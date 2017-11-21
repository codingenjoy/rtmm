<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style>
.CInfo .combo,.CInfo input {
	background-color: #cccccc;
}

.is_col0 {
	width: 15px;
}

.his_col0 {
	width: 33px;
}

.iq {
	width: 95%;
}

.htable_div div {
	border-right: solid 1px #ccc;
}

.btable_div td {
	border-right: solid 1px #fff;
}

.btable_checked td {
	border-right: 1px solid #3F9673;
}

.btable_div tr:hover td {
	border-right: 1px solid #9c6;
}

.iconPut {
	background: #fff;
}

.Wdate {
	margin-left: 15px;
}
.inputText {
    padding-right:1px;
}
.s1_col{
   width: 85px;
}
.t2_col{
   width: 170px;
}
.btable_div tr {
	line-height : 20px;
}
</style>
<div class="htable_div">
	<table>
		<thead>
			<tr class="tr_special1">
				<td>
					<div class="t2_col">货号</div>
				</td>
				<td>
					<div class="t2_col">店号/区域</div>
				</td>
				<td colspan="2">
					<div class="t2_col">进价(元)</div>
				</td>
				<td>
					<div class="s1_col">进价增长率</div>
				</td>

				<td colspan="2">
					<div class="t2_col">售价(元)</div>
				</td>
				<td colspan="2">
					<div class="t2_col">售价生效日</div>
				</td>
				<td>
					<div class="s1_col">售价增长率</div>
				</td>
				<td>
					<div class="his_col0"></div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="t2_col">&nbsp;</div>
				</td>
				<td>
					<div class="t2_col">&nbsp;</div>
				</td>
				<td>
					<div class="s1_col">旧</div>
				</td>
				<td>
					<div class="s1_col">新</div>
				</td>
<!-- 				<td colspan="2">
					<div class="t2_col">&nbsp;</div>
				</td> -->
				<td>
					<div class="s1_col">&nbsp;</div>
				</td>
				<td>
					<div class="s1_col">旧</div>
				</td>
				<td>
					<div class="s1_col">新</div>
				</td>
				<td colspan="2">
					<div class="t2_col">&nbsp;</div>
				</td>
				<td>
				    <div class="s1_col">&nbsp;</div>
				</td>
				<td>
				    <div class="his_col0">&nbsp;</div>
				</td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 400px;">
<c:if test="${not empty page.result }">
<form id="myForm">
	<table>
		<tr>
			<td>
				<div class="t2_col">&nbsp;</div>
			</td>
			<td>
				<div class="t2_col">&nbsp;</div>
			</td>
			<td>
				<div class="s1_col right_c">&nbsp;</div>
			</td>
			<td>
				<div class="s1_col">
					<input type="text" class="w95 inputText align_right" name="buyPriceHeader" onkeydown="return valiNormPri(this,event)" onchange="formatNorPri(this,4)">
				</div>
			</td>
<!-- 			<td colspan="2">
				<div class="t2_col">
					<input class="Wdate w80" type="text" name="buyPADateHeader" onclick="WdatePicker({readOnly:true})" readonly="readonly"/>
				</div>
			</td> -->
			<td>
				<div class="s1_col align_right">&nbsp;</div>
			</td>
			<td>
				<div class="s1_col right_c">&nbsp;</div>
			</td>
			<td>
				<div class="s1_col">
					<input type="text" class="w95 inputText align_right" name="sellPriceHeader" onkeydown="return valiNormPri(this,event)" onchange="formatMinPri(this,2)">
				</div>
			</td>
            <td colspan="2">
				<div class="t2_col">
					<input class="Wdate w80" type="text" name="sellPADateHeader" onclick="WdatePicker({readOnly:true})"  readonly="readonly" />
				</div>
			</td>
			<td>
				<div class="s1_col align_right">&nbsp;</div>
			</td>
		</tr>

			<c:forEach items="${page.result}" var="data">
				<tr>
					<td style="width: 79px;">
						<div class="t2_col" title="${data.itemNo}-${data.itemName }">${data.itemNo}-${data.itemName } <input type="hidden" name="itemNo" value="${data.itemNo}">
						</div>
					</td>
					<td>
						<div class="t2_col" title="${data.storeNo}-${data.storeName }">${data.storeNo}-${data.storeName}<input type="hidden" name="storeNo" value="${data.storeNo}">
						</div>
					</td>
					<td>
						<div class="s1_col right_c  normBuyPrice">${data.normBuyPrice}</div>
					</td>
					<td>
						<div class="s1_col">
							<input type="text" class="w95 inputText align_right" name="buyPrice" 
							<c:if test="${not empty data.auditBuyPrice }">
							value="${data.auditBuyPrice }" 
							</c:if>
							onkeydown="return valiNormPri(this,event)" onchange="formatNorPri(this,4)">
						</div>
					</td>
					<td>
						<div class="s1_col align_right buyGroRate"></div>
					</td>
					<td>
						<div class="s1_col right_c  normSellPrice">${data.normSellPrice}</div>
					</td>
					<td>
						<div class="s1_col">
							<input type="text" class="w95 inputText align_right" name="sellPrice"
							<c:if test="${not empty data.auditBuyPrice }">
							value="${data.auditSellPrice }" 
							</c:if>
							 onkeydown="return valiNormPri(this,event)" onchange="formatMinPri(this,2)">
						</div>
					</td>
					<td colspan="2">
						<div class="t2_col">
							<input class="Wdate w80" type="text" name="sellPriceActivDate"  
							<c:if test="${not empty data.auditSellPriceActiveDate }">
							value="<fmt:formatDate pattern="yyyy-MM-dd" value="${data.auditSellPriceActiveDate }" />"  
							</c:if>
							onclick="WdatePicker({readOnly:true})" readonly="readonly"/>
						</div>
					</td>
					<td>
						<div class="s1_col align_right sellGroRate"></div>
					</td>
				</tr>
			</c:forEach>
	</table>
	</form>
	</c:if>
