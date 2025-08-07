import { test, expect } from "@playwright/test";
import { visitDashboard, testIds } from "../utils";

test.describe("Sidebar UI", () => {
  test("renders Clerk components", async ({ page }) => {
    await visitDashboard(page);
    await expect(page.getByTestId(testIds.orgSwitcher)).toBeVisible();
    await expect(page.getByTestId(testIds.userButton)).toBeVisible();
  });

  test("redirects unauthenticated user to sign-in page", async ({ page }) => {
    await page.context().clearCookies();
    await page.goto("/dashboard");
    await expect(page).toHaveURL(/.*sign-in.*/);
  });
});
