"use client";

import { OrganizationSwitcher } from "@/components/auth/clerk-components";
import {
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from "@/components/ui/sidebar";

export function TeamSwitcher() {
  return (
    <SidebarMenu>
      <SidebarMenuItem>
        <SidebarMenuButton
          size="lg"
          className="data-[state=open]:bg-sidebar-accent data-[state=open]:text-sidebar-accent-foreground h-12"
        >
          <OrganizationSwitcher
            hidePersonal
            appearance={{
              elements: {
                organizationSwitcherTrigger:
                  "flex items-center w-full h-full p-0 border-0 bg-transparent hover:bg-transparent focus:bg-transparent rounded-md transition-colors",
                organizationSwitcherTriggerIcon: "ml-auto size-4",
                organizationPreview: "flex items-center w-full gap-2",
                organizationPreviewAvatarBox:
                  "size-8 rounded-lg flex items-center justify-center bg-sidebar-primary text-sidebar-primary-foreground shrink-0",
                organizationPreviewAvatarImage: "size-8 rounded-lg",
                organizationPreviewMainIdentifier:
                  "grid flex-1 text-left",
                organizationPreviewPrimaryIdentifier:
                  "truncate text-sm font-medium",
                organizationPreviewSecondaryIdentifier:
                  "truncate text-xs text-muted-foreground",
              },
            }}
            createOrganizationMode="modal"
            organizationProfileMode="modal"
          />
        </SidebarMenuButton>
      </SidebarMenuItem>
    </SidebarMenu>
  );
}
