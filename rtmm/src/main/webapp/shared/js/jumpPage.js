
/**
 * 跳转
 * @param 跳转的页号
 */
function jumpPage(pageNo) {
	if(typeof(pageNoID)=='undefined'){
		$("#pageNo").val(pageNo);
	}else{
		$("#"+pageNoID).val(pageNo);
	}
	pageQuery();
}


/**
 * 通过form进行跳转,把page包含在form中
 * 跳转
 * @param 跳转的页号
 */
function jumpPage2(pageNo) {
	var formEle = $(currEle).parents('form');
	formEle.find('.pageNo').val(pageNo);
	formEle.submit();
}
//记录当前点击的dom元素,通过获取它,得到form
var currEle;
document.onmousedown = function(e) {
	var e = e?e:event
	var d = e.srcElement || e.target;
	currEle = d;
}


/**
 * 跳转（手工输入页码）
 */
function gotoPage(pageNo, totalPage) {
	var gotoPage = $("#goto_page").val();
	
	if(gotoPage.length == 0 || isNaN(gotoPage)) {
		gotoPage = 1;
	} else if(parseInt(gotoPage) > parseInt(totalPage)) {
		gotoPage = totalPage;
	}
	
	$("#goto_page").val(gotoPage);
	
	if(gotoPage != pageNo) {
		jumpPage(gotoPage);
	} else {
		//alert("已经是第 " + pageNo + " 页，无需跳转");
		top.jAlert('warning','已经是第 ' + pageNo + ' 页，无需跳转','消息提示');
	}
}

function changePageSize(){
	var pageSize = $("#page_size_select").val();
	if($("#pageSize").length>0){
		$("#pageSize").val(pageSize);
	}
	jumpPage(1);
}

function returnPaginationHtml(pagination){
	var conHtml="<span class=\"page_bar\">";
	if(pagination.hasPrevPage){
		conHtml+="<span><a href=\"javascript:jumpAjaxPage("+pagination.prevPage+");\">上一页</a></span>";
	}else{
		conHtml+="<span class=\"disable\">上一页</span>";
	}
	if(pagination.hasManyPage){
		for(var i=0;i<pagination.showPageNoList.length;i++){
			var entity=pagination.showPageNoList[i];
			if(entity==pagination.pageNo){
				conHtml+="<span class=\"currentPage\">"+entity+"</span>";
			}else{
				conHtml+="<span><a href=\"javascript:jumpAjaxPage("+entity+")\">"+entity+"</a></span>";
			}
		}
	}
	if(pagination.hasNextPage){
		conHtml+="<span><a href=\"javascript:jumpAjaxPage("+pagination.nextPage+");\">下一页</a></span>";
	}else{
		conHtml+="<span class=\"disable\">下一页</span>";
	}
	conHtml+="</span><div class=\"clear_both\"></div>";
	return conHtml;
	
}
