package com.cglab.smartplace;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;
/**
 * Servlet implementation class LogoutCheck
 */
public class LogoutCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogoutCheck() {
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
		
		HttpSession session = request.getSession(); // true : 세션이 없을 경우 생성, false : 세션이 없을 경우 생성 안함
		
		request.setCharacterEncoding("utf-8"); // request된 데이터 utf-8로 인코딩

		session.removeAttribute("User_ID"); // 키 값이 User_ID 세션 삭제
		session.removeAttribute("User_PW"); // 키 값이 User_ID 세션 삭제
		
		session.invalidate();
		
		response.sendRedirect("menu1by7.jsp"); //로그인 실패 시 index.jsp 이동
	}

}
