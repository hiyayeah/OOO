<%@page import="board.ReplyDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.ReplyDAO"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
int num = Integer.parseInt(request.getParameter("num"));

FileBoardDAO dao = new FileBoardDAO();

dao.updateReadcount(num);

FileBoardDTO board = dao.selectFileBoard(num);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String sId = (String)session.getAttribute("sId");

if(sId == null) {
	%>
	<script>
		alert("회원만 접근 가능한 페이지입니다.");
		history.back();
	</script>
	<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/driver_content.jsp</title>
<style type="text/css">
table {
	border: solid 3px;
	text-align: center;
	vertical-align: middle;
	border-collapse: collapse;
}
th {
	vertical-align: middle;
	
}

</style>
<link href="../css/NewFile.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	
	function forwardReply() {
		//세션 아이디가 있을 경우에만 쓰기 동작 수행 => 세션 아이디 없으면 경고 출력 후 중단
		
		<%if(sId != null){ %>
			var content = document.getElementById("reply_content").value;
			location.href = "driver_content_reply_writePro.jsp?boardType=driver&num=<%=board.getNum()%>&name=<%=sId%>&content=" + content;
		<%} else {%>
			alert("댓글은 로그인 후 사용 가능합니다!");
		<% }%>
		
	}

</script>
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"><img width="100%" height="300" src="../images/logogo.png"></div>

		<!-- 본문 내용 -->
		<article style="display: table; width: 1300px; margin: 50px auto;">
			<h1>Freeboard Content</h1>
			<form action="#" method="post">
				<table class="table">
					<tr style="border-bottom: dotted 1px;">
      					<th>글번호</th>
    					<td><%=board.getNum() %></td>
    					<th>글쓴이</th>
    					<td><%=board.getName() %></td>
    				</tr>
    				<tr style="border-bottom: dotted 1px;">
      					<th>작성일</th>
    					<td><%=sdf.format(board.getDate()) %></td>
    					<th>조회수</th>
    					<td><%=board.getReadcount() %></td>
    				</tr>
    				<tr style="border-bottom: dotted 1px;">
      					<th>제목</th>
    					<td colspan="3"><%=board.getSubject() %></td>
    				</tr>
    				<tr style="border-bottom: dotted 1px;">
      					<th>내용</th>
    					<td colspan="3">
    						<textarea readonly="readonly" class="form-control" rows="15"><%=board.getContent() %></textarea>
    					</td>
    				</tr>
    				<tr style="border-bottom: dotted 1px;">
      					<th>파일</th>
    					<td colspan="3">
							<a href="../upload/<%=board.getReal_file()%>" download="<%=board.getOriginal_file() %>"><%=board.getOriginal_file() %></a>
    					</td>
    				</tr>
    				<tr style="border-bottom: dotted 1px;">
    					<th >댓글</th>
		    			<td colspan="3">
		    				<textarea style="width: 90%; float: left;" class="form-control" rows="1" id="reply_content"></textarea>
		    				<input style="float: left; margin-left: 10px;" class="btn" type="button" value="쓰기" 
		    				onclick="forwardReply()">
		    			</td>
		    		</tr>
		    		<%
					// ReplyDAO 객체 생성 후 selectReplyList() 메서드를 호출하여 댓글 목록 가져오기
					// => 파라미터 : 글번호(num)   리턴타입 : List<ReplyDTO>(replyList)
					ReplyDAO replyDAO = new ReplyDAO();
					String BoardType = "driver";
					List<ReplyDTO> replyList = replyDAO.selectReplyList(num, BoardType);
					
					// 날짜 및 시각 형식을 "월월-일일 시시:분분" 형식으로 설정
					SimpleDateFormat sdf2 = new SimpleDateFormat("MM-dd HH:mm");
					
					// List 객체 크기만큼 반복하면서 ReplyDTO 객체(reply) 꺼내기 => 향상된 for문 사용
					for(ReplyDTO reply : replyList) {
					%>
			    		<tr style="border-bottom: dotted 1px;">
			    			<td>
			    				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">
  								<path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>
								</svg><%=reply.getName() %>
			    			</td>
			    			<td align="left"><%=reply.getContent() %></td>
			    			<td><%=sdf2.format(reply.getDate()) %></td>
			    			<td>
			    				<%if(sId != null && sId.equals(reply.getName())){%>
			    				<input type="button" value="삭제" class="btn btn-primary btn-sm" 
			    				onclick="location.href='driver_content_reply_deletePro.jsp?num=<%=reply.getNum()%>&refNum=<%=num%>'">
			    				<%} %>
			    			</td>
			    		</tr>
		    			<%
		    		}
		    		%>
				</table>
				
				<script>
					function func1(num) {
						<%if(sId != null && sId.equals(board.getName())){ %>
						location.href="driver_update.jsp?num=" + num;
						<%} else {%>
							alert("권한이 없습니다.");
						<% }%>
					}
					
					function func2(num) {
						<%if(sId != null && sId.equals(board.getName())){ %>
						location.href="driver_delete.jsp?num=" + num;
						<%} else {%>
							alert("권한이 없습니다.");
						<% }%>
					}
				</script>
				
				<div id="table_search" style="float: right;">
					<input type="button" value="글수정" class="btn" onclick="func1('<%=num%>')">
					<input type="button" value="글삭제" class="btn" onclick="func2('<%=num%>')">
					<input type="button" value="글목록" class="btn" onclick="location.href ='driver.jsp'">
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


