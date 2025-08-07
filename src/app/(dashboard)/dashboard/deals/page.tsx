"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { RouteProtection } from "@/components/auth/route-protection";
import { SiteHeader } from "@/components/layout/site-header";
import {
  Card,
  CardContent,
  CardDescription,
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
import { Button } from "@/components/ui/forms/button";
import { Input } from "@/components/ui/forms/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/forms/select";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/overlays/dialog";
import { Eye, Download, Plus } from "lucide-react";
import { DealDetails } from "@/components/deals/deal-details";
import { useDeals } from "@/hooks/use-deals";
import type { Tables } from "@/types/supabase";

function DealsPageContent() {
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedType, setSelectedType] = useState("all");
  const [selectedStatus, setSelectedStatus] = useState("all-status");
  const router = useRouter();

  // Use the custom hook to fetch deals
  const {
    deals: rawDeals,
    loading,
    error,
  } = useDeals({
    type: selectedType !== "all" ? selectedType : undefined,
    status: selectedStatus !== "all-status" ? selectedStatus : undefined,
    search: searchTerm || undefined,
  });

  // The API returns: (Tables<"bsi_deals"> & { deal: Tables<"deal"> })[]
  // Map to a UI-friendly shape
  const deals: Array<{
    id: string | number;
    name: string;
    type: string;
    amount: string;
    roi: string;
    date: string;
    location: string;
    investors: string;
    status: string;
    raw: Tables<"bsi_deals"> & { deal: Tables<"deal"> };
  }> = (rawDeals || []).map((d) => {
    const dealObj = d.deal;
    return {
      id: dealObj.id ?? "",
      name: dealObj.deal_name ?? "",
      type: dealObj.deal_type ?? "",
      amount: dealObj.loan_amount_total?.toString() ?? "",
      roi: dealObj.note_rate?.toString() ?? "",
      date: dealObj.created_at ?? "",
      location: dealObj.property_id?.toString() ?? "",
      investors: "1", // Placeholder, update if you have investor count
      status: dealObj.deal_disposition_1 ?? "",
      raw: d,
    };
  });

  return (
    <>
      <SiteHeader />
      <div className="flex flex-col gap-4 py-4 md:gap-6 md:py-6 px-4 lg:px-6">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-3xl font-bold tracking-tight">Deals</h1>
            <p className="text-muted-foreground">
              Manage your investment deals and track their performance.
            </p>
          </div>
          <Button onClick={() => router.push("/dashboard/deals/new")}>
            <Plus className="mr-2 h-4 w-4" />
            New Deal
          </Button>
        </div>

        <div className="grid gap-4">
          <Card>
            <CardHeader>
              <CardTitle>Deal Portfolio</CardTitle>
              <CardDescription>
                View and manage all your investment deals.
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="flex flex-col sm:flex-row gap-4 mb-6">
                <Input
                  placeholder="Search deals..."
                  value={searchTerm}
                  onChange={(e: React.ChangeEvent<HTMLInputElement>) =>
                    setSearchTerm(e.target.value)
                  }
                  className="sm:max-w-xs"
                />
                <Select value={selectedType} onValueChange={setSelectedType}>
                  <SelectTrigger className="sm:max-w-xs">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All Types</SelectItem>
                    <SelectItem value="dscr">DSCR</SelectItem>
                    <SelectItem value="rtl">RTL</SelectItem>
                  </SelectContent>
                </Select>
                <Select
                  value={selectedStatus}
                  onValueChange={setSelectedStatus}
                >
                  <SelectTrigger className="sm:max-w-xs">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all-status">All Status</SelectItem>
                    <SelectItem value="active">Active</SelectItem>
                    <SelectItem value="pending">Pending</SelectItem>
                    <SelectItem value="closed">Closed</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              {loading ? (
                <div className="flex justify-center py-8">Loading deals...</div>
              ) : error ? (
                <div className="flex justify-center py-8 text-red-500">
                  Error loading deals: {error}
                </div>
              ) : deals.length === 0 ? (
                <div className="flex flex-col items-center justify-center py-8 text-center">
                  <p className="text-muted-foreground mb-4">No deals found</p>
                  <Button onClick={() => router.push("/dashboard/deals/new")}>
                    <Plus className="mr-2 h-4 w-4" />
                    Create Your First Deal
                  </Button>
                </div>
              ) : (
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>ID</TableHead>
                      <TableHead>Name</TableHead>
                      <TableHead>Type</TableHead>
                      <TableHead>Amount</TableHead>
                      <TableHead>ROI</TableHead>
                      <TableHead>Location</TableHead>
                      <TableHead>Investors</TableHead>
                      <TableHead>Status</TableHead>
                      <TableHead className="text-right">Actions</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {deals.map((deal) => (
                      <TableRow key={deal.id}>
                        <TableCell className="font-medium">{deal.id}</TableCell>
                        <TableCell>{deal.name}</TableCell>
                        <TableCell>
                          <Badge variant="outline">{deal.type}</Badge>
                        </TableCell>
                        <TableCell>${deal.amount}</TableCell>
                        <TableCell>{deal.roi}%</TableCell>
                        <TableCell>{deal.location}</TableCell>
                        <TableCell>{deal.investors}</TableCell>
                        <TableCell>
                          <Badge
                            variant={
                              deal.status === "active"
                                ? "default"
                                : deal.status === "pending"
                                ? "secondary"
                                : "outline"
                            }
                          >
                            {deal.status}
                          </Badge>
                        </TableCell>
                        <TableCell className="text-right">
                          <div className="flex justify-end gap-2">
                            <Dialog>
                              <DialogTrigger asChild>
                                <Button variant="ghost" size="sm">
                                  <Eye className="h-4 w-4" />
                                </Button>
                              </DialogTrigger>
                              <DialogContent className="sm:max-w-[600px]">
                                <DialogHeader>
                                  <DialogTitle>Deal Details</DialogTitle>
                                  <DialogDescription>
                                    View comprehensive details for {deal.name}
                                  </DialogDescription>
                                </DialogHeader>
                                <DealDetails
                                  deal={{
                                    name: deal.name,
                                    location: deal.location,
                                    type: deal.type,
                                    status: deal.status,
                                    amount: deal.amount,
                                    roi: deal.roi,
                                    date: deal.date,
                                    investors: deal.investors,
                                  }}
                                />
                              </DialogContent>
                            </Dialog>
                            <Button variant="ghost" size="sm">
                              <Download className="h-4 w-4" />
                            </Button>
                          </div>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              )}
            </CardContent>
          </Card>
        </div>
      </div>
    </>
  );
}

export default function DealsPage() {
  return (
    <RouteProtection
      requiredContactTypes={[
        "Balance Sheet Investor",
        "Lender",
        "Borrower",
        "Broker",
        "Point of Contact",
      ]}
      requiredPermissions={["canAccessDeals"]}
    >
      <DealsPageContent />
    </RouteProtection>
  );
}
