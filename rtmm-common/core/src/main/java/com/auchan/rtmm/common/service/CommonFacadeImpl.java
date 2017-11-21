// license-header java merge-point
/**
 * This is only generated once! It will never be overwritten.
 * You can (and have to!) safely modify it by hand.
 * TEMPLATE:    SpringServiceImpl.vsl in andromda-spring cartridge
 * MODEL CLASS: Data::com.auchan.rtmm.common.service::CommonFacade
 * STEREOTYPE:  Service
 */
package com.auchan.rtmm.common.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;

import rtmm.apprvPrcss.Task;

import com.auchan.common.codetable.vo.MetaDataVO;
import com.auchan.common.security.SessionKeyStore;
import com.auchan.common.security.enums.SESSION_NAMED_FILEDS;
import com.auchan.common.security.enums.SYS_LANG;
import com.auchan.common.security.session.SessionAccessFacade;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.common.utils.QueryUtil;
import com.auchan.rtmm.common.vo.BankBranchVO;
import com.auchan.rtmm.common.vo.BankVO;
import com.auchan.rtmm.common.vo.CatalogSimpleVO;
import com.auchan.rtmm.common.vo.ClCatalogVO;
import com.auchan.rtmm.common.vo.ItemBasicSimpleVO;
import com.auchan.rtmm.common.vo.RegionVO;
import com.auchan.rtmm.common.vo.SearchTaskVO;
import com.auchan.rtmm.common.vo.SupplierSimpleVO;
import com.auchan.rtmm.common.vo.TaskVO;
import com.auchan.rtmm.common.vo.VatVO;

/**
 * @see com.auchan.rtmm.common.service.CommonFacade
 */
public class CommonFacadeImpl extends CommonFacadeBase {

