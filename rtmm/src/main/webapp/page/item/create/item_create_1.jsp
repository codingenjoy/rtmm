<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css" rel="Stylesheet" />

<style type="text/css">
.i_input2 {
	width: 15%;
}

/* .Rect2Warn{
float: right;
margin-right: 20px;
width: 20px;
cursor: pointer;
background: url("${ctx}/shared/themes/${theme}/images/icon0402.png") no-repeat scroll -556px -28px rgba(0, 0, 0, 0);
} */


<%-- .autocomplete {
    background: url("${ctx}/shared/themes/${theme}/images/easyUI/combo_arrow.png") no-repeat scroll right center rgba(0, 0, 0, 0);
} --%>
</style>

<!-- 图片start -->
<script type="text/javascript">
var createItemsUploadPhotos = new Array();//当前商品下所有的证件图片信息
var itemNumber=0; //当前图片的次序信息

//点击查看图片信息
$("#lookItemPic").unbind("click").bind("click",function(){
if(createItemsUploadPhotos.length>0){
	itemNumber=0;
$("#showItem_p").css({ "top": 0, "left": 0, "display": "block", "width": screen.width, "height": "690px" });
loadCreateUploadImgInfos(createItemsUploadPhotos[0]);
	}else{
		top.jAlert('warning', '没有检测到图片，请增加图片', '提示消息');   
}
});

//关闭事件(查看图片窗口)
$("#closeLookPic").live("click", function () {
    $("#showItem_p").css("display", "none");
});
//点击编辑图片信息
$("#editItemPic").unbind("click").bind("click",function(){
	  var ht = $(document).height();
      var wd = $(document).width();
      $("#editItemPicDiv").css({"height":ht,"width":wd,"display":"block"});
      if($('#itemNo').val()==''){
    	  $.post(ctx + '/uploadItemPicAction/toUploadPicAndCreateItem',null,function(data){
				$("#editItemPicInfos").html(data);
			},'html');      
      }
      else{   
    	  $.post(ctx + '/uploadItemPicAction/toUploadItemPic',{"itemNo":$('#itemNo').val()},function(data){
				$("#editItemPicInfos").html(data);
			},'html');         
          }
});
//关闭事件(编辑图片窗口)
$("#closeItemEditPic").unbind("click").bind("click",function(){
	$("#editItemPicInfos").empty();//清空增加图片页面
	$("#editItemPicDiv").hide();//当前层隐藏	

   //添加信息到缓存中
   if($('#itemNo').val()==''){
	   addSessionCacheItemPicInfos("itemcreate");
   }
   else{
	createItemsUploadPhotos=new Array();
	loadImgInfos($('#itemNo').val());
  }
	
  if(createItemsUploadPhotos.length>0){
   $("#itemBaseInfoImg").empty();
   $("#itemBaseInfoImg").attr("src", createItemsUploadPhotos[0]);
	 }
});



$("#lookItem_prev_brower").live("mouseover", function () {
    $(this).addClass("prev_brower_bg");
});
$("#lookItem_prev_brower").live("mouseout", function () {
    $(this).removeClass("prev_brower_bg");
});
$("#lookItem_next_brower").live("mouseover", function () {
    $(this).addClass("next_brower_bg");
});
$("#lookItem_next_brower").live("mouseout", function () {
    $(this).removeClass("next_brower_bg");
});

$("#lookItem_next_brower").unbind("click").bind("click", function () {
	if(typeof(createItemsUploadPhotos[itemNumber+1])!='undefined' || createItemsUploadPhotos[itemNumber+1]!=null){
		itemNumber=itemNumber+1;
		loadCreateUploadImgInfos(createItemsUploadPhotos[itemNumber]);
    	}else{
            $("#lookItem_pp3").text("已经到最后一张了");
		    	}    
});

$("#lookItem_prev_brower").unbind("click").bind("click", function () {
	if(typeof(createItemsUploadPhotos[itemNumber-1])!='undefined' || createItemsUploadPhotos[itemNumber-1]!=null){
		itemNumber=itemNumber-1;
		loadCreateUploadImgInfos(createItemsUploadPhotos[itemNumber]);
    	}else{
            $("#lookItem_pp3").text("已经到第一张了");
		    	}    
});

//加载图片到层中
function loadCreateUploadImgInfos(key){
	 $("#lookItem_pp2").empty();
	  $("#lookItem_pp3").empty();
    $("#lookItem_pp2").attr("src",key);
    }




//关闭事件，当窗口关闭时，把数据放到sessionCache中（新增函数）
  function addSessionCacheItemPicInfos(keyType){
      if(createItemsUploadPhotos.length>0){
         var  infos= "";
            for(var i=0; i< createItemsUploadPhotos.length;i++){
                  if(i<createItemsUploadPhotos.length-1){
                 	 infos=infos+createItemsUploadPhotos[i]+",";
                      }else{                       	 
                     	 infos=infos+createItemsUploadPhotos[i];
                          }
                }
          
 	 $.ajax({
				url :'${ctx}/upload/addPicToSessionCache?tt='
						+ new Date().getTime(),
						data : {type:keyType,
							   cacheInfo:infos
						     },
				type : 'POST',
				success : function(response) {
						
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					top.jAlert('error', '网络超时!请稍后重试', '提示消息');
				}
			});
             }
 
      }

//如果数据已经存在，则加入集合管理
  $(function(){
  //添加信息到缓存中
  <c:if test='${item ne null}'>

  loadImgInfos("${item.itemNo}");
  
	</c:if>

	<c:if test="${empty item}">
 	$('.majorSupNo').each(function(){
 		$(this).keydown(function (e) {
            if (e.keyCode == 13) {
            	getMajorSupplier($(this));
            }
        });
 	});
 	</c:if>
 	
 	$('.brandId').each(function(){
 		$(this).keydown(function (e) {
            if (e.keyCode == 13) {
            	getItemBrandById($(this));
            }
        });
 	}); 
	  });

//根据货号查看信息
function loadImgInfos(itemId){
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
				    	   createItemsUploadPhotos.push(link);                      	
					       });
				       loadFristImgInfo();					       
				}				
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});
	
}

