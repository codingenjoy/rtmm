(function() {

	/**
	 * 可选配置项
	 */
	var attrs = {
		paginatorElem : 'paginator',
		totalItems : 0,// 总条数
		itemsPerPage : 20,// 每页条数
		page : 1,// 当前显示第几页
		pageSpan : 5,// 最多同时显示多少页
		prevNext : true, // 是否显示上一页/下一页
		firstLast : true, // 是否显示首页/尾页
		showTotal : true, // 是否显示总条数
		psConfigurable : [ 10, 20, 30 ]
	// 每页显示条数是否可配置，若可配置，则传入支持条数的数组，如[20, 50,100]
	};

	function Paginator(lconfig) {
		var prototype = this;
		for ( var i in lconfig)
			prototype[i] = lconfig[i];
		this.__buildUI();
	}
	;

	Paginator.prototype.__buildUI = function() {
		// 计算分页
		this.__calculateTotalPage();
		// render
		var elemId = this.paginatorElem || attrs.paginatorElem;
		var html = this.__render();
		$('#' + elemId).html(html);
		this.__bindEvents($('#' + elemId));
	};

	/**
	 * 绑定事件
	 */
	Paginator.prototype.__bindEvents = function(dom) {
		var paginator = this;
		$(dom).find('a').not("[class$='off']").bind('click', function(e) {
			var page = $(e.srcElement || e.target).data('page');
			paginator.__changePage(page);
		});

		$(dom).find('select').bind('change', function(e) {
			var pageSize = $(e.srcElement || e.target).val();
			paginator.itemsPerPage = pageSize;
			paginator.__changePage(1);// 重置到第一页
		});
		
		$(dom).find('input').bind('change', function(e) {
			
			var goPage = $(e.srcElement || e.target).val();
			if (!goPage || !goPage.match(/^\d+$/)) {
				$(this).addClass('errorInput');
				$(this).attr('title', '输入必须为整数');
				$(this).focus();
				return true;
			}else if (goPage < 1 || goPage > paginator.__totalPages){
				$(this).addClass('errorInput');
				$(this).attr('title', '跳转的页码不存在');
				$(this).focus();
				return true;
			}else{
				$(this).removeClass('errorInput');
				$(this).attr('title', '');
			}
			paginator.__changePage(goPage);// 跳转到指定页
		});
	};

	/**
	 * 绑定事件
	 */
	Paginator.prototype.__unBindEvents = function(dom) {
		$(dom).find('a').unbind('click');
		$(dom).find('select').unbind('change');
		$(dom).find('input').unbind('change');
	};
	/**
	 * 计算总页数
	 */
	Paginator.prototype.__calculateTotalPage = function() {
		var paginator = this;
		var totalItems = paginator.totalItems || attrs.totalItems;
		var itemsPerPage = paginator.itemsPerPage || attrs.itemsPerPage;
		var curPage = paginator.page || attrs.page;
		paginator.itemsPerPage = itemsPerPage;
		paginator.pageSpan = paginator.pageSpan || attrs.pageSpan;
		paginator.__page = curPage;
		paginator.__totalPages = Math.ceil(totalItems / itemsPerPage);
	};

	/**
	 * 生成所有分页的HTML结构
	 */
	Paginator.prototype.__render = function() {
		var paginator = this;
		var totalItems = paginator.totalItems;
		var totalPages = paginator.__totalPages;
		var page = Math.min(paginator.__page, totalPages);
		var pageSpan = paginator.pageSpan;
		var half = (paginator.pageSpan / 2) | 0;
		var itemsPerPage = paginator.itemsPerPage;
		var markup = '', disabled = false, start1, end1, start2, end2;

		// 不足一页的不显示哦
		if (totalPages < 1) {
			return markup;
		}

		// 显示x-xx项
		markup += '<div class="fl_left">' + (parseInt((page - 1) * itemsPerPage,10) + 1)
				+ '-' + parseInt(page * itemsPerPage,10);
		markup += '项';

		// 共xx项
		if (paginator.showTotal || attrs.showTotal) {
			markup += '共' + totalItems + '项 &nbsp;&nbsp;';
		}
		
		// 每页显示xx项
		if (paginator.psConfigurable || attrs.psConfigurable) {
			var sizes = paginator.psConfigurable || attrs.psConfigurable;
			markup += '|&nbsp;每页显示 <select>';
			for (var i = 0, len = sizes.length; i < len; i++) {
				markup += '<option value="' + sizes[i] + '" '
						+ (sizes[i] == itemsPerPage ? 'selected' : '') + '>'
						+ sizes[i] + '</option>';
			}
			markup += '</select>项';
		}
		markup += '</div>';

		markup += '<div class="fl_right page_list2">';
		// 首页
		if (paginator.firstLast || attrs.firstLast) {
			disabled = page <= 1;
			markup += paginator.__getFirstLast(1, '首页', 'page_first_block',
					disabled);
		}

		// 上一页
		if (paginator.prevNext || attrs.firstLast) {
			disabled = page === 1;
			markup += paginator.__getFirstLast(page - 1, '上一页',
					'page_prev_block', disabled);
		}

		// 当前页之前的分页链接，半闭区间[start1, end1)
		start1 = Math.max(Math.min(page - half, totalPages - pageSpan), 1);
		end1 = page;
		for (i = start1; i < end1; i++) {
			markup += paginator.__getPageMarkup(i);
		}

		// 当前页
		markup += '<a title="' + page + '" class="click_block">' + page
				+ '</a>';

		// 当前页之后的分页链接，半闭区间[start2, end2)
		start2 = page + 1;
		end2 = Math.min(Math.max(page + half, start1 + pageSpan), totalPages);
		for (i = start2; i < end2; i++) {
			markup += paginator.__getPageMarkup(i);
		}

		// 下一页
		if (paginator.prevNext || attrs.firstLast) {
			disabled = page >= totalPages;
			markup += paginator.__getFirstLast(page + 1, '下一页',
					'page_next_block', disabled);
		}

		// 末页
		if (paginator.firstLast || attrs.firstLast) {
			disabled = page >= totalPages;
			markup += paginator.__getFirstLast(totalPages, '末页',
					'page_end_block', disabled);
		}
		
		markup += '<span style="margin-right:10px;">&nbsp;&nbsp;&nbsp;到第 ';
		markup += '<input id="goto_page" class="page_no_input2" maxlength="5" type="text">';
		markup += '页</span>';
		markup += '</div>';
		return markup;
	};

	/**
	 * 生成某一页的HTML结构
	 */
	Paginator.prototype.__getPageMarkup = function(page) {
		return ('<a title="' + page + '" data-page="' + page + '">' + page + '</a>');
	};

	/**
	 * 生成首页,上一页，下一页，尾页的HTML结构
	 */
	Paginator.prototype.__getFirstLast = function(page, text, className,
			disabled) {
		if (disabled) {
			className += '_off';
		}
		return ('<a title="' + text + '" class="' + className + '" data-page="'
				+ page + '"></a>');
	};

	/**
	 * 改变页码
	 */
	Paginator.prototype.__changePage = function(page) {
		var itemsPerPage = this.itemsPerPage;
		this.callback(page, itemsPerPage);
	};

	/*
	 * 注销事件，将element从DOM中删除
	 */
	Paginator.prototype.destroy = function() {
		
		var elemId = this.paginatorElem || attrs.paginatorElem;
		// 注销事件
		this.__unBindEvents($('#' + elemId));
		$('#' + elemId).remove();
		for ( var propName in this) {
			this[propName] = null;
			delete this[propName];
		}
	};

	this.Paginator = Paginator;
})();
