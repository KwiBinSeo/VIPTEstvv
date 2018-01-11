<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.cglab.smartplace.AllData" %> <!-- 사용자가 입력하는 모든 데이터들을 저장할 객체 import -->

<!-- 회원이 로그인 되어 있는지 세션 확인 부분 -->
<%
	AllData AD = new AllData();

	// ID 받기
	HttpSession session = request.getSession(false);
	String User_ID = "master";//(String)session.getAttribute("User_ID");
	String User_PW = "master";//(String)session.getAttribute("User_PW");
	
	GregorianCalendar calendar = new GregorianCalendar();
	
	calendar.add(Calendar.DATE, 0); // 금일 날짜 받아오기

	String[] weekDay = {"일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"};
	
	// 날짜 받기
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH) + 1;
	int date = calendar.get(Calendar.DATE);
	int num = calendar.get(Calendar.DAY_OF_WEEK) - 1;
	
	String today = Integer.toString(year) + "년 " + Integer.toString(month) + "월 " + Integer.toString(date) + "일 " + weekDay[num]; // 오늘 날짜
	
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
	String[] rsarray;
	
	// 데이터베이스 카운트 세기 
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(URL, DB_NAME, DB_PW);
		stmt = conn.createStatement(); // 상태 확인
		query = "select * from occupation"; // query문 생성
		rs = stmt.executeQuery(query);
		
		rs.last();
		count = rs.getRow();
		rs.beforeFirst(); // 커서를 원상태로 복구
		
	} catch (SQLException se) {
		se.printStackTrace();
	} catch (ClassNotFoundException cnfe) {
		cnfe.printStackTrace();
	}
	
	rsarray = new String[count]; // 데이터를 저장할 변수 rsarray String 객체 배열 생성
	
	// rsarray[] 배열에 데이터 넣기
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(URL, DB_NAME, DB_PW);
		stmt = conn.createStatement(); // 상태확인
		query = "select * from occupation"; // query문 생성
		rs = stmt.executeQuery(query); // 쿼리문 실행
		
		while(rs.next()) {
			rsarray[i] = rs.getString("occupation"); // 직업 데이터를 rsarray[]에 저장
			//System.out.println("직업  " + i + ": " + rsarray[i]); // 실제 데이터 출력
			i++;
		}
	} catch (SQLException se) {
		se.printStackTrace();
	} catch (ClassNotFoundException cnfe) {
		cnfe.printStackTrace();
	}
	// DB 연결 부분 끝
	
	// 세션 데이터 받기
	int occupation_count = (Integer) session.getAttribute("occupation_count");
	
	ArrayList<String> occupation = (ArrayList) session.getAttribute("occupation"); // 투입 인원 구분
	ArrayList<String> occupation_yesterday = (ArrayList) session.getAttribute("occupation_yesterday"); // 투입 전일 데이터
	ArrayList<String> occupation_today = (ArrayList) session.getAttribute("occupation_today"); // 투입 금일 데이터
	ArrayList<String> occupation_total = (ArrayList) session.getAttribute("occupation_total"); // 투입 누계 데이터
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>건설현장관리플랫폼 | 장비현황</title>
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
	<!-- 테이블 동적할당 부분 추가 -->
	
	<script type="text/javascript">
 	function goPage_Up() {
		// 페이지 이동
		document.addForm.action="Occupation_count.do";
		document.addForm.method="post";
		document.addForm.submit();
 	}
 	
 	function goPage_Down() {
 		if(<%=occupation_count%> <= 1) {
 			alert('1개 아래로 줄일 수 없습니다.');
 		}
 		else {
			// 페이지 이동
			document.subForm.action="Occupation_count2.do";
			document.subForm.method="post";
			document.subForm.submit();
 		}
  	}
	</script>
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
	             	 		<% System.out.println("세션 아이디: "+ User_ID); %>
	            		</a>
	            		<ul class="dropdown-menu">          
		              		<!-- Menu Footer-->
		              		<li class="user-header">
		              			<img src="<c:url value="/resources/css/plugins/img/user.png" />" class="img-circle" alt="User Image">
		              			<p> <%=User_ID %>
		              				<small> 00현장관리자</small>
		              			</p>
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
            			<i class="fa fa-book"></i> <span>일일&nbsp;작업&nbsp;일보</span>
            			<span class="pull-right-container">
              				<i class="fa fa-angle-left pull-right"></i>
            			</span>
          			</a>
          			<ul class="treeview-menu">
            			<li><a href="/smartplace/menu1by1.jsp"><i class="fa fa-circle-o"></i>작업&nbsp;사항</a></li>            
						<li><a href="/smartplace/menu1by2.jsp"><i class="fa fa-circle-o"></i>공종&nbsp;작업&nbsp;현황</a></li>  
						<li class="active"><a href="/smartplace/menu1by3.jsp"><i class="fa fa-circle-o"></i>인원&nbsp;현황</a></li>
						<li><a href="/smartplace/menu1by4.jsp"><i class="fa fa-circle-o"></i>장비&nbsp;투입&nbsp;현황</a></li>
						<li><a href="/smartplace/menu1by5.jsp"><i class="fa fa-circle-o"></i>자재&nbsp;투입&nbsp;현황(관급)</a></li>
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
      		<h1> 인원 현황<small>Personnel status</small></h1>
      		<ol class="breadcrumb">
        		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        		<li class="active">Equipment input status</li>
      		</ol>
    	</section>

		<section class="content">
			<div class="col-md-12">
				<div class="box box-danger">
					<div class = "box-header with-border">
						<h3 class="box-title"> 인원 투입 현황</h3>
					</div>
					<!-- <script type="text/javascript"> -->

					<div class="box-body">
						<div class="col-md-16">			
							<form id="frm" action="/smartplace/menu1by3Toby4.do" method="POST" class="form-group">
								<div class="table-responsive">
		        					<table class="table no-margin text-center">	
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
												<td><center>
													<input type="text" list="countries" name="<%="mat"+personnel_index%>" />
													<datalist id="countries">
														<%for(int index = 0; index < count; index++) {%>
														<option name="<%="mat"+index%>" value="<%=rsarray[index]%>"><%=rsarray[index]%></option>
														<%}%>
													</datalist>
												</center></td>
												<td><center><input type="text" name="<%="yest"+personnel_index%>" width=50></center></input></td>
												<td><center><input type="text" name="<%="today"+personnel_index%>" width=50></center></input></td>
												<td><center><input type="text" name="<%="total"+personnel_index%>" width=50></center></input></td>
											</tr>
											<%}} else { 
											for(int personnel_index = 0; personnel_index < occupation_count; personnel_index++) { %>
											<tr>
												<td><center>
													<input type="text" list="countries" name="<%="mat"+personnel_index%>" value="<%=occupation.get(personnel_index)%>"/>
													<datalist id="countries">
														<%for(int index = 0; index < count; index++) {%>
														<option id="<%="mat"+index%>" value="<%=rsarray[index]%>"><%=rsarray[index]%></option>
														<%}%>
													</datalist>
												</center></td>
												<td><center><input type="text" name="<%="yest"+personnel_index%>" width=50 value="<%=occupation_yesterday.get(personnel_index)%>"></center></input></td>
												<td><center><input type="text" name="<%="today"+personnel_index%>" width=50 value="<%=occupation_today.get(personnel_index)%>"></center></input></td>
												<td><center><input type="text" name="<%="total"+personnel_index%>" width=50 value="<%=occupation_total.get(personnel_index)%>"></center></input></td>
											</tr>
											<% }} %>
										</tbody>
									</table>
								</div>							
								<div class="pull-right">
									<input type="submit" value="NEXT" class="btn btn-primary btn-block "></input>
								</div>
							</form>
							<br>
							<div class = "box-header with-border">
								<div class="pull-right">
									<form name="addForm" id="add" onclick="javascript:goPage_Up()" method="POST" style="float:left; margin: 5px">
										<input type="submit" value="+" class="btn btn-primary btn-block" ></input>
									</form>
									<form name="subForm" id="sub" onclick="javascript:goPage_Down()" method="POST" style="float:left; margin: 5px">
										<input type="submit" value="-" class="btn btn-primary btn-block" ></input>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	
	<footer class="main-footer">
    	<div class="pull-right hidden-xs">
      		<b>Version</b> 2.4.0
    	</div>
    	<strong>Copyright &copy; 2017-2017 <a href="http://cglab.sch.ac.kr/" target="_blank">Maded by CGLAB in Soonchunhyang Univ</a>.</strong> All rights reserved.
  	</footer>
	
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
</div>
</body>
</html>