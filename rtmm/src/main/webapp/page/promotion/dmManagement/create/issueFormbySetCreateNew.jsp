<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<%@ include file="/page/commons/datepick.jsp"%>
<script type="text/javascript">
	$(function(){
		
	});
	function createIframeDialog() {
		top.window.$.fn.zWindow({
			width : 600,
			height : 390,
			titleable : true,
			title : '选择套系',
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
	}
</script>

<style type="text/css">
    .fl_left {
        margin-right:3px;
    }
    .lineToolbar {
        margin-top:0;
    }
</style>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left"></div>
	<div class="tagsM">全国性DM期数与主题</div>
	<div class="tags"></div>
	<!--最后一个-->
	<div class="tagsM">全国性及门店DM期数与主题</div>
	<div class="tags tags3 tags_right_on"></div>
	<!--一定不要忘了tag3-->
	<!--add-->
	<div class="tagsM_q  tagsM_on">创建DM期数与主题</div>
	<div class="tags3_close_on">
		<div class="tags_close"></div>
	</div>
</div>
<div class="Container-1">
	<div class="Content">
		<form id="createPromotion_form" action="">
			<div class="CInfo">
				<span>项</span> <span>10，000</span> <span>/</span> <span>1</span> <span>第</span>
				<span>|</span> <span>张三</span> <span>修改人</span> <span>2014-03-03</span>
				<span>修改日期</span> <span>李四</span> <span>建档人</span> <span>2014-02-02</span>
				<span>创建日期</span>
			</div>
			<div style="height: 245px;">
				<div class="inner_half CM">
					<div class="CM-bar">
						<div>促销基本信息</div>
					</div>
					<div class="CM-div">
						<div class="ig_top20">
							<div class="msg_txt">档期</div>
							<input type="text" class="inputText w23" />
						</div>
						<div class="ig">
							<div class="msg_txt">促销期间</div>
							<input type="text" class="Wdate w23"
								onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
							&nbsp;-&nbsp;
							<input type="text" class="Wdate w23"
								onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
						</div>
						<div class="ig">
							<div class="msg_txt">采购期间</div>
							<input type="text" class="Wdate w23"
								onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
							&nbsp;-&nbsp;
							<input type="text" class="Wdate w23"
								onclick="    WdatePicker({ isShowClear: false, readOnly: true })" />
						</div>
						<div class="ig">
							<div class="msg_txt">价格生效日</div>
							<input type="text" class="Wdate w23"
								onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
						</div>
						<div class="ig">
							<div class="msg_txt">套系</div>
							<div class="iconPut w23 fl_left">
								<input type="text" class="w80" />
								<div class="ListWin" onclick="createIframeDialog()"></div>
							</div>
							&nbsp;
							<input type="text" class="inputText w40 Black" readonly="readonly"/>
						</div>
						<div class="ig">
							<div class="msg_txt">会议日</div>
							<input type="text" class="Wdate w23"
								onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
						</div>
						<div class="ig">
							<div class="msg_txt">海报协调人</div>
							<input type="text" class="inputText w23" />
							&nbsp
							<input type="checkbox" />
							&nbsp;并入门店DM
						</div>
					</div>
				</div>
				<div class="inner_half">
					<div class="CM" style="height: 90px">
						<div class="CM-bar-en">
							<div>DM</div>
						</div>
						<div class="CM-div">
							<div class="ig_top20">
								<div class="msg_txt">DM最后定稿日</div>
								<input type="text" class="Wdate w23"
									onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
								&nbsp;<span>DM价格开放日</span>&nbsp;
								<input type="text" class="Wdate w23"
									onclick="    WdatePicker({ isShowClear: false, readOnly: true })" />
							</div>
							<div class="ig">
								<div class="msg_txt">DM计划期间</div>
								<input type="text" class="Wdate w23"
									onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
								&nbsp;-&nbsp;
								<input type="text" class="Wdate w23"
									onclick="    WdatePicker({ isShowClear: false, readOnly: true })" />
							</div>
						</div>
					</div>
					<div class="CM" style="height: 60px; margin-top: 2px;">
						<div class="CM-bar-en">
							<div>S</div>
						</div>
						<div class="CM-div">
							<div class="ig_top20">
								<div class="msg_txt">S计划期间</div>
								<input type="text" class="Wdate w23"
									onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
								&nbsp;-&nbsp;
								<input type="text" class="Wdate w23"
									onclick="    WdatePicker({ isShowClear: false, readOnly: true })" />
							</div>
						</div>
					</div>
					<div class="CM" style="height: 90px; margin-top: 2px;">
						<div class="CM-bar-en">
							<div>L</div>
						</div>
						<div class="CM-div">
							<div class="ig_top20">
								<div class="msg_txt">L计划期间</div>
								<input type="text" class="Wdate w23"
									onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
								&nbsp;-&nbsp;
								<input type="text" class="Wdate w23"
									onclick="    WdatePicker({ isShowClear: false, readOnly: true })" />
							</div>
							<div class="ig">
								<div class="msg_txt">L最后审核日</div>
								<input type="text" class="Wdate w23"
									onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="CM" style="height: 290px; margin-top: 2px;">
				<div class="CM-bar">
					<div>主题与店别</div>
				</div>
				<div class="CM-div">
					<div class="zt_db">
						<div class="top20">
							<span class="zt_title1">编号</span> <span class="zt_title2">主题</span>
							<span class="zt_title3">渠道</span> <span class="zt_title4">参与组别</span>
							<span class="zt_title5">开始日期</span> <span class="zt_title6">结束日期</span>
						</div>
						<div class="ztdb_tb">
							<div class="ig_top10">
								<input type="checkbox" class="fl_left" style="margin-top: 4px;" />
								<input type="text" class="inputText w7 Black fl_left" />
								<input type="text" class="inputText w25 fl_left" />
								<select class="w10 fl_left"><option></option></select>
								<div class="iconPut w25 fl_left">
									<input class="w90" type="text" />
									<div class="ListWin"></div>
								</div>
								<input type="text" class="Wdate w12_5"
									onclick="WdatePicker({ isShowClear: false, readOnly: true })"
									value="2012-09-09" />
								<input type="text" class="Wdate w12_5"
									onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
							</div>
							<div class="ig">
								<input type="checkbox" class="fl_left" style="margin-top: 4px;" />
								<input type="text" class="inputText w7 Black fl_left" />
								<input type="text" class="inputText w25 fl_left" />
								<select class="w10 fl_left"><option></option></select>
								<div class="iconPut w25 fl_left">
									<input class="w90" type="text" />
									<div class="ListWin"></div>
								</div>
								<input type="text" class="Wdate w12_5"
									onclick="WdatePicker({ isShowClear: false, readOnly: true })"
									value="2012-09-09" />
								<input type="text" class="Wdate w12_5"
									onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
							</div>
						</div>
						<div class="top10">
							<input type="checkbox" class="fl_left top5" />
							<div class="deleteBar fl_left"></div>
							<div class="lineToolbar fl_left"></div>
							<div class="createNewBar fl_left"></div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>