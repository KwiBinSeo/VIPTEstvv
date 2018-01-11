<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.cglab.smartplace.AllData" %> <!-- 사용자가 입력하는 모든 데이터들을 저장할 객체 import -->

<%
	// AllData 객체 만들기
 	AllData AD = new AllData();
 
	//id 받기
	HttpSession session = request.getSession(false);
	String User_ID = "master";//(String)session.getAttribute("User_ID");
	String User_PW = "master";//(String)session.getAttribute("User_PW");
	
	//서버 날짜 date에 저장
	GregorianCalendar calendar = new GregorianCalendar();
	GregorianCalendar calendar_2 = new GregorianCalendar();

	calendar.add(Calendar.DATE, -1); // 전일 날짜 가져요기
	calendar_2.add(Calendar.DATE, 0); // 금일 날짜 가져오기

	String[] weekDay = {"일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"};

	// 전일 요일 계산하는 부분
	int year_1 = calendar.get(Calendar.YEAR);
	int month_1 = calendar.get(Calendar.MONTH) + 1;
	int date_1 = calendar.get(Calendar.DATE);
	int num_1 = calendar.get(Calendar.DAY_OF_WEEK) - 1;

	// 금일 요일 계산하는 부분
	int year_2 = calendar_2.get(Calendar.YEAR);
	int month_2 = calendar_2.get(Calendar.MONTH) + 1;
	int date_2 = calendar_2.get(Calendar.DATE);
	int num_2 = calendar_2.get(Calendar.DAY_OF_WEEK) - 1;
		
	String yesterday = Integer.toString(year_1) + "년 " + Integer.toString(month_1) + "월 "
			+ Integer.toString(date_1) + "일 " + weekDay[num_1]; // 어제 날짜
	String today = Integer.toString(year_2) + "년 " + Integer.toString(month_2) + "월 " + Integer.toString(date_2)
			+ "일 " + weekDay[num_2]; // 오늘 날짜
%>

