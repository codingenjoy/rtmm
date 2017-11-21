<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css" rel="Stylesheet" />
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
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
$(".PanelBtn2, .PanelClose").on("click", function () {
	closePopupWin();
});

</script>
        <div class="Panel_top">
            <span>输入订单商品分店订购量</span>
            <div class="PanelClose"></div>
        </div>
        <div class="Table_Panel">
            <div class="p51_panel">
                <div>
                <textarea id="ordQtyArea" class="w90 txtarea" rows="5"></textarea>
                </div>
                <div class="ig"></div>
                <div class="msg"> 粘贴格式“店号 数量”，例如：“102 20”</div>
            </div>
        </div>
        <div class="Panel_footer">
            <div class="PanelBtn">
                <div class="PanelBtn1" onclick="submitOrdQty()">确定</div>
                <div class="PanelBtn2">取消</div>
            </div>
        </div>
