<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
var areaColors = ['#B4DECD', '#1D8281', '#DB634F', '#FF9999', '#FBD258', '#F29A3F', '#44BF87'];
var typeColors=['#336666','#ff9900'];//促销，正常
var coatColors=['#0099CC','#FFCC33','#FF6666'];//总毛利率，正常毛利率，促销毛利率
    function showCustPriceDataD(data,category){
    	 $('#show').highcharts({
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
                text: '${Region}'                                                 
            }                                                              
        },                                                                 
        yAxis: {                                                           
            min:0,
            showEmpty: false,                                                      
            title:{                                                       
    			text: '${TurnoverY}',                             
    			align: 'high'         
    		 }, 
    		 labels: {                                                      
  				overflow: 'justify'                                        
           	 }                                                              
        },                                                                 
        tooltip: {                                                         
            valueSuffix: '${Yuan}'                                       
        },                                                                 
        plotOptions:{                                                     
            bar:{       
                dataLabels:{                                              
      				enabled:true,                                      
      				align: 'right'        
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
            shadow: true                                                   
        },                                                                 
        credits: {                                                         
            enabled: false                                                 
        },   
         plotOptions: {
            series: {
                pointWidth: 20
            }
        },
        series: data 
         }); 
    }
    
    
    
    
    function showGrossMarginDataD(data,category,plotBand){
    	$('#show').highcharts({
    		 chart: {
            type: 'column'
        },
        title: {
             style: { "display": "none" }
        },
        xAxis: {
            categories: category,
             tickInterval: 1,
	         plotBands:plotBand
        },
        tooltip: {                                                         
            valueSuffix: '%'                                       
        },
        yAxis: {
            title:{
               	align: 'high',
                offset: 0,
                text: '%',
                rotation: 0
            }
        },
        credits: {
            enabled: false
        },
        series: [{name: '${Margin}',data: data[0],color:coatColors[0]}, 
                 {name: '${NormalMargin}',data: data[1],color:coatColors[1]}, 
                 {name: '${PromotionMargin}',data: data[2],color:coatColors[2]}
               ]
        });
    }
    
    function showVisitorsDataD(data){
    	 $('#show').highcharts({
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
            	 valueSuffix: '%'
 	            //pointFormat: '{series.name}：{point.percentage:.1f}%'
             },
             plotOptions: {
                 pie: {
                     allowPointSelect: false,
                     cursor: 'pointer',
                     dataLabels: {
                         enabled: true,
                         format: '{point.name}<br/>{series.name}:{point.percentage:.1f}%',
                         style: {
                             color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                         }
                     }
                 },
                 series: {
                     cursor: 'pointer'
                 }
             },
             series:[{
                 type: 'pie',
                 name: '${Rate}',
                 data: data
             }]
     });
    }
    
    function showSalesDataD(data,categoriesinput){
    	categories =categoriesinput,
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
                typeStr = "${NormalTurnover}";
            }
            versionsData.push({
                name: data[i].drilldown.categories[j]+"<br/>●${StoreNumber}："+VData[2]+"<br/>●${TotalTurnover}："+VData[3]+"${QYuan}<br/>●"+typeStr+"："+VData[4]+"${QYuan}",
                y:Number(VData[0]),
                color:VData[1]
            });
        }
    }

    // Create the chart
    $('#show').highcharts({
        chart: {
            type: 'pie'
        },
        title: {
            style: { "display": "none" }
        },
        credits: {
            enabled: false // 禁用版权信息
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
                cursor: 'pointer'
            }
        },
        tooltip: {
            valueSuffix: '%'
        },
        series: [{
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
            data: versionsData,
            tooltip: {
 	            pointFormat: ''
            },
            size: '80%',
            innerSize: '60%',
            dataLabels: {
                formatter: function () {
                    return this.y > 1 ?  this.point.name : null;
                }
            }
        }]
    }); 
    }

