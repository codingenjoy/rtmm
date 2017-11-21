<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<style type="text/css">
.Table_Panel td {
	height: 30px;	
}
.paging .page_list{
width:350px;
}
.Panel_footer div{
margin-top:3px;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#unionSearchField").keydown(function(e){ 
			if(e.keyCode == 13){ 
				pageQuery1(); 
            	return false;
			} 
		}); 
	});

	function createCompany(){
		closePopupWin();
		showContent(ctx+'/supplier/company/createSupCompany');
	}
	
	function pageQuery1() {
		var unionSearchField =  $('#unionSearchField').val()=='输入公司名称或公司编号或税号查询'?'':$('#unionSearchField').val();
		if(unionSearchField==''){
			top.jAlert('warning','请输入条件进行查询','提示信息');
			return;
		}
		var pageNo =  $('#chooseSupComFrom').find('input[name=pageNo1]').val();
		var pageSize  = $('#chooseSupComFrom').find('select[name=pageSize]').val();
		$.ajax({
				type : "post",
				data : {
					'unionSearchField' : unionSearchField,
					'pageNo'  : pageNo,
					'pageSize': pageSize
				},
				dataType : "html",
				url : ctx + '/commons/window/chooseSupComList',
				success : function(data) {
					$('#choose_company_content').html(data);
					<auchan:operauth ifAnyGrantedCode="111211996"> 
						if($('#choose_company_content').find('tr').size()==0){
							$('#choose_company_content').html("没有找到匹配的公司，你可以创建公司<div class='Tools11 td2_4' title='新增' style='width: 16px;height: 20px;cursor: pointer;margin-left: 210px;margin-top: -18px;' onclick='createCompany()'></div>");
						}
					</auchan:operauth>
				}
		});
	}
</script>

<div class="Panel_top">
	<span>选择公司</span>
	<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div style="margin: 15px auto; width: 97%; height: 100%;">
		<form id="chooseSupComFrom">
		<div style="height: 30px; background: #CCC;">
			<div class="Icon-div">
				<input type="text" class="IS_input" value="" id="unionSearchField" placeholder="输入公司名称或公司编号或税号查询"/>
				<div class="cbankIcon" onclick="pageQuery1()"></div>
			</div>
		</div>
		<div class="htable_div">
			<table>
				<thead>
					<tr>
						<td>
							<div class="t_cols" style="width: 100px;">公司编号</div>
						</td>
						<td>
							<div class="t_cols" style="width: 300px;">公司名称</div>
						</td>
						<td>
							<div class="t_cols" style="width: 150px;">公司税号</div>
						</td>
						<td>
							<div style="width: 16px;">&nbsp;</div>
						</td>
					</tr>
				</thead>
			</table>
		</div>
		<div class="Content" id="choose_company_content">
		</div>
		</form>
	</div>
</div>
<!-- <div class="Panel_footer">
     <div class="PanelBtn1 pt_div" style="margin-left: 150px;" onclick="confirmBtn()">确认</div>
     <div class="PanelBtn1 pt_div" onclick="wipeBtn()">清除</div>
     <div class="PanelBtn2 pt_div" onclick="closePopupWin()">取消</div>
</div> -->