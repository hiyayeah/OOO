<%@page import="board.ReplyDAO"%>
<%@page import="board.ImgBoardDAO"%>
<%@page import="board.ImgBoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
request.setCharacterEncoding("UTF-8");

int listLimit = 9;
int pageNum = 1;

if(request.getParameter("pageNum") != null) {
	pageNum = Integer.parseInt(request.getParameter("pageNum"));
}

int startRow = (pageNum - 1) * listLimit;

ImgBoardDAO dao = new ImgBoardDAO();
ArrayList<ImgBoardDTO> boardList = dao.selectBoardList(startRow, listLimit);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>img_board/img.jsp</title>
<style type="text/css"></style>
<link href="../css/NewFile.css" rel="stylesheet" type="text/css">
</head>
<body>
	<!-- 헤더 들어가는곳 -->
	<jsp:include page="../inc/top.jsp" />
	<!-- 헤더 들어가는곳 -->

	<!-- 본문들어가는 곳 -->
	<!-- 본문 메인 이미지 -->
	<div id="sub_img_center"><img width="100%" height="300" src="../images/wall5.jpg"></div>
	
	
	<!-- 본문 내용 -->
	<article style="display: table; margin: 50px auto; width: 1400px;">
		<h1>Gallery</h1>
		<%for(ImgBoardDTO board : boardList) {
			ReplyDAO replyDAO = new ReplyDAO();
	    	int replyCount = replyDAO.replyCount(board.getNum(), "img");
		%>
   		<div class="card mb-3" style="width: 400px; margin: 30px 30px; float: left; cursor: pointer;" onclick="location.href='img_content.jsp?num=<%=board.getNum()%>'">
			<h3 class="card-header"><%=board.getSubject() %></h3>
			<div class="card-body">
				<h5 class="card-title"><%=board.getContent() %></h5>
				<h6 class="card-subtitle text-muted">- <%=board.getName() %></h6>
			</div>
				<img src = "../img_upload/<%=board.getOriginal_file() %>" style="height: 400px;">
			<div class="card-body">
				<p class="card-text"><%=sdf.format(board.getDate()) %></p>
				<span style="float: right;"><svg xmlns="http://www.w3.org/2000/svg" style="margin-right: 3px;" width="16" height="16" fill="currentColor" class="bi bi-chat-square-dots" viewBox="0 0 16 16">
  				<path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1h-2.5a2 2 0 0 0-1.6.8L8 14.333 6.1 11.8a2 2 0 0 0-1.6-.8H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h2.5a1 1 0 0 1 .8.4l1.9 2.533a1 1 0 0 0 1.6 0l1.9-2.533a1 1 0 0 1 .8-.4H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
  				<path d="M5 6a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
				</svg><%=replyCount %></span>
			</div>
		</div>
		<%} %>
		
		<div style="clear: both;"></div>
		
		<!-- 검색 기능 -->
		<div id="table_search">
			<button type="button" style="float: left; margin-left: 30px;" class="btn btn-light" onclick="location.href = 'img_write.jsp'">글쓰기</button>
			<form style="display: inline;" action="img_search.jsp" method="get">
			<select style="width: 180px; float: left; margin-left: 49%" class="form-select" id="exampleSelect1" name="select">
			        <option value="subject">글제목</option>
			        <option value="content">글내용</option>
					<option value="name">글쓴이</option>
					<option value="original_file">첨부파일명</option>
			</select>
		    <input type="text" name="keyword" style="width: 250px; float: left; margin: 0px 5px;" class="form-control" required="required">
   			<button type="submit" value="Search" style="float: left;" class="btn btn-light">Search</button>
     		</form>
		</div>
		
		<div style="clear: both;"></div>
		
			<%
			int boardListCount = dao.selectBoardListCount();
			int pageListLimit = 9;
			int maxPage = boardListCount / pageListLimit 
					+ (boardListCount % pageListLimit == 0 ? 0 : 1);
			int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
			int endPage = startPage + pageListLimit - 1;
			if(endPage > maxPage) { endPage = maxPage; }
			%>
			
		<div style="width: 300px; margin-left: 50%; margin-right: auto;">
			
			<!-- 이전 페이지 버튼(Prev) 클릭 시 현재 페이지 번호 - 1 값 전달 -->
			<!-- 단, 현재 페이지번호가 1 페이지보다 클 경우 하이퍼링크 표시(아니면 제거) -->
			<%if(pageNum == 1) { %>
				<a style="text-decoration: none; font-size: 150%;" href="javascript:void(0)">&laquo;</a>
			<%} else { %>
				<a style="text-decoration: none; font-size: 150%;" href="img.jsp?pageNum=<%=pageNum - 1%>">&laquo;</a>
			<%} %>
			
			<!-- for문을 사용하여 startPage ~ endPage 까지 목록 표시 -->
			<%for(int i = startPage; i <= endPage; i++) { %>
				<!-- 현재 페이지 번호(pageNum) 가 i 값과 같을 경우 하이퍼링크 제거 -->
				<%if(pageNum == i) { %>
					<a style="text-decoration: none; font-size: 150%;" href="javascript:void(0)"><%=i %></a>
				<%} else { %>
					<a style="text-decoration: none; font-size: 150%;" href="img.jsp?pageNum=<%=i %>"><%=i %></a>
				<%} %>
			<%} %>
			
			<!-- 다음 페이지 버튼(Next) 클릭 시 현재 페이지 번호 + 1 값 전달 -->
			<!-- 단, 현재 페이지번호가 최대 페이지 번호보다 작을 경우 하이퍼링크 표시(아니면 제거) -->
			<%if(pageNum == maxPage) { %>
				<a style="text-decoration: none; font-size: 150%;" href="javascript:void(0)">&raquo;</a>
			<%} else { %>
				<a style="text-decoration: none; font-size: 150%;" href="img.jsp?pageNum=<%=pageNum + 1%>">&raquo;</a>
			<%} %>
		</div>
	</article>

	<div style="clear: both;"></div>
	
	<!-- 푸터 들어가는곳 -->
	<jsp:include page="../inc/bottom.jsp" />
	<!-- 푸터 들어가는곳 -->

</body>
</html>
    