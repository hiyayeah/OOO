<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%
request.setCharacterEncoding("UTF-8");

String name = request.getParameter("name");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String gender = request.getParameter("gender");
String email1 = request.getParameter("email1");
String email2 = request.getParameter("email2");
String post_code = request.getParameter("post_code");
String address1 = request.getParameter("address1");
String address2 = request.getParameter("address2");
String phone = request.getParameter("phone");


// INSERT 작업에 필요한 데이터를 BoardDTO 객체 생성 후 저장
MemberDTO member = new MemberDTO();
member.setName(name);
member.setId(id);
member.setPass(pass);
member.setGender(gender);
member.setEmail1(email1);
member.setEmail2(email2);
member.setPost_code(post_code);
member.setAddress1(address1);
member.setAddress2(address2);
member.setPhone(phone);

MemberDAO dao = new MemberDAO();
int insertCount = dao.insertMember(member);

// INSERT 작업 수행 결과 판별
if(insertCount > 0){
	response.sendRedirect("joinSuccess.jsp");
} else {%>
	<script>
	alert("회원가입 실패!");
	history.back();
	</script>
<% }%>