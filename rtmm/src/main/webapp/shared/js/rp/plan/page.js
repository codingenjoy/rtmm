/*
 * 本文件定义了在本功能页面上所有DOM元素的事件处理函数.
 */
var planHandler = new PlanHandler();
// 科目组编号
var acctsArray = [];

// 设置主题名称
function setThemeName(obj) {
	$("#crRdmTopic").val($(obj).val());
	var rmBeginDate = $("#crRdmNo option:selected").attr("dmBeginDate");
	var rmEndDate = $("#crRdmNo option:selected").attr("dmEndDate");
	$("#crRdmBeginDate").val(rmBeginDate);
	$("#crRdmEndDate").val(rmEndDate);
}

// 添加商品信息行
function addItem(/* Node */theCurrentElement) {
	// TODO validate
	// 调用，增加新
	planHandler.addOneEmptyIterm();
	// $("#templTabCodeDiv").scrollTop($("#templTabCodeDiv").scrollTop()+30);
	// 调用，增加新
	$(".tr_click_on")[0].scrollIntoView();
	$(".tr_click_on")[1].scrollIntoView();
};

// 添加条款信息行
function addTabTerm(/* Node */theCurrentElement) {
	// 调用，增加新
	planHandler.addNewTerms2OneTab();
	$("#templTabTermDiv").scrollTop($("#templTabTermDiv").scrollTop() + 30);
};

// 添加科目信息行
function addTabTermAcct(/* Node */theCurrentElement) {
	// 调用，增加新
	planHandler.addNewAccts2OneTerm();
};

// 获取商品信息以及商品下的门店(手动输入)
function getItemMessAndStores(/* Node */theCurrentElement) {
	var itemNo = theCurrentElement.value;
	// 禁止重复查询
	if (planHandler.forbidRepetitionSearch(/* String */itemNo)) {
		return;
	}
	// 验证是否已存在的货号
	if (planHandler.wheterExistItemNo(/* String */itemNo)) {
		jWarningAlert('该货号已存在，请重新输入！');
		theCurrentElement.value = "";
		return;
	}
	// 获取货号
	if (!itemNo) {
		return;
	}
	// 获取课别
	var catlgId = $.trim($("#crCatlgId").val());
	if (!catlgId) {
		$("#crCatlgId").val('');
		$("#crCatlgId").addClass("errorInput");
		$("#crCatlgId").attr("title", "课别不能为空");
		theCurrentElement.value = '';
		return;
	}
	// 获取物流中心
	var storeNo = $.trim($("#crDcStoreNo").val());
	if (!storeNo) {
		$("#crDcStoreNo").addClass("errorInput");
		$("#crDcStoreNo").attr("title", "请选择物流中心");
		theCurrentElement.value = '';
		return;
	}
	// RP DM开始日期
	var rdmBeginDate = $.trim($("#crRdmBeginDate").val());
	if (!rdmBeginDate) {
		$("#crRdmBeginDate").addClass("errorInput");
		$("#crRdmBeginDate").attr("title", "门店确认期间开始日不能为空");
		$("#crRdmBeginDate").val('');
		return;
	}
	// RP DM结束日期
	var rdmEndDate = $.trim($("#crRdmEndDate").val());
	if (!rdmEndDate) {
		$("#crRdmEndDate").addClass("errorInput");
		$("#crRdmEndDate").attr("title", "门店确认期间结束日不能为空");
		$("#crRdmEndDate").val('');
		return;
	}
	var rpNo = $.trim($("#crRpNo").val());
	// 获取信息
	$.ajax({
		type : 'post',
		url : ctx + '/rp/plan/serarchItem',
		data : {
			rpNo : rpNo,
			itemNoArray : itemNo,
			catlgId : catlgId,
			storeNo : storeNo,
			rdmBeginDate : rdmBeginDate,
			rdmEndDate : rdmEndDate
		},
		success : function(data) {
			// 商品信息
			var rpItemList = data.rpItemList;
			if (!rpItemList || rpItemList.length == 0) {
				jWarningAlert('没有该货号，请重新输入！');
				theCurrentElement.value = "";
				return;
			}
			// 门店信息
			var rpStoreList = data.rpStoreList;
			var itemVO = {};
			itemVO.rpItemList = rpItemList;
			itemVO.rpStoreList = rpStoreList;
			planHandler.showItemMessage(/* Object */itemVO, /* Node */
					theCurrentElement);
		}
	});
}
// 删除选择的页签以及页签级联的数据
function removeTabs(/* Node */theCurrentElement) {
	planHandler.removeOneTabByNode(theCurrentElement);
}
// **删除选择的商品(由用户发起)
function doDeleteItem(/* Node */anyPURowMemberNodeIn) {
	// 验证是否有可删除信息
	/*
	 * if (checkedWhetherDeleteMess("templTabCodeDiv")) {
	 * jWarningAlert('请选择要删除的页签！'); return ; }
	 */
	// 如果提供了事件对象，则这是一个非IE浏览器
	if (anyPURowMemberNodeIn && anyPURowMemberNodeIn.stopPropagation) {
		// 因此它支持W3C的stopPropagation()方法
		anyPURowMemberNodeIn.stopPropagation();
	} else {
		// 否则，我们需要使用IE的方式来取消事件冒泡
		window.event.cancelBubble = true;
	}
	planHandler.removeOneItemByNode(/* Node */anyPURowMemberNodeIn);
	// 重新赋值索引
	var itemListFirstDivArea = $("#itemListFirstDivArea");
	var itemFirstArray = itemListFirstDivArea.get(0).rows;
	var itemFirstLen = itemFirstArray.length;
	var itemListSecondDivArea = $("#itemListSecondDivArea");
	var itemSecondArray = itemListSecondDivArea.get(0).rows;
	if (itemFirstLen != 0) {
		for (var ind = 0; ind < itemFirstLen; ind++) {
			var trElem = itemFirstArray[ind];
			var tr2Elem = itemSecondArray[ind];
			trElem.setAttribute("_index", "tr" + (ind + 1));
			tr2Elem.setAttribute("_index", "tr" + (ind + 1));
			if ($(trElem).hasClass("tr_click_on")) {
				trElem.setAttribute("class", "tr" + (ind + 1) + " tr_click_on");
				tr2Elem
						.setAttribute("class", "tr" + (ind + 1)
								+ " tr_click_on");
			} else {
				trElem.setAttribute("class", "tr" + (ind + 1));
				tr2Elem.setAttribute("class", "tr" + (ind + 1));
			}
		}
	}

};
// 删除某个模版页签下的条款(由用户发起)
function doDeleteTabTerms(/* Node */anyPUIRowMemberNodeIn) {
	// 验证是否有可删除信息
	if (checkedWhetherDeleteMess(/**/"templTabTermDiv")) {
		jWarningAlert('请选择要删除的条款！');
		return;
	}
	planHandler.removeOneTabTermByNode(/* Null */);
};
// **删除某个商品/选中的多个门店(由用户发起)
function doDeleteItemStores(/* None */anyPUIRowMemberNodeIn) {
	// 验证是否有可删除信息
	if (checkedWhetherDeleteMess(/* String */"itemStoreDivArea")) {
		jWarningAlert('请选择要删除的门店！');
		return;
	}
	// to-do.取选中的多个门店编号
	planHandler.removeOneItemStoreAcctByNode(/* Null */);
};

