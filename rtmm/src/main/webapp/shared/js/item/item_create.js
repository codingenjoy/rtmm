$.fn.serializeObject = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || null);
		} else {
			o[this.name] = this.value || null;
		}
	});
	return o;
};

/** 输入整数值 */
function inputToInputIntNumber() {
	$("input.count_text").each(function() {
		$(this).keyup(function() {
			if ($(this).val() != '' && !(/^\d+$/).test($(this).val())) {
				if ($(this).val() == ' ') {
					$(this).val('');
					return false;
				}
				if ($(this).val() != '') {
					$(this).val($(this).attr('preval'));
				}
				return true;
			}
		$(this).attr('preval', $(this).val());
		});
		$(this).blur(function(){
			if ($(this).val() != '' && !(/^\d+$/).test($(this).val())) {
				if ($(this).val() == ' ') {
					$(this).val('');
					return false;
				}
				if ($(this).val() != '') {
					$(this).val($(this).attr('preval'));
				}
				return true;
			}
		});
	});
}
/** 输入小数值 double_text */
function inputToInputDoubleNumber() {
	$("input.double_text").each(function(){
		$(this).keyup(function() {
			if ($(this).val() != '' && !(/^\d+[.]{0,1}\d*$/).test($(this).val())) {
				if ($(this).val() == ' ') {
					$(this).val('');
					return false;
				}
				if ($(this).val() != '') {
					$(this).val($(this).attr('preval'));
				}
				return true;
			}
			$(this).attr('preval', $(this).val());
		});
		$(this).blur(function() {
			if ($(this).val() != '' && !(/^\d+[.]{0,1}\d*$/).test($(this).val())) {
				if ($(this).val() == ' ') {
					$(this).val('');
					return false;
				}
				if ($(this).val() != '') {
					$(this).val($(this).attr('preval'));
				}
				return true;
			}
			$(this).attr('preval', $(this).val());
		});
	});
}

function getCatalogSelect(obj, url) {
	$.post(ctx + url + $('#' + obj.attr('id') + '2').val(), function(data) {
		loadSelectDiv(obj, type);
	});
}

/** select框选择后刷新下级select框 */
function chubieInputSelect(url) {
	$("#chubieInput").unautocomplete().autocomplete(url, {
		minChars : 0,
		width : $(this).attr('width'),
		max : 3000,
		matchContains : true,
		matchCase : false,// 不区分大小写
		autoFill : false,
		dataType : 'json',
		formatItem : function(row, i, max) {
			return row.catlgId + "-" + row.catlgName;
		},
		formatMatch : function(row, i, max) {
			return row.catlgId + "-" + row.catlgName;
		},
		formatResult : function(row) {
			return row.catlgId + "-" + row.catlgName;
		}

	}).result(
			function(event, data, formatted) { // 回调
				var thisValue = data.catlgId + "-" + data.catlgName;
				$(this).val(thisValue);
				$("#chubieInput2").val(data.catlgId);
				$(this).removeClass('errorInput');
				var prevValue = $(this).attr('prevValue');
				$(this).attr('prevValue', data.catlgId + "-" + data.catlgName);
				if ($.trim(prevValue) == '' || prevValue != thisValue) {
					// $.post(ctx +
					// $('#kebieInput').attr('currurl')+data.id,function(data){
					var ccurl = ctx + $('#kebieInput').attr('currurl')+ data.catlgId;
					$('#kebieInput,#dafenleiInput,#zhongfenleiInput')
							.removeAttr('prevvalue');
					$('#kebieInput').flushCache();
					$('#dafenleiInput').flushCache();
					$('#zhongfenleiInput').flushCache();
					$('#xiaofenleiInput').flushCache();
					$('#kebieInput').unautocomplete();
					$('#dafenleiInput').unautocomplete();
					$('#zhongfenleiInput').unautocomplete();
					$('#xiaofenleiInput').unautocomplete();
					$('#kebieInput').val('');
					$('#dafenleiInput').val('');
					$('#zhongfenleiInput').val('');
					$('#xiaofenleiInput').val('');
					$('#kebieInput2').val('');
					$('#dafenleiInput2').val('');
					$('#zhongfenleiInput2').val('');
					$('#xiaofenleiInput2').val('');
					$('#clstrdisplay').val('');
					kebieInputSelect(ccurl);
					// });
				}
				setCatlgWarn($('#xiaofenleiInput2').val());
			});
}
function kebieInputSelect(url) {
	$("#kebieInput").unautocomplete().autocomplete(url, {
		minChars : 0,
		width : $('#kebieInput').attr('acWidth'),
		max : 3000,
		matchContains : true,
		matchCase : false,// 不区分大小写
		autoFill : false,
		dataType : 'json',
		formatItem : function(row, i, max) {
			return row.catlgId + "-" + row.catlgName;
		},
		formatMatch : function(row, i, max) {
			return row.catlgId + "-" + row.catlgName;
		},
		formatResult : function(row) {
			return row.catlgId + "-" + row.catlgName;
		}

	}).result(
			function(event, data, formatted) { // 回调
				$(this).val(data.catlgId + "-" + data.catlgName);
				var thisValue = data.catlgId + "-" + data.catlgName;
				// $("#kebieInput").val(thisValue);
				$("#kebieInput2").val(data.catlgId);
				$(this).removeClass('errorInput');
				var prevValue = $(this).attr('prevValue');
				$(this).attr('prevValue', data.catlgId + "-" + data.catlgName);
				if ($.trim(prevValue) == '' || prevValue != thisValue) {
					// $.post(ctx +
					// $('#dafenleiInput').attr('currurl')+data.catlgId,function(data){
					var ccurl = ctx + $('#dafenleiInput').attr('currurl')
							+ data.catlgId;
					$('#clstrdisplay').val('');
					$('#dafenleiInput,#zhongfenleiInput').removeAttr(
							'prevvalue');
					$('#dafenleiInput').flushCache();
					$('#zhongfenleiInput').flushCache();
					$('#xiaofenleiInput').flushCache();
					$('#dafenleiInput').unautocomplete();
					$('#zhongfenleiInput').unautocomplete();
					$('#xiaofenleiInput').unautocomplete();
					$('#dafenleiInput').val('');
					$('#zhongfenleiInput').val('');
					$('#xiaofenleiInput').val('');
					$('#dafenleiInput2').val('');
					$('#zhongfenleiInput2').val('');
					$('#xiaofenleiInput2').val('');
					dafenleiInputSelect(ccurl);
					// });
				}
				setCatlgWarn($('#xiaofenleiInput2').val());
			});
}
function dafenleiInputSelect(url) {
	$("#dafenleiInput").unautocomplete().autocomplete(url, {
		minChars : 0,
		width : $(this).attr('width'),
		max : 3000,
		matchContains : true,
		matchCase : false,// 不区分大小写
		autoFill : false,
		dataType : 'json',
		formatItem : function(row, i, max) {
			return row.catlgNo + "-" + row.catlgName;
		},
		formatMatch : function(row, i, max) {
			return row.catlgNo + "-" + row.catlgName;
		},
		formatResult : function(row) {
			return row.catlgNo + "-" + row.catlgName;
		}

	}).result(function(event, data, formatted) { // 回调
		var thisValue = data.catlgNo + "-" + data.catlgName;
		$(this).val(thisValue);
		$("#dafenleiInput2").val(data.catlgId);
		$(this).removeClass('errorInput');
		var prevValue = $(this).attr('prevValue');
		$(this).attr('prevValue', thisValue);
		if ($.trim(prevValue) == '' || prevValue != thisValue) {
			// $.post(ctx +
			// $('#zhongfenleiInput').attr('currurl')+data.id,function(data){
			var ccurl = ctx + $('#zhongfenleiInput').attr('currurl') + data.catlgId;
			$('#zhongfenleiInput').removeAttr('prevvalue');
			$('#zhongfenleiInput').flushCache();
			$('#xiaofenleiInput').flushCache();
			$('#zhongfenleiInput').unautocomplete();
			$('#xiaofenleiInput').unautocomplete();
			$('#zhongfenleiInput').val('');
			$('#xiaofenleiInput').val('');
			$('#zhongfenleiInput2').val('');
			$('#xiaofenleiInput2').val('');
			zhongfenleiInputSelect(ccurl);
			// });
		}
		setCatlgWarn($('#xiaofenleiInput2').val());
	});
}
function zhongfenleiInputSelect(url) {
	$("#zhongfenleiInput").unautocomplete().autocomplete(url, {
		minChars : 0,
		width : $(this).attr('width'),
		max : 3000,
		matchContains : true,
		matchCase : false,// 不区分大小写
		autoFill : false,
		dataType : 'json',
		formatItem : function(row, i, max) {
			return row.catlgNo + "-" + row.catlgName;
		},
		formatMatch : function(row, i, max) {
			return row.catlgNo + "-" + row.catlgName;
		},
		formatResult : function(row) {
			return row.catlgNo + "-" + row.catlgName;
		}

	}).result(function(event, data, formatted) { // 回调
		var thisValue = data.catlgNo + "-" + data.catlgName;
		$(this).val(thisValue);
		// $("#zhongfenleiInput").val(thisValue);
		$("#zhongfenleiInput2").val(data.catlgId);
		$(this).removeClass('errorInput');
		var prevValue = $(this).attr('prevValue');
		$(this).attr('prevValue', thisValue);
		getSpeclGrpCtrl(data.catlgId);
		if ($.trim(prevValue) == '' || prevValue != thisValue) {
			// $.post(ctx +
			// $('#xiaofenleiInput').attr('currurl')+data.id,function(data){
			var ccurl = ctx + $('#xiaofenleiInput').attr('currurl') + data.catlgId;
			$('#xiaofenleiInput').flushCache();
			$('#xiaofenleiInput').unautocomplete();
			$('#xiaofenleiInput').val('');
			$('#xiaofenleiInput2').val('');
			xiaofenleiInputSelect(ccurl);
			// });
		}
		setCatlgWarn($('#xiaofenleiInput2').val());
	});
}
function xiaofenleiInputSelect(url) {
	$("#xiaofenleiInput").unautocomplete().autocomplete(url, {
		minChars : 0,
		width : $(this).attr('width'),
		max : 3000,
		matchContains : true,
		matchCase : false,// 不区分大小写
		autoFill : false,
		dataType : 'json',
		formatItem : function(row, i, max) {
			return row.catlgNo + "-" + row.catlgName;
		},
		formatMatch : function(row, i, max) {
			return row.catlgNo + "-" + row.catlgName;
		},
		formatResult : function(row) {
			return row.catlgNo + "-" + row.catlgName;
		}

	}).result(function(event, data, formatted) { // 回调
		$("#xiaofenleiInput2").val(data.catlgId);
		setCatlgWarn(data.catlgId);
		$(this).removeClass('errorInput');
		$(this).val(data.catlgNo + "-" + data.catlgName);
	});
}

/** 处别2 */
function chubieInputSelect2(url) {
	$("#chubieInput").autocomplete(url, {
		minChars : 0,
		width : $(this).attr('width'),
		max : 3000,
		matchContains : true,
		matchCase : false,// 不区分大小写
		autoFill : false,
		dataType : 'json',
		formatItem : function(row, i, max) {
			return row.catlgId + "-" + row.catlgName;
		},
		formatMatch : function(row, i, max) {
			return row.catlgId + "-" + row.catlgName;
		},
		formatResult : function(row) {
			return row.catlgId + "-" + row.catlgName;
		}

	}).result(
			function(event, data, formatted) { // 回调
				var thisValue = data.catlgId + "-" + data.catlgName;
				$(this).val(thisValue);
				$("#chubieInput2").val(data.catlgId);
				$(this).removeClass('errorInput');
				var prevValue = $(this).attr('prevValue');
				$(this).attr('prevValue', data.catlgId + "-" + data.catlgName);
				if ($.trim(prevValue) == '' || prevValue != thisValue) {
					// $.post(ctx +
					// $('#kebieInput').attr('currurl')+data.id,function(data){
					var ccurl = ctx + $('#kebieInput').attr('currurl')
							+ data.catlgId;
					$('#clstrdisplay').val('');
					$('#kebieInput,#dafenleiInput,#zhongfenleiInput')
							.removeAttr('prevvalue');
					$('#kebieInput').flushCache();
					$('#dafenleiInput').flushCache();
					$('#zhongfenleiInput').flushCache();
					$('#xiaofenleiInput').flushCache();
					$('#kebieInput').unautocomplete();
					$('#dafenleiInput').unautocomplete();
					$('#zhongfenleiInput').unautocomplete();
					$('#xiaofenleiInput').unautocomplete();
					$('#kebieInput').val('');
					$('#dafenleiInput').val('');
					$('#zhongfenleiInput').val('');
					$('#xiaofenleiInput').val('');
					$('#kebieInput2').val('');
					$('#dafenleiInput2').val('');
					$('#zhongfenleiInput2').val('');
					$('#xiaofenleiInput2').val('');
					kebieInputSelect(ccurl);
					// });
				}
			});
}

/** 处别2 */
function kebieInputSelect2(url) {
	$("#kebieInput").autocomplete(url, {
		minChars : 0,
		width : $(this).attr('width'),
		max : 3000,
		matchContains : true,
		matchCase : false,// 不区分大小写
		autoFill : false,
		dataType : 'json',
		formatItem : function(row, i, max) {
			return row.catlgId + "-" + row.catlgName;
		},
		formatMatch : function(row, i, max) {
			return row.catlgId + "-" + row.catlgName;
		},
		formatResult : function(row) {
			return row.catlgId + "-" + row.catlgName;
		}

	}).result(
			function(event, data, formatted) { // 回调
				var thisValue = data.catlgId + "-" + data.catlgName;
				$(this).val(thisValue);
				$("#kebieInput2").val(data.catlgId);
				$(this).removeClass('errorInput');
				var prevValue = $(this).attr('prevValue');
				$(this).attr('prevValue', data.catlgId + "-" + data.catlgName);
				if ($.trim(prevValue) == '' || prevValue != thisValue) {
					var ccurl = ctx + $('#dafenleiInput').attr('currurl')
							+ data.catlgId;
					$('#clstrdisplay').val('');
					$('#dafenleiInput,#zhongfenleiInput')
							.removeAttr('prevvalue');
					$('#dafenleiInput').flushCache();
					$('#zhongfenleiInput').flushCache();
					$('#xiaofenleiInput').flushCache();
					$('#kebieInput').unautocomplete();
					$('#dafenleiInput').unautocomplete();
					$('#zhongfenleiInput').unautocomplete();
					$('#xiaofenleiInput').unautocomplete();
					$('#kebieInput').val('');
					$('#dafenleiInput').val('');
					$('#zhongfenleiInput').val('');
					$('#xiaofenleiInput').val('');
					$('#kebieInput2').val('');
					$('#dafenleiInput2').val('');
					$('#zhongfenleiInput2').val('');
					$('#xiaofenleiInput2').val('');
					dafenleiInputSelect(ccurl);
					setCatlgWarn($('#xiaofenleiInput2').val());
					// });
				}
			});
}

