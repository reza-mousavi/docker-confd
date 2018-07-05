package com.reza.sample.docker.rest.controller;

import com.reza.sample.docker.rest.dto.HelloMessage;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/hello")
public class HelloWorldRestController {

	private static final Logger logger = LogManager.getLogger(HelloWorldRestController.class);

	@Value("${spring.application.name}")
	private String applicationName;

	@RequestMapping(path = "/", method = RequestMethod.GET)
	public HelloMessage sayHelloDefault(){
		logger.info("Responding default.");
		return HelloMessage.builder().message("Hello anonymous!").application(applicationName).build();
	}

	@RequestMapping(path = "/{name}", method = RequestMethod.GET)
	public HelloMessage sayHello(@PathVariable("name")String name){
		logger.info("Responding for : " + name);
		return HelloMessage.builder().message(String.format("Hello '%s'!", name)).application(applicationName).build();
	}

}
