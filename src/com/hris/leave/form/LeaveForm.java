package com.hris.leave.form;

import com.hris.leave.model.*;
import java.util.*;
import org.apache.struts.action.ActionForm;

public class LeaveForm extends ActionForm {
	
	private String task;
	
	//main menu
	private List<SpecialDateBean> upcomingMassleave;
	private List<SpecialDateBean> upcomingNationalHoliday;
	//
	
	private EmployeeBean currentEmployee;
	private List<LeaveBean> employeeLeaveList;
	private List<LeaveBean> employeeHistoryLeaveList;
	
	private List<ExtraQuotaBean> extraQuotaList;
	//private List<LeaveDetailBean> employeeLeaveDetail;
	private String selectedLeaveId;
	private String selectedYear;
	private List<String> categoryYear;
	
	//buat request leave
	private List<Map> leaveType;
	private List<Map> leaveApprover;
	private List<Map> departments;
	
	private String typeLeaveRequest;
	private String approverLeaveRequest;
	
	private String selectedLeaveType;
	private String startLeaveDate;
	private String lastLeaveDate;
	
	//request extra quota
	private String substitutedDate;
	
	//leave & extra quota
	private String selectedLeaveApprover;
	private String description;
	
	//approval
	private String approvedExtraQuotaId;
	private String approvedEmployeeId;
	private String approvalComment;

	//buat list cuti hr
	private String selectedEmployee;
	private String selectedDepartment;
	private List<EmployeeBean> employeeList;
	
	//buat eod
	private EodBean eodBean;
	
	//buat itemin sidebar
	private String currentSideBar;
	
	//buat kasih message
	private String error;
	private String info;
	
	//session
	private String parameter;
	
	// public List<LeaveDetailBean> getEmployeeLeaveDetail() {
	// return employeeLeaveDetail;
	// }
	//
	// public void setEmployeeLeaveDetail(List<LeaveDetailBean>
	// employeeLeaveDetail) {
	// this.employeeLeaveDetail = employeeLeaveDetail;
	// }
	
	public String getError() {
		return error;
	}
	
	
	
	public String getInfo() {
		return info;
	}



	public void setInfo(String info) {
		this.info = info;
	}



	public String getParameter() {
		return parameter;
	}

	public void setParameter(String parameter) {
		this.parameter = parameter;
	}

	public void setError(String error) {
		this.error = error;
	}

	public List<LeaveBean> getEmployeeHistoryLeaveList() {
		return employeeHistoryLeaveList;
	}

	public List<String> getCategoryYear() {
		return categoryYear;
	}

	public void setCategoryYear(List<String> categoryYear) {
		this.categoryYear = categoryYear;
	}

	public String getSelectedYear() {
		return selectedYear;
	}

	public void setSelectedYear(String selectedYear) {
		this.selectedYear = selectedYear;
	}

	public String getApprovedExtraQuotaId() {
		return approvedExtraQuotaId;
	}

	public void setApprovedExtraQuotaId(String approvedExtraQuotaId) {
		this.approvedExtraQuotaId = approvedExtraQuotaId;
	}

	public List<ExtraQuotaBean> getExtraQuotaList() {
		return extraQuotaList;
	}

	public void setExtraQuotaList(List<ExtraQuotaBean> extraQuotaList) {
		this.extraQuotaList = extraQuotaList;
	}

	public String getSubstitutedDate() {
		return substitutedDate;
	}

	public void setSubstitutedDate(String substitutedDate) {
		this.substitutedDate = substitutedDate;
	}

	public void setEmployeeHistoryLeaveList(List<LeaveBean> employeeHistoryLeaveList) {
		this.employeeHistoryLeaveList = employeeHistoryLeaveList;
	}
	
	public String getApprovalComment() {
		return approvalComment;
	}

	public String getApprovedEmployeeId() {
		return approvedEmployeeId;
	}

	public void setApprovedEmployeeId(String approvedEmployeeId) {
		this.approvedEmployeeId = approvedEmployeeId;
	}

	public String getSelectedDepartment() {
		return selectedDepartment;
	}

