package com.auchan.rtmm.rp.service.test;

import java.util.ArrayList;
import java.util.List;

import junit.framework.Assert;

import org.junit.Test;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.common.common.Ordering;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.rp.service.RpDmFacadeImpl;
import com.auchan.rtmm.rp.vo.RpDmCond;
import com.auchan.rtmm.testcase.BusinessServiceUnitTestBase;

public class RpDmFacadeImplTest extends BusinessServiceUnitTestBase{

	private RpDmCond searchCond;
	private PaginationSettings pageSet = new PaginationSettings();

	@Test
	public void testHandleSearchRpDmByPage() {
		RpDmFacadeImpl pdi = ServiceUtil.getService("rpDmFacadeImpl", RpDmFacadeImpl.class);
		searchCond = new RpDmCond();
		pageSet.setPageNo(1);
		pageSet.setPageSize(20);
		Ordering order = new Ordering(true, "rdmNo");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);
		PaginationResult result = pdi.searchRpDmByPage(searchCond, pageSet);
		Assert.assertEquals(result.getTotalCount().intValue(),14);
	}

	@Test
	public void testHandleCreateRpDm() {
	}

}
