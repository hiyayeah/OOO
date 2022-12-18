<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/login.jsp</title>
<link href="../css/NewFile.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->
		  
		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"><img width="100%" height="300" src="../images/6.jpg"></div>
		<!-- 본문 내용 -->
		
		  <article style="display: table; width: 1200px; margin: 20px auto 300px auto;">
		  	
		  	<form style="margin: 10px 200px;" action="loginPro.jsp" method="post" id="join">
		  		<h1>Login</h1>
		  		<fieldset>
		  			<legend>Login Info</legend>
		  			<hr>
					<label class="col-form-label col-form-label-lg mt-1" for="inputLarge">User Id</label>
					<input class="form-control form-control-lg" type="text" name="id" required="required" placeholder="Enter Id" >
					<label class="col-form-label col-form-label-lg mt-1" for="inputLarge">Password</label>
					<input class="form-control form-control-lg" type="password" name="pass" required="required" placeholder="Enter Password">					
		  		</fieldset>
		
		  		<div class="clear"></div>
		  		<br>
		  		<div id="buttons">
		  			<button type="submit" class="btn btn-primary">Submit</button>
		  			<button type="reset" class="btn btn-primary">Cancel</button>
		  		</div>
		  	</form>
		  </article>
		  
		  
		<div style="clear: both;"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


