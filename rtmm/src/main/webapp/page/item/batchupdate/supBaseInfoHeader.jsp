<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.paging .page_list {
	width: 380px;
}
</style>
<script type="text/javascript">
$(function(){
//initialize the sup checkbox by the whole map is user-defined.
	$.each($("#supBulkEditNo").val().split(','),function(i,val){
		var supNo=val;
		$.each($('.Table_Panel').find('input[name=supNo]'),function(i,val){
			if(supNo==val.value){
				$(val).parent().parent().find(':checkbox').attr('checked','checked');
			}
		});
	});
//initialize the sup checkAllbox by the current page in the  whole map is user-defined.
	$.each($('.Table_Panel').find('input[name=supChk]'),function(i,val){
		if($(val).attr('checked')==undefined){	
		$("#supChkAll").removeAttr('checked');
		return false;
		}
	    $("#supChkAll").attr('checked','checked');
	});

//and or remove the sup object by triggerring the supNo、supName、supStatus.
	$(".addOrRemSup").unbind().bind('click',function(){
		
		var supObj=$(this).parent().parent();
		var supBulkEditNoStr=$("#supBulkEditNo").val();
		var supNo=supObj.find('input[name=supNo]').val();
		var supIndex=supBulkEditNoStr.indexOf(','+supNo+',');
 		if( supObj.find('input:checkbox').attr('checked')=='checked'&&supIndex>=0){		
 			supObj.find('input:checkbox').removeAttr('checked');	
  			supBulkEditNoStr=supBulkEditNoStr.replace(','+supNo+',',',');		
		}
		else if(supObj.find('input:checkbox').attr('checked')!='checked'&&supIndex<0){
			supObj.find('input:checkbox').attr('checked','checked');
 			supBulkEditNoStr=supBulkEditNoStr+supNo+',';
		}
 		$.each($('.Table_Panel').find('input[name=supChk]'),function(i,val){
 			if($(val).attr('checked')==undefined){	
 			$("#supChkAll").removeAttr('checked');
 			return false;
 			}
 		    $("#supChkAll").attr('checked','checked');
 		});
 		$("#supBulkEditNo").val(supBulkEditNoStr);
	});
// and or remove sup object by triggerring the checkbox.
	$('input[name=supChk]').unbind().bind('change',function(){
		
		var supObj=$(this).parent().parent().parent();
		var supBulkEditNoStr=$("#supBulkEditNo").val();
		var supNo=supObj.find('input[name=supNo]').val();
		var supIndex=supBulkEditNoStr.indexOf(','+supNo+',');
		if(supObj.find('input:checkbox').attr('checked')=='checked'&&supIndex<0){
 			supBulkEditNoStr=supBulkEditNoStr+supNo+',';
	}
	else if(supObj.find('input:checkbox').attr('checked')!='checked'&&supIndex>=0){
		supBulkEditNoStr=supBulkEditNoStr.replace(','+supNo+',',',');	
	}
	$("#supBulkEditNo").val(supBulkEditNoStr);
	});
	
});
//and or remove the all sup object in the current page by triggerring the checkAll box. 
function addOrRemSupByChbAll(obj){
	var supBulkEditNoStr=$("#supBulkEditNo").val();
	if($(obj).attr('checked')==undefined||$(obj).attr('checked')==null){
	$.each($('.Table_Panel').find('input[name=supNo]'),function(i,val){
   		if(supBulkEditNoStr.indexOf(","+val.value+",")>=0){
   			supBulkEditNoStr=supBulkEditNoStr.replace(','+val.value+',',',');
   		}
	});
	}
	else{
		$.each($('.Table_Panel').find('input[name=supNo]'),function(i,val){
			
	   		if(supBulkEditNoStr.indexOf(","+val.value+",")<0){
	   			supBulkEditNoStr=supBulkEditNoStr+val.value+',';
			}
		});
	}
	$("#supBulkEditNo").val(supBulkEditNoStr);
}
</script>
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols" style="width: 30px;">
						<input type="checkbox" id="supChkAll" class="isCheckAll"
							onclick="addOrRemSupByChbAll(this)">
					</div></td>
				<td><div class="t_cols" style="width: 80px;">厂编</div></td>
				<td><div class="t_cols" style="width: 415px;">公司名称</div></td>
				<td><div class="t_cols" style="width: 80px;">状态</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 320px;">
	<table class="single_tb">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="sup">
				<tr>
					<td><div class="t_cols"
							style="width: 30px; border-right: 0px !important; text-align: center;">
							<input type="checkbox" name="supChk" class="isCheck">
						</div></td>
					<td><div class="t_cols addOrRemSup"
							style="width: 80px; text-align: right; border-right: 0px !important;">${sup.supNo}&nbsp;&nbsp;</div>
						<input type="hidden" name="supNo" value="${sup.supNo}"></td>
					<td><div class="t_cols addOrRemSup"
							style="width: 415px; border-right: 0px !important;">
							<c:out value="${sup.comName }"></c:out>
						</div> <input type="hidden" name="supName" value="${sup.comName}">
					</td>

					<td><div class="t_cols addOrRemSup"
							style="width: 80px; border-right: 0px !important;">
							<auchan:getDictValue mdgroup="SUPPLIER_STATUS"
								code="${sup.status}"></auchan:getDictValue>
						</div> <input type="hidden" name="status" value="${sup.status}">
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>