package com.hris.leave.handler;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.google.gson.Gson;
import com.hris.leave.form.LeaveForm;
import com.hris.leave.form.SpecialDateForm;
import com.hris.leave.manager.EodManager;
import com.hris.leave.manager.LeaveManager;
import com.hris.leave.manager.SpecialDateManager;
import com.hris.leave.model.LeaveDetailBean;
import com.hris.leave.model.SpecialDateBean;

public class SpecialDateAction extends DispatchAction {
	
	SpecialDateManager objManager=new SpecialDateManager();
	HttpSession session = null;
	public ActionForward showMassLeaveList(ActionMapping mapping,ActionForm form,
			HttpServletRequest request,HttpServletResponse response){
		SpecialDateForm objForm = (SpecialDateForm) form;
		return doSetList(mapping, objForm, SpecialDateBean.MASS_LEAVE_TYPE);
	}
	
	public ActionForward showNationalHolidayList(ActionMapping mapping,ActionForm form,
			HttpServletRequest request,HttpServletResponse response){
		SpecialDateForm objForm = (SpecialDateForm) form;
		return doSetList(mapping, objForm, SpecialDateBean.NATIONAL_HOLIDAY_TYPE);
	}
	
	public ActionForward saveAddNationalHoliday(ActionMapping mapping,ActionForm form,
			HttpServletRequest request,HttpServletResponse response){
		
		System.out.println("masuk save add new holiday");
		SpecialDateForm objForm= (SpecialDateForm) form;
		session = request.getSession();
		doCheck(objForm,objManager,"add");
		
		objForm.getCurrentSpecialDateBean().setType(SpecialDateBean.NATIONAL_HOLIDAY_TYPE);
		objForm.getCurrentSpecialDateBean().setCreateUser(session.getAttribute("userId").toString());	
		
		objManager.insertSpecialDate(objForm.getCurrentSpecialDateBean());
		return doSetList(mapping, objForm, SpecialDateBean.NATIONAL_HOLIDAY_TYPE);
	}
	

	public ActionForward saveAddMassLeave(ActionMapping mapping,ActionForm form,
			HttpServletRequest request,HttpServletResponse response){
		
		System.out.println("masuk save add mass leave");
		SpecialDateForm objForm= (SpecialDateForm) form;
		session = request.getSession();
		doCheck(objForm,objManager,"add");
		
		objForm.getCurrentSpecialDateBean().setType(SpecialDateBean.MASS_LEAVE_TYPE);
		objForm.getCurrentSpecialDateBean().setCreateUser(session.getAttribute("userId").toString());
		
		objManager.insertSpecialDate(objForm.getCurrentSpecialDateBean());
		
		return doSetList(mapping, objForm, SpecialDateBean.MASS_LEAVE_TYPE);		
	}
	public ActionForward editNationalHoliday(ActionMapping mapping,ActionForm form,
			HttpServletRequest request,HttpServletResponse response){
		
		SpecialDateForm objForm = (SpecialDateForm) form;
		System.out.println(objForm.getSpecialDateId());
		session = request.getSession();
		doCheck(objForm,objManager,"edit");
		
		objForm.getCurrentSpecialDateBean().setId(objForm.getSpecialDateId());
		objForm.getCurrentSpecialDateBean().setCreateUser(session.getAttribute("userId").toString());
		objManager.updateSpecialDate(objForm.getCurrentSpecialDateBean());
		return doSetList(mapping, objForm, SpecialDateBean.NATIONAL_HOLIDAY_TYPE);
	}
	
	public ActionForward editMassLeave(ActionMapping mapping,ActionForm form,
			HttpServletRequest request,HttpServletResponse response){
		
		SpecialDateForm objForm = (SpecialDateForm) form;
		System.out.println(objForm.getSpecialDateId());
		session = request.getSession();
		doCheck(objForm,objManager, "edit");
		
		objForm.getCurrentSpecialDateBean().setId(objForm.getSpecialDateId());
		objForm.getCurrentSpecialDateBean().setCreateUser(session.getAttribute("userId").toString());
		objManager.updateSpecialDate(objForm.getCurrentSpecialDateBean());
		
		return doSetList(mapping, objForm, SpecialDateBean.MASS_LEAVE_TYPE);
	}
	
	public ActionForward deleteMassLeave(ActionMapping mapping,ActionForm form,
			HttpServletRequest request,HttpServletResponse response ){
		
		SpecialDateForm objForm = (SpecialDateForm) form;
		
		objManager.deleteSpecialDate(objForm.getSpecialDateId());
		return doSetList(mapping, objForm, SpecialDateBean.MASS_LEAVE_TYPE);
	}
	
