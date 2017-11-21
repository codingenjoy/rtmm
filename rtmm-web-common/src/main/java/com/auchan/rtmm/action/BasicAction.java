package com.auchan.rtmm.action;

import java.beans.PropertyEditorSupport;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.auchan.common.codetable.utils.CodeTableI18NUtil;
import com.auchan.common.codetable.vo.MetaDataVO;
import com.auchan.common.logging.AuchanLogger;
import com.auchan.common.security.SessionKeyStore;
import com.auchan.common.security.enums.SESSION_NAMED_FILEDS;
import com.auchan.common.security.enums.SYS_LANG;
import com.auchan.common.security.session.SessionAccessFacade;
import com.auchan.rtmm.util.JsonUtil;
import com.auchan.rtmm.util.StringUtils_Auchan;
import com.auchan.rtmm.util.TreeVo;

public class BasicAction {

	private final static AuchanLogger log = AuchanLogger.getLogger(BasicAction.class);

	/**
	 * 
	 */
	public final static String AJAX = "ajax";
	public final static String STATUS = "status";
	public final static String SUCCESS = "success";
	public final static String ERROR = "error";
	public final static String MESSAGE = "message";
	public static final String VIEW = "view";

	public static final String LIST = "list";
	public static final String WARN = "warn";
	public static final String ERRORCODE = "errorcode";
	public static final String CONTENT = "content";

	public String now = StringUtils_Auchan.getString_yyyy_MM_dd(new Date());

	public String menu_name;

	public String login_name;
	public Integer admin;

	public Map<String, Integer> menuArray;

	// AJAX输出，返回null
	public String ajax(HttpServletResponse response, String content, String type) {
		try {
			response.setContentType(type + ";charset=UTF-8");
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
			response.getWriter().write(content);
			response.getWriter().flush();
			response.getWriter().close();
		} catch (IOException e) {
			log.error(e);
		}
		return null;
	}

	// AJAX输出文本，返回null
	public String ajaxText(HttpServletResponse response, String text) {
		return ajax(response, text, "text/plain");
	}

	// AJAX输出HTML，返回null
	public String ajaxHtml(HttpServletResponse response, String html) {
		return ajax(response, html, "text/html");
	}

	// AJAX输出XML，返回null
	public String ajaxXml(HttpServletResponse response, String xml) {
		return ajax(response, xml, "text/xml");
	}

	// 根据字符串输出JSON，返回null
	public String ajaxJson(HttpServletResponse response, String jsonString) {
		return ajax(response, jsonString, "text/html");
	}

	/*
	 * 根据Map输出JSON，返回null
	 * 设置MIME头为"application/json",这是标准 RFC 4672.
	 */
	public String ajaxJson(HttpServletResponse response, Map<String, Object> jsonMap) {
		return ajax(response, JsonUtil.java2json(jsonMap), "application/json");
	}

	// 输出JSON警告消息，返回null
	public String ajaxJsonWarnMessage(HttpServletResponse response, String message) {
		Map<String, String> jsonMap = new HashMap<String, String>();
		jsonMap.put(STATUS, WARN);
		jsonMap.put(MESSAGE, message);
		return ajax(response, JsonUtil.java2json(jsonMap), "text/html");
	}

	// 输出JSON成功消息，返回null
	public String ajaxJsonSuccessMessage(HttpServletResponse response, String message) {
		Map<String, String> jsonMap = new HashMap<String, String>();
		jsonMap.put(STATUS, SUCCESS);
		jsonMap.put(MESSAGE, message);
		return ajax(response, JsonUtil.java2json(jsonMap), "text/html");
	}

	// 输出JSON错误消息，返回null
	public String ajaxJsonErrorMessage(HttpServletResponse response, String message) {
		Map<String, String> jsonMap = new HashMap<String, String>();
		jsonMap.put(STATUS, ERROR);
		jsonMap.put(MESSAGE, message);
		return ajax(response, JsonUtil.java2json(jsonMap), "text/html");
	}

	// 设置页面不缓存
	public void setResponseNoCache(HttpServletResponse response) {
		response.setHeader("progma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Cache-Control", "no-store");
		response.setDateHeader("Expires", 0);
	}

