"use client";

import { OpenAIIcon } from "@/components/assets/openai-icon";

import {
  SidebarGroup,
  SidebarGroupContent,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from "@/components/ui/sidebar";

export function NavAI() {
  return (
    <SidebarGroup>
      <SidebarGroupContent>
        <SidebarMenu>
          <SidebarMenuItem>
            <SidebarMenuButton
              tooltip="Ask AI"
              className="rounded-md bg-primary text-white hover:bg-primary/90 hover:text-white active:bg-primary/90 active:text-white dark:text-black dark:hover:text-black dark:active:text-black min-w-8 duration-200 ease-linear"
            >
              <OpenAIIcon size={20} />
              <span>Ask AI</span>
            </SidebarMenuButton>
          </SidebarMenuItem>
        </SidebarMenu>
      </SidebarGroupContent>
    </SidebarGroup>
  );
}
