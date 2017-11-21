<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.paging .page_list {
	width: 380px;
}
</style>


<script type="text/javascript">
initOrderItemMsg('${errorMsg}','${clstrName}');

function initOrderItemMsg(errorMsg,clstrName){
	if (errorMsg!= ''){
		top.jWarningAlert(errorMsg);
		$("#clstrdisplay").val("");
	}else if (errorMsg == '' && clstrName != ''){
		$("#clstrdisplay").val(clstrName);
	}
	/*set the checkAll checkbox.*/ 
	setCheckAll();
	/*set the checkbox.*/ 
	setCheckItem();

}

//initialize the item checkbox by the whole map is user-defined.
function setCheckItem(){
	$.each($("#hoOrderItemNo").val().split(','),function(i,val){
		var itemNo=val;
		$.each($('.Table_Panel').find('input[name=itemNo]'),function(i,val){
			if(itemNo==val.value){
				$(val).parent().parent().find(':checkbox').attr('checked','checked');
			}
		});
	});
}

//initialize the item checkAllbox by the current page in the  whole map is user-defined.
function setCheckAll(){
	$.each($('.Table_Panel').find('input[name=itemChk]'),function(i,val){
		if($(val).attr('checked')==undefined){	
		$("#itemChkAll").removeAttr('checked');
		return false;
		}
	    $("#itemChkAll").attr('checked','checked');
	});
}
//and or remove the all item object in the current page by triggerring the checkAll box. 
function addOrRemItemByChbAll(obj){
	uptCheckALLStat(obj);
	var hoOrderItemNoStr=$("#hoOrderItemNo").val();
	if($(obj).attr('checked')==undefined||$(obj).attr('checked')==null){
	$.each($('.Table_Panel').find('input[name=itemNo]'),function(i,val){
   		if(hoOrderItemNoStr.indexOf(','+val.value+',')>=0){
   			hoOrderItemNoStr=hoOrderItemNoStr.replace(','+val.value+',',',');
   		}
	});
	}
	else{
		$.each($('.Table_Panel').find('input[name=itemNo]'),function(i,val){
	   		if(hoOrderItemNoStr.indexOf(','+val.value+',')<0){
	   			hoOrderItemNoStr=hoOrderItemNoStr+val.value+',';
			}
		});
	}
	$("#hoOrderItemNo").val(hoOrderItemNoStr);
}

/*judge if check the checkAllBox when changing the status of the check. */
function uptCheckStat(){
	   var checkAll=true;
	   var itemCheckBoxList=$(".isCheck");
	$.each(itemCheckBoxList,function(index,item){
		if(this.checked==false){
			checkAll=false;
			return false;
		};
		});
	if(!checkAll){	
		$(".isCheckAll").attr("checked",false);
	}
	else{
		$(".isCheckAll").attr("checked",true);
	}
}
/*judge if check all the checkbox*/
function uptCheckALLStat(obj){
	if(obj.checked){
		$(".isCheck").attr("checked",true);	
	}
	else{
		$(".isCheck").attr("checked",false);	
	}
}
//and or remove the item object by triggerring the itemNo、temName、itemStatus.
	function changeItemBodyStat(self){
		uptCheckStat();
		var itemObj=$(self).parent().parent();
		var hoOrderItemNoStr=$("#hoOrderItemNo").val();
		var itemNo=itemObj.find('input[name=itemNo]').val();
		var itemIndex=hoOrderItemNoStr.indexOf(','+itemNo+',');
 		if(itemObj.find('input:checkbox').attr('checked')=='checked'&&itemIndex>=0){		
  			itemObj.find('input:checkbox').removeAttr('checked');	
  			hoOrderItemNoStr=hoOrderItemNoStr.replace(','+itemNo+',',',');		
		}
		else if(itemObj.find('input:checkbox').attr('checked')!='checked'&&itemIndex<0){
 			itemObj.find('input:checkbox').attr('checked','checked');
 			hoOrderItemNoStr=hoOrderItemNoStr+itemNo+',';
		}
 		$.each($('.Table_Panel').find('input[name=itemChk]'),function(i,val){
 			if($(val).attr('checked')==undefined){	
 			$("#itemChkAll").removeAttr('checked');
 			return false;
 			}
 		    $("#itemChkAll").attr('checked','checked');
 		});
 		$("#hoOrderItemNo").val(hoOrderItemNoStr);
 }
// and or remove item object by triggerring the checkbox.
function changeItemCheckBoxStat(self){
	    uptCheckStat();
		var itemObj=$(self).parent().parent().parent();
		var hoOrderItemNoStr=$("#hoOrderItemNo").val();
		var itemNo=itemObj.find('input[name=itemNo]').val();
		var itemIndex=hoOrderItemNoStr.indexOf(','+itemNo+',');
		if(itemObj.find('input:checkbox').attr('checked')=='checked'&&itemIndex<0){
 			hoOrderItemNoStr=hoOrderItemNoStr+itemNo+',';
	}
	    else if(itemObj.find('input:checkbox').attr('checked')!='checked'&&itemIndex>=0){
		hoOrderItemNoStr=hoOrderItemNoStr.replace(','+itemNo+',',',');	
	}
	$("#hoOrderItemNo").val(hoOrderItemNoStr);
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
				<td><div class="t_cols" style="width: 100px;">货号</div></td>
				<td><div class="t_cols" style="width: 415px;">商品名称</div></td>
				<td><div class="t_cols" style="width: 80px;">状态</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 260px;">
	<table class="single_tb">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item">
				<tr>
					<td><div class="t_cols"
							style="width: 30px; border-right: 0px !important; text-align: center;">
							<input type="checkbox" name="itemChk" class="isCheck" onclick="changeItemCheckBoxStat(this)">
						</div></td>
					<td><div class="t_cols addOrRemItem" onclick="changeItemBodyStat(this)"
							style="width: 80px; text-align: right; border-right: 0px !important;">${item.itemNo}&nbsp;&nbsp;</div>
						<input type="hidden" name="itemNo" value="${item.itemNo}">
					</td>
					<td><div class="t_cols addOrRemItem" onclick="changeItemBodyStat(this)"
							style="width: 415px; border-right: 0px !important;">${item.itemName }</div>
						<input type="hidden" name="itemName" value="${item.itemName}">
					</td>

					<td><div class="t_cols addOrRemItem" onclick="changeItemBodyStat(this)"
							style="width: 100px; border-right: 0px !important;">
							<auchan:getDictValue mdgroup="ITEM_BASIC_STATUS"
								code="${item.status}"></auchan:getDictValue>
						</div> <input type="hidden" name="status" value="${item.status}">
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet1.jsp"></jsp:include>
