<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
    <style type="text/css">
        .Table_Panel {
            height:400px;
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
	 	.my-head-td-ck,.ck{
			width:3% !important;
		}
		.my-head-td-comgrpNo,.comgrpNo{
			width:17% !important;
		}
		.my-head-td-comgrpName,comgrpName{
			width:40% !important;
		}
		.my-head-td-comgrpEnName,.comgrpEnName{
			width:40% !important;
		}       
    </style>
<script type="text/javascript">
	$(function(){
		selectComGrp();
		formartDatagrid();
	});
 	function formartDatagrid() {
	    var t1 = ".my-head-td-ck,.datagrid-header-check,.datagrid-cell-check,.ck";
	    var t2 = ".my-head-td-comgrpNo,.my-head-td-comgrpNo div,.comgrpNo div,.comgrpNo";
	    var t3 = ".my-head-td-comgrpName,.my-head-td-comgrpName div,.comgrpName div,.comgrpName";
	    var t4 = ".my-head-td-comgrpEnName,.my-head-td-comgrpEnName div,.comgrpEnName div,.comgrpEnName";
	    $(t1).css("width", $(".datagrid-view").css("width").split("px")[0] * 0.03);
	    $(t2).css("width", $(".datagrid-view").css("width").split("px")[0] * 0.17);
	    $(t3).css("width", $(".datagrid-view").css("width").split("px")[0] * 0.4);
	    $(t4).css("width", $(".datagrid-view").css("width").split("px")[0] * 0.4);
	} 
</script>

        <div class="Panel_top">
            <span>选择集团</span>
            <div class="PanelClose" style="margin-right:0;"  onclick="closePopupWin()"></div>
        </div>
        <div class="Table_Panel">
            <div style="margin:15px auto;width:97%;height:100%;">
<!--                 <div style="height:30px;background:#CCC;">
                    <div class="Icon-div">
                        <input type="text" class="IS_input" value="" />
                        <div class="cbankIcon"></div>
                    </div>
                </div> -->
                <div class="">
					<table id="dg2" style="height:360px;width:570px;"></table>
				</div>
            </div>
        </div>
        <div class="Panel_footer">
            <div class="PanelBtn">
                <div class="PanelBtn1" onclick="chooseComGrp()">确认</div>
                <div class="PanelBtn2" onclick="closePopupWin()">取消</div>
            </div>
        </div>
