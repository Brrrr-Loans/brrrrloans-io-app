"use client";

import * as React from "react";
import { usePathname } from "next/navigation";
import { useUser } from "@clerk/nextjs";
import {
  Building,
  Home,
  FileBarChart2,
  LineChart,
  CircleDollarSign,
} from "lucide-react";
import { NavAI } from "./nav-ai";
import { NavMain } from "./nav-main";
import { NavDocuments } from "./nav-documents";
import { NavUser } from "./nav-user";
import { TeamSwitcher } from "./team-switcher";

import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarHeader,
} from "@/components/ui/sidebar";

export function AppSidebar(
  props: React.ComponentPropsWithoutRef<typeof Sidebar>
) {
  const pathname = usePathname();
  const { user } = useUser();

  const mainNavItems = [
    {
      title: "Dashboard",
      url: "/dashboard",
      icon: Home,
      isActive: pathname === "/dashboard",
    },
    {
      title: "Deals",
      url: "/dashboard/deals",
      icon: Building,
      isActive: pathname.startsWith("/dashboard/deals"),
    },
    {
      title: "Distributions",
      url: "/dashboard/distributions",
      icon: CircleDollarSign,
      isActive: pathname.startsWith("/dashboard/distributions"),
    },
  ];

  const documentItems = [
    {
      name: "Statements",
      url: "/dashboard/documents",
      icon: FileBarChart2,
    },
    {
      name: "Reports",
      url: "/dashboard/reports",
      icon: LineChart,
    },
  ];

  // Prepare user data for NavUser component
  const userData = user
    ? {
        name: user.fullName || user.firstName || "User",
        email: user.primaryEmailAddress?.emailAddress || "user@example.com",
        avatar: user.imageUrl || "/default-avatar.png",
      }
    : {
        name: "Loading...",
        email: "",
        avatar: "/default-avatar.png",
      };

  return (
    <Sidebar collapsible="offcanvas" variant="inset" {...props}>
      <SidebarHeader>
        <TeamSwitcher />
      </SidebarHeader>
      <SidebarContent>
        <NavAI />
        <NavMain items={mainNavItems} />
        <NavDocuments items={documentItems} />
      </SidebarContent>
      <SidebarFooter>
        <NavUser user={userData} />
      </SidebarFooter>
    </Sidebar>
  );
}