// **商品表单录入数据存放
function doUpdateOneItem(/* Node */doOneItemElement) {
	// flag为true是回车事件，
	// 验证是否为数字
	if (isNoNum(doOneItemElement.value || '', 8)) {
		doOneItemElement.value = '';
		$(doOneItemElement).addClass("errorInput");
		$(doOneItemElement).attr("title", "请输入数字");
		return;
	}
	planHandler._doUpdateOneItemRowContent(/* Node */doOneItemElement, /* Boolean */
			true);
	flag = false;
	// 回车下个元素获取光标
	// eventOperation(/*Node*/doOneTabElement);
};
// **门店表单录入数据存放
function doUpdateOneItemStore(/* Node */doOneItemStoreElement) {
	planHandler._doUpdateOneItemStoreRowContent(/* Node */doOneItemStoreElement, /* Boolean */
			true);
	flag = false;
};
// 当目标[商品]被点击后,执行本操作
function doOnItemSelected(/* Node */anyRowMemberNodeIn) {
	var storeNo = $.trim($("#crDcStoreNo").val());
	if (!storeNo) {
		return;
	}
	planHandler.activateItemByAnyElement(/* Node */anyRowMemberNodeIn, /* Integer */
			storeNo);
};
// 当目标[]被点击后,执行本操作
function doOnTempTabTermSelected(/* Node */anyRowMemberNodeIn) {
	planHandler.activateTermByAnyElement(/* Node */anyRowMemberNodeIn, /* Boolean */
			true);
};
// 当目标[科目行]被点击后,执行本操作
function doOnTempTabTermAcctSelected(/* Node */anyRowMemberNodeIn) {
	planHandler.activateTermAcctByAnyElement(/* Node */anyRowMemberNodeIn, /* Boolean */
			true);
};
// 键盘回车调入下个input框中
var flag = false;
function eventClick(/* Node */theCurrentElement) {
	if (event.keyCode == 13) {
		flag = true;
	}
}

