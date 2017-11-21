<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/js/loading/loading.css" />
<script type="text/javascript"
	src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="${ctx}/shared/js/iframeContent.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="${ctx}/shared/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/common.js" charset="utf-8"></script>	
<script type="text/javascript" src="${ctx}/shared/js/loading/loading.js" charset="utf-8"></script>
 
 <style type="text/css">
        
        /*overwrite*/

        .fl_left {
            margin-right:3px;
        }
        .lineToolbar {
            margin-top:2px;
        }
        .ztdb_tb {
            height:300px;
        }
        .CM-div .inner_half {
            border-left:1px dashed #ccc;height:85px;
        }
        
        /*frozen table*/
        .frozen_div {
            height:280px;
            overflow: hidden;
            border-bottom: 1px solid #ccc;
        }
        #frozen_cols {
            height:100%;
            width:140px;
        }
        #move_cols {
            height:100%;
            width:820px;
        }
        #f_cols_head, #m_cols_head {
            height:35px;border-bottom:1px solid #ccc;
        }
        #f_cols_body,#m_cols_body {
            height:246px;/* equals #frozen_cols.height - #f_cols_head.height(default value is 40px) */
        }
    .errorInput {
	border-color: #f00 !important;
	background-color: #FFC1C1 !important;
     }
    </style>
<script type="text/javascript">
$(function (){
	$("#Tools6").removeClass("Tools6_disable");
	$("#Tools6").addClass("Icon-size1 Tools6");
	$("#itemNo").unbind("focus").bind("focus", function() {
		$("#itemNo").removeClass("errorInput");
		$("#itemNo").removeAttr("title");

	});
	$("#beginDate").unbind("focus").bind("focus", function() {
		$("#beginDate").removeClass("errorInput");
		$("#beginDate").removeAttr("title");

	});
	$("#endDate").unbind("focus").bind("focus", function() {
		$("#endDate").removeClass("errorInput");
		$("#endDate").removeAttr("title");

	});
    getPromotionItemChart();
    $("#Tools6").unbind("click").bind('click',function(){
    	var error=0;
    	var itemNo=$("#itemNo").val();
    	$("#regnStr").val('');
    	if($.trim(itemNo)=="")
    	{
    		 $("#itemNo").removeClass("errorInput").addClass('errorInput');
    		 $("#itemNo").attr("title",'请输入货号!');
    		 error++;
    	}
    	else if(!isNumber(itemNo)){
    		 $("#itemNo").removeClass("errorInput").addClass('errorInput');
    		 $("#itemNo").attr("title",'请注意输入货号!');
    		 error++;
    	}
    	
    	var beginDate=$("#beginDate").val();
    	if(beginDate=="")
    	{
    		 $("#beginDate").removeClass("errorInput").addClass('errorInput');
    		 $("#beginDate").attr("title",'请输入开始日期!');
    		 error++;
    	}
    	var endDate=$("#endDate").val();
    	if(endDate=="")
    	{
    		 $("#endDate").removeClass("errorInput").addClass('errorInput');
    		 $("#endDate").attr("title",'请输入结束日期!');
    		 error++;
    	}
    	
    	if(error>0)
    		{
    		return;
    		}
    	var storeRange=$("input[name='storeRange']:checked").val();
    	if(storeRange==undefined)
    	{
    	 top.jAlert('waring', '请选择门店范围!', '提示消息');
    	 return;
    	}
    	else if(storeRange==0)
    	{
    		var storeNo=$("#storeNo").val();
    		if(storeNo=='')
    			{
    			 top.jAlert('waring', '请选择门店!', '提示消息');
    			 return;
    			}
    	}
    	else if(storeRange==1)
    	{
    		var regnArr=[];
    		$("input[name='regnNo']:checked").each(function(){
    			regnArr.push($(this).val());
    		});
    		$("#regnStr").val(regnArr.join(","));
    		if(regnArr.length==0){
    			top.jAlert('waring', '请选择区域!', '提示消息');
    			return;
    		}
    		
    	}
        getPromotionItemChart();

    });
    
    $(".showItemWin").unbind("click").bind('click',function(){
    	   top.openPopupWin(700,450,'/promotion/promotionItemStatistics/showUnitWin');
    	});
    
    $("#itemNo").unbind("blur").bind("blur",function(){
    	var itemNo=$(this).val();
    	if($.trim(itemNo)=="")
    	{
    		return;
    	}
    	else if(!isNumber(itemNo)){
    		top.jAlert('waring', '请输入数字!', '提示消息');
    		return;
    	}
    	
    $.ajax({
    	//async : false,
    	url : ctx + '/promotion/promotionItemStatistics/getItemInfo?ti='+(new Date()).getTime(),
    	data : {'itemNo':itemNo},
    	type : 'POST',
    	success : function(response) {
    		var itemInfo=response["itemInfo"];
    		if(itemInfo!=null)
    		{
    			$("#itemName").val(itemInfo.itemName);
    			$("#sellUnit").val(itemInfo.sellUnitName);
    			$("#statusName").val(itemInfo.statusName);
    			$("#chuBieName").val(itemInfo.chuBieName);
    			$("#courseName").val(itemInfo.courseName);
    			$("#seriesName").val(itemInfo.seriesName);
    			
    			$("#bigCategoryName").val(itemInfo.bigCategoryName);
    			$("#middleCategoryName").val(itemInfo.middleCategoryName);
    			$("#smallCategoryName").val(itemInfo.smallCategoryName);
    		}
    		else{
    			$("#itemName").val('');
    			$("#sellUnit").val('');
    			$("#statusName").val('');
    			$("#chuBieName").val('');
    			$("#courseName").val('');
    			$("#seriesName").val('');
    			
    			$("#bigCategoryName").val('');
    			$("#middleCategoryName").val('');
    			$("#smallCategoryName").val('');
    			top.jAlert('waring', '没有找到该商品记录!', '提示消息');
    			return;
    		}
    			
    	},
    	error : function(XMLHttpRequest, textStatus, errorThrown) {
    		top.jAlert('error', '网络超时!请稍后重试', '提示消息');
    	}
    });
    })
});

