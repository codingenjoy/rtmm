package com.auchan.rtmm.action;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.common.service.CommonFacade;


@Controller
@RequestMapping(value = "/commons")
public class BasicPopupAction extends BasicAction{
	
	
	/**
	 * 显示城市弹出框
	 * 
	 * @return
	 */
	@RequestMapping("/popupCitySelectedAction")
	public String popupCitySelectedAction(Model model) {
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
		List provinceList = cf.getProvinceList();
		model.addAttribute("provinceList", provinceList);
		return "commons/popupCityPanel";
	}

}
