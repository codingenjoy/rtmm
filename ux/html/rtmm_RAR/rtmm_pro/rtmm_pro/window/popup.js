function errorAlert_frame(msg, width, height, title) {

    var $topWindow = $(window.parent.document);
    var $body = $topWindow.find("body");
    $body.append('<div id="alert_layer"></div>');
  
    var $alert_layer = $topWindow.find("#alert_layer");
    var w = $topWindow.width();
    var h = $topWindow.height();
    $alert_layer.css({ "width": w, "height": h, "display": "block" });

    var $alertErrorPop = $topWindow.find("#alertErrorPop");
    var $framedoc=$(window.parent.frames["alertErrorPop"].document);
    var $alert_body = $framedoc.find("#alert_body");
    var $panel = $framedoc.find(".Panel");

    var $alert_text = $framedoc.find("#alert_text");
    var $alert_title = $framedoc.find("#alert_title");

    if (height != '' && height != undefined) {
        $alertErrorPop.css({ "height": height+75 });
        $alert_body.css("height", height);
    } else {
        height = 60;
    }
    if (width != '' && width != undefined) {
        $alertErrorPop.css({ "width": width + 'px' });
        $panel.css({ "width": width - 5 + 'px' });
    } else {
        width = 510;
    }
    if (msg != '' && msg != undefined) {
        $alert_text.html(msg);
    }
    if (title != '' && title != undefined) {
        $alert_title.html(title);
    }
    var win_x = ($topWindow.width() - width) / 2;//随着浏览器的变化而变化，而且不计算滚动条
    var win_y = ($topWindow.height() - (Number(height) + 60)) / 2 + $topWindow.scrollTop();
    $alertErrorPop.css({ "display": "block", "z-index": "10005", "position": "absolute", "top": win_y + 'px', "left": win_x + 'px' });
}

function successAlert_frame(msg, width, height, title) {

    var $topWindow = $(window.parent.document);
    var $body = $topWindow.find("body");
    $body.append('<div id="alert_layer"></div>');

    var $alert_layer = $topWindow.find("#alert_layer");
    var w = $topWindow.width();
    var h = $topWindow.height();
    $alert_layer.css({ "width": w, "height": h, "display": "block" });

    var $alertSuccessPop = $topWindow.find("#alertSuccessPop");
    var $framedoc = $(window.parent.frames["alertSuccessPop"].document);
    var $alert_body = $framedoc.find("#alert_body");
    var $panel = $framedoc.find(".Panel");

    var $alert_text = $framedoc.find("#alert_text");
    var $alert_title = $framedoc.find("#alert_title");

    if (height != '' && height != undefined) {
        $alertSuccessPop.css({ "height": height + 85 });
        $alert_body.css("height", height);
    } else {
        height = 60;
    }
    if (width != '' && width != undefined) {
        $alertSuccessPop.css({ "width": width + 'px' });
        $panel.css({ "width": width - 5 + 'px' });
    } else {
        width = 510;
    }
    if (msg != '' && msg != undefined) {
        $alert_text.html(msg);
    }
    if (title != '' && title != undefined) {
        $alert_title.html(title);
    }
    var win_x = ($topWindow.width() - width) / 2;//随着浏览器的变化而变化，而且不计算滚动条
    var win_y = ($topWindow.height() - (Number(height) + 60)) / 2 + $topWindow.scrollTop();
    $alertSuccessPop.css({ "display": "block", "z-index": "10005", "position": "absolute", "top": win_y + 'px', "left": win_x + 'px' });
}

