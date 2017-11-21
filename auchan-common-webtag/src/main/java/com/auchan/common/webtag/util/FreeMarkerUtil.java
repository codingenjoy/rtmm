package com.auchan.common.webtag.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import com.auchan.common.logging.AuchanLogger;
import com.auchan.common.webtag.tree.BTreeDataControlTag;

import freemarker.cache.StringTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class FreeMarkerUtil {
	

	private final static AuchanLogger log = AuchanLogger.getLogger(FreeMarkerUtil.class);
	private final static int BUFFER_SIZE = 4096; 
	
    
	/**
	 * the method is a template of freemarker, 
	 * we can by using the root(map<key,value>)
	 * match the value to the template.
	 * 
	 *
	 * @param templateName
	 * @param root
	 * @return
	 */
	
	public static String getFtlText(String templateName, Map<?, ?> root) {


			

		        /*get the template resource error*/
				String templateContent = null;
				try {

					templateContent = InputStreamTOString(FreeMarkerUtil.class.getResourceAsStream("/freemarker/"+templateName));
				} catch (Exception e) {
					
					log.error("get freemark template resource error: ", e);
				}
				if(templateContent==null||templateContent.equals("")){
					log.info("freemarker couldn't get the template content");
					return null;
				}
				
				/*get the templateloader*/
			    StringTemplateLoader stringLoader = new StringTemplateLoader();

			    stringLoader.putTemplate("freemarkerTemplate",templateContent);
			    
				/* init the configuration of freemark*/
				Configuration config = new Configuration();
				config.setTemplateLoader(stringLoader);
				
				/*get the codetable template*/
				Template template = null;
				try {
					template = config.getTemplate("freemarkerTemplate");
				} catch (IOException e) {
					
					log.error("get freemark template  error:", e);
				}
				StringWriter writer=new StringWriter();
				
				/* transform the map data to stringwriter according by freemark template*/
				
				if(root==null||root.size()==0){
			        log.info("freemarker couldn't get the root Map");
					return null;
				}
				try {
					template.process(root, writer);
				} catch (TemplateException e) {
					log.error("freemark template process error:", e);
				} catch (IOException e) {
					log.error("freemark template process IO error:", e);
				}

				String info=writer.toString();
				return info;		
			
}

 /**
  * get the template content by the output stream 
  * 
  * @param in
  * 
  */
	public static String InputStreamTOString(InputStream in) throws Exception{  
        
        ByteArrayOutputStream outStream = new ByteArrayOutputStream();  
        byte[] data = new byte[BUFFER_SIZE];  
        int count = -1;  
        while((count = in.read(data,0,BUFFER_SIZE)) != -1)  
            outStream.write(data, 0, count);  
          
        data = null;
        outStream.close();
        return new String(outStream.toByteArray(),"UTF-8");  
    } 



}
