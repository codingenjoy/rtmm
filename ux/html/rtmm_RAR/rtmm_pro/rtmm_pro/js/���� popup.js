function errorAlert_frame(frameSrc, msg, width, height, title) {

    setFrameSrc(frameSrc);

    var $topWindow = $(window.parent.document);
    var $body = $topWindow.find("body");
    $body.append('<div id="alert_layer"></div>');
    //$body.append('<iframe id=\"errorAlert\" name=\"errorAlert\" src=\"' + frameSrc + '\" frameborder=\"0\" scrolling=\"no\"></iframe>');
    var $alert_layer = $topWindow.find("#alert_layer");
    var w = $topWindow.width();
    var h = $topWindow.height();
    $alert_layer.css({ "width": w, "height": h, "display": "block" });

    var $alertPop = $topWindow.find("#alertPop");
    var $framedoc=$(window.parent.frames["alertPop"].document);
    var $alert_body = $framedoc.find("#alert_body");
    var $panel = $framedoc.find(".Panel");

    var $alert_text = $framedoc.find("#alert_text");
    var $alert_title = $framedoc.find("#alert_title");

    if (height != '' && height != undefined) {
        $alertPop.css({ "height": height+75 });
        $alert_body.css("height", height);
    } else {
        height = 60;
    }
    if (width != '' && width != undefined) {
        $alertPop.css({ "width": width + 'px' });
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
    $alertPop.css({ "display": "block", "z-index": "10000", "position": "absolute", "top": win_y + 'px', "left": win_x + 'px' });
}
//function setFrameSrc(frameSrc) {
//    var $topWindow = $(window.parent.document);
//    var $alertPop = $topWindow.find("#alertPop");

//    if (frameSrc == '' || frameSrc == undefined) {
//        return false;
//    } else {
//        $alertPop.attr("src", frameSrc);
//    }
//}