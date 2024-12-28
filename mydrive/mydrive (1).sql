-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 06, 2024 at 05:27 PM
-- Server version: 11.5.2-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mydrive`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add folder', 7, 'add_folder'),
(26, 'Can change folder', 7, 'change_folder'),
(27, 'Can delete folder', 7, 'delete_folder'),
(28, 'Can view folder', 7, 'view_folder'),
(29, 'Can add uploaded file', 8, 'add_uploadedfile'),
(30, 'Can change uploaded file', 8, 'change_uploadedfile'),
(31, 'Can delete uploaded file', 8, 'delete_uploadedfile'),
(32, 'Can view uploaded file', 8, 'view_uploadedfile'),
(33, 'Can add profile', 9, 'add_profile'),
(34, 'Can change profile', 9, 'change_profile'),
(35, 'Can delete profile', 9, 'delete_profile'),
(36, 'Can view profile', 9, 'view_profile');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$870000$uxNgX0wgcPw7Pb3dtC7jU8$Pi/9cVATgMM89bKluMOWcQpu2AEAVZ8lVb+iTbIFqvo=', '2024-11-06 09:46:17.484402', 0, 'dieudonne', 'Dieudnne', 'Tsongo', '', 0, 1, '2024-10-30 21:18:00.929474'),
(3, 'pbkdf2_sha256$870000$coGKm4mer0PyXFcU9Mc1LA$B0KsRM/8gSTxeLNTqC3DmIFXKITzSGu0HRxQ5ciMISY=', '2024-11-04 14:49:00.405095', 1, '112721', '', '', 'kathembo.dieudonne@strathmore.edu', 1, 1, '2024-11-04 14:47:32.941670'),
(4, 'pbkdf2_sha256$870000$dlO309c3PEliA4AHbsxv60$xWhLT39we4V2yW0SuzKTAdIJsGi/ycYFkIHUwAIvQ54=', '2024-11-06 08:27:02.537783', 0, 'Marlene', 'Marlene', 'Camille', '', 0, 1, '2024-11-05 17:52:11.001101'),
(5, 'pbkdf2_sha256$870000$IvjaMR5xRr5ajXFREnKuMm$5xqlMAiltZHU9MI7/KwZRs1sh/FW2WC53W7TUWvJu9Y=', '2024-11-05 20:23:15.434003', 0, 'Malene', 'Marlen', 'Cmille', 'malene@gmail.com', 0, 1, '2024-11-05 20:22:51.127561'),
(6, 'pbkdf2_sha256$870000$qb0Um3Don8PRZNgvL3mVjm$tGSBaqJoXjVoWolK5wppyQ6okHf3zDJEqzmHX7lSxOE=', '2024-11-06 08:21:10.929659', 0, 'sashy', 'Sarah', 'Mongare', 'sarah.chebet@gmail.com', 0, 1, '2024-11-06 08:20:51.432340'),
(8, 'pbkdf2_sha256$870000$0zmvyFUpE8AjKlV8MThUOo$CeDvu8+C8/5yUXj/tSiibGZxxN9T7tDBk9fIn1NpfMM=', '2024-11-06 09:16:16.119650', 0, 'Sarah', 'Sarah', 'Mongare', '', 0, 1, '2024-11-06 08:48:45.987640'),
(9, 'pbkdf2_sha256$870000$A7a1T6tnQktjfmphdAU2vJ$DV9lqkkrkDSRzOdZGvmL6RkJdyoCXP/Mhd9ovl8H1aE=', '2024-11-06 09:01:28.494647', 0, 'nini', 'mevah', 'atiana', '', 0, 1, '2024-11-06 09:01:21.659128');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'mydrive', 'folder'),
(9, 'mydrive', 'profile'),
(8, 'mydrive', 'uploadedfile'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-10-30 21:17:22.821384'),
(2, 'auth', '0001_initial', '2024-10-30 21:17:23.133103'),
(3, 'admin', '0001_initial', '2024-10-30 21:17:23.187872'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-10-30 21:17:23.193077'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-10-30 21:17:23.212516'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-10-30 21:17:23.263025'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-10-30 21:17:23.296018'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-10-30 21:17:23.318218'),
(9, 'auth', '0004_alter_user_username_opts', '2024-10-30 21:17:23.327886'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-10-30 21:17:23.359046'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-10-30 21:17:23.362499'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-10-30 21:17:23.372590'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-10-30 21:17:23.395362'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-10-30 21:17:23.411900'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-10-30 21:17:23.439756'),
(16, 'auth', '0011_update_proxy_permissions', '2024-10-30 21:17:23.444855'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-10-30 21:17:23.472545'),
(18, 'mydrive', '0001_initial', '2024-10-30 21:17:23.575047'),
(19, 'sessions', '0001_initial', '2024-10-30 21:17:23.604199'),
(20, 'mydrive', '0002_alter_folder_unique_together', '2024-11-03 07:00:32.887553'),
(21, 'mydrive', '0003_alter_folder_unique_together_alter_folder_owner_and_more', '2024-11-03 20:56:20.992667'),
(22, 'mydrive', '0004_remove_folder_parent_folder_profile', '2024-11-05 13:30:25.981817'),
(23, 'mydrive', '0005_alter_profile_user_alter_profile_table', '2024-11-05 20:10:21.068090');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('i46js7b666ws9kof8ljvwi0hd008v5wq', '.eJxVjMsOwiAQRf-FtSG0F0Jx6d5vIAMzSNW0SR8r478rSRe6Pefc-1KR9q3GfZUljqzOqlOnX5YoP2Rqgu803Wad52lbxqRbog-76uvM8rwc7d9BpbW2NUwPgjXBogOcdZnKgM6k3ngJNDCKFwlcBB6J_WC5FGTYL4DL6v0Bw-M30A:1t8ccD:phlUq7gUMhpa5nWglsQSFarAOcyQp2nCBINFEVO_K_k', '2024-11-20 09:46:17.484402'),
('ycrncptl1jwfbraxcctsubessz8hcok1', '.eJxVjMsOwiAQRf-FtSG0F0Jx6d5vIAMzSNW0SR8r478rSRe6Pefc-1KR9q3GfZUljqzOqlOnX5YoP2Rqgu803Wad52lbxqRbog-76uvM8rwc7d9BpbW2NUwPgjXBogOcdZnKgM6k3ngJNDCKFwlcBB6J_WC5FGTYL4DL6v0Bw-M30A:1t8cNC:bwO1cDlnalggyxX6CQfNj6P0_Cq5LFL0fs3v6e4Bs-Y', '2024-11-20 09:30:46.830558');

-- --------------------------------------------------------

--
-- Table structure for table `mydrive_folder`
--

CREATE TABLE `mydrive_folder` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `owner_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mydrive_folder`
--

INSERT INTO `mydrive_folder` (`id`, `name`, `created_at`, `owner_id`) VALUES
(1, 'Kathembo Folder 1', '2024-11-03 19:48:48.694791', 1),
(5, 'Tsongo', '2024-11-03 21:02:16.730325', 1),
(6, 'Dido', '2024-11-03 21:20:27.663813', 1),
(8, 'Marlene', '2024-11-05 17:53:10.609972', 4),
(11, 'school', '2024-11-06 08:21:57.549293', 6),
(12, 'school', '2024-11-06 08:54:54.065582', 8);

-- --------------------------------------------------------

--
-- Table structure for table `mydrive_profile`
--

CREATE TABLE `mydrive_profile` (
  `id` bigint(20) NOT NULL,
  `profile_picture` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mydrive_profile`
