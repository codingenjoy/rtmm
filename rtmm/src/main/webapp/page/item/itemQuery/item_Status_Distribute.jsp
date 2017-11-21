<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<style type="text/css">
.Table_Panel {
	height: 406px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;	
}
.Panel_footer div{
margin-top:3px;
}
.rBlock{
float: left;width:150px;height:100%;margin-top: 50px;}

.colorBlock{
display:inline-block;
width:20px;height:15px;margin-top:7px;float: left;
}
.colorText{
display:inline-block;line-height:30px;float: left;margin-left:5px;
}
.red{
	background:#f00;
}
/* .highcharts-tooltip{
   width:auto;
   height:auto;
	max-width:300px;
	max-height:300px;
	overflow:auto;
} */
.highcharts-tooltip .tipBlock span{
display:inline-block;
line-height:22px;
width:80px;
overflow:hidden;
float:left;
}
.tipBlock{
width:400px;
}
/* .clearBoth{clear: both;} */
</style>
<script type="text/javascript">
	var colorMap = {};
	colorMap["0"] ="#33CCCC";
	colorMap["1"] ="#DB634F";
	colorMap["5"] ="#FBD258";
	colorMap["6"] ="#44BF87";
	colorMap["8"] ="#F29A3F";
	colorMap["9"] ="#a1e411";
	$(function() {
		var JsonData = ${result};
		if(JsonData != null && JsonData.length > 0){
			var series = [] ;
			for (var i = 0; i < JsonData.length; i++) {
				var statusName = JsonData[i].statusName;
				var statusRatio = Number(JsonData[i].statusRatio.toFixed(2)*100);
				if(i==0){
					var totalStore = JsonData[i].totalNum;
					$(".totalNum").html("总店数："+totalStore);
				}
				
				var colors = colorMap[JsonData[i].status];
				var tName ="店数："+JsonData[i].statusNum;
/* 				var regnNameMap = {};
				for (var j = 0; j < JsonData[i].storeList.length; j++) {
					//tName+=JsonData[i].storeList[j].storeName+",";
					if(regnNameMap[JsonData[i].storeList[j].regnName]){
						regnNameMap[JsonData[i].storeList[j].regnName] += JsonData[i].storeList[j].storeName+",";
					}else{
						regnNameMap[JsonData[i].storeList[j].regnName]=JsonData[i].storeList[j].regnName+":"+JsonData[i].storeList[j].storeName+",";
					}
				}
				$.each(regnNameMap, function(key, value) { 
					tName+=regnNameMap[key];
				});  */
				if(i == 0){
					series.push({name:statusName,y:statusRatio,color:colors,tname:tName,sliced:true,selected: true});
				}else{
					series.push({name:statusName,y:statusRatio,color:colors,tname:tName,});
				}
			}
			showPie(series);
		}
		
	});
	
	function showPie(data){
		$('#container').highcharts({
	        chart: {
	            plotBackgroundColor: null,
	            plotBorderWidth: null,
	            plotShadow: false
	        },
	        exporting:{
	         enabled: false
	        }
	        ,
	        credits: {
	            enabled: false
	        },
	        title: {
	            text: '',
	            useHTML:true
	        },
	        tooltip: {
	    	    pointFormat: '{point.tname}', 
	    	    /* formatter: function () {
	                var s = "<div class='tipBlock'>";
	                var storeNameArray = this.point.tname.split(",");
	                var regnNum=0;
	                for (var i = 0; i < storeNameArray.length; i++) {
						if(storeNameArray[i].search(':')>-1){
			                 var splitAt = storeNameArray[i].indexOf(':')+1;
			                 if(regnNum>=1) {s += "</div>";}
		                	 s += "<span>"+storeNameArray[i].substring(0,splitAt)+"</span><br class='clearBoth'/><div>";
		                	 s += "<span>"+storeNameArray[i].substring(splitAt,storeNameArray[i].length)+"</span>";
		                	 regnNum++;
			            }else{
							if((i+1)%5==0){
								s += "<span>"+storeNameArray[i]+"</span></div><div>";
							}else{
								s += "<span>"+storeNameArray[i]+"</span>";
							}
	                	}
					}
	                s+="</div>";
	                return s;
                },*/
	            useHTML:true
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                dataLabels: {
	                    enabled: true,
	                    color: '#000000',
	                    connectorColor: '#000000',
	                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
	                }
	            }
	        },
	        series:[{
	            type: 'pie',
	            name: '所占比例',
	            data:data
	        }]
	    });
		
	}
</script>

<div class="Panel_top">
	<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
</div>
<div >
	<%-- <div style="margin: 15px auto; width: 97%; height: 100%;" id="container">
		<div class="">
		${result}
		</div>
	</div> --%>
	<div id="container" style="width:600px;height:440px;float: left;"></div>
	<div class="rBlock">
		<div class="ig totalNum"></div>
		<div class="ig">
			<span class="colorBlock" style="background:#33CCCC"></span><span class="colorText">0-尚未生效</span>
		</div>
		<div class="ig">
			<span class="colorBlock" style="background:#DB634F"></span><span class="colorText">1-正常</span>
		</div>
		<div class="ig">
			<span class="colorBlock" style="background:#FBD258"></span><span class="colorText">5-暂时禁下单</span>
		</div>
		<div class="ig">
			<span class="colorBlock" style="background:#44BF87"></span><span class="colorText">6-长期禁下单</span>
		</div>
		<div class="ig">
			<span class="colorBlock" style="background:#F29A3F"></span><span class="colorText">8-进入删除</span>
		</div>
		<div class="ig">
			<span class="colorBlock" style="background:#a1e411"></span><span class="colorText">9-删除</span>
		</div>
	</div>
</div>
