"use client";

import { DashboardLayout } from "@/components/dashboard/layout";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui";
import { CreateDealForm } from "@/components/deals/create-deal-form";

export default function NewDealPage() {
  return (
    <DashboardLayout>
      <div className="flex flex-col gap-4">
        <div className="flex items-center justify-between">
          <h1 className="text-2xl font-bold tracking-tight">Create New Deal</h1>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>Deal Information</CardTitle>
            <CardDescription>
              Enter the details for the new investment deal
            </CardDescription>
          </CardHeader>
          <CardContent>
            <CreateDealForm />
          </CardContent>
        </Card>
      </div>
    </DashboardLayout>
  );
}
