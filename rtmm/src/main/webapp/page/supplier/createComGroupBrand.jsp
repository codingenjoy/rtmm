<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/page/commons/knockout.jsp" />
<style type="text/css">
.Table_Panel1 {
	height: 130px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}
</style>
<script type="text/javascript">
	$(function(){
		if ("${handleType }" == "add") {
			
		} else {
			$("#add_comgrpNoName").val($.trim($($(".btable_checked").find('input')).val()));
			$("#alterType").text('<auchan:i18n id="102003008"></auchan:i18n>');  //修改集团品牌
		}
		$("#add_comgrpNo").keydown(function(e){ 
			if(e.keyCode == 13){ 
				//根据comgrpNo查询集团
				var comgrpNo = $(this).val();
				$.post(ctx +'/commons/window/getComGrpByComgrpNo',{'comgrpNo':comgrpNo}, function(data){
					 if(data.comGrpVO && data.comGrpVO.comgrpNo){
						$('#add_comgrpNoName').attr("value",data.comGrpVO.comgrpName);
						pageQuery();
					}else{
						top.jAlert('warning',comgrpNo+'集团不存在，请确认后重新输入','提示消息');
						$('#add_comgrpNo').attr("value",'');
						$('#add_comgrpNo').focus();
					} 
				}); 
            	return false;
			} 
		}); 
		$('#add_comgrpNo').bind('change',function(obj){
			if($(this).val()==''){
				$(this).addClass('errorInput');
			}else{
				$(this).removeClass('errorInput');
			}
		});
	});
	$(".comgrpName").focus(function(){
		$("#ty_comgrpName").removeClass("errorInput");
	});
</script>
<div class="Panel_top">
	<span id="alterType" ><auchan:i18n id="102003007"></auchan:i18n></span>
	<div class="PanelClose" onclick="closePopupWinTwo()"></div>
</div>
<div class="Table_Panel1">
	<table class="CM_table">
        <tr>
            <td class="ST_td1"><span>*<auchan:i18n id="102003002"></auchan:i18n></span></td>
            <td class="ST_td2">
            <div class="iconPut w80">
            	<input id="add_comgrpNo" type="text" class="w85 comgrpNo"  value="${itemBrandVO.comgrpNo }" />
            	<div class="ListWin" onclick="openSupComgrpWindow('create')"></div> </div></td>
        </tr>
	    <tr>
	        <td>&nbsp;</td>
	        <td><input type="text" class="inputText w80 Black" id="add_comgrpNoName" readonly="readonly"/></td>
	    </tr>
		<tr>
			<td class="w20">
				<span>*<auchan:i18n id="102003004"></auchan:i18n></span>
			</td>
			<td>
				<input id="ty_comgrpName" maxlength="13" type="text" class="inputText w80 comgrpName" value="${itemBrandVO.brandName }" />
			</td>
		</tr>
		<tr>
			<td>
				<span><auchan:i18n id="102003005"></auchan:i18n> </span>
			</td>
			<td>
				<input id="ty_comgrpEnName" maxlength="33" type="text" class="inputText w80" value="${itemBrandVO.brandEnName }" />
			</td>
		</tr>
	</table>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="saveComgrpBrand('${handleType }')"><auchan:i18n id="100000004"></auchan:i18n></div>
		<div class="PanelBtn2" onclick="closePopupWinTwo()"><auchan:i18n id="100000003"></auchan:i18n></div>
	</div>
</div>
<input id="brandId" type="hidden" value="${itemBrandVO.brandId }" />