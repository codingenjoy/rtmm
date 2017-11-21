<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" rel="Stylesheet" />
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<style type="text/css">
  .Panelx {
            width:862px;
        }
        .Table_Panel {
            overflow:hidden;
        }
        .ListIcon {
             float: left; 
             margin-top:auto; 
             margin-right:auto; 
        }
        .part1, .part2 {
            float:left;
        }
        .part1 {
            width:550px;margin-top:15px;margin-bottom: 15px;padding: 0px 15px;border-right:1px dashed #999;height:96%;
        }
        .part2 {
            width:250px;height:433px;padding:15px 15px 0;
        }
        .CM-div {
            background:#fff;border:1px solid #999;height:363px;width:248px;overflow-y:auto;
        }
        .item {
            padding:0 10px;line-height:25px;
        }
        .paging .page_list {
            width:auto;
        }
        .ig {
            line-height:30px;padding-left:10px;
        }
        .ckbox {
            margin-right:5px;margin-top:8px;
        }
</style>
<div class="Panelx">
<div class="Panel_top">
	<span>选择厂商</span>
	<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
</div>
<form action="" onsubmit="search();return false;">
<div class="Table_Panel">
	<div class="part1">
		<div style="height: 30px; background: #CCC;">
			<div class="Icon-div">
				<input type="text" id="searchSupName" name="supName" placeholder="请输入厂商编号或名称查询" class="IS_input" />
				<div class="cbankIcon" onClick="search()"></div>
			</div>
		</div>
		<div class="search_tb_p">
			<div id="supDataList" style="height: 340px;"></div>
		</div>
	</div>
	 <div class="part2">
         <div class="ig">
             <input type="checkbox" class="ckbox" checked="checked"/>
             同步修改与原主厂商关联的所有厂商
         </div>
         <div class="GrayBg ig">
             关联原主厂商的厂商列表
         </div>
         <div class="CM-div">
         	<c:forEach items="${richList}" var="richList">
  				 <div class="item">${richList.cntrtId}-${richList.catlgId}-${richList.supNo}-${richList.supName}</div>
			</c:forEach>
         </div>
     </div>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div id="confirm" class="PanelBtn1" onclick="confirmSelected()">确定</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>
</form>
</div>
<script type="text/javascript">
var currEle;
document.onmousedown = function(e) {
	var e = e?e:event
	var d = e.srcElement || e.target;
	currEle = d;
}
	$('#searchSupName').keydown(function(e) {
		if (e.keyCode == 13) {
			search();
		}
	});

	function search() {
		$('#pageNo').val(1);
		pageQuery();
	}

	function pageQuery() {
		var formEle = $(currEle).parents('form');
		var formData = formEle.serialize();
		$.post(ctx+'/supplier/contract/current/supList',formData+"&catlgId="+$('#kebieInput').val(),function(data){
			$('#supDataList').html(data);
		});
	}

	function btable_checked(obj) {
		if (obj.size()==0) {
			top.jAlert('warning', '请选择厂商！', '提示消息');
			return;
		}
		selectCurrentSupplier(obj.attr('supNo'),obj.attr('comName'))
	}
	var supInfo = {};
	//单击事件
	function ClickSelectSupplier(supNo,comName){
		supInfo.supNo = supNo;
		supInfo.comName = comName;
	}
	//双击事件
	function selectCurrentSupplier(supNo,comName){
		$('.depositx .supNo').val(supNo);
		$('.depositx .supName').val(comName);
		$.ajaxSetup({
			async : false
		});
		getSupplierContractDetail(supNo,$('#kebieInput').val());
		if(judgeCheckbox()){
			$('.linkMainSup input[name=chngAllLinkInd]').val(1);
		}else{
			$('.linkMainSup input[name=chngAllLinkInd]').val(0);
		}
		$.ajaxSetup({
			async : true
		});
		closePopupWin();
	}
	
	//确认
	function confirmSelected() {
		if (!supInfo || !supInfo.supNo) {
			top.jAlert('warning', '请选择厂商！', '提示消息');
			return;
		}
		$.ajaxSetup({
			async : false
		});
		selectRebateSupplier(supInfo.supNo);
		if(judgeCheckbox()){
			$('.linkMainSup input[name=chngAllLinkInd]').val(1);
		}else{
			$('.linkMainSup input[name=chngAllLinkInd]').val(0);
		}
		$.ajaxSetup({
			async : true
		});
		closePopupWin();
	}
	//判断   同步修改与原主厂商关联的所有厂商是否勾选
	function judgeCheckbox(){
		var flag = false;
		if($('.Table_Panel .ckbox').is(':checked')){
			flag = true;
		}
		return flag;
	}
</script>
