/*
Created		19/07/2022
Modified		19/08/2022
Project		
Model		
Company		
Author		
Version		
Database		mySQL 5 
*/


drop table IF EXISTS distribucionasientos;
drop table IF EXISTS disponibilidadasientos;
drop table IF EXISTS disponibilidad;
drop table IF EXISTS factorpaqueteria;
drop table IF EXISTS tipopaquetes;
drop table IF EXISTS boletoscancelados;
drop table IF EXISTS tarjetasboletinadas;
drop table IF EXISTS promocionesdetalle;
drop table IF EXISTS terminales;
drop table IF EXISTS promociones;
drop table IF EXISTS familiares;
drop table IF EXISTS descuentos;
drop table IF EXISTS tipopasajero;
drop table IF EXISTS trarifastramos;
drop table IF EXISTS ventapago;
drop table IF EXISTS formapagosubtipo;
drop table IF EXISTS formaspago;
drop table IF EXISTS tipoventa;
drop table IF EXISTS ventascliente;
drop table IF EXISTS Clientes;
drop table IF EXISTS venta;
drop table IF EXISTS boletosvendidos;
drop table IF EXISTS tiposboletos;
drop table IF EXISTS boletosdisponibles;
drop table IF EXISTS sesiones;
drop table IF EXISTS registropasopuntos;
drop table IF EXISTS corridasdisponibles;
drop table IF EXISTS itinerario;
drop table IF EXISTS tiposervicio;
drop table IF EXISTS tramos;
drop table IF EXISTS oficinas;
drop table IF EXISTS corridasprogramadas;
drop table IF EXISTS autobusconductor;
drop table IF EXISTS autobuses;
drop table IF EXISTS conductores;
drop table IF EXISTS personas;


Create table personas (
	nNumeroPersona Int UNSIGNED NOT NULL AUTO_INCREMENT,
	aNombres Varchar(30) NOT NULL,
	aApellidos Varchar(30) NOT NULL,
	nOficina Int UNSIGNED NOT NULL,
	aTipo Varchar(2) NOT NULL,
	UNIQUE (nNumeroPersona),
 Primary Key (nNumeroPersona)) ;

Create table conductores (
	nNumeroConductor Int UNSIGNED NOT NULL AUTO_INCREMENT,
	nNumeroPersona Int UNSIGNED NOT NULL,
	aLicencia Varbinary(20) NOT NULL,
	fVigenciaLicencia Date NOT NULL,
	aEstado Varchar(2) NOT NULL,
	nNumeroAutobus Int,
	UNIQUE (nNumeroConductor),
 Primary Key (nNumeroConductor)) ;

Create table autobuses (
	nNumeroAutobus Int NOT NULL AUTO_INCREMENT,
	nNumeroEconomico Varchar(6) NOT NULL,
	nTipoServicio Int UNSIGNED NOT NULL,
	nDistribucionAsientos Int UNSIGNED NOT NULL,
	UNIQUE (nNumeroAutobus),
	UNIQUE (nNumeroEconomico),
 Primary Key (nNumeroAutobus)) ;

Create table autobusconductor (
	nNumeroConductor Int UNSIGNED NOT NULL,
	nNumeroAutobus Int NOT NULL,
 Primary Key (nNumeroConductor,nNumeroAutobus)) ;

