package com.cglab.smartplace;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*; // sql 관련 헤더파일
/**
 * Servlet implementation class LoginCheck
 */
public class LoginCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	AllData AD = new AllData();
	
	// 변수 선언
	private String User_ID = "";
	private String User_PW = "";
	private boolean Login_Check = false; // 로그인 체크
	private boolean Input_Check = false; // 입력 받는 데이터(아이디, 비밀번호) 체크
	
	// DB 연결 관련 변수
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null;
	String URL = "jdbc:mysql://220.69.209.170/smartplace";
	String DB_NAME = "cglab";
	String DB_PW = "clws";
	String query = "";
	
	String user_name = "";
	String user_position = "";
	String user_id = "";
	String user_pw = "";
	String user_area = "";
	String user_area_number = "";
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginCheck() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);

		
		HttpSession session = request.getSession(); //세션 객체 생성
		PrintWriter out = response.getWriter();
		
		request.setCharacterEncoding("utf-8"); // request된 데이터 utf-8로 인코딩
		setUserID(request.getParameter("User_ID")); // User_ID 값을 입력받아 User_ID 변수에 초기화
		setUserPW(request.getParameter("User_PW")); // User_PW 값을 입력받아 User_PW 변수에 초기화
		
		if(User_ID != "" || User_ID != null)
		{
			if(User_PW != "" || User_PW != null)
			{
				Input_Check = true; // 입력된 데이터를 체크하는 변수인 Input_Check 변수를 true로 변경
			}
			else
				System.out.println("사용자 비밀번호를 입력하세요.");
		}
		else
		{
			System.out.println("사용자 아이디를 입력하세요.");
		}
		
		// Input_Check가 true이면 실행 (아이디와 비밀번호가 입력되어 있으면 실행)
		if(Input_Check) {
			try {
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(URL, DB_NAME, DB_PW);
				stmt = conn.createStatement(); // 상태 확인
				
				query = "select * from master_member where id='"+User_ID+"'"; // User_ID와 같은 정보를 master_member 테이블에서 검색
				rs = stmt.executeQuery(query); // 쿼리문 실행
				
				if(rs.next()) {
					user_name = rs.getString("name");
					user_position = rs.getString("position");
					user_id = rs.getString("id");
					user_pw = rs.getString("password");
					user_area = rs.getString("management_area");
					user_area_number = rs.getString("area_number");

					// 입력한 아이디와 비밀번호와 찾은 비밀번호가 같은지 비교
					if(User_ID.equals(user_id) && User_PW.equals(user_pw)) {
						Login_Check = true;
					}
					else {
						Login_Check = false;
					}
				}
				else {
					Login_Check = false;
				}
			} catch(SQLException se) {
				System.out.println("DB연결을 실패하였습니다.");
			} catch(ClassNotFoundException cnfe) {
				cnfe.printStackTrace();
			}
		}
		else {
			response.sendRedirect("index.jsp");
		}
		
		// Login_Check 값이 true이면 실행
		if(Login_Check) {
			session.setAttribute("User_NAME", user_name); // 사용자 이름
			session.setAttribute("User_POSITION", user_position); // 사용자 직책
			session.setAttribute("User_ID", User_ID); // 사용자 아이디
			session.setAttribute("User_PW", User_PW); // 사용자 비밀번호
			session.setAttribute("User_AREA", user_area); // 사용자 관리 지역
			session.setAttribute("User_AREA_NUMBER", user_area_number); // 사용자 지역 번호
						
			response.sendRedirect("menu1by1.jsp");
		}
		else {
			response.sendRedirect("index.jsp"); //로그인 실패 시 index.jsp 이동
			out.println("<script>");
			out.println("alert(로그인 실패)");
			out.println("history.go(-1)"); //이전 페이지 이동
			out.println("</script>");
		}
	}
	
	// Getter
	public String getUserID() {
		return User_ID;
	}
	
	public String getUserPW() {
		return User_PW;
	}
	
	public boolean getLoginCheck() {
		return Login_Check;
	}
	
	public boolean getInputCheck() {
		return Input_Check;
	}
	
	// Setter
	public void setUserID(String User_ID) {
		this.User_ID = User_ID;
	}
	
	public void setUserPW(String User_PW) {
		this.User_PW = User_PW;
	}
	
	public void setLoginCheck(boolean Login_Check) {
		this.Login_Check = Login_Check;
	}

	public void setInputCheck(boolean Input_Check) {
		this.Input_Check = Input_Check;
	}
}