//加载第一张图片到默认图片中
function loadFristImgInfo(){

	if(createItemsUploadPhotos.length>0){
          $("#itemBaseInfoImg").attr("src",createItemsUploadPhotos[0]);
	}else{
		  $("#itemBaseInfoImg").attr("src","${ctx}/shared/themes/theme1/images/defaultImg.png");
		}
	
}

  
</script>
<!-- 1.这里加载遮罩层信息 ，图片浏览遮罩层-->
  <div id="showItem_p"  class="_p">
        <div id="lookItem_p_brower" style="border:2px solid #3f9673;" class="p_brower">
      <div class="zwindow_titleBar" style="height: 40px;position:relative;"><div class="zwindow_titleButtonBar"><div id="closeLookPic" class="zwindow_action_button zwindow_close"></div></div><div class="zwindow_title titleText">浏览图片信息</div></div>
        
            <div id="lookItem_prev_brower" class="prev_brower"></div>
            <div id="lookItem_pp" class="pp">
                <img src="" id="lookItem_pp2" alt="" class="pp2"/>
                <div id="lookItem_pp3" class="pp3"></div>
            </div>
            <div id="lookItem_next_brower" class="next_brower"></div>
        </div>
    </div>

<!-- 2.图片编辑遮罩层 -->
   <div id="editItemPicDiv" class='picture_layer'>
        <div style='width:1032px;height:500px;background:#fff;overflow:hidden;margin:60px auto;border:2px solid #3f9673;'>
				<div class="zwindow_titleBar" style="height: 40px;position:relative;"><div class="zwindow_titleButtonBar"><div id="closeItemEditPic" class="zwindow_action_button zwindow_close"></div></div><div class="zwindow_title titleText">新增图片信息</div></div>
				<div style="height:460px;overflow-x:hidden;overflow:hidden;" id="editItemPicInfos">

            </div>
                                               
        </div></div>
	




<div class="CInfo">
	<span class="sp_store5 sp_store_on"><auchan:i18n id="103001067"></auchan:i18n></span> <span
		class="sp_store4"><auchan:i18n id="103001068"></auchan:i18n></span> <span class="sp_store3"><auchan:i18n id="103001069"></auchan:i18n></span>
	<span class="sp_store2"><auchan:i18n id="103001070"></auchan:i18n></span> <span class="sp_store1"><auchan:i18n id="103001071"></auchan:i18n></span>
