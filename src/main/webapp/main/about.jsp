<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main/about</title>
<link href="../css/NewFile.css" rel="stylesheet" type="text/css">
</head>
<body>

	<!-- inc/top.jsp 페이지 포함시키기-->
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- 헤더 들어가는곳 -->

	<div align="center" style="margin: 50px; text-align: center; cursor: pointer;" onclick="location.href='main.jsp'">
		<h1>About</h1>
		<img style="width: 500px" src="../images/그림3.png"><br><br>
		
		<img style="width: 400px" src="../images/ashjklll.png">
		<img style="width: 350px" src="../images/ehejeahte.png">
		<br><br>
		
		<span style="width: 700px; height: 50px;" class="badge bg-info"><h2 style="color: white;">더 건강한 내일을 위한 오늘의 Today at Apple.</h2></span><br><br>
		<span style="width: 1500px; height: 50px;" class="badge bg-info"><h3 style="color: white;">운동은 함께 하면 더 좋은 법. 오운완 회원들과 ‘활동’ 링을 공유해보세요.</h3></span><br>
		<span style="width: 1500px; height: 50px;" class="badge bg-info"><h3 style="color: white;"> 서로 댓글을 통해 응원 하거나 선의의 경쟁심을 불러일으킬 수도 있죠.</h3></span><br>
		<span style="width: 1500px; height: 50px;" class="badge bg-info"><h3 style="color: white;"> 오운완 회원들과 세 개의 링. 하나의 목표. 매일매일 ‘움직이기’, ‘운동하기’, 그리고 ‘일어서기’ 링을 모두 채워보세요!</h3></span>
	</div>
	
	<div style="clear: both;"></div>  
	<!-- 푸터 들어가는곳 -->
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
</body>
</html>