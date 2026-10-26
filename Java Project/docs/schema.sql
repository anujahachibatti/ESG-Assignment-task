-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: esg_reporting_db
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `carbon_calculation_records`
--

DROP TABLE IF EXISTS `carbon_calculation_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carbon_calculation_records` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `calculation_date` datetime(6) NOT NULL,
  `calculation_version` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `emission_factors_used` text COLLATE utf8mb4_unicode_ci,
  `factor_provenance_note` text COLLATE utf8mb4_unicode_ci,
  `is_product_footprint` bit(1) NOT NULL,
  `scope1kg_co2e` double NOT NULL,
  `scope2location_kg_co2e` double NOT NULL,
  `scope2market_kg_co2e` double NOT NULL,
  `scope3category_coverage` text COLLATE utf8mb4_unicode_ci,
  `scope3kg_co2e` double NOT NULL,
  `verification_status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `organization_id` bigint NOT NULL,
  `period_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6guyad2gcy9lexehc8ynyrgvs` (`organization_id`),
  KEY `FKgdjpvgcgawx449a1up15c3wlx` (`period_id`),
  CONSTRAINT `FK6guyad2gcy9lexehc8ynyrgvs` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `FKgdjpvgcgawx449a1up15c3wlx` FOREIGN KEY (`period_id`) REFERENCES `reporting_periods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `evidence_files`
--

