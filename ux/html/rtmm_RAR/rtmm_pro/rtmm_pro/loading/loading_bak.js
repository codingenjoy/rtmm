//datagrid layer
function grid_layer_open() {
    $("body").append('<div id="grid_layer"><div id="g_loading"><div id="loadingClose" onclick="grid_layer_close()"></div></div></div>');
    var width = $(document).width();
    var height = $(document).height();
    var top = $(window).scrollTop() + ($(window).height() - 200) / 2;
    $("#grid_layer").css({ "width": width, "height": height, "display": "block" });
    $("#g_loading").css({ "margin-left": (width - 200) / 2, "margin-top": top });
}
/**
*clickLeft 点击按钮的$(this).offset().left值
*/
function grid_layer_open_login(clickLeft) {
    $("body").append('<div id="grid_layer" class="login_loading"><div id="g_loading"><div id="loadingClose" onclick="grid_layer_close()"></div></div></div>');
    var width = $(document).width();
    var height = $(document).height();
    var top = $(window).scrollTop() + ($(window).height() - 200) / 2;
    $("#grid_layer").css({ "width": width, "height": height, "display": "block" });
    $("#g_loading").css({ "left": clickLeft+25 });
}
function grid_layer_close() {
    $("#grid_layer").remove();
}