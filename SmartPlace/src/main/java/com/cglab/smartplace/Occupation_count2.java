package com.cglab.smartplace;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cglab.smartplace.AllData; // AllData Class 추가

/**
 * Servlet implementation class Occupation_count2
 */
public class Occupation_count2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	//AllData AD = new AllData();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Occupation_count2() {
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
		HttpSession session = request.getSession(false);
		
		System.out.println("자바스크립트 호출 성공!!");
		
		int occupation_count = (Integer) session.getAttribute("occupation_count");
		occupation_count--; //occupation_count 값을 -1 감소
		try {
			session.setAttribute("occupation_count", occupation_count); // 세션 다시 설정
		} catch(Exception e) {
			
		}
		response.sendRedirect("menu1by3.jsp");
	}

}
