<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
//华北，东北，华东，华中，华南，西南，西北
var areaColors = ['#B4DECD', '#1D8281', '#DB634F', '#FF9999', '#FBD258', '#F29A3F', '#44BF87'];
var typeColors=['#336666','#ff9900'];//促销，正常
var coatColors=['#0099CC','#FFCC33','#FF6666'];//总毛利率，正常毛利率，促销毛利率
$(function () {
	 $(".CInfo .analysisIcon").unbind().bind("click", function () {
	    $(this).toggleClass("analysis_off").toggleClass("analysis_on");
	    $(".analysis_part1").toggle();
	    $(".Content").toggleClass("analysis_tby");
	});
    var areaStr = getAreaStr();
    showImageData("1",areaStr);
    pageQuery();
});

	function pageQuery(){
		/*var pageNo = $("#pageNo").val();
		var pageSize = $("#pageSize").val();*/
		var analysisDate = $("#analysisDate").val();
	    var areaStr = getAreaStr();
	    /*if(pageNo == null || pageNo ==""){
	    	pageNo = 0;
	    }
	    if(pageSize==null || pageSize ==""){
	        pageSize =20;
	    }*/
		$.ajax({
	    	url: ctx + '/analysis/storesPerformance/storesPerformanceList?analysisDate='+analysisDate+'&areaStr='+areaStr/*+'&pageNo='+pageNo+'&pageSize='+pageSize*/,
			type: "post",
			dataType:"html",
			success: function(result) {
			  	$("#paList").html(result);
			}
		});
	}
	
	
	
    function showCustPriceData(data,category){
    	 $('#forth_column').highcharts({
             chart: {
                 type: 'bar'
             },
             title: {
                 style: { "display": "none" }
             },
             subtitle: {
                 style: { "display": "none" }
             },
             xAxis: {
                 categories: category,
                 title: {
                     text: null
                 },
                 labels: { enabled: false }

             },
             yAxis: {
                 min: 0,
                 title: {
                     text: 'Population (millions)',
                     align: 'high',
                     style: { "display": "none" }
                 },
                 labels: {
                     overflow: 'justify',enabled: false
                 }
             },
             tooltip: {
                 valueSuffix: '${Yuan}'
             },
             plotOptions: {
                 bar: {
                     dataLabels: {
                         enabled: false
                     }
                 },
	             series: {
	                 pointWidth: 20,
	                 events: {
                         click: function () {
                            showDetail('${AverageBasket}',4);
                         }
                     }
	             }
             },
             legend: {
                 layout: 'vertical',
                 align: 'right',
                 verticalAlign: 'top',
                 x: -40,
                 y: 100,
                 floating: true,
                 borderWidth: 1,
                 backgroundColor: '#FFFFFF',
                 shadow: true,
                 enabled: false
             },
             credits: {
                 enabled: false
             },
             series:data
         }); 
    }
    
    function showGrossMarginData(data,category,plotBand){
    	$('#third_column').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                style: { "display": "none" }
            },
            credits: {
                enabled: false
            },
            
            tooltip: {                                                         
                valueSuffix: '%'                                       
            },/*
            areaColors: ['#B4DECD', '#1D8281', '#DB634F', '#FF9999', '#FBD258', '#F29A3F', '#44BF87'],*/
            xAxis: {
                categories: category,
                tickInterval: 1,
	            plotBands:plotBand,
                labels: { enabled: false }
            },
            yAxis: {
                labels: {
                    enabled: false
                },
                title: {
                    style: { "display": "none" }
                }
            },
            legend: {
                 enabled: false 
            },
            plotOptions: {
                column: {
                    dataLabels: {
                        enabled: false
                    }
                },
                series: {
                    cursor: 'pointer',
                    point: {
                        events: {
                            click: function () {
                               showDetail('${Margin}',3);
                            }
                        }
                    }
                }
            },
            series: [{name: '${Margin}',data: data[0],color:coatColors[0]}, 
                     {name: '${NormalMargin}',data: data[1],color:coatColors[1]}, 
                     {name: '${PromotionMargin}',data: data[2],color:coatColors[2]}
                    ]
        });
    }
    
    function showVisitorsData(data){
    	 $('#second_pie').highcharts({
             chart: {
                 plotBackgroundColor: null,
                 plotBorderWidth: null,
                 plotShadow: true
             },
             title: {
                 style: {"display":"none"}
             },
             credits:{
                 enabled:false // 禁用版权信息
             },
             tooltip: {
 	            pointFormat: '{series.name}: {point.percentage:.1f}%'
             },
             plotOptions: {
                 pie: {
                     allowPointSelect: false,
                     cursor: 'pointer',
                     dataLabels: {
                         enabled: false,
                         format: '{point.name}: {point.percentage:.1f} %',
                         style: {
                             color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                         }
                     }
                 },
                 series: {
                     cursor: 'pointer',
                     point: {
                         events: {
                             click: function () {
                                showDetail("${CustomerNumber}",2);
                             }
                         }
                     }
                 }
             },
             series:[{
                 type: 'pie',
                 name: '${Rate}',
                 data: data
             }]
     });
    }
    
    function showSalesData(data,categories){
    //categories = ['正常', '促销'],
    name = '统计',
    data = data; 
    // Build the data arrays
    var browserData = [];
    var versionsData = [];
    for (var i = 0; i < data.length; i++) {
        // add browser data
        browserData.push({
            name: categories[i],
            y: data[i].y,
            color: data[i].color
        });

        // add version data
        for (var j = 0; j < data[i].drilldown.data.length; j++) {
            var brightness = 0.2 - (j / data[i].drilldown.data.length) / 5;
            var VData = data[i].drilldown.data[j].split("&");
            var typeStr = "${PromotionTurnover}";
            if(VData[5]=="0"){
                typeStr = '${NormalTurnover}';
            }
            versionsData.push({
                name: data[i].drilldown.categories[j]+"<br/>●${StoreNumber}："+VData[2]+"<br/>●${TotalTurnover}："+VData[3]+"${QYuan}<br/>●"+typeStr+"："+VData[4]+"${QYuan}",
                y: Number(VData[0]),
                color: VData[1]
            });
        }
    }

    // Create the chart
    $('#first_pie').highcharts({
        chart: {
            type: 'pie'
        },
        title: {
            style: { "display": "none" }
        },
        credits: {
            enabled: false // 禁用版权信息
        },
        tooltip: {
	            pointFormat: '{point.percentage:.1f}%'
         },
      plotOptions: {
            pie: {
                dataLabels: {
                    enabled: true
                },
                shadow: false,
                center: ['50%', '50%']
            },
            series: {
                cursor: 'pointer',
                point: {
                    events: {
                        click: function () {
                           showDetail("${Turnover}",1);
                        }
                    }
                }
            }
        },
        tooltip: {
            valueSuffix: '%'
        },
        series: [{
           /*  name: '促销类型所占比例', */
           name: '${Rate}',
            data: browserData,
            size: '60%',
            dataLabels: {
                formatter: function () {
                    return this.y > 5 ? this.point.name.split("<br/>")[0] : null;
                },
                color: 'white',
                distance: -30
            }
        }, {
            name: '地区所占比例',
            tooltip: {
 	            pointFormat: ''
            },
            data: versionsData,
            size: '80%',
            innerSize: '60%',
            dataLabels: {
                formatter: function () {
                    return null;
                }
            }
        }]
    }); 
    }
    
    
    
    
 function showImageData(analysisDate,areaStr){
 	$.ajax({
    	url: ctx + '/analysis/storesPerformance/showImageData?analysisDate='+analysisDate+'&areaStr='+areaStr,
		type: "post",
		dataType:"json",
		success: function(result) {
		   if(result.visitorlist.length > 0){
		   	  conVisitorsData(result);
		   }else{
			   
			   $("#second_pie").html("");
			  
		   }
		   if(result.grossMarginlist.length> 0){
		   	 conGrossMarginData(result);
		   }else{
			   $("#third_column").html("");
			   
		   }
		   
		  if(result.custPricelist.length > 0){
		  	 conCustPriceData(result);
		  }else{
			  
			  $("#forth_column").html("");
			  
		   }
		  if(result.salelist.length > 0){
		    conSalesData(result);
		  }else{
			  $("#first_pie").html("");
		   }
		}
	});
 }
 
 function conVisitorsData(result){
 	var dataArray =[];
   for (var i = 0; i < result.visitorlist.length; i++) {
   	   var data =  result.visitorlist[i];
   	   var acolor = getColor(data.areaNo);
   	   if(i==0){
   	   		dataArray.push({name:data.areaName+"<br/>●${StoreNumber}："+data.areaStoreAmount+"<br/>●${CustomerNumber}："+data.areaVistorTotal,y:Number(data.areaVistorRatio),sliced: true,selected: true,color:acolor});
   	   }else{
   			dataArray.push({name:data.areaName+"<br/>●${StoreNumber}："+data.areaStoreAmount+"<br/>●${CustomerNumber}："+data.areaVistorTotal,y:Number(data.areaVistorRatio),color:acolor});
   	   }
   }
   showVisitorsData(dataArray);
 }
 function conGrossMarginData(result){
 	var category =[];
 	var colorArray=[];
	$("input:checkbox[name='area']:checked").each(function(c){
		category.push($(this).attr("title"));
		colorArray.push(areaColors[($(this).val()-1)]);
	});
	var netMaoriTotalArray=[];
    var normalNetMaoriArray=[];
    var promNetMaoriArray=[];
    var dataArray =[];
    var plotBand=[];
    var fromNum = Number(-0.5);
    for (var i = 0; i < result.grossMarginlist.length; i++) {
   	   var data =  result.grossMarginlist[i];
   	   netMaoriTotalArray.push(Number(data.netMaoriTotal));
   	   normalNetMaoriArray.push(Number(data.normalNetMaori));
   	   promNetMaoriArray.push(Number(data.promNetMaori));
   	  
    }
    
     dataArray.push(netMaoriTotalArray);
     dataArray.push(normalNetMaoriArray);
     dataArray.push(promNetMaoriArray);
     for (var j = 0; j < colorArray.length; j++) {
   	   	   	 var toNum = Number(fromNum+1);
   	   	   	  plotBand.push({color:colorArray[j],from:fromNum,to:toNum});
   	   	   	  fromNum = Number(fromNum+1);
   	 }
    showGrossMarginData(dataArray,category,plotBand);
 }
 function conCustPriceData(result){
 	var category =[];
	var sAreaNoArray=[]; 
		$("input:checkbox[name='area']:checked").each(function(){
			category.push($(this).attr("title"));
			sAreaNoArray.push($(this).val());
	});
	var dataArray =[];
   for (var j = 0; j < sAreaNoArray.length; j++) {
   		 var colors = "";
   		 var areaName = "";
   	     var sAreaNo = sAreaNoArray[j];
   	     var datadtailArray =[];
   	     for (var i = 0; i < result.custPricelist.length; i++) {
   			var data  = result.custPricelist[i];
   			var areaNo = data.areaNo;
   			if(areaNo == sAreaNo){
   				areaName=data.areaName+"${AverageBasket}";
   				colors = getColor(areaNo);
   				for (var index = 0; index < sAreaNoArray.length; index++) {
   					if(index != j){
   						datadtailArray.push("");
   					}else{
   						datadtailArray.push(Number(data.customerPrice));
   					}
   				}
   			}
   		 }
   		 dataArray.push({name:areaName,data:datadtailArray,color:colors})
   }
   showCustPriceData(dataArray,category);
 }
 function conSalesData(result){
 	var AreaStr =[];
	$("input:checkbox[name='area']:checked").each(function(){
		AreaStr.push($(this).attr("title"));
	});
	var categories =[];
    var dataArray =[];
    var categoriesArray =AreaStr;
    var areaNoramlRatioArray=[];
    var areaPromRatioArray=[];
    var noramlRatioArray;
    var promRatioArry;
     for (var i = 0; i < result.salelist.length; i++) {
     	var data =  result.salelist[i];
     	var color="";
     	var areaNo = data.areaNo;
     	var areaName = data.areaName;
     	var type= data.type;
     	var areaNoramlRatio = data.areaNoramlRatio;
     	var areaPromRatio = data.areaPromRatio;
     	var areaStoreAmount = data.areaStoreAmount;
     	var areaSalesTotal = data.areaSalesTotal;
     	var areaPromSalesTotal = data.areaPromSalesTotal;
     	var areaNoramlSalesTotal = data.areaNoramlSalesTotal;
     	noramlRatioArray = Number(data.normalRatio);
     	promRatioArry = Number(data.promRatio);
     	for (var j = 0; j < categoriesArray.length; j++) {
     		var cotegory = categoriesArray[j];
     		if(type=="0"){//正常
     			if(cotegory==areaName){
     				color = getColor(areaNo);
     				areaNoramlRatioArray[j] =areaNoramlRatio+"&"+color+"&"+areaStoreAmount+"&"+areaSalesTotal+"&"+areaNoramlSalesTotal+"&"+type;
     			}
     		}else{//促销
     			if(cotegory==areaName){
     				color = getColor(areaNo);
     				areaPromRatioArray[j] =areaPromRatio+"&"+color+"&"+areaStoreAmount+"&"+areaSalesTotal+"&"+areaPromSalesTotal+"&"+type;
     			}
     		}
     		
     	}
     	
     	
	 }
   //categories = ['正常', '促销'],
   categories.push("${Normal}<br/>●${TotalTurnover}："+result.salelist[0].saleTotal+"${QYuan}<br/>●${NormalTurnover}："+result.salelist[0].normalSalesTotel+"${QYuan}");
   categories.push("${Promotion}<br/>●${TotalTurnover}："+result.salelist[0].saleTotal+"${QYuan}<br/>●${PromotionTurnover}："+result.salelist[0].promSalesTotal+"${QYuan}"); 
   	dataArray.push({y:noramlRatioArray ,color: typeColors[1], drilldown: {name: '${Normal}',categories: categoriesArray,data: areaNoramlRatioArray}
        }, {y:promRatioArry,color: typeColors[0],drilldown: {name: '${Promotion}',categories: categoriesArray,data: areaPromRatioArray}});		 
  showSalesData(dataArray,categories);
 }

