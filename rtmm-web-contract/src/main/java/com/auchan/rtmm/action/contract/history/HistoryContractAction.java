package com.auchan.rtmm.action.contract.history;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.action.BasicAction;
import com.auchan.rtmm.common.common.Ordering;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.common.utils.BeanUtils;
import com.auchan.rtmm.common.utils.DateUtils;
import com.auchan.rtmm.contract.service.ContractFacade;
import com.auchan.rtmm.contract.vo.ContractCond;
import com.auchan.rtmm.contract.vo.ContractVO;
import com.auchan.rtmm.supplier.service.SupplierFacade;
import com.auchan.rtmm.supplier.vo.ExternalSupplierVO;
import com.auchan.rtmm.supplier.vo.SupPaymentVO;
import com.auchan.rtmm.util.AuditInfoVO;
import com.auchan.rtmm.util.Page;

@Controller
@RequestMapping("/supplier/contract/history")
public class HistoryContractAction extends BasicAction {

	/**
	 * 最开始进来的页面
	 * 
	 * @return
	 */
	@RequestMapping("")
	public String main() {
		return "contract/history/main";
	}

	@RequestMapping("/listView")
	public String switchToListView(Model model) {
		Integer curYear = Integer.valueOf(DateUtils.getCurrentDate("yyyy"));
		List yearList = new ArrayList();
		for (int i = 2005; i < curYear; i++) {
			yearList.add(i);
		}
		model.addAttribute("yearList", yearList);
		return "contract/history/mainList";
	}

	/**
	 * 查询结果列表
	 * 
	 * @return
	 */
	@RequestMapping("/searchList")
	public String searchList(HttpServletRequest request,Model model, ContractCond contractCond, Page page) {
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageNo(page.getPageNo());
		pageSet.setPageSize(page.getPageSize());
		Ordering order = new Ordering(false, "cntrtId");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);

		// 设置赞助科目查询
		String grpAcctIds = request.getParameter("grpAcctIds");
		if (null != grpAcctIds && !"".equals(grpAcctIds)) {
			String grpAcctId[] = grpAcctIds.split(",");
			List grpAcctIdList = new ArrayList();
			for (int i = 0; i < grpAcctId.length; i++) {
				grpAcctIdList.add(grpAcctId[i]);
			}
			contractCond.setGrpAcctIds(grpAcctIdList);
		}else{
			contractCond.setGrpAcctIds(null);
		}
		
		ContractFacade cgaf = ServiceUtil.getService("contractFacade", ContractFacade.class);
		PaginationResult ps = cgaf.searchContractByPage(contractCond, pageSet);
		page.setTotalCount(ps.getTotalCount());
		page.setResult(ps.getData());
		model.addAttribute("page", page);
		return "contract/history/list";
	}

	/**
	 * 查询结果列表
	 * 
	 * @return
	 */
	@RequestMapping("/search")
	public String search(HttpServletRequest request, Model model, Page page, ContractCond contractCond) {
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageNo(page.getPageNo());
		pageSet.setPageSize(1);
		Ordering order = new Ordering(false, "cntrtId");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);
		
		// 设置赞助科目查询
		String grpAcctIds = request.getParameter("grpAcctIds");
		if (null != grpAcctIds && !"".equals(grpAcctIds)) {
			String grpAcctId[] = grpAcctIds.split(",");
			List grpAcctIdList = new ArrayList();
			for (int i = 0; i < grpAcctId.length; i++) {
				grpAcctIdList.add(grpAcctId[i]);
			}
			contractCond.setGrpAcctIds(grpAcctIdList);
		}else{
			contractCond.setGrpAcctIds(null);
		}
		
		ContractFacade cgaf = ServiceUtil.getService("contractFacade", ContractFacade.class);
		PaginationResult pr = cgaf.searchContractByPage(contractCond, pageSet);
		if (pr != null && pr.getData() != null) {
			ContractVO contractVO = (ContractVO) pr.getData().get(0);
			return detail(model, contractVO, page.getPageNo(), pr.getTotalCount());
		}
		model.addAttribute("flag", "noDataFound");
		return "contract/history/detail";
	}

	@RequestMapping("/detail")
	public String detail(Model model, ContractVO contractVO, Integer currentPage, Integer totalCount) {
		AuditInfoVO auditInfoVO = new AuditInfoVO();
		BeanUtils.copyProperties(contractVO, auditInfoVO);
		auditInfoVO.setCurRow(currentPage);
		auditInfoVO.setTotalRow(totalCount);
		SupplierFacade sf = ServiceUtil.getService("supplierFacade", SupplierFacade.class);
		ExternalSupplierVO externalSupplierVO = sf.getSupplierBaseInfoBySupNo(contractVO.getSupNo());
		SupPaymentVO supPaymentVO = sf.getSupPaymentBySupNo(contractVO.getSupNo());
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("contractVO", contractVO);
		model.addAttribute("auditInfoVO", auditInfoVO);
		model.addAttribute("extSupVO", externalSupplierVO);
		model.addAttribute("supPaymentVO", supPaymentVO);
		return "contract/history/detail";
	}

	@RequestMapping("/grpAccount")
	public String grpAccount(Model model, Long cntrtId, Integer tabType) {
		ContractFacade cgaf = ServiceUtil.getService("contractFacade", ContractFacade.class);
		List listGrpAccount = cgaf.findContractDetailByCntrtIdAndTabType(cntrtId, tabType);
		model.addAttribute("listGrpAccount", listGrpAccount);
		model.addAttribute("tabType", tabType);
		return "contract/history/detail_grp_account";
	}
	
}