function getVisitorsDataD(analysisDate,areaStr,categoryStr){
	$.ajax({
    	url: ctx + '/analysis/storesPerformance/getVisitorsData?analysisDate='+analysisDate+'&areaStr='+areaStr,
		type: "post",
		dataType:"json",
		success: function(result) {
		   var dataArray =[];
		   for (var i = 0; i < result.list.length; i++) {
		   	   var data =  result.list[i];
		   	   var acolor = getColorD(data.areaNo);
		   	   if(i==0){
		   	   		dataArray.push({name:data.areaName+"●${StoreNumber}："+data.areaStoreAmount+"<br/>●${CustomerNumber}："+data.areaVistorTotal,y:Number(data.areaVistorRatio),sliced: true,selected: true,color:acolor});
		   	   }else{
		   			dataArray.push({name:data.areaName+"●${StoreNumber}："+data.areaStoreAmount+"<br/>●${CustomerNumber}："+data.areaVistorTotal,y:Number(data.areaVistorRatio),color:acolor});
		   	   }
		   }
		   showVisitorsDataD(dataArray);
		}
	});

}
function getGrossMarginDataD(analysisDate,areaStr,categoryStr){
	var category =[];
	var categoryStrArray = categoryStr.split(",");
	for (var array = 0; array < categoryStrArray.length; array++) {
		category.push(categoryStrArray[array]);
	}
	$.ajax({
    	url: ctx + '/analysis/storesPerformance/getGrossMarginData?analysisDate='+analysisDate+'&areaStr='+areaStr,
		type: "post",
		dataType:"json",
		success: function(result) {
		   var netMaoriTotalArray=[];
		   var normalNetMaoriArray=[];
		   var promNetMaoriArray=[];
		   var dataArray =[];
		   var coateLength = category.length-3;
		   for (var i = 0; i < result.list.length; i++) {
		   	   var data =  result.list[i];
		   	   netMaoriTotalArray.push(Number(data.netMaoriTotal));
		   	   normalNetMaoriArray.push(Number(data.normalNetMaori));
		   	   promNetMaoriArray.push(Number(data.promNetMaori));
		   }
		   
		 dataArray.push(netMaoriTotalArray);
     	 dataArray.push(normalNetMaoriArray);
         dataArray.push(promNetMaoriArray);
          var plotBand=[];
          var fromNum = Number(-0.5);
          var areaStrArray = areaStr.split(",");
          var colorArray =[];
          for (var w = 0; w < areaStrArray.length; w++) {
          		colorArray.push(areaColors[(areaStrArray[w]-1)]);
          }
          for (var j = 0; j < colorArray.length; j++) {
   	   	   	  var toNum = Number(fromNum+1);
   	   	   	  plotBand.push({color:colorArray[j],from:fromNum,to:toNum});
   	   	   	  fromNum = Number(fromNum+1);
   	 	   }
		   showGrossMarginDataD(dataArray,category,plotBand);
		}
	});

}
function getCustPriceDataD(analysisDate,areaStr,categoryStr){
	var category =[];
	var sAreaNoArray=[]; 
	var categoryStrArray = categoryStr.split(",");
	var areaStrArray = areaStr.split(",");
	for (var array = 0; array < categoryStrArray.length; array++) {
		category.push(categoryStrArray[array]);
		sAreaNoArray.push(areaStrArray[array]);
	}
	$.ajax({
    	url: ctx + '/analysis/storesPerformance/getCustPriceData?analysisDate='+analysisDate+'&areaStr='+areaStr,
		type: "post",
		dataType:"json",
		success: function(result) {
		   var dataArray =[];
		   for (var j = 0; j < sAreaNoArray.length; j++) {
		   		 var colors = "";
		   		 var areaName = "";
		   	     var sAreaNo = sAreaNoArray[j];
		   	     var datadtailArray =[];
		   	     for (var i = 0; i < result.list.length; i++) {
		   			var data  = result.list[i];
		   			var areaNo = data.areaNo;
		   			if(areaNo == sAreaNo){
		   				areaName=category[j]+"${AverageBasket}";
		   				colors = getColorD(areaNo);
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
		   showCustPriceDataD(dataArray,category);
		}
	});
}


function getSalesDataD(analysisDate,areaStr,categoryStr){
	var AreaStr =[];
	var categoryStrArray = categoryStr.split(",");
	for (var array = 0; array < categoryStrArray.length; array++) {
		AreaStr.push(categoryStrArray[array]);
	}
	$.ajax({
    	url: ctx + '/analysis/storesPerformance/getSalesData?analysisDate='+analysisDate+'&areaStr='+areaStr,
		type: "post",
		dataType:"json",
		success: function(result) {
			var categories =[];
		    var dataArray =[];
		    var categoriesArray =AreaStr;
		    var areaNoramlRatioArray=[];
	   	    var areaPromRatioArray=[];
	   	    var noramlRatioArray;
	   	    var promRatioArry;
	   	     for (var i = 0; i < result.list.length; i++) {
	   	     	var data =  result.list[i];
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
	   	     				color = getColorD(areaNo);
	   	     				areaNoramlRatioArray[j] =areaNoramlRatio+"&"+color+"&"+areaStoreAmount+"&"+areaSalesTotal+"&"+areaNoramlSalesTotal+"&"+type;
	   	     			}
	   	     		}else{//促销
	   	     			if(cotegory==areaName){
	   	     				color = getColorD(areaNo);
	   	     				areaPromRatioArray[j] =areaPromRatio+"&"+color+"&"+areaStoreAmount+"&"+areaSalesTotal+"&"+areaPromSalesTotal+"&"+type;
	   	     			}
	   	     		}
	   	     		
	   	     	}
	   	     	
	   	     	
	   		 }
	   	   //categories = ['正常', '促销'],
	   	   categories.push("${Normal}<br/>●${TotalTurnover}："+result.list[0].saleTotal+"${QYuan}<br/>●${NormalTurnover}："+result.list[0].normalSalesTotel+"${QYuan}");
	   	   categories.push("${Promotion}<br/>●${TotalTurnover}："+result.list[0].saleTotal+"${QYuan}<br/>●${PromotionTurnover}："+result.list[0].promSalesTotal+"${QYuan}"); 
		   	dataArray.push({y:noramlRatioArray ,color: typeColors[1], drilldown: {name: '${Normal}',categories: categoriesArray,data: areaNoramlRatioArray}
		        }, {y:promRatioArry,color: typeColors[0],drilldown: {name: '${Promotion}',categories: categoriesArray,data: areaPromRatioArray}});		 
		  showSalesDataD(dataArray,categories);
		   
		}
	});
}


function getAreaStrD(){
	var AreaStr ="";
	$("input:checkbox[name='area']:checked").each(function(){
		AreaStr += $(this).val()+",";
	});
	return AreaStr.substring(0, AreaStr.length-1);
}

function getColorD(areaNo){
	var color="";
	color = areaColors[(areaNo-1)];
	return color;
}
</script>