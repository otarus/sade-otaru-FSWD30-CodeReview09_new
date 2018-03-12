-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 12. Feb 2018 um 13:45
-- Server-Version: 10.1.30-MariaDB
-- PHP-Version: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `sade-otaru-FSWD30-CodeReview09_new`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `car`
--

CREATE TABLE `car` (
  `car_id` int(11) NOT NULL,
  `brand` varchar(20) NOT NULL,
  `model` varchar(20) NOT NULL,
  `transmission` enum('A','M') NOT NULL,
  `price` int(11) NOT NULL,
  `rented` enum('Y','N') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `driver`
--

CREATE TABLE `driver` (
  `driver_id` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `passport_number` varchar(20) NOT NULL,
  `drivers_licence` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `dropoff`
--

CREATE TABLE `dropoff` (
  `dropoff_id` int(11) NOT NULL,
  `rental_id` int(11) NOT NULL,
  `dropoff_date` date NOT NULL,
  `dropoff_location` varchar(20) NOT NULL,
  `invoice_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `invoice`
--

CREATE TABLE `invoice` (
  `invoice_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `invoice_type` enum('Basic','Additional Charges') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rental`
--

CREATE TABLE `rental` (
  `rental_id` int(11) NOT NULL,
  `car_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `reservation_id` int(11) NOT NULL,
  `pickup_location` varchar(20) NOT NULL,
  `pickup_date` date NOT NULL,
  `dropoff_date` date NOT NULL,
  `invoice_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `reservation`
--

CREATE TABLE `reservation` (
  `reservation_id` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `car_brand` varchar(20) NOT NULL,
  `car_model` varchar(20) NOT NULL,
  `transmission` enum('A','M') NOT NULL,
  `pickup_location` varchar(20) NOT NULL,
  `pickup_date` date NOT NULL,
  `dropoff_date` date NOT NULL,
  `invoice_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `car`
--
ALTER TABLE `car`
  ADD PRIMARY KEY (`car_id`);

--
-- Indizes für die Tabelle `driver`
--
ALTER TABLE `driver`
  ADD PRIMARY KEY (`driver_id`);

--
-- Indizes für die Tabelle `dropoff`
--
ALTER TABLE `dropoff`
  ADD PRIMARY KEY (`dropoff_id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `rental_id` (`rental_id`);

--
-- Indizes für die Tabelle `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`invoice_id`);

--
-- Indizes für die Tabelle `rental`
--
ALTER TABLE `rental`
  ADD PRIMARY KEY (`rental_id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `reservation_id` (`reservation_id`),
  ADD KEY `car_id` (`car_id`),
  ADD KEY `driver_id` (`driver_id`);

--
-- Indizes für die Tabelle `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `invoice_id` (`invoice_id`);

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `dropoff`
--
ALTER TABLE `dropoff`
  ADD CONSTRAINT `dropoff_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`),
  ADD CONSTRAINT `dropoff_ibfk_2` FOREIGN KEY (`rental_id`) REFERENCES `rental` (`rental_id`);

--
-- Constraints der Tabelle `rental`
--
ALTER TABLE `rental`
  ADD CONSTRAINT `rental_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`),
  ADD CONSTRAINT `rental_ibfk_2` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`),
  ADD CONSTRAINT `rental_ibfk_3` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`),
  ADD CONSTRAINT `rental_ibfk_4` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`driver_id`);

--
-- Constraints der Tabelle `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;