/** 新增一行 */
function addDataRow(obj, prev) {
	$(obj).find('input').each(function() {
		var objName = $(this).attr('name');
		$(this).attr('name', prev + '[' + (provNum) + '].' + objName);
	});
	provNum++;
}

/** check-box全选或全取消 */
function selectCheckbox(obj, checked) {
	checked = $.trim(checked);
	if (checked == 'checked') {
		$(obj).find('input:checkbox').attr('checked', 'checked');
	} else {
		$(obj).find('input:checkbox').attr('checked', false);
	}
}
/** 删除选择的check-box */
function deleteCheckbox(obj) {
	$(obj).find('input:checkbox').each(function() {
		var checked = $(this).attr('checked');
		if (checked == 'checked') {
			$(this).parent().remove();
		}
	});
	if ($(obj).find('input:checkbox') == null || $(obj).find('input:checkbox').length == 0) {
		$('#item_create_2').find('#selectallbarcode').removeAttr("checked");
	}
	if($('#item_create_2').is(':visible')){
		updateAutoBarcode();
	}
}

function updateAutoBarcode(){
	var itemStoreCode= gen_ean13_barcode($('#itemNo').val(),$('#itemType').val(),$('#barcodeLabel').val(),$('#projLabel').val());
	$('#item_create_2:visible .hh_item :checkbox').attr('checked',false);
	$('#item_create_2:visible').find('input[name="barcode"]').each(function(){
		if($(this).val()==itemStoreCode){
			$('#item_create_2:visible .hh_item :checkbox').attr('checked','checked');
		}
	});
}

/** 城市pop-up */
function openCityAndProvWindow() {
	openPopupWin(550, 410,
			'/commons/window/chooseCityAndProv?callback=confirmReg');
}

/** 获取点击城市的值 */
function confirmReg(cityCode, cityName, provCode, provName) {
	var parentObj = $(currentPopObj).parent().parent();
	$(parentObj).find('.cityName').val(cityName);
	$(parentObj).find('.provName').val(provName);
	$(parentObj).find('.cityName').removeClass('errorInput');
	$(parentObj).find('.provName').removeClass('errorInput');
	$(parentObj).find('.provCode').val(provCode);
	$(parentObj).find('.cityCode').val(cityCode);
	closePopupWin();
}

/** 根据供应商ID获取采购类型 */
function getBuyMethodsBySupplierId(supplierId,internalInd) {
	if (!supplierId) {
		return false;
	}
	$.post(ctx + '/item/create/getBuyMethd?supId=' + supplierId+"&internalInd="+internalInd,
			function(data) {
				$('#buyMethd').empty();
				var selectBlankStr = '<option value="">请选择</option>';
				var optionStr = selectBlankStr;
				if(internalInd==1)
				{
					$.each(data, function(index, value) {
						optionStr += "<option value=" + value.code
								+ '>' + value.code + "-"
								+ value.title + "</option>";
					});
				}
				else
				{
					$.each(data, function(index, value) {
						optionStr += "<option value=" + value.code
								+ ' selected="selected">' + value.code + "-"
								+ value.title + "</option>";
					});
					$('#buyMethd').removeClass('errorInput');
				}

				$('#buyMethd').append(optionStr);

				$('#itemType').empty();
				$('#itemType').append(selectBlankStr);
				$('#prcssType').empty();
				$('#prcssType').append(selectBlankStr);
				$('#itemPack').empty();
				$('#itemPack').append(selectBlankStr);
				getNextMetaData();
			});
}

/** 根据商品采购/空管等决定下一级信息 */
function getNextMetaData() {
	var speclGrpCtrl = $('#speclGrpCtrl').val();
	var buyMethd = $('#buyMethd').val();
	if ($.trim(speclGrpCtrl) == '' || $.trim(buyMethd) == '') {
		return false;
	}
	var selectBlankStr = '<option value="">请选择</option>';
	var itemType = $('#itemType').val();
	$.ajaxSetup({
		async : false
	});
	if ($.trim(itemType) == '') {
		$.post(ctx + '/item/create/getMetaItemSmartSelection?speclCtrl='
				+ speclGrpCtrl + "&buyMethd=" + buyMethd, function(data) {
			var optionStr = selectBlankStr;
			$('#itemType').empty();
			$.each(data, function(index, value) {
				optionStr += "<option value=" + value.code + ">" + value.code
						+ "-&nbsp;" + value.title + "</option>";
			});
			$('#itemType').append(optionStr);
			$('#prcssType').empty();
			$('#prcssType').append(selectBlankStr);
			$('#itemPack').empty();
			$('#itemPack').append(selectBlankStr);
		});
		return false;
	}
	var prcssType = $('#prcssType').val();
	if ($.trim(prcssType) == '') {
		$.post(ctx + '/item/create/getMetaItemSmartSelection?speclCtrl='
				+ speclGrpCtrl + "&buyMethd=" + buyMethd + "&itemType="
				+ itemType, function(data) {
			var selectBlankStr = '<option value="">请选择</option>';
			var optionStr = selectBlankStr;
			$('#prcssType').empty();
			$.each(data, function(index, value) {
				optionStr += "<option value=" + value.code + ">" + value.code
						+ "-&nbsp;" + value.title + "</option>";
			});
			$('#prcssType').append(optionStr);
			$('#itemPack').empty();
			$('#itemPack').append(selectBlankStr);
		});
		return false;
	}
	$.post(ctx + '/item/create/getMetaItemSmartSelection?speclCtrl='
			+ speclGrpCtrl + "&buyMethd=" + buyMethd + "&itemType=" + itemType
			+ "&prcssType=" + prcssType, function(data) {
		var optionStr = '<option value="">请选择</option>';
		$('#itemPack').empty();
		$.each(data, function(index, value) {
			optionStr += "<option value=" + value.code + ">" + value.code
					+ "-&nbsp;" + value.title + "</option>";
		});
		$('#itemPack').append(optionStr);
		return false;
	});
	$.ajaxSetup({
		async : true
	});
}

function nullInputCheck() {
	$('.mustInput:visible').each(function() {
		$(this).blur(function() {
			if ($.trim($(this).val()) == '' && !($(this).hasClass())) {
				$(this).addClass('errorInput');
			}
		});
		$(this).focus(function() {
			$(this).removeClass('errorInput');
		});
	});
}

/** form 校验 */
function chkItemInfo() {
	var inputOk = true;
	$('.mustInput:visible').each(function() {
		if ($.trim($(this).val()) == '') {
			if (!($(this).hasClass('errorInput'))) {
				$(this).addClass('errorInput');
			}
			inputOk = false;
		}
	});

	return inputOk;
}
/** form保存 */
function saveItemInfo() {
	if (chkItemInfo()) {
		var retVal = true;
		$.ajaxSetup({
			async : false
		});
		grid_layer_open();
		retVal = saveForm(eval("saveStep" + item_create_content));
		grid_layer_close();
		grid_layer_close();
		if (!retVal) {
			return retVal;
		}
		$.ajaxSetup({
			async : true
		});
		// $('#Tools2').addClass('Tools2_disable');
		// $('#Tools2').removeClass('Tools2');
		return retVal;
	} else {
		return false;
	}
}

function saveForm(callback) {
	return callback();
}

function checkForm1() {
	$.ajaxSetup({
		async : false
	});
	var returnVal = true;
	var valueCheckErr = false;
	var regionNodeObjs = $('input.regionNode[value!=""]');
	var msg = '';
	for (var i = 0; i < regionNodeObjs.size(); i++) {
		for (var j = 0; i < regionNodeObjs.size() && i != j; i++) {
			if ($(regionNodeObjs[i]).val() == $(regionNodeObjs[j]).val()) {
				$(regionNodeObjs[i]).addClass('errorInput');
				$(regionNodeObjs[j]).addClass('errorInput');
				returnVal = false;
				valueCheckErr = true;
			}
		}
	}
	if (valueCheckErr) {
		valueCheckErr = false;
		msg += "城市有重复!";
	}
	else
	{
		for (var i = 0; i < regionNodeObjs.size() ; i++) {
			$(regionNodeObjs[i]).removeClass('errorInput');
		}
	}
	var majorRegnOrignCode = $('#majorRegn input.orignCode').val();
	$('.otherRegn input.orignCode[value!=""]').each(
			function() {
				if ($(this).val() == majorRegnOrignCode) {
					returnVal = false;
					$(this).addClass('errorInput');
					$(this).parent().parent().find('.orignTitle').addClass(
							'errorInput');
					valueCheckErr = true;
				}
			});
	if (valueCheckErr) {
		msg += "<br/>其他产地不能与主产地重复!";
		valueCheckErr = false;
	}
	var producerComName = $('input.producerComName[value!=""]');
	for (var i = 0; i < producerComName.size(); i++) {
		for (var j = 0; i < producerComName.size() && i != j; i++) {
			if ($(producerComName[i]).val() == $(producerComName[j]).val()) {
				$(producerComName[i]).addClass('errorInput');
				returnVal = false;
				valueCheckErr = true;
			}
		}
	}
	if (valueCheckErr) {
		msg += "<br/>生产单位不能重复!";
	}
	if (!returnVal) {
		// commonAlert(msg,300,50,'新增商品');
		top.jAlert('warning', msg, '消息提示');
	}
	$.ajaxSetup({
		async : true
	});
	return returnVal;
}

function saveStep1() {
	if (checkForm1()) {
		var formUrl = $('#item_create_' + (item_create_content)).attr('url');
		// var itemBasicData = $('#item_create_1').serialize();
		var itemBasicAuditVo = JSON.stringify($('#item_create_1')
				.serializeObject());
		var producerAddrVo = JSON.stringify($('#majorRegn').serializeObject());

		var produceAddrList = $('#otherRegList').find('.otherRegn').map(
				function() {
					return JSON.stringify($(this).serializeObject());
				}).get().join(", ");
		if (item_create[item_create_content] == itemBasicAuditVo+ producerAddrVo + produceAddrList) {
			if(saveButFlag=='save'){top.jAlert('warning', '已保存!', '消息提示');}
			return true;
		}
		item_create[item_create_content] = itemBasicAuditVo + producerAddrVo + produceAddrList;
		var seTopicIds = $('#seTopicIds').val();
		var retval = true;
		var modflag = false;
		$.ajaxSetup({async : false});
		if($.trim($('#itemNo').val())==''){
			top.jConfirm('当前页面保存以后,主厂商、处别、课别、大中小分类、系列将不能修改,您需要保存当前页面的信息吗？','提示消息',function(ret){
				if(ret){
					retval = submitData(itemBasicAuditVo,producerAddrVo,produceAddrList,seTopicIds,formUrl,saveButFlag,retval);
					//向右,保存成功后,直接跳入第二步
					if(saveButFlag!='save' && retval){
						//turnRight();
						item_create_content=2;
						switchDiv(item_create_content);
					}
				}
				else{
					item_create[item_create_content]='';
				}
			});
			return false;
		}
		else{
			retval = submitData(itemBasicAuditVo,producerAddrVo,produceAddrList,seTopicIds,formUrl,saveButFlag,retval);
			return retval;
		}
		$.ajaxSetup({async : true});
	} else {
		return false;
	}
}

function submitData(itemBasicAuditVo,producerAddrVo,produceAddrList,seTopicIds,formUrl,saveButFlag,retval){
	$.ajax({
		type : "post",
		async : false,
		url : ctx + formUrl,
		// dataType : "json",
		data : {
			itemBasicAuditVo : itemBasicAuditVo,
			producerAddrVo : producerAddrVo,
			produceAddrList : produceAddrList,
			seTopicIds : seTopicIds,
			taskId : itemTaskId
		},
		success : function(data) {
			if (data.status == 'success') {
				itemTaskId = data.taskId;
				if($.trim($('#itemNo').val())==''){
					$('#itemNo').val(data.itemNo);
				}
				if($.trim($('#majorRegn .producerId').val())==''){
					$('#majorRegn .producerId').val(data.producerId);
				}
				$('#prod_unitName_1').val($('#prod_unitName').val());
			}
			if(saveButFlag=='save'){
				if (data.status == 'success') {
//					successAlert("保存成功", 300, 50, '新增商品');
						top.jAlert('success',"保存成功!", '消息提示');
						$('.cantEdit').attr('disabled','disabled');
						$('#majorSupNo').attr('readonly','readonly');
						$('.cantEdit').removeAttr('onclick');
						$('.cantEdit').removeAttr('onblur');
				} else {
					if (data.message) {
						// commonAlert(data.message,300,50,'新增商品');
						top.jAlert('warning', data.message, '消息提示');
					} else {
						// commonAlert("保存失败!",300,50,'新增商品');
						top.jAlert('warning', '保存失败!', '消息提示');
						item_create[item_create_content]='';
					}
					retval = false;
				}
			}
		}
	});
	return retval
}

// 第二步校验
function checkForm2() {
	var returnVal = true;
	var barcodeList = $('input[name="barcode"]:visible');
	for (var i = 0; i < barcodeList.length; i++) {
		for (var j = 0; j < barcodeList.length && j != i; j++) {
			if ($(barcodeList[i]).val() == $(barcodeList[j]).val()) {
				returnVal = false;
				top.jAlert('warning', '商品条码重复输入!', '消息提示');
				break;
			}
		}
	}
	if (returnVal) {
		$('input[name="barcode"]:visible').each(function() {
			if (validate_barcode($(this))) {
				var code = $(this).val();
			} else {
				returnVal = false;
			}
		});
	}
	return returnVal;
}
// 第二步保存
function saveStep2() {
	if (checkForm2()) {
		var formUrl = $('#item_create_' + (item_create_content)).attr('url');
		var retval = true;
		var itemBarcodeData = $('#item_create_' + item_create_content)
				.serialize();
		if ($('input[name="barcode"]:visible').size() == 0) {
			top.jAlert('warning', '商品条码不能为空!', '消息提示');
			return false;
		}
		if (itemBarcodeData == item_create[item_create_content]) {
			if(saveButFlag=='save'){top.jAlert('warning', '已保存!', '消息提示');}
			return true;
		}
		item_create[item_create_content] = itemBarcodeData;
		$.ajaxSetup({async : false});
		$.post(ctx + formUrl, item_create[item_create_content] + "&taskId="
				+ itemTaskId, function(data) {
			if(saveButFlag=='save'){
				if (data.status == 'success') {
					$.each(data.result, function(index, value) {
						var barcode = value;
						var barcode_Create_Date = new Date(barcode.creatDate).format('yyyy-MM-dd');
						$("#item_create_2").find(".sp_tb:first").find('.ig input[name=\'barcode\']').each(
								function() {
									if ($.trim($(this).val()) == barcode.barcode) {
										$(this).next().val(barcode_Create_Date);
										$(this).next().next().val(barcode.creatBy);
										return true;
									}
								});
					});
	//				successAlert("保存成功", 300, 50, '新增商品');
					top.jAlert('success',"保存成功!", '消息提示');
					return true;
				} else {
					if (data.message) {
						// commonAlert(data.message,300,50,'新增商品');
						top.jAlert('warning', data.message, '消息提示');
					} else {
						// commonAlert("保存失败!",300,50,'新增商品')
						top.jAlert('warning', '保存失败!', '消息提示');
						item_create[item_create_content]='';
					}
					retval = false;
				}
			}
		});
		$.ajaxSetup({
			async : true
		});
		return retval;
	} else {
		return false;
	}
}

