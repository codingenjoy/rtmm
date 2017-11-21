<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>

        <div class="Panel_top">
            <span>选择期数信息</span>
            <div class="PanelClose" id="closeTopic"  onclick="closeTopic()" style="margin-right:0;"></div>
        </div>
        <div class="Table_Panel" id="chooseItemSEtopicNoDiv">
            <div style="margin:15px auto 0px auto;width:97%;height:100%;">
                <div style="height:30px;background:#CCC;">
                    <div class="Icon-div">
                        <input type="text" class="IS_input" id="selectSereisTopicNo" placeholder="请输入期数编号或者期数名称（名称支持模糊查询）"/>
                        <div class="cbankIcon" id="selectSeriesItem"></div>
                    </div>
                </div>
                <div class="search_tb_p">
                    <table id="update_items" style="height:400px;"></table>
                    
                    
                    
                </div>
            </div>
        </div>
      
    <script type="text/javascript">

    	var searchSeId="";
    	var searchTopicUrl="";
		 var searchTopicName="";
    	
    function loadItemTopicList(){
    
        $('#update_items').datagrid({
            rownumbers: false,
            singleSelect: true,
            pagination: true,
            pageSize: 20,
            striped: true,//奇偶行使用不同背景色  
            queryParams : {
            	seId:searchSeId,
            	topicName:searchTopicName            	
        		},
			url :searchTopicUrl,
            columns: [[
            {	field : 'seId',title : 'SE期数',sortable: true, align: 'right', halign: 'center', width: 120 },
            {	field : 'topicName',title : 'SE主题',sortable: true, halign: 'center', width: 350 }
            ]],             
            onLoadSuccess: function (data) { 
            		               	
            },                
          onDblClickRow: function (rowIndex, rowData) {        	  
        	   	          	  
        	  //传出数值信息
        	  confirmChooseTopic(rowData);        	  
        	  //关闭窗口
        	  closePopupWin(); 
          }
        });
        
        
    }

    function closeTopic(){
    	closePopupWin(); 
        }
        
        $(function(){
        	//加载查询信息
        	loadItemTopicList();
             //查询事件
            $("#selectSeriesItem").bind('click').click(function(){
            	searchTopicName="";
            	searchSeId="";
            	searchTopicUrl ="<c:url value='/itemQueryManagement/readSeTopicSettingBypage'/>?tt="+new Date().getTime();
            	var mySeriesItem=$.trim($("#selectSereisTopicNo").val());
        	
            	if(isNumber(mySeriesItem)){
            		searchSeId=mySeriesItem;
            	}else{
            		searchTopicName=mySeriesItem;
            	}	
            	loadItemTopicList();
          	
            });
             
             //获取焦点事件
            $("#selectSereisTopicNo").focus(function(){
            	$("#selectSereisTopicNo").removeClass().addClass("IS_input");
        		$("#selectSereisTopicNo").attr("title","请输入期数编号或者期数名称（名称支持模糊查询）");    	
            });
            
        });
        
        
        
      //验证信息，必须输入数字
    	function isNumber(str) {
    		var result = str.match(/^[0-9]{0,10}$/);
    		if (result == null)
    			return false;
    		return true;
    	}


	    //回车事件绑定
    	   $("#chooseItemSEtopicNoDiv").unbind("keypress").keypress(function(event){		
    	  	if(event!== null && event.keyCode == 13){
   	    	 $("#selectSeriesItem").click();
    	  		} 
    	  }); 
    
    </script>
