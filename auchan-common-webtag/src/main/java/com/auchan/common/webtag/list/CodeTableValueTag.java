package com.auchan.common.webtag.list;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import com.auchan.common.codetable.utils.CodeTableI18NUtil;
import com.auchan.common.codetable.vo.MetaDataVO;

public class CodeTableValueTag extends ListControlTag implements Tag {

	private String code;
	private String mdgroup;
	private MetaDataVO metaDataVO = null;
	// showType=1 only show code
	// showType=2 only show title
	// default showType=3 show code + title
	private String showType = "3";

	public int doStartTag() throws JspException {
		metaDataVO = CodeTableI18NUtil.getMetaData(this.mdgroup, this.code);
		StringBuilder show = new StringBuilder("");
		if ("1".equals(showType)) {
			show.append(metaDataVO.getCode());
		} else if ("2".equals(showType)) {
			show.append(metaDataVO.getTitle());
		} else if ("3".equals(showType)) {
			show.append(metaDataVO.getCode());
			show.append("-");
			show.append(metaDataVO.getTitle());
		}
		try {
			if (null != metaDataVO.getCode()) {
				pageContext.getOut().write(show.toString());
			}else{
				pageContext.getOut().write("");
			}
		} catch (IOException e) {
			log.error("CodeTableTag OutPut Error:", e);
		}
		return EVAL_BODY_INCLUDE;
	}

	public int doEndTag() throws JspException {

		return 0;
	}

	public void release() {

	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMdgroup() {
		return mdgroup;
	}

	public void setMdgroup(String mdgroup) {
		this.mdgroup = mdgroup;
	}

	public void setPageContext(PageContext pageContext) {
		this.pageContext = pageContext;
	}

	public void setParent(Tag t) {

	}

	public Tag getParent() {

		return null;
	}

	public String getShowType() {
		return showType;
	}

	public void setShowType(String showType) {
		this.showType = showType;
	}

}
