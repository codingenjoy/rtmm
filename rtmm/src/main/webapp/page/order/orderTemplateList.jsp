<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.order_list {
	height: 30px;
	line-height: 30px;
}

.fst {
	width: 615px;
	padding-left: 45px;
	float: left;
	text-decoration: underline;
	color: #3F9672;
	cursor: pointer;
}

.scd {
	width: 185px;
	float: left;
}

.trd {
	width: 160px;
	float: left;
}

.order_list .downExcel {
	margin-right: 10px;
	margin-top: 5px;
	float: right;
}

.order_list .lookExcel {
	margin-right: 3px;
	margin-top: 5px;
	float: right;
}
/*.btable_div .order_list:nth-child(2n) {
            background:#F9F9F9;
        }*/
</style>
<script type="text/javascript">
	$(".order_list:odd").css("background", "#f9f9f9");

	function downLoadTemplate(fileName){
		window.location.href = '${ctx}/order/downLoadTemplate?fileName='+fileName;
		return false;
	}

</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">Excel模板列表</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Content" id="templateList">
		<div class="htable_div">
			<table>
				<thead>
					<tr>
						<td>
							<div class="t_cols align_center" style="width: 30px;">&nbsp;</div>
						</td>
						<td>
							<div class="t_cols" style="width: 615px;">
								模板名称
								<!--<div style="display:inline-block;width:10px;height:20px;"></div>-->
							</div>
						</td>
						<td>
							<div class="t_cols" style="width: 185px;">文件大小</div>
						</td>
						<td>
							<div style="width: 190px; line-height: 20px;">操作</div>
						</td>
					</tr>
				</thead>
			</table>
		</div>
		<div class="btable_div" style="height: 509px;">
			<c:forEach items="${fileList}" var="file">
				<div class="order_list">
					<div class="fst" onclick="downLoadTemplate('${file.fileName}');">${file.fileName}</div>
					<div class="scd">${file.fileSize }</div>
					<div class="trd">
						<div class="lookExcel"></div>
						<div class="downExcel"></div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>