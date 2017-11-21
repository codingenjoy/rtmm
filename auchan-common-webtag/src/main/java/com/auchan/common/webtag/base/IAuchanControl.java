/**
 * @(#) IAuchanControl.java
 */

package com.auchan.common.webtag.base;

import java.net.URL;

public interface IAuchanControl
{
	String getCtrlFullQualifiedName( );
	
	URL getCtrlTemplateURL( );
	
	String getSCMSessionId( );
	
	
}
