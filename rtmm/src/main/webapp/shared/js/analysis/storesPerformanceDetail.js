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
                text: '地区'                                                 
            }                                                              
        },                                                                 
        yAxis: {                                                           
            min:0,
            showEmpty: false,                                                      
            title:{                                                       
    			text: '客单价 (元)',                             
    			align: 'high'         
    		 }, 
    		 labels: {                                                      
  				overflow: 'justify'                                        
           	 }                                                              
        },                                                                 
        tooltip: {                                                         
            valueSuffix: '元'                                       
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
        yAxis: {
            title:{
               	align: 'high',
                offset: 0,
                text: '百分比 (%)',
                rotation: 0
            }
        },
        credits: {
            enabled: false
        },
        series: [{name: '总毛利率',data: data[0],color:coatColors[0]}, 
                 {name: '正常毛利率',data: data[1],color:coatColors[1]}, 
                 {name: '促销毛利率',data: data[2],color:coatColors[2]}
               ]
           /* chart: {
                type: 'column'
            },
            title: {
                style: { "display": "none" }
            },
            credits: {
                enabled: false
            },
            colors: ['#B4DECD', '#1D8281', '#DB634F', '#FF9999', '#FBD258', '#F29A3F', '#44BF87'],
            xAxis: {
                categories: category,
                labels: { enabled: true }
            },
            yAxis: {
                labels: {
                    enabled: true
                },
                title: {
                    style: { "display": "none" }
                }
            },
            legend: {
                 enabled:  true
            },
            plotOptions: {
                column: {
                    dataLabels: {
                        enabled: true
                    }
                },
                series: {
                    cursor: 'pointer'
                }
            },
            series: [{name: '总毛利率',data: data[0]}, 
                     {name: '正常毛利率',data: data[1]}, 
                     {name: '促销毛利率',data: data[2]}
                    ]*/
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
 	            pointFormat: '{series.name}：{point.percentage:.1f}%'
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
                 name: '占总数',
                 data: data
             }]
     });
    }
    
    function showSalesDataD(data){
    	categories = ['正常', '促销'],
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
              var typeStr = "促销销售额";
            if(VData[5]=="0"){
                typeStr = "正常销售额";
            }
            versionsData.push({
                name: data[i].drilldown.categories[j]+"<br/>●分店数量："+VData[2]+"<br/>●总销售额："+VData[3]+"千元<br/>●"+typeStr+"："+VData[4]+"千元",
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
       // colors: ['#B4DECD', '#1D8281', '#DB634F', '#FF9999', '#FBD258', '#F29A3F', '#44BF87'],
        
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
            name: '促销类型所占比例',
            data: browserData,
            size: '60%',
            dataLabels: {
                formatter: function () {
                    return this.y > 5 ? this.point.name : null;
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
		   	   		dataArray.push({name:data.areaName+"●分店数量："+data.areaStoreAmount+"<br/>●总来客数："+data.areaVistorTotal,y:Number(data.areaVistorRatio),sliced: true,selected: true,color:acolor});
		   	   }else{
		   			dataArray.push({name:data.areaName+"●分店数量："+data.areaStoreAmount+"<br/>●总来客数："+data.areaVistorTotal,y:Number(data.areaVistorRatio),color:acolor});
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
		  /* for (var j = 0; j < result.list.length; j++) {
		   	    var netMariArray =[Number(netMaoriTotalArray[j]),Number(normalNetMaoriArray[j]),Number(promNetMaoriArray[j])];
		   	    dataArray.push(netMariArray);
		   }*/
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
		   				areaName=category[j]+"客单价";
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
	   	   categories.push("正常<br/>●销售总额："+result.list[0].saleTotal+"<br/>●正常销售总额："+result.list[0].normalSalesTotel);
	   	   categories.push("促销<br/>●销售总额："+result.list[0].saleTotal+"<br/>●促销销售总额："+result.list[0].promSalesTotal); 
		   	dataArray.push({y:noramlRatioArray ,color: typeColors[1], drilldown: {name: '正常',categories: categoriesArray,data: areaNoramlRatioArray}
		        }, {y:promRatioArry,color: typeColors[0],drilldown: {name: '促销',categories: categoriesArray,data: areaPromRatioArray}});		 
		  showSalesDataD(dataArray,categories);
		   
		}
	});
}

/*function getVisitorsDataD(analysisDate,areaStr){
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
		   	   		dataArray.push({name:data.areaName,y:Number(data.areaVistorRatio),sliced: true,selected: true,color:acolor});
		   	   }else{
		   			dataArray.push({name:data.areaName,y:Number(data.areaVistorRatio),color:acolor});
		   	   }
		   }
		   showVisitorsDataD(dataArray);
		}
	});

}
function getGrossMarginDataD(analysisDate,areaStr){
	$.ajax({
    	url: ctx + '/analysis/storesPerformance/getGrossMarginData?analysisDate='+analysisDate+'&areaStr='+areaStr,
		type: "post",
		dataType:"json",
		success: function(result) {
		   var netMaoriTotalArray=[];
		   var normalNetMaoriArray=[];
		   var promNetMaoriArray=[];
		    var dataArray =[];
		   
		  
		   for (var i = 0; i < result.list.length; i++) {
		   	   var data =  result.list[i];
		   	   netMaoriTotalArray.push(data.netMaoriTotal);
		   	   normalNetMaoriArray.push(data.normalNetMaori);
		   	   promNetMaoriArray.push(data.promNetMaori);
		   }
		   for (var j = 0; j < result.list.length; j++) {
		   	    var netMariArray =[Number(netMaoriTotalArray[j]),Number(normalNetMaoriArray[j]),Number(promNetMaoriArray[j])];
		   	    dataArray.push(netMariArray);
		   }
		    var category = ['华东', '华北', '华南'];
		   showGrossMarginDataD(dataArray,category);
		}
	});

}
function getCustPriceDataD(analysisDate,areaStr){
	$.ajax({
    	url: ctx + '/analysis/storesPerformance/getCustPriceData?analysisDate='+analysisDate+'&areaStr='+areaStr,
		type: "post",
		dataType:"json",
		success: function(result) {
		   var dataArray =[];
		   var sAreaNoArray = ['2', '4', '0','5'];
		   var category =['华东', '华南', '华北','西南'];
		   for (var j = 0; j < category.length; j++) {
		   	 	 var colors = "";
		   		 var areaName = "";
		   	     var sAreaNo = sAreaNoArray[j];
		   	     var datadtailArray =[];
		   	     for (var i = 0; i < result.list.length; i++) {
		   	     	var data  = result.list[i];
		   			var areaNo = data.areaNo;
		   			if(areaNo == sAreaNo){
		   				areaName=data.areaNo;
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


function getSalesDataD(analysisDate,areaStr){
	//areaColors= ['#B4DECD', '#1D8281', '#DB634F', '#FF9999', '#FBD258', '#F29A3F', '#44BF87'];
	$.ajax({
    	url: ctx + '/analysis/storesPerformance/getSalesData?analysisDate='+analysisDate+'&areaStr='+areaStr,
		type: "post",
		dataType:"json",
		success: function(result) {
		   var dataArray =[];
		    var categoriesArray =['华南', '华东'];
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
	   	     	noramlRatioArray = Number(data.normalRatio);
	   	     	promRatioArry = Number(data.promRatio);
	   	     	for (var j = 0; j < categoriesArray.length; j++) {
	   	     		var cotegory = categoriesArray[j];
	   	     		if(type=="0"){//正常
	   	     			if(cotegory==areaName){
	   	     				color = getColorD(areaNo);
	   	     				areaNoramlRatioArray[j] =areaNoramlRatio+"&"+color;
	   	     			}
	   	     		}else{//促销
	   	     			if(cotegory==areaName){
	   	     				color = getColorD(areaNo);
	   	     				areaPromRatioArray[j] =areaPromRatio+"&"+color;
	   	     			}
	   	     		}
	   	     		
	   	     	}
	   	     	
	   	     	
	   		 }
		   	dataArray.push({y:noramlRatioArray ,color: typeColors[1], drilldown: {name: '正常',categories: categoriesArray,data: areaNoramlRatioArray}
		        }, {y:promRatioArry,color: typeColors[0],drilldown: {name: '促销',categories: categoriesArray,data: areaPromRatioArray}});		 	 
		    showSalesDataD(dataArray);
		   
		}
	});
}
$(".highcharts-background").live("click",function(){alert("sdfad");})*/
/*function checkDataD(analysisDate,areas){
	var flag = true;
	if(analysisDate ==null || analysisDate ==""){
		top.jAlert('warning', '请选择业绩日期！', '提示消息');
		flag =false;
		return;
	}
	
	if(areas ==null && areas.length < 1){
		top.jAlert('warning', '请选择要查询的区域！', '提示消息');
		flag =false;
		return;
	}
	return flag;
}*/
function getAreaStrD(){
	var AreaStr ="";
	$("input:checkbox[name='area']:checked").each(function(){
		AreaStr += $(this).val()+",";
	});
	return AreaStr.substring(0, AreaStr.length-1);
}

function getColorD(areaNo){
	var color="";
	//$("input:checkbox[name='area']").each(function(i){
		//alert(areaNo+"*****"+$(this).val());
		 //if($(this).val()==areaNo){
		 	//color = areaColors[i];
		// }
	//});
	color = areaColors[(areaNo-1)];
	return color;
}



