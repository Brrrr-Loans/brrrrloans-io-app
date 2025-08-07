--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.13 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA auth;


--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA extensions;


--
-- Name: pg_cron; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_cron WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_cron; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_cron IS 'Job scheduler for PostgreSQL';


--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql;


--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql_public;


--
-- Name: pg_net; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_net; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_net IS 'Async HTTP';


--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA pgbouncer;


--
-- Name: pgsodium; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA pgsodium;


--
-- Name: pgsodium; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgsodium WITH SCHEMA pgsodium;


--
-- Name: EXTENSION pgsodium; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgsodium IS 'Pgsodium is a modern cryptography library for Postgres.';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA realtime;


--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA storage;


--
-- Name: supabase_functions; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA supabase_functions;


--
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA supabase_migrations;


--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA vault;


--
-- Name: http; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS http WITH SCHEMA extensions;


--
-- Name: EXTENSION http; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION http IS 'HTTP client for PostgreSQL, allows web page retrieval inside the database.';


--
-- Name: moddatetime; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS moddatetime WITH SCHEMA extensions;


--
-- Name: EXTENSION moddatetime; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION moddatetime IS 'functions for tracking last modification time';


--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgaudit; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgaudit WITH SCHEMA extensions;


--
-- Name: EXTENSION pgaudit; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgaudit IS 'provides auditing functionality';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: wrappers; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS wrappers WITH SCHEMA extensions;


--
-- Name: EXTENSION wrappers; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION wrappers IS 'Foreign data wrappers developed by Supabase';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


--
-- Name: amortization_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.amortization_type AS ENUM (
    'fixed_rate',
    'adjustable_rate'
);


--
-- Name: appraisal_order_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.appraisal_order_status AS ENUM (
    'accepted_by_vendor',
    'action_required',
    'appraiser_waiting_for_contract',
    'appraiser_waiting_for_lease',
    'appraiser_waiting_for_questionnaire',
    'assigned_to_vendor',
    'awaiting_confirmation_for_appointment',
    'awaiting_fee_approval_from_client',
    'awaiting_info_from_client',
    'awaiting_trip_fee_approval_to_proceed',
    'cancelled',
    'completed',
    'declined_by_vendor',
    'file_in_review',
    'in_progress',
    'inspected',
    'inspection_scheduled',
    'left_message_with_contact',
    'on_hold',
    'order_Is_due_today',
    'payment_pending',
    'please_submit_report_order_past_due',
    'reconsideration_requested',
    'reconsideration_requested_urgent',
    'report_accepted',
    'report_accepted_awaiting_payment',
    'revision_requested',
    'revision_requested_urgent',
    'unassigned',
    'unassigned_awaiting_bids'
);


--
-- Name: appraisal_order_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.appraisal_order_type AS ENUM (
    'commercial',
    'residential'
);


--
-- Name: TYPE appraisal_order_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.appraisal_order_type IS 'commercial appraisal v residential appraisal';


--
-- Name: citizenship; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.citizenship AS ENUM (
    'U.S. Citizen',
    'Permanent Resident',
    'Non-Permanent Resident',
    'Foreign National'
);


--
-- Name: clerk_org_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.clerk_org_role AS ENUM (
    'admin',
    'member'
);


--
-- Name: company_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.company_role AS ENUM (
    'Borrowing Entity',
    'Broker',
    'Insurance',
    'Legal',
    'Title',
    'Appraisal',
    'Appraisal Management Company',
    'Lender',
    'Loan Buyer',
    'Balance Sheet Investor',
    'Environmental',
    'Escrow',
    'Entity Member (Layer)'
);


--
-- Name: condo_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.condo_type AS ENUM (
    'warrantable',
    'non_warrantable'
);


--
-- Name: TYPE condo_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.condo_type IS 'warrantability';


--
-- Name: constant_types; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.constant_types AS ENUM (
    'Text',
    'Numeric',
    'Boolean'
);


--
-- Name: TYPE constant_types; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.constant_types IS 'Types of constants that can be defined';


--
-- Name: contact_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.contact_type AS ENUM (
    'Appraisal Administration',
    'Appraisal Management Company',
    'Appraiser',
    'Borrower',
    'Borrower Assistant',
    'Broker',
    'Broker Loan Processor',
    'General Contractor',
    'Entity Member',
    'Escrow',
    'Insurance',
    'Balance Sheet Investor',
    'Lender',
    'Point of Contact',
    'Referring Party',
    'Title',
    'Transaction Coordinator',
    'Loan Buyer'
);


--
-- Name: continents; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.continents AS ENUM (
    'africa',
    'antarctica',
    'asia',
    'europe',
    'oceania',
    'north_america',
    'south_america'
);


--
-- Name: country_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.country_enum AS ENUM (
    'Bonaire, Sint Eustatius and Saba',
    'Curaçao',
    'Guernsey',
    'Isle of Man',
    'Jersey',
    'Åland Islands',
    'Montenegro',
    'Saint Barthélemy',
    'Saint Martin (French part)',
    'Serbia',
    'Sint Maarten (Dutch part)',
    'South Sudan',
    'Timor-Leste',
    'American Samoa',
    'Andorra',
    'Angola',
    'Anguilla',
    'Antarctica',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Aruba',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bermuda',
    'Bhutan',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Bouvet Island',
    'Brazil',
    'British Indian Ocean Territory',
    'Brunei Darussalam',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Cape Verde',
    'Cayman Islands',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Christmas Island',
    'Cocos (Keeling) Islands',
    'Colombia',
    'Comoros',
    'Congo',
    'Congo, the Democratic Republic of the',
    'Cook Islands',
    'Costa Rica',
    'Cote DIvoire',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Ethiopia',
    'Falkland Islands (Malvinas)',
    'Faroe Islands',
    'Fiji',
    'Finland',
    'France',
    'French Guiana',
    'French Polynesia',
    'French Southern Territories',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Gibraltar',
    'Greece',
    'Greenland',
    'Grenada',
    'Guadeloupe',
    'Guam',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Heard Island and Mcdonald Islands',
    'Holy See (Vatican City State)',
    'Honduras',
    'Hong Kong',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran, Islamic Republic of',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Korea, Democratic People''s Republic of',
    'Korea, Republic of',
    'Kuwait',
    'Kyrgyzstan',
    'Lao People''s Democratic Republic',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Macao',
    'Macedonia, the Former Yugoslav Republic of',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Martinique',
    'Mauritania',
    'Mauritius',
    'Mayotte',
    'Mexico',
    'Micronesia, Federated States of',
    'Moldova, Republic of',
    'Monaco',
    'Mongolia',
    'Albania',
    'Montserrat',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Caledonia',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'Niue',
    'Norfolk Island',
    'Northern Mariana Islands',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestine, State of',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Pitcairn',
    'Poland',
    'Portugal',
    'Puerto Rico',
    'Qatar',
    'Reunion',
    'Romania',
    'Russian Federation',
    'Rwanda',
    'Saint Helena, Ascension and Tristan da Cunha',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Pierre and Miquelon',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Georgia and the South Sandwich Islands',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Svalbard and Jan Mayen',
    'Swaziland',
    'Sweden',
    'Switzerland',
    'Syrian Arab Republic',
    'Taiwan (Province of China)',
    'Tajikistan',
    'Tanzania, United Republic of',
    'Thailand',
    'Togo',
    'Tokelau',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Turks and Caicos Islands',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States',
    'United States Minor Outlying Islands',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Venezuela',
    'Viet Nam',
    'Virgin Islands (British)',
    'Virgin Islands (U.S.)',
    'Wallis and Futuna',
    'Western Sahara',
    'Yemen',
    'Zambia',
    'Zimbabwe',
    'Afghanistan',
    'Algeria'
);


--
-- Name: credit_check_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.credit_check_status AS ENUM (
    'Payment Needed',
    'Paid',
    'Approved',
    'Denied',
    'Frozen',
    'Under Review'
);


--
-- Name: TYPE credit_check_status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.credit_check_status IS 'Status of credit check for a borrower or guarantor';


--
-- Name: deal_disposition_1; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.deal_disposition_1 AS ENUM (
    'active',
    'dead',
    'on_hold'
);


--
-- Name: deal_stage_1; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.deal_stage_1 AS ENUM (
    'lead',
    'scenario',
    'deal'
);


--
-- Name: deal_stage_2; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.deal_stage_2 AS ENUM (
    'loan_setup',
    'processing_1',
    'appraisal_review',
    'processing_2',
    'qc_1',
    'underwriting',
    'conditionally_approved',
    'qc_2',
    'clear_to_close',
    'closed_and_funded'
);


--
-- Name: deal_status_primary; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.deal_status_primary AS ENUM (
    'Scenario',
    'Loan Setup',
    'Pre-Qual Review (PQR)',
    'Processing I',
    'Appraisal Review',
    'Processing II',
    'Pre-Submission Review (PSR)',
    'Underwriting',
    'Conditionally Approved',
    'Clear to Close',
    'Closed & Funded'
);


--
-- Name: deal_status_primary__old_version_to_be_dropped; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.deal_status_primary__old_version_to_be_dropped AS ENUM (
    'Prequal',
    'Scenario',
    'Active',
    'Complete',
    'Dead/Archived'
);


--
-- Name: debt_instrument_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.debt_instrument_type AS ENUM (
    'mortgage_note',
    'bridge_loan',
    'construction_loan',
    'rehab_loan',
    'senior_debt',
    'convertible_note',
    'mortgage_pool',
    'asset_backed_security',
    'other'
);


--
-- Name: document_category; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.document_category AS ENUM (
    'application',
    'appraisal',
    'assets',
    'closing',
    'credit_and_background',
    'construction',
    'environmental',
    'experience',
    'id',
    'insurance',
    'pricing',
    'property',
    'seasoning',
    'servicing',
    'title',
    'entity'
);


--
-- Name: document_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.document_role AS ENUM (
    'Loan Officer',
    'Loan Opener',
    'Processor',
    'Broker',
    'Borrower',
    'Borrower/Broker',
    'Processor/Broker'
);


--
-- Name: document_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.document_status AS ENUM (
    'approved',
    'pending_review',
    'pending_submission',
    'pending_exception',
    'rejected_items_needed',
    'rejected_revisions_needed',
    'rejected_signature_needed'
);


--
-- Name: entity_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.entity_type AS ENUM (
    'corp',
    'general_partnership',
    'limited_liability_company',
    'limited_liability_partnership',
    'limited_partnership',
    's_corp',
    'sole_proprietorship'
);


--
-- Name: TYPE entity_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.entity_type IS 'company tax classification';


--
-- Name: fee_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.fee_type AS ENUM (
    'lender_fee',
    'broker_fee',
    'appraisal_fee',
    'title_fee',
    'property_tax_-_city/town',
    'property_tax_-_county',
    'property_tax_-_school',
    'lender_holdback',
    'lender_reserve',
    'insurance _premium',
    'credit_and_background_fee',
    'judgment',
    'lien',
    'recording_and_transfer_fee',
    'transfer_tax',
    'lender_escrow'
);


--
-- Name: TYPE fee_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.fee_type IS 'Types of loan fees';


--
-- Name: lead_source; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.lead_source AS ENUM (
    'biggerpockets',
    'broker',
    'brrrr.com_chat',
    'brrrr.com_form_submission',
    'direct_mail_marketing',
    'email_marketing',
    'event_conference_tradeshow',
    'existing_client',
    'podcast',
    'search_engine',
    'referral',
    'social_media',
    'other',
    'reia'
);


--
-- Name: lease_length; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.lease_length AS ENUM (
    'N/A',
    'STR',
    'Unoccupied',
    '12',
    '24',
    '36'
);


--
-- Name: ledger_entry_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.ledger_entry_type AS ENUM (
    'contribution',
    'redemption',
    'interest',
    'fee'
);


--
-- Name: loan_accrual_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.loan_accrual_type AS ENUM (
    '30/360',
    '30/365',
    'Actual 360',
    'Actual 365'
);


--
-- Name: loan_amortization; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.loan_amortization AS ENUM (
    'interest_only',
    '300',
    '360'
);


--
-- Name: loan_program; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.loan_program AS ENUM (
    'BPL Program A',
    'BPL Program B'
);


--
-- Name: TYPE loan_program; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.loan_program IS 'List of loan programs';


--
-- Name: loan_structure_dscr; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.loan_structure_dscr AS ENUM (
    '30_yr_fixed',
    '5/1_arm',
    '7/1_arm',
    '10/1_arm_io',
    '5/6_arm',
    '10/6_arm'
);


--
-- Name: TYPE loan_structure_dscr; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.loan_structure_dscr IS 'loan_structure_dscr_bplmortgagetrust';


--
-- Name: loan_term_months; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.loan_term_months AS ENUM (
    '6',
    '12',
    '15',
    '18',
    '24',
    '36',
    '48',
    '60',
    '72',
    '84',
    '96',
    '108',
    '120',
    '300',
    '360'
);


--
-- Name: TYPE loan_term_months; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.loan_term_months IS 'term duration (months)';


--
-- Name: loan_type_1; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.loan_type_1 AS ENUM (
    'dscr',
    'rtl'
);


--
-- Name: loan_type_2; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.loan_type_2 AS ENUM (
    'bridge',
    'bridge_plus_rehab'
);


--
-- Name: ltv_scores; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.ltv_scores AS (
	ltv_1 numeric,
	ltv_2 numeric,
	ltv_3 numeric,
	ltv_4 numeric,
	ltv_5 numeric,
	ltv_6 numeric,
	ltv_7 numeric
);


--
-- Name: marital_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.marital_status AS ENUM (
    'Married',
    'Separated',
    'Unmarried'
);


--
-- Name: max_ltv_scores; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.max_ltv_scores AS (
	purchase_ltv numeric,
	delayed_purchase_ltv numeric,
	refinance_rt_ltv numeric,
	refinance_co_ltv numeric
);


--
-- Name: milestone_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.milestone_status AS ENUM (
    'to_do',
    'in_progress',
    'completed'
);


--
-- Name: ppp_structure; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.ppp_structure AS ENUM (
    'Declining',
    'Fixed 5%',
    'Fixed 4%',
    'Fixed 3%',
    'Fixed 2%',
    'Fixed 1%',
    'Interest',
    'Minimum Interest'
);


--
-- Name: TYPE ppp_structure; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.ppp_structure IS 'pre-payment penalty structure';


--
-- Name: ppp_structure_1; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.ppp_structure_1 AS ENUM (
    'declining',
    'fixed',
    'minimum_interest'
);


--
-- Name: ppp_term; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.ppp_term AS ENUM (
    '0',
    '12',
    '24',
    '36',
    '48',
    '60',
    '72',
    '84',
    '96',
    '108',
    '120'
);


--
-- Name: TYPE ppp_term; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.ppp_term IS 'prepayment penalty duration (months)';


--
-- Name: professional_license; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.professional_license AS ENUM (
    'Appraiser',
    'Certified Public Accountant (CPA)',
    'General Contractor',
    'Lender',
    'Mortgage (NMLS)',
    'Real Estate Broker',
    'Property Manager'
);


--
-- Name: project_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.project_status AS ENUM (
    'Sold',
    'Held',
    'In Progress'
);


--
-- Name: TYPE project_status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.project_status IS 'Status of a project in a borrower''s track record';


--
-- Name: project_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.project_type AS ENUM (
    'fix_and_flip',
    'ground_up',
    'rental',
    'stabilized_bridge'
);


--
-- Name: TYPE project_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.project_type IS 'investment strategy or loan purpose';


--
-- Name: property_appraisal_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.property_appraisal_status AS ENUM (
    'Payment Needed',
    'Paid',
    'Ordered',
    'Received',
    'Revision Needed',
    'Revision Requested',
    'Completed'
);


--
-- Name: TYPE property_appraisal_status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.property_appraisal_status IS 'Status of appraisal for a property';


--
-- Name: property_lease_term_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.property_lease_term_status AS ENUM (
    'active',
    'expired',
    'month_to_month'
);


--
-- Name: property_occupancy; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.property_occupancy AS ENUM (
    'Vacant',
    'Tenant Occupied',
    'Owner Occupied'
);


--
-- Name: property_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.property_type AS ENUM (
    'Single Family',
    'Condominium',
    'Condominium Warrantable',
    'Condominium Non-Warrantable',
    'Multifamily 2-4',
    'Multifamily 5-10',
    'Townhome/PUD',
    'Multifamily 11+',
    'Mixed Use 2-4',
    'Mixed Use 5-10',
    'Mixed Use 11+',
    'Other'
);


