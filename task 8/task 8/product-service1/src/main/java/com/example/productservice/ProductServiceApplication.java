package com.example.productservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Value;

@SpringBootApplication
@RestController
public class ProductServiceApplication {

    @Value("${server.port}")
    private String port;

    public static void main(String[] args) {
        SpringApplication app = new SpringApplication(ProductServiceApplication.class);
        PortUtil.configureDynamicPort(app, port -> port + 1);
        app.run(args);
    }

    @GetMapping("/")
    public String status() {
        return "Product Service is running on port: " + port;
    }
    
    // An endpoint here will be useful if Payment service wants to just check data
    @GetMapping("/info")
    public String info() {
        return "Product Data from port " + port;
    }
}
