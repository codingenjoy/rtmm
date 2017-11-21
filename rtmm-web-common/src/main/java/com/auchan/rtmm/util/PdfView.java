package com.auchan.rtmm.util;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.springframework.web.servlet.view.document.AbstractPdfView;
import org.xhtmlrenderer.pdf.ITextFontResolver;
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.auchan.rtmm.util.freemarker.FreeMarkerUtil;
import com.lowagie.text.Document;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;

public class PdfView extends AbstractPdfView {

	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document document, PdfWriter writer, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String filename = MapUtils.getString(model, "fileName");
		String templateName = MapUtils.getString(model, "templateName");
		Map<String, Object> paramMap = MapUtils.getMap(model, "paramMap");
		filename = java.net.URLEncoder.encode(filename, "UTF-8");
		response.setContentType("application/pdf");
		response.setHeader("Content-disposition", "attachment;filename=" + filename + ".pdf");
		
		StringBuilder path = new StringBuilder("");
		path.append(request.getSession().getServletContext().getRealPath(""));
		path.append(File.separator);
		path.append("WEB-INF");
		path.append(File.separator);
		path.append("classes");
		path.append(File.separator);
		path.append("template");
		path.append(File.separator);
		
		String content = FreeMarkerUtil.process(path.toString(), templateName, paramMap);
		
		// 以下是具体的pdf要输出内容的操作代码
		ITextRenderer renderer = new ITextRenderer();
		renderer.setDocumentFromString(content);
		ITextFontResolver fontResolver = renderer.getFontResolver();
		fontResolver.addFont(path + File.separator + "tahoma.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
		fontResolver.addFont(path + File.separator + "MSYH.TTF", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
		renderer.layout();
		renderer.createPDF(response.getOutputStream());
		// document.add(new Paragraph(strHtml) );
		response.flushBuffer();
	}

}
