$("a, input[type='button'], input[type='submit'], input[type='checkbox'],input[type='radio']").live("focus", function () {
    if (this.blur) {
        this.blur();
    }
});
function fixWidth(parent, percent) {
    return ($(parent).css("width")) * percent; //这里你可以自己做调整  
}
window.fixWidth = fixWidth;
function favDropDisp() {
    var top = "40px";
    var left = $(".RMenu").offset().left + 1;
    //var R_Point = $(".RMenu").offset().left;//RMenu ol 的起点坐标
    $(".FavDrop").css({ "display": "block", "position": "absolute", "z-index": "999", "top": "40px", "left": left });
}
function myFavDisp() {
    var left = $(".RMenu").offset().left - 213;
    $(".MyFav").css({ "display": "block", "position": "absolute", "z-index": "1000", "top": "42px", "left": left });
}
//function myFavDisp2() {
//    var left = $(".RMenu").offset().left - 303;
//    $(".Myzw").css({ "display": "block", "position": "absolute", "z-index": "1000", "top": "160px", "left": left });
//}
function setBg(preId, curId) {

    if (curId != preId) {//说明没有点击在同一个菜单
        if (preId != "" && preId != undefined) {
            $("#" + preId).removeClass("Sub_on");
            $("#" + curId).addClass("Sub_on");
        } else {
            $("#" + curId).addClass("Sub_on");
        }
    }
}
function setMenuTitle(str) {
    if (str.length > 5) {
        str = str.substring(0, 5) + "...";
    }
    return str;
}
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



