<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/tree.css" rel="Stylesheet" />
<style type="text/css">
.Table_Panel {
	height: 550px;
	overflow: hidden;
}

.CM_p {
	height: 280px;
	width: 595px;
	margin: 20px 2px 0px 20px;
}

.f_c {
	width: 80%;
	height: 20px;
	border-top: #ccc solid 1px;
	margin-left: 30px;
	color: #808080;
	float: left;
	margin-top: 54px;
}

.t2,.t3 {
	height: 240px;
	overflow-x: hidden;
	overflow-y: auto;
	float: left;
	background: #fff;
	margin-top: 20px;
	border: 1px solid #808080;
}

.t2 {
	width: 328px;
	margin-left: 20px;
}

.t3 {
	width: 200px;
	margin-left: 5px;
}

.CM2 {
	background: #f9f9f9;
	width: 296px;
	height: 240px;
	float: right;
	margin-top: 3px;
}

.b {
	height: 209px;
	overflow: auto;
}

.d {
	width: 235px;
	height: 200px;
	background: #fff;
	margin: 20px auto auto 40px;
	border: 1px solid #808080;
}

.e,.f,.b {
	width: 215px;
	margin: 0 auto;
	line-height: 26px;
}

.e {
	overflow: auto;
	height: 169px;
}

.e div,.b div {
	border-top: 1px solid #fff;
	height: 28px;
	cursor: pointer;
}

.f {
	border-top: 1px solid #808080;
	height: 30px;
}

.tree-icon {
	display: none;
}

input[disabled="disabled"] {
	border: 1px solid #6c6c6c;
}

.first_div {
	height: 410px;
	width: 100%;
}

.second_div {
	height: 110px;
	width: 100%;
	margin-top: 2px;
}
</style>

<script type="text/javascript">
	
	$(function() {
		/*check all the store automatically when click the radio named 
		 * pagination by the area.*/
		$("#pagByAreaNo").unbind().bind("click",function(){
		$('#storeDiv').find("input").not('[disabled="disabled"]').attr(
						'checked', true).attr("disabled","disabled");
	    $("#storeCheckAll").attr('checked', true).attr("disabled","disabled");
		});
		$("#pagByStoreNo").unbind().bind("click",function(){
			$('#storeDiv').find("input").attr(
					'checked', false).removeAttr("disabled");
            $("#storeCheckAll").attr('checked', false).removeAttr("disabled");
		});
		$("#pagByItemNo").unbind().bind("click",function(){
			$('#storeDiv').find("input").attr(
					'checked', false).removeAttr("disabled");
            $("#storeCheckAll").attr('checked', false).removeAttr("disabled");
		});
		/**
		 * 新增下傳區域, 選擇下傳區域彈出框: 點選店時檢查全選框
		 */
		$('.item2').die().live('click', function(){
			var tmp = $(this).find("input");
			var name = $(tmp).attr("name");
			if ($(this).find('input').length == 1) {
				if ($(".check[name="+ name + "]:checked").length == $(".check[name="+ name + "]").length){
					$(".checkAll[name="+ name + "]").attr("checked","checked");
				}
				else{
					$(".checkAll[name="+ name + "]").removeAttr("checked");
				}
			}
		});
		
		$('#itemStoreArea').find('li').remove();// 先删除树
		$.post(ctx + "/item/batchupdate/getItemAreaTree",{},
				function(data) {
				$('#itemStoreArea')
			    .tree(
				{
				checkbox : true,
				data : data,
				onCheck : function(node,checked) {
					$.ajax({
					type : "post",
					async : false,
	                url : ctx+ "/item/batchupdate/getStoreByAreaId",
					dataType : "json",
					data : {
					'areaId' : node.id,},
					success : function(data) {
						$.each(data,function(index,item) {
										if (checked) {$("#storeDiv").append(
										"<div class='item2' id='store_"+item.storeNo+"'><label><input type='checkbox' class='check' name='hypeMarketNo' value="+item.storeNo+"></label><span>"
										+item.storeNo+"-"+item.storeName
										+ "</span></div>");
										} else {
										$("#storeDiv").find("div[id=store_"+ item.storeNo+ "]").remove();
										        }
										     });
						if($('input[name="paginationStyle"]:checked').attr("id")=='pagByAreaNo'){						
							$('#storeDiv').find("input").not('[disabled="disabled"]').attr(
									'checked', true).attr("disabled","disabled");
				            $("#storeCheckAll").attr('checked', true).attr("disabled","disabled");
						 }
						 }
					            });
					
					if ($('#storeDiv .item2 :checked').length != 0 && ($('#storeDiv .item2').length == $('#storeDiv .item2 :checked').length)){
						$('#storeCheckAll').attr("checked", "checked");
					}
					else{
						$('#storeCheckAll').removeAttr("checked");
					}}});
				}, "json");

	});
</script>

<div class="Panel_top">
	<span>选择下传区域</span>
	<div class="PanelClose" onclick="closePopupWinTwo()"></div>
