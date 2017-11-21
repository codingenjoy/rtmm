/*
 * Routines-1.定义一个“splash引用计数器”， 内部处理逻辑如下：
 * (1).当收到任意客户端对grid_layer_open()的调用请求时，内部对引用计数 + 1；
 * (2).当收到任意客户端对grid_layer_close()的调用请求时，内部对引用计数 - 1；
 * 同时，在内部会启动一个用于Cleanup的Timer,不断地检测“计数器是否归零”，若归零则关闭Splash。
 * 
 * Routines-2.以下内容是对于"Splash调用出现'例外情况'的处理":
 * 当某个Caller不遵守"对Splash的调用要形成闭环,即在调用 open()后，必须保证调用close()"这个契约。
 * 我们建立了TimetoLive的内省机制，并在CleanupTimer的循环检测中进行了调用。
 */
function TtlIntrospect(){
	this._startTiming = null;
	this._TTL_SENCONDS = 90 * 1000;
}
//设置启动时间
TtlIntrospect.prototype.doStart = function(){
	this._startTiming = new Date().getTime();
};
//检测是否超时
TtlIntrospect.prototype.isTimedout = function(){
	var currTime = new Date().getTime(); 
	var delta = currTime - this._startTiming;
	var timedout = delta >= this._TTL_SENCONDS;
	if (timedout){
		var warnMsg = '系统检测到Splash超时, 已强制关闭！\r\n(Splash上限：' + this._TTL_SENCONDS + '毫秒)';
		if (top.jAlert)
			top.jAlert('warning', warnMsg,'提示消息');
		else
			alert(warnMsg);
	}
	return timedout;
};
TtlIntrospect.prototype.reset = function(){
	this._startTiming = null;
};

function SpinlockBasedSplash(){
	this._refCount = 0;
};
SpinlockBasedSplash.prototype.increaseRef = function(){
	this._refCount++;
	if (this._refCount == 1){
		var wndObj = top.window || window;
		var splashDom = wndObj.document.getElementById("grid_layer");
		if (!splashDom)
			$("body").append('<div id="grid_layer"><div id="g_loading"><div id="loadingClose" onclick="grid_layer_close()"></div></div></div>');
		$("#grid_layer").show();
	}
	return this._refCount > 1;
};
SpinlockBasedSplash.prototype.decreaseRef = function(){
	if(this._refCount<=0)
		return;
	this._refCount--;
};
SpinlockBasedSplash.prototype.checkCanBeClosed = function(){
	return this._refCount <=0;
};
SpinlockBasedSplash.prototype.checkIfMultiRefsExist = function(){
	return this._refCount > 1;
};
SpinlockBasedSplash.prototype.reset = function(){
	this._refCount = 0;
};
SpinlockBasedSplash.prototype.forceClose = function(){
	gTtlIntrospectDaemon.reset();
	$("#grid_layer").hide();
	this.reset();
};
SpinlockBasedSplash.prototype.show = function(/*customizedLeft, optional*/leftPos){
    //var width = $(document).width();
    //var height = $(document).height();
    var width = $(document).width()-10;
    var height = $(document).height()-10;
    var top = $(window).scrollTop() + ($(window).height() - 200) / 2;
    $("#grid_layer").css({ "width": width, "height": height, "display": "block" });
    if (leftPos){
    	$("#g_loading").css({ "left": leftPos});
    }
    else
        $("#g_loading").css({ "margin-left": (width - 200) / 2, "margin-top": top });
    
    $("#grid_layer").show();
};
SpinlockBasedSplash.prototype.hide = function(){
	try {
		$("#grid_layer").hide();
	} catch(e0){
		var errorMsg = "在关闭Splash的过程中产生错误！\r\n" + e0;
		/*if (top.jAlert)
			top.jAlert('error', errorMsg,'提示消息');
		else
			alert(errorMsg);*/
	}
};

var gTtlIntrospectDaemon = new TtlIntrospect();
var gSplash = new SpinlockBasedSplash();

//alert();
var gSplashCleanupTimer = window.setInterval(function(){
	var canCloseIt = gSplash.checkCanBeClosed();
	if (!canCloseIt) {
		if (gTtlIntrospectDaemon.isTimedout()){
			gSplash.forceClose();
		}
		return;
	} else {
		gSplash.hide();
	}
}, 500);
if (window.attachEvent) { 
    window.attachEvent("onunload", function(){
    	try {
	    	window.clearInterval(gSplashCleanupTimer);	
    	} catch(e0){
    	}
    }); 
} else if (window.addEventListener) { 
    window.addEventListener("onunload", function(){
    	try {
    	window.clearInterval(gSplashCleanupTimer);	
    	} catch(e1){
    	}
    }, false);   
}

function grid_layer_open() {
	var isMultiAttached = gSplash.increaseRef();
	if (isMultiAttached) return;
	gTtlIntrospectDaemon.doStart();
	gSplash.show();
}


/**
*clickLeft 点击按钮的$(this).offset().left值
*/
function grid_layer_open_login(clickLeft) {
	var isMultiAttached = gSplash.increaseRef();
	$("#grid_layer").addClass("login_loading");
	if (isMultiAttached) return;
	gTtlIntrospectDaemon.doStart();
	gSplash.show(clickLeft+25);
}
function grid_layer_close() {
	gSplash.decreaseRef();
}
function grid_layer_forceClose(){
	gSplash.forceClose();
}