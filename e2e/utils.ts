import { Page } from "@playwright/test";

export const testIds = {
  orgSwitcher: "org-switcher",
  userButton: "user-button",
};

export async function visitDashboard(page: Page) {
  await page.goto("/dashboard");
}
