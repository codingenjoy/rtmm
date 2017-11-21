$(function () {
    $("#m_cols_body").scroll(function () {
        var ys_top = $(this).scrollTop();
        var xs_left = $(this).scrollLeft();
        
        var xm_left = $("#m_cols_head").scrollLeft();

        var yf_top = $("#f_cols_body").scrollTop();

        //if (xs_left != undefined && xs_left != xm_left && xs_left > 0) {
        //    //drag x-scroll(#m_cols_head move)
        //    $("#m_cols_head").scrollLeft(xs_left);
        //}
        //if (ys_top != undefined && ys_top != yf_top && ys_top > 0) {
        //    //drag y-scroll(#f_cols_body move)
        //    $("#f_cols_body").scrollTop(ys_top);
        //}
        if (xs_left != undefined) {
            //drag x-scroll(#m_cols_head move)
            $("#m_cols_head").scrollLeft(xs_left);
        }
        if (ys_top != undefined ) {
            //drag y-scroll(#f_cols_body move)
            $("#f_cols_body").scrollTop(ys_top);
        }

    });
    $(".m_cols_body").scroll(function () {
        var ys_top = $(this).scrollTop();
        var xs_left = $(this).scrollLeft();

        var xm_left = $(".m_cols_head").scrollLeft();

        var yf_top = $(".f_cols_body").scrollTop();

        if (xs_left != undefined) {

            $(".m_cols_head").scrollLeft(xs_left);
        }
        if (ys_top != undefined) {

            $(".f_cols_body").scrollTop(ys_top);
        }

    });

    $(".m_cols_body tr:even,.f_cols_body tr:even").addClass("default_bg");

    $(".m_cols_body tr,.f_cols_body tr").mouseover(function () {
        var index = $(this).attr("_index");
        var $tr = $("." + index);
        $tr.addClass("tr_hover");
    });
    $(".m_cols_body tr,.f_cols_body tr").mouseout(function () {
        var index = $(this).attr("_index");
        var $tr = $("." + index);
        $tr.removeClass("tr_hover");
    });
    $(".m_cols_body tr,.f_cols_body tr").click(function () {

        var index = $(this).attr("_index");
        var $tr = $("." + index);

        $tr.parents(".m_cols_body").find(".tr_click_on").removeClass("tr_click_on");
        $tr.parents(".f_cols_body").find(".tr_click_on").removeClass("tr_click_on");

        $tr.toggleClass("tr_click_on");
    });
    


});
