"use client";

import { useState, useEffect } from "react";
import { createClientComponentClient } from "@supabase/auth-helpers-nextjs";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@/components/ui/layout/card";
import { Button } from "@/components/ui/forms/button";
import { Input } from "@/components/ui/forms/input";
import { Label } from "@/components/ui/forms/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/forms/select";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/data/table";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
  DialogFooter,
  DialogClose,
} from "@/components/ui/overlays/dialog";
import {
  CalendarIcon,
  Download,
  FileText,
  Plus,
  Trash,
  Upload,
  Loader2,
  Search,
} from "lucide-react";
import { format } from "date-fns";
import type { InvestorStatement } from "@/types/investor-statements";
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/forms/form";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import * as z from "zod";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/overlays/popover";
import { Calendar } from "@/components/ui/forms/calendar";
import { cn } from "@/lib/utils";
import { useToast } from "@/hooks/use-toast";

interface Investor {
  id: number;
  first_name: string;
  last_name: string;
}

interface Organization {
  id: string;
  name: string;
}

const formSchema = z.object({
  investorId: z.string().min(1, "Investor is required"),
  orgId: z.string().optional(),
  statementDate: z.date({ required_error: "Statement date is required" }),
  periodStart: z.date({ required_error: "Period start date is required" }),
  periodEnd: z.date({ required_error: "Period end date is required" }),
  totalUpbOpen: z.coerce.number().min(0, "Amount must be positive"),
  totalUpbClose: z.coerce.number().min(0, "Amount must be positive"),
  totalInterest: z.coerce.number().min(0, "Amount must be positive"),
  totalPrincipal: z.coerce.number().min(0, "Amount must be positive"),
  statementFile: z.instanceof(File).optional(),
});

