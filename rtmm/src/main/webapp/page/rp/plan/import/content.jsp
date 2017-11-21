<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<div id="validContent">
	<%@ include file="valid.jsp"%>
</div>
<div id="invalidContent" style="display: none;">
	<%@ include file="invalid.jsp"%>
</div>

<script type="text/javascript">
	if ('${processId}' != '') {
		$("#totalCount").val('${totalCount}');
		search();
		search1();
	}

	//導入正確 valid 的翻頁
	function validRpQuery(processId) {
		// need to change this part!!!
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
			// 更新每頁顯示筆數到 $('#orderForm')裡
			formData = $('#validForm').serialize();
		}

		$.post(ctx + '/rp/plan/getTempRpValidPage', formData, function(data) {
			$('#validRecord').html(data);
			// 如果有導入正確的, 就可以進行下一步
			//绑定保留计划列表的toolbar时间
			initEnventForRpImport();
			if ($('#validBasicInfo').find('#successCount:first').val() > 0) {
				$("#Tools2").attr("class", "Tools2");
			}
		}, 'html');

		$('#displayDiv').find('.item22').removeClass('item_on');
		$($('#displayDiv').find('.item22')[1]).addClass('item_on');
	}

	// 導入錯誤 invalid 的翻頁
	function invalidRpQuery(processId) {
		var formData;
		if (processId) {
			formData = {
				'processId' : processId,
				'pageNo' : 1,
				'pageSize' : 100
			};
		} else {
			// errorCode 更新
			$("#invalidForm input[name=errorCode]").val($("#errorCode").val());
			formData = $("#invalidForm").serialize();
		}
		$.post(ctx + '/rp/plan/getTempRpInvalidPage', formData, function(data) {
			$('#invalidContent').html(data);
		}, 'html');

	}
	// search for valid records
	function search() {
		validRpQuery('${processId}');
	}

	// search for invalid records
	function search1() {
		$('#pageNo1').val(1);
		invalidRpQuery('${processId}');
	}
</script>