// 第三步校验
function checkForm3() {
	var returnVal = true;
	if (!inputToInputDoubleNumberAndChkLenManul($('#face'))) {
		top.jAlert('warning', '长度格式不正确!', '消息提示');
		return false;
	}
	if (!inputToInputDoubleNumberAndChkLenManul($('#depth'))) {
		top.jAlert('warning', '宽度格式不正确!', '消息提示');
		return false;
	}
	if (!inputToInputDoubleNumberAndChkLenManul($('#hght'))) {
		top.jAlert('warning', '高度格式不正确!', '消息提示');
		return false;
	}
	return returnVal;
}
//第三步保存
function saveStep3() {
	if (checkForm3() && validataLicnceInfo()) {
		var formUrl = $('#item_create_' + (item_create_content)).attr('url');
		var retval = true;
		var itemSpecData = $('#item_create_' + item_create_content).serialize();
		if (itemSpecData == item_create[item_create_content]) {
			if(saveButFlag=='save'){top.jAlert('warning', '已保存!', '消息提示');}
			return true;
		}
		//封装json数据传到后台
		appendJsonDataByLicnce();
		
		item_create[item_create_content] = itemSpecData;
		$.ajaxSetup({
			async : false
		});
		$.post(ctx + formUrl, item_create[item_create_content] + "&taskId="
				+ itemTaskId+"&comLicencesList="+jsonStrs, function(data) {
			if(saveButFlag=='save'){
				if (data.status == 'success') {
	//				successAlert("保存成功", 300, 50, '新增商品');
					top.jAlert('success',"保存成功!", '消息提示');
					jsonStrs="";
					readLicnceIdPicInfos($('#itemNo').val());
					return true;
				} else {
					if (data.message) {
						// commonAlert(data.message,300,50,'新增商品');
						top.jAlert('warning', data.message, '消息提示');
						jsonStrs="";
					} else {
						// commonAlert("保存成功",300,50,'新增商品')
						top.jAlert('warning', '保存失败!', '消息提示');
						item_create[item_create_content]='';
						jsonStrs="";
					}
					retval = false;
				}
			}
		});
		$.ajaxSetup({
			async : true
		});
		return retval;
	} else {
		return false;
	}
}

// 第4步校验
function checkForm4() {
	var returnVal = true;
	var scaleMemo = $('#scaleMemo').val();
	if(scaleMemo.length>20){
		$('#scaleMemo').addClass('errorInput');
		return false;
	}
	
	return returnVal;
}
// 第4步保存
function saveStep4() {
	if (checkForm4()) {
		var formUrl = $('#item_create_' + (item_create_content)).attr('url');
		var retval = true;
		var itemRealStoreCtrlData = $('#item_create_' + item_create_content)
				.serialize();
		if (itemRealStoreCtrlData == item_create[item_create_content]) {
			if(saveButFlag=='save'){top.jAlert('warning', '已保存!', '消息提示');}
			return true;
		}
		item_create[item_create_content] = itemRealStoreCtrlData;
		$.ajaxSetup({
			async : false
		});
		$.post(ctx + formUrl, item_create[item_create_content] + "&taskId="
				+ itemTaskId, function(data) {
			if(saveButFlag=='save'){
				if (data.status == 'success') {
	//				successAlert("保存成功", 300, 50, '新增商品');
					top.jAlert('success',"保存成功", '消息提示');
					return true;
				} else {
					if (data.message) {
						// commonAlert(data.message,300,50,'新增商品');
						top.jAlert('warning', data.message, '消息提示');
					} else {
						// commonAlert("保存失败!",300,50,'新增商品');
						top.jAlert('warning', '保存失败!', '消息提示');
						item_create[item_create_content]='';
					}
					retval = false;
				}
			}
		});
		$.ajaxSetup({
			async : true
		});
		return retval;
	} else {
		return false;
	}
}

// 第5步校验
function checkForm5() {
	var returnVal = true;
	if($('#storeListDiv .list_ex0').size()==0){
		top.jAlert('warning', '请新增主厂商及下传区域!', '消息提示');
		return false;
	}
	if (!inputToInputDoubleNumberAndChkLenManul($('.storeInfo'))) {
		return false;
	}
	return chkStoreInfo();
}

String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) {
	if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
		return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi" : "g")),
				replaceWith);
	} else {
		return this.replace(reallyDo, replaceWith);
	}
};

// 第5步保存
function saveStep5() {
	if (checkForm5()) {
		var formUrl = $('#item_create_' + (item_create_content)).attr('url');
		var retval = true;
		var itemStoreInfoList = $('#storeInfoList').find('.itemStoreInfo').map(
				function() {
					return JSON.stringify($(this).serializeObject());
				}).get().join("+");

		var otherSupFormList = $('#otherSupListDiv').find('.otherSupForm').map(
				function() {
					// return $(this).serialize().replaceAll("=","+");
					return JSON.stringify($(this).serializeObject());
				}).get().join("+");
		if (item_create[item_create_content] == itemStoreInfoList
				+ otherSupFormList) {
			if(saveButFlag=='save'){top.jAlert('warning', '已保存!', '消息提示');}
			return true;
		}
		item_create[item_create_content] = itemStoreInfoList + otherSupFormList;

		$.ajaxSetup({
			async : false
		});
		$.post(ctx + formUrl, "itemStoreInfoVOList=" + itemStoreInfoList
				+ "&itemSupVOList=" + otherSupFormList + "&itemNo="
				+ $('#itemNo').val() + "&taskId=" + itemTaskId + "&orignCode="
				+ $('#otherOrignCode').val() + "&producerId="
				+ $('#producerId').val() + "&buyMethd=" + $('#buyMethd').val()
				+ "&prcssType=" + $('#prcssType').val(), function(data) {
			if(saveButFlag=='save'){
				if (data.status == 'success') {
	//				successAlert("保存成功", 300, 50, '新增商品');
					top.jAlert('success',"保存成功", '消息提示');
					$('#Tools2').removeClass('Tools2');
					$('#Tools2').addClass('Tools2_disable');
					$('#Tools2').unbind("click");
					$.post(ctx + "/workspace/task/checkItemCanSubmit?taskId=" + itemTaskId, function(data) {
						if(data.status=='success'){
							canSubmitFlag=1;
							$('#Tools26').removeClass("Tools26_disable");
							$('#Tools26').addClass("Tools26");
							$('#Tools26').unbind("click").bind("click", submitItemData);
						}
					});
					return true;
				} else {
					if (data.message) {
						// commonAlert(data.message,300,50,'新增商品');
						top.jAlert('warning', data.message, '消息提示');
					} else {
						// commonAlert("保存失败!",300,50,'新增商品');
						top.jAlert('warning', '保存失败!', '消息提示');
						item_create[item_create_content]='';
					}
					retval = false;
				}
			}
		});
		$.ajaxSetup({
			async : true
		});
		return retval;
		/*
		 * $.ajax({ type : "post", async : false, url : ctx + formUrl, dataType :
		 * "json", data :{ itemStoreInfoVOList:itemStoreInfoList,
		 * itemSupVOList:otherSupFormList } , success : function(data) {
		 * alert(data); } });
		 */
	} else {
		return false;
	}
}

//提交商品信息到审核流程
function submitItemData() {
	if(checkForm5()){
		$.post(ctx + '/workspace/task/doSubmitItemCreateTask2Audit', 'taskId='+itemTaskId, function(data) {
				if(data.status=='success'){
					top.jAlert('success', '提交成功!', '消息提示');
					$('#Tools26').removeClass("Tools26");
					$('#Tools26').addClass("Tools26_disable");
					$('#Tools26').unbind("click");
				}
				else{
					top.jAlert('warning', data.message, '消息提示');
				}
			});
	}
}

/** 上一步 */
function turnLeft() {
	// return ;//不能回头修改
	if (item_create_content == 5) {
		$('#Tools25').unbind("click").bind("click", turnRight);
	}
	/*
	 * if(item_create[item_create_content]!=$('#item_create_'+item_create_content).serialize()){
	 * commonAlert("请先保存,再进入上一步!",300,50,'新增商品'); return false; }
	 */
	return switchDiv(--item_create_content);
}
/** 下一步 */
function turnRight() {
	saveButFlag = "turn";
	$.ajaxSetup({async : false});
	if (viewFlag=='1' || saveItemInfo()) {
		if (item_create_content == 1) {
			$('#Tools24').unbind("click").bind("click", turnLeft);
		}
		/*
		 * if(item_create[item_create_content]!=$('#item_create_'+item_create_content).serialize()){
		 * commonAlert("请先保存,再进入下一步!",300,50,'新增商品'); return false; }
		 */
		// switchDiv(++item_create_content);
		if (item_create_content == 1) {
			$('#Tools24').unbind("click").bind("click", turnLeft);
		}
		/*
		 * if(item_create[item_create_content]!=$('#item_create_'+item_create_content).serialize()){
		 * commonAlert("请先保存,再进入下一步!",300,50,'新增商品'); return false; }
		 */
		saveButFlag="save";
		$.ajaxSetup({
			async : true
		});
		return switchDiv(++item_create_content);
	}
}
/** 进入上一步/下一步页面 */
function switchDiv(num) {
	$('.itemName').val($('#itemName').val());
	if (num > 0 && num < 6) {
		var showDivUrl = '';
		$('#Tools26').removeClass("Tools26");
		$('#Tools26').addClass("Tools26_disable");
		$('#Tools26').unbind("click");
		switch (num) {
		case 1:
			if($('#itemNo').val()!=''){
				$('#majorSupNo').attr('readonly','readonly');
				$('#majorSupNo').removeAttr('onblur');
				$('.cantEdit').attr('disabled','disabled');
				$('.cantEdit').removeAttr('onclick');
				$('.cantEdit').removeAttr('onblur');
			}
			$('#Tools24').unbind("click");
			$('#Tools24').removeClass("Tools24");
			$('#Tools24').addClass("Tools24_disable");
			break;
		case 2:
			showDivUrl = 'stepTwo?taskId=' + itemTaskId;
			$('#Tools24').unbind("click").bind("click", turnLeft);
			$('#Tools24').addClass("Tools24");
			$('#Tools24').removeClass("Tools24_disable");
			$('#Tools25').addClass("Tools25");
			$('#Tools25').removeClass("Tools25_disable");
			break;
		case 3:
			showDivUrl = 'stepThree?secId=' + $('#kebieInput2').val()
					+ "&taskId=" + itemTaskId;
			break;
		case 4:
			showDivUrl = 'stepFour?taskId=' + itemTaskId;
			$('#Tools24').addClass("Tools24");
			$('#Tools24').removeClass("Tools24_disable");
			$('#Tools25').addClass("Tools25");
			$('#Tools25').removeClass("Tools25_disable");
			break;
		case 5:
			showDivUrl = 'stepFive?taskId=' + itemTaskId+"&itemMainSupNo="+$('#majorSupNo').val();
			$('#Tools25').unbind("click", turnRight);
			$('#Tools25').removeClass("Tools25");
			$('#Tools25').addClass("Tools25_disable");
			if(checkEditHasSaved()){
				$.post(ctx + "/workspace/task/checkItemCanSubmit?taskId=" + itemTaskId, function(data) {
					if(data.status=='success'){
						canSubmitFlag=1;
						$('#Tools26').removeClass("Tools26_disable");
						$('#Tools26').addClass("Tools26");
						$('#Tools26').unbind("click").bind("click", submitItemData);
					}
				});
			}
			break;
		}
		showDivUrl = ctx + '/item/create/' + showDivUrl;
		var divDivObj = $('.item_create_' + num);
		$.ajaxSetup({
			async : false
		});
		if ($.trim(divDivObj.html()) == '') {
			$.post(showDivUrl, function(data) {
				$(divDivObj).html(data);
			});
		}
		$.ajaxSetup({
			async : true
		});
		$('.Content').hide();
		$(divDivObj).show();
		$('#Tools2').removeClass('Tools2_disable');
		$('#Tools2').addClass('Tools2');
		$('.CInfo').css(
				'background-image',
				'url(' + ctx + '/shared/themes/'+theme+'/images/item' + num
						+ '.jpg)');
		$('.sp_store_on').removeClass('sp_store_on');
		$('.sp_store' + (6 - num)).addClass('sp_store_on');
		$('.sp_store_off').removeClass('sp_store_off');
		$('.CInfo').find('.sp_store_on').prevAll().addClass('sp_store_off');
		if(num==4){
			readLicnceIdPicInfosToShow($('#itemNo').val());	
		}
		if(viewFlag=='1'){
			$('input:text').attr('readonly','readonly');
			$('textarea').attr('readonly','readonly');
			$('input:checkbox').attr('disabled','disabled');
			if(num!=1){
				$('select').attr('disabled','disabled');
			}
			$('.ListWin').attr('onclick','');
			$('.sp_icon2').attr('onclick','');
			$('.Icon-size2').attr('onclick','');
			$('.sp_icon4').attr('onclick','');
			$('#Tools2').removeClass('Tools2');
			$('#Tools2').addClass('Tools2_disable');
			$('#Tools2').unbind('click');
			$('.divHide').hide();
			$('input:visible').each(function(){$(this).removeAttr('onblur');$(this).unbind();});
			if(num==5){
				$('.chbox-mgl').css('margin-left','30px');
			}
			else{
				$('.chbox-mgl').css('margin-left','15px');
			}
		}
		if(num<5){
			$('#Tools2').unbind("click").bind("click", saveItemInfo);
			if(num==2){
				var itemStoreCode= gen_ean13_barcode($('#itemNo').val(),$('#itemType').val(),$('#barcodeLabel').attr('barcodeLabel'),$('#projLabel').val());
				var eanBarcodeEle = null;
				$('#item_create_2').find('input[name="barcode"]').each(function(){
					if(this.value==itemStoreCode)
						eanBarcodeEle=$(this);
				});
				if($(eanBarcodeEle).size()>0){
					$('#item_create_2 .hh_item :checkbox').attr('checked','checked');
					var itemStoreCode2= gen_ean13_barcode($('#itemNo').val(),$('#itemType').val(),$('#barcodeLabel').val(),$('#projLabel').val());
					$(eanBarcodeEle[0]).val(itemStoreCode2);
				}
			}
		}
		else{
			setSubmitStatus();
		}
	}
}

