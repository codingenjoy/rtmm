$(document).ready(function () {
    //$(".item_management").click(function () {
    //    window.location.href = "../item/11_Item_overview_table.html";
    //});
    $("#overview").click(function () {
        window.location.href = "../item/11_Item_overview_table.html";
    });
    $("#changePrice").click(function () {
        window.location.href = "../item/12_Item_Price.html";
    });
    $("#guige").click(function () {
        window.location.href = "../item/13_Item_Spec.html";
    });
    $("#tiaoma").click(function () {
        window.location.href = "../item/14_Item_BarCode.html";
    });
    $("#guanlian").click(function () {
        window.location.href = "../item/15_1_Item_Correlation_Repacking_View.html";
    });
    $("#i_changshang").click(function () {
        window.location.href = "../item/16_Item_Supplier.html";
    });
    $("#chenlie").click(function () {
        window.location.href = "../item/17_Item_Stock_View.html";
    });
    $("#jinxiaocun").click(function () {
        window.location.href = "../item/18_Item_Invoicing_View.html";
    });
    $("#dc_info").click(function () {
        window.location.href = "../item/19_Item_DC Info_View.html";
    });

    $("#content1").click(function () {
        window.location.href = "../item/11_Item_overView_content.html";
    });
    $("#list1").click(function () {
        window.location.href = "../item/11_Item_overview_table.html";
    });
    $("#content2").click(function () {
        window.location.href = "../item/21_content_Item_Series Items_same price_View.html";
    });
    $("#list2").click(function () {
        window.location.href = "../item/21_Item_Series_table.html";
    });
});

//2
function modifyBank2() {
    //$("body").append('');
    var selector = "#popupWin";
    $(selector).window({
        width: 660,
        height: 680,
        modal: true,
        shadow: false,
        border: false,
        noheader: true
    });
    $(selector).window('open');

    $(selector).window('refresh', 'file:///D:/我的酷盘/rtmm/rtmm/Supplier-31-panel2.html');

    window.windowSelector = selector;
}