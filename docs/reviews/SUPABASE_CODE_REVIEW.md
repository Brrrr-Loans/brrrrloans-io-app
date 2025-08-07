# Supabase Code Review Report

## Critical Issues Found

### 1. **Multiple Conflicting Client Setups** ⚠️ HIGH PRIORITY

**Problem**: The codebase has at least 5 different ways to create Supabase clients, leading to confusion and potential bugs:

- `src/lib/supabase/client.ts` - @supabase/ssr browser client
- `src/lib/supabase/server.ts` - @supabase/ssr server client
- `src/lib/supabase.ts` - Custom Clerk integration
- `src/lib/supabase-client.ts` - Client-side with Clerk
- `src/lib/supabase-server.ts` - Server-side with Clerk

**Files Affected**:

- `src/lib/supabase/` (entire directory)
- `src/lib/supabase.ts`
- `src/lib/supabase-client.ts`
- `src/lib/supabase-server.ts`

**Recommendation**:
Consolidate to a single, consistent approach. Choose either the @supabase/ssr approach OR the Clerk integration approach, but not both.

### 2. **Inconsistent Authentication Patterns** ⚠️ HIGH PRIORITY

**Problem**: Different parts of the codebase use different authentication methods:

```typescript
// In hooks/use-investor-permissions.ts - WRONG APPROACH
const supabase = createClientComponentClient<Database>();

// In api/investor-statements/route.ts - DIFFERENT APPROACH
const supabase = createRouteHandlerClient({ cookies });

// In actions/deals.ts - YET ANOTHER APPROACH
const supabase = await getSupabaseClient();
```

**Files Affected**:

- `src/hooks/use-investor-permissions.ts` (lines 11-12)
- `src/app/api/investor-statements/route.ts` (lines 10)
- `src/app/actions/deals.ts` (line 8)

**Security Risk**: Using `createClientComponentClient` without proper authentication setup can bypass Row Level Security.

### 3. **Serious Security Issues** 🚨 CRITICAL

**Problem**: Several security vulnerabilities found:

#### a) Unsafe Client Usage

```typescript
// In use-investor-permissions.ts - BYPASSES AUTHENTICATION
const supabase = createClientComponentClient<Database>();
```

#### b) Missing Input Validation

```typescript
// In actions/deals.ts (lines 48-56) - NO VALIDATION
const { error } = await supabase.from("deal").insert({
  deal_name: name, // No sanitization
  amount: cleanAmount, // Basic string manipulation only
  // ...
});
```

#### c) Improper Access Control

```typescript
// In actions/deals.ts (lines 134-141) - WEAK PERMISSION CHECK
const { data: dealContact, error: checkError } = await supabase
  .from("deal_roles")
  .select("*")
  .eq("deal_id", Number(id))
  .eq("contact_id", Number(userId)) // Using Clerk ID as contact_id - WRONG
  .eq("role", "Owner")
  .single();
```

### 4. **Data Type Issues** ⚠️ MEDIUM PRIORITY

**Problem**: Inconsistent handling of data types:

```typescript
// In actions/deals.ts (line 60) - String used as number
deal_id: Number(dealId), // dealId is generated as string but used as number

// In actions/documents.ts (lines 51-61) - Complex type coercion
const documentFileSize = Number.parseInt(documentFileSizeRaw);
if (!documentFileSize) { // This logic is flawed
```

### 5. **Storage Security Issues** ⚠️ MEDIUM PRIORITY

**Problem**: Overly permissive storage policies in setup:

```typescript
// In api/storage/setup/route.ts (lines 80-95) - TOO PERMISSIVE
CREATE POLICY "Allow users to read any documents"
ON storage.objects
FOR SELECT
TO authenticated
USING (bucket_id = 'documents'); // Allows access to ANY document
```

### 6. **Error Handling Gaps** ⚠️ MEDIUM PRIORITY

**Problem**: Inconsistent error handling patterns:

```typescript
// In hooks/use-deals.ts (lines 35-48) - Good error handling
if (!response.ok) {
  if (response.status === 401) {
    router.push("/sign-in");
    return;
  }
  // ... proper error handling
}

// But in actions/deals.ts (lines 47-52) - Basic error handling only
if (error) {
  throw new Error(error.message);
}
```

## Recommendations by Priority

