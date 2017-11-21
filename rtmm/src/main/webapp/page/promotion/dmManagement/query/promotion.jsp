<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/iframeContent.js" type="text/javascript"></script>
<%-- <script src="${ctx}/shared/js/rtmm.js" type="text/javascript"></script> --%>
<%@ include file="/page/commons/zWindow.jsp"%>
<script type="text/javascript">

    
	/* 创建添加弹窗 */
	function createIframeDialog() {
		
		top.window.$.zWindow.open({
			width : 600,
			height : 150,
			title : '创建新套系',
			windowSrc : ctx+'/storeGroup/DMManagement/addGrpTypePop',
			/* 关闭后执行的事件 */
			afterClose : function(data) {
				if(data!=undefined)
				{
				if(data.close==2)
					{
				     window.location.href=ctx + '/promotion/DMManagement/storeGroup';
					}
				}
			}
		    
		   
		});
	}
	
	/* 创建修改套系弹窗 */
	function createUpdateGrpTypeIframeDialog() {
		var chkVal=$(".tbx").find('.item_on2').find('input[type="checkbox"]').val();
		 if(!chkVal)
			 {
			 top.jAlert('warning', '请选择套系', '提示消息');
			 return;
			 }
		top.window.$.zWindow.open({
			width : 600,
			height : 150,
			title : '修改套系',
			windowSrc : ctx+'/storeGroup/DMManagement/updateGrpTypePop?grpTypeId='+chkVal,
			/* 关闭后执行的事件 */
			afterClose : function(data) {
				if(data!=undefined)
				{
				if(data.close==2)
					{
				     window.location.href=ctx + '/promotion/DMManagement/storeGroup';
					}
				}
			}
		    
		   
		});
	}
	
	/* 创建修改组别弹窗 */
	function createUpdateStoreGrpPopIframeDialog() {
		 var chkVal=$(".tbx2").find('.item_on2').find('input[type="checkbox"]').val();
		 var grpTypeId=$(".tbx").find('.item_on2').find('input[type="checkbox"]').val();
		 if(!chkVal)
			 {
			 top.jAlert('warning', '请选择组别', '提示消息');
			 return;
			 }
		top.window.$.zWindow.open({
			width : 600,
			height : 150,
			title : '修改组别',
			windowSrc : ctx+'/storeGroup/DMManagement/updateStoreGrpPop?grpTypeId='+grpTypeId+'&grpId='+chkVal,
			/* 关闭后执行的事件 */
			afterClose : function(data) {
				if(data!=undefined)
				{
				if(data.close==2)
					{
				     window.location.href=ctx + '/promotion/DMManagement/storeGroup';
					}
				}
			}
		    
		   
		});
	}
	
	
	/* 创建组别添加弹窗 */
	function createStoreGroupCreatIframeDialog() {
		 var chkVal=$(".tbx").find('.item_on2').find('input[type="checkbox"]').val();
		 if(!chkVal)
			 {
			 top.jAlert('warning', '请选择套系', '提示消息');
			 return;
			 }
		 $.ajax({
				async : false,
				url : ctx + '/storeGroup/DMManagement/checkIsGrpTypeInUse?ti='+(new Date()).getTime(),
				data : {'grpTypeId':chkVal},
				type : 'POST',
				success : function(response) {
					var flag=response["flag"];
						if(flag)
						{
							top.jAlert('warning', '套系正在使用,不能添加组别!', '提示消息');
						}
						else
						{
							top.window.$.zWindow.open({
								width : 600,
								height : 150,
								title : '创建组别',
								windowSrc : ctx+'/storeGroup/DMManagement/storeGroupCreateGroupPop?grpTypeId='+chkVal,
								/* 关闭后执行的事件 */
								afterClose : function(data) {
									if(data!=undefined)
									{
									   if(data.close==2)
										{
									     window.location.href=ctx + '/promotion/DMManagement/storeGroup';
										}
									   if(data.close==3)
										{
										   top.window.$.zWindow.open({
												width : 600,
												height : 390,
												title : '选择门店',
												windowSrc : ctx+'/storeGroup/DMManagement/storeCreatePop?storeGroupName='+data.storeGroupName+'&grpTypeId='+data.grpTypeId,
												/* 关闭后执行的事件 */
												afterClose : function(data) {
													if(data!=undefined)
													{
													if(data.close==2)
														{
													     window.location.href=ctx + '/promotion/DMManagement/storeGroup';
														}
													}
												}
											    
											   
											}); 
										}
									}
									
								}
							    
							   
							});
						}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					top.jAlert('error', '网络超时!请稍后重试', '提示消息');
				}
			});
		
	}
	
	
	/* 选择门店弹窗 */
	function createStoreCreatIframeDialog() {
		  var chkVal=$(".tbx2").find('.item_on2').find('input[type="checkbox"]').val();
		 var grpTypeId=$(".tbx").find('.item_on2').find('input[type="checkbox"]').val();
		 if(!chkVal)
			 {
			 top.jAlert('warning', '请选择组别', '提示消息');
			 return;
			 }
		 
		 top.window.$.zWindow.open({
				width : 600,
				height : 395,
				title : '选择门店',
				windowSrc : ctx+'/storeGroup/DMManagement/storeCreatePop?grpId='+chkVal+'&grpTypeId='+grpTypeId,
				/* 关闭后执行的事件 */
				afterClose : function(data) {
					
					if(data!=undefined)
					{
					if(data.close==2)
						{
					     window.location.href=ctx + '/promotion/DMManagement/storeGroup';
						}
					}
				}
			    
			   
			});  
	}