	public void setSelectedDepartment(String selectedDepartment) {
		this.selectedDepartment = selectedDepartment;
	}

	public void setApprovalComment(String approvalComment) {
		this.approvalComment = approvalComment;
	}

	public void setDepartments(List<Map> departments) {
		this.departments = departments;
	}
	
	public List<Map> getDepartments() {
		return departments;
	}

	public String getSelectedLeaveType() {
		return selectedLeaveType;
	}

	public void setSelectedLeaveType(String selectedLeaveType) {
		this.selectedLeaveType = selectedLeaveType;
	}

	public String getSelectedLeaveApprover() {
		return selectedLeaveApprover;
	}

	public void setSelectedLeaveApprover(String selectedLeaveApprover) {
		this.selectedLeaveApprover = selectedLeaveApprover;
	}

	public String getSelectedLeaveId() {
		return selectedLeaveId;
	}

	public void setSelectedLeaveId(String selectedLeaveId) {
		this.selectedLeaveId = selectedLeaveId;
	}

	public String getTypeLeaveRequest() {
		return typeLeaveRequest;
	}

	public void setTypeLeaveRequest(String typeLeaveRequest) {
		this.typeLeaveRequest = typeLeaveRequest;
	}

	public String getApproverLeaveRequest() {
		return approverLeaveRequest;
	}

	public void setApproverLeaveRequest(String approverLeaveRequest) {
		this.approverLeaveRequest = approverLeaveRequest;
	}
	
	public String getCurrentSideBar() {
		return currentSideBar;
	}

	public void setCurrentSideBar(String currentSideBar) {
		this.currentSideBar = currentSideBar;
	}

	public LeaveForm(){
		currentEmployee=new EmployeeBean();
	}
	
	public String getSelectedEmployee() {
		return selectedEmployee;
	}

	public void setSelectedEmployee(String selectedEmployee) {
		this.selectedEmployee = selectedEmployee;
	}

	public List<LeaveBean> getEmployeeLeaveList() {
		return employeeLeaveList;
	}

	public void setEmployeeLeaveList(List<LeaveBean> employeeLeaveList) {
		this.employeeLeaveList = employeeLeaveList;
	}

	public String getStartLeaveDate() {
		return startLeaveDate;
	}

	public void setStartLeaveDate(String startLeaveDate) {
		this.startLeaveDate = startLeaveDate;
	}

	public String getLastLeaveDate() {
		return lastLeaveDate;
	}

	public void setLastLeaveDate(String lastLeaveDate) {
		this.lastLeaveDate = lastLeaveDate;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<Map> getLeaveType() {
		return leaveType;
	}

	public void setLeaveType(List<Map> leaveType) {
		this.leaveType = leaveType;
	}

	public List<Map> getLeaveApprover() {
		return leaveApprover;
	}

	public void setLeaveApprover(List<Map> leaveApprover) {
		this.leaveApprover = leaveApprover;
	}

	public EodBean getEodBean() {
		return eodBean;
	}

	public void setEodBean(EodBean eodBean) {
		this.eodBean = eodBean;
	}

	public EmployeeBean getCurrentEmployee() {
		return currentEmployee;
	}

	public void setCurrentEmployee(EmployeeBean currentEmployee) {
		this.currentEmployee = currentEmployee;
	}

	public List<EmployeeBean> getEmployeeList() {
		return employeeList;
	}

	public void setEmployeeList(List<EmployeeBean> employeeList) {
		this.employeeList = employeeList;
	}

	public List<SpecialDateBean> getUpcomingMassleave() {
		return upcomingMassleave;
	}

	public void setUpcomingMassleave(List<SpecialDateBean> upcomingMassleave) {
		this.upcomingMassleave = upcomingMassleave;
	}

	public List<SpecialDateBean> getUpcomingNationalHoliday() {
		return upcomingNationalHoliday;
	}

	public void setUpcomingNationalHoliday(
			List<SpecialDateBean> upcomingNationalHoliday) {
		this.upcomingNationalHoliday = upcomingNationalHoliday;
	}

	public String getTask() {
		return task;
	}

	public void setTask(String task) {
		this.task = task;
	}
	
	
	
}
