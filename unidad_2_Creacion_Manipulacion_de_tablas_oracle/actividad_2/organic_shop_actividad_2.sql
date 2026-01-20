-- Base de Datos para Organic Shop

-- Creación de tablas

CREATE TABLE categoria( -- creación de la tabla "categoria"
    id_categoria NUMBER(3) PRIMARY KEY, -- campo que servira como primary key de tipo numerico de hasta 3 digitos
    nombre_cat VARCHAR2(20), -- campo para nombre de categoria de tipo cadena de caracteres con longitud 20
    descripcion VARCHAR2(50) -- campo para descripción, de tipo cadena de caracteres de longitud 50
); 


CREATE TABLE producto( -- Creación de la tabla "producto"
    id_producto NUMBER(5) PRIMARY KEY, -- campo que servira de primary key de tipo numerico de hasta 5 digitos
    nombre_prod VARCHAR2(30), -- campo para nombre de producto de tipo cadena de caracteres de longitud 30 
    precio_unit NUMBER(12,2), -- campo para el precio unitario de tipo numerico con una precición de 12 números enteros y dos decimales
    stock NUMBER(6), -- campo stock para existencias de tipo numerico con longitud de 6
    id_categori NUMBER(3), -- campo que se utilizara como clave foranea de tipo numerico con longitud 3
    CONSTRAINT fk_categoria FOREIGN KEY (id_categori) 
        REFERENCES categoria(id_categoria) -- clave foranea que apunta a la tabla producto y que hace referencia a su clave primaria
);


CREATE TABLE cliente(-- creación de la tabla "cliente"
    id_cliente NUMBER(10) PRIMARY KEY, -- campo que servira de primary key de tipo numerico con longitud 10
    nombre VARCHAR2(15), -- campo de tipo cadena de caracteres de longgitud 15 para registrar el nombre del cliente
    apellido VARCHAR2(20), -- campo de tipo cadena de caracteres con longitud 20 para registrar el apellido del cliente
    edad NUMBER(2), -- campo de tipo numerico con longitud 2 para registar edad del cleinte
    direccion VARCHAR2(30), -- campo de tipo cadena de caracteres de longitud 30 para registar direccion del cliente
    telefono NUMBER(10), -- campo de tipo numerico de longitud 10 para registar telefono del cliente
    email VARCHAR2(45), -- campo de tipo cadena de caracteres de longitud 45 para registrar email del cliente
    tarjeta_credito NUMBER(16), -- campo de tipo numerico de longitud 16 para almacenar el numero de tarjeta del cliente
    direccion_envio VARCHAR2(30) -- campo de tipo cadena de caracteres de longitud 30 para almacenar la direccion de envio para el cliente
);

CREATE TABLE factura ( -- creacion de tabla factura
    id_factura NUMBER(7) PRIMARY KEY, -- campo que servira de clave primaria de tipo numerico de longitud 7
    id_client NUMBER(10), -- 
    fecha DATE, -- campo de tipo fecha su funcion sera registrar el dia en que se realizo la venta
    total_factura NUMBER(12,2), -- capo de tipo numerico con longitud de 12 numeros enteros y 2 decimales para registrar el total de la factura
    estado_factura VARCHAR2(12) -- campo de tipo cadena de caracteres de longitud 12 para indicar los deatlles del estado de la factura
);

CREATE TABLE detalle (
    num_detalle NUMBER(7), -- campo de tipo numerico con longitud 7 que serivira de identificador de registro
    id_fact NUMBER(7), -- campo de tipo numerico con longitud 7 para identificar la factura
    id_producto NUMBER(8), -- campo de tipo numerico de longitud 8 para el identificador de producto
    cantidad NUMBER(4), -- campo de tipo numerico de longitud 4 para ingresar la cantidad de productos
    precio NUMBER(12,2), -- campo de tipo numerico de longitud 12 enteros y 2 decimales para registrar el precio
    PRIMARY KEY (id_fact, num_detalle), -- clave primaria compuesta, uno depende del otro, no puede haber valores nulos
    CONSTRAINT fk_factura FOREIGN KEY (id_fact) REFERENCES factura(id_factura), -- creación de la clave foranea 
    CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE carrito ( -- creacion de tabla carrito
    id_carrito NUMBER(5) PRIMARY KEY, -- campo de tipo numerico de longitud 5, sera clave primaria y servira de identificador
    id_factura NUMBER(7), -- campo de tipo numerico de longitud 7 para el id de factura
    id_cliente number(10),--campo de tipo numerico de longitud 10 para el id del cliente
    cantidad_prod NUMBER(5), -- campo de tipo numerico de longitud 5 para registrar la cantidad de productos
    CONSTRAINT fk_factura_carrito FOREIGN KEY (id_factura) REFERENCES factura(id_factura), -- creacion de clave foranea
    CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) -- creacion de clave foranea
);


