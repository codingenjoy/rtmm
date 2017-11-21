function errorAlert_frame(frameSrc, msg, width, height, title) {
    if (frameSrc == '' || frameSrc == undefined) {
        return false;
    }
    var $topWindow = $(window.parent.document);
    var $body = $topWindow.find("body");
    $body.append('<div id="alert_layer"></div>');
    $body.append('<iframe id=\"errorAlert\" name=\"errorAlert\" src=\"' + frameSrc + '\" frameborder=\"0\" scrolling=\"no\"></iframe>');
    var $alert_layer = $topWindow.find("#alert_layer");
    var w = $topWindow.width();
    var h = $topWindow.height();
    $alert_layer.css({ "width": w, "height": h, "display": "block" });

    var $alert_error_body = $topWindow.find("#alert_error_body");
    var $errorAlert = $topWindow.find("#errorAlert");
    var $panel = $(window.parent.frames["errorAlert"].document).find(".Panel");

    var $alert_error_text = $topWindow.find("#alert_error_text");
    var $alert_error_title = $topWindow.find("#alert_error_title");
    debugger;
    if (height != '' && height != undefined) {
        $alert_error_body.css("height", height);
    } else {
        height = 60;
    }
    if (width != '' && width != undefined) {
        $errorAlert.css({ "width": width + 'px' });
        $panel.css({ "width": width - 20 + 'px' });
    } else {
        width = 510;
    }
    if (msg != '' && msg != undefined) {
        $alert_error_text.html(msg);
    }
    if (title != '' && title != undefined) {
        $alert_error_title.html(title);
    }
    var win_x = ($topWindow.width() - width) / 2;//随着浏览器的变化而变化，而且不计算滚动条
    var win_y = ($topWindow.height() - (Number(height) + 60)) / 2 + $topWindow.scrollTop();
    $errorAlert.css({ "display": "block", "z-index": "10000", "position": "absolute", "top": win_y + 'px', "left": win_x + 'px' });
}