<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
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
	
	var itemNo ="0";//货号	
	var orignName="";//产地名称
	var prdcrId ="";//单位编号
	var url="";//查询action
        //查询按钮
	$('#Tools1').attr('class', 'Icon-size1 Tools1 B-id').bind('click',
			function() {
				DispOrHid('B-id');
				gridbar_B();
			});
	 $(function(){
		 readitemOriginInfos(1,20);
		 });
	
	//翻页信息
	function pageQuery() {
		readitemOriginInfos($("#pageNo").val(), $("#pageSize").val());
	}
	
	//产地信息列表
	function readitemOriginInfos(pageNo, pageSize) {
		$.ajax({
			url : '<c:url value='/itemQueryManagement/readItemOriginBypage'/>',
			type : "post",
			dataType : "html",
			data : {
				itemNo:itemNo,
				orignName:orignName,
				prdcrId:prdcrId,
				pageNo : pageNo,
				pageSize : pageSize
			},
			success : function(data) {
				$("#itemOriginList").html(data);
			}
		});
	}
	
	//如果值为null 则定义为‘’
	function setNulltoEmpty(str) {
		if (str == null) {
			str = "";
		}
		return str;
	}
	//验证信息，必须输入数字
	function isNumber(str){
	   var result = str.match(/^[0-9]{0,10}$/); 
	       if (result == null) 
	           return false; 
	       return true; 
	}   	
    //查询产地信息
   $("#searchOrigin").click(function(){
	   var errorCount=0;
	   if($("#searchItemNo").val()=="" && $("#searchOrignName").val()==""){
	    	 $("#searchItemNo").removeClass().addClass("inputText w80  errorInput");
	    	 $("#searchOrignName").removeClass().addClass("inputText w80  errorInput");
	    	 errorCount++;
	       } 
	   
	  if(!isNumber($.trim($("#searchItemNo").val()))){
		  $("#searchItemNo").removeClass().addClass("inputText w80  errorInput");
		  errorCount++;
		  }
	      if(!isNumber($.trim($("searchOrignName").val()))){
		  $("#searchPrdcrId").removeClass().addClass("inputText w80  errorInput");
		  errorCount++;
		  }
		  if(errorCount==0){
		 itemNo =$.trim($("#searchItemNo").val());//货号	
		 orignName=$.trim($("#searchOrignName").val());//产地名称
		 prdcrId =$.trim($("#searchPrdcrId").val());//单位编号
		 //url="<c:url value='/itemQueryManagement/readItemOriginBypage'/>";
         //查询信息
		 readitemOriginInfos(1,20);
			  }		    
	   });

   //加载查询获得各个焦点事件
   $("#searchItemOrignDiv :input").focus(function(){
		  $("#searchItemOrignDiv :input").removeClass().addClass("inputText w80");
		  $("#searchItemOrignDiv :input").attr("title","请输入合理的货号");
	   });
  
   //清空所有查询条件信息
   $("#searchClear").click(function(){
	   $("#searchItemOrignDiv :input").val("");
	   $("#searchItemOrignDiv :input").removeClass("errorInput");
	   });
   
   

   //回车事件绑定
   $("#searchItemOrignDivInfo").unbind("keypress").keypress(function(event){		
  	if(event!== null && event.keyCode == 13){
  		$("#searchOrigin").focus();
  		 $("#searchOrigin").click();
  		} 
  }); 				
	</script>




<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">产地查询</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Search Bar_on" id="searchItemOrignDivInfo">
		<!-- Bar_on-->
		<div class="SearchTop">
			<span>查询条件</span>
			<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
		</div>
		<div class="line"></div>
		<div class="SMiddle" id="searchItemOrignDiv">
			<table class="SearchTable">
				<!--    <tr>
                                <td class="ST_td1"><span>产地</span></td>
                                <td><input type="text" class="inputText w55" /></td>
                            </tr> -->
				<tr>
					<td><span>货号</span></td>
					<td><input type="text" class="inputText w80" id="searchItemNo"
						maxlength="15" /></td>
				</tr>
				<tr>
					<td><span>产地名称</span></td>
					<td><input type="text" class="inputText w80"
						id="searchOrignName" /></td>
				</tr>
				<!--  
                            <tr>
                                <td><span>单位编号</span></td>
                                <td><input type="text" class="inputText w80" id="searchPrdcrId"/>
                                </td>
                            </tr>
                              -->
			</table>
		</div>
		<div class="line"></div>
		<div class="SearchFooter">
			<div class="Icon-size1 Tools20" id="searchClear"></div>
			<div class="Icon-size1 Tools6" id="searchOrigin"></div>
		</div>
	</div>
	<div class="Content" id="itemOriginList" style="width: 74%"></div>
</div>
