<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<jsp:include page="/page/commons/knockout.jsp" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/combo.css" rel="Stylesheet" />


<style type="text/css">
.Table_Panel {
	height: 155px;
	overflow: hidden;
}

.schedule {
	width: 272px;
	height: 80px;
	margin-left: 110px;
}

.schedule div {
	height: 25px;
}

.schedule .icondiv2 {
	margin: 6px auto auto 2px;
	cursor: pointer;
}

.week {
	width: 50%;
	float: left;
}

.week div {
	height: 15px;
	width: 15px;
	float: left;
	margin: 5px auto auto 2px;
	cursor: pointer;
}

.week21 div:hover {
	background: #a5d7d7;
}

.week20 div {
	border: 1px solid #F9F9F9;
}

.week21 div {
	border: #999999 solid 1px;
}

.wtitle {
	width: 35%;
	float: left;
	line-height: 28px;
	text-align: right;
}
</style>
<script type="text/javascript">
	$(function() {

		disableCheckStart = false;
		disableCheckEnd  = false;
		
		//取得配送中心的清單
		StoreListSearch2('${dcSup.storeNo}');

		//根據action 來判斷標題, 限制廠編, 配送中心為唯讀
		if ('${action}' == 'UPDATE') {
			$('.Panel_top span').text("修改DC厂商");
			$('#supNo').attr("readonly", "readonly");
			$('#supNo').addClass("Black");
			
			// 如果廠商已經啟用了, 就不能修改起始日期 
			if ( '${dcSup.applyStartDateFrom}' <= new Date().format('yyyy-MM-dd')){
				$('#applyStartDate').attr("readonly","readonly");
				$('#applyStartDate').removeClass("Wdate").addClass("inputText Black").removeAttr("onclick");
				disableCheckStart = true;
			}
			
			// 如果廠商已經過期了, 也不能修改截止日期 
			if ( '${dcSup.applyStartDateEnd}' != '' && '${dcSup.applyStartDateEnd}' <= new Date().format('yyyy-MM-dd')){
				$('#applyEndDate').attr("readonly","readonly");
				$('#applyEndDate').removeClass("Wdate").addClass("inputText Black").removeAttr("onclick");
				disableCheckEnd = true;
			}
			
		}
		
	});

	function ViewModel() {
		var self = this;
		var isValid = true;
		var lockSttus;
		if ( '${action}' == 'UPDATE'){
			lockSttus = '${dcSup.lockSttus}';
		}else{
			lockSttus = 0;
		}
		self.action = ko.observable("${action}");
		self.supNo = ko.observable("${dcSup.supNo}").extend({
			number : {
				params : true,
				message : "数字格式"
			},
			maxLength : {
				params : 8,
				message : "最大长度为8位数字"
			},
			validation : {
				validator : function(val, param) {
					// 修改資料則不檢查supNo 是否唯一
					if ('${action}' == "UPDATE") {
						return true;
					}
					$.ajax({
						async : false,
						url : ctx + '/supplier/checkDCSupNoUnique',
						type : 'POST',
						data : {
							'supNo' : val
						},
						success : function(response) {
							isValid = (response != true);
						},
						error : function() {
							isValid = false;
						}
					});
					return isValid;
				},
				message : '该厂编已经存在',

			}
		});

		self.applyStartDate = ko.observable('${dcSup.applyStartDateFrom}').extend({
			required : {
				parmas : true,
				message : "请设置启用日期"
			},
			validation : {
				validator : function (val, param){
					if (viewModel == 'undefined' || disableCheckStart ){
						return true;
					}
					return ( val > (new Date().format('yyyy-MM-dd')) );
				},
				message : "启用日期必须大于今天"
			}
		});

		self.applyEndDate = ko.observable('${dcSup.applyStartDateEnd}').extend({
			validation : {
				validator : function(val, param) {
					if (viewModel == 'undefined' || val == '' || disableCheckEnd) {
						return true;
					}
					return ( (val > (new Date().format('yyyy-MM-dd'))) && (val > self.applyStartDate()));
				},
				message : "截止日期必須必须大于今天, 且晚於启用日期"
			}
		});

		self.lockSttus = ko.observable(lockSttus).extend({
			required : {
				parmas : true,
				message : "请设置状态"
			}
		});

		ko.validation.registerExtenders();
		self.save = function(form, event) {

			// 驗證是否有選擇配送中心
			var flag = $("#storeNo ~ span > input").val() == "请选择";
			// 验证表单
			viewModel.errors = ko.validation.group(viewModel);
			if (!viewModel.isValid() || flag) {
				if (flag) {
					$("#storeNo ~ span > input").addClass("errorInput");
					$("#storeNo ~ span > input").attr("title", "请设置配送中心");
				}
				viewModel.errors.showAllMessages();
				return;
			}

			// 提交表单
			$.ajax({
				type : "post",
				async : false,
				url : ctx + '/supplier/saveDCSupplier',
				dataType : "json",
				data : {
					'action' : '${action}',
					'supNo' : viewModel.supNo(),
					'storeNo' : $("#storeNo").combobox("getValue"),
					'applyStartDate' : viewModel.applyStartDate(),
					'applyEndDate' : viewModel.applyEndDate(),
					'lockSttus' : viewModel.lockSttus()
				},
				success : function(data) {
					if (data == true) {
						top.jAlert('success', '操作成功','提示消息');
					} else {
						top.jAlert('error', '操作失败','提示消息');
					}
					closePopupWin();
					pageQuery();
				}
			});
		};

	}
	function saveDCSupplier() {
		viewModel.save();
	}
	var viewModel = new ViewModel();
	ko.applyBindings(viewModel);
</script>
<div class="Panel_top">
	<span>创建DC厂商</span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<table class="CM_table">
		<tr>
			<td class="w35"><span>DC厂商</span></td>
			<td><input id="supNo" data-bind="value:supNo,validationElement:supNo" type="text" class="inputText w35" /></td>
		</tr>
		<tr>
			<td><span>*配送中心</span></td>
			<td><input id="storeNo" value="" data-options="editable:false,panelHeight:'auto'" /></td>
		</tr>
		<tr>
			<td><span>*启用日期</span></td>

			<td><input id="applyStartDate" class="Wdate w35" data-bind="value:applyStartDate,validationElement:applyStartDate" type="text"
				onclick="WdatePicker({onpicked:function(){$(this).trigger('change');},onclearing:function(){$(this).attr('value','').trigger('change');},isShowClear:false,readOnly:true})" ></td>
		</tr>
		<tr>
			<td><span>截止日期</span></td>

			<td><input id="applyEndDate" class="Wdate w35" data-bind="value:applyEndDate,validationElement:applyEndDate" type="text"
				onclick="WdatePicker({onpicked:function(){$(this).trigger('change');},onclearing:function(){$(this).attr('value','').trigger('change');},isShowClear:false,readOnly:true})" ></td>
		</tr>
		<tr>
			<td class="w35"><span>*<!-- 状态 --><auchan:i18n id="102006004"/></span></td>
			<td><auchan:select mdgroup="SUP_DC_CTRL_LOCK_STTUS" _class="select1 w35 Black" 
					dataBind="value:lockSttus,validationElement:lockSttus" disabled="disabled"/></td>
		</tr>

	</table>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="saveDCSupplier()">保存</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>
