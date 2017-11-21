<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>${defaultTitle }</title>
<meta name="keywords" content="${defaultKeyWords }" />
<meta name="description" content="${defaultDescription }" />
<meta name="author" content="${defaultKeyWords }" />
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate"/> 
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<%@ include file="/page/commons/easyui.jsp"%>
<%@ include file="/page/commons/datepick.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css" rel="Stylesheet" />
<script src="${ctx}/shared/js/rtmm.js"  type="text/javascript"></script>
<script src="${ctx}/shared/js/common.js" type="text/javascript"></script>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/welcome.css" rel="Stylesheet" />
 <style type="text/css">
        .CInfo{
            background-color:#eee;
            background-image:url(${ctx}/shared/themes/${theme}/images/item1.jpg);
            background-repeat:no-repeat;
        }
        .cdsc0 {
            float:left;
            margin-top:5px;
            margin-right:5px;
        }
        .cdsc1 {
            float:left;
            width:10%;margin-right:5px;
        }
        .cdsc2 {
            float:left;
           width:8%;margin-right:5px;
        }
        .cdsc2_1 {
            float:left;
           width:10%;margin-right:5px;
        }
        .cdsc3 {
            float:left;
            width:15%;
            margin-right:5px;
        }
        .cdsc3_1 {
            float:left;
            width:20%;
            margin-right:5px;
        }
        .cdsp {
            float:left;color:#ccc;line-height:20px;
        }
        .cdsc {
            height:60px;margin-top:15px;
        }
        .CInfo span {
            line-height:20px;
        }

    </style>
<script type="text/javascript">

