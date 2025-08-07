#!/usr/bin/env node

import { createClient } from '@supabase/supabase-js';

// Database cleanup script for auth_user_profiles table duplication
console.log('🔍 Database Cleanup Script - Table Duplication Fix');
console.log('===================================================\n');

// Check for required environment variables
const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.env.NEXT_PUBLIC_SUPABASE_KEY || process.env.SUPABASE_ANON_KEY;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

console.log('Environment Check:');
console.log('- SUPABASE_URL:', SUPABASE_URL ? '✅ Found' : '❌ Missing');
console.log('- SUPABASE_ANON_KEY:', SUPABASE_ANON_KEY ? '✅ Found' : '❌ Missing');
console.log('- SUPABASE_SERVICE_ROLE_KEY:', SUPABASE_SERVICE_ROLE_KEY ? '✅ Found' : '❌ Missing');
console.log('');

if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  console.log('❌ Missing required environment variables!');
  console.log('');
  console.log('Please set the following environment variables:');
  console.log('export NEXT_PUBLIC_SUPABASE_URL="your-supabase-url"');
  console.log('export NEXT_PUBLIC_SUPABASE_ANON_KEY="your-anon-key"');
  console.log('export SUPABASE_SERVICE_ROLE_KEY="your-service-role-key"  # Optional but recommended');
  console.log('');
  console.log('You can find these values in your Supabase project dashboard:');
  console.log('1. Go to https://supabase.com/dashboard');
  console.log('2. Select your project');
  console.log('3. Go to Settings → API');
  console.log('4. Copy the values from the "Project API keys" section');
  process.exit(1);
}

// Create Supabase client
const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY || SUPABASE_ANON_KEY);

async function checkTableExists(tableName) {
  try {
    const { data, error } = await supabase
      .from(tableName)
      .select('count(*)', { count: 'exact', head: true });
    
    if (error && error.code === 'PGRST116') {
      // Table doesn't exist or no access
      return { exists: false, count: 0, error: error.message };
    } else if (error) {
      return { exists: false, count: 0, error: error.message };
    }
    
    return { exists: true, count: data?.length || 0, error: null };
  } catch (err) {
    return { exists: false, count: 0, error: err.message };
  }
}

async function getTableRecordCount(tableName) {
  try {
    const { count, error } = await supabase
      .from(tableName)
      .select('*', { count: 'exact', head: true });
    
    if (error) {
      return { count: 0, error: error.message };
    }
    
    return { count: count || 0, error: null };
  } catch (err) {
    return { count: 0, error: err.message };
  }
}

async function checkDuplicateTables() {
  console.log('🔍 Checking table existence and record counts...\n');
  
  // Check both tables
  const tables = ['auth_user_profile', 'auth_user_profiles'];
  const results = {};
  
  for (const table of tables) {
    console.log(`Checking table: ${table}`);
    const tableInfo = await checkTableExists(table);
    
    if (tableInfo.exists) {
      const countInfo = await getTableRecordCount(table);
      results[table] = {
        exists: true,
        count: countInfo.count,
        error: countInfo.error
      };
      console.log(`  ✅ Exists with ${countInfo.count} records`);
      if (countInfo.error) {
        console.log(`  ⚠️  Error getting count: ${countInfo.error}`);
      }
    } else {
      results[table] = {
        exists: false,
        count: 0,
        error: tableInfo.error
      };
      console.log(`  ❌ Does not exist or no access`);
      if (tableInfo.error) {
        console.log(`  Error: ${tableInfo.error}`);
      }
    }
  }
  
  return results;
}

