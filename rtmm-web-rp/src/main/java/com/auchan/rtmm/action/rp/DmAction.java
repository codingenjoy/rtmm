package com.auchan.rtmm.action.rp;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.action.BasicAction;
import com.auchan.rtmm.common.common.Ordering;
import com.auchan.rtmm.common.search.PaginationResult;
import com.auchan.rtmm.common.search.PaginationSettings;
import com.auchan.rtmm.rp.service.RpDmFacade;
import com.auchan.rtmm.rp.vo.RpDmCond;
import com.auchan.rtmm.rp.vo.RpDmVo;
import com.auchan.rtmm.util.DateUtils;
import com.auchan.rtmm.util.Page;
@Controller
@RequestMapping("/rp/dm")
public class DmAction extends BasicAction {
	
	/**
	 * 菜单点击进入的页面
	 */
	@RequestMapping("")
	public String search(Model model){
		return "rp/dm/main";
	}

	/**
	 * 查询列表
	 */
	@RequestMapping("/search")
	public String list(Model model,Page<RpDmCond> page,RpDmCond searchCond){
	 	if (null == page){
			page = new Page<RpDmCond>(); 
		}
	 	RpDmFacade fac =ServiceUtil.getService("rpDmFacade", RpDmFacade.class);
		PaginationSettings pageSettings = new PaginationSettings();
		pageSettings.setPageNo(page.getPageNo());
		pageSettings.setPageSize(page.getPageSize());
		
		Ordering order1 = new Ordering(false, "rdmNo");
		Ordering order2 = new Ordering(true, "creatDate");
		List<Ordering> olist = new ArrayList<Ordering>();
		olist.add(order1);
		olist.add(order2);
		pageSettings.setOrderBy(olist);
		PaginationResult paginationResult=fac.searchRpDmByPage(searchCond, pageSettings);
		if (paginationResult.getData()!=null&&paginationResult.getData().size()!=0) {
			page.setResult(paginationResult.getData());
			page.setTotalCount(paginationResult.getTotalCount());
		}else{
			page.setResult(null);
			page.setTotalCount(paginationResult.getTotalCount());
		}
		model.addAttribute("page", page);
		return "rp/dm/list";
	}

	/**
	 * 创建
	 */
	@RequestMapping("/create")
	public String create(Model model){
		Date nowDate=new Date();
		model.addAttribute("minDate",DateUtils.parseDate2Str(nowDate, "yyyy-MM-dd"));
		return "rp/dm/create";
	}
	/**
	 * 修改
	 */
	@RequestMapping("/edit")
	public String edit(Model model,Integer rdmNo){
		RpDmFacade fac =ServiceUtil.getService("rpDmFacade", RpDmFacade.class);
	 	RpDmVo rpDmVO=fac.findRpDmInfoByRpDmNo(rdmNo);
		Date nowDate=new Date();
		model.addAttribute("minDate",DateUtils.parseDate2Str(nowDate, "yyyy-MM-dd"));
		model.addAttribute("rpDmVO",rpDmVO);
		return "rp/dm/edit";
	}
	/**
	 * 详情
	 */
	@RequestMapping("/del")
	@ResponseBody
	public Map<String, Object>  del(Model model,Integer rdmNo){
		RpDmFacade fac =ServiceUtil.getService("rpDmFacade", RpDmFacade.class);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
	 	fac.deleteRpDm(rdmNo);
		try {
			jsonMap.put("message", "删除成功");
			jsonMap.put("flag", true);
		} catch (Exception e) {
			jsonMap.put("message", "删除失败");
			jsonMap.put("flag", false);
		}
		return jsonMap;
	}
	/**
	 * 详情
	 */
	@RequestMapping("/detail")
	public String detail(Model model,Integer rdmNo){
		RpDmFacade fac =ServiceUtil.getService("rpDmFacade", RpDmFacade.class);
	 	RpDmVo rpDmVO=fac.findRpDmInfoByRpDmNo(rdmNo);
	 	model.addAttribute("rpDmVO",rpDmVO);
		return "rp/dm/detail";
	}
	/**
	 * 保存修改
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(Model model,RpDmVo rpDmVo,String flag){
	 	RpDmFacade fac =ServiceUtil.getService("rpDmFacade", RpDmFacade.class);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		try {
			if(flag!=null&&"add".equals(flag)){
				fac.createRpDm(rpDmVo);
				jsonMap.put("message", "保存成功");
				jsonMap.put("flag", true);
			}else if(flag!=null&&"edit".equals(flag)){
				fac.updateRpDm(rpDmVo);
				jsonMap.put("message", "保存成功");
				jsonMap.put("flag", true);
			}
		} catch (Exception e) {
			jsonMap.put("message", "保存失败");
			jsonMap.put("flag", false);
		}
		
		return jsonMap;
	}
}
