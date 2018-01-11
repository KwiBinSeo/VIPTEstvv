<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.cglab.smartplace.AllData" %> <!-- 사용자가 입력하는 모든 데이터들을 저장할 객체 import -->

 <%
	// 더미 데이터를 이용한 자재 투입 현황 설계
	request.setCharacterEncoding("UTF-8");
	
	// Session 객체에 저장 되어 있는 User_ID 및 User_PW 받기
	HttpSession session = request.getSession(false);
	String User_ID = "master";//(String) session.getAttribute("User_ID");
	String User_PW = "master";//(String) session.getAttribute("User_PW");
	String User_AREA = "경기도 화성시"; // (String) session.getAttribute("User_AREA");
 	// 서버 날짜를 저장하는 부분
	GregorianCalendar calendar = new GregorianCalendar();
	
	String[] weekDay = {"일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"};
	calendar.add(Calendar.DATE, 0); // 금일 날짜 가져오기
 	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH) + 1;
	int date = calendar.get(Calendar.DATE);
	int num = calendar.get(Calendar.DAY_OF_WEEK);
	
	// DB연결 부분
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
	
	String[] materials; // 자재명 저장
	String[] materials_number; // 자재 번호 저장
	String[] total; // 자재 별 전체 설계량 저장
	String[] base_quantity; // 기반 입량 저장
	String[] input_quantity; // 반입량 저장
	String[] total_quantity; // 반입 누계 저장
	String[] etc; // 비고 저장
	String[] type; // 관급 또는 사급인지 저장
	String m_type = "관급";
	// Database연결 부분
	// 현재 데이터베이스에 얼마만큼의 데이터가 저장되어 있는지 count하는 부분
 	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(URL, DB_NAME, DB_PW);
		stmt = conn.createStatement(); // 상태 확인
		query = "select * from materials_list where id='"+User_ID+"' And type='"+m_type+"'"; // construction_list 테이블에서 User_ID와 같은 속성의 데이터를 가져옴
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
	
	int materials_list_count_k = count; // materials_list_count 변수 값을 count로 초기화
	// 세션 데이터 저장
	try {
		session.setAttribute("materials_list_count_k", materials_list_count_k); // materials_list_count_k 세션 객체 생성
	} catch (Exception e) {
		
	}
	
 	materials = new String[count]; // 자재명을 저장할 배열 생성
 	materials_number = new String[count]; // 자재 번호를 저장할 배열 생성
 	total = new String[count]; // 자재 별 전체 설계량 저장할 배열 생성
 	base_quantity = new String[count]; // 기반 입량을 저장할 배열 생성
 	input_quantity = new String[count]; // 반입량을 저장할 배열 생성
 	total_quantity = new String[count]; // 반입 누계 저장 배열 생성
 	etc = new String[count]; // 비고 저장 배열 생성
 	type = new String[count]; // 관급 또는 사급인지 저장 배열 생성
	
	// 생성된 rsarray 배열에 데이터를 저장하는 부분
	try {
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(URL, DB_NAME, DB_PW);
		stmt = conn.createStatement(); // 상태 확인
		query = "select * from materials_list where id='"+User_ID+"' And type='"+m_type+"'"; // construction_list 테이블에서 User_ID와 같은 속성의 데이터를 가져옴
		rs = stmt.executeQuery(query); // 쿼리문 실행
		// 실제 데이터를 rsarray 배열에 삽입
		while(rs.next()) {
			materials[i] = rs.getString("materials");
			materials_number[i] = rs.getString("materials_number");
			total[i] = rs.getString("total");
			base_quantity[i] = rs.getString("base_quantity");
			input_quantity[i] = rs.getString("input_quantity");
			total_quantity[i] = rs.getString("total_quantity");
			etc[i] = rs.getString("etc");
			type[i] = rs.getString("type");
			//System.out.println("배열 값 : "+ construction[i]);
			i++;
		}
	} catch (SQLException se) {
		se.printStackTrace();
	} catch (ClassNotFoundException cnfe) {
		cnfe.printStackTrace();
	}
 	
 	// 세션 데이터 받기
	ArrayList<String> materials_k = (ArrayList) session.getAttribute("materials_k");
	ArrayList<String> materials_type_k = (ArrayList) session.getAttribute("materials_type_k");
	ArrayList<String> materials_total_k = (ArrayList) session.getAttribute("materials_total_k");
	ArrayList<String> materials_base_quantity_k = (ArrayList) session.getAttribute("materials_base_quantity_k");
	ArrayList<String> materials_input_quantity_k = (ArrayList) session.getAttribute("materials_input_quantity_k");
	ArrayList<String> materials_total_quantity_k = (ArrayList) session.getAttribute("materials_total_quantity_k");
	ArrayList<String> materials_etc_k = (ArrayList) session.getAttribute("materials_etc_k");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>건설현장관리플랫폼 | 자재투입현황</title>
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
            				<a href="#" class="dropdown-toggle" data-toggle="dropdown">
              					<i class="fa fa-user" class="user-image" alt="User Image"></i>
             	 				<span class="hidden-xs"><%=User_ID %></span>
             	 				<%// System.out.println("세션 아이디: "+id); %>
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
				<!-- sidebar menu: : style can be found in sidebar.less -->
      			<ul class="sidebar-menu" data-widget="tree">
        			<li class="header">MENU</li>
        			<li class="active treeview">
          				<a href="#">
            				<i class="fa fa-book"></i> <span>일일&nbsp;작업&nbsp;일보</span>
            				<span class="pull-right-container">
              					<i class="fa fa-angle-left pull-right"></i>
            				</span>
          				</a>
          				<ul class="treeview-menu">
            				<li><a href="/smartplace/menu1by1.jsp"><i class="fa fa-circle-o"></i>작업&nbsp;사항</a></li>            
							<li><a href="/smartplace/menu1by2.jsp"><i class="fa fa-circle-o"></i>공종&nbsp;작업&nbsp;현황</a></li>  
							<li><a href="/smartplace/menu1by3.jsp"><i class="fa fa-circle-o"></i>인원&nbsp;현황</a></li>
							<li><a href="/smartplace/menu1by4.jsp"><i class="fa fa-circle-o"></i>장비&nbsp;투입&nbsp;현황</a></li>
							<li class="active"><a href="/smartplace/menu1by5.jsp"><i class="fa fa-circle-o"></i>자재&nbsp;투입&nbsp;현황(관급)</a></li>
							<li><a href="/smartplace/menu1by6.jsp"><i class="fa fa-circle-o"></i>자재&nbsp;투입&nbsp;현황(사급)</a></li>
							<li><a href="/smartplace/menu1by7.jsp"><i class="fa fa-circle-o"></i>작업&nbsp;일보&nbsp;모아&nbsp;보기</a></li>
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
	      		<h1> 자재 투입 현황(관급)<small>Material input status</small></h1>
	      		<ol class="breadcrumb">
	        		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        		<li class="active">Material input status</li>
	      		</ol>
    		</section>

			<section class="content">
				<div class="col-md-12">
					<div class="box box-danger">
						<div class="box-body">
							<form id="frm" action="/smartplace/menu1by5Toby6.do" method="POST" >
								<div class = "box-header with-border">
									<h3 class="box-title"> 관급 자재 투입 현황</h3> 
								</div>
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
											<!-- 반입량이 없으면 실행 -->
											<% if(materials_input_quantity_k == null) { 
												for(int index = 0; index < materials_list_count_k; index++) { %>
											<tr>
												<td><center><label style="width:200px" name="<%="materials"+index%>" value="<%=materials[index]%>"><%=materials[index]%></label>
												<input type="hidden" name="<%="materials"+index%>" value="<%=materials[index]%>"></input>
												<td><center><label name="<%="materials_total"+index%>"><%=total[index]%></label>
												<input type="hidden" name="<%="materials_total"+index%>" value="<%=total[index]%>"></input>
												<td><center><input type="text" name="<%="materials_base_quantity"+index%>" value="0"></input></td>
												<td><center><input type="text" name="<%="materials_input_quantity"+index%>" value="0"></input></td>
												<td><center><input type="text" name="<%="materials_total_quantity"+index%>" value="0"></input></td>
												<td><center><input type="text" name="<%="materials_etc"+index%>" value="-"></input></td>
											</tr>
											<% }
											} else { 												
												for(int index = 0; index < materials_list_count_k; index++) { %>
											<tr>
												<td><center><label style="width:200px" name="<%="materials"+index%>" value="<%=materials[index]%>"><%=materials[index]%></label>
												<input type="hidden" name="<%="materials"+index%>" value="<%=materials[index]%>"></input>
												<td><center><label name="<%="materials_total"+index%>" value="<%=total[index]%>"><%=total[index]%></label>
												<input type="hidden" name="<%="materials_total"+index%>" value="<%=total[index]%>"></input>
												<td><center><input type="text" name="<%="materials_base_quantity"+index%>" value="<%=materials_base_quantity_k.get(index)%>"></input></td>
												<td><center><input type="text" name="<%="materials_input_quantity"+index%>" value="<%=materials_input_quantity_k.get(index)%>"></input></td>
												<td><center><input type="text" name="<%="materials_total_quantity"+index%>" value="<%=materials_total_quantity_k.get(index)%>"></input></td>
												<td><center><input type="text" name="<%="materials_etc"+index%>" value="<%=etc[index]%>"></input></td>
											</tr>
											<% }} %>			
										</tbody>
									</table>
								</div>

								<!-- 추가 끝 -->
								<div class="pull-right">
									<input type="submit" value="NEXT" class="btn btn-primary btn-block"></input>
								</div>
							</form>
						</div>
					</div>
				</div>
			</section>	
		</div>
	  
		<!-- footer 메뉴바 -->
		<footer class="main-footer">
	    	<div class="pull-right hidden-xs">
	      		<b>Version</b> 2.4.0
	    	</div>
	    	<strong>Copyright &copy; 2017-2017 <a href="http://cglab.sch.ac.kr/" target="_blank">Maded by CGLAB in Soonchunhyang Univ</a>.</strong> All rights reserved.
	  	</footer>		
	</div>
	<!-- /.content-wrapper -->

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
