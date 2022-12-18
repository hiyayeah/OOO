<%@page import="board.FileBoardDTO"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main/main</title>
<link href="../css/NewFile.css" rel="stylesheet" type="text/css">
</head>
<body>

	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<!-- inc/top.jsp 페이지 포함시키기-->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->
		  
		<div style="clear: both;"></div>   
		<!-- 본문들어가는 곳 -->
		<!-- 메인 이미지 -->
		<div id="main_img"><img width="100%" height="400px" src="../images/swim.jpg"></div>
		<!-- 본문 내용 -->
		<article style="display: table; margin: 10px auto;">

		  	<div class="card mb-3" style="width: 500px; margin: 20px 50px 20px 100px; float: left; cursor: pointer;" onclick="location.href='https://www.apple.com/kr/apple-events'">
				<h3 class="card-header">- Apple Event</h3>
				<div class="card-body">
					<h5 class="card-title">9월 8일 새벽 2시 생중계</h5>
					<h6 class="card-subtitle text-muted">apple.com 또는 Apple TV 앱에서 온라인으로 시청하세요!</h6>
				</div>
					<img src = "../images/event2.jpg" style="height: 500px;">
				<div class="card-body">
					<p class="card-text">애플 ‘아이폰 14’ 공개 임박…"9월 8일 애플 이벤트로 초대"<br>
					아이폰14가 공개되는 애플의 연중 최대 행사 '애플 이벤트'가 올해 예년 보다 1주일 빠른 9월 8일(한국시간) 개최된다.</p>
				</div>
			</div>
		  	
			<div class="card mb-3" style="width: 500px;  margin: 20px 50px 20px 50px; float: left;">
				<h3 class="card-header">- 내게 맞는 애플워치는?</h3>
				<div class="card-body">
					<h5 class="card-title">한방에 딱 정해주는 애플워치 구매 가이드!</h5>
					<h6 class="card-subtitle text-muted">-By ITSub잇섭</h6>
				</div>
					<iframe width="500" height="500" src="https://www.youtube.com/embed/_qNxGGVHcqU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
				<div class="card-body">
					<p class="card-text">비싼게 무조건 좋은것만은 아니다?? 한방에 딱 정해주는 2021/2022 기준 애플워치 구매 가이드!<br>(애플워치 시리즈7 출시 후 기준)</p>
				</div>
			</div>
		  	
		  	<div class="card mb-3" style="width: 500px;  margin: 20px 100px 20px 50px; float: left; cursor: pointer;" onclick="location.href='https://www.nike.com/kr/ko_kr/c/running/nike-run-club'">
				<h3 class="card-header">- Nike+ Run Club</h3>
				<div class="card-body">
					<h5 class="card-title">나의 완벽한 러닝 파트너 어플리케이션</h5>
					<h6 class="card-subtitle text-muted">러닝 가이드, 트래킹, 친구 초대 기능까지.</h6>
				</div>
					<img src = "../images/nikerun.jpg" style="height: 500px;">
				<div class="card-body">
					<p class="card-text">Nike+ Run Club과 함께 내 생애 첫 러닝을, 그리고 가장 재미나고 스피드 넘치는 러닝을 시작해보세요.<br>매 세션마다 코치와 페이서에게 전문적인 가이드를 받아보세요!</p>
				</div>
			</div>
			
			<div style="clear: both;"></div> 
			
			
			<div class="list-group" style="float: left; margin-left: 200px; width: 700px; text-align: center;">
				<article style="display: table; width: 600px; margin: 20px auto;">
					<h3 style="background-color: #7b8ad8; color: #bed1e6">[ Notice ]</h3>
					<table style=" width: 650px;">
						<!-- 공지사항 게시물(notice) 중 최근 5개 표시 영역 -->
						<%
						BoardDAO dao = new BoardDAO();
						ArrayList<BoardDTO> rencentBoardList = dao.selectRencentBoardList();
						for(BoardDTO board : rencentBoardList) {%>
						<tr onclick="location.href = '../center/notice_content.jsp?num=<%=board.getNum() %>'" style="cursor:pointer; border-bottom: dotted 1px;">
							<td><%=board.getSubject() %></td>
							<td><%=board.getName() %></td>
							<td><%=sdf.format(board.getDate())%></td>
						</tr>
						<%} %>
					</table>
				</article>	
			</div>
			
			
			<div class="list-group" style="float: left; margin-left: 100px; width: 700px; text-align: center;">
				<article style="display: table; width: 600px; margin: 20px auto;">
					<h3 style="background-color: #7b8ad8; color: #bed1e6">[ FreeBoard ]</h3>
					<table style=" width: 650px;">
						<!-- 공지사항 게시물(notice) 중 최근 5개 표시 영역 -->
						<%
						FileBoardDAO dao2 = new FileBoardDAO();
						ArrayList<FileBoardDTO> rencentBoardList2 = dao2.selectRencentBoardList();
						for(FileBoardDTO board : rencentBoardList2) {%>
						<tr onclick="location.href = '../center/driver_content.jsp?num=<%=board.getNum() %>'" style="cursor:pointer; border-bottom: dotted 1px;">
							<td><%=board.getSubject() %></td>
							<td><%=board.getName() %></td>
							<td><%=sdf.format(board.getDate())%></td>
						</tr>
						<%} %>
					</table>
				</article>	
			</div>
			
	  	</article>
		  
		<div style="clear: both;"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>