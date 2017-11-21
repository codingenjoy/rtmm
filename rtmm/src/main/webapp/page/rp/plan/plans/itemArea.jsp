<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="CM orderRPedit">
	<div class="CM-bar">
		<div>商品列表</div>
	</div>
	<div class="CM-div">
		<div class="frozen_div">
			<!--right parts that can scroll-->
			<div class="move_cols">
				<!--frozen top head parts when drag the y-scroll -->
				<div class="m_cols_head">
					<table cellpadding="0" cellspacing="0" class="align_center">
						<tr>
							<td><div style="width: 30px;"></div></td>
							<td><div style="width: 103px;">货号</div></td>
							<td><div style="width: 155px;">品名</div></td>
							<td><div style="width: 97px;">订购倍数</div></td>
							<td><div style="width: 95px;">本次进价（元）</div></td>
							<td><div style="width: 95px;">正常进价（元）</div></td>
							<td><div style="width: 103px;">厂编</div></td>
							<td><div style="width: 153px;">公司名称</div></td>
							<td><div style="width: 93px;">最小量</div></td>
							<td><div style="width: 90px;">总配额</div></td>
							<td><div style="width: 90px;">&nbsp;</div></td>
						</tr>
					</table>
				</div>
				<!--this parts can be scrolled all the time-->
				<div class="m_cols_body order6_edit">
					<table id="itemListFirstDivArea" cellpadding="0" cellspacing="0">
					</table>
				</div>
			</div>

			<div class="frozen_cols">
				<!--frozen top head parts-->
				<div class="f_cols_head">
					<table cellpadding="0" cellspacing="0">
						<tr><td><div style="width: 60px;">&nbsp;</div></td></tr>
					</table>
				</div>
				<!--frozen body parts-->
				<div class="f_cols_body">
					<table id="itemListSecondDivArea" cellpadding="0" cellspacing="0">
					</table>
				</div>
			</div>
		</div>
		<div class="ig" style="border-top:1px solid #999;margin-left:20px;">
			<div class="Icon-size2 Tools11 sp_icon4" onclick="addItem();" ></div>
			<div class="Icon-size2 Line-1 sp_icon3" ></div>
			<div class="Icon-size2 sp_icon3 copy" onclick="showItemPasteWin(this)" ></div>
			<!-- <div class="Icon-size2 lineToolbar fl_left"></div>
            <div id="copyBar_div" class="Icon-size2 copyBar fl_left" onclick="showItemPasteWin(this)"></div> -->
		</div>
	</div>
</div>