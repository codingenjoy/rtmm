package com.auchan.rtmm.util.excel;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;

import com.auchan.rtmm.rp.vo.LBatchRpDmVO;
import com.auchan.rtmm.rp.vo.LBatchRpItemVO;
import com.auchan.rtmm.util.StringUtils;

public class RPReadExcel extends ExcelProcessor {

	LBatchRpDmVO rpDm = null;
	List<LBatchRpItemVO> rpList = null;
	Map<Integer, String> storeMap = null;
	
	Integer overallError = null;
	String overallErrMsg = null;
	
	Integer totalRecord = 0;
	Integer totalStore = 0;
	String version = null;
	
	String itemNo;
	String itemName;
	String buyPrice;
	String dcSupNo;
	String dcSupName;
	String ordMultiParm;
	String initTotQty;
	String initTotAmnt;
	String storeQty;

	public LBatchRpDmVO getRpDm() {
		return rpDm;
	}

	public void setRpDm(LBatchRpDmVO rpDm) {
		this.rpDm = rpDm;
	}

	public List<LBatchRpItemVO> getRpList() {
		return rpList;
	}

	public void setRpList(List<LBatchRpItemVO> rpList) {
		this.rpList = rpList;
	}
	
	public Map<Integer, String> getStoreMap() {
		return storeMap;
	}

	public void setStoreMap(Map<Integer, String> storeMap) {
		this.storeMap = storeMap;
	}

	public Integer getOverallError() {
		return overallError;
	}

	public void setOverallError(Integer overallError) {
		this.overallError = overallError;
	}

	public String getOverallErrMsg() {
		return overallErrMsg;
	}

	public void setOverallErrMsg(String overallErrMsg) {
		this.overallErrMsg = overallErrMsg;
	}

	public Integer getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(Integer totalRecord) {
		this.totalRecord = totalRecord;
	}

	public Integer getTotalStore() {
		return totalStore;
	}

