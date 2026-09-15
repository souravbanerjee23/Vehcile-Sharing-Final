package com.sourav.vehiclesharing.auth;

import java.time.Instant;

public record OtpChallenge(String code, Instant expiresAt, UserRole role) {
    public boolean isExpired() {
        return Instant.now().isAfter(expiresAt);
    }
}
