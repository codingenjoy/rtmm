<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="TopMenu">
	<div class="Logo"></div>
	<auchan:menu id="${mid}" />
	<ol class="RMenu">
		<li class="MenuDrop">
			<a class="RM4"></a>
			<ol class="FavDrop">
				<li class="FavDrop1">
					<div class="RM1"></div>
					<span>${myFavorite }</span>
				</li>
				<li class="FavDrop2">
					<div class="RM3"></div>
					<span>${userPreference}</span>
				</li>
				<li class="FavDrop3">
					<div class="RM2"></div>
					<span>${pwdSetting }</span>
				</li>
                 <li class="FavDrop6">
                     <div class="RM6"></div>
                     <span>${changeJobFun}</span>
                 </li>
				<li class="FavDrop5" >
					<div class="RM5"></div>
					<span>${logout }</span>
				</li>
			</ol>
		</li>
		<%
			String chunk10 = null;
			String fullName0 = (String)request.getAttribute("staffName");
			/* if (fullName0!=null){
				String[] parts0 = fullName0.split("\\s+");
				String name0 = parts0[0];
				int charSize0 = name0.length()>10?10:name0.length();
				chunk10 = name0.substring(0, charSize0);
			} */
		%>
		<c:set var="staffForName" scope="session" value="${staffName}"></c:set>
		<li class="RMenu_Text">
			<div class="longText" title="<%= fullName0 %>">${welcome }，<%= fullName0 %></div>
		</li>
	</ol>
	<ol class="MyFav"
		style="display: none; position: absolute; z-index: 1000; top: 42px; left: 1027px;">
	</ol>
	<input type="hidden" id="currentId" value="${currentId }">
	<ol class="Myzw" style="display: none;">
		<c:if test="${fn:length(jfList)>0}">
			<c:forEach items="${jfList}" var="jf">
				<li><div class="changeJobFun">
				<input type="hidden" id="jobFunctionId" value=${jf.id }>
				<c:choose>
				<c:when test="${jf.storeNo eq 0}">			
				<span class="zw_txt1 longText" title='HO-<c:if test="${not empty jf.parntDeptId}">${jf.parntDeptName }-</c:if>${jf.deptName }'>
				HO-<c:if test="${not empty jf.parntDeptId}">${jf.parntDeptName }-</c:if>${jf.deptName }
				</span>
				</c:when>
				<c:otherwise>
				<span class="zw_txt1 longText" title='${jf.storeNo }-<c:if test="${not empty jf.parntDeptId}">${jf.parntDeptName }-</c:if>${jf.deptName }'>
				${jf.storeNo }-<c:if test="${not empty jf.parntDeptId}">${jf.parntDeptName }-</c:if>${jf.deptName }
				</span>
				</c:otherwise>
				</c:choose>
				<span class="zw_txt2">${jf.jobFunctionName }</span>
				<span class="zw_icon">
				</span></div></li>
			</c:forEach>
		</c:if>
	</ol>
</div>
<div id="popupWin" class="Panel" style="display: none"></div>
<div id="popupWinTwo" class="Panel" style="display: none"></div>
<script src="${ctx}/shared/js/main/menu.js" charset="gbk" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$(".Logo").unbind("click").bind("click",function(){
		toIndex();
	});
	$(".FavDrop2").bind("click",function(){
		openPopupWin(450,200,'/setting/toChangeUserPreference');
	});
	$(".FavDrop3").bind("click",function(){
		openPopupWin(450,220,'/setting/toChangePassWord');
	});
	$(".FavDrop5").bind("click",function(){
		var message = '<auchan:i18n id="100001018"/>';
		var title = '<auchan:i18n id="100000001"/>';
		logout(title,message);
	});
	pointJobFun();
	if ('${isFirstLogin}'=='true') {
		// 首次登陆后跳出修改密码界面
		//toChangePassWord();
		openPopupWin(450,220,'/setting/toChangePassWord?flag=isFirstLogin');
	}
	buildFavHTML();
});
</script>