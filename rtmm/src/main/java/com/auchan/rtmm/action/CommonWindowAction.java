package com.auchan.rtmm.action;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.auchan.common.codetable.utils.CodeTableI18NUtil;
import com.auchan.common.codetable.vo.MetaDataVO;
import com.auchan.common.core.util.ServiceUtil;
import com.auchan.common.logging.AuchanLogger;
import com.auchan.rtmm.common.common.Ordering;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.common.service.CommonFacade;
import com.auchan.rtmm.common.vo.CatalogSimpleVO;
import com.auchan.rtmm.common.vo.ItemBasicSimpleVO;
import com.auchan.rtmm.common.vo.SupplierSimpleVO;
import com.auchan.rtmm.items.service.ItemBarcodeFacade;
import com.auchan.rtmm.items.service.ItemBrandFacade;
import com.auchan.rtmm.items.service.ItemCreateFacade;
import com.auchan.rtmm.items.service.ItemsFacade;
import com.auchan.rtmm.items.vo.SearchAllSupplierVO;
import com.auchan.rtmm.items.vo.SearchCondItemBarcodeVO;
import com.auchan.rtmm.items.vo.SearchCondItemBasicVO;
import com.auchan.rtmm.items.vo.SearchCondItemBrandVO;
import com.auchan.rtmm.supplier.service.CompanyFacade;
import com.auchan.rtmm.supplier.service.SupplierFacade;
import com.auchan.rtmm.supplier.vo.ComGrpVO;
import com.auchan.rtmm.supplier.vo.SearchCompanyPageVO;
import com.auchan.rtmm.supplier.vo.SearchSupplierVO;
import com.auchan.rtmm.supplier.vo.SupCompanyVO;
import com.auchan.rtmm.util.Page;
import com.auchan.rtmm.util.StringUtils;

@Controller
@RequestMapping("/commons/window")
public class CommonWindowAction extends BasicAction {
	private final static AuchanLogger log = AuchanLogger.getLogger(CommonWindowAction.class);

	@RequestMapping("/chooseCity")
	public String popupCitySelectedAction(Model model) {
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		List provinceList = cf.getProvinceList();
		model.addAttribute("provinceList", provinceList);
		return "commons/window/chooseCity";
	}

	@ResponseBody
	@RequestMapping("/getCity")
	public List getCity(Integer regnNo) {
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		return cf.getCityList(regnNo);
	}

	@RequestMapping("/chooseSection")
	public String chooseSection(Model model,String status) {
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		List divisionList = cf.getDivisionList();
		model.addAttribute("divisionList", divisionList);
		model.addAttribute("status",status);
		return "commons/window/chooseSection";
	}

	@ResponseBody
	@RequestMapping("/getSection")
	public List ShowSection(Integer divisionId, String status) {
		List<String> statusList = new ArrayList<String>();
		if (StringUtils.isNotEmpty(status)) {
			for (String s : status.split(",")) {
				statusList.add(s);
			}
		}
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		return cf.getSectionListByDivision(divisionId,statusList);
	}

	@RequestMapping({ "/chooseSupCom" })
	public String chooseSupCom(Model model) {
		return "commons/window/chooseSupCom";
	}

	@RequestMapping("/chooseSupComList")
	public String supCompanyList(Model model, SearchCompanyPageVO vo, Page<SupCompanyVO> page) {
		if (page == null) {
			page = new Page<SupCompanyVO>();
		}
		PaginationResult result = null;
		PaginationSettings ps = new PaginationSettings();
		ps.setPageNo(page.getPageNo());
		ps.setPageSize(page.getPageSize());

		Ordering order = new Ordering(true, "comNo");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		ps.setOrderBy(olist);

		CompanyFacade cf = ServiceUtil.getService("companyFacade", CompanyFacade.class);
		result = cf.searchCompanies(vo, ps);
		if (null != result.getTotalCount() && 0 != result.getTotalCount()) {
			page.setTotalCount(result.getTotalCount());
			page.setResult(result.getData());
		} else {
			page.setTotalCount(0);
			page.setResult(null);
		}
		model.addAttribute("page", page);
		return "commons/window/chooseSupComList";
	}

