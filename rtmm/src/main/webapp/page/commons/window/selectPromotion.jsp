<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/iframeContent.js" charset="utf-8"></script>
<script type="text/javascript">
function cancel(){
	top.window.$.zWindow.close({'key':'123'});
}
</script>
<style type="text/css">
    .tp_store_bottom {
        margin:15px 20px;
        height:280px;
        border:1px solid #e5e5e5;
    }
    .txi_list {
        height:250px;overflow-y:auto;overflow-x:hidden;
    }
    /*overwrite*/
    .cbankIcon {
        float:right;
        margin-right:1px;
    }
    .item .item_gou {
        margin-top:7px;
    }
    .item {
        padding-left:15px;
        line-height:30px;
    }
</style>
<div class="Panel">
    <div class="Table_Panel">
        <div class="tp_store_bottom">
            <div class="IconDiv_bg">
                <div class="Icon-div">
                    <div class="w95 Icon-div2">
                        <input type="text" class="w100 input_propt_color" value="输入套系编号或名称"/>
                    </div>
                    <div class="cbankIcon"></div>
                </div>
            </div>
            <div class="txi_list">
                <div class="item">01 按区域划分-9大组<div class="item_gou"></div></div>
                <div class="item">01 按区域划分-9大组<div class="item_gou"></div></div>
                <div class="item">01 按区域划分-9大组<div class="item_gou"></div></div>
            </div>
        </div>
        <div style="clear:both;"></div>
    </div>
    <div class="Panel_footer">
        <div class="PanelBtn">
            <div class="PanelBtn1">确定</div>
            <div class="PanelBtn2">取消</div>
        </div>
    </div>
    <div style="clear:both;"></div>
</div>


