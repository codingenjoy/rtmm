<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<script type="text/javascript">
	function selectSupplier(obj) {
		var supno = $(obj).attr('supNo');
		var supnm = $(obj).attr('comName');
		var comNo = $(obj).attr('comNo');
		var internalInd = $(obj).attr('internalInd');
		var cntrtType = $(obj).attr('cntrtType');
		if (item_create_content == 1 && supno != null) {
			$('#majorSupNo').val(supno);
			$('#majorSupNo').removeClass('errorInput');
			$('#chubieInput').removeClass('errorInput');
			$('#kebieInput').removeClass('errorInput');
			$('.sellVatNo').removeClass('errorInput');
			$('.buyVatNo').removeClass('errorInput');
			var buyMethd = $('#buyMethd');

			if (buyMethd.size()>0) {
				getBuyMethodsBySupplierId(supno,internalInd);
			}
			$('#supName').val(supnm);
			if($.trim(cntrtType)!=''){
				$('#buyPerd').val(cntrtType);
				$('#buyPerd').removeClass('errorInput');
			}
			setBuyPerdParameter(cntrtType);
			
			//getSupDivSecInfo
			$.post(ctx + '/item/create/getSupDivSecInfo?supNo='+supno, function(data) {
				if(!data || !data.divNo|| internalInd==1){
					$('#chubieInput').unautocomplete();
					$('#kebieInput').unautocomplete();
					$('#dafenleiInput').unautocomplete();
					$('.ac_results').empty();
					chubieInputSelect2(ctx + "/item/create/getDivisions");
					kebieInputSelect2(ctx + '/item/create/getSectionAction?divisionId='+$('#chubieInput2').val());
					ctx + $('#kebieInput').attr('currurl')+ data.catlgId;
					$('#kebieInput').attr('currurl','/catalog/groupShowSectionAction?divisionId=');
					$('#chubieInput').val('');
					$('#chubieInput2').val('');
					$('#kebieInput').val('');
					$('#kebieInput2').val('');
					$('#dafenleiInput').val('');
					$('#dafenleiInput2').val('');
					$('#zhongfenleiInput').val('');
					$('#zhongfenleiInput2').val('');
					$('#xiaofenleiInput').val('');
					$('#xiaofenleiInput2').val('');
					$('#clstrdisplay').val('');
					return false;
				}
				$('#chubieInput').val(data.divNo+"-"+data.divName);
				$('#chubieInput2').val(data.divNo);
				$('#kebieInput').val(data.secNo+"-"+data.secName);
				$('#kebieInput2').val(data.secNo);
				chubieInputSelect(ctx + "/item/create/getSupDivList?supNo="+supno);
				$('#kebieInput').attr('currurl','/item/create/getSupSecList?supNo='+supno+'&divisionId=');
				kebieInputSelect(ctx+$('#kebieInput').attr('currurl')+$('#chubieInput2').val());
				dafenleiInputSelect(ctx+$('#dafenleiInput').attr('currurl')+$('#kebieInput2').val() );
				$('#clstrdisplay').val('');
				$('#dafenleiInput').val('');
				$('#dafenleiInput2').val('');
				$('#zhongfenleiInput').val('');
				$('#zhongfenleiInput2').val('');
				$('#xiaofenleiInput').val('');
				$('#xiaofenleiInput2').val('');
			});
		} else if (item_create_content == 5) {
			var existSup = $('.otherSup[othSupNo="' + supno + '"]');
			var list_ex0List = $('.list_ex0[supNo="' + supno + '"]');
			
			var updataTag = $('#updataTag').val();
			$('.curig:first').find('.errorInput').removeClass('errorInput');
			$('.curig:first').find('.otherSup:first').attr('preval2','');
			if($('#supNo:visible').size()>0){
				if (existSup.size() > 1) {
					top.jAlert('warning', '您已选择了该供应商为非主厂商!', '消息提示');
					obj.val('');
					obj.parent().parent().find('.comNo').val('');
					obj.parent().parent().find('.comName').val('');
					return false;
				}
				$('.curig:first').find('.otherSup:first').val(supno);
				getSupplierByInputSupplierId($('.curig:first').find('.otherSup:first'),updataTag);
			}
			else{
				var majorSupNo = $('#majorSupNo').val();
				if ((existSup.size()==1&& !existSup.parent().parent().hasClass('curig')) && existSup.size() > 0) {
					top.jAlert('warning', '您已选择了该供应商!', '消息提示');
					obj.val('');
					obj.parent().parent().find('.comNo').val('');
					obj.parent().parent().find('.comName').val('');
					return false;
				}
				if (list_ex0List.size() > 0) {
					top.jAlert('warning', '该供应商已选为主厂商,不能选为非主厂商!', '消息提示');
					obj.val('');
					obj.parent().parent().find('.comNo').val('');
					obj.parent().parent().find('.comName').val('');
					return false;
				}
				if (supno==majorSupNo) {
					top.jAlert('warning', '该供应商已选为商品主厂商,不能选为非主厂商!', '消息提示');
					obj.val('');
					obj.parent().parent().find('input').val('');
					return false;
				}
				if (supno==majorSupNo) {
					top.jAlert('warning', '该供应商已选为商品主厂商,不能选为非主厂商!', '消息提示');
					return false;
				}

				$('.curig:first').find('.otherSup:first').val(supno);
				$('.curig:first').find('.otherSup:first').attr('preval2',supno);
				$('.curig:first').find('.otherSup:first').attr('othSupNo',supno);
				if ($('.curig:first').find('.comNo:first').length > 0) {
					$('.curig:first').find('.comNo:first').val(comNo);
				}
				$('.curig:first').find('.comName:first').val(supnm);
				$('.curig:first').children().removeClass('errorInput');
			}
		}

		closePopupWin();
	}

	$(function() {
		$('.sup_tr').each(function(){
			$(this).unbind("dblclick").bind("dblclick", function() {
				selectSupplier($(this));
			});
		});
		if (item_create_content == 5) {
			$('.sup_tr[supNo="' + $('.curig:first').find('.otherSup:first').val() + '"]').addClass(
			'btable_checked');
		}
		else{
			if ($('#majorSupNo').val() != '') {
				$('.sup_tr[supNo="' + $('#majorSupNo').val() + '"]').addClass(
						'btable_checked');
			}
		}
	});
