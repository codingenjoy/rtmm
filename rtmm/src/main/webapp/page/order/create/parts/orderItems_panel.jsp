<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="CM" style="height: 180px; margin-top: 2px;">
	<div class="CM-bar">
		<div>订单商品</div>
	</div>
<div class="CM-div">
	<div class="pro_store_item hoOrderCreateStore">
		<div class="top15">
			<span class="pso1">货号</span>
			<span class="pso2">品名</span>
			<!-- <span class="pso3">英文名</span> -->
			<span class="pso2">销售单位</span>
			<span class="pso4">采购方式</span>
			<span class="pso4">成本时点</span>
			<span class="pso4">总订购量</span>
			<span class="pso5">总赠品数量</span>
			<span class="pso6">总在途量</span>
			<span class="pso1">总库存量</span>
		</div>
		<div class="pro_store_tb_edit w100" id="pro_store_tb_edit"></div>
		<div class="ig_top10">
			<div class="first_ztdb createNewBar fl_left" onclick="addOrderItem()"></div>
			<div class="lineToolbar fl_left"></div>
			<div class="copyBar fl_left" onclick="addOrderPasteItem()"></div>
			<div class="lineToolbar fl_left"></div>
			<div class="listBar fl_left" onclick="addOrderPopWin()"></div>
			</div>
		</div>
	</div>
</div>