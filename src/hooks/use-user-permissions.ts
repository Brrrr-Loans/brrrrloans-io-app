"use client";

import { useUser } from "@clerk/nextjs";
import { useState, useEffect } from "react";
import type { UserPermissions } from "@/types/auth";

export function useUserPermissions() {
  const { user, isLoaded } = useUser();
  const [permissions, setPermissions] = useState<UserPermissions | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function fetchPermissions() {
      // Always fetch permissions since our API has fallback logic
      try {
        setLoading(true);
        setError(null);

        const apiUrl = "/api/auth/permissions";
        console.log("🔄 Fetching permissions from:", apiUrl);
        console.log("🌍 Current window location:", window.location.href);

        const response = await fetch(apiUrl, {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
          credentials: "include", // Include cookies for authentication
          cache: "no-cache", // Prevent caching issues
        });

        console.log("📡 Permissions response:", {
          url: response.url,
          status: response.status,
          ok: response.ok,
          contentType: response.headers.get("content-type"),
          redirected: response.redirected,
        });

        if (!response.ok) {
          const responseText = await response.text();
          console.error("❌ Non-OK response:", responseText);
          throw new Error(`HTTP ${response.status}: ${responseText}`);
        }

        const responseText = await response.text();
        console.log(
          "📝 Raw response text (first 200 chars):",
          responseText.substring(0, 200)
        );

        const userPermissions: UserPermissions = JSON.parse(responseText);
        console.log("✅ Parsed permissions:", userPermissions);

        setPermissions(userPermissions);
      } catch (err) {
        console.error("❌ Error fetching permissions:", err);
        setError(
          err instanceof Error ? err.message : "Failed to fetch permissions"
        );
      } finally {
        setLoading(false);
      }
    }

    fetchPermissions();
  }, []); // Remove dependencies to always fetch

  return { permissions, loading, error };
}