function commonAlert_frame(msg, width, height, title) {

    var $topWindow = $(window.parent.document);
    var $body = $topWindow.find("body");
    $body.append('<div id="alert_layer"></div>');

    var $alert_layer = $topWindow.find("#alert_layer");
    var w = $topWindow.width();
    var h = $topWindow.height();
    $alert_layer.css({ "width": w, "height": h, "display": "block" });

    var $alertCommonPop = $topWindow.find("#alertCommonPop");
    var $framedoc = $(window.parent.frames["alertCommonPop"].document);
    var $alert_body = $framedoc.find("#alert_body");
    var $panel = $framedoc.find(".Panel");

    var $alert_text = $framedoc.find("#alert_text");
    var $alert_title = $framedoc.find("#alert_title");

    if (height != '' && height != undefined) {
        $alertCommonPop.css({ "height": height + 85 });
        $alert_body.css("height", height);
    } else {
        height = 60;
    }
    if (width != '' && width != undefined) {
        $alertCommonPop.css({ "width": width + 'px' });
        $panel.css({ "width": width - 5 + 'px' });
    } else {
        width = 510;
    }
    if (msg != '' && msg != undefined) {
        $alert_text.html(msg);
    }
    if (title != '' && title != undefined) {
        $alert_title.html(title);
    }
    var win_x = ($topWindow.width() - width) / 2;//随着浏览器的变化而变化，而且不计算滚动条
    var win_y = ($topWindow.height() - (Number(height) + 60)) / 2 + $topWindow.scrollTop();
    $alertCommonPop.css({ "display": "block", "z-index": "10005", "position": "absolute", "top": win_y + 'px', "left": win_x + 'px' });
}

function confirmAlert_frame(msg, width, height, title) {

    var $topWindow = $(window.parent.document);
    var $body = $topWindow.find("body");
    $body.append('<div id="alert_layer"></div>');

    var $alert_layer = $topWindow.find("#alert_layer");
    var w = $topWindow.width();
    var h = $topWindow.height();
    $alert_layer.css({ "width": w, "height": h, "display": "block" });

    var $alertConfirmPop = $topWindow.find("#alertConfirmPop");
    var $framedoc = $(window.parent.frames["alertConfirmPop"].document);
    var $alert_body = $framedoc.find("#alert_body");
    var $panel = $framedoc.find(".Panel");

    var $alert_text = $framedoc.find("#alert_text");
    var $alert_title = $framedoc.find("#alert_title");

    if (height != '' && height != undefined) {
        $alertConfirmPop.css({ "height": height + 85 });
        $alert_body.css("height", height);
    } else {
        height = 60;
    }
    if (width != '' && width != undefined) {
        $alertConfirmPop.css({ "width": width + 'px' });
        $panel.css({ "width": width - 5 + 'px' });
    } else {
        width = 510;
    }
    if (msg != '' && msg != undefined) {
        $alert_text.html(msg);
    }
    if (title != '' && title != undefined) {
        $alert_title.html(title);
    }
    var win_x = ($topWindow.width() - width) / 2;//随着浏览器的变化而变化，而且不计算滚动条
    var win_y = ($topWindow.height() - (Number(height) + 60)) / 2 + $topWindow.scrollTop();
    $alertConfirmPop.css({ "display": "block", "z-index": "10005", "position": "absolute", "top": win_y + 'px', "left": win_x + 'px' });
}

function windowPop_frame(frameId,width, height) {
    var $frameId = "#" + frameId;
    var $topWindow = $(window.parent.document);
    var $body = $topWindow.find("body");
    $body.append('<div id="window_layer"></div>');

    var $alert_layer = $topWindow.find("#window_layer");
    var w = $topWindow.width();
    var h = $topWindow.height();
    $alert_layer.css({ "width": w, "height": h, "display": "block" });

    var $frame = $topWindow.find($frameId);
    var $framedoc = $(window.parent.frames[frameId].document);
    var $alert_body = $framedoc.find("#alert_body");
    var $panel = $framedoc.find(".Panel");

    height = $alert_body.css("height");
    height=(Number)(height.substring(0, height.length - 2))+90;
    $frame.css({ "height": height });
    width = $panel.css("width");
    width = (Number)(width.substring(0, width.length - 2)) + 5;
    $frame.css({ "width": width });

    var win_x = ($topWindow.width() - width) / 2;//随着浏览器的变化而变化，而且不计算滚动条
    var win_y = ($topWindow.height() - height) / 2 + $topWindow.scrollTop();
    $frame.css({ "display": "block", "z-index": "10000", "position": "absolute", "top": win_y + 'px', "left": win_x + 'px' });

}

function closePop(frameId) {
    var $frameId = "#" + frameId;
    var $topWindow = $(window.parent.document);
    var $frame = $topWindow.find($frameId);
    var $alert_layer = $topWindow.find("#window_layer");

    $frame.css("display", "none");
    $alert_layer.remove();
}