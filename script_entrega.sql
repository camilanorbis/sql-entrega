CREATE SCHEMA automotora;
USE automotora;

CREATE TABLE Cliente (
	id_cliente int NOT NULL,
    cedula int UNIQUE NOT NULL,
    nombre varchar(50) NOT NULL,
    apellido varchar(50) NOT NULL,
    fecha_nac date NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY(id_cliente)
);

CREATE TABLE Empleado (
	id_empleado int NOT NULL,
    nombre varchar(50) NOT NULL,
    apellido varchar(50) NOT NULL,
    fecha_ingreso date NOT NULL,
    salario int NOT NULL,
    CONSTRAINT pk_empleado PRIMARY KEY(id_empleado)
);

CREATE TABLE Vehiculo (
	id_vehiculo int NOT NULL,
    matricula varchar(50) UNIQUE NOT NULL,
    nro_chasis int UNIQUE NOT NULL,
    tipo varchar(50) NOT NULL,
    marca varchar(50) NOT NULL,
    modelo varchar(50) NOT NULL,
    estado varchar(50) NOT NULL,
    CONSTRAINT pk_vehiculo PRIMARY KEY(id_vehiculo)
);

CREATE TABLE CompraVenta (
	id_venta int NOT NULL,
    fecha_venta date NOT NULL,
    precio_venta int NOT NULL,
    forma_pago varchar(50) NOT NULL,
    titulo_entregado boolean NOT NULL,
    id_cliente int NOT NULL,
    id_empleado int NOT NULL,
    id_vehiculo int NOT NULL,
    CONSTRAINT pk_compraventa PRIMARY KEY(id_venta),
    CONSTRAINT fk_compraventa_cliente FOREIGN KEY(id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_compraventa_empleado FOREIGN KEY(id_empleado) REFERENCES Empleado(id_empleado),
    CONSTRAINT fk_compraventa_vehiculo FOREIGN KEY(id_vehiculo) REFERENCES Vehiculo(id_vehiculo)
); 

CREATE TABLE Cuota (
	id_cuota int NOT NULL,
    nro_cuota int NOT NULL,
    monto int NOT NULL,
    fecha_vencimiento date NOT NULL,
    fecha_pago date NOT NULL,
    estado varchar(50) NOT NULL,
    id_venta int NOT NULL,
    CONSTRAINT pk_cuota PRIMARY KEY(id_cuota),
    CONSTRAINT fk_cuota_venta FOREIGN KEY(id_venta) REFERENCES CompraVenta(id_venta)
);

CREATE TABLE Seguro (
	id_seguro int NOT NULL,
    nro_poliza varchar(50) UNIQUE NOT NULL,
    titular varchar(100) NOT NULL,
    matricula varchar(50) UNIQUE NOT NULL,
    vigencia date NOT NULL,
    aseguradora varchar(50) NOT NULL,
    id_vehiculo int UNIQUE NOT NULL,
    CONSTRAINT pk_seguro PRIMARY KEY(id_seguro),
    CONSTRAINT fk_seguro_vehiculo FOREIGN KEY(id_vehiculo) REFERENCES Vehiculo(id_vehiculo)
);

CREATE TABLE Gasto (
	id_gasto int NOT NULL,
    descripcion varchar(200) NOT NULL,
    monto int NOT NULL,
    fecha date NOT NULL,
    id_vehiculo int NOT NULL,
    CONSTRAINT pk_gasto PRIMARY KEY(id_gasto),
    CONSTRAINT fk_gasto_vehiculo FOREIGN KEY(id_vehiculo) REFERENCES Vehiculo(id_vehiculo)
);