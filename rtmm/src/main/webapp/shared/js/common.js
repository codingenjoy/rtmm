$.ajaxSetup({
	contentType:"application/x-www-form-urlencoded;charset=utf-8",
	beforeSend:function(){
		if(this.dataType!='script'){
			try{
				top.grid_layer_open();
			}catch(e){
				log(xhr.status + ',url=' + this.url + ',error=' +e);
			}
		}
		//log('url=' + this.url + ',data=' + this.data);
	},
	complete:function(xhr,textStatus){
		try{
			// 通过XMLHttpRequest取得响应头，sessionstatus
			var sessionstatus=xhr.getResponseHeader("sessionstatus"); 
			if(sessionstatus=="timeOut"){
				top.location.href = ctx + "/toLogin";
			}
			var exception=xhr.getResponseHeader("exception");
			if(exception){
				top.jAlert('error','系统建设中，敬请期待','提示消息');
			}
		}catch(e){
			log(xhr.status + ',url=' + this.url + ',error=' +e);
		}
		if(this.dataType!='script'){
			log('code='+xhr.status + ',url=' + this.url + ',data=' + this.data);
			try{
				top.grid_layer_close();
			}catch(e){
				log(xhr.status + ',url=' + this.url + ',error=' +e);
			}
		}
	},
	success :function(data,textStatus){
		if(this.dataType!='script'){
			try{
				top.grid_layer_close();
			}catch(e){
				log(xhr.status + ',url=' + this.url + ',error=' +e);
			}
		}
	},
	error:function(XMLHttpRequest,textStatus){
	
		if(this.dataType!='script'){
			try{
				top.grid_layer_close();
			}catch(e){
				log(xhr.status + ',url=' + this.url + ',error=' +e);
			}
		}
	}

});

//Check whether the parameter is a function
function isFunction (/*Object*/obj) {
	return $.type(obj) === "function";
}

//Print a message to the console
function log(/*String*/message) {  
	//console.log(message);
	var curTime = new Date().format("yyyy-MM-dd hh:mm:ss");
	if (message)
		message = curTime + ',' + message;
	try{
	    var myconsole = document.getElementById('console')||top.document.getElementById('console');
	    var p = document.createElement('p');    
	    p.appendChild(document.createTextNode(message));  
	    myconsole.appendChild(p);  
	    while (myconsole.childNodes.length > 25) {  
	    	myconsole.removeChild(myconsole.firstChild);  
	    }  
	    myconsole.scrollTop = myconsole.scrollHeight;  
	}catch(e){
		//log(e);
	}
}

//Close message console
function closeLogConsole(){
	showConsole = false;
	$('#consoleDiv').hide();
}

//Check whether the string for a specified length of digital
function isNumber(/*String*/str,/*Int*/len) {
	len=len||10;
	var number = new RegExp("^[0-9]{1,"+len+"}$");
	if (number.test($.trim(str))) {
		return true;
	} else {
		return false;
	}
}

//Check whether the string for a specified length,scale of digital
function isFloat(/*String*/str,/*Int length-1*/len,/*Int*/scale) {
	var reg = new RegExp("^([1-9][0-9]{0," + len + "}|0)([.][0-9]{0,"+ scale + "})?$");
	if (reg.test($.trim(str))) {
		return true;
	}
	return false;
}

//日期转换,例如new Date().format("yyyy-MM-dd hh:mm:ss");
Date.prototype.format = function(format) {
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds() // millisecond
	};
	if (/(y+)/.test(format))
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
	return format;
};

// 打开弹出框
function openPopupWin(/*Int*/windowWidth,/*Int*/ windowHeight,/*String*/actionUrl,/*optional*/top) {
	var selector = "#popupWin";
	top=top!=undefined?top:null;
	$(selector).window({
		width : windowWidth,
		height : windowHeight,
		draggable : true,
		resizable : false,
		modal : true,
		shadow : false,
		border : false,
		noheader : true,
		top : top
	});
	$(selector).css("display", "block");
	$(selector).window("open");
	$(selector).window('refresh', ctx + actionUrl);
	window.windowSelector = selector;
}

// 关闭弹出框
function closePopupWin() {
	$("#popupWin").html('');
	$("#popupWin").window("close");
}

