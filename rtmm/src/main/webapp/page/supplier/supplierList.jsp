<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/supplier/supplierCommon.js" charset="gbk" type="text/javascript"></script>
<%@ include file="/page/commons/toolbar.jsp"%>

<div class="CTitle">
  	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on" style="">
     	厂商管理
	</div>
    <div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<form id="queryFrom"  class="clean_from">
	<div class="Search" style="display: none;">
		<!-- Bar_on-->
		<div class="SearchTop">
			<span><auchan:i18n id="100002013"/></span><!-- 查询条件 -->
			<div class="Icon-size1 CircleClose C-id" onclick="{DispOrHid('C-id');gridbar_C();}"></div>
		</div>
		<div class="line"></div>
		<div class="SMiddle">
			<table class="SearchTable">
				<tr>
					<td class="ST_td1">
						<span><!-- 采购厂编 --><auchan:i18n id="102006003"/></span>
					</td>
					<td class="ST_td2">
						<input name="supNo" type="text" class="inputText w80" value="${searchSupplierVO.supNo}" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
					</td>
				</tr>
				<tr>
					<td>
						<span><!-- 公司 --><auchan:i18n id="102006005"/></span>
					</td>
					<td>
						<div class="iconPut" style="width: 55%; float: left;">
							<input id="comNo" name="comNo" type="text" style="width: 75%" value="${searchSupplierVO.comNo}"/>
							<div class="ListWin" id="selectCompany"></div>
						</div>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input id="comName" name="comName" type="text" class="Black inputText w80" readonly="readonly" value="${searchSupplierVO.comName}"/>
					</td>
				</tr>
				<tr>
					<td>
						<span><!-- 厂商种类 --><auchan:i18n id="102006007"/></span>
					</td>
					<td>
						<auchan:select name="supType" mdgroup="SUPPLIER_SUP_TYPE" _class="w80" value="${searchSupplierVO.supType}" ignoreValue="11,12" />
					</td>
				</tr>
				<tr>
					<td>
						<span><!-- 厂商状态 --><auchan:i18n id="102006004"/></span>
					</td>
					<td>
						<auchan:select name="status" mdgroup="SUPPLIER_STATUS" _class="w80" value="${searchSupplierVO.status}"/>
					</td>
				</tr>
				<tr>
					<td>
						<span><!-- 供货方式 --><auchan:i18n id="102006008"/></span>
					</td>
					<td>
						<auchan:select name="dlvryMethd" mdgroup="SUPPLIER_DLVRY_METHD" _class="w80" value="${searchSupplierVO.dlvryMethd}"/>
					</td>
				</tr>
				<tr>
					<td>
						<span><!-- 采购方式 --><auchan:i18n id="102006009"/></span>
					</td>
					<td>
						<auchan:select name="buyMethd" mdgroup="SUPPLIER_BUY_METHD" _class="w80" value="${searchSupplierVO.buyMethd}"/>
					</td>
				</tr>
				<tr>
					<td>
						<span><!-- 合同标准 --><auchan:i18n id="102006011"/></span>
					</td>
					<td>
						<auchan:select name="cntrtType" mdgroup="SUPPLIER_CONTRT_TYPE" _class="w80" value="${searchSupplierVO.cntrtType}"/>
					</td>
				</tr>
				<tr>
					<td>
						<span>门店</span>
					</td>
					<td>
						<select name="storeNo" class="w80">
							<option value=""><auchan:i18n id="100000009"/></option>
							<c:forEach items="${stores}" var="store">
									<c:choose>
										<c:when test="${store.storeNo==searchSupplierVO.storeNo}">
											<option value="${store.storeNo}" selected="selected">${store.storeName}</option>
										</c:when>
										<c:otherwise>
											<option value="${store.storeNo}">${store.storeName}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="102008004"/></span><!-- 课别 -->
					</td>
					<td>
						<div class="iconPut" style="width: 35%; float: left;">
							<input id="catlgId"  name="catlgId" type="text" style="width: 65%" value="${searchSupplierVO.catlgId}">
							<div class="ListWin" id="selectDivision"></div>
						</div>
						<input id="catlgName" name="catlgName" type="text" class="Black inputText twoInput2 w50" readonly="readonly" value="${searchSupplierVO.catlgName}">
					</td>
				</tr>
				<tr>
					<td>
						<span><!-- 可否退货 --><auchan:i18n id="102006033"/></span>
					</td>
					<td>
						<auchan:select name="rtnAllow" mdgroup="SUP_STORE_SEC_INFO_RTN_ALLOW" _class="w80" value="${searchSupplierVO.rtnAllow}"/>
					</td>
				</tr>
				<tr>
					<td>
						<span><!-- 付款状态 --><auchan:i18n id="102006038"/></span>
					</td>
					<td>
						<auchan:select name="paySttus" mdgroup="SUP_STORE_SEC_INFO_PAY_STTUS" _class="w80" value="${searchSupplierVO.paySttus}"/>
						
					</td>
				</tr>
				<tr>
					<td>
						<span><!-- 门店课别状态 --><auchan:i18n id="102006029"/></span>
					</td>
					<td>
						<auchan:select name="cataStatus" mdgroup="SUP_STORE_SEC_INFO_STATUS" _class="w80" value="${searchSupplierVO.cataStatus}"/>
					</td>
				</tr>
				<tr>
					<td>
						<span><!-- 应付余额 --><auchan:i18n id="102006037"/></span>
					</td>
					<td>
						<input name="apAmtSt" type="text" class="inputText w35" value="${searchSupplierVO.apAmtSt}"/>-
						<input name="apAmtEd" type="text" class="inputText w35" value="${searchSupplierVO.apAmtEd}"/>元
					</td>
				</tr>
				<tr>
					<td>
						<span><!-- 进价折扣 --><auchan:i18n id="102006039"/></span>
					</td>
					<td>
						<input name="bpDiscSt" type="text" class="inputText w35" value="${searchSupplierVO.bpDiscSt}"/>-
						<input name="bpDiscEd" type="text" class="inputText w35" value="${searchSupplierVO.bpDiscEd}"/>%
					</td>
				</tr>
				<tr>
					<td>
						<span><!-- 发票折扣 --><auchan:i18n id="102006040"/></span>
					</td>
					<td>
						<input name="invDiscSt" type="text" class="inputText w35" value="${searchSupplierVO.invDiscSt}"/>-
						<input name="invdiscEd" type="text" class="inputText w35" value="${searchSupplierVO.invdiscEd}"/>%
					</td>
				</tr>
				<tr>
					<td>
						<span><!-- 其他折扣 --><auchan:i18n id="102006041"/></span>
					</td>
					<td>
						<input name="othDiscSt" type="text" class="inputText w35" value="${searchSupplierVO.othDiscSt}"/>-
						<input name="othDiscEd" type="text" class="inputText w35" value="${searchSupplierVO.othDiscEd}"/>%
					</td>
				</tr>
			</table>
		</div>
		<div class="line"></div>
		<div class="SearchFooter">
			<div class="Icon-size1 Tools20" onclick="clean()"></div>
			<div class="Icon-size1 Tools6" onclick="search()"></div>
		</div>
	</div>
	<div class="Content" id="supplier_content">
	</div>
	</form>
