-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 29, 2021 at 11:13 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `trellodb`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `workspace_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `user_id`, `workspace_id`) VALUES
(78, 15, 69),
(79, 15, 70),
(80, 16, 70),
(81, 15, 71),
(96, 20, 83);

-- --------------------------------------------------------

--
-- Table structure for table `card`
--

CREATE TABLE `card` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `color` varchar(10) DEFAULT '#c8ff03',
  `user_id` int(11) DEFAULT NULL,
  `cardlist_id` int(11) DEFAULT NULL,
  `isdone` tinyint(1) DEFAULT 0,
  `duedate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `card`
--

INSERT INTO `card` (`id`, `title`, `description`, `color`, `user_id`, `cardlist_id`, `isdone`, `duedate`) VALUES
(132, 'Libra', 'Law and Order', '#8600FF', NULL, 71, 0, '2021-04-30 04:00:00'),
(133, 'Ursa Major', 'Great Bear in the sky', '#3F2613', NULL, 71, 0, '2021-04-30 04:00:00'),
(134, 'Telescope', 'Big metal tube with glass', '#308CE9', NULL, 72, 1, NULL),
(135, 'Tent', NULL, '#f0ad4e', NULL, 72, 0, '2021-04-22 04:00:00'),
(136, 'Sleeping Bags', NULL, '#0275D8', NULL, 72, 0, NULL),
(137, 'Design Document', 'Create initial design document', '#E34DB8', NULL, 73, 0, '2021-05-01 04:00:00'),
(138, 'Mission Statement', 'Decide mission statement', '#EB00C9', NULL, 73, 0, '2021-04-30 04:00:00'),
(139, 'Workbench ERD', 'Create the ERD in SQL Workbench', '#FF0000', 17, 75, 0, '2021-04-30 04:00:00'),
(140, 'Business Rules', 'Decide business rules for the database', '#00FF79', 15, 75, 0, '2021-04-14 04:00:00'),
(141, 'Normalization', 'Normalize the database', '#0079FF', 15, 75, 0, '2021-05-08 04:00:00'),
(171, 'card 1', NULL, '#3D8C3D', NULL, 84, 0, '2021-04-30 04:00:00'),
(173, 'Meet and Greet', NULL, '#d9534f', NULL, NULL, 0, NULL),
(174, 'Meet and Greet', 'Get to know the team!', '#5CB85C', 15, 87, 1, '2021-04-27 04:00:00'),
(176, 'securities', NULL, '#d9534f', NULL, 71, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cardlist`
--

CREATE TABLE `cardlist` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `workspace_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cardlist`
--

INSERT INTO `cardlist` (`id`, `name`, `workspace_id`) VALUES
(71, 'Constellations', 70),
(72, 'Equipment', 70),
(73, 'P1 - Project Proposal', 71),
(75, 'P2 - Inital ERD', 71),
(84, 'list 1', 69),
(87, 'Miscellaneous', 71);

-- --------------------------------------------------------

--
-- Table structure for table `invite`
--

CREATE TABLE `invite` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `workspace_id` int(11) NOT NULL,
  `status` varchar(100) NOT NULL,
  `isadmininvite` tinyint(1) NOT NULL DEFAULT 0,
  `recipient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `invite`
--

INSERT INTO `invite` (`id`, `sender_id`, `workspace_id`, `status`, `isadmininvite`, `recipient_id`) VALUES
(24, 15, 70, 'ACCEPTED', 1, 16),
(25, 15, 71, 'ACCEPTED', 0, 17),
(26, 15, 71, 'REJECTED', 1, 16),
(27, 15, 71, 'ACCEPTED', 0, 17),
(28, 15, 78, 'ACCEPTED', 1, 15),
(29, 15, 79, 'ACCEPTED', 1, 17),
(30, 15, 71, 'ACCEPTED', 1, 16),
(31, 15, 71, 'ACCEPTED', 0, 16);

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `workspace_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

CREATE TABLE `task` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `isdone` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `name`) VALUES
(15, 'a', 'a', 'Pranav'),
(16, 'q', 'q', 'Aditya'),
(17, 'w', 'w', 'Robin'),
(18, '', '', ''),
(19, 'saf', '12345678', 'dasf'),
(20, 'asfa', 'asfasfasfa', 'fadsf'),
(21, 'v', 'asdfasfass', 'fsaf');

-- --------------------------------------------------------

--
-- Table structure for table `workspace`
--

CREATE TABLE `workspace` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `bg_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `workspace`
--

INSERT INTO `workspace` (`id`, `name`, `description`, `bg_id`) VALUES
(69, 'Summer Plans', 'Workspace to keep track of summer goals and tasks', 7),
(70, 'Astronomy', 'Workspace to keep track of stargazing', 5),
(71, 'Database Design Group 14', 'Group to discuss and manage the final project for INFO6210', 6),
(78, 'fasdf', '', 1),
(79, 'a', 'a', 2),
(83, 'securities', 'fasf', 2),
(86, 'a', '', 9),
(89, 'daf', '', 2);

-- --------------------------------------------------------

--
-- Table structure for table `workspacebg`
--

CREATE TABLE `workspacebg` (
  `id` int(11) NOT NULL,
  `filename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `workspacebg`
--

INSERT INTO `workspacebg` (`id`, `filename`) VALUES
(1, 'blur.jpg'),
(2, 'lights.jpg'),
(3, 'marble-2.jpg'),
(5, 'stars.jpg'),
(6, 'street.jpg'),
(7, 'wood.jpg'),
(8, 'desk.jpg'),
(9, 'mauve.jpg'),
(10, 'wall.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_fk` (`workspace_id`);

--
-- Indexes for table `card`
--
ALTER TABLE `card`
  ADD PRIMARY KEY (`id`),
  ADD KEY `card_fk` (`cardlist_id`);

--
-- Indexes for table `cardlist`
--
ALTER TABLE `cardlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cardlist_fk` (`workspace_id`);

--
-- Indexes for table `invite`
--
ALTER TABLE `invite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invite_fk` (`workspace_id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_fk` (`workspace_id`);

--
-- Indexes for table `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `workspace`
--
ALTER TABLE `workspace`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `workspacebg`
--
ALTER TABLE `workspacebg`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `card`
--
ALTER TABLE `card`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT for table `cardlist`
--
ALTER TABLE `cardlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `invite`
--
ALTER TABLE `invite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `task`
--
ALTER TABLE `task`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `workspace`
--
ALTER TABLE `workspace`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `workspacebg`
--
ALTER TABLE `workspacebg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_fk` FOREIGN KEY (`workspace_id`) REFERENCES `workspace` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `card`
--
ALTER TABLE `card`
  ADD CONSTRAINT `card_fk` FOREIGN KEY (`cardlist_id`) REFERENCES `cardlist` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cardlist`
--
ALTER TABLE `cardlist`
  ADD CONSTRAINT `cardlist_fk` FOREIGN KEY (`workspace_id`) REFERENCES `workspace` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `invite`
--
ALTER TABLE `invite`
  ADD CONSTRAINT `invite_fk` FOREIGN KEY (`workspace_id`) REFERENCES `workspace` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `member`
--
ALTER TABLE `member`
  ADD CONSTRAINT `member_fk` FOREIGN KEY (`workspace_id`) REFERENCES `workspace` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
