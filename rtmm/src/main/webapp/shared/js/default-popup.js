
function commonAlert(title, icon, msg, yesFn) {
    var alertDiv = $("#common_alert_8888");
    if (alertDiv != null) {
    	$("#common_alert_8888").die('click');
        alertDiv.remove();
    }
    var common_alert_div =
			"<div class=\"hide\" id=\"common_alert_8888\">"
                +"<div class=\"popup\">"
                    + "<div class=\"popup_title\">"
                        + "<h2 class=\"f_l\">" + title + "</h2>"
                        + "<div class=\"f_r mg_r_5 mg_t_5\">"
                            + "<a class=\"close_small\" id=\"close_small_link_8888\"></a>"
                        + "</div>"
                        + "<div class=\"clear_both\"></div>"
                    + "</div>"
                    + "<div class=\"popup_body\">"
                        + "<div class=\"f_l mg_l_20 mg_r_20 popup_icons\"><span class=\"inline_bk\"></span></div>"
                        + "<div class=\"f_l a_c popup_con\">"
                            + "<p class=\"mg_b_25 color_333 font_14 w_252 font_b popup_con_paragh\">" + msg + "</p>"
                            + "<p class=\"mg_b_20 popup_con_btn\"><input type=\"button\" value=\"确定\"id='common_alert_8888_yes' class=\"grey_middle_btn color_333 font_b\" /></p>"
                        + "</div>"
                        + "<div class=\"clear_both\"></div>"
                    + "</div>"
                + "</div>"
            + "</div>";
    $(common_alert_div).appendTo("body");
    $('.popup_body .popup_icons span').attr('class', icon);
    $("#close_small_link_8888").live('click', function () {
        $.closePopupLayer('common_alert_8888');
        setTimeout("$(\"select\").removeClass(\"hide\")",1000);
    });
    $("#common_alert_8888_yes").live('click', function () {
        $.closePopupLayer('common_alert_8888');
        setTimeout("$(\"select\").removeClass(\"hide\")",1000);
    });
    if (yesFn) {
        $("#common_alert_8888_yes").live('click', yesFn);
        $("#close_small_link_8888").live('click', yesFn);
    }
    
    openPopup('480', 'common_alert_8888');
//    var h = $(window).height();
//    var w = $(window).width();
//    var st = $(window).scrollTop();
//    var sl = $(window).scrollLeft();
//    $("#common_alert_8888").css("top", ((h - 60) / 2) + st);
//    $("#common_alert_8888").css("left", ((w - 80) / 2) + sl);
};


function commonConfirm(title, icon, msg, yesFn, noFn) {
    var alertDiv = $("#common_confirm_888");
    if (alertDiv != null) {
        $("#common_confirm_888_yes").die('click');
        alertDiv.remove();
    }
    var common_alert_div =
	"<div class=\"hide\" id=\"common_confirm_888\">"
        + "<div class=\"popup\">"
            + "<div class=\"popup_title\">"
                + "<h2 class=\"f_l\">" + title + "</h2>"
                + "<div class=\"f_r mg_r_5 mg_t_5\">"
                    + "<a class=\"close_small\" id=\"close_small_link_888\"></a>"
                + "</div>"
                + "<div class=\"clear_both\"></div>"
            + "</div>"
            + "<div class=\"popup_body\">"
                + "<div class=\"f_l mg_l_20 mg_r_20 popup_icons\"><span class=\"inline_bk\"></span></div>"
                + "<div class=\"f_l a_c popup_con\">"
                    + "<p class=\"mg_b_25 color_333 font_14 font_b popup_con_paragh\">" + msg + "</p>"
                    + "<p class=\"mg_b_20 popup_con_btn\"><input type=\"button\" value=\"确定\"id='common_confirm_888_yes' class=\"grey_middle_btn color_333 font_b\" /><input type=\"button\" value=\"取消\"id='common_confirm_888_no' class=\"grey_middle_btn color_333 font_b mg_l_20\" /></p>"
                + "</div>"
                + "<div class=\"clear_both\"></div>"
            + "</div>"
        + "</div>"
    + "</div>";
    $(common_alert_div).appendTo("body");
    $('.popup_body .popup_icons span').attr('class', icon);
    $("#close_small_link_888").live('click', function () {
        $.closePopupLayer('common_confirm_888');
    });
    $("#common_confirm_888_yes").live('click', function () {
        $.closePopupLayer('common_confirm_888');
    });
    $("#common_confirm_888_yes").live('click', yesFn);
    $("#common_confirm_888_no").live('click', function () {
        $.closePopupLayer('common_confirm_888');
    });
    if (noFn) {
        $("#common_confirm_888_no").live('click', noFn);
    }
    openPopup('280', 'common_confirm_888');
//    var h = $(window).height();
//    var w = $(window).width();
//    var st = $(window).scrollTop();
//    var sl = $(window).scrollLeft();
//    $("#common_confirm_888").css("top", ((h - 60) / 2) + st);
//    $("#common_confirm_888").css("left", ((w - 80) / 2) + sl);
}

function errorAlert(msg,yesFn){
	var title="提示信息";
	var icon="inline_bk orange_ques_small";
	commonAlert(title, icon, msg, yesFn);
}

