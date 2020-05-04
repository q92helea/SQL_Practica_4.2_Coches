CREATE TABLE clientes(
/*4. Los DNI tienen 9 caractere, siendo el último una letra.*/
nif VARCHAR(9) PRIMARY KEY,
nombre VARCHAR2(20),
dir VARCHAR2(30),
ciudad CHAR(25),
/*9. los teléfonos empiezan por 6, 7, 8 o 9.*/
tfno NUMBER(9)
);

CREATE TABLE coches(
/*2.Matricula es cuatro números y tres letras o bien una o dos letras, un guión, cuatro
números, un guión y una o dos letras. (Ejs: 2345DFV, M-2332-NV,SE-3445-DF)*/
id_matrc VARCHAR2(10)PRIMARY KEY,
-- 8. marca y modelo nunca se dejarán en blanco.
marca VARCHAR2(20)NOT NULL,
modelo VARCHAR2(20) NOT NULL,
color CHAR(8), -- El color con el nombre más largo es "amarillo", pero no hay restricción.
pvp NUMBER(7,2)
);

ALTER TABLE coches ADD(id_cli VARCHAR(9));

ALTER TABLE coches ADD(CONSTRAINT fk_id_cli_clientes
FOREIGN KEY(id_cli) REFERENCES clientes (nif));

/*1.Color es verde, rojo, amarillo o blanco.*/
ALTER TABLE coches ADD(CONSTRAINT chk_color_car CHECK (color IN ('rojo','verde','amarillo','blanco')) 
);
10.El precio de un coche está entre 10000 y 60000.
ALTER TABLE coches ADD(CONSTRAINT chk_pvp_coches CHECK (pvp BETWEEN 10000 AND 60000)
);

CREATE TABLE operaciones(
id_op VARCHAR2(4)PRIMARY KEY,
dscrp VARCHAR2(150),
/* 5. Las Horas MO de una operación nunca pasan de 4*/
hr_mon NUMBER (1)
);

ALTER TABLE operaciones ADD(CONSTRAINT chk_hr_mon_operaciones CHECK (hr_mon BETWEEN 0 AND 4));

CREATE TABLE materiales (
id_mat VARCHAR2(3)PRIMARY KEY, 
name_mat VARCHAR2(20)
cantidad NUMBER(2));

CREATE TABLE piezasxoperacion (
id_piezs NUMBER(4) PRIMARY KEY,
id_opr NUMBER(4),
cantidad NUMBER(2)SET DEFAULT '1',
CONSTRAINT fk_id_mat FOREIGN KEY (id_piezs)REFERENCES materiales (id_mat))
CONSTRAINT fk_id_opr FOREIGN KEY (id_opr)REFERENCES operaciones (id_op)));

ALTER TABLE piezasxoperacion CHECK (cantidad>=1);

CREATE TABLE revisiones(
/*3. Las revisiones se hacen de 8 de la mañana a 5 de la tarde.*/
id_rev NUMBER(4) PRIMARY KEY,
fchrev DATE,
matr_car VARCHAR2(10),
CONSTRAINT fk_mtrc_car_coches FOREIGN KEY(matr_car) REFERENCES coches(id_matrc)
);

/*6. Todas las claves primarias, ajenas y candidatas.*/

CREATE TABLE constande(
id_opr VARCHAR2(10) PRIMARY KEY,
id_revn NUMBER(4), 
CONSTRAINT fk_id_opr FOREIGN KEY(id_opr)REFERENCES operaciones(id_op),
CONSTRAINT fk_id_revn FOREIGN KEY(id_revn)REFERENCES revisiones(id_rev)
);