package com.auchan.rtmm.action.contract.current;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
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
import com.auchan.rtmm.common.service.CommonFacade;
import com.auchan.rtmm.common.utils.BeanUtils;
import com.auchan.rtmm.common.utils.DateUtils;
import com.auchan.rtmm.common.vo.VatVO;
import com.auchan.rtmm.contract.service.ContractAuditFacade;
import com.auchan.rtmm.contract.service.ContractFacade;
import com.auchan.rtmm.contract.service.ContractTmplFacade;
import com.auchan.rtmm.contract.vo.BuyerVO;
import com.auchan.rtmm.contract.vo.CatlgVO;
import com.auchan.rtmm.contract.vo.ContractAuditVO;
import com.auchan.rtmm.contract.vo.ContractCond;
import com.auchan.rtmm.contract.vo.ContractDetailAuditVO;
import com.auchan.rtmm.contract.vo.ContractDetailVO;
import com.auchan.rtmm.contract.vo.ContractTmplAcctVO;
import com.auchan.rtmm.contract.vo.ContractTmplTabVO;
import com.auchan.rtmm.contract.vo.ContractTmplTermVO;
import com.auchan.rtmm.contract.vo.RichContractVO;
import com.auchan.rtmm.contract.vo.SupCond;
import com.auchan.rtmm.contract.vo.SupVO;
import com.auchan.rtmm.supplier.service.SupplierFacade;
import com.auchan.rtmm.supplier.vo.ExternalSupplierVO;
import com.auchan.rtmm.supplier.vo.SupPaymentVO;
import com.auchan.rtmm.util.AuditInfoVO;
import com.auchan.rtmm.util.JsonUtil;
import com.auchan.rtmm.util.Page;
import com.auchan.rtmm.util.SpringUtil;

@Controller
@RequestMapping("/supplier/contract/current")
public class CurrentContractAction extends BasicAction {

