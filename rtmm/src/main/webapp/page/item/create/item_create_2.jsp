<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<form action="" id="item_create_2" url="/item/create/doCreateBarcode">
	<!-- <div class="CInfo">
		<span class="sp_store5">创建商品基本信息</span> <span
			class="sp_store4  sp_store_on">创建商品条码信息</span> <span
			class="sp_store3">创建商品规格信息</span> <span class="sp_store2">创建商品陈列信息</span>
		<span class="sp_store1">创建商品厂商门店信息</span>
	</div> -->
<div class="CInfo">
	<span class="sp_store5"><auchan:i18n id="103001067"></auchan:i18n></span> <span
		class="sp_store4 sp_store_on"><auchan:i18n id="103001068"></auchan:i18n></span> <span class="sp_store3"><auchan:i18n id="103001069"></auchan:i18n></span>
	<span class="sp_store2"><auchan:i18n id="103001070"></auchan:i18n></span> <span class="sp_store1"><auchan:i18n id="103001071"></auchan:i18n></span>
</div>

	<div style="height: 60px;" class="CM">
		<div class="CM-bar">
			<div><auchan:i18n id="103001003"></auchan:i18n></div>
		</div>
		<div class="CM-div">
			<div class="hh_item">
				<div class="icol_text w7">
					<span><auchan:i18n id="103001003"></auchan:i18n></span>
				</div>
				<div class="iconPut iq" style="width: 13%;">
					<input style="width: 83%" type="text" name="itemNo" class="itemNo" readonly="readonly"/>
					<div class="ListWin"></div>
				</div>
				<input class="inputText iq Black itemName" style="width: 20%;" readonly="readonly"
					type="text" name="itemName" /> <input class="divHide" type="checkbox"
					style="margin-left: 10px; vertical-align: middle;" onclick="handler_barcode_click($(this),$(this).attr('checked'),$('#itemNo').val(),$('#itemType').val(),$('#barcodeLabel').val(),$('#projLabel').val());" /> <span  class="divHide"><auchan:i18n id="103001084"></auchan:i18n></span>
			</div>
		</div>
	</div>
	<div style="height: 470px; margin-top: 2px;" class="CM">
		<div class="CM-bar">
			<div><auchan:i18n id="103001083"></auchan:i18n></div>
		</div>
		<div class="CM-div">
			<div class="txm_info">
				<div class="txm_title">
					<span style="margin-left: 120px;">*<auchan:i18n id="103001004"></auchan:i18n></span><span
						style="margin-left: 110px;"><auchan:i18n id="103001062"></auchan:i18n></span> <span
						style="margin-left: 50px;"><auchan:i18n id="103001063"></auchan:i18n></span>
				</div>
				<div class="sp_tb">
					<c:if test="${not empty barcodeList}">
						<c:forEach items="${barcodeList}" var="obj">
							<div class="ig">
								<input type="checkbox" class="divHide" onclick="resetCheckAll($(this).parent().parent())"/> <input type="text"
									class="w45 inputText count_text mustInput chbox-mgl" maxlength="14"
									onblur="validate_barcode($(this));updateAutoBarcode();" name="barcode"
									value="${obj.barcode}" onChange="updateAutoBarcode();" /> <input type="text"
									class="w20 inputText Black" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${obj.creatDate}"/>"/>
								<input type="text" class="w20 inputText Black"  readonly="readonly"
									value="${obj.creatBy}" />
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${empty barcodeList}">
						<div class="ig">
							<input type="checkbox"  onclick="resetCheckAll($(this).parent().parent())"/> <input type="text"
								class="w45 inputText count_text mustInput" maxlength="14"
								onblur="validate_barcode($(this));updateAutoBarcode();" name="barcode"
								value="${obj.barcode}" onChange="updateAutoBarcode();" /> <input type="text"
								class="w20 inputText Black createDate"
								value="" readonly="readonly"/> <input type="text"
								class="w20 inputText Black createBy" value="" readonly="readonly"/>
						</div>
					</c:if>
				</div>
				<div class="ig divHide">
					<input type="checkbox" class="sp_icon1 checkAll" id="selectallbarcode"
						onclick="selectCheckbox($(this).parent().prev(),$(this).attr('checked'));" />
					<div class="Icon-size2 Tools10 sp_icon2"
						onclick="deleteCheckbox($(this).parent().prev());"></div>
					<div class="Icon-size2 Line-1 sp_icon3 "></div>
					<div class="Icon-size2 Tools11 sp_icon4"
						onclick="if($(this).parent().prev().find('.ig').size()>14){return false;}$(this).parent().prev().append($('#itemBarDiv').html());$(this).parent().prev().find('.ig:last input[name=\'barcode\']').addClass('mustInput');nullInputCheck();inputToInputIntNumber();"></div>
				</div>
			</div>
		</div>
	</div>


</form>

<div id="itemBarDiv" style="display: none;">
	<div class="ig">
		<input type="checkbox"  onclick="resetCheckAll($(this).parent().parent())"/> <input type="text"
			class="w45 inputText count_text" maxlength="14" name="barcode"
			onblur="validate_barcode($(this));updateAutoBarcode();"  onChange="updateAutoBarcode();"/> <input type="text"
			class="w20 inputText Black createDate"  readonly="readonly" value=""/> <input type="text"
			class="w20 inputText Black createBy" readonly="readonly"  value="" />
	</div>
</div>

<script type="text/javascript">
$(document).ready(function() {
		inputToInputIntNumber();
		nullInputCheck();
		setDefaultCreate();
		$('.itemNo').val($('#itemNo').val());
		$('.itemName').val($('#itemName').val());

		<c:if test="${not empty barcodeList}">
		item_create[2] = $('#item_create_2').serialize();
		</c:if>
/*  		
 var itemStoreCode= gen_ean13_barcode($('#itemNo').val(),$('#itemType').val(),$('#barcodeLabel').attr('barcodeLabel'),$('#projLabel').val());
		var eanBarcodeEle = $('#item_create_2').find('input[name="barcode"][value="'+itemStoreCode+'"]');
		if(eanBarcodeEle.size()>0){
			$('#item_create_2 .hh_item :checkbox').attr('checked','checked');
			var itemStoreCode2= gen_ean13_barcode($('#itemNo').val(),$('#itemType').val(),$('#barcodeLabel').val(),$('#projLabel').val());
			$(eanBarcodeEle[0]).val(itemStoreCode2);
		}  */
	});

	function setDefaultCreate() {
		var curdate = new Date().format('yyyy-MM-dd');
 		$('.createBy').attr('value',mycurrentstaff);
		$('.createDate').attr('value',curdate);  
/* 		
 		barlist = ${barcodeList};
		if (barlist.length == 0) {
			$('#sp_tb').find('.ig:first input:eq(2)').val(mycurrentstaff);
			$('#sp_tb').find('.ig:first input:eq(3)').val(curdate); 
		} 
 		$('#itemBarDiv').find('.ig:first').children().eq(2).attr('value',mycurrentstaff);
		$('#itemBarDiv').find('.ig:first').children().eq(3).attr('value',curdate);  */  
	}
</script>