function setSubmitStatus(){
	$('#Tools26').removeClass("Tools26");
	$('#Tools26').addClass("Tools26_disable");
	$('#Tools26').unbind("click");
	$('#Tools2').removeClass('Tools2');
	$('#Tools2').addClass('Tools2_disable');
	$('#Tools2').unbind("click");
	if(!checkEditHasSaved()){
		$('#Tools2').removeClass('Tools2_disable');
		$('#Tools2').addClass('Tools2');
		$('#Tools2').unbind("click").bind("click", saveItemInfo);
	}
	else if(item_create[5]!=null){
		if(canSubmitFlag==1){
			$('#Tools26').removeClass("Tools26_disable");
			$('#Tools26').addClass("Tools26");
			$('#Tools26').unbind("click").bind("click", submitItemData);
		}
	}
}

function checkEditHasSaved(){
	var itemStoreInfoList = $('#storeInfoList').find('.itemStoreInfo').map(
			function() {
				return JSON.stringify($(this).serializeObject());
			}).get().join("+");

	var otherSupFormList = $('#otherSupListDiv').find('.otherSupForm').map(
			function() {
				// return $(this).serialize().replaceAll("=","+");
				return JSON.stringify($(this).serializeObject());
			}).get().join("+");
	if (itemStoreInfoList=='' || item_create[5] == itemStoreInfoList + otherSupFormList) {
		return true;
	}
	return false;
}

// 单位下拉框
function loadDownLoadDivByName(obj, dataList, setValueObj, divWidth, type,
		callback) {
	$(obj).autocomplete(
			dataList,
			{
				minChars : 0,
				width : $.trim(divWidth) == '' ? $(this).attr('width')
						: divWidth,
				max : 3000,
				matchContains : true,
				matchCase : true,// 不区分大小写
				autoFill : false,
				selectFirst:true,
				dataType : 'json',
				formatItem : function(row, i, max) {
					return ($.trim(type) != '' && type == 0) ? row.title
							: (row.code + "-" + row.title);
				},
				formatMatch : function(row, i, max) {
					return row.title;

				},
				formatResult : function(row) {
					return row.title;
				}
			}).result(function(event, data, formatted) { // 回调
		if (data && setValueObj) {
			setValueObj.val(data.code);
		}
		if (callback) {
			callback();
		}
	});
}

function unitAvgCalculate() {
	var avgUnitCode = $('#avgUnit').val();
	var baseVolUnitCode = $('#baseVolUnit').val();
	unitCalculate(baseVolUnitCode, avgUnitCode);
}

function unitCalculate(fromCode, toCode) {
	var avgUnitConversion = $('#avgUnitConversion').val();
	if (fromCode == '' || toCode == '') {
		if (avgUnitConversion != '') {
			var baseVol = $.trim($('#baseVol').val());
			var numOfPackUnit = $.trim($('#numOfPackUnit').val());
			if (baseVol != '' && numOfPackUnit != '') {
				$('#avgMulti').val(
						eval(baseVol) * eval(numOfPackUnit)
								/ eval(avgUnitConversion));
			}
		}
	} else {
		if (fromCode == toCode) {
			$('#avgUnitConversion').val(1);
		}
		$.post(ctx + "/item/create/getAvgUnitConversion?fromCode=" + fromCode
				+ "&toCode=" + toCode, function(data) {
			if (data == '') {
				$('#avgUnitConversion').val('');
				$('#avgMulti').val('');
				return false;
			}
			$('#avgUnitConversion').val(data);
			var baseVol = $.trim($('#baseVol').val());
			var numOfPackUnit = $.trim($('#numOfPackUnit').val());
			if (baseVol != '' && numOfPackUnit != '') {
				$('#avgMulti').val(
						eval(baseVol) * eval(numOfPackUnit) / eval(data));
			}
		});
	}
}

// 课别属性选择框
function loadKebieAttrInputSelect(obj, dataList, divWidth) {
	$(obj).autocomplete(dataList, {
		minChars : 0,
		width : $.trim(divWidth) == '' ? $(this).attr('width') : divWidth,
		max : 3000,
		matchContains : true,
		matchCase : false,// 不区分大小写
		autoFill : false,
		dataType : 'json',
		formatItem : function(row, i, max) {
			return row.secAttrValNo + "-" + row.secAttrValName;
		},
		formatMatch : function(row, i, max) {
			return row.secAttrValNo;

		},
		formatResult : function(row) {
			return row.secAttrValNo;
		}

	}).result(function(event, data, formatted) { // 回调
		$(this).parent().parent().find('.attrVal').val(data.secAttrValName);
		$(this).parent().find('.attrId').val(data.secAttrId);
	});
}

function loadDownLoadDivByCode(obj, dataList, setValueObj, type) {
	$(obj).autocomplete(
			dataList,
			{
				minChars : 0,
				width : $(this).attr('width'),
				max : 3000,
				matchContains : true,
				matchCase : false,// 不区分大小写
				autoFill : false,
				dataType : 'json',
				formatItem : function(row, i, max) {
					return type && type == 0 ? row.title
							: (row.code + "-" + row.title);
				},
				formatMatch : function(row, i, max) {
					return row.code;

				},
				formatResult : function(row) {
					return row.code;
				}

			}).result(function(event, data, formatted) { // 回调
		if (data && setValueObj) {
			setValueObj.val(data.title);
		}
	});
}

function advertisConfirm() {
	var advAll = '';
	var error = '';
	$('.openDiv:last .advList').find('.ig').each(
			function(i) {
				var cnDesc = $.trim($(this).find('.cnDesc').val());
				var enDesc = $.trim($(this).find('.enDesc').val());
				if (cnDesc == '') {
					var num = i + 1;
					// commonAlert("请输入'广告语"+(num<10?'0'+num:num)+"'的中文广告语!",300,50,'新增商品');
					top
							.jAlert('warning',
									"请输入'广告语" + (num < 10 ? '0' + num : num)
											+ "'的中文广告语!", '消息提示');
					error = "请输入'广告语" + (num < 10 ? '0' + num : num)
							+ "'的中文广告语!";
					return false;
				}
				var inputValue = cnDesc + (enDesc == '' ? '' : ',') + enDesc;
				advAll = advAll + inputValue + ";";
			});
	advAll = advAll.substring(0, advAll.length - 1);
	if (error != '') {
		return false;
	}
	if (advAll != '') {
		$('#advShowList').val(advAll);
		$('#openHidDiv').html($('.openDiv:last').html());
	} else {
		$('#advShowList').val(advAll);
		// commonAlert("请输入广告语!",300,50,'新增商品');
		/*top.jAlert('warning', '请输入广告语!', '消息提示');
		return false;*/
	}
	closeAdvWindow();
}

function openAdvWindow(windowWidth, windowHeight) {
	var selector = $('.openDiv:last');
	var advShowList = $('#advShowList').val();
	var advAll = advShowList.split(";");
	var adList = $('.openDiv:last .advList').find('.ig');
	$('.openDiv:last .advList').html('');
	for (var i = 0; i < advAll.length; i++) {
		addAdvDataRow(0);
	}
	$('.openDiv:last .advList').find('.ig').each(function(i) {
		if (advAll[i]) {
			var ad = advAll[i].split(",");
			$(this).find('.cnDesc').val($.trim(ad[0]));
			$(this).find('.enDesc').val($.trim(ad[1]));
		}
	});
	$(selector).window({
		width : windowWidth,
		height : windowHeight,
		draggable : true,
		resizable : false,
		modal : true,
		shadow : false,
		border : false,
		noheader : true
	});
	$(selector).css("display", "block");
	$(selector).window("open");
	$(selector).parent().css('top', '10px');
	$('.openDiv').css("width",windowWidth);
	$('.openDiv.Panel').css("width",'955px');
	$('.openDiv').css("height",windowHeight);
	window.windowSelector = selector;
	bindPopButtonEvent();
}

function closeAdvWindow() {
	$('.openDiv:last').window("close");
	$(".grid_layer").hide();
}

/** 新增一行广告 */
function addAdvDataRow(addTag) {
	if(addTag!=0){
		if($('.openDiv:last .advList').find('.ig').size()==5){
			top.jAlert('warning', '广告数量不能超过5个!', '消息提示');
			return false;
		}
	}
	$('.openDiv:last .advList').append($('#itemAdvDiv').html());
	$('.openDiv:last .advList').find('.ig').each(function(i) {
		var num = i + 1;
		$(this).find('.adNo').html("" + (num < 10 ? "0" + num : num));
	});
}

/** 删除选择广告check-box */
function deleteAdvCheckbox(obj) {
	$(obj).find('input:checkbox').each(function() {
		var checked = $(this).attr('checked');
		if (checked == 'checked') {
			$(this).parent().remove();
		}
	});
	$('.openDiv .advList').find('.ig').each(function(i) {
		var num = i + 1;
		$(this).find('.adNo').html("" + (num < 10 ? "0" + num : num));
	});
}

function closeItemPopWindow() {
	try{
		closePopupWin();
	}catch(e){
		
	}
}
function setValueForInput() {
	var _i = 0;
	if ($.trim(inputValueArray) != '' && inputValueArray.length > 0) {
		if (_i < inputValueArray.length) {
			$('.openDiv:last').find('input.inputText').each(function() {
				$(this).val(inputValueArray[_i++]);
			});
		}
	}
}

// 弹出框
function openNewPopupItemWin(windowWidth, windowHeight) {
	if (chkStoreInfo()) {
		/*
		 * if($('#storeListDiv').find('.list_ex0').size()==1){
		 * copyFirstStoreDataInfo(); }
		 */

		$('#storeListDiv').append($('#storeListDftDiv').html());
		currtOpenObj_s5 = $('#storeListDiv').find('.list_ex0:last');
		currtOpenObj_s5.hide();
		var selector = $('.popupItemWin:last');
		$(selector).window({
			width : windowWidth,
			height : windowHeight,
			draggable : true,
			resizable : false,
			modal : true,
			shadow : false,
			border : false,
			noheader : true
		});
		// alert($(selector).html());
		$.ajaxSetup({
			async : false
		});
		$(selector).load(ctx + '/item/create/stepFivePanel');
		$.ajaxSetup({
			async : true
		});
		if ($('div[supNo="'+$('#majorSupNo').val()+'"]').size()==0) {
			$('#supNo').attr('disabled', 'disabled');
			var supNoObj = $('#supNo');
			$('#supNo').val($('#majorSupNo').val());
			getSupplierByInputSupplierId(supNoObj);
		}
		$(selector).css("display", "block");
		$(selector).window("open");
		$(selector).parent().css('top', '10px');
		// $(selector).window('refresh', ctx + actionUrl);
		grid_layer_close();
		window.windowSelector = selector;
		bindPopButtonEvent();
	}
}

function getMainSupInfoToNewInput(newObj) {
	var firstStoreInfoList = $('#storeInfoList').find('.storeInfo:first');
	var lastStoreInfoList = $('#storeInfoList').find('.storeInfo:last');
	lastStoreInfoList.find('.bnoName').val(
			firstStoreInfoList.find('.bnoName').val());
	lastStoreInfoList.find('.newSell').val(
			firstStoreInfoList.find('.newSell').val());
	lastStoreInfoList.find('.vat').val(firstStoreInfoList.find('.vat').val());
	lastStoreInfoList.find('.normBuyPrice').val(
			firstStoreInfoList.find('.normBuyPrice').val());
	lastStoreInfoList.find('.normSellPrice').val(
			firstStoreInfoList.find('.normSellPrice').val());
	lastStoreInfoList.find('.buyPriceLimit').val(
			firstStoreInfoList.find('.buyPriceLimit').val());
	lastStoreInfoList.find('.minSellPrice').val(
			firstStoreInfoList.find('.minSellPrice').val());
	lastStoreInfoList.find('.storeUpdtSpInd').val(
			firstStoreInfoList.find('.storeUpdtSpInd').val());
	lastStoreInfoList.find('.dcAttr').val(
			firstStoreInfoList.find('.dcAttr').val());
	var ordCreatMethd = firstStoreInfoList.find('.ordCreatMethd').val();
	lastStoreInfoList.find('.ordCreatMethd').val(ordCreatMethd);
	lastStoreInfoList.find('.oplCycle').val(
			firstStoreInfoList.find('.oplCycle').val());
	lastStoreInfoList.find('.rtnAllow').val(
			firstStoreInfoList.find('.rtnAllow').val());
	lastStoreInfoList.find('.ordMultiParm').val(
			firstStoreInfoList.find('.ordMultiParm').val());
	lastStoreInfoList.find('.upb').val(firstStoreInfoList.find('.upb').val());
	lastStoreInfoList.find('.rcvShelfLifeDays').val(
			firstStoreInfoList.find('.rcvShelfLifeDays').val());
	lastStoreInfoList.find('.speclBuyVatNo').val(
			firstStoreInfoList.find('.speclBuyVatNo').val());

	$('.item_create_5 .order').attr('checked', 'checked');

	$(lastStoreInfoList).find('.ordCreatMethds').each(function() {
		if (ordCreatMethd != '') {
			if (ordCreatMethd.indexOf($(this).val()) > -1) {
				$(this).attr('checked', 'checked');
			}
		}
	});
	/*
	 * var bnoName = currtOpenObj_s5.find('.bnoName').val(); var newSell =
	 * currtOpenObj_s5.find('.newSell').val(); var vat =
	 * currtOpenObj_s5.find('.vat').val(); var normBuyPrice =
	 * currtOpenObj_s5.find('.normBuyPrice').val(); var normSellPrice =
	 * currtOpenObj_s5.find('.normSellPrice').val(); var buyPriceLimit =
	 * currtOpenObj_s5.find('.buyPriceLimit').val(); var minSellPrice =
	 * currtOpenObj_s5.find('.minSellPrice').val(); var storeUpdtSpInd =
	 * currtOpenObj_s5.find('.storeUpdtSpInd').val(); var dcAttr =
	 * currtOpenObj_s5.find('.dcAttr').val(); var ordCreatMethd =
	 * currtOpenObj_s5.find('.ordCreatMethd').val(); var oplCycle =
	 * currtOpenObj_s5.find('.oplCycle').val(); var rtnAllow =
	 * currtOpenObj_s5.find('.rtnAllow').val(); var ordMultiParm =
	 * currtOpenObj_s5.find('.ordMultiParm').val(); var upb =
	 * currtOpenObj_s5.find('.upb').val(); var rcvShelfLifeDays =
	 * currtOpenObj_s5.find('.rcvShelfLifeDays').val();
	 */
}

