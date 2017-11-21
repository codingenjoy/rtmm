<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<%@ include file="/page/commons/toolbar.jsp"%>
 <script type="text/javascript">
 
 // 让bar中的某个菜单可用(新增)
    $('#Tools11').removeClass('Tools11_disable').addClass('Tools11').bind('click',function() {
		//alert('d');	
		showContent('/series/seriesAdd');
	});
          
 
 
 
        //查询按钮
		$('#Tools1').attr('class', 'Icon-size1 Tools1 B-id').bind('click',
				function() {
					DispOrHid('B-id');
					gridbar_B();
				});

		$(function() {
			seriesList();
			//默认关闭查询窗口
			DispOrHid('C-id');

			$("#seriesPro").click(function() {

				if ($("#seriesPro").attr("checked") == "checked") {
					alert($("#seriesPro").attr("checked"));

				}
			});
			
			
			//为层注册一个click事件
			$("#seriesSearch").click(function(){
				seriesList();
				
			});
			

			//为系列类型添加弹出层事件
			$("#searchCatlgId").unbind("click focus").bind("click focus",function() {
				//打开弹出层
				openPopupWin(600, 500, '/commons/window/chooseSection');
			});		
			//为商品列表加入弹出层事件
			$("#searchRefItemNo").unbind("click focus").bind("click focus",function() {
				//打开弹出层
				openPopupWin(600, 500, '/series/toSearchRefItemList');
			});
			
		});
		
		//根据弹出层回调结果信息  
		function confirmChooseSection(id, name) {
			$('#searchCatlgId').attr('value', id);
			//关闭弹出层
			closePopupWin();
		}
		
		//根据弹出层回调结果信息
		function confirmChooseSeries(rowData){
			$("#searchRefItemNo").val(rowData.itemNo);
			//关闭弹出层
			closePopupWin();
		}
		
		//加载jqyeryeasyui页面信息
		
		var searchClstrId ="";//系列编号	
		var searchClstrName="";//系列编号
		var searchCatlgId="";//课别
		var searchRefItemNo="";//商品货号
		var searchClstrType="";//系列类型

//我的草稿箱-厂商管理列表
function seriesList() {
      
	 searchClstrId =$.trim($("#searchClstrId").val());//系列编号	
	 searchClstrName=$.trim($("#searchClstrName").val());//系列编号
	 searchCatlgId=$.trim($("#searchCatlgId").val());//课别
	 searchRefItemNo=$.trim($("#searchRefItemNo").val());//商品货号
	 searchClstrType=$.trim($("#searchClstrType").val());//系列类型
		
	 //正则表达式
		if(isNumber(searchClstrId)){						
		//执行查询
		readSeriesList();			
		}else{
			top.jAlert('warning', '请注意查询条件','提示消息');
		}
			
}

		
		
