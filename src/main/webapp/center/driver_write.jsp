<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/driver_write.jsp</title>
<style type="text/css">
table {
	border: solid 3px;
	text-align: center;
	vertical-align: middle;
}
th {
	vertical-align: middle;
	text-decoration: none;
}
</style>
<link href="../css/NewFile.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
	// 세션에 저장된 아이디가 null 이면 자바스크립트를 통해 "회원만 접근 가능합니다" 출력 후 돌아가기
	String sId = (String)session.getAttribute("sId");
	
	if(sId == null) {
		%>
		<script>
			alert("글쓰기 권한이 없습니다.");
			history.back();
		</script>
		<%
	}
	%>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"><img width="100%" height="300" src="../images/logogo.png"></div>
		
		<!-- 본문 내용 -->
		<article style="display: table; width: 1300px; margin: 50px auto;">
			<h1>Freeboard Write</h1>
			<form action="driver_writePro.jsp" method="post" enctype="multipart/form-data">
				<table class="table">
					<tr>
      					<th>글쓴이</th>
    					<td><input type="text" class="form-control" name="name" id="inputDefault" value="<%=sId %>" required="required" readonly="readonly"></td>
    				</tr>
				    <tr>
      					<th>비밀번호</th>
    					<td><input type="password" class="form-control" name="pass" required="required" id="inputDefault"></td>
    				</tr>
    				<tr>
      					<th>제목</th>
    					<td><input type="text" class="form-control" name="subject" required="required" id="inputDefault"></td>
    				</tr>
   					<tr>
      					<th scope="col">내용</th>
    					<td scope="col"><textarea class="form-control" name="content" required="required" rows="20"></textarea></td>
    				</tr>
    				<tr>
      					<th>파일</th>
    					<td><input class="form-control" type="file" name="original_file" id="formFile"></td>
    				</tr>
				</table>
				<div id="table_search" style="float: right;">
					<input type="submit" value="글쓰기" class="btn">
				</div>
			</form>
			<div style="clear: both;"></div>
		</article>

		<div style="clear: both;"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


