<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript" src="${ctx}/shared/js/picShow/showComLicncePic.js"></script>
<script src="${ctx}/item/create/stepThreeAutoComplete?secId=${secId}" type="text/javascript"></script>

<style type="text/css">
     .Panel {
         width:955px;
     }
     .Table_Panel {
         height:350px;
         overflow:hidden;
     }
     .zzz_12 {
         margin-left:250px;
     }
     .zzz_13 {
         margin-left:330px;
     }
     .ck_zz{margin-right: 5px; 
     margin-top: 5px;
     float: left
     }
     
     .sp_icon1{
     margin-left: 5px
     
      }
     
 </style>
 <script type="text/javascript">
var createLicnceInfo = new Array();//当前商品下所有的证件
var havedLicnceInfo =new Array();//当前商品下所有的证件(存在的)
$(function(){
	readLicnceIdPicInfos($('#itemNo').val());	
	createLicnceInfo=new Array();
	
});

//异步获取证件信息是否存在
function readLicenceCountByLicnceId(licnceId){
	var infoOne= $(licnceId).parent().parent().find("[name='new_licnce_type']").val();
	var infoTwo= $.trim($(licnceId).parent().parent().find("[name='new_licnce_no']").val());
	if(infoOne==""){ 
		top.jAlert('warning', '请选择证件类型', '消息提示');
     return;
		}else{
        if(infoOne<10){
        	infoOne="0"+infoOne;
            } 
	}
	if(infoTwo=="") 	
	{ 
		top.jAlert('warning', '请输入证件号', '消息提示');
     return ;
		}
     if(!validationLicnce(licnceId)){
         return;
         }
     		
		 $.ajax({
			url :'${ctx}/uploadItemPicAction/readLicenceCount?tt='
					+ new Date().getTime(),
			data : {licenceId:infoTwo+"@"+infoOne},
			type : 'POST',
			success : function(response) {
                //检测证件信息是不是存在
                 if(response!=0){
                         if(containsArray(havedLicnceInfo,infoTwo+"@"+infoOne)){
                        	 loadItemlicnce(licnceId);
                             }else{
                	 top.jAlert('warning', '证件信息已经存在', '消息提示');
                          }
                     }else{
                    	 loadItemlicnce(licnceId);
                    	//存入证件信息
                  	   createLicnceInfo.push(infoTwo+"@"+infoOne);	                  	
                        }				
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});
}


//检测证件信息，如果证件Id已经在页面存在，则提示用户
function validationLicnce(licnceId){
	var infoOne= $(licnceId).parent().parent().find("[name='new_licnce_type']").val();
	var infoTwo= $.trim($(licnceId).parent().parent().find("[name='new_licnce_no']").val());
	 if(infoOne<10){
     	infoOne="0"+infoOne;
         }

      if($(licnceId).parent().parent().find("[name='new_licnce_no']").attr("readonly")=='readonly'){
    	  loadItemlicnce(licnceId);
          }else  if(containsArray(createLicnceInfo,infoTwo+"@"+infoOne)){
    	$(licnceId).parent().parent().find("[name='new_licnce_no']").removeClass().addClass('w20 inputText errorInput');
    	$(licnceId).parent().parent().find("[name='new_licnce_no']").focus(function(){
        $(licnceId).parent().parent().find("[name='new_licnce_no']").removeClass().addClass('w20 inputText');
       });

   	 top.jAlert('warning', '证件信息已经输入，请检测再输入', '消息提示');
    	 return false;
         }else{
             return true;
      }		
}


 
//点击编辑图片信息
function loadItemlicnce(licnceId){
	
	var infoOne= $(licnceId).parent().parent().find("[name='new_licnce_type']").val();
	var infoTwo= $.trim($(licnceId).parent().parent().find("[name='new_licnce_no']").val());

	 if(infoOne<10){
	     	infoOne="0"+infoOne;
	         }
     
	if(viewFlag==1){
		loadComPicInfos(infoTwo+"@"+infoOne);
		}else{ 
	//锁定证件号码和证件类型
	$(licnceId).parent().parent().find("[name='new_licnce_type']").attr("disabled","disabled");
	$(licnceId).parent().parent().find("[name='new_licnce_no']").attr("readonly","readonly");
    //遮罩层信息
	   var ht = $(document).height();
       var wd = $(document).width();
       if(typeof(itemsUploadPhotos)!="undefined"){
       itemsUploadPhotos=new Array();
           }
       $("#updateItemPicDiv").css({"height":ht,"width":wd,"display":"block"});
       $("#edit_ItemPicInfos").load("${ctx}/uploadItemPicAction/toUploadLiceneItemPic?licnceId="+infoTwo+"@"+infoOne);
		}
 };

 $("#close_ItemPic").unbind("click").bind("click",function(){

	 $("#edit_ItemPicInfos").empty();//清空增加图片页面
		$("#updateItemPicDiv").hide();//当前层隐藏	
 });


 //增加证件信息
$("#add_New_ItemLicnce").unbind("click").bind("click",function(){
	var htmlDiv="<div class='ig'  style='margin-top:5px;'> </div>";
	var htmlone="<input type='checkbox' class='ck_zz'> "
		 +"<div class='license1 fl_left'>"
		 +"<div class='license2' onclick='readLicenceCountByLicnceId(this)'></div>"
		 +"</div>";
		 $("#metaInfos select").attr("disabled",false); 	 
	//设置某个选项为选中项
    var htmlTwo=$("#metaInfos").html();
    $(htmlTwo).val("");
    var htmlThree="<input type='text' class='w20 inputText'  name='new_licnce_no' />"
		 +"<input type='text' class='w20 inputText'  name='new_licnce_issuby' />"		 
		 +"<input name='new_licene_endDate'  readonly='readonly' class='Wdate w12_5' type='text' onClick='WdatePicker()'>"
		 +"<input name='new_licnce_startDate'  readonly='readonly' class='Wdate w12_5' type='text' onClick='WdatePicker()'>";
          //生成一个层，动态添加到厂商证照列表下
	      $(htmlDiv).html(htmlone+htmlTwo+htmlThree).appendTo("#item_licnce_list");
          loadCheckBoxClick();//加载checkbox事件	
          nullInputCheck();
});

 //移除证件信息
$("#remove_itemLicnce").unbind("click").bind("click",function(){
 //移除选中的项
$("#item_licnce_list input:checked").parent().remove();	

 //设置全框为不选中状态
$("#check_All_itemLicnce").attr("checked",false);
});


 //全选反选事件
$("#check_All_itemLicnce").unbind("click").bind("click",function(){
if($("#check_All_itemLicnce").attr("checked")=="checked"){
	$(".ck_zz").attr("checked",true);
}else{
	$(".ck_zz").attr("checked",false);
}	
});



 function loadCheckBoxClick(){
//选定事件
$("#item_licnce_list :checkbox").unbind("click").bind("click",function(){
     if($("#item_licnce_list :checkbox").length == $("#item_licnce_list :checkbox:checked").length){
    	 $("#check_All_itemLicnce").attr("checked","checked");
         }else{
        	 $("#check_All_itemLicnce").attr("checked",false);
             }	
});
 }

var jsonStrs="";
//拼装json数据
function appendJsonDataByLicnce(){
	jsonStrs="";//先清理
$("#item_licnce_list").find(".ig").each(function(index,item){
var licnceType ;
var licnceNo;
var issueBy;
var validStartDate;
var validEndDate;
var jsons;
	licnceType= "'licnceType':"+$(this).find("[name='new_licnce_type']").val();
	if(licnceType<10){
		licnceType="0"+licnceType;
		}
	licnceNo=",'licnceNo':'"+$(this).find("[name='new_licnce_no']").val();
	issueBy="','issueBy':'"+$(this).find("[name='new_licnce_issuby']").val();
	validStartDate="','validStartDate':'"+$(this).find("[name='new_licnce_startDate']").val();
	validEndDate="','validEndDate':'"+$(this).find("[name='new_licene_endDate']").val()+"'";
if($("#item_licnce_list").find(".ig").length==1){
	jsons="[{"+licnceType+licnceNo+issueBy+validStartDate+validEndDate+"}]";	
}else{  
if(index==0){   
	jsons="[{"+licnceType+licnceNo+issueBy+validStartDate+validEndDate+"},";
}else if(index== $("#item_licnce_list").find(".ig").length-1){
	jsons="{"+licnceType+licnceNo+issueBy+validStartDate+validEndDate+"}]";	
}else{
	jsons="{"+licnceType+licnceNo+issueBy+validStartDate+validEndDate+"},";		
}
}
jsonStrs=jsonStrs+jsons;

});	

}

//读取证件信息
//需要执行的方法，读取图片信息
     function readLicnceIdPicInfos(itemNo){
    	 havedLicnceInfo=new Array();
         $("#item_licnce_list").empty();
    	 $.ajax({
				url :'${ctx}/supplierLicenceAction/readItemLicnceByItemId?tt='
						+ new Date().getTime(),
				data : {itemNo:itemNo},
				type : 'POST',
				success : function(response) {
					$(response).each(function(index,item){
						  havedLicnceInfo.push(item.licnceId);
						 addItemLicnce(item);
						});
					loadCheckBoxClick();//加载checkbox事件		
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					top.jAlert('error', '网络超时!请稍后重试', '提示消息');
				}
			});

         }

function addItemLicnce(item){
	var htmlDiv="<div class='ig'  style='margin-top:5px;'> </div>";
	var htmlone="<input type='checkbox' class='ck_zz divHide'> "
		 +"<div class='license1 fl_left chbox-mgl'>"
		 +"<div class='license2' onclick='loadItemlicnce(this)'></div>"
		 +"</div>";
			//设置某个选项为选中项
	var typeInfo=getDictValue('COM_LICENCE_LICNCE_TYPE',item.licnceType);
    var htmlTwo="<select disabled='disabled'name='new_licnce_type'  style='width:12.5%' title='"+typeInfo+"'> <option  value='"+item.licnceType+"' selected='selected'>"+typeInfo+"</option><select>";
    var htmlThree="<input type='text' class='w20 inputText'  name='new_licnce_no' value='"+item.licnceNo+"' readonly='readonly'/>"
		 +"<input type='text' class='w20 inputText'  name='new_licnce_issuby' value='"+item.issueBy+"'/>"		 
		 +"<input name='new_licene_endDate' value='"+new Date(item.vaildEndDate).format('yyyy-MM-dd')+"' readonly='readonly' class='Wdate w12_5' type='text'>"
		 +"<input name='new_licnce_startDate' value='"+ new Date(item.vaildStartDate).format('yyyy-MM-dd')+"' readonly='readonly' class='Wdate w12_5' type='text'>";
          //生成一个层，动态添加到厂商证照列表下
	      $(htmlDiv).html(htmlone+htmlTwo+htmlThree).appendTo("#item_licnce_list");
}

//证照信息验证
function validataLicnceInfo(){
	if(viewFlag==1){return true;}

	 //加入鼠标焦点切入事件
    $("#item_licnce_list .ig input").each(function(index,inputInfo){
 	   $(inputInfo).focus(function(){
     	   $(inputInfo).removeClass("errorInput");
     	   $(inputInfo).parent().find("select").removeClass("errorInput");
     	   }); 
 	                 
        });
    //加入鼠标焦点切入事件
    $("#item_licnce_list .ig select").each(function(index,selectInfo){
 	   $(selectInfo).focus(function(){
     	   $(selectInfo).removeClass("errorInput");
     	   $(selectInfo).parent().find("input").removeClass("errorInput");
     	   });                 
        });
	
var licnceInfos = new Array();//当前商品下所有的证件
var errorCount=0;
$("#item_licnce_list .ig").each(function(index,item){ 
   var oneInfo=$(item).find("[name='new_licnce_type']").val();
   if(oneInfo<10){
	   oneInfo="0"+oneInfo;
       } 
   var twoInfo=$.trim($(item).find("[name='new_licnce_no']").val());
   licnceInfos.push(twoInfo+"@"+oneInfo);

   //检测数据库，查看证件信息是否存在         
   validationLicnceByLicnceId(twoInfo+"@"+oneInfo,function(data){
             if(data!=0 && !containsArray(havedLicnceInfo,twoInfo+"@"+oneInfo)){
            	  errorCount=errorCount+1;
                  //如果信息存在，则提示用户
           	   $(item).find("[name='new_licnce_type']").addClass("errorInput");
           	   $(item).find("[name='new_licnce_no']").addClass("errorInput");
                 }    
	   });
 }); 
       //如果证件信息已存在，则提示
        if(errorCount>0){   
           	    top.jAlert('warning', '证件信息已经存在', '提示消息');
           	    return false;
            }
//验证选项有没有选中
 $("#item_licnce_list .ig").each(function(index,item){
        //检测下拉框是不是有选择        
        if($(item).find("[name='new_licnce_type']").val()==""){
        	errorCount=errorCount+1;
        	$(item).find("[name='new_licnce_type']").addClass("errorInput");
            }
        //检测会不会有重复的证件信息
       var one=$(item).find("[name='new_licnce_type']").val();
       if(one<10){
    	   one="0"+one;
           } 
       var two=$.trim($(item).find("[name='new_licnce_no']").val());
       if(two==""){
    	   errorCount=errorCount+1;
    	   $(item).find("[name='new_licnce_no']").addClass("errorInput");
           }
         if(containsArray(licnceInfos,two+"@"+one)){
             //验证通过，从集合中移除                       
				//移除集合中的图片信息
				for (var index = 0; index < licnceInfos.length; index++) {
					if ((two+"@"+one) == licnceInfos[index]) {
						//移除当前图片链接
						licnceInfos.splice(index, 1);
					}
				}
           }else{
        	   errorCount=errorCount+1;
               //如果信息重复，则提示用户
        	   $(item).find("[name='new_licnce_type']").addClass("errorInput");
        	   $(item).find("[name='new_licnce_no']").addClass("errorInput");
        	   top.jAlert('warning', '证件信息已经输入，请检测再输入', '消息提示');
        	   return false;
               }
          //验证发证机关
          if($.trim($(item).find("[name='new_licnce_issuby']").val())==""){
        	  errorCount=errorCount+1;
        	 $(item).find("[name='new_licnce_issuby']").addClass("errorInput");
              }                
         //检测时间对比，如果起始事件小于结束时间，则提示
         var startDate=$(item).find("[name='new_licnce_startDate']").val();
         var endDate=$(item).find("[name='new_licene_endDate']").val();
           if(startDate==""){
        	   errorCount=errorCount+1;
        	   $(item).find("[name='new_licnce_startDate']").addClass("errorInput");
               }
           if(endDate==""){
        	   errorCount=errorCount+1;
        	   $(item).find("[name='new_licene_endDate']").addClass("errorInput");
               }
           //验证时间信息
           if(startDate!="" &&  endDate!=""){
        	   if(dateStrToDate(startDate)>dateStrToDate(endDate)){
        		   errorCount=errorCount+1;
        		   $(item).find("[name='new_licnce_startDate']").addClass("errorInput");
              	    top.jAlert('warning', '开始时间不能大于截至时间', '提示消息');
         		   return false;
            	   }       	                    
               }                        
	 });
      
       if(errorCount>0){
    return false;
       }
       else{
    return true;
       }
      
}

//异步检测证件信息
function  validationLicnceByLicnceId(licnceId,methodName){
	 $.ajax({
			url :'${ctx}/uploadItemPicAction/readLicenceCount?tt='
					+ new Date().getTime(),
			data : {licenceId:licnceId},
			type : 'POST',
			success : function(response) {
				methodName(response);			
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});
	
}



//传入时间字符串，传化成js Date类型,格式限定yyyy-MM-dd,yyyy/MM/dd
function  dateStrToDate(dateStr){
    //根据日期字符串转换成日期
    var regEx = new RegExp("\\-","gi");
    dateStr=dateStr.replace(regEx,"/");
    //dateStr=dateStr.replace("\\-","/");//这样不行
    //parse  yyyy/MM/dd 这种格式!法克!
    var milliseconds=Date.parse(dateStr);
    var dateInfo=new Date();
    dateInfo.setTime(milliseconds);
  return dateInfo;	
}



//检测list中存在item
function containsArray(arrObj,item){
	var isHaved=false;
     if(typeof(arrObj)!="undefined" && arrObj.length>0 ){
    	  for (var i =0 ;i<arrObj.length;i++) {
					if (arrObj[i] == item) {
						isHaved=true;
				     }    
         }
     }
     return isHaved;
}

</script>
 
 <div style="display: none;" id="metaInfos"><auchan:select name="new_licnce_type"   mdgroup="COM_LICENCE_LICNCE_TYPE" style="width: 12.5%;"  ></auchan:select></div>
 <!--  图片编辑遮罩层 -->
   <div id="updateItemPicDiv" class='picture_layer'>
        <div style='width:1032px;height:500px;background:#fff;overflow:hidden;margin:60px auto;border:2px solid #3f9673;'>
				<div class="zwindow_titleBar" style="height: 40px;position:relative;"><div class="zwindow_titleButtonBar"><div id="close_ItemPic" class="zwindow_action_button zwindow_close"></div></div><div class="zwindow_title titleText">新增图片信息</div></div>
				<div style="height:460px;overflow-x:hidden;overflow:hidden;" id="edit_ItemPicInfos">
                             
            </div>
                                               
        </div></div>
 
<form action="/item/create/doCreateItemSpec" id="item_create_3" url="/item/create/doCreateItemSpec">
	<!-- <div class="CInfo">
         <span class="sp_store5">创建商品基本信息</span>
         <span class="sp_store4">创建商品条码信息</span>
         <span class="sp_store3 sp_store_on">创建商品规格信息</span>
         <span class="sp_store2">创建商品陈列信息</span>
         <span class="sp_store1">创建商品厂商门店信息</span>
     </div> -->
<div class="CInfo">
	<span class="sp_store5"><auchan:i18n id="103001067"></auchan:i18n></span> <span
		class="sp_store4"><auchan:i18n id="103001068"></auchan:i18n></span> <span class="sp_store3 sp_store_on"><auchan:i18n id="103001069"></auchan:i18n></span>
	<span class="sp_store2"><auchan:i18n id="103001070"></auchan:i18n></span> <span class="sp_store1"><auchan:i18n id="103001071"></auchan:i18n></span>
</div>

     <div style="height:60px;" class="CM">
         <div class="CM-bar"><div><auchan:i18n id="103001003"></auchan:i18n></div></div>
         <div class="CM-div">
             <div class="hh_item">
                  <div class="icol_text w7"><span><auchan:i18n id="103001003"></auchan:i18n></span></div>
                  <div class="iconPut iq" style="width:13%;"><input style="width:83%" type="text" name="itemNo" class="itemNo"  readonly="readonly" /><div class="ListWin"></div></div>
                  <input class="inputText iq Black itemName" style="width:20%;" type="text" name="itemName" readonly="readonly"/>
             </div>
         </div>
     </div>
     <div style="height:330px;margin-top:2px;">
         <div class="tb50">
             <div style="height:120px;" class="CM">
                 <div class="CM-bar"><div><auchan:i18n id="103001072"></auchan:i18n></div></div>
                 <div class="CM-div">
                     <div style="height:35px;margin-top:15px;">
                         <div class="msg_txt">
                             <div><auchan:i18n id="103001072"></auchan:i18n></div>
                         </div>
                         <input type="text" class="inputText w70" name="specDesc" maxlength="30" id="specDesc" style="width:61%;" value="${itemSpec.specDesc}"/>
                     </div>
                     <div class="ig">
                         <div class="msg_txt">
                         	<auchan:i18n id="103001085"></auchan:i18n>
                         </div>
                         <select class="" name="itemGrd" id="itemGrd">
                         <option value=""><auchan:i18n id="100000009"></auchan:i18n></option>
                         <c:forEach items="${itemGrdList}" var="obj">
                         <option value="${obj.code}" <c:if test="${itemSpec.itemGrd==obj.code || obj.code==0}">selected="selected"</c:if>><%-- ${obj.code}&nbsp;-&nbsp; --%>${obj.title}</option>
                         </c:forEach>
                         </select>
                         <span>&nbsp;&nbsp;<auchan:i18n id="103001086"></auchan:i18n>&nbsp;&nbsp;</span>
                         <input type="text" class="inputText w36" name="model" id="model" value="${itemSpec.model}"  maxlength="20" />
                     </div>
                     <div class="ig">
                         <div class="msg_txt"><auchan:i18n id="103001087"></auchan:i18n></div>
                         <input class="inputText w10 double_text_with_len" maxlength="7" id="face" name="face" type="text" value="${itemSpec.face}" preval="" intval="4" decval="2" />
                         <span>cm&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001088"></auchan:i18n></span>
                         <input class="inputText w10 double_text_with_len" maxlength="7" id="depth" name="depth" type="text" value="${itemSpec.depth}" preval=""  intval="4" decval="2"/>
                         <span>cm&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001089"></auchan:i18n></span>
                         <input class="inputText w10 double_text_with_len" maxlength="7" id="hght" name="hght" type="text" value="${itemSpec.hght}" preval=""  intval="4" decval="2" />
                         <span>cm</span>
                     </div>
                 </div>
             </div>
             <div style="height:250px;margin-top:2px;" class="CM">
                 <div class="CM-bar"><div><auchan:i18n id="103001090"></auchan:i18n></div></div>
                 <div class="CM-div">
                     <div class="ig"  style="margin-top:15px;">
                         <div class="msg_txt"><auchan:i18n id="103001091"></auchan:i18n></div>
                         <div style="float:left;width:110px;">
                         <input type="text" class="w100 inputText" name="storgCond" id="storgCond"  maxlength="20" value="${itemSpec.storgCond}"/>
                         <%-- <select class="w100" name="storgCond" id="storgCond">
                         <c:forEach items="${storgCondList}" var="obj">
                         <option value="${obj.code}">${obj.code}-${obj.title}</option>
                         </c:forEach>
                         </select> --%></div>
                         <span class="jksp">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<auchan:i18n id="103001092"></auchan:i18n>&nbsp;&nbsp;</span>
                         <div class="iconPut iq fl_left" style="width:20%;">
                             <select class="w100 mustInput" name="shelfLifeIndMethd" id="shelfLifeIndMethd">
	                         <c:forEach items="${shelfLifeIndMethdList}" var="obj">
	                         <option value="${obj.code}" <c:if test="${itemSpec.shelfLifeIndMethd==obj.code}">selected="selected"</c:if>>${obj.code}-${obj.title}</option>
	                         </c:forEach>
	                         </select>
                         </div>
                     </div>
                     <div class="ig">
                         <div class="msg_txt"><auchan:i18n id="103001093"></auchan:i18n></div>
                         <input type="text" class="w15 inputText fl_left count_text count_text" onchange="getStdShelfLifeDays();" id="stdShelfLifePerd" name="stdShelfLifePerd" value="${itemSpec.stdShelfLifePerd}" maxlength="4" />
                         <div class="fl_left" style="width:70px;margin-left:5px;" >
                         <select name="perdUnitName" id="perdUnitName" onchange="getStdShelfLifeDays();">
                         <!-- <option>选择</option> -->
                         <c:forEach var="obj" items="${perdUnitNameList}">
                         <option value="${obj.code}" <c:if test="${itemSpec.perdUnitName==obj.code}">selected="selected"</c:if>>${obj.title}</option>
                         </c:forEach>
                         </select>
                         </div>
                         <span><auchan:i18n id="103001094"></auchan:i18n></span>
                         <input type="text" class="w10 Black inputText count_text" name="stdShelfLifeDays" maxlength="4" id="stdShelfLifeDays" value="${itemSpec.stdShelfLifeDays}" readonly="readonly"/>
                         <span><auchan:i18n id="103001157"></auchan:i18n></span>
                     </div>
                     <div class="ig">
                         <div class="msg_txt">*<auchan:i18n id="103001095"></auchan:i18n></div>
                         <select name="hlthLabel" >
                         <c:forEach items="${itemSpechealthLabelList}" var="obj">
                         <option value="${obj.code}" <c:if test="${empty itemSpec.hlthLabel && obj.code==0}">selected="selected"</c:if><c:if test="${not empty itemSpec.hlthLabel && obj.code==itemSpec.hlthLabel}">selected="selected"</c:if>>${obj.title}</option>
                         </c:forEach>
                         </select>
                         <%-- <div class="iconPut iq fl_left" style="width:13%;">
                             <input type="text" style="width:60%" class="healthLbl mustInput" setValueObjId="healthLblName"  clean="1" acWidth="100px" name="hlthLabel" value="<c:if test="${empty itemSpec.hlthLabel}">0</c:if><c:if test="${not empty itemSpec.hlthLabel}">${itemSpec.hlthLabel}</c:if>">
                             <div class="ListWin" onclick="var obj=$(this).prev();obj.focus();obj.click();"></div>
                         </div>
                         <c:forEach items="${itemSpechealthLabelList}" var="obj">
                         <c:if test="${obj.code==itemSpec.hlthLabel || (empty itemSpec.hlthLabel && obj.code==0)}">
                         <input class="inputText iq Black healthLblName" type="text" style="width:20%;" setValueObjId="healthLbl"  clean="1" acWidth="100px" value="${obj.title}" readonly="readonly"/>
                         </c:if>
                         </c:forEach> --%>
                         <%-- <c:if test="${empty itemSpec.hlthLabel}"><input class="inputText iq Black healthLblName" type="text" style="width:20%;" setValueObjId="healthLbl"  clean="1" acWidth="100px"  value="" readonly="readonly"/></c:if> --%>
                     </div>
                     <div class="ig">
                         <div class="msg_txt"><auchan:i18n id="103001096"></auchan:i18n></div>
                         <input type="text" class="w50 inputText fl_left" name="edbleMethd" id="edbleMethd" value="${itemSpec.edbleMethd}" maxlength="20" />
                     </div>
                     <div style="height:60px;">
                         <div class="msg_txt">
                             <div><auchan:i18n id="103001097"></auchan:i18n></div>
                         </div>
                         <textarea class="w70 txtarea" rows="2" name="ingrOrCntntDesc" id="ingrOrCntntDesc"  maxlength="500" style="font-family:Microsoft YaHei">${itemSpec.ingrOrCntntDesc}</textarea>
                     </div>
                 </div>
             </div>
         </div>
         <div class="tb50">
             <div style="height:120px;" class="CM">
                 <div class="CM-bar"><div><auchan:i18n id="103001098"></auchan:i18n></div></div>
                 <div class="CM-div">
                     <div style="margin-top:15px;" class="ig bz_info">
                         <div><span class="bz_1"><auchan:i18n id="103001099"></auchan:i18n></span>
                             <span class="bz_2"><auchan:i18n id="103001100"></auchan:i18n>（<auchan:i18n id="103001101"></auchan:i18n>）</span>
                             <span class="bz_3"><auchan:i18n id="103001102"></auchan:i18n></span>
                             <span class="bz_4"><auchan:i18n id="103001103"></auchan:i18n></span></div>
                     </div>
                     <div class="ig">
                         <span class="jksp">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;</span>
                         <input class="inputText iq Black" id="prod_unitName_1" type="text" style="width:10%;" disabled="disabled"/>
                         <span class="jksp">&nbsp;=&nbsp;</span>
                         <input class="inputText iq count_text" name="numOfPackUnit" onchange="unitAvgCalculate()" value="${itemSpec.numOfPackUnit}" id="numOfPackUnit" type="text" style="width:10%;" maxlength="2"/>
                         <div class="iconPut iq fl_left" style="width:15%;">
                            <input type="hidden" id="packUnit" name="packUnit" clean="1" value="${itemSpec.packUnit}">
                            <input type="text" class="w70 longText unitName" id="packUnitName" setValueObjId="packUnit" name="packUnitName" clean="1" value="<c:forEach items="${itemUnitList}" var="obj"><c:if test="${obj.code==itemSpec.packUnit}">${obj.title}</c:if></c:forEach>">
							<div class="ListWin" onclick="$(this).prev().focus();$(this).prev().click();"></div>
                         </div>
                         <span class="fl_left">&nbsp;x&nbsp;</span>
                         <input class="inputText iq count_text" id="baseVol" name="baseVol" value="${itemSpec.baseVol}"  type="text" style="width:20%;" onchange="unitAvgCalculate()" maxlength="4"/>
                         <div class="iconPut iq fl_left" style="width:15%;">
                             <input type="hidden" id="baseVolUnit" name="baseVolUnit" clean="1" value="${itemSpec.baseVolUnit}" onchange="unitAvgCalculate()">
                             <input type="text" class="w70 longText baseVolUnitName" id="baseVolUnitName" name="baseVolUnitName" clean="1" value="<c:forEach items="${itemUnitList}" var="obj"><c:if test="${obj.code==itemSpec.baseVolUnit}">${obj.title}</c:if></c:forEach>">
							 <div class="ListWin" onclick="$(this).prev().focus();$(this).prev().click();"></div>
                         </div>
                     </div>
                     <div class="ig">
                         <div class="msg_txt"><auchan:i18n id="103001104"></auchan:i18n></div>
                         <div class="iconPut fl_left w15">
                             <input type="hidden" name="avgUnitConversion" id="avgUnitConversion">
                             <input type="hidden" name="avgUnit" id="avgUnit" value="${itemSpec.avgUnit}">
                             <input class="w70 avgUnitName" type="text" name="avgUnitName" id="avgUnitName" value="<c:forEach items="${itemUnitList}" var="obj"><c:if test="${obj.code==itemSpec.avgUnit}">${obj.title}</c:if></c:forEach>">
                             <div class="ListWin" onclick="$(this).prev().focus();$(this).prev().click();"></div>
                         </div>
                         <div class="msg_txt"><auchan:i18n id="103001105"></auchan:i18n></div>
                         <input class="inputText fl_left w20 double_text_with_len" name="avgMulti" id="avgMulti" type="text" maxlength="11"  value="${itemSpec.avgMulti}" preval=""  intval="6" decval="2"/>
                     </div>
                 </div>
             </div>
             <div style="height:60px; margin-top:2px;" class="CM">
                 <div class="CM-bar"><div><auchan:i18n id="103001106"></auchan:i18n></div></div>
                 <div class="CM-div">
                     <div class="ig"  style="margin-top:15px;">
                         <div class="msg_txt"><auchan:i18n id="103001106"></auchan:i18n></div>
                         <div class="iconPut fl_left w70">
                             <input type="text" class="w93" id="advShowList" name="itemAdDescSet" value="${adDesc}" readonly="readonly" >
                             <div class="ListWin" onclick="openAdvWindow(967,447);"></div>
                         </div>
                     </div>
                 </div>
             </div>
             <div style="height:145px;margin-top:2px;" class="CM">
                 <div class="CM-bar"><div><auchan:i18n id="103001107"></auchan:i18n></div></div>
                 <div class="CM-div">
                     <div class="ig"  style="margin-top:15px;">
                         <div class="msg_txt"><auchan:i18n id="103001108"></auchan:i18n>1</div>
                         <input class="inputText iq Black" type="text" style="width:20%;" readonly="readonly" value="${clSecCtrl.secAttr1Name}"/>
                         <div class="iconPut iq fl_left" style="width:13%;"><input type="hidden" class="attrId" name="secAttr1ValId" id="secAttr1ValId" value="${itemSpec.secAttr1ValId}">
                             <input type="text" style="width:60%" <c:if test="${not empty clSecCtrl.secAttr1Name}"> id="attrNo1" value="${secAttrNo1}" acWidth="66px" class="count_text" setValueObjId="attrVal"</c:if>/>
                             <div class="ListWin" onclick="$(this).prev().focus();$(this).prev().click();"></div>
                         </div>
                         <input class="inputText iq Black attrVal" readonly="readonly" type="text" style="width:20%;" name="secAttr1Value" id="secAttr1Value" value="${secAttrName1}"/>
                     </div>
                     <div class="ig">
                         <div class="msg_txt"><auchan:i18n id="103001108"></auchan:i18n>2</div>
                         <input class="inputText iq Black" type="text" style="width:20%;" readonly="readonly" value="${clSecCtrl.secAttr2Name}"/>
                         <div class="iconPut iq fl_left" style="width:13%;"><input type="hidden" class="attrId" name="secAttr2ValId" id="secAttr2ValId" value="${itemSpec.secAttr2ValId}">
                             <input type="text" style="width:60%" <c:if test="${not empty clSecCtrl.secAttr2Name}"> id="attrNo2" value="${secAttrNo2}" acWidth="66px" class="count_text" setValueObjId="attrVal"</c:if>/>
                             <div class="ListWin" onclick="$(this).prev().focus();$(this).prev().click();"></div>
                         </div>
                         <input class="inputText iq Black attrVal" readonly="readonly" type="text" style="width:20%;"  name="secAttr2Value" id="secAttr2Value" value="${secAttrName2}"/>
                     </div>
                     <div class="ig">
                         <div class="msg_txt"><auchan:i18n id="103001108"></auchan:i18n>3</div>
                         <input class="inputText iq Black" type="text" style="width:20%;" readonly="readonly" value="${clSecCtrl.secAttr3Name}"/>
                         <div class="iconPut iq fl_left" style="width:13%;"><input type="hidden" class="attrId" name="secAttr3ValId" id="secAttr3ValId" value="${itemSpec.secAttr3ValId}">
                             <input type="text" style="width:60%" <c:if test="${not empty clSecCtrl.secAttr3Name}"> id="attrNo3" value="${secAttrNo3}" acWidth="66px" class="count_text" setValueObjId="attrVal"</c:if>/>
                             <div class="ListWin" onclick="$(this).prev().focus();$(this).prev().click();"></div>
                         </div>
                         <input class="inputText iq Black attrVal" readonly="readonly" type="text" style="width:20%;" name="secAttr3Value" id="secAttr3Value" value="${secAttrName3}"/>
                     </div>
                     <div class="ig">
                         <div class="msg_txt"><auchan:i18n id="103001108"></auchan:i18n>4</div>
                         <input class="inputText iq Black" type="text" style="width:20%;" readonly="readonly" value="${clSecCtrl.secAttr4Name}"/>
                         <div class="iconPut iq fl_left" style="width:13%;"><input type="hidden" class="attrId" name="secAttr4ValId" id="secAttr4ValId" value="${itemSpec.secAttr4ValId}">
                         
                             <input type="text" style="width:60%" <c:if test="${not empty clSecCtrl.secAttr4Name}"> id="attrNo4" acWidth="66px" class="count_text" value="${secAttrNo4}" setValueObjId="attrVal"</c:if>/>
                             <div class="ListWin" onclick="$(this).prev().focus();$(this).prev().click();"></div>
                         </div>
                         <input class="inputText iq Black attrVal" readonly="readonly" type="text" style="width:20%;" name="secAttr4Value" id="secAttr4Value" value="${secAttrName4}"/>
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
                 <div class="zz_2" id="item_licnce_list">
                   <!--  
                     <div class="ig"  style="margin-top:5px;">
                     <input type="checkbox" class="ck_zz"> 
                         <div class="license1 fl_left">
                             <div class="license2" onclick="loadItemlicnce(this)"></div>
                         </div>
                         <input type="text" class="w12_5 inputText Black fl_left" name="new_licnce_type"/>
                         <input type="text" class="w20 inputText fl_left" name="new_licnce_no"/>
                         <input type="text" class="w20 inputText fl_left" name="new_licnce_issuby"/>
						<input data-bind="value:validStartDate,validationElement:validStartDate" name="new_licnce_startDate" class="Wdate w12_5 fl_left" type="text" onClick="WdatePicker({onpicked:function(){$(this).trigger('change');},onclearing:function(){$(this).attr('value','').trigger('change')},isShowClear:false,readOnly:true})" >
						<input data-bind="value:validEndDate,validationElement:validEndDate" name="new_licene_endDate" class="Wdate w12_5 fl_left" type="text" onClick="WdatePicker({onpicked:function(){$(this).trigger('change');},onclearing:function(){$(this).attr('value','').trigger('change')},isShowClear:false,readOnly:true})" >
                     </div>
                  -->
                 </div>
                <div class="ig divHide">
					<input type="checkbox" class="sp_icon1  checkAll" id="check_All_itemLicnce">
					<div class="Icon-size2 Tools10 sp_icon2" id="remove_itemLicnce" ></div>
					<div class="Icon-size2 Line-1 sp_icon3 "></div>
					<div class="Icon-size2 Tools11 sp_icon4" id="add_New_ItemLicnce"></div>
				</div>
             </div>
         </div>
     </div>
</form>

<div id="openHidDiv" style="display:none;">
</div>
 <div class="openDiv" style="display:none;">
	<div class="Panel" style="width:955px">
        <div class="Panel_top">
            <span><auchan:i18n id="103001115"></auchan:i18n></span>
            <div class="PanelClose" onclick="closeAdvWindow()"></div>
        </div>
        <div class="Table_Panel" style="height:350px;">
		     <div class="create3_p">
		          <div class="zz_1">
		                <span class="zzz_12"><auchan:i18n id="103001116"></auchan:i18n></span>
		                <span class="zzz_13"><auchan:i18n id="103001117"></auchan:i18n></span>
		           </div>
		          <div class="create3_zz_2 fzcsgl advList">
		          </div>
		          <div class="ig">
		               <input type="checkbox" class="sp_icon1 checkAll" onclick="selectCheckbox($(this).parent().prev(),$(this).attr('checked'));"/>
		               <div class="Icon-size2 Tools10 sp_icon2" onclick="var obj=$(this).parent().prev();deleteAdvCheckbox(obj);if(obj.find('input:not(:checked)').size()>0||obj.find('input:checkbox').size()==0){$(this).prev().attr('checked',false);}">
		               </div><div class="Icon-size2 Line-1 sp_icon3 "></div>
		               <div class="Icon-size2 Tools11 sp_icon4" onclick="addAdvDataRow();var obj=$(this).parent().prev();if(obj.find('input:not(:checked)').size()>0||obj.find('input:checkbox').size()==0){$(this).prev().prev().attr('checked',false);}"></div>
		           </div>
		    </div>
        </div>
        <div class="Panel_footer">
            <div class="PanelBtn">
                <div class="PanelBtn1" onclick="advertisConfirm();"><auchan:i18n id="100000004"></auchan:i18n></div>
                <div class="PanelBtn2" onclick="closeAdvWindow();"><auchan:i18n id="100000003"></auchan:i18n></div>
            </div>
        </div>
    </div>
</div>
    <div id="itemAdvDiv" style="display:none;">
          <div class="ig zz_2_1">
               <input type="checkbox" class="fl_left" onclick="resetCheckAll($(this).parent().parent())"/>
               <span class="advLabel"><auchan:i18n id="103001106"></auchan:i18n><span class="adNo"></span></span>
               <input type="text" class="w44 inputText cnDesc" maxlength="25" name="cnDesc" />
               <input type="text" class="w44 inputText enDesc" maxlength="25" name="enDesc"/>
           </div>
    </div>
<script type="text/javascript">

var inputValueArray=null;
$(function(){
	$('.window .Table_Panel .advList').html('');
	inputToInputIntNumber();
	inputToInputDoubleNumberAndChkLen($('#item_create_3'));
	//inputToInputDoubleNumberAndChkLen(4,2);
	$('.itemNo').val($('#itemNo').val());
	$('.itemName').val($('#itemName').val());
	$('#prod_unitName_1').val($('#prod_unitName').val());
	if(viewFlag!='1'){
		loadKebieAttrInputSelect($('#attrNo1'),itemSecExtendAttrValList1,'167px');
		loadKebieAttrInputSelect($('#attrNo2'),itemSecExtendAttrValList2,'167px');
		loadKebieAttrInputSelect($('#attrNo3'),itemSecExtendAttrValList3,'167px');
		loadKebieAttrInputSelect($('#attrNo4'),itemSecExtendAttrValList4,'167px');
		loadSelectDiv($('.healthLbl'),healthLblList,0);
		loadDownLoadDivByName($("#packUnitName"),itemUnitList,$('#packUnit'),'70px',0,null);
	 	loadDownLoadDivByName($("#baseVolUnitName"),itemUnitList,$('#baseVolUnit'),'70px',0,unitAvgCalculate); ; 
		loadDownLoadDivByName($("#avgUnitName"),itemUnitList,$('#avgUnit'),'70px',0,unitAvgCalculate); 
	}
	else{
		$('.ListWin').attr('onclick','');
	}
	$('.PanelClose').die().live('click',closeItemPopWindow);
   	setValueForInput();
   	<c:if test="${empty itemSpec}">
   	addAdvDataRow();
	if($('#packUnitName').val()==''){
		$('#packUnitName').val($('#prod_unitName').val());
		$('#packUnit').val($('#sellUnitValue').val());
	}
	if($('#numOfPackUnit').val()==''){
		$('#numOfPackUnit').val(1);
	}
   	</c:if>
   	nullInputCheck();
   	<c:if test="${not empty itemSpec.itemNo}">
   	item_create[3]=$('#item_create_3').serialize();
   	</c:if>
});
    </script>