<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
table td{font-size:12px;}
</style>
<div id="SearchDiv_11" class="RightContentLeft FloatLeft Grey5 DisplayNo"><!--search搜索栏-->

    <div class="HPAndThirty">

        <span style="padding-left:10px;float:left;">查询条件</span>

        <span class="LeftMenuIcon FloatRight Icon CircleClose MarginRight10" title="关闭"></span>

    </div>

    <div class="MenuLine Icon lineAAAAA"></div>

    <div class="SelectConditonal HPAndThirty">

        <div class="SelectConditonalText" style="line-height:30px;">公司编号</div>

        <div class="SelectConditonal1">

            <input type="text" class="SelectConditonal11" style="width:60%;"/>

        </div>

    </div>

    <div class="SelectConditonal HPAndThirty">

        <div class="SelectConditonalText" style="line-height:30px;">公司名称</div>

        <div  class="SelectConditonal1">

            <input type="text" class="SelectConditonal11" />

        </div>

    </div>

    <div class="SelectConditonal HPAndThirty">

        <div class="SelectConditonalText">公司英文名称</div>

        <div class="SelectConditonal1">

            <input type="text" class="SelectConditonal11" />

        </div>

    </div>

    <div class="SelectConditonal HPAndThirty">

        <div class="SelectConditonalText" style="line-height:30px;">公司状态</div>

        <div class="SelectConditonal1">

            <select>

                <option>-请选择-</option>

            </select>

        </div>

    </div>

    <div class="SelectConditonal HPAndThirty">

        <div class="SelectConditonalText" style="line-height:30px;">法人代表</div>

        <div  class="SelectConditonal1">

            <input type="text" class="SelectConditonal11" style="width:60%;" />

        </div>

    </div>

    <div class="SelectConditonal HPAndThirty">

        <div class="SelectConditonalText" style="line-height:30px;">经营范围</div>

        <div  class="SelectConditonal1">

            <input type="text" class="SelectConditonal11" />

        </div>

    </div>

    <div class="SelectConditonal HPAndThirty">

        <div class="SelectConditonalText" style="line-height:30px;">经营范围</div>

        <div  class="SelectConditonal1" >

            <div class="InputDiv MarginLeft10">

                <input type="text" class="SelectConditonal12 FloatLeft"/>

                <span class="RightContentToolIcon Icon Catelog FloatRight" style="margin-top:3px; margin-right:5px;"></span>

            </div>

        </div>

    </div>

    <div class="SelectConditonal HPAndThirty">

        <div class="SelectConditonalText" style="line-height:30px;">成立日期</div>

        <div  class="SelectConditonal1" >

            <div class="InputDiv MarginLeft10">

                <input type="text" class="SelectConditonal12 FloatLeft" />

                <span class="RightContentToolIcon Icon Canlendar FloatRight" style="margin-top:3px; margin-right:5px;"></span>

            </div>

        </div>

    </div>

    <div class="HPAndThirty">

        <div class="SelectConditonalText" style="line-height:30px;">注册城市</div>

        <div  class="SelectConditonal1" >

            <div class="InputDiv2 MarginLeft10 FloatLeft">

                <input type="text" class="SelectConditonal15 FloatLeft"/>

                <span class="RightContentToolIcon Icon Canlendar FloatLeft" style="margin-top:3px; margin-Left:5px;"></span>

            </div>

            <input type="text" class="InputDiv3 FloatLeft MarginLeft10"/>

        </div>

    </div>

    <div class="SelectConditonal HPAndThirty">

        <div class="SelectConditonalText" style="line-height:30px;">税号</div>

        <div  class="SelectConditonal1">

            <input type="text" class="SelectConditonal11" />

        </div>

    </div>

    <div class="MenuLine Icon lineAAAAA"></div>

    <div class="HPAndForty">

        <span class="LeftMenuIcon FloatRight Icon Rubber MarginRight10" title="隐藏左侧菜单栏"></span>

        <span class="LeftMenuIcon FloatRight Icon SelectRuslt MarginRight10" title="隐藏左侧菜单栏"></span>

    </div>

