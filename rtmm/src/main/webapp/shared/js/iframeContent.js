﻿$(".pstb_del2,.pstb_del").live("click", function () {
    var $row = $(this).parent(".item");
    $row.remove();
});

//日期转换,例如new Date().format("yyyy-MM-dd hh:mm:ss");
Date.prototype.format = function(format) {
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds() // millisecond
	};
	if (/(y+)/.test(format))
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
	return format;
};

//从字典表取数据(先从缓存中找，找不到就去数据库查找)
var dictList = [];
function getDictValue(mdGrpKey, code, showType) {
	var result = '';
	var find = false;
	if(dictList.length>0){
		$.each(dictList,function(index,item){
			if(item.key == mdGrpKey && item.code == code){
				if (showType == 2) {
					var itemTitle = item.title;
					result = itemTitle.substring(itemTitle.indexOf("-") + 1, itemTitle.length);
				} else {
					result = item.title;
				}
				find = true;
				return false;
			}
		});
	}
	if(!find){
		$.ajax({
			type : "post",
			url : ctx + '/commons/window/getDictValue',
			async : false,
			contenttype :"application/x-www-form-urlencoded;charset=utf-8", 
			dataType : "json",
			data : {
				'mdGrpKey' : mdGrpKey,
				'code' : code
			},
			success : function(data) {
				dictList.push({'key':mdGrpKey,'code':data.code,'title':data.code+'-'+data.title});
				if (showType == 2 ) {
					result = data.title;
				} else {
					result = data.code+'-'+data.title;
				}
			},
			error : function(data) {
				result = '';
			}
		});
	}
	return result;
}

//checkbox 选中时有虚线框
$("a, input[type='button'], input[type='submit'], input[type='checkbox'],input[type='radio']").live("focus", function () {
    if (this.blur) {
        this.blur();
    }
});
//去除input框的初始提示文字的灰色
$(".input_propt_color").live("click", function () {
    $(this).val("");
    $(this).removeClass("input_propt_color");
});

//Submenu sidebar search 的显示和隐藏
function DispOrHid(c) {
    var selector = $(".panel,.panel-body,.datagrid-view,.datagrid-view2,.datagrid-header,.datagrid-header,.datagrid-body,.datagrid-htable,.datagrid-btable,.datagrid-header-row,.datagrid-row,.datagrid-footer");
    if (c == "1-id" || c == "A-id") {
        $(".SubMenu").toggle();
        $(".SideBar").toggle();
        //alert($(".SubMenu").css("display"));
        if ($(".SubMenu").css("display") == "none") {
            $(".LeftMenu").css("width", "40px");
            $(".Container").css("width", "1200px");
            //$(".SideBarText").text(menuName);
            if ($(".Search").css("display") == "none") {
                //alert(".search=none,submenu=none,sidebar=block");
                selector.css("width", "1188px");
            } else {
                selector.css("width", "888px");//?????
            }
        }
        else {
            $(".LeftMenu").css("width", "16%");
            $(".Container").css("width", "84%");
            if ($(".Search").css("display") == "none") {
                selector.css("width", "1031px");
            } else {
                selector.css("width", "771px");
            }
        }
    }
    else if (c == "B-id" || c == "C-id") {
        $(".Search").toggle();
        //alert($(".Search").css("display"));
        if ($(".Search").css("display") == "none") {
            $(".Content").css("width", "99%");
            if ($(".SubMenu").css("display") == "block") {
                selector.css("width", "1031px");
            } else {
                selector.css("width", "1188px");
            }
        } else {
            $(".Content").css("width", "74%");
            if ($(".SubMenu").css("display") == "block") {
                selector.css("width", "771px");
            } else {
                selector.css("width", "888px");
            }
        }
    }
    else {
        alert("传入的参数有错误！");
    }
}
window.DispOrHid = DispOrHid;

//List item 列表点击 单选
$(".item").live("click", function () {
    var pre = "";
    var cur = $(this).attr("class");;

    $(this).parent().find(".item_on").removeClass("item_on");

    $(this).addClass("item_on");
});

