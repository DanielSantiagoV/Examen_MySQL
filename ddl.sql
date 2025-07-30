-- Crear base de datos
CREATE DATABASE centro_salud;
USE centro_salud;

-- Tabla de especialidades médicas
CREATE TABLE especialidades (
    id_especialidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre_especialidad VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- Tabla de médicos
CREATE TABLE medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(100),
    tipo_medico ENUM('titular', 'interino', 'sustituto') NOT NULL,
    id_especialidad INT,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_especialidad) REFERENCES especialidades(id_especialidad)
);

-- Tabla de horarios de consulta
CREATE TABLE horarios_consulta (
    id_horario INT AUTO_INCREMENT PRIMARY KEY,
    id_medico INT,
    dia_semana ENUM('lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo') NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);

-- Tabla de empleados
CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(100),
    tipo_empleado ENUM('ATS', 'auxiliar_enfermeria', 'celador', 'administrativo') NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de pacientes
CREATE TABLE pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(15),
    direccion TEXT,
    id_medico_asignado INT,
    FOREIGN KEY (id_medico_asignado) REFERENCES medicos(id_medico)
);

-- Tabla de sustituciones
CREATE TABLE sustituciones (
    id_sustitucion INT AUTO_INCREMENT PRIMARY KEY,
    id_medico_titular INT,
    id_medico_sustituto INT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    motivo VARCHAR(200),
    activa BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_medico_titular) REFERENCES medicos(id_medico),
    FOREIGN KEY (id_medico_sustituto) REFERENCES medicos(id_medico)
);

-- Tabla de vacaciones para médicos
CREATE TABLE vacaciones_medicos (
    id_vacacion INT AUTO_INCREMENT PRIMARY KEY,
    id_medico INT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    dias_totales INT NOT NULL,
    estado ENUM('planificada', 'disfrutada', 'cancelada') DEFAULT 'planificada',
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);

-- Tabla de vacaciones para empleados
CREATE TABLE vacaciones_empleados (
    id_vacacion INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    dias_totales INT NOT NULL,
    estado ENUM('planificada', 'disfrutada', 'cancelada') DEFAULT 'planificada',
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);