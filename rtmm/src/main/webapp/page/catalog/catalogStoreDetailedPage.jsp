<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.t_div1,.t_div2 {
	width: 50%;
	height: 539px;
	float: left;
}

.t_div1_1 {
	height: 387px;
}

.t_div1_2 {
	height: 150px;
	margin-top: 2px;
}

.t_div2_2 {
	height: 539px;
	margin-top: 2px;
}

.t2_title {
	line-height: 25px;
}

.t2_title div {
	width: 70px;
	float: left;
	margin-left: 75px;
}

.com1 {
	height: 100%;
	overflow-x: hidden;
	overflow-y: scroll;
}

.com1_tb {
	width: 100%;
	height: 55px;
}

.com_lis {
	height: 20px;
	width: 20px;
	border: 1px dashed #999999;
}

.icondiv11_new {
	width: 20%;
	float: left;
	color: #999999;
}

.icondiv11_new input {
	width: 72%;
}

.icondiv12_new {
	width: 28%;
	float: left;
	margin-left: 3px;
	color: #999999;
}

.icondiv12_new input {
	width: 82%;
}

.w91_s232_new {
	width: 91%;
	width: 92%;
	width: 92%;
}

.icondiv11_new_2 {
	width: 20%;
	float: left;
	color: #999999;
}

.icondiv11_new_2 input {
	width: 72%;
}

.icondiv12_new_2 {
	width: 28%;
	float: left;
	margin-left: 3px;
	color: #999999;
}

.icondiv12_new_2 input {
	width: 82%;
}

.w91_s232_new_2 {
	width: 91%;
	width: 92%;
	width: 92%;
}
</style>
<script type="text/javascript">
	$(function() {
		if ("${locale }" == "en") {
			$(".Container").addClass("en");
		}
		$("#Tools1").attr('class', "Icon-size1 Tools1_disable B-id");
		$('#detail').find("input").attr('readonly', 'readonly');
		$('#detail').find("select").attr('disabled', 'disabled');
		var page = parseInt('${currentPage}');
		var totalCount = parseInt($('#totalCount').val());

		//禁用详情
		$('#Tools22').unbind('click');
		//启用列表
		$('#Tools21').unbind('click').bind('click',function() {
			$('#Tools21').parent().attr('class','RightTool checked');
			$('#Tools22').parent().addClass('checked');
			$("#Tools1").attr('class', "Icon-size1 Tools1 B-id");
			$('#listTitle').show();
			$('#storeList').show();
			$('#detailTitle').hide();
			$('#detail').hide();
			//禁用翻页按钮
			$("#Tools17").addClass('Tools17_disable');
			$("#Tools19").addClass('Tools19_disable');
			$("#Tools18").addClass('Tools18_disable');
			$("#Tools16").addClass('Tools16_disable');
			//禁用列表按钮 
			$('#Tools21').removeClass('Tools21').addClass('Tools21_disable');
			//启用详情按钮
			onClickRow('${storeInfoVO.storeNo}',page);
		});

		//上一页
		if(page != '1' && page != ''){
			$("#Tools17").removeClass('Tools17_disable').addClass('Tools17').unbind('click').bind('click',function() {
				doGeneralSearch(parseInt(page)-1);
			});
		}else{
			$("#Tools17").addClass('Tools17_disable');
		}

		//下一页
		if(page != totalCount){
			$("#Tools19").removeClass('Tools19_disable').addClass('Tools19').unbind('click').bind('click',function() {
				doGeneralSearch(parseInt(page)+1);
			});
		}else{
			$("#Tools19").addClass('Tools19_disable');
		}
		
		//最后一页
		if(page != totalCount && totalCount > page){
			$("#Tools18").removeClass('Tools18_disable').addClass('Tools18').unbind('click').bind('click',function() {
				doGeneralSearch(totalCount);
			});
		}else{
			$("#Tools18").addClass('Tools18_disable');
		}

		//第一页
		if(page != '1' && page !='' ){
			$("#Tools16").removeClass('Tools16_disable').addClass('Tools16').unbind('click').bind('click',function() {
				doGeneralSearch(1);
			});
		}else{
			$("#Tools16").addClass('Tools16_disable');
		}

		function doGeneralSearch(pageNo){
			var param = $('#storeList').find("#queryFrom").serialize();
			$.post(ctx + '/catalog/doGeneralSearchStore?pageNo='+pageNo,param,function(data){
				$("#detail").html(data);
			},'html');
		}
	});
