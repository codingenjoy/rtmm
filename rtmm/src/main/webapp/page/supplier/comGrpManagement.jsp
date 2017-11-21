<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<%-- <script src="${ctx}/shared/js/supplier/comGrp.js" charset="UTF-8" type="text/javascript"></script> --%>
<jsp:include page="/page/supplier/comGrpBase.jsp" />
<style>
    .my-head-td-ck,.ck,.my-head-td-ck div,.ck div{
        display : none;
    }
    .datagrid-body{
    	overflow-x:hidden;
    }
    .scroll_bar{overflow-x:auto;}
</style>
<script type="text/javascript">
	var record = new Record();
	$(function() {
		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click",
			function() {
				DispOrHid('B-id');
				//gridbar_B();
		});
		<auchan:operauth ifAnyGrantedCode="111111996">
			$("#Tools11").attr('class', "Icon-size1 Tools11 B-id").unbind("click").bind("click",
				function() {
					createComGrp();
			});
			$("#Tools12").attr('class', "Icon-size1 Tools12 B-id").unbind("click").bind("click",
				function() {
					modifyComGrp();
			});
		</auchan:operauth>
 		$("#supComMess").bind('click', function() {
 				companyManagement();
		}); 
 		$("#supComBrand").unbind().bind('click', function() {
				companyBrandManagement();
		}); 
 		$(".Tools6").unbind().bind('click',function(){
	 			//comGrpSearch();
	 			initPage();
	 			pageQuery();
 		});
/*  		$(".Tools20").unbind().bind('click',function(){
	 			cleanSearch();
 		}); */
 		//comGrpSearch();
 		pageQuery();
 		//回车执行查询
		$(".Search").find('input').keydown(function(e){ 
			if(e.keyCode == 13){ 
				pageQuery(); 
            	return false;
			} 
		}); 
	});
</script>

<script type="text/javascript">
function closeSearch(){
	DispOrHid('C-id');
	//gridbar_C();
}
function initPage(){
	$('#pageNo').val(1);
	var pageSize = $('#pageSize').val();
	if(pageSize==""){
		$('#pageSize').val(20);
	}
}
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
<%--      <div id="first" class="tags1_left tags1_left_on"></div>
     <div id="comGrpMess" class="tagsM tagsM_on">${grp_info }</div>
     <div class="tags tags_left_on"></div>

      <!--中间-->
     <div id="supComMess" class="tagsM">${grp_com }</div>
     <div class="tags tags3_r_off"></div>
      --%>
     <!-- <div class="tags"></div>

     最后一个
     <div class="tagsM">集团品牌</div>
     <div class="tags tags3_r_off"></div> -->
     
     
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div id="comGrpMess" class="tagsM tagsM_on"><auchan:i18n id="102001001"></auchan:i18n></div>
	<div class="tags tags_left_on"></div>

	<!--中间-->
	<div id="supComMess" class="tagsM"><auchan:i18n id="102002001"></auchan:i18n></div>
	<div class="tags"></div>

	<!--最后一个-->
	<div id="supComBrand" class="tagsM"><auchan:i18n id="102003001"></auchan:i18n></div>
	<div class="tags tags3_r_off"></div>
</div>
<div class="Container-1" >
	<div class="Search" style="display: none;" id="supCompanyList">
		<!-- Bar_on-->
		<div class="SearchTop">
			<span><auchan:i18n id="100002013"></auchan:i18n></span> <!-- 查询条件 -->
			<div class="Icon-size1 CircleClose C-id" onclick="closeSearch();"></div>
		</div>
		<div class="line"></div>
		<div class="SMiddle">
		<form id="queryFrom" class="clean_from" action="">
			<table class="SearchTable" border="0" cellspacing="0" cellpadding="0">
                 <tr>
                     <td class="ST_td1"><span>${comgrpNo }</span></td>
                     <td class="ST_td2"><input id="comgrpNoSearch" type="text" class="inputText w80" onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="6"/></td>
                 </tr>
                 <tr>
                     <td><span>${comgrpName }</span></td>
                     <td><input id="comgrpNameSearch" type="text" class="inputText w80" maxlength="20"/></td>
                 </tr>
                 <tr>
                     <td><span>${comgrpEnName }</span></td>
                     <td><input id="comgrpEnNameSearch" type="text" class="inputText w80" maxlength="20"/></td>
                 </tr>
                 <!-- <tr>
                     <td><span>创建日期</span></td>
                     
                     <td><div class="iconPut w80"><input id="" type="text" class="w85" /><div class="C_Func Calendar"></div> </div></td>
                 </tr> -->
            </table>
            </form>
		</div>
		<div class="line"></div>
		<div class="SearchFooter">
			<div class="Icon-size1 Tools20" onclick="cleanSearch();"></div>
			<div class="Icon-size1 Tools6"></div>
		</div>
	</div>

	<div class="Content" id="supCompanyDetailed">
		<table id="dg" style="height: 570px;"></table>
	</div>
</div>
<!-- <div id="supCompanyDetailed">
</div> -->