</script>

<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<input type="hidden" name="pageSize" id="pageSize"
	value="${page.pageSize }" />

<div class="">
	<div class="search_tb_p">
		<div class="htable_div">
          <table>
             <thead>
                 <tr>
					<td><div class="t_cols align_center" style="width:60px;">厂商NO</div></td>
					<td><div class="t_cols" style="width:290px;">厂商名称</div></td>
					<td><div class="t_cols" style="width:290px;">厂商英文名称</div></td>
					<td><div style="width:16px;">&nbsp;</div></td>
				</tr>
          </thead>
  	 	 </table>
    	</div>
    	<div class="btable_div" style="height:280px;">
             <table  class="single_tb w100"><!--multi_tb为多选 width:1001px;-->
					<c:forEach items="${page.result }" var="supplier">
						<tr class='sup_tr' internalInd="${supplier.internalInd}" supNo="${supplier.supNo}" comNo="${supplier.comNo}" comName="${supplier.comName}" cntrtType="${supplier.cntrtType}">
							<td class="align_center" style="width:60px;text-align:right;">${supplier.supNo}&nbsp;&nbsp;</td>
							<td align="left" style="width:290px;">${supplier.comName}</td>
							<td align="left" style="width:290px;">${supplier.comEnName}</td>
							<td><div style="width:16px;">&nbsp;</div></td>
						</tr>
					</c:forEach>
             </table>    
         </div> 
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
	<div class="PanelBtn">
		<div onclick="selectSupplier($('tr.btable_checked'))" class="PanelBtn1">确定</div>
		<div onclick="closePopupWin()" class="PanelBtn2">取消</div>
	</div>
	</div>
</div>