--
-- Name: residence_ownership; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.residence_ownership AS ENUM (
    'Own',
    'Rent'
);


--
-- Name: task_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.task_status AS ENUM (
    'not_started',
    'in_progress',
    'completed'
);


--
-- Name: transaction_method; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.transaction_method AS ENUM (
    'ach',
    'billpay',
    'cash',
    'check',
    'credit_card',
    'cryptocurrency',
    'debit_card',
    'internal',
    'rtp',
    'wire',
    'other'
);


--
-- Name: transaction_reference_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.transaction_reference_type AS ENUM (
    'federal_reference_number',
    'imad',
    'omad'
);


--
-- Name: transaction_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.transaction_status AS ENUM (
    'canceled',
    'completed',
    'failed',
    'initiated',
    'on_hold',
    'owed',
    'pending',
    'processing',
    'refunded',
    'returned',
    'scheduled'
);


--
-- Name: transaction_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.transaction_type AS ENUM (
    'purchase',
    'delayed_purchase',
    'refinance_rate_term',
    'refinance_cash_out'
);


--
-- Name: true_false; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.true_false AS ENUM (
    'true',
    'false'
);


--
-- Name: us_states; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.us_states AS ENUM (
    'AL',
    'AK',
    'AZ',
    'AR',
    'CA',
    'CO',
    'CT',
    'DC',
    'DE',
    'FL',
    'GA',
    'HI',
    'ID',
    'IL',
    'IN',
    'IA',
    'KS',
    'KY',
    'LA',
    'ME',
    'MD',
    'MA',
    'MI',
    'MN',
    'MS',
    'MO',
    'MT',
    'NE',
    'NV',
    'NH',
    'NJ',
    'NM',
    'NY',
    'NC',
    'ND',
    'OH',
    'OK',
    'OR',
    'PA',
    'PR',
    'RI',
    'SC',
    'SD',
    'TN',
    'TX',
    'UT',
    'VT',
    'VA',
    'WA',
    'WV',
    'WI',
    'WY'
);


--
-- Name: us_states_long; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.us_states_long AS ENUM (
    'alabama',
    'alaska',
    'arizona',
    'arkansas',
    'california',
    'colorado',
    'connecticut',
    'delaware',
    'district_of_columbia',
    'florida',
    'georgia',
    'hawaii',
    'idaho',
    'illinois',
    'indiana',
    'iowa',
    'kansas',
    'kentucky',
    'louisiana',
    'maine',
    'maryland',
    'massachusetts',
    'michigan',
    'minnesota',
    'mississippi',
    'missouri',
    'montana',
    'nebraska',
    'nevada',
    'new_hampshire',
    'new_jersey',
    'new_mexico',
    'new_york',
    'north_carolina',
    'north_dakota',
    'ohio',
    'oklahoma',
    'oregon',
    'pennsylvania',
    'rhode_island',
    'south_carolina',
    'south_dakota',
    'tennessee',
    'texas',
    'utah',
    'vermont',
    'virginia',
    'washington',
    'west_virginia',
    'wisconsin',
    'wyoming'
);


--
-- Name: user_role_internal; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_role_internal AS ENUM (
    'admin',
    'account_executive',
    'loan_processor',
    'balance_sheet_investor',
    'loan_opener'
);


--
-- Name: TYPE user_role_internal; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.user_role_internal IS 'internal user roles ';


--
-- Name: vesting_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.vesting_type AS ENUM (
    'entity',
    'Individual'
);


--
-- Name: TYPE vesting_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE public.vesting_type IS 'the loan will close (title will vest) in the name of a(n):';


--
-- Name: warrantability; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.warrantability AS ENUM (
    'warrantable',
    'non-warrantable'
);


--
-- Name: yes_no; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.yes_no AS ENUM (
    'yes',
    'no'
);


--
-- Name: action; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    IF EXISTS (
      SELECT 1
      FROM pg_event_trigger_ddl_commands() AS ev
      JOIN pg_extension AS ext
      ON ev.objid = ext.oid
      WHERE ext.extname = 'pg_net'
    )
    THEN
      IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'supabase_functions_admin'
      )
      THEN
        CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
      END IF;

      GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

      IF EXISTS (
        SELECT FROM pg_extension
        WHERE extname = 'pg_net'
        -- all versions in use on existing projects as of 2025-02-20
        -- version 0.12.0 onwards don't need these applied
        AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8.0', '0.10.0', '0.11.0')
      ) THEN
        ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
        ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

        ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
        ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

        REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
        REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

        GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
        GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      END IF;
    END IF;
  END;
  $$;


--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: -
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