// 保存新增或修改信息
function savePlan() {
	// 验证货号是否为空
	var rows = $("#itemListFirstDivArea").get(0).rows.length;
	if (rows === 0) {
		jWarningAlert("商品列表不能为空!");
		return;
	}
	var rpNo = $.trim($("#crRpNo").val());
	var planInfo = {};
	if (rpNo == "") {
		planInfo = planHandler.getData();
	} else {
		planInfo = planHandler.getEditData();
	}
	planInfo.rpNo = rpNo;
	planInfo.status = $.trim($("#crStatus").val());
	planInfo.catlgId = $.trim($("#crCatlgId").val());
	planInfo.rdmNo = $.trim($("#crRdmNo option:selected").text());
	planInfo.rdmTopic = $.trim($("#crRdmTopic").val());
	planInfo.rdmBeginDate = $.trim($("#crRdmBeginDate").val());
	planInfo.rdmEndDate = $.trim($("#crRdmEndDate").val());
	planInfo.stCnfrmBeginDate = $.trim($("#crStCnfrmBeginDate").val());
	planInfo.stCnfrmEndDate = $.trim($("#crStCnfrmEndDate").val());
	planInfo.stRepBeginDate = $.trim($("#crStRepBeginDate").val());
	planInfo.stRepEndDate = $.trim($("#crStRepEndDate").val());
	planInfo.dcStoreNo = $.trim($("#crDcStoreNo").val());
	// 保留信息验证
	var errorObj = checkRpPlan(planInfo);
	if (errorObj.flag) {
		if (errorObj.errorStore != "") {
			jWarningAlert(errorObj.errorStore);
			// 定位错误信息
			planHandler.showErrorElement(/* String */errorObj.indexOf);
		}
		return;
	}
	$.ajax({
		type : "post",
		url : ctx + "/rp/plan/save",
		data : {
			planInfoStr : JSON.stringify(planInfo)
		},
		success : function(data) {
			if (data.status == "success") {
				// jSuccessAlert(data.message);
				top.jAlert('success', data.message, '消息提示', function(flag) {
					if (flag) {
						showList();
					}
				});
				// openCreatePage();
			} else if (data.status == "error") {
				// jErrorAlert(data.message);
				jWarningAlert("此DM活动期间已有货号：[" + data.message.join() + "]");
			}
		}
	});
}

// 批量修改建议量
function batchUpdateInitQty(/* Node */theCurrentElement) {
	var initQty = theCurrentElement.value;
	// 验证是否为数字
	if (isNoNum(initQty || '', 8)) {
		theCurrentElement.value = '';
		$(theCurrentElement).addClass("errorInput");
		$(theCurrentElement).attr("title", "请输入数字");
		return;
	}
	planHandler._doUpdateInitQty(/* Node */theCurrentElement, /* Integer */
			initQty);
}
// 打开选择支付方式弹出框
function openOfPaymentWin(/* Node */theCurrentElement) {
	$(theCurrentElement.parentNode.children[0]).removeClass("errorInput");
	// 获取支付方式
	var payMethdOptnsStr = "";
	payMethdOptnsStr = planHandler
			.getPayMethdOptnsValue(/* Node */theCurrentElement);
	openPopupWin(405, 275,
			'/supplier/contract/templ/openOfPaymentWin?payMethdOptnsStr='
					+ payMethdOptnsStr);
}

// 选择的支付方式填入表单中
function writePayMethdOptns() {
	// 获取选择的支付方式
	// 支付方式全称
	var payMethOpensStr = "";
	// 支付方式编号
	var payMethOpens = "";
	$("#payMethOptnsDiv").children().each(
			function(i, payMeth) {
				if (payMeth.children[0].checked) {
					payMethOpensStr = payMethOpensStr
							+ payMeth.children[1].innerHTML + ";";
					payMethOpens = payMethOpens
							+ payMeth.children[1].getAttribute("payMethd")
							+ ",";
				}
			});
	if (payMethOpens == "") {
		jWarningAlert('请选择支付方式！');
		return;
	}
	payMethOpensStr = payMethOpensStr.substring(0, payMethOpensStr.length - 1);
	payMethOpens = payMethOpens.substring(0, payMethOpens.length - 1);
	// 赋值
	planHandler._doAssignmentPayMethOpens(/* String */payMethOpens,/* String */
			payMethOpensStr);
	// 关闭弹出框
	closePopupWin();
}
// 选择科目组编号填入表单中
function writeGrpAcctId() {
	// 检查条款下的科目是否已经存在
	var acctsList = planHandler
			._doCheckGrpAcctNoWhetherExist(/* Array */acctsArray);
	if (acctsList.length > 0) {
		jWarningAlert('科目组编号：' + acctsList[0].grpAcctNo + '已经存在！');
		return;
	}
	// 关闭弹出框
	closePopupWin();
	// 赋值并显示在科目区域上
	planHandler._doAssignmentGrpAccts(/* Array */acctsArray);
}
/**
 * 修改数据存放数组里 修改时，根据模版编号查询出所有的信息，分别存放到this._tabList = [],this._tab2TermMapping =
 * {},this._term2AcctsMapping = {}
 */
