<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>

        <div class="Panel_top">
            <span>选择需要增加的商品</span>
            <div class="PanelClose" id="closeSeriesItemWindow" style="margin-right:0;"></div>
        </div>
        <div class="Table_Panel" id="chooseSeriesDiv">
            <div style="margin:15px auto 0px auto;width:97%;height:100%;">
                <div style="height:30px;background:#CCC;">
                    <div class="Icon-div">
                        <input type="text" class="IS_input" id="searchSeriesInput" title="输入货号或品名查询(支持模糊查询)" placeholder="输入货号或品名查询(支持模糊查询)"/>
                        <div class="cbankIcon" id="searchSeriesItemNo"></div>
                    </div>
                </div>
                <div class="search_tb_p" id="item_update_div">
                    <table id="update_items" style="height:350px;"></table>
                    
                      <div class="Panel_footer">
            <div class="PanelBtn">
                <div class="PanelBtn1" onclick="saveSearchSeries()">保存</div>
                <div class="PanelBtn2" id="closeSeriesItemWin">取消</div>
            </div>
        </div>
                    
                </div>
            </div>
        </div>
      
    <script type="text/javascript">
       var  searchItemNo="";
       var chooseItems = new Array(); //基础的集合信息（修改后），只有点击确定后，该信息才生效
       var chooseDeleteItem=new Array(); //当点击反选时，移除信息 
       var searchItemName ="";//商品名称   
       var searchUrl="";          
       function readSeriesItemList(){
        $('#update_items').datagrid({
            rownumbers: false,
            //singleSelect: false,
            pagination: true,
            pageSize: 20,
            striped: true,//奇偶行使用不同背景色 
            queryParams : {
            itemNo:searchItemNo,
            catlgNo:$("[name=catlgId]").val(), //从其他页面获取课别信息
            itemName:searchItemName ,//商品名称  
            clstrType:$("#searchClstrType").val(),
            itemStatus:8          
    		},
            url : searchUrl ,
            columns: [[
            { field: 'ck', checkbox: true},
            { field: 'itemNo', title: '货号', sortable: true, align: 'right', halign: 'center', width: 120},
            { field: 'itemName', title: '商品名称', sortable: true, halign: 'center', width: 250 },
            { field: 'status', title: '状态', halign: 'center', width: 200 ,formatter : function(val, rec) {
				return getDictValue('ITEM_STORE_INFO_STATUS',rec.status);
			}}
            ]],
             onLoadSuccess: function (data) {            	
            	 //判断选中信息，如果选中，则显示
            	  for(var i in data.rows){
            		  if(containsItemByItemNo(items,data.rows[i].itemNo)){
            			  $('#update_items').datagrid("selectRow", i);
            		  } 
                 //记录本次操作的信息
                    if(containsItemByItemNo(chooseItems,data.rows[i].itemNo)){
            			  $('#update_items').datagrid("selectRow", i);
            		  }          		                           		   	             		
             	 //如果是代表商品，选中
            	  if($("#addRefItemNo").val()==data.rows[i].itemNo){
          			  $('#update_items').datagrid("selectRow", i);
            		  }
            	 }            	                        	           	 
          },         
            onSelect: function (rowIndex, rowData) {//选中事件
                //添加一个信息栏
            if(!containsItemByItemNo(chooseItems,rowData.itemNo)){
                chooseItems.push(rowData);//添加商品成功后，该商品在保存前不允许再次添加
            }
            removeElementForArray(chooseDeleteItem,rowData.itemNo);
          },
          
          onUnselect: function (rowIndex, rowData) {
        	    if($("#addRefItemNo").val()==rowData.itemNo){
      			  $('#update_items').datagrid("selectRow", rowIndex);
        	    	top.jAlert("warning","代表商品不允许取消","提示信息");
        			return ;
        		  }  
        	  //alert("反选");
        	  removeElementForArray(chooseItems,rowData);
        	  //反选时，加入移除列表
        	  chooseDeleteItem.push(rowData.itemNo);
          },
          onSelectAll: function (rows) {       	
        	  for(var i = 0;i < rows.length;i++){
        		//添加商品成功后，该商品在保存前不允许再次添加
        		  if(!containsItemByItemNo(chooseItems,rows[i].itemNo)){
        		  chooseItems.push(rows[i]);
        		  }
          		  removeElementForArray(chooseDeleteItem,rows[i].itemNo); 		  
            	  } 	  
          },onUnselectAll:function(rows){
        	  for(var i=0;i<rows.length;i++){
            	  //代表商品信息
        		  if($("#addRefItemNo").val()==rows[i].itemNo){
          			  $('#update_items').datagrid("selectRow", i);          			  
            		  }
        		  removeElementForArray(chooseItems,rows[i]); //添加商品成功后，该商品在保存前不允许再次添加          	  
        		  if(containsItemByItemNo(items,rows[i].itemNo)){
                  	//在原生集合中存在，加入删除列表
                  	chooseDeleteItem.push(rows[i].itemNo);
                    } 
        	  } 
              },onBeforeLoad:function(row, param){
              //加载前去掉checkbox选中
        	  $("#item_update_div :checkbox").attr("checked",false);          	              
              }
        });
        
       }
       
   	 //加载完毕后允许关闭
 	  $("#closeSeriesItemWindow").unbind("click").click(function(){        		  
   		//关闭弹出层
   			closePopupWin();        		  
   	  });
 	 
 	 $("#closeSeriesItemWin").unbind("click").click(function(){          		 
 		//关闭弹出层
			closePopupWin();     		 
 	 });             
        
        //保存事件
        function saveSearchSeries(){
            //点击确定，商品保存生效
            for(var i in chooseItems){
                 if(!containsItemByItemNo(items,chooseItems[i].itemNo)){
                       items.push(chooseItems[i]);
                     }
                }          
        	//移除反选的信息
            for(var item in chooseDeleteItem){
            	removeItemByItemNo(items,chooseDeleteItem[item]);
                }                   	
        	//加载列表信息（该函数来自于页面content_Item_Series Items_same price_View.jsp）
        	readAllSearchItems();
        	//关闭窗口
        	closePopupWin();     
        }
        
     
        $(function(){
            //清空数据
            chooseItems = [];
        	//加载商品列表信息
        	readSeriesItemList();
        	
        	$("#searchSeriesItemNo").click(function(){
        		searchItemNo="";
        		searchItemName="";
        		searchUrl="<c:url value='/series/readRefItemList'/>";
        		var searchSeriesInput=$.trim($("#searchSeriesInput").val());
        		if(searchSeriesInput==""){
        			top.jAlert('warning', '请输入查询信息', '提示消息');
            		return;
            		}
        		if(isNumber(searchSeriesInput)){
        			searchItemNo=searchSeriesInput;
        			readSeriesItemList();
        		}else{
        			searchItemName=searchSeriesInput;
        			readSeriesItemList();
        		}
        	});
        	
        	$("#searchSeriesInput").bind("focus",function(){
        		$("#searchSeriesInput").removeClass().addClass("IS_input");
        		$("#searchSeriesInput").attr("title","输入货号或品名查询(支持模糊查询)");
        		
        	});
        	
        });
          	  
  	    //回车事件绑定
   $("#chooseSeriesDiv").unbind("keypress").keypress(function(event){		
  	if(event!== null && event.keyCode == 13){
   	 $("#searchSeriesItemNo").click();
  		} 
  }); 

   /**
    * 检测商品中是不是存在此货号
    * @param array 数组
    * @param itemNo  货号
    */  
    function containsItemByItemNo(array,itemNo){
        var containsCount=0;
    	if(typeof(array) != "undefined" && array.length > 0 ){
            for(var i in array){
                if(array[i].itemNo == itemNo){
                	containsCount++;
                }
          }
            if(containsCount > 0){
               return true;
                }else{
               return false;
                    }
        }
   }

    /**
     * 移除商品列表（数组）中的货号
     * @param array 数组
     * @param itemNo  货号
     */  
   function removeItemByItemNo(array,itemNo){
	   if(typeof(array) != "undefined" && array.length > 0 ){
           for(var i in array){
               if(array[i].itemNo == itemNo){
            	 //移除
       			array.splice(i, 1);               
               }
         }      
       }
	   } 


     
	 
    </script>
