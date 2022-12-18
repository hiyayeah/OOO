<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/join.jsp</title>
<script type="text/javascript">
	
	var isSamePass = false;
	var isCorrectPass = false;
	
	function checkId() {
		window.open("check_id.jsp", "ID 중복확인", "width=500px, height=300px");
	}
	
	
	//<input type="password" name="passwd" placeholder="8 ~ 16글자 사이 입력" onkeyup="checkPasswd(this.value)">	
	function checkPasswd(pass) {
		var spancheckPasswdResult = document.getElementById("checkPasswdResult");
		if(pass.length >= 8 && pass.length <= 16){
			spancheckPasswdResult.innerHTML = "*사용 가능한 패스워드";
			spancheckPasswdResult.style.color = "#378dfc";
			isCorrectPassword = true;
		} else {
			spancheckPasswdResult.innerHTML = "*사용 불가능한 패스워드";
			spancheckPasswdResult.style.color = "#e52527";
			isCorrectPassword = false;
		}
	}

	
	function checkPasswd2(pass2) {
		var spancheckPasswd2Result = document.getElementById("checkPasswd2Result");
		
		if(pass2 == document.fr.pass.value) {
			spancheckPasswd2Result.innerHTML = "*비밀번호 일치";
			spancheckPasswd2Result.style.color = "#378dfc";
			isSamePass = true;
		} else {
			spancheckPasswd2Result.innerHTML = "*비밀번호 불일치";
			spancheckPasswd2Result.style.color = "#e52527";
			isSamePass = false;
		}
	}
	
	function selectDomain(domain) {
		document.fr.email2.value = domain;
		
		// 만약, 직접입력 항목 선택 시("" 입력 시) 
		if(domain == "") {
			document.fr.email2.focus();
		}
	}
	
	function checkForm() {
		
		// 2) 두 패스워드 비교 결과를 저장한 변수를 사용하여 판별하는 방법 
		if(document.fr.id.value == "") { 
			alert("아이디 입력 필수!");
			document.fr.id.focus();
			return false;
		} else if(!isSamePass) {
			alert("패스워드가 일치하지 않습니다!");
			document.fr.pass.select();
			return false;
		}
		
		return true;
	}
	

</script>

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
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->
		  
		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"><img width="100%" height="300" src="../images/6.jpg"></div>

		<!-- 본문 내용 -->
		<article style="display: table; width: 1200px; margin: 20px auto;">
			<form action="joinPro.jsp" method="post" name="fr"  style="margin: 10px 200px;" onsubmit="return checkForm()">
				<h1>Join Us</h1>
				<fieldset>
					<legend>Basic Info</legend>
						<div class="form-group">
				    		<label class="form-label mt-4">Name</label>
				      		<input type="text" class="form-control" name="name" required="required">
				    	</div>
				    	<div class="form-group">
				      		<label class="form-label mt-4">User Id</label>
				      	<div style="clear:both; "></div>
							<input type="text" style="width: 70%; float: left;" class="form-control" name="id" placeholder="중복확인 버튼클릭" readonly="readonly" onclick="checkId()" required="required">
							<button type="button" style="float: left; margin-left: 10px;" class="btn btn-outline-primary" onclick="checkId()">중복확인</button>
						<div style="clear:both; "></div>
				    	</div>
				    	<div class="form-group">
				      		<label class="form-label mt-4">Password</label>
				      		<span style="margin-left: 10px" id="checkPasswdResult"></span>
				      		<input type="password" class="form-control" name="pass" placeholder="8 ~ 16글자 사이 입력" onkeyup="checkPasswd(this.value)" required>
				    	</div>
				    	<div class="form-group">
				      		<label class="form-label mt-4">Retype Password</label>
				      		<span style="margin-left: 10px" id="checkPasswd2Result"></span> 
				      		<input type="password" class="form-control" name="pass2" onkeyup="checkPasswd2(this.value)" required>
				    	</div>
				    	<div class="form-group">
							<label class="form-label mt-4">Gender</label><br>
					   		<input style="vertical-align: middle;" class="form-check-input" type="radio" name="gender" value="남">
					   		<strong style="margin-right: 25px; font-size: large;">남</strong>
					    	<input style="vertical-align: middle;" class="form-check-input" type="radio" name="gender" value="여">
					    	<strong style="font-size: large;">여</strong>
				    	</div>
				      		<label class="form-label mt-4">E-Mail</label>
				    	<div>
				    		<table>
				    			<tr>
				    				<td><input type="text" class="form-control" name="email1" required></td>
				    				<th> @ </th>
				    				<td><input type="text" class="form-control" name="email2" required></td>
				    				<td>
				    					<select style="margin-left:10px;" class="form-select" name="emailDomain" onchange="selectDomain(this.value)">
							        		<option value="">직접입력</option>
									        <option value="gmail.com">gmail.com</option>
									        <option value="hanmail.net">hanmail.net</option>
									        <option value="nate.com">nate.com</option>
									        <option value="naver.com">naver.com</option>
	     								</select>
				    				</td>
				    			</tr>
				    		</table>
		  		</fieldset>
		  		<fieldset>
		  			<br>
		  			<legend>Optional</legend>
		  				<div class="form-group">
					    	<label class="form-label mt-4">Post Code</label><br>
		  					<input type="text" style="width: 70%; float: left;" class="form-control" name="post_code" id="post_code" placeholder="우편번호" onclick="execDaumPostcode()">
		  					<button type="button" style="float: left; margin-left: 10px;" class="btn btn-outline-primary" onclick="execDaumPostcode()">검색</button>
		  				</div>
		  				<div style="clear: both;"></div>
			  			<div class="form-group">
					    	<label class="form-label mt-4">Address</label>
					      	<table>
					      		<tr>
					      			<td><input style="width: 395px; margin-right: 5px;" type="text" class="form-control" name="address1" id="address1"  placeholder="주소"></td>
					      			<td><input style="width: 395px" type="text" class="form-control" name="address2" id="address2" placeholder="상세주소"></td>
					      		</tr>
					      	</table>
					    </div>
		  				<div class="form-group">
				    		<label class="form-label mt-4">Phone Number</label>
				      		<input type="text" class="form-control" name="phone" >
				    	</div>
		  		</fieldset>
				<div style="clear: both;"></div>		
		  		<div id="table_search" style="float: right; margin-top: 25px;">
					<input type="submit" value="가입" class="btn">
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


