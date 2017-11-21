<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

 <script src="${ctx}/shared/js/vis/vis.js"></script>
 <link href="${ctx}/shared/js/vis/vis.css" rel="stylesheet" type="text/css" />
    
   <style>
   #visualization {
      box-sizing: border-box;
      width: 100%;
      height: 500px;
    }
     .vis.timeline .item.green {
      background-color: #3F9673;
      border-color: #3F9673;
    }
    
     .vis.timeline .item.red {
      background-color: #F37864;
      border-color: #F37864;
    }
    
  .brit {
            border-right:1px dashed #ccc;
        }
        /*overwrite*/
        /*.fixed_div3 {
            margin-top: 1px;
        }*/
        .fl_left {
            margin-right:3px;
        }
        .lineToolbar {
            margin-top:2px;
        }
        .ztdb_tb {
            height:300px;
        }
        .CM-div .inner_half {
            border-left:1px dashed #ccc;height:85px;
        }
 
        /*frozen table*/
        .frozen_div {
            height: 320px;
            overflow: hidden;
            border-bottom: 1px solid #ccc;
        }
        #frozen_cols {
            height:100%;
            width:240px;
        }
        #move_cols {
            height:100%;/* equals #frozen_cols.height */
            width:100%;/*width:720px;*/
        }
        #f_cols_head, #m_cols_head {
            height: 30px;
            border-bottom: 1px solid #ccc;
        }
        #f_cols_body,#m_cols_body {
            height:250px;/* equals #frozen_cols.height - #f_cols_head.height(default value is 40px) */
            border-bottom:1px solid #ccc;
        }
  
  </style>


     <div class="CM" style="height:360px;margin-top:2px;">
                        <div class="CM-bar"><div>商品促销期数查询结果</div></div>
                        <div class="CM-div">
                            <div class="zt_db">
                                <div class="buy_sale_tit">
                                    <input type="checkbox" onclick="showProm()" id="showPromBuy" name="showPromBuy" checked="checked"/><span>&nbsp;显示进价促销</span>&nbsp;<span  class="buy_bg"></span>&nbsp;&nbsp;&nbsp;<input onclick="showProm()" type="checkbox" id="showPromSale" name="showPromSale" checked="checked" /><span>&nbsp;显示售价促销</span>&nbsp;<span class="sale_bg"></span>
                                    <span class="stb stb_on">
                                        <span class="stb22"></span>
                                    </span>
                                    <span class="stb">
                                        <span class="stb11"></span>
                                    </span>
      </div>
    <div class="frozen_div">
    
  
       <div id="visualization" ></div>
       
      
 
                                    <!--right parts that can scroll-->
      <div id="move_cols">
                                        <!--frozen top head parts when drag the y-scroll -->
                                        <div id="m_cols_head">
                                             <table cellpadding="0" cellspacing="0">
                                                  <tr>
                                                      <td><div style="width:90px;">店号 </div></td>
                                                      <td><div style="width:100px;">促销期数</div></td>
                                                      <td><div style="width:100px;">正常进价(元)</div></td>
                                                      <td><div style="width:100px;">促销进价(元))</div></td>
                                                      <td><div style="width:90px;">开始日</div></td>
                                                      <td><div style="width:90px;">结束日</div></td>
                                                      <td><div style="width:100px;">正常售价(元)</div></td>
                                                      <td><div style="width:100px;">促销售价(元)</div></td>
                                                      <td><div style="width:90px;">开始日</div></td>
                                                      <td><div style="width:90px;">结束日</div></td>
                      
                                                      <td><div style="width:90px;">&nbsp;</div></td><!--占位-->
                                                  </tr>
                                              </table>
                                        </div>
                                        <!--this parts can be scrolled all the time-->
                                        <div id="m_cols_body">
                                            <table cellpadding="0" id="tbColBody" cellspacing="0">
                                              
 
                                            </table>
                                        </div>
              </div>
      
   
    </div>
    <script type="text/javascript">
    Array.prototype.del=function(n){
    	if(n<0)
    	return this;
    	else
    	return this.slice(0,n).concat(this.slice(n+1,this.length));
    	};
    
    var groups = new vis.DataSet(eval('(${groups})'));
                               
    var items = new vis.DataSet({
                                  type: {start: 'ISODate', end: 'ISODate' }
                                });
    var items = new vis.DataSet(eval('(${items})'));

    var container = document.getElementById('visualization');
    var options = {
                                  min: '${beginDate}',              // 限制区间
                                  max: '${endDate}',
                                  zoomMin: 1000 * 60 * 60 * 24*12,  // 最小缩放为一天
                                  zoomMax: 1000 * 60 * 60 * 24*30,  // 最大缩放一个月  
                                  dataAttributes: ['tooltip','promType'],
                                  editable: {
                                    add: false,//去除添加
                                    remove: false//去除删除
                                  },
                                  clickToUse: false,
                                  groupOrder: function (a, b) {
                                    return a.value - b.value;
                                  }
                                  
      };

      var timeline = new vis.Timeline(container);
      timeline.setOptions(options);
      timeline.setGroups(groups);
      timeline.setItems(items);
      
      
      function showProm()
      {
      	var itemsArr=eval('(${items})');
      	var promBuy=true;
      	var promSale=true;
      	if($("#showPromBuy").attr("checked")=='checked')
      	{
      		promBuy=true;
      	}
      	else
      	{
      		promBuy=false;
      	}
      	if($("#showPromSale").attr("checked")=='checked')
      	{
      		promSale=true;
      	}
      	else
      	{
      		promSale=false;
      	}
      	if(!promBuy)
      	{
      		if(itemsArr)
      		{
      		 for(var i=0;i<itemsArr.length;i++)
  			 {
  				var itemJson=itemsArr[i];
  				if(itemJson.promType=='1')
  				{
  					itemsArr=itemsArr.del(i);
  					i=-1;
  				}
  			 }
      		}
      	}
      	if(!promSale)
      	{
      		if(itemsArr)
      		{
      		 for(var i=0;i<itemsArr.length;i++)
  			 {
  				var itemJson=itemsArr[i];
  				if(itemJson.promType=='2')
  				{
  					itemsArr=itemsArr.del(i);
  					i=-1;
  				}
  			 }
      		}
      	}
      	container.innerHTML="";
        var timeline = new vis.Timeline(container);
      	timeline.setOptions(options);
        timeline.setGroups(groups);
      	items = new vis.DataSet(itemsArr);
      	timeline.setItems(items);
      	
      	if(promBuy&&promSale)
      	{
      		 var htmlStr="";
             var promItemPeriodsArr=eval('(${promItemPeriodsArr})');
             $("#tbColBody").html("");
             for(var i=0;i<promItemPeriodsArr.length;i++)
             {
             	var promItemPeriods=promItemPeriodsArr[i];
             	htmlStr+="<tr>";
             	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' type='text' value='"+promItemPeriods.storeNo+"' class='inputText w93 ' /></div></td>";
                htmlStr+="<td><div style='width:100px;' >";
             	htmlStr+="    <input readonly='readonly' type='text' value='"+promItemPeriods.promNo+"' class='inputText w95 ' />";
             	htmlStr+="</div>";
             	htmlStr+="</td>";
                htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.normBuyPrice+"' type='text' class='inputText w95 ' /></div></td>";
             	htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.promBuyPrice+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.buyBeginDateStr+"' type='text' class='inputText w95' /></div></td>";
                htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.buyEndDateStr+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.normSellPrice+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.promSellPrice+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.promBeginDateStr+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.promEndDateStr+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="</tr>";
             }
             $("#tbColBody").html(htmlStr);
      	}
      	if(promBuy&&!promSale)
      	{
      		 var htmlStr="";
             var promItemPeriodsArr=eval('(${promItemPeriodsArr})');
             $("#tbColBody").html("");
             for(var i=0;i<promItemPeriodsArr.length;i++)
             {
            	
             	var promItemPeriods=promItemPeriodsArr[i];
             	if(promItemPeriods.pricePromType==null||promItemPeriods.pricePromType==2||promItemPeriods.pricePromType==1)
        		{
             	htmlStr+="<tr>";
             	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' type='text' value='"+promItemPeriods.storeNo+"' class='inputText w93 ' /></div></td>";
                htmlStr+="<td><div style='width:100px;' >";
             	htmlStr+="    <input type='text' readonly='readonly' value='"+promItemPeriods.promNo+"' class='inputText w95 ' />";
             	htmlStr+="</div>";
             	htmlStr+="</td>";
                htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.normBuyPrice+"' type='text' class='inputText w95 ' /></div></td>";
             	htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.promBuyPrice+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.buyBeginDateStr+"' type='text' class='inputText w95' /></div></td>";
                htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.buyEndDateStr+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.normSellPrice+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.promSellPrice+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.promBeginDateStr+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.promEndDateStr+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="</tr>";
            		}
             }
             $("#tbColBody").html(htmlStr);
      	}
      	
      	if(!promBuy&&promSale)
      	{
      		 var htmlStr="";
             var promItemPeriodsArr=eval('(${promItemPeriodsArr})');
             $("#tbColBody").html("");
             for(var i=0;i<promItemPeriodsArr.length;i++)
             {
            	
             	var promItemPeriods=promItemPeriodsArr[i];
             	if(promItemPeriods.pricePromType==3||promItemPeriods.pricePromType==1)
        		{
             	htmlStr+="<tr>";
             	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' type='text' value='"+promItemPeriods.storeNo+"' class='inputText w93 ' /></div></td>";
                htmlStr+="<td><div style='width:100px;' >";
             	htmlStr+="    <input type='text' readonly='readonly' value='"+promItemPeriods.promNo+"' class='inputText w95 ' />";
             	htmlStr+="</div>";
             	htmlStr+="</td>";
                htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.normBuyPrice+"' type='text' class='inputText w95 ' /></div></td>";
             	htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.promBuyPrice+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.buyBeginDateStr+"' type='text' class='inputText w95' /></div></td>";
                htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.buyEndDateStr+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.normSellPrice+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.promSellPrice+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.promBeginDateStr+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.promEndDateStr+"' type='text' class='inputText w95' /></div></td>";
             	htmlStr+="</tr>";
            		}
             }
             $("#tbColBody").html(htmlStr);
      	}
      	
      	if(!promBuy&&!promSale)
      	{
      		 $("#tbColBody").html("");
      	}
      }
        $(document).ready(function () {
            $(".m_body").css("width", $(".mbody_row").eq(0).find(".m_row").length * 620);
            var promItemPeriodsArr=eval('(${promItemPeriodsArr})');
            var htmlStr="";
            $("#tbColBody").html("");
            for(var i=0;i<promItemPeriodsArr.length;i++)
            {
            	var promItemPeriods=promItemPeriodsArr[i];
            	htmlStr+="<tr>";
            	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' type='text' value='"+promItemPeriods.storeNo+"' class='inputText w93 ' /></div></td>";
                htmlStr+="<td><div style='width:100px;' >";
            	htmlStr+="    <input readonly='readonly' type='text' value='"+promItemPeriods.promNo+"' class='inputText w95 ' />";
            	htmlStr+="</div>";
            	htmlStr+="</td>";
                htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.normBuyPrice+"' type='text' class='inputText w95 ' /></div></td>";
            	htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.promBuyPrice+"' type='text' class='inputText w95' /></div></td>";
            	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.buyBeginDateStr+"' type='text' class='inputText w95' /></div></td>";
                htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.buyEndDateStr+"' type='text' class='inputText w95' /></div></td>";
            	htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.normSellPrice+"' type='text' class='inputText w95' /></div></td>";
            	htmlStr+="<td><div style='width:100px;'><input readonly='readonly' value='"+promItemPeriods.promSellPrice+"' type='text' class='inputText w95' /></div></td>";
            	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.promBeginDateStr+"' type='text' class='inputText w95' /></div></td>";
            	htmlStr+="<td><div style='width:90px;'><input readonly='readonly' value='"+promItemPeriods.promEndDateStr+"' type='text' class='inputText w95' /></div></td>";
            	htmlStr+="</tr>";
            }
            $("#tbColBody").html(htmlStr);
            
        });
       
         
$(function(){
	 $(".stb11").unbind('click').bind('click',function(){
     	$(".stb22").parent().removeClass("stb_on");
     	$(this).parent().addClass("stb_on");
     	$("#visualization").hide();
     	$("#move_cols").show();
     });
      $(".stb22").unbind('click').bind('click',function(){
     	 $(".stb11").parent().removeClass("stb_on");
      	 $(this).parent().addClass("stb_on");
     	 $("#move_cols").hide();
     	$("#visualization").show();
     	
     });
	
});     
</script>