function packageEditData(/* JSON */jsonObject) {
	planHandler.packageEditData2Array(/* JSON */jsonObject);
}
// 清除errorInput样式
function inputFocus(/* Node */currentNode) {
	$(currentNode).removeClass("errorInput");
	$(currentNode).attr("title", "");
}
// 显示商品弹出框
function showItemWin() {
	// 获取课别
	var catlgId = $.trim($("#crCatlgId").val());
	if (!catlgId) {
		$("#crCatlgId").val('');
		$("#crCatlgId").addClass("errorInput");
		$("#crCatlgId").attr("title", "课别不能为空");
		return;
	}
	// 获取物流中心
	var storeNo = $.trim($("#crDcStoreNo").val());
	if (!storeNo) {
		$("#crDcStoreNo").addClass("errorInput");
		$("#crDcStoreNo").attr("title", "请选择物流中心");
		return;
	}
	// RP DM开始日期
	var rdmBeginDate = $.trim($("#crRdmBeginDate").val());
	if (!rdmBeginDate) {
		$("#crRdmBeginDate").addClass("errorInput");
		$("#crRdmBeginDate").attr("title", "门店确认期间开始日不能为空");
		$("#crRdmBeginDate").val('');
		return;
	}
	// RP DM结束日期
	var rdmEndDate = $.trim($("#crRdmEndDate").val());
	if (!rdmEndDate) {
		$("#crRdmEndDate").addClass("errorInput");
		$("#crRdmEndDate").attr("title", "门店确认期间结束日不能为空");
		$("#crRdmEndDate").val('');
		return;
	}
	top.openPopupWin(650, 548, '/rp/plan/choiceItemWin');
}
// 商品双击操作
function ondbclickcheckBox(/* Null */) {
	itemAffirmOperation(/* Null */);
}
// 商品确定操作
function itemAffirmOperation(/* Null */) {
	// 验证是否有选择的货号
	var itemflag = $("#rpItemDiv table :checked").length;
	if (itemflag != 1) {
		jWarningAlert('请选择货号！');
		return;
	}
	// 获取选择的货号
	var itemNo = $("#rpItemDiv table :checked").parent().next().text();
	var catlgId = $.trim($("#crCatlgId").val());
	var storeNo = $.trim($("#crDcStoreNo").val());
	// RP DM开始日期
	var rdmBeginDate = $.trim($("#crRdmBeginDate").val());
	// RP DM结束日期
	var rdmEndDate = $.trim($("#crRdmEndDate").val());
	var rpNo = $.trim($("#crRpNo").val());
	// 根据商品查询门店
	$.ajax({
		type : 'post',
		url : ctx + '/rp/plan/serarchItem',
		data : {
			rpNo : rpNo,
			itemNoArray : itemNo,
			catlgId : catlgId,
			storeNo : storeNo,
			rdmBeginDate : rdmBeginDate,
			rdmEndDate : rdmEndDate
		},
		success : function(data) {
			// 商品信息
			var rpItemList = data.rpItemList;
			if (!rpItemList || rpItemList.length == 0) {
				jWarningAlert('该货号不符合，请重新选择！');
				return;
			}
			// 门店信息
			var rpStoreList = data.rpStoreList;
			var itemVO = {};
			itemVO.rpItemList = rpItemList;
			itemVO.rpStoreList = rpStoreList;
			planHandler.radioShowItemMessage(/* Object */itemVO);
			closePopupWin();
		}
	});
}
// 显示商品批量新增弹出框
function showItemPasteWin(obj) {
	// 获取课别
	var catlgId = $.trim($("#crCatlgId").val());
	if (!catlgId) {
		$("#crCatlgId").val('');
		$("#crCatlgId").addClass("errorInput");
		$("#crCatlgId").attr("title", "课别不能为空");
		$("#crCatlgId").val('');
		return;
	}
	// 获取物流中心
	var storeNo = $.trim($("#crDcStoreNo").val());
	if (!storeNo) {
		$("#crDcStoreNo").addClass("errorInput");
		$("#crDcStoreNo").attr("title", "请选择物流中心");
		$("#crDcStoreNo").val('');
		return;
	}
	// RP DM开始日期
	var rdmBeginDate = $.trim($("#crRdmBeginDate").val());
	if (!rdmBeginDate) {
		$("#crRdmBeginDate").addClass("errorInput");
		$("#crRdmBeginDate").attr("title", "门店确认期间开始日不能为空");
		$("#crRdmBeginDate").val('');
		return;
	}
	// RP DM结束日期
	var rdmEndDate = $.trim($("#crRdmEndDate").val());
	if (!rdmEndDate) {
		$("#crRdmEndDate").addClass("errorInput");
		$("#crRdmEndDate").attr("title", "门店确认期间结束日不能为空");
		$("#crRdmEndDate").val('');
		return;
	}
	$.ajaxSetup({
		async : true
	});
	top.grid_layer_close();
	top.openPopupWin(600, 450, '/rp/plan/pasteItemNo');
}