</div>
<form action="" id="item_create_1" url="/item/create/doCreateItem"
	onsubmit="return false;">
	<div class="CM" style="height: 270px;">
		<div class="CM-bar">
			<div><auchan:i18n id="103001072"></auchan:i18n></div>
		</div>
		<div class="CM-div">
			<div class="ic">
				<div class="pic_1">
				<!-- 图片信息 -->
				<img width="111" height="111" id="itemBaseInfoImg" src="${ctx}/shared/themes/theme1/images/defaultImg.png">
						<div class="pic_21">
							<div class="look_pic edit_div" id="lookItemPic"></div>
							<c:if test="${1 ne view}"><div class="edit_pic edit_div" id="editItemPic"></div></c:if>
						</div>					
				</div>
				<div class="item11_1">
					<!--1-->
					<div class="icol_text w10">
						<span><auchan:i18n id="103001003"></auchan:i18n></span>
					</div>
					<div class="i_input1">
						<div class=" ib">
							<input type="text" class="w100 inputText Black" name="itemNo" id="itemNo" readonly="readonly" value="${item.itemNo}" tabindex="1">
						</div>
					</div>
					<div class="icol_text w10">
						<span>*<auchan:i18n id="103001024"></auchan:i18n></span>
					</div>
					<div class="i_input2">
						<select class="w80 mustInput" name="orignCtrl" tabindex="13">
							<c:if test="${view==1}">
							<c:forEach items="${itemBasicOriginCtrl}" var="obj">
							<c:if test="${(item.orignCtrl!=null && obj.code==item.orignCtrl)|| (item.orignCtrl==null && obj.code==1)}">
							<option value="${obj.code}" selected="selected">${obj.code}-${obj.title}</option>
							</c:if>
							</c:forEach>
							</c:if>
							<c:if test="${view!=1}">
							<option value=""><auchan:i18n id="100000009"></auchan:i18n></option>
							<c:forEach items="${itemBasicOriginCtrl}" var="obj">
							<option value="${obj.code}"<c:if test="${(item.orignCtrl!=null && obj.code==item.orignCtrl)|| (item.orignCtrl==null && obj.code==1)}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
							</c:forEach>
							</c:if>
						</select>
					</div>
					<div class="icol_text w10">
						<span>*<auchan:i18n id="103001017"></auchan:i18n></span>
					</div>
					<div class="i_input3">
						<%-- <auchan:select mdgroup="ITEM_BASIC_PROJ_LABEL"
							_class="select1 w50 mustInput" 
							dataBind="value:proj_label,validationElement:proj_label" name="projLabel" id="projLabel" value="${item.projLabel}"/> --%>
						<select class="select1 w50 mustInput" name="projLabel" tabindex="14" id="projLabel">
							<c:if test="${view==1}">
							<c:forEach items="${itemBasicProjLabel}" var="obj">
							<c:if test="${(item.projLabel!=null && obj.code==item.projLabel)|| (item.projLabel==null && obj.code==0)}">
							<option value="${obj.code}" selected="selected">${obj.code}-${obj.title}</option>
							</c:if>
							</c:forEach>
							</c:if>
							<c:if test="${view!=1}">
							<option value=""><auchan:i18n id="100000009"></auchan:i18n></option>
							<c:forEach items="${itemBasicProjLabel}" var="obj">
							<option value="${obj.code}"<c:if test="${(item.projLabel!=null && obj.code==item.projLabel)|| (item.projLabel==null && obj.code==0)}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
							</c:forEach>
							</c:if>
						</select>
					</div>
					<!--1-->
					<div class="icol_text w10">
						<span>*<auchan:i18n id="103001005"></auchan:i18n></span>
					</div>
					<div class="i_input1">
						<input type="text" class="inputText w90 mustInput" id="itemName" name="itemName" maxlength="30" value="${item.itemName}" tabindex="2">
					</div>
					<div class="icol_text w10">
						<span>*<auchan:i18n id="103001016"></auchan:i18n></span>
					</div>
					<div class="i_input2">
						<select class="w80 mustInput" id="buyMethd" name="buyMethd" onchange="$('#itemType').empty();$('#prcssType').empty();$('#itemPack').empty();getNextMetaData();if($(this).val()=='3'){$('#startDate').removeAttr('disabled');$('#startDate').css('background-color', '#fff');$('#endDate').removeAttr('disabled');$('#endDate').css('background-color', '#fff');}" tabindex="22">
						<c:if test="${view==1}">
							<c:forEach items="${buyMethdList}" var="obj">
							<c:if test="${obj.code==item.buyMethd}">
							<option value="${obj.code}" selected="selected">${obj.code}-${obj.title}</option>
							</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${view!=1}">
							<option value=""><auchan:i18n id="100000009"></auchan:i18n></option>
							<c:forEach items="${buyMethdList}" var="obj">
							<option value="${obj.code}"<c:if test="${obj.code==item.buyMethd}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
							</c:forEach>
						</c:if>
						</select>
					</div>
					<div class="icol_text w10">
						<span>*<auchan:i18n id="103001018"></auchan:i18n></span>
					</div>
					<div class="i_input3">
						<select id="itemType" name="itemType" class="w50 mustInput" onchange="$('#prcssType').empty();$('#itemPack').empty();getNextMetaData();" tabindex="23">
						<c:if test="${view==1}">
							<c:forEach items="${itemTypeList}" var="obj">
							<c:if test="${obj.code==item.itemType}">
							<option value="${obj.code}" selected="selected">${obj.code}-${obj.title}</option>
							</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${view!=1}">
							<option value=""><auchan:i18n id="100000009"></auchan:i18n></option>
							<c:forEach items="${itemTypeList}" var="obj">
							<option value="${obj.code}"<c:if test="${obj.code==item.itemType}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
							</c:forEach>
						</c:if>
						</select>
					</div>
					<!--1-->
					<div class="icol_text w10">
						<span><auchan:i18n id="103001006"></auchan:i18n></span>
					</div>
					<div class="i_input1">
						<input type="text" class="inputText w90" name="itemEnName" maxlength="60"
							id="itemEnName" value="${item.itemEnName}" tabindex="3">
					</div>
					<div class="icol_text w10">
						<span>*<auchan:i18n id="103001019"></auchan:i18n></span>
					</div>
					<div class="i_input2">
						<%--<auchan:select mdgroup="ITEM_BASIC_BUY_METHD"
							_class="select1 w50" 
							dataBind="value:buy_method,validationElement:buy_method"/> --%>
						<select id="prcssType" name="prcssType" onchange="$('#itemPack').empty();getNextMetaData();" class="w90 mustInput" tabindex="24">
							<c:if test="${view==1}">
							<c:forEach items="${prcssTypeList}" var="obj">
							<c:if test="${obj.code==item.prcssType}">
							<option value="${obj.code}" selected="selected">${obj.code}-${obj.title}</option>
							</c:if>
							</c:forEach>
							</c:if>
							<c:if test="${view!=1}">
							<option value=""><auchan:i18n id="100000009"></auchan:i18n></option>
							<c:forEach items="${prcssTypeList}" var="obj">
							<option value="${obj.code}"<c:if test="${obj.code==item.prcssType}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
							</c:forEach>
							</c:if>
						</select>
					</div>
					<div class="icol_text w10">
						<span>*<auchan:i18n id="103001020"></auchan:i18n></span>
					</div>
					<div class="i_input3"><input type="hidden" id="speclGrpCtrl" name="speclGrpCtrl" value="${item.speclGrpCtrl}">
					<select id="origCtrlList" style="display: none;">
					<c:forEach var="obj" items="${itemBasicSpeclGrpCtrlList}">
						<option value="${obj.code}">${obj.code}-${obj.title}</option>
					</c:forEach>
					</select>
						<!-- <auchan:select mdgroup="ITEM_BASIC_BUY_PERD"
							_class="select1 w50" 
							dataBind="value:buy_pred,validationElement:buy_pred" name="buyPerd"/> -->
						<select id="itemPack" name="itemPack" class="select1 w50 mustInput" tabindex="25">
							<c:if test="${view==1}">
							<c:forEach items="${itemPackList}" var="obj">
							<c:if test="${obj.code==item.itemPack}">
							<option value="${obj.code}" selected="selected">${obj.code}-${obj.title}</option>
							</c:if>
							</c:forEach>
							</c:if>
							<c:if test="${view!=1}">
							<option value=""><auchan:i18n id="100000009"></auchan:i18n></option>
							<c:forEach items="${itemPackList}" var="obj">
							<option value="${obj.code}"<c:if test="${obj.code==item.itemPack}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
							</c:forEach>
							</c:if>
						</select>
					</div>
					<!--1-->
					<div class="icol_text w10">
						<span>*<auchan:i18n id="103001007"></auchan:i18n></span>
					</div>
					<div class="i_input1">
						<div class="iconPut iq">
							<input type="text" style="width: 71%" class="mustInput majorSupNo" name="majorSupNo" id="majorSupNo" tabindex="4" value="${item.majorSupNo}"  <c:if test="${empty item.majorSupNo}">onblur="if($(this).attr('preval2')!=$(this).val()){getMajorSupplier($(this));}"</c:if><c:if test="${not empty item.majorSupNo}"> readonly="readonly"</c:if> preval2=""/>
							<div class="ListWin cantEdit" onclick="<c:if test="${empty item.majorSupNo}">$.ajaxSetup({async:false});openSupWindow();$('#popupWin:visible .Panel_top span').text('选择主厂商');$.ajaxSetup({async:true});</c:if>" ></div>
						</div>
						<input type="text" class="inputText fl_left w58 Black cantEdit" id="supName" tabindex="5" value="${item.comName}" readonly="readonly"/>
					</div>
					<div class="icol_text w10">
						<span>*<auchan:i18n id="103001021"></auchan:i18n></span>
					</div>
					<div class="i_input2">
						<select name="buyPerd" id="buyPerd" class="w80 mustInput" onchange="setBuyPerdParameter($(this).val());" tabindex="26">
							<c:if test="${view==1}">
							<c:forEach items="${itemBasicBuyPerd}" var="obj">
							<c:if test="${item.buyPerd==obj.code}">
							<option value="${obj.code}" selected="selected">${obj.code}-${obj.title}</option>
							</c:if>
							</c:forEach>
							</c:if>
							<c:if test="${view!=1}">
							<option value=""><auchan:i18n id="100000009"></auchan:i18n></option>
							<c:forEach items="${itemBasicBuyPerd}" var="obj">
							<option value="${obj.code}"<c:if test="${item.buyPerd==obj.code}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
							</c:forEach>
							</c:if>
						</select>
					</div>
					<div class="icol_text w10">
						<span>*<auchan:i18n id="103001025"></auchan:i18n></span>
					</div>
					<div class="i_input3">
						<select name="barcodeLabel" id="barcodeLabel" class="w80 mustInput" tabindex="27" barcodeLabel="item.barcodeLabel">
							<c:if test="${view==1}">
							<c:forEach items="${itemBasicBarcodeLabel}" var="obj">
							<c:if test="${item.barcodeLabel==obj.code}">
							<option value="${obj.code}" selected="selected">${obj.code}-${obj.title}</option>
							</c:if>
							</c:forEach>
							</c:if>
							<c:if test="${view!=1}">
							<option value=""><auchan:i18n id="100000009"></auchan:i18n></option>
							<c:forEach items="${itemBasicBarcodeLabel}" var="obj">
							<option value="${obj.code}"<c:if test="${item.barcodeLabel==obj.code}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
							</c:forEach>
							</c:if>
						</select>
					</div>

				</div>
			</div>
			<div class="ic">
				<div class="ig">
					<span class="icol_text2"><auchan:i18n id="103001008"></auchan:i18n></span>
					<div class="ia">
						<input type="hidden" name="status" value="<c:if test="${not empty status}">${status}</c:if><c:if test="${empty status}">${itemStatusList[0].code}</c:if>">
						<select class="select1 w100" disabled="disabled">
							<c:forEach items="${itemStatusList}" var="itemStatus">
								<option value="${itemStatus.code}">${itemStatus.code}-${itemStatus.title}</option>
							</c:forEach>
						</select>
					</div>
					<span class="icol_text2"><auchan:i18n id="103001009"></auchan:i18n></span>
					<div class="iconPut ih">
						<input type="text" style="width: 71%" class="brandId" id="brandId" name="brandId" value="${item.brandId}" tabindex="6" onblur="if($(this).attr('preval2')!=$(this).val()){getItemBrandById($(this));}" preval2=""/>
						<div class="ListWin" onclick="openBrandWindow()"></div>
					</div>
					<input type="text" class="inputText ik Black" id="brandName" value="${item.brandName}"  readonly="readonly">
					<div class="icol_text w11">
						<span><auchan:i18n id="103001022"></auchan:i18n></span>
					</div>
					<div style="width: 5%" class="iconPut ih">
						<input type="text" class="w60 mustInput" name="seTopicIds" id="seTopicIds" readonly="readonly" tabindex="28" value="${item.seTopicIds}">
						<div class="ListWin" onclick="initSeTopicInfo();openSEWindow()"></div>
					</div>
