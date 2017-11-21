<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/item/itemSearch.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/picShow/showComLicncePic.js"></script>

<style type="text/css">
._w120 {
	width: 120px;
}
._w80 {
	width: 80px;
}
.ListWin {
    height: 20px;
    width: 20px;
    margin-top: 5px;
    margin-left: 3px;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#ovreviewContent").find("input").attr("readonly","readonly");
		$("#itemNo").attr("readonly",false);
		setToolsbarAllDisable();
		$("#Tools21").unbind().removeClass().addClass('Icon-size1 Tools21_disable');
		//修改商品规格信息
		if ($.trim($('#itemName').val()) != "") {
			
		 	<auchan:operauth ifAnyGrantedCode="112113002" >
			$('#Tools12').removeClass('Tools12_disable').addClass('Tools12').unbind('click').bind('click', function() {
				$.ajax( {
					type : 'post',
					url : ctx + '/item/basicInformation/judgeItemNoWhetherAlterAction',
					data :{itemNo : $("#itemNo").val()},
					success : function(data) {
						if (data.status == "success") {
							param.itemNo = $('#itemNo').val();
							param.itemName = $('#itemName').val();
							$('#ovreviewContent').load(ctx + '/item/basicInformation/alertItemSpecInfoAction', param);
						} else {
							top.jAlert('warning', data.message,'提示消息');
						}
					}
				});
			});
			</auchan:operauth>
		}
		//传递参数 
		var param = {
			'itemNo' : '${sessionScope.itemNoSearch}',
			'itemName' : '${sessionScope.itemNameSearch}',
			'storeNo' : '${sessionScope.storeNoSearch}',
			'storeName' : '${sessionScope.storeNameSearch}'
		};
		//商品总览(tab)
		$('#ovreviewTab').unbind("click").bind( 'click', function() {
			var itemNo = '${sessionScope.itemNoSearch}';
			if(itemNo != null && itemNo != ""){
				searchItemByItemNo('${sessionScope.itemNoSearch}','${sessionScope.storeNoSearch}');
				
			}else{
				$('.Container').load(ctx + '/item/query/generalSearch', param);
			}
		});
		//变价信息(tab)
		$('#priceChangeTab').unbind("click").bind( 'click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemPriceChangeInfo', param);
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
		$('#saleCtrlInfoTab').unbind("click").bind( 'click', function() {
			$('#ovreviewContent').load(ctx+ '/item/query/itemRealStoreSaleCtrlInfo',param);
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
		openCleanBtn('/item/query/itemSpecInfo',false);
		//直接点击后，打开查询按钮
		var itemNoSearch = '${sessionScope.itemNoSearch}';
		
		if((itemNoSearch == null || itemNoSearch == "") && 
		    ($("#itemNo").attr("value") == "" || $("#itemNo").attr("value") == "输入货号查询")){
			openSearchBtn('/item/query/itemSpecInfo',false);
		}
		$("#itemNo").unbind().bind('keypress', function(e) {
			var code=e.keyCode;
			if (13==code) {
				$('#Tools6').click();
			}
		});	
	});
</script>
<%-- <%@ include file="/page/commons/toolbar.jsp"%> --%>

	 <div id="look_Item_p"  class="_p">
        <div id="look_Item_p_brower" style="border:2px solid #3f9673;" class="p_brower">
      <div class="zwindow_titleBar" style="height: 40px;position:relative;"><div class="zwindow_titleButtonBar"><div id="close_LookPic" class="zwindow_action_button zwindow_close"></div></div><div class="zwindow_title titleText">浏览图片信息</div></div>
        
            <div id="look_Item_prev_brower" class="prev_brower"></div>
            <div id="look_Item_pp" class="pp">
                <img  id="look_Item_pp2" alt="" class="pp2"/>
                <div id="look_Item_pp3" class="pp3"></div>
            </div>
            <div id="look_Item_next_brower" class="next_brower"></div>
        </div>
    </div>

<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left "></div>
	<div class="tagsM " id="ovreviewTab">商品总览</div>
	<div class="tags "></div>
	<div class="tagsM" id="priceChangeTab">商品变价</div>
	<div class="tags tags_right_on"></div>
	<div class="tagsM tagsM_on" id="specInfoTab">商品规格</div>
	<div class="tags tags_left_on"></div>
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
	<div class="tags"></div>
	<div class="tagsM " id="itemOrderQuery">商品订单查询</div>
<div class="tags tags3_r_off"></div>	
</div>
<div class="CInfo">
	<div style="float: left;" class="w25">
	</div>
	<c:if test="${not empty itemBasicVO}">
		<div id="message">
			<span>项</span> 
			<span class="canEmpty">${total}</span> 
			<span>/</span> 
			<span class="canEmpty">${page}</span>
			<span>第</span> 
			<span>|</span> 
			<span class="canEmpty">${itemSpecInfoVO.chngBy}</span> 
			<span>修改人</span>
			<span class="canEmpty"><fmt:formatDate pattern="yyyy-MM-dd" value="${itemSpecInfoVO.chngDate}" /></span> 
			<span>修改日期</span> <span class="canEmpty">${itemBasicVO.creatBy}</span>
			<span>建档人</span> <span class="canEmpty"><fmt:formatDate pattern="yyyy-MM-dd" value="${itemBasicVO.creatDate}" /></span> 
			<span>创建日期</span>
		</div>
	</c:if>
</div>
	<div style="height: 60px;" class="CM">
		<div class="CM-bar">
			<div>货号</div>
		</div>
		<div class="CM-div">
			<div class="hh_item">
				<div class="icol_text w7">
					<span>货号</span>
				</div>
				<div class="iconPut iq" style="width: 13%;">
					<input class ="w83 count_text" type="text" id="itemNo" value="${itemBasicVO.itemNo }" placeholder="输入货号查询"
					onkeyup="value=this.value.replace(/\D+/g,'')" maxlength="8"/>
					<div class="ListWin" onclick="chooseItemNo()"></div>
				</div>
				<input class="inputText iq " style="width: 20%;" type="text" id="itemName" value="${itemBasicVO.itemName }" />
			</div>
		</div>
	</div>
<div style="height: 300px; margin-top: 2px;">
	<div class="tb50">
		<div style="height: 105px;" class="CM">
			<div class="CM-bar">
				<div>基本信息</div>
			</div>
			<div class="CM-div">
				<div class="ig" style="margin-top: 15px;">
					<div class="msg_txt">商品规格</div>
					<input type="text" class="inputText w70" value="${itemSpecInfoVO.specDesc }" />
				</div>
				<div class="ig">
					<div class="msg_txt">等级</div>
					<input class="inputText _w120" 
						<c:if test="${itemSpecInfoVO.itemGrd != null}">
                           	value="<auchan:getDictValue code="${itemSpecInfoVO.itemGrd}" mdgroup="ITEM_SPEC_ITEM_GRD"></auchan:getDictValue>"
                        </c:if>
					 />
					<span>&nbsp;&nbsp;型号&nbsp;&nbsp;</span> 
					<input type="text" class="inputText w36" value="${itemSpecInfoVO.model }" />
				</div>
				<div class="ig">
					<div class="msg_txt">长</div>
					<input type="text" class="inputText w10" value="${itemSpecInfoVO.face }" /> 
					<span>&nbsp;cm&nbsp;&nbsp;&nbsp;&nbsp;宽</span>
					<input type="text" class="inputText w10" value="${itemSpecInfoVO.depth }" /> 
					<span>&nbsp;cm&nbsp;&nbsp;&nbsp;&nbsp;高</span>
					<input type="text" class="inputText w10" value="${itemSpecInfoVO.hght }" /> 
					<span>&nbsp;cm</span>
				</div>
			</div>
		</div>
		<div style="height: 205px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>其他信息</div>
			</div>
			<div class="CM-div">
				<div class="ig" style="margin-top: 10px;">
					<div class="msg_txt">保存方式</div>
					<input class="inputText w20" value="${itemSpecInfoVO.storgCond}" />
					<span>&nbsp;&nbsp;&nbsp;保质期标注方式&nbsp;</span> 
					<input type="text" class="inputText _w120" 
						<c:if test="${itemSpecInfoVO.shelfLifeIndMethd != null}">
                           	value="<auchan:getDictValue code="${itemSpecInfoVO.shelfLifeIndMethd }" mdgroup="ITEM_SPEC_SHELF_LIFE_IND_METHD"></auchan:getDictValue>"
                        </c:if>					
					/>
				</div>
				<div class="ig">
					<div class="msg_txt">保质期</div>
					<input type="text" class="w15 inputText fl_left" value="${itemSpecInfoVO.stdShelfLifePerd }" />
					<div class="fl_left" style="width: 60px; margin-left: 5px;">
						<input class="inputText" style="height: 20px; width: 45px;"  
							<c:if test="${itemSpecInfoVO.perdUnitName != null}">
	                           	value="<auchan:getDictValue code="${itemSpecInfoVO.perdUnitName }" mdgroup="ITEM_SPEC_PERD_UNIT_NAME" showType="2"></auchan:getDictValue>"
	                        </c:if>							
						/>
					</div>
					<span>或</span> 
					<input type="text" class="w10  inputText" value="${itemSpecInfoVO.stdShelfLifeDays }" /> 
					<span>天</span>
				</div>
				<div class="ig">
					<div class="msg_txt">健康食品</div>
					<%-- <input type="text" class="inputText w15 fl_left" value="${itemSpecInfoVO.hlthLabel }" />  --%>
					<input class="inputText iq " type="text" style="width: 20%; margin-left: 3px;" 
							<c:if test="${itemSpecInfoVO.hlthLabel != null}">
	                           	value="<auchan:getDictValue code="${itemSpecInfoVO.hlthLabel }" mdgroup="ITEM_SPEC_HLTH_LABEL"></auchan:getDictValue>"
	                        </c:if>						
					/>
				</div>
				<div class="ig">
					<div class="msg_txt">食用方法</div>
					<input type="text" class="inputText w70" value="${itemSpecInfoVO.edbleMethd }" />
				</div>
				<div style="height: 60px;">
					<div class="msg_txt">
						<div>成分说明</div>
					</div>
					<textarea class="w70 txtarea" rows="2" readonly="readonly">${itemSpecInfoVO.ingrOrCntntDesc }</textarea>
				</div>
			</div>
		</div>
	</div>
	<div class="tb50">
		<div style="height: 90px;" class="CM">
			<div class="CM-bar">
				<div>包装信息</div>
			</div>
			<div class="CM-div">
				<div style="margin-top: 15px;" class="ig bz_info">
					<div>
						<span class="bz_1">计量单位</span> <span class="bz_2">单位含量（容量）</span>
						<span class="bz_3">包装单位</span> <span class="bz_4">包装计数</span>
					</div>
				</div>
				<div class="ig">
					<span class="jksp">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;</span>
					<input class="inputText iq " type="text" style="width: 10%;" 
						<c:if test="${itemSpecInfoVO.sellUnit != null}">
                           	value="<auchan:getDictValue code="${itemSpecInfoVO.sellUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>"
                        </c:if>					
					/> 
					<span class="jksp">&nbsp;=&nbsp;</span> 
					<input class="inputText iq" type="text" style="width: 10%;" value="${itemSpecInfoVO.numOfPackUnit }" />
					<div class="iconPut iq fl_left" style="width: 10%;">
						<input type="text" style="width: 55%" 
							<c:if test="${itemSpecInfoVO.packUnit != null}">
								value="<auchan:getDictValue code="${itemSpecInfoVO.packUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>" 
							</c:if>		
						/>
						<div class="ListWin"></div>
					</div>
					<span class="fl_left">&nbsp;x&nbsp;</span> 
					<input class="inputText iq" type="text" style="width: 20%;" value="${itemSpecInfoVO.baseVol }" />
					<div class="iconPut iq fl_left" style="width: 12%;">
						<input type="text" style="width: 55%" 
							<c:if test="${itemSpecInfoVO.baseVolUnit != null}">
								value="<auchan:getDictValue code="${itemSpecInfoVO.baseVolUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>" 
							</c:if>	
						/>
						<div class="ListWin"></div>
					</div>
				</div>
				<div class="ig" >
					<div class="msg_txt">均价倍数</div>
					<input type="text" name="avgMulti" class="inputText w20 fl_left" maxlength="9" value="${itemSpecInfoVO.avgMulti }" />
					<div class="msg_txt">均价单位</div>
					<div class="iconPut iq fl_left" style="width: 12%;">
						<input type="text" class="w60 longText" 
							<c:if test="${itemSpecInfoVO.avgUnit != null}">
								value="<auchan:getDictValue code="${itemSpecInfoVO.avgUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>"
							</c:if>	
						/>
						<div class="ListWin" ></div>
					</div>
				</div>
			</div>
		</div>
		<div style="height: 60px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>广告语</div>
			</div>
			<div class="CM-div">
				<div class="ig" style="margin-top: 15px;">
					<div class="msg_txt">广告语</div>
					<input type="text" class="inputText w70" value="${adList2Str}" 
					<c:if test="${adList2Str != null}">onclick="showAdDesc();"</c:if>/>
				</div>
			</div>
		</div>
		<div style="height: 145px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>课别属性</div>
			</div>
			<div class="CM-div">
				<div class="ig" style="margin-top: 15px;">
					<div class="msg_txt">属性1</div>
					<input class="inputText iq " type="text" style="width: 20%;" value="${secAttr1Val.secAttrSeqName }" />
					<div class="iconPut iq fl_left" style="width: 13%;">
						<input type="text" style="width: 60%" value="${secAttr1Val.secAttrValNo }"/>
						<div class="ListWin"></div>
					</div>
					<input class="inputText iq " type="text" style="width: 20%;" value="${secAttr1Val.secAttrValName }" />
				</div>
				<div class="ig">
					<div class="msg_txt">属性2</div>
					<input class="inputText iq " type="text" style="width: 20%;" value="${secAttr2Val.secAttrSeqName }" />
					<div class="iconPut iq fl_left" style="width: 13%;">
						<input type="text" style="width: 60%" value="${secAttr2Val.secAttrValNo }"/>
						<div class="ListWin"></div>
					</div>
					<input class="inputText iq " type="text" style="width: 20%;" value="${secAttr2Val.secAttrValName }" />
				</div>
				<div class="ig">
					<div class="msg_txt">属性3</div>
					<input class="inputText iq " type="text" style="width: 20%;" value="${secAttr3Val.secAttrSeqName }" />
					<div class="iconPut iq fl_left" style="width: 13%;">
						<input type="text" style="width: 60%" value="${secAttr3Val.secAttrValNo }"/>
						<div class="ListWin"></div>
					</div>
					<input class="inputText iq " type="text" style="width: 20%;" value="${secAttr3Val.secAttrValName }" />
				</div>
				<div class="ig">
					<div class="msg_txt">属性4</div>
					<input class="inputText iq " type="text" style="width: 20%;" value="${secAttr4Val.secAttrSeqName }" />
					<div class="iconPut iq fl_left " style="width: 13%;">
						<input type="text" style="width: 60%" class="" value="${secAttr4Val.secAttrValNo }"/>
						<div class="ListWin"></div>
					</div>
					<input class="inputText iq " type="text" style="width: 20%;" value="${secAttr4Val.secAttrValName }" />
				</div>
			</div>
		</div>
	</div>
</div>
<div style="height: 140px; margin-top: 2px;" class="CM">
	<div class="CM-bar">
		<div>证照信息</div>
	</div>
	<div class="CM-div">
		<div class="zz_info">
			<div class="zz_1">
				<span class="zz_11">证件类型</span> <span class="zz_12">证件号码</span> <span
					class="zz_13">发证机关</span> <span class="zz_14">截止日期</span> <span
					class="zz_15">起始日期</span>
			</div>
			<div class="zz_2 itemLicList">
				<c:forEach items="${listComLic}" var="lic">
					<div class="ig" style="margin-top: 5px; margin-left: 10px;">
						<div class="license1 fl_left">
							<div class="license2" onclick="loadComPicInfos('${lic.licnceId}')"></div>
						</div>
						<auchan:select name="new_licnce_type" disabled="disabled"   mdgroup="COM_LICENCE_LICNCE_TYPE" style="width: 17%;" value="${lic.licnceType}" ></auchan:select>
						<input type="text" class="w20 inputText" value="${lic.licnceNo}" /> 
						<input type="text" class="w17 inputText" value="${lic.issueBy}" /> 
						<input type="text" class="w17 inputText" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${lic.vaildEndDate}"/>" />
						<input type="text" class="w17 inputText" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${lic.vaildStartDate}"/>"/>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
