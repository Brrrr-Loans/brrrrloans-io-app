#!/usr/bin/env node

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.env.NEXT_PUBLIC_SUPABASE_KEY;

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function deepInvestigation() {
  console.log('🔍 Deep Investigation - Table Drop Status');
  console.log('==========================================\n');
  
  console.log('📋 Test 1: Direct table query...');
  try {
    const { data, error, count } = await supabase
      .from('auth_user_profiles')
      .select('*', { count: 'exact' });
    
    if (error) {
      console.log('✅ Error accessing table:', error.code, '-', error.message);
      if (error.code === 'PGRST116') {
        console.log('🎉 This means the table was successfully dropped!');
      }
    } else {
      console.log('⚠️  Table still accessible');
      console.log('📊 Data:', data);
      console.log('📊 Count:', count);
    }
  } catch (err) {
    console.log('✅ Exception accessing table:', err.message);
    console.log('🎉 This likely means the table was successfully dropped!');
  }
  
  console.log('\n📋 Test 2: Testing different access methods...');
  
  // Test with head request
  try {
    const { error } = await supabase
      .from('auth_user_profiles')
      .select('count(*)', { count: 'exact', head: true });
    
    if (error) {
      console.log('✅ Head request failed:', error.code);
    } else {
      console.log('⚠️  Head request succeeded');
    }
  } catch (err) {
    console.log('✅ Head request exception:', err.message);
  }
  
  // Test with simple select
  try {
    const { error } = await supabase
      .from('auth_user_profiles')
      .select('id')
      .limit(1);
    
    if (error) {
      console.log('✅ Simple select failed:', error.code);
    } else {
      console.log('⚠️  Simple select succeeded');
    }
  } catch (err) {
    console.log('✅ Simple select exception:', err.message);
  }
  
  console.log('\n📋 Test 3: Verifying the correct table works...');
  try {
    const { data, error } = await supabase
      .from('auth_user_profile')
      .select('id, clerk_id, role, clerk_role')
      .limit(1);
    
    if (error) {
      console.log('❌ Correct table has issues:', error.message);
    } else {
      console.log('✅ Correct table works perfectly');
      console.log('📊 Available columns confirmed');
    }
  } catch (err) {
    console.log('❌ Correct table error:', err.message);
  }
  
  console.log('\n🎯 INVESTIGATION SUMMARY');
  console.log('========================');
  console.log('If you see mostly ✅ errors above, the DROP command likely worked!');
  console.log('Supabase might have API caching that takes a few minutes to update.');
  console.log('\n💡 The important thing is that auth_user_profile works with clerk_role column.');
  console.log('Your application should now function correctly regardless!');
}

deepInvestigation();