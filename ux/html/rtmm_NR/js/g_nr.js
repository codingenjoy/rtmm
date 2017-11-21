$(".RMenu").live("mouseover", function () {
    //var win_x = $(window).width();//随着浏览器的变化而变化，而且不计算滚动条
    //var win = screen.width;//屏幕设置的分辨率
    //var winx = window.innerWidth;//ie 不支持
    //alert("jq:"+win_x+" js:"+win+"  window:"+winx);//jq:1490 1920 1507(含滚动条）
    favDropDisp();
});
function favDropDisp() {
    var top = "40px";
    var left = $(".RMenu").offset().left + 1;
    //var R_Point = $(".RMenu").offset().left;//RMenu ol 的起点坐标
    $(".FavDrop").css({ "display": "block", "position": "absolute", "z-index": "999", "top": "40px", "left": left });
}
$(".RMenu").live("mouseout", function () {
    //$(".FavDrop").removeClass("RMenu_selected");
    $(".FavDrop").css({ "display": "none" });
});
//收藏

$('.Fav').live("click", function (e) {
    e.stopPropagation();
    var mid = $(this).parent().attr('id');
    $(this).removeClass("Fav_bigger1");
    $(this).removeClass("Fav_bigger2");
    $(this).toggleClass("Fav_On");
    if ($(this).attr("class").indexOf("Fav_On") > 0) {
        //addFav(mid);
    } else {
        //removeFav(mid);
    }

});
$('.Fav').live("mouseover", function () {
    if ($(this).attr("class").indexOf("Fav_On") > 0) {
        $(this).addClass("Fav_bigger2");
    } else {
        $(this).addClass("Fav_bigger1");
    }
});
$('.Fav').live("mouseout", function () {
    if ($(this).attr("class").indexOf("Fav_On") > 0) {
        $(this).removeClass("Fav_bigger2");
    } else {
        $(this).removeClass("Fav_bigger1");
    }
});
//MyFav
$(".FavDrop1").live("mouseover", function () {
    myFavDisp();
});
$(".FavDrop1").live("mouseout", function () {
    if ($(".RM4").attr("class").indexOf("RM4_on") < 0) {
        //表示鼠标已经离开收藏列表
        $(".MyFav").css({ "display": "none" });
    }
});
function myFavDisp() {
    var left = $(".RMenu").offset().left - 213;
    $(".MyFav").css({ "display": "block", "position": "absolute", "z-index": "1000", "top": "42px", "left": left });
}
$(".MyFav").live("mouseover", function () {
    $(".RM4").addClass("RM4_on");
    favDropDisp();
    $(".FavDrop1").addClass("FavDrop1_on");
    myFavDisp();
});
$(".MyFav").live("mouseout", function () {
    $(".RM4").removeClass("RM4_on");
    $(".FavDrop1").removeClass("FavDrop1_on");
    $(this).css({ "display": "none" });
    $(".FavDrop").css("display", "none");
});
$(".Sub").live("click", function () {
    $(".Sub").removeClass("Sub_on");
    $(this).addClass("Sub_on");
});
function setMenuTitle(str) {
    if (str.length > 5) {
        str = str.substring(0, 5) + "...";
    }
    return str;
}
//++ --
$(".Expend1").live("click", function () {
    $(".SubList ol").css("display", "block");
    $(".L1_Yes").removeClass('L1_Yes_ss');
});
$(".Expend2").live("click", function () {
    $(".SubList ol").css("display", "none");
    $(".L1_Yes").addClass('L1_Yes_ss');
});
//点击顶部菜单，更换背景
$(".MainMenu a").live("click", function () {
    var t_preId = "";
    var t_curId = $(this).attr("class");

    var pre_on = "";//已经选定的样式
    var cur_on = "";//当前点击的，需要的样式

    if (t_curId.indexOf("_on") < 0) {//说明没有点击在同一个菜单,当前点击的菜单没有XX_on

        cur_on = t_curId + "_on";

        if (t_preId == "" || t_preId == undefined) {
            //如果记录上次点击的class为空，则需要循环检查"xx_on"
            $(".MainMenu a").each(function () {
                //var xx=$(this).attr("class").indexOf("_on") ;
                var temp_pre = "";
                if ($(this).attr("class").indexOf("_on") > 0) {
                    temp_pre = $(this).attr("class");
                    var tmp_arr = temp_pre.split(" ");
                    for (var i = 0; i < tmp_arr.length; i++) {
                        if (tmp_arr[i].indexOf("_on") > 0) {
                            pre_on = tmp_arr[i];
                            t_preId = pre_on.substring(0, pre_on.indexOf("_on"));
                            return false;
                        }
                    }
                }
            });
        }
        if (t_preId != "" && t_preId != undefined) {
            $("." + t_preId).removeClass(pre_on);
        }
        $("." + t_curId).addClass(cur_on);

        t_preId = t_curId;
    }
});

$(function () {
    

    $(".HiddenSub").click(function (e) {
        e.stopPropagation();
        $(".SubMenu").addClass("off_nr");
        $(".SideBar").removeClass("off_nr");
        $(".LeftContainer").removeClass("left_menu").addClass("side_bar");
        $(".Container_nr").addClass("Container_nr_SideBar");
        $(".side_bar").unbind("click").bind("click", function () {
            hiddenSideBar();
        });
    });
    
    $(".searchToolBar").click(function () {
        if (!$(this).hasClass("searchToolBar_off")) {
            $(".search_ctr").toggleClass("off_nr");
            $(".Content_nr").toggleClass("search_hap");
        }
    });
    $(".search_top .CircleClose").click(function () {
        $(".search_ctr").addClass("off_nr");
        $(".Content_nr").removeClass("search_hap");
    });

    $(".r_txt").delegate(".switch_r", "click", function () {
        $(this).toggleClass("switch_off");

        var $child = $(this).parents(".r_txt").next();
        var childClass = $child.prop("class");

        if ($(this).hasClass(childClass)) {
            $child.toggle();
        }
    });

    $(".ct_info").delegate(".ct_ck", "change", function () {
        var type = $(this).prop("name");
        var $icon = $(".sh_i" + type);

        var $op=$icon.parent(".w20");

        if ($(this).prop("checked")) {
            $op.css("display", "block");
        } else {
            $op.css("display", "none");
        }
    });
});
function hiddenSideBar() {
    $(".SubMenu").removeClass("off_nr");
    $(".SideBar").addClass("off_nr");
    $(".LeftContainer").addClass("left_menu").removeClass("side_bar");
    $(".Container_nr").removeClass("Container_nr_SideBar");
    $(".side_bar").unbind("click");
}
