# Supabase Storage Setup Instructions

This document explains how to properly set up Supabase Storage for use with the application.

## Important: Security Considerations

The Supabase Storage setup requires the use of a service role key which has **full admin access** to your Supabase project. This key should:

- **NEVER** be exposed in client-side code
- **NEVER** be committed to version control
- **ONLY** be used in secure server environments

## Setup Options

You have two options for setting up the required buckets and RLS policies:

### Option 1: Manual Setup via Supabase Dashboard (Recommended for Development)

1. Log in to your [Supabase Dashboard](https://app.supabase.com/)
2. Navigate to your project
3. Go to Storage in the left sidebar
4. Create a new bucket called `documents` with the following settings:

   - Public access: Disabled
   - File size limit: 50MB (or your preferred limit)

5. Then set up RLS policies. Go to Authentication > Policies and create the following policies for the `storage.objects` table:

   - **Read Policy (SELECT)**:

     ```sql
     CREATE POLICY "Allow users to read any documents"
     ON storage.objects
     FOR SELECT
     TO authenticated
     USING (bucket_id = 'documents');
     ```

   - **Insert Policy (INSERT)**:

     ```sql
     CREATE POLICY "Allow users to upload any documents"
     ON storage.objects
     FOR INSERT
     TO authenticated
     WITH CHECK (bucket_id = 'documents');
     ```

   - **Update Policy (UPDATE)**:

     ```sql
     CREATE POLICY "Allow users to update any documents"
     ON storage.objects
     FOR UPDATE
     TO authenticated
     USING (bucket_id = 'documents');
     ```

   - **Delete Policy (DELETE)**:

     ```sql
     CREATE POLICY "Allow users to delete any documents"
     ON storage.objects
     FOR DELETE
     TO authenticated
     USING (bucket_id = 'documents');
     ```

### Option 2: Automated Setup via API (Recommended for Production/CI)

We've created a secure server-side API route that can set up the storage buckets and RLS policies:

1. Add a strong random string to your environment variables as `STORAGE_SETUP_API_KEY`
2. Add your Supabase service role key to your environment variables as `SUPABASE_SERVICE_ROLE_KEY`
3. Make a POST request to `/api/storage/setup?api_key=YOUR_API_KEY` to set up the buckets and policies

Example using curl:

```bash
curl -X POST https://your-app-url.com/api/storage/setup?api_key=YOUR_API_KEY
```

Example using a deployment script:

```bash
# Example for a deployment environment like Vercel
if [ "$VERCEL_ENV" = "production" ]; then
  echo "Setting up Supabase Storage..."
  curl -X POST "https://$VERCEL_URL/api/storage/setup?api_key=$STORAGE_SETUP_API_KEY"
fi
```

## Troubleshooting

If you encounter errors related to storage, check the following:

1. Ensure the `documents` bucket exists in your Supabase project
2. Verify RLS policies are correctly set up for the `storage.objects` table
3. Check that your client-side authentication is working correctly (JWT tokens are valid)
4. Ensure your app has the necessary environment variables:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `SUPABASE_SERVICE_ROLE_KEY` (server-side only)

If file uploads fail with permission errors, this is likely a RLS policy issue. Review the policies to ensure authenticated users have the necessary permissions.
