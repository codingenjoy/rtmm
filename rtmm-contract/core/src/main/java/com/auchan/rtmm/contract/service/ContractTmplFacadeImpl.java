// license-header java merge-point
/**
 * This is only generated once! It will never be overwritten.
 * You can (and have to!) safely modify it by hand.
 * TEMPLATE:    SpringServiceImpl.vsl in andromda-spring cartridge
 * MODEL CLASS: Data::com.auchan.rtmm.contract.service::ContractTmplFacade
 * STEREOTYPE:  Service
 */
package com.auchan.rtmm.contract.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.springframework.jdbc.core.BeanPropertyRowMapper;

import rtmm.contract.entity.ContractTmpl;
import rtmm.contract.entity.ContractTmplAcct;
import rtmm.contract.entity.ContractTmplAcctPK;
import rtmm.contract.entity.ContractTmplTab;
import rtmm.contract.entity.ContractTmplTerm;

import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.common.session.SessionHelper;
import com.auchan.rtmm.common.utils.BeanUtils;
import com.auchan.rtmm.common.utils.QueryUtil;
import com.auchan.rtmm.contract.vo.ContractTmplAcctCond;
import com.auchan.rtmm.contract.vo.ContractTmplAcctVO;
import com.auchan.rtmm.contract.vo.ContractTmplCond;
import com.auchan.rtmm.contract.vo.ContractTmplTabCond;
import com.auchan.rtmm.contract.vo.ContractTmplTabVO;
import com.auchan.rtmm.contract.vo.ContractTmplTermCond;
import com.auchan.rtmm.contract.vo.ContractTmplTermVO;
import com.auchan.rtmm.contract.vo.ContractTmplVO;
import com.auchan.rtmm.contract.vo.ContributionGrpAccountVO;

/**
 * @see com.auchan.rtmm.contract.service.ContractTmplFacade
 */