//加载查询信息		
function readSeriesList(){	
	$("#seriesList").datagrid( {
		rownumbers : false,
		singleSelect : true,
		pagination : true,
		pageSize : 20,
		striped: true,//奇偶行使用不同背景色  
		url :  "<c:url value='/series/readSeriesByPage'/>",
		queryParams : {
			clstrId:searchClstrId,
			clstrName:searchClstrName,
			catlgId:searchCatlgId,
			refItemNo:searchRefItemNo,
			clstrType:searchClstrType
		},
		columns : [ [ {
			field : 'clstrId',
			title : '系列编号',
			width : 120,
			sortable : true,
			halign : 'center',
			align : 'center'
		}, {
			field : 'clstrName',
			title : '系列名称',
			width : 200,
			sortable : true,
			halign : 'center'
		}, {
			field : 'catlgId',
			title : '课别',
			width : 150,
			halign : 'center'
		}, {
			field : 'refItemNo',
			title : '代表商品货号',
			width : 150,
			halign : 'center'
		}, {
			field : 'refItemName',
			title : '代表商品品名',
			halign : 'center'
	
			
		},{
			field : 'clstrType',
			title : '系列类型',
			halign : 'center',
				formatter : function(val, rec) {
					return getDictValue('ITEM_CLUSTER_CLSTR_TYPE',rec.clstrType);
				},
			
	
		}
		,{
			field : 'batchPriceChngInd',
			title : '商品同价',
			halign : 'center',
			formatter : function(val, rec) {
				return getDictValue('ITEM_CLUSTER_BATCH_PRICE_CHNG_IND',rec.batchPriceChngInd);
			},
		}			
		] ],
		onLoadSuccess: function (data) {
			//加载数据完成，
			// 让bar中的某个菜单不可用（修改）并且移除单击事件
		    $('#Tools12').removeClass('Tools12').addClass('Tools12_disable').unbind("click");
		},
		onClickRow : function(rowIndex, rowData) {
			// 让bar中的某个菜单可用（修改）
		    $('#Tools12').removeClass('Tools12_disable').addClass('Tools12').unbind("click").bind('click',function() {
				//alert('d');	
				showContent('/series/toUpdateSeries?clstrId='+rowData.clstrId);
			});
		}
		,error: function(XMLHttpRequest, textStatus, errorThrown) { 
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
		
		
//选择弹出框，点确定后，需执行固定方法完成自己想要的结果(页面调用通用方法)	
function confirmAlert(msg, width, height, title) {
    var $body = $("body");
    $body.append('<div id="alert_layer"></div>');
    var $layer = $("#alert_layer");
    var w = $(document).width();
    var h = $(document).height();
    $layer.css({ "width": w, "height": h, "display": "block" });

    $body.append('<div id=\"confirmAlert\" class=\"Panel\"><div class=\"alert_top\"><span id=\"alert_confirm_title\" class=\"alert_title\">confirm提示！</span><div id=\"alert_close\" class=\"PanelClose\"></div></div><div class=\"Table_Panel\" id=\"alert_confirm_body\"><div class=\"alert_body\"><div class=\"alert_b1 alert_comfirm \"></div><div id=\"alert_confirm_text\" class=\"alert_text\">这是一个confirm提示框！</div></div></div><div class=\"Panel_footer\"><div class=\"PanelBtn\"><div class=\"PanelBtn1\">确定</div><div class=\"cancel\">取消</div></div></div></div>');
    if (height != '' && height != undefined) {
        $("#alert_confirm_body").css("height", height);
    } else {
        height = 60;
    }
    if (width != '' && width != undefined) {
        $("#confirmAlert").css({ "width": width + 'px' });
    } else {
        width = 500;
    }
    if (msg != '' && msg != undefined) {
        $("#alert_confirm_text").html(msg);
    }
    if (title != '' && title != undefined) {
        $("#alert_confirm_title").html(title);
    }
    var win_x = ($(window).width() - width) / 2;//随着浏览器的变化而变化，而且不计算滚动条
    var win_y = ($(window).height() - (Number(height) + 60)) / 2 + $(window).scrollTop();
    $("#confirmAlert").css({ "display": "block", "z-index": "10000", "position": "absolute", "top": win_y + 'px', "left": win_x + 'px' });
    
    $(".PanelBtn1").unbind("click").bind("click", function () {
		//需要指定方法 特定函数，需指定
		   executeFuction();
		  $(this).parents(".Panel").remove();
	        $("#alert_layer").remove();
		
    });
    $(".cancel,#alert_close,.btn1").unbind("click").bind("click", function () {
        $(this).parents(".Panel").remove();
        $("#alert_layer").remove();
 
    });

}	
		
		
		
	</script>

   



<div class="CTitle">
  	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on" style="">
     系列商品管理
	</div>
    <div class="tags tags3_r_on"></div>
</div>
   

 <div class="Container-1">
                <div class="Search Bar_on" ><!-- Bar_on-->
                    <div class="SearchTop">
                        <span>查询条件</span>
                        <div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
                    </div>
                    <div class="line"></div>
                    <div class="SMiddle">
                        <table class="SearchTable">
                            <tr>
                                <td class="ST_td1"><span>系列编号</span></td>
                                <td>
                                <input id="searchClstrId"  class="w80 inputText" type="text" />
                                </td>
                            </tr>
                            <tr>
                                <td><span>系列名称</span></td>
                                <td><input id="searchClstrName"  class="w80 inputText" type="text" /></td>
                            </tr>
                            <tr>
                                <td><span>课别</span></td>
                                <td>
                                  <input  id="searchCatlgId" class="w80 inputText" />
                                </td>
                            </tr>
                            <tr>
                                <td><span>代表商品货号</span></td>
                                <td>
                                <input id="searchRefItemNo" class="w80 inputText" />
                                </td>
                            </tr>                          
                            <tr>
                                <td><span>系列类型</span></td>
                                <td>
                               <auchan:select id="searchClstrType" mdgroup="ITEM_CLUSTER_CLSTR_TYPE" _class="w80" />
                                
                                </td>
                            </tr>                         
                            <tr>
                                <td><span>商品同价</span></td>
                                <td>
                            <auchan:select id="supType" mdgroup="ITEM_CLUSTER_BATCH_PRICE_CHNG_IND" _class="w80" />
                                </td>
                            </tr>                         
                        </table>
                    </div>
                    <div class="line"></div>
                    <div class="SearchFooter">
                        <div class="Icon-size1 Tools20"></div>
                        <div class="Icon-size1 Tools6" id="seriesSearch"></div>
                    </div>
                </div>
              	<div class="Content">
		<table id="seriesList" style="height: 570px;"></table>
	      </div>
                </div>
