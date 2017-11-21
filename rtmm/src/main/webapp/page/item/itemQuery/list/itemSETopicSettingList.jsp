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
						<td><div class="t_cols" style="width: 100px;">开始月份</div></td>
						<td><div class="t_cols" style="width: 100px;">结束月份</div></td>
						<td><div class="t_cols" style="width: 280px;">SE主题</div></td>
						<td><div class="t_cols" style="width: 160px;">类型</div></td>
						<td><div class="t_cols" style="width: 180px;">创建日期</div></td>
						<td><div class="t_cols" style="width: 100px;">创建人</div></td>												
						<td><div style="width: 16px;">&nbsp;</div></td>
					</tr>
				</thead>
			</table>
		</div>
		
		<div class="btable_div" style="height: 509px;">
		
		
			<table class="single_tb w100" id='itemSETopic_tab_List'>
				<!--multi_tb为多选 width:1001px;-->
				 <c:forEach   items="${page.result}" var="itemSETopicVO">
				<tr>
					<td class="align_center" style="width: 30px;">
						</td>
					<td style="width: 71px;" align="right">${itemSETopicVO.seId } &nbsp;</td>
					<td style="width: 101px;">${itemSETopicVO.buyBeginMth }/${itemSETopicVO.buyBeginDay }</td>
					<td style="width: 101px;">${itemSETopicVO.buyEndMth }/${itemSETopicVO.buyEndDay }</td>
					<td style="width: 281px;" >${itemSETopicVO.topicName }</td>
					<td style="width: 161px;"><auchan:getDictValue code='${itemSETopicVO.topicType }' mdgroup='ITEM_SE_TOPIC_TOPIC_TYPE' /></td>
					<td style="width: 181px;"><c:if test="${itemSETopicVO.creatDate ne null}"><fmt:formatDate value="${itemSETopicVO.creatDate }" pattern="yyyy-MM-dd"/></c:if> </td>
					<td style="width: 101px;"><auchan:getStuffName value="${itemSETopicVO.creatBy }"/></td>					
					<td style="width: auto">&nbsp;</td>
				</tr>
				</c:forEach>
			</table>
		</div>
     </div>          
          <jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
               