### CRITICAL FIXES (Implement Immediately)

#### 1. Fix Authentication Security

Replace unsafe client usage:

```typescript
// REMOVE this pattern from use-investor-permissions.ts
const supabase = createClientComponentClient<Database>();

// REPLACE with proper Clerk integration
const supabase = useSupabase(); // Use your existing hook
```

#### 2. Consolidate Client Creation

Choose ONE approach and remove others:

#### Option A: Use Clerk Integration (Recommended)

- Keep: `src/lib/supabase-server.ts` and `src/hooks/use-supabase.ts`
- Remove: `src/lib/supabase/` directory entirely
- Remove: `src/lib/supabase.ts` and `src/lib/supabase-client.ts`

#### Option B: Use @supabase/ssr

- Keep: `src/lib/supabase/` directory
- Remove: All Clerk-specific Supabase files

#### 3. Fix Data Type Handling

```typescript
// In actions/deals.ts - Fix ID generation and usage
const dealId = Math.floor(100000 + Math.random() * 900000); // Generate as number
// Remove string prefixing for database IDs
```

### HIGH PRIORITY FIXES

#### 4. Implement Proper Row Level Security

Create proper RLS policies for each table:

```sql
-- Example for deals table
CREATE POLICY "Users can only see their deals"
ON deal
FOR SELECT
TO authenticated
USING (
  id IN (
    SELECT DISTINCT dr.deal_id
    FROM deal_roles dr
    JOIN contact c ON dr.contact_id = c.id
    JOIN auth_user_profile aup ON c.email_address = aup.email
    WHERE aup.clerk_id = auth.jwt() ->> 'clerk_user_id'
  )
);
```

#### 5. Add Input Validation

```typescript
// Add validation schemas using zod or similar
import { z } from "zod";

const createDealSchema = z.object({
  name: z.string().min(1).max(255),
  amount: z.string().regex(/^\d+(\.\d{2})?$/),
  // ... other validations
});
```

#### 6. Fix Storage Policies

Implement user-specific storage access:

```sql
CREATE POLICY "Users can only access their documents"
ON storage.objects
FOR ALL
TO authenticated
USING (
  bucket_id = 'documents' AND
  (storage.foldername(name))[1] = (auth.jwt() ->> 'clerk_user_id')
);
```

### MEDIUM PRIORITY IMPROVEMENTS

#### 7. Standardize Error Handling

Create a consistent error handling pattern:

```typescript
// Create src/lib/error-handler.ts
export function handleSupabaseError(error: any, context: string) {
  console.error(`Supabase error in ${context}:`, error);

  if (error.code === "PGRST116") {
    throw new Error("No data found");
  }
  if (error.code === "23505") {
    throw new Error("Duplicate entry");
  }

  throw new Error(error.message || "Database operation failed");
}
```

#### 8. Optimize Performance

- Implement connection pooling
- Add request caching where appropriate
- Use Supabase's built-in caching headers

#### 9. Add Comprehensive Logging

```typescript
// Add to all database operations
console.log("Supabase operation:", {
  operation: "SELECT",
  table: "deals",
  user: userId,
  timestamp: new Date().toISOString(),
});
```

## Files Requiring Immediate Attention

1. **`src/hooks/use-investor-permissions.ts`** - Security vulnerability
2. **`src/app/actions/deals.ts`** - Type safety and validation issues
3. **`src/app/api/investor-statements/route.ts`** - Inconsistent auth pattern
4. **`src/lib/supabase-server.ts`** - Should be the single source of truth
5. **`src/app/api/storage/setup/route.ts`** - Overly permissive policies

## Testing Recommendations

1. **Security Testing**: Verify RLS policies prevent unauthorized access
2. **Type Testing**: Ensure all database operations are type-safe
3. **Error Testing**: Test error scenarios and ensure proper handling
4. **Performance Testing**: Monitor query performance and optimize slow operations

## Next Steps

1. **Phase 1**: Fix critical security issues (use-investor-permissions.ts)
2. **Phase 2**: Consolidate client creation patterns
3. **Phase 3**: Implement proper RLS policies
4. **Phase 4**: Add comprehensive input validation
5. **Phase 5**: Standardize error handling and logging

This review identified significant security and consistency issues that should be addressed immediately to ensure the application's reliability and security.
