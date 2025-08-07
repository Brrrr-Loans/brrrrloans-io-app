export type ContactType =
  | "Appraisal Administration"
  | "Appraisal Management Company"
  | "Appraiser"
  | "Borrower"
  | "Borrower Assistant"
  | "Broker"
  | "Broker Loan Processor"
  | "General Contractor"
  | "Entity Member"
  | "Escrow"
  | "Insurance"
  | "Balance Sheet Investor"
  | "Lender"
  | "Point of Contact"
  | "Referring Party"
  | "Title"
  | "Transaction Coordinator"
  | "Loan Buyer";

export type UserRole = "admin" | "investor" | "broker" | "borrower" | "viewer";

export interface UserPermissions {
  userId: string;
  email: string;
  contactType: ContactType;
  role: UserRole;
  contactId: number;
  authUserProfileId: number;
  canAccessDeals: boolean;
  canAccessDistributions: boolean;
  canAccessDocuments: boolean;
  canAccessReports: boolean;
  canAccessAdminFeatures: boolean;
}

export class PermissionError extends Error {
  constructor(message: string, public code: string = "PERMISSION_DENIED") {
    super(message);
    this.name = "PermissionError";
  }
}
