package com.auchan.rtmm.util.freemarker;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class FreeMarkerUtil {

	/**
	 * templatePath模板文件存放路径,templateName 模板文件名称,filename 生成的文件名称
	 * 
	 * @param templatePath
	 * @param templateName
	 * @param fileName
	 * @param root
	 */
	public static void analysisTemplate(String templatePath, String templateName, String fileName, Map<?, ?> root) {
		try {
			// 初使化FreeMarker配置
			Configuration config = new Configuration();
			// 设置要解析的模板所在的目录，并加载模板文件
			config.setDirectoryForTemplateLoading(new File(templatePath));
			// 设置包装器，并将对象包装为数据模型
			config.setObjectWrapper(new DefaultObjectWrapper());

			// 获取模板,并设置编码方式，这个编码必须要与页面中的编码格式一致
			// 否则会出现乱码
			Template template = config.getTemplate(templateName, "UTF-8");
			// 合并数据模型与模板
			FileOutputStream fos = new FileOutputStream(fileName);
			Writer out = new OutputStreamWriter(fos, "UTF-8");
			template.process(root, out);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}
	}

	public static String process(String path,String file, Map data) throws Exception {
		//1创建Configuration  
		Configuration cfg=new Configuration();
		try {
			cfg.setDirectoryForTemplateLoading(new File(path));
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 2生成Template实例
		Template template = cfg.getTemplate(file, "UTF-8");
		// 4通过Template实例的process方法把数据放入模板中
		StringWriter writer = new StringWriter();
		try {
			template.process(data, writer);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return writer.toString();
	}

}
