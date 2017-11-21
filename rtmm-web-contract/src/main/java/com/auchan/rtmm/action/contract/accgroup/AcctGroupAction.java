package com.auchan.rtmm.action.contract.accgroup;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.action.BasicAction;
import com.auchan.rtmm.common.common.Ordering;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.common.service.CommonFacade;
import com.auchan.rtmm.contract.ContractException;
import com.auchan.rtmm.contract.service.ContributionGrpAccountFacade;
import com.auchan.rtmm.contract.vo.ContributionAccountVO;
import com.auchan.rtmm.contract.vo.ContributionGrpAccountCond;
import com.auchan.rtmm.contract.vo.ContributionGrpAccountVO;
import com.auchan.rtmm.util.JsonUtil;
import com.auchan.rtmm.util.Page;

@Controller
@RequestMapping("/supplier/contract/acctGroup")
public class AcctGroupAction extends BasicAction {

	/**
	 * 最开始进来的页面
	 * 
	 * @return
	 */
	@RequestMapping("")
	public String search() {
		// TODO
		return "contract/acctGroup/main";
	}

	/**
	 * 查询结果列表
	 * 
	 * @return
	 */
	@RequestMapping("/search")
	public String list(Model model, ContributionGrpAccountCond grpAccountCond, Page page) {
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageNo(page.getPageNo());
		pageSet.setPageSize(page.getPageSize());
		Ordering order = new Ordering(false, "grpAcctId");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);
		ContributionGrpAccountFacade cgaf = ServiceUtil.getService("contributionGrpAccountFacade", ContributionGrpAccountFacade.class);
		PaginationResult ps = cgaf.searchGrpAccountByPage(grpAccountCond, pageSet);
		page.setTotalCount(ps.getTotalCount());
		page.setResult(ps.getData());
		model.addAttribute("page", page);
		return "contract/acctGroup/list";
	}

	@RequestMapping("/getExtInfo")
	public String getExtInfo(Model model, Integer grpAcctId) {
		ContributionGrpAccountFacade cgaf = ServiceUtil.getService("contributionGrpAccountFacade", ContributionGrpAccountFacade.class);
		List acctList = cgaf.findContributionAcctByGrpAcctId(grpAcctId);
		model.addAttribute("acctList", acctList);
		return "contract/acctGroup/listExtInfo";
	}

	@RequestMapping("/create")
	public String create(Model model) {
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		List vatList = cf.getVatList();
		model.addAttribute("vatList", vatList);
		model.addAttribute("action", "create");
		return "contract/acctGroup/create";
	}

	@RequestMapping("/update")
	public String update(Model model, Integer grpAcctId) {
		ContributionGrpAccountFacade cgaf = ServiceUtil.getService("contributionGrpAccountFacade", ContributionGrpAccountFacade.class);
		ContributionGrpAccountVO grpAccountVO = cgaf.getGrpAccountById(grpAcctId);
		List acctList = cgaf.findContributionAcctByGrpAcctId(grpAcctId);
		grpAccountVO.setContributionAcctList(acctList);
		model.addAttribute("grpAccountVO", grpAccountVO);
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		List vatList = cf.getVatList();
		model.addAttribute("vatList", vatList);
		model.addAttribute("action", "update");
		return "contract/acctGroup/create";
	}

	@RequestMapping("view")
	public String show() {
		return "contract/acctGroup/view";
	}

	@RequestMapping("edit")
	public String edit(Model model, Integer grpAcctId) {
		ContributionGrpAccountFacade cgaf = ServiceUtil.getService("contributionGrpAccountFacade", ContributionGrpAccountFacade.class);
		ContributionGrpAccountVO grpAccountVO = cgaf.getGrpAccountById(grpAcctId);
		model.addAttribute("grpAccountVO", grpAccountVO);
		model.addAttribute("action", "update");
		return "contract/acctGroup/create";
	}

	@ResponseBody
	@RequestMapping("doUpdate")
	public Map<String, Object> doUpdate(HttpServletRequest request, ContributionGrpAccountVO grpAccountVo) {
		Map<String, Object> retMap = new HashMap<String, Object>();
		retMap.put(STATUS, SUCCESS);
		retMap.put(MESSAGE, "保存成功");
		try {
			ContributionGrpAccountFacade cgf = ServiceUtil.getService("contributionGrpAccountFacade", ContributionGrpAccountFacade.class);
			String[] acctIds = request.getParameterValues("acctId");
			String[] vatNos = request.getParameterValues("vatNo");
			String[] condValTypes = request.getParameterValues("accCondValType");
			// 2.设置选中项赞助科目信息
			List<ContributionAccountVO> contributionAcctList = new ArrayList<ContributionAccountVO>();
			for (int i = 0; i < acctIds.length; i++) {
				ContributionAccountVO accountVO = new ContributionAccountVO();
				accountVO.setConbnAcctNo(Integer.valueOf(acctIds[i]));// 科目编号
				accountVO.setVatNo(Integer.valueOf(vatNos[i]));// 税率
				accountVO.setCondValType(condValTypes[i]);// 目标单位
				contributionAcctList.add(accountVO);
			  }
			  grpAccountVo.setContributionAcctList(contributionAcctList);
			    //grpAccountVo.setFeeType(1);
			    grpAccountVo.setInvTitle(1);
			// 3.执行创建操作
			cgf.updateGrpAccount(grpAccountVo);
		} catch (Exception e) {
			Throwable t0 = e.getCause();
			if (t0 != null && t0 instanceof ContractException) {
				String errorCode = ((ContractException) t0).getErrorCode();
				String prefix = ((ContractException) t0).getErrorCodeClassfier();
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, getErrorTitle(prefix,errorCode));
			}else{
				e.printStackTrace();
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, "保存失败");
		}
	  }
		return retMap;
	}
	
	@ResponseBody
	@RequestMapping("doCreate")
	public Map<String, Object> save(HttpServletRequest request, ContributionGrpAccountVO grpAccountVo) {
		Map<String, Object> retMap = new HashMap<String, Object>();
		retMap.put(STATUS, SUCCESS);
		retMap.put(MESSAGE, "保存成功");
		try {
			ContributionGrpAccountFacade cgf = ServiceUtil.getService("contributionGrpAccountFacade", ContributionGrpAccountFacade.class);
			String[] acctIds = request.getParameterValues("acctId");
			String[] vatNos = request.getParameterValues("vatNo");
			String[] condValTypes = request.getParameterValues("accCondValType");
			// 2.设置选中项赞助科目信息
			List<ContributionAccountVO> contributionAcctList = new ArrayList<ContributionAccountVO>();
			for (int i = 0; i < acctIds.length; i++) {
				ContributionAccountVO accountVO = new ContributionAccountVO();
				accountVO.setConbnAcctNo(Integer.valueOf(acctIds[i]));// 科目编号
				accountVO.setVatNo(Integer.valueOf(vatNos[i]));// 税率
				accountVO.setCondValType(condValTypes[i]);// 目标单位
				contributionAcctList.add(accountVO);
			}
				grpAccountVo.setContributionAcctList(contributionAcctList);
				//grpAccountVo.setFeeType(1);
				grpAccountVo.setInvTitle(1);

			// 3.执行创建操作
			cgf.createGrpAccount(grpAccountVo);
		} catch (Exception e) {
			e.printStackTrace();
			Throwable t0 = e.getCause();
			if (t0 != null && t0 instanceof ContractException) {
				String errorCode = ((ContractException) t0).getErrorCode();
				String prefix = ((ContractException) t0).getErrorCodeClassfier();
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, getErrorTitle(prefix,errorCode));
			}else{
				e.printStackTrace();
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, "保存失败");
			}	

		}
		return retMap;
	}
	
	@ResponseBody
	@RequestMapping("getAccountInfo")
	public List getAccountInfo(Integer  grpAcctId) {
		ContributionGrpAccountFacade cgaf = ServiceUtil.getService("contributionGrpAccountFacade", ContributionGrpAccountFacade.class);
		List acctList = cgaf.findContributionAcctByGrpAcctId(grpAcctId);
		return acctList;
	}
}


