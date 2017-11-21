<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<script type="text/javascript">

function addStoreGrpType(){
	var flag = $("#flag").val();
	var catlgId = $("#catlgId").val();
	var unitNo =$("#no").val();
	var unitType = $("#unitType").val();
	var storeNo=$("#storeNo").val();
	var isSearch = $("#isSearch").val();
	var promType = $("#pricePromType").val();
	var buyStartDate = $("#buyStartDate").val();
	var buyEndDate = $("#buyEndDate").val();
	var promStartDate = $("#promStartDate").val();
	var promEndDate = $("#promEndDate").val();
	var promNo = $("#promNo").val();
	var singleUnitNo = '${singleUnitNo}';
	if(unitNo!="" && unitNo !=null){
	}else{
		top.jWarningAlert('请选择要添加的代号信息！');
		return ;
	}
	if(flag =="promART"){
		if(isSearch =="yes"){
			//top.window.$.zWindow.close({'key':'2',"promUnitNo":$("#no").val(),"promUnitName":$("#name").val()});
		    document.getElementById('contentIframe').contentWindow.addStoreGrpTypeReturn({'key':'2',"promUnitNo":$("#no").val(),"promUnitName":$("#name").val()});
		}else{
			$.ajax({
				async : true,
				url: ctx + '/prom/nondm/art/newGetARTJsonData',
		        type: "post",
		        dataType:"json",
		        data:{unitType:unitType,unitNo:unitNo,catlgId:catlgId,promType:promType,buyStartDate:buyStartDate,buyEndDate:buyEndDate,promStartDate:promStartDate,promEndDate:promEndDate,promNo:promNo,singleUnitNo:singleUnitNo},
		        success: function(result) {
		        	if (result.hasUnitFlag==1){
		        		top.jWarningAlert('该代号不存在！');
		        		return;
		            }
		        	if((result.hasUnitFlag==0)&&(result.list == null || result.list.length <=0)&&unitType!=0){
		        		top.jWarningAlert('该代号下的商品都已添加！');
		        		return;
		        	}
		        	
		        	if(result.list != null && result.list.length > 0){ 
		   				document.getElementById('contentIframe').contentWindow.addStoreGrpTypeReturn({"promUnitNo":$("#no").val(),"promUnitName":$("#name").val(),"list":result.list,"itemList":result.itemLis});
		        	}
		        }
		    }); 
			
			
		}
			

		
	}else if(flag=="promStore")
		{
		if(storeNo!=""&&storeNo!=null&&unitNo!="" && unitNo !=null){
		$.ajax({
    		//async : false,
    		url : ctx + '/prom/nondm/store/getPromItemStoreSupplier?ti='+(new Date()).getTime(),
    		data : {'storeNo':storeNo,'catlgId':catlgId,'clstrId':unitNo,'unitType':unitType,'pricePromType':promType},
    		type : 'POST',
    		success : function(response) {
    			var data=response['row'];
    			if(data==null)
    			{
    				top.jWarningAlert('该代号下不存在符合门店促销的商品，请重新选择代号！');
    			}
    			else
   				{
    				
   				//top.window.$.zWindow.close({'key':'2',"promUnitNo":$("#no").val(),"promUnitName":$("#name").val(),"list":data});
   				document.getElementById('contentIframe').contentWindow.addStoreGrpTypeReturn($("#no").val(),$("#name").val(),data);
   				}
    		}
		});
		}
		}else if(flag=="priceHO")
		{
			if (unitType != 0) {
				$.ajax({
					//async : false,
					url : ctx + '/prom/nondm/ho/searchItemList?ti=' + (new Date()).getTime(),
					data : {
						'promUnitNo' : unitNo,
						'unitType' : unitType,
						'catalgId' : catlgId
					},
					type : 'POST',
					success : function(response) {
						var data = response['row'];
						if(data==null)
		    			{
		    				top.jWarningAlert( '该代号下不存在商品，请重新选择代号！');
		    			}
		    			else
		    			{
		    				//top.window.$.zWindow.close({'key':'2',"promUnitNo":$("#no").val(),"promUnitName":$("#name").val()});
		       				document.getElementById('contentIframe').contentWindow.popUnitWinReturn($("#no").val(),$("#name").val());

		    			}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						top.jErrorAlert('网络超时!请稍后重试');
					}
				});
			} else {
				$.ajax({
					type : "post",
					url : ctx + '/prom/nondm/ho/showUnitDataAction',
					data : {
						unitType : unitType,
						itemNo : unitNo,
						catlgId : catlgId,
						pageNo : 1,
						pageSize : 1
					},
					success : function(result) {
						var unitName_v = result["unitName"];
						if (unitName_v == "") {
		    				top.jWarningAlert( '该商品没有厂商，请重新选择商品！');
		    			}
		    			else
		    			{
		    				//top.window.$.zWindow.close({'key':'2',"promUnitNo":$("#no").val(),"promUnitName":$("#name").val()});
		       				document.getElementById('contentIframe').contentWindow.popUnitWinReturn($("#no").val(),$("#name").val());

		    			}
					}
				});
			}
		}

	else{
		//top.window.$.zWindow.close({'key':'2',"promUnitNo":$("#no").val(),"promUnitName":$("#name").val()});
		document.getElementById('contentIframe').contentWindow.addStoreGrpTypeReturn($("#no").val(),$("#name").val());

	}
	
	
	
}
function onClickRow(obj){
	$("#no").val($(obj).find("input[name='promNo']")[0].value);
	$("#name").val($(obj).find("input[name='promName']")[0].value);
}

