import { NextResponse } from "next/server";
import { auth } from "@clerk/nextjs/server";

export async function GET() {
  try {
    const { userId, sessionId } = await auth();

    return NextResponse.json({
      userId,
      sessionId,
      hasAuth: !!userId,
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    console.error("Auth debug error:", error);
    return NextResponse.json(
      {
        error: "Auth debug failed",
        details: error instanceof Error ? error.message : "Unknown error",
      },
      { status: 500 }
    );
  }
}