	/**
	 * 最开始进来的页面
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("")
	public String search(HttpServletRequest request,Model model, ContractCond contractCond, Page<RichContractVO> page) {
		page.setPageNo(1);
		page.setPageSize(20);
		list(request,model, contractCond, page);
		
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		List<VatVO> vatList = cf.getVatList();
		model.addAttribute("vatList", vatList);
		return "contract/current/main";
	}

	/**
	 * 查询结果列表
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/search")
	public String list(HttpServletRequest request,Model model, ContractCond contractCond, Page<RichContractVO> page) {
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageNo(page.getPageNo());
		pageSet.setPageSize(page.getPageSize());
		Ordering order = new Ordering(false, "cntrtId");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);
		
		// 设置查询年为本年
		contractCond.setYear(Integer.valueOf(DateUtils.getCurrentDate("yyyy")));
		// 设置赞助科目查询
		String grpAcctIds = request.getParameter("grpAcctIds");
		if (null != grpAcctIds && !"".equals(grpAcctIds)) {
			String grpAcctId[] = grpAcctIds.split(",");
			List<String> grpAcctIdList = new ArrayList<String>();
			for (int i = 0; i < grpAcctId.length; i++) {
				grpAcctIdList.add(grpAcctId[i]);
			}
			contractCond.setGrpAcctIds(grpAcctIdList);
		}else{
			contractCond.setGrpAcctIds(null);
		}
		ContractFacade cgaf = ServiceUtil.getService("contractFacade", ContractFacade.class);
		PaginationResult ps = cgaf.searchCurrentYearContractByPage(contractCond, pageSet);
		if(ps!=null){
			page.setTotalCount(ps.getTotalCount());
			page.setResult(ps.getData());
		}
		model.addAttribute("page", page);
		return "contract/current/list";
	}

	@RequestMapping("/create")
	public String create(Model model,HttpServletRequest request,HttpServletResponse response) {
		model.addAttribute("year",Calendar.getInstance().get(Calendar.YEAR));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date newDate = new Date(); //当天
		Date lastDate = DateUtils.addDays(DateUtils.ceiling(newDate, Calendar.YEAR),-1); //当年最后一天
		Date firstDate = DateUtils.getCurrYearFirst();
		model.addAttribute("today",sdf.format(firstDate));
		model.addAttribute("lastDay",sdf.format(lastDate));
		
		
		//获取当年的模板
		setTabInfoToModel(model, request, response,null);
		return "contract/current/create";
	}
	
	@RequestMapping("/tabDetailForReadOnly")
	public String tabDetailForReadOnly(Model model,Integer tabType,Integer tabId,Long cntrtId){
		String pageName=null;
		setTabDetailToModel(model, tabType, tabId,cntrtId);
		switch(tabType){
			case 1:pageName="contract_detail_Basic_readonly";break;
			case 2:pageName="contract_detail_Rebate_readonly";break;
			case 3:pageName="contract_detail_Phase_readonly";break;
		}
		return "contract/current/"+pageName;
	}
	
	@RequestMapping("/tabDetail")
	public String tabTermDetail(Model model,Integer tabType,Integer tabId,Long cntrtId){
		String pageName=null;
		ContractFacade contractFacade = ServiceUtil.getService("contractFacade", ContractFacade.class);
		if(cntrtId!=null){
			RichContractVO contractVO = contractFacade.getContractByCntrtId(cntrtId);
			model.addAttribute("contract", contractVO);
		}
		setTabDetailToModel(model, tabType, tabId,cntrtId);
		switch(tabType){
			case 1:pageName="contract_detail_Basic";break;
			case 2:pageName="contract_detail_Rebate";break;
			case 3:pageName="contract_detail_Phase";break;
		}
		return "contract/current/"+pageName;
	}
	
	/**
	 * tab 
	 * @param model
	 * @param request
	 * @param response
	 * @param cntrtId 通过cntrtId是否为空判断是否新增数据
	 */
	@SuppressWarnings("unchecked")
	private void setTabInfoToModel(Model model,HttpServletRequest request,HttpServletResponse response,Long cntrtId){
		//获取当年的模板tab
		ContractTmplFacade contractTmplFacade = ServiceUtil.getService("contractTmplFacade", ContractTmplFacade.class);
		List<ContractTmplTabVO> tabList = contractTmplFacade.findInUseTmplTab();
		Integer tabId = null;
		Integer tabType = null;
		if(SpringUtil.isNotEmpty(tabList)){
			model.addAttribute("tabList", tabList);
			//tab下所有的条款termList
			tabId = tabList.get(0).getTabId();
			tabType = tabList.get(0).getTabType();
			model.addAttribute("tabId", tabId);
			model.addAttribute("tabType", tabType);
			//setTabDetailToModel(model, tabType, tabId,cntrtId);
		}
	}

