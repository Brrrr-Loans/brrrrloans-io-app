import { NextResponse } from "next/server";
import {
  getSupabaseClient,
  createServiceRoleClient,
} from "@/lib/supabase-server";
import { auth } from "@clerk/nextjs/server";

export async function GET() {
  try {
    // TEMPORARY WORKAROUND: Use service role client while we fix Clerk auth
    console.log("🛠️ Using temporary workaround for deals API");

    const supabase = createServiceRoleClient();
    // Note: URL parameters available for future filtering implementation
    // const url = new URL(request.url);
    // const searchParams = url.searchParams;

    // TEMPORARY: Use default contact_id = 1 for development
    const contactId = 1;
    console.log("Using default contact_id:", contactId);

    // Query bsi_deals using the default contact_id
    const query = supabase
      .from("bsi_deals")
      .select(
        `
        *,
        deal(*)
      `
      )
      .eq("contact_id", contactId);

    // Apply filters if provided (note: these may need adjustment based on actual deal table structure)
    // if (status) {
    //   query = query.eq("deal.deal_disposition_1", status);
    // }

    // if (type) {
    //   query = query.eq("deal.deal_type", type);
    // }

    // if (search) {
    //   query = query.or(
    //     `deal.deal_name.ilike.%${search}%,deal.id.ilike.%${search}%`
    //   );
    // }

    const { data, error } = await query;

    if (error) {
      console.error("Error fetching deals:", error);
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    // After fetching all user_profile rows:
    const { data: allClerkIds } = await supabase
      .from("auth_user_profile")
      .select("clerk_id");

    console.log("All clerk_ids in DB:", allClerkIds);

    // The returned data is: Array<{ ...bsi_deals fields..., deal: Tables<"deal"> }>
    return NextResponse.json(data || []);
  } catch (error) {
    console.error("Unexpected error:", error);
    return NextResponse.json(
      { error: "An unexpected error occurred" },
      { status: 500 }
    );
  }
}
