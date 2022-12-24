DROP DATABASE IF EXISTS telefonia;
CREATE DATABASE telefonia;
USE telefonia;

-- TABLES
-- Table 'LineaCliente'
DROP TABLE IF EXISTS `LineaCliente`;
CREATE TABLE `LineaCliente` (
  `NRO_CELULAR` INTEGER,
  `dni_cliente` INTEGER,
  PRIMARY KEY (`NRO_CELULAR`)
);

-- Table 'Cliente'
DROP TABLE IF EXISTS `Cliente`;
CREATE TABLE `Cliente` (
  `dni_cliente` INTEGER,
  `nombres` VARCHAR(64) NULL DEFAULT NULL,
  `primer_apellido` VARCHAR(64) NULL DEFAULT NULL,
  `segundo_apellido` VARCHAR(64) NULL DEFAULT NULL,
  `direccion` VARCHAR(64) NULL DEFAULT NULL,
  `fecha_nacimiento` DATE NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `clave` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`dni_cliente`)
);
	
-- Table 'CompraCliente'
DROP TABLE IF EXISTS `CompraCliente`;
CREATE TABLE `CompraCliente` (
  `id_compra` INTEGER,
  `dni_cliente` INTEGER,
  `id_producto` INTEGER,
  PRIMARY KEY (`id_compra`)
);

-- Table 'Consulta'
DROP TABLE IF EXISTS `Consulta`;
CREATE TABLE `Consulta` (
  `id_consulta` INTEGER AUTO_INCREMENT,
  `estado` VARCHAR(50) NULL DEFAULT NULL,
  `asunto` VARCHAR(100) NULL DEFAULT NULL,
  `descripcion` MEDIUMTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_consulta`)
);

-- Table 'Producto'
DROP TABLE IF EXISTS `Producto`;
CREATE TABLE `Producto` (
  `id_producto` INTEGER AUTO_INCREMENT,
  `precio` DECIMAL NULL DEFAULT NULL,
  `stock` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id_producto`)
);

-- Table 'Celular'
DROP TABLE IF EXISTS `Celular`;
CREATE TABLE `Celular` (
  `id_producto` INTEGER,
  `modelo` VARCHAR(100),
  PRIMARY KEY (`id_producto`)
);

-- Table 'Plan'
DROP TABLE IF EXISTS `Plan`;
CREATE TABLE `Plan` (
  `id_producto` INTEGER,
  `nombre` VARCHAR(50) NULL DEFAULT NULL,
  `descripcion` MEDIUMTEXT NULL DEFAULT NULL,
  `gigas` INTEGER NULL DEFAULT NULL,
  `minutos` INTEGER NULL DEFAULT NULL,
  `mensajes` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id_producto`)
);

-- Table 'Empleado'
DROP TABLE IF EXISTS `Empleado`;
CREATE TABLE `Empleado` (
  `id_empleado` INTEGER AUTO_INCREMENT,
  `nombres` VARCHAR(50) NULL DEFAULT NULL,
  `primer_apellido` VARCHAR(50) NULL DEFAULT NULL,
  `segundo_apellido` VARCHAR(50) NULL DEFAULT NULL,
  `fech_nac` DATE NULL DEFAULT NULL,
  `celular` INTEGER NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `id_cargo` INTEGER NULL DEFAULT 2,
  `usuario` VARCHAR(50) NULL DEFAULT NULL,
  `clave` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id_empleado`)
);

-- Table 'Distrito'
DROP TABLE IF EXISTS `Distrito`;
CREATE TABLE `Distrito` (
  `id_distrito` INTEGER AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id_distrito`)
);

-- Table 'Gerente'
DROP TABLE IF EXISTS `Gerente`;
CREATE TABLE `Gerente` (
  `id_empleado` INTEGER,
  `fech_comienzo` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id_empleado`)
);

-- Table 'Base_telefonica'
DROP TABLE IF EXISTS `Base_telefonica`;
CREATE TABLE `Base_telefonica` (
  `ID_base` INTEGER AUTO_INCREMENT,
  `direccion` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_base`)
);

-- Table 'Provincia'
DROP TABLE IF EXISTS `Provincia`;
CREATE TABLE `Provincia` (
  `id_provincia` INTEGER AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id_provincia`)
);

