-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-08-2024 a las 22:12:27
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mundosbk`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carito`
--

CREATE TABLE `carito` (
  `idUsuarios` int(11) NOT NULL,
  `nombreM` varchar(45) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precioU` int(11) DEFAULT NULL,
  `subtotal` int(11) DEFAULT NULL,
  `foto` varchar(200) DEFAULT NULL,
  `idMotos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_factura`
--

CREATE TABLE `detalle_factura` (
  `idfactura` int(11) NOT NULL,
  `cantida` int(11) DEFAULT NULL,
  `precioU` int(11) DEFAULT NULL,
  `subtotal` int(11) DEFAULT NULL,
  `nombreM` varchar(45) DEFAULT NULL,
  `idMotos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `idUsuarios` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

CREATE TABLE `marca` (
  `id` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `modelo` varchar(45) DEFAULT NULL,
  `serie` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `motos`
--

CREATE TABLE `motos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio` int(11) DEFAULT NULL,
  `foto` varchar(200) DEFAULT NULL,
  `marca_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `correo` varchar(200) DEFAULT NULL,
  `clave` varchar(200) DEFAULT NULL,
  `telefono` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `correo`, `clave`, `telefono`) VALUES
(1, 'jhonny', 'jhonny@com.co', '1234', 232142),
(2, 'yu', 'yu@com.co', 'pbkdf2:sha256:600000$uvpTusUk4ydgiumi$bab46d0eda7db4581b90f6d3cce136b1bd96581a6bf7fea9e00dbe7665541609', 3213345445),
(3, 'yuky', 'yuky@com.co', 'scrypt:32768:8:1$8vGGixH88SHZ6frA$dcdced98f0ea8307d20679ddc8f3127f315f8a982e69d7ecba99eb24ff074fc1589d4e8e9ecd326884557eaa0dfc47ef6ab2e52dcd90806a69ffc392da18a1a3', 3213345445);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carito`
--
ALTER TABLE `carito`
  ADD PRIMARY KEY (`idUsuarios`,`idMotos`),
  ADD KEY `fk_repuestos_has_usuarios_usuarios1_idx` (`idUsuarios`),
  ADD KEY `fk_carito_motos1_idx` (`idMotos`);

--
-- Indices de la tabla `detalle_factura`
--
ALTER TABLE `detalle_factura`
  ADD PRIMARY KEY (`idfactura`,`idMotos`),
  ADD KEY `fk_factura_has_repuestos_factura1_idx` (`idfactura`),
  ADD KEY `fk_detalle_factura_motos1_idx` (`idMotos`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id`,`idUsuarios`),
  ADD KEY `fk_factura_usuarios_idx` (`idUsuarios`);

--
-- Indices de la tabla `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `motos`
--
ALTER TABLE `motos`
  ADD PRIMARY KEY (`id`,`marca_id`),
  ADD KEY `fk_repuestos_marca1_idx` (`marca_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `marca`
--
ALTER TABLE `marca`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `motos`
--
ALTER TABLE `motos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carito`
--
ALTER TABLE `carito`
  ADD CONSTRAINT `fk_carito_motos1` FOREIGN KEY (`idMotos`) REFERENCES `motos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_repuestos_has_usuarios_usuarios1` FOREIGN KEY (`idUsuarios`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_factura`
--
ALTER TABLE `detalle_factura`
  ADD CONSTRAINT `fk_detalle_factura_motos1` FOREIGN KEY (`idMotos`) REFERENCES `motos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_factura_has_repuestos_factura1` FOREIGN KEY (`idfactura`) REFERENCES `factura` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `fk_factura_usuarios` FOREIGN KEY (`idUsuarios`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `motos`
--
ALTER TABLE `motos`
  ADD CONSTRAINT `fk_repuestos_marca1` FOREIGN KEY (`marca_id`) REFERENCES `marca` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
