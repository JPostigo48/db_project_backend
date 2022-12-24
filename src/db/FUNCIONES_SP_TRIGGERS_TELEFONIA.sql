USE telefonia;

#STORED PROCEDURE 01
DELIMITER //
DROP PROCEDURE IF EXISTS Nuevo_Producto_Celular//
CREATE PROCEDURE Nuevo_Producto_Celular (IN celprecio DECIMAL(10,0),IN celstock INT,IN celmodelo VARCHAR(100))
BEGIN
	DECLARE idnuevo INT;
	INSERT INTO `producto` (`precio`,`stock`) VALUES (celprecio,celstock);
    SET idnuevo = (SELECT MAX(`id_producto`) FROM producto);
    INSERT INTO `celular` (`id_producto`,`modelo`) VALUES
    (idnuevo,celmodelo);
END;
//
DELIMITER ;
-- CALL Nuevo_Producto_Celular(`precio`,`stock`,`modelo`);

#STORED PROCEDURE 02
DELIMITER //
DROP PROCEDURE IF EXISTS Nuevo_Producto_Plan//
CREATE PROCEDURE Nuevo_Producto_Plan (
IN planprecio DECIMAL(10,0),
IN planstock INT,
IN plannombre VARCHAR(50),
IN plandescrip MEDIUMTEXT,
IN plangigas INT,
IN planmin INT,
IN planmsj INT)
BEGIN
	DECLARE idnuevo INT;
	INSERT INTO `producto` (`precio`,`stock`) VALUES (planprecio,planstock);
    SET idnuevo = (SELECT MAX(`id_producto`) FROM producto);
    INSERT INTO `plan` (`id_producto`,`nombre`,`descripcion`,`gigas`,`minutos`,`mensajes`) VALUES
    (idnuevo,plannombre,plandescrip,plangigas,planmin,planmsj);
END;
//
DELIMITER ;
-- CALL Nuevo_Producto_Plan(`precio`,`stock`,`nombre`,`descripcion`,`gigas`,`minutos`,`mensajes`);

#STORED PROCEDURE 03
DELIMITER //
DROP PROCEDURE IF EXISTS Agregar_Linea_Cliente//
CREATE PROCEDURE Agregar_Linea_Cliente(IN nuevonro INT, IN tipolinea VARCHAR(64), IN dnicliente INT)
BEGIN
	INSERT INTO `linea` (`NRO_CELULAR`,`tipo`) VALUES (nuevonro,tipolinea);
    INSERT INTO `lineacliente` (`NRO_CELULAR`,`dni_cliente`) VALUES (nuevonro,dnicliente);
END;
//
DELIMITER ;
-- CALL Agregar_Linea_Cliente (`NRO_CELULAR`,`tipo`,`dni_cliente`);

#STORED PROCEDURE 04
DELIMITER //
DROP PROCEDURE IF EXISTS Agregar_Consulta//
CREATE PROCEDURE Agregar_Consulta (IN asuntonuevo VARCHAR(100), IN descripnuevo MEDIUMTEXT, IN dninuevo INT)
BEGIN
	DECLARE idnuevo INT;
	INSERT INTO `consulta` (`estado`,`asunto`,`descripcion`) VALUES ('ABIERTO',asuntonuevo,descripnuevo);
    SET idnuevo = (SELECT MAX(`id_consulta`) FROM consulta);
    INSERT INTO `consultacliente` (`dni_cliente`,`id_consulta`) VALUES (dninuevo,idnuevo);
END;
//
DELIMITER ;
-- CALL Agregar_Consulta (`asunto`,`descripnuevo`,`dninuevo`);

#STORED PROCEDURE 05
DELIMITER //
DROP PROCEDURE IF EXISTS Agregar_Empleado//
CREATE PROCEDURE Agregar_Empleado (
IN new_nombres VARCHAR(50),
IN new_primer_apellido VARCHAR(50),
IN new_segundo_apellido VARCHAR(50),
IN new_fech_nac DATE,
IN new_celular INT,
IN new_clave VARCHAR(50),
IN idbase INT)
BEGIN
	DECLARE idnuevo INT;
    DECLARE usuarionuevo VARCHAR(30);
    INSERT INTO `empleado` (`id_empleado`,`nombres`,`primer_apellido`,`segundo_apellido`,`fech_nac`,`celular`,`clave`) VALUES
    (idnuevo,new_nombres,new_primer_apellido,new_segundo_apellido,new_fech_nac,new_celular,new_clave);
    SET idnuevo = (SELECT MAX(`id_empleado`) FROM empleado);
    SET usuarionuevo = CONCAT(SUBSTRING(new_nombres,1,1),REPLACE(new_primer_apellido," ",""));
    UPDATE empleado SET usuario = LCASE(usuarionuevo) WHERE id_empleado = idnuevo;
	UPDATE empleado SET email = LCASE(CONCAT(usuarionuevo,idnuevo,"@entel.pe")) WHERE id_empleado = idnuevo;
    INSERT INTO `baseEmpleado` (`ID_base`,`id_empleado`) VALUES (idbase,idnuevo);
    SELECT usuario 'USUARIO', email 'CORREO' FROM `empleado` WHERE id_empleado = idnuevo;
END;
//
DELIMITER ;
-- CALL Agregar_Empleado (`nombres`,`primer_apellido`,`segundo_apellido`,`fech_nac`,`celular`,`clave`,`ID_base`);

