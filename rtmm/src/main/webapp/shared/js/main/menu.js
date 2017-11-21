//跳转到收藏页面
function gotoFav(mid){
	var currentId=$("#currentId").val();
	window.location.href=ctx+'/fav/'+mid+'?jobFunctionId=0'+currentId;
}

function removeFavE(o,mid){
	$(o).parent().remove();
	removeFav(mid);
	$($("#"+mid).find('span')[2]).removeClass("Fav_On");
}

// 添加收藏
function addFav(mid){
	opFav(mid,true);
	buildFavHTML();
}
// 删除收藏
function removeFav(mid){
	opFav(mid,false);
	buildFavHTML();
}

// 收藏管理
function opFav(mid,flag){
	$.ajax({
		type : "post",
		async : false,
		url : ctx+'/fav/addOrRemove',
		dataType : "json",
		data : {'menuIds':mid,'flag':flag},
		success : function(data) {
			// 操作成功
		},error : function(data) {
			// 操作失败
		}
	});
}

// 构建收藏夹
function buildFavHTML(){
	$('.MyFav').find('li').remove();
    $.ajax({
		type : "post",
		async : false,
		url : ctx + "/fav/getAllFavoriteByStaff",
		dataType : "json",
		success : function(data) {
			$.each(data, function(key, value) {
				$('.MyFav').append('<li><a onclick="gotoFav('+value.id+')">'+value.title+'</a><div onclick="removeFavE(this,'+value.id+')" class="Closediv CircleClose"></div></li>');
			});
		}
	});
}
// 登出
function logout(title,message) {
	top.jConfirm(message,title,function(ret){
		if(ret){
			window.location.href = ctx + '/logout';
		}
	});
}

function myFavDisp2() {
    var left = $(".RMenu").offset().left - 253;
    $(".Myzw").css({ "display": "block", "position": "absolute", "z-index": "1000", "top": "160px", "left": left });
}

$(function(){
	$(".FavDrop6").live("mouseover", function () {
		myFavDisp2();
	});
	$(".FavDrop6").live("mouseout", function () {
	    $(".Myzw").css({ "display": "none" });
	    
	});
	$(".Myzw").live("mouseover", function (){
	    $(".RM4").addClass("RM4_on");
	    favDropDisp();
	    $(".FavDrop6").addClass("FavDrop6_on");
	    myFavDisp2();
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
	$(".changeJobFun").unbind().bind("click",function(){
		var jobFunctionId=$(this).find("#jobFunctionId").val();
		window.location.href = ctx + '/changeJobFun?jobFunctionId='+jobFunctionId;
	});
});
/**/
function pointJobFun(){
	var currentId=$("#currentId").val();
	if(currentId==""||currentId==undefined){
		return;
	}
	var obj=$(".Myzw").find(".changeJobFun");
	$.each($(".Myzw").find(".changeJobFun"),function(i,val){
		if($(val).find("#jobFunctionId").val()==currentId){			
		    $(".Myzw li").removeClass("myzw_li_on");
		    $(val).parent().addClass("myzw_li_on");
		    $(val).unbind();
		}
	});

}
// 回到首页
function toIndex() {
	var currentId=$("#currentId").val();
	window.location.href = ctx + '/index?jobFunctionId='+currentId;
}