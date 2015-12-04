package com.hris.leave.model;

public class LeaveBean {
	/*
	   leave_id
	   employee_id
	   leave_date
	   leave_type_id
	   description
	   submit_date
	   approved_by
	   approval_status
	   approval_date
	 */
	public static final String PENDING = "Pending";
	public static final String HISTORY = "History";
	
	public static final String APPROVAL_STATUS_PENDING_REQUEST="1";
	public static final String APPROVAL_STATUS_PENDING_CANCEL="2";
	public static final String APPROVAL_STATUS_ACCEPTED="3";
	public static final String APPROVAL_STATUS_REJECTED="4";
	public static final String APPROVAL_STATUS_CANCELLED="5";
	
	public static final String YEARLY_LEAVE_TYPE="1";
	public static final String REWARD_LEAVE_TYPE="2";
	public static final String MISC_LEAVE_TYPE="3";
	public static final String EXTRA_LEAVE_TYPE="4";
	
	private String leaveId;
	private String employeeId;
	private String employeeName;
	private String employeeNik;
	//private String leaveDate;
	private String leaveType;
	private String description;
	private String submitDate;
	private String approvedBy;
	private String approvalStatus;
	private String approvalComment;
	private String approvalDate;
	private String expiredDate;
	private String firstDayOfLeave;
	private String lastDayOfLeave;
	private String totalLeaveDay;
//	private String comment;
//	
	private String extraQuotaId;
	
	
	public String getExtraQuotaId() {
		return extraQuotaId;
	}
	public void setExtraQuotaId(String extraQuotaId) {
		this.extraQuotaId = extraQuotaId;
	}
	public String getApprovalComment() {
		return approvalComment;
	}
	public void setApprovalComment(String approvalComment) {
		this.approvalComment = approvalComment;
	}
	public String getEmployeeNik() {
		return employeeNik;
	}
	public void setEmployeeNik(String employeeNik) {
		this.employeeNik = employeeNik;
	}
//	public String getComment() {
//		return comment;
//	}
//	public void setComment(String comment) {
//		this.comment = comment;
//	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getTotalLeaveDay() {
		return totalLeaveDay;
	}
	public void setTotalLeaveDay(String totalLeaveDay) {
		this.totalLeaveDay = totalLeaveDay;
	}
	public String getExpiredDate() {
		return expiredDate;
	}
	public void setExpiredDate(String expiredDate) {
		this.expiredDate = expiredDate;
	}
	public String getFirstDayOfLeave() {
		return firstDayOfLeave;
	}
	public void setFirstDayOfLeave(String firstDayOfLeave) {
		this.firstDayOfLeave = firstDayOfLeave;
	}
	public String getLastDayOfLeave() {
		return lastDayOfLeave;
	}
	public void setLastDayOfLeave(String lastDayOfLeave) {
		this.lastDayOfLeave = lastDayOfLeave;
	}
	public String getLeaveId() {
		return leaveId;
	}
	public void setLeaveId(String leaveId) {
		this.leaveId = leaveId;
	}
	public String getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}
//	public String getLeaveDate() {
//		return leaveDate;
//	}
//	public void setLeaveDate(String leaveDate) {
//		this.leaveDate = leaveDate;
//	}
	public String getLeaveType() {
		return leaveType;
	}
	public void setLeaveType(String leaveType) {
		this.leaveType = leaveType;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getSubmitDate() {
		return submitDate;
	}
	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}
	public String getApprovedBy() {
		return approvedBy;
	}
	public void setApprovedBy(String approvedBy) {
		this.approvedBy = approvedBy;
	}
	public String getApprovalStatus() {
		return approvalStatus;
	}
	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}
	public String getApprovalDate() {
		return approvalDate;
	}
	public void setApprovalDate(String approvalDate) {
		this.approvalDate = approvalDate;
	}
	
	
	 
}