function chkStoreInfo() {
	var inputOk = true;
	if (currtOpenObj_s5) {
		var supno = currtOpenObj_s5.attr('supNo');
		$('#storeInfoList .storeInfo:visible').find('.mustInput').each(
				function() {
					if ($.trim($(this).val()) == '') {
						if (!($(this).hasClass('errorInput'))) {
							$(this).addClass('errorInput');
						}
						inputOk = false;
					}
				});

		var ordCreatMethds = $('#storeInfoList .ordCreatMethds:visible:checked');
		if ($('#storeInfoList .ordCreatMethds:visible').size() != 0
				&& ordCreatMethds.size() == 0) {
			// commonAlert('请选择订货方式!',300,50,'新增商品');
			top.jAlert('warning', '请选择订货方式!', '消息提示');
			inputOk = false;
		}
	}

	return inputOk;
	/*
	 * if(currtOpenObj_s5){ // var bnoName =
	 * currtOpenObj_s5.find('.bnoName').val(); // var newSell =
	 * currtOpenObj_s5.find('.newSell').val(); // var vat =
	 * currtOpenObj_s5.find('.vat').val(); var supNo =
	 * currtOpenObj_s5.attr('supNo'); if($.trim(supNo)!=''){ var storedataDiv =
	 * $('#storeInfoList').find('.sup'+supNo); var normBuyPrice =
	 * storedataDiv.find('input.normBuyPrice').val();
	 * if($.trim(normBuyPrice)==''){ alert('请输入正常进价!'); return false; } var
	 * normSellPrice = storedataDiv.find('.normSellPrice').val();
	 * if($.trim(normSellPrice)==''){ alert('请输入正常售价 !'); return false; } // var
	 * buyPriceLimit = currtOpenObj_s5.find('.buyPriceLimit').val(); // var
	 * minSellPrice = currtOpenObj_s5.find('.minSellPrice').val(); var
	 * storeUpdtSpInd = storedataDiv.find('.storeUpdtSpInd').val();
	 * if($.trim(storeUpdtSpInd)==''){ alert('请选择门店变价 !'); return false; } var
	 * dcAttr = storedataDiv.find('.dcAttr').val(); if($.trim(dcAttr)==''){
	 * alert('请选择DC属性 !'); return false; } var ordCreatMethd =
	 * storedataDiv.find('.ordCreatMethd').val(); if($.trim(ordCreatMethd)==''){
	 * alert('请选择订货方式!'); return false; } var oplCycle =
	 * storedataDiv.find('.oplCycle').val(); if($.trim(oplCycle)==''){
	 * alert('请输入订货周期!'); return false; } var rtnAllow =
	 * storedataDiv.find('.rtnAllow').val(); if($.trim(rtnAllow)==''){
	 * alert('请选择可否退货!'); return false; } var ordMultiParm =
	 * storedataDiv.find('.ordMultiParm').val(); if($.trim(ordMultiParm)==''){
	 * alert('请输入订购倍数!'); return false; } var upb =
	 * storedataDiv.find('.upb').val(); if($.trim(upb)==''){ alert('请输入箱含量!');
	 * return false; } var rcvShelfLifeDays =
	 * storedataDiv.find('.rcvShelfLifeDays').val();
	 * if($.trim(rcvShelfLifeDays)==''){ alert('请输入允收天数 !'); return false; } } }
	 */
}

// 弹出框暂时不好用
function openPopupItemWin(windowWidth, windowHeight, obj) {
	selector = $('.popupItemWin:last');
	// var selector = "#popupItemWin";
	$(selector).window({
		width : windowWidth,
		height : windowHeight,
		draggable : true,
		resizable : false,
		modal : true,
		shadow : false,
		border : false,
		noheader : true
	});
	$.ajaxSetup({
		async : false
	});
	$(selector).load(ctx + '/item/create/stepFivePanel');
	$.ajaxSetup({
		async : true
	});
	var supNoObj = $('#supNo');
	$('#supNo').attr('disabled', 'disabled');
	$('#supNo').val($(obj).attr('supNo'));
	$.ajaxSetup({
		async : false
	});
	getSupplierByInputSupplierId(supNoObj, "Y");
	$.ajaxSetup({
		async : true
	});
	$('#updataTag').val('Y');
	$(selector).css("display", "block");
	$(selector).window("open");
	$(selector).parent().css('top', '10px');
	// $(selector).window('refresh', ctx + actionUrl);
	window.windowSelector = selector;
	bindPopButtonEvent();
}

function bindPopButtonEvent() {
	$('.popupItemWin:last').find('.PanelClose').attr('onClick',
			'cancleOperate()');
	$('.popupItemWin:last').find('.PanelBtn2').attr('onClick',
			'cancleOperate()');
	$('.popupItemWin:last').find('.PanelBtn1').attr('onClick',
			'savePopupItemWinData()');
}

function cancleOperate() {
	try{
		closePopupItemWin();
	}
	catch(e){
		
	}
	if ($.trim(currtOpenObj_s5) != '') {
		var updataTag = $('#updataTag').val();
		if (updataTag != 'Y') {
			$(currtOpenObj_s5).remove();
		}
	}
}

// 关闭弹出框
function closePopupItemWin() {
	var selector = $('.popupItemWin:last');
	// $("#popupItemWin").html('');
	if ($.trim(selector) != '') {
		// alert($(selector).parent().find('.selectStoreObj').val());
		$(selector).window("close");
		$("#grid_layer").hide();
	}
}

function showCurrtDiv() {
	if(currtOpenObj_s5.index()==-1){
		currtOpenObj_s5=$('#storeListDiv').find('.list_ex0:first');
	}
	var list_ex0_on = $('.list_ex0_on');
	list_ex0_on.removeClass('list_ex0_on');
	list_ex0_on.find('.list_ex2').hide();
	currtOpenObj_s5.addClass('list_ex0_on');
	currtOpenObj_s5.find('.list_ex2').show();
	$('.storeInfo').hide();
	$('#storeInfoList .storeInfo:eq('+ currtOpenObj_s5.index() + ')').show();
	nullInputCheck();
}

/** 弹出框按确定 */
function savePopupItemWinData() {
	if (!checkItemSupPopForm()) {
		return false;
	}
	var selectStoreObjData = currtOpenObj_s5.find('.selectStoreObjData');
	if ($.trim($(selectStoreObjData).val()) == '') {
		currtOpenObj_s5.show();
	}
	$(selectStoreObjData).val($('#step5PanelForm:visible').serialize());
	var ckObjList = $('#step5PanelForm:visible').find(
			'.selectedInput:visible:checked');
	var str = '';
	var storeNo = '';
	for (var i = 0; i < ckObjList.length; i++) {
		str += (i == 0 ? "" : '、') + $(ckObjList[i]).val()+"-"
				+ $(ckObjList[i]).attr('tagNameTitle');
		storeNo += $(ckObjList[i]).val() + ',';
	}
	var allStoreNoList = $('#allStoreNoList');
	var allStoreNos = allStoreNoList.val();

	var storeNos = $(currtOpenObj_s5).attr('storeNos');

	if ($.trim(storeNos) != '') {
		if (allStoreNos.indexOf(storeNos) == 0) {
			allStoreNos = allStoreNos.replace(allStoreNos, '');
		} else if (allStoreNos.indexOf(storeNos) > 0) {
			allStoreNos = allStoreNos.replace(',' + storeNos, ',');
		}
	}
	allStoreNoList.val(allStoreNos + storeNo);
	var list_ex21 = currtOpenObj_s5.find('.list_ex21');
	list_ex21.html('<div align="left" style="padding:5px;">' + str + '</div>');
	list_ex21.height('auto');
	list_ex21.parent().height(list_ex21.height() + 10);
	if (list_ex21.parent().height() == 10) {
		list_ex21.parent().height('auto');
	}
	currtOpenObj_s5.attr("supNo", $('#supNo').val());
	currtOpenObj_s5.attr("storeNos", storeNo);
	var updataTag = $('#updataTag').val();
	if (updataTag != 'Y') {
		addStoreDataInfo();
	}
	nullInputCheck();
	inputToInputIntNumber();
	inputToInputDoubleNumber();
	inputToInputDoubleNumberAndChkLen($('.storeInfo'));
	$('#storeInfoList').find('.storeInfo:eq('+currtOpenObj_s5.index()+")").find('.supStoreNoList').val(
			currtOpenObj_s5.attr('storeNos'));
	$('#storeInfoList').find('.storeInfo:eq('+currtOpenObj_s5.index()+")").find('.stMainSupNo').val(
			currtOpenObj_s5.attr('supNo'));
	$('#storeInfoList').find('.storeInfo:visible .bnoName').val($('#step5PanelForm .bnoName').val());
	$('#storeInfoList').find('.storeInfo:visible select.bnoName').attr('disabled','disabled');
	$('.item_create_5 input,select').each(function(){
		$(this).change(function(){
			setSubmitStatus();
		});
	});
	if (updataTag != 'Y') {
		if($('#supNo').attr('dc')=='1'){
			$('#storeInfoList .itemStoreInfo:last .dcAttr option[value="0"]').remove();
		}
		else{
			$('#storeInfoList .itemStoreInfo:last .dcAttr option:not([value="0"])').remove();
		}
	}
	setSubmitStatus();
	if($('#storeInfoList .itemStoreInfo').size()==1 && updataTag != 'Y'){
		$('.normBuyPrice:visible').val($('#stdBuyPrice').val());
		$('.normSellPrice:visible').val($('#stdSellPrice').val());
	}
	
	closePopupItemWin();
}

function checkItemSupPopForm() {
	var supNo = $('#supNo').val();
	var supplierName = $('.supplierName').val();
	var ckObjList = $('#step5PanelForm:visible').find('.selectedInput:visible:checked');
	if ($.trim(supNo) == '' || $.trim(supplierName) == '') {
		top.jAlert('warning', '请选择一个供应商!', '消息提示');
		return false;
	}
	if (ckObjList.length < 1) {
		top.jAlert('warning', '请选择一个门店!', '消息提示');
		return false;
	}
	var allStoreNoList = $('#allStoreNoList').val();
	var updataTag = $('#updataTag').val();
	for (var i = 0; i < ckObjList.length; i++) {
		var ckStore = $(ckObjList[i]).val();
		if (updataTag != 'Y'
				&& ckStore != ''
				&& allStoreNoList != ''
				&& (allStoreNoList.indexOf(ckStore + ',') == 0 || allStoreNoList
						.indexOf(',' + ckStore + ',') > 0)) {
			top.jAlert('warning', '已选择该门店', '消息提示');
			return false;
		}
	}
	return true;
}

function copyFirstStoreDataInfo() {
	$('#storeInfoModelDiv')
			.html($('#storeInfoList').find('.storeInfo').clone());
	var list_ex0Info = $('#storeListDiv').find('.list_ex0:last');
	list_ex0Info.attr('index', (itemStoreNo + 1));
	list_ex0Info.addClass('store' + (itemStoreNo + 1));
	$('#storeInfoList').find('.storeInfo:last').addClass(
			'store' + (itemStoreNo + 1));
	// modifyStoreInfoInputName();
}

/** 新增一个厂商 */
function addStoreDataInfo() {
	var storeInfoList = $('#storeInfoList').html();
	$('#storeInfoList').append($('#storeInfoModelDiv').html());
	if ($.trim(storeInfoList) != '') {
		// modifyStoreInfoInputName();
		$('.storeInfo').hide();
		var lastStoreInfo = $('#storeInfoList').find('.storeInfo:last');
		lastStoreInfo.attr('class', 'storeInfo');
		lastStoreInfo.show();
		var list_ex0Info = $('#storeListDiv').find('.list_ex0:last');
		// list_ex0Info.find('.Tools12').click();
		list_ex0Info.attr('index', (itemStoreNo));
		list_ex0Info.addClass('store' + (itemStoreNo));
		lastStoreInfo.addClass('store' + (itemStoreNo));
		list_ex0Info.attr("supNo", $('#supNo').val());
		list_ex0Info.addClass('sup' + $('#supNo').val());
		currtOpenObj_s5 = list_ex0Info;
	} else {
		$('#storeListDiv').find('.list_ex0:first').find('.Tools10').remove();
	}
	$('#storeListDiv').find('.list_ex0:last').addClass(
			'sup' + $('#supNo').val());
	$('#storeInfoList').find('.storeInfo:last').addClass(
			'sup' + $('#supNo').val());
	getMainSupInfoToNewInput();
	currtOpenObj_s5.click();
	// $(obj).find('.advLabel').append('<span
	// class="adNo">'+itemStoreNo+'</span>');
}

function changeOrdCreatMethd(obj) {
	var ordCreatMethds = '';
	$(obj).parent().find('.ordCreatMethds:checked').each(function() {
		if (ordCreatMethds != '') {
			ordCreatMethds += ',';
		}
		ordCreatMethds += $(this).val();
	});
	$(obj).parent().find('.ordCreatMethd').val(ordCreatMethds);
	;
}

/** 新增一个非主厂商 */
function addOtherSupInfo() {
	$('#otherSupListDiv').append($('#otherSupDiv').html());
	nullInputCheck();
	inputToInputIntNumber();
	$('.otherSup').each(function(){
 		$(this).unbind('keydown').keydown(function (e) {
            if (e.keyCode == 13) {
            	getOtherSupplier($(this));
            }
        });
 	});
	$('.item_create_5 input,select').each(function(){
		$(this).change(function(){
			setSubmitStatus();
		});
	});
	setSubmitStatus();
	$('#otherSupListDiv').scrollTop($('#otherSupListDiv .otherSupForm:last').offset().top);
}

function modifyStoreInfoInputName() {
	var currStoreInfoList = $('#storeInfoList').find('.storeInfo:last');
	currStoreInfoList.find('input').each(function() {
		var objName = $(this).attr('name');
		$(this).attr('name', storePrev + '[' + (itemStoreNo) + '].' + objName);
	});
	currStoreInfoList.find('select').each(function() {
		var objName = $(this).attr('name');
		$(this).attr('name', storePrev + '[' + (itemStoreNo) + '].' + objName);
	});
	currtOpenObj_s5 = $('#storeListDiv').find('.list_ex0:last');
	itemStoreNo++;
}

