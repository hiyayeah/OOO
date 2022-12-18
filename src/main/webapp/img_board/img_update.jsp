<%@page import="board.ImgBoardDTO"%>
<%@page import="board.ImgBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
int num = Integer.parseInt(request.getParameter("num"));
ImgBoardDAO dao = new ImgBoardDAO();
ImgBoardDTO board = dao.selectFileBoard(num);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>img_board/img_update.jsp</title>
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
	<%
	// 세션에 저장된 아이디가 null 이거나 게시물의 아이디와 일치하지 않으면 
	// 자바스크립트를 통해 "접근 권한이 없습니다!" 출력 후 돌아가기
	// 단, 관리자 아이디("admin")는 접근 권한 허용
	String id = (String)session.getAttribute("sId");
	System.out.println(id);
	
	if(id == null || !id.equals("admin") && !id.equals(board.getName())) {
		// 관리자 아이디가 아니고 세션 아이디가 일치하지 않으면 권한 없음
		// <-> 관리자 아이디이거나 세션 아이디가 일치하면 권한 있음
		%>
		<script>
			alert("접근 권한이 없습니다!");
			history.back();
		</script>
		<%} %>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"><img width="100%" height="300" src="../images/looo.jpg"></div>
		
		<!-- 본문 내용 -->
		<article style="display: table; width: 1300px; margin: 50px auto;">
			<h1>Gallery Update</h1>
			<form action="img_updatePro.jsp" method="post" enctype="multipart/form-data">
				<input type="hidden" name="num" value="<%=request.getParameter("num")%>">
				<input type="hidden" name="real_file" value="<%=board.getReal_file()%>">
				<table class="table">
					<tr>
      					<th>글쓴이</th>
    					<td><input type="text" class="form-control" name="name"  value="<%=board.getName()%>" id="inputDefault"></td>
    				</tr>
    				<tr>
      					<th>패스워드</th>
    					<td><input type="password" class="form-control" name="pass" required="required" id="inputDefault"></td>
    				</tr>
    				<tr>
      					<th>제목</th>
    					<td><input type="text" class="form-control" name="subject" value="<%=board.getSubject()%>" id="inputDefault"></td>
    				</tr>
   					<tr>
      					<th scope="col">내용</th>
    					<td scope="col"><textarea class="form-control" name="content" id="exampleTextarea" rows="20"><%=board.getContent() %></textarea></td>
    				</tr>
    				<tr>
						<td>파일</td>
						<td>
							<%=board.getOriginal_file() %><br>
							<input class="form-control" type="file" name="original_file" id="formFile" required="required">
						</td>
					</tr>
				</table>
				<div id="table_search" style="float: right;">
					<input type="submit" value="글수정" class="btn">
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


