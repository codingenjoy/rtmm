package com.auchan.rtmm.action;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.auchan.common.codetable.utils.CodeTableI18NUtil;
import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.chart.StoreDynamicGraphics;
import com.auchan.rtmm.common.service.CommonFacade;
import com.auchan.rtmm.staff.service.RoleFacade;
import com.auchan.rtmm.staff.service.StaffFacade;
import com.auchan.rtmm.staff.service.StaffSessionFacade;
import com.auchan.rtmm.staff.vo.ChangeStaffVO;
import com.auchan.rtmm.staff.vo.JobFunctionVO;
import com.auchan.rtmm.staff.vo.RuntimeStaffVO;

@Controller
@RequestMapping("/")
public class IndexAction extends BasicAction {

	@ModelAttribute
	public void setAttribute(Model model) {
		setSeoAndSettingToModel(model);
		StaffSessionFacade saf = ServiceUtil.getService("staffSessionFacade", StaffSessionFacade.class);
		StaffFacade sf = ServiceUtil.getService("staffFacade", StaffFacade.class);
		RuntimeStaffVO runtimeStaffVO = saf.getRuntimeStaffInfo();
		ChangeStaffVO staff = sf.getStaffInfoById(runtimeStaffVO.getStaffId());
		String lang = saf.getRuntimeStaffLang();
		String staffName = staff.getName();
		if ("en".equals(lang) &&null!=staff.getNameEn()&&!"".equals(staff.getNameEn())) {
			staffName = staff.getNameEn();
		}
		model.addAttribute("staffName", staffName);
		model.addAttribute("isFirstLogin", sf.isFirstLogin(runtimeStaffVO.getStaffId()));
		model.addAttribute("lang", CodeTableI18NUtil.getStaffLang());
	}

	@RequestMapping({ "", "index" })
	public String toIndex(Model model, Long jobFunctionId) {
		RoleFacade rf = ServiceUtil.getService("roleFacade", RoleFacade.class);
		List<JobFunctionVO> jfList = rf.getJobFunctionInfoByStaff(false);
		model.addAttribute("currentId",jobFunctionId);
		model.addAttribute("jfList", jfList);
		return "main/welcome";
	}

	/**
	 * 选择岗位 
	 * 1.只有一个岗位的时候不用选择 
	 * 2.岗位设置完成跳转到欢迎页面
	 * 
	 * @param model
	 * @param jobFunctionId
	 * @return
	 */
	@RequestMapping("/changeJobFun")
	public String changeJobFun(Model model, Long jobFunctionId) {
		RoleFacade rf = ServiceUtil.getService("roleFacade", RoleFacade.class);
		List<JobFunctionVO> jfList = rf.getValidateRolesByStaff(false);
		if (null != jobFunctionId) {
			
			rf.setAccessJobFunction(jobFunctionId);
			model.addAttribute("currentId",jobFunctionId);
			model.addAttribute("jfList", jfList);
			return "main/welcome";
		}
		if (jfList.size() == 1) {
			rf.setAccessJobFunction(jfList.get(0).getId());
			model.addAttribute("currentId",jfList.get(0).getId());
			model.addAttribute("jfList", jfList);
			return "main/welcome";
		}
		model.addAttribute("jfList", jfList);
		return "main/changeJobFun";
	}

	@RequestMapping("tajax")
	public String removeAll(HttpServletRequest request, Long id, String name, HttpServletResponse response) {
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		System.out.println(id);
		System.out.println(name);
		jsonMap.put(STATUS, ERROR);
		try {
			jsonMap.put("text", "这是返回的文本");
			jsonMap.put(STATUS, SUCCESS);
			jsonMap.put(MESSAGE, "操作成功");
		} catch (Exception e) {
			jsonMap.put(MESSAGE, e.getMessage());
		}
		return ajaxJson(response, jsonMap);
	}

	/**
	 * 选择岗位 
	 * 1.只有一个岗位的时候不用选择 
	 * 2.岗位设置完成跳转到欢迎页面
	 * 
	 * @param model
	 * @param jobFunctionId
	 * @return
	 */
	@RequestMapping("/changeJobFun1")
	public String changeJobFun1(Model model, Long jobFunctionId) {
		RoleFacade rf = ServiceUtil.getService("roleFacade", RoleFacade.class);
		if (null != jobFunctionId) {
			rf.setAccessJobFunction(jobFunctionId);
			return "main/welcome1";
		}
		List<JobFunctionVO> jfList = rf.getJobFunctionInfoByStaff(false);
		
		if (jfList.size() == 1) {
			rf.setAccessJobFunction(jfList.get(0).getId());
			return "main/welcome1";
		}
		model.addAttribute("jfList", jfList);
		return "main/changeJobFun";
	}
	
	@RequestMapping("/getStoreImg")
	public String genStoreImg(HttpServletRequest request) {

		//set the relative path of the jboss.
		String storePath =request.getSession().getServletContext().getRealPath("");
        String path=storePath+File.separator+"shared"+File.separator+"themes"+File.separator+"theme1"+File.separator+"images"+File.separator+"ch_2.jpg";
        StoreDynamicGraphics storeDynamicGraphics=new StoreDynamicGraphics();
		storeDynamicGraphics.setUrl(path);
		//set the store num of area. 
		CommonFacade cf = ServiceUtil.getService("commonFacade", CommonFacade.class);
	    List<Map<String,Object>> areaStorelist=cf.getStoreCountByArea();
	    Map<String,Integer> areaMap=new HashMap<String,Integer>();
	    for(Map<String,Object> retMap:areaStorelist){
	    	String regnName = MapUtils.getString(retMap, "regnName");
	    	Integer cnt = MapUtils.getInteger(retMap, "cnt");
	    	if(regnName.equals("东北")){
	    		regnName="NE";
	    	}
	    	else if(regnName.equals("华北")){
	    		regnName="NC";
	    	}
	    	else if(regnName.equals("西北")){
	    		regnName="NW";
	    	}
	    	else if(regnName.equals("西南")){
	    		regnName="SW";
	    	}
	    	else if(regnName.equals("华南")){
	    		regnName="SC";
	    	}
	    	else if(regnName.equals("华东")){
	    		regnName="EC";
	    	}
	    	else if(regnName.equals("华中")){
	    		regnName="CC";
	    	}
	    	areaMap.put(regnName, cnt);
	    }
	    List<String> areaList=new ArrayList<String>();
	    	areaList.add("NE");
	    	areaList.add("NC");
	    	areaList.add("NW");
	    	areaList.add("SW");
	    	areaList.add("SC");
	    	areaList.add("EC");
	    	areaList.add("CC");
        for(String area: areaList){
        	System.out.println();
         if(null==areaMap.get(area)){
        	 areaMap.put(area, 0); 
         }
        }
		List<Integer> graphicsDataHeightList=storeDynamicGraphics.getGraphicsData(areaMap);
		storeDynamicGraphics.graphicsGeneration(graphicsDataHeightList);
		return "true";
	}

}