// 还原属性
function reModifyStoreInfoInputName() {
	var currStoreInfoList = $('#storeInfoList').find('.storeInfo:last');
	currStoreInfoList.attr('class', 'storeInfo');
	currStoreInfoList.find('input').each(function() {
		var objName = $(this).attr('name');
		$(this).attr('name', objName.substr(objName.indexOf('.') + 1));
	});
	currStoreInfoList.find('select').each(function() {
		var objName = $(this).attr('name');
		$(this).attr('name', objName.substr(objName.indexOf('.') + 1));
	});
	currtOpenObj_s5 = $('#storeListDiv').find('.list_ex0:last');
	currtOpenObj_s5.attr('class', 'list_ex0');
	itemStoreNo = 0;
}
function deleteStoreInfo(obj) {
	$.ajaxSetup({
		async : false
	});
	var allStoreNoList = $('#allStoreNoList').val();
	var storeNos = obj.attr('storeNos');
	if (allStoreNoList.indexOf(storeNos) == 0) {
		allStoreNoList = allStoreNoList.replace(storeNos, '');
	} else {
		allStoreNoList = allStoreNoList.replace("," + storeNos, ",");
	}
	$('#storeInfoList .storeInfo:eq('+ $('#storeListDiv .list_ex0').index(obj) + ')').remove();
	$(obj).remove();
	$('#allStoreNoList').val(allStoreNoList);
	currtOpenObj_s5 = $('#storeListDiv').find('.list_ex0:first');
	showCurrtDiv();
	$.ajaxSetup({
		async : true
	});
	setSubmitStatus();
}

// 通过供应商Id获取供应商名
function getSupplierByInputSupplierId(obj, updataTag) {
	var supNo = $(obj).val();
	var isDcSup = 0;
	var kebieInput2 = $('#kebieInput2').val();
	if ($.trim(supNo) == '') {
		return false;
	}
	if ($('.otherSup[othSupNo="' + supNo + '"]').size() > 0) {
		// commonAlert('该厂商已设为非主厂商!',300,50,'新增商品');
		top.jAlert('warning', '该厂商已设为非主厂商!', '消息提示');
		$(obj).val('');
		return false;
	}
	//获取供应商及下传区域树
	$.post(ctx + "/item/create/getSupRegion?supNo="+supNo + "&catlgId=" + kebieInput2,function(data){
		if(data.status=='success'){
			$(obj).attr('dc',data.isDcSup);
			var supplierName = $(obj).parent().parent().find('.supplierName');
			supplierName.val(data.supplier.comName);
			isDcSup = data.isDcSup;
			var internalInd = data.supplier.internalInd;
			currtOpenObj_s5.find('.list_ex12').text(supNo+"-"+supplierName.val());
			var supStoreNos=currtOpenObj_s5.attr('storenos');
			var allStoreNoList = $('#allStoreNoList').val();
			if(allStoreNoList.indexOf(supStoreNos)==0){
				allStoreNoList = allStoreNoList.replace(supStoreNos,'');
			}
			else if(allStoreNoList.indexOf(','+supStoreNos)>0){
				allStoreNoList = allStoreNoList.replace(','+supStoreNos,',');
			}
			$('#dcCenterDiv').empty();
			$('#machinDiv').empty();
			//获取供应商下传门店(当前商品已选择的下传门店不再显示)
			$.post(ctx + "/item/create/getStoreList?supNo="+supNo+"&regnNoList="+1+"&internalInd="+internalInd,function(data){
				if(data){
					var allStr = '';
					var dcCenterDivStr = '';
					var machinDivStr = '';
					$.each(data, function(index, value) {
						if(!(allStoreNoList.indexOf(value.storeNo+',')==0||allStoreNoList.indexOf(','+value.storeNo+',')>0)){
							if(value.bizType==8){
								dcCenterDivStr+='<div class="item2 '+value.assrtId+'"><label>';
								dcCenterDivStr+='<input type="checkbox" class="selectedInput" onclick="checkedOrUncheckedInputToAllInput($(this));" name="a" tagNameTitle="'+value.storeName+'" value="'+value.storeNo+'">';
								dcCenterDivStr+='</label><span>'+value.storeName+'-'+value.storeNo+'</span></div>';
							}
							else if(value.bizType==7){
								machinDivStr+='<div class="item2 '+value.assrtId+'"><label>';
								machinDivStr+='<input type="checkbox" class="selectedInput" onclick="checkedOrUncheckedInputToAllInput($(this));" name="d" tagNameTitle="'+value.storeName+'" value="'+value.storeNo+'">';
								machinDivStr+='</label><span>'+value.storeName+'-'+value.storeNo+'</span></div>';
							}
						}else{
							if(value.bizType==7){
								itemDcSelected=1;
							}
						}
						});
					if($('#dcCenterDiv').is(':empty')){
						$('#dcCenterDiv').append(dcCenterDivStr);
					}
					if($('#machinDiv').is(':empty')){
						$('#machinDiv').append(machinDivStr);
					}
					setInputAttrValue(isDcSup,kebieInput2);
				}
			});
			//区域树
			$.ajaxSetup({async : false});
			$('#tt').tree({
				checkbox : true,
				data : data.tree,
				onClick : function(node) {
				},
				onCheck : function(node,checked) {
					var pn1 = $('#tt').tree('getParent', node.target);
					var pn2=null,pn3=null;
					var nodeLvl=1;
					if(pn1!=null){
						nodeLvl=2;
						pn2 = $('#tt').tree('getParent', pn1.target);
						if(pn2!=null){
							nodeLvl=3;
							pn3 = $('#tt').tree('getParent', pn2.target);
							if(pn3!=null){
								nodeLvl=4;
							}
						}
					}
					var nodes = $('#tt').tree('getChildren', node.target);
					if(checked){
						var disabledNodes = $('.tree-node[disable="disabled"]');
						var _str = '';
						if(nodes.length>0){
							for(var i=0;i<nodes.length;i++){
								var breakFlag = false;
								for(var j=0;j<disabledNodes.size();j++){
									var nodeId = $(disabledNodes[j]).attr('node-id');
									if(nodeId==nodes[i].id){
										breakFlag = true;
										break;
									}
								}
								if(breakFlag){
									continue;
								}
								_str = _str +","+ nodes[i].id;
							}
						}
						else{
							_str = _str +","+ node.id;
						}
						_str = _str.substr(1);
						if($.trim(_str)==''){
							return;
						}
						//获取供应商下传门店(当前商品已选择的下传门店不再显示)
						$.post(ctx + "/item/create/getStoreList?supNo="+supNo+"&regnNoList="+_str+"&internalInd="+internalInd,function(data){
							if(data){
								var allStr = '';
								var storeDivStr = '';
								var dcCenterDivStr = '';
								var machinDivStr = '';
								$.each(data, function(index, value) {
									if(!(allStoreNoList.indexOf(value.storeNo+',')==0||allStoreNoList.indexOf(','+value.storeNo+',')>0)){
										if(value.bizType==1 && $('#storeDiv .'+value.assrtId).size()==0){
											storeDivStr+='<div class="item2 '+value.assrtId+'"><label>';
											storeDivStr+='<input type="checkbox" class="selectedInput" onclick="checkedOrUncheckedInputToAllInput($(this));" name="n" tagNameTitle="'+value.storeName+'" value="'+value.storeNo+'">';
											storeDivStr+='</label><span>'+value.storeName+'-'+value.storeNo+'</span></div>';
										}
									}else{
										if(value.bizType==7){
											itemDcSelected=1;
										}
									}
									});
								$('#storeDiv').append(storeDivStr);
							}
						});
					}
					else{
						if(nodes.length>0){
							for(var i=0;i<nodes.length;i++){
								$('#storeDiv .'+nodes[i].id).remove();
							}
						}
						else{
							$('.'+node.id).remove();
						}
						if($('#storeDiv .item2').size()==0){
							$('#storeDiv').next().find('input:checkbox').removeAttr('checked');
						}
					}
				
				}
				
			});
			//red_bno_node
			if(bnoResult!=null){
				changeNodeBNOResult();
			}

			$.ajaxSetup({async : true});
		}
		else{
			$('#supNo').val('');
			$('.supplierName').val('');
			top.jAlert('warning', '供应商不存在!', '消息提示');
		}
	});
	$(obj).attr('preval2',$(obj).val());
}

function setInputAttrValue(isDcSup,kebieInput2){
	if(isDcSup==0){
		$('.dcSupAttr').attr("disabled","disabled");
		$('#machinDiv input:checkbox').attr("disabled","disabled");
		//$('.dmcAttr').removeAttr("disabled");
		$('#storeDiv input:checkbox').removeAttr("disabled");
		$('.jgCsAttr').removeAttr("disabled");
		$('#dcCenterDiv input:checkbox').removeAttr("disabled");
	}
	else{
		$('.dcSupAttr').removeAttr("disabled");
		$('#machinDiv input:checkbox').removeAttr("disabled");
		//$('.dmcAttr').attr("disabled","disabled");
		$('#storeDiv input:checkbox').attr("disabled","disabled");
		$('.jgCsAttr').attr("disabled","disabled");
		$('#dcCenterDiv input:checkbox').attr("disabled","disabled");
	}
	if(kebieInput2!='' && kebieInput2=='128'){
		$('#dcCenterDiv input').removeAttr("disabled");
		$('#dcCenterDiv input').attr("readonly","readonly");
		$('#dcCenterDiv input').attr("checked","checked");
		$('#dcCenterDiv input').click(function(){$(this).attr("checked","checked");});
		$('.jgCsAttr').removeAttr("disabled","disabled");
		$('.jgCsAttr').attr("checked","checked");
		$('.jgCsAttr').attr("readonly","readonly");
	}
	else{
		$('.jgCsAttr').removeAttr("checked");
		$('#dcCenterDiv input').removeAttr("checked");
		$('#dcCenterDiv input').attr("disabled","disabled");
		$('.jgCsAttr').attr("disabled","disabled");
	}
}

function changeNodeBNOResult(){
	var bnoName = $('#step5PanelForm .bnoName').val();
	$('.disChk').remove();
	$('#tt').find('.tree-checkbox-d').addClass('tree-checkbox').removeClass('tree-checkbox-d');
	$('#tt li').removeAttr('title');
	$('#tt .red_bno_node').removeClass('red_bno_node');
	$('#tt .tree-node').removeAttr('disable');
	if(bnoName==''){
		bnoName='B';
	}
	if($('#clstrType').val()=='1'){
		return false;
	}
	$.each(bnoResult,function(i){
		var disChk = '<input type="checkbox" style="margin-top:8px;" class="tree-checkbox1 disChk" disabled="disabled">';
		if(this[""+bnoName]!=''){
			$('#tt .tree-node[node-id="'+i+'"]').parent().attr('title',"本区域以下门店"+bnoName+"属性超出:"+this[""+bnoName]);
			$('#tt .tree-node[node-id="'+i+'"]').parent().addClass('red_bno_node');
			$('#tt .tree-node[node-id="'+i+'"]').parent().find('.tree-checkbox').addClass('tree-checkbox-d').after(disChk).removeClass('tree-checkbox');
			$('#tt .tree-node[node-id="'+i+'"]').parent().find('.tree-node').each(function(){
				$(this).attr('disable','disabled');
			});
		}
		else{
			$(this).removeAttr('disable');
		}
	});
	 
	$('#storeDiv .item2').show();
	var disabledNodes = $('.tree-node[disable="disabled"]');
	for(var j=0;j<disabledNodes.size();j++){
		var nodeId = $(disabledNodes[j]).attr('node-id');
		$('#storeDiv .'+nodeId).hide();
	}
}

function getOtherSupplier(obj) {
	var _otherSupNo = obj.val();
	if(isNaN(_otherSupNo)){
		return false;
	}
	if (_otherSupNo == '') {
		return false;
	}
	$(obj).attr('othSupNo',_otherSupNo);
	var index=obj.parent().parent().parent().index();
	var existSup = 0;
	$('#otherSupListDiv .otherSupForm:not(:eq('+index+')) .otherSup').each(function(){
		if($(this).val()==_otherSupNo){
			existSup++;
		}
	});
	//alert(existSup.size());
	//alert('.otherSup[othSupNo="' + _otherSupNo + '"][value="' + _otherSupNo + '"]:not(:eq('+obj.parent().parent().parent().index()+'))');
	var list_ex0List = $('.list_ex0[supNo="' + _otherSupNo + '"]');
	var majorSupNo = $('#majorSupNo').val();
	var catlgId = $('#kebieInput2').val();
	if (_otherSupNo==majorSupNo) {
		top.jAlert('warning', '该供应商已选为商品主厂商,不能选为非主厂商!', '消息提示');
		obj.val('');
		obj.parent().parent().find('input').val('');
		return false;
	}
	if (existSup > 0 || list_ex0List.size() > 0) {
		top.jAlert('warning', '您已选择了该供应商!', '消息提示');
		obj.val('');
		obj.parent().parent().find('.comNo').val('');
		obj.parent().parent().find('.comName').val('');
		return false;
	}
	$(obj).attr('preval2','');
	if($(obj).attr('preval2')!=$(obj).val()){
		$.post(
			ctx + "/item/create/getSupRegion?isOtherSup=1&supNo="
					+ $(obj).val() + "&catlgId=" + catlgId, function(data) {
				if(data.status=='success'){
					// alert(data.supplier.supComVO.comNo);
					$(obj).parent().parent().find('.comNo').val(
							data.supplier.comNo);
					$(obj).attr('othSupNo',_otherSupNo);
					$(obj).parent().parent().find('.comName').val(
							data.supplier.comName);
					$(obj).parent().parent().children().removeClass('errorInput');
					obj.attr('preval2',_otherSupNo);
				}
				else{
					top.jAlert('warning', '供应商不存在!', '消息提示');
					obj.val('');
					obj.parent().parent().find('.comNo').val('');
					obj.parent().parent().find('.comName').val('');
				}
			});
	}
}

function getItemBrandById(obj) {
	var _itemBrandId = obj.val();
	if(isNaN(_itemBrandId)){
		return false;
	}
	if (_itemBrandId == '') {
		return false;
	}

	obj.attr('preval2','');
	$.post(
			ctx + "/item/create/getBrandByBrandNo?brandId="
					+ $(obj).val(), function(data) {
				if(data.status=='success'){
					$(obj).parent().parent().find('#brandName').attr('value',
							data.brand.brandName);
					$(obj).parent().parent().children().removeClass('errorInput');
					obj.attr('preval2',_itemBrandId);
				}
				else{
					top.jAlert('warning', data.message, '消息提示');
					obj.val('');
					obj.parent().parent().find('#brandName').val('');					
				}
			});
}

