<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style>
#countTime {
	width: 12px;
	height: 12px;
	float: right;
	margin-top: 8px;
	margin-right: 2px;
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
			<div class="icol_text">今日执行店数&nbsp;</div>
			<input type="text" class="input_style w5" id="dayRunStoreCount"
				value="${storeStatusCount.dayRunStoreCount }" />
			<div class="icol_text">
				<input type="checkbox" class="ct_ck" name="wt" checked="checked"
					id="executing" />正确执行中&nbsp;
			</div>
			<input type="text" class="input_style w5" id="executingCount"
				value="${storeStatusCount.executingCount }" />
			<div class="sh_i sh_iwt"></div>

			<div class="icol_text">
				<input type="checkbox" class="ct_ck" name="rd" checked="checked"
					id="executeError" />执行出错&nbsp;
			</div>
			<input type="text" class="input_style w5" id="executeErrorCount"
				value="${storeStatusCount.executeErrorCount }" />
			<div class="sh_i sh_ird"></div>

			<div class="icol_text">
				<input type="checkbox" class="ct_ck" name="gy" checked="checked"
					id="readyToStart" />未开始&nbsp;
			</div>
			<input type="text" class="input_style w5" id="readyToStartCount"
				value="${storeStatusCount.readyToStartCount }" />
			<div class="sh_i sh_igy"></div>

			<div class="icol_text">
				<input type="checkbox" class="ct_ck" name="gn" checked="checked"
					id="executeOver" />已完成&nbsp;
			</div>
			<input type="text" class="input_style w5" id="executeOverCount"
				value="${storeStatusCount.executeOverCount }" />
			<div class="sh_i sh_ign"></div>

			<span class="refresh1 refresh_icon" onclick="loadNRMonitorDetail()"></span>
			<span class="refresh2"> <input type="checkbox"
				class="refresh_ck" id="autoRefresh"
				<c:if test="${autoRefreshStatus eq 1 }">
				checked="checked"
				</c:if>
				onclick="timeCount()"  value="nrMonitorDetail"/>&nbsp;&nbsp;自动刷新
			</span>
			<div id="countTime"></div>
		</div>
		<div class="rjjk">
			<c:forEach items="${storesMap }" var="area">
				<div class="r_txt">
					<span class="switch_r zb"></span> ${area.key }
				</div>
				<div class="zb">
					<div class="h0">
						<c:forEach items="${area.value }" var="store">
							<div class="w20 fl_left">
								<span class="p30">${store.storeNo }-${store.storeName }</span>
								<c:if test="${store.status eq 2 }">
									<div class="sh_i sh_iwt"></div>
								</c:if>
								<c:if test="${store.status eq 4 }">
									<div class="sh_i sh_ird"></div>
								</c:if>
								<c:if test="${store.status eq 1 }">
									<div class="sh_i sh_igy"></div>
								</c:if>
								<c:if test="${store.status eq 3 }">
									<div class="sh_i sh_ign"></div>
								</c:if>
							</div>
						</c:forEach>
						<div class="clear"></div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<div style="clear: both;"></div>
</div>
