<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	//滚动条事件
	$(document).ready(function() {
		$(".btable_div").scroll(function() {
			var left = $(this).scrollLeft();
			$(".htable_div").scrollLeft(left);
		});
	});
	//提交订单信息
	$(function() {
		$('#Tools26').attr('class', 'Tools26').bind('click', function() {
			if (orderTransArray.length == 0) {
				top.jWarningAlert('请至少选择一条数据信息');
			} else
				submitTrans();
		});

		
		$('.sendOrder_tr').each(function(){		
			var sendOrderRec =  new orderTransRecord($(this).attr('storeNo'),$(this).attr('ordNo'));
			var result = isExistOrderTransRecord(orderTransArray,sendOrderRec);

			if(result >= 0 )
			{
				$(this).find('input:checkbox').attr('checked','checked');
			}
		}); 
		if($('.sendOrder_tr input:checkbox:not(:checked)').size()==0 && $('.sendOrder_tr input:checkbox').size()>0){
			$('input[name=OrderSendCheck]:visible').attr('checked','checked');
		}
	});
	//全选
	function selectOrderSendStatTrace(obj) {
		if ($(obj).attr("checked") == "checked") {
			$("input[name=orderSendStatTraceCheck]").attr("checked", "checked");
		} else {
			$("input[name=orderSendStatTraceCheck]").removeAttr("checked");
		}
		//countChecked();
	}

	function submitTrans() {
		var list = [];
		for(curOrd in orderTransArray)
		{
			list.push({
				'ordNo' : orderTransArray[curOrd].ordNo,
				'storeNo' : orderTransArray[curOrd].storeNo
			});
		}
/* 		$.each($('input[type=checkbox]:checked'), function(index, obj) {
			list.push({
				'ordNo' : $(obj).next().val(),
				'storeNo' : $(obj).next().next().val()
			});
		}); */
		$.post(ctx + '/order/submitStatTrace', {
			'jsonData' : JSON.stringify(list)
		}, function(data) {
			if (data.status == 'success') {
				top.jSuccessAlert(data.message);
				orderTransArray  = new Array();
				search();
			} else {
				top.jAlert('error', '保存失败！！', data.message);
			}
			
		}, 'json');

	}

	function orderTransRecord(storeNo,ordNo)
	{
		this.storeNo = storeNo;
		this.ordNo = ordNo;
	}

	//the ord is already selected
	function isExistOrderTransRecord(ordArr,ord)
	{
		
		var result = -1;

		for(curOrd in ordArr)
		{
			if(ordArr[curOrd].storeNo == ord.storeNo && ordArr[curOrd].ordNo == ord.ordNo)
			{
				result = curOrd;
				break;
			}
		}
		
		return result;
	}

	function setAllToInput(){
		$('.sendOrder_tr').each(function(){
			selectedAllCheckBox($(this).attr('ordNo'),$(this).attr('storeNo'),$(this).find('input:checkbox'),$("input[name=OrderSendCheck]").attr('checked'));
		});
	}

	function selectedAllCheckBox(ordNo,storeNo,obj,checkflag){
		if(checkflag=='checked'){
			obj.attr('checked','checked');
		}
		else{
			obj.attr('checked',false);
		}
		setSendOrder(ordNo,storeNo,obj);
	}

	function setSendOrder(ordNo,storeNo,obj){
		var addOrRem = obj.attr('checked');
		var sendOrderRec =  new orderTransRecord(storeNo,ordNo);
		var result = isExistOrderTransRecord(orderTransArray,sendOrderRec);
		if(addOrRem=='checked'){			
			if(result < 0)
			{
				orderTransArray.push(sendOrderRec);
			}
		}
		else if(addOrRem!='checked'){
			if(result >= 0)
			{
				orderTransArray.splice(result,1);
			}
		}
/* 		$('#seTopicIds1').val(seTopicIds1);
		$('#seTopicName1').val(seTopicName1); */
	}

	function checkBoxStatus(){
		if($('.btable_div:visible input:checkbox:not(:checked)').size()>0 || $('.btable_div:visible input:checkbox').size()==0){
			$('input[name=OrderSendCheck]:visible').attr('checked',false);
		}
		if($('.btable_div:visible input:checkbox').size()>0 && $('.btable_div:visible input:checkbox:not(:checked)').size()==0){
			$('input[name=OrderSendCheck]:visible').attr('checked','checked');
		} 
	}
</script>
<!-- 分页属性 -->
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />

<div class="htable_div">
	<table>
		<thead>
			<tr>

				<td>
					<div class="t_cols align_center" style="width: 20px;">
						<input type="checkbox" onclick="setAllToInput()" name="OrderSendCheck">
					</div>
				</td>
				<td>
					<div class="t_cols" style="width: 180px;">店号</div>
				</td>
				<td>
					<div class="t_cols" style="width: 150px;">订单号码</div>
				</td>
				<td>
					<div class="t_cols" style="width: 150px;">发送通道</div>
				</td>
				<td>
					<div class="t_cols" style="width: 150px;">发送状态</div>
				</td>
				<td>
					<div class="t_cols" style="width: 150px;">发送次数</div>
				</td>
				<td>
					<div class="t_cols" style="width: 180px;">末次发送时间</div>
				</td>

			</tr>
		</thead>
	</table>
</div>

<div class="btable_div" style="height: 509px;">
	<table class="single_tb w100" id='stOrder_tab_List'>
		<c:forEach items="${page.result}" var="orderSendStatTraceInfoVO">

			<tr class="sendOrder_tr" ordNo="${orderSendStatTraceInfoVO.ordNo}" storeNO="${orderSendStatTraceInfoVO.storeNo}">
				<td class="align_center" style="width: 20px;"><input type="checkbox" id="${orderSendStatTraceInfoVO.ordNo}" name="orderSendStatTraceCheck"
					onclick="setSendOrder('${orderSendStatTraceInfoVO.ordNo}','${orderSendStatTraceInfoVO.storeNo}',$(this));checkBoxStatus();"> <input type="hidden" value="${orderSendStatTraceInfoVO.ordNo}"> <input type="hidden"
					value="${orderSendStatTraceInfoVO.storeNo}"></td>
				<td style="width: 181px;" align="left" title="${orderSendStatTraceInfoVO.storeNo }-${orderSendStatTraceInfoVO.storeName }">${orderSendStatTraceInfoVO.storeNo }-${orderSendStatTraceInfoVO.storeName }&nbsp;</td>
				<td style="width: 151px;" align="right">${orderSendStatTraceInfoVO.ordNo }&nbsp;</td>
				<td style="width: 151px;" align="right"><auchan:getDictValue code="${orderSendStatTraceInfoVO.ordAccptMethd }"
						mdgroup="SUPPLIER_ORDR_ACCPT_METHD" />&nbsp;</td>
				<td style="width: 151px;" align="right"><auchan:getDictValue code="${orderSendStatTraceInfoVO.transSttus }" mdgroup="ORD_TRANS_STATE_TRACK_TRANS_STTUS" />&nbsp;</td>
				<td style="width: 151px;" align="right">${orderSendStatTraceInfoVO.nbrTimesTtans }&nbsp;</td>
				<td style="width: 181px;" align="right">${orderSendStatTraceInfoVO.lastOrdTransTime }&nbsp;<%-- <c:if test="${orderSendStatTraceInfoVO.lastOrdTransTime ne null}">
						<fmt:formatDate value="${orderSendStatTraceInfoVO.lastOrdTransTime }" pattern="yyyy-MM-dd" />
					</c:if> --%>
				<td style="width: auto">&nbsp;</td>
			</tr>
		</c:forEach>

	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>