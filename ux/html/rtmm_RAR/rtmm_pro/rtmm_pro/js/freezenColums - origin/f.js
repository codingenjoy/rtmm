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
});
