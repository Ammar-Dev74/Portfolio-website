-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 16, 2026 at 04:46 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `socialmedia`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `post_id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `image` varchar(500) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `signup`
--

CREATE TABLE `signup` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `signup`
--

INSERT INTO `signup` (`user_id`, `first_name`, `last_name`, `email`, `phone`, `password`) VALUES
(5, 'Ammar', 'khan', 'khan@gmail.com', '0123456789', 'scrypt:32768:8:1$XtqsS1ybAVlI6oIM$3f423e6d2a6e9b997a29fef0723de9393cae92e5c993ad44c2d370712e52b1068950ab8eb1a3a9835bf8a6a8568af5805cfce14e2698a30d6f964196d2240bb0'),
(7, 'Ak', 'khan', 'AK12@gmail.com', '0123456666', 'scrypt:32768:8:1$8AEgErEEFB1Uq5EA$f73a00ca99f88bcb39f84cd29cd764897ce501f2353e47fafc9745b8c6e4f583b90cda62badbb928dba58131dd35df8eb22845d5258d65dd8732826bf234a295'),
(8, 'Ak', 'khan', 'AK123@gmail.com', '0123456668', 'scrypt:32768:8:1$2hhGyh3JKETZpvt2$e441ab4770178fde85011cf86f96e766634a9217b74fe50ac8a88d3c37f0b6ba3fbdc006e308b477d1048bf22eda7d071143999f37c5de9b90227564d14df09f'),
(9, 'Ak', 'khan', 'AK1234@gmail.com', '0123456778', 'scrypt:32768:8:1$gdGqHXACrcyMZf1e$869d3d6fbc35f6926be0814aada9f1ea3bb4c4707354ebf138da0dc7681ca2a3a826b2806f7fc7c5472db1eddeb641855abc84a905f3247169e44b1cbefd2be7'),
(10, 'Ak', 'khan', 'AK12345@gmail.com', '0123456700', 'scrypt:32768:8:1$EEHefMbEdclqrRD9$9b460bfe019e9f834d1723ae03e5dc9ef68c791254d36e3a4aa0eede2a29d9e64190a3ccbe2917158e390dfba6416dac3742f23fb084f89530d5f8f652dac3cf'),
(11, 'Ak', 'khan', 'AK123456@gmail.com', '0123456708', 'scrypt:32768:8:1$qd7LgguenkH9FZhE$cec799369ba11a2a6d3cc2c0d83dc6634eccb66be2b617893f106b86a0f872fc6eacb98bb05d22fa5ee93bf9e6de27ac3ae715231184b446527685a6c18bf17d'),
(12, 'Ak', 'khan', 'AK1234567@gmail.com', '0123456709', 'scrypt:32768:8:1$Jn5Fri3L52gWVL3s$f23641a97974062aafef46cc567992f6500cc4ac7decd5a6535d0dd8e9808db97ce73cf8a54edb23e3425ba350513a06068550120ad6a927d61387bc661e0059');

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`post_id`);

--
-- Indexes for table `signup`
--
ALTER TABLE `signup`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `signup`
--
ALTER TABLE `signup`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
