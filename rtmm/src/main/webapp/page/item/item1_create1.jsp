<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/combo.css" />
<script src="${ctx}/shared/js/catalog/catalog.js" type="text/javascript"></script>
<link href="${ctx}/shared/themes/theme2/css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/shared/js/jquery/auto/jquery.autocomplete.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/item/item_create.js" type="text/javascript"></script>
<script src="${ctx}/item/create/citys" type="text/javascript"></script>
<script src="${ctx}/item/create/getRegionNodeListAndUnt" type="text/javascript"></script>

<style type="text/css">
.cdsc0 {
	float: left;
	margin-top: 5px;
	margin-right: 5px;
}

.cdsc1 {
	float: left;
	width: 10%;
	margin-right: 5px;
}

.cdsc2 {
	float: left;
	width: 8%;
	margin-right: 5px;
}

.cdsc2_1 {
	float: left;
	width: 10%;
	margin-right: 5px;
}

.cdsc3 {
	float: left;
	width: 15%;
	margin-right: 5px;
}

.cdsc3_1 {
	float: left;
	width: 20%;
	margin-right: 5px;
}

.cdsp {
	float: left;
	color: #ccc;
	line-height: 20px;
}

.cdsc {
	height: 60px;
	margin-top: 15px;
}

.CInfo span {
	line-height: 20px;
} 
</style>

<script type="text/javascript">
<c:if test="${not empty regionNodeListAndUnt}">${regionNodeListAndUnt }</c:if>
var viewFlag='${view}';
$(function(){
	$('#content .ToolBar td').each(function(){
		var _className=$(this).attr('class');
		if($.trim(_className)!=''){
			if(_className!='' && _className.indexOf('disable')<0){
				$(this).removeClass(_className).addClass(_className+"_disable");
				$(this).unbind('click');
			}
		}
	});

	$('#Tools1').removeClass('Tools1').addClass('Tools1_disable').unbind("click").die();
	$('#Tools21').removeClass('Tools21').addClass('Tools21_disable').unbind("click").die();
	$('#Tools6').addClass('Tools6_disable').removeClass('Tools6').unbind("click").die();
	$('#Tools11').addClass('Tools11_disable').removeClass('Tools11').unbind("click").die();
	$('#Tools21').addClass('Tools21_disable').removeClass('Tools21').unbind("click").die();
	$('#Tools12').addClass('Tools12_disable').removeClass('Tools12').unbind("click").die();
	$('#Tools25').unbind().bind("click",turnRight);
	$('#Tools25').removeClass('Tools25_disable');
	$('#Tools25').addClass('Tools25');
	$('.item_create_1').hide();
	$('.item_create_1:last').show();
	
	if('${view}'=='1'){
		$('input:text').attr('readonly','readonly');
		$('input:checkbox').attr('disabled','disabled');
		$('#Tools2').removeClass('Tools2');
		$('#Tools2').addClass('Tools2_disable');
		$('#Tools2').unbind('click');
		$('.divHide').hide();
		$('.chbox-mgl').css('margin-left','15px');
	}
	else{
		$('#Tools2').removeClass('Tools2_disable');
		$('#Tools2').addClass('Tools2');
		$('#Tools2').unbind('click').bind('click',saveItemInfo);
	}
});

</script>

 <div id="look_Item_p"  class="_p">
        <div id="look_Item_p_brower" style="border:2px solid #3f9673;" class="p_brower">
      <div class="zwindow_titleBar" style="height: 40px;position:relative;"><div class="zwindow_titleButtonBar"><div id="close_LookPic" class="zwindow_action_button zwindow_close"></div></div><div class="zwindow_title titleText">浏览图片信息</div></div>
        
            <div id="look_Item_prev_brower" class="prev_brower"></div>
            <div id="look_Item_pp" class="pp">
                <img  id="look_Item_pp2" alt="" class="pp2"/>
                <div id="look_Item_pp3" class="pp3"></div>
            </div>
            <div id="look_Item_next_brower" class="next_brower"></div>
        </div>
    </div>
<div class="Content item_create_1">
<%@ include file="/page/item/create/item_create_1.jsp"%>
</div>
<div class="Content item_create_2"></div>
<div class="Content item_create_3"></div>
<div class="Content item_create_4"></div>
<div class="Content item_create_5"></div>

<script type="text/javascript">
$('.CInfo').css({'background-image':'url(${ctx}/shared/themes/${theme}/images/item1.jpg)','background-repeat': 'no-repeat','background-color': '#EEE'});
$('.CInfo span').css('line-height','20px');
var theme = '${theme}';
var saveButFlag="save";
$('.item_create_2').hide();
$('.item_create_3').hide();
$('.item_create_4').hide();
$('.item_create_5').hide();
var item_create=new Array([6]);
item_create[1] = null;
item_create[2] = null;
item_create[3] = null;
item_create[4] = null;
item_create[5] = null;
var item_create_content=1;
var itemAdvNo=1;
var current_obj=null; 
var mycurrentstaff=null;
$(function(){
	updateComGrp("ITEM_BASIC_PRCSS_TYPE","#s_prcss_type");
	updateComGrp("ITEM_BASIC_ITEM_PACK","#s_item_pack");
	updateComGrp("ITEM_BASIC_ITEM_TYPE","#s_item_type");
	
 	/* $('#Tools12').toggleClass('Tools12_disable').toggleClass('Tools12'); */
 
	if(viewFlag!='1'){
		loadSelectDiv($('.regionNode'),regionNodeList,2);
		loadSelectDiv($('.orignTitle'),cityList,3);
		loadDownLoadDivByName($(".unitName"),itemUnitList,$('#sellUnitValue'),'80px',0,null);
		loadProducerList($('.producerComName'));
	}
	else{
		$('.ListWin').attr('onclick','');
		$('.sp_icon2').attr('onclick','');
		$('.sp_icon4').attr('onclick','');
	}
	inputToInputIntNumber();
	
	/**输入小数值 double_text*/
	inputToInputDoubleNumber();
	mycurrentstaff="${CurrentStaffNo}";
	<c:if test="${not empty item}">
	if(viewFlag!='1'){
		chubieInputSelect(ctx + "/item/create/getSupDivList?supNo=${item.majorSupNo}");
		kebieInputSelect(ctx+$('#kebieInput').attr('currurl')+$('#chubieInput2').val());
		dafenleiInputSelect(ctx+$('#dafenleiInput').attr('currurl')+$('#kebieInput2').val());
		zhongfenleiInputSelect(ctx+$('#zhongfenleiInput').attr('currurl')+$('#kebieInput2').val());
		xiaofenleiInputSelect(ctx+$('#xiaofenleiInput').attr('currurl')+$('#zhongfenleiInput2').val());
	}
	var itemBasicAuditVo0 = JSON.stringify($('#item_create_1').serializeObject());
	var producerAddrVo0 = JSON.stringify($('#majorRegn').serializeObject());
	var produceAddrList0 = $('#otherRegList').find('.otherRegn').map(function(){
		return JSON.stringify($(this).serializeObject());
	}).get().join(", ");
	item_create[item_create_content]=itemBasicAuditVo0+producerAddrVo0+produceAddrList0;
	</c:if>
});

</script>