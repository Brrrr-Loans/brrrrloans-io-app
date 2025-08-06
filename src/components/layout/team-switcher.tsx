"use client";

import { ChevronsUpDown } from "lucide-react";
import { useOrganization, useUser } from "@clerk/nextjs";
import { OrganizationSwitcher } from "@/components/auth/clerk-components";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import {
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from "@/components/ui/sidebar";

export function TeamSwitcher() {
  const { organization } = useOrganization();
  const { user } = useUser();

  // Get organization info for display
  const orgName = organization?.name || "Select Organization";
  const userRole = organization?.role || user?.primaryEmailAddress?.emailAddress || "";
  const orgImageUrl = organization?.imageUrl;

  return (
    <SidebarMenu>
      <SidebarMenuItem>
        <SidebarMenuButton
          size="lg"
          className="data-[state=open]:bg-sidebar-accent data-[state=open]:text-sidebar-accent-foreground h-12"
          asChild
        >
          <div className="relative">
            {/* Custom layout matching NavUser exactly */}
            <Avatar className="size-8 rounded-lg">
              <AvatarImage src={orgImageUrl} alt={orgName} />
              <AvatarFallback className="rounded-lg">
                {orgName
                  .split(" ")
                  .map((n) => n[0])
                  .join("")
                  .toUpperCase() || "O"}
              </AvatarFallback>
            </Avatar>
            <div className="grid flex-1 text-left">
              <span className="truncate text-sm font-medium">
                {orgName}
              </span>
              <span className="truncate text-xs text-muted-foreground">
                {userRole}
              </span>
            </div>
            <ChevronsUpDown className="ml-auto size-4" />
            
            {/* Hidden OrganizationSwitcher for functionality */}
            <div className="absolute inset-0">
              <OrganizationSwitcher
                hidePersonal
                appearance={{
                  elements: {
                    organizationSwitcherTrigger: "opacity-0 w-full h-full cursor-pointer",
                    organizationSwitcherTriggerIcon: "hidden",
                    organizationPreview: "hidden",
                    organizationPreviewAvatarBox: "hidden",
                    organizationPreviewAvatarImage: "hidden",
                    organizationPreviewMainIdentifier: "hidden",
                    organizationPreviewPrimaryIdentifier: "hidden",
                    organizationPreviewSecondaryIdentifier: "hidden",
                  },
                }}
                createOrganizationMode="modal"
                organizationProfileMode="modal"
              />
            </div>
          </div>
        </SidebarMenuButton>
      </SidebarMenuItem>
    </SidebarMenu>
  );
}
