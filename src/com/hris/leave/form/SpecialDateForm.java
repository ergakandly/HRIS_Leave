package com.hris.leave.form;

import java.util.*;
import com.hris.leave.model.SpecialDateBean;
import org.apache.struts.action.ActionForm;

public class SpecialDateForm extends ActionForm{
	private String task;
	private String specialDateId;
	private String selectedYear;
	private List<SpecialDateBean> specialDateList;
	private List<SpecialDateBean> historySpecialDateList;
	private List<String> categoryYearList;
	private SpecialDateBean currentSpecialDateBean = new SpecialDateBean();
	
	//untuk message
	private String error;

	private String currentSideBar;



	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public List<String> getCategoryYearList() {
		return categoryYearList;
	}

	public String getSelectedYear() {
		return selectedYear;
	}

	public void setSelectedYear(String selectedYear) {
		this.selectedYear = selectedYear;
	}

	public void setCategoryYearList(List<String> categoryYearList) {
		this.categoryYearList = categoryYearList;
	}

	public List<SpecialDateBean> getHistorySpecialDateList() {
		return historySpecialDateList;
	}

	public void setHistorySpecialDateList(
			List<SpecialDateBean> historySpecialDateList) {
		this.historySpecialDateList = historySpecialDateList;
	}

	public String getSpecialDateId() {
		return specialDateId;
	}

	public String getCurrentSideBar() {
		return currentSideBar;
	}

	public void setCurrentSideBar(String currentSideBar) {
		this.currentSideBar = currentSideBar;
	}

	public void setSpecialDateId(String specialDateId) {
		this.specialDateId = specialDateId;
	}

	public List<SpecialDateBean> getSpecialDateList() {
		return specialDateList;
	}

	public void setSpecialDateList(List<SpecialDateBean> specialDateList) {
		this.specialDateList = specialDateList;
	}

	public SpecialDateBean getCurrentSpecialDateBean() {
		return currentSpecialDateBean;
	}

	public void setCurrentSpecialDateBean(SpecialDateBean currentSpecialDateBean) {
		this.currentSpecialDateBean = currentSpecialDateBean;
	}

	public String getTask() {
		return task;
	}

	public void setTask(String task) {
		this.task = task;
	}
	
	
}
