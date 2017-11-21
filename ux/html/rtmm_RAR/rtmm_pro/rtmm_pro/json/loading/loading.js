//datagrid layer
function grid_layer_open() {
    $("body").append('<div id="grid_layer"><div id="g_loading"><div id="loadingClose"></div></div></div>');
    var width = $(document).width();
    var height = $(document).height();
    var top = $(window).scrollTop() + ($(window).height() - 200) / 2;
    $("#grid_layer").css({ "width": width, "height": height, "display": "block" });
    $("#g_loading").css({ "margin-left": (width - 200) / 2, "margin-top": top });
}
function grid_layer_close() {
    $("#grid_layer").remove();
}