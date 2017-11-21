/* 隐藏显示搜索栏*/
function showHideLeftSearchDiv(){
	if($('.Container-1 .Search').is(':visible')){
		hideLeft();
	}
	else{
		showLeft();
	}
}

/* 隐藏左边查询*/
function hideLeft(){
	if(!$('.Container-1 .Search').is(':visible')) return;
	$('.Container-1 .Search').hide();
	$('.Container-1 .Content').css('width','99%');
}

/*显示左边查询*/
function showLeft(){
	if($('.Container-1 .Search').is(':visible')) return;
	$('.Container-1 .Search').show();
	$('.Container-1 .Content').css('width','74%');
}

/*显示列表页面*/
function showListPage(){
	$('.list').show();
	//$('.detail').hide();
	$('#Tools1').removeClass('Tools1_disable').addClass('Tools1');
	$('#Tools2').removeClass('Tools2').addClass('Tools2_disable');
	$("#Tools21").attr('class', "Icon-size1 Tools21_on");
	$($("#Tools21").parent()).addClass("ToolsBg");
	$('#Tools11').removeClass('Tools11_disable').addClass('Tools11');
	if($('.btable_checked').size()<1){
		$('#Tools12').removeClass('Tools12').addClass('Tools12_disable');
		$('#Tools22').removeClass('Tools22').removeClass('Tools22_on').addClass('Tools22_disable').removeClass('Tools22_hover').parent().removeClass('ToolsBg');
	}
	else{
		$('#Tools12').addClass('Tools12').removeClass('Tools12_disable');
		$('#Tools22').addClass('Tools22').removeClass('Tools22_disable');
	}
}

/*切换到详细页*/
function switchDetail(title){
	$('.newTitle').text(title);
	$('.list').hide();
	//$('.detail').show(); 
	hideLeft();
	$('#Tools1').removeClass('Tools1_on').parent().removeClass('Tools1Parent_bg');
	$('#Tools1').removeClass('Tools1').addClass('Tools1_disable');
	$('#Tools2').removeClass('Tools2').addClass('Tools2_disable');
	$('#Tools11').removeClass('Tools11').addClass('Tools11_disable');
	$('#Tools12').removeClass('Tools12').addClass('Tools12_disable');
	$('#Tools21').removeClass('Tools21').addClass('Tools21_disable').removeClass('Tools21_hover').removeClass('Tools21_on').parent().removeClass('ToolsBg');
	$('#Tools22').removeClass('Tools22').addClass('Tools22_disable');
}

/*合同模块toolbar初始化*/
function initEnventForDm(){
	$('#Tools1,#Tools2,#Tools10,#Tools11,#Tools12,#Tools21,#Tools22').die().unbind().bind('click',function(){
		bindEvent($(this).attr('id'));
	});
}

/*绑定函数,因为仅根据id绑定函数的话,
 * 到不同页面要来回绑定/取消,
 * 所以根据是否disable,disable的tool不执行相关函数
 */
function bindEvent(toolId){
	var toolElem = $('#'+toolId);
	if(toolElem.hasClass(toolId+'_disable')){
		return ;
	}
	switch(toolId){
		case 'Tools1':showHideLeftSearchDiv();break;
		case 'Tools2':saveDM();break;
		case 'Tools10':del($('.btable_checked').find("input[name='rdmNo']").val());break;
		case 'Tools11':showCreatePage();break;
		case 'Tools12':showEditPage($('.btable_checked').find("input[name='rdmNo']").val());break;
		case 'Tools21':showListPage();break;
		case 'Tools22':showDetailPage($('.btable_checked').find("input[name='rdmNo']").val());break;
	}
}
function showCreatePage(){
	openPopupWin(617,437, '/rp/dm/create');

}
function showEditPage(rdmNo){
	openPopupWin(617,437, '/rp/dm/edit?rdmNo='+rdmNo);
}
function showDetailPage(rdmNo){
	$("#Tools21").attr('class', "Icon-size1 Tools21");
	$("#Tools21").parent().removeClass("ToolsBg");
	openPopupWin(617,437, '/rp/dm/detail?rdmNo='+rdmNo);
}
function saveDM(){
}
function checkSearchForm(){
	var returnVal=true;
	var rdmNo=$.trim($("input[name='rdmNo']").val());
    if(!isNumber(rdmNo)){
    	$("input[name='rdmNo']").addClass("errorInput");
    	$("input[name='rdmNo']").attr("title","DM编号必须为数字！");
    	returnVal=false;
	}
	return returnVal;
}

