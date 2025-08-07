import { useEffect, useState } from "react";
import { useInvestorPermissions } from "@/hooks/use-investor-permissions";
import { Skeleton } from "@/components/ui";

interface WithInvestorPermissionProps {
  resourceType: "deal" | "document" | "contribution" | "distribution";
  resourceId: string;
  fallback?: React.ReactNode;
  loadingComponent?: React.ReactNode;
}

export function withInvestorPermission<P extends object>(
  WrappedComponent: React.ComponentType<P>
) {
  return function WithPermissionCheck({
    resourceType,
    resourceId,
    fallback = null,
    loadingComponent = <Skeleton className="w-full h-32" />,
    ...props
  }: WithInvestorPermissionProps & P) {
    const [hasPermission, setHasPermission] = useState(false);
    const [isChecking, setIsChecking] = useState(true);
    const {
      canViewDeal,
      canViewDocument,
      canViewContribution,
      canViewDistribution,
      isLoading,
    } = useInvestorPermissions();

    useEffect(() => {
      async function checkPermission() {
        if (!resourceId || isLoading) return;

        let hasAccess = false;
        switch (resourceType) {
          case "deal":
            hasAccess = await canViewDeal(resourceId);
            break;
          case "document":
            hasAccess = await canViewDocument(resourceId);
            break;
          case "contribution":
            hasAccess = await canViewContribution(resourceId);
            break;
          case "distribution":
            hasAccess = await canViewDistribution(resourceId);
            break;
        }

        setHasPermission(hasAccess);
        setIsChecking(false);
      }

      checkPermission();
    }, [
      resourceType,
      resourceId,
      isLoading,
      canViewDeal,
      canViewDocument,
      canViewContribution,
      canViewDistribution,
    ]);

    if (isChecking || isLoading) {
      return loadingComponent;
    }

    if (!hasPermission) {
      return fallback;
    }

    return <WrappedComponent {...(props as P)} />;
  };
}
 