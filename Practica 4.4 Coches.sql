CREATE TABLE coches(
idmatricula VARCHAR2(10)PRIMARY KEY,
marca VARCHAR2(20)NOT NULL,
modelo VARCHAR2(20) NOT NULL,-- 8. marca y modelo nunca se dejarán en blanco.
color CHAR(8), -- 1. El color con el nombre más largo es "amarillo"
/*pvp NUMBER(7,2) He tenido que borrar la tabla para corregir*/
pvp 
);
CREATE TABLE clientes(
NIF VARCHAR(9), -- 
nombre VARCHAR2(20),
dir VARCHAR2(30),
ciudad CHAR(25),
tfno NUMBER(9)
);
CREATE TABLE operaciones(
codop VARCHAR2(4),
dscrp varchar2(150),
hrmon NUMBER (1) /*tiempo de montaje en horas.*/
);
CREATE TABLE materiales(
codmat VARCHAR2(3), 
nombre VARCHAR2(20),
cantidad NUMBER(2)
);

CREATE TABLE piezasxoperacion(
codmat NUMBER(4)FOREIGN KEY,
codopr NUMBER(4)FOREIGN KEY,
cantidad VARCHAR2(2)
); 

CREATE TABLE revisiones(
codrev NUMBER(4) PRIMARY KEY,
fchrev DATE,
matrcar VARCHAR2(10),
);

CREATE TABLE constran(
codopr NUMBER PRIMARY KEY,
codrevn NUMBER, 
CONSTRAINT fk_codopr FOREIGN KEY(codop)REFERENCES operaciones(codop),
COSNTRAINT fk_codrevn FOREIGN KEY(codrev)REFERENCES revisiones(codrev)
);