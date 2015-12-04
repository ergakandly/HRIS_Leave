package com.hris.leave.model;

public class LeaveDetailBean {
	
	private String leaveDetailId;
	private String leaveId;
	private String leaveDate;
	private String leaveDay;
	// String approvalStatus;
	
	public String getLeaveDetailId() {
		return leaveDetailId;
	}
	public String getLeaveDay() {
		return leaveDay;
	}
	public void setLeaveDay(String leaveDay) {
		this.leaveDay = leaveDay;
	}
	public void setLeaveDetailId(String leaveDetailId) {
		this.leaveDetailId = leaveDetailId;
	}
	public String getLeaveId() {
		return leaveId;
	}
	public void setLeaveId(String leaveId) {
		this.leaveId = leaveId;
	}
	public String getLeaveDate() {
		return leaveDate;
	}
	public void setLeaveDate(String leaveDate) {
		this.leaveDate = leaveDate;
	}
//	public String getApprovalStatus() {
//		return approvalStatus;
//	}
//	public void setApprovalStatus(String leaveDetailApprovalStatus) {
//		this.approvalStatus = leaveDetailApprovalStatus;
//	}
	
	
	
}
