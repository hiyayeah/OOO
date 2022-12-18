<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String sId = (String)session.getAttribute("sId");

String pass = request.getParameter("pass");

MemberDAO dao = new MemberDAO();
int deleteCount = dao.deleteMember(sId, pass);

if(deleteCount > 0) {
	session.invalidate();
	%>
	<script>
	alert("탈퇴 완료되었습니다.");
	</script>
	<%
	response.sendRedirect("../main/main.jsp");
} else { %>
	<script>
		alert("회원 탈퇴 실패!");
		history.back();
	</script>
	<%} %>
