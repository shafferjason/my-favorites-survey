# My Favorites Survey — Specification

## Overview
A standalone web survey for Chick-fil-A Wall Street team members. Employees enter their clock-in number, get greeted by name, and fill out their favorite things. One response per employee, editable on return. Admin dashboard for viewing and exporting responses.

## Architecture
- **Frontend**: Static HTML/CSS/JS (no framework). Two pages: `index.html` (survey) and `admin.html` (dashboard)
- **Backend**: Supabase REST API (PostgREST) via anon key — no server-side code
- **Database**: `employee_favorites` table in the Hub's Supabase project (migrations 082-084)
- **Hosting**: Netlify (https://my-favorites-survey.netlify.app)
- **Source**: https://github.com/shafferjason/my-favorites-survey

## Survey Flow (index.html)
1. Employee enters clock-in number (5 or 6 digits)
2. REST lookup: `ident_employees?employee_code=eq.{code}&deleted_at=is.null&is_device=eq.false`
3. If found, check for existing favorites: `employee_favorites?employee_id=eq.{id}`
4. Greet by preferred_name (or first_name). Pre-fill form if returning.
5. Survey form: 15 questions grouped into 5 sections + allergies + caffeine
6. Submit via upsert: `POST /employee_favorites?on_conflict=employee_id` with `Prefer: resolution=merge-duplicates`

## Survey Questions

| # | Section | Question | DB Column |
|---|---------|----------|-----------|
| 1 | Snacks & Sweets | Favorite candy | candy |
| 2 | Snacks & Sweets | Favorite snack | snack |
| 3 | Snacks & Sweets | Favorite chips | chips |
| 4 | Snacks & Sweets | Favorite birthday cake flavor | cake_flavor |
| 5 | Snacks & Sweets | Favorite dessert | dessert |
| 6 | Drinks | Favorite drink | drink |
| 7 | Drinks | Favorite coffee or energy drink | coffee_energy |
| 8 | Dining Out | Favorite fast-food restaurant (not CFA) | fast_food |
| 9 | Dining Out | Favorite restaurant | restaurant |
| 10 | Dining Out | Favorite Chick-fil-A menu item | cfa_item |
| 11 | Dining Out | Favorite type of pizza | pizza |
| 12 | Lifestyle | Favorite place to shop | shop |
| 13 | Lifestyle | Favorite color | color |
| 14 | Lifestyle | A gift you would like to receive | gift |
| 15 | Lifestyle | Favorite scent | scent |
| - | Health | Food allergies (free text) | allergies |
| - | Health | Caffeine preference (Yes/No/Sometimes) | caffeine |

All fields are optional. No field is required.

## Admin Dashboard (admin.html)
- Password-protected (client-side, sessionStorage)
- Queries `employee_favorites` joined with `ident_employees` for names
- Search by employee name or any answer field
- Detail modal shows all answers for a single employee
- CSV export of filtered results
- Admin password: configured in `ADMIN_PASSWORD` constant

## Language Support
- English/Spanish toggle (Mexican Spanish translations)
- All labels have `data-en` and `data-es` attributes
- Language state persists across screens within a session

## Hub Database Dependencies
This project depends on tables in the AppStudio Hub Supabase project:
- `ident_employees` — employee lookup (created in Hub setup.sql)
- `employee_favorites` — survey responses (created in Hub migration 082)
- Migrations 081-084 must be applied for the survey to function

## Files
| File | Purpose |
|------|---------|
| `index.html` | Survey (login + form + success screens) |
| `admin.html` | Admin dashboard |
| `logo.jpg` | CFA Wall Street logo (used in hero + OG preview) |
| `setup.sql` | Reference schema for employee_favorites |
| `SPEC.md` | This file |
| `CHANGELOG.md` | Session log |
