//加载部门树
function initDeptTree(storeId) {
	if (storeId != '') {
		$('#deptTree').find('li').remove();// 先删除树
		$.post(ctx + "/param/loadDeptTreeData", {
			'storeId' : storeId
		}, function(data) {			
			$('#deptTree').tree({
				checkbox : false,
				data : data,
				onClick : function(node) {
					initJobFunList(node.id);
				}
			});
		}, "json");
	} else {
		$('#deptTree').find('li').remove();
	}
}
	
//根据部门查询职位信息
function initJobFunList(deptId) {
	$.ajax({
		type : "post",
		url : ctx + "/param/getJobFunctionInfoByDept",
		dataType : "json",
		data : {
			deptId : deptId
		},
		success : function(data) {
			
			$('#jobFunList').empty();
			$('#selectRoleList').empty();
			$.each(data, function(key, value) {
				
				var obj = '<div class="item" id=jobfun_' + value.id
						+ ' onclick="getRoleInfoByJobFun(' + value.id
						+ ')"><span>' + value.jobFunctionName
						+ '</span><div class="ListIcon"></div></div>';
				$('#jobFunList').append(obj);
			});
		}
	});
}

// 根据职位查询关联角色
function getRoleInfoByJobFun(jobFunId) {
	$.ajax({
		type : "post",
		url : ctx + "/param/getRoleInfoByJobFun",
		dataType : "json",
		data : {
			jobFunId : jobFunId
		},
		success : function(data) {
			
			listAllRoles();
			$('#selectRoleList').empty();
			$.each(data, function(key, value) {
				
				$('#unSelectRoleList').find('#role_' + value.id).remove();
				var obj = '<div class="item2" id="role_' + value.id
						+ '"><span>' + value.name
						+ '</span><div class="ListIcon"></div></div>';
				$('#selectRoleList').append(obj);
			});
		}
	});
}

// 查询所有角色
function listAllRoles() {
	$.ajax({
		type : "post",
		async : false,
		url : ctx + "/param/listAllRoles",
		dataType : "json",
		success : function(data) {
			
			$('#unSelectRoleList').empty();
			$.each(data, function(key, value) {
				
				var obj = '<div class="item3" id="role_' + value.id
						+ '"><span>' + value.name
						+ '</span><div class="ListIcon"></div></div>';
				$('#unSelectRoleList').append(obj);
			});
		}
	});
}

//为职位关联角色
function join() {
	$.each($('#unSelectRoleList').find('.item_on'), function(key, value) {		
		$(value).remove();
		$('#selectRoleList').append(value);
	});
}

//取消职位已关联的角色
function unjoin() {
	$.each($('#selectRoleList').find('.item_on'), function(key, value) {		
		$(value).remove();
		$('#unSelectRoleList').append(value);
	});
}

/* 保存职位与角色绑定 */
function doSaveJobFunRole() {
	if ($('#jobFunList').find('.item_on').length == 0) {
		alert('请选择一个职位进行设置');
		return;
	}
	var jobFunId = $('#jobFunList').find('.item_on')[0].id.replace('jobfun_',
			'');
	var roleIds = '';
	var sep = '';
	$.each($('#selectRoleList').children(), function(key, value) {
		
		roleIds = roleIds + sep + value.id.replace('role_', '');
		sep = ',';
	});
	$.ajax({
		type : "post",
		async : false,
		url : ctx + "/param/doSaveJobFunRole",
		data : {
			jobFunId : jobFunId,
			roleIds : roleIds
		},
		dataType : "json",
		success : function(data) {
			top.jAlert("success","操作成功","提示信息");
			//alert("操作成功");
		}
	});
}