<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>

<%
	//서버 날짜 date에 저장
GregorianCalendar calendar = new GregorianCalendar();

int year = calendar.get(Calendar.YEAR);
int month = calendar.get(Calendar.MONTH)+1;
int dat = calendar.get(Calendar.DATE);

String date = Integer.toString(year) +"-"+Integer.toString(month)+"-"+Integer.toString(dat);

	//id 받기
HttpSession session = request.getSession(false);
String id = (String)session.getAttribute("id");
%>


<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>건설현장관리플랫폼 | 공사개요</title>
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
			<a href="home.jsp" class="logo">
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
								<span class="hidden-xs"><%=id %></span>
								<% System.out.println("세션 아이디: "+id); %>
							</a>
							<ul class="dropdown-menu">          
								<!-- Menu Footer-->
								<li class="user-header">
									<img src="<c:url value="/resources/css/plugins/img/user.png" />" class="img-circle" alt="User Image">
									<p> <%=id %>
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
					<li>
						<a href="/smartppace/menu1by1.jsp">
							<i class="fa fa-book"></i> <span>일일&nbsp;작업&nbsp;일보</span>
							<span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="/test/menu1by1"><i class="fa fa-circle-o"></i>작업&nbsp;사항</a></li>            
							<li><a href="/test/menu1by2"><i class="fa fa-circle-o"></i>공종&nbsp;작업&nbsp;현황</a></li>  
							<li><a href="/test/menu1by3"><i class="fa fa-circle-o"></i>인원&nbsp;현황</a></li>
							<li><a href="/test/menu1by4"><i class="fa fa-circle-o"></i>장비&nbsp;투입&nbsp;현황</a></li>
							<li><a href="/test/menu1by5"><i class="fa fa-circle-o"></i>자재&nbsp;투입&nbsp;현황</a></li>
							<li><a href="/test/menu1by6"><i class="fa fa-circle-o"></i>작업&nbsp;일보&nbsp;모아&nbsp;보기</a></li>
						</ul>
					</li>
					<li class="active treeview">
						<a href="#">
							<i class="fa fa-user-md"></i> <span>관리자&nbsp;페이지&nbsp;</span>
							<span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="/smartplace/admin0.jsp"><i class="fa fa-circle-o"></i>공사&nbsp;개요</a></li> 
							<li><a href="/smartplace/admin1.jsp"><i class="fa fa-circle-o"></i>계약&nbsp;내용</a></li>
							<li class="active"><a href="#"><i class="fa fa-circle-o"></i>공사진척&nbsp;및&nbsp;공사대금수령사항</a></li> 
							<li><a href="/smartplace/admin3.jsp"><i class="fa fa-circle-o"></i>참여자&nbsp;현황</a></li>    
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
				<h1>공사진척 및 공사대금수령사항</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
					<li class="active">Work issue</li>
				</ol>
			</section>

			
			<section class="content">
				<div class=" box box-danger">
					<div class="box-header with-border">
											
						<h4 class="box-title"><i class="fa fa-check"></i><b>&nbsp;&nbsp;공사 대금 수령 사항</b></h4>
						<div class="pull-right">
							<input type="submit" value="next" class="btn btn-primary btn-block"></input>
						</div>
						
						<table class="table no-margin">
							<tbody>
								
								<tr>
									<th width=200>구분</th>
									<td><input type="text" id="3by1" name="3by1" width=100></td>
								</tr>
								<tr>
									<th width=200>회차</th>
									<td><input type="text" id="3by2" name="3by2" width=100></td>
								</tr>
								<tr>
									<th width=200>수령업체</th>
									<td><input type="text" id="3by3" name="3by3" width=100></td>
								</tr>
								<tr>
									<th width=200>기성검사일</th>
									<td><input type="text" id="3by4" name="3by4" width=100></td>
								</tr>
								<tr>
									<th width=200>기성금액</th>
									<td><input type="text" id="3by5" name="3by5" width=100>원</td>
								</tr>
								<tr>
									<th width=200>(금회)기성율 / (누계)기성율</th>
									<td><input type="text" id="3by6" name="3by6" width=70>%</td>
									<td><input type="text" id="3by7" name="3by7" width=70>%</td>
								</tr>
								<tr>
									<th width=200>선금정산액</th>
									<td><input type="text" id="3by8" name="3by8" width=100>원</td>
								</tr>
								<tr>
									<th width=200>수령금액(현금,어음,기타)</th>
									<td><input type="text" id="3by9" name="3by9" width=70>원</td>
									<td><input type="text" id="3by10" name="3by10" width=70>원</td>
									<td><input type="text" id="3by11" name="3by11" width=70>원</td>
								</tr>
								<tr>
									<th width=200>수령금액</th>
									<td><input type="text" id="3by12" name="3by12" width=100>원</td>
								</tr>
								<tr>
									<th width=200>잔액</th>
									<td><input type="text" id="3by13" name="3by13" width=100>원</td>
								</tr>
								<tr>
									<th width=200>수령년월일</th>
									<td><input type="text" id="3by14" name="3by14" width=100></td>
								</tr>
							</tbody>
						</table>
						
						
					</div></div>
				</section>
				

				<section class="content">

					<div class=" box box-danger">
						<div class="box-header with-border">
							
							
							<h4 class="box-title"><i class="fa fa-check"></i><b>&nbsp;&nbsp;하도급 대금 지급 사항</b></h4>

							
							<table class="table no-margin">
								<tbody>
									
									<tr>
										<th width=200>구분</th>
										<td><input type="text" id="4by1" name="4by1" width=100></td>
									</tr>
									<tr>
										<th width=200>하도급업체</th>
										<td><input type="text" id="4by2" name="4by2" width=100></td>
									</tr>
									<tr>
										<th width=200>회차</th>
										<td><input type="text" id="4by3" name="4by3" width=100></td>
									</tr>
									<tr>
										<th width=200>기성검사일</th>
										<td><input type="text" id="4by4" name="4by4" width=100></td>
									</tr>
									<tr>
										<th width=200>기성금액</th>
										<td><input type="text" id="4by5" name="4by5" width=100></td>
									</tr>
									<tr>
										<th width=200>지급일</th>
										<td><input type="text" id="4by6" name="4by6" width=100>원</td>
									</tr>
									<tr>
										<th width=200>선금정산액</th>
										<td><input type="text" id="4by7" name="4by7" width=100>원</td>
									</tr>
									<tr>
										<th width=200>수령금액(현금,어음,기타)</th>
										<td><input type="text" id="4by8" name="4by8" width=70>원</td>
										<td><input type="text" id="4by9" name="4by9" width=70>원</td>
										<td><input type="text" id="4by10" name="4by10" width=70>원</td>
									</tr>
									<tr>
										<th width=200>수령금액</th>
										<td><input type="text" id="4by11" name="4by11" width=100>원</td>
									</tr>
									<tr>
										<th width=200>잔액</th>
										<td><input type="text" id="4by12" name="4by12" width=100>원</td>
									</tr>
								</tbody>
							</table>
							
							
						</div></div>
					</section>



					<!-- Control Sidebar -->
					<aside class="control-sidebar control-sidebar-dark">
						<!-- Create the tabs -->
						<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
							<li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
							<li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
						</ul>
						<!-- Tab panes -->
						<div class="tab-content">
							<!-- Home tab content -->
							<div class="tab-pane" id="control-sidebar-home-tab">
								<h3 class="control-sidebar-heading">Recent Activity</h3>
								<ul class="control-sidebar-menu">
									<li>
										<a href="javascript:void(0)">
											<i class="menu-icon fa fa-birthday-cake bg-red"></i>

											<div class="menu-info">
												<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

												<p>Will be 23 on April 24th</p>
											</div>
										</a>
									</li>
									<li>
										<a href="javascript:void(0)">
											<i class="menu-icon fa fa-user bg-yellow"></i>

											<div class="menu-info">
												<h4 class="control-sidebar-subheading">Frodo Updated His Profile</h4>

												<p>New phone +1(800)555-1234</p>
											</div>
										</a>
									</li>
									<li>
										<a href="javascript:void(0)">
											<i class="menu-icon fa fa-envelope-o bg-light-blue"></i>

											<div class="menu-info">
												<h4 class="control-sidebar-subheading">Nora Joined Mailing List</h4>

												<p>nora@example.com</p>
											</div>
										</a>
									</li>
									<li>
										<a href="javascript:void(0)">
											<i class="menu-icon fa fa-file-code-o bg-green"></i>

											<div class="menu-info">
												<h4 class="control-sidebar-subheading">Cron Job 254 Executed</h4>

												<p>Execution time 5 seconds</p>
											</div>
										</a>
									</li>
								</ul>
								<!-- /.control-sidebar-menu -->

								<h3 class="control-sidebar-heading">Tasks Progress</h3>
								<ul class="control-sidebar-menu">
									<li>
										<a href="javascript:void(0)">
											<h4 class="control-sidebar-subheading">
												Custom Template Design
												<span class="label label-danger pull-right">70%</span>
											</h4>

											<div class="progress progress-xxs">
												<div class="progress-bar progress-bar-danger" style="width: 70%"></div>
											</div>
										</a>
									</li>
									<li>
										<a href="javascript:void(0)">
											<h4 class="control-sidebar-subheading">
												Update Resume
												<span class="label label-success pull-right">95%</span>
											</h4>

											<div class="progress progress-xxs">
												<div class="progress-bar progress-bar-success" style="width: 95%"></div>
											</div>
										</a>
									</li>
									<li>
										<a href="javascript:void(0)">
											<h4 class="control-sidebar-subheading">
												Laravel Integration
												<span class="label label-warning pull-right">50%</span>
											</h4>

											<div class="progress progress-xxs">
												<div class="progress-bar progress-bar-warning" style="width: 50%"></div>
											</div>
										</a>
									</li>
									<li>
										<a href="javascript:void(0)">
											<h4 class="control-sidebar-subheading">
												Back End Framework
												<span class="label label-primary pull-right">68%</span>
											</h4>

											<div class="progress progress-xxs">
												<div class="progress-bar progress-bar-primary" style="width: 68%"></div>
											</div>
										</a>
									</li>
								</ul>
								<!-- /.control-sidebar-menu -->

							</div>
							<!-- /.tab-pane -->
							<!-- Stats tab content -->
							<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
							<!-- /.tab-pane -->
							<!-- Settings tab content -->
							<div class="tab-pane" id="control-sidebar-settings-tab">
								<form method="post">
									<h3 class="control-sidebar-heading">General Settings</h3>

									<div class="form-group">
										<label class="control-sidebar-subheading">
											Report panel usage
											<input type="checkbox" class="pull-right" checked>
										</label>

										<p>
											Some information about this general settings option
										</p>
									</div>
									<!-- /.form-group -->

									<div class="form-group">
										<label class="control-sidebar-subheading">
											Allow mail redirect
											<input type="checkbox" class="pull-right" checked>
										</label>

										<p>
											Other sets of options are available
										</p>
									</div>
									<!-- /.form-group -->

									<div class="form-group">
										<label class="control-sidebar-subheading">
											Expose author name in posts
											<input type="checkbox" class="pull-right" checked>
										</label>

										<p>
											Allow the user to show his name in blog posts
										</p>
									</div>
									<!-- /.form-group -->

									<h3 class="control-sidebar-heading">Chat Settings</h3>

									<div class="form-group">
										<label class="control-sidebar-subheading">
											Show me as online
											<input type="checkbox" class="pull-right" checked>
										</label>
									</div>
									<!-- /.form-group -->

									<div class="form-group">
										<label class="control-sidebar-subheading">
											Turn off notifications
											<input type="checkbox" class="pull-right">
										</label>
									</div>
									<!-- /.form-group -->

									<div class="form-group">
										<label class="control-sidebar-subheading">
											Delete chat history
											<a href="javascript:void(0)" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>
										</label>
									</div>
									<!-- /.form-group -->
								</form>
							</div>
							<!-- /.tab-pane -->
						</div>
					</aside>
					<!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
  	immediately after the control sidebar -->
  	<div class="control-sidebar-bg"></div>
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