function onDblClickRow(obj)
{
	var flag = $("#flag").val();
	var catlgId = $("#catlgId").val();
	var unitNo =$("#no").val();
	var unitType = $("#unitType").val();
	var storeNo=$("#storeNo").val();
	var isSearch = $("#isSearch").val();
	var pricePromType=$("#pricePromType").val();
	var buyStartDate = $("#buyStartDate").val();
	var buyEndDate = $("#buyEndDate").val();
	var promStartDate = $("#promStartDate").val();
	var promEndDate = $("#promEndDate").val();
	var promNo = $("#promNo").val();
	var singleUnitNo = '${singleUnitNo}';
	if(unitNo!="" && unitNo !=null){
	}else{
		top.jWarningAlert('请选择要添加的代号信息！');
		return ;
	}
	if(flag =="promART"){
		if(isSearch =="yes"){
			top.window.$.zWindow.close({'key':'2',"promUnitNo":$("#no").val(),"promUnitName":$("#name").val()}); 
		}else{
			$.ajax({
				url: ctx + '/prom/nondm/art/newGetARTJsonData',
		        type: "post",
		        dataType:"json",
		        data:{unitType:unitType,unitNo:unitNo,catlgId:catlgId,promType:pricePromType,buyStartDate:buyStartDate,buyEndDate:buyEndDate,promStartDate:promStartDate,promEndDate:promEndDate,promNo:promNo,singleUnitNo:singleUnitNo},
		        success: function(result) {
		        	if (result.hasUnitFlag==1){
		        		top.jWarningAlert('该代号不存在！');
		        		return;
		            }
		        	if((result.hasUnitFlag==0)&&(result.list == null || result.list.length <=0)&&unitType!=0){
		        		top.jWarningAlert('该代号下的商品都已添加！');
		        		return;
		        	}
		        	
		        	if(result.list != null && result.list.length > 0){ 
		   				document.getElementById('contentIframe').contentWindow.addStoreGrpTypeReturn({"promUnitNo":$("#no").val(),"promUnitName":$("#name").val(),"list":result.list,"itemList":result.itemList});
		        	}
		        }
		    }); 
			
			
		}
			

		
	}else if(flag=="promStore")
		{
		if(storeNo!=""&&storeNo!=null&&unitNo!="" && unitNo !=null){
		$.ajax({
    		async : false,
    		url : ctx + '/prom/nondm/store/getPromItemStoreSupplier?ti='+(new Date()).getTime(),
    		data : {'storeNo':storeNo,'catlgId':catlgId,'clstrId':unitNo,'unitType':unitType,'pricePromType':pricePromType},
    		type : 'POST',
    		success : function(response) {
    			var data=response['row'];
    			if(data==null)
    			{
    				top.jWarningAlert('该代号下不存在符合门店促销的商品，请重新选择代号！');
    			}
    			else
   				{
       				document.getElementById('contentIframe').contentWindow.addStoreGrpTypeReturn($("#no").val(),$("#name").val(),data);
   				}
    		}
		});
		}
		}else if(flag=="priceHO")
		{
			if (unitType != 0) {
				$.ajax({
					async : false,
					url : ctx + '/prom/nondm/ho/searchItemList?ti=' + (new Date()).getTime(),
					data : {
						'promUnitNo' : unitNo,
						'unitType' : unitType,
						'catalgId' : catlgId
					},
					type : 'POST',
					success : function(response) {
						var data = response['row'];
						if(data==null)
		    			{
		    				top.jWarningAlert('该代号下不存在商品，请重新选择代号！');
		    			}
		    			else
		    			{
		    				//top.window.$.zWindow.close({'key':'2',"promUnitNo":$("#no").val(),"promUnitName":$("#name").val()});
		       				document.getElementById('contentIframe').contentWindow.popUnitWinReturn($("#no").val(),$("#name").val());

		    			}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						top.jErrorAlert('网络超时!请稍后重试');
					}
				});
			} else {
				$.ajax({
					type : "post",
					url : ctx + '/prom/nondm/ho/showUnitDataAction',
					data : {
						unitType : unitType,
						itemNo : unitNo,
						catlgId : catlgId,
						pageNo : 1,
						pageSize : 1
					},
					success : function(result) {
						var unitName_v = result["unitName"];
						if (unitName_v == "") {
		    				top.jWarningAlert('该商品没有厂商，请重新选择商品！');
		    			}
		    			else
		    			{
		    				//top.window.$.zWindow.close({'key':'2',"promUnitNo":$("#no").val(),"promUnitName":$("#name").val()});
		       				document.getElementById('contentIframe').contentWindow.popUnitWinReturn($("#no").val(),$("#name").val());

		    			}
					}
				});
			}
		}else{
			document.getElementById('contentIframe').contentWindow.addStoreGrpTypeReturn($("#no").val(),$("#name").val());

		}
}


