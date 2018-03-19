package uk.gov.hmcts.reform.demo.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.http.ResponseEntity.ok;

@RestController
public class HelloWorldEndpoint {

    @GetMapping
    public ResponseEntity<String> helloWorld() {
        return ok("Welcome to spring-boot-template");
    }
}