	/**
	 * 组装tab数据(适合审批中的合同,正式合同见 setTabDetailToModel)
	 * @param model
	 * @param contractAuditVo
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private List<ContractTmplTabVO> setTabsDetailToModel(Model model,ContractAuditVO contractAuditVo){
		if(contractAuditVo==null || contractAuditVo.getCntrtId()==null){
			return null;
		}
		ContractTmplFacade contractTmplFacade = ServiceUtil.getService("contractTmplFacade", ContractTmplFacade.class);
		List<ContractTmplTabVO> tabList = contractTmplFacade.findInUseTmplTab();
		List<ContractDetailAuditVO> detailList = (List<ContractDetailAuditVO>)contractAuditVo.getDetailList();
		Map<Integer,List<ContractDetailVO>> detailMap = this.contractDetailAuditList2Map(model,detailList);
		Iterator<ContractTmplTabVO> tabIt = tabList.iterator();
		Map<Integer,Integer> termPayMethdMap = new HashMap<Integer, Integer>();
		while(tabIt.hasNext()){
			ContractTmplTabVO tab = tabIt.next();
			Integer tabId = tab.getTabId();
			List<ContractTmplTermVO> termList = contractTmplFacade.findContractTmplTermByTabId(tabId);
			List<ContractTmplAcctVO> accList = contractTmplFacade.findContractTmplAcctByTabId(tabId);
			setValuesFortermList(model, detailMap, accList, termList, termPayMethdMap);
			tab.setTermList(termList);
		}
		model.addAttribute("termPayMethdMap", termPayMethdMap);
		return tabList;
	}
	
	/**
	 * 组装tab数据(适合正式合同,审批中的合同见 setTabsDetailToModel)
	 * @param model
	 * @param tabType
	 * @param tabId
	 * @param cntrtId 通过cntrtId是否为空判断是否新增数据
	 */
	@SuppressWarnings("unchecked")
	private List<ContractTmplTermVO> setTabDetailToModel(Model model,Integer tabType,Integer tabId,Long cntrtId){
		ContractTmplFacade contractTmplFacade = ServiceUtil.getService("contractTmplFacade", ContractTmplFacade.class);
		List<ContractTmplTermVO> termList = contractTmplFacade.findContractTmplTermByTabId(tabId);
		List<ContractDetailVO> detailList = null;
		Map<Integer,List<ContractDetailVO>> detailMap = null;
		if(cntrtId!=null){
			ContractFacade contractFacade = ServiceUtil.getService("contractFacade", ContractFacade.class);
			detailList = contractFacade.findContractDetailByCntrtIdAndTabId(cntrtId, tabId);
		}
		detailMap = this.contractDetailList2Map(detailList);
		//tab下所有的条目 accLIst
		List<ContractTmplAcctVO> accList = contractTmplFacade.findContractTmplAcctByTabId(tabId);
		Map<Integer,Integer> termPayMethdMap = new HashMap<Integer, Integer>();
		setValuesFortermList(model, detailMap, accList, termList,termPayMethdMap);
		model.addAttribute("termPayMethdMap", termPayMethdMap);
		model.addAttribute("termList", termList);
		model.addAttribute("tabId", tabId);
		model.addAttribute("tabType", tabType);
		return termList;
	}
	
	/**
	 * 为每个term设置数据
	 * @param model
	 * @param detailMap
	 * @param accList
	 * @param termList
	 * @param termPayMethdMap term对应的支付方式
	 */
	private void setValuesFortermList(Model model,Map<Integer,List<ContractDetailVO>> detailMap,
			List<ContractTmplAcctVO> accList,List<ContractTmplTermVO> termList,Map<Integer,Integer> termPayMethdMap){

		Iterator<ContractTmplAcctVO> accIt = accList.iterator();
		//以下往temp中塞入account数据
		
		//先组装一个map<kay,value> kay:termId,value:accList
		Map<Integer,List<ContractTmplAcctVO>> map = new HashMap<Integer, List<ContractTmplAcctVO>>();
		Map<String,Boolean> termHasDetail = new HashMap<String, Boolean>();
		String preKey = "trm";
		while(accIt.hasNext()){
			ContractTmplAcctVO obj = accIt.next();
			Integer temId = obj.getTermId();
			List<ContractDetailVO> detais = detailMap.get(obj.getGrpAcctId());
			Integer payMethd = null;

			//如果acct有数据,给term标识出来,否则往term中设置空对象
			if(SpringUtil.isNotEmpty(detais)){
				payMethd = detais.get(0).getPayMethd();
				if(detais.get(0).getCntrtDetlId()!=null){
					termHasDetail.put(preKey+temId, true);
				}
			}
			else{
				detais = new ArrayList<ContractDetailVO>();
				detais.add(new ContractDetailVO());
			}
			obj.setDetailList(detais);
			List<ContractTmplAcctVO> list = map.get(temId);
			if(list==null){
				list = new ArrayList<ContractTmplAcctVO>();
			}
			list.add(obj);
			if(termPayMethdMap.get(temId)==null && payMethd!=null){
				termPayMethdMap.put(temId, payMethd);
			}
			map.put(temId,list);
		}
		Iterator<ContractTmplTermVO> it = termList.iterator();
		List<MetaDataVO> metaList = CodeTableI18NUtil.getMetaDataList("CONTRACT_DETL_PAY_METHD");
		Map<String,MetaDataVO> metaMap = new HashMap<String, MetaDataVO>();
		for(MetaDataVO vo:metaList){
			metaMap.put(vo.getCode(), vo);
		}
		while(it.hasNext()){
			ContractTmplTermVO obj = it.next();
			//往temp中塞入accList
			Integer temId = obj.getTermId();
			List<ContractTmplAcctVO> acctlist = map.get(temId);
			if(obj.getFixDsplyInd().intValue()==0 && termHasDetail.get(preKey+temId)==null){
				continue;
			}
			obj.setAcctList(acctlist);
			String payMethd = obj.getPayMethdOptns();
			String str[]=payMethd.split(",");
			List<MetaDataVO> list = new ArrayList<MetaDataVO>();
			for(String s:str){
				if(metaMap.get(s)!=null){
					list.add(metaMap.get(s));
				}
			}
			//往temp中塞入 payMethdList
			obj.setPayMethdList(list);
		}
	}
	
