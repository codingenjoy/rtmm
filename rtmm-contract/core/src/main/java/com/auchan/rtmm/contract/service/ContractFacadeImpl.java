// license-header java merge-point
/**
 * This is only generated once! It will never be overwritten.
 * You can (and have to!) safely modify it by hand.
 * TEMPLATE:    SpringServiceImpl.vsl in andromda-spring cartridge
 * MODEL CLASS: Data::com.auchan.rtmm.contract.service::ContractFacade
 * STEREOTYPE:  Service
 */
package com.auchan.rtmm.contract.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.springframework.jdbc.core.BeanPropertyRowMapper;

import rtmm.contract.entity.Contract;
import rtmm.contract.entity.ContractAudit;
import rtmm.contract.entity.ContractDetailAudit;

import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.common.session.SessionHelper;
import com.auchan.rtmm.common.utils.BeanUtils;
import com.auchan.rtmm.common.utils.DateUtils;
import com.auchan.rtmm.common.utils.QueryUtil;
import com.auchan.rtmm.contract.vo.BuyerVO;
import com.auchan.rtmm.contract.vo.CatlgVO;
import com.auchan.rtmm.contract.vo.ContractCond;
import com.auchan.rtmm.contract.vo.ContractDetailVO;
import com.auchan.rtmm.contract.vo.ContractVO;
import com.auchan.rtmm.contract.vo.RichContractVO;
import com.auchan.rtmm.contract.vo.SupCond;
import com.auchan.rtmm.contract.vo.SupVO;

/**
 * @see com.auchan.rtmm.contract.service.ContractFacade
 */
public class ContractFacadeImpl extends ContractFacadeBase {
	
	@Override
	protected void handleCreateContract(ContractVO contractVo)
			throws Exception {
		
		//1.保存合同主档信息
//		//1.1.生成cntrtId
//		Long cntrtId = this.generateContractId(contractVo);
		ContractAudit contract = ContractAudit.Factory.newInstance();
		BeanUtils.copyProperties(contractVo, contract);
		contract.setCreatBy(SessionHelper.getCurrentStaffNo());
		contract.setCreatDate(new Date());
		contract.setCreatBy(SessionHelper.getCurrentStaffNo());
		contract.setChngDate(new Date());
		contract.setValidStartDate(DateUtils.getCurrYearFirst());
		contract.setValidEndDate(DateUtils.getCurrYearLast());
		this.getContractAuditDao().create(contract);
		
		//2.保存合同明细列表
		@SuppressWarnings("unchecked")
		List<ContractDetailVO> detailVoList = contractVo.getDetailList();
		int rankIdex = 1;
		for(ContractDetailVO detailVo : detailVoList){
			ContractDetailAudit  detail = ContractDetailAudit.Factory.newInstance();
			BeanUtils.copyProperties(detailVo, detail);
			detail.setCntrtDetlId(contract.getCntrtId()*100+rankIdex++);//明细主键规则合同号*100+序号
			detail.setCntrtId(contract.getCntrtId());
			detail.setYear(contract.getYear());
			detail.setVatNo(contract.getSupVatNo() != null ? contract.getSupVatNo() : 0);
			detail.setCreatBy(SessionHelper.getCurrentStaffNo());
			detail.setCreatDate(new Date());
			detail.setCreatBy(SessionHelper.getCurrentStaffNo());
			detail.setChngDate(new Date());
			this.getContractDetailAuditDao().create(detail);
		}
		//3.为方便数据迁移，新增数据到CONTRI_SUP_CON_ACCT
		
		
	}

	@Override
	protected ContractVO handleGetContractByCntrtId(Long cntrtId)
			throws Exception {
		//1.读取合同主档信息
		Contract contract = this.getContractDao().get(cntrtId);
		ContractVO contractVO = new ContractVO();
		BeanUtils.copyProperties(contract, contractVO);
		return contractVO;
	}

