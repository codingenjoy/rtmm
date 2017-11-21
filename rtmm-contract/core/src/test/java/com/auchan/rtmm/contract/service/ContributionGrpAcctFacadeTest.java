package com.auchan.rtmm.contract.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.springframework.util.Assert;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.common.common.Ordering;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.common.utils.DateUtils;
import com.auchan.rtmm.contract.vo.ContributionAccountVO;
import com.auchan.rtmm.contract.vo.ContributionGrpAccountCond;
import com.auchan.rtmm.contract.vo.ContributionGrpAccountVO;
import com.auchan.rtmm.testcase.BusinessServiceUnitTestBase;

public class ContributionGrpAcctFacadeTest extends BusinessServiceUnitTestBase {

	@Test
	public void testSearchGrpAccountByPage() {
		ContributionGrpAccountFacade cgf = ServiceUtil.getService("contributionGrpAccountFacade", ContributionGrpAccountFacade.class);
		ContributionGrpAccountCond grpAccountCond = new ContributionGrpAccountCond();
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageNo(1);
		pageSet.setPageSize(1);
		Ordering order = new Ordering(false, "grpAcctId");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);
		grpAccountCond.setGrpAcctId(12);
		PaginationResult pr = cgf.searchGrpAccountByPage(grpAccountCond, pageSet);
	}

	@Test
	public void testFindContributionAcctByGrpAcctId() {
		ContributionGrpAccountFacade cgf = ServiceUtil.getService("contributionGrpAccountFacade", ContributionGrpAccountFacade.class);
		List list = cgf.findContributionAcctByGrpAcctId(7);
	}

	@Test
	public void testGetGrpAccountById() {
		ContributionGrpAccountFacade cgf = ServiceUtil.getService("contributionGrpAccountFacade", ContributionGrpAccountFacade.class);
		Integer grpAccountId = Integer.parseInt("65");
		ContributionGrpAccountVO retVo = cgf.getGrpAccountById(grpAccountId);
		System.out.println(retVo.getGrpAcctName());
		Assert.notNull(retVo, "赞助条目存在");
	}

	@Test
	public void testCreateGrpAccount() {
		ContributionGrpAccountFacade cgf = ServiceUtil.getService("contributionGrpAccountFacade", ContributionGrpAccountFacade.class);
		// 1.设置赞助科目组基本信息
		ContributionGrpAccountVO grpAccountVo = new ContributionGrpAccountVO();
		//grpAccountVo.setGrpAcctId(12345678);// 赞助科目编号
		grpAccountVo.setGrpAcctSeqNo(1);// 赞助科目序号
		grpAccountVo.setGrpAcctName("测试科目组");// 科目中文名称
		grpAccountVo.setGrpAcctEnName("test grp account");// 科目英文名称
		grpAccountVo.setGrpAcctAbbr("cskmz");// 科目缩写
		grpAccountVo.setStatus(1);// 科目状态
		grpAccountVo.setDedctValType("A");// 扣款单位
		grpAccountVo.setCalcBy(1);// 扣款计算方式
		grpAccountVo.setDedctFreq(1);// 扣款频率
		grpAccountVo.setCondValType("A");// 目标单位
		grpAccountVo.setDegeeCondInd(0);// 是否递增条件科目
		grpAccountVo.setLinkMainSupInd(0);// 是否关联主厂商
		grpAccountVo.setUsedForType(3);// 使用类型 MetaData, 可以是协议，合约，以及阶段性合约
		grpAccountVo.setGrpGrpAbbr("test");// 科目组别缩写，
		grpAccountVo.setFeeType(1);// 费用类型
		grpAccountVo.setInvTitle(1);// 发票抬头

		// 2.设置选中项赞助科目信息
		List<ContributionAccountVO> contributionAcctList = new ArrayList<ContributionAccountVO>();
		ContributionAccountVO accountVO = new ContributionAccountVO();
		accountVO.setConbnAcctNo(123456);// 科目编号
		accountVO.setVatNo(1);// 税率
		accountVO.setCondValType("A");// 目标单位
		contributionAcctList.add(accountVO);
		grpAccountVo.setContributionAcctList(contributionAcctList);

		// 3.执行创建操作
		cgf.createGrpAccount(grpAccountVo);
	}

	@Test
	public void testUpdateGrpAccount() {
		ContributionGrpAccountFacade cgf = ServiceUtil.getService("contributionGrpAccountFacade", ContributionGrpAccountFacade.class);
		// 1.查询出待修改的项
		ContributionGrpAccountVO grpAccountVo = cgf.getGrpAccountById(62776);

		// 2.设置修改内容
		grpAccountVo.setGrpAcctSeqNo(1);// 赞助科目序号
		grpAccountVo.setGrpAcctName("测试科目组");// 科目中文名称
		grpAccountVo.setGrpAcctEnName("test grp account");// 科目英文名称
		grpAccountVo.setGrpAcctAbbr("cskmz");// 科目缩写
		grpAccountVo.setStatus(1);// 科目状态
		grpAccountVo.setDedctValType("A");// 扣款单位
		grpAccountVo.setCalcBy(1);// 扣款计算方式
		grpAccountVo.setDedctFreq(1);// 扣款频率
		grpAccountVo.setCondValType("A");// 目标单位
		grpAccountVo.setDegeeCondInd(0);// 是否递增条件科目
		grpAccountVo.setLinkMainSupInd(0);// 是否关联主厂商
		grpAccountVo.setUsedForType(3);// 使用类型 MetaData, 可以是协议，合约，以及阶段性合约
		grpAccountVo.setGrpGrpAbbr("test");// 科目组别缩写，
		grpAccountVo.setFeeType(1);// 费用类型
		grpAccountVo.setInvTitle(1);// 发票抬头

		// 3.设置选中项赞助科目信息
		List<ContributionAccountVO> contributionAcctList = new ArrayList<ContributionAccountVO>();
		ContributionAccountVO accountVO = new ContributionAccountVO();
		accountVO.setConbnAcctNo(123456);// 科目编号
		accountVO.setVatNo(1);// 税率
		accountVO.setCondValType("A");// 目标单位
		contributionAcctList.add(accountVO);
		grpAccountVo.setContributionAcctList(contributionAcctList);

		// 4.执行修改操作
		cgf.updateGrpAccount(grpAccountVo);

	}

}