function getPromotionItemChart(){
	var promotionItemForm = $("#promotionItemForm").serialize();
	$.ajax({
		url: ctx + '/promotion/promotionItemStatistics/getPromotionItemSheduleChart',
        type: "post",
        dataType:"html",
        data:promotionItemForm,
        success: function(data) {
 			$("#Container").html(data);
        }
	});
}
function enterIn(evt){
	  var evt=evt?evt:(window.event?window.event:null);//兼容IE和FF
	  if (evt.keyCode==13){
	  $("#itemNo").blur();
	}
}



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
	
	

function addItemNoReturn(unitNo,unitName){
	
	if ($.trim(unitNo)==""){
		top.closePopupWin();
		return;
	 }
		$("#itemName").val(unitName);
		$("#itemNo").val(unitNo);
		
	  $.ajax({
		//async : false,
		url : ctx + '/promotion/promotionItemStatistics/getItemInfo?ti='+(new Date()).getTime(),
		data : {'itemNo':unitNo},
		type : 'POST',
		success : function(response) {
			var itemInfo=response["itemInfo"];
			if(itemInfo!=null)
			{
				$("#itemName").val(itemInfo.itemName);
				$("#sellUnit").val(itemInfo.sellUnitName);
				$("#statusName").val(itemInfo.statusName);
				$("#chuBieName").val(itemInfo.chuBieName);
				$("#courseName").val(itemInfo.courseName);
				$("#seriesName").val(itemInfo.seriesName);
				
				$("#bigCategoryName").val(itemInfo.bigCategoryName);
				$("#middleCategoryName").val(itemInfo.middleCategoryName);
				$("#smallCategoryName").val(itemInfo.smallCategoryName);
			}
			else{
				$("#itemName").val('');
				$("#sellUnit").val('');
				$("#statusName").val('');
				$("#chuBieName").val('');
				$("#courseName").val('');
				$("#seriesName").val('');
				
				$("#bigCategoryName").val('');
				$("#middleCategoryName").val('');
				$("#smallCategoryName").val('');
				top.closePopupWin();
				top.jAlert('waring', '没有找到该商品记录!', '提示消息');
				return;
			}
				
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			top.closePopupWin();
			top.jAlert('error', '网络超时!请稍后重试', '提示消息');
		}
	});
	 top.closePopupWin();
    }

