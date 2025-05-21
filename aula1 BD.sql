#Script de abertura banco de dados

#Criação do banco de dados
CREATE SCHEMA if not exists AnjoDePatas;

#Abertura do banco de dados
USE AnjoDePatas;

CREATE TABLE if not exists tb_tutor (
	tut_id INTEGER AUTO_INCREMENT NOT NULL,
	tut_nome VARCHAR(100) NOT NULL,
	tut_email VARCHAR(150) NOT NULL,
	tut_whatssap VARCHAR(20) DEFAULT 'Não informado',
     
	CONSTRAINT PRIMARY KEY(tut_id)
);    

CREATE TABLE if not exists tb_raca (
	raca_id INTEGER AUTO_INCREMENT NOT NULL,
    raca_nome VARCHAR(100) NOT NULL,
    
    CONSTRAINT PRIMARY KEY(raca_id)
);

CREATE TABLE if not exists tb_pet (
	pet_id INTEGER AUTO_INCREMENT NOT NULL,
    pet_tutid INTEGER NOT NULL,
	pet_nome VARCHAR(30),
    pet_idade INTEGER NOT NULL CHECK (pet_idade >= 1),
    pet_racaid INTEGER,
    
    CONSTRAINT PRIMARY KEY(pet_id),
    
    CONSTRAINT FOREIGN KEY(pet_tutid) 
    REFERENCES tb_tutor (tut_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    
    CONSTRAINT FOREIGN KEY(pet_racaid)
    REFERENCES tb_raca (raca_id)
    ON DELETE SET NULL
    ON UPDATE SET NULL
);

CREATE TABLE if not exists tb_veterinario (
	vet_id INTEGER NOT NULL AUTO_INCREMENT,
    vet_nome VARCHAR(100) NOT NULL,
    vet_especialidade VARCHAR(150) DEFAULT 'Clínico Geral',
    
    CONSTRAINT PRIMARY KEY(vet_id)
);

CREATE TABLE if not exists tb_consulta (
	con_petid INTEGER NOT NULL,
    con_vetid INTEGER NOT NULL,
    con_data DATE NOT NULL,
    con_valor DECIMAL (10,2) NOT NULL CHECK (con_valor >=150 && con_valor <=300),
    con_pesopet DECIMAL (4,2) DEFAULT 0,
    
    CONSTRAINT PRIMARY KEY (con_petid, con_vetid, con_data),
    
    CONSTRAINT FOREIGN KEY (con_petid) 
    REFERENCES tb_pet (pet_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    
    CONSTRAINT FOREIGN KEY (con_vetid)
    REFERENCES tb_veterinario (vet_id)
    ON DELETE RESTRICT 
    ON UPDATE CASCADE
);

#DROP TABLE tb_pet
#DROP TABLE tb_raca