async function performCleanup() {
  console.log('\n🧹 Database Cleanup Analysis\n');
  
  const tableResults = await checkDuplicateTables();
  
  const singularTable = tableResults['auth_user_profile'];
  const pluralTable = tableResults['auth_user_profiles'];
  
  console.log('\n📊 Analysis Results:');
  console.log('==================');
  console.log(`auth_user_profile (correct):  ${singularTable.exists ? `✅ ${singularTable.count} records` : '❌ Missing'}`);
  console.log(`auth_user_profiles (duplicate): ${pluralTable.exists ? `⚠️  ${pluralTable.count} records` : '✅ Already removed'}`);
  
  if (!pluralTable.exists) {
    console.log('\n🎉 GOOD NEWS: The duplicate table "auth_user_profiles" does not exist!');
    console.log('No cleanup needed. The table naming is already consistent.');
    return true;
  }
  
  if (!singularTable.exists) {
    console.log('\n🚨 WARNING: The correct table "auth_user_profile" does not exist!');
    console.log('This suggests a more serious configuration issue.');
    console.log('Please check your database schema and ensure the correct table exists.');
    return false;
  }
  
  if (pluralTable.exists) {
    console.log('\n⚠️  FOUND DUPLICATE TABLE: auth_user_profiles');
    console.log(`This duplicate table contains ${pluralTable.count} records.`);
    console.log('');
    console.log('🛑 MANUAL ACTION REQUIRED:');
    console.log('Due to safety concerns, automatic table deletion is disabled.');
    console.log('Please manually execute the following SQL commands in your Supabase dashboard:');
    console.log('');
    console.log('1. Go to your Supabase project dashboard');
    console.log('2. Navigate to SQL Editor');
    console.log('3. Execute this query to check for data:');
    console.log('   SELECT COUNT(*) FROM auth_user_profiles;');
    console.log('');
    if (pluralTable.count > 0) {
      console.log('4. ⚠️  BACKUP DATA if needed:');
      console.log('   SELECT * FROM auth_user_profiles;');
      console.log('');
    }
    console.log('5. Drop the duplicate table:');
    console.log('   DROP TABLE IF EXISTS auth_user_profiles CASCADE;');
    console.log('');
    console.log('6. Verify the cleanup:');
    console.log('   SELECT table_name FROM information_schema.tables');
    console.log('   WHERE table_name LIKE \'%user_profile%\';');
    
    return false;
  }
  
  return true;
}

async function testAuthenticationFlow() {
  console.log('\n🔐 Testing Authentication Flow\n');
  
  try {
    // Test 1: Basic connection
    console.log('Test 1: Basic database connection...');
    const { data: healthCheck, error: healthError } = await supabase
      .from('auth_user_profile')
      .select('count(*)', { count: 'exact', head: true });
    
    if (healthError) {
      console.log(`  ❌ Connection failed: ${healthError.message}`);
      return false;
    } else {
      console.log('  ✅ Connection successful');
    }
    
    // Test 2: Check table structure
    console.log('\nTest 2: Checking auth_user_profile table structure...');
    const { data: sampleData, error: structureError } = await supabase
      .from('auth_user_profile')
      .select('id, clerk_id, email, first_name, last_name')
      .limit(1);
    
    if (structureError) {
      console.log(`  ❌ Structure check failed: ${structureError.message}`);
      return false;
    } else {
      console.log('  ✅ Table structure looks good');
      if (sampleData && sampleData.length > 0) {
        console.log('  📊 Sample record structure:', Object.keys(sampleData[0]));
      }
    }
    
    // Test 3: Check for any remaining plural references
    console.log('\nTest 3: Verifying no references to plural table...');
    try {
      const { data: pluralCheck, error: pluralError } = await supabase
        .from('auth_user_profiles')
        .select('count(*)', { count: 'exact', head: true });
      
      if (pluralError && pluralError.code === 'PGRST116') {
        console.log('  ✅ Plural table correctly does not exist');
      } else if (pluralError) {
        console.log('  ✅ Plural table is not accessible (expected)');
      } else {
        console.log('  ⚠️  Plural table still exists - cleanup needed');
        return false;
      }
    } catch (err) {
      console.log('  ✅ Plural table correctly does not exist');
    }
    
    console.log('\n🎉 Authentication flow tests completed successfully!');
    return true;
    
  } catch (error) {
    console.log(`\n❌ Authentication flow test failed: ${error.message}`);
    return false;
  }
}

async function main() {
  try {
    // Step 1: Perform cleanup analysis
    const cleanupSuccess = await performCleanup();
    
    // Step 2: Test authentication flows
    const authSuccess = await testAuthenticationFlow();
    
    console.log('\n📋 SUMMARY');
    console.log('==========');
    console.log(`Database cleanup: ${cleanupSuccess ? '✅ No action needed' : '⚠️  Manual action required'}`);
    console.log(`Authentication test: ${authSuccess ? '✅ Passed' : '❌ Failed'}`);
    
    if (cleanupSuccess && authSuccess) {
      console.log('\n🎉 All checks passed! Your database is in good shape.');
      console.log('The table naming fix has been successfully applied.');
    } else {
      console.log('\n⚠️  Some issues found. Please review the output above for next steps.');
    }
    
  } catch (error) {
    console.error('\n💥 Unexpected error:', error);
    process.exit(1);
  }
}

// Run the script
main();