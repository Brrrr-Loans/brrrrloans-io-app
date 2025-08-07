"use client";

import { SidebarInset, SidebarProvider } from "@/components/ui";
import { AppSidebar } from "@/components/layout/app-sidebar";

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <SidebarProvider>
      <AppSidebar />
      <SidebarInset>
        <div className="flex flex-col gap-4 pb-4 md:gap-6 md:pb-6 px-4 lg:px-6 flex-1">
          {children}
        </div>
      </SidebarInset>
    </SidebarProvider>
  );
}
