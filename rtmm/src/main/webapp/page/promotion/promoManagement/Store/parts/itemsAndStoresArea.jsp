<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<div class="CM" style="height: 220px; margin-top: 2px;">
			<div class="CM-bar">
				<div>促销商品门店信息</div>
			</div>
<div class="CM-div">
				<div class="pro_store_item">

					<div class="zt_tit" style="overflow: hidden; width: 100%;">
						<div class="zt_top15">

							<span class="pro1">货号</span> <span class="pro2">商品名称</span> <span
								class="pro3">公司名称</span> <span class="pro4">正常进价(元)</span> <span
								class="pro5">促销进价(元)</span> <span class="pro6">正常售价(元)</span> <span
								class="pro7">促销售价(元)</span> <span class="pro8">降价幅度(%)</span> <span
								class="pro9">净毛利(%)</span>
						</div>
						<div class="cx_tj">
							<div class="cx_tj_inner">
								<input type="text"
									class="inputText ws17_5 Black promBuyPriceBody"
									disabled="disabled" style="margin-left: 576px;" onkeyup="promPriceKeyUp(this,event)" onblur="promBuyPriceBodyBlur(this)"/> <input
									type="text" class="inputText ws10 Black promSellPriceBody" onkeyup="promPriceKeyUp(this,event)" onblur="promSalePriceBodyBlur(this)"
									disabled="disabled" style="margin-left: 112px;" />
							</div>
						</div>
					</div>
					<div class="pro_store_tb" style="height: 56%;"></div>
					<div class="top5">
						<input class="fl_left top3" name="checkStoreItemAll"
							onclick="checkAll(this)" type="checkbox" />
						<div class="deleteBar fl_left" onclick="removeProstore()"></div>
						<div class="lineToolbar fl_left"></div>
						<div class="createNewBar fl_left" onclick="showDelItemDialog()" id="showDeleteItems"></div>
					</div>
			</div>
</div>