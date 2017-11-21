
function pageQuery() {
	var number = new RegExp(/^[0-9]{1,6}$/);
	var taskId = $('#taskId').val();
	if(taskId != "" && !number.test($.trim(taskId))){
		top.jAlert('warning','任务编号请输入数字格式','提示信息');
		return;
	}
	var createDateStart = $('input[name=createDateStart]').val();
	var createDateEnd = $('input[name=createDateEnd]').val();
	if(createDateStart != '' && createDateEnd != '' && createDateStart>createDateEnd){
		top.jAlert('warning','开始时间不能大于结束时间','提示信息');
		return;
	}
	
	var param = $("#queryFrom").serialize();
	$.ajax({
		type : "post",
		data :param,
		dataType : "html",
		url : ctx + '/workspace/task/getTaskByPage',
		success : function(data) {
			$('#task_content').html(data);
		}
	});
}

function onClickRow(module,taskId,prcssId,taskType){
	$('#Tools12').addClass('Tools12_disable');//禁用编辑
	$('#Tools26').addClass('Tools26_disable');//禁用提交
	if(module==1){

		var canEdit = true;
		if(taskId){
			$.ajax({
				type : "post",
				url : ctx + '/workspace/task/checkSupplierCanEdit',
				async : false,
				dataType : "json",
				data : {
					'taskId' : taskId
				},
				success : function(data) {
					canEdit = data;
				}
			});
		}
		if(canEdit){
			var action = 'create';
			if(taskType==1){
				action = 'create';
			}else if(taskType==2){
				action = 'update';
			}
			//修改厂商信息
			$('#Tools12').removeClass('Tools12_disable').addClass('Tools12').unbind('click').bind('click',function() {
				showContent(ctx + '/supplierAudit/createSupplier?taskId=' + taskId+'&action='+action);
			});
			
			//提交审核
			var tools26 = $('#Tools26');
			$(tools26).removeClass('Tools26_disable').addClass('Tools26');
			$(tools26).unbind('click').bind('click',function() {
				top.jConfirm('你确定要提交信息进行审核吗?','提示消息',function(ret){
					if(ret){
						$.ajax({
							type : "post",
							url : ctx+'/workspace/task/doSubmitTask2Audit',
							async :false,
							dataType : "json",
							data : {'taskId':taskId},
							success : function(data) {
								if(data.status=='success'){
									top.jAlert('success', '提交成功','提示消息');
								}else{
									top.jAlert('warning', data.message,'提示消息');
								}
								pageQuery();
							}
						});
					}
				});
			});	
			
		}
	}
	 if(module==2){
		 var canEdit = false;
		 var Tools12 = $('#Tools12');
		 $(Tools12).removeClass('Tools12').addClass('Tools12_disable');
		 var tools26 = $('#Tools26');
		 $(tools26).unbind('click');
		 $.ajaxSetup({async : false});
		 $(tools26).removeClass('Tools26').addClass('Tools26_disable');
			if($.trim(prcssId)!=''){
				$.post( ctx + '/workspace/task/checkItemCanEdit', 'taskId='+taskId, function(data) {
					canEdit = eval(data);
				});
			}
			else{
				canEdit = true;
				//模拟审核通过
				$.post(ctx + "/workspace/task/checkItemCanSubmit?taskId=" + taskId, function(data) {
					if(data.status=='error'){
						return false;
					}
					$(tools26).removeClass('Tools26_disable').addClass('Tools26');
					$(tools26).bind('click',function() {
						top.jConfirm('你确定要提交信息进行审核吗?','提示消息',function(ret){
							if(ret){
								$.ajax({
									type : "post",
									url : ctx+'/workspace/task/doSubmitItemCreateTask2Audit',
									async :false,
									dataType : "json",
									data : {'taskId':taskId},
									success : function(data) {
										if(data.status=='success'){
											top.jAlert('success', '提交成功','提示消息');
										}else{
											top.jAlert('warning', data.message,'提示消息');
										}
									}
								});
							}
						});
					});
				});
			}
			if(canEdit){
				$(Tools12).removeClass('Tools12_disable').addClass('Tools12');
				$(Tools12).unbind('click').bind('click',function() {
					$('.Container-1').load(ctx + "/item/create/baseInfo?taskId="+taskId+"&t="+new Date().getTime());
				});
			}
		$.ajaxSetup({async : true});
	}
	 
	if(module==5){
		 //合同管理
		 var canEdit = true;
		 var Tools12 = $('#Tools12');
		 $(Tools12).removeClass('Tools12').addClass('Tools12_disable');
		 var tools26 = $('#Tools26');
		 $(tools26).unbind('click');
		 $.ajaxSetup({async : false});
		 $(tools26).removeClass('Tools26').addClass('Tools26_disable');
			if($.trim(prcssId)!=''){
				canEdit = false;
			}else{
				$(tools26).removeClass('Tools26_disable').addClass('Tools26');
				$(tools26).bind('click',function() {
					top.jConfirm('你确定要提交信息进行审核吗?','提示消息',function(ret){
						if(ret){
							$.ajax({
								type : "post",
								url : ctx+'/workspace/task/doSubmitContract2Audit',
								async :false,
								dataType : "json",
								data : {'taskId':taskId},
								success : function(data) {
									if(data.status=='success'){
										top.jAlert('success', '提交成功','提示消息',function(){
											onSubMenuItemClick(52);
										});
									}else{
										top.jAlert('warning', data.message,'提示消息');
									}
								}
							});
						}
					});
				});
			}
			if(canEdit){
				$(Tools12).removeClass('Tools12_disable').addClass('Tools12');
				$(Tools12).unbind('click').bind('click',function() {
					$(Tools12).removeClass('Tools12').addClass('Tools12_disable');
					var Tools2 = $('#Tools2');
					$(Tools2).removeClass('Tools2_disable').addClass('Tools2');
					Tools2.unbind('click').bind('click',function(){
						if(Tools2.hasClass('Tools2_disable')){
							return false;
						}
						showCreatePage = function(){return false;};
						saveContract();
					})
					$('.Container-1').html('<div class="Content detail" style="width:99%;"></div>');
					$('.Container-1 .detail').load(ctx + "/supplier/contract/current/editContract?taskId="+taskId+"&t="+new Date().getTime(),function(data){
						var supNo = $("#supNo").val();
						var kebieInput = $("#kebieInput").val();
						if(supNo != "" && kebieInput != ""){
							getBuyerListBySupCatlgId(supNo,kebieInput);
						}
					});
				});
			}
		$.ajaxSetup({async : true});
	}
}


function onDblClickRow(module,taskId){
	//双击
	if(module==1){
		showContent(ctx + '/supplierAudit/getSupplierAuditGeneralInfo?taskId='+taskId);
	}
	else if(module==2){
		$('.Container-1').load(ctx + "/item/create/baseInfo?view=1&taskId="+taskId+"&t="+new Date().getTime());
	}else if(module==5){
		$('.Container-1').load(ctx + "/supplier/contract/current/detailContract?taskId="+taskId+"&t="+new Date().getTime(),function(){
			$('.Container-1').find('input').attr('readonly','readonly');
		});
	}
}