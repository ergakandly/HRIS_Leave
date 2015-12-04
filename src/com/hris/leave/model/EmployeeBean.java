package com.hris.leave.model;

import java.util.*;

public class EmployeeBean {
	
	private String employeeId;
	private String employeeNik;
	private String employeeName;
	private String departmentName;
	
	private String locationName;
	private String currentLeaveQuota;
	private String currentQuotaExpiredDate;
	private String lastQuota;
	private String lastQuotaExpiredDate;
	private String rewardQuota;
	private String rewardQuotaExpiredDate;
	private String renewalDate;
	
//	public List<ExtraQuotaBean> getExtraQuota() {
//		return extraQuota;
//	}
//	public void setExtraQuota(List<ExtraQuotaBean> extraQuota) {
//		this.extraQuota = extraQuota;
//	}
	
	public String getEmployeeNik() {
		return employeeNik;
	}
	public void setEmployeeNik(String employeeNik) {
		this.employeeNik = employeeNik;
	}
	public String getRenewalDate() {
		return renewalDate;
	}
	public void setRenewalDate(String renewalDate) {
		this.renewalDate = renewalDate;
	}
	public String getLocationName() {
		return locationName;
	}
	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}
	public String getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public String getCurrentLeaveQuota() {
		return currentLeaveQuota;
	}
	public void setCurrentLeaveQuota(String currentLeaveQuota) {
		this.currentLeaveQuota = currentLeaveQuota;
	}
	public String getCurrentQuotaExpiredDate() {
		return currentQuotaExpiredDate;
	}
	public void setCurrentQuotaExpiredDate(String currentQuotaExpiredDate) {
		this.currentQuotaExpiredDate = currentQuotaExpiredDate;
	}
	public String getLastQuota() {
		return lastQuota;
	}
	public void setLastQuota(String lastQuota) {
		this.lastQuota = lastQuota;
	}
	public String getLastQuotaExpiredDate() {
		return lastQuotaExpiredDate;
	}
	public void setLastQuotaExpiredDate(String lastQuotaExpiredDate) {
		this.lastQuotaExpiredDate = lastQuotaExpiredDate;
	}
	public String getRewardQuota() {
		return rewardQuota;
	}
	public void setRewardQuota(String rewardQuota) {
		this.rewardQuota = rewardQuota;
	}
	public String getRewardQuotaExpiredDate() {
		return rewardQuotaExpiredDate;
	}
	public void setRewardQuotaExpiredDate(String rewardQuotaExpiredDate) {
		this.rewardQuotaExpiredDate = rewardQuotaExpiredDate;
	}
	
	//private List<LeaveBean> employeeLeave;
	
	
	
}
