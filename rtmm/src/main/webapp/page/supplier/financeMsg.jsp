<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
    <style type="text/css">
        body {
            width:757px; font-family:'Microsoft YaHei';font-size:14px;font-weight:600;margin:0 auto;
        }
        table {
            border:1px solid #000;
        }
        .rh {
            border-right:3px solid #000;
        }
        td ,th{
            border:1px solid #000;height:50px;
        }
        th {
            border-bottom:3px solid #000;
        }
            td div{
                font-weight:500;width:99%;
            }
        th span {
             font-weight:500;color:#bdb8b8;
        }
        .wh100 {
            width:100%;
            height:100%;
        }
        .w80 {
            width:80px;
        }
        .w125 {
            width:125px;
        }
        .head {
            height:30px;
        }
        .h1,.h2{
            line-height:30px;
        }
        .h1 {
            float:left;
        }
        .h2 {
            float:right;
        }
        .title {font-size:16px;text-align:center;}
        .zs {
            color:#bdb8b8;font-weight:400;font-size:12px;
        }
        .tb {
            border:3px solid #000;
        }
        .foot {
            text-align:center;margin-top:30px;
        }
        .f1 {
            float:left;
        }
        .f2 ,.f3{font-weight:normal;}
        .f3 {
            float:right;
        }
        .tb2, .tb3, .tb4, .tb5,.title {
            margin-top:30px;margin-bottom:5px;
        }
        .bg {
            background: #f5f5f5;
        }
        .djx {
            background:url(images/djx.png) 0 0;
        }
        .fh {
            text-align:center;font-size:30px;
        }
        /*.tb2 {
            margin-top:30px;
        }
        .tb3 {
            margin-top:30px;
        }
        .tb4 {
            margin-top:30px;
        }
        .tb5 {
            margin-top:30px;
        }*/
    </style>
    <div class="head">
        <span class="h1">ACCOUNTING INFORMATION FORM 财务信息表</span>
        <span class="h2">Task No. 201404280001</span>
    </div>
    <div class="title">ACCOUNTING INFORMATION FORM 财务信息表</div>

    <div class="tb">
        <table  cellspacing="0" cellpadding="0" class="wh100">
            <tr>
                <td class="w80 bg">
                    <div>NEW</div>
                    <div>新建</div>
                </td>
                <td class="w80 fh">●</td>
                <td class="w80 bg"><div>UPDATE</div>
                    <div>更新</div></td>
                <td  class="w80 fh">○</td>
                <td class="w125 bg">
                    <div>SUPPLIER NO.</div><div>供应商编号</div>
                </td>
                <td class="w125">&nbsp;</td>
                <td class="w80 bg">
                    <div>DIVISION</div><div>处别</div>
                </td>
                <td  class="w80">&nbsp;</td>
            </tr>
        </table>
    </div>
    <div class="zs">* “●”表示选中项，“○”表示未选中项</div>
    <div class="tb2">COMPANY INFORMATION 公司信息</div>
    <div class="tb">
       <table  cellspacing="0" cellpadding="0" class="wh100">
            <col style="width: 150px;" />
            <col style="width: 75px;" />
            <col style="width: auto" />
            <col style="width: 150px;" />
            <col style="width: 80px;" />
        <tbody>
            <tr>
                <td colspan="2" class="bg"><div>CORPORATE NAME</div><div>公司注册名称</div></td>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td colspan="2" class="bg"><div>TAXES REGISTRATION NUMBER</div><div>税务登记号</div></td>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td class="bg"><div>INVOICE ADDRESS</div><div>发票地址</div></td>
                <td colspan="2"></td>
                <td class="bg"><div>POSTAL CODE</div><div>邮编</div></td>
                <td></td>
            </tr>
        </tbody>
        </table>
    </div>
    <div class="tb3">PAYMENT INFORMATION 付款信息</div>
    <div class="tb">
        <table  cellspacing="0" cellpadding="0" class="wh100">
            <col style="width:150px;"/>
            <col style="width:150px;"/>
            <col style="width:75px;"/>
            <col style="width:75px;"/>
            <col style="width:75px;"/>
            <col style="width:75px;"/>
            <col style="width:150px;"/>
            <tbody>
            <tr>
                <td class="bg"><div>PAYMENT MODE</div><div>付款方式</div></td>
                <td colspan="2"></td>
                <td colspan="2" class="bg"><div>PAYMENT MODE</div><div>付款方式</div></td>
                <td colspan="2">c</td>
            </tr>
            <tr>
                <td class="bg"><div>PAYMENT MODE</div><div>付款方式</div></td>
                <td colspan="2">c</td>
                <td colspan="2" class="bg"><div>PAYMENT MODE</div><div>付款方式</div></td>
                <td colspan="2">c</td>
            </tr>
            <tr>
                <td class="bg"><div>PAYMENT MODE</div><div>付款方式</div></td>
                <td colspan="2">c</td>
                <td colspan="2" class="bg"><div>PAYMENT MODE</div><div>付款方式</div></td>
                <td colspan="2">c</td>
            </tr>
            <tr>
                <td colspan="2" class="bg"><div>PAYMENT MODE</div><div>付款方式</div></td>
                <td colspan="2"></td>
                <td colspan="2" class="bg"><div>PAYMENT MODE</div><div>付款方式</div></td>
                <td></td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="tb4 bg">BANK INFORMATION 银行信息</div>
    <div class="tb">
        <table  cellspacing="0" cellpadding="0" class="wh100">
            <col style="width:120px;"/>
            <col style="width:150px;"/>
            <col style="width:75px;"/>
            <col style="width:120px;"/>
            <col style="width:200px;"/>
            <tbody>
            <tr>
                <td></td>
                <td></td>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td class="bg"><div>ACCOUNT NO.</div><div>银行账号</div></td>
                <td colspan="2"></td>
                <td class="bg"><div>ACCOUNT NO.</div><div>银行账号</div></td>
                <td></td>
            </tr>
            </tbody>
        </table>
        </div>
        <div class="tb5">CONFIRMED BY 签字</div>
        <div class="tb">
            <table cellspacing="0" cellpadding="0" class="wh100">
                <col style="width:150px;"/>
                <col style="width:150px;"/>
                <col style="width:75px;"/>
                <col style="width:150px;"/>
                <col style="width:150px;"/>
                <col style="width:75px;"/>
                <tr>
                    <th class="djx"></th>
                    <th  class="bg"><span>Signature</span></th>
                    <th class="rh bg"><span>Validation Date</span></th>
                    <th></th>
                    <th  class="bg"><span>Signature</span></th>
                    <th  class="bg"><span>Validation Date</span></th>
                </tr>
                <tr>
                    <td><div>Assistant Of Buyer</div></td>
                    <td></td>
                    <td class="rh"></td>
                    <td><div>Assistant Of Buyer</div></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="bg"><div>Assistant Of Buyer</div></td>
                    <td></td>
                    <td class="rh"></td>
                    <td class="bg"><div>Assistant Of Buyer</div></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="bg"><div>Assistant Of Buyer</div></td>
                    <td></td>
                    <td class="rh"></td>
                    <td class="bg"><div>Assistant Of Buyer</div></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="bg"><div>Assistant Of Buyer</div></td>
                    <td></td>
                    <td class="rh"></td>
                    <td class="bg"><div>Assistant Of Buyer</div></td>
                    <td></td>
                    <td></td>
                </tr>
            </table>
        </div>
    <div class="foot">
        <span class="f1">Auchan Confidential</span>
        <span class="f2">Print Date - 4/29/2014</span>
        <span class="f3">Page 1 of 1</span>
    </div>