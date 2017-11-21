<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.paging .page_list {
	width: 380px;
}
</style>
<script type="text/javascript">
var supNo="";//厂商编号
var supName="";//厂商名称
$(".addSingleSup").unbind().bind('dblclick',function(){
	var confirm=$("#popupWin").find("#confirm");
	$(confirm).click();
});

//双击事件
$("#supInfoList tr").unbind("dblclick click").bind("dblclick click",function(){
	supNo=$(this).find("[name=supNo]").val();
	supName=$(this).find("#sup_supName").text();
});


//回调信息
function readSupInfo(methodName){     
   if(supNo!="" && supName!=""){
	methodName(supNo,supName);	      
	   }     
}



</script>
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols" style="width: 30px;"></div></td>
				<td><div class="t_cols" style="width: 80px;">厂编</div></td>
				<td><div class="t_cols" style="width: 415px;">公司名称</div></td>
				<td><div class="t_cols" style="width: 160px;">状态</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 320px;">
	<table class="single_tb" id="supInfoList">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="sup">
				<tr id="supInfo_${sup.supNo}_${sup.comName}">
					<td><div class="t_cols"
							style="width: 30px; border-right: 0px !important; text-align: center;">
							<!-- 	<input type="checkbox" name="supChk"> -->
						</div></td>
					<td><div class="t_cols addSingleSup"
							style="width: 80px; text-align: right; border-right: 0px !important;">${sup.supNo}&nbsp;&nbsp;</div>
						<input type="hidden" name="supNo" value="${sup.supNo}"></td>
					<td><div class="t_cols addSingleSup" id="sup_supName"
							style="width: 415px; border-right: 0px !important;">
							<c:out value="${sup.comName }" />
						</div> <input type="hidden" name="supName" value="${sup.comName}">
					</td>

					<td><div class="t_cols addSingleSup"
							style="width: 160px; border-right: 0px !important;">
							<auchan:getDictValue mdgroup="SUPPLIER_STATUS"
								code="${sup.status}"></auchan:getDictValue>
						</div> <input type="hidden" name="status" value="${sup.status}">
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>