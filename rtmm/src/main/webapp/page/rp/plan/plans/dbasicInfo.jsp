<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <div style="height:150px;" class="CM">
    <div class="inner_half">
        <div class="CM-bar"><div>保留计划基本信息</div></div>
        <div class="CM-div">
            <div class="ig_top20">
                <div class="icol_text w20"><span>计划号</span></div>
                <input type="text" class="inputText w20 fl_left" id="rpNo"/>
                <div class="icol_text"><span>&nbsp;&nbsp;&nbsp;状态</span></div>
                <input type="text" class="inputText w30 fl_left " id="status" />
            </div>
            <div class="ig">
                <div class="icol_text w20"><span>RP DM</span></div>
                <input type="text" class="inputText w20 fl_left" id="rdmNo" />
                <div class="icol_text"><span>&nbsp;&nbsp;&nbsp;主题</span></div>
                <input type="text" class="inputText w30 fl_left"id="rdmTopic" />
            </div>
            <div class="ig">
                <div class="icol_text w20"><span>开始日期</span></div>
                <input class="inputText w20 fl_left" id="rdmBeginDate" type="text"/>
                <div class="icol_text"><span>&nbsp;&nbsp;&nbsp;结束日期</span></div>
                <input class="inputText w20 fl_left"id="rdmEndDate" type="text"/>
            </div>
            <div class="ig">
                <div class="icol_text w20"><span>物流中心</span></div>
                <input type="text" class="inputText w20 fl_left" id="dcStoreNo"/>
            </div>
        </div>
    </div>
    <div class="inner_half">
        <div class="ig_top20">
            <span class="icol_text">课别&nbsp;</span>
            <input type="text" class="inputText w15 fl_left"   id="catlgId" />
            <div class="fl_left">&nbsp;</div>
            <input type="text" class="inputText w30 fl_left" id="catlgName"/>
        </div>
        <div class="ig">
            <div class="icol_text"><span>需要门店确认</span></div>
            <input type="checkbox" class="cks" id="stCnfrmInd"/>
            <div class="icol_text"><span>&nbsp;&nbsp;&nbsp;门店确认期间</span></div>
            <input class="inputText w20 fl_left" type="text" id="stCnfrmBeginDate"/>
            <div class="icol_text"><span>&nbsp;-</span></div>
            <input class="inputText w20 fl_left" type="text" id="stCnfrmEndDate"/>
        </div>
        <div class="ig">
            <div class="icol_text w2x"><span>门店补货期间</span></div>
            <input class="inputText w20 fl_left" type="text" id="stRepBeginDate"/>
            <div class="icol_text"><span>&nbsp;-</span></div>
            <input class="inputText w20 fl_left" type="text" id="stRepEndDate" />
        </div>
        <div class="ig">
            <span class="icol_text">总金额&nbsp;</span>
            <input type="text" class="inputText w30" id="finalAmnt"/>&nbsp;元
        </div>
    </div>
</div>