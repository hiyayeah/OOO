<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String sId = (String)session.getAttribute("sId");
%>
<script>
	function confirm_logout() {
		var result = confirm("로그아웃 하시겠습니까?");
		if(result) {
			location.href = "../member/logout.jsp"
		}
	}
</script>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div><img style="width: 100px; margin-left: 15px" src="../images/그림3.png"></div>
		<div class="container-fluid">
<!-- 			<a class="navbar-brand" href="#">오운완</a> -->
			<ul class="navbar-nav me-auto">
				<li class="nav-item">
					<a class="nav-link active" href="../main/main.jsp">Home</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="../center/notice.jsp">Notice</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="../center/driver.jsp">Freeboard</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="../img_board/img.jsp">Gallery</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="../main/about.jsp">About</a>
				</li>
			</ul>
			<form class="d-flex">
				<%if(sId == null) { %>
						<button type="button" class="btn btn-light"onclick="location.href='../member/login.jsp'">login</button>
						<button type="button" class="btn btn-info" onclick="location.href='../member/join.jsp'">join</button>
					<%} else { %>
						<button type="button" class="btn btn-light"onclick="location.href='../member/memberInfo.jsp'"><%=sId %> 님</button>
						<button type="button" class="btn btn-info" onclick="confirm_logout()">logout</button>
						
						<%-- 만약, 로그인 된 아이디가 "admin" 일 경우 관리자 페이지(admin/admin_main.jsp) 링크 표시 --%>
						<%if(sId.equals("admin")) { %>
							<button type="button" class="btn btn-outline-info" onclick="location.href='../admin/member_list.jsp'">관리자 페이지</button>
						<%} %>
					<%} %>
			
<!-- 				<button type="button" class="btn btn-light"onclick="location.href='../member/login.jsp'">login</button> -->
<!-- 				<button type="button" class="btn btn-info" onclick="location.href='../member/join.jsp'">join</button> -->
			</form>
		</div>
	</div>
</nav>

