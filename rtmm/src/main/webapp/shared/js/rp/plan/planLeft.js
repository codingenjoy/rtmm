
/*
 * 课别弹出框的方法
 */
function showCatlgWin(/*Node*/catlgElem){
	top.openPopupWin(602,180,'/rp/plan/showCatlgWin');
}
/*
 * 课别弹出框的返回方法
 */
function addCatlgReturn(/*String*/catlgId,/*String*/catlgName){
	 if(catlgId&&catlgName){
		$("#CatlgId").val(catlgId);
		$("#CatlgName").val(catlgName);
	  }
	  top.closePopupWin();
}
/*查询方法*/
function searchRpPlan(){
	showListPage();
}

/*清除的方法*/
function clearInput(){
	$(".cleanInput").val("");
}
/*
 * 用户按下按键的时候出发此方法
 */
function doSearchCatlgKeyin(/*envent*/evet,/*Node*/catlgElem){
	doCheckInputEvent(evet,catlgElem);
}
/*
 * 当光标移出课别的输入框时候，调用此方法
 */
function doSearchCatlg(/*Node*/catlgElem){
	var sectionNo = catlgElem.value;
	if(sectionNo==null || sectionNo ==""){return;}
	$.ajax( {
		type : 'post',
		url : ctx + '/catalog/searchSectionMessAction',
		data : {
			catlgId : sectionNo},
		success : function(data) {
			var sectionInfoVO = data.sectionInfoVO;
			if (sectionInfoVO != null) {
				$("#CatlgName").val(sectionInfoVO.catlgName);
			} else {
				top.jWarningAlert("没有找到对应信息, 请重新输入");
				$("#CatlgName").val('');
				$("#CatlgId").val('');
			}
		}
	});
}
function enterShow(evt) {
	 var evt=evt?evt:(window.event?window.event:null);//兼容IE和FF
	 if (evt.keyCode==13){
		showListPage();
	 }else if (evt.keyCode==8){
		 return;
	 }
}


