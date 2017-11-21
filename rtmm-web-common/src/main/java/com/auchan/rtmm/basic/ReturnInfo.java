package com.auchan.rtmm.basic;

import java.io.Serializable;
import java.util.Map;

public class ReturnInfo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public final static int RETURNINFO_CODE_SUCCESS = 1;

	public final static int RETURNINFO_CODE_ERROR = 2;
	
	public final static int RETURNINFO_CODE_NODATA = 3;
	
	public final static int RETURNINFO_CODE_INVALID = 4;
	
	private String trId;
	
	//1 success 2 error 3 nodata 4 invalid
	private int code;
	
	private String msg;
	
	private String entity;
	
	private Map<Object, Object> params;

	public String getTrId() {
		return trId;
	}

	public void setTrId(String trId) {
		this.trId = trId;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getEntity() {
		return entity;
	}

	public void setEntity(String entity) {
		this.entity = entity;
	}

	public Map<Object, Object> getParams() {
		return params;
	}

	public void setParams(Map<Object, Object> params) {
		this.params = params;
	}
	
}
