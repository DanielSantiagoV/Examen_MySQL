-- Insertar especialidades
INSERT INTO especialidades (nombre_especialidad, descripcion) VALUES
('Medicina General', 'Atención médica general'),
('Cardiología', 'Especialidad del corazón'),
('Pediatría', 'Medicina infantil'),
('Traumatología', 'Huesos y articulaciones');

-- Insertar médicos
INSERT INTO medicos (nombre, apellidos, dni, telefono, email, tipo_medico, id_especialidad) VALUES
('Juan', 'García López', '12345678A', '600123456', 'juan.garcia@centro.es', 'titular', 1),
('María', 'Rodríguez Martín', '87654321B', '600654321', 'maria.rodriguez@centro.es', 'titular', 2),
('Pedro', 'Sánchez Ruiz', '11223344C', '600112233', 'pedro.sanchez@centro.es', 'interino', 3),
('Ana', 'Fernández López', '44332211D', '600443322', 'ana.fernandez@centro.es', 'sustituto', 1);

-- Insertar horarios de consulta
INSERT INTO horarios_consulta (id_medico, dia_semana, hora_inicio, hora_fin) VALUES
(1, 'lunes', '08:00:00', '14:00:00'),
(1, 'martes', '08:00:00', '14:00:00'),
(2, 'lunes', '15:00:00', '21:00:00'),
(2, 'miercoles', '08:00:00', '14:00:00'),
(3, 'jueves', '08:00:00', '14:00:00'),
(4, 'viernes', '15:00:00', '21:00:00');

-- Insertar empleados
INSERT INTO empleados (nombre, apellidos, dni, telefono, email, tipo_empleado) VALUES
('Carmen', 'López Díaz', '55667788E', '600556677', 'carmen.lopez@centro.es', 'ATS'),
('Luis', 'Martín Gómez', '99881122F', '600998811', 'luis.martin@centro.es', 'auxiliar_enfermeria'),
('Isabel', 'Ruiz Herrera', '77665544G', '600776655', 'isabel.ruiz@centro.es', 'celador'),
('Roberto', 'Jiménez Silva', '33445566H', '600334455', 'roberto.jimenez@centro.es', 'administrativo');

-- Insertar pacientes
INSERT INTO pacientes (nombre, apellidos, dni, fecha_nacimiento, telefono, direccion, id_medico_asignado) VALUES
('Antonio', 'Morales Castro', '66778899I', '1980-05-15', '600667788', 'Calle Mayor 1', 1),
('Lucía', 'Vega Romero', '11335577J', '1992-08-22', '600113355', 'Avenida Sol 25', 1),
('Francisco', 'Torres Blanco', '88994455K', '1975-12-03', '600889944', 'Plaza España 10', 2),
('Elena', 'Navarro Prieto', '22446688L', '1988-03-18', 'Calle Luna 5', 2);