$(".item_tr").live("click", function () {
    var pre = "";
    var cur = $(this).attr("class");;

    $(".item_tr").parent().find(".item_on2").removeClass("item_on2");

    $(this).addClass("item_on2");
});
//List item 列表点击 多选
$(".item2,.item3,.item4").live("click", function () {
    $(this).toggleClass("item_on");
});
$(".tbx tr").live("click", function () {
    $('.tbx').find('.item_on2').removeClass('item_on2');

    $(this).addClass("item_on2");

    var y = $(this).offset().top - 120;

    $(".px").css({ "top": y });
});
// 全选 设置包含input的div class=“inputDiv” 全选input class=“checkAll”;另外input的父标签是label，label的父标签是一个div，这个div就是随着选中状态变色
$(".checkAll").live("click", function () {
    var isCheck = this.checked;
    var input = $(".inputDiv input[name=" + this.name + "]");
    //var inputdiv = $(".inputDiv").find("div");
    //alert(isCheck);
    if (isCheck) {
        input.attr("checked", true);
        input.parent().parent().addClass("item_on");
    } else {
        input.attr("checked", false);
        input.parent().parent().removeClass("item_on");
    }
});
//检索Icon
$(".Tools1").live("click", function () {
    $(".Tools1").parent().toggleClass("Tools1Parent_bg");
    $(".Tools1").toggleClass("Tools1_on");
});
$(".Tools1").live("mouseover", function () {
    $(".Tools1").addClass("Tools1_over");
});
$(".Tools1").live("mouseout", function () {
    $(".Tools1").removeClass("Tools1_over");
});
$(".C-id").live("click", function () {
    $(".Tools1").parent().removeClass("Tools1Parent_bg");
    $(".Tools1").removeClass("Tools1_on");
});
//week
$(".week div").live("click", function () {
    $(this).toggleClass("weekon");
});
$(".Rect2Check").live("click", function () {
    $(this).prev().children().toggleClass("weekon");
});

//data table
//table 单行选中 多行选中

