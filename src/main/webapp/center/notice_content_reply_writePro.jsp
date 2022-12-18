<%@page import="board.ReplyDAO"%>
<%@page import="board.ReplyDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String boardType = request.getParameter("boardType");
int num = Integer.parseInt(request.getParameter("num"));
String name = request.getParameter("name");
String content = request.getParameter("content");

//ReplyDTO 객체(reply)를 생성하여 파라미터 저장
ReplyDTO reply = new ReplyDTO();
reply.setBoardType(boardType);
reply.setRefNum(num); // 원본글 번호를 refNum 변수에 저장
reply.setName(name);
reply.setContent(content);

//ReplyDAO 객체 생성 후 insertReply() 메서드 호출하여 댓글 등록
ReplyDAO dao = new ReplyDAO();
int insertCount = dao.insertReply(reply);

if(insertCount > 0) {
	response.sendRedirect("notice_content.jsp?num=" + num);
} else {
	%>
	<script>
		alert("댓글 등록 실패!");
		history.back();
	</script>
	<%
}
%>



