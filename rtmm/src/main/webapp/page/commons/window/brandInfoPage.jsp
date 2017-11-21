<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<script type="text/javascript">
$('.brand_tr').die().live("dblclick",function(){
	selectBrand($(this));
});

function selectBrand(obj){
	var brandid = $(obj).attr('brandId');
	var brandnm = $(obj).attr('brandName');
	
 	$('#brandId').attr('value',brandid);
 	$('#brandId').removeClass('errorInput');
	$('#brandName').attr('value',brandnm); 
	closePopupWin();
}

$(function(){
	if($('#brandId').val()!=''){
		$('.brand_tr[brandId="'+$('#brandId').val()+'"]').addClass('btable_checked');
	}
	
	$('#brandNameInput').keydown(function (e) {
        if (e.keyCode == 13) {
        	pageQuery();
        }
    });
});
</script>

<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<input type="hidden" name="pageSize" id="pageSize"
	value="${page.pageSize }" />

<div class="">
	<div class="search_tb_p">
		<div class="htable_div">
			<table>
             <thead>
                 <tr>
					<td><div class="t_cols align_center" style="width:60px;">品牌ID</div></td>
					<td><div class="t_cols" style="width:290px;">品牌名称</div></td>
					<td><div class="t_cols" style="width:290px;">品牌英文名称</div></td>
					<td><div style="width:16px;">&nbsp;</div></td>
				 </tr>
			  </thead>
  	 		</table>
         </div>
	 	<div class="btable_div" style="height:280px;">
           <table  class="single_tb w100"><!--multi_tb为多选 width:1001px;-->
			<c:forEach items="${page.result }" var="item_brand">
				<tr class='brand_tr' brandId="${item_brand.brandId}" brandName="${item_brand.brandName}" brandEnName="${item_brand.brandEnName}">
					<td style="text-align:right;width:60px;">${item_brand.brandId}&nbsp;&nbsp;</td>
					<td align="left" style="width:269px;padding-left:5px;">${item_brand.brandName}</td>
					<td align="left" style="width:290px;padding-left:5px;">${item_brand.brandEnName}</td>
					<td><div style="width:16px;padding-left:5px;">&nbsp;</div></td>
				</tr>
			</c:forEach>
		</table>    
	</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
	<div class="PanelBtn">
		<div onclick="selectBrand($('tr.btable_checked'))" class="PanelBtn1">确定</div>
		<div onclick="closePopupWin()" class="PanelBtn2">取消</div>
	</div>
</div>
</div>

