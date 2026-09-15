import './globals.css';
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Vehicle Sharing Platform',
  description: 'Next.js UI for the Vehicle Sharing Spring Boot APIs'
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
