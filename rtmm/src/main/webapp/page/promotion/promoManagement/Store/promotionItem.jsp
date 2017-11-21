<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/js/loading/loading.css" />
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/iframeContent.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/common.js" charset="utf-8"></script>	
<script type="text/javascript" src="${ctx}/shared/js/loading/loading.js" charset="utf-8"></script>

<script type="text/javascript"> 
/*课别弹出框*/
function showCatlgWin(){
	top.openPopupWin(602,180,'/prom/nondm/art/showCatlgWin');
}

/*代号弹出框*/
function showUnitWin(){
	var unitType =$("#unitType").val();
	var catlgId =$("#catlgId").val();
    if(unitType==''){
	top.jAlert('warning', '请选择代号类别 !', '提示消息');
		 return;
    }
	top.openPopupWin(800,450, '/prom/nondm/store/showUnitWinQuery?unitType='+unitType+'&catlgId='+catlgId);
}
/*手动输入课别*/
function catlgIdBlur(obj){
	var sectionNo = $.trim($(obj).val());
	if(!isNumber(sectionNo)){
		top.jAlert('warning', '输入课别有误',"提示消息");
		$("#catlgId").val('');
		$("input[name='catlgName']").val('');
		return;
	}
	if(sectionNo){
		pr_searchSectionMess(sectionNo);
	}else{
		$("#catlgId").val('');
		$("input[name='catlgName']").val('');
	}
}
/*手动输入促销号*/
function promNoBlur(obj){
	var sectionNo = $.trim($(obj).val());
	if(!isNumber(sectionNo)){
		top.jAlert('warning', '输入促销号有误',"提示消息");
		$("#promNo").val('');
		return;
	}
}
/*手动输入代号*/
function promUnitNoBlur(obj){
	var unitNo = $.trim($(obj).val());
	var unitType =$("#unitType").val();
    if (unitNo!=""&&unitType == '') {
    	    $("#promUnitNo").val('');
		    $("#promUnitName").val('');
			top.jAlert('warning', '请选择代号类别!', '提示消息');
			return;
	}
		if (!isNumber(unitNo)) {
			top.jAlert('warning', '输入代号有误', window.v_messages);
			$("#promUnitNo").val('');
			$("#promUnitName").val('');
			return;
		}
		if (unitNo) {
			pr_searchPromUnitName(unitNo,unitType);
		}else{
			$("#promUnitNo").val('');
			$("#promUnitName").val('');
		}
}




$(function (){
	/*门店用户进入菜单查询数据*/
	var userFlag='${userFlag}';
	var jump='${jump}';
	if(userFlag!='0'||jump=='jump')
	{
		Query();
	}else{
		DispOrHid('B-id');
	}
	//DispOrHid('B-id');
	$("#Tools11").removeClass("Tools11_disable");
	$("#Tools11").addClass("Icon-size1 Tools11");
	$("#Tools21").attr('class', "Icon-size1 Tools21_on");
	$($("#Tools21").parent()).addClass("ToolsBg");
	$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind(
			"click", function() {
				DispOrHid('B-id');
	});
	
	
	$("#Tools11").unbind("click").bind("click",function(){
		$(top.document).find("#contentIframe").attr("src",ctx + '/prom/nondm/store/create');
	});
	
	

});


