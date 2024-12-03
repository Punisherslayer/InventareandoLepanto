-- Crear base de datos
CREATE DATABASE IF NOT EXISTS inventareandolepanto;

-- Usar la base de datos
USE inventareandolepanto;

-- Tabla de Tipos de Usuarios
CREATE TABLE IF NOT EXISTS TiposUsuarios (
    id_tipo_usuario INT AUTO_INCREMENT PRIMARY KEY,
    tipo_usuario ENUM('Informática', 'Mecánica', 'Biblioteca') NOT NULL,
    INDEX (tipo_usuario)
);

-- Tabla de Tipos de Ubicación
CREATE TABLE IF NOT EXISTS Tipos_Ubicacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_ubicacion ENUM('Informática', 'Mecánica', 'Biblioteca') NOT NULL
);

-- Tabla de Roles (Tic = informática, Mec = Mecanica, Blica = Biblioteca)
CREATE TABLE IF NOT EXISTS Roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    rol ENUM('adminTic', 'tecnicoTic', 'usuarioTic', 'adminMec', 'tecnicoMec', 'usuarioMec', 'adminBlic', 'usuarioBlic') NOT NULL,
    INDEX (rol)
);

-- Actualización en la tabla de Ubicaciones
CREATE TABLE IF NOT EXISTS Ubicaciones (
    id_ubicacion INT AUTO_INCREMENT PRIMARY KEY,
    nombre_ubicacion VARCHAR(100) NOT NULL UNIQUE,
    departamento_responsable VARCHAR(50),
    id_tipo_ubicacion INT,
    FOREIGN KEY (id_tipo_ubicacion) REFERENCES Tipos_Ubicacion(id),
    INDEX (nombre_ubicacion)
);

-- Tabla de Usuarios
CREATE TABLE IF NOT EXISTS Usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, 
    id_tipo_usuario INT,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_tipo_usuario) REFERENCES TiposUsuarios(id_tipo_usuario),
    INDEX (username),
    INDEX (email)
);

-- Tabla de Roles de Usuarios (intermedia para permitir múltiples roles por usuario)
CREATE TABLE IF NOT EXISTS RolesUsuarios (
    id_usuario INT,
    id_rol INT,
    fecha_asignacion DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Agregar fecha de asignación
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id),
    FOREIGN KEY (id_rol) REFERENCES Roles(id_rol)
);

-- Tabla de Equipos
CREATE TABLE IF NOT EXISTS Equipos (
    id_equipo INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('PC', 'Laptop', 'Impresora', 'Otro') NOT NULL,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    sistema_operativo ENUM('Windows', 'Linux', 'macOS', 'Otro') NOT NULL,
    id_ubicacion INT,
    estado ENUM('activo', 'en reparación', 'obsoleto') NOT NULL,
    FOREIGN KEY (id_ubicacion) REFERENCES Ubicaciones(id_ubicacion),
    INDEX (id_ubicacion),
    INDEX (tipo),
    INDEX (estado)
);

-- Tabla de Componentes
CREATE TABLE IF NOT EXISTS Componentes (
    id_componente INT AUTO_INCREMENT PRIMARY KEY,
    tipo_componente ENUM('Procesador', 'RAM', 'Disco_Duro', 'Tarjeta_Grafica', 'Fuente_Alimentacion', 'Otro') NOT NULL,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    especificaciones TEXT,
    estado ENUM('disponible', 'en uso', 'en reparación', 'desechado') NOT NULL,
    id_equipo INT,
    FOREIGN KEY (id_equipo) REFERENCES Equipos(id_equipo),
    INDEX (id_equipo),
    INDEX (estado)
);

-- Tabla de Software
CREATE TABLE Software (
    id_software INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    version VARCHAR(20) NOT NULL,
    fecha_vencimiento DATE,
    detalles_licencia VARCHAR(100) NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    id_equipo INT,
    FOREIGN KEY (id_equipo) REFERENCES Equipos(id_equipo),
    INDEX (nombre),
    INDEX (version),
    INDEX (id_equipo)
);

-- Tabla de Incidencias
CREATE TABLE IF NOT EXISTS Incidencias (
    id_incidencia INT AUTO_INCREMENT PRIMARY KEY,
    descripcion_incidencia VARCHAR(200) NOT NULL,
    fecha_reporte DATETIME NOT NULL,
    estado ENUM('abierta', 'en progreso', 'cerrada', 'cancelada') DEFAULT 'abierta',
    prioridad ENUM('baja', 'media', 'alta') DEFAULT 'media',
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id),
    INDEX (id_usuario),
    INDEX (estado),
    INDEX (prioridad)
);

