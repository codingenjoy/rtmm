<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/iframeContent.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/promotion/periodsToTheTopic.js" charset="utf-8"></script>
<script type="text/javascript">
$(function(){
	getPagePromoIssueAllList();
	$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind(
			"click", function() {
				DispOrHid('B-id');
	});
	$("#Tools21").attr('class', "Icon-size1 Tools21_on");
	$($("#Tools21").parent()).addClass("ToolsBg");
	
	
	function getPagePromoIssueAllList(){
		var promoIssuedFrom = $("#promoIssuedForm").serialize();
		$.ajax({
			url: ctx + '/promotion/DMManagement/promoIssueAllList',
	        type: "post",
	        dataType:"html",
	        data:promoIssuedFrom,
	        success: function(data) {
	 			$("#promoListDiv").html(data);
	        }
		});
	}
	
	//切换全国DM
	$('#countryTab').live( 'click', function() {
		$(top.document).find("#contentIframe").attr("src",ctx + '/promotion/DMManagement/periodAndTheme');

	});
	//切换全国及门店的DM
	/* $('#countryAndShopTab').live( 'click', function() {
		$(top.document).find("#contentIframe").attr("src",ctx + '/promotion/DMManagement/promoIssueAll');
		
	}); */
	//当点击行时，详情按钮变化
	$(".single_tb tr").live("click", function () {
		$("#Tools22").attr('class', "Icon-size1 Tools22");
	});
	//跳转到详情页面
	$("#Tools22").live('click',function(){
		$(top.document).find("#contentIframe").attr("src",ctx + '/promotion/DMManagement/promoIssueFormStoreByHO');
	});
	
	$("#Tools11").attr('class', "Icon-size1 Tools11").bind("click",
			function() {
		issueFormbyStoreSetCreateNew();
		});
	
	$("#shopWindowDiv").live('click',function(){
		top.window.$.fn.zWindow({
			width : 600,
			height : 390,
			titleable : true,
			title : '选择门店',
			moveable : true,
			windowBtn : [ 'close' ],
			windowType : 'iframe',
			targetWindow : top,
			windowSrc : ctx+'/promotion/DMManagement/openPromotionWindowAction',
			resizeable : false,
			/* 关闭后执行的事件 */
			afterClose : function(data) {

			},
			isMode : true
		});
	});
	
});
</script>
<%@ include file="/page/commons/toolbar.jsp"%>

 <div class="CTitle">
        <!--第一个-->
         <div class="tags1_left"></div>
         <div class="tagsM " id="countryTab">全国性DM期数与主题</div>
         <div class="tags tags_right_on"></div>
         <!--最后一个-->
         <div class="tagsM tagsM_on" id="countryAndShopTab">全国性及门店DM期数与主题</div>
         <div class="tags tags3_r_on"></div>
      
 </div>
 <div class="Search Bar_off" ><!-- Bar_on-->
     <div class="SearchTop">
     	<span>查询条件</span>
     	<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
	 </div>
 <div class="SMiddle">
 	<form id="promoIssuedForm">
     <table class="SearchTable" border="0" cellspacing="0" cellpadding="0">
         <tr>
             <td class="ST_td1"><span>档期</span></td>
             <td><input class="w65 inputText" type="text" /></td>
         </tr>
         <tr>
             <td class="ST_td1"><span>主题</span></td>
             <td><input class="w85 inputText" type="text" /></td>
         </tr>
         <tr>
             <td><span>开始日</span></td>
             <td>
                 <input type="text" class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true })"/>&nbsp;-
             </td>
            </tr>
            <tr>
                <td><span>&nbsp;</span></td>
                <td>
                	<input type="text" class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true })"/>
                </td>
            </tr>
            <tr>
                <td><span>结束日</span></td>
                <td>
                	<input type="text" class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true })"/>&nbsp;-
                </td>
            </tr>
            <tr>
                <td><span>&nbsp;</span></td>
                <td>
                	<input type="text" class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true })"/>
                </td>
            </tr>
            <tr>
                <td><span>计划起日</span></td>
                <td>
                	<input type="text" class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true })"/>
                </td>
            </tr>
            <tr >
                <td><span>&nbsp;</span></td>
                <td>
                	<input type="text" class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true })"/>
                </td>
            </tr>
            <tr>
                <td><span>计划迄日</span></td>
                <td>
                	<input type="text" class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true })"/>&nbsp;-
                </td>
            </tr>
            <tr>
                <td><span>&nbsp;</span></td>
                <td>
                	<input type="text" class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true })"/>
                </td>
            </tr>
            <tr>
                <td><span>门店</span></td>
                <td>
               		<div class="iconPut w65 fl_left">
						<input type="text" class="w80">
						<div class="ListWin" id="shopWindowDiv"></div>
					</div>
                </td>
            </tr>
            <tr>
                <td><span>&nbsp;</span></td>
                <td>
                    <input class="w85 inputText" type="text" />
                </td>
            </tr>
            <tr>
                <td><span>排档方</span></td>
                <td>
                    <select class="w85"><option></option></select>
                </td>
            </tr>
        </table>
     </form>
    </div>
    <div class="line"></div>
    <div class="SearchFooter">
        <div class="Icon-size1 Tools20"></div>
        <div class="Icon-size1 Tools6"></div>
    </div>
