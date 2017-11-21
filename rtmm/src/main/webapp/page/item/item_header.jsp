<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
            <div class="CTitle">
                <!--第一个-->
                            <div class="tags1_left tags1_left_on"></div>
                            <div class="tagsM tagsM_on" id="ovreviewTab">商品总览</div>
                            <div class="tags tags_left_on"></div>

                             <!--中间-->
                            <div class="tagsM" id="priceChangeTab">商品变价</div>
                            <div class="tags"></div>
                <!--中间-->
                            <div class="tagsM" id="specInfoTab">商品规格</div>
                            <div class="tags"></div>
                <!--中间-->
                            <div class="tagsM" id="barcodeInfoTab">商品条码</div>
                            <div class="tags"></div>
                <!--中间-->
<!--                             <div class="tagsM" id="realativeInfoTab">商品关联</div>
                            <div class="tags"></div> -->
                <!--中间-->
                            <div class="tagsM" id="supInfoTab">商品厂商</div>
                            <div class="tags"></div>
                <!--中间-->
                            <div class="tagsM" id="realStoreSaleCtrlInfoTab">商品陈列</div>
                            <div class="tags tags3_r_off""></div>
<!--                 中间
                            <div class="tagsM">商品进销存</div>
                            <div class="tags"></div> -->

                            <!--最后一个-->
<!--                             <div class="tagsM" id="itemDCInfoTab">DC商品</div>
                            <div class="tags tags3_r_off"></div> -->
                            
                            <!--一定不要忘了tag3-->
                            <!--add-->
            </div>
            
<script type="text/javascript">
$('#Tools11').removeClass('Tools11_disable');
$('#Tools11').addClass('Tools11');
$(function(){
	$('#Tools11').click(function(){
		$('.tags_right_on').removeClass('tags_right_on');
		$('.tags_left_on').removeClass('tags_left_on');
		$('.tags1_left_on').removeClass('tags1_left_on');
		$('.tagsM_on').removeClass('tagsM_on');
		$('.tags3_r_on').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_off').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_on').removeClass('tags3_r_on');
		$('.tags3_r_off').removeClass('tags3_r_off');
		$('.item_create_tab').show();
		$('.tagsM_q').addClass('tagsM_on');
		//$('.Container-1').load(ctx+"/item/create/baseInfo");
		showContent(ctx + '/item/query/generalSearch',getParam());
	});

	$('.tags_close').click(function(){
		$('.tagsM').eq(0).click();
	});
	//商品变价
	$('#priceChangeTab').click(function(){
 		$('.tags_right_on').removeClass('tags_right_on');
		$('.tags_left_on').removeClass('tags_left_on');
		$('.tags1_left_on').removeClass('tags1_left_on');
		$('.tagsM_on').removeClass('tagsM_on');
		
		$("#ovreviewTab").next().addClass('tags_right_on');
		$('#priceChangeTab').addClass('tagsM_on');
		$("#priceChangeTab").next().addClass('tags_left_on'); 
		
		showContent(ctx + '/item/query/itemPriceChangeInfo',getParam());
		//$('.Container-1').load(ctx+"/item/query/itemPriceChangeInfo");
	});
	$('#specInfoTab').click(function(){
		$('.tags_right_on').removeClass('tags_right_on');
		$('.tags_left_on').removeClass('tags_left_on');
		$('.tags1_left_on').removeClass('tags1_left_on');
		$('.tagsM_on').removeClass('tagsM_on');
		$('.tags3_r_on').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_off').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_on').removeClass('tags3_r_on');
		$('.tags3_r_off').removeClass('tags3_r_off');
		$('.item_create_tab').show();
		$('.tagsM_q').addClass('tagsM_on');
		$('.Container-1').load(ctx+"/item/query/itemSpecInfo");
	});
	$('#barcodeInfoTab').click(function(){
		$('.tags_right_on').removeClass('tags_right_on');
		$('.tags_left_on').removeClass('tags_left_on');
		$('.tags1_left_on').removeClass('tags1_left_on');
		$('.tagsM_on').removeClass('tagsM_on');
		$('.tags3_r_on').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_off').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_on').removeClass('tags3_r_on');
		$('.tags3_r_off').removeClass('tags3_r_off');
		$('.item_create_tab').show();
		$('.tagsM_q').addClass('tagsM_on');
		$('.Container-1').load(ctx+"/item/query/itemBarcodeInfo");
	});
	$('#realativeInfoTab').click(function(){
		$('.tags_right_on').removeClass('tags_right_on');
		$('.tags_left_on').removeClass('tags_left_on');
		$('.tags1_left_on').removeClass('tags1_left_on');
		$('.tagsM_on').removeClass('tagsM_on');
		$('.tags3_r_on').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_off').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_on').removeClass('tags3_r_on');
		$('.tags3_r_off').removeClass('tags3_r_off');
		$('.item_create_tab').show();
		$('.tagsM_q').addClass('tagsM_on');
		$('.Container-1').load(ctx+"/item/query/itemPriceChangeInfo");
	});
	$('#supInfoTab').click(function(){
		$('.tags_right_on').removeClass('tags_right_on');
		$('.tags_left_on').removeClass('tags_left_on');
		$('.tags1_left_on').removeClass('tags1_left_on');
		$('.tagsM_on').removeClass('tagsM_on');
		$('.tags3_r_on').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_off').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_on').removeClass('tags3_r_on');
		$('.tags3_r_off').removeClass('tags3_r_off');
		$('.item_create_tab').show();
		$('.tagsM_q').addClass('tagsM_on');
		$('.Container-1').load(ctx+"/item/query/itemRealativeInfo");
	});
	$('#realativeInfoTab').click(function(){
		$('.tags_right_on').removeClass('tags_right_on');
		$('.tags_left_on').removeClass('tags_left_on');
		$('.tags1_left_on').removeClass('tags1_left_on');
		$('.tagsM_on').removeClass('tagsM_on');
		$('.tags3_r_on').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_off').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_on').removeClass('tags3_r_on');
		$('.tags3_r_off').removeClass('tags3_r_off');
		$('.item_create_tab').show();
		$('.tagsM_q').addClass('tagsM_on');
		$('.Container-1').load(ctx+"/item/query/itemRealativeInfo");
	});
	$('#realStoreSaleCtrlInfoTab').click(function(){
		$('.tags_right_on').removeClass('tags_right_on');
		$('.tags_left_on').removeClass('tags_left_on');
		$('.tags1_left_on').removeClass('tags1_left_on');
		$('.tagsM_on').removeClass('tagsM_on');
		$('.tags3_r_on').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_off').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_on').removeClass('tags3_r_on');
		$('.tags3_r_off').removeClass('tags3_r_off');
		$('.item_create_tab').show();
		$('.tagsM_q').addClass('tagsM_on');
		$('.Container-1').load(ctx+"/item/query/itemRealStoreSaleCtrlInfo");
	});
	$('#itemDCInfoTab').click(function(){
		$('.tags_right_on').removeClass('tags_right_on');
		$('.tags_left_on').removeClass('tags_left_on');
		$('.tags1_left_on').removeClass('tags1_left_on');
		$('.tagsM_on').removeClass('tagsM_on');
		$('.tags3_r_on').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_off').addClass('tags3').addClass('tags_right_on');
		$('.tags3_r_on').removeClass('tags3_r_on');
		$('.tags3_r_off').removeClass('tags3_r_off');
		$('.item_create_tab').show();
		$('.tagsM_q').addClass('tagsM_on');
		$('.Container-1').load(ctx+"/item/query/itemDCInfo");
	});
});
</script>