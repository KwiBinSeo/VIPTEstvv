package com.cglab.smartplace;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class ReportSearchController
 */
public class ReportSearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	// DB에서 받는 데이터를 저장할 ArrayList
	public ArrayList<String> issue_date = new ArrayList<String>();
	public ArrayList<String> issue_id = new ArrayList<String>();
	
	public ArrayList<String> materials_k = new ArrayList<String>(); // 관급
	public ArrayList<String> materials_k_input_quantity = new ArrayList<String>(); // 관급
	public ArrayList<String> materials_s = new ArrayList<String>(); // 사급
	public ArrayList<String> materials_s_input_quantity = new ArrayList<String>(); // 
	
	public ArrayList<String> materials_k_list = new ArrayList<String>(); // 관급
	public ArrayList<String> materials_s_list = new ArrayList<String>(); // 사급
	public ArrayList<String> cal_materials_k_input_quantity  = new ArrayList<String>();
	public ArrayList<String> materials_k_total  = new ArrayList<String>();
	public ArrayList<String> cal_materials_s_input_quantity  = new ArrayList<String>();
	public ArrayList<String> materials_s_total  = new ArrayList<String>();

	public ArrayList<String> construction  = new ArrayList<String>();
	public ArrayList<String> construction_total  = new ArrayList<String>();
	public ArrayList<String> construction_today  = new ArrayList<String>();
	public ArrayList<String> construction_list  = new ArrayList<String>();
	public ArrayList<String> construction_today_sum  = new ArrayList<String>();
	public ArrayList<String> cal_construction_today_sum  = new ArrayList<String>();
	// 세션을 저장할 ArrayList
	// 세션 공종
	public ArrayList<String> session_construction  = new ArrayList<String>();
	public ArrayList<String> session_construction_total  = new ArrayList<String>();
	public ArrayList<String> session_construction_today  = new ArrayList<String>();
		
	// 세션 관급
	public ArrayList<String> session_materials_k_input_quantity  = new ArrayList<String>();
	public ArrayList<String> session_materials_k  = new ArrayList<String>();
	public ArrayList<String> session_materials_k_total  = new ArrayList<String>();
	
	// 세션 사급
	public ArrayList<String> session_materials_s_input_quantity  = new ArrayList<String>();
	public ArrayList<String> session_materials_s = new ArrayList<String>();
	public ArrayList<String> session_materials_s_total  = new ArrayList<String>();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportSearchController() {
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
		
		// 초기화 부분
		issue_date.clear();
		issue_id.clear();
		materials_k.clear();
		materials_k_input_quantity.clear();
		materials_s.clear();
		materials_s_input_quantity.clear();
		materials_k_list.clear();
		materials_s_list.clear();
		cal_materials_k_input_quantity.clear();
		session_materials_k_input_quantity.clear();
		session_materials_k.clear();
		materials_k_total.clear();
		materials_s_total.clear();
		cal_materials_s_input_quantity.clear();
		session_materials_s_input_quantity.clear();
		session_materials_s.clear();
		session_materials_s_total.clear();
		
		session_construction.clear();
		session_construction_total.clear();
		session_construction_today.clear();
		
		construction.clear();
		construction_total.clear();
		construction_today.clear();
		construction_list.clear();
		construction_today_sum.clear();
		cal_construction_today_sum.clear();
		
		
		HttpSession session = request.getSession(); //세션 객체 생성
		PrintWriter out = response.getWriter();
		
		request.setCharacterEncoding("utf-8"); // request된 데이터 utf-8로 인코딩
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		
		/*
		// 날짜 데이터 스플릿하기
		String[] start_date_split;
		start_date_split = start_date.split("-");
		start_date = start_date_split[0] + "년 " + start_date_split[1] + "월 " + start_date_split[2] + "일";
		
		String[] end_date_split;
		end_date_split = end_date.split("-");
		end_date = end_date_split[0] + "년 " + end_date_split[1] + "월 " + end_date_split[2] + "일";	
		*/
		session.setAttribute("start_date", start_date);
		session.setAttribute("end_date", end_date);
		
		// DB연결 부분
		Connection conn = null;
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null, rs2 = null;
		String URL = "jdbc:mysql://220.69.209.170/smartplace";
		String DB_NAME = "cglab";
		String DB_PW = "clws";
		String query = "";
		String User_ID = "master";
		//start_date="2017-09-28";
		//end_date="2018-11-21";
		// Database연결 부분
		
		// 현재 데이터베이스에 얼마만큼의 데이터가 저장되어 있는지 count하는 부분
	 	try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL, DB_NAME, DB_PW);
			stmt = conn.createStatement(); // 상태 확인
			//query = "select * from workissue where id='"+User_ID+"' and date Between '"+start_date+"' and '"+end_date+"'"; // 
			
			query = "select * from materials_log where id='"+User_ID+"' and date Between '"+start_date+"' and '"+end_date+"'"; // 
			
			rs = stmt.executeQuery(query); // 쿼리문 실행
			
			// start_date와 end_date사이에 있는 데이터를 전부 가져옴
			while(rs.next()) {
				// 관급 사급에 따른 데이터 분류
				if(rs.getString("type").equals("관급")) {
					materials_k.add(rs.getString("materials"));
					materials_k_input_quantity.add(rs.getString("input_quantity"));
				}
				else {
					materials_s.add(rs.getString("materials"));
					materials_s_input_quantity.add(rs.getString("input_quantity"));
				}
			}
			rs.beforeFirst(); // 커서를 원상태로 복구
		} catch (SQLException se) {
			se.printStackTrace();
		} catch (ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		}
	 	
	 	// 등록된 자재 리스트를 검색하는 쿼리문
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL, DB_NAME, DB_PW);
			stmt = conn.createStatement(); // 상태 확인
			//query = "select * from workissue where id='"+User_ID+"' and date Between '"+start_date+"' and '"+end_date+"'"; // 
			
			query = "select * from materials_list where id='"+User_ID+"'"; // 
			
			rs = stmt.executeQuery(query); // 쿼리문 실행
			
			// start_date와 end_date사이에 있는 데이터를 전부 가져옴
			while(rs.next()) {
				// 관급 사급에 따른 데이터 분류
				if(rs.getString("type").equals("관급")) {
					materials_k_list.add(rs.getString("materials"));
					materials_k_total.add(rs.getString("total"));
				}
				else {
					materials_s_list.add(rs.getString("materials"));
					materials_s_total.add(rs.getString("total"));
				}
			}
			rs.beforeFirst(); // 커서를 원상태로 복구
		} catch (SQLException se) {
			se.printStackTrace();
		} catch (ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		}
	 	
	 	// 공종 작업 검색 쿼리문
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL, DB_NAME, DB_PW);
			stmt = conn.createStatement(); // 상태 확인
			//query = "select * from workissue where id='"+User_ID+"' and date Between '"+start_date+"' and '"+end_date+"'"; // 
			
			query = "select * from construction_log where id='"+User_ID+"' and date Between '"+start_date+"' and '"+end_date+"'"; // 
			
			rs = stmt.executeQuery(query); // 쿼리문 실행
			
			// start_date와 end_date사이에 있는 데이터를 전부 가져옴
			while(rs.next()) {
				construction.add(rs.getString("construction"));
				construction_today_sum.add(rs.getString("today_result"));
			}
			rs.beforeFirst(); // 커서를 원상태로 복구
		} catch (SQLException se) {
			se.printStackTrace();
		} catch (ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		}
		
	 	// 등록된 공종 리스트를 검색하는 쿼리문
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL, DB_NAME, DB_PW);
			stmt = conn.createStatement(); // 상태 확인
			//query = "select * from workissue where id='"+User_ID+"' and date Between '"+start_date+"' and '"+end_date+"'"; // 
			
			query = "select * from construction_list where id='"+User_ID+"'"; // 
			
			rs = stmt.executeQuery(query); // 쿼리문 실행
			
			// start_date와 end_date사이에 있는 데이터를 전부 가져옴
			while(rs.next()) {
				construction_list.add(rs.getString("construction"));
				construction_total.add(rs.getString("total"));
			}
			rs.beforeFirst(); // 커서를 원상태로 복구
		} catch (SQLException se) {
			se.printStackTrace();
		} catch (ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		}
		
		// 공종 자자별 총 합 계산
	 	for(int i = 0; i < construction_list.size(); i++) {
	 		int total = 0;
	 		for(int j = 0; j < construction.size(); j++) {
	 			if(construction_list.get(i).equals(construction.get(j))) {
	 				total = total + Integer.parseInt(construction_today_sum.get(j));
	 		 		System.out.println("total : " + total);
	 			}
	 			else {
	 			}
	 			//session_materials_k.add(materials_k_list.get(i)); // 자재 리스트 저장	
	 		}
	 		System.out.println("총 : " + construction.size());
	 		//System.out.println("total : " + total);
	 		cal_construction_today_sum.add(String.valueOf(total)); // 총 양을 저장
	 	}
		
	 	// 관급 자재명 별 총 합 계산
	 	for(int i = 0; i < materials_k_list.size(); i++) {
	 		int total = 0;
	 		for(int j = 0; j < materials_k.size(); j++) {
	 			if(materials_k_list.get(i).equals(materials_k.get(j))) {
	 				total = total + Integer.parseInt(materials_k_input_quantity.get(j));
	 		 		System.out.println("total : " + total);
	 			}
	 			else {
	 			}
	 			//session_materials_k.add(materials_k_list.get(i)); // 자재 리스트 저장	
	 		}
	 		System.out.println("총 : " + materials_k.size());
	 		//System.out.println("total : " + total);
 			cal_materials_k_input_quantity.add(String.valueOf(total)); // 총 양을 저장
	 	}
	 	
	 	// 사급 자재명 별 총 합 계산
	 	for(int i = 0; i < materials_s_list.size(); i++) {
	 		int total = 0;
	 		for(int j = 0; j < materials_s.size(); j++) {
	 			if(materials_s_list.get(i).equals(materials_s.get(j))) {
	 				total = total + Integer.parseInt(materials_s_input_quantity.get(j));
	 		 		System.out.println("total : " + total);
	 			}
	 			else {
	 			}
	 			//session_materials_k.add(materials_k_list.get(i)); // 자재 리스트 저장	
	 		}
	 		System.out.println("총 : " + materials_s.size());
	 		//System.out.println("total : " + total);
 			cal_materials_s_input_quantity.add(String.valueOf(total)); // 총 양을 저장
	 	}
	 	
	 		
	 	//session_issue_date = (ArrayList) session.getAttribute("session_issue_date");
	 	//session_issue_id = (ArrayList) session.getAttribute("session_issue_id");
	 	
	 	// 세션 데이터 넣기
	 	// 공종
	 	session_construction = (ArrayList) session.getAttribute("session_construction");
	 	session_construction_total = (ArrayList) session.getAttribute("session_construction_total");
	 	session_construction_today = (ArrayList) session.getAttribute("session_construction_today");
	 	
	 	// 관급
	 	session_materials_k = (ArrayList) session.getAttribute("session_materials_k");
	 	session_materials_k_input_quantity = (ArrayList) session.getAttribute("session_materials_k_input_quantity");
	 	session_materials_k_total = (ArrayList) session.getAttribute("session_materials_k_total");
	 	
	 	// 사급
	 	session_materials_s = (ArrayList) session.getAttribute("session_materials_s");
	 	session_materials_s_input_quantity = (ArrayList) session.getAttribute("session_materials_s_input_quantity");
	 	session_materials_s_total = (ArrayList) session.getAttribute("session_materials_s_total");
	 	
	 	for(int i = 0; i < construction_list.size(); i++) {

	 		String _construction = construction_list.get(i);
	 		String _construction_total = construction_total.get(i);
	 		String _construction_today = cal_construction_today_sum.get(i);
	 		
			if(session_construction == null)
			{
				session_construction = new ArrayList<String>();
				session.setAttribute("session_construction", session_construction);
			}
			if(session_construction_total == null)
			{
				session_construction_total = new ArrayList<String>();
				session.setAttribute("session_construction_total", session_construction_total);
			}
			if(session_construction_today == null)
			{
				session_construction_today = new ArrayList<String>();
				session.setAttribute("session_construction_today", session_construction_today);
			}
			
			session_construction.add(_construction);
			session_construction_total.add(_construction_total);
			session_construction_today.add(_construction_today);

	 	}
	 	
	 	for(int i = 0; i < materials_k_list.size(); i++) {

	 		String _materials_k = materials_k_list.get(i);
	 		String _materials_k_input_quantity = cal_materials_k_input_quantity.get(i);
	 		String _materials_k_total = materials_k_total.get(i);
	 		
			if(session_materials_k == null)
			{
				session_materials_k = new ArrayList<String>();
				session.setAttribute("session_materials_k", session_materials_k);
			}
			if(session_materials_k_input_quantity == null)
			{
				session_materials_k_input_quantity = new ArrayList<String>();
				session.setAttribute("session_materials_k_input_quantity", session_materials_k_input_quantity);
			}
			if(session_materials_k_total == null)
			{
				session_materials_k_total = new ArrayList<String>();
				session.setAttribute("session_materials_k_total", session_materials_k_total);
			}
			
			session_materials_k.add(_materials_k);
			session_materials_k_input_quantity.add(_materials_k_input_quantity);
			session_materials_k_total.add(_materials_k_total);

	 	}
	 	
	 	for(int i = 0; i < materials_s_list.size(); i++) {

	 		String _materials_s = materials_s_list.get(i);
	 		String _materials_s_input_quantity = cal_materials_s_input_quantity.get(i);
	 		String _materials_s_total = materials_s_total.get(i);

			if(session_materials_s == null)
			{
				session_materials_s = new ArrayList<String>();
				session.setAttribute("session_materials_s", session_materials_s);
			}
			if(session_materials_s_input_quantity == null)
			{
				session_materials_s_input_quantity = new ArrayList<String>();
				session.setAttribute("session_materials_s_input_quantity", session_materials_s_input_quantity);
			}
			if(session_materials_s_total == null)
			{
				session_materials_s_total = new ArrayList<String>();
				session.setAttribute("session_materials_s_total", session_materials_s_total);
			}

			session_materials_s.add(_materials_s);
			session_materials_s_input_quantity.add(_materials_s_input_quantity);
			session_materials_s_total.add(_materials_s_total);
	 	}
	 	session.setAttribute("session_construction",session_construction);
	 	session.setAttribute("session_construction_total",session_construction_total);
	 	session.setAttribute("session_construction_today",session_construction_today);
	 	
	 	session.setAttribute("session_materials_k",session_materials_k);
	 	session.setAttribute("session_materials_k_input_quantity",session_materials_k_input_quantity);
	 	session.setAttribute("session_materials_k_total",session_materials_k_total);
	 	
	 	session.setAttribute("session_materials_s",session_materials_s);
	 	session.setAttribute("session_materials_s_input_quantity",session_materials_s_input_quantity);
	 	session.setAttribute("session_materials_s_total",session_materials_s_total);
	 	
		// 페이지 이동
		response.sendRedirect("menu1by8.jsp");
	}

}