/*查询表单提交*/
function searchFormSubmit(){
	if(checkSearchForm()){
		currentDMPageQuery();
	}
}

/*翻页信息*/
function currentDMPageQuery(pageNo,pageSize) {
	$('.Container-1 .Content.list').html();
	var param = $('#searchForm').serialize();
	param = joinPostParam(param,'pageNo',pageNo||1);
	param = joinPostParam(param,'pageSize',pageSize||20);
	$.post(ctx + $('#searchForm').attr('action'),param,
			function(data) {
		$('.Container-1 .Content.list').html(data);
		if($('#Tools10').hasClass('Tools10')){
			$('#Tools10').removeClass('Tools10').addClass('Tools10_disable');
		}
		if($('#Tools12').hasClass('Tools12')){
			$('#Tools12').removeClass('Tools12').addClass('Tools12_disable');
		}
	});
};
/*保存创建信息*/
function save(flag){
	var rdmNo=$.trim($("input[name='rdmNoCreate']").val());
	var rdmTopic=$.trim($("input[name='rdmTopicCreate']").val());
	var rdmBeginDateCreate=$.trim($("input[name='rdmBeginDateCreate']").val());
    var rdmEndDateCreate=$.trim($("input[name='rdmEndDateCreate']").val());
    var stCnfrmDaysCreate=$.trim($("input[name='stCnfrmDaysCreate']").val());
    var scmPrepDaysCreate=$.trim($("input[name='scmPrepDaysCreate']").val());
    var stDlvryBefDaysCreate=$.trim($("input[name='stDlvryBefDaysCreate']").val());
    var creatDateCreate=$.trim($("input[name='creatDateCreate']").val());
    var creatByCreate=$.trim($("input[name='creatByCreate']").val());
    var json={};
    if(flag=="add"){
    	
	    json.flag="add";
	    json.rdmTopic=rdmTopic;
	    json.rdmBeginDate=rdmBeginDateCreate;
	    json.rdmEndDate=rdmEndDateCreate;
	    json.stCnfrmDays=stCnfrmDaysCreate;
	    json.scmPrepDays=scmPrepDaysCreate;
	    json.stDlvryBefDays=stDlvryBefDaysCreate;
    }else{
    	json.flag="edit";
    	json.rdmNo=rdmNo;
    	json.rdmTopic=rdmTopic;
	    json.rdmBeginDate=rdmBeginDateCreate;
	    json.rdmEndDate=rdmEndDateCreate;
	    json.stCnfrmDays=stCnfrmDaysCreate;
	    json.scmPrepDays=scmPrepDaysCreate;
	    json.stDlvryBefDays=stDlvryBefDaysCreate;
	    json.creatDate=creatDateCreate;
	    json.creatBy=creatByCreate;
    }
	if(saveValidate(rdmTopic,rdmBeginDateCreate,rdmEndDateCreate,stCnfrmDaysCreate,scmPrepDaysCreate,stDlvryBefDaysCreate)){
		$.ajax({
			url : ctx +'/rp/dm/save?time='+(new Date()).getTime(),
			data : json,
			type : 'POST',
			success : function(response) {
				 if(response['flag']){
				    jAlert('success', response['message'], '提示消息',function(){
				    	$('#Tools12').removeClass('Tools12').addClass('Tools12_disable');
				    	$("#Tools10").removeClass('Tools10').addClass('Tools10_disable');
						$('#Tools22').removeClass('Tools22').removeClass('Tools22_on').addClass('Tools22_disable').removeClass('Tools22_hover').parent().removeClass('ToolsBg');
				    	currentDMPageQuery();
				    	closePopupWin();
				    });
				 }else{
					jAlert('error', response['message'], '提示消息');
				 }
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});
    }
}
function del(rdmNo){
	jConfirm('您确定要删除该保留计划吗？','提示消息',function(ret){
	if(ret){
	$.ajax({
		url : ctx +'/rp/dm/del?time='+(new Date()).getTime(),
		data : {'rdmNo':rdmNo},
		type : 'POST',
		success : function(response) {
			 if(response['flag']){
			    jAlert('success', response['message'], '提示消息',function(){
			    	$('#Tools12').removeClass('Tools12').addClass('Tools12_disable');
			    	$("#Tools10").removeClass('Tools10').addClass('Tools10_disable');
					$('#Tools22').removeClass('Tools22').removeClass('Tools22_on').addClass('Tools22_disable').removeClass('Tools22_hover').parent().removeClass('ToolsBg');
			    	currentDMPageQuery();
			    });
			 }else{
				jAlert('warning', response['message'], '提示消息');
			 }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			jAlert('error', '网络超时!请稍后重试', '提示消息');
		}
	 });
	}
 });
}
/*保存创建信息校验*/
function saveValidate(rdmTopic,rdmBeginDateCreate,rdmEndDateCreate,stCnfrmDaysCreate,scmPrepDaysCreate,stDlvryBefDaysCreate){
	var returnVal=true;
    if(rdmTopic==""){
    	$("input[name='rdmTopicCreate']").addClass("errorInput");
    	$("input[name='rdmTopicCreate']").attr("title","主题不能为空！");
    	returnVal=false;
    }else if(charLen(rdmTopic)>60){
    	$("input[name='rdmTopicCreate']").addClass("errorInput");
    	$("input[name='rdmTopicCreate']").attr("title","主题必须等于小于60个字节！");
    	returnVal=false;
    }
    if(rdmBeginDateCreate==""){
    	$("input[name='rdmBeginDateCreate']").addClass("errorInput");
    	$("input[name='rdmBeginDateCreate']").attr("title","活动开始日不能为空！");
    	returnVal=false;
    }
    if(rdmEndDateCreate==""){
    	$("input[name='rdmEndDateCreate']").addClass("errorInput");
    	$("input[name='rdmEndDateCreate']").attr("title","活动结束日不能为空！");
    	returnVal=false;
    }
    if(stCnfrmDaysCreate==""){
    	$("input[name='stCnfrmDaysCreate']").addClass("errorInput");
    	$("input[name='stCnfrmDaysCreate']").attr("title","门店最少确认天数不能为空！");
    	returnVal=false;
    }else if(!isNumber(stCnfrmDaysCreate)){
    	$("input[name='stCnfrmDaysCreate']").addClass("errorInput");
    	$("input[name='stCnfrmDaysCreate']").attr("title","门店最少确认天数必须为数字！");
    	returnVal=false;
    }else if(stCnfrmDaysCreate=="0"){
    	$("input[name='stCnfrmDaysCreate']").addClass("errorInput");
    	$("input[name='stCnfrmDaysCreate']").attr("title","门店最少确认天数不能小于1！");
		returnVal=false;
    }
    if(scmPrepDaysCreate==""){
    	$("input[name='scmPrepDaysCreate']").addClass("errorInput");
    	$("input[name='scmPrepDaysCreate']").attr("title","SCM备货天数不能为空！");
    	returnVal=false;
    }else if(!isNumber(scmPrepDaysCreate)){
    	$("input[name='scmPrepDaysCreate']").addClass("errorInput");
    	$("input[name='scmPrepDaysCreate']").attr("title","SCM备货天数必须为数字！");
    	returnVal=false;
    }else if(scmPrepDaysCreate=="0"){
    	$("input[name='scmPrepDaysCreate']").addClass("errorInput");
    	$("input[name='scmPrepDaysCreate']").attr("title","SCM备货天数不能小于1！");
		returnVal=false;
   }
    if(stDlvryBefDaysCreate==""){
    	$("input[name='stDlvryBefDaysCreate']").addClass("errorInput");
    	$("input[name='stDlvryBefDaysCreate']").attr("title","门店补货提前天数不能为空！");
    	returnVal=false;
    }else if(!isNumber(stDlvryBefDaysCreate)){
    	$("input[name='stDlvryBefDaysCreate']").addClass("errorInput");
    	$("input[name='stDlvryBefDaysCreate']").attr("title","门店补货提前天数必须为数字！");
    	returnVal=false;
    }else if(stDlvryBefDaysCreate=="0"){
    	$("input[name='stDlvryBefDaysCreate']").addClass("errorInput");
    	$("input[name='stDlvryBefDaysCreate']").attr("title","门店补货提前天数不能小于1！");
    	returnVal=false;
    }
	return returnVal;
}
/*验证DM编号*/
function checkRdmNo(obj){
	   var rdmNo=$.trim($(obj).val());
	   if(!isNumber(rdmNo)){
		   $(obj).addClass("errorInput");
	       $(obj).attr("title","DM编号必须为数字！");
	    }
}
/*验证主题*/
function checkRdmTopic(obj){
	 var rdmTopic=$.trim($(obj).val());
	 if(rdmTopic==""){
	    	$(obj).addClass("errorInput");
	    	$(obj).attr("title","主题不能为空！");
	    }else if(charLen(rdmTopic)>60){
	    	$(obj).addClass("errorInput");
	    	$(obj).attr("title","主题必须等于小于60个字节！");
	    }
}
/*验证活动开始日期*/
function checkRdmBeginDate(obj){
	 var rdmBeginDate=$.trim($(obj).val());
	 if(rdmBeginDate==""){
	    	$(obj).addClass("errorInput");
	    	$(obj).attr("title","活动开始日不能为空！");
	    	returnVal=false;
	  }
}
/*验证活动结束日期*/
function checkRdmEndDate(obj){
	 var rdmEndDate=$.trim($(obj).val());
	 if(rdmEndDate==""){
		$(obj).addClass("errorInput");
		$(obj).attr("title","活动结束日不能为空！");
	}
}
/*验证门店最后确认天数*/
function checkStCnfrmDays(obj){
	 var stCnfrmDays=$(obj).val();
	 if(stCnfrmDays==""){
			$(obj).addClass("errorInput");
			$(obj).attr("title","门店最少确认天数不能为空！");
	 }else if(!isNumber(stCnfrmDays)){
			$(obj).addClass("errorInput");
			$(obj).attr("title","门店最少确认天数必须为数字！");
	 }else if(stCnfrmDays=="0"){
			$(obj).addClass("errorInput");
			$(obj).attr("title","门店最少确认天数不能小于1！");
	 }
}

/*验证SCM备货天数*/
function checkScmPrepDays(obj){
	 var scmPrepDays=$(obj).val();
	 if(scmPrepDays==""){
		$(obj).addClass("errorInput");
		$(obj).attr("title","SCM备货天数不能为空！");
	 }else if(!isNumber(scmPrepDays)){
		$(obj).addClass("errorInput");
		$(obj).attr("title","SCM备货天数必须为数字！");
	 }else if(scmPrepDays=="0"){
			$(obj).addClass("errorInput");
			$(obj).attr("title","SCM备货天数不能小于1！");
	 }
}

/*验证门店补货提前天数*/
function checkStDlvryBefDays(obj){
	 var stDlvryBefDays=$(obj).val();
	 if(stDlvryBefDays==""){
		$(obj).addClass("errorInput");
		$(obj).attr("title","门店补货提前天数不能为空！");
	 }else if(!isNumber(stDlvryBefDays)){
		$(obj).addClass("errorInput");
		$(obj).attr("title","门店补货提前天数必须为数字！");
	 }else if(stDlvryBefDays=="0"){
			$(obj).addClass("errorInput");
			$(obj).attr("title","门店补货提前天数不能小于1！");
	 }
}
/*移除错误样式*/
function removeError(obj){
	$(obj).removeClass("errorInput");
	$(obj).attr("title","");
}
/*清空查询框*/
function clearInput(){
	$('#searchForm').find("input").val("");
}
function closePopupWinDetail(){
	$("#Tools22").attr('class', "Icon-size1 Tools22");
	$("#Tools22").parent().removeClass("ToolsBg");
	$("#Tools21").attr('class', "Icon-size1 Tools21_on Tools21");
	$("#Tools21").parent().addClass("ToolsBg");
	closePopupWin();
}
/*绑定回车事件*/
function enterBind(){
	$(".enterBind").keydown(function(e) {
		if (e.keyCode == 13) {
			searchFormSubmit();
		}
	});
}

function listTrClick(obj){
	$("#Tools22").attr('class', "Icon-size1 Tools22");
	$("#Tools12").removeClass("Tools12_disable");
	$("#Tools12").addClass("Icon-size1 Tools12");
	$("#Tools10").attr('class',"Icon-size1 Tools10");
}
function listTrDblClick(obj){
	$("#Tools21").attr('class', "Icon-size1 Tools21");
	$("#Tools21").parent().removeClass("ToolsBg");
	$("#Tools22").attr('class', "Icon-size1 Tools22_on");
	$($("#Tools22").parent()).addClass("ToolsBg");
	var rdmNo=$(obj).find("input[name='rdmNo']").val();
	openPopupWin(617,437, '/rp/dm/detail?rdmNo='+rdmNo);
}
/* 检查是否是数字	*/
function isNumber(param){  
    var reg = new RegExp("^[0-9]*$"); 
    if($.trim(param)=='')
	    {
	    	return true;
	    }
	    if(!reg.test(param)){  
	       return false; 
	     }
	    else
	    {
	    	return true;
	    }
} 

/*返回字符字节 */
function charLen(s)
{
	var l = 0;
	var a = s.split("");
	for (var i=0;i<a.length;i++)
	{
		if (a[i].charCodeAt(0)<299) {
			l++;
			} 
		else {
			l+=2;
			}
	}
	return l;
 }