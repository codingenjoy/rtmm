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
	//查询按钮
	$('#Tools1').attr('class', 'Icon-size1 Tools1 B-id').bind('click',
			function() {
				DispOrHid('B-id');
				gridbar_B();
			});

	//加载页面信息

	var searchSeId = "";
	var searchBuyBeginMth = "";
	var searchBuyEndMth = "";
	var searchTopicName = "";
	var searchCreatDate = "";

	$(function() {
       //初始化页面信息	
            //初始化页面信息    
	 searchSeId = "";
	 searchBuyBeginMth = "";
	 searchBuyEndMth = "";
	 searchTopicName = "";
	 searchCreatDate = "";
       
		readItemSeTopicSettingInfos(1,20);
		//默认关闭查询窗口
		DispOrHid('C-id');
	});

	Date.prototype.format = function(format) {
		var o = {
			"M+" : this.getMonth() + 1, //month
			"d+" : this.getDate(), //day
			"h+" : this.getHours(), //hour
			"m+" : this.getMinutes(), //minute
			"s+" : this.getSeconds(), //second
			"q+" : Math.floor((this.getMonth() + 3) / 3), //quarter
			"S" : this.getMilliseconds()
		//millisecond
		}
		if (/(y+)/.test(format))
			format = format.replace(RegExp.$1, (this.getFullYear() + "")
					.substr(4 - RegExp.$1.length));
		for ( var k in o)
			if (new RegExp("(" + k + ")").test(format))
				format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
						: ("00" + o[k]).substr(("" + o[k]).length));
		return format;
	};

	


	//翻页信息
	function pageQuery() {
		readItemSeTopicSettingInfos($("#pageNo").val(), $("#pageSize").val());
	}
	
	//商品列表
	function readItemSeTopicSettingInfos(pageNo, pageSize) {
		$.ajax({
			url : "<c:url value='/itemQueryManagement/readItemSeTopicSettingBypage'/>",
			type : "post",
			dataType : "html",
			data : {
				seId:searchSeId,
				buyBeginMth:searchBuyBeginMth,
				buyEndMth:searchBuyEndMth,
				topicName:searchTopicName,
				creatDate:searchCreatDate,
				pageNo : pageNo,
				pageSize : pageSize
			},
			success : function(data) {
				$("#seTopicSettingInfo").html(data);
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
	$("#itemSeSearch").click(function() {
		showContent('<c:url value='/itemQueryManagement/itemSeTopicSearch'/>');
	});

	 //查询按钮事件
	 $("#seTopicSearchBtn").unbind().click(function(){
		 var errorCount=0;
		 //获取所有的数字输入框，如果输入格式不正确，则提示
		 $("#searchItemSeTopicDiv [name=searchNum]").each(function(index,item){
			  if(!isNumber($.trim($(this).val()))){
				  $(this).removeClass().addClass("inputText w80  errorInput");
				  errorCount++;
				  }
			 });
		 //获取所有的数字输入框，如果输入格式不正确，则提示
		 $("#searchItemSeTopicDiv [name=searchMonth]").each(function(index,item){
			  if(!isNumber($.trim($(this).val()))){
				  $(this).removeClass().addClass("inputText w80  errorInput");
				  errorCount++;
				  }
			 });
             if($.trim($("#searchBuyBeginMth").val())<0 || $.trim($("#searchBuyBeginMth").val())>12){
            	  $("#searchBuyBeginMth").removeClass().addClass("inputText w80  errorInput");
				  errorCount++;
            	  
                 }
             if($.trim($("#searchBuyEndMth").val())<0 || $.trim($("#searchBuyEndMth").val())>12){
           	  $("#searchBuyEndMth").removeClass().addClass("inputText w80  errorInput");
			  errorCount++;         	  
                }
             
		 
		  if(errorCount==0){
            //加载查询信息
               searchSeId=$.trim($("#searchSeId").val());
			   searchBuyBeginMth = $.trim($("#searchBuyBeginMth").val());
			   searchBuyEndMth = $.trim($("#searchBuyEndMth").val());
			   searchTopicName = $.trim($("#searchTopicName").val());
			   searchCreatDate = $.trim($("#searchCreatDate").val());
               //执行查询信息
			   readItemSeTopicSettingInfos(1,20);
			  }


		 });
    
	  //清空所有查询条件信息
	   $("#searchClearBtn").click(function(){
		   $("#searchItemSeTopicDiv :input").val("");
		   $("#searchItemSeTopicDiv :input").removeClass("errorInput");
		   });

	   //加载查询获得各个焦点事件
	   $("#searchItemSeTopicDiv [name=searchNum]").focus(function(){
			  $(this).removeClass().addClass("inputText w80");
			  $(this).attr("title","请输入数字");
		   });

	   //加载查询获得各个焦点事件
	   $("#searchItemSeTopicDiv [name=searchMonth]").focus(function(){
			  $(this).removeClass().addClass("inputText w80");
			  $(this).attr("title","请输入正确的月份");
		   });

	    //回车事件绑定
	     $("#searchItemSeTopicDiv").unbind("keypress").keypress(function(event){		
	    	if(event!== null && event.keyCode == 13){
	    		$("#seTopicSearchBtn").focus();
	    		$("#seTopicSearchBtn").click();
	    		} 
	    }); 
</script>


<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">主题设定</div>
	<div class="tags tags_left_on"></div>
	<!--最后一个-->
	<div class="tagsM" id="itemSeSearch">SE商品查询</div>
	<div class="tags tags3_r_off"></div>
</div>
<div class="Container-1">
	<div class="Search Bar_on">
		<!-- Bar_on-->
		<div class="SearchTop">
			<span>查询条件</span>
			<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
		</div>
		<div class="line"></div>
		<div class="SMiddle" id="searchItemSeTopicDiv">
			<table class="SearchTable">
				<tr>
					<td class="ST_td1"><span>SE期数</span></td>
					<td><input type="text" id="searchSeId" name="searchNum" class="inputText w80" /></td>
				</tr>
				<tr>
					<td><span>开始月份</span></td>
					<td>
					<input type="text" id="searchBuyBeginMth" name="searchMonth" class="inputText w80" />
					</td>
				</tr>
				<tr>
					<td><span>结束月份</span></td>
					<td>
					<input type="text" id="searchBuyEndMth" name="searchMonth" class="inputText w80" />
					</td>
				</tr>
				<tr>
					<td><span>SE主题</span></td>
					<td><input type="text" id="searchTopicName" class="inputText w80"/></td>
				</tr>
				<tr>
					<td><span>创建日期</span></td>
					<td><input class="Wdate w80" type="text"
						id="searchCreatDate"  onclick="WdatePicker({ isShowClear: false, readOnly: true })" /></td>
				</tr>
			</table>
		</div>
		<div class="line"></div>
		<div class="SearchFooter">
			<div class="Icon-size1 Tools20" id="searchClearBtn"></div>
			<div class="Icon-size1 Tools6" id="seTopicSearchBtn"></div>
		</div>
	</div>
	<div class="Content" id="seTopicSettingInfo">
		<table id="itemSupList" style="height: 570px;"></table>
	</div>
</div>
