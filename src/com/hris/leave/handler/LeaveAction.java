package com.hris.leave.handler;

import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.time.*;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.hris.leave.exception.*;
import com.hris.leave.form.LeaveForm;
import com.hris.leave.manager.EodManager;
import com.hris.leave.manager.LeaveManager;
import com.hris.leave.manager.SpecialDateManager;
import com.hris.leave.model.EmployeeBean;
import com.hris.leave.model.ExtraQuotaBean;
import com.hris.leave.model.LeaveBean;
import com.hris.leave.model.LeaveDetailBean;
import com.hris.leave.model.SpecialDateBean;
import com.hris.leave.util.LeaveUtil;
import com.google.gson.*;

public class LeaveAction extends Action {
	
	private LeaveManager objLeaveManager=new LeaveManager();
	private SpecialDateManager objSpecialDateManager=new SpecialDateManager();
	private EodManager objEodManager = new EodManager();
	HttpSession session =null;
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		LeaveForm objForm = (LeaveForm) form;
		
		session = request.getSession(false);
		//check session jika ada parameter yang diterima
		if (null!=request.getParameter("zx") && LeaveUtil.isBase64(request.getParameter("zx").replace(' ', '+'))) {
			//parameter diterima
			System.out.println("LEAVE Check session dari parameter.");
			String param = request.getParameter("zx").replace(' ', '+');
			String user[] = LeaveUtil.decrypt(param).split("##");
			
			// cek apakah memang data memiliki hak akses
			if (objLeaveManager.isAuthorized(user[0], user[1])) {
				//parameter yang akan dikirim
				System.out.println("LEAVE param dikirim: "+ param);
				request.setAttribute("zx", param);
				
				System.out.println("LEAVE Set session "+user[0]+".");
				session.setAttribute("username", user[0]);
				session.setAttribute("password", user[1]);
				session.setAttribute("roleId", user[2]);
				session.setAttribute("userId", user[3]);
				session.setAttribute("employeeId", user[4]);
				session.setAttribute("employeeName", user[5]);
			}
			else {
				// hancurkan session karena username dan password tidak pernah ada
				System.out.println("LEAVE "+session.getAttribute("username")+" tidak terautorisasi. Session dihancurkan.");
				if (null != session)
					session.invalidate();
				
				response.sendRedirect(objLeaveManager.getPortalUrl());
				return null;
			}
		}
		objForm.setUrlPortal(objLeaveManager.getPortalUrl());
		request.setAttribute("zx", "?zx="+LeaveUtil.createParameter(session));
		
		System.out.println("Task:"+objForm.getTask());
		
		//BUAT TESTING--------------------------------------------------
//		  session=request.getSession();
//		  session.setAttribute("username", "donny.setiawan"); 
//		  session.setAttribute("password", "donny"); 
//		  session.setAttribute("roleId", "3"); 
//		  session.setAttribute("userId", "22"); 
//		  session.setAttribute("employeeId", "4"); 
//		  session.setAttribute("employeeName", "Donny Setiawan");
		//--------------------------------------------------------------
		  
		objForm.setCurrentEmployee(objLeaveManager.getIndividualEmployeeData(session.getAttribute("employeeId").toString()));
		
