CREATE TABLE clientes(
nif VARCHAR(9) PRIMARY KEY,
nombre VARCHAR2(20),
dir VARCHAR2(30),
ciudad CHAR(25),
tfno NUMBER(9)
);
/*4. Los DNI tienen 9 caracteres, siendo el �ltimo una letra.*/
 ALTER TABLE clientes ADD (
  CONSTRAINT CHK_nif CHECK (REGEXP_LIKE(nif, '^[0-9]{8}[aA-zZ]$')));
                                        
/*9. los teléfonos empiezan por 6, 7, 8 o 9.*/
ALTER TABLE clientes ADD CONSTRAINT chk_tfno_clientes CHECK (tfno like ('6%''7%''8%''9%'));
                                                                       
CREATE TABLE coches(
id_matrc VARCHAR2(10)PRIMARY KEY,
-- 8. marca y modelo nunca se dejar�n en blanco.
marca VARCHAR2(20)NOT NULL,
modelo VARCHAR2(20) NOT NULL,
color CHAR(8), -- El color con el nombre m�s largo es "amarillo", pero no hay restricci�n.
pvp NUMBER(7,2));

ALTER TABLE coches ADD(id_cli VARCHAR(9));

ALTER TABLE coches ADD (CONSTRAINT fk_id_cli_clientes FOREIGN KEY(id_cli) REFERENCES clientes (nif));
                                                                                               
/*1.Color es verde, rojo, amarillo o blanco.*/
ALTER TABLE coches ADD (
    CONSTRAINT chk_color_coches CHECK (color IN ('rojo','verde','amarillo','blanco')));
                                                 
/*2.Matricula es cuatro números y tres letras o bien una o dos letras, un gui�n, cuatro
números, un guión y una o dos letras. (Ejs: 2345DFV, M-2332-NV,SE-3445-DF)*/
ALTER TABLE coches ADD (CONSTRAINT CHK_matricula CHECK (REGEXP_LIKE (ID_matrc,('^[0-9]{4}[aA-zZ]{3}$'))  
                     OR REGEXP_LIKE(ID_matrc,('^[aA-zZ]{1-2}-[0-9]{4}-[aA-zZ]{1-2}$'))));

/*10.El precio de un coche est� entre 10000 y 60000.*/
ALTER TABLE coches ADD CONSTRAINT chk_pvp_coches CHECK (pvp BETWEEN 10000 AND 60000);


CREATE TABLE operaciones(
id_op VARCHAR2(4)PRIMARY KEY,
dscrp VARCHAR2(150),
hr_mon NUMBER (1)
);
                                     
/* 5. Las Horas MO de una operación nunca pasan de 4*/

ALTER TABLE operaciones ADD(
 CONSTRAINT chk_hr_mon_operaciones CHECK (hr_mon BETWEEN 0 AND 4));

CREATE TABLE materiales (
id_mat VARCHAR2(3)PRIMARY KEY, 
name_mat VARCHAR2(20),
cantidad NUMBER(2)
);

CREATE TABLE piezasxoperacion (
id_piezs NUMBER(4) PRIMARY KEY,
id_opr NUMBER(4),
cantidad VARCHAR2(2)DEFAULT '1',
CONSTRAINT fk_id_mat FOREIGN KEY (id_piezs)REFERENCES materiales (id_mat)
CONSTRAINT fk_id_opr FOREIGN KEY (id_opr)REFERENCES operaciones (id_op)
);
                                                           
CREATE TABLE revisiones(
id_rev NUMBER(4) PRIMARY KEY,
fchrev DATE,
matr_car VARCHAR2(10),
CONSTRAINT fk_mtrc_car_coches FOREIGN KEY(matr_car) REFERENCES coches(id_matrc)
);
                                                                 
/*3. Las revisiones se hacen de 8 de la ma�ana a 5 de la tarde.*/

ALTER TABLE Revisiones ADD ( 
    CONSTRAINT chk_fchrev CHECK ( to_char(fchrev, 'HH24:mm:ss') > '08:00:00' AND to_char(fchrev, 'HH24:mm:ss') < '17:00:00' )
    );
                                                                 
/*6. Todas las claves primarias, ajenas y candidatas.*/

CREATE TABLE constande(
id_opr VARCHAR2(10) PRIMARY KEY,
id_revn NUMBER(4), 
CONSTRAINT fk_id_opr FOREIGN KEY(id_opr)REFERENCES operaciones(id_op),
CONSTRAINT fk_id_revn FOREIGN KEY(id_revn)REFERENCES revisiones(id_rev)
);
