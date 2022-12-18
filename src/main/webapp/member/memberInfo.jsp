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

String sId = (String)session.getAttribute("sId");

MemberDAO dao = new MemberDAO();
MemberDTO member = dao.selectMember(sId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/memberInfo.jsp</title>
<link href="../css/NewFile.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->
		  
		<!-- 본문 내용 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"><img width="100%" height="300" src="../images/6.jpg"></div>
		  <article style="display: table; width: 1200px; margin: 20px auto;">
			<form action="joinPro.jsp" method="post" style="margin: 10px 200px;">
				<h1>Member Info</h1>
				<fieldset>
					<legend>Basic Info</legend>
						<div class="form-group">
				    		<label class="form-label mt-4">Name</label>
				      		<input type="text" class="form-control form-control-lg" disabled="" name="name" value="<%=member.getName()%>" >
				    	</div>
				    	<div class="form-group">
				      		<label class="form-label mt-4">User Id</label>
				      	<div style="clear:both; "></div>
							<input type="text" class="form-control form-control-lg" disabled="" name="id" value="<%=member.getId()%>">
				    	</div>
				    	<div class="form-group">
				      		<label class="form-label mt-4">Date Of Join</label>
				      		<span style="margin-left: 10px" id="checkPasswdResult"></span>
				      		<input type="text" class="form-control form-control-lg" disabled="" name="date" value="<%=member.getDate() %>">
				    	</div>
				    	<div class="form-group">
							<label class="form-label mt-4">Gender</label><br>
							<input type="text" class="form-control form-control-lg" disabled="" name="gender" value="<%=member.getGender()%>">
				    	</div>
				      		<label class="form-label mt-4">E-Mail</label>
				    	<div>
				    		<input type="text" class="form-control form-control-lg" disabled="" name="email1" value="<%=member.getEmail1() %>">
				    	</div>
		  			<br>
		  			<legend>Optional</legend>
		  				<div class="form-group">
					    	<label class="form-label mt-4">Post Code</label><br>
		  					<input type="text" value="<%=member.getPost_code() %>" class="form-control form-control-lg" name="post_code" id="post_code" disabled="" >
		  				</div>
		  				<div style="clear: both;"></div>
			  			<div class="form-group">
					    	<label class="form-label mt-4">Address</label>
					      	<table>
					      		<tr>
					      			<td><input style="width: 395px; margin-right: 5px;" type="text" class="form-control form-control-lg" disabled="" name="address1" value="<%=member.getAddress1() %>"></td>
					      			<td><input style="width: 395px" type="text" class="form-control form-control-lg" disabled="" name="address2" value="<%=member.getAddress2() %>"></td>
					      		</tr>
					      	</table>
					    </div>
		  				<div class="form-group">
				    		<label class="form-label mt-4">Phone Number</label>
				      		<input type="text" class="form-control form-control-lg" disabled="" name="phone" value="<%=member.getPhone() %>">
				    	</div>
		  		</fieldset>
				<div style="clear: both;"></div>		
		  		<div id="table_search" style="float: right; margin-top: 25px;">
					<input type="button" value="수정" class="btn" onclick="location.href='memberInfo_update.jsp'">
					<input type="button" value="탈퇴" class="btn" onclick="location.href='memberInfo_delete.jsp'">
				</div>
		  	</form>
		</article>
		  
		<div style="clear: both;"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>