-- Table 'Region'
DROP TABLE IF EXISTS `Region`;
CREATE TABLE `Region` (
  `id_region` INTEGER AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id_region`)
);

-- Table 'Compra'
DROP TABLE IF EXISTS `Compra`;
CREATE TABLE `Compra` (
  `id_compra` INTEGER AUTO_INCREMENT,
  `hora` TIME NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id_compra`)
);

-- Table 'linea'
DROP TABLE IF EXISTS `linea`;
CREATE TABLE `linea` (
  `NRO_CELULAR` INTEGER,
  `tipo` VARCHAR(64) NULL DEFAULT NULL,
  PRIMARY KEY (`NRO_CELULAR`)
);

-- Table 'clientDistrDirec'
DROP TABLE IF EXISTS `clientDistrDirec`;
CREATE TABLE `clientDistrDirec` (
  `id_distrito` INTEGER,
  `dni_cliente` INTEGER,
  PRIMARY KEY (`dni_cliente`)
);

-- Table 'DistritoProvincia'
DROP TABLE IF EXISTS `DistritoProvincia`;
CREATE TABLE `DistritoProvincia` (
  `id_distrito` INTEGER,
  `id_provincia` INTEGER,
  PRIMARY KEY (`id_distrito`)
);

-- Table 'ProvinciaRegion'
DROP TABLE IF EXISTS `ProvinciaRegion`;
CREATE TABLE `ProvinciaRegion` (
  `id_provincia` INTEGER,
  `id_region` INTEGER,
  PRIMARY KEY ( `id_provincia`)
);

-- Table 'BaseDistrDirec'
DROP TABLE IF EXISTS `BaseDistrDirec`;
CREATE TABLE `BaseDistrDirec` (
  `ID_base` INTEGER,
  `id_distrito` INTEGER,
  PRIMARY KEY (`ID_base`)
);

-- Table 'BaseEmpleado'
DROP TABLE IF EXISTS `BaseEmpleado`;
CREATE TABLE `BaseEmpleado` (
  `ID_base` INTEGER,
  `id_empleado` INTEGER,
  PRIMARY KEY (`id_empleado`)
);

-- Table 'ConsultaEmpleado'
DROP TABLE IF EXISTS `ConsultaEmpleado`;
CREATE TABLE `ConsultaEmpleado` (
  `id_empleado` INTEGER,
  `id_consulta` INTEGER,
  PRIMARY KEY (`id_empleado`)
);

-- Table 'ConsultaCliente'
DROP TABLE IF EXISTS `ConsultaCliente`;
CREATE TABLE `ConsultaCliente` (
  `id_consulta` INTEGER,
  `dni_cliente` INTEGER,
  PRIMARY KEY (`id_consulta`)
);

-- Table 'Cargo'
DROP TABLE IF EXISTS `Cargo`;
CREATE TABLE `Cargo` (
  `id_cargo` INTEGER AUTO_INCREMENT,
  `titulo` VARCHAR(50),
  `sueldo` INTEGER,
  PRIMARY KEY (`id_cargo`)
);

