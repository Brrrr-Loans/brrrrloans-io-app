"use client";

import { Loader2 } from "lucide-react";

export function LoadingAuth() {
  return (
    <div className="flex h-screen w-full flex-col items-center justify-center">
      <Loader2 className="h-8 w-8 animate-spin text-primary" />
      <p className="mt-2 text-sm text-muted-foreground">
        Connecting to database...
      </p>
    </div>
  );
}
