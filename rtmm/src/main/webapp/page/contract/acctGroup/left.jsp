<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="SearchTop">
	<span>查询条件</span>
	<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
</div>
<div class="line"></div>
<div class="SMiddle">
   <form id="searchForm" name="searchForm" class="clean_from">
	<table class="SearchTable ">
	  <div class="Search">
		<tbody>
		      <input type="hidden" id="pageNo" name="pageNo"> 
		      <input type="hidden" id="pageSize" name="pageSize"> 
			<!-- <tr>
				<td class="ST_td1"><span>序号</span></td>
				<td><input name="grpAcctSeqNo" class="w85 inputText" type="text" maxlength=10 onkeyup="this.value=this.value.replace(/\D/g,'')"
					onafterpaste="if(isNaN(this.value))execCommand('undo')"></td>
			</tr> -->
			<tr>
				<td><span>科目组编号</span></td>
				<td><input name="grpAcctId" class="w85 inputText" type="text" maxlength=10 onkeyup="this.value=this.value.replace(/\D/g,'')"
					onafterpaste="if(isNaN(this.value))execCommand('undo')"></td>
			</tr>
			<tr>
				<td><span>中文名</span></td>
				<td><input name="grpAcctName" class="w85 inputText" type="text" maxlength=20></td>
			</tr>
			<tr>
				<td><span>英文名</span></td>
				<td><input name="grpAcctEnName" class="w85 inputText" type="text" maxlength=20></td>
			</tr>
			<tr>
				<td><span>缩写</span></td>
				<td><input name="grpAcctAbbr" class="w85 inputText" type="text" maxlength=10></td>
			</tr>
			<tr>
				<td><span>状态</span></td>
				<td><auchan:select name="status" mdgroup="CONTRIBUTION_GRP_ACCOUNT_STATUS" _class="w85" value="${searchVO.status}" /></td>
			</tr>
			<%-- <tr>
				<td><span>扣款单位</span></td>
				<td><select name="condValType" class="w85">
						<option value="">请选择</option>
						<option value="A">A-金额</option>
						<option value="P">P-百分比</option>
						<option value="A,P">A,P-金额和百分比</option>
				</select></td>
			</tr>
			<tr>
				<td><span>扣款周期</span></td>
				<td><auchan:select name="dedctFreq" mdgroup="CONTRIBUTION_GRP_ACCOUNT_DEDCT_FREQ" _class="w85" value="${searchVO.dedctFreq}" /></td>
			</tr>
			<tr>
				<td><span>目标单位</span></td>
				<td><select name="dedctValType" class="w85">
						<option value="">请选择</option>
						<option value="A">A-金额</option>
						<option value="P">P-百分比</option>
						<option value="A,P">A,P-金额和百分比</option>
				</select></td>
			</tr>
			<tr>
				<td><span>是否关联主厂商</span></td>
				<td><select name="linkMainSupInd" class="w85">
						<option value="">请选择</option>
						<option value="1">是</option>
						<option value="0">否</option>
				</select></td>
			</tr> --%>
			<tr>
				<td><span>递增条件</span></td>
				<td><select name="degeeCondInd" class="w85">
						<option value="">请选择</option>
						<option value="1">是</option>
						<option value="0">否</option>
				</select></td>
			</tr>
			<%-- <tr>
				<td><span>使用范围</span></td>
				<td><auchan:select name="usedForType" mdgroup="CONTRIBUTION_GRP_ACCOUNT_USED_FOR_TYPE" _class="w85" value="${searchVO.usedForType}" /></td>
			</tr>

			<tr>
				<td><span>费用类型</span></td>
				<td><auchan:select name="feeType" mdgroup="CONTRIBUTION_GRP_ACCOUNT_FEE_TYPE" _class="w85" value="${searchVO.feeType}" /></td>
			</tr> --%>
		</tbody>
	 </div> 
	</table>
  </form>
</div>
<div class="line"></div>
<div class="SearchFooter">
	<div class="Icon-size1 Tools20" onclick="clean_form()"></div>
	<div class="Icon-size1 Tools6" onclick="searchFormSubmit()"></div>
</div>
<script>
function clean_form(){
	$.each($(".clean_from").find('input'),function(index,item){
		if(!item.readOnly||$(item).hasClass('Wdate')){
			$(item).removeClass('errorInput');
			$(item).attr('title','');
			$(item).attr('value','');
		}
	});
	$($(".clean_from").find('select')[0]).attr('value','');
	
	$($(".clean_from").find('select')[1]).find("option[value='']").attr('selected','selected');
}
$("#searchForm").keypress(function (e){
	var code = event.keyCode; 
	if (13 == code) { 
		$(".Tools6").click();
	} 
	});
</script>


