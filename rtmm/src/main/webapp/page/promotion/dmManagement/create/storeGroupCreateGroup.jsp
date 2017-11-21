<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
    
    /* 创建门店选择弹窗 */
	function createIframeDialog() {
		var storeGroupName=$.trim(encodeURI(encodeURI($("#storeGroupName").val())));
    	var grpTypeId=$("#grpTypeId").val();
    	if(storeGroupName==''||storeGroupName==null)
    	{
    		top.jAlert('message', '组别名称不能为空', '提示消息');
    		return;
    	}
		cancel(3,grpTypeId,storeGroupName);
		/*  top.window.$.zWindow.open({
			width : 600,
			height : 390,
			title : '选择门店',
			windowSrc : ctx+'/storeGroup/DMManagement/storeCreatePop?storeGroupName='+storeGroupName+'&grpTypeId='+grpTypeId,
			afterClose : function(data) {
				if(data!=undefined)
				{
				if(data.close==2)
					{
				     window.location.href=ctx + '/promotion/DMManagement/storeGroup';
					}
				}
			}
		    
		   
		}); */
	}
    
    
</script>

<div class="Table_Panel">
    <div class="ig" style="margin-top:10px;">
        <input type="hidden" id="grpTypeId" name="grpTypeId" value="${grpTypeId}">
        <div class="msg_txt">组别</div>
        <input class="inputText w20 Black" disabled="disabled" />
    </div>
    <div class="ig">
        <div class="msg_txt">组别名称</div>
        <input class="inputText w50" name="storeGroupName" id="storeGroupName"/>
    </div>
</div>
<div class="Panel_footer">
    <div class="PanelBtn">
        <span class="PanelBtn1" onclick="createIframeDialog()">确定</span>
        <span class="PanelBtn2" onclick="cancel(1)">取消</span>
    </div>
</div>
<div style="clear:both;"></div>