function getPromotionListPage(){
	var promotionItemForm = $("#promotionItemForm").serialize();
	$.ajax({
		url: ctx + '/prom/nondm/store/getPromStoreList',
        type: "post",
        dataType:"html",
        data:promotionItemForm,
        success: function(data) {
 			$("#listdata_div").html(data);
        }
	});
}
function addStoreGrpTypeReturn(unitNo,unitName){
	if (unitNo != undefined){
		$("input[name='promUnitNo']").val(unitNo);
		$("input[name='promUnitName']").val(unitName);
	}
	top.closePopupWin();
}


	//手动查询课别
	function pr_searchSectionMess(sectionNo) {
		$.ajax({
					type : 'post',
					url : ctx + '/catalog/searchSectionMessAction',
					data : {
						catlgId : sectionNo
					},
					success : function(data) {
						var sectionInfoVO = data.sectionInfoVO;
						if (sectionInfoVO != null) {
							$("input[name='catlgName']").val(
									sectionInfoVO.catlgName);
						} else {
							top.jAlert("warning", "没有找到对应信息, 请重新输入",
									"提示消息");
							$("input[name='catlgName']").val('');
							$("#catlgId").val('');
						}
					}
				});
	}

	//手动查询代号
	function pr_searchPromUnitName(unitNo,unitType) {
		$.ajax({
					type : 'post',
					url : ctx
							+ '/prom/nondm/ho/searchPromUnitNameAction',
					data : {
						itemNo : unitNo,
						unitType : unitType
					},
					success : function(data) {
						if (data.unitName != "") {
							$("#promUnitName").val(data.unitName);
						} else {
							top.jAlert("warning", "没有找到对应信息, 请重新输入",
									"提示消息");
							$("#promUnitNo").val('');
							$("#promUnitName").val('');
						}
					}
				});
	}

	function isNumber(param) {
		var reg = new RegExp("^[0-9]*$");
		if ($.trim(param) == '') {
			return true;
		}
		if (!reg.test(param)) {
			return false;
		} else {
			return true;
		}
	}
	
	
	function enterInCatlgId(evt){
		  var evt=evt?evt:(window.event?window.event:null);//兼容IE和FF
		  if (evt.keyCode==13){
			  $("#catlgId").blur();
			  Query();
		}
	}
	
	function enterInUnitNo(evt){
		  var evt=evt?evt:(window.event?window.event:null);//兼容IE和FF
		  if (evt.keyCode==13){
			  $("#promUnitNo").blur();
			  Query();
		}
	}
	function changeType(){
		$("#promUnitNo").val('');
		$("#promUnitName").val('');
	}
	function clearEndInput()
	{
		$(this).blur();
	}
	function dateChange(obj){
		obj.value='';
	}
	function addCatlgReturn(catlgId,catlgName){
		  if(catlgId&&catlgName){
			$("#catlgId").val(catlgId);
			$("#catlgName").val(catlgName);
		  }
		  top.closePopupWin();
	}
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
 <div class="CTitle">
<!--第一个-->
   <div class="tags1_left tags1_left_on"></div>
   <div class="tagsM tagsM_on">门店促销信息</div>
   <div class="tags tags3_r_on"></div>
