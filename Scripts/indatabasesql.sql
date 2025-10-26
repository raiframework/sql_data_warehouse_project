---

## ⚙️ Setup Guide

This guide explains how to set up the RAI Framework Data Warehouse locally using **SQL Server** and connect it to **Power BI** for analysis and reflection.

---

### 🧩 Step 1: Prerequisites
Before starting, make sure you have the following installed:
- **Microsoft SQL Server** (Developer or Express Edition)
- **SQL Server Management Studio (SSMS)**
- **Power BI Desktop**
- Optional: **Python** (for data transformation or automation)
- Optional: **Visual Studio / SSIS** (for automated ETL pipelines)

---

### 🧱 Step 2: Create the Database

1. Open **SQL Server Management Studio (SSMS)**.  
2. Connect to your local instance.  
3. Run the following SQL command:

```sql
CREATE DATABASE DataWarehouse;
GO
USE DataWarehouse;
GO

🪶 Step 3: Create the Medallion Architecture Schemas
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
GO
🧰 Step 4: Create Tables (RAI-PCF Aligned)
-- Example: Silver Layer Table
CREATE TABLE silver.dim_participant (
    participant_key NVARCHAR(64) PRIMARY KEY,
    standardized_name NVARCHAR(255),
    standardized_email NVARCHAR(255),
    org_id NVARCHAR(50),
    role NVARCHAR(50),
    member_type NVARCHAR(50),
    consent_ok BIT,
    last_updated DATETIME DEFAULT GETDATE()
);

Step 5: Load Data into the Bronze Layer

You can import your raw .csv files using:

SQL Server Import Wizard (right-click database → Tasks → Import Data)

or run this sample script:
BULK INSERT bronze.registration_raw
FROM 'C:\Data\registration_oct2025.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

🧪 Step 6: Clean and Transform Data (Silver Layer)

Apply transformations to:

Standardize names and emails

Match attendance to registration

Add validation flags

Example:

INSERT INTO silver.fact_attendance_clean
SELECT 
    p.participant_key,
    e.event_id,
    DATEDIFF(MINUTE, a.join_time, a.leave_time) AS attendance_minutes,
    CASE 
        WHEN a.match_score >= 0.8 THEN 1 ELSE 0 
    END AS verified
FROM bronze.attendance_raw a
JOIN silver.dim_participant p ON a.raw_email = p.standardized_email
JOIN silver.dim_event e ON a.event_code = e.event_code;

📊 Step 7: Build Analytical Models (Gold Layer)

Aggregate insights for Power BI dashboards.

Example:

CREATE OR ALTER VIEW gold.vw_monthly_engagement AS
SELECT
    FORMAT(e.event_date, 'yyyy-MM') AS month,
    COUNT(DISTINCT p.participant_key) AS participants,
    COUNT(DISTINCT CASE WHEN a.verified = 1 THEN a.participant_key END) AS verified_participants,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN a.verified = 1 THEN a.participant_key END) / NULLIF(COUNT(DISTINCT p.participant_key), 0),
        2
    ) AS engagement_rate
FROM silver.fact_attendance_clean a
JOIN silver.dim_event e ON e.event_id = a.event_id
JOIN silver.dim_participant p ON p.participant_key = a.participant_key
GROUP BY FORMAT(e.event_date, 'yyyy-MM');
GO

📈 Step 8: Connect Power BI

Open Power BI Desktop.

Click Get Data → SQL Server Database.

Enter your server name (e.g., localhost\SQLEXPRESS) and database name (DataWarehouse).

Choose DirectQuery mode for real-time insights.

Select your gold views such as:

vw_monthly_engagement

dim_participant

dim_event

Then build visuals for:

Monthly participation trends

Engagement rates

Participant demographics

Data quality or governance indicators

🔁 Step 9: Reflective Review Cycle

Use RAI-PCF codes to log insights in a dashboard or Excel sheet, e.g.:

Date	Domain	PCF Code	Insight	Action
2025-10-25	Reflection	R1.3	Participation dropped 12%	Simplify registration process
2025-10-25	Governance	G1.4	3 missing consents found	Add pre-event consent field
🧭 Step 10: Continuous Improvement

Integrate your data warehouse with:

Python or Power Automate for scheduled ETL

Email/Teams notifications for insights

RAI dashboards for reflection and transparency

🧩 Outcome

By following this setup, you will have:

A complete Reflective Data Warehouse with Bronze–Silver–Gold architecture.

Ethical, traceable insights that support data-driven reflection.

A repeatable model for continuous organizational learning.

/*
⚠️ IMPORTANT NOTICE:
Executing this script will completely remove the existing 'DataWarehouse' database (if it already exists).  
All stored data, tables, and configurations within that database will be **permanently deleted**.  

Before proceeding:
- Ensure you have created full backups of any important data.  
- Review this action carefully to avoid accidental data loss.  
- Only run this script if you intend to recreate the database from scratch.
*/
