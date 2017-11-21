<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<jsp:include page="/page/commons/knockout.jsp" />
<%-- <script src="${ctx}/shared/js/supplier/comGrp.js" charset="UTF-8" type="text/javascript"></script> --%>
<jsp:include page="/page/supplier/comGrpBase.jsp" />
<script type="text/javascript">
	$(function() {
		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click",
				function() {
						DispOrHid('B-id');
						gridbar_B();
		});
		<auchan:operauth ifAnyGrantedCode="111113996">
			$("#Tools11").attr('class', "Icon-size1 Tools11 B-id").bind("click",
				function() {
				createComGrpBrand("add");
			});
			$("#Tools12").attr('class', "Icon-size1 Tools12_disable B-id").bind("click",
				function() {
				createComGrpBrand("alter");
			});
		</auchan:operauth>
 		$('#comGrpMess').bind('click', function() {
 			comGrpManagement();
		});
 		$("#supComMess").bind('click', function() {
			companyManagement();
		}); 
 		$(".Tools6").bind('click',function(){
 			initPage();
 			pageQuery();
 		});
 		//companyGrpBrandSearch("${comgrpNo }");
 		pageQuery();
 		//回车执行查询
		$(".Search").find('input').not('[name=comgrpBrandNoSearch]').keydown(function(e){ 
			if(e.keyCode == 13){ 
				pageQuery(); 
            	return false;
			} 
		}); 
		$("#comgrpBrandNoSearch").keydown(function(e){ 
			if(e.keyCode == 13){ 
				//根据comgrpNo查询集团
				var comgrpNo = $(this).val();
				$.post(ctx +'/commons/window/getComGrpByComgrpNo',{'comgrpNo':comgrpNo}, function(data){
					 if(data.comGrpVO && data.comGrpVO.comgrpNo){
						$('#comgrpBrandNameSearch').attr("value",data.comGrpVO.comgrpName);
						pageQuery();
					}else{
						top.jAlert('warning',comgrpNo+'集团不存在，请确认后重新输入','提示消息');
						$('#comgrpBrandNoSearch').attr("value",'');
						$('#comgrpBrandNoSearch').focus();
					} 
				}); 
            	return false;
			} 
		}); 
	});
	function closeSearch(){
		DispOrHid('C-id');
		gridbar_C();
	}
	function pageQuery(){
		
		var comgrpBrandNoSearch =  $.trim($("#comgrpBrandNoSearch").val());
		if(!comgrpBrandNoSearch){
			comgrpBrandNoSearch = $.trim('${comgrpNo }');
		}
		var brandNoSearch = $("#brandNoSearch").val();
		var brandNameSearch = $("#brandNameSearch").val();
		var brandEnNameSearch = $("#brandEnNameSearch").val();
		var creatDateSearch = $("#creatDateSearch").val();
		var pageNo = $('#pageNo').val();
		var pageSize = $('#pageSize').val();
		$.ajax({
	        type : "post",
	        async : false,
	        url : ctx + "/supplier/company/companyGrpBrandListPage",
	        dataType : "html",
	        data : {
				'comgrpNo' : comgrpBrandNoSearch,
				'brandId' : brandNoSearch,
				'brandName' : brandNameSearch,
				'brandEnName' : brandEnNameSearch,
				'creatDate' : creatDateSearch,
				'pageNo' : pageNo,
				'pageSize' : pageSize
	        },
	        success : function(data) {
	           $('#supCompanyDetailed').html(data);
	        }
		});
	}
	function companyBrandSearch(){
		pageQuery();
	}

	function clean(){
		$('#comgrpBrandNoSearch').val('');
		$('#comgrpBrandNameSearch').val('');
		$('#creatDateSearch').val('');
		$('#brandNoSearch').val('');
		$('#brandNameSearch').val('');
		$('#brandEnNameSearch').val('');
	}
</script>
<style type="text/css">
    .my-head-td-ck,.ck,.my-head-td-ck div,.ck div{
        display : none;
    }
    .datagrid-body{
    	overflow-x:hidden;
    }
    .scroll_bar{overflow-x:auto;}
</style>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
     <div id="first" class="tags1_left "></div>
     <div id="comGrpMess" class="tagsM "><auchan:i18n id="102001001"></auchan:i18n></div>
     <div id="midden" class="tags"></div>

      <!--中间-->

     <div id="supComMess" class="tagsM"><auchan:i18n id="102002001"></auchan:i18n></div>
     <div id="last" class="tags tags_right_on"></div>
     
     <div id="supComBrand" class="tagsM tagsM_on"><auchan:i18n id="102003001"></auchan:i18n></div>
     <div id="lasts" class="tags tags3_r_on"></div>
     
     <!-- <div class="tags"></div>

     最后一个
     <div class="tagsM">集团品牌</div>
     <div class="tags tags3_r_off"></div> -->
</div>
<div class="Container-1" id="supCompanyList">
	<div class="Search" style="display: none;"><!-- Bar_on-->
		<form class="clean_from">
         <div class="SearchTop">
             <span><auchan:i18n id="100002013"></auchan:i18n></span>  <!-- 查询条件 -->
             <div class="Icon-size1 CircleClose C-id" onclick="closeSearch();"></div>
         </div>
         <div class="line"></div>
         <div class="SMiddle">
             <table class="SearchTable" border="0" cellspacing="0" cellpadding="0" >
                 <tr>
                     <td class="ST_td1"><span><auchan:i18n id="102003002"></auchan:i18n></span></td>
                     <td class="ST_td2">
                     <div class="iconPut w80">
                     	<input id="comgrpBrandNoSearch" name="comgrpBrandNoSearch" type="text" class="w85" onkeyup="value=this.value.replace(/\D+/g,'')"/>
                     	<div class="ListWin" onclick="openSupComgrpWindow()"></div> </div></td>
                 </tr>
                 <tr>
                     <td>&nbsp;</td>
                     <td><input type="text" class="inputText w80 Black" id="comgrpBrandNameSearch" readonly="readonly"/></td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102003003"></auchan:i18n></span></td>
                     <td><input id="brandNoSearch" type="text" class="inputText w80" /></td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102003004"></auchan:i18n></span></td>
                     <td><input id="brandNameSearch" type="text" class="inputText w80" /></td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102003005"></auchan:i18n></span></td>
                     <td><input id="brandEnNameSearch" type="text" class="inputText w80" /></td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102003006"></auchan:i18n></span></td>
                     <td>
                     	<input id="creatDateSearch" class="Wdate" type="text" onClick="WdatePicker({isShowClear:false,readOnly:true})" style="width: 137px;" >
                     </td>
                 </tr>
             </table>
         </div>
         <div class="line"></div>
         <div class="SearchFooter">
             <div class="Icon-size1 Tools20" onclick="clean()"></div>
             <div class="Icon-size1 Tools6" ></div>
         </div>
         </form>
     </div>
     <div class="Content" id="supCompanyDetailed">
		<table id="dg" style="height: 570px;"></table>
	</div>
</div>
<!-- <div id="supCompanyDetailed">
</div> -->
