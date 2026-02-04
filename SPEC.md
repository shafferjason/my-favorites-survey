# My Favorites Survey - Application Spec

## Overview
A web-based "My Favorites" survey for team members to fill out their favorite foods, drinks, shops, etc. Results are stored in a database and accessible to admins through a searchable dashboard. This is intended for a Chick-fil-A team/workplace.

---

## Survey Form (Public - No Login Required)

### Language
- Toggle between English and Spanish
- All question labels display in the selected language
- Default language: English

### Fields Collected

| # | Field | DB Column | Type | Required |
|---|-------|-----------|------|----------|
| - | Name | respondent_name | text | YES |
| 1 | Favorite candy | candy | text | no |
| 2 | Favorite snack | snack | text | no |
| 3 | Favorite chips | chips | text | no |
| 4 | Favorite drink | drink | text | no |
| 5 | Favorite birthday cake flavor | cake_flavor | text | no |
| 6 | Favorite dessert | dessert | text | no |
| 7 | Favorite fast-food restaurant (not Chick-fil-A) | fast_food | text | no |
| 8 | Favorite restaurant | restaurant | text | no |
| 9 | Favorite place to shop | shop | text | no |
| 10 | Favorite color | color | text | no |
| 11 | Favorite Chick-fil-A menu item | cfa_item | text | no |
| 12 | A gift you would like to receive | gift | text | no |
| 13 | Favorite coffee or energy drink | coffee_energy | text | no |
| 14 | Favorite type of pizza | pizza | text | no |
| 15 | Favorite scent | scent | text | no |
| - | Food allergies | allergies | text | no |
| - | Caffeine preference | caffeine | Yes / No / Sometimes (radio) | no |

### Spanish Translations for Labels
| English | Spanish |
|---------|---------|
| Favorite candy | Dulce favorito |
| Favorite snack | Snack favorito |
| Favorite chips | Papitas preferidas |
| Favorite drink | Bebida favorita |
| Favorite birthday cake flavor | Sabor de pastel favorito de cumpleaños |
| Favorite dessert | Postre favorito |
| Favorite fast-food restaurant (not Chick-fil-A) | Restaurante de comida rápida favorito (que no sea Chick-fil-A) |
| Favorite restaurant | Restaurante favorito |
| Favorite place to shop | Lugar favorito para ir de compras |
| Favorite color | Color favorito |
| Favorite Chick-fil-A menu item | Artículo favorito de Chick-fil-A |
| A gift you would like to receive | Regalo que te gustaría recibir |
| Favorite coffee or energy drink | Café o bebida energética favorita |
| Favorite type of pizza | Tipo de pizza favorito |
| Favorite scent | Aroma favorito |
| Do you have any food allergies? | ¿Tienes alguna alergia alimentaria? |
| Caffeine preference | Preferencia de cafeína |
| Yes | Sí |
| Sometimes | A veces |
| Submit | Enviar |

### Behavior
- No login or authentication required to fill out the survey
- Multiple submissions are allowed (each submission creates a new record, even with the same name)
- After successful submission, show a "Thank you" confirmation with an option to submit another response
- Only the Name field is required; all other fields are optional

---

## Admin Dashboard (Password Protected)

### Authentication
- Single shared admin password (configured in app settings)
- Password is checked client-side against a stored value
- Session persists in browser tab (sessionStorage) — logging out or closing the tab clears it
- No user accounts or signup needed

### Search & Filtering
- **Primary search**: by respondent name
- **Full search**: across all answer fields (dropdown to select "All Fields" or a specific field)
- Search is case-insensitive
- Results update as the admin types (real-time filtering)

### Results Table
- Shows all submissions in reverse chronological order (newest first)
- Table columns visible in list view: Name, Candy, Snack, Drink, Color, CFA Item, Submitted Date
- Clicking a row opens a detail modal with ALL fields for that response

### Individual Response View (Modal)
- Displays the respondent's name, submission date, and all 17 answer fields
- Option to delete the response (with confirmation prompt)

### Export
- "Export CSV" button exports the currently filtered results to a .csv file
- CSV includes all fields and the submission date

---

## Tech Stack

### Backend / Database: Supabase
- **Table name**: `responses`
- Row Level Security enabled
- Policies: public INSERT, public SELECT, public DELETE (via anon key)
- See `setup.sql` for the full schema

### Frontend
- Static HTML/CSS/JavaScript (no framework required)
- Communicates with Supabase via REST API using the anon key
- Mobile-responsive design

### Configuration Required
The following values must be set before deployment:
1. `SUPABASE_URL` — Supabase project URL (in both index.html and admin.html)
2. `SUPABASE_ANON_KEY` — Supabase anon/public API key (in both files)
3. `ADMIN_PASSWORD` — The shared admin password (in admin.html only)

### Hosting
Can be deployed to any static hosting provider (Netlify, Vercel, GitHub Pages, etc.) since there is no server-side code.

---

## File Inventory

| File | Purpose |
|------|---------|
| `index.html` | Public survey form |
| `admin.html` | Admin dashboard (login, search, view, delete, export) |
| `setup.sql` | SQL script to create the Supabase table, indexes, and RLS policies |
| `SPEC.md` | This file — application specification |
