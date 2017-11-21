<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
	$(function() {
		$('#ovreviewTab').bind('click', function() {
			showContent(ctx + '/item/query/itemBaseInfo', null);
		});
		sonItemTypeinfo();
	});
</script>
<style type="text/css">
    .iq {
        margin-left:3px;
        background:#ccc;
    }
    .zz_info {
        width:750px;margin-left:20px;
    }
    .zz_2 input {
        margin-left: 3px;
    }
        .zz_2 input[type="checkbox"] {
            float:left;
            margin-top:4px;
            margin-right:3px;
            margin-left:0px;
        }
    .zz_2 {
        height:300px;
    }
    .sp_icon1 {
        margin-left:9px;
    }
    .zz_11 {
        margin-left:55px;
    }
    .zz_12 {
        margin-left:100px;
    }
    .zz_13 {
        margin-left:90px;
    }
    .zz_14 {
        margin-left:55px;
    }
    .zz_15 {
        margin-left:50px;
    }
    .zz_16 {
        margin-left:55px;
    }
</style>
<input type="hidden" id="itemNoStr">
<div style="height:380px;margin-top:2px;" class="CM">
	<div class="CM-bar">
		<div>子货号</div>
	</div>
	<div class="CM-div zz_info">
		<div class="zz_1">
			<span class="zz_11">子货号</span> 
			<span class="zz_12">商品名称</span> 
			<span class="zz_13">商品状态</span> 
			<span class="zz_14">销售单位</span> 
			<span class="zz_15">售价(元)</span> 
			<span class="zz_16">进价(元)</span>
		</div>
		<div id="correlationdiv" class="zz_2">
		<span style="display:block;height:10px;width:100%;"></span>
		</div>
		<div class="ig">
			<input type="checkbox" class="sp_icon1 isCheckAlls" />
			<div class="Icon-size2 Tools10 sp_icon2 deleteCheckeds"></div>
			<div class="Icon-size2 Line-1 sp_icon3 "></div>
			<div class="Icon-size2 Tools11 sp_icon4" onclick="sonItemCorrelationArticleSelect()" ></div>
		</div>
	</div>
</div>
