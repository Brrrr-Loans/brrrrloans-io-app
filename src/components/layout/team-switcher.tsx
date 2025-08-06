"use client";

import * as React from "react";
import { ChevronsUpDown, Building2 } from "lucide-react";
import { useOrganization, useOrganizationList } from "@clerk/nextjs";

import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import {
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  useSidebar,
} from "@/components/ui/sidebar";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";

export function TeamSwitcher() {
  const { isMobile } = useSidebar();
  const { organization } = useOrganization();
  const { userMemberships, setActive, createOrganization } = useOrganizationList();

  const activeOrganization = organization || userMemberships?.data?.[0]?.organization;

  if (!activeOrganization) {
    return (
      <SidebarMenu>
        <SidebarMenuItem>
          <SidebarMenuButton
            size="lg"
            className="data-[state=open]:bg-sidebar-accent data-[state=open]:text-sidebar-accent-foreground"
            onClick={() => createOrganization()}
          >
            <div className="bg-sidebar-primary text-sidebar-primary-foreground flex aspect-square size-8 items-center justify-center rounded-lg">
              <Building2 className="size-4" />
            </div>
            <div className="grid flex-1 text-left text-sm leading-tight">
              <span className="truncate font-medium">Create Organization</span>
              <span className="truncate text-xs">Get started</span>
            </div>
          </SidebarMenuButton>
        </SidebarMenuItem>
      </SidebarMenu>
    );
  }

  return (
    <SidebarMenu>
      <SidebarMenuItem>
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <SidebarMenuButton
              size="lg"
              className="data-[state=open]:bg-sidebar-accent data-[state=open]:text-sidebar-accent-foreground"
            >
              <Avatar className="size-8 rounded-lg">
                <AvatarImage src={activeOrganization.imageUrl} alt={activeOrganization.name} />
                <AvatarFallback className="rounded-lg bg-sidebar-primary text-sidebar-primary-foreground">
                  {activeOrganization.name
                    .split(" ")
                    .map((n) => n[0])
                    .join("")
                    .toUpperCase() || "O"}
                </AvatarFallback>
              </Avatar>
              <div className="grid flex-1 text-left text-sm leading-tight">
                <span className="truncate font-medium">{activeOrganization.name}</span>
                <span className="truncate text-xs">
                  {userMemberships?.data?.find(m => m.organization.id === activeOrganization.id)?.role || "Member"}
                </span>
              </div>
              <ChevronsUpDown className="ml-auto" />
            </SidebarMenuButton>
          </DropdownMenuTrigger>
          <DropdownMenuContent
            className="w-[--radix-dropdown-menu-trigger-width] min-w-56 rounded-lg"
            align="start"
            side={isMobile ? "bottom" : "right"}
            sideOffset={4}
          >
            <DropdownMenuLabel className="text-xs text-muted-foreground">
              Organizations
            </DropdownMenuLabel>
            {userMemberships?.data?.map((membership, index) => (
              <DropdownMenuItem
                key={membership.organization.id}
                onClick={() => setActive({ organization: membership.organization })}
                className="gap-2 p-2"
              >
                <Avatar className="size-6 rounded-md">
                  <AvatarImage src={membership.organization.imageUrl} alt={membership.organization.name} />
                  <AvatarFallback className="rounded-md text-xs">
                    {membership.organization.name
                      .split(" ")
                      .map((n) => n[0])
                      .join("")
                      .toUpperCase() || "O"}
                  </AvatarFallback>
                </Avatar>
                {membership.organization.name}
              </DropdownMenuItem>
            ))}
            <DropdownMenuSeparator />
            <DropdownMenuItem 
              className="gap-2 p-2"
              onClick={() => createOrganization()}
            >
              <div className="flex size-6 items-center justify-center rounded-md border bg-transparent">
                <Building2 className="size-4" />
              </div>
              <div className="font-medium text-muted-foreground">Create organization</div>
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </SidebarMenuItem>
    </SidebarMenu>
  );
}
