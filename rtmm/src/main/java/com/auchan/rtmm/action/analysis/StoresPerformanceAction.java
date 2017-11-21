package com.auchan.rtmm.action.analysis;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.auchan.common.codetable.utils.CodeTableI18NUtil;
import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.common.common.Ordering;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.prom.service.StoresPerformanceFacade;
import com.auchan.rtmm.prom.vo.SearchStoresPerformanceVO;
import com.auchan.rtmm.prom.vo.StoresPerformanceVO;
import com.auchan.rtmm.util.DateUtils;
import com.auchan.rtmm.util.Page;

@Controller
@RequestMapping(value = "/analysis/storesPerformance")
public class StoresPerformanceAction {
    @ModelAttribute
    public void setAttribute(Model model){
    	//1	正常
    	model.addAttribute("Normal",CodeTableI18NUtil.getMsgById("106001018").getTitle());
    	//2	促销
    	model.addAttribute("Promotion",CodeTableI18NUtil.getMsgById("106001019").getTitle());
    	//3	分店数量
    	model.addAttribute("StoreNumber",CodeTableI18NUtil.getMsgById("106001026").getTitle());
    	//4	销售总额
    	model.addAttribute("TotalTurnover",CodeTableI18NUtil.getMsgById("106001032").getTitle());
    	//5	促销销售额
    	model.addAttribute("PromotionTurnover",CodeTableI18NUtil.getMsgById("106001033").getTitle());
    	//6	地区所占比例
    	model.addAttribute("AreaRate",CodeTableI18NUtil.getMsgById("106001027").getTitle());
    	//7	正常销售额
    	model.addAttribute("NormalTurnover",CodeTableI18NUtil.getMsgById("106001031").getTitle());
    	//8	促销类型所占比例
    	model.addAttribute("Promotion(%)",CodeTableI18NUtil.getMsgById("106001023").getTitle());
    	//9	来客数
    	model.addAttribute("CustomerNumber",CodeTableI18NUtil.getMsgById("106001013").getTitle());
    	//10所占比例
    	model.addAttribute("Rate",CodeTableI18NUtil.getMsgById("106001028").getTitle());
    	//11总毛利率
    	model.addAttribute("Margin",CodeTableI18NUtil.getMsgById("106001014").getTitle());
    	//12正常毛利率
    	model.addAttribute("NormalMargin",CodeTableI18NUtil.getMsgById("106001029").getTitle());
    	//13促销毛利率
    	model.addAttribute("PromotionMargin",CodeTableI18NUtil.getMsgById("106001030").getTitle());
    	//14客单价
    	model.addAttribute("AverageBasket",CodeTableI18NUtil.getMsgById("106001015").getTitle());
    	//15 销售额
    	model.addAttribute("Turnover",CodeTableI18NUtil.getMsgById("106001012").getTitle());
    	//15 客单（元）
    	model.addAttribute("TurnoverY",CodeTableI18NUtil.getMsgById("106001025").getTitle());
    	//元
    	model.addAttribute("Yuan",CodeTableI18NUtil.getMsgById("106001034").getTitle());
    	//地区
    	model.addAttribute("Region",CodeTableI18NUtil.getMsgById("106001035").getTitle());
    	//百分比(%)
    	model.addAttribute("Percent",CodeTableI18NUtil.getMsgById("106001036").getTitle());
    	//${QYuan}
    	model.addAttribute("QYuan",CodeTableI18NUtil.getMsgById("106001037").getTitle());
    	//请选择查询日期
    	model.addAttribute("PleeaseSelectDate",CodeTableI18NUtil.getMsgById("106001039").getTitle());
    	//请选择要查询的区域
    	model.addAttribute("PleaseSelectRegion",CodeTableI18NUtil.getMsgById("106001038").getTitle());
    	//提示信息
    	model.addAttribute("message",CodeTableI18NUtil.getMsgById("100000001").getTitle());
    	//最少选择一个区域
    	model.addAttribute("PleaseSelectAReginAtLeast",CodeTableI18NUtil.getMsgById("106001040").getTitle());
    	//日历控件
    	model.addAttribute("calendarL",CodeTableI18NUtil.getMsgById("100003001").getTitle());
    }
	 
	 
	/**
	 * 分店业绩查询页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/storePerformacePage")
	public String storePerformacePage(HttpServletRequest request,Model model){
		Date sysDate = new Date();
		String beforeDate = DateUtils.parseDate2Str(DateUtils.dayOffset(sysDate, -1), "yyyy-MM-dd");
		StoresPerformanceFacade spf = ServiceUtil.getService("storesPerformanceFacade", StoresPerformanceFacade.class);
		List areaList = spf.getAreaList();
		model.addAttribute("areaList", areaList);
		model.addAttribute("workDate", beforeDate);
		return "analysis/storesPerformance/query/storePerformancePage";
	}
	
	/**
	 *  门店业绩查询的List分页列表
	 * @param request
	 * @param model
	 * @param page
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping("/storesPerformanceList")
	public String storesPerformanceList(HttpServletRequest request,Model model,Page<StoresPerformanceVO> page) throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");   
		SearchStoresPerformanceVO sspfVo = new SearchStoresPerformanceVO();
		List<String> areaList = new ArrayList<String>();
		String areaStr = request.getParameter("areaStr");
		String workDate = request.getParameter("analysisDate");
		//String pageNo = request.getParameter("pageNo");
		//String pageSize = request.getParameter("pageSize");
		if(areaStr.length() > 0){
			String[] areaArray = areaStr.split(",");
			for (int i = 0; i < areaArray.length; i++) {
				areaList.add(areaArray[i]);
			}
			sspfVo.setIncludeRegnNoList(areaList);
		}
		if(workDate.length() > 0){
			sspfVo.setPerformanceDate(sdf.parse(workDate));
		}
		if (null == page){
			page = new Page<StoresPerformanceVO>(); 
		}
		StoresPerformanceFacade spfService = ServiceUtil.getService("storesPerformanceFacade", StoresPerformanceFacade.class);
		PaginationSettings ps = new PaginationSettings();
		/*if(pageNo.length()>0){
			ps.setPageNo(Integer.valueOf(pageNo));
		}
		if(pageSize.length() > 0){
			
			ps.setPageSize(Integer.valueOf(pageSize));
		}*/
		ps.setPageNo(page.getPageNo());
		ps.setPageSize(20000);
		Ordering order = new Ordering(false,"totSalesAmnt");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		ps.setOrderBy(olist);
		PaginationResult paginationResult  = spfService.getStorePerfromcePageList(ps, sspfVo);
		
