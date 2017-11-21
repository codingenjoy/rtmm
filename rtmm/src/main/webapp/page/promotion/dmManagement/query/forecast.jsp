<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <style type="text/css">
        .ig {
            height: 30px;
            line-height: 25px;
        }
        .fixed_htd1 {
            position:fixed;background:#f5f5f5;
        }
        .fixed_htd2 {
            position:fixed;background:#f5f5f5;margin-left:31px;
        }
        .fixed_htd3 {
            position:fixed;background:#f5f5f5;margin-left:102px;
        }
        .fixed_btd1 {
            width:30px;position:fixed;background:#fff;
        }
        .fixed_btd2 {
            width:71px;position:fixed;margin-left:30px;background:#fff;
        }
        .fixed_btd3 {
            width:181px;position:fixed;margin-left:101px;background:#fff;
        }
        .btable_div tr:hover .fixed_btd1,.btable_div tr:hover .fixed_btd2,.btable_div tr:hover .fixed_btd3{
        background: #99cc66;
        /*color: #fff;*/
        }
        .btable_checked .fixed_btd1,.btable_checked .fixed_btd2,.btable_checked .fixed_btd3{
        background: #3F9673;
        /*color: #fff;*/
        }
        .htable_div tr {
         line-height:normal; 
        }
        .fixed_btd1,.fixed_btd2,.fixed_btd3 {
            line-height:29px;
        }
    </style>
    
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
                <td><div class="iconPut w65 fl_left">
                            <input type="text" class="w80" />
                            <div class="Calendar"></div>
                        </div>&nbsp;-
                </td>
            </tr>
            <tr>
                <td><span>&nbsp;</span></td>
                <td><div class="iconPut w65 fl_left">
                            <input type="text" class="w80" />
                            <div class="Calendar"></div>
                        </div>
                </td>
            </tr>
            <tr>
                <td><span>促销售价<br />结束日期</span></td>
                <td><div class="iconPut w65 fl_left">
                            <input type="text" class="w80" />
                            <div class="Calendar"></div>
                        </div>&nbsp;-
                </td>
            </tr>
            <tr>
                <td><span>&nbsp;</span></td>
                <td><div class="iconPut w65 fl_left">
                            <input type="text" class="w80" />
                            <div class="Calendar"></div>
                        </div>
                </td>
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
        <div class="w25 fl_left">
            <div class="cinfo_div">店号</div>
            <select class="w80 top3"><option>102-上海中原店</option></select>
        </div>
        <input type="checkbox" />
        <span>已输入预估量</span>&nbsp;&nbsp;&nbsp;
        <input type="checkbox" />
        <span>未输入预估量</span>
    </div>
    <div class="htable_div">
        <table>
            <thead>
            <tr>
                <td class="fixed_htd1"><div class="t_cols align_center" style="width:30px;"><input type="checkbox" /></div></td>
                <td class="fixed_htd2"><div class="t_cols align_center" style="width:70px;">货号<!--<div style="display:inline-block;width:10px;height:20px;"></div>--></div></td>
                <td class="fixed_htd3"><div class="t_cols align_center" style="width:180px;">商品名称</div></td>
                <td><div style="width:283px;"></div></td>
                <td><div class="t_cols align_center" style="width:80px;">档期</div></td>
                <td><div class="t_cols align_center" style="width:80px;">代号类别</div></td>
                <td><div class="t_cols align_center" style="width:80px;">代号</div></td>
                <td><div class="t_cols align_center" style="width:100px;">促销售价起始</div></td>
                <td><div class="t_cols align_center" style="width:100px;">促销售价结束</div></td>
                <td><div class="t_cols align_center" style="width:70px;">促销售价（元）</div></td>
                <td><div class="t_cols align_center" style="width:100px;">供货量</div></td>
                <td><div class="t_cols align_center" style="width:100px;">总部预估量</div></td>
                <td><div class="t_cols align_center" style="width:100px;">门店预估量</div></td>
                <td><div class="t_cols align_center" style="width:100px;">陈列</div></td>
                <td><div style="width:16px;">&nbsp;</div></td>
            </tr>
        </thead>
     </table>
    </div>
    <div class="btable_div" style="height:479px;">
        <table  class="single_tb w100"><!--multi_tb为多选 width:1001px;-->
            <tr>
                <td class="align_center fixed_btd1" ><input type="checkbox" /></td>
                <td class="fixed_btd2" >123456</td>
                <td class="fixed_btd3" >P&GXXXXX有限公司世界杯世界杯</td>
                <td style="width:282px;">&nbsp;</td>
                <td style="width:81px;">XXXXX有限公司</td>
                <td style="width:81px;">P&GXXXXX有限公司世界杯世界杯</td>
                <td style="width:81px;">123456</td>
                <td style="width:101px;">123456</td>
                <td style="width:101px;">123456</td>
                <td style="width:71px;">上档中</td>
                <td style="width:101px;">123456</td>
                <td style="width:101px;">123456</td>
                <td style="width:101px;"><select class="w95"><option></option></select></td>
                <td style="width:101px;"><select class="w95"><option></option></select></td>
                <td style="width:auto">&nbsp;</td>
            </tr>
            <tr>
                <td class="align_center fixed_btd1" ><input type="checkbox" /></td>
                <td class="fixed_btd2" >123456</td>
                <td class="fixed_btd3" >P&GXXXXX有限公司世界杯世界杯</td>
                <td style="width:282px;">&nbsp;</td>
                <td style="width:81px;">XXXXX有限公司</td>
                <td style="width:81px;">P&GXXXXX有限公司世界杯世界杯</td>
                <td style="width:81px;">123456</td>
                <td style="width:101px;">123456</td>
                <td style="width:101px;">123456</td>
                <td style="width:71px;">上档中</td>
                <td style="width:101px;">123456</td>
                <td style="width:101px;">123456</td>
                <td style="width:101px;"><select class="w95"><option></option></select></td>
                <td style="width:101px;"><select class="w95"><option></option></select></td>
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
                <a title="6" class="num">999999</a>
                <a style="cursor:default;">...</a>
                <a title="2" class="num">3</a>
                <a title="2" class="num">2</a>
                <a title="1" class="num">1</a>
                <a title="上一页" class="page_prev_block_off"></a>
                <a title="首页" class="page_first_block_off"></a>  
     </div>
    </div>
</div>