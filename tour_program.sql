-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Anamakine: localhost:3306
-- Üretim Zamanı: 21 Oca 2025, 22:06:25
-- Sunucu sürümü: 8.0.40-0ubuntu0.24.04.1
-- PHP Sürümü: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `tour_program`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `agencyprovider`
--

CREATE TABLE `agencyprovider` (
  `id` int NOT NULL,
  `companyRef` varchar(50) NOT NULL,
  `company_name` varchar(50) NOT NULL,
  `phone_number` varchar(100) NOT NULL,
  `company_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `agencyprovider`
--

INSERT INTO `agencyprovider` (`id`, `companyRef`, `company_name`, `phone_number`, `company_id`) VALUES
(146, 'UFSQF3M3', 'Correct', '505 232 5082', 75),
(147, '6ON58P9E', 'oncu', '505 232 5050', 75);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `agencyrolemembers`
--

CREATE TABLE `agencyrolemembers` (
  `id` int NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `agencyrolemembers`
--

INSERT INTO `agencyrolemembers` (`id`, `username`, `position`, `password`, `company_id`, `created_at`) VALUES
(65, 'admin', 'admin', '$2b$10$2WQfWqNJDRuZTGHIp.LRu.9LnyjfcVKC.kgmQRGLNEK2V7cvn0yq2', 75, '2025-01-18 17:23:58'),
(69, 'yusuf', 'operasyon', '$2b$10$uCmk6M5FBhPmPW/g0spsAe2yk/Q3pu19NURwSyNNNWRabKU8K/4Cm', 75, '2025-01-18 17:43:43'),
(70, 'zemzem', 'muhasebe', '$2b$10$TYHBtIeZ8UJV4eIz0KnlieG5nm/WH08ZCGWGaFGelg6HPkfcr2F1u', 75, '2025-01-18 17:43:53');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `agency_provider_settings`
--

CREATE TABLE `agency_provider_settings` (
  `id` int NOT NULL,
  `provider_id` varchar(255) NOT NULL,
  `earnings` decimal(10,2) DEFAULT '0.00',
  `promotion_rate` decimal(5,2) DEFAULT '0.00',
  `revenue` decimal(10,2) DEFAULT '0.00',
  `pax_adult` int DEFAULT '0',
  `pax_child` int DEFAULT '0',
  `pax_free` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `areaslist`
--

CREATE TABLE `areaslist` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `region_id` int NOT NULL,
  `company_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `areaslist`
--

INSERT INTO `areaslist` (`id`, `name`, `region_id`, `company_id`, `created_at`, `updated_at`) VALUES
(14, 'Çolakli', 12, 75, '2025-01-18 19:44:34', '2025-01-18 19:44:34'),
(15, 'Kumköy', 12, 75, '2025-01-18 19:44:34', '2025-01-18 19:44:34'),
(16, 'Evrenseki', 12, 75, '2025-01-18 19:44:34', '2025-01-18 19:44:34');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `companyusers`
--

CREATE TABLE `companyusers` (
  `id` int NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `position` varchar(50) NOT NULL,
  `ref_code` varchar(50) NOT NULL,
  `company_user` varchar(100) NOT NULL,
  `company_pass` varchar(100) NOT NULL,
  `duration_use` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `verification` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `companyusers`
--

INSERT INTO `companyusers` (`id`, `company_name`, `position`, `ref_code`, `company_user`, `company_pass`, `duration_use`, `created_at`, `verification`) VALUES
(75, 'maxtoria', 'Agency', 'MAX2738', 'maxtoria', '$2b$10$qh2OzVWaDN8joN77.F2maOnp.aP0wc.8qka6sRw.QYYSnp/1Uu.BW', '1', '2025-01-18 17:22:43', 'XZZ3BD');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `regionslist`
--

CREATE TABLE `regionslist` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `company_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `regionslist`
--

INSERT INTO `regionslist` (`id`, `name`, `company_id`, `created_at`, `updated_at`) VALUES
(12, 'Side', 75, '2025-01-18 19:44:34', '2025-01-18 19:44:34');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id` int NOT NULL,
  `company_id` int NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `page_id` varchar(50) NOT NULL,
  `has_permission` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `role_permissions`
--

INSERT INTO `role_permissions` (`id`, `company_id`, `role_name`, `page_id`, `has_permission`, `created_at`, `updated_at`) VALUES
(5176, 75, 'muhasebe', 'dashboard', 1, '2025-01-21 20:14:39', '2025-01-21 20:14:39'),
(5177, 75, 'muhasebe', 'companies', 0, '2025-01-21 20:14:39', '2025-01-21 20:14:39'),
(5178, 75, 'muhasebe', 'guides', 0, '2025-01-21 20:14:39', '2025-01-21 20:14:39'),
(5179, 75, 'muhasebe', 'tours', 0, '2025-01-21 20:14:39', '2025-01-21 20:14:39'),
(5180, 75, 'muhasebe', 'reports', 0, '2025-01-21 20:14:39', '2025-01-21 20:14:39'),
(5181, 75, 'muhasebe', 'hotels', 0, '2025-01-21 20:14:39', '2025-01-21 20:14:39'),
(5182, 75, 'muhasebe', 'backup', 0, '2025-01-21 20:14:39', '2025-01-21 20:14:39'),
(5183, 75, 'muhasebe', 'settings', 0, '2025-01-21 20:14:39', '2025-01-21 20:14:39'),
(5184, 75, 'operasyon', 'dashboard', 1, '2025-01-21 20:14:39', '2025-01-21 20:14:39'),
(5185, 75, 'operasyon', 'companies', 1, '2025-01-21 20:14:39', '2025-01-21 20:14:39'),
(5186, 75, 'operasyon', 'guides', 1, '2025-01-21 20:14:39', '2025-01-21 20:14:39'),
(5187, 75, 'operasyon', 'tours', 1, '2025-01-21 20:14:39', '2025-01-21 20:14:39'),
(5188, 75, 'operasyon', 'reports', 0, '2025-01-21 20:14:39', '2025-01-21 20:14:39'),
(5189, 75, 'operasyon', 'hotels', 0, '2025-01-21 20:14:39', '2025-01-21 20:14:39'),
(5190, 75, 'operasyon', 'backup', 0, '2025-01-21 20:14:39', '2025-01-21 20:14:39'),
(5191, 75, 'operasyon', 'settings', 0, '2025-01-21 20:14:39', '2025-01-21 20:14:39');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tourlist`
--

CREATE TABLE `tourlist` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `company_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `tourlist`
--

INSERT INTO `tourlist` (`id`, `name`, `company_id`, `created_at`, `updated_at`) VALUES
(23, 'Antalya City Tour', 75, '2025-01-18 19:44:34', '2025-01-18 19:44:34'),
(24, 'Alanya City Tour', 75, '2025-01-18 19:44:34', '2025-01-18 19:44:34'),
(25, 'Pamakkale Tour', 75, '2025-01-18 19:44:34', '2025-01-18 19:44:34');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(34, 'sahin', 'sahinyucel@yandex.com', '$2b$10$HxPEFsFq.6VPFSkBZ3dNXu2Z45R1BLtqLT.UNN5bfO4StdQFD78om');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `agencyprovider`
--
ALTER TABLE `agencyprovider`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`);

--
-- Tablo için indeksler `agencyrolemembers`
--
ALTER TABLE `agencyrolemembers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`);

--
-- Tablo için indeksler `agency_provider_settings`
--
ALTER TABLE `agency_provider_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_provider` (`provider_id`);

--
-- Tablo için indeksler `areaslist`
--
ALTER TABLE `areaslist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `region_id` (`region_id`),
  ADD KEY `company_id` (`company_id`);

--
-- Tablo için indeksler `companyusers`
--
ALTER TABLE `companyusers`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `regionslist`
--
ALTER TABLE `regionslist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`);

--
-- Tablo için indeksler `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_permission` (`company_id`,`role_name`,`page_id`);

--
-- Tablo için indeksler `tourlist`
--
ALTER TABLE `tourlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `agencyprovider`
--
ALTER TABLE `agencyprovider`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=148;

--
-- Tablo için AUTO_INCREMENT değeri `agencyrolemembers`
--
ALTER TABLE `agencyrolemembers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- Tablo için AUTO_INCREMENT değeri `agency_provider_settings`
--
ALTER TABLE `agency_provider_settings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `areaslist`
--
ALTER TABLE `areaslist`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Tablo için AUTO_INCREMENT değeri `companyusers`
--
ALTER TABLE `companyusers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- Tablo için AUTO_INCREMENT değeri `regionslist`
--
ALTER TABLE `regionslist`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Tablo için AUTO_INCREMENT değeri `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5192;

--
-- Tablo için AUTO_INCREMENT değeri `tourlist`
--
ALTER TABLE `tourlist`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `agencyprovider`
--
ALTER TABLE `agencyprovider`
  ADD CONSTRAINT `agencyprovidertour` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `agencyrolemembers`
--
ALTER TABLE `agencyrolemembers`
  ADD CONSTRAINT `agencyrolemembers_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`);

--
-- Tablo kısıtlamaları `areaslist`
--
ALTER TABLE `areaslist`
  ADD CONSTRAINT `areaslist_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `regionslist` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `areaslist_ibfk_2` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `regionslist`
--
ALTER TABLE `regionslist`
  ADD CONSTRAINT `regionslist_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`);

--
-- Tablo kısıtlamaları `tourlist`
--
ALTER TABLE `tourlist`
  ADD CONSTRAINT `tourlist_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companyusers` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