function getMajorSupplier(obj) {
	
	var _itemMajorSup = obj.val();
	if(isNaN(_itemMajorSup)){
		return false;
	}
	if (_itemMajorSup == '') {
		return false;
	}

	obj.attr('preval2','');
	$.post(
			ctx + "/item/create/getSupRegion?supNo="+_itemMajorSup, function(data) {
				if(data.status=='success'){
					$(obj).parent().parent().find('#supName').attr('value',
							data.supplier.comName);
					$(obj).parent().parent().children().removeClass('errorInput');
					obj.attr('preval2',_itemMajorSup);
					setMajorSupplierExternInfo(data.supplier);
					$('#clstrdisplay').val('');
				}
				else{
					top.jAlert('warning', data.message, '消息提示');
					obj.val('');
					obj.parent().parent().find('#supName').val('');					
				}
			});
}

function setMajorSupplierExternInfo(supplier) {
	var supno = supplier.supNo;
	var internalInd = supplier.internalInd;
	var cntrtType = supplier.cntrtType;
	if (supno != null) {
		$('#chubieInput').removeClass('errorInput');
		$('#kebieInput').removeClass('errorInput');
		$('.sellVatNo').removeClass('errorInput');
		$('.buyVatNo').removeClass('errorInput');
		var buyMethd = $('#buyMethd');
		
		if($.trim(cntrtType)!=''){
			$('#buyPerd').attr('value',cntrtType);
			$('#buyPerd').removeClass('errorInput');
		}
		
		//getSupDivSecInfo
		$.post(ctx + '/item/create/getSupDivSecInfo?supNo='+supno, function(data) {
			if(!data || !data.divNo || internalInd==1){
				$('#chubieInput').unautocomplete();
				$('#kebieInput').unautocomplete();
				$('#dafenleiInput').unautocomplete();
				$('.ac_results').empty();
				chubieInputSelect2(ctx + "/item/create/getDivisions");
				kebieInputSelect2(ctx + '/item/create/getSectionAction?divisionId='+$('#chubieInput2').val());
			  /*chubieInputSelect2(ctx + "/catalog/groupShowDivisionsAction");
				kebieInputSelect2(ctx + '/catalog/groupShowSectionAction?divisionId='+$('#chubieInput2').val());*/
				ctx + $('#kebieInput').attr('currurl')+ data.catlgId;
				$('#clstrdisplay').val('');
				$('#kebieInput').attr('currurl','/item/create/getSectionAction?divisionId=');
				$('#chubieInput').val('');
				$('#chubieInput2').val('');
				$('#kebieInput').val('');
				$('#kebieInput2').val('');
				$('#dafenleiInput').val('');
				$('#dafenleiInput2').val('');
				$('#zhongfenleiInput').val('');
				$('#zhongfenleiInput2').val('');
				$('#xiaofenleiInput').val('');
				$('#xiaofenleiInput2').val('');
				setCatlgWarn($('#xiaofenleiInput2').val());
				return false;
			}
			$('#chubieInput').val(data.divNo+"-"+data.divName);
			$('#chubieInput2').val(data.divNo);
			$('#kebieInput').val(data.secNo+"-"+data.secName);
			$('#kebieInput2').val(data.secNo);
			chubieInputSelect(ctx + "/item/create/getSupDivList?supNo="+supno);
			$('#kebieInput').attr('currurl','/item/create/getSupSecList?supNo='+supno+'&divisionId=');
			kebieInputSelect(ctx+$('#kebieInput').attr('currurl')+$('#chubieInput2').val());
			dafenleiInputSelect(ctx+$('#dafenleiInput').attr('currurl')+$('#kebieInput2').val() );
			$('#dafenleiInput').val('');
			$('#dafenleiInput2').val('');
			$('#zhongfenleiInput').val('');
			$('#zhongfenleiInput2').val('');
			$('#xiaofenleiInput').val('');
			$('#xiaofenleiInput2').val('');
			setCatlgWarn($('#xiaofenleiInput2').val());
		});

		if (buyMethd.size()>0) {
			getBuyMethodsBySupplierId(supno,internalInd);
		}

		setBuyPerdParameter(cntrtType);
	}
}

function getSpeclGrpCtrl(midClId) {
	$('#speclGrpCtrl').val('');
	$.post(ctx + "/item/create/getSpeclGrpCtrl?catlgId=" + midClId, function(
			data) {
		if(data.midGrpCtrl != null){
			$('#speclGrpCtrl').val(data.midGrpCtrl.speclGrpCtrl);
			$('#item_create_1 .buyVatNo').val(data.midGrpCtrl.buyVatNo);
			$('#item_create_1 .sellVatNo').val(data.midGrpCtrl.sellVatNo);
		}
		$('#itemType').empty();
		$('#prcssType').empty()
		$('#itemPack').empty()
		var optionStr = '<option value="">请选择</option>';
		$('#itemType').append(optionStr);
		$('#prcssType').append(optionStr);
		$('#itemPack').append(optionStr);
		//origCtrlList speclGrpCtrl
		var ctrlText = $('#origCtrlList option[value="'+$('#speclGrpCtrl').val()+'"]').text();
		$('#displaySpeclCtrl option:first').text(ctrlText==''?"9-其他":ctrlText);
		getNextMetaData();
	});
}

function getStdShelfLifeDays() {
	var stdShelfLifePerd = $('#stdShelfLifePerd').val();
	var perdUnitName = $('#perdUnitName').val();
	if (stdShelfLifePerd == '' || perdUnitName == '') {
		$('#stdShelfLifeDays').val('');
		return false;
	}
	switch (perdUnitName) {
	case '3':
		$('#stdShelfLifeDays').val(365 * eval(stdShelfLifePerd));
		break;
	case '2':
		$('#stdShelfLifeDays').val(30 * eval(stdShelfLifePerd));
		break;
	case '1':
		$('#stdShelfLifeDays').val(stdShelfLifePerd);
		break;
	}
	if($('#stdShelfLifeDays').val().length>4){
		top.jAlert('warning', '保质期天数太大!', '消息提示',function(retval){
			if(retval){
				$('#stdShelfLifePerd').val('');
				$('#stdShelfLifeDays').val('');
			}
		});
	}
}

function compareObj(obj1, obj2) {
	if (obj1.val() > obj2.val()) {
		obj2.val(obj1.val());
	}
}

function initSeTopicInfo() {
	var seTopicIds = $('#seTopicIds').val();
	var seTopicName = $('#seTopicName').val();
	$('#seTopicIds1').val(seTopicIds == '' ? "," : (',' + seTopicIds + ','));
	$('#seTopicName1').val(seTopicName == '' ? "," : (',' + seTopicName + ','));
}

function caculateTiji(obj) {
	var layer = obj.find('#layer').val();
	var width = obj.find('#width').val();
	var depth = obj.find('#depth').val();
	obj.find('#tiji').val(eval(layer) * eval(width) * eval(depth));
	if(obj.find('#tiji').val()=='NaN'){
		obj.find('#tiji').val('');
	}
}

function closeCreateItem() {
	$('#content').load(ctx + '/item/query/itemBaseInfo');
	/*
	 * $(".tagsM_q,.tags3_close_on").remove();
	 * $(".tags3").addClass("tags3_r_on");
	 * $(".tags3").removeClass("tags_right_on");
	 * $(".tags3").addClass("tags3_r_off");
	 * $(".tags1_left").addClass("tags1_left_on");
	 * $(".tags1_left").next().addClass("tagsM_on");
	 * $(".tags1_left").next().next().addClass("tags_left_on");
	 * $('.Content').hide(); $('.Content:eq(0)').show();
	 */
}

// 根据购买期限决定季节期数和有效期间
function setBuyPerdParameter(buyPerd) {
	$('#seTopicIds').removeClass('errorInput');
	$('#seTopicName').removeClass('errorInput');
	$('#endDate').removeClass('errorInput');
	$('#startDate').removeClass('errorInput');
	if (buyPerd == 1 || buyPerd == '') {
		$('#seTopicIds').val('');
		$('#seTopicIds').attr('disabled', 'disabled');
		$('#seTopicName').attr('disabled', 'disabled');
		$('#seTopicIds').css('background-color', '#ccc');
		$('#seTopicName').css('background-color', '#ccc');
		$('#seTopicIds').next().attr('onclick', '');
		$('#seTopicName').val('');
		$('#seTopicIds').removeClass('mustInput');
		$('#seTopicName').removeClass('mustInput');
		if($('#buyMethd').val()!='3'){
			$('#endDate').val('');
			$('#startDate').val('');
			$('#endDate').attr('disabled', 'disabled');
			$('#startDate').attr('disabled', 'disabled');
			$('#startDate').css('background-color', '#ccc');
			$('#endDate').css('background-color', '#ccc');
		}
		$('#endDate').removeClass('mustInput');
		$('#startDate').removeClass('mustInput');
	} else if (buyPerd == 2) {
		$('#seTopicIds').next().attr('onclick',
				'initSeTopicInfo();openSEWindow();');
		$('#seTopicIds').removeAttr('disabled');
		$('#seTopicName').removeAttr('disabled');
		$('#seTopicIds').css('background-color', '#fff');
		$('#seTopicName').css('background-color', '#fff');
		$('#seTopicIds').addClass('mustInput');
		$('#seTopicName').addClass('mustInput');
		if($('#buyMethd').val()!='3'){
			$('#endDate').val('');
			$('#startDate').val('');
			$('#endDate').attr('disabled', 'disabled');
			$('#startDate').attr('disabled', 'disabled');
			$('#startDate').css('background-color', '#ccc');
			$('#endDate').css('background-color', '#ccc');
		}
		$('#endDate').removeClass('mustInput');
		$('#startDate').removeClass('mustInput');
	} else if (buyPerd == 3) {
		$('#seTopicIds').val('');
		$('#seTopicIds').attr('disabled', 'disabled');
		$('#seTopicName').attr('disabled', 'disabled');
		$('#seTopicIds').css('background-color', '#ccc');
		$('#seTopicName').css('background-color', '#ccc');
		$('#seTopicIds').next().attr('onclick', '');
		$('#seTopicName').val('');
		$('#seTopicIds').removeClass('mustInput');
		$('#seTopicName').removeClass('mustInput');
		$('#startDate').removeAttr('disabled');
		$('#endDate').removeAttr('disabled');
		$('#startDate').css('background-color', '#fff');
		$('#endDate').css('background-color', '#fff');
		$('#startDate').addClass('mustInput');
		$('#endDate').addClass('mustInput');
	}
}

// barcode校验
function validate_barcode(obj) {
	var result = chk_barcode_valid(obj.val());
	
	if (result == -1) {
		obj.addClass('errorInput');
		obj.attr('title','条码格式不正确');
		return false;
	} else {
		obj.removeClass('errorInput');
		obj.removeAttr('title');
		obj.val(result);
	}
	
	if(!validate_barcodeIsExist(obj))
	{
		return false;
	}
	
	return true;
}

//barcode重复校验
function validate_barcodeIsExist(obj) {
	var barcode = obj.val();
	var itemNo = $('#itemNo').val();
    var retval = true;
	$.ajax({
		type : 'post',
		async : false,
		dataType : "json",
		url : ctx + '/item/create/checkBarcodeIsExist',
		data : {
			barcode : barcode,
			itemNo  : itemNo
		},
		success : function(data) {
			if (data.status == "success") {
				obj.removeClass('errorInput');
				obj.removeAttr('title');
				retval = true;
			} else {
				obj.addClass('errorInput');
				obj.attr('title','条码重复');
				retval =  false;
			}
		}
	});
	return retval;
}
// barcode国际规则校验
function chk_barcode_valid(barcode) {
	var len = barcode.length;
	var c_barcd = barcode;

	if (len == 8 && barcode.substr(0, 1) == '0') {
		var pos_1 = barcode.substr(7, 1);
		var pos_2 = barcode.substr(6, 1);
		var pos_3 = barcode.substr(5, 1);
		var pos_4 = barcode.substr(4, 1);
		var pos_5 = barcode.substr(3, 1);
		var pos_6 = barcode.substr(2, 1);
		var pos_7 = barcode.substr(1, 1);
		if (pos_2 == '3' && eval(pos_5) < 3) {
			return -1;
		} else if (pos_2 == '4' && pos_4 == '0') {
			return -1;
		} else if (eval(pos_2) > 4 && pos_3 == '0') {
			return -1;
		}
		var ean13 = '00' + pos_7 + pos_6; /* first four digits */
		if (pos_2 == '0' || pos_2 == '1' || pos_2 == '2') {
			ean13 = ean13 + pos_2 + '0000' + pos_5 + pos_4 + pos_3;
		} else if (pos_2 == '3') {
			ean13 = ean13 + pos_5 + '00000' + pos_4 + pos_3;
		} else if (pos_2 == '4') {
			ean13 = ean13 + pos_5 + pos_4 + '00000' + pos_3;
		} else {
			ean13 = ean13 + pos_5 + pos_4 + pos_3 + '0000' + pos_2;
		}
		ean13 = ean13 + pos_1;
		len = ean13.length;
		;/* end of if len = 8 */
		c_barcd = ean13;
	} else if (len == 7) {
		var pos_1 = barcode.substr(6, 1);
		var pos_2 = barcode.substr(5, 1);
		var pos_3 = barcode.substr(4, 1);
		var pos_4 = barcode.substr(3, 1);
		var pos_5 = barcode.substr(2, 1);
		var pos_6 = barcode.substr(1, 1);
		var pos_7 = barcode.substr(0, 1);
		if (pos_2 == '3' && eval(pos_5) < 3) {
			return -1;
		} else if (pos_2 == '4' && pos_4 == '0') {
			return -1;
		} else if (eval(pos_2) > 4 && pos_3 == '0') {
			return -1;
		}
		var ean13 = '00' + pos_7 + pos_6; /* first four digits */
		if (pos_2 == '0' || pos_2 == '1' || pos_2 == '2') {
			ean13 = ean13 + pos_2 + '0000' + pos_5 + pos_4 + pos_3;
		} else if (pos_2 == '3') {
			ean13 = ean13 + pos_5 + '00000' + pos_4 + pos_3;
		} else if (pos_2 == '4') {
			ean13 = ean13 + pos_5 + pos_4 + '00000' + pos_3;
		} else {
			ean13 = ean13 + pos_5 + pos_4 + pos_3 + '0000' + pos_2;
		}
		ean13 = ean13 + pos_1;
		len = ean13.length;/* end of if len = 8 */
		c_barcd = ean13;
	} else if (len == 9)/* QiaoLeQI length 9 for RT-MART */
	{
		if (barcode.substr(0, 1) != '2' || barcode.substr(8, 1) != '2') {
			return -1;
		}
	} else {
		c_barcd = barcode;
	}
	var sum_a = 0;
	var sum_b = 0;
	for (var i = len - 1; i > 0; i = i - 2) {
		sum_a = sum_a + eval(c_barcd.substr(i - 1, 1));
		if (i >= 2) {
			sum_b = sum_b + eval(c_barcd.substr(i - 2, 1));
		}
	}
	if (sum_a == 0 && sum_b == 0) {
		return -1;
	}
	var sum_tot = sum_a * 3 + sum_b + eval(c_barcd.substr(len - 1, 1));
	if (sum_tot % 10 != 0) {
		return -1;
	}
	return c_barcd;
}

