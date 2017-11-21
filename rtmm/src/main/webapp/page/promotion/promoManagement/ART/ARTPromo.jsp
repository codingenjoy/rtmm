<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/js/loading/loading.css" /> 
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/iframeContent.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/loading/loading.js" charset="utf-8"></script> 
<script type="text/javascript" src="${ctx}/shared/js/common.js" charset="utf-8"></script>	
<script type="text/javascript" src="${ctx}/shared/js/iframeContent.js" charset="utf-8"></script>
<script type="text/javascript"> 

$(function (){
	pageQuery(0);
	DispOrHid('B-id');
	$("#Tools11").removeClass("Tools11_disable");
	$("#Tools11").addClass("Icon-size1 Tools11");
	$("#Tools21").attr('class', "Icon-size1 Tools21_on");
	$($("#Tools21").parent()).addClass("ToolsBg");
	
	$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind(
		"click", function() {
			DispOrHid('B-id');
	});
		
	$("#Tools11").live("click",function(){
		$(top.document).find("#contentIframe").attr("src",ctx + '/prom/nondm/art/createARTPromo');
		//window.location.href=ctx + '/prom/nondm/art/createARTPromo';
	});
	
	
	$('.Tools20').live("click",function(){
		$("#unitNo").die("change");
		$(".cleanInput").val("");
		$(".cleanSelect").val("");
	});
	
	/* onkeydown="enterShow(event)" */
    document.onkeydown = function(e) {
		enterShow(e) ;
	} 

});


function pageQuery(flag){
	//var jump = '${jump}';
	var pageSize = $("#pageSize").val();
	var pageNo = $("#pageNo").val();
	var jump = $("#jump").val();
	if(pageSize == null || pageSize == ""){
		pageSize = 20;
	}
	if(pageNo == null || pageNo == "" || flag == 1){
		pageNo =1;
	}
	if(jump != null && jump=="jump"){
		$("#pSize").val('${page.pageSize}');
		$("#pNo").val('${page.pageNo}');
		$("#pageSize").val('${page.pageSize}');
		$("#pageNo").val('${page.pageNo}');
		var sectionNo =$("#CatlgId").val();
		var unitNo = $("#unitNo").val();
		var unitType = $.trim($("#unitType").val());
		if(sectionNo !=null && sectionNo !=""){
			pr_searchSectionMess(sectionNo);
		}
		if(unitNo !=null && unitNo !=""){
			pr_searchPromUnitName(unitNo,unitType);
		}
		$("#jump").val("");
	}else{
		$("#pSize").val(pageSize);
		$("#pNo").val(pageNo);
	}
	
	var unitNo = $.trim($("#unitNo").val());
	if(unitNo !=null && unitNo !=""){
		if(!isNumber(unitNo)){
			top.jWarningAlert('输入代号有误！');
			$("#unitNo").val('');
			$("#unitName").val('');
			return;
		}
	}
	var sectionNo = $.trim($("#CatlgId").val());
	if(sectionNo !=null && sectionNo !=""){
		if(!isNumber(sectionNo)){
			top.jWarningAlert('输入课别有误');
			$("#CatlgId").val('');
			$("#CatlgName").val('');
			return;
		}
	}
	
	var promNo = $("#promNo").val();
	if(promNo !=null && promNo !=""){
		if(!isNumber(promNo)){
			top.jWarningAlert('输入促销期数有误');
			$("#promNo").val('');
			return;
		}
	}
	var ARTPromoForm = $("#ARTPromoForm").serialize();
	$.ajax({
		url: ctx + '/prom/nondm/art/searchARTPromoList',
        type: "post",
        dataType:"html",
        data:ARTPromoForm,
        success: function(data) {
        	$("#Tools10").removeClass("Icon-size1 Tools10");
			$("#Tools10").addClass("Tools10_disable");
 			$("#ARTPromoListDiv").html(data);
        }
	});
}


//手动输入课别
$("#CatlgId").die("blur").live("blur",function(){
	var sectionNo = $.trim($(this).val());
	if(!isNumber(sectionNo)){
		top.jWarningAlert('输入课别有误');
		$("#CatlgId").val('');
		$("#CatlgName").val('');
		return;
	}
	
	if(sectionNo==""){
		$("#CatlgId").val('');
		$("#CatlgName").val('');
		return;
	}
	if(sectionNo){
		pr_searchSectionMess(sectionNo);
	}
});