#STORED PROCEDURE 06
DELIMITER //
DROP PROCEDURE IF EXISTS Hacer_Compra//
CREATE PROCEDURE Hacer_Compra(IN new_hora TIME, IN new_fecha DATE, IN dnicliente INT, IN idproducto INT)
BEGIN
	DECLARE idnuevo INT;
    INSERT INTO `compra` (`hora`,`fecha`) VALUES (new_hora,new_fecha);
    SET idnuevo = (SELECT MAX(`id_compra`) FROM compra);
    INSERT INTO `compraCliente` (`id_compra`,`dni_cliente`,`id_producto`) VALUES (idnuevo,dnicliente,idproducto);
    UPDATE `producto` SET stock = stock - 1 WHERE id_producto = idnuevo;
END;
//
DELIMITER ;
-- CALL Hacer_Compra(`hora`,`fecha`,`dni_cliente`,`id_producto`);

#STORED PROCEDURE 07
DELIMITER //
DROP PROCEDURE IF EXISTS Modificar_Empleado//
CREATE PROCEDURE Modificar_Empleado(
IN idempl INT,
IN new_nombres VARCHAR(50),
IN new_primer_apellido VARCHAR(50),
IN new_segundo_apellido VARCHAR(50),
IN new_fech_nac DATE,
IN new_celular INT,
IN new_clave VARCHAR(50),
IN idbase INT)
BEGIN
	UPDATE `empleado` SET
    nombres = new_nombres,
    primer_apellido = new_primer_apellido,
    segundo_apellido = new_segundo_apellido,
    fech_nac = new_fech_nac,
    celular = new_celular,
    clave = new_clave
    WHERE id_empleado = idempl;
    UPDATE `baseEmpleado` SET ID_base = idbase WHERE id_empleado = idempl;
END;
//
DELIMITER ;
-- CALL Modificar_Empleado(`ide`,`nombres`,`primer_apellido`,`segundo_apellido`,`fech_nac`,`celular`,`clave`,`idbase`);

#STORED PROCEDURE 08
DELIMITER //
DROP PROCEDURE IF EXISTS Obtener_Info_Empleado//
CREATE PROCEDURE Obtener_Info_Empleado(IN idempl INT)
BEGIN
	SELECT nombres 'Nombres',
    primer_apellido 'Primer Apellido',
    segundo_apellido 'Segundo Apellido',
    fech_nac 'Fecha de Nacimiento',
    celular 'Celular',
    email 'Email',
    usuario 'Usuario'
    FROM `empleado` WHERE id_empleado = idempl;
END;
//
DELIMITER ;
-- CALL Obtener_Info_Empleado(`id_empleado`);

#STORED PROCEDURE 09
DELIMITER //
DROP PROCEDURE IF EXISTS Validar_Empleado//
CREATE PROCEDURE Validar_Empleado(IN usuario_empl VARCHAR(50),IN clave_empl VARCHAR(50))
BEGIN
	SELECT id_empleado 'ID', id_cargo 'CARGO' FROM `empleado` WHERE usuario = usuario_empl AND clave = clave_empl;
END;
//
DELIMITER ;
-- CALL Validar_Empleado(`usuario`,`clave`);

#STORED PROCEDURE 10
DELIMITER //
DROP PROCEDURE IF EXISTS Validar_Cliente//
CREATE PROCEDURE Validar_Cliente(IN dni_clnt INT,IN clave_clnt VARCHAR(50))
BEGIN
	SELECT nombres 'NOMBRES' FROM `cliente` WHERE dni_cliente = dni_clnt AND clave = clave_clnt;
END;
//
DELIMITER ;
-- CALL Validar_Cliente(`dni_cliente`,`clave`);

#STORED PROCEDURE 11
-- BUSCAR LINEAS DE UN CLIENTE Y SU  TIPO
DELIMITER //
DROP PROCEDURE IF EXISTS Buscar_lineas//
CREATE PROCEDURE  Buscar_lineas(IN dni INT)
BEGIN
	SELECT c.dni_cliente 'DNI', CONCAT(UCASE(c.primer_apellido),' ',UCASE(c.segundo_apellido),', ',c.nombres)'NOMBRES',
	lc.NRO_CELULAR 'CELULAR', l.tipo 'TIPO'
	FROM telefonia.cliente c
	inner join telefonia.lineacliente lc on lc.dni_cliente = c.dni_cliente
	inner join telefonia.linea l on l.NRO_CELULAR = lc.NRO_CELULAR
	where c.dni_cliente = dni;
END;
//
DELIMITER ;
-- CALL Buscar_lineas(`dni_cliente`)

#FUNCTION 01
DELIMITER //
DROP FUNCTION IF EXISTS Validar_Cliente_Funcion//
CREATE FUNCTION Validar_Cliente_Funcion(dni_clnt INT,clave_clnt VARCHAR(50)) RETURNS BOOL DETERMINISTIC
BEGIN
	DECLARE validate BOOL;
    SET validate = FALSE;
    IF dni_clnt = (SELECT dni_cliente FROM `cliente` WHERE dni_cliente = dni_clnt AND clave = clave_clnt) THEN
		SET validate = TRUE;
	END IF;
    RETURN validate;
END;
//
DELIMITER ;
-- SELECT Validar_Cliente_Funcion(`dni_cliente`,`clave`);

#TRIGGER 01
DELIMITER //
DROP TRIGGER IF EXISTS agregar_gerente //
CREATE TRIGGER agregar_gerente
AFTER INSERT ON gerente FOR EACH ROW
BEGIN
    UPDATE empleado SET id_cargo = 1 WHERE id_empleado = NEW.id_empleado;
END;
//

