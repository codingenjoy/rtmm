<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>

        <div class="Panel_top">
            <span>选择代表商品</span>
            <div class="PanelClose" id="closeOneSeriesWindow" style="margin-right:0;"></div>
        </div>
         <div class="Table_Panel" id="chooseOneSeriesDiv">
            <div style="margin:15px auto 0px auto;width:97%;height:100%;">
                <div style="height:30px;background:#CCC;">
                    <div class="Icon-div">
                        <input type="text" class="IS_input" id="selectSereisItemNo" title="输入货号或品名查询(支持模糊查询)" placeholder="输入货号或品名查询(支持模糊查询)"/>
                        <div class="cbankIcon" id="selectSeriesItem"></div>
                    </div>
                </div>
                <div class="search_tb_p" id="item_update_div">
                    <table id="update_items" style="height:350px;"></table>
                    
                      <div class="Panel_footer">
            <div class="PanelBtn">
                <div class="PanelBtn1" onclick="saveSearchSeries()"><auchan:i18n id="100000004"></auchan:i18n></div>
                <div class="PanelBtn2" id="closeSeriesItemWin"><auchan:i18n id="100000003"></auchan:i18n></div>
            </div>
        </div>
                    
                </div>
            </div>
        </div>
      
 <script type="text/javascript">
var searchItemNo="";
var searchItemName="";
var searchUrl="";
var searchRowdata=null;
function loadSeriesItemList(){
$('#update_items').datagrid(
	{
		rownumbers : false,
		singleSelect : true,
		pagination : true,
		pageSize : 20,
		striped : true,//奇偶行使用不同背景色  
		queryParams : {
			itemNo : searchItemNo,
			catlgNo : $("[name=catlgId]").val(), //从其他页面获取课别信息  
 			itemName : searchItemName, //商品名称
 			/* 		clstrType : $("#searchClstrType").val(), */
			itemStatus : 8
		},

		url : searchUrl,
		columns : [ [
				{
					field : 'itemNo',
					title : '<auchan:i18n id="103001003"></auchan:i18n>',
					sortable : true,
					align : 'right',
					halign : 'center',
					width : 120,
					formatter : function(val, rec) {
						return rec.itemNo+'&nbsp;';
					}
				},
				{
					field : 'itemName',
					title : '<auchan:i18n id="103002011"></auchan:i18n>',
					sortable : true,
					halign : 'center',
					width : 250,
					formatter : function(val, rec) {
						return rec.itemName+'&nbsp;';
					}
				},
				{
					field : 'status',
					title : '<auchan:i18n id="103002017"></auchan:i18n>',
					halign : 'center',
					width : 200,
					formatter : function(
							val, rec) {
						return getDictValue(
								'ITEM_STORE_INFO_STATUS',
								rec.status);
					}
				} ] ],

		onLoadSuccess : function(data) {
			searchRowdata = null;
		},
		onDblClickRow : function(rowIndex,
				rowData) {
			//传出数值信息
			confirmChooseSeries(rowData);
			//关闭窗口
			//closePopupWin(); 
		},
		onSelect : function(rowIndex,
				rowData) {//选中事件
			searchRowdata = rowData;
		}
	});

}
//关闭窗口
$("#closeOneSeriesWindow").unbind("click").click(
		function() {
			//关闭弹出层
			closePopupWin();
		});

//关闭窗口
$("#closeSeriesItemWin").unbind("click").click(function() {
	//关闭弹出层
	closePopupWin();
});
function saveSearchSeries() {
	if (searchRowdata != null) {
		//传出数值信息
		confirmChooseSeries(searchRowdata);
	} else {
		top.jAlert("warning", "请选择代表商品", "提示信息");
	}
}

$(function() {
	//加载查询信息
	loadSeriesItemList();

	//查询事件
	$("#selectSeriesItem").unbind("click").click(
					function() {
						searchItemNo = "";
						searchItemName = "";
						searchUrl = "<c:url value='/series/readRefItemList'/>?tt="
								+ new Date().getTime();
						var mySeriesItem = $.trim($(
								"#selectSereisItemNo")
								.val());
						if (mySeriesItem == "") {
							top.jAlert('warning',
									'请输入查询信息', '提示消息');
							return;
						}
						if (isNumber(mySeriesItem)) {
							searchItemNo = mySeriesItem;
						} else {
							searchItemName = mySeriesItem;
						}
						loadSeriesItemList();
					});

	//获取焦点事件
	$("#selectSereisItemNo").focus(
			function() {
				$("#selectSereisItemNo").removeClass()
						.addClass("IS_input");
				$("#selectSereisItemNo").attr("title",
						"输入货号或品名查询(支持模糊查询)");
			});

});

//回车事件绑定
$("#chooseOneSeriesDiv").unbind("keypress").keypress(
		function(event) {
			if (event !== null && event.keyCode == 13) {
				$("#selectSeriesItem").click();
			}
		});
</script>
