<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/page/create_Supplier343.css" />
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/supplier/supplierCommon.js" charset="gbk" type="text/javascript"></script>
<script src="${ctx}/shared/js/supplier/supplierCreateStoreSecInfo.js" charset="gbk" type="text/javascript"></script>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<style type="text/css">
.cmt1:hover {
	background: #99cc66;
	color: #fff;
}

.week21 div:hover {
	background: #a5d7d7;
}

.div_left,.div_middle,.div_right {
	width: 33%;
	float: left;
	height: 100%
}

.list_ex2_none {
	display: none;
}

#oneStore {
	padding-right: 20px;
	float: left;
	min-width: 100px;
	line-height: 20px;
}

.storeNameArea {
	overflow: auto;
}
</style>
<script type="text/javascript">
	//页面元素值是否变化
	var elementChange  = false;
	var supNoStr = ''; //存储已经下传的课
	$(function() {
		<c:if test="${action == 'create'}">
			$('.CInfo').css("background-image","url(${ctx}/shared/themes/${theme}/images/a343.jpg)");
	   	</c:if>
	   	<c:if test="${action == 'update'}">
	   		$('.CInfo').css("background-image","url(${ctx}/shared/themes/${theme}/images/s343.jpg)");
	   	</c:if>
	   	
		$('#keydownDiv').bind('mousedown', function() { 
			elementChange = true;
		});
		
		if('${from}'=='generalInfo'){
			$.post(ctx + "/supplier/getSupplierSectionCatalogBySupNo", {
				supNo : "${supNo}"
			}, function(data) {
				$.each(data,function(index,item){
					
					supNoStr = "," + supNoStr + item.catlgId;
				});
			});
		}
	});
	$('.tagsM').die('click');

	//生成下传区域
	function getStoreLoadArea(list,key1,key2){
		var array1 = [];
		var array2 = [];
		for (var i = 0; i < list.length; i++) {
			array1.push(list[i][key1]);
		}
		for (var i = 0; i < list.length; i++) {
			array2.push(list[i][key2]);
		}
		var output="";
		output = output + "<div class=\"list_ex21\" >"; 
		$.each(array2, function(index, value){
			output = output + "<div id=\"oneStore\">" + value+ "<input"+ 
			" type=\"hidden\" name=\"oneStoreNo\" value=\""+array1[index]+"\"/>"+
			"<input type=\"hidden\" name=\"oneStoreName\" value=\""+value+"\"/>"+
			"</div>";
		});	
		output = output + "</div>";
		return output;
	}
	// Display a remove icon while approaching a store in a group
	$('#oneStore').die().live({
		mouseenter : function() {
			$(this).append("<div class=\"store_close\" style=\"float:right;\" onclick=\"removeStore($(this))\"></div>");
		},
		mouseleave : function() {
			$(this).find('div').remove();
		}
	});
	// remove the store
	function removeStore(obj){
	 var store=obj.parent();
	 var storeNo=$(store).find("input[name=oneStoreNo]").val();
	 var storeName=$(store).find("input[name=oneStoreName]").val();
		//search catalog index
		var cataIndex = null;
		$.each(viewModel.cataInfoList(), function(index, item) {
			if (item.catlgId() == viewModel.catlgId()) {
				cataIndex = index;
				return false;
			}
		});
		var storeIndex = null;
		$.each(viewModel.cataInfoList()[cataIndex].storeOrderInfoList(),
				function(index, item) {					
              if(!(item.storeName().indexOf(storeName)<0)){
            	  storeIndex=index;
            	  return false;
              }
			});
		var storeNoStr=(viewModel.cataInfoList()[cataIndex].storeOrderInfoList()[storeIndex].storeNo()+',').replace(storeNo+',','');
		var storeNoStr1=storeNoStr.substring(0,storeNoStr.length-1);
		var storeNameStr=(viewModel.cataInfoList()[cataIndex].storeOrderInfoList()[storeIndex].storeName()+',').replace(storeName+',','');
		var storeNameStr1=storeNameStr.substring(0,storeNameStr.length-1);
		viewModel.cataInfoList()[cataIndex].storeOrderInfoList()[storeIndex].storeNo(storeNoStr1);
		viewModel.cataInfoList()[cataIndex].storeOrderInfoList()[storeIndex].storeName(storeNameStr1);
		$(obj).parent().remove();
		var array1 = storeNoStr1.split(',');
		var array2 = storeNameStr1.split(',');
		var output="";
		output = output + "<div class=\"list_ex21\" >"; 
		$.each(array2, function(index, value){
			output = output + "<div id=\"oneStore\">" + value+ "<input"+ 
			" type=\"hidden\" name=\"oneStoreNo\" value=\""+array1[index]+"\"/>"+
			"<input type=\"hidden\" name=\"oneStoreName\" value=\""+value+"\"/>"+
			"</div>";
		});	
		output = output + "</div>";
		viewModel.cataInfoList()[cataIndex].storeOrderInfoList()[storeIndex].storeNameArea(output);
		//if storeNo and storeName is null,remove the storeOrderList[index] item.
		if(storeNoStr1==undefined||storeNoStr1==""){
			viewModel.cataInfoList()[cataIndex].storeOrderInfoList.remove(viewModel.cataInfoList()[cataIndex].storeOrderInfoList()[storeIndex]);
		}
		
		
	}
	//添加下传区域信息(确定后回调函数)
	function confirmSelectArea(list){
		closePopupWin();
		var storeNo = joinObject(list,'storeNo',',');
		var storeName = joinObject(list,'storeName',',');
		 var storeNameArea=getStoreLoadArea(list,'storeNo','storeName');
		var grpId = new Date().format('yyyyMMddhhmmssSSS');
		
		$.each(viewModel.cataInfoList(),function(index,item){
			if(item.catlgId() == viewModel.catlgId()){
				
				//下传区域信息默认拷贝第一个组设置的信息(袁航要求)。
				var oldObj = viewModel.cataInfoList()[index].storeOrderInfoList()[0];
				var newObj = null;
				if(oldObj){
					newObj = new supplierCreateStoreSecInfo.StoreOrderInfo(grpId,storeNo,storeName, oldObj.cataStatus(),
							oldObj.minOrdAmt(),oldObj.rtnAllow(),oldObj.leadTime(),oldObj.oplSched().toString(),
							oldObj.dlvrySched().toString(),oldObj.supOrdAddr().addrId(),
							oldObj.supRtnAddr().addrId(),true,storeNameArea);
					
				}else{
					newObj = new supplierCreateStoreSecInfo.StoreOrderInfo(grpId,storeNo,storeName,'','',
							'','','','','','',true,storeNameArea);
				}
				
				$.each(viewModel.cataInfoList()[index].storeOrderInfoList(),function(index,store){
					
					store.visible(false);
				});
				viewModel.cataInfoList()[index].storeOrderInfoList().push(newObj);
				viewModel.cataInfoList()[index].storeOrderInfoList(viewModel.cataInfoList()[index].storeOrderInfoList());				
				return false;
			}
		});
	}
	
	//选择定退货地址(确定后回调函数)
	function confirmChooseSupAddress(addrId){
		closePopupWin();
		$(viewModel.tmpVal()).find('input').attr('value',addrId).trigger('change');
		//清空临时变量的值 
		viewModel.tmpVal('');
	}

	//选择课别(确定后回调函数)
	function confirmChooseSection(id,name){
		if('${from}'=='generalInfo'){
			if(supNoStr.indexOf(','+id)>=0){
				top.jAlert('warning', '该课别已经下传过了,不能重复添加', '提示消息');
				return;
			}
		}

		closePopupWin();
		//当前处课已经选中过了，则跳过
		var exists = false;
		$.each(viewModel.cataInfoList(), function(index, item) {
			if (item.catlgId() == id) {
				exists = true;
				return false;
			}
		});
		if (exists) {
			top.jAlert('warning', '该课别已经被添加了,不能重复添加', '提示消息');
			return;
		}

		var visible = false;
		if (viewModel.cataInfoList().length == 0) {
			visible = true;
		}
		viewModel.cataInfoList.push(new supplierCreateStoreSecInfo.CataInfo(id,
				name, '', '', '', [], visible));
		//新增课别默认选中
		$.each(viewModel.cataInfoList(), function(index, item) {
			if (item.catlgId() == id) {
				item.visible(true);
			} else {
				item.visible(false);
			}
		});
		var index = viewModel.cataInfoList().length - 1;
		viewModel.cataInfoList()[index].chooseDownLoadArea();
		//标识该页信息已经发生变化
		elementChange = true;
	}
	var viewModel = new supplierCreateStoreSecInfo.ViewModel('${supNo}',
			'${taskId}', '${comNo}', '${action}', '${from}');
	ko.applyBindings(viewModel);
	//从总览界面过来不显示之前已经下传的课
	if ('${from}' != 'generalInfo') {
		viewModel.initCataInfoList();
	}
	
	//默认显示第一个课，第一个下传区域
	if (viewModel.cataInfoList().length > 0) {
		viewModel.cataInfoList()[0].visible(true);
		viewModel.catlgId(viewModel.cataInfoList()[0].catlgId());
		if (viewModel.cataInfoList()[0].storeOrderInfoList().length > 0) {
			viewModel.cataInfoList()[0].storeOrderInfoList()[0].visible(true);
		}
	}

    //如果没有课别，则默认弹出选择课别弹出框
	if(viewModel.cataInfoList().length == 0){
		supplierCommon.selectDivision('1');
	}

	//上一步（从总览界面过来的时候）
	if ('${from}' != 'generalInfo') {

		$('.div_left').unbind('click').bind('click',function() {
			sep1();
		});

		$('.div_middle').unbind('click').bind('click',function() {
			sep2();
		});

		//第一步
		function sep1(){
			var param = {'supNo':viewModel.supNo(),'taskId':viewModel.taskId(),'comNo':viewModel.comNo(),'action':viewModel.action()};
			if(elementChange){
				top.jConfirm('页面还有信息未保存，你确定要离开本页面吗?','提示消息',function(ret){
					if(ret){
						$.post(ctx + '/supplierAudit/createSupplier',param,function(data){
							$("#content").html(data);
						},'html');
					}
				});
			}else{
				$.post(ctx + '/supplierAudit/createSupplier',param,function(data){
					$("#content").html(data);
				},'html');
			}
		}

		//第二步
		function sep2(){
			var param = {
				'supNo' : viewModel.supNo(),
				'taskId' : viewModel.taskId(),
				'comNo' : viewModel.comNo(),
				'action' : viewModel.action()
			};
			if(elementChange){
				top.jConfirm('页面还有信息未保存，你确定要离开本页面吗?','提示消息',function(ret) {
					if (ret) {
						$.post(ctx + '/supplierAudit/createSupPayment',param,function(data){
							$("#content").html(data);
						},'html');
					}
				});
			}else{
				$.post(ctx + '/supplierAudit/createSupPayment',param,function(data){
					$("#content").html(data);
				},'html');
			}
		}
		
		$('#Tools24').removeClass('Tools24_disable').addClass('Tools24').unbind('click').bind('click',function() {
			sep2();
		});		
	}
	//保存按钮
	$("#Tools2").attr('class', "Tools2").unbind('click').bind("click",function() {
		viewModel.save('save');
		elementChange = false;
	});

	//检测任务是否可以被提交
	var canEdit = true;
	if('${taskId}' != '' && '${from}' != 'generalInfo'){
		$.ajax({
			type : "post",
			url : ctx + '/workspace/task/checkSupplierCanEdit',
			async : false,
			dataType : "json",
			data : {
				'taskId' : '${taskId}'
			},
			success : function(data) {
				canEdit = data;
			}
		});
	}
	if(canEdit){
		$("#Tools26").attr('class', "Tools26").unbind('click').bind("click",function() {
			viewModel.save('submit');
			elementChange = false;
		});
	}

	$('#selectSection').unbind('click').bind("click", function() {
		// 添加课的时候，先验证表单(填写完整后才允许添加新的课)
		viewModel.errors = ko.validation.group(viewModel);
		if (!viewModel.isValid()) {
			viewModel.errors.showAllMessages();
			return;
		}
		supplierCommon.selectDivision('1');
	});
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<c:if test="${from != 'generalInfo'}">
<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">
		<c:if test="${action == 'create'}">
       		创建厂商
       	</c:if>
       	<c:if test="${action == 'update'}">
       		修改厂商
       	</c:if>
	</div>
	<div class="tags tags3_r_on"></div>
