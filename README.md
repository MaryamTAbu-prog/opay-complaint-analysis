OPay Complaint Analysis

An analysis of 4,010 public 1 and 2 star OPay app reviews (December 2025 to November 2026) to find what users complain about most, and what OPay should look into first.

Tools: Python (scraping), SQL Server (cleaning and categorising), Power BI (dashboard)

Key findings
- 4,010 low-star (1 and 2 star) reviews analysed. 1,789 were real complaints, 1,411 were noise (praise, very short text or junk) and 810 were unclear.
- App or network problems were the largest complaint group: 564 of 1,789.
- The other top groups were Loans (209), Verification, login or access (197), Money deducted or refund (174) and Customer support (134).
- Low-star reviews rose from about 9 a day in December to about 14 a day in October. November is a partial month.

Inside the groups:
- 93 of 174 money-deducted complaints mention a refund or reversal.
- 157 of 564 app and network complaints mention network, slowness or crashes.
- 58 of 197 verification complaints mention face checks.
- 42 of 209 loan complaints mention interest or charges.

Recommendations
- Money deducted: add a transaction tracker with a stated refund time.
- App or network: add a service-status banner and promote the USSD option when the network is weak.
- Verification: show why a check failed and what to do next.
- Loans: show the full repayment cost before the user accepts.
- Support: give each complaint a ticket number and a reply-time target.

Success measure: fewer 1 and 2 star reviews per day.

How it works

1. 01_opay_review_collection.ipynb collects public 1 and 2 star reviews with the google-play-scraper library, keeps only the period that both ratings cover (from 1 December 2025), and tidies the text. Only the date, rating and review text are kept. Reviewer names are not saved.
2. The reviews are loaded into SQL Server. SQL rules (ordered CASE statements) label each review as a complaint category, noise or unclear. A view, vw_opay_complaints, feeds Power BI.
3. Power BI shows three pages: Overview, Deep dive and Recommendations.
   
Limitations

1. Only 1 and 2 star reviews were collected, so this shows what unhappy users complain about, not how all users feel.
2. Reviews come from people who chose to write, so they lean negative.
3. Keyword rules leave about 20% of reviews unclear.
4. Theme counts come from keyword matching, so they are estimates.
5. Complaints about fees and charges are counted in their own category, including some that are loan-related.
6. Reviews do not show whether users knew about USSD.
7. A rise in complaints after a date does not prove that anything caused it.

Privacy
Only public reviews were used. The repository contains no raw review text, no reviewer names and no data files. Dashboard screenshots show counts and categories only.

Run it yourself
pip install -r requirements.txt
jupyter notebook 01_opay_review_collection.ipynb


sql/03_theme_counts.sql contains the keyword counts used in the findings.

About

Built by Maryam Tolulope Abubakar. LinkedIn · GitHub