// 打开弹出框
function openPopupWinTwo(/*Int*/windowWidth, /*Int*/windowHeight,/*String*/actionUrl,/*Int*/left) {
	var selector = "#popupWinTwo";
	$(selector).window({
		width : windowWidth,
		height : windowHeight,
		draggable : true,
		resizable : false,
		modal : true,
		shadow : false,
		border : false,
		noheader : true,
		left : left
	});
	$(selector).css("display", "block");
	$(selector).window("open");
	$(selector).window('refresh', ctx + actionUrl);
	window.windowSelector = selector;
}

// 关闭弹出框
function closePopupWinTwo() {
	$("#popupWinTwo").html('');
	$("#popupWinTwo").window("close");
}

//展示内容区域
function showContent(/*String*/url,/*Json Object*/param) {
	if (!param) {
		param = {};
	}
	if (url != "") {
		if (url.indexOf(ctx) != 0) {
			url = ctx + url;
		}
		
		if(pmenuid==21){
			top.grid_layer_open();
			var iframe = $("<iframe id='contentIframe' frameBorder='0' style='width:100%;height:650px;' scrolling='no' src='"+url+"'/>");
			$("#content").html(iframe);
			top.grid_layer_close();
		}else{
			$.post(url,param,function(data){
				$("#content").html(data);
			},'html');
		}
	} else {
		$("#content").html("<font>系统建设中，敬请期待。</font>");
	}
}
//从字典表取数据(先从缓存中找，找不到就去数据库查找)
var dictList = [];
function getDictValue(/*String*/mdGrpKey,/*Int*/code,/*Int*/showType) {
	var result = '';
	var find = false;
	if(dictList.length>0){
		$.each(dictList,function(index,item){
			if(item.key == mdGrpKey && item.code == code){
				if (showType == 2) {
					var itemTitle = item.title;
					result = itemTitle.substring(itemTitle.indexOf("-") + 1, itemTitle.length);
				} else {
					result = item.title;
				}
				find = true;
				return false;
			}
		});
	}
	if(!find){
		$.ajax({
			type : "post",
			url : ctx + '/commons/window/getDictValue',
			async : false,
			contenttype :"application/x-www-form-urlencoded;charset=utf-8", 
			dataType : "json",
			data : {
				'mdGrpKey' : mdGrpKey,
				'code' : code
			},
			success : function(data) {
				dictList.push({'key':mdGrpKey,'code':data.code,'title':data.code+'-'+data.title});
				if (showType == 2 ) {
					result = data.title;
				} else {
					result = data.code+'-'+data.title;
				}
			},
			error : function(data) {
				result = '';
			}
		});
	}
	return result;
}

function onMenuItemClick(/*Int*/mid){
	$.ajax({
	   type: "POST",
	   url: ctx+"/subMenu/"+mid,
	   global : false,
	   beforeSend:function(){
	   },
	   complete:function(XMLHttpRequest,textStatus){
	   },
	   dataType : 'html',
	   success: function(msg){
		   $("#content_body").html(msg);
	   }
	});
}

function onSubMenuItemClick(/*Int*/mid){
	var url = $.trim($("#"+mid).attr("auchanurl"));
	if(url==""||url==undefined){
		return false;
	}
	showContent(url);
}

function joinObject(/*JSON List*/list,/*String*/key,/*String*/sep) {
	var array = [];
	for (var i = 0; i < list.length; i++) {
		array.push(list[i][key]);
	}
	return array.join(sep);
};

$('.Tools20').live("click",function(){
	$.each($(".clean_from .Search").find('input'),function(index,item){
		if(!item.readOnly||$(item).hasClass('Wdate')){
			$(item).removeClass('errorInput');
			$(item).attr('title','');
			$(item).attr('value','');
		}
	});
	$.each($(".clean_from .Search").find('select'),function(index,item){
		if(!item.disabled){
			$(item).removeClass('errorInput');
			$(item).attr('title','');
			$(item).attr('value','');
		}
	});
});
/*check if having error in the seach input textboxes.*/
function ifHaveErrorInputInSearch(){
	var errorFlag=false;
	$.each($(".clean_from .Search").find('input'),function(index,item){
		if(!item.readOnly||$(item).hasClass('Wdate')){
			if($(item).hasClass('errorInput')){
			errorFlag=true;
			return false;
			}
		}
	});
	$.each($(".clean_from .Search").find('select'),function(index,item){
		if(!item.disabled && $(item).hasClass('errorInput')){
			errorFlag=true;
			return false;
		}
	});	
	return errorFlag;
}

