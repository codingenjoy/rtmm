package com.auchan.rtmm.action.rp;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.action.BasicAction;
import com.auchan.rtmm.catalogue.service.AuchanCompanyFacade;
import com.auchan.rtmm.common.common.Ordering;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.company.vo.StoreSearchCondVO;
import com.auchan.rtmm.orders.service.CreateOrderFacade;
import com.auchan.rtmm.orders.vo.HoOrderRegionStoreVO;
import com.auchan.rtmm.rp.RPException;
import com.auchan.rtmm.rp.service.RpBatchImportFacade;
import com.auchan.rtmm.rp.service.RpPlanFacade;
import com.auchan.rtmm.rp.vo.FindRpItemInfoVO;
import com.auchan.rtmm.rp.vo.FindRpRegionByItemNoVO;
import com.auchan.rtmm.rp.vo.FindRpStoreListByRegnVO;
import com.auchan.rtmm.rp.vo.FindRpStroeListVO;
import com.auchan.rtmm.rp.vo.LBatchRpDmVO;
import com.auchan.rtmm.rp.vo.LBatchRpItemInvalidVO;
import com.auchan.rtmm.rp.vo.LBatchRpItemVO;
import com.auchan.rtmm.rp.vo.LBatchRpStoreVO;
import com.auchan.rtmm.rp.vo.LBatchRpTotalVO;
import com.auchan.rtmm.rp.vo.RPDMInfoVO;
import com.auchan.rtmm.rp.vo.RpCond;
import com.auchan.rtmm.rp.vo.RpItemInfoVO;
import com.auchan.rtmm.rp.vo.RpItemVo;
import com.auchan.rtmm.rp.vo.RpRegionInfoVO;
import com.auchan.rtmm.rp.vo.RpRegionStoreVO;
import com.auchan.rtmm.rp.vo.RpStroeListVO;
import com.auchan.rtmm.rp.vo.RpVo;
import com.auchan.rtmm.rp.vo.SaveRPVO;
import com.auchan.rtmm.util.DateUtils;
import com.auchan.rtmm.util.JsonUtil;
import com.auchan.rtmm.util.Page;
import com.auchan.rtmm.util.SpringUtil;
import com.auchan.rtmm.util.StringUtils;
import com.auchan.rtmm.util.TreeVo;
import com.auchan.rtmm.util.excel.RPReadExcel;

