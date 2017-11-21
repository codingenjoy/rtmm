package com.auchan.common.webtag.oper;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.rtmm.staff.service.MenuFacade;

public class OperAuthTag implements Tag {

	private String ifAnyGrantedCode="";
	
	private String ifAllGrantedCode="";
	
	private String ifNotGrantedCode="";

	public void setPageContext(PageContext pc) {

	}

	public void setParent(Tag t) {

	}

	public Tag getParent() {

		return null;
	}

	public int doStartTag() throws JspException {
		MenuFacade mf = ServiceUtil.getService("menuFacade", MenuFacade.class);
		List<String> privilegeList = (List<String>) mf.getOperationByStaff();
		String[] codes;
		boolean hasAllPrivilege = false;
		boolean hasAnyPrivilege = false;
		boolean hasNotPrivilege = false;
		if (privilegeList != null && privilegeList.size() > 0) {

			if (ifAllGrantedCode != null && !"".equals(ifAllGrantedCode)) {
				codes = ifAllGrantedCode.split(",");
				hasAllPrivilege = true;
				for (int i = 0; i < codes.length; i++) {
					if (!privilegeList.contains(codes[i].trim())) {
						hasAllPrivilege = false;
						break;
					}
				}
			}
			else if(ifAnyGrantedCode != null && !"".equals(ifAnyGrantedCode)){
				codes = ifAnyGrantedCode.split(",");
				hasAnyPrivilege = false;
				for (int i = 0; i < codes.length; i++) {
					if (privilegeList.contains(codes[i].trim())) {
						hasAnyPrivilege = true;
						break;
					}
				}	
			}
			else if(ifNotGrantedCode != null && !"".equals(ifNotGrantedCode)){
				codes = ifNotGrantedCode.split(",");
				hasNotPrivilege = true;
				for (int i = 0; i < codes.length; i++) {
					if (privilegeList.contains(codes[i].trim())) {
						hasNotPrivilege = false;
						break;
					}
				}	
			}
		}
		if (hasAllPrivilege) {
			return EVAL_BODY_INCLUDE;
		}
		else if(hasAnyPrivilege){
			return EVAL_BODY_INCLUDE;
		}
		else if(hasNotPrivilege){
			return EVAL_BODY_INCLUDE;
		}
		else {
			return SKIP_BODY;
		}
	}

	public int doEndTag() throws JspException {

		return 0;
	}

	public void release() {

	}

	public String getIfAnyGrantedCode() {
		return ifAnyGrantedCode;
	}

	public void setIfAnyGrantedCode(String ifAnyGrantedCode) {
		this.ifAnyGrantedCode = ifAnyGrantedCode;
	}

	public String getIfAllGrantedCode() {
		return ifAllGrantedCode;
	}

	public void setIfAllGrantedCode(String ifAllGrantedCode) {
		this.ifAllGrantedCode = ifAllGrantedCode;
	}

	public String getIfNotGrantedCode() {
		return ifNotGrantedCode;
	}

	public void setIfNotGrantedCode(String ifNotGrantedCode) {
		this.ifNotGrantedCode = ifNotGrantedCode;
	}

}
