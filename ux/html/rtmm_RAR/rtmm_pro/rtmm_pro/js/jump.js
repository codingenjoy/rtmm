$(document).ready(function () {


});
//top


    //Tag跳转
    $(".tag").live("click", function () {
        var curid = $(this).attr("id");
        var preid = "";
        $(".tag").each(function () {
            if ($(this).attr("class").indexOf("_off") < 1) {
                preid = $(this).attr("id");
                return false;
            }
        });
        if (curid != preid) {
            //$("#" + preid).addClass("Tag_off");
            //$("#" + curid).removeClass("Tag_off");
            if (curid == "jt_tags1") {
                location.href = "Supplier-11.html";
            }
            else if (curid == "jt_tags2") {
                location.href = "Supplier-12.html";
            }
            else if (curid == "jt_tags3") {
                location.href = "Supplier-13.html";
            }
            else if (curid == "gs_tags1") {
                location.href = "Supplier-21.html";
            }
            else if (curid == "gs_tags2") {
                location.href = "Supplier-22.html";
            }
            else if (curid == "gs_tags31") {
                location.href = "Supplier-23-1.html";
            }
            else if (curid == "gs_tags32") {
                location.href = "Supplier-23-2.html";
            }
            else if (curid == "cs_tags1") {
                location.href = "Supplier-31.html";
            }
            else if (curid == "cs_tags2") {
                location.href = "Supplier-32.html";
            }
            else if (curid == "cs_tags3") {
                location.href = "Supplier-33.html";
            }
            else if (curid == "wsx_tags1"){
                location.href = "Supplier-41.html";
            }
            else if (curid == "wsx_tags2") {
                location.href = "Supplier-32.html";
            }
            else if (curid == "wsx_tags3") {
                location.href = "Supplier-33.html";
            }
            else {
            }
        }
    });

    //toolsicon 跳转
    $(".create_NewMac").live("click", function () {
        location.href = "Supplier-34-1.html";
    });
    $(".s341_next").live("click", function () {
        location.href = "Supplier-34-2.html";
    });
    $(".s342_next").live("click", function () {
        location.href = "Supplier-34-3.html";
    });
    $(".s342_last").live("click", function () {
        location.href = "Supplier-34-1.html";
    });
    $(".s343_last").live("click", function () {
        location.href = "Supplier-34-2.html";
    }); 
    $(".sh_newMac").live("click", function () {
        location.href = "Supplier-44-1.html";
    }); 
    $(".s441_next").live("click", function () {
        location.href = "Supplier-44-2.html";
    });
    $(".s442_last").live("click", function () {
        location.href = "Supplier-44-1.html";
    });
    $(".s21_add").live("click", function () {
        location.href = "Supplier-23-2.html";
    });
