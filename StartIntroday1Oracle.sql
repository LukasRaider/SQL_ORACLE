DROP TABLE person;
DROP TABLE department;
DROP TABLE contact;
DROP TABLE cat_contact_type;

CREATE TABLE person (
        id          NUMBER(4),
        firstName   VARCHAR(50),
        lastName    VARCHAR(50),
        sex         CHAR(1),
        age         NUMBER(2),
        salary      NUMBER(8,2),
        id_dept     NUMBER(1),
        hire_date   DATE DEFAULT SYSDATE
);

CREATE TABLE department(
        id          NUMBER(1),
        name        VARCHAR(50) NOT NULL
);

CREATE TABLE cat_contact_type(
        id          NUMBER(2),
        name        VARCHAR(50) NOT NULL
);

CREATE TABLE contact(
        id          NUMBER(4),
        id_person   NUMBER(4),
        id_cat_contact  NUMBER(2),
        value       VARCHAR(50)
);


DROP SEQUENCE seqPerson;
CREATE SEQUENCE seqPerson
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
    
DROP SEQUENCE seqDepartment;
CREATE SEQUENCE seqDepartment
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
    
DROP SEQUENCE seqContact;
CREATE SEQUENCE seqContact
    START WITH 1
    INCREMENT BY 1
    NOCACHE;


TRUNCATE TABLE person;
TRUNCATE TABLE department;
TRUNCATE TABLE cat_contact_type;
TRUNCATE TABLE contact;

INSERT INTO department(id,name) VALUES 
(seqDepartment.nextVal,'HR');
INSERT INTO department(id,name) VALUES 
(seqDepartment.nextVal,'DEVEL');
INSERT INTO department(id,name) VALUES 
(seqDepartment.nextVal,'FINANCE');
INSERT INTO department(id,name) VALUES 
(seqDepartment.nextVal,'IT');

INSERT INTO cat_contact_type (id, name) VALUES 
(1, 'EMAIL');
INSERT INTO cat_contact_type (id, name) VALUES 
(2, 'GSM');
INSERT INTO cat_contact_type (id, name) VALUES 
(3, 'SKYPE');
INSERT INTO cat_contact_type (id, name) VALUES 
(4, 'FAX');


INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextVal, 'Petr', 'Svoboda', 'M', 25, 47800, 1 );
INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextVal, 'Radek', 'Barta', 'M', 34, 17520, 1 );
INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextVal, 'Frantisek', 'Novak', 'M', 58, 37800, 1 );
INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextVal, 'Lenka', 'Novakova', 'F', 45, 33800, 3 );
INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextVal, 'Dita', 'Wiesnerova', 'F', 38, 44800, 1 );
INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextVal, 'Karel', 'Janak', 'M', 31, 40000, 2 );

INSERT INTO contact VALUES (seqContact.nextVal, 1, 1, 'svoboda@gmail.com' );
INSERT INTO contact VALUES (seqContact.nextVal, 1, 2, '777 556 777' );
INSERT INTO contact VALUES (seqContact.nextVal, 4, 3, 'lenka_cz' );
INSERT INTO contact VALUES (seqContact.nextVal, 4, 2, '602 343 990' );
INSERT INTO contact VALUES (seqContact.nextVal, 6, 2, '604 191 222' );
INSERT INTO contact VALUES (seqContact.nextVal, 5, 1, 'dita@seznam.cz' );

COMMIT; /* potrzeni ze chemem vlozit kvuli session propise at se vidi bez komitu ale nebude v databazi */

SELECT *
FROM person
WHERE salary>28000
;

SELECT *
FROM person
WHERE sex='F'
;

SELECT *
FROM person
WHERE salary>28000 AND sex='F'
;

SELECT *
FROM person 
ORDER BY lastname
;

SELECT *
FROM person 
ORDER BY lastname, firstname DESC
;

SELECT *
FROM person 
ORDER BY sex, lastname, firstname DESC
;

SELECT *
FROM person per 
WHERE sex = 'F'
;

SELECT per.firstname, per.lastname 
FROM person
;

SELECT firstname|| ' ' || lastname AS JMENO FROM person;

SELECT * 
FROM person per
WHERE id=1
;

SELECT per.id, per.lastname,per.salary
FROM person per
WHERE id=1
;

SELECT per.firstname as JMENO, per.lastname as PRIJEMNI FROM person per WHERE id=1;

SELECT per.firstname|| ' ' || per.lastname AS JMENO_A_PRIJEMNI FROM person per WHERE id=1;

SELECT * FROM person WHERE id!=1;
SELECT * FROM person WHERE id>1;
