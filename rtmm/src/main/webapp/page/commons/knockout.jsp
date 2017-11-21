<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript" src="${ctx}/shared/js/knockout/knockout-latest.debug.js"></script>
<script type="text/javascript" src="${ctx}/shared/js/knockout/knockout.validation.js"></script>
<script type="text/javascript" src="${ctx}/shared/js/knockout/knockout.mapping.js"></script>
<script type="text/javascript">
	ko.validation.init({
		insertMessages : false,
		errorClass : 'errorInput',
		grouping : {
			deep : true
		}
	});
</script>