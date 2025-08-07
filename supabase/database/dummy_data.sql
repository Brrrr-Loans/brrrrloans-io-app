-- CONTACT TYPES
INSERT INTO public.contact_types (id, name) VALUES
  (1, 'Borrower'), (2, 'Lender'), (3, 'Broker'), (4, 'Guarantor'), (5, 'Investor'),
  (6, 'Title'), (7, 'Escrow'), (8, 'Insurance'), (9, 'Appraiser'), (10, 'Other');

-- CONTACTS
INSERT INTO public.contact (id, company_id, user_id, contact_type) VALUES
  (1, NULL, 1, 'Borrower'), (2, NULL, 2, 'Lender'), (3, NULL, 3, 'Broker'), (4, NULL, 4, 'Guarantor'), (5, NULL, 5, 'Investor'),
  (6, NULL, 6, 'Title'), (7, NULL, 7, 'Escrow'), (8, NULL, 8, 'Insurance'), (9, NULL, 9, 'Appraiser'), (10, NULL, 10, 'Other');

-- AUTH USER PROFILES
INSERT INTO public.auth_user_profiles (id, contact_id, role, email, username, first_name, last_name)
VALUES
  (1, 1, 'admin', 'user1@example.com', 'user1', 'Alice', 'Smith'),
  (2, 2, 'account_executive', 'user2@example.com', 'user2', 'Bob', 'Jones'),
  (3, 3, 'loan_processor', 'user3@example.com', 'user3', 'Carol', 'Lee'),
  (4, 4, 'balance_sheet_investor', 'user4@example.com', 'user4', 'David', 'Kim'),
  (5, 5, 'loan_opener', 'user5@example.com', 'user5', 'Eve', 'Wong'),
  (6, 6, 'admin', 'user6@example.com', 'user6', 'Frank', 'Brown'),
  (7, 7, 'account_executive', 'user7@example.com', 'user7', 'Grace', 'White'),
  (8, 8, 'loan_processor', 'user8@example.com', 'user8', 'Hank', 'Green'),
  (9, 9, 'balance_sheet_investor', 'user9@example.com', 'user9', 'Ivy', 'Black'),
  (10, 10, 'loan_opener', 'user10@example.com', 'user10', 'Jack', 'Gray');

-- AUTH CLERK ORGS
INSERT INTO public.auth_clerk_orgs (id, clerk_organization_id, clerk_organization_name, clerk_organization_slug, created_by_clerk_id)
VALUES
  (1, 'org1', 'Org One', 'org-one', 'user1'),
  (2, 'org2', 'Org Two', 'org-two', 'user2'),
  (3, 'org3', 'Org Three', 'org-three', 'user3'),
  (4, 'org4', 'Org Four', 'org-four', 'user4'),
  (5, 'org5', 'Org Five', 'org-five', 'user5'),
  (6, 'org6', 'Org Six', 'org-six', 'user6'),
  (7, 'org7', 'Org Seven', 'org-seven', 'user7'),
  (8, 'org8', 'Org Eight', 'org-eight', 'user8'),
  (9, 'org9', 'Org Nine', 'org-nine', 'user9'),
  (10, 'org10', 'Org Ten', 'org-ten', 'user10');

-- AUTH CLERK ORGS MEMBERS
INSERT INTO public.auth_clerk_orgs_members (id, user_id, clerk_id, clerk_organization_fkey, clerk_role, clerk_organization_id)
VALUES
  (1, 1, 'user1', 1, 'admin', 'org1'),
  (2, 2, 'user2', 2, 'member', 'org2'),
  (3, 3, 'user3', 3, 'member', 'org3'),
  (4, 4, 'user4', 4, 'admin', 'org4'),
  (5, 5, 'user5', 5, 'member', 'org5'),
  (6, 6, 'user6', 6, 'admin', 'org6'),
  (7, 7, 'user7', 7, 'member', 'org7'),
  (8, 8, 'user8', 8, 'admin', 'org8'),
  (9, 9, 'user9', 9, 'member', 'org9'),
  (10, 10, 'user10', 10, 'admin', 'org10');

