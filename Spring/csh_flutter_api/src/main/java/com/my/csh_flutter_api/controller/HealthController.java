package com.my.csh_flutter_api.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping(value="/hc")
public class HealthController {

	
	@GetMapping("")
	public String hc() {
		return "running";
	}
}