</div>
<div class="Table_Panel">
	<div class="" style="width: 615px; height: 523px; float: left;">
		<div class="CM_p CM">
			<div class="CM-bar" style="height: 280px;">
				<div>大卖场</div>
			</div>
			<div class="t2" id="hypeMarCity">
				<ul id="itemStoreArea"></ul>
			</div>
			<div class="t3">
				<div class="b inputDiv" style="width: 180px;" id="storeDiv"></div>
				<div class="f" style="width: 180px;">
					<label> <input id="storeCheckAll" type="checkbox"
						name="hypeMarketNo" class="checkAll"
						onclick="hypeMarketCheckAll(this)" />
					</label> <span>全选</span>
				</div>
			</div>
		</div>
		<div class="p52_2_2">
			<div class="CM2">
				<div class="CM-bar" style="height: 240px;">
					<div>物流中心</div>
				</div>
				<div class="d">
					<div class="e inputDiv" id="dcCenterDiv">
						<c:forEach items="${dcCenterList}" var="store">
							<div class="item2">
								<label><input type="checkbox" class="check"
									name="dcCenterNo" value="${store.storeNo}" /> </label> <span>${store.storeName}</span>
							</div>
						</c:forEach>
					</div>
					<div class="f">
						<label> <input type="checkbox" name="dcCenterNo"
							class="checkAll" onclick="dcCenterCheckAll(this)" />
						</label> <span>全选</span>
					</div>
				</div>
			</div>
			<div class="CM2" style="margin-right: 3px;">
				<div class="CM-bar" style="height: 240px;">
					<div>加工中心</div>
				</div>
				<div class="d">
					<div class="e inputDiv" id="machinDiv">
						<c:forEach items="${machiningList}" var="store">
							<div class="item2">
								<label><input type="checkbox" class="check"
									name="machiningNo" value="${store.storeNo}" /> </label> <span>${store.storeName}</span>
							</div>
						</c:forEach>
					</div>

					<div class="f">
						<label> <input type="checkbox" name="machiningNo"
							class="checkAll" onclick="machinCheckAll(this)" />
						</label> <span>全选</span>
					</div>
				</div>
			</div>

		</div>
	</div>
	<div class="p52_2_1">
		<div class="CM first_div">
			<div class="CM-bar">
				<div>修改项</div>
			</div>

			<div class="CM-div" style="width: 90%;" id="mdfOption">
				<div class="ig" style="margin-top: 15px;">
					<input type="checkbox" id="status" name="lmtMdfOpts" value="status" />
					&nbsp;&nbsp;状态
				</div>
				<div class="ig">
					<input type="checkbox" id="pchaPriLimit" name="lmtMdfOpts"
						value="buyPriceLimit" /> &nbsp;&nbsp;买价限制
				</div>
				<div class="ig">
					<input type="checkbox" id="ordMultiParm" name="lmtMdfOpts"
						value="ordMultiParm" /> &nbsp;&nbsp;订购倍数
				</div>
				<div class="ig">
					<input type="checkbox" id="DCAttr" name="lmtMdfOpts" value="dcAttr" />
					&nbsp;&nbsp;DC属性
				</div>
				<div class="ig">
					<input type="checkbox" id="boxContent" name="lmtMdfOpts"
						value="upb" /> &nbsp;&nbsp;箱含量
				</div>
				<div class="ig">
					<input type="checkbox" id="oplCycle" name="lmtMdfOpts"
						value="oplCycle" /> &nbsp;&nbsp;订货周期
				</div>
				<!-- 			<div class="ig">
				<input type="checkbox" id="mops" name="lmtMdfOpts" value="mops" />
				&nbsp;&nbsp;BNO属性
			</div> -->
				<div class="ig">
					<input type="checkbox" id="rcvShelfLifeDays" name="lmtMdfOpts"
						value="rcvShelfLifeDays" /> &nbsp;&nbsp;允许天数
				</div>
				<div class="ig">
					<input type="checkbox" id="dcShelfLifeDays" name="lmtMdfOpts"
						value="dcShelfLifeDays" /> &nbsp;&nbsp;配送天数
				</div>
				<div class="ig">
					<input type="checkbox" id="rcvAllow" name="lmtMdfOpts"
						value="rcvAllow" /> &nbsp;&nbsp;可否收货
				</div>
				<div class="ig">
					<input type="checkbox" id="ifRtnGoods" name="lmtMdfOpts"
						value="rtnAllow" /> &nbsp;&nbsp;可否退货
				</div>
				<div class="ig">
					<input type="checkbox" id="sellAllow" name="lmtMdfOpts"
						value="sellAllow" /> &nbsp;&nbsp;可否销售
				</div>
				<div class="ig">
					<input type="checkbox" id="storeUpdtSpInd" name="lmtMdfOpts"
						value="storeUpdtSpInd" /> &nbsp;&nbsp;门店变价
				</div>
				<div class="ig">
					<input type="checkbox" id="lowestPrice" name="lmtMdfOpts"
						value="minSellPrice" /> &nbsp;&nbsp;最低售价
				</div>
				<div class="f_c">*最多可同时选择5项修改项。</div>
			</div>
		</div>
		<div class="CM second_div">
			<div class="CM-bar">
				<div>显示方式</div>
			</div>
			<div class="CM-div" style="width: 90%;">
				<div class="ig" style="margin-top: 15px;">
					<input id="pagByItemNo" type="radio" name="paginationStyle"
						checked="checked" />&nbsp;&nbsp;按货号分页显示
				</div>
				<div class="ig">
					<input id="pagByStoreNo" type="radio" name="paginationStyle" />&nbsp;&nbsp;按门店分页显示
				</div>
				<div class="ig">
					<input id="pagByAreaNo" type="radio" name="paginationStyle" />&nbsp;&nbsp;按区域分页显示
				</div>
			</div>
		</div>
	</div>
</div>
<div class="Panel_footer" style="width: 939px;">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="itemMulModEditor('${itemNumModStr}')">确定</div>
		<div class="PanelBtn2" onclick="closePopupWinTwo()">取消</div>
	</div>
</div>