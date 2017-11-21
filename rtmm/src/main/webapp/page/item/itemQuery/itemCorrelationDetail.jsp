<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<%@ include file="/page/commons/toolbar.jsp"%>



<script type="text/javascript">
	//设置所有的input标签为只读
	$(":input").attr("readonly", true);
   //设置所有的input标签的title
    $(":input").each(function(index,item){
         $(this).attr("title",$(this).val());

        });
    
	$(function() {
		$("#childItemInfosDiv").hide();		
		readItemCorrlationInfos();
		$("#Tools21").removeClass('Tools21_disable').addClass('Tools21').unbind('click').bind('click',function(){			
			$("#Tools22").removeClass('Tools22').addClass('Tools22_disable').unbind('click');
			readItemCorrelationList();		
		});	
	});
	//商品关联列表
 	function readItemCorrelationList() {
		$.ajax({
			url : ctx + "/itemQueryManagement/itemCorrelationSearch",
			type : "post",
			dataType : "html",
			success : function(data) {
				$("#content").html(data);
			}
		});
	} 
	//加载查询信息		
	function itemSupList() {
		$("#readAllChildItems").datagrid(
		{
			rownumbers : false,
			singleSelect : true,
			pagination : true,
			pageSize : 10,
			width : 1031,
			height : 385,
			striped : true,//奇偶行使用不同背景色  
			url : "<c:url value='/itemQueryManagement/readItemChildByItemNo'/>",
			queryParams : {
				itemNo : "${itemBasicVO.itemNo}"
			},
			columns : [ [
					{
						field : 'itemNo',
						title : '子货号',
						width : 100,
						halign : 'center',
						align : 'center',
						resizable : false
					},
					{
						field : 'itemName',
						title : '商品名称',
						width : 310,
						halign : 'center',
						resizable : false,
						formatter : function(val, rec) {
							return "<span title='"+rec.itemName+"'>"
									+ rec.itemName + "</span>";
						}
					},
					{
						field : 'cntdQty',
						title : '包含数量',
						width : 100,
						halign : 'center',
						align : 'center',
						resizable : false
					},									
					{
						field : 'status',
						title : '商品状态',
						width : 100,
						halign : 'center',
						resizable : false,
						formatter : function(val, rec) {
							return getDictValue(
									'ITEM_BASIC_STATUS',
									rec.status);
							
						}
					},
					{
						field : 'sellUnit',
						title : '销售单位',
						width : 130,
						resizable : false,
						halign : 'center',
						formatter : function(val, rec) {
							return getDictValue(
									'UNIT',
									rec.sellUnit);									
						}										
					}, {
						field : 'stdSellPrice',
						title : '售价',
						halign : 'center',
						align:"right",
						resizable : false,
						width : 100
					}, 
					 {
						field : 'stdBuyPrice',
						title : '进价',
						halign : 'center',
						align:"right",
						resizable : false,										
						width : 100																		
						},	
					 {
							field : 'valPct',
							title : '价格比例(%)',
							halign : 'center',
							align:"right",
							resizable : false,										
							width : 100,
							formatter : function(val, rec) {
								return rec.valPct+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";									
							}	
							
					}, {
						field : 'temp',
						title : ' ',
						width : 18,
						halign : 'center'
					} ] ],
			onLoadSuccess : function(data) {

			},
			onClickRow : function(rowIndex, rowData) {

			},
			onDblClickRow : function(rowIndex, rowData) {
			
			},
			error : function(XMLHttpRequest, textStatus,
					errorThrown) {
				//这里是ajax错误信息  
			}
			});
	}



	//异步获取详细信息，如果为1，显示单个，多个则列表显示
   function readItemCorrlationInfos(){
		$.ajax({
			type : 'post',
			url : ctx + '/itemQueryManagement/readItemChildByItemNo?tt='
					+ new Date().getTime(),
			data : {
				itemNo : "${itemBasicVO.itemNo}",
				page:1,
				rows:100
			},
			success : function(data) {
                    if(data.rows.length<= 1){
                    	$("#childItemInfosDiv").show();
                    	$("#childItemNo").val(data.rows[0].itemNo);
                    	$("#childItemName").val(data.rows[0].itemName);
                    	$("#childItemName").attr("title",data.rows[0].itemName);
                    	$("#childEnItemName").val(data.rows[0].itemEnName);
                    	$("#childSellUnit").val(getDictValue("UNIT",data.rows[0].sellUnit).split("-")[1]);
                    	$("#childNumOfPackUnit").val(data.rows[0].numOfPackUnit);
                    	if(data.rows[0].packUnit!=null){
                    	$("#childPackUnit").val(getDictValue("UNIT",data.rows[0].packUnit).split("-")[1]);
                        	}
                    	$("#childBaseVol").val(data.rows[0].baseVol);
                    	$("#childBaseVolUnit").val(data.rows[0].baseVolUnit);
                    	$("#childCntdQty").val(data.rows[0].cntdQty);
                    	$("#childStatus").val(getDictValue("ITEM_STORE_INFO_STATUS",data.rows[0].status));
                    	$("#childComNo").val(data.rows[0].majorSupNo);
                    	$("#childComName").val(data.rows[0].majorSupName);
                    	$("#childStdBuyPrice").val(data.rows[0].stdBuyPrice);
                    	$("#childBuyVatNo").val(data.rows[0].buyVatNo);
                    	$("#childBuyVatVal").val(data.rows[0].buyVatVal);
                    	$("#childStdSellPrice").val(data.rows[0].stdSellPrice);
                    	$("#childSellVatNo").val(data.rows[0].sellVatNo);
                    	$("#childSellVatVal").val(data.rows[0].sellVatVal);
                        }else{
                           //列表展示，多个结果时候
                        	itemSupList();
                            }
				

			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				//这里是ajax错误信息
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});


	   }
	

	
</script>



<div class="CTitle">
	<!--第一个-->

	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">商品关联信息</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Content">
		<div style="height: 150px;" class="CM">
			<div class="CM-bar">
				<div>母货号</div>
			</div>
			<div class="CM-div">
				<div class="inner_half">
					<div class="ig" style="margin-top: 15px;">
						<div class="msg_txt">母货号</div>
						<div class="iconPut fl_left w20">
							<input type="text" class="w75" value="${itemBasicVO.itemNo}" />
							<div class="ListWin"></div>
						</div>
						<input class="inputText w50" type="text"
							value="${itemBasicVO.itemName }" />
					</div>
					<div class="ig">
						<div class="msg_txt">英文名称</div>
						<input type="text" class="inputText w70"
							value="${itemBasicVO.itemEnName }" />
					</div>
				<div class="ig">
						<div class="msg_txt">销售单位</div>
						<span class="jksp">1&nbsp;</span> 
						<input class="inputText iq" type="text" style="width: 10%;" 
							<c:if test="${itemBasicVO.sellUnit != null}">
	                           	value="<auchan:getDictValue code="${itemBasicVO.sellUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>"
	                        </c:if>							
						/>
						<span class="jksp">&nbsp;=&nbsp;</span> 
						<input class="inputText iq w10" type="text" value="${itemBasicVO.numOfPackUnit }" readonly="readonly" /> 
						<input class="inputText iq w10" type="text"
						<c:if test="${itemBasicVO.packUnit != null}">				
						 value="<auchan:getDictValue code='${itemBasicVO.packUnit}' mdgroup='UNIT'  showType='2'/>" </c:if>  readonly="readonly" /> 
						
						<span class="fl_left">&nbsp;x&nbsp;</span> 
						<input class="inputText iq w10" type="text" value="${itemBasicVO.baseVol }" readonly="readonly" /> 
						<input class="inputText iq w10" type="text" value="${itemBasicVO.baseVolUnit }" readonly="readonly" />
					</div>
					<div class="ig">
						<div class="msg_txt">母货类型</div>
						<auchan:select mdgroup="ITEM_RELATIVE_RLTN_TYPE" _class="w23"
							value="${itemBasicVO.rltnType}" disabled="disabled" />

					</div>
				</div>
				<div class="inner_half">
					<div class="ig" style="margin-top: 15px;">
						<div class="msg_txt">商品状态</div>
						<input type="text" class="inputText w20"
							value="${itemBasicVO.status}-<auchan:getDictValue code='${itemBasicVO.status}' mdgroup='ITEM_STORE_INFO_STATUS' showType='2' />" />
					</div>
					<div class="ig">
						<div class="msg_txt">厂商</div>
						<div class="iconPut fl_left w20">
							<input type="text" class="w75" value="${itemBasicVO.comNo }" />
							<div class="ListWin"></div>
						</div>
						<input class="inputText iq" style="width: 55%;" type="text"
							value="${itemBasicVO.comName }" />
					</div>
					<div class="ig">
						<div class="msg_txt">进价</div>
						<input class="w20 inputText " type="text"
							value="${itemBasicVO.stdBuyPrice}" /> <span>元&nbsp;&nbsp;&nbsp;进价税率&nbsp;</span>
						<input class="w10 inputText " type="text"
							value="${itemBasicVO.buyVatNo}" /> <span>-</span> <input
							class="w10 inputText " type="text"
							value="${itemBasicVO.buyVatVal}" /> <span>&nbsp;%</span>
					</div>
					<div class="ig">
						<div class="msg_txt">售价</div>
						<input class="w20 inputText " type="text"
							value="${itemBasicVO.stdSellPrice}" /> <span>元&nbsp;&nbsp;&nbsp;售价税率&nbsp;</span>
						<input class="w10 inputText " type="text"
							value="${itemBasicVO.sellVatNo}" /> <span>-</span> <input
							class="w10 inputText " type="text"
							value="${itemBasicVO.sellVatVal}" /> <span>&nbsp;%</span>
					</div>
				</div>

			</div>
		</div>

     <div style="height: 150px; margin-top: 2px;" class="CM"  id="childItemInfosDiv">
			<div class="CM-bar">
				<div>子货号</div>
			</div>
			<div class="CM-div">
				<div class="inner_half">
					<div class="ig" style="margin-top: 15px;">
						<div class="msg_txt">子货号</div>
						<div class="iconPut fl_left w20">
							<input type="text" class="w75" id="childItemNo"/>
							<div class="ListWin"></div>
						</div>
						<input class="inputText w50" type="text" id="childItemName"/>
					</div>
					<div class="ig">
						<div class="msg_txt">英文名称</div>
						<input type="text" class="inputText w70" id="childEnItemName"/>
					</div>
					<div class="ig">
						<div class="msg_txt">销售单位</div>
						<span class="jksp">1&nbsp;</span> <input class="inputText iq"
							type="text" style="width: 10%;" id="childSellUnit"  />
						<span class="jksp">&nbsp;=&nbsp;</span> <input
							class="inputText iq w10" type="text" id="childNumOfPackUnit" 
							 /> <input class="inputText iq w10" id="childPackUnit"
							type="text" /> <span
							class="fl_left">&nbsp;x&nbsp;</span> <input id="childBaseVol"
							class="inputText iq w10" type="text"/> <input class="inputText iq w10"
							type="text" id="childBaseVolUnit"  />
					</div>
					<div class="ig">
						<div class="msg_txt">包含数量</div>
						<input class="inputText iq" type="text"  id="childCntdQty"/>
					</div>
				</div>
				<div class="inner_half">
					<div class="ig" style="margin-top: 15px;">
						<div class="msg_txt">商品状态</div>
						<input type="text" class="inputText w20" id="childStatus" />
					</div>
					<div class="ig">
						<div class="msg_txt">厂商</div>
						<div class="iconPut fl_left w20">
							<input type="text" class="w75" id="childComNo"/>
							<div class="ListWin"></div>
						</div>
						<input class="inputText iq" type="text" style="width: 55%;" id="childComName"/>
					</div>
					<div class="ig">
						<div class="msg_txt">进价</div>
						<input class="w20 inputText" type="text" id="childStdBuyPrice" /> <span>元&nbsp;&nbsp;&nbsp;进价税率&nbsp;</span>
						<input class="w10 inputText" type="text" id="childBuyVatNo"/> <span>-</span> <input
							class="w10 inputText" type="text" id="childBuyVatVal"/><span>&nbsp;%</span>
					</div>
					<div class="ig">
						<div class="msg_txt">售价</div>
						<input class="w20 inputText" type="text" id="childStdSellPrice"/> <span>元&nbsp;&nbsp;&nbsp;售价税率&nbsp;</span>
						<input class="w10 inputText" type="text" id="childSellVatNo"/> <span>-</span> <input
							class="w10 inputText" type="text" id="childSellVatVal"/><span>&nbsp;%</span>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 这里放入子货号信息，分页查询 -->
		<div style="height: 600px; width: 1031px; margin-top: 2px" >
               <table id="readAllChildItems"></table>
		</div>
	</div>
</div>
