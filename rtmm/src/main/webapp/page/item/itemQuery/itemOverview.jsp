<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/item/itemSearch.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/item/itemUpdate.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
	
<style type="text/css">
._w120 {
	width: 120px;
}

._w80 {
	width: 80px;
}

._w83 {
	width: 83px;
}

._w90 {
	width: 90px;
}

.i_input1_2 {
	float: left;
	height: 30px;
	width: 33%;
}

.ib_2 {
	float: left;
	width: 32%;
}

.edit_div {
	width: 20px;
	height: 20px;
	float: left;
	margin-left: 5px;
}

.iq {
	width: 25%;
}

.tiaoma {
	float: left;
	line-height: 25px;
	margin-left: 10px;
	margin-right: 5px;
}
</style>
<script type="text/javascript">
	var currIndex = 0;
	var itemLookNumber=0;//浏览图片使用，浏览图片次序
	var itemLookInfos=new Array();//当前单个商品所有的图片信息
	$(function() {
		setToolsbarAllDisable();
		$($("#Tools22").parent()).addClass("ToolsBg");
		$("#Tools22").attr('class', "Icon-size1 Tools22_on");
		$('#Tools21').attr('class','Icon-size1 Tools21').unbind().bind('click',function(){
			$('#ovreviewContent').hide();
			$('#ovreviewList').show();
			setToolsbarAllDisable();
			$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").unbind().bind("click",
					function() {
						DispOrHid('B-id');
						gridbar_B();
			});
			setTools23();
		/* 	showStoreSelect();
			showDivision(); */
			 $(".SearchTable").find('input').bind('keypress',function(e){
				 var code=e.keyCode;
					if (13==code) {
						initPage();
						pageQuery1();
					}
			}); 
			$($("#Tools21").parent()).addClass("ToolsBg");
			$("#Tools21").attr('class', "Icon-size1 Tools21_on");
			$('#Tools22').attr('class','Icon-size1 Tools22').unbind().bind('click',function(){
/* 				$('#ovreviewContent').load(ctx + '/item/query/itemBaseInfo',function(){
					$('#ovreviewList').hide();
					$('#ovreviewContent').show();
					$("#barcode").attr("readonly",false);
					$("#itemNo").attr("readonly",false);
				}); */
				showContent(ctx + '/item/query/generalSearch');
			});
		});
		//新增商品入口start
		<auchan:operauth ifAnyGrantedCode="112111001" >
		$('#Tools11').removeClass('Tools11_disable');
		$('#Tools11').addClass('Tools11');
		$('#Tools11').unbind('click').bind('click',createItemPage);
		</auchan:operauth>		
		//传递参数 
		var param = {
			'itemNo' : '${sessionScope.itemNoSearch}',
			'storeNo' : '${sessionScope.storeNoSearch}'
		};
		//商品总览(tab)
		$('#ovreviewTab').unbind("click")
				.bind(
						'click',
						function() {
							var itemNo = '${sessionScope.itemNoSearch}';
							if (itemNo) {
								searchItemByItemNo(
										'${sessionScope.itemNoSearch}',
										'${sessionScope.storeNoSearch}','');
							} else {
								$('#ovreviewContent').load(ctx + '/item/query/itemBaseInfo',function(){
									$('#ovreviewList').hide();
									$('#ovreviewContent').show();
									$("#barcode").attr("readonly",false);
									$("#itemNo").attr("readonly",false);
								});
							}
						});
		//变价信息(tab)
		$('#priceChangeTab').unbind("click").bind(
				'click',
				function() {
					$('#ovreviewContent').load(ctx + '/item/query/itemPriceChangeInfo', param);
				});
		//规格信息(tab)
		$('#specInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemSpecInfo', param);
		});
		//商品条码(tab)
		$('#barcodeInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemBarcodeInfo', param);
		});
		//商品关联(tab)
		$('#realativeInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemRealativeInfo', param);
		});
		//商品厂商(tab)
		$('#supInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemSupInfo', param);
		});
		//商品陈列(tab)
		$('#saleCtrlInfoTab').unbind("click").bind(
				'click',
				function() {
					$('#ovreviewContent').load(
							ctx + '/item/query/itemRealStoreSaleCtrlInfo',
							param);
				});
		//DC信息(tab)
		$('#dcInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemDCInfo', param);
		});
		//商品产地(tab)
		$('#originInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemOriginInfo', param);
		});
		//商品供应区域(tab)
		$('#supAreaInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemSupplierAreaInfo', param);
		});
		//商品订单查询(tab)
		$('#itemOrderQuery').unbind("click").bind('click',function(){
			$('#ovreviewContent').load(ctx + '/item/query/itemOrderQuery', param);
		});
		//上一页
		if ('${page}' != '1' && '${page}' != '') {
			$("#Tools17").toggleClass('Tools17_disable').toggleClass('Tools17')
					.bind('click', function() {
						searchItemByPageNo('${prePage}');
					});
		}

		//下一页
		if ('${page}' != '${total}') {
			$("#Tools19").toggleClass('Tools19_disable').toggleClass('Tools19')
					.bind('click', function() {
						searchItemByPageNo('${nextPage}');
					});
		}
		//最后一页
		if ('${page}' != '${total}' && eval('${total}') > eval('${page}')) {
			$("#Tools18").toggleClass('Tools18_disable').toggleClass('Tools18')
					.bind('click', function() {
						searchItemByPageNo('${total}');
					});
		}

		//第一页
		if ('${page}' != '1' && '${page}' != '') {
			$("#Tools16").toggleClass('Tools16_disable').toggleClass('Tools16')
					.bind('click', function() {
						searchItemByPageNo('1');
					});
		}
		//采购期限为2-季节时，给季节期数赋值（取该商品下的季节期数中的第一个）,并绑定点击弹出窗口事件
		if ('${itemBasicVO.buyPerd}' == 2) {
			$("#topic").attr("readonly", false);
			setItemSeTopic('${itemBasicVO.buyPerd}');
			$('#topic').unbind("click").bind('click', function() {
				showSETopic();
			});
		}
		//存在系列时，给系列绑定事件
		if('${itemBasicVO.clstrId}'){
			$('#clstrName').unbind("click").bind('click', function() {
				showCluster();
			});	
		}
		// 新增下傳區域入口
		if ('${itemBasicVO.itemNo}' != '') {
			$('.icm').die()
					.live(
							"click",
							function() {
								var catlgId = $.trim($("#catlgId").val());
								var buyWhen = '${itemBasicVO.buyWhen}';
								var pre = getParam();
								var newParam = {
										'itemNo' : pre.itemNo,
										'itemName' : pre.itemName,
										'storeNo' : pre.storeNo,
										'storeName' : pre.storeName,
										'catlgId' : catlgId,
										'buyWhen' : buyWhen
								}
								$('#ovreviewContent').load(
										ctx + '/item/update/updateSupArea',
										newParam);
							});
		} else {
			$('.icm').die().live("click", function() {
				top.jAlert('warning', '请先检索需要新增下传区域的商品', '提示消息');
			});
		}

		setItemStoreInfoOrdCreatMethd();
		/*if('${barcodeSearch}'){
			setItemBarcode('${barcodeSearch}');
		}
		 		if('${sessionScope.barcodeSearch}'){
		 $('barcode').val('${sessionScope.barcodeSearch}');
		 }else{
		 setItemBarcode();
		 } */
		//打开搜索
		//overviewSearchByItemNo();
		overviewSearch();
 		$("#itemNo").unbind().bind('keypress', function(e) {
			var code=e.keyCode;
			if (13==code) {
				var searchItemNo = getPageItemNo();
				var searchBarcode = getPageBarcode();
				if(searchItemNo){
					searchItemByItemNo(searchItemNo,'',searchBarcode);
				}else{
					top.jAlert('warning', '请输入查询条件！','提示消息',function(e){
						if( e.keyCode == 13 || e.keyCode == 27 ) {
							$.alerts._hide();
						}
					});		
				} 
			}
		});
 		$("#barcode").unbind().bind('keypress', function(e) {
 			window.event.cancelBubble=true;
			var code=e.keyCode;
			if (13==code) {
				var searchItemNo = getPageItemNo();
				var searchBarcode = getPageBarcode();
				if(searchBarcode){
					searchItemByItemNo(searchItemNo,'',searchBarcode);
				}else{
					top.jAlert('warning', '请输入查询条件！','提示消息');
				} 
			}
		});
 		$(".searchField").each(function(){
			$(this).focus(function() {
	 			if($(this).val() == $(this).attr("placeholder")) {
	 				$(this).val("");
	 				$(this).css('color', '#333333');
	 			}
	 		});
		}); 
	});

	//图片维护功能，如果有图片信息

	$(function() {
		//加载当前商品的图片信息
		"<c:if test='${itemBasicVO.itemNo ne null}'>"
		readLookItemPicInfos("${itemBasicVO.itemNo}");
		"</c:if>"
		//加载图片信息
		"<c:if test='${itemBasicVO.status != null}'>"
		$("#readAndUpdateItemPic")
				.unbind("click")
				.bind(
						"click",
						function() {
							if ($("#itemNo").val() != ""
									&& $("#itemMainStatus").val() != "") {
								var ht = $(document).height();
								var wd = $(document).width();
								$("#managerItemPicDiv").css({
									"height" : ht,
									"width" : wd,
									"display" : "block"
								});


								$.post(ctx + '/uploadItemPicAction/toUploadItemPic',{'itemNo':'${itemBasicVO.itemNo}'},function(data){
									$("#updateItemPicInfo").html(data);
								},'html');


							}
						});
		"</c:if>"
	});

	//关闭事件(编辑图片窗口)
	$("#closeItemViewEditPic").unbind("click").bind("click", function() {
		$("#managerItemPicDiv").hide();
		$("#updateItemPicInfo").empty();
		itemLookInfos=new Array();
		//重新加载图片信息
		readLookItemPicInfos("${itemBasicVO.itemNo}");
		
	});


    //需要执行的方法，读取图片信息
    function readLookItemPicInfos(itemId){
   	 $.ajax({
				url :'${ctx}/uploadItemPicAction/readItemPic?tt='
						+ new Date().getTime(),
				data : {itemNo:itemId},
				type : 'POST',
				success : function(response) {
					if(response!=""){
				       //读取图片信息
					       $(response).each(function(index,item){
					    	   var link=ufs+item.itemPicFileId;
					    	   itemLookInfos.push(link);                      	
						       });
                            //有数据就加载图片信息
					       loadReadPicInfo("lookBsaeItem");
					       loadFristImg();		
					}				
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					top.jAlert('error', '网络超时!请稍后重试', '提示消息');
				}
			});
        }


  //加载浏览图片信息
    function loadReadPicInfo(id){

    	//关闭事件(查看图片窗口)
    	$("#closeLookPic").live("click", function () {
    	    $("#"+id+"_p").css("display", "none");
    	});
    	
   	 $("#"+id+"_prev_brower").live("mouseover", function () {
   		    $(this).addClass("prev_brower_bg");
   		});
   		$("#"+id+"_prev_brower").live("mouseout", function () {
   		    $(this).removeClass("prev_brower_bg");
   		});
   		$("#"+id+"_next_brower").live("mouseover", function () {
   		    $(this).addClass("next_brower_bg");
   		});
   		$("#"+id+"_next_brower").live("mouseout", function () {
   		    $(this).removeClass("next_brower_bg");
   		});

   		$("#"+id+"_next_brower").unbind("click").bind("click", function () {
   			$("#lookBsaeItem_pp3").empty();
   			if(typeof(itemLookInfos[itemLookNumber+1])!='undefined' || itemLookInfos[itemLookNumber+1]!=null){
   				itemLookNumber=itemLookNumber+1;
   				loadItemImgInfos(id,itemLookInfos[itemLookNumber]);
				$("#lookBsaeItem_pp3").text("当前第"+(itemLookNumber+1)+"张，共"+itemLookInfos.length+"张");   				
   		    	}else{
                $("#lookBsaeItem_pp3").text("已经到最后一张了");
   	   		    	}
   		});
   		$("#"+id+"_prev_brower").unbind("click").bind("click", function () {
   			$("#lookBsaeItem_pp3").empty();
   			if(typeof(itemLookInfos[itemLookNumber-1])!='undefined' || itemLookInfos[itemLookNumber-1]!=null){
				$("#lookBsaeItem_pp3").text("当前第"+itemLookNumber+"张，共"+itemLookInfos.length+"张");  	   			
   				itemLookNumber=itemLookNumber-1;
   				loadItemImgInfos(id,itemLookInfos[itemLookNumber]);
   		    	}else{
   		    	 $("#lookBsaeItem_pp3").text("已经到第一张了");
   	   		    	}
   		});
   	 }

  //加载图片到层中
    function loadItemImgInfos(id,key){
    	 $("#"+id+"_pp2").empty();
        $("#"+id+"_pp2").attr("src",key);
        }

    
