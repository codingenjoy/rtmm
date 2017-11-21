package com.auchan.rtmm.action.contract.templ;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.auchan.common.codetable.utils.CodeTableI18NUtil;
import com.auchan.common.codetable.vo.MetaDataVO;
import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.action.BasicAction;
import com.auchan.rtmm.common.common.Ordering;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.contract.service.ContractTmplFacade;
import com.auchan.rtmm.contract.vo.ContractTmplAcctVO;
import com.auchan.rtmm.contract.vo.ContractTmplCond;
import com.auchan.rtmm.contract.vo.ContractTmplTabVO;
import com.auchan.rtmm.contract.vo.ContractTmplTermVO;
import com.auchan.rtmm.contract.vo.ContractTmplVO;
import com.auchan.rtmm.util.JsonUtil;
import com.auchan.rtmm.util.Page;

@Controller
@SuppressWarnings({ "rawtypes", "unchecked" })
@RequestMapping("/supplier/contract/templ")
public class TemplateAction extends BasicAction {
	/**
	 * 模板总页面
	 * 
	 * @return
	 */
	@RequestMapping("")
	public String main(Model model, ContractTmplCond tmplCond, Page page,
			HttpServletRequest request, HttpServletResponse response) {
		list(model, tmplCond, page, request, response);
		return "/contract/templ/main";
	}

	/**
	 * 模板列表
	 * 
	 * @return
	 */
	@RequestMapping("/list")
	public String list(Model model, ContractTmplCond tmplCond, Page page,
			HttpServletRequest request, HttpServletResponse response) {
		ContractTmplFacade of = ServiceUtil.getService("contractTmplFacade",
				ContractTmplFacade.class);
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageSize(page.getPageSize());
		pageSet.setPageNo(page.getPageNo());
		List<Ordering> orderList = new ArrayList<Ordering>();
		Ordering order = new Ordering(true, "tmplId");
		orderList.add(order);
		pageSet.setOrderBy(orderList);
		PaginationResult result = of
				.searchContractTmplByPage(tmplCond, pageSet);
		page.setTotalCount(result.getTotalCount());
		page.setResult(result.getData());
		model.addAttribute("page", page);
		return "/contract/templ/list";
	}

	/**
	 * 模板详情
	 */
	@RequestMapping("/detail")
	public String detail(Model model, Integer templ_id) {
		ContractTmplFacade ctf = ServiceUtil.getService("contractTmplFacade",
				ContractTmplFacade.class);
		ContractTmplVO tmplVO = null;
		if (!"".equals(templ_id)&&templ_id!=null) {
			tmplVO = ctf.getContractTmplByTmplId(templ_id);
		}
		model.addAttribute("tmplVO", tmplVO);
		return "/contract/templ/detail";
	}

	/*
	 * *********************************************************************
	 * 以下是系统界面模版新增和修改功能
	 * 
	 * *********************************************************************
	 */

	/**
	 * 
	 * 打开系统界面模版的新增页面 注意：新增页面和修改页面所属同一个页面
	 * 
	 * @return
	 */
	@RequestMapping("/create")
	public String create(Model model) {
		ContractTmplVO contractTmplVO = new ContractTmplVO();
		contractTmplVO.setInUseInd(0);
		JSONObject jsonObject = JSONObject.fromObject(null);
		model.addAttribute("createOrEdit", 0);
		model.addAttribute("templVO", contractTmplVO);
		model.addAttribute("jsonObject", jsonObject);
		return "/contract/templ/createAndEdit";
	}

	/**
	 * 
	 * 打开系统界面模版的新修改页面 注意：修改页面和新增页面所属同一个页面
	 * 
	 * @return
	 */
	@RequestMapping("/edit")
	public String edit(Model model, Integer templId) {
		ContractTmplFacade ctf = ServiceUtil.getService("contractTmplFacade", ContractTmplFacade.class);
		ContractTmplVO templVO= ctf.getContractTmplByTmplId(templId);
		JSONObject jsonObject = JSONObject.fromObject(templVO);
		model.addAttribute("createOrEdit", 1);
		model.addAttribute("templVO", templVO);
		model.addAttribute("jsonObject", jsonObject);
		return "/contract/templ/createAndEdit";
	}
	
