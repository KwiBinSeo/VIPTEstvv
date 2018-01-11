package com.cglab.smartplace;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class menu1by4Toby5
 */
public class menu1by4Toby5 extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	//AllData AD = new AllData();
	public ArrayList<String> equipment = new ArrayList<String>();
	public ArrayList<String> equipment_yesterday = new ArrayList<String>();
	public ArrayList<String> equipment_today = new ArrayList<String>();
	public ArrayList<String> equipment_total = new ArrayList<String>();
		
    /**
     * @see HttpServlet#HttpServlet()
     */
    public menu1by4Toby5() {
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
		
		equipment.clear(); // 장비 현황을 저장할 ArrayList 초기화
		equipment_yesterday.clear(); // 전일 장비 현황 데이터를 저장할 ArrayList 초기화
		equipment_today.clear(); // 금일 장비 현황을 저장할 ArrayList 초기화
		equipment_total.clear(); // 누계 장비 현황 데이터를 ArrayList 초기화
		
		int equipment_count = (Integer) session.getAttribute("equipment_count");
		
		equipment = (ArrayList) session.getAttribute("equipment");
		equipment_yesterday = (ArrayList) session.getAttribute("equipment_yesterday");
		equipment_today = (ArrayList) session.getAttribute("equipment_today");
		equipment_total = (ArrayList) session.getAttribute("equipment_total");
		
		for(int i = 0; i < equipment_count; i++)
		{
			String equip = request.getParameter("equip"+i);
			String yest = request.getParameter("yest"+i);
			String today = request.getParameter("today"+i);
			String total = request.getParameter("total"+i);
			
			if(equipment == null)
			{
				equipment = new ArrayList<String>();
				session.setAttribute("equipment", equipment);
			}
			if(equipment_yesterday == null)
			{
				equipment_yesterday = new ArrayList<String>();
				session.setAttribute("equipment_yesterday", equipment_yesterday);
			}
			if(equipment_today == null)
			{
				equipment_today = new ArrayList<String>();
				session.setAttribute("equipment_today", equipment_today);
			}
			if(equipment_total == null)
			{
				equipment_total = new ArrayList<String>();
				session.setAttribute("equipment_total", equipment_total);
			}
			
			equipment.add(equip);
			equipment_yesterday.add(yest);
			equipment_today.add(today);
			equipment_total.add(total);
			
			System.out.println(equipment.get(i));
			System.out.println(equipment_yesterday.get(i));
			System.out.println(equipment_today.get(i));
			System.out.println(equipment_total.get(i));
		}
		
		// 관급 페이지러 넘어가기 전에 자재 데이터를 저장하는 부분
		
		response.sendRedirect("menu1by5.jsp");
	}

}
