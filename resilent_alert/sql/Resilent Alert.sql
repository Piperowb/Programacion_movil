-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-11-2023 a las 19:14:28
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
  `mensaje` longtext NOT NULL,
  `id_tipo_desastre` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `ubicacion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `alerta`
--

INSERT INTO `alerta` (`id`, `mensaje`, `id_tipo_desastre`, `fecha`, `ubicacion`) VALUES
(1, 'Se pronostica la llegada de un huracán en las próximas horas. Tomen medidas de precaución inmediatas. Refúgiense en lugares seguros, abastezcan alimentos y agua, y sigan las instrucciones de las autoridades locales. Eviten áreas costeras y prepárense para fuertes vientos y lluvias intensas', 1, '2023-11-30 16:36:13', '4.6097, -74.0817'),
(2, 'Se ha detectado actividad sísmica significativa. Prepárense para un posible terremoto. Busquen lugares seguros, como debajo de muebles sólidos, y manténganse alejados de ventanas. Desarrollen un plan de evacuación y tengan suministros de emergencia listos.', 2, '2023-11-25 16:37:05', '6.2442, -75.581'),
(3, 'Alerta de tornado en la zona. Busquen refugio en un sótano o interior de una estructura resistente. Eviten ventanas y manténganse informados a través de emisoras de radio y aplicaciones de alerta. Si están al aire libre, busquen un refugio inmediato.', 3, '2024-01-10 16:37:17', '3.4516, -76.5320');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lista_suministros`
--

CREATE TABLE `lista_suministros` (
  `id` int(11) NOT NULL,
  `id_tipo_desastre` int(11) NOT NULL,
  `suministro` varchar(100) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `lista_suministros`
--

INSERT INTO `lista_suministros` (`id`, `id_tipo_desastre`, `suministro`, `descripcion`, `fecha_creacion`) VALUES
(1, 1, 'Agua embotellada', 'Agua potable en envases sellados para el consumo durante emergencias', '2023-11-18 11:14:02'),
(2, 1, 'Comida enlatada', 'Alimentos no perecederos enlatados con larga vida útil', '2023-11-18 11:14:43'),
(3, 2, 'Kit de primeros auxilios', 'Material médico básico para el tratamiento de lesiones leves durante y después de un terremoto', '2023-11-18 11:14:49'),
(4, 2, 'Linterna y pilas', 'Iluminación de emergencia para situaciones de corte de energía', '2023-11-18 11:14:53'),
(9, 3, 'Refugio portátil', 'Carpa o refugio ligero para protegerse del viento y la lluvia', '2023-11-18 11:14:57'),
(10, 3, 'Alarma de tornado', 'Dispositivo de alerta para recibir notificaciones tempranas sobre tornados', '2023-11-18 11:15:00'),
(11, 4, 'Bomba de agua manual', 'Dispositivo para bombear agua fuera de áreas inundadas', '2023-11-18 11:15:05'),
(12, 4, 'Chaleco salvavidas', 'Equipo de seguridad para protegerse en caso de inundaciones repentinas', '2023-11-18 11:15:09'),
(13, 5, 'Máscara antigás', 'Protección respiratoria contra cenizas volcánicas y gases tóxicos', '2023-11-18 11:17:01'),
(14, 5, 'Gafas de protección', 'Protección ocular contra partículas finas y cenizas en suspensión', '2023-11-18 11:17:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `refugio`
--

CREATE TABLE `refugio` (
  `id` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `ubicacion` varchar(100) NOT NULL,
  `capacidad` varchar(11) NOT NULL,
  `servicios` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `refugio`
--

INSERT INTO `refugio` (`id`, `nombre`, `ubicacion`, `capacidad`, `servicios`) VALUES
(1, 'Refugio Andino', 'Bogota', '50', 'Calefacción, Comida, Agua Potable'),
(2, 'Refugio Paisa', 'Medellin', '40', 'Comida, Duchas, Camas'),
(3, 'Refugio Caribe', 'Cartagena', '25', 'Cocina, Camas, Baños'),
(4, 'Refugio Salsa', 'Santiago de', '30', 'Comida, Baños, Wi-Fi'),
(5, 'Refugio Sierra Nevada', 'Bucaramanga', '45', 'Senderismo, Tiendas de Campaña, Agua Potable');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_desastre`
--

CREATE TABLE `tipo_desastre` (
  `id` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `ubicacion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_desastre`
--

INSERT INTO `tipo_desastre` (`id`, `nombre`, `descripcion`, `ubicacion`) VALUES
(1, 'Huracanes', 'Los huracanes son tormentas tropicales con vientos de alta velocidad y fuertes lluvias. Pueden causa', '4.6097, -74.0817'),
(2, 'Terremotos', 'Los terremotos son movimientos repentinos de la corteza terrestre que pueden causar sacudidas intens', '6.2442, -75.581'),
(3, 'Tornado', 'Los tornados son columnas rotativas de aire con alta velocidad que descienden de nubes de tormenta h', '3.4516, -76.5320'),
(4, 'Inundaciones', 'Las inundaciones pueden ocurrir debido a fuertes lluvias, deshielos, marejadas ciclónicas o desborda', '7.1254, -73.1198'),
(5, 'Erupciones volcánicas', 'Las erupciones volcánicas son eventos en los que magma, ceniza y gases son expulsados desde un volcá', '4.8143, -75.6944');

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
(1, 'Johan Hincapie', 'Clave123', 'usuario.prueba@example.com', '123 Calle de Prueba', '123-456-7890', '2023-10-21 10:00:00'),
(2, 'Felipe Rodriguez', '123456', 'felipero@gmail.com', 'carera12', '312314', '2023-01-27 11:24:40'),
(3, 'Daniela Gutierres', '12345678', 'dani08@gmail.com', 'carrea 123d bis#', '312314', '2023-01-24 11:24:35'),
(4, 'Angie Vanessa', '1234567', 'angvan@email.com', 'caseq123', '32512245', '2023-01-03 11:24:25'),
(5, 'Carla Triana', '55555', 'carlatri@gmail.com', 'accarw1123', '231231223', '2023-10-21 22:39:04');

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
  ADD KEY `id_tipo_desastre` (`id_tipo_desastre`);

--
-- Indices de la tabla `refugio`
--
ALTER TABLE `refugio`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_desastre`
--
ALTER TABLE `tipo_desastre`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alerta`
--
ALTER TABLE `alerta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `lista_suministros`
--
ALTER TABLE `lista_suministros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `refugio`
--
ALTER TABLE `refugio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tipo_desastre`
--
ALTER TABLE `tipo_desastre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
  ADD CONSTRAINT `lista_suministros_ibfk_1` FOREIGN KEY (`id_tipo_desastre`) REFERENCES `tipo_desastre` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
