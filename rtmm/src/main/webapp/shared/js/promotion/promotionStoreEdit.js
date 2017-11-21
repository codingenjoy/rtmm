var unit=new Array(); //定义全局数组 保存代号 商品信息
Array.prototype.del=function(n){
	if(n<0)
	return this;
	else
	return this.slice(0,n).concat(this.slice(n+1,this.length));
	};
$(function(){
	top.grid_layer_close();
});
/*时间验证*/
function checkTime(promBeginDate,promEndDate,buyBeginDate,buyEndDate,beforePromBeginDate,beforeBuyBeginDate,beforeBuyEndDate)
    {
          var buyBeginFlag=$("#buyBegin").val();
          var sellBeginFlag=$("#sellBegin").val();
          $("#promEndDate").removeClass("errorInput");
    	  $("#promBeginDate").removeClass("errorInput");
    	  $("#buyEndDate").removeClass("errorInput");
    	  $("#buyBeginDate").removeClass("errorInput");
    	  $("#buyBeginDate").attr("title","");
    	  $("#buyEndDate").attr("title","");
    	  $("#promBeginDate").attr("title","");
    	  $("#promEndDate").attr("title","");
    	  if(promBeginDate==''&&promEndDate==''&&buyBeginDate==''&&buyEndDate=='')
  		  {
    		  var tip="采购期间促销期间至少一个不能为空！";
    		  $("#promEndDate").addClass("errorInput");
    		  $("#promBeginDate").addClass("errorInput");
    		  $("#buyEndDate").addClass("errorInput");
    		  $("#buyBeginDate").addClass("errorInput");
    		  $("#buyBeginDate").attr("title",tip);
    		  $("#buyEndDate").attr("title",tip);
    		  $("#promBeginDate").attr("title",tip);
    		  $("#promEndDate").attr("title",tip);
  		      return false;
  		 }
  	    else if(promBeginDate!=''&&promEndDate=='')
  		 {
  		     $("#promEndDate").addClass("errorInput");
			 $("#promEndDate").attr("title","请输入促销结束时间！");
  		     return false;
  		 }
  	     else if(promBeginDate==''&&promEndDate!=''){
		      $("#promBeginDate").addClass("errorInput");
			  $("#promBeginDate").attr("title","请输入促销开始时间！");
		      return false;
		     }
  	     else if(buyBeginDate!=''&&buyEndDate==''){
		      $("#buyEndDate").addClass("errorInput");
			  $("#buyEndDate").attr("title","请输入采购结束时间！");
		      return false;
		   }
	      else if(buyBeginDate==''&&buyEndDate!=''){
		      $("#buyBeginDate").addClass("errorInput");
			  $("#buyBeginDate").attr("title","请输入采购开始时间！");
		      return false;
		     }
		   var promNo=$("#promNo").val();
    	  var flag=true;
    	  $.ajax({
    		    async:false,
		    	url: ctx + '/prom/nondm/store/checkUpdateTime?buyDateStart='+buyBeginDate+'&buyDateEnd='+buyEndDate+'&promDateStart='+promBeginDate+'&buyBeginFlag='+buyBeginFlag+'&sellBeginFlag='+sellBeginFlag+'&promDateEnd='+promEndDate+'&beforePromBeginDate='+beforePromBeginDate+'&beforeBuyBeginDate='+beforeBuyBeginDate+'&beforeBuyEndDate='+beforeBuyEndDate+'&promNo='+promNo+'&ti='+(new Date()).getTime(),
				type: "post",
				dataType:"json",
				success: function(result) {
				    if(result.message!=null && result.message !="success"){
				    	if(result.key=='1'){
				    		$("#buyBeginDate").addClass("errorInput");
							$("#buyBeginDate").attr("title",result.message);
							//$("#buyBeginDate").focus();
				    	}
				    	if(result.key=='2'){
				    		$("#buyEndDate").addClass("errorInput");
							$("#buyEndDate").attr("title",result.message);
							//$("#buyEndDate").focus();
				    	}
				    	if(result.key=='3'){
				    		$("#promBeginDate").addClass("errorInput");
							$("#promBeginDate").attr("title",result.message);
							//$("#promBeginDate").focus();
				    	}if(result.key=='4'){
				    		$("#promEndDate").addClass("errorInput");
							$("#promEndDate").attr("title",result.message);
							//$("#promEndDate").focus();
				    	}
				    	flag=false;
				    }    	
				}
		    });
    	  return flag;
  }
/*时间变化验证*/
function checkChangeTime(){
	var promBeginDate=$("#promBeginDate").val();
	var promEndDate=$("#promEndDate").val();
	var buyBeginDate=$("#buyBeginDate").val();
	var buyEndDate=$("#buyEndDate").val();
	var beforePromBeginDate=$("#beforePromBeginDate").val();
	var beforeBuyBeginDate=$("#beforeBuyBeginDate").val();
	var beforeBuyEndDate=$("#beforeBuyEndDate").val();
	checkTime(promBeginDate,promEndDate,buyBeginDate,buyEndDate,beforePromBeginDate,beforeBuyBeginDate,beforeBuyEndDate);
	
  }
/*检查主题*/
function checkSubjName(){
	var subjName=$("#subjName").val();
	$("#subjName").removeClass('errorInput');
	$("#subjName").attr("title",'');
 	if($.trim(subjName)=='')
	{
	  $("#subjName").addClass('errorInput');
	  $("#subjName").attr("title",'请输入主题!');
	}
 	else if(charLen($.trim(subjName))>30){
 		$("#subjName").addClass('errorInput');
 		$("#subjName").attr("title",'主题不能超过30个字节!');
 	}
 }
