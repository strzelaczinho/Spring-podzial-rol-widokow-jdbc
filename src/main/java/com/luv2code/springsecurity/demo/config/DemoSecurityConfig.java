package com.luv2code.springsecurity.demo.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.User.UserBuilder;

@Configuration
@EnableWebSecurity
public class DemoSecurityConfig extends WebSecurityConfigurerAdapter {

	// dodaje referencje dla security data source
	@Autowired
	private DataSource securityDataSource;
	
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {

		// jdbc authentication ... 
		auth.jdbcAuthentication().dataSource(securityDataSource);// teraz uzywam jdbc autoryacji tzn autentykacji . 
		
	}

		@Override	// httppsecurity = configure spring security
		protected void configure(HttpSecurity http) throws Exception { // konfiguruje bezpiecznsto w web paths aplikacji , loginu , logoutu
			
			http.authorizeRequests()	// coonfigures restrict access based on http serwer request 
			.antMatchers("/").hasRole("EMPLOYEE")// kazdy kto jest pracownikiem moze wejsc na glowna strone 
			.antMatchers("/leaders/**").hasRole("MANAGER")	// kazdy kto jest managerem moze korzystac z zasobow /leaders/ i wszystko co jest dalej w hierarchii
			.antMatchers("/systems/**").hasRole("ADMIN")	// kazdy kto jest adminem z systemow i wszystko co jest dalej 
			.and()// oraz
			.formLogin()// customizes login process
			.loginPage("/showMyLoginPage") // pppokaz strone logowania nasza custoom form 
			.loginProcessingUrl("/authenticateTheUser")// To strona submitu // doopiero wtedy login  post data to the url ktora jest lwlasnie przetwarzana (sprawdzi id oraz password)
			.permitAll()// pozwwool wszystkiim na zobacznie strony logowania
			.and()
			.logout()
			.permitAll() // jeszcze dodaje dodatkowo andem mozliwosc wylogowywania(). Domyslnie sesje sa ustawione na 15 minut w springu nie wiem ile bedzie teraz. Trzeba usunac jeszcze sesje i ciasteczka z logowania ... 
			.and()
			.exceptionHandling().accessDeniedPage("/access-denied");
		}
		
}






