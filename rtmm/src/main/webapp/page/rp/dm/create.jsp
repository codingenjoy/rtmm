<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="Panel">
	<div class="Panel_top">
		<span>添加DM促销活动</span>
		<div class="PanelClose" onclick="closePopupWin()"></div>
	</div>
	<div class="Table_Panel">
		<div class="ig_top10">
			<div class="icol_text w30">
				<span>RP DM编号</span>
			</div>
			<input type="text" name="rdmNoCreate" class="inputText w20 Black" readonly="readonly" />
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>主题</span>
			</div>
			<input type="text" name="rdmTopicCreate" class="inputText w40" onfocus="removeError(this)" onblur="checkRdmTopic(this)" />
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>活动开始日</span>
			</div>
			<input id="rdmBeginDateCreate" name="rdmBeginDateCreate" class="Wdate w20" type="text"
				 onclick="WdatePicker({onpicked:function(){if(this.value>$dp.$('rdmEndDateCreate').value){$dp.$('rdmEndDateCreate').value='';$dp.$('rdmEndDateCreate').focus();}},isShowClear: false, readOnly: true,minDate:'${minDate}' })" onfocus="removeError(this)" onblur="checkRdmBeginDate(this)" />

		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>活动结束日</span>
			</div>
			<input name="rdmEndDateCreate" id="rdmEndDateCreate" class="Wdate w20" type="text"
				onclick="WdatePicker({ isShowClear: false, readOnly: true,minDate:'#F{$dp.$D(\'rdmBeginDateCreate\')}' })" onfocus="removeError(this)" onblur="checkRdmEndDate(this)"  />

		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>门店最少确认天数</span>
			</div>
			<input type="text" name="stCnfrmDaysCreate" class="inputText w20 align_right" value="" onfocus="removeError(this)" onblur="checkStCnfrmDays(this)" maxlength="2"/>&nbsp;天
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>SCM备货天数</span>
			</div>
			<input type="text" name="scmPrepDaysCreate" class="inputText w20 align_right" value="" onfocus="removeError(this)" onblur="checkScmPrepDays(this)" maxlength="2"/>&nbsp;天
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>门店补货提前天数</span>
			</div>
			<input type="text" name="stDlvryBefDaysCreate" class="inputText w20 align_right" value="" onfocus="removeError(this)" onblur="checkStDlvryBefDays(this)" maxlength="2"/>&nbsp;天
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>创建日期</span>
			</div>
			<input type="text" class="inputText w20 Black" readonly="readonly"/>
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>创建人</span>
			</div>
			<input type="text" class="inputText w20 Black" readonly="readonly" />
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>修改日期</span>
			</div>
			<input type="text" class="inputText w20 Black" readonly="readonly"/>
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>修改人</span>
			</div>
			<input type="text" class="inputText w20 Black" readonly="readonly"/>
		</div>
		<div class="clearBoth"></div>
	</div>
	<div class="Panel_footer">
		<div class="PanelBtn">
			<div class="PanelBtn1" onclick="save('add')">确定</div>
			<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
		</div>
	</div>
	<div class="clearBoth"></div>
</div>
