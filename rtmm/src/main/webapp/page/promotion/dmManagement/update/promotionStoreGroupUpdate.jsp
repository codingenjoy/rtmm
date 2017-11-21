<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<script type="text/javascript">
    function cancel(n,grpTypeId,storeGroupName){
	top.window.$.zWindow.close({"close":n,"grpTypeId":grpTypeId,"storeGroupName":storeGroupName});
    }
    
   
	function updateStoreGrp() {
		var storeGroupName=$.trim($("#storeGroupName").val());
    	var grpId=$("#grpId").val();
    	var grpTypeId=$("#grpTypeId").val();
    	if(storeGroupName==''||storeGroupName==null)
    	{
    		top.jAlert('message', '组别名称不能为空', '提示消息');
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
    				top.jAlert('warning', '套系正在使用,不能修改组别!', '提示消息');
    			}
    			else
    			{
    				$.ajax({
    		    		async : false,
    		    		url : ctx + '/storeGroup/DMManagement/updateStoreGrp?ti='+(new Date()).getTime(),
    		    		data : {'grpId':grpId,'storeGroupName':storeGroupName},
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
        <input type="hidden" id="grpTypeId" name="grpTypeId" value="${grpTypeId}">
        <div class="msg_txt">组别</div>
        <input class="inputText w20 Black"  id="grpId" value="${storeGrp.grpId }" disabled="disabled" />
    </div>
    <div class="ig">
        <div class="msg_txt">组别名称</div>
        <input class="inputText w50" value="${storeGrp.grpName }" name="storeGroupName" id="storeGroupName"/>
    </div>
</div>
<div class="Panel_footer">
    <div class="PanelBtn">
        <span class="PanelBtn1" onclick="updateStoreGrp()">确定</span>
        <span class="PanelBtn2" onclick="cancel(1)">取消</span>
    </div>
</div>
<div style="clear:both;"></div>