	@RequestMapping({ "/chooseSupComgrp" })
	public String chooseSupComgrp(Model model, String action) {
		model.addAttribute("action", action);
		return "commons/window/chooseSupComgrp";
	}

	@ResponseBody
	@RequestMapping(value = "/getDictValue", produces = { "application/json;charset=UTF-8" })
	public MetaDataVO getDictValue(String mdGrpKey, String code) {
		log.debug("------------------mdGrpKey" + mdGrpKey + ",code=" + code);
		MetaDataVO metaDataVO = CodeTableI18NUtil.getMetaData(mdGrpKey, code);
		return metaDataVO;
	}

	@RequestMapping("/chooseCityAndProv")
	public String chooseCityAndProv(Model model, String callback) {
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		List provinceList = cf.getProvinceList();
		model.addAttribute("provinceList", provinceList);
		model.addAttribute("callback", callback);
		return "commons/window/chooseCityAndProv";
	}

	@RequestMapping({ "/chooseSupNo" })
	public String chooseSupNo(Model model, String callback) {
		model.addAttribute("callback", callback);
		return "commons/window/chooseSupNo";
	}

	@RequestMapping({ "/chooseBrand" })
	public String chooseBrand(Model model, String callback) {
		model.addAttribute("callback", callback);
		return "commons/window/chooseBrand";
	}

	// 用于显示商品下的广告列表
	@RequestMapping({ "/showItemAdDesc" })
	public String showItemAdDesc(Model model, String itemNoSearch) {
		model.addAttribute("itemNoSearch", itemNoSearch);
		return "commons/window/showItemAdDesc";
	}

	// 用于显示商品下的季节期数列表
	@RequestMapping({ "/showItemSETopic" })
	public String showItemSETopic(Model model, String itemNoSearch) {
		model.addAttribute("itemNoSearch", itemNoSearch);
		return "commons/window/showItemSETopic";
	}

	// 选择货号
	@RequestMapping({ "/chooseItem" })
	public String chooseItem(Model model, String callback) {
		model.addAttribute("callback", callback);
		return "commons/window/chooseItem";
	}

	/**
	 * 显示货号列表
	 * 
	 * @param page
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping({ "/listItemsData" })
	public Map<String, Object> listItemsData(Integer page, Integer rows, Model model, SearchCondItemBasicVO serarchVO) {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		PaginationSettings ps = new PaginationSettings();
		List<Ordering> orderList = new ArrayList<Ordering>();
		Ordering order = new Ordering(true, "itemNo");
		orderList.add(order);
		ps.setOrderBy(orderList);
		ps.setPageNo(page);
		ps.setPageSize(rows);
		ItemsFacade nf = ServiceUtil.getService("itemsFacade", ItemsFacade.class);
		try {
			PaginationResult result = nf.searchItemBasicList(ps, serarchVO);
			if (null != result) {
				if (null != result.getData()) {
					jsonMap.put("total", result.getTotalCount());
					jsonMap.put("rows", result.getData());
				} else {
					jsonMap.put("total", 0);
					jsonMap.put("rows", new ArrayList<Object>());
				}
			} else {
				jsonMap.put("total", 0);
				jsonMap.put("rows", new ArrayList<Object>());
			}
		} catch (Exception e) {
			log.error("message", e);
			jsonMap.put("total", 0);
			jsonMap.put("rows", new ArrayList<Object>());
		}
		return jsonMap;
	}

	/**
	 * 厂商管理(根据条件查询外部厂商)
	 * 
	 * @param model
	 * @param searchSupplierVO
	 * @param page
	 *            第几页
	 * @param rows
	 *            每页显示条数
	 * @return
	 */
	@ResponseBody
	@RequestMapping({ "/listSupData" })
	public Map<String, Object> listSupData(Integer page, Integer rows, Model model, SearchSupplierVO serarchVO) {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		PaginationSettings ps = new PaginationSettings();
		List<Ordering> orderList = new ArrayList<Ordering>();
		Ordering order = new Ordering(true, "supNo");
		orderList.add(order);
		ps.setOrderBy(orderList);
		ps.setPageNo(page);
		ps.setPageSize(rows);
		SupplierFacade nf = ServiceUtil.getService("supplierFacade", SupplierFacade.class);
		try {
			PaginationResult result = nf.serachSupplierPage(serarchVO, ps);
			if (null != result) {
				if (null != result.getData()) {
					jsonMap.put("total", result.getTotalCount());
					jsonMap.put("rows", result.getData());
				} else {
					jsonMap.put("total", 0);
					jsonMap.put("rows", new ArrayList<Object>());
				}
			} else {
				jsonMap.put("total", 0);
				jsonMap.put("rows", new ArrayList<Object>());
			}
		} catch (Exception e) {
			log.error("message", e);
			jsonMap.put("total", 0);
			jsonMap.put("rows", new ArrayList<Object>());
		}
		return jsonMap;
	}

