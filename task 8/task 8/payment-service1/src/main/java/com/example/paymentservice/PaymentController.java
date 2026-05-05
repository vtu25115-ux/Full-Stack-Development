package com.example.paymentservice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@RestController
public class PaymentController {

    @Value("${server.port}")
    private String port;

    @Autowired
    private WebClient.Builder webClientBuilder;

    @GetMapping("/")
    public String status() {
        return "Payment Service is running on port: " + port;
    }

    @GetMapping("/pay")
    public Mono<String> pay() {
        return webClientBuilder.build()
                .get()
                .uri("http://product-service/info")
                .retrieve()
                .bodyToMono(String.class)
                .map(productResponse -> "Payment successful on port " + port + ". Product details: [" + productResponse + "]");
    }
}
