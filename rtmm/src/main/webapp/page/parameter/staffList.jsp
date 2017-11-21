<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/page/role_Param11.css" rel="Stylesheet" />
<style type="text/css">
.m_btn {
	height: 20px;
	width: 70px;
	float: right;
	margin-right: 5px;
	background: #EEEEEE;
	margin-top: 5px;
	color: #3F9673;
	cursor: pointer;
	text-align: center;
	line-height: 20px;
	margin-right: 5px;
	background: #EEEEEE;
	margin-top: 5px;
	color: #3F9673;
	cursor: pointer;
	text-align: center;
}

.userListTop3 {
	width: 240px;
	height: 20px;
	float: right;
	margin: 5px 5px auto auto;
	border: 1px solid #CCCCCC;
}

.userList {
	width: 100%;
	height: 30px;
	line-height: 30px;
	color: #fff;
}
</style>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/page.css" rel="Stylesheet" />
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<div class="RightPanel" id="RightPanel">
	<div style="height: 620px; display: block;" id="userManagement">
		<div class="CTitle">
			<div class="tags1_left tags1_left_on"></div>
			<div class="tagsM tagsM_on">密码重置及解锁</div>
			<div class="tags tags3_r_on"></div>
		</div>
		<div class="paramRightPanel" style="width: 99%; background: #fff;">
			<div class="userList" style="background: #3F9673;">
				用户列表
				<div class="m_btn" onclick="resetPassWord();">重置密码</div>
				<div class="m_btn" onclick="unLock();">解锁</div>
				<div class="m_btn" onclick="lock();">锁定</div>
				<div class="userListTop3" style="background: #fff;">
					<input type="text" class="userListText FloatLeft" id="userName"
						placeholder="请输入姓名进行查询"> <span
						style="float: right; width: 16px; height: 16px; margin: 2px 2px auto auto;">
						<input type="image"
						src="/rtmm/shared/themes/${theme}/images/Search.gif"
						onclick="pageQuery()">
					</span>
				</div>
			</div>
			<div id="user_content" class="Content"></div>
			<input type="hidden" id="storeNo" /> <input type="hidden"
				id="deptNo" /> <input type="hidden" id="userName" />
		</div>
	</div>
</div>
<script type="text/javascript">
	//用户分页查询
	var staffId = null;
	var locked = null;
	function pageQuery() {
		staffId = null;
		$.ajax({
			type : "post",
			data : {
				pageNo : $('#pageNo').val(),
				pageSize : $('#pageSize').val(),
				storeNo : '0',
				deptNo : '',
				userName : ($('#userName').val()=='请输入姓名进行查询'?"":$('#userName').val()),
				showAll : true,
				showValid : true
			},
			dataType : "html",
			url : ctx + '/param/staffListPage',
			success : function(data) {
				$('#user_content').html(data);
			}
		});
	}
	pageQuery();

	function onClickRow(sid,lck){
		
		staffId = sid;
		locked = lck;
	}
	
	//重置密码
	function resetPassWord() {
		var staffIds = staffId;
		if (staffIds == null) {
			top.jAlert('warning', '请选择需要一个用户', '提示消息');
			return;
		}
		top.jConfirm('你确定要重置用户密码?', '提示消息', function(data) {
			if (data) {
				$.post(ctx + '/param/resetPassWord', {
					'staffIds' : staffIds
				}, function(data) {
					if (data) {
						//重载表格数据
						top.jAlert('success', '操作成功', '提示消息');
						pageQuery();
					} else {
						//操作失败
						top.jAlert('error', '操作失败', '提示消息');
					}

				}, "json");
			}
		});
	}

	//解锁
	function unLock() {
		var staffIds = staffId;
		if (staffIds == null) {
			top.jAlert('error', '请选择需要一个用户', '提示消息');
			return;
		}
		if(locked=="false"){
			top.jAlert('warning', '该用户未被锁定,无需解锁', '提示消息');
			return;
		}
		top.jConfirm('你确定要解锁用户吗?', '提示消息', function(ret) {
			if (ret) {
				$.post(ctx + '/param/unLock', {
					'staffIds' : staffIds
				}, function(data) {
					if (data) {
						top.jAlert('success', '操作成功', '提示消息');
						pageQuery();
					} else {
						//操作失败
						top.jAlert('error', '操作失败', '提示消息');
					}
				}, "json");
			}
		});
	}

	//锁定
	function lock() {
		
		var staffIds = staffId;
		if (staffIds == null) {
			top.jAlert('error', '请选择需要一个用户', '提示消息');
			return;
		}
		if(locked=="true"){
			top.jAlert('warning', '该为用户已经被锁定', '提示消息');
			return;
		}
		top.jConfirm('你确定要锁定用户吗?', '提示消息', function(data) {
			if (data) {
				$.post(ctx + '/param/lock', {
					'staffIds' : staffIds
				}, function(data) {
					if (data) {
						//重载表格数据
						top.jAlert('success', '操作成功', '提示消息');
						pageQuery();
					} else {
						//操作失败
						top.jAlert('success', '操作成功', '提示消息');
					}

				}, "json");

			}
		});
	}
</script>