</div>

<div id="RightContentRight_11" class="RightContentRight FloatRight">

<!--                <div class="RCR_Left FloatLeft" style="background:#4cff00;display:none;">



                </div>-->

    <div class="RCR_Right FloatLeft">

        <div class="RCR_Right1 TextAlginCenter" style="border-bottom:1px solid #FFFFFF;">

            <table border="0" cellspacing="0" cellpadding="0">

                <tr>

                    <td class="RCR_Cols1"><input type="checkbox" /></td>

                    <td class="RCR_Cols2"><span class="FloatLeft">|</span>公司编号</td>

                    <td class="RCR_Cols4"><span class="FloatLeft">|</span>公司名称</td>

                    <td class="RCR_Cols5"><span class="FloatLeft">|</span>公司类型</td>

                    <td class="RCR_Cols2"><span class="FloatLeft">|</span>公司状态</td>

                    <td class="RCR_Cols3_D"><span class="FloatLeft">|</span>注册城市</td>

                    <td class="RCR_Cols3_D"><span class="FloatLeft">|</span>成立日期</td>

                </tr>

            </table>

        </div>

        <div class="RCR_Right2" style="border-bottom:1px solid #999999;">

            <table border="0" cellspacing="0" cellpadding="0">
            
<c:forEach items="${list }" var="firm">
                  <tr class="Grey1">

                      <td class="RCR_Cols1 TextAlginCenter"><input type="checkbox" name="firmCheckbox" onclick="singleCheckbox(this)"/></td>

                      <td class="RCR_Cols2 TextAlginRight">${firm.firmNumber }  &nbsp;</td>

                      <td class="RCR_Cols4 TextAlginLeft">&nbsp;&nbsp;${firm.firmName } </td>

                      <td class="RCR_Cols5 TextAlginLeft">&nbsp;&nbsp;&nbsp;${firm.firmType } </td><!--公司类型-->

                      <td class="RCR_Cols2 TextAlginLeft">&nbsp;&nbsp;&nbsp;${firm.firmCondition } </td>

                      <td class="RCR_Cols3_D TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;</td><!--地址-->

                      <td class="RCR_Cols3_D TextAlginLeft">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><!--2012-12-21-->

                  </tr>
</c:forEach>

            </table>

        </div>

        <!--<div style="width:99.5%; height:1px; margin:0 auto; background-color:#999999;"></div>-->

        <div class=" HPAndThirty"><!--RCR_PageNum-->

            <div class="RCR_PageNum1 FloatLeft">

                第<span>1-15</span>项,共<span>145</span>项&nbsp;|&nbsp ;每页显示

                <select id=selectPageTest class="Border" style="width:50px;" onchange="selectPageTest()">

<!--                                 <option>50</option>

                                <option>45</option>

                                <option>40</option>

                                <option>35</option>
 -->
                    <option>30</option>

         <!--            <option>25</option>
-->
                    <option>20</option>

<!--                        <option>15</option>
-->
                    <option>10</option>

                </select>

                项

            </div>

            <div class="RCR_PageNum2 FloatRight">

                

                <span class="FloatRight MarginRight20">&nbsp;页</span>

                <input type="text" class="FloatRight Border" style="width:30px; height:15px;" />

                <span class="FloatRight">&nbsp;&nbsp;跳转至&nbsp;</span>

                <div class="FloatRight Icon Last"></div>

                <div class="FloatRight Icon Next"></div>

                <div class="FloatRight TextAlginCenter">20</div>

                <div class="FloatRight TextAlginCenter">...</div>

                <div class="FloatRight TextAlginCenter">5</div>

                <div class="FloatRight TextAlginCenter">4</div>

                <div class="FloatRight TextAlginCenter"><p onclick="selectFirm()">3</p></div>

                <div class="FloatRight TextAlginCenter"><p onclick="selectFirm()">2</p></div>

                <div class="FloatRight TextAlginCenter GreencColor">1</div>

                <div class="FloatRight Icon Privious2"></div>

                <div class="FloatRight Icon First2"></div>

            </div>

        </div>

    </div>

</div>
