package com.auchan.rtmm.contract.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.junit.Test;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.common.common.Ordering;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.contract.vo.ContractTmplAcctVO;
import com.auchan.rtmm.contract.vo.ContractTmplCond;
import com.auchan.rtmm.contract.vo.ContractTmplTabVO;
import com.auchan.rtmm.contract.vo.ContractTmplTermVO;
import com.auchan.rtmm.contract.vo.ContractTmplVO;
import com.auchan.rtmm.testcase.BusinessServiceUnitTestBase;

public class ContractTmplFacadeTest extends BusinessServiceUnitTestBase{
	
	@Test
	public void testCreateContract(){
		ContractTmplFacade ctf = ServiceUtil.getService("contractTmplFacade", ContractTmplFacade.class);
		ContractTmplVO contractTmplVO = new ContractTmplVO();
		
		//设置tmpl信息
		contractTmplVO.setInUseInd(0);//默认为0
		
		//设置模版下的tabList
		List<ContractTmplTabVO> tabList = new ArrayList<ContractTmplTabVO>();
		ContractTmplTabVO tabVo = new ContractTmplTabVO();
		tabVo.setTabName("测试页签2");
		tabVo.setTabEnName("yeqian2");
		tabVo.setTabRankNo(1);
		tabVo.setTabType(1);
		tabList.add(tabVo);
		contractTmplVO.setTabList(tabList);
		
		//设置tab下的tremList
		List<ContractTmplTermVO> termVoList = new ArrayList<ContractTmplTermVO>();
		ContractTmplTermVO termVo = new ContractTmplTermVO();
		termVo.setFixDsplyInd(0);
		termVo.setPayMethdOptns("1,2");
		termVo.setPaperPageNo(1);
		termVo.setTermName("测试条款2");
		termVo.setTermEnName("tiaokuan");
		termVo.setTermRankNo(1);
		termVoList.add(termVo);
		tabVo.setTermList(termVoList);
		
		//设置term下的acctList
		List<ContractTmplAcctVO> acctVoList = new ArrayList<ContractTmplAcctVO>();
		ContractTmplAcctVO acctVo = new ContractTmplAcctVO();
		acctVo.setGrpAcctId(18);
		acctVo.setGrpAcctRankNo(2);
		acctVoList.add(acctVo);
		termVo.setAcctList(acctVoList);
		
		ctf.createContractTmpl(contractTmplVO);
	}
	
	@Test
	public void testUpdateContract(){
		ContractTmplFacade ctf = ServiceUtil.getService("contractTmplFacade", ContractTmplFacade.class);
		ContractTmplVO contractTmplVO = ctf.getContractTmplByTmplId(1);
		
		//设置tmpl信息
		//contractTmplVO.setTmplId(1);
		contractTmplVO.setInUseInd(1);//默认为0
		
		/*//设置模版下的tabList
		List<ContractTmplTabVO> tabList = new ArrayList<ContractTmplTabVO>();
		ContractTmplTabVO tabVo = new ContractTmplTabVO();
		tabVo.setTabName("测试页签2");
		tabVo.setTabEnName("yeqian2");
		tabVo.setTabRankNo(2);
		tabVo.setTabType(2);
		//tabVo.setTabId(62955);
		//tabVo.setTmplId(62954); 
		tabList.add(tabVo);
		contractTmplVO.setTabList(tabList);
		
		//设置tab下的tremList
		List<ContractTmplTermVO> termVoList = new ArrayList<ContractTmplTermVO>();
		ContractTmplTermVO termVo = new ContractTmplTermVO();
		termVo.setFixDsplyInd(0);
		termVo.setPayMethdOptns("1,2,3,4");
		termVo.setPaperPageNo(1);
		termVo.setTermName("测试条款2");
		termVo.setTermEnName("tiaokuan2");
		termVo.setTermRankNo(1);
		//termVo.setTermId(62956);
		//termVo.setTabId(62955);
		termVoList.add(termVo);
		tabVo.setTermList(termVoList);
		
		//设置term下的acctList
		List<ContractTmplAcctVO> acctVoList = new ArrayList<ContractTmplAcctVO>();
		ContractTmplAcctVO acctVo = new ContractTmplAcctVO();
		acctVo.setGrpAcctId(107);
		acctVo.setGrpAcctRankNo(2);
		acctVoList.add(acctVo);
		termVo.setAcctList(acctVoList);
		*/
		ctf.updateContractTmpl(contractTmplVO);
	}	
	@Test
	public void testSearchGrpAccountByPage(){
		ContractTmplFacade ctf = ServiceUtil.getService("contractTmplFacade", ContractTmplFacade.class);
		ContractTmplCond searchCond = new ContractTmplCond();
		//模版id
		searchCond.setTmplId(Integer.parseInt("1"));
		//是否有效
		searchCond.setInUseInd(Integer.parseInt("0"));
		//创建日期
		searchCond.setCreatDate(new Date());
		//创建人
		searchCond.setCreatBy("sysAdmin");
		//修改日期
		searchCond.setChngDate(new Date());
		//修改人
		searchCond.setChngBy("sysAdmin");
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageNo(1);
		pageSet.setPageSize(20);
		Ordering order = new Ordering(true, "tmplId");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);
		PaginationResult result = ctf.searchContractTmplByPage(searchCond, pageSet);
		ContractTmplVO vo =(ContractTmplVO) result.getData().get(0);
		//System.out.println(vo.getCreatBy() +"shijian"+vo.getCreatDate());
		//Assert.notNull(result.getData().size(), "条目存在");
	}
	
	
	@Test
	public void testGetContractTmplByTmplId(){
		ContractTmplFacade ctf = ServiceUtil.getService("contractTmplFacade", ContractTmplFacade.class);
		ContractTmplVO vo =ctf.getContractTmplByTmplId(62934);
		System.out.println("tabList="+vo.getTabList().size());
		ContractTmplTabVO tabVo =  (ContractTmplTabVO) vo.getTabList().get(0);
		System.out.println("termList="+tabVo.getTermList().size());
		ContractTmplTermVO termVo = (ContractTmplTermVO)tabVo.getTermList().get(0);
		System.out.println("acctList="+termVo.getAcctList().size());
	}
	@Test
	public void testFindContractTmplTabByTmplId(){
		ContractTmplFacade ctf = ServiceUtil.getService("contractTmplFacade", ContractTmplFacade.class);
		List tbList = null;
		tbList = ctf.findContractTmplTabByTmplId(62934);
		System.out.println("testFindContractTmplTabByTmplId:->"+tbList);
	}
	@Test
	public void testFindContractTmplAcctByTermId(){
		ContractTmplFacade ctf = ServiceUtil.getService("contractTmplFacade", ContractTmplFacade.class);
		List acctList = ctf.findContractTmplAcctByTermId(7);
		System.out.println("testFindContractTmplAcctByTermId:->"+acctList.size());
	}
	
	@Test
	public void testFindInUseTmplTab(){
		ContractTmplFacade ctf = ServiceUtil.getService("contractTmplFacade", ContractTmplFacade.class);
		List tabList = ctf.findInUseTmplTab();
		System.out.println("testFindInUseTmplTab:->"+tabList.size());
	}
	
	@Test
	public void testFindContractTmplAcctByTabId(){
		ContractTmplFacade ctf = ServiceUtil.getService("contractTmplFacade", ContractTmplFacade.class);
		List tabList = ctf.findContractTmplAcctByTabId(1);
		System.out.println("testFindInUseTmplTab:->"+tabList.size());
	}
	

}
