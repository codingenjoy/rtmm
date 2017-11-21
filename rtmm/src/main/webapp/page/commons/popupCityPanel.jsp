<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
    <link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css" rel="Stylesheet" />
    <link type="text/css" href="${ctx}/shared/themes/${theme}/css/Componet.css" rel="Stylesheet" />
    <script src="${ctx}/shared/js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="${ctx}/shared/js/rtmm.js" type="text/javascript"></script>
    <%@ include file="/page/commons/easyui.jsp"%>
</head>

<style type="text/css">
        .Table_Panel {
            height:400px;
            overflow:hidden;
      
        }
        .tree-folder, .tree-file, 
        .tree-node-hover .tree-file, .tree-node-hover .tree-folder, 
        .tree-node-selected .tree-file, .tree-node-selected .tree-folder {
            background:none;
            display:none;
        }
</style>
<body>

    <div class="Panel">
        <div class="Panel_top">
            <span>省市选择</span>
            <div class="PanelClose"></div>
        </div>
        <div class="Table_Panel">
                <div style="height:199px;"></div>
                <ul id="Mytt2"></ul>
        </div>
        <div class="Panel_footer">
            <div class="PanelBtn">
                <div class="PanelBtn1">保存</div>
                <div class="PanelBtn2">取消</div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $('#Mytt2').tree({
            checkbox: false,
            url: 'json/tree_data1.json'
        });
    </script>

</body>
</html>