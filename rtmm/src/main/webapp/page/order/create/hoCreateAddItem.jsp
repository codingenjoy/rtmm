<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<!--  <link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css" rel="Stylesheet" />-->
    <script src="${ctx}/shared/js/rtmm.js" type="text/javascript"></script>
    <script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
    <style type="text/css">
        /*overwrite*/
        .Table_Panel {
            height:450px;
            overflow:hidden;
        }
        .Table_Panel td{
            height:30px;
        }
        .search_tb_p {
            height: 313px;
        }
        .cbankIcon {
            margin-right: 2px;
            float: right;
        }
        /* .fl_left {
            margin-left:3px;
        } */
    </style>
    <script>
        $(document).ready(function () {
            $(".bSeriesSearch").on("change", function () {
                if (this.checked) {
                    $(".bSeriesSearch_on").css({ "display": "block" });
                } else {
                    $(".bSeriesSearch_on").css({ "display": "none" });
                }
            });
            $(".bItemSearch").on("click", function () {
                if (this.checked) {
                    $(".bSeriesSearch_on").css({ "display": "none" });
                }
            });
            $(".PanelBtn2").on("click", function () {
            	closePopupWin();
            });
            $(".PanelClose").on("click", function () {
            	closePopupWin();
            });
            $("input[name='searchType']").on("click", function () {
            	 var searchType=$(this).val();
            	 if(searchType==0)
            	 {
            		 $(".searchItemNoDiv").hide();
            		 $(".Icon-div").hide();
            		 $("#searchItemNo").val("");
            		 $("#update_items").html("");
            		 $("#errorTip").css("display","none");
            	 }
            	 else
                 {
            		 $(".Icon-div").show();
            		 $(".searchItemNoDiv").hide();
            		 $("#clstrdisplay").val("");
            		 $("#clstrId").val("");
            		 $("#searchItemNo").blur();
            		 $("#update_items").html("");
                 }
            	 
            });
            
            
        	
        });
        
        // 
        function removeClass(obj){
        	$(obj).removeClass("errorInput");
        	$(obj).removeAttr("title");
        }
        
        // 將系列的查詢結果顯示帶底下的區塊
        function getItemByClstrId(){
        	$.ajax({
    			type : "post",
    			dataType : "html",
    			data : {
    				pageNo : 1,
    				pageSize : 20,
    				clstrId : $.trim($("#clstrId").val()),
    				supNo : $.trim($('#supNo').val()),
    				catlgId : $.trim($('#catlgId').val()),
    				needClstrName : 1
    			},
    			url : ctx + '/hoOrderCreate/getHoOrderItemInfo?ti='+(new Date()).getTime(),
    			success : function(data) {
    				$('#update_items').html(data);
    			}
    		});
        }
        
        // 直接輸入系列代號
       	$("#clstrId").keydown(function(e) {
    		if (e.keyCode == 13) {
    			var str = $("#clstrId").val();
    			var result = str.match(/^[0-9]{0,10}$/);
    			if (result != null){
	    			getItemByClstrId();
    			}else{
    				$("#clstrId").addClass("errorInput");
    			 	$("#clstrId").attr("title","请输入数字");    				
    			}
    		}
    	});
    	
      	//系列弹出层
        $("#clstrWinPop").unbind().bind("click", function() {
        	var catlgId=$('#catlgId').val();
        	if(catlgId=="")
        	{
            	top.jWarningAlert('请选择课别！');
        		return;
        	}
        	openPopupWinTwo(660, 520, '/hoOrderCreate/showClusterListPop?catlgId='
        			+ catlgId);
        	});
      
        function selectCluster(obj){
        	if(obj.length == 1)
        	{
        		var clusterid = $(obj).attr('clusterId');
        		var clusternm = $(obj).attr('clusterName');
        		var clusterType = $(obj).attr('clusterType');
        		var clusterbatchPriceChngInd = $(obj).attr('clusterbatchPriceChngInd');
        		
        	 	$('#clstrdisplay').attr('value',clusternm);
        	 	$('#clstrdisplay').removeClass('errorInput');
        		$('#clstrId').attr('value',clusterid); 
        		$('#clstrType').attr('value',clusterType); 
        		$('#batchPriceChngInd').attr('value',clusterbatchPriceChngInd);
        		var pageNo = $('#pageNo1').val() || '1';
        		var pageSize = $('#pageSize1').val() || '10';
        		var catlgId = $('#catlgId').val();
        		var supNo = $('#supNo').val();  		
        		$.ajax({
        			type : "post",
        			dataType : "html",
        			data : {
        				pageNo : pageNo,
        				pageSize : pageSize,
        				clstrId:clusterid,
        				supNo : supNo,
        				catlgId:catlgId
        				
        			},
        			url : ctx + '/hoOrderCreate/getHoOrderItemInfo?ti='+(new Date()).getTime(),
        			success : function(data) {
        				$('#update_items').html(data);
        				if($.trim($("#itemInfoList").text())){
        					$("#errorTip").css("display","none");
        				}
        				else{
        					$("#errorTip").css("display","block");
        				}
        			}
        		});
        		closePopupWinTwo();
        		}
        	else{
        		top.jWarningAlert("请选择系列");
        	}
        }
    </script>

        <div class="Panel_top">
            <span>新增订单商品</span>
            <div class="PanelClose" style="margin-right:0;"></div>
        </div>
        <div class="Table_Panel">
            <div style="margin:15px auto 0px auto;width:97%;height:100%;">
                <div style="height:auto;">
                    <div class="ig">
                        <div class="icol_text">课别</div><input id="catlgId" name="catlgId" type="text" class="inputText w15  fl_left Black" readonly="readonly" value="${catlgId }"/><input type="text" class="inputText w50 Black fl_left" readonly="readonly" value="${catlgName }"/>
                    </div>
                    <div class="ig">
                        <input type="radio" name="searchType" value="0" class="bSeriesSearch"/><span>&nbsp;&nbsp;按系列查询</span><span>&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="radio" name="searchType" value="1" checked="checked" class="bItemSearch" /><span>&nbsp;&nbsp;按单品查询</span>
                    </div>
 
                    <div class="Bar_off ig bSeriesSearch_on">
                        <div class="icol_text">系列</div>
                        <div class="iconPut fl_left w15">
                             <input type="text" class="w75" id="clstrId" name="clstrId" onClick="removeClass(this)"/>
                             <div class="ListWin" name="clstrId" id="clstrWinPop"></div>
                        </div>
                        <input type="text" class="inputText w50 Black fl_left" id="clstrdisplay" name="clstrdisplay" />
                        <div class="icol_text red" id="errorTip" style="display: none;">该系列没有商品</div>
                        <input type="hidden"  id="clstrType" value="" />
						<input type="hidden"  id="batchPriceChngInd" value="" />						
                    </div>
                </div>
                <div style="height:1px;background:#CCC;" >
                    <div class="Icon-div">
                        <input type="text" class="IS_input" value="" id="searchItemNo" name="searchItemNo" placeholder="请输入商品名称查询"/>
                        <div class="cbankIcon" onclick="search1()"></div>
                    </div>
                </div>
                <br class="clearBoth"/>
                <div class="search_tb_p">
                   <div id="update_items" style="height:400px;"></div>
                   
                </div>
            </div>
        </div>
        <div class="Panel_footer">
            <div class="PanelBtn">
                <div id="confirm" class="PanelBtn1" onclick="saveHoOrderItemNo()">确定</div>
                <div class="PanelBtn2">取消</div>
            </div>
        </div>
        <input type="hidden"  id="supNo" name="supNo" value="${supNo }" />
