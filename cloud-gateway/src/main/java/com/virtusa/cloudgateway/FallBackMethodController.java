package com.virtusa.cloudgateway;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController

public class FallBackMethodController {
	
	
	@GetMapping("/empServiceFallback")
	public String empServiceFallBackMethod() {
		return "Employee service is taking longer than expected.please try again";
	}
	
	@GetMapping("/departmentServiceFallback")
	public String departmentServiceFallBackMethod() {
		return "Department service is taking longer than expected.please try again";
	}
}
