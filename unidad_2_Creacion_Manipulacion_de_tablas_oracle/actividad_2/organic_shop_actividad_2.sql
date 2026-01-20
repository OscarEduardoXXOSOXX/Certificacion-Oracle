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


