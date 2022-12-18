<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String sId = (String)session.getAttribute("sId");

String post_code = request.getParameter("post_code");
String address1 = request.getParameter("address1");
String address2 = request.getParameter("address2");
String phone = request.getParameter("phone");

MemberDTO member = new MemberDTO();
member.setPost_code(post_code);
member.setAddress1(address1);
member.setAddress2(address2);
member.setPhone(phone);

MemberDAO dao = new MemberDAO();
int updateCount = dao.updateMember(member, sId);


if(updateCount > 0) {
	response.sendRedirect("memberInfo.jsp");
} else {
	%>
	<script>
		alert("회원정보 수정 실패!");
		history.back();
	</script>
	<%
}
%>



%>