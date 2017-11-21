<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<%@ include file="/page/commons/toolbar.jsp"%>
<style type="text/css">
.datagrid-body {
margin: 0;
padding: 0;
overflow-x: auto;
overflow-y: scroll;
zoom: 1;
}
</style>
 <script type="text/javascript">

        //查询按钮
		$('#Tools1').attr('class', 'Icon-size1 Tools1 B-id').bind('click',
				function() {
					DispOrHid('B-id');
					gridbar_B();
				});

		
	
		//加载jqyeryeasyui页面信息
		var itemNo ="0";
		var itemName="";
		var supNo="";
		var storeNo="";
		//翻页信息
		function pageQuery() {
			readItemSupplierInfos($("#pageNo").val(), $("#pageSize").val());
		}
		

		//商品列表
		function readItemSupplierInfos(pageNo, pageSize) {
			$.ajax({
				url : "<c:url value='itemQueryManagement/readItemSupStoreByPage'/>",
				type : "post",
				dataType : "html",
				data : {
					itemNo:itemNo,
					itemName:itemName,
					supNo:supNo,
					storeNo:storeNo,
					pageNo : pageNo,
					pageSize : pageSize
				},
				success : function(data) {
					$("#itemSupplierInfoList").html(data);
				},
				error : function(XMLHttpRequest, textStatus,
						errorThrown) {
					//这里是ajax错误信息  
				}
			});
		}
				
		
//验证信息，必须输入数字
function isNumber(str){
   var result = str.match(/^[0-9]{0,10}$/); 
       if (result == null) 
           return false; 
       return true; 
}   	


//查询事件
 $("#seriesSearch").click(function(){
	   var errorCount=0;
		  if(!isNumber($.trim($("#searchItemNo").val()))){
			  $("#searchItemNo").addClass("errorInput");
			  $("#searchItemNo").attr("title","请输入合理的货号");
			  errorCount++;
			  }
		     if(!isNumber($.trim($("#searchSupNo").val()))){
			  $("#searchSupNo").addClass("errorInput");
			  $("#searchSupNo").attr("title","请输入合理的厂编");			  
			  errorCount++;
			  }
		     if(!isNumber($.trim($("#searchStoreNo").val()))){
				  $("#searchStoreNo").addClass("errorInput");
				  $("#searchStoreNo").attr("title","请输入合理的店号");			  
				  errorCount++;
				  }
             if($.trim($("#searchItemNo").val())!="" ||  $.trim($("#searchSupNo").val())!="" ||
                $.trim($("#searchItemName").val())!=""){
            	 if(errorCount==0){             	 
            		 itemNo =$.trim($("#searchItemNo").val());
            		 itemName=$.trim($("#searchItemName").val());
            		 supNo=$.trim($("#searchSupNo").val());
            		 storeNo=$.trim($("#searchStoreNo").val());	
                  //查询信息
            		 readItemSupplierInfos(1,20);

            		}	
                 }else{
                	 top.jAlert('warning', '请输入货号或者品名或者厂编！', '提示消息');
                    }			  	 
	 });

   

          //设置获取焦点事件
   $("[name=inputNumber]").focus(function(){
	   $(this).removeClass("errorInput");

	   });

   $("#clearSearch").unbind("click").bind("click",function(){

    $("#searchSupplierInfos :input").val("");
    $("#searchSupplierInfos :input").removeClass("errorInput");
	   });



   //回车事件绑定
   $("#searchSupplierInfos").unbind("keypress").keypress(function(event){		
  	if(event!== null && event.keyCode == 13){
  		$("#seriesSearch").focus();
  		 $("#seriesSearch").click();
  		} 
  }); 



   //跳转到商品厂商查询按门店查询
   $("#itemSeSetting").unbind().click(function(){
	   showContent('<c:url value='/itemQueryManagement/supSearch'/>');
	   });
	</script>

  

<div class="CTitle">
  	<!--第一个-->
	<div class="tags1_left"></div>
	<div class="tagsM" id="itemSeSetting">商品厂商</div>
	<div class="tags tags_right_on"></div>
	<!--最后一个-->
	<div class="tagsM  tagsM_on" >商品查询（按店）</div>
	<div class="tags tags3_r_on"></div>
</div>
   

 <div class="Container-1">
                <div class="Search Bar_on" id="searchSupplierInfos"><!-- Bar_on-->
                    <div class="SearchTop">
                        <span>查询条件</span>
                        <div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
                    </div>
                    <div class="line"></div>
                    <div class="SMiddle">
                       <table class="SearchTable">
                          <tr>
            <td class="ST_td1"><span>店号</span></td>
            <td>
            	<select id="searchStoreNo" name="inputNumber"  class="w80" >
	         		<option value="">请选择</option>
					<c:forEach items="${stores}" var="store">
						<option value="${store.storeNo}" title="${store.storeNo}-${store.storeName}">${store.storeNo}-${store.storeName}</option>
					</c:forEach>
				</select>
            </td>
        </tr>
				<tr>
					<td><span>货号</span></td>
					<td><input type="text" class="inputText w80"  name="inputNumber" id="searchItemNo" maxlength="15"/></td>
				</tr>
				<tr>
					<td><span>品名</span></td>
					<td><input type="text" class="inputText w80" id="searchItemName"/></td>
				</tr>
				<tr>
					<td><span>厂编</span></td>
					<td><input type="text" class="inputText w80" name="inputNumber" id="searchSupNo" maxlength="15"/></td>
				</tr>			
				<!-- <tr>
					<td><span>正常进价</span></td>
					<td><input type="text" class="inputText w80" /></td>
				</tr>
				<tr>
					<td><span>主厂商</span></td>
					<td><select class="w60" disabled="disabled"
						style="color: #f00;"><option>保洁</option></select></td>
				</tr> -->
			</table>
                    </div>
                    <div class="line"></div>
                    <div class="SearchFooter">
                        <div class="Icon-size1 Tools20" id="clearSearch"></div>
                        <div class="Icon-size1 Tools6" id="seriesSearch"></div>
                    </div>
                </div>
              	<div class="Content" style="width: 74%" id="itemSupplierInfoList">
		           <!--  <table id="itemSupList" style="height: 570px" ></table> -->
	            </div>
               </div>
