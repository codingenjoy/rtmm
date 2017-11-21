<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${defaultTitle }</title>
<meta name="keywords" content="${defaultKeyWords }" />
<meta name="description" content="${defaultDescription }" />
<meta name="author" content="${defaultAuthor }" />
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate"/>
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/MyUI.css" rel="Stylesheet" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/Global.css" rel="Stylesheet" />
<script type="text/javascript">
	function selectFirm(){
		var options=$("#selectPageTest option:selected");
		$.post(ctx+"/selectFirm",{pageNoStr:"1",pageSizeStr:options.text()},
		    	function(date){
		    	$("#Menu11").html(date);
		    },
		    "html");
	}
	//单选CheckBox
	function singleCheckbox(cb){
		var check= $("input[name='firmCheckbox']");
		if(cb.checked == false){
			cb.checked == false;
		} else {
			for(var i = 0; i < check.length; i++){
					if(check[i] != cb){
						check[i].checked = false;
					} else {
						check[i].checked = true;
					}
			}
		}
	}
	//实现每页显示多少条数据
/*  	function selectPageTest(){
		var options=$("#selectPageTest option:selected");
		var opt=$("#selectPageTest").option;
		$.post(ctx+"/pageSum",{pageSum:options.text()},
				function(date){
			$("#Menu11").html(date);
		},
		"html");
		for(var i = 0; i < opt.length; i++){
			if(opt[i].equals(${pageSumint })){
				opt[i].selected = true;
			}
		}
	} */
</script>

</head>
<body>
    <jsp:include page="/page/commons/menu.jsp"></jsp:include>
    <jsp:include page="/page/commons/lefthead.jsp"></jsp:include>
    <div id="RightContent_Biggest" class="RightContent FloatLeft">
        <div class="RightContentTools HPAndForty">
            <div id="Search" style="width:35px; height:40px;float:left;" class="Pointer" ><!--class="LightGreenColor"-->
                <span class="RightContentToolIcon FloatLeft MarginLeft10 RightContentTools_span Icon Select" title=""></span>
            </div>
            <span class="RightContentToolIcon2 FloatLeft Icon Line333333 "></span>
            <span class="RightContentToolIcon FloatLeft MarginLeft15 RightContentTools_span Icon Save2"></span>
            <span class="RightContentToolIcon FloatLeft MarginLeft15 RightContentTools_span Icon Printer"></span>
            <span class="RightContentToolIcon FloatLeft MarginLeft15 RightContentTools_span Icon Excel"></span>
            <span class="RightContentToolIcon2 FloatLeft MarginLeft15 Icon Line333333"></span>
            <span class="RightContentToolIcon FloatLeft MarginLeft15 RightContentTools_span Icon SelectRuslt2"></span>
            <span class="RightContentToolIcon FloatLeft MarginLeft15 RightContentTools_span Icon Rubber2"></span>
            <span class="RightContentToolIcon2 FloatLeft MarginLeft15 Icon Line333333"></span>
            <span class="RightContentToolIcon FloatLeft MarginLeft15 RightContentTools_span Icon New"></span>
            <span class="RightContentToolIcon FloatLeft MarginLeft15 RightContentTools_span Icon Delete"></span>
            <span class="RightContentToolIcon FloatLeft MarginLeft15 RightContentTools_span Icon Edit2"></span>
            <span class="RightContentToolIcon2 FloatLeft MarginLeft15 Icon Line333333"></span>
            <span class="RightContentToolIcon FloatLeft MarginLeft15 RightContentTools_span Icon First"></span>
            <span class="RightContentToolIcon FloatLeft MarginLeft15 RightContentTools_span Icon Previous"></span>
            <span class="RightContentToolIcon FloatLeft MarginLeft15 RightContentTools_span Icon Next"></span>
            <span class="RightContentToolIcon FloatLeft MarginLeft15 RightContentTools_span Icon Last"></span>
            <span class="RightContentToolIcon2 FloatLeft MarginLeft15 Icon Line333333"></span>
            <div id="SwitchContent" class="FloatRight" style="height:40px; width:70px;">
                <div id="DetailContent" style="width:35px; height:40px;float:right;" class="Pointer LightGreenColor">
                    <span class="RightContentToolIcon FloatLeft MarginLeft10 RightContentTools_span Icon ChangContent2 ui-widget-content" title="切换到详细信息"></span>
                </div>
                <div  id="ListContent" style="width:35px; height:40px;float:right;" class="Pointer ">
                    <span class="RightContentToolIcon FloatLeft MarginLeft10 RightContentTools_span Icon ChangList ui-widget-content" title="切换到列表"></span>
                </div>
            </div>
        </div>
        
        <div class="HPAndThirty Grey4"><!--RightContentTitle-->
            <div id="Tag1" class="Tags Tag">公司信息</div>
            <!--<div class="Tags Tag">公司信息</div>-->
        </div>

        <div id="Menu1" class="RightContentB DisplayNo"><!--这里的内容会随着变化 分店详细信息2-->
            <div class="RCB_Top">
                <span class="MarginRight10">第&nbsp;1,000,000 / 1,000,000&nbsp;项</span>&nbsp;&nbsp;
                <span class="RightContentToolIcon2 FloatLeft MarginLeft15 MarginRight10 Icon Line333333"></span>
                <span class="RCB_TopSpan">修改人&nbsp;&nbsp;张三</span>
                <span class="RCB_TopSpan">修改日期&nbsp;&nbsp;2013-12-01</span>
                <span class="RCB_TopSpan">建档人&nbsp;&nbsp;张三</span>
                <span class="RCB_TopSpan">创建日期&nbsp;&nbsp;2013-12-01</span>
            </div>

            <div style="width:98%; height:1px; margin:0 auto; background-color:#999999;"></div>

            <div class="RCB_CompanyInfo MarginLeft10">
                <div class="RCB_CompanyInfo1 FloatLeft">
                    <div class="RCB_CompanyInfo1_1">
                        <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
                          <tr>
                              <td>&nbsp;</td><td></td>
                          </tr>
                          <tr>
                            <td class="Column1">公司编号</td>
                            <td class="Column2"><input type="text" class="Width2 Border" value="1"/></td>
                          </tr>
                          <tr>
                            <td class="Column1">公司名称</td>
                            <td class="Column2"><input type="text" class="Width4 Border" value="上海欧尚超市有限公司" /></td>
                          </tr>
                          <tr>
                            <td class="Column1">公司英文名</td>
                            <td class="Column2"><input type="text" class="Width4 Border" /></td>
                          </tr>
                          <tr>
                            <td class="Column1">公司类型</td>
                            <td class="Column2"><input type="text" class="Width2 Border" value="有限公司" />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                状态<input type="text" class="Width2 Border" value="1-正常" />
                            </td>
                          </tr>
                          <tr>
                            <td class="Column1">法人代表</td>
                            <td class="Column2"><input type="text" class="Width2 Border" /></td>
                          </tr>
                          <tr>
                            <td class="Column1">经营范围</td>
                            <td class="Column2"><input type="text" class="Width2 Border" /></td>
                          </tr>
                        <tr>
                            <td class="Column1">成立日期</td>
                            <td class="Column2"><input type="text" class="Width2 Border" value="1999/03/20" /></td>
                          </tr>
                          <tr>
                            <td class="Column1">注册城市</td>
                            <td class="Column2"><input type="text" class="Width2 Border" /><input type="text" class="Width2 Border" value="上海" /></td>

                          </tr>

                          <tr>

                            <td class="Column1">税号</td>

                            <td class="Column2"><input type="text" class="Width4 Border" value="310110607372919" /></td>

                          </tr>

                          <tr>

                            <td class="Column1">公司注册地址</td>

                            <td class="Column2"><input type="text" class="Width2 Border" value="上海市" /><input type="text" class="Width2 Border" value="杨浦区中原路102号" /></td>

                          </tr>

                          <tr>

                            <td class="Column1">电话号码</td>

                            <td class="Column2"><input type="text" class="Width2 Border" value="021-65589988" />&nbsp; 电子邮箱<input type="text" class="Width2 Border" /></td>

                          </tr>

                          <tr>

                            <td class="Column1">网址</td>

                            <td class="Column2"><input type="text" class="Width4 Border" value="http://www..." /></td>

                          </tr>

                          </table>

                    </div>

                    <div class="RCB_CompanyInfo1_2 ">

                        <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">

                          <tr>

                            <td class="Column1">发票送达地址</td>

                            <td class="Column2"><input type="text" class="RCR_Cols2 Border" value="010" />

                                <input type="text" class="RCR_Cols4 Border"  value="上海市"/>

                                <input type="text" class=" Border" style="width:45%;" value="平凉路1398号1号楼813室" />

                            </td>

                          </tr>

                          <tr>

                            <td class="Column1">邮政编码</td>

                            <td class="Column2"><input type="text" class="Width2 Border" value="200090" />&nbsp;&nbsp;&nbsp;&nbsp;

                                <!-- 联系人 --><auchan:i18n id="102006016"/><input type="text" class="Width2 Border" /></td>

                          </tr>

                          <tr>

                            <td class="Column1">电话号码</td>

                            <td class="Column2"><input type="text" class="Width2 Border" value="021-65701967" />

                                移动电话<input type="text" class="Width2 Border" /></td>

                          </tr>

                          <tr>

                            <td class="Column1">传真号码</td>

                            <td class="Column2"><input type="text" class="Width2 Border" /></td>

                          </tr>

                        </table>

                    </div>

                </div>

                <div class="RCB_CompanyInfo1 FloatLeft RCB_CompanyInfo1_3">

                    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">

                        <tr class="BottomLine TextAlginCenter">

                            <td></td>

                            <td></td>

                            <td>证件类型</td>

                            <td>证件号</td>

                            <td>截止日期</td>

                        </tr>

                    </table>

                    <div style="width:96%; height:1px; float:right; background-color:#999999;"></div>

                    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                        <tr>

                            <td style="width:12%"><input type="checkbox" style="float:right" /></td>

                            <td style="width:8%">

                                <div class="CompanLicense2"></div>

                            </td>

                            <td style="width:25%">

                                <select class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:30%">

                                <select  class="CompanLicense1">

                                    <option></option>

                                </select>

                            </td>

                            <td style="width:25%">

                                <div  class="SelectConditonal1" style="width:100%;" >

                                <div class="InputDiv MarginLeft10" style="height:16px;background:#CCCCCC;" >

                                    <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:80%; height:14px;background:#CCCCCC;"/>

                                    <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:1px;"></span>

                                </div>

                                </div>

                            </td>

                        </tr>

                    </table>

                    <div style="width:96%; height:1px; float:right; background-color:#999999;"></div>

                        <table border="0" cellspacing="0" cellpadding="0" style="width:100%">

                            <tr>

                                <td style="width:12%" class="Height1"><input type="checkbox" class="FloatRight"/></td>

                                <td class=" Height1">

                                

                                    <span class="RightContentToolIcon FloatLeft  Icon New MarginTop5 MarginLeft7"></span>

                                    <span class="FloatLeft MarginTop5 MarginLeft7">|</span>

                                    <span class="RightContentToolIcon FloatLeft Icon Delete MarginTop5 MarginLeft7"></span>

                                </td>

                            </tr>

                        </table>

                    </div>

                </div>

            </div>
		<div id="Menu11" class="RightContentA DisplayYes"><!--CompanyInfo 这里的内容会随着变化-->
			<jsp:include page="/page/sort/Menu11Div.jsp"></jsp:include>
	    </div>
        <div id="Menu21" class="RightContentA DisplayNo"><!--这里的内容会随着变化 分店信息1-->

            <div id="SearchDiv_2" class="RightContentLeft FloatLeft Grey5 DisplayNo"><!--search搜索栏-->

                <div class="HPAndThirty">

                    <span style="padding-left:10px;float:left;">查询条件</span>

                    <span class="LeftMenuIcon FloatRight Icon CircleClose MarginRight10" title="关闭"></span>

                </div>

                <div class="MenuLine Icon lineAAAAA"></div>

                <div class="SelectConditonal HPAndThirty">

                    <div class="SelectConditonalText" style="line-height:30px;">公司编号</div>

                    <div class="SelectConditonal1">

                        <input type="text" class="SelectConditonal11" style="width:60%;"/>

                    </div>

                </div>

                <div class="SelectConditonal HPAndThirty">

                    <div class="SelectConditonalText" style="line-height:30px;">公司名称</div>

                    <div  class="SelectConditonal1">

                        <input type="text" class="SelectConditonal11" />

                    </div>

                </div>

                <div class="SelectConditonal HPAndThirty">

                    <div class="SelectConditonalText">公司英文名称</div>

                    <div class="SelectConditonal1">

                        <input type="text" class="SelectConditonal11" />

                    </div>

                </div>

                <div class="SelectConditonal HPAndThirty">

                    <div class="SelectConditonalText" style="line-height:30px;">公司状态</div>

                    <div class="SelectConditonal1">

                        <select>

                            <option>-请选择-</option>

                        </select>

                    </div>

                </div>

                <div class="SelectConditonal HPAndThirty">

                    <div class="SelectConditonalText" style="line-height:30px;">法人代表</div>

                    <div  class="SelectConditonal1">

                        <input type="text" class="SelectConditonal11" style="width:60%;" />

                    </div>

                </div>

                <div class="SelectConditonal HPAndThirty">

                    <div class="SelectConditonalText" style="line-height:30px;">经营范围</div>

                    <div  class="SelectConditonal1">

                        <input type="text" class="SelectConditonal11" />

                    </div>

                </div>

                <div class="SelectConditonal HPAndThirty">

                    <div class="SelectConditonalText" style="line-height:30px;">经营范围</div>

                    <div  class="SelectConditonal1" >

                        <div class="InputDiv MarginLeft10">

                            <input type="text" class="SelectConditonal12 FloatLeft"/>

                            <span class="RightContentToolIcon Icon Catelog FloatRight" style="margin-top:3px; margin-right:5px;"></span>

                        </div>

                    </div>

                </div>

                <div class="SelectConditonal HPAndThirty">

                    <div class="SelectConditonalText" style="line-height:30px;">成立日期</div>

                    <div  class="SelectConditonal1" >

                        <div class="InputDiv MarginLeft10">

                            <input type="text" class="SelectConditonal12 FloatLeft" />

                            <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:3px; margin-right:5px;"></span>

                        </div>

                    </div>

                </div>

                <div class="HPAndThirty">

                    <div class="SelectConditonalText" style="line-height:30px;">注册城市</div>

                    <div  class="SelectConditonal1" >

                        <div class="InputDiv2 MarginLeft10 FloatLeft">

                            <input type="text" class="SelectConditonal15 FloatLeft"/>

                            <span class="RightContentToolIcon Icon Canlendar FloatLeft" style="margin-top:3px; margin-Left:5px;"></span>

                        </div>

                        <input type="text" class="InputDiv3 FloatLeft MarginLeft10"/>

                    </div>

                </div>

                <div class="SelectConditonal HPAndThirty">

                    <div class="SelectConditonalText" style="line-height:30px;">税号</div>

                    <div  class="SelectConditonal1">

                        <input type="text" class="SelectConditonal11" />

                    </div>

                </div>

                <div class="MenuLine Icon lineAAAAA"></div>

                <div class="HPAndForty">

                    <span class="LeftMenuIcon FloatRight Icon Rubber MarginRight10" title="隐藏左侧菜单栏"></span>

                    <span class="LeftMenuIcon FloatRight Icon SelectRuslt MarginRight10" title="隐藏左侧菜单栏"></span>

                </div>

            </div>

            <div id="RightContentRight_2" class="RightContentRight FloatRight">

