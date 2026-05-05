package com.example.paymentservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.context.event.ApplicationEnvironmentPreparedEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MapPropertySource;

import java.net.ServerSocket;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

public class PortUtil {
    public static void configureDynamicPort(SpringApplication app, Function<Integer, Integer> fallbackStrategy) {
        app.addListeners(new PortListener(fallbackStrategy));
    }

    private static class PortListener implements ApplicationListener<ApplicationEnvironmentPreparedEvent> {
        private final Function<Integer, Integer> fallbackStrategy;

        public PortListener(Function<Integer, Integer> fallbackStrategy) {
            this.fallbackStrategy = fallbackStrategy;
        }

        @Override
        public void onApplicationEvent(ApplicationEnvironmentPreparedEvent event) {
            ConfigurableEnvironment environment = event.getEnvironment();
            Integer configuredPort = environment.getProperty("server.port", Integer.class);
            if (configuredPort != null && configuredPort > 0) {
                int port = configuredPort;
                while (!isPortAvailable(port)) {
                    System.out.println("Port " + port + " is in use. Trying next available port...");
                    port = fallbackStrategy.apply(port);
                }
                if (port != configuredPort) {
                    Map<String, Object> props = new HashMap<>();
                    props.put("server.port", port);
                    environment.getPropertySources().addFirst(new MapPropertySource("dynamicPort", props));
                    System.out.println("Dynamically assigned port: " + port);
                }
            }
        }
    }

    private static boolean isPortAvailable(int port) {
        try (ServerSocket ignored = new ServerSocket(port)) {
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