// 商品批量数据处理
function batchPasteItemNo(data) {
	var itemNoArray = data.join();
	// 获取课别
	var catlgId = $.trim($("#crCatlgId").val());
	// 获取物流中心
	var storeNo = $.trim($("#crDcStoreNo").val());
	// RP DM开始日期
	var rdmBeginDate = $.trim($("#crRdmBeginDate").val());
	// RP DM结束日期
	var rdmEndDate = $.trim($("#crRdmEndDate").val());
	var rpNo = $.trim($("#crRpNo").val());
	// 获取信息
	$.ajax({
		type : 'post',
		url : ctx + '/rp/plan/serarchItem',
		data : {
			rpNo : rpNo,
			itemNoArray : itemNoArray,
			catlgId : catlgId,
			storeNo : storeNo,
			rdmBeginDate : rdmBeginDate,
			rdmEndDate : rdmEndDate
		},
		success : function(data) {
			// 商品信息
			var rpItemList = data.rpItemList;
			if (!rpItemList || rpItemList.length == 0) {
				jWarningAlert('没有该货号，请重新输入！');
				return;
			}
			// 不存在的货号
			var noExistItemNo = [];
			var itemList = data.itemList;
			var len = rpItemList.length;
			var len1 = itemList.length;
			// 检测没有的货号
			for (var ind = 0; ind < len; ind++) {
				var itemNo = itemList[ind];
				var flag = true;
				for (var ind1 = 0; ind1 < len1; ind1++) {
					itemNo1 = rpItemList[ind].itemNo;
					// 检查货号是否存在
					if (itemNo == itemNo1) {
						flag = false;
						break;
					}
				}
				if (flag) {
					noExistItemNo.push(itemNo);
				}
			}
			if (noExistItemNo.length !== 0) {
				jWarningAlert('以下货号没有[' + noExistItemNo.join() + ']！');
				return;
			}
			// 门店信息
			var rpStoreList = data.rpStoreList;
			var itemVO = {};
			itemVO.rpItemList = rpItemList;
			itemVO.rpStoreList = rpStoreList;
			planHandler.batchShowItemMessage(/* Object */itemVO);
		}
	});
}

// 初始化修改的数据
function showEditData(/* Json */obj) {
	// 保留计划基本信息
	var rpVO = obj.rpVO;
	// 商品
	var itemMap = obj.itemMap;
	$("#crRpNo").val(rpVO.rpNo);
	// 设置状态
	$("#crStatusStr").val(getDictValue("RP_STATUS", rpVO.status, 1));
	$("#crStatus").val(rpVO.status);
	// 设置课别
	$("#crCatlgId").val(rpVO.catlgId);
	$("#crCatlgId").prop("readonly", true);
	$("#crCatlgId").next().removeProp("onclick");
	setCatglId(/* Integer */rpVO.catlgId);
	// 设置RP DM
	setRpDm(/* String */rpVO.rdmNo);
	if (rpVO.stCnfrmBeginDate) {
		$(".cks").prop("checked", true);
		$("#crStCnfrmBeginDate").val(
				new Date(rpVO.stCnfrmBeginDate.time).format("yyyy-MM-dd"));
		$("#crStCnfrmEndDate").val(
				new Date(rpVO.stCnfrmEndDate.time).format("yyyy-MM-dd"));
	} else {
		$(".cks").prop("checked", false);
		var stCnfrmBeginDate = $("#crStCnfrmBeginDate");
		var stCnfrmEndDate = $("#crStCnfrmEndDate");
		stCnfrmBeginDate.addClass("Black");
		stCnfrmEndDate.addClass("Black");
		stCnfrmBeginDate.prop("disabled", "disabled");
		stCnfrmEndDate.prop("disabled", "disabled");
	}
	$("#crStRepBeginDate").val(
			new Date(rpVO.stRepBeginDate.time).format("yyyy-MM-dd"));
	$("#crStRepEndDate").val(
			new Date(rpVO.stRepEndDate.time).format("yyyy-MM-dd"));
	$("#crDcStoreNo").val(rpVO.dcStoreNo);
	$("#crDcStoreNo option:not(:selected)").remove();
	$("#finalAmnt").val(rpVO.finalAmnt);
	// 设置商品
	planHandler.editPlanMessage(/* Object */itemMap);
}

// 设置RP DM
function setRpDm(/* String */rdmNo) {
	$("#crRdmNo option").each(function(ind, element) {
		if (element.text == rdmNo) {
			element.selected = true;
			setThemeName($("#crRdmNo"));
			return false;
		}
	});
	$("#crRdmNo option:not(:selected)").remove();
}