	/**
	 * 把contractDetail的list转换成map
	 * @param list
	 * @return Map<key,value> key:grpAcctId,value:detailList
	 */
	private Map<Integer,List<ContractDetailVO>> contractDetailList2Map(List<ContractDetailVO> list){
		Map<Integer,List<ContractDetailVO>> map = new HashMap<Integer, List<ContractDetailVO>>();
		if(SpringUtil.isNotEmpty(list)){
			Iterator<ContractDetailVO> it = list.iterator();
			String supName = null;
			while(it.hasNext()){
				ContractDetailVO obj = it.next();
				Integer linkMainSupNo = obj.getLinkMainSupNo();
				if(linkMainSupNo!=null && supName==null){
					SupplierFacade sf = ServiceUtil.getService("supplierFacade", SupplierFacade.class);
					ExternalSupplierVO externalSupplierVO = sf.getSupplierBaseInfoBySupNo(linkMainSupNo);
					supName = externalSupplierVO.getSupComVO().getComName();
					obj.setSupName(supName);
				}
				else if(linkMainSupNo!=null && supName!=null){
					obj.setSupName(supName);
				}
				List<ContractDetailVO> details = map.get(obj.getGrpAcctId());
				if(details==null){
					details = new ArrayList<ContractDetailVO>();
				}
				details.add(obj);
				map.put(obj.getGrpAcctId(), details);
			}
		}
		return map;
	}
	
