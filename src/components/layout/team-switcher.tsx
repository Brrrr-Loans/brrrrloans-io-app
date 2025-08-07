"use client";

import { OrganizationSwitcher } from "@/components/auth/clerk-components";
import {
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from "@/components/ui";

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
                // Main trigger button - matches official shadcn/ui TeamSwitcher
                organizationSwitcherTrigger: {
                  display: "flex",
                  width: "100%",
                  alignItems: "center",
                  gap: "0.5rem",
                  overflow: "hidden",
                  borderRadius: "0.375rem",
                  padding: "0.5rem",
                  textAlign: "left",
                  fontSize: "0.875rem",
                  outline: "none",
                  transition: "all",
                  border: "none",
                  backgroundColor: "transparent",
                  ":hover": {
                    backgroundColor: "hsl(var(--sidebar-accent))",
                    color: "hsl(var(--sidebar-accent-foreground))",
                  },
                  ":focus-visible": {
                    ring: "2px solid hsl(var(--sidebar-ring))",
                  },
                  '[data-state="open"]': {
                    ring: "2px solid hsl(var(--sidebar-ring))",
                    backgroundColor: "hsl(var(--sidebar-accent))",
                    color: "hsl(var(--sidebar-accent-foreground))",
                  },
                  height: "3rem", // h-12
                },

                // Organization avatar - matches shadcn/ui pattern
                organizationPreviewAvatarBox: {
                  backgroundColor: "hsl(var(--sidebar-primary))",
                  color: "hsl(var(--sidebar-primary-foreground))",
                  display: "flex",
                  aspectRatio: "1",
                  width: "2rem", // size-8
                  height: "2rem", // size-8
                  alignItems: "center",
                  justifyContent: "center",
                  borderRadius: "0.5rem", // rounded-lg
                  flexShrink: "0",
                },

                // Text container - matches NavUser grid layout
                organizationPreviewMainIdentifier: {
                  display: "grid",
                  flex: "1 1 0%",
                  textAlign: "left",
                  fontSize: "0.875rem",
                  lineHeight: "1.25",
                },

                // Organization name - matches NavUser primary text
                organizationPreviewPrimaryIdentifier: {
                  overflow: "hidden",
                  textOverflow: "ellipsis",
                  whiteSpace: "nowrap",
                  fontWeight: "500", // font-medium
                },

                // Organization role - matches NavUser secondary text
                organizationPreviewSecondaryIdentifier: {
                  overflow: "hidden",
                  textOverflow: "ellipsis",
                  whiteSpace: "nowrap",
                  fontSize: "0.75rem", // text-xs
                  color: "hsl(var(--muted-foreground))",
                },

                // Chevron icon - matches NavUser positioning
                organizationSwitcherTriggerIcon: {
                  marginLeft: "auto",
                  width: "1rem", // size-4
                  height: "1rem", // size-4
                },

                // Dropdown content styling
                organizationSwitcherPopoverContent: {
                  width: "var(--radix-dropdown-menu-trigger-width)",
                  minWidth: "14rem", // min-w-56
                  borderRadius: "0.5rem", // rounded-lg
                },
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
