package com.example.apigateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ApiGatewayApplication {

    public static void main(String[] args) {
        SpringApplication app = new SpringApplication(ApiGatewayApplication.class);
        // Default port: 8080 (fallback: 8081 if busy)
        PortUtil.configureDynamicPort(app, port -> port == 8080 ? 8081 : port + 1);
        app.run(args);
    }
}
