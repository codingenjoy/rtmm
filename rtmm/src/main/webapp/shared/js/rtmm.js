	 $("a, input[type='button'], input[type='submit'], input[type='checkbox'],input[type='radio']").live("focus", function () {
		    if (this.blur) {
		        this.blur();
		      }
		   });
    function fixWidth(parent,percent) {
        return ($(parent).css("width")) * percent; //这里你可以自己做调整  
    }
    window.fixWidth = fixWidth;
    //Topmenu RightMenu
    $(".RMenu").live("mouseover",function () {
        //var win_x = $(window).width();//随着浏览器的变化而变化，而且不计算滚动条
        //var win = screen.width;//屏幕设置的分辨率
        //var winx = window.innerWidth;//ie 不支持
        //alert("jq:"+win_x+" js:"+win+"  window:"+winx);//jq:1490 1920 1507(含滚动条）
        favDropDisp();
    });
    function favDropDisp(){
        var top = "40px";
        var left = $(".RMenu").offset().left + 1;
        //var R_Point = $(".RMenu").offset().left;//RMenu ol 的起点坐标
        $(".FavDrop").css({ "display": "block", "position": "absolute","z-index":"999", "top": "40px", "left": left });
    }
    $(".RMenu").live("mouseout",function () {
        //$(".FavDrop").removeClass("RMenu_selected");
        $(".FavDrop").css({ "display": "none" });
    });
    //收藏

    $('.Fav').live("click", function () {
        var mid = $(this).parent().attr('id');
        $(this).removeClass("Fav_bigger1");
        $(this).removeClass("Fav_bigger2");
        $(this).toggleClass("Fav_On");
        if ($(this).attr("class").indexOf("Fav_On")>0) {
            addFav(mid);
        } else {
            removeFav(mid);
        }

    });
    $('.Fav').live("mouseover", function () {
        if ($(this).attr("class").indexOf("Fav_On") > 0) {
            $(this).addClass("Fav_bigger2");
        } else {
            $(this).addClass("Fav_bigger1");
        }
    });
    $('.Fav').live("mouseout",function () {
        if ($(this).attr("class").indexOf("Fav_On") > 0) {
            $(this).removeClass("Fav_bigger2");
        } else {
            $(this).removeClass("Fav_bigger1");
        }
    });
    //MyFav
    $(".FavDrop1").live("mouseover",function () {
        //alert("xx");
        myFavDisp();
    });
    $(".FavDrop1").live("mouseout",function () {
        if ($(".RM4").attr("class").indexOf("RM4_on") < 0){
            //表示鼠标已经离开收藏列表
            $(".MyFav").css({ "display": "none" });
        }
    });
    function myFavDisp() {
        var left = $(".RMenu").offset().left - 213;
        $(".MyFav").css({ "display": "block", "position": "absolute", "z-index": "1000", "top": "42px", "left": left });
    }
    $(".MyFav").live("mouseover",function () {
        $(".RM4").addClass("RM4_on");
        favDropDisp();
        $(".FavDrop1").addClass("FavDrop1_on");
        myFavDisp();
    });
    $(".MyFav").live("mouseout",function () {
        $(".RM4").removeClass("RM4_on");
        $(".FavDrop1").removeClass("FavDrop1_on");
        $(this).css({ "display": "none" });
        $(".FavDrop").css("display","none" );
    });
    
    $(".SubText,.L1_Yes,.L1_Yes_ss").live("click", function () {

    	var curId = "";
        curId = $(this).parent().attr("id");
        
        var preId="";
        $(".Sub").each(function(){
        	
        	if($(this).attr("class").indexOf("Sub_on")>0){
        		
        		preId=$(this).attr("id");
        		
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
        
        setBg(preId,curId);
        
    });
    
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
//程序员不要拷贝这段代码start
    //CTitle
    //$(".tagsM").live("click", function () {
    //    if ($(this).nextAll().filter(".tags3_close_on") != undefined && $(this).nextAll().filter(".tags3_close_on").attr("class")!="") {
    //        //alert("是否保存！");
    //        add3_2($(this).nextAll().filter(".tags3_close_on").prev());
    //    }
        
    //    if ($(this).attr("class").indexOf("tagsM_on") < 0) {
    //        removeC();
    //        if ($(this).next().attr("class").indexOf("tags3") > -1) {
    //            //3 点击的是最后一个
    //            add3_1(this);
    //        } else if ($(this).prev().attr("class").indexOf("tags1") > -1) {
    //            //1
    //            add1(this);
    //        } else {
    //            add2(this);
    //        }
    //    }
    //});
    //function removeC() {
    //    $(".CTitle").find(".tagsM_on,.tags1_left_on,.tags_left_on,.tags_right_on").removeClass("tagsM_on tags1_left_on tags_left_on tags_right_on");
    //    $(".tags3_r_on").addClass("tags3_r_off");
    //    $(".tags3_r_on").removeClass("tags3_r_on");

    //}
    //function add1(s) {
    //    $(s).prev().addClass("tags1_left_on");
    //    $(s).addClass("tagsM_on");
    //    $(s).next().addClass("tags_left_on");
    //}
    //function add2(s) {
    //    $(s).prev().addClass("tags_right_on");
    //    $(s).addClass("tagsM_on");
    //    $(s).next().addClass("tags_left_on");
    //}
    //function add3_1(s) {
    //    $(s).prev().addClass("tags_right_on");
    //    $(s).addClass("tagsM_on");
    //    $(s).next().removeClass("tags3_r_off");
    //    $(s).next().addClass("tags3_r_on");
    //}
    //function add3_2(s) {
    //    s.prev().removeClass("tags3 tags_right_on");
    //    s.prev().addClass("tags3_r_off");
    //    s.next().remove();
    //    s.remove();
    //}
    //$(".tags_close").live("click", function () {
    //    $(".tagsM_q,.tags3_close_on").remove();
    //    $(".tags3").prev().prev().addClass("tags_right_on");
    //    $(".tags3").prev().addClass("tagsM_on");
    //    $(".tags3").addClass("tags3_r_on");
    //    $(".tags3").removeClass("tags3 tags_right_on");
    //});

    //$(".testAdd").click(function () {
    //    removeC();
    //    $(".tags3_r_off").addClass("tags3 tags_right_on");
    //    $(".tags3_r_off").removeClass("tags3_r_off");
    //    var selector = $('<div class="tagsM_q  tagsM_on">信息维护信息维护.J Mogen Banker</div><div class="tags3_close_on"><div class="tags_close"></div></div>');
    //    selector.appendTo(".CTitleX");
    //});
//程序员不要拷贝这段代码 end

    //点击顶部菜单，更换背景
    $(".MainMenu a").live("click",function () {
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
    //点击右侧tools，更换背景
    $(".RightTool div").live("click", function () {
        var yy = $(this).attr("class");
        var xx=$(this).attr("class").indexOf("Tools21");
        if ($(this).attr("class").indexOf("disable") < 0) {
            if ($(this).attr("class").indexOf("Tools22") > -1) {
                $(".Tools21").removeClass("Tools21_on");
                $(".Tools21").parent().removeClass("ToolsBg");
                $(this).addClass("Tools22_on");
                $(this).parent().addClass("ToolsBg");

            } else if ($(this).attr("class").indexOf("Tools21") > -1) {
                $(".Tools22").removeClass("Tools22_on");
                $(".Tools22").parent().removeClass("ToolsBg");
                $(this).addClass("Tools21_on");
                $(this).parent().addClass("ToolsBg");
            } else {
                alert("Something is ERROR!");
            }
        }
    });
    $(".RightTool div").live("mouseover", function () {
        if ($(this).attr("class").indexOf("disable") < 0) {
            if ($(this).attr("class").indexOf("Tools22") > -1) {
                $(this).addClass("Tools22_hover");
                $(this).removeClass("Tools22");
            } else if ($(this).attr("class").indexOf("Tools21") > -1) {
                $(this).addClass("Tools21_hover");
                $(this).removeClass("Tools21");
            } else {
                alert("Something is ERROR!");
            }
        }
    });
    $(".RightTool div").live("mouseout", function () {
        if ($(this).attr("class").indexOf("disable") < 0) {
            if ($(this).attr("class").indexOf("Tools22") > -1) {
                $(this).removeClass("Tools22_hover");
                $(this).addClass("Tools22");
            } else if ($(this).attr("class").indexOf("Tools21") > -1) {
                $(this).removeClass("Tools21_hover");
                $(this).addClass("Tools21");
            } else {
                alert("Something is ERROR!");
            }
        }
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
                $(".SideBarText").text($(".SideBarText").text($('.Sub_on > .SubText').text()));
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

    //scroll bar datagrid
    function gridbar_B(){
    	$(".datagrid-body").toggleClass("scroll_bar");
    }
    function gridbar_C(){
    	$(".datagrid-body").removeClass("scroll_bar");
    }
    
//日历
    //$(".C_Func").live("click", function () {
    //    var top = $(this).parent().offset().top + 25;
    //    var left = $(this).parent().offset().left;
    //    $("#date_div").css({ "left": left, "top": top });
    //    $("#date_div").toggle();

    //    document.onclick = function (e) {
    //        var evt = window.event; //|| arguments.callee.caller.arguments[0]; // 获取event对象
    //        var tar;  //evt.srcElement ||  获取触发事件的源对象
    //        if (e == undefined) {
    //            tar = evt.srcElement;
    //        } else {
    //            tar = e.target;
    //        }
            
    //        if (tar.parentElement.className != "calendar-header") {
    //            $("#date_div").hide();
    //        }
    //    }
    //    var input = $(this).prev("input");
    //    $('#date_div').calendar({
    //        onSelect: function (date) {
    //            //
    //            //input.val(date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate());
    //            $(input).attr('value', date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate()).trigger('change');
    //            //alert(date.getFullYear() + ":" + (date.getMonth() + 1) + ":" + date.getDate());
    //            $("#date_div").css("display", "none");
    //        }
    //    });
    //});;
    //++ --
    $(".Expend1").live("click", function () {
        $(".SubList ol").css("display", "block");
        $(".L1_Yes").removeClass('L1_Yes_ss');
    });
    $(".Expend2").live("click", function () {
        $(".SubList ol").css("display", "none");
        $(".L1_Yes").addClass('L1_Yes_ss');
    });
    //新增页面Tag catelog-11.html
    //$(".adduser").live("click", function () {
    //    //alert("Ri");
    //    $(".Container").load("Catelog-11-1.html");
    //});
    //$(".Tag_close").live("click", function () {

    //});
    //弹出层 catelog-51.html
    //$(".addLarge").live("click", function () {
    //    //window
    //    $('#win').load("Catelog-51-panel.html");
    //    var x = $(window).width();
    //    $('#popWin').css({ "display": "block" ,"top":"100px;","left":(x-600)/2});
    //});
    //List item 列表点击 单选 
    $(".pr21 .item,.CM-div .item,.gyBlock .item").live("click", function () {
            $(this).parent().find(".item_on").removeClass("item_on");
            $(this).addClass("item_on");
        });

    //List item 列表点击 多选
    $(".item2,.item3,.item4").live("click", function () {
    	if ($(this).find("input").attr("disabled") != "disabled"){
     	   $(this).toggleClass("item_on");
     	   if ($(this).hasClass("item_on")){
               $(this).find("input:checkbox").attr("checked", "checked");    		   

     	   }else{
     		   $(this).find("input:checkbox").removeAttr("checked");
     	   }
        }
     });
    $(".tbx tr").live("click", function () {
        $('.tbx').find('.item_on2').removeClass('item_on2');

        $(this).addClass("item_on2");

        var y = $(this).offset().top-120;

        $(".px").css({ "top": y });
    });
// 全选 设置包含input的div class=“inputDiv” 全选input class=“checkAll”;另外input的父标签是label，label的父标签是一个div，这个div就是随着选中状态变色
    $(".checkAll").live("click", function () {
        var isCheck = this.checked;
        var input = $(".inputDiv input[name=" + this.name + "]:not(:disabled)");
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
    /*$(".week div").live("click", function () {
        $(this).toggleClass("weekon");
    });
    $(".Rect2Check").live("click", function () {
        $(this).prev().children().toggleClass("weekon");
    });*/

//data table
//table 单行选中 多行选中
    $(".multi_tb tr").live("click", function () {
        $(this).toggleClass("btable_checked");
    });
    $(".single_tb tr").live("click", function () {
        $(this).parents("table").find(".btable_checked").removeClass("btable_checked");
        $(this).toggleClass("btable_checked");
    });
    function setBorderRig(className){
    	var thArr =  $(className).find('.datagrid-header-row > td > div');
    	for(var i = 1;i<thArr.length-2;i++){
    		$(thArr[i]).css("border-right", "1px solid #ccc");
    	}
    	var trArr =  $(className).find('.datagrid-row');
    	for(var i = 0;i<trArr.length;i++){
    		var divArr = $(trArr[i]).find('div');
    		for(var j = 1;j<divArr.length-2;j++){
    			$(divArr[j]).css("border-right", "1px solid #fff");
    		}
    	}
    };
    $(document).ready(function () {
        $(".btable_div").scroll( function () {
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
    function confirmWindow(msg, width, height, title,okfn,cancelfn) {

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

    /*
    菜单
*/
function mainMenu() {
    this.setWidth();
}
/*
    控制非定宽菜单的宽度
*/
mainMenu.prototype.setWidth = function () {
    var num = $(".MainMenu li").length;
    $("ol.MainMenu").animate({ "width": num * 100 + "px" },20);
}
/*
    左右方向按钮控制菜单的移动
    direct - string（"left","right") 或
    direct - number（1，-1）， 移动方向，右移按钮值为-1，,左移按钮为1
    distance - number,移动距离，可选，默认移动100(px)
    obj - object,要移动的对象,可选
*/
mainMenu.prototype.move = function (direct,distance,obj) {
    var d = 0;
    distance = distance ? distance : 900;
    if(typeof(direct)=="string"){
        d=direct=="left"?1:(-1);
    }else{
        d=direct;
    }
    obj = obj ? $(obj) : $("ol.MainMenu");
    var ltVal = obj.css("left");
    var left = parseInt(ltVal.substr(0, ltVal.length - 2));
    var wVal = obj.css("width");
    var width = parseInt(wVal.substr(0, wVal.length - 2));;
    var lt = (left + d * distance);
    if (lt <= 0) {
        if (Math.abs(lt) <= width) {//Math.abs(lt)+ 900 
            obj.animate({ "left": lt + "px" }, 300);
        }
    }
    else {
        obj.css("left", 0);
    }
}

