-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 18, 2021 at 11:01 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blog_flask`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `ph_num` bigint(20) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `ph_num`, `msg`, `date`) VALUES
(1, 'VJ', 'vj@gmail.com', 78894, 'i like this blog site', '0000-00-00 00:00:00'),
(2, 'vaishu', 'vaishnavij2000@gmail.com', 9876543210, 'hi', '2021-02-03 20:22:39'),
(3, 'Ram', 'ram@gmail.com', 8788092797, 'hello, I am ram, i need help', '2021-02-03 20:24:01'),
(4, 'asdf', 'a@b.com', 9876543210, 'hello i am new', '2021-02-04 20:19:27'),
(5, 'harry', 'harry@try.com', 8788092797, 'hello i m harry', '2021-02-04 20:44:29'),
(6, 'vaishu', 'harry@gmail.com', 9876543210, 'hello i am mail user', '2021-02-04 22:01:11'),
(7, 'vaishu', 'harry@gmail.com', 9876543210, 'hello i am mail user', '2021-02-04 22:01:58'),
(8, 'Ram', 'ram@gmail.com', 9876543210, 'hi i m new mail', '2021-02-04 22:06:48'),
(9, 'Ram', 'ram@gmail.com', 9876543210, 'hi i m new mail', '2021-02-04 22:06:48'),
(10, 'Ram', 'ram@gmail.com', 9876543210, 'hi i m new mail', '2021-02-04 22:13:45'),
(11, 'sofia', 'a@b.com', 9876543210, 'this is test mail', '2021-02-04 22:16:44'),
(12, 'das', 'rohas@gmail.com', 0, 'thamk you for contacting', '2021-02-04 22:21:29');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `post_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(12) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`post_id`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'First post', 'This is my first post\'s title', 'first-post', 'ok This is my first post and i am very excited for this blog site made in python flask', 'about-bg.jpg', '2021-02-04 22:29:32'),
(2, 'Django (web framework)', 'An awesome python framework for web development', 'django-python', 'Django\'s primary goal is to ease the creation of complex, database-driven websites. The framework emphasizes reusability and \"pluggability\" of components, less code, low coupling, rapid development, and the principle of don\'t repeat yourself.[11] Python is used throughout, even for settings, files, and data models. Django also provides an optional administrative create, read, update and delete interface that is generated dynamically through introspection and configured via admin models. ', 'home-bg.jpg', '2021-02-04 22:49:31'),
(3, 'flask', 'python flask', 'flask-python', 'idk web frame work', 'home-bg.jpg', '2021-02-11 20:47:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
