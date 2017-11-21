/**
 * 顯示所選商品的分店訂單詳情
 * 
 * @param itemNo
 * @param object
 */
function itemInfoByStore(itemNo, object) {
	if (object != undefined && $(object).hasClass("item_on")) {
		return;
	} else {
		$(".pro_store_tb_edit .item_on").removeClass("item_on");
	}
	$(object).addClass("item_on");
	// 如果已經選取過, 顯示這個 div,  隱藏其他的. 若沒選過, send request 到後台
	var exist = $("#storeList").find('#storeDetailInfo-'+itemNo).length;
	if (exist == 1){
		$("#storeList .store").hide();
		$("#storeList #storeDetailInfo-" +itemNo).show();
	}else{
		$.post(ctx + '/order/hoOrderItemStoreInfo', {
			'ordNo' : $(".CM-div #ordNo").val(),
			'itemNo' : itemNo
		}, function(data) {
			$("#storeList .store").hide();
			$("#storeList").append(data);
		});
	}
}

/**
 * 刪除此筆訂單
 */
function deleteThisOrder() {
	var param = {
		ordNoList : $(".CM-div #ordNo").val()
	};
	var url = ctx + "/order/deleteOrder";
	$.post(url, param, function(data) {
		$.post(ctx + '/order/hoOrder', {}
		, function(data) {
			$(".Container").html(data);
		});
		top.jAlert("success", "订单已删除", "提示消息");
	}, 'json');
}

function switchToListView() {
	// 隱藏詳細頁面 div
	$("#hoOrderDetailView").hide();
	$("#hoOrderDetailTag").hide();

	// 顯示列表頁面 div
	$("#hoOrderListView").show();
	$("#hoOrderListTag").show();

	// 打開列表頁面的工具
	toolbar.disable('Tools10');
	toolbar.disable('Tools12');
	checkCreatePrivilege();
	bindTool1();
	
	$("[type=checkbox]").removeAttr("checked");
	$("#hoOrder_tab_List .btable_checked").removeClass("btable_checked");
}