// 设置课别
function setCatglId(/* Integer */sectionNo) {
	$.ajax({
		type : 'post',
		url : ctx + '/catalog/searchSectionMessAction',
		data : {
			catlgId : sectionNo
		},
		success : function(data) {
			var sectionInfoVO = data.sectionInfoVO;
			$("#crCatlgName").val(sectionInfoVO.catlgName);
			$("#crCatlgName").attr("title", sectionInfoVO.catlgName);
		}
	});
}

// ***********************************添加门店开始******************************
// 打开门店弹出框
function showStoreWin() {

	/*
	 * var isValidate = validate(true); if (!isValidate) return false;
	 */
	openPopupWinTwo(624, 423, "/rp/plan/openStoreWin");
};
// 门店弹出框确认操作
function addOrderItemStores(/* Array */storeVO) {
	if (storeVO.storeArr.length == 0) {
		jWarningAlert('请选择门店！');
		return;
	}
	planHandler.batchAddStore(/* Array */storeVO);
	closePopupWinTwo();
}
// ***********************************添加门店结束******************************

// 更改物流中心,做的事情
function changeCrDcStoreNo(/* Node */currentNode) {
	// 清空商品信息和门店信息
	planHandler.clearItemAndStore(/* Null */);
}

// ***********************************更新厂商开始******************************
// 打开厂商弹出框
function showSupplierWin(obj) {
	var trElement = $(obj).parent().parent().parent().get(0);
	var itemNo = trElement.cells[0].children[0].children[0].value || "";
	// 验证是否有货号
	if (itemNo == "") {
		jWarningAlert('货号不能为空！');
		return;
	}
	top.openPopupWin(650, 548, '/rp/plan/showSupplierWin');
};
// 厂商弹出框确认操作
function supplierAffirmOperation(/* Object */supplier) {
	if (!("supNo" in supplier)) {
		jWarningAlert('请选择厂商！');
		return;
	}
	var supplierElem = $("#itemListFirstDivArea .tr_click_on").get(0).children[5].children[0].children[0];
	var comNameElem = $("#itemListFirstDivArea .tr_click_on").get(0).children[6].children[0];
	supplierElem.value = supplier.supNo;
	comNameElem.value = supplier.comName;
	planHandler._doUpdateOneItemRowContent(/* Node */supplierElem, /* Boolean */
			true);
	closePopupWin();
}

// 获取商品信息的厂商(手动输入)
function getItemSupplier(/* Node */theCurrentElement) {
	var supNo = theCurrentElement.value;
	// 验证厂商是否为空
	if (supNo == "") {
		return;
	}
	// 获取货号
	var trElement = $(theCurrentElement).parent().parent().parent().get(0);
	var itemNo = trElement.cells[0].children[0].children[0].value || "";
	// 验证是否有货号
	if (itemNo == "") {
		jWarningAlert('货号不能为空！');
		return;
	}
	// 获取课别
	var catlgId = $.trim($("#crCatlgId").val());
	if (!catlgId) {
		$("#crCatlgId").val('');
		$("#crCatlgId").addClass("errorInput");
		$("#crCatlgId").attr("title", "课别不能为空");
		theCurrentElement.value = '';
		return;
	}
	/*
	 * //获取物流中心 var storeNo = $.trim($("#crDcStoreNo").val()); if (!storeNo) {
	 * $("#crDcStoreNo").addClass("errorInput");
	 * $("#crDcStoreNo").attr("title","请选择物流中心"); theCurrentElement.value = '';
	 * return ; }
	 */
	// 获取信息
	$.ajax({
		type : 'post',
		url : ctx + '/rp/plan/serarchSupplier',
		data : {
			itemNo : itemNo,
			catlgId : catlgId,
			supNo : supNo
		},
		success : function(data) {
			var supNo = data.supNo;
			if (supNo === "") {
				theCurrentElement.value = '';
				var comNameElem = $(theCurrentElement).parent().parent().next()
						.get(0).children[0];
				comNameElem.value = '';
				jWarningAlert('没有该厂商，请重新输入！');
				return;
			}
			theCurrentElement.value = supNo;
			var comNameElem = $(theCurrentElement).parent().parent().next()
					.get(0).children[0];
			comNameElem.value = data.comName;
			planHandler._doUpdateOneItemRowContent(/* Node */theCurrentElement, /* Boolean */
					true);
		}
	});
}
// ***********************************更新厂商结束******************************

function selectCatlg() {
	// 打开弹出层
	openPopupWin(600, 500, '/commons/window/chooseSection');
	$("#crCatlgId").removeClass('errorInput');
	$("#crCatlgId").attr('title', '');
}
function confirmChooseSection(id, name) {
	var catlgId = $.trim($('#crCatlgId').val());
	if (catlgId !== $.trim(id)) {
		changeCrDcStoreNo(/* Node */null);
	}
	// 创建保留计划中的课别
	$('#crCatlgId').attr('value', id);
	$('#crCatlgName').attr('value', name);
	// 关闭弹出层
	closePopupWin();
}

