<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/contract/acctGroup/acctGroupCreate.js" type="text/javascript"></script>
<style type="text/css">
.Tb_Panel2 {
	height: 200px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}

.iconPut {
	height: 22px;
	border: 1px solid #999;
}

.twoinput23 {
	width: 25%;
	float: left;
}

.twoinput22 {
	width: 10%;
	float: left;
}

.CM-bar {
	height: 250px;
}

.p52_2_1 {
	width: 680px;
}

.p52_text1 {
	margin-left: 90px;
}

.p52_text2 {
	margin-left: 100px;
}

.p52_text3 {
	margin-left: 80px;
}
</style>
<div class="Panel_top">
	<span>
		<c:choose>
			<c:when test="${action =='create'}">
				创建赞助科目组<%--  <auchan:getStuffName value="jianjian000"/> --%>
			</c:when>
			<c:otherwise>
				修改赞助科目组
			</c:otherwise>
		</c:choose>
	</span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div class="Tb_Panel2" style="height: 400px; margin-left: 5px;">
<form id="searchCreateForm" name="searchCreateForm">
	<div class="t_div1">
		<div class="CM t_div1_1" style="margin-top: 2px;">
			<div class="CM-bar">
				<div>赞助科目组基本信息</div>
			</div>
			<div class="CM-div">
			 
				<table class="CM_table" >
					<tbody>
						<tr>
							<td>
								<span>科目组编号</span>
							</td>
							<td>
								<input type="text" class="inputText w55" name="grpAcctId" maxlength=10 onchange="handleErrorInput(this)" value="${grpAccountVO.grpAcctId}">
							</td>
							<td>
								<span>扣款周期</span>
							</td>
							<td>
								<auchan:select name="dedctFreq" mdgroup="CONTRIBUTION_GRP_ACCOUNT_DEDCT_FREQ" _class="w55" value="${grpAccountVO.dedctFreq}" onchange="RmerrorInput(this)"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>序号</span>
							</td>
							<td>
								<input type="text" class="inputText w55" name="grpAcctSeqNo" maxlength=10 onchange="handleErrorInput(this)" value="${grpAccountVO.grpAcctSeqNo}">
							</td>
							<td>
								<span>目标单位</span>
							</td>
							<td>
							<auchan:select2 name="condValType" mdgroup="CONTRACT_COND_VAL_TYPE" _class="w55" value="${grpAccountVO.condValType}" 
								onchange="handleCondValType()"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>中文名</span>
							</td>
							<td>
								<input type="text" class="inputText w85" name="grpAcctName" maxlength=20 value="${grpAccountVO.grpAcctName}" onchange="RmerrorInput(this)">
							</td>
							<td>
								<span>是否关联主厂商</span>
							</td>
							<td>
							<auchan:select2 name="linkMainSupInd" mdgroup="CONTRACT_LINK_MAIN_SUP_IND" _class="w55" value="${grpAccountVO.linkMainSupInd}" 
								onchange="RmerrorInput(this)"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>英文名</span>
							</td>
							<td>
								<input type="text" class="inputText w85" name="grpAcctEnName" maxlength=20 value="${grpAccountVO.grpAcctEnName}" 
								onchange="RmerrorInput(this)">
							</td>
							<td>
								<span>递增条件</span>
							</td>
							<td>
							<auchan:select2 name="degeeCondInd" mdgroup="CONTRACT_DEGEE_COND_IND" _class="w55" value="${grpAccountVO.degeeCondInd}" 
								onchange="RmerrorInput(this)"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>缩写</span>
							</td>
							<td>
								<input type="text" class="inputText w55" name="grpAcctAbbr" maxlength=10 value="${grpAccountVO.grpAcctAbbr}" onchange="RmerrorInput(this)">
							</td>
							<td>
								<span>使用范围</span>
							</td>
							<td>
								<auchan:select name="usedForType" mdgroup="CONTRIBUTION_GRP_ACCOUNT_USED_FOR_TYPE" _class="w55" value="${grpAccountVO.usedForType}" 
								onchange="RmerrorInput(this)"/>

							</td>
						</tr>
						<tr>
							<td>
								<span>状态</span>
							</td>
							<td>
								<auchan:select name="status" mdgroup="CONTRIBUTION_GRP_ACCOUNT_STATUS" _class="w55" value="${grpAccountVO.status}" 
								onchange="RmerrorInput(this)"/>
							</td>
							<td>
								<span>组别</span>
							</td>
							<td>
								<input type="text" class="inputText w55" name="grpGrpAbbr" onchange="RmerrorInput(this)" value="${grpAccountVO.grpGrpAbbr}" maxlength=10>
							</td>
						</tr>
						<tr>
							<td>
								<span>扣款单位</span>
							</td>
							<td>
							<auchan:select2 name="dedctValType" mdgroup="CONTRACT_DEDCT_VAL_TYPE" _class="w55" value="${grpAccountVO.dedctValType}" 
								onchange="RmerrorInput(this)"/>
							</td>
							<td>
								<span>扣款计算方式</span>
							</td>
							<td>
								<auchan:select name="calcBy" mdgroup="CONTRIBUTION_GRP_ACCOUNT_CALC_BY" _class="w55" value="${grpAccountVO.calcBy}"
								 onchange="RmerrorInput(this)"/>
							</td>
						</tr>
						 <tr>
						    <td>
								<span>费用类型</span>
							</td>
							<td>
								<auchan:select name="feeType" mdgroup="CONTRIBUTION_GRP_ACCOUNT_FEE_TYPE" _class="w55" value="${grpAccountVO.feeType}"
								 onchange="RmerrorInput(this)"/>
							</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr> 
					</tbody>
				</table>
			
			</div>
		</div>
		<div class="CM t_div1_2" style="margin-top: 2px;">
			<div class="CM-bar">
				<div>选中项赞助科目</div>
			</div>
			<div class="CM-div">
				<div class="p52_tb" style="width: 95%">
					<div class="ig">
						<span class="p52_text1">科目编号</span>
						<span class="p52_text2">税率(%)</span>
						<span class="p52_text3">目标单位</span>
					</div>
					<div class="p52_tb1" style="overflow-y: auto; height: 90px">
					</div>
					<div class="ig">
						<input class="sp_icon1 isCheckAllss" type="checkbox" onclick="selectAllAcc(this)">
						<div class="Icon-size2 Tools10 sp_icon2" title="删除" onclick="removeAccId()"></div>
						<div class="Icon-size2 Line-1 sp_icon3"></div>
						<div class="Icon-size2 Tools11 sp_icon4" title="新增" onclick="addAccId()"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
</div>

<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="saveFormSubmit('${action}')">
			<auchan:i18n id="100000002"></auchan:i18n>
		</div>
		<div class="PanelBtn2" onclick="closePopupWin()">
			<auchan:i18n id="100000003"></auchan:i18n>
		</div>
	</div>
</div>
<div id="acctTmp"  style="display: none">
<%@ include file="/page/contract/acctGroup/parts/accountTmp.jsp"%>
</div>
<script type="text/javascript">
	$(function(){
		if('${action}'=='update'){
			var grpAcctId = "${grpAccountVO.grpAcctId}";
			$.post(ctx+'/supplier/contract/acctGroup/getAccountInfo',{'grpAcctId':grpAcctId},function(data){
				$.each(data,function(index,obj){
					addAccId(obj.conbnAcctNo,obj.vatNo,obj.condValType);
				});
			},'json');
			$("#searchCreateForm").find("input[name='grpAcctId']").attr("readonly","readonly");
			$("#searchCreateForm").find("input[name='grpAcctId']").addClass('Black');   
		}
	});
</script>
