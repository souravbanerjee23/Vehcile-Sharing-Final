package com.sourav.vehiclesharing.auth;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
public class OtpController {

    private final OtpService otpService;

    public OtpController(OtpService otpService) {
        this.otpService = otpService;
    }

    @PostMapping("/request-otp")
    public Map<String, Object> requestOtp(@RequestBody OtpRequest request) {
        otpService.createOtp(request.contact(), request.role());

        Map<String, Object> response = new HashMap<>();
        response.put("message", "OTP sent successfully");
        response.put("contact", request.contact());
        response.put("role", request.role());
        response.put("expiresInMinutes", 5);
        return response;
    }

    @PostMapping("/verify-otp")
    public ResponseEntity<Map<String, Object>> verifyOtp(@RequestBody OtpVerifyRequest request) {
        boolean valid = otpService.verifyOtp(request.contact(), request.role(), request.code());

        Map<String, Object> response = new HashMap<>();
        response.put("authenticated", valid);
        response.put("contact", request.contact());
        response.put("role", request.role());
        response.put("message", valid ? "OTP verified successfully" : "Invalid or expired OTP");

        return valid
                ? ResponseEntity.ok(response)
                : ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
    }

    public record OtpRequest(String contact, UserRole role) {
    }

    public record OtpVerifyRequest(String contact, UserRole role, String code) {
    }
}
