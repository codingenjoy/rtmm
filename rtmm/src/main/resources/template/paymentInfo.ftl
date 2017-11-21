<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<#setting number_format="#">
<title>Goals And Competencies History</title>
<style type="text/css">
body {
	font-family:'Microsoft YaHei';
	color: #000;
	font-size: 14px;
}
.container {
	width: 730px;
	margin-right: auto;
	margin-left: auto;
}

div.header-left {
	display: none
}

div.header-right {
	display: none
}

div.footer-left {
	display: none;
	color: #000;
	font-size: 8px;
	margin-left: 20px;
}

div.footer-right {
	display: none;
	color: #000;
	font-size: 8px;
	margin-right: 20px;
	margin-top: 25px;
}

@page {
	width: 730px;
	margin-right: auto;
	margin-left: auto;
	margin: 0.65in;
	@top-left{
		content:element(header-left)
	};
	@top-right {
		content: element(header-right)
	};
	@bottom-left {
		content: element(footer-left)
	};
	@bottom-right {
		content: element(footer-right)
	};
}
#pagenumber:before {
	content: counter(page);
}

#pagecount:before {
	content: counter(pages);
}

@media print {
	div.header-left {
		display: block;
		position: running(header-left);
	}
	div.header-right {
		display: block;
		position: running(header-right);
	}
	div.footer-left {
		display: block;
		position: running(footer-left);
		left: 500px;
	}
	div.footer-right {
		display: block;
		position: running(footer-right);
		right: 500px;
	}
}
table {
    border:1px solid #000;
}
.rh {
    border-right:3px solid #000;
}
td ,th{
    border:1px solid #000;height:40px;
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
    border:0px solid #000;
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
</style>
</head>
<body style="font-family: Microsoft YaHei; color: #000; margin: 0px; padding: 0px;">
	<div id="header-left" class="header-left" align="center">ACCOUNTING INFORMATION FORM 财务信息表</div>
	<div id="header-right" class="header-right" align="right">Task No.${taskId}</div>
	<div id="footer-left" class="footer-left" align="left">
		Auchan Confidential <span style="margin-left: 200px;">Print Date - ${printDate}</span>
	</div>
	<div id="footer-right" class="footer-right" align="right">
		Page <span id="pagenumber" /> of <span id="pagecount" />
	</div>
	<div class="container" style="width: 660px; margin-right: auto; margin-left: auto;">
		<div class="title">ACCOUNTING INFORMATION FORM 财务信息表</div>
		<div class="tb">
	        <table  cellspacing="0" cellpadding="0" class="wh100">
	            <tr>
	                <td class="w80 bg">
	                    <div>NEW</div>
	                    <div>新建</div>
	                </td>
	                <#if taskType=1>
	                <td class="w80 fh">●</td>
	                <#else>
	                <td class="w80 fh"></td>
	                </#if> 
	                <td class="w80 bg"><div>UPDATE</div>
	                    <div>更新</div></td>
	                <#if taskType=2>
	                <td class="w80 fh">●</td>
	                <#else>
	                <td class="w80 fh"></td>
	                </#if> 
	                <td class="w125 bg">
	                    <div>SUPPLIER NO.</div><div>供应商编号</div>
	                </td>
	                <td class="w125">
	                ${supNo}
	                </td>
	                <td class="w80 bg">
	                    <div>DIVISION</div><div>处别</div>
	                </td>
	                <td  class="w80"></td>
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
	                <td colspan="3">${comName}</td>
	            </tr>
	            <tr>
	                <td colspan="2" class="bg"><div>TAXES REGISTRATION NUMBER</div><div>税务登记号</div></td>
	                <td colspan="3">${unifmNo}</td>
	            </tr>
	            <tr>
	                <td class="bg"><div>INVOICE ADDRESS</div><div>发票地址</div></td>
	                <td colspan="2">${dlvryAddrDetllAddr}</td>
	                <td class="bg"><div>POSTAL CODE</div><div>邮编</div></td>
	                <td>${dlvryAddrPostCode}</td>
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
	                <td colspan="2" class="bg"><div>RETURN</div><div>退货回传</div></td>
	                <td colspan="2"></td>
	            </tr>
	            <tr>
	                <td class="bg"><div>BILLING BATCT</div><div>付款批次</div></td>
	                <td colspan="2"></td>
	                <td colspan="2" class="bg"><div>RETURN POSTING</div><div>退货过账</div></td>
	                <td colspan="2"></td>
	            </tr>
	            <tr>
	                <td class="bg"><div>PAYMENT PERIOD</div><div>付款周期</div></td>
	                <td colspan="2"></td>
	                <td colspan="2" class="bg"><div>CLAIMS STATUS</div><div>债权状态</div></td>
	                <td colspan="2"></td>
	            </tr>
	            <tr>
	                <td colspan="2" class="bg"><div>OUTGOING INVOICING ARTIFICIALLY</div><div>人工销项发票并立</div></td>
	                <td colspan="2"></td>
	                <td colspan="2" class="bg"><div>E-INVOICE</div><div>电子发票</div></td>
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
	            <col style="width:55px;"/>
	            <col style="width:160px;"/>
	            <col style="width:180px;"/>
	            <tbody>
	            <tr>
	                <td rowspan="2" class="bg"><div>BANK NAME</div><div>银行名称</div></td>
	                <td class="bg"><div>HEAD OFFICE</div><div>总行</div></td>
	                <td colspan="3"></td>
	            </tr>
	            <tr>
	                <td class="bg"><div>BRANCH OFFICE</div><div>支行</div></td>
	                <td colspan="3"></td>
	            </tr>
	            <tr>
	                <td class="bg"><div>ACCOUNT NO.</div><div>银行账号</div></td>
	                <td colspan="2"></td>
	                <td class="bg"><div>LARGE PAYMENT NO.</div><div>大额支付号</div></td>
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
                    <td class="bg"><div>Assistant Of Buyer</div></td>
                    <td></td>
                    <td class="rh"></td>
                    <td class="bg"><div>RTS Assistant</div></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="bg"><div>Buyer</div></td>
                    <td></td>
                    <td class="rh"></td>
                    <td class="bg"><div>Control</div></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="bg"><div>Quality Manager</div></td>
                    <td></td>
                    <td></td>
                    <td class="bg"><div>Account</div></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="bg"><div>Head Buyer</div></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </table>
        </div>
	</div>
</body>
</html>
