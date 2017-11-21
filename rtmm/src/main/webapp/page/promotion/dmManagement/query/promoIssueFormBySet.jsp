<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/rtmm.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<script type="text/javascript">
$(function(){
	//$('#Container').load(ctx + '/promotion/DMManagement/periodAndThemeList');
	
	//全国性DM期数与主题(tab)
	$('#countryTab').unbind("click").bind( 'click', function() {
		$('#Container').load(ctx + '/promotion/DMManagement/periodAndTheme');
		/* $(this).addClass("tagsM_on");
		$("div .tagsM_on").removeClass("tagsM_on"); */
		
		
	});
	
	$('#countryAndShopTab').unbind("click").bind( 'click', function() {
		$('#Container').load(ctx + '/promotion/DMManagement/promoIssueAllList');
		/* $(this).addClass("tagsM_on");
		$("div .tagsM_on").removeClass("tagsM_on"); */
		
	});
	
});
</script>
<div class="Container-1" id="Container">
<%@ include file="/page/commons/toolbar.jsp"%>

 <div class="CTitle">
       <!--第一个-->
       <div class="tags1_left tags1_left_on"></div>
       <div class="tagsM tagsM_on" id="countryTab">全国性DM期数与主题</div>
       <div class="tags tags_left_on"></div>
       <!--最后一个-->
       <div class="tagsM" id="countryAndShopTab">全国性及门店DM期数与主题</div>
       <div class="tags tags3_r_off"></div>
</div>
<div class="Container-1">
    <div class="Content">
        <div class="CInfo">
            <span>项</span>
            <span>10，000</span>
            <span>/</span>
            <span>1</span>
            <span>第</span>
            <span>|</span>
            <span>张三</span>
            <span>修改人</span>
            <span>2014-03-03</span>
            <span>修改日期</span>
            <span>李四</span>
            <span>建档人</span>
            <span>2014-02-02</span>
            <span>创建日期</span>
        </div>
        <div style="height:245px;">
            <div class="inner_half CM">
                <div class="CM-bar"><div>促销基本信息</div></div>
                <div class="CM-div">
                    <div class="ig_top20">
                        <div class="msg_txt">档期</div><input type="text" class="inputText w23" />
                    </div>
                    <div class="ig">
                        <div class="msg_txt">促销期间</div>
                        <input type="text" class="inputText w23" />&nbsp;-&nbsp;<input type="text" class="inputText w23" />
                    </div>
                    <div class="ig">
                        <div class="msg_txt">采购期间</div>
                        <input type="text" class="inputText w23" />&nbsp;-&nbsp;<input type="text" class="inputText w23" />
                    </div>
                    <div class="ig">
                        <div class="msg_txt">价格生效日</div>
                        <input type="text" class="inputText w23" />
                    </div>
                    <div class="ig">
                        <div class="msg_txt">套系</div>
                        <input type="text" class="inputText w23" />&nbsp;<input type="text" class="inputText w40" />
                    </div>
                    <div class="ig">
                        <div class="msg_txt">会议日</div>
                        <input type="text" class="inputText w23" />
                    </div>
                    <div class="ig">
                        <div class="msg_txt">海报协调人</div>
                        <input type="text" class="inputText w23" />&nbsp<input type="checkbox" />&nbsp;并入门店DM
                    </div>
                </div>
            </div>
            <div class="inner_half">
                <div class="CM" style="height:90px">
                    <div class="CM-bar-en"><div>DM</div></div>
                    <div class="CM-div">
                        <div class="ig_top20">
                            <div class="msg_txt">DM最后定稿日</div>
                            <input type="text" class="inputText w23" />&nbsp;<span>DM价格开放日</span>&nbsp;<input type="text" class="inputText w23" />
                        </div>
                        <div class="ig">
                            <div class="msg_txt">DM计划期间</div>
                            <input type="text" class="inputText w23" />&nbsp;-&nbsp;<input type="text" class="inputText w23" />
                        </div>
                    </div>
                </div>
                <div class="CM" style="height:60px;margin-top:2px;">
                    <div class="CM-bar-en"><div>S</div></div>
                    <div class="CM-div">
                        <div class="ig_top20">
                            <div class="msg_txt">S计划期间</div>
                            <input type="text" class="inputText w23" />&nbsp;-&nbsp;<input type="text" class="inputText w23" />
                        </div>
                    </div>
                </div>
                <div class="CM" style="height:90px;margin-top:2px;">
                    <div class="CM-bar-en"><div>L</div></div>
                    <div class="CM-div">
                        <div class="ig_top20">
                            <div class="msg_txt">L计划期间</div>
                            <input type="text" class="inputText w23" />&nbsp;-&nbsp;<input type="text" class="inputText w23" />
                        </div>
                        <div class="ig">
                            <div class="msg_txt">L最后审核日</div>
                            <input type="text" class="inputText w23" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="CM" style="height:290px;margin-top:2px;">
            <div class="CM-bar"><div>主题与店别</div></div>
            <div class="CM-div">
                <div class="zt_db">
                    <div style="margin-top:20px;">
                        <span class="zt_title1">编号</span>
                        <span class="zt_title2">主题</span>
                        <span class="zt_title3">渠道</span>
                        <span class="zt_title4">参与组别</span>
                        <span class="zt_title5">开始日期</span>
                        <span class="zt_title6">结束日期</span>
                    </div>
                    <div class="ztdb_tb">
                        <div class="ig_top10">
                            <input type="text" class="inputText w7 first_ztdb" />
                            <input type="text" class="inputText w25" />
                            <input type="text" class="inputText w10" />
                            <input type="text" class="inputText w25" />
                            <input type="text" class="inputText w12_5" />
                            <input type="text" class="inputText w12_5" />
                        </div>
                        <div class="ig">
                            <input type="text" class="inputText w7 first_ztdb" />
                            <input type="text" class="inputText w25" />
                            <input type="text" class="inputText w10" />
                            <input type="text" class="inputText w25" />
                            <input type="text" class="inputText w12_5" />
                            <input type="text" class="inputText w12_5" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>