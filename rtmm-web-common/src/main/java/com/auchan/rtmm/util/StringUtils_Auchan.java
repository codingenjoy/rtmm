package com.auchan.rtmm.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
/**
 * 对String进行简单的转换操作
 * 包含 时间格式转换
 * 数值型数组转换
 * ...
 * @author Allen.Zhang
 *
 */
public class StringUtils_Auchan {

	public static SimpleDateFormat yyyyMMdd = new SimpleDateFormat("yyyyMMdd");
	public static SimpleDateFormat yyyy_MM_dd = new SimpleDateFormat("yyyy-MM-dd");
	public static SimpleDateFormat yyyy_MM_dd_HH_mm = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	public static SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
	public static SimpleDateFormat yyyy_MM_dd_HH_mm_ss = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public static List<Long> convertStringToLongList(String str)
	{
		String[] strs = str.split(",");
		return toLongArray(strs);
	}

	public static List<Long> toLongArray(String[] longStr) {
		List<Long> llist = new ArrayList<Long>();
		for(String ls : longStr){
			try {
				Long l = Long.parseLong(ls);
				llist.add(l);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		return llist.size()>0 ? llist : null;
	}
	public static List<Integer> convertStringToIntegerList(String str)
	{
		String[] strs = str.split(",");
		return toIntegerArray(strs);
	}

	public static List<Integer> toIntegerArray(String[] intStr) {
		List<Integer> llist = new ArrayList<Integer>();
		for(String ls : intStr){
			try {
				Integer l = Integer.parseInt(ls);
				llist.add(l);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		return llist.size()>0 ? llist : null;
	}
	/**
	 * 
	 * @param yyyyMMdd
	 * @return
	 */
	public static Date getDate_yyyyMMdd(String yyyyMMddStr){
		Date date = null;
		try {
			date = yyyyMMdd.parse(yyyyMMddStr);
		} catch (ParseException e) {

			e.printStackTrace();
		}
		return date;
	}
	/**
	 * 
	 * @param yyyyMMddHHmmss
	 * @return
	 */
	public static Date getDate_yyyyMMddHHmmss(String yyyyMMddHHmmssStr){
		Date date = null;
		try {
			date = yyyyMMddHHmmss.parse(yyyyMMddHHmmssStr);
		} catch (ParseException e) {

			e.printStackTrace();
		}
		return date;
	}
	/**
	 * 
	 * @param yyyy-MM-dd
	 * @return
	 */
	public static Date getDate_yyyy_MM_dd(String yyyyMMddStr){
		Date date = null;
		try {
			date = yyyy_MM_dd.parse(yyyyMMddStr);
		} catch (ParseException e) {

			e.printStackTrace();
		}
		return date;
	}
	/**
	 * 
	 * @param yyyy-MM-dd HH:mm:ss
	 * @return
	 */
	public static Date getDate_yyyy_MM_dd_HH_mm_ss(String yyyyMMddHHmmssStr){
		Date date = null;
		try {
			date = yyyy_MM_dd_HH_mm_ss.parse(yyyyMMddHHmmssStr);
		} catch (ParseException e) {

			e.printStackTrace();
		}
		return date;
	}
	/**
	 * 
	 * @param yyyyMMdd
	 * @return
	 */
	public static String getString_yyyyMMdd(Date date){
		return yyyyMMdd.format(date);
	}
	/**
	 * 
	 * @param yyyyMMddHHmmss
	 * @return
	 */
	public static String getString_yyyyMMddHHmmss(Date date){
		return yyyyMMddHHmmss.format(date);
	}
	/**
	 * 
	 * @param yyyy-MM-dd
	 * @return
	 */
	public static String getString_yyyy_MM_dd(Date date){
		return yyyy_MM_dd.format(date);
	}
	/**
	 * 
	 * @param yyyy-MM-dd HH:mm:ss
	 * @return
	 */
	public static String getString_yyyy_MM_dd_HH_mm_ss(Date date){
		return yyyy_MM_dd_HH_mm_ss.format(date);
	}
	/**
	 * 
	 * @param yyyy-MM-dd HH:mm
	 * @return
	 */
	public static String getString_yyyy_MM_dd_HH_mm(Date date){

		return yyyy_MM_dd_HH_mm.format(date);
	}

	/**
	 * 返回字符串的编码
	 * @param str
	 * @return
	 */
	public static String getEncoding(String str) {      
		String encode = "";   
		try {      
			encode = "UTF-8";      
			if (str.equals(new String(str.getBytes(encode), encode))) {      
				String s2 = encode;      
				return s2;      
			}      
			encode = "GB18030";   
			if (str.equals(new String(str.getBytes(encode), encode))) {      
				String s = encode;      
				return s;      
			}          
			encode = "GBK";      
			if (str.equals(new String(str.getBytes(encode), encode))) {      
				String s3 = encode;      
				return s3;      
			}      
			encode = "GB2312";      
			if (str.equals(new String(str.getBytes(encode), encode))) {      
				String s3 = encode;      
				return s3;      
			}      
			encode = "ISO-8859-1";      
			if (str.equals(new String(str.getBytes(encode), encode))) {      
				String s1 = encode;      
				return s1;      
			}      
		} catch (Exception exception3) {      
		}      
		return "";      
	}      
}
