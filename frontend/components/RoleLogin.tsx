'use client';

import { FormEvent, useState } from 'react';
import { api, UserRole } from '@/lib/api';

type Props = {
  role: UserRole;
  title: string;
  description: string;
  onAuthenticated: (contact: string, role: UserRole) => void;
};

export default function RoleLogin({ role, title, description, onAuthenticated }: Props) {
  const [contact, setContact] = useState('');
  const [otp, setOtp] = useState('');
  const [sent, setSent] = useState(false);
  const [status, setStatus] = useState('');

  async function requestOtp(event: FormEvent) {
    event.preventDefault();
    await api.requestOtp(contact, role);
    setSent(true);
    setStatus(`OTP sent to ${contact}. It expires in 5 minutes.`);
  }

  async function verifyOtp(event: FormEvent) {
    event.preventDefault();
    const result = await api.verifyOtp(contact, role, otp);

    if (!result.authenticated) {
      setStatus(result.message || 'Invalid or expired OTP.');
      return;
    }

    setStatus('Login successful.');
    onAuthenticated(contact, role);
  }

  return (
    <div className="login-card">
      <span className="eyebrow">
        {role === 'DRIVER' ? 'For ride owners' : 'For passengers'}
      </span>
      <h3>{title}</h3>
      <p>{description}</p>

      {!sent ? (
        <form className="login-form" onSubmit={requestOtp}>
          <label>
            Email or phone
            <input
              required
              value={contact}
              onChange={event => setContact(event.target.value)}
              placeholder="you@example.com"
            />
          </label>
          <button className="button primary" type="submit">
            Send OTP
          </button>
        </form>
      ) : (
        <form className="login-form" onSubmit={verifyOtp}>
          <label>
            Enter OTP
            <input
              required
              inputMode="numeric"
              maxLength={6}
              value={otp}
              onChange={event => setOtp(event.target.value)}
              placeholder="6-digit OTP"
            />
          </label>
          <button className="button primary" type="submit">
            Verify & continue
          </button>
          <button className="text-button" type="button" onClick={() => setSent(false)}>
            Use another account
          </button>
        </form>
      )}

      {status ? <p className="login-status">{status}</p> : null}
    </div>
  );
}
