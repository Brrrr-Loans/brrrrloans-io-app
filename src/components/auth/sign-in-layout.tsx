"use client";

import Image from "next/image";
import { ThemeDropdown } from "@/components/theme/theme-dropdown";
import type { ReactNode } from "react";

interface SignInLayoutProps {
  children: ReactNode;
}

export function SignInLayout({ children }: SignInLayoutProps) {
  return (
    <div className="bg-background min-h-screen relative">
      {/* Global Theme Dropdown - positioned absolutely over entire layout */}
      <div className="absolute top-4 right-4 z-50">
        <ThemeDropdown />
      </div>

      {/* Main content area with right column positioned */}
      <div className="md:pr-[498px]">
        {/* Left side: Sign-in form */}
        <div className="relative items-center justify-center px-6 py-24 md:flex min-h-screen">
          {/* Logo */}
          <div className="absolute top-4 left-4 z-50">
            <a
              href="/dashboard"
              aria-label="Go to dashboard"
              className="flex items-center gap-2 font-medium"
            >
              <div className="flex h-8 w-8 items-center justify-center">
                <Image
                  src="/logos/brrrr-icon-sq-gradient-black-2.svg"
                  alt="Brrrr Loans Logo Light Mode"
                  width={32}
                  height={32}
                  className="block dark:hidden"
                />
                <Image
                  src="/logos/brrrr-icon-sq-gradient-white-2.svg"
                  alt="Brrrr Loans Logo Dark Mode"
                  width={32}
                  height={32}
                  className="hidden dark:block"
                />
              </div>
            </a>
          </div>

          {/* Sign-in form container */}
          <div className="m-auto w-full max-w-sm">{children}</div>
        </div>
      </div>

      {/* Right side: Sticky positioned column - matches Moov.io exactly */}
      <aside className="hidden md:block fixed top-0 right-0 w-[498px] h-screen bg-muted">
        <div className="h-full py-16 flex items-center justify-center">
          <Image
            src="https://ui.shadcn.com/placeholder.svg"
            alt="Image"
            width="1800"
            height="1800"
            className="rounded-lg object-cover w-full h-full max-w-none"
          />
        </div>
      </aside>
    </div>
  );
}