//手动输入代号
$("#unitNo").die("change").live("change",function(){
	var unitNo = $.trim($(this).val());
	var unitType = $.trim($("#unitType").val());
	if(unitType ==""){
		top.jWarningAlert('请选择代号类别 ！');
		$("#unitNo").val('');
		$("#unitName").val('');
		return;
		
	}
	if(!isNumber(unitNo)){
		top.jWarningAlert('输入代号有误！');
		$("#unitNo").val('');
		$("#unitName").val('');
		return;
	}
	
	if(unitNo==""){
		$("#unitNo").val('');
		$("#unitName").val('');
		return;
	}
	if(unitNo){
		pr_searchPromUnitName(unitNo,unitType);
	}
});


//手动查询课别
function pr_searchSectionMess(sectionNo){
	$.ajax( {
		type : 'post',
		beforeSend:function(){
			grid_layer_open();
		},
		url : ctx + '/catalog/searchSectionMessAction',
		data : {
			catlgId : sectionNo},
		success : function(data) {
			grid_layer_close();
			var sectionInfoVO = data.sectionInfoVO;
			if (sectionInfoVO != null) {
				/* if($("#CatlgId").val()==""){
					$("#CatlgName").val('');
				}else{ */
					$("#CatlgName").val(sectionInfoVO.catlgName);
				/* } */
	 			
			} else {
				top.jWarningAlert("没有找到对应信息, 请重新输入");
				$("#CatlgName").val('');
				$("#CatlgId").val('');
			}
		}
	});
}

//手动查询代号
function pr_searchPromUnitName(unitNo,unitType){
	$.ajax( {
		type : 'post',
		beforeSend:function(){
			grid_layer_open();
		},
		url : ctx + '/prom/nondm/ho/searchPromUnitNameAction',
		data : {itemNo : unitNo,unitType : unitType},
		success : function(data) {
			grid_layer_close();
			if (data.unitName != "") {
	 			$("#unitName").val(data.unitName);
	 			$("#unitName").attr("title",data.unitName);
			} else {
				top.jWarningAlert("没有找到对应信息, 请重新输入");
				$("#unitNo").val('');
				$("#unitName").val('');
			}
		}
	});
}

function isNumber(param){  
    var reg = new RegExp("^[0-9]*$"); 
    if($.trim(param)=='')
    {
    	return true;
    }
    if(!reg.test(param)){  
       return false; 
     }
    else
    {
    	return true;
    }
} 

$(".showCatlgWin").live('click',function(){
	//课别弹出框
	$(".showCatlgWin").die('click').live('click',function(){
		top.openPopupWin(602,180,'/prom/nondm/art/showCatlgWin');
	});
	
});
function addCatlgReturn(catlgId,catlgName){
	  if(catlgId&&catlgName){
		$("#CatlgId").val(catlgId);
		$("#CatlgName").val(catlgName);
	  }
	  top.closePopupWin();
	}
$(".showUnitWin").live('click',function(){
	var catlgId = $("#CatlgId").val();
	var unitType = $.trim($("#unitType").val());
	var promType = $.trim($("#pricePromType").val());
	if(unitType ==""){
		top.jWarningAlert('请选择代号类别 ！');
		$("#unitNo").val('');
		$("#unitName").val('');
		return;
	}
	top.openPopupWin(800,450, '/prom/nondm/art/showUnitWin?unitType='+unitType+'&catlgId='+catlgId+'&promType='+promType);
});


function addStoreGrpTypeReturn(data){
	if (data != undefined){
		$("#unitNo").val(data.promUnitNo);
		$("#unitName").val(data.promUnitName);
	}
	top.closePopupWin();
}
function cancel(n){
	top.window.$.zWindow.close({"close":n});
 }
 
//回车事件绑定
/* $("#searchPromotionItem").unbind("keypress").keypress(function(event){	
	var evt=event?event:(window.event?window.event:null);//兼容IE和FF
	  if (evt.keyCode==13){
		  enterShow();
	}
});  */
 
