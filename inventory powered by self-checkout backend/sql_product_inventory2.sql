-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 19, 2024 at 10:11 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sql_product_inventory2`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `order_date`) VALUES
(1, '1', '2024-01-20 10:24:27'),
(2, '1', '2024-01-20 10:28:23'),
(3, '2', '2024-01-20 10:46:45'),
(9, '2', '2024-01-20 11:39:43'),
(10, '2', '2024-01-20 11:44:28'),
(11, '2', '2024-01-20 11:46:26'),
(12, '1', '2024-01-20 11:51:01'),
(13, '1', '2024-01-23 10:54:17'),
(14, '3', '2024-01-23 10:55:49'),
(15, '0', '2024-01-25 13:12:53'),
(16, '2', '2024-01-25 13:13:20'),
(17, '0', '2024-01-25 13:59:42'),
(18, '5', '2024-01-26 06:28:19'),
(19, '3', '2024-01-26 06:32:27'),
(20, '8', '2024-01-26 06:34:17'),
(21, '0', '2024-01-26 07:26:33'),
(22, '10', '2024-01-26 07:28:36'),
(23, '10', '2024-01-27 11:02:52'),
(24, '2', '2024-01-27 11:05:00'),
(25, '0', '2024-01-27 11:12:35'),
(26, '0', '2024-01-27 11:15:20'),
(27, '0', '2024-01-27 11:17:12'),
(28, '0', '2024-01-27 11:26:06'),
(29, '0', '2024-01-27 11:27:15'),
(32, '0', '2024-01-27 11:30:23'),
(33, '9', '2024-01-27 11:31:21'),
(34, '1', '2024-01-27 11:34:34'),
(35, '2', '2024-01-27 11:37:56'),
(36, '0', '2024-01-27 11:46:17'),
(37, '1', '2024-01-27 11:47:34'),
(38, '1', '2024-01-27 11:49:06'),
(39, '0', '2024-01-27 11:52:11'),
(40, '0', '2024-01-27 11:55:24'),
(41, '0', '2024-01-27 11:57:01'),
(42, '0', '2024-01-27 11:58:25'),
(43, '0', '2024-01-27 12:51:35'),
(44, '0', '2024-01-27 12:55:36'),
(45, '0', '2024-01-27 13:04:10'),
(46, '1', '2024-01-27 13:07:31'),
(47, '0', '2024-01-27 13:10:10'),
(48, '0', '2024-01-27 13:12:48'),
(49, '0', '2024-01-27 13:14:55'),
(50, '0', '2024-01-27 13:15:54'),
(51, '10', '2024-01-27 13:48:50'),
(52, '0', '2024-02-05 08:22:42'),
(53, '10', '2024-02-06 11:32:21'),
(54, '356fs5656', '2024-02-07 11:37:23'),
(55, '654381d3fce764fc844670ef', '2024-02-07 11:47:33'),
(56, '654381d3fce764fc844670ef', '2024-02-07 11:57:50'),
(57, '654381d3fce764fc844670ef', '2024-02-07 11:58:33'),
(58, '654381d3fce764fc844670ef', '2024-02-07 12:59:09'),
(59, '654381d3fce764fc844670ef', '2024-02-07 13:02:52'),
(60, '654381d3fce764fc844670ef', '2024-02-07 13:06:39'),
(61, '654381d3fce764fc844670ef', '2024-02-07 13:07:15'),
(62, '654381d3fce764fc844670ef', '2024-02-07 13:13:11'),
(63, '654381d3fce764fc844670ef', '2024-02-09 10:20:17'),
(64, '654381d3fce764fc844670ef', '2024-02-09 10:49:38'),
(65, '654381d3fce764fc844670ef', '2024-02-09 11:02:21'),
(66, '654381d3fce764fc844670ef', '2024-02-09 11:42:35'),
(67, '654381d3fce764fc844670ef', '2024-02-10 11:12:36'),
(68, '654381d3fce764fc844670ef', '2024-02-10 12:48:42'),
(69, '654381d3fce764fc844670ef', '2024-02-10 12:55:15'),
(70, '654381d3fce764fc844670ef', '2024-02-11 08:02:42'),
(71, '654381d3fce764fc844670ef', '2024-02-11 08:21:13'),
(72, '654381d3fce764fc844670ef', '2024-02-11 08:22:13'),
(73, '654381d3fce764fc844670ef', '2024-02-11 08:33:52'),
(74, '654381d3fce764fc844670ef', '2024-02-11 08:41:55'),
(75, '654381d3fce764fc844670ef', '2024-02-11 08:44:53'),
(76, '654381d3fce764fc844670ef', '2024-02-11 08:46:19'),
(77, '654381d3fce764fc844670ef', '2024-02-11 08:49:08'),
(78, '654381d3fce764fc844670ef', '2024-02-11 08:50:24'),
(79, '654381d3fce764fc844670ef', '2024-02-11 08:50:42'),
(80, '654381d3fce764fc844670ef', '2024-02-11 08:51:51'),
(81, '654381d3fce764fc844670ef', '2024-02-11 08:52:07'),
(82, '654381d3fce764fc844670ef', '2024-02-11 08:53:43'),
(83, '654381d3fce764fc844670ef', '2024-02-11 08:54:00'),
(84, '654381d3fce764fc844670ef', '2024-02-11 09:17:33'),
(85, '654381d3fce764fc844670ef', '2024-02-11 09:18:53'),
(86, '654381d3fce764fc844670ef', '2024-02-11 09:20:18'),
(87, '654381d3fce764fc844670ef', '2024-02-11 09:21:18'),
(88, '654381d3fce764fc844670ef', '2024-02-11 09:22:01'),
(89, '654381d3fce764fc844670ef', '2024-02-11 09:24:09'),
(90, '654381d3fce764fc844670ef', '2024-02-11 09:25:34'),
(91, '654381d3fce764fc844670ef', '2024-02-11 09:33:15'),
(92, '654381d3fce764fc844670ef', '2024-02-11 09:35:14'),
(93, '654381d3fce764fc844670ef', '2024-02-11 09:36:37'),
(94, '654381d3fce764fc844670ef', '2024-02-11 09:37:08'),
(95, '654381d3fce764fc844670ef', '2024-02-11 09:38:04'),
(96, '654381d3fce764fc844670ef', '2024-02-11 09:38:44'),
(97, '654381d3fce764fc844670ef', '2024-02-11 09:42:19'),
(98, '654381d3fce764fc844670ef', '2024-02-11 09:43:17'),
(99, '654381d3fce764fc844670ef', '2024-02-11 09:45:09'),
(100, '654381d3fce764fc844670ef', '2024-02-11 09:46:03'),
(101, '654381d3fce764fc844670ef', '2024-02-11 11:23:01'),
(102, '654381d3fce764fc844670ef', '2024-02-11 11:41:15'),
(103, '654381d3fce764fc844670ef', '2024-02-11 11:43:42'),
(104, '654381d3fce764fc844670ef', '2024-02-11 11:46:01'),
(105, '654381d3fce764fc844670ef', '2024-02-11 11:49:50'),
(106, '654381d3fce764fc844670ef', '2024-02-11 11:50:42'),
(107, '654381d3fce764fc844670ef', '2024-02-11 11:52:28'),
(108, '654381d3fce764fc844670ef', '2024-02-11 11:54:21'),
(109, '654381d3fce764fc844670ef', '2024-02-11 11:55:58'),
(110, '654381d3fce764fc844670ef', '2024-02-11 11:57:01'),
(111, '654381d3fce764fc844670ef', '2024-02-11 11:59:31'),
(112, '654381d3fce764fc844670ef', '2024-02-11 12:02:40'),
(113, '654381d3fce764fc844670ef', '2024-02-11 12:06:35'),
(114, '654381d3fce764fc844670ef', '2024-02-11 12:07:22'),
(115, '654381d3fce764fc844670ef', '2024-02-11 12:08:37'),
(116, '654381d3fce764fc844670ef', '2024-02-11 12:12:52'),
(117, '654381d3fce764fc844670ef', '2024-02-11 12:13:44'),
(118, '654381d3fce764fc844670ef', '2024-02-11 12:14:32'),
(119, '654381d3fce764fc844670ef', '2024-02-11 12:14:55'),
(120, '654381d3fce764fc844670ef', '2024-02-11 12:15:21'),
(121, '654381d3fce764fc844670ef', '2024-02-11 12:15:53'),
(122, '654381d3fce764fc844670ef', '2024-02-11 12:18:25'),
(123, '654381d3fce764fc844670ef', '2024-02-11 12:26:48'),
(124, '654381d3fce764fc844670ef', '2024-02-11 12:28:37'),
(125, '654381d3fce764fc844670ef', '2024-02-11 12:29:50'),
(126, '654381d3fce764fc844670ef', '2024-02-11 12:30:38'),
(127, '654381d3fce764fc844670ef', '2024-02-11 12:32:03'),
(128, '654381d3fce764fc844670ef', '2024-02-11 12:34:33'),
(129, '654381d3fce764fc844670ef', '2024-02-11 12:37:15'),
(130, '654381d3fce764fc844670ef', '2024-02-11 16:32:52'),
(131, '654381d3fce764fc844670ef', '2024-02-11 17:07:29'),
(132, '654381d3fce764fc844670ef', '2024-02-11 17:08:16'),
(133, '654381d3fce764fc844670ef', '2024-02-11 17:09:24'),
(134, '654381d3fce764fc844670ef', '2024-02-11 17:11:57'),
(135, '654381d3fce764fc844670ef', '2024-02-11 18:00:30'),
(136, '654381d3fce764fc844670ef', '2024-02-11 18:36:39'),
(137, '654381d3fce764fc844670ef', '2024-02-11 18:45:46'),
(138, '654381d3fce764fc844670ef', '2024-02-11 19:09:02'),
(139, '654381d3fce764fc844670ef', '2024-02-12 03:51:01'),
(140, '65c998b7bcf31331fec274b4', '2024-02-12 04:09:09'),
(141, '654381d3fce764fc844670ef', '2024-02-12 06:20:07'),
(142, '654381d3fce764fc844670ef', '2024-02-12 06:37:54'),
(143, '654381d3fce764fc844670ef', '2024-02-20 06:27:47'),
(144, '654381d3fce764fc844670ef', '2024-02-20 06:30:45'),
(145, '654381d3fce764fc844670ef', '2024-03-06 09:29:42'),
(146, '65eaab791b5f6390777845f9', '2024-03-08 06:30:29'),
(147, '65eaab791b5f6390777845f9', '2024-03-08 06:31:27'),
(148, '654381d3fce764fc844670ef', '2024-03-08 06:38:02'),
(149, '654381d3fce764fc844670ef', '2024-03-18 07:15:53'),
(150, '654381d3fce764fc844670ef', '2024-03-18 08:11:04'),
(151, '65f7f9dad05fbe93af7ab513', '2024-03-18 08:24:07'),
(152, '65f7f9dad05fbe93af7ab513', '2024-03-18 08:27:12'),
(153, '654381d3fce764fc844670ef', '2024-03-18 08:35:26'),
(154, '0', '2024-03-18 17:46:25'),
(155, '65f7f9dad05fbe93af7ab513', '2024-03-19 04:31:50'),
(156, '65f7f9dad05fbe93af7ab513', '2024-03-19 05:12:38'),
(157, '654381d3fce764fc844670ef', '2024-03-19 05:37:11'),
(158, '654381d3fce764fc844670ef', '2024-05-22 12:23:26'),
(159, '654381d3fce764fc844670ef', '2024-05-22 12:31:42'),
(160, '654381d3fce764fc844670ef', '2024-05-22 22:00:43'),
(161, '654381d3fce764fc844670ef', '2024-05-22 22:14:29'),
(162, '654381d3fce764fc844670ef', '2024-05-23 04:06:52'),
(163, '654381d3fce764fc844670ef', '2024-05-23 05:28:50'),
(164, '654381d3fce764fc844670ef', '2024-05-23 05:58:47'),
(165, '654381d3fce764fc844670ef', '2024-06-01 04:54:39'),
(166, '654381d3fce764fc844670ef', '2024-06-01 05:52:08'),
(167, '654381d3fce764fc844670ef', '2024-06-01 10:01:28'),
(168, '654381d3fce764fc844670ef', '2024-06-01 11:50:50');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`) VALUES
(1, 1, 13, 2),
(2, 1, 14, 1),
(3, 2, 13, 1),
(4, 2, 14, 1),
(5, 3, 14, 1),
(16, 9, 13, 3),
(17, 9, 14, 1),
(18, 10, 13, 3),
(19, 10, 14, 1),
(20, 11, 13, 3),
(21, 11, 14, 1),
(22, 12, 13, 1),
(23, 12, 14, 1),
(24, 13, 13, 3),
(25, 13, 14, 4),
(26, 14, 13, 2),
(27, 14, 14, 3),
(28, 15, 14, 1),
(29, 16, 14, 1),
(30, 16, 15, 2),
(31, 17, 13, 1),
(32, 17, 15, 1),
(33, 18, 13, 2),
(34, 18, 14, 2),
(35, 19, 13, 2),
(36, 19, 14, 3),
(37, 20, 15, 2),
(38, 21, 14, 1),
(39, 21, 15, 3),
(40, 22, 13, 1),
(41, 22, 14, 1),
(42, 23, 13, 1),
(43, 23, 15, 1),
(44, 24, 13, 2),
(45, 24, 15, 1),
(46, 24, 14, 3),
(47, 25, 15, 1),
(48, 25, 13, 1),
(49, 26, 13, 2),
(50, 26, 15, 1),
(51, 27, 13, 1),
(52, 27, 15, 2),
(53, 28, 13, 2),
(54, 28, 15, 1),
(55, 28, 14, 3),
(56, 29, 15, 2),
(57, 29, 14, 1),
(58, 32, 13, 2),
(59, 33, 13, 1),
(60, 33, 15, 1),
(61, 33, 14, 2),
(62, 34, 13, 1),
(63, 34, 14, 2),
(64, 35, 13, 1),
(65, 35, 14, 1),
(66, 36, 14, 2),
(67, 37, 13, 2),
(68, 37, 14, 1),
(69, 38, 14, 1),
(70, 39, 13, 1),
(71, 39, 14, 2),
(72, 40, 13, 2),
(73, 40, 14, 2),
(74, 41, 14, 1),
(75, 41, 13, 2),
(76, 42, 14, 2),
(77, 43, 14, 1),
(78, 44, 13, 1),
(79, 44, 14, 2),
(80, 45, 14, 1),
(81, 46, 13, 1),
(82, 47, 13, 2),
(83, 47, 14, 3),
(84, 48, 13, 2),
(85, 48, 14, 1),
(86, 49, 14, 4),
(87, 50, 14, 1),
(88, 51, 13, 1),
(89, 51, 14, 2),
(90, 52, 16, 1),
(91, 53, 13, 1),
(92, 53, 15, 1),
(93, 54, 13, 1),
(94, 54, 15, 1),
(95, 55, 13, 1),
(96, 56, 13, 1),
(97, 56, 14, 2),
(98, 57, 13, 2),
(99, 57, 14, 2),
(100, 58, 14, 2),
(101, 59, 14, 1),
(102, 59, 15, 1),
(103, 60, 14, 1),
(104, 60, 15, 1),
(105, 61, 14, 2),
(106, 61, 15, 2),
(107, 62, 15, 2),
(108, 63, 14, 2),
(109, 64, 13, 2),
(110, 65, 15, 1),
(111, 66, 15, 2),
(112, 66, 14, 2),
(113, 66, 13, 1),
(114, 67, 16, 2),
(115, 67, 14, 1),
(116, 68, 14, 2),
(117, 68, 15, 1),
(118, 69, 15, 1),
(119, 69, 13, 1),
(120, 69, 14, 1),
(121, 70, 14, 2),
(122, 71, 14, 1),
(123, 71, 15, 2),
(124, 72, 14, 1),
(125, 72, 15, 2),
(126, 73, 14, 1),
(127, 73, 15, 2),
(128, 74, 14, 1),
(129, 74, 15, 2),
(130, 75, 15, 1),
(131, 76, 15, 1),
(132, 77, 15, 1),
(133, 78, 15, 1),
(134, 79, 15, 1),
(135, 80, 15, 1),
(136, 81, 15, 1),
(137, 82, 15, 1),
(138, 83, 15, 1),
(139, 84, 15, 1),
(140, 84, 16, 1),
(141, 85, 15, 1),
(142, 85, 16, 1),
(143, 86, 15, 1),
(144, 86, 16, 1),
(145, 87, 15, 1),
(146, 87, 16, 1),
(147, 88, 15, 1),
(148, 88, 16, 1),
(149, 89, 16, 1),
(150, 90, 16, 1),
(151, 91, 14, 2),
(152, 92, 14, 2),
(153, 93, 14, 2),
(154, 94, 14, 2),
(155, 95, 14, 2),
(156, 96, 14, 2),
(157, 97, 14, 1),
(158, 98, 14, 1),
(159, 99, 13, 1),
(160, 100, 13, 1),
(161, 101, 13, 1),
(162, 102, 13, 2),
(163, 103, 13, 1),
(164, 103, 14, 1),
(165, 104, 13, 1),
(166, 104, 14, 1),
(167, 105, 14, 1),
(168, 106, 14, 1),
(169, 107, 14, 1),
(170, 108, 14, 1),
(171, 109, 15, 1),
(172, 110, 15, 1),
(173, 111, 15, 1),
(174, 112, 15, 1),
(175, 113, 15, 1),
(176, 114, 15, 1),
(177, 115, 15, 1),
(178, 116, 15, 1),
(179, 117, 15, 1),
(180, 118, 15, 1),
(181, 119, 15, 1),
(182, 120, 15, 1),
(183, 121, 15, 1),
(184, 122, 15, 1),
(185, 123, 13, 2),
(186, 124, 13, 1),
(187, 125, 13, 1),
(188, 126, 13, 1),
(189, 127, 13, 1),
(190, 128, 13, 1),
(191, 129, 13, 2),
(192, 130, 15, 1),
(193, 130, 14, 1),
(194, 131, 14, 1),
(195, 132, 14, 1),
(196, 133, 15, 1),
(197, 134, 14, 1),
(198, 135, 15, 1),
(199, 136, 13, 1),
(200, 136, 16, 1),
(201, 137, 14, 1),
(202, 138, 14, 1),
(203, 139, 15, 2),
(204, 139, 14, 1),
(205, 139, 13, 1),
(206, 140, 13, 2),
(207, 140, 15, 1),
(208, 141, 15, 2),
(209, 142, 14, 2),
(210, 143, 13, 1),
(211, 143, 14, 1),
(212, 144, 14, 2),
(213, 144, 13, 1),
(214, 145, 13, 2),
(215, 145, 15, 1),
(216, 146, 13, 1),
(217, 146, 15, 1),
(218, 147, 15, 1),
(219, 148, 14, 1),
(220, 148, 13, 1),
(221, 149, 13, 1),
(222, 149, 15, 1),
(223, 150, 14, 1),
(224, 150, 15, 1),
(225, 151, 13, 1),
(226, 152, 13, 1),
(227, 153, 14, 1),
(228, 154, 17, 1),
(229, 154, 19, 2),
(230, 154, 20, 2),
(231, 155, 14, 1),
(232, 156, 21, 1),
(233, 157, 13, 1),
(234, 157, 16, 2),
(235, 158, 14, 2),
(236, 159, 14, 1),
(237, 159, 19, 2),
(238, 160, 18, 2),
(239, 161, 20, 1),
(240, 162, 14, 1),
(241, 162, 18, 2),
(242, 163, 18, 2),
(243, 164, 18, 3),
(244, 165, 20, 2),
(245, 165, 15, 1),
(246, 166, 13, 2),
(247, 166, 15, 1),
(248, 167, 13, 1),
(249, 168, 13, 1),
(250, 168, 15, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `barcode` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `barcode`, `quantity`, `photo`, `category`) VALUES
(13, 'Test 1', '120.00', '101', 93, ':3000/uploads/photo-1701337080245.jpg', 'Smart Watches'),
(14, 'Test 2', '250.00', '102', 193, ':3000/uploads/photo-1701342900766.jpg', 'Smart Watches'),
(15, 'Test 3', '360.00', '103', 146, ':3000/uploads/photo-1705816919696.jpg', 'Shampoo'),
(16, 'Test 4', '400.00', '104', 98, ':3000/uploads/photo-1707121335251.jpg', 'Soap'),
(17, 'Test 5', '150.00', '105', 99, ':3000/uploads/photo-1710748721214.jpg', 'Mobile Phones'),
(18, 'Test 6', '250.00', '106', 91, ':3000/uploads/photo-1710748765479.jpg', 'Mobile Phones'),
(19, 'Test 7', '350.00', '107', 96, ':3000/uploads/photo-1710748818070.jpg', 'Tablets'),
(20, 'Test 8', '450.00', '108', 95, ':3000/uploads/photo-1710748848625.jpg', 'Tablets'),
(21, 'Test 9', '100.00', '109', 99, ':3000/uploads/photo-1710748914767.jpg', 'Shampoo'),
(22, 'Test 10', '100.00', '110', 100, ':3000/uploads/photo-1710748943703.jpg', 'Soap');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `barcode` (`barcode`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=169;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=251;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
