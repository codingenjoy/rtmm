<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css"
	href="${ctx}/shared/themes/${theme}/css/freezenColums/f.css"
	rel="Stylesheet" />
<link type="text/css"
	href="${ctx}/shared/themes/${theme}/css/freezenColums/f.js"
	rel="Stylesheet" />
<style type="text/css">
.wh_280 {
	width: 280px;
}

.wh_12 {
	width: 12px;
}
</style>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">日结监控</div>
	<div class="tags tags3_r_on"></div>
</div>

<div class="Container-1">
	<div class="Content_nr">
		<div class="ct_info">
			<div class="icol_text">店号&nbsp;</div>
			<select class="w12_5" id="nrStoresSelect"
				onchange="getNRJobListAndLogByStore()">
			</select>
		
			<span class="refresh1 refresh_icon" id="refresh" onclick="getNRJobListAndLogByStore()">
			</span>
			<span class="refresh2">
				<input type="checkbox" class="refresh_ck" id="autoRefresh" onclick="timeCount()" value="nrMonitorList"/>&nbsp;&nbsp;自动刷新
			</span>
		</div>

		<div class="move_cols tabel_002">
			<!--frozen top head parts when drag the y-scroll -->
			<div class="m_cols_head">
				<table cellpadding="0" cellspacing="0">
					<tbody>
						<tr>
							<td><div class="wh_12">&nbsp;</div></td>
							<td><div class="wh_245">状态</div></td>
							<td><div class="wh_245">开始时间</div></td>
							<td><div class="wh_245">结束时间</div></td>
							<td><div class="wh_280">程序名称</div></td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--this parts can be scrolled all the time-->
			<div class="m_cols_body">
				<table cellpadding="0" cellspacing="0" class="single_tb"
					id="nrStoreJobRows">
				</table>
			</div>
		</div>
		<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
		<div class="ct_cm ct_cm2">
			<div class="szText">
				<div class="sz_text">
					<div class="sz_cld">详细信息</div>
				</div>
			</div>
			<div class="cm_block" id="nrStoreLog"></div>
		</div>

	</div>
	<div style="clear: both;"></div>
</div>

<table id="nrStoreJobRow" style="display: none;">
	<tr class="tr0">
		<td><div class="align_center wh_12">&nbsp;</div></td>
		<td><div class="longText wh_245" name="jobStatus"></div></td>
		<td><div class="longText wh_245" name="jobStartTime"></div></td>
		<td><div class="longText wh_245" name="jobEndTime"></div></td>
		<td><div class="wh_temp wh_280" name="jobProcName"></div></td>
	</tr>
</table>


