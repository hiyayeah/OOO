package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import board.BoardDTO;
import db.JdbcUtil;

public class MemberDAO {

	public int insertMember(MemberDTO member) {
		int insertCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 1단계 & 2단계
		con = JdbcUtil.getConnection();
		
		try {
			// 3단계. SQL 구문 작성 및 전달
			// => 글 쓰기(INSERT) 작업 수행
			String sql = "INSERT INTO member VALUES (?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getId());
			pstmt.setString(3, member.getPass());
			pstmt.setString(4, member.getGender());
			pstmt.setString(5, member.getEmail1() + "@" + member.getEmail2());
			pstmt.setString(6, member.getPost_code());
			pstmt.setString(7, member.getAddress1());
			pstmt.setString(8, member.getAddress2());
			pstmt.setString(9, member.getPhone());
			
			// 4단계. SQL 구문 실행 및 결과 처리
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - insertMember()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return insertCount;
	}
	
	
	public int login(MemberDTO member) {
		int loginMember = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				loginMember = 1;
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - login()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		return loginMember;
	}
	
	
	
	
	public boolean checkId(String id) {
		boolean isDuplicate = false;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 1단계 & 2단계
		Connection con = JdbcUtil.getConnection();
		
		try {
			// SELECT 구문을 사용하여 아이디가 일치하는 레코드 검색
			// => 아이디가 일치하는 레코드가 있을 경우 isDuplicate 변수값을 true 로 변경
			String sql = "SELECT * FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				isDuplicate = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return isDuplicate;
	}
	
	
	
	public MemberDTO selectMember(String id) {
		MemberDTO member = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 1단계 & 2단계
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 조회 결과가 있을 경우 MemberDTO 객체 생성 및 데이터 저장
				member = new MemberDTO();
				member.setName(rs.getString("name"));
				member.setId(rs.getString("id"));
				member.setPass(rs.getString("pass"));
				member.setGender(rs.getString("gender"));
				member.setEmail1(rs.getString("email"));
				member.setPost_code(rs.getString("post_code"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setPhone(rs.getString("phone"));
				member.setDate(rs.getDate("date"));
			}
		}  catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - selectMember()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return member;
	}
	
	
	
	
	public int selectMemberListCount() {
		int memberListCount = 0;
		
		// DB 작업에 사용할 변수 선언
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 1단계&2단계 작업을 수행하기 위해 JdbcUtil 클래스의 getConnection() 메서드 호출
		// => static 메서드이므로 클래스명만으로 접근 가능함
		con = JdbcUtil.getConnection();
		
		try {
			// 게시물 목록 갯수 조회 => COUNT(*) 함수 활용
			String sql = "SELECT COUNT(*) FROM member";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				memberListCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - selectMemberListCount()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return memberListCount;
	}

	
	// 전체 회원 조회하는 selectMemberListCount() 메서드 정의(검색 기능 추가)
	// => 파라미터 : 검색어(keyword)    리턴타입 : int(memberListCount)
	public int selectMemberListCount(String keyword, String select) {
		int memberListCount = 0;
		
		// DB 작업에 사용할 변수 선언
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 1단계&2단계 작업을 수행하기 위해 JdbcUtil 클래스의 getConnection() 메서드 호출
		// => static 메서드이므로 클래스명만으로 접근 가능함
		con = JdbcUtil.getConnection();
		
		try {
			// 게시물 목록 갯수 조회 => COUNT(*) 함수 활용
			// 검색 기능이 추가됐으므로 WHERE 절에 검색어 추가(제목 검색)
			// => WHERE 절에 LIKE 결합
			String sql = "SELECT COUNT(*) FROM member WHERE " + select + " LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%"); // 검색어를 포함하기 위해 % 결합
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				memberListCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - selectMemberListCount()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return memberListCount;
	}
	
	
	
	
	
	
	public ArrayList<MemberDTO> selectMemberList(int startRow, int listLimit) {
		// ArrayList 타입 사용 시 클래스명 뒤에 <> 기호를 쓰고, 기호 사이에 클래스타입을 지정하면
		// 해당 ArrayList 객체에서 사용되는 데이터는 모두 지정된 클래스타입 데이터로만 사용된다!
		ArrayList<MemberDTO> memberList = null; // ArrayList 에서 사용할 데이터를 MemberDTO 타입으로 고정
		
		// DB 작업에 사용할 변수 선언
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 1단계&2단계 작업을 수행하기 위해 JdbcUtil 클래스의 getConnection() 메서드 호출
		// => static 메서드이므로 클래스명만으로 접근 가능함
		con = JdbcUtil.getConnection();
		
		try {
			// 3단계. SQL 구문 작성 및 전달
			String sql = "SELECT * FROM member ORDER BY name LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);
			
			// 4단계. SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			
			// 전체 게시물 목록을 저장할 ArrayList 객체 생성
			memberList = new ArrayList<MemberDTO>(); // MemberDTO 객체 저장 전용 ArrayList 객체 생성됨
			
			// 조회 결과가 있을 경우 레코드 접근 반복
			while(rs.next()) {
				// 1개 레코드를 저장할 MemberDTO 객체 생성 후 데이터 저장
				MemberDTO member = new MemberDTO();
				member.setName(rs.getString("name"));
				member.setId(rs.getString("id"));
				member.setGender(rs.getString("gender"));
				member.setEmail1(rs.getString("email"));
				member.setDate(rs.getDate("date"));
				
				// 전체 레코드를 저장할 ArrayList<MemberDTO> 객체에 1개 레코드가 저장된 MemberDTO 객체 추가
				memberList.add(member);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - selectMemberList()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환 - JdbcUtil 클래스의 static 메서드 close() 호출
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return memberList;
	}
	
	
	
	
	
	public ArrayList<MemberDTO> selectMemberList(int startRow, int listLimit, String keyword, String select) {
		// ArrayList 타입 사용 시 클래스명 뒤에 <> 기호를 쓰고, 기호 사이에 클래스타입을 지정하면
		// 해당 ArrayList 객체에서 사용되는 데이터는 모두 지정된 클래스타입 데이터로만 사용된다!
		ArrayList<MemberDTO> memberList = null; // ArrayList 에서 사용할 데이터를 MemberDTO 타입으로 고정
		
		// DB 작업에 사용할 변수 선언
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 1단계&2단계 작업을 수행하기 위해 JdbcUtil 클래스의 getConnection() 메서드 호출
		// => static 메서드이므로 클래스명만으로 접근 가능함
		con = JdbcUtil.getConnection();
		
		try {
			// 3단계. SQL 구문 작성 및 전달
			String sql = "SELECT * FROM member WHERE " + select + " LIKE ? ORDER BY name LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, listLimit);
			
			// 4단계. SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			
			// 전체 게시물 목록을 저장할 ArrayList 객체 생성
			memberList = new ArrayList<MemberDTO>(); // MemberDTO 객체 저장 전용 ArrayList 객체 생성됨
			
			// 조회 결과가 있을 경우 레코드 접근 반복
			while(rs.next()) {
				// 1개 레코드를 저장할 MemberDTO 객체 생성 후 데이터 저장
				MemberDTO member = new MemberDTO();
				member.setName(rs.getString("name"));
				member.setId(rs.getString("id"));
				member.setGender(rs.getString("gender"));
				member.setEmail1(rs.getString("email"));
				member.setDate(rs.getDate("date"));
				
				// 전체 레코드를 저장할 ArrayList<MemberDTO> 객체에 1개 레코드가 저장된 MemberDTO 객체 추가
				memberList.add(member);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - selectMemberList()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환 - JdbcUtil 클래스의 static 메서드 close() 호출
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return memberList;
	}
	
	
	
	
	public int postCount(String name) {
		int postCount = 0;
		
		// DB 작업에 사용할 변수 선언
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 1단계&2단계 작업을 수행하기 위해 JdbcUtil 클래스의 getConnection() 메서드 호출
		// => static 메서드이므로 클래스명만으로 접근 가능함
		con = JdbcUtil.getConnection();
		
		try {
			// 게시물 목록 갯수 조회 => COUNT(*) 함수 활용
			// 검색 기능이 추가됐으므로 WHERE 절에 검색어 추가(제목 검색)
			// => WHERE 절에 LIKE 결합
			String sql ="select ( (select count(*) from board where name=?) + (select count(*) from file_board where name=?) + (select count(*) from img_board where name=?))";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, name);
			pstmt.setString(3, name);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				postCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - postCount()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return postCount;
	}
	
	
	
	
	
	public int replyCount(String name) {
		int replyCount = 0;
		
		// DB 작업에 사용할 변수 선언
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 1단계&2단계 작업을 수행하기 위해 JdbcUtil 클래스의 getConnection() 메서드 호출
		// => static 메서드이므로 클래스명만으로 접근 가능함
		con = JdbcUtil.getConnection();
		
		try {
			// 게시물 목록 갯수 조회 => COUNT(*) 함수 활용
			// 검색 기능이 추가됐으므로 WHERE 절에 검색어 추가(제목 검색)
			// => WHERE 절에 LIKE 결합
			String sql = "SELECT COUNT(*) FROM reply WHERE name=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name); // 검색어를 포함하기 위해 % 결합
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				replyCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - replyCount()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return replyCount;
	}
	
	
	
	// 회원정보 수정 작업을 위한 updateMember()
	public int updateMember(MemberDTO member, String sId) {
		int updateCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			// 1단계 & 2단계
			con = JdbcUtil.getConnection();
			
			// 글번호와 패스워드가 일치하는 게시물의 작성자, 제목, 내용 수정(UPDATE)
			String sql = "UPDATE member SET post_code=?,address1=?,address2=?,phone=? WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getPost_code());
			pstmt.setString(2, member.getAddress1());
			pstmt.setString(3, member.getAddress2());
			pstmt.setString(4, member.getPhone());
			pstmt.setString(5, sId);
			
			updateCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - updateMember()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		return updateCount;
	}
	
	
	
	public int deleteMember(String sId, String pass) {
		int deleteCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			// 1단계 & 2단계
			con = JdbcUtil.getConnection();
			
			// 글번호와 패스워드가 일치하는 레코드 삭제
			String sql = "DELETE FROM member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sId);
			pstmt.setString(2, pass);
			
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - deleteMember()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		return deleteCount;
	}
	
	
	
	
	
	
	
}
