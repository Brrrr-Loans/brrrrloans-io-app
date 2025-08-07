"use client";

import { useState, useEffect } from "react";
import { createClientComponentClient } from "@supabase/auth-helpers-nextjs";
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
import { Button } from "@/components/ui";
import { Download, FileText } from "lucide-react";
import { format } from "date-fns";
import type { InvestorStatement } from "@/types/investor-statements";
import { Skeleton } from "@/components/ui/feedback/skeleton";

interface InvestorStatementsListProps {
  investorId?: number;
  orgId?: string;
}

export function InvestorStatementsList({
  investorId,
  orgId,
}: InvestorStatementsListProps) {
  const [statements, setStatements] = useState<InvestorStatement[]>([]);
  const [organizations, setOrganizations] = useState<{ [key: string]: string }>(
    {}
  );
  const [loading, setLoading] = useState(true);
  const supabase = createClientComponentClient();

  useEffect(() => {
    fetchStatements();
    fetchOrganizations();
  }, [investorId, orgId]);

  async function fetchOrganizations() {
    try {
      const { data, error } = await supabase
        .from("clerk_organizations")
        .select("id, name");

      if (error) throw error;

      // Create a map of org IDs to names for easy lookup
      const orgMap: { [key: string]: string } = {};
      data?.forEach((org) => {
        orgMap[org.id] = org.name;
      });

      setOrganizations(orgMap);
    } catch (error) {
      console.error("Error fetching organizations:", error);
    }
  }

  async function fetchStatements() {
    try {
      setLoading(true);
      const params = new URLSearchParams();

      if (investorId) {
        params.append("investorId", investorId.toString());
      }

      if (orgId) {
        params.append("orgId", orgId);
      }

      const response = await fetch(
        `/api/investor-statements?${params.toString()}`
      );
      if (!response.ok) {
        throw new Error("Failed to fetch statements");
      }

      const data = await response.json();
      setStatements(data.statements || []);
    } catch (error) {
      console.error("Error fetching statements:", error);
    } finally {
      setLoading(false);
    }
  }

  const handleDownload = async (statement: InvestorStatement) => {
    try {
      // If we have a file_path, use it to download from Supabase storage
      if (statement.file_path) {
        const { data, error } = await supabase.storage
          .from("investor-statements")
          .download(statement.file_path);

        if (error) {
          console.error("Error downloading file:", error);
          return;
        }

        // Create a download link
        const fileName = statement.file_name || `statement-${statement.id}.pdf`;
        const url = window.URL.createObjectURL(data);
        const link = document.createElement("a");
        link.href = url;
        link.download = fileName;
        document.body.appendChild(link);
        link.click();
        link.remove();
        window.URL.revokeObjectURL(url);
      } else {
        console.error("No file path available for download");
      }
    } catch (error) {
      console.error("Error downloading statement:", error);
    }
  };

  const formatCurrency = (amount: number | null) => {
    if (amount === null) return "N/A";
    return new Intl.NumberFormat("en-US", {
      style: "currency",
      currency: "USD",
    }).format(amount);
  };

  const formatDate = (dateString: string) => {
    return format(new Date(dateString), "MMM d, yyyy");
  };

  // Get organization name for display
  const getOrganizationName = (statement: InvestorStatement) => {
    if (!statement.org_id) return "Individual";
    return organizations[statement.org_id] || statement.org_id;
  };

  if (loading) {
    return (
      <Card>
        <CardHeader>
          <CardTitle>Investor Statements</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-2">
            <Skeleton className="h-10 w-full" />
            <Skeleton className="h-10 w-full" />
            <Skeleton className="h-10 w-full" />
          </div>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle>Investor Statements</CardTitle>
      </CardHeader>
      <CardContent>
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead>Statement Date</TableHead>
              <TableHead>Period</TableHead>
              <TableHead>Type</TableHead>
              <TableHead>Interest</TableHead>
              <TableHead>Principal</TableHead>
              <TableHead>Fees</TableHead>
              <TableHead>Total UPB</TableHead>
              <TableHead>Actions</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {statements.map((statement) => (
              <TableRow key={statement.id}>
                <TableCell>{formatDate(statement.statement_date)}</TableCell>
                <TableCell>
                  {formatDate(statement.statement_period_start)} -{" "}
                  {formatDate(statement.statement_period_end)}
                </TableCell>
                <TableCell>{getOrganizationName(statement)}</TableCell>
                <TableCell>
                  {formatCurrency(statement.total_interest)}
                </TableCell>
                <TableCell>
                  {formatCurrency(statement.total_principal)}
                </TableCell>
                <TableCell>{formatCurrency(statement.total_fees)}</TableCell>
                <TableCell>
                  {formatCurrency(statement.total_upb_close)}
                </TableCell>
                <TableCell>
                  <Button
                    variant="ghost"
                    size="sm"
                    onClick={() => handleDownload(statement)}
                    disabled={!statement.file_path}
                  >
                    <Download className="h-4 w-4 mr-2" />
                    Download
                  </Button>
                </TableCell>
              </TableRow>
            ))}
            {statements.length === 0 && (
              <TableRow>
                <TableCell colSpan={8} className="text-center">
                  No statements available
                </TableCell>
              </TableRow>
            )}
          </TableBody>
        </Table>
      </CardContent>
    </Card>
  );
}
