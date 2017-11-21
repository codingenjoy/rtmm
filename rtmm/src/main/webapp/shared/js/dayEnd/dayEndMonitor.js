/**
 * content : javascript of day end monitor
 * author : wanghai
 */
/*display or hide the night run list and detail*/
function showListOrDetail(){
	if($("#nrMonitorMgmtDetail").css("display")=="block"){
		$('#Tools22').unbind().removeClass('Tools22').addClass('Tools22_disable')
		.removeClass('Tools22_hover');
		$('#Tools21').removeClass('Tools21_disable').
		addClass('Tools21').unbind().bind('click',function(){
			$('#nrMonitorMgmtDetail').hide();
			$('#nrMonitorMgmtList').show();
			showListOrDetail();
			//load all night run stores when displaying the nrMonitorMgmtList.
			loadAllNightRunStores();
		});
	}
	else{
		$('#Tools21').unbind().removeClass('Tools21').addClass('Tools21_disable')
		.removeClass('Tools21_hover');
		$('#Tools22').removeClass('Tools22_disable').
		addClass('Tools22').unbind().bind('click',function(){
			$('#nrMonitorMgmtList').hide();
			$('#nrMonitorMgmtDetail').show();
			showListOrDetail();
		});
	}
}

/*load all night run stores.*/
function loadAllNightRunStores(){
	$.ajax({
		type : "post",
		url : ctx + "/nrManagement/loadAllNightRunStores",
		success : function(nrStoreList){
			$("#nrStoresSelect").html("");
			$.each(nrStoreList,function(i,val){
				var option="<option>"+val.storeNo+"-"+val.storeName+"</option>";
				$("#nrStoresSelect").append(option);
			});
			//initiate the jobList and the logs by storeNo.
			initNRJobListAndLog();
		}		
	});
}

/*load the nr monitor detail page*/
function loadNRMonitorDetail(){
	var status=0;
	if($(":visible:input[id='autoRefresh']").attr("checked")=="checked"){
		status=1;
	}
	$.post(ctx+"/nrManagement/nrMonitorMgmt",{status:status},function(data){
		$("#content").html(data);
	});
}
/*get the night run stores' jobList and logs by storeNo*/
function getNRJobListAndLogByStore(storeNo){
	if(storeNo==undefined||""==$.trim(storeNo)){
	var storeNoIndex=$("#nrStoresSelect").val().indexOf('-');
	     storeNo=$("#nrStoresSelect").val().substring(0,storeNoIndex);
	}
	$.ajax({
		type : "post",
		url : ctx + "/nrManagement/getNRJobListAndLogByStore",
		data :{
			storeNo : storeNo
		},
		success : function(jbListAndLogMap){
			if(jbListAndLogMap.nrJobList){
				var nrStoreJobRows="";
				$("#nrStoreJobRows").html("");
				$.each(jbListAndLogMap.nrJobList,function(i,val){
					var nrStoreJobRow=$("table#nrStoreJobRow").children();
					$(nrStoreJobRow).find("[name='jobStatus']").text(val.status);
					$(nrStoreJobRow).find("[name='jobStartTime']").text(
					        new Date(val.startDt).format("yyyy-MM-dd hh:mm:ss"));
					$(nrStoreJobRow).find("[name='jobEndTime']").text(
							new Date(val.endDt).format("yyyy-MM-dd hh:mm:ss"));
					$(nrStoreJobRow).find("[name='jobProcName']").text(val.jobName);
					nrStoreJobRows+=$(nrStoreJobRow).html();
				});
				$("#nrStoreJobRows").append(nrStoreJobRows);	
			}
			if(jbListAndLogMap.nrLogVO){
				$("#nrStoreLog").html(jbListAndLogMap.nrLogVO.logInfo);
			}
		}		
	});
}

/*initiate the nr stores' jobList and logs by storeNo.*/
function initNRJobListAndLog(){
	if($("#nrStoresSelect").val()!=undefined&&$.trim($("#nrStoresSelect").val())){
	var storeNoIndex=$("#nrStoresSelect").val().indexOf('-');
    var storeNo=$("#nrStoresSelect").val().substring(0,storeNoIndex);
	getNRJobListAndLogByStore(storeNo);
	}
	else{
		return false;
	}
}

/*timing refresh jobList and logs*/
function autoRefresh(type){
		if(type=='nrMonitorList'){
		getNRJobListAndLogByStore();		
		timeCount();
		}
		else if(type=="nrMonitorDetail"){
		loadNRMonitorDetail();	
		timeCount();
		}	
}
/*display the time count after checking the checkbox.*/
var nrCount;
function timeCount(type){
	if($(":visible:input[id='autoRefresh']").attr("checked")=="checked"){	
	if($(":visible[id='countTime']").text()==undefined||
			""==$.trim($(":visible[id='countTime']").html())){
		$(":visible[id='countTime']").text(5);	
	}
	else{
		$(":visible[id='countTime']").text($(":visible[id='countTime']").text()-1);
	}
	if($(":visible[id='countTime']").text()>0){
		nrCount=setTimeout("timeCount()",1000);
	}
	else{
		$(":visible[id='countTime']").text("");
		var type=$(":visible[id='autoRefresh']").val();
		autoRefresh(type);
	}
   }
	else{		
		 clearTimeout(nrCount);	
		 $(":visible[id='countTime']").text("");
	}
}