		if(objForm.getTask()!=null){
			
			if ("leaveList".equalsIgnoreCase(objForm.getTask()))
			{	
				return goToLeaveList(mapping,objForm);
			}
			else if ("leaveInput".equalsIgnoreCase(objForm.getTask()))
			{
				return goToLeaveRequest(mapping,objForm);
			}
			else if("leaveextrainput".equalsIgnoreCase(objForm.getTask())){
				
				return goToExtraQuotaRequest(mapping,objForm);
			}
			else if("processLeaveRequest".equalsIgnoreCase(objForm.getTask())){
				
				return processLeaveRequest(mapping,objForm);
			}
			else if("processExtraQuotaRequest".equalsIgnoreCase(objForm.getTask())){
				
				System.out.println("masuk process extra quota");
				return processExtraQuotaRequest(mapping,objForm);
			}
			else if ("leaveListAllEmployees".equalsIgnoreCase(objForm.getTask()))
			{
				objForm.setEmployeeList(objLeaveManager.getAllEmployees(null,null));
				objForm.setDepartments(objLeaveManager.getAllDepartments());
				objForm.setCurrentSideBar("5a");
				
				return mapping.findForward("leaveListAllEmployees");
			}
			else if("eod".equalsIgnoreCase(objForm.getTask()))	
			{
				return goToEodPage(mapping,objForm);
			}
			else if("leaveapproval".equalsIgnoreCase(objForm.getTask()))
			{
				return goToLeaveApproval(mapping,objForm);
			} 
			else if("leaveextraapproval".equalsIgnoreCase(objForm.getTask())){
				
				return goToExtraQuotaApproval(mapping,objForm);
			}
			else if("leavecancellationapproval".equalsIgnoreCase(objForm.getTask())){
				
				return goToLeaveCancellationApproval(mapping,objForm);
			}
			else if("approveleave".equalsIgnoreCase(objForm.getTask())){
				
				System.out.println("masuk approve leave bro "+objForm.getSelectedLeaveId());
				LeaveBean leave=new LeaveBean();
				leave.setLeaveId(objForm.getSelectedLeaveId());
				leave.setApprovalComment(objForm.getApprovalComment());
				leave.setApprovalStatus(LeaveBean.APPROVAL_STATUS_ACCEPTED);
				objLeaveManager.updateLeaveApprovalStatus(leave);
				objForm.setInfo("Leave request successfully approved");
				
				return goToLeaveApproval(mapping,objForm);
			}
			else if("approveextraquota".equalsIgnoreCase(objForm.getTask())){
				
				return processExtraQuotaApproval(mapping,objForm,ExtraQuotaBean.EXTRA_QUOTA_STATUS_APPROVED);
			} 
			else if("approveleavecancellation".equalsIgnoreCase(objForm.getTask())){
				
				return processLeaveCancellation(mapping,objForm);
				
			} 
			else if("rejectleavecancellation".equalsIgnoreCase(objForm.getTask())){
				
				System.out.println("masuk proses reject leave cancellation");
				LeaveBean bean=objLeaveManager.getSingleIndividualLeave(objForm.getSelectedLeaveId());
				bean.setApprovalStatus(LeaveBean.APPROVAL_STATUS_CANCELLED);
				objLeaveManager.updateLeaveApprovalStatus(bean);
				
				return goToLeaveCancellationApproval(mapping,objForm);
			
			}
			else if("rejectextraquota".equalsIgnoreCase(objForm.getTask()))
			{
				return processExtraQuotaApproval(mapping,objForm,ExtraQuotaBean.EXTRA_QUOTA_STATUS_REJECTED);
			}
			else if("rejectleave".equalsIgnoreCase(objForm.getTask())){
			
				return processLeaveCancellation(mapping,objForm);
			}
			else if("cancelleave".equalsIgnoreCase(objForm.getTask())){
				
				return requestLeaveCancellation(mapping,objForm);
			}
			else if("asyncleavedetail".equalsIgnoreCase(objForm.getTask())){
				
				Gson gson=new Gson();
				List<LeaveDetailBean> objLeaveDetail= objLeaveManager.getLeaveDetail(objForm.getSelectedLeaveId());
				
				String jsonData= gson.toJson(objLeaveDetail);
				
				response.setContentType("application/json");
				response.setHeader("cache-control", "no-cache");
				System.out.println(jsonData);
				
				PrintWriter out = response.getWriter();
				out.write(jsonData);
				out.flush();
				
				return null;
			}
			else if("asyncleave".equalsIgnoreCase(objForm.getTask())){
				
				Gson gson=new Gson();
				LeaveBean objLeaveBean=null;
				
				String jsonData= gson.toJson(objLeaveBean);
				
				response.setContentType("application/json");
				response.setHeader("cache-control", "no-cache");
				System.out.println(jsonData);
				PrintWriter out = response.getWriter();
				out.write(jsonData);
				out.flush();
				
				return null;
			} 
			else if("asyncAllEmployees".equalsIgnoreCase(objForm.getTask())){
 				
				Gson gson=new Gson();
 				
 				System.out.println(objForm.getSelectedEmployee());
 				System.out.println(objForm.getSelectedDepartment());
 				objForm.setEmployeeList(objLeaveManager.getAllEmployees(objForm.getSelectedDepartment(),objForm.getSelectedEmployee()));
 				String jsonData= gson.toJson(objForm.getEmployeeList());
 				
 				response.setContentType("application/json");
 				response.setHeader("cache-control", "no-cache");
 				System.out.println(jsonData);
 				PrintWriter out = response.getWriter();
 				out.write(jsonData);
 				out.flush();
 				
 				return null;
 			}
			else if("asyncSingleEmployeeLeaveList".equalsIgnoreCase(objForm.getTask()))
			{
				Gson gson=new Gson();
				String defaultYear = null;
				objForm.setCategoryYear(objLeaveManager.getCategoryYear(objForm.getSelectedEmployee()));
				
				if(objForm.getCategoryYear().size() !=0)
					defaultYear = objForm.getCategoryYear().get(0);
				
				if(objForm.getSelectedYear().equals("default"))
					objForm.setEmployeeLeaveList(objLeaveManager.getAllIndividualLeave(objForm.getSelectedEmployee(), defaultYear));
				
				if(objForm.getSelectedYear() != null && !"default".equals(objForm.getSelectedYear()))
					objForm.setEmployeeLeaveList(objLeaveManager.getAllIndividualLeave(objForm.getSelectedEmployee(), objForm.getSelectedYear()));

				String jsonData= gson.toJson(objForm.getEmployeeLeaveList());
 				
				response.setContentType("application/json");
 				response.setHeader("cache-control", "no-cache");

 				System.out.println(jsonData);
 				PrintWriter out = response.getWriter();
 				out.write(jsonData);
 				out.flush();
 				
				return null;
			}
			else if ("asyncGetCategoryYear".equalsIgnoreCase(objForm.getTask()))
			{
				Gson gson=new Gson();
				String defaultYear = null;
				objForm.setCategoryYear(objLeaveManager.getCategoryYear(objForm.getSelectedEmployee()));
				
				if(objForm.getCategoryYear().size() != 0)
				{	
					defaultYear = objForm.getCategoryYear().get(0);
					objForm.setEmployeeLeaveList(objLeaveManager.getAllIndividualLeave(objForm.getSelectedEmployee(), defaultYear));
				}
				
				String jsonData= gson.toJson(objForm.getCategoryYear());
 				
				response.setContentType("application/json");
 				response.setHeader("cache-control", "no-cache");

 				System.out.println(jsonData);
 				PrintWriter out = response.getWriter();
 				out.write(jsonData);
 				out.flush();
				
				return null;
			}
			else if("doeod".equalsIgnoreCase(objForm.getTask()))
			{
				System.out.println("masuk do eod");

				try{
					objLeaveManager.doEodProcess(session.getAttribute("username").toString());
					objForm.setInfo("Success!");
				}catch(SQLException ex){
					ex.printStackTrace();
				}
				return goToEodPage(mapping,objForm);
			}
			else if ("logout".equalsIgnoreCase(objForm.getTask()))
			{
				session = request.getSession(false);
				objLeaveManager.updateStatusLogin(session.getAttribute("username").toString(), 0);
				System.out.println("PORTAL "+session.getAttribute("username")+" logout.");
				
				if(session != null)
		    		session.invalidate();
				
				System.out.println("LEAVE menuju PORTAL");
				response.sendRedirect(objLeaveManager.getPortalUrl());
				return null;
			}
	
		} 
		
