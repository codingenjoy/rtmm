<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.t_div1,.t_div2 {
	width: 50%;
	height: 539px;
	float: left;
}

.t_div1_1 {
	height: 370px;
}

.t_div1_2 {
	height: 167px;
	margin-top: 2px;
}
/*.t_div2_1 {
            height:120px;
        }*/
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

.icondiv11 {
	width: 20%;
	float: left;
	background: #cccccc;
	color: #999999;
}

.icondiv11 input {
	width: 72%;
	background: #cccccc;
}

.icondiv12 {
	width: 28%;
	float: left;
	margin-left: 3px;
	background: #cccccc;
	color: #999999;
}

.icondiv12 input {
	width: 82%;
	background: #cccccc;
}

.w91_s232 {
	width: 91%;
	width /*\**/: 92% \9;
	*width: 92%;
	background: #cccccc;
}

.icondiv11_2 {
	width: 20%;
	float: left;
	color: #999999;
}

.icondiv11_2 input {
	width: 72%;
}

.icondiv12_2 {
	width: 28%;
	float: left;
	margin-left: 3px;
	color: #999999;
}

.icondiv12_2 input {
	width: 82%;
}

.w91_s232_2 {
	width: 91%;
	width /*\**/: 92% \9;
	*width: 92%;
}
</style>

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
		<span><auchan:getStuffName value="${companyVO.chngBy }"/></span>
		<span><auchan:i18n id="101006010"></auchan:i18n></span>
		<span>
			<fmt:formatDate pattern="yyyy-MM-dd" value="${companyVO.chngDate }" />
		</span>
		<span><auchan:i18n id="101006009"></auchan:i18n></span>
		<span><auchan:getStuffName value="${companyVO.creatBy }"/></span>
		<span><auchan:i18n id="100002016"></auchan:i18n></span><!-- 建档人 -->
		<span>
			<fmt:formatDate pattern="yyyy-MM-dd" value="${companyVO.creatDate }" />
		</span>
		<span><auchan:i18n id="101008010"></auchan:i18n></span>
	</div>
	<div class="line" style="width: 100%"></div>
	<div class="t_div1" style="width: 50%; height: 539px; float: left;">
		<div class="CM t_div1_1">
			<div class="CM-bar">
				<div><auchan:i18n id="101001025"></auchan:i18n></div>
			</div>
			<form id="baseMessageForm">
				<div class="CM-div">
					<table class="CM_table">
						<tr>
							<td style="width: 25%;">
								<span><auchan:i18n id="101001002"></auchan:i18n></span>
							</td>
							<td>
								<input id="comNo" name="firmNumber" type="text" class="inputText twoInput1" value="${companyVO.comNo }" readonly="readonly" />
								<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态</span>
								<select id="status" name="status" style="width: 28%; float: left;">
									<option>${companyVO.statusTitle }</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								<span><auchan:i18n id="101001006"></auchan:i18n></span>
							</td>
							<td>
								<input type="text" class="fl_left inputText w35" value="${companyVO.unifmNo }" />
								<span style="float: left; margin-left: 5px;"><auchan:i18n id="101001009"></auchan:i18n></span>
								<input id="localUnifmNo" name="localUnifmNo" value="${companyVO.localUnifmNo }" type="text" class="inputText w_36" />
							</td>
						</tr>
						<tr>
							<td>
								<span><auchan:i18n id="101001003"></auchan:i18n></span>
							</td>
							<td>
								<input id="comName" name="comName" type="text" class="inputText" style="width: 68%" value="${companyVO.comName }" />
							</td>
						</tr>
						<tr>
							<td>
								<span><auchan:i18n id="101001010"></auchan:i18n></span>
							</td>
							<td>
								<input id="comEnName" name="comEnName" type="text" class="inputText" style="width: 68%" value="${companyVO.comEnName }" />
							</td>
						</tr>
						<tr>
							<td>
								<span><auchan:i18n id="101001004"></auchan:i18n></span>
							</td>
							<td>
								<select id="econType" name="econType" style="width: 40%; float: left;">
									<option>${companyVO.econTitle }</option>
								</select>
							</td>
						</tr>

						<tr>
							<td>
								<span><auchan:i18n id="101001011"></auchan:i18n></span>
							</td>
							<td>
								<input id="legalRpstv" name="legalRpstv" value="${companyVO.legalRpstv }" type="text" class="inputText" style="width: 28%" />
							</td>
						</tr>

						<tr>
							<td>
								<span><auchan:i18n id="101001012"></auchan:i18n></span>
							</td>
							<td>
								<input id="bizScopeDesc" name="bizScopeDesc" value="${companyVO.bizScopeDesc }" type="text" class="inputText" style="width: 68%" />
							</td>
						</tr>
						<tr>
							<td>
								<span><auchan:i18n id="101001008"></auchan:i18n></span>
							</td>
							<td>
								<div class="iconPut" style="width: 28%;">
									<input id="setupDate" name="setupDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${companyVO.setupDate }"/>" type="text"
										class="w80" />
									<div class="Calendar"></div>
								</div>
							</td>
						</tr>
						<tr>
							<td style="width: 20%;">
								<span><auchan:i18n id="101001013"></auchan:i18n></span>
							</td>
							<td>
								<div class="iconPut" style="width: 20%; float: left;">
									<input type="text" value="${regAddr.provName }" style="width: 72%;" />
									<div style="color: #999999;"><auchan:i18n id="101002011"></auchan:i18n></div>
								</div>
								<div class="iconPut" style="width: 28%; float: left; margin-left: 3px;">
									<input type="text" value="${regAddr.cityName }" style="width: 62%;" />
									<div class="ListWin cityselected"></div>
									<div style="color: #999999;"><auchan:i18n id="101002012"></auchan:i18n></div>
								</div>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<input value="${regAddr.detllAddr }" type="text" class="inputText w91_s232_2" />
							</td>
						</tr>
						<tr>
							<td>
								<span><auchan:i18n id="101002006"></auchan:i18n></span>
							</td>
							<td>
								<input type="text" class="fl_left inputText w10" value="${regAddr.areaCode }" maxlength="4" />
								<span style="float: left; margin: 0;">-</span>
								<input type="text" class="fl_left inputText w20" value="${regAddr.phoneNo }" maxlength="8" />
								<span style="float: left; margin-left: 12px;"><auchan:i18n id="101002013"></auchan:i18n></span>
								<input id="email" name="email" value="${regAddr.emailAddr }" type="text" class="inputText w_36 emailvalidation" />
								<span class="emailerror"></span>
							</td>
						</tr>
						<tr>
							<td>
								<span><auchan:i18n id="101001016"></auchan:i18n></span>
							</td>
							<td>
								<input id="webSite" name="webSite" value="${companyVO.webSite }" type="text" class="inputText w91_s232_2" />
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>


		<div class="CM t_div1_2">
			<div class="CM-bar">
				<div><auchan:i18n id="101001017"></auchan:i18n></div>
			</div>
			<form id="personAddressForm">
				<div class="CM-div">
					<table class="CM_table">
						<tr>
							<td style="width: 25%;">
								<span><auchan:i18n id="101001017"></auchan:i18n></span>
							</td>
							<td>
								<div class="iconPut" style="width: 20%; float: left;">
									<input type="text" value="${invAddr.provName }" style="width: 72%;" />
									<div style="color: #999999;"><auchan:i18n id="101002011"></auchan:i18n></div>
								</div>
								<div class="iconPut" style="width: 28%; float: left; margin-left: 3px;">
									<input type="text" value="${invAddr.cityName }" style="width: 62%;" />
									<div class="ListWin cityselected"></div>
									<div style="color: #999999;"><auchan:i18n id="101002012"></auchan:i18n></div>
								</div>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<input value="${invAddr.detllAddr }" type="text" class="inputText w91_s232_2" />
							</td>
						</tr>
						<tr>
							<td>
								<span><auchan:i18n id="101003018"></auchan:i18n></span>
							</td>
							<td>
								<input value="${invAddr.postCode }" type="text" class="inputText twoInput1" />
								<span style="float: left; margin-left: 85px;"><auchan:i18n id="101001019"></auchan:i18n></span>
								<input id="contactPeople" name="contactPeople" type="text" class="inputText twoInput2" />
							</td>
						</tr>
						<tr>
							<td>
								<span><auchan:i18n id="101003027"></auchan:i18n></span>
							</td>
							<td>
								<input type="text" class="fl_left inputText w10" value="${invAddr.areaCode }" maxlength="4" />
								<span style="float: left; margin: 0;">-</span>
								<input type="text" class="fl_left inputText w25" value="${invAddr.phoneNo }" maxlength="8" />
								<span style="float: left; margin-left: 29px;"><auchan:i18n id="101001020"></auchan:i18n></span>
								<input value="${invAddr.moblNo }" type="text" class="inputText twoInput2" maxlength="11" />
							</td>
						</tr>
						<tr>
							<td>
								<span><auchan:i18n id="101001021"></auchan:i18n></span>
							</td>
							<td>
								<input type="text" class="fl_left inputText w10" value="${invAddr.areaCode }" maxlength="4" />
								<span style="float: left; margin: 0;">-</span>
								<input type="text" class="fl_left inputText w25" value="${invAddr.faxNo }" maxlength="8" />
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>

	</div>
	<div class="t_div2">

		<div class="CM t_div2_2">
			<div class="CM-bar">
				<div><auchan:i18n id="101001026"></auchan:i18n></div>
			</div>
			<form id="comCertificate">
				<div class="CM-div">
					<table class="CM_table" style="width: 92%; margin-left: 10px;">
						<tr>
							<td>
								<div class="t2_title">
									<div><auchan:i18n id="101001022"></auchan:i18n></div>
									<div><auchan:i18n id="101001023"></auchan:i18n></div>
									<div><auchan:i18n id="101001024"></auchan:i18n></div>
								</div>
							</td>
						</tr>
						<tr>
							<td class="line"></td>
						</tr>
						<tr>
							<td style="height: 460px;">
								<div class="com1">
									<table class="com1_tb">
										<c:forEach items="${clvList }" var="comLicenceVO">
											<tr>
												<td style="width: 5%;">
													<input type="checkbox" value="${comLicenceVO.licnceId }" disabled="disabled" />
												</td>
												<td style="width: 7%;">
													<div class="com_lis"></div>
												</td>
												<!--class="license1"-->
												<td style="width: 28%;">
													<input value="${comLicenceVO.licnceType }" type="text" class="inputText w90" />
												</td>
												<td style="width: 35%;">
													<input value="${comLicenceVO.licnceNo }" type="text" class="inputText w90" />
												</td>
												<td style="width: 25%;">
													<div class="iconPut w80">
														<input value='<fmt:formatDate pattern="yyyy-MM-dd" value="${comLicenceVO.validEndDate }"/>' type="text" style="width: 79%" />
													</div>
												</td>
											</tr>
										</c:forEach>
									</table>
									</div>
								</td>
							</tr>
							<tr>
								<td class="line"></td>
							</tr>
						</table>
					</div>
				</form>
			</div>
		</div>
	</div>

<script type="text/javascript">

	$(function() {
		if ("${locale }" == "en") {
			$(".Container").addClass("en");
		}
		
		$('#detail').find("input").attr('readonly', 'readonly');
		$('#detail').find("select").attr('disabled', 'disabled');
		var page = parseInt('${currentPage}');
		var totalCount = parseInt($('#totalCount').val());
		
		$("#Tools1").attr('class', "Icon-size1 Tools1_disable B-id");
		//禁用详情
		$('#Tools22').unbind('click');
		//启用列表
		$('#Tools21').unbind('click').bind('click',function() {
			$('#Tools21').parent().attr('class','RightTool checked');
			$('#Tools22').parent().addClass('checked');
			$("#Tools1").attr('class', "Icon-size1 Tools1 B-id");
			$('#listTitle').show();
			$('#list').show();
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
			onClickRow('${companyVO.comNo}',page);
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
			var param = $('#list').find("#queryFrom").serialize();
			$.post(ctx + '/catalog/doGeneralSearch?pageNo='+pageNo,param,function(data){
				$("#detail").html(data);
			},'html');
		}
	});
</script>