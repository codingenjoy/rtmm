<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.paging .page_list {
	width: 380px;
}
</style>
<script type="text/javascript">
$(function(){
//initialize the item checkbox by the whole map is user-defined.
	$.each($("#itemBulkEditNo").val().split(','),function(i,val){
		var itemNo=val;
		$.each($('.Table_Panel').find('input[name=itemNo]'),function(i,val){
			if(itemNo==val.value){
				$(val).parent().parent().find(':checkbox').attr('checked','checked');
			}
		});
	});
//initialize the item checkAllbox by the current page in the  whole map is user-defined.
	$.each($('.Table_Panel').find('input[name=itemChk]'),function(i,val){
		if($(val).attr('checked')==undefined){	
		$("#itemChkAll").removeAttr('checked');
		return false;
		}
	    $("#itemChkAll").attr('checked','checked');
	});

//and or remove the item object by triggerring the itemNo、temName、itemStatus.
	$(".addOrRemItem").unbind().bind('click',function(){
		var itemObj=$(this).parent().parent();
		var itemBulkEditNoStr=$("#itemBulkEditNo").val();
		var itemNo=itemObj.find('input[name=itemNo]').val();
		var itemIndex=itemBulkEditNoStr.indexOf(','+itemNo+',');
 		if(itemObj.find('input:checkbox').attr('checked')=='checked'&&itemIndex>=0){		
  			itemObj.find('input:checkbox').removeAttr('checked');	
  			itemBulkEditNoStr=itemBulkEditNoStr.replace(','+itemNo+',',',');		
		}
		else if(itemObj.find('input:checkbox').attr('checked')!='checked'&&itemIndex<0){
 			itemObj.find('input:checkbox').attr('checked','checked');
 			itemBulkEditNoStr=itemBulkEditNoStr+itemNo+',';
		}
 		$.each($('.Table_Panel').find('input[name=itemChk]'),function(i,val){
 			if($(val).attr('checked')==undefined){	
 			$("#itemChkAll").removeAttr('checked');
 			return false;
 			}
 		    $("#itemChkAll").attr('checked','checked');
 		});
 		$("#itemBulkEditNo").val(itemBulkEditNoStr);
	});
// and or remove item object by triggerring the checkbox.
	$('input[name=itemChk]').unbind().bind('change',function(){
		var itemObj=$(this).parent().parent().parent();
		var itemBulkEditNoStr=$("#itemBulkEditNo").val();
		var itemNo=itemObj.find('input[name=itemNo]').val();
		var itemIndex=itemBulkEditNoStr.indexOf(','+itemNo+',');
		if(itemObj.find('input:checkbox').attr('checked')=='checked'&&itemIndex<0){
 			itemBulkEditNoStr=itemBulkEditNoStr+itemNo+',';
	}
	else if(itemObj.find('input:checkbox').attr('checked')!='checked'&&itemIndex>=0){
		itemBulkEditNoStr=itemBulkEditNoStr.replace(','+itemNo+',',',');	
	}
	$("#itemBulkEditNo").val(itemBulkEditNoStr);
	});
	
});
//and or remove the all item object in the current page by triggerring the checkAll box. 
function addOrRemItemByChbAll(obj){
	var itemBulkEditNoStr=$("#itemBulkEditNo").val();
	if($(obj).attr('checked')==undefined||$(obj).attr('checked')==null){
	$.each($('.Table_Panel').find('input[name=itemNo]'),function(i,val){
   		if(itemBulkEditNoStr.indexOf(','+val.value+',')>=0){
   			itemBulkEditNoStr=itemBulkEditNoStr.replace(','+val.value+',',',');
   		}
	});
	}
	else{
		$.each($('.Table_Panel').find('input[name=itemNo]'),function(i,val){
	   		if(itemBulkEditNoStr.indexOf(','+val.value+',')<0){
	   			itemBulkEditNoStr=itemBulkEditNoStr+val.value+',';
			}
		});
	}
	$("#itemBulkEditNo").val(itemBulkEditNoStr);
}
</script>
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols" style="width: 30px;">
						<input type="checkbox" id="itemChkAll" class="isCheckAll"
							onclick="addOrRemItemByChbAll(this)">
					</div></td>
				<td><div class="t_cols" style="width: 80px;">货号</div></td>
				<td><div class="t_cols" style="width: 415px;">商品名称</div></td>
				<td><div class="t_cols" style="width: 80px;">状态</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 320px;">
	<table class="single_tb">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item">
				<tr>
					<td><div class="t_cols"
							style="width: 30px; border-right: 0px !important; text-align: center;">
							<input type="checkbox" name="itemChk" class="isCheck">
						</div></td>
					<td><div class="t_cols addOrRemItem"
							style="width: 80px; text-align: right; border-right: 0px !important;">${item.itemNo}&nbsp;&nbsp;</div>
						<input type="hidden" name="itemNo" value="${item.itemNo}">
					</td>
					<td><div class="t_cols addOrRemItem"
							style="width: 415px; border-right: 0px !important;">${item.itemName }</div>
						<input type="hidden" name="itemName" value="${item.itemName}">
					</td>

					<td><div class="t_cols addOrRemItem"
							style="width: 80px; border-right: 0px !important;">
							<auchan:getDictValue mdgroup="ITEM_BASIC_STATUS"
								code="${item.status}"></auchan:getDictValue>
						</div> <input type="hidden" name="status" value="${item.status}">
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>

