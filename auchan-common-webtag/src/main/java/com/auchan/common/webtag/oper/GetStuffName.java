package com.auchan.common.webtag.oper;


import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.common.security.SessionKeyStore;
import com.auchan.common.security.enums.SESSION_NAMED_FILEDS;
import com.auchan.common.security.enums.SYS_LANG;
import com.auchan.common.security.session.SessionAccessFacade;
import com.auchan.common.webtag.list.ListControlTag;
import com.auchan.rtmm.staff.service.StaffFacade;
import com.auchan.rtmm.staff.service.StaffSessionFacade;
import com.auchan.rtmm.staff.vo.RuntimeStaffVO;
import com.auchan.rtmm.staff.vo.StaffVO;

public class GetStuffName extends ListControlTag implements Tag {

	private String value;
	
	
	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Override
	public int doStartTag() throws JspException {
		try {
			StaffFacade sf = ServiceUtil.getService("staffFacade",StaffFacade.class);
			StaffVO staffVO = sf.getStaffInfoByStaffNo(value);
            if(staffVO!=null){
            	pageContext.getOut().write(staffVO.getName());
            }
            else{
            	pageContext.getOut().write(value);
            }
		} catch (IOException e) {
			log.error("CodeTableTag OutPut Error:", e);
		}
		return EVAL_BODY_INCLUDE;
	}

	@Override
	public void setParent(Tag t) {
		
		
	}

	@Override
	public Tag getParent() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int doEndTag() throws JspException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void release() {
		// TODO Auto-generated method stub
		
	}
	
	public void setPageContext(PageContext pageContext) {
		this.pageContext = pageContext;
	}

	
}
