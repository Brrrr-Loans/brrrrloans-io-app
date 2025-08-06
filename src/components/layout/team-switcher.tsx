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
                  "flex items-center w-full h-full p-0 border-0 bg-transparent hover:bg-transparent focus:bg-transparent rounded-md transition-colors after:content-[''] after:absolute after:right-0 after:top-1/2 after:-translate-y-1/2 after:w-4 after:h-4 after:bg-current after:opacity-70 after:[mask-image:url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTUiIGhlaWdodD0iMTUiIHZpZXdCb3g9IjAgMCAxNSAxNSIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0ibTQuNSA2IDMgMyAzLTMiIHN0cm9rZT0iY3VycmVudENvbG9yIiBzdHJva2Utd2lkdGg9IjEiLz4KPHBhdGggZD0ibTQuNSA5IDMtMyAzIDMiIHN0cm9rZT0iY3VycmVudENvbG9yIiBzdHJva2Utd2lkdGg9IjEiLz4KPC9zdmc+')] after:[mask-repeat:no-repeat] after:[mask-position:center]",
                organizationSwitcherTriggerIcon: "hidden",
                organizationPreview: "flex items-center w-full relative",
                organizationPreviewAvatarBox:
                  "size-8 rounded-lg flex items-center justify-center bg-sidebar-primary text-sidebar-primary-foreground shrink-0",
                organizationPreviewAvatarImage: "size-8 rounded-lg",
                organizationPreviewMainIdentifier:
                  "grid flex-1 text-left ml-2 pr-6",
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
