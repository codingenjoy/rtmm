<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
//滚动条事件
$(document).ready(function () {
    $(".btable_div").scroll(function () {
        var left = $(this).scrollLeft();
        $(".htable_div").scrollLeft(left);
    });
});

</script>


<!-- 分页属性 -->
 <input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
 <div>
 <div class="htable_div">
			<table>
				<thead>
					<tr>
						<td><div class="t_cols align_center" style="width: 30px;">
							</div></td>
						<td><div class="t_cols" style="width: 70px;">SE期数</div></td>
						<td><div class="t_cols" style="width: 100px;">课别</div></td>
						<td><div class="t_cols" style="width: 100px;">大分类</div></td>
						<td><div class="t_cols" style="width: 100px;">中分类</div></td>
						<td><div class="t_cols" style="width: 100px;">小分类</div></td>
						<td><div class="t_cols" style="width: 150px;">货号</div></td>
						<td><div class="t_cols" style="width: 100px;">状态</div></td>	
						<td><div class="t_cols" style="width: 100px;">厂编</div></td>																		
						<td><div class="t_cols" style="width: 100px;">进价</div></td>												
						<td><div class="t_cols" style="width: 100px;">售价</div></td>																		
																	
						<td><div style="width: 16px;">&nbsp;</div></td>
					</tr>
				</thead>
			</table>
		</div>
		
		<div class="btable_div" style="height: 509px;">
		
		
			<table class="single_tb w100" id='itemSETopic_tab_List'>
				<!--multi_tb为多选 width:1001px;-->
				 <c:forEach   items="${page.result}" var="itemSEDetailVO">
				<tr >
					<td class="align_center" style="width: 30px;">
						</td>
					<td style="width: 71px;" align="right">${itemSEDetailVO.seId }</td>
					<td style="width: 101px;"title="${itemSEDetailVO.secNo }-${itemSEDetailVO.secName }"> &nbsp;${itemSEDetailVO.secNo }-${itemSEDetailVO.secName }</td>
					<td style="width: 101px;"title="${itemSEDetailVO.grpNo }-${itemSEDetailVO.grpName }">${itemSEDetailVO.grpNo }-${itemSEDetailVO.grpName }</td>
					<td style="width: 101px;"title="${itemSEDetailVO.midgrpNo }-${itemSEDetailVO.midgrpName }">${itemSEDetailVO.midgrpNo }-${itemSEDetailVO.midgrpName }</td>
					<td style="width: 101px;"title="${itemSEDetailVO.catlgNo }-${itemSEDetailVO.catlgName }">${itemSEDetailVO.catlgNo }-${itemSEDetailVO.catlgName }</td>
					<td style="width: 151px;" title="${itemSEDetailVO.itemNo }-${itemSEDetailVO.itemName }">${itemSEDetailVO.itemNo }-${itemSEDetailVO.itemName }</td>
					<td style="width: 101px;"><auchan:getDictValue code='${itemSEDetailVO.status }' mdgroup='ITEM_STORE_INFO_STATUS' /></td>
					<td style="width: 101px;" align="right">${itemSEDetailVO.supNo } &nbsp;</td>
					<td style="width: 101px;" align="right">${itemSEDetailVO.stdBuyPrice } &nbsp;</td>
					<td style="width: 101px;" align="right">${itemSEDetailVO.stdSellPrice } &nbsp;</td>					
					<td style="width: auto">&nbsp;</td>
				</tr>
				</c:forEach>
			</table>
		</div>
     </div>          
          <jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
               