<!--                <div class="RCR_Left FloatLeft" style="background:#4cff00;display:none;">



                </div>-->

                <div class="RCR_Right FloatLeft">

                    <div class="RCR_Right1 TextAlginCenter" style="border-bottom:1px solid #FFFFFF;">

                        <table border="0" cellspacing="0" cellpadding="0">

                            <tr>

                                <td class="RCR_Cols1"><input type="checkbox" /></td>

                                <td class="RCR_Cols2"><span class="FloatLeft">|</span>分店店号</td>

                                <td class="RCR_Cols2"><span class="FloatLeft">|</span>分店名称</td>

                                <td class="RCR_Cols2"><span class="FloatLeft">|</span>分店状态</td>

                                <td class="RCR_Cols3"><span class="FloatLeft">|</span>分店等级</td>

                                <td class="RCR_Cols4"><span class="FloatLeft">|</span>公司</td>

                                <td class="RCR_Cols2"><span class="FloatLeft">|</span>分店业态</td>

                                <td class="RCR_Cols5"><span class="FloatLeft">|</span>区域/城市</td>

                            </tr>

                        </table>

                    </div>

                    <div class="RCR_Right2" style="border-bottom:1px solid #999999;">

                        <table border="0" cellspacing="0" cellpadding="0">

                            <tr class="Grey1">

                                <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox"  class="DisplayNo" /></td>

                                <td class="RCR_Cols2 TextAlginRight">0&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;HO-总公司</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;1</td><!--9. 删除-->

                                <td class="RCR_Cols3 TextAlginLeft">&nbsp;&nbsp;</td><!--营业额&nbsp;&nbsp;等级1-->

                                <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;&nbsp;欧尚(中国)投资有限公司</td><!--大润发流通事业股份有限公司-->

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--配送中心-->

                                <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--华东-->

                            </tr>

                            <tr>

                                <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox"  class="DisplayNo" /></td>

                                <td class="RCR_Cols2 TextAlginRight">96&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;D96-ATLIA</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;1</td><!--9. 删除-->

                                <td class="RCR_Cols3 TextAlginLeft">&nbsp;&nbsp;</td><!--营业额&nbsp;&nbsp;等级1-->

                                <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;&nbsp;欧尚(中国)投资有限公司</td><!--大润发流通事业股份有限公司-->

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;弗玛物流</td><!--配送中心-->

                                <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--华东-->

                            </tr>

                            <tr class="Grey1">

                                <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox"  class="DisplayNo" /></td>

                                <td class="RCR_Cols2 TextAlginRight">102&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;YP1-中原店</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;1</td><!--9. 删除-->

                                <td class="RCR_Cols3 TextAlginLeft">&nbsp;2</td><!--营业额&nbsp;&nbsp;等级1-->

                                <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;&nbsp;上海欧尚超市有限公司</td><!--大润发流通事业股份有限公司-->

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--配送中心-->

                                <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--华东-->

                            </tr>

                            <tr>

                                <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox"  class="DisplayNo" /></td>

                                <td class="RCR_Cols2 TextAlginRight">103&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;YP2-长阳店</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;1</td><!--9. 删除-->

                                <td class="RCR_Cols3 TextAlginLeft">&nbsp;2</td><!--营业额&nbsp;&nbsp;等级1-->

                                <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;&nbsp;上海欧尚超市有限公司</td><!--大润发流通事业股份有限公司-->

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--配送中心-->

                                <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--华东-->

                            </tr>

                            <tr class="Grey1">

                                <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox"  class="DisplayNo" /></td>

                                <td class="RCR_Cols2 TextAlginRight">104&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;SZ1-苏州1&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;1</td><!--9. 删除-->

                                <td class="RCR_Cols3 TextAlginLeft">&nbsp;1</td><!--营业额&nbsp;&nbsp;等级1-->

                                <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;&nbsp;苏州欧尚超市有限公司</td><!--大润发流通事业股份有限公司-->

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--配送中心-->

                                <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--华东-->

                            </tr>

                            <tr>

                                <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox"  class="DisplayNo" /></td>

                                <td class="RCR_Cols2 TextAlginRight">105&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;WX1-无锡1&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;1</td><!--9. 删除-->

                                <td class="RCR_Cols3 TextAlginLeft">&nbsp;3</td><!--营业额&nbsp;&nbsp;等级1-->

                                <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;&nbsp;杭州欧尚超市有限公司</td><!--大润发流通事业股份有限公司-->

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--配送中心-->

                                <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--华东-->

                            </tr>

                            <tr class="Grey1">

                                <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox"  class="DisplayNo" /></td>

                                <td class="RCR_Cols2 TextAlginRight">106&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;HZ1-杭州1</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;1</td><!--9. 删除-->

                                <td class="RCR_Cols3 TextAlginLeft">&nbsp;3</td><!--营业额&nbsp;&nbsp;等级1-->

                                <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;&nbsp;上海欧尚超市有限公司</td><!--大润发流通事业股份有限公司-->

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--配送中心-->

                                <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--华东-->

                            </tr>

                            <tr>

                                <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox"  class="DisplayNo" /></td>

                                <td class="RCR_Cols2 TextAlginRight">107&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;MH1-闵行1&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;1</td><!--9. 删除-->

                                <td class="RCR_Cols3 TextAlginLeft">&nbsp;3</td><!--营业额&nbsp;&nbsp;等级1-->

                                <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;&nbsp;上海新欧尚超市有限公司</td><!--大润发流通事业股份有限公司-->

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--配送中心-->

                                <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--华东-->

                            </tr>

                            <tr class="Grey1">

                                <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox"  class="DisplayNo" /></td>

                                <td class="RCR_Cols2 TextAlginRight">108&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;JD1-嘉定1</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;1</td><!--9. 删除-->

                                <td class="RCR_Cols3 TextAlginLeft">&nbsp;3</td><!--营业额&nbsp;&nbsp;等级1-->

                                <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;&nbsp;南京欧尚超市有限公司</td><!--大润发流通事业股份有限公司-->

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--配送中心-->

                                <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--华东-->

                            </tr>

                            <tr>

                                <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox"  class="DisplayNo" /></td>

                                <td class="RCR_Cols2 TextAlginRight">109&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;NJ1-南京1</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;1</td><!--9. 删除-->

                                <td class="RCR_Cols3 TextAlginLeft">&nbsp;&nbsp;5</td><!--营业额&nbsp;&nbsp;等级1-->

                                <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;&nbsp;宁波欧尚超市有限公司</td><!--大润发流通事业股份有限公司-->

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--配送中心-->

                                <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--华东-->

                            </tr>

                            <tr class="Grey1">

                                <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox"  class="DisplayNo" /></td>

                                <td class="RCR_Cols2 TextAlginRight">110&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;NB1-宁波1&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;1</td><!--9. 删除-->

                                <td class="RCR_Cols3 TextAlginLeft">&nbsp;&nbsp;3</td><!--营业额&nbsp;&nbsp;等级1-->

                                <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;&nbsp;宁波欧尚超市有限公司江东店</td><!--大润发流通事业股份有限公司-->

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--配送中心-->

                                <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--华东-->

                            </tr>

                            <tr>

                                <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox"  class="DisplayNo" /></td>

                                <td class="RCR_Cols2 TextAlginRight">111&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;NB2-宁波2&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;1</td><!--9. 删除-->

                                <td class="RCR_Cols3 TextAlginLeft">&nbsp;&nbsp;3</td><!--营业额&nbsp;&nbsp;等级1-->

                                <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;&nbsp;宁波欧尚超市有限公司江东店</td><!--大润发流通事业股份有限公司-->

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--配送中心-->

                                <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--华东-->

                            </tr>

                            <tr class="Grey1">

                                <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox"  class="DisplayNo" /></td>

                                <td class="RCR_Cols2 TextAlginRight">112&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;CS1-常熟1</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;1</td><!--9. 删除-->

                                <td class="RCR_Cols3 TextAlginLeft">&nbsp;&nbsp;4</td><!--营业额&nbsp;&nbsp;等级1-->

                                <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;&nbsp;苏州欧尚超市有限公司常熟黄河店</td><!--大润发流通事业股份有限公司-->

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--配送中心-->

                                <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--华东-->

                            </tr>

                            <tr>

                                <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox"  class="DisplayNo" /></td>

                                <td class="RCR_Cols2 TextAlginRight">113&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;CZ1-常州1&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;1</td><!--9. 删除-->

                                <td class="RCR_Cols3 TextAlginLeft">&nbsp;&nbsp;5</td><!--营业额&nbsp;&nbsp;等级1-->

                                <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;&nbsp;常州欧尚超市有限公司</td><!--大润发流通事业股份有限公司-->

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--配送中心-->

                                <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--华东-->

                            </tr>

                            <tr>

                                <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox"  class="DisplayNo" /></td>

                                <td class="RCR_Cols2 TextAlginRight">114&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;ZS1-舟山1&nbsp;</td>

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;1</td><!--9. 删除-->

                                <td class="RCR_Cols3 TextAlginLeft">&nbsp;&nbsp;4</td><!--营业额&nbsp;&nbsp;等级1-->

                                <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;&nbsp;宁波欧尚超市有限公司舟山店</td><!--大润发流通事业股份有限公司-->

                                <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--配送中心-->

                                <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--华东-->

                            </tr>

                        </table>

                    </div>

                    <!--<div style="width:99.5%; height:1px; margin:0 auto; background-color:#999999;"></div>-->

                    <div class=" HPAndThirty"><!--RCR_PageNum-->

                        <div class="RCR_PageNum1 FloatLeft">

                            第<span>1-15</span>项,共<span>145</span>项&nbsp;|&nbsp ;每页显示

                            <select class="Border" style="width:50px;">

                                <option>50</option>

                                <option>45</option>

                                <option>40</option>

                                <option>35</option>

                                <option>30</option>

                                <option>25</option>

                                <option>20</option>

                                <option>15</option>

                                <option>10</option>

                            </select>

                            项

                        </div>

                        <div class="RCR_PageNum2 FloatRight">

                            

                            <span class="FloatRight MarginRight20">&nbsp;页</span>

                            <input type="text" class="FloatRight Border" style="width:30px; height:15px;" />

                            <span class="FloatRight">&nbsp;&nbsp;跳转至&nbsp;</span>

                            <div class="FloatRight Icon Last"></div>

                            <div class="FloatRight Icon Next"></div>

                            <div class="FloatRight TextAlginCenter">20</div>

                            <div class="FloatRight TextAlginCenter">...</div>

                            <div class="FloatRight TextAlginCenter">5</div>

                            <div class="FloatRight TextAlginCenter">4</div>

                            <div class="FloatRight TextAlginCenter">3</div>

                            <div class="FloatRight TextAlginCenter">2</div>

                            <div class="FloatRight TextAlginCenter GreencColor">1</div>

                            <div class="FloatRight Icon Privious2"></div>

                            <div class="FloatRight Icon First2"></div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

        <div id="Menu2" class="RightContentB DisplayNo"><!--这里的内容会随着变化 分店详细信息2-->

            <div class="RCB_Top">

                <span class="MarginRight10">第&nbsp;1,000,000 / 1,000,000&nbsp;项</span>&nbsp;&nbsp;

                <span class="RightContentToolIcon2 FloatLeft MarginLeft15 MarginRight10 Icon Line333333"></span>

                <span class="RCB_TopSpan">修改人&nbsp;&nbsp;张三</span>

                <span class="RCB_TopSpan">修改日期&nbsp;&nbsp;2013-12-01</span>

                <span class="RCB_TopSpan">建档人&nbsp;&nbsp;张三</span>

                <span class="RCB_TopSpan">创建日期&nbsp;&nbsp;2013-12-01</span>

            </div>

            <div style="width:98%; height:1px; margin:0 auto; background-color:#999999;"></div>

            <div class="RCB_Content1 MarginLeft10 Grey1">

                <table border="0" cellspacing="0" cellpadding="0">

                  <tr>

                    <td class="Column1">分店店号</td>

                    <td class="Column2"><input type="text" class="Width2 Border" value="103" /></td>

                  </tr>

                  <tr>

                    <td class="Column1">分店名称</td>

                    <td class="Column2"><input type="text" class="Width4 Border" value="YP2-长阳店" /></td>

                  </tr>

                  <tr>

                    <td class="Column1">分店状态</td>

                    <td class="Column2">

                        <select class="Width2 Border">

                            <option>1-正常 </option>

                            <option>5-装修 </option>

                            <option>9-关店 </option>

                        </select>

                    </td>

                  </tr>

                  <tr>

                    <td class="Column1">分店业态</td>

                    <td class="Column2">

                        <select  class="Width1 Border FloatLeft">

                            <option>大卖场</option>

                            <option>精品店 </option>

                            <option>B2C </option>

                            <option>加工中心 </option>

                            <option>物流中心 </option>

                        </select>

                        <span class="FloatLeft">*全面折扣店</span>

                        <select class="Width0 FloatLeft Border">

                            <option>是</option>

                            <option>否</option>

                        </select>

                        <span class="FloatLeft">*加入物流</span>

                        <select class="Width0 FloatLeft Border">

                            <option>是</option>

                            <option>否</option>

                        </select>



                    </td>

                  </tr>

                  <tr>

                    <td class="Column1">分店等级</td>

                    <td class="Column2">

                        <span class="MarginLeft10 FloatLeft">营业额</span>

                        <input type="text"  value="2" style="width:5%;" class="FloatLeft Grey4"/>

                        <input type="text" class="Width0 FloatLeft Border Grey4" value="5亿--10亿"/>

                        <span class="MarginLeft10 FloatLeft">面积</span>

                        <select class="FloatLeft Width2 Border">

                            <option>-请选择-</option>

                        </select>

                    </td>

                  </tr>

                  <tr>

                    <td class="Column1">开业时间</td>

                    <td class="Column2">

                        <div  class="SelectConditonal1" style="width:40%" >

                            <div class="InputDiv MarginLeft10">

                                <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:87%;" value="2001/9/2"/>

                                <span class="RightContentToolIcon Icon Catelog FloatRight" style="margin-top:3px; margin-right:5px;"></span>

                            </div>

                        </div>

                    </td>

                  </tr>

                  <tr>

                    <td class="Column1">公司</td>

                    <td class="Column2">

                        <div  class="SelectConditonal1" style="width:75%" >

                            <div class="InputDiv2 MarginLeft10 FloatLeft Width2">

                                <input type="text" class="SelectConditonal15 FloatLeft" style="margin-left:0px;width:50%;" value="129"/>

                                <span class="RightContentToolIcon Icon Canlendar FloatLeft" style="margin-top:3px; margin-Left:5px;"></span>

                            </div>

                            <input type="text" class="InputDiv3 FloatLeft MarginLeft10" style="width:50%" value="上海欧尚超市有限公司"/>

                        </div>

                    </td>

                  </tr>

                </table>

                <table border="0" cellspacing="0" cellpadding="0" width="50%">

                  <tr>

                    <td class="Column1">营业时间</td>

                    <td class="Column2">

                        <select class="Width0 FloatLeft Border">

                            <option>08</option>

                        </select>

                        <span class="MarginLeft10 FloatLeft">:</span>

                        <select class="Width0 FloatLeft Border">

                            <option>00</option>

                        </select>

                        <span class="MarginLeft10 FloatLeft">-</span>

                        <select class="Width0 FloatLeft Border">

                            <option>22</option>

                        </select>

                        <span class="MarginLeft10 FloatLeft">:</span>

                        <select class="Width0 FloatLeft Border">

                            <option>00</option>

                        </select>

                    </td>

                  </tr>

                  <tr>

                    <td class="Column1">分店地址</td>

                    <td class="Column2"><input type="text" class="Width4 Border" value="上海杨浦区长阳路 1750 号" /></td>

                  </tr>

                  <tr>

                    <td class="Column1">邮编</td>

                    <td class="Column2"><input type="text" class="Width3 Border" value="200090" /></td>

                  </tr>

                  <tr>

                    <td class="Column1">电话号码</td>

                    <td class="Column2"><input type="text" class="Width3 Border" value="021-65399039" /></td>

                  </tr>

                  <tr>

                    <td class="Column1">传真号码</td>

                    <td class="Column2"><input type="text" class="Width3 Border" value="021-65730205" /></td>

                  </tr>

                  <tr>

                    <td class="Column1">区域/城市</td>

                    <td class="Column2">

                        <div  class="SelectConditonal1" style="width:62%;" >

                            <div class="InputDiv MarginLeft10">

                                <input type="text" class="SelectConditonal12 FloatLeft" style="margin-left:0px;width:83%;"/>

                                <span class="RightContentToolIcon Icon Catelog FloatRight" style="margin-top:3px; margin-right:5px;"></span>

                            </div>

                        </div>

                    </td>

                  </tr>

                  <tr>

                    <td class="Column1">&nbsp;</td>

                    <td class="Column2">&nbsp;</td>

                  </tr>

                </table>

            </div>

            <div class="RCB_Content2 MarginLeft10">

                <div class="RCB_Content2Left FloatLeft">

                    <div class="RCB_Content2_1 Grey1">

                        <table border="0" cellspacing="0" cellpadding="0">

                          <tr>

                            <td class="Height1">&nbsp;</td>

                            <td class="Height1">&nbsp;</td>

                          </tr>

                          <tr>

                            <td class="Column1">加入NR日期</td>

                            <td class="Column2">

                                <div  class="SelectConditonal1" style="width:63%">

                                    <div class="InputDiv MarginLeft10">

                                        <input type="text" class="SelectConditonal12 FloatLeft" style="width:70%;height:15px; margin-left:0px;"/>

                                        <span class="RightContentToolIcon Icon Catelog FloatRight" style="margin-top:2px; margin-right:5px;"></span>

                                    </div>

                                </div>

                            </td>

                          </tr>

                          <tr>

                            <td class="Column1">传真号码</td>

                            <td class="Column2"><input type="text" class="Width3 Border" value="021-65730205" /></td>

                          </tr>

                        </table>

                    </div>

                    <div class="RCB_Content2_2 Grey1">

                        <table border="0" cellspacing="0" cellpadding="0">

                          <tr>

                            <td class="Height1">&nbsp;</td>

                            <td class="Height1">&nbsp;</td>

                          </tr>

                            <tr>

                            <td class="Column1">传真号码</td>

                            <td class="Column2"><input type="text" class="Width3 Border" value="021-65730205" /></td>

                          </tr>

                          <tr>

                            <td class="Column1">公司注册地址</td>

                            <td class="Column2"><input type="text" class="Width4 Border" /></td>

                          </tr>

                          <tr>

                            <td class="Column1">发票抬头</td>

                            <td class="Column2"><input type="text" class="Width4 Border" value="上海欧尚超市有限公司" /></td>

                          </tr>

                          <tr>

                            <td class="Column1">发票送达地址</td>

                            <td class="Column2"><input type="text" class="Width0 Border" /><input type="text" class="Width3 Border" /></td>

                          </tr>

                          <tr>

                            <td class="Column1">开户行名称</td>

                            <td class="Column2"><input type="text" class="Width4 Border" value="中行市东支行" /></td>

                          </tr>

                          <tr>

                            <td class="Column1">银行账户</td>

                            <td class="Column2"><input type="text" class="Width3 Border" value="044159-018252094884"/></td>

                          </tr>

                        </table>

                    </div>

                </div>

                <div class="RCB_Content2Right FloatLeft Grey1">

                    <table border="0" cellspacing="0" cellpadding="0">

                        <tr>

                            <td class="Col1">&nbsp;</td>

                            <td class="Col2">*仓库编号&nbsp;&nbsp;</td>

                            <td class="Col3">*地址&nbsp;&nbsp;</td>

                            <td class="Col2" style="text-align:left;">邮编&nbsp;&nbsp;</td>

                            <td class="Col5" style="text-align:left;">电话号码&nbsp;&nbsp;</td>

                            <td class="Col5" style="text-align:left;">传真号码&nbsp;&nbsp;</td>

                        </tr>

                    </table>

                    <div style="width:90%; height:1px; margin:0 auto; background-color:#999999;"></div>

                    <div style="height:240px;width:98%;overflow:scroll;overflow-x:hidden;">

                    <table border="0" cellspacing="0" cellpadding="0">

                        <tr>

                            <td class="Col1"><input type="checkbox" name="warehouseCheck"  class="RCB_Content2RightInput RCB_Content2RightFirstInput"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" value="103"  style=" line-height:20px;" /></td>

                            <td class="Col3"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" title="Address" value="上海市嘉定区安智路281号" style=" line-height:20px;" /></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                        </tr>

                        <tr>

                            <td class="Col1"><input type="checkbox" name="warehouseCheck" class="RCB_Content2RightInput RCB_Content2RightFirstInput"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col3"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" title="Address"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                        </tr>

                        <tr>

                            <td class="Col1"><input type="checkbox" name="warehouseCheck" class="RCB_Content2RightInput RCB_Content2RightFirstInput"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col3"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border"  title="Address"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                        </tr>

                        <tr>

                            <td class="Col1"><input type="checkbox" name="warehouseCheck" class="RCB_Content2RightInput RCB_Content2RightFirstInput"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col3"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border"  title="Address"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                        </tr>

                        <tr>

                            <td class="Col1"><input type="checkbox" name="warehouseCheck" class="RCB_Content2RightInput RCB_Content2RightFirstInput"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col3"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border"  title="Address"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                        </tr>

                        <tr>

                            <td class="Col1"><input type="checkbox" name="warehouseCheck" class="RCB_Content2RightInput RCB_Content2RightFirstInput"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col3"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border"  title="Address"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                        </tr>

                        <tr>

                            <td class="Col1"><input type="checkbox" name="warehouseCheck" class="RCB_Content2RightInput RCB_Content2RightFirstInput"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col3"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border"  title="Address"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                        </tr>

                        <tr>

                            <td class="Col1"><input type="checkbox" name="warehouseCheck" class="RCB_Content2RightInput RCB_Content2RightFirstInput"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col3"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border"  title="Address"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                        </tr>

                        <tr>

                            <td class="Col1"><input type="checkbox" name="warehouseCheck" class="RCB_Content2RightInput RCB_Content2RightFirstInput"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col3"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border"  title="Address"/></td>

                            <td class="Col2"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                            <td class="Col5"><input type="text" name="warehouseCheck" class="RCB_Content2RightInput Border" /></td>

                        </tr>

                    </table>

                    </div>

                    <div style="width:90%; height:1px; margin:0 auto; background-color:#999999;"></div>

                    <table border="0" cellspacing="0" cellpadding="0">

                        <tr>

                            <td class="Col1 Height1"><input type="checkbox" class="RCB_Content2RightFirstInput" name="warehouseCheck"/></td>

                            <td class="Col7 Height1">

                                

                                <span class="RightContentToolIcon FloatLeft  Icon New MarginTop5 MarginLeft7"></span>

                                <span class="FloatLeft MarginTop5 MarginLeft7">|</span>

                                <span class="RightContentToolIcon FloatLeft Icon Delete MarginTop5 MarginLeft7"></span>

                            </td>

                        </tr>

                    </table>

                </div>

            </div>

        </div>
