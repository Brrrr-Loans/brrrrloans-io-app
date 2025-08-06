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
                  "flex w-full items-center gap-2 overflow-hidden rounded-md p-2 text-left text-sm outline-none ring-sidebar-ring transition-[width,height,padding] hover:bg-sidebar-accent hover:text-sidebar-accent-foreground focus-visible:ring-2 active:bg-sidebar-accent active:text-sidebar-accent-foreground disabled:pointer-events-none disabled:opacity-50 aria-disabled:pointer-events-none aria-disabled:opacity-50 data-[state=open]:hover:bg-sidebar-accent data-[state=open]:hover:text-sidebar-accent-foreground data-[state=open]:bg-sidebar-accent data-[state=open]:text-sidebar-accent-foreground h-12 w-full border-0 bg-transparent",
                organizationSwitcherTriggerIcon: "ml-auto size-4",
                organizationPreview: "flex items-center w-full gap-2",
                organizationPreviewAvatarBox:
                  "relative flex shrink-0 overflow-hidden size-8 rounded-lg",
                organizationPreviewAvatarImage: "aspect-square h-full w-full",
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
