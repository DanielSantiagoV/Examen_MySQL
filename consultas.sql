-- ====================================================================
-- CONSULTAS SQL FUNCIONALES PARA BASE DE DATOS CENTRO DE SALUD
-- ====================================================================

USE centro_salud;

-- CONSULTA 1: Número de pacientes atendidos por cada médico
SELECT 
    m.id_medico,
    CONCAT(m.nombre, ' ', m.apellidos) AS medico,
    e.nombre_especialidad,
    COUNT(p.id_paciente) AS total_pacientes
FROM medicos m
LEFT JOIN pacientes p ON m.id_medico = p.id_medico_asignado
LEFT JOIN especialidades e ON m.id_especialidad = e.id_especialidad
GROUP BY m.id_medico, m.nombre, m.apellidos, e.nombre_especialidad
ORDER BY total_pacientes DESC;

-- CONSULTA 2: Total de días de vacaciones planificadas y disfrutadas por cada empleado
SELECT 
    e.id_empleado,
    CONCAT(e.nombre, ' ', e.apellidos) AS empleado,
    e.tipo_empleado,
    COALESCE(SUM(CASE WHEN v.estado = 'planificada' THEN v.dias_totales ELSE 0 END), 0) AS dias_planificadas,
    COALESCE(SUM(CASE WHEN v.estado = 'disfrutada' THEN v.dias_totales ELSE 0 END), 0) AS dias_disfrutadas,
    COALESCE(SUM(v.dias_totales), 0) AS total_dias_vacaciones
FROM empleados e
LEFT JOIN vacaciones_empleados v ON e.id_empleado = v.id_empleado
GROUP BY e.id_empleado, e.nombre, e.apellidos, e.tipo_empleado
ORDER BY total_dias_vacaciones DESC;

-- CONSULTA 3: Médicos con mayor cantidad de horas de consulta en la semana
SELECT 
    m.id_medico,
    CONCAT(m.nombre, ' ', m.apellidos) AS medico,
    m.tipo_medico,
    e.nombre_especialidad,
    COUNT(h.id_horario) AS dias_consulta,
    ROUND(SUM(TIME_TO_SEC(TIMEDIFF(h.hora_fin, h.hora_inicio))/3600), 2) AS horas_semanales
FROM medicos m
LEFT JOIN horarios_consulta h ON m.id_medico = h.id_medico
LEFT JOIN especialidades e ON m.id_especialidad = e.id_especialidad
GROUP BY m.id_medico, m.nombre, m.apellidos, m.tipo_medico, e.nombre_especialidad
HAVING horas_semanales > 0
ORDER BY horas_semanales DESC;

-- CONSULTA 4: Número de sustituciones realizadas por cada médico sustituto
SELECT 
    m.id_medico,
    CONCAT(m.nombre, ' ', m.apellidos) AS medico_sustituto,
    e.nombre_especialidad,
    COUNT(s.id_sustitucion) AS total_sustituciones,
    COUNT(CASE WHEN s.activa = TRUE THEN 1 END) AS sustituciones_activas,
    COUNT(CASE WHEN s.activa = FALSE THEN 1 END) AS sustituciones_finalizadas
FROM medicos m
LEFT JOIN sustituciones s ON m.id_medico = s.id_medico_sustituto
LEFT JOIN especialidades e ON m.id_especialidad = e.id_especialidad
WHERE m.tipo_medico = 'sustituto'
GROUP BY m.id_medico, m.nombre, m.apellidos, e.nombre_especialidad
ORDER BY total_sustituciones DESC;

-- CONSULTA 5: Número de médicos que están actualmente en sustitución
SELECT 
    'Médicos en sustitución activa' AS descripcion,
    COUNT(DISTINCT s.id_medico_sustituto) AS medicos_sustituyendo,
    COUNT(DISTINCT s.id_medico_titular) AS medicos_siendo_sustituidos,
    COUNT(s.id_sustitucion) AS total_sustituciones_activas
FROM sustituciones s
WHERE s.activa = TRUE 
    AND s.fecha_inicio <= CURDATE() 
    AND (s.fecha_fin IS NULL OR s.fecha_fin >= CURDATE());

-- CONSULTA 6: Horas totales de consulta por médico por día de la semana
SELECT 
    m.id_medico,
    CONCAT(m.nombre, ' ', m.apellidos) AS medico,
    h.dia_semana,
    h.hora_inicio,
    h.hora_fin,
    ROUND(TIME_TO_SEC(TIMEDIFF(h.hora_fin, h.hora_inicio))/3600, 2) AS horas_dia
FROM medicos m
JOIN horarios_consulta h ON m.id_medico = h.id_medico
ORDER BY m.id_medico, 
    FIELD(h.dia_semana, 'lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo');

