package com.example.serviceregistry;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@SpringBootApplication
@EnableEurekaServer
public class ServiceRegistryApplication {

    public static void main(String[] args) {
        SpringApplication app = new SpringApplication(ServiceRegistryApplication.class);
        PortUtil.configureDynamicPort(app, port -> port == 8762 ? 8761 : port + 1);
        app.run(args);
    }
}
