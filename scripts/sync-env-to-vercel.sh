#!/bin/bash

PROJECT="bl-1-lender-portal" # Vercel project name
TEAM="brrrr"          # Vercel team slug (or omit if deploying under personal account)

echo "🧪 Syncing Preview env vars to Vercel..."
vercel env add NEXT_PUBLIC_CLERK_FRONTEND_API preview < .env.local
vercel env add NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY preview < .env.local
vercel env add NEXT_PUBLIC_SUPABASE_URL preview < .env.local
vercel env add NEXT_PUBLIC_SUPABASE_ANON_KEY preview < .env.local

echo "🚀 Syncing Production env vars to Vercel..."
vercel env add CLERK_FRONTEND_API production < .env.local
vercel env add CLERK_API_KEY production < .env.local
vercel env add CLERK_JWT_KEY production < .env.local
vercel env add SUPABASE_SERVICE_ROLE_KEY production < .env.local
vercel env add NEXT_PUBLIC_SUPABASE_URL production < .env.local

echo "✅ Done syncing Vercel environment variables."