-- Table: public.property_income
CREATE TABLE public.property_income (
  id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  property_id bigint NOT NULL,
  unit text NULL,
  tenant_name text NULL,
  tenant_occupied public.yes_no NULL,
  lease_length public.lease_length NULL,
  lease_rent numeric NULL,
  lease_term_begin date NULL,
  lease_term_end date NULL,
  lease_term_status public.property_lease_term_status NULL,
  market_rent_fmr numeric NULL,
  created_at timestamp with time zone NULL DEFAULT now(),
  updated_at timestamp with time zone NULL
);

-- Add foreign key constraint for property_id (property.id)
ALTER TABLE "public"."property_income" ADD CONSTRAINT "property_income_property_id_fkey" FOREIGN KEY ("property_id") REFERENCES "public"."property" ("id"); 