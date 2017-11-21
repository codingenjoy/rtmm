//拼写Json格式
function convertJsonStr(obj, val){
    var div_name = $("#"+obj).find("."+val);
    var comma = "--";
    var bracket_left = "{";
    var bracket_right = "}";
    var div_str = "";
    $.each(div_name, function(i,val){
        var str = "";
        var div_name_ig = $(div_name[i]).find("input");
        $.each(div_name_ig,function(j, val){
            if (val.name != "") {
                str = str + '"' + val.name + '":"' + val.value + '",';
            }
        });
        str = str.substring(0,str.length-1);
        div_str = div_str + bracket_left + str + bracket_right + comma;
    });
    div_str = div_str.substring(0, div_str.length-2);
    return div_str;
}