-- Tabla de Mantenimiento de Equipos
CREATE TABLE IF NOT EXISTS MantenimientoEquipos (
    id_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('preventivo', 'correctivo') NOT NULL,
    descripcion_mantenimiento TEXT NOT NULL,
    fecha_mantenimiento DATETIME NOT NULL,
    id_incidencia INT,
    id_equipo INT,
    estado ENUM('completado', 'pendiente', 'cancelado') DEFAULT 'pendiente',
    FOREIGN KEY (id_incidencia) REFERENCES Incidencias(id_incidencia),
    FOREIGN KEY (id_equipo) REFERENCES Equipos(id_equipo),
    INDEX (id_equipo),
    INDEX (estado)
);

-- Tabla de Mantenimiento de Componentes de Equipos
CREATE TABLE IF NOT EXISTS MantenimientoComponentes (
    id_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('preventivo', 'correctivo') NOT NULL,
    descripcion_mantenimiento TEXT NOT NULL,
    fecha_mantenimiento DATETIME NOT NULL,
    id_incidencia INT,
    id_componente INT,
    estado ENUM('completado', 'pendiente', 'cancelado') DEFAULT 'pendiente',
    FOREIGN KEY (id_incidencia) REFERENCES Incidencias(id_incidencia),
    FOREIGN KEY (id_componente) REFERENCES Componentes(id_componente),
    INDEX (id_componente),
    INDEX (estado)
);

-- Tabla de Coches
CREATE TABLE IF NOT EXISTS Coches (
    id_coche INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(100) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    año INT NOT NULL,
    estado ENUM('activo', 'en reparación', 'obsoleto') DEFAULT 'activo',
    descripcion TEXT,
    INDEX (marca),
    INDEX (modelo),
    INDEX (estado)
);

-- Tabla de Incidencias para Coches
CREATE TABLE IF NOT EXISTS IncidenciasCoche (
    id_incidencia INT AUTO_INCREMENT PRIMARY KEY,
    descripcion_incidencia VARCHAR(200) NOT NULL,
    fecha_reporte DATETIME NOT NULL,
    estado ENUM('abierta', 'en progreso', 'cerrada', 'cancelada') DEFAULT 'abierta',
    prioridad ENUM('baja', 'media', 'alta') DEFAULT 'media',
    id_coche INT,
    id_usuario INT,
    FOREIGN KEY (id_coche) REFERENCES Coches(id_coche),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id),
    INDEX (id_coche),
    INDEX (id_usuario),
    INDEX (estado),
    INDEX (prioridad)
);

-- Tabla de Mantenimiento de Coches
CREATE TABLE IF NOT EXISTS MantenimientoCoche (
    id_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('preventivo', 'correctivo') NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_mantenimiento DATETIME NOT NULL,
    id_coche INT,
    estado ENUM('completado', 'pendiente', 'cancelado') DEFAULT 'pendiente',
    FOREIGN KEY (id_coche) REFERENCES Coches(id_coche),
    INDEX (estado)
);

-- Tabla de Bibliotecas
CREATE TABLE IF NOT EXISTS Bibliotecas (
    id_biblioteca INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    horario_apertura VARCHAR(100),
    descripcion TEXT,
    INDEX (nombre),
    INDEX (direccion)
);

-- Tabla de Libros
CREATE TABLE IF NOT EXISTS Libros (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    fecha_publicacion DATE,
    isbn VARCHAR(50) UNIQUE NOT NULL,
    disponibilidad BOOLEAN DEFAULT TRUE,
    INDEX (isbn)
);

-- Tabla de Préstamos
CREATE TABLE IF NOT EXISTS Prestamos (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    id_libro INT,
    id_usuario INT,
    fecha_prestamo DATETIME NOT NULL,
    fecha_devolucion DATE,
    estado ENUM('Activo', 'Devuelto', 'Vencido') DEFAULT 'Activo',
    FOREIGN KEY (id_libro) REFERENCES Libros(id_libro) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) ON DELETE CASCADE,
    INDEX (id_libro),
    INDEX (id_usuario),
    INDEX (estado)
);

-- Tabla de Mensajes
CREATE TABLE IF NOT EXISTS Mensajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    mensaje TEXT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) ON DELETE CASCADE,
    INDEX (id_usuario),
    INDEX (fecha)
);

-- Tabla de Historial de Fechas
CREATE TABLE IF NOT EXISTS HistorialFechas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) ON DELETE CASCADE,
    INDEX (id_usuario)
);

-- Tabla de Accesos a Bibliotecas (para gestionar qué usuarios tienen acceso a qué biblioteca)
CREATE TABLE IF NOT EXISTS AccesosBiblioteca (
    id_usuario INT,
    id_biblioteca INT,
    fecha_asignacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_usuario, id_biblioteca),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (id_biblioteca) REFERENCES Bibliotecas(id_biblioteca) ON DELETE CASCADE
);
