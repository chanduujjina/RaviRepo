package com.emmes.spring.mvc.config;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import com.emmes.spring.mvc.dao.EmployeeDao;
import com.emmes.spring.mvc.daoimpl.EmployeeDAOImpl;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.emmes.spring.mvc")
public class WebappConfiguration extends WebMvcConfigurerAdapter{

	@Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix("/WEB-INF/jsp/");
        viewResolver.setSuffix(".jsp");
        return viewResolver;
    }
	@Bean
	public DataSource getDataSource(){
		DriverManagerDataSource dataSource=new DriverManagerDataSource();
		dataSource.setDriverClassName("com.mysql.jdbc.Driver");
		dataSource.setUrl("jdbc:mysql://localhost:3306/enterprisedb");
		dataSource.setUsername("root");
		dataSource.setPassword("root");
		return dataSource;
	}
	@Bean
	public JdbcTemplate getJdbcTemplate(DataSource dataSource){
		JdbcTemplate jdbcTemplate=new JdbcTemplate(dataSource);
		jdbcTemplate.setResultsMapCaseInsensitive(true);
		return jdbcTemplate;
	}
	@Bean
	public EmployeeDao getEmployeeDao(){
		return new EmployeeDAOImpl();
	}
	/*
     * Configure ResourceHandlers to serve static resources like CSS/ Javascript etc...
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**").addResourceLocations("/static/");
    }
}
