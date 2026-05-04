package com.example.userservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Value;

@SpringBootApplication
@RestController
public class UserServiceApplication {

    @Value("${server.port}")
    private String port;

    public static void main(String[] args) {
        SpringApplication app = new SpringApplication(UserServiceApplication.class);
        PortUtil.configureDynamicPort(app, port -> port + 1);
        app.run(args);
    }

    @GetMapping("/")
    public String status() {
        return "User Service is running on port: " + port;
    }
}
