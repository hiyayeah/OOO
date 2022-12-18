<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");
String pass = request.getParameter("pass");

MemberDTO member = new MemberDTO();
member.setId(id);
member.setPass(pass);

MemberDAO dao = new MemberDAO();
int loginMember = dao.login(member);

if(loginMember > 0) {
	session.setAttribute("sId", id);
	response.sendRedirect("../main/main.jsp");
} else {%>
	<script>
		alert("아이디 또는 패스워드가 틀렸습니다!");
		history.back();
	</script>	
<%} %>
