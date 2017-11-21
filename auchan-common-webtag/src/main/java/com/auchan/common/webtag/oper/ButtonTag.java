/**
 * @(#) ButtonTag.java
 */

package com.auchan.common.webtag.oper;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;

import com.auchan.common.webtag.util.FreeMarkerUtil;

public class ButtonTag extends OpControlTag implements Tag
{

	private String modulekey;
	private String pagekey;
	private String ctrlkey;
	private String extrapathkey;
	
	/*
	 * rule the button will get the focus
	 *  automatically when uploading the page. 
	 */
	private String btnautofocus; 
	private String btndisabled;
	private String btnform;//rule the button belongs to one or more forms 
	private String btnname;
	private String btntype; 
	private String btntext;
	private String btnvalue;
	private String btnclass;
	private String btnevent;//the event when the button is clicked 
	
    private boolean isHavaCtrlKey=true;
    private boolean isPrivileged=true;
    private boolean isDisabled=true;
   

    
	
	


	public int doStartTag() throws JspException {
		
		
		if(this.ctrlkey==null||"".equals(this.ctrlkey)){
			
			log.info("THE CTRL KEY MUST BE SET VALUE!");		
			isHavaCtrlKey=false;
		}
		    isPrivileged=checkIfCtrlPriGranted(modulekey,pagekey,ctrlkey,this.extrapathkey);
		    

		    if(btndisabled=="false"){
		    	
		    	isDisabled=Boolean.parseBoolean(btndisabled);
		    }
		    else{
		    	
		    	isDisabled=true;
		    }
		    
		   isDisabled=isDisabled&&isPrivileged&&isHavaCtrlKey;
		   
		   if(isDisabled==true){
			   
			   btndisabled=null;
			   
		   }
		   else{
			   btndisabled="disabled";
		   }
		 /*/
		  * encapsulate the button attribute in the key-value style  
		  */
         Map<String,String> btnAttr=new HashMap<String,String>();
         btnAttr.put("btnautofocus", btnautofocus);
         btnAttr.put("btndisabled", btndisabled);
         btnAttr.put("btnform", btnform);
         btnAttr.put("btnname", btnname);
         btnAttr.put("btntype", btntype);
         btnAttr.put("btnvalue", btnvalue);
         btnAttr.put("btnclass", btnclass);
         btnAttr.put("btnevent", btnevent);
         btnAttr.put("btntext", btntext);

         String info = FreeMarkerUtil.getFtlText("button.ftl",btnAttr);
         
		
		try {
			
			pageContext.getOut().write(info);
			
		} catch (IOException e) {
			
			log.error("ButtonTag Str Output To Page Error:",e);
		}
		

		return EVAL_BODY_INCLUDE;
	}
	
	
	
	
	public boolean checkIfCtrlPriGranted(String modulekey,String pagekey,String ctrlkey,String extrapathkey){
		
		
		
		
		
		return true;

	}
	

	public int doEndTag() throws JspException {

		return 0;
	}

	public void release() {

		
	}
	
	public void setParent(Tag t) {

		
	}

	public Tag getParent() {

		return null;
	}

	public String getModulekey() {
		return modulekey;
	}

	public void setModulekey(String modulekey) {
		this.modulekey = modulekey;
	}

	public String getPagekey() {
		return pagekey;
	}

	public void setPagekey(String pagekey) {
		this.pagekey = pagekey;
	}

	public String getCtrlkey() {
		return ctrlkey;
	}

	public void setCtrlkey(String ctrlkey) {
		this.ctrlkey = ctrlkey;
	}

	public String getExtrapathkey() {
		return extrapathkey;
	}

	public void setExtrapathkey(String extrapathkey) {
		this.extrapathkey = extrapathkey;
	}

	public String getBtnautofocus() {
		return btnautofocus;
	}

	public void setBtnautofocus(String btnautofocus) {
		this.btnautofocus = btnautofocus;
	}

	public String getBtndisabled() {
		return btndisabled;
	}

	public void setBtndisabled(String btndisabled) {
		this.btndisabled = btndisabled;
	}

	public String getBtnform() {
		return btnform;
	}

	public void setBtnform(String btnform) {
		this.btnform = btnform;
	}

	public String getBtnname() {
		return btnname;
	}

	public void setBtnname(String btnname) {
		this.btnname = btnname;
	}

	public String getBtntype() {
		return btntype;
	}

	public void setBtntype(String btntype) {
		this.btntype = btntype;
	}

	public String getBtnvalue() {
		return btnvalue;
	}

	public void setBtnvalue(String btnvalue) {
		this.btnvalue = btnvalue;
	}

	public String getBtnclass() {
		return btnclass;
	}

	public void setBtnclass(String btnclass) {
		this.btnclass = btnclass;
	}

	public String getBtnevent() {
		return btnevent;
	}

	public void setBtnevent(String btnevent) {
		this.btnevent = btnevent;
	}

	public String getBtntext() {
		return btntext;
	}
	
	public void setBtntext(String btntext) {
		this.btntext = btntext;
	}

	
}
