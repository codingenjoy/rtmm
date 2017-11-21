<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ include file="/page/commons/taglibs.jsp"%>
 <style type="text/css">
        .align_right {
            padding-right:10px;
        }
</style>
<div class="htable_div">
    <table>
        <thead>
        <tr>
            <td><div class="t_cols align_center" style="width:30px;">&nbsp;</div></td>
            <td><div class="t_cols" style="width:100px;">计划号</div></td>
            <td><div class="t_cols" style="width:120px;">主题</div></td>
            <td><div class="t_cols" style="width:100px;">物流中心</div></td>
            <td><div class="t_cols" style="width:100px;">DM</div></td>
            <td><div class="t_cols" style="width:120px;">课别</div></td>
            <td><div class="t_cols" style="width:120px;">开始日期</div></td>
            
            <td><div class="t_cols" style="width:120px;">结束日期</div></td>
            <td><div class="t_cols" style="width:160px;">门店确认期间</div></td>
            <td><div class="t_cols" style="width:170px;">门店补货期间</div></td>

            <td><div class="t_cols" style="width:110px;">总金额</div></td>
            <td><div style="width:16px;">&nbsp;</div></td>
        </tr>
    </thead>
 </table>
</div>
<div class="btable_div" style="height:509px;">
    <table class="single_tb w100"><!--multi_tb为多选 width:1001px;-->
        <tbody>
        	<c:if test="${not empty page.result}">
        		<c:forEach items="${page.result}" var="rp" varStatus="rpindex">
			        <tr planId="${ rp.rpNo}" num="${rpindex.index + 1}" onclick="doChangeDetailIcon(this)" ondblclick="toDetailPage(this)">
			            <td class="align_center" style="width:30px;">&nbsp;</td>
			            <td style="width:101px;">${rp.rpNo}</td>
			            <td style="width:121px;">${rp.rdmTopic}</td>	
			            <td style="width:101px;">${rp.dcStoreNo}-${rp.dcStoreName}</td>
			            <td style="width:101px;">${rp.rdmNo}</td>
			            <td style="width:121px;">${rp.catlgId}-${rp.catlgName }</td>
			            <td style="width:121px;"><fmt:formatDate pattern='yyyy-MM-dd' value='${rp.rdmBeginDate}' /></td>
			            <td style="width:131px;"><fmt:formatDate pattern='yyyy-MM-dd' value='${rp.rdmEndDate }' /></td>
			            <td style="width:161px;"><fmt:formatDate pattern='yyyy-MM-dd' value='${rp.stRepBeginDate}' />/<fmt:formatDate pattern='yyyy-MM-dd' value='${rp.stRepEndDate}' /></td>
			            <td style="width:141px;"><fmt:formatDate pattern='yyyy-MM-dd' value='${rp.stCnfrmBeginDate}' />/<fmt:formatDate pattern='yyyy-MM-dd' value='${rp.stCnfrmEndDate}' /></td>
			            <td style="width:101px;" class="align_right">${rp.finalAmnt}</td>
			            <td style="width:auto">&nbsp;</td>
			        </tr>
		        </c:forEach>
	        </c:if>
	    </tbody>
    </table>    
</div>
<div class="paging" id="currentContract"></div>
<input type="hidden" id="detailPageSize" value="${page.pageSize}"/>
<input type="hidden" id="detailPageNo" value="${page.pageNo}"/>
<%@ include file="/page/commons/paginator.jsp"%>
<script type="text/javascript">
	var p = new Paginator({
		totalItems:'${page.totalCount}',
		itemsPerPage:'${page.pageSize}',
		page:'${page.pageNo}',
		paginatorElem:'currentContract',
		callback:function(pageNo,pageSize){
			showListPage(pageNo,pageSize);
		}
	});
	$(window).unload(function() {
		//0.清理资源;
		p.destroy();
	});

	$(function(){
		$(".btable_div").scroll(function () {
		    var left = $(this).scrollLeft();
		    //alert(left);
		    $(".htable_div").scrollLeft(left);
		});
 		$("#plan_div").keydown(function(e){ 
			if(e.keyCode == 13){
				showListPage();
			}
		});
 		
/* 		document.onkeydown = function(e) {
			enterShow(e) ;
		}; */

	});
	
</script>

                