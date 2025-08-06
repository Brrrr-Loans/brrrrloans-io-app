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
          className="data-[state=open]:bg-sidebar-accent data-[state=open]:text-sidebar-accent-foreground"
        >
          <OrganizationSwitcher
            hidePersonal
            appearance={{
              elements: {
                organizationSwitcherTrigger:
                  "flex items-center w-full h-full p-0 border-0 bg-transparent hover:bg-transparent focus:bg-transparent rounded-md transition-colors",
                organizationSwitcherTriggerIcon: "ml-auto size-4",
                organizationPreview: "flex items-center w-full gap-3",
                organizationPreviewAvatarBox:
                  "flex aspect-square size-8 items-center justify-center rounded-lg bg-sidebar-primary text-sidebar-primary-foreground shrink-0",
                organizationPreviewAvatarImage: "size-8 rounded-lg",
                organizationPreviewMainIdentifier:
                  "grid flex-1 text-left text-sm leading-tight",
                organizationPreviewPrimaryIdentifier:
                  "truncate font-medium text-sm text-sidebar-foreground",
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
