<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style>
        .CInfo .combo,.CInfo input{
            background-color:#cccccc;
        }

        .iq {
            width:95%;
        }
        .htable_div div {
            border-right:solid 1px #ccc;
        }
        .btable_div td {
            border-right:solid 1px #fff;
        }
        .btable_checked td {
            border-right:1px solid #3F9673;
        }
        .btable_div tr:hover td {
            border-right:1px solid #9c6;
        }
        .iconPut {
            background:#fff;
        }
        .is_col0 {
            width:2px;
        }
        .his_col0 {
            width:20px;
        }
        .s1_col {
            width: 145px;
        }
       .t2_col {
            width: 291px;
        }
        .right_c {
        text-align: right;
        }
</style>
<div class="htable_div">
	<table>
		<thead>
			<tr class="tr_special1">
				<td>
					<div class="s1_col">货号</div>
				</td>
				<td>
					<div class="s1_col">店号/区域</div>
				</td>
				<c:if test='${fn:indexOf(fields, "status")>=0}'>
					<td colspan="2">
						<div class="t2_col">状态</div>
					</td>
				</c:if>
								<c:if test='${fn:indexOf(fields, "buyPriceLimit")>=0}'>
					<td colspan="2">
						<div class="t2_col">买价限制</div>
					</td>
				</c:if>
								<c:if test='${fn:indexOf(fields, "ordMultiParm")>=0}'>
					<td colspan="2">
						<div class="t2_col">订购倍数</div>
					</td>
				</c:if>
								<c:if test='${fn:indexOf(fields, "dcAttr")>=0}'>
					<td colspan="2">
						<div class="t2_col">DC属性</div>
					</td>
				</c:if>
								<c:if test='${fn:indexOf(fields, "upb")>=0}'>
					<td colspan="2">
						<div class="t2_col">箱含量</div>
					</td>
				</c:if>
								<c:if test='${fn:indexOf(fields, "oplCycle")>=0}'>
					<td colspan="2">
						<div class="t2_col">订货周期</div>
					</td>
				</c:if>
								<c:if test='${fn:indexOf(fields, "mops")>=0}'>
					<td colspan="2">
						<div class="t2_col">BNO属性</div>
					</td>
				</c:if>
								<c:if test='${fn:indexOf(fields, "rcvShelfLifeDays")>=0}'>
					<td colspan="2">
						<div class="t2_col">允许天数</div>
					</td>
				</c:if>
								<c:if test='${fn:indexOf(fields, "dcShelfLifeDays")>=0}'>
					<td colspan="2">
						<div class="t2_col">配送天数</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "rcvAllow")>=0}'>
					<td colspan="2">
						<div class="t2_col">可否收货</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "rtnAllow")>=0}'>
					<td colspan="2">
						<div class="t2_col">可否退货</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "sellAllow")>=0}'>
					<td colspan="2">
						<div class="t2_col">可否销售</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "storeUpdtSpInd")>=0}'>
					<td colspan="2">
						<div class="t2_col">门店变价</div>
					</td>
				</c:if>
								<c:if test='${fn:indexOf(fields, "minSellPrice")>=0}'>
					<td colspan="2">
						<div class="t2_col">最低售价</div>
					</td>
				</c:if>
									<td colspan="2">
						<div class="t2_col">&nbsp;</div>
					</td>
			</tr>
			<tr>
				<td>
					<div class="s1_col">&nbsp;</div>
				</td>
				<td>
					<div class="s1_col">&nbsp;</div>
				</td>
				<c:if test='${fn:indexOf(fields, "status")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "buyPriceLimit")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "ordMultiParm")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "dcAttr")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "upb")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "oplCycle")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "mops")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "rcvShelfLifeDays")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "dcShelfLifeDays")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "rcvAllow")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "rtnAllow")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "sellAllow")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "storeUpdtSpInd")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "minSellPrice")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
									<td colspan="2">
						<div class="t2_col">&nbsp;</div>
					</td>
			</tr>
		</thead>
	</table>
