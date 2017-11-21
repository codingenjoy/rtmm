/**
 * module : my workspace --> report list
 * reporter : wanghai
 * 
 */

//download the exported files if it is asynchronous export.
function downloadReport(exportId,status){
	/*  2 : 生成完成
	 *  3 : 下载完成
	 **/
	if(status=='2'||status=='3'){
		self.location=ctx+'/workspace/reportMgt/downloadReport?exportId='+exportId;
	}
	else{
		top.jAlert('warning','导出文件运行中或已出错','提示信息');
		return false;
	}
	
}
/*export files when clicking exported button
 *according by 
 *<param>type[async/sync]</param>
 *<param>reportcfgid</param> 
 *<param>params</param>  
**/
function exportReport(type,reportcfgid,params){
	if(reportcfgid==undefined||""==$.trim(reportcfgid)
			||type==undefined||""==$.trim(type)){
		return false;
	}
	if(type=="async"){	
		$.ajax({
			type : "post",
			url : ctx +"/export/asyncExportInfo",
			data : {
		    reportcfgid : reportcfgid,
		    params : params
			},
		    success : function(data){
		    if(data.status=='success'){
	    		top.jAlert('success','已导出到未下载报表列表','提示信息');
		    }
		    else{
	    	    top.jAlert('error','导出错误','提示信息');
		    }
		    }
		});		
	}
	else if(type=="sync"){	
		$.ajax({
			type : "post",
			url : ctx +"/export/syncExportInfo",
			data : {
		    reportcfgid : reportcfgid,
			params : params			
			},
		    success : function(exportId){
		    	if(exportId!=undefined && ""!=$.trim(exportId)){
		    		downloadReport(exportId,'2');
		    		top.jAlert('success','导出成功','提示信息');
		    	}
		    	else{
		    		top.jAlert('error','导出错误','提示信息');
		    	}
		    }
		});		
	}
}
/*covert the serialize string into the object.*/
function serializeToObj(serialParams){
	var serialParamsArray=serialParams.split("&");
	var paramsStr="{";
	var key;
	var value;
	for(var i=0;i<serialParamsArray.length;i++){
		key=serialParamsArray[i].substring(0,serialParamsArray[i].indexOf("="));
		value=serialParamsArray[i].substring(serialParamsArray[i].indexOf("=")+1);
		paramsStr=paramsStr+"\""+key+"\":\""+value+"\",";
	}
	paramsStr=paramsStr.substring(0,paramsStr.length-1)+"}";
	return JSON.parse(paramsStr);
}