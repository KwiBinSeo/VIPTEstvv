package com.cglab.smartplace;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cglab.smartplace.AllData; // Data 객체 입력 부분 추가
/**
 * Servlet implementation class menu1by3Toby4
 */
public class menu1by3Toby4 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public ArrayList<String> occupation = new ArrayList<String>();
	public ArrayList<String> occupation_yesterday = new ArrayList<String>();
	public ArrayList<String> occupation_today = new ArrayList<String>();
	public ArrayList<String> occupation_total = new ArrayList<String>();
		
    /**
     * @see HttpServlet#HttpServlet()
     */
    public menu1by3Toby4() {
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
		
		occupation.clear(); // 인원 현황을 저장할 ArrayList 초기화
		occupation_yesterday.clear(); // 전일 인원 현황 데이터를 저장할 ArrayList 초기화
		occupation_today.clear(); // 금일 인원 현황을 저장할 ArrayList 초기화
		occupation_total.clear(); // 누계 인원 현황 데이터를 ArrayList 초기화
		
		int occupation_count = (Integer) session.getAttribute("occupation_count");
		
		occupation = (ArrayList) session.getAttribute("occupation");
		occupation_yesterday = (ArrayList) session.getAttribute("occupation_yesterday");
		occupation_today = (ArrayList) session.getAttribute("occupation_today");
		occupation_total = (ArrayList) session.getAttribute("occupation_total");
		
		for(int i = 0; i < occupation_count; i++)
		{
			String occ = request.getParameter("mat"+i);
			String yest = request.getParameter("yest"+i);
			String today = request.getParameter("today"+i);
			String total = request.getParameter("total"+i);

			if(occupation == null)
			{
				occupation = new ArrayList<String>();
				session.setAttribute("occupation", occupation);
			}
			if(occupation_yesterday == null)
			{
				occupation_yesterday = new ArrayList<String>();
				session.setAttribute("occupation_yesterday", occupation_yesterday);
			}
			if(occupation_today == null)
			{
				occupation_today = new ArrayList<String>();
				session.setAttribute("occupation_today", occupation_today);
			}
			if(occupation_total == null)
			{
				occupation_total = new ArrayList<String>();
				session.setAttribute("occupation_total", occupation_total);
			}
			occupation.add(occ);
			occupation_yesterday.add(yest);
			occupation_today.add(today);
			occupation_total.add(total);
			
			System.out.println(occupation.get(i));
			System.out.println(occupation_yesterday.get(i));
			System.out.println(occupation_today.get(i));
			System.out.println(occupation_total.get(i));
		}
		
		// 장비 투입 현황 라인수를 표현 할 변수
		int equipment_count = 5;
		try {
			session.setAttribute("equipment_count", equipment_count);
		} catch(Exception e) {
			
		}
		response.sendRedirect("menu1by4.jsp");
	}

}
