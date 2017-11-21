<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/tld/auchan" prefix="auchan"%>
<div class="CM itemStoreMess" style="height: 296px; margin-top: 2px;">
	<div class="CM-bar">
		<div>促销商品门店信息</div>
	</div>
	<div class="CM-div">
		<div class="pro_store_item">
			<div class="pro_store_item1">
				<div class="top15">所选商品</div>
				<div class="pro_store_items" style="height: 75%;">
				</div>
				<div class="ig_top10">
					<div id="showDeleteItems" unitTypeValue="" unitNoValue="" class="createNewBar_off" onclick="addSelectedItem(this)"></div>
				</div>
			</div>
			<div class="pro_store_item2">
				<table>
					<tr>
						<td class="psi0" >&nbsp;</td>
						<td class="psi1" >门店</td>
						<td class="psi2" >厂商</td>
						<td class="psi3" >&nbsp;</td>
						<td class="psi4" >商品状态</td>
						<td class="psi5" >正常进价(元)</td>
						<td class="psi6" >促销进价(元)</td>
					</tr>
				</table>
				<div class="fu_div">
					<input type="text" class="inputText w12_5 updatePriceAll" onkeyup="inputToInputDoubleNumber(this)" style="margin-left: 565px;" value="" />
				</div>
				<div class="pro_store_tb promItemStoreMess_div" style="height: 65%;">
					<div class="top10"></div>
					</div>
				<div class="top10">
					<input class="fl_left top3 isCheckAllsProm" type="checkbox" disabled="disabled" />
					<div class="deleteBar_off fl_left deleteCheckedsProm" checkUnitType="" checkItemNo="" checkPromNo=""></div>
					<div class="lineToolbar fl_left"></div>
					<div class="createNewBar_off fl_left" id="promItemStore_div" checkUnitType="" checkItemNo="" checkPromNo="" onclick="addStoreSupMess(this)"></div>
				</div>
			</div>
		</div>
	</div>
</div>
