<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ include file="/page/commons/toolbar.jsp"%>
<script src="${ctx}/shared/js/catalog/catalogCommon.js" type="text/javascript"></script>
<style type="text/css">
.tb_bg{height: 120px; margin-top: 10px;background:#f9f9f9;}
</style>
<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on"><auchan:i18n id="101006001"></auchan:i18n></div>
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
					<td class="w35">
						<span><auchan:i18n id="101006006"></auchan:i18n></span>
					</td>
					<td>
						<select id="divNo" name="divNo" onchange="sectionSelect(this.value,'secNo')" class="w80">
							<option value=''><auchan:i18n id="100000009"></auchan:i18n></option>
							<c:forEach items="${divisionList }" var="item">
								<option value="${item.id}">${item.id}-${item.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="w35">
						<span><auchan:i18n id="101006007"></auchan:i18n></span>
					</td>
					<td>
						<select id="secNo" name="secNo" class="w80" style="width:135px;">
							<option value=''><auchan:i18n id="100000009"></auchan:i18n></option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="w35">
						<span><auchan:i18n id="101006002"></auchan:i18n></span>
					</td>
					<td>
						<input id="catlgNo" name="catlgNo" type="text" class="inputText w80" title="数字格式" 
						onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="8"/>
					</td>
				</tr>
				<tr>
					<td class="w35">
						<span><auchan:i18n id="101006016"></auchan:i18n></span>
					</td>
					<td>
						<input id="catlgName" name="catlgName" type="text" class="inputText w80" title="大分类名称" />
					</td>
				</tr>
				<tr>
					<td class="w35" class="w80">
						<span><auchan:i18n id="101006005"></auchan:i18n></span>
					</td>
					<td>
						<%-- <auchan:select mdgroup="CL_CATALOG_STATUS" id="status" name="status" _class="w80"></auchan:select> --%>
						<select id="status" name="status" class="w80">
							<option value=""><auchan:i18n id="100000009"></auchan:i18n></option>
							<option value="0">0-尚未生效</option>
							<option value="1">1-正常</option>
							<option value="9">9-删除</option>
						</select>
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
	
	<div class="Content" id="extraInfo">
		<div id="group_content"></div>
		<div id="group_ext_info"></div>
	</div>
	</form>
</div>

<script type="text/javascript">
	
	$(function() {
 		$(".SMiddle").keydown(function(e){ 
			if(e.keyCode == 13){ 
				$("#pageNo").val(1);
				pageQuery();
				return false;
			} 
		}); 
 		
		//新增
		<auchan:operauth ifAnyGrantedCode="110411996">
			$("#Tools11").attr('class', "Tools11").unbind("click").bind("click", function() {
					openCreateGroup();
			});
		</auchan:operauth>
		//删除
		/* $("#Tools10").attr('class', "Tools10_disable").bind("click",function() {
			groupDelete();
		}); */

		//查询按钮
		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click",function() {
			DispOrHid('B-id');
			gridbar_B();
		});
	});

	// 打开创建大分类窗口
	function openCreateGroup() {
		openPopupWin(600, 300, '/catalog/createGroup');
	}

	// 修改大分类
	function groupUpdata() {
		if($('#dg').datagrid('getSelections') != 0){
			openPopupWin(600, 300, '/catalog/groupUpdataAction');
		}
	}

	function search() {
		$("#pageNo").val(1);
		pageQuery();
	}
	

	function pageQuery() {
		
		var number = new RegExp(/^[0-9]{1,8}$/);
		var catlgNo = $('#catlgNo').val();
		if(catlgNo != "" && !number.test($.trim(catlgNo))){
			top.jWarningAlert('大分类请输入数字格式',window.v_messages);
			return;
		}
		
		var param = $("#queryFrom").serialize();
		$.ajax({
			type : "post",
			data :param,
			dataType : "html",
			url : ctx + '/catalog/groupListPage',
			success : function(data) {
				$('#group_content').html(data);
				//默认选中表格第一行
				if($('#group_content').find('table').find("tr").size()>1){
					$('#group_content').find('table').find("tr:eq(0)").trigger('click');
				}else{
					$('#group_ext_info').find('input').attr('value','');
				}
			}
		});
	}
	pageQuery();

	function onClickRow(catlgId,catlgName,catlgEnName,status,divTitle,secTitle,createDate,chngDate,chngBy){
		
		setExtInfo(catlgId,createDate,chngDate,chngBy);//设置选中项额外信息
		//绑定修改按钮
		<auchan:operauth ifAnyGrantedCode="110411002,110411996">
			$("#Tools12").removeClass("Tools12_disable").addClass("Tools12").bind("click",function(){
				openPopupWin(600, 300, '/catalog/updateGroup?catlgId='+catlgId);
			});
		</auchan:operauth>
	}

	/*设置选中项额外信息*/
	function setExtInfo(catlgId,createDate,chngDate,chngBy){
		$.ajax({
			type : "post",
			async : false,
			data :{groupCode:catlgId},
			dataType : "html",
			url : ctx + '/catalog/getGroupExtInfo',
			success : function(data) {
				$('#group_ext_info').html(data);
			}
		});
		$('#createDate').attr('value',createDate);
		$('#chngDate').attr('value',chngDate);
		$('#chngBy').attr('value',chngBy);
		
	}

	function onDblClickRow(comNo){	
	
	}
	
</script>
