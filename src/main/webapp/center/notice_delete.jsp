<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_delete.jsp</title>
<style type="text/css">
table {
	border: solid 3px;
	text-align: center;
	vertical-align: middle;
}
th {
	vertical-align: middle;
}
</style>
<link href="../css/NewFile.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"><img width="100%" height="300" src="../images/looo.jpg"></div>
		
		<!-- 본문 내용 -->
		<article style="display: table; width: 1300px; margin: 100px auto;">
			<h1>Notice Delete</h1>
			<form action="notice_deletePro.jsp" method="post">
				<input type="hidden" name="num" value="<%=request.getParameter("num")%>">
				<table class="table">
					<tr>
      					<th>패스워드</th>
    					<td><input type="password" class="form-control" name="pass" id="inputDefault"></td>
    				</tr>
				</table>
				<div id="table_search" style="float: right;">
					<input type="submit" value="글삭제" class="btn">
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


