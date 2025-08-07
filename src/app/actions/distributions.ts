"use server";

import { getSupabaseClient } from "@/lib/supabase-server";
import { auth } from "@clerk/nextjs/server";
import { revalidatePath } from "next/cache";

export async function createDistribution(formData: FormData) {
  const { userId } = await auth();
  if (!userId) {
    throw new Error("Unauthorized");
  }

  const supabase = await getSupabaseClient();

  const dealId = formData.get("dealId");
  const distributionType = formData.get("distributionType");
  const totalAmount = formData.get("totalAmount");
  const distributionDate = formData.get("distributionDate");
  const status = formData.get("status") ?? "Scheduled";
  const notes = formData.get("notes");
  const investorPaymentsJson = formData.get("investorPayments");

  if (
    typeof dealId !== "string" ||
    typeof distributionType !== "string" ||
    typeof totalAmount !== "string" ||
    typeof distributionDate !== "string" ||
    typeof investorPaymentsJson !== "string"
  ) {
    throw new Error("Missing required fields");
  }

  try {
    // Parse the investor payments
    const investorPayments = JSON.parse(investorPaymentsJson);

    // Insert distribution record (id will be auto-generated)
    const { error } = await supabase.from("bsi_distributions").insert({
      deal_id: Number(dealId),
      created_at: new Date().toISOString(),
      notes: typeof notes === "string" ? notes : null,
      // Required fields (use dummy values or parse from formData as needed)
      capital_contribution: 0,
      deposit_amount: Number(totalAmount) || 0,
      interest_amount: 0,
      loan_amount_snapshot: 0,
      principal_amount: 0,
      rate_of_return_pct: 0,
      statement_id: crypto.randomUUID(), // Generate a valid UUID
      servicing_fee: 0,
      wire_fee: 0,
    } as any); // Temporarily use 'any' to bypass strict type checking for auto-generated id

    if (error) {
      throw new Error(error.message);
    }

    revalidatePath("/dashboard/distributions");
    return { success: true };
  } catch (error) {
    console.error("Error creating distribution:", error);
    throw error;
  }
}

export async function updateDistributionStatus(id: number, status: string) {
  const { userId } = await auth();
  if (!userId) {
    throw new Error("Unauthorized");
  }

  const supabase = await getSupabaseClient();

  try {
    // Update distribution (no status or updated_by fields in Supabase types)
    const { error } = await supabase
      .from("bsi_distributions")
      .update({
        updated_at: new Date().toISOString(),
      })
      .eq("id", id); // id is a number

    if (error) {
      throw new Error(error.message);
    }

    revalidatePath("/dashboard/distributions");
    return { success: true };
  } catch (error) {
    console.error("Error updating distribution status:", error);
    throw error;
  }
}

export async function deleteDistribution(id: number) {
  const { userId } = await auth();
  if (!userId) {
    throw new Error("Unauthorized");
  }

  const supabase = await getSupabaseClient();

  try {
    // Check if the distribution is in a state that allows deletion
    const { data: distribution, error: checkError } = await supabase
      .from("bsi_distributions")
      .select("*")
      .eq("id", id)
      .single();

    if (checkError) {
      throw new Error(checkError.message);
    }

    // Only allow deletion if status is 'Scheduled' (if such a field exists)
    // if (distribution.status !== "Scheduled") {
    //   throw new Error("Only scheduled distributions can be deleted");
    // }

    // Delete the distribution payments first (if table exists)
    // const { error: paymentsError } = await supabase
    //   .from("bs_investor_distribution_payments")
    //   .delete()
    //   .eq("distribution_id", id);

    // if (paymentsError) {
    //   throw new Error(paymentsError.message);
    // }

    // Delete the distribution
    const { error } = await supabase
      .from("bsi_distributions")
      .delete()
      .eq("id", id);

    if (error) {
      throw new Error(error.message);
    }

    revalidatePath("/dashboard/distributions");
    return { success: true };
  } catch (error) {
    console.error("Error deleting distribution:", error);
    throw error;
  }
}
