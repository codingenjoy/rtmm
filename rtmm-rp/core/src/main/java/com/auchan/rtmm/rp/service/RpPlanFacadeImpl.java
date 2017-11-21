// license-header java merge-point
/**
 * This is only generated once! It will never be overwritten.
 * You can (and have to!) safely modify it by hand.
 * TEMPLATE:    SpringServiceImpl.vsl in andromda-spring cartridge
 * MODEL CLASS: Data::com.auchan.rtmm.rp.service::RpPlanFacade
 * STEREOTYPE:  Service
 */
package com.auchan.rtmm.rp.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.springframework.beans.BeanUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;

import rtmm.order.entity.Rp;
import rtmm.order.entity.RpItem;
import rtmm.order.entity.RpItemPK;

import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.common.session.SessionHelper;
import com.auchan.rtmm.common.utils.QueryUtil;
import com.auchan.rtmm.rp.vo.FindRpItemInfoVO;
import com.auchan.rtmm.rp.vo.FindRpStroeListVO;
import com.auchan.rtmm.rp.vo.RPDMInfoVO;
import com.auchan.rtmm.rp.vo.RpCond;
import com.auchan.rtmm.rp.vo.RpItemInfoVO;
import com.auchan.rtmm.rp.vo.RpItemVo;
import com.auchan.rtmm.rp.vo.RpStroeListVO;
import com.auchan.rtmm.rp.vo.RpVo;
import com.auchan.rtmm.rp.vo.SaveRPVO;

/**
 * @see com.auchan.rtmm.rp.service.RpPlanFacade
 */
