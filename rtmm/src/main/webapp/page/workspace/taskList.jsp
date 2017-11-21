<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/workspace/task.js" type="text/javascript"></script>
<script>
	$(function() {
		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click",
				function() {
					DispOrHid('B-id');
					gridbar_B();
				});
		pageQuery();
	});

	function search() {
		$("#pageNo").val(1);
		pageQuery();
	}
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<!--最后一个-->
	<div class="tagsM  tagsM_on">
		<c:if test="${module==1}">
			未生效厂商管理
		</c:if>
		<c:if test="${module==2}">
			未生效商品管理
		</c:if>
		<c:if test="${module==3}">
			未生效订单管理
		</c:if>
		<c:if test="${module==4}">
			未生效促销管理
		</c:if>
		<c:if test="${module==5}">
			未生效合同管理
		</c:if>

	</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<form id="queryFrom" class="clean_from">
		<div class="Search Bar_on" style="display: none">
			<!-- Bar_on-->
			<div class="SearchTop">
				<span>查询条件</span>
				<div class="Icon-size1 CircleClose C-id" onclick="{DispOrHid('C-id');gridbar_C();}"></div>
			</div>
			<div class="line"></div>
			<div class="SMiddle">
				<input type="hidden" id="module" name="module" value="${module}" />
				<table class="SearchTable">
					<tr>
						<td>
							<span>任务编号</span>
						</td>
						<td>
							<input id="taskId" name="taskId" type="text" class="inputText w80" onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="8" />
						</td>
					</tr>
					<tr>
						<td class="ST_td1">
							<span>任务类型</span>
						</td>
						<td>
							<c:if test="${module==1}">
								<auchan:select mdgroup="TASK_TYPE" ignoreValue="3,4,5,6,7,8,9,10,11,12,13,14,15,16" name="taskType" _class="select1" style="width:138px;"
									/>
							</c:if>
							<c:if test="${module==2}">
								<auchan:select mdgroup="TASK_TYPE" ignoreValue="1,2" name="taskType" _class="select1" style="width:138px;" />
							</c:if>
							<c:if test="${module==5}">
								<auchan:select mdgroup="TASK_TYPE" ignoreValue="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" name="taskType" _class="select1" style="width:138px;" />
							</c:if>
						</td>
					</tr>
					<!-- <tr>
						<td><span>打印编号</span></td>
						<td><input name="printSeqNo" type="text" class="inputText w80" /></td>
					</tr>
					<tr>
						<td><span>采购厂编</span></td>
						<td><input name="procurement" type="text" class="inputText w80" /></td>
					</tr> -->
					<tr>
						<td>
						<c:if test="${module==1}">
							<span><!-- 采购厂编 --><auchan:i18n id="102006003"/></span>
						</c:if>
						<c:if test="${module==2}">
							<span>商品货号</span>
						</c:if>
						<c:if test="${module==5}">
							<span>合同编号</span>
						</c:if>
						</td>
						<td><input name="bizObjPkNo" type="text" class="inputText w80" onkeyup="this.value=this.value.replace(/\D/g,'')"/></td>
					</tr>
					<tr>
						<td>
							<span>流程创建时间</span>
						</td>
						<td>
							<input name="createDateStart" class="Wdate w80" type="text" onClick="WdatePicker({isShowClear:false,readOnly:true})">
							-
						</td>
					</tr>
					<tr>
						<td>
							<span>&nbsp;</span>
						</td>
						<td>
							<input name="createDateEnd" class="Wdate w80" type="text" onClick="WdatePicker({isShowClear:false,readOnly:true})">
						</td>
					</tr>
				</table>

			</div>
			<div class="line"></div>
			<div class="SearchFooter">
				<div class="Icon-size1 Tools20"></div>
				<div class="Icon-size1 Tools6" onclick="search()"></div>
			</div>
		</div>
		<div class="Content">
			<div class="htable_div">
				<table>
					<thead>
						<tr>
							<td>
								<div class="t_cols" style="width: 150px;">任务编号</div>
							</td>
							<td>
								<div class="t_cols" style="width: 200px;">任务类型</div>
							</td>
							<td>
								<div class="t_cols" style="width: 150px;">任务状态</div>
							</td>
							<td>
								<div class="t_cols" style="width: 150px;">
									<c:choose>
										<c:when test="${module==1}">
											厂商编号
										</c:when>
										<c:when test="${module==2}">
											商品货号
										</c:when>
										<c:otherwise>
											业务对象编号
										</c:otherwise>
									</c:choose>
								</div>
							</td>
							<td>
								<div class="t_cols" style="width: 150px;">修改人</div>
							</td>
							<td>
								<div class="t_cols" style="width: 150px;">修改时间</div>
							</td>
							<td>
								<div style="width: 16px;">&nbsp;</div>
							</td>
						</tr>
					</thead>
				</table>
			</div>
			<div id="task_content">
			</div>
		</div>
	</form>
</div>

