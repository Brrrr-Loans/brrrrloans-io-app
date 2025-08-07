"use client";

import * as React from "react";
import { useState, useEffect } from "react";
import { createClientComponentClient } from "@supabase/auth-helpers-nextjs";
import {
  ColumnDef,
  ColumnFiltersState,
  SortingState,
  VisibilityState,
  flexRender,
  getCoreRowModel,
  getFilteredRowModel,
  getPaginationRowModel,
  getSortedRowModel,
  useReactTable,
  ColumnOrderState,
} from "@tanstack/react-table";
import {
  DndContext,
  KeyboardSensor,
  MouseSensor,
  TouchSensor,
  closestCenter,
  type DragEndEvent,
  useSensor,
  useSensors,
} from "@dnd-kit/core";
import { restrictToHorizontalAxis } from "@dnd-kit/modifiers";
import {
  SortableContext,
  arrayMove,
  horizontalListSortingStrategy,
} from "@dnd-kit/sortable";
import { useSortable } from "@dnd-kit/sortable";
import { CSS } from "@dnd-kit/utilities";
import { Badge } from "@/components/ui/feedback/badge";
import { Button } from "@/components/ui";
import { Checkbox } from "@/components/ui";
import {
  DropdownMenu,
  DropdownMenuCheckboxItem,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/overlays/dropdown-menu";
import { Input } from "@/components/ui";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/data/table";
import {
  ArrowUpDown,
  ChevronDown,
  MoreHorizontal,
  Plus,
  Columns2,
  GripVertical,
  ChevronLeft,
  ChevronRight,
  ChevronsLeft,
  ChevronsRight,
} from "lucide-react";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui";
import type { Tables } from "@/types/supabase";

// Extended type with joined data
interface DealWithRelations {
  id: number;
  deal_name: string | null;
  deal_stage_2: string | null;
  loan_amount_total: number | null;
  funding_date: string | null;
  project_type: string | null;
  property_address: string | null;
  guarantor_name: string | null;
  loan_number: string | null;
}

// Draggable Header Component
const DraggableTableHeader = ({ header, table }: any) => {
  const columnId = header.column.id;
  const isFixedColumn = columnId === "select" || columnId === "actions";

  const { attributes, isDragging, listeners, setNodeRef, transform } =
    useSortable({
      id: header.column.id,
      disabled: isFixedColumn,
    });

  const style: React.CSSProperties = {
    opacity: isDragging ? 0.5 : 1,
    position: "relative",
    transform: isFixedColumn ? "none" : CSS.Translate.toString(transform),
    transition: isDragging ? "none" : "transform 0.2s ease",
    whiteSpace: "nowrap",
    width: header.column.getSize(),
    zIndex: isDragging ? 999 : "auto",
  };

  return (
    <TableHead
      key={header.id}
      ref={setNodeRef}
      style={style}
      className={`h-12 relative text-left ${
        isDragging ? "shadow-lg border-2 border-primary" : ""
      }`}
    >
      <div className="flex items-center">
        {!isFixedColumn && (
          <button
            className="flex items-center cursor-grab active:cursor-grabbing opacity-60 hover:opacity-100 p-0.5 rounded hover:bg-muted transition-colors mr-0.5"
            {...attributes}
            {...listeners}
            title="Drag to reorder column"
          >
            <GripVertical className="h-4 w-4" />
          </button>
        )}
        <div className="flex-1 text-left">
          {header.isPlaceholder
            ? null
            : flexRender(header.column.columnDef.header, header.getContext())}
        </div>
      </div>
    </TableHead>
  );
};

const columns: ColumnDef<DealWithRelations>[] = [
  {
    id: "select",
    header: ({ table }) => (
      <div className="p-2">
        <Checkbox
          checked={
            table.getIsAllPageRowsSelected() ||
            (table.getIsSomePageRowsSelected() && "indeterminate")
          }
          onCheckedChange={(value) => table.toggleAllPageRowsSelected(!!value)}
          aria-label="Select all"
        />
      </div>
    ),
    cell: ({ row }) => (
      <div className="p-2">
        <Checkbox
          checked={row.getIsSelected()}
          onCheckedChange={(value) => row.toggleSelected(!!value)}
          aria-label="Select row"
        />
      </div>
    ),
    enableSorting: false,
    enableHiding: false,
    size: 50,
  },
  {
    id: "loan_number",
    accessorKey: "loan_number",
    header: ({ column }) => {
      return (
        <Button
          variant="ghost"
          onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
          className="h-8 px-1"
        >
          Loan Number
          <ArrowUpDown className="ml-2 h-4 w-4" />
        </Button>
      );
    },
    cell: ({ row }) => (
      <div className="text-sm font-medium">
        {row.getValue("loan_number") || "—"}
      </div>
    ),
  },
  {
    id: "property_address",
    accessorKey: "property_address",
    header: ({ column }) => {
      return (
        <Button
          variant="ghost"
          onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
          className="h-8 px-1"
        >
          Property Address
          <ArrowUpDown className="ml-2 h-4 w-4" />
        </Button>
      );
    },
    cell: ({ row }) => (
      <div className="max-w-[200px] truncate">
        {row.getValue("property_address") || "No address"}
      </div>
    ),
  },
  {
    id: "project_type",
    accessorKey: "project_type",
    header: ({ column }) => {
      return (
        <Button
          variant="ghost"
          onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
          className="h-8 px-1"
        >
          Project Type
          <ArrowUpDown className="ml-2 h-4 w-4" />
        </Button>
      );
    },
    cell: ({ row }) => {
      const projectType = row.getValue("project_type") as string;
      const displayValue = projectType
        ? projectType
            .replace(/_/g, " ")
            .replace(/\b\w/g, (l) => l.toUpperCase())
        : "Unknown";

      return <Badge variant="outline">{displayValue}</Badge>;
    },
  },
  {
    id: "deal_stage_2",
    accessorKey: "deal_stage_2",
    header: ({ column }) => {
      return (
        <Button
          variant="ghost"
          onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
          className="h-8 px-1"
        >
          Deal Stage
          <ArrowUpDown className="ml-2 h-4 w-4" />
        </Button>
      );
    },
    cell: ({ row }) => {
      const stage = row.getValue("deal_stage_2") as string;
      const displayValue = stage
        ? stage.replace(/_/g, " ").replace(/\b\w/g, (l) => l.toUpperCase())
        : "Not Set";

      return (
        <Badge
          variant={
            stage === "closed_and_funded"
              ? "default"
              : stage === "clear_to_close"
              ? "secondary"
              : "outline"
          }
        >
          {displayValue}
        </Badge>
      );
    },
  },
  {
    id: "loan_amount_total",
    accessorKey: "loan_amount_total",
    header: ({ column }) => {
      return (
        <Button
          variant="ghost"
          onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
          className="h-8 px-1"
        >
          Total Amount
          <ArrowUpDown className="ml-2 h-4 w-4" />
        </Button>
      );
    },
    cell: ({ row }) => {
      const amount = row.getValue("loan_amount_total") as number;
      return (
        <div className="font-medium">
          {amount
            ? new Intl.NumberFormat("en-US", {
                style: "currency",
                currency: "USD",
              }).format(amount)
            : "—"}
        </div>
      );
    },
  },
  {
    id: "guarantor_name",
    accessorKey: "guarantor_name",
    header: ({ column }) => {
      return (
        <Button
          variant="ghost"
          onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
          className="h-8 px-1"
        >
          Guarantor
          <ArrowUpDown className="ml-2 h-4 w-4" />
        </Button>
      );
    },
    cell: ({ row }) => (
      <div className="max-w-[150px] truncate">
        {row.getValue("guarantor_name") || "No guarantor"}
      </div>
    ),
  },
  {
    id: "funding_date",
    accessorKey: "funding_date",
    header: ({ column }) => {
      return (
        <Button
          variant="ghost"
          onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
          className="h-8 px-1"
        >
          Funding Date
          <ArrowUpDown className="ml-2 h-4 w-4" />
        </Button>
      );
    },
    cell: ({ row }) => {
      const date = row.getValue("funding_date") as string;
      return date ? new Date(date).toLocaleDateString() : "—";
    },
  },
  {
    id: "actions",
    enableHiding: false,
    size: 60,
    cell: ({ row }) => {
      const deal = row.original;

      return (
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button variant="ghost" className="h-8 w-8 p-0">
              <span className="sr-only">Open menu</span>
              <MoreHorizontal className="h-4 w-4" />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end">
            <DropdownMenuLabel>Actions</DropdownMenuLabel>
            <DropdownMenuItem
              onClick={() => navigator.clipboard.writeText(deal.id.toString())}
            >
              Copy deal ID
            </DropdownMenuItem>
            <DropdownMenuSeparator />
            <DropdownMenuItem>View details</DropdownMenuItem>
            <DropdownMenuItem>Edit deal</DropdownMenuItem>
            <DropdownMenuSeparator />
            <DropdownMenuItem className="text-red-600">
              Archive
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      );
    },
  },
];

export function DealsDataTable() {
  const [data, setData] = useState<DealWithRelations[]>([]);
  const [loading, setLoading] = useState(true);
  const [sorting, setSorting] = useState<SortingState>([]);
  const [columnFilters, setColumnFilters] = useState<ColumnFiltersState>([]);
  const [columnVisibility, setColumnVisibility] = useState<VisibilityState>({});
  const [rowSelection, setRowSelection] = useState({});
  const [columnOrder, setColumnOrder] = useState<ColumnOrderState>([
    "select",
    "loan_number",
    "property_address",
    "project_type",
    "deal_stage_2",
    "loan_amount_total",
    "guarantor_name",
    "funding_date",
    "actions",
  ]);

  const supabase = createClientComponentClient();

  // Set up sensors for drag and drop
  const sensors = useSensors(
    useSensor(MouseSensor, {
      activationConstraint: {
        distance: 3,
      },
    }),
    useSensor(TouchSensor, {
      activationConstraint: {
        delay: 200,
        tolerance: 8,
      },
    }),
    useSensor(KeyboardSensor, {})
  );

  useEffect(() => {
    async function fetchDeals() {
      try {
        setLoading(true);

        // First, let's try a simple query to see what we get
        console.log("Fetching deals with joins...");

        const { data: deals, error } = await supabase
          .from("deal")
          .select(
            `
            id,
            deal_name,
            deal_stage_2,
            loan_amount_total,
            funding_date,
            project_type,
            property_id,
            primary_guarantor_id,
            loan_number
          `
          )
          .order("created_at", { ascending: false });

        if (error) {
          console.error("Error fetching deals:", error);
          return;
        }

        console.log("Basic deals data:", deals);

        // Now let's try to get property data separately
        const dealIds = deals?.map((deal) => deal.id) || [];

        // Fetch property data for these deals
        let propertyData: any = {};
        if (dealIds.length > 0) {
          const { data: properties, error: propError } = await supabase
            .from("property")
            .select("id, address");

          if (!propError && properties) {
            propertyData = properties.reduce((acc, prop) => {
              acc[prop.id] = prop.address;
              return acc;
            }, {});
            console.log("Property data:", propertyData);
          } else {
            console.error("Property fetch error:", propError);
          }
        }

        // Fetch guarantor data
        let guarantorData: any = {};
        if (dealIds.length > 0) {
          const { data: guarantors, error: guarError } = await supabase
            .from("guarantor")
            .select("id, name");

          if (!guarError && guarantors) {
            guarantorData = guarantors.reduce((acc, guar) => {
              acc[guar.id] = guar.name;
              return acc;
            }, {});
            console.log("Guarantor data:", guarantorData);
          } else {
            console.error("Guarantor fetch error:", guarError);
          }
        }

        // Transform the data to match our interface
        const transformedData: DealWithRelations[] = (deals || []).map(
          (deal: any) => {
            const propertyAddress = deal.property_id
              ? propertyData[deal.property_id] ||
                `Property ID: ${deal.property_id}`
              : "No property";

            const guarantorName = deal.primary_guarantor_id
              ? guarantorData[deal.primary_guarantor_id] ||
                `Guarantor ID: ${deal.primary_guarantor_id}`
              : "No guarantor";

            console.log(
              `Deal ${deal.id}: property_id=${deal.property_id}, address=${propertyAddress}`
            );
            console.log(
              `Deal ${deal.id}: guarantor_id=${deal.primary_guarantor_id}, name=${guarantorName}`
            );

            return {
              id: deal.id,
              deal_name: deal.deal_name,
              deal_stage_2: deal.deal_stage_2,
              loan_amount_total: deal.loan_amount_total,
              funding_date: deal.funding_date,
              project_type: deal.project_type,
              property_address: propertyAddress,
              guarantor_name: guarantorName,
              loan_number: deal.loan_number,
            };
          }
        );

        console.log("Final transformed data:", transformedData);
        setData(transformedData);
      } catch (err) {
        console.error("Error fetching deals:", err);
      } finally {
        setLoading(false);
      }
    }

    fetchDeals();
  }, [supabase]);

  const table = useReactTable({
    data,
    columns,
    state: {
      sorting,
      columnVisibility,
      rowSelection,
      columnFilters,
      columnOrder,
    },
    enableRowSelection: true,
    onRowSelectionChange: setRowSelection,
    onSortingChange: setSorting,
    onColumnFiltersChange: setColumnFilters,
    onColumnVisibilityChange: setColumnVisibility,
    onColumnOrderChange: setColumnOrder,
    getCoreRowModel: getCoreRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    getSortedRowModel: getSortedRowModel(),
  });

  // Format column names for display
  function formatColumnName(columnId: string): string {
    const columnNameMap: Record<string, string> = {
      loan_number: "Loan Number",
      property_address: "Property Address",
      project_type: "Project Type",
      deal_stage_2: "Deal Stage",
      loan_amount_total: "Total Amount",
      guarantor_name: "Guarantor",
      funding_date: "Funding Date",
    };

    return (
      columnNameMap[columnId] ||
      columnId.replace(/_/g, " ").replace(/\b\w/g, (l) => l.toUpperCase())
    );
  }

  // Handle drag end for column reordering
  function handleDragEnd(event: DragEndEvent) {
    const { active, over } = event;

    console.log("Drag end:", { active: active?.id, over: over?.id });

    if (active && over && active.id !== over.id) {
      const activeId = active.id as string;
      const overId = over.id as string;

      // Don't allow dragging fixed columns
      if (
        activeId === "select" ||
        activeId === "actions" ||
        overId === "select" ||
        overId === "actions"
      ) {
        return;
      }

      const oldOrder = table.getState().columnOrder;
      console.log("Current column order:", oldOrder);

      setColumnOrder((prev) => {
        const oldIndex = prev.indexOf(activeId);
        const newIndex = prev.indexOf(overId);

        console.log("Moving from index", oldIndex, "to", newIndex);

        // Create new order but preserve fixed positions
        const newOrder = arrayMove(prev, oldIndex, newIndex);

        // Ensure select is first and actions is last
        const finalOrder = newOrder.filter(
          (id) => id !== "select" && id !== "actions"
        );
        const result = ["select", ...finalOrder, "actions"];

        console.log("New column order:", result);
        return result;
      });
    }
  }

  if (loading) {
    return (
      <div className="w-full">
        <div className="flex items-center justify-between py-4">
          <div className="flex items-center space-x-2">
            <div className="h-8 w-[250px] bg-muted animate-pulse rounded" />
          </div>
          <div className="flex items-center space-x-2">
            <div className="h-8 w-[70px] bg-muted animate-pulse rounded" />
            <div className="h-8 w-[100px] bg-muted animate-pulse rounded" />
          </div>
        </div>
        <div className="rounded-md border">
          <div className="h-[500px] bg-muted animate-pulse" />
        </div>
        <div className="flex items-center justify-end space-x-2 py-4">
          <div className="h-8 w-[160px] bg-muted animate-pulse rounded" />
        </div>
      </div>
    );
  }

  return (
    <DndContext
      collisionDetection={closestCenter}
      modifiers={[restrictToHorizontalAxis]}
      onDragEnd={handleDragEnd}
      sensors={sensors}
    >
      <div className="w-full">
        <div className="flex items-center justify-between py-4">
          <div className="flex items-center space-x-2">
            <Input
              placeholder="Filter deals..."
              value={
                (table
                  .getColumn("property_address")
                  ?.getFilterValue() as string) ?? ""
              }
              onChange={(event) =>
                table
                  .getColumn("property_address")
                  ?.setFilterValue(event.target.value)
              }
              className="max-w-sm"
            />
          </div>
          <div className="flex items-center space-x-2">
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button
                  variant="outline"
                  size="sm"
                  className="h-8 bg-background"
                >
                  <Columns2 className="w-4 h-4 mr-2" />
                  <span className="text-xs font-medium">Customize Columns</span>
                  <ChevronDown className="w-4 h-4 ml-2" />
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end" className="w-[200px]">
                {table
                  .getAllColumns()
                  .filter(
                    (column) =>
                      typeof column.accessorFn !== "undefined" &&
                      column.getCanHide()
                  )
                  .map((column) => {
                    return (
                      <DropdownMenuCheckboxItem
                        key={column.id}
                        checked={column.getIsVisible()}
                        onCheckedChange={(value) =>
                          column.toggleVisibility(!!value)
                        }
                      >
                        {formatColumnName(column.id)}
                      </DropdownMenuCheckboxItem>
                    );
                  })}
              </DropdownMenuContent>
            </DropdownMenu>
            <Button size="sm" className="h-8">
              <Plus className="mr-2 h-4 w-4" />
              Add Deal
            </Button>
          </div>
        </div>
        <div className="rounded-md border">
          <Table>
            <TableHeader>
              {table.getHeaderGroups().map((headerGroup) => (
                <TableRow key={headerGroup.id} className="bg-muted">
                  <SortableContext
                    items={columnOrder.filter(
                      (id) => id !== "select" && id !== "actions"
                    )}
                    strategy={horizontalListSortingStrategy}
                  >
                    {headerGroup.headers.map((header) => (
                      <DraggableTableHeader
                        key={header.id}
                        header={header}
                        table={table}
                      />
                    ))}
                  </SortableContext>
                </TableRow>
              ))}
            </TableHeader>
            <TableBody>
              {table.getRowModel().rows?.length ? (
                table.getRowModel().rows.map((row) => (
                  <TableRow
                    key={row.id}
                    data-state={row.getIsSelected() && "selected"}
                    className="h-14"
                  >
                    {row.getVisibleCells().map((cell) => (
                      <TableCell key={cell.id} className="text-left">
                        {flexRender(
                          cell.column.columnDef.cell,
                          cell.getContext()
                        )}
                      </TableCell>
                    ))}
                  </TableRow>
                ))
              ) : (
                <TableRow>
                  <TableCell
                    colSpan={columns.length}
                    className="h-24 text-center"
                  >
                    No results.
                  </TableCell>
                </TableRow>
              )}
            </TableBody>
          </Table>
        </div>
        <div className="flex items-center justify-between py-4">
          <div className="text-sm text-muted-foreground">
            {table.getFilteredSelectedRowModel().rows.length} of{" "}
            {table.getFilteredRowModel().rows.length} row(s) selected.
          </div>
          <div className="flex items-center gap-8">
            <div className="flex items-center gap-2">
              <p className="text-sm font-medium text-foreground">
                Rows per page
              </p>
              <Select
                value={table.getState().pagination.pageSize.toString()}
                onValueChange={(value) => {
                  table.setPageSize(Number(value));
                }}
              >
                <SelectTrigger className="w-[80px] h-9">
                  <SelectValue placeholder="10" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="10">10</SelectItem>
                  <SelectItem value="20">20</SelectItem>
                  <SelectItem value="30">30</SelectItem>
                  <SelectItem value="40">40</SelectItem>
                  <SelectItem value="50">50</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <p className="text-sm font-medium text-foreground">
              Page {table.getState().pagination.pageIndex + 1} of{" "}
              {table.getPageCount()}
            </p>

            <div className="flex items-center gap-2">
              <Button
                variant="outline"
                size="icon"
                onClick={() => table.setPageIndex(0)}
                disabled={!table.getCanPreviousPage()}
              >
                <ChevronsLeft className="h-4 w-4" />
                <span className="sr-only">First page</span>
              </Button>
              <Button
                variant="outline"
                size="icon"
                onClick={() => table.previousPage()}
                disabled={!table.getCanPreviousPage()}
              >
                <ChevronLeft className="h-4 w-4" />
                <span className="sr-only">Previous page</span>
              </Button>
              <Button
                variant="outline"
                size="icon"
                onClick={() => table.nextPage()}
                disabled={!table.getCanNextPage()}
              >
                <ChevronRight className="h-4 w-4" />
                <span className="sr-only">Next page</span>
              </Button>
              <Button
                variant="outline"
                size="icon"
                onClick={() => table.setPageIndex(table.getPageCount() - 1)}
                disabled={!table.getCanNextPage()}
              >
                <ChevronsRight className="h-4 w-4" />
                <span className="sr-only">Last page</span>
              </Button>
            </div>
          </div>
        </div>
      </div>
    </DndContext>
  );
}
