"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { useUser } from "@clerk/nextjs";
import type { UserPermissions, ContactType, UserRole } from "@/types/auth";
import { useUserPermissions as useUserPermissionsHook } from "@/hooks/use-user-permissions";
import { AlertCircle, Lock } from "lucide-react";
import {
  Alert,
  AlertDescription,
  AlertTitle,
} from "@/components/ui/feedback/alert";
import { Button } from "@/components/ui";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/layout/card";

interface RouteProtectionProps {
  children: React.ReactNode;
  requiredContactTypes?: ContactType[];
  requiredRoles?: UserRole[];
  requiredPermissions?: Array<keyof UserPermissions>;
  fallbackComponent?: React.ComponentType<{
    permissions: UserPermissions | null;
  }>;
  redirectTo?: string;
}

export function RouteProtection({
  children,
  requiredContactTypes = [],
  requiredRoles = [],
  requiredPermissions = [],
  fallbackComponent: FallbackComponent,
  redirectTo,
}: RouteProtectionProps) {
  const [hasAccess, setHasAccess] = useState(false);
  const { isLoaded, isSignedIn } = useUser();
  const {
    permissions,
    loading: permissionsLoading,
    error,
  } = useUserPermissionsHook();
  const router = useRouter();

  useEffect(() => {
    async function checkPermissions() {
      if (!isLoaded) return;

      if (!isSignedIn) {
        if (redirectTo) {
          router.push(redirectTo);
        } else {
          router.push("/sign-in");
        }
        return;
      }

      if (!permissions && !permissionsLoading && !error) {
        setHasAccess(false);
        return;
      }

      if (permissions) {
        // Check contact type requirements
        const contactTypeMatch =
          requiredContactTypes.length === 0 ||
          requiredContactTypes.includes(permissions.contactType);

        // Check role requirements
        const roleMatch =
          requiredRoles.length === 0 ||
          requiredRoles.includes(permissions.role);

        // Check specific permission requirements
        const permissionMatch =
          requiredPermissions.length === 0 ||
          requiredPermissions.every((perm) => permissions[perm]);

        setHasAccess(contactTypeMatch && roleMatch && permissionMatch);
      } else {
        setHasAccess(false);
      }
    }

    checkPermissions();
  }, [
    isLoaded,
    isSignedIn,
    permissions,
    permissionsLoading,
    error,
    requiredContactTypes,
    requiredRoles,
    requiredPermissions,
    router,
    redirectTo,
  ]);

  if (!isLoaded || permissionsLoading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
      </div>
    );
  }

  if (!hasAccess) {
    if (FallbackComponent) {
      return <FallbackComponent permissions={permissions} />;
    }

    return (
      <div className="container mx-auto py-12 px-4">
        <Card className="max-w-md mx-auto">
          <CardHeader className="text-center">
            <div className="mx-auto w-12 h-12 bg-destructive/10 rounded-full flex items-center justify-center mb-4">
              <Lock className="w-6 h-6 text-destructive" />
            </div>
            <CardTitle>Access Restricted</CardTitle>
            <CardDescription>
              You don't have permission to access this page.
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            {permissions && (
              <Alert>
                <AlertCircle className="h-4 w-4" />
                <AlertTitle>Your Current Access Level</AlertTitle>
                <AlertDescription>
                  Contact Type: {permissions.contactType}
                  <br />
                  Role: {permissions.role}
                </AlertDescription>
              </Alert>
            )}
            <div className="flex flex-col sm:flex-row gap-2">
              <Button
                variant="outline"
                onClick={() => router.back()}
                className="flex-1"
              >
                Go Back
              </Button>
              <Button
                onClick={() => router.push("/dashboard")}
                className="flex-1"
              >
                Go to Dashboard
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>
    );
  }

  return <>{children}</>;
}

/**
 * Hook to get current user permissions
 * @deprecated Use the hook from @/hooks/use-user-permissions instead
 */
export function useUserPermissions() {
  // Re-export the hook from the proper location
  return useUserPermissionsHook();
}