	/**
	 * 在树中查找父节点
	 * 
	 * @param treeList
	 * @param deptVo
	 * @param retTreeVo
	 */
	protected TreeVo findParentNodeByTree(List<TreeVo> treeList, String compareId) {
		TreeVo retVo = null;
		for (TreeVo treeVo : treeList) {
			if (retVo != null) {
				return retVo;
			}
			if (compareId.equals(treeVo.getId())) {
				retVo = treeVo;
				continue;
			} else if (treeVo.getChildren().size() > 0) {
				retVo = findParentNodeByTree(treeVo.getChildren(), compareId);
			}
		}
		return retVo;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public String getNow() {
		return now;
	}

	public void setNow(String now) {
		this.now = now;
	}

	protected void setSeoAndSettingToModel(Model model) {
		
		model.addAttribute("defaultTitle", CodeTableI18NUtil.getMsgById("100001005").getTitle());
		model.addAttribute("defaultKeyWords", CodeTableI18NUtil.getMsgById("100001006").getTitle());
		model.addAttribute("defaultDescription", CodeTableI18NUtil.getMsgById("100001007").getTitle());
		model.addAttribute("author", CodeTableI18NUtil.getMsgById("100001008").getTitle());
		model.addAttribute("myFavorite", CodeTableI18NUtil.getMsgById("100001001").getTitle());
		model.addAttribute("userPreference", CodeTableI18NUtil.getMsgById("100001009").getTitle());
		model.addAttribute("pwdSetting", CodeTableI18NUtil.getMsgById("100001002").getTitle());
		model.addAttribute("logout", CodeTableI18NUtil.getMsgById("100001003").getTitle());
		model.addAttribute("welcome", CodeTableI18NUtil.getMsgById("100001004").getTitle());
		model.addAttribute("changeJobFun", CodeTableI18NUtil.getMsgById("100001017").getTitle());
	}

	protected void setRequestParamterToModel(HttpServletRequest request, Model model) {
		Iterator it = request.getParameterMap().keySet().iterator();
		while (it.hasNext()) {
			String key = (String) it.next();
			String values[] = request.getParameterValues(key);
			if (values.length == 1) {
				model.addAttribute(key, values[0].trim());
			} else {
				model.addAttribute(key, values);
			}
		}
	}

	@ExceptionHandler(Exception.class)
	@ResponseStatus(value = HttpStatus.OK)
	public String handleException(Exception ex, HttpServletRequest request, HttpServletResponse response) throws IOException {
		if (ex != null) {
			ex.printStackTrace();
		}
		String requestedWith = request.getHeader("x-requested-with");
		if ("XMLHttpRequest".equals(requestedWith)) {
			response.setHeader("exception", "true");
			return "exception";
		} else {
			return "commons/404";
		}

	}
	/**
	 * get the detail message 
	 * according by the mdGrgKey
	 * 
	 * @param mdGrpKey
	 * @param code
	 * @return
	 */
	public MetaDataVO getDictValue(String mdGrpKey, String code) {
		log.info("------------------mdGrpKey"+mdGrpKey+",code="+code);
		MetaDataVO metaDataVO = CodeTableI18NUtil.getMetaData(mdGrpKey, code);
		return metaDataVO;
	}
	
	public String getErrorTitle(String mdGrpKey, String code) {
		String lang = (String) SessionAccessFacade.getInstance().getValue(SessionKeyStore.get(), SESSION_NAMED_FILEDS.LANG.getValue());
		MetaDataVO metaDataVO = CodeTableI18NUtil.getMetaData(mdGrpKey, code);
		if(SYS_LANG.EN.getValue().equals(lang)){
			return metaDataVO.getE_desc();
		}else if(SYS_LANG.FR.getValue().equals(lang)){
			return metaDataVO.getF_desc();
		}else{
			return metaDataVO.getL_desc();
		}
	}

	@InitBinder
	public void initBinder(WebDataBinder dataBinder){
		dataBinder.registerCustomEditor(Date.class, new PropertyEditorSupport() {
		    public void setAsText(String value) {
		        try {
		            setValue(new SimpleDateFormat("yyyy-MM-dd").parse(value));
		        } catch(ParseException e) {
		            setValue(null);
		        }
		    }
		});
	}
}