Create table corridasprogramadas (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	nItinerario Int UNSIGNED NOT NULL,
	nTipoServicio Int UNSIGNED NOT NULL,
	hSalida Time NOT NULL,
	lLunes Bool NOT NULL,
	lMartes Bool NOT NULL,
	lMiercoles Bool NOT NULL,
	lJueves Bool NOT NULL,
	lViernes Bool NOT NULL,
	lSabado Bool NOT NULL,
	lDomingo Bool NOT NULL,
	fInicio Date NOT NULL,
	fFin Date NOT NULL,
	lBaja Bool NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table oficinas (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	aClave Varchar(5) NOT NULL,
	aNombre Varchar(15) NOT NULL,
	aTipo Varchar(3) NOT NULL,
	lDestino Bool NOT NULL,
	UNIQUE (nNumero),
	UNIQUE (aClave),
 Primary Key (nNumero)) ;

Create table tramos (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	nOrigen Int UNSIGNED NOT NULL,
	nDestino Int UNSIGNED NOT NULL,
	nKilometros Int NOT NULL,
	nTiempo Int NOT NULL,
	nEstancia Int NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table tiposervicio (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	aClave Char(2) NOT NULL,
	aDescripcion Varchar(20) NOT NULL,
	nDistribucionAsientos Int UNSIGNED NOT NULL,
	UNIQUE (nNumero),
	UNIQUE (aClave),
 Primary Key (nNumero)) ;

Create table itinerario (
	nItinerario Int UNSIGNED NOT NULL AUTO_INCREMENT,
	nConsecutivo Int NOT NULL,
	nTramo Int UNSIGNED NOT NULL,
 unique xItinerario (nItinerario),
 Primary Key (nItinerario)) ;

Create table corridasdisponibles (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	nProgramada Int UNSIGNED NOT NULL,
	nItinerario Int UNSIGNED NOT NULL,
	nTipoServicio Int UNSIGNED NOT NULL,
	fSalida Date NOT NULL,
	hSalida Time NOT NULL,
	aEstado Varchar(1) NOT NULL,
	nNumeroAutobus Int NOT NULL,
	nNumeroConductor Int UNSIGNED NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table registropasopuntos (
	nNumero Int UNSIGNED NOT NULL,
	nItinerario Int UNSIGNED NOT NULL,
	fLlegada Datetime NOT NULL,
	fSalida Datetime NOT NULL,
 Primary Key (nNumero,nItinerario)) ;

Create table sesiones (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	nNumeroPersona Int UNSIGNED NOT NULL,
	nOficina Int UNSIGNED NOT NULL,
	fContable Date NOT NULL COMMENT 'Es la fecha contable a la que pertenece la sesion',
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table boletosdisponibles (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	nTipoBoleto Int UNSIGNED NOT NULL,
	aSerie Varchar(5) NOT NULL,
	nFolioInicial Int NOT NULL,
	nFolioFinal Int NOT NULL,
	nOficina Int UNSIGNED NOT NULL,
	nNumeroPersona Int UNSIGNED NOT NULL,
	lActivo Bool NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table tiposboletos (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	aTipo Varbinary(1) NOT NULL,
	aDescripcion Varchar(20) NOT NULL,
	nCantidad Smallint UNSIGNED NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table boletosvendidos (
	nNumero Bigint UNSIGNED NOT NULL AUTO_INCREMENT,
	nVenta Int UNSIGNED NOT NULL,
	nCorrida Int UNSIGNED NOT NULL,
	fSalida Date NOT NULL,
	hSalida Time NOT NULL,
	nOrigen Int UNSIGNED NOT NULL,
	nDestino Int UNSIGNED NOT NULL,
	aTipoPasajero Varchar(2) NOT NULL,
	nTipoPaquete Int UNSIGNED NOT NULL,
	nFactorPaqueteria Int UNSIGNED NOT NULL,
	aPasajero Text NOT NULL,
	nAsiento Char(20) NOT NULL,
	aTipoVenta Varchar(4) NOT NULL,
	nDescuento Int UNSIGNED NOT NULL,
	nPromocion Int UNSIGNED NOT NULL,
	nMontoBase Decimal(6,2) NOT NULL,
	nMontoDescuento Decimal(6,2) NOT NULL,
	nIVA Decimal(6,2) NOT NULL,
	aEstado Char(20) NOT NULL,
	fCreacion Datetime NOT NULL,
	nTerminal Int UNSIGNED NOT NULL,
	UNIQUE (nNumero),
	UNIQUE (nVenta),
 Primary Key (nNumero)) ;

Create table venta (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	nSesion Int UNSIGNED NOT NULL,
	fCreacion Datetime NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table Clientes (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	aNombre Text NOT NULL,
	aTelefono Varchar(20) NOT NULL,
	aCorreo Varbinary(100) NOT NULL,
	aRFC Varchar(20) NOT NULL,
	nDescuento Decimal(4,2) NOT NULL,
	aRazonSocial Varchar(100) NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table ventascliente (
	nVenta Int UNSIGNED NOT NULL,
	nCliente Int UNSIGNED NOT NULL,
 Primary Key (nVenta,nCliente)) ;

Create table tipoventa (
	aClave Varchar(4) NOT NULL,
	aDescripcion Text NOT NULL,
	ntipoboleto Int UNSIGNED NOT NULL,
	UNIQUE (aClave),
 Primary Key (aClave)) 
COMMENT = 'CO = Boleto Confirmado
AB = Boleto Abierto
MA = Boleto Manual
PC = Paqueteria Comercial
PI = Paqueteria Interna
EE = Exceso equipaje
GE = Guarda equipaje
BI = Boleto Internet
BA = Boleto Agencia
BW = Boleto WebServices
AP = Abono Paqueteria';

Create table formaspago (
	aClave Varchar(2) NOT NULL,
	aDescripcion Varchar(15) NOT NULL,
	UNIQUE (aClave),
 Primary Key (aClave)) ;

Create table formapagosubtipo (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	aClave Varchar(2) NOT NULL,
	aDescripcion Varbinary(20) NOT NULL,
	lPedirFolio Bool NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table ventapago (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	nVenta Int UNSIGNED NOT NULL,
	aFormaPago Varchar(2) NOT NULL,
	nFormaPagoSubtipo Int UNSIGNED NOT NULL,
	nMonto Decimal(7,2) NOT NULL,
	fCreacion Datetime NOT NULL,
	aFolioDocumento Varchar(20) NOT NULL,
	aAutorizacionBanco Varchar(10) NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table trarifastramos (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	nTipoServicio Int UNSIGNED NOT NULL,
	nOrigen Int UNSIGNED NOT NULL,
	nDestino Int UNSIGNED NOT NULL,
	nMontoBaseRuta Decimal(6,2) NOT NULL,
	nMontoBasePaqueteria Decimal(6,2) NOT NULL,
	nIVA Decimal(6,2) NOT NULL,
	fAplicacion Date NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table tipopasajero (
	aClave Varchar(2) NOT NULL,
	aDescripcion Varchar(15) NOT NULL,
	nDescuento Decimal(3,2) NOT NULL,
	UNIQUE (aClave),
 Primary Key (aClave)) ;

Create table descuentos (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	aClaveConfirmacion Varchar(4) NOT NULL,
	fInicio Date NOT NULL,
	fFin Date NOT NULL,
	nOrigen Int UNSIGNED NOT NULL,
	nDestino Int UNSIGNED NOT NULL,
	fCreacion Date NOT NULL,
	dDescuento Smallint NOT NULL,
	nPasajero Int UNSIGNED NOT NULL,
	nSolicita Int UNSIGNED NOT NULL,
	nOtorga Int UNSIGNED NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table familiares (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	nEmpleado Int UNSIGNED NOT NULL,
	nFamiliar Int UNSIGNED NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table promociones (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	aTipo Char(2) NOT NULL,
	aDescripcion Varchar(20) NOT NULL,
	nMaximos Char(20) NOT NULL COMMENT 'N�mero m�ximo de descuentos por corrida',
	nDescuento Smallint NOT NULL,
	fInicio Date NOT NULL,
	fFin Date NOT NULL,
	fCreacion Date NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table terminales (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	aTerminal Varchar(20) NOT NULL,
	nOficina Int UNSIGNED NOT NULL,
	aDescripcion Varchar(15) NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table promocionesdetalle (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	nPromocion Int UNSIGNED NOT NULL,
	nTerminal Int UNSIGNED NOT NULL,
	nOrigen Int UNSIGNED NOT NULL,
	nDestino Int UNSIGNED NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table tarjetasboletinadas (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	aNumeroTarjeta Varchar(16) NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table boletoscancelados (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	nBoletoVendido Bigint UNSIGNED NOT NULL,
	nBoletoNuevo Bigint UNSIGNED NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table tipopaquetes (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	aTipo Varchar(2) NOT NULL,
	aDescripcioin Varchar(15) NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table factorpaqueteria (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	aTipo Varchar(1) NOT NULL,
	nValorMaximo Decimal(6,2) NOT NULL,
	nFactor Decimal(3,2) NOT NULL,
	fAplicacion Date NOT NULL,
	fCreacion Datetime NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table disponibilidad (
	nNumero Bigint UNSIGNED NOT NULL AUTO_INCREMENT,
	nCorridaDisponible Int UNSIGNED NOT NULL,
	nOrigen Int UNSIGNED NOT NULL,
	nDestino Int UNSIGNED NOT NULL,
	fLlegada Date NOT NULL,
	hLlegada Time NOT NULL,
	fSalida Date NOT NULL,
	hSalida Time NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;

Create table disponibilidadasientos (
	nDisponibilidad Bigint UNSIGNED NOT NULL,
	nAsiento Smallint NOT NULL,
	aEstadoAsiento Char(20) NOT NULL) ;

Create table distribucionasientos (
	nNumero Int UNSIGNED NOT NULL AUTO_INCREMENT,
	nAsientos Smallint NOT NULL,
	aDistribucion Text NOT NULL,
	UNIQUE (nNumero),
 Primary Key (nNumero)) ;


Alter table autobuses add unique xNumeroEconomico (nNumeroEconomico,nNumeroAutobus);


Alter table conductores add Foreign Key (nNumeroPersona) references personas (nNumeroPersona) on delete  restrict on update  restrict;
Alter table sesiones add Foreign Key (nNumeroPersona) references personas (nNumeroPersona) on delete  restrict on update  restrict;
Alter table boletosdisponibles add Foreign Key (nNumeroPersona) references personas (nNumeroPersona) on delete  restrict on update  restrict;
Alter table descuentos add Foreign Key (nSolicita) references personas (nNumeroPersona) on delete  restrict on update  restrict;
Alter table familiares add Foreign Key (nFamiliar) references personas (nNumeroPersona) on delete  restrict on update  restrict;
Alter table familiares add Foreign Key (nEmpleado) references personas (nNumeroPersona) on delete  restrict on update  restrict;
Alter table descuentos add Foreign Key (nOtorga) references personas (nNumeroPersona) on delete  restrict on update  restrict;
Alter table descuentos add Foreign Key (nPasajero) references personas (nNumeroPersona) on delete  restrict on update  restrict;
Alter table autobusconductor add Foreign Key (nNumeroConductor) references conductores (nNumeroConductor) on delete  restrict on update  restrict;
Alter table corridasdisponibles add Foreign Key (nNumeroConductor) references conductores (nNumeroConductor) on delete  restrict on update  restrict;
Alter table autobusconductor add Foreign Key (nNumeroAutobus) references autobuses (nNumeroAutobus) on delete  restrict on update  restrict;
Alter table conductores add Foreign Key (nNumeroAutobus) references autobuses (nNumeroAutobus) on delete  restrict on update  restrict;
Alter table corridasdisponibles add Foreign Key (nNumeroAutobus) references autobuses (nNumeroAutobus) on delete  restrict on update  restrict;
Alter table corridasdisponibles add Foreign Key (nProgramada) references corridasprogramadas (nNumero) on delete  restrict on update  restrict;
Alter table tramos add Foreign Key (nOrigen) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table tramos add Foreign Key (nDestino) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table personas add Foreign Key (nOficina) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table sesiones add Foreign Key (nOficina) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table boletosdisponibles add Foreign Key (nOficina) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table boletosvendidos add Foreign Key (nOrigen) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table boletosvendidos add Foreign Key (nDestino) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table trarifastramos add Foreign Key (nOrigen) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table trarifastramos add Foreign Key (nDestino) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table descuentos add Foreign Key (nOrigen) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table descuentos add Foreign Key (nDestino) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table terminales add Foreign Key (nOficina) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table promocionesdetalle add Foreign Key (nOrigen) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table promocionesdetalle add Foreign Key (nDestino) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table disponibilidad add Foreign Key (nOrigen) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table disponibilidad add Foreign Key (nDestino) references oficinas (nNumero) on delete  restrict on update  restrict;
Alter table itinerario add Foreign Key (nTramo) references tramos (nNumero) on delete  restrict on update  restrict;
Alter table autobuses add Foreign Key (nTipoServicio) references tiposervicio (nNumero) on delete  restrict on update  restrict;
Alter table trarifastramos add Foreign Key (nTipoServicio) references tiposervicio (nNumero) on delete  restrict on update  restrict;
Alter table corridasprogramadas add Foreign Key (nTipoServicio) references tiposervicio (nNumero) on delete  restrict on update  restrict;
Alter table corridasdisponibles add Foreign Key (nTipoServicio) references tiposervicio (nNumero) on delete  restrict on update  restrict;
Alter table corridasprogramadas add Foreign Key (nItinerario) references itinerario (nItinerario) on delete  restrict on update  restrict;
Alter table corridasdisponibles add Foreign Key (nItinerario) references itinerario (nItinerario) on delete  restrict on update  restrict;
Alter table registropasopuntos add Foreign Key (nItinerario) references itinerario (nItinerario) on delete  restrict on update  restrict;
Alter table registropasopuntos add Foreign Key (nNumero) references corridasdisponibles (nNumero) on delete  restrict on update  restrict;
Alter table boletosvendidos add Foreign Key (nCorrida) references corridasdisponibles (nNumero) on delete  restrict on update  restrict;
Alter table disponibilidad add Foreign Key (nCorridaDisponible) references corridasdisponibles (nNumero) on delete  restrict on update  restrict;
Alter table venta add Foreign Key (nSesion) references sesiones (nNumero) on delete  restrict on update  restrict;
Alter table boletosdisponibles add Foreign Key (nTipoBoleto) references tiposboletos (nNumero) on delete  restrict on update  restrict;
Alter table tipoventa add Foreign Key (ntipoboleto) references tiposboletos (nNumero) on delete  restrict on update  restrict;
Alter table boletoscancelados add Foreign Key (nBoletoVendido) references boletosvendidos (nNumero) on delete  restrict on update  restrict;
Alter table boletoscancelados add Foreign Key (nBoletoNuevo) references boletosvendidos (nNumero) on delete  restrict on update  restrict;
Alter table boletosvendidos add Foreign Key (nVenta) references venta (nNumero) on delete  restrict on update  restrict;
Alter table ventascliente add Foreign Key (nVenta) references venta (nNumero) on delete  restrict on update  restrict;
Alter table ventapago add Foreign Key (nVenta) references venta (nNumero) on delete  restrict on update  restrict;
Alter table ventascliente add Foreign Key (nCliente) references Clientes (nNumero) on delete  restrict on update  restrict;
Alter table boletosvendidos add Foreign Key (aTipoVenta) references tipoventa (aClave) on delete  restrict on update  restrict;
Alter table formapagosubtipo add Foreign Key (aClave) references formaspago (aClave) on delete  restrict on update  restrict;
Alter table ventapago add Foreign Key (aFormaPago) references formaspago (aClave) on delete  restrict on update  restrict;
Alter table ventapago add Foreign Key (nFormaPagoSubtipo) references formapagosubtipo (nNumero) on delete  restrict on update  restrict;
Alter table boletosvendidos add Foreign Key (aTipoPasajero) references tipopasajero (aClave) on delete  restrict on update  restrict;
Alter table boletosvendidos add Foreign Key (nDescuento) references descuentos (nNumero) on delete  restrict on update  restrict;
Alter table promocionesdetalle add Foreign Key (nPromocion) references promociones (nNumero) on delete  restrict on update  restrict;
Alter table boletosvendidos add Foreign Key (nPromocion) references promociones (nNumero) on delete  restrict on update  restrict;
Alter table boletosvendidos add Foreign Key (nTerminal) references terminales (nNumero) on delete  restrict on update  restrict;
Alter table promocionesdetalle add Foreign Key (nTerminal) references terminales (nNumero) on delete  restrict on update  restrict;
Alter table boletosvendidos add Foreign Key (nTipoPaquete) references tipopaquetes (nNumero) on delete  restrict on update  restrict;
Alter table boletosvendidos add Foreign Key (nFactorPaqueteria) references factorpaqueteria (nNumero) on delete  restrict on update  restrict;
Alter table disponibilidadasientos add Foreign Key (nDisponibilidad) references disponibilidad (nNumero) on delete  restrict on update  restrict;
Alter table tiposervicio add Foreign Key (nDistribucionAsientos) references distribucionasientos (nNumero) on delete  restrict on update  restrict;
Alter table autobuses add Foreign Key (nDistribucionAsientos) references distribucionasientos (nNumero) on delete  restrict on update  restrict;


/* Users permissions */


