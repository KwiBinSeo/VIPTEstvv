<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

<%
	// ������� �α��� ���� ��������
	String User_ID = "";
	String User_PW = "";
	boolean Login_Check = true;
	
	try {
		User_ID = (String)session.getAttribute("User_ID"); // session ��ü���� User_ID���� �����´�.
		User_PW = (String)session.getAttribute("User_PW"); // session ��ü���� User_PW���� �����´�.
		
		if(User_ID == null || User_ID.equals("")) {
			Login_Check = false; // ���̵�� ��й�ȣ�� ������ ����Ǿ� ������ ����
		}
		else {
			Login_Check = true; // ���̵�� ��й�ȣ�� ������ ����Ǿ� ������ ����
		}
	} catch (Exception e) {
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>  
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>ȭ�����հǼ�(��) | Login</title>
	<!-- Tell the browser to be responsive to screen width -->
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<!-- Bootstrap 3.3.7 -->
	<link rel="stylesheet" href="resources/css/bootstrap/css/bootstrap.min.css">
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
	<!-- Ionicons -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="resources/css/dist/css/AdminLTE.min.css">
	<!-- iCheck -->
	<link rel="stylesheet" href="resources/css/plugins/iCheck/square/blue.css">

	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	<!-- Google Font -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
	
	<!-- jQuery 3.1.1 -->
	<script src="../../plugins/jQuery/jquery-3.1.1.min.js"></script>
	<!-- Bootstrap 3.3.7 -->
	<script src="../../bootstrap/js/bootstrap.min.js"></script>
	<!-- iCheck -->
	<script src="../../plugins/iCheck/icheck.min.js"></script>
	<script>
	$(function () {
	  $('input').iCheck({
	    checkboxClass: 'icheckbox_square-blue',
	    radioClass: 'iradio_square-blue',
	    increaseArea: '20%' // optional
	  });
	});
	</script>
</head>

<body class="hold-transition login-page">
	<div class="login-box">
		<!-- ȭ�����հǼ� �ΰ� -->
		<div class="login-logo">
			<a href="/test"><font size="5"><b>ȭ�����հǼ�(��)</b> �����۾��Ϻ�</font></a>
		</div>
	
		<!-- /.login-logo -->
		<div class="login-box-body"  >
 			<form action="LoginCheck.do"  method="post">
				<p class="login-box-msg">Sign in to start your session</p>
				<!-- ���̵� �Է� �κ� -->
				<div class="form-group has-feedback">
      				<input name="User_ID" type="text" class="form-control" placeholder="���̵�">
      				<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
   				</div>
   				<!-- ��й�ȣ �Է� �κ� -->
    			<div class="form-group has-feedback">
      				<input name="User_PW" type="password" class="form-control" placeholder="��й�ȣ">
					<span class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
				<div class="row">
					<form id="Login" action="#" method="post">-
						<div class="col-xs-8">
							<div class="checkbox icheck">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<label><input type="checkbox"> Remember Me</label>
  							</div>
						</div>
						<!-- /.col -->   
    					<input type="submit" value="LOGIN" class="btn btn-primary btn-block btn-flat"></input>
					</form>
				</div>	
			</form>
		</div>
	</div>
	<!-- /.login-box-body -->
</body>
</html>
