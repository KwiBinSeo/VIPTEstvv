package com.cglab.smartplace;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// 관급자재 페이지에서 사급 자재 페이지로 이동

/**
 * Servlet implementation class menu1by6Toby7
 */
public class menu1by6Toby7 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public ArrayList<String> materials_s = new ArrayList<String>(); // 사급 자재를 저장할 ArrayList
	public ArrayList<String> materials_total_s = new ArrayList<String>(); // 사급 자재 설계량을 저장 할 변수
	public ArrayList<String> materials_type_s = new ArrayList<String>(); // 자재 타입(사급)을 저장할 ArrayList
	public ArrayList<String> materials_base_quantity_s = new ArrayList<String>(); // 사급 자재 별 기반입량을 저장할 ArrayList
	public ArrayList<String> materials_input_quantity_s = new ArrayList<String>(); // 사급 자재 별 반입량을 저장할 ArrayList
	public ArrayList<String> materials_total_quantity_s = new ArrayList<String>(); // 사급 자재 별 반입 누계를 저장할 ArrayList
	public ArrayList<String> materials_etc_s = new ArrayList<String>(); // 사급 자재 별 비고를 저장할 ArrayList  
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public menu1by6Toby7() {
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

		materials_s.clear(); 				  // 자재명을 저장할 ArrayList
		materials_type_s.clear(); 			  // 자재 타입(관급/사급)을 저장할 ArrayList
		materials_total_s.clear(); 		      // 자재 별 설계량 저장할 ArrayList
		materials_base_quantity_s.clear();    // 자재 별 기반입량을 저장할 ArrayList
		materials_input_quantity_s.clear();   // 자재 별 반입량을 저장할 ArrayList
		materials_total_quantity_s.clear();   // 자재 별 반입 누계를 저장할 ArrayList
		materials_etc_s.clear(); 			  // 자재 별 비고를 저장할 ArrayList
		
		int materials_list_count_s = (Integer) session.getAttribute("materials_list_count_s"); // 관급 자재 리스트들의 카운트를 저장하는 세션
		
		materials_s = (ArrayList) session.getAttribute("materials_s");
		materials_total_s = (ArrayList) session.getAttribute("materials_total_s");
		materials_base_quantity_s = (ArrayList) session.getAttribute("materials_base_quantity_s");
		materials_input_quantity_s = (ArrayList) session.getAttribute("materials_input_quantity_s");
		materials_total_quantity_s = (ArrayList) session.getAttribute("materials_total_quantity_s");
		materials_etc_s = (ArrayList) session.getAttribute("materials_etc_s");
		
		for(int index = 0; index < materials_list_count_s; index++)
		{
			String materials = request.getParameter("materials"+index);
			String materials_total = request.getParameter("materials_total"+index);
			String materials_base_quantity = request.getParameter("materials_base_quantity"+index);
			String materials_input_quantity = request.getParameter("materials_input_quantity"+index);
			String materials_total_quantity = request.getParameter("materials_total_quantity"+index);
			String materials_etc = request.getParameter("materials_etc"+index);
			
			if(materials_s == null)
			{
				materials_s = new ArrayList<String>();
				session.setAttribute("materials_s", materials_s);
			}
			if(materials_total_s == null)
			{
				materials_total_s = new ArrayList<String>();
				session.setAttribute("materials_total_s", materials_total_s);
			}
			if(materials_base_quantity_s == null)
			{
				materials_base_quantity_s = new ArrayList<String>();
				session.setAttribute("materials_base_quantity_s", materials_base_quantity_s);
			}
			if(materials_input_quantity_s == null)
			{
				materials_input_quantity_s = new ArrayList<String>();
				session.setAttribute("materials_input_quantity_s", materials_input_quantity_s);
			}
			if(materials_total_quantity_s == null)
			{
				materials_total_quantity_s = new ArrayList<String>();
				session.setAttribute("materials_total_quantity_s", materials_total_quantity_s);
			}
			if(materials_etc_s == null)
			{
				materials_etc_s = new ArrayList<String>();
				session.setAttribute("materials_etc_s", materials_etc_s);
			}
			materials_s.add(materials);
			materials_total_s.add(materials_total);
			materials_base_quantity_s.add(materials_base_quantity);
			materials_input_quantity_s.add(materials_input_quantity);
			materials_total_quantity_s.add(materials_total_quantity);
			materials_etc_s.add(materials_etc);	
		}	
		
		response.sendRedirect("menu1by7.jsp"); // 모아보기로 이동
	}
}