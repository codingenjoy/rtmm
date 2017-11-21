var p_attrId = null;

// 创建课别信息
function createSection() {
	openPopupWin(615, 300, '/catalog/createSection');
}

//修改课信息
function updateSection() {
	openPopupWin(615, 300, '/catalog/updateSection?');
}

//修改课信息
function updateSection(catlgId) {
	openPopupWin(615, 300, '/catalog/updateSection?catlgId='+catlgId);
}

function pageQuery(divisionId) {
	
	$('#divisionId').attr('value',divisionId);
	var param = $("#queryFrom").serialize();
	$.ajax({
		type : "post",
		data : param,
		dataType : "html",
		url : ctx + '/catalog/getSectionByPage',
		success : function(data) {
			$('#section_content').html(data);
		}
	});
}

