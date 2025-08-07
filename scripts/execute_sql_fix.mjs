#!/usr/bin/env node

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.env.NEXT_PUBLIC_SUPABASE_KEY;

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function executeDatabaseFix() {
  console.log('🔧 Attempting Automated Database Fix');
  console.log('=====================================\n');
  
  // Step 1: Try to drop duplicate table
  console.log('Step 1: Attempting to drop duplicate table...');
  try {
    const { error } = await supabase.rpc('exec_sql', {
      sql: 'DROP TABLE IF EXISTS auth_user_profiles CASCADE;'
    });
    
    if (error) {
      console.log('❌ Cannot drop table programmatically:', error.message);
    } else {
      console.log('✅ Successfully dropped duplicate table!');
    }
  } catch (err) {
    console.log('❌ Error dropping table:', err.message);
  }
  
  // Step 2: Try to add missing column
  console.log('\nStep 2: Attempting to add clerk_role column...');
  try {
    const { error } = await supabase.rpc('exec_sql', {
      sql: `
        ALTER TABLE auth_user_profile 
        ADD COLUMN IF NOT EXISTS clerk_role TEXT 
        CHECK (clerk_role IN ('admin', 'member'));
      `
    });
    
    if (error) {
      console.log('❌ Cannot add column programmatically:', error.message);
    } else {
      console.log('✅ Successfully added clerk_role column!');
    }
  } catch (err) {
    console.log('❌ Error adding column:', err.message);
  }
  
  console.log('\n🛠️ MANUAL EXECUTION REQUIRED');
  console.log('=============================');
  console.log('The operations above require admin privileges.');
  console.log('You need to execute the SQL commands manually.\n');
  
  console.log('📋 Quick Manual Steps:');
  console.log('1. Go to: https://supabase.com/dashboard');
  console.log('2. Navigate to: SQL Editor');
  console.log('3. Copy and paste this SQL:');
  console.log('');
  console.log('   -- Drop duplicate table');
  console.log('   DROP TABLE IF EXISTS auth_user_profiles CASCADE;');
  console.log('');
  console.log('   -- Add missing column');
  console.log('   ALTER TABLE auth_user_profile ');
  console.log('   ADD COLUMN IF NOT EXISTS clerk_role TEXT ');
  console.log('   CHECK (clerk_role IN (\'admin\', \'member\'));');
  console.log('');
  console.log('   -- Set default');
  console.log('   ALTER TABLE auth_user_profile ');
  console.log('   ALTER COLUMN clerk_role SET DEFAULT \'member\';');
  console.log('');
  console.log('4. Click "Run" to execute');
  console.log('');
  console.log('⏱️ Estimated time: 2 minutes');
  console.log('');
}

executeDatabaseFix();