$("input[name='area']").live("click",function(){
	var analysisDate = $("#analysisDate").val();
	var areaStr = getAreaStr();
	var isPass = checkData(analysisDate,areaStr);
	var flag = true;
	$("input:checkbox[name='area']").each(function(i){
		if(!$(this).prop("checked")){
			flag = false;
			return false;
		};
	});
	
	if(flag){
		$("#checkAll").attr("checked",true);
	}else{
		$("#checkAll").attr("checked",false);
	}
	if(isPass){
		/*getVisitorsData(analysisDate,areaStr);
		getGrossMarginData(analysisDate,areaStr);
		getCustPriceData(analysisDate,areaStr);
		getSalesData(analysisDate,areaStr);*/
		showImageData(analysisDate,areaStr);
		pageQuery();
	}else{
		$(this).attr("checked","checked");
	}
 });
 
function changeDate(){
	var analysisDate = $("#analysisDate").val();
	var areaStr = getAreaStr();
	var isPass = checkData(analysisDate,areaStr);
	if(isPass){
		showImageData(analysisDate,areaStr);
		pageQuery();
	}
}
function checkData(analysisDate,areas){
	var flag = true;
	if(analysisDate ==null || analysisDate ==""){
		top.jWarningAlert('${PleeaseSelectDate}！', '${message}');
		flag =false;
		return;
	}
	
	if(areas ==null || areas.length < 1){
		top.jWarningAlert('${PleaseSelectAReginAtLeast}！', '${message}');
		flag =false;
		return;
	}
	return flag;
}
function getAreaStr(){
	var AreaStr ="";
	$("input:checkbox[name='area']:checked").each(function(){
		AreaStr += $(this).val()+",";
	});
	return AreaStr.substring(0, AreaStr.length-1);
}

