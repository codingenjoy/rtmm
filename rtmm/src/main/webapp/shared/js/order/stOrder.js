/**
 * author:wanghai
 * create date:2015/1/9
 */

/**
 *check the validity of the stOrderEndDate.
 */
function stOrderEndDateQuery(dp){
	$("#ordDateEnd").attr('title','');
	$("#ordDateEnd").removeClass('errorInput');
	var orderBeginDate=$("#ordDateBegin").val();
	var orderEndDate= dp.cal.getNewDateStr();
	if(orderBeginDate){		
		var subDays=getSubDays(orderBeginDate,orderEndDate);
		if(subDays<0){
			$("#ordDateEnd").attr('title','结束日期小于开始日期');
			$("#ordDateEnd").addClass('errorInput');
			return false;
		}
	} 
}

/**
 *check the validity of the stOrderStartDate.
 */
function stOrderStartDateQuery(dp){
	$("#ordDateEnd").attr('title','');
	$("#ordDateEnd").removeClass('errorInput');
	var orderEndDate=$("#ordDateEnd").val();
	var orderBeginDate= dp.cal.getNewDateStr();
	if(orderEndDate){		
		var subDays=getSubDays(orderBeginDate,orderEndDate);
		if(subDays<0){
			$("#ordDateEnd").attr('title','结束日期小于开始日期');
			$("#ordDateEnd").addClass('errorInput');
			return false;
		}
	} 
}

/**
 *check the validity of the stOrderPlanRecptEndDate.
 */
function stOrderPlanRecptEndDateQuery(dp){
	$("#planRecptDateEnd").attr('title','');
	$("#planRecptDateEnd").removeClass('errorInput');
	var planRecptBeginDate=$("#planRecptDateBegin").val();
	var planRecptEndDate= dp.cal.getNewDateStr();
	if(planRecptBeginDate){		
		var subDays=getSubDays(planRecptBeginDate,planRecptEndDate);
		if(subDays<0){
			$("#planRecptDateEnd").attr('title','结束日期小于开始日期');
			$("#planRecptDateEnd").addClass('errorInput');
			return false;
		}
	} 
}

/**
 *check the validity of the stOrderPlanRecptStartDate.
 */
function stOrderPlanRecptStartDateQuery(dp){
	$("#planRecptDateEnd").attr('title','');
	$("#planRecptDateEnd").removeClass('errorInput');
	var planRecptEndDate=$("#planRecptDateEnd").val();
	var planRecptBeginDate= dp.cal.getNewDateStr();
	if(planRecptEndDate){		
		var subDays=getSubDays(planRecptBeginDate,planRecptEndDate);
		if(subDays<0){
			$("#planRecptDateEnd").attr('title','结束日期小于开始日期');
			$("#planRecptDateEnd").addClass('errorInput');
			return false;
		}
	} 
}

/**
 *check the validity of the stOrderRealRecptEndDate.
 */
function stOrderRealRecptEndDateQuery(dp){
	$("#realRecptDateEnd").attr('title','');
	$("#realRecptDateEnd").removeClass('errorInput');
	var realRecptBeginDate=$("#realRecptDateBegin").val();
	var realRecptEndDate= dp.cal.getNewDateStr();
	if(realRecptBeginDate){		
		var subDays=getSubDays(realRecptBeginDate,realRecptEndDate);
		if(subDays<0){
			$("#realRecptDateEnd").attr('title','结束日期小于开始日期');
			$("#realRecptDateEnd").addClass('errorInput');
			return false;
		}
	} 
}

/**
 *check the validity of the stOrderRealRecptStartDate.
 */
function stOrderRealRecptStartDateQuery(dp){
	$("#realRecptDateEnd").attr('title','');
	$("#realRecptDateEnd").removeClass('errorInput');
	var realRecptEndDate=$("#realRecptDateBegin").val();
	var realRecptBeginDate= dp.cal.getNewDateStr();
	if(realRecptEndDate){		
		var subDays=getSubDays(realRecptBeginDate,realRecptEndDate);
		if(subDays<0){
			$("#realRecptDateEnd").attr('title','结束日期小于开始日期');
			$("#realRecptDateEnd").addClass('errorInput');
			return false;
		}
	}  
}