<input type="hidden" id="seTopicIds1">
<input type="hidden" id="seTopicName1">
					<input type="text" style="width: 7%;" class="inputText ik mustInput" id="seTopicName" value="${item.seTopicNames}" readonly="readonly" tabindex="29">
					<span class="fl_left">&nbsp;&nbsp;<auchan:i18n id="103001023"></auchan:i18n>&nbsp;&nbsp;</span> <input
						type="text" class="Wdate fl_left mustInput" style="width: 90px;" type="text"
						id="startDate"  tabindex="30" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${item.validStartDate}"/>"
						onClick="WdatePicker({onpicked:function(){if(this.value>$dp.$('endDate').value){$dp.$('endDate').value='';$dp.$('endDate').focus();}},isShowClear:false,readOnly:true/*,minDate:'%y-%M-\#{%d+1}'*/})"
						readonly="readonly" name="validStartDate"> <span class="fl_left">-</span> <input
						type="text" class="Wdate fl_left mustInput" style="width: 90px;" type="text"
						id="endDate"
						onClick="WdatePicker({onpicked:function(){if(this.value<$dp.$('startDate').value){$dp.$('startDate').value='';$dp.$('startDate').focus();}},isShowClear:false,readOnly:true})"
						readonly="readonly" name="validEndDate" tabindex="31" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${item.validEndDate}"/>">
				</div>
				<div class="io">
					<div class="ig">
						<span class="icol_text2 w17">*<auchan:i18n id="103001010"></auchan:i18n></span>
							<input type="hidden" id="chubieInput2" value="${item.divNo}">
							<input id="chubieInput" class="inputText w65 mustInput cantEdit" acCode="code" acTitle="name" 
							setValueObjId="chubieInput2" nextInputObjId="kebieInput" clean="1" readonly="readonly" value="${item.divName}" tabindex="8"/>
							<!-- <select class="w65" id="chubieInput">
								<option value="">请选择处别</option>
							</select> -->
						<%--<div class="iconPut iq">
							 <input type="text" readonly="readonly" prevalue="" class="w60 longText" onblur="var preval=$(this).attr('prevalue');if(preval!=''){$(this).val(preval)}"
								id="chubieInput">
							<div class="ListWin"  
								onclick="$(this).prev().val('');$(this).prev().focus();$(this).prev().click();"></div> 
						</div>
						<input class="longText inputText w35" readonly="readonly"
							id="chubieInput2">--%>
					</div>
					<div class="ig">
						<span class="icol_text2 w17">*<auchan:i18n id="103001011"></auchan:i18n></span>
						<!-- <select class="w65" id="kebieInput" name="">
								<option value="">请选择</option>
							</select> -->
							<input type="hidden" id="kebieInput2" value="${item.secNo}">
						<input id="kebieInput" class="inputText w65 mustInput cantEdit" readonly="readonly" acWidth="150px" acCode="catlgId" acTitle="catlgName" nextInputObjId="dafenleiInput"
						 currUrl="/item/create/getSupSecList?supNo=${item.majorSupNo}&divisionId=" setValueObjId="kebieInput2" clean="1" tabindex="9" value="${item.secName}"/>
						<%--<div class="iconPut iq">
							 <input type="text" readonly="readonly" prevalue="" class="w60 longText"
								id="kebieInput">
							<div class="ListWin"
								onclick="$(this).prev().focus();$(this).prev().click();"></div>
						</div>
						<input class="longText inputText w35" readonly="readonly"
							id="kebieInput2">--%>
					</div>
					<div class="ig">
						<span class="icol_text2 w17"><auchan:i18n id="103001015"></auchan:i18n></span>
						
						<div class="iconPut iq" style="width:65%">
						<c:if test="${empty itemClusterItems.clstrId}">
							<input type="text" readonly="readonly" class="w85 cantEdit" id="clstrdisplay" tabindex="4" value=""/>
						</c:if> 
						<c:if test="${not empty itemClusterItems.clstrId}">
						<input type="text" readonly="readonly" class="w85  Black" id="clstrdisplay" tabindex="4" value="${itemClusterItems.clstrId}-${itemClusterItems.clstrName}"/>
						</c:if> 
							<div class="ListWin cantEdit" onclick="$.ajaxSetup({async:false});if($.trim($('#kebieInput2').val())==''){top.jAlert('warning','请选择课别!', '消息提示');return false;}openClusterWindow();$('#popupWin:visible .Panel_top span').text('选择系列');$.ajaxSetup({async:true});" ></div>
						</div>
						<input type="hidden"  id="clstrId" name="clstrId" value="${itemClusterItems.clstrId}" />
						<input type="hidden"  id="clstrType" value="${itemClusterItems.clstrType}" />
						<input type="hidden"  id="batchPriceChngInd" value="${itemClusterItems.batchPriceChngInd}" />						
					</div>
					<!-- <div class="ig">
						<span class="icol_text2 w17">群组</span>
						<div class="iconPut iq">
							<input type="text" class="w60 longText">
							<div class="ListWin"></div>
						</div>
						<input class="longText inputText w35">
					</div> -->
				</div>
				<div class="io2">
					<div class="ig">
						<span class="icol_text2">*<auchan:i18n id="103001012"></auchan:i18n></span>
						<!-- <select class="w60" id="dafenleiInput">
								<option value="">请选择</option>
							</select> -->
							
							<input type="hidden" id="dafenleiInput2" value="${item.grpId}">
						<input id="dafenleiInput" tagNameTitle2="当前课别下无大分类" class="inputText w62 mustInput cantEdit" readonly="readonly" acCode="code" acTitle="name" nextInputObjId="zhongfenleiInput"
						 currUrl="/item/create/getCatalogAction?parentId=" setValueObjId="dafenleiInput2" clean="1" tabindex="10" value="${item.grpName}"/>
					<%--	<div class="iconPut iq">
							<input type="text" value="" readonly="readonly" select="select"
								id="dafenleiInput" class="w60 longText">
							<div class="ListWin"
								onclick="$(this).prev().focus();$(this).prev().click();"></div>
						</div>
						<input type="text" value="" id="dafenleiInput2"
							readonly="readonly" class="longText inputText w35"> --%>
					</div>
					<div class="ig">
						<span class="icol_text2">*<auchan:i18n id="103001013"></auchan:i18n></span>
						<!-- <select class="w60" id="zhongfenleiInput" onchange="getSpeclGrpCtrl($(this).val());">
								<option value="">请选择</option>
							</select> -->
						
						<input type="hidden" id="zhongfenleiInput2" value="${item.midgrpId}">
						<input id="zhongfenleiInput" tagNameTitle2="当前大分类下无中分类" class="inputText w62 mustInput cantEdit" readonly="readonly" acCode="code" acTitle="name" nextInputObjId="xiaofenleiInput"
						 currUrl="/item/create/getCatalogAction?parentId=" setValueObjId="zhongfenleiInput2" clean="1" tabindex="11" value="${item.midgrpName}"/>
						<%--<div class="iconPut iq">
							<input type="text" readonly="readonly" class="w60 longText" select="select"
								id="zhongfenleiInput">
							<div class="ListWin"
								onclick="$(this).prev().focus();$(this).prev().click();"></div>
						</div>
						<input class="longText inputText w35" readonly="readonly"
							id="zhongfenleiInput2"> --%>
					</div>
					<div class="ig">
						<span class="icol_text2">*<auchan:i18n id="103001014"></auchan:i18n></span>
						<!-- <select class="w60" id="xiaofenleiInput"  name="catlgId">
								<option value="">请选择</option>
							</select> -->
							
						<input type="hidden" id="xiaofenleiInput2" tagNameTitle2="当前中分类下无小分类" name="catlgId" value="${item.catlgId}">
						<input id="xiaofenleiInput" class="inputText w62 mustInput cantEdit" readonly="readonly" acCode="code" acTitle="name"
						 currUrl="/item/create/getCatalogAction?parentId=" setValueObjId="xiaofenleiInput2" clean="1" tabindex="12" value="${item.catlgName}"/>
					</div>
				</div>
				<div class="ip">
					<div class="ip1 w12_5">
						<div>
							<span>*<auchan:i18n id="103001026"></auchan:i18n></span>
						</div>
						<div>
							<span>*<auchan:i18n id="103001027"></auchan:i18n></span>
						</div>
						<div>
							<span><auchan:i18n id="101007012"></auchan:i18n></span>
						</div>
					</div>
					<div class="ip2 w25">
						<div class="ig" style="width:100%;">
							<div class="iconPut iq1" style="width:71%;"><input id="sellUnitValue" type="hidden" value="${item.sellUnit}" name="sellUnit">
								<input type="text" class="w60 longText unitName mustInput" id="prod_unitName" value="${item.sellUnitName}" style="width:60px;" setValueObjId="sellUnitValue" clean="1" tabindex="32">
								<div class="ListWin" onclick="$(this).prev().focus();$(this).prev().click();"></div>
							</div>
						</div>
						<div class="ig">
							<%-- <auchan:select mdgroup="ITEM_BASIC_BUY_WHEN"
								_class="select1 mustInput buyWhen" 
								dataBind="value:buy_when,validationElement:buy_when" name="buyWhen"/>--%>
							<select class="select1 mustInput buyWhen" name="buyWhen" onchange="if($(this).val()=='2' && $('.buyPriceLimit').size()>0){$('.buyPriceLimit').removeAttr('disabled');}else{
								$('.buyPriceLimit').attr('disabled','disabled');$('.buyPriceLimit').val('');}"> 
							<c:if test="${view==1}">
							<c:forEach items="${buyWhenList}" var="when">
							<c:if test="${item.buyWhen==when.code}">
								<option value="${when.code}" selected="selected">${when.code}-${when.title}</option>
							</c:if>
							</c:forEach>
							</c:if>
							<c:if test="${view!=1}">
							<c:forEach items="${buyWhenList}" var="when">
								<option value="${when.code}"<c:if test="${item.buyWhen==when.code}"> selected="selected"</c:if>>${when.code}-${when.title}</option>
							</c:forEach>
							</c:if>
							</select>
						</div>
					</div>
					<div class="ip3 w60">
						<div class="ig">
							<span class="icol_text2 fl_left">*<auchan:i18n id="103002014"></auchan:i18n></span><div class="w20 iconPut fl_left"><input type="text" class="w100 double_text_with_len mustInput" decval="2" intval="6" id="stdBuyPrice" name="stdBuyPrice" value="${item.stdBuyPrice}"></div><span class="fl_left" style="padding-top:4px;">元</span>
							<span class="icol_text2">*<auchan:i18n id="103001028"></auchan:i18n></span>
							<select name="buyVatNo" class="mustInput buyVatNo">
								<c:if test="${view==1}">
								<c:forEach items="${vatList}" var="obj">
								<c:if test="${obj.vatNo==item.buyVatNo}">
								<option value="${obj.vatNo}" selected="selected">${obj.vatNo}- ${obj.vatVal}%</option>
								</c:if>
								</c:forEach>
								</c:if>
								<c:if test="${view!=1}">
								<option value=""><auchan:i18n id="100000009"></auchan:i18n></option>
								<c:forEach items="${vatList}" var="obj">
								<option value="${obj.vatNo}"<c:if test="${obj.vatNo==item.buyVatNo}"> selected="selected"</c:if>>${obj.vatNo}- ${obj.vatVal}%</option>
								</c:forEach>
								</c:if>
							</select>
							<%-- <div style="width: 20%" class="iconPut iq">
								<input type="text" value="${item.buyVatNo}" class="w60 longText mustInput vatno" tabindex="33" readonly="readonly" id="buyvatno" name="buyVatNo">
								<div class="ListWin" onclick="$('.currVatObj').removeClass('currVatObj');$(this).addClass('currVatObj');openVatWindow()"></div>
							</div>
							<input type="text" value="${item.buyVatVal}" class="longText inputText vatval mustInput w35" readonly="readonly" id="buyvatval">% --%>
						</div>
						<div class="ig">
							<span class="icol_text2 fl_left">*<auchan:i18n id="103001162"></auchan:i18n></span><div class="w20 iconPut fl_left"><input type="text" class="w100 double_text_with_len mustInput" decval="2" intval="6" id="stdSellPrice" name="stdSellPrice" value="${item.stdSellPrice}"></div><span class="fl_left" style="padding-top:4px;">元</span>
							<span class="icol_text2">*<auchan:i18n id="103001029"></auchan:i18n></span>
							<select name="sellVatNo" class="mustInput sellVatNo">
								<c:if test="${view==1}">
								<c:forEach items="${vatList}" var="obj">
								<c:if test="${obj.vatNo==item.sellVatNo}">
								<option value="${obj.vatNo}" selected="selected">${obj.vatNo}- ${obj.vatVal}%</option>
								</c:if>
								</c:forEach>
								</c:if>
								<c:if test="${view!=1}">
								<option value=""><auchan:i18n id="100000009"></auchan:i18n></option>
								<c:forEach items="${vatList}" var="obj">
								<option value="${obj.vatNo}"<c:if test="${obj.vatNo==item.sellVatNo}"> selected="selected"</c:if>>${obj.vatNo}- ${obj.vatVal}%</option>
								</c:forEach>
								</c:if>
							</select>
							<%-- <div style="width: 20%" class="iconPut iq">
								<input type="text" value="${item.sellVatNo}" class="w60 vatno longText mustInput" tabindex="35" readonly="readonly"  id="sellvatno" name="sellVatNo">
								<div class="ListWin" onclick="$('.currVatObj').removeClass('currVatObj');$(this).addClass('currVatObj');openVatWindow()"></div>
							</div>
							<input type="text" value="${item.sellVatVal}" class="longText inputText w35 mustInput vatval" readonly="readonly" id="sellvatval">% --%>
						</div>
					</div>
					<select id="displaySpeclCtrl" class="w20">
						<c:if test="${empty item.speclGrpCtrl}">
						<option value=""><auchan:i18n id="100000009"></auchan:i18n></option>
						</c:if>
						<c:if test="${not empty item.speclGrpCtrl}">
						<c:forEach var="obj" items="${itemBasicSpeclGrpCtrlList}">
							<c:if test="${(item.speclGrpCtrl eq obj.code)}">
							<option value="${obj.code}">${obj.code}-${obj.title}</option>
							</c:if>
						</c:forEach>
						</c:if>
					</select>
					<auchan:i18n id="103001030"></auchan:i18n> <input class="w50 inputText" name="buyerMemo" value="${item.buyerMemo}" maxlength="20" tabindex="36">
				</div>

			</div>
		</div>
	</div>
