package com.auchan.rtmm.action.contract;

import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.formula.functions.T;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.action.BasicAction;
import com.auchan.rtmm.common.common.Ordering;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.contract.service.ContributionGrpAccountFacade;
import com.auchan.rtmm.contract.vo.ContributionGrpAccountCond;
import com.auchan.rtmm.util.Page;

@Controller
@SuppressWarnings({"unchecked","rawtypes"})
@RequestMapping("/supplier/contract/common")
public class CommonAction extends BasicAction {
	
	@RequestMapping("chooseOfSupplierList")
	public String chooseOfSupplierList(Model model, Long cntrtId, Integer tabType) {
		return "contract/choiceOfSupplierWin";
	}

	/**
	 * 
	 * 打开选择科目组弹出框
	 * 
	 * @return
	 */
	@RequestMapping("/openAcctGroupWin")
	public String openAcctGroupWin(Model model) {
		//model.addAttribute("page", new Page());
		Page page = new Page();
		page.setPageNo(1);
		page.setPageSize(10);
		searchAcctGroupData(null, page, model);
		return "/contract/choiceOfAcctGroupWin";
	}

	/**
	 * 查询科目组信息列表
	 * 
	 * @param grpAcctId
	 * @param page
	 * @return
	 */
	@RequestMapping("/searchAcctGroupData")
	public String searchAcctGroupData(Integer grpAcctId, Page<T> page, Model model) {
		ContributionGrpAccountFacade cgf = ServiceUtil.getService("contributionGrpAccountFacade", ContributionGrpAccountFacade.class);
		ContributionGrpAccountCond grpAccountCond = new ContributionGrpAccountCond();
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageNo(page.getPageNo());
		pageSet.setPageSize(page.getPageSize());
		Ordering order = new Ordering(true, "grpAcctSeqNo");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);
		grpAccountCond.setGrpAcctId(grpAcctId);
		PaginationResult result = cgf.searchGrpAccountByPage(grpAccountCond, pageSet);
		page.setResult(result.getData());
		page.setTotalCount(result.getTotalCount());
		model.addAttribute("page", page);
		return "/contract/choiceOfAcctGroupList";
	}
}