	@RequestMapping({ "/chooseBrandNo" })
	public String chooseBrandNo(Model model, String callback) {
		model.addAttribute("callback", callback);
		return "commons/window/chooseBrandNo";
	}

	@ResponseBody
	@RequestMapping({ "/listBrandData" })
	public Map<String, Object> listBrandData(Integer page, Integer rows, Model model, SearchCondItemBrandVO serarchVO) {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		PaginationSettings ps = new PaginationSettings();
		List<Ordering> orderList = new ArrayList<Ordering>();
		Ordering order = new Ordering(true, "brandId");
		orderList.add(order);
		ps.setOrderBy(orderList);
		ps.setPageNo(page);
		ps.setPageSize(rows);
		ItemBrandFacade nf = ServiceUtil.getService("itemBrandFacade", ItemBrandFacade.class);
		try {
			PaginationResult result = nf.searchItemBrandList(ps, serarchVO);
			if (null != result) {
				if (null != result.getData()) {
					jsonMap.put("total", result.getTotalCount());
					jsonMap.put("rows", result.getData());
				} else {
					jsonMap.put("total", 0);
					jsonMap.put("rows", new ArrayList<Object>());
				}
			} else {
				jsonMap.put("total", 0);
				jsonMap.put("rows", new ArrayList<Object>());
			}
		} catch (Exception e) {
			log.error("message", e);
			jsonMap.put("total", 0);
			jsonMap.put("rows", new ArrayList<Object>());
		}
		return jsonMap;
	}

	// 选择货号
	@RequestMapping({ "/chooseItemBarcode" })
	public String chooseItemBarcode(Model model, String callback) {
		model.addAttribute("callback", callback);
		return "commons/window/chooseItemBarcode";
	}

