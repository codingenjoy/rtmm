package com.auchan.rtmm.util.freemarker;

import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import freemarker.cache.TemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class StringTemplateLoader implements TemplateLoader{

	private static final String DEFAULT_TEMPLATE_KEY = "_default_template_key";
	private Map<String, Object> templates = new HashMap<String, Object>();
	
	private StringTemplateLoader(String defaultTemplate) {
		if (defaultTemplate != null && !defaultTemplate.equals("")) {
			templates.put(DEFAULT_TEMPLATE_KEY, defaultTemplate);
		}
	}

	public void AddTemplate(String name, String template) {
		
		if (name == null || template == null || name.equals("")|| template.equals("")) {
			return;
		}
		if (!templates.containsKey(name)) {
			templates.put(name, template);
		}
	}

	public Object findTemplateSource(String name) throws IOException {

		if (name == null || name.equals("")) {

			name = DEFAULT_TEMPLATE_KEY;

		}

		return templates.get(name);

	}

	public long getLastModified(Object templateSource) {

		return 0;

	}
	public Reader getReader(Object templateSource, String encoding) throws IOException {

		return new StringReader((String) templateSource);

	}

	@Override
	public void closeTemplateSource(Object templateSource) throws IOException {
		// TODO Auto-generated method stub	
	}
	/**
	 * 解析字符串类型freemarker模板
	 * @param templateString
	 * @param rootValue
	 * @return
	 */
	public static String getTemplateString(String templateString,Map<String, Object> rootValue)
	{  
		String info=null;
		Configuration configuration = new Configuration();
		configuration.setTemplateLoader(new StringTemplateLoader(templateString));    
		configuration.setDefaultEncoding("UTF-8");    
        Template template;
        StringWriter writer = null;
		try {
			template = configuration.getTemplate("");
			writer = new StringWriter();    
			template.process(rootValue, writer); 
			info = writer.toString();
		} catch (IOException e) {
			System.out.println("template load error.....");
			e.printStackTrace();
		} catch (TemplateException e) {
			System.out.println("template load value error.....");
			e.printStackTrace();
		}    
        return info;  
	}
	
}
