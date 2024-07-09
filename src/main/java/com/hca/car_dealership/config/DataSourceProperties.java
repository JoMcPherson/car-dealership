package com.hca.car_dealership.config;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "spring.datasource")
@Data
@NoArgsConstructor
@AllArgsConstructor

public class DataSourceProperties {
    private String url;
    private String userName;
    private String password;
    private String driverClassName;
}
