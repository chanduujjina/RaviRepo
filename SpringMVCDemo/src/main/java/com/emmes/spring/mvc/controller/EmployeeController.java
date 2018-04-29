package com.emmes.spring.mvc.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.emmes.spring.mvc.dao.EmployeeDao;
import com.emmes.spring.mvc.domain.Employee;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
//@RequestMapping("/SpringMVCDemo")
public class EmployeeController {
	@Autowired
    private EmployeeDao employeeDAO;

    @RequestMapping(value = "/saveemp",method=RequestMethod.POST)
    public ModelAndView saveEmployee(@ModelAttribute("employee") @Valid Employee employee,BindingResult result)
    {
    	if(result.hasErrors()){
    		System.out.println("result:"+result.toString());
    	}
        try
        {
            if(employeeDAO.getEmployeeById(employee.getId()) != null);
            employeeDAO.updateEmployee(employee);
        }
        catch(EmptyResultDataAccessException e)
        {
            System.out.println("inside catch");
            employeeDAO.saveEmployee(employee);
        }
        return new ModelAndView("redirect:/employees");
    }
    @RequestMapping(value = "/editview/{id}")
    @ResponseBody
    public Employee editEmp(@ModelAttribute("employee") Employee employee,@PathVariable("id") int id)
    {
    	System.out.println("inside editEmp");
        employee=employeeDAO.getEmployeeById(id);
        
        return employee;
    }
    
    @RequestMapping(value = "/edit/{id}")
    public ModelAndView editEmployee(@ModelAttribute("employee") Employee employee,@PathVariable("id") int id)
    {
        ModelAndView model = new ModelAndView("employees");
        employee=employeeDAO.getEmployeeById(id);
        employeeDAO.updateEmployee(employee);
        List employeeList = employeeDAO.getAllEmployees();
        model.addObject("employeeList",employeeList);
        
        return model;
    }
    
    @RequestMapping(value = "/delete/{id}")
    public ModelAndView deleteEmployee(@ModelAttribute("employee") Employee employee,@PathVariable("id") int id)
    {
    	System.out.println("id::"+id);
        employeeDAO.deleteEmployee(id);
        
        return new ModelAndView("redirect:/employees");
    }

    @RequestMapping(value = "/employees")
    public ModelAndView listEmployees(@ModelAttribute("employee") Employee employee) throws JsonProcessingException
    {
        ModelAndView model = new ModelAndView("employees");
        List<Employee> employeeList = employeeDAO.getAllEmployees();
        System.out.println(employeeList);
        //ObjectMapper mapper=new ObjectMapper();
        //String objectJson=mapper.writeValueAsString(employeeList);
        //System.out.println("objectJson::"+objectJson);
        //String json=convertjavaJson(employeeList);
        model.addObject("employeeList", employeeList);
        return model;
    }
	@RequestMapping(value = "/")
    public ModelAndView getEmployeeList(@ModelAttribute("employee") Employee employee)
    {
    	return new ModelAndView("redirect:/employees");
    }
    
    @RequestMapping("/search/{id}")
	@ResponseBody
	public Employee getById(@PathVariable int id) {
    	System.out.println("inside getById");
    	System.out.println("id::"+id);
    	Employee employee=employeeDAO.getEmployeeById(id);
    	return employee;
	}
    
    @RequestMapping("/empDetails")
    public @ResponseBody String getEmployeeDetails() throws JsonProcessingException{
    	 List<Employee> employeeList = employeeDAO.getAllEmployees();
    	 ObjectMapper mapper=new ObjectMapper();
    	 String objectJson=mapper.writeValueAsString(employeeList);
    	 System.out.println("objectJson::"+objectJson);
		return objectJson;
    	
    }
    
}
