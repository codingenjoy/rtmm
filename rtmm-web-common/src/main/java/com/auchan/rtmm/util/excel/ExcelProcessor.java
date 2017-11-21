package com.auchan.rtmm.util.excel;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

/**
 * Excel处理器，兼容Excel-2003与Excel-2007
 */
public abstract class ExcelProcessor implements ExcelRowProcessor {
	private ExcelRowProcessor processor;

	public ExcelProcessor(InputStream inputStream, String version) throws Exception {
		if ("2003".equals(version)) {
			processor = new MyExcel2003RowProcessor(inputStream);
		} else {
			processor = new MyExcel2007RowProcessor(inputStream);
		}
	}

	public void processByRow() throws Exception {
		processor.processByRow();
	}

	public void processByRow(int sheetIndex) throws Exception {
		processor.processByRow(sheetIndex);
	}

	public void stop() throws IOException {
		processor.stop();
	}

	public abstract void processRow(XRow row);

	private class MyExcel2003RowProcessor extends Excel2003RowProcessor {
		public MyExcel2003RowProcessor(InputStream inputStream) throws Exception {
			super(inputStream);
		}

		@Override
		public void processRow(XRow row) {
			ExcelProcessor.this.processRow(row);
		}
	}

	private class MyExcel2007RowProcessor extends Excel2007RowProcessor {
		public MyExcel2007RowProcessor(InputStream inputStream) throws Exception {
			super(inputStream);
		}

		@Override
		public void processRow(XRow row) {
			ExcelProcessor.this.processRow(row);
		}
	}
}
