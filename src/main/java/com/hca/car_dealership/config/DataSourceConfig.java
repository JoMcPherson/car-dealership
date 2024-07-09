package com.hca.car_dealership.config;


import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataSourceConfig {
    @Autowired
    private DataSourceProperties dataSourceProperties;

    @Bean
    public BasicDataSource dataSource() {
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setUrl(dataSourceProperties.getUrl());
        dataSource.setUsername(dataSourceProperties.getUserName());
        dataSource.setPassword(dataSourceProperties.getPassword());
        dataSource.setDriverClassName(dataSourceProperties.getDriverClassName());
        return dataSource;
    }
}
