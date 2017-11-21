<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
    <style type="text/css">
        .Table_Panel {
            height:408px;
            overflow:hidden;
        }
        .Table_Panel td{
            height:30px;
        }
        .SearchList {
            height:30px;background-color:#f5f5f5;width:100%;float:left;
        }
        .SearchList input{
            width:95%;float:left;height:20px;margin:5px 5px;
        }
        .SearchList div {
            width:16px; height:21px;margin-top:5px;float:left;
        }
        .Item {
            height:30px;
        }
            .Item span {
                float:left;
                line-height:30px;
                margin-left: 20px;
            }
            .Item:hover {
                background:#99cc66;
            }
        .GouIcon {
            float: right;
            height: 16px;
            margin-right: 5px;
            margin-top: 7px;
            width: 16px;
        }
        .Item_on {
            background-color:#3F9673;
        }
    </style>
<script type="text/javascript">
	$(function(){
		selectCompany("");
	});
	$(".cbankIcon").die("click").live("click",function(){
		var comName = $.trim($("#comgrpNameInput").val());
		selectCompany(comName);
	});
	
	function enterIns(evt){
		  var evt=evt?evt:(window.event?window.event:null);//兼容IE和FF
		  if (evt.keyCode==13){
				var comNames = $.trim($("#comgrpNameInput").val());
				selectCompany(comNames);
		}
	}
</script>

        <div class="Panel_top">
            <span>选择公司</span>
            <div class="PanelClose" style="margin-right:0;"  onclick="closePopupWin()"></div>
        </div>
        <div class="Table_Panel">
            <div style="margin:15px auto;width:97%;height:100%;">
				<div style="height: 30px; background: #CCC;">
					<div class="Icon-div">
						<input type="text" class="IS_input" onkeydown="enterIns(event);" value="" id="comgrpNameInput" placeholder="输入公司名称查询" />
						<div class="cbankIcon" ></div>
					</div>
				</div>
                <div>
					<table id="dg2" style="height:360px;width:570px;"></table>
				</div>
            </div>
        </div>
        <div class="Panel_footer">
            <div class="PanelBtn">
                <div class="PanelBtn1" onclick="saveCompany()">确认</div>
                <div class="PanelBtn2" onclick="closePopupWin()">取消</div>
            </div>
        </div>
