<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
request.setCharacterEncoding("UTF-8");
String sId = (String)session.getAttribute("sId");
String keyword = request.getParameter("keyword");
String select = request.getParameter("select");

if(keyword == null) {
	keyword = "";
}

int listLimit = 10;
int pageNum = 1;

if(request.getParameter("pageNum") != null) {
	pageNum = Integer.parseInt(request.getParameter("pageNum"));
}

int startRow = (pageNum - 1) * listLimit;

MemberDAO dao = new MemberDAO();
ArrayList<MemberDTO> memberList = dao.selectMemberList(startRow, listLimit, keyword, select);

int list = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin/member_search.jsp</title>

<style type="text/css"></style>
<link href="../css/NewFile.css" rel="stylesheet" type="text/css">
</head>
<body>
	<!-- 헤더 들어가는곳 -->
	<jsp:include page="../inc/top.jsp" />
	<!-- 헤더 들어가는곳 -->

	<!-- 본문들어가는 곳 -->
	<!-- 본문 메인 이미지 -->
	<div id="sub_img_center"><img width="100%" height="300" src="../images/looo.jpg"></div>
	
	<!-- 본문 내용 -->
	<article style="display: table; margin: 50px auto;">
		<table class="table" style="width: 1500px; float:left;">
		    <tr>
		    	<td colspan="5"><h1>Member List</h1></td>
		    </tr>
		    <tr class="table-active">
				<th scope="col">No.</th>
		    	<th scope="col">이름</th>
		      	<th scope="col">ID</th>
		      	<th scope="col">성별</th>
		      	<th scope="col">Email</th>
		      	<th scope="col">가입일</th>
		      	<th scope="col">글 수</th>
		      	<th scope="col">댓글 수</th>
		      	<th scope="col">비고</th>
		    </tr>
		    <%for(MemberDTO member : memberList) {
		    	list++;%>
		    	 <tr class="table-light">
			      <th scope="row"><%=list %></th>
			      <td><%=member.getName() %></td>
			      <td><%=member.getId() %></td>
			      <td><%=member.getGender() %></td>
			      <td><%=member.getEmail1() %></td>
			      <td><%=member.getDate() %></td>
			      <td><%=dao.postCount(member.getId()) %></td>
			      <td><%=dao.replyCount(member.getId()) %></td>
			      <td></td>
			    </tr>
		    <%} %>
		</table>
		
		<div style="clear: both;"></div>
		
		<!-- 검색 기능 -->
		<div id="table_search">
			<form style="display: inline;" action="member_search.jsp" method="get">
   				<select style="width: 180px; float: left; margin-left: 64%" class="form-select" id="exampleSelect1" name="select">
			        <option value="name">이름</option>
			        <option value="id">ID</option>
			    </select>
		        <input type="text" name="keyword" value="<%=keyword %>" style="width: 250px; float: left; margin: 0px 5px;" class="form-control" required="required">
   				<button type="submit" value="Search" style="float: left;" class="btn btn-light">Search</button>
     		</form>
		</div>
		
		
		<div style="clear: both;"></div>
		
			<%
			int memberListCount = dao.selectMemberListCount(keyword, select);
			int pageListLimit = 10;
			int maxPage = memberListCount / pageListLimit 
					+ (memberListCount % pageListLimit == 0 ? 0 : 1);
			int startPage = (pageNum - 1) / memberListCount * pageListLimit + 1;
			int endPage = startPage + pageListLimit - 1;
			if(endPage > maxPage) { endPage = maxPage; }
			%>
			
		<div style="width: 300px; margin-left: 50%; margin-right: auto;">
			
			<!-- 이전 페이지 버튼(Prev) 클릭 시 현재 페이지 번호 - 1 값 전달 -->
			<!-- 단, 현재 페이지번호가 1 페이지보다 클 경우 하이퍼링크 표시(아니면 제거) -->
			<%if(pageNum == 1) { %>
				<a style="text-decoration: none; font-size: 150%;" href="javascript:void(0)">&laquo;</a>
			<%} else { %>
				<a style="text-decoration: none; font-size: 150%;" href="member_list.jsp?pageNum=<%=pageNum - 1%>">&laquo;</a>
			<%} %>
			
			<!-- for문을 사용하여 startPage ~ endPage 까지 목록 표시 -->
			<%for(int i = startPage; i <= endPage; i++) { %>
				<!-- 현재 페이지 번호(pageNum) 가 i 값과 같을 경우 하이퍼링크 제거 -->
				<%if(pageNum == i) { %>
					<a style="text-decoration: none; font-size: 150%;" href="javascript:void(0)"><%=i %></a>
				<%} else { %>
					<a style="text-decoration: none; font-size: 150%;" href="member_list.jsp?pageNum=<%=i %>"><%=i %></a>
				<%} %>
			<%} %>
			
			<!-- 다음 페이지 버튼(Next) 클릭 시 현재 페이지 번호 + 1 값 전달 -->
			<!-- 단, 현재 페이지번호가 최대 페이지 번호보다 작을 경우 하이퍼링크 표시(아니면 제거) -->
			<%if(pageNum == maxPage) { %>
				<a style="text-decoration: none; font-size: 150%;" href="javascript:void(0)">&raquo;</a>
			<%} else { %>
				<a style="text-decoration: none; font-size: 150%;" href="member_list.jsp?pageNum=<%=pageNum + 1%>">&raquo;</a>
			<%} %>
			
		</div>
	</article>

	<div style="clear: both;"></div>
	
	<!-- 푸터 들어가는곳 -->
	<jsp:include page="../inc/bottom.jsp" />
	<!-- 푸터 들어가는곳 -->

</body>
</html>
    