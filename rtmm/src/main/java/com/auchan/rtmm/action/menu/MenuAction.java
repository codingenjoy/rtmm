package com.auchan.rtmm.action.menu;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MenuAction {
	
	@RequestMapping("/subMenu/{pid}")
	public String toSubPage(@PathVariable String pid,Model model,String sid,String toUrl){
		model.addAttribute("sid",sid);
		model.addAttribute("pid",pid);
		model.addAttribute("toUrl",toUrl);
		return "commons/lefthead";
	}

}
