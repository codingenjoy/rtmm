<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
	$(function(){
		sonItemTypeinfo_2();
	});
</script>
<input type="hidden" id="itemNoStr">
<div style="height:380px;margin-top:2px;" class="CM">
    <div class="CM-bar"><div>子货号</div></div>
    <div class="CM-div zz_info">
        <div class="zz_1">
            <span class="zz_11">子货号</span>
            <span class="zz_12">商品名称</span>
            <span class="zz_13">商品状态</span>
            <span class="zz_14">包含数量</span>
            <span class="zz_15">销售单位</span>
            <span class="zz_16">售价(元)</span>
            <span class="zz_17">进价(元)</span>
            <span class="zz_18">价格比例(%)</span>
        </div>
        <div id="correlationdiv" class="zz_2">
        	<span style="display:block;height:10px;width:100%;"></span>
        </div>
    	<div class="ig">
           <input type="checkbox" class="sp_icon1 isCheckAlls"/>
           <div class="Icon-size2 Tools10 sp_icon2 deleteCheckeds"></div>
           <div class="Icon-size2 Line-1 sp_icon3 "></div>
           <div class="Icon-size2 Tools11 sp_icon4" onclick="sonItemCorrelationArticleSelect()" ></div>
	    </div>
    </div>
</div>
