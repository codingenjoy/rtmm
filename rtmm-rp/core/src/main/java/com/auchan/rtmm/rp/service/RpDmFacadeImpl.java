// license-header java merge-point
/**
 * This is only generated once! It will never be overwritten.
 * You can (and have to!) safely modify it by hand.
 * TEMPLATE:    SpringServiceImpl.vsl in andromda-spring cartridge
 * MODEL CLASS: Data::com.auchan.rtmm.rp.service::RpDmFacade
 * STEREOTYPE:  Service
 */
package com.auchan.rtmm.rp.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import rtmm.order.entity.RpDm;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.common.session.SessionHelper;
import com.auchan.rtmm.common.utils.BeanUtils;
import com.auchan.rtmm.common.utils.QueryUtil;
import com.auchan.rtmm.rp.vo.RpDmCond;
import com.auchan.rtmm.rp.vo.RpDmVo;

/**
 * @see com.auchan.rtmm.rp.service.RpDmFacade
 */
public class RpDmFacadeImpl extends RpDmFacadeBase {

	/**
	 * query the rp_dm lists.
	 */
	@Override
	protected PaginationResult handleSearchRpDmByPage(RpDmCond searchCond,
			PaginationSettings pageSet) throws Exception {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap = QueryUtil.inverBeanToMap(searchCond);
		BeanPropertyRowMapper<RpDmVo> beanPropertyRowMapper = new BeanPropertyRowMapper<RpDmVo>(
				RpDmVo.class);
		PaginationResult result = QueryUtil.serachPageData("rtmm", "rp",
				"rpDm", "searchRpDmByPage", pageSet, whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return result;
	}

	/**
	 * create the rp_dm.
	 */
	@Override
	protected void handleCreateRpDm(RpDmVo rpDmVo) throws Exception {
		RpDm rpDm = RpDm.Factory.newInstance();
		BeanUtils.copyProperties(rpDmVo, rpDm, new String[] { "rdmNo" });
		rpDm.setCreatBy(SessionHelper.getCurrentStaffNo());
		rpDm.setCreatDate(new Date());
		rpDm.setChngBy(SessionHelper.getCurrentStaffNo());
		rpDm.setChngDate(new Date());
		this.getRpDmDao().create(rpDm);
	}

	/**
	 * update the rp_dm.
	 */
	@Override
	protected void handleUpdateRpDm(RpDmVo rpDmVo) throws Exception {
		RpDm rpDm = RpDm.Factory.newInstance();
		BeanUtils.copyProperties(rpDmVo, rpDm);
		rpDm.setChngBy(SessionHelper.getCurrentStaffNo());
		rpDm.setChngDate(new Date());
		this.getRpDmDao().update(rpDm);
	}

	@Override
	protected RpDmVo handleFindRpDmInfoByRpDmNo(Integer rdmNo) throws Exception {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("rdmNo", rdmNo);
		BeanPropertyRowMapper<RpDmVo> beanPropertyRowMapper = new BeanPropertyRowMapper<RpDmVo>(
				RpDmVo.class);
		@SuppressWarnings("unchecked")
		List<RpDmVo> result = QueryUtil.serachDataList("rtmm", "rp", "rpDm",
				"findRpDmInfoByRpDmNo", whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return (result == null || result.isEmpty()) ? null : result.get(0);
	}

	@Override
	protected void handleDeleteRpDm(Integer rdmNo) throws Exception {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("rdmNo", rdmNo);
		String deleteSql=QueryUtil.getDataSql("rtmm", "rp", "rpDm", "deleteRpDm", whereMap);
		this.getNamedParameterJdbcTemplate().update(deleteSql, whereMap);
	}

}