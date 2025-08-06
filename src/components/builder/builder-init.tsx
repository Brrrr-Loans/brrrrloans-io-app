"use client";

import { useEffect } from "react";
import { builder } from "@builder.io/react";

export function BuilderInit() {
  useEffect(() => {
    // Initialize Builder.io on the client side
    if (process.env.NEXT_PUBLIC_BUILDER_API_KEY) {
      builder.init(process.env.NEXT_PUBLIC_BUILDER_API_KEY);
    }
  }, []);

  return null;
}
