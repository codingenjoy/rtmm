package com.auchan.rtmm.common.common;
/*
 * 定义RTMM系统中各类META的唯一识别名字，为一个字符串。
 * 
 * 重要说明：在业务逻辑上，每一个META项由"GRP + CODE"组合而成，用于唯一表示一项确定的META；
 * 该组合 有多种实现方式，举例如下：
(1)点分表达式。GRP.CODE
(2)下划线分隔表达式。如GRP_CODE
(3)前斜杠分隔表达式。如GRP/CODE。

建议优先选择“前斜杠分隔表达式”。
 */
public final class META_NAME_ALIASES {
	public static final String CL_CATALOG_STATUS = "CL_CATALOG_STATUS";
	public static final String CL_SEC_CTRL_FOOD_NONFOOD = "CL_SEC_CTRL_FOOD_NONFOOD";
	public static final String CL_SEC_CTRL_ORD_DELET_ENBLD_IND = "CL_SEC_CTRL_ORD_DELET_ENBLD_IND";
	public static final String CL_MID_GRP_CTRL_STOCK_CTRL = "CL_MID_GRP_CTRL_STOCK_CTRL";
	public static final String CL_MID_GRP_CTRL_SPECL_GRP_CTRL = "CL_MID_GRP_CTRL_SPECL_GRP_CTRL";
	public static final String CL_SUBGRP_CTRL_CTRL_VAL = "CL_SUBGRP_CTRL_CTRL_VAL";
	
	public static final String COMPANY_STATUS="COMPANY_STATUS";
	public static final String COMPANY_ECON_TYPE="COMPANY_ECON_TYPE";
	
	public static final String STORE_BIZ_TYPE="STORE_BIZ_TYPE";
	public static final String STORE_STATUS="STORE_STATUS";
	public static final String STORE_JOIN_DC_IND="STORE_JOIN_DC_IND";
	public static final String REALSTORE_DISC_STORE_IND="REALSTORE_DISC_STORE_IND";
	
	public static final String ITEM_BASIC_STATUS="ITEM_BASIC_STATUS";
	public static final String UNIT="UNIT";
	public static final String ITEM_BASIC_BUY_METHD="ITEM_BASIC_BUY_METHD";
	public static final String ITEM_BASIC_BUY_WHEN="ITEM_BASIC_BUY_WHEN";
	
	//More meta definitions.
	
	
}
