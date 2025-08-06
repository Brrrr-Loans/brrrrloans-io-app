"use client";

import Image from "next/image";
import { ReactNode } from "react";
import { ThemeDropdown } from "@/components/theme/theme-dropdown";

interface SignUpLayoutProps {
  children: ReactNode;
}

export function SignUpLayout({ children }: SignUpLayoutProps) {
  return (
    <div className="bg-background min-h-screen md:flex">
      {/* Global Theme Dropdown - positioned absolutely over entire layout */}
      <div className="absolute top-4 right-4 z-50">
        <ThemeDropdown />
      </div>

      {/* Left side: Sign-up form */}
      <div className="relative items-center justify-center px-6 py-24 md:flex md:flex-1">
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

        {/* Sign-up form container */}
        <div className="m-auto w-full max-w-sm">{children}</div>
      </div>

      {/* Right side: Image - Fixed width to match Moov.io */}
      <div className="hidden bg-muted md:block md:w-[480px]">
        <div className="h-screen p-8 flex items-center justify-center">
          <Image
            src="https://ui.shadcn.com/placeholder.svg"
            alt="Image"
            width="1800"
            height="1800"
            className="rounded-lg object-cover w-full h-full max-w-none"
          />
        </div>
      </div>
    </div>
  );
}
