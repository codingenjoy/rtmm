$(document).ready(function() {
	$.post(ctx + "/param/showAllRoleMenuAuthorityAction", {}, function(data) {
		$("#menuAuthorityDiv").html(data);
	}, "html");
	
	/*judge if check the checkAllBox when changing the status of the check. */
	$(".isCheck").live("click",function(){
		   var checkAll=true;
		   var itemCheckBoxList=$(".isCheck");
		$.each(itemCheckBoxList,function(index,item){
			if(this.checked==false){
				checkAll=false;
				return false;
			};
			});
		if(!checkAll){	
			$(".isCheckAll").attr("checked",false);
		}
		else{
			$(".isCheckAll").attr("checked",true);
		}
		
	});
	/*judge if check all the checkbox*/
	$(".isCheckAll").live("click",isChelkALL=function(){
		
		if(this.checked){
			$(".isCheck").attr("checked",true);	
		}
		else{
			$(".isCheck").attr("checked",false);	
		}
		
	});
});

/* display the menu authority of role 
 * according by the selected role in the left.
 */
function menuAuthority() {
	    $("#operAuthorityDiv").css('display','none');
	    $("#menuAuthorityDiv").css('display','block');
		showRoleMenuAuthority($("#menuAuthority").parent().parent().find('input#roleId').val());
}

//操作权限
function operateAuthority() {
	$.post(ctx + "/param/showOperateAuthorityAction", {}, function(data) {
		$("#menuAuthorityDiv").css('display','none');
		$("#operAuthorityDiv").css('display','block');
		$("#operAuthorityDiv").html('');
		$("#operAuthorityDiv").html(data);
		showRoleOperAuthority($("#operAuthority").parent().parent().find('input#roleId').val());
	}, "html");

}

function MyttTree() {
}

// 添加用户
function addUser() {
	$("#roleManagenent").css("display", 'none');
	$("#userManagement").css("display", 'none');
	$("#area").css("display", 'none');
	$("#addUser").css("display", 'block');
	basicSelectRoles();

}

// 清除所写角色
function clearText() {
	$("#roleName").val("");
	$("#describe").val("");

}

// 添加角色
function roleSave() {
	var roleName = $("#roleName").val();
	if (roleName == "" || roleName == null) {
		alert("角色不能为空！");
	} else {
		$.post(ctx + "/param/createRole", {
			roleName : $("#roleName").val(),
			describe : $("#describe").val()
		}, function(data) {
			if (data.status == "success") {
				alert(data.text);
				closeModify();
			} else {
				alert(data.text);
			}
		}, "json");
	}
}

// show角色菜单权限
function showRoleMenuAuthority(role) {	
	if(role==""||role==undefined){	
		return false;
	}
    $("#roleId").attr("value",role);
	var checkId = "";
	var deleteChecked = $("#Mytt").tree('getChecked');
	$.each(deleteChecked, function(i, val) {
		checkId = deleteChecked[i].id;
		$('#Mytt').tree('uncheck', $("#Mytt").tree('find', checkId).target);
	});

	RoleId = role;
	/*bind events adding roleMenuAuthority for Tools2. */
	$("#Tools2").attr('class', "Tools2").unbind().bind("click", function() {
		addRoleMenuAuthority(RoleId);
	}).attr('title','保存');

	$.ajax({
		type : "post",
		url : ctx + "/param/showRoleMenuAuthority", 
		data : {
			roleId:role
		},
	    success:function(data) {
		var menuId = data.menuId;
		$.each(menuId, function(i, val) {
				$('#Mytt').tree('check', $("#Mytt").tree('find', val).target);	
		});
	}});
}

//show the existed operation authority  according by the role clicked.
function showRoleOperAuthority(role){
	if(role==""||role==undefined){	
		return false;
	}
    $("#roleId").attr("value",role);
	var checkId = "";
	var deleteChecked = $("#paraOperAuthTree").tree('getChecked');
	$.each(deleteChecked, function(i, val) {
		checkId = deleteChecked[i].id;
		$('#paraOperAuthTree').tree('uncheck', $("#paraOperAuthTree").tree('find', checkId).target);
	});

	RoleId = role;
	/*bind events adding roleMenuAuthority for Tools2. */
	$("#Tools2").attr('class', "Tools2").unbind().bind("click", function() {
		addRoleOperAuthority(RoleId);
	}).attr('title','保存');
	
	$.post(ctx + "/param/showRoleOperAuthority", {
		roleId : role
	}, function(data) {
		var operId = data.operId;
		$(".isCheckAll").removeAttr('checked');
		$(".isCheck").removeAttr('checked');
		$.each(operId, function(i, val) {
				$('#'+val.privId).attr('checked','checked');
		});
	}, "json");
	
}

//
function addRoleOperAuthority(RoleId){
	var operId = $(".isCheck:checked");
	var authorityId = "";
	var strNull = "";
	$.each(operId, function(i, item) {
		authorityId += strNull + operId[i].id;
		strNull = ",";
	});
	
	$.post(ctx + "/param/addRoleOperAuthority", {
		authorityId : authorityId,
		roleId : RoleId
	}, function(data) {
		if (data.status == "success") {
			top.jAlert('success', '操作成功','提示消息');
		} else {
			top.jAlert('error', '操作失败','提示消息');
		}
	}, "json");
}

// 添加角色菜单权限
function addRoleMenuAuthority(RoleId) {
	
	var menuId = $("#Mytt").tree('getChecked');
	var authorityId = "";
	var strNull = "";
	
	if(menuId.length==0){
		
		top.jAlert('warning',"请给角色赋予权限！",'提示消息');
		return false;
	}
	
	$.each(menuId, function(i, item) {
		authorityId += strNull + menuId[i].id;
		strNull = ",";
	});
	
	$.post(ctx + "/param/addRoleMenuAuthority", {
		authorityId : authorityId,
		roleId : RoleId
	}, function(data) {
		if (data.status == "success") {
			top.jAlert('success', '操作成功','提示消息');
		} else {
			top.jAlert('error', '操作失败','提示消息');
		}
	}, "json");

}

function MyttTree2() {
	$('#Mtt2').tree({
		checkbox : false,
		data : [ {
			"id" : 1,
			"text" : "My Documents",
			"state" : "open",
			"children" : [ {
				"id" : 11,
				"text" : "Photos",
				"state" : "open",
				"children" : [ {
					"id" : 111,
					"text" : "Friend"
				// "state":"closed",
				}, {
					"id" : 112,
					"text" : "Wife"
				}, {
					"id" : 113,
					"text" : "Company"
				} ]
			}, {
				"text" : "Languages",
				"state" : "open",
				"children" : [ {
					"text" : "Java"
				}, {
					"text" : "C#"
				} ]
			} ]
		}, {
			"id" : 2,
			"text" : "CompanyCCCCCCCCCCCC",
			"state" : "open",
			"children" : [ {
				"text" : "Java"
			}, {
				"text" : "C#"
			} ]
		} ]
	});
}