	public ActionForward deleteNationalHoliday(ActionMapping mapping,ActionForm form,
			HttpServletRequest request,HttpServletResponse response ){

		SpecialDateForm objForm = (SpecialDateForm) form;
		
		objManager.deleteSpecialDate(objForm.getSpecialDateId());
		return doSetList(mapping, objForm, SpecialDateBean.NATIONAL_HOLIDAY_TYPE);		
	}
	
	public ActionForward getAsyncSpecialDate(ActionMapping mapping,ActionForm form,
			HttpServletRequest request,HttpServletResponse response ){
		
		SpecialDateForm objForm = (SpecialDateForm) form;
		
		Gson gson=new Gson();
		
		String categoryYear = objForm.getSelectedYear();
		String specialDateType = objForm.getSpecialDateId();
		System.out.println("Selected Year: "+categoryYear+"& Special Date Type: "+specialDateType);
		objForm.setHistorySpecialDateList(objManager.getSpecialDate(specialDateType,SpecialDateBean.HISTORY,categoryYear,null));
				
		String jsonData= gson.toJson(objForm.getHistorySpecialDateList());
		
		response.setContentType("application/json");
		response.setHeader("cache-control", "no-cache");
		System.out.println(jsonData);
		
		PrintWriter out;
		try {
			out = response.getWriter();
			out.write(jsonData);
			out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	

	private ActionForward doSetList(ActionMapping mapping,  SpecialDateForm objForm, String specialDateType) {
		// TODO Auto-generated method stub
		if(objForm.getSelectedYear() == null)
		objForm.setSelectedYear(objManager.getDefaultCategoryYear(specialDateType, SpecialDateBean.HISTORY));
		
		String categoryYear = objForm.getSelectedYear();
		
		objForm.setCategoryYearList(objManager.getCategoryYear(specialDateType, SpecialDateBean.HISTORY));
		objForm.setSpecialDateList(objManager.getSpecialDate(specialDateType, SpecialDateBean.UPCOMING,null,null));
		objForm.setHistorySpecialDateList(objManager.getSpecialDate(specialDateType,SpecialDateBean.HISTORY,categoryYear,null));
		
		if(objForm.getSelectedYear() != null)
			System.out.println(objForm.getSelectedYear().toString());
		
		if(specialDateType == SpecialDateBean.MASS_LEAVE_TYPE)
			{
				objForm.setCurrentSideBar("5b");
				return mapping.findForward("mleavelist");
			}
		else if(specialDateType == SpecialDateBean.NATIONAL_HOLIDAY_TYPE)
			{
				objForm.setCurrentSideBar("5c");
				return mapping.findForward("nholidaylist");
			}
		else
			return null;
	}
	
	private void doCheck(SpecialDateForm objForm, SpecialDateManager objManager, String flag) {
		// TODO Auto-generated method stub
		String date = objForm.getCurrentSpecialDateBean().getDate();
		String id= objForm.getSpecialDateId();
		System.out.println("selected id:"+id);
		System.out.println(date);
		String parseDate = null;
		SimpleDateFormat newFormat = new SimpleDateFormat("dd/MM/yyyy",Locale.ENGLISH);
		SimpleDateFormat displayFormat = new SimpleDateFormat("dd MMM yyyy",Locale.ENGLISH);
		
		try {
			parseDate = displayFormat.format(newFormat.parse(date));
			
			System.out.println("sukses");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			parseDate = date;
			System.out.println("gagal");
		}
		
		SpecialDateBean result = objManager.validateSpecialDate(parseDate);
		
		//System.out.println(result.getDate()+"Result Query");
			if (flag.equals("add"))
			{
				if (result != null) {
					objForm.setError("Date conflicts with "+result.getDescription()+" ["+result.getDate()+"]");
				}
			}
			else if (flag.equals("edit"))
			{
				
				if (result != null && 
						( result.getId().equals(id) && (date.equals(result.getDate()) || parseDate.equals(result.getDate())))) 
				{
					objForm.setError("");
					System.out.println("edit sukses");
				}
				else if(result  != null)
				{
					objForm.setError("Date conflicts with "+result.getDescription()+" ["+result.getDate()+"]");
					System.out.println("edit gagal");
				}
			
			}
		
		
	
	}
	
}