	/**
	 * 显示货号列表
	 * 
	 * @param page
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping({ "/listItemBarcodeData" })
	public Map<String, Object> listItemBarcodeData(Integer page, Integer rows, Model model, SearchCondItemBarcodeVO searchCondItemBarcodeVO) {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		PaginationSettings ps = new PaginationSettings();
		List<Ordering> orderList = new ArrayList<Ordering>();
		Ordering order = new Ordering(true, "itemNo");
		orderList.add(order);
		ps.setOrderBy(orderList);
		ps.setPageNo(page);
		ps.setPageSize(rows);
		ItemBarcodeFacade nf = ServiceUtil.getService("itemBarcodeFacade", ItemBarcodeFacade.class);
		try {
			PaginationResult result = nf.searchItemBarcodeList(ps, searchCondItemBarcodeVO);
			if (null != result) {
				if (null != result.getData()) {
					jsonMap.put("total", result.getTotalCount());
					jsonMap.put("rows", result.getData());
				} else {
					jsonMap.put("total", 0);
					jsonMap.put("rows", new ArrayList<Object>());
				}
			} else {
				jsonMap.put("total", 0);
				jsonMap.put("rows", new ArrayList<Object>());
			}
		} catch (Exception e) {
			log.error("message", e);
			jsonMap.put("total", 0);
			jsonMap.put("rows", new ArrayList<Object>());
		}
		return jsonMap;
	}

	/**
	 * 厂商管理(根据条件查询外部厂商)
	 * 
	 * @param model
	 * @param searchSupplierVO
	 * @param page
	 *            第几页
	 * @param rows
	 *            每页显示条数
	 * @return
	 */
	@ResponseBody
	@RequestMapping({ "/listAllSupData" })
	public Map<String, Object> listAllSupData(Integer page, Integer rows, Model model, SearchAllSupplierVO searchAllSupplierVO) {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		Ordering order = new Ordering(true, "supNo");
		com.auchan.rtmm.common.search.PaginationSettings ps = new com.auchan.rtmm.common.search.PaginationSettings();
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order);
		ps.setOrderBy(olist);
		ps.setPageNo(page);
		ps.setPageSize(rows);
		searchAllSupplierVO.setExcludeStatus(Arrays.asList(0, 9));
		ItemCreateFacade icf = ServiceUtil.getService("itemCreateFacade", ItemCreateFacade.class);
		try {
			PaginationResult result = icf.serachAllSupplierPage(searchAllSupplierVO, ps);
			if (null != result) {
				if (null != result.getData()) {
					jsonMap.put("total", result.getTotalCount());
					jsonMap.put("rows", result.getData());
				} else {
					jsonMap.put("total", 0);
					jsonMap.put("rows", new ArrayList<Object>());
				}
			} else {
				jsonMap.put("total", 0);
				jsonMap.put("rows", new ArrayList<Object>());
			}
		} catch (Exception e) {
			log.error("message", e);
			jsonMap.put("total", 0);
			jsonMap.put("rows", new ArrayList<Object>());
		}
		return jsonMap;
	}

	// 用于显示商品下的系列列表
	@RequestMapping({ "/showItemCluster" })
	public String showItemCluster(Model model, String itemNoSearch) {
		model.addAttribute("itemNoSearch", itemNoSearch);
		return "commons/window/showItemCluster";
	}

	/**
	 * 查询课别信息
	 * 
	 */
	@RequestMapping(value = "readCatalogInfoBySecNo")
	@ResponseBody
	public List readCatalogInfoBySecNo(Integer secNo) {
		List<CatalogSimpleVO> cvo = null;
		// 定义查询的结果集合
		try {
			CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
			cvo = cf.readCatalogInfoBySecNo(secNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cvo;
	}

	/**
	 * 查询商品信息
	 * 
	 */
	@RequestMapping(value = "readItemInfoBySecNoAndItemNo")
	@ResponseBody
	public List readItemInfoBySecNoAndItemNo(Integer itemNo, Integer secNo) {
		List<ItemBasicSimpleVO> cvo = null;
		// 定义查询的结果集合
		try {
			CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
			cvo = cf.readItemInfoBySecNoAndItemNo(itemNo, secNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cvo;
	}

	/**
	 * 查询厂商信息
	 * 
	 */
	@RequestMapping(value = "readSupInfoBySupNo")
	@ResponseBody
	public List readSupInfoBySupNo(Integer supNo, Integer catlgId, String comName) {
		List<SupplierSimpleVO> cvo = null;
		// 定义查询的结果集合
		try {
			CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
			cvo = cf.readSupInfoBySupNo(supNo, catlgId, comName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cvo;
	}
    /**
     * 通过集团编号查找集团
     */
	@ResponseBody
	@RequestMapping("/getComGrpByComgrpNo")
	public Map<String,Object> getComGrpByComgrpNo(Integer comgrpNo) {
		CompanyFacade cf = ServiceUtil.getService("companyFacade", CompanyFacade.class);
		Map<String,Object> jsonMap = new HashMap<String, Object>();
		PaginationResult result = null;
    	PaginationSettings ps = new PaginationSettings();
    	ps.setPageNo(1);
    	ps.setPageSize(1);
    	ComGrpVO comGrpVO = new ComGrpVO();
    	comGrpVO.setComgrpNo(comgrpNo);
		try {
			result = cf.searchComGrps(comGrpVO, ps);
			if (null != result && null != result.getData()) {
				@SuppressWarnings("unchecked")
				List<ComGrpVO> comGrps = result.getData();
				jsonMap.put("comGrpVO", comGrps.get(0));
			}else{
				jsonMap.put("comGrpVO",null);
			}
		} catch (Exception e) {
			// TODO: handle exception
			log.error("message",e);
		}
		return jsonMap;
	}
}