function changeCatlg(self) {
	$(self).attr('title', '');
	$(self).removeClass('errorInput');
	var flag = true;
	var catlgId = $(self).val();
	if ($.trim(catlgId) != '' && isNumber($.trim(catlgId))) {
		readCatalogInfoBySecNo(catlgId, function(data) {
			if (data != "") {
				$("#crCatlgName").val(data[0].secName);
				changeCrDcStoreNo(/* Node */null);
			} else {
				top.jAlert('warning', '没有找到相应课别信息！', '提示消息');
				$("#crCatlgId").val("");
				$("#crCatlgName").val("");
				flag = false;
			}
		});
	} else {
		$("#crCatlgId").val("");
		$("#crCatlgName").val("");
		flag = false;
	}
}

function storeConfirm(obj) {
	var stCnfrmBeginDate = $("#crStCnfrmBeginDate");
	var stCnfrmEndDate = $("#crStCnfrmEndDate");
	if (!obj.checked) {
		stCnfrmBeginDate.addClass("Black");
		stCnfrmEndDate.addClass("Black");
		stCnfrmBeginDate.prop("disabled", "disabled");
		stCnfrmEndDate.prop("disabled", "disabled");
		stCnfrmBeginDate.val("");
		stCnfrmEndDate.val("");
		stCnfrmBeginDate.removeClass("errorInput");
		stCnfrmEndDate.removeClass("errorInput");
		stCnfrmBeginDate.prop('title', '');
		stCnfrmEndDate.prop('title', '');
	} else {
		stCnfrmBeginDate.removeClass("Black");
		stCnfrmEndDate.removeClass("Black");
		stCnfrmBeginDate.removeProp("disabled");
		stCnfrmEndDate.removeProp("disabled");
	}
}

function stBeginDateQuery(dp) {
	$("input[name='stBeginDate']").attr('title', '');
	$("input[name='stBeginDate']").removeClass('errorInput');
	// 门店确认开始日期
	var stBeginDateStr = dp.cal.getNewDateStr();
	// 门店确认结束日期
	var crStCnfrmEndDateStr = $.trim($("#crStCnfrmEndDate").val());
	var stBeginDateStr1 = $.trim($("#crStCnfrmBeginDate").val());
	if (stBeginDateStr !== stBeginDateStr1 && stBeginDateStr1 !== "") {
		top.jConfirm("确定修改则清空商品列表，确定要修改?", "提示信息", function(ret) {
			if (ret) {
				// 清空商品信息和门店信息
				planHandler.clearItemAndStore(/* Null */);
			} else {
				return false;
			}
		});
	}
	debugger;
	// 验证门店确认期间
	if (crStCnfrmEndDateStr) {
		var flag = checkDate(stBeginDateStr, crStCnfrmEndDateStr);
		if (!flag) {
			$("#crStCnfrmEndDate").attr('title', '结束日期小于开始日期');
			$("#crStCnfrmEndDate").addClass('errorInput');
			$("#crStCnfrmEndDate").val('');
			crStCnfrmEndDateStr = "";
		}
		if (crStCnfrmEndDateStr) {
			// 门店补货开始日期
			var crStRepBeginDateStr = $.trim($("#crStRepBeginDate").val());
			// DM活动开始日期
			var crRdmBeginDateStr = $.trim($("#crRdmBeginDate").val());
			// 验证门店补货开始日期
			var flag = checkDate(crStRepBeginDateStr, crRdmBeginDateStr);
			if (!flag) {
				$("#crStRepBeginDate").attr('title', '门店补货开始日期在DM活动开始日期之前');
				$("#crStRepBeginDate").addClass('errorInput');
				$("#crStRepBeginDate").val('');
				crStCnfrmEndDateStr = "";
			} else {
				var flag = checkDate(crStRepBeginDateStr, crStCnfrmEndDateStr);
				if (flag) {
					$("#crStRepBeginDate").attr('title', '门店补货开始日期在门店需求确认结束之后');
					$("#crStRepBeginDate").addClass('errorInput');
					$("#crStRepBeginDate").val('');
					crStCnfrmEndDateStr = "";
				}
			}
		}

	}
	/*
	 * var date=new Date(Date.parse(stBeginDate.replace(/-/g, "/"))); var
	 * stCnfrmDays = $("#crRdmNo option:selected").attr("stCnfrmDays"); var
	 * stEnd=(new
	 * Date(date.getTime()+stCnfrmDays*1000*60*60*24)).format('yyyy-MM-dd'); var
	 * scmPrepDays = $("#crRdmNo option:selected").attr("scmPrepDays"); var
	 * dmbeginDate=$("#crRdmBeginDate").val(); var
	 * subDays=getSubDays(stBeginDate,dmbeginDate); if(subDays<=scmPrepDays){
	 * $("input[name='stBeginDate']").attr('title','开始日期大于选择的DM的活动开始日 -
	 * 物流准备天数'); $("input[name='stBeginDate']").addClass('errorInput');
	 * $("input[name='stEndDate']").val(''); return false;
	 *  } $("input[name='stEndDate']").val(stEnd); var
	 * subDays2=getSubDays(stEnd,dmbeginDate); if(subDays2<=scmPrepDays){
	 * $("input[name='stEndDate']").attr('title','结束日期大于选择的DM的活动开始日 - 物流准备天数');
	 * $("input[name='stEndDate']").addClass('errorInput'); return false;
	 *  }
	 */
}

