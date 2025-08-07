"use client";

import { useState } from "react";
import { SiteHeader } from "@/components/layout/site-header";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
  CardFooter,
} from "@/components/ui";
import { Button } from "@/components/ui";
import { Input } from "@/components/ui";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui";
import { DatePicker } from "@/components/ui";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui";
import { Download, FileText, Filter, Printer } from "lucide-react";

const reports = [
  {
    id: "REP-001",
    name: "Monthly Investor Statement",
    description:
      "Detailed statement of investor returns and portfolio performance",
    lastGenerated: "2024-04-30",
    frequency: "Monthly",
  },
  {
    id: "REP-002",
    name: "Quarterly Financial Report",
    description:
      "Comprehensive financial report with balance sheets and cash flow statements",
    lastGenerated: "2024-03-31",
    frequency: "Quarterly",
  },
  {
    id: "REP-003",
    name: "Annual Tax Documents",
    description: "Tax documents for investors including K-1 forms",
    lastGenerated: "2023-12-31",
    frequency: "Annually",
  },
  {
    id: "REP-004",
    name: "Deal Performance Summary",
    description: "Performance metrics for all active deals",
    lastGenerated: "2024-04-15",
    frequency: "Monthly",
  },
  {
    id: "REP-005",
    name: "Distribution Report",
    description: "Summary of all distributions made to investors",
    lastGenerated: "2024-04-30",
    frequency: "Monthly",
  },
];

export default function ReportsPage() {
  const [searchTerm, setSearchTerm] = useState("");
  const [startDate, setStartDate] = useState(null);
  const [endDate, setEndDate] = useState(null);

  return (
    <>
      <SiteHeader />
      <div className="@container/main flex flex-1 flex-col gap-2">
        <div className="flex flex-col gap-4 py-4 md:gap-6 md:py-6 px-4 lg:px-6">
          <div className="flex items-center justify-between">
            <h1 className="text-2xl font-bold tracking-tight">Reports</h1>
            <Button>
              <FileText className="mr-2 h-4 w-4" />
              Generate New Report
            </Button>
          </div>

          <Card>
            <CardHeader>
              <CardTitle>Custom Report Generator</CardTitle>
              <CardDescription>
                Create custom reports for specific date ranges and metrics
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
                <div className="space-y-2">
                  <label className="text-sm font-medium">Report Type</label>
                  <Select defaultValue="investor">
                    <SelectTrigger>
                      <SelectValue placeholder="Select report type" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="investor">
                        Investor Statement
                      </SelectItem>
                      <SelectItem value="financial">
                        Financial Report
                      </SelectItem>
                      <SelectItem value="performance">
                        Performance Summary
                      </SelectItem>
                      <SelectItem value="distribution">
                        Distribution Report
                      </SelectItem>
                    </SelectContent>
                  </Select>
                </div>

                <div className="space-y-2">
                  <label className="text-sm font-medium">Start Date</label>
                  <DatePicker date={startDate} setDate={setStartDate} />
                </div>

                <div className="space-y-2">
                  <label className="text-sm font-medium">End Date</label>
                  <DatePicker date={endDate} setDate={setEndDate} />
                </div>

                <div className="space-y-2">
                  <label className="text-sm font-medium">Format</label>
                  <Select defaultValue="pdf">
                    <SelectTrigger>
                      <SelectValue placeholder="Select format" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="pdf">PDF</SelectItem>
                      <SelectItem value="excel">Excel</SelectItem>
                      <SelectItem value="csv">CSV</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>
            </CardContent>
            <CardFooter className="flex justify-end gap-2">
              <Button variant="outline">
                <Filter className="mr-2 h-4 w-4" />
                Additional Filters
              </Button>
              <Button>
                <FileText className="mr-2 h-4 w-4" />
                Generate Report
              </Button>
            </CardFooter>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>Available Reports</CardTitle>
              <CardDescription>
                Standard reports that can be generated or scheduled
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="flex items-center gap-2 mb-4">
                <Input
                  placeholder="Search reports..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="max-w-sm"
                />
                <Select defaultValue="all">
                  <SelectTrigger className="w-[180px]">
                    <SelectValue placeholder="Filter by frequency" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All Frequencies</SelectItem>
                    <SelectItem value="monthly">Monthly</SelectItem>
                    <SelectItem value="quarterly">Quarterly</SelectItem>
                    <SelectItem value="annually">Annually</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>ID</TableHead>
                    <TableHead>Name</TableHead>
                    <TableHead>Description</TableHead>
                    <TableHead>Last Generated</TableHead>
                    <TableHead>Frequency</TableHead>
                    <TableHead className="text-right">Actions</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {reports
                    .filter(
                      (report) =>
                        report.name
                          .toLowerCase()
                          .includes(searchTerm.toLowerCase()) ||
                        report.id
                          .toLowerCase()
                          .includes(searchTerm.toLowerCase()) ||
                        report.description
                          .toLowerCase()
                          .includes(searchTerm.toLowerCase())
                    )
                    .map((report) => (
                      <TableRow key={report.id}>
                        <TableCell className="font-medium">
                          {report.id}
                        </TableCell>
                        <TableCell>{report.name}</TableCell>
                        <TableCell>{report.description}</TableCell>
                        <TableCell>
                          {new Date(report.lastGenerated).toLocaleDateString()}
                        </TableCell>
                        <TableCell>{report.frequency}</TableCell>
                        <TableCell className="text-right">
                          <div className="flex justify-end gap-2">
                            <Button variant="ghost" size="icon">
                              <Download className="h-4 w-4" />
                              <span className="sr-only">Download</span>
                            </Button>
                            <Button variant="ghost" size="icon">
                              <Printer className="h-4 w-4" />
                              <span className="sr-only">Print</span>
                            </Button>
                          </div>
                        </TableCell>
                      </TableRow>
                    ))}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </div>
      </div>
    </>
  );
}
