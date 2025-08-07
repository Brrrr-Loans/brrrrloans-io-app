export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[];

export type Database = {
  public: {
    Tables: {
      appraisal: {
        Row: {
          appraiser_id: number | null;
          co_amc: number | null;
          co_appraisal: number | null;
          created_at: string;
          date_amc_vendor_accept: string | null;
          date_amc_vendor_assign: string | null;
          date_inspection_completed: string | null;
          date_inspection_scheduled: string | null;
          date_report_effective: string | null;
          date_report_expiration: string | null;
          date_report_ordered: string | null;
          date_report_received: string | null;
          deal_id: number | null;
          document_id: number | null;
          file_number: string | null;
          file_number_amc: string | null;
          id: number;
          order_status:
            | Database["public"]["Enums"]["appraisal_order_status"]
            | null;
          order_type:
            | Database["public"]["Enums"]["appraisal_order_type"]
            | null;
          property_id: number | null;
          updated_at: string | null;
          value_conclusion_as_is: number | null;
          value_conclusion_as_repaired: number | null;
          value_conclusion_fair_market_rent: number | null;
        };
        Insert: {
          appraiser_id?: number | null;
          co_amc?: number | null;
          co_appraisal?: number | null;
          created_at?: string;
          date_amc_vendor_accept?: string | null;
          date_amc_vendor_assign?: string | null;
          date_inspection_completed?: string | null;
          date_inspection_scheduled?: string | null;
          date_report_effective?: string | null;
          date_report_expiration?: string | null;
          date_report_ordered?: string | null;
          date_report_received?: string | null;
          deal_id?: number | null;
          document_id?: number | null;
          file_number?: string | null;
          file_number_amc?: string | null;
          id?: number;
          order_status?:
            | Database["public"]["Enums"]["appraisal_order_status"]
            | null;
          order_type?:
            | Database["public"]["Enums"]["appraisal_order_type"]
            | null;
          property_id?: number | null;
          updated_at?: string | null;
          value_conclusion_as_is?: number | null;
          value_conclusion_as_repaired?: number | null;
          value_conclusion_fair_market_rent?: number | null;
        };
        Update: {
          appraiser_id?: number | null;
          co_amc?: number | null;
          co_appraisal?: number | null;
          created_at?: string;
          date_amc_vendor_accept?: string | null;
          date_amc_vendor_assign?: string | null;
          date_inspection_completed?: string | null;
          date_inspection_scheduled?: string | null;
          date_report_effective?: string | null;
          date_report_expiration?: string | null;
          date_report_ordered?: string | null;
          date_report_received?: string | null;
          deal_id?: number | null;
          document_id?: number | null;
          file_number?: string | null;
          file_number_amc?: string | null;
          id?: number;
          order_status?:
            | Database["public"]["Enums"]["appraisal_order_status"]
            | null;
          order_type?:
            | Database["public"]["Enums"]["appraisal_order_type"]
            | null;
          property_id?: number | null;
          updated_at?: string | null;
          value_conclusion_as_is?: number | null;
          value_conclusion_as_repaired?: number | null;
          value_conclusion_fair_market_rent?: number | null;
        };
        Relationships: [
          {
            foreignKeyName: "appraisal_appraiser_id_fkey";
            columns: ["appraiser_id"];
            isOneToOne: false;
            referencedRelation: "contact";
            referencedColumns: ["id"];
          },
          {
            foreignKeyName: "appraisal_co_amc_fkey";
            columns: ["co_amc"];
            isOneToOne: false;
            referencedRelation: "company";
            referencedColumns: ["co_id"];
          },
          {
            foreignKeyName: "appraisal_co_appraisal_fkey";
            columns: ["co_appraisal"];
            isOneToOne: false;
            referencedRelation: "company";
            referencedColumns: ["co_id"];
          },
          {
            foreignKeyName: "appraisal_deal_id_fkey";
            columns: ["deal_id"];
            isOneToOne: false;
            referencedRelation: "deal";
            referencedColumns: ["id"];
          },
          {
            foreignKeyName: "appraisal_document_id_fkey";
            columns: ["document_id"];
            isOneToOne: false;
            referencedRelation: "document_files";
            referencedColumns: ["id"];
          },
          {
            foreignKeyName: "appraisal_property_id_fkey";
            columns: ["property_id"];
            isOneToOne: false;
            referencedRelation: "property";
            referencedColumns: ["id"];
          }
        ];
      };
      guarantor: {
        Row: {
          borrower_id: number | null;
          cell_phone: string | null;
          citizenship: Database["public"]["Enums"]["citizenship"] | null;
          created_at: string;
          credit_check:
            | Database["public"]["Enums"]["credit_check_status"]
            | null;
          date_of_birth: string | null;
          deal_id: number | null;
          email_address: string | null;
          exp_flips_sold: number | null;
          exp_ground_ups_sold: number | null;
          exp_professional_license:
            | Database["public"]["Enums"]["professional_license"]
            | null;
          exp_rentals_owned: number | null;
          fico_report_date_expiration: string | null;
          fico_report_date_pulled: string | null;
          fico_report_score_equifax: number | null;
          fico_report_score_experian: number | null;
          fico_report_score_transunion: number | null;
          fico_score_mid_actual: number | null;
          fico_score_mid_estimate: number | null;
          first_name: string | null;
          first_time_home_buyer: Database["public"]["Enums"]["yes_no"] | null;
          has_experience: Database["public"]["Enums"]["yes_no"] | null;
          home_phone: string | null;
          id: number;
          last_name: string | null;
          mailing_address_city: string | null;
          mailing_address_country: string | null;
          mailing_address_is_primary_residence: boolean | null;
          mailing_address_po_box: string | null;
          mailing_address_postal_code: string | null;
          mailing_address_state:
            | Database["public"]["Enums"]["us_states"]
            | null;
          mailing_address_state_long:
            | Database["public"]["Enums"]["us_states_long"]
            | null;
          mailing_address_street: string | null;
          mailing_address_suite_apt: string | null;
          marital_status: Database["public"]["Enums"]["marital_status"] | null;
          middle_name: string | null;
          mortgage_debt: number | null;
          name: string | null;
          office_phone: string | null;
          previous_residence_address_city: string | null;
          previous_residence_address_country: string | null;
          previous_residence_address_postal_code: string | null;
          previous_residence_address_state:
            | Database["public"]["Enums"]["us_states"]
            | null;
          previous_residence_address_state_long:
            | Database["public"]["Enums"]["us_states_long"]
            | null;
          previous_residence_address_street: string | null;
          previous_residence_address_suite_apt: string | null;
          primary_residence_address_city: string | null;
          primary_residence_address_country: string | null;
          primary_residence_address_postal_code: string | null;
          primary_residence_address_state:
            | Database["public"]["Enums"]["us_states"]
            | null;
          primary_residence_address_state_long:
            | Database["public"]["Enums"]["us_states_long"]
            | null;
          primary_residence_address_street: string | null;
          primary_residence_address_suite_apt: string | null;
          primary_residence_occupancy_start_date: string | null;
          primary_residence_ownership:
            | Database["public"]["Enums"]["residence_ownership"]
            | null;
          social_security_number: string | null;
        };
        Insert: {
          borrower_id?: number | null;
          cell_phone?: string | null;
          citizenship?: Database["public"]["Enums"]["citizenship"] | null;
          created_at?: string;
          credit_check?:
            | Database["public"]["Enums"]["credit_check_status"]
            | null;
          date_of_birth?: string | null;
          deal_id?: number | null;
          email_address?: string | null;
          exp_flips_sold?: number | null;
          exp_ground_ups_sold?: number | null;
          exp_professional_license?:
            | Database["public"]["Enums"]["professional_license"]
            | null;
          exp_rentals_owned?: number | null;
          fico_report_date_expiration?: string | null;
          fico_report_date_pulled?: string | null;
          fico_report_score_equifax?: number | null;
          fico_report_score_experian?: number | null;
          fico_report_score_transunion?: number | null;
          fico_score_mid_actual?: number | null;
          fico_score_mid_estimate?: number | null;
          first_name?: string | null;
          first_time_home_buyer?: Database["public"]["Enums"]["yes_no"] | null;
          has_experience?: Database["public"]["Enums"]["yes_no"] | null;
          home_phone?: string | null;
          id?: number;
          last_name?: string | null;
          mailing_address_city?: string | null;
          mailing_address_country?: string | null;
          mailing_address_is_primary_residence?: boolean | null;
          mailing_address_po_box?: string | null;
          mailing_address_postal_code?: string | null;
          mailing_address_state?:
            | Database["public"]["Enums"]["us_states"]
            | null;
          mailing_address_state_long?:
            | Database["public"]["Enums"]["us_states_long"]
            | null;
          mailing_address_street?: string | null;
          mailing_address_suite_apt?: string | null;
          marital_status?: Database["public"]["Enums"]["marital_status"] | null;
          middle_name?: string | null;
          mortgage_debt?: number | null;
          name?: string | null;
          office_phone?: string | null;
          previous_residence_address_city?: string | null;
          previous_residence_address_country?: string | null;
          previous_residence_address_postal_code?: string | null;
          previous_residence_address_state?:
            | Database["public"]["Enums"]["us_states"]
            | null;
          previous_residence_address_state_long?:
            | Database["public"]["Enums"]["us_states_long"]
            | null;
          previous_residence_address_street?: string | null;
          previous_residence_address_suite_apt?: string | null;
          primary_residence_address_city?: string | null;
          primary_residence_address_country?: string | null;
          primary_residence_address_postal_code?: string | null;
          primary_residence_address_state?:
            | Database["public"]["Enums"]["us_states"]
            | null;
          primary_residence_address_state_long?:
            | Database["public"]["Enums"]["us_states_long"]
            | null;
          primary_residence_address_street?: string | null;
          primary_residence_address_suite_apt?: string | null;
          primary_residence_occupancy_start_date?: string | null;
          primary_residence_ownership?:
            | Database["public"]["Enums"]["residence_ownership"]
            | null;
          social_security_number?: string | null;
        };
        Update: {
          borrower_id?: number | null;
          cell_phone?: string | null;
          citizenship?: Database["public"]["Enums"]["citizenship"] | null;
          created_at?: string;
          credit_check?:
            | Database["public"]["Enums"]["credit_check_status"]
            | null;
          date_of_birth?: string | null;
          deal_id?: number | null;
          email_address?: string | null;
          exp_flips_sold?: number | null;
          exp_ground_ups_sold?: number | null;
          exp_professional_license?:
            | Database["public"]["Enums"]["professional_license"]
            | null;
          exp_rentals_owned?: number | null;
          fico_report_date_expiration?: string | null;
          fico_report_date_pulled?: string | null;
          fico_report_score_equifax?: number | null;
          fico_report_score_experian?: number | null;
          fico_report_score_transunion?: number | null;
          fico_score_mid_actual?: number | null;
          fico_score_mid_estimate?: number | null;
          first_name?: string | null;
          first_time_home_buyer?: Database["public"]["Enums"]["yes_no"] | null;
          has_experience?: Database["public"]["Enums"]["yes_no"] | null;
          home_phone?: string | null;
          id?: number;
          last_name?: string | null;
          mailing_address_city?: string | null;
          mailing_address_country?: string | null;
          mailing_address_is_primary_residence?: boolean | null;
          mailing_address_po_box?: string | null;
          mailing_address_postal_code?: string | null;
          mailing_address_state?:
            | Database["public"]["Enums"]["us_states"]
            | null;
          mailing_address_state_long?:
            | Database["public"]["Enums"]["us_states_long"]
            | null;
          mailing_address_street?: string | null;
          mailing_address_suite_apt?: string | null;
          marital_status?: Database["public"]["Enums"]["marital_status"] | null;
          middle_name?: string | null;
          mortgage_debt?: number | null;
          name?: string | null;
          office_phone?: string | null;
          previous_residence_address_city?: string | null;
          previous_residence_address_country?: string | null;
          previous_residence_address_postal_code?: string | null;
          previous_residence_address_state?:
            | Database["public"]["Enums"]["us_states"]
            | null;
          previous_residence_address_state_long?:
            | Database["public"]["Enums"]["us_states_long"]
            | null;
          previous_residence_address_street?: string | null;
          previous_residence_address_suite_apt?: string | null;
          primary_residence_address_city?: string | null;
          primary_residence_address_country?: string | null;
          primary_residence_address_postal_code?: string | null;
          primary_residence_address_state?:
            | Database["public"]["Enums"]["us_states"]
            | null;
          primary_residence_address_state_long?:
            | Database["public"]["Enums"]["us_states_long"]
            | null;
          primary_residence_address_street?: string | null;
          primary_residence_address_suite_apt?: string | null;
          primary_residence_occupancy_start_date?: string | null;
          primary_residence_ownership?:
            | Database["public"]["Enums"]["residence_ownership"]
            | null;
          social_security_number?: string | null;
        };
        Relationships: [
          {
            foreignKeyName: "guarantor_borrower_id_fkey";
            columns: ["borrower_id"];
            isOneToOne: false;
            referencedRelation: "borrower";
            referencedColumns: ["id"];
          },
          {
            foreignKeyName: "guarantor_deal_id_fkey";
            columns: ["deal_id"];
            isOneToOne: false;
            referencedRelation: "deal";
            referencedColumns: ["id"];
          }
        ];
      };
    };
    Views: {
      [_ in never]: never;
    };
    Functions: {
      // ... functions would be defined here
    };
    Enums: {
      // ... enums would be defined here
    };
    CompositeTypes: {
      // ... composite types would be defined here
    };
  };
};