<input type="hidden" name="pageNo1" id="pageNo1" value="${page.pageNo }" />
        
        
<script type="text/javascript">

	$('#searchItemNo').keydown(function(e) {
		if (e.keyCode == 13) {
			search1();
			return false;
		}
	});
    function search1(){
    	$('#pageNo1').val(1);
    	pageQuery1();   	
    }
	function pageQuery1() {
		var clstrId="";
		var itemName="";
				
			var searchType=$("input[name='searchType']:checked").val();
			if(searchType==0)
			{  
				clstrId=$("#clstrId").val();
			}
			else
				{
				var queryKey=$.trim($("#searchItemNo").val()); 
				if(queryKey==""||queryKey==undefined){
					top.jWarningAlert("请输入查询条件");	
					return;
				}
				itemName=queryKey;
				}
			
		var pageNo = $('#pageNo1').val() || '1';
		var pageSize = $('#pageSize1').val() || '10';
		var catlgId = $('#catlgId').val();
		var supNo = $('#supNo').val();
		$('#pageNo1').val(1);
		
		$.ajax({
			type : "post",
			dataType : "html",
			data : {
				pageNo : pageNo,
				pageSize : pageSize,
				clstrId:clstrId,
				supNo : supNo,
				catlgId:catlgId,
				itemName:itemName
			},
			url : ctx + '/hoOrderCreate/getHoOrderItemInfo?ti='+(new Date()).getTime(),
			success : function(data) {
				$('#update_items').html(data);
			}
		});
	}

</script>
        