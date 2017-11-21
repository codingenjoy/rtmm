<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
    <style type="text/css">
        .Table_Panel {
            height:550px;
            overflow:hidden;
        }
        .CM_p {
            height:280px;
            width:595px;
            margin:2px auto 0px auto;
        }
        .t2, .t3 {
            height:240px;
            overflow-x:hidden;
            overflow-y:auto;
            float:left;
            background:#fff;
            margin-top:20px;
            border:1px solid #808080;
        }
        .t2 {
            width:328px;
            margin-left:20px;
        }
        .t3 {
            width:200px;
            margin-left:5px;
        }
        .CM2 {
            background:#f9f9f9;
            width:296px;
            height:240px;
        }
        .b{
            height:209px;overflow:auto;
        }
        .d {
            width:235px;
            height:200px;
            background:#fff;
            margin:20px auto auto 40px;
            border:1px solid #808080;
        }
        .e, .f,.b {
            width:215px;margin:0 auto;line-height:26px;
        }
        .e{
            overflow:auto;
            height:169px;
        }
            .e div,.b div {
                border-top:1px solid #fff;
                height:28px;
                cursor:pointer;
            }
        .f {
            border-top:1px solid #808080;
            height:30px;
        }
        .tree-icon {
            display:none;
        }
        .hh_item2 {
            margin-top:6px;
            height:24px;
        }
        .red_bno_node{
        	color:red;
        }
    </style>
    <form id="step5PanelForm" action="/item/create/doCreateItemStoreInfoAudit" onsubmit="return false;" url="/item/create/doCreateItemStoreInfoAudit">
    <div class="Panel" style="width: 635px;">
	<div class="Panel_top">
		<span><auchan:i18n id="102006071"></auchan:i18n></span>
		<div class="PanelClose" onclick="closePopupWin()"></div>
	</div>
	<div class="Table_Panel">
		<div class="ig">
             <div class="hh_item2"><input type="hidden" id="updataTag">
                  <div class="icol_text w10"><span><auchan:i18n id="103001142"></auchan:i18n></span></div>
                  <div style="width:13%;" class="iconPut iq"><input type="text" class="count_text otherSup" id="supNo" style="width:70%" onblur="if($(this).attr('preval2')!=$(this).val()){getSupplierByInputSupplierId($(this));}"><div class="ListWin" onclick="if($(this).prev().is(':enabled')){$('.curig').removeClass('curig');$(this).parent().parent().addClass('curig');$.ajaxSetup({async:false});openSupWindow();$('#popupWin:visible .Panel_top span').text('选择主厂商');$.ajaxSetup({async:true});}"></div></div>
                  <input type="text" style="width:40%;" readonly="readonly" class="inputText iq supplierName comName">
                  <div class="icol_text w10"><span><auchan:i18n id="103001032"></auchan:i18n></span></div>
                  <select class="w15 bnoName mustInput" name="mops" onchange="changeNodeBNOResult();">
                <option value="B" selected="selected">B</option>
                <option value="N">N</option>
                <option value="O">O</option>
                </select>
             </div>
        </div>
		<div class="CM_p">
			<div class="CM-bar" style="height: 280px;">
				<div><auchan:i18n id="103001143"></auchan:i18n></div>
			</div>
			<div class="t2">
				<ul id="tt"></ul>
			</div>
			<div class="t3">
				<div class="b inputDiv" style="width: 180px;" id="storeDiv">
					<!-- <div class="item2">
						<label><input type="checkbox" name="n" />
						</label>
						<span>998-上海加工中心</span>
					</div> -->
				</div>
				<div class="f" style="width: 180px;">
					<label> <input type="checkbox" name="n" class="checkAll dmcAttr" <c:if test="${dlvryMethd == '2'}">disabled="disabled"</c:if>/>
					</label>
					<span><auchan:i18n id="103001144"></auchan:i18n></span>
				</div>
			</div>
		</div>
		<div style="width: 595px; height: 240px; margin: 3px auto;">
			<div class="CM2" style="float: left;">
				<div class="CM-bar" style="height: 240px;">
					<div><auchan:i18n id="103001145"></auchan:i18n></div>
				</div>
				<div class="d">
					<div class="e inputDiv" id="dcCenterDiv">
					</div>
					<div class="f">
						<label> <input type="checkbox" name="a" class="checkAll jgCsAttr" <c:if test="${dlvryMethd == '2'}">disabled="disabled"</c:if> />
						</label>
						<span><auchan:i18n id="103001144"></auchan:i18n></span>
					</div>
				</div>
			</div>
			<div class="CM2" style="margin-left: 3px; float: right;">
				<div class="CM-bar" style="height: 240px;">
					<div><auchan:i18n id="103001146"></auchan:i18n></div>
				</div>
				<div class="d">
					<div class="e inputDiv" id="machinDiv">
						<c:forEach items="${machiningList}" var="store">
						<div class="item4">
							<label><input type="checkbox" name="storeNo" value="${store.storeNo}" <c:if test="${dlvryMethd == '1'}">disabled="disabled"</c:if> />
							</label>
							<span>${store.storeName}</span>
						</div>
						</c:forEach>
					</div>
					<div class="f">
						<label><input type="checkbox" name="d" class="checkAll dcSupAttr" <c:if test="${dlvryMethd == '1'}">disabled="disabled"</c:if>/>
						</label>
						<span><auchan:i18n id="103001144"></auchan:i18n></span>
					</div>
				</div>
			</div>
		</div>

	</div>
	<div class="Panel_footer">
		<div class="PanelBtn">
			<div class="PanelBtn1" onclick="confirmChoose()"><auchan:i18n id="103001147"></auchan:i18n></div>
			<div class="PanelBtn2" onclick="closePopupWin()"><auchan:i18n id="103001148"></auchan:i18n></div>
		</div>
	</div>
</div>
</form>
<div id="" style="display:none;">

</div>
<script type="text/javascript">
$.post(ctx + "/item/create/getBnoResult","catlgId="+$('#xiaofenleiInput2').val(),function(data){
	 bnoResult = data;
});
$(function(){
	$('#supNo').keydown(function (e) {
        if (e.keyCode == 13) {
        	getSupplierByInputSupplierId($(this));
        }
    });
	$('#machinDiv').text('');
	$('#dcCenterDiv').text('');
	inputToInputIntNumber();
});
function selected(obj){
	if($(obj).attr('checked')!='checked'){
		$(obj).attr('checked','checked');
	}
	else{
		$(obj).removeAttr('checked');
	}
}

function checkedOrUncheckedInputToAllInput(obj){
	var checkBoxDiv = $(obj).parent().parent().parent();
	var cflag = $(obj).attr('checked');
	if (checkBoxDiv.find('input:checkbox:not(:checked)').length > 0 || checkBoxDiv.find('input:checkbox').length == 0) {
		checkBoxDiv.parent().find('.checkAll').removeAttr('checked');
	}
	if (checkBoxDiv.find('input:checkbox:not(:checked)').length == 0 && checkBoxDiv.find('input:checkbox').length > 0) {
		checkBoxDiv.parent().find('.checkAll').attr('checked','checked');
	}
}
</script>