</div>
<div class="Content" id="promoListDiv" >
 <!-- <div class="htable_div">
     <table>
         <thead>
         <tr>
             <td><div class="t_cols align_center" style="width:30px;">&nbsp;</div></td>
             <td><div class="t_cols align_center" style="width:70px;">档期<div style="display:inline-block;width:10px;height:20px;"></div></div></td>
             <td><div class="t_cols align_center" style="width:150px;">主题</div></td>
             <td><div class="t_cols align_center" style="width:80px;">开始日</div></td>
             <td><div class="t_cols align_center" style="width:80px;">结束日</div></td>
             <td><div class="t_cols align_center" style="width:80px;">计划起日</div></td>
             <td><div class="t_cols align_center" style="width:80px;">计划迄日</div></td>
             <td><div class="t_cols align_center" style="width:100px;">门店</div></td>
             <td><div class="t_cols align_center" style="width:70px;">上档中</div></td>
             <td><div class="t_cols align_center" style="width:100px;">排档方</div></td>
             <td><div style="width:16px;">&nbsp;</div></td>
         </tr>
     </thead>
  </table>
 </div>
 <div class="btable_div" style="height:509px;">
     <table  class="single_tb w100">multi_tb为多选 width:1001px;
         <tr style="color:#ff6a00">
             <td class="align_center tr_close" style="width:30px;"></td>
             <td style="width:71px;">123456</td>
             <td style="width:151px;">世界杯</td>
             <td style="width:81px;">XXXXX有限公司</td>
             <td style="width:81px;">P&GXXXXX有限公司世界杯世界杯</td>
             <td style="width:81px;">123456</td>
             <td style="width:81px;">XXXXX有限公司</td>
             <td style="width:101px;">123456</td>
             <td style="width:71px;">上档中</td>
             <td style="width:101px;">上档方</td>
             <td style="width:auto">&nbsp;</td>
         </tr>
         <tr class="trSpecial Bar_off" style="height:auto;">
             <td class="align_center" style="width:30px;"></td>
             <td colspan="9" style="white-space:normal;">
                 <div class="htable_div" style="height:30px;">
                     <table>
                         <thead>
                         <tr style="background:none;color:#333;">
                             <td><div class="t_cols" style="width:70px;">编号<div style="display:inline-block;width:10px;height:20px;"></div></div></td>
                             <td><div class="t_cols" style="width:232px;">主题</div></td>
                             <td><div class="t_cols" style="width:80px;">渠道</div></td>
                             <td><div class="t_cols" style="width:262px;">参与组别</div></td>
                             <td><div style="width:16px;">&nbsp;</div></td>
                         </tr>
                     </thead>
                  </table>
                 </div>
                 <div class="btable_div" style="height:60px;overflow:auto;">
                     <table width="100%">
                         <tr>
                             <td style="width:71px;">data1</td>
                             <td style="width:233px;">data2</td>
                             <td style="width:81px;">data3</td>
                             <td style="width:263px;">data4</td>
                             <td style="width:auto;">&nbsp;</td>
                         </tr>
                         <tr>
                             <td>data1</td>
                             <td>data2</td>
                             <td>data3</td>
                             <td>data4</td>
                             <td style="width:auto;">&nbsp;</td>
                         </tr>
                     </table>
                 </div>
             </td>
         </tr>
         
         <tr>
             <td class="align_center tr_open"></td>
             <td>123456</td>
             <td>世界杯</td>
             <td>XXXXX有限公司</td>
             <td>P&GXXXXX有限公司世界杯世界杯</td>
             <td>123456</td>
             <td>XXXXX有限公司</td>
             <td>123456</td>
             <td>上档中</td>
             <td>上档方</td>
             <td style="width:auto">&nbsp;</td>
         </tr>
         <tr class="trSpecial">
             <td class="align_center" style="width:30px;"></td>
             <td colspan="9" >厂商名称输入有误。厂商合同标准与失效日期错误。门店课别信息中的采购范围输入有误。其他信息有误。</td>
         </tr>
         <tr>
             <td class="align_center tr_open"></td>
             <td>123456</td>
             <td>世界杯</td>
             <td>XXXXX有限公司</td>
             <td>P&GXXXXX有限公司世界杯世界杯</td>
             <td>123456</td>
             <td>XXXXX有限公司</td>
             <td>123456</td>
             <td>上档中</td>
             <td>上档方</td>
             <td style="width:auto">&nbsp;</td>
         </tr>
     </table>    
 </div>
 <div class="paging">
  <div class="fl_left">
   第1-20项,共 5 项&nbsp;&nbsp;|&nbsp;每页显示 <select>
    <option value="10">10</option>
    <option value="20" selected="selected">20</option>
    <option value="30">30</option>
   </select> 项
  </div>
  <div class="fl_right page_list">
         <span class="fl_right" style="margin-right:10px;">&nbsp;&nbsp;&nbsp;到第 <input name="pageNo" id="goto_page" class="page_no_input" maxlength="5" type="text"/> 页 <input value="go"  type="button"/></span>
             <a class="page_end_block" title="尾页"></a>
             <a class="page_next_block" title="下一页"></a>
             <a title="6" class="num">999999</a>
             <a style="cursor:default;">...</a>
                <a title="2" class="num">3</a>
                <a title="2" class="num">2</a>
                <a title="1" class="num">1</a>
                <a title="上一页" class="page_prev_block_off"></a>
                <a title="首页" class="page_first_block_off"></a>  
     </div>
    </div> -->
</div>