export function InvestorStatementsAdmin() {
  const [statements, setStatements] = useState<InvestorStatement[]>([]);
  const [investors, setInvestors] = useState<Investor[]>([]);
  const [organizations, setOrganizations] = useState<Organization[]>([]);
  const [loading, setLoading] = useState(true);
  const [uploading, setUploading] = useState(false);
  const [open, setOpen] = useState(false);
  const supabase = createClientComponentClient();

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      totalUpbOpen: 0,
      totalUpbClose: 0,
      totalInterest: 0,
      totalPrincipal: 0,
    },
  });

  useEffect(() => {
    fetchStatements();
    fetchInvestors();
    fetchOrganizations();
  }, []);

  async function fetchStatements() {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from("bsi_statements")
        .select("*")
        .order("statement_date", { ascending: false });

      if (error) throw error;
      setStatements(data || []);
    } catch (error) {
      console.error("Error fetching statements:", error);
    } finally {
      setLoading(false);
    }
  }

  async function fetchInvestors() {
    try {
      const { data, error } = await supabase
        .from("contact")
        .select("id, first_name, last_name")
        .eq("contact_types_id", 12) // Balance Sheet Investor type ID
        .order("last_name");

      if (error) throw error;
      setInvestors(data || []);
    } catch (error) {
      console.error("Error fetching investors:", error);
    }
  }

  async function fetchOrganizations() {
    try {
      const { data, error } = await supabase
        .from("clerk_organizations")
        .select("id, name")
        .order("name");

      if (error) throw error;
      setOrganizations(data || []);
    } catch (error) {
      console.error("Error fetching organizations:", error);
    }
  }

  const handleDownload = async (statement: InvestorStatement) => {
    try {
      if (statement.file_path) {
        const { data, error } = await supabase.storage
          .from("investor-statements")
          .download(statement.file_path);

        if (error) {
          console.error("Error downloading file:", error);
          return;
        }

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

  const handleDelete = async (id: number) => {
    if (!confirm("Are you sure you want to delete this statement?")) return;

    try {
      const statement = statements.find((s) => s.id === id);

      // Delete the file from storage if it exists
      if (statement?.file_path) {
        await supabase.storage
          .from("investor-statements")
          .remove([statement.file_path]);
      }

      // Delete the statement record
      const { error } = await supabase
        .from("bsi_statements")
        .delete()
        .eq("id", id);

      if (error) throw error;

      toast({
        title: "Statement deleted",
        description: "The investor statement has been deleted successfully.",
      });

      // Refresh the statements list
      fetchStatements();
    } catch (error) {
      console.error("Error deleting statement:", error);
      toast({
        variant: "destructive",
        title: "Error",
        description: "Failed to delete the statement.",
      });
    }
  };

  const onSubmit = async (values: z.infer<typeof formSchema>) => {
    try {
      setUploading(true);

      const file = values.statementFile;
      let filePath = null;
      let fileName = null;
      let fileType = null;
      let fileSize = null;
      let fileUrl = null;

      // Upload file to Supabase Storage if provided
      if (file) {
        const timestamp = Date.now();
        fileName = file.name;
        fileType = file.type;
        fileSize = file.size;

        // Set the file path based on whether it's for an individual investor or organization
        if (values.orgId) {
          // For organization statements, use org_{org_id}/ prefix
          filePath = `org_${values.orgId}/${timestamp}_${fileName}`;
        } else {
          // For individual investor statements
          filePath = `${values.investorId}/${timestamp}_${fileName}`;
        }

        const { data: uploadData, error: uploadError } = await supabase.storage
          .from("investor-statements")
          .upload(filePath, file);

        if (uploadError) throw uploadError;

        // Get the public URL
        const { data: urlData } = await supabase.storage
          .from("investor-statements")
          .getPublicUrl(filePath);

        fileUrl = urlData.publicUrl;
      }

      // Insert statement record in the database
      const { data, error } = await supabase
        .from("bsi_statements")
        .insert({
          investor_id: parseInt(values.investorId),
          org_id: values.orgId || null,
          statement_date: values.statementDate.toISOString(),
          statement_period_start: values.periodStart.toISOString(),
          statement_period_end: values.periodEnd.toISOString(),
          total_upb_open: values.totalUpbOpen,
          total_upb_close: values.totalUpbClose,
          total_interest: values.totalInterest,
          total_principal: values.totalPrincipal,
          file_path: filePath,
          file_name: fileName,
          file_type: fileType,
          file_size: fileSize,
          file_url: fileUrl,
          uploaded_at: new Date().toISOString(),
        })
        .select();

      if (error) throw error;

      toast({
        title: "Statement created",
        description: "The investor statement has been created successfully.",
      });

      // Close the dialog and refresh the statements list
      setOpen(false);
      form.reset();
      fetchStatements();
    } catch (error) {
      console.error("Error creating statement:", error);
      toast({
        variant: "destructive",
        title: "Error",
        description: "Failed to create the statement.",
      });
    } finally {
      setUploading(false);
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

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h2 className="text-2xl font-bold">Investor Statements Management</h2>

        <Dialog open={open} onOpenChange={setOpen}>
          <DialogTrigger asChild>
            <Button>
              <Plus className="h-4 w-4 mr-2" />
              New Statement
            </Button>
          </DialogTrigger>
          <DialogContent className="max-w-2xl">
            <DialogHeader>
              <DialogTitle>Create New Investor Statement</DialogTitle>
            </DialogHeader>

            <Form {...form}>
              <form
                onSubmit={form.handleSubmit(onSubmit)}
                className="space-y-6"
              >
                <div className="grid grid-cols-2 gap-4">
                  <FormField
                    control={form.control}
                    name="investorId"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Investor</FormLabel>
                        <Select
                          onValueChange={field.onChange}
                          defaultValue={field.value}
                        >
                          <FormControl>
                            <SelectTrigger>
                              <SelectValue placeholder="Select an investor" />
                            </SelectTrigger>
                          </FormControl>
                          <SelectContent>
                            {investors.map((investor) => (
                              <SelectItem
                                key={investor.id}
                                value={investor.id.toString()}
                              >
                                {investor.last_name}, {investor.first_name}
                              </SelectItem>
                            ))}
                          </SelectContent>
                        </Select>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="orgId"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Organization (Optional)</FormLabel>
                        <Select
                          onValueChange={field.onChange}
                          defaultValue={field.value}
                        >
                          <FormControl>
                            <SelectTrigger>
                              <SelectValue placeholder="Select organization (optional)" />
                            </SelectTrigger>
                          </FormControl>
                          <SelectContent>
                            <SelectItem value="">
                              Individual Investor
                            </SelectItem>
                            {organizations.map((org) => (
                              <SelectItem key={org.id} value={org.id}>
                                {org.name}
                              </SelectItem>
                            ))}
                          </SelectContent>
                        </Select>
                        <FormDescription>
                          If this statement is for an organization, select it
                          here
                        </FormDescription>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                </div>

                <div className="grid grid-cols-2 gap-4">
                  <FormField
                    control={form.control}
                    name="statementDate"
                    render={({ field }) => (
                      <FormItem className="flex flex-col">
                        <FormLabel>Statement Date</FormLabel>
                        <Popover>
                          <PopoverTrigger asChild>
                            <FormControl>
                              <Button
                                variant={"outline"}
                                className={cn(
                                  "pl-3 text-left font-normal",
                                  !field.value && "text-muted-foreground"
                                )}
                              >
                                {field.value ? (
                                  format(field.value, "PPP")
                                ) : (
                                  <span>Pick a date</span>
                                )}
                                <CalendarIcon className="ml-auto h-4 w-4 opacity-50" />
                              </Button>
                            </FormControl>
                          </PopoverTrigger>
                          <PopoverContent className="w-auto p-0" align="start">
                            <Calendar
                              mode="single"
                              selected={field.value}
                              onSelect={field.onChange}
                              initialFocus
                            />
                          </PopoverContent>
                        </Popover>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                </div>

                <div className="grid grid-cols-2 gap-4">
                  <FormField
                    control={form.control}
                    name="periodStart"
                    render={({ field }) => (
                      <FormItem className="flex flex-col">
                        <FormLabel>Period Start</FormLabel>
                        <Popover>
                          <PopoverTrigger asChild>
                            <FormControl>
                              <Button
                                variant={"outline"}
                                className={cn(
                                  "pl-3 text-left font-normal",
                                  !field.value && "text-muted-foreground"
                                )}
                              >
                                {field.value ? (
                                  format(field.value, "PPP")
                                ) : (
                                  <span>Pick a date</span>
                                )}
                                <CalendarIcon className="ml-auto h-4 w-4 opacity-50" />
                              </Button>
                            </FormControl>
                          </PopoverTrigger>
                          <PopoverContent className="w-auto p-0" align="start">
                            <Calendar
                              mode="single"
                              selected={field.value}
                              onSelect={field.onChange}
                              initialFocus
                            />
                          </PopoverContent>
                        </Popover>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="periodEnd"
                    render={({ field }) => (
                      <FormItem className="flex flex-col">
                        <FormLabel>Period End</FormLabel>
                        <Popover>
                          <PopoverTrigger asChild>
                            <FormControl>
                              <Button
                                variant={"outline"}
                                className={cn(
                                  "pl-3 text-left font-normal",
                                  !field.value && "text-muted-foreground"
                                )}
                              >
                                {field.value ? (
                                  format(field.value, "PPP")
                                ) : (
                                  <span>Pick a date</span>
                                )}
                                <CalendarIcon className="ml-auto h-4 w-4 opacity-50" />
                              </Button>
                            </FormControl>
                          </PopoverTrigger>
                          <PopoverContent className="w-auto p-0" align="start">
                            <Calendar
                              mode="single"
                              selected={field.value}
                              onSelect={field.onChange}
                              initialFocus
                            />
                          </PopoverContent>
                        </Popover>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                </div>

                <div className="grid grid-cols-3 gap-4">
                  <FormField
                    control={form.control}
                    name="totalUpbOpen"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Opening UPB</FormLabel>
                        <FormControl>
                          <Input type="number" step="0.01" min="0" {...field} />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="totalUpbClose"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Closing UPB</FormLabel>
                        <FormControl>
                          <Input type="number" step="0.01" min="0" {...field} />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="totalInterest"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Interest</FormLabel>
                        <FormControl>
                          <Input type="number" step="0.01" min="0" {...field} />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />

                  <FormField
                    control={form.control}
                    name="totalPrincipal"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Principal</FormLabel>
                        <FormControl>
                          <Input type="number" step="0.01" min="0" {...field} />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                </div>

                <FormField
                  control={form.control}
                  name="statementFile"
                  render={({ field: { value, onChange, ...fieldProps } }) => (
                    <FormItem>
                      <FormLabel>Statement PDF</FormLabel>
                      <FormControl>
                        <Input
                          type="file"
                          accept=".pdf"
                          onChange={(e) => {
                            const file = e.target.files?.[0];
                            if (file) {
                              onChange(file);
                            }
                          }}
                          {...fieldProps}
                        />
                      </FormControl>
                      <FormDescription>
                        Upload a PDF version of the statement
                      </FormDescription>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <DialogFooter>
                  <Button type="submit" disabled={uploading}>
                    {uploading ? "Uploading..." : "Create Statement"}
                  </Button>
                </DialogFooter>
              </form>
            </Form>
          </DialogContent>
        </Dialog>
      </div>

      <Card>
        <CardContent className="pt-6">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Investor</TableHead>
                <TableHead>Organization</TableHead>
                <TableHead>Statement Date</TableHead>
                <TableHead>Period</TableHead>
                <TableHead>Interest</TableHead>
                <TableHead>Principal</TableHead>
                <TableHead>Total UPB</TableHead>
                <TableHead>File</TableHead>
                <TableHead>Actions</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {statements.map((statement) => {
                const investor = investors.find(
                  (i) => i.id === statement.investor_id
                );
                const investorName = investor
                  ? `${investor.last_name}, ${investor.first_name}`
                  : `Investor #${statement.investor_id}`;

                return (
                  <TableRow key={statement.id}>
                    <TableCell>{investorName}</TableCell>
                    <TableCell>
                      {statement.org_id
                        ? organizations.find((o) => o.id === statement.org_id)
                            ?.name || statement.org_id
                        : "Individual"}
                    </TableCell>
                    <TableCell>
                      {formatDate(statement.statement_date)}
                    </TableCell>
                    <TableCell>
                      {formatDate(statement.statement_period_start)} -{" "}
                      {formatDate(statement.statement_period_end)}
                    </TableCell>
                    <TableCell>
                      {formatCurrency(statement.total_interest)}
                    </TableCell>
                    <TableCell>
                      {formatCurrency(statement.total_principal)}
                    </TableCell>
                    <TableCell>
                      {formatCurrency(statement.total_upb_close)}
                    </TableCell>
                    <TableCell>
                      {statement.file_path ? (
                        <span className="flex items-center">
                          <FileText className="h-4 w-4 mr-2" />
                          {statement.file_name || "Statement PDF"}
                        </span>
                      ) : (
                        <span className="text-muted-foreground">No file</span>
                      )}
                    </TableCell>
                    <TableCell>
                      <div className="flex space-x-2">
                        {statement.file_path && (
                          <Button
                            variant="ghost"
                            size="sm"
                            onClick={() => handleDownload(statement)}
                          >
                            <Download className="h-4 w-4" />
                          </Button>
                        )}
                        <Button
                          variant="ghost"
                          size="sm"
                          className="text-red-500 hover:text-red-700"
                          onClick={() => handleDelete(statement.id)}
                        >
                          <Trash className="h-4 w-4" />
                        </Button>
                      </div>
                    </TableCell>
                  </TableRow>
                );
              })}
              {statements.length === 0 && (
                <TableRow>
                  <TableCell colSpan={8} className="text-center">
                    {loading ? "Loading statements..." : "No statements found"}
                  </TableCell>
                </TableRow>
              )}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </div>
  );
}
