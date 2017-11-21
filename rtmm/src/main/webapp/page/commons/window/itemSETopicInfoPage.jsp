<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>


<script type="text/javascript">
	/* $('.setopic_tr').live("dblclick", function() {
		var setopicid = $(this).children().eq(0).children().eq(0).text();
		var senm = $(this).children().eq(1).children().eq(0).text();
		closePopupWin();
	}); */
	var seTopicIds1 = $('#seTopicIds1').val();
	var seTopicName1 = $('#seTopicName1').val();
	$(function(){
		$('input:checkbox').each(function(){
			var thval = $(this).val();
			if(seTopicIds1!='' && seTopicIds1.indexOf(','+thval+',')>=0){
				$(this).attr('checked','checked');
			}
		}); 
		if($('.setopic_tr input:checkbox:not(:checked)').size()==0 && $('.setopic_tr input:checkbox').size()>0){
			$('.setAllToInput').attr('checked','checked');
		}
		
		$('#seTopicNameInput').keydown(function (e) {
            if (e.keyCode == 13) {
            	pageQuery();
            }
        });
	});

	function checkBoxStatus(){
		if($('.btable_div:visible input:checkbox:not(:checked)').size()>0 || $('.btable_div:visible input:checkbox').size()==0){
			$('.setAllToInput:visible').attr('checked',false);
		}
		if($('.btable_div:visible input:checkbox').size()>0 && $('.btable_div:visible input:checkbox:not(:checked)').size()==0){
			$('.setAllToInput:visible').attr('checked','checked');
		} 
	}
	
	function setSeTopic(secId,secName,obj){
		var seTopicIds1 = $('#seTopicIds1').val();
		var seTopicName1 = $('#seTopicName1').val();
		var addOrRem = obj.attr('checked');
		if(addOrRem=='checked' && seTopicIds1.indexOf(','+secId+',')<0){
			seTopicIds1=seTopicIds1+secId+',';
			seTopicName1 = seTopicName1+secName+',';
		}
		else if(addOrRem!='checked' && seTopicIds1.indexOf(','+secId+',')>=0){
				seTopicIds1=seTopicIds1.replace(','+secId+',',',');
				seTopicName1 = seTopicName1.replace(','+secName+',',',');
		}
		$('#seTopicIds1').val(seTopicIds1);
		$('#seTopicName1').val(seTopicName1);
	}
	
	function chooseSeTopic(){
		var seTopicIds1 = $('#seTopicIds1').val();
		var seTopicName1 = $('#seTopicName1').val();
		$('#seTopicIds').val(seTopicIds1.substring(0,seTopicIds1.length-1));
		$('#seTopicIds').val(seTopicIds1.substring(1,seTopicIds1.length-1));
		$('#seTopicName').val(seTopicName1.substring(0,seTopicName1.length-1));
		$('#seTopicName').val(seTopicName1.substring(1,seTopicName1.length-1));
		if($('#seTopicIds').val()==','){
			$('#seTopicIds').val('');
			$('#seTopicName').val('');
			$('#seTopicIds').addClass('errorInput');
			$('#seTopicName').addClass('errorInput');
		}
		else{
			$('#seTopicIds').removeClass('errorInput');
			$('#seTopicName').removeClass('errorInput');
		}
		closePopupWin();
	}
	
	function selectedAllCheckBox(secId,secName,obj,checkflag){
		if(checkflag=='checked'){
			obj.attr('checked','checked');
		}
		else{
			obj.attr('checked',false);
		}
		setSeTopic(secId,secName,obj);
	}
	
	function selectedCheckBox(secId,secName,obj){
		if(obj.attr('checked')=='checked'){
			obj.attr('checked',false);
		}
		else{
			obj.attr('checked','checked');
		}
		setSeTopic(secId,secName,obj);
		checkBoxStatus();
	}
	
	function setAllToInput(){
		$('.setopic_tr').each(function(){
			selectedAllCheckBox($(this).attr('topicId'),$(this).attr('topicName'),$(this).find('input:checkbox'),$('.setAllToInput').attr('checked'));
		});
	}
