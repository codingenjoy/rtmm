/**
 * @(#) BTreeDataControlTag.java
 */

package com.auchan.common.webtag.tree;

import java.io.IOException;
import java.io.StringWriter;
import java.net.URL;


import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.omg.CORBA.Object;

import com.auchan.common.webtag.base.AuchanBaseControlTag;




public class BTreeDataControlTag extends AuchanBaseControlTag
{
	
	/**
	 * Set the xml file source of tag's data
	 */
	public String xmlDataSrcStr;
	
	 /**
     * Set the xml file URL of tag's data,it is 
     * a additional attribute as same as 'xmlDataSrcStr'.
     *
     */
	public URL xmlDataSrcURL;

	/**
	 * Set the source of the xsl parsing the xml file.
	 */
	public String xslStyleSheetSrc;
    


	@Override
	protected Object getCtrlData() {
		
		return null;
	} 
    
	/**
	 * 
	 * this method is setted for parse xml in the xsl schema,
	 * you can use it by extend the class.
	 * 
	 * 
	 * @param xslStyleSheetSrc
	 * @param dataSource
	 * @return
	 */
    
	protected String xslParseXml(String xslStyleSheetSrc,Source  dataSource)
	{
			URL xslUrl = BTreeDataControlTag.class.getResource(xslStyleSheetSrc);

			Source xslSource = null;
			try {
				xslSource = new StreamSource(xslUrl.openStream());
			} catch (IOException e) {
				log.error("error on load xsl stream from :" + xslUrl!=null?xslUrl.toString():null, e);
			}
			TransformerFactory tFac = TransformerFactory.newInstance();
			Transformer t = null;
			try {
				t = tFac.newTransformer(xslSource);
			} catch (TransformerConfigurationException e) {
				log.error("error on get one new transformer with xsl source:" + xslSource, e);
			}
			
	        StringWriter htmlFile=new StringWriter();
	        Result result = new StreamResult(htmlFile);
 
	        try {
				t.transform(dataSource, result);
			} catch (TransformerException e) {
				log.error("error on transform.", e);
			}
	        return htmlFile.toString();
	        

	}
	
	
	/**
	 *get and set the particular property of this tag
	 */
	
	public void setXmlDataSrcStr(String xmlDataSrcStr) {
		this.xmlDataSrcStr = xmlDataSrcStr;
	}



	public URL getXmlDataSrcURL() {
		return xmlDataSrcURL;
	}



	public void setXmlDataSrcURL(URL xmlDataSrcURL) {
		this.xmlDataSrcURL = xmlDataSrcURL;
	}
	
	public String getXslStyleSheetSrc() {
		return xslStyleSheetSrc;
	}



	public void setXslStyleSheetSrc(String xslStyleSheetSrc) {
		this.xslStyleSheetSrc = xslStyleSheetSrc;
	}
    
    
	public String getXmlDataSrcStr() {

		return xmlDataSrcStr;
	}

	
}