/**输入整数值*/
function inputToInputIntNumber(){
	$("input.count_text").keyup(function () {
	    if ($(this).val()!='' && !(/^\d+$/).test($(this).val())) {
	    	if($(this).val()==' '){
	    		$(this).val('');
	    		return false;
	    	}
	    	if($(this).val()!=''){
	    		$(this).val($(this).attr('preval'));
	    	}
	    	return true; 
	    }
	    $(this).attr('preval',$(this).val());
	});
}
/**输入小数值 double_text*/
function inputToInputDoubleNumber(){
	$("input.double_text").keyup(function () {
		
		if ($(this).val().indexOf(".") < 0) {
			if ($(this).val()!=''&&!(/^\d{0,3}$/).test($(this).val())) {
				if($(this).val()==' '){
					$(this).val('');
					return false;
				}
				if($(this).val()!=''){
					$(this).val($(this).attr('preval'));
				}
				return true;
			}
			$(this).attr('preval',$(this).val());

		} else {
			if ($(this).val()!=''&&!(/^\d+[.]{0,1}\d{0,2}$/).test($(this).val())) {
				if($(this).val()==' '){
					$(this).val('');
					return false;
				}
				if($(this).val()!=''){
					$(this).val($(this).attr('preval'));
				}
				return true;
			}
			$(this).attr('preval',$(this).val());
		}
	});
}

function loadSelectDiv(obj,dataList,type){
	try{
		var attr1 = obj.attr('acCode');
		var attr2 = obj.attr('acTitle');
		var acWidth = obj.attr('acWidth');
		//alert(obj.attr('id')+"   "+attr1+"   "+attr2+" dataList:"+dataList);
		var nextInputObjId = $.trim(obj.attr('nextInputObjId'));//input的id
		if($.trim(attr1)==''){
			attr1='code';
		}
		if($.trim(attr2)==''){
			attr2='title';
		}
		if($.trim(acWidth)==''){
			acWidth = obj.attr('width');
		}
		$(obj).autocomplete(dataList, {
		    minChars: 0,
		    width: acWidth,
			max:	3000,
		    matchContains: true,
		    matchCase:false,
		    autoFill: false,
		    dataType: 'json',
		    formatItem: function(row, i, max) {
		    	switch(type){
		    	  case 0:
			        	return row[attr2];
		    	  case 1:
		        	return row[attr1]+"-"+row[attr2];
		    	  case 2:
		    		return row[attr2];
		    	  case 3:
			    	return row[attr1]+"-"+row[attr2];
		    	  default:
		    		return row[attr1]+"-"+row[attr2];
		    	}
		    },
		    formatMatch: function(row, i, max) {
		    	switch(type){
		    	  case 0:
		    	  case 1:
		        	return row[attr1];
		    	  case 2:
		    		return row[attr2];
		    	  case 3:
			    	return row[attr2];
		    	  default:
		    		return row[attr1]+"-"+row[attr2];
		    	}
	
		    },
		    formatResult: function(row) {
		    	switch(type){
		    	  case 0:
		    	  case 1:
		        	return row[attr1];
		    	  case 2:
		    		return row[attr2];
		    	  case 3:
		    		return row[attr2];
		    	  default:
		    		return row[attr1]+"-"+row[attr2];
		    	}
		    }
		    
		}).result(function(event, data, formatted) {
			//$(this).val(data[attr1]+"-"+data[attr2]);
			var _nextInputObjId = nextInputObjId;
			while($.trim($('#'+_nextInputObjId).attr('nextInputObjId'))!=''){
				$('#'+_nextInputObjId).val('');
				var _nextInputObjId2 = $('#'+_nextInputObjId).attr('setValueObjId');
				$('#'+_nextInputObjId2).val('');
				_nextInputObjId = $('#'+_nextInputObjId).attr('nextInputObjId');
				$('#'+_nextInputObjId).unautocomplete();
			}
			if(nextInputObjId!=''){
				var nextInputObj = $('#'+nextInputObjId);
				var currUrl=nextInputObj.attr('currUrl');
				var setValueObjId=$(this).attr('setValueObjId');
				var nextObjData;
				var setValueObj = $(this).parent().find('input#'+setValueObjId);
				if(setValueObj.size()==0){
					setValueObj = $(this).parent().parent().find('input#'+setValueObjId);
				}
				if(setValueObj.size()>0){
					if($.trim(type)!=1){
						$(setValueObj).val(data[attr1]);
					}
					else{
						$(setValueObj).val(data[attr2]);
					}
				}
				$.ajaxSetup({async : false});
				$.post(ctx + currUrl+data[attr1],function(data){
					nextObjData = data;
				});
				$.ajaxSetup({async : true});
				
				return loadSelectDiv(nextInputObj,nextObjData,type);
			}
			else{
				var setValueObjId=$(this).attr('setValueObjId');
				var setValueObj = $(this).parent().find('input.'+setValueObjId);
				if(setValueObj.size()==0){
					setValueObj = $(this).parent().parent().find('input.'+setValueObjId);
				}
				setValueObj.removeClass('errorInput');
				if(setValueObj.size()>0){
					if($.trim(type)!=1 && $.trim(type)!=0){
						$(setValueObj).val(data[attr1]);
					}
					else{
						$(setValueObj).val(data[attr2]);
					}
				}
			}
		    });
	}
	catch(e){
		
	}
}