</script>
<style type="text/css">
.tp_store_bottom {
	margin: 15px 20px;
	height: 280px;
	border: 1px solid #e5e5e5;
}

.txi_list {
	height: 250px;
	overflow-y: auto;
	overflow-x: hidden;
}
/*overwrite*/
.cbankIcon {
	float: right;
	margin-right: 1px;
}

.item .item_gou {
	margin-top: 7px;
}

.item {
	padding-left: 15px;
	line-height: 30px;
}

/* .btable_div,.htable_div {
	width: 98%;
	margin-left: 1%;
	border-bottom:0;
} */
.htable_div{
	padding:0;margin-top:4px;background:#eee;
}
.btable_div{
border-bottom:1px solid #eee;overflow-x:hidden;
}
.errorInput {
	border-color: #f00 !important;
	background-color: #FFC1C1 !important;
}
.IS_input {
	width: 95%;
	float: left;
	margin-top: 2px;
}

</style>

<form name="showUnitWinFrom" id="showUnitWinFrom" onSubmit="return false;">

<div class="Panel_top">
	<span>选择代号</span>
	<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div style="margin: 15px auto 5px auto; width: 97%; height: 100%;">
		
		<div style="height: 30px; background: #CCC;">
			<div class="Icon-div">
				<input type="text"  name="selectSereisItemName" onkeydown="enterIn(event);" placeholder="请输入货号或代号名称" class="IS_input" id="selectSereisItemName"/>
               	<input type="hidden" name = "itemNo"  id="itemNo"/>
               	<input type="hidden" name = "itemName"  id="itemName"/>
                <div class="cbankIcon" id="selectSeriesItem"></div>
			</div>
		</div>
		<div id="showUnitList" style="height: 300px">
			
		</div>
	
	</div>
