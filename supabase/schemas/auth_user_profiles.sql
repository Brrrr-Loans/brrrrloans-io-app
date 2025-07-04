create table if not exists "public"."auth_user_profiles" (
    "id" bigint generated by default as identity not null,
    "contact_id" bigint,
    "updated_at" timestamp with time zone default (now() AT TIME ZONE 'utc'::text),
    "role" user_role_internal,
    "is_active_yn" boolean default true,
    "deactivation_date" date,
    "invitation_date" date,
    "activated_date" date,
    "is_internal_yn" boolean not null default false,
    "email" character varying(255),
    "office_phone" text,
    "clerk_id" text,
    "username" text,
    "first_name" text,
    "last_name" text,
    "cell_phone" text,
    "office_phone_extension" text,
    "is_locked" boolean default false,
    "is_banned" boolean default false,
    "last_active_at" timestamp with time zone,
    "last_sign_in_at" timestamp with time zone,
    "legal_accepted_at" timestamp with time zone,
    "email_verified" boolean default false,
    "email_verified_at" timestamp with time zone,
    "create_organization_enabled" boolean default false,
    "delete_self_enabled" boolean default false,
    "has_image" boolean default false,
    "image_url" text,
    "full_name" text generated always as (TRIM(BOTH FROM ((COALESCE(first_name, ''::text) || ' '::text) || COALESCE(last_name, ''::text)))) stored,
    "avatar_url" text,
    "website" text
);

alter table "public"."auth_user_profiles" enable row level security;

alter table "public"."auth_user_profiles" add constraint "auth_user_profiles_pkey" primary key ("id");
create unique index "auth_user_profiles_username_key" on public.auth_user_profiles (username);
create unique index "auth_user_profiles_clerk_id_key" on public.auth_user_profiles (clerk_id);
alter table "public"."auth_user_profiles" add constraint "auth_user_profiles_contact_id_fkey" foreign key ("contact_id") references "public"."contact" ("id"); 