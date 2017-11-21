<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/tree.css" rel="Stylesheet" />
<style type="text/css">
.Table_Panel {
	height: 325px;
	overflow: hidden;
}

.CM_p {
	height: 280px;
	width: 595px;
	margin: 20px 2px 0px 20px;
}

.t2,.t3 {
	height: 240px;
	overflow-x: hidden;
	overflow-y: auto;
	float: left;
	background: #fff;
	margin-top: 20px;
	border: 1px solid #808080;
}

.t2 {
	width: 328px;
	margin-left: 20px;
}

.t3 {
	width: 200px;
	margin-left: 5px;
}

.CM2 {
	background: #f9f9f9;
	width: 296px;
	height: 240px;
	float: right;
	margin-top: 3px;
}

.b {
	height: 209px;
	overflow: auto;
}

.d {
	width: 235px;
	height: 200px;
	background: #fff;
	margin: 20px auto auto 40px;
	border: 1px solid #808080;
}

.e,.f,.b {
	width: 215px;
	margin: 0 auto;
	line-height: 26px;
}

.e {
	overflow: auto;
	height: 169px;
	width:95%;
}

.e div,.b div {
	border-top: 1px solid #fff;
	height: 28px;
	cursor: pointer;
}

.f {
	border-top: 1px solid #808080;
	height: 30px;
	width:95%;
}

.tree-icon {
	display: none;
}

.Panel_footer {
	width: 937px;
}

.first_div {
	height: 100%;
	width: 100%;
}

.second_div {
	height: 89px;
	width: 100%;
	margin-top: 2px;
}
</style>
<script type="text/javascript">
/*check all the hype market when multiply modify
  the item store page.*/	
function hypeMarketCheckAll(obj) {
	
	if (obj.checked) {
		$('#storeDiv').find("input[name='hypeMarketNo']").not('[disabled="disabled"]').attr(
				'checked', true);
	} else {
		$('#storeDiv').find("input[name='hypeMarketNo']").not('[disabled="disabled"]').attr(
				'checked', false);
	}
}
/*check all the logistics center when multiply modify
the item store page.*/	
function dcCenterCheckAll(obj) {
	if (obj.checked) {
		$('#dcCenterDiv').find("input[name='machiningNo']").not('[disabled="disabled"]').attr(
				'checked', true);
	} else {
		$('#dcCenterDiv').find("input[name='machiningNo']").not('[disabled="disabled"]').attr(
				'checked', false);
	}
}

/*check all the machine center when multiply modify
the item store page.*/	
function machinCheckAll(obj) {
	if (obj.checked) {
		$('#dcCenterDiv').find("input").not('[disabled="disabled"]').attr(
				'checked', true);
	} else {
		$('#dcCenterDiv').find("input").not('[disabled="disabled"]').attr(
				'checked', false);
	}
}

</script>
<div class="Panel_top">
	<span>选择需要订购商品的门店</span>
	<div class="PanelClose" onclick="closePopupWinTwo()"></div>
</div>
<div class="Table_Panel">
	<div class="" style="width: 615px; height: 285px; float: left;">
		<div class="CM_p CM">
			<div class="CM-bar" style="height: 280px;">
				<div>大卖场</div>
			</div>
			<div class="t2" id="hypeMarCity">
				<ul id="itemChgPriArea"></ul>
			</div>
			<div class="t3">
				<div class="b inputDiv" style="width: 180px;" id="storeDiv"></div>
				<div class="f" style="width: 180px;">
					<label> <input id="storeCheckAll" type="checkbox"
						name="hypeMarketNoAll" class="checkAll"
						onclick="hypeMarketCheckAll(this)" />
					</label><span>全选</span>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="Panel_footer" style="width: 610px;">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="addStoreLs()">确定</div>
		<div class="PanelBtn2" onclick="closePopupWinTwo()">取消</div>
	</div>