	public void setTotalStore(Integer totalStore) {
		this.totalStore = totalStore;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getItemNo() {
		return itemNo;
	}

	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getBuyPrice() {
		return buyPrice;
	}

	public void setBuyPrice(String buyPrice) {
		this.buyPrice = buyPrice;
	}

	public String getDcSupNo() {
		return dcSupNo;
	}

	public void setDcSupNo(String dcSupNo) {
		this.dcSupNo = dcSupNo;
	}

	public String getDcSupName() {
		return dcSupName;
	}

	public void setDcSupName(String dcSupName) {
		this.dcSupName = dcSupName;
	}

	public String getOrdMultiParm() {
		return ordMultiParm;
	}

	public void setOrdMultiParm(String ordMultiParm) {
		this.ordMultiParm = ordMultiParm;
	}

	public String getInitTotQty() {
		return initTotQty;
	}

	public void setInitTotQty(String initTotQty) {
		this.initTotQty = initTotQty;
	}

	public String getInitTotAmnt() {
		return initTotAmnt;
	}

	public void setInitTotAmnt(String initTotAmnt) {
		this.initTotAmnt = initTotAmnt;
	}

	public String getStoreQty() {
		return storeQty;
	}

	public void setStoreQty(String storeQty) {
		this.storeQty = storeQty;
	}

	public RPReadExcel(InputStream inputStream) throws Exception {
		super(inputStream, "2007");
		rpDm = new LBatchRpDmVO();
		rpList = new ArrayList<LBatchRpItemVO>();
		storeMap = new HashMap<Integer, String>();
	}

	@Override
	public void processRow(XRow row) {
		// 解析出版本號
		if (row.getRowIndex() == 1) {
			version = row.getCell(1).getValue();
			if (StringUtils.isEmpty(version)
					|| (!StringUtils.isEmpty(version) && !version
							.equals("v1.0"))) {
				overallError = 1;
				overallErrMsg = "模板版本有误, 请下载最新版本";
			}
			return;
		}

		// 解析出RP DM编号
		if (row.getRowIndex() == 3) {
			String rmdNoStr = row.getCell(1).getValue();
			if (!StringUtils.isEmpty(rmdNoStr)
					&& StringUtils.isNumeric(rmdNoStr)) {
				rpDm.setRmdNo(Integer.valueOf(rmdNoStr));
			} else {
				overallError = 1;
				overallErrMsg = overallErrMsg + " RP-DM编号有误";
			}
			return;
		}
		
		// 解析出课别编号
		if (row.getRowIndex() == 4) {
			String catlgIdStr = row.getCell(1).getValue();
			if (!StringUtils.isEmpty(catlgIdStr)
					&& StringUtils.isNumeric(catlgIdStr)) {
				rpDm.setCatlgId(Integer.valueOf(catlgIdStr));
			} else {
				overallError = 1;
				overallErrMsg = overallErrMsg + " 课别编号有误";
			}
			return;
		}
		
		// 解析出物流中心编号
		if (row.getRowIndex() == 5) {
			String dcStoreNoStr = row.getCell(1).getValue();
			if (!StringUtils.isEmpty(dcStoreNoStr)
					&& StringUtils.isNumeric(dcStoreNoStr)) {
				rpDm.setDcStoreNo(Integer.valueOf(dcStoreNoStr)); 
			} else {
				overallError = 1;
				overallErrMsg = overallErrMsg + " 物流中心编号有误";
			}
			return;
		}
		
		// 解析是否需要门店确认
		if (row.getRowIndex() == 6) {
			String stCnfrmIndStr = row.getCell(1).getValue();
			if (!StringUtils.isEmpty(stCnfrmIndStr) && (stCnfrmIndStr.equals("是") || stCnfrmIndStr.equals("否") )) {
				if (stCnfrmIndStr.equals("是")){
					rpDm.setStCnfrmInd(1);
				}
				else{
					rpDm.setStCnfrmInd(0);
				}
			} else {
				overallError = 1;
				overallErrMsg = overallErrMsg + " 请选择是否需要门店确认";
			}
			return;
		}
		
		// 若需要门店确认, 门店确认期间不可为空
		if (row.getRowIndex() == 7) {
			String stCnfrmStartDateStr = row.getCell(1).getValue();
			String stCnfrmEndDateStr = row.getCell(3).getValue();
			
			if (rpDm.getStCnfrmInd() == 1 && ( !StringUtils.isEmpty(stCnfrmStartDateStr) && !StringUtils.isEmpty(stCnfrmEndDateStr))) {
				rpDm.setStCnfrmBeginDate(HSSFDateUtil.getJavaDate(Double.valueOf(stCnfrmStartDateStr)));
				rpDm.setStCnfrmEndDate(HSSFDateUtil.getJavaDate(Double.valueOf(stCnfrmEndDateStr)));
			}else{
				overallError = 1;
				overallErrMsg = overallErrMsg + " 门店确认期间不可为空";
			}
			return;
		}
		
		// 解析门店补货时间
		if (row.getRowIndex() == 8) {
			String stRepStartDateStr = row.getCell(1).getValue();
			String stRepEndDateStr = row.getCell(3).getValue();
			if ((!StringUtils.isEmpty(stRepStartDateStr) && !StringUtils.isEmpty(stRepEndDateStr))) {
				rpDm.setStRepBeginDate(HSSFDateUtil.getJavaDate(Double.valueOf(stRepStartDateStr)));
				rpDm.setStRepEndDate(HSSFDateUtil.getJavaDate(Double.valueOf(stRepEndDateStr)));
			}
			else{
				overallError = 1;
				overallErrMsg = overallErrMsg + " 门店补货时间不可为空";
			}
			return;
		}
		
		if (row.getRowIndex() == 10) {
			String rpTotQtyStr = row.getCell(1).getValue();
			if (!StringUtils.isEmpty(rpTotQtyStr) && StringUtils.isNumeric(rpTotQtyStr)){
				rpDm.setRpTotQty(Integer.valueOf(rpTotQtyStr));
			}else{
				overallError = 1;
				overallErrMsg = overallErrMsg + " RP总建议量有误";
			}
			return;
		}
		
		if (row.getRowIndex() == 11) {
			String rpTotAmntStr = row.getCell(1).getValue();
			if (!StringUtils.isEmpty(rpTotAmntStr) && StringUtils.isNumeric(rpTotAmntStr)){
				rpDm.setRpTotAmnt(Double.valueOf(rpTotAmntStr));
			}else{
				overallError = 1;
				overallErrMsg = overallErrMsg + " RP总金额有误";
			}
			return;
		}
		
		// 解析總下傳商品數
		if (row.getRowIndex() == 12) {
			String totalRecordStr = row.getCell(1).getValue();
			if (!StringUtils.isEmpty(totalRecordStr) && StringUtils.isNumeric(totalRecordStr)){
				totalRecord = Integer.valueOf(totalRecordStr);
			}
			return;
		}
		
		// 解析總下傳門店數
		if (row.getRowIndex() == 13) {
			String totalStoreStr = row.getCell(1).getValue();
			if (!StringUtils.isEmpty(totalStoreStr) && StringUtils.isNumeric(totalStoreStr)){
				totalStore = Integer.valueOf(totalStoreStr);
			}
			return;
		}

		// 忽略无用的行
		if (row.getRowIndex() <= 15 || (row.getRowIndex() > (16 + this.totalRecord))) {
			return;
		}
		
		if (row.getRowIndex() == 16){
			String storeNoStr = "";
			for (int i = 8 ; i < 8 + totalStore; i++){
				storeNoStr = row.getCell(i).getValue();
				if (!storeNoStr.isEmpty() && StringUtils.isNumeric(storeNoStr)){
					storeMap.put(i, storeNoStr);
				}else {
					overallError = 1;
					overallErrMsg = overallErrMsg + " " + i + "栏的门店有误";
				}
			}
			return;
		}
		

		// 開始解析RP內容
		itemNo = row.getCell(0).getValue();
		// 如果貨號為空, 則忽略該行
		if ("".equals(itemNo)){
			return;
		}
		itemName = row.getCell(1).getValue();
		buyPrice = row.getCell(2).getValue();
		dcSupNo = row.getCell(3).getValue();
		dcSupName = row.getCell(4).getValue();
		ordMultiParm = row.getCell(5).getValue();
		initTotQty = row.getCell(6).getValue();
		initTotAmnt = row.getCell(7).getValue();
		
		LBatchRpItemVO itemVO = null;
		for (int i = 8; i < 8 + this.totalStore ; i++){
			storeQty = row.getCell(i).getValue();
			if (!storeQty.isEmpty()){
				itemVO = new LBatchRpItemVO ();
				itemVO.setItemNo(itemNo);
				itemVO.setItemName(itemName);
				itemVO.setBuyPrice(buyPrice);
				itemVO.setDcSupNo(dcSupNo);
				itemVO.setDcSupName(dcSupName);
				itemVO.setOrdMultiParm(ordMultiParm);
				itemVO.setInitTotQty(initTotQty);
				itemVO.setInitTotAmnt(initTotAmnt);
				itemVO.setStoreNo(storeMap.get(i));
				itemVO.setStoreQty(storeQty);
				itemVO.setRowNum(row.getRowIndex());
				rpList.add(itemVO);
			}
		}
	}

	public static Map<String, Object> processRowExcel(InputStream inputStream)
			throws Exception {
		RPReadExcel rpre = new RPReadExcel(inputStream);
		rpre.processByRow(1);// 处理第一个sheet
		Map<String, Object> returnMap = new HashMap<String, Object>();
		if (rpre.getOverallError() != null && rpre.getOverallError() == 1) {
			returnMap.put("overallErr", rpre.getOverallError());
			returnMap.put("overallErrMsg", rpre.getOverallErrMsg());
		} else if (StringUtils.isEmpty(rpre.getVersion())) {
			returnMap.put("overallErr", 1);
			returnMap.put("overallErrMsg", "模板有误, 请下载最新版本");
		} else {
			returnMap.put("overallErr", 0);
			returnMap.put("rpDm", rpre.getRpDm());
			returnMap.put("rpDmItem", rpre.getRpList());
		}
		return returnMap;
	}

	public static void main(String[] args) throws Exception {
		FileInputStream fis = new FileInputStream("d:/orderTemplate_1000.xlsx");
		Map<String, Object> map = RPReadExcel.processRowExcel(fis);
		System.out.println(map.size());

	}

}
