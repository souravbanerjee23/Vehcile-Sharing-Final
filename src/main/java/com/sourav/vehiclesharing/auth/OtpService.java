package com.sourav.vehiclesharing.auth;

import java.security.SecureRandom;
import java.time.Duration;
import java.time.Instant;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;

@Service
public class OtpService {
    private static final Duration OTP_TTL = Duration.ofMinutes(5);
    private final SecureRandom random = new SecureRandom();
    private final Map<String, OtpChallenge> challenges = new ConcurrentHashMap<>();

    public String createOtp(String contact, UserRole role) {
        String normalizedContact = normalize(contact);
        String code = String.format("%06d", random.nextInt(1_000_000));
        challenges.put(key(normalizedContact, role), new OtpChallenge(code, Instant.now().plus(OTP_TTL), role));
        return code;
    }

    public boolean verifyOtp(String contact, UserRole role, String code) {
        String normalizedContact = normalize(contact);
        String challengeKey = key(normalizedContact, role);
        OtpChallenge challenge = challenges.get(challengeKey);
        if (challenge == null || challenge.isExpired() || !challenge.code().equals(code)) {
            return false;
        }
        challenges.remove(challengeKey);
        return true;
    }

    private String key(String contact, UserRole role) {
        return role.name() + ":" + contact;
    }

    private String normalize(String contact) {
        if (contact == null || contact.isBlank()) {
            throw new IllegalArgumentException("Email or phone is required");
        }
        return contact.trim().toLowerCase();
    }
}
