<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<%@ include file="/page/commons/easyui.jsp"%>
<script src="${ctx}/shared/js/rtmm.js" charset="utf-8" type="text/javascript"></script>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/tree.css" rel="Stylesheet" />

<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<script src="${ctx}/shared/js/iframeContent.js" type="text/javascript"></script>
<script type="text/javascript">
    function cancel(n){
	top.window.$.zWindow.close({"close":n});
    }
    
    function addStoreGrpAndStore()
    {
    	var arr=[];
    	$('input[name="storeNoCk"]:checked').each(function() {
            	arr.push($(this).val());
         });
         if(arr.length==0)
        	 {
        	 top.jAlert('warning', '请选择要添加的门店', '提示消息');
        	 return;
        	 }
    	var storeGroupName=$("#storeGroupName").val();
    	var grpTypeId=$("#grpTypeId").val();
    	var grpId=$("#grpId").val();
    	$.ajax({
			async : false,
			url : ctx + '/storeGroup/DMManagement/checkIsGrpTypeInUse?ti='+(new Date()).getTime(),
			data : {'grpTypeId':grpTypeId},
			type : 'POST',
			success : function(response) {
				var flag=response["flag"];
				if(flag)
				{
					top.jAlert('warning', '套系正在使用,不能添加门店!', '提示消息');
				}
				else
				{
					$.ajax({
						async : false,
						url : ctx + '/storeGroup/DMManagement/addStoreGrpAndStore?ti='+(new Date()).getTime(),
						data : {'grpTypeId':grpTypeId,'storeGroupName':storeGroupName,storeId:arr.join(";"),"grpId":grpId},
						type : 'POST',
						success : function(response) {
							var data=response["flag"];
							if(data)
							{
								top.jAlert('success', '添加成功', '提示消息');
								cancel(2);
							}
							else
							{
								top.jAlert('error', '添加失败', '提示消息');
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
    
    function checkAll(chk)
    {
    	$('input[name="storeNoCk"]').each(function() {
    		if(chk.checked&&!$(this).attr("disabled"))
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
<style type="text/css">
    .tp_store_bottom {
        margin:15px 20px;
        background:#eee;
        height:280px;
    }
    .tp_city {
        padding-top:10px;
        background:#fff;
        display:inline-block;
        overflow-y:auto;
        margin-top:20px;
        margin-left:16px;
        height:230px;
        width:300px;
        float:left;
    }
    .tp_store {
        padding-top:10px;
        background:#fff;
        display:inline-block;
        overflow-y:auto;
        margin-top:20px;
        margin-left:5px;
        height:230px;width:220px;
        float:left;
        overflow-y:hidden;
    }
    .sp1 {
        height:85%;line-height:30px;overflow-y:auto;
    }
    .sp2 {
        width:90%;height:30px;border-top:1px solid #ccc;margin:10px auto;
    }
        .sp1 .item2 {
            padding-left:11px;border-bottom:1px solid #fff;
        }
    .ck_sp1 {
        margin-right:10px;vertical-align:middle;
    }
    /*//tree*/
    .tree-icon {
        display:none;
    }
</style>
       
        <div class="Table_Panel">
         <input id="grpTypeId" name="grpTypeId" type="hidden" value="${grpTypeId}"/>
         <input id="storeGroupName" name="grpTypeId" type="hidden" value="${storeGroupName}"/>
         <input id="grpId" name="grpId" type="hidden" value="${grpId}"/>
         
            <div class="tp_store_bottom">
                <div class="tp_city">
                    <ul id="Mytt"></ul>
                </div>
                <div class="tp_store">
                    <div class="sp1">
                       <!--  <div class="item2"><input type="checkbox" class="ck_sp1" />101-上海中原店</div>
                        <div class="item2"><input type="checkbox" class="ck_sp1" />101-上海中原店</div>
                        <div class="item2"><input type="checkbox" class="ck_sp1" />101-上海中原店</div>
                        <div class="item2"><input type="checkbox" class="ck_sp1" />101-上海中原店</div>
                        <div class="item2"><input type="checkbox" class="ck_sp1" />101-上海中原店</div>
                        <div class="item2"><input type="checkbox" class="ck_sp1" />101-上海中原店</div> -->
                    </div>
                    <div class="sp2">
                        <input type="checkbox" onclick="checkAll(this)" class="ck_sp1" />全选
                    </div>
                </div>
            </div>
            <div style="clear:both;"></div>
        </div>
        <div class="Panel_footer">
            <div class="PanelBtn">
                <span class="PanelBtn1" onclick="addStoreGrpAndStore()">确定</span>
                <span class="PanelBtn2" onclick="cancel(1)">取消</span>
                
            </div>
        </div>
        <div style="clear:both;"></div>
        
         <script type="text/javascript">
         var tree=eval('(${tree})'); 
      
        $('#Mytt').tree({
            checkbox: true,
            data:tree,
            onClick: function(node){
        	},
        	onCheck:function(node,checked){
        			 $.ajax({
        					async : false,
        					url : ctx + '/storeGroup/DMManagement/findStoreByRegnNos?ti='+(new Date()).getTime(),
        					data : {'sid':node.id},
        					type : 'POST',
        					success : function(response) {
        						var data=response["storeLs"];
        						
        							$.each(data,function(index,item){
    									if(checked){
    										$(".sp1").append("<div class='item2' id='store_"+item.storeNo+"'><label><input type='checkbox' name='storeNoCk' value="+item.storeNo+"></label><span>"+item.storeName+"</span></div>");
    									}else{
    										$(".sp1").find("div[id=store_"+item.storeNo+"]").remove();
    									}
    								});
        							
        					},
        					error : function(XMLHttpRequest, textStatus, errorThrown) {
        						top.jAlert('error', '网络超时!请稍后重试', '提示消息');
        					}
        				});
        			 var storeList=eval('(${storeList})'); 
        			 $.each(storeList,function(index,item){
          				$('input[name="storeNoCk"][value='+item.STORENO+']').attr('disabled',true);
          			});
        		 
        	}

            
            
        });
       
        $.ready(function () {
            $("tr:even").addClass(GrayBg);
        });
        </script>
        