CREATE TABLE usuarios(-- creacion de tabla usuarios
    id_usuarios NUMBER(5), -- campo de tipo numerico de longit 5 para el id de usuarios
    id_rol number(2), -- campo de tipo numerico de longitud 2 para asignar rol
    nombre_usuario VARCHAR2(10) -- campo de tipo cadena de caracteres para registrar el nombre del usuario
);

CREATE TABLE roles(
    id_rol NUMBER(3), -- campo de tipo numerico de longitud 3 para el id de rol
    nombre_rol VARCHAR2(15), -- campo de tipo cadena de caracteres de longitud 15 para el nombre del rol
    descripcion VARCHAR2(30) -- campo de tipo cadena de caracteres para la descripcion de rol
);


-- comienzo del ejercicio
-- Creacion de la tabla proveedores y sus campos

CREATE TABLE proveedores(
    id_proveedor NUMBER(5) PRIMARY KEY, -- clave primaria
    nombre_proveedor VARCHAR2(50), -- campo de tipo cadena de caracteres de longitud 50 para el nombre del proveedor
    telefono VARCHAR2(15), -- campo cadena de caracteres de longitud 15 para el telefono del proveedor
    email VARCHAR2(50), -- campo cadena de caracteres de longitud 50 para el email del proveedor
    direccion  VARCHAR2(100) -- campo cadena de caracteres para la direccion del proveedor
    
);

-- añadir columna id_proveedor en tabla producto:

ALTER TABLE producto ADD id_proveedor NUMBER(5);

-- creacion de clave foranea en tabla producto

ALTER TABLE producto ADD CONSTRAINT fk_proveedor FOREIGN KEY (id_proveedor) 
        REFERENCES proveedores(id_proveedor);
        
--Creacion de tabla auditoria_stock
CREATE TABLE auditoria_stock(
    id_auditoria NUMBER(5) PRIMARY KEY, -- clave primaria
    id_producto NUMBER(5), -- sera la clave foranea que apunta a producto
    fecha_cambio DATE, -- campo para registar la fecha de modificacion
    tipo_cambio VARCHAR2(10), -- especifica que tipo de cambio sera entrada o salida
    cantidad_cambiada NUMBER(5), -- unidades modificadas
    observaciones VARCHAR2(100), -- descripcion detallada del movimiento
    CONSTRAINT fk_producto_auditoria FOREIGN KEY (id_producto) 
        REFERENCES producto(id_producto),-- definicion de la clave foranea 
    CONSTRAINT chk_tipo_cambio_valores 
        CHECK (tipo_cambio IN ('Entrada','Salida'))-- definicion de los valores
);


-- insercion de datos de prueba proveedores
INSERT ALL 
    INTO proveedores (id_proveedor, nombre_proveedor, telefono, email, direccion) 
        VALUES(1, 'Coca Cola', 5986147852, 'grupo.cocacola@prueb.com', 'Ecatepec num 23 Av. Guerrero')
    INTO proveedores (id_proveedor, nombre_proveedor, telefono, email, direccion) 
        VALUES(2, 'Barcel', 5645781020, 'barcel.frituras@prueb.com', 'Nayarit num 33 Av. Las lomas')
    INTO proveedores (id_proveedor, nombre_proveedor, telefono, email, direccion) 
        VALUES(3, 'La Moderna', 5584102148, 'la_moderna@prueb.com', 'Toluca 12 Av. Constituyentes')
SELECT 1 FROM dual;

-- insercion de datos en tabla categoria
INSERT ALL 
    INTO categoria (id_categoria, nombre_cat, descripcion)
         VALUES(1, 'Refrescos', 'Bebidas gasificadas')
    INTO categoria (id_categoria, nombre_cat, descripcion)
         VALUES(2, 'Botanas', 'Antojos y snacks')
    INTO categoria (id_categoria, nombre_cat, descripcion)
         VALUES(3, 'Sopas', 'Pastas, consomes y potajes ')
