export const dynamic = "force-dynamic";

import { createServerComponentClient } from "@supabase/auth-helpers-nextjs";
import { cookies } from "next/headers";
import { DealDetailsWrapper } from "@/components/deals/protected-deal-details";
import { DocumentsListWrapper } from "@/components/documents/list-protected-documents";
import { DistributionsListWrapper } from "@/components/distributions/protected-distributions-list";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui";
import { notFound } from "next/navigation";
import type { Database } from "@/types/supabase";

interface PageProps {
  params: Promise<{
    id: string;
  }>;
}

export default async function DealPage({ params }: PageProps) {
  const { id } = await params;
  const supabase = createServerComponentClient<Database>({ cookies });

  // Fetch basic deal data
  const { data: deal, error } = await supabase
    .from("deal")
    .select("*")
    .eq("id", parseInt(id))
    .single();

  if (error || !deal) {
    notFound();
  }

  return (
    <div className="container mx-auto py-6 space-y-6">
      <DealDetailsWrapper dealId={id} deal={deal} />

      <Tabs defaultValue="documents" className="w-full">
        <TabsList>
          <TabsTrigger value="documents">Documents</TabsTrigger>
          <TabsTrigger value="distributions">Distributions</TabsTrigger>
        </TabsList>

        <TabsContent value="documents">
          <DocumentsListWrapper dealId={id} />
        </TabsContent>

        <TabsContent value="distributions">
          <DistributionsListWrapper dealId={id} />
        </TabsContent>
      </Tabs>
    </div>
  );
}
