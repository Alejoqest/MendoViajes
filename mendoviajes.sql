-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-10-2023 a las 14:10:07
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mendoviajes`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viajes ida`
--

CREATE TABLE `viajes ida` (
  `numVuelo` bigint(8) NOT NULL,
  `destino` enum('miami','nueva-york','fort-lauderdale','los-angeles','orlando','montreal','toronto','vancouver','mexico','buenos-aires','madrid','barcelona','londres','frankfurt','berlin','paris','roma','milan','tokio','shanghai') DEFAULT NULL,
  `clase` enum('economica','premium','ejecutiva','primera') NOT NULL,
  `equipaje` enum('sin equipaje','permitido') NOT NULL,
  `fechaVuelo` date DEFAULT NULL,
  `horaVuelo` time NOT NULL,
  `duracionVuelo` time NOT NULL,
  `precioPer` double(255,5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `viajes ida`
--

INSERT INTO `viajes ida` (`numVuelo`, `destino`, `clase`, `equipaje`, `fechaVuelo`, `horaVuelo`, `duracionVuelo`, `precioPer`) VALUES
(100, 'montreal', 'economica', 'permitido', '2023-11-03', '14:30:00', '15:25:00', 919900.00000),
(124, 'buenos-aires', 'economica', 'sin equipaje', '2023-11-01', '13:30:00', '01:40:00', 35300.00000),
(139, 'buenos-aires', 'economica', 'sin equipaje', '2023-11-01', '17:35:00', '02:00:00', 38580.00000),
(230, 'buenos-aires', 'economica', 'permitido', '2023-10-31', '16:20:00', '02:00:00', 25400.00000),
(243, 'buenos-aires', 'economica', 'permitido', '2023-11-01', '10:30:00', '02:30:00', 28600.00000),
(267, 'buenos-aires', 'economica', 'permitido', '2023-11-01', '14:30:00', '01:30:00', 43150.00000),
(341, 'miami', 'economica', 'permitido', '2023-11-01', '08:45:00', '12:00:00', 338400.00000),
(344, 'miami', 'economica', 'sin equipaje', '2023-11-01', '10:30:00', '11:15:00', 337500.00000),
(348, 'miami', 'economica', 'sin equipaje', '2023-11-01', '14:25:00', '11:25:00', 326300.00000),
(349, 'miami', 'economica', 'sin equipaje', '2023-11-01', '16:30:00', '10:45:00', 336400.00000),
(405, 'buenos-aires', 'economica', 'permitido', '2023-11-01', '12:15:00', '02:20:00', 25500.00000),
(453, 'miami', 'economica', 'permitido', '2023-11-01', '12:30:00', '10:45:00', 337250.00000),
(459, 'miami', 'economica', 'permitido', '2023-11-01', '09:25:00', '11:35:00', 339500.00000),
(574, 'miami', 'economica', 'permitido', '2023-11-01', '09:00:30', '10:30:00', 349500.00000),
(647, 'miami', 'economica', 'sin equipaje', '2023-11-01', '15:25:00', '11:25:00', 329500.00000),
(840, 'miami', 'economica', 'sin equipaje', '2023-11-01', '04:00:30', '10:30:00', 339922.00000),
(7540, 'nueva-york', 'economica', 'sin equipaje', '2023-11-01', '12:40:00', '18:30:00', 629090.00000);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `viajes ida`
--
ALTER TABLE `viajes ida`
  ADD PRIMARY KEY (`numVuelo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
