<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- Bar_on-->
	<div class="SearchTop">
		<span>查询条件</span>
		<!-- 查询条件 -->
		<div class="Icon-size1 CircleClose C-id"
			onclick="{DispOrHid('C-id');gridbar_C();}"></div>
	</div>
	<div class="line"></div>
	<div class="SMiddle">
		<form id="queryForm" class="clean_from">
			<table class="SearchTable">
				<tr>
					<td><span>模板编号</span></td>
					<td><input id="tmpl_id" name="tmplId" type="text"
						onkeyup="inputNumbers(this)" class="inputText w80" /></td>
				</tr>
				<tr>
					<td><span>使用状态</span></td>
					<td><auchan:select mdgroup="CONTRACT_TMPL_IN_USE_IND"
							_class="select1 w80" name="inUseInd" id="inUseInd" /></td>
				</tr>
				<tr>
					<td><span>创建日期</span></td>
					<td><input name="creatDate" class="Wdate w65 inputText"
						type="text" style="width: 120px;"
						onClick="WdatePicker({isShowClear:false,readOnly:true,onpicking:function(dp){createDateChangeConfirm(dp);}})"></td>
				</tr>
				<tr>
					<td><span>创建人</span></td>
					<td><input name="creatBy" type="text" class="inputText w80" /></td>
				</tr>
				<tr>
					<td><span>修改日期</span></td>
					<td><input name="chngDate" class="Wdate w65 inputText"
						type="text" style="width: 120px;"
						onClick="WdatePicker({isShowClear:false,readOnly:true,onpicking:function(dp){chngDateChangeConfirm(dp);}})"></td>
					<td>
				</tr>
				<tr>
					<td><span>修改人</span></td>
					<td><input type="text" name="chngBy" class="inputText w80"></td>
				</tr>
			</table>
			<input type="hidden" name="pageNo" id="pageNo" value="1"/>
			<input type="hidden" name="pageSize" id="pageSize" value="20"/>
		</form>
	</div>
<div class="line"></div>
<div class="SearchFooter">
	<div class="Icon-size1 Tools20" onclick="clearQuery()"></div>
	<div class="Icon-size1 Tools6" onclick="pageQuery()"></div>
</div>

