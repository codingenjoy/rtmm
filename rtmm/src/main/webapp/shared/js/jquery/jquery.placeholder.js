//@charset "utf-8";
/**
 * jquery版本要求：1.3 ~ 1.8，HTML声明请遵循W3C标准 用来模拟HTML5 input标签的placeholder属性的插件
 * 兼容IE6、7、8、9浏览器
 */
$(function($) {
	// 判断浏览器是否支持input框的placeholder属性
	function isInputPlaceholder() {
		var input = document.createElement('input');
		return 'placeholder' in input;
	}
	// 判断浏览器是否支持textArea框的placeholder属性
	function isTextAreaPlaceholder() {
		var textarea = document.createElement('textarea');
		return 'placeholder' in textarea;
	}

	if (!isInputPlaceholder()) {
		var originalColor = '';
		// 把input绑定事件,排除password框
		$("input").not("input[type='password']").each(function() {
			if ($(this).val() == "" && $(this).attr("placeholder")) {
				$(this).val($(this).attr("placeholder"));
				originalColor = $(this).css('color');
				$(this).css('color', '#C9C9C9');
				$(this).focus(function() {
					if ($(this).val() == $(this).attr("placeholder")) {
						$(this).val("");
						$(this).css('color', originalColor);
					}
				});
				$(this).blur(function() {
					if ($(this).val() == "") {
						$(this).css('color', '#C9C9C9');
						$(this).val($(this).attr("placeholder"));
					}
				});
			}
		});

		// 对password框的特殊处理1.创建一个text框 2获取焦点和失去焦点的时候切换
		$("input[type='password']").each(
				function(index) {
					if ($(this).attr("placeholder") != "") {
						var pwdField = $(this);
						var pwdVal = pwdField.attr('placeholder');
						pwdField.after('<input id="pwdPlaceholder_' + index
								+ '" type="text" value=' + pwdVal
								+ ' autocomplete="off"/>');
						var pwdPlaceholder = $('#pwdPlaceholder_' + index);
						pwdPlaceholder.css('color', '#C9C9C9');
						pwdPlaceholder.show();
						pwdField.hide();
						pwdPlaceholder.focus(function() {
							pwdPlaceholder.hide();
							pwdField.show();
							pwdField.focus();
						});
						pwdField.blur(function() {
							if (pwdField.val() == '') {
								pwdPlaceholder.show();
								pwdField.hide();
							}
						});
					}
				});
	}
	
	if (!isTextAreaPlaceholder()) {
		var originalColor = '';
		// 把textarea绑定事件
		$("textarea").each(function() {
			if ($(this).val() == "" && $(this).attr("placeholder")) {
				$(this).val($(this).attr("placeholder"));
				originalColor = $(this).css('color');
				$(this).css('color', '#C9C9C9');
				$(this).focus(function() {
					if ($(this).val() == $(this).attr("placeholder")) {
						$(this).val("");
						$(this).css('color', originalColor);
					}
				});
				$(this).blur(function() {
					if ($(this).val() == "") {
						$(this).css('color', '#C9C9C9');
						$(this).val($(this).attr("placeholder"));
					}
				});
			}
		});
	}
});