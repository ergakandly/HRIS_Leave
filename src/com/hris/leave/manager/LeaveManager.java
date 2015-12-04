package com.hris.leave.manager;

import java.util.*;
import java.sql.*;

import com.hris.leave.ibatis.IbatisHelper;
import com.hris.leave.model.EmployeeBean;
import com.hris.leave.model.ExtraQuotaBean;
import com.hris.leave.model.LeaveBean;
import com.hris.leave.model.LeaveDetailBean;
import com.ibatis.sqlmap.client.SqlMapClient;

public class LeaveManager {

	private SqlMapClient ibatis;

	public LeaveManager() {
		ibatis = IbatisHelper.getSqlMapInstance();
	}

	public List<Map> getLeaveType() {
		List<Map> result = null;

		try {

			result = ibatis.queryForList("leave.getLeaveType", "");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		return result;
	}
	
	public List<Map> getAllDepartments() {
		List<Map> result = null;

		try {

			result = ibatis.queryForList("leave.getAllDepartments", "");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		return result;
	}

	public List<Map> getLeaveApprover(String employeeId) {
		List<Map> result = null;
		System.out.println("ID EMPLOYEE:"+employeeId);
		try {

			result = ibatis.queryForList("leave.getLeaveApprover", employeeId);
				
			if (result == null)
				System.out.println("resultnya null bro");
			else {
				for (Map m : result) {
					System.out.println(m.get("EMPLOYEENAME"));
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	public EmployeeBean getIndividualEmployeeData(String employeeId) {

		EmployeeBean result = null;

		try {

			result = (EmployeeBean) ibatis.queryForObject(
					"leave.getIndividualEmployee", employeeId);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}
	
	public List<EmployeeBean> getAllEmployees(String departmentId, String employeeName){
 		
 		List<EmployeeBean> result=null;
 		Map<String,String> param = new HashMap<String, String>();
 		param.put("departmentId", departmentId);
 		param.put("employeeName", employeeName);
 		
 		try {
 			result=ibatis.queryForList("leave.getAllEmployees",param);
 		} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
 		
		return result;
	}
	
	public LeaveBean getSingleIndividualLeave(String leaveId){
		LeaveBean result=null;
		
		Map param=new HashMap();
		param.put("leaveId",leaveId);
		
		try{
			result=(LeaveBean)ibatis.queryForObject("leave.getIndividualLeave",param);
		} catch(SQLException e){
			e.printStackTrace();
		}
		
		return result;
	}
	
	public List<LeaveBean> getSingleEmployeeLeaveList (String employeeId)
	{
		List result = null;
		
		try{
			result=ibatis.queryForList("leave.getSingleEmployeeLeaveList",employeeId);
		} catch(SQLException e){
			e.printStackTrace();
		}
		
		return result;
	}
	
	public List<LeaveBean> getAllIndividualLeave(String employeeId, String categoryYear) {

		List<LeaveBean> result = null;

		Map param = new HashMap();
		param.put("employeeId", employeeId);
		param.put("categoryYear", categoryYear);

		try {

			result = ibatis.queryForList("leave.getIndividualLeave", param);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	public List<String> getCategoryYear(String employeeId){
		List<String> result = null;
		
		try {

			result = ibatis.queryForList("leave.getCategoryYear", employeeId);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("resultnya::"+result);
		return result;
	}
	
	public List<LeaveDetailBean> getLeaveDetail(String leaveId){
		
		List<LeaveDetailBean> result = null;
		System.out.println("leaveId:"+leaveId);
		try {

			result = ibatis.queryForList("leave.getLeaveDetail", leaveId);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}
	
	public List<LeaveBean> getLeaveHistory(String employeeId) {

		List<LeaveBean> result = null;

		Map param = new HashMap();
		param.put("employeeId", employeeId);
		param.put("context", "histori");

		try {

			result = ibatis.queryForList("leave.getIndividualLeave", param);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}
	
	public List<LeaveBean> getCurrentLeave(String employeeId) {

		List<LeaveBean> result = null;

		Map param = new HashMap();
		param.put("employeeId", employeeId);
		param.put("context", "current");

		try {

			result = ibatis.queryForList("leave.getIndividualLeave", param);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	public List<LeaveBean> getApprovalRequest(String employeeId, String type){
		
		List<LeaveBean> result = null;
		
		Map param = new HashMap();
		if(type.equalsIgnoreCase("pendingcancel"))
			param.put("excludedEmployee", employeeId);
		else
			param.put("employeeId", employeeId);
		
		param.put("type",type);
		System.out.println("params: "+param);
		
		try {

			result = ibatis.queryForList("leave.getApprovalRequest", param);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}
	
	public List<ExtraQuotaBean> getExtraQuotaApprovalRequest(String employeeId){
		
		List<ExtraQuotaBean> result=null;
		
		try {
			
			result = ibatis.queryForList("leave.getExtraQuotaApprovalRequest", employeeId);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}
	
	public List<String> getEmployeeLeaveDateByInterval(String employeeId,String startDate, String endDate){
		
		List<String> result=null;
		Map param=new HashMap();
		param.put("employeeId", employeeId);
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		
		try {
			result=ibatis.queryForList("leave.getLeaveByInterval",param);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	public Boolean cekAttendance(String employeeId, String date){
		
		Boolean present=null;
		String attId=null;
		
		Map param=new HashMap();
		param.put("employeeId",employeeId);
		param.put("date", date);
		
		try {
			
			attId=(String)ibatis.queryForObject("leave.checkAttendance", param);
			present=attId==null||attId.equals("")?false:true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		return present;
	}
	
	public Boolean cekExistingSubstitutedDate(String employeeId, String date){
		
			Boolean exists=null;
			String result=null;
			
			Map param=new HashMap();
			param.put("employeeId",employeeId);
			param.put("substitutedDate", date);
			
			try {
				
				result=(String)ibatis.queryForObject("leave.checkExistingSubstitutedDate", param);
				exists=result.equals("1")?true:false;
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
			return exists;
	}

	public void insertNewLeave(LeaveBean leave, List<LeaveDetailBean> leaveDetail) throws SQLException{
		
		if(leave.getApprovedBy() == null || leave.getApprovedBy().equals(""))
		{
			leave.setApprovedBy(leave.getEmployeeId());
			leave.setApprovalComment("Top Level Manager: Auto-Approved");
			leave.setApprovalStatus("3");
		}
		
		try {
			ibatis.startTransaction();
			ibatis.insert("leave.addLeave", leave);
			
			for(LeaveDetailBean det:leaveDetail){
				ibatis.insert("leave.addLeaveDetail", det);
			}
			ibatis.commitTransaction();

		} finally{

			ibatis.endTransaction();

		}
		
	}

	public Boolean updateYearlyLeaveQuota(String employeeId, String lastQuota, String currentQuota){
		
		Map param= new HashMap();
		param.put("type", "yearly");
		param.put("lastQuota",lastQuota);
		param.put("currentQuota", currentQuota);
		param.put("employeeId", employeeId);
		
		try {
			ibatis.startTransaction();
			ibatis.update("leave.updateLeaveQuota", param);
			ibatis.commitTransaction();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} finally{
			try {
				ibatis.endTransaction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
		}
		
		
		return true;
	}
	
	public Boolean updateRewardLeaveQuota(String employeeId, String rewardQuota){
		
		Map param= new HashMap();
		param.put("type", "reward");
		param.put("rewardQuota",rewardQuota);
		param.put("employeeId", employeeId);
		
		try {
			ibatis.startTransaction();
			ibatis.update("leave.updateLeaveQuota", param);
			ibatis.commitTransaction();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} finally{
			try {
				ibatis.endTransaction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
		}
		
		return true;
	}

	public Boolean updateLeaveApprovalStatus(LeaveBean leave) {
		// TODO Auto-generated method stub
		
		if(leave.getApprovalComment() ==null)
		{
			leave.setApprovalComment("");
		}
		
		try {
			ibatis.startTransaction();
			ibatis.update("leave.updateLeaveApprovalStatus", leave);
			ibatis.commitTransaction();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("update gagal");
			return false;
		} finally{
			try {
				ibatis.endTransaction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
		}
		
		return true;
	}
	
	public Boolean updateExtraQuotaApprovalStatus(ExtraQuotaBean extraQuota){
		try {
			ibatis.startTransaction();
			ibatis.update("leave.updateExtraQuotaApprovalStatus", extraQuota);
			ibatis.commitTransaction();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} finally{
			try {
				ibatis.endTransaction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
		}
		
		return true;
	}
	
	public Boolean insertNewExtraQuota(ExtraQuotaBean extraQuota){
		
		try {
			ibatis.startTransaction();
			ibatis.insert("leave.addExtraQuota", extraQuota);
			ibatis.commitTransaction();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} finally{
			try {
				ibatis.endTransaction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
		}
		
		return true;
	}
	
	public void updateExtraQuotaUsageStatus(String id, String status){
		
		Map param= new HashMap();
		param.put("extraLeaveQuotaId",id);
		param.put("status", status);
		
		try {
			ibatis.startTransaction();
			ibatis.update("leave.updateExtraQuotaUsageStatus", param);
			ibatis.commitTransaction();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			try {
				ibatis.endTransaction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public ExtraQuotaBean getExtraQuotaToUse(String employeeId, String leaveDate){
		
		ExtraQuotaBean result=null;
		Map param=new HashMap();
		param.put("leaveDate", leaveDate);
		param.put("employeeId", employeeId);
		
		try {
			result=(ExtraQuotaBean)ibatis.queryForObject("leave.getExtraQuotaToUse", param);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	public List<ExtraQuotaBean> getIndividualExtraQuota(String employeeId) {
		// TODO Auto-generated method stub
		List<ExtraQuotaBean> result=null;
		
		try {
			result=ibatis.queryForList("leave.GetIndividualExtraLeaveQuota", employeeId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	public Integer getUsedCurrentQuota(String employeeId){
		
		Integer result=null;
		
		try {
			result=(Integer) ibatis.queryForObject("leave.checkUsedCurrentQuota", employeeId);
		} catch (SQLException e) {
			 
			e.printStackTrace();
		}
		
		return result;
	}
	
	public boolean isAuthorized(String username, String password) {
		Map user = new HashMap();
		user.put("username", username);
		user.put("password", password);
		
		int result = 0;
		try {
			result = (Integer) ibatis.queryForObject("users.isAuthorized", user);
			if (result == 1)
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;	
	}
	
	public void updateStatusLogin(String username, int status) {
		Map<String,String> user = new HashMap<String,String>();
		user.put("username", username);
		user.put("status", String.valueOf(status));
		
		try {
			ibatis.startTransaction();
			ibatis.update("users.updateStatusLogin", user);
			ibatis.commitTransaction();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				ibatis.endTransaction();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void doEodProcess(String userId) throws SQLException{
		
		try{
			ibatis.startTransaction();
			ibatis.update("leave.doEodManual", userId);
			ibatis.commitTransaction();
		}finally{
			ibatis.endTransaction();
		}
		
	}
	
	public String getPortalUrl() {
		String url = null;
		try {
			url = (String) ibatis.queryForObject("users.getPortalUrl", "");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return url;
	}
}
