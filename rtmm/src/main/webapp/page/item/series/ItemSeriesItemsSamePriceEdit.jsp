<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

	$(function() {
		//加载当前列表信息
		readSeriesByClstrId(1, 100, loadPageInfo);
		//加载系列课别信息
		readSectionInfoBycatlgId();

		//添加多个商品列表
		$("#updateMoreSeries").click(function() {
			 //没有选择同品项信息，则不允许点击列表信息
			if($("#searchClstrType").val()==""){
				$("#searchClstrType").removeClass().addClass(
				'w40 errorInput');
				top.jAlert("warning","请先选择系列类型信息","提示信息");
				return;
				}
			//打开弹出层
			openPopupWin(600, 500, '/series/toRefItemEditList');
		});

		//全选反选事件
		$("#searchALLSeries").click(function() {
			if ($("#searchALLSeries").attr("checked")) {
				$("input[name='searchSeriesBox']").attr("checked", true);
			} else {
				$("input[name='searchSeriesBox']").attr("checked", false);
			}
		});

		//关闭新增页面选项卡

		$("#closeUpdateSeriesPage").click(function() {
			
			showContent('/series/seriesList');
		});

		//点击课别事件
		$("#searchClstrType").bind("focus", function() {
			$("#searchClstrType").removeClass().addClass('w40');

		});

		//设置默认的选中框		
		$("#searchClstrType").val("${itemClusterVO.clstrType}");
		if("${itemClusterVO.clstrType}"=="1"){
			$("#updateBatchPriceChngInd").attr("disabled",false);

		//设置checkbox选中		
		if ("${itemClusterVO.batchPriceChngInd}" == "1") {
			$("#updateBatchPriceChngInd").attr("checked", "checked");
		}
		}

		$("#searchStatus").val(getDictValue('ITEM_STORE_INFO_STATUS','${itemBasicVO.status }'));


		   var item_status="${itemBasicVO.status }";
				if(item_status =="8"|| item_status=="9"){
					top.jAlert("warning","该系列的代表商品状态为删除或者进入删除","提示信息");
					}
		
	});
	// 新增选项
	$('#Tools2').attr('class', "Tools2").unbind('click').bind(
			'click',
			function() {
				var error = 0;
				//页面验证信息
				if ($.trim($("#updateClstrName").val()) == "") {
					//验证提示
					$("#updateClstrName").removeClass().addClass(
							'inputText w50 errorInput');
					error++;
				}
				if ($.trim($("#searchClstrType").val()) == "") {
					//验证提示
					$("#searchClstrType").removeClass().addClass(
							'w40 errorInput');
					error++;
				}

				//选择商品同价
                if($("#updateBatchPriceChngInd").attr("checked")=="checked"){
                   //当选择商品同价之后,对比，如果进价和售价全部一致，则通过
                    var buyPrice= $("#searchStdBuyPrice").val();//售价
                    var stdSellPrice=$("#searchStdSellPrice").val();//进价
                    //判断进价
                     $("[name=childStdBuyPrice]").each(function(index,item){
                           if(parseFloat($(this).val())!= parseFloat(buyPrice)){
                               $(this).removeClass().addClass('w7 inputText errorInput');
                        	   error++;
                               }
                         });
                     //判断售价
                     $("[name=childStdSellPrice]").each(function(index,item){
                         if(parseFloat($(this).val())!= parseFloat(stdSellPrice)){
                             $(this).removeClass().addClass('w7 inputText errorInput');                           
                      	   error++;
                             }
                       });	

                    }
                if(!validationClstrType()){
                	error++;
                    }
				if (error > 0)
					return;

				//增加修改的集合
				$("#updateAddItems").val(itemsAdd);
				$("#updateDelItems").val(itemsDelete);
				//修改数据信息
				$.ajax({
					async : false,
					url : ctx + '/series/updateSeriesItemsByClstr?tt='
							+ new Date().getTime(),
					data : $('#updateNewSeries').serialize(),
					type : 'POST',
					success : function(response) {
						if (response == "success") {
							top.jAlert('success', '修改数据成功', '提示消息');
							//重新加载数据，跳转到详情页面
							showContent('/series/toReadSeriesByClstrId?clstrId=${itemClusterVO.clstrId }');

							
						} else {
							top.jAlert('warning', '修改数据失败!请重试', '提示消息');
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						top.jAlert('error', '网络超时!请稍后重试', '提示消息');
					}
				});
			});



	//删除选中的信息商品信息
	$("#deleteSearchSeries").click(function() {
		if($("[name=searchSeriesBox]:checked").length==0){
			top.jAlert("warning","请选择要删除的项！","提示信息");
        return;
			}
		top.jConfirm('要清除选中的数据吗？', '提示消息', function(ret) {
			//返回ret，点击确定返回true,点击取消返回false
			if (ret) {
				executeFuction();
				//去掉全选按钮选中
				$("#searchALLSeries").attr("checked", false);
			}
		});
		//confirmAlert("要清除选中的数据吗？", 350, 80, "欧尚提示");	
	});

	//弹出对话框提示特定方法
	function executeFuction() {

		$("input[name='searchSeriesBox']:checked").each(function(i) {
			//移除选中的信息
			deleteItemByItemNo(items,$(this).val());
			//操作信息，删除列表
			//判断是不是在原始集合信息中，如果是原始信息集合，则加入删除集合信息
			if (containsArray(itemsList,$(this).val())) {
				//存在后，点击删除，加入删除集合
				itemsDelete.push($(this).val());
			}
			// 如果在新增信息中存在，从已添加信息去除
			if (containsArray(itemsAdd,$(this).val())) {
				//存在增加信息，删除
				removeElementForArray(itemsAdd,$(this).val());		
			}

		});
		//重新加载数据
		readAllSearchItems(items);

	}

	//根据弹出层回调结果信息  
	function confirmChooseSection(id, name) {
		$('#updateCatlgId').attr('value', id);
		$('#updateCatlgName').attr('value', name);
		//关闭弹出层
		closePopupWin();
	}

	//根据弹出层信息回调系列商品信息
	function confirmChooseSeries(rowData) {
		//页面部分
		$("#updateRefItemNo").val(rowData.itemNo);
		$("#updateMidgrpName").val(rowData.itemName);
		$("#hiddenSearchItemNo").val(rowData.itemNo);

		//添加一个信息栏
		$("#searchItemNo").val(rowData.itemNo);
		$("#searchItemName").val(rowData.itemName);
		$("#searchMidgrpName").val(rowData.catlgName);
		$("#searchBrandName").val(rowData.brandName);
		$("#searchStdBuyPrice").val(rowData.stdBuyPrice);
		$("#searchStdSellPrice").val(rowData.stdSellPrice);
		$("#searchStatus").val(getDictValue('ITEM_STORE_INFO_STATUS',rowData.status));

		//商品同品项信息
        $("#addClstrType").val(rowData.clstrType);
		//关闭弹出层
		closePopupWin();
	}

	//为相应的层添加信息
	function addItem(ItemNo, itemName, catlgName, brandName, stdBuyPrice,
			stdSellPrice, status, secAttrValName1, secAttrValName2,
			secAttrValName3, secAttrValName4,brandId,catlgId,clstrType) {
	     var brandInfo ="";              
			if(brandId!=null){
				brandInfo=brandId+"-"+brandName;
				}
		$("#seriesItemList")
				.append(
						"<div class='ig' style='margin-top: 5px; margin-left: 10px;'>"
								+ "<input type='checkbox' name='searchSeriesBox' value='"+ItemNo+"'>&nbsp;"
								+ "<input type='hidden' name='searchItemNo' value='"+ItemNo+"'/> "
								+ "<input type='hidden' name='searchClstrType' value='"+clstrType+"'/> "								
								+ "<input type='text' readonly='readonly' class='w7 inputText Black' value='"+ItemNo+"'/> "
								+ "<input type='text' readonly='readonly' class='w10 inputText longText' title='"+setNulltoEmpty(itemName)+"' value='"
								+ setNulltoEmpty(itemName)
								+ "'/> <input type='text'"
								+ "class='w10 inputText' readonly='readonly' value='"
								+  setNulltoEmpty(catlgName)
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
								+ "class='w7 inputText' readonly='readonly' name='childStdBuyPrice'  value='"
								+ setNulltoEmpty(stdBuyPrice)
								+ "' /> <input type='text'"
								+ "class='w7 inputText' readonly='readonly' name='childStdSellPrice' value='"
								+ setNulltoEmpty(stdSellPrice)
								+ "' /> <input type='text'"
    			+"class='w9 inputText' readonly='readonly' title='"+getDictValue('ITEM_STORE_INFO_STATUS',status)+"' value='"+getDictValue('ITEM_STORE_INFO_STATUS',status)+"'/>"
								+ "</div>");
	}
	
	//获取所有的选中信息并加载
	function readAllSearchItems(items) {
		//清空原来的所有信息
		$("#seriesItemList").empty();
		for ( var key in items) {
			
			if($("#searchItemNo").val()!=items[key].itemNo){
				addItem(items[key].itemNo, 
						items[key].itemName,
						items[key].catlgName, 
						items[key].brandName, 
						items[key].stdBuyPrice, 
						items[key].stdSellPrice, 
						items[key].status,
						items[key].secAttrValName1, 
						items[key].secAttrValName2,
						items[key].secAttrValName3, 
						items[key].secAttrValName4,
						items[key].brandId,
						items[key].catlgId,
						items[key].clstrType);
				}
			//选择加载信息，验证商品同价信息
			checkUpdateBatchPriceChngInd();
		}

		//选中事件，如果全部选择，则需要把全选按钮置为选中
		$("#seriesItemList :checkbox")
				.click(
						function() {
							var seriesLength = $("#seriesItemList :checkbox").length;
							var checkedSeriesLength = $("#seriesItemList :checkbox:checked").length;
							if (seriesLength == checkedSeriesLength) {
								$("#searchALLSeries").attr("checked", true);
							}else{
								$("#searchALLSeries").attr("checked", false);
								}
						});
		
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

			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				//这里是ajax错误信息
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
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
									if (itemsAdd.length > 0
											|| itemsDelete.length > 0) {
										top
												.jConfirm(
														'已经有存在修改数据，需要保存？（友情提示，如果不保存，之前的操作信息在下一页不会保留）',
														'提示消息',
														function(ret) {
															if (ret) {
																//加载下一个页面信息
																clearAllItems();//清除相关的集合
																loadItemsInfos(
																		pageNumber,
																		pageSize);
															} else {
																loadItemsOff = false;
																$(
																		'#pagesItemsSeries')
																		.pagination(
																				'select',
																				currentPageNo);
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


	 //当选择非同品项时，商品同价不允许点击
	$("#searchClstrType").change(function(){
      if($("#searchClstrType").val()==1){
    	  $("#updateBatchPriceChngInd").attr("disabled",false);
          }else{
        	  $("#updateBatchPriceChngInd").attr("disabled",true);
        	  $("#updateBatchPriceChngInd").attr("checked",false);
          }
      checkUpdateBatchPriceChngInd();
	
});


	 //商品同价信息，点击商品同价后，如果商品同价，提示不正常的信息
    $("#updateBatchPriceChngInd").click(function(){
    	checkUpdateBatchPriceChngInd();
        });

	 //验证商品同价信息
  function checkUpdateBatchPriceChngInd(){
	  if($("#updateBatchPriceChngInd").attr("checked")=="checked"){
    	  var buyPrice= $("#searchStdBuyPrice").val();//售价
          var stdSellPrice=$("#searchStdSellPrice").val();//进价
           $("[name=childStdBuyPrice]").each(function(index,item){
                 if(parseFloat($(this).val())!= parseFloat(buyPrice)){
                     $(this).removeClass().addClass('w7 inputText errorInput');
                     }
               });
           $("[name=childStdSellPrice]").each(function(index,item){
               if(parseFloat($(this).val())!= parseFloat(stdSellPrice)){
                   $(this).removeClass().addClass('w7 inputText errorInput');                           
                   }
             });	
         }else{
        	  $("[name=childStdBuyPrice]").removeClass().addClass('w7 inputText');
        	  $("[name=childStdSellPrice]").removeClass().addClass('w7 inputText');
             }
	  }

   //焦点获取事件
  $("#updateClstrName").focus(function(){
	  $("#updateClstrName").removeClass("errorInput");
	  });



//验证同品项
  function validationClstrType(){
  var	error=0;
  //如果是同品项，开始验证
  if($("#searchClstrType").val()==1 ){
     //2.验证系列商品同品项
     $("#seriesItemList .ig").each(function(index,item){
         if( $(item).find('[name=searchClstrType]').val()==1 && !containsArray(itemsList,$(item).find('[name=searchItemNo]').val())){              
          $(item).find("input").addClass("errorInput");
          error++;
             }
  	   });   	
  }else{
  	 $("#seriesItemList .ig").each(function(index,item){
  	        $(item).find("input").removeClass("errorInput");
  	}); 
  }
  if(error>0){
	  top.jAlert('warning', '有些商品已存在其他同品项系列中！', '提示消息');
  return false;	
  }else{
  	return true;
  }	
  }

   //选择同品项事件
  $("#searchClstrType").change(function(){
  	validationClstrType();
  	
  });

  
 
  
  
  /**
   * 移除商品中某些货号
   * @param array 数组
   * @param itemNo  货号
   */    
  function deleteItemByItemNo(array,itemNo){
        if(typeof(array) != "undefined" && array.length > 0 ){
              for(var i in array){
                  if(array[i].itemNo == itemNo){
                	//移除
          			array.splice(i, 1);
                      }
                  }
            }
	  }
  

  

  
</script>

<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left"></div>
	<div class="tagsM"><auchan:i18n id="103002018"></auchan:i18n></div>
	<div class="tags tags3 tags_right_on"></div>
	<!--一定不要忘了tag3-->
	<!--add-->
	<div class="tagsM_q  tagsM_on"><auchan:i18n id="103002021"></auchan:i18n></div>
	<div class="tags3_close_on">
		<div class="tags_close" id="closeUpdateSeriesPage"></div>
	</div>
</div>

<div class="Container-1">
	<div class="Content">
		<div class="CInfo">
			 <span><auchan:getStuffName value="${itemClusterVO.chngBy }"/></span> <span><auchan:i18n id="103001065"></auchan:i18n></span> <span> <c:if test="${itemClusterVO.chngDate ne null}" > <fmt:formatDate value="${itemClusterVO.chngDate }" type="date" /> </c:if>     </span>
			<span><auchan:i18n id="103001064"></auchan:i18n></span> <span><auchan:getStuffName value="${itemClusterVO.creatBy}"/></span> <span><auchan:i18n id="103001063"></auchan:i18n></span> <span><c:if test="${itemClusterVO.chngDate ne null}" > <fmt:formatDate value="${itemClusterVO.creatDate }" type="date" /> </c:if> </span>
			<span><auchan:i18n id="103001062"></auchan:i18n></span>
		</div> 

		<form id="updateNewSeries">
			<input type="hidden" id="updateAddItems" name="updateAddItems">
			<input type="hidden" id="updateDelItems" name="updateDelItems">
		<input type="hidden" id="addClstrType"/>

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
								 class="inputText w65" />
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
						<div class="ig"  style="margin-top: 15px;">
							<div class="msg_txt"><auchan:i18n id="103002007"></auchan:i18n></div>
							<auchan:select id="searchClstrType" name="clstrType"
								mdgroup="ITEM_CLUSTER_CLSTR_TYPE" _class="w40"
								/>
							<span>&nbsp;&nbsp;<auchan:i18n id="103002008"></auchan:i18n>&nbsp;&nbsp;</span> <input type="checkbox"
								id="updateBatchPriceChngInd" name="batchPriceChngInd" value="1"
								style="vertical-align: middle;" disabled="disabled" />
						</div>
						<div class="ig">
							<div class="msg_txt"><auchan:i18n id="103002009"></auchan:i18n></div>
							<input type="text" class="inputText w20" id="updateRefItemNo"
								value="${itemClusterVO.refItemNo}" name="refItemNo"
								readonly="readonly" /> <input type="text" class="inputText w55"
								id="updateMidgrpName" readonly="readonly"
								value="<c:out value='${itemBasicVO.itemName }'/>" title="<c:out value='${itemBasicVO.itemName }'/>" />
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
							<span style="margin-left: 40px;"><auchan:i18n id="103002010"></auchan:i18n></span> <span class="zz_12"
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
							<div class="ig" style="margin-top: 5px; margin-left: 10px;">
								&nbsp;&nbsp;&nbsp; &nbsp;<input type="text" id="searchItemNo"
									class="w7 inputText Black" readonly="readonly"
									value="${itemClusterVO.refItemNo}" /> <input type="hidden"
									value="${itemClusterVO.clstrId}" id="hiddenSearchItemNo"
									name="searchItemNo"> <input type="text"
									id="searchItemName" readonly='readonly'
									value="${itemBasicVO.itemName }" class="w10 inputText longText" />
								<input type="text" class="w10 inputText" readonly='readonly'
									id="searchMidgrpName" value="${itemBasicVO.midgrpName }" /> <input
									type="text" class="w10 inputText" readonly='readonly'
									id="searchBrandName" <c:if test="${itemBasicVO.brandId ne null }"> value="${itemBasicVO.brandId }-${itemBasicVO.brandName }" </c:if> /> <input
									type="text" class="w7 inputText" readonly='readonly'
									id="searchSecAttrValName1"  value='${itemClusterItemVO.secAttrValName1}'/> <input type="text"
									class="w7 inputText" readonly='readonly'
									id="searchSecAttrValName2"   value='${itemClusterItemVO.secAttrValName2}'/> <input type="text"
									class="w7 inputText" readonly='readonly'
									id="searchSecAttrValName3"  value='${itemClusterItemVO.secAttrValName3}'/> <input type="text"
									class="w7 inputText" readonly='readonly'
									id="searchSecAttrValName4"  value='${itemClusterItemVO.secAttrValName4}'/> <input type="text"
									class="w7 inputText" readonly='readonly' id="searchStdBuyPrice"
									value="${itemBasicVO.stdBuyPrice }" /> <input type="text"
									class="w7 inputText" readonly='readonly'
									id="searchStdSellPrice" value="${itemBasicVO.stdSellPrice }" />
								<input type="text" class="w9 inputText" readonly='readonly'
									id="searchStatus" value="${itemBasicVO.status }" />
							</div>
							<div id="seriesItemList">
								<!-- 这里插入动态内容 -->
							</div>
						</div>
						<!-- 其他功能菜单 -->
						<div class="ig">
							<input class="sp_icon1" type="checkbox" id="searchALLSeries"
								style="margin-left: 10px; margin-right: 15px;" />
							<div class="Icon-size2 Tools10 sp_icon4" id="deleteSearchSeries"></div>
							<div class="Icon-size2 Line-1 sp_icon3 "></div>
							<div class="Icon-size2 Tools11 sp_icon4" id="updateMoreSeries"></div>
							<div class="Icon-size2 Line-1 sp_icon3"></div>
							<!-- <div id="pagesItemsSeries" style="margin-left: 5px"></div> -->
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