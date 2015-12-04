package com.hris.leave.manager;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hris.leave.ibatis.IbatisHelper;
import com.hris.leave.model.SpecialDateBean;
import com.ibatis.sqlmap.client.SqlMapClient;

public class SpecialDateManager {
	
	private SqlMapClient ibatis;
	
	public SpecialDateManager()
	{
		ibatis=IbatisHelper.getSqlMapInstance();
	}
	
	/**
	 * Method untuk mendapatkan list tanggal cuti bersama atau hari libur nasional
	 * digunakan untuk melakukan pengecekan pengajuan cuti
	 * yang bertepatan dengan tanggal cuti bersama atau hari libur nasional
	 * @param startDate 
	 * @param endDate
	 * @return 
	 */
	public List<String> getSpecialDateByPeriod(String startDate, String endDate){
		
		List<String> result= null;
		Map param=new HashMap();
		
		param.put("startDate",startDate);
		param.put("endDate",endDate);
		
		try {
			result=ibatis.queryForList("specialdate.getSpecialDateByInterval", param);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	/**
	 * Method untuk mendapatkan list berisi informasi seputar cuti bersama atau hari libur nasional
	 * @param specialDateType "1" = hari libur nasional, "2" = cuti bersama
	 * @param specialDateCategory 	"Upcoming" = untuk tanggal sesudah hari ini, "History" = untuk tanggal hari ini dan sebelumnya
	 * @param categoryYear	digunakan untuk mengelompokkan list lewat tahun
	 * @param closestSpecialDate untuk mendapatkan list cuti bersama atau hari libur nasional 3 bulan dari sekarang
	 * @return
	 */
	public List<SpecialDateBean> getSpecialDate(String specialDateType, String specialDateCategory, String categoryYear, String closestSpecialDate)
	{
		List<SpecialDateBean> result=null;
		Map map = new HashMap<String, String>();
		
		map.put("specialDateType", specialDateType);
		map.put("specialDateCategory", specialDateCategory);
		map.put("categoryYear",categoryYear);
		map.put("closestSpecialDate",closestSpecialDate);
		
		try
		{
			ibatis.startTransaction();
			result=ibatis.queryForList("specialdate.getSpecialDate", map);
			ibatis.commitTransaction();
			
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			
			try {
				ibatis.endTransaction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return result;
	}
	
	/**
	 * Method yang digunakan untuk validasi tanggal yang diinput user
	 * @param date
	 * @return
	 */
	public SpecialDateBean validateSpecialDate(String date){
		Map<String, String> map = new HashMap<String, String>();
		SpecialDateBean result=null;

		map.put("specialDateCategory","Upcoming");
		map.put("validateSpecialDate", date);
		
		try
		{
			ibatis.startTransaction();
			result=(SpecialDateBean) ibatis.queryForObject("specialdate.getSpecialDate", map);
			ibatis.commitTransaction();
			
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			
			try {
				ibatis.endTransaction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return result;
	}
	
	/**
	 * Menambahkan tanggal cuti bersama atau hari libur nasional ke dalam database
	 * @param bean
	 */
	public void insertSpecialDate(SpecialDateBean bean){
		try
		{
			ibatis.startTransaction();
			ibatis.insert("specialdate.insertSpecialDate", bean);
			ibatis.commitTransaction();
			
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			
			try {
				ibatis.endTransaction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * Untuk menghapus cuti bersama atau hari libur nasional dari tabel master
	 * @param specialDateId
	 */
	public void deleteSpecialDate(String specialDateId){
		try
		{
			ibatis.startTransaction();
			ibatis.delete("specialdate.deleteSpecialDate", specialDateId);
			ibatis.commitTransaction();
			
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			
			try {
				ibatis.endTransaction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * Method untuk mengedit cuti bersama atau hari libur nasional
	 * @param bean
	 */
	public void updateSpecialDate(SpecialDateBean bean)
	{
		try
		{
			System.out.println(bean.getDescription());
			System.out.println(bean.getDate());
			System.out.println(bean.getUpdateUser());
			System.out.println(bean.getId());
			ibatis.startTransaction();
			ibatis.update("specialdate.updateSpecialDate", bean);
			ibatis.commitTransaction();
			
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			
			try {
				ibatis.endTransaction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * Untuk mendapatkan list tahun yang digunakan untuk categorizing
	 * @param specialDateType
	 * @param specialDateCategory
	 * @return
	 */
	public List<String> getCategoryYear(String specialDateType, String specialDateCategory){
		List<String> result = null;
		
		Map<String,String> param = new HashMap<String,String>();
		
		param.put("specialDateType",specialDateType);
		param.put("specialDateCategory",specialDateCategory);
		
		try {
			result=ibatis.queryForList("specialdate.getCategoryYear", param);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * Untuk mendapatkan nilai default pada categorizing year
	 * @param specialDateType
	 * @param specialDateCategory
	 * @return
	 */
	public String getDefaultCategoryYear(String specialDateType, String specialDateCategory){
		Map<String,String> param = new HashMap<String,String>();
		
		String result = null;
		
		param.put("specialDateType",specialDateType);
		param.put("specialDateCategory",specialDateCategory);
		
		try {
			result=(String) ibatis.queryForObject("specialdate.getDefaultCategoryYear", param);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * Mendapatkan tahun berjalan pada server
	 * @param specialDateType
	 * @return
	 */
	public String getCurrentYear(String specialDateType){
		String result = null;
		
		try {
			result=(String) ibatis.queryForObject("specialdate.getCurrentYear", specialDateType);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
}
