# India Analyst Job Market: Where the Postings Actually Are

A self-sourced analysis of 953 live Data Analyst, Business Analyst, and MIS
Executive job postings across six Indian cities, pulled directly from the
Adzuna Job Search API — built to answer a question directly relevant to my
own job search: where is the demand actually concentrated, and is my
search radius too narrow?

## Why this project

Most portfolio projects use pre-cleaned datasets from Kaggle. This one is
sourced independently through a live API, which meant dealing with real
API authentication issues, data quality limitations, and messy real-world
job posting text — the kind of problems an analyst actually runs into on
the job, not in a tutorial.

## Key findings

- **MIS Executive postings are roughly 5x rarer** than Data Analyst or
  Business Analyst postings in this sample (79 vs. 427 and 447
  respectively) — despite the underlying work (reporting, dashboards, KPI
  tracking) clearly existing across many companies. A closer look at
  individual postings suggests some of this work gets filed under generic
  "Admin" or "Operations" titles/categories instead of a dedicated MIS
  title.
- **Job posting volume is heavily concentrated** in a handful of metro
  cities. Mumbai leads (229 postings), followed by Hyderabad, Bangalore,
  and Pune, with Delhi and Indore trailing well behind.
- **Indore — my home market — accounts for just 3.25% of all postings
  analyzed** across all three roles. This is direct, personal evidence
  that a location-limited job search significantly restricts the
  available opportunity pool for these roles.
- **80% of postings across all three role types were categorized as "IT
  Jobs"** by Adzuna's tagging system, regardless of whether the title was
  Data Analyst, Business Analyst, or MIS Executive — suggesting employers
  and job boards treat these roles as closely related at a categorical
  level, even though resumes and interviews for them are evaluated quite
  differently.

## Data limitation (and how I handled it)

Adzuna's free-tier API truncates the `description` field to exactly 500
characters. I discovered this by checking `.describe()` on description
length, which showed the 25th/50th/75th percentiles all clustered at
500 — a clear sign of truncation, not naturally short postings.

This meant keyword-based skill matching (searching for "SQL," "Python,"
"Power BI," etc. within descriptions) was unreliable — most real skill
requirements sit further down in a job posting than the first 500
characters typically reach. I tested combining title + category + full
description text to partially compensate, which raised match rates only
marginally, confirming the truncation — not my methodology — was the
limiting factor.

Rather than force potentially misleading skill-frequency numbers, I
scoped the analysis around what the data could answer reliably: posting
volume by role, by city, and by category — all of which come from
complete, untruncated fields.

## Tools used

- **Python** (`requests`, `pandas`) — API collection, cleaning, dedup,
  keyword extraction testing
- **Google Colab** — development environment
- **Power BI** — final dashboard (KPI cards, bar charts, matrix,
  methodology notes)
- **Adzuna Job Search API** — data source

## Methodology summary

1. Queried the Adzuna API for 3 role types × 6 cities (up to 100 postings
   per combination)
2. Saved raw JSON responses locally to avoid re-hitting the API while
   iterating
3. Loaded, deduplicated (1,049 → 953 postings), and structured into a
   single DataFrame
4. Diagnosed and documented the description-truncation limitation
5. Extracted role and city labels from search metadata (reliable) rather
   than relying solely on truncated description text
6. Built a Power BI dashboard summarizing posting volume, city
   distribution, and role × city breakdown, with an explicit note on data
   limitations

## Files in this repo

- `collect_jobs.py` — pulls postings from the Adzuna API, saves raw JSON
- `analyze_jobs.py` — cleans, deduplicates, and exports `jobs_clean.csv`
- `jobs_clean.csv` — final cleaned dataset (953 rows)
- Power BI dashboard (`.pbix`) — full interactive dashboard