dddd
        <div id="Menu3" class="RightContentC DisplayNo"><!--处课信息-->

            <div class="CLeft FloatLeft">

                <div class="HPAndThirty">

                    <span style="padding-left:10px;float:left;margin-top:5px;">查询条件</span>

                    <span class="LeftMenuIcon FloatRight Icon New MarginTop5" title="关闭"></span>

                </div>

                <div>

                    <table border="0" cellspacing="0" cellpadding="0" style="width:97%;margin-left:10px;">

                        <tr class="Grey2">

                            <td class="CTableTd1 TextAlginCenter"><input type="checkbox" class="DisplayNo"/></td>

                            <td class="CTableTd1 TextAlginCenter"><span class="FloatLeft">|</span>处别</td>

                            <td class="CTableTd2 TextAlginCenter"><span class="FloatLeft">|</span>中文名称</td>

                            <td class="CTableTd3 TextAlginCenter"><span class="FloatLeft">|</span>英文名称</td>

                        </tr>

                        <tr class="Grey1">

                            <td class="CTableTd1 TextAlginCenter"><input type="checkbox" class="DisplayNo"/></td>

                            <td class="CTableTd1 TextAlginRight">1</td>

                            <td class="CTableTd2">&nbsp;纺织品</td>

                            <td class="CTableTd3">&nbsp;&nbsp;TEXITLE</td>

                        </tr>

                        <tr>

                            <td class="CTableTd1 TextAlginCenter"><input type="checkbox" class="DisplayNo"/></td>

                            <td class="CTableTd1 TextAlginRight">2</td>

                            <td class="CTableTd2">&nbsp;家电</td>

                            <td class="CTableTd3">&nbsp;&nbsp;TECHNICAL</td>

                        </tr>

                        <tr class="Grey1">

                            <td class="CTableTd1 TextAlginCenter"><input type="checkbox" class="DisplayNo"/></td>

                            <td class="CTableTd1 TextAlginRight">3</td>

                            <td class="CTableTd2">&nbsp;家用百货</td>

                            <td class="CTableTd3">&nbsp;&nbsp;BAZAAR</td>

                        </tr>

                        <tr>

                            <td class="CTableTd1 TextAlginCenter"><input type="checkbox" class="DisplayNo"/></td>

                            <td class="CTableTd1 TextAlginRight">4</td>

                            <td class="CTableTd2">&nbsp;大众消费品</td>

                            <td class="CTableTd3">&nbsp;&nbsp;MCP</td>

                        </tr>

                        <tr class="GreencColor White">

                            <td class="CTableTd1 TextAlginCenter"><input type="checkbox" checked="checked"/></td>

                            <td class="CTableTd1 TextAlginRight">5</td>

                            <td class="CTableTd2">&nbsp;生鲜</td>

                            <td class="CTableTd3">&nbsp;&nbsp;FRESH PRODUCT</td>

                        </tr>

                        <tr>

                            <td class="CTableTd1 TextAlginCenter"><input type="checkbox" class="DisplayNo"/></td>

                            <td class="CTableTd1 TextAlginRight">6</td>

                            <td class="CTableTd2">&nbsp;服务处</td>

                            <td class="CTableTd3">&nbsp;&nbsp;SERVICE</td>

                        </tr>

                        <tr class="Grey1">

                            <td class="CTableTd1 TextAlginCenter"><input type="checkbox" class="DisplayNo"/></td>

                            <td class="CTableTd1 TextAlginRight">9</td>

                            <td class="CTableTd2">&nbsp;未知商品</td>

                            <td class="CTableTd3">&nbsp;&nbsp;UNKNOWN ITEMS</td>

                        </tr>

                    </table>

                </div>

            </div>

            <div class="CMiddle FloatLeft"></div>

            <div class="CRight FloatLeft">

                <table border="0" cellspacing="0" cellpadding="0" style="width:98%" class="BottomLine">

                    <tr class="Grey2">

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginCenter"><span class="FloatLeft">|</span>课别</td>

                        <td class="RCR_Cols3_D TextAlginCenter"><span class="FloatLeft">|</span>中文名称</td>

                        <td class="RCR_Cols4 TextAlginCenter"><span class="FloatLeft">|</span>英文名称</td>

                        <td class="Width0 TextAlginCenter"><span class="FloatLeft">|</span>食品/非食品</td>

                        <td class="Width0 TextAlginCenter"><span class="FloatLeft">|</span>订单删除</td>

                        <td class="RCR_Cols5_D TextAlginCenter"><span class="FloatLeft">|</span>状态</td>

                    </tr>

                    <tr class="Grey1">

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginRight">125&nbsp;</td>

                        <td class="RCR_Cols3_D">&nbsp;乳制品</td>

                        <td class="RCR_Cols4">DAIRY</td>

                        <td class="Width0">&nbsp;食品</td>

                        <td class="Width0">&nbsp;0-可</td>

                        <td class="RCR_Cols5_D">1-正常</td>

                    </tr>

                    <tr>

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginRight">128&nbsp;</td>

                        <td class="RCR_Cols3_D">&nbsp;面包和面粉制点心</td>

                        <td class="RCR_Cols4">BKY</td>

                        <td class="Width0">&nbsp;食品</td>

                        <td class="Width0">&nbsp;1-不可</td>

                        <td class="RCR_Cols5_D">1-正常</td>

                    </tr>

                    <tr class="Grey1">

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginRight">129&nbsp;</td>

                        <td class="RCR_Cols3_D">&nbsp;品牌面包</td>

                        <td class="RCR_Cols4">Trade bakery & Pastry</td>

                        <td class="Width0">&nbsp;食品</td>

                        <td class="Width0">&nbsp;0-可</td>

                        <td class="RCR_Cols5_D">9-删除</td>

                    </tr>

                    <tr>

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginRight">177&nbsp;</td>

                        <td class="RCR_Cols3_D">&nbsp;自助熟食</td>

                        <td class="RCR_Cols4">COLD-CUTS</td>

                        <td class="Width0">&nbsp;食品</td>

                        <td class="Width0">&nbsp;0-可</td>

                        <td class="RCR_Cols5_D">1-正常</td>

                    </tr>

                    <tr class="Grey1">

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginRight">178&nbsp;</td>

                        <td class="RCR_Cols3_D">&nbsp;熟食站</td>

                        <td class="RCR_Cols4">DELICATESN STAND</td>

                        <td class="Width0">&nbsp;食品</td>

                        <td class="Width0">&nbsp;0-可</td>

                        <td class="RCR_Cols5_D">1-正常</td>

                    </tr>

                    <tr>

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginRight">179&nbsp;</td>

                        <td class="RCR_Cols3_D">&nbsp;点心</td>

                        <td class="RCR_Cols4">DIM SUM</td>

                        <td class="Width0">&nbsp;食品</td>

                        <td class="Width0">&nbsp;0-可</td>

                        <td class="RCR_Cols5_D">1-正常</td>

                    </tr>

                    <tr>

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginRight">181&nbsp;</td>

                        <td class="RCR_Cols3_D">&nbsp;肉制品</td>

                        <td class="RCR_Cols4">BUTCHERY</td>

                        <td class="Width0">&nbsp;食品</td>

                        <td class="Width0">&nbsp;0-可</td>

                        <td class="RCR_Cols5_D">1-正常</td>

                    </tr>

                    <tr class="Grey1">

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginRight">184&nbsp;</td>

                        <td class="RCR_Cols3_D">&nbsp;鱼类</td>

                        <td class="RCR_Cols4">FISH</td>

                        <td class="Width0">&nbsp;食品</td>

                        <td class="Width0">&nbsp;0-可</td>

                        <td class="RCR_Cols5_D">1-正常</td>

                    </tr>

                    <tr>

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginRight">185&nbsp;</td>

                        <td class="RCR_Cols3_D">&nbsp;冷冻食品</td>

                        <td class="RCR_Cols4">FROZEN FOODS</td>

                        <td class="Width0">&nbsp;食品</td>

                        <td class="Width0">&nbsp;0-可</td>

                        <td class="RCR_Cols5_D">1-正常</td>

                    </tr>

                    <tr>

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginRight">177&nbsp;</td>

                        <td class="RCR_Cols3_D">&nbsp;自助熟食</td>

                        <td class="RCR_Cols4">COLD-CUTS</td>

                        <td class="Width0">&nbsp;食品</td>

                        <td class="Width0">&nbsp;0-可</td>

                        <td class="RCR_Cols5_D">1-正常</td>

                    </tr>

                    <tr class="Grey1">

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginRight">178&nbsp;</td>

                        <td class="RCR_Cols3_D">&nbsp;熟食站</td>

                        <td class="RCR_Cols4">DELICATESN STAND</td>

                        <td class="Width0">&nbsp;食品</td>

                        <td class="Width0">&nbsp;0-可</td>

                        <td class="RCR_Cols5_D">1-正常</td>

                    </tr>

                    <tr>

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginRight">179&nbsp;</td>

                        <td class="RCR_Cols3_D">&nbsp;点心</td>

                        <td class="RCR_Cols4">DIM SUM</td>

                        <td class="Width0">&nbsp;食品</td>

                        <td class="Width0">&nbsp;0-可</td>

                        <td class="RCR_Cols5_D">1-正常</td>

                    </tr>

                    <tr>

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginRight">177&nbsp;</td>

                        <td class="RCR_Cols3_D">&nbsp;自助熟食</td>

                        <td class="RCR_Cols4">COLD-CUTS</td>

                        <td class="Width0">&nbsp;食品</td>

                        <td class="Width0">&nbsp;0-可</td>

                        <td class="RCR_Cols5_D">1-正常</td>

                    </tr>

                    <tr class="Grey1">

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginRight">178&nbsp;</td>

                        <td class="RCR_Cols3_D">&nbsp;熟食站</td>

                        <td class="RCR_Cols4">DELICATESN STAND</td>

                        <td class="Width0">&nbsp;食品</td>

                        <td class="Width0">&nbsp;0-可</td>

                        <td class="RCR_Cols5_D">1-正常</td>

                    </tr>

                    <tr>

                        <td class ="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                        <td class="RCR_Cols5_D TextAlginRight">905&nbsp;</td>

                        <td class="RCR_Cols3_D">&nbsp;生鲜处无名商品</td>

                        <td class="RCR_Cols4">FP Unknown Items</td>

                        <td class="Width0">&nbsp;食品</td>

                        <td class="Width0">&nbsp;0-可</td>

                        <td class="RCR_Cols5_D">1-正常</td>

                    </tr>

                </table>

                     <div class=" HPAndThirty" ><!--RCR_PageNum-->

                        <div class="RCR_PageNum1 FloatLeft">

                            第<span>1-15</span>项,共<span>145</span>项&nbsp;|&nbsp ;每页显示

                            <select class="Border" style="width:50px;">

                                <option>50</option>

                                <option>45</option>

                                <option>40</option>

                                <option>35</option>

                                <option>30</option>

                                <option>25</option>

                                <option>20</option>

                                <option>15</option>

                                <option>10</option>

                            </select>

                            项

                        </div>

                        <div class="RCR_PageNum2 FloatRight">

                            

                            <span class="FloatRight MarginRight20">&nbsp;页</span>

                            <input type="text" class="FloatRight Border" style="width:30px; height:15px;" />

                            <span class="FloatRight">&nbsp;&nbsp;跳转至&nbsp;</span>

                            <div class="FloatRight Icon Last"></div>

                            <div class="FloatRight Icon Next"></div>

                            <div class="FloatRight TextAlginCenter">20</div>

                            <div class="FloatRight TextAlginCenter">...</div>

                            <div class="FloatRight TextAlginCenter">5</div>

                            <div class="FloatRight TextAlginCenter">4</div>

                            <div class="FloatRight TextAlginCenter">3</div>

                            <div class="FloatRight TextAlginCenter">2</div>

                            <div class="FloatRight TextAlginCenter GreencColor">1</div>

                            <div class="FloatRight Icon Privious2"></div>

                            <div class="FloatRight Icon First2"></div>

                        </div>

                    </div>

            </div>

        </div>