</div>
</c:if>
<c:if test="${from == 'generalInfo'}">
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left"></div>
	<div class="tagsM tagsM"><!-- 厂商总览 --><auchan:i18n id="102006001"/></div>
	<div class="tags tags_left"></div>

	<!--中间-->
	<div class="tagsM">厂商财务信息</div>
	<div class="tags"></div>

	<!--最后一个-->
	<div class="tagsM"><!-- 厂商供应区域 --><auchan:i18n id="102008001"/></div>
	<div class="tags tags3 tags_right_on"></div>
	
	<div class="tagsM tagsM_on">新增厂商门店课别信息</div>
	<div class="tags tags3_r_on"></div>
</div>
</c:if>
<div class="Container-1">
	<div class="Content" style="width: 99%;">
		<!--width:74%;-->
		<c:if test="${from != 'generalInfo'}">
			<!-- 修改的时候，从总览界面新增门店课别信息 -->
			<div class="CInfo">
		        <div class="div_left"></div>
				<div class="div_middle"></div>
				<div class="div_right"></div>
	        </div>
	    </c:if>
	    <div id="keydownDiv">
	    <c:if test="${from == 'generalInfo'}">
	    	<div>
	            <span><!-- 采购厂编 --><auchan:i18n id="102006003"/>&nbsp;</span>
	            <input type="text" class="inputText w10 Black" value="${supNo}" readonly="readonly">
	            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 公司编号 --><auchan:i18n id="102006049"/>&nbsp;</span>
	            <input type="text" class="inputText w7 Black" value="${comNo}" readonly="readonly"><span>&nbsp;</span>
	            <input type="text" class="inputText w15 Black"  value="${comName}" readonly="readonly">
            </div>
	    </c:if>
		<!--539-->
		<div class="t_div2 CM">
			<div data-bind="foreach: cataInfoList">
				<div class="td2_1" data-bind="event:{click:switchSection},css:visible()==true?'GreenBg':''">
					<input type="hidden" name="catlgId" data-bind="value:catlgId"/>
					<span data-bind="text:catlgId"></span>-
					<span data-bind="text:catlgName"></span>
				</div>
			</div>
			<c:if test="${action == 'create'}">
	        	<div class="Tools11 Icon-size2 fl_left" id="selectSection" title="新增" style="float: right; margin-top: 13px; margin-right: 15px;"></div>
	        </c:if>
		</div>

		<div data-bind="foreach: cataInfoList">
			<div data-bind="visible:visible">
				<div class="CM fx_div1">
					<div class="CM-bar" style="height: 60px;">
						<div>公共</div>
					</div>
					<div class="CM-div">
					<table class="CM_table">
						<tr>
							<td class="w10">
								<span><!-- 采购范围 --><auchan:i18n id="102006027"/></span>
							</td>
							<td  class="w20">
								<input type="text" class="inputText w80" data-bind="value:ordScope" maxlength="25"/>
							</td>
							<td  class="w10">
								<span><!-- 备注 --><auchan:i18n id="102006028"/></span>
							</td>
							<td  class="w20">
								<input type="text" class="inputText w80" data-bind="value:buyrMemo" maxlength="25"/>
							</td>
							<td  class="w10">
								<span><!-- 新店折扣 --><auchan:i18n id="102006030"/></span>
							</td>
							<td  class="w20">
								<input type="text" class="inputText w20" data-bind="value:newStDiscDays,validationElement:newStDiscDays" maxlength="4"/>
							</td>
						</tr>
					</table>
					</div>
				</div>

				<div class="f_div">
					<div class="CM f_div1">
						<div class="CM-bar" style="height: 340px;">
							<div>下传区域</div>
						</div>
						<div class="list_ex">
							<div data-bind="foreach: storeOrderInfoList">
							<div class="list_ex0" data-bind="event:{click:switchStoreGroup},css:visible()==true?'list_ex0_on':''">
								<input type="hidden" name="switchStoreGroup"/>
								<div class="list_ex1">
									<div class="ssuo list_ex11 Icon-size1"></div>
									<div class="longText list_ex12" data-bind="text:storeName"></div>
									<!-- <div class="Icon-size2 Tools12 list_ex13"></div> -->
									<div class="list_ex14 Icon-size2 Tools10" data-bind="event:{click:delStoreGroupInfo}"></div>
								</div>
							     <div class="list_ex2 storeNameArea" data-bind="html:storeNameArea">
								</div>
							</div>
							</div>
						</div>
						<div style="height: 30px; width: 85%; margin: 0 auto;">
							  <c:choose>
								<c:when test="${action == 'update'}">
									<div class="ListWin cmt2" data-bind="event:{click:chooseDownLoadArea}" style="float: left">
									</div>
									<span class="fl_left" style="line-height: 20px;">&nbsp;&nbsp;选择修改下传门店</span>
								</c:when>
								<c:otherwise>
									<div class="Icon-size2 Tools11 fl_left" data-bind="event:{click:chooseDownLoadArea}"></div>
									<span class="fl_left" style="line-height: 20px;">&nbsp;&nbsp;新增下传区域</span>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div data-bind="foreach: storeOrderInfoList">
					<div class="CM f_div2" data-bind="visible:visible">
						<div class="f_div21">
							<div class="CM-bar" style="height: 150px;">
								<div><!-- 订单信息 --><auchan:i18n id="102006066"/></div>
							</div>
							<div class="CM-div">
							<table class="CM_table">
								<tr>
									<td>
										<span><!-- 门店课别状态 --><auchan:i18n id="102006029"/></span>
									</td>
									<td class="w15">
										<select data-bind="value:cataStatus">
											<c:choose>
												<c:when test="${action == 'create'}">
													<option value="0">0-未生效</option>
												</c:when>
												<c:otherwise>
													<option value=""><auchan:i18n id="100000009"/></option> 
													<option value="1">1-正常</option>
													<option value="2">2-禁止下单</option>
													<option value="8">8-进入删除</option>
												</c:otherwise>
											</c:choose>
										</select>
									</td>
									<td>
										<c:if test="${action=='update'}">
											<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 总应付余额 --><auchan:i18n id="102006025"/></span>
											<input type="text" class="inputText twoInput2 Black" value="${totApAmt}"  readonly="readonly" style="width:75px">
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="w25">
										<span><c:if test="${action == 'create'}">*</c:if><!-- 最低订购(MOC) --><auchan:i18n id="102006031"/></span>
									</td>
									<td class="w20">
										<input type="text" class="inputText w78" data-bind="value:minOrdAmt,validationElement:minOrdAmt" maxlength="10" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
										元
									</td>
									<td class="w55" rowspan="3">
										<div class="schedule">
											<div style="height: 25px;">
												<div class="wtitle">&nbsp;</div>
												<div class="week week20" style="width:51%">
													<div>一</div>
													<div>二</div>
													<div>三</div>
													<div>四</div>
													<div>五</div>
													<div>六</div>
													<div>日</div>
												</div>
											</div>
											<div style="height: 1px; background: #999999; overflow: hidden; width: 85%;"></div>
											<div style="height: 25px;">
												<div class="wtitle">
													<span><c:if test="${action == 'create'}">*</c:if><!-- OPL订货行程 --><auchan:i18n id="102006034"/></span>
												</div>
												<div class="week week21" data-bind="validationElement:oplSched">
													<div data-bind="event:{click:oplSched().monClick},css:oplSched().mon()=='1'?'weekon':''"></div>
													<div data-bind="event:{click:oplSched().tueClick},css:oplSched().tue()=='1'?'weekon':''"></div>
													<div data-bind="event:{click:oplSched().wedClick},css:oplSched().wed()=='1'?'weekon':''"></div>
													<div data-bind="event:{click:oplSched().thuClick},css:oplSched().thu()=='1'?'weekon':''"></div>
													<div data-bind="event:{click:oplSched().friClick},css:oplSched().fri()=='1'?'weekon':''"></div>
													<div data-bind="event:{click:oplSched().satClick},css:oplSched().sat()=='1'?'weekon':''"></div>
													<div data-bind="event:{click:oplSched().sunClick},css:oplSched().sun()=='1'?'weekon':''"></div>
												</div>
												<input type="checkbox" data-bind="checked: oplSched().checkAll,event:{change:oplSched().checkAllClick}" style="margin-top: 7px;">
												<!--<div class="icondiv2 Rect2Close"></div>-->
											</div>
											<div style="height: 25px;">
												<div class="wtitle">
													<span><c:if test="${action == 'create'}">*</c:if><!-- 送货行程 --><auchan:i18n id="102006036"/></span>
												</div>
												<div class="week week21" data-bind="validationElement:dlvrySched">
													<div data-bind="event:{click:dlvrySched().monClick},css:dlvrySched().mon()=='1'?'weekon':''"></div>
													<div data-bind="event:{click:dlvrySched().tueClick},css:dlvrySched().tue()=='1'?'weekon':''"></div>
													<div data-bind="event:{click:dlvrySched().wedClick},css:dlvrySched().wed()=='1'?'weekon':''"></div>
													<div data-bind="event:{click:dlvrySched().thuClick},css:dlvrySched().thu()=='1'?'weekon':''"></div>
													<div data-bind="event:{click:dlvrySched().friClick},css:dlvrySched().fri()=='1'?'weekon':''"></div>
													<div data-bind="event:{click:dlvrySched().satClick},css:dlvrySched().sat()=='1'?'weekon':''"></div>
													<div data-bind="event:{click:dlvrySched().sunClick},css:dlvrySched().sun()=='1'?'weekon':''"></div>
												</div>
												<input type="checkbox" data-bind="checked: dlvrySched().checkAll,event:{change:dlvrySched().checkAllClick}" style="margin-top: 7px;">
												<!--<div class="icondiv2 Rect2Close"></div>-->
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<span><c:if test="${action == 'create'}">*</c:if><!-- 准备天数 --><auchan:i18n id="102006035"/></span>
									</td>
									<td>
										<input type="text" class="inputText w78" data-bind="value:leadTime,validationElement:leadTime" maxlength="3" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
										天
									</td>
								</tr>
								<tr>
									<td>
										<span><c:if test="${action == 'create'}">*</c:if><!-- 可否退货 --><auchan:i18n id="102006033"/></span>
									</td>
									<td>
										<auchan:select mdgroup="SUP_STORE_SEC_INFO_RTN_ALLOW" _class="w87" dataBind="value:rtnAllow,validationElement:rtnAllow"  />
									</td>
								</tr>
							</table>
							</div>
						</div>
						<div class="f_div22">
							<div class="CM-bar" style="height: 188px;">
								<div><!-- 订货退货地址 --><auchan:i18n id="102006068"/></div>
							</div>
							<div class="CM-div">
							<table class="CM_table">
								<tr>
									<td colspan="2" style="line-height: 18px;">
										<div class="cmt1" data-bind="event:{click:clickAddress},css:showAddressIndex()=='0'?'GreenBg':''">
											<input type="hidden" value="0"><!-- 订货地址 --><auchan:i18n id="102006054"/>
										</div>
										<div class="cmt1" data-bind="event:{click:clickAddress},css:showAddressIndex()=='1'?'GreenBg':''">
											<input type="hidden" value="1"><!-- 退货地址 --><auchan:i18n id="102006055"/>
										</div>
										<div class="ListWin cmt2" data-bind="event:{click:chooseSupAddress}">
											<input type="text" data-bind="value:selectAddressId" style="display: none">
										</div>
										<div class="cmt3">
											<div style="width: 20px; height: 30px; float: left;">
												<input type="checkbox" style="margin-top: 6px; *margin-top: 3px;" data-bind="checked:relatedAddress" />
												&nbsp;
											</div>
											<div class="Line-1 td2_5" style="margin-top: 2px;"></div>
											<div class="cmt32">订货退货地址关联</div>
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="height: 10px; overflow: hidden;">
										<div class="line"></div>
									</td>
								</tr>
								<!-- 订货地址 -->
								<tr data-bind="visible:supOrdAddr().visible">
									<td style="width: 20%;">
										<span><!-- 地址 --><auchan:i18n id="102006014"/></span>
									</td>
									<td>
										<div class="iconPut" style="width: 20%; float: left;">
											<input type="text" style="width: 72%;"
												data-bind="value:supOrdAddr().provName,validationElement:supOrdAddr().provName" readonly="readonly" />
											<div style="color: #999999;"><!-- 省 --><auchan:i18n id="100000010"/></div>
										</div>
										<div class="iconPut"
											style="width: 30%; float: left; margin-left: 3px;">
											<input type="text" style="width: 62%;"
												data-bind="value:supOrdAddr().cityName,validationElement:supOrdAddr().cityName" readonly="readonly"/>
											<div style="color: #999999;"><!-- 市 --><auchan:i18n id="100000010"/></div>
										</div>
									</td>
								</tr>
								<tr data-bind="visible:supOrdAddr().visible">
									<td>&nbsp;</td>
									<td>
										<input type="text" class="inputText w91_s232" data-bind="value:supOrdAddr().detailAddr,validationElement:supOrdAddr().detailAddr" readonly="readonly"/>
									</td>
								</tr>
								<tr data-bind="visible:supOrdAddr().visible">
									<td>
										<span>邮编</span>
									</td>
									<td>
										<input type="text" class="inputText twoinput25" data-bind="value:supOrdAddr().postCode,validationElement:supOrdAddr().postCode" readonly="readonly"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 联系人 --><auchan:i18n id="102006016"/>&nbsp;</span>
										<input type="text" class="inputText twoinput25" data-bind="value:supOrdAddr().cntctName" readonly="readonly"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 传真 --><auchan:i18n id="102006017"/>&nbsp;</span>
										<input type="text" class="inputText twoinput22" data-bind="value:supOrdAddr().areaCode" readonly="readonly"/>
										<span style="float: left; margin: 0;">-</span>
										<input type="text" class="inputText twoinput23" data-bind="value:supOrdAddr().faxNo" readonly="readonly"/>
									</td>
								</tr>
								<tr data-bind="visible:supOrdAddr().visible">
									<td>
										<span><!-- 固话 --><auchan:i18n id="102006018"/></span>
									</td>
									<td>
										<input type="text" class="inputText twoinput22" data-bind="value:supOrdAddr().areaCode,validationElement:supOrdAddr().areaCode" readonly="readonly"/>
										<span style="float: left; margin: 0;">-</span>
										<input type="text" class="inputText twoinput26" data-bind="value:supOrdAddr().phoneNo,validationElement:supOrdAddr().phoneNo" readonly="readonly"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 移动 --><auchan:i18n id="102006019"/></span>
										<input type="text" class="inputText twoinput27" data-bind="value:supOrdAddr().moblNo,validationElement:supOrdAddr().moblNo" readonly="readonly" style="width:20%"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 电邮 --><auchan:i18n id="102006020"/></span>
										<input type="text" class="inputText twoinput28" data-bind="value:supOrdAddr().emailAddr,validationElement:supOrdAddr().emailAddr" readonly="readonly" style="width:28%"/>
									</td>
								</tr>
								<!-- 退货地址 -->
								<tr data-bind="visible:supRtnAddr().visible">
									<td style="width: 20%;">
										<span><!-- 地址 --><auchan:i18n id="102006014"/></span>
									</td>
									<td>
										<div class="iconPut" style="width: 20%; float: left;">
											<input type="text" style="width: 72%;"
												data-bind="value:supRtnAddr().provName,validationElement:supRtnAddr().provName" readonly="readonly" />
											<div style="color: #999999;"><!-- 省 --><auchan:i18n id="100000010"/></div>
										</div>
										<div class="iconPut"
											style="width: 30%; float: left; margin-left: 3px;">
											<input type="text" style="width: 62%;"
												data-bind="value:supRtnAddr().cityName,validationElement:supRtnAddr().cityName" readonly="readonly"/>
											<div style="color: #999999;"><!-- 市 --><auchan:i18n id="100000010"/></div>
										</div>
									</td>
								</tr>
								<tr data-bind="visible:supRtnAddr().visible">
									<td>&nbsp;</td>
									<td>
										<input type="text" class="inputText w91_s232" data-bind="value:supRtnAddr().detailAddr,validationElement:supRtnAddr().detailAddr" readonly="readonly"/>
									</td>
								</tr>
								<tr data-bind="visible:supRtnAddr().visible">
									<td>
										<span>邮编</span>
									</td>
									<td>
										<input type="text" class="inputText twoinput25" data-bind="value:supRtnAddr().postCode,validationElement:supRtnAddr().postCode" readonly="readonly"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 联系人 --><auchan:i18n id="102006016"/>&nbsp;</span>
										<input type="text" class="inputText twoinput25" data-bind="value:supRtnAddr().cntctName" readonly="readonly"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 传真 --><auchan:i18n id="102006017"/>&nbsp;</span>
										<input type="text" class="inputText twoinput22" data-bind="value:supRtnAddr().areaCode" readonly="readonly"/>
										<span style="float: left; margin: 0;">-</span>
										<input type="text" class="inputText twoinput23" data-bind="value:supRtnAddr().faxNo" readonly="readonly"/>
									</td>
								</tr>
								<tr data-bind="visible:supRtnAddr().visible">
									<td>
										<span><!-- 固话 --><auchan:i18n id="102006018"/></span>
									</td>
									<td>
										<input type="text" class="inputText twoinput22" data-bind="value:supRtnAddr().areaCode,validationElement:supRtnAddr().areaCode" readonly="readonly"/>
										<span style="float: left; margin: 0;">-</span>
										<input type="text" class="inputText twoinput26" data-bind="value:supRtnAddr().phoneNo,validationElement:supRtnAddr().phoneNo" readonly="readonly"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 移动 --><auchan:i18n id="102006019"/></span>
										<input type="text" class="inputText twoinput27" data-bind="value:supRtnAddr().moblNo,validationElement:supRtnAddr().moblNo" readonly="readonly" style="width:20%"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 电邮 --><auchan:i18n id="102006020"/></span>
										<input type="text" class="inputText twoinput28" data-bind="value:supRtnAddr().emailAddr,validationElement:supRtnAddr().emailAddr" readonly="readonly" style="width:28%"/>
									</td>
								</tr>
								
							</table>
							</div>
						</div>
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</div>