<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<%@ include file="/page/commons/toolbar.jsp"%>
<style type="text/css">
/*.ListWin {
            height: 20px;
            width: 20px;
            margin-top: 5px;
            margin-left: 3px;
        }*/
.CInfo input[type="text"] {
	margin-left: 3px;
}

.iconPut {
	margin-right: 3px;
	float: left;
}
.iconPut span {
	color: #999;
}

.zz_info {
	width: 95%;
}

.zz_2 {
	height: 340px;
}

.zz_2 input {
	margin-left: 3px;
}

.zz_11 {
	margin-left: 50px;
}

.zz_12 {
	margin-left: 43px;
}

.zz_13 {
	margin-left: 185px;
}

.zz_14 {
	margin-left: 75px;
}
</style>

<script type="text/javascript">
	$(" :input").attr("readonly",true);
	$("#Tools21").removeClass('Tools21_disable').addClass('Tools21').unbind('click').bind('click',function(){			
		$("#Tools22").removeClass('Tools22').addClass('Tools22_disable').unbind('click');
		readItemOriginList();		
	});

   function readItemOriginList(){		
	    $.ajax({
        type : "post",
        url : ctx + "/itemQueryManagement/itemOriginSearch",
        success : function(data){
            $("#content").html(data);
        }
        });
	}	

</script>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">商品产地</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Content">
		<div class="CInfo">
			<div style="float: left;" class="w35">
				<div class="cinfo_div">货号</div>
				<div class="iconPut w25">
					<input class="w75" type="text" value="${itemOthOrignVOs[0].itemNo}"/>
				</div>
				<input type="text" class="inputText w55" value="${itemOthOrignVOs[0].itemName}"/>
			</div>
			<!-- <span>项</span> <span>10，000</span> <span>/</span> <span>1</span> <span>第</span>
			<span>|</span> <span>张三</span> <span>修改人</span> <span>2014-03-03</span>
			<span>修改日期</span> <span>李四</span> <span>建档人</span> <span>2014-02-02</span>
			<span>创建日期</span> -->
		</div>

		<div style="height: 480px;" class="CM">
			<div class="CM-bar">
				<div>产地及生产单位设定</div>
			</div>
			<div class="CM-div">
				<div style="height: 60px; margin-top: 10px;">
					<div class="inner_half">
						<div class="ig">
							<div class="msg_txt">主产地</div>
							<input type="text" class="w15 inputText" value="${itemOthOrignVOs[0].orignCode}" /> <input type="text"
								class="w35 inputText" value="<auchan:getDictValue code="${itemOthOrignVOs[0].orignCode}" mdgroup="origin" showType="2"/>" />
						</div>
						<div class="ig">
							<div class="msg_txt">主生产单位</div>
							<input type="text" class="w65 inputText" value="${itemOthOrignVOs[0].prdcrName}" />
						</div>
					</div>
					<div class="inner_half">
						<div class="ig">
							<div class="msg_txt">单位地址</div>
							<div class="iconPut w20">
								<input type="text" class="w80" value="${itemOthOrignVOs[0].provName}"  /> <span>省</span>
							</div>
							<div class="iconPut w20">
								<input type="text" class="w80"  value="${itemOthOrignVOs[0].cityName}"/> <span>市</span>
							</div>
						</div>
						<div class="ig">
							<div class="msg_txt">&nbsp;</div>
							<input type="text" class="w65 inputText" value="${itemOthOrignVOs[0].detllAddr}" />
						</div>
					</div>
				</div>
				<div class="zz_info">
					<div class="zz_1">
						<span class="zz_11">城市</span> <span class="zz_12">其他产地</span> <span
							class="zz_13">生产单位</span> <span class="zz_14">单位地址</span>
					</div>
					<div class="zz_2">
					         <c:if test="${itemOthOrignVOs ne null and itemOthOrignVOs.size() > 1 }" >
					        <c:forEach items="${itemOthOrignVOs}" var="itemOthOrignVO" begin="1" >
					          <c:if test="${itemOthOrignVO.majorOrigInd ne 1}">
						<div class="ig" style="margin-top: 5px; margin-left: 10px;">
							<input type="text" class="w10 inputText fl_left"  value="${itemOthOrignVO.cityName }"/> <input
								type="text" class="w7 inputText fl_left"   value="${itemOthOrignVO.orignCode }"/> <input type="text"
								class="w10 inputText fl_left" value="<auchan:getDictValue code="${itemOthOrignVO.orignCode}" mdgroup="origin" showType="2"/>" /> <input type="text"
								class="w20 inputText fl_left" value="${itemOthOrignVO.prdcrName }"/>
							<div class="iconPut w10" style="margin-left: 3px;">
								<input type="text" class="w80" value="${itemOthOrignVO.provName }"/> <span>省</span>
							</div>
							<div class="iconPut w10">
								<input type="text" class="w80" value="${itemOthOrignVO.cityName }"/> <span>市</span>
							</div>
							<input type="text" class="w20 inputText fl_left"  value="${itemOthOrignVO.detllAddr }"/>
						</div>
						</c:if>
						</c:forEach>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
