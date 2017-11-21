package com.auchan.rtmm.common.utils;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

import com.auchan.common.codetable.utils.CodeTableUtil;
import com.auchan.common.codetable.vo.SqlDataVO;
import com.auchan.common.security.SessionCache;
import com.auchan.rtmm.common.common.Ordering;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.common.session.SessionHelper;

public class QueryUtil {
	/**
	 * 获取所有数据
	 * 
	 * @param appKey
	 * @param moduleKey
	 * @param pageKay
	 * @param sqlKey
	 * @param whereMap
	 * @return
	 */
	public static String getDataSql(String appKey, String moduleKey, String pageKay, String sqlKey, Map<String, Object> whereMap) {
		setUserAuthInfo(whereMap);
		SqlDataVO sqlData = CodeTableUtil.getSql(appKey, moduleKey, pageKay, sqlKey);
		String sql = null;
		if (sqlData != null && sqlData.getSql_desc() != null && !"".equals(sqlData.getSql_desc().trim())) {
			sql = sqlData.getSql_desc();
			sql = VelocityUtils.render(sql, whereMap);

		}
		return sql;
	}

	/**
	 * 获取 总记录数sql
	 * 
	 * @param appKey
	 * @param moduleKey
	 * @param pageKay
	 * @param sqlKey
	 * @param whereMap
	 * @return
	 */
	public static String getDataCountSql(String appKey, String moduleKey, String pageKay, String sqlKey, Map<String, Object> whereMap) {
		String mainSql = getDataSql(appKey, moduleKey, pageKay, sqlKey, whereMap);
		if (mainSql == null) {
			return null;
		}
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT count(*) count FROM ( ");
		sql.append(mainSql);
		sql.append(")");
		return sql.toString();
	}

	/**
	 * 获取 总记录数sql
	 * 
	 * @param sqlString
	 * @return
	 */
	public static String getDataCountSql(String sqlString) {
		if (sqlString == null) {
			return null;
		}
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT count(*) count FROM ( ");
		sql.append(sqlString);
		sql.append(")");
		return sql.toString();
	}

	/**
	 * 获取带分页条件的sql
	 * 
	 * @param sqlString
	 * @param paging
	 * @param whereMap
	 * @return
	 */
	public static String getDataPageSql(String sqlString, PaginationSettings paging, Map<String, Object> whereMap) {
		if (sqlString == null) {
			return null;
		}
		StringBuffer sql = new StringBuffer();
		List<Ordering> orderList = paging.getOrderBy();
		String orderBy = "";
		if (orderList != null && orderList.size() > 0) {
			orderBy = " ORDER BY ";
			for (Ordering order : orderList) {
				orderBy += order.toString() + ",";
			}
			if (orderBy.endsWith(",")) {
				orderBy = orderBy.substring(0, orderBy.length() - 1);
			}
		}
		Integer start = (paging.getPageNo() - 1) * paging.getPageSize() + 1;
		Integer end = paging.getPageNo() * paging.getPageSize();
		whereMap.put("start", start);
		whereMap.put("end", end);
		sql.append(" SELECT * FROM ( ");
		sql.append(" SELECT t.* ,row_number() OVER(" + orderBy + ") row_num FROM ( ");
		sql.append(sqlString);
		sql.append(" ) t");
		sql.append(" ) t2 WHERE t2.row_num<=:end");
		sql.append(" AND t2.row_num>=:start");
		return sql.toString();
	}

	/**
	 * 执行分页查询
	 * 
	 * @param appKey
	 * @param moduleKey
	 * @param pageKay
	 * @param sqlKey
	 * @param paging
	 * @param whereMap
	 *            条件集合
	 * @param template
	 *            JDBC
	 * @param beanPropertyRowMapper
	 *            模型Bean
	 * @return
	 */
	public static PaginationResult serachPageData(String appKey, String moduleKey, String pageKay, String sqlKey, PaginationSettings paging,
			Map<String, Object> whereMap, NamedParameterJdbcTemplate template, BeanPropertyRowMapper beanPropertyRowMapper) {
		PaginationResult pr = new PaginationResult();
		String allSql = getDataSql(appKey, moduleKey, pageKay, sqlKey, whereMap);
		String countSql = getDataCountSql(allSql);
		Integer count = template.queryForInt(countSql, whereMap);
		if (count > 0) {
			String pageSql = getDataPageSql(allSql, paging, whereMap);
			List swaVOList = template.query(pageSql, whereMap, beanPropertyRowMapper);
			pr.setData(swaVOList);
		}
		pr.setTotalCount(count);
		return pr;
	}
	/**
	 * 执行分页查询
	 * 
	 * @param appKey
	 * @param moduleKey
	 * @param pageKay
	 * @param sqlKey
	 * @param paging
	 * @param whereMap
	 *            条件集合
	 * @param template
	 *            JDBC
	 * @param beanPropertyRowMapper
	 *            模型Bean
	 * @return
	 */
	public static PaginationResult serachPageData(String appKey, String moduleKey, String pageKay, String sqlKey, PaginationSettings paging,
			Map<String, Object> whereMap, NamedParameterJdbcTemplate template, BeanPropertyRowMapper beanPropertyRowMapper, boolean doCountRtComputing) {
		PaginationResult pr = new PaginationResult();
		String allSql = getDataSql(appKey, moduleKey, pageKay, sqlKey, whereMap);
		Integer count = -1;//-1 means don't search query totalCount in Real-time.
		if (doCountRtComputing){
			String countSql = getDataCountSql(allSql);
			count = template.queryForInt(countSql, whereMap);
		}
		if (!doCountRtComputing || count > 0) {
			String pageSql = getDataPageSql(allSql, paging, whereMap);
			List swaVOList = template.query(pageSql, whereMap, beanPropertyRowMapper);
			pr.setData(swaVOList);
		}
		pr.setTotalCount(count);
		return pr;
	}

	/**
	 * 执行一般查询 不带分页
	 * 
	 * @param appKey
	 * @param moduleKey
	 * @param pageKay
	 * @param sqlKey
	 * @param paging
	 * @param whereMap
	 *            条件集合
	 * @param template
	 *            JDBC
	 * @param beanPropertyRowMapper
	 *            模型Bean
	 * @return
	 */
	public static List serachDataList(String appKey, String moduleKey, String pageKay, String sqlKey, Map<String, Object> whereMap,
			NamedParameterJdbcTemplate template, BeanPropertyRowMapper beanPropertyRowMapper) {
		String sql = getDataSql(appKey, moduleKey, pageKay, sqlKey, whereMap);
		return template.query(sql, whereMap, beanPropertyRowMapper);
	}

	/**
	 * 将资源Bean中的属性和值获取并保存在Map中
	 * 
	 * @param javaBean
	 *            资源Bean
	 * @return
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	public static Map<String, Object> inverBeanToMap(Object javaBean) throws IllegalArgumentException, IllegalAccessException,
			InvocationTargetException {
		Map<String, Object> map = new HashMap<String, Object>();
		Class<? extends Object> clas = javaBean.getClass();
		Method[] methods = clas.getMethods();
		if (methods == null || methods.length == 0) {
			return map;
		}
		for (Method method : methods) {
			if (method.getName().startsWith("get") || method.getName().startsWith("is")) {// 只处理get和is方法
				Object val = method.invoke(javaBean, new Object[] {});
				if (val == null || ((val instanceof String) && "".equals(((String) val).trim()))) {// null
					continue;
				}
				String propName = "";
				if (method.getName().startsWith("get")) {// 是get方法
					propName = method.getName().substring(3, method.getName().length());
				} else if (method.getName().startsWith("is")) {// is方法
					propName = method.getName().substring(2, method.getName().length());
				}
				if (propName.length() > 0) {
					propName = propName.substring(0, 1).toLowerCase() + propName.substring(1, propName.length());
				}
				// 获取值
				map.put(propName, val);
			}
		}

		return map;
	}

	private static void setUserAuthInfo(Map<String, Object> whereMap) {
		whereMap.put("AUTH_JOB_FUNCTION_ID", SessionHelper.getCurrentJobFunctionId());
		whereMap.put("AUTH_STAFF_NO", SessionHelper.getCurrentStaffNo());
	}
}
