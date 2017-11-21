
	var itemsUploadPhotos = new Array();//当前单个商品下所有图片信息

	var itemsIndex = 0;
	var list = new Array();
	$(".photo").live("mouseover", function() {
		var t = $(this).offset().top;
		var l = $(this).offset().left;
		$("#_photo").css({
			"top" : t,
			"left" : l,
			"display" : "block"
		});
		$("#_photo").attr("x", $(this).attr("id"));
	});
	$("#p1").live('click', function() {
		$(".photo").find("img").attr("dz", "0");
		var tx = "#" + $(this).parent().attr("x");
		$(tx).find("img").attr("dz", "1");
		var t = $(this).offset().top;
		var l = $(this).offset().left;
		$("#dz1").css({
			"top" : t,
			"left" : l,
			"display" : "block"
		});
	});

	$("#set_itemPic_p1").unbind("click").live("click", function() {
		var info = $(this).parent().attr("x");
		top.jConfirm('确定把这张图片设置到首页显示么？', '提示消息', function(ret) {
			//返回ret，点击确定返回true,点击取消返回false
			if (ret) {
				//这里设置信息
				updateItemPicInfos(info);
				//$("#_photo").css("display", "none");
			}
		});

	});
	$("#read_itemPic_p2").live("click", function() {
		$("#update_pp3").empty();
		var tx = "#" + $(this).parent().attr("x");
		list = $("#photos").find("img");
		/*   for (var i = 0; i < list.length; i++) {
		     alert($(list[i]).attr("src"));
		 } */
		//获取下标信息             
		for ( var i=0 ;i<itemsUploadPhotos.length;i++) {
			var link =ufs+$(this).parent().attr("x");
			if (itemsUploadPhotos[i] == link) {
				itemsIndex = parseInt(i);
				$("#update_pp3").text("当前第"+(itemsIndex+1)+"张，共"+itemsUploadPhotos.length+"张");
			}
		}
		$("#update_p").css({
			"top" : 0,
			"left" : 0,
			"display" : "block",
			"width" : screen.width,
			"height" : "690px"
		});
		//$("#_p").empty();
		$("#update_pp2").attr("src", $(tx + " img").attr("src"));
	});
	$("#delete_itemPic_p3").unbind("click").bind("click", function() {
		var tx = "#" + $(this).parent().attr("x");
		var info = $(this).parent().attr("x");

		top.jConfirm('要删除该图片信息么？', '提示消息', function(ret) {
			//返回ret，点击确定返回true,点击取消返回false
			if (ret) {
				//删除操作，从数据库删除该信息
				deleteItemPicInfos("${currentItemNo}", info);
                      
				//移除集合中的图片信息
				 for(var index =0; index<itemsUploadPhotos.length;index++){
					 
					 var link=ufs+info;
					 if(link==itemsUploadPhotos[index]){
                         //移除当前图片链接
						 itemsUploadPhotos.splice(index,1);
						 }
					  }                             
				$(tx).remove();
				$("#_photo").css("display", "none");
			}
		});
	});
	$("#dz1").live('click', function() {
		$(".photo").find("img").attr("dz", "0");
		$(this).css("display", "none");
	});
	$("#closePicBtn").live("click", function() {
		$("#update_p").css("display", "none");
	});
	$("#update_prev_brower").live("mouseover", function() {
		$(this).addClass("prev_brower_bg");
	});
	$("#update_prev_brower").live("mouseout", function() {
		$(this).removeClass("prev_brower_bg");
	});
	$("#update_next_brower").live("mouseover", function() {
		$(this).addClass("next_brower_bg");
	});
	$("#update_next_brower").live("mouseout", function() {
		$(this).removeClass("next_brower_bg");
	});

	/*  $("#photos").parent().delegate(".photo","mouseleave",function(){
		//	
		$("#_photo").css({"display":"none"});
	});  */
	$("#uploadPicInfo").delegate("#_photo", "mouseleave", function() {
		$("#_photo").css({
			"display" : "none"
		});
	});
	$("#update_next_brower")
			.unbind("click")
			.bind(
					"click",
					function() {
						$("#update_pp3").empty();
						if (typeof (itemsUploadPhotos[itemsIndex + 1]) != 'undefined'
								|| itemsUploadPhotos[itemsIndex + 1] != null) {
							itemsIndex = itemsIndex + 1;
							loadUploadImgInfos(itemsUploadPhotos[itemsIndex]);
							$("#update_pp3").text("当前第"+(itemsIndex+1)+"张，共"+itemsUploadPhotos.length+"张");
						} else {
							$("#update_pp3").text("已经到最后一张了");
						}
					});

	$("#update_prev_brower")
			.unbind("click")
			.bind(
					"click",
					function() {
						$("#update_pp3").empty();
						if (typeof (itemsUploadPhotos[itemsIndex - 1]) != 'undefined'
								|| itemsUploadPhotos[itemsIndex - 1] != null) {
							$("#update_pp3").text("当前第"+itemsIndex+"张，共"+itemsUploadPhotos.length+"张");
							itemsIndex = itemsIndex - 1;
							loadUploadImgInfos(itemsUploadPhotos[itemsIndex]);
						} else {
							$("#update_pp3").text("已经是第一张了");
						}
					});

	//测试实例
	function showMywindow() {
		$.fn.zWindow({
			width : 600,
			height : 390,
			titleable : true,
			title : '选择添加图片和预览',
			moveable : true,
			windowBtn : [ 'close' ],
			windowType : 'iframe',
			windowSrc : ctx+'/upload/toUpload',
			resizeable : false,
			/* 关闭后执行的事件 */
			afterClose : function() {

			},
			isMode : true
		});
	}

	//添加图片信息
	function addPhotos() {

		showMywindow();

		$(".zwindow_pannel")
				.append(
						'<div class="Panel_footer"><span class="PanelBtn1" id="submitBtn"  >确定</span><span class="PanelBtn2" id="exitBtn"  >取消</span></div><div style="clear:both;"></div>');
		//绑定事件
		$("#submitBtn").click(clickSubmitBtn);
		$("#exitBtn").click(clickExitBtn);
	};

	//点击确定按钮，触发事件
	function clickSubmitBtn() {
		if ($(".zwindow-iframe").contents().find("form").is("form")) {
			//检测是否为图片文件，如果是图片文件，则不允许提交
			if (validateImgFile()) {
				//设置图片存放路径
				$(".zwindow-iframe").contents().find('#category').val(1);
				$(".zwindow-iframe").contents().find('#subjectNo').val(
						"${currentItemNo}");
				//提交表单
				$(".zwindow-iframe").contents().find('form').submit();
			} else {
				return;
			}
		} else {
			var photoName = $(".zwindow-iframe").contents().find("img").attr(
					"title");
			if (typeof (photoName) == "undefined" || typeof (photoName) == null
					|| photoName == "") {
				top.jAlert('warning', '上传图片异常，图片大小不能大于5M!', '提示消息');
				$.zWindow.close();
				return;
			}
			var link = ufs + photoName;
			$("#photos").append(
					"<div id='"+photoName+"' class='photo'>"
							+ "<img src='"+link+"' />" + "</div>");
			//点击图片生成完毕，添加到图片集合信息中
			itemsUploadPhotos.push(link);
			//这里点保存时，直接添加至数据库
			createPicInfos("${currentItemNo}", photoName);
			$.zWindow.close();
			//重新定义次序信息
			itemsIndex = 0;
		}
	};

	//点击取消按钮，触发事件
	function clickExitBtn() {
		$.zWindow.close();
	};

	//加载图片到层中
	function loadUploadImgInfos(key) {
		$("#update_pp2").empty();
		$("#update_pp2").attr("src", key);
	}

	//验证信息，如果是不是图片文件，则不允许提交
	function validateImgFile() {

		var filepath = $(".zwindow-iframe").contents().find("#houseMaps").val();
		var extStart = filepath.lastIndexOf(".");
		var ext = filepath.substring(extStart, filepath.length).toUpperCase();
		if (ext != ".BMP" && ext != ".PNG" && ext != ".GIF" && ext != ".JPG"
				&& ext != ".JPEG") {
			top.jAlert('warning', '请选择图片文件', '提示消息');
			return false;
		} else {
			return true;
		}
	}

	//需要执行的方法，读取图片信息
	function readItemPicInfos(itemId) {
		$.ajax({
			url : ctx+'/uploadItemPicAction/readItemPic?tt='
					+ new Date().getTime(),
			data : {
				itemNo : itemId
			},
			type : 'POST',
			success : function(response) {
				if (response != "") {
					//读取图片信息
					$(response).each(
							function(index, item) {
								var link = ufs + item.itemPicFileId;
								itemsUploadPhotos.push(link);
								$("#photos").append(
										"<div id='"+item.itemPicFileId+"' class='photo'>"
												+ "<img src='"+link+"' />"
												+ "</div>");
							});

				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});

	}

	//需要执行的方法，增加图片信息
	function createPicInfos(itemNo, itemPicFileId) {
		if (itemPicFileId == null || itemPicFileId == "") {
			return;
		}

		$.ajax({
			url : ctx+'/uploadItemPicAction/createItemPic?tt='
					+ new Date().getTime(),
			data : {
				itemNo : itemNo,
				itemPicFileId : itemPicFileId
			},
			type : 'POST',
			success : function(response) {

			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});

	}

	//需要执行的方法，删除图片信息
	function deleteItemPicInfos(itemNo, itemPicFileId) {
		$.ajax({
			url : ctx+'/uploadItemPicAction/deleteItemPic?tt='
					+ new Date().getTime(),
			data : {
				itemNo : itemNo,
				itemPicFileId : itemPicFileId
			},
			type : 'POST',
			success : function(response) {
				if (response == 1) {
					top.jAlert('success', '删除图片信息成功!', '提示消息');
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});
	}

	//更新信息，用于更新顺序信息，设置某张图片到首页中显示
	function updateItemPicInfos(itemPicFileId) {
		$.ajax({
			url : ctx+'/uploadItemPicAction/updateItemPicInfo?tt='
					+ new Date().getTime(),
			data : {
				itemPicFileId : itemPicFileId
			},
			type : 'POST',
			success : function(response) {
				if (response == "success") {
					top.jAlert('success', '设置图片信息成功!', '提示消息');
				} else {
					top.jAlert('warning', '设置图片信息失败!', '提示消息');
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});
	}