(function() {

	/**
	 * 可选配置项
	 */
	var defaults = {
		selector : "#toolbar",
		Tools1 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools2 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools3 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools10 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools11 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools12 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools16 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools17 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools18 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools19 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools20 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools21 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools22 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools24 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools25 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools26 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools27 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools28 : {
			enable : false,
			callback : function() {
				
			}
		},
		Tools29 : {
			enable : false,
			callback : function() {
				
			}
		}
	};

	var ToolBar = function(options) {
		this.container = $(defaults.selector);
		defaults = extend(defaults, options);
		var html = this.getTemplate();
		this.container.html(html);
		this.init();
	};

	ToolBar.prototype.init = function() {
		for ( var tid in defaults) {
			var toolbar = defaults[tid];
			if (toolbar && toolbar.enable)
				this.enable(tid, toolbar.callback);
			else
				this.disable(tid);
		}
	};

	ToolBar.prototype.reset = function(options) {
		defaults = extend(defaults, options);
		this.init();
	};
	
	ToolBar.prototype.getDefaults = function() {
		return defaults;
	};

	ToolBar.prototype.enable = function(tid, callback) {
		defaults[tid].enable = true;
		defaults[tid].callback = callback;
		var toolbar = this.container.find('#' + tid);
		toolbar.removeClass(tid + '_disable').addClass(tid);
		toolbar.unbind('click').bind('click', callback);
	};

	ToolBar.prototype.disable = function(tid) {
		defaults[tid].enable = false;
		var toolbar = this.container.find('#' + tid);
		toolbar.removeClass(tid).addClass(tid + '_disable');
		toolbar.unbind('click');
	};

	/**
	 * 生成所有页面的HTML结构
	 */
	ToolBar.prototype.getTemplate = function() {
		var markup = '';
		markup += '<div class="ToolBar">';
		markup += '<div class="SearchTool"><div id="Tools1" class="Icon-size1 Tools1_disable B-id"></div></div>';
		markup += '<table><tr>';
		markup += '<td class="Line-1"></td>';
		markup += '<td id="Tools2" class="Tools2_disable"></td><td></td>';
		markup += '<td id="Tools3" class="Tools3_disable"></td><td></td>';
		markup += '<td id="Tools23" class="Tools23_disable"></td><td></td>';
		markup += '<td class="Line-1"></td>';
		markup += '<td id="Tools6" class="Tools6_disable"></td>';
		markup += '<td></td>';
		markup += '<td id="Tools20" class="Tools20_disable"></td>';
		markup += '<td class="Line-1"></td>';
		markup += '<td id="Tools11" class="sh_newMac Tools11_disable"></td><td></td>';
		markup += '<td id="Tools10" class="Tools10_disable"></td><td></td>';
		markup += '<td id="Tools12" class="Tools12_disable"></td>';
		markup += '<td class="Line-1"></td>';
		markup += '<td id="Tools16" class="Tools16_disable"></td><td></td>';
		markup += '<td id="Tools17" class="Tools17_disable"></td><td></td>';
		markup += '<td id="Tools19" class="Tools19_disable"></td><td></td>';
		markup += '<td id="Tools18" class="Tools18_disable"></td>';
		markup += '<td class="Line-1_disable"></td>';
		markup += '<td id="Tools24"  class="Tools24_disable"></td><td></td>';
		markup += '<td id="Tools25"  class="Tools25_disable"></td><td></td>';
		markup += '<td id="Tools26"  class="Tools26_disable"></td>';
		markup += '<td class="Line-1"></td>';
		markup += '<td id="Tools27"  class="Tools27_disable"></td><td></td>';
		markup += '<td id="Tools28"  class="Tools28_disable"></td>';
		markup += '<td class="Line-1"></td>';
		markup += '<td id="Tools29"  class="Tools29_disable"></td>';
		markup += '</tr></table>';
		markup += '<div class="RightTool"><div id="Tools22" class="Icon-size1 Tools22_disable" title="content"></div></div>';
		markup += '<div class="RightTool"><div id="Tools21" class="Icon-size1 Tools21_disable" title="list"></div></div> ';
		markup += '</div>';
		return markup;
	};

	/*
	 * 注销事件，将element从DOM中删除
	 */
	ToolBar.prototype.destroy = function() {
		// 注销事件
		this.__unBindEvents();
		this.container.remove();
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

	this.ToolBar = ToolBar;
})();