--

INSERT INTO `mydrive_profile` (`id`, `profile_picture`, `user_id`) VALUES
(1, 'profile_pics/default_image_9QoBH4Q.jpg', 1),
(2, 'profile_pics/photo_Dieudonne_bw6Z32F.jpg', 4),
(3, 'profile_pics/sarah.jpg', 8),
(4, 'profile_pics/Screenshot_2024-09-25_143806.png', 9);

-- --------------------------------------------------------

--
-- Table structure for table `mydrive_uploadedfile`
--

CREATE TABLE `mydrive_uploadedfile` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `last_modified` datetime(6) NOT NULL,
  `file_size` int(10) UNSIGNED DEFAULT NULL CHECK (`file_size` >= 0),
  `original_location` varchar(255) DEFAULT NULL,
  `file` varchar(100) NOT NULL,
  `owner_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mydrive_uploadedfile`
--

INSERT INTO `mydrive_uploadedfile` (`id`, `name`, `last_modified`, `file_size`, `original_location`, `file`, `owner_id`) VALUES
(142, 'Billet Madrid-Paris.PDF', '2024-11-06 09:57:34.549118', 72049, 'uploads/Billet_Madrid-Paris.PDF', 'uploads/Billet_Madrid-Paris.PDF', 1),
(143, 'Paris-Athene.pdf', '2024-11-05 18:44:57.538833', 380121, 'Paris-Athene.pdf', 'uploads/Paris-Athene.pdf', 1),
(144, 'Paris-Athene.pdf', '2024-11-05 18:45:47.451138', 380121, 'Paris-Athene.pdf', 'uploads/Paris-Athene_LHr6tiz.pdf', 1),
(145, 'Billet Madrid-Paris.PDF', '2024-11-05 21:34:33.665694', 72049, 'uploads/Billet_Madrid-Paris_3fnUTup.PDF', 'uploads/Billet_Madrid-Paris_3fnUTup.PDF', 1),
(147, 'Paris-Athene.pdf', '2024-11-05 20:23:28.222279', 380121, 'Paris-Athene.pdf', 'uploads/Paris-Athene_aCIZIwK.pdf', 5),
(150, 'Copy of Confitemini Domino.mp4', '2024-11-05 22:20:45.186367', 10441205, 'uploads/Confitemini_Domino_34kt1Op.mp4', 'uploads/Confitemini_Domino_34kt1Op.mp4', 1),
(151, 'Copy of Confitemini Domino.mp4', '2024-11-06 07:42:45.807871', 10441205, 'uploads/Confitemini_Domino_34kt1Op.mp4', 'uploads/Confitemini_Domino_34kt1Op.mp4', 1),
(152, 'Copy of Class Diagrams.drawio.png', '2024-11-06 07:17:56.232241', 370473, 'uploads/Class_Diagrams_ywlOJYP.drawio.png', 'uploads/Class_Diagrams_ywlOJYP.drawio.png', 1),
(153, 'Billet Madrid-Paris.PDF', '2024-11-06 07:54:22.134487', 72049, 'Billet Madrid-Paris.PDF', 'uploads/Billet_Madrid-Paris_2WYBBTw.PDF', 4),
(154, 'Confitemini Domino.mp4', '2024-11-06 07:59:09.389001', 10441205, 'Confitemini Domino.mp4', 'uploads/Confitemini_Domino_jlAX0Wl.mp4', 1),
(155, 'Class_Diagrams.drawio', '2024-11-06 07:59:19.576822', 70700, 'Class_Diagrams.drawio', 'uploads/Class_Diagrams.drawio', 1),
(156, 'default_image.jpg', '2024-11-06 07:59:31.474499', 109882, 'default_image.jpg', 'uploads/default_image.jpg', 1),
(157, 'photo_Dieudonne.jpg', '2024-11-06 07:59:41.140590', 61354, 'photo_Dieudonne.jpg', 'uploads/photo_Dieudonne.jpg', 1),
(158, 'Class Diagrams.drawio.png', '2024-11-06 08:22:28.893650', 370473, 'uploads/Class_Diagrams_Yb7L1cJ.drawio.png', 'uploads/Class_Diagrams_Yb7L1cJ.drawio.png', 6),
(159, 'Confitemini Domino.mp4', '2024-11-06 08:49:17.357294', 10441205, 'Confitemini Domino.mp4', 'uploads/Confitemini_Domino_vnG2CPe.mp4', 8),
(160, 'AEGEAN_AIRLINES_SA_E_ticket_Confirmation.pdf', '2024-11-06 08:55:07.990497', 380121, 'AEGEAN_AIRLINES_SA_E_ticket_Confirmation.pdf', 'uploads/AEGEAN_AIRLINES_SA_E_ticket_Confirmation.pdf', 8),
(161, 'sarah.jpg', '2024-11-06 08:55:42.236582', 145413, 'sarah.jpg', 'uploads/sarah.jpg', 8),
(162, 'Class Diagrams.drawio.png', '2024-11-06 08:55:52.153428', 370473, 'Class Diagrams.drawio.png', 'uploads/Class_Diagrams_vXwOqEj.drawio.png', 8),
(163, 'BookingReceipt_Q7OZM6.pdf', '2024-11-06 08:56:45.002278', 461887, 'BookingReceipt_Q7OZM6.pdf', 'uploads/BookingReceipt_Q7OZM6.pdf', 8),
(164, 'CheckList for Train in Belgium.docx', '2024-11-06 08:56:55.172966', 538453, 'CheckList for Train in Belgium.docx', 'uploads/CheckList_for_Train_in_Belgium.docx', 8),
(165, 'ET_DIEUDONNE_KATHEMBOTSONGO (1).PDF', '2024-11-06 08:57:05.296499', 72049, 'ET_DIEUDONNE_KATHEMBOTSONGO (1).PDF', 'uploads/ET_DIEUDONNE_KATHEMBOTSONGO_1.PDF', 8),
(166, 'Screenshot 2024-09-19 214414.png', '2024-11-06 09:06:10.149507', 147127, 'Screenshot 2024-09-19 214414.png', 'uploads/Screenshot_2024-09-19_214414.png', 9),
(167, 'Screenshot 2024-09-19 214414.png', '2024-11-06 09:46:30.778618', 147127, 'Screenshot 2024-09-19 214414.png', 'uploads/Screenshot_2024-09-19_214414_cOsgTxj.png', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `mydrive_folder`
--
ALTER TABLE `mydrive_folder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mydrive_folder_owner_id_bc267e67` (`owner_id`);

--
-- Indexes for table `mydrive_profile`
--
ALTER TABLE `mydrive_profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `mydrive_uploadedfile`
--
ALTER TABLE `mydrive_uploadedfile`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mydrive_uploadedfile_owner_id_bb2fc1c3_fk_auth_user_id` (`owner_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `mydrive_folder`
--
ALTER TABLE `mydrive_folder`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `mydrive_profile`
--
ALTER TABLE `mydrive_profile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `mydrive_uploadedfile`
--
ALTER TABLE `mydrive_uploadedfile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `mydrive_folder`
--
ALTER TABLE `mydrive_folder`
  ADD CONSTRAINT `mydrive_folder_owner_id_bc267e67_fk_auth_user_id` FOREIGN KEY (`owner_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `mydrive_profile`
--
ALTER TABLE `mydrive_profile`
  ADD CONSTRAINT `mydrive_profile_user_id_32855610_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `mydrive_uploadedfile`
--
ALTER TABLE `mydrive_uploadedfile`
  ADD CONSTRAINT `mydrive_uploadedfile_owner_id_bb2fc1c3_fk_auth_user_id` FOREIGN KEY (`owner_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
