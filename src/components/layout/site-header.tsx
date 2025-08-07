"use client";

import { usePathname } from "next/navigation";
import { Separator } from "@/components/ui/layout/separator";
import { SidebarTrigger } from "@/components/ui/layout/sidebar";
import { SearchForm } from "@/components/layout/search-form";
import { ThemeDropdown } from "@/components/theme/theme-dropdown";

interface SiteHeaderProps {
  title?: string;
  breadcrumb?: React.ReactNode;
}

function getPageTitle(pathname: string): string {
  // Remove trailing slash and split path
  const path = pathname.replace(/\/$/, "");

  if (path === "/dashboard") return "Dashboard";
  if (path === "/dashboard/deals") return "Deals";
  if (path.startsWith("/dashboard/deals/")) return "Deal Details";
  if (path === "/dashboard/distributions") return "Distributions";
  if (path.startsWith("/dashboard/distributions/"))
    return "Distribution Details";
  if (path === "/dashboard/documents") return "Documents";
  if (path === "/dashboard/reports") return "Reports";
  if (path === "/dashboard/investor") return "Investor Portal";
  if (path === "/dashboard/investor-statements") return "Investor Statements";
  if (path.startsWith("/dashboard/admin/")) return "Admin";
  if (path === "/builder") return "Builder";

  // Default fallback - capitalize the last segment
  const segments = path.split("/");
  const lastSegment = segments[segments.length - 1];
  return lastSegment
    ? lastSegment.charAt(0).toUpperCase() + lastSegment.slice(1)
    : "Dashboard";
}

export function SiteHeader({ title, breadcrumb }: SiteHeaderProps) {
  const pathname = usePathname();
  const dynamicTitle = title || getPageTitle(pathname);
  return (
    <header className="bg-background z-50 flex h-16 shrink-0 items-center gap-2 border-b px-4 sticky top-0">
      <SidebarTrigger className="-ml-1" />
      <Separator
        orientation="vertical"
        className="bg-border shrink-0 w-[1px] mr-2 h-4"
      />
      {breadcrumb ? (
        <div className="flex items-center gap-2">{breadcrumb}</div>
      ) : (
        <h1 className="text-base font-medium">{dynamicTitle}</h1>
      )}
      <div className="flex w-full justify-between ml-4">
        <SearchForm className="w-full max-w-56 xl:max-w-64" />
        <ThemeDropdown />
      </div>
    </header>
  );
}
