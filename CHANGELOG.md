# My Favorites Survey — Changelog

## 2026-02-04 - Claude Code Session

**Complete rebuild: employee lookup, upsert, branded design**

This session replaced the original name-based survey with an employee-code-based system tied to the Hub's `ident_employees` table.

### Survey (index.html)
- Replaced free-text name entry with clock-in number lookup against `ident_employees`
- Greeting by preferred_name (or first_name) after lookup
- One response per employee via UNIQUE constraint + upsert (`on_conflict=employee_id`)
- Pre-fills form when employee returns with existing answers
- English/Spanish toggle with Mexican Spanish translations (6 corrections applied)
- Questions grouped into 5 themed sections: Snacks & Sweets, Drinks, Dining Out, Lifestyle, Health
- Full redesign: deep red gradient landing, white badge logo, iOS-style card fields, curved survey header, fade-in animations, pill-style radio buttons
- Open Graph meta tags for rich link previews
- Safe area CSS for notched phones
- CFA Wall Street logo in hero
- Removed placeholder that showed a real employee's clock-in number

### Admin (admin.html)
- Queries `employee_favorites` joined with `ident_employees` for display names
- Search filters include employee name from join
- CSV export includes clock-in number
- Detail modal shows employee name + code
- Delete restricted to authenticated users (migration 084)

### Database (Hub-side, migrations 081-084)
- 081: Relaxed employee_code CHECK to allow 5-digit codes
- 082: Created `employee_favorites` table with RLS
- 083: Seeded 116 employees from PIN Report
- 084: Security tightening (DELETE → auth rank 5+, anon SELECT narrowed)

### Deployment
- GitHub repo: https://github.com/shafferjason/my-favorites-survey
- Netlify: https://my-favorites-survey.netlify.app

### Bug fixes during session
- Upsert failing on re-submission → added `?on_conflict=employee_id` to POST URL
- Logo showing as white/pink rectangle → removed CSS brightness/invert filter, displayed as white badge
- Placeholder showing real employee code → removed placeholder