//查询课别信息
function readCatalogInfoBySecNo(/*Int*/secNo,/*String*/methodName) {
	$.post(ctx + '/commons/window/readCatalogInfoBySecNo?tt='+ new Date().getTime(),{
		secNo : secNo		
	},function(data){
		methodName(data);
	},'json');
}

//查询商品信息
function readItemInfoBySecNoAndItemNo(/*Int*/itemNo,/*Int*/secNo,/*String*/methodName) {
	$.post(ctx + '/commons/window/readItemInfoBySecNoAndItemNo?tt='+ new Date().getTime(),{
		itemNo:itemNo,
		secNo : secNo		
	},function(data){
		methodName(data);
	},'json');
}


//查询厂商信息
function readSupInfoBySupNo(/*Int*/catlgId,/*Int*/supNo, /*String*/methodName) {
	$.post(ctx + '/commons/window/readSupInfoBySupNo?tt='+ new Date().getTime(),{
		catlgId : catlgId,
		supNo:supNo
	},function(data){
		methodName(data);
	},'json');
}

/**
 * 对比数组中是否包含某个值/对象
 * @param array 数组Array
 * @param item  值/对象
 * @returns   包含 true / 不包含 false
 */
function containsArray(array,item){
	var containsCount = 0;
	if(typeof(array) != "undefined" && array.length > 0 ){
		for(var i in array){
			if(array[i] == item){				
				containsCount++;
			}			
		}		
	}
	if(containsCount > 0){
		return true;		
	}else{
		return false;
	}	
	}
	
/**
 * 移除数组中的值
 * @param array 数组
 * @param item  值/对象
 */
function removeElementForArray(array,item){	
	if( typeof(array)!="undefined" && array.length>0){
	for (var i = 0; i < array.length; i++) {
		if (array[i] == item) {
			//移除
			array.splice(i, 1);
		}
	}	
 }
}

/**
 * 将数组2中的所有数据添加到数据1
 * @param array1 数组1
 * @param array2 数组2
 */
function pushAllForArray(array1,array2){
	if(typeof(array1)!="undefined" && typeof(array1)!="undefined" && array2.length>0){
		for(var item in array2){
			array1.push(array2[item]);	
		}	
	}				
}
/*get the days between the start date and the end date. */
function getSubDays(/*start date*/strDateStart,/*end date*/strDateEnd){
	var iDays; 
	var strSeparator = "-"; //split mark of date
	var oDate1; 
	var oDate2; 
	oDate1= strDateStart.split(strSeparator); 
	oDate2= strDateEnd.split(strSeparator); 
	var strDateS = new Date(oDate1[0], oDate1[1]-1, oDate1[2]); 
	var strDateE = new Date(oDate2[0], oDate2[1]-1, oDate2[2]); 
	iDays = parseInt((strDateE - strDateS)/ 1000 / 60 / 60 /24);//transform the milliseconds into the days.
	return iDays;
}

function rtmmCall(functionNameStr){ 
	eval(functionNameStr); 
}

function joinPostParam(/* String */str,/* String */pName, /* Object */pValue) {
	if (str) {
		str = str + "&" + pName + "=" + pValue;
	} else {
		str = str + "?" + pName + "=" + pValue;
	}
	return str;
}