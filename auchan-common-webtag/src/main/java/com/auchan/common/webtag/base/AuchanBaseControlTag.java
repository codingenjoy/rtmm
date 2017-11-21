/**
 * @(#) AuchanBaseControlTag.java
 */

package com.auchan.common.webtag.base;

import java.net.URL;
import java.util.List;

import javax.servlet.jsp.PageContext;

import org.omg.CORBA.Object;

import com.auchan.common.core.util.ServiceUtil;
import com.auchan.common.logging.AuchanLogger;
import com.auchan.common.security.SessionKeyStore;
import com.auchan.rtmm.staff.service.RoleFacade;

/**
 * <html>
 *   <head>
 *     <title>1.    </title>
 *     
 *   </head>
 *   <body>
 *     <p>
 *       1.html-related attributes which is defined in JSP Standard Library
 *     </p>
 *     <p>
 *       @id
 *     </p>
 *     <p>
 *       @name
 *     </p>
 *     <p>
 *       @class
 *     </p>
 *     <p>
 *       @value, which support JSTL-style expression. for example: ${....}
 *     </p>
 *   </body>
 * </html>
 */
public abstract class AuchanBaseControlTag extends JSTLTag implements IAuchanControl
{
	
	
	public PageContext pageContext;
	
	public URL getCtrlTemplateURL() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getSCMSessionId() {
		return SessionKeyStore.get();
	}

	protected final static AuchanLogger log = AuchanLogger.getLogger(AuchanBaseControlTag.class);
	
	public String appKey = "rtmm";
	public String moduleKey = "__default__";
	public String pageKey;
	
	public String ctrlKey;
	/**
	 * @extraPathKey may be NULL
	 */
	public String extraPathKey;
	

	protected List getCtrlPrivilegeData()
	{

		RoleFacade rf = ServiceUtil.getService("roleFacade", RoleFacade.class);
		return null;
	}
	
	protected abstract Object getCtrlData();
	
	
	public String getCtrlFullQualifiedName() {
		StringBuffer fqn = new StringBuffer(this.appKey).append("/").append(this.moduleKey).append("/");
		if (this.extraPathKey != null && !this.extraPathKey.trim().equals(""))
			fqn.append(this.extraPathKey).append("/");
		fqn.append(this.pageKey).append("/");
		fqn.append(this.ctrlKey);
		return fqn.toString();
	}


	public String getModuleKey() {
		return moduleKey;
	}

	public void setModuleKey(String moduleKey) {
		this.moduleKey = moduleKey;
	}

	public String getPageKey() {
		return pageKey;
	}

	public void setPageKey(String pageKey) {
		this.pageKey = pageKey;
	}

	public String getCtrlKey() {
		return ctrlKey;
	}

	public void setCtrlKey(String ctrlKey) {
		this.ctrlKey = ctrlKey;
	}

	public String getExtraPathKey() {
		return extraPathKey;
	}

	public void setExtraPathKey(String extraPathKey) {
		this.extraPathKey = extraPathKey;
	}

	public PageContext getPageContext() {
		return pageContext;
	}

	public void setPageContext(PageContext pageContext) {
		this.pageContext = pageContext;
	}
	
}
