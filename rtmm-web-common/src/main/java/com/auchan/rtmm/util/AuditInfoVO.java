package com.auchan.rtmm.util;

import java.io.Serializable;
import java.util.Date;

public class AuditInfoVO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String creatBy;
	private Date creatDate;
	private String chngBy;
	private Date chngDate;
	private Integer curRow;
	private Integer totalRow;

	public String getCreatBy() {
		return creatBy;
	}

	public void setCreatBy(String creatBy) {
		this.creatBy = creatBy;
	}

	public Date getCreatDate() {
		return creatDate;
	}

	public void setCreatDate(Date creatDate) {
		this.creatDate = creatDate;
	}

	public String getChngBy() {
		return chngBy;
	}

	public void setChngBy(String chngBy) {
		this.chngBy = chngBy;
	}

	public Date getChngDate() {
		return chngDate;
	}

	public void setChngDate(Date chngDate) {
		this.chngDate = chngDate;
	}

	public Integer getCurRow() {
		return curRow;
	}

	public void setCurRow(Integer curRow) {
		this.curRow = curRow;
	}

	public Integer getTotalRow() {
		return totalRow;
	}

	public void setTotalRow(Integer totalRow) {
		this.totalRow = totalRow;
	}

	public AuditInfoVO(String creatBy, Date creatDate, String chngBy, Date chngDate, Integer curRow, Integer totalRow) {
		super();
		this.creatBy = creatBy;
		this.creatDate = creatDate;
		this.chngBy = chngBy;
		this.chngDate = chngDate;
		this.curRow = curRow;
		this.totalRow = totalRow;
	}

	public AuditInfoVO() {
	}

}