</div>

<div class="btable_div" style="height: 400px;">
<c:if test="${not empty page.result }">
		<form id="myForm">
			<input type="hidden" name="fields" value="${fields}">
	<table>
		<tr>
			<td>
				<div class="s1_col">&nbsp;</div>
			</td>
			<td>
				<div class="s1_col">&nbsp;</div>
			</td>
						<c:if test='${fn:indexOf(fields, "status")>=0}'>
				<td>
					<div class="s1_col"></div>
				</td>
				<td>
					<div class="s1_col">
						<auchan:select mdgroup="ITEM_STORE_INFO_STATUS" name="statusHeader" _class="w95" excludeOpt="0,9"></auchan:select>
					</div>
				</td>
			</c:if>
			<c:if test='${fn:indexOf(fields, "buyPriceLimit")>=0}'>
				<td>
					<div class="s1_col"></div>
				</td>
				<td>
					<div class="s1_col">
						<input type="text" class="w95 inputText" name="buyPriceLimitHeader" onkeydown="return valiNormPri(this,event)" onchange="formatNorPri(this,4)">
					</div>
				</td>
			</c:if>
						<c:if test='${fn:indexOf(fields, "ordMultiParm")>=0}'>
				<td>
					<div class="s1_col"></div>
				</td>
				<td>
					<div class="s1_col">
						<input type="text" class="w95 inputText" name="ordMultiParmHeader" onkeydown="return valiNumMax(this,event,4)">
					</div>
				</td>
			</c:if>
			<c:if test='${fn:indexOf(fields, "dcAttr")>=0}'>
				<td>
					<div class="s1_col"></div>
				</td>
				<td>
					<div class="s1_col">
						<auchan:select mdgroup="ITEM_STORE_INFO_DC_ATTR" name="dcAttrHeader" _class="w95"></auchan:select>
					</div>
				</td>
			</c:if>
			<c:if test='${fn:indexOf(fields, "upb")>=0}'>
				<td>
					<div class="s1_col"></div>
				</td>
				<td>
					<div class="s1_col">
						<input type="text" class="w95 inputText" name="upbHeader" onkeydown="return valiNumMax(this,event,4)">
					</div>
				</td>
			</c:if>
			<c:if test='${fn:indexOf(fields, "oplCycle")>=0}'>
				<td>
					<div class="s1_col"></div>
				</td>
				<td>
					<div class="s1_col">
						<input type="text" class="w95 inputText" name="oplCycleHeader" onkeydown="return valiNumMax(this,event,2)">
					</div>
				</td>
			</c:if>
			<c:if test='${fn:indexOf(fields, "mops")>=0}'>
				<td>
					<div class="s1_col"></div>
				</td>
				<td>
					<div class="s1_col">
						<input type="text" class="w95 inputText" name="mopsHeader" onkeydown="return valiChar(this,event,1)">
					</div>
				</td>
			</c:if>
			<c:if test='${fn:indexOf(fields, "rcvShelfLifeDays")>=0}'>
				<td>
					<div class="s1_col"></div>
				</td>
				<td>
					<div class="s1_col">
						<input type="text" class="w95 inputText" name="rcvShelfLifeDaysHeader" onkeydown="return valiNumMax(this,event,4)">
					</div>
				</td>
			</c:if>
			<c:if test='${fn:indexOf(fields, "dcShelfLifeDays")>=0}'>
				<td>
					<div class="s1_col"></div>
				</td>
				<td>
					<div class="s1_col">
						<input type="text" class="w95 inputText" name="dcShelfLifeDaysHeader" onkeydown="return valiNumMax(this,event,4)">
					</div>
				</td>
			</c:if>
			<c:if test='${fn:indexOf(fields, "rcvAllow")>=0}'>
				<td>
					<div class="s1_col"></div>
				</td>
				<td>
					<div class="s1_col">
						<auchan:select mdgroup="ITEM_STORE_INFO_RCV_ALLOW" name="rcvAllowHeader" style="width:70px;"></auchan:select>
					</div>
				</td>
			</c:if>
			<c:if test='${fn:indexOf(fields, "rtnAllow")>=0}'>
				<td>
					<div class="s1_col"></div>
				</td>
				<td>
					<div class="s1_col">
						<auchan:select mdgroup="ITEM_STORE_INFO_RTN_ALLOW" name="rtnAllowHeader" style="width:70px;"></auchan:select>
					</div>
				</td>
			</c:if>
			<c:if test='${fn:indexOf(fields, "sellAllow")>=0}'>
				<td>
					<div class="s1_col"></div>
				</td>
				<td>
					<div class="s1_col">
						<auchan:select mdgroup="ITEM_STORE_INFO_SELL_ALLOW" name="sellAllowHeader" style="width:70px;"></auchan:select>
					</div>
				</td>
			</c:if>
			<c:if test='${fn:indexOf(fields, "storeUpdtSpInd")>=0}'>
				<td>
					<div class="s1_col"></div>
				</td>
				<td>
					<div class="s1_col">
						<auchan:select mdgroup="ITEM_STORE_INFO_STORE_UPDT_SP_IND" name="storeUpdtSpIndHeader" style="width:70px;"></auchan:select>
					</div>
				</td>
			</c:if>
			
			<c:if test='${fn:indexOf(fields, "minSellPrice")>=0}'>
				<td>
					<div class="s1_col"></div>
				</td>
				<td>
					<div class="s1_col">
						<input type="text" class="w95 inputText" name="minSellPriceHeader" onkeydown="return valiNormPri(this,event)" onchange="formatMinPri(this,2)">
					</div>
				</td>
			</c:if>
		</tr>
			<c:forEach items="${page.result}" var="data">
				<tr>
					<td style="width: 79px;">
						<div class="s1_col" title="${data.itemNo}-${data.itemName}">${data.itemNo}-${data.itemName} <input type="hidden" name="itemNo" value="${data.itemNo}">
						</div>
					</td>
					<td>
						<div class="s1_col" title="${data.storeNo}-${data.storeName}">${data.storeNo}-${data.storeName}<input type="hidden" name="storeNo" value="${data.storeNo}">
						</div>
					</td>
					<c:if test='${fn:indexOf(fields, "status")>=0}'>
						<td>
							<div class="s1_col">
								<auchan:getDictValue mdgroup="ITEM_STORE_INFO_STATUS" code="${data.status}"></auchan:getDictValue></div>
						</td>
						<td>
							<div class="s1_col">
							    <c:if test="${data.status==8}">
								<auchan:select mdgroup="ITEM_STORE_INFO_STATUS" _class="w95" excludeOpt="0,9" disabled="disabled" value="8"></auchan:select>
								</c:if>
								<c:if test="${data.status!=8}">
								<auchan:select mdgroup="ITEM_STORE_INFO_STATUS" name="status" _class="w95" excludeOpt="0,9"></auchan:select>
								</c:if>
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "buyPriceLimit")>=0}'>
						<td>
							<div class="s1_col right_c">${data.buyPriceLimit}&nbsp;&nbsp;</div>
						</td>
						<td>
							<div class="s1_col">
								<input type="text" class="w95 inputText" name="buyPriceLimit" onkeydown="return valiNormPri(this,event)" onchange="formatNorPri(this,4)">
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "ordMultiParm")>=0}'>
						<td>
							<div class="s1_col right_c">${data.ordMultiParm}&nbsp;&nbsp;</div>
						</td>
						<td>
							<div class="s1_col">
								<input type="text" class="w95 inputText" name="ordMultiParm" onkeydown="return valiNumMax(this,event,4)">
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "dcAttr")>=0}'>
						<td>
							<div class="s1_col">
								<auchan:getDictValue mdgroup="ITEM_STORE_INFO_DC_ATTR" code="${data.dcAttr}"></auchan:getDictValue></div>
						</td>
						<td>
							<div class="s1_col">
								<auchan:select mdgroup="ITEM_STORE_INFO_DC_ATTR" name="dcAttr" _class="w95"></auchan:select>
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "upb")>=0}'>
						<td>
							<div class="s1_col right_c">${data.upb}&nbsp;&nbsp;</div>
						</td>
						<td>
							<div class="s1_col">
								<input type="text" class="w95 inputText" name="upb" onkeydown="return valiNumMax(this,event,4)">
							</div>
						</td>
					</c:if>
				    <c:if test='${fn:indexOf(fields, "oplCycle")>=0}'>
						<td>
							<div class="s1_col right_c">${data.oplCycle}&nbsp;&nbsp;</div>
						</td>
						<td>
							<div class="s1_col">
								<input type="text" class="w95 inputText" name="oplCycle" onkeydown="return valiNumMax(this,event,2)">
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "mops")>=0}'>
						<td>
							<div class="s1_col">${data.mops}</div>
						</td>
						<td>
							<div class="s1_col">
								<input type="text" class="w95 inputText" name="mops" onkeydown="return valiChar(this,event,1)">
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "rcvShelfLifeDays")>=0}'>
						<td>
							<div class="s1_col right_c">${data.rcvShelfLifeDays}&nbsp;&nbsp;</div>
						</td>
						<td>
							<div class="s1_col">
								<input type="text" class="w95 inputText" name="rcvShelfLifeDays" onkeydown="return valiNumMax(this,event,4)">
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "dcShelfLifeDays")>=0}'>
						<td>
							<div class="s1_col right_c">${data.dcShelfLifeDays}&nbsp;&nbsp;</div>
						</td>
						<td>
							<div class="s1_col">
								<input type="text" class="w95 inputText" name="dcShelfLifeDays" onkeydown="return valiNumMax(this,event,2)">
							</div>
						</td>
					</c:if>
					
					<c:if test='${fn:indexOf(fields, "rcvAllow")>=0}'>
						<td>
							<div class="s1_col">
								<auchan:getDictValue mdgroup="ITEM_STORE_INFO_RCV_ALLOW"  code="${data.rcvAllow}"></auchan:getDictValue>
							</div>
						</td>
						<td>
							<div class="s1_col">
								<auchan:select mdgroup="ITEM_STORE_INFO_RCV_ALLOW" name="rcvAllow" style="width:70px;"></auchan:select>
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "rtnAllow")>=0}'>
						<td>
							<div class="s1_col">
								<auchan:getDictValue mdgroup="ITEM_STORE_INFO_RTN_ALLOW" code="${data.rtnAllow}"></auchan:getDictValue></div>
						</td>
						<td>
							<div class="s1_col">
								<auchan:select mdgroup="ITEM_STORE_INFO_RTN_ALLOW" name="rtnAllow" style="width:70px;"></auchan:select>
							</div>
						</td>
					</c:if>

					<c:if test='${fn:indexOf(fields, "sellAllow")>=0}'>
						<td>
							<div class="s1_col">
								<auchan:getDictValue mdgroup="ITEM_STORE_INFO_SELL_ALLOW" code="${data.sellAllow}"></auchan:getDictValue></div>
						</td>
						<td>
							<div class="s1_col">
								<auchan:select mdgroup="ITEM_STORE_INFO_SELL_ALLOW" name="sellAllow" style="width:70px;"></auchan:select>
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "storeUpdtSpInd")>=0}'>
						<td>
							<div class="s1_col">
								<auchan:getDictValue mdgroup="ITEM_STORE_INFO_STORE_UPDT_SP_IND"  code="${data.storeUpdtSpInd}"></auchan:getDictValue>
							</div>
						</td>
						<td>
							<div class="s1_col">
								<auchan:select mdgroup="ITEM_STORE_INFO_STORE_UPDT_SP_IND" name="storeUpdtSpInd" style="width:70px;"></auchan:select>
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "minSellPrice")>=0}'>
						<td>
							<div class="s1_col right_c">${data.minSellPrice}&nbsp;&nbsp;</div>
						</td>
						<td>
							<div class="s1_col">
								<input type="text" class="w95 inputText" name="minSellPrice" onkeydown="return valiNormPri(this,event)" onchange="formatMinPri(this,2)">
							</div>
						</td>
					</c:if>
				</tr>
			</c:forEach>
	</table>
	</form>
	</c:if>
