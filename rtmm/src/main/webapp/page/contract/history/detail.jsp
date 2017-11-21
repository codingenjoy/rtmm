<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/contract/detail_top.jsp"%>
<%@ include file="/page/contract/history/detail_basic.jsp"%>
<%@ include file="/page/contract/history/detail_tab.jsp"%>
<div class="detailGrpAccount">
	<%@ include file="/page/contract/history/detail_grp_account.jsp"%>
</div>
<script type="text/javascript">
	
	inputToInputIntNumber();
	enableDetailViewIcon();
	// 查到資料
	if ('${flag}' != "noDataFound" && '${currentPage}' != "" ){
		disableSearch();
		$($('#detailViewCon .detail .gyBlock').find('span')[0]).trigger('click');
	}
	else if ('${flag}' == "noDataFound"){
		top.jAlert("warning","没有找到对应的数据讯息", "消息提示");
		$("#detailViewCon .search input").val('');
	}
	
	$("#Tools6").removeClass('Tools6_disable').addClass('Tools6').off('click').on('click',function() {
		doGeneralSearch(1);
	});

	
	var page = '';
	if('${currentPage}'){
		disableSearch();
		page = parseInt('${currentPage}');
	}
	var totalCount = '';
	if('${totalCount}'){
		totalCount = parseInt('${totalCount}');
	}
	
	//上一页
	if(page != '1' && page != ''){
		$("#Tools17").removeClass('Tools17_disable').addClass('Tools17').off('click').on('click',function() {
			doGeneralSearch(parseInt(page)-1);
		});
	}else{
		$("#Tools17").addClass('Tools17_disable').off('click');
	}
	
	//下一页
	if(page != totalCount){
		$("#Tools19").removeClass('Tools19_disable').addClass('Tools19').off('click').on('click',function() {
			doGeneralSearch(parseInt(page)+1);
		});
	}else{
		$("#Tools19").addClass('Tools19_disable').off('click');
	}
	
	//最后一页
	if(page != totalCount && totalCount > page){
		$("#Tools18").removeClass('Tools18_disable').addClass('Tools18').off('click').on('click',function() {
			doGeneralSearch(totalCount);
		});
	}else{
		$("#Tools18").addClass('Tools18_disable').off('click');
	}
	
	//第一页
	if(page != '1' && page !='' ){
		$("#Tools16").removeClass('Tools16_disable').addClass('Tools16').off('click').on('click',function() {
			doGeneralSearch(1);
		});
	}else{
		$("#Tools16").addClass('Tools16_disable').off('click');
	}
	
	
	function doGeneralSearch(pageNo){
		if ($("#detailViewCon #searchForm #cntrtId").val()=='输入合同编号'){
			$("#detailViewCon #searchForm #cntrtId").val('');
		}
		if ($("#detailViewCon #searchForm #supNo").val()=='输入厂编'){
			$("#detailViewCon #searchForm #supNo").val('');
		}
		if ($("#detailViewCon #searchForm #year").val()=='输入年份'){
			$("#detailViewCon #searchForm #year").val('');
		}
		var param = $("#detailViewCon #searchForm").serialize();
		$.post(ctx + '/supplier/contract/history/search?pageNo='+pageNo, param, function(data) {
			$('#detailViewCon .detail').html(data);
		}, 'html');
	}
	
</script>