		return goToLeaveRequest(mapping,objForm);
//		request.setAttribute("lala","lalala");
//		String currentMassLeaveYear = objSpecialDateManager.getCurrentYear(SpecialDateBean.MASS_LEAVE_TYPE);
//		String currentNationalHolidayYear = objSpecialDateManager.getCurrentYear(SpecialDateBean.NATIONAL_HOLIDAY_TYPE);
//		objForm.setUpcomingMassleave(objSpecialDateManager.getSpecialDate(SpecialDateBean.MASS_LEAVE_TYPE, SpecialDateBean.UPCOMING, currentMassLeaveYear,"TRUE"));
//		objForm.setUpcomingNationalHoliday(objSpecialDateManager.getSpecialDate(SpecialDateBean.NATIONAL_HOLIDAY_TYPE, SpecialDateBean.UPCOMING,currentNationalHolidayYear,"TRUE"));
//		return mapping.findForward("menu");
//	
	}
	
	private ActionForward goToEodPage(ActionMapping mapping, LeaveForm objForm) {
		
		objForm.setEodBean(objEodManager.getLastEod());
		objForm.setCurrentSideBar("5d");
		
		return mapping.findForward("eod");
	}

	private ActionForward goToLeaveCancellationApproval(ActionMapping mapping,
			LeaveForm form) {
		
		form.setEmployeeLeaveList(objLeaveManager.getApprovalRequest(form.getCurrentEmployee().getEmployeeId(), "PendingCancel"));
		return mapping.findForward("leaveCancellationApproval");
	}

	private ActionForward requestLeaveCancellation(ActionMapping mapping,
			LeaveForm form) {
		 
		LeaveBean leave= objLeaveManager.getSingleIndividualLeave(form.getSelectedLeaveId());
		System.out.println("approvalStatus:"+leave.getApprovalStatus());
		
		if(leave.getApprovalStatus().equals(LeaveBean.APPROVAL_STATUS_PENDING_REQUEST)){
		//kalo status=pending, lsg process leave cancellation
			processLeaveCancellation(mapping,form);
			form.setInfo("Leave request successfully cancelled");
			System.out.println("masuk sini");
		}
		else{
		//kalo status!=pending, ubah status approval jd [pending cancel]
			System.out.println("Update "+leave.getLeaveId()+" jadi pending cancel");
			leave.setApprovalStatus(LeaveBean.APPROVAL_STATUS_PENDING_CANCEL);
			form.setInfo("Leave cancellation request succesfully submitted. Please wait for approval");
			objLeaveManager.updateLeaveApprovalStatus(leave);
		}
		
		return goToLeaveList(mapping, form);
	}

	private ActionForward processExtraQuotaApproval(ActionMapping mapping,
			LeaveForm form, String approvalStatus) {
		 
		
		System.out.println("lalala");
		ExtraQuotaBean bean=new ExtraQuotaBean();
		bean.setExtraLeaveQuotaId(form.getApprovedExtraQuotaId());
		bean.setStatus(approvalStatus);
		bean.setApprovalComment(form.getApprovalComment());
		
		objLeaveManager.updateExtraQuotaApprovalStatus(bean);
		
		return goToExtraQuotaApproval(mapping,form);
	}

	private ActionForward goToExtraQuotaApproval(ActionMapping mapping,
			LeaveForm objForm) {
		 
		System.out.println("masuk halaman extra quota approval");
		
		if(session!=null && session.getAttribute("roleId").toString().equals("1"))
			objForm.setExtraQuotaList(objLeaveManager.getExtraQuotaApprovalRequest(""));
		else
			objForm.setExtraQuotaList(objLeaveManager.getExtraQuotaApprovalRequest(objForm.getCurrentEmployee().getEmployeeId()));
		return mapping.findForward("leaveExtraApproval");
	}

	private ActionForward goToExtraQuotaRequest(ActionMapping mapping,
			LeaveForm objForm) {
		 
		objForm.setLeaveApprover(objLeaveManager.getLeaveApprover(objForm.getCurrentEmployee().getEmployeeId()));
		objForm.setDescription("");
		objForm.setSubstitutedDate("");
		objForm.setSelectedLeaveApprover("");
		
		return mapping.findForward("leaveExtraInput");
	}

	private ActionForward processExtraQuotaRequest(ActionMapping mapping,
			LeaveForm objForm) {
		 
		String employeeId=objForm.getCurrentEmployee().getEmployeeId();
		
		if(objLeaveManager.cekExistingSubstitutedDate(employeeId, objForm.getSubstitutedDate()))
			objForm.setError("Substituted date already exists");
		else if(!checkSubstitutedDateValidity(objForm.getSubstitutedDate()))
			objForm.setError("Substituted date must not be smaller than 14 days before request date");
		else{
			ExtraQuotaBean bean=new ExtraQuotaBean();
			bean.setEmployeeId(objForm.getCurrentEmployee().getEmployeeId());
			bean.setSubstitutedDate(objForm.getSubstitutedDate());
			System.out.println("sub:"+bean.getSubstitutedDate());
			bean.setDescription(objForm.getDescription());
			bean.setApprovedBy(objForm.getSelectedLeaveApprover());
			bean.setApprovalDate("");
			bean.setApprovalComment("");
			bean.setStatus(ExtraQuotaBean.EXTRA_QUOTA_STATUS_PENDING);
			
			objLeaveManager.insertNewExtraQuota(bean);
			
			objForm.setInfo("Extra quota request successfully submitted. Please wait for approval");
		}
		
		objForm.setSubstitutedDate("");
		objForm.setDescription("");
		return goToExtraQuotaRequest(mapping,objForm);
	}

	private ActionForward processLeaveCancellation(ActionMapping mapping,
			LeaveForm form) {
		 
			
			System.out.println("detail process reject leave");
			System.out.println("id leave yg mau direject:"+form.getSelectedLeaveId());
			String leaveId=form.getSelectedLeaveId();

			EmployeeBean emp=null;
			
			LeaveBean leave=objLeaveManager.getSingleIndividualLeave(leaveId);
			emp=objLeaveManager.getIndividualEmployeeData(leave.getEmployeeId());
			
			if(form.getTask().equalsIgnoreCase("cancelleave")){
				System.out.println("approval date jd nodate");
				leave.setApprovalComment(emp.getEmployeeName()+" cancelled this request before this request has been approved");
				leave.setApprovalDate("nodate");
			}
			else if(form.getApprovalComment()!=null)
				leave.setApprovalComment(form.getApprovalComment());
			
			if(form.getTask().equals("rejectleave"))
				leave.setApprovalStatus(LeaveBean.APPROVAL_STATUS_REJECTED);
			else
				leave.setApprovalStatus(LeaveBean.APPROVAL_STATUS_CANCELLED);
			
			String leaveType=leave.getLeaveType();
			System.out.println("leave type:"+leaveType);
			
			System.out.println("employee yg mau direject:"+emp.getEmployeeName());
			
			try{
				if(leaveType.equals(LeaveBean.YEARLY_LEAVE_TYPE)||leaveType.equalsIgnoreCase("cuti tahunan"))
					processYearlyLeaveCancellation(leave,emp);
				else if(leaveType.equals(LeaveBean.REWARD_LEAVE_TYPE)||leaveType.equalsIgnoreCase("cuti reward"))
					processRewardLeaveCancellation(leave,emp);
				else if(leaveType.equals(LeaveBean.MISC_LEAVE_TYPE)||leaveType.equalsIgnoreCase("cuti meninggalkan pekerjaan"))
					processMiscLeaveCancellation(leave,emp);
				else if(leaveType.equals(LeaveBean.EXTRA_LEAVE_TYPE) || leaveType.equalsIgnoreCase("cuti extra"))
					processExtraLeaveCancellation(leave,emp);
				
			}catch(ParseException ex){
				ex.printStackTrace();
			}
			
			if(form.getTask().equalsIgnoreCase("approveleavecancellation")){
				form.setInfo("Leave cancellation request successfully approveed");
				return goToLeaveCancellationApproval(mapping,form);
			}
			else{
				form.setInfo("Leave request successfully rejected");
				return goToLeaveApproval(mapping, form);
			}
				
	}
	
	private ActionForward goToLeaveApproval(ActionMapping mapping,
			LeaveForm form) {
		 
		form.setCurrentSideBar("4");
		
		//kasih kondisi super admin=load semua yg pending
		if(session!=null && session.getAttribute("roleId").toString().equals("1"))
			form.setEmployeeLeaveList(objLeaveManager.getApprovalRequest("", LeaveBean.PENDING));
		else
			form.setEmployeeLeaveList(objLeaveManager.getApprovalRequest(form.getCurrentEmployee().getEmployeeId(), LeaveBean.PENDING));
		
		form.setEmployeeHistoryLeaveList(objLeaveManager.getApprovalRequest(form.getCurrentEmployee().getEmployeeId(),LeaveBean.HISTORY));
		return mapping.findForward("leaveApproval");
	}

	private ActionForward goToLeaveRequest(ActionMapping mapping,
			LeaveForm objForm) {
		 
		
		objForm.setLeaveType(objLeaveManager.getLeaveType());
		objForm.setLeaveApprover(objLeaveManager.getLeaveApprover(objForm.getCurrentEmployee().getEmployeeId()));
		objForm.setExtraQuotaList(objLeaveManager.getIndividualExtraQuota(objForm.getCurrentEmployee().getEmployeeId()));
	
		//cek kalo udh ga punya kuota, gausah munculin pilihan cutinya
		if(objForm.getCurrentEmployee().getRewardQuota().equals("0")){
			Map<String, String> map=new HashMap<String, String>();
			map.put("LEAVETYPEID", LeaveBean.REWARD_LEAVE_TYPE);
			map.put("LEAVETYPE", "Cuti Reward");
			objForm.getLeaveType().remove(map);
		}
		
		if(objForm.getCurrentEmployee().getCurrentLeaveQuota().equals("0") && objForm.getCurrentEmployee().getLastQuota().equals("0"))
		{
			Map<String, String> map=new HashMap<String, String>();
			map.put("LEAVETYPEID", LeaveBean.YEARLY_LEAVE_TYPE);
			map.put("LEAVETYPE", "Cuti Tahunan");
			objForm.getLeaveType().remove(map);
		}
		
		if(objForm.getExtraQuotaList().size()==0){
			Map<String, String> map=new HashMap<String, String>();
			map.put("LEAVETYPEID", LeaveBean.EXTRA_LEAVE_TYPE);
			map.put("LEAVETYPE", "Cuti Extra");
			objForm.getLeaveType().remove(map);
		}
		
		objForm.setSubstitutedDate("");
		objForm.setDescription("");
		objForm.setSelectedLeaveType("");
		objForm.setCurrentSideBar("1");
		
		return mapping.findForward("leaveInput");
	}

	private ActionForward goToLeaveList(ActionMapping mapping, LeaveForm form){
		System.out.println("Masuk leave list");
		form.setEmployeeLeaveList(objLeaveManager.getCurrentLeave(form.getCurrentEmployee().getEmployeeId()));
		form.setEmployeeHistoryLeaveList(objLeaveManager.getLeaveHistory(form.getCurrentEmployee().getEmployeeId()));
		form.setCurrentSideBar("2");
		return mapping.findForward("leaveList");
	}
	
	private ActionForward processLeaveRequest(ActionMapping mapping,
			LeaveForm form) {
		 
		String leaveType=form.getSelectedLeaveType();
		
		String startDate=form.getStartLeaveDate();
		String lastDate=
				form.getLastLeaveDate()==null||form.getLastLeaveDate().equals("")?
						form.getStartLeaveDate():form.getLastLeaveDate();
						
		System.out.println("tipe cuti:"+form.getSelectedLeaveType());
		System.out.println("startdate extra leave:"+startDate);
		System.out.println("lastdate extra leave:"+lastDate);

			try {
				CheckDate(startDate,lastDate,form.getCurrentEmployee(),leaveType);
				List<LeaveDetailBean> leaveList = getValidLeaveList(startDate,lastDate,form.getCurrentEmployee());
				
				if(leaveType.equals(LeaveBean.YEARLY_LEAVE_TYPE))
					processYearlyLeave(leaveList,form);
				else if(leaveType.equals(LeaveBean.REWARD_LEAVE_TYPE))
					processRewardLeave(leaveList,form);
				else if(leaveType.equals(LeaveBean.EXTRA_LEAVE_TYPE))
					processExtraLeave(leaveList,form);
				else if(leaveType.equals(LeaveBean.MISC_LEAVE_TYPE))
					processMiscLeave(leaveList,form);
				
				form.setInfo("Leave request successfully submitted. Please wait for approval.");
				form.setStartLeaveDate("");
				form.setLastLeaveDate("");
				form.setDescription("");
				form.setSelectedLeaveType("");
				
			} catch (ParseException e) {
				
				e.printStackTrace();
				form.setError("Invalid date");
				
			} catch (LeaveException e) {
				
				e.printStackTrace();
				System.out.println("error:"+e.getMessage());
				form.setError(e.getMessage());
			
			} catch (SQLException e) {
				 
				form.setError("Failed to submit request due to database issue");
				e.printStackTrace();
				
			} catch(Exception e){
				
				form.setError("Unknown error. failed to submit your request");
				e.printStackTrace();
			}
		
		System.out.println("msg:"+form.getError());
		
		//JGN LUPA GANTI
		//refresh employee data
		form.setCurrentEmployee(objLeaveManager.getIndividualEmployeeData(form.getCurrentEmployee().getEmployeeId()));
		return goToLeaveRequest(mapping,form);
		//return goToLeaveList(mapping,form);
		
	}
	
	private void processExtraLeaveCancellation(LeaveBean leave, EmployeeBean emp) {
		 
		
		System.out.println(leave.getExtraQuotaId());
		//update approval status jd rejected/canceled
		objLeaveManager.updateLeaveApprovalStatus(leave);
		
		//update status quota jd APPROVED lg
		objLeaveManager.updateExtraQuotaUsageStatus(leave.getExtraQuotaId(), ExtraQuotaBean.EXTRA_QUOTA_STATUS_APPROVED);
	}

	private void processMiscLeaveCancellation(LeaveBean leave, EmployeeBean emp) {
		 
		objLeaveManager.updateLeaveApprovalStatus(leave);
	}

	private void processRewardLeave(List<LeaveDetailBean> leaveList,
			LeaveForm form) throws ParseException, LeaveException, SQLException {
		 
		
		System.out.println("masuk process reward leave");
		Integer rewardQuota= Integer.parseInt(form.getCurrentEmployee().getRewardQuota());
		SimpleDateFormat formatter=new SimpleDateFormat("dd/MM/yyyy");
		SimpleDateFormat monFormatter= new SimpleDateFormat("dd MMM yyyy",Locale.ENGLISH);

		if(leaveList.size()>rewardQuota){
			form.setError("Your reward quota is not sufficient");
		}
		else{
			
			String rewardQuotaExpiryDate= form.getCurrentEmployee().getRewardQuotaExpiredDate();
			String leaveExpiryDate=addMonthsToDate(leaveList.get(leaveList.size()-1).getLeaveDate(),formatter,6);
			
			for(LeaveDetailBean bean:leaveList){
				
				String currentLeaveDate=bean.getLeaveDate();
				
				/*
				 * Cek apa ada cuti yg melebihi tanggal expiry kuota reward
				 * if true, throw LeaveExpiredException
				 */
				if(formatter.parse(currentLeaveDate).after(monFormatter.parse(rewardQuotaExpiryDate)))
					throw new LeaveException(currentLeaveDate);
				
				/* Decrement kuota reward */
				rewardQuota--;
			}
			
			LeaveBean leave= new LeaveBean();
			leave.setDescription(form.getDescription());
			leave.setEmployeeId(form.getCurrentEmployee().getEmployeeId());
			leave.setLeaveType(LeaveBean.REWARD_LEAVE_TYPE);
			leave.setExpiredDate(leaveExpiryDate);
			leave.setApprovedBy(form.getSelectedLeaveApprover());
			leave.setApprovalStatus(LeaveBean.APPROVAL_STATUS_PENDING_REQUEST);
			
			objLeaveManager.insertNewLeave(leave, leaveList);
			objLeaveManager.updateRewardLeaveQuota(form.getCurrentEmployee().getEmployeeId(), rewardQuota.toString());
		}
		
	}

	private void processYearlyLeave(List<LeaveDetailBean> leaveList,
			LeaveForm form) throws ParseException, LeaveException, SQLException {
		 
		SimpleDateFormat digitMonth=new SimpleDateFormat("dd/MM/yyyy");
		SimpleDateFormat nameMonth=new SimpleDateFormat("dd MMM yyyy",Locale.ENGLISH);
		
		Integer currentQuota=Integer.parseInt(form.getCurrentEmployee().getCurrentLeaveQuota());
		Integer lastQuota=Integer.parseInt(form.getCurrentEmployee().getLastQuota());
		Date expired=nameMonth.parse(form.getCurrentEmployee().getCurrentQuotaExpiredDate());
		
		System.out.println("lastQuotaBefore:"+lastQuota);
		System.out.println("currentQuotaBefore:"+currentQuota);
		
		if(leaveList.size()>currentQuota+lastQuota){
			throw new LeaveException("Your yearly quota is not sufficient");
		}else{
				
			String quotaExpiryDate=form.getCurrentEmployee().getLastQuotaExpiredDate();
			String leaveExpiryDate=addMonthsToDate(leaveList.get(leaveList.size()-1).getLeaveDate(),digitMonth,6);
			System.out.println("expiry date:"+ leaveExpiryDate);
			
			for(LeaveDetailBean bean:leaveList){
				
				String currentDate=bean.getLeaveDate();
				System.out.println("currdate="+currentDate);
				if(lastQuota!=0){
					if(digitMonth.parse(currentDate).before(nameMonth.parse(quotaExpiryDate))){
						lastQuota--;
					}else{
						currentQuota--;
					}
				}else{
					currentQuota--;
				}
			}
			
			LeaveBean leave=new LeaveBean();
			leave.setDescription(form.getDescription());
			leave.setEmployeeId(form.getCurrentEmployee().getEmployeeId());
			leave.setLeaveType(LeaveBean.YEARLY_LEAVE_TYPE);
			leave.setExpiredDate(leaveExpiryDate);
			leave.setApprovedBy(form.getSelectedLeaveApprover());
			leave.setApprovalStatus(LeaveBean.APPROVAL_STATUS_PENDING_REQUEST);
			
			//evaluasi lg prosesnya-> gara2 skenario kalo insert gagal query update quota masih jalan
			objLeaveManager.insertNewLeave(leave, leaveList);
			objLeaveManager.updateYearlyLeaveQuota(form.getCurrentEmployee().getEmployeeId(), lastQuota.toString(),currentQuota.toString());
		}	
		
		System.out.println("currentQuotaAfter:"+currentQuota);
		System.out.println("lastQuotaAfter:"+lastQuota);
		
	}

	private void processMiscLeave(List<LeaveDetailBean> leaveList, LeaveForm form) throws ParseException, SQLException{
		
		SimpleDateFormat formatter=new SimpleDateFormat("dd/MM/yyyy");
		
		//monformatter= buat format quota expiry date karena pake formatnya beda
		SimpleDateFormat monFormatter=new SimpleDateFormat("dd MMM yyyy",Locale.ENGLISH);
	
		//String quotaExpiryDate=form.getCurrentEmployee().getLastQuotaExpiredDate();
		String leaveExpiryDate=addMonthsToDate(leaveList.get(leaveList.size()-1).getLeaveDate(),formatter,6);
		System.out.println("expiry date:"+ leaveExpiryDate);
			
		LeaveBean leave=new LeaveBean();
		leave.setDescription(form.getDescription());
		leave.setEmployeeId(form.getCurrentEmployee().getEmployeeId());
		leave.setLeaveType(LeaveBean.MISC_LEAVE_TYPE);
		leave.setExpiredDate(leaveExpiryDate);
		leave.setApprovedBy(form.getSelectedLeaveApprover());
		leave.setApprovalStatus(LeaveBean.APPROVAL_STATUS_PENDING_REQUEST);
		
		//evaluasi lg prosesnya-> gara2 skenario kalo insert gagal query update quota masih jalan
		objLeaveManager.insertNewLeave(leave, leaveList);
		
	}
	
	private void processExtraLeave(List<LeaveDetailBean> leaveList, LeaveForm form) throws LeaveException, SQLException{
		
		System.out.println("masuk process extra leave");
		String leaveDate= leaveList.get(0).getLeaveDate();
		String employeeId= form.getCurrentEmployee().getEmployeeId();
		
		ExtraQuotaBean extraQuotaToBeUsed = objLeaveManager.getExtraQuotaToUse(employeeId, leaveDate);
		
		if(extraQuotaToBeUsed == null)
			throw new LeaveException("Requested leave date is past extra quota expired date");
		else{
			LeaveBean leave= new LeaveBean();
			leave.setDescription(form.getDescription());
			leave.setEmployeeId(employeeId);
			leave.setLeaveType(LeaveBean.EXTRA_LEAVE_TYPE);
			leave.setExpiredDate(extraQuotaToBeUsed.getExpiredDate());
			leave.setApprovedBy(form.getSelectedLeaveApprover());
			leave.setApprovalStatus(LeaveBean.APPROVAL_STATUS_PENDING_REQUEST);
			leave.setExtraQuotaId(extraQuotaToBeUsed.getExtraLeaveQuotaId());
			
			System.out.println("mau add extra leave");
			objLeaveManager.insertNewLeave(leave, leaveList);
			objLeaveManager.updateExtraQuotaUsageStatus(extraQuotaToBeUsed.getExtraLeaveQuotaId(), ExtraQuotaBean.EXTRA_QUOTA_STATUS_USED);
		}		
	}
	
	private void processRewardLeaveCancellation(LeaveBean leave, EmployeeBean emp) throws ParseException {
		 
		SimpleDateFormat formatter=new SimpleDateFormat("dd MMM yyyy",Locale.ENGLISH);
		
		Integer rewardQuota=Integer.parseInt(emp.getRewardQuota());
		
		Date lastRenewalDate=formatter.parse(addMonthsToDate(emp.getRenewalDate(),formatter,-12));
		
		List<LeaveDetailBean> leaveDetail=objLeaveManager.getLeaveDetail(leave.getLeaveId());
		
		for(LeaveDetailBean bean:leaveDetail){
			Date currentLeaveDate=formatter.parse(bean.getLeaveDate());
			if(!currentLeaveDate.before(lastRenewalDate))
				rewardQuota++;
		}
		
		objLeaveManager.updateLeaveApprovalStatus(leave);
		objLeaveManager.updateRewardLeaveQuota(emp.getEmployeeId(), rewardQuota.toString());
		
	}

	private void processYearlyLeaveCancellation(LeaveBean leave, EmployeeBean emp ) throws ParseException{
			
		SimpleDateFormat formatter= new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH);
		
		Integer lastQuota=Integer.parseInt(emp.getLastQuota());
		Integer currentQuota=Integer.parseInt(emp.getCurrentLeaveQuota());
		
		/*potensi null pointer di baris berikut apabila lastquotaexpireddate masih kosong*/
		Date lastQuotaExpiredDate= formatter.parse(emp.getLastQuotaExpiredDate());
		
		Date currentQuotaExpiredDate=formatter.parse(emp.getCurrentQuotaExpiredDate());
		Date lastRenewalDate=formatter.parse(addMonthsToDate(emp.getRenewalDate(),formatter,-12));
		
		System.out.println("lastQuotaBefore:"+lastQuota);
		System.out.println("currentQuotaBefore:"+currentQuota);
		
		List<LeaveDetailBean> leaveDetail=objLeaveManager.getLeaveDetail(leave.getLeaveId());
		
		for(LeaveDetailBean bean : leaveDetail){
			System.out.println("tanggal yg mau dicancel:"+bean.getLeaveDate());
			Date currentLeaveDate=formatter.parse(bean.getLeaveDate());
			
			if(currentLeaveDate.before(lastRenewalDate)||currentLeaveDate.equals(lastRenewalDate))
				lastQuota++;
			else if(currentLeaveDate.before(lastQuotaExpiredDate))
				if(currentQuota + objLeaveManager.getUsedCurrentQuota(emp.getEmployeeId())==12)
					lastQuota++;
				else 
					currentQuota++;
			
			else if((currentLeaveDate.after(lastQuotaExpiredDate)  || currentLeaveDate.equals(lastQuotaExpiredDate)) && currentQuota<12)
					currentQuota++;
				
		}
		
		
		System.out.println("currentQuotaAfter:"+currentQuota);
		System.out.println("lastQuotaAfter:"+lastQuota);
		System.out.println("appprovalStatus:"+leave.getApprovalStatus());
		System.out.println("comment:"+leave.getApprovalComment());
		objLeaveManager.updateLeaveApprovalStatus(leave);
		objLeaveManager.updateYearlyLeaveQuota(emp.getEmployeeId(), lastQuota.toString(), currentQuota.toString());
	}
		
	private List<LeaveDetailBean> getValidLeaveList(String startDate,
			String endDate, EmployeeBean employee) throws ParseException, LeaveException {
		 
		String employeeId=employee.getEmployeeId();
		
		List<LeaveDetailBean> leaveListRequest= new ArrayList<LeaveDetailBean>();
		List<String> specialDate= objSpecialDateManager.getSpecialDateByPeriod(startDate, endDate);
		List<String> leaveList = objLeaveManager.getEmployeeLeaveDateByInterval(employeeId, startDate, endDate);
		
		SimpleDateFormat formatter=new SimpleDateFormat("dd/MM/yyyy");
		
		Calendar calendar=Calendar.getInstance();
		Date start=formatter.parse(startDate);
		Date end=formatter.parse(endDate);
	
		calendar.setTime(start);
		
		while(!calendar.getTime().after(end)){
			
			System.out.println(calendar.getTime());
			
			int day=calendar.get(Calendar.DAY_OF_WEEK);
			String currDate= formatter.format(calendar.getTime());
			
			/*
			 * Cek apakah ada tanggal cuti yang direquest overlap dengan cuti yang existing,
			 * if true, throw LeaveOverlapException
			 */
			if(leaveList!=null && leaveList.contains(currDate))
				throw new LeaveException("Requested leave date overlapped with existing leave date");
			
			if(day!=1 && day != 7 && !specialDate.contains(currDate))
			{
				if(!(calendar.getTime().before(new Date()) && objLeaveManager.cekAttendance(employeeId, currDate))){
					LeaveDetailBean bean=new LeaveDetailBean();
					bean.setLeaveDate(currDate);
					leaveListRequest.add(bean);
				}else{
					throw new LeaveException("You have attendance record on requested date");
				}
			} 
	
			calendar.add(Calendar.DAY_OF_MONTH, 1);
		}
		
		//CEK LAGI YA
		if(leaveListRequest.size()==0)
			throw new LeaveException("Requested leave date is a day off");
		
		for(LeaveDetailBean a: leaveListRequest){
			System.out.println("leave date:"+a.getLeaveDate());
		}
		
		return leaveListRequest;
	}
	
	private void CheckDate(String startDate, String lastDate,
			EmployeeBean employee, String leaveType) throws LeaveException, ParseException {
		
		SimpleDateFormat digitMonth=new SimpleDateFormat("dd/MM/yyyy");
		SimpleDateFormat nameMonth=new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH);
		Date start= digitMonth.parse(startDate);
		Date end= digitMonth.parse(lastDate);
		Date expired=nameMonth.parse(employee.getCurrentQuotaExpiredDate());
		
		System.out.println("currentLeaveExpiryDate:"+employee.getCurrentQuotaExpiredDate());
		
		if(end.before(start))
			throw new LeaveException("Invalid date range");
		if(leaveType.equals(LeaveBean.YEARLY_LEAVE_TYPE))
			if(start.after(expired)||end.after(expired))
				throw new LeaveException("Leave date is beyond your yearly quota expiry date ("+employee.getCurrentQuotaExpiredDate()+")");
	
	}
	
	private boolean checkSubstitutedDateValidity(String date){
		
		//rencana ganti semua date & calendar dari java.util ke java.time
		DateTimeFormatter formatter=DateTimeFormatter.ofPattern("dd/MM/yyyy");
		LocalDate now=LocalDate.now();
		
		LocalDate subsDate=LocalDate.parse(date, formatter);
		
		return subsDate.isBefore(now.minusDays(14))?false:true;

	}
	
	private String addMonthsToDate(String date, DateFormat formatter, Integer months) throws ParseException{
		
		Calendar calendar=Calendar.getInstance();
		calendar.setTime(formatter.parse(date));
		calendar.add(Calendar.MONTH, months);
		
		return formatter.format(calendar.getTime());
	}
}
