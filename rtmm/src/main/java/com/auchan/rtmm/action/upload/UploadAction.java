package com.auchan.rtmm.action.upload;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.auchan.common.security.SessionCache;
import com.auchan.rtmm.action.BasicAction;
import com.auchan.rtmm.common.session.SessionHelper;

@Controller
@RequestMapping(value = "/upload")
public class UploadAction extends BasicAction {

	@RequestMapping(value = "toUpload")
	public ModelAndView toUpload() {
		return new ModelAndView("/upload/upload");
	}


@RequestMapping(value = "addPicToSessionCache")
@ResponseBody
public void addPicToSessionCache(String cacheInfo,String type) {
	String userId=SessionHelper.getCurrentStaffId();
	String key= type+userId;
	SessionCache.put(key, cacheInfo);	
}
}




