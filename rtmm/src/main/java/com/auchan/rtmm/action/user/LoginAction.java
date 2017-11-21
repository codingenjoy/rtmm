package com.auchan.rtmm.action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.auchan.common.codetable.utils.CodeTableI18NUtil;
import com.auchan.common.codetable.vo.MetaDataVO;
import com.auchan.common.core.util.ServiceUtil;
import com.auchan.common.logging.AuchanLogger;
import com.auchan.common.security.SCMException;
import com.auchan.rtmm.action.BasicAction;
import com.auchan.rtmm.basic.Constants;
import com.auchan.rtmm.bean.User;
import com.auchan.rtmm.staff.service.StaffFacade;
import com.auchan.rtmm.staff.vo.LoginStaffVO;

@Controller
public class LoginAction extends BasicAction {

	private final static AuchanLogger log = AuchanLogger.getLogger(LoginAction.class);

	@RequestMapping({ "/toLogin" })
	public String toLogin(Model model,String msg) {
		model.addAttribute("msg", msg);
		// 清除用户数据的操作
		return "main/login";
	}
	
	/**
	 * 用户登陆
	 * @param request
	 * @param response
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping({ "/loginCheck" })
	public Map<String, Object> login(HttpServletRequest request, HttpServletResponse response, User user) {
		// 保存用户数据的操作
		StaffFacade sf = ServiceUtil.getService("staffFacade", StaffFacade.class);
		Map<String, Object> otherInfo = new HashMap<String, Object>();
		otherInfo.put("loginIP", request.getRemoteAddr());
		otherInfo.put("lang", request.getParameter("lang"));
		otherInfo.put("loginDomain", "rtmm");
		otherInfo.put("forceLogin",request.getParameter("forceLogin"));
		
		LoginStaffVO vo = null;
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		try {
			vo = sf.login(user.getCode(), user.getPassword(), otherInfo);	
			jsonMap.put(STATUS, SUCCESS);
			request.getSession().setAttribute(Constants.SCM_SESSION_TOKEN, vo.getScmSessionToken());
			log.debug("登录成功");
		} catch (Exception scme) {
			Throwable t0 = scme.getCause();
			if (t0 != null && t0 instanceof SCMException) {
				String errorCode = ((SCMException) t0).getErrorCode();
				String prefix = ((SCMException) t0).getErrorCodeClassfier();
				MetaDataVO metaDataVO = CodeTableI18NUtil.getMetaData(prefix, errorCode);
				//step1. set the ERROR flag.
				jsonMap.put(STATUS, ERROR);
				//step2. set the MESSAGE description;
				jsonMap.put(MESSAGE, metaDataVO.getL_desc());
				//step3. set the "login error" OBJECT;
				Map<String, String> loginError = new HashMap<String, String>();
				loginError.put("category", prefix);
				loginError.put("code", errorCode);
				
				if("004".equals(errorCode)){
					try {
						String errorIp = ((SCMException) t0).getAttachedData().get(0);
						loginError.put("errorIp", errorIp);
					} catch (Exception e) {
						log.error(e);
					}
				}

				jsonMap.put("error", loginError);
				//step4. set the "error message in EN" description;
				jsonMap.put("message_en", metaDataVO.getE_desc());
				
				log.error("Error! " + prefix + "-" + errorCode);
			} else {
				log.error(scme.getMessage(), scme);
				jsonMap.put(STATUS, ERROR);
				jsonMap.put(MESSAGE, "登入失败！");
			}
		}
		return jsonMap;
	}

	/**
	 * 用户登出
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "/logout" })
	public String logout(HttpServletRequest request) {
		StaffFacade sf = ServiceUtil.getService("staffFacade", StaffFacade.class);
		try{
			sf.logoff((String) request.getSession().getAttribute("SCM_TOKEN"));
			request.getSession().invalidate();
		}catch(Exception scme){
			Throwable t0 = scme.getCause();
			if (t0 != null && t0 instanceof SCMException) {
				log.error("Error. System code is" + ((SCMException) t0).getErrorCode());
			} else {
				log.error(scme.getMessage(), scme);
			}
		}
		return "redirect:/toLogin";
	}

}
