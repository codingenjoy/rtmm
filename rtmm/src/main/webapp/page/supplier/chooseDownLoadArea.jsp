<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/tree.css" rel="Stylesheet" />
<style type="text/css">
  .Table_Panel {
      /* height:550px; */
      overflow:hidden;
  }
  .CM_p {
      height:280px;
      width:595px;
      margin:20px auto 0px auto;
  }
  .t2, .t3 {
      height:240px;
      overflow-x:hidden;
      overflow-y:auto;
      float:left;
      background:#fff;
      margin-top:20px;
      border:1px solid #808080;
  }
  .t2 {
      width:328px;
      margin-left:20px;
  }
  .t3 {
      width:200px;
      margin-left:5px;
  }
  .CM2 {
      background:#f9f9f9;
      width:296px;
      height:240px;
  }
  .b{
      height:209px;overflow:auto;
  }
  .d {
      width:235px;
      height:200px;
      background:#fff;
      margin:20px auto auto 40px;
      border:1px solid #808080;
  }
  .e, .f,.b {
      width:215px;margin:0 auto;line-height:26px;
  }
  .e{
      overflow:auto;
      height:169px;
  }
      .e div,.b div {
          border-top:1px solid #fff;
          height:28px;
          cursor:pointer;
      }
  .f {
      border-top:1px solid #808080;
      height:30px;
  }
  .tree-icon {
      display:none;
  }
</style>

