<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/page/commons/knockout.jsp" />
<jsp:include page="/page/supplier/supplier.jsp" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<script src="${ctx}/shared/js/supplier/company.js" type="text/javascript"></script>
<script type="text/javascript">
	var supplier_comNo = null;
	var supplier_comName= null;
	$(function() {
		//初始化toolsbar按钮
		initToolsbar();
		if ($.trim(supplier_comNo) != "") {
			goSupCompanyDetailed(supplier_comNo);
		} else {
			//supCompanySearch();
			pageQuery();
		}
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
		//gridbar_C();
	}
	function initPage(){
		$('#pageNo').val(1);
		var pageSize = $('#pageSize').val();
		if(pageSize==""){
			$('#pageSize').val(20);
		}
	}
	function initToolsbar(){
		$("#Tools1").unbind().attr('class', "Icon-size1 Tools1 B-id").bind("click",
				function() {
						DispOrHid('B-id');
						//gridbar_B();
		});
		<auchan:operauth ifAnyGrantedCode="111211996"> 
		$("#Tools11").unbind().attr('class', "Icon-size1 Tools11 B-id").bind("click",
				function() {
			createSupCompany();
		});
		</auchan:operauth>
 		$("#comOthAddrMess").unbind().bind('click', function() {
 			comOtherAddrManagement();
		}); 
 		$(".Tools6").unbind().bind('click',function(){
 			//supCompanySearch();
 			initPage();
 			pageQuery();
 		});
 		$(".Tools20").unbind().bind('click',function(){
 			clearSearch();
 		});
		$("#Tools22").unbind().attr('class', "Icon-size1 Tools22_disable").bind("click",
				function() {
					//supCompanyDetailed();
					goSupCompanyDetailed($('.btable_checked').attr('id'));
				});
		$("#Tools21").attr('class', "Icon-size1 Tools21_disable").bind("click",
				function() {
					supCompanyList();
				});
		
		<auchan:operauth ifAnyGrantedCode="111211996"> 
	 		$("#Tools12").attr('class', "Icon-size1 Tools12").unbind("click").bind("click",
					function() {
						modifyCompany();
			}); 
 		</auchan:operauth>
	}
	function goCreateSupplier(comNo){
		<auchan:operauth ifAnyGrantedCode="111311996">
			$.post(ctx + '/supplierAudit/createSupplier',{'action':'create','comNo':comNo},function(data){
				$("#content").html(data);
			},'html');
		</auchan:operauth>
	}
	
</script>

<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
     <!--第一个-->
      <div id="first" class="tags1_left tags1_left_on"></div>
      <div id="supComMess" class="tagsM tagsM_on"><auchan:i18n id="102004001"></auchan:i18n></div>
      <div id="midden" class="tags tags_left_on"></div>
      <!--最后一个-->
      <div id="comOthAddrMess" class="tagsM"><auchan:i18n id="102006068"></auchan:i18n></div><!-- 订货退货地址 -->
      <div id="last" class="tags tags3_r_off"></div>
</div>
<div class="Container-1" id="supCompanyList">
	<div class="Search" style="display: none;"><!-- Bar_on-->
         <div class="SearchTop">
             <span><auchan:i18n id="100002013"></auchan:i18n></span> <!-- 查询条件 -->
             <div class="Icon-size1 CircleClose C-id" onclick="closeSearch();"></div>
         </div>
         <div class="line"></div>
         <div class="SMiddle">
             <table class="SearchTable" border="0" cellspacing="0" cellpadding="0">
                 <tr>
                     <td class="ST_td1"><span><auchan:i18n id="102004006"></auchan:i18n></span></td>
                     <td class="ST_td2"><div class="iconPut w80"><input id="comgrpNoSearch" name="comgrpNoSearch" type="text" class="w85" 
                     onkeyup="value=this.value.replace(/\D+/g,'')"
                     />
                     <div class="ListWin" onclick="openSupComgrpWindow()"></div> </div></td>
                 </tr>
                 <tr>
                     <td>&nbsp;</td>
                     <td><input type="text" class="inputText w80 Black" id="comgrpNameSearch" readonly="readonly"/></td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102004002"></auchan:i18n></span></td>
                     <td><input id="comNoSearch" type="text" class="inputText w80" /></td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102004003"></auchan:i18n></span></td>
                     <td><input id="comNameSearch" type="text" class="inputText w80" /></td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102004004"></auchan:i18n></span></td>
                     <td><input id="comEnNameSearch" type="text" class="inputText w80" /></td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102004007"></auchan:i18n></span></td>
                     <td>
                    	 <auchan:select id="econTypeSearch" _class="w80" mdgroup="COMPANY_ECON_TYPE" ></auchan:select>
                     </td>
                 </tr>
                 <tr>
                     <td><span><auchan:i18n id="102004008"></auchan:i18n></span></td>
                     <td><input id="unifmNoSearch" type="text" class="inputText w80" /></td>
                 </tr>
                 <tr>
                     <td><span>注册城市</span></td>
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
                     <td><span>创建日期</span></td>
                     
                     <td>
                     	<!-- <div class="iconPut w80"><input id="creatDateSearch" type="text" class="w85" /><div class="C_Func Calendar"></div> </div> -->
                     	<input id="creatDateSearch" class="Wdate" type="text" onClick="WdatePicker({isShowClear:false,readOnly:true})" style="width: 137px;">
                     	<!-- <div style="margin:1px 0;"></div><input id="creatDateSearch" class="easyui-datebox" style="width:135px;"/> -->
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