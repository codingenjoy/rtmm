<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ include file="/page/commons/knockout.jsp"%>
<script src="${ctx}/shared/js/catalog/warehouse.js" type="text/javascript"></script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on"><auchan:i18n id="101002001"></auchan:i18n></div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<form id="queryFrom" class="clean_from">
	<div class="Search" style="display: none">
		<!-- Bar_on-->
		<div class="SearchTop">
			<span><auchan:i18n id="100002013"></auchan:i18n></span> <!-- 查询条件 -->
			<div class="Icon-size1 CircleClose C-id" onclick="{DispOrHid('C-id');gridbar_C();}"></div>
		</div>
		<div class="line"></div>
		<div class="SMiddle">
			<table class="SearchTable">
				<tr>
					<td class="ST_td1">
						<span><auchan:i18n id="101002002"></auchan:i18n></span>
					</td>
					<td class="ST_td2">
						<input name="whseNo" type="text" class="inputText w80" title="数字格式" maxlength="4" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101002003"></auchan:i18n></span>
					</td>
					<td>
						<input name="cityName" type="text" class="inputText w80" maxlength="10" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101002005"></auchan:i18n></span>
					</td>
					<td>
						<input name="postCode" type="text" class="inputText w80" maxlength="6" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
					</td>
				</tr>

				<tr>
					<td>
						<span><auchan:i18n id="101002006"></auchan:i18n></span>
					</td>
					<td>
						<input name="phoneNo" type="text" class="inputText w80" maxlength="12" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101002007"></auchan:i18n></span>
					</td>
					<td>
						<input name="faxNo" type="text" class="inputText w80" maxlength="6" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
					</td>
				</tr>
			</table>
		</div>
		<div class="line"></div>
		<div class="SearchFooter">
			<div class="Icon-size1 Tools20"></div>
			<div class="Icon-size1 Tools6" onclick="search()"></div>
		</div>
	</div>
	<div class="Content" id="warehouse_content">
	</div>
	</form>
</div>
<script type="text/javascript">
	$(document).ready(function (){
		pageQuery();
		$(".SMiddle").keydown(function(e){ 
			if(e.keyCode == 13){ 
				
				$("#pageNo").val(1);
				pageQuery();
				return false;
			} 
		});
		
		$("#Tools1").attr('class',"Icon-size1 Tools1 B-id").bind("click",function(){
			DispOrHid('B-id');
			gridbar_B();
		});
		<auchan:operauth ifAnyGrantedCode="110211996">
			$("#Tools11").attr('class', "Tools11").unbind("click").bind("click", function() {
				openPopupWinTwo(600,370,"/catalog/createWarehouse");
			});
		</auchan:operauth>
     });

	function search() {
		$("#pageNo").val(1);
		pageQuery();
	}
	
	function pageQuery() {
		
		var param = $("#queryFrom").serialize();
		$.ajax({
			type : "post",
			data :param,
			dataType : "html",
			url : ctx + '/catalog/getWarehouseByPage',
			success : function(data) {
				$('#warehouse_content').html(data);
			}
		});
	}

	function onDblClickRow(whseNo){
		viewStaff(staffId);
	}

	function onClickRow(whseNo){
		<auchan:operauth ifAnyGrantedCode="110211996">
			$("#Tools12").removeClass("Tools12_disable").addClass("Tools12").bind("click",function(){
				warehouseUpdata(whseNo);
			});
		</auchan:operauth>
	}
	
</script>