--
-- Name: format_address(text, text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.format_address(po_box text, street text, apt_suite text, city text, state text, postal_code text, country text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    formatted_address text;
BEGIN
    -- Initialize an array to hold address components
    formatted_address := TRIM(BOTH ', ' FROM
        array_to_string(
            ARRAY_REMOVE(
                ARRAY[
                    NULLIF(street, ''),
                    NULLIF(apt_suite, ''),
                    NULLIF(city, ''),
                    CASE
                        WHEN COALESCE(state, '') <> '' AND COALESCE(postal_code, '') <> '' THEN
                            state || ' ' || postal_code
                        WHEN COALESCE(state, '') <> '' THEN
                            state
                        WHEN COALESCE(postal_code, '') <> '' THEN
                            postal_code
                        ELSE
                            NULL
                    END,
                    NULLIF(country, ''),
                    CASE 
                        WHEN COALESCE(po_box, '') <> '' THEN
                            'PO Box ' || po_box 
                        ELSE 
                            NULL 
                    END
                ],
                NULL
            ),
            ', '
        )
    );

    -- Return the formatted address
    RETURN formatted_address;
END;
$$;


--
-- Name: format_deal_name(bigint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.format_deal_name(property_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    formatted_name text;
BEGIN
    SELECT 
        CONCAT_WS(', ', 
            p.address_street, 
            p.address_suite_apt, 
            p.address_city || ', ' || p.address_state || ' ' || p.address_postal_code
        )
    INTO formatted_name
    FROM public.property p
    WHERE p.id = property_id;

    RETURN formatted_name;
END;
$$;


--
-- Name: get_jsonb_array_element(jsonb, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_jsonb_array_element(array_value jsonb, index integer) RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    RETURN (
        with elements as (
          with x as (
            select jsonb_array_elements_text(array_value) AS element) 
            select x.element, row_number() over() as element_index from x
          ) 
        select elements.element from elements where elements.element_index = index);
END;
$$;


--
-- Name: get_numeric_constant(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_numeric_constant(constant_name text) RETURNS numeric
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    result numeric;
BEGIN
    -- Retrieve the constant record based on the given name
    SELECT numeric_value INTO result
    FROM public.constants
    WHERE name = constant_name;

    -- Check if the constant record exists
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Constant with name % not found', constant_name;
    END IF;

    return result;
END;
$$;


--
-- Name: get_state_code(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_state_code(state_name text) RETURNS public.us_states
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$BEGIN
    state_name := LOWER(state_name); -- Convert input to lowercase
    CASE state_name
        WHEN 'alabama' THEN RETURN 'AL';
        WHEN 'alaska' THEN RETURN 'AK';
        WHEN 'arizona' THEN RETURN 'AZ';
        WHEN 'arkansas' THEN RETURN 'AR';
        WHEN 'california' THEN RETURN 'CA';
        WHEN 'colorado' THEN RETURN 'CO';
        WHEN 'connecticut' THEN RETURN 'CT';
        WHEN 'delaware' THEN RETURN 'DE';
        WHEN 'florida' THEN RETURN 'FL';
        WHEN 'georgia' THEN RETURN 'GA';
        WHEN 'hawaii' THEN RETURN 'HI';
        WHEN 'idaho' THEN RETURN 'ID';
        WHEN 'illinois' THEN RETURN 'IL';
        WHEN 'indiana' THEN RETURN 'IN';
        WHEN 'iowa' THEN RETURN 'IA';
        WHEN 'kansas' THEN RETURN 'KS';
        WHEN 'kentucky' THEN RETURN 'KY';
        WHEN 'louisiana' THEN RETURN 'LA';
        WHEN 'maine' THEN RETURN 'ME';
        WHEN 'maryland' THEN RETURN 'MD';
        WHEN 'massachusetts' THEN RETURN 'MA';
        WHEN 'michigan' THEN RETURN 'MI';
        WHEN 'minnesota' THEN RETURN 'MN';
        WHEN 'mississippi' THEN RETURN 'MS';
        WHEN 'missouri' THEN RETURN 'MO';
        WHEN 'montana' THEN RETURN 'MT';
        WHEN 'nebraska' THEN RETURN 'NE';
        WHEN 'nevada' THEN RETURN 'NV';
        WHEN 'new_hampshire' THEN RETURN 'NH';
        WHEN 'new_jersey' THEN RETURN 'NJ';
        WHEN 'new_mexico' THEN RETURN 'NM';
        WHEN 'new_york' THEN RETURN 'NY';
        WHEN 'north_carolina' THEN RETURN 'NC';
        WHEN 'north_dakota' THEN RETURN 'ND';
        WHEN 'ohio' THEN RETURN 'OH';
        WHEN 'oklahoma' THEN RETURN 'OK';
        WHEN 'oregon' THEN RETURN 'OR';
        WHEN 'pennsylvania' THEN RETURN 'PA';
        WHEN 'rhode_island' THEN RETURN 'RI';
        WHEN 'south_carolina' THEN RETURN 'SC';
        WHEN 'south_dakota' THEN RETURN 'SD';
        WHEN 'tennessee' THEN RETURN 'TN';
        WHEN 'texas' THEN RETURN 'TX';
        WHEN 'utah' THEN RETURN 'UT';
        WHEN 'vermont' THEN RETURN 'VT';
        WHEN 'virginia' THEN RETURN 'VA';
        WHEN 'washington' THEN RETURN 'WA';
        WHEN 'west_virginia' THEN RETURN 'WV';
        WHEN 'wisconsin' THEN RETURN 'WI';
        WHEN 'wyoming' THEN RETURN 'WY';
        ELSE RETURN NULL;
    END CASE;
END;$$;


--
-- Name: get_text_constant(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_text_constant(constant_name text) RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    result text;
BEGIN
    -- Retrieve the constant record based on the given name
    SELECT text_value INTO result
    FROM public.constants
    WHERE name = constant_name;

    -- Check if the constant record exists
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Constant with name % not found', constant_name;
    END IF;

    return result;
END;
$$;


--
-- Name: get_yesno_constant(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_yesno_constant(constant_name text) RETURNS public.yes_no
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    result yes_no;
BEGIN
    -- Retrieve the constant record based on the given name
    SELECT yes_no_value INTO result
    FROM public.constants
    WHERE name = constant_name;

    -- Check if the constant record exists
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Constant with name % not found', constant_name;
    END IF;

    return result;
END;
$$;


--
-- Name: handle_new_deal(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.handle_new_deal() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$declare 
  program_a_id int8;
  program_b_id int8;
begin

  insert into loan_program_a (loan_amount)
  values (0)
  returning id into program_a_id;

  insert into loan_program_b (loan_amount)
  values (0)
  returning id into program_b_id;

  NEW.program_a_id := program_a_id;
  NEW.program_b_id := program_b_id;
  return NEW;
end;$$;


--
-- Name: handle_new_loan_application(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.handle_new_loan_application() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  guarantor_count int;
  company_member_count int;
  company_member_borrower_id int;
  company_member_company_id int;
  company_member_guarantor_index text;
  counter int;
  new_deal_id bigint;
  new_company_id bigint;
  new_primary_borrower_id bigint;
  new_second_borrower_id bigint;
  new_third_borrower_id bigint;
  new_fourth_borrower_id bigint;
  new_primary_guarantor_id bigint;
  new_second_guarantor_id bigint;
  new_third_guarantor_id bigint;
  new_fourth_guarantor_id bigint;
  new_property_id bigint;
  submission_data JSONB;
BEGIN
  submission_data := NEW.submission::JSONB;
  BEGIN
  -- Create the property
    new_property_id := create_property_from_submission(submission_data);

  -- Create the deal
    new_deal_id := create_deal_from_submission(submission_data, new_property_id);

  -- Create the borrowers and set them as guarantors on the deal
    guarantor_count := CAST(NULLIF(submission_data->>'numberGuarantors', '') AS numeric);
    IF guarantor_count > 0 THEN
      new_primary_borrower_id = create_submission_borrower(
        submission_data->>'primaryGuarantorFirstName',
        submission_data->>'primaryGuarantorMiddleName',
        submission_data->>'primaryGuarantorLastName',
        submission_data->>'primaryGuarantorEmail',
        submission_data->>'primaryGuarantorCellPhone',
        submission_data->>'primaryGuarantorAlternatePhone',
        CAST(NULLIF(submission_data->>'primaryGuarantorCitizenship', '') AS citizenship),
        submission_data->>'primaryGuarantorSSN',
        TO_DATE(submission_data->>'primaryGuarantorDateOfBirth', 'YYYY-MM-DD'),
        submission_data->>'primaryGuarantorAddress',
        submission_data->>'primaryGuarantorAddressLine2',
        submission_data->>'primaryGuarantorCity',
        CAST(NULLIF(submission_data->>'primaryGuarantorState', '') AS us_states_long),
        submission_data->>'primaryGuarantorPostalCode',
        submission_data->>'primaryGuarantorCounty',
        submission_data->>'primaryGuarantorCountry',
        CAST(NULLIF(submission_data->>'primaryGuarantorFICO', '') as numeric),
        CAST(NULLIF(submission_data->>'primaryGuarantorRentalsOwned', '') as numeric),
        CAST(NULLIF(submission_data->>'primaryGuarantorFixAndFlip', '') as numeric),
        CAST(NULLIF(submission_data->>'primaryGuarantorGroundUp', '') as numeric),
        CAST(submission_data->>'primaryGuarantorExperienced' as yes_no)
      );

      new_primary_guarantor_id = create_submission_guarantor(new_deal_id, new_primary_borrower_id, 
        submission_data->>'primaryGuarantorFirstName',
        submission_data->>'primaryGuarantorMiddleName',
        submission_data->>'primaryGuarantorLastName',
        submission_data->>'primaryGuarantorEmail',
        submission_data->>'primaryGuarantorCellPhone'
      );
    END IF;

    IF guarantor_count > 1 THEN
      new_second_borrower_id = create_submission_borrower(
        submission_data->>'secondGuarantorFirstName',
        submission_data->>'secondGuarantorMiddleName',
        submission_data->>'secondGuarantorLastName',
        submission_data->>'secondGuarantorEmail',
        submission_data->>'secondGuarantorCellPhone',
        submission_data->>'secondGuarantorAlternatePhone',
        CAST(NULLIF(submission_data->>'secondGuarantorCitizenship', '') AS citizenship),
        submission_data->>'secondGuarantorSSN',
        TO_DATE(submission_data->>'secondGuarantorDateOfBirth', 'YYYY-MM-DD'),
        submission_data->>'secondGuarantorAddress',
        submission_data->>'secondGuarantorAddressLine2',
        submission_data->>'secondGuarantorCity',
        CAST(NULLIF(submission_data->>'secondGuarantorState', '') AS us_states_long),
        submission_data->>'secondGuarantorPostalCode',
        submission_data->>'secondGuarantorCounty',
        submission_data->>'secondGuarantorCountry',
        CAST(NULLIF(submission_data->>'secondGuarantorFICO', '') as numeric),
        CAST(NULLIF(submission_data->>'secondGuarantorRentalsOwned', '') as numeric),
        CAST(NULLIF(submission_data->>'secondGuarantorFixAndFlip', '') as numeric),
        CAST(NULLIF(submission_data->>'secondGuarantorGroundUp', '') as numeric),
        CAST(submission_data->>'secondGuarantorExperienced' as yes_no)
      );

      new_second_guarantor_id = create_submission_guarantor(new_deal_id, new_second_borrower_id, 
        submission_data->>'secondGuarantorFirstName',
        submission_data->>'secondGuarantorMiddleName',
        submission_data->>'secondGuarantorLastName',
        submission_data->>'secondGuarantorEmail',
        submission_data->>'secondGuarantorCellPhone'
      );
    END IF;

    IF guarantor_count > 2 THEN
      new_third_borrower_id = create_submission_borrower(
        submission_data->>'thirdGuarantorFirstName',
        submission_data->>'thirdGuarantorMiddleName',
        submission_data->>'thirdGuarantorLastName',
        submission_data->>'thirdGuarantorEmail',
        submission_data->>'thirdGuarantorCellPhone',
        submission_data->>'thirdGuarantorAlternatePhone',
        CAST(NULLIF(submission_data->>'thirdGuarantorCitizenship', '') AS citizenship),
        submission_data->>'thirdGuarantorSSN',
        TO_DATE(submission_data->>'thirdGuarantorDateOfBirth', 'YYYY-MM-DD'),
        submission_data->>'thirdGuarantorAddress',
        submission_data->>'thirdGuarantorAddressLine2',
        submission_data->>'thirdGuarantorCity',
        CAST(NULLIF(submission_data->>'thirdGuarantorState', '') AS us_states_long),
        submission_data->>'thirdGuarantorPostalCode',
        submission_data->>'thirdGuarantorCounty',
        submission_data->>'thirdGuarantorCountry',
        CAST(NULLIF(submission_data->>'thirdGuarantorFICO', '') as numeric),
        CAST(NULLIF(submission_data->>'thirdGuarantorRentalsOwned', '') as numeric),
        CAST(NULLIF(submission_data->>'thirdGuarantorFixAndFlip', '') as numeric),
        CAST(NULLIF(submission_data->>'thirdGuarantorGroundUp', '') as numeric),
        CAST(submission_data->>'thirdGuarantorExperienced' as yes_no)
      );

      new_third_guarantor_id = create_submission_guarantor(new_deal_id, new_third_borrower_id, 
        submission_data->>'thirdGuarantorFirstName',
        submission_data->>'thirdGuarantorMiddleName',
        submission_data->>'thirdGuarantorLastName',
        submission_data->>'thirdGuarantorEmail',
        submission_data->>'thirdGuarantorCellPhone'
      );
    END IF;

    IF guarantor_count > 3 THEN
      new_fourth_borrower_id = create_submission_borrower(
        submission_data->>'fourthGuarantorFirstName',
        submission_data->>'fourthGuarantorMiddleName',
        submission_data->>'fourthGuarantorLastName',
        submission_data->>'fourthGuarantorEmail',
        submission_data->>'fourthGuarantorCellPhone',
        submission_data->>'fourthGuarantorAlternatePhone',
        CAST(NULLIF(submission_data->>'fourthGuarantorCitizenship', '') AS citizenship),
        submission_data->>'fourthGuarantorSSN',
        TO_DATE(submission_data->>'fourthGuarantorDateOfBirth', 'YYYY-MM-DD'),
        submission_data->>'fourthGuarantorAddress',
        submission_data->>'fourthGuarantorAddressLine2',
        submission_data->>'fourthGuarantorCity',
        CAST(NULLIF(submission_data->>'fourthGuarantorState', '') AS us_states_long),
        submission_data->>'fourthGuarantorPostalCode',
        submission_data->>'fourthGuarantorCounty',
        submission_data->>'fourthGuarantorCountry',
        CAST(NULLIF(submission_data->>'fourthGuarantorFICO', '') as numeric),
        CAST(NULLIF(submission_data->>'fourthGuarantorRentalsOwned', '') as numeric),
        CAST(NULLIF(submission_data->>'fourthGuarantorFixAndFlip', '') as numeric),
        CAST(NULLIF(submission_data->>'fourthGuarantorGroundUp', '') as numeric),
        CAST(submission_data->>'fourthGuarantorExperienced' as yes_no)
      );

      new_fourth_guarantor_id = create_submission_guarantor(new_deal_id, new_fourth_borrower_id, 
        submission_data->>'fourthGuarantorFirstName',
        submission_data->>'fourthGuarantorMiddleName',
        submission_data->>'fourthGuarantorLastName',
        submission_data->>'fourthGuarantorEmail',
        submission_data->>'fourthGuarantorCellPhone'
      );
    END IF;


    IF submission_data->>'vestingEntityType' = 'Entity' THEN
      new_company_id := create_company_from_submission(submission_data);
      company_member_count := submission_data->>'numberCompanyMembers';

      IF new_company_id IS NOT NULL AND company_member_count > 0 THEN 
        counter := 1;

        WHILE counter <= company_member_count LOOP
          
          company_member_company_id := null;
          company_member_borrower_id := null;
          company_member_guarantor_index := null;

          IF get_jsonb_array_element(submission_data->'companyOwnerType', counter) = 'Entity' THEN
          -- get the company member type, if company, create a company and get the id. 
          insert into company (co_name, co_entity_type, co_ein, co_ppb_address_street, co_ppb_address_suite_apt,
            co_ppb_address_city, co_ppb_address_state_long, co_ppb_address_postal_code, co_ppb_address_country, co_role)
            values(
              get_jsonb_array_element(submission_data->'companyOwnerEntityName', counter),
              CAST(get_jsonb_array_element(submission_data->'companyOwnerEntityType', counter) AS entity_type),
              get_jsonb_array_element(submission_data->'companyOwnerEIN', counter),
              get_jsonb_array_element(submission_data->'companyOwnerStreetAddress', counter),
              get_jsonb_array_element(submission_data->'companyOwnerAddressLine2', counter),
              get_jsonb_array_element(submission_data->'companyOwnerCity', counter),
              CAST(get_jsonb_array_element(submission_data->'companyOwnerState', counter) AS us_states_long),
              get_jsonb_array_element(submission_data->'companyOwnerPostalCode', counter),
              CAST(get_jsonb_array_element(submission_data->'companyOwnerCountry', counter) AS country_enum),
              'Borrowing Entity'::company_role
            )
          returning co_id into company_member_company_id;
         
          ELSE
          -- if individual, check if is guarantor. if so get the guarantor number 
            IF get_jsonb_array_element(submission_data->'companyOwnerIsGuarantor', counter) = 'Yes' THEN
              company_member_guarantor_index := split_part(
                get_jsonb_array_element(submission_data->'companyOwnerGuarantorId', counter), ':', 1);
              company_member_borrower_id := CASE company_member_guarantor_index
                                              WHEN '1' THEN new_primary_borrower_id
                                              WHEN '2' THEN new_second_borrower_id
                                              WHEN '3' THEN new_third_borrower_id
                                              WHEN '4' THEN new_fourth_borrower_id
                                              ELSE null
                                            END;
            ELSE
              insert into borrower (first_name, middle_name, last_name, email_address, cell_phone, social_security_number,
                primary_residence_address_street, primary_residence_address_suite_apt, primary_residence_address_city, primary_residence_address_state_long, primary_residence_address_postal_code, primary_residence_address_country)
              values(
                get_jsonb_array_element(submission_data->'companyOwnerFirstName', counter),
                get_jsonb_array_element(submission_data->'companyOwnerMiddleName', counter),
                get_jsonb_array_element(submission_data->'companyOwnerLastName', counter),
                get_jsonb_array_element(submission_data->'companyOwnerEmail', counter),
                get_jsonb_array_element(submission_data->'companyOwnerCellPhone', counter),
                get_jsonb_array_element(submission_data->'companyOwnerTaxId', counter),
                get_jsonb_array_element(submission_data->'companyOwnerStreetAddress', counter),
                get_jsonb_array_element(submission_data->'companyOwnerAddressLine2', counter),
                get_jsonb_array_element(submission_data->'companyOwnerCity', counter),
                CAST(get_jsonb_array_element(submission_data->'companyOwnerState', counter) AS us_states_long),
                get_jsonb_array_element(submission_data->'companyOwnerPostalCode', counter),
                get_jsonb_array_element(submission_data->'companyOwnerCountry', counter)
              )
              returning id into company_member_borrower_id;
            END IF;
          END IF;
          -- create the member with the appropriate ids
          insert into company_member (member_company_id, 
            --member_name, 
            member_ownership_percentage, member_title, 
            member_borrower_id, member_owning_company_id, member_type, member_name_first, member_name_last, member_is_guarantor)
          values(
            new_company_id,
            --get_jsonb_array_element(submission_data->'companyOwnerName', counter),
            CAST(NULLIF(get_jsonb_array_element(submission_data->'companyOwnerOwnership', counter), '') AS double precision)/100,
            get_jsonb_array_element(submission_data->'companyOwnerTitle', counter),
            company_member_borrower_id,
            company_member_company_id,
            CAST(NULLIF(get_jsonb_array_element(submission_data->'companyOwnerType', counter), '') AS vesting_type),
            get_jsonb_array_element(submission_data->'companyOwnerFirstName', counter),
            get_jsonb_array_element(submission_data->'companyOwnerLastName', counter),
            CAST(NULLIF(get_jsonb_array_element(submission_data->'companyOwnerIsGuarantor', counter), '') AS yes_no)
          );
          counter := counter + 1;
        END LOOP;
      END IF;

    END IF;

    -- update the deal with the parties
    UPDATE deal SET
      company_id = new_company_id,
      primary_guarantor_id = new_primary_guarantor_id,
      second_guarantor_id = new_second_guarantor_id,
      third_guarantor_id = new_third_guarantor_id,
      fourth_guarantor_id = new_fourth_guarantor_id
    WHERE id = new_deal_id;
    
    IF new_deal_id IS NOT NULL THEN
      UPDATE loan_application SET 
        application_deal_id = new_deal_id,
        status = 'DEAL CREATED',
        reprocess = false 
      WHERE id = NEW.id;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
    -- Log the error (optional)
      UPDATE loan_application SET 
        status = 'ERROR',
        reprocess = false , 
        error_message = SQLERRM 
      WHERE id = NEW.id;
      RAISE LOG 'Error processing loan application submission: %', SQLERRM;
  END;
  RETURN NEW;
END;
$$;


--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$begin
  insert into public.user_profile (id, email, first_name, last_name, avatar_url)
  values (new.id, new.email, new.raw_user_meta_data->>'first_name', new.raw_user_meta_data->>'last_name', new.raw_user_meta_data->>'avatar_url');
  return new;
  return new;
end;$$;


--
-- Name: handle_user_profile_changes(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.handle_user_profile_changes() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$DECLARE contactid bigint;
BEGIN
    --Update deal table:
    --RAISE log 'Running handle_user_profile_changes function with ID: %', NEW.id;
    select id into contactid from contact where user_profile_id = NEW.id;
    UPDATE deal SET guarantor_fico_score = NEW.fico_score_mid_actual, guarantor_citizenship = NEW.citizenship, 
    guarantor_first_time_home_buyer = NEW.first_time_home_buyer, guarantor_mortgage_debt = NEW.mortgage_debt
    where primary_guarantor_id = contactid and deal.locked = false;

RETURN NEW;
END;$$;


--
-- Name: ltv(public.transaction_type, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ltv(transaction_type public.transaction_type, as_is_value numeric, purchase_price numeric, loan_amount numeric) RETURNS numeric
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    result NUMERIC;
BEGIN
    result := CASE
        WHEN transaction_type IN ('Refinance Rate/Term', 'Refinance Cash Out') THEN (100 * (loan_amount / as_is_value))
        WHEN purchase_price < as_is_value AND transaction_type IN ('Purchase', 'Delayed Purchase') THEN (100 * (loan_amount / purchase_price))
        WHEN purchase_price >= as_is_value AND transaction_type IN ('Purchase', 'Delayed Purchase') THEN (100 * (loan_amount / as_is_value))
    END;
    RETURN result;
END;
$$;


--
-- Name: update_property_address(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_property_address() RETURNS trigger
    LANGUAGE plpgsql
    AS $$declare 
  new_address text;
begin
  IF length(new.address_state_long::text) > 2 THEN
    new.address_state := get_state_code(new.address_state_long::text);
  END IF;

  new_address := format_address(new.address_street, new.address_suite_apt, new.address_city, new.address_state::text, new.address_postal_code, new.address_country, null);
  
  new.address = new_address;
  return new;
end;$$;


--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      PERFORM pg_notify(
          'realtime:system',
          jsonb_build_object(
              'error', SQLERRM,
              'function', 'realtime.send',
              'event', event,
              'topic', topic,
              'private', private
          )::text
      );
  END;
END;
$$;


--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


--
-- Name: http_request(); Type: FUNCTION; Schema: supabase_functions; Owner: -
--

CREATE FUNCTION supabase_functions.http_request() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'supabase_functions'
    AS $$
    DECLARE
      request_id bigint;
      payload jsonb;
      url text := TG_ARGV[0]::text;
      method text := TG_ARGV[1]::text;
      headers jsonb DEFAULT '{}'::jsonb;
      params jsonb DEFAULT '{}'::jsonb;
      timeout_ms integer DEFAULT 1000;
    BEGIN
      IF url IS NULL OR url = 'null' THEN
        RAISE EXCEPTION 'url argument is missing';
      END IF;

      IF method IS NULL OR method = 'null' THEN
        RAISE EXCEPTION 'method argument is missing';
      END IF;

      IF TG_ARGV[2] IS NULL OR TG_ARGV[2] = 'null' THEN
        headers = '{"Content-Type": "application/json"}'::jsonb;
      ELSE
        headers = TG_ARGV[2]::jsonb;
      END IF;

      IF TG_ARGV[3] IS NULL OR TG_ARGV[3] = 'null' THEN
        params = '{}'::jsonb;
      ELSE
        params = TG_ARGV[3]::jsonb;
      END IF;

      IF TG_ARGV[4] IS NULL OR TG_ARGV[4] = 'null' THEN
        timeout_ms = 1000;
      ELSE
        timeout_ms = TG_ARGV[4]::integer;
      END IF;

      CASE
        WHEN method = 'GET' THEN
          SELECT http_get INTO request_id FROM net.http_get(
            url,
            params,
            headers,
            timeout_ms
          );
        WHEN method = 'POST' THEN
          payload = jsonb_build_object(
            'old_record', OLD,
            'record', NEW,
            'type', TG_OP,
            'table', TG_TABLE_NAME,
            'schema', TG_TABLE_SCHEMA
          );

          SELECT http_post INTO request_id FROM net.http_post(
            url,
            payload,
            params,
            headers,
            timeout_ms
          );
        ELSE
          RAISE EXCEPTION 'method argument % is invalid', method;
      END CASE;

      INSERT INTO supabase_functions.hooks
        (hook_table_id, hook_name, request_id)
      VALUES
        (TG_RELID, TG_NAME, request_id);

      RETURN NEW;
    END
  $$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: -
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: -
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: document_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_files (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    name text,
    public_notes text,
    private_notes text,
    status public.document_status,
    category public.document_category,
    deal_id bigint,
    borrower_id bigint,
    entity_id bigint,
    property_id bigint,
    guarantor_id bigint,
    effective_date date,
    expiration_date date,
    is_required boolean,
    uploaded_by text,
    uploaded_at timestamp with time zone,
    file_url text,
    file_size bigint,
    file_type text,
    file_path text
);


--
-- Name: TABLE document_files; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.document_files IS 'Storing documents used for loans';


--
-- Name: COLUMN document_files.name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.document_files.name IS 'document name';


--
-- Name: COLUMN document_files.property_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.document_files.property_id IS 'The Property Associated with a document';


--
-- Name: COLUMN document_files.is_required; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.document_files.is_required IS 'Is the document a required document?';


--
-- Name: Documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.document_files ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Documents_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tasks (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deal_id bigint,
    task_name character varying DEFAULT ''::character varying NOT NULL,
    due_date date,
    assigned_to bigint,
    status public.task_status,
    milestone_id bigint,
    task_description text,
    task_order numeric,
    date_reached date,
    date_completed date,
    task_complete boolean,
    days_until_due numeric,
    task_action text
);


--
-- Name: TABLE tasks; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.tasks IS 'Tasks that need to be completed during the Loan Review Process';


--
-- Name: COLUMN tasks.days_until_due; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.tasks.days_until_due IS 'The number of days after which a task is due after its parent milestone turns to "In Progress"';


--
-- Name: Tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.tasks ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Tasks_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: appraisal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.appraisal (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    date_report_effective date,
    date_report_expiration date,
    updated_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    property_id bigint,
    deal_id bigint,
    document_id bigint,
    date_report_ordered date,
    date_report_received date,
    date_inspection_completed date,
    date_inspection_scheduled date,
    value_conclusion_as_is numeric,
    value_conclusion_as_repaired numeric,
    value_conclusion_fair_market_rent numeric,
    file_number_amc text,
    file_number text,
    co_appraisal bigint,
    co_amc bigint,
    appraiser_id bigint,
    date_amc_vendor_assign timestamp with time zone,
    date_amc_vendor_accept timestamp with time zone,
    order_type public.appraisal_order_type,
    order_status public.appraisal_order_status
);


--
-- Name: TABLE appraisal; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.appraisal IS 'appraisal data';


--
-- Name: COLUMN appraisal.property_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.appraisal.property_id IS 'property record linked to the appraisal record';


--
-- Name: COLUMN appraisal.deal_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.appraisal.deal_id IS 'deal record linked to the appraisal record';


--
-- Name: COLUMN appraisal.order_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.appraisal.order_type IS 'commercial appraisal v residential appraisal';


--
-- Name: COLUMN appraisal.order_status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.appraisal.order_status IS 'appraisal order status';


--
-- Name: appraisal_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.appraisal ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.appraisal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_clerk_orgs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_clerk_orgs (
    id bigint NOT NULL,
    clerk_org_id text NOT NULL,
    clerk_org_name text NOT NULL,
    clerk_org_slug text NOT NULL,
    created_by_clerk_id text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: auth_clerk_orgs_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_clerk_orgs_members (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    clerk_id text NOT NULL,
    clerk_org_id text NOT NULL,
    user_id bigint,
    clerk_org_fkey bigint,
    clerk_org_role public.clerk_org_role DEFAULT 'member'::public.clerk_org_role
);


--
-- Name: TABLE auth_clerk_orgs_members; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.auth_clerk_orgs_members IS 'clerk organization memberships';


--
-- Name: COLUMN auth_clerk_orgs_members.user_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.auth_clerk_orgs_members.user_id IS 'foreign key to user_profile_id';


--
-- Name: auth_user_profile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_profile (
    email character varying(255),
    updated_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    username text,
    first_name text,
    last_name text,
    full_name text GENERATED ALWAYS AS (TRIM(BOTH FROM ((COALESCE(first_name, ''::text) || ' '::text) || COALESCE(last_name, ''::text)))) STORED,
    avatar_url text,
    website text,
    role public.user_role_internal,
    is_active_yn boolean DEFAULT true,
    deactivation_date date,
    invitation_date date,
    activated_date date,
    id bigint NOT NULL,
    cell_phone text,
    office_phone_extension text,
    is_internal_yn boolean DEFAULT false NOT NULL,
    office_phone text,
    clerk_id text,
    contact_id bigint,
    create_organization_enabled boolean DEFAULT false,
    delete_self_enabled boolean DEFAULT false,
    is_locked boolean DEFAULT false,
    is_banned boolean DEFAULT false,
    last_active_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    legal_accepted_at timestamp with time zone,
    has_image boolean DEFAULT false,
    image_url text,
    email_verified boolean DEFAULT false,
    email_verified_at timestamp with time zone,
    CONSTRAINT username_length CHECK ((char_length(username) >= 3))
);


--
-- Name: COLUMN auth_user_profile.role; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.auth_user_profile.role IS 'User role: ADMIN, ACCOUNT_EXECUTIVE, LOAN_PROCESSOR, BALANCE_SHEET_INVESTOR, or LOAN_OPENER';


--
-- Name: COLUMN auth_user_profile.is_active_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.auth_user_profile.is_active_yn IS 'Whether the user account is active';


--
-- Name: COLUMN auth_user_profile.cell_phone; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.auth_user_profile.cell_phone IS 'cell phone number';


--
-- Name: COLUMN auth_user_profile.office_phone_extension; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.auth_user_profile.office_phone_extension IS 'office phone number extension';


--
-- Name: COLUMN auth_user_profile.is_internal_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.auth_user_profile.is_internal_yn IS 'Whether the user is an internal employee';


--
-- Name: COLUMN auth_user_profile.office_phone; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.auth_user_profile.office_phone IS 'office phone number';


--
-- Name: COLUMN auth_user_profile.clerk_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.auth_user_profile.clerk_id IS 'The unique identifier from Clerk authentication service';


--
-- Name: COLUMN auth_user_profile.contact_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.auth_user_profile.contact_id IS 'foreign key to contact_id';


--
-- Name: borrower; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.borrower (
    id bigint NOT NULL,
    primary_residence_address_street text,
    primary_residence_address_suite_apt text,
    primary_residence_address_city text,
    primary_residence_address_state public.us_states,
    primary_residence_address_postal_code text,
    primary_residence_address_country text,
    primary_residence_occupancy_start_date date,
    primary_residence_ownership public.residence_ownership,
    previous_residence_address_street text,
    previous_residence_address_suite_apt text,
    previous_residence_address_city text,
    previous_residence_address_state public.us_states,
    previous_residence_address_postal_code text,
    previous_residence_address_country text,
    mailing_address_is_primary_residence boolean,
    mailing_address_street text,
    mailing_address_suite_apt text,
    mailing_address_po_box text,
    mailing_address_city text,
    mailing_address_state public.us_states,
    mailing_address_postal_code text,
    mailing_address_country text,
    date_of_birth date,
    social_security_number text,
    citizenship public.citizenship,
    marital_status public.marital_status,
    fico_score_mid_estimate smallint,
    fico_score_mid_actual smallint,
    fico_report_date_pulled date,
    exp_ground_ups_sold smallint DEFAULT 0,
    exp_flips_sold smallint DEFAULT 0,
    exp_rentals_owned smallint DEFAULT 0,
    exp_professional_license public.professional_license,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    updated_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    mortgage_debt numeric,
    fico_report_date_expiration date GENERATED ALWAYS AS ((fico_report_date_pulled + 91)) STORED,
    first_time_home_buyer public.yes_no,
    fico_report_score_equifax smallint,
    fico_report_score_experian smallint,
    fico_report_score_transunion smallint,
    primary_residence_address_state_long public.us_states_long,
    previous_residence_address_state_long public.us_states_long,
    mailing_address_state_long public.us_states_long,
    has_experience public.yes_no,
    credit_check public.credit_check_status,
    first_name text,
    middle_name text,
    last_name text,
    name text GENERATED ALWAYS AS (((first_name || ' '::text) || last_name)) STORED,
    email_address text,
    cell_phone text,
    home_phone text,
    office_phone text,
    primary_residence_address_county text,
    previous_residence_occupancy_start_date date,
    previous_residence_occupancy_end_date date
);


--
-- Name: borrower_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.borrower ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.borrower_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: bs_debt_instruments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bs_debt_instruments (
    id bigint NOT NULL,
    instrument_type public.debt_instrument_type NOT NULL,
    name text NOT NULL,
    target_yield_pct numeric,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: bs_debt_instruments_deals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bs_debt_instruments_deals (
    id bigint NOT NULL,
    instrument_id bigint NOT NULL,
    deal_id bigint NOT NULL
);


--
-- Name: COLUMN bs_debt_instruments_deals.instrument_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.bs_debt_instruments_deals.instrument_id IS 'foreign key to debt_instruments_id';


--
-- Name: COLUMN bs_debt_instruments_deals.deal_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.bs_debt_instruments_deals.deal_id IS 'foreign key to deal_id';


--
-- Name: bs_debt_instruments_deals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.bs_debt_instruments_deals ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.bs_debt_instruments_deals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: bsi_deals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bsi_deals (
    deal_id bigint NOT NULL,
    contact_id bigint NOT NULL,
    contact_types_id bigint NOT NULL
);


--
-- Name: bsi_distributions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bsi_distributions (
    id bigint NOT NULL,
    deal_id bigint,
    rate_of_return_pct numeric(5,4) NOT NULL,
    interest_amount numeric(15,2) NOT NULL,
    servicing_fee numeric(15,2) DEFAULT 0.00 NOT NULL,
    wire_fee numeric(15,2) DEFAULT 0.00 NOT NULL,
    deposit_amount numeric(15,2) NOT NULL,
    notes text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    investor_id bigint,
    capital_contribution numeric NOT NULL,
    loan_amount_snapshot numeric NOT NULL,
    upb_close numeric,
    statement_id uuid NOT NULL,
    principal_amount numeric NOT NULL,
    instrument_id bigint,
    clerk_org_id bigint,
    clerk_org_member_id bigint,
    user_id bigint
);


--
-- Name: COLUMN bsi_distributions.clerk_org_member_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.bsi_distributions.clerk_org_member_id IS 'fkey auth_clerk_orgs_members_id';


--
-- Name: COLUMN bsi_distributions.user_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.bsi_distributions.user_id IS 'fkey auth_user_profile_id';


--
-- Name: bsi_statements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bsi_statements (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    investor_id bigint,
    statement_date date NOT NULL,
    statement_period_start date NOT NULL,
    statement_period_end date NOT NULL,
    total_upb_open numeric NOT NULL,
    total_upb_close numeric NOT NULL,
    total_interest numeric NOT NULL,
    total_principal numeric,
    total_fees numeric NOT NULL,
    clerk_org_id bigint
);


--
-- Name: bsi_transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bsi_transactions (
    id bigint NOT NULL,
    investor_id bigint,
    transaction_amount numeric(15,2),
    transaction_date timestamp with time zone DEFAULT now() NOT NULL,
    transaction_method public.transaction_method,
    transaction_status public.transaction_status,
    reference_number text,
    reference_type public.transaction_reference_type,
    notes text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    deal_id bigint,
    ledger_entry_type public.ledger_entry_type DEFAULT 'contribution'::public.ledger_entry_type NOT NULL,
    instrument_id bigint,
    clerk_id text,
    clerk_organization_id text
);


--
-- Name: bsi_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.bsi_transactions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.bsi_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: bsi_transactions_references; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bsi_transactions_references (
    id bigint NOT NULL,
    transaction_id bigint NOT NULL,
    reference_type public.transaction_reference_type NOT NULL,
    reference_value text NOT NULL
);


--
-- Name: cba_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cba_requests (
    id bigint NOT NULL,
    submitted_at timestamp with time zone DEFAULT now() NOT NULL,
    completed_at timestamp with time zone,
    deal_id bigint,
    uw_prequal_result_credit bigint,
    uw_prequal_result_background bigint,
    submitted_by bigint NOT NULL
);


--
-- Name: COLUMN cba_requests.deal_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.cba_requests.deal_id IS 'foreign key';


--
-- Name: COLUMN cba_requests.uw_prequal_result_credit; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.cba_requests.uw_prequal_result_credit IS 'foreign key to select_uw_outcomes_id';


--
-- Name: COLUMN cba_requests.uw_prequal_result_background; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.cba_requests.uw_prequal_result_background IS 'foreign key to select_uw_outcomes_id';


--
-- Name: COLUMN cba_requests.submitted_by; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.cba_requests.submitted_by IS 'foreign key - select the user_profile_id of the individual who submitted the request';


--
-- Name: cba_requests_guarantors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cba_requests_guarantors (
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    cba_request_id bigint NOT NULL,
    guarantor_id bigint NOT NULL
);


--
-- Name: TABLE cba_requests_guarantors; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.cba_requests_guarantors IS 'junction table for a many-to-many relationship';


--
-- Name: cba_submission_credit_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.cba_requests ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.cba_submission_credit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: company; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company (
    co_id bigint NOT NULL,
    co_name text,
    co_ein text,
    co_website text,
    co_ppb_address_street text,
    co_ppb_address_suite_apt text,
    co_ppb_address_city text,
    co_ppb_address_postal_code text,
    co_ppb_address_country public.country_enum DEFAULT 'United States'::public.country_enum,
    co_phone text,
    co_fax text,
    co_logo text,
    co_role public.company_role,
    co_ppb_address_state public.us_states,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    updated_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    co_date_established date,
    co_state_of_formation public.us_states,
    co_bank_of_business_account text,
    co_bank_account_balance numeric,
    co_entity_type public.entity_type,
    co_ppb_address_state_long public.us_states_long,
    co_state_of_formation_long public.us_states_long,
    primary_guarantor_id bigint
);


--
-- Name: COLUMN company.co_ppb_address_street; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company.co_ppb_address_street IS 'principal place of business - street';


--
-- Name: COLUMN company.co_ppb_address_suite_apt; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company.co_ppb_address_suite_apt IS 'principal place of business - suite/apt/bldg';


--
-- Name: COLUMN company.co_ppb_address_city; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company.co_ppb_address_city IS 'principal place of business - city';


--
-- Name: COLUMN company.co_ppb_address_postal_code; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company.co_ppb_address_postal_code IS 'principal place of business - postal code';


--
-- Name: COLUMN company.co_ppb_address_country; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company.co_ppb_address_country IS 'principal place of business - country';


--
-- Name: COLUMN company.co_ppb_address_state; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company.co_ppb_address_state IS 'principal place of business - state';


--
-- Name: COLUMN company.co_date_established; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company.co_date_established IS 'entity date of formation in state of formation';


--
-- Name: COLUMN company.co_state_of_formation; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company.co_state_of_formation IS 'entity domestic state of formation';


--
-- Name: COLUMN company.co_bank_of_business_account; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company.co_bank_of_business_account IS 'business account - bank name';


--
-- Name: COLUMN company.co_bank_account_balance; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company.co_bank_account_balance IS 'business account - current balance';


--
-- Name: COLUMN company.co_entity_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company.co_entity_type IS 'entity legal structure';


--
-- Name: COLUMN company.primary_guarantor_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company.primary_guarantor_id IS 'The company member who will serve as the Primary Guarantor';


--
-- Name: company_contact; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_contact (
    id bigint NOT NULL,
    co_id bigint,
    contact_id bigint,
    deal_id bigint
);


--
-- Name: company_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.company_contact ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.company_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: company_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.company ALTER COLUMN co_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: company_member; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_member (
    member_id bigint NOT NULL,
    member_company_id bigint,
    member_ownership_percentage double precision,
    member_created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    member_updated_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    member_title text,
    member_borrower_id bigint,
    member_name_first text,
    member_name_last text,
    member_type public.vesting_type,
    member_owning_company_id bigint,
    member_is_guarantor public.yes_no
);


--
-- Name: company_member_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.company_member ALTER COLUMN member_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.company_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: company_roles_defined; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_roles_defined (
    id bigint NOT NULL,
    co_role public.company_role NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    deal_id bigint
);


--
-- Name: COLUMN company_roles_defined.co_role; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company_roles_defined.co_role IS 'company role';


--
-- Name: company_role_mm_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.company_roles_defined ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.company_role_mm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: company_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_roles (
    id bigint NOT NULL,
    co_id bigint NOT NULL,
    role_id bigint NOT NULL,
    deal_id bigint
);


--
-- Name: company_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.company_roles ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.company_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: constants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.constants (
    id bigint NOT NULL,
    name text,
    description text,
    type public.constant_types,
    active boolean,
    text_value text,
    numeric_value numeric,
    yes_no_value public.yes_no,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    updated_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text)
);


--
-- Name: constants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.constants ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.constants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: contact; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact (
    id bigint NOT NULL,
    first_name text,
    last_name text,
    email_address text,
    cell_phone text,
    home_phone text,
    office_phone text,
    portal_access boolean DEFAULT false,
    company_id bigint,
    contact_type public.contact_type,
    profile_picture text,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    updated_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    name text GENERATED ALWAYS AS (((first_name || ' '::text) || last_name)) STORED,
    contact_types public.contact_type[],
    middle_name text,
    user_id bigint
);


--
-- Name: contact_types_jt; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_types_jt (
    id bigint NOT NULL,
    contact_id bigint,
    contact_types_id bigint
);


--
-- Name: contact_contact_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.contact_types_jt ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.contact_contact_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: contact_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.contact ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: contact_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_types (
    id bigint NOT NULL,
    name text
);


--
-- Name: contact_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.contact_types ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.contact_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: countries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.countries (
    id bigint NOT NULL,
    name text,
    iso2 text NOT NULL,
    iso3 text,
    local_name text,
    continent public.continents
);


--
-- Name: TABLE countries; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.countries IS 'Full list of countries.';


--
-- Name: COLUMN countries.name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.countries.name IS 'Full country name.';


--
-- Name: COLUMN countries.iso2; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.countries.iso2 IS 'ISO 3166-1 alpha-2 code.';


--
-- Name: COLUMN countries.iso3; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.countries.iso3 IS 'ISO 3166-1 alpha-3 code.';


--
-- Name: COLUMN countries.local_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.countries.local_name IS 'Local variation of the name.';


--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.countries ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: custom_loan_fees; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_loan_fees (
    id bigint NOT NULL,
    deal_id bigint NOT NULL,
    fee_category public.fee_type,
    fee_description text,
    fee_amount numeric,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: custom_loan_fees_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.custom_loan_fees ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.custom_loan_fees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: deal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deal (
    id bigint NOT NULL,
    deal_name text,
    vesting_type public.vesting_type,
    guarantor_count smallint DEFAULT '1'::smallint,
    lead_source_type public.lead_source,
    property_id bigint,
    company_id bigint,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    updated_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    note_date date,
    mid_fico smallint DEFAULT '0'::smallint,
    pricing_is_locked boolean DEFAULT false NOT NULL,
    broker_id bigint,
    lead_source_name text,
    loan_number text,
    declaration_1_lawsuits boolean,
    declaration_2_bankruptcy boolean,
    declaration_3_felony boolean DEFAULT false,
    declaration_5_license boolean DEFAULT false,
    declaration_1_lawsuits_explanation text,
    declaration_2_bankruptcy_explanation text,
    declaration_3_felony_explanation text,
    recourse_type text DEFAULT 'full_recourse'::text,
    transaction_type public.transaction_type,
    payoff_mtg1_amount numeric,
    loan_structure_dscr public.loan_structure_dscr,
    guarantor_fico_score smallint,
    title_company_contact_id bigint,
    title_company_id bigint,
    insurance_carrier_contact_id bigint,
    closing_agent_contact_id bigint,
    appraisal_poc_contact_id bigint,
    insurance_carrier_company_id bigint,
    cash_out_purpose text,
    target_closing_date date,
    date_of_purchase date,
    loan_amount_total numeric,
    construction_holdback numeric,
    loan_amount_initial numeric,
    loan_term public.loan_term_months,
    title_file_number text,
    deal_type public.loan_type_1,
    project_type public.project_type,
    deal_stage_1 public.deal_stage_1,
    deal_stage_2 public.deal_stage_2,
    deal_disposition_1 public.deal_disposition_1,
    loan_type_rtl public.loan_type_2,
    renovation_cost numeric,
    renovation_completed date,
    recently_renovated public.yes_no,
    purchase_price numeric,
    account_executive_id bigint,
    funding_date date,
    loan_sale_date date,
    pricing_file_path text,
    pricing_file_url text,
    second_guarantor_id bigint,
    third_guarantor_id bigint,
    fourth_guarantor_id bigint,
    primary_guarantor_id bigint,
    loan_buyer_contact_id bigint,
    loan_buyer_company_id bigint,
    loan_processor_id bigint,
    loan_opener_id bigint,
    note_rate numeric,
    cost_of_capital numeric,
    broker_company_id bigint,
    escrow_company_id bigint,
    escrow_contact_id bigint,
    ltv_asis numeric,
    ltv_after_repair numeric,
    io_period numeric,
    ppp_term public.ppp_term,
    ppp_structure_1 public.ppp_structure_1
);


--
-- Name: COLUMN deal.note_date; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.deal.note_date IS 'actual closing date';


--
-- Name: COLUMN deal.declaration_5_license; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.deal.declaration_5_license IS 'Are you a licensed General Contractor, Real Estate Broker / Sales Person, Lender, Appraiser or involved in any other real estate related activities?';


--
-- Name: COLUMN deal.target_closing_date; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.deal.target_closing_date IS 'projected closing date';


--
-- Name: COLUMN deal.date_of_purchase; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.deal.date_of_purchase IS 'acquisition date / purchase date';


--
-- Name: COLUMN deal.construction_holdback; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.deal.construction_holdback IS 'lender holdback: construction financed';


--
-- Name: COLUMN deal.title_file_number; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.deal.title_file_number IS 'issuing office file number';


--
-- Name: COLUMN deal.deal_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.deal.deal_type IS 'Deal Type';


--
-- Name: COLUMN deal.funding_date; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.deal.funding_date IS 'date on which funding authorization is issued';


--
-- Name: COLUMN deal.loan_sale_date; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.deal.loan_sale_date IS 'date of loan sale';


--
-- Name: COLUMN deal.note_rate; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.deal.note_rate IS 'interest rate charged to the borrower';


--
-- Name: COLUMN deal.ltv_asis; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.deal.ltv_asis IS 'loan to value as is = (initial loan amount / lesser of as is value and purchase price)';


--
-- Name: COLUMN deal.ltv_after_repair; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.deal.ltv_after_repair IS 'loan to value after repair value (total loan amount / after repair value)';


--
-- Name: COLUMN deal.io_period; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.deal.io_period IS 'duration of interest only period expressed as a number of months (e.g., 120)';


--
-- Name: COLUMN deal.ppp_term; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.deal.ppp_term IS 'pre-payment penalty term';


--
-- Name: COLUMN deal.ppp_structure_1; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.deal.ppp_structure_1 IS 'pre-payment penalty structure';


--
-- Name: deal_appraisals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deal_appraisals (
    id bigint NOT NULL,
    deal_id bigint,
    appraisal_id bigint,
    "property_Id" bigint
);


--
-- Name: deal_appraisals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.deal_appraisals ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.deal_appraisals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: deal_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.deal ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.deal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: deal_property; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deal_property (
    id bigint NOT NULL,
    deal_id bigint NOT NULL,
    property_id bigint NOT NULL
);


--
-- Name: deal_property_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.deal_property ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.deal_property_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: deal_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deal_roles (
    id bigint NOT NULL,
    deal_id bigint,
    contact_id bigint,
    contact_types_id bigint
);


--
-- Name: deal_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.deal_roles ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.deal_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: debt_instruments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.bs_debt_instruments ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.debt_instruments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: document_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_roles (
    id bigint NOT NULL,
    role_name text NOT NULL
);


--
-- Name: document_roles_assigned; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_roles_assigned (
    document_id bigint NOT NULL,
    role_id bigint NOT NULL
);


--
-- Name: document_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.document_roles ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.document_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: fee; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fee (
    id bigint NOT NULL,
    category text NOT NULL,
    program public.loan_program,
    fee_amount_bps numeric NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: TABLE fee; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.fee IS 'Table for the fee options used for loan pricing';


--
-- Name: COLUMN fee.fee_amount_bps; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.fee.fee_amount_bps IS 'fee amount %';


--
-- Name: fee_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.fee ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.fee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: guarantor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.guarantor (
    guarantor_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    borrower_id bigint,
    deal_id bigint,
    first_name text,
    middle_name text,
    last_name text,
    name text GENERATED ALWAYS AS (((first_name || ' '::text) || last_name)) STORED,
    email_address text,
    cell_phone text,
    home_phone text,
    office_phone text,
    primary_residence_address_street text,
    primary_residence_address_suite_apt text,
    primary_residence_address_city text,
    primary_residence_address_state public.us_states,
    primary_residence_address_state_long public.us_states_long,
    primary_residence_address_postal_code text,
    primary_residence_address_country text,
    primary_residence_occupancy_start_date date,
    primary_residence_ownership public.residence_ownership,
    previous_residence_address_street text,
    previous_residence_address_suite_apt text,
    previous_residence_address_city text,
    previous_residence_address_state public.us_states,
    previous_residence_address_state_long public.us_states_long,
    previous_residence_address_postal_code text,
    previous_residence_address_country text,
    mailing_address_is_primary_residence boolean,
    mailing_address_street text,
    mailing_address_suite_apt text,
    mailing_address_po_box text,
    mailing_address_city text,
    mailing_address_state public.us_states,
    mailing_address_state_long public.us_states_long,
    mailing_address_postal_code text,
    mailing_address_country text,
    date_of_birth date,
    social_security_number text,
    citizenship public.citizenship,
    marital_status public.marital_status,
    mortgage_debt numeric,
    fico_score_mid_estimate smallint,
    fico_score_mid_actual smallint,
    fico_report_date_pulled date,
    fico_report_date_expiration date GENERATED ALWAYS AS ((fico_report_date_pulled + 91)) STORED,
    fico_report_score_equifax smallint,
    fico_report_score_experian smallint,
    fico_report_score_transunion smallint,
    first_time_home_buyer public.yes_no,
    exp_ground_ups_sold smallint DEFAULT 0,
    exp_flips_sold smallint DEFAULT 0,
    exp_rentals_owned smallint DEFAULT 0,
    exp_professional_license public.professional_license,
    has_experience public.yes_no,
    credit_check public.credit_check_status
);


--
-- Name: TABLE guarantor; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.guarantor IS 'Borrower linked to a deal';


--
-- Name: guarantor_guarantor_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.guarantor ALTER COLUMN guarantor_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.guarantor_guarantor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: loan_application; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.loan_application (
    id bigint NOT NULL,
    submission jsonb,
    status text,
    application_deal_id bigint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    error_message text,
    reprocess boolean DEFAULT false
);


--
-- Name: loan_application_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.loan_application ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.loan_application_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: milestone_templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.milestone_templates (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    milestone_name text NOT NULL,
    milestone_order numeric,
    status public.milestone_status,
    types_applied_to text,
    subject_property_state public.us_states,
    vesting_type public.vesting_type,
    email_template_subject text,
    email_template_body text
);


--
-- Name: COLUMN milestone_templates.status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.milestone_templates.status IS 'The default status when new milestones are created for a deal.';


--
-- Name: COLUMN milestone_templates.subject_property_state; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.milestone_templates.subject_property_state IS 'state(s) in which the subject property is located';


--
-- Name: milestone_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.milestone_templates ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.milestone_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: milestones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.milestones (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deal_id bigint NOT NULL,
    milestone_order numeric,
    status public.milestone_status,
    date_reached date,
    date_completed date,
    milestone_template_id bigint,
    email_subject text,
    email_body text,
    email_sent boolean,
    date_email_sent date
);


--
-- Name: TABLE milestones; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.milestones IS 'Stages for each deal';


--
-- Name: COLUMN milestones.milestone_order; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.milestones.milestone_order IS 'The order each milestone needs to be completed in.';


--
-- Name: COLUMN milestones.status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.milestones.status IS 'Current status of milestone';


--
-- Name: COLUMN milestones.date_reached; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.milestones.date_reached IS 'The date a deal reached the milestone';


--
-- Name: milestones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.milestones ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.milestones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: payroll_submission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payroll_submission (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now(),
    income_bpc_usd numeric,
    income_bpc_pct numeric,
    income_lpc_usd numeric,
    income_lpc_pct numeric,
    income_lpc_trailing_yn boolean,
    income_lpc_trailing_usd numeric,
    income_lpc_trailing_pct numeric,
    income_lpc_promo_usd numeric,
    expense_ace_corp_return_usd numeric DEFAULT 0.00,
    expense_ace_corp_override_usd numeric DEFAULT 0.00,
    expense_misc_ppcc_usd numeric DEFAULT 0.00,
    income_net_usd numeric,
    comp_ae_formula_output_usd numeric,
    comp_ae_formula_output_pct numeric,
    comp_ae_final_usd numeric,
    comp_lp_formula_output_usd numeric,
    comp_lp_formula_output_pct numeric,
    comp_lp_final_usd numeric,
    income_bpc_received_yn boolean,
    income_bpc_received_datetime timestamp with time zone,
    deal_id bigint
);


--
-- Name: TABLE payroll_submission; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.payroll_submission IS 'user submission data by deal record';


--
-- Name: COLUMN payroll_submission.deal_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.payroll_submission.deal_id IS 'foreign key to deal record';


--
-- Name: payroll_submission_fees_1099; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payroll_submission_fees_1099 (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    payroll_submission_id bigint,
    broker_id bigint,
    expense_1099_broker_fee_usd numeric,
    expense_1099_broker_fee_pct numeric,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone
);


--
-- Name: TABLE payroll_submission_fees_1099; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.payroll_submission_fees_1099 IS 'junction table to associate one or more broker fee(s) and referral fee(s) to payroll submission record(s)';


--
-- Name: payroll_submission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.payroll_submission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.payroll_submission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: profile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_user_profile ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: property; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.property (
    id bigint NOT NULL,
    property_type public.property_type,
    year_built bigint,
    sq_footage_gla_aiv bigint,
    address_street text,
    address_suite_apt text,
    address_city text,
    address_state public.us_states,
    address_postal_code text,
    address_country text DEFAULT 'United States'::text,
    units smallint,
    expense_annual_property_tax numeric,
    expense_annual_insurance_hoi numeric,
    expense_annual_insurance_flood numeric,
    expense_annual_management numeric,
    expense_annual_association_hoa numeric,
    purchase_price numeric,
    renovation_cost numeric,
    renovation_completed date,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    updated_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    address text,
    short_term_rental public.yes_no,
    declining_market public.yes_no,
    rural public.yes_no,
    flood_zone public.yes_no,
    recently_renovated public.yes_no,
    purchase_date date,
    rehab_completed_post_acquisition numeric,
    value_aiv_estimate numeric,
    hoa_contact_phone text,
    hoa_contact_person text,
    hoa_contact_email text,
    inspection public.yes_no,
    sq_footage_lot_aiv bigint,
    value_aiv_appraised numeric,
    value_arv_estimate numeric,
    value_arv_appraised numeric,
    warrantability public.warrantability,
    latitude numeric,
    longitude numeric,
    hoa_contact bigint,
    address_state_long public.us_states_long,
    bedrooms_aiv numeric,
    bedrooms_arv numeric,
    bathrooms_aiv numeric,
    bathrooms_arv numeric,
    sq_footage_gla_arv bigint,
    sq_footage_lot_arv bigint,
    address_county text,
    hoa_name text,
    occupancy public.property_occupancy,
    income_monthly_gross_rent numeric,
    income_monthly_fair_market_rent numeric,
    sale_price numeric,
    sale_date date,
    photo_url text
);


--
-- Name: COLUMN property.sq_footage_gla_aiv; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.sq_footage_gla_aiv IS 'gross living area as is';


--
-- Name: COLUMN property.expense_annual_property_tax; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.expense_annual_property_tax IS 'annual property tax';


--
-- Name: COLUMN property.expense_annual_insurance_hoi; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.expense_annual_insurance_hoi IS 'annual insurance premium - homeowner''s';


--
-- Name: COLUMN property.expense_annual_insurance_flood; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.expense_annual_insurance_flood IS 'annual insurance premium - flood';


--
-- Name: COLUMN property.expense_annual_management; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.expense_annual_management IS 'annual property management cost';


--
-- Name: COLUMN property.expense_annual_association_hoa; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.expense_annual_association_hoa IS 'annual homeowner''s association dues';


--
-- Name: COLUMN property.value_aiv_estimate; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.value_aiv_estimate IS 'as is value - estimate';


--
-- Name: COLUMN property.sq_footage_lot_aiv; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.sq_footage_lot_aiv IS 'lot size as is';


--
-- Name: COLUMN property.value_aiv_appraised; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.value_aiv_appraised IS 'as is value - appraised';


--
-- Name: COLUMN property.value_arv_estimate; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.value_arv_estimate IS 'after repair value - estimate';


--
-- Name: COLUMN property.value_arv_appraised; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.value_arv_appraised IS 'after repair value - appraised';


--
-- Name: COLUMN property.bedrooms_aiv; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.bedrooms_aiv IS 'number of bedrooms as is';


--
-- Name: COLUMN property.bedrooms_arv; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.bedrooms_arv IS 'number of bedrooms as repaired';


--
-- Name: COLUMN property.bathrooms_aiv; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.bathrooms_aiv IS 'number of bathrooms as is';


--
-- Name: COLUMN property.bathrooms_arv; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.bathrooms_arv IS 'number of bathrooms as repaired';


--
-- Name: COLUMN property.sq_footage_gla_arv; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.sq_footage_gla_arv IS 'gross living area as repaired';


--
-- Name: COLUMN property.sq_footage_lot_arv; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.sq_footage_lot_arv IS 'lot size as repaired';


--
-- Name: COLUMN property.photo_url; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property.photo_url IS 'link to property photo';


--
-- Name: property_reapi; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.property_reapi (
    id bigint NOT NULL,
    data_property_type text,
    pi_year_built bigint,
    pi_gla_sqft_asis bigint,
    address_street text,
    address_unit text,
    address_city text,
    address_state public.us_states,
    address_zip5 text,
    pi_units_count_asis numeric,
    tax_amount_annual numeric,
    pi_hoa_fees_annual numeric,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    updated_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    address_full text,
    data_value_asis_est numeric,
    lot_size_sqft_asis bigint,
    value_arv_estimate numeric,
    pi_hoa_warrantability text,
    pi_latitude numeric,
    pi_longitude numeric,
    address_county text,
    pi_hoa_name text,
    data_occupancy_oo_yn text,
    pi_demo_fmr_1br numeric,
    pi_demo_fmr_2br numeric,
    data_last_sale_price numeric,
    property_id bigint,
    address_zip4 text,
    address_house text,
    address_street_type text,
    address_unit_type text,
    address_predirection text,
    address_jurisdiction text,
    pi_basement_sqft numeric,
    pi_basement_sqft_finished numeric,
    pi_basement_type text,
    pi_rooms_bathrooms_asis numeric,
    pi_rooms_bedrooms_asis numeric,
    pi_rooms_bathrooms_partial_asis numeric,
    pi_rooms_count_asis numeric,
    pi_buildings_count_asis numeric,
    pi_construction_method text,
    pi_garage_type text,
    pi_garage_sqft_asis bigint,
    data_last_sale_date date,
    data_preforeclosure_yn text,
    data_private_lender_yn text,
    data_occupancy_vacant_yn text,
    data_reapi_last_update timestamp with time zone,
    "data_property_type_MFH2to4" text,
    "data_property_type_MFH5plus" text,
    data_freeclear_yn text,
    data_owner_mortgage_balance_est numeric,
    data_owner_mortgage_payment_est numeric,
    "data_owner_equity$_est" numeric,
    "data_owner_equity%_est" numeric,
    data_flood_zone_yn text,
    data_flood_zone_description text,
    data_flood_zone_type text,
    data_owner_mortgage_arm_yn text,
    data_owner_is_entity_yn text,
    data_owner_is_bank_yn text,
    data_owner_mortgage_maturitydate date,
    data_mls_last_sale_date date,
    data_mls_active text,
    data_mls_last_status_date date,
    data_mls_status text,
    data_open_mortgage_balance_est numeric,
    data_mls_daysonmarket bigint,
    data_mls_cancelled text,
    data_mls_failed text,
    data_mls_failed_date date,
    data_mls_listing_date date,
    data_mls_listing_price numeric,
    data_mls_listing_price_sqft numeric,
    data_mls_pending text,
    data_mls_sold text,
    data_property_type_mobilehome_yn text,
    data_mls_total_updates double precision,
    data_mls_type text,
    reapi_id bigint NOT NULL,
    lot_apn text,
    lot_apn_unformatted text,
    lot_census_block text,
    lot_census_block_group text,
    lot_census_tract text,
    lot_landuse text,
    lot_legal_description text,
    lot_legal_section text,
    lot_size_acres_asis numeric,
    lot_legal_lot_number text,
    lot_property_use text,
    lot_subdivision text,
    lot_zoning text,
    lot_legal_block_number text,
    tax_year bigint,
    data_owner_inherited_yn text,
    data_owner_investorbuyer_yn text,
    data_mls_sold_price numeric,
    data_lien_yn text,
    data_taxlien_yn text,
    data_auction_info text,
    pi_demo_fmr_efficiency numeric,
    pi_demo_fmr_4br numeric,
    pi_demo_fmr_3br numeric,
    pi_demo_fmr_year double precision,
    data_reapi_loaded_at timestamp with time zone,
    pi_demo_suggested_rent numeric,
    pi_demo_hud_area_code text,
    pi_demo_hud_area_name text,
    pi_demo_hud_median_income numeric,
    api_response jsonb,
    CONSTRAINT property_reapi_address_zip5_check CHECK ((length(address_zip5) = 5)),
    CONSTRAINT property_reapi_pinfo_address_zip4_check CHECK ((length(address_zip4) = 4)),
    CONSTRAINT property_reapi_tax_year_check CHECK ((tax_year = 4))
);


--
-- Name: TABLE property_reapi; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.property_reapi IS 'Property search records returned by a RealEstateAPI endpoint';


--
-- Name: COLUMN property_reapi.pi_gla_sqft_asis; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.pi_gla_sqft_asis IS 'sq footage of gross living area as is';


--
-- Name: COLUMN property_reapi.tax_amount_annual; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.tax_amount_annual IS 'property tax amount annual';


--
-- Name: COLUMN property_reapi.pi_hoa_fees_annual; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.pi_hoa_fees_annual IS 'annual homeowner''s association dues';


--
-- Name: COLUMN property_reapi.data_value_asis_est; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_value_asis_est IS 'as is value - estimate';


--
-- Name: COLUMN property_reapi.lot_size_sqft_asis; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.lot_size_sqft_asis IS 'lot size (sq ft)';


--
-- Name: COLUMN property_reapi.value_arv_estimate; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.value_arv_estimate IS 'after repair value - estimate';


--
-- Name: COLUMN property_reapi.data_occupancy_oo_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_occupancy_oo_yn IS 'property is owner occupied (true/false)';


--
-- Name: COLUMN property_reapi.pi_demo_fmr_1br; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.pi_demo_fmr_1br IS 'fair market rent 1 bedroom';


--
-- Name: COLUMN property_reapi.pi_demo_fmr_2br; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.pi_demo_fmr_2br IS 'fair market rent 2 bedroom';


--
-- Name: COLUMN property_reapi.data_preforeclosure_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_preforeclosure_yn IS 'property in pre-foreclosure (true/false)';


--
-- Name: COLUMN property_reapi.data_private_lender_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_private_lender_yn IS 'lender is private lender (true/false)';


--
-- Name: COLUMN property_reapi.data_occupancy_vacant_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_occupancy_vacant_yn IS 'property is vacant (true/false)';


--
-- Name: COLUMN property_reapi.data_reapi_last_update; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_reapi_last_update IS 'data source last updated by provider (yyyy-mm-dddd hh:mm:ss)';


--
-- Name: COLUMN property_reapi."data_property_type_MFH2to4"; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi."data_property_type_MFH2to4" IS '2-4 unit multifamily (true/false)';


--
-- Name: COLUMN property_reapi."data_property_type_MFH5plus"; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi."data_property_type_MFH5plus" IS '5+ unit multifamily (true/false)';


--
-- Name: COLUMN property_reapi.data_freeclear_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_freeclear_yn IS 'property is free and clear (true/false)';


--
-- Name: COLUMN property_reapi.data_flood_zone_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_flood_zone_yn IS 'property is in a flood zone (true/false)';


--
-- Name: COLUMN property_reapi.data_owner_mortgage_arm_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_owner_mortgage_arm_yn IS 'existing mortgage is an adjustable rate mortgage (true/false)';


--
-- Name: COLUMN property_reapi.data_owner_is_entity_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_owner_is_entity_yn IS 'property owner is an entity (true/false)';


--
-- Name: COLUMN property_reapi.data_owner_is_bank_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_owner_is_bank_yn IS 'property is bank owned (true/false)';


--
-- Name: COLUMN property_reapi.data_property_type_mobilehome_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_property_type_mobilehome_yn IS 'property is a mobile home (true/false)';


--
-- Name: COLUMN property_reapi.reapi_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.reapi_id IS 'unique property id provided by RealEstateAPI';


--
-- Name: COLUMN property_reapi.lot_apn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.lot_apn IS 'assessor''s parcel number formatted';


--
-- Name: COLUMN property_reapi.lot_apn_unformatted; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.lot_apn_unformatted IS 'assessor''s parcel number unformatted';


--
-- Name: COLUMN property_reapi.lot_size_acres_asis; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.lot_size_acres_asis IS 'lot size (acres)';


--
-- Name: COLUMN property_reapi.lot_legal_lot_number; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.lot_legal_lot_number IS 'lot number per legal description';


--
-- Name: COLUMN property_reapi.lot_legal_block_number; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.lot_legal_block_number IS 'block number per legal description';


--
-- Name: COLUMN property_reapi.tax_year; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.tax_year IS 'property tax year';


--
-- Name: COLUMN property_reapi.data_owner_inherited_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_owner_inherited_yn IS 'owner acquired title by inheritance (true/false)';


--
-- Name: COLUMN property_reapi.data_owner_investorbuyer_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_owner_investorbuyer_yn IS 'owner is a real estate investor (true/false)';


--
-- Name: COLUMN property_reapi.data_lien_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_lien_yn IS 'lien present (true/false)';


--
-- Name: COLUMN property_reapi.data_taxlien_yn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_taxlien_yn IS 'tax lien present (true/false)';


--
-- Name: COLUMN property_reapi.pi_demo_fmr_efficiency; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.pi_demo_fmr_efficiency IS 'fair market rent efficiency';


--
-- Name: COLUMN property_reapi.pi_demo_fmr_4br; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.pi_demo_fmr_4br IS 'fair market rent 4 bedroom';


--
-- Name: COLUMN property_reapi.pi_demo_fmr_3br; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.pi_demo_fmr_3br IS 'fair market rent 3 bedroom';


--
-- Name: COLUMN property_reapi.pi_demo_fmr_year; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.pi_demo_fmr_year IS 'fair market rent - year of demographics data provided by HUD';


--
-- Name: COLUMN property_reapi.data_reapi_loaded_at; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.data_reapi_loaded_at IS 'timestamp: api response body loaded at';


--
-- Name: COLUMN property_reapi.api_response; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_reapi.api_response IS 'json response body';


--
-- Name: property_data_reapi_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.property_reapi ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.property_data_reapi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: property_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.property ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.property_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: property_income; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.property_income (
    id bigint NOT NULL,
    unit text,
    property_id bigint NOT NULL,
    lease_length public.lease_length,
    lease_rent numeric,
    market_rent_fmr numeric,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    updated_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    tenant_occupied public.yes_no,
    lease_term_begin date,
    lease_term_end date,
    tenant_name text,
    lease_term_status public.property_lease_term_status
);


--
-- Name: COLUMN property_income.lease_term_begin; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_income.lease_term_begin IS 'first day of the initial lease term (effective date)';


--
-- Name: COLUMN property_income.lease_term_end; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.property_income.lease_term_end IS 'last day of the initial lease term (expiration date)';


--
-- Name: property_income_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.property_income ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.property_income_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: select_uw_outcomes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.select_uw_outcomes (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    label text DEFAULT ''::text NOT NULL,
    description text DEFAULT ''::text
);


--
-- Name: TABLE select_uw_outcomes; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.select_uw_outcomes IS 'dropdown values - underwriting decisions';


--
-- Name: task_templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.task_templates (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    task_name text,
    task_description text,
    task_order numeric,
    status public.task_status,
    date_reached date,
    due_date date,
    date_completed date,
    assigned_to bigint,
    types_applied_to text,
    milestone_template_id bigint,
    days_until_due numeric,
    task_action text
);


--
-- Name: COLUMN task_templates.types_applied_to; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.task_templates.types_applied_to IS 'The deal/loan/property types a task applies to.';


--
-- Name: COLUMN task_templates.days_until_due; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.task_templates.days_until_due IS 'The number of days after which a task is due after its parent milestone turns to "In Progress"';


--
-- Name: task_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.task_templates ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.task_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: transaction_references_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.transaction_references_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transaction_references_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.transaction_references_id_seq OWNED BY public.bsi_transactions_references.id;


--
-- Name: user_clerk_orgs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_clerk_orgs ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.user_clerk_orgs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_org_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_clerk_orgs_members ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.user_org_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: uw_result_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.select_uw_outcomes ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.uw_result_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: -
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: objects; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: hooks; Type: TABLE; Schema: supabase_functions; Owner: -
--

CREATE TABLE supabase_functions.hooks (
    id bigint NOT NULL,
    hook_table_id integer NOT NULL,
    hook_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    request_id bigint
);


--
-- Name: TABLE hooks; Type: COMMENT; Schema: supabase_functions; Owner: -
--

COMMENT ON TABLE supabase_functions.hooks IS 'Supabase Functions Hooks: Audit trail for triggered hooks.';


--
-- Name: hooks_id_seq; Type: SEQUENCE; Schema: supabase_functions; Owner: -
--

CREATE SEQUENCE supabase_functions.hooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hooks_id_seq; Type: SEQUENCE OWNED BY; Schema: supabase_functions; Owner: -
--

ALTER SEQUENCE supabase_functions.hooks_id_seq OWNED BY supabase_functions.hooks.id;


--
-- Name: migrations; Type: TABLE; Schema: supabase_functions; Owner: -
--

CREATE TABLE supabase_functions.migrations (
    version text NOT NULL,
    inserted_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: -
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text,
    created_by text,
    idempotency_key text
);


--
-- Name: seed_files; Type: TABLE; Schema: supabase_migrations; Owner: -
--

CREATE TABLE supabase_migrations.seed_files (
    path text NOT NULL,
    hash text NOT NULL
);


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: hooks id; Type: DEFAULT; Schema: supabase_functions; Owner: -
--

ALTER TABLE ONLY supabase_functions.hooks ALTER COLUMN id SET DEFAULT nextval('supabase_functions.hooks_id_seq'::regclass);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: document_files Documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_files
    ADD CONSTRAINT "Documents_pkey" PRIMARY KEY (id);


--
-- Name: tasks Tasks_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT "Tasks_id_key" UNIQUE (id);


--
-- Name: tasks Tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT "Tasks_pkey" PRIMARY KEY (id);


--
-- Name: appraisal appraisal_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appraisal
    ADD CONSTRAINT appraisal_pkey PRIMARY KEY (id);


--
-- Name: borrower borrower_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.borrower
    ADD CONSTRAINT borrower_profile_pkey PRIMARY KEY (id);


--
-- Name: bs_debt_instruments_deals bs_debt_instruments_deals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bs_debt_instruments_deals
    ADD CONSTRAINT bs_debt_instruments_deals_pkey PRIMARY KEY (id);


--
-- Name: bsi_deals bsi_deals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bsi_deals
    ADD CONSTRAINT bsi_deals_pkey PRIMARY KEY (deal_id, contact_id, contact_types_id);


--
-- Name: bsi_distributions bsi_distributions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bsi_distributions
    ADD CONSTRAINT bsi_distributions_pkey PRIMARY KEY (id);


--
-- Name: bsi_statements bsi_statements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bsi_statements
    ADD CONSTRAINT bsi_statements_pkey PRIMARY KEY (id);


--
-- Name: cba_requests cba_submission_credit_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cba_requests
    ADD CONSTRAINT cba_submission_credit_id_key UNIQUE (id);


--
-- Name: cba_requests cba_submission_credit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cba_requests
    ADD CONSTRAINT cba_submission_credit_pkey PRIMARY KEY (id);


--
-- Name: cba_requests_guarantors cba_submissions_guarantors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cba_requests_guarantors
    ADD CONSTRAINT cba_submissions_guarantors_pkey PRIMARY KEY (cba_request_id, guarantor_id);


--
-- Name: company_contact company_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_contact
    ADD CONSTRAINT company_contact_pkey PRIMARY KEY (id);


--
-- Name: company_member company_member_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_member
    ADD CONSTRAINT company_member_pkey PRIMARY KEY (member_id);


--
-- Name: company company_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pkey PRIMARY KEY (co_id);


--
-- Name: company_roles_defined company_role_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_roles_defined
    ADD CONSTRAINT company_role_name_key UNIQUE (co_role);


--
-- Name: company_roles_defined company_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_roles_defined
    ADD CONSTRAINT company_role_pkey PRIMARY KEY (id);


--
-- Name: company_roles company_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_roles
    ADD CONSTRAINT company_roles_pkey PRIMARY KEY (id);


--
-- Name: constants constants_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.constants
    ADD CONSTRAINT constants_name_key UNIQUE (name);


--
-- Name: constants constants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.constants
    ADD CONSTRAINT constants_pkey PRIMARY KEY (id);


--
-- Name: contact_types_jt contact_contact_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_types_jt
    ADD CONSTRAINT contact_contact_types_pkey PRIMARY KEY (id);


--
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- Name: contact_types_jt contact_types_jt_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_types_jt
    ADD CONSTRAINT contact_types_jt_id_key UNIQUE (id);


--
-- Name: contact_types contact_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_types
    ADD CONSTRAINT contact_types_pkey PRIMARY KEY (id);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: custom_loan_fees custom_loan_fees_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_loan_fees
    ADD CONSTRAINT custom_loan_fees_pkey PRIMARY KEY (id);


--
-- Name: deal_appraisals deal_appraisals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal_appraisals
    ADD CONSTRAINT deal_appraisals_pkey PRIMARY KEY (id);


--
-- Name: deal deal_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_pkey PRIMARY KEY (id);


--
-- Name: deal_property deal_property_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal_property
    ADD CONSTRAINT deal_property_pkey PRIMARY KEY (id);


--
-- Name: deal_roles deal_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal_roles
    ADD CONSTRAINT deal_roles_pkey PRIMARY KEY (id);


--
-- Name: bs_debt_instruments debt_instruments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bs_debt_instruments
    ADD CONSTRAINT debt_instruments_pkey PRIMARY KEY (id);


--
-- Name: document_roles_assigned document_roles_assigned_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_roles_assigned
    ADD CONSTRAINT document_roles_assigned_pkey PRIMARY KEY (document_id, role_id);


--
-- Name: document_roles document_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_roles
    ADD CONSTRAINT document_roles_pkey PRIMARY KEY (id);


--
-- Name: document_roles document_roles_role_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_roles
    ADD CONSTRAINT document_roles_role_name_key UNIQUE (role_name);


--
-- Name: fee fee_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fee
    ADD CONSTRAINT fee_pkey PRIMARY KEY (id);


--
-- Name: guarantor guarantor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guarantor
    ADD CONSTRAINT guarantor_pkey PRIMARY KEY (guarantor_id);


--
-- Name: loan_application loan_application_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loan_application
    ADD CONSTRAINT loan_application_pkey PRIMARY KEY (id);


--
-- Name: milestone_templates milestone_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milestone_templates
    ADD CONSTRAINT milestone_templates_pkey PRIMARY KEY (id);


--
-- Name: milestones milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milestones
    ADD CONSTRAINT milestones_pkey PRIMARY KEY (id);


--
-- Name: payroll_submission_fees_1099 payroll_submission_fees_1099_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payroll_submission_fees_1099
    ADD CONSTRAINT payroll_submission_fees_1099_pkey PRIMARY KEY (id);


--
-- Name: payroll_submission payroll_submission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payroll_submission
    ADD CONSTRAINT payroll_submission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (id);


--
-- Name: auth_user_profile profiles_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_profile
    ADD CONSTRAINT profiles_username_key UNIQUE (username);


--
-- Name: property_reapi property_data_reapi_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property_reapi
    ADD CONSTRAINT property_data_reapi_pkey PRIMARY KEY (id);


--
-- Name: property_income property_income_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property_income
    ADD CONSTRAINT property_income_pkey PRIMARY KEY (id);


--
-- Name: property property_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT property_pkey PRIMARY KEY (id);


--
-- Name: property_reapi property_reapi_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property_reapi
    ADD CONSTRAINT property_reapi_id_key UNIQUE (id);


--
-- Name: task_templates task_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_templates
    ADD CONSTRAINT task_templates_pkey PRIMARY KEY (id);


--
-- Name: company_contact unique_company_contact; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_contact
    ADD CONSTRAINT unique_company_contact UNIQUE (co_id, contact_id, deal_id);


--
-- Name: company_roles unique_company_role_deal; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_roles
    ADD CONSTRAINT unique_company_role_deal UNIQUE (co_id, role_id, deal_id);


--
-- Name: deal_appraisals unique_deal_appraisal; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal_appraisals
    ADD CONSTRAINT unique_deal_appraisal UNIQUE (deal_id, appraisal_id);


--
-- Name: auth_clerk_orgs user_clerk_orgs_clerk_organization_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_clerk_orgs
    ADD CONSTRAINT user_clerk_orgs_clerk_organization_id_key UNIQUE (clerk_org_id);


--
-- Name: auth_clerk_orgs user_clerk_orgs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_clerk_orgs
    ADD CONSTRAINT user_clerk_orgs_pkey PRIMARY KEY (id);


--
-- Name: auth_clerk_orgs user_clerk_orgs_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_clerk_orgs
    ADD CONSTRAINT user_clerk_orgs_slug_key UNIQUE (clerk_org_slug);


--
-- Name: auth_clerk_orgs_members user_org_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_clerk_orgs_members
    ADD CONSTRAINT user_org_memberships_pkey PRIMARY KEY (id);


--
-- Name: auth_user_profile user_profile_clerk_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_profile
    ADD CONSTRAINT user_profile_clerk_id_key UNIQUE (clerk_id);


--
-- Name: select_uw_outcomes uw_result_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.select_uw_outcomes
    ADD CONSTRAINT uw_result_id_key UNIQUE (id);


--
-- Name: select_uw_outcomes uw_result_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.select_uw_outcomes
    ADD CONSTRAINT uw_result_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: hooks hooks_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: -
--

ALTER TABLE ONLY supabase_functions.hooks
    ADD CONSTRAINT hooks_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: -
--

ALTER TABLE ONLY supabase_functions.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (version);


--
-- Name: schema_migrations schema_migrations_idempotency_key_key; Type: CONSTRAINT; Schema: supabase_migrations; Owner: -
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_idempotency_key_key UNIQUE (idempotency_key);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: -
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: seed_files seed_files_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: -
--

ALTER TABLE ONLY supabase_migrations.seed_files
    ADD CONSTRAINT seed_files_pkey PRIMARY KEY (path);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: bsi_distribution_payments_pkey; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX bsi_distribution_payments_pkey ON public.bsi_transactions USING btree (id);


--
-- Name: document_files_pkey; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX document_files_pkey ON public.document_files USING btree (id);


--
-- Name: idx_user_profile_clerk_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_profile_clerk_id ON public.auth_user_profile USING btree (clerk_id);


--
-- Name: idx_user_profile_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_profile_email ON public.auth_user_profile USING btree (email);


--
-- Name: idx_user_profile_is_active_yn; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_profile_is_active_yn ON public.auth_user_profile USING btree (is_active_yn);


--
-- Name: idx_user_profile_is_banned; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_profile_is_banned ON public.auth_user_profile USING btree (is_banned);


--
-- Name: idx_user_profile_is_internal_yn; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_profile_is_internal_yn ON public.auth_user_profile USING btree (is_internal_yn);


--
-- Name: idx_user_profile_is_locked; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_profile_is_locked ON public.auth_user_profile USING btree (is_locked);


--
-- Name: idx_user_profile_last_active_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_profile_last_active_at ON public.auth_user_profile USING btree (last_active_at);


--
-- Name: idx_user_profile_last_sign_in_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_profile_last_sign_in_at ON public.auth_user_profile USING btree (last_sign_in_at);


--
-- Name: idx_user_profile_legal_accepted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_profile_legal_accepted_at ON public.auth_user_profile USING btree (legal_accepted_at);


--
-- Name: idx_user_profile_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_profile_role ON public.auth_user_profile USING btree (role);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: -
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: supabase_functions_hooks_h_table_id_h_name_idx; Type: INDEX; Schema: supabase_functions; Owner: -
--

CREATE INDEX supabase_functions_hooks_h_table_id_h_name_idx ON supabase_functions.hooks USING btree (hook_table_id, hook_name);


--
-- Name: supabase_functions_hooks_request_id_idx; Type: INDEX; Schema: supabase_functions; Owner: -
--

CREATE INDEX supabase_functions_hooks_request_id_idx ON supabase_functions.hooks USING btree (request_id);


--
-- Name: borrower handle_borrower_profile_changes_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER handle_borrower_profile_changes_trigger AFTER UPDATE OF citizenship, first_time_home_buyer, mortgage_debt, fico_score_mid_actual ON public.borrower FOR EACH ROW EXECUTE FUNCTION public.handle_user_profile_changes();


--
-- Name: auth_user_profile handle_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.auth_user_profile FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime('updated_at');


--
-- Name: borrower handle_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.borrower FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime('updated_at');


--
-- Name: company handle_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.company FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime('updated_at');


--
-- Name: company_member handle_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.company_member FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime('member_updated_at');

ALTER TABLE public.company_member DISABLE TRIGGER handle_updated_at;


--
-- Name: contact handle_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.contact FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime('updated_at');


--
-- Name: deal handle_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.deal FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime('updated_at');


--
-- Name: property handle_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER handle_updated_at BEFORE UPDATE ON public.property FOR EACH ROW EXECUTE FUNCTION extensions.moddatetime('updated_at');


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: -
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: appraisal appraisal_appraiser_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appraisal
    ADD CONSTRAINT appraisal_appraiser_id_fkey FOREIGN KEY (appraiser_id) REFERENCES public.contact(id) ON DELETE SET NULL;


--
-- Name: appraisal appraisal_co_amc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appraisal
    ADD CONSTRAINT appraisal_co_amc_fkey FOREIGN KEY (co_amc) REFERENCES public.company(co_id) ON DELETE SET NULL;


--
-- Name: appraisal appraisal_co_appraisal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appraisal
    ADD CONSTRAINT appraisal_co_appraisal_fkey FOREIGN KEY (co_appraisal) REFERENCES public.company(co_id) ON DELETE SET NULL;


--
-- Name: appraisal appraisal_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appraisal
    ADD CONSTRAINT appraisal_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id) ON DELETE SET NULL;


--
-- Name: appraisal appraisal_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appraisal
    ADD CONSTRAINT appraisal_document_id_fkey FOREIGN KEY (document_id) REFERENCES public.document_files(id) ON DELETE SET NULL;


--
-- Name: appraisal appraisal_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appraisal
    ADD CONSTRAINT appraisal_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.property(id) ON DELETE SET NULL;


--
-- Name: auth_clerk_orgs_members auth_clerk_orgs_members_clerk_org_fkey_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_clerk_orgs_members
    ADD CONSTRAINT auth_clerk_orgs_members_clerk_org_fkey_fkey FOREIGN KEY (clerk_org_fkey) REFERENCES public.auth_clerk_orgs(id);


--
-- Name: bs_debt_instruments_deals bs_debt_instruments_deals_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bs_debt_instruments_deals
    ADD CONSTRAINT bs_debt_instruments_deals_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id);


--
-- Name: bs_debt_instruments_deals bs_debt_instruments_deals_instrument_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bs_debt_instruments_deals
    ADD CONSTRAINT bs_debt_instruments_deals_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES public.bs_debt_instruments(id);


--
-- Name: bsi_distributions bsi_distributions_clerk_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bsi_distributions
    ADD CONSTRAINT bsi_distributions_clerk_org_id_fkey FOREIGN KEY (clerk_org_id) REFERENCES public.auth_clerk_orgs(id);


--
-- Name: bsi_distributions bsi_distributions_clerk_org_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bsi_distributions
    ADD CONSTRAINT bsi_distributions_clerk_org_member_id_fkey FOREIGN KEY (clerk_org_member_id) REFERENCES public.auth_clerk_orgs_members(id);


--
-- Name: bsi_distributions bsi_distributions_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bsi_distributions
    ADD CONSTRAINT bsi_distributions_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id);


--
-- Name: bsi_distributions bsi_distributions_instrument_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bsi_distributions
    ADD CONSTRAINT bsi_distributions_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES public.bs_debt_instruments(id);


--
-- Name: bsi_distributions bsi_distributions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bsi_distributions
    ADD CONSTRAINT bsi_distributions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.auth_user_profile(id);


--
-- Name: bsi_statements bsi_statements_clerk_org_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bsi_statements
    ADD CONSTRAINT bsi_statements_clerk_org_id_fkey FOREIGN KEY (clerk_org_id) REFERENCES public.auth_clerk_orgs(id);


--
-- Name: cba_requests cba_submission_credit_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cba_requests
    ADD CONSTRAINT cba_submission_credit_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id);


--
-- Name: cba_requests cba_submission_credit_submitted_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cba_requests
    ADD CONSTRAINT cba_submission_credit_submitted_by_fkey FOREIGN KEY (submitted_by) REFERENCES public.auth_user_profile(id);


--
-- Name: cba_requests cba_submission_credit_uw_prequal_result_background_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cba_requests
    ADD CONSTRAINT cba_submission_credit_uw_prequal_result_background_fkey FOREIGN KEY (uw_prequal_result_background) REFERENCES public.select_uw_outcomes(id);


--
-- Name: cba_requests cba_submission_credit_uw_prequal_result_credit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cba_requests
    ADD CONSTRAINT cba_submission_credit_uw_prequal_result_credit_fkey FOREIGN KEY (uw_prequal_result_credit) REFERENCES public.select_uw_outcomes(id);


--
-- Name: company_contact company_contact_co_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_contact
    ADD CONSTRAINT company_contact_co_id_fkey FOREIGN KEY (co_id) REFERENCES public.company(co_id) ON DELETE CASCADE;


--
-- Name: company_contact company_contact_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_contact
    ADD CONSTRAINT company_contact_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES public.contact(id) ON DELETE CASCADE;


--
-- Name: company_contact company_contact_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_contact
    ADD CONSTRAINT company_contact_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id) ON DELETE SET NULL;


--
-- Name: company_member company_member_member_borrower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_member
    ADD CONSTRAINT company_member_member_borrower_id_fkey FOREIGN KEY (member_borrower_id) REFERENCES public.borrower(id) ON DELETE CASCADE;


--
-- Name: company_member company_member_member_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_member
    ADD CONSTRAINT company_member_member_company_id_fkey FOREIGN KEY (member_company_id) REFERENCES public.company(co_id) ON DELETE CASCADE;


--
-- Name: company_member company_member_member_owning_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_member
    ADD CONSTRAINT company_member_member_owning_company_id_fkey FOREIGN KEY (member_owning_company_id) REFERENCES public.company(co_id) ON DELETE SET NULL;


--
-- Name: company company_primary_guarantor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_primary_guarantor_id_fkey FOREIGN KEY (primary_guarantor_id) REFERENCES public.company_member(member_id) ON UPDATE CASCADE;


--
-- Name: company_roles_defined company_role_mm_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_roles_defined
    ADD CONSTRAINT company_role_mm_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: company_roles company_roles_co_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_roles
    ADD CONSTRAINT company_roles_co_id_fkey FOREIGN KEY (co_id) REFERENCES public.company(co_id) ON DELETE CASCADE;


--
-- Name: company_roles company_roles_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_roles
    ADD CONSTRAINT company_roles_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: company_roles company_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_roles
    ADD CONSTRAINT company_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.company_roles_defined(id) ON DELETE CASCADE;


--
-- Name: contact contact_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT contact_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.company(co_id);


--
-- Name: contact contact_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT contact_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.auth_user_profile(id);


--
-- Name: deal deal_appraisal_poc_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_appraisal_poc_contact_id_fkey FOREIGN KEY (appraisal_poc_contact_id) REFERENCES public.contact(id) ON DELETE SET NULL;


--
-- Name: deal_appraisals deal_appraisals_appraisal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal_appraisals
    ADD CONSTRAINT deal_appraisals_appraisal_id_fkey FOREIGN KEY (appraisal_id) REFERENCES public.appraisal(id) ON DELETE SET NULL;


--
-- Name: deal_appraisals deal_appraisals_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal_appraisals
    ADD CONSTRAINT deal_appraisals_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id) ON DELETE SET NULL;


--
-- Name: deal_appraisals deal_appraisals_property_Id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal_appraisals
    ADD CONSTRAINT "deal_appraisals_property_Id_fkey" FOREIGN KEY ("property_Id") REFERENCES public.property(id) ON DELETE SET NULL;


--
-- Name: deal deal_broker_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_broker_company_id_fkey FOREIGN KEY (broker_company_id) REFERENCES public.company(co_id) ON DELETE SET NULL;


--
-- Name: deal deal_closing_agent_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_closing_agent_contact_id_fkey FOREIGN KEY (closing_agent_contact_id) REFERENCES public.contact(id) ON DELETE SET NULL;


--
-- Name: deal deal_escrow_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_escrow_company_id_fkey FOREIGN KEY (escrow_company_id) REFERENCES public.company(co_id) ON DELETE SET NULL;


--
-- Name: deal deal_escrow_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_escrow_contact_id_fkey FOREIGN KEY (escrow_contact_id) REFERENCES public.contact(id) ON DELETE SET NULL;


--
-- Name: deal deal_fourth_guarantor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_fourth_guarantor_id_fkey FOREIGN KEY (fourth_guarantor_id) REFERENCES public.guarantor(guarantor_id) ON DELETE SET NULL;


--
-- Name: deal deal_insurance_carrier_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_insurance_carrier_company_id_fkey FOREIGN KEY (insurance_carrier_company_id) REFERENCES public.company(co_id) ON DELETE SET NULL;


--
-- Name: deal deal_insurance_carrier_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_insurance_carrier_contact_id_fkey FOREIGN KEY (insurance_carrier_contact_id) REFERENCES public.contact(id) ON DELETE SET NULL;


--
-- Name: deal deal_loan_buyer_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_loan_buyer_company_id_fkey FOREIGN KEY (loan_buyer_company_id) REFERENCES public.company(co_id);


--
-- Name: deal deal_loan_buyer_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_loan_buyer_contact_id_fkey FOREIGN KEY (loan_buyer_contact_id) REFERENCES public.contact(id);


--
-- Name: deal deal_loan_opener_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_loan_opener_id_fkey FOREIGN KEY (loan_opener_id) REFERENCES public.auth_user_profile(id);


--
-- Name: deal deal_loan_processor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_loan_processor_id_fkey FOREIGN KEY (loan_processor_id) REFERENCES public.auth_user_profile(id) ON DELETE SET NULL;


--
-- Name: deal deal_primary_guarantor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_primary_guarantor_id_fkey FOREIGN KEY (primary_guarantor_id) REFERENCES public.guarantor(guarantor_id) ON DELETE SET NULL;


--
-- Name: deal deal_second_guarantor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_second_guarantor_id_fkey FOREIGN KEY (second_guarantor_id) REFERENCES public.guarantor(guarantor_id) ON DELETE SET NULL;


--
-- Name: deal deal_third_guarantor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_third_guarantor_id_fkey FOREIGN KEY (third_guarantor_id) REFERENCES public.guarantor(guarantor_id) ON DELETE SET NULL;


--
-- Name: deal deal_title_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_title_company_id_fkey FOREIGN KEY (title_company_id) REFERENCES public.company(co_id) ON DELETE SET NULL;


--
-- Name: document_files documents_borrower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_files
    ADD CONSTRAINT documents_borrower_id_fkey FOREIGN KEY (borrower_id) REFERENCES public.borrower(id) ON DELETE CASCADE;


--
-- Name: document_files documents_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_files
    ADD CONSTRAINT documents_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id) ON DELETE CASCADE;


--
-- Name: document_files documents_entity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_files
    ADD CONSTRAINT documents_entity_id_fkey FOREIGN KEY (entity_id) REFERENCES public.company(co_id) ON DELETE CASCADE;


--
-- Name: document_files documents_guarantor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_files
    ADD CONSTRAINT documents_guarantor_id_fkey FOREIGN KEY (guarantor_id) REFERENCES public.guarantor(guarantor_id);


--
-- Name: document_files documents_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_files
    ADD CONSTRAINT documents_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.property(id);


--
-- Name: document_roles_assigned fk_document; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_roles_assigned
    ADD CONSTRAINT fk_document FOREIGN KEY (document_id) REFERENCES public.document_files(id) ON DELETE CASCADE;


--
-- Name: document_roles_assigned fk_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_roles_assigned
    ADD CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES public.document_roles(id) ON DELETE CASCADE;


--
-- Name: guarantor guarantor_borrower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guarantor
    ADD CONSTRAINT guarantor_borrower_id_fkey FOREIGN KEY (borrower_id) REFERENCES public.borrower(id) ON DELETE CASCADE;


--
-- Name: guarantor guarantor_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.guarantor
    ADD CONSTRAINT guarantor_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id) ON DELETE CASCADE;


--
-- Name: loan_application loan_application_application_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loan_application
    ADD CONSTRAINT loan_application_application_deal_id_fkey FOREIGN KEY (application_deal_id) REFERENCES public.deal(id) ON DELETE SET NULL;


--
-- Name: milestones milestones_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milestones
    ADD CONSTRAINT milestones_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id) ON DELETE CASCADE;


--
-- Name: milestones milestones_milestone_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milestones
    ADD CONSTRAINT milestones_milestone_template_id_fkey FOREIGN KEY (milestone_template_id) REFERENCES public.milestone_templates(id);


--
-- Name: payroll_submission payroll_submission_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payroll_submission
    ADD CONSTRAINT payroll_submission_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: payroll_submission_fees_1099 payroll_submission_fees_1099_broker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payroll_submission_fees_1099
    ADD CONSTRAINT payroll_submission_fees_1099_broker_id_fkey FOREIGN KEY (broker_id) REFERENCES public.contact(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: payroll_submission_fees_1099 payroll_submission_fees_1099_payroll_submission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payroll_submission_fees_1099
    ADD CONSTRAINT payroll_submission_fees_1099_payroll_submission_id_fkey FOREIGN KEY (payroll_submission_id) REFERENCES public.payroll_submission(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: property property_hoa_contact_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT property_hoa_contact_fkey FOREIGN KEY (hoa_contact) REFERENCES public.contact(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: property_income property_income_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property_income
    ADD CONSTRAINT property_income_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.property(id);


--
-- Name: property_reapi property_reapi_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property_reapi
    ADD CONSTRAINT property_reapi_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.property(id);


--
-- Name: contact_types_jt public_contact_contact_types_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_types_jt
    ADD CONSTRAINT public_contact_contact_types_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES public.contact(id) ON DELETE CASCADE;


--
-- Name: contact_types_jt public_contact_contact_types_contact_types_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_types_jt
    ADD CONSTRAINT public_contact_contact_types_contact_types_id_fkey FOREIGN KEY (contact_types_id) REFERENCES public.contact_types(id) ON DELETE CASCADE;


--
-- Name: custom_loan_fees public_custom_loan_fees_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_loan_fees
    ADD CONSTRAINT public_custom_loan_fees_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id);


--
-- Name: deal public_deal_account_executive_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT public_deal_account_executive_id_fkey FOREIGN KEY (account_executive_id) REFERENCES public.auth_user_profile(id) ON DELETE SET NULL;


--
-- Name: deal public_deal_broker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT public_deal_broker_id_fkey FOREIGN KEY (broker_id) REFERENCES public.contact(id) ON DELETE SET NULL;


--
-- Name: deal public_deal_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT public_deal_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.company(co_id) ON DELETE SET NULL;


--
-- Name: deal_property public_deal_property_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal_property
    ADD CONSTRAINT public_deal_property_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id) ON DELETE CASCADE;


--
-- Name: deal public_deal_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT public_deal_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.property(id) ON DELETE SET NULL;


--
-- Name: deal_property public_deal_property_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal_property
    ADD CONSTRAINT public_deal_property_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.property(id);


--
-- Name: deal_roles public_deal_roles_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal_roles
    ADD CONSTRAINT public_deal_roles_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES public.contact(id) ON DELETE CASCADE;


--
-- Name: deal_roles public_deal_roles_contact_types_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal_roles
    ADD CONSTRAINT public_deal_roles_contact_types_id_fkey FOREIGN KEY (contact_types_id) REFERENCES public.contact_types(id) ON DELETE CASCADE;


--
-- Name: deal_roles public_deal_roles_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal_roles
    ADD CONSTRAINT public_deal_roles_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id) ON DELETE CASCADE;


--
-- Name: deal public_deal_title_company_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT public_deal_title_company_contact_id_fkey FOREIGN KEY (title_company_contact_id) REFERENCES public.contact(id) ON DELETE SET NULL;


--
-- Name: task_templates task_templates_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_templates
    ADD CONSTRAINT task_templates_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.auth_user_profile(id);


--
-- Name: task_templates task_templates_milestone_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_templates
    ADD CONSTRAINT task_templates_milestone_template_id_fkey FOREIGN KEY (milestone_template_id) REFERENCES public.milestone_templates(id);


--
-- Name: tasks tasks_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.auth_user_profile(id);


--
-- Name: tasks tasks_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deal(id) ON DELETE SET NULL;


--
-- Name: tasks tasks_milestone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_milestone_id_fkey FOREIGN KEY (milestone_id) REFERENCES public.milestones(id) ON DELETE CASCADE;


--
-- Name: auth_clerk_orgs user_clerk_orgs_created_by_clerk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_clerk_orgs
    ADD CONSTRAINT user_clerk_orgs_created_by_clerk_id_fkey FOREIGN KEY (created_by_clerk_id) REFERENCES public.auth_user_profile(clerk_id);


--
-- Name: auth_clerk_orgs_members user_org_memberships_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_clerk_orgs_members
    ADD CONSTRAINT user_org_memberships_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.auth_user_profile(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_user_profile user_profile_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_profile
    ADD CONSTRAINT user_profile_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES public.contact(id);


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: company Allow API Insert; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow API Insert" ON public.company FOR INSERT TO anon WITH CHECK (true);


--
-- Name: loan_application Allow API Insert; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow API Insert" ON public.loan_application FOR INSERT TO anon WITH CHECK (true);


--
-- Name: borrower Allow auth select; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow auth select" ON public.borrower FOR SELECT TO anon, authenticated USING (true);


--
-- Name: guarantor Allow auth select; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow auth select" ON public.guarantor FOR SELECT TO anon, authenticated USING (true);


--
-- Name: property Allow auth select; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow auth select" ON public.property FOR SELECT TO anon, authenticated USING (true);


--
-- Name: property_reapi Allow authenticated users to select all property_reapi records; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow authenticated users to select all property_reapi records" ON public.property_reapi FOR SELECT TO authenticated USING (true);


--
-- Name: property_reapi Allow users to insert property records; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow users to insert property records" ON public.property_reapi FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: deal Enable read access for all users; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Enable read access for all users" ON public.deal FOR SELECT USING (true);


--
-- Name: company Return data for API insert; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Return data for API insert" ON public.company FOR SELECT USING (true);


--
-- Name: auth_user_profile Service role can insert new users; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Service role can insert new users" ON public.auth_user_profile FOR INSERT TO service_role WITH CHECK (true);


--
-- Name: auth_user_profile Service role can read all profiles; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Service role can read all profiles" ON public.auth_user_profile FOR SELECT TO service_role USING (true);


--
-- Name: auth_user_profile Service role can update user profiles; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Service role can update user profiles" ON public.auth_user_profile FOR UPDATE TO service_role USING (true) WITH CHECK (true);


--
-- Name: contact Users can select their own contact; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can select their own contact" ON public.contact FOR SELECT TO authenticated USING ((email_address = (auth.jwt() ->> 'email'::text)));


--
-- Name: document_files Users can select their own documents; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can select their own documents" ON public.document_files FOR SELECT TO authenticated USING ((uploaded_by = (auth.uid())::text));


--
-- Name: auth_user_profile Users can select their own profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can select their own profile" ON public.auth_user_profile FOR SELECT TO authenticated USING ((clerk_id = (auth.jwt() ->> 'sub'::text)));


--
-- Name: appraisal; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.appraisal ENABLE ROW LEVEL SECURITY;

--
-- Name: auth_clerk_orgs; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.auth_clerk_orgs ENABLE ROW LEVEL SECURITY;

--
-- Name: auth_clerk_orgs_members; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.auth_clerk_orgs_members ENABLE ROW LEVEL SECURITY;

--
-- Name: auth_user_profile; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.auth_user_profile ENABLE ROW LEVEL SECURITY;

--
-- Name: borrower; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.borrower ENABLE ROW LEVEL SECURITY;

--
-- Name: bs_debt_instruments; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.bs_debt_instruments ENABLE ROW LEVEL SECURITY;

--
-- Name: bs_debt_instruments_deals; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.bs_debt_instruments_deals ENABLE ROW LEVEL SECURITY;

--
-- Name: bsi_deals; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.bsi_deals ENABLE ROW LEVEL SECURITY;

--
-- Name: bsi_distributions; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.bsi_distributions ENABLE ROW LEVEL SECURITY;

--
-- Name: bsi_statements; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.bsi_statements ENABLE ROW LEVEL SECURITY;

--
-- Name: bsi_transactions; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.bsi_transactions ENABLE ROW LEVEL SECURITY;

--
-- Name: bsi_transactions_references; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.bsi_transactions_references ENABLE ROW LEVEL SECURITY;

--
-- Name: cba_requests; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.cba_requests ENABLE ROW LEVEL SECURITY;

--
-- Name: cba_requests_guarantors; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.cba_requests_guarantors ENABLE ROW LEVEL SECURITY;

--
-- Name: company; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.company ENABLE ROW LEVEL SECURITY;

--
-- Name: company_contact; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.company_contact ENABLE ROW LEVEL SECURITY;

--
-- Name: company_member; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.company_member ENABLE ROW LEVEL SECURITY;

--
-- Name: company_roles; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.company_roles ENABLE ROW LEVEL SECURITY;

--
-- Name: company_roles_defined; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.company_roles_defined ENABLE ROW LEVEL SECURITY;

--
-- Name: constants; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.constants ENABLE ROW LEVEL SECURITY;

--
-- Name: contact; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.contact ENABLE ROW LEVEL SECURITY;

--
-- Name: contact_types; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.contact_types ENABLE ROW LEVEL SECURITY;

--
-- Name: contact_types_jt; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.contact_types_jt ENABLE ROW LEVEL SECURITY;

--
-- Name: countries; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.countries ENABLE ROW LEVEL SECURITY;

--
-- Name: custom_loan_fees; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.custom_loan_fees ENABLE ROW LEVEL SECURITY;

--
-- Name: deal; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.deal ENABLE ROW LEVEL SECURITY;

--
-- Name: deal_appraisals; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.deal_appraisals ENABLE ROW LEVEL SECURITY;

--
-- Name: deal_property; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.deal_property ENABLE ROW LEVEL SECURITY;

--
-- Name: deal_roles; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.deal_roles ENABLE ROW LEVEL SECURITY;

--
-- Name: document_files; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.document_files ENABLE ROW LEVEL SECURITY;

--
-- Name: document_roles; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.document_roles ENABLE ROW LEVEL SECURITY;

--
-- Name: document_roles_assigned; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.document_roles_assigned ENABLE ROW LEVEL SECURITY;

--
-- Name: fee; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.fee ENABLE ROW LEVEL SECURITY;

--
-- Name: guarantor; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.guarantor ENABLE ROW LEVEL SECURITY;

--
-- Name: loan_application; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.loan_application ENABLE ROW LEVEL SECURITY;

--
-- Name: milestone_templates; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.milestone_templates ENABLE ROW LEVEL SECURITY;

--
-- Name: milestones; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.milestones ENABLE ROW LEVEL SECURITY;

--
-- Name: payroll_submission; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.payroll_submission ENABLE ROW LEVEL SECURITY;

--
-- Name: payroll_submission_fees_1099; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.payroll_submission_fees_1099 ENABLE ROW LEVEL SECURITY;

--
-- Name: property; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.property ENABLE ROW LEVEL SECURITY;

--
-- Name: property_income; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.property_income ENABLE ROW LEVEL SECURITY;

--
-- Name: property_reapi; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.property_reapi ENABLE ROW LEVEL SECURITY;

--
-- Name: select_uw_outcomes; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.select_uw_outcomes ENABLE ROW LEVEL SECURITY;

--
-- Name: task_templates; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.task_templates ENABLE ROW LEVEL SECURITY;

--
-- Name: tasks; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: -
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: objects Give authenticated users access to DOCS in folder 1j7ijdx_0; Type: POLICY; Schema: storage; Owner: -
--

CREATE POLICY "Give authenticated users access to DOCS in folder 1j7ijdx_0" ON storage.objects FOR INSERT TO authenticated WITH CHECK (((bucket_id = 'document_upload'::text) AND (storage.extension(name) = 'doc'::text) AND (lower((storage.foldername(name))[1]) = 'public'::text) AND (auth.role() = 'authenticated'::text)));


--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: -
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


--
-- Name: supabase_realtime appraisal; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.appraisal;


--
-- Name: supabase_realtime auth_user_profile; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.auth_user_profile;


--
-- Name: supabase_realtime borrower; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.borrower;


--
-- Name: supabase_realtime cba_requests; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.cba_requests;


--
-- Name: supabase_realtime company; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.company;


--
-- Name: supabase_realtime company_member; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.company_member;


--
-- Name: supabase_realtime contact; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.contact;


--
-- Name: supabase_realtime deal; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.deal;


--
-- Name: supabase_realtime document_files; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.document_files;


--
-- Name: supabase_realtime fee; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.fee;


--
-- Name: supabase_realtime loan_application; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.loan_application;


--
-- Name: supabase_realtime milestones; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.milestones;


--
-- Name: supabase_realtime payroll_submission; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.payroll_submission;


--
-- Name: supabase_realtime property; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.property;


--
-- Name: supabase_realtime property_reapi; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.property_reapi;


--
-- Name: supabase_realtime tasks; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.tasks;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


--
-- PostgreSQL database dump complete
--

