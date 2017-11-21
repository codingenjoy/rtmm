<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<%@ include file="/page/commons/toolbar.jsp"%>
<style type="text/css">
.datagrid-body {
margin: 0;
padding: 0;
overflow-x: auto;
overflow-y: scroll;
zoom: 1;
}
</style>
<script type="text/javascript">
//加载jqyeryeasyui页面信息

var seId="0";//主题号
var secNo = "";//课别
var grpNo = "";//大分类
var midgrpNo = "";//中分类
var catlgNo = "";//小分类
var itemNo = "";//货号
var status="";//状
var  stdBuyPricebMin="";
var stdBuyPricebMax="";	
var stdSellPriceMin="";
var stdSellPriceMax="";

	//查询按钮
	$('#Tools1').attr('class', 'Icon-size1 Tools1 B-id').bind('click',
			function() {
				DispOrHid('B-id');
				gridbar_B();
			});

	$(function() {
		status="";
		//readItemSeTopicDetailInfos(1,20);
		
	});


	//翻页信息
	function pageQuery() {
		readItemSeTopicDetailInfos($("#pageNo").val(), $("#pageSize").val());
	}
	
	//商品列表
	function readItemSeTopicDetailInfos(pageNo, pageSize) {
		$.post("<c:url value='/itemQueryManagement/readItemSeTopicBypage'/>?tt="+new Date().getTime(),{
			seId:seId,
			 secNo:secNo,
			 grpNo:grpNo,
			 midgrpNo:midgrpNo,
			 catlgNo:catlgNo,
			 itemNo:itemNo, 
		     status:status,
		     stdBuyPricebMin:stdBuyPricebMin,
	    	 stdBuyPricebMax:stdBuyPricebMax,
	    	 stdSellPriceMin:stdSellPriceMin,
	    	 stdSellPriceMax:stdSellPriceMax,		
			pageNo : pageNo,
			pageSize : pageSize
		},function(data){
			$("#itemSETopicDetailList").html(data);
		});

		/* $.ajax({
			url : "<c:url value='/itemQueryManagement/readItemSeTopicBypage'/>?tt="+new Date().getTime(),
			type : "post",
			dataType : "html",
			data : {
				seId:seId,
				 secNo:secNo,
				 grpNo:grpNo,
				 midgrpNo:midgrpNo,
				 catlgNo:catlgNo,
				 itemNo:itemNo, 
			     status:status,
			     stdBuyPricebMin:stdBuyPricebMin,
		    	 stdBuyPricebMax:stdBuyPricebMax,
		    	 stdSellPriceMin:stdSellPriceMin,
		    	 stdSellPriceMax:stdSellPriceMax,		
				pageNo : pageNo,
				pageSize : pageSize
			},
			success : function(data) {
				$("#itemSETopicDetailList").html(data);
			},
			error : function(XMLHttpRequest, textStatus,
					errorThrown) {
				//这里是ajax错误信息  
			}
		}); */
	}


	//根据季节商品获取季节信息
	function readSeTopicInfosBySeId(seId,methodName) {
		 $.ajax({
			url : "<c:url value='/itemQueryManagement/readSeTopicSettingBypage'/>?tt="+new Date().getTime(),
			type : "post",
			dataType : "json",
			data : {
				seId:seId,
				rows:10,
				page:1			
			},
			global:false,
			beforeSend:function(){
				//grid_layer_open();
			},
			complete:function(XMLHttpRequest,textStatus){
				try{
					// 通过XMLHttpRequest取得响应头，sessionstatus
					var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus"); 
					if(sessionstatus=="timeOut"){
						top.location.href = ctx + "/toLogin";
					}
					var exception=XMLHttpRequest.getResponseHeader("exception");
					if(exception){
						top.jAlert('error','系统建设中，敬请期待','提示消息');
					}
				}catch(e){
				}
			},
			success : function(data) {
				methodName(data.rows[0]);
			},
			error : function(XMLHttpRequest, textStatus,
					errorThrown) {
				//这里是ajax错误信息  
			}
		}); 
	}
	

	//验证信息，必须输入数字
	function isNumber(str) {
		var result = str.match(/^[0-9]{0,10}$/);
		if (result == null)
			return false;
		return true;
	}

         //为选项卡加载点击事件
     $("#itemSeSetting").click(function(){
    		showContent('<c:url value='/itemQueryManagement/itemSeTopicSetting'/>');
         }
     );

        //点击课别，选择信息
     $("[name=searchSection]").click(function(){
    	 $("#searchSectionId").removeClass("errorInput");
    	 $("#searchSeTop").focus();
 	     openPopupWin(600, 500, '/commons/window/chooseSection');
         });
          //点击期数，获取期数信息
          
          $("[name=searchTopicBtn]").click(function(){
      		$("#searchTopicId").removeClass("errorInput");
       	    $("#searchSeTop").focus();  		
        	  openPopupWin(600, 500, '/itemQueryManagement/chooseTopicInfo');
              });
              
              
          //双击期数，获取信息
          
          function confirmChooseTopic(data){
            $("#searchTopicId").val(data.seId);
			$("#searchTopicName").val(data.topicName);
              }    


     
         //点击货号，选择信息
     $("[name=searchSeries]").click(function(){
         $("#searchSeriesId").removeClass("errorInput");
    	 $("#searchSeTop").focus();        
    	 openPopupWin(600, 500, '/commons/window/chooseItem?callback=confirmRtn');
         });


	function confirmRtn(itemNoRtn,itemNameRtn){
		$('#searchSeriesName').val(itemNameRtn);
		 $("#searchSeriesId").val(itemNoRtn);
		$('#searchSeriesName').attr("title",itemNameRtn);
		 //关闭弹出层
		closePopupWin();
		}
     
         
   //根据弹出层回调结果信息  
 	function confirmChooseSection(id, name) {
 		$('#searchSectionId').attr('value', id);
 		$('#searchSectionName').attr('value', name);
 		//关闭弹出层
 		
 		//根据课别信息获取大分类信息
 		sectionSelect(id);
         //清空其他选项（中小分类）
         $('#midsizeCode').empty();
     	 $('#midsizeCode').attr("disabled",true);
         $('#catlgNo').empty(); 
         $('#catlgNo').attr("disabled",true);
 		closePopupWin();
 	}




 // 根据课显示大分类信息
 	function sectionSelect(sectionId) {
 		$('#groupCode').removeAttr("disabled");
 		$.ajax( {
 			type : "post",
 			url : ctx + "/catalog/midsizeShowGroupAction",
 			data : {
 				sectionId : sectionId
 			},
 			global:false,
 			beforeSend:function(){
 				//grid_layer_open();
 			},
 			complete:function(XMLHttpRequest,textStatus){
 				try{
 					// 通过XMLHttpRequest取得响应头，sessionstatus
 					var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus"); 
 					if(sessionstatus=="timeOut"){
 						top.location.href = ctx + "/toLogin";
 					}
 					var exception=XMLHttpRequest.getResponseHeader("exception");
 					if(exception){
 						top.jAlert('error','系统建设中，敬请期待','提示消息');
 					}
 				}catch(e){
 				}
 			},
 			success : function(data) {
 				var select = $("#groupCode");
 				//清空选项
 				select.empty(); 			
 				select.append("<option value=''>请选择</option>");
 				$.each(data, function(index, value) {
 					var option = "<option value='" + value.id + "' title='"+value.code+"'>" + value.code
 							+ "-&nbsp;" + value.name + "</option>";
 					select.append(option);
 				});
 			},error : function(XMLHttpRequest, textStatus, errorThrown) {
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
 		});

 	}

 //中分类的触发事件(大分类选项卡)
  $("#groupCode").change(function(){
	  groupSelect($("#groupCode").val());	 
	  });
 	 
 	//根据大分类显示中分类信息
 	function groupSelect(id) {
 		$('#midsizeCode').removeAttr("disabled");
 		$.ajax( {
 			type : "post",
 			url : ctx + "/catalog/subShowMidsizeAction",
 			data : {
 			gourpCode : id
 			},
 			global:false,
 			beforeSend:function(){
 				//grid_layer_open();
 			},
 			complete:function(XMLHttpRequest,textStatus){
 				try{
 					// 通过XMLHttpRequest取得响应头，sessionstatus
 					var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus"); 
 					if(sessionstatus=="timeOut"){
 						top.location.href = ctx + "/toLogin";
 					}
 					var exception=XMLHttpRequest.getResponseHeader("exception");
 					if(exception){
 						top.jAlert('error','系统建设中，敬请期待','提示消息');
 					}
 				}catch(e){
 				}
 			},
 			success : function(data) {
 				var select = $("#midsizeCode");
 				select.empty();
 				select.append("<option value=''>请选择</option>");
 				$.each(data, function(index, value) {
 					var option = "<option value='" + value.id + "' title='"+value.code+"'>" + value.code
 							+ "-&nbsp;" + value.name + "</option>";
 					select.append(option);
 				});
 			}
 		});
 	}


 	//小分类分类的触发事件
 	  $("#midsizeCode").change(function(){
 		 midgrpSelect($("#midsizeCode").val());
 		  });

 	
 	//根据中分类显示小分类信息
 	function midgrpSelect(id) {
 		$("#catlgNo").removeAttr("disabled");
 		$.ajax( {
 			type : "post",
 			url : ctx + "/catalog/subGroupShowGroupAction",
 			data : {
 				midsizeId : id
 			},
 			global:false,
 			beforeSend:function(){
 				//grid_layer_open();
 			},
 			complete:function(XMLHttpRequest,textStatus){
 				try{
 					// 通过XMLHttpRequest取得响应头，sessionstatus
 					var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus"); 
 					if(sessionstatus=="timeOut"){
 						top.location.href = ctx + "/toLogin";
 					}
 					var exception=XMLHttpRequest.getResponseHeader("exception");
 					if(exception){
 						top.jAlert('error','系统建设中，敬请期待','提示消息');
 					}
 				}catch(e){
 				}
 			},
 			success : function(data) {
 				var select = $("#catlgNo");
 				select.empty();
 				select.append("<option value=''>请选择</option>");
 				$.each(data, function(index, value) {
 					var option = "<option value='" + value.id + "' title='"+value.code+"'>" + value.code
 							+ "-&nbsp;" + value.name + "</option>";
 					select.append(option);
 				});
 			}
 		});
 	}      

	//如果值为null 则定义为‘’
	function setNulltoEmpty(str) {
		if (str == null || typeof(str)=="undefined") {
			str = "";
		}
		return str;
	}

  //点击查询信息，查询结果
  
  $("#searchSeTop").unbind().mousedown(function(){
      var error=0;
      seId=$("#searchTopicId").val();//主题信息
	  secNo = $("#searchSectionId").val();//课别
	   grpNo = setNulltoEmpty($("#groupCode :selected").attr('title'));//大分类
	   midgrpNo = setNulltoEmpty($("#midsizeCode :selected").attr('title'));//中分类
	   catlgNo = setNulltoEmpty($("#catlgNo :selected").attr('title'));//小分类
	   itemNo = $("#searchSeriesId").val();//货号
	   status=$("#searchRelativeType").val();//状态

       //检测
       $("[name=searchInputNum]").each(function(index,item){                        
              if(isNaN($(this).val())){
            	  $(this).addClass("errorInput");
            	  $(this).attr("title","请输入正确的价格信息");  
            	  error++;
                  }
           }); 
      
      $("[name=searchInputNumber]").each(function(index,item){
           if(!isNumber($(item).val())){
        	   $(item).addClass("errorInput");
        	   $(item).attr("title","请输入正确的信息");
        	   error++;  
               }
          });                     	   
	   if(error==0){
        stdBuyPricebMin=$("#stdBuyPricebMin").val();
        stdBuyPricebMax=$("#stdBuyPricebMax").val();	
        stdSellPriceMin=$("#stdSellPriceMin").val();
        stdSellPriceMax=$("#stdSellPriceMax").val();

        
		   //执行查询
		 readItemSeTopicDetailInfos(1,20);
		   }	   	
	  });
 	

  //清空所有查询条件信息
   $("#searchClearBtn").click(function(){
	   $("#searchSeTopDiv :input").val("");
	   $("#searchSeTopDiv :input").removeClass("errorInput");
	   
	   $("#groupCode").empty();
	   $("#midsizeCode").empty();
	   $("#catlgNo").empty();
	   status="";
	   
	   });

   //设置获取焦点事件
   $("[name=searchInputNum]").focus(function(){
	   $(this).removeClass("errorInput");
	   });
   $("[name=searchInputNumber]").focus(function(){
	   $(this).removeClass("errorInput");
	   });


   //设置课别下大分类信息
$("#searchSectionId").unbind("blur").blur(function(){
 var sectionId = $("#searchSectionId").val();
	$("#searchSectionName").val("");
if(isNumber(sectionId) && sectionId!=""){
     //加载课别信息
	readCatalogInfoBySecNo(sectionId,function(data){
          if(data!="" && data.length>0){
				$("#searchSectionName").val(data[0].secName);
              }
		});
	
	//根据课别信息获取大分类信息
		sectionSelect(sectionId);
	//加载课别内容信息			
}else{
	$("#groupCode").empty();
} 	
});


   
$("#searchTopicId").unbind("blur").blur(function(){
	//清除信息
	$("#searchTopicName").val("");
 var searchTopicId=$("#searchTopicId").val();//主题信息
	if(isNumber(searchTopicId)&&searchTopicId!=""){
	readSeTopicInfosBySeId(searchTopicId,function(data){
		if(data!=null){
    $("#searchTopicName").val(data.topicName);
			}
		});
	}
});

//商品信息
$("#searchSeriesId").unbind("blur").blur(function(){
	//清除信息
	$("#searchSeriesName").val("");
	var secNo = $("#searchSectionId").val();//课别
	var itemNo=$("#searchSeriesId").val();//商品编号
	if(isNumber(secNo) && isNumber(itemNo) &&itemNo!=""){
		//加载商品信息
		readItemInfoBySecNoAndItemNo(itemNo,secNo,function(data){
         if(data!=""){
			$("#searchSeriesName").val(data[0].itemName);
			$("#searchSeriesName").attr("title",data[0].itemName);
             }
         else{
        	 $("#searchSeriesId").val("");
        	 top.jWarningAlert("商品货号不存在");
        	 return false; 
             }
			});
		}
	
});

//回车事件绑定
$("#itemSeTopicDiv").unbind("keypress").keypress(function(event){		
	if(event!== null && event.keyCode == 13){
		$("#searchSeTop").focus();
		$("#searchSeTop").mousedown();
		} 
}); 

</script>



<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left"></div>
	<div class="tagsM" id="itemSeSetting">主题设定</div>
	<div class="tags tags_right_on"></div>
	<!--最后一个-->
	<div class="tagsM  tagsM_on" >SE商品查询</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Search Bar_on" id="itemSeTopicDiv">
		<!-- Bar_on-->
		<div class="SearchTop">
			<span>查询条件</span>
			<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
		</div>
		<div class="line"></div>
		<div class="SMiddle" id="searchSeTopDiv">
			<table class="SearchTable">
			<tr>
					<td class="w30"><span>期数</span></td>
					<td><div class="iconPut fl_left w55">
							<input class="w75" type="text" id="searchTopicId" name="searchInputNumber" maxlength="10"/>
							<div class="ListWin" name="searchTopicBtn"></div>
						</div></td>
				</tr>
				<tr>
					<td><span>&nbsp;</span></td>
					<td><input type="text" id="searchTopicName" class="inputText w80 Black" readonly="readonly" /></td>
				</tr>
				<tr>
					<td class="w30"><span>课别</span></td>
					<td><div class="iconPut fl_left w55">
							<input class="w75" type="text" id="searchSectionId"  name="searchInputNumber" />
							<div class="ListWin" name="searchSection"></div>
						</div></td>
				</tr>
				<tr>
					<td><span>&nbsp;</span></td>
					<td><input type="text" id="searchSectionName" class="inputText w80 Black" readonly="readonly" /></td>
				</tr>
				<tr>
					<td><span>大分类</span></td>
					<td>
							<select id="groupCode"  class="inputText w80" readonly="readonly" > </select>
					</td>
				</tr>			
				<tr>
					<td><span>中分类</span></td>
					<td><select id="midsizeCode"  class="inputText w80" readonly="readonly"></select>
						</td>
				</tr>			
				<tr>
					<td><span>小分类</span></td>
					<td><select id="catlgNo"  class="inputText w80 " readonly="readonly"></select></td>
				</tr>
				
				<tr>
					<td><span>货号</span></td>
					<td><div class="iconPut fl_left w55">
							<input class="w75" type="text" name="searchInputNumber" id="searchSeriesId"  maxlength="10"/>
							<div class="ListWin" name="searchSeries"></div>
						</div></td>
				</tr>
				<tr>
					<td><span>&nbsp;</span></td>
					<td><input type="text" class="inputText w80 Black"  Id="searchSeriesName"/></td>
				</tr>
				<tr>
					<td><span>状态</span></td>
					<td><auchan:select id="searchRelativeType"
							mdgroup="ITEM_STORE_INFO_STATUS" _class="w80"
							/></td>
				</tr>
				<tr>
					<td><span>进价</span></td>
					<td><input type="text" class="inputText w80" name="searchInputNum" id="stdBuyPricebMin"/><span>元
							-</span></td>
				</tr>
				<tr>
					<td><span>&nbsp;</span></td>
					<td><input type="text" class="inputText w80"  name="searchInputNum" id="stdBuyPricebMax"/><span>元
							&nbsp;</span></td>
				</tr>
				<tr>
					<td><span>售价</span></td>
					<td><input type="text" class="inputText w80" name="searchInputNum"  id="stdSellPriceMin"/><span>元
							-</span></td>
				</tr>
				<tr>
					<td><span>&nbsp;</span></td>
					<td><input type="text" class="inputText w80" name="searchInputNum"  id="stdSellPriceMax" /><span>元
							&nbsp;</span></td>
				</tr>
			</table>
		</div>
		<div class="line"></div>
		<div class="SearchFooter">
			<div class="Icon-size1 Tools20" id="searchClearBtn"></div>
			<div class="Icon-size1 Tools6" id="searchSeTop"></div>
		</div>
	</div>


	<div class="Content" id="itemSETopicDetailList" style="width: 74%">
		<!-- <table id="itemSupList" style="height: 570px;"></table> -->
	</div>
</div>
