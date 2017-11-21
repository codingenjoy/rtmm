package com.auchan.rtmm.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

public class DateUtils  extends org.apache.commons.lang.time.DateUtils {

	public static XMLGregorianCalendar convertToXMLGregorianCalendar(Date date) {

		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(date);
		XMLGregorianCalendar gc = null;
		try {
			gc = DatatypeFactory.newInstance().newXMLGregorianCalendar(cal);
		} catch (Exception e) {

			e.printStackTrace();
		}
		return gc;
	}

	public static Date convertToDate(XMLGregorianCalendar cal) throws Exception {
		GregorianCalendar ca = cal.toGregorianCalendar();
		return ca.getTime();
	}

	/**
	 * yearOffset:返回移动指定年数后的日期
	 * 
	 * @param : date 指定日期
	 * @param : offset 移动年数
	 * @return: Date 返回移动后的日期
	 * @author: Kin
	 * @since : Verion 1.0
	 */
	public static Date yearOffset(Date date, int offset) {
		return offsetDate(date, Calendar.YEAR, offset);
	}

	/**
	 * yearOffset:返回移动指定月数后的日期
	 * 
	 * @param : date 指定日期
	 * @param : offset 移动月数
	 * @return: Date 返回移动后的日期
	 * @author: Kin
	 * @since : Verion 1.0
	 */
	public static Date monthOffset(Date date, int offset) {
		return offsetDate(date, Calendar.MONTH, offset);
	}

	/**
	 * yearOffset:返回移动指定天数后的日期
	 * 
	 * @param : date 指定日期
	 * @param : offset 移动天数
	 * @return: Date 返回移动后的日期
	 * @author: Kin
	 * @since : Verion 1.0
	 */
	public static Date dayOffset(Date date, int offset) {
		return offsetDate(date, Calendar.DATE, offset);
	}

	/**
	 * offsetDate:返回指定日期相应位移后的日期
	 * 
	 * @param : date 指定日期
	 * @param : field 位移单位，见 {@link Calendar}
	 * @param : offset 位移数量，正数表示之后的时间，负数表示之前的时间
	 * @return: Date 返回移动后的日期
	 * @author: Kin
	 * @since : Verion 1.0
	 */
	public static Date offsetDate(Date date, int field, int offset) {
		Calendar calendar = convert(date);
		calendar.add(field, offset);
		return calendar.getTime();
	}
	
	/**
	 * 计算两个日期间的相差的天数(整数),大的在前面.
	 * @param date1
	 * @param date2
	 * @return days
	 */
	public static int getMinusOfTwoDate(Date date1,Date date2){
		return (int)((date1.getTime()-date2.getTime())/(1000*60*60*24));
	}

	/**
	 * convert:把指定日期转换成默认时区的Calendar
	 * 
	 * @param : date
	 * @return: Calendar 默认时区的Calendar
	 * @author: Kin
	 * @since : Verion 1.0
	 */
	private static Calendar convert(Date date) {
		return convert(date, Locale.getDefault());
	}

	/**
	 * convert:把指定日期转换成指定时区的Calendar
	 * 
	 * @param date
	 * @return: 指定日期转换成指定时区的Calendar
	 * @author: Kin
	 * @return: Calendar
	 * @since : Verion 1.0
	 */
	public static Calendar convert(Date date, Locale zone) {
		Calendar calendar = new GregorianCalendar(zone);
		calendar.setTime(date);
		return calendar;
	}

	static public Date parseDate(String s) throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return format.parse(s);
	}
	
	static public String parseDate2Str(Date date,String format){
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}

	static public Date parseDate(String s, String f){
		try{
			SimpleDateFormat format = new SimpleDateFormat(f);
			return format.parse(s);
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	static public String getCurrentDate(String format){
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(new Date());
	}
    /**
     * @param sourceStartDate
     * @param sourceEndDate
     * @param comperStartDate
     * @param comperEndDate
     * @return 在目标范围内，返回true
     */
    public static boolean inSoucreDateRange(Date sourceStartDate,Date sourceEndDate,
    		Date comperStartDate,Date comperEndDate){
    	//sourceEndDate小于comperStartDate，不重复
    	//sourceStartDate大于comperEndDate，不重复
        if(sourceEndDate.before(comperStartDate) || sourceStartDate.after(comperEndDate) ){
        	return false;
        }  
        return true;  
    } 
}