public class RpPlanFacadeImpl
    extends RpPlanFacadeBase
{

    /**
     * @see com.auchan.rtmm.rp.service.RpPlanFacade#searchRpByPage(RpCond, PaginationSettings)
     */
    protected  PaginationResult handleSearchRpByPage(RpCond searchCond, PaginationSettings pageSet)
        throws Exception
    {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap = QueryUtil.inverBeanToMap(searchCond);
		BeanPropertyRowMapper<RpVo> beanPropertyRowMapper = new BeanPropertyRowMapper<RpVo>(
				RpVo.class);
		PaginationResult result = QueryUtil.serachPageData("rtmm", "rp",
				"rpPlan", "searchRpByPage", pageSet, whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return result;
    }

	@Override
	protected List<RPDMInfoVO> handleGetRPDMInfoByNo() throws Exception {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		BeanPropertyRowMapper<RPDMInfoVO> beanPropertyRowMapper = new BeanPropertyRowMapper<RPDMInfoVO>(
				RPDMInfoVO.class);
		@SuppressWarnings("unchecked")
		List<RPDMInfoVO> result = QueryUtil.serachDataList("rtmm", "rp", "rpPlan", "getRPDMInfoByNo", whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return result;
	}

	@Override
	protected List<RpItemInfoVO> handleFindRpItemInfo(FindRpItemInfoVO findRpItemInfoVoList)
			throws Exception {
		Map<String, Object> whereMap = QueryUtil.inverBeanToMap(findRpItemInfoVoList);
		BeanPropertyRowMapper<RpItemInfoVO> beanPropertyRowMapper = new BeanPropertyRowMapper<RpItemInfoVO>(
				RpItemInfoVO.class);
		@SuppressWarnings("unchecked")
		List<RpItemInfoVO> pr = QueryUtil.serachDataList("rtmm", "rp", "rpPlan", "findRpItemInfo", whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return pr;
	}

	@SuppressWarnings("unchecked")
	@Override
	protected List<RpStroeListVO> handleFindRpStroeList(FindRpStroeListVO findRpStroeListVo)
			throws Exception {
		Map<String, Object> whereMap = QueryUtil.inverBeanToMap(findRpStroeListVo);
		BeanPropertyRowMapper<RpStroeListVO> beanPropertyRowMapper = new BeanPropertyRowMapper<RpStroeListVO>(
				RpStroeListVO.class);
		List<RpStroeListVO> pr = QueryUtil.serachDataList("rtmm", "rp", "rpPlan", "findRpStroeList", whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		
		return pr;
	}

	@Override
	protected Integer handleGetRpNo() throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sql = QueryUtil.getDataSql("rtmm", "rp", "rpPlan", "getRpNo", paramMap);
		Integer rpNo = this.getNamedParameterJdbcTemplate().queryForInt(sql, paramMap);

		return rpNo;
	}

	@SuppressWarnings("unchecked")
	@Override
	protected SaveRPVO handleCreateRpAndItem(SaveRPVO saveRPVo)
			throws Exception {
		
		if(saveRPVo.getRpVo() == null || saveRPVo.getRpItemVo() == null 
				|| saveRPVo.getRpItemVo().isEmpty())
		{
			return null;
		}
		
		//get rpNo
		Integer rpNo = this.handleGetRpNo();
		
		saveRPVo.setRpNo(rpNo);
		
		String curDate = parseDate2Str(new Date(), "yyyy-MM-dd");
		
		saveRPVo.getRpVo().setRpNo(rpNo);
		saveRPVo.getRpVo().setStatus(0);
		saveRPVo.getRpVo().setFinalAmnt(0.0);
		saveRPVo.getRpVo().setCreatBy(SessionHelper.getCurrentStaffNo());
		saveRPVo.getRpVo().setCreatDate(parseDate(curDate));
		saveRPVo.getRpVo().setChngBy(SessionHelper.getCurrentStaffNo());
		saveRPVo.getRpVo().setChngDate(parseDate(curDate));
		
		for(RpItemVo rpItemVo : (List<RpItemVo>)saveRPVo.getRpItemVo())
		{
			rpItemVo.setRpNo(rpNo);
			rpItemVo.setCreatBy(SessionHelper.getCurrentStaffNo());
			rpItemVo.setCreatDate(parseDate(curDate));
			rpItemVo.setChngBy(SessionHelper.getCurrentStaffNo());
			rpItemVo.setChngDate(parseDate(curDate));
		}
		
		this.handleCreateRp(saveRPVo.getRpVo());
		this.handleCreateRpItem(saveRPVo.getRpItemVo());
		
		return saveRPVo;
	}
	
	private RpVo handleCreateRp(RpVo rpVo)
	{
		Rp rp =  Rp.Factory.newInstance();
		BeanUtils.copyProperties(rpVo, rp);
		this.getRpDao().create(rp);
		return rpVo;
	}
	
	private List<RpItemVo> handleCreateRpItem(List<RpItemVo> rpItemVoList)
	{
		List<RpItem> rpItemList = new ArrayList<RpItem>();
		for (RpItemVo vo : rpItemVoList) {
			RpItem rpItem = RpItem.Factory.newInstance();
			BeanUtils.copyProperties(vo, rpItem, new String[] { "rpNo", "itemNo", "storeNo" });
			RpItemPK pk = new RpItemPK();
			pk.setRpNo(vo.getRpNo());
			pk.setStoreNo(vo.getStoreNo());
			pk.setItemNo(vo.getItemNo());
			rpItem.setRpItemPk(pk);
			rpItemList.add(rpItem);
		}
		this.getRpItemDao().create(rpItemList);
		return rpItemVoList;
	}
	
	private Date parseDate(String s) throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return format.parse(s);
	}
	
	private String parseDate2Str(Date date, String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}

	@Override
	protected List<RpItemVo> handleFindExistedRpItemInfo(Integer rpNo) throws Exception {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("rpNo", rpNo);
		BeanPropertyRowMapper<RpItemVo> beanPropertyRowMapper = new BeanPropertyRowMapper<RpItemVo>(
				RpItemVo.class);
		@SuppressWarnings("unchecked")
		List<RpItemVo> result = QueryUtil.serachDataList("rtmm", "rp", "rpPlan",
				"findExistedRpItemInfo", whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return result;
	}

	@SuppressWarnings("unchecked")
	@Override
	protected List<RpVo> handleFindRpBasicInfo(Integer rpNo) throws Exception {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("rpNo", rpNo);
		BeanPropertyRowMapper<RpVo> beanPropertyRowMapper = new BeanPropertyRowMapper<RpVo>(
				RpVo.class);
		List<RpVo> result = QueryUtil.serachDataList("rtmm", "rp", "rpPlan",
				"findRpBasicInfo", whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return result; 
	}

	@Override
	protected void handleDeleteRp(Integer rpNo) throws Exception {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("rpNo", rpNo);
		String deleteRpSql=QueryUtil.getDataSql("rtmm", "rp", "rpPlan", "deleteRp", whereMap);
		this.getNamedParameterJdbcTemplate().update(deleteRpSql, whereMap);
		String deleteRpItemSql=QueryUtil.getDataSql("rtmm", "rp", "rpPlan", "deleteRpItem", whereMap);
		this.getNamedParameterJdbcTemplate().update(deleteRpItemSql, whereMap);
		
	}

	@SuppressWarnings("unchecked")
	@Override
	protected SaveRPVO handleUpdateRpAndItem(SaveRPVO saveRpVo)
			throws Exception {
		
		if(saveRpVo.getRpVo() == null || saveRpVo.getRpItemVo() == null 
				|| saveRpVo.getRpItemVo().isEmpty() || saveRpVo.getRpNo() == null 
				|| saveRpVo.getItemNoList() == null || saveRpVo.getItemNoList().isEmpty())
		{
			return null;
		}
		Integer rpNo = saveRpVo.getRpNo();
		
		String curDate = parseDate2Str(new Date(), "yyyy-MM-dd");
		
		saveRpVo.getRpVo().setCreatBy(SessionHelper.getCurrentStaffNo());
		saveRpVo.getRpVo().setCreatDate(parseDate(curDate));
		saveRpVo.getRpVo().setChngBy(SessionHelper.getCurrentStaffNo());
		saveRpVo.getRpVo().setChngDate(parseDate(curDate));
		
		for(RpItemVo rpItemVo : (List<RpItemVo>)saveRpVo.getRpItemVo())
		{
			rpItemVo.setRpNo(rpNo);
			rpItemVo.setCreatBy(SessionHelper.getCurrentStaffNo());
			rpItemVo.setCreatDate(parseDate(curDate));
			rpItemVo.setChngBy(SessionHelper.getCurrentStaffNo());
			rpItemVo.setChngDate(parseDate(curDate));
		}
		
		this.handleSaveRp(saveRpVo.getRpVo());
		this.handleSaveRpItem(saveRpVo.getRpItemVo(), rpNo, saveRpVo.getItemNoList());
		return null;
	}
	
	private RpVo handleSaveRp(RpVo rpVo)
	{
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("rpNo", rpVo.getRpNo());
		whereMap.put("stCnfrmInd", rpVo.getStCnfrmInd());
		whereMap.put("stCnfrmBeginDate", rpVo.getStCnfrmBeginDate());
		whereMap.put("stCnfrmEndDate", rpVo.getStCnfrmEndDate());
		whereMap.put("stRepBeginDate", rpVo.getStRepBeginDate());
		whereMap.put("stRepEndDate", rpVo.getStRepEndDate());
		whereMap.put("chngDate", rpVo.getChngDate());
		whereMap.put("chngBy", rpVo.getChngBy());

		String sql = QueryUtil.getDataSql("rtmm", "rp", "rpPlan",
				"updateRp", whereMap);
		this.getNamedParameterJdbcTemplate().update(sql, whereMap);
		return rpVo;
	}
	
	private List<RpItemVo> handleSaveRpItem(List<RpItemVo> rpItemVoList,
			Integer rpNo,List<Integer> itemNoList)
	{

		Set<RpItemVo> sourceList = new HashSet<RpItemVo>(
				this.getRpItemByRpNo(rpNo, itemNoList));
		Set<RpItemVo> targetList = new HashSet<RpItemVo>(
				rpItemVoList);
		List<RpItemVo> result = new ArrayList<RpItemVo>();
		// updatelist
		Set<RpItemVo> updateVO = new HashSet<RpItemVo>();
		// createlist
		Set<RpItemVo> addVO = new HashSet<RpItemVo>();
		for (RpItemVo target : targetList) {
			boolean isAdd = true;

			for (RpItemVo source : sourceList) {
				if (new EqualsBuilder()
						.append(source.getStoreNo(), target.getStoreNo())
						.append(source.getRpNo(), target.getRpNo())
						.append(source.getItemNo(), target.getItemNo())
						.isEquals()) {
					target.setCreatBy(source.getCreatBy());
					target.setCreatDate(source.getCreatDate());
					isAdd = false;
					break;
				}
			}
			if (isAdd) {
				addVO.add(target);
			} else {
				updateVO.add(target);
			}
		}

		// save HoOrderItemInfo
		for (RpItemVo createRpItemVo : addVO) {

			RpItem rpItem = RpItem.Factory.newInstance();
			BeanUtils.copyProperties(createRpItemVo, rpItem, new String[] { "rpNo", "itemNo", "storeNo" });
			RpItemPK pk = new RpItemPK();
			pk.setRpNo(createRpItemVo.getRpNo());
			pk.setStoreNo(createRpItemVo.getStoreNo());
			pk.setItemNo(createRpItemVo.getItemNo());
			rpItem.setRpItemPk(pk);
			this.getRpItemDao().create(rpItem);
			result.add(createRpItemVo);
		}

		// update HoOrderItemInfo
		for (RpItemVo updateRpItemVo : updateVO) {

			RpItem rpItem = RpItem.Factory.newInstance();
			BeanUtils.copyProperties(updateRpItemVo, rpItem, new String[] { "rpNo", "itemNo", "storeNo" });
			RpItemPK pk = new RpItemPK();
			pk.setRpNo(updateRpItemVo.getRpNo());
			pk.setStoreNo(updateRpItemVo.getStoreNo());
			pk.setItemNo(updateRpItemVo.getItemNo());
			rpItem.setRpItemPk(pk);
			this.getRpItemDao().update(rpItem);
			result.add(updateRpItemVo);
		}

		// deletelist
		Set<RpItemPK> delRpItem = new HashSet<RpItemPK>();

		for (RpItemVo source : sourceList) {
			boolean isDelete = true;
			for (RpItemVo target : targetList) {
				if (new EqualsBuilder()
						.append(source.getStoreNo(), target.getStoreNo())
						.append(source.getRpNo(), target.getRpNo())
						.append(source.getItemNo(), target.getItemNo())
						.isEquals()) {
					isDelete = false;
					break;
				}
			}
			if (isDelete) {

				delRpItem.add(new RpItemPK(source.getStoreNo(), source
						.getRpNo(), source.getItemNo()));
			}
		}
		for (RpItemPK rpItem : delRpItem) {
			this.getRpItemDao().remove(rpItem);;
		}

		return result;
	}
	
	@SuppressWarnings("unchecked")
	private List<RpItemVo> getRpItemByRpNo(
			Integer rpNo, List<Integer> itemNoList) {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("rpNo", rpNo);
		whereMap.put("includeItems", itemNoList);
		BeanPropertyRowMapper<RpItemVo> beanPropertyRowMapper = new BeanPropertyRowMapper<RpItemVo>(
				RpItemVo.class);
		List<RpItemVo> voDetailList = QueryUtil.serachDataList(
				"rtmm", "rp", "rpPlan", "updateRpItem", whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return voDetailList;
	}

}