-- BDABC_Electrodomesticos
--Grupo: La Secta del Profe Hugo 
--fecha: 21/2/25

use master 
go

if DB_ID('BDABC_Electrodomesticos') is not null
  drop database BDABC_Electrodomesticos
go

create database BDABC_Electrodomesticos
go

use BDABC_Electrodomesticos
go

IF OBJECT_ID('Proveedor','U') IS NOT NULL
  drop table Proveedor
go

-- tabla de proveedores
create table Proveedor 
(
    idProve char(9) primary key,
    nombreProve varchar(50) not null,
    contactoProve varchar(50) not null,
    direccionProve varchar(50),
    telefonoProve char(10) not null,
	emailProve nvarchar (50)
)
go

IF OBJECT_ID('electrodomesticos','U') IS NOT NULL
  drop table electrodomesticos
go
-- tabla de electrodomésticos
create table electrodomesticos 
(
    idElectro char(9) primary key,
    nombreElectro varchar(50) not null,
    descripcionElectro varchar(50),
    marcaElectro varchar(50),
    precioCompraElectro decimal(8,2) not null,
    precioVentaElectro decimal(8,2) not null
)
go

IF OBJECT_ID('OrdenCompra','U') IS NOT NULL
  drop table OrdenCompra
go

-- tabla de órdenes de compra
create table OrdenCompra 
(
    idOrdComp char(9) primary key,
    fechaOrdComp datetime not null,
    horaOrdComp time,
    montoTOrdComp decimal(8,2) not null,
	idProve char(9),
    foreign key (idProve) references Proveedor(idProve)
)
go

IF OBJECT_ID('DetalleEntradaSalida','U') IS NOT NULL
  drop table DetalleEntradaSalida
go

-- tabla de detalle de entrada/salida
create table DetalleEntradaSalida
(
    idDetalleES char(9) primary key,
    idElectro char(9),
    idOrdComp char (9),
    cantidadDetalleES int,
    subtotalDetalleES decimal(8,2),
    foreign key (idElectro) references electrodomesticos(idElectro),
    foreign key (idOrdComp) references OrdenCompra(idOrdComp)
)
go

IF OBJECT_ID('Cliente','U') IS NOT NULL
  drop table Cliente
go

-- tabla de clientes
create table Cliente 
(
    idCliente char(9) primary key,
    nombreC varchar(50) not null,
    tipoDocumC varchar(50),
    dniC char(10),
	direccionC varchar(50),
	telefonoC char(9),
	emailC nvarchar(50),
)
go

IF OBJECT_ID('Comprobante','U') IS NOT NULL
  drop table Comprobante
go

-- tabla de comprobantes de venta
create table Comprobante 
(
    idComprobante char(9) primary key,
    idCliente char(9) not null,
    fechaComp datetime,
	montoTotalComp decimal(8,2),
    foreign key (idCliente) references Cliente(idCliente),
)
go

IF OBJECT_ID('DetalleComprobante','U') IS NOT NULL
  drop table DetalleComprobante
go

-- tabla de detalle de comprobante
create table DetalleComprobante
(
    idDetalleComp char(9) primary key,
    cantidadDetalleComp int,
    precioVentaDetalleComp decimal(8,2),
    subTotalDetalleComp decimal(8,2),
	idDetalleES char(9),
	idComprobante char(9),
	foreign key (idComprobante) references Comprobante(idComprobante),
    foreign key (idDetalleES) references DetalleEntradaSalida(idDetalleES)
)
 go