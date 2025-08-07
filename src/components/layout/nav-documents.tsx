"use client";

import Link from "next/link";
import React from "react";

import {
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from "@/components/ui";

export function NavDocuments({
  items,
}: {
  items: {
    name: string;
    url?: string;
    icon: React.ComponentType<{ className?: string }>;
    disabled?: boolean;
  }[];
}) {
  return (
    <SidebarGroup className="group-data-[collapsible=icon]:hidden">
      <SidebarGroupLabel className="text-xs font-medium text-sidebar-foreground/70">
        Documents
      </SidebarGroupLabel>
      <SidebarGroupContent>
        <SidebarMenu>
          {items.map((item) => (
            <SidebarMenuItem key={item.name}>
              {item.url ? (
                <SidebarMenuButton
                  asChild
                  className="text-sidebar-foreground/70 font-normal hover:text-sidebar-foreground hover:bg-sidebar-accent"
                >
                  <Link href={item.url}>
                    <item.icon />
                    <span>{item.name}</span>
                  </Link>
                </SidebarMenuButton>
              ) : (
                <SidebarMenuButton
                  className={`font-normal ${
                    item.disabled
                      ? "text-sidebar-foreground/50 cursor-not-allowed"
                      : "text-sidebar-foreground/70 hover:text-sidebar-foreground hover:bg-sidebar-accent"
                  }`}
                  disabled={item.disabled}
                >
                  <item.icon
                    className={
                      item.disabled ? "text-sidebar-foreground/50" : ""
                    }
                  />
                  <span>{item.name}</span>
                </SidebarMenuButton>
              )}
            </SidebarMenuItem>
          ))}
        </SidebarMenu>
      </SidebarGroupContent>
    </SidebarGroup>
  );
}
