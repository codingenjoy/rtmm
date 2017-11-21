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
    </style>
<script type="text/javascript">
	$(function(){
		selectCompany();
	});
	
	
	var divsionId = null;
	var spanText = null;
	//选择所选公司
	function selectCompany(){
	/*	if (comId != obj) { 	
			$("#div"+comId).removeClass("Item_on");
		}
		$("#div"+obj).addClass("Item Item_on");
		comId = obj;
		divsionId = $($("#div"+obj).find('span')[0]).text();
		spanText = $($("#div"+obj).find('span')[1]).text();*/
		$("#dg2").datagrid( {
			rownumbers : false,
			singleSelect : true,
			pagination : true,
			pageSize : 20,
			url : ctx + '/catalog/companyWindowAction',
			columns : [ [ {
				field : 'ck',
				checkbox : true,
				halign : 'center'
			}, {
				field : 'compNo',
				title : '公司编号',
				sortable : true,
				halign : 'center',
				align : 'right'
			}, {
				field : 'compName',
				title : '公司名称',
				sortable : true,
				halign : 'center'
			}, {
				field : 'bizScope',
				title : '公司类型',
				halign : 'center'
			}, {
				field : 'status',
				title : '状态',
				formatter : function(val,rec){
					var v_status = null;
					if (rec.status == 0) {
						v_status = "尚未生效";
					} else if (rec.status == 1) {
						v_status = "正常";
					} else if (rec.status == 9) {
						v_status = "删除";
					}
					return v_status;
				},
				halign : 'center'
			}, {
				field : 'regCity',
				title : '注册城市',
				halign : 'center'
			}, {
				field : 'setupDateBegin',
				title : '成立日期',
				halign : 'center',
				formatter : function(val, rec) {
					return new Date(val).format('yyyy-MM-dd');
				}
			}] ],
			onClickRow : function(rowIndex, rowData) {
				divsionId = rowData.compNo;
				spanText = rowData.compName;
			}
		});
	}
	//保存所选的公司
	function saveCompany(){
		$("#comNo").val(divsionId);
		$("#companName").val(spanText);
		closePopupWin();
	}
</script>

        <div class="Panel_top">
            <span>选择公司</span>
            <div class="PanelClose" style="margin-right:0;"  onclick="closePopupWin()"></div>
        </div>
        <div class="Table_Panel">
            <div style="margin:15px auto;width:97%;height:100%;">
                <div style="height:30px;background:#CCC;">
                    <div class="Icon-div">
                        <input type="text" class="IS_input" value="" />
                        <div class="cbankIcon"></div>
                    </div>
                </div>
<%--                 <div style="height:403px;overflow-x:hidden;overflow-y:scroll;border-left:2px solid #f9f9f9;border-bottom:2px solid #f9f9f9;">
                	<c:forEach items="${companyList }" var="companyVo">
	                	<div id="div${companyVo.bizScope }" class="Item" onclick="selectCompany(${companyVo.bizScope })">
	                        <span>${companyVo.bizScope }</span><span>${companyVo.compName }</span>
	                        <div class="GouIcon"></div>
	                    </div>
	                </c:forEach>
                </div> --%>
                <div class="">
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