</div>
<script type="text/javascript">
      var storeStr = '${storeStr}';
    	$(function(){	
    		/**
    		 * 新增下傳區域, 選擇下傳區域彈出框: 點選店時檢查全選框
    		 */
    		$("input[name='hypeMarketNo']").die().live('click', function(){
    			var name = $(this).attr("name");    			
    		   /*judge if check the checkAll box.*/
    				if ($(".check[name="+ name + "]:checked").not('[disabled="disabled"]').length == $(".check[name="+ name + "]").not('[disabled="disabled"]').length){
    					$(".checkAll[name='hypeMarketNoAll']").attr("checked","checked");
    				}
    				else{
    					$(".checkAll[name='hypeMarketNoAll']").removeAttr("checked");
    				}
    		});
    		
    		var itemNo = $('.pro_store_tb_edit .item_on').find("input[name='itemNo']").val();
    		var ordSupNo=$('#supId').val();
    		var ordCatlgId=$('#catlgId').val();
    		
    		$('#itemChgPriArea').find('li').remove();//先删除树
    		$.post(ctx + "/order/getItemRegion?itemNo="+itemNo + '&catlgId=' + ordCatlgId + '&supId=' + ordSupNo,{ 
    		}, function(data) {
    			$('#itemChgPriArea').tree({
    				checkbox : true,
    				data : data.tree,
    				onClick : function(node) {},
    				onCheck : function(node,checked) {
    					var pn1 = $('#itemChgPriArea').tree('getParent', node.target);
    					var pn2=null,pn3=null;
    					var nodeLvl=1;
    					if(pn1!=null){
    						nodeLvl=2;
    						pn2 = $('#itemChgPriArea').tree('getParent', pn1.target);
    						if(pn2!=null){
    							nodeLvl=3;
    							pn3 = $('#itemChgPriArea').tree('getParent', pn2.target);
    							if(pn3!=null){
    								nodeLvl=4;
    							}
    						}
    					}
    					var nodes = $('#itemChgPriArea').tree('getChildren', node.target);
    					if(checked){
    						var disabledNodes = $('.tree-node[disable="disabled"]');
    						var _str = '';
    						if(nodes.length>0){
    							for(var i=0;i<nodes.length;i++){
    								var breakFlag = false;
    								for(var j=0;j<disabledNodes.size();j++){
    									var nodeId = $(disabledNodes[j]).attr('node-id');
    									if(nodeId==nodes[i].id){
    										breakFlag = true;
    										break;
    									}
    								}
    								if(breakFlag){
    									continue;
    								}
    								_str = _str +","+ nodes[i].id;
    							}
    						}
    						else{
    							_str = _str +","+ node.id;
    						}
    						_str = _str.substr(1);
    						if($.trim(_str)==''){
    							return;
    						}
    						//获取下传门店
    						$.post(ctx + "/order/getStoreList?itemNo="+itemNo+"&regnNoList="+_str + '&catlgId=' + ordCatlgId + '&supId=' + ordSupNo,function(data){
    							if(data){
    								var allStr = '';
    								var storeDivStr = '';
    								var dcCenterDivStr = '';
    								$.each(data, function(index, value) {
    										if(value.bizType==1){
    											storeDivStr+='<div class="item2'+value.regnNo+'"><label>';
    											storeDivStr+='<input type="checkbox" class="check"  name="hypeMarketNo" tagNameTitle="'+value.storeName+'" value="'+value.storeNO+'">';
    											storeDivStr+='</label><span>'+value.storeNO+'-'+value.storeName+'</span></div>';
    										}
    									});
    								$('#storeDiv').append(storeDivStr);
    								$('#dcCenterDiv').append(dcCenterDivStr);
    								var orderStoreArray=[];
    								$("input[name='storeNoCk']").each(function(){
    									orderStoreArray.push($(this).val().split("_")[0]);
    								});
    		    					for (var index = 0; index < orderStoreArray.length; index++) {
    		    						var storeNo = orderStoreArray[index];
    		    						$('input[name="hypeMarketNo"][value='+storeNo+']').attr('disabled',true);
    								}
    		    					for (var index = 0; index < orderStoreArray.length; index++) {
    		    						var storeNo = orderStoreArray[index];
    		    						$('input[name="machiningNo"][value='+storeNo+']').attr('disabled',true);
    								}
    							}
    						});
    				}
    				else{
							if(nodes.length>0){
								for(var i=0;i<nodes.length;i++){
									$('#storeDiv .'+nodes[i].id).remove();
									$('#dcCenterDiv .'+nodes[i].id).remove();
								}
							}
							else{
								$('.'+node.id).remove();
							}

						}
    				}
    			});
    		}, "json");
    		
    	});
</script>



