-- Create the documents table
CREATE TABLE documents (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  deal_id TEXT NOT NULL,
  category TEXT NOT NULL,
  file_type TEXT NOT NULL,
  file_size BIGINT NOT NULL,
  file_url TEXT NOT NULL,
  uploaded_by UUID NOT NULL, -- Add this column to track who uploaded the document
  upload_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better query performance
CREATE INDEX idx_documents_deal_id ON documents(deal_id);
CREATE INDEX idx_documents_category ON documents(category);
CREATE INDEX idx_documents_upload_date ON documents(upload_date);
CREATE INDEX idx_documents_uploaded_by ON documents(uploaded_by);

-- Set up RLS (Row Level Security) policies
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;

-- Users can only view documents they uploaded
CREATE POLICY "Users can only view their own documents"
  ON documents FOR SELECT
  USING (auth.uid() = uploaded_by);

-- Users can only insert documents with their user ID
CREATE POLICY "Users can only insert their own documents"
  ON documents FOR INSERT
  WITH CHECK (auth.uid() = uploaded_by);

-- Users can only update their own documents
CREATE POLICY "Users can only update their own documents"
  ON documents FOR UPDATE
  USING (auth.uid() = uploaded_by);

-- Users can only delete their own documents
CREATE POLICY "Users can only delete their own documents"
  ON documents FOR DELETE
  USING (auth.uid() = uploaded_by);
