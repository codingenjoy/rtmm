<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<jsp:include page="/page/commons/knockout.jsp" />
<style type="text/css">
.Table_Panel {
	height: 220px;
	overflow: hidden;
}

/*
.Table_Panel td {
	height: 30px;
} */

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
		//根據action判斷標題, 和限制廠編為唯讀
		if ('${action}' == 'UPDATE') {
			$('.Panel_top span').text("修改内部厂商");
			$('.Table_Panel').find('#supNo').attr("readonly", "readonly");
			$('.Table_Panel').find('#supNo').addClass("Black");

			// UPDATE 只能選擇 status 1,2,8
			$('#status option[value=0]').attr("disabled", "disabled");
			$('#status option[value=9]').attr("disabled", "disabled");
		} else {
			// CREATE 只能選擇 status 1,2
			$('#status option[value=0]').attr("disabled", "disabled");
			$('#status option[value=8]').attr("disabled", "disabled");
			$('#status option[value=9]').attr("disabled", "disabled");
		}

	});

	Common = {
		Week : function(value, css) {
			var self = this;
			self.value = ko.observable(value);
			self.css = ko.observable(css);
			self.weekClick = function(obj, event) {
				if (self.css() == 'weekon') {
					self.css('');
					self.value('0');
				} else {
					self.css('weekon');
					self.value('1');
				}
			};
		},
		WeekInfo : function(value) {

			var self = this;
			self.mon = ko.observable(value.substr(0, 1));
			self.monClick = function(obj, event) {
				if (self.mon() == '1') {
					self.mon('0');
				} else {
					self.mon('1');
				}
				self.checkAllComputed(self);
			};
			self.tue = ko.observable(value.substr(1, 1));
			self.tueClick = function(obj, event) {
				if (self.tue() == '1') {
					self.tue('0');
				} else {
					self.tue('1');
				}
				self.checkAllComputed(self);
			};
			self.wed = ko.observable(value.substr(2, 1));
			self.wedClick = function(obj, event) {
				if (self.wed() == '1') {
					self.wed('0');
				} else {
					self.wed('1');
				}
				self.checkAllComputed(self);
			};
			self.thu = ko.observable(value.substr(3, 1));
			self.thuClick = function(obj, event) {
				if (self.thu() == '1') {
					self.thu('0');
				} else {
					self.thu('1');
				}
				self.checkAllComputed(self);
			};
			self.fri = ko.observable(value.substr(4, 1));
			self.friClick = function(obj, event) {
				if (self.fri() == '1') {
					self.fri('0');
				} else {
					self.fri('1');
				}
				self.checkAllComputed(self);
			};
			self.sat = ko.observable(value.substr(5, 1));
			self.satClick = function(obj, event) {
				if (self.sat() == '1') {
					self.sat('0');
				} else {
					self.sat('1');
				}
				self.checkAllComputed(self);
			};
			self.sun = ko.observable(value.substr(6, 1));
			self.sunClick = function(obj, event) {
				if (self.sun() == '1') {
					self.sun('0');
				} else {
					self.sun('1');
				}
				self.checkAllComputed(self);
			};
			self.checkAll = ko.observable(false);
			self.checkAll.subscribe(function(newValue) {
				if (newValue) {
					self.mon('1');
					self.tue('1');
					self.wed('1');
					self.thu('1');
					self.fri('1');
					self.sat('1');
					self.sun('1');
				} else {
					self.mon('0');
					self.tue('0');
					self.wed('0');
					self.thu('0');
					self.fri('0');
					self.sat('0');
					self.sun('0');
				}
				self.checkAllComputed(self);
			});
			self.checkAllComputed = function(self) {

				var s = self.mon() + self.tue() + self.wed() + self.thu()
						+ self.fri() + self.sat() + self.sun();
				if (s == '1111111') {
					self.checkAll(true);
				} else if (s == '0000000') {
					self.checkAll(false);
				} else{
					self.checkAll(false);
					viewModel.dlvrySched(new Common.WeekInfo(s));
				}
			};
			self.toString = function() {

				var s = self.mon() + self.tue() + self.wed() + self.thu()
						+ self.fri() + self.sat() + self.sun();
				return s;
			};
			if (value == '1111111') {
				self.checkAll(true);
			} else {
				self.checkAll(false);
			}

		}
	};

	function ViewModel() {
		var self = this;
		var isValid = true;

		self.action = ko.observable('${action}');
		self.supNo = ko.observable('${intrnSup.supNo}').extend({
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

					//修改時不檢查supNo 是否唯一
					if ('${action}' == "UPDATE") {
						return true;
					}

					$.ajax({
						async : false,
						url : ctx + '/supplier/checkSupNoUnique',
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
		self.intrnSupName = ko.observable("${intrnSup.intrnSupName}").extend({
			required : {
				params : true,
				message : "请设置内部厂商名称"
			},
			maxLength : {
				params : 15,
				message : "内部厂商名称最大长度为15个字符"
			}
		});
		self.supType = ko.observable("${intrnSup.supType}").extend({
			required : {
				params : true,
				message : "请设置内部厂商类型"
			}
		});
		self.status = ko.observable("${intrnSup.status}").extend({
			required : {
				params : true,
				message : "请设置状态"
			}
		});
		self.leadTime = ko.observable("${intrnSup.leadTime}").extend({
			required : {
				parmas : true,
				message : "请设置准备天数"
			},
			number : {
				params : true,
				message : "数字格式"
			},
			maxLength : {
				params : 2,
				message : "最大长度为2位数字"
			}
		});

		//送货行程
		self.dlvrySched = ko.observable(new Common.WeekInfo('${intrnSup.dlvrySched}'
				|| '0000000'));
		self.dlvrySchedStr = ko.computed(function() {
			return self.dlvrySched().toString();
		});
		self.dlvrySched.extend({
			validation : {
				validator : function(obj) {
					if (obj.toString() == '0000000') {
						return false;
					} else {
						return true;
					}
				},
				message : "请设置送货行程"
			}
		});
		self.save = function(form, event) {
			// 验证表单
			viewModel.errors = ko.validation.group(viewModel);
			if (!viewModel.isValid()) {
				viewModel.errors.showAllMessages();
				return;
			}
			// 提交表单
			$.ajax({
				type : "post",
				async : false,
				url : ctx + '/supplier/saveInternalSupplier',
				dataType : "json",
				data : {
					'action' : viewModel.action(),
					'supNo' : viewModel.supNo(),
					'intrnSupName' : viewModel.intrnSupName(),
					'supType' : viewModel.supType(),
					'status' : viewModel.status(),
					'leadTime' : viewModel.leadTime(),
					'dlvryList' : viewModel.dlvrySchedStr()
				},
				success : function(data) {
					if (data == true) {
						top.jAlert('success', '操作成功', '提示消息');
					} else {
						top.jAlert('error', '操作失败', '提示消息');
					}
					closePopupWin();
					pageQuery();
				}
			});
		};

	}
	function saveIntrnSupplier() {
		viewModel.save();
	}

	var viewModel = new ViewModel();
	ko.applyBindings(viewModel);
</script>
<div class="Panel_top">
	<span>创建内部厂商</span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<table class="CM_table">
		<tr>
			<td class="w35"><span>内部厂编</span></td>
			<td><input id="supNo"
				data-bind="value:supNo,validationElement:supNo" type="text"
				class="inputText w35" /></td>
		</tr>
		<tr>
			<td><span>*厂商名称</span></td>
			<td><input
				data-bind="value:intrnSupName,validationElement:intrnSupName"
				type="text" class="inputText w55" maxlength="15" /></td>
		</tr>
		<tr>
			<td class="w35"><span>*<!-- 准备天数 --><auchan:i18n id="102006035"/></span></td>
			<td><input data-bind="value:leadTime,validationElement:leadTime"
				type="text" class="inputText w35" maxlength="2" /></td>
		</tr>
		<tr>
			<td class="w35"><span>*内部厂商类型</span></td>
			<td><auchan:select id="supType" ignoreValue="1,2,3,4,5,6,7,8"
					_class="w35" mdgroup="SUPPLIER_SUP_TYPE" 
					dataBind="value:supType,validationElement:supType"></auchan:select></td>
		</tr>
		<tr>
			<td class="w35"><span>*<!-- 状态 --><auchan:i18n id="102006004"/></span></td>
			<td><auchan:select id="status" _class="w35"
					mdgroup="SUPPLIER_STATUS" 
					dataBind="value:status,validationElement:status"></auchan:select></td>
		</tr>
	</table>
	<div class="schedule">
		<div style="height: 25px;">
			<div class="wtitle">&nbsp;</div>
			<div class="week week20">
				<div>一</div>
				<div>二</div>
				<div>三</div>
				<div>四</div>
				<div>五</div>
				<div>六</div>
				<div>日</div>
			</div>
		</div>
		<div
			style="height: 1px; background: #999999; overflow: hidden; width: 85%;"></div>
		<div style="height: 25px;">
			<div class="wtitle">
				<span>*<!-- 送货行程 --><auchan:i18n id="102006036"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</div>
			<div class="week week21" data-bind="validationElement:dlvrySched">
				<div
					data-bind="event:{click:dlvrySched().monClick},css:dlvrySched().mon()=='1'?'weekon':''"></div>
				<div
					data-bind="event:{click:dlvrySched().tueClick},css:dlvrySched().tue()=='1'?'weekon':''"></div>
				<div
					data-bind="event:{click:dlvrySched().wedClick},css:dlvrySched().wed()=='1'?'weekon':''"></div>
				<div
					data-bind="event:{click:dlvrySched().thuClick},css:dlvrySched().thu()=='1'?'weekon':''"></div>
				<div
					data-bind="event:{click:dlvrySched().friClick},css:dlvrySched().fri()=='1'?'weekon':''"></div>
				<div
					data-bind="event:{click:dlvrySched().satClick},css:dlvrySched().sat()=='1'?'weekon':''"></div>
				<div
					data-bind="event:{click:dlvrySched().sunClick},css:dlvrySched().sun()=='1'?'weekon':''"></div>
			</div>
			<input type="checkbox"
				data-bind="checked:dlvrySched().checkAll,event:{click:dlvrySched().checkAllClick}"
				style="margin-top: 7px;">
		</div>
	</div>
</div>

<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="saveIntrnSupplier()">保存</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>