	/**
	 * 
	 * 保存新增或修改的信息
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/save")
	public Map<String, Object> save(String templateStr) {
		ContractTmplFacade templ = ServiceUtil.getService("contractTmplFacade", ContractTmplFacade.class);
		Map<String, Object> map = new HashMap<String, Object>();
		//json字符串转换Map
		Map<String, Object> templMap = JsonUtil.json2java(templateStr, Map.class);
		//获取模版页签信息
		List<Map<String, Object>> tabList = (List<Map<String, Object>>)templMap.get("tabs");
		Iterator<Map<String, Object>> itTab = tabList.iterator();
		//获取页签信息
		Map<String, Object> termDataMap = (Map<String, Object>)templMap.get("tab2terms");
		//获取科目信息
		Map<String, Object> acctDataMap = (Map<String, Object>)templMap.get("term2accts");
		ContractTmplVO  contractTmplVO = new ContractTmplVO();
		//设置模版编号
		contractTmplVO.setTmplId(MapUtils.getInteger(templMap, "templateNo"));
		contractTmplVO.setInUseInd(MapUtils.getInteger(templMap, "inUseInd"));
		//存放页签信息
		List<ContractTmplTabVO> tabVOList = new ArrayList<ContractTmplTabVO>();
		//以下操作把数据封装放入到ContractTmplCond中
		int tabRankNoIdx = 0;
		while(itTab.hasNext()){
			
			//页签数据放入tabVO
			Map<String, Object> tabMap = itTab.next();
			ContractTmplTabVO tabVO = new ContractTmplTabVO();
			tabVO.setTabRankNo(tabRankNoIdx++);
			tabVO.setTabName(MapUtils.getString(tabMap, "tabName"));					//设置tab中文名
			tabVO.setTabEnName(MapUtils.getString(tabMap, "tabEnName"));				//设置tab英文名
			tabVO.setTabType(MapUtils.getInteger(tabMap, "tabType"));					//设置tab类型
			
			//存放条款信息
			List<ContractTmplTermVO> termVOList = new ArrayList<ContractTmplTermVO>();
			//获取页签下的条款数据(强转Map类型)
			Map<String, Object> termTempMap = (Map<String, Object>)termDataMap.get(MapUtils.getString(tabMap, "tabId"));
			//通过termMap的key值获取条款的data数据转换成List
			List<Map<String, Object>> termList = (List<Map<String, Object>>)termTempMap.get("data");
			Iterator<Map<String, Object>> itTerm = termList.iterator();
			int termRankNoIdx = 0;
			while(itTerm.hasNext()){
				//条款数据放入termVO
				Map<String, Object> termMap = itTerm.next();
				ContractTmplTermVO termVO = new ContractTmplTermVO();	
				termVO.setTermRankNo(termRankNoIdx++);
				termVO.setTermName(MapUtils.getString(termMap, "termName"));			//设置term中文名
				termVO.setTermEnName(MapUtils.getString(termMap, "termEnName"));		//设置term英文名
				termVO.setPayMethdOptns(MapUtils.getString(termMap, "payMethdOptns"));	//设置term支付方式	
				termVO.setFixDsplyInd(MapUtils.getInteger(termMap, "fixDsplyInd"));		//设置term固定条款
				termVO.setPaperPageNo(MapUtils.getInteger(termMap, "paperPageNo"));		//设置term纸板页数
				
				//存放科目信息
				List<ContractTmplAcctVO> acctVOList = new ArrayList<ContractTmplAcctVO>();
				//获取条款下的科目数据(强转Map类型)
				Map<String, Object> acctTempMap = (Map<String, Object>)acctDataMap.get(MapUtils.getString(termMap, "termId"));
				//通过acctTempMap的key值获取条款的accts数据转换成List
				List<Map<String, Object>> acctList = (List<Map<String, Object>>)acctTempMap.get("accts");
				Iterator<Map<String, Object>> itAcct = acctList.iterator();
				int acctRankNoIdx = 0;
				while(itAcct.hasNext()){
					//科目数据放入acctVO
					Map<String, Object> acctMap = itAcct.next();
					ContractTmplAcctVO acctVO = new ContractTmplAcctVO();	
					acctVO.setGrpAcctRankNo(acctRankNoIdx++);
					acctVO.setGrpAcctId(MapUtils.getInteger(acctMap, "grpAcctNo"));		//设置acct科目组编号
					acctVO.setGrpAcctName(MapUtils.getString(acctMap, "grpAcctName"));	//设置acct科目组名称
					acctVOList.add(acctVO);
				}
				termVO.setAcctList(acctVOList);		//所属科目数据放入条款下
				termVOList.add(termVO);				
			}
			tabVO.setTermList(termVOList);			//所属条款数据放入页签下
			tabVOList.add(tabVO);
		}
		contractTmplVO.setTabList(tabVOList);
		if (contractTmplVO.getTmplId() != null) {
			templ.updateContractTmpl(contractTmplVO);
		} else {
			templ.createContractTmpl(contractTmplVO);
		}
		map.put(STATUS, SUCCESS);
		map.put(MESSAGE, "创建成功！");
		return map;
	}
	
	/**
	 * 打开选择支付方式弹出框
	 * 
	 * @param model
	 * @param payMethdOptnsStr
	 * @return
	 */
	@RequestMapping("/openOfPaymentWin")
	public String openOfPaymentWin(Model model, String payMethdOptnsStr) {
		List<MetaDataVO> metadata = new ArrayList<MetaDataVO>();
		metadata = (List<MetaDataVO>) CodeTableI18NUtil.getMetaDataList("CONTRACT_DETL_PAY_METHD");
		model.addAttribute("metadata", metadata);
		model.addAttribute("payMethdOptnsStr", payMethdOptnsStr);
		return "/contract/choiceOfPaymentWin";
	}
}
