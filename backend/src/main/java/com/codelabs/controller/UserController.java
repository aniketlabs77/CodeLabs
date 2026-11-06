package com.codelabs.controller;

import com.codelabs.dto.LoginRequest;
import com.codelabs.dto.RegisterRequest;
import com.codelabs.dto.UserResponse;
import com.codelabs.entity.User;
import com.codelabs.service.UserService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/register")
    public ResponseEntity<UserResponse> register(@Valid @RequestBody RegisterRequest request) {
        User savedUser = userService.registerUser(request);

        UserResponse response = new UserResponse(
            savedUser.getId(),
            savedUser.getEmail(),
            savedUser.getFullName(),
            savedUser.getRole()
        );

        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @PostMapping("/login")
    public ResponseEntity<UserResponse> login(@Valid @RequestBody LoginRequest request) {
        User user = userService.login(request);

        UserResponse response = new UserResponse(
            user.getId(),
            user.getEmail(),
            user.getFullName(),
            user.getRole()
        );

        return ResponseEntity.ok(response);
    }
}