// 自动生成内部barcode
function ins_ean13_barcode(obj, itemno, itemType, barcodeLabel, projLabel) {
	var ins_flag = true;
	var obj_bar = obj.parent().parent().parent().next().find(".sp_tb:first");
	obj_bar.find('.ig input[name=\'barcode\']').each(
			function() {
				if ($.trim($(this).val()) == "") {
					$(this).val(
							gen_ean13_barcode(itemno, itemType, barcodeLabel,
									projLabel));
					ins_flag = false;
					$(this).removeClass('errorInput');
					$(this).removeAttr('title');
					return false;
				}
			});

	if (ins_flag) {
		obj_bar.append($('#itemBarDiv').html());
		var curr_bar = obj_bar.find('.ig:last input[name=\'barcode\']');
		var eanCode = gen_ean13_barcode(itemno, itemType, barcodeLabel,
				projLabel);
		curr_bar[0].value= eanCode;
		curr_bar.val(eanCode);
		curr_bar.addClass('mustInput');
		nullInputCheck();
		inputToInputIntNumber();
	}
}

// 删除内部barcode
function del_ean13_barcode(obj, itemno, itemType, barcodeLabel, projLabel) {

	var obj_bar = obj.parent().parent().parent().next().find(".sp_tb:first");
	obj_bar.find('.ig input[name=\'barcode\']').each(function() {

		if ($.trim($(this).val()).search("^(?=20|21)[0-9]*$") > -1) {
			$(this).val('');
			return false;
		}
	});
}

// 内部条码生成规则
function gen_ean13_barcode(itemno, itemType, barcodeLabel, projLabel) {

	var c_barcode = 0;
	if (itemType == 1 && barcodeLabel == 1) {
		var s1 = (2100000 + itemno % 100000).toString() + '00000';
	}

	else {
		if (projLabel == 1) {
			s1 = (204000000000 + eval(itemno)).toString();
		} else {
			s1 = (200000000000 + eval(itemno)).toString();
		}
	}

	var x13 = eval(s1.substr(0, 1));
	var x12 = eval(s1.substr(1, 1));
	var x11 = eval(s1.substr(2, 1));
	var x10 = eval(s1.substr(3, 1));
	var x9 = eval(s1.substr(4, 1));
	var x8 = eval(s1.substr(5, 1));
	var x7 = eval(s1.substr(6, 1));
	var x6 = eval(s1.substr(7, 1));
	var x5 = eval(s1.substr(8, 1));
	var x4 = eval(s1.substr(9, 1));
	var x3 = eval(s1.substr(10, 1));
	var x2 = eval(s1.substr(11, 1));
	var oddsum = x13 + x11 + x9 + x7 + x5 + x3;
	var evensum = x12 + x10 + x8 + x6 + x4 + x2;
	var c1 = (10 - (evensum * 3 + oddsum) % 10) % 10;
	c_barcode = s1 + c1.toString();
	return c_barcode;
}

// 自动生成内部码选择处理
function handler_barcode_click(obj, chk_flag, itemno, itemType, barcodeLabel,
		projLabel) {
	if (chk_flag) {
		ins_ean13_barcode(obj, itemno, itemType, barcodeLabel, projLabel);
	} else {
		del_ean13_barcode(obj, itemno, itemType, barcodeLabel, projLabel);
	}
}

/** 输入小数值 double_text */
function inputToInputDoubleNumberAndChkLen(obj) {
	obj.find("input.double_text_with_len").each(function() {
		var intval = $(this).attr('intval');
		var decval = $(this).attr('decval');	
		var reg = new RegExp("^[0-9]{1," + intval +"}[.][0-9]{0,"+decval+"}$|^[0-9]{1,"+intval+"}$");
		$(this).keyup(function(){		
			if ($(this).val() != '' && !reg.test($(this).val())) {
				if ($(this).val() == ' ') {
					$(this).val('');
					return false;
				}
				if ($(this).val() != '') {
					$(this).val($(this).attr('preval'));
				}
				return true;
			}
			$(this).attr('preval', $(this).val());
		});
		$(this).blur(function(){
			var val = $(this).val();
			if (val!= '' && !reg.test(val)) {
				if (val == ' ') {
					$(this).val('');
					return false;
				}
				if ($(this).val() != '') {
					$(this).val($(this).attr('preval'));
				}
				return true;
			}
			if (val.indexOf('.')==val.length-1) {
					$(this).val(val.substring(0,val.length-1));
			}
			$(this).attr('preval', $(this).val());
		});
	});
}

function inputToInputDoubleNumberAndChkLenManul(obj) {
	var intval = obj.attr('intval');
	var decval = obj.attr('decval');
	var reg = new RegExp("^[0-9]{1,"+intval +"}[.][0-9]{1,"+decval+"}$|^[0-9]{1,"+intval+"}$");
	var val = $.trim(obj.val());
	
	if (val != '' && !reg.test(val)) {
		obj.addClass('errorInput');
		obj.attr('title','输入格式不正确    整数:'+ intval + '位,小数:' + decval + '位');
		return false;
	} else {
		obj.removeClass('errorInput');
		obj.removeAttr('title');
	}
	return true;
	
}

function loadRegionNode(obj){
	$(obj).autocomplete(regionNodeList, {
	    minChars: 0,
	    width: $(this).attr('width'),
		max:	3000,
	    matchContains: true,
	    matchCase:false,//不区分大小写
	    autoFill: false,
	    dataType: 'json',
	    formatItem: function(row, i, max) {
	        return row.regnName;
	    },
	    formatMatch: function(row, i, max) {
	        return row.regnName;

	    },
	    formatResult: function(row) {
	        return row.regnName;
	    }
	    
	}).result(function(event, data, formatted) { //回调
			
	    });
}

function loadProducerList(obj){
	$(obj).autocomplete(ctx+'/item/create/searchProduceAndCompany', {
	    minChars: 0,
	    width: $(this).attr('width'),
		max:	3000,
	    matchContains: true,
	    matchCase:false,//不区分大小写
	    autoFill: false,
	    dataType: 'json',
	    formatItem: function(row, i, max) {
	        return row.producerName;
	    },
	    formatMatch: function(row, i, max) {
	        return row.producerName;
	
	    },
	    formatResult: function(row) {
	        return row.producerName;
	    }
		,callback:function(obj){
			setProducerData(obj);
		}
	}).result(function(event, data, formatted) { //回调
		$(this).val(data.producerName);
		$(this).parent().find('input.comNo').val(data.comNo);
		var prov = $(this).parent().find('input.provName');
		var pp = null;
		if(!prov || prov.size()==0){
			prov = $(this).parent().parent().find('input.provName');
			if(!prov || prov.size()==0){
				pp = $(this).parent().parent().parent();
			}
			else{
				pp = $(this).parent().parent();
			}
		}
		else{
			pp = $(this).parent();
		}
		if(pp){
			setProducerData($(this),data);
		}
	});
}

function setProducerData(obj,data){
	var prov = $(obj).parent().find('input.provName');
	var pp = null;
	if(!prov || prov.size()==0){
		prov = $(obj).parent().parent().find('input.provName');
		if(!prov || prov.size()==0){
			pp = $(obj).parent().parent().parent();
		}
		else{
			pp = $(obj).parent().parent();
		}
	}
	else{
		pp = $(obj).parent();
	}
	prov = pp.find('input.provName');
	if(prov){
		prov.val(data?data.provinceName:'');
		prov.removeClass('errorInput');
	}
	var prov2 = pp.find('input.provCode');
	if(prov2){
		prov2.val(data?data.provinceCode:'');
	}
	var city = pp.find('input.cityName');
	if(city){
		city.val(data?data.cityName:'');
		city.removeClass('errorInput');
	}
	var city2 = pp.find('input.cityCode');
	if(city2){
		city2.val(data?data.cityCode:'');
	}
	var _address = pp.find('input.address');
	if(_address){
		_address.removeClass('errorInput');
		_address.val(data?data.address:'');
	}
	var comNo = pp.find('input.comNo');
	if(comNo){
		comNo.val(data?data.comNo:'');
	}
	var producerId = pp.find('input.producerId');
	if(producerId){
		producerId.val(data?data.producerId:'');
	}
	var addressId = pp.find('input.addressId');
	if(addressId){
		addressId.val(data?data.addressId:'');
	}
}

function loadOrignTitle(obj){
	$(obj).autocomplete(cityList, {
	    minChars: 0,
	    width: $(this).attr('width'),
		max:	3000,
	    matchContains: true,
	    matchCase:false,//不区分大小写
	    autoFill: false,
	    dataType: 'json',
	    formatItem: function(row, i, max) {
	        return row.code+"-"+row.title;
	    },
	    formatMatch: function(row, i, max) {
	        return row.title;
	
	    },
	    formatResult: function(row) {
	        return row.title;
	    }
	    
	}).result(function(event, data, formatted) { //回调
		if(data){
			$(this).prev().find('.orignCode').val(data.code);
		}
        });
}
//查询META数据
function updateComGrp(url, tid) {
		$.ajax({
			type : 'post',
			async : false,
			dataType : "json",
			url : ctx + '/item/create/getMeta/' + url,
			data : {},
			success : function(data) {
				if (data != null) {
					refreshMetaSelect(data, tid);
				} else {
					top.jAlert('error', "查询" + url + "数据失败", '提示消息');
				}
			}
		});
	}


	//查询生产单位
	function searchPrcAndCom() {
		var prdcrName = $.trim($("#comNo2").val());
		$.ajax({
			type : 'post',
			async : false,
			dataType : "json",
			url : ctx + '/item/create/searchProduceAndCompany',
			data : {
				prdcrName : prdcrName
			},
			success : function(data) {
				if (data != null) {
					top.jAlert('success', '查询数据成功', '提示消息');
				} else {
					top.jAlert('error', '查询数据失败', '提示消息');
				}
			}
		});
	}

	function addOtherSupList(obj) {
		obj.append($('#provCityDiv').html());
		//addDataRow(obj,'produceAddrList');
		$(obj).find('.ig:last').find('input:text').addClass('mustInput');
		loadSelectDiv(obj.find('.regionNode:last'), regionNodeList, 2);
		loadSelectDiv(obj.find('.orignTitle:last'), cityList,3);
		loadProducerList($('.producerComName'));
		$('#otherRegList').scrollTop($('#otherRegList .otherRegn:last').offset().top);
	}

	function refreshMetaSelect(data, tid) {
		$(tid).empty();
		$(tid).append('<option value="">请选择</option>');
		for (var i = 0; i < data.length; i++) {
			$(tid).append(
					"<option value="+data[i].itemCode+">" + data[i].desc
							+ "</option>");
		}
	}

	function openBrandWindow() {
		openPopupWin(720, 510, '/item/create/showBrandListPop');
	}

	function openVatWindow() {
		openPopupWin(550, 510, '/item/create/showVatListPop');
	}

	function openSupWindow() {
		openPopupWin(750, 490, '/item/create/showSupListPop');
	}
	
	function openClusterWindow() {
		openPopupWin(750, 490, '/item/create/showClusterListPop?catlgId='
				+ $('#kebieInput2').val());
	}

	function openSEWindow() {
		openPopupWin(650, 570, '/item/create/showSETopicListPop?catlgId='
				+ $('#chubieInput2').val());
	}

	function resetCheckAll(obj) {
		if (obj.find('input:checkbox:not(:checked)').size()!=0 || obj.find('input:checkbox:checked').size()==0) {
			obj.next().find('.checkAll').attr('checked', false);
		} else if (obj.find('input:checkbox:not(:checked)').size() == 0) {
			obj.next().find('.checkAll').attr('checked', true);
		}
	}
	
	function setCatlgWarn(catlgId){
		$('#xiaofenleiInput').removeClass('red_info');
		$('#xiaofenleiInput').removeAttr('_title');
		if($.trim(catlgId)==''){
			return false;
		}
		$.ajax({
			type : 'post',
			async : false,
			dataType : "json",
			url : ctx + '/item/create/getCatlgBnoResult',
			data : {
				catlgId : catlgId
			},
			success : function(data) {
				if (data != null && ($.trim(data["B"])!='' || $.trim(data["N"])!='' || $.trim(data["O"])!='')) {
					var str= '';
					$.each(data,function(bnoName){
						var title ="以下区域"+bnoName+"属性超出:<br/>";
						var trStre = "";
						var d=this;
						for(var i=0;i<bgRegn.length;i++){
							var caochu = false;
							for(var j=0;j<d.length;j++){
								if(d[j]==bgRegn[i]){
									caochu = true;
									break;
								}
							}
							if(caochu){
								if(trStre!=''){
									trStre += '、'+bgRegnName[i] ;
								}
								else{
									trStre += bgRegnName[i] ;
								}
							}
						}
						if(trStre!=''){
							if(str==''){
								str+=title+trStre;
							}
							else{
								str+="<br/><br/>"+title+trStre;
							}
						}
					});
					
					$('#xiaofenleiInput').addClass('red_info');
					$('#xiaofenleiInput').attr('_title',str)
					$(".red_info").mouseover(function () {
						var text = $(this).attr("_title");
						var top = $(this).offset().top;
						var left = $(this).offset().left;
						$("#_title").html(text).css({"top":top+30,"left":left,"display":"block"});
						}); 
					$(".red_info").focus(function () {
						$("#_title").css("display","none");
						});
					$(".red_info").mouseout(function () {
						$("#_title").css({ "display": "none" });
						}); 
				}
			}
		});
	}
	
	function popBnoDiv(){
		var selector = $('.bnoResultDiv');
		$(selector).window({
			width : 595,
			height : 300,
			draggable : true,
			resizable : false,
			modal : true,
			shadow : false,
			border : false,
			noheader : true
		});
		$(selector).parent().css('top', '10px');
		$(selector).css("display", "block");$(selector).window("open");window.windowSelector = selector;bindPopButtonEvent();
	}