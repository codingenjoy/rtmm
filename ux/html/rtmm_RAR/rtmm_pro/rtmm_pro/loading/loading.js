//datagrid layer
/*
 * 定义一个“splash引用计数器”，名字为gSplashRefCount；
 * 内部处理逻辑如下：
 * (1).当收到任意客户端对grid_layer_open()的调用请求时，内部对引用计数 + 1；
 * (2).当收到任意客户端对grid_layer_close()的调用请求时，内部对引用计数 - 1；
 * 同时，在内部会启动一个用于Cleanup的Timer,不断地检测“计数器是否归零”，若归零则关闭Splash。
 */
var gSplashRefCount = 0;
var gSplashCleanupTimer = window.setInterval(function(){
	if (gSplashRefCount>0) return;
	try {
		//以下代码替代“$("#grid_layer").remove()”的功能。
		var wndObj = window || window.top; 
		var splashDom = wndObj.document.getElementById("grid_layer");
		if (!splashDom) return;
		splashDom.style.display ="none";
	} catch(e0){
		//alert(e0.number + "\n" + e0.description);
	}
}, 100);
window.attachEvent("onunload", function(){
	window.clearInterval(gSplashCleanupTimer);
});
function doSplashReset(){
    var width = $(document).width();
    var height = $(document).height();
    var top = $(window).scrollTop() + ($(window).height() - 200) / 2;
    $("#grid_layer").css({ "width": width, "height": height, "display": "block" });
    $("#g_loading").css({ "margin-left": (width - 200) / 2, "margin-top": top });
	
}
function grid_layer_open() {
	gSplashRefCount++;
	if (gSplashRefCount >1) return;
	var wndObj = window || window.top ; 
	var splashDom = wndObj.document.getElementById("grid_layer");
	if (splashDom) {
		splashDom.style.display = "block";
		doSplashReset();
		return;
	}
    $("body").append('<div id="grid_layer"><div id="g_loading"><div id="loadingClose" onclick="grid_layer_close()"></div></div></div>');
    doSplashReset();
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
	gSplashRefCount--;
}
