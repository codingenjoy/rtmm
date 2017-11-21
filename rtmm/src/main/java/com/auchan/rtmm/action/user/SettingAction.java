package com.auchan.rtmm.action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.common.logging.AuchanLogger;
import com.auchan.common.security.SCMException;
import com.auchan.rtmm.action.BasicAction;
import com.auchan.rtmm.staff.UserException;
import com.auchan.rtmm.staff.service.StaffFacade;
import com.auchan.rtmm.staff.vo.UserPreferenceVO;

@Controller
@RequestMapping(value = "/setting")
public class SettingAction extends BasicAction {

	private final static AuchanLogger log = AuchanLogger.getLogger(SettingAction.class);

	/**
	 * 修改用户密码
	 * 
	 * @param request
	 * @param oldPlainPwd
	 * @param newCryptedPwd
	 * @return
	 */
	@RequestMapping({ "/toChangePassWord" })
	public String toChangePassWord(Model model,String flag) {
		model.addAttribute("flag", flag);
		return "setting/changePassWord";
	}

	/**
	 * 修改用户密码
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping({ "/doChangePassWord" })
	public Map<String, Object> doChangePassWord(HttpServletRequest request, String oldPlainPwd, String newCryptedPwd) {
		Map<String, Object> retMap = new HashMap<String, Object>();
		retMap.put(STATUS, SUCCESS);
		retMap.put(MESSAGE, "操作成功");
		try {
			StaffFacade sf = ServiceUtil.getService("staffFacade", StaffFacade.class);
			sf.changePassword(oldPlainPwd, newCryptedPwd);
		} catch (Exception scme) {
			Throwable t0 = scme.getCause();
			if (t0 != null && t0 instanceof UserException) {
				String errorCode = ((UserException) t0).getErrorCode();
				String prefix = ((UserException) t0).getErrorCodeClassfier();
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, getErrorTitle(prefix,errorCode));
				log.error("Error. System code is" + errorCode);
			}else{
				log.error(scme.getMessage(), scme);
				retMap.put(STATUS, ERROR);
				retMap.put(MESSAGE, "操作失败");
			}
		}
		return retMap;
	}

	/**
	 * 修改用户方言和主题
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "/toChangeUserPreference" })
	public String toChangeUserPreference(Model model) {
		StaffFacade sf = ServiceUtil.getService("staffFacade", StaffFacade.class);
		UserPreferenceVO userPreferenceVO = sf.getUserPreference();
		model.addAttribute("userPreferenceVO",userPreferenceVO);
		return "setting/changeUserPreference";
	}

	/**
	 * 修改用户方言和主题
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping({ "/doChangeUserPreference" })
	public boolean doChangeUserPreference(HttpServletRequest request, String lang, String theme) {
		boolean ret = true;
		try {
			StaffFacade sf = ServiceUtil.getService("staffFacade", StaffFacade.class);
			sf.changeUserPreference(lang, theme);
		} catch (Exception scme) {
			if (scme instanceof SCMException) {
				log.error("Error. System code is" + ((SCMException) scme).getErrorCode());
			}else{
				log.error(scme.getMessage(), scme);
			}
			ret = false;
		}
		return ret;
	}

}
