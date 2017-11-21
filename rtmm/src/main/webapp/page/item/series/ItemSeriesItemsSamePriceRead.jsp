<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="${ctx}/shared/js/workspace/report.js"></script>
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<%@ include file="/page/commons/toolbar.jsp"%>

<script type="text/javascript">

	//定义修改商品列表，在没有保存前不允许重复添加
	var itemsList = new Array(); //存储基础信息
	var items = new Array(); //基础的集合信息（修改后）
	var itemsAdd = new Array(); //增加信息列表的集合信息
	var itemsDelete = new Array(); //删除信息列表的集合信息	
	// 让bar中的某个菜单可用(编辑)
	<auchan:operauth ifAnyGrantedCode="112211996" >
		$('#Tools12').removeClass('Tools12_disable')
				.addClass('Tools12')
				.bind('click',function() {
							showContent(ctx+'/series/toUpdateSeries?clstrId=${itemClusterVO.clstrId }');
						});
	</auchan:operauth>
	
	//返回列表页面
	$('#Tools21')
	.removeClass('Tools21_disable')
	.addClass('Tools21')
	.bind('click',function() {
				showContent(ctx+'/series/seriesList');
			});

	$(function() {
		//加载当前列表信息
		readSeriesByClstrId(1, 100, loadPageInfo);
		//加载系列课别信息
		readSectionInfoBycatlgId();

		//设置所有的输入标签为只读
		$("input:not(:button,:hidden)").prop("readonly", "readonly");

	
		//关闭详情页面选项卡

		$("#closeUpdateSeriesPage").click(function() {
			showContent('/series/seriesList');
		});

	

		//设置默认的选中框		
		$("#searchClstrType").val("${itemClusterVO.clstrType}");
		//设置checkbox选中		
		if ("${itemClusterVO.batchPriceChngInd}" == 1) {
			$("#updateBatchPriceChngInd").attr("checked", "checked");
		}
		$("#searchStatus").val(
						getDictValue('ITEM_STORE_INFO_STATUS',
								'${itemBasicVO.status }'));

   var item_status="${itemBasicVO.status }";
		if(item_status =="8"|| item_status=="9"){
			top.jAlert("warning","该系列的代表商品状态为删除或者进入删除","提示信息");
			}
	});


	//为相应的层添加信息
	function addItem(ItemNo, itemName, catlgName, brandName, stdBuyPrice,
			stdSellPrice, status, secAttrValName1, secAttrValName2,
			secAttrValName3, secAttrValName4,brandId,catlgId) {
		 var brandInfo ="";              
			if(brandId!=null){
				brandInfo=brandId+"-"+brandName;
				}
		$("#seriesItemList").append(
						"<div class='ig' style='margin-top: 5px; margin-left: 10px;'>"
								+ "<input type='hidden' name='searchItemNo' value='"+ItemNo+"'/> "
								+ "<input type='text' readonly='readonly' class='w7 inputText Black' value='"+ItemNo+"'/> "
								+ "<input type='text' readonly='readonly' class='w10 inputText longText' value='"
								+ setNulltoEmpty(itemName)								
								+ "'/> <input type='text'"
								+ "class='w10 inputText' readonly='readonly' value='"
								+ setNulltoEmpty(catlgName)
								+ "' /> <input type='text'"
								+ "class='w10 inputText' readonly='readonly' value='"
								+ brandInfo
								+ "'/> <input type='text'"
								+ "class='w7 inputText' readonly='readonly' value='"
								+ setNulltoEmpty(secAttrValName1)
								+ "' /> <input type='text'"
								+ "class='w7 inputText' readonly='readonly'  value='"
								+ setNulltoEmpty(secAttrValName2)
								+ "'/> <input type='text'"
								+ "class='w7 inputText'  readonly='readonly' value='"
								+ setNulltoEmpty(secAttrValName3)
								+ "'/> <input type='text'"
								+ "class='w7 inputText'  readonly='readonly' value='"
								+ setNulltoEmpty(secAttrValName4)
								+ "'/> <input type='text'"
								+ "class='w7 inputText' readonly='readonly'  value='"
								+ setNulltoEmpty(stdBuyPrice)
								+ "' /> <input type='text'"
								+ "class='w7 inputText' readonly='readonly' value='"
								+ setNulltoEmpty(stdSellPrice)
								+ "' /> <input type='text'"
								+ "class='w9 inputText' readonly='readonly'  value='"
								+ getDictValue('ITEM_STORE_INFO_STATUS', status)							
								+ "'/>" + "</div>");
	}

	//获取所有的选中信息并加载
	function readAllSearchItems(itemList) {
		//清空原来的所有信息
		$("#seriesItemList").empty();
		for ( var key in itemList) {
			//获取信息
			addItem(itemList[key].itemNo, 
					itemList[key].itemName, 
					itemList[key].catlgName, 
					itemList[key].brandName, 
					itemList[key].stdBuyPrice, 
					itemList[key].stdSellPrice, 
					itemList[key].status, 
					itemList[key].secAttrValName1, 
					itemList[key].secAttrValName2, 
					itemList[key].secAttrValName3, 
					itemList[key].secAttrValName4,
					itemList[key].brandId,
					itemList[key].catlgId);	
		}
          //给每一个input标签加入title
		$("#allSeriesListInfo :input").each(function(){
           $(this).attr("title",$(this).val());
			});
	}

	//加载信息
	function readSeriesByClstrId(pageNo, pageSize, methodName) {
		$.ajax({
			type : 'post',
			url : ctx + '/series/readSeriesItemsByClstrId?tt='
					+ new Date().getTime(),
			data : {
				clstrId : "${itemClusterVO.clstrId}",
				page : pageNo,
				rows : pageSize
			},
			success : function(data) {
				methodName(data);
                if(data.total>0){
                enableExportExcel(data.total);
                }
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				//这里是ajax错误信息
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});
	}
	//系列商品详情的导出
	function enableExportExcel(exportCount){
		$('#Tools23').removeClass('Tools23_disable').addClass('Tools23').unbind().bind('click',function() {
			if(exportCount>5000){
				 top.jAlert('warning', '请缩小查询范围到5000项以下', '提示消息');
				 return false;
			 }  
			 top.jAlert('success', '数据正在导出，请稍候...！', '提示消息');
			 var paramsObj= {};
			 paramsObj.clstrId="${itemClusterVO.clstrId}";
			 paramsObj.attr1Name=$.trim($("#base_secAttr1Name").val());
			 paramsObj.attr2Name=$.trim($("#base_secAttr2Name").val());
			 paramsObj.attr3Name=$.trim($("#base_secAttr3Name").val());
			 paramsObj.attr4Name=$.trim($("#base_secAttr4Name").val());
			 exportReport('sync','112211005',paramsObj); 
		});
		}
	//调用ajax函数信息，加载页码信息,页面加载时加载一次
	function loadPageInfo(data) {
		$('#pagesItemsSeries')
				.pagination(
						{
							total : data.total,
							pageSize : 100,
							showRefresh : false,
							showPageList : false,
							onSelectPage : function(pageNumber, pageSize) {
								if (loadItemsOff) {
									if (itemsAdd.length > 0|| itemsDelete.length > 0 ) {
										top.jConfirm(
														'已经有存在修改数据，需要保存？（友情提示，如果不保存，之前的操作信息在下一页不会保留）',
														'提示消息',
														function(ret) {
															if (ret) {
																//加载下一个页面信息
																clearAllItems();//清除相关的集合
																loadItemsInfos(pageNumber,pageSize);
															} else {
																loadItemsOff = false;
																$('#pagesItemsSeries').pagination('select',currentPageNo);
																readAllSearchItems(items);
																return;
															}
														});
									} else {
										//清空数据，从新加载数据
										clearAllItems();
										//分页加载数据
										loadItemsInfos(pageNumber, pageSize);
									}
								} else {
									loadItemsOff = true;//当开关关闭后，下次操作时再次打开			         
								}
							}
						});
		//加载第一页信息
		loadItemsInfos(1, 100);
	}

	var loadItemsOff = true;//定义加载数据开关
	var currentPageNo = 0;
	//封装页面产品信息，用于系列下所有产品信息，分页显示
	function loadItemsInfos(pageNo, pageSize) {
		currentPageNo = pageNo;
		$.ajax({
			type : 'post',
			url : ctx + '/series/readSeriesItemsByClstrId?tt='
					+ new Date().getTime(),
			data : {
				clstrId : "${itemClusterVO.clstrId }",
				page : pageNo,
				rows : pageSize
			},
			success : function(data) {
				if (data.rows.length > 0) {
					$(data.rows).each(function(index, item) {
						//封装集合信息
						if (item != null) {
							items.push(item);
							//基本信息，只用来存储从后台加载过来的信息
							itemsList.push(item.itemNo);
						}
					});
					//封装信息完成，开始加载新的信息
					readAllSearchItems(items);
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				//这里是ajax错误信息
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});
	}

	//清除集合信息
	function clearAllItems() {
		//每次分页后，清空当前操作集合信息 
		items = [];//操作信息
		itemsList = [];//基本信息
		itemsDelete = [];//删除操作
		itemsAdd = [];//增加信息操作
	}

	//验证信息，必须输入数字
	function isNumber(str) {
		var result = str.match(/^[0-9]{0,10}$/);
		if (result == null)
			return false;
		return true;
	}
	//如果值为null 则定义为‘’
	function setNulltoEmpty(str) {
		if (str == null) {
			str = "";
		}
		return str;
	}

	//根据课别Id获取课详细信息
	function readSectionInfoBycatlgId() {
		$.ajax({
			type : 'post',
			url : ctx + '/series/readSectionInfoByCatlgId?tt='
					+ new Date().getTime(),
			data : {
				catlgId : "${itemClusterVO.catlgId}",
			},
			success : function(data) {
				$("#base_secAttr1Name").val(data.secAttr1Name);
				$("#base_secAttr2Name").val(data.secAttr2Name);
				$("#base_secAttr3Name").val(data.secAttr3Name);
				$("#base_secAttr4Name").val(data.secAttr4Name);
				$("#updateCatlgName").val(data.catlgName);
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				//这里是ajax错误信息
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});

	}

	
	
</script>

<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left"></div>
	<div class="tagsM"><auchan:i18n id="103002018"></auchan:i18n></div>
	<div class="tags tags3 tags_right_on"></div>
	<!--一定不要忘了tag3-->
	<!--add-->
	<div class="tagsM_q  tagsM_on"><auchan:i18n id="103002019"></auchan:i18n></div>
	<div class="tags3_close_on">
		<div class="tags_close" id="closeUpdateSeriesPage"></div>
	</div>
</div>

<div class="Container-1">
	<div class="Content">
	
		<div class="CInfo">
			 <span><auchan:getStuffName value="${itemClusterVO.chngBy }"/></span> <span><auchan:i18n id="103001065"></auchan:i18n></span> <span> <c:if test="${itemClusterVO.chngDate ne null}" > <fmt:formatDate value="${itemClusterVO.chngDate }" pattern="yyyy-MM-dd"/> </c:if>     </span>
			<span><auchan:i18n id="103001064"></auchan:i18n></span> <span><auchan:getStuffName value="${itemClusterVO.creatBy}"/></span> <span><auchan:i18n id="103001063"></auchan:i18n></span> <span><c:if test="${itemClusterVO.chngDate ne null}" > <fmt:formatDate value="${itemClusterVO.creatDate }" pattern="yyyy-MM-dd" /> </c:if> </span>
			<span><auchan:i18n id="103001062"></auchan:i18n></span>
		</div> 

		<form id="updateNewSeries">
			<input type="hidden" id="updateAddItems" name="updateAddItems">
			<input type="hidden" id="updateDelItems" name="updateDelItems">

			<div style="height: 120px;" class="CM">
				<div class="CM-bar">
					<div><auchan:i18n id="103002020"></auchan:i18n></div>
				</div>
				<!-- 新增form信息 -->
				<div class="CM-div">
					<div class="inner_half">
						<div class="ig" style="margin-top: 15px;">
							<div class="msg_txt"><auchan:i18n id="103002002"></auchan:i18n></div>
							<input type="text" name="clstrId" readonly="readonly"
								class="w20 inputText Black" value="${itemClusterVO.clstrId }" />
						</div>
						<div class="ig">
							<div class="msg_txt"><auchan:i18n id="103002003"></auchan:i18n></div>
							<input type="text" name="clstrName"
								value="<c:out value='${itemClusterVO.clstrName }'/>" id="updateClstrName"
								title="<c:out value='${itemClusterVO.clstrName }'/>" class="inputText w65" />
						</div>
						<div class="ig">
							<div class="msg_txt"><auchan:i18n id="103002004"></auchan:i18n></div>
							<input type="text" id="updateCatlgId" name="catlgId"
								readonly="readonly" class="inputText w20"
								value="${itemClusterVO.catlgId }" /> <input type="text"
								id="updateCatlgName" name="catlgName" readonly="readonly"
								value="${itemClusterVO.catlgName}" class="inputText w44" />
						</div>
					</div>
					<div class="inner_half">
						<div class="ig" style="margin-top: 15px;">
							<div class="msg_txt"><auchan:i18n id="103002007"></auchan:i18n></div>
							<auchan:select id="searchClstrType" name="clstrType"
								disabled="true" mdgroup="ITEM_CLUSTER_CLSTR_TYPE" _class="w40"
								/>
							<span>&nbsp;&nbsp;<auchan:i18n id="103002008"></auchan:i18n>&nbsp;&nbsp;</span> <input type="checkbox"
								id="updateBatchPriceChngInd" name="batchPriceChngInd" value="1"
								readonly="readonly" style="vertical-align: middle;" disabled="disabled" />
						</div>
						<div class="ig">
							<div class="msg_txt"><auchan:i18n id="103002009"></auchan:i18n></div>
							<input type="text" class="inputText w20" id="updateRefItemNo"
								value="${itemClusterVO.refItemNo}" name="refItemNo"
								readonly="readonly" /> <input type="text" class="inputText w52"
								id="updateMidgrpName" readonly="readonly" title="<c:out value='${itemBasicVO.itemName }'/>"
								value="<c:out value='${itemBasicVO.itemName }'/>" />
						</div>

						
					</div>

				</div>
			</div>

			<div style="height: 410px; margin-top: 2px;" class="CM">
				<div class="CM-bar">
					<div><auchan:i18n id="103002018"></auchan:i18n></div>
				</div>
				<div class="CM-div">
					<div class="zz_info" style="width: 98%;">
						<div class="zz_1" style="width: 97.5%;">
							<span style="margin-left: 20px;"><auchan:i18n id="103002010"></auchan:i18n></span> <span class="zz_12"
								style="margin-left: 37px;"><auchan:i18n id="103002011"></auchan:i18n></span> <span class="zz_13"
								style="margin-left: 50px;"><auchan:i18n id="103002012"></auchan:i18n></span> <span class="zz_14"
								style="margin-left: 62px;"><auchan:i18n id="103002013"></auchan:i18n></span> <input type="text"
								id="base_secAttr1Name" class="inputText w7"
								style="margin-left: 40px;" readonly="readonly" /> <input
								type="text" id="base_secAttr2Name" style="margin-left: 1px;"
								class="inputText w7" readonly="readonly" /> <input type="text"
								class="inputText w7" style="margin-left: 1px;"
								readonly="readonly" id="base_secAttr3Name" /> <input
								type="text" class="inputText w7" style="margin-left: 1px;"
								readonly="readonly" id="base_secAttr4Name" /> <span class=""
								style="margin-left: 10px;"><auchan:i18n id="103002014"></auchan:i18n>（<auchan:i18n id="103002016"></auchan:i18n>）</span> <span class=""
								style="margin-left: 10px;"><auchan:i18n id="103002015"></auchan:i18n>（<auchan:i18n id="103002016"></auchan:i18n>）</span> <span class=""
								style="margin-left: 20px;"><auchan:i18n id="103002017"></auchan:i18n></span>
						</div>

						<div class="series_item1" id="allSeriesListInfo">
	<%-- 						<div class="ig" style="margin-top: 5px; margin-left: 10px;">
								<input type="text" id="searchItemNo" class="w7 inputText Black"
									readonly="readonly" value="${itemClusterVO.refItemNo}" /> <input
									type="hidden" value="${itemClusterVO.clstrId}"
									id="hiddenSearchItemNo" name="searchItemNo"> <input
									type="text" id="searchItemName" readonly='readonly'
									value="${itemBasicVO.itemName }" class="w10 inputText longText" />
								<input type="text" class="w10 inputText" readonly='readonly'
									id="searchMidgrpName" value="${itemBasicVO.midgrpName }" /> 
									<input
									type="text" class="w10 inputText" readonly='readonly'
									id="searchBrandName" <c:if test="${itemBasicVO.brandId ne null }"> value=" ${itemBasicVO.brandId }-${itemBasicVO.brandName }" </c:if> /> <input
									type="text" class="w7 inputText" readonly='readonly'
									id="searchSecAttrValName1"  value='${itemClusterItemVO.secAttrValName1}'/> <input type="text"
									class="w7 inputText" readonly='readonly'
									id="searchSecAttrValName2" value='${itemClusterItemVO.secAttrValName2}' /> <input type="text"
									class="w7 inputText" readonly='readonly'
									id="searchSecAttrValName3"  value='${itemClusterItemVO.secAttrValName3}'/> <input type="text"
									class="w7 inputText" readonly='readonly'
									id="searchSecAttrValName4" value='${itemClusterItemVO.secAttrValName4}'/> <input type="text"
									class="w7 inputText" readonly='readonly' id="searchStdBuyPrice"
									value="${itemBasicVO.stdBuyPrice }" /> <input type="text"
									class="w7 inputText" readonly='readonly'
									id="searchStdSellPrice" value="${itemBasicVO.stdSellPrice }" />
								<input type="text" class="w9 inputText" readonly='readonly'
									id="searchStatus" value="${itemBasicVO.status }" />
							</div> --%>
							
							<div id="seriesItemList">
								<!-- 这里插入动态内容 -->
							</div>
						</div>
						<!-- 其他功能菜单 -->
						<div class="ig">
							<div id="pagesItemsSeries" style="margin-left: 5px"></div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>


<script type="text/javascript">
	$('#i1').combobox({
		//url: 'combobox_data.json',
		width : 100,
		readonly : false,
		data : [ {
			"id" : 1,
			"text" : "text1"
		}, {
			"id" : 2,
			"text" : "text2"
		}, {
			"id" : 3,
			"text" : "1-总公司",
			"selected" : true
		}, {
			"id" : 4,
			"text" : "text4"
		}, {
			"id" : 5,
			"text" : "text5"
		} ],
		valueField : 'id',
		textField : 'text',
		//onSelect: function(rec){
		//var url = 'get_data2.php?id='+rec.id;
		//$('#cc2').combobox('reload', url);
		//}
		onSelect : function(rec) {
			//alert(rec.id + "....." + rec.text);
		}
	});
	$('#i2').combobox({
		//url: 'combobox_data.json',
		width : 100,
		readonly : false,
		data : [ {
			"id" : 1,
			"text" : "text1"
		}, {
			"id" : 2,
			"text" : "text2"
		}, {
			"id" : 3,
			"text" : "1-textile",
			"selected" : true
		}, {
			"id" : 4,
			"text" : "text4"
		}, {
			"id" : 5,
			"text" : "text5"
		} ],
		valueField : 'id',
		textField : 'text',
		//onSelect: function(rec){
		//var url = 'get_data2.php?id='+rec.id;
		//$('#cc2').combobox('reload', url);
		//}
		onSelect : function(rec) {
			//alert(rec.id + "....." + rec.text);
		}
	});
	$('#i3').combobox({
		//url: 'combobox_data.json',
		width : 60,
		readonly : false,
		data : [ {
			"id" : 1,
			"text" : "年",
			"selected" : true
		}, {
			"id" : 2,
			"text" : "月"
		}, {
			"id" : 3,
			"text" : "天"
		} ],
		valueField : 'id',
		textField : 'text',
		//onSelect: function(rec){
		//var url = 'get_data2.php?id='+rec.id;
		//$('#cc2').combobox('reload', url);
		//}
		onSelect : function(rec) {
			//alert(rec.id + "....." + rec.text);
		}
	});
</script>