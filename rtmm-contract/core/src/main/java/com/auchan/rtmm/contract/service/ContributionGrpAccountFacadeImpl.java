// license-header java merge-point
/**
 * This is only generated once! It will never be overwritten.
 * You can (and have to!) safely modify it by hand.
 * TEMPLATE:    SpringServiceImpl.vsl in andromda-spring cartridge
 * MODEL CLASS: Data::com.auchan.rtmm.contract.service::ContributionGrpAccountFacade
 * STEREOTYPE:  Service
 */
package com.auchan.rtmm.contract.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.springframework.jdbc.core.BeanPropertyRowMapper;

import rtmm.contract.entity.ContributionAccount;
import rtmm.contract.entity.ContributionGrpAccount;

import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.common.session.SessionHelper;
import com.auchan.rtmm.common.utils.BeanUtils;
import com.auchan.rtmm.common.utils.QueryUtil;
import com.auchan.rtmm.contract.ContractException;
import com.auchan.rtmm.contract.vo.ContributionAccountVO;
import com.auchan.rtmm.contract.vo.ContributionGrpAccountCond;
import com.auchan.rtmm.contract.vo.ContributionGrpAccountVO;

/**
 * @see com.auchan.rtmm.contract.service.ContributionGrpAccountFacade
 */
public class ContributionGrpAccountFacadeImpl extends ContributionGrpAccountFacadeBase {

	@Override
	protected PaginationResult handleSearchGrpAccountByPage(ContributionGrpAccountCond grpAccountCond, PaginationSettings pageSet) throws Exception {
		Map<String, Object> whereMap = QueryUtil.inverBeanToMap(grpAccountCond);
		BeanPropertyRowMapper<ContributionGrpAccountVO> beanPropertyRowMapper = new BeanPropertyRowMapper<ContributionGrpAccountVO>(
				ContributionGrpAccountVO.class);
		PaginationResult pr = QueryUtil.serachPageData("rtmm", "contract", "accgroup", "searchGrpAccountByPage", pageSet, whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return pr;
	}

	@Override
	protected ContributionGrpAccountVO handleGetGrpAccountById(Integer grpAccountId) throws Exception {
		ContributionGrpAccountVO retVO = new ContributionGrpAccountVO();
		ContributionGrpAccount pojo = this.getContributionGrpAccountDao().get(grpAccountId);
		BeanUtils.copyProperties(pojo, retVO);
		return retVO;
	}

	@Override
	protected void handleCreateGrpAccount(ContributionGrpAccountVO grpAccountVo) throws Exception {
		if (null == grpAccountVo.getGrpAcctId()) {
			throw new ContractException("001");
		}
		ContributionGrpAccount pojo = this.getContributionGrpAccountDao().get(grpAccountVo.getGrpAcctId());
		if (null != pojo) {
			throw new ContractException("002");
		}
		ContributionGrpAccount grpAccount = ContributionGrpAccount.Factory.newInstance();
		BeanUtils.copyProperties(grpAccountVo, grpAccount);
		grpAccount.setCreatDate(new Date());
		grpAccount.setCreatBy(SessionHelper.getCurrentStaffNo());
		grpAccount.setChngDate(new Date());
		grpAccount.setChngBy(SessionHelper.getCurrentStaffNo());
		this.getContributionGrpAccountDao().create(grpAccount);
		@SuppressWarnings("unchecked")
		List<ContributionAccountVO> contributionAcctList = grpAccountVo.getContributionAcctList();
		for (ContributionAccountVO accountVO : contributionAcctList) {
			ContributionAccount ca = this.getContributionAccountDao().get(accountVO.getConbnAcctNo());
			if (null != ca) {
				throw new ContractException("003");
			}
			ContributionAccount account = ContributionAccount.Factory.newInstance();
			BeanUtils.copyProperties(accountVO, account);
			account.setCreatDate(new Date());
			account.setCreatBy(SessionHelper.getCurrentStaffNo());
			account.setChngDate(new Date());
			account.setChngBy(SessionHelper.getCurrentStaffNo());
			account.setGrpAcctId(grpAccount.getGrpAcctId());
			this.getContributionAccountDao().create(account);
		}
	}

	@Override
	protected Boolean handleUpdateGrpAccount(ContributionGrpAccountVO grpAccountVO) throws Exception {
		ContributionGrpAccount grpAccount = this.getContributionGrpAccountDao().get(grpAccountVO.getGrpAcctId());
		BeanUtils.copyProperties(grpAccountVO, grpAccount, new String[] { "grpAcctId", "creatDate", "creatBy" });
		grpAccount.setChngDate(new Date());
		grpAccount.setChngBy(SessionHelper.getCurrentStaffNo());
		this.getContributionGrpAccountDao().update(grpAccount);
		org.hibernate.classic.Session session = this.getContributionGrpAccountDao().getTemplate().getSessionFactory().getCurrentSession();
		SQLQuery sqlQuery = session.createSQLQuery("delete from CONTRIBUTION_ACCOUNT t where t.grp_acct_id = :grpAcctId");
		sqlQuery.setParameter("grpAcctId", grpAccountVO.getGrpAcctId());
		sqlQuery.executeUpdate();
		@SuppressWarnings("unchecked")
		List<ContributionAccountVO> accountVOList = grpAccountVO.getContributionAcctList();
		for (ContributionAccountVO accountVO : accountVOList) {
			ContributionAccount ca = this.getContributionAccountDao().get(accountVO.getConbnAcctNo());
			if (null != ca) {
				throw new ContractException("003");
			}
			ContributionAccount account = ContributionAccount.Factory.newInstance();
			BeanUtils.copyProperties(accountVO, account);
			account.setCreatDate(new Date());
			account.setCreatBy(SessionHelper.getCurrentStaffNo());
			account.setChngDate(new Date());
			account.setChngBy(SessionHelper.getCurrentStaffNo());
			account.setGrpAcctId(grpAccount.getGrpAcctId());
			this.getContributionAccountDao().create(account);
		}
		return true;
	}

	@Override
	protected List<ContributionAccountVO> handleFindContributionAcctByGrpAcctId(Integer grpAccId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grpAccId", grpAccId);
		BeanPropertyRowMapper<ContributionAccountVO> beanPropertyRowMapper = new BeanPropertyRowMapper<ContributionAccountVO>(
				ContributionAccountVO.class);
		@SuppressWarnings("unchecked")
		List<ContributionAccountVO> list = QueryUtil.serachDataList("rtmm", "contract", "accgroup", "findContributionAcctByGrpAcctId", paramMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return list;
	}

	@Override
	protected List<ContributionGrpAccountVO> handleFindGrpAccount() throws Exception {
		Map<String, Object> whereMap = new HashMap<String, Object>();
		BeanPropertyRowMapper<ContributionGrpAccountVO> beanPropertyRowMapper = new BeanPropertyRowMapper<ContributionGrpAccountVO>(
				ContributionGrpAccountVO.class);
		@SuppressWarnings("unchecked")
		List<ContributionGrpAccountVO> retList = QueryUtil.serachDataList("rtmm", "contract", "accgroup", "searchGrpAccountByPage", whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return retList;
	}

	@Override
	protected Boolean handleIsNotExistGrpAcctId(Integer grpAcctId) throws Exception {
		ContributionGrpAccount pojo = this.getContributionGrpAccountDao().get(grpAcctId);
		return pojo == null;// 不存在返回true，存在返回false
	}

}