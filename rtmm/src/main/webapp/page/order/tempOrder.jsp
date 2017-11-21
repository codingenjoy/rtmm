<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div id="validArea"></div>
<div id="invalidArea" style="display: none;"></div>
<script type="text/javascript">
	// 導入正確 valid 的翻頁
	function pageQuery(processId) {
		if ($(':visible .errorInput').length > 0) {
			top.jWarningAlert('请修正标红栏位');
			return;
		}
		var formData;
		if (processId) {
			formData = {
				'processId' : processId,
				'pageNo' : 1,
				'pageSize' : 100
			};
		} else {
			formData = $('#orderForm').serialize();
		}

		$.post(ctx + '/order/getTempOrderValidPage', formData, function(data) {
			$('#validArea').html(data);
			totalCount();
			// 如果有導入正確的, 就可以進行下一步
			if ($('#validArea').find('#successCount:first').val() > 0) {
				$("#Tools2").attr("class", "Tools2").unbind().bind("click",
						function() {
							saveImportOrder();
						});
			} else {
				$("#Tools2").attr("class", "Tools2_disable").off();
			}
		}, 'html');
		$('#displayDiv').find('.item22').removeClass('item_on');
		$($('#displayDiv').find('.item22')[1]).addClass('item_on');
	}

	// 導入錯誤 invalid 的翻頁
	function pageQuery1(processId) {
		var formData;
		if (processId) {
			formData = {
				'processId' : processId,
				'pageNo' : 1,
				'pageSize' : 100
			};
		} else {
			$("#orderInvalidForm input[name=errorCode]").val(
					$("#errorCode").val());
			formData = $("#orderInvalidForm").serialize();
		}
		$.post(ctx + '/order/getTempOrderInvalidPage', formData,
				function(data) {
					$('#invalidArea').html(data);
					totalCount();
				}, 'html');
	}

	function totalCount() {
		var failCount = $('#invalidArea').find('#failCount:first').val();
		var sucCount = $('#validArea').find('#successCount:first').val();
		if (isNaN(failCount)) {
			failCount = 0;
		}
		if (isNaN(sucCount)) {
			sucCount = 0;
		}
		$('#totalCount')
				.attr('value', parseInt(sucCount) + parseInt(failCount));
	}

	function search1() {
		$('#pageNo1').val(1);
		pageQuery1('${processId}');
	}

	function search() {
		pageQuery('${processId}');
	}

	search();
	search1();
</script>