//浏览图片信息
function showItemPic(){
	itemLookNumber=0;
	if(itemLookInfos.length>0){
		$("#lookBsaeItem_p").css({ "top": 0, "left": 0, "display": "block", "width": screen.width, "height": "690px" });
		$("#lookBsaeItem_pp3").empty();
		 $("#lookBsaeItem_pp2").empty();
		   $("#lookBsaeItem_pp2").attr("src",itemLookInfos[0]);

			$("#lookBsaeItem_pp3").text("当前第1张，共"+itemLookInfos.length+"张");  	  
		}else{
			top.jAlert('warning', '没有检测到图片', '提示消息');   
			}		
}

//加载第一张图片到默认图片中
function loadFristImg(){

	if(itemLookInfos.length>0){
          $("#itemBaseInfoImg").attr("src",itemLookInfos[0]);
	}else{
		  $("#itemBaseInfoImg").attr("src","${ctx}/shared/themes/theme1/images/defaultImg.png");
		}
	
}

    
</script>
<!-- 1.这里加载遮罩层信息 ，图片浏览遮罩层-->
<div id="lookBsaeItem_p" class="_p">
	<div id="lookBsaeItem_p_brower" style="border: 2px solid #3f9673;"
		class="p_brower">
		<div class="zwindow_titleBar"
			style="height: 40px; position: relative;">
			<div class="zwindow_titleButtonBar">
				<div id="closeLookPic" class="zwindow_action_button zwindow_close"></div>
			</div>
			<div class="zwindow_title titleText">浏览图片信息</div>
		</div>

		<div id="lookBsaeItem_prev_brower" class="prev_brower"></div>
		<div id="lookBsaeItem_pp" class="pp">
			<img src="" id="lookBsaeItem_pp2" alt="" class="pp2" />
			<div id="lookBsaeItem_pp3" class="pp3"></div>
		</div>
		<div id="lookBsaeItem_next_brower" class="next_brower"></div>
	</div>
