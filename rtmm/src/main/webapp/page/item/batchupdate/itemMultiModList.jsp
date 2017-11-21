<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
	   function pageQuery(){	  
		  if($("#flag").val()=="true"){
				top.jConfirm('你需要保存当前页面的信息吗','提示消息',function(ret){
					if(!ret){
						 $("#flag").val("false");
					     if('${forum}'=='itemBaseInfo'){
					    	 itemBaseInfoList('${fields}','${itemNumModStr}');
					     }
					     else if('${forum}'=='itemStoreInfo'){
					    	 itemStoreInfoList('${fields}','${itemNumModStr}','${storeMultiModStr}','${paginStyleId}');
					     }
					     else if('${forum}'=='itemChgPrice'){
					    	itemChgPriList('${itemNumModStr}','${storeMultiModStr}','${paginStyleId}'); 
					     }
					}
				});
		  }
		  else{
			     if('${forum}'=='itemBaseInfo'){
			    	 itemBaseInfoList('${fields}','${itemNumModStr}');
			     }
			     else if('${forum}'=='itemStoreInfo'){
			    	 itemStoreInfoList('${fields}','${itemNumModStr}','${storeMultiModStr}','${paginStyleId}');
			     }
			     else if('${forum}'=='itemChgPrice'){
			    	itemChgPriList('${itemNumModStr}','${storeMultiModStr}','${paginStyleId}'); 
			     }
		  }

		}
	 $(function(){
		 $("#myForm").die().live("click",function(){ 
			 $("#flag").val("true");
		 });
		 $("#Tools6").removeClass('Tools6').addClass('Tools6_disable').unbind();
		 $("#Tools11").removeClass('Tools11').addClass('Tools11_disable').unbind();
		 pageQuery();
	 });
</script>

<input type="hidden" id="flag" value="false" />
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<input type="hidden" id="taskId" />

<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">批量修改</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Content" id="page_content"></div>
</div>