$(".multi_tb tr").live("click", function () {
    $(this).toggleClass("btable_checked");
});
$(".single_tb tr").live("click", function () {

    if (!$(this).hasClass("trSpecial")&&$(this).parents("table").attr("class") != "" && $(this).parents("table").attr("class") != undefined) {
        $(this).parents("table").find(".btable_checked").removeClass("btable_checked");
        $(this).toggleClass("btable_checked");
    } else {
        return false;
    }
});
$(document).ready(function () {

    $(".btable_div").scroll(function () {
        var left = $(this).scrollLeft();
        //alert(left);
        $(".htable_div").scrollLeft(left);
    });
    $(".tr_close").live("click", function () {
        var $borther = $(this).parent().next(".trSpecial");
        if ($borther.length < 1) {
            alert("当前数据行没有隐藏的子行！");
            return false;
        }
        $(this).addClass("tr_open");
        $(this).removeClass("tr_close");
        $borther.removeClass("Bar_off");
    });
    $(".tr_open").live("click", function () {
        var $borther = $(this).parent().next(".trSpecial");

        $(this).addClass("tr_close");
        $(this).removeClass("tr_open");
        $borther.addClass("Bar_off");
    });
});
//商品批量修改，单选框控制内容却换
//$(".plxg_radio input").live("click", function () {
//    var id = $(this).attr("id");
//    if (id == "p52_tb") {
//        $(".p51_panel .txtarea").css("display", "none");
//        $(".p51_panel .p52_tb").css("display", "block");
//    }
//    if (id == "area") {
//        $(".p51_panel .p52_tb").css("display", "none");
//        $(".p51_panel .txtarea").css("display", "block");
//    }
//});
//商品批量修改，单选框控制内容却换
$(".dis_item_supplier input").live("click", function () {
    var id = $(this).attr("id");
    if (id == "dis_supplier") {
        $(".dis_item").css("display", "none");
        $(".dis_supplier").css("display", "block");
    }
    if (id == "dis_item") {
        $(".dis_supplier").css("display", "none");
        $(".dis_item").css("display", "block");
    }
});
$(".need_update_item input").live("click", function () {
    var id = $(this).attr("id");
    if (id == "all_select") {
        $(".part_select").css("display", "none");
        $(".all_select").css("display", "block");
    }
    if (id == "part_select") {
        $(".all_select").css("display", "none");
        $(".part_select").css("display", "block");
    }
});
////////
function commonAlert(msg, width, height, title) {
    var $body = $("body");
    $body.append('<div id="alert_layer"></div>');
    var $layer = $("#alert_layer");
    var w = $(document).width();
    var h = $(document).height();
    $layer.css({ "width": w, "height": h, "display": "block" });

    $body.append('<div id=\"commonAlert\" class=\"Panel\"><div class=\"alert_top\"><span id=\"alert_common_title\" class=\"alert_title\">信息提示</span><div id=\"alert_close\" class=\"PanelClose\"></div></div><div id=\"alert_common_body\" class=\"Table_Panel\"><div class=\"alert_body\"><div class=\"alert_b1 alert_info \"></div><div id=\"alert_common_text\" class=\"alert_text\">这是一个消息提示框！</div></div></div><div class=\"Panel_footer\"><div class=\"btn1\">确定</div></div></div>');
    if (height != '' && height != undefined) {
        $("#alert_common_body").css("height", height);
    } else {
        height = 60;
    }
    if (width != '' && width != undefined) {
        $("#commonAlert").css({ "width": width + 'px' });
    } else {
        width = 500;
    }
    if (msg != '' && msg != undefined) {
        $("#alert_common_text").html(msg);
    }
    if (title != '' && title != undefined) {
        $("#alert_common_title").html(title);
    }
    var win_x = ($(window).width() - width) / 2;//随着浏览器的变化而变化，而且不计算滚动条
    var win_y = ($(window).height() - (Number(height) + 60)) / 2 + $(window).scrollTop();
    $("#commonAlert").css({ "display": "block", "z-index": "10000", "position": "absolute", "top": win_y + 'px', "left": win_x + 'px' });
}
function errorAlert(msg, width, height, title) {

    var $body = $("body");
    $body.append('<div id="alert_layer"></div>');
    var $layer = $("#alert_layer");
    var w = $(document).width();
    var h = $(document).height();
    $layer.css({ "width": w, "height": h, "display": "block" });

    $body.append('<div id=\"errorAlert\" class=\"Panel\"><div class=\"alert_top\"><span id=\"alert_error_title\" class=\"alert_title\">错误信息提示</span><div id=\"alert_close\" class=\"PanelClose\"></div></div><div id=\"alert_error_body\" class=\"Table_Panel\"><div class=\"alert_body\"><div class=\"alert_b1 cha \"></div><div id=\"alert_error_text\" class=\"alert_text\">这是一个错误消息提示框！</div></div></div><div class=\"Panel_footer\"><div class=\"btn1\">确定</div></div></div>');
    if (height != '' && height != undefined) {
        $("#alert_error_body").css("height", height);
    } else {
        height = 60;
    }
    if (width != '' && width != undefined) {
        $("#errorAlert").css({ "width": width + 'px' });
    } else {
        width = 500;
    }
    if (msg != '' && msg != undefined) {
        $("#alert_error_text").html(msg);
    }
    if (title != '' && title != undefined) {
        $("#alert_error_title").html(title);
    }
    var win_x = ($(window).width() - width) / 2;//随着浏览器的变化而变化，而且不计算滚动条
    var win_y = ($(window).height() - (Number(height) + 60)) / 2 + $(window).scrollTop();
    $("#errorAlert").css({ "display": "block", "z-index": "10000", "position": "absolute", "top": win_y + 'px', "left": win_x + 'px' });
}
function successAlert(msg, width, height, title) {

    var $body = $("body");
    $body.append('<div id="alert_layer"></div>');
    var $layer = $("#alert_layer");
    var w = $(document).width();
    var h = $(document).height();
    $layer.css({ "width": w, "height": h, "display": "block" });

    $body.append('<div id=\"successAlert\" class=\"Panel\"><div class=\"alert_top\"><span id=\"alert_success_title\" class=\"alert_title\">成功信息提示</span><div id=\"alert_close\" class=\"PanelClose\"></div></div><div class=\"Table_Panel\" id=\"alert_success_body\"><div class=\"alert_body\"><div class=\"alert_b1 gou \"></div><div id=\"alert_success_text\" class=\"alert_text\">这是一个操作成功消息提示框！</div></div></div><div class=\"Panel_footer\"><div class=\"btn1\">确定</div></div></div>');
    if (height != '' && height != undefined) {
        $("#alert_success_body").css("height", height);
    } else {
        height = 60;
    }
    if (width != '' && width != undefined) {
        $("#successAlert").css({ "width": width + 'px' });
    } else {
        width = 500;
    }
    if (msg != '' && msg != undefined) {
        $("#alert_success_text").html(msg);
    }
    if (title != '' && title != undefined) {
        $("#alert_success_title").html(title);
    }
    var win_x = ($(window).width() - width) / 2;//随着浏览器的变化而变化，而且不计算滚动条
    var win_y = ($(window).height() - (Number(height) + 60)) / 2 + $(window).scrollTop();
    $("#successAlert").css({ "display": "block", "z-index": "10000", "position": "absolute", "top": win_y + 'px', "left": win_x + 'px' });
}
function warnAlert(msg, width, height, title) {
    var $body = $("body");
    $body.append('<div id="alert_layer"></div>');
    var $layer = $("#alert_layer");
    var w = $(document).width();
    var h = $(document).height();
    $layer.css({ "width": w, "height": h, "display": "block" });

    $body.append('<div id=\"warnAlert\" class=\"Panel\"><div class=\"alert_top\"><span id=\"alert_warn_title\" class=\"alert_title\">警告提示</span><div id=\"alert_close\" class=\"PanelClose\"></div></div><div class=\"Table_Panel\" id=\"alert_warn_body\"><div class=\"alert_body\"><div class=\"alert_b1 warn \"></div><div id=\"alert_warn_text\" class=\"alert_text\">这是一个警告消息提示框！</div></div></div><div class=\"Panel_footer\"><div class=\"btn1\">确定</div></div></div>');
    if (height != '' && height != undefined) {
        $("#alert_warn_body").css("height", height);
    } else {
        height = 60;
    }
    if (width != '' && width != undefined) {
        $("#warnAlert").css({ "width": width + 'px' });
    } else {
        width = 500;
    }
    if (msg != '' && msg != undefined) {
        $("#alert_warn_text").html(msg);
    }
    if (title != '' && title != undefined) {
        $("#alert_warn_title").html(title);
    }
    var win_x = ($(window).width() - width) / 2;//随着浏览器的变化而变化，而且不计算滚动条
    var win_y = ($(window).height() - (Number(height) + 60)) / 2 + $(window).scrollTop();
    $("#warnAlert").css({ "display": "block", "z-index": "10000", "position": "absolute", "top": win_y + 'px', "left": win_x + 'px' });
}
function confirmWindow(msg, width, height, title, okfn, cancelfn) {

    var $body = $("body");
    $body.append('<div id="alert_layer"></div>');
    var $layer = $("#alert_layer");
    var w = $(document).width();
    var h = $(document).height();
    $layer.css({ "width": w, "height": h, "display": "block" });

    $body.append('<div id=\"confirmAlert\" class=\"Panel\"><div class=\"alert_top\"><span id=\"alert_confirm_title\" class=\"alert_title\">confirm提示</span><div id=\"alert_close\" class=\"PanelClose\"></div></div><div class=\"Table_Panel\" id=\"alert_confirm_body\"><div class=\"alert_body\"><div class=\"alert_b1 alert_comfirm \"></div><div id=\"alert_confirm_text\" class=\"alert_text\">这是一个confirm提示框！</div></div></div><div class=\"Panel_footer\"><div class=\"PanelBtn\"><div class=\"PanelBtn1\">确定</div><div class=\"cancel\">取消</div></div></div></div>');
    if (height != '' && height != undefined) {
        $("#alert_confirm_body").css("height", height);
    } else {
        height = 60;
    }
    if (width != '' && width != undefined) {
        $("#confirmAlert").css({ "width": width + 'px' });
    } else {
        width = 500;
    }
    if (msg != '' && msg != undefined) {
        $("#alert_confirm_text").html(msg);
    }
    if (title != '' && title != undefined) {
        $("#alert_confirm_title").html(title);
    }
    var win_x = ($(window).width() - width) / 2;//随着浏览器的变化而变化，而且不计算滚动条
    var win_y = ($(window).height() - (Number(height) + 60)) / 2 + $(window).scrollTop();
    $("#confirmAlert").css({ "display": "block", "z-index": "10000", "position": "absolute", "top": win_y + 'px', "left": win_x + 'px' });

    if (okfn != '' && okfn != undefined) {
        okfn();
    }
    if (cancelfn != '' && cancelfn != undefined) {
        cancelfn();
    }
}
$("#alert_close,.btn1,.cancel").live("click", function () {
    $(this).parents(".Panel").remove();
    $("#alert_layer").remove();
});
//selector 当前点击的对象 this
//function closeAlert(selector) {
//    $(selector).parents(".Panel").remove();
//    $("#alert_layer").remove();
//}
function openPopup(pop_id, width, height) {

    var $layer = $("#alert_layer");
    var w = $(document).width();
    var h = $(document).height();
    $layer.css({ "width": w, "height": h, "display": "block" });

    var $pop = $("#" + pop_id);
    var $Table_Panel = $("#" + pop_id + " .Table_Panel");//set height

    if (height != '' && height != undefined) {
        $Table_Panel.css("height", height);
    } else {
        height = 60;
    }
    if (width != '' && width != undefined) {
        $pop.css({ "width": width + 'px' });
    } else {
        width = 600;
    }
    var win_x = ($(window).width() - width) / 2;//随着浏览器的变化而变化，而且不计算滚动条
    var win_y = ($(window).height() - (Number(height) + 60)) / 2 + $(window).scrollTop();
    //防止为负值时，弹窗头部看不到，或弹窗左侧看不到
    if (win_x < 0) {
        win_x = 10;
    }
    if (win_y < 0) {
        win_y = 10;
    }
    $pop.css({ "display": "block", "z-index": "10000", "position": "absolute", "top": win_y + 'px', "left": win_x + 'px' });

}
function closePopup(pop_id) {
    var $pop = $("#" + pop_id);
    $pop.css({ "display": "none" });
    var $layer = $("#alert_layer");
    $layer.css({ "display": "none" });
}

