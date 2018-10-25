package com.luv2code.springsecurity.demo.config;

import java.beans.PropertyVetoException;
import java.util.logging.Logger;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.mchange.v2.c3p0.ComboPooledDataSource;

@Configuration// mowi ze to jest plik konfiguracyjny 
@EnableWebMvc	// <mvc:annotation-driven> support do walidacja , formatowania  ,konwersje , uzwa @Controlerow oraz @RequestMappoowanie oraz tego typu metod
@ComponentScan(basePackages="com.luv2code.springsecurity.demo")	// skanje pakiety w poszukiwaniu Konfiguracji oraz kontrolera, service
@PropertySource("classpath:persistence-mysql.properties")// czytam plik dotyczacy bazy. Nalezy pamietac ze wszystkie pliki src/main/resources sa automatycznie kopiowane do classpath podczas Maven build
public class DemoAppConfig
{

	@Autowired
	private Environment env;	// bedzie trzymac dane z pliku mysql.properties. To jest Helper Klass
	
	
	// logger
	private Logger logger = Logger.getLogger(getClass().getName());	
	
	
	// define a bean for ViewResolver. czyli zwykly viewResolver
	@Bean
	public ViewResolver viewResolver() {	
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();	
		viewResolver.setPrefix("/WEB-INF/view/");
		viewResolver.setSuffix(".jsp");
		
		return viewResolver;
	}
	// define a bean for our security datasource
	@Bean	
	public DataSource securityDataSource() {	// rejestruje bean dla security dataSource
		
		// create connection pool
		ComboPooledDataSource securityDataSource= new ComboPooledDataSource();		
		// set the jdbc driver class
		try {
			securityDataSource.setDriverClass(env.getProperty("jdbc.driver"));
		} catch (PropertyVetoException exc) {
			throw new RuntimeException(exc);
		}
		// log the connection props
		// for sanity's sake, log this info
		// just to make sure we are REALLY reading data from properties file
		
		logger.info(">>> jdbc.url=" + env.getProperty("jdbc.url"));//czytam  log conection props zeby upewnic sie ze czytam wlasciwe dane 
		logger.info(">>> jdbc.user=" + env.getProperty("jdbc.user"));			
		// set database connection props
		
		securityDataSource.setJdbcUrl(env.getProperty("jdbc.url"));
		securityDataSource.setUser(env.getProperty("jdbc.user"));
		securityDataSource.setPassword(env.getProperty("jdbc.password"));
		
		// set connection pool props

		securityDataSource.setInitialPoolSize(getIntProperty("connection.pool.initialPoolSize"));//to jest ta konwersja , metoda domyslnie oczekuje inta  ktorego musimy zamienic metoda getProperty
		securityDataSource.setMinPoolSize(getIntProperty("connection.pool.minPoolSize"));
		securityDataSource.setMaxPoolSize(getIntProperty("connection.pool.maxPoolSize"));
		securityDataSource.setMaxIdleTime(getIntProperty("connection.pool.maxIdleTime"));
		
		return securityDataSource;
	}
	// need a helper method  read environment property and convert to int	
	// to jest metoda majaca na celu pomoc w konwersji zdania 	connection.pool.initialPoolSize=5 	czytanego z pliku . To jest zamianie tej wartosci na inta 
	private int getIntProperty(String propName) {		
		String propVal = env.getProperty(propName);	
	// now convert to int
		int intPropVal = Integer.parseInt(propVal);
		
		return intPropVal;
	}
}
















