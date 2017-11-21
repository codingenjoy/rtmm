<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/item/itemBaseDoc.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/combo.css"/>
    <style type="text/css">
        ._w120{width:120px;}
        ._w80{width:80px;}
                .license2:hover {
            background-position:-3px -19px;
        }
        .zz_info {
            width:95%;
        }
        .iconPut {
            float:left;
            margin-left:3px;
        }
        .zz_2 {
            height:140px;
        }
        .zz_2 input {
            margin-left:3px;
        }
        .zz_2 input[type="checkbox"] {
            margin-top:5px;
        }
        .zz_11 {
            margin-left:60px;
        }
        .zz_12 {
            margin-left:75px;
        }
        .zz_13 {
            margin-left:60px;
        }
        .zz_14 {
            margin-left:50px;
        }
        .zz_15 {
            margin-left:220px;
        }
        .zz_16 {
            margin-left:35px;
        }
        .zz_17 {
            margin-left:30px;
        }
        .sp_icon1 {
            margin-left:12px;
        }
        .tb_top {
            margin-top:10px;margin-left:20px;margin-bottom:5px; border-bottom:1px solid #ccc;
        }
    </style>
    <script type="text/javascript">  
    $(function(){
    	$("#Tools12").attr('class', "Tools12").bind("click", function() {
    		itemMultiMod();		
    	});
		//返回列表
		$('#Tools21').toggleClass('Tools21_disable').toggleClass('Tools21').bind('click',function() {
			showContent(ctx + '/item/query/itemBaseList');
		});
    });
 // 提交注册信息
    function changeStoreNo(storeNo) {
	 var itemNo = $('#itemNo').val();
	 if(itemNo != null && itemNo != ""){
     	$.ajax( {
    		type : 'post',
    		url : ctx + '/item/query/changeStore',
    		data : {
    			storeNo : storeNo,
    			itemNo : itemNo
			},
    		success : function(data) {
    			$("#storeInfo").html('');
				$("#storeInfo").html(data);
    		}
    	}); 
	 }
    }
    </script>
    <%@ include file="/page/commons/toolbar.jsp"%>
    <div class="CTitle">
    <!--第一个-->
    <div class="tags1_left "></div>
    <div class="tagsM " id="ovreviewTab">商品总览</div>
    <div class="tags"></div>
    <!--中间-->
    <div class="tagsM" id="priceChangeTab">商品变价</div>
    <div class="tags"></div>
    <div class="tagsM" id="specInfoTab">商品规格</div>
    <div class="tags"></div>
    <div class="tagsM " id="barcodeInfoTab">商品条码</div>
    <div class="tags"></div>
    <div class="tagsM " id="supInfoTab">商品厂商</div>   
    <div class="tags tags_right_on"></div>
    <div class="tagsM tagsM_on" id="dcInfoTab">DC信息</div>
    <div class="tags tags3_r_on"></div>
	</div> 
            <div class="Container-1">
                <div class="Content">
	                <div class="CInfo">
                        <div style="float:left;" class="w25">
                            <div class="cinfo_div">店号</div>
								<c:forEach items="${storeList}" var="store">
									<option value="${store.storeNo}">${store.storeNo}-${store.storeName}</option>
								</c:forEach>                        
							</div>
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

                    <div style="height:60px;" class="CM">
                        <div class="CM-bar"><div>货号</div></div>
                        <div class="CM-div">
                            <div class="hh_item">
                                 <div class="icol_text w7"><span>货号</span></div>
                                 <div class="iconPut iq" style="width:13%;"><input style="width:83%" type="text"/><div class="ListWin"></div></div>
                                 <input class="inputText iq Black" style="width:20%;" type="text"/>

                                <span class="fl_left" style="line-height:20px;">&nbsp;&nbsp;&nbsp;保质期&nbsp;&nbsp;</span>
                                        <input type="text" class="w5 inputText fl_left" />
                                        <div class="fl_left" style="width:50px;margin-left:5px;" ><input id="i3" data-options="editable:false,panelHeight:'auto'" style="height:20px;"/></div>
                                        <span>或</span>
                                        <input type="text" class="w5 Black inputText" />
                                        <span>天</span>
                            </div>
                        </div>
                    </div>
                    <div style="height:252px;">
                        <div class="tb50">
                            <div style="height:140px;margin-top:2px;" class="CM">
                                <div class="CM-bar"><div>陈列信息</div></div>
                                <div class="CM-div">
                                    <div class="ig"  style="margin-top:15px;">
                                        <div class="msg_txt">货物属性</div>
                                        <input type="text" class="inputText w20" />
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt">DC订购单位</div>
                                        <input type="text" class="inputText w20" />
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt">门店补货方式</div>
                                        <input class="inputText w10" type="text"/>
                                        <input class="inputText w20" type="text" />
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt">补货单位</div>
                                        <input type="text" class="w10 inputText align_right" />
                                    </div>
                                </div>
                            </div>
                            <div style="height:110px; margin-top:2px;" class="CM">
                                <div class="CM-bar"><div>托盘信息</div></div>
                                <div class="CM-div">
                                    <div class="ig"  style="margin-top:15px;">
                                        <div class="msg_txt">每层箱数TI</div>
                                        <input type="text" class="inputText w15"/>
                                        <span>托盘层数HI</span>
                                        <input type="text" class="inputText w15"/>
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt">每托盘箱数</div>
                                        <input type="text" class="inputText w15"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tb50">
                            <div style="height:252px; margin-top:2px;" class="CM">
                                <div class="CM-bar"><div>磅秤机信息</div></div>
                                <div class="CM-div">
                                    <div class="tb_top">
                                        <span style="margin-left:140px;">外箱</span>
                                        <span style="margin-left:130px;">内箱</span>
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt">箱含量</div>
                                        <input class="inputText w30 align_right" value="开快点快点"/>
                                        <input class="inputText w30 align_right" />
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt">面(CM)</div>
                                        <input class="inputText w30 align_right" value="开快点快点"/>
                                        <input class="inputText w30 align_right" />
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt">高(CM)</div>
                                        <input class="inputText w30 align_right" value="开快点快点"/>
                                        <input class="inputText w30 align_right" />
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt">深(CM)</div>
                                        <input class="inputText w30 align_right" value="开快点快点"/>
                                        <input class="inputText w30 align_right" />
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt">体积(M3)</div>
                                        <input class="inputText w30 align_right" value="开快点快点"/>
                                        <input class="inputText w30 align_right" />
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt">毛重(KG)</div>
                                        <input class="inputText w30 align_right" value="开快点快点"/>
                                        <input class="inputText w30 align_right" />
                                    </div>
                                    <div class="ig">
                                        <div class="msg_txt">净重(KG)</div>
                                        <input class="inputText w30 align_right" value="开快点快点"/>
                                        <input class="inputText w30 align_right" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="height:220px;margin-top:2px;" class="CM">
                        <div class="CM-bar"><div>证照信息</div></div>
                        <div class="CM-div">
                            <div class="zz_info">
                                <div class="zz_1">
                                    <span class="zz_11">物流店号</span>
                                    <span class="zz_12">状态</span>
                                    <span class="zz_13">DC属性</span>
                                    <span class="zz_14">供应商</span>
                                    <span class="zz_15">进价(元)</span>
                                    <span class="zz_16">允收天数(天)</span>
                                    <span class="zz_17">配送天数(天)</span>
                                </div>
                                <div class="zz_2">
                                    <div class="ig" style="margin-top:5px;margin-left:10px;">
                                        <input type="checkbox" class="fl_left" />
                                        <select class="w12_5 fl_left"><option></option></select>
                                        <input type="text" class="w10 inputText fl_left" />
                                        <input type="text" class="w10 inputText fl_left Black" />
                                        <div class="iconPut w10">
                                                <input type="text" class="w70"/>
                                                <div class="ListWin"></div>
                                        </div>
                                        <input type="text" class="w17 inputText fl_left" />
                                        <input type="text" class="w10 inputText fl_left" />
                                        
                                        <input type="text" class="w10 inputText" />
                                        <input type="text" class="w10 inputText" />
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