SELECT 1 FROM dual;


-- insercion de datos en tabla producto 
INSERT ALL 
    INTO producto (id_producto, nombre_prod, precio_unit, stock, id_categori, id_proveedor)
         VALUES(1, 'Coca cola 600 ml', 12.50, 24, 1, 1)
    INTO producto (id_producto, nombre_prod, precio_unit, stock, id_categori, id_proveedor)
         VALUES(2, 'Papas fritas', 22.50, 30, 2, 2)
    INTO producto (id_producto, nombre_prod, precio_unit, stock, id_categori, id_proveedor)
         VALUES(3, 'Pasta maruchan', 10.36, 7, 3, 3)
SELECT 1 FROM dual;


-- insercion de datos en tabla auditoria stock
INSERT ALL 
    INTO auditoria_stock (id_auditoria, id_producto, fecha_cambio, tipo_cambio, cantidad_cambiada, observaciones)
         VALUES(1, 3, SYSDATE, 'Entrada', 7, 'ingreso de 7 unidades nuevas')
    INTO auditoria_stock (id_auditoria, id_producto, fecha_cambio, tipo_cambio, cantidad_cambiada, observaciones)
         VALUES(2, 2, SYSDATE, 'Entrada', 30, 'ingreso de 30 unidades nuevas')
    INTO auditoria_stock (id_auditoria, id_producto, fecha_cambio, tipo_cambio, cantidad_cambiada, observaciones)
         VALUES(3, 1, SYSDATE, 'Entrada', 24, 'ingreso de 24 unidades nuevas')
SELECT 1 FROM dual;

COMMIT;


-- Actividad 2 
-- Inserción, actualización y eliminación de datos en tablas

--1 insertar 3 registros en tabla proveedores:
INSERT ALL 
    INTO proveedores (id_proveedor, nombre_proveedor, telefono, email, direccion) 
        VALUES(4, 'Red Bull', 5886147852, 'energy_bull@prueb.com', 'Zcatecas num 03 Av. Madero')
    INTO proveedores (id_proveedor, nombre_proveedor, telefono, email, direccion) 
        VALUES(5, 'Herdez', 5545781020, 'suministros@prueb.com', 'Buenos Aires num 343 Av. Rio Bravo')
    INTO proveedores (id_proveedor, nombre_proveedor, telefono, email, direccion) 
        VALUES(6, 'Palmolive', 5784102148, 'medi_solutions@prueb.com', 'Coyoacan 155 Av. Constituyentes')
SELECT 1 FROM dual;


--2 Actualización de uno de los proveedores mediante consulta UPDATE:
UPDATE proveedores SET direccion = 'Jilotepec de Molina Enriquez 23 Av. Lazaro Cardenas' WHERE id_proveedor = 6;

--3 Eliminación de un proveedor basandose en id_proveedor:
DELETE FROM proveedores WHERE id_proveedor = 5;

-- 4 insertar 3 registros en auditoria_stock para simular entradas y salidas de inventario de productos
INSERT ALL 
    INTO auditoria_stock (id_auditoria, id_producto, fecha_cambio, tipo_cambio, cantidad_cambiada, observaciones)
         VALUES(4, 4, SYSDATE, 'Entrada', 12, 'ingreso de 11 unidades nuevas')
    INTO auditoria_stock (id_auditoria, id_producto, fecha_cambio, tipo_cambio, cantidad_cambiada, observaciones)
         VALUES(5, 4, SYSDATE, 'Salida', 5, 'Salida de 5 unidades caducadas')
    INTO auditoria_stock (id_auditoria, id_producto, fecha_cambio, tipo_cambio, cantidad_cambiada, observaciones)
         VALUES(6, 5, SYSDATE, 'Salida', 3, 'salida de 3 unidades vendidas')
SELECT 1 FROM dual;


--5 Actualizacion de un registro en auditoria_stock, cambiar campo observaciones.
UPDATE auditoria_stock SET observaciones = 'Descuento de temporada' WHERE id_auditoria = 4;


--6 utilizar DELETE para eliminar uno de los registros de auditoria_stock basandose en id_auditoria.
DELETE FROM auditoria_stock WHERE id_auditoria = 6;

COMMIT;


