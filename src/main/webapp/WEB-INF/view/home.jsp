 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>	<!-- JSTl potrzebne do sprawdzenia bledu-->
 <%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
 <%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %> <!-- uri do uzywwania spring security tags  -->
<html>

<head>
	<title> Company Home Page</title>
</head>

<body>
	<h2> Company Home Page</h2>
	<hr>
	
	Welcome to  company home page! yeehaasdas
	<hr>
	<!--  pokaz nazwe usera oraz role -->
		User: <security:authentication property="principal.username" />	<!--  to beedzie user ID , dla uzytkownika ktory jest wlasnie zalogowany  -->
		<br><br>
		Role(s): <security:authentication property="principal.authorities"/>	<!--authorities   to bedzie rola   -->
	
	<security:authorize access="hasRole('MANAGER')">				<!--  pokaz te sekcje tylko wylacznie dla managerow -->
	<hr>
		<p>
			<a href="${pageContext.request.contextPath}/leaders">LeaderShip Meeting</a>	<!-- teraz ustawiam strone/kontekst widoczna tylko dla managerow -->
			(Only for Manager peeps)
		</p>
	
		</security:authorize>
	
		<security:authorize access="hasRole('ADMIN')">	<!--  pokaz te sekcje tylko wylacznie dla adminow -->

	<p>
		<a href="${pageContext.request.contextPath}/systems">IT Systems Meeting</a>				<!-- Add a link to point to /systems ... this is for the admins -->
		(Only for Admin peeps)
	</p>
		</security:authorize>
		<hr>
	
		<form:form action="${pageContext.request.contextPath}/logout" method="POST"> <!-- form provides automatic support for seuciry def -->
		
		<input type="submit" value="Logout" />
		</form:form>
</body>

</html>