function errorAlertByTitle(title,msg,str,yesFn){
	var icon="inline_bk orange_ques_small";
	
	var alertDiv = $("#common_alert_8888");
    if (alertDiv != null) {
    	$("#common_alert_8888").die('click');
        alertDiv.remove();
    }
    var common_alert_div =
			"<div class=\"hide\" id=\"common_alert_8888\">"
                +"<div class=\"popup\">"
                    + "<div class=\"popup_title\">"
                        + "<h2 class=\"f_l\">" + title + "</h2>"
                        + "<div class=\"f_r mg_r_5 mg_t_5\">"
                            + "<a class=\"close_small\" id=\"close_small_link_8888\"></a>"
                        + "</div>"
                        + "<div class=\"clear_both\"></div>"
                    + "</div>"
                    + "<div class=\"popup_body\">"
                        + "<div class=\"f_l mg_l_20 mg_r_20 popup_icons\"><span class=\"inline_bk\"></span></div>"
                        + "<div class=\"f_l a_c popup_con\">"
                            + "<p class=\"mg_b_25 color_333 font_14 w_252 font_b popup_con_paragh\">" + msg + "</p>"
                            + "<p class=\"mg_b_25 color_333 font_14 w_252  popup_con_paragh\">" + str + "</p>"
                            + "<p class=\"mg_b_20 popup_con_btn\"><input type=\"button\" value=\"返回\"id='common_alert_8888_yes' class=\"grey_middle_btn color_333 font_b\" /></p>"
                        + "</div>"
                        + "<div class=\"clear_both\"></div>"
                    + "</div>"
                + "</div>"
            + "</div>";
    $(common_alert_div).appendTo("body");
    $('.popup_body .popup_icons span').attr('class', icon);
    $("#close_small_link_8888").live('click', function () {
        $.closePopupLayer('common_alert_8888');
        setTimeout("$(\"select\").removeClass(\"hide\")",1000);
    });
    $("#common_alert_8888_yes").live('click', function () {
        $.closePopupLayer('common_alert_8888');
        setTimeout("$(\"select\").removeClass(\"hide\")",1000);
    });
    if (yesFn) {
        $("#common_alert_8888_yes").live('click', yesFn);
        $("#close_small_link_8888").live('click', yesFn);
    }
    openPopup('480', 'common_alert_8888');
}

function successAlert(msg,yesFn){
	var title="提示信息";
	var icon="inline_bk orange_true_small";
	commonAlert(title, icon, msg, yesFn);
}

function showLoadingPop()
{
	var loading_div='<div id="loading_div_9999" class="hide" style="text-align: center;">'
		+'<div class="loading_img2"></div>'
		+'</div>';
	$(loading_div).appendTo("body");
	openPopup('480', 'loading_div_9999');
}
//function showLoadingPop()
//{
//	var loading_div='<div id="loading_div_9999" class="hide">'
//		+'<div class="pop">'
//		+'<div class="loading_content">'
//		+'<div class="loading_img"></div>'
//		+'<div class="loading_text">正在执行,请稍候...</div>'
//		+'</div>'
//		+'</div>'
//		+'</div>';
//	$(loading_div).appendTo("body");
//	openPopup('480', 'loading_div_9999');
//}
function closeLoadingPop()
{
	$.closePopupLayer('loading_div_9999');
}

function commonConfirmWidth(title, icon, msg, width,yesFn, noFn){
	  var alertDiv = $("#common_confirm_888");
	    if (alertDiv != null) {
	        $("#common_confirm_888_yes").die('click');
	        alertDiv.remove();
	    }
	    var common_alert_div =
		"<div class=\"hide\" id=\"common_confirm_888\">"
	        + "<div class=\"popup\">"
	            + "<div class=\"popup_title\">"
	                + "<h2 class=\"f_l\">" + title + "</h2>"
	                + "<div class=\"f_r mg_r_5 mg_t_5\">"
	                    + "<a class=\"close_small\" id=\"close_small_link_888\"></a>"
	                + "</div>"
	                + "<div class=\"clear_both\"></div>"
	            + "</div>"
	            + "<div class=\"popup_body\">"
	                + "<div class=\"f_l mg_l_20 mg_r_20 popup_icons\"><span class=\"inline_bk\"></span></div>"
	                + "<div class=\"f_l a_c popup_con\">"
	                    + "<p class=\"mg_b_25 color_333 font_14 font_b popup_con_paragh\">" + msg + "</p>"
	                    + "<p class=\"mg_b_20 popup_con_btn\"><input type=\"button\" value=\"确定\"id='common_confirm_888_yes' class=\"grey_middle_btn color_333 font_b\" /><input type=\"button\" value=\"取消\"id='common_confirm_888_no' class=\"grey_middle_btn color_333 font_b mg_l_20\" /></p>"
	                + "</div>"
	                + "<div class=\"clear_both\"></div>"
	            + "</div>"
	        + "</div>"
	    + "</div>";
	    $(common_alert_div).appendTo("body");
	    $('.popup_body .popup_icons span').attr('class', icon);
	    $("#close_small_link_888").live('click', function () {
	        $.closePopupLayer('common_confirm_888');
	    });
	    $("#common_confirm_888_yes").live('click', function () {
	        $.closePopupLayer('common_confirm_888');
	    });
	    $("#common_confirm_888_yes").live('click', yesFn);
	    $("#common_confirm_888_no").live('click', function () {
	        $.closePopupLayer('common_confirm_888');
	    });
	    if (noFn) {
	        $("#common_confirm_888_no").live('click', noFn);
	    }
	    openPopup(width, 'common_confirm_888');
	
}

function logout(){
	var title="提示信息";
	var icon="inline_bk orange_ques_small";
	var msg = "确认退出登录?";
	commonConfirmWidth(title, icon, msg, 300,
		function(){
			window.location.href = ctx+"/logout.do";
		}
	);	
}

function defaultDelConfirm(fun){
	var title="确认信息";
	var icon="inline_bk orange_ques_small";
	var msg = "确定要删除吗?";
	commonConfirmWidth(title, icon, msg, 300,fun);
}