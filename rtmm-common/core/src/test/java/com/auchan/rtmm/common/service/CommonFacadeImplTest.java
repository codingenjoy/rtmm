package com.auchan.rtmm.common.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.common.common.Ordering;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.common.vo.SearchTaskVO;
import com.auchan.rtmm.testcase.BusinessServiceUnitTestBase;

public class CommonFacadeImplTest extends BusinessServiceUnitTestBase {

	@Test
	public void testhandleGetBankList() {
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		List list = cf.getBankList();
		System.out.print(list.size());
	}

	@Test
	public void handleGetBankBranchList(){
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		List list = cf.getBankBranchList(576);
		System.out.print(list.size());
	}
	
	@Test
	public void handleGetAuchanAreaList(){
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		List list = cf.getAuchanAreaList();
		System.out.print(list.size());
	}
	
	
	@Test
	public void handleGetProvinceList(){
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		List list = cf.getProvinceList();
		System.out.print(list.size());
	}
	
	@Test
	public void handleGetCityList(){
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		List list = cf.getCityList(1);
		System.out.print(list.size());
	}
	
	@Test
	public void handleSearchTaskPage(){
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		PaginationSettings paginationSettings = new PaginationSettings();
		paginationSettings.setPageNo(1);
		paginationSettings.setPageSize(10);
		Ordering order = new Ordering(true, "taskId");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		paginationSettings.setOrderBy(olist);
		
		PaginationResult ps = cf.searchTaskPage(new SearchTaskVO(), paginationSettings);
		List list = ps.getData();
		System.out.print(list.size());
		
	}
	
	@Test
	public void handleGetVatList(){
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		List list = cf.getVatList();
		System.out.print(list.size());
	}
	
	@Test
	public void handleGetStoreCountByArea(){
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		List list = cf.getStoreCountByArea();
		System.out.print(list.size());
	}
	
}