@Controller
@RequestMapping("/rp/plan")
public class PlanAction extends BasicAction {
	private static final Integer BIZTYPE = 7;
	/**
	 * 菜单点击进入的页面
	 */
	@RequestMapping("")
	public String serarch(Model model){
		AuchanCompanyFacade auchanCompanyService = ServiceUtil.getService("auchanCompanyFacade", AuchanCompanyFacade.class);
		Page page = new Page();
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageNo(page.getPageNo());
		pageSet.setPageSize(100);
		Ordering order = new Ordering(false,"bizType");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);
		//查询物流中心
		StoreSearchCondVO sscVO = new StoreSearchCondVO();
		sscVO.setBizType(this.BIZTYPE);
		PaginationResult paginationResult = auchanCompanyService.listAllStore(sscVO, pageSet);
		model.addAttribute("dcStoreList", paginationResult.getData());
		return "rp/plan/main";
	}

	/**
	 * 查询rePlan记录（分页查询）
	 * @param model
	 * @param request
	 * @param rpCond
	 * @param page
	 * @return
	 */
	@RequestMapping("/serarch")
	public String list(Model model,HttpServletRequest request,RpCond rpCond,Page<RpCond> page){
		RpPlanFacade rpPlanService = ServiceUtil.getService("rpPlanFacade", RpPlanFacade.class);
		
		//设置分页的参数
		if (null == page){page = new Page<RpCond>();}
		if(null==rpCond){rpCond=new RpCond();}
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageNo(page.getPageNo());
		pageSet.setPageSize(page.getPageSize());
		
		Ordering order = new Ordering(false,"rpNo");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);
		
		PaginationResult paginationResult = rpPlanService.searchRpByPage(rpCond, pageSet);
		if(paginationResult.getData() !=null && 0 != paginationResult.getData().size()){
			page.setResult(paginationResult.getData());
			page.setTotalCount(paginationResult.getTotalCount());
		}
		
		model.addAttribute("page", page);
		model.addAttribute("len",page.getResult().size());
		return "rp/plan/list";
	}

	/**
	 * 创建
	 */
	@RequestMapping("/create")
	public String create(Model model){
		//TODO
		AuchanCompanyFacade auchanCompanyService = ServiceUtil.getService("auchanCompanyFacade", AuchanCompanyFacade.class);
		RpPlanFacade rpf = ServiceUtil.getService("rpPlanFacade", RpPlanFacade.class);
		//查询rpDM
		List<RPDMInfoVO> rpDMList = rpf.getRPDMInfoByNo();
		//查询物流中心
		Page page = new Page();
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageNo(page.getPageNo());
		pageSet.setPageSize(100);
		Ordering order = new Ordering(false,"bizType");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);
		StoreSearchCondVO sscVO = new StoreSearchCondVO();
		sscVO.setBizType(this.BIZTYPE);
		PaginationResult paginationResult = auchanCompanyService.listAllStore(sscVO, pageSet);
		model.addAttribute("dcStoreList", paginationResult.getData());
		model.addAttribute("rpDMList", rpDMList);
		model.addAttribute("status", 0);
		return "rp/plan/create";
	}
	
	/**
	 * 修改
	 */
	@RequestMapping("/edit")
	public String edit(Model model, Integer rpNo){
		AuchanCompanyFacade auchanCompanyService = ServiceUtil.getService("auchanCompanyFacade", AuchanCompanyFacade.class);
		RpPlanFacade rpf = ServiceUtil.getService("rpPlanFacade", RpPlanFacade.class);
		//查询rpDM
		List<RPDMInfoVO> rpDMList = rpf.getRPDMInfoByNo();
		//查询物流中心
		Page page = new Page();
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageNo(page.getPageNo());
		pageSet.setPageSize(100);
		Ordering order = new Ordering(false,"bizType");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);
		StoreSearchCondVO sscVO = new StoreSearchCondVO();
		sscVO.setBizType(this.BIZTYPE);
		PaginationResult paginationResult = auchanCompanyService.listAllStore(sscVO, pageSet);
		model.addAttribute("dcStoreList", paginationResult.getData());
		model.addAttribute("rpDMList", rpDMList);
		
		//查询保留计划基本信息
		List<RpVo> rpList = rpf.findRpBasicInfo(rpNo);
		RpVo rpVO = rpList.get(0);
		Map<String, Object> rpMap = new HashMap<String, Object>();
		Map<String,Object> itemMap = new HashMap<String, Object>();
		
		//RpItemInfoVO
		//获取保留计划下商品以及门店
		List<RpItemVo> rpItemList = rpf.findExistedRpItemInfo(rpNo);
		//封装数据，结构为每个商品对应每个门店（一个商品对应很多的门店）
		Iterator<RpItemVo> it = rpItemList.iterator();
		while(it.hasNext()){
			RpItemVo rpItemVo = it.next();
			if (itemMap.get(String.valueOf(rpItemVo.getItemNo())) != null) {
				Map<String, Object> map = (Map<String, Object>)itemMap.get(String.valueOf(rpItemVo.getItemNo()));
				List<Map<String, Object>> storeArray = (List<Map<String, Object>>)map.get("storeArray");
				//门店数据
				Map<String, Object> storeMap = new HashMap<String, Object>();
				storeMap.put("storeNo", rpItemVo.getStoreNo());
				storeMap.put("storeName", rpItemVo.getStoreName());
				storeMap.put("initQty", rpItemVo.getInitQty());
				storeMap.put("stCnfrmQty", rpItemVo.getStCnfrmQty());
				storeMap.put("finalQty", rpItemVo.getFinalQty());
				Date date = rpItemVo.getChngDate();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String chngDate = sdf.format(date);
				storeMap.put("chngDate", chngDate);
				storeArray.add(storeMap);
				map.put("storeArray", storeArray);
				itemMap.put(String.valueOf(rpItemVo.getItemNo()), map);
			} else {
				//商品数据
				Map<String, Object> item2storeMap = new HashMap<String, Object>();
				item2storeMap.put("itemNo", rpItemVo.getItemNo());
				item2storeMap.put("itemName", rpItemVo.getItemName());
				item2storeMap.put("ordMultiParm", rpItemVo.getOrdMultiParm());
				item2storeMap.put("buyPrice", rpItemVo.getBuyPrice());
				item2storeMap.put("normBuyPrice", rpItemVo.getNormBuyPrice());
				item2storeMap.put("dcSupNo", rpItemVo.getDcSupNo());
				item2storeMap.put("comName", rpItemVo.getComName());
				item2storeMap.put("stMinOrdQty", rpItemVo.getStMinOrdQty());
				//门店空数据
				List<Map<String, Object>> storeList = new ArrayList<Map<String,Object>>();
				item2storeMap.put("storeArray", storeList);
				itemMap.put(String.valueOf(rpItemVo.getItemNo()), item2storeMap);
			}
		}
		rpMap.put("rpVO", rpVO);
		rpMap.put("itemMap", itemMap);
		JSONObject rpJson = JSONObject.fromObject(rpMap);
		model.addAttribute("rpJsonStr", rpJson);
		return "rp/plan/edit";
	}
	
	/**
	 * 保存数据
	 * @param planInfoStr
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/save")
	public Map<String, Object> save(String planInfoStr) throws ParseException{
		//TODO
		Map<String, Object> map = new HashMap<String, Object>();
		RpPlanFacade rpf = ServiceUtil.getService("rpPlanFacade", RpPlanFacade.class);
		Map<String, Object> planInfoMap = JsonUtil.json2java(planInfoStr, Map.class);
		List<Map<String, Object>> itemList = (List<Map<String, Object>>)planInfoMap.get("items");
		Map<String, Object> storeMap = (Map<String, Object>)planInfoMap.get("item2store");
		List<RpItemVo> rpItemList = new ArrayList<RpItemVo>();
		SaveRPVO saveRPVo = new SaveRPVO();
		RpVo rpVO = new RpVo();
		//保留计划信息赋值
		rpVO.setStatus(MapUtils.getInteger(planInfoMap, "status"));
		rpVO.setCatlgId(MapUtils.getInteger(planInfoMap, "catlgId"));
		rpVO.setRdmNo(MapUtils.getInteger(planInfoMap, "rdmNo"));
		rpVO.setRdmTopic(MapUtils.getString(planInfoMap, "rdmTopic"));
		rpVO.setStCnfrmInd(1);
		SimpleDateFormat rdmBegin = new SimpleDateFormat("yyyy-MM-dd");
		Date rdmBeginDate = rdmBegin.parse(MapUtils.getString(planInfoMap, "rdmBeginDate"));
		rpVO.setRdmBeginDate(rdmBeginDate);
		SimpleDateFormat rdmEnd = new SimpleDateFormat("yyyy-MM-dd");
		Date rdmEndDate = rdmEnd.parse(MapUtils.getString(planInfoMap, "rdmEndDate"));
		rpVO.setRdmEndDate(rdmEndDate);
		SimpleDateFormat stCnfrmBegin = new SimpleDateFormat("yyyy-MM-dd");
		Date stCnfrmBeginDate = stCnfrmBegin.parse(MapUtils.getString(planInfoMap, "stCnfrmBeginDate"));
		rpVO.setStCnfrmBeginDate(stCnfrmBeginDate);
		SimpleDateFormat stCnfrmEnd = new SimpleDateFormat("yyyy-MM-dd");
		Date stCnfrmEndDate = stCnfrmEnd.parse(MapUtils.getString(planInfoMap, "stCnfrmEndDate"));
		rpVO.setStCnfrmEndDate(stCnfrmEndDate);
		SimpleDateFormat stRepBegin = new SimpleDateFormat("yyyy-MM-dd");
		Date stRepBeginDate = stRepBegin.parse(MapUtils.getString(planInfoMap, "stRepBeginDate"));
		rpVO.setStRepBeginDate(stRepBeginDate);
		SimpleDateFormat stRepEnd = new SimpleDateFormat("yyyy-MM-dd");
		Date stRepEndDate = stRepEnd.parse(MapUtils.getString(planInfoMap, "stRepEndDate"));
		rpVO.setStRepEndDate(stRepEndDate);
		rpVO.setDcStoreNo(MapUtils.getInteger(planInfoMap, "dcStoreNo"));
		//商品以及门店辅助
		Iterator<Map<String, Object>> itemIt = itemList.iterator();
		while(itemIt.hasNext()){
			Map<String, Object> itemMap = itemIt.next();
			Map<String, Object> dataMap = (Map<String, Object>)storeMap.get(MapUtils.getString(itemMap, "itemNo"));
			List<Map<String, Object>> storeList = (List<Map<String, Object>>)dataMap.get("data");
			Iterator<Map<String, Object>> storeIt = storeList.iterator();
			while(storeIt.hasNext()){
				RpItemVo rpItemVo = new RpItemVo();
				Map<String, Object> itemStoreMap = storeIt.next();
				//设置商品信息
				rpItemVo.setItemNo(MapUtils.getInteger(itemMap, "itemNo"));
				rpItemVo.setOrdMultiParm(MapUtils.getInteger(itemMap, "ordMultiParm"));
				rpItemVo.setBuyPrice(MapUtils.getDouble(itemMap, "curBuyPrice"));
				rpItemVo.setNormBuyPrice(MapUtils.getDouble(itemMap, "normBuyPrice"));
				rpItemVo.setDcSupNo(MapUtils.getInteger(itemMap, "stMainSupNo"));
				rpItemVo.setStMinOrdQty(MapUtils.getInteger(itemMap, "stMinOrdQty"));
				rpItemVo.setItemFlag(1);
				//设置门店信息
				rpItemVo.setStoreNo(MapUtils.getInteger(itemStoreMap, "storeNo"));
				rpItemVo.setInitQty(MapUtils.getInteger(itemStoreMap, "initQty"));
				rpItemVo.setStCnfrmQty(MapUtils.getInteger(itemStoreMap, "stCnfrmQty"));
				rpItemVo.setFinalQty(MapUtils.getInteger(itemStoreMap, "finalQty"));
				rpItemList.add(rpItemVo);
			}
		}
		saveRPVo.setRpVo(rpVO);
		saveRPVo.setRpItemVo(rpItemList);
		rpf.createRpAndItem(saveRPVo);
		map.put(STATUS, SUCCESS);
		map.put("message", "保存成功 ！");
		return map;
	}

	/**
	 * 选择课别的弹出框
	 * @param model
	 * @return
	 */
	@RequestMapping("/showCatlgWin")
	public String showCatlgWin(Model model){
		return "rp/plan/showCatlgWin";
	}

	/**
	 * 删除replan记录
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public static Map<String, Object> delete(HttpServletRequest request,Model model){
		RpPlanFacade rpPlanService = ServiceUtil.getService("rpPlanFacade", RpPlanFacade.class);
		Map<String,Object> map = new HashMap<String, Object>();
		String rpPlanId = request.getParameter("rpPlanId");
		rpPlanService.deleteRp(Integer.valueOf(rpPlanId));
		String status="success";
		String message="删除成功";
		map.put("status", status);
		map.put("message", message);
		return map;
	}
	
	@RequestMapping("/detail")
	public String detail(Model model,HttpServletRequest request,Page<RpCond> page) throws ParseException{
		RpCond rpCond = new RpCond();
		RpPlanFacade rpPlanService = ServiceUtil.getService("rpPlanFacade", RpPlanFacade.class);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String pageSize =request.getParameter("pageSize");
		String pageNo =request.getParameter("pageNo");
		String rdmEndDateBegin =request.getParameter("rdmEndDateBegin");
		String rdmBeginDateEnd =request.getParameter("rdmBeginDateEnd");
		String rdmBeginDateBegin =request.getParameter("rdmBeginDateBegin");
		String CatlgId =request.getParameter("CatlgId");
		String rdmNo =request.getParameter("rdmNo");
		String dcStoreNo =request.getParameter("dcStoreNo");
		String rdmTopic =request.getParameter("rdmTopic");
		String rpNo =request.getParameter("rpNo");
		String rdmEndDateEnd =request.getParameter("rdmEndDateEnd");
		String stCnfrmBeginDate =request.getParameter("stCnfrmBeginDate");
		String stCnfrmEndDate =request.getParameter("stCnfrmEndDate");
		String stRepBeginDate =request.getParameter("stRString ");
		String stRepEndDate =request.getParameter("stRepEndDate");
		String finalAmntBegin =request.getParameter("finalAmntBegin");
		String finalAmntEnd = request.getParameter("finalAmntEnd"); 
		String planId = request.getParameter("planId");
		String flag = request.getParameter("flag");
		//结束日期期间开始时间
		if(!StringUtils.isEmpty(rdmEndDateBegin)&&StringEqualNull(rdmEndDateBegin)){
			rpCond.setRdmEndDateBegin(sdf.parse(rdmEndDateBegin));
		}
		//开始日期期间结束时间
		if(!StringUtils.isEmpty(rdmBeginDateEnd)&&StringEqualNull(rdmBeginDateEnd)){
			rpCond.setRdmBeginDateEnd(sdf.parse(rdmBeginDateEnd));
		}
		//开始日期期间开始时间
		if(!StringUtils.isEmpty(rdmBeginDateBegin)&&StringEqualNull(rdmBeginDateBegin)){
			rpCond.setRdmBeginDateBegin(sdf.parse(rdmBeginDateBegin));
		}
		//课别
		if(!StringUtils.isEmpty(CatlgId)&&StringEqualNull(CatlgId)){
			rpCond.setCatlgId(Integer.valueOf(CatlgId));
		}
		//DM
		if(!StringUtils.isEmpty(rdmNo)&&StringEqualNull(rdmNo)){
			rpCond.setRdmNo(Integer.valueOf(rdmNo));
		}
		//物流中心
		if(!StringUtils.isEmpty(dcStoreNo)&&StringEqualNull(dcStoreNo)){
			rpCond.setDcStoreNo(Integer.valueOf(dcStoreNo));
		}
		//主题
		if(!StringUtils.isEmpty(rdmTopic)&&StringEqualNull(rdmTopic)){
			rpCond.setRdmTopic(rdmTopic);
		}
		//计划编号
		if(!StringUtils.isEmpty(rpNo)&&StringEqualNull(rpNo)){
			rpCond.setRpNo(Integer.valueOf(rpNo));
		}
		//结束日期的结束日期
		if(!StringUtils.isEmpty(rdmEndDateEnd)&&StringEqualNull(rdmEndDateEnd)){
			rpCond.setRdmEndDateEnd(sdf.parse(rdmEndDateEnd));
		}
		//确认开始日期
		if(!StringUtils.isEmpty(stCnfrmBeginDate)&&StringEqualNull(stCnfrmBeginDate)){
			rpCond.setStCnfrmBeginDate(sdf.parse(stCnfrmBeginDate));
		}
		//确认结束日期
		if(!StringUtils.isEmpty(stCnfrmEndDate)&&StringEqualNull(stCnfrmEndDate)){
			rpCond.setStCnfrmEndDate(sdf.parse(stCnfrmEndDate));
		}
		//补货开始日期
		if(!StringUtils.isEmpty(stRepBeginDate)&&StringEqualNull(stRepBeginDate)){
			rpCond.setStRepBeginDate(sdf.parse(stRepBeginDate));
		}
		//补货结束日期
		if(!StringUtils.isEmpty(stRepEndDate)&&StringEqualNull(stRepEndDate)){
			rpCond.setStRepEndDate(sdf.parse(stRepEndDate));
		}
		//总金额最低值
		if(!StringUtils.isEmpty(finalAmntBegin)&&StringEqualNull(finalAmntBegin)){
			rpCond.setFinalAmntBegin(Double.valueOf(finalAmntBegin));
		}
		//总金额最高值
		if(!StringUtils.isEmpty(finalAmntEnd)&&StringEqualNull(finalAmntEnd)){
			rpCond.setFinalAmntEnd(Double.valueOf(finalAmntEnd));
		}
		
		//设置分页的参数
		if (null == page){page = new Page<RpCond>();}
		PaginationSettings pageSet = new PaginationSettings();
		pageSet.setPageNo(Integer.valueOf(pageNo));
		pageSet.setPageSize(Integer.valueOf(pageSize));
		Ordering order = new Ordering(false,"rpNo");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		pageSet.setOrderBy(olist);
		
		//查询rpPlan的baseic信息
		PaginationResult paginationResult = rpPlanService.searchRpByPage(rpCond, pageSet);
		if(paginationResult.getData() !=null && 0 != paginationResult.getData().size()){
			page.setTotalCount(paginationResult.getTotalCount());
			if(flag!=null&&"page".equals(flag)){
				planId = ((RpVo)paginationResult.getData().get(0)).getRpNo().toString();
			}
			List list = rpPlanService.findRpBasicInfo(Integer.valueOf(planId));
			RpVo rpvo = (RpVo)list.get(0);
			model.addAttribute("rpPlanVo",  JsonUtil.java2json(rpvo));
			formatDateToStr(rpvo,model);
			//查询rePlan的商品门店信息列表
			List<Object> rpItemInfoList = rpPlanService.findExistedRpItemInfo(rpvo.getRpNo());
			if(rpItemInfoList !=null&&rpItemInfoList.size() > 0){
				//进行包装和分类处理
				makeRpItemInfoToJson(rpItemInfoList,model);
			}
			
		}
		String rpCondParam = JsonUtil.java2json(rpCond);
		model.addAttribute("rpCondParam", rpCondParam);
		model.addAttribute("page", page);
		return "rp/plan/detail";
	}
	/**
	 * 查询商品信息以及商品下关联的门店
	 * 
	 * @param itemNoArray
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/serarchItem")
	public Map<String, Object> serarchItem(Integer [] itemNoArray, FindRpItemInfoVO findRpVO){
		RpPlanFacade rpf = ServiceUtil.getService("rpPlanFacade", RpPlanFacade.class);
		Map<String, Object> map = new HashMap<String, Object>();
 		List<Integer> itemList = new ArrayList<Integer>();
		CollectionUtils.addAll(itemList, itemNoArray);
		findRpVO.setIncludeItemNoList(itemList);
		findRpVO.setMinStatus(1);
		List<RpItemInfoVO> rpItemList = rpf.findRpItemInfo(findRpVO);
		List<RpStroeListVO> rpStoreList = new ArrayList<RpStroeListVO>();
		if (!SpringUtil.isEmpty(rpItemList)) {
			rpStoreList = serarchItemStores(rpItemList.get(0).getItemNo(), findRpVO.getStoreNo());
		}
		map.put("rpItemList", rpItemList);
		map.put("rpStoreList", rpStoreList);
		return map;
	}
	
	/**
	 * 此方法暂不可用
	 * @param rpItemInfoList
	 * @param model
	 */
	public static void makeRpItemInfoToJson(List<Object> rpItemInfoList,Model model){
		List<Object> ItemInfoList = new ArrayList<Object>();
		List<Object> storeInfoList = new ArrayList<Object>();
		Map<String,RpItemVo> ItemInfoMap = new HashMap<String,RpItemVo>();
		for (int rpItemInfoIndex = 0; rpItemInfoIndex < rpItemInfoList.size(); rpItemInfoIndex++) {
			RpItemVo rpItemInfo = (RpItemVo)rpItemInfoList.get(rpItemInfoIndex);
			if(!ItemInfoMap.containsKey(rpItemInfo.getItemNo())){
				ItemInfoMap.put(rpItemInfo.getItemNo().toString(), rpItemInfo);
			}
		}
		
		for(Map.Entry<String, RpItemVo> entry: ItemInfoMap.entrySet()) {
			ItemInfoList.add(entry.getValue());
			String ItemNo = entry.getKey();
			List<RpItemVo> storesList = new ArrayList<RpItemVo>();
			Map<String, Object> storesMap = new HashMap<String, Object>();
			for (int storeInfoIndex = 0; storeInfoIndex < rpItemInfoList.size(); storeInfoIndex++) {
				RpItemVo store = (RpItemVo)rpItemInfoList.get(storeInfoIndex);
				if(ItemNo.equals(store.getItemNo().toString())){
					storesList.add(store);
				}
			}
			storesMap.put("data", storesList);
			storesMap.put("itemNo", ItemNo);
			storeInfoList.add(storesMap);
		}
		model.addAttribute("itemInfoData", JsonUtil.java2json(ItemInfoList));
		model.addAttribute("storeInfoData", JsonUtil.java2json(storeInfoList));
	}
	
	public static void formatDateToStr(RpVo rpvo,Model model){
		model.addAttribute("rdmBeginDate",DateUtils.parseDate2Str(rpvo.getRdmBeginDate(), "yyyy-MM-dd")); 
		model.addAttribute("rdmEndDate",DateUtils.parseDate2Str(rpvo.getRdmEndDate(), "yyyy-MM-dd")); 
		model.addAttribute("stCnfrmBeginDate",DateUtils.parseDate2Str(rpvo.getStCnfrmBeginDate(), "yyyy-MM-dd")); 
		model.addAttribute("stCnfrmEndDate",DateUtils.parseDate2Str(rpvo.getStCnfrmEndDate(), "yyyy-MM-dd")); 
		model.addAttribute("stRepBeginDate",DateUtils.parseDate2Str(rpvo.getStRepBeginDate(), "yyyy-MM-dd")); 
		model.addAttribute("stRepEndDate",DateUtils.parseDate2Str(rpvo.getStRepEndDate(), "yyyy-MM-dd")); 
		
	}
	
	/**
	 * 查询门店信息
	 * 
	 * @param itemNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/serarchItemStores")
	public List<RpStroeListVO> serarchItemStores(Integer itemNo, Integer dcStoreNo){
		RpPlanFacade rpf = ServiceUtil.getService("rpPlanFacade", RpPlanFacade.class);
		FindRpStroeListVO findRpStoreVO = new FindRpStroeListVO();
		findRpStoreVO.setItemNo(itemNo);
		findRpStoreVO.setDcStoreNo(dcStoreNo);
		List<Integer> statusArray = new ArrayList<Integer>();
		statusArray.add(1);
		statusArray.add(2);
		findRpStoreVO.setStatusList(statusArray);
		List<Integer> typeArray = new ArrayList<Integer>();
		typeArray.add(1);
		findRpStoreVO.setBizTypeList(typeArray);
		List<RpStroeListVO> rpStoreList = rpf.findRpStroeList(findRpStoreVO);
		return rpStoreList;
	}
	
	/**
	 * 查询门店信息页面
	 * 
	 * @param itemNo
	 * @return
	 */
	@RequestMapping("/serarchItemStorePage")
	public String serarchItemStorePage(Model model, Integer itemNo, Integer dcStoreNo){
		RpPlanFacade rpf = ServiceUtil.getService("rpPlanFacade", RpPlanFacade.class);
		FindRpStroeListVO findRpStoreVO = new FindRpStroeListVO();
		findRpStoreVO.setItemNo(itemNo);
		findRpStoreVO.setDcStoreNo(dcStoreNo);
		List<RpStroeListVO> rpStoreList = rpf.findRpStroeList(findRpStoreVO);
		model.addAttribute("rpStoreList", rpStoreList);
		return "rp/plan/choiceOfStoreList";
	}
	
	/**
	 * 進入RP保留計畫導入頁面
	 */
	@RequestMapping("/startImport")
	public String startImport(Model model){
		//TODO
		
		return "rp/plan/import/main";
	}
	
	/**
	 * RP保留計畫導入 (插入 Ltable) 
	 * @param file
	 * @param model
	 * @param response
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("/importExcel2db")
	public void importExcel2db(@RequestParam("file") CommonsMultipartFile file,Model model,HttpServletResponse response) {
		Map<String, Object> retMap = new HashMap<String, Object>();
		Double processId = null;
		retMap.put(STATUS,SUCCESS);
		retMap.put(MESSAGE, "导入成功");
		try {
			Map<String, Object> parseResult = RPReadExcel.processRowExcel(file.getInputStream());
			System.out.println(parseResult.toString());
			RpBatchImportFacade rpbf = ServiceUtil.getService("rpBatchImportFacade", RpBatchImportFacade.class);
			
			// 版本, 課別, 物流中心編號, 門店確認, 門店確認和補貨時間如果有誤, 直接回到頁面顯示錯誤訊息
			if ((Integer)parseResult.get("overallErr") == 1){
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, parseResult.get("overallErrMsg"));
			}
			else {
				LBatchRpDmVO rpDm = (LBatchRpDmVO)parseResult.get("rpDm");
				// 先做初步的資料驗證, 通過了才會有 processId
				processId = rpbf.checkRpDmValid(rpDm);
				if (processId != null && !processId.equals("")){
					retMap.put(STATUS, SUCCESS);
					rpbf.createRpDM(processId, rpDm);
					rpbf.createRpItem(processId, (List<LBatchRpItemVO> )parseResult.get("rpDmItem"));
					rpbf.checkOrder(processId);
				}else{
					retMap.put(STATUS, ERROR);
					retMap.put(MESSAGE, "Not sure what s going on... where is my error code?");
				}
				
			}
		}catch (Exception e1) {
			Throwable t0 = e1.getCause();
			if (t0 != null && t0 instanceof RPException) {
				String errorCode = ((RPException) t0).getErrorCode();
				String prefix = ((RPException) t0).getErrorCodeClassfier();
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, getErrorTitle(prefix,errorCode));
			}else{
				e1.printStackTrace();
				retMap.put(STATUS,ERROR);
				retMap.put(MESSAGE, "档案有误, 请重新上传");
			}	
		}
		// 將 processId 傳回頁面
		retMap.put(CONTENT, processId);

		String json=JsonUtil.java2json(retMap);
		PrintWriter pw;
		try {
			response.setContentType("text/html;charset=UTF-8"); 
			pw = response.getWriter();
			pw.write("<script>parent.callback('"+json+"')</script>");
		} catch (IOException e) {
//			log.error(e);
		}
	}	
	
	/**
	 * RP保留計畫導入  (導入清單後, 傳回RP的基本資料)
	 * @param model
	 * @param page
	 * @param processId
	 * @return
	 */
	@RequestMapping("/getTempRecord")
	public String getTempRecord(Model model, Double processId) {
		RpBatchImportFacade rpbf = ServiceUtil.getService("rpBatchImportFacade", RpBatchImportFacade.class);
		LBatchRpDmVO rpDmVO = rpbf.getRpDM(processId);
		LBatchRpTotalVO rpTotalVO = rpbf.getRPTotal(processId);
		// 查出 excel 裡面總共有多少筆數
		Integer totalCount = rpbf.getTotalCount(processId);
		model.addAttribute("rpDmVO", rpDmVO);
		model.addAttribute("validInfo", rpTotalVO);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("processId", processId);
		
		return "rp/plan/import/content";
	}
	
	/**
	 * RP保留計畫導入, 傳回導入正確的清單
	 * @param model
	 * @param page
	 * @param processId
	 * @return
	 */
	@RequestMapping("/getTempRpValidPage")
	public String getTempOrderValidPage(HttpServletRequest request, Model model, Page page, Double processId){
		RpBatchImportFacade rpbf = ServiceUtil.getService("rpBatchImportFacade", RpBatchImportFacade.class);
		LBatchRpTotalVO totalInfoVO = null;
		if (page == null){
			page.setPageNo(1);
			page.setPageSize(20);
		}
		// 將頁面上的修改更新進資料庫
		this.updateLRpItemValid(request);
		PaginationSettings ps = new PaginationSettings();
		PaginationResult validPr = null;
		ps.setPageNo(page.getPageNo());
		ps.setPageSize(page.getPageSize());
		Ordering order = new Ordering(true, "rowNum");
		List<Ordering> sortList = new ArrayList<Ordering> ();
		sortList.add(order);
		ps.setOrderBy(sortList);
		validPr = rpbf.searchRpDmItemValidByPage(processId, ps);
		if (validPr != null && validPr.getTotalCount() > 0){
			page.setTotalCount(validPr.getTotalCount());
			page.setResult(validPr.getData());
			//TODO: 確認一下 getRPTotal 是是計算 valid 的總價值
			totalInfoVO = rpbf.getRPTotal(processId);
		}
		else{
			page.setTotalCount(0);
			page.setResult(null);
		}
		model.addAttribute("processId", processId);
		model.addAttribute("validInfo", totalInfoVO);
		model.addAttribute("page", page);
		return "rp/plan/import/validStoreDetail";
	}
	/**
	 * RP保留計畫導入, 傳回導入失敗的筆數
	 * @param request
	 * @param model
	 * @param page
	 * @param processId
	 * @param errorCode 錯誤代號可為空
	 * @return
	 */
	@RequestMapping("/getTempRpInvalidPage")
	public String getTempRpInvalidPage(HttpServletRequest request, Model model, Page page, Double processId, Integer errorCode){
		RpBatchImportFacade rpbf = ServiceUtil.getService("rpBatchImportFacade", RpBatchImportFacade.class);
		LBatchRpItemInvalidVO invalidVO = null;
		if (page == null){
			page.setPageNo(1);
			page.setPageSize(20);
		}
		// 將頁面上的修改更新進資料庫
		this.updateLRpItemValid(request);
		PaginationSettings ps = new PaginationSettings();
		PaginationResult invalidPr = null;
		ps.setPageNo(page.getPageNo());
		ps.setPageSize(page.getPageSize());
		Ordering order = new Ordering(true, "rowNum");
		List<Ordering> sortList = new ArrayList<Ordering> ();
		sortList.add(order);
		ps.setOrderBy(sortList);
		invalidPr = rpbf.searchRpDmItemInValidByPage(processId, errorCode, ps);
		if (invalidPr != null && invalidPr.getTotalCount() >0){
			page.setTotalCount(invalidPr.getTotalCount());
			page.setResult(invalidPr.getData());
		}
		else{
			page.setTotalCount(0);
			page.setResult(null);
		}
		model.addAttribute("processId", processId);
		model.addAttribute("page", page);
		return "rp/plan/import/invalid";
	}
	
	/**
	 * RP保留計畫, 導入成功頁面, 將頁面上的 input 更新回資料庫
	 * @param request
	 * @return
	 */
	public Boolean updateLRpItemValid(HttpServletRequest request){
		Object[] obj = request.getParameterValues("itemNo");
		Integer rowIndexCount = obj != null ? (Integer) obj.length : 0;		
		if (rowIndexCount >0){
			RpBatchImportFacade rpbf = ServiceUtil.getService("rpBatchImportFacade", RpBatchImportFacade.class);
			List<LBatchRpItemVO> list = new ArrayList<LBatchRpItemVO> ();
			for (int i = 0; i < rowIndexCount; i++){
				LBatchRpItemVO rpvo = new LBatchRpItemVO();
				rpvo.setItemNo(request.getParameterValues("itemNo")[i]);
				rpvo.setProcessId(Double.valueOf(request.getParameterValues("processId")[0]));
				rpvo.setBuyPrice(request.getParameterValues("buyPrice")[i]);
				rpvo.setOrdMultiParm(request.getParameterValues("ordMultiParm")[i]);
				rpvo.setInitTotQty(request.getParameterValues("initTotQty")[i]);
				rpvo.setInitTotAmnt(request.getParameterValues("initTotAmnt")[i]);
				list.add(rpvo);
			}
			rpbf.updateRpDmItemValid(list);
		}
		return true;
	}
	
	/**
	 * RP保留計畫導入成功頁面, 將分店詳情的資料更新回資料庫
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateLRpStoreDetail")
	public Map updateLRpStoreDetail(HttpServletRequest request){
		Map<String, Object> retMap = new HashMap<String, Object> ();
		Object[] obj = request.getParameterValues("storeNo");
		Map<String, Object> contentMap = new HashMap<String, Object>();

		try{
			Integer rowIndexCount = obj != null ? (Integer) obj.length : 0;		
			if (rowIndexCount >0){
				RpBatchImportFacade rpbf = ServiceUtil.getService("rpBatchImportFacade", RpBatchImportFacade.class);
				List<LBatchRpItemVO> list = new ArrayList<LBatchRpItemVO> ();
				for (int i = 0; i < rowIndexCount; i++){
					LBatchRpItemVO rpvo = new LBatchRpItemVO();
					rpvo.setItemNo(request.getParameterValues("itemNo")[0]);
					rpvo.setProcessId(Double.valueOf(request.getParameterValues("processId")[0]));
					rpvo.setStoreNo(request.getParameterValues("storeNo")[i]);
					rpvo.setStoreQty(request.getParameterValues("storeQty")[i]);
					list.add(rpvo);
				}
				contentMap.put("totalOrdQty", request.getParameterValues("totalOrdQty")[0]);
				contentMap.put("itemNo", request.getParameterValues("itemNo")[0]);
				rpbf.updateRpDmStoreDetail(list);
			}
		}
		catch(Exception e){
			e.printStackTrace();
			retMap.put(STATUS, ERROR);
		}
		retMap.put(STATUS,SUCCESS);
		retMap.put(CONTENT, contentMap);
		return retMap;
	}
	
	/**
	 * RP保留計畫導入頁面, 顯示分店詳細資料
	 * @param model
	 * @param processId
	 * @param itemNo
	 * @param itemName
	 * @param ordMultiParm
	 * @return
	 */
	@RequestMapping("/showStoreDetail")
	public String showStoreDetail(Model model, Double processId, Integer itemNo, String itemName, Integer ordMultiParm){
		RpBatchImportFacade rpbf = ServiceUtil.getService("rpBatchImportFacade", RpBatchImportFacade.class);
		List<LBatchRpStoreVO> list= null;
		list = rpbf.getStoreDetail(processId, itemNo);
		model.addAttribute("processId", processId);
		model.addAttribute("itemNo", itemNo);
		model.addAttribute("itemName", itemName);
		model.addAttribute("ordMultiParm", ordMultiParm);
		model.addAttribute("result", list);
		return "rp/plan/import/storeDetail";
	}
	
	/**
	 * RP保留計畫導入頁面, 儲存導入的保留計畫
	 * @param model
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/saveToRpPlan")
	public Map saveToRpPlan (Model model, HttpServletRequest request){
		Map<String, Object> retMap = new HashMap<String, Object> ();
		RpBatchImportFacade rpbf = ServiceUtil.getService("rpBatchImportFacade", RpBatchImportFacade.class);
		// 先更新頁面上的所有 input
		if (updateLRpItemValid(request)){
			Double processId = Double.valueOf(request.getParameterValues("processId")[0]);
			rpbf.makeOrder(processId);
		}
		retMap.put(STATUS, SUCCESS);
		retMap.put(MESSAGE, "保存成功");
		return retMap;
	}
	
	public boolean StringEqualNull(String str){
		if("null".equalsIgnoreCase(str)){
			return false;
		}else{
			return true;
		}
	}

	/**
	 * 选择商品的弹出框
	 * @param model
	 * @return
	 */
	@RequestMapping("/choiceItemWin")
	public String choiceItemWin(Model model){
		return "rp/plan/choiceOfItemWin";
	}
	
	/**
	 * 查询商品结果
	 * @param model
	 * @param page
	 * @param findRpItemInfoVo
	 * @return
	 */
	@RequestMapping("/choiceItemList")
	public String choiceItemList(Model model, Page page, FindRpItemInfoVO findRpItemInfoVo){
		RpPlanFacade rpf = ServiceUtil.getService("rpPlanFacade", RpPlanFacade.class);
		//设置分页
		PaginationSettings ps = new PaginationSettings();
		ps.setPageNo(page.getPageNo());
		ps.setPageSize(page.getPageSize());
		Ordering order = new Ordering(true, "itemNo");
		List<Ordering> sortList = new ArrayList<Ordering> ();
		sortList.add(order);
		ps.setOrderBy(sortList);
		//设置参数
		findRpItemInfoVo.setMinStatus(1);
		//结果查询
		PaginationResult result = rpf.findRpItemInfoByPage(ps, findRpItemInfoVo);
		if (SpringUtil.isNotEmpty(result.getData())) {
			page.setResult(result.getData());
			page.setTotalCount(result.getTotalCount());
		}
		model.addAttribute("page", page);
		return "rp/plan/choiceOfItemList";
	}
	
	//新增批量商品弹出框
	@RequestMapping("/pasteItemNo")
	public String pasteItemNo(Model model){
		return "rp/plan/pasteItemNo";
	}
	
	/**
	 * 批量商品数据
	 * @param itemNoArray
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/batchUnitDataAction")
	public Map<String, Object> batchUnitData(String [] itemNoArray){
		return null;
	}
	
	@ResponseBody
	@RequestMapping("/updateStoreOrdQty")
	public Map<String, Object> updateStoreOrdQty(Double processId, Integer itemNo, Integer ordMultiParm, Double buyPrice){
		Map<String, Object> retMap = new HashMap<String, Object> ();
		
		if (processId == null || itemNo == null || ordMultiParm == null){
			retMap.put(STATUS, ERROR);
			return retMap;
		}
		Map<String, Object> contentMap = new HashMap<String, Object> ();
		RpBatchImportFacade rpbf = ServiceUtil.getService("rpBatchImportFacade", RpBatchImportFacade.class);
		LBatchRpItemVO rpVO = rpbf.updateStoreOrdQty(processId, itemNo, ordMultiParm, buyPrice);
		LBatchRpTotalVO totalVO = rpbf.getRPTotal(processId);
		contentMap.put("initTotQty", rpVO.getInitTotQty());
		contentMap.put("initTotAmnt", rpVO.getInitTotAmnt());
		contentMap.put("totQuantity", totalVO.getRpTotQty());
		contentMap.put("totAmount", totalVO.getRpTotAmnt());
		contentMap.put("itemNo", itemNo);
		retMap.put(STATUS, SUCCESS);
		retMap.put("CONTENT", contentMap);
		return retMap;
	}
	
	/**
     * 弹出门店。
     * 
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/openStoreWin")
	public String openStoreWin(Model model, HttpServletRequest request) {
		return "rp/plan/planStoresShowNew";
	}
    
    /**
     * 获取大卖场 
     * 
     * @param model
     * @param itemNo
     * @param supId
     * @param catlgId
     * @return
     */
	@ResponseBody
	@RequestMapping("getItemRegion")
	public Map<String, Object> getSupStoreInfo(Model model, Integer itemNo,
			Integer supId, Integer catlgId) {
		    Map<String, Object> jsonMap = new HashMap<String, Object>();
		    List<TreeVo> treeList = this.getTreeList(model,itemNo,supId);
			jsonMap.put("tree", treeList);
		    return jsonMap;
	}
	
	/**
	 * 大卖场封装tree
	 * @param model
	 * @param itemNo
	 * @param supId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("getItemRegions")
	public List<TreeVo> getTreeList(Model model, Integer itemNo,Integer supId) {
		RpPlanFacade rpf = ServiceUtil.getService("rpPlanFacade", RpPlanFacade.class);
		FindRpRegionByItemNoVO findRpRegionByItemNoVo = new FindRpRegionByItemNoVO();
		List<Integer> typeArray = new ArrayList<Integer>();
		typeArray.add(1);
		findRpRegionByItemNoVo.setBizTypeList(typeArray);
		List<Integer> statusArray = new ArrayList<Integer>();
		statusArray.add(1);
		statusArray.add(2);
		findRpRegionByItemNoVo.setStatusList(statusArray);
		findRpRegionByItemNoVo.setDcStoreNo(supId);
		findRpRegionByItemNoVo.setItemNo(itemNo);
		List<RpRegionInfoVO> regList = rpf.getRegionByItemNo(findRpRegionByItemNoVo);
		List<TreeVo> treeList = new ArrayList<TreeVo>();
		for (RpRegionInfoVO vo : regList) {
			String id = (vo.getAssrtId() != null) ? vo.getAssrtId().toString()
					: "";
			String pid = (vo.getParntAssrtId() != null) ? vo.getParntAssrtId()
					.toString() : "";
			String text = vo.getRegnName();
			TreeVo parentTreeVo = null;
			if (StringUtils.isBlank(pid)) {
				treeList.add(new TreeVo(id, text, "open",
						new ArrayList<TreeVo>()));
				continue;
			}
			parentTreeVo = findParentNodeByTree(treeList, pid);
			if (null != parentTreeVo) {
				List<TreeVo> list = parentTreeVo.getChildren();
				if (null == list) {
					list = new ArrayList<TreeVo>();
					parentTreeVo.setChildren(list);
				}
				list.add(new TreeVo(id, text, "closed", new ArrayList<TreeVo>()));
			} else {
				treeList.add(new TreeVo(id, text, "open",
						new ArrayList<TreeVo>()));
			}
		}
		return treeList;
	}
	
	/**
	 * 获取大卖场下的门店
	 * @param model
	 * @param itemNo
	 * @param regnNoList
	 * @param supId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("getStoreList")
	public List<RpRegionStoreVO> getStoreList(Model model, Integer itemNo, Integer [] regnNoList,Integer supId) {
		RpPlanFacade rpf = ServiceUtil.getService("rpPlanFacade", RpPlanFacade.class);
		FindRpStoreListByRegnVO findRpStoreListByRegnVo = new FindRpStoreListByRegnVO();
		List<Integer> typeArray = new ArrayList<Integer>();
		typeArray.add(1);
		findRpStoreListByRegnVo.setBizTypeList(typeArray);
		findRpStoreListByRegnVo.setDcStoreNo(supId);
		findRpStoreListByRegnVo.setItemNo(itemNo);
		List<Integer> statusArray = new ArrayList<Integer>();
		statusArray.add(1);
		statusArray.add(2);
		findRpStoreListByRegnVo.setStatusList(statusArray);
		
		if(SpringUtil.isNotEmpty(regnNoList))
		{
			List<Integer> regnnolist = new ArrayList<Integer>();
			for(int i = 0; i < regnNoList.length; i++)
			{
				regnnolist.add(regnNoList[i]);
			}
			findRpStoreListByRegnVo.setRegnNoList(regnnolist);
		}
		else{
			return null;
		}
		List<RpRegionStoreVO> storeList = rpf.getRegionStoreByItemNo(findRpStoreListByRegnVo);
		return storeList;
	}


}