/*function getColorIndexStr(){
	var colorIndexStr="";
	$("input:checkbox[name='area']:checked").each(function(){
		
	});
}*/

function getColor(areaNo){
	var color="";
	$("input:checkbox[name='area']").each(function(i){
		 if($(this).val()==areaNo){
		 	color = areaColors[i];
		 }
	});
	return color;
}

$("#checkAll").live("click",function(){
	  if(this.checked){
        $(".isChecks").attr("checked",true);    
    }
    else{
        $(".isChecks").attr("checked",false);    
    }
    
    var areaStr = getAreaStr();
    var workDate = $("#analysisDate").val();
    if(areaStr.length > 0){
	    showImageData(workDate,areaStr);
	    pageQuery();
    }else{
        top.jWarningAlert('${PleaseSelectRegion}！', '${message}');
    }
});

function showDetail(title,flag){
	var analysisDate = $("#analysisDate").val();
	var areaStr = getAreaStr();
	var isPass = checkData(analysisDate,areaStr);
	if(isPass){
		top.window.$.fn.zWindow({
			width : 800,
			height : 550,
			titleable : true,	
			title : title,
			moveable : true,
			windowBtn : ['close'],
			windowType : 'iframe',
			targetWindow : top,
			windowSrc : ctx + '/analysis/storesPerformance/showDetail?analysisDate='+analysisDate+'&areaStr='+areaStr+'&flag='+flag,
			resizeable : false,
			isMode : true
		});
	}
}
</script>