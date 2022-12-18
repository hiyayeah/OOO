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
<title>member/memberInfo_update.jsp</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('post_code').value = data.zonecode;
                document.getElementById("address1").value = roadAddr;
                document.getElementById("address2").focus();
            }
        }).open();
    }
</script>
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
			<form action="memberInfo_updatePro.jsp" method="post" style="margin: 10px 200px;">
				<h1>Member Info - 정보수정</h1>
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
		  					<input type="text" style="width: 70%; float: left;" value="<%=member.getPost_code() %>" class="form-control" name="post_code" id="post_code" onclick="execDaumPostcode()">
		  					<button type="button" style="float: left; margin-left: 10px;" class="btn btn-outline-primary" onclick="execDaumPostcode()">검색</button>
		  				</div>
		  				<div style="clear: both;"></div>
		  				
		  				
		  				<div class="form-group">
					    	<label class="form-label mt-4">Address</label>
					      	<table>
					      		<tr>
					      			<td><input style="width: 395px; margin-right: 5px;" type="text" class="form-control" name="address1" id="address1" value="<%=member.getAddress1() %>"></td>
					      			<td><input style="width: 395px" type="text" class="form-control" name="address2" id="address2" value="<%=member.getAddress2() %>"></td>
					      		</tr>
					      	</table>
					    </div>
		  				<div class="form-group">
				    		<label class="form-label mt-4">Phone Number</label>
				      		<input type="text" class="form-control" value="<%=member.getPhone() %>" name="phone">
				    	</div>
		  		</fieldset>
				<div style="clear: both;"></div>		
		  		<div id="table_search" style="float: right; margin-top: 25px;">
					<input type="submit" value="수정하기" class="btn">
					<input type="reset" value="취소" class="btn">
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
