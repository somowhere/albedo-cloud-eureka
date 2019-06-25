package com.albedo.java.docs.web;

import com.albedo.java.docs.config.swagger.ServiceDefinitionsContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

//import com.albedo.java.docs.config.swagger.ServiceDefinitionsContext;

/**
 * 
 * @author satish sharma
 * <pre>
 *  Controller to serve the JSON from our in-memory store. So that UI can render the API-Documentation	
 * </pre>
 */
@Controller
public class ServiceDefinitionController {
	
	@Autowired
	private ServiceDefinitionsContext definitionContext;

	@GetMapping("/service/{servicename}")
	@ResponseBody
	public String getServiceDefinition(@PathVariable("servicename") String serviceName){
		return definitionContext.getSwaggerDefinition(serviceName);
	}

	@RequestMapping("/")
	public String index() {
		return "redirect:/swagger-ui.html";
	}

}
