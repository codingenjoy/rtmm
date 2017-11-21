package com.auchan.rtmm.util.freemarker;

import java.util.HashMap;
import java.util.Map;

public class CreateHtmlTest {
	
	public static void main(String[] args) {
		HtmlContent obj = new HtmlContent();
		obj.setUserName("allen");
		obj.setUserPassword("123456");

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("root", obj);
		String templatesPath = "D:/_img/_templates";
		String templateFile = "/createhtml.ftl";
		String htmlFile = templatesPath + "/0077.html";
		FreeMarkerUtil.analysisTemplate(templatesPath, templateFile, htmlFile, dataMap);
	}
	
}
