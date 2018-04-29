package com.emmes.spring.mvc.domain;

import java.util.Map;

public class EmployeeJsonRespone {
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public boolean isValidated() {
		return validated;
	}
	public void setValidated(boolean validated) {
		this.validated = validated;
	}
	public Map<String, String> getErrorMessages() {
		return errorMessages;
	}
	public void setErrorMessages(Map<String, String> errorMessages) {
		this.errorMessages = errorMessages;
	}
	private Employee employee;
	   private boolean validated;
	   private Map<String, String> errorMessages;
}