-- DEALS
INSERT INTO public.deal (id, deal_name, deal_stage_1, deal_stage_2, deal_type, deal_disposition_1, company_id, property_id, broker_id, loan_term, recently_renovated, project_type, vesting_type)
VALUES
  (1, 'Deal 1', 'lead', 'loan_setup', 'dscr', 'active', NULL, 1, 3, '12', 'yes', 'ground_up', 'entity'),
  (2, 'Deal 2', 'scenario', 'processing_1', 'rtl', 'dead', NULL, 2, 4, '24', 'no', 'rental', 'Individual'),
  (3, 'Deal 3', 'deal', 'appraisal_review', 'dscr', 'on_hold', NULL, 3, 5, '36', 'yes', 'fix_and_flip', 'entity'),
  (4, 'Deal 4', 'lead', 'processing_2', 'rtl', 'active', NULL, 4, 6, '48', 'no', 'stabilized_bridge', 'Individual'),
  (5, 'Deal 5', 'scenario', 'qc_1', 'dscr', 'dead', NULL, 5, 7, '60', 'yes', 'ground_up', 'entity'),
  (6, 'Deal 6', 'deal', 'underwriting', 'rtl', 'on_hold', NULL, 6, 8, '72', 'no', 'rental', 'Individual'),
  (7, 'Deal 7', 'lead', 'conditionally_approved', 'dscr', 'active', NULL, 7, 9, '84', 'yes', 'fix_and_flip', 'entity'),
  (8, 'Deal 8', 'scenario', 'qc_2', 'rtl', 'dead', NULL, 8, 10, '96', 'no', 'stabilized_bridge', 'Individual'),
  (9, 'Deal 9', 'deal', 'clear_to_close', 'dscr', 'on_hold', NULL, 9, 1, '108', 'yes', 'ground_up', 'entity'),
  (10, 'Deal 10', 'lead', 'closed_and_funded', 'rtl', 'active', NULL, 10, 2, '120', 'no', 'rental', 'Individual');

-- PROPERTY
INSERT INTO public.property (id, address, property_type, occupancy, recently_renovated)
VALUES
  (1, '123 Main St', 'Single Family', 'Owner Occupied', 'yes'),
  (2, '456 Oak Ave', 'Condominium', 'Tenant Occupied', 'no'),
  (3, '789 Pine Rd', 'Multifamily 2-4', 'Vacant', 'yes'),
  (4, '101 Maple Dr', 'Townhome/PUD', 'Owner Occupied', 'no'),
  (5, '202 Elm St', 'Mixed Use 2-4', 'Tenant Occupied', 'yes'),
  (6, '303 Cedar Ln', 'Other', 'Vacant', 'no'),
  (7, '404 Birch Blvd', 'Single Family', 'Owner Occupied', 'yes'),
  (8, '505 Spruce Ct', 'Condominium', 'Tenant Occupied', 'no'),
  (9, '606 Willow Way', 'Multifamily 2-4', 'Vacant', 'yes'),
  (10, '707 Aspen Pl', 'Townhome/PUD', 'Owner Occupied', 'no');

-- GUARANTOR
INSERT INTO public.guarantor (guarantor_id, first_name, last_name, borrower_id, deal_id, citizenship, has_experience, first_time_home_buyer)
VALUES
  (1, 'Alice', 'Smith', 1, 1, 'U.S. Citizen', 'yes', 'no'),
  (2, 'Bob', 'Jones', 2, 2, 'Permanent Resident', 'no', 'yes'),
  (3, 'Carol', 'Lee', 3, 3, 'Foreign National', 'yes', 'no'),
  (4, 'David', 'Kim', 4, 4, 'U.S. Citizen', 'no', 'yes'),
  (5, 'Eve', 'Wong', 5, 5, 'Permanent Resident', 'yes', 'no'),
  (6, 'Frank', 'Brown', 6, 6, 'Foreign National', 'no', 'yes'),
  (7, 'Grace', 'White', 7, 7, 'U.S. Citizen', 'yes', 'no'),
  (8, 'Hank', 'Green', 8, 8, 'Permanent Resident', 'no', 'yes'),
  (9, 'Ivy', 'Black', 9, 9, 'Foreign National', 'yes', 'no'),
  (10, 'Jack', 'Gray', 10, 10, 'U.S. Citizen', 'no', 'yes');

-- CONTACT TYPES JT
INSERT INTO public.contact_types_jt (id, contact_id, contact_types_id)
VALUES
  (1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 4), (5, 5, 5),
  (6, 6, 6), (7, 7, 7), (8, 8, 8), (9, 9, 9), (10, 10, 10);

-- BSI DEALS
INSERT INTO public.bsi_deals (deal_id, contact_id, contact_types_id)
VALUES
  (1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 4), (5, 5, 5),
  (6, 6, 6), (7, 7, 7), (8, 8, 8), (9, 9, 9), (10, 10, 10);