//当出现错误的时候，不弹出错误提示框
function stopError() {
	return true;
}
//window.onerror = stopError;
//
</script>
</head>
<body>
<div class="TopMenu"></div>
    <div class="Center">
        <div class="LeftMenu">
            <div class="SideBar Bar_off 1-id" onclick="DispOrHid('1-id')"><div class="SideBarText">公司信息</div></div>
            <div class="SubMenu">
                <div class="SubTool">
                    <div class="Expend">
                        <div class="Expend1"></div>
                        <div class="Expend2"></div>
                    </div>
                    <div class="HiddenSub A-id" onclick="DispOrHid('A-id')"></div>
                </div>
                <ol class="SubList">
                    <li>
                        <a class="Sub Sub_on"><span class="L1_No"></span>
                           <span class="SubText">商品基本资料</span>
                           <span class="Fav"></span></a><!-- Fav_On-->
                    </li>
                    <li>
                        <a class="Sub"><span class="L1_No"></span>
                           <span class="SubText">系列商品管理</span>
                           <span class="Fav"></span></a>
                    </li>
                    <li>
                        <a class="Sub"><span class="L1_No"></span>
                           <span class="SubText">商品厂商查询</span>
                           <span class="Fav"></span></a>
                    </li>
                                        <li>
                        <a class="Sub"><span class="L1_No"></span>
                           <span class="SubText">季节性商品信息</span>
                           <span class="Fav"></span></a><!-- Fav_On-->
                    </li>
                    <li>
                        <a class="Sub"><span class="L1_No"></span>
                           <span class="SubText">进销存查询</span>
                           <span class="Fav"></span></a>
                    </li>
                    <li>
                        <a class="Sub"><span class="L1_No"></span>
                           <span class="SubText">异常查询</span>
                           <span class="Fav"></span></a>
                    </li>
                    <li>
                        <a class="Sub"><span class="L1_No"></span>
                           <span class="SubText">商品异动查询</span>
                           <span class="Fav"></span></a>
                    </li>
                </ol>
            </div>
        </div>
        <div class="Container">
            <div class="ToolBar">
                <div class="SearchTool">
                    <div class="Icon-size1 Tools1_disable B-id" title="检索" onclick="DispOrHid('B-id')" ></div>
                </div>
                <table>
                    <tr>
                        <td class="Line-1"></td>
			<td id="Tools2" class="Tools2_disable"></td>
			<td></td>
			<td id="Tools3" class="Tools3_disable"></td>
			<td></td>
			<td id="Tools23" class="Tools23_disable"></td>
			<td></td>
			<td class="Line-1"></td>
			<td id="Tools6" class="Tools6_disable"></td>
			<td></td>
			<td id="Tools20" class="Tools20_disable"></td>
			<td class="Line-1"></td>
			<td id="Tools11" class="sh_newMac Tools11_disable"></td>
			<td></td>
			<td id="Tools10" class="Tools10_disable"></td>
			<td></td>
			<td id="Tools12" class="Tools12_disable"></td>
			<td class="Line-1"></td>
			<td id="Tools16" class="Tools16_disable"></td>
			<td></td>
			<td id="Tools17" class="Tools17_disable"></td>
			<td></td>
			<td id="Tools19" class="Tools19_disable"></td>
			<td></td>
			<td id="Tools18" class="Tools18_disable"></td>
			<td class="Line-1_disable"></td>
			<td id="Tools24"  class="Tools24_disable"></td>
			<td></td>
			<td id="Tools25"  class="Tools25_disable"></td>
			<td></td>
			<td id="Tools26"  class="Tools26_disable"></td>
			<td class="Line-1"></td>
			<td id="Tools27"  class="Tools27_disable"></td>
			<td></td>
			<td id="Tools28"  class="Tools28_disable"></td>
			<td class="Line-1"></td>
			<td id="Tools29"  class="Tools29_disable"></td>
                    </tr>
                </table>
                <div class="RightTool ToolsBg">
                    <div class="Tools22 Icon-size1 Tools22_on " title="content"></div>
                </div>
                <div class="RightTool">
                    <div class="Icon-size1 Tools21" title="list"></div>
                </div>
            </div>
            <div class="CTitle">
                <!--第一个-->
                            <div class="tags1_left tags1_left_on"></div>
                            <div class="tagsM tagsM_on">商品总览</div>
                            <div class="tags tags_left_on"></div>

                             <!--中间-->
                            <div class="tagsM">商品变价</div>
                            <div class="tags"></div>
                <!--中间-->
                            <div class="tagsM">商品变价</div>
                            <div class="tags"></div>
                <!--中间-->
                            <div class="tagsM">商品条码</div>
                            <div class="tags"></div>
                <!--中间-->
                            <div class="tagsM">改包装设定</div>
                            <div class="tags"></div>
                <!--中间-->
                            <div class="tagsM">商品厂商</div>
                            <div class="tags"></div>
                <!--中间-->
                            <div class="tagsM">商品陈列信息</div>
                            <div class="tags"></div>
                <!--中间-->
                            <div class="tagsM">商品进销存</div>
                            <div class="tags"></div>

                            <!--最后一个-->
                            <div class="tagsM">DC商品</div>
                            <div class="tags tags3 tags_right_on"></div>
                            <!--一定不要忘了tag3-->
                            <!--add-->
                            <div class="tagsM_q  tagsM_on">创建新商品</div>
                            <div class="tags3_close_on">
                                <div class="tags_close"></div>
                            </div>
            </div>
            <div class="Container-1">
                <div class="Content">
	                <div class="CInfo">
                        <span class="sp_store5 sp_store_on">创建商品基本信息</span>
                        <span class="sp_store4">创建商品规格信息</span>
                        <span class="sp_store3">创建商品规格信息</span>
                        <span class="sp_store2">创建商品陈列信息</span>
                        <span class="sp_store1">创建商品厂商门店信息</span>
                    </div>

                    <div style="height:270px;" class="CM">
                        <div class="CM-bar"><div>基本信息</div></div>
                        <div class="CM-div">
                            <div class="ic">
                                <div class="pic_1"></div>
                                <div class="item11_1">
                                    <!--1-->
                                    <div class="icol_text w10"><span>货号</span></div>
                                    <div class="i_input1">
                                        <div class="iconPut ib">
                                        <input type="text" class="w80"/>
                                        <div class="ListWin"></div>
                                        </div></div>
                                    <div class="icol_text w10"><span>产地维护</span></div>
                                    <div class="i_input2"><input id="i1" data-options="editable:false,panelHeight:'auto'"/></div>
                                    <div class="icol_text w10"><span>*项目类型</span></div>
                                    <div class="i_input3"><input id="i2" data-options="editable:false,panelHeight:'auto'"/></div>
                                    <!--1-->
                                    <div class="icol_text w10"><span>*品名</span></div>
                                    <div class="i_input1"><input type="text" class="inputText w90"/></div>
                                    <div class="icol_text w10"><span>*商品类别</span></div>
                                    <div class="i_input2"><input id="i3" data-options="editable:false,panelHeight:'auto'"/></div>
                                    <div class="icol_text w10"><span>*加工类别</span></div>
                                    <div class="i_input3"><input id="i4" data-options="editable:false,panelHeight:'auto'"/></div>
                                    <!--1-->
                                    <div class="icol_text w10"><span>英文品名</span></div>
                                    <div class="i_input1"><input type="text" class="inputText w90"/></div>
                                    <div class="icol_text w10"><span>*采购方式</span></div>
                                    <div class="i_input2"><input id="i5" data-options="editable:false,panelHeight:'auto'"/></div>
                                    <div class="icol_text w10"><span>*采购期限</span></div>
                                    <div class="i_input3"><input id="i6" data-options="editable:false,panelHeight:'auto'"/></div>
                                    <!--1-->
                                    <div class="icol_text w10"><span>主厂商</span></div>
                                    <div class="i_input1">
                                        <div class="iconPut iq"><input type="text" style="width:71%"/><div class="ListWin"></div></div>
                                        <input type="text" class="inputText fl_left w58 Black" />
                                    </div>
                                    <div class="icol_text w10"><span>季节期数</span></div>
                                    <div class="i_input2"><input id="i7" data-options="editable:false,panelHeight:'auto'"/></div>
                                    <div class="icol_text w10"><span>有效期间</span></div>
                                    <div class="i_input3"><input id="i8" data-options="editable:false,panelHeight:'auto'"/></div>

                                </div>
                            </div>
                            <div class="ic">
                                <div class="ig">
                                    <span class="icol_text2">主状态</span>
                                    <div class="ia"><input id="i9" data-options="editable:false,panelHeight:'auto'"/></div>
                                    <span class="icol_text2">品牌</span>
                                    <div class="iconPut ih"><input type="text" style="width:71%"/><div class="ListWin"></div></div>
                                    <input type="text" class="inputText ik" />
                                    <div class="icol_text w11"><span>季节期数xx</span></div>
                                    <div class="iconPut ih" style="width:5%"><input type="text" class="w60"/><div class="ListWin"></div></div>
                                    <input type="text" class="inputText ik" style="width:7%;" />
                                    <span class="fl_left">&nbsp;&nbsp;有效期间&nbsp;&nbsp;</span>
                                    <div class="iconPut w10 fl_left C_Func "><input class="w80" type="text"/><div class="Calendar"></div> </div>
                                    <span class="fl_left">-</span>
                                    <div class="iconPut w10 fl_left C_Func "><input class="w80" type="text"/><div class="Calendar"></div> </div>
                                </div>
                                <div class="io">
                                    <div class="ig">
                                    <span class="icol_text2">处别</span>
                                    <div class="iconPut iq"><input type="text" class="w60 longText"/><div class="ListWin"></div></div>
                                    <input class="longText inputText w35" />
                                    </div><div class="ig">
                                    <span class="icol_text2">课别</span>
                                    <div class="iconPut iq"><input type="text" class="w60 longText"/><div class="ListWin"></div></div>
                                    <input class="longText inputText w35" />
                                    </div><div class="ig">
                                    <span class="icol_text2">群组</span>
                                    <div class="iconPut iq"><input type="text" class="w60 longText"/><div class="ListWin"></div></div>
                                    <input class="longText inputText w35" /></div>
                                </div>
                                <div class="io2">
                                    <div class="ig">
                                    <span class="icol_text2">大分类</span>
                                    <div class="iconPut iq"><input type="text" class="w60 longText" value="9898989"/><div class="ListWin"></div></div>
                                    <input class="longText inputText w35" type="text" value="123445555" />
                                    </div><div class="ig">
                                    <span class="icol_text2">中分类</span>
                                    <div class="iconPut iq"><input type="text" class="w60 longText"/><div class="ListWin"></div></div>
                                    <input class="longText inputText w35" />
                                    </div><div class="ig">
                                    <span class="icol_text2">小分类</span>
                                    <div class="iconPut iq"><input type="text" class="w60 longText"/><div class="ListWin"></div></div>
                                    <input class="longText inputText w35" /></div>
                                </div>
                                <div class="io">
                                    <div class="ig">
                                        <span class="icol_text2">长</span>
                                        <input class="longText inputText w35" /><span class="icol_text2">cm</span>
                                    </div>
                                    <div class="ig">
                                        <span class="icol_text2">宽</span>
                                        <input class="longText inputText w35" /><span class="icol_text2">cm</span>
                                    </div>
                                    <div class="ig">
                                        <span class="icol_text2">高</span>
                                        <input class="longText inputText w35" /><span class="icol_text2">cm</span>
                                    </div>
                                </div>
                                <div class="ip">
                                    <div class="ip1 w12_5">
                                            <div><span>销售单位</span></div>
                                            <div><span>成本时点</span></div>
                                            <div><span>采购备注</span></div>
                                        </div>
                                    <div class="ip2 w25">
                                            <div class="ig">
                                                <div class="iconPut iq1"><input type="text" class="w60 longText"/><div class="ListWin"></div></div>
                                            </div>
                                            <div class="ig">
                                                <input id="i10" data-options="editable:false,panelHeight:'auto'"/>
                                            </div>
                                    </div>
                                    <div class="ip3 w60">
                                            <div class="ig">
                                                <span class="icol_text2">进价税率</span>
                                                <div class="iconPut iq" style="width:20%"><input type="text" class="w60 longText" value="9898989"/><div class="ListWin"></div></div>
                                                <input class="longText inputText w35" type="text" value="123445555" />%
                                            </div>
                                            <div class="ig">
                                                <span class="icol_text2">售价税率</span>
                                                <div class="iconPut iq" style="width:20%"><input type="text" class="w60 longText" value="9898989"/><div class="ListWin"></div></div>
                                                <input class="longText inputText w35" type="text" value="123445555" />%
                                            </div>
                                    </div>
                                    <input class="w80 inputText" />
                                </div>
                                
                            </div>
                        </div>
                    </div>

                    <div style="height:260px;margin-top:2px;" class="CM">
                            <div class="CM-bar">
                                <div>状态及价格信息</div>
                                <div class="icm Icon-size2" style="margin-top:120px;"></div>
                            </div>
                            <div class="CM-div">
                                <div class="cdsc">
                                    <div class="tb50">
                                        <div class="ig">
                                            <div class="msg_txt">*主产地</div>
                                            <div class="iconPut iq fl_left" style="width:13%;">
                                                <input type="text" style="width:60%" />
                                                <div class="ListWin"></div>
                                            </div>
                                            <input class="inputText iq Black" type="text" style="width:35%;" />
                                        </div>
                                        <div class="ig">
                                            <div class="msg_txt">主生产单位</div>
                                            
                                            <input class="inputText iq Black" type="text" style="width:70%;" />
                                        </div>
                                    </div>
                                    <div class="tb50">
                                        <div class="ig">
                                            <div class="msg_txt">保存方式</div>
                                            <div class="iconPut" style="width:20%;float:left;">
                                                <input type="text" style="width:75%;" value="上海" readonly="readonly" />
                                                <div style="color:#999999;">省</div>
                                            </div>
                                            <div class="iconPut" style="width:28%;float:left; margin-left:3px;">
                                                <input type="text" style="width:70%;" value="上海市" readonly="readonly" />
                                                <div style="color:#999999;">市</div>
                                                    <div class="ListWin cityselected"></div>
                                                </div>
                                            </div>
                                        <div class="ig">
                                            <div class="msg_txt">&nbsp;</div>
                                            <input class="w50 inputText" />
                                        </div>
                                    </div>
                                </div>
                                <div class="txm_info" style="width:960px;">
                                    <div class="txm_title2">
                                        <span style="margin-left:50px;">城市</span><span style="margin-left:60px;">其他产地</span>
                                        <span style="margin-left:230px;">生产单位</span><span style="margin-left:100px;">单位地址</span>
                                    </div>
                                    <div class="sp_tb2" style="height:120px;">
                                        <div class="ig" style="margin-top:5px;">
                                            <input type="checkbox" class="cdsc0"/>
                                            <input type="text" class="cdsc1 inputText Black"/>
                                            <div class="iconPut cdsc2">
                                                <input type="text" style="width:70%"/>
                                                <div class="ListWin"></div>
                                            </div>
                                            <input type="text" class="inputText cdsc3 Black" readonly="readonly"/>
                                            <input type="text" class="inputText cdsc3_1"/>
                                            <div class="iconPut cdsc2_1">
                                                <input type="text" style="width:82%"/>
                                                <span class="cdsp">省</span>
                                            </div>
                                            <div class="iconPut cdsc2_1">
                                                <input type="text" style="width:65%" class="fl_left"/>
                                                <span class="cdsp">市</span>
                                                <div class="ListWin"></div>
                                            </div>
                                            <input type="text" class="w20 inputText" />
                                        </div>
                                        <div class="ig">
                                            <input type="checkbox" class="cdsc0"/>
                                            <input type="text" class="cdsc1 inputText  Black"/>
                                            <div class="iconPut cdsc2">
                                                <input type="text" style="width:70%"/>
                                                <div class="ListWin"></div>
                                            </div>
                                            <input type="text" class="inputText cdsc3 Black" readonly="readonly"/>
                                            <input type="text" class="inputText cdsc3_1"/>
                                            <div class="iconPut cdsc2_1">
                                                <input type="text" style="width:82%"/>
                                                <span class="cdsp">省</span>
                                            </div>
                                            <div class="iconPut cdsc2_1">
                                                <input type="text" style="width:65%" class="fl_left"/>
                                                <span class="cdsp">市</span>
                                                <div class="ListWin"></div>
                                            </div>
                                            <input type="text" class="w20 inputText" />
                                        </div>
                                        <div class="ig">
                                            <input type="checkbox" class="cdsc0"/>
                                            <input type="text" class="cdsc1 inputText  Black"/>
                                            <div class="iconPut cdsc2">
                                                <input type="text" style="width:70%"/>
                                                <div class="ListWin"></div>
                                            </div>
                                            <input type="text" class="inputText cdsc3 Black" readonly="readonly"/>
                                            <input type="text" class="inputText cdsc3_1"/>
                                            <div class="iconPut cdsc2_1">
                                                <input type="text" style="width:82%"/>
                                                <span class="cdsp">省</span>
                                            </div>
                                            <div class="iconPut cdsc2_1">
                                                <input type="text" style="width:65%" class="fl_left"/>
                                                <span class="cdsp">市</span>
                                                <div class="ListWin"></div>
                                            </div>
                                            <input type="text" class="w20 inputText" />
                                        </div>
                                    </div>
                                    <div class="ig">
                                        <input type="checkbox" class="sp_icon1"/>
                                        <div class="Icon-size2 Tools10 sp_icon2">
                                        </div><div class="Icon-size2 Line-1 sp_icon3 "></div>
                                        <div class="Icon-size2 Tools11 sp_icon4" ></div>
                                    </div>
                                </div>
                            </div>
            </div>
        </div>
    </div>
        </div>
    </div>
    
    <div id="popupWin" class="Panel" style="display: none"></div>
    
<script type="text/javascript">
$(function(){
	$.ajaxSetup({async : false});
	$('.Container-1').load(ctx+"/item/create/baseInfo");
	$.ajaxSetup({async : true});
	$('.tags_right_on').removeClass('tags_right_on');
	$('.tags_left_on').removeClass('tags_left_on');
	$('.tags1_left_on').removeClass('tags1_left_on');
	$('.tagsM_on').removeClass('tagsM_on');
	$('.tags3_r_on').addClass('tags3').addClass('tags_right_on');
	$('.tags3_r_off').addClass('tags3').addClass('tags_right_on');
	$('.tags3_r_on').removeClass('tags3_r_on');
	$('.tags3_r_off').removeClass('tags3_r_off');
	$('.item_create_tab').show();
	$('.tagsM_q').addClass('tagsM_on');
});
</script>
</body>
</html>