</div>
<script type="text/javascript">
	$(function() {

		$("#queryFrom").find('input').not('[name=comNo]').keydown(function(e){ 
			if(e.keyCode == 13){ 
				pageQuery(); 
            	return false;
			} 
		}); 

		$("#comNo").keydown(function(e){ 
			
			if(e.keyCode == 13){ 
				//根据comNo查询其注册地址填充到厂商联系方式中
				var comNo = $(this).val();
				$.post("${ctx}/supplier/company/getSupCompanyInfo",{comNo:comNo}, function(data){
					if(data.supCompany && data.supCompany.comNo){
						$('#comName').attr("value",data.supCompany.comName);
						pageQuery();
					}else{
						top.jAlert('warning',comNo+'公司不存在，请确认后重新输入','提示消息');
						$('#comNo').attr("value",'');
					}
				});
            	return false;
			} 
		}); 

		
		
		$('#Tools1').attr('class', 'Icon-size1 Tools1 B-id').bind('click',function() {
			DispOrHid('B-id');
			gridbar_B();
		});
		
		$('#selectDivision').bind("click",function(){
			supplierCommon.selectDivision('0,1,9');
		});
		
		$("#selectCompany").bind("click",function(){
			supplierCommon.selectCompany();
		});
		
		/* $("#searchSupplier").bind("click",function(){
			pageQuery();
		}); */
		
		//supplierList.serachSuppiler();
		search();
	});

	function clean(){
		$('#comNo').attr('value','');
		$('#comName').attr('value','');
		$('#catlgId').attr('value','');
		$('#catlgName').attr('value','');
	}
	
	function confirmChooseSupCom(comNo, comName, grpNo, grpName) {
		$("#comNo").attr("value",comNo);
		$("#comName").attr("value",comName);
	}
	
	function confirmChooseSection(id, name){
		$('#catlgId').attr('value', id);
		$('#catlgName').attr('value', name);
		closePopupWin();
	} 

	function search() {
		$("#pageNo").val(1);
		pageQuery();
	}

	function pageQuery() {
		var param = $("#queryFrom").serialize();
		$.post(ctx + '/supplier/getSupplierByPage',param,function(data){
			$("#supplier_content").html(data);
		},'html');
		
	}

	var tool22 = $('#Tools22');
	$(tool22).removeClass('Tools22_disable').addClass('Tools22');
	$(tool22).unbind('click').bind('click',function() {
		$.post(ctx + '/supplier/generalSearch',function(data){
			$("#content").html(data);
		},'html');
	});
	
	function onClickRow(supNo){
		var tool22 = $('#Tools22');
		$(tool22).removeClass('Tools22_disable').addClass('Tools22');
		$(tool22).unbind('click').bind('click',function() {
			showContent(ctx + '/supplier/getSupplierGeneralInfo?supNo=' +supNo);
		});
		<auchan:operauth ifAnyGrantedCode="111311996">	
			var tool12 = $('#Tools12');
			$(tool12).removeClass('Tools12_disable').addClass('Tools12');
			$(tool12).unbind("click");
			$(tool12).unbind('click').bind('click',function() {
				$.ajax({
					type : "post",
					async : false,
					url : ctx + "/supplierAudit/checkSupplierModifiable",
					dataType : "json",
					data : {
						'supNo' : supNo
					},
					success : function(data) {
						if (data.status!='success') {
							top.jWarningAlert(data.message);
						} else {
							showContent(ctx + '/supplierAudit/updateSupplierBySupNo?supNo='+ supNo+'&action=update');
						}
					}
				});
			});
		</auchan:operauth>
	}


	function onDblClickRow(supNo,comNo,count){
		
		var pageNo = $('#pageNo').val();
		var pageSize = $('#pageSize').val();
		var page = (parseInt(pageNo,10)-1)*parseInt(pageSize,10) + parseInt(count,10);
		$.post(ctx + '/supplier/changeGeneralSearchPage',{'page':page},function(data){
			$("#content").html(data);
		},'html');
	}

</script>