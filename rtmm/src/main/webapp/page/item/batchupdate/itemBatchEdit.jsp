<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/item/itemBaseDoc.js" type="text/javascript"></script>
<style type="text/css">
.p52_text3 {
	margin-left: 190px;
}
</style>
<%@ include file="/page/commons/toolbar.jsp"%>
<div id="itemBaseInfoContainer">
	<div class="CTitle">
		<div class="tags1_left tags1_left_on"></div>
		<div class="tagsM tagsM_on">商品批量修改</div>
		<div class="tags tags3_r_on"></div>
	</div>
	<input type="hidden" id="itemBulkEditNo">
	<div class="Container-1">
		<div class="Content">
			<div style="height: 110px; margin-top: 2px;" class="CM">
				<div class="CM-bar">
					<div>修改的版块</div>
				</div>
				<div class="CM-div">
					<div class="ig" style="padding-top: 20px; padding-left: 20px;">
						<input id="itemBaseInfo" type="radio" name="itemChgForum"
							checked="checked" class="itemEditBaseForum" /> <span
							style="margin-left: 5px; margin-right: 50px;">修改商品基本信息</span> <input
							id="addAssoItemSup" type="radio" name="itemChgForum"
							class="itemEditOtherForum" /> <span style="margin-left: 5px;">新增商品厂商关联</span>
					</div>
					<div class="ig" style="padding-left: 20px;">
						<input id="itemChgPrice" type="radio" name="itemChgForum"
							class="itemEditBaseForum" /> <span
							style="margin-left: 5px; margin-right: 50px;">设置商品变价</span> <input
							id="disAssoItemSup" type="radio" name="itemChgForum"
							style="margin-left: 23px;" class="itemEditOtherForum" /> <span
							style="margin-left: 5px;">取消商品厂商关联</span>
					</div>
					<div class="ig" style="padding-left: 20px;">
						<input id="itemStoreInfo" type="radio" name="itemChgForum"
							class="itemEditBaseForum" /> <span
							style="margin-left: 5px; margin-right: 50px;">修改商品门店信息</span> <input
							id="itemBulkEditBidRate" type="radio" name="itemChgForum"
							class="itemEditOtherForum" /> <span style="margin-left: 5px;">修改商品厂商特殊进价税率</span>
					</div>
				</div>
			</div>
			<div style="height: 290px; margin-top: 2px;" class="CM">
				<div class="CM-bar">
					<div>修改的商品</div>
				</div>
				<div class="CM-div">
					<div class="w60 p52_tb">
						<div class="ig">
							<span class="p52_text1">货号</span> <span class="p52_text2">品名</span>
							<span class="p52_text3">状态</span>
						</div>
						<div class="p52_tb1" id="itemBulkEditNoMsg"
							style="overflow-y: auto;"></div>
						<div class="ig">
							<input class="sp_icon1 isCheckAllss" type="checkbox"
								id="itemBulkEditCheckAll" />
							<div class="Icon-size2 Tools10 sp_icon2 deleteCheckeds"
								id="itemBulkEditDelIcon" onclick="itemBulkEditDel()"></div>
							<div class="Icon-size2 Line-1 sp_icon3"></div>
							<div class="Icon-size2 Tools11 sp_icon4" id="itemBulkEditSelIcon"></div>
							<div class="Icon-size2 Line-1 sp_icon3 "></div>
							<div class="Icon-size2 copy sp_icon4" id="itemBulkEditPasIcon"></div>
						</div>
						<div class="Panel_footer">
							<div class="PanelBtn">
								<div class="PanelBtn1" onclick="itemChooseMulModOption()">确定</div>
								<div class="PanelBtn2">取消</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>