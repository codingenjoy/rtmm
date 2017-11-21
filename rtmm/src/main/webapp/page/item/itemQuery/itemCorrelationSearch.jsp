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
	//加载jqyeryeasyui页面信息
	var searchItemNo = ""; 
	var searchItemName = "";
	var searchRelativeType = "";
	var searchChildNo = "";
	var searchChildName = "";

	$(function() {
		//默认关闭查询窗口
		 DispOrHid('C-id');
		 searchItemNo = ""; 
		 searchItemName = "";
		 searchRelativeType = "";
		 searchChildNo = "";
		 searchChildName = "";	 
		 readitemCorrnlationInfos(1, 20);
	});


	//翻页信息
	function pageQuery() {
		readitemCorrnlationInfos($("#pageNo").val(), $("#pageSize").val());
	}
	
	//商品关联列表
	function readitemCorrnlationInfos(pageNo, pageSize) {
		$.ajax({
			url : "<c:url value='/itemQueryManagement/readItemCorrelationBypage'/>",
			type : "post",
			dataType : "html",
			data : {
				itemNo:searchItemNo,
				itemName:searchItemName,
				rltnType:searchRelativeType,
				childItemNo:searchChildNo,
				childItemName:searchChildName,
				pageNo : pageNo,
				pageSize : pageSize
			},
			success : function(data) {
				$("#itemCorrnlationSearch").html(data);
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

	//点击查询按钮
	$("#searchCorrelation").unbind().mousedown(function() {
		var errorCount=0;
		if(!isNumber($.trim($("#searchItemNo").val()))){
				  $("#searchItemNo").removeClass().addClass("inputText w80  errorInput");
				  errorCount++;
				  }
		if(!isNumber($.trim($("#searchChildNo").val()))){
				  $("#searchChildNo").removeClass().addClass("inputText w80  errorInput");
				  errorCount++;
				  }
		if(errorCount==0){
			 searchItemNo = $.trim($("#searchItemNo").val()); 
			 searchItemName =  $.trim($("#searchItemName").val());
			 searchRelativeType = $("#searchRelativeType").val();
			 searchChildNo =  $.trim($("#searchChildNo").val());
			 searchChildName =  $.trim($("#searchChildName").val());
             //查询信息
             readitemCorrnlationInfos(1, 20); 				 
			}		
	});

	 //加载查询获得各个焦点事件
	   $("[name=searchCorrelationInput]").focus(function(){
			  $(this).removeClass().addClass("inputText w80");
			  $(this).attr("title","请输入合理的数字");
		   });
	   //加载查询获得各个焦点事件
	   $("[name=searchCorrelationNameInput]").focus(function(){
			  $(this).removeClass().addClass("inputText w80");
			  $(this).attr("title","请输入名称");
		   });

	     //清除选项信息
     $("#searchCorrelationClear").click(function(){
    	  $("#searchCorrelationDiv :input").val("");
    	  $("#searchCorrelationDiv :input").removeClass("errorInput");
    	  searchRelativeType = "";
         });

     //回车事件绑定
     $("#searchCorrelationDiv").unbind("keypress").keypress(function(event){		
    	if(event!== null && event.keyCode == 13){
    		$("#searchCorrelation").focus();
    		 $("#searchCorrelation").mousedown();
    		} 
    }); 

	   
</script>



<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">商品关联查询</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Search Bar_on">
		<!-- Bar_on-->
		<div class="SearchTop">
			<span>查询条件</span>
			<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
		</div>
		<div class="line"></div>
		<div class="SMiddle" id="searchCorrelationDiv">
			<table class="SearchTable">
				<tr>
					<td class="ST_td1"><span>母货号</span></td>
					<td><input type="text" class="inputText w80" id="searchItemNo"  name="searchCorrelationInput"/></td>
				</tr>
				<tr>
					<td><span>母货品名</span></td>
					<td><input type="text" class="inputText w80"
						id="searchItemName" name="searchCorrelationNameInput"/></td>
				</tr>
				<tr>
					<td><span>母货类型</span></td>
					<td><auchan:select id="searchRelativeType"
							mdgroup="ITEM_RELATIVE_RLTN_TYPE" _class="w80"
							/></td>
				</tr>
				<tr>
					<td><span>子货号</span></td>
					<td><input type="text" class="inputText w80"
						id="searchChildNo" name="searchCorrelationInput"/></td>
				</tr>
				<tr>
					<td><span>子货品名</span></td>
					<td><input type="text" class="inputText w80"
						id="searchChildName" name="searchCorrelationNameInput"/></td>
				</tr>
			</table>
		</div>
		<div class="line"></div>
		<div class="SearchFooter">
			<div class="Icon-size1 Tools20" id="searchCorrelationClear"></div>
			<div class="Icon-size1 Tools6" id="searchCorrelation"></div>
		</div>
	</div>
	<div class="Content" id="itemCorrnlationSearch">
	</div>
</div>
