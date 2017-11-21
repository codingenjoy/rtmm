<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/page/commons/knockout.jsp" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css" rel="Stylesheet" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" rel="Stylesheet" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" rel="Stylesheet" />
<script src="${ctx}/shared/js/supplier/company.js" charset="UTF-8" type="text/javascript"></script>

<script type="text/javascript">
var itemsPic= new Array();//当前单个证件下所有的证件图片信息
var itemIndex=0;
	$(function() {
		
		if ("${locale }" == "en") {
			$(".Container").addClass("en");
		}
		itemsPic=new Array(); //清空图片信息
		
		$('#supCompanyContext').find("input").attr("readonly","readonly");
		$('#supCompanyContext').find(":checkbox").attr("disabled","disabled");
		$('#supCompanyContext').find("select").attr("disabled","disabled");
		supplier_comNo = $("#comNo").val();
		supplier_comName = $("#comName").val();
		
	});

	$("#closePicBtn").live("click", function () {
        $("#read_p").css("display", "none");
    });
	$("#read_prev_brower").live("mouseover", function () {
        $(this).addClass("prev_brower_bg");
    });
    $("#read_prev_brower").live("mouseout", function () {
        $(this).removeClass("prev_brower_bg");
    });
    $("#read_next_brower").live("mouseover", function () {
        $(this).addClass("next_brower_bg");
    });
    $("#read_next_brower").live("mouseout", function () {
        $(this).removeClass("next_brower_bg");
    });

  	$("#read_next_brower").unbind("click").bind(
			"click",
			function() {
				$("#read_pp3").empty();
				if (typeof (itemsPic[itemIndex + 1]) != 'undefined'
						|| itemsPic[itemIndex + 1] != null) {
					itemIndex = itemIndex + 1;
					loadImgInfos(itemsPic[itemIndex]);
					$("#read_pp3").text(
							"当前第" + (itemIndex + 1) + "张，共"
									+ itemsPic.length + "张");
				} else {
					$("#read_pp3").text("已经到最后一张了");
				}
			});

	$("#read_prev_brower").unbind("click").bind(
			"click",
			function() {
				$("#read_pp3").empty();
				if (typeof (itemsPic[itemIndex - 1]) != 'undefined'
						|| itemsPic[itemIndex - 1] != null) {
					$("#read_pp3").text(
							"当前第" + itemIndex + "张，共"
									+ itemsPic.length + "张");
					itemIndex = itemIndex - 1;
					loadImgInfos(itemsPic[itemIndex]);
				} else {
					$("#read_pp3").text("已经是第一张了");
				}
			});
 
    
    
     function loadImgInfos(key){
    	 $("#read_pp2").empty();
         $("#read_pp2").attr("src",key);
	
         }
    
	   //加载信息
    function readPhotoListByLincenceId(lincenceId){
    	 $("#read_pp3").empty();
		   var width_window=$(window).width();
		   var height_window=$(document).height();
				itemsPic=new Array(); 
				itemIndex=0;
		 $.ajax({
				url :'${ctx}/supplierLicenceAction/readComGroupLicenceByLicenceId?tt='
						+ new Date().getTime(),
				data : {licnceId:lincenceId},
				type : 'POST',
				success : function(response) {
					if(response!=""){
				$("#read_p").css({"display":"block","width":width_window,"height":height_window,"top":0,"left":0});							 
                 
				$(response).each(function(index,item){
					  itemsPic.push(ufs+item.licncePicFileId); 
						});	
					loadImgInfos(itemsPic[0]);	
					$("#read_pp3").text(
							"当前第1张，共"
									+ itemsPic.length + "张");					
					}				
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					top.jAlert('error', '网络超时!请稍后重试', window.v_messages);
				}
			});
		 
   	   //$("#baseComImginfo").empty();
       //$("#baseComImginfo").load("${ctx}/supplierLicenceAction/readComGroupLicence?licnceId="+lincenceId);
        };
    
        
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
            background: #fff;
        }
        .twoinput22 {
            width: 10%;
            float: left;
            background: #fff;
        }
        .twoinput23 {
            width: 25%;
            float: left;
            background: #fff;
        }
        .twoinput24 {
            width: 33%;width/*\**/:33%\9;*width:33.3%;
            float: left;
            background: #fff;
        }
        .twoinput25 {
            width: 14.5%;
            float: left;
            background: #fff;
        }
        .twoinput26 {
            width: 16%;
            float: left;
            background: #fff;
        }
        .twoinput27 {
            width: 25%;
            float: left;
            background: #fff;
        }
        .twoinput28 {
            width: 20%;width/*\**/:20.5%\9;*width:20%;
            float: left;
            background: #fff;
        }
    </style>
        <div class="Content" style="width:99%;" id="baseComImginfo"><!--width:74%;-->
	        <div class="CInfo hide">
				<span><auchan:getStuffName value="${supCompany.chngBy }"/></span>
				<span><auchan:i18n id="100002014"></auchan:i18n></span><!-- 修改人 -->
				<span><fmt:formatDate pattern="yyyy-MM-dd" value="${supCompany.chngDate }"/></span>
				<span><auchan:i18n id="100002015"></auchan:i18n></span><!-- 修改日期 -->
				<span><auchan:getStuffName value="${supCompany.creatBy }"/></span>
				<span><auchan:i18n id="100002016"></auchan:i18n></span><!-- 建档人 -->
				<span><fmt:formatDate pattern="yyyy-MM-dd" value="${supCompany.creatDate }"/></span>
				<span><auchan:i18n id="102002010"></auchan:i18n></span>
			</div>
            <div class="line" style="width:100%"></div>
            <div class="t_div1" style="width:50%;height:539px; float:left;">
                <div class="CM t_div1_1">
                    <div class="CM-bar"><div><auchan:i18n id="102004033"></auchan:i18n></div></div>
                    <div class="CM-div">
                    <table class="CM_table">
                        <tr>
                            <td style="width:25%;"><span>*<auchan:i18n id="102002002"></auchan:i18n></span></td>
                            <td><input type="text" class="inputText twoInput1 Black " id="comNo" name="comNo" value="${supCompany.comNo }"/>
                            </td>
                        </tr>
                        <tr>
                            <td><span>*<auchan:i18n id="102004008"></auchan:i18n></span></td>
                            <td><input type="text" class="inputText fl_left" style="width:44%" id="unifmNo" name="unifmNo" value="${supCompany.unifmNo }"/>
                                <span style="float:left;margin-right:1px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态</span>
                                <%-- <input type="text" class="Black inputText twoInput2"   id="unifmNo" name="unifmNo" value="${supCompany.status}"/> --%>
                            	<select class="Black" style="width: 26%; float: left;" id="unifmNo" name="unifmNo" disabled="disabled">
									<option value="0" <c:if test="${supCompany.status == 0}">selected="selected"</c:if>>0-尚未生效</option>
									<option value="1" <c:if test="${supCompany.status == 1}">selected="selected"</c:if>>1-正常</option>
									<option value="9" <c:if test="${supCompany.status == 9}">selected="selected"</c:if>>9-删除</option>
								</select> 
                            </td>
                        </tr>
                        <tr>
                            <td><span>*<auchan:i18n id="102002003"></auchan:i18n></span></td>
                            <td><input type="text" class="inputText w94"  id="comName" name="comName" value="${supCompany.comName }"/></td>
                        </tr>
                        <tr>
                            <td><span><auchan:i18n id="102002004"></auchan:i18n></span></td>
                            <td><input type="text" class="inputText w94"  id="comEnName" name="comEnName" value="${supCompany.comEnName }"/></td>
                        </tr>
                        <tr>
                            <td><span><auchan:i18n id="102002006"></auchan:i18n></span></td>
                            <td><div class="iconPut" style="width:28%;float:left;">
                            		<input type="text" style="width:80%"  id="comgrpNo" name="comgrpNo" value="${supCompany.comGrpVO.comgrpNo }"/>
                            	<div class="ListWin" >
                            	</div>
                            	</div>
                                    <input type="text" class="Black inputText twoinput20" id="comgrpName" name="comgrpName" value="${supCompany.comGrpVO.comgrpName}"/></td>
                        </tr>
                        <tr>
                            <td><span>*<auchan:i18n id="102002007"></auchan:i18n></span></td>
                            <td><select style="width:42%;float:left;"  id="comNo" name="econType" >
                            	<option value="${supCompany.econType }" <c:if test="${supCompany.econType == 1}">selected="selected"</c:if> >有限公司</option>
                            	<option value="${supCompany.econType }" <c:if test="${supCompany.econType == 2}">selected="selected"</c:if>>股份有限责任公司</option>
                            	<option value="${supCompany.econType }" <c:if test="${supCompany.econType == 3}">selected="selected"</c:if>>个人独资企业</option>
                            	<option value="${supCompany.econType }" <c:if test="${supCompany.econType == 4}">selected="selected"</c:if>>合伙企业</option>
                            </select>
                            <span style="float:left;margin-right:2px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<auchan:i18n id="102004010"></auchan:i18n></span>
                            <input type="text" class="inputText twoinput21"  id="legalRpstv" name="legalRpstv" value="${supCompany.legalRpstv }"/></td>
                        </tr>
                        <tr>
                            <td><span>*<auchan:i18n id="102004012"></auchan:i18n></span></td>
                            <td><input type="text" class="inputText"  data-bind="value:viewModel.bizScopeDesc" id="bizScopeDesc" name="bizScopeDesc" value="${supCompany.bizScopeDesc }"/></td>
                        </tr>
                        <tr>
                            <td><span>*<auchan:i18n id="102004013"></auchan:i18n></span></td>
                            <td>
                            	<div class="iconPut" style="width:28%;">
                            		<input type="text" class="w80" data-bind="value:viewModel.setupDate" id="setupDate" name="setupDate" 
                            		value="<fmt:formatDate pattern="yyyy-MM-dd" value="${supCompany.setupDate }"/>"
                            		/>
                            	<div class="C_Func Calendar"></div> 
                            	</div>
                            </td>
                        </tr>
                        <tr>
                            <td><span>*<auchan:i18n id="102004009"></auchan:i18n></span></td>
                            <td>
 								<div class="iconPut" style="width:20%;float:left;">
 									<input type="text" value="${supCompany.comRegstrAddress.provName }" style="width:72%;"/><div style="color:#999999;">省</div>
                                </div>
                                <div class="iconPut" style="width:35%;float:left; margin-left:3px;">
                                    <input type="text" value="${supCompany.comRegstrAddress.cityName }" style="width:62%;"/><div style="color:#999999;">市</div><div class="ListWin"></div>
                                </div>
                           </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td><input type="text" class="inputText w94"  id="regDetllAddr" name="regDetllAddr" value="${supCompany.comRegstrAddress.detllAddr  }"/></td>
                        </tr>
                        <tr>
                            <td><span>*<auchan:i18n id="102004014"></auchan:i18n></span></td>
                            <td><input type="text" class="inputText twoinput22" id="regAreaCode" value="${supCompany.comRegstrAddress.areaCode }"/><span style="float:left;margin:0;">-</span>
                                    <input type="text" class="inputText twoinput23"  id="regPhoneNo" name="regPhoneNo" value="${supCompany.comRegstrAddress.phoneNo }"/>
                                    <span style="float:left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<auchan:i18n id="102004015"></auchan:i18n></span>
                                    <input type="text" class="inputText twoinput24"  id="regEmailAddr" name="regEmailAddr" value="${supCompany.comRegstrAddress.emailAddr }"/></td>
                        </tr>
                        <tr>
                            <td><span>*<auchan:i18n id="102004016"></auchan:i18n></span></td>
                            <td><input type="text" class="inputText w94" id="webSite" name="webSite" value="${supCompany.webSite }"/></td>
                        </tr>
                    </table>
               		</div>
                </div>
                <div class="CM t_div1_2">
                    <div class="CM-bar"><div><auchan:i18n id="102004017"></auchan:i18n></div></div>
                    <div class="CM-div">
                    <table class="CM_table">
                        <tr>
                            <td style="width:25%;"><span>*<auchan:i18n id="102004017"></auchan:i18n></span></td>
                            <td>
 								<div class="iconPut" style="width:20%;float:left;">
 									<input type="text" value="${supCompany.invDlvryAddress.provName }" style="width:72%;"/><div style="color:#999999;">省</div>
                                </div>
                                <div class="iconPut" style="width:35%;float:left; margin-left:3px;">
                                    <input type="text" value="${supCompany.invDlvryAddress.cityName }" style="width:62%;"/><div style="color:#999999;">市</div><div class="ListWin cityselected"></div>
                                </div>                            	
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td><input type="text" class="inputText w94"  id="dlvDetllAddr" value="${supCompany.invDlvryAddress.detllAddr }"/></td>
                        </tr>
                        <tr>
                            <td><span><auchan:i18n id="102004018"></auchan:i18n></span></td>
                            <td>
                            	<input type="text" class="inputText twoinput25" id="dlvPostCode" value="${supCompany.invDlvryAddress.postCode }"/>
                                <span style="float:left;margin:0;">&nbsp;&nbsp;&nbsp;<auchan:i18n id="102004019"></auchan:i18n>&nbsp;</span>
                                <input type="text" class="inputText twoinput25" id="dlvCntctName"  value="${supCompany.invDlvryAddress.cntctName }"/>
                                <span style="float:left;margin:0;">&nbsp;&nbsp;&nbsp;<auchan:i18n id="102004020"></auchan:i18n>&nbsp;</span>
                                <input type="text" class="inputText twoinput22" value="${supCompany.invDlvryAddress.areaCode }"/><span style="float:left;margin:0;">-</span>
                                <input type="text" class="inputText twoinput23" id="dlvFaxNo"  value="${supCompany.invDlvryAddress.faxNo }"/>
                            </td>
                        </tr>
                        <tr>
                            <td><span><auchan:i18n id="102004014"></auchan:i18n></span></td>
                            <td>
                            	<input type="text" class="inputText twoinput22" id="dlvAreaCode" name="dlvAreaCode" value="${supCompany.invDlvryAddress.areaCode }"/>
                            		<span style="float:left;margin:0;">-</span>
                                <input type="text" class="inputText twoinput26" id="dlvPhoneNo" name="dlvPhoneNo" value="${supCompany.invDlvryAddress.phoneNo }"/>
                                <span style="float:left;margin:0;">&nbsp;&nbsp;<auchan:i18n id="102004021"></auchan:i18n></span>
                                    <input type="text" class="inputText twoinput27"  id="dlvMoblNo" name="dlvMoblNo" value="${supCompany.invDlvryAddress.moblNo }"/>
                                <span style="float:left;margin:0;">&nbsp;&nbsp;<auchan:i18n id="102004015"></auchan:i18n></span>
                                    <input type="text" class="inputText twoinput28"  id="dlvEmailAddr" name="dlvEmailAddr" value="${supCompany.invDlvryAddress.emailAddr }"/>
                            </td>
                        </tr>
                        
                    </table>
                	</div>
                </div>
            </div>
            <div class="t_div2">
                <div class="CM t_div2_1" style="height:120px;">
                    <div class="CM-bar"><div><auchan:i18n id="102004034"></auchan:i18n></div></div>
                    <div class="CM-div">
                    <table class="CM_table">
                        <tr>
                            <td style="width:25%;"><span><auchan:i18n id="102004025"></auchan:i18n></span></td>
                            <td><input type="text" class="inputText w50" data-bind="value:viewModel.lawNote" id="lawNote" name="lawNote" value="${supCompany.lawNote }"/></td>
                        </tr>
                        <tr>
                            <td><span><auchan:i18n id="102004026"></auchan:i18n></span></td>
                            <td><input type="text" class="inputText w50" data-bind="value:viewModel.debtNote" id="debtNote" name="debtNote" value="${supCompany.debtNote }"/></td>
                        </tr>
                        <tr>
                            <td><span><auchan:i18n id="102004027"></auchan:i18n></span></td>
                            <td><input type="text" class="inputText w50" data-bind="value:viewModel.credtNote" id="credtNote" name="credtNote" value="${supCompany.credtNote }"/></td>
                        </tr>
                    </table>
                	</div>
                </div>
                <div class="CM t_div2_2">
				<div class="CM-bar">
					<div><auchan:i18n id="102004035"></auchan:i18n></div>
				</div>
				<div class="CM-div">
					<table class="CM_table" style="width:470px; margin-left: 10px;">
						<tr><td style="height:370px;">
						<div style="height:100%;width:450px;overflow-x:auto;overflow-y:auto;">
						<table style="width:880px;">
						<tr>
							<td style="width: 30px;">&nbsp;</td>
							<td style="width: 40px;">&nbsp;</td>
							<td style="width: 180px;"><auchan:i18n id="102004028"></auchan:i18n></td>
							<td style="width: 180px;"><auchan:i18n id="102004029"></auchan:i18n></td>
							<td style="width: 150px;"><auchan:i18n id="102004031"></auchan:i18n></td>
							<td style="width: 150px;"><auchan:i18n id="102004030"></auchan:i18n></td>
							<td style="width: 150px;"><auchan:i18n id="102004032"></auchan:i18n></td>
						</tr>
						<tr>
							<td class="line" colspan="7"></td>
						</tr>
						<tbody>
						<c:forEach items="${supCompany.comLicences }" var="comLicenceVO">
						<tr>
							<td>
								<input type="checkbox" />
							</td>
							
							<td ><div style="height: 20px; width: 20px; border: 1px solid #999999;" onclick="readPhotoListByLincenceId('${comLicenceVO.licnceId}')" class="license1"></div></td>
							<td >
								<auchan:select  mdgroup="COM_LICENCE_LICNCE_TYPE" style="width: 90%;" value="${comLicenceVO.licnceType }"></auchan:select>
							</td>
							<td >
								<input type="text" style="width: 90%;" class="inputText" value="${comLicenceVO.licnceNo }"/>
							</td>
							<td >
								<div class="iconPut w90">
									<input type="text" style="width: 70%" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${comLicenceVO.validStartDate }"/>"/>
								</div>
							</td>
							<td >
								<div class="iconPut w90">
									<input type="text" style="width: 70%" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${comLicenceVO.validEndDate }"/>" />
								</div>
							</td>
							<td >
								<div class="iconPut w90">
									<input type="text" style="width: 70%"  value="${comLicenceVO.issueBy }"/>
								</div>
							</td>
						</tr>
						</c:forEach>
						</tbody>
						</table>
						</div>
						</td></tr>
						<tr>
							<td class="line"></td>
						</tr>
					</table>
				</div>
			</div>
            </div>
        </div>

 <div id="read_p"  class="_p">
        <div id="read_p_brower" class="p_brower" style="border:2px solid #3f9673;">
             <div class="zwindow_titleBar" style="height: 40px;position:relative;"><div class="zwindow_titleButtonBar"><div id="closePicBtn" class="zwindow_action_button zwindow_close"></div></div><div class="zwindow_title titleText">浏览图片信息</div></div>                 
            <div id="read_prev_brower" class="prev_brower"></div>
            <div id="read_pp" class="pp">             
                <img src="" id="read_pp2" alt="" class="pp2"/>
                <div id="read_pp3" class="pp3"></div>
            </div>
            <div id="read_next_brower" class="next_brower"></div>
        </div>
    </div>