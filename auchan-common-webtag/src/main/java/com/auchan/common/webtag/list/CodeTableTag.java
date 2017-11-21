/**
 * @(#) CodeTableTag.java
 */

package com.auchan.common.webtag.list;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import com.auchan.common.codetable.utils.CodeTableI18NUtil;
import com.auchan.common.codetable.vo.MetaDataVO;
import com.auchan.common.webtag.util.FreeMarkerUtil;

public class CodeTableTag extends ListControlTag implements Tag {

	private String value;// the default value of codetable.
	private String mdgroup;
	private String id;
	private String _class;
	private String style;
	private String dataBind;
	private String optionsCaption;
	private String disabled;
	private String name;
	private String ignoreValue = "";
	private String onchange;
	private List<MetaDataVO> metadata = null;
	/*exclude the option you don't need according 
	 *by the meta key.and separated by the comma.
	 **/
	private String excludeOpt="";
	/*judge if add the code before the title in the desc*/
	private String iscode="1";
	/*judge if have a caption in the selection.*/
	private String iscaption="1";
	

	/**
	 * the method doStartTag() get the server's metadata and encapsulate it to
	 * metaDataMap,we can display this metadata by freemark(xx.ftl).
	 * 
	 */
	public int doStartTag() throws JspException {

		Map<String, String> metaDataMap = null;
		List<Map<String, String>> dataList = new ArrayList<Map<String, String>>();
		String [] ignoreValueList = ignoreValue.split(",");
		String[] excludeOptArray=excludeOpt.split(",");
		Map<String, Object> rootMap = new HashMap<String, Object>();
		rootMap.put("_class", _class);
		rootMap.put("style", style);
		rootMap.put("dataBind", dataBind);
		rootMap.put("id", id);
		rootMap.put("optionsCaption", optionsCaption);
		rootMap.put("disabled", disabled);
		rootMap.put("name", name);
		rootMap.put("onchange", onchange);
		if (this.mdgroup == null || "".equals(this.mdgroup)) {

			return SKIP_BODY;
		}
		metadata = new ArrayList<MetaDataVO>();
		metadata = (List<MetaDataVO>) CodeTableI18NUtil.getMetaDataList(this.mdgroup);
		Collections.sort(metadata);
		if (metadata == null || metadata.size() == 0) {

			log.info("there is no metadata");
			rootMap.put("codeTableOptions", dataList);

		} else {
			Iterator<MetaDataVO> it = metadata.iterator();
			
			//add please select option
			if(!this.iscaption.equals("0")){
			metaDataMap = new HashMap<String, String>();
			metaDataMap.put("itemCode", "");
			metaDataMap.put("desc", CodeTableI18NUtil.getMsgById("100000009").getTitle());	
			dataList.add(metaDataMap);
			}
			while (it.hasNext()) {
				MetaDataVO metaDataVO = it.next();
				if(null == metaDataVO.getCode()){
					log.info("the code in this group is not existed");
					continue;
				}
				boolean ignore = false;
				for(int i=0;i<ignoreValueList.length;i++){
					if(ignoreValueList[i].equals(metaDataVO.getCode())){
						ignore = true;
						break;
					}
				}
				if(ignore){
					continue;
				}
				metaDataMap = new HashMap<String, String>();
				boolean isexcluded=false;
				if (metaDataVO.getCode().equals(value)) {

					metaDataMap.put("isselected", "true");
				} else {
					metaDataMap.put("isselected", "false");
				}
				for(int i=0;i<excludeOptArray.length;i++){
					if(excludeOptArray[i].equals(metaDataVO.getCode())){
						isexcluded=true;
	                       break;
					}
				}
				if(!isexcluded){
					metaDataMap.put("itemCode", metaDataVO.getCode());
					if(this.iscode.equals("0")){
					metaDataMap.put("desc", metaDataVO.getTitle());
					}
					else{
					metaDataMap.put("desc", metaDataVO.getCode()+"-"+metaDataVO.getTitle());	
					}
					dataList.add(metaDataMap);
				}				
			}
			
			
			rootMap.put("codeTableOptions", dataList);
		}
		String info = FreeMarkerUtil.getFtlText("codetable.ftl", rootMap);

		if (info == null || info.equals("")) {

			log.info("Codetable Tag Couldn't Get The Info After Parsing Template");
			return SKIP_BODY;
		}

		try {
			pageContext.getOut().write(info);
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

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getMdgroup() {
		return mdgroup;
	}

	public void setMdgroup(String mdgroup) {
		this.mdgroup = mdgroup;
	}

	public List<MetaDataVO> getMetadata() {
		return metadata;
	}

	public void setMetadata(List<MetaDataVO> metadata) {
		this.metadata = metadata;
	}

	public void setPageContext(PageContext pageContext) {
		this.pageContext = pageContext;
	}

	public void setParent(Tag t) {

	}

	public Tag getParent() {

		return null;
	}

	public String get_class() {
		return _class;
	}

	public void set_class(String _class) {
		this._class = _class;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	
	public String getDataBind() {
		return dataBind;
	}

	public void setDataBind(String dataBind) {
		this.dataBind = dataBind;
	}

	public String getOptionsCaption() {
		return optionsCaption;
	}

	public void setOptionsCaption(String optionsCaption) {
		this.optionsCaption = optionsCaption;
	}
	
	public String getDisabled() {
		return disabled;
	}
	
	public void setDisabled(String disabled) {
		this.disabled = disabled;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}

	public String getIgnoreValue() {
		return ignoreValue;
	}

	public void setIgnoreValue(String ignoreValue) {
		this.ignoreValue = ignoreValue;
	}

	public String getOnchange() {
		return onchange;
	}

	public void setOnchange(String onchange) {
		this.onchange = onchange;
	}

	public String getExcludeOpt() {
		return excludeOpt;
	}

	public void setExcludeOpt(String excludeOpt) {
		this.excludeOpt = excludeOpt;
	}

	public String getIscode() {
		return iscode;
	}

	public void setIscode(String iscode) {
		this.iscode = iscode;
	}

	public String getIscaption() {
		return iscaption;
	}

	public void setIscaption(String iscaption) {
		this.iscaption = iscaption;
	}
	
	
	
}
