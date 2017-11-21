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
	var items = new Array();


	$(function() {
		//为系列类型（课别）添加弹出层事件
		$("#addCatlgBtn").unbind("click").bind("click", function() {
			//打开弹出层
			openPopupWin(600, 500, '/commons/window/chooseSection');
				});
		//为商品列表加入弹出层事件
		$("#addRefItemNoBtn").unbind("click").bind("click", function() {
			//让输入框失去焦点
			$("#addMoreSeries").focus();
              //没有选择课别信息，则不允许点击列表信息
			if(isNumber($("#addCatlgId").val())&& $("#addCatlgId").val()==""){
				top.jAlert("warning","请先选择课别信息","提示信息");
				return;
				}
			 //没有选择同品项信息，则不允许点击列表信息
			if($("#searchClstrType").val()==""){
				$("#searchClstrType").addClass('errorInput');
				top.jAlert("warning","请先选择系列类型信息","提示信息");
				return;
				}
			//打开弹出层
			openPopupWin(600, 500, '/series/toSearchRefItemList');
		});
		//添加多个商品列表
		$("#addMoreSeries").click(function() {
					   //没有选择课别信息，则不允许点击列表信息
					if(!isNumber($("#addCatlgId").val()) || $("#addCatlgId").val()==""){
						top.jAlert("warning","请先选择课别信息","提示信息");
						return;
						}
					   //没有选择信息，则不允许点击列表信息
					if(!isNumber($("#addRefItemNo").val()) || $("#addRefItemNo").val()==""){
						top.jAlert("warning","请选择代表商品","提示信息");
						return;
						}
					 //没有选择同品项信息，则不允许点击列表信息
					if($("#searchClstrType").val()==""){
						$("#searchClstrType").addClass('errorInput');
						top.jAlert("warning","请先选择系列类型信息","提示信息");
						return;
						}
					//打开弹出层
					openPopupWin(600, 500, '/series/toRefItemList');
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

		$("#closeAddSeriesPage").click(function() {
			showContent('/series/seriesList');
		});

		//验证信息提示
		//点击系列名称事件
		$("#addClstrName").bind("focus", function() {
			$("#addClstrName").removeClass().addClass('inputText w50');

		});

		//点击同品信息事件
		$("#searchClstrType").unbind("focus").bind("focus", function() {
			$("#searchClstrType").removeClass("errorInput");

		});
		//点击代表事件
		$("#addRefItemNo").unbind("focus").bind("focus", function() {
			$("#addRefItemNo").removeClass("errorInput");
			$("#addMidgrpName").removeClass("errorInput");

		});
		//点击系列类型事件
		$("#addCatlgId").unbind("focus").bind("focus", function() {
			$("#addCatlgId").removeClass('errorInput');
		});
	});
	
	// 新增选项
	$('#Tools2').attr('class', "Tools2").unbind('click').bind(
			'click',
			function() {
				var error = 0;
				//页面验证信息
				if ($.trim($("#addClstrName").val()) == "") {
					//验证提示
					$("#addClstrName").removeClass().addClass(
							'inputText w50 errorInput');
					error++;
				}
				if ($.trim($("#searchClstrType").val()) == "") {
					//验证提示
					$("#searchClstrType").addClass('errorInput');
					error++;
				}
				if (!isNumber($("#addRefItemNo").val()) || $.trim($("#addRefItemNo").val()) == "") {
					//验证提示
					$("#addRefItemNo").addClass("errorInput");
					error++;
				}
				if (!isNumber($("#addCatlgId").val()) || $.trim($("#addCatlgId").val()) == "") {
					//验证提示
					$("#addCatlgId").addClass('errorInput');
					error++;
				}
				//选择商品同价
                if($("#batchPriceChngInd").attr("checked")=="checked"){
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
               //判断同品项信息
               if(!validationClstrType()){
            	   error++;
                   }           			
				if (error > 0){
					return;
					}

				$.ajax({
					async : false,
					url : ctx + '/series/handleCreateItemCluster',
					data : $('#addNewSeries').serialize(),
					type : 'POST',
					success : function(response) {
						if (response == "success") {
							top.jAlert('success', '新增数据成功', '提示消息');
						} else {
							top.jAlert('warning', '新增数据失败!请重试', '提示消息');
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						top.jAlert('error', '网络超时!请稍后重试', '提示消息');
					}
				});

				//清空数据
				items = [];
				//重新加载数据
				readAllSearchItems();
				//重置表单
				$('#addNewSeries')[0].reset();
			});


	//删除选中的信息商品信息
	$("#deleteSearchSeries").unbind("click").bind("click", function() {
		if($("[name=searchSeriesBox]:checked").length==0){
			top.jAlert("warning","请选择要删除的项！","提示信息");
        return;
			}
		top.jConfirm('要清除选中的数据吗？', '提示消息', function(ret) {
			//返回ret，点击确定返回true,点击取消返回false
			if (ret) {
				//重新加载数据
				executeFuction();
				//去掉全选按钮选中
				$("#searchALLSeries").attr("checked", false);
			}
		});
	});

	//移除选中的数据
	function executeFuction() {

		$("input[name='searchSeriesBox']:checked").each(function(i) {
			//移除选中的信息
			deleteItemByItemNo(items,$(this).val());
		});
		//重新加载数据
		readAllSearchItems();

	}

	//根据弹出层回调结果信息  
	function confirmChooseSection(id, name) {

		$('#addCatlgId').attr('value', id);
		$('#addCatlgName').attr('value', name);

	      //加载课别属性信息		
		loadSecCtrl(id,function(data){
         $("#baseDiffAttrName1").val(data.secAttr1Name);
         $("#baseDiffAttrName2").val(data.secAttr2Name);
         $("#baseDiffAttrName3").val(data.secAttr3Name);
         $("#baseDiffAttrName4").val(data.secAttr4Name);        
			});
		//关闭弹出层
		closePopupWin();
	}

	//根据弹出层信息回调系列商品信息
	function confirmChooseSeries(rowData) {
		//items.put(rowData.itemNo,rowData);
		//页面部分
		$("#addRefItemNo").val(rowData.itemNo);
		$("#addMidgrpName").val(rowData.itemName);
		$("#hiddenSearchItemNo").val(rowData.itemNo);

		//添加一个信息栏
		$("#searchItemNo").val(rowData.itemNo);
		$("#searchItemName").val(rowData.itemName);
		$("#searchCatlgName").val(rowData.catlgName);
		if(rowData.brandId!=null){
		$("#searchBrandName").val(setNulltoEmpty(rowData.brandId) +"-"+setNulltoEmpty(rowData.brandName));
		}
		$("#searchStdBuyPrice").val(rowData.stdBuyPrice);
		$("#searchStdSellPrice").val(rowData.stdSellPrice);
		$("#searchStatus").val(getDictValue('ITEM_STORE_INFO_STATUS', rowData.status));
		$("#searchSecAttrValName1").val(rowData.secAttrValName1);
		$("#searchSecAttrValName2").val(rowData.secAttrValName2);
		$("#searchSecAttrValName3").val(rowData.secAttrValName4);
		$("#searchSecAttrValName4").val(rowData.secAttrValName4);

		//商品同品项信息
        $("#addClstrType").val(rowData.clstrType);
		
		//关闭弹出层
		closePopupWin();

	    //给每一个input标签加入title
		$("#allSeriesListInfo :input").each(function(){
           $(this).attr("title",$(this).val());
			});
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
								+ "<input type='text' readonly='readonly' class='w10 inputText longText'  value='"
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
								+ "class='w7 inputText' readonly='readonly'  name='childStdSellPrice' value='"
								+ setNulltoEmpty(stdSellPrice)
								+ "' /> <input type='text'"
								+ "class='w9 inputText' readonly='readonly'  title='"
								+ getDictValue('ITEM_STORE_INFO_STATUS', status)
								+ "' value='"
								+ getDictValue('ITEM_STORE_INFO_STATUS', status)
								+ "'/>" + "</div>");

	}

	//获取所有的选中信息并加载
	function readAllSearchItems() {
		//清空原来的所有信息
		$("#seriesItemList").empty();
		for ( var key in items) {
			//获取信息 		
			if(isFunction(items[key])){
				//alert(items.keySet()[key]);
				continue;
			}
			if($("#addRefItemNo").val()!=items[key].itemNo){
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
           //检测商品同价信息
			checkBatchPriceChngInd();
		}

		//选中事件，如果全部选择，则需要把全选按钮置为选中
		$("#seriesItemList :checkbox")
				.click(
						function() {
							var seriesLength = $("#seriesItemList :checkbox").length;
							var checkedSeriesLength = $("#seriesItemList :checkbox:checked").length;
							if (seriesLength == checkedSeriesLength) {
								$("#searchALLSeries").attr("checked", true);
							} else {
								$("#searchALLSeries").attr("checked", false);
							}
						});

	    //给每一个input标签加入title
		$("#allSeriesListInfo :input").each(function(){
           $(this).attr("title",$(this).val());
			});
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
    //当选择非同品项时，商品同价不允许点击
	$("#searchClstrType").change(function(){
      if($("#searchClstrType").val()==1){
    	  $("#batchPriceChngInd").attr("disabled",false);
          }else{
        	  $("#batchPriceChngInd").attr("disabled",true);
        	  $("#batchPriceChngInd").attr("checked",false);
          }
        //验证同价信息
      checkBatchPriceChngInd();
  	
});

    //商品同价信息，点击商品同价后，如果商品同价，提示不正常的信息
    $("#batchPriceChngInd").click(function(){
    	checkBatchPriceChngInd();
        });


    //验证商品同价信息
  function checkBatchPriceChngInd(){
	  if($("#batchPriceChngInd").attr("checked")=="checked"){
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


 //验证同品项
function validationClstrType(){
var	error=0;
//如果是同品项，开始验证
if($("#searchClstrType").val()==1){
	// 1.验证代表商品
   if($("#addClstrType").val()==1){
   $("#addRefItemNo").addClass("errorInput");
   $("#addMidgrpName").addClass("errorInput");
     error++;
   }
   //2.验证系列商品同品项
   $("#seriesItemList .ig").each(function(index,item){
       if( $(item).find('[name=searchClstrType]').val()==1){              
        $(item).find("input").addClass("errorInput");
        error++;
           }
	   });   	
}else{
	//如果是非同品项，跳过这些验证
	 $("#addRefItemNo").removeClass("errorInput");
	 $("#addMidgrpName").removeClass("errorInput");
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



//课别选项
$("#addCatlgId").unbind("blur").blur(function(){
	$("#addCatlgName").val("");
var secNo=$("#addCatlgId").val();
if(isNumber(secNo) && secNo!=""){
     //加载课别信息
	readCatalogInfoBySecNo(secNo,function(data){
          if(data!="" && data.length>0){
				$("#addCatlgName").val(data[0].secName);
              }else{
            	  top.jAlert('warning', '该课别不存在，请重新输入或选择', '提示消息');
            	  $("#addCatlgId").val("");
                  }
		});		
}
});

//代表商品选项
$("#addRefItemNo").unbind("blur").blur(function(){	
$("#addMidgrpName").val("");
var itemNo=$("#addRefItemNo").val();
var catlgNo=$("#addCatlgId").val();
var clstrType=$("#searchClstrType").val();
if(isNumber(itemNo) && itemNo!=""){
     //加载代表商品信息
	readitemSeriesInfo(itemNo,catlgNo,clstrType,function(data){
          if(data!=""  && data.length>0){
				$("#addMidgrpName").val(data[0].itemName);
				//添加一个信息栏
				$("#searchItemNo").val(data[0].itemNo);
				$("#searchItemName").val(data[0].itemName);
				$("#searchCatlgName").val(data[0].catlgName);
				$("#hiddenSearchItemNo").val(data[0].itemNo);
				
				
				if(data[0].brandId!=null){
				$("#searchBrandName").val(setNulltoEmpty(data[0].brandId) +"-"+setNulltoEmpty(data[0].brandName));
				}
				$("#searchStdBuyPrice").val(data[0].stdBuyPrice);
				$("#searchStdSellPrice").val(data[0].stdSellPrice);
				$("#searchStatus").val(getDictValue('ITEM_STORE_INFO_STATUS', data[0].status));
				$("#searchSecAttrValName1").val(data[0].secAttrValName1);
				$("#searchSecAttrValName2").val(data[0].secAttrValName2);
				$("#searchSecAttrValName3").val(data[0].secAttrValName4);
				$("#searchSecAttrValName4").val(data[0].secAttrValName4);				
              }else{
            	  top.jAlert('warning', '代表不存在，请重新输入或选择', '提示消息');
            	  $("#addRefItemNo").val("");
            	  $("#series_refItemNo input").val("");
                  }
		});		
}
});

//代表商品选项
$("#addRefItemNo").unbind("focus").focus(function(){	
	if(isNumber($("#addCatlgId").val()) && $("#addCatlgId").val()==""){
		top.jAlert("warning","请先选择课别信息","提示信息");
		return;
		}
	 //没有选择同品项信息，则不允许点击列表信息
	if($("#searchClstrType").val()==""){
		$("#searchClstrType").addClass('errorInput');
		top.jAlert("warning","请先选择系列类型信息","提示信息");
		return;
		}
});




//查询代表商品信息
function readitemSeriesInfo(itemNo,catlgNo, clstrType,methodName) {
	$.ajax({
		type : 'post',
		url : ctx + '/series/readRefItemList?tt='
				+ new Date().getTime(),
		dataType:"json",		
		data : {
			 itemNo:itemNo,
	         catlgNo: catlgNo, //从其他页面获取课别信息
	         clstrType:clstrType,
	         page:1,
	         rows:20
		},
		success : function(data) {
			methodName(data.rows);
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			//这里是ajax错误信息
			top.jAlert('error', '网络超时!请稍后重试', '提示消息');
		}
	});
}


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
	<div class="tagsM_q  tagsM_on"><auchan:i18n id="103002022"></auchan:i18n></div>
	<div class="tags3_close_on">
		<div class="tags_close" id="closeAddSeriesPage"></div>
	</div>
</div>

<div class="Container-1">
	<div class="Content" >
<!-- 
		 	<div class="CInfo">
			 <span>李四</span> <span>建档人</span> <span>2014-02-02</span>
			<span>创建日期</span>
		</div>  -->

		<form id="addNewSeries">
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
							<input type="text" class="w20 inputText Black"
								readonly="readonly" />
						</div>
						<div class="ig">
							<div class="msg_txt">*<auchan:i18n id="103002003"></auchan:i18n></div>
							<input type="text" name="clstrName" id="addClstrName"
								title="请输入系列名称" class="inputText w63" maxlength="20"/>
						</div>
						<div class="ig">
							<div class="msg_txt">*<auchan:i18n id="103002004"></auchan:i18n></div>
							<div class="iconPut iq fl_left" style="width:18%;">
                                            <input type="text" class="w75" id="addCatlgId" name="catlgId" >
                                            <div class="ListWin" id="addCatlgBtn"></div>
                                        </div>
							<!-- <input type="text" id="addCatlgId" name="catlgId" readonly="readonly"
								class="inputText w20" />  --><input type="text" id="addCatlgName"
								name="catlgName" class="inputText w44" />
						</div>
					</div>
					<div class="inner_half">
						<div class="ig"  style="margin-top: 15px;">
							<div class="msg_txt">*<auchan:i18n id="103002007"></auchan:i18n></div>
							<auchan:select id="searchClstrType" name="clstrType"
								mdgroup="ITEM_CLUSTER_CLSTR_TYPE" _class="w40"
								/>
							<span>&nbsp;&nbsp;<auchan:i18n id="103002008"></auchan:i18n>&nbsp;&nbsp;</span> <input id="batchPriceChngInd" type="checkbox"
								name="batchPriceChngInd" value="1" disabled="disabled"
								style="vertical-align: middle;" />
						</div>
						<div class="ig">
							<div class="msg_txt">*<auchan:i18n id="103002009"></auchan:i18n></div>
							<div class="iconPut iq fl_left" style="width:21%;">
                                            <input type="text" class="w75" id="addRefItemNo" name="refItemNo" >
                                            <div class="ListWin" id="addRefItemNoBtn"></div>
                                        </div>
						<!-- 	<input type="text" class="inputText w20" id="addRefItemNo" readonly="readonly"
								name="refItemNo" /> --> <input type="text" class="inputText w55"
								id="addMidgrpName" readonly="readonly"/>
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
								 class="inputText w7" style="margin-left: 40px;" id="baseDiffAttrName1"
								readonly="readonly" /> <input type="text" id="baseDiffAttrName2"
								style="margin-left: 1px;" class="inputText w7"
								readonly="readonly" /> <input type="text" class="inputText w7"
								style="margin-left: 1px;" readonly="readonly" id="baseDiffAttrName3"/> <input
								type="text" class="inputText w7" style="margin-left: 1px;"
								readonly="readonly"  id="baseDiffAttrName4"/> <span class=""
								style="margin-left: 10px;"><auchan:i18n id="103002014"></auchan:i18n>（<auchan:i18n id="103002016"></auchan:i18n>）</span> <span class=""
								style="margin-left: 10px;"><auchan:i18n id="103002015"></auchan:i18n>（<auchan:i18n id="103002016"></auchan:i18n>）</span> <span class=""
								style="margin-left: 20px;"><auchan:i18n id="103002017"></auchan:i18n></span>
						</div>

						<div class="series_item1" id="allSeriesListInfo" >
							<div class="ig" style="margin-top: 5px; margin-left: 10px;" id="series_refItemNo">
								&nbsp;&nbsp;&nbsp; &nbsp;<input type="text" id="searchItemNo"
									class="w7 inputText Black" readonly="readonly" /> <input
									type="hidden" id="hiddenSearchItemNo" name="searchItemNo">
								<input type="text" id="searchItemName"
									class="w10 inputText longText" readonly="readonly" /> <input
									type="text" class="w10 inputText" id="searchCatlgName"
									readonly="readonly" /> <input type="text"
									class="w10 inputText" id="searchBrandName" readonly="readonly" />
								<input type="text" class="w7 inputText" readonly="readonly"
									id="searchSecAttrValName1" /> <input type="text"
									class="w7 inputText" readonly="readonly"
									id="searchSecAttrValName2" /> <input type="text"
									class="w7 inputText" readonly="readonly"
									id="searchSecAttrValName3" /> <input type="text"
									class="w7 inputText" readonly="readonly"
									id="searchSecAttrValName4" /> <input type="text"
									class="w7 inputText" id="searchStdBuyPrice" readonly="readonly" />
								<input type="text" class="w7 inputText" id="searchStdSellPrice"
									readonly="readonly" /> <input type="text" class="w9 inputText"
									id="searchStatus" readonly="readonly" />
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
							<div class="Icon-size2 Tools11 sp_icon4" id="addMoreSeries"></div>
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