<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/js/loading/loading.css" />
<link href="${ctx}/shared/js/freezenColums/f.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/loading/loading.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/common.js" charset="utf-8"></script>	
<script src="${ctx}/shared/js/freezenColums/f.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/shared/js/promotion/common/prototype_rowBasedCanvas.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/promotion/common/prototype_PromUnitCanvas.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/promotion/common/prototype_PromUnitItemsCanvas.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/promotion/common/prototype_PromUnitItemStoresFirstCanvas.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/promotion/common/prototype_PromUnitItemStoresSecondCanvas.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/promotion/common/prototype_PromMgmtHandler.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/promotion/art/ArtPromMgmtHandler.js" charset="utf-8"></script>

<script type="text/javascript" src="${ctx}/shared/js/promotion/art/page.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/promotion/art/validate.js" charset="utf-8"></script>
<script type="text/javascript">

$(function(){
	$("#m_cols_head").scroll(function(){
		var left=$(this).scrollLeft();
		$("#m_cols_body").scrollLeft(left);
	});
	//打开等待页面（小鸟标示）
	  $("#Tools2").removeClass("Tools2_disable").addClass("Tools2");
	  $("#btnAddMoreItems").removeClass("createNewBar_off").addClass("createNewBar");
	  $("#btnAddMoreStores").removeClass("createNewBar_off").addClass("createNewBar");
	 
	  
	  //商品门店的Json数据，unitNo-Array（itemStore）数据结构
	  var itemStoreList = ${itemStoreList};
	  //代号的Json数据(unitNo,unitType，unitName)
	  var unitNoList = ${unitList};
	  //基础数据
	  var basicInfo =${promMgVO};
	  
     
	  initARTDataOnUpdate(itemStoreList,unitNoList,basicInfo);
	
		$(".PanelClose").click(function () {
		    myclose($("#popup"));
		});
		$(".PanelBtn1").click(function () {
		    myclose($("#popup"));
		});
     document.onkeydown = function(e) {
			var ev = e || window.event;//获取event对象 
			var obj = ev.target || ev.srcElement;//获取事件源 
			var t = obj.type || obj.getAttribute('type');//获取事件源类型 
			//获取作为判断条件的事件类型 
			var vReadOnly = obj.readOnly;
			var vDisabled = obj.disabled;
			//处理undefined值情况 
			vReadOnly = (vReadOnly == undefined) ? false : vReadOnly;
			vDisabled = (vDisabled == undefined) ? true : vDisabled;
			//当敲Backspace键时，事件源类型为密码或单行、多行文本的， 
			//并且readOnly属性为true或disabled属性为true的，则退格键失效 
			var flag1 = ev.keyCode == 8
					&& (t == "password" || t == "text" || t == "textarea")
					&& (vReadOnly == true || vDisabled == true);
			//当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效 
			var flag2 = ev.keyCode == 8 && t != "password" && t != "text"
					&& t != "textarea";
			//判断 
			if (flag2 || flag1)
				return false;
		};
		
		//保存数据
		$("#Tools2").die("click").live("click",function(){
			if($(this).hasClass("Tools2_disable")){return;}
			 savePromARTData();
		});
		//关闭等待页面（小鸟标示）
		top.grid_layer_forceClose();
});

