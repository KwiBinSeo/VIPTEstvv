package com.cglab.smartplace;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class menu1by2Toby3
 */
public class menu1by2Toby3 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ArrayList<String> construction = new ArrayList<String>();
	public ArrayList<String> construction_number = new ArrayList<String>();
	public ArrayList<String> total = new ArrayList<String>();
	public ArrayList<String> today_result = new ArrayList<String>();
	public ArrayList<String> accumulate = new ArrayList<String>();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public menu1by2Toby3() {
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
		response.setCharacterEncoding("euc-kr");
		//AllData AD = new AllData(); // AllData 객체 생성
		HttpSession session = request.getSession(false);
		
		PrintWriter out = response.getWriter();
		
		// 공종 관련 데이터를 저장 할 ArrayList 초기화
		construction.clear();
		total.clear();
		today_result.clear();
		accumulate.clear();
		
		int construction_list_count = (Integer) session.getAttribute("construction_list_count"); // 공종 리스트들의 카운트를 저장하는 세션
		//int construction_list_count = Integer.parseInt(temp); // String을 Int로 형변환
		
		// ArrayList에 Session 담기
		construction = (ArrayList) session.getAttribute("construction"); // 현재 진행하고있음 한줄밖에 작성 안함
		total = (ArrayList) session.getAttribute("total");
		today_result = (ArrayList) session.getAttribute("today_result");
		accumulate = (ArrayList) session.getAttribute("accumulate");
		// 전달받은 데이터를 받아오기
		
		for(int i = 0; i < construction_list_count; i++) {
			//construction.add(request.getParameter("con"+i));
			//total.add(request.getParameter("tot"+i));
			//today_result.add(request.getParameter("today_result"+i));
			//accumulate.add(request.getParameter("accumulate"+i));	
			//System.out.println(construction.get(i));
			
			String con = request.getParameter("con"+i);
			String to = request.getParameter("tot"+i);
			String today_res = request.getParameter("today_result"+i);
			String acc = request.getParameter("accumulate"+i);
			
			if(construction == null)
			{
				construction = new ArrayList<String>();
				session.setAttribute("construction", construction);
			}
			if(total == null)
			{
				total = new ArrayList<String>();
				session.setAttribute("total", total);
			}
			if(today_result == null)
			{
				today_result = new ArrayList<String>();
				session.setAttribute("today_result", today_result);
			}
			if(accumulate == null)
			{
				accumulate = new ArrayList<String>();
				session.setAttribute("accumulate", accumulate);
			}
			construction.add(con);
			total.add(to);
			today_result.add(today_res);
			accumulate.add(acc);
		}
		
		session.setAttribute("construction",construction);
		session.setAttribute("total",total); // 설계량
		session.setAttribute("today_result",today_result); // 오늘 실적
		session.setAttribute("accumulate",accumulate); // 누적
		
		int occupation_count = 5;
		session.setAttribute("occupation_count", occupation_count); // 인원 투입현황 카운트
		
		response.sendRedirect("menu1by3.jsp");
	}
}