/*促销类型的显示规则*/
function getPromoType(){//buyTimeStart//promTimeStart
	var buyts = $("#buyBeginDate").val();
	var buyte = $("#buyEndDate").val();
	var promts= $("#promBeginDate").val();
	var promte= $("#promEndDate").val();

	var timeType = $(this).attr("ttype");
	var buyBegin = $('#buyBegin').val();
	var sellBegin = $('#sellBegin').val();
	if(timeType =='buy'&&(promts =="" && promte=="")){
		$("#pricePromTypeName").val("2-仅进价促销");
		$("#pricePromType").val("2");
		if(buyBegin!=1){
		$(".promBuyPriceHead").removeAttr('disabled');
    	$(".promBuyPriceBody").removeAttr('disabled');
    	$(".promBuyPriceHead").removeClass('Black');
    	$(".promBuyPriceBody").removeClass('Black');
    	$("input[name='promBuyPrice']").each(function(){
    		$(this).removeAttr('disabled');
    		$(this).removeClass('Black');
    	});
		}
		if(this.value>$dp.$('buyEndDate').value)
    	{
    		$dp.$('buyEndDate').value='';
    		$dp.$('buyEndDate').focus();
    	}
	}
	if((timeType =='buy' && (promts!="" || promte!="")) || (timeType =='prom' && (buyts!="" || buyte!=""))){
	    $("#pricePromTypeName").val("1-进-售价促销");
	    $("#pricePromType").val("1");
	    if(buyBegin!=1){
	    	$(".promBuyPriceHead").removeAttr('disabled');
	    	$(".promBuyPriceBody").removeAttr('disabled');
	    	$(".promBuyPriceHead").removeClass('Black');
	    	$(".promBuyPriceBody").removeClass('Black');
	    	$("input[name='promBuyPrice']").each(function(){
	    		$(this).removeAttr('disabled');
	    		$(this).removeClass('Black');
	    	});
	    }
	    if(sellBegin!=1){
	    	$(".promSellPriceHead").removeAttr('disabled');
	    	$(".promSellPriceBody").removeAttr('disabled');
	    	$(".promSellPriceHead").removeClass('Black');
	    	$(".promSellPriceBody").removeClass('Black');
	    	$("input[name='promSalePrice']").each(function(){
	    		$(this).removeAttr('disabled');
	    		$(this).removeClass('Black');
	    	});
	    }
	    
		if(this.name=='buyBeginDate'){
			  if(this.value>$dp.$('buyEndDate').value)
	    	  {
	    		$dp.$('buyEndDate').value='';
	    		$dp.$('buyEndDate').focus();
	    	  }
		}
		if(this.name=='promBeginDate'){
			if(this.value>$dp.$('promEndDate').value)
	    	  {
	    		$dp.$('promEndDate').value='';
	    		$dp.$('promEndDate').focus();
	    	  }
		}
		
	}
	if(timeType =='prom' && (buyts=="" && buyte=="")){
		$("#pricePromTypeName").val("3-仅售价促销");
		$("#pricePromType").val("3");
		if(sellBegin!=1){
		$(".promSellPriceHead").removeAttr('disabled');
    	$(".promSellPriceBody").removeAttr('disabled');
    	$(".promSellPriceHead").removeClass('Black');
    	$(".promSellPriceBody").removeClass('Black');
    	$("input[name='promSalePrice']").each(function(){
    		$(this).removeAttr('disabled');
    		$(this).removeClass('Black');
    	});
    	if(this.value>$dp.$('promEndDate').value)
    	{
    		$dp.$('promEndDate').value='';
    		$dp.$('promEndDate').focus();
    	}
		}
	}
	checkChangeTime();
}
/* 屏蔽backspace、F5,F4为刷新 */
document.onkeydown = function(e) {
	var e = e || window.event || arguments.callee.caller.arguments[0];
	var d = e.srcElement || e.target;
	if (e.keyCode && e.keyCode == 115) {
		e.keyCode=0;
		e.returnValue=false;
		$('#forwardForm').submit();
		return false;
	}
	if (e.keyCode && e.keyCode == 116) {
		e.keyCode=0;
		return false;
	}
	if (e && e.keyCode == 8) {
		if(d.tagName.toUpperCase() == 'INPUT' && d.readOnly == true){
			return false;
		}else if(d.tagName.toUpperCase() == 'INPUT' || d.tagName.toUpperCase() == 'TEXTAREA'){
			return true;	
		}else{
			return false;
		}
	}
};
$(function() {
		$("#Tools2").removeClass("Tools2_disable");
		$("#Tools2").addClass("Icon-size1 Tools2");
		$(".pro_store_tb").scroll(function () {
             var left = $(this).scrollLeft();
             $(".zt_tit").scrollLeft(left);
        });
		
		$(".pstb_del2,.pstb_del").die("click");
		
		$("#storeNo").unbind("focus").bind("focus", function() {
			$("#storeNo").removeClass("errorInput");
			$("#storeNo").attr("title",'');
		});

		$("#subjName").unbind("focus").bind("focus", function() {
			$("#subjName").removeClass("errorInput");
			$("#subjName").attr("title",'');

		});
		
		$("#catlgId").unbind("focus").bind("focus", function() {
			$("#catlgId").removeClass("errorInput");
			$("#catlgId").attr("title",'');

		});
		$("#Tools2").unbind("click").bind("click",updateItemStoreInfo);
});
/*保存商品门店信息*/
function updateItemStoreInfo(){
	top.grid_layer_open();
	var promNo=$("#promNo").val();
	var promSubjId=$("#promSubjId").val();
	var storeNo=$("#storeNo").val();
	var error=0;
	if(storeNo==''||storeNo==undefined)
	{
	   $("#storeNo").removeClass().addClass('w60 top3 errorInput');
	   $("#storeNo").attr("title",'请选择店号!');
       error++;
    }
	var subjName=$.trim($("#subjName").val());
	if(subjName=='')
	{
	   $("#subjName").removeClass().addClass(
		'inputText w50 errorInput');
	   $("#subjName").attr("title",'请输入主题!');
       error++;
    }
	else if(charLen(subjName)>30){
 		$("#subjName").addClass('errorInput');
 		$("#subjName").attr("title",'主题不能超过30个字节!');
 		error++;
 	}
	var catlgId=$("#catlgId").val();
	if($.trim(catlgId)=='')
	{
		$("#catlgId").removeClass().addClass('w70 errorInput');
		$("#catlgId").attr("title",'请选择课别!');
		error++;
    }
	var promBeginDate=$("#promBeginDate").val();
	var promEndDate=$("#promEndDate").val();
	var buyBeginDate=$("#buyBeginDate").val();
	var buyEndDate=$("#buyEndDate").val();
	var beforePromBeginDate=$("#beforePromBeginDate").val();
	var beforeBuyBeginDate=$("#beforeBuyBeginDate").val();
	var beforeBuyEndDate=$("#beforeBuyEndDate").val();
	if(!checkTime(promBeginDate,promEndDate,buyBeginDate,buyEndDate,beforePromBeginDate,beforeBuyBeginDate,beforeBuyEndDate))
	{
		error++;
		top.grid_layer_close();
		return;
	}
	if(error>0)
	{
		top.grid_layer_close();
	    return;
	}
	if(unit.length==0)
		{
		top.jAlert('warning', '代号信息不能为空!', '提示消息');
		top.grid_layer_close();
		return;
		}
	var pricePromType=$("#pricePromType").val();
	var comma = "--";
	var bracket_left = "{";
	var bracket_right = "}";

	//促销信息
	var promSchedule= bracket_left+'"storeNo":\"' + storeNo + '\",'+'"promNo":\"' + promNo + '\",'+'"catlgId":\"' + catlgId + '\",'+'"buyBeginDate":\"'+buyBeginDate+'\",'+'"buyEndDate":\"'+buyEndDate+'\",'+
	    '"promBeginDate":\"'+promBeginDate+'\",'+ '"promEndDate":\"'+promEndDate+'\",'+'"pricePromType":\"'+pricePromType+'\"'+bracket_right;
	//主题信息
	subjName = subjName.replace(">", "&gt;");
	subjName = subjName.replace("\"", "&quot;");  
	subjName = subjName.replace("<", "&lt;");
	subjName = subjName.replace("\'", "&#39;"); 
	var subject=bracket_left+'"promSubjId":"' + promSubjId + '",'+'"subjName":"' + subjName + '"'+bracket_right;
	//代号数组
	var promUnitSt=[];
	//商品数组
	var promItem=[];
	for (var i = 0; i < unit.length; i++) {
		var json=unit[i];
		promUnitSt.push(bracket_left+'"unitType":"' + json.unitType + '",'+'"promUnitNo":"' + json.promUnitNo + '",'+'"promActvy":"' + json.promActvy + '",'+'"promGiftHint":"' + json.promGiftHint + '",'+'"catlgId":"' + catlgId + '"'+bracket_right);
		if(json.itemArr.length==0)
		{
		   top.jAlert('warning','代号'+json.promUnitNo+'下促销商品门店信息为空!', '提示消息');
    	   top.grid_layer_close();
		   return;
		}
		for (var j = 0; j < json.itemArr.length; j++) {
		   var itemJson=json.itemArr[j];
		   if(itemJson.promBuyPrice==''&&buyBeginDate!='')
			  {
			   if(itemJson.status<=5&&itemJson.buyMethd !=2&&itemJson.prcssType!=2&&itemJson.prcssType!=4&&itemJson.prcssType!=5){
			   top.jAlert('warning', '采购期间已经设置，代号'+json.promUnitNo+'下有商品门店促销进价为空!', '提示消息');
	    		   top.grid_layer_close();
			   return;
			   }else{
				   itemJson.promBuyPrice='0';
			   }
			  }
		   else if(itemJson.promBuyPrice=='')
			   {
			   itemJson.promBuyPrice='0';
			   }
		   if(itemJson.promSellPrice==''&&promBeginDate!='')
			  {
			   top.jAlert('warning', '促销期间已经设置，代号'+json.promUnitNo+'下有商品门店促销售价为空!', '提示消息');
	    		   top.grid_layer_close();
			   return;
			  }
		   else if(itemJson.promSellPrice=='')
			  {
			   itemJson.promSellPrice='0';
			  }
		   var itemStr=bracket_left+'"promSupNo":"' + itemJson.promSupNo + '",'+'"storeNo":"' + storeNo + '",'+'"itemNo":"' + itemJson.itemNo + '",'+'"unitType":"' + json.unitType + '",'+'"promUnitNo":"' + json.promUnitNo + '",'+
		   '"normBuyPrice":"' + itemJson.normalBuyPrice + '",'+'"normSellPrice":"' + itemJson.normalSalePrice + '",'+'"promBuyPrice":"' + itemJson.promBuyPrice + '",'+'"promSellPrice":"' + itemJson.promSellPrice + '"'+bracket_right;
		   promItem.push(itemStr);
		}
	}
	if(promItem.length==0)
	{
	top.jAlert('warning', '促销商品门店信息不能为空!', '提示消息');
	top.grid_layer_close();
	return;
	}
	//修改促销门店信息
	$.ajax({
		//async : false,
		url : ctx + '/prom/nondm/store/promotionItemEdit?ti='+(new Date()).getTime(),
		data : {'promSchedule':promSchedule,'subject':subject,'promUnitSt':promUnitSt.join(comma),'promItem':promItem.join(comma)},
		type : 'POST',
		success : function(response) {
    		top.grid_layer_close();
			var mes=response["message"];
			if(mes=='true')
			{
			top.jAlert('success', '保存成功', '提示消息',function(){
		    			//window.location.href=ctx + '/prom/nondm/store/edit?&promNo='+promNo;
			 });
			}
			else
			{
				top.jAlert('warning', mes, '提示消息');
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
    		top.grid_layer_close();
			top.jAlert('error', '网络超时!请稍后重试', '提示消息');
		}
	});
	
}
/*代号弹出框*/
function showUnitWin(obj){
	var unitWin=$(obj);
	 var itemNo=unitWin.parent().find("input[name='promUnitNo']").val();
     if(!validateItemPrice(itemNo,$(this).parent().parent().attr('class'))){
   	  return;
     }
   	var unitType =unitWin.parent().parent().find("select").val();
   	var catlgId = $("#catlgId").val();
   	var storeNo=$("#storeNo").val();
   	var pricePromType=$("#pricePromType").val();
    if(storeNo==''){
		 top.jAlert('warning', '请选择门店!', '提示消息');
		 return;
	}
   	if(catlgId==''){
		 top.jAlert('warning', '请选择课别!', '提示消息');
		 return;
	}
   	if(unitType==''){
		 top.jAlert('warning', '请选择代号类别!', '提示消息');
		 unitWin.parent().parent().find("input[name='promUnitNo']").val('');
		 return;
	}
   	 var itemArr=new Array();
   	 for (var i = 0; i < unit.length; i++) {
		       var unitJson=unit[i];
		       if(unitJson.unitType==unitType&&itemNo==unitJson.promUnitNo){
		    	var itemJsonArr=unitJson.itemArr;
		        for(var j = 0; j < itemJsonArr.length; j++){
			        var itemJson=itemJsonArr[j];
			        itemArr.push(itemJson.itemNo);
		        }
   	       }
        }
	if(!checkOrderIsUseCommom(itemArr,31)){
		return;
	}
   	 var promUnitNoCondition =unitWin.parent().parent().find("input[name='promUnitNo']").val();
  	 var beforePromUnitNo=unitWin.parent().parent().find("input[name='beforePromUnitNo']");
   	 if(promUnitNoCondition!=$.trim(beforePromUnitNo.val()))
	    	{
	    	 // 清除之前代号数组
	  	      for (var i = 0; i < unit.length; i++) {
					       var unitJson=unit[i];
						    if(unitJson.unitType==unitType&&unitJson.promUnitNo==$.trim(beforePromUnitNo.val()))
						    	   {
						    	      unit=unit.del(i);
						    	      i=-1;
						    	   }
	  	      }
		 }
     top.openPopupWin(800,450, '/prom/nondm/store/showUnitWin?unitType='+unitType+'&catlgId='+catlgId+'&pricePromType='+pricePromType+'&storeNo='+storeNo);
}
/*代号弹出框返回数据*/    	
function addStoreGrpTypeReturn(unitNo,unitName,storeItemList){
	var unitType=$(".item_on").find("select[name='unitType']");
	var promUnitNo=$(".item_on").find("input[name='promUnitNo']");
	var beforePromUnitNo=$(".item_on").find("input[name='beforePromUnitNo']");
	if($.trim(unitNo)==$.trim(beforePromUnitNo.val())){
	    top.jAlert('warning', '该代号已经添加，请重新选择代号！', '提示消息');
	    return;
	}
	$(".promSellPriceBody").val("");
	$(".promBuyPriceBody").val("");
	$(".item_on").find(".promSellPriceHead").val("");
	$(".item_on").find(".promBuyPriceHead").val("");
	if (unitNo != undefined){
		$(".zt_tit").scrollLeft(0);
		$(".pro_store_tb").scrollLeft(0);
		$(".item_on").find("input[name='promUnitNo']").val(unitNo);
		$(".item_on").find("input[name='promUnitName']").val(unitName);
		//var pricePromType=$("#pricePromType").val();
		if(unitNo!=''&&unitNo!=undefined)
			{
	    	  var storeNo=$("#storeNo").val();
	    	  var catlgId = $("#catlgId").val();
	    	  var promActvy=$(".item_on").find("select[name='promActvy']").val();
	    	  var promGiftHint=$(".item_on").find("input[name='promGiftHint']").val();
	    	  if($.trim(promUnitNo.val())!=$.trim(beforePromUnitNo.val()))
	  	      {
  	    	  // 清除之前代号数组
  	  	        for (var i = 0; i < unit.length; i++) {
		        var unitJson=unit[i];
			    if(unitJson.unitType==unitType.val()&&unitJson.promUnitNo==$.trim(beforePromUnitNo.val()))
			     {
			    	      unit=unit.del(i);
			    	      i=-1;
			      }
  			   }
	  	  	  if(!checkHasOne(unitType.val(),$.trim(promUnitNo.val())))
			  {
			    $(".item_on").find("input[name='promUnitNo']").val("");
			    $(".item_on").find("input[name='promUnitName']").val("");
			    top.jAlert('warning', '该代号已经添加，请重新选择代号！', '提示消息');
			    return;
			  }
	  	  	 if(unitType.val()==0&&$.trim(promUnitNo.val())!=$.trim(beforePromUnitNo.val())){
		  	      if(!checkHasItemNo($.trim(promUnitNo.val()))){
		  	    	var returnUnitNo=returnHasItemNoUnit($.trim(promUnitNo.val()));
	    	        promUnitNo.val("");
			        promUnitNo.parent().parent().find("input[name='promUnitName']").val("");
		            top.jAlert('warning', '该商品已经存在已添加的'+returnUnitNo+'代号中！', '提示消息');
		 		    return;
		  	      }
		    	 }
	  	    	  beforePromUnitNo.val($.trim(promUnitNo.val()));
	
	  	    	}
	    	  
	    	  if(unitType&&catlgId&&promUnitNo)
	    		  {
	    		    if(!storeNo||$.trim(storeNo)=='')
	    		    	{
	    		    	     top.jAlert('warning', '请选择门店', '提示消息');
	    		    	     return;
	    		    	}
	    		    if($.trim(unitType.val())=='')
	    		    	{
	    		    	 top.jAlert('warning', '请选择代号类别', '提示消息');
	    		    	 promUnitNo.val('');
			    	     return;
	    		    	}
	    		    if($.trim(promUnitNo.val())=='')
			    	 {
			    	 top.jAlert('warning', '请选择代号', '提示消息');
		    	     return;
			    	 }
	    		    var  len=unit.length;
	    		    for(var j=0;j<unit.length;j++)
	    		    {
    		    	  var json=unit[j];
    		    	  if(json.unitType==unitType.val()&&json.promUnitNo==$.trim(promUnitNo.val())){
    		    		 len=j;
    		    	  }
	    		    }
	    			var data=storeItemList;
	    			var dataArr=JSON.parse(storeItemList);
	    			$(".pro_store_tb").html("");
	    			var itemArr=new Array();
	    			if(data==null)
	    			{
	    				$(".item_on").find("input[name='promUnitNo']").val("");
	    				$(".item_on").find("input[name='promUnitName']").val("");
	    				beforePromUnitNo.val("");
	    				top.jAlert('warning', '该代号下不存在符合门店促销的商品，请重新选择代号！', '提示消息');
	    	    		top.closePopupWin();
	    				return;
	    			}
	    			data=JSON.parse(data);
	    			for(var i=0;i<data.length;i++)
	    			{
	    				var promBuyPrice='';
	    				if(data[i].promBuyPrice!=null)
	    					{
	    					promBuyPrice=data[i].promBuyPrice;
	    					}
	    				var promSellPrice='';
	    				if(data[i].promSellPrice!=null)
	    					{
	    					promSellPrice=data[i].promSellPrice;
	    					}
	    				if(!checkHasItemNo(data[i].itemNo))
	    				  {
	    					 for(var n=0;n<dataArr.length;n++){
	    						  if(data[i].itemNo==dataArr[n].itemNo)
						    	   {
	    							  dataArr=dataArr.del(n);
						    	      n=-1;
						    	   }
	    					 }
	    					continue;
	    				  }
	    				var itemJson={'itemNo':data[i].itemNo,'itemName':data[i].itemName,'mainComName':data[i].mainComName,'promSupNo':data[i].stMainSupNo,'normalBuyPrice':data[i].normBuyPrice,'promBuyPrice':promBuyPrice,'normalSalePrice':data[i].normSellPrice,'promSellPrice':promSellPrice,'buyPriceLimit':data[i].buyPriceLimit,'buyWhen':data[i].buyWhen,'netCost':data[i].netCost,'vatVal':data[i].vatVal,'status':data[i].status,'buyMethd':data[i].buyMethd,'prcssType':data[i].prcssType,'priceRange':"",'netProfit':"",'headMinMargin':data[i].headMinMargin,'branchMinMargin':data[i].branchMinMargin};
	    		
    		    	 itemArr.push(itemJson);
	    			}
	    			var  unitJson={'unitType':unitType.val(),'promUnitNo':$.trim(promUnitNo.val()),'promActvy':promActvy,'promGiftHint':promGiftHint,'itemArr':itemArr};
	    			if(dataArr.length==0){
	    				top.jAlert('warning', '该代号下的商品已经全部添加，请重新选择代号！', '提示消息');
	    				$(".item_on").find("input[name='promUnitNo']").val('');
	    				$(".item_on").find("input[name='promUnitName']").val('');
	  	  	    	    beforePromUnitNo.val("");
                        return;
	    			}
	    			unit[len]=unitJson;
	    			$.ajax({
	    				//async : false,
	    				type : 'post',
	    				url : ctx + '/prom/nondm/store/getPromItemStoreList',
	    				data : {'storeItemJs':JSON.stringify(dataArr),'pricePromType':$("#pricePromType").val()},
	    				success : function(storeItemData) {
	    					$(".pro_store_tb").html(storeItemData);
	    				}
	    		     });		
	    		  }
			}
	}
	top.closePopupWin();
}
/*门店变化清空代号 促销商品信息*/
function changStore()
{
  $("#unitNoList").html("");
  $(".pro_store_tb").html("");
  unit=[];
}
/*添加代号*/
function addUnitItem()
{
    var buyBegin = $('#buyBegin').val();
    var sellBegin = $('#sellBegin').val();
	if (buyBegin == '1') {
		top.jAlert('warning', '促销进价已经开始,不能添加代号信息!', '提示消息');
		return;
	}
	if (sellBegin == '1') {
		top.jAlert('warning', '促销售价已经开始,不能添加代号信息!', '提示消息');
		return;
	}
	var storeNo = $("#storeNo").val();
	var error = 0;
	if(storeNo==''||storeNo==undefined)
	{
	   $("#storeNo").removeClass().addClass('w60 top3 errorInput');
	   $("#storeNo").attr("title",'请选择店号!');
       error++;
    }
	var subjName=$("#subjName").val();
	
	if($.trim(subjName)=='')
	{
	   $("#subjName").removeClass().addClass('inputText w50 errorInput');
	   $("#subjName").attr("title",'请输入主题!');
       error++;
    }
	
	var catlgId=$("#catlgId").val();
	if($.trim(catlgId)=='')
	{
		$("#catlgId").removeClass().addClass('w70 errorInput');
		$("#catlgId").attr("title",'请选择课别!');
		error++;
    }
	var promBeginDate=$("#promBeginDate").val();
	var promEndDate=$("#promEndDate").val();
	var buyBeginDate=$("#buyBeginDate").val();
	var buyEndDate=$("#buyEndDate").val();
	var beforePromBeginDate=$("#beforePromBeginDate").val();
	var beforeBuyBeginDate=$("#beforeBuyBeginDate").val();
	var beforeBuyEndDate=$("#beforeBuyEndDate").val();
	if(!checkTime(promBeginDate,promEndDate,buyBeginDate,buyEndDate,beforePromBeginDate,beforeBuyBeginDate,beforeBuyEndDate))
	{
		error++;
		return;
	}
    var itemNo=$(".item_on").find("input[name='promUnitNo']").val();
    for (var i = 0; i < unit.length; i++) {
	    
    		var json=unit[i];
    		if(itemNo==json.promUnitNo){
    		if(json.itemArr.length==0)
    		{
    		   top.jAlert('warning','代号'+json.promUnitNo+'下促销商品门店信息为空!', '提示消息');
    		   error++;
    		   return;
    		}
    		for (var j = 0; j < json.itemArr.length; j++) {
	    		   var itemJson=json.itemArr[j];
	    		   if(itemJson.promBuyPrice==''&&buyBeginDate!='')
	    			  {
	    			   $(".pro_store_tb").find("input[name='promBuyPrice']").each(function() {
	    				   if($(this).val()==""&&$(this).attr("disabled")!="disabled"){
	    					   $(this).removeClass("errorInput").addClass('errorInput');
	    					   $(this).attr("title", '促销进价不能为空且必须是不能超过四位小数的数字!');
	    					   error++;
	    				   }else{
	    					   $(this).removeClass("errorInput");
	    					   $(this).attr("title", '');
	    				   }
	    			   });
	    			  }
	    		 
	    		   if(itemJson.promSellPrice==''&&promBeginDate!='')
	    			  {
	    			   $(".pro_store_tb").find("input[name='promSalePrice']").each(function() {
	    				   if($(this).val()==""&&$(this).attr("disabled")!="disabled"){
	    					   $(this).removeClass("errorInput").addClass('errorInput');
	    					   $(this).attr("title", '促销售价不能为空且必须是不能超过两位小数的数字!');
	    					   error++;
	    				   }else{
	    					   $(this).removeClass("errorInput");
	    					   $(this).attr("title", '');
	    				   }
	    			   });
	    			  }
	    	}
    		if($(this).attr('class')!='item item_on'){
    		for (var j = 0; j < json.itemArr.length; j++) {
    		   var itemJson=json.itemArr[j];
    		   if(itemJson.promBuyPrice==''&&buyBeginDate!='')
    			  {
    			   if(itemJson.status<=5&&itemJson.buyMethd !=2&&itemJson.prcssType!=2&&itemJson.prcssType!=4&&itemJson.prcssType!=5){
    			   top.jAlert('warning', '采购期间已经设置，代号'+json.promUnitNo+'下有商品门店促销进价为空!', '提示消息');
	    		   error++;
    			   return;
    			   }
    			  }
    		 
    		   if(itemJson.promSellPrice==''&&promBeginDate!='')
    			  {
    			   top.jAlert('warning', '促销期间已经设置，代号'+json.promUnitNo+'下有商品门店促销售价为空!', '提示消息');
	    		   error++;
    			   return;
    			  }
    		   
    		  }
    		}
		}
      }
       if(error>0)
       {
        return;
       }
	  $(".pro_store_tb").html("");
	  $("#unitNoList").append(($(".cloneDiv").find("#addPromCode_div")).clone());
	  $("#unitNoList").find(".item:last").click();
	  $(".pro_store_tb_edit").scrollTop($(".pro_store_tb_edit")[0].scrollHeight+30);
}
      
function unitTypeChange(obj){
  var unitTypeObj=$(obj);
  var promUnitNo=unitTypeObj.parent().find("input[name='promUnitNo']").val();
  var itemArr=new Array();
  $("input[name='promBuyPrice']").each(function(){
	  var itemNo = $(this).parent().find("input[name='itemNo']").val();
	  itemArr.push(itemNo);
  });
  
  if(itemArr.length>0){
	  if(!checkOrderIsUseCommom(itemArr,32)){
		  var unitType="";
		   for (var i = 0; i < unit.length; i++) {
		       var unitJson=unit[i];
			    if(unitJson.promUnitNo==promUnitNo)
			      {
			    	unitType=unitJson.unitType;
			       }
	       }
		   unitTypeObj.find("option[value='"+unitType+"']").attr("selected",true);
	  return;
 }
  }
  // 清除代号数组
 for (var i= 0; i < unit.length; i++) {
        var unitJson=unit[i];
	    if(unitJson.promUnitNo==promUnitNo)
	    {
	    	      unit=unit.del(i);
	    }
	  }
   $(".promSellPriceBody").val("");
   $(".promBuyPriceBody").val("");
   unitTypeObj.parent().find(".promSellPriceHead").val("");
   unitTypeObj.parent().find(".promBuyPriceHead").val("");
   unitTypeObj.parent().find("input[name='promUnitNo']").val("");
   unitTypeObj.parent().find("input[name='promUnitName']").val("");
   $(".pro_store_tb").html("");
}
/*代号框失去焦点事件 查询代号门店信息*/
function promUnitNoBlur(obj){
	$(".zt_tit").scrollLeft(0);
	$(".pro_store_tb").scrollLeft(0);
	var itemNo=$(obj).parent().find(".item_on").find("input[name='promUnitNo']").val();
    if(!validateItemPrice(itemNo,$(obj).parent().parent().attr('class'))){
  	  return;
    }
   
  	
	  //var buyBegin=$('#buyBegin').val();
 	  //var sellBegin=$('#sellBegin').val();
	  var unitType=$(obj).parent().parent().find("select[name='unitType']");
	  var promUnitNo=$(obj);
	  var promActvy=$(obj).parent().parent().find("select[name='promActvy']").val();
	  var promGiftHint=$(obj).parent().parent().find("input[name='promGiftHint']").val();
	  var storeNo=$("#storeNo").val();
	  var catlgId = $("#catlgId").val();
	  var beforePromUnitNo=$(obj).parent().parent().find("input[name='beforePromUnitNo']");
	  var pricePromType=$("#pricePromType").val();
	  var itemArr=new Array();
	  $("input[name='promBuyPrice']").each(function(){
		  var itemNo = $(this).parent().find("input[name='itemNo']").val();
		  itemArr.push(itemNo);
	  });
	 
	  if(itemArr.length>0&&$.trim(promUnitNo.val())!=$.trim(beforePromUnitNo.val())){
		  if(!checkOrderIsUseCommom(itemArr,31)){
			  promUnitNo.val($.trim(beforePromUnitNo.val()));
  		      return;
  		}
	 /* if(!checkPromIsInOrder(false,itemArr.join(","))){
		    promUnitNo.val($.trim(beforePromUnitNo.val()));
			top.jAlert('warning', '存在没有作废的订单使用了该促销期数下的商品，不能修改代号!', '提示消息');
			return;
		}*/
	  }
	  if($.trim(promUnitNo.val())==$.trim(beforePromUnitNo.val())){
		  promUnitNo.val($.trim(promUnitNo.val()));
		  return;
	  }
	
    if($.trim(promUnitNo.val())!=$.trim(beforePromUnitNo.val()))
  	{
  	   $(".promSellPriceBody").val("");
	       $(".promBuyPriceBody").val("");
	       $(this).parent().parent().find(".promSellPriceHead").val("");
	       $(this).parent().parent().find(".promBuyPriceHead").val("");
  	       // 清除之前代号数组
	      for (var i = 0; i < unit.length; i++) {
				       var unitJson=unit[i];
					    if(unitJson.unitType==unitType.val()&&unitJson.promUnitNo==$.trim(beforePromUnitNo.val()))
					    	   {
					    	      unit=unit.del(i);
					    	      i=-1;
					    	   }
			  }
	  if(!checkHasOne(unitType.val(),$.trim(promUnitNo.val())))
	  {
        promUnitNo.val("");
		promUnitNo.parent().parent().find("input[name='promUnitName']").val("");
		$(".promSellPriceBody").val("");
	  	$(".promBuyPriceBody").val("");
	  	promUnitNo.parent().parent().find(".promSellPriceHead").val("");
	  	promUnitNo.parent().parent().find(".promBuyPriceHead").val("");
	  	$(".pro_store_tb").html("");
	    top.jAlert('warning', '该代号已经添加，请重新选择代号！', '提示消息');
	    return;
	  }
	 if(unitType.val()==0&&$.trim(promUnitNo.val())!=$.trim(beforePromUnitNo.val())){
	  	      if(!checkHasItemNo($.trim(promUnitNo.val()))){
	  	    	var returnUnitNo=returnHasItemNoUnit($.trim(promUnitNo.val()));
	  	    	promUnitNo.val("");
	 			promUnitNo.parent().parent().find("input[name='promUnitName']").val("");
	 			$(".promSellPriceBody").val("");
		    	$(".promBuyPriceBody").val("");
		    	promUnitNo.parent().parent().find(".promSellPriceHead").val("");
		    	promUnitNo.parent().parent().find(".promBuyPriceHead").val("");
		    	beforePromUnitNo.val("");
		    	$(".pro_store_tb").html("");
	 		    top.jAlert('warning', '该商品已经存在已添加的'+returnUnitNo+'代号中！', '提示消息');
	 		    return;
	  	      }
	    	 }
  	  beforePromUnitNo.val($.trim(promUnitNo.val()));
  	}
	    if($.trim(promUnitNo.val())=='')
	  	{
			 promUnitNo.val("");
			 promUnitNo.parent().parent().find("input[name='promUnitName']").val("");
			 $(".promSellPriceBody").val("");
	  	     $(".promBuyPriceBody").val("");
	  	     promUnitNo.parent().parent().find(".promSellPriceHead").val("");
	  	     promUnitNo.parent().parent().find(".promBuyPriceHead").val("");
	  	     $(".pro_store_tb").html("");
	  	     beforePromUnitNo.val('');
	         return;
	  	};
	  	if(!isNumber(promUnitNo.val()))
	  	{
	  	  promUnitNo.val("");
		  promUnitNo.parent().parent().find("input[name='promUnitName']").val("");
		  $(".promSellPriceBody").val("");
	  	  $(".promBuyPriceBody").val("");
	  	  promUnitNo.parent().parent().find(".promSellPriceHead").val("");
	  	  promUnitNo.parent().parent().find(".promBuyPriceHead").val("");
	  	  $(".pro_store_tb").html("");
	  	  beforePromUnitNo.val('');
		  top.jAlert('warning', '输入代号必须为数字', '提示消息');
	      return;
	  	};
		    var  len=unit.length;
		    var flag=false;
		    for(var j=0;j<unit.length;j++)
		    {
		    	  var json=unit[j];
		    	  if(json.unitType==unitType.val()&&json.promUnitNo==$.trim(promUnitNo.val())){
		    		 flag=true;
		    		 len=j;
		    	  }
		    }
		    
		    if(!flag){
		    	$.ajax({
		    		//async : false,
		    		url : ctx + '/prom/nondm/store/getPromItemStoreSupplier?ti='+(new Date()).getTime(),
		    		data : {'storeNo':storeNo,'catlgId':catlgId,'clstrId':$.trim(promUnitNo.val()),'unitType':unitType.val(),'pricePromType':pricePromType},
		    		type : 'POST',
		    		success : function(response) {
		    			$(".pro_store_tb").html("");
		    			var data=response['row'];
		    			var dataArr=JSON.parse(data);
		    			var unitName=response['unitName'];
		    			if(data==null)
		    				{
		    				 promUnitNo.val("");
		    		 	     promUnitNo.parent().parent().find("input[name='promUnitName']").val("");
		    		 	    $(".promSellPriceBody").val("");
		    		    	$(".promBuyPriceBody").val("");
		    		    	promUnitNo.parent().parent().find(".promSellPriceHead").val("");
		    		    	promUnitNo.parent().parent().find(".promBuyPriceHead").val("");
		    		    	beforePromUnitNo.val("");
		    				top.jAlert('warning', '该代号下不存在符合门店促销的商品，请重新输入代号！', '提示消息');
		    				  return;
		    				}
		    			 data=JSON.parse(data);
	    		 	     promUnitNo.parent().parent().find("input[name='promUnitName']").val(unitName);

		    		
		    		    
		    			var itemArr=new Array();
		    			for(var i=0;i<data.length;i++)
		    				{
		    				var promBuyPrice='';
		    				if(data[i].promBuyPrice!=null)
		    					{
		    					promBuyPrice=data[i].promBuyPrice;
		    					}
		    				var promSellPrice='';
		    				if(data[i].promSellPrice!=null)
		    					{
		    					promSellPrice=data[i].promSellPrice;
		    					}
		    				if(!checkHasItemNo(data[i].itemNo))
	    				    {
		    					for(var n=0;n<dataArr.length;n++){
		    						  if(data[i].itemNo==dataArr[n].itemNo)
							    	   {
		    							  dataArr=dataArr.del(n);
							    	      n=-1;
							    	   }
		    					}
	    					   continue;
	    				    }
		    				
		    				var itemJson={'itemNo':data[i].itemNo,'itemName':data[i].itemName,'mainComName':data[i].mainComName,'promSupNo':data[i].stMainSupNo,'normalBuyPrice':data[i].normBuyPrice,'promBuyPrice':promBuyPrice,'normalSalePrice':data[i].normSellPrice,'promSellPrice':promSellPrice,'buyPriceLimit':data[i].buyPriceLimit,'buyWhen':data[i].buyWhen,'netCost':data[i].netCost,'vatVal':data[i].vatVal,'status':data[i].status,'buyMethd':data[i].buyMethd,'prcssType':data[i].prcssType,'priceRange':"",'netProfit':"",'headMinMargin':data[i].headMinMargin,'branchMinMargin':data[i].branchMinMargin};
 	    		    	 itemArr.push(itemJson);
		    			}
		    			var  unitJson={'unitType':unitType.val(),'promUnitNo':$.trim(promUnitNo.val()),'promActvy':promActvy,'promGiftHint':promGiftHint,'itemArr':itemArr};
		    			if(dataArr.length==0){
		    				top.jAlert('warning', '该代号下的商品已经全部添加，请重新选择代号！', '提示消息');
		    				$(".item_on").find("input[name='promUnitNo']").val('');
		    				$(".item_on").find("input[name='promUnitName']").val('');
		    				beforePromUnitNo.val("");
                          return;
		    			}
		    			unit[len]=unitJson;
		    			$.ajax({
		    				//async : false,
		    				type : 'post',
		    				url : ctx + '/prom/nondm/store/getPromItemStoreList',
		    				data : {'storeItemJs':JSON.stringify(dataArr),'pricePromType':$("#pricePromType").val()},
		    				success : function(storeItemData) {
		    					$(".pro_store_tb").html(storeItemData);
		    				}
		    		     });
		    		},
		    		error : function(XMLHttpRequest, textStatus, errorThrown) {
		    			top.jAlert('error', '网络超时!请稍后重试', '提示消息');
		    		}
		    	});
		    	
		  }
		
}

     
function promPriceFocus(obj){
	 $(obj).removeClass("errorInput");
	 $(obj).attr("title","");
}
/*查询商品厂商信息*/
$(".item").die("click").live('click',function(){
	  var promBeginDate=$("#promBeginDate").val();
	  var buyBeginDate=$("#buyBeginDate").val();
      var itemNo=$(this).parent().find(".item_on").find("input[name='promUnitNo']").val();
      var error=0;
      //var pricePromType=$("#pricePromType").val();
      if($(this).hasClass("item_on")){
    	  return;
      }
	  for (var i = 0; i < unit.length; i++) {
    		var json=unit[i];
    		if(itemNo==json.promUnitNo){
    		if($(this).attr('class')!='item item_on'){
    		  if(json.itemArr.length==0){
    		   top.jAlert('warning','代号'+json.promUnitNo+'下促销商品门店信息为空!', '提示消息');
    		   error++;
    		   return;
    		  }
    		}
    		for (var j = 0; j < json.itemArr.length; j++) {
    		   var itemJson=json.itemArr[j];
    		   if(itemJson.promBuyPrice==''&&buyBeginDate!='')
    			  {
    			   $(".pro_store_tb").find("input[name='promBuyPrice']").each(function() {
	    			   if(itemJson.status<=5&&itemJson.buyMethd !=2&&itemJson.prcssType!=2&&itemJson.prcssType!=4&&itemJson.prcssType!=5){
    				   if($(this).val()==""&&$(this).attr("disabled")!="disabled"){
    					   $(this).removeClass("errorInput").addClass('errorInput');
	    				   $(this).attr("title", '促销进价不能为空且必须是不能超过四位小数的数字!');
	    				   error++;
    				   }else{
    					   $(this).removeClass("errorInput");
    					   $(this).attr("title", '');
    				   }
    				   
	    			   }
    			   });
    			  }
    		   if(itemJson.promSellPrice==''&&promBeginDate!='')
    			  {
    			   $(".pro_store_tb").find("input[name='promSalePrice']").each(function() {
    				   if($(this).val()==""){
    					   $(this).removeClass("errorInput").addClass(
    						'errorInput');
	    					 $(this).attr("title", '促销售价不能为空且必须是不能超过两位小数的数字!');
    					     error++;
    				   }else{
    					   $(this).removeClass("errorInput");
    					   $(this).attr("title", '');
    				   }
    				   
    			   });
    			  }
	    	}
    		var promUnitNoStr="";
    		for (var j = 0; j < json.itemArr.length; j++) {
	    		   var itemJson=json.itemArr[j];
	    		   if(itemJson.promBuyPrice==''&&buyBeginDate!='')
	    			  {
	    			   promUnitNoStr=json.promUnitNo;
	    			   j=json.itemArr.length;
	    			   i=unit.length;
	    			  }
	    		 
	    		   if(itemJson.promSellPrice==''&&promBeginDate!='')
	    			  {
	    			   promUnitNoStr=json.promUnitNo;
	    			   j=json.itemArr.length;
	    			   i=unit.length;
	    			  }
	    		   
	    		  }
    		if($(this).attr('class')!='item item_on'&&promUnitNoStr!=$(this).find("input[name='promUnitNo']").val()){
    		for (var j = 0; j < json.itemArr.length; j++) {
    		   var itemJson=json.itemArr[j];
    		   if(itemJson.promBuyPrice==''&&buyBeginDate!='')
    			  {
    			   if(itemJson.status<=5&&itemJson.buyMethd !=2&&itemJson.prcssType!=2&&itemJson.prcssType!=4&&itemJson.prcssType!=5){
    			   top.jAlert('warning', '采购期间已经设置，代号'+json.promUnitNo+'下有商品门店促销进价为空!', '提示消息');
    			   return;
    			   }
    			  }
    		   if(itemJson.promSellPrice==''&&promBeginDate!='')
    			  {
    			   top.jAlert('warning', '促销期间已经设置，代号'+json.promUnitNo+'下有商品门店促销售价为空!', '提示消息');
    			   top.grid_layer_close();
    			   return;
    			  }
    		   
    		  }
    		}
		}
      }
	  if(error>0){
		  return;
	  }
	  $(this).parent().find(".item_on").removeClass("item_on");
	  $(this).addClass("item_on");
	  var buyBegin=$('#buyBegin').val();
   	  var sellBegin=$('#sellBegin').val();
	  $(".pro_store_tb").html("");
	  var buyHeadVal=$(this).find(".promBuyPriceHead").val();
	  var sellHeadVal=$(this).find(".promSellPriceHead").val();
	  $(".promSellPriceBody").val(sellHeadVal);
	  $(".promBuyPriceBody").val(buyHeadVal);
	  var unitType=$(this).find("select[name='unitType']");
	  var promUnitNo=$(this).find("input[name='promUnitNo']");
	  var catlgId = $("#catlgId").val();
	  var beforePromUnitNo=$(this).find("input[name='beforePromUnitNo']");
      if($.trim(promUnitNo.val())!=$.trim(beforePromUnitNo.val()))
    	{
    	 // 清除之前代号数组
  	      for (var i = 0; i < unit.length; i++) {
				       var unitJson=unit[i];
					    if(unitJson.unitType==unitType.val()&&unitJson.promUnitNo==$.trim(beforePromUnitNo.val()))
					    	   {
					    	      unit=unit.del(i);
					    	      i=-1;
					    	   }
			  }
    	  beforePromUnitNo.val($.trim(promUnitNo.val()));
    	}
	  if($.trim(promUnitNo.val())=='')
    	{
          return;
    	};
    	if(!isNumber($.trim(promUnitNo.val())))
    	{
    	  promUnitNo.val("");
		  top.jAlert('error', '输入代号必须为数字', '提示消息');
		  return;
    	};
    	top.grid_layer_open();
	  if(unitType&&catlgId&&promUnitNo)
		  {
		    var  len=unit.length;
		    var flag=false;
		    for(var j=0;j<unit.length;j++)
		    {
		    	  var json=unit[j];
		    	  if(json.unitType==unitType.val()&&json.promUnitNo==$.trim(promUnitNo.val())){
		    		 flag=true;
		    		 len=j;
		    	  }
		    }
		    if(flag)
		    {
		    	$(".pro_store_tb").html("");
				if(unit[len].itemArr){
				var itemArrJs=unit[len].itemArr;
				var itemStoreArr=new Array();
				for(var m=0;m<itemArrJs.length;m++)
					{
					var itemJsonData=itemArrJs[m];
					var promSellPrice=null;
					if(itemJsonData.promSellPrice!=""){
						promSellPrice=itemJsonData.promSellPrice;
					}
					var promBuyPrice=null;
					if(itemJsonData.promBuyPrice!=""){
						promBuyPrice=itemJsonData.promBuyPrice;
					}
					var buyPriceLimit=null;
					if(itemJsonData.buyPriceLimit!=""){
						buyPriceLimit=itemJsonData.buyPriceLimit;
					}
					var itemStoreJson={'itemNo':itemJsonData.itemNo,'netCost':itemJsonData.netCost,'vatVal':itemJsonData.vatVal,'itemName':itemJsonData.itemName,'mainComName':itemJsonData.mainComName,'normBuyPrice':itemJsonData.normalBuyPrice,'promBuyPrice':promBuyPrice,'normSellPrice':itemJsonData.normalSalePrice,'promSellPrice':promSellPrice,'buyWhen':itemJsonData.buyWhen,'buyPriceLimit':buyPriceLimit,'status':itemJsonData.status,'buyMethd':itemJsonData.buyMethd,'prcssType':itemJsonData.prcssType,'priceRange':itemJsonData.priceRange,'profit':itemJsonData.netProfit,'headMinMargin':itemJsonData.headMinMargin,'branchMinMargin':itemJsonData.branchMinMargin};
					itemStoreArr.push(itemStoreJson);
		  
					}
				$(".zt_tit").scrollLeft(0);
				$(".pro_store_tb").scrollLeft(0);
				$.ajax({
					//async : false,
					type : 'post',
					url : ctx + '/prom/nondm/store/getPromItemStoreList',
					data : {'storeItemJs':JSON.stringify(itemStoreArr),'pricePromType':$("#pricePromType").val(),'buyBegin':buyBegin,'sellBegin':sellBegin},
					success : function(storeItemData) {
						$(".pro_store_tb").html(storeItemData);
						$(".pro_store_tb").find("input[name='netProfit']").each(function() {
							var netMaori = $(this).val();
							if(netMaori!=""){
							var headMinMargin= $(this).parent().find("input[name='headMinMargin']").val();
							var branchMinMargin=$(this).parent().find("input[name='branchMinMargin']").val();
							if(netMaori<0){
								$(this).removeClass("hiLightYellowInput").addClass("hiLightInput");
							}else if(headMinMargin!=""&&headMinMargin!=null&&netMaori<parseFloat(headMinMargin)){
								$(this).removeClass("hiLightInput").addClass("hiLightYellowInput");
							}else if(branchMinMargin!=""&&branchMinMargin!=null&&netMaori<parseFloat(branchMinMargin)){
								$(this).removeClass("hiLightInput").addClass("hiLightYellowInput");
							}
							else{
								$(this).removeClass("hiLightInput");
								$(this).removeClass("hiLightYellowInput");
							}
							}
							});
					}
			     });
			 }
		  }
		}
	  top.grid_layer_close();
});
/*移除选中厂商商品信息*/
function removeProstore(){
  var buyBegin=$('#buyBegin').val();
  var sellBegin=$('#sellBegin').val();
  if(buyBegin=='1')
	  {
	      top.jAlert('warning', '进价促销已经开始,不能删除促销商品!', '提示消息');
          return;
	  }
  if(sellBegin=='1')
  {
	  top.jAlert('warning', '售价促销已经开始,不能删除促销商品!', '提示消息');
      return;
  }
  var itemNoArr=new Array();
  $('input[name="proStoreCK"]:checked').each(function(){
	  itemNoArr.push($(this).val());
  });
  if(itemNoArr.length==0){
	  top.jAlert('warning', '请选择要删除的促销商品!', '提示消息');
	  return;
  }
  if(!checkOrderUsed(itemNoArr.join(","),12)){
	  return;
  }
  $('input[name="proStoreCK"]').each(function() {
		if($(this).attr("checked")=='checked')
			{
    	      // 清除数组相应商品
    	      for (var i = 0; i < unit.length; i++) {
    	    	  if(unit[i].itemArr)
    	    		  {
				       var item=unit[i].itemArr;
				       for (var j = 0; j < item.length; j++) {
				    	   var itemInfo=item[j];
					       if(itemInfo.itemNo==$(this).val())
					    	   {
					    	    item=item.del(j);
					    	    j=-1;
					    	   }
				        }
				       unit[i].itemArr=item;
    	    		 }
			  }
			  $("#pro_ig_"+$(this).val()).remove();
			}
     });
	 $("input[name='checkStoreItemAll']").attr('checked',false);
}
      
function  validateItemPrice(itemNo,classStr){
	  var promBeginDate=$("#promBeginDate").val();
	  var buyBeginDate=$("#buyBeginDate").val();
	  var error=0;
      if(classStr!='item item_on'){
   	  for (var i = 0; i < unit.length; i++) {
    		var json=unit[i];
    		if(itemNo==json.promUnitNo){
    		if(json.itemArr.length==0)
    		{
    		   top.jAlert('warning','代号'+json.promUnitNo+'下促销商品门店信息为空!', '提示消息');
    		   error++;
 			   return false;
    		}
    		for (var j = 0; j < json.itemArr.length; j++) {
	    		   var itemJson=json.itemArr[j];
	    		   if(itemJson.promBuyPrice==''&&buyBeginDate!='')
	    			  {
	    			   $(".pro_store_tb").find("input[name='promBuyPrice']").each(function() {
		    			   if(itemJson.status<=5&&itemJson.buyMethd !=2&&itemJson.prcssType!=2&&itemJson.prcssType!=4&&itemJson.prcssType!=5){
	    				   if($(this).val()==""&&$(this).attr("disabled")!="disabled"){
	    					   $(this).removeClass("errorInput").addClass('errorInput');
		    				   $(this).attr("title", '促销进价不能为空且必须是不能超过四位小数的数字!');
	    					   error++;
	    				   }else{
	    					   $(this).removeClass("errorInput");
		    				   $(this).attr("title", '');
	    				   }
		    			   }
	    			   });
	    			  }
	    		   if(itemJson.promSellPrice==''&&promBeginDate!='')
	    			  {
	    			   $(".pro_store_tb").find("input[name='promSalePrice']").each(function() {
	    				   if($(this).val()==""){
	    					   $(this).removeClass("errorInput").addClass(
	    						'errorInput');
		    					 $(this).attr("title", '促销售价不能为空且必须是不能超过两位小数的数字!');
	    					     error++;
	    				   }else{
	    					   $(this).removeClass("errorInput");
		    				   $(this).attr("title", '');
	    				   }
	    				   
	    			   });
	    			  }
	    	}
    		for (var j = 0; j < json.itemArr.length; j++) {
    		   var itemJson=json.itemArr[j];
    		   if(itemJson.promBuyPrice==''&&buyBeginDate!='')
    			  {
    			   if(itemJson.status<=5&&itemJson.buyMethd !=2&&itemJson.prcssType!=2&&itemJson.prcssType!=4&&itemJson.prcssType!=5){
    			   top.jAlert('warning', '采购期间已经设置，代号'+json.promUnitNo+'下有商品门店促销进价为空!', '提示消息');
    			   return false;
    			   }
    			  }
    		 
    		   if(itemJson.promSellPrice==''&&promBeginDate!='')
    			  {
    			   top.jAlert('warning', '促销期间已经设置，代号'+json.promUnitNo+'下有商品门店促销售价为空!', '提示消息');
    			   return false;
    			  }
    		   
    		  }
    		}
		}
      }
   	  if(error>0){
   		  return false;
   	  }
   	  else{
   		  return true;
   	  }
}
/*检查订单是否使用*/
function checkOrderUsed(itemStr,flagStr){
    	  var promNo=$("#promNo").val();
    	  var storeNo=$("#storeNo").val();
    	  var flag=true;
    	  $.ajax({
    		    async:false,
		    	url: ctx + '/prom/nondm/store/checkOrderItem?itemStr='+itemStr+'&promNo='+promNo+'&storeNo='+storeNo+'&flag='+flagStr+'&ti='+(new Date()).getTime(),
				type: "post",
				dataType:"json",
				beforeSend: function(){
					//nothing to do
				},
				success: function(result) {
				    if(result.message!=null&&result.message!=""&& result.message !="success"){
				    	flag=false;
	   	    			top.jAlert('warning', result.message, '提示消息');
				    }    	
				}
		    });
    	  return flag;
}
/*代号删除*/
function delUnitClick(obj,e){
	 //e.stopPropagation();
	 var itemNo=$(obj).parent().find(".item_on").find("input[name='promUnitNo']").val();
     if(!validateItemPrice(itemNo,$(obj).parent().attr('class'))){
   	  return;
     }
	  var buyBegin=$('#buyBegin').val();
  	  var sellBegin=$('#sellBegin').val();
  	  if(buyBegin=='1')
  		  {
		     top.jAlert('warning', '进价促销已经开始,不能删除代号信息!', '提示消息');
            return;
  		  }
  	  if(sellBegin=='1')
		  {
			 top.jAlert('warning', '售价促销已经开始,不能删除代号信息!', '提示消息');
            return;
		  }
  	   var promUnitNo=$(obj).parent(".item").find("input[name='promUnitNo']").val();
       var unitType=$(obj).parent(".item").find("select[name='unitType']").val();
  	   var itemNoArr=new Array();
  	   for (var i = 0; i < unit.length; i++) {
	       var unitJson=unit[i];
		    if(unitJson.unitType==unitType&&unitJson.promUnitNo==promUnitNo)
		    	   {
		    	          for(var j=0;j<unitJson.itemArr.length;j++){
		    	        	  itemNoArr.push(unitJson.itemArr[j].itemNo);
		    	          }
		    	   }
           }
  	   //检查是否已经有订单商品使用该促销期数
  	  if(itemNoArr.length!=0){
  	      if(!checkOrderUsed(itemNoArr.join(","),11)){
  		  return;
  	      }
  	  }
	 // 清除代号数组
     for (var i = 0; i < unit.length; i++) {
	       var unitJson=unit[i];
		   if(unitJson.unitType==unitType&&unitJson.promUnitNo==promUnitNo){
   	         unit=unit.del(i);
   	         i=-1;
			}
		  }
	    var $row = $(obj).parent(".item");
	    if($(obj).parent(".item").hasClass("item_on")){
	    	if(unit.length>0){
	    		 //默认选中第一个
	    		 $(".pro_store_tb_edit").find(".item:first").click();
	    		 $(".pro_store_tb_edit").scrollTop(0);
	    	}else{
	    		$(".pro_store_tb").html("");
	    	}
   	    
       }
	    $row.remove();
}


function checkAll(chk){
     $('input[name="proStoreCK"]').each(function() {
      		if(chk.checked)
      			{
          	      $(this).attr("checked",true);
      			}
      		else
      			{
      			 $(this).attr("checked",false);
      			}
       });
      }
function proStoreCKClick(){
	 var flag=true;
	 $.each($('input[name="proStoreCK"]'),function(i,val){
		if($(val).attr('checked')==undefined){	
		flag=false;
		}
	 });
	 if(flag){
		  $('input[name="checkStoreItemAll"]').attr('checked','checked');
	 }
	 else{
		  $('input[name="checkStoreItemAll"]').removeAttr('checked');
  	 }
}
  
/**
 * 促销进价，促销售价的关联变化
 * promBuyPriceHead，promSellPriceHead
 * promBuyPriceBody，promSellPriceBody
*/
//点击promBuyPriceHead，promSellPriceHead 改变promBuyPriceBody，promSellPriceBody,并计算降价幅度，和净毛利
function promBuyPriceHeadBlur(obj){
	var buyBegin=$('#buyBegin').val();
  	if(buyBegin=='1')
  	{
		top.jAlert('warning', '促销进价已经开始,不能修改促销进价!', '提示消息');
        return;
  	}
	var promBuyPriceHeadVal = $.trim($(obj).val());
	if(!isMoney(promBuyPriceHeadVal))
	{
		top.jAlert('warning', '促销进价必须是不能超过四位小数的数字!', '提示消息');
		$(".promBuyPriceBody").val('');
		$(obj).val('');
		return;
    }
	if(promBuyPriceHeadVal=="")
	{
	  $(obj).val('');
	  $(".promBuyPriceBody").val('');
      return;
     }
	var itemArr=new Array();
	$("input[name='promBuyPrice']").each(function(){
		var itemNo = $(this).parent().find("input[name='itemNo']").val();
		itemArr.push(itemNo);
	});
	if(!checkOrderIsUseCommom(itemArr,21)){
		$(obj).val("");
		$(".promBuyPriceBody").val('');
		return;
	}
	var isPass = true;
	
	$("input[name='promBuyPrice']").each(function(){
	//获取正常进价normBuyPrice,
	var normBuyPrice = $(this).parent().find("input[name='normalBuyPrice']").val();
	var buyWhen=$(this).parent().find("input[name='buyWhen']").val();
	var buyPriceLimit=$(this).parent().find("input[name='buyPriceLimit']").val();
	if($(this).attr('disabled')=='disabled'){
		return true;
		}
	if(parseFloat(promBuyPriceHeadVal)>= parseFloat(normBuyPrice)&&buyWhen!=2){
		top.jAlert('warning', '促销进价必须小于正常进价!', '提示消息');
		isPass =false;
		$(obj).val('');
		$(".promBuyPriceBody").val('');
		return;
	}
	if(buyWhen == "2"){
		if((buyPriceLimit =="null"||buyPriceLimit =="")&&parseFloat(promBuyPriceHeadVal)>= parseFloat(normBuyPrice)&&buyPriceLimit !="null"&&buyPriceLimit !=""){
			top.jAlert('warning', '促销进价必须小于正常进价!', '提示消息');
			isPass =false;
			$(obj).val("");
			$(".promBuyPriceBody").val('');
  			return;
		}
		if(buyPriceLimit !="null"&&buyPriceLimit !=""&& parseFloat(promBuyPriceHeadVal)>parseFloat(buyPriceLimit)){
		top.jAlert('warning', '促销进价必须小于买价限制：'+buyPriceLimit+'元!', '提示消息');
		isPass =false;
		$(obj).val('');
		$(".promBuyPriceBody").val('');
		return;
		}
    }
	
	});
		
		if(!isPass)
			{
			 return;
			}
	/*if(!checkPromIsInOrder(false,itemArr.join(","))){
			obj.val("");
		top.jAlert('warning', '存在没有作废的订单使用了该促销期数下的商品，不能修改价格!', '提示消息');
		return;
		}*/
		$(obj).val(promBuyPriceHeadVal);
		$(".promBuyPriceBody").each(function (){
			var buyBegin=$('#buyBegin').val();
    	  if(buyBegin=='1')
    		  {
  			      top.jAlert('warning', '促销进价已经开始,不能修改促销进价!', '提示消息');
                  return;
    		  }
    	  
			$(this).val(promBuyPriceHeadVal);
		});
		
		$("input[name='promBuyPrice']").each(function(){
			if($(this).attr('disabled')=='disabled'){
				return true;
			}
			$(this).val(promBuyPriceHeadVal);
			$(this).removeClass("errorInput");
		$(this).attr("title", '');
		    // 修改数组相应商品价格
		  var itemNo=$(this).parent().find("input[name='itemNo']").val();
	      for (var i = 0; i < unit.length; i++) {
	    	 
	    	  if(unit[i].itemArr)
	    		  {
			       var item=unit[i].itemArr;
			       for (var j = 0; j < item.length; j++) {
			    	   var itemInfo=item[j];
				       if(itemInfo.itemNo==itemNo)
				    	   {
				    	   itemInfo.promBuyPrice=promBuyPriceHeadVal;
				    	   item[j]=itemInfo;
				    	   }
			        }
			       unit[i].itemArr=item;
			       
	    		 }
			  
		  }
		});
		
}

function checkOrderIsUseCommom(itemNoArr,flag)
{
	  var isUse=true;
  	  //检查是否已经有订单商品使用该促销期数
  	  if(itemNoArr.length!=0){
  	      if(!checkOrderUsed(itemNoArr.join(","),flag)){
  	    	isUse=false;
  	      }
  	  }
  	return isUse;
}
function promBuyPriceBodyBlur(obj){
	    var buyBegin=$('#buyBegin').val();
		var promBuyPriceHeadVal=$.trim($(obj).val());
		if(buyBegin=='1')
	    {
		 top.jAlert('warning', '促销进价已经开始,不能修改促销进价!', '提示消息');
         return;
        }
		if(!isMoney(promBuyPriceHeadVal))
		{
		top.jAlert('warning', '促销进价必须是不能超过四位小数的数字!', '提示消息');
		$(obj).val('');
		$(".promBuyPriceHead").parent().parent().find(".item_on").find(".promBuyPriceHead").each(function (){
  			$(this).val('');
  		});
			return;
	    }
		if(promBuyPriceHeadVal=="")
		{
		  $(obj).val('');
		   $(".promBuyPriceHead").parent().parent().find(".item_on").find(".promBuyPriceHead").each(function (){
			$(this).val('');
		  });
	      return;
	     }
		var itemArr=new Array();
		$("input[name='promBuyPrice']").each(function(){
			var itemNo = $(this).parent().find("input[name='itemNo']").val();
			itemArr.push(itemNo);
		});
		if(!checkOrderIsUseCommom(itemArr,21)){
			$(obj).val("");
			return;
		}
		var isPass =true;
		$("input[name='promBuyPrice']").each(function(){
		var normBuyPrice = $(this).parent().find("input[name='normalBuyPrice']").val();
		var buyWhen=$(this).parent().find("input[name='buyWhen']").val();
		var buyPriceLimit=$(this).parent().find("input[name='buyPriceLimit']").val();
		if($(this).attr('disabled')=='disabled'){
			return true;
		}
	if(parseFloat(promBuyPriceHeadVal) >= parseFloat(normBuyPrice)&&buyWhen!=2){
		top.jAlert('warning', '促销进价必须小于正常进价!', '提示消息');
		isPass =false;
		$(obj).val('');
		$(".promBuyPriceHead").parent().parent().find(".item_on").find(".promBuyPriceHead").each(function (){
  			$(this).val('');
  		});
		return false;
	}
	if(buyWhen == "2"){
		if((buyPriceLimit =="null"||buyPriceLimit =="")&&parseFloat(promBuyPriceHeadVal)>= parseFloat(normBuyPrice)&&buyPriceLimit !="null"&&buyPriceLimit !=""){
			top.jAlert('warning', '促销进价必须小于正常进价!', '提示消息');
			isPass =false;
			$(obj).val("");
			$(".promBuyPriceHead").parent().parent().find(".item_on").find(".promBuyPriceHead").each(function (){
	  			$(this).val('');
	  		});
  			return;
		}
		if(buyPriceLimit !="null"&&buyPriceLimit !=""&& parseFloat(promBuyPriceHeadVal)>parseFloat(buyPriceLimit)){
		top.jAlert('warning', '促销进价必须小于买价限制：'+buyPriceLimit+'元!', '提示消息');
		isPass =false;
		$(obj).val('');
		$(".promBuyPriceHead").parent().parent().find(".item_on").find(".promBuyPriceHead").each(function (){
  			$(this).val('');
  		});
			return;
		}
    }
		});
		if(!isPass)
			{
			return;
			}
		
	   /*if(!checkPromIsInOrder(false,itemArr.join(","))){
			obj.val("");
		top.jAlert('warning', '存在没有作废的订单使用了该促销期数下的商品,不能修改价格!', '提示消息');
		return;
		}*/
		$(".promBuyPriceHead").parent().parent().find(".item_on").find(".promBuyPriceHead").each(function (){
			$(this).val(promBuyPriceHeadVal);
		});
		$(obj).val(promBuyPriceHeadVal);
		$("input[name='promBuyPrice']").each(function(){
			if($(this).attr('disabled')=='disabled'){
				return true;
			}
			$(this).val(promBuyPriceHeadVal);
			$(this).removeClass("errorInput");
		$(this).attr("title", '');
		    // 修改数组相应商品价格
		  var itemNo=$(this).parent().find("input[name='itemNo']").val();
	      for (var i = 0; i < unit.length; i++) {
	    	 
	    	  if(unit[i].itemArr)
	    		  {
			       var item=unit[i].itemArr;
			       for (var j = 0; j < item.length; j++) {
			    	   var itemInfo=item[j];
				       if(itemInfo.itemNo==itemNo)
				    	   {
				    	   itemInfo.promBuyPrice=promBuyPriceHeadVal;
				    	   item[j]=itemInfo;
				    	   }
			        }
			       unit[i].itemArr=item;
			       
	    		 }
			  
		  }
		});
		
}

  	
function promSalePriceHeadBlur(obj){
	var sellBegin=$('#sellBegin').val();
 	  if(sellBegin=='1')
		  {
			top.jAlert('warning', '促销售价已经开始,不能修改促销售价!', '提示消息');
            return;
		  }
		var promSellPriceHeadVal = $.trim($(obj).val());
		if(!isSellMoney(promSellPriceHeadVal))
		{
			top.jAlert('warning', '促销售价必须是不能超过两位小数的数字!', '提示消息');
			$(obj).val('');
			$(".promSellPriceBody").val('');
			return;
	    }
		if(promSellPriceHeadVal=="")
		{
		  $(obj).val('');
		  $(".promSellPriceBody").val('');
	      return;
	     }
	  //促销售价必须 < 正常售价 * 0.95
    //normSellPrice
	  var isPass =true;
    $("input[name='promSalePrice']").each(function (i){
		//获取正常进价normBuyPrice,
		var normSellPrice = $(this).parent().find("input[name='normalSalePrice']").val();
		if(parseFloat(promSellPriceHeadVal) >= (parseFloat(normSellPrice)*0.95)){
			top.jAlert('warning', '促销售价必须小于正常售价*0.95!', '提示消息');
			isPass =false;
			$(obj).val('');
			$(".promSellPriceBody").val('');
			return false;
		}
	   });
    if(!isPass)
  	  {
  	   return;
  	  }
		$(".promSellPriceBody").each(function (){
			$(this).val(promSellPriceHeadVal);
		});
		$(obj).val(promSellPriceHeadVal);
		$("input[name='promSalePrice']").each(function (){
			 var itemNo=$(this).parent().find("input[name='itemNo']").val();
			var priceCut="";
			 var netMaori="";
			 if(itemNo){
				 
			var promSellPrice = promSellPriceHeadVal;
			var netCost = $(this).parent().find("input[name='netCost']").val();
			var vat = $(this).parent().find("input[name='vat']").val();
			var normSellPrice = $(this).parent().find("input[name='normalSalePrice']").val();
			if(promSellPrice!=""){
			priceCut = roundFun ((normSellPrice-promSellPrice)/normSellPrice*100,2);
			netMaori = roundFun((((Number(promSellPrice)/( 1 + Number(vat/100)))-Number(netCost))/( Number(promSellPrice)/( 1 + Number(vat/100))))*100,3);
			var headMinMargin= $(this).parent().find("input[name='headMinMargin']").val();
			var branchMinMargin=$(this).parent().find("input[name='branchMinMargin']").val();
			if(netMaori<0){
				$(this).parent().find("input[name='netProfit']").removeClass("hiLightYellowInput").addClass("hiLightInput");
			}else if(headMinMargin!=""&&headMinMargin!=null&&netMaori<parseFloat(headMinMargin)){
				$(this).parent().find("input[name='netProfit']").removeClass("hiLightInput").addClass("hiLightYellowInput");
			}else if(branchMinMargin!=""&&branchMinMargin!=null&&netMaori<parseFloat(branchMinMargin)){
				$(this).parent().find("input[name='netProfit']").removeClass("hiLightInput").addClass("hiLightYellowInput");
			}
			else{
				$(this).parent().find("input[name='netProfit']").removeClass("hiLightInput");
				$(this).parent().find("input[name='netProfit']").removeClass("hiLightYellowInput");
			}
			$(this).parent().find("input[name='priceRanage']").val(priceCut);
			$(this).parent().find("input[name='netProfit']").val(netMaori);
			}else{
				$(this).parent().find("input[name='priceRanage']").val("");
	  			$(this).parent().find("input[name='netProfit']").val("");
			}
			 }
	  	      for (var i = 0; i < unit.length; i++) {
	  	    	 
	  	    	  if(unit[i].itemArr)
	  	    		  {
					       var item=unit[i].itemArr;
					       for (var j = 0; j < item.length; j++) {
					    	   var itemInfo=item[j];
						       if(itemInfo.itemNo==itemNo)
						    	   {
						    	   itemInfo.promSellPrice=promSellPriceHeadVal;
						    	   itemInfo.priceRange=priceCut;
	  					    	   itemInfo.netProfit=netMaori;
						    	   item[j]=itemInfo;
						    	   }
					        }
					       unit[i].itemArr=item;
					       
	  	    		 }
					  
				  }
			$(this).val(promSellPriceHeadVal);
			$(this).removeClass("errorInput");
			$(this).attr("title", '');
		});
		
}

function promSalePriceBodyBlur(obj){
	 var sellBegin=$('#sellBegin').val();
	  if(sellBegin=='1')
	  {
		   top.jAlert('warning', '促销售价已经开始,不能修改促销售价!', '提示消息');
          return;
	  }
	var promSellPriceHeadVal = $.trim($(obj).val());

	if(!isSellMoney(promSellPriceHeadVal))
	{
		top.jAlert('warning', '促销售价必须是不能超过两位小数的数字!', '提示消息');
		$(obj).val('');
		$(".promSellPriceHead").parent().parent().find(".item_on").find(".promSellPriceHead").each(function (){
			$(this).val('');
		});
		return;
   }
	if(promSellPriceHeadVal=="")
	{
	  $(obj).val('');
	  $(".promSellPriceHead").parent().parent().find(".item_on").find(".promSellPriceHead").each(function (){
			$(this).val('');
	  });
     return;
    }
 //促销售价必须 < 正常售价 * 0.95
 //normSellPrice
 var isPass =true;
 $("input[name='promSalePrice']").each(function (i){
	//获取正常进价normBuyPrice,
	var normSellPrice = $(this).parent().find("input[name='normalSalePrice']").val();
	if(parseFloat(promSellPriceHeadVal) >= (parseFloat(normSellPrice)*0.95)){
		top.jAlert('warning', '促销售价必须小于正常售价*0.95!', '提示消息');
		isPass =false;
		$(obj).val('');
		 $(".promSellPriceHead").parent().parent().find(".item_on").find(".promSellPriceHead").each(function (){
				$(this).val('');
		  });
		return false;
	}
  });
 if(!isPass)
 {
  return;
 }
	$(".promSellPriceHead").parent().parent().find(".item_on").find(".promSellPriceHead").each(function (){
		$(this).val(promSellPriceHeadVal);
	});
	$(obj).val(promSellPriceHeadVal);
	
$("input[name='promSalePrice']").each(function (){
		var itemNo=$(this).parent().find("input[name='itemNo']").val();
		var priceCut="";
		var netMaori="";
		if(itemNo){
		var promSellPrice = promSellPriceHeadVal;
		var netCost = $(this).parent().find("input[name='netCost']").val();
		var vat = $(this).parent().find("input[name='vat']").val();
		var normSellPrice = $(this).parent().find("input[name='normalSalePrice']").val();
		
		if(promSellPrice!=""){
		priceCut = roundFun ((normSellPrice-promSellPrice)/normSellPrice*100,2);
		netMaori = roundFun((((Number(promSellPrice)/( 1 + Number(vat/100)))-Number(netCost))/( Number(promSellPrice)/( 1 + Number(vat/100))))*100,3);
		var headMinMargin= $(this).parent().find("input[name='headMinMargin']").val();
		var branchMinMargin=$(this).parent().find("input[name='branchMinMargin']").val();
		if(netMaori<0){
			$(this).parent().find("input[name='netProfit']").removeClass("hiLightYellowInput").addClass("hiLightInput");
		}else if(headMinMargin!=""&&headMinMargin!=null&&netMaori<parseFloat(headMinMargin)){
			$(this).parent().find("input[name='netProfit']").removeClass("hiLightInput").addClass("hiLightYellowInput");
		}else if(branchMinMargin!=""&&branchMinMargin!=null&&netMaori<parseFloat(branchMinMargin)){
			$(this).parent().find("input[name='netProfit']").removeClass("hiLightInput").addClass("hiLightYellowInput");
		}
		else{
			$(this).parent().find("input[name='netProfit']").removeClass("hiLightInput");
			$(this).parent().find("input[name='netProfit']").removeClass("hiLightYellowInput");
		}
		$(this).parent().find("input[name='priceRanage']").val(priceCut);
		$(this).parent().find("input[name='netProfit']").val(netMaori);
		}else{
			$(this).parent().find("input[name='priceRanage']").val("");
 			$(this).parent().find("input[name='netProfit']").val("");
		}
		 }
		 
 	      for (var i = 0; i < unit.length; i++) {
 	    	 
 	    	  if(unit[i].itemArr)
 	    		  {
				       var item=unit[i].itemArr;
				       for (var j = 0; j < item.length; j++) {
				    	   var itemInfo=item[j];
					       if(itemInfo.itemNo==itemNo)
					    	   {
					    	   itemInfo.promSellPrice=promSellPriceHeadVal;
					    	   itemInfo.priceRange=priceCut;
 					    	   itemInfo.netProfit=netMaori;
					    	   item[j]=itemInfo;
					    	   }
				        }
				       unit[i].itemArr=item;
				       
 	    		 }
				  
			  }
		$(this).val(promSellPriceHeadVal);
		$(this).removeClass("errorInput");
		$(this).attr("title", '');
	});
}

function changePromBuyPrice(itemNo,promBuyPrice){
	 for (var i = 0; i < unit.length; i++) {
  	  if(unit[i].itemArr)
  		  {
			       var item=unit[i].itemArr;
			       for (var j = 0; j < item.length; j++) {
			    	   var itemInfo=item[j];
				       if(itemInfo.itemNo==itemNo)
				    	   {
				    	   itemInfo.promBuyPrice=promBuyPrice;
				    	   item[j]=itemInfo;
				    	   }
			        }
			       unit[i].itemArr=item;
			       
  		 }
			  
		}
}
function promBuyPriceChange(obj){
	clearBuyHeadBody();
	if(buyBegin=='1')
	{
		   top.jAlert('warning', '促销进价已经开始,不能修改促销进价!', '提示消息');
           return;
	}
	var itemNo=$(obj).parent().find("input[name='itemNo']").val();
	if(!itemNo)
	{
		 return;
	}
	var beforeBuyPrice="";
	for (var i = 0; i < unit.length; i++) {
  	    	  if(unit[i].itemArr)
  	    		  {
				       var item=unit[i].itemArr;
				       for (var j = 0; j < item.length; j++) {
				    	   var itemInfo=item[j];
					       if(itemInfo.itemNo==itemNo)
					    	   {
					    	    beforeBuyPrice=itemInfo.promBuyPrice;
					    	    j=item.length;
					    	    i=unit.length;
					    	   }
				        }
  	    		 }
		}
	var itemNoArr=new Array();
	itemNoArr.push(itemNo);
	if(!checkOrderIsUseCommom(itemNoArr,22)){
		$(obj).val(beforeBuyPrice);
		return;
	}
/*	if(!checkPromIsInOrder(false,itemNo)){
		$(this).val(beforeBuyPrice);
	    top.jAlert('warning', '存在没有作废的订单使用了该促销期数下的商品,不能修改价格!', '提示消息');
	    return;
	}*/
	var promBuyPrice = $.trim($(obj).val());
	if(!isMoney(promBuyPrice))
	{
		top.jAlert('warning', '促销进价必须是不能超过四位小数的数字!', '提示消息');
		$(obj).val('');
		$(obj).addClass("errorInput");
		$(obj).attr("title", '促销进价必须是不能超过四位小数的数字!');
		changePromBuyPrice(itemNo,'');
		return;
    }
	if(promBuyPrice=="")
	{
	$(obj).val('');
	$(obj).addClass("errorInput");
	$(obj).attr("title", '促销进价不能为空且必须是不能超过四位小数的数字!');
	changePromBuyPrice(itemNo,'');
	return;
   }
	var isPass =true;
	var normBuyPrice = $(obj).parent().find("input[name='normalBuyPrice']").val();
	var buyWhen=$(obj).parent().find("input[name='buyWhen']").val();
	var buyPriceLimit=$(obj).parent().find("input[name='buyPriceLimit']").val();
	if(parseFloat(promBuyPrice) >= parseFloat(normBuyPrice)&&buyWhen!=2){
		top.jAlert('warning', '促销进价必须小于正常进价!', '提示消息');
		isPass =false;
		$(obj).val('');
		$(obj).removeClass("errorInput").addClass("errorInput");
		$(obj).attr("title", '促销进价必须小于正常进价!');
		changePromBuyPrice(itemNo,'');
		return;
	}
	if(buyWhen == "2"){
		if((buyPriceLimit =="null"||buyPriceLimit =="")&&parseFloat(promBuyPrice)>= parseFloat(normBuyPrice)&&buyPriceLimit !="null"&&buyPriceLimit !=""){
			top.jAlert('warning', '促销进价必须小于正常进价!', '提示消息');
			isPass =false;
			$(obj).val("");
			$(obj).removeClass("errorInput").addClass("errorInput");
			$(obj).attr("title", '促销进价必须小于正常进价!');
			changePromBuyPrice(itemNo,'');
  			return;
		}
		if(buyPriceLimit !="null"&&buyPriceLimit !=""&& (parseFloat(promBuyPrice)>parseFloat(buyPriceLimit))){
		top.jAlert('warning', '促销进价必须小于买价限制：'+buyPriceLimit+'元!', '提示消息');
		isPass =false;
		$(obj).removeClass("errorInput").addClass("errorInput");
		$(obj).attr("title", '促销进价必须小于买价限制：'+buyPriceLimit+'元!');
		$(obj).val('');
		changePromBuyPrice(itemNo,'');
		return;
		}
    }
  if(!isPass)
  {
   return;
  }
  $(obj).removeClass("errorInput");
  changePromBuyPrice(itemNo,promBuyPrice);
}
function promBuyPriceKeyUp(obj,evt){
	var event=evt?evt:(window.event?window.event:null);//兼容IE和FF
	  if (event.keyCode==13){
		  var nextVal=$(obj).parent().next().find("input[name='promBuyPrice']").val();
		  if(nextVal!=undefined){
			 $(obj).parent().next().find("input[name='promBuyPrice']").focus().val(nextVal);
		  }
		  else{
			  var nextSaleVal=$(obj).parent().parent().find("input[name='promSalePrice']:first").not(":disabled").val();
			  $(obj).parent().parent().find("input[name='promSalePrice']:first").not(":disabled").focus().val(nextSaleVal);
		  }
	  }
}
function promBuyPriceBlur(obj){
	if($.trim($(obj).val())==""&&$(obj).attr("disabled")!="disabled"){
	  $(obj).removeClass("errorInput").addClass('errorInput');
	  $(obj).attr("title", '促销进价不能为空且必须为不能超过四位小数的数字!');
	}
}
function promSalePriceKeyUp(obj,evt){
	var event=evt?evt:(window.event?window.event:null);//兼容IE和FF
	 if (event.keyCode==13){
		  var saleVal=$(obj).parent().next().find("input[name='promSalePrice']").val();
		  if(saleVal!=undefined){
			 $(obj).parent().next().find("input[name='promSalePrice']").focus().val(saleVal);
		  }
	  }
}
function promSalePriceBlur(obj){
	if($.trim($(obj).val())==""&&$(obj).attr("disabled")!="disabled"){
	  $(obj).removeClass("errorInput").addClass('errorInput');
	  $(obj).attr("title", '促销售价不能为空且必须为不能超过两位小数的数字!');
	}
}

function clearBuyHeadBody(){
	$(".promBuyPriceBody").val("");
	$(".item_on").find(".promBuyPriceHead").val("");
}
function clearSellHeadBody(){
	$(".promSellPriceBody").val("");
	$(".item_on").find(".promSellPriceHead").val("");
}
function changePromSalePrice(itemNo,promSellPrice,priceCut,netMaori){
	for (var i = 0; i < unit.length; i++) {
  	  if(unit[i].itemArr)
  		  {
			       var item=unit[i].itemArr;
			       for (var j = 0; j < item.length; j++) {
			    	   var itemInfo=item[j];
				       if(itemInfo.itemNo==itemNo)
				    	   {
				    	   itemInfo.promSellPrice=promSellPrice;
				    	   itemInfo.priceRange=priceCut;
				    	   itemInfo.netProfit=netMaori;
				    	   item[j]=itemInfo;
				    	   }
			        }
			       unit[i].itemArr=item;
			       
  		 }
	}
}
function promSalePriceChange(obj){
	    clearSellHeadBody();
		var itemNo=$(obj).parent().find("input[name='itemNo']").val();
		if(!itemNo)
		{
			 return;
		}
		var promSellPrice = $.trim($(obj).val());
		if(!isSellMoney(promSellPrice))
		{
			top.jAlert('warning', '促销售价必须是不能超过两位小数的数字!', '提示消息');
			$(obj).addClass("errorInput");
			$(obj).attr("title", '促销售价必须是不能超过两位小数的数字!');
			$(obj).val('');
			$(obj).parent().find("input[name='priceRanage']").val(priceCut);
			$(obj).parent().find("input[name='netProfit']").val(netMaori);
			changePromSalePrice(itemNo,'','','');
			return;
	    }
		if(promSellPrice=="")
			{
			$(obj).val('');
			$(obj).parent().find("input[name='priceRanage']").val(priceCut);
			$(obj).parent().find("input[name='netProfit']").val(netMaori);
			changePromSalePrice(itemNo,'','','');
			$(obj).addClass("errorInput");
			$(obj).attr("title", '促销售价不能为空且必须是不能超过两位小数的数字!');
		    return;
		  }
		 //促销售价必须 < 正常售价 * 0.95
		//normSellPrice
	  var isPass =true;
	  //$("input[name='promSalePrice']").each(function (i){
		//获取正常进价normBuyPrice,
		var normSellPrice = $(obj).parent().find("input[name='normalSalePrice']").val();
		if(parseFloat(promSellPrice) >= (parseFloat(normSellPrice)*0.95)){
			top.jAlert('warning', '促销售价必须小于正常售价*0.95!', '提示消息');
			isPass =false;
			$(obj).val('');
			$(obj).parent().find("input[name='priceRanage']").val(priceCut);
			$(obj).parent().find("input[name='netProfit']").val(netMaori);
			changePromSalePrice(itemNo,'','','');
			$(obj).addClass("errorInput");
			$(obj).attr("title", '促销售价必须小于正常售价*0.95!');
			return false;
		}
	  // });
	  if(!isPass)
	  {
	   return;
	  }
	    $(obj).removeClass("errorInput");
		var netCost = $(obj).parent().find("input[name='netCost']").val();
		var vat = $(obj).parent().find("input[name='vat']").val();
		var normSellPrice = $(obj).parent().find("input[name='normalSalePrice']").val();
		var priceCut="";
		var netMaori="";
		if(promSellPrice!=""){
		priceCut = roundFun ((normSellPrice-promSellPrice)/normSellPrice*100,2);
		netMaori = roundFun((((Number(promSellPrice)/( 1 + Number(vat/100)))-Number(netCost))/( Number(promSellPrice)/( 1 + Number(vat/100))))*100,3);
		var headMinMargin= $(obj).parent().find("input[name='headMinMargin']").val();
		var branchMinMargin=$(obj).parent().find("input[name='branchMinMargin']").val();
		if(netMaori<0){
			$(obj).parent().find("input[name='netProfit']").removeClass("hiLightYellowInput").addClass("hiLightInput");
			}else if(headMinMargin!=""&&headMinMargin!=null&&netMaori<parseFloat(headMinMargin)){
				$(obj).parent().find("input[name='netProfit']").removeClass("hiLightInput").addClass("hiLightYellowInput");
			}else if(branchMinMargin!=""&&branchMinMargin!=null&&netMaori<parseFloat(branchMinMargin)){
				$(obj).parent().find("input[name='netProfit']").removeClass("hiLightInput").addClass("hiLightYellowInput");
			}
		else{
			 $(obj).parent().find("input[name='netProfit']").removeClass("hiLightInput");
			 $(obj).parent().find("input[name='netProfit']").removeClass("hiLightYellowInput");
			}
		$(obj).parent().find("input[name='priceRanage']").val(priceCut);
		$(obj).parent().find("input[name='netProfit']").val(netMaori);
		}else{
			$(obj).parent().find("input[name='priceRanage']").val("");
			$(obj).parent().find("input[name='netProfit']").val("");
		}
		changePromSalePrice(itemNo,promSellPrice,priceCut,netMaori);
}

function   roundFun(numberRound,roundDigit)  {    //四舍五入，保留位数为roundDigit
		if   (numberRound>=0){
			var   tempNumber   =   parseInt((numberRound   *   Math.pow(10,roundDigit)+0.5))/Math.pow(10,roundDigit);
			return   tempNumber;
		} else{
			numberRound1=-numberRound;
			var   tempNumber   =   parseInt((numberRound1   *   Math.pow(10,roundDigit)+0.5))/Math.pow(10,roundDigit);
			return   -tempNumber;
		}
}
/*促销提示变化事件*/	
function promActvyChange(obj){
	var actvy=$(obj);
	var unitType=actvy.parent().find("select[name='unitType']").val();
	var unitNo=actvy.parent().find("input[name='promUnitNo']").val();
	var promActvy=actvy.val();
	for (var i = 0; i < unit.length; i++) {
  	    if(unit[i].unitType==unitType&&unit[i].promUnitNo==unitNo){
	       var unitJson=unit[i];
	       unitJson.promActvy=promActvy;
	       unit[i]=unitJson;
				       
  	    }
	}
}
/*促销提示内容变化事件*/
function promGiftHintChange(obj){
	var giftHint=$(obj);
	var unitType=giftHint.parent().find("select[name='unitType']").val();
	var unitNo=giftHint.parent().find("input[name='promUnitNo']").val();
	var promGiftHint=giftHint.val();
	for (var i = 0; i < unit.length; i++) {
  	    if(unit[i].unitType==unitType&&unit[i].promUnitNo==unitNo){
	       var unitJson=unit[i];
	       unitJson.promGiftHint=promGiftHint;
	       unit[i]=unitJson;
  	   }
	}
	
}
  	

/*显示删除的商品信息弹出框*/
function showDelItemDialog(){
  var buyBegin=$('#buyBegin').val();
  var sellBegin=$('#sellBegin').val();
  var pricePromType=$("#pricePromType").val();
  if(buyBegin=='1')
	  {
		  top.jAlert('warning', '促销进价已经开始,不能添加促销商品!', '提示消息');
          return;
	  }
  if(sellBegin=='1')
	  {
		 top.jAlert('warning', '促销售价已经开始,不能添加促销商品!', '提示消息');
         return;
	  }
	var unitType=$(".item_on").find("select[name='unitType']").val();
	var unitNo=$(".item_on").find("input[name='promUnitNo']").val();
	var storeNo=$("#storeNo").val();
	var catlgId = $("#catlgId").val();
	var itemsValue=[];
	if($.trim(unitNo)=='')
	{
		top.jAlert('warning', '请选择代号信息', '提示消息');
		return;
	}
	$("input[name='proStoreCK']").each(function(){
		itemsValue.push($(this).val());
	});
	if(unit.length > 0){
		    	for (var i = 0; i < unit.length; i++) {
		    		if(unitNo!= unit[i].promUnitNo){
		    		var itemArr = unit[i].itemArr;
		    		for(var j = 0; j < itemArr.length; j++) {
		    			var item=itemArr[j];
		    			itemsValue.push(item.itemNo);
		    		}
		    		}
		    	}
	 }
	    	
	var itemsId = itemsValue.join(",");
	top.openPopupWin(610,500, '/prom/nondm/store/showDeleteItemsList?unitType='+unitType+'&unitNo='+unitNo+'&storeNo='+storeNo+'&catlgId='+catlgId+'&itemsValue='+itemsId+'&pricePromType='+pricePromType);

}
/*返回删除商品结果*/
function addDelItemReturn(itemArr,itemStorArr){
	if (itemArr != ""){
			$(".zt_tit").scrollLeft(0);
			 $(".pro_store_tb").scrollLeft(0);
			var promUnitNo=$(".item_on").find("input[name='promUnitNo']").val();
			var unitType=$(".item_on").find("select[name='unitType']").val();
			for(var m=0;m<unit.length;m++)
				{
				  var unitJson=unit[m];
				   if(unitJson.unitType==unitType&&unitJson.promUnitNo==promUnitNo)
		    	   {
		    	       var itemJsonArr=unitJson.itemArr;
		    	       for(var n=0;n<itemArr.length;n++)
		    	    	   {
		    	    	   itemJsonArr.push(itemArr[n]);
		    
		    	    	   }
		    	       unit[m].itemArr=itemJsonArr;
		    	       $.ajax({
		    				//async : false,
		    				type : 'post',
		    				url : ctx + '/prom/nondm/store/getPromItemStoreList',
		    				data : {'storeItemJs':JSON.stringify(itemStorArr),'pricePromType':$("#pricePromType").val()},
		    				success : function(storeItemData) {
		    					$(".pro_store_tb").append(storeItemData);
		    				}
		    		     });
		    	   }
				}
			
		}
	  top.closePopupWin();
}
/*验证促销进价*/
function isMoney(param)
{
	var reg = /^([1-9][\d]{0,7}|0)(\.[\d]{1,4})?$/;
    if($.trim(param)=='')
    {
    	return true;
    }
    if(!reg.test(param)){  
       return false; 
     }
    else if(param==0){  
	       return false; 
	 }
    else
    {
    	return true;
    }
}
/*验证促销售价*/
function isSellMoney(param)
{
	var reg = /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;
    if($.trim(param)=='')
    {
    	return true;
    }
    if(!reg.test(param)){  
       return false; 
     }
    else if(param==0){  
	       return false; 
	 }
    else
    {
    	return true;
    }
}
/*检查是否是数字*/
function isNumber(param){  
    var reg = new RegExp("^[0-9]*$"); 
    if($.trim(param)=='')
    {
    	return true;
    }
    if(!reg.test(param)){  
       return false; 
     }
    else
    {
    	return true;
    }
} 
/*检查代号是否已经存在*/
function checkHasOne(unitType,unitNo){
    	if(unit.length > 0){
	    	for (var i = 0; i < unit.length; i++) {
	    		var json = unit[i];
	    		var jUnitType=json.unitType;
	    		var jUnitNo = json.promUnitNo;
	    		if(unitType==jUnitType && unitNo == jUnitNo){
	    			return false;
	    		}
	    	}
    	}else{
    		return true;
    	}
    	return true;
}
/*检查当前商品是否有没有作废的订单订单已经使用该促销期数*/
function checkPromIsInOrder(flag,itemNoStr){
 	var promNo = $("#promNo").val();
 	$.ajax({
 		 async : false,
		 url: ctx + '/prom/nondm/store/checkOrderItem?promNo='+promNo+'&flag='+flag+'&itemStr='+itemNoStr+'&ti='+(new Date()).getTime(),
	     type: "post",
	     success: function(result) {
	        if(result.message == 'success'){
	        	flag = true;
	        }
	     }
    });
    return flag;
}
/*检查商品是否已经存在*/
function checkHasItemNo(itemNo){
    	if(unit.length > 0){
	    	for (var i = 0; i < unit.length; i++) {
	    		var itemArr = unit[i].itemArr;
	    		for(var j = 0; j < itemArr.length; j++) {
	    			var item=itemArr[j];
	    			if(item.itemNo==itemNo){
		    			return false;
		    		}
	    		}
	    		
	    		
	    	}
    	}else{
    		return true;
    	}
    	
    	return true;
}
/*返回存在商品的代号 */
function returnHasItemNoUnit(itemNo){
    	if(unit.length > 0){
	    	for (var i = 0; i < unit.length; i++) {
	    		var itemArr = unit[i].itemArr;
	    		for(var j = 0; j < itemArr.length; j++) {
	    			var item=itemArr[j];
	    			if(item.itemNo==itemNo){
		    			return unit[i].promUnitNo;
		    		}
	    		}
	    	}
    	}else{
    	return "";
}
 return "";
}
/*关闭修改门店促销*/
function closeUpdateStoreProm(obj,pageNoList,pageSizeList) {
	var array = obj.split("#&");
	var subjName = encodeURI(array[1]);
	array[1] = encodeURI(subjName);
	window.location.href=ctx + '/prom/nondm/store/search?pageNoList='+pageNoList+'&pageSizeList='+pageSizeList+'&paramArray='+array;
}
/*输入代号验证 */
function enterInUnitNo(evt,obj){
	  $(".zt_tit").scrollLeft(0);
	  $(".pro_store_tb").scrollLeft(0);
	  var event=evt?evt:(window.event?window.event:null);//兼容IE和FF
	  if (event.keyCode==13){
		  obj.blur();
	}
}
/*促销价格keyup事件  回车触发blur事件*/
function promPriceKeyUp(obj,evt)	{
	var event=evt?evt:(window.event?window.event:null);//兼容IE和FF
	if (event.keyCode==13){
	    if($(obj).val()==''||obj.name=='promBuyPrice'||obj.name=='promSalePrice'){
	    	return;
	    }
	    try{
	        obj.blur();//回车触发blur事件
	    }
	    catch(e){};
	 }
}
/*返回字符字节 */
function charLen(s)
{
	var l = 0;
	var a = s.split("");
	for (var i=0;i<a.length;i++)
	{
		if (a[i].charCodeAt(0)<299) {
			l++;
			} 
		else {
			l+=2;
			}
	}
	return l;
 }