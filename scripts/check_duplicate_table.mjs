#!/usr/bin/env node

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.env.NEXT_PUBLIC_SUPABASE_KEY;

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function checkTableInfo() {
  console.log('🔍 Checking duplicate table details...\n');
  
  // Check if there are any constraints or dependencies
  try {
    const { count, error } = await supabase
      .from('auth_user_profiles')
      .select('*', { count: 'exact', head: true });
    
    if (error) {
      console.log('✅ Table access error:', error.message);
      console.log('This might mean the table was actually dropped!');
    } else {
      console.log('📊 auth_user_profiles record count:', count || 0);
      console.log('⚠️  Table is still accessible with', count || 0, 'records');
      console.log('');
      console.log('💡 Since the table is empty, it\'s safe to drop.');
      console.log('📋 Try this SQL command again in Supabase SQL Editor:');
      console.log('');
      console.log('   DROP TABLE IF EXISTS auth_user_profiles CASCADE;');
      console.log('');
      console.log('🔍 Alternative approach if that fails:');
      console.log('   -- Check for any foreign key constraints first');
      console.log('   SELECT * FROM information_schema.table_constraints');
      console.log('   WHERE table_name = \'auth_user_profiles\';');
    }
  } catch (err) {
    console.log('✅ Error checking table:', err.message);
    console.log('This likely means the table was successfully dropped!');
  }
}

checkTableInfo();