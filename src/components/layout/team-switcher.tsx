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
                organizationSwitcherTrigger: {
                  display: "flex",
                  alignItems: "center",
                  width: "100%",
                  height: "100%",
                  padding: "0",
                  border: "0",
                  backgroundColor: "transparent",
                  "&:hover": {
                    backgroundColor: "transparent",
                  },
                  "&:focus": {
                    backgroundColor: "transparent",
                  },
                  borderRadius: "6px",
                  transition: "colors",
                },
                organizationSwitcherTriggerIcon: {
                  marginLeft: "auto",
                  width: "16px",
                  height: "16px",
                },
                organizationPreview: {
                  display: "flex",
                  alignItems: "center",
                  width: "100%",
                  gap: "8px",
                },
                organizationPreviewAvatarBox: {
                  width: "32px",
                  height: "32px",
                  borderRadius: "8px",
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  flexShrink: "0",
                },
                organizationPreviewAvatarImage: {
                  width: "32px",
                  height: "32px",
                  borderRadius: "8px",
                },
                organizationPreviewMainIdentifier: {
                  display: "grid",
                  flex: "1",
                  textAlign: "left",
                },
                organizationPreviewPrimaryIdentifier: {
                  overflow: "hidden",
                  textOverflow: "ellipsis",
                  whiteSpace: "nowrap",
                  fontSize: "14px",
                  fontWeight: "500",
                },
                organizationPreviewSecondaryIdentifier: {
                  overflow: "hidden",
                  textOverflow: "ellipsis",
                  whiteSpace: "nowrap",
                  fontSize: "12px",
                  color: "hsl(var(--muted-foreground))",
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
