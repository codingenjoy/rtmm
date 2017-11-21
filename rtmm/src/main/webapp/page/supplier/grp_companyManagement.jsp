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
		initToolsbar();
 		//companyGrpSearch("${comgrpNo }");
 		pageQuery();
 		//回车执行查询
		$(".Search").find('input').not('[name=comgrpNoSearch]').keydown(function(e){ 
			if(e.keyCode == 13){ 
				pageQuery(); 
            	return false;
			} 
		}); 
		$("#comgrpNoSearch").keydown(function(e){ 
			if(e.keyCode == 13){ 
				//根据comgrpNo查询集团
				var comgrpNo = $(this).val();
				$.post(ctx +'/commons/window/getComGrpByComgrpNo',{'comgrpNo':comgrpNo}, function(data){
					 if(data.comGrpVO && data.comGrpVO.comgrpNo){
						$('#comgrpNameSearch').attr("value",data.comGrpVO.comgrpName);
						pageQuery();
					}else{
						top.jAlert('warning',comgrpNo+'集团不存在，请确认后重新输入','提示消息');
						$('#comgrpNoSearch').attr("value",'');
						$('#comgrpNoSearch').focus();
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
	function initPage(){
		$('#pageNo').val(1);
		var pageSize = $('#pageSize').val();
		if(pageSize==""){
			$('#pageSize').val(20);
		}
	}
	function pageQuery(){
		var comgrpNoSearch =  $.trim($("#comgrpNoSearch").val());
		if (comgrpNoSearch == "") {
			comgrpNoSearch = $.trim('${comgrpNo }');
		}
		var comNoSearch = $("#comNoSearch").val();
		var comNameSearch = $("#comNameSearch").val();
		var comEnNameSearch = $("#comEnNameSearch").val();
		var econTypeSearch = $("#econTypeSearch").val();
		var unifmNoSearch = $("#unifmNoSearch").val();
		var cityNameSearch = $("#cityNameSearch").val();
		var creatDateSearch = $("#creatDateSearch").val();
		var pageNo = $('#pageNo').val();
		var pageSize = $('#pageSize').val();
		$.ajax({
		        type : "post",
		        async : false,
		        url : ctx + "/supplier/company/companyGrpListPage" ,
		        dataType : "html",
		        data : {
					'comgrpNo':comgrpNoSearch,
					'comNo':comNoSearch,
					'comName':comNameSearch,
					'comEnName':comEnNameSearch,
					'econType':econTypeSearch,
					'unifmNo':unifmNoSearch,
					'cityName':cityNameSearch,
					'creatDate':creatDateSearch,
					'pageNo' : pageNo,
					'pageSize' : pageSize
		        },
		        success : function(data) {
		           $('#supCompanyDetailed').html(data);
		        }
	   });
		
	}
	function initToolsbar(){
		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click",
				function() {
						DispOrHid('B-id');
						gridbar_B();
		});
		$("#Tools22").attr('class', "Icon-size1 Tools22_disable").bind("click",
				function() {
					//supCompanyGroupDetailed();
					goSupCompanyDetailed($('.btable_checked').attr('id'));
				});
		$("#Tools21").attr('class', "Icon-size1 Tools21_disable").bind("click",
				function() {
					//supCompanyGroupList();
					//显示公司列表
					showContent(ctx+'/supplier/group/companyManagement');
				});
 		$('#comGrpMess').unbind().bind('click', function() {
 			comGrpManagement();
		}); 
 		$("#supComBrand").unbind().bind('click', function() {
			companyBrandManagement();
		});
 		$(".Tools6").unbind().bind('click',function(){
 			//companySearch();
 			//companyGrpSearch("${comgrpNo }");
 			initPage();
 			pageQuery();
 		});
 		$(".Tools20").unbind().bind('click',function(){
 			cleanComSearch();
 		});
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
     <div id="comGrpMess" class="tagsM ">${grp_info }</div>
     <div class="tags tags_right_on"></div>

      <!--中间-->

     <div id="supComMess" class="tagsM tagsM_on">${grp_com }</div>
     <div class="tags tags_left_on"></div>

     <div id="supComBrand" class="tagsM"><auchan:i18n id="102003001"></auchan:i18n></div>
     <div class="tags tags3_r_off"></div>
</div>
<div class="Container-1" id="supCompanyList">
	<div class="Search" style="display: none;"><!-- Bar_on-->
         <div class="SearchTop">
             <span><auchan:i18n id="100002013"></auchan:i18n></span>  <!-- 查询条件 -->
             <div class="Icon-size1 CircleClose C-id" onclick="closeSearch();"></div>
         </div>
         <div class="line"></div>
         <div class="SMiddle">
             <table class="SearchTable" border="0" cellspacing="0" cellpadding="0" >
                 <tr>
                     <td class="ST_td1"><span><auchan:i18n id="102002006"></auchan:i18n></span></td>
                     <td class="ST_td2">
                     <div class="iconPut w80">
                     	<input id="comgrpNoSearch" name="comgrpNoSearch" type="text" class="w85"  onkeyup="value=this.value.replace(/\D+/g,'')"/>
                     	<div class="ListWin" onclick="openSupComgrpWindow()"></div> </div></td>
                 </tr>
                 <tr>
                     <td>&nbsp;</td>
                     <td><input type="text" class="inputText w80 Black" id="comgrpNameSearch" readonly="readonly"/></td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102002002"></auchan:i18n></span></td>
                     <td><input id="comNoSearch" type="text" class="inputText w80" /></td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102002003"></auchan:i18n></span></td>
                     <td><input id="comNameSearch" type="text" class="inputText w80" /></td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102002004"></auchan:i18n></span></td>
                     <td><input id="comEnNameSearch" type="text" class="inputText w80" /></td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102002007"></auchan:i18n></span></td>
                     <td>
                     	<auchan:select id="econTypeSearch" _class="w80" mdgroup="COMPANY_ECON_TYPE" ></auchan:select>
                     </td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102002008"></auchan:i18n></span></td>
                     <td><input id="unifmNoSearch" type="text" class="inputText w80" /></td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102002009"></auchan:i18n></span></td>
                     <td>
                     	<div class="iconPut w80">
	                     	<input id="cityNoSearch" type="text" class="w85" readonly="readonly"/>
	                     	<div class="ListWin" onclick="openCityWindow()" ></div> 
	                     </div>
                     </td>
                 </tr>
                 <tr>
                     <td>&nbsp;</td>
                      <td><input id="cityNameSearch" type="text" class="Black inputText w80" readonly="readonly"/></td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102002010"></auchan:i18n></span></td>
                     
                     <td>
                     	<input id="creatDateSearch" class="Wdate" type="text" onClick="WdatePicker({isShowClear:false,readOnly:true})" style="width: 137px;" >
                     </td>
                 </tr>
             </table>
         </div>
         <div class="line"></div>
         <div class="SearchFooter">
             <div class="Icon-size1 Tools20"></div>
             <div class="Icon-size1 Tools6"></div>
         </div>
     </div>
     <div class="Content" id="supCompanyDetailed">
		<table id="dg" style="height: 570px;"></table>
	</div>
</div>
<div id="supCompanyContext">
</div>