	/**
	 * @see com.auchan.rtmm.common.service.CommonFacade#getAuchanAreaList()
	 */
	protected List handleGetAuchanAreaList() throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sql = QueryUtil.getDataSql("rtmm", "common", "getAuchanAreaList", "query_data", paramMap);
		BeanPropertyRowMapper<RegionVO> beanPropertyRowMapper = new BeanPropertyRowMapper<RegionVO>(RegionVO.class);
		return this.getNamedParameterJdbcTemplate().query(sql, paramMap, beanPropertyRowMapper);
	}

	/**
	 * @see com.auchan.rtmm.common.service.CommonFacade#getBankList()
	 */
	protected List handleGetBankList() throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sql = QueryUtil.getDataSql("rtmm", "common", "getBankList", "query_data", paramMap);
		BeanPropertyRowMapper<BankVO> beanPropertyRowMapper = new BeanPropertyRowMapper<BankVO>(BankVO.class);
		return this.getNamedParameterJdbcTemplate().query(sql, paramMap, beanPropertyRowMapper);
	}

	/**
	 * @see com.auchan.rtmm.common.service.CommonFacade#getBankBranchList(Integer)
	 */
	protected List handleGetBankBranchList(Integer bankId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bankId", bankId);
		String sql = QueryUtil.getDataSql("rtmm", "common", "getBankBranchList", "query_data", paramMap);
		BeanPropertyRowMapper<BankBranchVO> beanPropertyRowMapper = new BeanPropertyRowMapper<BankBranchVO>(BankBranchVO.class);
		return this.getNamedParameterJdbcTemplate().query(sql, paramMap, beanPropertyRowMapper);
	}

	@SuppressWarnings("rawtypes")
	private List getStandAreaList(String lvl, Integer parentAssrtId) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("lvl", lvl);
		paramMap.put("parentAssrtId", parentAssrtId);
		String sql = QueryUtil.getDataSql("rtmm", "common", "getStandAreaList", "query_data", paramMap);
		BeanPropertyRowMapper<RegionVO> beanPropertyRowMapper = new BeanPropertyRowMapper<RegionVO>(RegionVO.class);
		return this.getNamedParameterJdbcTemplate().query(sql, paramMap, beanPropertyRowMapper);
	}

	@Override
	protected List handleGetProvinceList() throws Exception {
		return getStandAreaList("3", null);
	}

	@Override
	protected List handleGetCityList(Integer parentAssrtId) throws Exception {
		return getStandAreaList("4", parentAssrtId);
	}

	@Override
	protected PaginationResult handleSearchTaskPage(SearchTaskVO searchTaskVO, PaginationSettings pageSettings) throws Exception {
		Map<String, Object> paramMap = QueryUtil.inverBeanToMap(searchTaskVO);
		BeanPropertyRowMapper<TaskVO> beanPropertyRowMapper = new BeanPropertyRowMapper<TaskVO>(TaskVO.class);
		PaginationResult pr = QueryUtil.serachPageData("rtmm", "common", "searchTaskPage", "query_data", pageSettings, paramMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return pr;
	}

	@Override
	protected List handleGetVatList() throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		BeanPropertyRowMapper<VatVO> beanPropertyRowMapper = new BeanPropertyRowMapper<VatVO>(VatVO.class);
		String sql = QueryUtil.getDataSql("rtmm", "common", "getVatList", "query_data", paramMap);
		return this.getNamedParameterJdbcTemplate().query(sql, paramMap, beanPropertyRowMapper);
	}

	@Override
	protected void handleSubmitTask2Audit(Integer taskId,String prcssId) throws Exception {
		Task task = this.getTaskDao().get(taskId);
		task.setTaskSttus(1);
		task.setPrcssId(prcssId);
		this.getTaskDao().update(task);
	}

	@Override
	protected void handleDoTaskAudit(Integer taskId, Integer auditStatus) throws Exception {
		Task task = this.getTaskDao().get(taskId);
		if (task.getTaskType() == 4) {
			doAuditItemCreate(taskId,auditStatus);
		} else if (task.getTaskType() == 8 || task.getTaskType() == 9 || task.getTaskType() == 10) {
			doAuditItemCreate(taskId,auditStatus);
		}
	}

	protected Boolean doAuditItemSup(Integer taskId,Integer auditStatus) throws Exception {
		org.hibernate.classic.Session session = this.getTaskDao().getTemplate().getSessionFactory().getCurrentSession();
		Connection conn = session.connection();
		CallableStatement st = null;
		// 生成存储过程名
		StringBuilder procName = new StringBuilder("{ call pkg_item_audit.item_sup_audit(?,?) }");
		st = conn.prepareCall(procName.toString());
		st.setObject(1, taskId, java.sql.Types.INTEGER);
		st.setObject(2, auditStatus, java.sql.Types.INTEGER);
		st.execute();
		return true;
	}

	protected Boolean doAuditItemCreate(Integer taskId,Integer auditStatus) throws Exception {
		org.hibernate.classic.Session session = this.getTaskDao().getTemplate().getSessionFactory().getCurrentSession();
		Connection conn = session.connection();
		CallableStatement st = null;
		// 生成存储过程名
		StringBuilder procName = new StringBuilder("{ call pkg_item_audit.item_create_audit(?,?) }");
		st = conn.prepareCall(procName.toString());
		st.setObject(1, taskId, java.sql.Types.INTEGER);
		st.setObject(2, auditStatus, java.sql.Types.INTEGER);
		st.execute();
		return true;
	}

	@Override
	protected List handleGetDivisionList() throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		BeanPropertyRowMapper<ClCatalogVO> beanPropertyRowMapper = new BeanPropertyRowMapper<ClCatalogVO>(ClCatalogVO.class);
		String sql = QueryUtil.getDataSql("rtmm", "common", "getDivisionList", "query_data", paramMap);
		return this.getNamedParameterJdbcTemplate().query(sql, paramMap, beanPropertyRowMapper);
	}

	@Override
	protected List handleGetSectionListByDivision(Integer divisionId,List statusList) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("divisionId", divisionId);
		if (statusList != null && statusList.size() > 0) {
			paramMap.put("statusList", statusList);
		}
		BeanPropertyRowMapper<ClCatalogVO> beanPropertyRowMapper = new BeanPropertyRowMapper<ClCatalogVO>(ClCatalogVO.class);
		String sql = QueryUtil.getDataSql("rtmm", "common", "getSectionListByDivision", "query_data", paramMap);
		return this.getNamedParameterJdbcTemplate().query(sql, paramMap, beanPropertyRowMapper);
	}

	@Override
	protected List handleGetStoreCountByArea() throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sql = QueryUtil.getDataSql("rtmm", "common", "getStoreCountByArea", "query_data", paramMap);
		return this.getNamedParameterJdbcTemplate().queryForList(sql, paramMap);
	}

	@Override
	protected TaskVO handleGetTaskById(Integer taskId) throws Exception {
		Task task = this.getTaskDao().get(taskId);
		TaskVO taskVO = new TaskVO();
		BeanUtils.copyProperties(task, taskVO);
		return taskVO;
	}
	
	@Override
	protected List handleReadSupInfoBySupNo(Integer supNo, Integer catlgId,String comName) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("supNo", supNo);
		paramMap.put("catlgId", catlgId);
		paramMap.put("comName", comName);
		BeanPropertyRowMapper<SupplierSimpleVO> beanPropertyRowMapper = new BeanPropertyRowMapper<SupplierSimpleVO>(SupplierSimpleVO.class);
		String sql = QueryUtil.getDataSql("rtmm", "common", "supNo", "readSupInfoBySupNo", paramMap);
		return this.getNamedParameterJdbcTemplate().query(sql, paramMap, beanPropertyRowMapper);
	}
	
	@Override
	protected List handleReadItemInfoBySecNoAndItemNo(Integer itemNo, Integer secNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("itemNo", itemNo);
		paramMap.put("secNo", secNo);
		BeanPropertyRowMapper<ItemBasicSimpleVO> beanPropertyRowMapper = new BeanPropertyRowMapper<ItemBasicSimpleVO>(ItemBasicSimpleVO.class);
		String sql = QueryUtil.getDataSql("rtmm", "common", "secNo", "readItemInfoBySecNoAndItemNo", paramMap);
		return this.getNamedParameterJdbcTemplate().query(sql, paramMap, beanPropertyRowMapper);
	}
	
	@Override
	protected List handleReadCatalogInfoBySecNo(Integer secNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("secNo", secNo);
		BeanPropertyRowMapper<CatalogSimpleVO> beanPropertyRowMapper = new BeanPropertyRowMapper<CatalogSimpleVO>(CatalogSimpleVO.class);
		String sql = QueryUtil.getDataSql("rtmm", "common", "catalogId", "readCatalogInfoBySecNo", paramMap);
		return this.getNamedParameterJdbcTemplate().query(sql, paramMap, beanPropertyRowMapper);
	}

	@Override
	protected List handleGetMetaDataList(String mdgroup) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("mdgroup", mdgroup);
		BeanPropertyRowMapper<MetaDataVO> beanPropertyRowMapper = new BeanPropertyRowMapper<MetaDataVO>(MetaDataVO.class);
		String sql = QueryUtil.getDataSql("rtmm", "common", "getMetaDataList", "query_data", paramMap);
		List<MetaDataVO> list = this.getNamedParameterJdbcTemplate().query(sql, paramMap, beanPropertyRowMapper);
		String lang = (String) SessionAccessFacade.getInstance().getValue(SessionKeyStore.get(), SESSION_NAMED_FILEDS.LANG.getValue());
		for (MetaDataVO dataVO : list) {
			if (SYS_LANG.EN.getValue().equals(lang)) {
				dataVO.setTitle(dataVO.getE_desc());
			} else if (SYS_LANG.FR.getValue().equals(lang)) {
				dataVO.setTitle(dataVO.getF_desc());
			} else {
				dataVO.setTitle(dataVO.getL_desc());
			}
		}
		return list;
	}
	
}