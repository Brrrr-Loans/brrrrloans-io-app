-- Migration: Drop duplicate auth_user_profiles table
-- Purpose: Remove the duplicate plural table, keeping only auth_user_profile (singular)
-- Date: $(date)
-- Author: System Cleanup

-- First, check if any data exists in the plural table that doesn't exist in singular
DO $$
DECLARE
    plural_count INTEGER;
    singular_count INTEGER;
BEGIN
    -- Check if both tables exist
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'auth_user_profiles') 
       AND EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'auth_user_profile') THEN
        
        -- Get record counts
        SELECT COUNT(*) INTO plural_count FROM auth_user_profiles;
        SELECT COUNT(*) INTO singular_count FROM auth_user_profile;
        
        RAISE NOTICE 'Found % records in auth_user_profiles (plural)', plural_count;
        RAISE NOTICE 'Found % records in auth_user_profile (singular)', singular_count;
        
        -- If plural table has data, warn about data loss
        IF plural_count > 0 THEN
            RAISE WARNING 'The auth_user_profiles table contains % records that will be lost!', plural_count;
            RAISE WARNING 'Please review and migrate any important data before running this script.';
            
            -- Optionally show sample data from plural table
            RAISE NOTICE 'Sample data from auth_user_profiles:';
            -- Add a SELECT query here if you want to see the data
        END IF;
        
    END IF;
END $$;

-- Drop foreign key constraints that reference the plural table
-- (This section would need to be customized based on actual constraints)
DO $$
DECLARE
    constraint_record RECORD;
BEGIN
    -- Find all foreign key constraints referencing auth_user_profiles
    FOR constraint_record IN 
        SELECT 
            tc.constraint_name,
            tc.table_name,
            kcu.column_name
        FROM information_schema.table_constraints tc
        JOIN information_schema.key_column_usage kcu 
            ON tc.constraint_name = kcu.constraint_name
        JOIN information_schema.constraint_column_usage ccu 
            ON ccu.constraint_name = tc.constraint_name
        WHERE tc.constraint_type = 'FOREIGN KEY'
        AND ccu.table_name = 'auth_user_profiles'
    LOOP
        RAISE NOTICE 'Found FK constraint: % on table %.%', 
            constraint_record.constraint_name, 
            constraint_record.table_name, 
            constraint_record.column_name;
        
        -- Uncomment the next line to actually drop the constraint
        -- EXECUTE format('ALTER TABLE %I DROP CONSTRAINT %I', 
        --     constraint_record.table_name, 
        --     constraint_record.constraint_name);
    END LOOP;
END $$;

-- Drop RLS policies on the plural table
DO $$
DECLARE
    policy_record RECORD;
BEGIN
    -- Find all RLS policies on auth_user_profiles
    FOR policy_record IN 
        SELECT policyname 
        FROM pg_policies 
        WHERE tablename = 'auth_user_profiles'
    LOOP
        RAISE NOTICE 'Found RLS policy: %', policy_record.policyname;
        
        -- Uncomment the next line to actually drop the policy
        -- EXECUTE format('DROP POLICY %I ON auth_user_profiles', policy_record.policyname);
    END LOOP;
END $$;

-- Drop indexes on the plural table
DO $$
DECLARE
    index_record RECORD;
BEGIN
    -- Find all indexes on auth_user_profiles
    FOR index_record IN 
        SELECT indexname 
        FROM pg_indexes 
        WHERE tablename = 'auth_user_profiles'
    LOOP
        RAISE NOTICE 'Found index: %', index_record.indexname;
        
        -- Uncomment the next line to actually drop the index
        -- EXECUTE format('DROP INDEX IF EXISTS %I', index_record.indexname);
    END LOOP;
END $$;

-- Finally, drop the duplicate table
-- UNCOMMENT THE NEXT LINE WHEN READY TO EXECUTE
-- DROP TABLE IF EXISTS auth_user_profiles CASCADE;

-- Verify the cleanup
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'auth_user_profiles') THEN
        RAISE NOTICE '✅ Successfully dropped auth_user_profiles table';
    ELSE
        RAISE NOTICE '⚠️  auth_user_profiles table still exists';
    END IF;
    
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'auth_user_profile') THEN
        RAISE NOTICE '✅ auth_user_profile table exists and is preserved';
    ELSE
        RAISE WARNING '❌ auth_user_profile table is missing! This is a problem.';
    END IF;
END $$;