function enterShow(evt) {
	 var evt=evt?evt:(window.event?window.event:null);//兼容IE和FF
	 if (evt.keyCode==13){
		 $("#pageNo").val(1);
			var catlgId = $("#CatlgId").val();                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
			var unitNo = $("#unitNo").val();
			var unitType = $.trim($("#unitType").val());
			if(catlgId != null && catlgId != ""){
				$("#CatlgId").blur();
				pr_searchSectionMess(catlgId);
			}else{
				$("#CatlgId").val("");
				$("#CatlgName").val("");
				
			}
			if(unitNo != null && unitNo != ""){
				if(unitType !=null && unitType !=""){
					pr_searchPromUnitName(unitNo,unitType);
				}else{
					top.jWarningAlert('请选择代号类别 ！');
					return;
				}
				
			}else{
				$("#unitNo").val("");
				$("#unitName").val("");
			}
			
			pageQuery(0);
	 }else if (evt.keyCode==8){
		 return;
		 
	 }
}
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
 <div class="CTitle">
    <!--第一个-->
    <div class="tags1_left tags1_left_on"></div>
    <div class="tagsM tagsM_on">ART促销</div>
    <div class="tags tags3_r_on"></div>
</div>

<div class="Container-1">
 <form action="" id="ARTPromoForm">
	 <div class="Search Bar_on" style="margin-top:9px;"><!-- Bar_on-->
        <div class="SearchTop">
            <span>查询条件</span>
            <div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
        </div>
       
        <div class="SMiddle">
             <table class="SearchTable" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="ST_td1"><span>促销期数</span></td>
                    <td><input class="w65 inputText cleanInput" type="text" name="promNo" id="promNo" value="${promART.promNo }"/>
                    	<input type="hidden" name="pSize" id="pSize" value="${page.pageSize}"/>
                    	<input type="hidden" name="pNo" id="pNo" value="${page.pageNo}"/>
                    	<input type="hidden" name="jump" id="jump" value="${jump}"/>
                    </td>
                </tr>
                <tr>
                    <td><span>主题</span></td>
                    <td><input class="w85 inputText cleanInput" type="text" name="subjName" id="subjName" value="${promART.subjName }"/></td>
                </tr>
                <tr>
                    <td><span>课别</span></td>
                    <td><div class="iconPut w65 fl_left">
                                <input type="text" class="w80 cleanInput" name="catlgId" id="CatlgId"  onkeydown="enterShow(event)" value="${promART.catlgId }"/>
                                <div class="ListWin showCatlgWin"></div>
                            </div>
                    </td>
                </tr>
                <tr>
                    <td><span>&nbsp;</span></td>
                    <td>
                        <input class="w85 inputText Black cleanInput" type="text" id="CatlgName" />
                    </td>
                </tr>
                <tr>
                    <td><span>代号类别</span></td>
                    <td><auchan:select mdgroup="PROM_UNIT_BY_ST_UNIT_TYPE" _class="w85 cleanSelect" name="unitType" id='unitType'  value="${promART.unitType}"/></td>
                </tr>
                <tr>
                    <td><span>代号</span></td>
                    <td><div class="iconPut w65 fl_left">
                                <input type="text" class="w80 cleanInput" id="unitNo" name="unitNo"  onkeydown="enterShow(event)" value="${promART.unitNo }"/>
                                <div class="ListWin showUnitWin"></div>
                            </div>
                    </td>
                </tr>
                <tr>
                    <td><span>&nbsp;</span></td>
                    <td>
                        <input class="w85 inputText Black cleanInput" id="unitName" type="text" />
                    </td>
                </tr>
                <tr>
                    <td><span>促销类型</span></td>
                    <td><auchan:select mdgroup="PROM_STORE_ITEM_PRICE_PROM_TYPE" _class="w85 cleanSelect" name="pricePromType" id='pricePromType'  value="${promART.pricePromType }" ignoreValue="4"/></td>
                </tr> 
                <!-- <tr>
                    <td><span>组合促销</span></td>
                    <td><select class="w85" name="" ><option></option></select></td>
                </tr> -->
                <tr>
                    <td><span class="span_right">采购起始<br/>期间</span></td>
                    <td><input type="text" class="Wdate w65 cleanInput" name="buyBeginDateStart" id="buyBeginDateStart"  onclick="WdatePicker({ isShowClear: false, readOnly: true ,lang:'${calendarL}',dateFormat:'yy-MM-dd'})"  <c:if test="${promART.buyBeginDateStart !=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promART.buyBeginDateStart }" />" </c:if>/>&nbsp;-
                    </td>
                </tr>
                <tr>
                    <td><span>&nbsp;</span></td>
                    <td><input type="text" class="Wdate w65 cleanInput" name="buyBeginDateEnd" id="buyBeginDateEnd" onclick="WdatePicker({ isShowClear: false, readOnly: true,lang:'${calendarL}',dateFormat:'yy-MM-dd' })"  <c:if test="${promART.buyBeginDateEnd !=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promART.buyBeginDateEnd }" />" </c:if>/>
                    </td>
                </tr>
                <tr>
                    <td><span class="span_right">采购结束<br/>期间</span></td>
                    <td><input type="text" class="Wdate w65 cleanInput" name="buyEndDateStart" id="buyEndDateStart" onclick="WdatePicker({ isShowClear: false, readOnly: true ,lang:'${calendarL}',dateFormat:'yy-MM-dd'})" <c:if test="${promART.buyEndDateStart !=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promART.buyEndDateStart }" />" </c:if>/>&nbsp;-
                    </td>
                </tr>
                <tr>
                    <td><span>&nbsp;</span></td>
                    <td><input type="text" class="Wdate w65 cleanInput" name="buyEndDateEnd" id="buyEndDateEnd" onclick="WdatePicker({ isShowClear: false, readOnly: true,lang:'${calendarL}',dateFormat:'yy-MM-dd' })"  <c:if test="${promART.buyEndDateEnd !=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promART.buyEndDateEnd }" />" </c:if>/>
                    </td>
                </tr>
                <tr>
                    <td><span class="span_right">促销起始<br/>期间</span></td>
                    <td><input type="text" class="Wdate w65 cleanInput" name="promBeginDateStart" id="promBeginDateStart"  onclick="WdatePicker({ isShowClear: false, readOnly: true,lang:'${calendarL}',dateFormat:'yy-MM-dd' })"  <c:if test="${promART.promBeginDateStart !=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promART.promBeginDateStart }" />" </c:if>/>&nbsp;-
                    </td>
                </tr>
                <tr>
                    <td><span>&nbsp;</span></td>
                    <td><input type="text" class="Wdate w65 cleanInput" name="promBeginDateEnd"  id="promBeginDateEnd" onclick="WdatePicker({ isShowClear: false, readOnly: true,lang:'${calendarL}',dateFormat:'yy-MM-dd' })"  <c:if test="${promART.promBeginDateEnd !=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promART.promBeginDateEnd }" />" </c:if>/>
                    </td>
                </tr>
                <tr>
                    <td><span class="span_right">促销结束<br/>期间</span></td>
                    <td><input type="text" class="Wdate w65 cleanInput" name="promEndDateStart" id="promEndDateStart"  onclick="WdatePicker({ isShowClear: false, readOnly: true ,lang:'${calendarL}',dateFormat:'yy-MM-dd'})" <c:if test="${promART.promEndDateStart !=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promART.promEndDateStart }" />" </c:if>/>&nbsp;-
                    </td>
                </tr>
                <tr>
                    <td><span>&nbsp;</span></td>
                    <td><input type="text" class="Wdate w65 cleanInput" name="promEndDateEnd" id="promEndDateEnd" onclick="WdatePicker({ isShowClear: false, readOnly: true,lang:'${calendarL}',dateFormat:'yy-MM-dd' })" <c:if test="${promART.promEndDateEnd !=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promART.promEndDateEnd }" />" </c:if>/>
                    </td>
                </tr>
            </table>
        </div>
        
        <div class="line"></div>
        <div class="SearchFooter">
            <div class="Icon-size1 Tools20"></div>
            <div class="Icon-size1 Tools6" onclick="pageQuery(1)"></div>
        </div>
    </div>
    </form>
    <div class="Content" style="width:74%;margin-top:-9;" id="ARTPromoListDiv"></div>
</div>