	@Override
	protected List<ContractDetailVO> handleFindContractDetailByCntrtIdAndTabType(Long cntrtId,
			Integer tabType) throws Exception {
		/*Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("tabType", tabType);
		paramMap.put("cntrtId", cntrtId);
		String sql = QueryUtil.getDataSql("rtmm", "contract", "history", "findContractDetailByTabType", paramMap);
		BeanPropertyRowMapper<ContractDetailVO> beanPropertyRowMapper = new BeanPropertyRowMapper<ContractDetailVO>(ContractDetailVO.class);
		return this.getNamedParameterJdbcTemplate().query(sql, paramMap, beanPropertyRowMapper);*/
		ContractCond searchCond  = new ContractCond();
		searchCond.setTabType(tabType);
		searchCond.setCntrtId(cntrtId);
		return this.searchDetailAndGrpAucct(searchCond);
	}

	@Override
	protected List<ContractDetailVO> handleFindContractDetailByCntrtIdAndTabId(Long cntrtId,
			Integer tabId) throws Exception {
		ContractCond searchCond  = new ContractCond();
		searchCond.setTabId(tabId);
		searchCond.setCntrtId(cntrtId);
		return this.searchDetailAndGrpAucct(searchCond);
	}

	@Override
	protected PaginationResult handleSerarchContractByPage(
			ContractCond searchCond, PaginationSettings pageSet)
			throws Exception {
		Map<String, Object> whereMap = QueryUtil.inverBeanToMap(searchCond);
		BeanPropertyRowMapper<RichContractVO> beanPropertyRowMapper = new BeanPropertyRowMapper<RichContractVO>(RichContractVO.class);
		PaginationResult pr = QueryUtil.serachPageData("rtmm", "contract", "history", "serarchContract", pageSet, whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return pr;
	}

	@Override
	protected PaginationResult handleSearchCurrentYearContractByPage(
			ContractCond searchCond, PaginationSettings pageSet)
			throws Exception {
		searchCond.setYear(DateUtils.getCurrYear());
		return this.handleSerarchContractByPage(searchCond, pageSet);
	}

	@Override
	protected PaginationResult handleSerarchContractDetailByPage(
			ContractCond searchCond, PaginationSettings pageSet)
			throws Exception {
		Map<String, Object> whereMap = QueryUtil.inverBeanToMap(searchCond);
		BeanPropertyRowMapper<ContractDetailVO> beanPropertyRowMapper = new BeanPropertyRowMapper<ContractDetailVO>(ContractDetailVO.class);
		PaginationResult pr = QueryUtil.serachPageData("rtmm", "contract", "history", "serarchContractDetail", pageSet, whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		
		return pr;
	}

	@Override
	protected Boolean handleIsBuyer(String staffNo) throws Exception {
		Map<String,Object> whereMap = new HashMap<String,Object>();
		whereMap.put("staffNo", staffNo);
		BeanPropertyRowMapper<Object> beanPropertyRowMapper = new BeanPropertyRowMapper<Object>(Object.class);
		@SuppressWarnings("unchecked")
		List<Object> voList = QueryUtil.serachDataList("rtmm", "contract", "search", "isBuyer", whereMap, 
												this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return (voList != null && voList.size() >0);
		 
	}

	@Override
	protected List<BuyerVO> handleFindBuyerBySupNoAndCatlgId(Integer supNo, Integer catlgId)
			throws Exception {
		Map<String,Object> whereMap = new HashMap<String,Object>();
		whereMap.put("supNo", supNo);
		whereMap.put("catlgId", catlgId);
		BeanPropertyRowMapper<BuyerVO> beanPropertyRowMapper = new BeanPropertyRowMapper<BuyerVO>(BuyerVO.class);
		@SuppressWarnings("unchecked")
		List<BuyerVO> voList = QueryUtil.serachDataList("rtmm", "contract", "search", "getBuyerList", whereMap, 
												this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return voList;
	}

	@Override
	protected PaginationResult handleChooseLinkMainSupByPage(
			PaginationSettings pageSet, SupCond supCond) throws Exception {
		Map<String, Object> paramMap = QueryUtil.inverBeanToMap(supCond);
		BeanPropertyRowMapper<SupVO> beanPropertyRowMapper = new BeanPropertyRowMapper<SupVO>(SupVO.class);
		PaginationResult pr = QueryUtil.serachPageData("rtmm", "contract", "search", "searchLinkMainSup", pageSet, paramMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return pr;
	}


	@Override
	protected List<CatlgVO> handleFindCatlgBySupNo(Integer supNo) throws Exception {
		Map<String,Object> whereMap = new HashMap<String,Object>();
		whereMap.put("supNo", supNo);
		BeanPropertyRowMapper<CatlgVO> beanPropertyRowMapper = new BeanPropertyRowMapper<CatlgVO>(CatlgVO.class);
		@SuppressWarnings("unchecked")
		List<CatlgVO> voList = QueryUtil.serachDataList("rtmm", "contract", "search", "findCatlgBySupNo", whereMap, 
												this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return voList;
	}

	@Override
	protected void handleUpdateContractAudit(ContractVO contractVO)
			throws Exception {
		ContractAudit pojo = this.getContractAuditDao().get(contractVO.getCntrtId());
		BeanUtils.copyProperties(contractVO, pojo);
		pojo.setChngBy(SessionHelper.getCurrentStaffNo());
		pojo.setChngDate(new Date());
		@SuppressWarnings("unchecked")
		List<ContractDetailVO> detailVoList = contractVO.getDetailList();
		for(ContractDetailVO detailVo :detailVoList){
			ContractDetailAudit detail = this.getContractDetailAuditDao().get(detailVo.getCntrtDetlId());
			BeanUtils.copyProperties(detailVo, detail);
			detail.setChngBy(SessionHelper.getCurrentStaffNo());
			detail.setChngDate(new Date());
			this.getContractDetailAuditDao().update(detail);
		}
		this.getContractAuditDao().update(pojo);
	}

	@Override
	protected PaginationResult handleSearchContractAuditByPage(
			ContractCond searchCond, PaginationSettings pageSet)
			throws Exception {
		Map<String, Object> whereMap = QueryUtil.inverBeanToMap(searchCond);
		BeanPropertyRowMapper<RichContractVO> beanPropertyRowMapper = new BeanPropertyRowMapper<RichContractVO>(RichContractVO.class);
		PaginationResult pr = QueryUtil.serachPageData("rtmm", "contract", "history", "serarchContractAudit", pageSet, whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return pr;
	}


	@Override
	protected Boolean handleIsExistsContractBySupNoAndCatlgId(Integer supNo,
			Integer catlgId) throws Exception {
		org.hibernate.classic.Session session = this.getContractDao().getTemplate().getSessionFactory().getCurrentSession();
		SQLQuery query = session.createSQLQuery(
							  " select * from contract t where 1=1 and t.YEAR = to_char(sysdate,'yyyy') "
							+ "	and t.SUP_NO = :supNo and t.CATLG_ID = :catlgId ");
		query.setParameter("supNo", supNo);
		query.setParameter("catlgId", catlgId);
		
		int i = query.executeUpdate();
		return i>0;
	}

	@Override
	protected List<ContractDetailVO> handleFindContractDetailBySupNoAndItemId(Integer supNo,
			Integer itemId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String,Object>();
		paramMap.put("supNo", supNo);
		paramMap.put("itemId", itemId);
		String sql = QueryUtil.getDataSql("rtmm", "contract", "search", "findContractDetail", paramMap);
		BeanPropertyRowMapper<ContractDetailVO> beanPropertyRowMapper = new BeanPropertyRowMapper<ContractDetailVO>(ContractDetailVO.class);
		return this.getNamedParameterJdbcTemplate().query(sql, paramMap, beanPropertyRowMapper);
	}

	protected List<ContractDetailVO> searchDetailAndGrpAucct(ContractCond searchCond) throws Exception {
		Map<String, Object> paramMap = QueryUtil.inverBeanToMap(searchCond);
		String sql = QueryUtil.getDataSql("rtmm", "contract", "search", "serarchDetailGrpAcct", paramMap);
		BeanPropertyRowMapper<ContractDetailVO> beanPropertyRowMapper = new BeanPropertyRowMapper<ContractDetailVO>(ContractDetailVO.class);
		return this.getNamedParameterJdbcTemplate().query(sql, paramMap, beanPropertyRowMapper);
	}
	protected Long generateContractId(ContractVO contractVo) throws Exception {
		//YY || 'D' || 'CCC' || 'SSSSSSS'
		/*YY: 两位的年份，如14
		D: 处别的ID
		CCC：课别的ID
		SSSSSSS：7位的厂商编号*/
		int year = (DateUtils.getCurrYear())%1000;
		String divsion = "";
		String section = contractVo.getCatlgId().toString();
		String supNo = contractVo.getSupNo().toString();
		Long contractId = Long.parseLong(year+divsion+section+supNo);
		return contractId;
	}
	

	protected List<SupVO> handleChooseLinkMainSup() throws Exception {
		Map<String, Object> paramMap = new HashMap<String,Object>();
		String sql = QueryUtil.getDataSql("rtmm", "contract", "search", "searchLinkMainSup", paramMap);
		BeanPropertyRowMapper<SupVO> beanPropertyRowMapper = new BeanPropertyRowMapper<SupVO>(SupVO.class);
		return this.getNamedParameterJdbcTemplate().query(sql, paramMap, beanPropertyRowMapper);
	}
	
	public int createContractSupVat(ContractVO contractVo) {
		org.hibernate.classic.Session session = this.getContractDao().getTemplate().getSessionFactory().getCurrentSession();
		SQLQuery query = session.createSQLQuery(
							  " insert into contract_sup_vat   "
							+ "	values(:cntrtId,:supVatNo,:status) ");
		query.setParameter("cntrtId", 1);
		query.setParameter("supVatNo", 1);
		query.setParameter("status", 1);
		return query.executeUpdate();
	}
	public int  queryContractSupVat(ContractVO contractVo) {
		org.hibernate.classic.Session session = this.getContractDao().getTemplate().getSessionFactory().getCurrentSession();
		SQLQuery query = session.createSQLQuery(
							  " select * from contract_sup_vat  t where 1=1 "
							+ "	and t.SUP_VAT_NO=:supVatNo "
							+ " and t.CNTRT_ID=:cntrtId");
		query.setParameter("supVatNo", contractVo.getSupVatNo());
		query.setParameter("cntrtId", contractVo.getCntrtId());
		return query.executeUpdate();
	}
	
	public int  updateContractSupVat(ContractVO contractVo,String status) {
		org.hibernate.classic.Session session = this.getContractDao().getTemplate().getSessionFactory().getCurrentSession();
		StringBuffer sql = new StringBuffer("update contract_sup_vat set status=:status where 1=1 ");
		if(contractVo.getCntrtId() != null){
			sql.append("and t.CNTRT_ID=:cntrtId");
		}
		if(contractVo.getSupNo() != null){
			sql.append("and t.SUP_VAT_NO=:supVatNo");
		}
		SQLQuery query = session.createSQLQuery(sql.toString());
		
		query.setParameter("status", status);
		if(contractVo.getCntrtId() != null){
			query.setParameter("cntrtId", contractVo.getCntrtId());
		}
		if(contractVo.getSupNo() != null){
			query.setParameter("supVatNo", contractVo.getSupVatNo());
		}
		return query.executeUpdate();
	}
}