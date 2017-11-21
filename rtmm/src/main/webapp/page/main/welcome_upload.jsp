<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>${defaultTitle }</title>
<meta name="keywords" content="${defaultKeyWords }" />
<meta name="description" content="${defaultDescription }" />
<meta name="author" content="${defaultKeyWords }" />
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate"/> 
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<%@ include file="/page/commons/easyui.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css" rel="Stylesheet" />
<script src="${ctx}/shared/js/rtmm.js"  type="text/javascript"></script>
<script src="${ctx}/shared/js/common.js" type="text/javascript"></script>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/welcome.css" rel="Stylesheet" />
<script type="text/javascript">
/* <!--
//当出现错误的时候，不弹出错误提示框
function stopError() {
	return true;
}
window.onerror = stopError;
//--> */
</script>
<script type="text/javascript">
	$(function() {
		$.ajax({
			url : ctx+'/workspace/getNotice4Row',
			type : 'POST',
			success : function(data) {
				$('#newsPanel').empty();
				$.each(data,function(index,obj){
					var value = obj.title;
					if (index > 4) {
						return;
					} else if (index == 4) {
						value = '查看更多>>';
						date = '' ;
					} else {
						date = new Date(obj.createDate).format('yyyy-MM-dd');
					}
					var news = '<div class="news"><input type="hidden" value="'+obj.id+'"><div class="n1" ><div class="n11 n11_1"></div><div class="n12">'
							+ value
							+ '</div></div><span>'
							+ date + '</span></div>';
					$('#newsPanel').append(news);
				});
				$('#newsPanel').find('.news:first').css('margin-top','15px');
				$('#newsPanel').find('.news:lt(4)').bind("click",function(){
					var noticeId = $(this).find('input').val();
					var form = $('#forwardForm');
					$(form).attr('action',ctx +'/fav/37');
					$(form).append('<input type="hidden" name="noticeId" value="'+noticeId+'">');
					$(form).submit();
					
				});
				$('#newsPanel').find('.news:gt(3)').bind("click",function(){
					getNoticeByPage();
				});
			}
		});
		
	});
	function getNoticeByPage(){
		var form = $('#forwardForm');
		$(form).attr('action',ctx+'/fav/37');
		$(form).submit();
	}
</script>
</head>
<body>
<form id="forwardForm" method="post">
</form>
<div class="TopMenu" id="top_menu">
  <jsp:include page="/page/commons/menu.jsp"></jsp:include>
</div>
<div id="content_body" class="Center">
        <div class="wlc1">
            <div class="ch1"></div>
            <div class="ch2">
                <div class="ch21"></div>
                <div class="ch22">门店数量</div>
            </div>
        </div>
        <div class="wlc2">
            <div class="wlc21 wlc2x">
                <div class="n x"></div>
                <div id="newsPanel">
                </div>
            </div>
            <div class="wlc22 wlc2x">
                <div class="m x"></div>
                <div class="news" style="margin-top:15px;">
                        <div class="n1" >
                            <div class="n11 n11_2"></div>
                            <div class="n12">Auchan RTMM V2 管理系统上线</div>
                        </div>
                        <span>2014-09-43</span>
                </div>
                <div class="news">
                        <div class="n1">
                            <div class="n11 n11_2"></div>
                            <div class="n12">Auchan RTMM V2 管理系统上线</div>
                        </div>
                        <span>2014-09-43</span>
                </div>
                <div class="news">
                        <div class="n1">
                            <div class="n11 n11_2"></div>
                            <div class="n12">Auchan RTMM V2 管理系统上线</div>
                        </div>
                        <span>2014-09-43</span>
                </div>
                <div class="news">
                        <div class="n1">
                            <div class="n11 n11_2"></div>
                            <div class="n12">Auchan RTMM V2 管理系统上线</div>
                        </div>
                        <span>2014-09-43</span>
                </div>
                <div class="news">
                        <div class="n1">
                            <div class="n11  n11_2"></div>
                            <div class="n12">查看更多>>
                            </div>
                        </div>
                </div>
            </div>
        </div>
        <div class="foot">
            <span>欧尚（中国）投资有限公司</span>
            <div></div>
        </div>
    </div>
    <div>
    	这里上传测试
    	<label class="inline_bk w_100 mg_r_10 a_r">图片：</label>
	       <span>
		       <input id="fileFieldImage" name="fileFieldImage" type="file" name="upload" />
		       <input type="hidden" name="image1" id ="uploadFileUrlImage" class="w_150 h_line_20"  value=""/>
		       <a class="grey_small_btn inline_bk a_c mg_r_10" 
		        onclick="uploadFileFunc('fileFieldImage','imageFile','uploadFileNameImage','imageFile')">上传1</a>
	        </span>
	       <img src="" width="60" height="40" id="imageFile"/>
	       <input type="text" class="w_170 color_666 " value="" id="imgUrl" name="imgUrl" />
	       <br/>	
    </div>
    
<script type='text/javascript' src='http://upload.auchan.com:8080/upload/file/uploadjs'></script>
<script type="text/javascript">
document.domain="auchan.com";
 function uploadFileFunc(upfile,fileUrl){
		uploadFile(upfile,
			function(data){//成功方法
				alert(data.status);
				if(data.status=="success"){
					alert(data.link);
					//$("#"+fileUrl).attr("src","http://localhost:8080/"+data.link);
				}else{
					alert(data.message);
					$("#fileField").focus();
				}
			},function(data){//失败调用
			alert('error');
				alert(data.message);
				$("#fileField").focus();
			});
	}
	
</script>   
</body>
</html>
