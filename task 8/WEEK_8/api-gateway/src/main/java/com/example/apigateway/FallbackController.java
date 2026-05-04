package com.example.apigateway;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class FallbackController {

    @GetMapping("/")
    public String gatewayStatus() {
        return "API Gateway is running and ready to route requests!";
    }
}
