package com.auchan.common.webtag.oper;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import com.auchan.common.codetable.utils.CodeTableI18NUtil;
import com.auchan.common.webtag.util.FreeMarkerUtil;

public class I18nTag extends OpControlTag implements Tag{
	
	private String id; //the code where you can get the value in the internationality.

		
	public int doStartTag() throws JspException {
		String value="";//initiate the i18n value;
		if((null==id||id=="")){			
			return SKIP_BODY;
		}
		value=CodeTableI18NUtil.getMsgById(id).getTitle();
		if(value==null||value==""){			
			return SKIP_BODY;
		}
		Map<String, String> rootMap = new HashMap<String, String>();
		rootMap.put("value", value);
		String info = FreeMarkerUtil.getFtlText("i18n.ftl", rootMap);
		try {
			pageContext.getOut().write(info);
		} catch (IOException e) {
			log.error("I18nTag OutPut Error:", e);
		}
		return EVAL_BODY_INCLUDE;
	}
	
	public void setPageContext(PageContext pageContext) {
         
		this.pageContext=pageContext;
	}

	public void setParent(Tag t) {

		
	}

	public Tag getParent() {

		return null;
	}

	public int doEndTag() throws JspException {

		return 0;
	}

	public void release() {

		
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	

}
