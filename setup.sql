-- Run this in Supabase SQL Editor (https://supabase.com/dashboard/project/hqfszlxdkvwlvpwqqmbd/sql/new)

-- Strategic Focus Items table
CREATE TABLE IF NOT EXISTS strategic_items (
  id TEXT PRIMARY KEY,
  item TEXT NOT NULL,
  outcome TEXT NOT NULL,
  lens TEXT NOT NULL DEFAULT 'Cost',
  priority TEXT NOT NULL DEFAULT 'Medium',
  owner TEXT NOT NULL DEFAULT 'Don',
  status TEXT NOT NULL DEFAULT 'Open',
  r_value NUMERIC DEFAULT 0,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Strategic Users table (simple login)
CREATE TABLE IF NOT EXISTS strategic_users (
  id SERIAL PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  display_name TEXT NOT NULL,
  color TEXT NOT NULL DEFAULT '#3b82f6'
);

-- Insert default users
INSERT INTO strategic_users (username, password, display_name, color) VALUES
  ('don', 'Don123!', 'Don', '#f97316'),
  ('sean', 'Sean123!', 'Sean', '#3b82f6')
ON CONFLICT (username) DO NOTHING;

-- Enable RLS
ALTER TABLE strategic_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE strategic_users ENABLE ROW LEVEL SECURITY;

-- Allow all authenticated/anon users to read/write items (simple shared board)
CREATE POLICY "Allow all access to strategic_items" ON strategic_items FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow read access to strategic_users" ON strategic_users FOR SELECT USING (true);

-- Enable realtime
ALTER PUBLICATION supabase_realtime ADD TABLE strategic_items;
