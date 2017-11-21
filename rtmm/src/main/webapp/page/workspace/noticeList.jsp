<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="${ctx}/shared/js/jumpPage.js" type="text/javascript"></script>
<script>

	
	function pageQuery(noticeId) {
		var pageNo = $('#pageNo').val();
		var pageSize = $('#pageSize').val();
		$.ajax({
			type : "post",
			async: false,
			data : {
				pageNo : pageNo,
				pageSize : pageSize
			},
			dataType : "html",
			url : ctx + "/workspace/getNoticeListByPage",
			success : function(data) {
				$('#notice_content').html(data);
			}
		});
		if (noticeId != 'undefined' && noticeId != '') {
			displayOneNotice(noticeId);
		} 
	}

	function displayOneNotice(noticeId) {
		var position = $("#N" + noticeId).position().top - 150;
		$('.notice').animate({
			scrollTop : position
		}, 600);
	};

	$(function() {
		$(".r_btn_hide").live('click', function() {
			$(this).text("展开");
			$(this).attr('id', 'toShow');
			$(this).attr('class', 'f_r r_btn_show');
			$(this).parent().next().hide();
		});

		$(".r_btn_show").live('click', function() {
			$(this).text("缩小");
			$(this).attr('id', 'toHide');
			$(this).attr('class', 'f_r r_btn_hide');
			$(this).parent().next().show();
		});
		
		var noticeId = '${noticeId}';
		
		pageQuery(noticeId);
	});
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">公告信息</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1" id="noticeListDiv">
	<div class="Content" id="notice_content"></div>
</div>
