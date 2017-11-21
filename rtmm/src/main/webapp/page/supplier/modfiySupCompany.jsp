<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/page/commons/knockout.jsp" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css" rel="Stylesheet" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" rel="Stylesheet" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" rel="Stylesheet" />
<script src="${ctx}/shared/js/supplier/company.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
var viewModel = new ViewModel();
ko.applyBindings(viewModel);
$(function() {
	$("#Tools2").attr('class',"Tools2").bind("click",function(){
		viewModel.update();
	});
	$('#supComMess').bind('click', function() {
			companyManagement();
	}); 
	$('#comOthAddrMess').bind('click', function() {
			comOtherAddrManagement();
	}); 
	$("#closeDiv").bind("click",function(){
		wipeAddPage();
	});
});
</script>
<style type="text/css">
        .t_div1,.t_div2 {
            width:50%;height:539px;float:left;
        }
        
        .t_div1_1 {
            height:387px;
        }
        .t_div1_2 {
            height:150px;margin-top:2px;
        }
        .t_div2_1 {
            height:120px;
        }
        .t_div2_2 {
            height:417px;margin-top:2px;
        }
        .t2_title {
            line-height:25px;
        }
        .t2_title div {
            width:70px;float:left;margin-left:75px;
        }
        /*input对齐*/
        .w91_s232 {
            width:91%;width/*\**/:92%\9;*width:92%;
        }
        .twoinput20 {
            width: 62%;width/*\**/:62.5%\9;*width:62.5%;
            float: left;
            margin-left: 3px;
        }
        .twoinput21{
            width: 30%;
            float: left;
            margin-left: 3px;
        }
        .twoinput22 {
            width: 10%;
            float: left;
        }
        .twoinput23 {
            width: 25%;
            float: left;
        }
        .twoinput24 {
            width: 33%;width/*\**/:33%\9;*width:33.3%;
            float: left;
        }
        .twoinput25 {
            width: 14.5%;
            float: left;
        }
        .twoinput26 {
            width: 16%;
            float: left;
        }
        .twoinput27 {
            width: 25%;
            float: left;
        }
        .twoinput28 {
            width: 20%;width/*\**/:20.5%\9;*width:20%;
            float: left;
        }
    </style>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
    <!--第一个-->
    <div id="first" class="tags1_left"></div>
    <div id="supComMess" class="tagsM">公司总览</div>
  	<div id="midden" class="tags"></div>
    <!--最后一个-->
    <div id="comOthAddrMess" class="tagsM"><!-- 订货退货地址 --><auchan:i18n id="102002010"/></div>
    <div id="last" class="tags tags3 tags_right_on"></div>
<!--一定不要忘了tag3-->
    <!--add-->
    <div id="createSupCom" class="tagsM_q  tagsM_on">创建新公司</div>
    <div id ="createLast" class="tags3_close_on">
    <div id="closeDiv" class="tags_close"></div>
    </div>
