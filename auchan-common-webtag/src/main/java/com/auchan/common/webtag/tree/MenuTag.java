/**
 * @(#) MenuTag.java
 */

package com.auchan.common.webtag.tree;

import java.io.IOException;
import java.io.StringReader;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.common.webtag.enums.TagSchemaEnum;
import com.auchan.rtmm.staff.service.MenuFacade;
import com.auchan.rtmm.staff.vo.MenuVO;

public class MenuTag extends BTreeDataControlTag implements Tag {

	   /**
	    * judge if the data in menu was loaded
	    */
	private boolean isFirstLoad = true;
	
	   /**
	    * the attribute defaults null.
	    */
	private Long pid;
	
       /**
         * the default selected item  in the menu.
         */
	private Long id;
	
       
       /**
        * you can overwrite the method in Jsp,and it will
        * be executed after the tag content executed,it starts
        * in the label '</auchan:menu>'
        */
	public int doEndTag() throws JspException {
		return EVAL_PAGE;

	}

    /**
     * the auchan menu style and data are concreted 
     * in this method,it firstly get the menu data from 
     * the server by the getTopMenuData() or getSubMenuTreeData(),
     * after that,the method will put this data together in xml
     * style and format it by the schema got by getSchemaURI(),
     * finally,we will output the formatted  data to the Jsp page.
     * 
     */
	@SuppressWarnings("unchecked")
	public int doStartTag() {
		MenuFacade mf = ServiceUtil.getService("menuFacade", MenuFacade.class);
			
			List<MenuVO> menus = null;
			Source dataSource=null;
			String xslStyleSheet=null;
			
			if(mf==null||"".equals(mf)){
				
				return SKIP_BODY;
			}

			if (pid == null || "".equals(pid)) {
				menus = mf.getTopMenuData();
				dataSource = this.getTopMenuData(menus);
				xslStyleSheet=TagSchemaEnum.MENU_TAG_XSL.getSchemaURI();
				
			} else {
				Long parentId = Long.valueOf(pid);
				menus = mf.getSubMenuTreeData(parentId);
				List<MenuVO> collectedList=mf.getAllFavoriteByStaff();
				dataSource = this.getSubMenuData(parentId,menus,collectedList);
				xslStyleSheet=TagSchemaEnum.SUBMENU_TAG_XSL.getSchemaURI();
				
			}

			String htmlFileStr = xslParseXml(xslStyleSheet, dataSource);

			try {
				pageContext.getOut().write(htmlFileStr);
			} catch (IOException e) {
				log.error(" error on output :" + htmlFileStr, e);
			}

		return EVAL_BODY_INCLUDE;
	}

	/**
	 * Format the subMenuTag data in the style of xml according 
	 * by the subMenu data from the server.
	 * 
	 * 
	 * @param parentId:get the parent menu's ID,
	 * @param menus:get the data of sub menu 
	 * @param collectedList: the favorite menu list.
	 * 
	 */
	
	private Source getSubMenuData(Long parentId,List<MenuVO> menus,List<MenuVO> collectedList) {

		StringBuffer subMenuXmlData = new StringBuffer();
		subMenuXmlData.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		subMenuXmlData.append("<menu id=\"Menu\" ");

		 subMenuXmlData.append(">");

		 StringBuffer subMenuDataRecursion = new StringBuffer();		
		 subMenuXmlData.append(setSubItem(parentId, menus, subMenuDataRecursion,collectedList));
			

		
		subMenuXmlData.append("</menu>");

		String strSubMenuXmlData=subMenuXmlData.toString();
		StringReader stringReader = new StringReader(strSubMenuXmlData);
		Source dataSource = new StreamSource(stringReader);
		return dataSource;
	}

	/**
	 * Format the subMenuTag data in the style of xml according 
	 * by the subMenu data from the server.
	 * 
	 * 
	 * @param parentId:get the parent menu's ID,
	 * @param mlist:get the data of sub menu, 
	 * @param bf:append the record of submenu data in the style of xml in the recursion.
	 * @param collectedList: the favorite menu list.
	 */
	
	private String setSubItem(Long parentId ,List<MenuVO> mlist ,StringBuffer bf,List<MenuVO> collectedList){

		for(MenuVO mb : mlist){
             Long subpId=mb.getParentId();
			if(subpId.equals(parentId)){
				bf.append("<item id=\"" + mb.getId() + "\" class=\"\" pid=\"" + mb.getParentId()
						+ "\"");
				String isCollectedStr="";
				for(MenuVO collectedMenu:collectedList){
					
					if(mb.getId().equals(collectedMenu.getId())){
						isCollectedStr=" iscollected=\"true\" ";			
						break;
					}
					else{
						isCollectedStr=" iscollected=\"false\" ";
					}
				}
				bf.append(isCollectedStr);
				if(mb.getId().equals(this.id)){
					
					bf.append(" isselected=\"true\" ");
				}
				else{
					
					bf.append(" isselected=\"false\" ");
				}
				bf.append(" title=\"" + mb.getTitle() + "\"");
				String url=mb.getUrl();
				if (url == null || "".equals(url)) {
					url="";
				}
				bf.append(" url=\"" + url + "\">");
				setSubItem(mb.getId(),mlist ,bf,collectedList);
				bf.append("</item>");
				
			}
		}

		return bf.toString();
	}
	
	/**
	 * Format the topMenuTag data in the style of xml according 
	 * by the topMenu data from the server.
	 * 
	 * @param menus:the data of top menu,
	 */
	
	
	private Source getTopMenuData(List<MenuVO> menus) {
        if(menus==null)
        {
        	return null;
        }
		StringBuffer topMenuXmlData = new StringBuffer();
		topMenuXmlData.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		topMenuXmlData.append("<menu id=\"Menu\">");
		for (MenuVO mb : menus) {

				topMenuXmlData.append("<item id=\"" + mb.getId()
						+ "\" class=\""+ mb.getName()+"_"+mb.getKey()+"\"");

				if(mb.getId().equals(this.id)){
					
					topMenuXmlData.append(" isselected=\"true\" ");
				}
				else{
					
					topMenuXmlData.append(" isselected=\"false\" ");
				}

				topMenuXmlData.append(" title=\"" + mb.getTitle() + "\">");
				topMenuXmlData.append("</item>");

		}	
		topMenuXmlData.append("</menu>");
		StringReader stringReader = new StringReader(topMenuXmlData.toString());
		Source dataSource = new StreamSource(stringReader);
		return dataSource;
	}

    /**
     *Called on a Tag handler to release state.
     */
	public void release() {

	}

	/**
	 * Set the parent (closest enclosing tag handler) of this tag handler.
	 */
	public void setParent(Tag t) {
		
	}
	/**
	 * Get the parent (closest enclosing tag handler) for this tag handler.
	 */
	public Tag getParent() {
		return null;
	}
	
	
	/**
	 *get and set the particular property of this tag
	 */
	
	public boolean isFirstLoad() {
		return isFirstLoad;
	}

	public void setFirstLoad(boolean isFirstLoad) {
		this.isFirstLoad = isFirstLoad;
	}


	public Long getPid() {
		return pid;
	}


	public void setPid(Long pid) {
		this.pid = pid;
	}


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}

}