<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
boolean isDuplicate = Boolean.parseBoolean(request.getParameter("isDuplicate"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/check_id.jsp</title>
<script type="text/javascript">
	
// 	window.onload = function() {
		
// 	}
	
	function getCheckId(){
		<%if(id != null) {%>
			document.fr.id.value = "<%=request.getParameter("id") %>";
			<%if(isDuplicate == true) {%>
				document.getElementById("checkIdResult").innerHTML = "이미 사용중인 아이디";
				document.getElementById("checkIdResult").style.color = "#e52527";
			<%} else{%>
				var btn = "<input type='button' class='btn btn-outline-info' value='아이디 사용' onclick='useId()'>";
				document.getElementById("checkIdResult").innerHTML = "사용 가능한 아이디<br>" + btn;
				document.getElementById("checkIdResult").style.color = "#378dfc";
			
			<%}%>
			
		<%}%>
	}
	
	function useId() {
		// 부모창(join.jsp)의 ID 입력란에 중복 확인이 완료된 ID 값 표시
// 		window.opener.document.fr.id.value = document.fr.id.value;
		window.opener.document.fr.id.value = "<%=id %>";
		
		// 현재 자식창(check_id.jsp) 닫기
		window.close();
	}
	
	
	
</script>
<link href="../css/NewFile.css" rel="stylesheet" type="text/css">
</head>
<body onload="getCheckId()">

	<h1 style="text-align: center;">ID 중복 체크</h1>
	<form action="check_idPro.jsp" name="fr">
		<input type="text" class="form-control" name="id" required="required">
		<button type="submit" style="float: right;" class="btn btn-outline-info" onclick="">중복확인</button><br><br>
		<div style="float: left;" id="checkIdResult"></div>
	</form>
	
</body>
</html>