<div class="Panel" style="width: 635px;">
	<div class="Panel_top">
		<span>选择下传区域</span>
		<div class="PanelClose" onclick="closePopupWin()"></div>
	</div>
	<div class="Table_Panel">
		<c:if test="${dlvryMethd!=2}">
			<div class="CM_p">
				<div class="CM-bar" style="height: 280px;">
					<div>大卖场</div>
				</div>
				<div class="t2">
					<ul id="tt"></ul>
				</div>
				<div class="t3" id="storeDiv">
					<div class="b inputDiv" style="width: 180px;" >
						<!-- <div class="item2">
							<label><input type="checkbox" name="n" />
							</label>
							<span>998-上海加工中心</span>
						</div> -->
					</div>
					<div class="f" style="width: 180px;">
						<label> <input type="checkbox" name="n" class="checkAll" 
						<c:if test="${dlvryMethd == '2'}">disabled="disabled"</c:if> onclick="storeCheckAll(this)" />
						</label>
						<span>全选</span>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${dlvryMethd!=1 || (dlvryMethd!=2 && parntCatlgId==5)}">
		<div style="width: 595px; height: 240px; margin: 3px auto;">
			
			<c:if test="${dlvryMethd!=1}">
				<!-- 供货方式不是直配时显示 -->
				<div class="CM2 fl_left" style="margin-left: 3px;">
					<div class="CM-bar" style="height: 240px;">
						<div>物流中心</div>
					</div>
					<div class="d" id="machinDiv">
						<div class="e inputDiv" >
							<c:forEach items="${dcCenterList}" var="store">
							<div class="item4" onclick='selectAny(this)'>
								<label><input type="checkbox" name="storeNo" onchange="selectMachinStoreNo()" value="${store.storeNo}"/>
								</label>
								<span>${store.storeNo}-${store.storeName}</span>
							</div>
							</c:forEach>
						</div>
						<div class="f">
							<label><input type="checkbox" name="d" class="checkAll" onclick="machinCheckAll(this)"/>
							</label>
							<span>全选</span>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${dlvryMethd!=2 && parntCatlgId==5}">
				<!-- 供货方式不是DC时候显示 -->
				<div class="CM2 fl_left">
					<div class="CM-bar" style="height: 240px;">
						<div>加工中心</div>
					</div>
					<div class="d" id="dcCenterDiv">
						<div class="e inputDiv">
							<c:forEach items="${machiningList}" var="store">
							<div class="item3" onclick='selectAny(this)'>
								<label><input type="checkbox" name="storeNo" value="${store.storeNo}" onchange="selectDcStoreNo()" <c:if test="${dlvryMethd == '2'}">disabled="disabled"</c:if> />
								</label>
								<span>${store.storeNo}-${store.storeName}</span>
							</div>
							</c:forEach>
						</div>
						<div class="f">
							<label> <input type="checkbox" name="a" class="checkAll" <c:if test="${dlvryMethd == '2'}">disabled="disabled"</c:if>  onclick="dcCenterCheckAll(this) " />
							</label>
							<span>全选</span>
						</div>
					</div>
				</div>
			</c:if>
		</div>
	</c:if>
	</div>
	<div class="Panel_footer">
		<div class="PanelBtn">
			<div class="PanelBtn1" onclick="confirmChoose()">确定</div>
			<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	
	function selectAny(obj){
		if ($(obj).find("input").attr("disabled") != "disabled"){
		 	   $(obj).toggleClass("item_on");
		 	   if ($(obj).hasClass("item_on")){
		           $(obj).find("input:checkbox").attr("checked", "checked");    		   
		
		 	   }else{
		 		   $(obj).find("input:checkbox").removeAttr("checked");
		 	   }
		    }
			$(obj).find("input[type=checkbox]").trigger("change");
	}
	
	function confirmChoose(){
		var list = [];
		$.each($('input[name="storeNo"][type=checkbox]:checked'),function(index,item){
			list.push({'storeNo':$(this).val(),'storeName':$(this).parent().next().text()});
		});
		if(list.length==0){
			top.jAlert('warning', '请选择门店','提示消息');
			return false;
		}
		confirmSelectArea(list);
	}

	//大卖场选中事件
	function selectStoreNo(){
		var allSize = $('#storeDiv').find('input[name=storeNo]').not('.checkAll').size();
		var checkSize = $('#storeDiv').find('input[name=storeNo]:checked').not('.checkAll').size();
		if(allSize==checkSize){
			$('#storeDiv').find('.checkAll').attr("checked",true);
		}else{
			$('#storeDiv').find('.checkAll').attr("checked",false);
		}
	}
	
	//大卖场全选事件
	function storeCheckAll(obj){
		if(obj.checked){
			$.each($('#storeDiv').find("input").not('[disabled="disabled"]').not('.checkAll'),function(index,obj){
				$(this).attr('checked',true);
				$(this).parent().parent().addClass('item_on');
			});
		}else{
			$.each($('#storeDiv').find("input").not('[disabled="disabled"]').not('.checkAll'),function(index,obj){
				$(this).attr('checked',false);
				$(this).parent().parent().removeClass('item_on');
			});
		}
	}

	//加工中心选中事件
	function selectDcStoreNo(){
		
		var allSize = $('#dcCenterDiv').find('input[name=storeNo]').not('.checkAll').size();
		var checkSize = $('#dcCenterDiv').find('input[name=storeNo]:checked').not('.checkAll').size();
		if(allSize==checkSize){
			$('#dcCenterDiv').find('.checkAll').attr("checked",true);
		}else{
			$('#dcCenterDiv').find('.checkAll').attr("checked",false);
		}
	}

	//加工中心全选事件
	function dcCenterCheckAll(obj){
		if(obj.checked){
			$.each($('#dcCenterDiv').find("input").not('[disabled="disabled"]').not('.checkAll'),function(index,obj){
				$(this).attr('checked',true);
				$(this).parent().parent().addClass('item_on');
			});
		}else{
			$.each($('#dcCenterDiv').find("input").not('[disabled="disabled"]').not('.checkAll'),function(index,obj){
				$(this).attr('checked',false);
				$(this).parent().parent().removeClass('item_on');
			});
		}
	}

	//物流中心选中事件
	function selectMachinStoreNo(){
		
		var allSize = $('#machinDiv').find('input[name=storeNo]').not('.checkAll').size();
		var checkSize = $('#machinDiv').find('input[name=storeNo]:checked').not('.checkAll').size();
		if(allSize==checkSize){
			$('#machinDiv').find('.checkAll').attr("checked",true);
		}else{
			$('#machinDiv').find('.checkAll').attr("checked",false);
		}
	}
	//物流中心全选事件
	function machinCheckAll(obj){
		if(obj.checked){
			$.each($('#machinDiv').find("input").not('[disabled="disabled"]').not('.checkAll'),function(index,obj){
				$(this).attr('checked',true);
				$(this).parent().parent().addClass('item_on');
			});
		}else{
			$.each($('#machinDiv').find("input").not('[disabled="disabled"]').not('.checkAll'),function(index,obj){
				$(this).attr('checked',false);
				$(this).parent().parent().removeClass('item_on');
			});
		}
	}
	
	//将之前选中的门店disabled
	function disabledCheckBox(){
		var list = viewModel.tmpVal().split(',');
		if(viewModel.action()=='create'){
			$.each(list,function(index,item){
				$('input[name="storeNo"][value='+item+']').attr('disabled',true);
			});
		}else if(viewModel.action()=='update'){
			$('input[name="storeNo"]').attr('disabled',true);
			$.each(list,function(index,item){
				$('input[name="storeNo"][value='+item+']').attr('disabled',false);
			});
		}
	}
	
	$(function(){
		
		if('${dlvryMethd}' == '2'){
			$('#popupWin').height('329px');
		}else if('${dlvryMethd}' == '1' && '${parntCatlgId}' != '5'){
			$('#popupWin').height('383px');
		}
		
		disabledCheckBox();
		
		if ('${dlvryMethd}' != '2') {
			//供货方式为DC的时候下传区域不包括大卖场
			$('#tt').find('li').remove();// 先删除树
			$.post(ctx + "/supplier/getAreaTree", {
			}, function(data) {
				$('#tt').tree({
					checkbox : true,
					data : data,
					onClick : function(node) {
						
					},onCheck : function(node,checked) {
						
						$.ajax({
							type : "post",
							async : false,
							url : ctx + "/supplier/getStoreByAreaId",
							dataType : "json",
							data : {
								'areaId' :node.id,
								'dlvryMethd' : '${dlvryMethd }'
							},
							success : function(data) {
								$.each(data,function(index,item){
									if(checked){
										$("#storeDiv>div").first().append("<div class='item2' id='store_"+item.storeNo+"' onclick='selectAny(this)'><label><input type='checkbox' name='storeNo' value="+item.storeNo+" onchange='selectStoreNo()'></label><span>"+item.storeNo+"-"+item.storeName+"</span></div>");
									}else{
										$("#storeDiv>div").first().find("div[id=store_"+item.storeNo+"]").remove();
									}
								});
								disabledCheckBox();
								selectStoreNo();
							}
						});
					}
					
				});
			}, "json");
		};
		
		// 不使用 rtmm.js 的 click bind. 
		$(".item2,.item3,.item4").die("click");
		
	});
</script>