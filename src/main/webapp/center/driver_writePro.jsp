<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// notice_write.jsp 페이지로부터 전달받은 파라미터를 사용하여 funweb.board 테이블에 추가
request.setCharacterEncoding("UTF-8");

String uploadPath = "/upload";
int fileSize = 1024 * 1024 * 20;
ServletContext context = request.getServletContext();
String realPath = context.getRealPath(uploadPath);

MultipartRequest multi = new MultipartRequest(
		request, 
		realPath,
		fileSize,
		"UTF-8", 
		new DefaultFileRenamePolicy()
	);

FileBoardDTO board = new FileBoardDTO();
board.setName(multi.getParameter("name"));
board.setPass(multi.getParameter("pass"));
board.setSubject(multi.getParameter("subject"));
board.setContent(multi.getParameter("content"));

String fileElement = multi.getFileNames().nextElement().toString();

board.setOriginal_file(multi.getOriginalFileName(fileElement)); // 원본 파일명
board.setReal_file(multi.getFilesystemName(fileElement)); // 실제 업로드 된 파일명

FileBoardDAO dao = new FileBoardDAO();
int insertCount = dao.insertFileBoard(board);

if(insertCount > 0) { // 회원가입 성공 시 driver.jsp 포워딩
	response.sendRedirect("driver.jsp");
} else { // 실패 시
	%>
	<script>
		alert("글쓰기 실패!");
		history.back();
	</script>
	<%} %>