<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link href="${ctx}/shared/themes/${theme}/css/easyUI/tree.css" type="text/css" rel="stylesheet"/>
<style type="text/css">
    .sp_icon1 {
        margin-left:15px;
    }
    .list_ex {
        height: 260px;
        margin-left:20px;
    }
</style>
 <script type="text/javascript">
     var currtOpenObj_s5=null;
     var itemStoreNo=0;
     var storePrev='storeInfoList';
     var itemDcSelected=0;
     var bnoResult =null;
     var canSubmitFlag=0;
     
     $(function(){
		$('.itemNo').val($('#itemNo').val());
		$('.itemName').val($('#itemName').val());
    	 if($('.buyWhen').val()!='2'){
    		 $('.buyPriceLimit').attr('disabled','disabled');
    	 }
    	 
     	<c:if test="${not empty storeList}">
     	$('.list_ex21').each(function(){
	    	$(this).height('auto');
	    	$(this).parent().height($(this).height()+10);
	    	if($(this).parent().height()==10){
	    		$(this).parent().height('auto');
	    	}
     	});
     	currtOpenObj_s5 = $('#storeListDiv').find('.list_ex0:first');showCurrtDiv();
     	var itemStoreInfoList = $('#storeInfoList').find('.itemStoreInfo').map(
				function() {
					return JSON.stringify($(this).serializeObject());
				}).get().join("+");

		var otherSupFormList = $('#otherSupListDiv').find('.otherSupForm').map(
				function() {
					// return $(this).serialize().replaceAll("=","+");
					return JSON.stringify($(this).serializeObject());
				}).get().join("+");

     	item_create[5] = itemStoreInfoList + otherSupFormList;
     	</c:if>
     	$('.otherSup').each(function(){
     		$(this).keydown(function (e) {
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
    	 nullInputCheck();
    	 inputToInputIntNumber();
    	 inputToInputDoubleNumber();

    	if($('div[supNo="${itemMainSupNo}"]').size()==0 && viewFlag!='1'){
        	$('#add_area').click();
        }else{
		
        }
/*     	 $.each($('.storeInfo'), function(){
    		 inputToInputDoubleNumberAndChkLen($(this));
        	 }); */
    	 //$('.storeInfo').each(inputToInputDoubleNumberAndChkLen($(this)));
    	 inputToInputDoubleNumberAndChkLen($('.storeInfo'));
     });
 </script>
 <form  action="/item/create/doCreateItemStoreInfoAudit" onsubmit="return false;" url="/item/create/doCreateItemStoreInfoAudit" id="item_create_5">
 </form><!-- 
	<div class="CInfo">
		<span class="sp_store5">创建商品基本信息</span> <span
			class="sp_store4">创建商品条码信息</span> <span class="sp_store3">创建商品规格信息</span>
		<span class="sp_store2">创建商品陈列信息</span> <span class="sp_store1 sp_store_on">创建商品厂商门店信息</span>
	</div> -->
	<div class="CInfo">
		<span class="sp_store5"><auchan:i18n id="103001067"></auchan:i18n></span> <span
			class="sp_store4"><auchan:i18n id="103001068"></auchan:i18n></span> <span class="sp_store3"><auchan:i18n id="103001069"></auchan:i18n></span>
		<span class="sp_store2"><auchan:i18n id="103001070"></auchan:i18n></span> <span class="sp_store1 sp_store_on"><auchan:i18n id="103001071"></auchan:i18n></span>
	</div>

     <div style="height:60px;" class="CM">
        <div class="CM-bar"><div><auchan:i18n id="103001003"></auchan:i18n></div></div>
        <div class="CM-div">
            <div class="hh_item">
                 <div class="icol_text w7"><span><auchan:i18n id="103001003"></auchan:i18n></span></div>
                 <div class="iconPut iq" style="width:13%;"><input style="width:83%" type="text" name="itemNo" class="itemNo" readonly="readonly" /><div class="ListWin"></div></div>
                 <input class="inputText iq Black itemName" style="width:20%;" type="text" name="itemName" readonly="readonly" />
            </div>
        </div>
    </div>
    <div style="height:322px;">
        <div class="tb50">
            <div style="height:320px; margin-top:2px;" class="CM">
                <div class="CM-bar"><div><auchan:i18n id="103001149"></auchan:i18n></div></div>
                <div class="CM-div list_ex" id="storeListDiv">
                	<c:set var="storeIndex" value="0"></c:set>
		        	<c:forEach items="${storeList}" var="obj">
		                <div class="list_ex0 sup${obj.stMainSupNo}" supNo="${obj.stMainSupNo}" storeNos="${obj.supStoreNoList}" onclick="if(chkStoreInfo()){currtOpenObj_s5=$(this);showCurrtDiv();}">
				    		<input type="hidden" class="selectStoreObj">
				    		<input type="hidden" class="selectStoreObjData">
				            <div class="list_ex1">
				                <div class="ssuo list_ex11 Icon-size1"></div>
				                <div class="longText list_ex12">${obj.stMainSupNo}-${obj.comName}</div> 
				                <div class="Icon-size2 Tools12 list_ex13 divHide" onclick="currtOpenObj_s5=$(this).parent().parent();openPopupItemWin(650,640,$(this).parent().parent());"></div>
				                <c:if test="${obj.stMainSupNo!=itemMainSupNo}"><div class="list_ex14 Icon-size2 Tools10 divHide" onclick="deleteStoreInfo($(this).parent().parent());"></div></c:if>
				                <c:if test="${obj.stMainSupNo==itemMainSupNo}"><c:set var="itemMainSupNo" value="0"></c:set></c:if>
				            </div>
				            <div class="list_ex2" style="display: none">
				                <div  class="list_ex21" style="height:auto;"><div align="left" style="padding:5px;">${obj.storeNames}</div></div>
				                <div class="zhezhao"></div><!--遮罩-->
				            </div>
				        </div>
                	<c:set var="storeIndex" value="${storeIndex+1}"></c:set>
		            </c:forEach>
                </div>
                <div style="height:30px;width:85%;margin:0 auto;" class="divHide">
                    <div id="add_area" class="Icon-size2 Tools11 fl_left"  onclick="openNewPopupItemWin(650,640);"></div>
                    <span class="fl_left" style="line-height:20px;">&nbsp;&nbsp;<auchan:i18n id="103001150"></auchan:i18n></span>
                </div>
            </div>
        </div>
        <div class="tb50" id="storeInfoList">            
            <c:forEach items="${storeList}" var="store">
                		<form class="itemStoreInfo">
							 <div class="storeInfo  sup${store.stMainSupNo}">
							    <div class="ztjg_info CM">
							    <input type="hidden" class="supStoreNoList" name="supStoreNoList" value="${store.supStoreNoList}">
							    <input type="hidden" class="stMainSupNo" name="stMainSupNo" value="${store.stMainSupNo}">
							        <div class="CM-bar"><div><auchan:i18n id="103001151"></auchan:i18n></div></div>
							        <div class="CM-div">
							            <div class="ig"  style="margin-top:15px;">
							                <div class="msg_txt"><auchan:i18n id="103001032"></auchan:i18n></div>
							                <input type="hidden" class="bnoName" name="mops" value="${store.mops}">
							                <select class="w15 bnoName mustInput" disabled="disabled">
							                <option value="B"<c:if test="${store.mops=='B'}"> selected="selected"</c:if>>B</option>
							                <option value="N"<c:if test="${store.mops=='N'}"> selected="selected"</c:if>>N</option>
							                <option value="O"<c:if test="${store.mops=='O'}"> selected="selected"</c:if>>O</option>
							                </select>
							                <span>&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001152"></auchan:i18n>&nbsp;&nbsp;</span>
            							    <input type="hidden" name="trialSaleInd" class="trialSaleInd" value="<c:if test="${not empty store.trialSaleInd}">${store.trialSaleInd}</c:if><c:if test="${empty store.trialSaleInd}">0</c:if>">
							                <input type="checkbox" class="newSell" onchange="var obj = $(this).parent().find('.trialSaleInd');if(obj.val()=='0'){obj.val(1);}else{obj.val(0);}" <c:if test="${store.trialSaleInd==1}">checked="checked"</c:if>/>
							                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001153"></auchan:i18n>&nbsp;&nbsp;</span>
							                <select class="w15 speclBuyVatNo" name="speclBuyVatNo">
							                	<option value=""><auchan:i18n id="103001154"></auchan:i18n></option>
												<c:forEach items="${vatList}" var="obj">
												<option value="${obj.vatNo}"<c:if test="${store.speclBuyVatNo==obj.vatNo}"> selected="selected"</c:if>>${obj.vatNo}-${obj.vatVal}</option>
												</c:forEach>
							                </select>
							            </div>
							            <div class="ig">
							                <div class="msg_txt">*<auchan:i18n id="103001036"></auchan:i18n></div>
							                <input type="text" class="w20 inputText double_text_with_len normBuyPrice mustInput" intval="6" decval="4" preval="${store.normBuyPrice}" name="normBuyPrice" value="${store.normBuyPrice}"/>
							                <span>&nbsp;<auchan:i18n id="103002016"></auchan:i18n>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*<auchan:i18n id="103001037"></auchan:i18n></span>
							                <input type="text" class="w20 inputText double_text_with_len normSellPrice mustInput" intval="6" decval="2" preval="${store.normSellPrice}" name="normSellPrice" value="${store.normSellPrice}"/>
							                <span>&nbsp;<auchan:i18n id="103002016"></auchan:i18n></span>
							            </div>
							            <div class="ig">
							                <div class="msg_txt"><auchan:i18n id="103001040"></auchan:i18n></div>
							                <input type="text" class="w20 inputText double_text_with_len buyPriceLimit" intval="6" decval="4" preval="${store.buyPriceLimit}" name="buyPriceLimit" title="仅当成本时点为2时，店内采购时输入" value="${store.buyPriceLimit}"/>
							                <span>&nbsp;<auchan:i18n id="103002016"></auchan:i18n>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001041"></auchan:i18n></span>
							                <input type="text" class="w20 inputText double_text_with_len minSellPrice" intval="6" decval="2" preval="${store.minSellPrice}" name="minSellPrice" value="${store.minSellPrice}"/>
							                <span>&nbsp;<auchan:i18n id="103002016"></auchan:i18n></span>
							            </div>
							            <div class="ig">
							                <div class="msg_txt">*<auchan:i18n id="103001044"></auchan:i18n></div>
							                <select class="w20 storeUpdtSpInd mustInput" name="storeUpdtSpInd">
												<c:forEach items="${priceChList}" var="obj">
												<option value="${obj.code}"<c:if test="${store.storeUpdtSpInd==obj.code}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
												</c:forEach>
							                </select>
							                <span>&nbsp;<auchan:i18n id="103001155"></auchan:i18n>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*<auchan:i18n id="103001034"></auchan:i18n></span>
							                <select class="w20 dcAttr mustInput" name="dcAttr">
												<c:forEach items="${dcAttrList}" var="obj">
												<option value="${obj.code}"<c:if test="${store.dcAttr==obj.code}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
												</c:forEach>
							                </select>
							                <span>&nbsp;</span>
							            </div>
							        </div>
							    </div>
							    <div class="dhxx_info CM">
							        <div class="CM-bar"><div><auchan:i18n id="103001156"></auchan:i18n></div></div>
							        <div class="CM-div">
							            <div class="ig dhxx_info_1"  style="margin-top:15px;">
							                <div class="msg_txt">*<auchan:i18n id="103001047"></auchan:i18n></div>
							                <c:set var="metdStrs" value="${fn:split(store.ordCreatMethd, ',')}"/>
							                <input type="hidden" name="ordCreatMethd" class="ordCreatMethd" value="${store.ordCreatMethd}">
							                <c:forEach items="${itemStoreInfo}" var="obj">
							                <c:set var="metdStr" value="0"/>
							                <c:forEach items="${metdStrs}" var="methd">
							                <c:if test="${methd==obj.code}">
							                <c:set var="metdStr" value="1"/>
							                </c:if>
							                </c:forEach>
							                <input type="checkbox" value="${obj.code}" <c:if test="${metdStr==1}"> checked="checked"</c:if> onclick="changeOrdCreatMethd($(this))" class="ordCreatMethds"/><span>${obj.title}</span>
							                </c:forEach>
							            </div>
							            <div style="height:120px;">
							                <div class="dh_info1">
							                    <div class="ig">
							                        <input type="radio" class="order" checked="checked" style="margin-left:12px;"/>
							                        <span><auchan:i18n id="103001048"></auchan:i18n></span>
							                        <input type="text" class="w30 inputText double_text oplCycle" maxlength="2" preval="${store.oplCycle}" name="oplCycle" value="<c:if test="${not empty store.oplCycle}">${store.oplCycle}</c:if><c:if test="${empty store.oplCycle}">1</c:if>"/>
							                        <span><auchan:i18n id="103001049"></auchan:i18n></span>
							                    </div>
							                    <div style="height:60px;">
							                        <div class="dh_radio1" style="margin-top:25px;"> 
							                            <input type="radio" name="order" disabled="disabled"/>
							                        </div>
							                        <div class="dh_radio2">
							                            <div class="ig">
							                                <span>&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001050"></auchan:i18n>&nbsp;&nbsp;</span><input type="text" class="w50 inputText Black" readonly="readonly"/>
							                            </div>
							                            <div class="ig">
							                                <span>&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001051"></auchan:i18n>&nbsp;&nbsp;</span><input type="text" class="w50 inputText Black" readonly="readonly"/>
							                            </div>
							                        </div>
							                    </div>
							                </div>
							                <div class="dh_info2">
							                      <div class="ig">
							                                <span>&nbsp;*<auchan:i18n id="103001052"></auchan:i18n>&nbsp;</span>
							                                <select class="w50 rtnAllow mustInput" name="rtnAllow">
																<c:forEach items="${rtnAllowList}" var="obj">
																<option value="${obj.code}"<c:if test="${store.rtnAllow==obj.code}"> selected="selected"</c:if>>${obj.title}</option>
																</c:forEach>
							                                </select>
							                            </div>
							                      <div class="ig">
							                                <span>&nbsp;<auchan:i18n id="103001054"></auchan:i18n>&nbsp;</span><input type="text" class="w50 inputText count_text upb" maxlength="4" preval="${store.upb}" name="upb" value="${store.upb}"/>
							                            </div>
							                </div>
							                <div class="dh_info3">
							                      <div class="ig">
							                                <span>&nbsp;*<auchan:i18n id="103001055"></auchan:i18n>&nbsp;</span><input type="text" class="w50 inputText count_text ordMultiParm mustInput" maxlength="4" name="ordMultiParm" preval="${store.ordMultiParm}" value="${store.ordMultiParm}"/>
							                            </div>
							                      <div class="ig">
							                                <span>&nbsp;<auchan:i18n id="103001056"></auchan:i18n>&nbsp;</span><input type="text" class="w50 inputText count_text rcvShelfLifeDays" maxlength="4" name="rcvShelfLifeDays" preval="${store.rcvShelfLifeDays}" value="${store.rcvShelfLifeDays}"/>&nbsp;<auchan:i18n id="103001157"></auchan:i18n>
							                            </div>
							                </div>
							            </div>
							        </div>
							   </div>
							  </div>
						</form>
                	</c:forEach>
        </div>  
    </div>
    <div style="height:140px;margin-top:2px;" class="CM">
        <div class="CM-bar"><div><auchan:i18n id="103001158"></auchan:i18n></div></div>
        <div class="CM-div">
            <div class="zz_info">
                <div class="zz_1">
                    <span class="zz_11"><auchan:i18n id="103001159"></auchan:i18n></span>
                    <span class="zz_12_1"><auchan:i18n id="103001160"></auchan:i18n></span>
                    <span class="zz_13_1"><auchan:i18n id="103001161"></auchan:i18n></span>
                    <span class="zz_14_1"><auchan:i18n id="103001153"></auchan:i18n></span>
                </div>
                <div class="zz_2 fzcsgl combobox-gitem" style="padding-top:5px;" id="otherSupListDiv">
                <c:if test="${not empty ItemSupList}">
                <c:forEach items="${ItemSupList}" var="obj2">
                    <form class="otherSupForm"><div class="ig">
                        <input type="checkbox" class="fl_left divHide" />
                        <div class="iconPut chbox-mgl" style="width:15%;float:left;">
                            <input type="text" style="width:75%" class="otherSup mustInput count_text" name="supNo" preval2="${obj2.supNo}" preval="${obj2.supNo}" othSupNo="${obj2.supNo}" value="${obj2.supNo}" 
                            onblur="getOtherSupplier($(this));"/>
                            <div class="ListWin" onclick="$('.curig').removeClass('curig');$(this).parent().parent().addClass('curig');$.ajaxSetup({async:false});openSupWindow();$('#popupWin:visible .Panel_top span').text('选择非主厂商');$.ajaxSetup({async:true});"></div>
                        </div>
                        <input type="text" class="w17 inputText Black comNo" value="${obj2.comNo}" readonly="readonly" />
                        <input type="text" class="w35 inputText Black comName" value="${obj2.comName}" readonly="readonly" />
                        <select class="w17" name="speclBuyVatNo">
                        	<option value=""><auchan:i18n id="103001154"></auchan:i18n></option>
							<c:forEach items="${vatList}" var="obj">
							<option value="${obj.vatNo}"<c:if test="${obj2.speclBuyVatNo==obj.vatNo}"> selected="selected"</c:if>>${obj.vatNo}-${obj.vatVal}</option>
							</c:forEach>
						</select>
					</div></form>
                    
                </c:forEach>
                </c:if>
                <%-- <c:if test="${empty ItemSupList && empty storeList}">
                    
                    <form class="otherSupForm">
                    <div class="ig">
                        <input type="checkbox" class="fl_left" onclick="resetCheckAll($(this).parent().parent().parent());"/>
                        <div class="iconPut" style="width:15%;float:left;">
                            <input type="text" style="width:75%" name="supNo" class="otherSup mustInput count_text" onblur="if($(this).attr('preval2')!=$(this).val()){getOtherSupplier($(this));}"/>
                            <div class="ListWin" onclick="$('.curig').removeClass('curig');$(this).parent().parent().addClass('curig');openSupWindow();"></div>
                        </div>
                        <input type="text" class="w17 inputText Black comNo"  readonly="readonly" />
                        <input type="text" class="w35 inputText Black comName"  readonly="readonly" />
                        <select class="w17" name="speclBuyVatNo">
                        	<option value="">选择税率</option>
							<c:forEach items="${vatList}" var="obj">
							<option value="${obj.vatNo}">${obj.vatNo}-${obj.vatVal}</option>
							</c:forEach>
						</select>
					 </div></form>
                   
                </c:if> --%>
                </div>
                <div class="ig divHide">
                    <input type="checkbox" class="sp_icon1 checkAll" onclick="selectCheckbox($(this).parent().prev(),$(this).attr('checked'));"/>
                    <div class="Icon-size2 Tools10 sp_icon2" onclick="$('#otherSupListDiv').find('.ig input:checkbox:checked').each(function(){$(this).parent().parent().remove();});resetCheckAll($('#otherSupListDiv'));setSubmitStatus();">
                    </div><div class="Icon-size2 Line-1 sp_icon3 "></div>
                    <div class="Icon-size2 Tools11 sp_icon4" onclick="addOtherSupInfo();$(this).parent().find('.checkAll').attr('checked',false);"></div>
                </div>
            </div>
        </div>
    </div>
    <div id="storeListDftDiv" style="display: none">
        <div class="list_ex0" onclick="if(currtOpenObj_s5.attr('supNo')==$(this).attr('supNo') || chkStoreInfo()){currtOpenObj_s5=$(this);showCurrtDiv();}">
    		<input type="hidden" class="selectStoreObj">
    		<input type="hidden" class="selectStoreObjData">
            <div class="list_ex1">
                <div class="ssuo list_ex11 Icon-size1"></div>
                <div class="longText list_ex12"></div> 
                <div class="Icon-size2 Tools12 list_ex13" onclick="currtOpenObj_s5=$(this).parent().parent();openPopupItemWin(650,640,$(this).parent().parent());"></div>
                <div class="list_ex14 Icon-size2 Tools10" onclick="deleteStoreInfo($(this).parent().parent());"></div>
            </div>
            <div class="list_ex2" style="display: none">
                <div  class="list_ex21"></div>
                <div class="zhezhao"></div><!--遮罩-->
            </div>
        </div>
    </div><input type="hidden" id="allStoreNoList" value="<c:forEach items="${storeList}" var="obj">${obj.supStoreNoList},</c:forEach>">
<div class="popupItemWin" class="Panel" style="display: none"></div>
<div id="storeInfoModelDiv" style="display: none">
<form class="itemStoreInfo">
 <div class="storeInfo">
    <div class="ztjg_info CM">
    <input type="hidden" class="supStoreNoList" name="supStoreNoList">
    <input type="hidden" class="stMainSupNo" name="stMainSupNo">
        <div class="CM-bar"><div><auchan:i18n id="103001151"></auchan:i18n></div></div>
        <div class="CM-div">
            <div class="ig"  style="margin-top:15px;">
                <div class="msg_txt"><auchan:i18n id="103001032"></auchan:i18n></div>
				<input type="hidden" class="bnoName" name="mops" value="">
                <select class="w15 bnoName mustInput">
                <option value="B">B</option>
                <option value="N">N</option>
                <option value="O">O</option>
                </select>
                <span>&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001152"></auchan:i18n>&nbsp;&nbsp;</span>
                <input type="hidden" name="trialSaleInd" class="trialSaleInd" value="0">
                <input type="checkbox" class="newSell" onchange="var obj = $(this).parent().find('.trialSaleInd');if(obj.val()=='0'){obj.val(1);}else{obj.val(0);}"/>
                <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001153"></auchan:i18n>&nbsp;&nbsp;</span>
                <select class="w15 speclBuyVatNo" name="speclBuyVatNo">
                	<option value=""><auchan:i18n id="103001154"></auchan:i18n></option>
					<c:forEach items="${vatList}" var="obj">
					<option value="${obj.vatNo}">${obj.vatNo}-${obj.vatVal}</option>
					</c:forEach>
                </select>
            </div>
            <div class="ig">
                <div class="msg_txt">*<auchan:i18n id="103001036"></auchan:i18n></div>
                <input type="text" class="w20 inputText double_text_with_len normBuyPrice mustInput" intval="6" decval="4" name="normBuyPrice"/>
                <span>&nbsp;<auchan:i18n id="103001155"></auchan:i18n>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*<auchan:i18n id="103001037"></auchan:i18n></span>
                <input type="text" class="w20 inputText double_text_with_len normSellPrice mustInput" intval="6" decval="2" name="normSellPrice"/>
                <span>&nbsp;<auchan:i18n id="103001155"></auchan:i18n></span>
            </div>
            <div class="ig">
                <div class="msg_txt"><auchan:i18n id="103001040"></auchan:i18n></div>
                <input type="text" class="w20 inputText double_text_with_len buyPriceLimit" intval="6" decval="4" name="buyPriceLimit" title="仅当成本时点为2时，店内采购时输入" />
                <span>&nbsp;<auchan:i18n id="103001155"></auchan:i18n>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001041"></auchan:i18n></span>
                <input type="text" class="w20 inputText double_text_with_len minSellPrice" intval="6" decval="2" name="minSellPrice"/>
                <span>&nbsp;<auchan:i18n id="103001155"></auchan:i18n></span>
            </div>
            <div class="ig">
                <div class="msg_txt">*<auchan:i18n id="103001044"></auchan:i18n></div>
                <select class="w20 storeUpdtSpInd mustInput" name="storeUpdtSpInd">
					<c:forEach items="${priceChList}" var="obj">
					<option value="${obj.code}">${obj.code}-${obj.title}</option>
					</c:forEach>
                </select>
                <span>&nbsp;元&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*<auchan:i18n id="103001034"></auchan:i18n></span>
                <select class="w20 dcAttr mustInput" name="dcAttr">
					<c:forEach items="${dcAttrList}" var="obj">
					<option value="${obj.code}">${obj.code}-${obj.title}</option>
					</c:forEach>
                </select>
                <span>&nbsp;</span>
            </div>
        </div>
    </div>
    <div class="dhxx_info CM">
        <div class="CM-bar"><div><auchan:i18n id="103001156"></auchan:i18n></div></div>
        <div class="CM-div">
            <div class="ig dhxx_info_1"  style="margin-top:15px;">
                <div class="msg_txt">*<auchan:i18n id="103001047"></auchan:i18n></div>
                <input type="hidden" name="ordCreatMethd" id="ordCreatMethd" class="ordCreatMethd mustInput">
                <c:forEach items="${itemStoreInfo}" var="obj">
                <input type="checkbox" value="${obj.code}" onclick="changeOrdCreatMethd($(this))" class="ordCreatMethds"/><span>${obj.title}</span>
                </c:forEach>
            </div>
            <div style="height:120px;">
                <div class="dh_info1">
                    <div class="ig">
                        <input type="radio" class="order" checked="checked" style="margin-left:12px;"/>
                        <span><auchan:i18n id="103001048"></auchan:i18n></span>
                        <input type="text" class="w30 inputText double_text oplCycle" name="oplCycle" value="1" maxlength="2"/>
                        <span><auchan:i18n id="103001049"></auchan:i18n></span>
                    </div>
                    <div style="height:60px;">
                        <div class="dh_radio1" style="margin-top:25px;"> 
                            <input type="radio" name="order" disabled="disabled"/>
                        </div>
                        <div class="dh_radio2">
                            <div class="ig">
                                <span>&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001050"></auchan:i18n>&nbsp;&nbsp;</span><input type="text" class="w50 inputText Black" readonly="readonly"/>
                            </div>
                            <div class="ig">
                                <span>&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001051"></auchan:i18n>&nbsp;&nbsp;</span><input type="text" class="w50 inputText Black" readonly="readonly"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="dh_info2">
                      <div class="ig">
                                <span>&nbsp;*<auchan:i18n id="103001052"></auchan:i18n>&nbsp;</span>
                                <select class="w50 rtnAllow mustInput" name="rtnAllow">
									<c:forEach items="${rtnAllowList}" var="obj">
									<option value="${obj.code}">${obj.code}-${obj.title}</option>
									</c:forEach>
                                </select>
                            </div>
                      <div class="ig">
                                <span>&nbsp;<auchan:i18n id="103001054"></auchan:i18n>&nbsp;</span><input type="text" maxlength="4" class="w50 inputText count_text upb" name="upb"/>
                            </div>
                </div>
                <div class="dh_info3">
                      <div class="ig">
                                <span>&nbsp;*<auchan:i18n id="103001055"></auchan:i18n>&nbsp;</span><input type="text" maxlength="4" class="w50 inputText count_text ordMultiParm mustInput" name="ordMultiParm"/>
                            </div>
                      <div class="ig">
                                <span>&nbsp;<auchan:i18n id="103001056"></auchan:i18n>&nbsp;</span><input type="text" maxlength="4" class="w50 inputText count_text rcvShelfLifeDays" name="rcvShelfLifeDays"/>&nbsp;天
                            </div>
                </div>
            </div>
        </div>
   </div>
  </div>
  </form>
</div>

<div id="otherSupDiv" class="Bar_off">

<form class="otherSupForm"><div class="ig">
	<input type="checkbox" class="fl_left" onclick="resetCheckAll($(this).parent().parent().parent());"/>
	<div class="iconPut iq" style="width:15%;float:left;">
	    <input type="text" style="width:75%" class="otherSup mustInput count_text" name="supNo" onblur="getOtherSupplier($(this));"/>
	    <div class="ListWin" onclick="$('.curig').removeClass('curig');$(this).parent().parent().addClass('curig');$.ajaxSetup({async:false});openSupWindow();$('#popupWin:visible .Panel_top span').text('选择非主厂商');$.ajaxSetup({async:true});"></div>
	</div>
	<input type="text" class="w17 inputText Black comNo"  readonly="readonly" />
	<input type="text" class="w35 inputText Black comName"  readonly="readonly" />
	<select class="w17" name="speclBuyVatNo">
      	<option value=""><auchan:i18n id="103001154"></auchan:i18n></option>
		<c:forEach items="${vatList}" var="obj">
		<option value="${obj.vatNo}">${obj.vatNo}-${obj.vatVal}</option>
		</c:forEach>
	</select>
	</div>
</form>

</div>