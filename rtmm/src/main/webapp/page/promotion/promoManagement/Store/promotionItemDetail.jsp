<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/js/loading/loading.css" />
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/iframeContent.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/loading/loading.js" charset="utf-8"></script>
<link href="${ctx}/shared/js/freezenColums/f.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/shared/js/freezenColums/f.js" type="text/javascript"></script>

    <style type="text/css">

        /*overwrite*/
        /*.fixed_div3 {
            margin-top: 1px;
        }*/
        .fl_left {
            margin-right:3px;
        }
        .lineToolbar {
            margin-top:2px;
        }
        .ztdb_tb {
            height:300px;
        }

        /*frozen table*/
        .frozen_div {
            height: 320px;
            overflow: hidden;
            border-bottom: 1px solid #ccc;
        }
        #frozen_cols {
            height:100%;
            width:240px;
        }
        #move_cols {
            height:100%;/* equals #frozen_cols.height */
            width:715px;
        }
        #f_cols_head, #m_cols_head {
            height: 30px;
            border-bottom: 1px solid #ccc;
        }
        #f_cols_body,#m_cols_body {
            height:290px;/* equals #frozen_cols.height - #f_cols_head.height(default readonly="readonly" value is 40px) */
        }
    </style>
<script type="text/javascript">
top.grid_layer_close();
/* 屏蔽backspace、F5,F4为刷新 */
document.onkeydown = function(e) {
	/* var ev = document.all ? window.event : e;
	ev.cancelBubble = true; */
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
var unitTypeList =new Array();
var unitNoList = new Array();
var ItemsStoreArray = new Array();
$(function(){
	$("#Tools22").parent().addClass("ToolsBg");
	$("#Tools22").attr('class','Icon-size1 Tools22_on Tools22');
	$("#Tools21").attr('class', "Icon-size1 Tools21");
	$("#Tools21").unbind("click").bind("click",pageQuery);
	UnitArray = ${initJsonArray};
	ItemsStoreArray=${promItemStoreLs};
	showItemStore(ItemsStoreArray);
	showUnitTypSelect(UnitArray);
	var promParty='${promSubjDetail.promParty}';
	var promBegin='${promSubjDetail.promBegin}';
	var promEnd='${promSubjDetail.promEnd}';
	var promNoSel='${promSubjDetail.promNo}';
	if(promParty=='L'&&promEnd==0)
	{
		$("#Tools12").removeClass("Tools12_disable");
		$("#Tools12").addClass("Icon-size1 Tools12");
	}
    else
	{
		$("#Tools12").removeClass("Icon-size1 Tools12");
		$("#Tools12").addClass("Tools12_disable");
	}
    if(promParty=='L'&&promBegin==0)
    {
	$("#Tools10").removeClass("Tools10_disable");
	$("#Tools10").addClass("Icon-size1 Tools10");
    }
    else
    {
	$("#Tools10").removeClass("Icon-size1 Tools10");
	$("#Tools10").addClass("Tools10_disable");
	$("#Tools10").unbind("click");
    }
    $("#Tools10:not('.Tools10_disable')").unbind("click").bind('click',function(){
    	
	    top.jConfirm('你确定需要删除该条促销信息吗','提示消息',function(ret){
		if(ret){
		 $.ajax({
 		        //async:false,
		    	url: ctx + '/prom/nondm/store/delPromotionItem?ti='+(new Date()).getTime(),
				type: "post",
				dataType:"json",
				data : {'promNo':promNoSel},
				success: function(result) {
	   	    			top.jAlert('warning', result.message, '提示消息',function(){
	   	    				pageQuery();
	   	    			});
	   	    			
				}
		    });
		}
	    });
	});
    $("#Tools12:not('.Tools12_disable')").unbind("click").bind("click",function(){
    	var pageNo = '${pageNoList}';
		var pageSize = '${pageSizeList}';
		var obj = "${paramArray}";
		var array = obj.split("#&");
		var subjName = encodeURI(array[1]);
		array[1] = encodeURI(subjName);
	    if(promNoSel&&promNoSel!=""){
	      top.grid_layer_open();
	      $(top.document).find("#contentIframe").attr("src",ctx + '/prom/nondm/store/edit?promNo='+promNoSel+'&paramArray='+array+'&pageNo='+pageNo+'&pageSize='+pageSize);
	   }
   });

	
});

function pageQuery(){
	var pageSizeList ="${pageSizeList}";
	var obj = "${paramArray}";
	var array = obj.split("#&");
	var pageNoList = "${pageNoList}";
	var subjName = encodeURI(array[1]);
	array[1] = encodeURI(subjName);
	window.location.href=ctx + '/prom/nondm/store/search?paramArray='+array+'&pageNoList='+pageNoList+'&pageSizeList='+pageSizeList;
}
   Array.prototype.unique = function () {
   var temp = new Array();
     this.sort();
     for(i = 0; i < this.length; i++) {
         if( this[i] == this[i+1]) {
           continue;
       }
         temp[temp.length]=this[i];
     }
     return temp;
 
   }
 
function showItemStore(ItemsStoreArray){
	$("#itemStoreBody").html("");
	$("#frozenBody").html("");
	var htmlStr="";
 	var htmlFrozenStr="";
     for (var i = 0; i < ItemsStoreArray.length; i++) {
	 	var item = ItemsStoreArray[i];
	 	htmlStr+="<tr>";
 		htmlStr+="<td><div style='width:110px;'><input type='text' readonly='readonly' value='"+item.status+"-"+item.statusName+"' readonly='readonly' class='inputText w93 ' /></div></td>";
 		htmlStr+="<td><div style='width:60px'>";
 		htmlStr+="<input type='text'  style='width:90%'  class='inputText w95 ' readonly='readonly' value='"+item.stMainSupNo+"' readonly='readonly' />";
 		htmlStr+="</div>";
 		htmlStr+="</td>";
		htmlStr+="<td><div style='width:220px;'><input type='text' style='padding-left:5px;' readonly='readonly' value='"+item.mainComName+"' class='inputText w95 ' /></div></td>";
		htmlStr+="<td><div style='width:110px;'><input type='text' readonly='readonly' value='"+item.normBuyPrice+"' class='inputText w95 ' /></div></td>";
		htmlStr+="<td><div style='width:110px;'> <input type='text' readonly='readonly' value='"+item.promBuyPrice+"' class='inputText w95 ' /></div></td>";
		htmlStr+="<td><div style='width:110px;'><input type='text' readonly='readonly' value='"+item.normSellPrice+"' class='inputText w95 ' /></div></td>";
		htmlStr+="<td><div style='width:100px;'><input type='text' readonly='readonly' value='"+item.promSellPrice+"' class='inputText w95 ' /></div></td>";
		htmlStr+="<td><div style='width:100px;'><input type='text' readonly='readonly' value='"+item.priceRange+"' class='inputText w95 ' /></div></td>";
		htmlStr+="<td><div style='width:100px;'><input type='text' readonly='readonly' value='"+item.netMaori+"' class='inputText w95 ' /></div></td>";
		htmlStr+="</tr>";
		
		htmlFrozenStr+="<tr>";
		htmlFrozenStr+="<td style='width:30px;'></td>";
		htmlFrozenStr+="<td><div style='width:60px;'><input type='text' readonly='readonly' value='"+item.itemNo+"'  class='inputText w95 ' /></div></td>";
		htmlFrozenStr+="<td><div style='width:145px;'><input type='text' readonly='readonly' value='"+item.itemName+"'  class='inputText w95 ' /></div></td>";
		htmlFrozenStr+="</tr>";
		
     }
        htmlFrozenStr+="<tr>";
		htmlFrozenStr+="<td  style='width:30px;'><div style='width:30px;'>&nbsp;</div></td>";
		htmlFrozenStr+="<td><div style='width:65px;'>&nbsp;</div></td>";
		htmlFrozenStr+="<td><div style='width:150px;'>&nbsp;</div></td>";
		htmlFrozenStr+="</tr>";
     $("#frozenBody").append(htmlFrozenStr);
     $("#itemStoreBody").append(htmlStr);
     
}
 // 关闭门店促销
 function closeCreateStoreProm() {
	 pageQuery();

 }
 function showUnitTypSelect(ItemsStoreArray){
		var unitTypeArray = new Array();
		var unitNoArray = new Array();
		for (var i = 0; i < ItemsStoreArray.length; i++) {
			unitTypeArray[unitTypeArray.length] = ItemsStoreArray[i].unitType+"@"+ItemsStoreArray[i].unitTypeName;
			unitNoArray[unitNoArray.length] = ItemsStoreArray[i].unitNo+"@"+ItemsStoreArray[i].unitNoName+"@"+ItemsStoreArray[i].unitType+"@"+ItemsStoreArray[i].promActvy+"@"+ItemsStoreArray[i].pmGiftHint+"@"+ItemsStoreArray[i].memo;
		}
		unitTypeList = unitTypeArray.unique();
		unitNoList = unitNoArray.unique();
		var selectUnitType = "<option value=''>全部</option>";
		var selectUnitNo = "<option value=''>全部</option>";
		for (var j = 0; j < unitTypeList.length; j++) {
			var unitTypeStr = unitTypeList[j];
			var unittypeStrArray = unitTypeStr.split("@");
			selectUnitType+="<option value="+unittypeStrArray[0]+">"+unittypeStrArray[0]+"-"+unittypeStrArray[1]+"</option>";
		}
		for (var w = 0; w < unitNoList.length; w++) {
			var unitNoStr = unitNoList[w];
			var unitNoStrArray = unitNoStr.split("@");
			selectUnitNo+="<option value="+unitNoStrArray[0]+" type="+unitNoStrArray[2]+">"+unitNoStrArray[0]+"-"+unitNoStrArray[1]+"</option>";
		}
		
		$("#unitType").html(selectUnitType);
		$("#unitNo").html(selectUnitNo);
		
	}
	
 function unitTypeChange(obj){
	 top.grid_layer_open();
		$("#memo").val("");
		$("#promActvy").val("");
		$("#pmGiftHint").val("");
		var unitType = $(obj).val();
		var selectUnitNo = "<option value=''>全部</option>";
		var itemArray=new Array();
		for (var w = 0; w < unitNoList.length; w++) {
			var unitNoStr = unitNoList[w];
			var unitNoStrArray = unitNoStr.split("@");
			if(unitType !=null && unitType !=""){
				if(unitNoStrArray[2] ==unitType ){
					selectUnitNo+="<option value="+unitNoStrArray[0]+" type="+unitNoStrArray[2]+">"+unitNoStrArray[0]+"-"+unitNoStrArray[1]+"</option>";
				}
			}else{
				selectUnitNo+="<option value="+unitNoStrArray[0]+" type="+unitNoStrArray[2]+">"+unitNoStrArray[0]+"-"+unitNoStrArray[1]+"</option>";
			}
			
		}
		if(unitType!=""){
		for (var m = 0; m < ItemsStoreArray.length; m++) {
			var item=ItemsStoreArray[m];
			if(item.unitType==unitType){
				itemArray.push(ItemsStoreArray[m]);
			}
		}
		showItemStore(itemArray);
		}else{
		showItemStore(ItemsStoreArray);
		}
		$("#unitNo").html(selectUnitNo);
		top.grid_layer_close();
 }

 
 function unitNoChange(obj){
	 top.grid_layer_open();
		$("#memo").val("");
		$("#promActvy").val("");
		$("#pmGiftHint").val("");
		var unitNo = $(obj).val();
		var unitType = $("#unitType").val();
		
		for (var w = 0; w < unitNoList.length; w++) {
			var unitNoStr = unitNoList[w];
			var unitNoStrArray = unitNoStr.split("@");
			if(unitNoStrArray[0] ==unitNo ){
				$("#memo").val(unitNoStrArray[5]);
				$("#promActvy").val(unitNoStrArray[3]);
				$("#pmGiftHint").val(unitNoStrArray[4]);
			}
		}
		var itemArray=new Array();
		for (var m = 0; m < ItemsStoreArray.length; m++) {
			var item=ItemsStoreArray[m];
			if(unitType!=""){
				if(unitNo!=""){
			       if(item.unitType==unitType&&item.unitNo==unitNo){
				   itemArray.push(ItemsStoreArray[m]);
			       }
				}else{
					if(item.unitType==unitType){
						itemArray.push(ItemsStoreArray[m]);
					}
				}
			}else{
				if(unitNo!=""){
				if(item.unitNo==unitNo){
					itemArray.push(ItemsStoreArray[m]);
				}}
				else{
					itemArray=ItemsStoreArray;
				}
			}
		}
		showItemStore(itemArray);
		top.grid_layer_close();
 }

</script>

<%@ include file="/page/commons/toolbar.jsp"%>
	<div class="CTitle">
		<!--第一个-->
		<div class="tags1_left"></div>
		<!--最后一个-->
		<div class="tagsM">门店促销信息</div>
		<div class="tags tags3 tags_right_on"></div>
		<!--一定不要忘了tag3-->
		<!--add-->
		<div class="tagsM_q  tagsM_on">门店促销详情</div>
		<div class="tags3_close_on" onclick="closeCreateStoreProm()">
			<div class="tags_close"></div>
		</div>
	</div>
	<div class="Container-1">
		<div class="Content">
			<div class="CInfo">
				<div class="w25 fl_left">

					<div class="cinfo_div">店号</div>
					<select class="w60 top3" disabled="disabled">
						<option>${promSubjDetail.storeNo }-${promSubjDetail.storeName }</option>
					</select>
				</div>

				<span>${promSubjDetail.chngBy }</span> <span>修改人</span> <span><fmt:formatDate
						value="${promSubjDetail.chngDate }" pattern="yyyy-MM-dd" /> </span> <span>修改日期</span>
				<span>${promSubjDetail.createBy }</span> <span>建档人</span> <span><fmt:formatDate
						value="${promSubjDetail.createDate }" pattern="yyyy-MM-dd" /></span> <span>创建日期</span>
			</div>
			<div class="CM" style="height: 170px;">
				<div class="inner_half">
					<div class="CM-bar">
						<div>促销期数基本信息</div>
					</div>
					<div class="CM-div">
						<div class="ig_top20">
							<div class="icol_text w14">
								<span>促销期数</span>
							</div>
							<input type="text" readonly="readonly"
								value="${promSubjDetail.promNo }" class="inputText w20" /> <span>&nbsp;&nbsp;&nbsp;促销提出方&nbsp;</span>
							<input type="text" readonly="readonly"
								value="${promSubjDetail.promPartyName }" class="inputText w20" />
						</div>
						<div class="ig">
							<div class="icol_text w14">
								<span>主题</span>
							</div>
							<input type="text" readonly="readonly"
								value="${ promSubjDetail.subjName}" class="inputText w50" />
						</div>
						<div class="ig">
							<div class="icol_text w14">
								<span>采购期间</span>
							</div>

							<input type="text" class="inputText w20" readonly="readonly"
								<c:if test="${promSubjDetail.beginDate!=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promSubjDetail.beginDate}" />" </c:if> />&nbsp;-&nbsp;
							<input type="text" class="inputText w20" readonly="readonly"
								<c:if test="${promSubjDetail.endDate!=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promSubjDetail.endDate}" />" </c:if> />
						</div>
						<div class="ig">
							<div class="icol_text w14">
								<span>促销期间</span>
							</div>
							<input type="text" class="inputText w20" readonly="readonly"
								<c:if test="${promSubjDetail.promBeginDate!=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promSubjDetail.promBeginDate}" />" </c:if> />&nbsp;-&nbsp;
							<input type="text" class="inputText w20" readonly="readonly"
								<c:if test="${promSubjDetail.promEndDate!=null }"> value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${promSubjDetail.promEndDate}" />" </c:if> />
						</div>

						<div class="ig">
							<div class="icol_text w14">
								<span>促销类型</span>
							</div>
							<input type="text" class="inputText w25 fl_left"
								readonly="readonly"
								value="${promSubjDetail.pricePromType }-${promSubjDetail.pricePromTypeName }" />
						</div>


					</div>
				</div>
				<div class="inner_half">
					<div class="CM-bar">
						<div>促销商品基本信息</div>
					</div>
					<div class="CM-div">
						<div class="ig_top20">
							<div class="icol_text w14">
								<span>代号类别</span>
							</div>
							<select class="w50" id="unitType" onchange="unitTypeChange(this)"></select>
						</div>
						<div class="ig">
							<div class="icol_text w14">
								<span>代号</span>
							</div>
							<select class="w50" id="unitNo" onchange="unitNoChange(this)"></select>
						</div>
						<div class="ig">
							<div class="icol_text w14">
								<span>课别</span>
							</div>
							<input type="text" class="inputText w15" readonly="readonly"
								value="${ promSubjDetail.catlgId}" />&nbsp;<input type="text"
								class="inputText w25" readonly="readonly"
								value="${promSubjDetail.catlgName }" />
						</div>


						<div class="ig">

							<div class="icol_text w14">
								<span>促销提示</span>
							</div>
							<input readonly="readonly" id="promActvy" type="text"
								class="inputText w15 fl_left" /><input type="text"
								id="pmGiftHint" readonly="readonly"
								class="inputText w39 fl_left" />
						</div>
						<div class="ig">
							<div class="icol_text w14">
								<span>备注</span>
							</div>
							<input type="text" id="memo" readonly="readonly"
								class="inputText w76" />
						</div>

					</div>
				</div>

			</div>


			<div class="CM" style="height: 360px; margin-top: 2px;">
				<div class="CM-bar">
					<div>促销商品门店信息</div>
				</div>
				<div class="CM-div">
					<div class="zt_db">
						<div class="frozen_div">
							<!--left frozen parts of a table-->
							<div id="frozen_cols">
								<!--frozen top head parts-->
								<div id="f_cols_head">
									<div class="f_head_1">
										<table cellpadding="0" cellspacing="0">
											<tr>
												<td><div style="width: 30px;">&nbsp;</div></td>
												<td><div style="width: 60px;">货号</div></td>
												<td><div style="width: 145px;">&nbsp;</div></td>
											</tr>
										</table>
									</div>
								</div>
								<!--frozen body parts-->
								<div id="f_cols_body">
									<table cellpadding="0" id="frozenBody" cellspacing="0">
										<%--        <c:forEach items="${promItemStoreLs }" var="item">
                          <tr>
                              <td style="width:30px;"></td>
                              <td><div style="width:80px;"><input type="text" readonly="readonly" value="${item.itemNo }"  class="inputText w95 " /></div></td>
                              <td><div style="width:130px;"><input type="text" readonly="readonly" value="${item.itemName }"  class="inputText w95 " /></div></td>
                         </tr>
                           </c:forEach>
                         
                          

                          <!--占位行-->
                          <tr>
                              <td  style="width:30px;"><div style="width:30px;">&nbsp;</div></td>
                              <td><div style="width:80px;">&nbsp;</div></td>
                              <td><div style="width:110px;">&nbsp;</div></td>
                         </tr> --%>
									</table>
								</div>
							</div>
							<!--right parts that can scroll-->
							<div id="move_cols">
								<!--frozen top head parts when drag the y-scroll -->
								<div id="m_cols_head">
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td><div style="width: 110px;">商品状态</div></td>
											<td><div style="width: 60px;">厂商</div></td>
											<td><div style="width: 220px;">&nbsp;</div></td>
											<td><div style="width: 110px;">正常进价(元)</div></td>
											<td><div style="width: 110px;">促销进价(元)</div></td>
											<td><div style="width: 110px;">正常售价(元)</div></td>
											<td><div style="width: 100px;">促销售价(元)</div></td>
											<td><div style="width: 100px;">降价幅度(%)</div></td>
											<td><div style="width: 100px;">净毛利(%)</div></td>

											<td><div style="width: 90px;">&nbsp;</div></td>
											<!--占位-->
										</tr>
									</table>
								</div>
								<!--this parts can be scrolled all the time-->
								<div id="m_cols_body">
									<table cellpadding="0" id="itemStoreBody" cellspacing="0">
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>