function stEndDateQuery(dp) {
	// 通过接口获取物流准备天数RP_DM.SCM_PREP_DAYS
	$("input[name='stEndDate']").attr('title', '');
	$("input[name='stEndDate']").removeClass('errorInput');
	var stBeginDate = $("input[name='stBeginDate']").val();
	var stEndDate = dp.cal.getNewDateStr();
	var stEndDateStr = $.trim($("#crStCnfrmEndDate").val());
	if (stEndDateStr !== stEndDateStr) {
		top.jConfirm("确定修改则清空商品列表，确定要修改?", "提示信息", function(ret) {
			if (ret) {
				// 清空商品信息和门店信息
				planHandler.clearItemAndStore(/* Null */);
			}
		});
	}
	var dmbeginDate = $("#crRdmBeginDate").val();
	var scmPrepDays = $("#crRdmNo option:selected").attr("scmPrepDays");
	var subDays2 = getSubDays(stEndDate, dmbeginDate);
	if (stBeginDate) {
		var subDays1 = getSubDays(stBeginDate, stEndDate);

		if (subDays1 < 0) {
			$("input[name='stEndDate']").attr('title', '结束日期小于开始日期');
			$("input[name='stEndDate']").addClass('errorInput');
			return false;
		}
		if (subDays2 <= scmPrepDays) {
			$("input[name='stEndDate']").attr('title',
					'结束日期大于选择的DM的活动开始日 - 物流准备天数');
			$("input[name='stEndDate']").addClass('errorInput');
			return false;

		}
	}
}
function repBeginDateQuery(dp) {
	$("input[name='repBeginDate']").attr('title', '');
	$("input[name='repBeginDate']").removeClass('errorInput');
	var repBeginDate = dp.cal.getNewDateStr();
	var dmBeginDate = $("input[name='dmBeginDate']").val();
	var stEndDate = $("input[name='stEndDate']").val();
	var repEndDate = $("input[name='repEndDate']").val();
	if (stEndDate) {
		var subDays1 = getSubDays(repBeginDate, stEndDate);
		var subDays2 = getSubDays(repBeginDate, dmBeginDate);
		if (subDays1 > 0) {
			$("input[name='repBeginDate']").attr('title', '补货开始日期小于门店确认结束日期');
			$("input[name='repBeginDate']").addClass('errorInput');
			return false;
		}
		if (subDays2 < 0) {
			$("input[name='repBeginDate']").attr('title', '补货开始日期大于DM活动开始日期');
			$("input[name='repBeginDate']").addClass('errorInput');
			return false;
		}

	}
	if (repEndDate) {
		var subDays3 = getSubDays(repBeginDate, repEndDate);
		if (subDays3 < 0) {
			$("input[name='repBeginDate']").attr('title', '补货开始日期大于补货结束日期');
			$("input[name='repBeginDate']").addClass('errorInput');
			return false;
		}
	}
}

function repEndDateQuery(dp) {
	$("input[name='repEndDate']").attr('title', '');
	$("input[name='repEndDate']").removeClass('errorInput');
	var repBeginDate = $("input[name='repBeginDate']").val();
	var repEndDate = dp.cal.getNewDateStr();
	if (repBeginDate) {
		var subDays1 = getSubDays(repBeginDate, repEndDate);
		if (subDays1 < 0) {
			$("input[name='repEndDate']").attr('title', '补货结束日期小于补货开始日期');
			$("input[name='repEndDate']").addClass('errorInput');
			return false;
		}
	}
}

/**
 * 日期验证
 * 
 * @param beginDateStr
 * @param endDateStr
 * @returns {Boolean}(false:结束<开始,true:结束>开始)
 */
function checkDate(/* String */beginDateStr, /* String */endDateStr) {
	var beginDate = new Date(beginDateStr.replace(/-/g, "/"));
	var endDate = new Date(endDateStr.replace(/-/g, "/"));
	var result = (endDate.getTime() - beginDate.getTime()) / (1000 * 60 * 60);
	if (result < 0) {
		return false;
	} else {
		return true;
	}
}