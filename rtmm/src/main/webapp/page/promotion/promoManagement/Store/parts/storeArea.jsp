<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<div class="CInfo">
			<div class="w25 fl_left">
				<div class="cinfo_div">店号</div>
				<select onchange="changStore()" disabled="disabled"
					onblur="storeChange()" id="storeNo" name="storeNo" class="w60 top3">
					<option value="${store.storeNo }">${store.storeNo }-${store.storeName }</option>
				</select>
			</div>

</div>