</script>
<script type="text/javascript">
    $(".tbx tr").die("click").live("click", function () {
        $('.tbx').find('.item_on2').removeClass('item_on2');
        $(this).addClass("item_on2");

        var yy=$(this).offset().top;
        var y = $(this).offset().top - 78;
        $(".px").css({ "top": y });
        var sid="";
        if($(this).find('input[type="checkbox"]'))
        {
    	  sid=$(this).find('input[type="checkbox"]').val();
        }
        /*根据套系ID查询组别 */
    	$.ajax({
			async : false,
			url : ctx + '/storeGroup/DMManagement/findStoreGrpByGrpTypeId?ti='+(new Date()).getTime(),
			data : {'sid':sid},
			type : 'POST',
			success : function(response) {
				$(".tbx2 table").html("");
				var htmlStr="";
				$(".storeListItem").html("");
				var data=response["row"];
				if(data)
				{
					for(var i=0;i<data.length;i++)
						{
						    var obj=data[i];
						    if(i==0)
						    {
						    	htmlStr+="<tr class='item_tr'>"
						    	+"<td class='w10 align_center'><input name='storeGrpCK' type='checkbox' value="+obj.grpId+" /></td>"
						    	+"<td class='w25'>"+obj.grpId+"</td>"
						    	+"<td><div class='longText'>"+obj.grpName+"</div></td>"
						    	+"</tr>";
						    }
						    else
						    {
						    	htmlStr+="<tr class='item_tr'>"
								+"<td class='align_center'><input name='storeGrpCK' type='checkbox' value="+obj.grpId+" /></td>"
								+"<td class='w25'>"+obj.grpId+"</td>"
								+"<td><div class='longText'>"+obj.grpName+"</div></td>"
							    +"</tr>";
						    }
						}
					$(".tbx2 table").html(htmlStr);
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});
    	$(".item_tr:first").click();
    });
    
    $(".tbx2 tr").live("click", function () {
        var sid="";
        if($(this).find('input[type="checkbox"]'))
        {
    	  sid=$(this).find('input[type="checkbox"]').val();
        }
        /* 根据组别ID查询门店 */
    	$.ajax({
			async : false,
			url : ctx + '/storeGroup/DMManagement/findStoreBygrpId?ti='+(new Date()).getTime(),
			data : {'sid':sid},
			type : 'POST',
			success : function(response) {
				$(".storeListItem").html("");
				var htmlStr="";
				var data=response["row"];
				if(data)
				{
					for(var i=0;i<data.length;i++)
						{
						    var obj=data[i];
						    htmlStr+="<div class='item'>"+obj.storeName+"</div>";
						}
					$(".storeListItem").html(htmlStr);
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});

    });
    /* 删除套系*/
    function deleteGrpType(){
    	var arr=[];
    	$('input[name="grpTypeIdCk"]:checked').each(function() {
            	arr.push($(this).val());
         });
         if(arr.length==0)
        	 {
        	 top.jAlert('warning', '请选择要删除的套系', '提示消息');
        	 return;
        	 }
         top.jConfirm('要清除选中的数据吗？', '提示消息', function(ret) {
 			//返回ret，点击确定返回true,点击取消返回false
 			if (ret) {
 				//验证套系是否使用过
 				$.ajax({
 					async : false,
 					url : ctx + '/storeGroup/DMManagement/checkWasGrpTypeUsed?ti='+(new Date()).getTime(),
 					data : {'grpTypeId':arr.join(";")},
 					type : 'POST',
 					success : function(response) {
 						var flag=response["flag"];
 						if(flag)
 						{
 							top.jAlert('warning', '套系已经使用过,不能删除!', '提示消息');
 						}
 						else
 						{
 							$.ajax({
 			 					async : false,
 			 					url : ctx + '/storeGroup/DMManagement/deleteGrpType?ti='+(new Date()).getTime(),
 			 					data : {'grpTypeId':arr.join(";")},
 			 					type : 'POST',
 			 					success : function(response) {
 			 						var data=response["flag"];
 			 						if(data)
 			 						{
 			 							top.jAlert('success', '删除成功', '提示消息');
 			 							window.location.href=ctx + '/promotion/DMManagement/storeGroup';
 			 						}
 			 						else
 			 						{
 			 							top.jAlert('success', '删除失败', '提示消息');
 			 						}
 			 					},
 			 					error : function(XMLHttpRequest, textStatus, errorThrown) {
 			 						top.jAlert('error', '网络超时!请稍后重试', '提示消息');
 			 					}
 			 				});
 						}
 					},
 					error : function(XMLHttpRequest, textStatus, errorThrown) {
 						top.jAlert('error', '网络超时!请稍后重试', '提示消息');
 					}
 				});
 				
 			}
 		});
    	
    }
    
    /* 删除组别 */
    function deleteStoreGrp(){
    	var arr=[];
    	$('input[name="storeGrpCK"]:checked').each(function() {
            	arr.push($(this).val());
         });
		 var grpTypeId=$(".tbx").find('.item_on2').find('input[type="checkbox"]').val();
		 if(grpTypeId==''||grpTypeId==undefined)
    	 {
    	 top.jAlert('warning', '请选择组别相应的套系', '提示消息');
    	 return;
    	 }
         if(arr.length==0)
        	 {
        	 top.jAlert('warning', '请选择要删除的组别', '提示消息');
        	 return;
        	 }
          
         top.jConfirm('要清除选中的数据吗？', '提示消息', function(ret) {
  			//返回ret，点击确定返回true,点击取消返回false
  			if (ret) {
  				
  				$.ajax({
  					async : false,
  					url : ctx + '/storeGroup/DMManagement/checkWasGrpTypeUsed?ti='+(new Date()).getTime(),
  					data : {'grpTypeId':grpTypeId},
  					type : 'POST',
  					success : function(response) {
  						var flag=response["flag"];
 						if(flag)
 						{
 							top.jAlert('warning', '套系已经使用过,不能删除相应的组别!', '提示消息');
 						}
 						else
 						{
 							$.ajax({
 			  					async : false,
 			  					url : ctx + '/storeGroup/DMManagement/deleteStoreGrp?ti='+(new Date()).getTime(),
 			  					data : {'storeGrpId':arr.join(";")},
 			  					type : 'POST',
 			  					success : function(response) {
 			  						var data=response["flag"];
 			  						if(data)
 			  						{
 			  							top.jAlert('success', '删除成功', '提示消息');
 			  							window.location.href=ctx + '/promotion/DMManagement/storeGroup';
 			  						}
 			  						else
 			  						{
 			  							top.jAlert('success', '删除失败', '提示消息');
 			  						}
 			  					},
 			  					error : function(XMLHttpRequest, textStatus, errorThrown) {
 			  						top.jAlert('error', '网络超时!请稍后重试', '提示消息');
 			  					}
 			  				});
 						}
  						
  					},
  					error : function(XMLHttpRequest, textStatus, errorThrown) {
  						top.jAlert('error', '网络超时!请稍后重试', '提示消息');
  					}
  				});
  				
  			}
  		});
     	
    }
    function checkAll(chk)
    {
    	$('input[name="grpTypeIdCk"]').each(function() {
    		if(chk.checked)
    			{
        	      $(this).attr("checked",true);
    			}
    		else
    			{
    			 $(this).attr("checked",false);
    			}
     });
    }
    
    function checkAllStoreGrp(chk)
    {
    	$('input[name="storeGrpCK"]').each(function() {
    		if(chk.checked)
    			{
        	      $(this).attr("checked",true);
    			}
    		else
    			{
    			 $(this).attr("checked",false);
    			}
     });
    }
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
    <!--第一个-->
    <div class="tags1_left tags1_left_on"></div>
    <div class="tagsM tagsM_on">套系店别管理 </div>
    <div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Content">
		<div class="Con_tb">
			<!-- Bar_on-->
			<div class="SearchTopx">
				<span>套系</span>
				<div class="createNewBar" onclick="createIframeDialog()" ></div>
				<div class="lineToolbar"></div>
				<div class="editBar" onclick="createUpdateGrpTypeIframeDialog()"></div>
				<div class="lineToolbar"></div>
				<div class="deleteBar" onclick="deleteGrpType()"></div>
			</div>
			<div class="con_title">
				<table class="w100">
					<tr>
						<td class="w10 align_center"><input onclick="checkAll(this)" type="checkbox" /></td>
						<td class="w25 align_center borderLeft">套系</td>
						<td class="align_center borderLeft">套系名称</td>
					</tr>
				</table>
			</div>
			<div class="tbx">
				<table class="w100">
					
					<c:forEach items="${searchGrpTypeMap.row }" var="obj" varStatus="status">
					<c:if test="${status.index==0 }">
					  <tr class="tbr item_on2">
						<td class="w10 align_center"><input type="checkbox"  name="grpTypeIdCk"  value="${obj.grpTypeId }"/></td>
						<td class="w25">${obj.grpTypeId }</td>
						<td><div class="longText">${obj.grpTypeName }</div></td>
					</tr>
					</c:if>
					<c:if test="${status.index!=0 }">
					<tr>
						<td class="align_center"><input type="checkbox"name="grpTypeIdCk" value="${obj.grpTypeId }"/></td>
						<td>${obj.grpTypeId }</td>
						<td><div class="longText">${obj.grpTypeName }</div></td>
					</tr>
					</c:if>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="Con_R">
			<div class="Point_L">
				<div class="px Point_L2" style="position:relative;z-index:888;top:62px;"></div>
			</div>
			<div class="Point_R">
				<div class="group_list">
					<!-- Bar_on-->
					<div class="SearchTopx">
						<span>组别</span>
						<div class="createNewBar" onclick="createStoreGroupCreatIframeDialog()"></div>
						<div class="lineToolbar"></div>
						<div class="editBar" onclick="createUpdateStoreGrpPopIframeDialog()"></div>
						<div class="lineToolbar"></div>
						<div class="deleteBar" onclick="deleteStoreGrp()"></div>
					</div>
					<div class="con_title">
						<table class="w100">
							<tr>
								<td class="w10 align_center"><input onclick="checkAllStoreGrp(this)" type="checkbox" /></td>
								<td class="w25 align_center borderLeft">组别</td>
								<td class="align_center borderLeft">组别名称</td>
							</tr>
						</table>
					</div>
					<div class="tbx2">
						<table class="w100">
							
						</table>
					</div>
				</div>
				<div class="store_list">
					<div class="h30">
						<span>门店</span>
						<div class="editBar" onclick="createStoreCreatIframeDialog()"></div>
					</div>
					<div class="storeListItem">
						
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	$(".tbr:first").click();
	$(".item_tr:first").click();
	$(".item").die("click");
	
});
</script>