</div>

<script type="text/javascript">
	$(function() {
			$(".btable_div").scroll(function(){
				$(".htable_div").scrollLeft($(this).scrollLeft());
			});

		if ('${fn:indexOf(fields, "status")>=0}' == 'true') {
			$('select[name=statusHeader]').bind('change', function() {
				$('select[name=status]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "buyPriceLimit")>=0}' == 'true') {
			$('input[name=buyPriceLimitHeader]').bind('change', function() {
				$('input[name=buyPriceLimit]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "ordMultiParm")>=0}' == 'true') {
			$('input[name=ordMultiParmHeader]').bind('change', function() {
				$('input[name=ordMultiParm]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "dcAttr")>=0}' == 'true') {
			$('select[name=dcAttrHeader]').bind('change', function() {
				$('select[name=dcAttr]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "upb")>=0}' == 'true') {
			$('input[name=upbHeader]').bind('change', function() {
				$('input[name=upb]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "oplCycle")>=0}' == 'true') {
			$('input[name=oplCycleHeader]').bind('change', function() {
				$('input[name=oplCycle]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "mops")>=0}' == 'true') {
			$('input[name=mopsHeader]').bind('change', function() {
				$('input[name=mops]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "rcvShelfLifeDays")>=0}' == 'true') {
			$('input[name=rcvShelfLifeDaysHeader]').bind('change', function() {
				$('input[name=rcvShelfLifeDays]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "dcShelfLifeDays")>=0}' == 'true') {
			$('input[name=dcShelfLifeDaysHeader]').bind('change', function() {
				$('input[name=dcShelfLifeDays]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "rcvAllow")>=0}' == 'true') {
			$('select[name=rcvAllowHeader]').bind('change', function() {
				$('select[name=rcvAllow]').attr('value', this.value);
			});
		}		
		if ('${fn:indexOf(fields, "rtnAllow")>=0}' == 'true') {
			$('select[name=rtnAllowHeader]').bind('change', function() {
				$('select[name=rtnAllow]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "sellAllow")>=0}' == 'true') {
			$('select[name=sellAllowHeader]').bind('change', function() {
				$('select[name=sellAllow]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "storeUpdtSpInd")>=0}' == 'true') {
			$('select[name=storeUpdtSpIndHeader]').bind('change', function() {
				$('select[name=storeUpdtSpInd]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "minSellPrice")>=0}' == 'true') {
			$('input[name=minSellPriceHeader]').bind('change', function() {
				$('input[name=minSellPrice]').attr('value', this.value);
			});
		}

		$("#Tools2").attr('class', "Tools2").unbind('click').bind("click",
				function() {
			        if($('#myForm').find(".errorInput").hasClass('errorInput')){
			        	top.jAlert('warning', '请更正不合法的修改信息','提示消息');
			        	return false;
			        }
					$.ajax({
						async : false,
						url : ctx + '/item/batchupdate/saveItemStoreInfo',
						data : $('#myForm').serialize(),
						type : 'POST',
						success : function(data) {
							if(data.message=='success'){
								top.jAlert('success', '保存成功','提示消息');
								$("#flag").val("false");
								}
							    else if(data.message=='error'){
							    	top.jAlert('error', '保存失败！','提示消息');
								}
								else{
									top.jAlert('warning', data.message,'提示消息');
								}
						},
						error : function() {
							isValid = false; // however you would like to handle this
						}
					});
				});
	});
</script>
<jsp:include page="/page/item/batchupdate/pageSetByItemNo.jsp"></jsp:include>