</div>
<div class="Container-1">
        <div class="Content" style="width:99%;"><!--width:74%;-->
         <div class="CInfo">
                <span>项</span>
                <span>10，000</span>
                <span>/</span>
                <span>1</span>
                <span>第</span>
                <span>|</span>
                <span>张三</span>
                <span><!-- 修改人 --><auchan:i18n id="102009008"/></span>
                <span>2014-03-03</span>
                <span><!-- 修改日期 --><auchan:i18n id="102009007"/></span>
                <span>李四</span>
                <span><!-- 建档人 --><auchan:i18n id="102009006"/></span>
                <span>2014-02-02</span>
                <span><!-- 创建日期 --><auchan:i18n id="102002010"/></span>
            </div>
            <div class="line" style="width:100%"></div>
            <div class="t_div1" style="width:50%;height:539px; float:left;">
                <div class="CM t_div1_1">
                    <div class="CM-bar"><div><!-- 基本信息 --><auchan:i18n id="102004033"/></div></div>
                    <div class="CM-div">
                    <table class="CM_table">
                        <tr>
                            <td style="width:25%;"><span>*公司编号</span></td>
                            <td><input type="text" class="inputText twoInput1 Black " data-bind="value:viewModel.comNo"/>
                            </td>
                        </tr>
                        <tr>
                            <td><span>*<!-- 税号 --><auchan:i18n id="102006075"/></span></td>
                            <td><input type="text" class="inputText fl_left" style="width:44%" data-bind="value:viewModel.unifmNo"/>
                                <span style="float:left;margin-right:1px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 状态 --><auchan:i18n id="102008013"/></span>
                                <input type="text" class="Black inputText twoInput2"  value="0-未生效"/></td>
                        </tr>
                        <tr>
                            <td><span>*公司名称</span></td>
                            <td><input type="text" class="inputText w91_s232" data-bind="value:viewModel.comName"/></td>
                        </tr>
                        <tr>
                            <td><span>公司英文名</span></td>
                            <td><input type="text" class="inputText w91_s232" data-bind="value:viewModel.comEnName"/></td>
                        </tr>
                        <tr>
                            <td><span>*集团</span></td>
                            <td><div class="iconPut" style="width:28%;float:left;">
                            		<input type="text" style="width:80%" data-bind="value:viewModel.comgrpNo"/>
                            	<div class="ListWin" >
                            	</div>
                            	</div>
                                    <input type="text" class="Black inputText twoinput20" /></td>
                        </tr>
                        <tr>
                            <td><span>*公司类型</span></td>
                            <td><select style="width:42%;float:left;" data-bind="value:viewModel.econType">
                            	<option value="1">有限公司</option>
                            	<option value="2">股份有限责任公司</option>
                            	<option value="3">个人独资企业</option>
                            	<option value="4">合伙企业</option>
                            </select>
                            <span style="float:left;margin-right:2px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;法人代表</span>
                            <input type="text" class="inputText twoinput21" data-bind="value:viewModel.legalRpstv"/></td>
                        </tr>
                        <tr>
                            <td><span>*经营范围</span></td>
                            <td><input type="text" class="inputText w91_s232"  data-bind="value:viewModel.bizScopeDesc"/></td>
                        </tr>
                        <tr>
                            <td><span>*成立日期</span></td>
                            <td><div class="iconPut" style="width:28%;"><input type="text" class="w80" data-bind="value:viewModel.setupDate"/><div class="C_Func Calendar"></div> </div></td>
                        </tr>
                        <tr>
                            <td><span>*注册城市</span></td>
                            <td><input type="text" class="inputText twoInput1" style="width:20%;" data-bind="value:viewModel.regProvName"/>
                                <div class="iconPut" style="width:28%;float:left; margin-left:3px;">
                                <input type="text" style="width:80%" data-bind="value:viewModel.regCityName"/><div class="ListWin"></div></div></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td><input type="text" class="inputText w91_s232" data-bind="value:viewModel.regDetllAddr"/></td>
                        </tr>
                        <tr>
                            <td><span>*电话号码</span></td>
                            <td><input type="text" class="inputText twoinput22" data-bind="value:viewModel.regAreaCode"/><span style="float:left;margin:0;">-</span>
                                    <input type="text" class="inputText twoinput23" data-bind="value:viewModel.regMoblNo"/>
                                    <span style="float:left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;电子邮箱</span>
                                    <input type="text" class="inputText twoinput24" data-bind="value:viewModel.regEmailAddr"/></td>
                        </tr>
                        <tr>
                            <td><span>*网址</span></td>
                            <td><input type="text" class="inputText w91_s232" data-bind="value:viewModel.webSite"/></td>
                        </tr>
                    </table>
                	</div>
                </div>
                <div class="CM t_div1_2">
                    <div class="CM-bar"><div>发票送达地址</div></div>
                    <div class="CM-div">
                    <table class="CM_table">
                        <tr>
                            <td style="width:25%;"><span>*发票送达地址</span></td>
                            <td>
                                <div class="iconPut" style="width:20%;float:left;">
                                	<input type="text" style="width:72%;" data-bind="value:viewModel.dlvProvName"/>
                                    <div style="color:#999999;"><!-- 省 --><auchan:i18n id="100000010"/></div></div>
                                <div class="iconPut" style="width:28%;float:left; margin-left:3px;">
                                    <input type="text" style="width:62%;" data-bind="value:viewModel.dlvCityName"/><div style="color:#999999;"><!-- 市 --><auchan:i18n id="100000010"/></div><div class="ListWin"></div></div>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td><input type="text" class="inputText w91_s232" data-bind="value:viewModel.dlvDetllAddr"/></td>
                        </tr>
                        <tr>
                            <td><span><!-- 邮政编码 --><auchan:i18n id="102006015"/></span></td>
                            <td><input type="text" class="inputText twoinput25" data-bind="value:viewModel.dlvPostCode"/>
                                    <span style="float:left;margin:0;">&nbsp;&nbsp;&nbsp;<!-- 联系人 --><auchan:i18n id="102006016"/>&nbsp;</span>
                                   <input type="text" class="inputText twoinput25" data-bind="value:viewModel.dlvCntctName"/><span style="float:left;margin:0;">&nbsp;&nbsp;&nbsp;<!-- 传真 --><auchan:i18n id="102006017"/>&nbsp;</span>
                                <input type="text" class="inputText twoinput22" /><span style="float:left;margin:0;">-</span>
                                    <input type="text" class="inputText twoinput23" data-bind="value:viewModel.dlvFaxNo"/>
                            </td>
                        </tr>
                        <tr>
                            <td><span>电话号码</span></td>
                            <td><input type="text" class="inputText twoinput22" /><span style="float:left;margin:0;">-</span>
                                    <input type="text" class="inputText twoinput26" />
                                    <span style="float:left;margin:0;">&nbsp;&nbsp;手机</span>
                                    <input type="text" class="inputText twoinput27" data-bind="value:viewModel.dlvPhoneNo"/>
                                    <span style="float:left;margin:0;">&nbsp;&nbsp;邮箱</span>
                                    <input type="text" class="inputText twoinput28" data-bind="value:viewModel.dlvEmailAddr"/>
                            </td>
                        </tr>
                        
                    </table>
                </div>
                </div>
            </div>
            <div class="t_div2">
                <div class="CM t_div2_1" style="height:120px;">
                    <div class="CM-bar"><div><!-- 额外信息 --><auchan:i18n id="102004034"/></div></div>
                    <div class="CM-div">
                    <table class="CM_table">
                        <tr>
                            <td style="width:25%;"><span>法务注记</span></td>
                            <td><input type="text" class="inputText w50" data-bind="value:viewModel.lawNote"/></td>
                        </tr>
                        <tr>
                            <td><span>呆账催收注记</span></td>
                            <td><input type="text" class="inputText w50" data-bind="value:viewModel.debtNote"/></td>
                        </tr>
                        <tr>
                            <td><span>信用状况注记</span></td>
                            <td><input type="text" class="inputText w50" data-bind="value:viewModel.credtNote"/></td>
                        </tr>
                    </table>
                	</div>
                </div>
                <div class="CM t_div2_2">
                    <div class="CM-bar"><div>公司证件</div></div>
                    <div class="CM-div">
                    <table class="CM_table" style="width:92%;margin-left:10px;">
                        <tr>
                            <td>
                                <div class="t2_title">
                                    <div>证件类型</div>
                                    <div>证件号</div>
                                    <div>起始日期</div>
                                    <div>截止日期</div>
									<div>发证机关</div>
                                </div>
                            </td>
                        </tr>
                        <tr><td class="line"></td></tr>
                        <tr>
                            <td style="height:335px;">
                                <div style="height:100%;overflow-x:hidden;overflow-y:scroll;">
                                    <table style="width:100%;height:55px; overflow:scroll">
                                        <tbody data-bind="foreach: comLicencesList">
	                                        <tr>
	                                            <td style="width:5%;"><input type="checkbox" /> </td>
	                                            <td style="width:6%;"><div style="height:20px;width:20px;border:1px solid #999999;" class="license1"></div></td>
	                                            <td style="width:36%;">
	                                            	<auchan:select  mdgroup="COM_LICENCE_LICNCE_TYPE" style="width: 90%;" dataBind="value:licnceType"></auchan:select>
	                                            	<!-- <select style="width:90%;" data-bind="value:licnceType">
	                                            		<option value="0">请选择</option>
	                                            		<option value="1">营业执照</option>
														<option value="2">组织机构代码证</option>
														<option value="3">税务登记证</option>
														<option value="4">卫生许可证</option>
														<option value="5">QS</option>
														<option value="6">自产自销证明</option>
														<option value="7">开户许可证</option>
														<option value="8">3C证</option>
														<option value="9">流通许可证</option>
														<option value="10">商品条码证书</option>
														<option value="11">有机证书</option>
														<option value="12">有机转化证书</option>
														<option value="13">绿色证书</option>
														<option value="14">功能性食品检测报告</option>
														<option value="15">地区代理授权书</option>
														<option value="16">商标注册证</option>
														<option value="17">品牌授权书</option>
	                                            	</select> -->
	                                            </td>
	                                            <td style="width:30%;"><input type="text" style="width:90%;" class="inputText" data-bind="value:licnceNo"/></td>
	                                            <td style="width:23%;"><div class="iconPut w90"><input type="text" style="width:70%" /><div class="C_Func Calendar"></div> </div></td>
	                                            <td style="width:23%;"><div class="iconPut w90"><input type="text" style="width:70%" data-bind="value:validEndDate"/><div class="C_Func Calendar"></div> </div></td>
	                                            <td style="width:23%;"><div class="iconPut w90"><input type="text" style="width:70%" /><div class="C_Func Calendar"></div> </div></td>
	                                        </tr>
                                   		 </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr><td class="line"></td></tr>
                        <tr><td>
                            <input type="checkbox" style="float:left;"/>
                                <div class="Icon-size2 Tools10_disable fl_left" style="margin-left:10px;"></div>
                                <div class="Line-1 Icon-size2 fl_left"  data-bind='event:{click:$root.removeLicFun}'></div>
                                <div class="Tools11 Icon-size2 fl_left" data-bind='event:{click:$root.addLicFun}'></div>
                            </td></tr>
                    </table>
                	</div>
                </div>
            </div>
        </div>
</div>
