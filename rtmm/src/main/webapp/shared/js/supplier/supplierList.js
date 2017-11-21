;
if (typeof (Supplier) == "undefined") {
	Supplier = {};
};
Supplier.list = {
	// 查询用户
	getParam : function() {
		var queryParam = {
			supNo : $("#supNo").val(),
			comNo : $("#comNo").val(),
			supType : $("#supType").val(),
			dlvryMethd : $("#dlvryMethd").val(),
			buyMethd : $("#buyMethd").val(),
			cntrtType : $("#cntrtType").val(),
			catlgId : $("#catlgId").val(),
			rtnAllow : $("#rtnAllow").val(),
			cataStatus : $("#cataStatus").val(),
			paySttus  : $("#paySttus").val(),
			apAmtSt   : $("#apAmtSt").val(),
			apAmtEd   : $("#apAmtEd").val(),
			bpDiscSt : $("#bpDiscSt").val(),
			bpDiscEd : $("#bpDiscEd").val(),
			invdiscSt : $("#invdiscSt").val(),
			invdiscEd : $("#invdiscEd").val(),
			othDiscSt : $("#othDiscSt").val(),
			othDiscEd : $("#othDiscEd").val(),
			storeNo : $("#storeNo").val()
		};
		return queryParam;
	},
	reloadSupplier : function() {
		$('#dg').datagrid('load', supplierList.getParam());
	},
	serachSuppiler : function() {
		$('#dg').datagrid({
			url : ctx + '/supplier/getSupplierByPage',
			pagination : true,
			singleSelect : true,
			queryParams : supplierList.getParam(),
			pageSize : 10,
			columns : [ [
					{
						field : 'supNo1',
						title : '采购厂编',
						sortable : true,
						align : 'right',
						halign : 'center',
						width : '69',
						formatter : function(val, rec) {
							return rec.supNo + "&nbsp;&nbsp;";
						}
					},
					{
						field : 'comNo',
						title : '公司编号',
						align : 'left',
						halign : 'center',
						width : '92'
					},
					{
						field : 'comName',
						title : '公司',
						align : 'left',
						halign : 'center',
						width : '232',
						formatter : function(val, rec) {
							return '<div title='+rec.comName+'>'+rec.comName+'</div>';
						}
					},
					{
						field : 'supType',
						title : '厂商种类',
						align : 'left',
						halign : 'center',
						width : '174',
						formatter : function(val, rec) {
							if (rec.supType && rec.supType != null) {
								return getDictValue('SUPPLIER_SUP_TYPE',rec.supType);
							} else {
								return '';
							}
						}
					},
					{
						field : 'dlvryMethd',
						title : '供货方式',
						align : 'left',
						halign : 'center',
						width : '92',
						formatter : function(val, rec) {
							if (rec.dlvryMethd && rec.dlvryMethd != null) {
								return getDictValue('SUPPLIER_DLVRY_METHD',rec.dlvryMethd);
							} else {
								return '';
							}
						}
					},
					{
						field : 'buyMethd',
						title : '采购方式',
						align : 'left',
						halign : 'center',
						width : '93',
						formatter : function(val, rec) {
							if (rec.buyMethd && rec.buyMethd != null) {
								return getDictValue('SUPPLIER_BUY_METHD',rec.buyMethd);
							} else {
								return '';
							}
						}
					},
					{
						field : 'cntrtType',
						title : '合同标准',
						align : 'left',
						halign : 'center',
						width : '93',
						formatter : function(val, rec) {
							if (rec.cntrtType && rec.cntrtType != null) {
								return getDictValue('SUPPLIER_CONTRT_TYPE',rec.cntrtType);
							} else {
								return '';
							}
						}
					} ,
					{
						field : 'status',
						title : '状态',
						align : 'left',
						halign : 'center',
						width : '93',
						formatter : function(val, rec) {
							if (rec.status && rec.status != null) {
								return getDictValue('SUPPLIER_STATUS',rec.status);
							} else {
								return '';
							}
						}
					} ,
					{
						field : 'validEndDate',
						title : '有效期',
						align : 'left',
						halign : 'center',
						width : '93',
						formatter : function(val, rec) {
							if(rec.validEndDate){
								return new Date(rec.validEndDate).format('yyyy-MM-dd');
							}else{
								return '';
							}
						}
					} ] ],
			onClickRow : function(rowIndex, rowData) {
				
			},
			onDblClickRow : function(rowIndex, rowData) {
				showContent(ctx + '/supplier/doGeneralSearch?supNo=' + rowData.supNo + '&comNo=' + rowData.comNo);
			}
		});
	}
};
var supplierList = Supplier.list;