dddd
        <div id="Menu5" class="RightContentD DisplayNo"><!--大小类型信息，大类型，默认为此页，这里的内容会随着变化-->

            <div id="SearchDiv_5" class="RightContentLeft FloatLeft Grey5 DisplayNo">

                <div class="HPAndThirty">

                    <span style="padding-left:10px;float:left;">查询条件</span>

                    <span class="LeftMenuIcon FloatRight Icon CircleClose MarginRight10" title="关闭"></span>

                </div>

                <div class="MenuLine Icon lineAAAAA"></div>

                <div class="RightContentLeft3">

                    <div class="SelectConditonalText" style="line-height:30px;">大分类</div>

                    <div  class="SelectConditonal1" >

                        <div class="InputDiv2 MarginLeft10 FloatLeft">

                            <input type="text" class="SelectConditonal15 FloatLeft"/>

                            <span class="RightContentToolIcon Icon Catelog FloatLeft" style="margin-top:3px; margin-Left:5px;"></span>

                        </div>

                        <input type="text" class="InputDiv4 FloatLeft MarginLeft10 "/>

                    </div>

                    <div class="SelectConditonalText" style="line-height:30px;">状态</div>

                    <div  class="SelectConditonal1" >

                        <div class="InputDiv2 MarginLeft10 FloatLeft">

                            <input type="text" class="SelectConditonal15 FloatLeft"/>

                            <span class="RightContentToolIcon Icon Catelog FloatLeft" style="margin-top:3px; margin-Left:5px;"></span>

                        </div>

                        <input type="text" class="InputDiv4 FloatLeft MarginLeft10 "/>

                    </div>

                    <div class="SelectConditonalText" style="line-height:30px;">处别</div>

                    <div  class="SelectConditonal1" >

                        <div class="InputDiv2 MarginLeft10 FloatLeft">

                            <input type="text" class="SelectConditonal15 FloatLeft"/>

                            <span class="RightContentToolIcon Icon Catelog FloatLeft" style="margin-top:3px; margin-Left:5px;"></span>

                        </div>

                        <input type="text" class="InputDiv4 FloatLeft MarginLeft10 "/>

                    </div>

                    <div class="SelectConditonalText" style="line-height:30px;">课别</div>

                    <div  class="SelectConditonal1" >

                        <div class="InputDiv2 MarginLeft10 FloatLeft">

                            <input type="text" class="SelectConditonal15 FloatLeft"/>

                            <span class="RightContentToolIcon Icon Catelog FloatLeft" style="margin-top:3px; margin-Left:5px;"></span>

                        </div>

                        <input type="text" class="InputDiv4 FloatLeft MarginLeft10 "/>

                    </div>

                </div>

                <div class="MenuLine Icon lineAAAAA"></div>

                <div class="HPAndForty">

                    <span class="LeftMenuIcon FloatRight Icon Rubber MarginRight10" title="隐藏左侧菜单栏"></span>

                    <span class="LeftMenuIcon FloatRight Icon SelectRuslt MarginRight10" title="隐藏左侧菜单栏"></span>

                </div>

            </div>

            <div id="RightContentRight_5" class="RightContentRight FloatRight">

                    

                <div class="RCR_Right1 TextAlginCenter" style="border-bottom:1px solid #FFFFFF;">

                        <table border="0" cellspacing="0" cellpadding="0">

                            <tr>

                                <td class="RCR_Cols1_D"><input type="checkbox" /></td>

                                <td class="RCR_Cols2_D"><span class="FloatLeft">|</span>大分类</td>

                                <td class="RCR_Cols3_D"><span class="FloatLeft">|</span>中文名称</td>

                                <td class="RCR_Cols4_D"><span class="FloatLeft">|</span>英文名称</td>

                                <td class="RCR_Cols5_D"><span class="FloatLeft">|</span>状态</td>

                                <td class="RCR_Cols6_D"><span class="FloatLeft">|</span>课别</td>

                                <td class="RCR_Cols6_D"><span class="FloatLeft">|</span>处别</td>

                            </tr>

                        </table>

                </div>

                <div class="RCR_Right2" style="border-bottom:1px solid #999999; height:310px;">

                        <table border="0" cellspacing="0" cellpadding="0">

                            <tr class="Grey1">

                                <td class="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                                <td class="RCR_Cols2_D TextAlginRight">100&nbsp</td>

                                <td class="RCR_Cols3_D">&nbsp;&nbsp;大码男装</td>

                                <td class="RCR_Cols4_D">&nbsp;&nbsp;&nbsp;Man Section</td>

                                <td class="RCR_Cols5_D">&nbsp;&nbsp;&nbsp;&nbsp;1-正常</td>

                                <td class="RCR_Cols6_D">&nbsp;&nbsp;&nbsp;&nbsp;1-男装部</td>

                                <td class="RCR_Cols6_D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1-纺织品</td>

                            </tr>

                            <tr>

                                <td class="RCR_Cols1_D TextAlginCenter"><input type="checkbox" class="DisplayNo" /></td>

                                <td class="RCR_Cols2_D TextAlginRight">101&nbsp</td>

                                <td class="RCR_Cols3_D">&nbsp;&nbsp;牛仔裤</td>

                                <td class="RCR_Cols4_D">&nbsp;&nbsp;&nbsp;Man Section</td>

                                <td class="RCR_Cols5_D">&nbsp;&nbsp;&nbsp;&nbsp;9-删除</td>

                                <td class="RCR_Cols6_D">&nbsp;&nbsp;&nbsp;&nbsp;1-男装部</td>

                                <td class="RCR_Cols6_D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4-纺织品</td>

                            </tr>

                        </table>

                </div>

                <div class=" HPAndThirty"><!--RCR_PageNum-->

                        <div class="RCR_PageNum1 FloatLeft">

                            第<span>1-15</span>项,共<span>145</span>项&nbsp;|&nbsp ;每页显示

                            <select class="Border" style="width:50px;">

                                <option>50</option>

                                <option>45</option>

                                <option>40</option>

                                <option>35</option>

                                <option>30</option>

                                <option>25</option>

                                <option>20</option>

                                <option>15</option>

                                <option>10</option>

                            </select>

                            项

                        </div>

                        <div class="RCR_PageNum2 FloatRight">

                            

                            <span class="FloatRight MarginRight20">&nbsp;页</span>

                            <input type="text" class="FloatRight Border" style="width:30px; height:15px;" />

                            <span class="FloatRight">&nbsp;&nbsp;跳转至&nbsp;</span>

                            <div class="FloatRight Icon Last"></div>

                            <div class="FloatRight Icon Next"></div>

                            <div class="FloatRight TextAlginCenter">20</div>

                            <div class="FloatRight TextAlginCenter">...</div>

                            <div class="FloatRight TextAlginCenter">5</div>

                            <div class="FloatRight TextAlginCenter">4</div>

                            <div class="FloatRight TextAlginCenter">3</div>

                            <div class="FloatRight TextAlginCenter">2</div>

                            <div class="FloatRight TextAlginCenter GreencColor">1</div>

                            <div class="FloatRight Icon Privious2"></div>

                            <div class="FloatRight Icon First2"></div>

                        </div>

                    </div>

                <div class="RCR_Right4 Grey1">

                    <div class="RCR_right4">

                    <table border="0" cellspacing="0" cellpadding="0"><!--大类型-->

                        <tr>

                            <td>&nbsp;</td>

                            <td></td><td></td><td></td>

                        </tr>

                        <tr>

                            <td class="RCR_Cols6_D TextAlginRight">季度折扣率</td><td class="RCR_Cols6_D"><input type="text" class="RCR_Right4Input1" />%</td>

                            <td class="RCR_Cols6_D TextAlginRight">创建日期</td><td><input type="text" class="RCR_Right4Input1"/></td>

                        </tr>

                        <tr>

                            <td class="RCR_Cols6_D TextAlginRight">半年折扣率</td><td class="RCR_Cols6_D"><input type="text" class="RCR_Right4Input1" />%</td>

                            <td class="RCR_Cols6_D TextAlginRight">修改日期</td><td><input type="text" class="RCR_Right4Input1"/></td>

                        </tr>

                        <tr>

                            <td class="RCR_Cols6_D TextAlginRight">一年折扣率</td><td class="RCR_Cols6_D"><input type="text" class="RCR_Right4Input1" />%</td>

                            <td class="RCR_Cols6_D TextAlginRight">修改人</td><td><input type="text" class="RCR_Right4Input1"/></td>

                        </tr>

                    </table>

                    </div>

                </div>

            </div>

        </div>

        <div id="Menu6" class="RightContentD DisplayNo"><!--中类型信息，这里的内容会随着变化-->

            <div id="SearchDiv_6" class="RightContentLeft FloatLeft Grey5 DisplayNo">

                <div class="HPAndThirty">

                    <span style="padding-left:10px;float:left;">查询条件</span>

                    <span class="LeftMenuIcon FloatRight Icon CircleClose MarginRight10" title="关闭"></span>

                </div>

                <div class="MenuLine Icon lineAAAAA"></div>

                <div class="RightContentLeft3">

                    <div class="SelectConditonalText" style="line-height:30px;">中分类</div>

                    <div  class="SelectConditonal1" >

                        <div class="InputDiv2 MarginLeft10 FloatLeft">

                            <input type="text" class="SelectConditonal15 FloatLeft"/>

                            <span class="RightContentToolIcon Icon Catelog FloatLeft" style="margin-top:3px; margin-Left:5px;"></span>

                        </div>

                        <input type="text" class="InputDiv4 FloatLeft MarginLeft10 "/>

                    </div>

                    <div class="SelectConditonalText" style="line-height:30px;">状态</div>

                    <div  class="SelectConditonal1" >

                        <div class="InputDiv2 MarginLeft10 FloatLeft">

                            <input type="text" class="SelectConditonal15 FloatLeft"/>

                            <span class="RightContentToolIcon Icon Catelog FloatLeft" style="margin-top:3px; margin-Left:5px;"></span>

                        </div>

                        <input type="text" class="InputDiv4 FloatLeft MarginLeft10 "/>

                    </div>

                    <div class="SelectConditonalText" style="line-height:30px;">处别</div>

                    <div  class="SelectConditonal1" >

                        <div class="InputDiv2 MarginLeft10 FloatLeft">

                            <input type="text" class="SelectConditonal15 FloatLeft"/>

                            <span class="RightContentToolIcon Icon Catelog FloatLeft" style="margin-top:3px; margin-Left:5px;"></span>

                        </div>

                        <input type="text" class="InputDiv4 FloatLeft MarginLeft10 "/>

                    </div>

                    <div class="SelectConditonalText" style="line-height:30px;">课别</div>

                    <div  class="SelectConditonal1" >

                        <div class="InputDiv2 MarginLeft10 FloatLeft">

                            <input type="text" class="SelectConditonal15 FloatLeft"/>

                            <span class="RightContentToolIcon Icon Catelog FloatLeft" style="margin-top:3px; margin-Left:5px;"></span>

                        </div>

                        <input type="text" class="InputDiv4 FloatLeft MarginLeft10 "/>

                    </div>

                </div>

                <div class="MenuLine Icon lineAAAAA"></div>

                <div class="HPAndForty">

                    <span class="LeftMenuIcon FloatRight Icon Rubber MarginRight10" title="隐藏左侧菜单栏"></span>

                    <span class="LeftMenuIcon FloatRight Icon SelectRuslt MarginRight10" title="隐藏左侧菜单栏"></span>

                </div>

            </div>

            <div id="RightContentRight_6" class="RightContentRight FloatRight">

                    

                <div class="RCR_Right1 TextAlginCenter" style="border-bottom:1px solid #FFFFFF;">

                        <table border="0" cellspacing="0" cellpadding="0">

                            <tr>

                                <td class="RCR_Cols1_D"><input type="checkbox" /></td>

                                <td class="RCR_Cols2_D"><span class="FloatLeft">|</span>中分类</td>

                                <td class="RCR_Cols5_D"><span class="FloatLeft">|</span>中文名称</td>

                                <td class="RCR_Cols4"><span class="FloatLeft">|</span>英文名称</td>

                                <td class="RCR_Cols5_D"><span class="FloatLeft">|</span>状态</td>

                                <td class="RCR_Cols6_D"><span class="FloatLeft">|</span>大分类</td>

                                <td class="RCR_Cols6_D"><span class="FloatLeft">|</span>课别</td>

                                <td class="RCR_Cols6_D"><span class="FloatLeft">|</span>处别</td>

                            </tr>

                        </table>

                </div>

                <div class="RCR_Right2" style="border-bottom:1px solid #999999; height:310px;">

                        <table border="0" cellspacing="0" cellpadding="0">

                            <tr class="Grey1">

                                <td class="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                                <td class="RCR_Cols2_D TextAlginRight">10&nbsp</td>

                                <td class="RCR_Cols5_D">&nbsp;&nbsp;大码西装</td>

                                <td class="RCR_Cols4">&nbsp;&nbsp;&nbsp;LARGE SIZE BLAZER SUIT</td>

                                <td class="RCR_Cols5_D">&nbsp;&nbsp;&nbsp;&nbsp;1-正常</td>

                                <td class="RCR_Cols6_D">&nbsp;&nbsp;&nbsp;&nbsp;100 大码男装</td>

                                <td class="RCR_Cols6_D">&nbsp;&nbsp;&nbsp;&nbsp;1-男装部</td>

                                <td class="RCR_Cols6_D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1-纺织品</td>

                            </tr>

                            <tr>

                                <td class="RCR_Cols1_D TextAlginCenter"><input type="checkbox" class="DisplayNo" /></td>

                                <td class="RCR_Cols2_D TextAlginRight">11&nbsp</td>

                                <td class="RCR_Cols5_D">&nbsp;&nbsp;大码外套</td>

                                <td class="RCR_Cols4">&nbsp;&nbsp;&nbsp;LARGE SIZE OVERCOAT</td>

                                <td class="RCR_Cols5_D">&nbsp;&nbsp;&nbsp;&nbsp;9-删除</td>

                                <td class="RCR_Cols6_D">&nbsp;&nbsp;&nbsp;&nbsp;100 大码男装</td>

                                <td class="RCR_Cols6_D">&nbsp;&nbsp;&nbsp;&nbsp;1-男装部</td>

                                <td class="RCR_Cols6_D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1-纺织品</td>

                            </tr>

                        </table>

                </div>

                <div class=" HPAndThirty"><!--RCR_PageNum-->

                        <div class="RCR_PageNum1 FloatLeft">

                            第<span>1-15</span>项,共<span>145</span>项&nbsp;|&nbsp ;每页显示

                            <select class="Border" style="width:50px;">

                                <option>50</option>

                                <option>45</option>

                                <option>40</option>

                                <option>35</option>

                                <option>30</option>

                                <option>25</option>

                                <option>20</option>

                                <option>15</option>

                                <option>10</option>

                            </select>

                            项

                        </div>

                        <div class="RCR_PageNum2 FloatRight">

                            

                            <span class="FloatRight MarginRight20">&nbsp;页</span>

                            <input type="text" class="FloatRight Border" style="width:30px; height:15px;" />

                            <span class="FloatRight">&nbsp;&nbsp;跳转至&nbsp;</span>

                            <div class="FloatRight Icon Last"></div>

                            <div class="FloatRight Icon Next"></div>

                            <div class="FloatRight TextAlginCenter">20</div>

                            <div class="FloatRight TextAlginCenter">...</div>

                            <div class="FloatRight TextAlginCenter">5</div>

                            <div class="FloatRight TextAlginCenter">4</div>

                            <div class="FloatRight TextAlginCenter">3</div>

                            <div class="FloatRight TextAlginCenter">2</div>

                            <div class="FloatRight TextAlginCenter GreencColor">1</div>

                            <div class="FloatRight Icon Privious2"></div>

                            <div class="FloatRight Icon First2"></div>

                        </div>

                    </div>

                <div class="RCR_Right4 Grey1 DisplayNo"><!--大类型，默认为此页，这部分会改变-->

                    <div class="RCR_right4">

                    <table border="0" cellspacing="0" cellpadding="0"><!--大类型-->

                        <tr>

                            <td>&nbsp;</td>

                            <td></td><td></td><td></td>

                        </tr>

                        <tr>

                            <td class="RCR_Cols6_D TextAlginRight">季度折扣率</td><td class="RCR_Cols6_D"><input type="text" class="RCR_Right4Input1" />%</td>

                            <td class="RCR_Cols6_D TextAlginRight">创建日期</td><td><input type="text" class="RCR_Right4Input1"/></td>

                        </tr>

                        <tr>

                            <td class="RCR_Cols6_D TextAlginRight">半年折扣率</td><td class="RCR_Cols6_D"><input type="text" class="RCR_Right4Input1" />%</td>

                            <td class="RCR_Cols6_D TextAlginRight">修改日期</td><td><input type="text" class="RCR_Right4Input1"/></td>

                        </tr>

                        <tr>

                            <td class="RCR_Cols6_D TextAlginRight">一年折扣率</td><td class="RCR_Cols6_D"><input type="text" class="RCR_Right4Input1" />%</td>

                            <td class="RCR_Cols6_D TextAlginRight">修改人</td><td><input type="text" class="RCR_Right4Input1"/></td>

                        </tr>

                    </table>

                    </div>

                </div>

                <div class="RCR_Right4Z Grey1"><!--中类型-->

                    <div class="RCR_right4Z">

                        <div class="RCR_4ZLeft FloatLeft">

                            <table border="0" cellspacing="0" cellpadding="0">

                                <tr><td>&nbsp;</td><td></td></tr>

                                <tr>

                                    <td class="RCR_Cols4_D TextAlginRight">分类管控</td>

                                    <td><!--<input type="text" class="RCR_Cols4 Height1 MarginLeft10" />-->

                                        <select class="RCR_PageNum1 Height1 MarginLeft10 FloatLeft" >

                                            <option>1-烟</option>

                                            <option>2-本地专卖</option>

                                            <option>3-原材料</option>

                                            <option>4-包材</option>

                                        </select>

                                        <!--<input type="text" class="RCR_PageNum1 Height1 MarginLeft10 FloatLeft" />--></td>

                                </tr>

                                <tr>

                                    <td class="RCR_Cols4_D TextAlginRight">库存管理</td>

                                    <td><!--<input type="text" class="RCR_Cols4 Height1 MarginLeft10" />-->

                                        <select class="RCR_PageNum1 Height1 MarginLeft10 FloatLeft" >

                                            <option>1-单品管理</option>

                                            <option>2-生鲜面销</option>

                                        </select>

                                        <!--<input type="text" class="RCR_PageNum1 Height1 MarginLeft10 FloatLeft" />--></td>

                                </tr>

                                <tr>

                                    <td class="RCR_Cols4_D TextAlginRight">进价税率</td>

                                    <td><!--<input type="text" class="RCR_Cols4 Height1 MarginLeft10" />--><input type="text" class="RCR_Cols4 Height1 MarginLeft10" value="1-13%" /></td>

                                </tr>

                                <tr>

                                    <td class="RCR_Cols4_D TextAlginRight">买价税率</td>

                                    <td><!--<input type="text" class="RCR_Cols4 Height1 MarginLeft10" />--><input type="text" class="RCR_Cols4 Height1 MarginLeft10" value="2-17%" /></td>

                                </tr>

                            </table>

                        </div>

                        <div  class="RCR_4ZMiddle FloatLeft">

                            <table border="0" cellspacing="0" cellpadding="0">

                                <tr><td>&nbsp;</td><td></td></tr>

                                <tr>

                                    <td class="RCR_Cols4_D TextAlginRight">畅销</td>

                                    <td><span class="MarginLeft10">DMS ></span><input type="text" class="RCR_Cols4 Height1 MarginLeft7" value="3" style="line-height:20px;" /></td>

                                </tr>

                                <tr>

                                    <td class="RCR_Cols4_D TextAlginRight">缺货</td>

                                    <td><span class="MarginLeft10">库存  <</span><input type="text" class="RCR_Cols4 Height1 MarginLeft10" value="2" style="line-height:20px;" />× DMS</td>

                                </tr>

                                <tr>

                                    <td class="RCR_Cols4_D TextAlginRight">滞销天数</td>

                                    <td><input type="text" class="RCR_PageNum1 Height1 MarginLeft10" value="10" style="line-height:20px;"/>天</td>

                                </tr>

                                <!--<tr>

                                    <td class="RCR_Cols4_D TextAlginRight">采购</td>

                                    <td><input type="text" class="RCR_PageNum1 Height1 MarginLeft10" /><input type="text" class="RCR_Cols4 Height1 MarginLeft10" /></td>

                                </tr>-->

                            </table>

                        </div>

                        <div class="RCR_4ZRight FloatLeft">

                            <table border="0" cellspacing="0" cellpadding="0">

                                <tr><td>&nbsp;</td><td></td></tr>

                                <tr>

                                    <td class="RCR_Cols4_D TextAlginRight">创建日期</td>

                                    <td><input type="text" class="RCR_PageNum1 Height1 MarginLeft10" value="2014/03/01" /></td>

                                </tr>

                                <tr>

                                    <td class="RCR_Cols4_D TextAlginRight">修改日期</td>

                                    <td><input type="text" class="RCR_PageNum1 Height1 MarginLeft10"  value="2014/03/01"/></td>

                                </tr>

                                <tr>

                                    <td class="RCR_Cols4_D TextAlginRight">修改人</td>

                                    <td><input type="text" class="RCR_PageNum1 Height1 MarginLeft10" /></td>

                                </tr>

                                <tr>

                                    <td>&nbsp;</td>

                                    <td></td>

                                </tr>

                            </table>

                        </div>

                    </div>

                </div>

            </div>

        </div>

        <div id="Menu7" class="RightContentD DisplayNo"><!--小类型信息，这里的内容会随着变化-->

            <div id="SearchDiv_7" class="RightContentLeft FloatLeft Grey5 DisplayNo">

                <div class="HPAndThirty">

                    <span style="padding-left:10px;float:left;">查询条件</span>

                    <span class="LeftMenuIcon FloatRight Icon CircleClose MarginRight10" title="关闭"></span>

                </div>

                <div class="MenuLine Icon lineAAAAA"></div>

                <div class="RightContentLeft3">

                    <div class="SelectConditonalText" style="line-height:30px;">大分类</div>

                    <div  class="SelectConditonal1" >

                        <div class="InputDiv2 MarginLeft10 FloatLeft">

                            <input type="text" class="SelectConditonal15 FloatLeft"/>

                            <span class="RightContentToolIcon Icon Catelog FloatLeft" style="margin-top:3px; margin-Left:5px;"></span>

                        </div>

                        <input type="text" class="InputDiv4 FloatLeft MarginLeft10 "/>

                    </div>

                    <div class="SelectConditonalText" style="line-height:30px;">状态</div>

                    <div  class="SelectConditonal1" >

                        <div class="InputDiv2 MarginLeft10 FloatLeft">

                            <input type="text" class="SelectConditonal15 FloatLeft"/>

                            <span class="RightContentToolIcon Icon Catelog FloatLeft" style="margin-top:3px; margin-Left:5px;"></span>

                        </div>

                        <input type="text" class="InputDiv4 FloatLeft MarginLeft10 "/>

                    </div>

                    <div class="SelectConditonalText" style="line-height:30px;">处别</div>

                    <div  class="SelectConditonal1" >

                        <div class="InputDiv2 MarginLeft10 FloatLeft">

                            <input type="text" class="SelectConditonal15 FloatLeft"/>

                            <span class="RightContentToolIcon Icon Catelog FloatLeft" style="margin-top:3px; margin-Left:5px;"></span>

                        </div>

                        <input type="text" class="InputDiv4 FloatLeft MarginLeft10 "/>

                    </div>

                    <div class="SelectConditonalText" style="line-height:30px;">课别</div>

                    <div  class="SelectConditonal1" >

                        <div class="InputDiv2 MarginLeft10 FloatLeft">

                            <input type="text" class="SelectConditonal15 FloatLeft"/>

                            <span class="RightContentToolIcon Icon Catelog FloatLeft" style="margin-top:3px; margin-Left:5px;"></span>

                        </div>

                        <input type="text" class="InputDiv4 FloatLeft MarginLeft10 "/>

                    </div>

                </div>

                <div class="MenuLine Icon lineAAAAA"></div>

                <div class="HPAndForty">

                    <span class="LeftMenuIcon FloatRight Icon Rubber MarginRight10" title="隐藏左侧菜单栏"></span>

                    <span class="LeftMenuIcon FloatRight Icon SelectRuslt MarginRight10" title="隐藏左侧菜单栏"></span>

                </div>

            </div>

            <div id="RightContentRight_7" class="RightContentRight FloatRight">

                    

                <div class="RCR_Right1 TextAlginCenter" style="border-bottom:1px solid #FFFFFF;">

                        <table border="0" cellspacing="0" cellpadding="0">

                            <tr>

                                <td class="RCR_Cols1_D"><input type="checkbox" /></td>

                                <td class="XTableTd1"><span class="FloatLeft">|</span>小分类</td>

                                <td class="RCR_Cols5_D"><span class="FloatLeft">|</span>中文名称</td>

                                <td class="XTableTd4"><span class="FloatLeft">|</span>英文名称</td>

                                <td class="XTableTd2"><span class="FloatLeft">|</span>状态</td>

                                <td class="XTableTd3"><span class="FloatLeft">|</span>中分类</td>

                                <td class="XTableTd3"><span class="FloatLeft">|</span>大分类</td>

                                <td class="RCR_Cols6_D"><span class="FloatLeft">|</span>课别</td>

                                <td class="RCR_Cols6_D"><span class="FloatLeft">|</span>处别</td>

                            </tr>

                        </table>

                </div>

                <div class="RCR_Right2" style="border-bottom:1px solid #999999; height:310px;">

                        <table border="0" cellspacing="0" cellpadding="0">

                            <tr class="Grey1">

                                <td class="RCR_Cols1_D TextAlginCenter"><input type="checkbox" /></td>

                                <td class="XTableTd1">&nbsp;100</td>

                                <td class="RCR_Cols5_D">&nbsp;&nbsp;大码男装</td>

                                <td class="XTableTd4">&nbsp;&nbsp;&nbsp;Man Section</td>

                                <td class="XTableTd2">&nbsp;&nbsp;&nbsp;&nbsp;1-正常</td>

                                <td class="XTableTd3">&nbsp;&nbsp;&nbsp;&nbsp;10 中分类装</td>

                                <td class="XTableTd3">&nbsp;&nbsp;&nbsp;&nbsp;100 大分类装</td>

                                <td class="RCR_Cols6_D">&nbsp;&nbsp;&nbsp;&nbsp;1-大众消费品</td>

                                <td class="RCR_Cols6_D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4-大众消费品</td>

                            </tr>

                            <tr>

                                <td class="RCR_Cols1_D TextAlginCenter"><input type="checkbox" class="DisplayNo" /></td>

                                <td class="XTableTd1">&nbsp;100</td>

                                <td class="RCR_Cols5_D">&nbsp;&nbsp;大码男装</td>

                                <td class="XTableTd4">&nbsp;&nbsp;&nbsp;Man Section</td>

                                <td class="XTableTd2">&nbsp;&nbsp;&nbsp;&nbsp;1-正常</td>

                                <td class="XTableTd3">&nbsp;&nbsp;&nbsp;&nbsp;10 中分类装</td>

                                <td class="XTableTd3">&nbsp;&nbsp;&nbsp;&nbsp;100 大分类装</td>

                                <td class="RCR_Cols6_D">&nbsp;&nbsp;&nbsp;&nbsp;1-大众消费品</td>

                                <td class="RCR_Cols6_D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4-大众消费品</td>

                            </tr>

                        </table>

                </div>

                <div class=" HPAndThirty"><!--RCR_PageNum-->

                        <div class="RCR_PageNum1 FloatLeft">

                            第<span>1-15</span>项,共<span>145</span>项&nbsp;|&nbsp ;每页显示

                            <select class="Border" style="width:50px;">

                                <option>50</option>

                                <option>45</option>

                                <option>40</option>

                                <option>35</option>

                                <option>30</option>

                                <option>25</option>

                                <option>20</option>

                                <option>15</option>

                                <option>10</option>

                            </select>

                            项

                        </div>

                        <div class="RCR_PageNum2 FloatRight">

                            

                            <span class="FloatRight MarginRight20">&nbsp;页</span>

                            <input type="text" class="FloatRight Border" style="width:30px; height:15px;" />

                            <span class="FloatRight">&nbsp;&nbsp;跳转至&nbsp;</span>

                            <div class="FloatRight Icon Last"></div>

                            <div class="FloatRight Icon Next"></div>

                            <div class="FloatRight TextAlginCenter">20</div>

                            <div class="FloatRight TextAlginCenter">...</div>

                            <div class="FloatRight TextAlginCenter">5</div>

                            <div class="FloatRight TextAlginCenter">4</div>

                            <div class="FloatRight TextAlginCenter">3</div>

                            <div class="FloatRight TextAlginCenter">2</div>

                            <div class="FloatRight TextAlginCenter GreencColor">1</div>

                            <div class="FloatRight Icon Privious2"></div>

                            <div class="FloatRight Icon First2"></div>

                        </div>

                    </div>



                <div class="RCR_Right4X Grey1"><!--小类型，这部分会改变-->

                        <table border="0" cellspacing="0" cellpadding="0" class="RCR_right4X">

                            <tr><td  class="RCR_Cols1_D"></td>

                                <td>

                                <div class="RCR_4XLeft FloatLeft">

                                    <table border="0" cellspacing="0" cellpadding="0" class="RCR_table BottomLine">

                                        <tr><td class="TextAlginCenter"></td>

                                        <td class="TextAlginCenter">华东</td>

                                        <td class="TextAlginCenter">华北</td>

                                        <td class="TextAlginCenter">华南</td>

                                        <td class="TextAlginCenter">华中</td>

                                        <td class="TextAlginCenter">西南</td>

                                        <td class="TextAlginCenter">西北</td>

                                        <td class="TextAlginCenter">东北</td></tr>

                                    </table>

                                    <table border="0" cellspacing="0" cellpadding="0" class="RCR_table">

                                        <tr><td>B-Basic</td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td></tr>

                                        <tr><td>N-National</td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td></tr>

                                        <tr><td>O-Optional</td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td></tr>

                                        <tr><td>L-Local</td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td>

                                        <td class="TextAlginCenter"><input type="text" class="RCB_Content2RightInput Border " /></td></tr>

                                    </table>

                                </div>

                                <div class="RCR_4XRight FloatLeft">

                                    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;" class="">

                                        <tr>

                                            <td class="RCR_Cols4_D TextAlginRight">创建日期</td>

                                            <td><input type="text" class="InputDiv MarginLeft10" /></td>

                                        </tr>

                                        <tr>

                                            <td class="RCR_Cols4_D TextAlginRight">修改日期</td>

                                            <td><input type="text" class="InputDiv MarginLeft10" /></td>

                                        </tr>

                                        <tr>

                                            <td class="RCR_Cols4_D TextAlginRight">修改人</td>

                                            <td><input type="text" class="InputDiv MarginLeft10" /></td>

                                        </tr>

                                    </table>

                                </div>

                                </td>

                            </tr>

                        </table>

            </div>

        </div>

        </div>

    </div>

</body>

</html>



