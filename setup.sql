-- My Favorites Survey - Database Schema Reference
-- The actual table lives in the Hub project's Supabase (project: wevwmibokpqejcjjemde)
-- Created by migration: 082_employee_favorites.sql
--
-- This file is for reference only. Do NOT run this directly.

-- employee_favorites table
-- Stores one row per employee (UNIQUE on employee_id), editable via upsert
CREATE TABLE employee_favorites (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  employee_id UUID NOT NULL UNIQUE REFERENCES ident_employees(id) ON DELETE CASCADE,

  -- Survey answers (15 questions + allergies + caffeine)
  candy TEXT,
  snack TEXT,
  chips TEXT,
  drink TEXT,
  cake_flavor TEXT,
  dessert TEXT,
  fast_food TEXT,
  restaurant TEXT,
  shop TEXT,
  color TEXT,
  cfa_item TEXT,
  gift TEXT,
  coffee_energy TEXT,
  pizza TEXT,
  scent TEXT,
  allergies TEXT,
  caffeine TEXT,

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE employee_favorites ENABLE ROW LEVEL SECURITY;

-- Anon can SELECT (load existing answers for pre-fill)
CREATE POLICY "employee_favorites_anon_select"
  ON employee_favorites FOR SELECT
  TO anon
  USING (true);

-- Anon can INSERT (first submission from public survey page)
CREATE POLICY "employee_favorites_anon_insert"
  ON employee_favorites FOR INSERT
  TO anon
  WITH CHECK (true);

-- Anon can UPDATE (edit existing submission from public survey page)
CREATE POLICY "employee_favorites_anon_update"
  ON employee_favorites FOR UPDATE
  TO anon
  USING (true)
  WITH CHECK (true);

-- Authenticated users can also read
CREATE POLICY "employee_favorites_auth_select"
  ON employee_favorites FOR SELECT
  TO authenticated
  USING (true);

-- Admin can DELETE (cleanup from admin page)
CREATE POLICY "employee_favorites_admin_delete"
  ON employee_favorites FOR DELETE
  TO anon
  USING (true);

-- Index for fast lookup by employee
CREATE INDEX idx_employee_favorites_employee ON employee_favorites(employee_id);

-- Employee lookup for the survey (uses existing ident_employees table):
-- GET /rest/v1/ident_employees?employee_code=eq.{code}&select=id,first_name,preferred_name
-- The ident_employees table has an open SELECT policy (ident_employees_select_all)
