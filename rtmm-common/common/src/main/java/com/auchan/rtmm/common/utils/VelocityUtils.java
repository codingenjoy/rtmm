package com.auchan.rtmm.common.utils;

import java.io.StringWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;

/**
 * 使用Velocity生成内容的工具类.
 */
public class VelocityUtils {

	static {
		try {
			Velocity.init();
		} catch (Exception e) {
			throw new RuntimeException("Exception occurs while initialize the velociy.", e);
		}
	}

	/**
	 * 渲染内容, 得到干净的sql
	 * 
	 * @param template 模板内容.
	 * @param model 变量Map.
	 */
	public static String render(String template, Map<String, Object> model) {
		try {
			VelocityContext velocityContext = new VelocityContext(model);
			StringWriter result = new StringWriter();
			Velocity.evaluate(velocityContext, result, "", template);
			return getCleanSql(result.toString()); //得到干净的sql
		} catch (Exception e) {
			throw new RuntimeException("Parse template failed.", e);
		}
	}
	
	public static String getCleanSql(String sql) {
    	sql = sql.replace("\n", " "); //去除回车
		sql = sql.replace("\r", " "); //去除换行
		sql = sql.replace("	", " "); //去掉 "奇怪的空格": tab, tab 也就是:  \t
		
		sql = sql.replace("      ", " "); //合并 6 个空格
		sql = sql.replace("     ", " "); //合并 5 个空格
		sql = sql.replace("    ", " "); //合并 4 个空格
		sql = sql.replace("   ", " "); //合并 3 个空格
		sql = sql.replace("  ", " "); //合并 2 个空格
    	return sql;//sql.trim()
    }
	
	/**
	 * 基本用法
	 * @param args
	 */
	public static void main(String[] args) {
		StringBuffer sql = new StringBuffer();
		/*sql.append("select * from user ");
		sql.append("	WHERE 1=1 ");
				           
		sql.append("#if($startDate && $endDate) ");
		sql.append("	and ( ");
		sql.append("		t.CREATION_DATE <=:endDate  ");
		sql.append("	and ");
		sql.append("   t.CREATION_DATE >=:startDate ");
		sql.append("	) ");
		sql.append("#else ");
		sql.append("	#if($startDate) ");
		sql.append("		and t.CREATION_DATE >=:startDate ");
		sql.append("	#else ");
		sql.append("	#if($endDate) ");
		sql.append("	and t.CREATION_DATE <=:endDate  ");
		sql.append("	#end ");
		sql.append(" #end ");
		sql.append("#end");
		*/
		sql.append("#if(!$startDate)");
		sql.append("123");
		sql.append("#else ");
		sql.append("456");
		sql.append("#end ");
		
		Map<String, Object> valMap = new HashMap<String, Object>();
		Date startDate = new Date();
		valMap.put("startDate", startDate);
		
		
		String cleanSql = VelocityUtils.render(sql.toString(), valMap);
		System.out.println(cleanSql);
	}
}
