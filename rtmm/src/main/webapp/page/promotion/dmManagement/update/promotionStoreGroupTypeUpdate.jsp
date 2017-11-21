<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<script type="text/javascript">
function cancel(n){
	top.window.$.zWindow.close({"close":n});
}


function updateStoreGrpType(){
	var grpTypeId=$.trim($("#grpTypeId").val());
	var grpTypeName=$.trim($("#grpTypeName").val());
	if(grpTypeName==''||grpTypeName==null)
	{
		top.jAlert('message', '套系名称不能为空', '提示消息');
		return;
	}
	
	$.ajax({
		async : false,
		url : ctx + '/storeGroup/DMManagement/checkIsGrpTypeInUse?ti='+(new Date()).getTime(),
		data : {'grpTypeId':grpTypeId},
		type : 'POST',
		success : function(response) {
			var flag=response["flag"];
			if(flag)
			{
				top.jAlert('warning', '套系正在使用,不能修改套系!', '提示消息');
			}
			else
			{
				$.ajax({
					async : false,
					url : ctx + '/storeGroup/DMManagement/updateGrpType?ti='+(new Date()).getTime(),
					data : {'grpTypeName':grpTypeName,'grpTypeId':grpTypeId},
					type : 'POST',
					success : function(response) {
						var data=response["flag"];
						if(data)
						{
							top.jAlert('success', '修改成功', '提示消息');
						}
						else
						{
							top.jAlert('success', '修改失败', '提示消息');
						}
						cancel(2);
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						top.jAlert('error', '网络超时!请稍后重试', '提示消息');
						cancel(2);
					}
				});
				
			}
		}
	});
	
}
</script>

<div class="Table_Panel">
    <div class="ig" style="margin-top:10px;">
        <div class="msg_txt">套系</div>
        <input class="inputText w20 Black" id="grpTypeId" value="${storeGrpType.grpTypeId }"  disabled="disabled"/>
    </div>
    <div class="ig">
        <div class="msg_txt">套系名称</div>
        <input name="grpTypeName" id="grpTypeName" value="${storeGrpType.grpTypeName }" class="inputText w50" />
    </div>
</div>
<div class="Panel_footer">
    <div class="PanelBtn">
        <span class="PanelBtn1" onclick="updateStoreGrpType()">确定</span>
        <span class="PanelBtn2" onclick="cancel(1)">取消</span>
    </div>
</div>
<div style="clear:both;"></div>
