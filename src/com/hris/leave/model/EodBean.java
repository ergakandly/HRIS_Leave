package com.hris.leave.model;

import java.io.Serializable;

public class EodBean implements Serializable {

	private String eodDate;
	private String eodActor;
	private String flagEod;
		
	public String getFlagEod() {
		return flagEod;
	}
	public void setFlagEod(String flagEod) {
		this.flagEod = flagEod;
	}
	public String getEodDate() {
		return eodDate;
	}
	public void setEodDate(String eodDate) {
		this.eodDate = eodDate;
	}
	public String getEodActor() {
		return eodActor;
	}
	public void setEodActor(String eodActor) {
		this.eodActor = eodActor;
	}
	
	
}