DROP TABLE IF EXISTS `evidence_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evidence_files` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `confidential` bit(1) NOT NULL,
  `content_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `file_size_bytes` bigint DEFAULT NULL,
  `original_filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stored_filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `metric_revision_id` bigint NOT NULL,
  `uploader_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKflky4ryyibyirf1e106ojakjg` (`metric_revision_id`),
  KEY `FKbaf2377k80bhgrdm0clm1rm94` (`uploader_id`),
  CONSTRAINT `FKbaf2377k80bhgrdm0clm1rm94` FOREIGN KEY (`uploader_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKflky4ryyibyirf1e106ojakjg` FOREIGN KEY (`metric_revision_id`) REFERENCES `metric_revisions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metric_definitions`
--

DROP TABLE IF EXISTS `metric_definitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metric_definitions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `default_unit` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `formula_description` text COLLATE utf8mb4_unicode_ci,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pillar` enum('ENVIRONMENTAL','GOVERNANCE','SOCIAL') COLLATE utf8mb4_unicode_ci NOT NULL,
  `requires_facility` bit(1) NOT NULL,
  `standard_mapping` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `why_it_matters` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK1sgg2qvpsuo57lrg50n08r2rv` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metric_entries`
--

DROP TABLE IF EXISTS `metric_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metric_entries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `facility` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_owner_id` bigint DEFAULT NULL,
  `assigned_reviewer_id` bigint DEFAULT NULL,
  `current_revision_id` bigint DEFAULT NULL,
  `definition_id` bigint NOT NULL,
  `organization_id` bigint NOT NULL,
  `period_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKan58yleies0ejwd6eher2pa95` (`period_id`,`organization_id`,`definition_id`,`facility`),
  UNIQUE KEY `UKhhdi19hh0fova34oh6h1t0994` (`current_revision_id`),
  KEY `FKems49dcb6uuc32gl0u0gkdyo9` (`assigned_owner_id`),
  KEY `FK2p41h6ay1p970iueym8b9s840` (`assigned_reviewer_id`),
  KEY `FKa48wxbe01go7riu6nmvp1nbed` (`definition_id`),
  KEY `FK4iouqg8ou9x5p1wch9i7mo3ee` (`organization_id`),
  CONSTRAINT `FK2p41h6ay1p970iueym8b9s840` FOREIGN KEY (`assigned_reviewer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK48ksqc4edc1snrr4fxhkoths6` FOREIGN KEY (`period_id`) REFERENCES `reporting_periods` (`id`),
  CONSTRAINT `FK4iouqg8ou9x5p1wch9i7mo3ee` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `FKa48wxbe01go7riu6nmvp1nbed` FOREIGN KEY (`definition_id`) REFERENCES `metric_definitions` (`id`),
  CONSTRAINT `FKems49dcb6uuc32gl0u0gkdyo9` FOREIGN KEY (`assigned_owner_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKmks3ybh05fbgyocgpmksm83kn` FOREIGN KEY (`current_revision_id`) REFERENCES `metric_revisions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metric_revisions`
--

DROP TABLE IF EXISTS `metric_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metric_revisions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assumptions_and_exclusions` text COLLATE utf8mb4_unicode_ci,
  `breakdown_json` longtext COLLATE utf8mb4_unicode_ci,
  `calculated_result_text` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `calculated_value` double DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `data_source` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_state` enum('ESTIMATED','NOT_APPLICABLE','PROVIDED','UNAVAILABLE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `estimation_status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method_description` text COLLATE utf8mb4_unicode_ci,
  `primary_value` double DEFAULT NULL,
  `review_comment` text COLLATE utf8mb4_unicode_ci,
  `reviewed_at` datetime(6) DEFAULT NULL,
  `revision_number` int NOT NULL,
  `state_reason` text COLLATE utf8mb4_unicode_ci,
  `submitted_at` datetime(6) DEFAULT NULL,
  `unit` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `workflow_status` enum('APPROVED','CHANGES_REQUESTED','DRAFT','SUBMITTED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by_id` bigint DEFAULT NULL,
  `entry_id` bigint NOT NULL,
  `reviewed_by_id` bigint DEFAULT NULL,
  `submitted_by_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK86shr4w6uycv4dnjdn22f8lsk` (`created_by_id`),
  KEY `FKq2pefbk62ak4e4n4qtor4mdf2` (`entry_id`),
  KEY `FK51b8i055s53sm6g8bicup1f8d` (`reviewed_by_id`),
  KEY `FKdty4iqrpfuxyekyi209pexx8v` (`submitted_by_id`),
  CONSTRAINT `FK51b8i055s53sm6g8bicup1f8d` FOREIGN KEY (`reviewed_by_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK86shr4w6uycv4dnjdn22f8lsk` FOREIGN KEY (`created_by_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKdty4iqrpfuxyekyi209pexx8v` FOREIGN KEY (`submitted_by_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKq2pefbk62ak4e4n4qtor4mdf2` FOREIGN KEY (`entry_id`) REFERENCES `metric_entries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organizations`
--

DROP TABLE IF EXISTS `organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sector` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('DISTRIBUTOR','LOGISTICS','MANUFACTURER','REPORTING_COMPANY','RETAILER','SUPPLIER','WHOLESALER') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKkamtsqvsul6leg7svd95mmydq` (`code`),
  UNIQUE KEY `UKp9pbw3flq9hkay8hdx3ypsldy` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_versions`
--

DROP TABLE IF EXISTS `report_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_versions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `boundary_description` text COLLATE utf8mb4_unicode_ci,
  `docx_file_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generated_at` datetime(6) NOT NULL,
  `missing_disclosures_and_limitations` text COLLATE utf8mb4_unicode_ci,
  `pdf_file_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `report_title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `snapshot_revisions_json` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `version_number` int NOT NULL,
  `carbon_calculation_id` bigint DEFAULT NULL,
  `generated_by_id` bigint NOT NULL,
  `organization_id` bigint NOT NULL,
  `period_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKr1ty5i8gik455uap1qa62sntd` (`carbon_calculation_id`),
  KEY `FKfotcsocbn43l5o3ludla5loq3` (`generated_by_id`),
  KEY `FKi8lm0kwkyso9647rwalgdkx5d` (`organization_id`),
  KEY `FKhm0gde685wjn9tc29s3snlbdt` (`period_id`),
  CONSTRAINT `FKfotcsocbn43l5o3ludla5loq3` FOREIGN KEY (`generated_by_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKhm0gde685wjn9tc29s3snlbdt` FOREIGN KEY (`period_id`) REFERENCES `reporting_periods` (`id`),
  CONSTRAINT `FKi8lm0kwkyso9647rwalgdkx5d` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `FKr1ty5i8gik455uap1qa62sntd` FOREIGN KEY (`carbon_calculation_id`) REFERENCES `carbon_calculation_records` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reporting_periods`
--

DROP TABLE IF EXISTS `reporting_periods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporting_periods` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `active` bit(1) NOT NULL,
  `boundary_type` enum('EQUITY_SHARE','FINANCIAL_CONTROL','OPERATIONAL_CONTROL') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `end_date` date NOT NULL,
  `included_facilities` text COLLATE utf8mb4_unicode_ci,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `organization_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8e5ra4x45htnlw1u3b5t82l6s` (`organization_id`),
  CONSTRAINT `FK8e5ra4x45htnlw1u3b5t82l6s` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review_audits`
--

DROP TABLE IF EXISTS `review_audits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_audits` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comments` text COLLATE utf8mb4_unicode_ci,
  `new_status` enum('APPROVED','CHANGES_REQUESTED','DRAFT','SUBMITTED') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `previous_status` enum('APPROVED','CHANGES_REQUESTED','DRAFT','SUBMITTED') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revision_number` int DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `actor_id` bigint NOT NULL,
  `metric_entry_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKq5uxv6w0k02hoih154jlt9joh` (`actor_id`),
  KEY `FKbb23qk0yg12epaar35ktsf2ks` (`metric_entry_id`),
  CONSTRAINT `FKbb23qk0yg12epaar35ktsf2ks` FOREIGN KEY (`metric_entry_id`) REFERENCES `metric_entries` (`id`),
  CONSTRAINT `FKq5uxv6w0k02hoih154jlt9joh` FOREIGN KEY (`actor_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stakeholder_links`
--

DROP TABLE IF EXISTS `stakeholder_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stakeholder_links` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `linked_at` datetime(6) DEFAULT NULL,
  `relationship_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reporting_org_id` bigint NOT NULL,
  `stakeholder_org_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKe86klgi36pq60s86t23cuwkhl` (`reporting_org_id`,`stakeholder_org_id`),
  KEY `FKkjymeajfyssghtp9cufwl4yne` (`stakeholder_org_id`),
  CONSTRAINT `FK3fplseupv06puwi2isosfg0vq` FOREIGN KEY (`reporting_org_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `FKkjymeajfyssghtp9cufwl4yne` FOREIGN KEY (`stakeholder_org_id`) REFERENCES `organizations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` bit(1) NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('ROLE_ADMIN','ROLE_CONTRIBUTOR','ROLE_REPORT_VIEWER','ROLE_REVIEWER') COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `organization_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`),
  UNIQUE KEY `UKr43af9ap4edm43mmtq01oddj6` (`username`),
  KEY `FKqpugllwvyv37klq7ft9m8aqxk` (`organization_id`),
  CONSTRAINT `FKqpugllwvyv37klq7ft9m8aqxk` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-26 16:02:24
