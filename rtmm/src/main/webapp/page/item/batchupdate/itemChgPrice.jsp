<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/tree.css"
	rel="Stylesheet" />
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

.Panel_footer {
	width: 937px;
}

.first_div {
	height: 100%;
	width: 100%;
}

.second_div {
	height: 89px;
	width: 100%;
	margin-top: 2px;
}
</style>
<script type="text/javascript">
    	$(function(){
    		
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
    		
    		$('#itemChgPriArea').find('li').remove();//先删除树
    		$.post(ctx + "/item/batchupdate/getItemAreaTree", {
    		}, function(data) {
    			$('#itemChgPriArea').tree({
    				checkbox : true,
    				data : data,
    				onClick : function(node) {
    				},onCheck : function(node,checked) {
    					$.ajax({
    						type : "post",
    						async : false,
    						url : ctx + "/item/batchupdate/getStoreByAreaId",
    						dataType : "json",
    						data : {
    							'areaId' :node.id,
    						},
    						success : function(data) {
    							$.each(data,function(index,item){
    								if(checked){
    									$("#storeDiv").append("<div class='item2' id='store_"+item.storeNo+"'><label><input type='checkbox' class='check' name='hypeMarketNo' value="+item.storeNo+"></label><span>"+item.storeName+"</span></div>");
    								}else{
    									$("#storeDiv").find("div[id=store_"+item.storeNo+"]").remove();
    								}
    							});
    						}
    					});
    					if ($('#storeDiv .item2 :checked').length != 0 && ($('#storeDiv .item2').length == $('#storeDiv .item2 :checked').length)){
    						$('#storeCheckAll').attr("checked", "checked");
    					}
    					else{
    						$('#storeCheckAll').removeAttr("checked");
    					}
    				}
    				
    			});
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
				<ul id="itemChgPriArea"></ul>
			</div>
			<div class="t3">
				<div class="b inputDiv" style="width: 180px;" id="storeDiv"></div>
				<div class="f" style="width: 180px;">
					<label> <input id="storeCheckAll" type="checkbox"
						name="hypeMarketNo" class="checkAll"
						onclick="hypeMarketCheckAll(this)" />
					</label><span>全选</span>
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
						</label><span>全选</span>
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
						</label><span>全选</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="p52_2_1">
		<div class="CM first_div">
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
<div class="Panel_footer" style="width: 616px;">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="itemChgPriEditor('${itemNumModStr}')">确定</div>
		<div class="PanelBtn2" onclick="closePopupWinTwo()">取消</div>
	</div>
</div>