<!-- 공종명 불러오는 부분 -->
<%	
//DB연결 부분
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null, rs2 = null;
	String URL = "jdbc:mysql://220.69.209.170/smartplace";
	String DB_NAME = "cglab";
	String DB_PW = "clws";
	String query = "";
	int count = 0;
	int i = 0;
	
	String[] construction; // 공종명 저장
	String[] construction_number; // 공종 번호 저장
	String[] total; // 공종 별 전체 설계랑 저장
	String[] today_result; // 공종 별 오늘 실적 저장
	String[] accumulate; //공종 별 누계량 저장
	
	// Database연결 부분	
	// 공종 작업 현황 데이터 베이스 연결
	// 현재 데이터베이스에 얼마만큼의 데이터가 저장되어 있는지 count하는 부분
 	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(URL, DB_NAME, DB_PW);
		stmt = conn.createStatement(); // 상태 확인
		query = "select * from construction_list where id='"+User_ID+"'"; // construction_list 테이블에서 User_ID와 같은 속성의 데이터를 가져옴
		rs = stmt.executeQuery(query); // 쿼리문 실행
		
		// 회원아이디와 같은 공종 데이터를 전부 가져온다
		while(rs.next()) {
			// 유저아이디와 같은 id를 검색
			count++;
		}
		rs.beforeFirst(); // 커서를 원상태로 복구
	} catch (SQLException se) {
		se.printStackTrace();
	} catch (ClassNotFoundException cnfe) {
		cnfe.printStackTrace();
	}
	
	int construction_list_count = count; // construction_list_count 변수를 count 값으로 초기화
	
 	construction = new String[count]; // 공종명을 저장할 배열 생성
 	construction_number = new String[count]; // 공종 번호를 저장할 배열 생성
 	total = new String[count]; // 공종 별 전체 설계량 저장할 배열 생성
 	today_result = new String[count]; // 공종 별 오늘 실적을 저장할 배열 생성
 	accumulate = new String[count]; // 공종 별 누계랑을 저장할 배열 생성
 	
	// 생성된 rsarray 배열에 데이터를 저장하는 부분
	try {
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(URL, DB_NAME, DB_PW);
		stmt = conn.createStatement(); // 상태 확인
		query = "select * from construction_list where id='"+User_ID+"'"; // construction_list 테이블에서 User_ID와 같은 속성의 데이터를 가져옴
		rs = stmt.executeQuery(query); // 쿼리문 실행
		// 실제 데이터를 rsarray 배열에 삽입
		while(rs.next()) {
			construction[i] = rs.getString("construction");
			construction_number[i] = rs.getString("construction_number");
			total[i] = rs.getString("total");
			today_result[i] = rs.getString("today_result");
			accumulate[i] = rs.getString("accumulate");
			//System.out.println("배열 값 : "+ construction[i]);
			i++;
		}
	} catch (SQLException se) {
		se.printStackTrace();
	} catch (ClassNotFoundException cnfe) {
		cnfe.printStackTrace();
	}
	// DB 연결 부분 끝
	
	// 자재  현황 데이터 베이스 연결 끝
	int material_count = 0;
	int material_i = 0;
	String[] materials; // 자재명 저장
	String[] materials_number; // 자재 번호 저장
	String[] materials_total; // 자재 별 전체 설계량 저장
	String[] base_quantity; // 기반 입량 저장
	String[] input_quantity; // 반입량 저장
	String[] total_quantity; // 반입 누계 저장
	String[] etc; // 비고 저장
	String[] materials_type; // 관급 또는 사급인지 저장
	
	// Database연결 부분
	// 현재 데이터베이스에 얼마만큼의 데이터가 저장되어 있는지 count하는 부분
 	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(URL, DB_NAME, DB_PW);
		stmt = conn.createStatement(); // 상태 확인
		query = "select * from materials_list where id='"+User_ID+"'"; // construction_list 테이블에서 User_ID와 같은 속성의 데이터를 가져옴
		rs = stmt.executeQuery(query); // 쿼리문 실행
		
		// 회원아이디와 같은 공종 데이터를 전부 가져온다
		while(rs.next()) {
			// 유저아이디와 같은 id를 검색
			material_count++;
		}
		rs.beforeFirst(); // 커서를 원상태로 복구
	} catch (SQLException se) {
		se.printStackTrace();
	} catch (ClassNotFoundException cnfe) {
		cnfe.printStackTrace();
	}
	
	int materials_list_count = material_count; // materials_list_count 변수 값을 count로 초기화
	
 	materials = new String[material_count]; // 자재명을 저장할 배열 생성
 	materials_number = new String[material_count]; // 자재 번호를 저장할 배열 생성
 	materials_total = new String[material_count]; // 자재 별 전체 설계량 저장할 배열 생성
 	base_quantity = new String[material_count]; // 기반 입량을 저장할 배열 생성
 	input_quantity = new String[material_count]; // 반입량을 저장할 배열 생성
 	total_quantity = new String[material_count]; // 반입 누계 저장 배열 생성
 	etc = new String[material_count]; // 비고 저장 배열 생성
 	materials_type = new String[material_count]; // 관급 또는 사급인지 저장 배열 생성
	
	// 생성된 rsarray 배열에 데이터를 저장하는 부분
	try {
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(URL, DB_NAME, DB_PW);
		stmt = conn.createStatement(); // 상태 확인
		query = "select * from materials_list where id='"+User_ID+"'"; // construction_list 테이블에서 User_ID와 같은 속성의 데이터를 가져옴
		rs = stmt.executeQuery(query); // 쿼리문 실행
		// 실제 데이터를 rsarray 배열에 삽입
		while(rs.next()) {
			materials[material_i] = rs.getString("materials");
			materials_number[material_i] = rs.getString("materials_number");
			materials_total[material_i] = rs.getString("total");
			base_quantity[material_i] = rs.getString("base_quantity");
			input_quantity[material_i] = rs.getString("input_quantity");
			total_quantity[material_i] = rs.getString("total_quantity");
			etc[material_i] = rs.getString("etc");
			materials_type[material_i] = rs.getString("type");
			//System.out.println("배열 값 : "+ construction[i]);
			material_i++;
		}
	} catch (SQLException se) {
		se.printStackTrace();
	} catch (ClassNotFoundException cnfe) {
		cnfe.printStackTrace();
	}
 	
 	// 세션 관련 데이터 받기 시작
 	// 공종 세션 데이터 받기
 	ArrayList<String> session_today_result = (ArrayList) session.getAttribute("today_result"); // 오늘 공종 실적
	ArrayList<String> session_accumulate = (ArrayList) session.getAttribute("accumulate"); // 누적
	
	// 전일 작업사항 세션 데이터 받기
	String yesterday_issue = (String) session.getAttribute("yesterday_issue"); // 전일 작업 이슈 저장
	String yesterday_date = (String) session.getAttribute("yesterday_date"); // 전일 날짜 세션 저장
	String yesterday_weather = (String) session.getAttribute("yesterday_weather"); // 전일 날씨 세션 저장
	
	// 금일 작업사항 세션 데이터 받기
	String today_issue = (String) session.getAttribute("today_issue"); // 금일 작업 이슈 저장
	//String today_date = (String) session.getAttribute("today_date"); // 금일 날짜 저장
	String today_weather = (String) session.getAttribute("today_weather"); // 금일 날씨 저장
	
	// 인원 투 입 현황 세션 받기
	int occupation_count = (Integer) session.getAttribute("occupation_count"); // 인원 투입 현황 카운트
	ArrayList<String> occupation = (ArrayList) session.getAttribute("occupation"); // 투입 인원 구분
	ArrayList<String> occupation_yesterday = (ArrayList) session.getAttribute("occupation_yesterday"); // 투입 전일 데이터
	ArrayList<String> occupation_today = (ArrayList) session.getAttribute("occupation_today"); // 투입 금일 데이터
	ArrayList<String> occupation_total = (ArrayList) session.getAttribute("occupation_total"); // 투입 누계 데이터
	
	// 장비 현황 세션 받기
	int equipment_count = (Integer) session.getAttribute("equipment_count");
	ArrayList<String> equipment = (ArrayList) session.getAttribute("equipment"); // 장비 명
	ArrayList<String> equipment_yesterday = (ArrayList) session.getAttribute("equipment_yesterday"); // 장비 전일 데이터
	ArrayList<String> equipment_today = (ArrayList) session.getAttribute("equipment_today"); // 장비 금일 데이터
	ArrayList<String> equipment_total = (ArrayList) session.getAttribute("equipment_total"); // 장비 누계 데이터
		
	// 관급 자재 세션 데이터 받기
	int materials_list_count_k = (Integer) session.getAttribute("materials_list_count_k"); // 관급 자재 리스트 카운트
	ArrayList<String> materials_k = (ArrayList) session.getAttribute("materials_k"); // 관급 자재명
	//ArrayList<String> materials_type_k = (ArrayList) session.getAttribute("materials_type_k"); // 관급 자재명
	ArrayList<String> materials_total_k = (ArrayList) session.getAttribute("materials_total_k"); // 관급 자재 설계량
	ArrayList<String> materials_base_quantity_k = (ArrayList) session.getAttribute("materials_base_quantity_k"); // 관급 자재명
	ArrayList<String> materials_input_quantity_k = (ArrayList) session.getAttribute("materials_input_quantity_k"); // 관급 자재 반입량
	ArrayList<String> materials_total_quantity_k = (ArrayList) session.getAttribute("materials_total_quantity_k"); // 관급 자재 반입 누계
	ArrayList<String> materials_etc_k = (ArrayList) session.getAttribute("materials_etc_k"); // 관급 자재 비고
	
 	// 사급 자재 세션 데이터 받기
 	int materials_list_count_s = (Integer) session.getAttribute("materials_list_count_s"); // 사급 자재 리스트 카운트
	ArrayList<String> materials_s = (ArrayList) session.getAttribute("materials_s");
	//ArrayList<String> materials_type_s = (ArrayList) session.getAttribute("materials_type_s");
	ArrayList<String> materials_total_s = (ArrayList) session.getAttribute("materials_total_s");
	ArrayList<String> materials_base_quantity_s = (ArrayList) session.getAttribute("materials_base_quantity_s");
	ArrayList<String> materials_input_quantity_s = (ArrayList) session.getAttribute("materials_input_quantity_s");
	ArrayList<String> materials_total_quantity_s = (ArrayList) session.getAttribute("materials_total_quantity_s");
	ArrayList<String> materials_etc_s = (ArrayList) session.getAttribute("materials_etc_s");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>건설현장관리플랫폼 | 작업사항</title>
	<!-- Tell the browser to be responsive to screen width -->
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	 <!-- Bootstrap 3.3.7 -->
	<link href="<c:url value="/resources/css/bootstrap/css/bootstrap.min.css" />" rel="stylesheet">
	
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
	
	<!-- Ionicons -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
	  
	<!-- Theme style --> 
	<link href="<c:url value="/resources/css/dist/css/AdminLTE.min.css" />" rel="stylesheet">
	  
	<!-- AdminLTE Skins. Choose a skin from the css/skins
	     folder instead of downloading all of them to reduce the load. -->
	<link href="<c:url value="/resources/css/dist/css/skins/_all-skins.min.css" />" rel="stylesheet">
	  
	<!-- Morris chart -->
	<link href="<c:url value="/resources/css/plugins/morris/morris.css" />" rel="stylesheet">
	
	<!-- jvectormap -->
	<link href="<c:url value="/resources/css/plugins/jvectormap/jquery-jvectormap-1.2.2.css" />" rel="stylesheet">
	
	<!-- Date Picker -->
	<link href="<c:url value="/resources/css/plugins/datepicker/datepicker3.css" />" rel="stylesheet">
	
	<!-- Daterange picker -->
	<link href="<c:url value="/resources/css/plugins/daterangepicker/daterangepicker.css" />" rel="stylesheet">
	
	<!-- bootstrap wysihtml5 - text editor -->
	<link href="<c:url value="/resources/css/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />" rel="stylesheet">
	
	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	<!-- Google Font -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
  		<header class="main-header">
    		<!-- Logo -->
    		<a href="#" class="logo">
      			<!-- mini logo for sidebar mini 50x50 pixels -->
      			<span class="logo-mini"><b>관리</b>플랫폼</span>
      			<!-- logo for regular state and mobile devices -->
      			<span class="logo-lg" style="font-size:13pt"><b><i class="fa fa-tasks"></i>&nbsp;&nbsp;건설 현장 관리 플랫폼</b></span>
    		</a>
    		<!-- Header Navbar: style can be found in header.less -->
    		<nav class="navbar navbar-static-top">  
      			<div class="navbar-custom-menu">
        			<ul class="nav navbar-nav">
     	 				<li class="dropdown user user-menu">
            				<a href="/smartplace/LogoutCheck.do" class="dropdown-toggle" data-toggle="dropdown">
              					<i class="fa fa-user" class="user-image" alt="User Image"></i>
             	 				<span class="hidden-xs"><%=User_ID %></span>
             	 				<% System.out.println("세션 아이디: "+ User_ID); %>
            				</a>
            				<ul class="dropdown-menu">          
              					<!-- Menu Footer-->
              					<li class="user-header">
              						<img src="<c:url value="/resources/css/plugins/img/user.png" />" class="img-circle" alt="User Image">
              						<p> <%=User_ID %><small> 00현장관리자</small></p>
              					</li>		
              					<li class="user-footer">
                					<div class="pull-right">
                  						<a href="/test/logout" class="btn btn-default btn-flat">Sign out</a>
               	 					</div>
              					</li>
            				</ul>  
          				</li>
        			</ul>
       			</div>
    		</nav>
  		</header>
  
  		<!-- Left side column. contains the logo and sidebar -->
  		<aside class="main-sidebar">
    		<!-- sidebar: style can be found in sidebar.less -->
    		<section class="sidebar">
      		<!-- /.search form -->
      			<!-- sidebar menu: : style can be found in sidebar.less -->
      			<ul class="sidebar-menu" data-widget="tree">
        			<li class="header">MENU</li>
        			<li class="active treeview">
          				<a href="#">
            				<i class="fa fa-book"></i>
            				<span>일일&nbsp;작업&nbsp;일보</span>
            				<span class="pull-right-container">
              					<i class="fa fa-angle-left pull-right"></i>
            				</span>
          				</a>
          				<ul class="treeview-menu">
				            <li><a href="/smartplace/menu1by1.jsp"><i class="fa fa-circle-o"></i>작업&nbsp;사항</a></li>            
							<li><a href="/smartplace/menu1by2.jsp"><i class="fa fa-circle-o"></i>공종&nbsp;작업&nbsp;현황</a></li>  
							<li><a href="/smartplace/menu1by3.jsp"><i class="fa fa-circle-o"></i>인원&nbsp;현황</a></li>
							<li><a href="/smartplace/menu1by4.jsp"><i class="fa fa-circle-o"></i>장비&nbsp;투입&nbsp;현황</a></li>
							<li><a href="/smartplace/menu1by5.jsp"><i class="fa fa-circle-o"></i>자재&nbsp;투입&nbsp;현황(관급)</a></li>
							<li><a href="/smartplace/menu1by6.jsp"><i class="fa fa-circle-o"></i>자재&nbsp;투입&nbsp;현황(사급)</a></li>
							<li class="active"><a href="#"><i class="fa fa-circle-o"></i>작업&nbsp;일보&nbsp;모아&nbsp;보기</a></li>
							<li><a href="/smartplace/menu1by8.jsp"><i class="fa fa-circle-o"></i>작업&nbsp;일보&nbsp;검색</a></li>
			          	</ul>
        			</li>
	        		<li>
        			<a href="/smartplace/admin0.jsp">
	            			<i class="fa fa-book"></i> <span>관리자&nbsp;페이지&nbsp;</span>
	            			<span class="pull-right-container">
	              				<i class="fa fa-angle-left pull-right"></i>
	            			</span>
	          			</a>
	           			<ul class="treeview-menu">
	            			<li><a href="#"><i class="fa fa-user-md"></i>공사&nbsp;개요</a></li>    
	           			</ul>
	           		</li>
	      		</ul>
	    	</section>
	    	<!-- /.sidebar -->
	  	</aside>
  	
	  	<!-- Content Wrapper. Contains page content -->
	  	<div class="content-wrapper">
	    	<!-- Content Header (Page header) -->
	    	<section class="content-header">
	      		<h1> 작업 일보 모아 보기<small>Total View</small></h1>
	      		<ol class="breadcrumb">
	        		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        		<li class="active">total print</li>
	      		</ol>
	    	</section>
				
			<!-- 오늘의 날씨 -->
			<section class="content">
						
				<form id="frm" action="/smartplace/TotalInsertData.do" method="POST" class="form-group">
					<div class="pull-right">
						<input type="submit" value="NEXT" class="btn btn-primary btn-block "></input>
					</div>
				</form>
				
				<!-- 전일 작업 사항 시작 -->
				<div class="col-md-8 col-md-offset-2">
					<div class=" box box-danger">
						<div class="box-header with-border">
			            	<h3 class="box-title">전일 작업 사항</h3> &nbsp;&nbsp;&nbsp; <small><%=yesterday_date%> </small> 날씨 : <%=yesterday_weather%>	
			            </div>
						<div class="box-body">
							<div class="col-xs-6">
								<% if(yesterday_issue == null) {%>
								<textarea class="textarea" cols="100" rows="10" disabled>전일 예정 사항</textarea>	
								<% } else { %>
								<textarea class="textarea" cols="100" rows="10" disabled><%=yesterday_issue%></textarea>
								<% } %>						
							</div>
						</div>			
					</div>
				</div>
				<!-- 전일 작업 사항 끝 -->

				<!-- 금일 예정 사항 시작 -->			
				<div class="col-md-8 col-md-offset-2">
					<div class=" box box-danger">	
						<div class="box-header with-border">
			            	<h3 class="box-title">금일 예정 사항</h3> &nbsp;&nbsp;&nbsp; <small><%=today%></small> 날씨 : <%=today_weather%>
						</div>
						
				        <div class="box-body">
							<div class="col-xs-6">   
								<% if(today_issue.equals("") || today_issue == null) {%>
								<textarea class="textarea" cols="100" rows="10" disabled>금일 예정 사항 아직 입력 없음</textarea>	
								<% } else { %>
								<div>
								<textarea class="textarea" cols="100" rows="10" disabled><%=today_issue%></textarea>	
								</div>
								<% } %>				
							</div>
						</div>
					</div>
				</div>
				<!-- 금일 예정 사항 끝 -->	 
				
				<!-- 공종 작업 현황 -->
				<div class="col-md-8 col-md-offset-2">
					<div class=" box box-danger">
						<div class="box-header with-border">
			            	<h3 class="box-title">공종 작업 현황</h3>
						</div>
						<div class="col-md-16">
							<form id="frm"   action="#" method="POST" class="form-group">		
							<div  class="table-responsive">			     
					        	<table class="table no-margin text-center">			
									<thead>
										<tr>
											<th><center>공종명</center></th>
											<th><center>설계량</center></th>
											<th><center>실적</center></th>
											<th><center>누계</center></th>
										</tr>
									</thead>
									<tbody>
										<% 
											System.out.println("리스트 카운트 값 : " + construction_list_count); 
											//System.out.println("리스트 값 : " + AD.construction.get(0));
										%>
										<% if(session_today_result == null) {
											for(int index = 0; index < construction_list_count; index++) { %>
											<tr>
												<td><center><label name="<%="con"+index%>" for="<%=construction[index]%>"><%=construction[index]%></label>
												<td><center><label name="<%="tot"+index%>" for="<%=total[index]%>"><%=total[index]%></label></center></td>
												<td><center><label></label></center></td>
												<td><center><label></label></center></td>
											</tr>
										<% }} else { 
											for(int index = 0; index < construction_list_count; index++) { %>
											<tr>
												<td><center><label name="<%="con"+index%>" for="<%=construction[index]%>"><%=construction[index]%></label>
												<td><center><label name="<%="tot"+index%>" for="<%=total[index]%>"><%=total[index]%></label></center></td>
												<td><center><label><%=session_today_result.get(index)%></label></center></td>
												<td><center><label><%=session_accumulate.get(index)%></label></center></td>
											</tr>
										<% }} %>
									</tbody>
								</table>
							</div>
							</form>
						</div>
					</div>	
				</div>
				<!-- 공종 작업 현황 끝 -->
		
				<!-- 인원 현황 -->
				<div class="col-md-8 col-md-offset-2">
					<div class="box box-danger">
						<div class = "box-header with-border">
							<h3 class="box-title"> 인원 투입 현황</h3>
						</div>
						<!-- <script type="text/javascript"> -->
	
						<div class="box-body">    
							<form id="frm" method="POST" name="myForm">
								<div  class="table-responsive">
		        					<table class="table no-margin">			
										<thead>
											<tr>
												<th width=10><center>구분</center></th>
												<th width=10><center>전일</center></th>
												<th width=10><center>금일</center></th>
												<th width=10><center>누계</center></th>
											</tr>
										</thead>
										<tbody>
											<!-- occupation ArrayList가 비어있으면 실행 -->
											<% if(occupation == null) {
											for(int personnel_index = 0; personnel_index < occupation_count; personnel_index++) { %>
											<tr>
												<td><center><label></label></center></td>
												<td><center><label></label></center></td>
												<td><center><label></label></center></td>
												<td><center><label></label></center></td>
											</tr>
											<%}} else { 
											for(int personnel_index = 0; personnel_index < occupation_count; personnel_index++) { %>
											<tr>
												<td><center><label><%=occupation.get(personnel_index)%></label></center></td>
												<td><center><label><%=occupation_yesterday.get(personnel_index)%></label></center></td>
												<td><center><label><%=occupation_today.get(personnel_index)%></label></center></td>
												<td><center><label><%=occupation_total.get(personnel_index)%></label></center></td>
											</tr>
											<% }} %>
										</tbody>
									</table>
								</div>
							</form>
						</div>
					</div>		
				</div>
				<!-- 인원 현황 끝 -->
			
				<!-- 장비 현황 -->
				<div class="col-md-8 col-md-offset-2">
					<div class=" box box-danger">
						<div class="box-header with-border">	
	              			<h3 class="box-title">장비 현황</h3>
						</div>
		        		<div class="col-md-16">
							<form id="frm"   action="#" method="POST" >
								<div  class="table-responsive">
		        					<table class="table no-margin">			
										<thead>
											<tr>
												<th width=10><center>구분</center></th>
												<th width=10><center>전일</center></th>
												<th width=10><center>금일</center></th>
												<th width=10><center>누계</center></th>
											</tr>
										</thead>
										<tbody>
											<!-- equipment ArrayList가 비어있으면 실행 -->
											<% if(equipment == null) {
											for(int equipment_index = 0; equipment_index < equipment_count; equipment_index++) { %>
											<tr>
												<td><center><label></label></center></td>
												<td><center><label></label></center></td>
												<td><center><label></label></center></td>
												<td><center><label></label></center></td>
											</tr>
											<% }} else { 
											for(int equipment_index = 0; equipment_index < equipment_count; equipment_index++) { %>
											<tr>
												<td><center><label><%=equipment.get(equipment_index)%></label></center></td>
												<td><center><label><%=equipment_yesterday.get(equipment_index)%></label></center></td>
												<td><center><label><%=equipment_today.get(equipment_index)%></label></center></td>
												<td><center><label><%=equipment_total.get(equipment_index)%></label></center></td>
											</tr>									
											<% }} %>
										</tbody>
									</table>
								</div>
							</form>
						</div>
					</div>	
				</div>
				<!-- 장비 현황 끝 -->
				
				<!-- 관급 자재 투입 현황 -->
				<div class="col-md-8 col-md-offset-2">
					<div class=" box box-danger">	
						<div class="box-header with-border">
	              			<h3 class="box-title">관급 자재 투입 현황</h3>
						</div>
		        		<div class="box-body">
							<form id="frm"   action="/test/menu1by4" method="POST" >
								<div  class="table-responsive">
									<table class="table no-margin">
										<thead>
											<tr>
												<th><center>자재명</center></th>
												<th><center>설계량</center></th>
												<th><center>기반입량</center></th>
												<th><center>반입량</center></th>
												<th><center>반입누계</center></th>
												<th><center>비고</center></th>		
											</tr>
										</thead>
										<tbody>
											<% if(materials_input_quantity_k == null) {
											for(int index = 0; index < materials_list_count; index++) { 
												if(materials_type[index].equals("관급") || materials_type[index] == "관급") { %>
											<tr>
												<td><center><label></label></center></td>
												<td><center><label></label></center></td>
												<td><center><label></label></center></td> <!--기반입량 -->
												<td><center><label></label></center></td> <!-- 반입량 -->
												<td><center><label></label></center></td> <!-- 반입누계 -->
												<td><center><label></label></center></td> <!-- 비고 -->
											</tr>
											<% } else {}
												}} else { 
											for(int index = 0; index < materials_list_count_k; index++) { %>								
											<tr>
												<td><center><label style="width:200px"><%=materials_k.get(index)%></label> <!-- 자재명 -->
												<td><center><label><%=materials_total_k.get(index)%></label> <!-- 설계량 -->
												<td><center><label><%=materials_base_quantity_k.get(index)%></label></center></td> <!--기반입량 -->
												<td><center><label><%=materials_input_quantity_k.get(index)%></label></center></td> <!-- 반입량 -->
												<td><center><label><%=materials_total_quantity_k.get(index)%></label></center></td> <!-- 반입누계 -->
												<td><center><label><%=materials_etc_k.get(index)%></label></center></td> <!-- 비고 -->
											</tr>
											<% }} %>		
										</tbody>
									</table>
								</div>
							</form>
						</div>
					</div>
				</div>
				<!-- 관급 자재 투입 현황 끝 -->	
			
				<!-- 사급 자재 투입 현황 -->
				<div class="col-md-8 col-md-offset-2">
					<div class=" box box-danger">	
						<div class="box-header with-border">
	              			<h3 class="box-title">사급 자재 투입 현황</h3>
						</div>
		        		<div class="box-body">
							<form id="frm"   action="/test/menu1by4" method="POST" >
								<div class="table-responsive">
									<table class="table no-margin">
										<thead>
											<tr>
												<th><center>자재명</center></th>
												<th><center>설계량</center></th>
												<th><center>기반입량</center></th>
												<th><center>반입량</center></th>
												<th><center>반입누계</center></th>
												<th><center>비고</center></th>		
											</tr>
										</thead>
										<tbody>
											<% if(materials_input_quantity_s == null) {
											for(int index = 0; index < materials_list_count; index++) { 
												if(materials_type[index].equals("사급") || materials_type[index] == "사급") { %>
											<tr>
												<td><center><label></label></center></td>
												<td><center><label></label></center></td>
												<td><center><label></label></center></td> <!--기반입량 -->
												<td><center><label></label></center></td> <!-- 반입량 -->
												<td><center><label></label></center></td> <!-- 반입누계 -->
												<td><center><label></label></center></td> <!-- 비고 -->
											</tr>
											<% } else{}
											}} else { 
											for(int index = 0; index < materials_list_count_s; index++) { %>								
											<tr>
												<td><center><label style="width:200px"><%=materials_s.get(index)%></label> <!-- 자재명 -->
												<td><center><label><%=materials_total_s.get(index)%></label> <!-- 설계량 -->
												<td><center><label><%=materials_base_quantity_s.get(index)%></label></center></td>  <!--기반입량 -->
												<td><center><label><%=materials_input_quantity_s.get(index)%></label></center></td> <!-- 반입량 -->
												<td><center><label><%=materials_total_quantity_s.get(index)%></label></center></td> <!-- 반입누계 -->
												<td><center><label><%=materials_etc_s.get(index)%></label></center></td>            <!-- 비고 -->
											</tr>
											<% }} %>
										</tbody>
									</table>
								</div>
							</form>
						</div>	
					</div>		
				</div>
				<!-- 사급 자재 투입 현황 끝 -->	
			</section>
			<!-- Add the sidebar's background. This div must be placed
			     immediately after the control sidebar -->
			<div class="control-sidebar-bg"></div>
		</div>
			
		<!-- footer 메뉴바 -->
		<footer class="main-footer">
	    	<div class="pull-right hidden-xs">
	      		<b>Version</b> 2.4.0
	    	</div>
	    	<strong>Copyright &copy; 2017-2017 <a href="http://cglab.sch.ac.kr/" target="_blank">Maded by CGLAB in Soonchunhyang Univ</a>.</strong> All rights reserved.
	  	</footer>	
	</div>
	<!-- ./wrapper -->

	<!-- jQuery 3.1.1 -->
	<script src="css/plugins/jQuery/jquery-3.1.1.min.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
	  $.widget.bridge('uibutton', $.ui.button);
	</script>
	
	<!-- Bootstrap 3.3.7 -->
	<script src="resources/css/bootstrap/js/bootstrap.min.js"></script>
	
	<!-- Morris.js charts -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
	<script src="<c:url value="/resources/css/plugins/morris/morris.min.js" />"></script>
	
	<!-- Sparkline -->
	<script src="<c:url value="/resources/css/plugins/sparkline/jquery.sparkline.min.js" />"></script>
	
	<!-- jvectormap -->
	<script src="<c:url value="/resources/css/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" />"></script>
	
	<!-- jQuery Knob Chart -->
	<script src="<c:url value="/resources/css/plugins/knob/jquery.knob.js" />"></script>
	
	<!-- daterangepicker -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
	<script src="<c:url value="/resources/css/plugins/daterangepicker/daterangepicker.js" />"></script>
	
	<!-- datepicker -->
	<script src="<c:url value="/resources/css/plugins/datepicker/bootstrap-datepicker.js" />"></script>
	
	<!-- Bootstrap WYSIHTML5 -->
	<script src="<c:url value="/resources/css/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" />"></script>
	
	
	<!-- Slimscroll -->
	<script src="<c:url value="/resources/css/plugins/slimScroll/jquery.slimscroll.min.js" />"></script>
	
	<!-- FastClick -->
	<script src="<c:url value="/resources/css/plugins/fastclick/fastclick.js" />"></script>
	
	<!-- AdminLTE App -->
	<script src="<c:url value="/resources/css/dist/js/adminlte.min.js" />"></script>
	
	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
	<script src="<c:url value="/resources/css/dist/js/pages/dashboard.js" />"></script>
	
	<!-- AdminLTE for demo purposes -->
	<script src="<c:url value="/resources/css/dist/js/demo.js" />"></script>

</body>
</html>
