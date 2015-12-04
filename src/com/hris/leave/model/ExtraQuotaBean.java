package com.hris.leave.model;

public class ExtraQuotaBean {
	
	public static final String EXTRA_QUOTA_STATUS_PENDING="1";
	public static final String EXTRA_QUOTA_STATUS_APPROVED="2";
	public static final String EXTRA_QUOTA_STATUS_REJECTED="3";
	public static final String EXTRA_QUOTA_STATUS_USED="4";
	
	private String extraLeaveQuotaId;
	private String employeeId;
	private String employeeNik;
	private String employeeName;
	private String substitutedDate;
	private String expiredDate;
	private String description;
	private String submitDate;
	private String status;
	private String approvedBy;
	private String approvalDate;
	private String approvalComment;
	
	
	
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getExtraLeaveQuotaId() {
		return extraLeaveQuotaId;
	}
	public void setExtraLeaveQuotaId(String extraLeaveQuotaId) {
		this.extraLeaveQuotaId = extraLeaveQuotaId;
	}
	public String getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}
	public String getEmployeeNik() {
		return employeeNik;
	}
	public void setEmployeeNik(String employeeNik) {
		this.employeeNik = employeeNik;
	}
	public String getSubstitutedDate() {
		return substitutedDate;
	}
	public void setSubstitutedDate(String substitutedDate) {
		this.substitutedDate = substitutedDate;
	}
	public String getExpiredDate() {
		return expiredDate;
	}
	public void setExpiredDate(String expiredDate) {
		this.expiredDate = expiredDate;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getApprovedBy() {
		return approvedBy;
	}
	public void setApprovedBy(String approvedBy) {
		this.approvedBy = approvedBy;
	}
	public String getApprovalDate() {
		return approvalDate;
	}
	public void setApprovalDate(String approvalDate) {
		this.approvalDate = approvalDate;
	}
	public String getApprovalComment() {
		return approvalComment;
	}
	public void setApprovalComment(String approvalComment) {
		this.approvalComment = approvalComment;
	}

	
}