function doCloseARTEidtPage(){
	var arrayParamJson = '${paramArrayJson}';
	var arrayParam = JSON.parse(arrayParamJson).artEditParamArray;
	var subjName = arrayParam[1];
	arrayParam[1] = encodeURI(subjName);
	doCloseARTPage(arrayParam);
}
</script>
 <style type="text/css">
       .pso1,.pso2,.pso3 ,.pso4,.pso5 ,.pso6 ,.pso7 ,.pso8,.pso9 {
            float:left;
            margin-left:3px;
            display:inline-block;height:30px;line-height:30px;text-align:center;overflow:hidden;
        }
       .pso1 {
       		margin-left:15px;
            width:118px;
        }
        .pso2 {
            width:124px;
        }
        .pso3 {
            width:255px;
        }
        .pso4 ,
        .pso5,.pso6 {
            width:105px;
        }
        .pso7 {
            width:68px;
        }
        .pso8 {
            width:188px;
        }
         .pso9 {
            width:600px;
        }
        .top_tempx{
        	height:30px;overflow:hidden;
        }
        /*overwrite*/
        .listIcon {
            margin:1px 15px !important;
        }
        .pstb_del {
            margin-left:35px;
        }
        .item {
            height:25px;padding-top:3px;
        }
        .iconPut {
            background:#fff;
        }
        .fl_left {margin-right:3px;
        }
        .lineToolbar {
            margin-top:0;
        }
        .pro_store_tb {
            overflow-x:auto;
        }
        .pro_store_tb_edit .item {
            width:1500px;
        }
        .pro_store_item .top15 {
            width:830px;
            overflow-x:hidden;
        }
        .top_temp {
            width:1900px;height:30px;
        }
        /*frozen table*/
        .frozen_div {
            height: 197px;
            overflow: hidden;
            border-bottom: 1px solid #ccc;
        }
        #frozen_cols {
            height:220px;
            width:140px;
        }
        #move_cols {
            height:220px;/* equals #frozen_cols.height */
            /* width:550px; */
            width:79.5%;
        }
        #f_cols_head, #m_cols_head {
            height:60px;
        }
        #f_cols_body,#m_cols_body {
            height:137px;/* equals #frozen_cols.height - #f_cols_head.height(default value is 40px) */
        }
        .pro_store_tb_edit {
		    overflow-x: hidden;
		}
		
		.bgColorRed{
			border:1px solid #f00;
		}
		.trBgRed{
			background: #f00;
		}
		.Table_Panel {
            height:220px;line-height:22px;
		}
		#popup {
		    border:2px solid #3F9673;
		}
 </style>

<%@ include file="/page/commons/toolbar.jsp"%>
  <div class="CTitle">
       <!--第一个-->
       <div class="tags1_left"></div>
       <!--最后一个-->
       <div class="tagsM">ART促销</div>
       <div class="tags tags3 tags_right_on"></div>
       <!--一定不要忘了tag3-->
       <!--add-->
       <div class="tagsM_q  tagsM_on">修改ART促销</div>
       <div class="tags3_close_on">
           <div class="tags_close" onclick="doCloseARTEidtPage()"></div>
       </div>
</div>
<div class="Container-1">
    <div class="Content">
    	<input type="hidden" id="buyBegin" value="${buyBegin}"/> 
    	<input type="hidden" id="buyEnd" value="${buyEnd}"/> 
    	<input type="hidden" id="sellBegin" value="${sellBegin}"/> 
    	<input type="hidden" id="sellEnd" value="${sellEnd}"/> 
    	<input type="hidden" id="initOver" value="1"/> 
    	<input type="hidden" id="calendarLang" value="${calendarL}"/> 
    	
    	<%@ include file="parts/basicInfo.jsp"%>
		<%@ include file="parts/unitsArea.jsp"%>
		<%@ include file="parts/itemsAndStoresArea.jsp"%>
   </div>
</div>
<!-- 以下是各区块的DOM模板定义 -->
<div id="oneStoreLeftHeadRowTemplate" style="display: none;">
	<%@ include file="template/oneStoreLeftHeadRowTemplate.jsp"%>
</div>
<div id="oneStoreRightBodyRowTemplate" style="display: none;">
	<%@ include file="template/oneStoreRightBodyRowTemplate.jsp"%>
</div>

<div id="templateOnePromUnit" style="display: none">
	<%@ include file="template/onePromUnit.jsp"%>
</div>
<div id="templateOnePromUnitItem" style="display: none">
	<%@ include file="template/onePromUnitItem.jsp"%>
</div>
<%@ include file="parts/refreshLoad.jsp"%>
