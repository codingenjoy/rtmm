<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tld/auchan" prefix="auchan"%>
<%
/**
*最外端的"<div class="item supplerItem clone">"元素，不属于模板内容；
*但是必须存在，因为它起着承接DOM节点的作用.
*强制要求：模板内容不允许出现任何注释。

**/
%>
<div>
	<div>
		<div class="iconPut iconPut1 fl_left" style="width: 100px;">
			<input style="width: 80%" type="text" onchange="getItemMessAndStores(this);" />
			<div class="ListWin" onclick="showItemWin();"></div>
		</div>
	</div>
	<div>
		<input type="text" class="inputText fl_left Black" style="width: 150px;" readonly="readonly" />
	</div>
	<div>
		<input type="text" class="inputText fl_left" style="width: 90px;ime-mode:Disabled;" onfocus="$(this).removeClass('errorInput');$(this).attr('title','');" onchange="doUpdateOneItem(this);" maxlength="8" onkeyup="checkInputValueIntNum(this);" />
	</div>
	<div>
		<input type="text" class="inputText fl_left" style="width: 90px;ime-mode:Disabled;" onfocus="$(this).removeClass('errorInput');$(this).attr('title','');" onchange="doUpdateOneItem(this);" maxlength="10" onkeyup="checkInputValueDoubleNum(this);" />
	</div>
	<div>
		<input type="text" class="inputText fl_left Black" style="width: 90px;" readonly="readonly" />
	</div>
	<div>
		<input type="text" class="inputText fl_left Black" style="width: 100px;" readonly="readonly" />
	</div>
	<div>
		<input type="text" class="inputText fl_left Black" readonly="readonly" style="width: 150px;" />
	</div>
	<div>
		<input type="text" class="inputText fl_left" style="width: 90px;" onfocus="$(this).removeClass('errorInput');$(this).attr('title','');" onchange="doUpdateOneItem(this);" />
	</div>
	<div>
		<input type="text" class="inputText fl_left Black" style="width: 90px;" readonly="readonly" />
	</div>
</div>