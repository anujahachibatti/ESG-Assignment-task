# Traceable ESG Reporting Suite & Carbon Calculator Integration

A complete, enterprise-grade Java full-stack solution implementing traceable ESG reporting across Environmental, Social, and Governance pillars, integrated with organization carbon accounting, separation-of-duties review workflows, and immutable report generation.

---

## 1. Quick Access & Live Service URLs

| Component | URL | Description |
| :--- | :--- | :--- |
| **Frontend Application** | [http://localhost:3000](http://localhost:3000) | Interactive React + Vite + Tailwind CSS dashboard with Quick Role Switcher |
| **Backend API Service** | [http://localhost:8088](http://localhost:8088) | Spring Boot REST service with Spring Security JWT and MySQL storage |
| **Swagger UI Documentation** | [http://localhost:8088/swagger-ui/index.html](http://localhost:8088/swagger-ui/index.html) | Interactive OpenAPI 3 explorer and endpoint executor |
| **OpenAPI Spec (JSON)** | [http://localhost:8088/v3/api-docs](http://localhost:8088/v3/api-docs) | Raw OpenAPI 3 JSON document (also exported to `docs/openapi.json`) |

---

## 2. Demo User Credentials (Interactive Role Switching in UI)

The frontend header includes a **Role Switcher Dropdown** allowing 1-click evaluation of all user personas:

| Persona | Username | Password | Role | Organization |
| :--- | :--- | :--- | :--- | :--- |
| **Reporting Contributor** | `contributor` | `contrib123` | `ROLE_CONTRIBUTOR` | Apex Global Manufacturing Ltd |
| **Chief Sustainability Officer (Reviewer)** | `reviewer` | `review123` | `ROLE_REVIEWER` | Apex Global Manufacturing Ltd |
| **System Administrator** | `admin` | `admin123` | `ROLE_ADMIN` | Apex Global Manufacturing Ltd |
| **Tier-1 Supplier Contributor** | `supplier_user` | `supplier123` | `ROLE_CONTRIBUTOR` | GreenSteel Supply Corp |
| **External ESG Auditor** | `auditor` | `viewer123` | `ROLE_REPORT_VIEWER` | Global Assurance Ltd (Read-only) |

---

## 3. Assignment Deliverables Index

1. **Git Repositories & Final Commits:**
   - **Backend Repository:** `backend/` • Final Commit: `451ee81d3e2d113d5f815a82ea48ca50156e010f`
   - **Frontend Repository:** `frontend/` • Final Commit: `c290406c3854577291bdb4c764a22fa5c230807d`
2. **Postman Testing Documents (`postman/`):**
   - Collection: `postman/ESG_Reporting_Platform.postman_collection.json`
   - Environment: `postman/ESG_Reporting_Platform.postman_environment.json`
   - Covers calculations, evidence attachment, submission/review, blocked self-approval, and RBAC cross-org isolation.
3. **OpenAPI / Swagger Spec (`docs/`):**
   - `docs/openapi.json`
4. **Database Migration / Schema (`docs/`):**
   - `docs/schema.sql` (MySQL DDL exported from live database)
5. **Application Working Document & Sample Report (`docs/`):**
   - Design Note: `docs/ESG_APPLICATION_WORKING_DOCUMENT.md`
   - Generated Sample ESG Report (PDF): `docs/sample_esg_report.pdf`
   - Generated Sample ESG Report (Word): `backend/reports/ESG_Report_Org1_P1_v1.docx`

---

## 4. Key Architectural & ESG Verification Highlights

- **Completeness vs ESG Rating Separation:** The dashboard displays a **Reporting Completeness** metric (% of indicators reviewed and approved) with an explicit notice that completeness is not a sustainability performance score.
- **Scope 2 Bifurcation:** The carbon calculator integration cleanly segregates Location-based grid factors from Market-based contractual PPA factors.
- **Product Footprint Guard:** Operational control organization inventories are strictly isolated from product-level cradle-to-gate carbon footprints.
- **Separation of Duties:** Contributor self-approval is actively blocked at the database and API level (`actor != contributor`).
- **Zero Denominator & Calculation Safety:** Tested edge cases ensure zero denominators (e.g. 0 departures, 0 total waste) return explicit `N/A` rather than misleading zero or infinite scores.
- **Supplier Segregation:** Supplier headcounts and governance records are maintained in distinct organizations and are not summed into the reporting company's workforce.
- **Report Immutability:** Generated reports store frozen JSON snapshots with version hashes; subsequent data edits generate new versions without silently overwriting past publications.
