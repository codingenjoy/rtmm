<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/page.css" rel="Stylesheet" />
<style type="text/css">
.m_btn {
	height: 20px;
	width: 50px;
	float: right;
	margin-right: 5px;
	background: #EEEEEE;
	margin-top: 5px;
	color: #3F9673;
	cursor: pointer;
}

.m_btn span {
	line-height: 20px;
	margin-left: 15px;
}
</style>
<div style="height: 620px; display: block;">
	<div class="CTitle">
		<div class="tags1_left tags1_left_on"></div>
		<div class="tagsM tagsM_on">在线户管理</div>
		<div class="tags tags3_r_on"></div>
	</div>
	<div class="paramRightPanel" style="width: 99%; background: #fff;">
		<div class="userList" style="background: #3F9673;">
			用户列表
			<div class="m_btn">
				<span onclick="kickout()">踢出</span>
			</div>
		</div>
		<div class="Content">
			<div class="htable_div">
				<table>
					<thead>
						<tr>
							<td>
								<div class="t_cols" style="width: 50px;">
									<input type="checkbox" name="checkAll" onclick="clickCheckAll(this)">
								</div>
							</td>
							<td>
								<div class="t_cols" style="width: 100px;">用户名</div>
							</td>
							<td>
								<div class="t_cols" style="width: 280px;">安控ID</div>
							</td>
							<td>
								<div class="t_cols" style="width: 180px;">登陆时间</div>
							</td>
							<td>
								<div class="t_cols" style="width: 170px;">登陆IP</div>
							</td>
							<td>
								<div class="t_cols" style="width: 200px;">登陆服务器</div>
							</td>
							<td>
								<div style="width: 16px;">&nbsp;</div>
							</td>
						</tr>
					</thead>
				</table>
			</div>
			<div class="btable_div" style="height: 510px;">
				<table class="single_tb w100">
					<c:if test="${not empty staffs }">
						<c:forEach items="${staffs}" var="item">
							<tr>
								<td style="width: 51px;">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
									type="checkbox" name="sessionId" value="${item.sessionId}"
									onclick="clickCheck(this)">
								</td>
								<td style="width: 101px;"><span style="margin-right: 5px;">${item.staffName}</span>
								</td>
								<td style="width: 281px;">${item.sessionId}</td>
								<td style="width: 181px;"><fmt:formatDate
										pattern="yyyy-MM-dd HH:mm:ss" value="${item.loginTime}" /></td>
								<td style="width: 171px;">${item.loginIP}</td>
								<td style="width: 201px;">${item.loginNode}</td>
								<td style="width: auto">&nbsp;</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

	function clickCheckAll(obj){
		$('input[name=sessionId]').attr('checked',obj.checked);
	}
	
	function clickCheck(obj){		
		var allSize = $('input[name=sessionId]').size();
		var checkSize = $('input[name=sessionId]:checked').size();
		if(allSize == checkSize){
			$('input[name=checkAll]').attr('checked',true);
		}else{
			$('input[name=checkAll]').attr('checked',false);
		}
	}
	
	function kickout() {		
		var sidarray = [];
		var snamearray = [];
		$.each($('input[name=sessionId]:checked'),function(index,item){
			sidarray.push(item.value);
			snamearray.push($(this).parent().next().find('span').text());
		});
		var scmSessionIds = sidarray.join(",");
		var scmStaffNames = snamearray.join(",");
		if (scmSessionIds == '') {
			top.jAlert('common', '请选择需要踢出的用户', '提示消息');
			return;
		}		
		$.post('${ctx}/param/kickout', {
			scmSessionIds : scmSessionIds,
			scmStaffNames  : scmStaffNames
		}, function(data) {
			if (data.status=='success') {
				top.jAlert('success', '操作成功', '提示消息');
				$.post(ctx+'/param/onlineStaffMgmt',function(data){
					$("#content").html(data);
				})
			} else {
				//操作失败
				top.jAlert('error', data.message, '提示消息');
			}

		}, "json");

	}
</script>