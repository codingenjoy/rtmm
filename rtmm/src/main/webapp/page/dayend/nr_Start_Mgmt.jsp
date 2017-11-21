<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/catalog/catalog.js" type="text/javascript"></script>
<script type="text/javascript">
//点亮查询
var lastTabObj;
$("#barcode").attr("readonly",false);
$("#itemNo").attr("readonly",false);
$("#ovreviewList").hide();
$('#ovreviewList').load(ctx + '/item/query/itemBaseList');
showDivision();
/* $('.ToolBar').find('td[id]').each(
		function(){
			var thisId = this.attr('id');
			if((this.hasClass(thisId))){
				this.removeClass(thisId).addClass(thisId+"_disable");
			}
		}
); */
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div id="ovreviewList">
	<%@ include file="/page/item/itemQuery/item_overview_list.jsp"%>
</div>
<div id="ovreviewContent">
	<%@ include file="/page/item/itemQuery/itemOverview.jsp"%>
</div>
