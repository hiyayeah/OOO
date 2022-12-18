<%@page import="board.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int num = Integer.parseInt(request.getParameter("num"));
String sId = (String)session.getAttribute("sId");

if(sId == null) {
	%>
	<script>
		alert("댓글 삭제 실패!");
		history.back();
	</script>
	<%
}



ReplyDAO dao = new ReplyDAO();
int deleteCount = dao.deleteReply(num, sId);

if(deleteCount > 0) {
	response.sendRedirect("driver_content.jsp?num=" + request.getParameter("refNum"));
} else {
	%>
	<script>
		alert("댓글 삭제 실패!");
		history.back();
	</script>
	<%
}
%>