	/**
	 * 把contractDetail的list转换成map (临时表audit数据)
	 * @param list
	 * @return Map<key,value> key:grpAcctId,value:detailList
	 */
	private Map<Integer,List<ContractDetailVO>> contractDetailAuditList2Map(Model model, List<ContractDetailAuditVO> list){
		Map<Integer,List<ContractDetailVO>> map = new HashMap<Integer, List<ContractDetailVO>>();
		if(SpringUtil.isNotEmpty(list)){
			Iterator<ContractDetailAuditVO> it = list.iterator();
			String supName = null;
			while(it.hasNext()){
				ContractDetailAuditVO obj = it.next();
				Integer linkMainSupNo = obj.getLinkMainSupNo();
				if(linkMainSupNo!=null && supName==null){
					model.addAttribute("chngAllLinkInd", obj.getChngAllLinkInd());
					SupplierFacade sf = ServiceUtil.getService("supplierFacade", SupplierFacade.class);
					ExternalSupplierVO externalSupplierVO = sf.getSupplierBaseInfoBySupNo(linkMainSupNo);
					supName = externalSupplierVO.getSupComVO().getComName();
					obj.setSupName(supName);
				}
				else if(linkMainSupNo!=null && supName!=null){
					obj.setSupName(supName);
				}
				List<ContractDetailVO> details = map.get(obj.getGrpAcctId());
				if(details==null){
					details = new ArrayList<ContractDetailVO>();
				}
				details.add(obj);
				map.put(obj.getGrpAcctId(), details);
			}
		}
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/supInfo")
	public Map<String, Object> getSupplierInfo(Integer supNo,HttpServletRequest request,HttpServletResponse response){
		//获取厂商信息
		SupplierFacade sf = ServiceUtil.getService("supplierFacade", SupplierFacade.class);
		ExternalSupplierVO externalSupplierVO = sf.getSupplierBaseInfoBySupNo(supNo);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("sup", externalSupplierVO);
		if(externalSupplierVO!=null && externalSupplierVO.getChngBy() != null){
			//获取付款方式
			SupPaymentVO supPaymentVO = sf.getSupPaymentBySupNo(supNo);
			jsonMap.put("payment", supPaymentVO);
		}
		else{
			jsonMap.put(STATUS, ERROR);
		}
		return jsonMap;
	}
	
	@RequestMapping("/chooseSuplier")
	public String chooseSuplier(){
		return "contract/current/chooseContractSupplierWin";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/supList")
	public String getSupplier(Model model,Page<SupVO> page,String supName,Integer catlgId,HttpServletRequest request,HttpServletResponse response,Integer mainSup){
		ContractFacade contractFacade = ServiceUtil.getService("contractFacade", ContractFacade.class);
		//获得关联主厂商列表
		List<RichContractVO> richList = null;
		if(supName==null){
			if(mainSup!=null){
				richList = contractFacade.findSupListByLinkMainSupNo(mainSup);
				model.addAttribute("richList",richList);
			}
			return "contract/current/chooseSupplierWin";
		}
		this.getSupListBySupNo(model, page, supName, catlgId, request, response);
		return "contract/current/supplierInfoPage";
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping("/mainSup")
	public SupVO getSupListBySupNo(Model model,Page<SupVO> page,String supName,Integer catlgId,HttpServletRequest request,HttpServletResponse response){
		ContractFacade contractFacade = ServiceUtil.getService("contractFacade", ContractFacade.class);
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageNo(page.getPageNo());
		pageSet.setPageSize(page.getPageSize());
		Ordering order = new Ordering(false,"supNo");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);
		SupCond supCond = new SupCond();
		//如果是字符,按字符模糊查询;如果是数字,按数字精确查询
		if(StringUtils.isNumeric(supName) && supName.length()<=8){
			supCond.setSupNo(Integer.parseInt(supName));
		}
		else{
			supCond.setSupName(supName);
		}
		supCond.setCatlgId(catlgId);
		PaginationResult paginationResult = contractFacade.chooseLinkMainSupByPage(pageSet, supCond);
		model.addAttribute("supList", paginationResult.getData());
		page.setTotalCount(paginationResult.getTotalCount());
		page.setResult(paginationResult.getData());
		model.addAttribute("page",page);
		if(page.getPageSize()==1){
			List<SupVO> list = paginationResult.getData();
			SupVO sup = null;
			if(SpringUtil.isNotEmpty(list)){
				sup = list.get(0);
			}
			return sup;
		}
		return null;
	}
	
	@RequestMapping("/sup")
	@SuppressWarnings("unchecked")
	public String getSupplier(Model model,Integer supNo,Integer mainSupNo,Integer catlgId,Integer termId){
		//合同数据
		ContractFacade contractFacade = ServiceUtil.getService("contractFacade", ContractFacade.class);

		ContractAuditFacade contractAuditFacade = ServiceUtil.getService("contractAuditFacade", ContractAuditFacade.class);
		List<ContractDetailVO> list = null;
		if(mainSupNo!=null){
			list = contractAuditFacade.findContractDetailAuditBySupNo(mainSupNo);
			if(SpringUtil.isEmpty(list)){
				list = contractFacade.findContractDetailBySupNo(mainSupNo);
			}
		}
		model.addAttribute("detailList", list);
		//模板数据
		ContractTmplFacade contractTmplFacade = ServiceUtil.getService("contractTmplFacade", ContractTmplFacade.class);
		List<ContractTmplAcctVO> accList = contractTmplFacade.findContractTmplAcctByTermId(termId);
		model.addAttribute("acctList", accList);
		Map<Integer,List<ContractDetailVO>> detailMap = this.contractDetailList2Map(list);
		Iterator<ContractTmplAcctVO> accIt = accList.iterator();
		while(accIt.hasNext()){
			ContractTmplAcctVO obj = accIt.next();
			List<ContractDetailVO> detais = detailMap.get(obj.getGrpAcctId());
			//如果acct有数据,给term标识出来,否则往term中设置空对象
			if(SpringUtil.isEmpty(detais)){
				detais = new ArrayList<ContractDetailVO>();
				detais.add(new ContractDetailVO());
			}
			obj.setDetailList(detais);
		}
		
		String returnPage=null;
		if(mainSupNo==null){
			returnPage = "contract/current/rebate_template";
		}else{
			if(supNo.equals(mainSupNo)){
				returnPage = "contract/current/rebate_template";
			}
			else{
				returnPage = "contract/current/rebate_template_readonly";
			}
		}
		return returnPage;
	}
	
	@ResponseBody
	@RequestMapping("/isContractExists")
	public Map<String, Object> isContractExists(Integer supNo,Integer catlgId){
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		if(supNo==null || catlgId==null){
			jsonMap.put(STATUS, ERROR);
		}
		else{
			ContractFacade contractFacade = ServiceUtil.getService("contractFacade", ContractFacade.class);
			Boolean existFlag = contractFacade.isExistsContractBySupNoAndCatlgId(supNo, catlgId);
			jsonMap.put("flag", existFlag?1:0);
			jsonMap.put(STATUS, SUCCESS);
		}
		return jsonMap;
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping("/catlgList")
	public Map<String, Object> getCatlgListBySup(Model model,Integer supNo,HttpServletRequest request,HttpServletResponse response){
		ContractFacade contractFacade = ServiceUtil.getService("contractFacade", ContractFacade.class);
		List<CatlgVO> list = contractFacade.findCatlgBySupNo(supNo);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		if(SpringUtil.isNotEmpty(list)){
			jsonMap.put("list", list);
		}
		else{
			jsonMap.put(STATUS, ERROR);
		}
		return jsonMap;
	}
	
	@ResponseBody
	@SuppressWarnings("unchecked")
	@RequestMapping("/buyer")
	public Map<String, Object> findBuyerBySupNoAndCatlgId(Model model,Integer supNo,Integer catlgId,HttpServletRequest request,HttpServletResponse response){
		ContractFacade contractFacade = ServiceUtil.getService("contractFacade", ContractFacade.class);
		List<BuyerVO> buyList = contractFacade.findBuyerBySupNoAndCatlgId(supNo, catlgId);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		if(SpringUtil.isNotEmpty(buyList)){
			jsonMap.put("list", buyList);
		}
		else{
			jsonMap.put(STATUS, ERROR);
		}
		return jsonMap;
	}

	@RequestMapping("detail")
	public String detail(Model model,Long cntrtId,HttpServletRequest request,HttpServletResponse response) {
		//合同信息
		ContractFacade contractFacade = ServiceUtil.getService("contractFacade", ContractFacade.class);
		RichContractVO contractVO = contractFacade.getContractByCntrtId(cntrtId);
		model.addAttribute("contract", contractVO);
		AuditInfoVO auditInfoVO = new AuditInfoVO();
		BeanUtils.copyProperties(contractVO, auditInfoVO);
		model.addAttribute("auditInfoVO", auditInfoVO);
		//供应商
		SupplierFacade sf = ServiceUtil.getService("supplierFacade", SupplierFacade.class);
		ExternalSupplierVO externalSupplierVO = sf.getSupplierBaseInfoBySupNo(contractVO.getSupNo());
		model.addAttribute("supplier", externalSupplierVO);
		SupPaymentVO supPaymentVO = sf.getSupPaymentBySupNo(contractVO.getSupNo());
		model.addAttribute("payment", supPaymentVO);

		//获取合同模板
		setTabInfoToModel(model, request, response,cntrtId);
		return "contract/current/detail";
	}

	@RequestMapping("edit")
	public String edit(Long cntrtId,Model model,HttpServletRequest request,HttpServletResponse response) {
		//合同信息
		ContractFacade contractFacade = ServiceUtil.getService("contractFacade", ContractFacade.class);
		RichContractVO contractVO = contractFacade.getContractByCntrtId(cntrtId);
		model.addAttribute("contract", contractVO);
		AuditInfoVO auditInfoVO = new AuditInfoVO();
		BeanUtils.copyProperties(contractVO, auditInfoVO);
		model.addAttribute("auditInfoVO", auditInfoVO);
		//供应商
		SupplierFacade sf = ServiceUtil.getService("supplierFacade", SupplierFacade.class);
		ExternalSupplierVO externalSupplierVO = sf.getSupplierBaseInfoBySupNo(contractVO.getSupNo());
		model.addAttribute("supplier", externalSupplierVO);
		SupPaymentVO supPaymentVO = sf.getSupPaymentBySupNo(contractVO.getSupNo());
		model.addAttribute("payment", supPaymentVO);
		
		//获取合同模板
		setTabInfoToModel(model, request, response,cntrtId);

		return "contract/current/edit";
	}
	
	@RequestMapping("/editContract")
	public String workspaceEdit(Model model,HttpServletRequest request,HttpServletResponse response,Integer taskId){
		//合同信息
		ContractAuditFacade ctf = ServiceUtil.getService("contractAuditFacade", ContractAuditFacade.class);
		ContractAuditVO contractAuditVo = ctf.getContractAuditByTaskId(taskId);
		model.addAttribute("contract", contractAuditVo);
		
		//供应商
		SupplierFacade sf = ServiceUtil.getService("supplierFacade", SupplierFacade.class);
		ExternalSupplierVO externalSupplierVO = sf.getSupplierBaseInfoBySupNo(contractAuditVo.getSupNo());
		model.addAttribute("supplier", externalSupplierVO);
		
		//把合同tab及其detail放入model
		List<ContractTmplTabVO> tabList = setTabsDetailToModel(model, contractAuditVo);
		model.addAttribute("tabList", tabList);
		model.addAttribute("taskId", taskId);
		
		//创建日期等信息
		AuditInfoVO auditInfoVO = new AuditInfoVO();
		BeanUtils.copyProperties(contractAuditVo, auditInfoVO);
		model.addAttribute("auditInfoVO", auditInfoVO);
		return "contract/current/edit";
	}
	
	@RequestMapping("/detailContract")
	public String workspaceDetail(Model model,HttpServletRequest request,HttpServletResponse response,Integer taskId){
		//合同信息
		ContractAuditFacade ctf = ServiceUtil.getService("contractAuditFacade", ContractAuditFacade.class);
		ContractAuditVO contractAuditVo = ctf.getContractAuditByTaskId(taskId);
		model.addAttribute("contract", contractAuditVo);
		//创建日期等信息
		AuditInfoVO auditInfoVO = new AuditInfoVO();
		BeanUtils.copyProperties(contractAuditVo, auditInfoVO);
		model.addAttribute("auditInfoVO", auditInfoVO);
		//供应商
		SupplierFacade sf = ServiceUtil.getService("supplierFacade", SupplierFacade.class);
		ExternalSupplierVO externalSupplierVO = sf.getSupplierBaseInfoBySupNo(contractAuditVo.getSupNo());
		model.addAttribute("supplier", externalSupplierVO);
		
		//把合同tab及其detail放入model
		List<ContractTmplTabVO> tabList = setTabsDetailToModel(model, contractAuditVo);
		model.addAttribute("tabList", tabList);
		model.addAttribute("taskId", taskId);
		return "contract/current/detail";
	}
	
	@ResponseBody
	@RequestMapping("/save")
	public Map<String,Object> save(String contractStr,String detailList,String deleteData,HttpServletRequest request,HttpServletResponse response,Long taskId) {
		Map<String, Object> map = new HashMap<String, Object>();
 		ContractAuditFacade contractFacade = ServiceUtil.getService("contractAuditFacade", ContractAuditFacade.class);
		ContractAuditVO contract = JsonUtil.json2java(contractStr, ContractAuditVO.class);
		//格式化有效开始时间和结束时间
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			contract.setValidStartDate(sdf.parse(sdf.format(contract.getValidStartDate())));
			contract.setValidEndDate(sdf.parse(sdf.format(contract.getValidEndDate())));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if(contract.getAutoExtnd()==null){
			contract.setAutoExtnd(0);
		}
		List<ContractDetailAuditVO> cDtailList = JsonUtil.json2javaList(detailList, ContractDetailAuditVO.class);
		contract.setDetailList(cDtailList);
		contractFacade.saveOrUpdateContractAudit(contract);
		map.put("message","success");
		map.put("contract", contract);
		return map;
	}
}
