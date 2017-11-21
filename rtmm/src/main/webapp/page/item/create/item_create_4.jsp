<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript" src="${ctx}/shared/js/picShow/showComLicncePic.js"></script>
<script src="${ctx}/item/create/stepFourAutoComplete" type="text/javascript"></script>

<script type="text/javascript">

$(function(){
	//loadLicnceInfo();
	readLicnceIdPicInfosToShow($('#itemNo').val());	

	
});


function loadLicnceInfo(){

$("#item_show_licnce_list").html($("#item_licnce_list").html());
	
};

//读取证件信息
function load_licnce_Pic_info(info){
	var infoOne= $(info).parent().parent().find("[name='new_licnce_type']").val();
	var infoTwo= $(info).parent().parent().find("[name='new_licnce_no']").val();
	 if(infoOne<10){
     	infoOne="0"+infoOne;
         } 
	//显示图片信息
	loadComPicInfos(infoTwo+"@"+infoOne);		
}



//需要执行的方法，读取图片信息
   function readLicnceIdPicInfosToShow(itemNo){
	   havedLicnceInfo=new Array();
	   $("#item_show_licnce_list").empty();
	   $.ajax({
			url :'${ctx}/supplierLicenceAction/readItemLicnceByItemId?tt='
					+ new Date().getTime(),
			data : {itemNo:itemNo},
			type : 'POST',
			success : function(response) {
				$(response).each(function(index,item){
					havedLicnceInfo.push(item.licnceId);
					showItemLicnce(item);
					});
				loadCheckBoxClick();//加载checkbox事件		
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});
       }


   //加载信息到页面
   function showItemLicnce(item){
	   var htmlDiv="<div class='ig'  style='margin-top:5px;'> </div>";
		var htmlone="<div class='license1 fl_left'>"
			 +"<div class='license2' onclick='load_licnce_Pic_info(this)'></div>"
			 +"</div>";
		//设置某个选项为选中项
		var typeInfo=getDictValue('COM_LICENCE_LICNCE_TYPE',item.licnceType);
	    var htmlTwo="<select disabled='disabled'name='new_licnce_type'  style='width:12.5%' title='"+typeInfo+"'> <option  value='"+item.licnceType+"' selected='selected'>"+typeInfo+"</option><select>";
	    var htmlThree="<input type='text' class='w20 inputText'  name='new_licnce_no' value='"+item.licnceNo+"' readonly='readonly'/>"
			 +"<input type='text' class='w20 inputText'  name='new_licnce_issuby' value='"+item.issueBy+"'/>"		 
			 +"<input name='new_licene_endDate' value='"+new Date(item.vaildEndDate).format('yyyy-MM-dd')+"' readonly='readonly' class='Wdate w12_5' type='text' >"
			 +"<input name='new_licnce_startDate' value='"+ new Date(item.vaildStartDate).format('yyyy-MM-dd')+"' readonly='readonly' class='Wdate w12_5' type='text'>";
	          //生成一个层，动态添加到厂商证照列表下
		      $(htmlDiv).html(htmlone+htmlTwo+htmlThree).appendTo("#item_show_licnce_list");
			 $("#item_show_licnce_list input").attr("readonly","readonly");		
	}
	   
</script>

	
    
<form action="/item/create/doCreateItemRealStoreSaleCtrl" id="item_create_4" url="/item/create/doCreateItemRealStoreSaleCtrl">
	<!-- <div class="CInfo">
		<span class="sp_store5">创建商品基本信息</span> <span
			class="sp_store4">创建商品条码信息</span> <span class="sp_store3">创建商品规格信息</span>
		<span class="sp_store2 sp_store_on">创建商品陈列信息</span> <span class="sp_store1">创建商品厂商门店信息</span>
	</div> -->
	<div class="CInfo">
		<span class="sp_store5"><auchan:i18n id="103001067"></auchan:i18n></span> <span
			class="sp_store4"><auchan:i18n id="103001068"></auchan:i18n></span> <span class="sp_store3"><auchan:i18n id="103001069"></auchan:i18n></span>
		<span class="sp_store2 sp_store_on"><auchan:i18n id="103001070"></auchan:i18n></span> <span class="sp_store1"><auchan:i18n id="103001071"></auchan:i18n></span>
	</div>

	<div style="height:60px;" class="CM">
                        <div class="CM-bar"><div><auchan:i18n id="103001003"></auchan:i18n></div></div>
                        <div class="CM-div">
                            <div class="hh_item">
                                 <div class="icol_text w7"><span><auchan:i18n id="103001003"></auchan:i18n></span></div>
                                 <div class="iconPut iq" style="width:13%;"><input style="width:83%" type="text" name="itemNo" class="itemNo" readonly="readonly"/><div class="ListWin"></div></div>
                                 <input class="inputText iq Black itemName" style="width:20%;" type="text" name="itemName" readonly="readonly"/>
                            </div>
                        </div>
                    </div>
                    <div style="height:300px;">
                        <div class="tb50">
                            <div style="height:180px;margin-top:2px;" class="CM">
                                <div class="CM-bar"><div><auchan:i18n id="103001118"></auchan:i18n></div></div>
                                <div class="CM-div">
                                    <div class="ig"  style="margin-top:15px;">
                                        <div class="msg_txt">*<auchan:i18n id="103001119"></auchan:i18n></div>
                                        <div class="iconPut iq fl_left" style="width:13%;">
                                            <input type="text" style="width:60%" class="displyLvl mustInput" clean="1" setValueObjId="displyLvlName" acWidth="60px" id="displyLvl" name="displyLvl" value="<c:if test="${empty itemRealStoreSaleCtrl.displyLvl}">1</c:if><c:if test="${not empty itemRealStoreSaleCtrl.displyLvl}">${itemRealStoreSaleCtrl.displyLvl}</c:if>"/>
                                            <div class="ListWin" onclick="$(this).prev().focus();$(this).prev().click();"></div>
                                        </div>
                                        <input class="inputText iq Black displyLvlName" type="text" readonly="readonly" style="width:20%;" value="<c:forEach items="${displyLvlList2}" var="obj"><c:if test="${obj.code==itemRealStoreSaleCtrl.displyLvl || obj.code==1}">${obj.title}</c:if></c:forEach>"/>
                                    </div>
                                    <div style="height:120px;">
                                        <div class="tb50">
                                            <div class="ig">
                                                <div class="msg_txt" style="width:36%;"><auchan:i18n id="103001120"></auchan:i18n></div>
                                                <input class="w44 inputText count_text" name="width" maxlength="2" id="width" value="${itemRealStoreSaleCtrl.width}<c:if test="${empty itemRealStoreSaleCtrl.width}">1</c:if>" onchange="compareObj($('#minWidth'),$(this));caculateTiji($(this).parent().parent());"/>
                                            </div>
                                            <div class="ig">
                                                <div class="msg_txt" style="width:36%;"><auchan:i18n id="103001121"></auchan:i18n></div>
                                                <input class="w44 inputText count_text" name="layer" maxlength="2" id="layer" value="${itemRealStoreSaleCtrl.layer}<c:if test="${empty itemRealStoreSaleCtrl.layer}">1</c:if>" onchange="compareObj($('#minLayer'),$(this));caculateTiji($(this).parent().parent());"/>
                                            </div>
                                            <div class="ig">
                                                <div class="msg_txt" style="width:36%;"><auchan:i18n id="103001122"></auchan:i18n></div>
                                                <input class="w44 inputText count_text" name="depth" maxlength="2" id="depth" value="${itemRealStoreSaleCtrl.depth}<c:if test="${empty itemRealStoreSaleCtrl.depth}">1</c:if>" onchange="compareObj($('#minDepth'),$(this));caculateTiji($(this).parent().parent());"/>
                                            </div>
                                            <div class="ig">
                                                <div class="msg_txt" style="width:36%;"><auchan:i18n id="103001123"></auchan:i18n></div>
                                                <input class="w44 inputText count_text" readonly="readonly" id="tiji" value="<c:choose ><c:when test="${(empty itemRealStoreSaleCtrl.depth) or (empty itemRealStoreSaleCtrl.layer) or (empty itemRealStoreSaleCtrl.width)}">1</c:when><c:otherwise>${itemRealStoreSaleCtrl.depth*itemRealStoreSaleCtrl.layer*itemRealStoreSaleCtrl.width}</c:otherwise></c:choose>"/>
                                            </div>
                                        </div>
                                        <div class="tb49">
                                            <div class="ig">
                                                <div class="msg_txt" style="width:36%;"><auchan:i18n id="103001124"></auchan:i18n>(y)</div>
                                                <input class="w44 inputText count_text" name="minWidth" maxlength="2" id="minWidth" value="${itemRealStoreSaleCtrl.minWidth}<c:if test="${empty itemRealStoreSaleCtrl.minWidth}">1</c:if>" onchange="compareObj($('#minWidth'),$('#width'));caculateTiji($(this).parent().parent().prev());"/>
                                            </div>
                                            <div class="ig">
                                                <div class="msg_txt" style="width:36%;"><auchan:i18n id="103001125"></auchan:i18n>(x)</div>
                                                <input class="w44 inputText count_text" name="minLayer" maxlength="2" id="minLayer" value="${itemRealStoreSaleCtrl.minLayer}<c:if test="${empty itemRealStoreSaleCtrl.minLayer}">1</c:if>" onchange="compareObj($('#minLayer'),$('#layer'));caculateTiji($(this).parent().parent().prev());"/>
                                            </div>
                                            <div class="ig">
                                                <div class="msg_txt" style="width:36%;"><auchan:i18n id="103001126"></auchan:i18n>(z)</div>
                                                <input class="w44 inputText count_text" name="minDepth" maxlength="2" id="minDepth" value="${itemRealStoreSaleCtrl.minDepth}<c:if test="${empty itemRealStoreSaleCtrl.minDepth}">1</c:if>" onchange="compareObj($('#minDepth'),$(this).parent().parent().prev().find('#depth'));caculateTiji($(this).parent().parent().prev());"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div style="height:118px; margin-top:2px;" class="CM">
                                <div class="CM-bar"><div><auchan:i18n id="103001127"></auchan:i18n></div></div>
                                <div class="CM-div">
                                    <div class="ig"  style="margin-top:15px;">
                                        <div class="msg_txt"><auchan:i18n id="103001128"></auchan:i18n></div>
                                        <select class="w23 mustInput" name="railcard" id="railcard">
                                        	<c:forEach items="${railcardList}" var="railcard">
                                        	<option value="${railcard.code}" <c:if test="${railcard.code==itemRealStoreSaleCtrl.railcard || railcard.code==1}">selected="selected"</c:if>>${railcard.code}-${railcard.title}</option>
                                        	</c:forEach>
                                        </select>
                                        <span>&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001129"></auchan:i18n>&nbsp;</span>
                                        <input type="text" class="inputText w10 count_text" id="offShelfDays" maxlength="4" name="offShelfDays" value="${itemRealStoreSaleCtrl.offShelfDays}"/><span>&nbsp;天</span>
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt"><auchan:i18n id="103001130"></auchan:i18n></div>
                                        <input type="text" class="inputText w23" name="printSeq" maxlength="3" id="printSeq" value="${itemRealStoreSaleCtrl.printSeq}"/>
                                   		<span>&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001131"></auchan:i18n>&nbsp;</span>
                                        <input type="text" class="inputText w23" id="shelfKeepCond" maxlength="13" name="shelfKeepCond" value="${itemRealStoreSaleCtrl.shelfKeepCond}"/>
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt"><auchan:i18n id="103001132"></auchan:i18n></div>
                                        <input type="text" class="inputText w23 count_text" name="numRailcard" maxlength="2" id="numRailcard" value="${itemRealStoreSaleCtrl.numRailcard}"/>
                                    	<span>&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001133"></auchan:i18n>&nbsp;</span>
                                        <input type="text" class="inputText w23" id="stockKeepCond" maxlength="13" name="stockKeepCond" value="${itemRealStoreSaleCtrl.stockKeepCond}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tb50">
                            <div style="height:300px; margin-top:2px;" class="CM">
                                <div class="CM-bar"><div><auchan:i18n id="103001134"></auchan:i18n></div></div>
                                <div class="CM-div">
                                    <div class="ig"  style="margin-top:15px;">
                                        <div class="msg_txt"><auchan:i18n id="103001135"></auchan:i18n></div>
                                        <div style="float:left;width:360px;"><input type="text" readonly="readonly" class="inputText w95" maxlength="22" name="scaleName" id="scaleName" value="${itemRealStoreSaleCtrl.scaleName}"/></div>
                                    </div>
                                    <div style="height:60px;">
                                        <div class="msg_txt">
                                            <div><auchan:i18n id="103001136"></auchan:i18n></div>
                                        </div>
                                        <textarea class="w70 txtarea" onfocus="$(this).removeClass('errorInput');" rows="2" alt="长度不超过20个字符" title="长度不超过20个字符" title="长度不超过20个字符" id="scaleMemo" name="scaleMemo" style="font-family:Microsoft YaHei">${itemRealStoreSaleCtrl.scaleMemo}</textarea>
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt"><auchan:i18n id="103001137"></auchan:i18n></div>
                                        <select class="w20 mustInput" id="scaleUpdtSpInd" name="scaleUpdtSpInd">
                                       	<c:forEach items="${scaleUpdtSpIndList}" var="obj">
                                       	<option value="${obj.code}" <c:if test="${obj.code==itemRealStoreSaleCtrl.scaleUpdtSpInd}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
                                       	</c:forEach>
                                        </select>
                                        <span>&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001138"></auchan:i18n>&nbsp;</span>
                                        <select class="w20 mustInput" name="scaleLabelType" id="scaleLabelType">
                                       	<c:forEach items="${labelTypeList}" var="obj">
                                       	<option value="${obj.code}" <c:if test="${obj.code==itemRealStoreSaleCtrl.scaleLabelType}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
                                       	</c:forEach>
                                        </select>
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt"><auchan:i18n id="103001139"></auchan:i18n></div>
                                        <select class="w20 mustInput" name="dwnldToPackgMach" id="dwnldToPackgMach">
                                       	<c:forEach items="${dwnldToPackgMachList}" var="obj">
                                       	<option value="${obj.code}" <c:if test="${obj.code==itemRealStoreSaleCtrl.dwnldToPackgMach}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
                                       	</c:forEach>
                                        </select>
                                        <span>&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001140"></auchan:i18n>&nbsp;</span>
                                        <select class="w20 mustInput" id="qltyTraceType" name="qltyTraceType">
                                       	<c:forEach items="${traceTypeList}" var="obj">
                                       	<option value="${obj.code}" <c:if test="${obj.code==itemRealStoreSaleCtrl.qltyTraceType}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
                                       	</c:forEach>
                                        </select>
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt"><auchan:i18n id="103001141"></auchan:i18n></div>
                                        <input class="w20 inputText double_text_with_len" name="scalePeelWght" id="scalePeelWght" type="text" value="${itemRealStoreSaleCtrl.scalePeelWght}" preval="" intval="2" decval="2" />
                                        <span>&nbsp;g</span>
        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="height:140px;margin-top:2px;" class="CM">
                        <div class="CM-bar"><div><auchan:i18n id="103001109"></auchan:i18n></div></div>
                        <div class="CM-div">
                            <div class="zz_info">
                                <div class="zz_1">
                                    <span class="zz_11"><auchan:i18n id="103001110"></auchan:i18n></span>
                                    <span class="zz_15"><auchan:i18n id="103001111"></auchan:i18n></span>
                                    <span class="zz_15"><auchan:i18n id="103001112"></auchan:i18n></span>
                                    <span class="zz_14"><auchan:i18n id="103001113"></auchan:i18n></span>
                                    <span class="zz_15"><auchan:i18n id="103001114"></auchan:i18n></span>
                                </div>
                                <div class="zz_2" id="item_show_licnce_list" >
                                <!-- 这里是证件展示 -->
                                </div>
                                <div class="ig" style="margin-left:10px;">
                                        
                                            <div class="ListWin"></div>
                                       
                                </div>
                            </div>
                        </div>
                    </div>
</form>

<div id="" style="display:none;">

</div>

<script type="text/javascript">
${displyLvlList};
$(function(){
	$('.itemNo').val($('#itemNo').val());
	$('.itemName').val($('#itemName').val());
	if(viewFlag!='1'){
		loadSelectDiv($('.displyLvl'),displyLvlList,1);
	}
	else{
		$('.ListWin').attr('onclick','');
	}
	inputToInputIntNumber();
	inputToInputDoubleNumberAndChkLen($('#item_create_4'));
	nullInputCheck();
	<c:if test="${not empty itemRealStoreSaleCtrl}">
	item_create[4] = $('#item_create_4').serialize();
	</c:if>
	<c:if test="${empty itemRealStoreSaleCtrl}">
	if($('#barcodeLabel').val()!=0){
   		$('#scaleName').val($('#itemName').val());
   	}
	if($('#offShelfDays').val()==''){
		setOffShelfDays();
	}
	$('#shelfKeepCond').val($('#storgCond').val());
	$('#stockKeepCond').val($('#storgCond').val());
	</c:if>
});

function setOffShelfDays(){
	$.post(ctx + "/item/create/getSpeclGrpCtrl?catlgId=" + $('#zhongfenleiInput2').val(), function(data) {
		var offShelfDaysOptn = data.midGrpCtrl.offShelfDaysOptn;
		var offShelfDays = data.midGrpCtrl.offShelfDays;
		var stdShelfLifeDays = $('#stdShelfLifeDays').val();
		if($.trim(offShelfDaysOptn)==''){
			$('#offShelfDays').val('');
			return false;
		}
		switch(offShelfDaysOptn){
			case 0:
				$('#offShelfDays').val(0);
				break;
			case 1:
				if(stdShelfLifeDays!=''){
					$('#offShelfDays').val(stdShelfLifeDays/5);
				}
				break;
			case 2:
				if(stdShelfLifeDays!=''){
					$('#offShelfDays').val(stdShelfLifeDays/3);
				}
				break;	
			case 9:
				if(offShelfDays!=''){
					$('#offShelfDays').val(offShelfDays);
				}
				break;
		}
	});
}
</script>