</form>
	<div class="CM" style="height: 260px; margin-top: 2px;">
		<div class="CM-bar">
			<div><auchan:i18n id="103001078"></auchan:i18n></div>
		<!-- 	<div style="margin-top: 120px;" class="icm Icon-size2"></div> -->
		</div>
		<div class="CM-div">
	<form id="majorRegn" action="" onsubmit="return false;">
			<div class="cdsc">
				<div class="tb50">
					<div class="ig">
						<div class="msg_txt">*<auchan:i18n id="103001079"></auchan:i18n></div>
						<%-- <div style="width: 13%;" class="iconPut iq fl_left">
							<input type="text" tabindex="37" class="count_text orignCode mustInput" readonly="readonly" style="width: 60%" value="${item.orignCode}" id="otherOrignCode" name="otherOrignCode">
							<div class="ListWin" onclick="var obj=$(this).parent().parent().find('.orignTitle');obj.focus();obj.click();"></div>
						</div> --%>
						<input type="hidden" tabindex="37" class="count_text orignCode " readonly="readonly" style="width: 60%" value="${item.orignCode}" id="otherOrignCode" name="otherOrignCode">
						<c:forEach items="${metaOriginList}" var="meta">
						<c:if test="${item.orignCode==meta.code}">
						<input type="text" style="width: 35%;"  class="inputText iq orignTitle mustInput" setValueObjId="orignCode" clean="1" value="${meta.title}">
						</c:if>
						</c:forEach>
						<c:if test="${empty metaOriginList}">
						<input type="text" style="width: 35%;"  class="inputText iq orignTitle mustInput"  tagNameTitle="主产地" setValueObjId="orignCode" clean="1" value="${meta.title}"></c:if>
					</div>
					<div class="ig">
						<div class="msg_txt">*<auchan:i18n id="103001080"></auchan:i18n></div>
						<input type="hidden" name="comNo" class="comNo" value="${item.comNo}">
						<input type="hidden" id="producerId" name="producerId" class="producerId" value="${item.prdcrId}">
						<input type="text" style="width: 70%;" id="comNo2" tabindex="38" tagNameTitle="主生产单位" 
							class="inputText iq producerComName mustInput" name="producerName" value="${item.prdcrName}" maxlength="20">
					</div>
				</div>
				<div class="tb50">
					<div class="ig">
						<div class="msg_txt">*<auchan:i18n id="103001059"></auchan:i18n></div>
						<div style="width: 20%; float: left;" class="iconPut">
							<input type="text" class="provName mustInput" name="provinceName" readonly="readonly" value="${item.provName}"
								style="width: 75%;">
							<div style="color: #999999;"><auchan:i18n id="103001060"></auchan:i18n></div>
						</div>
						<div style="width: 28%; float: left; margin-left: 3px;"
							class="iconPut">
							<input type="text" readonly="readonly" class="cityName mustInput" name="cityName" value="${item.cityName}"
								style="width: 70%;">
							<!-- <div style="color: #999999;">市</div> --><span class="cdsp"><auchan:i18n id="103001061"></auchan:i18n></span>
							<div class="ListWin" onclick="currentPopObj = $(this);openCityAndProvWindow();"></div>
							<input type="hidden" name="provinceCode" class="provCode" value="">
							<input type="hidden" name="cityCode" class="cityCode">
						</div>
					</div>
					<div class="ig">
						<div class="msg_txt">&nbsp;</div>
						<input type="hidden" class="w50 inputText addressId" name="addressId" value="${item.addrId}">
						<input class="w50 inputText address mustInput" name="address" value="${item.detlAddr}" maxlength="30">
					</div>
				</div>
			</div>
			</form>
			<div style="width: 960px;" class="txm_info">
				<div class="txm_title2">
					<span style="margin-left: 50px;">*<auchan:i18n id="103001081"></auchan:i18n></span><span
						style="margin-left: 60px;">*<auchan:i18n id="103001082"></auchan:i18n></span> <span
						style="margin-left: 120px;">*<auchan:i18n id="103001058"></auchan:i18n></span><span
						style="margin-left: 100px;">*<auchan:i18n id="103001059"></auchan:i18n></span>
				</div>
				<div style="height: 120px;" class="sp_tb2" id="otherRegList">
				<c:if test="${empty othProdcrAddrList && empty item && 1==0}">
					<form class="otherRegn" action="" onsubmit="return false;">
					<div style="margin-top: 5px;" class="ig">
						<input type="checkbox" class="cdsc0" onclick="resetCheckAll($(this).parent().parent().parent())"> 
						<input type="hidden" class="regionNodeCode" name="cityRegnNo" value="">
						<input type="text"
							class="cdsc1 inputText regionNode mustInput" acWidth="95px" tabindex="40" setValueObjId="regionNodeCode" value="" acCode="regnNo" acTitle="regnName">
						<!-- <div class="iconPut cdsc2">
							<input type="text" style="width: 70%" class="orignCode mustInput" tabindex="41" name="otherOrignCode">
							<div class="ListWin" onclick="var obj=$(this).parent().parent().find('.orignTitle');obj.focus();obj.click();"></div>
						</div> -->
						<input type="hidden" style="width: 70%" class="orignCode mustInput" tabindex="41" name="otherOrignCode">
						<input type="text"	class="inputText cdsc3 orignTitle mustInput" setValueObjId="orignCode"> 
						
						<input type="hidden" name="comNo" class="comNo">
						<input type="hidden" name="producerId" class="producerId" value="">
						<input type="text" class="inputText cdsc3_1 producerComName mustInput" tabindex="42" name="producerName" value="" maxlength="20">
						<div class="iconPut cdsc2_1">
							<input type="text" class="provName mustInput" style="width: 82%" name="provinceName"> <span class="cdsp"><auchan:i18n id="103001060"></auchan:i18n></span>
						</div>
						<div class="iconPut cdsc2_1">
							<input type="text" class="fl_left cityName mustInput" style="width: 65%" name="cityName">
							<div class="ListWin" onclick="currentPopObj = $(this);openCityAndProvWindow();"></div><span class="cdsp"><auchan:i18n id="103001061"></auchan:i18n></span>
							<input type="hidden" name="provinceCode" class="provCode">
							<input type="hidden" name="cityCode" class="cityCode">
						</div>
						<input type="hidden" class="w50 inputText addressId" name="addressId">
						<input type="text" class="w20 inputText address mustInput" name="address" maxlength="30">
					</div>
				  </form>
				</c:if> 
				<c:if test="${not empty othProdcrAddrList}">
				<c:forEach items="${othProdcrAddrList}" var="obj">
					<form class="otherRegn" action="" onsubmit="return false;">
					<div style="margin-top: 5px;" class="ig">
						<input type="checkbox" class="cdsc0 divHide" onclick="resetCheckAll($(this).parent().parent().parent())"/> 
						<input type="hidden" class="regionNodeCode" name="cityRegnNo" value="${obj.cityRegnNo}">
						<c:forEach items="${regNodeList}" var="regNode">
						<c:if test="${obj.cityRegnNo==regNode.regnNo}">
						<input type="text"
							class="cdsc1 inputText regionNode mustInput chbox-mgl" acWidth="120px" tabindex="40" setValueObjId="regionNodeCode" value="${regNode.regnName}" acCode="regnNo" acTitle="regnName">
						</c:if>
						</c:forEach>
						<%-- <div class="iconPut cdsc2">
							<input type="text" style="width: 70%" class="orignCode mustInput" tabindex="41" name="otherOrignCode" value="${obj.otherOrignCode}">
							<div class="ListWin" onclick="var obj=$(this).parent().parent().find('.orignTitle');obj.focus();obj.click();"></div>
						</div>  --%>
						<input type="hidden" style="width: 70%" class="orignCode mustInput" tabindex="41" name="otherOrignCode" value="${obj.otherOrignCode}">
						<c:forEach items="${metaOriginList}" var="meta">
						<c:if test="${obj.otherOrignCode==meta.code}">
						<input type="text"	class="inputText cdsc3 orignTitle mustInput" setValueObjId="orignCode" value="${meta.title}">
						</c:if>
						</c:forEach>
						
						<input type="hidden" name="comNo" class="comNo" value="${obj.comNo}">
						<input type="hidden" name="producerId" class="producerId" value="${obj.producerId}">
						<input type="text" class="inputText cdsc3_1 producerComName mustInput" tabindex="42" name="producerName" maxlength="20" value="${obj.producerName}">
						<div class="iconPut cdsc2_1">
							<input type="text" class="provName mustInput" readonly="readonly" style="width: 82%" name="provinceName" value="${obj.provinceName}"> <span class="cdsp"><auchan:i18n id="103001060"></auchan:i18n></span>
						</div>
						<div class="iconPut cdsc2_1">
							<input type="text" class="fl_left cityName mustInput" readonly="readonly" style="width: 65%" name="cityName" value="${obj.cityName}">
							<div class="ListWin" onclick="currentPopObj = $(this);openCityAndProvWindow();"></div><span class="cdsp"><auchan:i18n id="103001061"></auchan:i18n></span>
							<input type="hidden" name="provinceCode" class="provCode">
							<input type="hidden" name="cityCode" class="cityCode">
						</div>
						<input type="hidden" class="w50 inputText addressId" name="addressId" value="${obj.addressId}">
						<input type="text" class="w20 inputText address mustInput" name="address" value="${obj.address}" maxlength="30">
					</div>
				  </form>
				</c:forEach>
				</c:if>
				</div>
				<div class="ig divHide">
					<input type="checkbox" class="sp_icon1  checkAll" onclick="selectCheckbox($(this).parent().prev(),$(this).attr('checked'));">
					<div class="Icon-size2 Tools10 sp_icon2" onclick="deleteCheckbox($(this).parent().prev());"></div>
					<div class="Icon-size2 Line-1 sp_icon3 "></div>
					<div class="Icon-size2 Tools11 sp_icon4" onclick="var obj=$(this).parent().prev();addOtherSupList(obj);nullInputCheck();"></div>
				</div>
			</div>
			
		</div>
	</div>


