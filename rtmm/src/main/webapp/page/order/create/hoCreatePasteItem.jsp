<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css" rel="Stylesheet" />
    <script src="${ctx}/shared/js/rtmm.js" type="text/javascript"></script>
    <style type="text/css">
        .Panel {
            width:635px;
        }
        .Table_Panel {
            height:400px;
            overflow:hidden;
        }
        .iconPut {
            width: 20%; float: left;margin-left:5px;
        }
        .txtarea {
            margin-left:20px;height:310px;
        }
        .msg {
            margin-left:20px;color:#f00;
        }
    </style>
<script type="text/javascript">
$(".PanelBtn2").on("click", function () {
	closePopupWin();
});
$(".PanelClose").on("click", function () {
	closePopupWin();
});

</script>
        <div class="Panel_top">
            <span>输入新增的订单商品</span>
            <div class="PanelClose"></div>
        </div>
        <div class="Table_Panel">
            <div class="p51_panel">
                <div>
                <textarea id="orderList" name="orderList" class="w90 txtarea" rows="5" ></textarea>
                </div>
                <div class="ig"></div>
                <div class="msg">
                    
                </div>
            </div>
        </div>
        <div class="Panel_footer">
            <div class="PanelBtn">
                <div class="PanelBtn1" onclick="savePasteOrder()">确定</div>
                <div class="PanelBtn2">取消</div>
            </div>
        </div>
