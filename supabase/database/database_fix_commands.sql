-- ================================================================
-- Database Cleanup and Schema Fix Commands
-- ================================================================
-- Execute these commands in your Supabase SQL Editor
-- Safe to run - both tables are empty (0 records)

-- Step 1: Verify current state (optional check)
-- ================================================================
SELECT 
    table_name,
    (SELECT COUNT(*) FROM information_schema.columns 
     WHERE table_name = t.table_name AND column_name = 'clerk_role') as has_clerk_role,
    (SELECT reltuples::BIGINT as estimate 
     FROM pg_class WHERE relname = t.table_name) as estimated_rows
FROM information_schema.tables t
WHERE table_name LIKE '%user_profile%'
ORDER BY table_name;

-- Step 2: Drop the duplicate table
-- ================================================================
-- Safe because:
-- - Both tables are empty (0 records confirmed)
-- - Both tables have identical structure  
-- - auth_user_profile (singular) is the correct table to keep

DROP TABLE IF EXISTS auth_user_profiles CASCADE;

-- Step 3: Add missing clerk_role column to correct table
-- ================================================================
-- Add the clerk_role column with proper constraints
ALTER TABLE auth_user_profile 
ADD COLUMN IF NOT EXISTS clerk_role TEXT 
CHECK (clerk_role IN ('admin', 'member'));

-- Set default value for new records
ALTER TABLE auth_user_profile 
ALTER COLUMN clerk_role SET DEFAULT 'member';

-- Step 4: Add helpful comment for documentation
-- ================================================================
COMMENT ON COLUMN auth_user_profile.clerk_role IS 
    'Clerk organization role: admin or member within Clerk organization context';

COMMENT ON COLUMN auth_user_profile.role IS 
    'Database user role: account_executive, loan_processor, etc. within application context';

-- Step 5: Verify the fixes (run this to confirm success)
-- ================================================================
SELECT 
    'auth_user_profile' as table_name,
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'auth_user_profile' 
AND column_name IN ('role', 'clerk_role', 'clerk_id', 'email')
ORDER BY column_name;

-- Step 6: Check that duplicate table is gone
-- ================================================================
SELECT COUNT(*) as remaining_user_profile_tables
FROM information_schema.tables 
WHERE table_name LIKE '%user_profile%';
-- Expected result: 1 (only auth_user_profile should remain)

-- Step 7: Test the table structure (should work without errors)
-- ================================================================
SELECT 
    id, 
    email, 
    clerk_id, 
    role,           -- Database role (e.g., account_executive)
    clerk_role,     -- Clerk org role (admin/member) 
    is_internal_yn,
    is_active_yn
FROM auth_user_profile 
LIMIT 1;

-- ================================================================
-- EXPECTED RESULTS AFTER RUNNING THESE COMMANDS:
-- ================================================================
-- ✅ auth_user_profiles table: REMOVED
-- ✅ auth_user_profile table: EXISTS with clerk_role column
-- ✅ Both role and clerk_role columns exist and serve different purposes
-- ✅ All code references will work correctly
-- ✅ Authentication flows will work properly