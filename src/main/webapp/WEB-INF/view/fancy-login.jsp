 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>		<!-- JSTl potrzebne do sprawdzenia bledu-->
<!doctype html>
<html lang="en">

<head>
	
	<title>Login Page</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<!-- Reference Bootstrap files -->
	<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>

<body>

	<div>
		
		<div id="loginbox" style="margin-top: 50px;" class="mainbox col-md-3 col-md-offset-2 col-sm-6 col-sm-offset-2">
			
			<div class="panel panel-info">

				<div class="panel-heading">
					<div class="panel-title">Sign In</div>
				</div>

				<div style="padding-top: 30px" class="panel-body">

					<!-- Login Form -->
					<form action="${pageContext.request.contextPath}/authenticateTheUser" method="POST" class="form-horizontal">

					    <!-- Place for messages: error, alert etc ... -->
					    <div class="form-group">
					        <div class="col-xs-15">
					            <div>
							<!-- Check for login error -->		
						<c:if test="${param.error != null}"> <!--  tworze test czy parametr podany nie zawiera pola lub nie udalo sie zalogowac. Czy powstal blad. Jesli jest blad wyswietl error mesage.  -->	
									            
									<div class="alert alert-danger col-xs-offset-1 col-xs-10">
										Nieprawidlowa nazwa uzytkownika lub haslo
									</div>
						</c:if>			
							
							
							
						<c:if test="${param.logout != null}">	<!-- tutaj przeslany zostanie parametr do psrawdzenia o tresci /.../showMyLoginPage?logout i pod tym katem zostanie sprawdzony parametr logowania -->	
									<!-- Checking for logout -->	            
									<div class="alert alert-success col-xs-offset-1 col-xs-10">
										Zostales wylogowany
									</div>
						</c:if>			  

					            </div>
					        </div>
					    </div>

						<!-- User name -->
						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> 
							
							<input type="text" name="username" placeholder="username" class="form-control"> <!-- ZWYKLY USERNAME -->
						</div>

						<!-- Password -->
						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span> 
							
							<input type="password" name="password" placeholder="password" class="form-control" ><!-- ZWYKLY PASSWORD -->
						</div>

						<!-- Login/Submit Button -->
						<div style="margin-top: 10px" class="form-group">						
							<div class="col-sm-6 controls">
								<button type="submit" class="btn btn-success">Login</button>
							</div>
						</div>
							
							 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
					</form>
	
				</div>

			</div>

		</div>

	</div>

</body>
</html>