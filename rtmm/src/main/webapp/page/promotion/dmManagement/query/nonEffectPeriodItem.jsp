<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/iframeContent.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<script type="text/javascript">
$(function(){
	DispOrHid('B-id');
	$("#Tools11").removeClass("Tools11_disable");
	$("#Tools11").addClass("Icon-size1 Tools11");
	
	$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click", function() {
		DispOrHid('B-id');
	});
});
</script>
<style type="text/css">
      .ig {
          height: 30px;
          line-height: 25px;
      }
</style>
<%@ include file="/page/commons/toolbar.jsp"%>

<div class="CTitle">
     <!--第一个-->
     <div class="tags1_left tags1_left_on"></div>
     <!--最后一个-->
     <div class="tagsM tagsM_on">DM期数与商品-按门店查询</div>
     <div class="tags tags3_r_on"></div>
</div>

<div class="Container-1">
             <div class="Search Bar_on" ><!-- Bar_on-->
        <div class="SearchTop">
            <span>查询条件</span>
            <div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
        </div>
        <div class="SMiddle">
            <table class="SearchTable" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="ST_td1"><span>档期</span></td>
                    <td><input class="w65 inputText" type="text" /></td>
                </tr>
                <tr>
                    <td><span>主题</span></td>
                    <td><input class="w85 inputText" type="text" /></td>
                </tr>
                <tr>
                    <td><span>代号类别</span></td>
                    <td><select class="w85"><option></option></select></td>
                </tr>
                <tr>
                    <td><span>代号</span></td>
                    <td><div class="iconPut w65 fl_left">
                                <input type="text" class="w80" />
                                <div class="ListWin"></div>
                            </div>
                    </td>
                </tr>
                <tr>
                    <td><span>&nbsp;</span></td>
                    <td>
                        <input class="w85 inputText Black" type="text" />
                    </td>
                </tr>
                <tr>
                    <td><span>促销提出方</span></td>
                    <td><select class="w85"><option></option></select></td>
                </tr>
                <tr>
                    <td><span>店号</span></td>
                    <td><select class="w85"><option></option></select></td>
                </tr>
                
                <tr>
                    <td><span>DM状态</span></td>
                    <td><select class="w85"><option></option></select></td>
                </tr>
                <tr>
                    <td><span>组合促销</span></td>
                    <td><select class="w85"><option></option></select></td>
                </tr>
                <tr>
                    <td style="line-height:20px;"><span style="line-height:15px;">促销售价<br />起始日期</span></td>
                    <td><input type="text" class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true })"/>&nbsp;-
                    </td>
                </tr>
                <tr>
                    <td><span>&nbsp;</span></td>
                    <td><input type="text" class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true })"/>
                    </td>
                </tr>
                <tr>
                    <td><span>促销售价<br />结束日期</span></td>
                    <td><input type="text" class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true })"/>&nbsp;-
                    </td>
                </tr>
                <tr>
                    <td><span>&nbsp;</span></td>
                    <td><input type="text" class="Wdate w65" onclick="WdatePicker({ isShowClear: false, readOnly: true })"/></td>
                </tr>
                
            </table>
        </div>
        <div class="line"></div>
        <div class="SearchFooter">
            <div class="Icon-size1 Tools20"></div>
            <div class="Icon-size1 Tools6"></div>
        </div>
    </div>
    <div class="Content" style="width:74%;">
        <div class="ig">
            <input type="checkbox" />
            <span>只显示待跟进期数商品</span>
        </div>
        <div class="htable_div">
            <table>
                <thead>
                <tr>
                    <td><div class="t_cols align_center" style="width:30px;"><input type="checkbox" /></div></td>
                    <td><div class="t_cols align_center" style="width:70px;">档期<!--<div style="display:inline-block;width:10px;height:20px;"></div>--></div></td>
                    <td><div class="t_cols align_center" style="width:180px;">主题</div></td>
                    <td><div class="t_cols align_center" style="width:80px;">代号类别</div></td>
                    <td><div class="t_cols align_center" style="width:80px;">代号</div></td>
                    <td><div class="t_cols align_center" style="width:80px;">促销提出方</div></td>
                    <td><div class="t_cols align_center" style="width:100px;">店号</div></td>
                    
                    <td><div class="t_cols align_center" style="width:100px;">DM状态</div></td>
                    <td><div class="t_cols align_center" style="width:70px;">组合促销</div></td>
                    <td><div class="t_cols align_center" style="width:100px;">促销售价起始</div></td>
                    <td><div class="t_cols align_center" style="width:100px;">促销售价结束</div></td>
                    <td><div style="width:16px;">&nbsp;</div></td>
                </tr>
            </thead>
         </table>
        </div>
        <div class="btable_div" style="height:479px;">
            <table  class="single_tb w100"><!--multi_tb为多选 width:1001px;-->
                <tr>
                    <td class="align_center" style="width:30px;"><input type="checkbox" /></td>
                    <td style="width:71px;">123456</td>
                    <td style="width:181px;">世界杯</td>
                    <td style="width:81px;">XXXXX有限公司</td>
                    <td style="width:81px;">P&GXXXXX有限公司世界杯世界杯</td>
                    <td style="width:81px;">123456</td>
                    <td style="width:101px;">123456</td>
                    <td style="width:101px;">123456</td>
                    <td style="width:71px;">上档中</td>
                    <td style="width:101px;">123456</td>
                    <td style="width:101px;">123456</td>
                    <td style="width:auto">&nbsp;</td>
                </tr>
                <tr>
                    <td class="align_center"><input type="checkbox" /></td>
                    <td>123456</td>
                    <td>世界杯</td>
                    <td>XXXXX有限公司</td>
                    <td>P&GXXXXX有限公司世界杯世界杯</td>
                    <td>123456</td>
                    <td>123456</td>
                    <td>123456</td>
                    <td>上档中</td>
                    <td>上档中</td>
                    <td>上档中</td>
                    <td style="width:auto">&nbsp;</td>
                </tr>
                <tr>
                    <td class="align_center"><input type="checkbox" /></td>
                    <td>123456</td>
                    <td>世界杯</td>
                    <td>XXXXX有限公司</td>
                    <td>P&GXXXXX有限公司世界杯世界杯</td>
                    <td>123456</td>
                    <td>XXXXX有限公司</td>
                    <td>123456</td>
                    <td>上档中</td>
                    <td>上档中</td>
                    <td>上档中</td>
                    <td style="width:auto">&nbsp;</td>
                </tr>
            </table>    
        </div>
        <div class="paging">
         <div class="fl_left">
          第1-20项,共 5 项&nbsp;&nbsp;|&nbsp;每页显示 <select>
           <option value="10">10</option>
           <option value="20" selected="selected">20</option>
           <option value="30">30</option>
          </select> 项
         </div>
         <div class="fl_right page_list">
                <span class="fl_right" style="margin-right:10px;">&nbsp;&nbsp;&nbsp;到第 <input name="pageNo" id="goto_page" class="page_no_input" maxlength="5" type="text"/> 页 <input value="go"  type="button"/></span>
                    <a class="page_end_block" title="尾页"></a>
                    <a class="page_next_block" title="下一页"></a>
                    <a title="6" class="num">9</a>
                    <a style="cursor:default;">...</a>
                    <a title="2" class="num">3</a>
                    <a title="2" class="num">2</a>
                    <a title="1" class="num">1</a>
                    <a title="上一页" class="page_prev_block_off"></a>
                    <a title="首页" class="page_first_block_off"></a>  
         </div>
        </div>
    </div>
</div>