$(".input_propt_color").live("click", function () {
    $(this).val("");
    $(this).removeClass("input_propt_color");
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
//week
    $(".week div").live("click", function () {
        $(this).toggleClass("weekon");
    });
    $(".Rect2Check").live("click", function () {
        $(this).prev().children().toggleClass("weekon");
    });


    $(document).ready(function () {
        //List item 列表点击 单选
        $(".CM-div,.gyBlock").delegate(".item", "click", function () {
            var pre = "";
            var cur = $(this).attr("class");;

            $(this).parent().find(".item_on").removeClass("item_on");

            $(this).addClass("item_on");
        });
        //List item 列表点击 多选
        $(".CM-div").delegate(".item2,.item3,.item4", "click", function () {
            $(this).toggleClass("item_on");
        });
        //收藏
        $('.TopMenu').delegate(".Fav", "click", function () {
            var mid = $(this).parent().attr('id');
            $(this).removeClass("Fav_bigger1");
            $(this).removeClass("Fav_bigger2");
            $(this).toggleClass("Fav_On");
            if ($(this).attr("class").indexOf("Fav_On") > 0) {
                addFav(mid);
            } else {
                removeFav(mid);
            }

        });
        $('.TopMenu').delegate(".Fav", "mouseover", function () {
            if ($(this).attr("class").indexOf("Fav_On") > 0) {
                $(this).addClass("Fav_bigger2");
            } else {
                $(this).addClass("Fav_bigger1");
            }
        });
        $('.TopMenu').delegate(".Fav", "mouseout", function () {
            if ($(this).attr("class").indexOf("Fav_On") > 0) {
                $(this).removeClass("Fav_bigger2");
            } else {
                $(this).removeClass("Fav_bigger1");
            }
        });
        //MyFav
        $(".TopMenu").delegate(".FavDrop1", "mouseover", function () {
            //alert("xx");
            myFavDisp();
        });
        $(".TopMenu").delegate(".FavDrop1", "mouseout", function () {
            $(".MyFav").css({ "display": "none" });
        });
        //Myzw
        $(".TopMenu").delegate(".FavDrop6", "mouseover", function () {
            var left = $(".RMenu").offset().left - 253;
            $(".Myzw").css({ "display": "block", "position": "absolute", "z-index": "1000", "top": "160px", "left": left });
        });
        $(".TopMenu").delegate(".FavDrop6", "mouseout", function () {
            $(".Myzw").css({ "display": "none" });
        });
        $(".TopMenu").delegate(".MyFav", "mouseover", function () {
            $(".RM4").addClass("RM4_on");
            favDropDisp();
            $(".FavDrop1").addClass("FavDrop1_on");
            myFavDisp();
        });
        $(".TopMenu").delegate(".MyFav", "mouseout", function () {
            $(".RM4").removeClass("RM4_on");
            $(".FavDrop1").removeClass("FavDrop1_on");
            $(this).css({ "display": "none" });
            $(".FavDrop").css("display", "none");
        });
        //$(".TopMenu").live(".Myzw", "mouseover", function () {
        //    $(".RM4").addClass("RM4_on");
        //    favDropDisp();
        //    $(".FavDrop6").addClass("FavDrop6_on");
        //    myFavDisp2();
        //});
        //点击顶部菜单，更换背景
        $(".MainMenu").delegate("a", "click", function () {
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
        //++ --
        $(".SubMenu").delegate(".Expend1", "click", function () {
            $(".SubList ol").css("display", "block");
            $(".L1_Yes").removeClass('L1_Yes_ss');
        });
        $(".SubMenu").delegate(".Expend2", "click", function () {
            $(".SubList ol").css("display", "none");
            $(".L1_Yes").addClass('L1_Yes_ss');
        });
        $(".tbx").delegate("tr","click", function () {
            $('.tbx').find('.item_on2').removeClass('item_on2');

            $(this).addClass("item_on2");

            var y = $(this).offset().top - 120;

            $(".px").css({ "top": y });
        });
        $(".SubMenu").delegate(".SubText,.L1_Yes,.L1_Yes_ss", "click", function () {

            var curId = "";
            curId = $(this).parent().attr("id");

            var preId = "";
            $(".Sub").each(function () {

                if ($(this).attr("class").indexOf("Sub_on") > 0) {

                    preId = $(this).attr("id");

                    return false;
                }
            });

            var child = $(this).parent().parent().children("ol");
            if (child.length > 0) {
                child.toggle();
                if ($(this).attr("class").indexOf("L1_Yes") < 0) {
                    $(this).prev().toggleClass("L1_Yes_ss");
                } else {
                    $(this).toggleClass("L1_Yes_ss");
                }
            }

            setBg(preId, curId);

        });
        //Topmenu RightMenu
        $(".TopMenu").delegate(".RMenu", "mouseover", function () {
            favDropDisp();
        });
        $(".TopMenu").delegate(".RMenu", "mouseout", function () {
            $(".FavDrop").css({ "display": "none" });
        });
        //检索Icon
        $(".ToolBar").delegate(".Tools1", "click", function () {
            $(".Tools1").parent().toggleClass("Tools1Parent_bg");
            $(".Tools1").toggleClass("Tools1_on");
        });
        $(".ToolBar").delegate(".Tools1", "mouseover", function () {
            $(".Tools1").addClass("Tools1_over");
        });
        $(".ToolBar").delegate(".Tools1", "mouseout", function () {
            $(".Tools1").removeClass("Tools1_over");
        });
        $(".Search").delegate(".C-id", "click", function () {
            $(".Tools1").parent().removeClass("Tools1Parent_bg");
            $(".Tools1").removeClass("Tools1_on");
        });
        //data table
        //table 单行选中 多行选中
        $(".multi_tb").delegate("tr", "click", function () {
            $(this).toggleClass("btable_checked");
        });
        $(".single_tb").delegate("tr", "click", function () {
            if ($(this).parents("table").attr("class") != "" && $(this).parents("table").attr("class") != undefined) {
                $(this).parents("table").find(".btable_checked").removeClass("btable_checked");
                $(this).toggleClass("btable_checked");
            } else {
                return false;
            }
        });
        //商品批量修改，单选框控制内容却换
        $(".dis_item_supplier").delegate("input", "click", function () {
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
        $(".need_update_item").delegate("input", "click", function () {
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
        $(".Myzw").delegate(".Myzw li", "click", function () {
            $(".Myzw li").removeClass("myzw_li_on");
            $(this).addClass("myzw_li_on");
        });
        $(".TopMenu").delegate(".Myzw", "mouseleave", function () {
            
            $(".FavDrop6").removeClass("FavDrop6_on");
            $(".FavDrop").css("display", "none");
            $(".Myzw").css("display", "none");
        });
        $(".btable_div").scroll( function () {
            var left = $(this).scrollLeft();
            //alert(left);
            $(".htable_div").scrollLeft(left);
        });
        $("table").delegate(".tr_close", "click", function () {
            var $borther = $(this).parent().next(".trSpecial");
            if ($borther.length < 1) {
                alert("当前数据行没有隐藏的子行！");
                return false;
            }
            $(this).addClass("tr_open");
            $(this).removeClass("tr_close");
            $borther.removeClass("Bar_off");
        });
        $("table").delegate(".tr_open","click", function () {
            var $borther = $(this).parent().next(".trSpecial");

            $(this).addClass("tr_close");
            $(this).removeClass("tr_open");
            $borther.addClass("Bar_off");
        });
    });

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

    