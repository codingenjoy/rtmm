package com.auchan.rtmm.contract.service;

import java.util.ArrayList;
import java.util.List;

import junit.framework.Assert;

import org.junit.Test;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.common.common.Ordering;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.contract.vo.BuyerVO;
import com.auchan.rtmm.contract.vo.CatlgVO;
import com.auchan.rtmm.contract.vo.ContractCond;
import com.auchan.rtmm.contract.vo.SupCond;
import com.auchan.rtmm.testcase.BusinessServiceUnitTestBase;

public class ContractFacadeTest extends BusinessServiceUnitTestBase{
	
	
	@Test
	public void testSearchCurrentYearContractByPage(){
		ContractFacade ctf = ServiceUtil.getService("contractFacade", ContractFacade.class);
		ContractCond searchCond = new ContractCond();
		searchCond.setYear(Integer.parseInt("2015"));
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageNo(1);
		pageSet.setPageSize(20);
		Ordering order = new Ordering(true, "cntrtId");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);
		PaginationResult result = ctf.searchCurrentYearContractByPage(searchCond, pageSet);
		Assert.assertEquals(result.getTotalCount().intValue(), 20);
	}
	
	@Test
	public void testFindContractDetailByCntrtIdAndTabId(){
		ContractFacade ctf = ServiceUtil.getService("contractFacade", ContractFacade.class);
		List list = ctf.findContractDetailByCntrtIdAndTabId(Long.parseLong("741220011944"), 1);
		Assert.assertEquals(list.size(), 4);
	}
	
	@Test
	public void testFindContractDetailByCntrtIdAndTabType(){
		ContractFacade ctf = ServiceUtil.getService("contractFacade", ContractFacade.class);
		List list = ctf.findContractDetailByCntrtIdAndTabId(Long.parseLong("741220011944"), 1);
		Assert.assertEquals(list.size(), 4);
	}
	
	@Test
	public void testChooseLinkMainSupNoByPage(){
		ContractFacade ctf = ServiceUtil.getService("contractFacade", ContractFacade.class);
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageNo(1);
		pageSet.setPageSize(20);
		Ordering order = new Ordering(true, "supNo");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);
		SupCond supCond = new SupCond();
		supCond.setCatlgId(125);
		PaginationResult rs = ctf.chooseLinkMainSupByPage(pageSet, supCond);
		Assert.assertEquals(rs.getTotalCount().intValue(), 5489);
	}
	
	@Test
	public void testCreateContriSupConAcct() throws Exception{/*
		ContractFacade ctf = ServiceUtil.getService("contractFacade", ContractFacade.class);
		ContractVO contractVo = new ContractVO();
		int a =ctf.createContriSupConAcct(contractVo);
		System.out.println("create"+a);
	*/}
	@Test
	public void testQueryContriSupConAcct() throws Exception{/*
		ContractFacade ctf = ServiceUtil.getService("contractFacade", ContractFacade.class);
		ContractVO contractVo = new ContractVO();
		 int a =ctf.queryContriSupConAcct(contractVo);
		 System.out.println("query"+a);
	*/}
	
	@Test
	public void testHandleIsBuyer(){
		ContractFacade ctf = ServiceUtil.getService("contractFacade", ContractFacade.class);
		Boolean isBuyer =ctf.isBuyer("E00000175");
		Assert.assertTrue(isBuyer);
	}
	@Test
	public void testGetBuyerList(){
		ContractFacade ctf = ServiceUtil.getService("contractFacade", ContractFacade.class);
		@SuppressWarnings("unchecked")
		List<BuyerVO> buyList =ctf.findBuyerBySupNoAndCatlgId(13792, 102011);
		Assert.assertEquals(buyList.size(), 5);
	}
	
	@Test
	public void testFindCatlgBySupNo(){
		ContractFacade ctf = ServiceUtil.getService("contractFacade", ContractFacade.class);
		@SuppressWarnings("unchecked")
		List<CatlgVO> buyList =ctf.findCatlgBySupNo(22481);
		Assert.assertEquals(buyList.size(), 4);
	}
}
