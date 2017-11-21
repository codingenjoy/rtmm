<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="${ctx}/shared/js/jquery-zwindow/js/zWindow.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/js/jquery-zwindow/css/default/zWindow.css" />

<style>
.Panel_footer {
border-left: 3px solid #3f9673;
border-right: 3px solid #3f9673;
border-bottom: 3px solid #3f9673;
width: 600px;
margin-left: -3px;
overflow: hidden;
text-align:center;
    height: 40px;

}
.PanelBtn1,.PanelBtn2,.pt_div{
    width: 78px;
    height: 30px;
    margin-left: 5px;
    cursor: pointer;
    line-height: 30px;
    text-align: center;
    display:inline-block;
    margin-top:4px;
}
.PanelBtn1 ,.btn1{
    background: none repeat scroll 0% 0% #F37864;
}
.PanelBtn2,.cancel {
    background: none repeat scroll 0% 0% #999;
}

</style>

  <script type="text/javascript">
  var itemsPhotos = new Array();//当前单个证件下所有的证件图片信息
  var itemsIndex=0;
  var list = new Array();
                    $(".photo").live("mouseover", function () {
                        var t = $(this).offset().top;
                        var l = $(this).offset().left;
                        $("#_photo").css({ "top": t, "left": l, "display": "block" });
                        $("#_photo").attr("x",$(this).attr("id"));
                    });
                    $("#p1").live('click', function () {
                        $(".photo").find("img").attr("dz", "0");
                        var tx = "#" + $(this).parent().attr("x");
                        $(tx).find("img").attr("dz", "1");
                        var t = $(this).offset().top;
                        var l = $(this).offset().left;
                        $("#dz1").css({ "top": t, "left": l, "display": "block" });
                    });
                    $("#p2").live("click", function () {
                    	$("#update_pp3").empty();                       
                        var tx = "#" + $(this).parent().attr("x"); 
                        list = $("#photos").find("img");
                      /*   for (var i = 0; i < list.length; i++) {
                           alert($(list[i]).attr("src"));
                       } */
                       //获取下标信息             
                       for (var i = 0; i < itemsPhotos.length; i++) {
       					var link = ufs + $(this).parent().attr("x");
       					if (itemsPhotos[i] == link) {
       						itemsIndex = parseInt(i);
       						$("#update_pp3").text(
       								"当前第" + (itemsIndex + 1) + "张，共"
       										+ itemsPhotos.length + "张");
       					     }
       				     }                                              
                        $("#update_p").css({ "top": 0, "left": 0, "display": "block", "width": screen.width, "height": "690px" });
                        //$("#_p").empty();
                          $("#update_pp2").attr("src",$(tx +" img").attr("src"));
                        });
                    $("#p3").live("click", function () {
                        var tx = "#"+$(this).parent().attr("x");
                        //移除集合中的图片信息
                        var info=$(this).parent().attr("x");
				for (var index = 0; index < itemsPhotos.length; index++) {
					var link = ufs + info;
					if (link == itemsPhotos[index]) {
						//移除当前图片链接
						itemsPhotos.splice(index, 1);
								}
						}
                        $(tx).remove();
                        $("#_photo").css("display", "none");
                    });
                    $("#dz1").live('click', function () {
                        $(".photo").find("img").attr("dz", "0");
                        $(this).css("display", "none");
                    });
                    $("#closePicBtn").live("click", function () {
                        $("#update_p").css("display", "none");
                    });
                    $("#update_prev_brower").live("mouseover", function () {
                        $(this).addClass("prev_brower_bg");
                    });
                    $("#update_prev_brower").live("mouseout", function () {
                        $(this).removeClass("prev_brower_bg");
                    });
                    $("#update_next_brower").live("mouseover", function () {
                        $(this).addClass("next_brower_bg");
                    });
                    $("#update_next_brower").live("mouseout", function () {
                        $(this).removeClass("next_brower_bg");
                    });
                    $("#uploadPicInfo").delegate("#_photo","mouseleave",function(){							
						$("#_photo").css({"display":"none"});
					}); 
					
                    
                   	$("#update_next_brower").unbind("click").bind(
                			"click",
                			function() {
                				$("#update_pp3").empty();
                				if (typeof (itemsPhotos[itemsIndex + 1]) != 'undefined'
                						|| itemsPhotos[itemsIndex + 1] != null) {
                					itemsIndex = itemsIndex + 1;
                					loadUploadImgInfos(itemsPhotos[itemsIndex]);
                					$("#update_pp3").text(
                							"当前第" + (itemsIndex + 1) + "张，共"
                									+ itemsPhotos.length + "张");
                				} else {
                					$("#update_pp3").text("已经到最后一张了");
                				}
                			});

                	$("#update_prev_brower").unbind("click").bind(
                			"click",
                			function() {
                				$("#update_pp3").empty();
                				if (typeof (itemsPhotos[itemsIndex - 1]) != 'undefined'
                						|| itemsPhotos[itemsIndex - 1] != null) {
                					$("#update_pp3").text(
                							"当前第" + itemsIndex + "张，共"
                									+ itemsPhotos.length + "张");
                					itemsIndex = itemsIndex - 1;
                					loadUploadImgInfos(itemsPhotos[itemsIndex]);
                				} else {
                					$("#update_pp3").text("已经是第一张了");
                				}
                			});
                 

                	//测试实例
                    function showMywindow(){
                    	$.fn.zWindow({
                            width: 600,
                            height: 390,
                            titleable: true,
                            title: '选择添加图片和预览',
                            moveable: true,
                            windowBtn: ['close'],
                            windowType: 'iframe',
                            windowSrc: '${ctx}/upload/toUpload',
                            resizeable: false,
                            /* 关闭后执行的事件 */
                            afterClose: function () {
                             
                            },
                            isMode: true
                        });                     
                        }
                    
                     //添加图片信息
					function addPhotos(){

						showMywindow();

						$(".zwindow_pannel").append('<div class="Panel_footer"><span class="PanelBtn1" id="submitBtn"  >确定</span><span class="PanelBtn2" id="exitBtn"  >取消</span></div><div style="clear:both;"></div>');            
                         //绑定事件
                        $("#submitBtn").click(clickSubmitBtn);
                        $("#exitBtn").click(clickExitBtn);
	                       };




                       //点击确定按钮，触发事件
                       function clickSubmitBtn(){
                           if($(".zwindow-iframe").contents().find("form").is("form")){
                                //检测是否为图片文件，如果是图片文件，则不允许提交
                                if(validateImgFile()){
                                    //设置图片存放路径
                                	$(".zwindow-iframe").contents().find('#category').val(2);
                                	$(".zwindow-iframe").contents().find('#subjectNo').val($("#createSupComNo").val());      
                                    //提交表单
                             	   $(".zwindow-iframe").contents().find('form').submit();
                                     }else{return;}                                                      
                               }else{
                            	   var photoName=$(".zwindow-iframe").contents().find("img").attr("title");
                            	      if(typeof(photoName) =="undefined" ||typeof(photoName)==null ||photoName==""){
                                    	top.jAlert('warning', '上传图片异常，图片大小不能大于5M!', '提示消息');    
                                         $.zWindow.close();                                      
                                          return;
                                         }                             
                                    var link=ufs+photoName;
                                	  $("#photos").append("<div id='"+photoName+"' class='photo'>"
                                              +"<img src='"+link+"' />"
                      	                     +"</div>");
                                      //点击图片生成完毕，添加到图片集合信息中
                                	  itemsPhotos.push(link);  
                                $.zWindow.close();
                                //重新定义次序信息
                                itemsIndex=0;        
                                }
                           };
                       
                    //点击取消按钮，触发事件
                      function clickExitBtn(){
                    	    $.zWindow.close();
                           };


                //加载图片信息           
               function loadSupComImgs(){
            	   itemsPhotos=new Array();	
                   if(itemsCreatPic[currentImgListId]!=null) {        
            	   itemsPhotos=itemsCreatPic[currentImgListId];
                   if(itemsPhotos.length>0){
                	   for (var i = 0; i < itemsPhotos.length; i++) {
                    	   var info=itemsPhotos[i].replace(ufs,"");
          					 $("#photos").append("<div id='"+info+"' class='photo'>"
                                     +"<img src='"+itemsPhotos[i]+"' />"
             	                     +"</div>");
         				     }                       
                     }
                  }               	   
               }
               //加载图片到层中
               function loadUploadImgInfos(key){
              	 $("#update_pp2").empty();
                   $("#update_pp2").attr("src",key);
                   }


              $(function(){
            	  loadSupComImgs();
           		        	  
                 });
                 

              //验证信息，如果是不是图片文件，则不允许提交
              function   validateImgFile(){

            	  var filepath=$(".zwindow-iframe").contents().find("#houseMaps").val();
            	  var extStart=filepath.lastIndexOf("."); 
      	        var ext=filepath.substring(extStart,filepath.length).toUpperCase(); 
      	        if(ext!=".BMP"&&ext!=".PNG"&&ext!=".GIF"&&ext!=".JPG"&&ext!=".JPEG"){ 
      	        	top.jAlert('warning', '请选择图片文件', '提示消息');   	
      	         	return false; 
      	        }else{
                    return true;
          	        }
               }
                 
                 

                </script>
                                <div id="uploadPicInfo">  
                
            <div class="Container-1">
              
                <div  class="Content">
                <div  id="photos">
	              
	                </div>
	                
                    <div id="add_photo" class="add_photo" onclick="addPhotos()">
	                
	                </div>
                </div>
        </div>

    <div id="date_div" style="width:160px;height:180px;display:none;position:absolute;z-index:9999;"></div>
    <div id="_photo">
        <div id="p1" class="p1"></div>
        <div id="p2" class="p2"></div>
        <div id="p3" class="p3"></div>
    </div>
    
    <div id="dz1"></div>
    
  <div id="update_p"  class="_p">
        <div id="update_p_brower" class="p_brower"  style="border:2px solid #3f9673;">
                      <div class="zwindow_titleBar" style="height: 40px;position:relative;"><div class="zwindow_titleButtonBar"><div id="closePicBtn" class="zwindow_action_button zwindow_close"></div></div><div class="zwindow_title titleText">浏览图片信息</div></div>           
            <div id="update_prev_brower" class="prev_brower"></div>
            <div id="update_pp" class="pp">             
                <img src="" id="update_pp2" alt="" class="pp2"/>
                <div id="update_pp3" class="pp3"></div>
            </div>
            <div id="update_next_brower" class="next_brower"></div>
        </div>
    </div>
    </div>