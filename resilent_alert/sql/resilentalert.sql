-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-10-2023 a las 23:00:12
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `resilentalert`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alerta`
--

CREATE TABLE `alerta` (
  `id` int(11) NOT NULL,
  `id_tipo_desastre` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `ubicacion` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lista_suministros`
--

CREATE TABLE `lista_suministros` (
  `id` int(11) NOT NULL,
  `id_tipo_desastre` int(11) NOT NULL,
  `id_suministro` int(11) NOT NULL,
  `fecha_creacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensaje`
--

CREATE TABLE `mensaje` (
  `id` int(11) NOT NULL,
  `contenido` varchar(100) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `refugio`
--

CREATE TABLE `refugio` (
  `id` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `ubicacion` int(11) NOT NULL,
  `capacidad` int(11) NOT NULL,
  `servicios` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `suministro`
--

CREATE TABLE `suministro` (
  `id` int(11) NOT NULL,
  `nombre` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `id_suministro_linea` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `suministro_en_lista`
--

CREATE TABLE `suministro_en_lista` (
  `id` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `id_lista_suminstro` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_desastre`
--

CREATE TABLE `tipo_desastre` (
  `id` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `id_mensaje` int(11) NOT NULL,
  `ubicacion` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `contraseña` varchar(50) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `fecha_creacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `contraseña`, `correo`, `direccion`, `telefono`, `fecha_creacion`) VALUES
(1, 'UsuarioPrueba', 'Clave123', 'usuario.prueba@example.com', '123 Calle de Prueba', '123-456-7890', '2023-10-21 10:00:00'),
(2, 'Felipe', '123456', 'gefrasdsss', 'carera12', '312314', '0000-00-00 00:00:00'),
(3, 'German rodriguez', '123456', 'felipe@felipe', 'carrea 123d bis#', '312314', '0000-00-00 00:00:00'),
(4, 'felipe', '1234569', 'gers@asd', 'caseq123', '32512245', '0000-00-00 00:00:00'),
(5, 'felipe', '12335', 'asdadd@asdad', 'accarw1123', '231231223', '2023-10-21 22:39:04'),
(6, 'asdasd', 'asdassddasd', 'asd@asdqw', '123214ccasda', '3123124', '2023-10-21 22:39:24'),
(7, 'aasdas', '1231asdasd', 'adasda@adsasd', 'dasdasd123', '23123', '2023-10-21 22:48:35'),
(8, 'asdads', '122312421', 'ger@asd', 'asdad12', '23123123', '2023-10-22 00:19:29'),
(9, 'felipe', '12335', 'asdadd@asdad', 'accarw1123', '231231223', '2023-10-22 00:24:40'),
(10, 'Kata', '12345678', 'saqmasdad@', 'caerrera1@asd', '312314', '2023-10-22 00:28:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_refugio`
--

CREATE TABLE `usuario_refugio` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_refugio` int(11) NOT NULL,
  `fecha_seleccion` datetime NOT NULL,
  `motivo_seleccion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alerta`
--
ALTER TABLE `alerta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tipo_desastre` (`id_tipo_desastre`);

--
-- Indices de la tabla `lista_suministros`
--
ALTER TABLE `lista_suministros`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tipo_desastre` (`id_tipo_desastre`),
  ADD KEY `id_suministro` (`id_suministro`);

--
-- Indices de la tabla `mensaje`
--
ALTER TABLE `mensaje`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `refugio`
--
ALTER TABLE `refugio`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `suministro`
--
ALTER TABLE `suministro`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_suministro_linea` (`id_suministro_linea`);

--
-- Indices de la tabla `suministro_en_lista`
--
ALTER TABLE `suministro_en_lista`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_lista_suministro` (`id_lista_suminstro`);

--
-- Indices de la tabla `tipo_desastre`
--
ALTER TABLE `tipo_desastre`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_mensaje` (`id_mensaje`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario_refugio`
--
ALTER TABLE `usuario_refugio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_refugio` (`id_refugio`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alerta`
--
ALTER TABLE `alerta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lista_suministros`
--
ALTER TABLE `lista_suministros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mensaje`
--
ALTER TABLE `mensaje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `refugio`
--
ALTER TABLE `refugio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `suministro`
--
ALTER TABLE `suministro`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `suministro_en_lista`
--
ALTER TABLE `suministro_en_lista`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_desastre`
--
ALTER TABLE `tipo_desastre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuario_refugio`
--
ALTER TABLE `usuario_refugio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alerta`
--
ALTER TABLE `alerta`
  ADD CONSTRAINT `alerta_ibfk_1` FOREIGN KEY (`id_tipo_desastre`) REFERENCES `tipo_desastre` (`id`);

--
-- Filtros para la tabla `lista_suministros`
--
ALTER TABLE `lista_suministros`
  ADD CONSTRAINT `lista_suministros_ibfk_1` FOREIGN KEY (`id_tipo_desastre`) REFERENCES `tipo_desastre` (`id`),
  ADD CONSTRAINT `lista_suministros_ibfk_2` FOREIGN KEY (`id_suministro`) REFERENCES `suministro` (`id`);

--
-- Filtros para la tabla `suministro`
--
ALTER TABLE `suministro`
  ADD CONSTRAINT `suministro_ibfk_1` FOREIGN KEY (`id_suministro_linea`) REFERENCES `suministro_en_lista` (`id`);

--
-- Filtros para la tabla `suministro_en_lista`
--
ALTER TABLE `suministro_en_lista`
  ADD CONSTRAINT `suministro_en_lista_ibfk_1` FOREIGN KEY (`id_lista_suminstro`) REFERENCES `lista_suministros` (`id`);

--
-- Filtros para la tabla `tipo_desastre`
--
ALTER TABLE `tipo_desastre`
  ADD CONSTRAINT `tipo_desastre_ibfk_1` FOREIGN KEY (`id_mensaje`) REFERENCES `mensaje` (`id`);

--
-- Filtros para la tabla `usuario_refugio`
--
ALTER TABLE `usuario_refugio`
  ADD CONSTRAINT `usuario_refugio_ibfk_1` FOREIGN KEY (`id_refugio`) REFERENCES `refugio` (`id`),
  ADD CONSTRAINT `usuario_refugio_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
