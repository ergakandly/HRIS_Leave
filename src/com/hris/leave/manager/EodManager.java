package com.hris.leave.manager;

import java.sql.SQLException;

import com.hris.leave.ibatis.IbatisHelper;
import com.hris.leave.model.EodBean;
import com.ibatis.sqlmap.client.SqlMapClient;

public class EodManager {

	private SqlMapClient ibatis;

	public EodManager() {
		ibatis = IbatisHelper.getSqlMapInstance();
	}

	public EodBean getLastEod() {
	
		EodBean result = new EodBean();
		
		try {
			ibatis.startTransaction();
			result=(EodBean) ibatis.queryForObject("eod.getLastEod","");
			ibatis.commitTransaction();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				ibatis.endTransaction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;
	}
}