public class ContractTmplFacadeImpl
    extends ContractTmplFacadeBase
{

    /**
     * @see com.auchan.rtmm.contract.service.ContractTmplFacade#searchContractTmplByPage(ContractTmplCond, PaginationSettings)
     */
	@Override
    protected  PaginationResult handleSearchContractTmplByPage(ContractTmplCond searchCond, PaginationSettings pageSet)
        throws Exception
    {
		Map<String, Object> whereMap = QueryUtil.inverBeanToMap(searchCond);
		BeanPropertyRowMapper<ContractTmplVO> beanPropertyRowMapper = new BeanPropertyRowMapper<ContractTmplVO>(
				ContractTmplVO.class);
		PaginationResult pr = QueryUtil.serachPageData("rtmm", "contract", "tmpl", "serachContractTempl", pageSet, whereMap,
				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
		return pr;
    }

    /**
     * @see com.auchan.rtmm.contract.service.ContractTmplFacade#getContractTmplByTmplId(Integer)
     */
    @Override
    protected  ContractTmplVO handleGetContractTmplByTmplId(Integer tmplId)
        throws Exception
    {
    	//读取合同主档信息
    	ContractTmplVO ctav = new ContractTmplVO();
    	ContractTmpl pojo = this.getContractTmplDao().get(tmplId);
    	BeanUtils.copyProperties(pojo, ctav);
    	//读取tab
    	@SuppressWarnings("unchecked")
		List<ContractTmplTabVO> tabVoList = this.findContractTmplTabByTmplId(tmplId);
    	for(ContractTmplTabVO tabVo : tabVoList){
    		@SuppressWarnings("unchecked")
    		List<ContractTmplTermVO> termVoList = this.findContractTmplTermByTabId(tabVo.getTabId());
    		for(ContractTmplTermVO termVo : termVoList){
    			@SuppressWarnings("unchecked")
    			List<ContractTmplAcctVO> acctVoList =this.findContractTmplAcctByTermId(termVo.getTermId());
    			termVo.setAcctList(acctVoList);
    		}
    		tabVo.setTermList(termVoList);
    	}
    	ctav.setTabList(tabVoList);
    	return ctav;
    }

    /**
     * @see com.auchan.rtmm.contract.service.ContractTmplFacade#findContractTmplTab(Integer)
     */
    @Override
    protected  List<ContractTmplTabVO> handleFindContractTmplTabByTmplId(Integer tmplId)
        throws Exception
    {
		ContractTmplTabCond searchCond = new ContractTmplTabCond();
		searchCond.setTmplId(tmplId);
		return this.findContractTmplTab(searchCond);
    }

    /**
     * @see com.auchan.rtmm.contract.service.ContractTmplFacade#findContractTmplTermByTabId(Integer)
     */
    @Override
    protected  List<ContractTmplTermVO> handleFindContractTmplTermByTabId(Integer tabId)
        throws Exception
    {
		ContractTmplTermCond searchCond = new ContractTmplTermCond();
		searchCond.setTabId(tabId);
		return this.findContractTmplTerm(searchCond);
    }

    /**
     * @see com.auchan.rtmm.contract.service.ContractTmplFacade#findContractTmplAcctByTermId(Integer)
     */
    @Override
    protected  List<ContractTmplAcctVO> handleFindContractTmplAcctByTermId(Integer termId)
        throws Exception
    {
		ContractTmplAcctCond searchCond = new ContractTmplAcctCond();
		searchCond.setTermId(termId);
		return this.findContractTmplAcct(searchCond);
    }

	@Override
	protected void handleUpdateContractTmpl(ContractTmplVO contractTmplVO)
			throws Exception {
		//1.删除tmp下面的子表信息（tab、term、acct）
		deleteContractTmplAndMoreByTmplId(contractTmplVO.getTmplId());

		//2.插入模版数据
		this.saveContractTmplTabList(contractTmplVO);
		
		
		//3.更新tmpl数据
    	ContractTmpl tmplPojo = this.getContractTmplDao().get(contractTmplVO.getTmplId());
    	//3.1.使用状态从0改为1
    	if(tmplPojo.getInUseInd() == 0 && contractTmplVO.getInUseInd() == 1){
    		org.hibernate.classic.Session session = this.getContractTmplDao().getTemplate().getSessionFactory().getCurrentSession();
    		SQLQuery acctQuery = session.createSQLQuery(" update CONTRACT_TMPL t set t.IN_USE_IND = 0 ");
    		acctQuery.executeUpdate();
    		tmplPojo.setInUseInd(contractTmplVO.getInUseInd());
    	}
    	tmplPojo.setChngBy(SessionHelper.getCurrentStaffNo());
    	tmplPojo.setChngDate(new Date());
    	
    	this.getContractTmplDao().update(tmplPojo);
	}
    /**
     * @see com.auchan.rtmm.contract.service.ContractTmplFacade#updateContractTmpl(ContractTmplVO)
     */
    protected  void handleUpdateContractTmplOld(ContractTmplVO contractTmplVO)
        throws Exception
    {
    	
    	//1.1.取出tabVOList
    	@SuppressWarnings("unchecked")
    	List<ContractTmplTabVO> tabVoList = contractTmplVO.getTabList();
    	
    	//1.2.转换tabVoList为tabPojoList
    	for(ContractTmplTabVO tabVo : tabVoList){
    		
    		//2.1.转换tabVo为tabPojo
    		ContractTmplTab tabPojo = ContractTmplTab.Factory.newInstance();;
    		if(tabVo.getTabId() != null){
    			tabPojo = this.getContractTmplTabDao().get(tabVo.getTabId());
    			BeanUtils.copyProperties(tabVo, tabPojo, new String[]{"tmplId","tabRankNo","tabName","tabEnName","tabType"});
    			this.getContractTmplTabDao().update(tabPojo);
    		}else{
    			BeanUtils.copyProperties(tabVo, tabPojo, new String[]{"tmplId","tabRankNo","tabName","tabEnName","tabType"});
    			this.getContractTmplTabDao().create(tabPojo);
    		}
    		
    		//2.2.取出termVoList
    		@SuppressWarnings("unchecked")
			List<ContractTmplTermVO> termVoList = tabVo.getTermList();
    		
    		//2.3.转换termVoList为termPojoList
    		for(ContractTmplTermVO termVo : termVoList){
    			
    			//3.1.转换termVO为termPojo
    			ContractTmplTerm termPojo = ContractTmplTerm.Factory.newInstance();
    			if(termVo.getTermId() != null){
    				 termPojo = this.getContractTmplTermDao().get(termVo.getTermId());
    				 BeanUtils.copyProperties(termVo, termPojo, new String[]{"termRankNo","termName","termEnName","payMethdOptns","fixDsplyInd","paperPageNo"});
    				 this.getContractTmplTermDao().update(termPojo);
    			}else{
    				 BeanUtils.copyProperties(termVo, termPojo, new String[]{"termRankNo","termName","termEnName","payMethdOptns","fixDsplyInd","paperPageNo"});
    				 termPojo.setTabId(tabPojo.getTabId());
    				 this.getContractTmplTermDao().create(termPojo);
    			}
    			
    			//3.2.取出acctVOList
    			@SuppressWarnings("unchecked")
    			List<ContractTmplAcctVO>  acctVoList = termVo.getAcctList();
    			
    			//3.3.转换acctVoList为acctPojoList
    			for(ContractTmplAcctVO acctVo : acctVoList){
    				
    				//4.1.转换acctVo为acctPojo
    				ContractTmplAcctPK acctPk = new ContractTmplAcctPK();
    				acctPk.setGrpAcctId(acctVo.getGrpAcctId());
    				acctPk.setTermId(termPojo.getTermId());
    				ContractTmplAcct acctPojo = this.getContractTmplAcctDao().load(acctPk);
    				if(acctPojo != null){
    					acctPojo.setGrpAcctRankNo(acctVo.getGrpAcctRankNo());
    					this.getContractTmplAcctDao().update(acctPojo);
    				}else{
    					acctPojo = ContractTmplAcct.Factory.newInstance();
    					acctPojo.setContractTmplAcctPk(acctPk);
    					acctPojo.setGrpAcctRankNo(acctVo.getGrpAcctRankNo());
    					this.getContractTmplAcctDao().create(acctPojo);
    				}
    				
    			}
    			
    		}
    		
    	}
    }

	@Override
	protected List<ContractTmplTabVO> handleFindInUseTmplTab() throws Exception {
		ContractTmplTabCond searchCond = new ContractTmplTabCond();
		searchCond.setInUseInd(1);//inUseInd为1，表示使用中，为0表示禁用
		return this.findContractTmplTab(searchCond);
	}


	@Override
	protected void handleCreateContractTmpl(ContractTmplVO contractTmplVO)
			throws Exception {
		//1. 取出tmplVo
    	ContractTmpl tmplPojo = ContractTmpl.Factory.newInstance();
    	
    	//2. 转换tmplVo为tmplPojo
    	BeanUtils.copyProperties(contractTmplVO, tmplPojo);
    	tmplPojo.setCreatBy(SessionHelper.getCurrentStaffNo());
    	tmplPojo.setCreatDate(new Date());
    	tmplPojo.setChngBy(SessionHelper.getCurrentStaffNo());
    	tmplPojo.setChngDate(new Date());
    	
    	//3.保存tmplPojo
    	this.getContractTmplDao().create(tmplPojo);
    	
    	//4.保存teml下的tab、term、acct
    	contractTmplVO.setTmplId(tmplPojo.getTmplId());
    	this.saveContractTmplTabList(contractTmplVO);
    	
	}
	@Override
	protected List<ContractTmplAcctVO> handleFindContractTmplAcctByTabId(Integer tabId)
			throws Exception {
		
		ContractTmplAcctCond searchCond = new ContractTmplAcctCond();
		searchCond.setTabId(tabId);
		return this.findContractTmplAcct(searchCond);
	}
	//辅助方法
    /**
     * 查询tmplTab
     * @param searchCond
     */
    protected  List<ContractTmplTabVO> findContractTmplTab(ContractTmplTabCond searchCond)
            throws Exception
        {
    		Map<String, Object> whereMap = QueryUtil.inverBeanToMap(searchCond);
    		BeanPropertyRowMapper<ContractTmplTabVO> beanPropertyRowMapper = new BeanPropertyRowMapper<ContractTmplTabVO>(
    				ContractTmplTabVO.class);
    		@SuppressWarnings("unchecked")
    		List<ContractTmplTabVO> pr = QueryUtil.serachDataList("rtmm", "contract", "tmpl", "findTmplTab", whereMap,
    				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
    		return pr;
        }
    /**
     * 查询tmplTerm
     * @param searchCond
     */
    protected  List<ContractTmplTermVO> findContractTmplTerm(ContractTmplTermCond searchCond)
            throws Exception
        {
    		Map<String, Object> whereMap = QueryUtil.inverBeanToMap(searchCond);
    		BeanPropertyRowMapper<ContractTmplTermVO> beanPropertyRowMapper = new BeanPropertyRowMapper<ContractTmplTermVO>(
    				ContractTmplTermVO.class);
    		@SuppressWarnings("unchecked")
    		List<ContractTmplTermVO> pr = QueryUtil.serachDataList("rtmm", "contract", "tmpl", "findTmplTerm", whereMap,
    				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
    		return pr;
        }
    /**
     * 查询tmplAcct
     * @param searchCond
     */
    protected  List<ContractTmplAcctVO> findContractTmplAcct(ContractTmplAcctCond searchCond)
            throws Exception
        {
    		Map<String, Object> whereMap = QueryUtil.inverBeanToMap(searchCond);
    		BeanPropertyRowMapper<ContractTmplAcctVO> beanPropertyRowMapper = new BeanPropertyRowMapper<ContractTmplAcctVO>(
    				ContractTmplAcctVO.class);
    		@SuppressWarnings("unchecked")
    		List<ContractTmplAcctVO> pr = QueryUtil.serachDataList("rtmm", "contract", "tmpl", "findTmplAcct", whereMap,
    				this.getNamedParameterJdbcTemplate(), beanPropertyRowMapper);
    		return pr;
        }
    
    /**
     * 根据tmplId删除tmpl以及tab、term、acct
     * @param contractTmplVO
     */
    protected void deleteContractTmplAndMoreByTmplId(Integer tmplId){
		//1.1.删除模版信息
		org.hibernate.classic.Session session = this.getContractTmplDao().getTemplate().getSessionFactory().getCurrentSession();
		//1.1.1删除acct
		SQLQuery acctQuery = session.createSQLQuery("delete from Contract_Tmpl_Acct acct where 1=1 "
													+" and EXISTS (select 1 from Contract_Tmpl_Term term where term.TERM_ID = acct.TERM_ID "
													+" and EXISTS (select 1 from Contract_Tmpl_Tab tab where tab.TAB_ID = term.TAB_ID and tab.TMPL_ID = :tmplId))");
		acctQuery.setParameter("tmplId", tmplId);
		acctQuery.executeUpdate();
		//1.1.2删除term
		SQLQuery termQuery = session.createSQLQuery("delete from Contract_Tmpl_Term term where 1=1 "
													+"  and EXISTS (select 1 from Contract_Tmpl_Tab tab where tab.TAB_ID = term.TAB_ID and tab.TMPL_ID = :tmplId)");
		termQuery.setParameter("tmplId", tmplId);
		termQuery.executeUpdate();
		//1.1.3删除tab
		SQLQuery tabQuery = session.createSQLQuery("delete from Contract_Tmpl_Tab tab where tab.TMPL_ID  = :tmplId");
		tabQuery.setParameter("tmplId", tmplId);
		tabQuery.executeUpdate();
    }
    /**
     * 保存TabList(包括tab下的term，以及term下的acct)
     * @param contractTmplVO
     */
    protected void saveContractTmplTabList(ContractTmplVO contractTmplVO){
    	@SuppressWarnings("unchecked")
		List<ContractTmplTabVO> tabVoList = contractTmplVO.getTabList();
       	//1.5.转换tabVoList为tabPojoList
    	for(ContractTmplTabVO tabVo : tabVoList){
    		
    		//2.1.转换tabVo为tabPojo
    		ContractTmplTab tabPojo = ContractTmplTab.Factory.newInstance();
			BeanUtils.copyProperties(tabVo, tabPojo);
			tabPojo.setTmplId(contractTmplVO.getTmplId());
			
			//2.2.保存tabPojo
			this.getContractTmplTabDao().create(tabPojo);
    		
    		//2.3.取出tabVo下的termVoList
    		@SuppressWarnings("unchecked")
    		List<ContractTmplTermVO> termVoList = tabVo.getTermList();
    		
    		//2.4.转换termVoList为termPojoList
    		for(ContractTmplTermVO termVo : termVoList){
    			
    			//3.1.转换termVo为termPojo
    			ContractTmplTerm termPojo = ContractTmplTerm.Factory.newInstance();
    			BeanUtils.copyProperties(termVo, termPojo);
    			termPojo.setTabId(tabPojo.getTabId());
    			
    			//3.2.保存termPojo
    			this.getContractTmplTermDao().create(termPojo);
    			
    			//3.3.取出tabVo下的acctPojoList
    			@SuppressWarnings("unchecked")
				List<ContractTmplAcctVO> acctVoList = termVo.getAcctList();
    			
    			//3.3. 转换acctVoList为acctPojoList
    			for(ContractTmplAcctVO acctVo : acctVoList){
    				
    				//4.1.转换acctVo为acctPojo
    				ContractTmplAcct acctPojo = ContractTmplAcct.Factory.newInstance();
    				ContractTmplAcctPK contractTmplAcctPkIn = new ContractTmplAcctPK();
    				contractTmplAcctPkIn.setGrpAcctId(acctVo.getGrpAcctId());
    				contractTmplAcctPkIn.setTermId(termPojo.getTermId());
    				acctPojo.setContractTmplAcctPk(contractTmplAcctPkIn);
    				acctPojo.setGrpAcctRankNo(acctVo.getGrpAcctRankNo());
    				this.getContractTmplAcctDao().create(acctPojo);
    			}
    			
    		}
    		
    	}
    }

}