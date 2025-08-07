"use client";

import { DashboardLayout } from "@/components/dashboard/layout";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui";
import { CreateDistributionForm } from "@/components/distributions/create-distribution-form";

export default function NewDistributionPage() {
  return (
    <DashboardLayout>
      <div className="flex flex-col gap-4">
        <div className="flex items-center justify-between">
          <h1 className="text-2xl font-bold tracking-tight">
            Create New Distribution
          </h1>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>Distribution Information</CardTitle>
            <CardDescription>
              Enter the details for the new investor distribution
            </CardDescription>
          </CardHeader>
          <CardContent>
            <CreateDistributionForm />
          </CardContent>
        </Card>
      </div>
    </DashboardLayout>
  );
}
