package com.hris.leave.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateHelper {
	public static Date parseDate(String date, String format) throws ParseException{
		
		SimpleDateFormat formatter= new SimpleDateFormat(format);
		return formatter.parse(date);
	}
}