</div>


<!-- 2.图片编辑遮罩层 -->
<div id="managerItemPicDiv" class='picture_layer'>
	<div
		style='width: 1032px; height: 500px; background: #fff; overflow: hidden; margin: 60px auto; border: 2px solid #3f9673;'>
		<div class="zwindow_titleBar"
			style="height: 40px; position: relative;">
			<div class="zwindow_titleButtonBar">
				<div id="closeItemViewEditPic"
					class="zwindow_action_button zwindow_close"></div>
			</div>
			<div class="zwindow_title titleText">新增图片信息</div>
		</div>
		<div style="height: 460px; overflow-x: hidden; overflow: hidden;"
			id="updateItemPicInfo"></div>
	</div>
</div>

<div id="itemBaseInfoContainer">
	<!-- 商品信息管理 -->
	<div class="CTitle" id="itemOverViewTitle">
		<!--第一个-->
		<div class="tags1_left tags1_left_on"></div>
		<div class="tagsM tagsM_on" id="ovreviewTab">商品总览</div>
		<div class="tags tags_left_on"></div>
		<div class="tagsM" id="priceChangeTab">商品变价</div>
		<div class="tags"></div>
		<div class="tagsM" id="specInfoTab">商品规格</div>
		<div class="tags"></div>
		<div class="tagsM" id="barcodeInfoTab">商品条码</div>
		<div class="tags"></div>
		<div class="tagsM" id="realativeInfoTab">商品关联</div>
		<div class="tags"></div>
		<div class="tagsM" id="supInfoTab">商品厂商</div>
		<div class="tags "></div>
		<div class="tagsM" id="saleCtrlInfoTab">商品陈列</div>
		<div class="tags "></div>
		<div class="tagsM" id="dcInfoTab">DC信息</div>
		<div class="tags "></div>
		<div class="tagsM" id="originInfoTab">商品产地</div>
		<div class="tags "></div>
		<div class="tagsM " id="supAreaInfoTab">商品供应区域</div>
		<div class="tags "></div>
		<div class="tagsM " id="itemOrderQuery">商品订单查询</div>
		<div class="tags tags3_r_off"></div>		
	</div>



	<div class="Container-1">
		<div class="Content" id="Content">
			<!-- 标头信息 -->
			<div class="CInfo">
				<div style="float: left;" class="w25">
					<div class="cinfo_div">店号</div>
					<select class="w65" id="storeNo" name="storeNo"
						onchange="changeStoreNo(this.value)">
						<c:forEach items="${storeList}" var="store">
							<option value="${store.storeNo}" title="${store.storeNo}-${store.storeName}"
								<c:if test="${storeNo == store.storeNo}">selected</c:if>>${store.storeNo}-${store.storeName}</option>
						</c:forEach>
					</select>
				</div>
				<div id="message" style="display:none">
					<span>项</span> <span class="canEmpty">${total}</span> <span>/</span>
					<span class="canEmpty">${page}</span> <span>第</span> <span>|</span>
					<span class="canEmpty">${itemBasicVO.chngBy}</span> <span>修改人</span>
					<span class="canEmpty"><fmt:formatDate pattern="yyyy-MM-dd"
							value="${itemBasicVO.chngDate}" /></span> <span>修改日期</span> <span
						class="canEmpty">${itemBasicVO.creatBy}</span> <span>建档人</span> <span
						class="canEmpty"><fmt:formatDate pattern="yyyy-MM-dd"
							value="${itemBasicVO.creatDate}" /></span> <span>创建日期</span>
				</div>
			</div>
			<!-- 基本信息 -->
			<div style="height: 270px;" id="baseItemInfo" class="CM">
				<div class="CM-bar">
					<div>基本信息</div>
				</div>
				<div class="CM-div">
					<div class="ic">
						<div class="pic_1">
							<!-- 图片信息 -->
							<img width="111" height="111" id="itemBaseInfoImg"
								src="${ctx}/shared/themes/theme1/images/defaultImg.png" onclick="showItemPic()">
								<c:if test="${itemBasicVO ne null}"> 
							<div class="pic_21">
								<div class="look_pic edit_div" id="lookandUpdateItemPic" onclick="showItemPic()"></div>
								<auchan:operauth ifAnyGrantedCode="112111998" >								
								<div class="edit_pic edit_div" id="readAndUpdateItemPic"></div>
								</auchan:operauth>
							</div>
							</c:if>
						</div>
						<div class="item11_1">
							<!--1-->
							<div class="icol_text w7">
								<span>货号</span>
							</div>
							<div class="i_input1_2">
								<div class="iconPut ib_2">
									<input type="text" class="w75 count_text searchField" id="itemNo"
										value="${itemBasicVO.itemNo}" placeholder="输入货号"
										readonly="readonly" onkeyup="value=this.value.replace(/\D+/g,'')" maxlength="8"/>
									<div class="ListWin" onclick="chooseItemNo();"></div>
								</div>
								<div class="icol_text w12_5">
									<span>条码</span>
								</div>
								<div class="iconPut ib">
									<input type="text" class="w80 searchField" id="barcode"  placeholder="输入条码" readonly="readonly" maxlength="14" value="${barcodeSearch}"/>
									<div class="ListWin" onclick="chooseItemBarcode();"></div>
								</div>
							</div>
							<div class="icol_text w10">
								<span>采购方式</span>
							</div>
							<div class="i_input2">
								<input class="inputText _w120" readonly="readonly"
									<c:if test="${itemBasicVO.buyMethd != null}">
		                                   	value="<auchan:getDictValue code="${itemBasicVO.buyMethd}" mdgroup="ITEM_BASIC_BUY_METHD"></auchan:getDictValue>"
		                            </c:if> />
							</div>
							<div class="icol_text w10">
								<span>项目类型</span>
							</div>
							<div class="i_input3">
								<input class="inputText _w120" readonly="readonly"
									<c:if test="${itemBasicVO.projLabel != null}">
	                                   	value="<auchan:getDictValue code="${itemBasicVO.projLabel}" mdgroup="ITEM_BASIC_PROJ_LABEL">
	                                   		   </auchan:getDictValue>"
                                   	</c:if> />
							</div>
							<!--1-->
							<div class="icol_text w7">
								<span>品名</span>
							</div>
							<div class="i_input1_2">
								<input type="text" id="itemName" class="inputText w90_5"
									value="${itemBasicVO.itemName}" readonly="readonly" />
							</div>
							<div class="icol_text w10">
								<span>商品类别</span>
							</div>
							<div class="i_input2">
								<input class="inputText _w120" readonly="readonly"
									<c:if test="${itemBasicVO.itemType != null}">
	                                   	value="<auchan:getDictValue code="${itemBasicVO.itemType}" mdgroup="ITEM_BASIC_ITEM_TYPE">
	                                   		   </auchan:getDictValue>"
                                   	</c:if> />
							</div>
							<div class="icol_text w10">
								<span>加工类别</span>
							</div>
							<div class="i_input3">
								<input class="inputText _w120" readonly="readonly"
									<c:if test="${itemBasicVO.prcssType != null}">
	                                    value="<auchan:getDictValue code="${itemBasicVO.prcssType}" mdgroup="ITEM_BASIC_PRCSS_TYPE"></auchan:getDictValue>"
                                    </c:if> />
							</div>
							<!--1-->
							<div class="icol_text w7">
								<span>英文品名</span>
							</div>
							<div class="i_input1_2">
								<input type="text" class="inputText w90_5"
									value="${itemBasicVO.itemEnName}" readonly="readonly" />
							</div>
							<div class="icol_text w10">
								<span>商品包装</span>
							</div>
							<div class="i_input2">
								<input class="inputText _w120" readonly="readonly"
									<c:if test="${itemBasicVO.itemPack != null}">
                                    	value="<auchan:getDictValue code="${itemBasicVO.itemPack}" mdgroup="ITEM_BASIC_ITEM_PACK"></auchan:getDictValue>"
                                   	</c:if> />
							</div>
							<div class="icol_text w10">
								<span>采购期限</span>
							</div>
							<div class="i_input3">
								<input class="inputText _w120" readonly="readonly"
									<c:if test="${itemBasicVO.buyPerd != null}">	
                                    	value="<auchan:getDictValue code="${itemBasicVO.buyPerd}" mdgroup="ITEM_BASIC_BUY_PERD"></auchan:getDictValue>"
                                    </c:if> />
							</div>
							<!--1-->
							<div class="icol_text w7">
								<span>主厂商</span>
							</div>
							<div class="i_input1_2">
								<input type="text" class="inputText w28" readonly="readonly"
									value="${itemBasicVO.comNo}" /> <input type="text"
									class="inputText w60" value="${itemBasicVO.comName}"
									readonly="readonly" />
							</div>
							<div class="icol_text w10">
								<span>季节期数</span>
							</div>
							<input type="text" class="inputText ik" style="width: 10%;" id="topic" readonly="readonly" />
							<div class="icol_text w7">
								<span>有效期间</span>
							</div>
							<input class="inputText fl_left _w83" type="text" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${itemBasicVO.validStartDate}"/>" readonly="readonly" /> 
							<span class="fl_left">&nbsp;-&nbsp;</span> 
							<input class="inputText _w83" type="text" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${itemBasicVO.validEndDate}"/>" readonly="readonly" />
						</div>
					</div>
					<div class="ic">
						<div class="ig">
							<span class="icol_text2">主状态</span>
								<div class="ia">
									<div class="iconPut w95">
                                        <input id="itemMainStatus" type="text" class="w75"
										readonly="readonly"
										<c:if test="${itemBasicVO.status != null}">
		                                   	value="<auchan:getDictValue code="${itemBasicVO.status}" mdgroup="ITEM_BASIC_STATUS"></auchan:getDictValue>"
	                                   	</c:if> />                                        
                                        <div class="pie" onClick="openStatusDistributeWind();"></div>
                                    </div>							
								<%-- <input id="itemMainStatus" class="inputText _w90" onClick="openStatusDistributeWind();"
									readonly="readonly"
									<c:if test="${itemBasicVO.status != null}">
	                                   	value="<auchan:getDictValue code="${itemBasicVO.status}" mdgroup="ITEM_BASIC_STATUS"></auchan:getDictValue>"
                                   	</c:if> /> --%>
							</div>
							<span class="icol_text2">品牌</span> <input type="text"
								class="inputText ih" value="${itemBasicVO.brandId}"
								readonly="readonly" /> <input type="text" class="inputText ik"
								value="${itemBasicVO.brandName}" readonly="readonly" />
							<div class="icol_text w11">
								<span>产地维护</span>
							</div>
							<div class="i_input2">
								<input class="inputText _w120" readonly="readonly"
									<c:if test="${itemBasicVO.orignCtrl != null}">
                                   		value="<auchan:getDictValue code="${itemBasicVO.orignCtrl}" mdgroup="ITEM_BASIC_ORIGIN_CTRL"></auchan:getDictValue>"
                                   	</c:if> />
							</div>
							<span class="tiaoma">条码贴标</span> <input class="inputText _w120"
								style="width: 143px"
								<c:if test="${itemBasicVO.barcodeLabel != null}">
		                           	value="<auchan:getDictValue code="${itemBasicVO.barcodeLabel}" mdgroup="ITEM_BASIC_BARCODE_LABEL"></auchan:getDictValue>"
		                        </c:if>
								readonly="readonly" />
						</div>
						<div class="io">
							<div class="ig">
								<span class="icol_text2">处别</span> <input class="inputText iq"
									value="${itemBasicVO.divNo}" readonly="readonly" /> <input
									class="longText inputText w50" value="${itemBasicVO.divName}"
									readonly="readonly" />
							</div>
							<div class="ig">
								<span class="icol_text2">课别</span> <input class="inputText iq"
									value="${itemBasicVO.secNo}" readonly="readonly" /> <input
									class="longText inputText w50" value="${itemBasicVO.secName}"
									readonly="readonly" />
							</div>
							<div class="ig">
								<span class="icol_text2">系列</span> <input class="inputText iq"
									value="${itemBasicVO.clstrId}" readonly="readonly" /> <input
									class="longText inputText w50" value="${itemBasicVO.clstrName}"
									readonly="readonly" id="clstrName"/>
							</div>
						</div>
						<div class="io2">
							<div class="ig">
								<span class="icol_text2">大分类</span> <input class="inputText iq"
									value="${itemBasicVO.grpNo}" readonly="readonly" /> <input
									class="longText inputText w37" type="text"
									value="${itemBasicVO.grpName}" readonly="readonly" />
							</div>
							<div class="ig">
								<span class="icol_text2">中分类</span> <input class="inputText iq"
									value="${itemBasicVO.midgrpNo}" readonly="readonly" /> <input
									class="longText inputText w37"
									value="${itemBasicVO.midgrpName}" readonly="readonly" />
							</div>
							<div class="ig">
								<span class="icol_text2">小分类</span> <input class="inputText iq"
									value="${itemBasicVO.catlgNo}" readonly="readonly" /> <input
									class="longText inputText w37" value="${itemBasicVO.catlgName}"
									readonly="readonly" /><input type="hidden" id="catlgId" value="${itemBasicVO.catlgId}">
							</div>
						</div>
						<div class="ip">
							<div class="ip1 w12_5">
								<div>
									<span>销售单位</span>
								</div>
								<div>
									<span>成本时点</span>
								</div>
								<div>
									<span>分类管控</span>
								</div>
							</div>
							<div class="ip2 w25">
								<div class="ig">
									<div class="iconPut iq1">
										<input type="text" class="w100" readonly="readonly"
											<c:if test="${itemBasicVO.sellUnit != null}">
					                           	value="<auchan:getDictValue code="${itemBasicVO.sellUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>"
					                        </c:if> />
									</div>
								</div>
								<div class="ig">
									<input class="inputText w90" readonly="readonly" id="buyWhen"
										<c:if test="${itemBasicVO.buyWhen != null}">
                                   			value="<auchan:getDictValue code="${itemBasicVO.buyWhen}" mdgroup="ITEM_BASIC_BUY_WHEN"></auchan:getDictValue>"
                                   		</c:if> />
								</div>
							</div>
							<%-- <div class="ip3 w60">
								<div class="ig">
									<span class="icol_text2">进价税率</span>
									<div class="iconPut iq" style="width: 20%">
										<input type="text" class="w60 longText"
											value="${itemBasicVO.buyVatNo}" readonly="readonly" />
										<div class="ListWin"></div>
									</div>
									<input class="longText inputText w35" type="text"
										value="${itemBasicVO.buyVatVal}" readonly="readonly" />%
								</div>
								<div class="ig">
									<span class="icol_text2">售价税率</span>
									<div class="iconPut iq" style="width: 20%">
										<input type="text" class="w60 longText"
											value="${itemBasicVO.sellVatNo}" readonly="readonly" />
										<div class="ListWin"></div>
									</div>
									<input class="longText inputText w35" type="text"
										value="${itemBasicVO.sellVatVal}" readonly="readonly" />%
								</div>
							</div> --%>
							 <c:set var="vatValSell" scope="session" value="${itemBasicVO.sellVatVal}"/>
			      		 	<div class="ip3 w60">
                            	<div class="ig">
                                	<span class="icol_text2">进价</span>
                                   	<input type="text" class="inputText w30 fl_left" readonly="readonly" 
                                   		value="<fmt:formatNumber value="${itemBasicVO.stdBuyPrice}" pattern="#0.0000"/> "/>
                                    <span class="fl_left">元</span>
                                    <span class="icol_text2">税率</span>
                                    <input class="longText inputText w30" type="text" readonly="readonly" 
                                    	<c:if test="${itemBasicVO.buyVatNo != null}">
                                    		value="${itemBasicVO.buyVatNo}-${itemBasicVO.buyVatVal}%" 
                                    	</c:if>
                                    />
                                </div>
                                <div class="ig">
                                    <span class="icol_text2">售价</span>
                                    <input type="text" class="inputText w30 fl_left"  readonly="readonly"
                                    	value="<fmt:formatNumber value="${itemBasicVO.stdSellPrice}" pattern="#0.00"/>"/>
                                    <span class="fl_left">元</span>
                                    <span class="icol_text2">税率</span>
                                    <input class="longText inputText w30" type="text"  readonly="readonly" 
                                    	<c:if test="${itemBasicVO.sellVatNo != null}">
                                    	value="${itemBasicVO.sellVatNo}-${itemBasicVO.sellVatVal}%" 
                                    	</c:if>
                                    />
                                </div>
                            </div>
                            
							 <input class="ia inputText" readonly="readonly"
								 <c:if test="${itemBasicVO.speclGrpCtrl != null}">
                                 	value="<auchan:getDictValue code="${itemBasicVO.speclGrpCtrl}" mdgroup="ITEM_BASIC_SPECL_GRP_CTRL"></auchan:getDictValue>"
	                             </c:if> 
							 />
							 <span class="icol_text2">采购备注</span>
							 <input class="w47 inputText" value="${itemBasicVO.buyerMemo}" readonly="readonly" />
						</div>

					</div>
				</div>
			</div>
			<!-- 状态及价格信息 -->
			<div id="storeInfo">
				<%@ include file="/page/item/itemQuery/item_Overview_Store_Info.jsp"%>
			</div>
		</div>
		<!-- 添加图片信息
		<div id="updateItemPicInfo" class="Content">
		</div> -->
	</div>
</div>