</div>
<input id="no" type="hidden" />
<input id="name" type="hidden" />
<input id="catlgId" name="catlgId" value="${catlgId }" type="hidden" />
<input id="unitType" name="unitType" value="${unitType }" type="hidden" />
<input id="flag" name="flag" value="${flag }" type="hidden" />
<input id="storeNo" name="storeNo" value="${storeNo }" type="hidden" />
<input id="isSearch" name="isSearch" value="${isSearch }" type="hidden" />
<input id="pricePromType" name="pricePromType" value="${pricePromType }" type="hidden" />
<input id="buyStartDate" name="buyStartDate" value="${buyStartDate }" type="hidden" />
<input id="buyEndDate" name="buyEndDate" value="${buyEndDate }" type="hidden" />
<input id="promStartDate" name="promStartDate" value="${promStartDate }" type="hidden" />
<input id="promEndDate" name="promEndDate" value="${promEndDate }" type="hidden" />
<input id="promNo" name="promNo" value="${promNo}" type="hidden" />
</form>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1 btn" onclick="addStoreGrpType()">确定</div>
		<div class="PanelBtn2 btn" onclick="closePopupWin()">取消</div>
	</div>
</div>
<div style="clear: both;"></div>
<script type="text/javascript">
function pageQuery() {
	var mySeriesItem=$.trim($("#selectSereisItemName").val());
	//if(mySeriesItem==""&&mySeriesItem!='请输入代号名称'){
	if(mySeriesItem==""&&mySeriesItem!='请输入货号或代号名称'){
		$("#selectSereisItemName").attr("title","请注意查询条件");
		return;
	}	
	 if(isNumber(mySeriesItem)){
		 $("#itemNo").val(mySeriesItem);
		 $("#itemName").val('');
	}else{
		$("#itemName").val(mySeriesItem);
		$("#itemNo").val('');
		
	} 
  
	 var param = $("#showUnitWinFrom").serialize();
	 $.ajax({
			type : "post",
			//async:false,
			data :param,	
			dataType : "html",
			url: ctx + '/prom/nondm/store/showUnitData?ti='+(new Date()).getTime(),
			success : function(data) {
				$('#showUnitList').html(data);
			}
		});
	
}

$(function(){
	//查询数据
	//pageQuery();
	//设置光标在此位置
	//$("#selectSereisItemName").focus();
	
     //查询事件
    $("#selectSeriesItem").unbind("click").bind("click",searchData);
    $("#dt").focus(function (e) {
        $e = $(e.target);
        $e.val('').removeClass("defaultText");
    });
    $("#dt").blur(function (e) {
        $e = $(e.target);
        if ($e.val() == '') {
            $e.val('请填写内容').addClass("defaultText");
        }
    });
     
});

function searchData(){
	var mySeriesItem=$.trim($("#selectSereisItemName").val());
	//if(mySeriesItem!=""&&mySeriesItem!='请输入代号名称'){
	if(mySeriesItem!=""&&mySeriesItem!='请输入货号或代号名称'){
		$("#pageNo").val(1);
		pageQuery();
	}else{
		$("#selectSereisItemName").removeClass().addClass("IS_input errorInput");
		$("#selectSereisItemName").attr("title","请注意查询条件");
	}	
}

function isNumber(param){  
    var reg = new RegExp("^[0-9]{1,8}$"); 
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
$("#selectSereisItemName").focus(function(){
	$(this).removeClass("IS_input errorInput").addClass("IS_input");
	$(this).attr("title","");
});
function enterIn(evt){
	  var eve=evt?evt:(window.event?window.event:null);//兼容IE和FF
	  if (eve.keyCode==13){
		  searchData();	
	}
}
</script>

