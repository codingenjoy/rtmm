<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/page/commons/knockout.jsp" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css" rel="Stylesheet" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" rel="Stylesheet" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" rel="Stylesheet" />
<script src="${ctx}/shared/js/supplier/company.js" charset="UTF-8" type="text/javascript"></script>
<script type="text/javascript">
function ViewModel() {
	var self = this;
	self.comNo = ko.observable('${}');
	self.unifmNo = ko.observable('${}');
	self.comName = ko.observable('');
	self.comEnName = ko.observable('');
	self.comgrpNo = ko.observable('');
	self.econType = ko.observable('');
	self.legalRpstv = ko.observable('');
	self.bizScopeDesc = ko.observable('');
	self.setupDate = ko.observable('');
	//注册地址信息
	self.regProvName = ko.observable('');
	self.regCityName = ko.observable('');
	self.regDetllAddr = ko.observable('');
	self.regAreaCode = ko.observable('');
	self.regMoblNo = ko.observable('');
	self.regEmailAddr = ko.observable('');
	self.webSite = ko.observable('');
	//发票地址
	self.dlvProvName = ko.observable('');
	self.dlvCityName = ko.observable('');
	self.dlvDetllAddr = ko.observable('');
	self.dlvPostCode = ko.observable('');
	self.dlvCntctName = ko.observable('');
	self.dlvFaxAreaCode = ko.observable('');
	self.dlvFaxNo = ko.observable('');
	self.dlvAreaCode = ko.observable('');
	self.dlvMoblNo = ko.observable('');
	self.dlvPhoneNo = ko.observable('');
	self.dlvEmailAddr = ko.observable('');
	//额外信息
	self.lawNote = ko.observable('');
	self.debtNote = ko.observable('');
	self.credtNote = ko.observable('');
	//公司证件
	self.comLicencesList   = ko.observableArray([]);
	self.addLicFun = function(o, event) {
		o.comLicencesList.push(new LicFun("", "", ""));
	};
	self.removeLicFun = function(obj) {
		self.comLicencesList.remove(obj);
	};
	self.update = function(form, event) {
		// 验证表单
		viewModel.errors = ko.validation.group(viewModel);
		if (!viewModel.isValid()) {
			viewModel.errors.showAllMessages();
			return;
		}
		if (viewModel.comLicencesList().length > 0) {
			var passValidate = true;
			$.each(viewModel.comLicencesList(), function(index, value) {
				var num = parseInt(index, 10) + 1;
				if (value.licnceType() == '') {
					passValidate = false;
					top.jAlert('error', '第' + num + '个证件类型不能为空','提示消息');
					return false;
				}
				if (value.licnceNo() == '') {
					passValidate = false;
					top.jAlert('error', '第' + num + '个证件号不能为空','提示消息');
					return false;
				}
				if (value.validEndDate() == '') {
					passValidate = false;
					top.jAlert('error', '第' + num + '个截止日期不能为空','提示消息');
					return false;
				}
			});
			if (!passValidate) {
				return;
			}
		}
		// 提交表单
		$.ajax({
			type : "post",
			async : false,
			url : ctx + "/supplier/company/updateSupCompany",
			dataType : "json",
			data : {
				'comNo' : viewModel.comNo(),
				'unifmNo' : viewModel.unifmNo(),
				'comName' : viewModel.comName(),
				'comEnName' : viewModel.comEnName(),
				'comGrpVO.comgrpNo' : viewModel.comgrpNo(),
				'econType' : viewModel.econType(),
				'legalRpstv' : viewModel.legalRpstv(),
				'bizScopeDesc' : viewModel.bizScopeDesc(),
				'setupDate' : viewModel.setupDate(),
				'comRegstrAddress.provName' : viewModel.regProvName(),
				'comRegstrAddress.cityName' : viewModel.regCityName(),
				'comRegstrAddress.detllAddr' : viewModel.regDetllAddr(),
				'comRegstrAddress.areaCode' : viewModel.regAreaCode(),
				'comRegstrAddress.moblNo' : viewModel.regMoblNo(),
				'comRegstrAddress.emailAddr' : viewModel.regEmailAddr(),
				'webSite' : viewModel.webSite(),
				'invDlvryAddress.provName' : viewModel.dlvProvName(),
				'invDlvryAddress.cityName' : viewModel.dlvCityName(),
				'invDlvryAddress.detllAddr' : viewModel.dlvDetllAddr(),
				'invDlvryAddress.postCode' : viewModel.dlvPostCode(),
				'invDlvryAddress.cntctName': viewModel.dlvCntctName(),
				//'invDlvryAddress.areaCode' : viewModel.dlvFaxAreaCode,
				'invDlvryAddress.faxNo' : viewModel.dlvFaxNo(),
				'invDlvryAddress.areaCode' : viewModel.dlvAreaCode(),
				'invDlvryAddress.moblNo' : viewModel.dlvMoblNo(),
				'invDlvryAddress.phoneNo' : viewModel.dlvPhoneNo(),
				'invDlvryAddress.emailAddr' :viewModel.dlvEmailAddr(),
				'lawNote' : viewModel.lawNote(),				
				'debtNote' : viewModel.debtNote(),				
				'credtNote' : viewModel.credtNote(),			
				'comLicencesList' : ko.toJSON(self.comLicencesList())			
			},
			success : function(data) {
				if (data) {
					top.jAlert('success','操作成功','提示消息');
				} else {
					top.jAlert('success','操作失败','提示消息');
				}
		}});
	};

}
var viewModel = new ViewModel();
ko.applyBindings(viewModel);
$(function() {
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
                    <div class="CM-bar"><div>基本信息</div></div>
                    <div class="CM-div">
                    <table class="CM_table">
                        <tr>
                            <td style="width:25%;"><span>*公司编号</span></td>
                            <td><input type="text" class="inputText twoInput1 Black " id="comNo" name="comNo" value="${supCompany.comNo }"/>
                            </td>
                        </tr>
                        <tr>
                            <td><span>*<!-- 税号 --><auchan:i18n id="102006075"/></span></td>
                            <td><input type="text" class="inputText fl_left" style="width:44%" id="unifmNo" name="unifmNo" value="${supCompany.unifmNo }"/>
                                <span style="float:left;margin-right:1px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 状态 --><auchan:i18n id="102008013"/></span>
                                <input type="text" class="Black inputText twoInput2"   id="unifmNo" name="unifmNo" value="${supCompany.status}"/>
                            </td>
                        </tr>
                        <tr>
                            <td><span>*公司名称</span></td>
                            <td><input type="text" class="inputText w91_s232"  id="comName" name="comName" value="${supCompany.comName }"/></td>
                        </tr>
                        <tr>
                            <td><span>公司英文名</span></td>
                            <td><input type="text" class="inputText w91_s232"  id="comEnName" name="comEnName" value="${supCompany.comEnName }"/></td>
                        </tr>
                        <tr>
                            <td><span>*集团</span></td>
                            <td><div class="iconPut" style="width:28%;float:left;">
                            		<input type="text" style="width:80%"  id="comgrpNo" name="comgrpNo" value="${supCompany.comGrpVO.comgrpNo }"/>
                            	<div class="ListWin" >
                            	</div>
                            	</div>
                                    <input type="text" class="Black inputText twoinput20" id="comgrpName" name="comgrpName" value="${supCompany.comGrpVO.comgrpName}"/></td>
                        </tr>
                        <tr>
                            <td><span>*公司类型</span></td>
                            <td><select style="width:42%;float:left;"  id="comNo" name="econType" >
                            	<option value="${supCompany.econType }" <c:if test="${supCompany.econType == 1}">selected="selected"</c:if> >有限公司</option>
                            	<option value="${supCompany.econType }" <c:if test="${supCompany.econType == 2}">selected="selected"</c:if>>股份有限责任公司</option>
                            	<option value="${supCompany.econType }" <c:if test="${supCompany.econType == 3}">selected="selected"</c:if>>个人独资企业</option>
                            	<option value="${supCompany.econType }" <c:if test="${supCompany.econType == 4}">selected="selected"</c:if>>合伙企业</option>
                            </select>
                            <span style="float:left;margin-right:2px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;法人代表</span>
                            <input type="text" class="inputText twoinput21"  id="legalRpstv" name="legalRpstv" value="${supCompany.legalRpstv }"/></td>
                        </tr>
                        <tr>
                            <td><span>*经营范围</span></td>
                            <td><input type="text" class="inputText w91_s232"  data-bind="value:viewModel.bizScopeDesc" id="bizScopeDesc" name="bizScopeDesc" value="${supCompany.bizScopeDesc }"/></td>
                        </tr>
                        <tr>
                            <td><span>*成立日期</span></td>
                            <td><div class="iconPut" style="width:28%;"><input type="text" class="w80" data-bind="value:viewModel.setupDate" id="setupDate" name="setupDate" value="${supCompany.setupDate }"/><div class="C_Func Calendar"></div> </div></td>
                        </tr>
                        <tr>
                            <td><span>*注册城市</span></td>
                            <td>
<%--                             	<input type="text" class="inputText twoInput1" style="width:20%;" data-bind="value:viewModel.regProvName" id="comNo" name="firmNumber" value="${supCompany.comNo }"/>
                                <div class="iconPut" style="width:28%;float:left; margin-left:3px;">
                                <input type="text" style="width:80%"  id="comNo" name="firmNumber" value="${supCompany.comNo }"/><div class="ListWin"></div></div>
 --%>                           
 								<div class="iconPut" style="width:20%;float:left;">
 									<input type="text" value="${supCompany.comRegstrAddress.provName }" style="width:72%;"/><div style="color:#999999;"><!-- 省 --><auchan:i18n id="100000010"/></div>
                                </div>
                                <div class="iconPut" style="width:35%;float:left; margin-left:3px;">
                                    <input type="text" value="${supCompany.comRegstrAddress.cityName }" style="width:62%;"/><div style="color:#999999;"><!-- 市 --><auchan:i18n id="100000010"/></div><div class="ListWin"></div>
                                </div>
                           </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td><input type="text" class="inputText w91_s232"  id="regDetllAddr" name="regDetllAddr" value="${supCompany.comRegstrAddress.detllAddr  }"/></td>
                        </tr>
                        <tr>
                            <td><span>*电话号码</span></td>
                            <td><input type="text" class="inputText twoinput22" id="regAreaCode" value="${supCompany.comRegstrAddress.areaCode }"/><span style="float:left;margin:0;">-</span>
                                    <input type="text" class="inputText twoinput23"  id="regMoblNo" name="regMoblNo" value="${supCompany.comRegstrAddress.moblNo }"/>
                                    <span style="float:left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;电子邮箱</span>
                                    <input type="text" class="inputText twoinput24"  id="regEmailAddr" name="regEmailAddr" value="${supCompany.comRegstrAddress.emailAddr }"/></td>
                        </tr>
                        <tr>
                            <td><span>*网址</span></td>
                            <td><input type="text" class="inputText w91_s232" id="webSite" name="webSite" value="${supCompany.webSite }"/></td>
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
<%--                                <div class="iconPut" style="width:20%;float:left;">
                                 	<input type="text" style="width:72%;" data-bind="value:viewModel.dlvProvName" id="comNo" name="firmNumber" value="${supCompany.comNo }"/>
                                    <div style="color:#999999;">省</div></div>
                                <div class="iconPut" style="width:28%;float:left; margin-left:3px;">
                                    <input type="text" style="width:62%;" data-bind="value:viewModel.dlvCityName"/><div style="color:#999999;">市</div><div class="ListWin"></div></div>
 --%>
 								<div class="iconPut" style="width:20%;float:left;">
 									<input type="text" value="${supCompany.invDlvryAddress.provName }" style="width:72%;"/><div style="color:#999999;"><!-- 省 --><auchan:i18n id="100000010"/></div>
                                </div>
                                <div class="iconPut" style="width:35%;float:left; margin-left:3px;">
                                    <input type="text" value="${supCompany.invDlvryAddress.cityName }" style="width:62%;"/><div style="color:#999999;"><!-- 市 --><auchan:i18n id="100000010"/></div><div class="ListWin cityselected"></div>
                                </div>                            	
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td><input type="text" class="inputText w91_s232"  id="dlvDetllAddr" value="${supCompany.invDlvryAddress.detllAddr }"/></td>
                        </tr>
                        <tr>
                            <td><span><!-- 邮政编码 --><auchan:i18n id="102006015"/></span></td>
                            <td>
                            	<input type="text" class="inputText twoinput25" id="dlvPostCode" value="${supCompany.invDlvryAddress.postCode }"/>
                                <span style="float:left;margin:0;">&nbsp;&nbsp;&nbsp;<!-- 联系人 --><auchan:i18n id="102006016"/>&nbsp;</span>
                                <input type="text" class="inputText twoinput25" id="dlvCntctName"  value="${supCompany.invDlvryAddress.cntctName }"/>
                                <span style="float:left;margin:0;">&nbsp;&nbsp;&nbsp;<!-- 传真 --><auchan:i18n id="102006017"/>&nbsp;</span>
                                <input type="text" class="inputText twoinput22" /><span style="float:left;margin:0;">-</span>
                                <input type="text" class="inputText twoinput23" id="dlvFaxNo"  value="${supCompany.invDlvryAddress.faxNo }"/>
                            </td>
                        </tr>
                        <tr>
                            <td><span>电话号码</span></td>
                            <td>
                            	<input type="text" class="inputText twoinput22" />
                            		<span style="float:left;margin:0;">-</span>
                                <input type="text" class="inputText twoinput26" id="dlvMoblNo" name="dlvMoblNo" value="${supCompany.invDlvryAddress.moblNo }"/>
                                <span style="float:left;margin:0;">&nbsp;&nbsp;手机</span>
                                    <input type="text" class="inputText twoinput27"  id="dlvPhoneNo" name="dlvPhoneNo" value="${supCompany.invDlvryAddress.phoneNo }"/>
                                <span style="float:left;margin:0;">&nbsp;&nbsp;邮箱</span>
                                    <input type="text" class="inputText twoinput28"  id="dlvEmailAddr" name="dlvEmailAddr" value="${supCompany.invDlvryAddress.emailAddr }"/>
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
                            <td><input type="text" class="inputText w50" data-bind="value:viewModel.lawNote" id="lawNote" name="lawNote" value="${supCompany.lawNote }"/></td>
                        </tr>
                        <tr>
                            <td><span>呆账催收注记</span></td>
                            <td><input type="text" class="inputText w50" data-bind="value:viewModel.debtNote" id="debtNote" name="debtNote" value="${supCompany.debtNote }"/></td>
                        </tr>
                        <tr>
                            <td><span>信用状况注记</span></td>
                            <td><input type="text" class="inputText w50" data-bind="value:viewModel.credtNote" id="credtNote" name="credtNote" value="${supCompany.credtNote }"/></td>
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
                                    <div>截止日期</div>
                                </div>
                            </td>
                        </tr>
                        <tr><td class="line"></td></tr>
                        <tr>
                            <td style="height:335px;">
                                <div style="height:100%;overflow-x:hidden;overflow-y:scroll;">
                                <div class="CM-div">
                                    <table style="width:100%;height:55px; overflow:scroll">
                                    <c:forEach items="${supCompany.comLicences }" var="comLicenceVO">
                                    	<tr>
											<td style="width: 5%;">
												<input type="checkbox" value="${comLicenceVO.licnceId }" />
											</td>
											<td style="width: 6%;">
												<div style="height:20px;width:20px;border:1px solid #999999;" class="license1"></div>
											</td>
											<!--class="license1"-->
											<td style="width: 37%;">
	                                            	<select style="width:92%;" data-bind="value:licnceType" id="licnceType" name="licnceType" >
	                                            		<option >请选择</option>
	                                            		<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==1}">selected="selected"</c:if>>营业执照</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==2}">selected="selected"</c:if>>组织机构代码证</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==3}">selected="selected"</c:if>>税务登记证</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==4}">selected="selected"</c:if>>卫生许可证</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==5}">selected="selected"</c:if>>QS</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==6}">selected="selected"</c:if>>自产自销证明</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==7}">selected="selected"</c:if>>开户许可证</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==8}">selected="selected"</c:if>>3C证</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==9}">selected="selected"</c:if>>流通许可证</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==10}">selected="selected"</c:if>>商品条码证书</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==11}">selected="selected"</c:if>>有机证书</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==12}">selected="selected"</c:if>>有机转化证书</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==13}">selected="selected"</c:if>>绿色证书</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==14}">selected="selected"</c:if>>功能性食品检测报告</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==15}">selected="selected"</c:if>>地区代理授权书</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==16}">selected="selected"</c:if>>商标注册证</option>
														<option value="${comLicenceVO.licnceType}" <c:if test="${comLicenceVO.licnceType ==17}">selected="selected"</c:if>>品牌授权书</option>
	                                            	</select>											
											</td>
											<td style="width: 30%;">
												<input value="${comLicenceVO.licnceNo }" type="text" class="inputText w90" />
											</td>
											<td style="width: 22%;">
												<div class="iconPut w90">
													<input value='<fmt:formatDate pattern="yyyy-MM-dd" value="${comLicenceVO.validEndDate }"/>' type="text" style="width: 90%" />
												</div>
											</td>
										</tr>
                                    </c:forEach>
                                    </table>
                                </div>
                                </div>
                            </td>
                        </tr>
                        <tr><td class="line"></td></tr>
                        <tr><td>
                            <input type="checkbox" style="float:left;"/>
                                <div class="Icon-size2 Tools10_disable fl_left" style="margin-left:10px;"></div>
                                <div class="Line-1 Icon-size2 fl_left"  ></div>
                                <div class="Tools11 Icon-size2 fl_left" ></div>
                            </td></tr>
                    </table>
                	</div>
                </div>
            </div>
        </div>
</div>