</script>
<%@ include file="/page/commons/toolbar.jsp"%>
   <div>
   <div class="CTitle">
                            <!--第一个-->
                            <div class="tags1_left tags1_left_on"></div>
                            <div class="tagsM tagsM_on">商品促销期数查询</div>
                            <div class="tags tags3_r_on"></div>
            </div>
            <div class="Container-1">
                <div class="Content">
                    
                     <form id="promotionItemForm" name="promotionItemForm">
                     <input type="hidden" id="regnStr" name="regnStr" readonly="readonly"  />
                  
		                    <div class="CM" style="height:170px;">
		                        
		                            <div class="inner_half">
		                            <div class="CM-bar"><div>查询条件</div></div>
		                                <div class="CM-div">
		                                    <div class="ig_top20">
		                                        <div class="icol_text w14"><span>*货号</span></div>
		                                        <div class="iconPut w20 fl_left">
		                                            <input class="w75" id="itemNo" onkeydown="enterIn(event);" maxlength="8" name="itemNo" type="text" />
		                                            <div class="ListWin showItemWin" ></div>
		                                        </div>
		                                        <input type="text" id="itemName" name="itemName" readonly="readonly" class="inputText w45 Black" />
		                                    </div>
		                                    <div class="ig">
		                                        <div class="icol_text w14"><span>销售单位</span></div>
		                                        <input type="text" id="sellUnit" name="sellUnit" readonly="readonly" class="inputText w20 Black fl_left" />
		                                        <div class="icol_text w14 fl_left"><span>主状态</span></div>
		                                        <input type="text" id="statusName" name="statusName" readonly="readonly" class="inputText w20 Black" />
		                                    </div>
		                                    <div>
		                                        <div class="w45 fl_left">
		                                            <div class="ig">
		                                                <div class="icol_text w31"><span>处别</span></div>
		                                                <input type="text" id="chuBieName" name="chuBieName" readonly="readonly" class="inputText w65 Black fl_left" />
		                                            </div>
		                                            <div class="ig">
		                                                <div class="icol_text w31"><span>课别</span></div>
		                                                <input type="text" id="courseName" name="courseName" readonly="readonly" class="inputText w65 Black fl_left" />
		                                            </div>
		                                            <div class="ig">
		                                                <div class="icol_text w31"><span>系列</span></div>
		                                                <input type="text" id="seriesName" name="seriesName" readonly="readonly" class="inputText w65 Black fl_left" />
		                                            </div>
		                                        </div>
		                                        <div class="inner_half">
		                                            <div class="ig">
		                                                <div class="icol_text w20"><span>大分类</span></div>
		                                                <input type="text" id="bigCategoryName" name="bigCategoryName" readonly="readonly" class="inputText w48 Black fl_left" />
		                                            </div>
		                                            <div class="ig">
		                                                <div class="icol_text w20"><span>中分类</span></div>
		                                                <input type="text" id="middleCategoryName" name="middleCategoryName" readonly="readonly" class="inputText w48 Black fl_left" />
		                                            </div>
		                                            <div class="ig">
		                                                <div class="icol_text w20"><span>小分类</span></div>
		                                                <input type="text" id="smallCategoryName" name="smallCategoryName" readonly="readonly" class="inputText w48 Black fl_left" />
		                                            </div>
		                                        </div>
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="inner_half">
		                                <div class="CM-div">
		                                    <div class="ig_top20">
		                                        <div class="icol_text w14"><span>*查询时段</span></div>
		                                        <input id="beginDate" name="beginDate" type="text" class="Wdate w20" onclick="WdatePicker({ isShowClear: false, readOnly: true })"/>&nbsp;-&nbsp;<input type="text"  id="endDate" name="endDate" class="Wdate w20" onclick="    WdatePicker({ isShowClear: false, readOnly: true })"/>
		                                    </div>
		                                    <div style="height:85px;">
		                                        <div class="w14 icol_text fl_left"><span>*门店范围</span></div>
		                                        <div class="w10 fl_left brit">
		                                            <div><input type="radio" name="storeRange" value="0"/>&nbsp;单店</div>
		                                            <div class="ig_padding"><input type="radio" name="storeRange" value="1" />&nbsp;区域</div>
		                                            <div class="ig_padding"><input type="radio" name="storeRange" value="2"/>&nbsp;全国</div>
		                                        </div>
		                                        <div class="w70 fl_left">
		                                            <div class="ig">
		                                                <div class="icol_text w10"><span>店号</span></div>
		                                                <select name="storeNo" id="storeNo" class="w30"><option value="">请选择</option>
		                 <c:forEach items="${storeLs}" var="store" >
		                 <option value="${store.storeNo }" >${store.storeNo }-${store.storeName }</option>
		                 </c:forEach>
		                 </select>
		                                            </div>
		
		                                            <div>
		                                                <div class="icol_text w10 fl_left"><span>区域</span></div>
		                                                <div class="w70 fl_left">
		                                                <c:forEach items="${areaList }" var="area" varStatus="step">
		                                                    <c:if test="${step.index eq 0 }"><div>
		                                                     
		                                                <c:forEach items="${areaList }" var="area1" varStatus="step1">
		                                                    <c:if test="${step1.index <=3 }">
		                                                    <input type="checkbox" name="regnNo"  value="${area1.assrtId }" />&nbsp;${area1.regnName }&nbsp;&nbsp;&nbsp;
		                                                    </c:if>
		                                                 </c:forEach>
		                                                 </div>
		                                                 </c:if>
		                                                 <c:if test="${step.index eq 4 }">
		                                                    <div class="ig_padding">
		                                                 
		                                                   <c:forEach items="${areaList }" var="area2" varStatus="step2">
		                                                        <c:if test="${step2.index >3 }">
		                                                        <input type="checkbox" name="regnNo" value="${area2.assrtId }" />&nbsp;${area2.regnName }&nbsp;&nbsp;&nbsp;
		                                                        </c:if>
		                                                    </c:forEach>
		                                                  </div></c:if>
		                                                 </c:forEach>
		                                                </div>
		                                            </div>
		
		
		                                        </div>
		                                    </div>
		
		
		                                </div>
		                              </div>  
		                     </div>
                     </form>
                            
					 <div id="Container" class="Container"></div>
         		</div>
             
         
        
    </div>