</script>
<style type="text/css">
._w85 {
	width: 85px;
}

._w442 {
	width: 442px;
}

._w30 {
	width: 30px;
}

.paging .page_list {
	width: 350px;
}
.Table_Panel{
height:500px;
}
</style>


<!-- <div class="">
	<div class="panel datagrid datagrid-header">
		<div class="datagrid-body" style="margin-top: 0px; height: 300px;">
			<table border="0" cellspacing="0" cellpadding="0"
				class="datagrid-htable" style="height: 39px;">
				<tbody>
					<tr class="datagrid-header-row" style="width: 371px;">
						<td class="my-head-td-comNo" field="NO"
							style="width: 30px; height: 30px;">
							<div class="datagrid-cell"
								style="text-align: center; width: 30px; height: 30px;">
								<span>SE_ID</span><span class="datagrid-sort-icon">&nbsp;</span>
							</div>
						</td>
						<td class="my-head-td-comNo" field="sqlKey"
							style="width: 175px; height: 30px;">
							<div class="datagrid-cell"
								style="text-align: center; width: 175px; height: 30px;">
								<span>主题名称</span><span class="datagrid-sort-icon">&nbsp;</span>
							</div>
						</td>
					</tr>
					<c:forEach items="${page.result }" var="setopic">
						<tr class='setopic_tr'>
							<td align="left">
								<div class="">${setopic.id}</div>
							</td>
							<td align="right">
								<div class="">${setopic.topicName}</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div> -->
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<input type="hidden" name="pageSize" id="pageSize" value="${page.pageSize }" />
<div class="search_tb_p" style="height:460px;">
	<!-- <table id="update_items" style="height:400px;"></table>-->
	<div class="htable_div">
		<table>
			<thead>
				<tr>
					<td><div class="t_cols align_center" style="width: 30px;">
							<input type="checkbox" name="tck" onclick="setAllToInput();" class="setAllToInput"/>
						</div></td>
					<td><div class="t_cols" style="width: 84px;"><auchan:i18n id="103004002"></auchan:i18n></div></td>
					<td><div class="t_cols" style="width: 441px;"><auchan:i18n id="103004005"></auchan:i18n></div></td>
					<td><div style="width: 16px;">&nbsp;</div></td>
				</tr>
			</thead>
		</table>
	</div>
	<div class="btable_div" style="height: 340px;">
		<table class="single_tb w100">
			<!--multi_tb为多选 width:1001px;-->
			<c:forEach items="${page.result }" var="setopic">

				<tr class='setopic_tr' topicId="${setopic.seId}" topicName="<c:out value="${setopic.topicName}"/>">
					<td class="align_center _w30"><input type="checkbox"
						name="tck" value="${setopic.seId}" onclick="setSeTopic('${setopic.seId}','<c:out value="${setopic.topicName}"/>',$(this));checkBoxStatus();"/></td>
					<td onclick="var obj = $(this).parent().find('input:checkbox');selectedCheckBox('${setopic.seId}','<c:out value="${setopic.topicName}"/>',obj);" class="_w85" style="text-align:right;">${setopic.seId}&nbsp;&nbsp;</td>
					<td onclick="var obj = $(this).parent().find('input:checkbox');selectedCheckBox('${setopic.seId}','<c:out value="${setopic.topicName}"/>',obj);" class="_w442">${setopic.topicName}</td>
					<td onclick="var obj = $(this).parent().find('input:checkbox');selectedCheckBox('${setopic.seId}','<c:out value="${setopic.topicName}"/>',obj);" style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</table>
	</div>	
	<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
	<div class="PanelBtn">
		<div onclick="chooseSeTopic()" class="PanelBtn1"><auchan:i18n id="100000002"></auchan:i18n></div>
		<div onclick="closePopupWin()" class="PanelBtn2"><auchan:i18n id="100000003"></auchan:i18n></div>
	</div>
</div>