</div>

<script type="text/javascript">
	$(function() {		
	        $(".btable_div").scroll( function () {
	           var left = $(this).scrollLeft();
	           $(".htable_div").scrollLeft(left);
	        });
			$('input[name=buyPriceHeader]').live('blur', function() {
				$('input[name=buyPrice]').attr('value', this.value);
				$('input[name=buyPrice]').change();
			});
			$('input[name=buyPADateHeader]').live('blur', function() {
				$('input[name=buyPriceActivDate]').attr('value', this.value);
			});

			$('input[name=sellPriceHeader]').live('blur', function() {
				$('input[name=sellPrice]').attr('value', this.value);
				$('input[name=sellPrice]').change();
			});

			$('input[name=sellPADateHeader]').live('blur', function() {
				$('input[name=sellPriceActivDate]').attr('value', this.value);
			});
			$('input[name=buyPrice]').live('change',function(){
				
				var newBuyPrice=$(this).val().replace(/,/g,'');
				if(newBuyPrice==undefined||newBuyPrice==""){
					$(this).parent().parent().parent().find(".buyGroRate").text("");
					return false;
				}
				var oldBuyPrice=$.trim($(this).parent().parent().parent().find(".normBuyPrice").html());
				var buyGroRate= Math.round((newBuyPrice-oldBuyPrice)/oldBuyPrice*100)/100;
				$(this).parent().parent().parent().find(".buyGroRate").text(Math.round(buyGroRate*100)+"%");
			});
			$('input[name=sellPrice]').change(function(){
				var newSellPrice=$(this).val().replace(/,/g,'');
				if(newSellPrice==undefined||newSellPrice==""){
					$(this).parent().parent().parent().find(".sellGroRate").text("");
					return false;
				}
				var oldSellPrice=$(this).parent().parent().parent().find(".normSellPrice").html();
				var sellGroRate= Math.round((newSellPrice-oldSellPrice)/oldSellPrice*100)/100;
				$(this).parent().parent().parent().find(".sellGroRate").text(Math.round(sellGroRate*100)+"%");
			});

		    $("#Tools2").attr('class', "Tools2").unbind('click').bind("click",
				function() {
		           if($('#myForm').find(".errorInput").hasClass('errorInput')){
		        	      top.jAlert('warning', '请更正不合法的修改信息','提示消息');
			        	  return false;
			           }
					$.ajax({
						async : false,
						url : ctx + '/item/batchupdate/saveItemPriInfo',
						data : $('#myForm').serialize()+"&taskId="+$("#taskId").val(),
						type : 'POST',
						success : function(data) {
							if(data.status=='success'){
								$("#taskId").val(data.taskId);
								top.jAlert('success', '保存成功','提示消息');
								$("#flag").val("false");
								}
							    else if(data.status=='error'){
							    	top.jAlert('error', '保存失败！','提示消息');
								}
								else if(data.status=='warn'){
									top.jAlert('warning', data.message,'提示消息');
								}
								else{
									top.jAlert('error', data.message,'提示消息');
								}
						},
						error : function() {
							isValid = false; // however you would like to handle this
						}
					});
				});
		    /*initiate the format of the price and trigger the 'blur' that 
		      displays the growth rate of price.*/
		    $('input[name=buyPrice]').change();
		    $('input[name=sellPrice]').change();
	});
</script>
<jsp:include page="/page/item/batchupdate/pageSetByItemNo.jsp"></jsp:include>