<div id="provCityDiv" style="display:none;">
<form class="otherRegn" action="" onsubmit="return false;">
<div class="ig">
	<input type="hidden" class="regionNodeCode" name="cityRegnNo">
	<input type="checkbox" class="cdsc0" onclick="resetCheckAll($(this).parent().parent().parent())"/> <input type="text" setValueObjId="regionNodeCode" acCode="regnNo" acTitle="regnName"
		class="cdsc1 inputText regionNode" acWidth="95px">
	<!-- <div class="iconPut cdsc2">
		<input type="text" style="width: 70%" class="orignCode mustInput" name="otherOrignCode">
		<div class="ListWin" onclick="var obj=$(this).parent().parent().find('.orignTitle');obj.focus();obj.click();"></div>
	</div> -->
	<input type="hidden" style="width: 70%" class="orignCode mustInput" name="otherOrignCode">
	<input type="text" class="inputText cdsc3 orignTitle" setValueObjId="orignCode"> 	
	<input type="hidden" name="comNo" class="comNo">
	<input type="hidden" name="producerId" class="producerId">
	<input type="text" class="inputText cdsc3_1 producerComName" name="producerName" maxlength="20">
	<div class="iconPut cdsc2_1">
		<input type="text" class="provName" readonly="readonly" style="width: 82%"> <span class="cdsp"><auchan:i18n id="103001060"></auchan:i18n></span>
	</div>
	<div class="iconPut cdsc2_1">
		<input type="text" class="fl_left cityName" readonly="readonly" style="width: 65%"> 
		<div class="ListWin" onclick="currentPopObj = $(this);openCityAndProvWindow();"></div><span
			class="cdsp"><auchan:i18n id="103001061"></auchan:i18n></span>
	</div>
	<input type="text" class="w20 inputText address" name="address" maxlength="30">
	<input type="hidden" class="w50 inputText addressId" name="addressId">
	<input type="hidden" name="provinceCode" class="provCode">
	<input type="hidden" name="cityCode" class="cityCode">
