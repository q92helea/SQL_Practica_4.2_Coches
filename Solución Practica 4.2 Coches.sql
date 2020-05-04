
CREATE TABLE clientes(
cod number PRIMARY KEY,
nif varchar2(9) unique,
nombre char(20),
dir  varchar2(30),
ciudad char(25),
tfno number(9));

CREATE TABLE coches(
matricula varchar2(10) PRIMARY KEY,
marca char(20) not null,
modelo varchar2(20) not null,
color char(8),
PVP number(7,2));

ALTER TABLE coches add (codigocliente number);

ALTER TABLE coches add (constraint fk_codigocliente_Clientes foreign key
(codigocliente) references clientes (cod));

CREATE TABLE revisiones(
cod number PRIMARY KEY,
fecharev date,
matriculacoche varchar2(10),
constraint fk_matriculacoche_coches foreign key(matriculacoche) references coches(matricula));

CREATE TABLE Operaciones(
cod number PRIMARY KEY,
descripción VARCHAR2,
horasMO number(1)
CONSTRAINT CK_HorasMO check (HorasMO BETWEEN 0 and 4)
);

CREATE TABLE PiezasPorOperacion(
CodMaterial number foreign KEY,
CodOperacion number foreign key,
Cantidad varchar2 default '1',
);

CREATE TABLE materiales (
cod number primary key,
nombre varchar2,
precio varchar2 between 10000 and 60000
);

create table constan (
Codigooperacion number primary key,
Codigorevision number,
constraint fk_codigooperacion foreign key (Codigooperacion) references Operaciones(cod),
constraint fk_codigorevision foreign key (Codigorevision) references revisiones(Cod)
);