		if (0 != paginationResult.getTotalCount()) {
			page.setResult(paginationResult.getData());
			page.setTotalCount(paginationResult.getTotalCount());
		}
		
		model.addAttribute("page", page);
		return "analysis/storesPerformance/query/storesPerformanceList";
	}
	
	@RequestMapping("/showImageData")
	@ResponseBody
	public Map<String, Object> showImageData(HttpServletRequest request,Model model) throws ParseException{
		Map<String, Object> map = new HashMap<String, Object>();
		DecimalFormat df = new DecimalFormat("0.00");
		String workDate = request.getParameter("analysisDate");
		if("1".equals(workDate)){
			workDate = DateUtils.parseDate2Str(DateUtils.dayOffset(new Date(), -1), "yyyy-MM-dd");
		}
		String areaStr = request.getParameter("areaStr");
		List<StoresPerformanceVO> ls = getDateListBy(workDate,areaStr);
		
		map.put("salelist", conSalesData(ls));
		map.put("visitorlist", conVisitorsData(ls));
		map.put("grossMarginlist", conGrossMarginData(ls));
		map.put("custPricelist", conCustPriceData(ls));
		return map;
		
	}
	
	/**
	 * 获取销售额
	 * @param request
	 * @param model
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping("/getSalesData")
	@ResponseBody
	public Map<String, Object> getSalesData(HttpServletRequest request,Model model) throws ParseException{
		Map<String, Object> map = new HashMap<String, Object>();
		DecimalFormat df = new DecimalFormat("0.00"); 
		String workDate = request.getParameter("analysisDate");
		if("1".equals(workDate)){
			workDate = DateUtils.parseDate2Str(DateUtils.dayOffset(new Date(), -1), "yyyy-MM-dd");
		}
		String areaStr = request.getParameter("areaStr");
		List<StoresPerformanceVO> ls = getDateListBy(workDate,areaStr);
		map.put("list", conSalesData(ls));
		return map;
	}
	
	public static List conSalesData(List<StoresPerformanceVO> ls){
		/*//正常所占比率
		public String promRatio;
		//促销所占比率
		public String noralRatio;
		//地区正常所占比率
		public String areaPromRatio;
		//地区促销所占比率
		public String areaNoramlRatio;*/
		List<AnalysisVO> AnalysisVOList = new ArrayList<AnalysisVO>();
		DecimalFormat df = new DecimalFormat("0.00");
		Double saleTotal=0.0;
		Double promSalesTotal=0.0;
		Double normalSalesTotel=0.0;
		for (int i = 0; i < ls.size(); i++) {
			StoresPerformanceVO storesPerformanceVO=ls.get(i);
			saleTotal+=storesPerformanceVO.getAreaTotSalesAmnt();
			promSalesTotal+=storesPerformanceVO.getAreaPromSalesAmnt();
			normalSalesTotel+=storesPerformanceVO.getAreaNormSalesAmnt();
		}
		
		for (int i = 0; i < ls.size(); i++) {
			StoresPerformanceVO storesPerformanceVO=ls.get(i);
			AnalysisVO analysis1 = new AnalysisVO();
			analysis1.setAreaName(storesPerformanceVO.getRegnName());
			analysis1.setType("0");//正常
			analysis1.setAreaNo(storesPerformanceVO.getRegnNo().toString());
			//areaNoramlRatio+"&"+color+"&"+areaStoreAmount+"&"+areaSalesTotal+"&"+areaPromSalesTotal;
			analysis1.setAreaPromRatio(df.format((storesPerformanceVO.getAreaPromSalesAmnt()/saleTotal)*100)+"");
			analysis1.setAreaNoramlRatio(df.format((storesPerformanceVO.getAreaNormSalesAmnt()/saleTotal)*100)+"");
			analysis1.setPromRatio(df.format((promSalesTotal/saleTotal)*100)+"");
			analysis1.setNormalRatio(df.format((normalSalesTotel/saleTotal)*100)+"");
			analysis1.setAreaStoreAmount(storesPerformanceVO.getAreaStoreCount().toString());
			analysis1.setAreaSalesTotal(storesPerformanceVO.getAreaTotSalesAmnt().toString());//地区的总销售额
			analysis1.setAreaPromSalesTotal(storesPerformanceVO.getAreaPromSalesAmnt().toString());//地区的促销销售额
			analysis1.setAreaNoramlSalesTotal(storesPerformanceVO.getAreaNormSalesAmnt().toString());//地区的正常销售额
			analysis1.setSaleTotal(saleTotal.toString());
			analysis1.setPromSalesTotal(promSalesTotal.toString());
			analysis1.setNormalSalesTotel(normalSalesTotel.toString());
			AnalysisVOList.add(analysis1);
			
			AnalysisVO analysis2= new AnalysisVO();
			analysis2.setAreaName(storesPerformanceVO.getRegnName());
			analysis2.setType("1");
			analysis2.setAreaNo(storesPerformanceVO.getRegnNo().toString());
			analysis2.setAreaPromRatio(df.format((storesPerformanceVO.getAreaPromSalesAmnt()/saleTotal)*100)+"");
			analysis2.setAreaNoramlRatio(df.format((storesPerformanceVO.getAreaNormSalesAmnt()/saleTotal)*100)+"");
			analysis2.setPromRatio(df.format((promSalesTotal/saleTotal)*100)+"");
			analysis2.setNormalRatio(df.format((normalSalesTotel/saleTotal)*100)+"");
			analysis2.setAreaStoreAmount(storesPerformanceVO.getAreaStoreCount().toString());
			analysis2.setAreaSalesTotal(storesPerformanceVO.getAreaTotSalesAmnt().toString());//地区的总销售额
			analysis2.setAreaPromSalesTotal(storesPerformanceVO.getAreaPromSalesAmnt().toString());//地区的促销销售额
			analysis2.setAreaNoramlSalesTotal(storesPerformanceVO.getAreaNormSalesAmnt().toString());//地区的正常销售额
			analysis2.setSaleTotal(saleTotal.toString());
			analysis2.setPromSalesTotal(promSalesTotal.toString());
			analysis2.setNormalSalesTotel(normalSalesTotel.toString());
			AnalysisVOList.add(analysis2);
		
		}
		return AnalysisVOList;
	}
	
	/**
	 * 获取访问量
	 * @param request
	 * @param model
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping("/getVisitorsData")
	@ResponseBody
	public Map<String, Object> getVisitorsData(HttpServletRequest request,Model model) throws ParseException{
		Map<String, Object> map = new HashMap<String, Object>();
		
		String workDate = request.getParameter("analysisDate");
		String areaStr = request.getParameter("areaStr");
		if("1".equals(workDate)){
			workDate = DateUtils.parseDate2Str(DateUtils.dayOffset(new Date(), -1), "yyyy-MM-dd");
		}
		//根据时间和地区编号查询客户访问量
		List<StoresPerformanceVO> ls = getDateListBy(workDate,areaStr);
		map.put("list", conVisitorsData(ls));
		return map;
	}
	
	public static List conVisitorsData(List<StoresPerformanceVO> ls){
		double total = 0;
		List<AnalysisVO> AnalysisVOList = new ArrayList<AnalysisVO>();
		for (int j = 0; j < ls.size(); j++) {
			StoresPerformanceVO spftotal = ls.get(j);
			if(spftotal.getAreaNbrVisit() != null){
				total = total + spftotal.getAreaNbrVisit();
			}
		}
		
		for (int i = 0; i < ls.size(); i++) {
			StoresPerformanceVO spf = ls.get(i);
			AnalysisVO analysisVO = new AnalysisVO();
			analysisVO.setAreaName(spf.getRegnName());	
			analysisVO.setAreaNo(spf.getRegnNo().toString());
			//analysisVO.setAssrtId(spf.getAssrtId());
			
			analysisVO.setAreaStoreAmount(spf.getAreaStoreCount().toString());
			if(spf.getAreaNbrVisit() !=null){
				analysisVO.setAreaVistorRatio((int)Math.round((spf.getAreaNbrVisit()/total)*100)+"");
				analysisVO.setAreaVistorTotal(spf.getAreaNbrVisit().toString());
			}else{
				analysisVO.setAreaVistorRatio("0");
				analysisVO.setAreaVistorTotal("0");
			}
			
			AnalysisVOList.add(analysisVO);
		}
		return AnalysisVOList;
	}
	/**
	 * 获取毛利率
	 * @param request
	 * @param model
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping("/getGrossMarginData")
	@ResponseBody
	public Map<String, Object> getGrossMarginData(HttpServletRequest request,Model model) throws ParseException{
		StoresPerformanceFacade spfService = ServiceUtil.getService("storesPerformanceFacade", StoresPerformanceFacade.class);
		List<String> areaNoList = new ArrayList<String>();
		Map<String, Object> map = new HashMap<String, Object>();
		String workDate = request.getParameter("analysisDate");
		String areaStr = request.getParameter("areaStr");
		String[] areaStrArray = areaStr.split(",");
		String notCluedAreaNo = "";
		if("1".equals(workDate)){
			workDate = DateUtils.parseDate2Str(DateUtils.dayOffset(new Date(), -1), "yyyy-MM-dd");
		}
		List<StoresPerformanceVO> ls = getDateListBy(workDate,areaStr);
		if(ls.size()!=areaStrArray.length){
			for (int i = 0; i < ls.size(); i++) {
				areaNoList.add(ls.get(i).getRegnNo().toString());
			}
			for (int j = 0; j < areaStrArray.length; j++) {
				String areaNo = areaStrArray[j];
				if(!areaNoList.contains(areaNo)){
					notCluedAreaNo += areaNo+",";
				}
			}
			List<StoresPerformanceVO> list = spfService.getAreaListBy(notCluedAreaNo.substring(0, notCluedAreaNo.length()-1));
			for (int w = 0; w < list.size(); w++) {
				StoresPerformanceVO spfv = list.get(w);
				spfv.setAreaTotMarginRate(0.0);
				spfv.setAreaNormMarginRate(0.0);
				spfv.setAreaPromMarginRate(0.0);
				/*spfv.setNetMaoriTotal(df.format(spf.getAreaTotMarginRate()));
				v.setNormalNetMaori(df.format((spf.getAreaNormMarginRate())));
				analysisVO.setPromNetMaori(df.format((spf.getAreaPromMarginRate())));*/
				ls.add(spfv);
			}
			/*for (int i = 0; i < areaStrArray.length; i++) {
				areaStr =areaStrArray[i];
				if(ls.contains(areaStr)){
					
				}
			}*/
		}
		map.put("list", conGrossMarginData(ls));
		return map;
	}
	
	public static List conGrossMarginData(List<StoresPerformanceVO> ls){
		List<AnalysisVO> AnalysisVOList = new ArrayList<AnalysisVO>();
		DecimalFormat df = new DecimalFormat("0.00");
		for (int i = 0; i < ls.size(); i++) {
			StoresPerformanceVO spf = ls.get(i);
			AnalysisVO analysisVO = new AnalysisVO();
			analysisVO.setAreaName(spf.getRegnName());
			analysisVO.setAreaNo(spf.getRegnNo().toString());
			//(int)Math.round((spf.getTotMarginRate()))+""
			analysisVO.setNetMaoriTotal(df.format(spf.getAreaTotMarginRate()));
			analysisVO.setNormalNetMaori(df.format((spf.getAreaNormMarginRate())));
			analysisVO.setPromNetMaori(df.format((spf.getAreaPromMarginRate())));
			AnalysisVOList.add(analysisVO);
		}		
		return AnalysisVOList;
	}
	
	/**
	 * 获取客单价
	 * @param request
	 * @param model
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping("/getCustPriceData")
	@ResponseBody
	public Map<String, Object> getCustPriceData(HttpServletRequest request,Model model) throws ParseException{
		StoresPerformanceFacade spfService = ServiceUtil.getService("storesPerformanceFacade", StoresPerformanceFacade.class);
		Map<String, Object> map = new HashMap<String, Object>();
		List<String> areaNoList = new ArrayList<String>();
		String workDate = request.getParameter("analysisDate");
		String areaStr = request.getParameter("areaStr");
		String[] areaStrArray = areaStr.split(",");
		String notCluedAreaNo = "";
		if("1".equals(workDate)){
			workDate = DateUtils.parseDate2Str(DateUtils.dayOffset(new Date(), -1), "yyyy-MM-dd");
		}
		List<StoresPerformanceVO> ls = getDateListBy(workDate,areaStr);
		if(ls.size()!=areaStrArray.length){
			for (int i = 0; i < ls.size(); i++) {
				areaNoList.add(ls.get(i).getRegnNo().toString());
			}
			for (int j = 0; j < areaStrArray.length; j++) {
				String areaNo = areaStrArray[j];
				if(!areaNoList.contains(areaNo)){
					notCluedAreaNo += areaNo+",";
				}
			}
			List<StoresPerformanceVO> list = spfService.getAreaListBy(notCluedAreaNo.substring(0, notCluedAreaNo.length()-1));
			for (int w = 0; w < list.size(); w++) {
				StoresPerformanceVO spfv = list.get(w);
				spfv.setAreaAvgBasket(0.00);
				ls.add(spfv);
			}
			/*for (int i = 0; i < areaStrArray.length; i++) {
				areaStr =areaStrArray[i];
				if(ls.contains(areaStr)){
					
				}
			}*/
		}
		map.put("list", conCustPriceData(ls));
		return map;
	}
	public static List conCustPriceData(List<StoresPerformanceVO> ls){
		List<AnalysisVO> AnalysisVOList = new ArrayList<AnalysisVO>();
		DecimalFormat df = new DecimalFormat("#.00");
		for (int i = 0; i < ls.size(); i++) {
			StoresPerformanceVO spf = ls.get(i);
			AnalysisVO analysisVO = new AnalysisVO();
			analysisVO.setAreaName(spf.getRegnName());
			analysisVO.setAreaNo(spf.getRegnNo().toString());
			if(spf.getAreaAvgBasket() != null){
				analysisVO.setCustomerPrice(df.format(spf.getAreaAvgBasket()).toString());
			}else{
				analysisVO.setCustomerPrice("0.0");
				
			}
			
			AnalysisVOList.add(analysisVO);
		}
		return AnalysisVOList;
	}
	@RequestMapping("/showDetail")
	public String showDetail(HttpServletRequest request,Model model) throws UnsupportedEncodingException{
		StoresPerformanceFacade spfService = ServiceUtil.getService("storesPerformanceFacade", StoresPerformanceFacade.class);
		String datetime = request.getParameter("analysisDate");
		String areaStr = request.getParameter("areaStr");
		String flag = request.getParameter("flag");
		List<StoresPerformanceVO> list = spfService.getAreaListBy(areaStr);
		String areaNameStr = "";
		for (int i = 0; i < list.size(); i++) {
			areaNameStr+=list.get(i).getRegnName()+",";
		}
		model.addAttribute("analysisDate", datetime);
		model.addAttribute("areaStr", areaStr);
		model.addAttribute("flag", flag);
		model.addAttribute("categoryStr",areaNameStr.substring(0, areaNameStr.length()-1));
		return  "analysis/storesPerformance/query/showDetail";
	}
	
	public static List<StoresPerformanceVO> getDateListBy(String workDate ,String AreaStr) throws ParseException{
		
		String [] areaArray = AreaStr.split(",");
		List<String> areaList = new ArrayList<String>();
		for (int i = 0; i < areaArray.length; i++) {
			areaList.add(areaArray[i]);
		}
		
		StoresPerformanceFacade spfService = ServiceUtil.getService("storesPerformanceFacade", StoresPerformanceFacade.class);
		SearchStoresPerformanceVO searchStoresPerformanceVO=new SearchStoresPerformanceVO();
		if(areaList.size()>0){
		searchStoresPerformanceVO.setIncludeRegnNoList(areaList);
		}else{
			List<StoresPerformanceVO> allAreaList = spfService.getAreaList();
			List<Integer> allAreaList1 = new ArrayList<Integer>();
			for (int i = 0; i < allAreaList.size(); i++) {
				allAreaList1.add(allAreaList.get(i).getRegnNo());
			}
			searchStoresPerformanceVO.setIncludeRegnNoList(allAreaList1);
		}
		
		if(workDate.length() > 0){
			searchStoresPerformanceVO.setPerformanceDate(DateUtils.parseDate(workDate));
			
		}
		List<StoresPerformanceVO> ls=spfService.getAreaPerformance(searchStoresPerformanceVO);
		return ls;
	}
}