</script>
<div class="Content" style="width: 99%;">
	<!--width:74%;-->
	<div class="CInfo hide">
		<c:if test="${totalCount>0}">
		 <span><auchan:i18n id="100000012"></auchan:i18n></span><!-- 项 -->
            <span>${totalCount}</span>
            <span>/</span>
            <span>${currentPage}</span>
            <span><auchan:i18n id="100000013"></auchan:i18n></span><!-- 第 -->
          </c:if>
          <span>|</span>
		<span><auchan:getStuffName value="${storeInfoVO.chngBy }"/></span>
		<span><auchan:i18n id="101006010"></auchan:i18n></span>
		<span>
			<fmt:formatDate pattern="yyyy-MM-dd" value="${storeInfoVO.chngDate }" />
		</span>
		<span><auchan:i18n id="101007010"></auchan:i18n></span>
		<span><auchan:getStuffName value="${companyVO.creatBy }"/></span>
		<span><auchan:i18n id="100002016"></auchan:i18n></span><!-- 建档人 -->
		<span>
			<fmt:formatDate pattern="yyyy-MM-dd" value="${storeInfoVO.creatDate }" />
		</span>
		<span><auchan:i18n id="101007009"></auchan:i18n></span>
	</div>
	<div class="line" style="width: 100%"></div>
	<!--539-->
	<div class="CM" style="height: 240px;">
		<div class="CM-bar">
			<div><auchan:i18n id="101001025"></auchan:i18n></div>
		</div>
		<div class="CM-div">
			<table class="CM_table">
				<tr>
					<td class="w12_5">
						<span><auchan:i18n id="101003002"></auchan:i18n></span>
					</td>
					<td class="w35">
						<input class="inputText w20" id="storeNo" value="${storeInfoVO.storeNo }" type="text" />
					</td>
					<td class="w15">
						<span><auchan:i18n id="101003007"></auchan:i18n></span>
					</td>
					<td>
						<input type="text" id="openDate" name="openDate" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${storeInfoVO.openDate }"/>'
							class="inputText w35" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101003003"></auchan:i18n></span>
					</td>
					<td>
						<input class="inputText w45" id="storeName" name="storeName" value="${storeInfoVO.storeName }" type="text" />
					</td>
					<td class="w15">
						<span><auchan:i18n id="101003016"></auchan:i18n></span>
					</td>
					<td>
						<input class="inputText w20" id="openTime" name="openTime" value="${storeInfoVO.openTime }" type="text" style="float: left;" />
						<span style="float: left; margin: 0;">-</span>
						<input class="inputText w20" id="closdTime" name="closdTime" value="${storeInfoVO.closdTime }" type="text" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101003004"></auchan:i18n></span>
					</td>
					<td>
						<auchan:select mdgroup="STORE_STATUS" _class="w30" value="${storeInfoVO.status}"/>
						<%-- <input class="inputText w25 Black downSelect" type="text" value="${storeInfoVO.statusTitle}" readonly="readonly" /> --%>
					</td>
					<td>
						<span><auchan:i18n id="101003017"></auchan:i18n></span>
					</td>
					<td>
						<div class="iconPut icondiv11_new">
							<input id="provName" name="provName" type="text" value="${addressVO.provName }" />
							<div><auchan:i18n id="101002011"></auchan:i18n></div>
						</div>
						<div class="iconPut icondiv12_new">
							<input id="cityName" name="cityName" type="text" value="${addressVO.cityName }" />
							<div style="color: #999999;"><auchan:i18n id="101002012"></auchan:i18n></div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101003008"></auchan:i18n></span>
					</td>
					<td>
						<auchan:select mdgroup="STORE_BIZ_TYPE" _class="w30" value="${storeInfoVO.bizType}"/>
					</td>
					<td>&nbsp;</td>
					<td>
						<input type="text" id="detllAddr" name="detllAddr" value="${addressVO.detllAddr }" class="inputText w91_s232_new_2" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101003009"></auchan:i18n></span>
					</td>
					<td>
						<auchan:select mdgroup="REALSTORE_DISC_STORE_IND" _class="w15" style="float: left;" value="${storeInfoVO.discStoreInd}"/>						
						<span style="float: left; margin: 0px 3px 0px 5px;"><auchan:i18n id="101003010"></auchan:i18n></span>
						<auchan:select mdgroup="STORE_JOIN_DC_IND" _class="w15" style="float: left;" value="${storeInfoVO.joinDcInd}"/>
						<c:choose>
							<c:when test="${storeInfoVO.bizType=='7'}">
								<span style="float: left; margin: 0px 3px 0px 5px;"><auchan:i18n id="101003034"></auchan:i18n></span><!-- 物流区域 -->
								<div class="iconPut " style="width: 25%; float: left;">
									<input class="w76" type="text" value="${storeInfoVO.dcAssrtTitle }" class="" />
									<div class="ListWin"></div>
								</div>
							</c:when>
						</c:choose>
					</td>
					<td>
						<span><auchan:i18n id="101002005"></auchan:i18n></span>
					</td>
					<td>
						<input class="inputText w45" name="postCode" id="postCode" value="${addressVO.postCode }" type="text" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101003005"></auchan:i18n></span>
					</td>
					<td>
						<input class="inputText " type="text" value="${storeInfoVO.lvlTiltle }" style="width: 40%;" />
					</td>
					<td>
						<span><auchan:i18n id="101003019"></auchan:i18n></span>
					</td>
					<td>
						<input type="text" class="fl_left inputText w10" value="${addressVO.areaCode }" />
						<span style="float: left; margin: 0;">-</span>
						<input type="text" class="fl_left inputText w25" value="${addressVO.phoneNo }" />
						<div class="fl_left" style="margin: 2px 5px 0px 5px;"><auchan:i18n id="101003020"></auchan:i18n></div>
						<input type="text" class="fl_left inputText w10" value="${addressVO.areaCode }" />
						<span style="float: left; margin: 0;">-</span>
						<input class="fl_left inputText w25" name="faxNo" id="faxNo" value="${addressVO.faxNo }" type="text" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101003006"></auchan:i18n></span>
					</td>
					<td>
						<input class=" inputText " style="width: 60%;" name="comName" id="comName" value="${storeInfoVO.comTitle }" type="text" />
					</td>
					<td>
						<span><auchan:i18n id="101003022"></auchan:i18n></span>
					</td>
					<td>
						<input class="inputText  w45" value="${storeInfoVO.regnName }" type="text" />
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div style="height: 297px; margin-top: 2px;">
		<div style="width: 50%; height: 100%; float: left;">
			<div style="height: 90px;" class="CM">
				<div class="CM-bar">
					<div><auchan:i18n id="101003029"></auchan:i18n></div>
				</div>
				<div class="CM-div">
					<table class="CM_table">
						<tr>
							<td class="w25">
								<span><auchan:i18n id="101003011"></auchan:i18n></span>
							</td>
							<td>
								<input type="text" id="nrStartDate" name="nrStartDate" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${storeInfoVO.nrStartDate }"/>'
									class="inputText w35" />
							</td>
						</tr>
						<tr>
							<td>
								<span><auchan:i18n id="101003012"></auchan:i18n></span>
							</td>
							<td>
								<input type="text" id="compOpenDate" name="compOpenDate" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${storeInfoVO.compOpenDate }"/>'
									class="inputText w35 " />
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div style="height: 205px; margin-top: 2px;" class="CM">
				<div class="CM-bar">
					<div><auchan:i18n id="101003031"></auchan:i18n></div>
				</div>
				<div class="CM-div">
					<table class="CM_table">
						<tr>
							<td class="w25">
								<span><auchan:i18n id="101001006"></auchan:i18n></span>
							</td>
							<td>
								<input type="text" value="${companyVO.unifmNo }" class="inputText w45 " />
							</td>
						</tr>
						<tr>
							<td style="width: 20%;">
								<span><auchan:i18n id="101001013"></auchan:i18n></span>
							</td>
							<td>
								<div class="iconPut icondiv11_new">
									<input type="text" value="${comRegVO.provName }" />
									<div><auchan:i18n id="101002011"></auchan:i18n></div>
								</div>
								<div class="iconPut icondiv12_new">
									<input type="text" value="${comRegVO.cityName }" />
									<div style="color: #999999;"><auchan:i18n id="101002012"></auchan:i18n></div>
								</div>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<input type="text" value="${comRegVO.detllAddr }" class="inputText w91_s232_new" />
							</td>
						</tr>
						<tr>
							<td style="width: 20%;">
								<span><auchan:i18n id="101003015"></auchan:i18n></span>
							</td>
							<td>
								<div class="iconPut icondiv11_new">
									<input type="text" value="${comInvVO.provName }" />
									<div><auchan:i18n id="101002011"></auchan:i18n></div>
								</div>
								<div class="iconPut icondiv12_new">
									<input type="text" value="${comInvVO.cityName }" />
									<div style="color: #999999;"><auchan:i18n id="101002012"></auchan:i18n></div>
								</div>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<input type="text" value="${comInvVO.detllAddr }" class="inputText w91_s232_new" />
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="CM" style="width: 50%; height: 100%; float: left;">
			<div class="CM-bar">
				<div><auchan:i18n id="101003032"></auchan:i18n></div>
			</div>
			<div class="CM-div">
				<table style="width: 90%; margin-left: 20px;">
					<tr>
						<td class="w23"><auchan:i18n id="101002002"></auchan:i18n></td>
						<td class="w15"><auchan:i18n id="101003024"></auchan:i18n></td>
						<td class="w15"><auchan:i18n id="101003025"></auchan:i18n></td>
						<td class="w10"><auchan:i18n id="101003026"></auchan:i18n></td>
						<td class="w17"><auchan:i18n id="101003027"></auchan:i18n></td>
						<td style="width: auto;"><auchan:i18n id="101003028"></auchan:i18n></td>
					</tr>
					<tr>
						<td colspan="6" class="line"></td>
					</tr>
					<tr>
						<td colspan="6" style="height: 215px;">
							<div style="height: 215px; overflow-x: hidden; overflow-y: scroll;">
								<table style="width: 100%;">
									<c:forEach items="${swaVoList }" var="swa">
										<tr>
											<td class="w15">
												<input type="text" value="${swa.whseNo }" class="inputText w95 " />
											</td>
											<td class="w25">
												<input type="text" value="${swa.detllAddr }" title="${swa.detllAddr }" class="inputText w95 " />
											</td>
											<td class="w15">
												<input type="text" value="${swa.postCode }" class="inputText w95 " />
											</td>
											<td class="w10">
												<input type="text" value="${swa.areaCode }" class="inputText w95 " />
											</td>
											<td class="w17">
												<input type="text" value="${swa.phoneNo }" class="inputText w95 " />
											</td>
											<td style="width: auto;">
												<input type="text" value="${swa.faxNo }" class="inputText w95 " />
											</td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="6" class="line"></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>