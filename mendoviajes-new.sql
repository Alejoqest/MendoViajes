-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-11-2023 a las 17:18:32
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
-- Estructura de tabla para la tabla `reservasvuelosida`
--

CREATE TABLE `reservasvuelosida` (
  `id` int(255) NOT NULL,
  `userId` int(255) NOT NULL,
  `vueloId` int(255) NOT NULL,
  `numAdultos` int(10) NOT NULL,
  `numMenores` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservasvuelosida`
--

INSERT INTO `reservasvuelosida` (`id`, `userId`, `vueloId`, `numAdultos`, `numMenores`) VALUES
(1, 1, 11, 1, 0),
(4, 2, 11, 1, 1),
(5, 2, 2, 1, 1),
(6, 2, 5, 1, 0),
(7, 2, 3, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservasvuelosvuelta`
--

CREATE TABLE `reservasvuelosvuelta` (
  `id` int(255) NOT NULL,
  `userId` int(255) NOT NULL,
  `vueloIdaId` int(255) NOT NULL,
  `vueloVueltaId` int(255) NOT NULL,
  `numAdultos` int(10) NOT NULL,
  `numMenores` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservasvuelosvuelta`
--

INSERT INTO `reservasvuelosvuelta` (`id`, `userId`, `vueloIdaId`, `vueloVueltaId`, `numAdultos`, `numMenores`) VALUES
(1, 2, 11, 1, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion`
--

CREATE TABLE `ubicacion` (
  `id` int(255) NOT NULL,
  `cuidad` varchar(255) NOT NULL,
  `region` varchar(255) NOT NULL,
  `pais` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ubicacion`
--

INSERT INTO `ubicacion` (`id`, `cuidad`, `region`, `pais`) VALUES
(1, 'Miami', 'Florida', 'Estados Unidos'),
(2, 'Nueva York', 'Nueva York', 'Estados Unidos'),
(3, 'Fort Lauderdale', 'Florida', 'Estados Unidos'),
(4, 'Los Ángeles', 'California', 'Estados Unidos'),
(5, 'Orlando', 'Florida', 'Estados Unidos'),
(6, 'Montreal', 'Quebec', 'Canadá'),
(7, 'Toronto', 'Ontario', 'Canadá'),
(8, 'Vancouver', 'Columbia Británica', 'Canadá'),
(9, 'Cuidad de México', 'México D.F.', 'México'),
(10, 'Buenos Aires', 'Cuidad de Buenos Aires', 'Argentina'),
(11, 'Madrid', 'Comunidad de Madrid', 'España'),
(12, 'Barcelona', 'Cataluña', 'España'),
(13, 'Londres', 'Inglaterra', 'Reino Unido'),
(14, 'Frankfurt', 'Hessen', 'Alemania'),
(15, 'Berlín', 'Berlín', 'Alemania'),
(16, 'París', 'lle de France', 'Francia'),
(17, 'Roma', 'Lazio', 'Italia'),
(18, 'Milán', 'Lombardia', 'Italia'),
(19, 'Tokio', 'Tokyo-to', 'Japón'),
(20, 'Shanghai', 'Shanghai Shi', 'República Popular China');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `userprueba`
--

CREATE TABLE `userprueba` (
  `usuario` varchar(255) NOT NULL,
  `contrasena` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `userprueba`
--

INSERT INTO `userprueba` (`usuario`, `contrasena`) VALUES
('1234user', '$2y$10$d60bQsjdfWDoy/XPW5dUEuxQrXh4OCNyMNp3X5lH9lxgXJSfCbKs.'),
('Alejo', '10'),
('Leo', '$2y$10$RwMknWy45/zweY37HercAe5eHkL7G1kvp7AIKl7LiWsLB31eoSJoe'),
('Luis', '$2y$10$pcAyllLOrEhtSByh6M38zemH5/naGbMHboFPQY8lae3Eud5DiyTS6'),
('Marcri', '$2y$10$i.Q3YtxgfpttcZ4UsNfms.RosR5J8LafAO1MOAdbwdrlimF/fKZhy');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `type` enum('usuario','administrador') NOT NULL DEFAULT 'usuario',
  `regdate` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `username`, `password`, `email`, `type`, `regdate`) VALUES
(1, 'Alejo', 'alejo', 'alejoquevedo@gmail.com', 'usuario', '2023-11-15 23:44:14'),
(2, 'Manuel', '$2y$10$G2AxZmYi41ORVp/sZ91lzOfuRmM5/enyBwz1q.CFFndzY4Vap.b/W', 'Manuel@gmail.com', 'usuario', '2023-11-18 16:24:35');

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viajesida`
--

CREATE TABLE `viajesida` (
  `id` int(255) NOT NULL,
  `numVuelo` int(255) NOT NULL,
  `destino` int(255) NOT NULL,
  `clase` enum('economica','premium','ejecutiva','primera') NOT NULL,
  `equipaje` enum('no permitido','permitido') NOT NULL,
  `fechaVuelo` date NOT NULL,
  `horaVuelo` time NOT NULL,
  `duracionVuelo` time NOT NULL,
  `precioPer` double(255,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `viajesida`
--

INSERT INTO `viajesida` (`id`, `numVuelo`, `destino`, `clase`, `equipaje`, `fechaVuelo`, `horaVuelo`, `duracionVuelo`, `precioPer`) VALUES
(1, 100, 6, 'economica', 'permitido', '2023-11-03', '14:30:00', '15:25:00', 919900.00),
(2, 124, 10, 'economica', 'no permitido', '2023-11-01', '13:30:00', '01:40:00', 35300.00),
(3, 139, 10, 'economica', 'no permitido', '2023-11-01', '17:35:00', '02:00:00', 38580.00),
(4, 230, 10, 'economica', 'permitido', '2023-10-31', '16:20:00', '02:00:00', 25400.00),
(5, 243, 10, 'economica', 'permitido', '2023-11-01', '10:30:00', '02:30:00', 28600.00),
(6, 267, 10, 'economica', 'permitido', '2023-11-01', '14:30:00', '01:30:00', 43150.00),
(7, 341, 1, 'economica', 'permitido', '2023-11-01', '08:45:00', '12:00:00', 338400.00),
(8, 344, 1, 'economica', 'no permitido', '2023-11-01', '10:30:00', '11:15:00', 337500.00),
(9, 348, 1, 'economica', 'no permitido', '2023-11-01', '14:25:00', '11:25:00', 326300.00),
(10, 349, 1, 'economica', 'no permitido', '2023-11-01', '16:30:00', '10:45:00', 336400.00),
(11, 405, 10, 'economica', 'permitido', '2023-11-01', '12:15:00', '02:20:00', 25500.00),
(12, 453, 1, 'economica', 'permitido', '2023-11-01', '12:30:00', '10:45:00', 337250.00),
(13, 459, 1, 'economica', 'permitido', '2023-11-01', '09:25:00', '11:35:00', 339500.00),
(14, 574, 1, 'economica', 'permitido', '2023-11-01', '09:00:30', '10:30:00', 349500.00),
(15, 647, 1, 'economica', 'no permitido', '2023-11-01', '15:25:00', '11:25:00', 329500.00),
(16, 840, 1, 'economica', 'no permitido', '2023-11-01', '04:00:30', '10:30:00', 339922.00),
(17, 7540, 2, 'economica', 'no permitido', '2023-11-01', '12:40:00', '18:30:00', 629090.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vuelosidayvuelta`
--

CREATE TABLE `vuelosidayvuelta` (
  `id` int(255) NOT NULL,
  `viajeIdaId` int(255) NOT NULL,
  `viajeVueltaId` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vuelosidayvuelta`
--

INSERT INTO `vuelosidayvuelta` (`id`, `viajeIdaId`, `viajeVueltaId`) VALUES
(1, 2, 1),
(2, 3, 1),
(3, 2, 1),
(4, 4, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vuelosvuelta`
--

CREATE TABLE `vuelosvuelta` (
  `id` int(255) NOT NULL,
  `ubicacion` int(255) NOT NULL,
  `numVuelta` int(255) NOT NULL,
  `clase` enum('economica','premium','ejecutiva','primera') NOT NULL,
  `equipaje` enum('no permitido','permitido') NOT NULL,
  `fechaVuelta` date NOT NULL,
  `horaVuelta` time NOT NULL,
  `duracionVuelta` time NOT NULL,
  `precioPer` double(255,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vuelosvuelta`
--

INSERT INTO `vuelosvuelta` (`id`, `ubicacion`, `numVuelta`, `clase`, `equipaje`, `fechaVuelta`, `horaVuelta`, `duracionVuelta`, `precioPer`) VALUES
(1, 10, 2452, 'economica', 'no permitido', '2023-12-01', '12:00:00', '02:25:00', 32000.00),
(2, 10, 1234, 'economica', 'permitido', '2023-12-01', '10:30:00', '02:30:00', 35300.00),
(3, 10, 2472, 'premium', 'permitido', '2023-12-01', '14:00:00', '01:45:00', 57500.00),
(4, 10, 2312, 'economica', 'permitido', '2023-12-01', '13:40:00', '02:30:00', 34500.00);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `reservasvuelosida`
--
ALTER TABLE `reservasvuelosida`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `reservasvuelosida_ibfk_2` (`vueloId`);

--
-- Indices de la tabla `reservasvuelosvuelta`
--
ALTER TABLE `reservasvuelosvuelta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `vueloId` (`vueloVueltaId`),
  ADD KEY `vueloIdaId` (`vueloIdaId`);

--
-- Indices de la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `userprueba`
--
ALTER TABLE `userprueba`
  ADD PRIMARY KEY (`usuario`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `viajes ida`
--
ALTER TABLE `viajes ida`
  ADD PRIMARY KEY (`numVuelo`);

--
-- Indices de la tabla `viajesida`
--
ALTER TABLE `viajesida`
  ADD PRIMARY KEY (`id`),
  ADD KEY `destino` (`destino`);

--
-- Indices de la tabla `vuelosidayvuelta`
--
ALTER TABLE `vuelosidayvuelta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `viajeIdaId` (`viajeIdaId`),
  ADD KEY `viejaVueltaId` (`viajeVueltaId`);

--
-- Indices de la tabla `vuelosvuelta`
--
ALTER TABLE `vuelosvuelta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `salida` (`ubicacion`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `reservasvuelosida`
--
ALTER TABLE `reservasvuelosida`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `reservasvuelosvuelta`
--
ALTER TABLE `reservasvuelosvuelta`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `viajesida`
--
ALTER TABLE `viajesida`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `vuelosidayvuelta`
--
ALTER TABLE `vuelosidayvuelta`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `vuelosvuelta`
--
ALTER TABLE `vuelosvuelta`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `reservasvuelosida`
--
ALTER TABLE `reservasvuelosida`
  ADD CONSTRAINT `reservasvuelosida_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservasvuelosida_ibfk_2` FOREIGN KEY (`vueloId`) REFERENCES `viajesida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reservasvuelosvuelta`
--
ALTER TABLE `reservasvuelosvuelta`
  ADD CONSTRAINT `reservasvuelosvuelta_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservasvuelosvuelta_ibfk_2` FOREIGN KEY (`vueloVueltaId`) REFERENCES `vuelosvuelta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservasvuelosvuelta_ibfk_3` FOREIGN KEY (`vueloIdaId`) REFERENCES `viajesida` (`id`);

--
-- Filtros para la tabla `viajesida`
--
ALTER TABLE `viajesida`
  ADD CONSTRAINT `viajesida_ibfk_1` FOREIGN KEY (`destino`) REFERENCES `ubicacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `vuelosidayvuelta`
--
ALTER TABLE `vuelosidayvuelta`
  ADD CONSTRAINT `vuelosidayvuelta_ibfk_1` FOREIGN KEY (`viajeIdaId`) REFERENCES `viajesida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `vuelosidayvuelta_ibfk_2` FOREIGN KEY (`viajeVueltaId`) REFERENCES `vuelosvuelta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `vuelosvuelta`
--
ALTER TABLE `vuelosvuelta`
  ADD CONSTRAINT `vuelosvuelta_ibfk_1` FOREIGN KEY (`ubicacion`) REFERENCES `ubicacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