</div>
</form>
</div>
<div class="bnoResultDiv" style="display:none;">
	<div class="Panel" style="width:550px;">
        <div class="Panel_top">
            <span>以下BNO超出</span>
            <div class="PanelClose" onclick="$('.bnoResultDiv').window('close');$('.grid_layer').hide();"></div>
        </div>
        <div class="Table_Panel" style="height:200px;padding:20px 10px 10px 10px;">
			<table width="100%" border="1">
			<tr>
			<td>BNO</td>
			<c:forEach var="obj" items="${bigRegionList}">
			<td regnNo="${obj.regnNo}">${obj.regnName}</td>
			</c:forEach>
			</tr>
			</table>
		</div>
</div>
</div>
<div id="_title" style="display:none;padding:10px;height:auto;width:150px;position:absolute;background:#fff;border:1px solid #000;">
</div>
<script type="text/javascript">
	var currentPopObj;
	var divisionId;
	var provNum = 3;
	var itemTaskId = '${item.taskId}';
	var bgRegn=new Array([${bigRegionList.size()}]);
	var bgRegnName=new Array([${bigRegionList.size()}]);
	inputToInputDoubleNumberAndChkLen($('#item_create_1'));
	<c:forEach var="obj" items="${bigRegionList}" varStatus="status">
	bgRegn[${status.index}]="${obj.regnNo}";
	bgRegnName[${status.index}]="${obj.regnName}";
	</c:forEach>
	$(function() {
		<c:if test="${not empty item}">
		if(viewFlag!='1'){
			$('.cantEdit').attr('disabled','disabled');
		}
		$('.cantEdit').unbind();
		$('.cantEdit').removeAttr('onclick');
		$('.cantEdit').removeAttr('onblur');
		</c:if>
		nullInputCheck();
		setBuyPerdParameter('${item.buyPerd}');
	});
	
</script>