-- FOREIGN KEYS
ALTER TABLE `LineaCliente` ADD FOREIGN KEY (NRO_CELULAR) REFERENCES `linea` (`NRO_CELULAR`);
ALTER TABLE `LineaCliente` ADD FOREIGN KEY (dni_cliente) REFERENCES `Cliente` (`dni_cliente`);
ALTER TABLE `CompraCliente` ADD FOREIGN KEY (id_compra) REFERENCES `Compra` (`id_compra`);
ALTER TABLE `CompraCliente` ADD FOREIGN KEY (dni_cliente) REFERENCES `Cliente` (`dni_cliente`);
ALTER TABLE `CompraCliente` ADD FOREIGN KEY (id_producto) REFERENCES `Producto` (`id_producto`);
ALTER TABLE `Plan` ADD FOREIGN KEY (id_producto) REFERENCES `Producto` (`id_producto`);
ALTER TABLE `Celular` ADD FOREIGN KEY (id_producto) REFERENCES `Producto` (`id_producto`);
ALTER TABLE `Gerente` ADD FOREIGN KEY (id_empleado) REFERENCES `Empleado` (`id_empleado`);
ALTER TABLE `Empleado` ADD FOREIGN KEY (id_cargo) REFERENCES `Cargo` (`id_cargo`);
ALTER TABLE `clientDistrDirec` ADD FOREIGN KEY (id_distrito) REFERENCES `Distrito` (`id_distrito`);
ALTER TABLE `clientDistrDirec` ADD FOREIGN KEY (dni_cliente) REFERENCES `Cliente` (`dni_cliente`);
ALTER TABLE `DistritoProvincia` ADD FOREIGN KEY (id_distrito) REFERENCES `Distrito` (`id_distrito`);
ALTER TABLE `DistritoProvincia` ADD FOREIGN KEY (id_provincia) REFERENCES `Provincia` (`id_provincia`);
ALTER TABLE `ProvinciaRegion` ADD FOREIGN KEY (id_region) REFERENCES `Region` (`id_region`);
ALTER TABLE `ProvinciaRegion` ADD FOREIGN KEY (id_provincia) REFERENCES `Provincia` (`id_provincia`);
ALTER TABLE `BaseDistrDirec` ADD FOREIGN KEY (ID_base) REFERENCES `Base_telefonica` (`ID_base`);
ALTER TABLE `BaseDistrDirec` ADD FOREIGN KEY (id_distrito) REFERENCES `Distrito` (`id_distrito`);
ALTER TABLE `BaseEmpleado` ADD FOREIGN KEY (ID_base) REFERENCES `Base_telefonica` (`ID_base`);
ALTER TABLE `BaseEmpleado` ADD FOREIGN KEY (id_empleado) REFERENCES `Empleado` (`id_empleado`);
ALTER TABLE `ConsultaEmpleado` ADD FOREIGN KEY (id_empleado) REFERENCES `Empleado` (`id_empleado`);
ALTER TABLE `ConsultaEmpleado` ADD FOREIGN KEY (id_consulta) REFERENCES `Consulta` (`id_consulta`);
ALTER TABLE `ConsultaCliente` ADD FOREIGN KEY (dni_cliente) REFERENCES `Cliente` (`dni_cliente`);
ALTER TABLE `ConsultaCliente` ADD FOREIGN KEY (id_consulta) REFERENCES `Consulta` (`id_consulta`);

-- INSERTS
-- INSERT INTO `Cliente` (`dni_cliente`,`nombres`,`primer_apellido`,`segundo_apellido`,`direccion`,`fecha_nacimiento`,`clave`) VALUES
-- ('','','','','','','');
-- INSERT INTO `Empleado` (`nombres`,`primer_apellido`,`segundo_apellido`,`fech_nac`,`celular`,`clave`) VALUES
-- ('','','','','','');
-- INSERT INTO `Gerente` (`id_empleado`,`fech_comienzo`) VALUES
-- ('','');
-- INSERT INTO `Base_telefonica` (`ID_base`,`direccion`) VALUES
-- ('','');
-- INSERT INTO `CompraCliente` (`dni_cliente`,`id_producto`) VALUES
-- ('','');
-- INSERT INTO `LineaCliente` (`NRO_CELULAR`,`dni_cliente`) VALUES
-- ('','');
-- INSERT INTO `Compra` (`id_compra`,`hora`,`fecha`) VALUES
-- ('','','');
-- INSERT INTO `linea` (`NRO_CELULAR`,`tipo`) VALUES
-- ('','');
-- INSERT INTO `clientDistrDirec` (`id_distrito`,`dni_cliente`) VALUES
-- ('','');
-- INSERT INTO `DistritoProvincia` (`id_distrito`,`id_provincia`) VALUES
-- ('','');
-- INSERT INTO `ProvinciaRegion` (`id_region`,`id_provincia`) VALUES
-- ('','');
-- INSERT INTO `BaseDistrDirec` (`ID_base`,`id_distrito`) VALUES
-- ('','');
-- INSERT INTO `BaseEmpleado` (`ID_base`,`id_empleado`) VALUES
-- ('','');
-- INSERT INTO `ConsultaEmpleado` (`id_empleado`,`id_consulta`) VALUES
-- ('','');
-- INSERT INTO `ConsultaCliente` (`dni_cliente`,`id_consulta`) VALUES
-- ('','');