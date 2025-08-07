"use client";

import { useState, useEffect } from "react";
import { createClientComponentClient } from "@supabase/auth-helpers-nextjs";
import { withInvestorPermission } from "@/components/auth/with-investor-permission";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@/components/ui/layout/card";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/data/table";
import { Badge } from "@/components/ui/feedback/badge";
import { Button } from "@/components/ui";
import { useRouter } from "next/navigation";
import type { Database } from "@/types/supabase";

interface Deal {
  id: number;
  deal_name: string | null;
  // Add more fields from the deal table as needed
}

function UnprotectedActiveDealsList() {
  const [deals, setDeals] = useState<Deal[]>([]);
  const [loading, setLoading] = useState(true);
  const router = useRouter();
  const supabase = createClientComponentClient<Database>();

  useEffect(() => {
    async function fetchDeals() {
      // First, get all deal_ids for this investor
      const { data: investorDeals, error: investorDealsError } = await supabase
        .from("bsi_deals")
        .select("deal_id");

      if (investorDealsError || !investorDeals) {
        setDeals([]);
        setLoading(false);
        return;
      }

      const dealIds = investorDeals.map((d) => d.deal_id);
      if (dealIds.length === 0) {
        setDeals([]);
        setLoading(false);
        return;
      }

      // Now, fetch deal details for these deal_ids
      const { data: dealsData, error: dealsError } = await supabase
        .from("deal")
        .select("id, deal_name")
        .in("id", dealIds);

      if (dealsError || !dealsData) {
        setDeals([]);
        setLoading(false);
        return;
      }

      setDeals(dealsData);
      setLoading(false);
    }

    fetchDeals();
  }, []);

  if (loading) {
    return <div>Loading active deals...</div>;
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle>Active Deals</CardTitle>
      </CardHeader>
      <CardContent>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Deal Name</TableHead>
              {/* Add more columns as needed */}
              <TableHead>Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {deals.map((deal) => (
              <TableRow key={deal.id}>
                <TableCell className="font-medium">
                  {deal.deal_name ?? ""}
                </TableCell>
                {/* Add more cells as needed */}
                <TableCell>
                  <Button
                    variant="ghost"
                    size="sm"
                    onClick={() => router.push(`/dashboard/deals/${deal.id}`)}
                  >
                    View Details
                  </Button>
                </TableCell>
              </TableRow>
            ))}
            {deals.length === 0 && (
              <TableRow>
                <TableCell colSpan={2} className="text-center">
                  No active deals found
                </TableCell>
              </TableRow>
            )}
          </TableBody>
        </Table>
      </CardContent>
    </Card>
  );
}

// Create a permission-protected version of ActiveDealsList
export const ProtectedActiveDealsList = withInvestorPermission(
  UnprotectedActiveDealsList
);

// Usage example:
export function ActiveDealsListWrapper() {
  return (
    <ProtectedActiveDealsList
      resourceType="deal"
      resourceId="all" // Special case for viewing all deals
      fallback={
        <Card>
          <CardHeader>
            <CardTitle>Active Deals</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-center text-muted-foreground">
              You don't have permission to view active deals.
            </div>
          </CardContent>
        </Card>
      }
    />
  );
}
