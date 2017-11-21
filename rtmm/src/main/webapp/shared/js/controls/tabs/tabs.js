(function() {

	/**
	 * 可选配置项
	 */
	var defaults = {
		selector : "#tabs",
		activeIndex : 0,
		toolbar : null
	};

	var Tabs = function(options) {
		
		this.container = $(defaults.selector);
		
		defaults = extend(defaults, options);
	
		this.init();
	};

	Tabs.prototype.createNew = function(title, url, closeable, callback) {
		
		var tab = this;
		if (isFunction(closeable)) {
			callback = closeable;
			closeable = undefined;
		}
		
		var tabNavHTML = null;
		if (this.__getTabSize() == 0) {
			tabNavHTML = this.__getFirstTemplate(title);
		} else {
			this.container.find('#tabs-nav').find('div:last').remove();
			tabNavHTML = this.__getMiddleTemplate(title);
		}
		this.container.find('#tabs-nav').append(tabNavHTML);
		this.container.find('#tabs-nav').find('div:last').data('nav-data', {
			title : title,
			url : url
		});
		
		if (closeable) {
			var lastDiv = this.container.find('#tabs-nav').find('div:last');
			lastDiv.append('<span class="closeable"></span>');
			lastDiv.find('.closeable').unbind('click').bind('click',function(e) {
				var index = tab.__getTabIndexByAnyMember($(this).parent()[0]);
				tab.__removeTab(index);
				tab.__initTabStyle();
			});
		}
		this.container.find('#tabs-nav').append(this.__getLastTemplate());

		$.ajax({
			url:url,
			beforeSend:function(){
			},
			complete:function(){
				callback(toolbar);
			},
			dataType:'html',
			success:function(data){
				tab.container.find('#tabs-content').append(data);
				tab.__bindEvents();
				var size = tab.__getTabSize();
				tab.setActiveTab(size);
				tab.__initTabStyle();	
			}
		});
		
		/*
		tab.container.find('#tabs-content').append('<div class="Container-1">测试' + title + '</div>');
		tab.__bindEvents();
		var size = tab.__getTabSize();
		tab.setActiveTab(size);
		this.__initTabStyle();*/

	};

	Tabs.prototype.__showTabList = function() {
		var moreTab = this.container.find('#tabs-nav').next();
		moreTab.show();
		var tab = this;
		moreTab.unbind('click').bind('click', function(e) {
			if (e.srcElement.nodeName == "DIV")
				tab.__buildTabList();
		});
	};

	Tabs.prototype.__hideTabList = function() {
		var moreTab = this.container.find('#tabs-nav').parent().next();
		moreTab.hide();
	};

	Tabs.prototype.__buildTabList = function() {
		
		var tab = this;
		var tabs = $('#tabs-nav').find('div:not(.tabEnd)');
		var tabList = $(this.container.find('#tabs-nav').parent().next()[0]);
		tabList.children().remove();
		$.each(tabs, function(index, elem) {
			var data = $(elem).data('nav-data');
			tabList.append('<li>' + data.title + '</li>');
			tabList.find('li:last').unbind('click').bind('click', function(e) {
				var index = tab.__getTabIndexByAnyMember(this);
				var $checked=tab.setActiveTab(index);
				
				tab.__hideTabList();
				tab.__activeMove($checked);
			});
		});
		tabList.show();
	};

	Tabs.prototype.__getTabIndexByAnyMember = function(/* Node */anyMemberIn) {
		var counter = 0;
		var tmpNode = anyMemberIn;
		while (tmpNode != null) {
			tmpNode = tmpNode.previousSibling;
			if (tmpNode && tmpNode.nodeType == 1)
				counter++;
		}
		return counter;
	};

	Tabs.prototype.__bindEvents = function() {
		var tab = this;
		var tabs_nav = this.container.find('#tabs-nav').find('div');
		tabs_nav.unbind('click').bind('click', function() {
			var index = tab.__getTabIndexByAnyMember(this);
			tab.setActiveTab(index);
		});
	};

	Tabs.prototype.__getTabSize = function() {
		var size = this.container.find('#tabs-nav').find('div').size();
		if (size > 1)
			size -= 1;
		return size;
	};

	Tabs.prototype.setActiveTab = function(index) {
		var tabSize = this.__getTabSize();
		index = index > (tabSize - 1) ? (tabSize - 1) : index;
		this.__beforeActiveTab();
		var elem = this.container.find('#tabs-nav').find('div')[index];
		this.container.find('.firstChecked').removeClass('firstChecked');
		this.container.find('.middleChecked').removeClass('middleChecked');
		if (index == 0) {
			$(elem).addClass('firstChecked');
		} else {
			$(elem).addClass('middleChecked');
		}
		for (var i = 0; i < this.__getTabSize(); i++) {
			$(this.container.find('#tabs-content').find('div')[i]).hide();
		}
		$(this.container.find('#tabs-content').find('div')[index]).show();
		this.__afterActiveTab(index);
	};
	
	Tabs.prototype.__beforeActiveTab = function() {
		var tab = this;
		if(defaults.toolbar){
			var elem = this.container.find('.firstChecked')||this.container.find('.middleChecked');
			var index = tab.__getTabIndexByAnyMember(elem);
			$(this.container.find('#tabs-nav').find('div')[index]).data('toolbar-data',toolbar.getDefaults());
		}
	};
	
	Tabs.prototype.__afterActiveTab = function(index) {
		if(defaults.toolbar){
			var options = $(this.container.find('#tabs-nav').find('div')[index]).data('toolbar-data');
			toolbar.reset({});
			toolbar.reset(options);
		}
	};

	Tabs.prototype.__removeTab = function(index) {
		$(this.container.find('#tabs-nav').find('div')[index]).remove();
		$(this.container.find('#tabs-content').find('div')[index]).remove();
		if (index >= 1)
			this.setActiveTab(index - 1);
	};

	Tabs.prototype.init = function() {
		var html = this.__getContainerTemplate();
		this.container.html(html);
	};

	Tabs.prototype.__getContainerTemplate = function() {
		var markup = '';
		markup += '<div class="spanner">';
		markup += '<div id="tabs-nav" class="spannerTabs"></div>';
		markup += '<div class="tabBtn" style="display:none;"></div>';
		markup += '</div>';
		markup += '<ol class="tabList" style="display:none;"></ol>';
		markup += '<div id="tabs-content" class="contentPanel"></div>';
		return markup;
	};

	Tabs.prototype.__getFirstTemplate = function(title) {
		return '<div class="firstTab"><span class="tabText">' + title
				+ '</span></div>';
	};

	Tabs.prototype.__getLastTemplate = function() {
		return '<div class="tabEnd"></div>';
	};

	Tabs.prototype.__getMiddleTemplate = function(title) {
		return '<div class="middleTab"><span class="tabText">' + title
				+ '</span></div>';
	};
	
	/*
	 * tabs的宽度是否超出 返回值超出的宽度number类型，正数表示超出多少，负数表示没超出
	 */
	Tabs.prototype.__isOutRange = function() {
		
		var spannerWidth = $("#tabs-nav").parent().outerWidth();
		var btnWidth = $(".tabBtn").outerWidth();
		var flag = this.__getTabWidth() + btnWidth - spannerWidth;

		return flag;
	};
	
	/*
	 * 计算并返回tabs的宽度
	 */
	Tabs.prototype.__getTabWidth = function() {
		var middleWidth = 5;
		$("#tabs-nav .middleTab").each(function() {
			middleWidth += $(this).outerWidth();
		});
		var otherWidth = $(".firstTab").outerWidth()
				+ $(".tabEnd").outerWidth();
		return otherWidth + middleWidth;
	};
	
	/*
	 * 设置tabs的宽度
	 */
	Tabs.prototype.__setTabWidth = function() {
		$(".spannerTabs").css("width", this.__getTabWidth() + "px");
	};
	
	/*
	 * 设置tabBtn的显示和隐藏 flag(可选，默认隐藏) - boolean值，true代表显示，false代表隐藏
	 */
	Tabs.prototype.__displayBtn = function(flag) {
		var tab = this;
		var disp = flag ? "block" : "none";
		$(".tabBtn").css("display", disp);
		$(".tabBtn").unbind('click').bind('click', function(e) {
			tab.__showTabList();
		});
	};
	
	/*
	 * Tab移动 distance number类型，移动的距离 $obj - 需要移动的jQuery对象，可选项，默认为$("#tabs-nav"）
	 * time - number类型，移动花费的时间，可选，默认100(ms)
	 */
	Tabs.prototype.__moveTabs = function(distance, $obj, time) {

		$obj = $.type($obj) == "object" ? $obj : $("#tabs-nav");
		if ($.type($obj) == "number") {
			time = $obj;
		} else if ($.type(time) == "number") {

		} else {
			time = 300;
		}
		// 多移动20(px)
		distance = distance == 0 ? 0 : distance + 20;
		distance >= 0 ? $obj.animate({
			"left" : distance * (-1) + "px"
		}, time) : undefined;
	};
	
	/*
	 * 初始化Tab段HTML的样式
	 */
	Tabs.prototype.__initTabStyle = function() {
		this.__setTabWidth();
		var distance = this.__isOutRange();// Tab总宽度超出规定范围的距离
		var leftVal = $("#tabs-nav").css("left");
		var left = parseInt(leftVal.substring(0, leftVal.length - 2));
		if (distance > 0) {
			this.__displayBtn(true);
			this.__moveTabs(distance);
		} else {
			
			if (left < 0) {
				this.__displayBtn(false);
				this.__moveTabs(0);
			}
		}
	};

	/*
	 * 注销事件，将element从DOM中删除
	 */
	Tabs.prototype.destroy = function() {

		var elemId = this.TabElem || defaults.TabElem;
		// 注销事件
		this.__unBindEvents($('#' + elemId));
		$('#' + elemId).remove();
		for ( var propName in this) {
			this[propName] = null;
			delete this[propName];
		}
	};

	function extend(target) {
		var argObj;
		for (var i = 1, l = arguments.length; i < l; i++) {
			argObj = arguments[i];
			if (isObject(argObj)) {
				for ( var prop in argObj) {
					if (argObj.hasOwnProperty(prop)) {
						target[prop] = argObj[prop];
					}
				}
			}
		}
		return target;
	}

	function isObject(value) {
		return {}.toString.call(value) === "[object Object]";
	}

	function isFunction(/* Object */obj) {
		return $.type(obj) === "function";
	}

	this.Tabs = Tabs;
})();