-- BSI STATEMENTS
INSERT INTO public.bsi_statements (id, investor_id, statement_date, statement_period_start, statement_period_end, total_upb_open, total_upb_close, total_interest, total_principal, total_fees, clerk_id, clerk_organization_id)
VALUES
  (1, 1, '2024-01-01', '2023-12-01', '2023-12-31', 100000, 95000, 5000, 4500, 500, 'user1', 'org1'),
  (2, 2, '2024-01-02', '2023-12-01', '2023-12-31', 200000, 195000, 5000, 4500, 500, 'user2', 'org2'),
  (3, 3, '2024-01-03', '2023-12-01', '2023-12-31', 300000, 295000, 5000, 4500, 500, 'user3', 'org3'),
  (4, 4, '2024-01-04', '2023-12-01', '2023-12-31', 400000, 395000, 5000, 4500, 500, 'user4', 'org4'),
  (5, 5, '2024-01-05', '2023-12-01', '2023-12-31', 500000, 495000, 5000, 4500, 500, 'user5', 'org5'),
  (6, 6, '2024-01-06', '2023-12-01', '2023-12-31', 600000, 595000, 5000, 4500, 500, 'user6', 'org6'),
  (7, 7, '2024-01-07', '2023-12-01', '2023-12-31', 700000, 695000, 5000, 4500, 500, 'user7', 'org7'),
  (8, 8, '2024-01-08', '2023-12-01', '2023-12-31', 800000, 795000, 5000, 4500, 500, 'user8', 'org8'),
  (9, 9, '2024-01-09', '2023-12-01', '2023-12-31', 900000, 895000, 5000, 4500, 500, 'user9', 'org9'),
  (10, 10, '2024-01-10', '2023-12-01', '2023-12-31', 1000000, 995000, 5000, 4500, 500, 'user10', 'org10');

-- BSI TRANSACTIONS
INSERT INTO public.bsi_transactions (id, investor_id, transaction_amount, transaction_date, transaction_method, transaction_status, reference_number, reference_type, notes, deal_id, ledger_entry_type, instrument_id, clerk_id, clerk_organization_id)
VALUES
  (1, 1, 1000, '2024-01-01', 'ach', 'completed', 'REF1', 'imad', 'Note 1', 1, 'contribution', 1, 'user1', 'org1'),
  (2, 2, 2000, '2024-01-02', 'wire', 'pending', 'REF2', 'omad', 'Note 2', 2, 'redemption', 2, 'user2', 'org2'),
  (3, 3, 3000, '2024-01-03', 'cash', 'initiated', 'REF3', 'federal_reference_number', 'Note 3', 3, 'interest', 3, 'user3', 'org3'),
  (4, 4, 4000, '2024-01-04', 'check', 'completed', 'REF4', 'imad', 'Note 4', 4, 'fee', 4, 'user4', 'org4'),
  (5, 5, 5000, '2024-01-05', 'ach', 'pending', 'REF5', 'omad', 'Note 5', 5, 'contribution', 5, 'user5', 'org5'),
  (6, 6, 6000, '2024-01-06', 'wire', 'initiated', 'REF6', 'federal_reference_number', 'Note 6', 6, 'redemption', 6, 'user6', 'org6'),
  (7, 7, 7000, '2024-01-07', 'cash', 'completed', 'REF7', 'imad', 'Note 7', 7, 'interest', 7, 'user7', 'org7'),
  (8, 8, 8000, '2024-01-08', 'check', 'pending', 'REF8', 'omad', 'Note 8', 8, 'fee', 8, 'user8', 'org8'),
  (9, 9, 9000, '2024-01-09', 'ach', 'initiated', 'REF9', 'federal_reference_number', 'Note 9', 9, 'contribution', 9, 'user9', 'org9'),
  (10, 10, 10000, '2024-01-10', 'wire', 'completed', 'REF10', 'imad', 'Note 10', 10, 'redemption', 10, 'user10', 'org10');

-- BSI TRANSACTIONS REFERENCES
INSERT INTO public.bsi_transactions_references (id, transaction_id, reference_type, reference_value)
VALUES
  (1, 1, 'imad', 'VAL1'),
  (2, 2, 'omad', 'VAL2'),
  (3, 3, 'federal_reference_number', 'VAL3'),
  (4, 4, 'imad', 'VAL4'),
  (5, 5, 'omad', 'VAL5'),
  (6, 6, 'federal_reference_number', 'VAL6'),
  (7, 7, 'imad', 'VAL7'),
  (8, 8, 'omad', 'VAL8'),
  (9, 9, 'federal_reference_number', 'VAL9'),
  (10, 10, 'imad', 'VAL10'); 