</div>
<div class="Container-1" >
 <form action="" id="promotionItemForm" name="promotionItemForm">
 <div class="Search Bar_on" style="display: none" id="searchPromotionItem"><!-- Bar_on-->
 
     <div class="SearchTop">
         <span>查询条件</span>
         <div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
     </div>
    
     <div class="SMiddle" >
         <input type="hidden" name="jump" id="jump" value="${jump}"/>
         <input type="hidden" name="pSize" id="pSize" value="${page.pageSize}"/>
         <input type="hidden" name="pNo" id="pNo" value="${page.pageNo}"/>
         <table class="SearchTable" border="0" cellspacing="0" cellpadding="0">
             <tr>
                 <td class="ST_td1"><span>档期</span></td>
                 <td><input name="promNo" id="promNo" value="${promStore.promNo }" maxlength="10" onblur="promNoBlur(this)" class="w65 inputText" type="text" /></td>
             </tr>
             <tr>
                 <td><span>主题</span></td>
                 <td><input name="subjName" id="subjName" value="${promStore.subjName }" class="w85 inputText" type="text" maxlength="30"/></td>
             </tr>
             <tr>
                 <td><span>课别</span></td>
                 <td><div class="iconPut w65 fl_left">
                             <input name="catlgId" onblur="catlgIdBlur(this)" id="catlgId" value="${promStore.catlgId }" onkeydown="enterInCatlgId(event)" maxlength="8" type="text" class="w80" />
                             <div class="ListWin showCatlgWin" onclick="showCatlgWin()" ></div>
                         </div>
                 </td>
             </tr>
             <tr>
                 <td><span>&nbsp;</span></td>
                 <td>
                     <input name="catlgName" id="catlgName" class="w85 inputText Black" type="text" />
                 </td>
             </tr>
             <tr>
                 <td><span>代号类别</span></td>
                 <td>	<auchan:select mdgroup="PROM_UNIT_BY_ST_UNIT_TYPE" _class="w85" id="unitType" onchange="changeType()" name="unitType" value="${promStore.unitType }"/>
                </td>
             </tr>
             <tr>
                 <td><span>代号</span></td>
                 <td><div class="iconPut w65 fl_left">
                             <input name="promUnitNo" value="${promStore.promUnitNo }" onkeydown="enterInUnitNo(event)" onblur="promUnitNoBlur(this)" maxlength="9" id="promUnitNo" type="text" class="w80" />
                             <div class="ListWin showUnitWin" onclick="showUnitWin()"></div>
                         </div>
                 </td>
             </tr>
             <tr>
                 <td><span>&nbsp;</span></td>
                 <td>
                     <input  name="promUnitName" id="promUnitName" class="w85 inputText Black" type="text" />
                 </td>
             </tr>
             <tr>
                 <td><span>促销提出方</span></td>
                 <td>
                 <select name="promParty" id="promParty" class="w85">
                 <option value="">请选择</option>
                  <option value="S" <c:if test="${promStore.promParty=='S' }">selected</c:if>>S-采购</option>
                  <option value="L" <c:if test="${promStore.promParty=='L' }">selected</c:if>>L-门店</option>
                 </select>
                 </td>
             </tr>
             <tr>
                 <td><span>店号</span></td>
                 <td><select name="storeNo" id="storeNo" class="w85"> <option value="">请选择</option> 
                 <c:forEach items="${storeLs}" var="store" >
                 <option value="${store.storeNo }" <c:if test="${userFlag ne '0' and jump!='jump'}">selected</c:if> <c:if test="${promStore.storeNo==store.storeNo}">selected</c:if> >${store.storeNo}-${store.storeName }</option>
                 </c:forEach>
                 </select></td>
             </tr>
            <!--  <tr>
                 <td><span>组合促销</span></td>
                 <td><select class="w85"><option></option></select></td>
             </tr> -->
             <tr>
                 <td><span class="span_right">采购起始<br />期间</span></td>
                 <td><input name="beginDate1" id="beginDate1" <c:if test="${promStore.beginDate1!=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promStore.beginDate1}" />" </c:if> type="text" class="Wdate w65" onchange="dateChange(beginDate2)" onclick="WdatePicker({onpicked:clearEndInput,isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',lang:'${calendarL}'})"/>&nbsp;-
                 </td>
             </tr>
             <tr>
                 <td><span>&nbsp;</span></td>
                 <td><input type="text" name="beginDate2"  id="beginDate2"  <c:if test="${promStore.beginDate2!=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promStore.beginDate2}" />" </c:if> class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',minDate:'#F{$dp.$D(\'beginDate1\')}',lang:'${calendarL}'})"/>
                 </td>
             </tr>
             <tr>
                 <td><span  class="span_right">采购结束<br />期间</span></td>
                 <td><input name="endDate1" id="endDate1" <c:if test="${promStore.endDate1!=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promStore.endDate1}" />" </c:if> type="text" class="Wdate w65" onchange="dateChange(endDate2)" onclick="WdatePicker({onpicked:clearEndInput, isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',lang:'${calendarL}'})"/>&nbsp;-
                 </td>
             </tr>
             <tr>
                 <td><span>&nbsp;</span></td>
                 <td><input name="endDate2" id="endDate2" <c:if test="${promStore.endDate2!=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promStore.endDate2}" />" </c:if>  type="text" class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',minDate:'#F{$dp.$D(\'endDate1\')}',lang:'${calendarL}'})"/>
                 </td>
             </tr>
             <tr>
                 <td><span class="span_right">促销起始<br />期间</span></td>
                 <td><input name="promBeginDate1" id="promBeginDate1" <c:if test="${promStore.promBeginDate1!=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promStore.promBeginDate1}" />" </c:if> type="text" class="Wdate w65" onchange="dateChange(promBeginDate2)" onclick="WdatePicker({onpicked:clearEndInput, isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',lang:'${calendarL}'})"/>&nbsp;-
                 </td>
             </tr>
             <tr>
                 <td><span>&nbsp;</span></td>
                 <td><input name="promBeginDate2" id="promBeginDate2" <c:if test="${promStore.promBeginDate2!=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promStore.promBeginDate2}" />" </c:if> type="text" class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',minDate:'#F{$dp.$D(\'promBeginDate1\')}',lang:'${calendarL}'})"/>
                 </td>
             </tr>
             <tr>
                 <td><span class="span_right">促销结束<br />期间</span></td>
                 <td><input name="promEndDate1" id="promEndDate1" <c:if test="${promStore.promEndDate1!=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promStore.promEndDate1}" />" </c:if> type="text" class="Wdate w65" onchange="dateChange(promEndDate2)" onclick="WdatePicker({onpicked:clearEndInput,  isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',lang:'${calendarL}'})"/>&nbsp;-
                 </td>
             </tr>
             <tr>
                 <td><span>&nbsp;</span></td>
                 <td><input name="promEndDate2" id="promEndDate2" <c:if test="${promStore.promEndDate2!=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promStore.promEndDate2}" />" </c:if> type="text" class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',minDate:'#F{$dp.$D(\'promEndDate1\')}',lang:'${calendarL}'})"/>
                 </td>
             </tr>
         </table>
     </div>
    
     <div class="line"></div>
     <div class="SearchFooter">
         <div class="Icon-size1 Tools20" onclick="clearQueryCondition()" ></div>
         <div class="Icon-size1 Tools6" id="searchPromStore" onclick="Query()"></div>
     </div>
 </div>
 
 <div class="Content" id="promotionItemListDiv">
    <div class="htable_div" >
    <table>
        <thead>
        <tr>
          <td><div class="t_cols align_center" style="width:30px;">&nbsp</td>
           <td><div class="t_cols align_center " style="width:75px;">档期<!--<div style="display:inline-block;width:10px;height:20px;"></div>--></div></td>
            <td><div class="t_cols align_center" style="width:135px;">主题</div></td>
            <td><div class="t_cols align_center" style="width:80px;">课别</div></td>
            <td><div class="t_cols align_center" style="width:100px;">促销提出方</div></td>
            <td><div class="t_cols align_center" style="width:100px;">店号</div></td>
            <td><div class="t_cols align_center" style="width:100px;">采购起始日期</div></td>
            <td><div class="t_cols align_center" style="width:100px;">采购结束日期</div></td>
            <td><div class="t_cols align_center" style="width:100px;">促销起始日期</div></td>
            <td><div class="t_cols align_center" style="width:100px;">促销结束日期</div></td>
             <td><div class="t_cols align_center" style="width:80px;">促销天数</div></td>
            <td><div style="width:16px;">&nbsp;</div></td>
        </tr>
    </thead>
 </table>
</div>
 <div id="listdata_div" >
 </div>
 </div>
 </form>
 </div>


<script type="text/javascript">
$(function(){
	$("#promUnitNo").blur();
	$("#catlgId").blur();
	
});
function Query()
{
    var promNo=$.trim($("#promNo").val());
	var subjName=$.trim($("#subjName").val());
	var catlgId=$.trim($("#catlgId").val());
	var unitType=$.trim($("#unitType").val());
	var promUnitNo=$.trim($("#promUnitNo").val());
	var promParty=$.trim($("#promParty").val());
	var storeNo=$.trim($("#storeNo").val());
	var beginDate1=$.trim($("#beginDate1").val());
	var beginDate2=$.trim($("#beginDate2").val());
	var endDate1=$.trim($("#endDate1").val());
	var endDate2=$.trim($("#endDate2").val());
	var promBeginDate1=$.trim($("#promBeginDate1").val());
	var promBeginDate2=$.trim($("#promBeginDate2").val());
	var promEndDate1=$.trim($("#promEndDate1").val());
	var promEndDate2=$.trim($("#promEndDate2").val());
	var flag=true;
	if(promNo==''&&subjName==""&&catlgId==""&&unitType==""&&promUnitNo==""&&promParty==""&&storeNo==""&&beginDate1==""&&beginDate2==""&&endDate1==""&&endDate2==""&&promBeginDate1==""&&promBeginDate2==""&&promEndDate1==""&&promEndDate2==""){
		flag=false;
	}
	
	if(flag){
	$("#pageNo").val(1);
	pageQuery();
	}else{
		top.jAlert('warning', '查询条件不能为空！', '提示消息');
	}
}
function pageQuery() {
	var param = $("#promotionItemForm").serialize();
	var promNo=$("#promNo").val();
	var jump=$("#jump").val();
	if(jump=="jump"){
		$("#jump").val("");
	}
	if(!isNumber(promNo))
		{
		   top.jAlert('warning', '档期必须为数字', '提示消息');
		   return;
		}
	
	var catlgId=$("#catlgId").val();
	if(!isNumber(catlgId))
		{
		   top.jAlert('warning', '课别必须为数字', '提示消息');
		   return;
		}
	var promUnitNo=$("#promUnitNo").val();
	if(!isNumber(promUnitNo))
		{
		   top.jAlert('warning', '代号必须为数字', '提示消息');
		   return;
		}
	$.ajax({
		type : "post",
		data :param,
		dataType : "html",
		url: ctx + '/prom/nondm/store/getPromStoreList',
		success : function(data) {
			$('#listdata_div').html(data);
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
function clearQueryCondition()
{
	$("#unitType option:first").prop("selected", 'selected');
	$("#promParty option:first").prop("selected", 'selected');
	$("#storeNo option:first").prop("selected", 'selected');
	$("#searchPromotionItem input").val("");
	
}
//回车事件绑定
$("#searchPromotionItem").unbind("keypress").keypress(function(event){	
	var evt=event?event:(window.event?window.event:null);//兼容IE和FF
	  if (evt.keyCode==13){
		  Query();
	}
}); 

</script>
