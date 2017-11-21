package com.auchan.rtmm.util.excel;

import java.io.IOException;

/**
 * 接口，Excel行级处理器
 */
public interface ExcelRowProcessor {
	public void processByRow() throws Exception;

	public void processByRow(int sheetIndex) throws Exception;

	public void processRow(XRow row);

	public void stop() throws IOException;
}
