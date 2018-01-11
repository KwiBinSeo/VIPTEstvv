<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

<%
	HttpSession session = request.getSession(false);
	String start_date = "기본값";
	String end_date = "기본값";

	// 공종 데이터 받기
	ArrayList<String> session_construction = new ArrayList<String>();
	ArrayList<String> session_construction_total = new ArrayList<String>();
	ArrayList<String> session_construction_today = new ArrayList<String>();
	
	// 관급 자재 데이터 받기
	ArrayList<String> session_materials_k = new ArrayList<String>();
	ArrayList<String> session_materials_k_input_quantity = new ArrayList<String>();
	ArrayList<String> session_materials_k_total = new ArrayList<String>();
	
	// 사급 자재 데이터 받기
	ArrayList<String> session_materials_s = new ArrayList<String>();
	ArrayList<String> session_materials_s_input_quantity = new ArrayList<String>();
	ArrayList<String> session_materials_s_total = new ArrayList<String>();
	
	try {
		start_date = (String) session.getAttribute("start_date");
		end_date = (String) session.getAttribute("end_date");
		// 세션 데이터 받기
		// 공종 자재 데이터
		session_construction = (ArrayList) session.getAttribute("session_construction");
		session_construction_total = (ArrayList) session.getAttribute("session_construction_total");
		session_construction_today = (ArrayList) session.getAttribute("session_construction_today");
		
		// 관급 자재 데이터
		session_materials_k = (ArrayList) session.getAttribute("session_materials_k");
		session_materials_k_input_quantity = (ArrayList) session.getAttribute("session_materials_k_input_quantity");
		session_materials_k_total = (ArrayList) session.getAttribute("session_materials_k_total");
		
		// 사급 자재 데이터
		session_materials_s= (ArrayList) session.getAttribute("session_materials_s");
		session_materials_s_input_quantity = (ArrayList) session.getAttribute("session_materials_s_input_quantity");
		session_materials_s_total = (ArrayList) session.getAttribute("session_materials_s_total");
		
	} catch(Exception e) {
		start_date = "세션이 비어있음";
		end_date = "세션이 비어있음";
	}
	
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
	
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data1 = google.visualization.arrayToDataTable([
          ['단위 : %', '진행률'],['2014', 1000],['2015', 1170],['2017', 1030]
        ]);

        var data = google.visualization.arrayToDataTable([
            ['공종 현황', '설계량', '진행'],
           	<% for(int i = 0; i < session_construction.size(); i++) { 
               if(i == session_construction.size()-1) { %>
               	['<%=session_construction.get(i)%>', '<%=session_construction_total.get(i)%>', '<%=session_construction_today.get(i)%>']
               <% } else { %>
           		['<%=session_construction.get(i)%>', '<%=session_construction_total.get(i)%>', '<%=session_construction_today.get(i)%>'],
               <% }} %>
              ]);
            
        var options = {
          chart: {
            title: '공종 진행률',
            subtitle: '<%=start_date%> ~ <%=end_date%> 까지 공종 현황',
          }
        };

        var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
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
             	 				<span class="hidden-xs"><%="User_ID" %></span>
             	 				<% System.out.println("세션 아이디: "+ "User_ID"); %>
            				</a>
            				<ul class="dropdown-menu">          
              					<!-- Menu Footer-->
              					<li class="user-header">
              						<img src="<c:url value="/resources/css/plugins/img/user.png" />" class="img-circle" alt="User Image">
              						<p> <%="User_ID" %><small> 00현장관리자</small></p>
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
							<li><a href="#"><i class="fa fa-circle-o"></i>작업&nbsp;일보&nbsp;모아&nbsp;보기</a></li>
							<li class="active"><a href="/smartplace/menu1by8.jsp"><i class="fa fa-circle-o"></i>작업&nbsp;일보&nbsp;검색</a></li>
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
	      		<h1> 작업 일보 검색<small>Search Total View</small></h1>
	      		<ol class="breadcrumb">
	        		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        		<li class="active">total print</li>
	      		</ol>
	    	</section>
			
			<section class="content">
				<form action="/smartplace/ReportSearchController.do" method="post">
					<div class="col-md-8 col-md-offset-2">
						<div class=" box box-danger">
							<div class="box-header with-border">
								<i class="fa fa-warning"></i>
								<h3 class="box-title">날짜 선택</h3>
								&nbsp;&nbsp;&nbsp; <small><%="Check Date"%> </small>
								<div class="pull-right">
									<input type="submit" value="Search" class="btn btn-primary btn-block"></input>
								</div>
							</div>
							
							<div class="box-header with-border">	
								<div class="pull-left">
									<label>시작 날짜 : </label>
									<input type="date" name="start_date" min="2001-01-01" max="2199-12-31" step="1" value="<%=start_date%>">
								</div>
							</div>
							<div class="box-header with-border">	
								<div class="pull-left">
									<label>종료 날짜 : </label>
									<input type="date" name="end_date" min="2001-01-01" max="2199-12-31" step="1" value="<%=end_date%>">
								</div>
							</div>	
						</div>
					</div>
				</form>
				
	

				<!-- 공종 작업 현황 -->
				<div class="col-md-8 col-md-offset-2">
					<div class="box box-danger">
						<div class="box-body">
							<div class = "box-header with-border">
								<h3 class="box-title"> 공종 작업 현황</h3> 
							</div>
							<table class="table no-margin">
								<thead>
									<tr>
										<th><center>공종명</center></th>
										<th><center>설계량</center></th>
										<th><center>누계</center></th>
									</tr>
								</thead>
								<tbody>
									<%if(session_construction == null) { %>
									<tr>
										<td><center><label></label></td>
										<td><center><label></label></td>
										<td><center><label></label></td>	
									</tr>
									<% } else { 
									for(int i = 0; i < session_construction.size(); i++) { %>
									<tr>
										<td><center><label><%=session_construction.get(i)%></label></td>
										<td><center><label><%=session_construction_total.get(i) %></label></td>
										<td><center><label><%=session_construction_today.get(i) %></label></td>
									</tr>
									<% }} %>
								</tbody>
							</table>
						</div>
					</div>
				</div>
								
				<!-- 관급 자재 -->
				<div class="col-md-8 col-md-offset-2">
					<div class="box box-danger">
						<div class="box-body">
							<div class = "box-header with-border">
								<h3 class="box-title"> 관급 자재 투입 현황</h3> 
							</div>
							<table class="table no-margin">
								<thead>
									<tr>
										<th><center>자재명</center></th>
										<th><center>설계량</center></th>
										<th><center>반입누계</center></th>
										<th><center>비고</center></th>
									</tr>
								</thead>
								<tbody>
									<%if(session_materials_k == null) { %>
									<tr>
										<td><center><label></label></td>
										<td><center><label></label></td>
										<td><center><label></label></td>
										<td><center><label></label></td>		
									</tr>
									<% } else {
									for(int i = 0; i < session_materials_k.size(); i++) {%>
									<tr>
										<td><center><label><%=session_materials_k.get(i)%></label></td>
										<td><center><label><%=session_materials_k_total.get(i)%></label></td>
										<td><center><label><%=session_materials_k_input_quantity.get(i)%></label></td>
										<td><center><label></label></td>		
									</tr>
									<% }} %>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				<!-- 사급 자재 -->
				<div class="col-md-8 col-md-offset-2">
					<div class="box box-danger">
						<div class="box-body">
							<div class = "box-header with-border">
								<h3 class="box-title"> 사급 자재 투입 현황</h3> 
							</div>
							<table class="table no-margin">
								<thead>
									<tr>
										<th><center>자재명</center></th>
										<th><center>설계량</center></th>
										<th><center>반입누계</center></th>
										<th><center>비고</center></th>
									</tr>
								</thead>
								<tbody>
									<%if(session_materials_s == null) { %>
									<tr>
										<td><center><label></label></td>
										<td><center><label></label></td>
										<td><center><label></label></td>
										<td><center><label></label></td>		
									</tr>
									<% } else {
									for(int i = 0; i < session_materials_s.size(); i++) {%>
									<tr>
										<td><center><label><%=session_materials_s.get(i)%></label></td>
										<td><center><label><%=session_materials_s_total.get(i)%></label></td>
										<td><center><label><%=session_materials_s_input_quantity.get(i)%></label></td>
										<td><center><label></label></td>		
									</tr>
									<% }} %>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				<div class="col-md-8 col-md-offset-2">
					<div class="box box-danger">
						<div class="box-body">
							<div id="columnchart_material" style="width: 800px; height: 500px;"></div>	
						</div>
					</div>
				</div>	
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
