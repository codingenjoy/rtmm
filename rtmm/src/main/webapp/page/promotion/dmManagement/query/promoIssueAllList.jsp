 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ include file="/page/commons/taglibs.jsp"%>
 <script type="text/javascript">
<!--

//-->
$(".btable_div tr").hover(
	function () {
		$(this).addClass("btable_hover");
	},
	function () {
		$(this).removeClass("btable_hover");
	  }
);
$(".btable_div").scroll(function () {
    var left = $(this).scrollLeft();
    $(".htable_div").scrollLeft(left);
});



</script>
 <div class="htable_div">
     <table>
         <thead>
         <tr>
             <td><div class="t_cols align_center" style="width:30px;">&nbsp;</div></td>
             <td><div class="t_cols align_center" style="width:90px;">档期</div></td>
             <td><div class="t_cols align_center" style="width:290px;">主题</div></td>
             <td><div class="t_cols align_center" style="width:100px;">开始日</div></td>
             <td><div class="t_cols align_center" style="width:100px;">结束日</div></td>
             <td><div class="t_cols align_center" style="width:100px;">计划起日</div></td>
             <td><div class="t_cols align_center" style="width:100px;">计划迄日</div></td>
             <td><div class="t_cols align_center" style="width:70px;">门店</div></td>
             <td><div class="t_cols align_center" style="width:70px;">上档中</div></td>
             <td><div class="t_cols align_center" style="width:60px;">排档方</div></td>
             <td><div style="width:16px;">&nbsp;</div></td>
         </tr>
     </thead>
  </table>
 </div>
 <c:if test="${ not empty page.result}">
 <div class="btable_div" style="height:509px;">
     <table  class="single_tb w100">
     	
		      <c:forEach items="${promThemeVOList}" var="promThemeVO">
			         <tr style="color:#ff6a00">
			             <td class="align_center tr_close" style="width:30px;"></td>
			             <td style="width:91px;">${promThemeVO.promNo }</td>
			             <td style="width:291px;">${promThemeVO.subjName }</td>
			             <td style="width:101px;"><fmt:formatDate pattern="yyyy-MM-dd" value="${promThemeVO.promBeginDate }"/></td>
			             <td style="width:101px;"><fmt:formatDate pattern="yyyy-MM-dd" value="${promThemeVO.buyBeginDate }"/></td>
			             <td style="width:101px;"><fmt:formatDate pattern="yyyy-MM-dd" value="${promThemeVO.dmPlanBeginDate }"/></td>
			             <td style="width:101px;"><fmt:formatDate pattern="yyyy-MM-dd" value="${promThemeVO.dmPriceAvailDate }"/></td>
			             <td style="width:71px;">${promThemeVO.storeName}</td>
			             <td style="width:41px;">${promThemeVO.promNo}</td>
			             <td style="width:61px;">全国DM</td>
			             <td style="width:auto">&nbsp;</td>
			         </tr>
		         </c:forEach>
		 	
         <!-- <tr class="trSpecial Bar_off" style="height:auto;">
             <td class="align_center" style="width:30px;"></td>
             <td colspan="9" style="white-space:normal;">
                 <div class="htable_div" style="height:30px;">
                     <table>
                         <thead>
                         <tr style="background:none;color:#333;">
                             <td><div class="t_cols  align_center" style="width:70px;">编号<div style="display:inline-block;width:10px;height:20px;"></div></div></td>
                             <td><div class="t_cols  align_center" style="width:232px;">主题</div></td>
                             <td><div class="t_cols  align_center" style="width:80px;">渠道</div></td>
                             <td><div class="t_cols  align_center" style="width:262px;">参与组别</div></td>
                             <td><div style="width:16px;">&nbsp;</div></td>
                         </tr>
                     </thead>
                  </table>
                 </div>
                 <div class="btable_div" style="height:60px;overflow:auto;">
                     <table width="100%">
                         <tr>
                             <td style="width:71px;">data1</td>
                             <td style="width:233px;">data2</td>
                             <td style="width:81px;">data3</td>
                             <td style="width:263px;">data4</td>
                             <td style="width:auto;">&nbsp;</td>
                         </tr>
                         <tr>
                             <td>data1</td>
                             <td>data2</td>
                             <td>data3</td>
                             <td>data4</td>
                             <td style="width:auto;">&nbsp;</td>
                         </tr>
                     </table>
                 </div>
             </td>
         </tr> -->
         
         <!-- <tr>
             <td class="align_center tr_open"></td>
             <td>123456</td>
             <td>世界杯</td>
             <td>XXXXX有限公司</td>
             <td>P&GXXXXX有限公司世界杯世界杯</td>
             <td>123456</td>
             <td>XXXXX有限公司</td>
             <td>123456</td>
             <td>上档中</td>
             <td>上档方</td>
             <td style="width:auto">&nbsp;</td>
         </tr>
         <tr class="trSpecial">
             <td class="align_center" style="width:30px;"></td>
             <td colspan="9" >厂商名称输入有误。厂商合同标准与失效日期错误。门店课别信息中的采购范围输入有误。其他信息有误。</td>
         </tr>
         <tr>
             <td class="align_center tr_open"></td>
             <td>123456</td>
             <td>世界杯</td>
             <td>XXXXX有限公司</td>
             <td>P&GXXXXX有限公司世界杯世界杯</td>
             <td>123456</td>
             <td>XXXXX有限公司</td>
             <td>123456</td>
             <td>上档中</td>
             <td>上档方</td>
             <td style="width:auto">&nbsp;</td>
         </tr> -->
     </table>    
 </div>

 <jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
 </c:if>
 