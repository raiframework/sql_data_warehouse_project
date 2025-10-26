# 🧠 RAI Framework Data Warehouse Project  

## Overview  
This project applies the **Reflective Agile Intelligence (RAI)** Framework to design and implement a modern **Data Warehouse** architecture (Bronze → Silver → Gold).  
The goal is to capture, validate, and analyze participation and engagement data for **organizational learning and improvement**, transforming raw records into ethical, data-driven insights.

---

## 🎯 Objectives  
- Track **monthly participation** and engagement based on registration and attendance data.  
- Standardize participant identities and resolve name mismatches.  
- Automate **data validation** using attendance, registration, and media metadata.  
- Provide **Power BI dashboards** for reflective and agile performance analysis.  
- Ensure **data governance, transparency, and traceability** aligned with ethical data standards.

---

## 🏗 Architecture (Medallion Model)  

| Layer | Purpose | Schema | Example Tables |
|--------|----------|---------|----------------|
| 🥉 Bronze | Raw ingestion layer (no transformations) | `bronze` | `registration_raw`, `attendance_raw`, `photo_raw` |
| 🥈 Silver | Cleaned and standardized data | `silver` | `dim_participant`, `dim_event`, `fact_attendance_clean` |
| 🥇 Gold | Business-ready analytics | `gold` | `fact_participation`, `dim_event`, `vw_monthly_engagement` |

---

## 📘 RAI-PCF Mapping  

| RAI Domain | Process | PCF Code | Description |
|-------------|----------|----------|--------------|
| Reflection | Define learning objectives & engagement KPIs | R1.1 | Identify how monthly events contribute to organizational learning |
| Agility | Automate data collection & ETL pipelines | A1.3 | Streamline ingestion and transformation using Power BI or SSIS |
| Intelligence | Validate and harmonize participation data | I1.2 | Match attendance and registration via fuzzy logic |
| Governance | Maintain participant privacy & consent | G1.4 | Ensure data records and media meet ethical standards |
| Impact | Measure learning outcomes | IM1.3 | Assess engagement trends and knowledge growth across sessions |

---

## 📊 Tools & Technologies  
- **SQL Server / SSIS** – Data modeling and ETL pipelines  
- **Power BI / DAX** – Visualization and KPIs  
- **Python / Pandas** – Data transformation and validation  
- **RAI Framework** – Reflective Agile Intelligence methodology  
- **GitHub** – Version control and documentation  

---

## 🔁 Continuous Reflection  
The data warehouse supports continuous improvement and learning cycles:  
- Compare planned vs. actual participation.  
- Identify mismatches or process issues.  
- Document insights in RAI-PCF reflective logs.  
- Adjust communication and engagement strategies based on data evidence.  

---

## 📈 Outcomes  
- A fully functional **RAI-aligned Data Warehouse** built with the Medallion architecture.  
- Improved **data quality, transparency, and learning impact tracking**.  
- Dynamic dashboards enabling **reflective, agile, and intelligent decision-making**.

---

## 📬 Authors  
**Narges Aminimoghaddam & Jafar Abolfathi**  
Reflective Agile Intelligence (RAI) Framework Creators  
📚 [raiframework.org](https://raiframework.org) *(Coming Soon)*  

---
