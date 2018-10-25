<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>	<!-- JSTl potrzebne do sprawdzenia bledu-->
  <%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Custom Login Page</title>
<style>
		.failed	{
		color: red;
	}
</style>

</head>
<body>
<h3>My Custom Login Page</h3>
	<form:form action="${pageContext.request.contextPath}/authenticateTheUser" method="POST"> 
		<c:if test="${param.error != null}"> <!--  tworze test czy parametr podany nie zawiera pola lub nie udalo sie zalogowac. To jest parametr porownywany z http://.../showMyLoginPage?login   lub ?logout . Spring , przymnie ten parametr do paramteru ze strony z logowaniem  i sprawdzi czy user wylogowal  sie czy tam zalogowal sie -->
		<i class="failed">Sorry! Wpisales zlego uzytkownika lub haslo</i>	
		</c:if>
		<p>
			User name: <input type="text" name="username"/> <!-- Spring Security poszuka tych zmiennych username oraz password -->
		</p>
		
		<p>
			User name: <input type="password" name="password"/>
		</p>
		<input type="submit" value="Login"/>
	</form:form>
</body>
</html>

<!--  TO protect against CSRF czylii Crrss Site Request Forgery attacks trzeba przylaczyc dodatkowa autentykacje do formy ktora probuje oszukac inna przegladarka . Probouje wywolwac twoja form:action Token pozwoli zweryfikowac kto jest uzytkownikiem i co klika i gzie. 
Domyslnie w Springu CSRF jest ustawiony i dziala , uzywa Synchronizer Token Pattern, kazy request posiada session cookie oraz token . Zanim dojdzie do przetwarzania aplikacji  spring sprawdzi twoj token . Wszystko to dzieki filtrom spring securit
tag form:form automatycznie dodaje CSRF autentykacje oraz submission , uzywac POST trzeba dla bezpieczenstwa
-->