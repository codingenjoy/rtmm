<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<#setting number_format="#">
<title>Goals And Competencies History</title>
<style type="text/css">
body {
	font-family:'Microsoft YaHei';
	color: #000;
	font-size: 9px;
}
.container {
	width: 730px;
	margin-right: auto;
	margin-left: auto;
}

div.header-left {
	display: none
}
div.header-center {
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
	@top-center{
		content:element(header-center)
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
	div.header-center {
		display: block;
		position: running(header-center);
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
/*.rh {
    border-right:1px solid #000;
}*/
td ,th{
    border:1px solid #000;height:25px;
}
th {
    border-bottom:1px solid #000;
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
    height:30px;font-weight: normal;
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
.title {font-size:10px;text-align:center;}
.zs {
    color:#bdb8b8;font-weight:400;font-size:6px;
}
.tb {
    border:1px solid #000;
}
.foot {
    text-align:center;margin-top:20px;
}
.f1 {
    float:left;
}
.f2 ,.f3{font-weight:normal;}
.f3 {
    float:right;
}
.tb2, .tb3, .tb4, .tb5,.title {
    margin-top:12px;margin-bottom:5px;
}
.bg {
    background-color: #f5f5f5;
}
.djx {
    background-image:url(../images/djx2.png);
}
.fh {
    text-align:center;font-size:30px;
}
.textCenter {
    text-align:center;
}
.theight {
    height:22px;
    text-align:left;
    font-weight:normal;
    font-style:italic;
    background: #f5f5f5;
}
</style>
</head>
<#if (catalogList?size > 0)>
 <#list catalogList as catalog>
<body style="font-family: Microsoft YaHei; color: #000; margin: 0px; padding: 0px;">
    <div id="header-left" class="header-left" align="left">Task No. ${taskId}</div>
	<div id="header-center" class="header-center" align="center">SUPPLIER INFORMATION FORM 供应商信息表</div>
	<div id="header-right" class="header-right" align="right">Print No. ${printId}</div>
	<div id="footer-left" class="footer-left" align="left">
		Auchan Confidential <span style="margin-left: 200px;">Print Date - ${printDate}</span>
	</div>
	<div id="footer-right" class="footer-right" align="right">
		Page <span id="pagenumber" /> of <span id="pagecount" />
	</div>
	<div class="container" style="width: 660px; margin-right: auto; margin-left: auto;">
    <div class="title">SUPPLIER INFORMATION FORM 供应商信息表</div>

    <div class="tb">
        <table  cellspacing="0" cellpadding="0" class="wh100">
            <tr>
                <td class="w80 bg">
                    <div>NEW</div>
                    <div>新建</div>
                </td>
                	<#if taskType=1>
	                <td class="w80 fh" style="font-size:7px;">●</td>
	                <#else>
	                <td class="w80 fh"></td>
	                </#if> 
                <td class="w80 bg"><div>UPDATE</div>
                    <div>更新</div></td>
                	<#if taskType=2>
	                <td class="w80 fh " style="font-size:7px;">●</td>
	                <#else>
	                <td class="w80 fh"></td>
	                </#if> 
                <td class="w125 bg">
                    <div>SUPPLIER NO.</div><div>供应商编号</div>
                </td>
                <td class="w125"><div>${supNo}</div></td>
                <td class="w80 bg">
                    <div>DIVISION</div><div>处别</div>
                </td>
                <td  class="w80"></td>
            </tr>
        </table>
    </div>
    <div class="zs">* “●”表示选中项，“○”表示未选中项</div>
    <div class="tb2">■MASTER INFORMATION 主信息</div>
    <div class="tb">
       <table  cellspacing="0" cellpadding="0" class="wh100">
           <col style="width: 88px;" />
           <col style="width: 48px;" />
           <col style="width: 68px;" />
           <col style="width: 120px;" />
           <col style="width: 68px;" />
           <col style="width: 68px;" />
           <col style="width: 68px;" />
           <col style="width: 68px;" />
           <col style="width: auto" />
        <tbody>
            <tr>
                <th colspan="9" class="theight">Corporate Information 公司信息</th>
            </tr>
            <tr>
                <td colspan="3" class="bg"><div>CORPORATE NAME</div><div>公司注册名称</div></td>
                <td colspan="6">
                <#if comName??>
                ${comName}
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="bg"><div>TAXES REGISTRATION NUMBER</div><div>税务登记号</div></td>
                <td colspan="6">
                 <#if unifmNo??>
                ${unifmNo}
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="bg"><div>INVOICE ADDRESS</div><div>发票地址</div></td>
                <td colspan="4">
                <#if dlvryAddrDetllAddr??>
                ${dlvryAddrDetllAddr}
                </#if>
                </td>
                <td colspan="2" class="bg"><div>POSTAL CODE</div><div>邮编</div></td>
                <td>
                <#if dlvryAddrPostCode??>
                ${dlvryAddrPostCode}
                </#if>
                </td>
            </tr>
            <tr>
                <th colspan="9" class="theight btop">Supplier Information 厂商信息</th>
            </tr>
            <tr>
                <td class="bg"><div>SORT</div><div>种类</div></td>
                <td colspan="2">
                <#if supType??>
                ${supType}
                </#if></td>
                <td class="bg"><div>SUPPLY MODE</div><div>供货方式</div></td>
                <td>
                <#if dlvryMethd??>
                ${dlvryMethd}
                </#if>
                </td>
                <td colspan="2" class="bg"><div>FIRST ORDER QTY</div><div>首订单量</div></td>
                <td colspan="2">
                <#if firstOrdQty??>
                ${firstOrdQty}
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="bg"><div>CHARACTER OF GOODS</div><div>商品特性</div></td>
                <td colspan="2"></td>
                <td colspan="2" class="bg"><div>TXT SUPPLIER NO.</div><div>TXT厂编</div></td>
                <td colspan="2">
                <#if txtSup??>
                ${txtSup}
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="bg"><div>CONTRACT STANDARD</div><div>合同标准</div></td>
                <td colspan="2">
                <#if cntrtType??>
                ${cntrtType}
                </#if>
                </td>
                <td colspan="2" class="bg"><div>EXPIRY DATE</div><div>失效日期</div></td>
                <td colspan="2">
                <#if validEndDate??>
                ${validEndDate}
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="bg"><div>ORDER DELIVERY MODE</div><div>订单发送方式</div></td>
                <td colspan="2">
                <#if ordAccptMethd??>
                ${ordAccptMethd}
                </#if>
                </td>
                <td colspan="2" class="bg"><div>ONLINE ACCOUNT LV.</div><div>网上对账级别</div></td>
                <td colspan="2">
                <#if scmLvl??>
                ${scmLvl}
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="bg"><div>SUPPLIER ADDRESS</div><div>厂商联系地址</div></td>
                <td colspan="4">
                <#if supAddrDetallAddr??>
                ${supAddrDetallAddr}
                </#if>
                </td>
                <td colspan="2" class="bg"><div>POSTAL CODE</div><div>邮编</div></td>
                <td>
                <#if supAddrPostCode??>
                ${supAddrPostCode}
                </#if>
                </td>
            </tr>
            <tr>
                <td class="bg" ><div>CONTACT</div><div>联络人</div></td>
                <td colspan="3">
                <#if supAddrCntctName??>
                ${supAddrCntctName}
                </#if>
                </td>
                <td class="bg"><div>MOBILE</div><div>移动</div></td>
                <td colspan="4">
                <#if supAddrMoblNo??>
                ${supAddrMoblNo}
                </#if>
                </td>
            </tr>
        </tbody>
        </table>
    </div>

    <div class="tb3">INFORMATION BY SECTION 分店课别信息</div>
    <div class="tb">
       <table  cellspacing="0" cellpadding="0" class="wh100">
           <col style="width: 75px;" />
           <col style="width: 55px;" />
           <col style="width: 65px;" />
           <col style="width: 65px;" />
           <col style="width: 65px;" />
           <col style="width: 65px;" />
           <col style="width: 65px;" />
           <col style="width: 65px;" />
           <col style="width: 65px;" />
           <col style="width: auto" />
        <tbody>
            <tr>
                <td class="bg"><div>SECTION</div><div>课别</div></td>
                <td colspan="9">
                <#if catalog.catlgId?? && catalog.catlgName??>
                ${catalog.catlgId}-${catalog.catlgName}
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="bg"><div>PROCUREMENT SCOPE</div><div>采购范围</div></td>
                <td colspan="4">
                <#if catalog.ordScope??>
                ${catalog.ordScope}
                </#if>
                </td>
                <td class="bg"><div>MEMO</div><div>备注</div></td>
                <td colspan="2">
                <#if catalog.buyrMemo??>
                ${catalog.buyrMemo}
                </#if>
                </td>
            </tr>
            <tr>
                <td class="bg"><div>ST NO.</div><div>分店号</div></td>
                <td colspan="9" style="height:100px;">
                <#if catalog.storeNoAndName??>
                ${catalog.storeNoAndName}
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="bg"><div>ST SECTION STATUS</div><div>门店课别状态</div></td>
                <td colspan="3">
                <#if catalog.secStatus??>
                ${catalog.secStatus}
                </#if>
                </td>
                <td colspan="2" class="bg"><div>MOC</div><div>最低订购</div></td>
                <td colspan="3">
                <#if catalog.minOrdAmt??>
                ${catalog.minOrdAmt}
                </#if>
                
                </td>
            </tr>
            <tr>
                <td colspan="2" class="bg"><div>PREPARATION DAYS</div><div>准备天数</div></td>
                <td colspan="3">
                <#if catalog.leadTime??>
                ${catalog.leadTime}
                </#if>
                </td>
                <td colspan="2" class="bg"><div>RETURN GOODS</div><div>可否退货（Y/N）</div></td>
                <td colspan="3">
                <#if catalog.rtnAllow??>
                <#if catalog.rtnAllow=0>
                 N
                <#else>
                 Y
                </#if>
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="djx bg"></td>
                <td class="bg textCenter"><div>MON.</div><div>周一</div></td>
                <td class="bg textCenter"><div>TUES.</div><div>周二</div></td>
                <td class="bg textCenter"><div>WED.</div><div>周三</div></td>
                <td class="bg textCenter"><div>THUR.</div><div>周四</div></td>
                <td class="bg textCenter"><div>FRI.</div><div>周五</div></td>
                <td class="bg textCenter"><div>SAT.</div><div>周六</div></td>
                <td class="bg textCenter"><div>SUN.</div><div>周日</div></td>
            </tr>
            <tr>
                <td colspan="3" class="bg"><div>OPL DAY</div><div>OPL订货行程</div></td>
                  <td class="textCenter"><div>
                 <#if catalog.oplSched[0]='1'>
                 √
                </#if>
                 </div></td>
                  <td class="textCenter"><div>
                 <#if catalog.oplSched[1]='1'>
                 √
                </#if>
                </div></td>
                 <td class="textCenter"><div>
                 <#if catalog.oplSched[2]='1'>
                 √
                </#if>
                </div></td>
                <td class="textCenter"><div>
                 <#if catalog.oplSched[3]='1'>
                 √
                </#if>
                </div></td>
                 <td class="textCenter"><div>
                 <#if catalog.oplSched[4]='1'>
                 √
                </#if>
                </div></td>
                 <td class="textCenter"><div>
                 <#if catalog.oplSched[5]='1'>
                 √
                </#if>
                </div></td>
                 <td class="textCenter"><div>
                 <#if catalog.dlvrySched[6]='1'>
                 √
                </#if>
                </div></td>
            </tr>
            <tr>
                <td colspan="3" class="bg"><div>DELIVERY DAY</div><div>送货行程</div></td>
                <td class="textCenter"><div>
                 <#if catalog.dlvrySched[0]='1'>
                 √
                </#if>
                </div></td>
                <td class="textCenter"><div>
                 <#if catalog.dlvrySched[1]='1'>
                 √
                </#if>
                </div></td>
                <td class="textCenter"><div>
                 <#if catalog.dlvrySched[2]='1'>
                 √
                </#if>
                </div></td>
                <td class="textCenter"><div>
                 <#if catalog.dlvrySched[3]='1'>
                 √
                </#if>
                </div></td>
                <td class="textCenter"><div>
                 <#if catalog.dlvrySched[4]='1'>
                 √
                </#if>
                </div></td>
                <td class="textCenter"><div>
                 <#if catalog.dlvrySched[5]='1'>
                 √
                </#if>
                </div></td>
                <td class="textCenter"><div>
                 <#if catalog.dlvrySched[6]='1'>
                 √
                </#if>
                </div></td>
            </tr>
            <tr>
                <td colspan="2" class="bg"><div>ORDER ADDRESS</div><div>订货地址</div></td>
                <td colspan="5">
                <#if catalog.supOrdAddr.provName?? && catalog.supOrdAddr.cityName?? && catalog.supOrdAddr.detllAddr??>
                ${catalog.supOrdAddr.provName}${catalog.supOrdAddr.cityName}${catalog.supOrdAddr.detllAddr}
                </#if>
                </td>
                <td colspan="2" class="bg"><div>POSTAL CODE</div><div>邮编</div></td>
                <td>
                <#if catalog.supOrdAddr.postCode??>
                ${catalog.supOrdAddr.postCode}
                </#if>
                </td>
            </tr>
            <tr>
                <td class="bg"><div>CONTACT</div><div>联络人</div></td>
                <td colspan="4">
                <#if catalog.supOrdAddr.cntctName??>
                ${catalog.supOrdAddr.cntctName}
                </#if>
                </td>
                <td class="bg"><div>MOBILE</div><div>移动</div></td>
                <td colspan="4">
                <#if catalog.supOrdAddr.moblNo??>
                ${catalog.supOrdAddr.moblNo}
                </#if>
                </td>
            </tr>
            <tr>
                <td class="bg"><div>TEL.</div><div>固话</div></td>
                <td colspan="2">
                <#if catalog.supOrdAddr.phoneNo??>
                ${catalog.supOrdAddr.phoneNo}
                </#if>
                </td>
                <td class="bg"><div>FAX</div><div>传真</div></td>
                <td colspan="2">
                <#if catalog.supOrdAddr.faxNo??>
                ${catalog.supOrdAddr.faxNo}
                </#if>
                </td>
                <td class="bg"><div>EMAIL</div><div>电邮</div></td>
                <td colspan="3">
                <#if catalog.supOrdAddr.emailAddr??>
                ${catalog.supOrdAddr.emailAddr}
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="bg"><div>RETURN ADDRESS</div><div>退货地址</div></td>
                <td colspan="5">
                <#if catalog.supOrdAddr.provName?? && catalog.supOrdAddr.cityName?? && catalog.supOrdAddr.detllAddr??>
                ${catalog.supOrdAddr.provName}${catalog.supOrdAddr.cityName}${catalog.supOrdAddr.detllAddr}
                </#if>
                </td>
                <td colspan="2" class="bg"><div>POSTAL CODE</div><div>邮编</div></td>
                <td>
                <#if catalog.supOrdAddr.postCode??>
                ${catalog.supOrdAddr.postCode}
                </#if>
                </td>
            </tr>
            <tr>
                <td class="bg"><div>CONTACT</div><div>联络人</div></td>
                <td colspan="4">
                <#if catalog.supOrdAddr.cntctName??>
                ${catalog.supOrdAddr.cntctName}
                </#if>
                </td>
                <td class="bg"><div>MOBILE</div><div>移动</div></td>
                <td colspan="4">
                <#if catalog.supOrdAddr.moblNo??>
                ${catalog.supOrdAddr.moblNo}
                </#if>
                </td>
            </tr>
            <tr>
                <td class="bg"><div>TEL.</div><div>固话</div></td>
                <td colspan="2">
                <#if catalog.supOrdAddr.phoneNo??>
                ${catalog.supOrdAddr.phoneNo}
                </#if>
                </td>
                <td class="bg"><div>FAX</div><div>传真</div></td>
                <td colspan="2">                
                <#if catalog.supOrdAddr.faxNo??>
                ${catalog.supOrdAddr.faxNo}
                </#if>
                </td>
                <td class="bg"><div>EMAIL</div><div>电邮</div></td>
                <td colspan="3">                
                <#if catalog.supOrdAddr.emailAddr??>
                ${catalog.supOrdAddr.emailAddr}
                </#if>
                </td>
            </tr>
        </tbody>
        </table>
    </div>

    <div class="tb4">CONFIRMED BY 签字</div>
    <div class="tb">
        <table  cellspacing="0" cellpadding="0" class="wh100">
            <col style="width:150px;"/>
            <col style="width:auto;"/>
            <col style="width:140px;"/>
            <col style="width:170px;"/>
            <tbody>
            <tr>
                <td class="bg"><div>BUYER ASSISTANT</div></td>
                <td></td>
                <td class="bg"><div>LOGISTICS MANAGER</div></td>
                <td></td>
            </tr>
            <tr>
                <td class="bg"><div>BUYER</div></td>
                <td></td>
                <td class="bg"><div>CONTRACT</div></td>
                <td></td>
            </tr>
            <tr>
                <td class="bg"><div>HEAD BUYER</div></td>
                <td></td>
                <td class="bg"><div>CATALOGUE</div></td>
                <td></td>
            </tr>
            <tr>
                <td class="bg"><div>PRODUCT MANAGER</div></td>
                <td></td>
                <td class="bg"><div>FOOD/NONFOOD DIRECTOR</div></td>
                <td></td>
            </tr>
            <tr>
                <td class="bg"><div>QUALITY MANAGER</div></td>
                <td></td>
                <td class="bg"><div>MANAGEMENT CONTROL</div></td>
                <td></td>
            </tr>
            </tbody>
        </table>
        </div>
	</div>
</body>
</#list>
<#else>
<body style="font-family: Microsoft YaHei; color: #000; margin: 0px; padding: 0px;">
    <div id="header-left" class="header-left" align="left">Task No. ${taskId}</div>
	<div id="header-center" class="header-center" align="center">SUPPLIER INFORMATION FORM 供应商信息表</div>
	<div id="header-right" class="header-right" align="right">Print No. ${printId}</div>
	<div id="footer-left" class="footer-left" align="left">
		Auchan Confidential <span style="margin-left: 200px;">Print Date - ${printDate}</span>
	</div>
	<div id="footer-right" class="footer-right" align="right">
		Page <span id="pagenumber" /> of <span id="pagecount" />
	</div>
	<div class="container" style="width: 660px; margin-right: auto; margin-left: auto;">
    <div class="title">SUPPLIER INFORMATION FORM 供应商信息表</div>

    <div class="tb">
        <table  cellspacing="0" cellpadding="0" class="wh100">
            <tr>
                <td class="w80 bg">
                    <div>NEW</div>
                    <div>新建</div>
                </td>
                	<#if taskType=1>
	                <td class="w80 fh" style="font-size:7px;">●</td>
	                <#else>
	                <td class="w80 fh"></td>
	                </#if> 
                <td class="w80 bg"><div>UPDATE</div>
                    <div>更新</div></td>
                	<#if taskType=2>
	                <td class="w80 fh " style="font-size:7px;">●</td>
	                <#else>
	                <td class="w80 fh"></td>
	                </#if> 
                <td class="w125 bg">
                    <div>SUPPLIER NO.</div><div>供应商编号</div>
                </td>
                <td class="w125"><div>${supNo}</div></td>
                <td class="w80 bg">
                    <div>DIVISION</div><div>处别</div>
                </td>
                <td  class="w80"></td>
            </tr>
        </table>
    </div>
    <div class="zs">* “●”表示选中项，“○”表示未选中项</div>
    <div class="tb2">■MASTER INFORMATION 主信息</div>
    <div class="tb">
       <table  cellspacing="0" cellpadding="0" class="wh100">
           <col style="width: 88px;" />
           <col style="width: 48px;" />
           <col style="width: 68px;" />
           <col style="width: 120px;" />
           <col style="width: 68px;" />
           <col style="width: 68px;" />
           <col style="width: 68px;" />
           <col style="width: 68px;" />
           <col style="width: auto" />
        <tbody>
            <tr>
                <th colspan="9" class="theight">Corporate Information 公司信息</th>
            </tr>
            <tr>
                <td colspan="3" class="bg"><div>CORPORATE NAME</div><div>公司注册名称</div></td>
                <td colspan="6">
                <#if comName??>
                ${comName}
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="bg"><div>TAXES REGISTRATION NUMBER</div><div>税务登记号</div></td>
                <td colspan="6">
                 <#if unifmNo??>
                ${unifmNo}
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="bg"><div>INVOICE ADDRESS</div><div>发票地址</div></td>
                <td colspan="4">
                <#if dlvryAddrDetllAddr??>
                ${dlvryAddrDetllAddr}
                </#if>
                </td>
                <td colspan="2" class="bg"><div>POSTAL CODE</div><div>邮编</div></td>
                <td>
                <#if dlvryAddrPostCode??>
                ${dlvryAddrPostCode}
                </#if>
                </td>
            </tr>
            <tr>
                <th colspan="9" class="theight btop">Supplier Information 厂商信息</th>
            </tr>
            <tr>
                <td class="bg"><div>SORT</div><div>种类</div></td>
                <td colspan="2">
                <#if supType??>
                ${supType}
                </#if></td>
                <td class="bg"><div>SUPPLY MODE</div><div>供货方式</div></td>
                <td>
                <#if dlvryMethd??>
                ${dlvryMethd}
                </#if>
                </td>
                <td colspan="2" class="bg"><div>FIRST ORDER QTY</div><div>首订单量</div></td>
                <td colspan="2">
                <#if firstOrdQty??>
                ${firstOrdQty}
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="bg"><div>CHARACTER OF GOODS</div><div>商品特性</div></td>
                <td colspan="2"></td>
                <td colspan="2" class="bg"><div>TXT SUPPLIER NO.</div><div>TXT厂编</div></td>
                <td colspan="2">
                <#if txtSup??>
                ${txtSup}
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="bg"><div>CONTRACT STANDARD</div><div>合同标准</div></td>
                <td colspan="2">
                <#if cntrtType??>
                ${cntrtType}
                </#if>
                </td>
                <td colspan="2" class="bg"><div>EXPIRY DATE</div><div>失效日期</div></td>
                <td colspan="2">
                <#if validEndDate??>
                ${validEndDate}
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="bg"><div>ORDER DELIVERY MODE</div><div>订单发送方式</div></td>
                <td colspan="2">
                <#if ordAccptMethd??>
                ${ordAccptMethd}
                </#if>
                </td>
                <td colspan="2" class="bg"><div>ONLINE ACCOUNT LV.</div><div>网上对账级别</div></td>
                <td colspan="2">
                <#if scmLvl??>
                ${scmLvl}
                </#if>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="bg"><div>SUPPLIER ADDRESS</div><div>厂商联系地址</div></td>
                <td colspan="4">
                <#if supAddrDetallAddr??>
                ${supAddrDetallAddr}
                </#if>
                </td>
                <td colspan="2" class="bg"><div>POSTAL CODE</div><div>邮编</div></td>
                <td>
                <#if supAddrPostCode??>
                ${supAddrPostCode}
                </#if>
                </td>
            </tr>
            <tr>
                <td class="bg" ><div>CONTACT</div><div>联络人</div></td>
                <td colspan="3">
                <#if supAddrCntctName??>
                ${supAddrCntctName}
                </#if>
                </td>
                <td class="bg"><div>MOBILE</div><div>移动</div></td>
                <td colspan="4">
                <#if supAddrMoblNo??>
                ${supAddrMoblNo}
                </#if>
                </td>
            </tr>
        </tbody>
        </table>
    </div>

   
	</div>
</body>
</#if>
</html>
