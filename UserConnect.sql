DROP TABLE person;
DROP TABLE department;
DROP TABLE cat_contact_type;
DROP TABLE contact;

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

CREATE TABLE department (
    id          NUMBER(1),
    name        VARCHAR(50) NOT NULL
);

CREATE TABLE cat_contact_type (
    id          NUMBER(2),
    name        VARCHAR(50) NOT NULL
);

CREATE TABLE contact (
    id          NUMBER(4),
    id_person   NUMBER(4),
    id_cat_contact  NUMBER(2),
    value       VARCHAR(50)
);

--FILL
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

INSERT INTO department (id, name) VALUES 
(seqDepartment.nextVal, 'HR');
INSERT INTO department (id, name) VALUES 
(seqDepartment.nextVal, 'DEVEL');
INSERT INTO department (id, name) VALUES 
(seqDepartment.nextVal, 'FINANCE');
INSERT INTO department (id, name) VALUES 
(seqDepartment.nextVal, 'IT');

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

COMMIT;

--�KOL1: Procvi�te jednoduch� selecty. 
--Cvi�te na tabulce person, kter� vznikla d�ky vytv��ec�mu a 
--pln�c�mu skriptu v p�edchoz� kapitole.
--v�pis osob s platem vy���m ne� 28000
SELECT * FROM person WHERE salary > 28000;
--v�pis v�ech �en
SELECT * FROM person WHERE sex = 'F';
--spojen� p�edchoz�ho, tedy v�pis v�ech �en s platem nad 28000
SELECT * FROM person 
WHERE salary > 28000
AND sex = 'F';

--�KOL 2
--ORDER BY ... (ASC), DESC
--a)v�pis se�azen� podle p��jmen�
SELECT * FROM person ORDER BY lastname;
--b)v�pis se�azen� podle p��jmen�, v p��pad� stejn�ho 
--p��jmen� jsou osoby se�azeny d�le podle k�estn�ho jm�na sestupn�
SELECT * FROM person ORDER BY lastname, firstname DESC;
--c)tot�, ale nejprve budou v�echny �eny, potom mu�i
SELECT * FROM person ORDER BY sex, lastname, firstname DESC;

--�KOL3:Aliasov�n� tabulky: 
--a)vyhledejte v tabulce nap��klad osobu, 
--jej� id je 1. Vytvo�te p�itom alias na tabulku person. 
--Ov��te, zda je pot� mo�no i nad�le pou��vat p�vodn� n�zev tabulky.
SELECT per.id, per.lastname FROM person per WHERE id=1;
--Aliasov�n� sloupc�: 
--b)vypi�te tabulku tak, �e v z�hlav� m�sto firstName a 
--lastName bude Jm�no a P��jmen�
SELECT per.firstname AS jmeno, 
    per.lastname AS prijmeni
FROM person per 
WHERE id=1;
--c)vypi�te tabulku tak, �e m�sto dvou sloupc� 
--(firstName a lastName) bude jeden, v n�m bude jm�no 
--a p��jmen� odd�len� mezerou.
SELECT per.firstname || ' ' || per.lastname AS fullname
FROM person per WHERE id=1;

-- <>, !=
SELECT * FROM person WHERE id != 1;
SELECT * FROM person WHERE id <> 1;

INSERT INTO person (id, lastname) VALUES (SEQPERSON.nextval,'Novak');
SELECT * FROM person WHERE firstname IS NOT NULL;
SELECT * FROM person WHERE firstname IS NULL;

UPDATE person SET firstname = 'Antonin' WHERE id = 7;
UPDATE person SET sex = 'M' WHERE sex IS NULL;

-- Upper a Lower
SELECT UPPER(firstname) FROM person;
SELECT LOWER(firstname) FROM person;

COMMIT;

--�KOL 4: v tabulce person:
--A)z Novak� ud�lejte Dvoraky. Ov��te v�pisem tabulky. 
--Bylo nutn� pou��t commit? Po ov��en� vra�te zp�t (p��kaz ROLLBACK), 
--a� v tom nem�me chaos. Nebo znovu spus�te pln�c� skript.
--B)id v�ech z�znam� zvy�te o 25. Ov��te a pak vra�te zp�t
--C)k�estn� jm�na p�eve�te na velk� p�smena. Ov��te a pak vra�te zp�t
--D)p�ed p��jmen� p�idejte znak #. Ov��te a pak vra�te zp�t


UPDATE person SET lastname='Dvorak' WHERE lastname='Novak';

COMMIT; /* provede zmenu */
ROLLBACK; /* vrati zpatky */ 

UPDATE person SET id = id+25;

COMMIT;
ROLLBACK;

UPDATE person SET UPPER(firstname);

COMMIT;
ROLLBACK;

UPDATE person SET lastname='#'||lastname;

COMMIT;
ROLLBACK;

UPDATE person SET id=id-25;

UPDATE person SET firstname= initcap(fistname);

UPDATE person SET lastname= substring(lastname,2);

UPDATE person SET lastname='Novak' WHERE lastname='Dvorak';

COMMIT;


UPDATE departments SET 

DROP TABLE department;
commit;

CREATE TABLE department (
    id          NUMBER(1),
    name        VARCHAR(50) NOT NULL,
    enabled     NUMBER(1) DEFAULT 1
);

DROP SEQUENCE seqDepartment;
CREATE SEQUENCE seqDepartment
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

INSERT INTO department (id, name) VALUES 
(seqDepartment.nextVal, 'HR');
INSERT INTO department (id, name) VALUES 
(seqDepartment.nextVal, 'DEVEL');
INSERT INTO department (id, name) VALUES 
(seqDepartment.nextVal, 'FINANCE');
INSERT INTO department (id, name) VALUES 
(seqDepartment.nextVal, 'IT');


UPDATE department SET enabled = 0 WHERE id IN (3,4);

SELECT * FROM department WHERE enabled=1;

SELECT * FROM person WHERE id_dept IN (1,2);

SELECT * FROM department WHERE enabled=1;

SELECT id
FROM department 
WHERE enabled = 1 
;
SELECT *
FROM person
WHERE id_dept IN(
    SELECT id
    FROM department
    WHERE enabled=1
)
;

SELECT *
FROM person
WHERE id_dept IN(
    SELECT id
    FROM department
    WHERE enabled=1
)
AND
salary > 28000
;

SELECT *
FROM person
WHERE id_dept IN(
    SELECT id
    FROM department
    WHERE enabled=0
)
AND
salary > 19000
;

SELECT * FROM person WHERE sex='F' AND id_dept=1;



SELECT * FROM DEPARTMENT
WHERE EXISTS(
    SELECT * FROM person
    WHERE id_dept = department.id
    AND sex = 'F'
);
/* Jestli yde v danem oddeleni existuje zenska */

SELECT *
from department dep 
WHERE dep.id IN (
    SELECT id_dept 
    from person 
    where sex='F'
)
;

SELECT *
FROM department
WHERE EXISTS(
    SELECT * 
    FROM person 
    WHERE id_dept=department.id
    AND sex='F'
)
AND NOT EXISTS(
    SELECT *
    FROM person
    WHERE id_dept= department.id
    AND sex='M'
);
/* Oddelnei kde pracuji zensky a zadny muz */


SELECT * 
FROM person
WHERE NOT EXISTS(SELECT * FROM contact WHERE person.id=id_person)
;


--propojeni vsech tabulek dohromady
--press id dept a id contact

SELECT *
FROM person
JOIN department ON (person.id_dept=department.id)
JOIN contact ON (contact.id_person=person.id)
JOIN cat_contact_type ON (contact.id_cat_contact=cat_contact_type.id);


--bvzpis ma prilis mnoho sloupcu 

SELECT per.id,per.firstName as jmeno,per.lastName as prijmeni,per.salary,dep.name as oddeleni, con.value as kontakt, cct.name as typ_kontaktu
FROM person per
JOIN department dep ON (per.id_dept=dep.id)
JOIN contact con ON (con.id_person=per.id)
JOIN cat_contact_type cct ON (con.id_cat_contact=cct.id);


--11  omezte vyse uvedeny vypis jen na telefony



SELECT per.id,per.firstName as jmeno,per.lastName as prijmeni,per.salary,dep.name as oddeleni, con.value as kontakt, cct.name as typ_kontaktu
FROM person per
RIGHT JOIN department dep ON (per.id_dept=dep.id)
RIGHT JOIN contact con ON (con.id_person=per.id)
RIGHT JOIN cat_contact_type cct ON (con.id_cat_contact=cct.id)

;


ALTER TABLE person ADD (
    id_boss     NUMBER(4)
);


UPDATE person SET
    id_boss = 5
WHERE id IN (1,4,6);

UPDATE person SET
    id_boss = 1
WHERE id IN (2.3);

SELECT per.firstName as Jmeno, per.lastName as Prijemni, boss.firstName || ' ' ||UPPER(boss.lastName) as bossName
FROM person per
JOIN person boss ON (per.id_boss = boss.id);

-- subjoin v stejne tabulku k sobe same pripojeni 

--13 soucet patu vsech zen
--a vsech yen 
-- b po oddelnie
--c vsech yam kde pracuji yenz 
SELECT SUM(per.salary)as Platy
FROM person per
JOIN department dep ON (per.id_dept = dep.id)
WHERE per.sex = 'F'
;

SELECT id_dept,SUM(per.salary)as Platy
FROM person per
WHERE per.sex = 'F'
GROUP BY id_dept
;


SELECT id_dept, SUM(per.salary) as Platy
FROM person per
WHERE id_dept IN
(
    SELECT id
    FROM department
    WHERE EXISTS(
        SELECT *
        FROM person
        WHERE id_dept = department.id
        AND sex = 'F'
    )
)
GROUP BY id_dept
;

SELECT id_dept, SUM(salary)
FROM person
WHERE id_dept IN (
    SELECT id_dept
    FROM person
    WHERE sex = 'F'
)
GROUP BY id_dept
;

--14 platy vsech yamestnnacu kde praciji jen zeny 

SELECT id_dept, SUM(salary) as Platy
FROM person
WHERE id_dept IN (
    SELECT id_dept
    FROM person
    WHERE sex = 'F' AND id_dept IN( 
    SELECT id_dept 
    FROM person 
    WHERE sex = 'M'
    )
)
GROUP BY id_dept
;

SELECT id_dept, SUM(salary)
FROM person
WHERE id_dept IN (
SELECT id_dept
FROM person
WHERE sex='F
AND id_dept NOT IN (
    SELECT id_dept
    FROm person
    WHERE sex='M')

)
GROUP BY id_dept
;

SELECT id_dept, SUM(salary) as Platy
FROM person
WHERE id_dept IN (
    SELECT id
    FROM cat_contact_type
    WHERE name = 'GSM'
)
GROUP BY id_dept
;


SELECT SUM(person.salary) as SUMA_SALARY
FROM person
WHERE person.id IN (
    SELECT contact.id_person
    FROM contact
    WHERE contact.id_cat_contact = 2
);
SELECT id_dept as "Odd�len�", SUM(salary) as "Platy" FROM person  
WHERE id_dept IN 
(SELECT id_dept FROM person WHERE sex='F') 
AND id_dept NOT IN (SELECT id_dept FROM person  WHERE sex='M') GROUP BY id_dept;

SELECT id FROM department
WHERE EXISTS (
    SELECT * FROM person
    WHERE id_dept = department.id AND sex='F'
    
)
AND NOT EXISTS (
    SELECT * FROM person 
    WHERE id_dept = deparment.id
    AND sex='M'
))
GROUP BY id_dept
;

-- union


SELECT id, firstname, lastname
FROM person 
UNION 
SELECT 158, 'TENTO CLOVEK', 'je testovaci konstanta'
FROM dual
;

SELECT SYSDATE FROM dual;

SELECT 1 as cislo FROM dual;


--15 cviko 

SELECT * 
FROM person
WHERE salary>40000 
UNION
SELECT *
FROM person
WHERE sex='M'
;

SELECT * 
FROM person
WHERE salary>40000 
UNION ALL
SELECT *
FROM person
WHERE sex='M'
;


SELECT * 
FROM person
WHERE salary>40000 
UNION ALL
SELECT *
FROM person
WHERE sex='M'
;

SELECT * 
FROM person
WHERE salary>40000 
UNION ALL
SELECT *
FROM person
WHERE sex='M'
MINUS
SELECT*
FROM person
WHERE salary > 45000
INTERSECT
SELECT *
FROM person
WHERE salary > 40000
INTERSECT
SELECT *
FROM person
WHERE sex ='F'
;


SELECT *
FROM person
WHERE salary IN (47800,40000,31111);
UNION
SELECT*
FROM person
WHERE age > ANY (30,42,50);
UNION
SELECT*
FROM person
WHERE age > ALL (30,40,50)
UNION
SELECT*
FROM person
WHERE salary > ALL(
SELECT salary
FROM person
WHERE sex='F')
;



CREATE OR REPLACE VIEW Womenvies AS

SELECT id,lastname,salary 
FROM person 
WHERE sex='F';

COMMIT;

SELECT * 
FROM womenvies wom
JOIN
CONTACT con ON (con.id_person=wom.id);


--18

CREATE OR REPLACE VIEW bohatiView AS
    SELECT firstname, lastname, sex as Pohlavi
    FROM person
    WHERE salary > 30000;


CREATE OR REPLACE VIEW personWithContact AS
    SELECT firstname || ' ' || lastname as Jmeno, con.value, cct.name
    FROM person per
    JOIN contact con ON (con.id_person = per.id)
    JOIN cat_contact_type cct ON (con.id_cat_contact=cct.id);

--vzcisiti tabulku person a naplnit ynovu 
DELETE person;
    
    vygenerovani_lidi.txt
INSERT INTO person VALUES(1, 'M�ria', 'Vymazalov�','F', '26',  24000, 3, '25.11.2014');
INSERT INTO person VALUES(2, 'V�t', 'Anto� ','M', '23',  23000, 3, '22/1/2011');
INSERT INTO person VALUES(3, 'Olena', 'Vr�nov�','F', '35',  12000, 4, '3.9.2005');
INSERT INTO person VALUES(4, 'Rudolf', 'Motl ','M', '51',  28000, 4, '25/5/2010');
INSERT INTO person VALUES(5, 'Em�lia', 'Adamcov�','F', '20',  19000, 4, '23.11.2018');
INSERT INTO person VALUES(6, 'Dalibor', 'Kub�k ','M', '28',  37000, 4, '1/6/2005');
INSERT INTO person VALUES(7, 'Radom�ra', 'Pape�ov�','F', '28',  35000, 4, '11.1.2008');
INSERT INTO person VALUES(8, 'Michal', 'Fojt�k ','M', '57',  42000, 4, '3/9/2017');
INSERT INTO person VALUES(9, 'S�ra', 'Markov�','F', '58',  35000, 3, '11.8.2019');
INSERT INTO person VALUES(10, 'Vladim�r', 'Valenta ','M', '34',  16000, 3, '18/3/2009');
INSERT INTO person VALUES(11, 'Tatiana', 'Dr�bkov�','F', '20',  23000, 4, '19.5.2010');
INSERT INTO person VALUES(12, 'Roland', 'Dvorsk� ','M', '62',  20000, 4, '19/7/2008');
INSERT INTO person VALUES(13, 'Martina', 'Mazurov�','F', '28',  38000, 1, '30.11.2015');
INSERT INTO person VALUES(14, 'Ferdinand', 'Pecka ','M', '45',  26000, 1, '28/5/2004');
INSERT INTO person VALUES(15, 'Hana', 'Heczkov�','F', '59',  46000, 4, '25.9.2012');
INSERT INTO person VALUES(16, 'Alex', 'Han�?ek ','M', '21',  35000, 4, '29/10/2015');
INSERT INTO person VALUES(17, 'Vlasta', 'Z�rubov�','F', '20',  26000, 4, '8.4.2018');
INSERT INTO person VALUES(18, '?estm�r', 'Seifert ','M', '50',  40000, 4, '7/9/2011');
INSERT INTO person VALUES(19, 'Martina', 'Zbo?ilov�','F', '52',  33000, 4, '2.2.2015');
INSERT INTO person VALUES(20, 'Imrich', 'Hole?ek ','M', '26',  13000, 4, '14/9/2006');
INSERT INTO person VALUES(21, 'Pavla', 'Krejzov�','F', '59',  13000, 4, '22.3.2004');
INSERT INTO person VALUES(22, 'Arno�t', 'Mina?�k ','M', '55',  19000, 4, '16/12/2018');
INSERT INTO person VALUES(23, 'Zuzana', 'Honsov�','F', '45',  21000, 4, '11.6.2017');
INSERT INTO person VALUES(24, 'Ondrej', 'Hrbek ','M', '32',  28000, 4, '24/12/2013');
INSERT INTO person VALUES(25, 'Zdenka', 'Pavlov�','F', '52',  37000, 4, '30.7.2006');
INSERT INTO person VALUES(26, 'Ren�', 'Kotl�r ','M', '61',  33000, 4, '1/11/2009');
INSERT INTO person VALUES(27, 'Pavla', 'Hou�kov�','F', '37',  44000, 3, '18.10.2019');
INSERT INTO person VALUES(28, 'Pavol', 'Pracha? ','M', '37',  42000, 3, '9/11/2004');
INSERT INTO person VALUES(29, 'Iva', 'Richterov�','F', '45',  24000, 4, '5.12.2008');
INSERT INTO person VALUES(30, 'Ivo', '�im?�k ','M', '20',  47000, 4, '10/2/2017');
INSERT INTO person VALUES(31, 'Milada', 'Havl�kov�','F', '30',  32000, 3, '1.10.2005');
INSERT INTO person VALUES(32, 'Bohumir', 'Nov�?ek ','M', '42',  21000, 3, '18/2/2012');
INSERT INTO person VALUES(33, 'Jindra', 'Hlavat�','F', '39',  20000, 4, '3.12.2012');
INSERT INTO person VALUES(34, 'Emil', 'Mach�lek ','M', '24',  25000, 4, '22/6/2011');
INSERT INTO person VALUES(35, 'Patricie', 'Gruberov�','F', '46',  36000, 1, '16.6.2018');
INSERT INTO person VALUES(36, 'Martin', 'Baloun ','M', '53',  31000, 1, '30/4/2007');
INSERT INTO person VALUES(37, '�ofie', 'Maz�nkov�','F', '31',  43000, 4, '12.4.2015');
INSERT INTO person VALUES(38, 'Robert', 'H�bl ','M', '29',  40000, 4, '30/9/2018');
INSERT INTO person VALUES(39, 'Na?a', 'Ku�elov�','F', '39',  23000, 1, '30.5.2004');
INSERT INTO person VALUES(40, 'Adrian', 'Soukup ','M', '58',  45000, 1, '9/8/2014');
INSERT INTO person VALUES(41, 'Johana', '�indlerov�','F', '24',  31000, 4, '18.8.2017');
INSERT INTO person VALUES(42, 'Anton�n', 'V�t ','M', '35',  18000, 4, '16/8/2009');
INSERT INTO person VALUES(43, 'Ema', 'Blechov�','F', '55',  38000, 3, '14.6.2014');
INSERT INTO person VALUES(44, 'Jozef', 'Smola ','M', '57',  27000, 3, '23/8/2004');
INSERT INTO person VALUES(45, 'Oksana', 'Mach�?kov�','F', '63',  18000, 4, '2.8.2003');
INSERT INTO person VALUES(46, 'Jan', 'Pa�ek ','M', '40',  33000, 4, '25/11/2016');
INSERT INTO person VALUES(47, 'Ilona', 'Val�kov�','F', '25',  42000, 1, '4.10.2010');
INSERT INTO person VALUES(48, 'Vojtech', 'Urb�nek ','M', '22',  37000, 1, '28/3/2016');
INSERT INTO person VALUES(49, 'B�ra', 'Fiedlerov�','F', '55',  42000, 4, '9.12.2005');
INSERT INTO person VALUES(50, 'Herbert', 'Pluha? ','M', '45',  47000, 4, '12/10/2007');
INSERT INTO person VALUES(51, 'Jind?i�ka', 'Klikov�','F', '64',  29000, 1, '10.2.2013');
INSERT INTO person VALUES(52, 'Juli�s', 'Pa?�zek ','M', '27',  16000, 1, '12/2/2007');
INSERT INTO person VALUES(53, 'Ilona', 'Niklov�','F', '49',  37000, 4, '7.12.2009');
INSERT INTO person VALUES(54, 'Prokop', '�im�?ek ','M', '50',  25000, 4, '15/7/2018');
INSERT INTO person VALUES(55, 'Magdalena', 'Petr�ov�','F', '57',  17000, 1, '20.6.2015');
INSERT INTO person VALUES(56, 'Viliam', 'Hanzal ','M', '32',  30000, 1, '24/5/2014');
INSERT INTO person VALUES(57, 'Danu�e', 'Jav?rkov�','F', '42',  25000, 4, '14.4.2012');
INSERT INTO person VALUES(58, 'Bruno', '�t?p�nek ','M', '55',  39000, 4, '31/5/2009');
INSERT INTO person VALUES(59, 'Aloisie', 'H?lkov�','F', '51',  12000, 1, '17.6.2019');
INSERT INTO person VALUES(60, 'Norbert', 'Balcar ','M', '37',  44000, 1, '1/10/2008');
INSERT INTO person VALUES(61, 'Magdalena', '?erm�kov�','F', '35',  12000, 4, '22.8.2014');
INSERT INTO person VALUES(62, 'Hubert', 'Homola ','M', '60',  18000, 4, '9/9/2016');
INSERT INTO person VALUES(63, 'Zd?nka', 'Kupkov�','F', '43',  36000, 1, '31.5.2005');
INSERT INTO person VALUES(64, 'Dan', 'Mokr� ','M', '42',  22000, 1, '11/1/2016');
INSERT INTO person VALUES(65, 'Karla', 'Hrabalov�','F', '28',  35000, 4, '29.12.2016');
INSERT INTO person VALUES(66, 'Karol', 'P�cha ','M', '19',  32000, 4, '27/7/2007');
INSERT INTO person VALUES(67, 'Radana', 'Paterov�','F', '36',  23000, 1, '8.10.2007');
INSERT INTO person VALUES(68, 'Radoslav', '��ma ','M', '47',  37000, 1, '27/11/2006');
INSERT INTO person VALUES(69, 'Lucie', 'Hronov�','F', '43',  39000, 1, '20.4.2013');
INSERT INTO person VALUES(70, 'Lud?k', 'Kouba ','M', '30',  42000, 1, '28/2/2019');
INSERT INTO person VALUES(71, 'Iryna', 'Schwarzov�','F', '29',  47000, 1, '13.2.2010');
INSERT INTO person VALUES(72, 'Kry�tof', 'Hendrych ','M', '53',  15000, 1, '8/3/2014');
INSERT INTO person VALUES(73, 'Ivana', 'N?mcov�','F', '36',  27000, 1, '27.8.2015');
INSERT INTO person VALUES(74, 'Ivan', 'Rezek ','M', '36',  21000, 1, '14/1/2010');
INSERT INTO person VALUES(75, 'Petra', 'Kotasov�','F', '22',  34000, 4, '22.6.2012');
INSERT INTO person VALUES(76, 'Ludv�k', 'Ba�ant ','M', '58',  30000, 4, '21/1/2005');
INSERT INTO person VALUES(77, 'Laura', 'Mizerov�','F', '53',  42000, 4, '18.4.2009');
INSERT INTO person VALUES(78, 'Mojm�r', 'Pavl�?ek ','M', '34',  39000, 4, '24/6/2016');
INSERT INTO person VALUES(79, 'Ivana', 'T?�skov�','F', '60',  22000, 4, '30.10.2014');
INSERT INTO person VALUES(80, 'Radim', 'Sl�ma ','M', '63',  44000, 4, '2/5/2012');
INSERT INTO person VALUES(81, 'Linda', 'Kal�bov�','F', '23',  46000, 1, '8.8.2005');
INSERT INTO person VALUES(82, 'Marek', 'Lebeda ','M', '45',  13000, 1, '3/9/2011');
INSERT INTO person VALUES(83, 'Dana', 'Urb�nkov�','F', '53',  45000, 4, '8.3.2017');
INSERT INTO person VALUES(84, 'Daniel', '�iga ','M', '22',  23000, 4, '12/8/2019');
INSERT INTO person VALUES(85, 'Sylva', 'Homolkov�','F', '62',  33000, 1, '15.12.2007');
INSERT INTO person VALUES(86, 'Pavel', '�?�rsk� ','M', '50',  27000, 1, '13/12/2018');
INSERT INTO person VALUES(87, 'Andrea', 'Hurtov�','F', '46',  33000, 4, '15.7.2019');
INSERT INTO person VALUES(88, 'Jaroslav', 'Ho?ej�� ','M', '28',  37000, 4, '28/6/2010');
INSERT INTO person VALUES(89, 'Maria', 'L�balov�','F', '54',  20000, 1, '23.4.2010');
INSERT INTO person VALUES(90, 'Rastislav', 'Veverka ','M', '56',  42000, 1, '29/10/2009');
INSERT INTO person VALUES(91, 'Darina', 'Zahradn�?kov�','F', '40',  28000, 4, '17.2.2007');
INSERT INTO person VALUES(92, 'Roman', 'Mi?ka ','M', '32',  15000, 4, '5/11/2004');
INSERT INTO person VALUES(93, 'Karolina', 'Jan?�kov�','F', '47',  44000, 1, '30.8.2012');
INSERT INTO person VALUES(94, 'Oliver', 'Chvojka ','M', '61',  20000, 1, '7/2/2017');
INSERT INTO person VALUES(95, 'Milu�ka', 'T�borsk�','F', '32',  16000, 4, '26.6.2009');
INSERT INTO person VALUES(96, 'Ji?�', 'Michna ','M', '37',  29000, 4, '15/2/2012');
INSERT INTO person VALUES(97, 'Valerie', 'Je�kov�','F', '40',  31000, 1, '7.1.2015');
INSERT INTO person VALUES(98, '?en?k', 'Kotas ','M', '20',  35000, 1, '24/12/2007');
INSERT INTO person VALUES(99, 'Jarom�ra', 'Bedn�?ov�','F', '25',  39000, 4, '2.11.2011');
INSERT INTO person VALUES(100, 'Gejza', 'Hork� ','M', '43',  44000, 4, '27/5/2019');
INSERT INTO person VALUES(101, 'Gertruda', 'Suchomelov�','F', '32',  19000, 4, '15.5.2017');
INSERT INTO person VALUES(102, 'Samuel', 'Hanzl�k ','M', '25',  13000, 4, '4/4/2015');
INSERT INTO person VALUES(103, 'Milu�e', 'Pet?�?kov�','F', '41',  43000, 2, '22.2.2008');
INSERT INTO person VALUES(104, 'Bronislav', '�im�k ','M', '53',  18000, 2, '6/8/2014');
INSERT INTO person VALUES(105, 'Svitlana', 'P?ikrylov�','F', '25',  42000, 4, '22.9.2019');
INSERT INTO person VALUES(106, 'Alexander 4 000', 'Pham ','M', '31',  27000, 4, '18/2/2006');
INSERT INTO person VALUES(107, 'Nad?�da', 'Blechov�','F', '34',  30000, 1, '1.7.2010');
INSERT INTO person VALUES(108, '�imon', 'Kraus ','M', '59',  32000, 1, '21/6/2005');
INSERT INTO person VALUES(109, 'Daniela', 'Landov�','F', '19',  38000, 1, '27.4.2007');
INSERT INTO person VALUES(110, 'Tibor', 'Nedv?d ','M', '35',  41000, 1, '22/11/2016');
INSERT INTO person VALUES(111, 'Al�b?ta', 'Ma�kov�','F', '26',  18000, 1, '7.11.2012');
INSERT INTO person VALUES(112, 'Alois', 'Mikula ','M', '64',  47000, 1, '30/9/2012');
INSERT INTO person VALUES(113, 'Nad?�da', 'Mal�','F', '58',  25000, 1, '2.9.2009');
INSERT INTO person VALUES(114, 'Svatopluk', '?ernohorsk� ','M', '40',  20000, 1, '8/10/2007');
INSERT INTO person VALUES(115, 'Sabina', 'Polansk�','F', '19',  41000, 1, '16.3.2015');
INSERT INTO person VALUES(116, 'Old?ich', '�im�nek ','M', '23',  25000, 1, '17/8/2003');
INSERT INTO person VALUES(117, 'M�ria', 'Nguyenov�','F', '51',  13000, 4, '10.1.2012');
INSERT INTO person VALUES(118, 'Peter', 'Dole�al ','M', '46',  34000, 4, '17/1/2015');
INSERT INTO person VALUES(119, 'Erika', 'Luke�ov�','F', '58',  29000, 1, '23.7.2017');
INSERT INTO person VALUES(120, 'Milan', 'Jaro� ','M', '29',  39000, 1, '26/11/2010');
INSERT INTO person VALUES(121, 'Sabina', 'Str�nsk�','F', '43',  36000, 4, '19.5.2014');
INSERT INTO person VALUES(122, 'Du�an', 'Lacina ','M', '51',  13000, 4, '3/12/2005');
INSERT INTO person VALUES(123, 'Radom�ra', 'Fischerov�','F', '52',  24000, 1, '25.2.2005');
INSERT INTO person VALUES(124, 'Jarom�r', 'Kavka ','M', '33',  17000, 1, '5/4/2005');
INSERT INTO person VALUES(125, 'Hana', '?erm�kov�','F', '59',  40000, 2, '8.9.2010');
INSERT INTO person VALUES(126, 'Vasil', 'Reme� ','M', '62',  23000, 2, '8/7/2017');
INSERT INTO person VALUES(127, 'Natalie', 'Vesel�','F', '45',  12000, 1, '4.7.2007');
INSERT INTO person VALUES(128, 'Tom�', 'Klime� ','M', '38',  32000, 1, '15/7/2012');
INSERT INTO person VALUES(129, 'Martina', 'Hrabalov�','F', '52',  27000, 2, '14.1.2013');
INSERT INTO person VALUES(130, 'Albert', 'Burda ','M', '21',  37000, 2, '23/5/2008');
INSERT INTO person VALUES(131, 'Hana', 'Jir�kov�','F', '37',  35000, 1, '10.11.2009');
INSERT INTO person VALUES(132, 'Zby�ek', 'Zach ','M', '43',  46000, 1, '25/10/2019');
INSERT INTO person VALUES(133, 'Natalie', 'Dubov�','F', '23',  43000, 4, '6.9.2006');
INSERT INTO person VALUES(134, 'Radek', 'Kulhav� ','M', '20',  19000, 4, '1/11/2014');
INSERT INTO person VALUES(135, 'Jitka', 'Bendov�','F', '30',  22000, 1, '19.3.2012');
INSERT INTO person VALUES(136, 'Tobi�', 'Rambousek ','M', '49',  25000, 1, '10/9/2010');
INSERT INTO person VALUES(137, 'Jolana', 'Machalov�','F', '39',  46000, 2, '22.5.2019');
INSERT INTO person VALUES(138, 'Petro', '?ervinka ','M', '31',  29000, 2, '11/1/2010');
INSERT INTO person VALUES(139, 'Zuzana', 'Hor?�kov�','F', '23',  46000, 1, '27.7.2014');
INSERT INTO person VALUES(140, 'Kristi�n', 'Kov�? ','M', '54',  39000, 1, '19/12/2017');
INSERT INTO person VALUES(141, 'Vladislava', 'Mizerov�','F', '31',  34000, 2, '5.5.2005');
INSERT INTO person VALUES(142, 'Boris', 'Hejda ','M', '36',  44000, 2, '22/4/2017');
INSERT INTO person VALUES(143, 'Barbora', 'Frankov�','F', '62',  33000, 4, '2.12.2016');
INSERT INTO person VALUES(144, 'Leopold', 'Gajdo� ','M', '59',  17000, 4, '4/11/2008');
INSERT INTO person VALUES(145, 'Ivanka', 'Medkov�','F', '24',  21000, 2, '11.9.2007');
INSERT INTO person VALUES(146, 'Robin', '�ilhav� ','M', '41',  22000, 2, '7/3/2008');
INSERT INTO person VALUES(147, 'Dita', 'Balcarov�','F', '55',  29000, 1, '7.7.2004');
INSERT INTO person VALUES(148, 'Leo', 'Kalina ','M', '64',  31000, 1, '9/8/2019');
INSERT INTO person VALUES(149, 'Jindra', 'Pavelkov�','F', '63',  45000, 1, '18.1.2010');
INSERT INTO person VALUES(150, 'Vratislav', 'Bart�k ','M', '46',  37000, 1, '17/6/2015');
INSERT INTO person VALUES(151, 'Elena', 'Mat?jkov�','F', '48',  16000, 1, '14.11.2006');
INSERT INTO person VALUES(152, 'Slavom�r', 'Merta ','M', '23',  46000, 1, '24/6/2010');
INSERT INTO person VALUES(153, '�ofie', 'Pale?kov�','F', '55',  32000, 1, '27.5.2012');
INSERT INTO person VALUES(154, 'Kamil', 'Ors�g ','M', '52',  15000, 1, '3/5/2006');
INSERT INTO person VALUES(155, 'Michala', 'Korbelov�','F', '41',  40000, 1, '22.3.2009');
INSERT INTO person VALUES(156, 'Erik', 'Lev� ','M', '28',  24000, 1, '3/10/2017');
INSERT INTO person VALUES(157, 'Johana', 'Ondr�?kov�','F', '48',  20000, 1, '3.10.2014');
INSERT INTO person VALUES(158, 'Milo�', 'Mac�k ','M', '57',  29000, 1, '12/8/2013');
INSERT INTO person VALUES(159, 'Radka', 'T�borsk�','F', '57',  44000, 2, '12.7.2005');
INSERT INTO person VALUES(160, 'Vladim�r', 'Zima ','M', '39',  34000, 2, '13/12/2012');
INSERT INTO person VALUES(161, 'Iveta', 'Knotkov�','F', '42',  15000, 2, '1.10.2018');
INSERT INTO person VALUES(162, 'Bohuslav', 'Hrb�?ek ','M', '61',  43000, 2, '21/12/2007');
INSERT INTO person VALUES(163, 'Ilona', 'Bedn�?ov�','F', '49',  31000, 2, '19.11.2007');
INSERT INTO person VALUES(164, 'Ernest', 'Pato?ka ','M', '44',  13000, 2, '30/10/2003');
INSERT INTO person VALUES(165, 'Radka', 'Bl�hov�','F', '35',  39000, 1, '14.9.2004');
INSERT INTO person VALUES(166, 'Ale�', 'Marek ','M', '21',  22000, 1, '1/4/2015');
INSERT INTO person VALUES(167, 'Danu�e', 'Bergerov�','F', '42',  18000, 2, '28.3.2010');
INSERT INTO person VALUES(168, 'Vladan', 'Mach�?ek ','M', '50',  27000, 2, '7/2/2011');
INSERT INTO person VALUES(169, 'Aneta', 'Ambro�ov�','F', '28',  26000, 1, '22.1.2007');
INSERT INTO person VALUES(170, 'V�clav', 'Seidl ','M', '26',  36000, 1, '15/2/2006');
INSERT INTO person VALUES(171, 'Magdalena', 'Pol�?kov�','F', '35',  42000, 2, '4.8.2012');
INSERT INTO person VALUES(172, 'Norbert', 'Jakubec ','M', '55',  41000, 2, '19/5/2018');
INSERT INTO person VALUES(173, 'Danu�e', 'Va��?kov�','F', '20',  14000, 1, '30.5.2009');
INSERT INTO person VALUES(174, 'Maxmili�n', 'Polansk� ','M', '31',  15000, 1, '27/5/2013');
INSERT INTO person VALUES(175, 'Aloisie', 'Synkov�','F', '29',  37000, 2, '1.8.2016');
INSERT INTO person VALUES(176, 'Zolt�n', 'Adamec ','M', '59',  19000, 2, '27/9/2012');
INSERT INTO person VALUES(177, 'Ladislava', 'Zezulov�','F', '59',  37000, 1, '7.10.2011');
INSERT INTO person VALUES(178, 'Vasil', 'Kotrba ','M', '36',  29000, 1, '11/4/2004');
INSERT INTO person VALUES(179, 'Hanna', 'Zemanov�','F', '22',  25000, 2, '9.12.2018');
INSERT INTO person VALUES(180, 'Augustin', 'Wagner ','M', '64',  34000, 2, '14/8/2003');
INSERT INTO person VALUES(181, 'Iryna', 'Kasalov�','F', '29',  41000, 2, '27.1.2008');
INSERT INTO person VALUES(182, 'Bohum�r', 'Hr?za ','M', '47',  39000, 2, '15/11/2015');
INSERT INTO person VALUES(183, 'Radana', 'Petr�kov�','F', '60',  12000, 2, '22.11.2004');
INSERT INTO person VALUES(184, 'Oto', 'Knap ','M', '24',  12000, 2, '22/11/2010');
INSERT INTO person VALUES(185, 'Lucie', 'Str�nsk�','F', '22',  28000, 2, '5.6.2010');
INSERT INTO person VALUES(186, 'Eduard', 'Urbanec ','M', '53',  17000, 2, '1/10/2006');
INSERT INTO person VALUES(187, 'Laura', '�indel�?ov�','F', '53',  36000, 2, '31.3.2007');
INSERT INTO person VALUES(188, 'Juraj', 'Dan?k ','M', '29',  27000, 2, '3/3/2018');
INSERT INTO person VALUES(189, 'Ivana', 'Janatov�','F', '60',  16000, 2, '11.10.2012');
INSERT INTO person VALUES(190, 'Dominik', '�ebesta ','M', '58',  32000, 2, '10/1/2014');
INSERT INTO person VALUES(191, 'Petra', '��pkov�','F', '46',  23000, 1, '7.8.2009');
INSERT INTO person VALUES(192, 'Marian', 'Mu��k ','M', '34',  41000, 1, '17/1/2009');
INSERT INTO person VALUES(193, 'Nela', 'Ku?ov�','F', '54',  47000, 3, '9.10.2016');
INSERT INTO person VALUES(194, 'Jozef', 'Bayer ','M', '62',  46000, 3, '20/5/2008');
INSERT INTO person VALUES(195, 'Michaela', '�kodov�','F', '39',  47000, 1, '15.12.2011');
INSERT INTO person VALUES(196, '�tefan', 'Kalivoda ','M', '39',  19000, 1, '28/4/2016');
INSERT INTO person VALUES(197, 'Linda', 'Dubov�','F', '47',  35000, 2, '16.2.2019');
INSERT INTO person VALUES(198, 'Lubom�r', '?ejka ','M', '21',  24000, 2, '30/8/2015');
INSERT INTO person VALUES(199, 'Dana', 'Grundzov�','F', '31',  34000, 1, '23.4.2014');
INSERT INTO person VALUES(200, 'Patrik', 'Kova?�k ','M', '45',  34000, 1, '14/3/2007');
INSERT INTO person VALUES(201, 'Darina', 'Havelkov�','F', '40',  22000, 2, '29.1.2005');
INSERT INTO person VALUES(202, 'Jakub', 'Hanus ','M', '27',  39000, 2, '16/7/2006');
INSERT INTO person VALUES(203, 'Karolina', 'Hor?�kov�','F', '47',  38000, 3, '12.8.2010');
INSERT INTO person VALUES(204, 'J?lius', 'St�rek ','M', '56',  44000, 3, '17/10/2018');
INSERT INTO person VALUES(205, 'Maria', 'Lebedov�','F', '33',  45000, 2, '8.6.2007');
INSERT INTO person VALUES(206, 'Svatoslav', 'Pil�t ','M', '32',  17000, 2, '25/10/2013');
INSERT INTO person VALUES(207, 'Valerie', 'Frankov�','F', '40',  25000, 3, '19.12.2012');
INSERT INTO person VALUES(208, 'Leo', 'Ju?�k ','M', '61',  22000, 3, '2/9/2009');
INSERT INTO person VALUES(209, 'Jarom�ra', 'Koubov�','F', '25',  33000, 2, '15.10.2009');
INSERT INTO person VALUES(210, 'Stepan', 'Bauer ','M', '37',  31000, 2, '9/9/2004');
INSERT INTO person VALUES(211, 'Milu�ka', 'Hofmanov�','F', '57',  41000, 1, '11.8.2006');
INSERT INTO person VALUES(212, 'Vladim�r', 'Ol�h ','M', '60',  41000, 1, '11/2/2016');
INSERT INTO person VALUES(213, 'Valerie', 'Chadimov�','F', '64',  20000, 2, '22.2.2012');
INSERT INTO person VALUES(214, 'R�bert', 'Jan�?ek ','M', '43',  46000, 2, '20/12/2011');
INSERT INTO person VALUES(215, 'Kl�ra', 'Mat?jkov�','F', '27',  44000, 3, '26.4.2019');
INSERT INTO person VALUES(216, 'Ferdinand', 'Havl�?ek ','M', '25',  15000, 3, '22/4/2011');
INSERT INTO person VALUES(217, 'Gertruda', '�est�kov�','F', '57',  44000, 2, '30.6.2014');
INSERT INTO person VALUES(218, 'Emanuel', 'Kolman ','M', '48',  24000, 2, '31/3/2019');
INSERT INTO person VALUES(219, 'Daniela', 'Korbelov�','F', '19',  32000, 3, '8.4.2005');
INSERT INTO person VALUES(220, '?estm�r', 'Anto� ','M', '30',  29000, 3, '1/8/2018');
INSERT INTO person VALUES(221, 'Regina', 'Cinov�','F', '49',  31000, 1, '6.11.2016');
INSERT INTO person VALUES(222, 'Andrej', 'Chalupa ','M', '53',  39000, 1, '14/2/2010');
INSERT INTO person VALUES(223, 'Nad?�da', 'Kar�skov�','F', '58',  19000, 3, '16.8.2007');
INSERT INTO person VALUES(224, 'Arno�t', 'Rozsypal ','M', '35',  43000, 3, '17/6/2009');
INSERT INTO person VALUES(225, 'Daniela', 'Dufkov�','F', '43',  27000, 2, '11.6.2004');
INSERT INTO person VALUES(226, 'Ondrej', 'Ot�hal ','M', '57',  17000, 2, '24/6/2004');
INSERT INTO person VALUES(227, 'M�ria', 'Sva?inov�','F', '51',  43000, 2, '23.12.2009');
INSERT INTO person VALUES(228, 'Marcel', 'Tich� ','M', '40',  22000, 2, '26/9/2016');
INSERT INTO person VALUES(229, 'Ane�ka', 'Hanzalov�','F', '36',  14000, 2, '18.10.2006');
INSERT INTO person VALUES(230, 'Pavol', 'Popelka ','M', '63',  31000, 2, '4/10/2011');
INSERT INTO person VALUES(231, 'Sabina', 'Buchtov�','F', '43',  30000, 2, '30.4.2012');
INSERT INTO person VALUES(232, 'Ivo', '?onka ','M', '46',  36000, 2, '12/8/2007');
INSERT INTO person VALUES(233, 'M�ria', 'Kola?�kov�','F', '29',  38000, 2, '24.2.2009');
INSERT INTO person VALUES(234, 'Bohumir', 'Hor?�k ','M', '22',  45000, 2, '13/1/2019');
INSERT INTO person VALUES(235, 'S�ra', '�torkov�','F', '36',  18000, 2, '7.9.2014');
INSERT INTO person VALUES(236, 'Vojt?ch', 'Horn�k ','M', '51',  15000, 2, '21/11/2014');
INSERT INTO person VALUES(237, 'Tatiana', 'Va��?kov�','F', '45',  41000, 3, '16.6.2005');
INSERT INTO person VALUES(238, 'Martin', 'Hole?ek ','M', '33',  19000, 3, '24/3/2014');
INSERT INTO person VALUES(239, 'Miriam', 'Ko?�nkov�','F', '30',  13000, 2, '5.9.2018');
INSERT INTO person VALUES(240, 'Robert', 'Vyb�ral ','M', '55',  29000, 2, '1/4/2009');
INSERT INTO person VALUES(241, 'Hana', 'Zezulov�','F', '37',  29000, 3, '24.10.2007');
INSERT INTO person VALUES(242, 'Artur', 'Voln� ','M', '38',  34000, 3, '7/2/2005');
INSERT INTO person VALUES(243, 'Natalie', 'Rozsypalov�','F', '23',  37000, 2, '19.8.2004');
INSERT INTO person VALUES(244, 'Anton�n', 'Neuman ','M', '60',  43000, 2, '11/7/2016');
INSERT INTO person VALUES(245, 'Martina', 'Matu�kov�','F', '30',  16000, 3, '2.3.2010');
INSERT INTO person VALUES(246, 'Gerhard', 'Pracha? ','M', '43',  12000, 3, '19/5/2012');
INSERT INTO person VALUES(247, 'Anna', 'Hub�?kov�','F', '62',  24000, 2, '26.12.2006');
INSERT INTO person VALUES(248, 'Petr', 'Richter ','M', '20',  21000, 2, '27/5/2007');
INSERT INTO person VALUES(249, 'Zuzana', 'Be?kov�','F', '23',  40000, 3, '8.7.2012');
INSERT INTO person VALUES(250, 'Cyril', 'Pt�?ek ','M', '49',  27000, 3, '29/8/2019');
INSERT INTO person VALUES(251, 'Jitka', 'Linkov�','F', '54',  47000, 2, '4.5.2009');
INSERT INTO person VALUES(252, 'Herbert', 'Dubsk� ','M', '25',  36000, 2, '5/9/2014');
INSERT INTO person VALUES(253, 'Leona', 'Mackov�','F', '63',  35000, 3, '6.7.2016');
INSERT INTO person VALUES(254, 'Juli�s', 'Vin� ','M', '53',  41000, 3, '6/1/2014');
INSERT INTO person VALUES(255, 'Bo�ena', 'Ka�p�rkov�','F', '47',  35000, 2, '11.9.2011');
INSERT INTO person VALUES(256, 'J�lius', 'Vav?�k ','M', '30',  14000, 2, '22/7/2005');
INSERT INTO person VALUES(257, 'Vladislava', 'Slov�?kov�','F', '56',  23000, 3, '13.11.2018');
INSERT INTO person VALUES(258, 'Viliam', 'Tomek ','M', '58',  19000, 3, '22/11/2004');
INSERT INTO person VALUES(259, 'Leona', 'Kom�nkov�','F', '41',  30000, 2, '8.9.2015');
INSERT INTO person VALUES(260, 'Bruno', 'Vondr�k ','M', '35',  28000, 2, '24/4/2016');
INSERT INTO person VALUES(261, 'Marie', 'Bayerov�','F', '50',  18000, 3, '17.6.2006');
INSERT INTO person VALUES(262, 'Norbert', 'Jen�?ek ','M', '63',  33000, 3, '27/8/2015');
INSERT INTO person VALUES(263, 'Dita', 'Radov�','F', '34',  18000, 2, '15.1.2018');
INSERT INTO person VALUES(264, 'Hubert', 'Ne�por ','M', '40',  43000, 2, '11/3/2007');
INSERT INTO person VALUES(265, 'Lucie', 'Pa�kov�','F', '42',  42000, 3, '24.10.2008');
INSERT INTO person VALUES(266, 'Dan', 'Malina ','M', '22',  47000, 3, '12/7/2006');
INSERT INTO person VALUES(267, 'Elena', 'Ji?�kov�','F', '26',  41000, 2, '30.12.2003');
INSERT INTO person VALUES(268, 'Karol', 'David ','M', '45',  21000, 2, '20/6/2014');
INSERT INTO person VALUES(269, 'Ji?ina', 'Pe�kov�','F', '35',  29000, 3, '3.3.2011');
INSERT INTO person VALUES(270, 'Radoslav', 'Hartman ','M', '27',  26000, 3, '21/10/2013');
INSERT INTO person VALUES(271, 'Lucie', 'Havl�?kov�','F', '20',  37000, 2, '27.12.2007');
INSERT INTO person VALUES(272, 'Albert', 'Kolman ','M', '49',  35000, 2, '28/10/2008');
INSERT INTO person VALUES(273, 'Libu�e', 'T�thov�','F', '28',  17000, 3, '9.7.2013');
INSERT INTO person VALUES(274, 'Kry�tof', 'Strej?ek ','M', '32',  40000, 3, '6/9/2004');
INSERT INTO person VALUES(275, 'Ivana', 'Cihl�?ov�','F', '59',  24000, 2, '5.5.2010');
INSERT INTO person VALUES(276, 'Bohdan', 'Chalupa ','M', '55',  13000, 2, '7/2/2016');
INSERT INTO person VALUES(277, 'Iveta', 'Kucha?ov�','F', '20',  40000, 3, '16.11.2015');
INSERT INTO person VALUES(278, 'Ludv�k', 'Kozel ','M', '38',  19000, 3, '17/12/2011');
INSERT INTO person VALUES(279, 'Nela', 'Dole?kov�','F', '53',  20000, 3, '3.5.2014');
INSERT INTO person VALUES(280, 'Petro', 'H?lka ','M', '59',  27000, 3, '18/6/2010');
INSERT INTO person VALUES(281, 'Sylva', 'Tome?kov�','F', '60',  36000, 3, '21.6.2003');
INSERT INTO person VALUES(282, 'Marian', 'Tich� ','M', '42',  32000, 3, '26/4/2006');
INSERT INTO person VALUES(283, 'Linda', 'Posp�chalov�','F', '46',  43000, 3, '8.9.2016');
INSERT INTO person VALUES(284, 'Boris', 'Popelka ','M', '64',  42000, 3, '27/9/2017');
INSERT INTO person VALUES(285, 'Maria', 'Barto�ov�','F', '53',  23000, 3, '28.10.2005');
INSERT INTO person VALUES(286, '�tefan', '?onka ','M', '47',  47000, 3, '5/8/2013');
INSERT INTO person VALUES(287, 'Darina', 'R?�i?kov�','F', '39',  31000, 2, '16.1.2019');
INSERT INTO person VALUES(288, 'Robin', 'Hor?�k ','M', '24',  20000, 2, '12/8/2008');
INSERT INTO person VALUES(289, 'Karolina', 'Hanusov�','F', '46',  47000, 3, '5.3.2008');
INSERT INTO person VALUES(290, 'Bohumil', 'Horn�k ','M', '52',  25000, 3, '21/6/2004');
INSERT INTO person VALUES(291, 'Maria', 'Boudov�','F', '31',  18000, 2, '30.12.2004');
INSERT INTO person VALUES(292, 'Vratislav', 'Kala� ','M', '29',  34000, 2, '22/11/2015');
INSERT INTO person VALUES(293, 'Mark�ta', 'Linkov�','F', '40',  42000, 3, '3.3.2012');
INSERT INTO person VALUES(294, '�t?p�n', '�af�? ','M', '57',  39000, 3, '25/3/2015');
INSERT INTO person VALUES(295, 'Renata', 'Chytilov�','F', '47',  22000, 4, '14.9.2017');
INSERT INTO person VALUES(296, 'Po?et', 'Voln� ','M', '40',  44000, 4, '1/2/2011');
INSERT INTO person VALUES(297, 'R?�ena', 'Ka�p�rkov�','F', '33',  30000, 3, '11.7.2014');
INSERT INTO person VALUES(298, 'Jind?ich', 'Neuman ','M', '62',  18000, 3, '8/2/2006');
INSERT INTO person VALUES(299, 'Milu�e', 'Svobodov�','F', '40',  45000, 4, '29.8.2003');
INSERT INTO person VALUES(300, 'Stepan', 'Pracha? ','M', '45',  23000, 4, '13/5/2018');
INSERT INTO person VALUES(301, 'Kl�ra', 'Kubi�tov�','F', '25',  17000, 3, '16.11.2016');
INSERT INTO person VALUES(302, 'Vladim�r', 'Richter ','M', '21',  32000, 3, '20/5/2013');
INSERT INTO person VALUES(303, 'Eli�ka', 'Michlov�','F', '57',  25000, 2, '12.9.2013');
INSERT INTO person VALUES(304, 'Bohuslav', '�est�k ','M', '44',  41000, 2, '27/5/2008');
INSERT INTO person VALUES(305, 'Milu�e', 'Lackov�','F', '64',  40000, 3, '26.3.2019');
INSERT INTO person VALUES(306, 'Ernest', 'Dubsk� ','M', '27',  46000, 3, '5/4/2004');
INSERT INTO person VALUES(307, 'Nina', 'Kolkov�','F', '27',  28000, 4, '2.1.2010');
INSERT INTO person VALUES(308, 'Oskar', 'Podzimek ','M', '55',  15000, 4, '7/8/2003');
INSERT INTO person VALUES(309, 'Nad?�da', 'Kohoutov�','F', '57',  28000, 3, '9.3.2005');
INSERT INTO person VALUES(310, 'Vladan', 'Vav?�k ','M', '32',  25000, 3, '16/7/2011');
INSERT INTO person VALUES(311, 'Em�lia', 'Pla?kov�','F', '19',  16000, 4, '11.5.2012');
INSERT INTO person VALUES(312, '?ubom�r', 'Tomek ','M', '60',  29000, 4, '16/11/2010');
INSERT INTO person VALUES(313, 'Al�b?ta', 'Karlov�','F', '49',  15000, 2, '16.7.2007');
INSERT INTO person VALUES(314, 'Norbert', 'Kub�?ek ','M', '37',  39000, 2, '24/10/2018');
INSERT INTO person VALUES(315, 'Olena', 'Nedomov�','F', '58',  39000, 4, '17.9.2014');
INSERT INTO person VALUES(316, 'Jon�', 'Smola ','M', '19',  44000, 4, '25/2/2018');
INSERT INTO person VALUES(317, 'Tatiana', 'Jan�kov�','F', '19',  19000, 4, '5.11.2003');
INSERT INTO person VALUES(318, 'Marcel', 'Hejduk ','M', '48',  13000, 4, '3/1/2014');
INSERT INTO person VALUES(319, 'Radom�ra', 'Jankov�','F', '51',  27000, 3, '24.1.2017');
INSERT INTO person VALUES(320, 'Pavol', 'Jirka ','M', '24',  22000, 3, '10/1/2009');
INSERT INTO person VALUES(321, 'V?ra', 'Petrov�','F', '58',  43000, 4, '14.3.2006');
INSERT INTO person VALUES(322, 'Rostislav', 'Pluha? ','M', '53',  28000, 4, '19/11/2004');
INSERT INTO person VALUES(323, 'Tatiana', 'Ka�parov�','F', '43',  14000, 3, '3.6.2019');
INSERT INTO person VALUES(324, 'Bohum�r', '�t?rba ','M', '30',  37000, 3, '21/4/2016');
INSERT INTO person VALUES(325, 'Radom�ra', 'Pavl�kov�','F', '29',  22000, 3, '29.3.2016');
INSERT INTO person VALUES(326, 'Oto', 'Kaplan ','M', '52',  46000, 3, '29/4/2011');
INSERT INTO person VALUES(327, 'Hana', 'Vrabcov�','F', '36',  38000, 3, '17.5.2005');
INSERT INTO person VALUES(328, 'Eduard', 'Kope?n� ','M', '35',  15000, 3, '8/3/2007');
INSERT INTO person VALUES(329, 'Alexandra', 'Dr�palov�','F', '45',  26000, 4, '18.7.2012');
INSERT INTO person VALUES(330, 'Mat?j', '�t?p�nek ','M', '63',  20000, 4, '9/7/2006');
INSERT INTO person VALUES(331, 'Martina', '��?kov�','F', '29',  25000, 3, '23.9.2007');
INSERT INTO person VALUES(332, 'Dominik', 'Dole?ek ','M', '40',  30000, 3, '17/6/2014');
INSERT INTO person VALUES(333, 'Jolana', 'Kantorov�','F', '37',  13000, 4, '25.11.2014');
INSERT INTO person VALUES(334, 'Anton�n', 'Demeter ','M', '22',  34000, 4, '18/10/2013');
INSERT INTO person VALUES(335, 'Zuzana', 'Vydrov�','F', '22',  13000, 3, '30.1.2010');
INSERT INTO person VALUES(336, 'Marek', 'Mike� ','M', '45',  44000, 3, '2/5/2005');
INSERT INTO person VALUES(337, 'Ta �na', 'S�korov�','F', '30',  36000, 4, '3.4.2017');
INSERT INTO person VALUES(338, 'Petr', 'P�cha ','M', '27',  13000, 4, '3/9/2004');
INSERT INTO person VALUES(339, 'Vlastimila', 'Cihl�?ov�','F', '37',  16000, 4, '22.5.2006');
INSERT INTO person VALUES(340, 'Petro', 'Krupka ','M', '56',  18000, 4, '5/12/2016');
INSERT INTO person VALUES(341, 'Ivanka', '?adov�','F', '23',  24000, 4, '11.8.2019');
INSERT INTO person VALUES(342, 'Vladimir', 'Bla�ek ','M', '33',  27000, 4, '13/12/2011');
INSERT INTO person VALUES(343, 'Vladislava', 'Koukalov�','F', '54',  32000, 3, '5.6.2016');
INSERT INTO person VALUES(344, 'Jakub', 'Hampl ','M', '55',  36000, 3, '21/12/2006');
INSERT INTO person VALUES(345, 'Vlastimila', 'Pt�?kov�','F', '62',  47000, 3, '24.7.2005');
INSERT INTO person VALUES(346, 'J?lius', 'Sochor ','M', '38',  42000, 3, '24/3/2019');
INSERT INTO person VALUES(347, 'Elena', 'Vr�nov�','F', '47',  19000, 3, '13.10.2018');
INSERT INTO person VALUES(348, 'Svatoslav', 'Hrabal ','M', '60',  15000, 3, '1/4/2014');
INSERT INTO person VALUES(349, 'Monika', 'Vyb�ralov�','F', '56',  43000, 4, '22.7.2009');
INSERT INTO person VALUES(350, 'Nikola', 'Kohout ','M', '42',  19000, 4, '2/8/2013');
INSERT INTO person VALUES(351, '��rka', 'R?�i?kov�','F', '63',  23000, 4, '2.2.2015');
INSERT INTO person VALUES(352, 'Matou�', 'Sl�ma ','M', '25',  25000, 4, '10/6/2009');
INSERT INTO person VALUES(353, 'Marta', 'Brabencov�','F', '48',  30000, 4, '29.11.2011');
INSERT INTO person VALUES(354, 'Hubert', 'Klement ','M', '48',  34000, 4, '18/6/2004');
INSERT INTO person VALUES(355, 'Simona', 'Boudov�','F', '56',  46000, 4, '11.6.2017');
INSERT INTO person VALUES(356, 'Hynek', 'Chmela? ','M', '31',  39000, 4, '19/9/2016');
INSERT INTO person VALUES(357, '��rka', '?ernochov�','F', '41',  18000, 4, '6.4.2014');
INSERT INTO person VALUES(358, 'Ferdinand', 'B�na ','M', '53',  12000, 4, '27/9/2011');
INSERT INTO person VALUES(359, 'Marta', 'Sukov�','F', '27',  25000, 3, '31.1.2011');
INSERT INTO person VALUES(360, 'Alex', 'Navr�til ','M', '29',  22000, 3, '5/10/2006');
INSERT INTO person VALUES(361, 'Radka', 'Hlav�?kov�','F', '34',  41000, 3, '13.8.2016');
INSERT INTO person VALUES(362, '?estm�r', 'Slav�k ','M', '58',  27000, 3, '6/1/2019');
INSERT INTO person VALUES(363, 'Vanda', 'Klementov�','F', '42',  29000, 1, '23.5.2007');
INSERT INTO person VALUES(364, 'Otto', 'Jake� ','M', '40',  31000, 1, '9/5/2018');
INSERT INTO person VALUES(365, 'Ilona', 'P�ov�','F', '27',  29000, 3, '21.12.2018');
INSERT INTO person VALUES(366, 'Arno�t', 'Voj�?ek ','M', '63',  41000, 3, '22/11/2009');
INSERT INTO person VALUES(367, 'Zlata', 'Michlov�','F', '35',  17000, 4, '29.9.2009');
INSERT INTO person VALUES(368, 'Ludv�k', 'Michna ','M', '45',  46000, 4, '25/3/2009');
INSERT INTO person VALUES(369, 'Danu�e', 'Bal�ov�','F', '19',  16000, 3, '4.12.2004');
INSERT INTO person VALUES(370, 'Marcel', 'P�a ','M', '23',  20000, 3, '3/3/2017');
INSERT INTO person VALUES(371, 'Aloisie', 'Kyselov�','F', '28',  40000, 4, '6.2.2012');
INSERT INTO person VALUES(372, 'Richard', 'Vondr�?ek ','M', '51',  24000, 4, '4/7/2016');
INSERT INTO person VALUES(373, 'Zora', 'Strakov�','F', '35',  20000, 1, '19.8.2017');
INSERT INTO person VALUES(374, 'V?roslav', '�imon ','M', '34',  30000, 1, '12/5/2012');
INSERT INTO person VALUES(375, 'Zd?nka', 'Bro�ov�','F', '20',  28000, 4, '14.6.2014');
INSERT INTO person VALUES(376, 'Miloslav', 'Kudl�?ek ','M', '56',  39000, 4, '21/5/2007');
INSERT INTO person VALUES(377, 'Aloisie', 'Jaro�ov�','F', '52',  35000, 3, '10.4.2011');
INSERT INTO person VALUES(378, 'Emil', 'V�ek ','M', '32',  12000, 3, '21/10/2018');
INSERT INTO person VALUES(379, 'Radana', 'M�chov�','F', '59',  15000, 4, '21.10.2016');
INSERT INTO person VALUES(380, 'Martin', 'Ba�ta ','M', '61',  17000, 4, '29/8/2014');
INSERT INTO person VALUES(381, 'Hanna', 'Mach�lkov�','F', '45',  23000, 3, '17.8.2013');
INSERT INTO person VALUES(382, 'Robert', '�indel�? ','M', '38',  26000, 3, '6/9/2009');
INSERT INTO person VALUES(383, 'Iryna', 'Burdov�','F', '52',  38000, 4, '28.2.2019');
INSERT INTO person VALUES(384, 'Artur', 'Star� ','M', '20',  32000, 4, '15/7/2005');
INSERT INTO person VALUES(385, 'Antonie', 'Hrn?�?ov�','F', '60',  26000, 1, '7.12.2009');
INSERT INTO person VALUES(386, 'Erv�n', 'Be?v�? ','M', '48',  36000, 1, '16/11/2004');
INSERT INTO person VALUES(387, 'Vendula', 'Hladk�','F', '46',  34000, 4, '2.10.2006');
INSERT INTO person VALUES(388, 'Ji?�', 'Nedoma ','M', '25',  45000, 4, '18/4/2016');
INSERT INTO person VALUES(389, 'V�clava', 'Pavl�kov�','F', '53',  14000, 1, '14.4.2012');
INSERT INTO person VALUES(390, 'Gabriel', 'Sedl�?ek ','M', '54',  15000, 1, '25/2/2012');
INSERT INTO person VALUES(391, 'Antonie', 'Dost�lov�','F', '39',  21000, 4, '8.2.2009');
INSERT INTO person VALUES(392, 'Vojtech', 'Tu?ek ','M', '30',  24000, 4, '5/3/2007');
INSERT INTO person VALUES(393, 'Linda', 'Zav?elov�','F', '46',  37000, 4, '22.8.2014');
INSERT INTO person VALUES(394, 'Drahom�r', 'Lacina ','M', '59',  29000, 4, '6/6/2019');
INSERT INTO person VALUES(395, 'Nela', 'Pe�tov�','F', '31',  45000, 4, '18.6.2011');
INSERT INTO person VALUES(396, 'Juli�s', 'Neubauer ','M', '35',  38000, 4, '13/6/2014');
INSERT INTO person VALUES(397, 'Sylva', 'Kroupov�','F', '39',  25000, 4, '29.12.2016');
INSERT INTO person VALUES(398, 'Tade�', 'Korbel ','M', '64',  44000, 4, '22/4/2010');
INSERT INTO person VALUES(399, 'Terezie', 'Dlouh�','F', '24',  32000, 4, '25.10.2013');
INSERT INTO person VALUES(400, 'Viliam', 'Kab�t ','M', '41',  17000, 4, '29/4/2005');
INSERT INTO person VALUES(401, 'Maria', 'Kupcov�','F', '31',  12000, 4, '8.5.2019');
INSERT INTO person VALUES(402, 'B?etislav', 'Ku?era ','M', '24',  22000, 4, '1/8/2017');
INSERT INTO person VALUES(403, 'Darina', 'H?lkov�','F', '63',  20000, 3, '2.3.2016');
INSERT INTO person VALUES(404, 'Matou�', 'Uher ','M', '46',  31000, 3, '8/8/2012');
INSERT INTO person VALUES(405, 'Zde?ka', 'H�jkov�','F', '25',  44000, 1, '10.12.2006');
INSERT INTO person VALUES(406, 'Denis', 'Karban ','M', '28',  36000, 1, '10/12/2011');
INSERT INTO person VALUES(407, 'R?�ena', 'Koukalov�','F', '33',  23000, 1, '22.6.2012');
INSERT INTO person VALUES(408, 'Rudolf', 'Rambousek ','M', '57',  41000, 1, '19/10/2007');
INSERT INTO person VALUES(409, 'Mark�ta', 'Sk�celov�','F', '64',  31000, 4, '18.4.2009');
INSERT INTO person VALUES(410, 'Dalibor', 'Sedl�k ','M', '33',  14000, 4, '21/3/2019');
INSERT INTO person VALUES(411, 'Kl�ra', 'Vr�nov�','F', '25',  47000, 1, '30.10.2014');
INSERT INTO person VALUES(412, 'Michal', 'Pavelka ','M', '62',  20000, 1, '27/1/2015');
INSERT INTO person VALUES(413, 'Eli�ka', 'Adamcov�','F', '57',  19000, 4, '26.8.2011');
INSERT INTO person VALUES(414, 'Lud?k', 'Slab� ','M', '38',  29000, 4, '4/2/2010');
INSERT INTO person VALUES(415, 'Milu�e', 'Pape�ov�','F', '64',  34000, 1, '8.3.2017');
INSERT INTO person VALUES(416, 'Nicolas', 'Gajdo� ','M', '21',  34000, 1, '13/12/2005');
INSERT INTO person VALUES(417, 'Kl�ra', 'Ml�dkov�','F', '50',  42000, 4, '1.1.2014');
INSERT INTO person VALUES(418, 'Ivan', 'Michal�k ','M', '44',  43000, 4, '16/5/2017');
INSERT INTO person VALUES(419, 'Nad?�da', 'Dr�bkov�','F', '57',  22000, 1, '15.7.2019');
INSERT INTO person VALUES(420, 'Alex', '��p ','M', '27',  13000, 1, '24/3/2013');
INSERT INTO person VALUES(421, 'Daniela', 'Mare?kov�','F', '42',  29000, 4, '10.5.2016');
INSERT INTO person VALUES(422, 'Franti�ek', 'Janda ','M', '49',  22000, 4, '31/3/2008');
INSERT INTO person VALUES(423, 'Nina', 'Sukov�','F', '51',  17000, 1, '17.2.2007');
INSERT INTO person VALUES(424, 'Boleslav', 'Merta ','M', '31',  26000, 1, '3/8/2007');
INSERT INTO person VALUES(425, 'Nad?�da', 'Kal�bov�','F', '35',  17000, 4, '17.9.2018');
INSERT INTO person VALUES(426, 'Ruslan', 'Hus�k ','M', '54',  36000, 4, '11/7/2015');
INSERT INTO person VALUES(427, 'Em�lia', 'Janou�kov�','F', '44',  41000, 1, '26.6.2009');
INSERT INTO person VALUES(428, 'Mario', 'Motl ','M', '36',  41000, 1, '11/11/2014');
INSERT INTO person VALUES(429, 'Zlatu�e', 'P�ov�','F', '51',  21000, 1, '7.1.2015');
INSERT INTO person VALUES(430, 'Mykola', 'Mac�k ','M', '19',  46000, 1, '20/9/2010');
INSERT INTO person VALUES(431, 'Na?a', '?ernohorsk�','F', '36',  28000, 1, '2.11.2011');
INSERT INTO person VALUES(432, 'Lubor', '�ediv� ','M', '41',  19000, 1, '27/9/2005');
INSERT INTO person VALUES(433, 'Tatiana', 'Bal�ov�','F', '44',  44000, 1, '15.5.2017');
INSERT INTO person VALUES(434, 'P?emysl', 'B�l� ','M', '24',  24000, 1, '30/12/2017');
INSERT INTO person VALUES(435, 'Radom�ra', 'Dole�elov�','F', '29',  16000, 1, '11.3.2014');
INSERT INTO person VALUES(436, 'Leopold', 'Dvorsk� ','M', '47',  34000, 1, '6/1/2013');
INSERT INTO person VALUES(437, 'Na?a', 'P�nkov�','F', '60',  23000, 4, '5.1.2011');
INSERT INTO person VALUES(438, 'Erv�n', 'Kala ','M', '23',  43000, 4, '14/1/2008');
INSERT INTO person VALUES(439, 'Natalie', 'Syrov�','F', '22',  39000, 4, '18.7.2016');
INSERT INTO person VALUES(440, 'Ev�en', 'Moln�r ','M', '52',  12000, 4, '23/11/2003');
INSERT INTO person VALUES(441, 'Bla�ena', 'Jaro�ov�','F', '30',  27000, 1, '27.4.2007');
INSERT INTO person VALUES(442, 'Maty�', 'Hlou�ek ','M', '34',  17000, 1, '19/8/2019');
INSERT INTO person VALUES(443, 'Hana', 'Hynkov�','F', '60',  27000, 4, '25.11.2018');
INSERT INTO person VALUES(444, 'Radovan', 'Sobotka ','M', '57',  27000, 4, '3/3/2011');
INSERT INTO person VALUES(445, 'Kv?tu�e', 'Mach�lkov�','F', '23',  15000, 1, '3.9.2009');
INSERT INTO person VALUES(446, 'J�n', 'Polansk� ','M', '39',  31000, 1, '5/7/2010');
INSERT INTO person VALUES(447, 'Jitka', 'Motlov�','F', '53',  14000, 4, '7.11.2004');
INSERT INTO person VALUES(448, 'Jozef', 'Hrbek ','M', '63',  41000, 4, '12/6/2018');
INSERT INTO person VALUES(449, 'Jolana', 'Smetanov�','F', '62',  38000, 1, '10.1.2012');
INSERT INTO person VALUES(450, 'Adam', 'Jakoubek ','M', '45',  46000, 1, '13/10/2017');
INSERT INTO person VALUES(451, 'Kv?tu�e', '�varcov�','F', '47',  46000, 4, '5.11.2008');
INSERT INTO person VALUES(452, '�imon', '�koda ','M', '21',  19000, 4, '21/10/2012');
INSERT INTO person VALUES(453, 'Vladislava', 'Tvrd�','F', '54',  25000, 1, '19.5.2014');
INSERT INTO person VALUES(454, 'David', 'Buchta ','M', '50',  24000, 1, '29/8/2008');
INSERT INTO person VALUES(455, 'Leona', 'Menclov�','F', '40',  33000, 4, '15.3.2011');
INSERT INTO person VALUES(456, 'Alois', 'Mar��k ','M', '26',  33000, 4, '7/9/2003');
INSERT INTO person VALUES(457, 'Ivanka', 'Langov�','F', '47',  13000, 1, '25.9.2016');
INSERT INTO person VALUES(458, 'Prokop', 'Ma?�k ','M', '55',  39000, 1, '9/12/2015');
INSERT INTO person VALUES(459, 'Vladislava', 'Kozlov�','F', '33',  21000, 4, '21.7.2013');
INSERT INTO person VALUES(460, 'Old?ich', 'Je� ','M', '31',  12000, 4, '16/12/2010');
INSERT INTO person VALUES(461, 'Jindra', 'Niklov�','F', '40',  36000, 1, '1.2.2019');
INSERT INTO person VALUES(462, 'Bruno', 'H�bl ','M', '60',  17000, 1, '25/10/2006');
INSERT INTO person VALUES(463, 'Marta', 'Dlouh�','F', '48',  24000, 2, '10.11.2009');
INSERT INTO person VALUES(464, 'Drahoslav', 'Jav?rek ','M', '42',  22000, 2, '25/2/2006');
INSERT INTO person VALUES(465, '�ofie', 'Jav?rkov�','F', '33',  24000, 4, '15.1.2005');
INSERT INTO person VALUES(466, 'Hubert', 'Jon� ','M', '20',  31000, 4, '3/2/2014');
INSERT INTO person VALUES(467, '��rka', 'H?lkov�','F', '41',  12000, 2, '19.3.2012');
INSERT INTO person VALUES(468, 'Dan', 'R?�ek ','M', '48',  36000, 2, '6/6/2013');
INSERT INTO person VALUES(469, 'Marta', 'B�nov�','F', '27',  19000, 1, '13.1.2009');
INSERT INTO person VALUES(470, 'Ctibor', 'Bl�ha ','M', '24',  45000, 1, '13/6/2008');
INSERT INTO person VALUES(471, 'Radka', 'Kupkov�','F', '34',  35000, 1, '27.7.2014');
INSERT INTO person VALUES(472, 'Radoslav', 'Kova?�k ','M', '53',  14000, 1, '22/4/2004');
INSERT INTO person VALUES(473, 'Iveta', 'Melicharov�','F', '19',  43000, 1, '23.5.2011');
INSERT INTO person VALUES(474, 'Albert', 'Homolka ','M', '29',  24000, 1, '23/9/2015');
INSERT INTO person VALUES(475, 'Diana', 'Pavlov�','F', '28',  31000, 2, '24.7.2018');
INSERT INTO person VALUES(476, 'Gustav', 'Mou?ka ','M', '57',  28000, 2, '24/1/2015');
INSERT INTO person VALUES(477, 'Sylva', 'Hou�kov�','F', '59',  38000, 1, '20.5.2015');
INSERT INTO person VALUES(478, 'Walter', 'Hlav�?ek ','M', '34',  37000, 1, '31/1/2010');
INSERT INTO person VALUES(479, 'Katar�na', 'Richterov�','F', '21',  18000, 2, '7.7.2004');
INSERT INTO person VALUES(480, 'Kv?toslav', 'Kub�t ','M', '62',  43000, 2, '10/12/2005');
INSERT INTO person VALUES(481, 'Sv?tlana', '?͎kov�','F', '52',  26000, 1, '26.9.2017');
INSERT INTO person VALUES(482, 'Petro', '�olc ','M', '39',  16000, 1, '12/5/2017');
INSERT INTO person VALUES(483, 'Zlata', 'Koudelov�','F', '59',  42000, 2, '14.11.2006');
INSERT INTO person VALUES(484, 'Igor', 'Balcar ','M', '22',  21000, 2, '21/3/2013');
INSERT INTO person VALUES(485, 'Karolina', 'Kade?�bkov�','F', '45',  13000, 1, '10.9.2003');
INSERT INTO person VALUES(486, 'Boris', 'Zv??ina ','M', '44',  30000, 1, '28/3/2008');
INSERT INTO person VALUES(487, 'Olga', 'Ko�kov�','F', '53',  37000, 2, '11.11.2010');
INSERT INTO person VALUES(488, 'Tade�', 'B�l� ','M', '26',  35000, 2, '30/7/2007');
INSERT INTO person VALUES(489, 'D�a', 'Vlas�kov�','F', '37',  37000, 1, '16.1.2006');
INSERT INTO person VALUES(490, 'Robin', 'Jedli?ka ','M', '49',  45000, 1, '8/7/2015');
INSERT INTO person VALUES(491, 'Renata', '�indlerov�','F', '46',  25000, 2, '20.3.2013');
INSERT INTO person VALUES(492, 'Vil�m', 'Petr? ','M', '31',  13000, 2, '8/11/2014');
INSERT INTO person VALUES(493, 'Sylvie', 'Kaiserov�','F', '30',  24000, 1, '25.5.2008');
INSERT INTO person VALUES(494, 'Vratislav', 'Dudek ','M', '55',  23000, 1, '24/5/2006');
INSERT INTO person VALUES(495, 'Denisa', 'Mach�?kov�','F', '39',  12000, 2, '28.7.2015');
INSERT INTO person VALUES(496, '�t?p�n', 'Seifert ','M', '37',  28000, 2, '24/9/2005');
INSERT INTO person VALUES(497, 'Vendula', 'Najmanov�','F', '46',  28000, 2, '14.9.2004');
INSERT INTO person VALUES(498, 'Po?et', 'H?lka ','M', '20',  33000, 2, '26/12/2017');
INSERT INTO person VALUES(499, 'So?a', 'Fiedlerov�','F', '31',  35000, 2, '4.12.2017');
INSERT INTO person VALUES(500, 'Jind?ich', 'Mina?�k ','M', '42',  42000, 2, '3/1/2013');
INSERT INTO person VALUES(501, 'Milu�e', '�edov�','F', '63',  43000, 1, '29.9.2014');
INSERT INTO person VALUES(502, 'Otakar', 'Hrbek ','M', '64',  16000, 1, '11/1/2008');
INSERT INTO person VALUES(503, 'Vendula', 'Proke�ov�','F', '24',  23000, 1, '17.11.2003');
INSERT INTO person VALUES(504, 'Luk�', 'Schejbal ','M', '47',  21000, 1, '19/11/2003');
INSERT INTO person VALUES(505, 'So?a', 'Luke�ov�','F', '56',  31000, 1, '5.2.2017');
INSERT INTO person VALUES(506, 'Bohuslav', 'Bar�k ','M', '23',  30000, 1, '22/4/2015');
INSERT INTO person VALUES(507, 'Julie', 'Krej?�?ov�','F', '63',  46000, 1, '26.3.2006');
INSERT INTO person VALUES(508, 'Ernest', '�im?�k ','M', '52',  35000, 1, '28/2/2011');
INSERT INTO person VALUES(509, 'Zlatu�e', 'Holubov�','F', '25',  34000, 2, '28.5.2013');
INSERT INTO person VALUES(510, 'Oskar', 'Pila? ','M', '34',  40000, 2, '1/7/2010');
INSERT INTO person VALUES(511, 'Nela', 'Houdkov�','F', '56',  34000, 1, '2.8.2008');
INSERT INTO person VALUES(512, 'Vladan', 'V�clav�k ','M', '58',  14000, 1, '9/6/2018');
INSERT INTO person VALUES(513, 'Tati�na', 'Moty?kov�','F', '64',  22000, 2, '5.10.2015');
INSERT INTO person VALUES(514, '?ubom�r', 'Baloun ','M', '40',  18000, 2, '10/10/2017');
INSERT INTO person VALUES(515, 'Terezie', 'M�?kov�','F', '48',  21000, 1, '10.12.2010');
INSERT INTO person VALUES(516, 'Norbert', 'Mi?ka ','M', '63',  28000, 1, '25/4/2009');
INSERT INTO person VALUES(517, 'V?ra', 'Such�nkov�','F', '57',  45000, 2, '10.2.2018');
INSERT INTO person VALUES(518, 'Jon�', '� astn� ','M', '45',  33000, 2, '26/8/2008');
INSERT INTO person VALUES(519, 'Tatiana', 'Hlav�?ov�','F', '42',  17000, 1, '7.12.2014');
INSERT INTO person VALUES(520, 'Zolt�n', 'Jon� ','M', '21',  42000, 1, '3/9/2003');
INSERT INTO person VALUES(521, 'Zde?ka', 'Hl�vkov�','F', '50',  33000, 2, '25.1.2004');
INSERT INTO person VALUES(522, 'Pavol', 'Doubek ','M', '50',  47000, 2, '6/12/2015');
INSERT INTO person VALUES(523, 'V?ra', 'Bart??kov�','F', '35',  40000, 1, '15.4.2017');
INSERT INTO person VALUES(524, 'Radomil', 'Pa�ek ','M', '27',  20000, 1, '13/12/2010');
INSERT INTO person VALUES(525, 'Vlasta', 'Ko?ov�','F', '42',  20000, 2, '3.6.2006');
INSERT INTO person VALUES(526, 'Bohum�r', 'Mat?j�?ek ','M', '55',  26000, 2, '22/10/2006');
INSERT INTO person VALUES(527, 'Martina', 'Hamplov�','F', '28',  28000, 1, '23.8.2019');
INSERT INTO person VALUES(528, 'Oto', 'Br�zdil ','M', '32',  35000, 1, '24/3/2018');
INSERT INTO person VALUES(529, 'Margita', 'T?�skov�','F', '36',  16000, 2, '1.6.2010');
INSERT INTO person VALUES(530, 'Vlastislav', 'Pa?�zek ','M', '60',  39000, 2, '25/7/2017');
INSERT INTO person VALUES(531, 'Old?i�ka', 'M�lkov�','F', '44',  31000, 3, '13.12.2015');
INSERT INTO person VALUES(532, 'Mat?j', 'Vondr�k ','M', '43',  45000, 3, '3/6/2013');
INSERT INTO person VALUES(533, 'Ta �na', 'Jedli?kov�','F', '29',  39000, 2, '7.10.2012');
INSERT INTO person VALUES(534, 'Leo�', 'Kubi� ','M', '19',  18000, 2, '10/6/2008');
INSERT INTO person VALUES(535, 'Karin', 'Ferkov�','F', '36',  19000, 2, '20.4.2018');
INSERT INTO person VALUES(536, 'Anton�n', 'L�tal ','M', '48',  23000, 2, '18/4/2004');
INSERT INTO person VALUES(537, 'Old?i�ka', 'Hurtov�','F', '22',  27000, 2, '14.2.2015');
INSERT INTO person VALUES(538, 'Zbyn?k', 'Jane?ek ','M', '24',  32000, 2, '20/9/2015');
INSERT INTO person VALUES(539, 'Ingrid', 'Bart�kov�','F', '29',  42000, 2, '3.4.2004');
INSERT INTO person VALUES(540, 'Petr', 'David ','M', '53',  38000, 2, '29/7/2011');
INSERT INTO person VALUES(541, 'Vlastimila', 'Divi�ov�','F', '60',  14000, 2, '23.6.2017');
INSERT INTO person VALUES(542, 'Lubom�r', 'Z�ruba ','M', '30',  47000, 2, '5/8/2006');
INSERT INTO person VALUES(543, 'Em�lia', 'Tvrd�kov�','F', '22',  30000, 2, '11.8.2006');
INSERT INTO person VALUES(544, 'Vladimir', 'Sova ','M', '59',  16000, 2, '7/11/2018');
INSERT INTO person VALUES(545, '�ofie', 'Mou?kov�','F', '53',  37000, 1, '30.10.2019');
INSERT INTO person VALUES(546, 'Jakub', 'Hrube� ','M', '35',  25000, 1, '14/11/2013');
INSERT INTO person VALUES(547, 'Pavl�na', 'Je�kov�','F', '62',  25000, 3, '8.8.2010');
INSERT INTO person VALUES(548, 'Zd?nek', 'Chalupa ','M', '63',  30000, 3, '17/3/2013');
INSERT INTO person VALUES(549, 'Patricie', 'Pila?ov�','F', '46',  25000, 1, '13.10.2005');
INSERT INTO person VALUES(550, 'Svatoslav', 'Hor�?ek ','M', '40',  40000, 1, '30/9/2004');
INSERT INTO person VALUES(551, 'Simona', 'Suchomelov�','F', '54',  13000, 2, '15.12.2012');
INSERT INTO person VALUES(552, 'Nikola', 'Rezek ','M', '22',  44000, 2, '1/2/2004');
INSERT INTO person VALUES(553, 'Nat�lie', 'Vlas�kov�','F', '62',  29000, 3, '28.6.2018');
INSERT INTO person VALUES(554, 'Matou�', 'Kope?ek ','M', '51',  14000, 3, '5/5/2016');
INSERT INTO person VALUES(555, 'Stanislava', 'P?ikrylov�','F', '47',  36000, 2, '24.4.2015');
INSERT INTO person VALUES(556, 'Hubert', 'Kamen�k ','M', '27',  23000, 2, '13/5/2011');
INSERT INTO person VALUES(557, 'Dominika', 'Kaiserov�','F', '54',  16000, 3, '11.6.2004');
INSERT INTO person VALUES(558, 'Hynek', 'Svozil ','M', '56',  28000, 3, '21/3/2007');
INSERT INTO person VALUES(559, 'Jind?i�ka', 'Borovi?kov�','F', '40',  24000, 2, '31.8.2017');
INSERT INTO person VALUES(560, 'Ferdinand', 'Hofman ','M', '33',  37000, 2, '22/8/2018');
INSERT INTO person VALUES(561, 'Ilona', 'Truhl�?ov�','F', '25',  31000, 1, '26.6.2014');
INSERT INTO person VALUES(562, 'Alex', '�iga ','M', '55',  46000, 1, '29/8/2013');
INSERT INTO person VALUES(563, 'Dominika', '�im?nkov�','F', '33',  47000, 2, '14.8.2003');
INSERT INTO person VALUES(564, '?estm�r', 'Michal ','M', '38',  16000, 2, '8/7/2009');
INSERT INTO person VALUES(565, 'Vilma', 'Polansk�','F', '41',  35000, 3, '16.10.2010');
INSERT INTO person VALUES(566, 'Otto', '�imek ','M', '20',  20000, 3, '8/11/2008');
INSERT INTO person VALUES(567, 'Hedvika', 'Olivov�','F', '25',  35000, 2, '21.12.2005');
INSERT INTO person VALUES(568, 'Arno�t', 'Vymazal ','M', '43',  30000, 2, '16/10/2016');
INSERT INTO person VALUES(569, 'Vanesa', 'Luke�ov�','F', '34',  23000, 3, '22.2.2013');
INSERT INTO person VALUES(570, 'Ludv�k', '�mejkal ','M', '25',  35000, 3, '18/2/2016');
INSERT INTO person VALUES(571, 'Leona', 'Bajerov�','F', '64',  22000, 1, '29.4.2008');
INSERT INTO person VALUES(572, 'Marcel', 'Kalina ','M', '48',  45000, 1, '2/9/2007');
INSERT INTO person VALUES(573, 'Marie', 'Bou?kov�','F', '27',  46000, 3, '2.7.2015');
INSERT INTO person VALUES(574, 'Richard', 'Bart?n?k ','M', '30',  13000, 3, '3/1/2007');
INSERT INTO person VALUES(575, 'Zora', 'Janatov�','F', '58',  18000, 2, '26.4.2012');
INSERT INTO person VALUES(576, 'P?emysl', 'Kotas ','M', '53',  22000, 2, '6/6/2018');
INSERT INTO person VALUES(577, 'Lucie', 'Samkov�','F', '19',  33000, 2, '7.11.2017');
INSERT INTO person VALUES(578, 'Miloslav', 'Navr�til ','M', '36',  28000, 2, '14/4/2014');
INSERT INTO person VALUES(579, 'Iryna', 'Neumannov�','F', '51',  41000, 2, '3.9.2014');
INSERT INTO person VALUES(580, 'Emil', 'Hanzl�k ','M', '58',  37000, 2, '21/4/2009');
INSERT INTO person VALUES(581, 'Ji?ina', 'Kopalov�','F', '58',  21000, 2, '22.10.2003');
INSERT INTO person VALUES(582, 'Martin', 'Vysko?il ','M', '41',  42000, 2, '28/2/2005');
INSERT INTO person VALUES(583, 'Lucie', 'Sehnalov�','F', '44',  29000, 2, '10.1.2017');
INSERT INTO person VALUES(584, 'Robert', 'Fo?t ','M', '63',  15000, 2, '31/7/2016');
INSERT INTO person VALUES(585, 'Libu�e', 'Gabrielov�','F', '51',  44000, 2, '28.2.2006');
INSERT INTO person VALUES(586, 'Artur', 'Hrb�?ek ','M', '46',  21000, 2, '9/6/2012');
INSERT INTO person VALUES(587, 'Viktorie', 'Bart??kov�','F', '59',  32000, 3, '2.5.2013');
INSERT INTO person VALUES(588, 'Erv�n', 'Hlav�? ','M', '28',  25000, 3, '11/10/2011');
INSERT INTO person VALUES(589, 'Iveta', '?ern�','F', '44',  32000, 2, '7.7.2008');
INSERT INTO person VALUES(590, 'Gerhard', 'Pokorn� ','M', '52',  35000, 2, '18/9/2019');
INSERT INTO person VALUES(591, 'Sv?tlana', 'Hamplov�','F', '52',  20000, 3, '8.9.2015');
INSERT INTO person VALUES(592, 'Gabriel', 'Hrn?�? ','M', '34',  40000, 3, '20/1/2019');
INSERT INTO person VALUES(593, 'Sylva', 'Frankov�','F', '38',  27000, 2, '4.7.2012');
INSERT INTO person VALUES(594, 'Vojtech', '�im�nek ','M', '56',  13000, 2, '27/1/2014');
INSERT INTO person VALUES(595, 'Katar�na', 'Nedbalov�','F', '45',  43000, 3, '15.1.2018');
INSERT INTO person VALUES(596, 'Drahom�r', 'V�ek ','M', '39',  18000, 3, '6/12/2009');
INSERT INTO person VALUES(597, 'Sv?tlana', 'P�chov�','F', '30',  15000, 2, '11.11.2014');
INSERT INTO person VALUES(598, 'Juli�s', 'Nguyen ','M', '61',  27000, 2, '13/12/2004');
INSERT INTO person VALUES(599, 'D�a', 'Kohoutkov�','F', '38',  31000, 3, '30.12.2003');
INSERT INTO person VALUES(600, 'Tade�', 'Adamec ','M', '44',  32000, 3, '16/3/2017');
INSERT INTO person VALUES(601, 'Karolina', 'Kol�?kov�','F', '23',  38000, 2, '20.3.2017');
INSERT INTO person VALUES(602, 'Viliam', 'Vondra ','M', '20',  42000, 2, '24/3/2012');
INSERT INTO person VALUES(603, 'Aloisie', 'Kovandov�','F', '30',  18000, 2, '8.5.2006');
INSERT INTO person VALUES(604, 'Vil�m', 'Blecha ','M', '49',  47000, 2, '31/1/2008');
INSERT INTO person VALUES(605, 'Mark�ta', 'Korbelov�','F', '63',  34000, 3, '22.10.2004');
INSERT INTO person VALUES(606, 'Drahoslav', 'Klime� ','M', '25',  19000, 3, '2/8/2006');
INSERT INTO person VALUES(607, 'Renata', 'Ondr�?kov�','F', '24',  14000, 3, '5.5.2010');
INSERT INTO person VALUES(608, 'Denis', 'Burda ','M', '54',  25000, 3, '4/11/2018');
INSERT INTO person VALUES(609, 'R?�ena', 'Kop?ivov�','F', '56',  21000, 2, '1.3.2007');
INSERT INTO person VALUES(610, 'Dan', 'Zach ','M', '30',  34000, 2, '11/11/2013');
INSERT INTO person VALUES(611, 'Milu�e', 'Vojtkov�','F', '63',  37000, 3, '11.9.2012');
INSERT INTO person VALUES(612, 'Dalibor', 'Junek ','M', '59',  39000, 3, '19/9/2009');
INSERT INTO person VALUES(613, 'Kl�ra', 'Hejnov�','F', '48',  45000, 2, '8.7.2009');
INSERT INTO person VALUES(614, 'Radoslav', '�emli?ka ','M', '35',  12000, 2, '27/9/2004');
INSERT INTO person VALUES(615, 'So?a', 'Zem�nkov�','F', '56',  24000, 3, '19.1.2015');
INSERT INTO person VALUES(616, 'Lud?k', 'Moudr� ','M', '64',  18000, 3, '29/12/2016');
INSERT INTO person VALUES(617, 'Milu�e', 'Buchtov�','F', '41',  32000, 2, '14.11.2011');
INSERT INTO person VALUES(618, 'Kry�tof', 'Kov�? ','M', '41',  27000, 2, '6/1/2012');
INSERT INTO person VALUES(619, 'Nina', '?eho?ov�','F', '50',  20000, 3, '16.1.2019');
INSERT INTO person VALUES(620, 'V�t?zslav', 'Hejda ','M', '23',  31000, 3, '10/5/2011');
INSERT INTO person VALUES(621, 'Bed?i�ka', 'Vlachov�','F', '57',  36000, 4, '5.3.2008');
INSERT INTO person VALUES(622, 'Tom�', 'Buri�nek ','M', '51',  37000, 4, '18/3/2007');
INSERT INTO person VALUES(623, 'Em�lia', 'Va��?kov�','F', '42',  43000, 3, '30.12.2004');
INSERT INTO person VALUES(624, 'Dominik', '�ilhav� ','M', '28',  46000, 3, '18/8/2018');
INSERT INTO person VALUES(625, 'Ingrid', 'Ko?�nkov�','F', '28',  15000, 2, '21.3.2018');
INSERT INTO person VALUES(626, 'Igor', 'Kalina ','M', '50',  19000, 2, '26/8/2013');
INSERT INTO person VALUES(627, 'Olena', 'Zezulov�','F', '35',  31000, 3, '9.5.2007');
INSERT INTO person VALUES(628, 'Marek', 'Luk� ','M', '33',  24000, 3, '4/7/2009');
INSERT INTO person VALUES(629, 'Em�lia', 'Rozsypalov�','F', '21',  39000, 2, '4.3.2004');
INSERT INTO person VALUES(630, '�tefan', '?ernoch ','M', '55',  34000, 2, '12/7/2004');
INSERT INTO person VALUES(631, 'Radom�ra', 'Matu�kov�','F', '28',  18000, 3, '15.9.2009');
INSERT INTO person VALUES(632, 'Pavel', 'Ors�g ','M', '38',  39000, 3, '13/10/2016');
INSERT INTO person VALUES(633, 'Franti�ka', 'Petr�kov�','F', '36',  42000, 4, '16.11.2016');
INSERT INTO person VALUES(634, '?udov�t', 'B�lek ','M', '20',  43000, 4, '14/2/2016');
INSERT INTO person VALUES(635, 'Tatiana', 'Lakato�ov�','F', '21',  42000, 2, '22.1.2012');
INSERT INTO person VALUES(636, 'Rastislav', 'Maz�nek ','M', '44',  17000, 2, '30/8/2007');
INSERT INTO person VALUES(637, 'Bla�ena', '�indel�?ov�','F', '29',  30000, 4, '26.3.2019');
INSERT INTO person VALUES(638, 'Oliver', 'Zima ','M', '26',  22000, 4, '31/12/2006');
INSERT INTO person VALUES(639, 'Nat�lie', 'Mackov�','F', '61',  37000, 3, '20.1.2016');
INSERT INTO person VALUES(640, 'Po?et', 'Hrb�?ek ','M', '48',  31000, 3, '2/6/2018');
INSERT INTO person VALUES(641, 'Alexandra', '��pkov�','F', '22',  17000, 3, '9.3.2005');
INSERT INTO person VALUES(642, 'Leo', 'P�a ','M', '31',  36000, 3, '11/4/2014');
INSERT INTO person VALUES(643, 'Bla�ena', '�andov�','F', '53',  25000, 3, '29.5.2018');
INSERT INTO person VALUES(644, 'Stepan', 'Pokorn� ','M', '53',  45000, 3, '18/4/2009');
INSERT INTO person VALUES(645, 'Jolana', 'Luk�ov�','F', '61',  41000, 3, '17.7.2007');
INSERT INTO person VALUES(646, 'Mikul�', 'Mach�?ek ','M', '36',  15000, 3, '25/2/2005');
INSERT INTO person VALUES(647, 'Kv?tu�e', 'Kulh�nkov�','F', '46',  12000, 3, '11.5.2004');
INSERT INTO person VALUES(648, 'Sebastian', 'Seidl ','M', '58',  24000, 3, '28/7/2016');
INSERT INTO person VALUES(649, 'Ta �na', 'Grundzov�','F', '53',  28000, 3, '22.11.2009');
INSERT INTO person VALUES(650, 'Bronislav', 'Van??ek ','M', '41',  29000, 3, '5/6/2012');
INSERT INTO person VALUES(651, 'Jolana', 'Kolkov�','F', '39',  36000, 2, '18.9.2006');
INSERT INTO person VALUES(652, 'Nikolas', 'Jirou�ek ','M', '64',  38000, 2, '14/6/2007');
INSERT INTO person VALUES(653, 'Ivanka', 'Kotkov�','F', '46',  16000, 3, '31.3.2012');
INSERT INTO person VALUES(654, '�imon', 'Jan? ','M', '47',  44000, 3, '15/9/2019');
INSERT INTO person VALUES(655, 'Monika', 'Lebedov�','F', '55',  39000, 4, '3.6.2019');
INSERT INTO person VALUES(656, 'Bohuslav', 'Star� ','M', '29',  12000, 4, '16/1/2019');
INSERT INTO person VALUES(657, 'Jaroslava', 'V�clavkov�','F', '40',  47000, 3, '29.3.2016');
INSERT INTO person VALUES(658, 'Arno�t', 'Blecha ','M', '51',  21000, 3, '24/1/2014');
INSERT INTO person VALUES(659, 'Irena', 'Koubov�','F', '47',  27000, 4, '17.5.2005');
INSERT INTO person VALUES(660, 'Libor', 'Hr?za ','M', '34',  27000, 4, '2/12/2009');
INSERT INTO person VALUES(661, 'Monika', 'Hofmanov�','F', '33',  35000, 3, '5.8.2018');
INSERT INTO person VALUES(662, 'Marcel', 'Knap ','M', '56',  36000, 3, '9/12/2004');
INSERT INTO person VALUES(663, '��rka', 'Chadimov�','F', '40',  14000, 4, '23.9.2007');
INSERT INTO person VALUES(664, 'Karel', 'Srb ','M', '39',  41000, 4, '13/3/2017');
INSERT INTO person VALUES(665, 'Marta', 'Knapov�','F', '25',  22000, 3, '19.7.2004');
INSERT INTO person VALUES(666, 'Rostislav', 'P?ibyl ','M', '62',  14000, 3, '20/3/2012');
INSERT INTO person VALUES(667, 'Simona', 'Kostkov�','F', '33',  38000, 3, '30.1.2010');
INSERT INTO person VALUES(668, 'Radko', '�ebesta ','M', '44',  20000, 3, '28/1/2008');
INSERT INTO person VALUES(669, '��rka', 'Hude?kov�','F', '64',  45000, 3, '26.11.2006');
INSERT INTO person VALUES(670, 'Jarom�r', 'Mu��k ','M', '21',  29000, 3, '30/6/2019');
INSERT INTO person VALUES(671, 'Diana', 'Peterov�','F', '27',  33000, 4, '28.1.2014');
INSERT INTO person VALUES(672, 'Miroslav', 'Kab�t ','M', '49',  33000, 4, '31/10/2018');
INSERT INTO person VALUES(673, 'Radka', 'Dr�palov�','F', '57',  33000, 3, '4.4.2009');
INSERT INTO person VALUES(674, 'Tom�', 'Kalivoda ','M', '26',  43000, 3, '16/5/2010');
INSERT INTO person VALUES(675, 'Vanda', 'Sobotkov�','F', '19',  21000, 4, '6.6.2016');
INSERT INTO person VALUES(676, 'Artur', '?ejka ','M', '54',  12000, 4, '16/9/2009');
INSERT INTO person VALUES(677, 'Barbara', 'Hejnov�','F', '27',  37000, 4, '25.7.2005');
INSERT INTO person VALUES(678, 'Gustav', 'Pek�rek ','M', '37',  17000, 4, '26/7/2005');
INSERT INTO person VALUES(679, 'Zlata', 'Hanzalov�','F', '58',  44000, 4, '13.10.2018');
INSERT INTO person VALUES(680, 'Walter', 'Dolej�� ','M', '59',  26000, 4, '26/12/2016');
INSERT INTO person VALUES(681, 'Vilma', 'Buchtov�','F', '19',  24000, 4, '1.12.2007');
INSERT INTO person VALUES(682, 'Kv?toslav', 'St�rek ','M', '42',  32000, 4, '3/11/2012');
INSERT INTO person VALUES(683, 'Aloisie', 'Kola?�kov�','F', '51',  32000, 3, '26.9.2004');
INSERT INTO person VALUES(684, 'Petro', 'Pil�t ','M', '19',  41000, 3, '12/11/2007');
INSERT INTO person VALUES(685, 'Zora', '�torkov�','F', '58',  12000, 4, '9.4.2010');
INSERT INTO person VALUES(686, 'Igor', 'Ju?�k ','M', '48',  46000, 4, '20/9/2003');
INSERT INTO person VALUES(687, 'Zd?nka', 'Dole?kov�','F', '44',  19000, 3, '3.2.2007');
INSERT INTO person VALUES(688, 'Boris', 'Bauer ','M', '24',  19000, 3, '20/2/2015');
INSERT INTO person VALUES(689, 'Vladim�ra', 'Ko?�nkov�','F', '52',  43000, 4, '7.4.2014');
INSERT INTO person VALUES(690, 'Tade�', 'Kosina ','M', '52',  24000, 4, '24/6/2014');
INSERT INTO person VALUES(691, 'Radana', 'Mu��kov�','F', '36',  43000, 3, '11.6.2009');
INSERT INTO person VALUES(692, 'Lum�r', 'Berger ','M', '29',  34000, 3, '6/1/2006');
INSERT INTO person VALUES(693, '�t?p�nka', 'Rozsypalov�','F', '45',  30000, 4, '13.8.2016');
INSERT INTO person VALUES(694, 'Vil�m', 'Janda ','M', '57',  38000, 4, '9/5/2005');
INSERT INTO person VALUES(695, 'Iryna', 'R?�i?kov�','F', '29',  30000, 3, '19.10.2011');
INSERT INTO person VALUES(696, 'Vratislav', 'Kolman ','M', '34',  12000, 3, '17/4/2013');
INSERT INTO person VALUES(697, 'Antonie', 'Hanzl�kov�','F', '38',  18000, 4, '21.12.2018');
INSERT INTO person VALUES(698, '�t?p�n', 'Anto� ','M', '62',  17000, 4, '18/8/2012');
INSERT INTO person VALUES(699, 'Magda', 'Lakato�ov�','F', '45',  34000, 1, '8.2.2008');
INSERT INTO person VALUES(700, 'Po?et', '�olc ','M', '45',  22000, 1, '27/6/2008');
INSERT INTO person VALUES(701, 'V�clava', 'Linkov�','F', '30',  41000, 4, '4.12.2004');
INSERT INTO person VALUES(702, 'Jind?ich', 'Rozsypal ','M', '22',  31000, 4, '5/7/2003');
INSERT INTO person VALUES(703, 'Antonie', 'Mokr�','F', '62',  13000, 3, '22.2.2018');
INSERT INTO person VALUES(704, 'Otakar', 'Ot�hal ','M', '44',  40000, 3, '5/12/2014');
INSERT INTO person VALUES(705, 'Linda', 'Ka�p�rkov�','F', '23',  29000, 4, '13.4.2007');
INSERT INTO person VALUES(706, 'Luk�', 'Valenta ','M', '27',  46000, 4, '14/10/2010');
INSERT INTO person VALUES(707, 'Nela', 'Klementov�','F', '55',  36000, 3, '6.2.2004');
INSERT INTO person VALUES(708, 'Bohuslav', 'Bo?ek ','M', '49',  19000, 3, '21/10/2005');
INSERT INTO person VALUES(709, 'Sylva', 'Kubi�tov�','F', '62',  16000, 4, '19.8.2009');
INSERT INTO person VALUES(710, 'Ernest', '?onka ','M', '32',  24000, 4, '23/1/2018');
INSERT INTO person VALUES(711, 'Veronika', 'Kulh�nkov�','F', '24',  40000, 1, '21.10.2016');
INSERT INTO person VALUES(712, 'Oskar', 'Han�?ek ','M', '60',  29000, 1, '26/5/2017');
INSERT INTO person VALUES(713, 'Maria', 'Drozdov�','F', '55',  40000, 3, '27.12.2011');
INSERT INTO person VALUES(714, 'Vladan', 'Peroutka ','M', '37',  39000, 3, '8/12/2008');
INSERT INTO person VALUES(715, 'Mark�ta', 'Kolkov�','F', '63',  28000, 4, '28.2.2019');
INSERT INTO person VALUES(716, '?ubom�r', 'Hole?ek ','M', '19',  43000, 4, '11/4/2008');
INSERT INTO person VALUES(717, 'Zde?ka', 'Ji?�kov�','F', '48',  35000, 4, '25.12.2015');
INSERT INTO person VALUES(718, 'V?roslav', 'Vyb�ral ','M', '42',  16000, 4, '12/9/2019');
INSERT INTO person VALUES(719, 'V?ra', '�im�nkov�','F', '34',  43000, 3, '19.10.2012');
INSERT INTO person VALUES(720, 'Miloslav', 'Pernica ','M', '64',  25000, 3, '19/9/2014');
INSERT INTO person VALUES(721, 'Mark�ta', 'Sokolov�','F', '41',  23000, 4, '2.5.2018');
INSERT INTO person VALUES(722, 'Zolt�n', 'Kliment ','M', '47',  31000, 4, '29/7/2010');
INSERT INTO person VALUES(723, 'Sandra', 'T�thov�','F', '50',  47000, 1, '8.2.2009');
INSERT INTO person VALUES(724, 'Lubor', '�koda ','M', '29',  35000, 1, '29/11/2009');
INSERT INTO person VALUES(725, 'Margita', 'Ulrichov�','F', '35',  18000, 4, '5.12.2005');
INSERT INTO person VALUES(726, 'Adrian', 'Zikmund ','M', '51',  45000, 4, '6/12/2004');
INSERT INTO person VALUES(727, 'And?la', 'Peterkov�','F', '42',  34000, 1, '18.6.2011');
INSERT INTO person VALUES(728, 'Ota', '�tefek ','M', '34',  14000, 1, '10/3/2017');
INSERT INTO person VALUES(729, 'Sandra', 'Vodi?kov�','F', '28',  42000, 4, '13.4.2008');
INSERT INTO person VALUES(730, 'Erv�n', 'Holan ','M', '57',  23000, 4, '17/3/2012');
INSERT INTO person VALUES(731, 'Jolana', 'Pt�?kov�','F', '59',  13000, 3, '6.2.2005');
INSERT INTO person VALUES(732, 'Ji?�', 'Kova?�k ','M', '33',  32000, 3, '25/3/2007');
INSERT INTO person VALUES(733, 'Old?i�ka', 'Mayerov�','F', '21',  29000, 4, '20.8.2010');
INSERT INTO person VALUES(734, 'Gabriel', 'Dohnal ','M', '62',  37000, 4, '27/6/2019');
INSERT INTO person VALUES(735, 'Tereza', 'Vl?kov�','F', '29',  17000, 1, '22.10.2017');
INSERT INTO person VALUES(736, 'Samuel', 'St�rek ','M', '44',  42000, 1, '28/10/2018');
INSERT INTO person VALUES(737, 'Vlastimila', 'Jon�ov�','F', '59',  17000, 4, '27.12.2012');
INSERT INTO person VALUES(738, 'Drahom�r', 'Jahoda ','M', '21',  16000, 4, '13/5/2010');
INSERT INTO person VALUES(739, 'Miroslava', 'Hanusov�','F', '22',  41000, 1, '6.10.2003');
INSERT INTO person VALUES(740, 'Alexander 4 000', 'Ju?�k ','M', '49',  21000, 1, '13/9/2009');
INSERT INTO person VALUES(741, 'Tereza', 'Boudov�','F', '53',  12000, 4, '25.12.2016');
INSERT INTO person VALUES(742, 'Erich', 'Bauer ','M', '26',  30000, 4, '20/9/2004');
INSERT INTO person VALUES(743, 'Pavl�na', 'Kr�tk�','F', '61',  28000, 1, '12.2.2006');
INSERT INTO person VALUES(744, '�imon', 'Malina ','M', '54',  35000, 1, '23/12/2016');
INSERT INTO person VALUES(745, 'Irena', 'Vlkov�','F', '46',  36000, 4, '3.5.2019');
INSERT INTO person VALUES(746, 'Anton', 'Jan�?ek ','M', '31',  44000, 4, '31/12/2011');
INSERT INTO person VALUES(747, 'Milena', 'Sladk�','F', '53',  15000, 4, '20.6.2008');
INSERT INTO person VALUES(748, 'Vit', 'Hartman ','M', '60',  13000, 4, '8/11/2007');
INSERT INTO person VALUES(749, 'Pavl�na', '��dkov�','F', '39',  23000, 4, '16.4.2005');
INSERT INTO person VALUES(750, 'Denis', 'Kolman ','M', '36',  23000, 4, '11/4/2019');
INSERT INTO person VALUES(751, 'Lidmila', 'Kubi�tov�','F', '47',  47000, 1, '18.6.2012');
INSERT INTO person VALUES(752, 'Peter', 'Anto� ','M', '64',  27000, 1, '12/8/2018');
INSERT INTO person VALUES(753, 'Simona', 'Form�nkov�','F', '32',  47000, 4, '24.8.2007');
INSERT INTO person VALUES(754, 'Dalibor', 'Dole�el ','M', '41',  37000, 4, '24/2/2010');
INSERT INTO person VALUES(755, 'Vanda', 'Drozdov�','F', '40',  34000, 1, '26.10.2014');
INSERT INTO person VALUES(756, 'Du�an', 'Rozsypal ','M', '23',  42000, 1, '28/6/2009');
INSERT INTO person VALUES(757, 'Marika', '?ervenkov�','F', '47',  14000, 1, '14.12.2003');
INSERT INTO person VALUES(758, 'Radko', 'Steiner ','M', '52',  47000, 1, '6/5/2005');
INSERT INTO person VALUES(759, 'Lydie', 'Kohoutov�','F', '33',  22000, 1, '4.3.2017');
INSERT INTO person VALUES(760, 'Filip', 'Tich� ','M', '29',  20000, 1, '6/10/2016');
INSERT INTO person VALUES(761, 'Bohdana', 'Jirou�kov�','F', '40',  38000, 1, '22.4.2006');
INSERT INTO person VALUES(762, 'Ctibor', 'Straka ','M', '58',  25000, 1, '15/8/2012');
INSERT INTO person VALUES(763, 'Barbara', 'Karlov�','F', '26',  45000, 4, '11.7.2019');
INSERT INTO person VALUES(764, 'Tom�', '?onka ','M', '34',  35000, 4, '23/8/2007');
INSERT INTO person VALUES(765, 'Zlata', 'M�chov�','F', '57',  17000, 4, '6.5.2016');
INSERT INTO person VALUES(766, 'Radim', 'Hor?�k ','M', '56',  44000, 4, '23/1/2019');
INSERT INTO person VALUES(767, 'Vilma', 'Kocourkov�','F', '64',  33000, 4, '24.6.2005');
INSERT INTO person VALUES(768, 'Boleslav', 'Peroutka ','M', '39',  13000, 4, '2/12/2014');
INSERT INTO person VALUES(769, 'Kamila', 'Jankov�','F', '27',  21000, 1, '26.8.2012');
INSERT INTO person VALUES(770, 'Tobi�', 'Hole?ek ','M', '21',  18000, 1, '4/4/2014');
INSERT INTO person VALUES(771, 'Zora', 'Karbanov�','F', '57',  20000, 4, '1.11.2007');
INSERT INTO person VALUES(772, 'Mario', 'Kone?n� ','M', '44',  27000, 4, '18/10/2005');
INSERT INTO person VALUES(773, 'Bohumila', 'Ka�parov�','F', '19',  44000, 1, '3.1.2015');
INSERT INTO person VALUES(774, 'Kristi�n', 'Voln� ','M', '26',  32000, 1, '18/2/2005');
INSERT INTO person VALUES(775, 'Marie', 'Bare�ov�','F', '50',  44000, 4, '9.3.2010');
INSERT INTO person VALUES(776, 'Lubor', 'Hude?ek ','M', '50',  42000, 4, '27/1/2013');
INSERT INTO person VALUES(777, 'Alice', 'Vrabcov�','F', '58',  32000, 1, '11.5.2017');
INSERT INTO person VALUES(778, 'Boris', 'Pracha? ','M', '32',  47000, 1, '30/5/2012');
INSERT INTO person VALUES(779, '�t?p�nka', 'Ors�gov�','F', '44',  39000, 4, '7.3.2014');
INSERT INTO person VALUES(780, 'Oliver', 'Richter ','M', '54',  20000, 4, '7/6/2007');
INSERT INTO person VALUES(781, 'Regina', 'Pourov�','F', '52',  27000, 1, '14.12.2004');
INSERT INTO person VALUES(782, 'Vili�m', '�tefek ','M', '36',  24000, 1, '8/10/2006');
INSERT INTO person VALUES(783, 'Antonie', 'Kroupov�','F', '36',  27000, 4, '14.7.2016');
INSERT INTO person VALUES(784, 'Leo', 'Krej?�k ','M', '59',  34000, 4, '16/9/2014');
INSERT INTO person VALUES(785, 'Al�beta', 'Cibulkov�','F', '45',  15000, 1, '23.4.2007');
INSERT INTO person VALUES(786, 'Slavom�r', 'Vin� ','M', '41',  39000, 1, '17/1/2014');
INSERT INTO person VALUES(787, 'V�clava', 'Kupcov�','F', '29',  14000, 4, '21.11.2018');
INSERT INTO person VALUES(788, 'Mikul�', 'Vav?�k ','M', '19',  13000, 4, '2/8/2005');
INSERT INTO person VALUES(789, 'Be�ta', 'Kopeck�','F', '38',  38000, 1, '29.8.2009');
INSERT INTO person VALUES(790, 'Erik', 'Tomek ','M', '47',  17000, 1, '3/12/2004');
INSERT INTO person VALUES(791, 'Yveta', 'H�jkov�','F', '23',  46000, 4, '25.6.2006');
INSERT INTO person VALUES(792, 'Emanuel', 'Vondr�k ','M', '23',  26000, 4, '5/5/2016');
INSERT INTO person VALUES(793, 'Alena', 'Koukalov�','F', '30',  25000, 1, '6.1.2012');
INSERT INTO person VALUES(794, 'Bed?ich', 'Smola ','M', '52',  32000, 1, '14/3/2012');
INSERT INTO person VALUES(795, 'Be�ta', 'Sk�celov�','F', '62',  33000, 4, '1.11.2008');
INSERT INTO person VALUES(796, 'Andrej', 'Ne�por ','M', '28',  41000, 4, '22/3/2007');
INSERT INTO person VALUES(797, 'Veronika', 'Vr�nov�','F', '23',  13000, 1, '15.5.2014');
INSERT INTO person VALUES(798, 'Bohuslav', 'Kuchta ','M', '57',  46000, 1, '23/6/2019');
INSERT INTO person VALUES(799, 'Lenka', 'Nov�','F', '55',  21000, 4, '11.3.2011');
INSERT INTO person VALUES(800, 'Svatopluk', 'Charv�t ','M', '33',  19000, 4, '1/7/2014');
INSERT INTO person VALUES(801, 'Marcela', 'Fuchsov�','F', '62',  36000, 1, '21.9.2016');
INSERT INTO person VALUES(802, 'Libor', '�t?rba ','M', '62',  25000, 1, '9/5/2010');
INSERT INTO person VALUES(803, 'Radmila', 'Brabencov�','F', '24',  24000, 2, '1.7.2007');
INSERT INTO person VALUES(804, 'V�clav', 'Berky ','M', '44',  29000, 2, '9/9/2009');
INSERT INTO person VALUES(805, 'Bohuslava', 'Cahov�','F', '56',  32000, 1, '25.4.2004');
INSERT INTO person VALUES(806, 'Ivo', 'Strej?ek ','M', '21',  38000, 1, '17/9/2004');
INSERT INTO person VALUES(807, 'Drahoslava', '?ernochov�','F', '63',  12000, 2, '6.11.2009');
INSERT INTO person VALUES(808, 'Maxmili�n', '�t?p�nek ','M', '50',  44000, 2, '19/12/2016');
INSERT INTO person VALUES(809, 'Sandra', 'Brad�?ov�','F', '49',  19000, 1, '2.9.2006');
INSERT INTO person VALUES(810, 'Vojt?ch', 'Kozel ','M', '26',  17000, 1, '28/12/2011');
INSERT INTO person VALUES(811, 'Kar�n', 'P?ibylov�','F', '56',  35000, 1, '15.3.2012');
INSERT INTO person VALUES(812, 'Zolt�n', 'Homola ','M', '55',  22000, 1, '5/11/2007');
INSERT INTO person VALUES(813, 'And?la', 'Janou�kov�','F', '41',  43000, 1, '9.1.2009');
INSERT INTO person VALUES(814, 'Miroslav', 'Zouhar ','M', '31',  31000, 1, '7/4/2019');
INSERT INTO person VALUES(815, 'Nina', 'P�ov�','F', '49',  23000, 1, '23.7.2014');
INSERT INTO person VALUES(816, 'Radomil', 'P�cha ','M', '60',  37000, 1, '14/2/2015');
INSERT INTO person VALUES(817, 'Karin', '?ernohorsk�','F', '34',  30000, 1, '18.5.2011');
INSERT INTO person VALUES(818, 'Artur', 'V�cha ','M', '36',  46000, 1, '21/2/2010');
INSERT INTO person VALUES(819, 'Barbora', 'Sv?tl�kov�','F', '43',  18000, 2, '20.7.2018');
INSERT INTO person VALUES(820, 'Gerhard', 'Sp�?il ','M', '64',  14000, 2, '24/6/2009');
INSERT INTO person VALUES(821, 'Nina', 'Dole�elov�','F', '27',  18000, 4, '24.9.2013');
INSERT INTO person VALUES(822, 'Walter', 'Franc ','M', '42',  24000, 4, '2/6/2017');
INSERT INTO person VALUES(823, 'Blanka', 'Do?ekalov�','F', '35',  42000, 2, '3.7.2004');
INSERT INTO person VALUES(824, 'Cyril', 'Hroch ','M', '24',  29000, 2, '3/10/2016');
INSERT INTO person VALUES(825, 'Emilie', 'Bro�ov�','F', '43',  21000, 2, '14.1.2010');
INSERT INTO person VALUES(826, 'Leo�', 'Ba�ant ','M', '53',  34000, 2, '12/8/2012');
INSERT INTO person VALUES(827, 'Miloslava', 'Jaro�ov�','F', '28',  29000, 1, '10.11.2006');
INSERT INTO person VALUES(828, 'Julius', 'Pavl�?ek ','M', '29',  43000, 1, '20/8/2007');
INSERT INTO person VALUES(829, 'Franti�ka', 'M�chov�','F', '35',  45000, 2, '23.5.2012');
INSERT INTO person VALUES(830, 'Zbyn?k', 'Sl�ma ','M', '58',  13000, 2, '28/6/2003');
INSERT INTO person VALUES(831, 'Kv?toslava', 'Peka?ov�','F', '21',  17000, 1, '19.3.2009');
INSERT INTO person VALUES(832, 'Tade�', 'Klement ','M', '34',  22000, 1, '29/11/2014');
INSERT INTO person VALUES(833, 'Milena', 'Macha?ov�','F', '52',  24000, 1, '12.1.2006');
INSERT INTO person VALUES(834, 'Vili�m', 'Mayer ','M', '57',  31000, 1, '6/12/2009');
INSERT INTO person VALUES(835, 'Franti�ka', '�ediv�','F', '59',  40000, 1, '26.7.2011');
INSERT INTO person VALUES(836, 'Vil�m', '?eh�?ek ','M', '40',  36000, 1, '14/10/2005');
INSERT INTO person VALUES(837, 'Yvona', 'Hladk�','F', '22',  28000, 2, '27.9.2018');
INSERT INTO person VALUES(838, 'V�t', 'Bal� ','M', '22',  41000, 2, '15/2/2005');
INSERT INTO person VALUES(839, 'Bla�ena', 'Tvrd�','F', '52',  27000, 1, '2.12.2013');
INSERT INTO person VALUES(840, '�t?p�n', 'Slav�k ','M', '45',  15000, 1, '23/1/2013');
INSERT INTO person VALUES(841, 'Bohdana', 'Soukupov�','F', '61',  15000, 2, '10.9.2004');
INSERT INTO person VALUES(842, 'Vlastimil', 'Mi?ka ','M', '27',  19000, 2, '27/5/2012');
INSERT INTO person VALUES(843, 'Kv?tu�e', 'Langov�','F', '45',  15000, 1, '10.4.2016');
INSERT INTO person VALUES(844, 'Jind?ich', 'Voj�?ek ','M', '50',  29000, 1, '10/12/2003');
INSERT INTO person VALUES(845, 'T�?a', 'Pe�tov�','F', '53',  39000, 2, '18.1.2007');
INSERT INTO person VALUES(846, 'Michal', 'Michna ','M', '32',  34000, 2, '5/9/2019');
INSERT INTO person VALUES(847, 'Bohdana', 'Hejlov�','F', '39',  46000, 1, '13.11.2003');
INSERT INTO person VALUES(848, 'Vladislav', 'V�?a ','M', '54',  43000, 1, '13/9/2014');
INSERT INTO person VALUES(849, 'Jana', 'Dlouh�','F', '46',  26000, 2, '26.5.2009');
INSERT INTO person VALUES(850, 'Nicolas', 'Hork� ','M', '37',  12000, 2, '22/7/2010');
INSERT INTO person VALUES(851, 'Vanesa', 'Kov�?ov�','F', '32',  34000, 1, '22.3.2006');
INSERT INTO person VALUES(852, 'Ivan', 'P?�hoda ','M', '60',  21000, 1, '29/7/2005');
INSERT INTO person VALUES(853, 'Ludmila', 'H?lkov�','F', '39',  14000, 1, '3.10.2011');
INSERT INTO person VALUES(854, 'Oskar', 'Kudl�?ek ','M', '43',  27000, 1, '31/10/2017');
INSERT INTO person VALUES(855, 'Jana', '�im�?kov�','F', '24',  21000, 1, '29.7.2008');
INSERT INTO person VALUES(856, 'Zden?k', 'V�ek ','M', '19',  36000, 1, '7/11/2012');
INSERT INTO person VALUES(857, 'Monika', 'Pelik�nov�','F', '32',  37000, 1, '9.2.2014');
INSERT INTO person VALUES(858, '?ubom�r', 'Ba�ta ','M', '48',  41000, 1, '16/9/2008');
INSERT INTO person VALUES(859, 'Adriana', 'Sk�celov�','F', '40',  25000, 2, '18.11.2004');
INSERT INTO person VALUES(860, 'Ondrej', 'Nedv?d ','M', '30',  46000, 2, '18/1/2008');
INSERT INTO person VALUES(861, 'Irena', 'Farka�ov�','F', '24',  25000, 1, '18.6.2016');
INSERT INTO person VALUES(862, 'Jon�', '��?ek ','M', '53',  19000, 1, '26/12/2015');
INSERT INTO person VALUES(863, 'Ivona', 'Adamcov�','F', '33',  12000, 2, '27.3.2007');
INSERT INTO person VALUES(864, 'Mykola', '?ernohorsk� ','M', '35',  24000, 2, '29/4/2015');
INSERT INTO person VALUES(865, 'Lada', 'Zapletalov�','F', '64',  20000, 2, '21.1.2004');
INSERT INTO person VALUES(866, 'Lubor', 'Svato? ','M', '57',  33000, 2, '6/5/2010');
INSERT INTO person VALUES(867, 'Lidmila', 'Dunkov�','F', '26',  36000, 2, '3.8.2009');
INSERT INTO person VALUES(868, 'Bohumir', 'Sedl�?ek ','M', '40',  39000, 2, '14/3/2006');
INSERT INTO person VALUES(869, 'Viktorie', 'Koudelov�','F', '57',  44000, 1, '30.5.2006');
INSERT INTO person VALUES(870, 'Ota', 'Tu?ek ','M', '63',  12000, 1, '15/8/2017');
INSERT INTO person VALUES(871, 'Vanda', 'Mare?kov�','F', '64',  23000, 2, '11.12.2011');
INSERT INTO person VALUES(872, 'Michael', 'Lacina ','M', '46',  17000, 2, '23/6/2013');
INSERT INTO person VALUES(873, 'Diana', 'Mina?�kov�','F', '50',  31000, 1, '6.10.2008');
INSERT INTO person VALUES(874, 'Vlastislav', 'Neubauer ','M', '22',  26000, 1, '30/6/2008');
INSERT INTO person VALUES(875, 'Zlata', 'Kal�bov�','F', '57',  47000, 2, '19.4.2014');
INSERT INTO person VALUES(876, 'Mat?j', 'Pohl ','M', '51',  31000, 2, '9/5/2004');
INSERT INTO person VALUES(877, 'Katar�na', 'Holasov�','F', '42',  18000, 1, '12.2.2011');
INSERT INTO person VALUES(878, 'Leo�', 'Vod�k ','M', '27',  41000, 1, '10/10/2015');
INSERT INTO person VALUES(879, 'Barbara', 'Homolkov�','F', '50',  34000, 1, '25.8.2016');
INSERT INTO person VALUES(880, 'Radek', 'Ku?era ','M', '56',  46000, 1, '19/8/2011');
INSERT INTO person VALUES(881, 'Karol�na', '?ernohorsk�','F', '58',  22000, 3, '4.6.2007');
INSERT INTO person VALUES(882, 'Jan', 'Ra�ka ','M', '38',  15000, 3, '20/12/2010');
INSERT INTO person VALUES(883, 'Nikola', 'Najmanov�','F', '44',  30000, 2, '30.3.2004');
INSERT INTO person VALUES(884, 'Adam', 'Karban ','M', '61',  24000, 2, '27/12/2005');
INSERT INTO person VALUES(885, 'Kamila', 'Dole�elov�','F', '51',  46000, 2, '11.10.2009');
INSERT INTO person VALUES(886, 'Herbert', 'Rambousek ','M', '43',  29000, 2, '31/3/2018');
INSERT INTO person VALUES(887, 'Karol�na', 'Sikorov�','F', '36',  17000, 2, '7.8.2006');
INSERT INTO person VALUES(888, 'Ladislav', 'Sedl�k ','M', '20',  38000, 2, '7/4/2013');
INSERT INTO person VALUES(889, '�t?p�nka', '�a�kov�','F', '44',  33000, 2, '18.2.2012');
INSERT INTO person VALUES(890, 'J�lius', 'Kov�? ','M', '49',  43000, 2, '14/2/2009');
INSERT INTO person VALUES(891, 'Vladim�ra', 'Pot??kov�','F', '29',  41000, 2, '13.12.2008');
INSERT INTO person VALUES(892, 'Zd?nek', 'Machala ','M', '25',  17000, 2, '22/2/2004');
INSERT INTO person VALUES(893, 'Ester', '�m�dov�','F', '38',  29000, 3, '15.2.2016');
INSERT INTO person VALUES(894, 'Bruno', 'Maxa ','M', '53',  21000, 3, '25/6/2003');
INSERT INTO person VALUES(895, '�t?p�nka', 'Bu?kov�','F', '22',  28000, 1, '22.4.2011');
INSERT INTO person VALUES(896, 'Nikola', 'Michal�k ','M', '30',  31000, 1, '3/6/2011');
INSERT INTO person VALUES(897, 'Regina', 'Macha?ov�','F', '30',  16000, 3, '24.6.2018');
INSERT INTO person VALUES(898, 'Drahoslav', 'Barto? ','M', '58',  36000, 3, '4/10/2010');
INSERT INTO person VALUES(899, 'Ester', 'Moty?kov�','F', '62',  24000, 2, '20.4.2015');
INSERT INTO person VALUES(900, 'Radko', 'Spurn� ','M', '35',  45000, 2, '11/10/2005');
INSERT INTO person VALUES(901, 'Yveta', '�varcov�','F', '23',  40000, 2, '7.6.2004');
INSERT INTO person VALUES(902, 'Karol', 'Merta ','M', '64',  14000, 2, '13/1/2018');
INSERT INTO person VALUES(903, 'Bed?i�ka', 'Such�nkov�','F', '55',  47000, 2, '26.8.2017');
INSERT INTO person VALUES(904, 'Ctibor', 'Hrd� ','M', '40',  23000, 2, '20/1/2013');
INSERT INTO person VALUES(905, 'Be�ta', 'Menclov�','F', '62',  27000, 2, '14.10.2006');
INSERT INTO person VALUES(906, 'Zdenek', 'Lev� ','M', '23',  29000, 2, '28/11/2008');
INSERT INTO person VALUES(907, 'Yveta', 'Hl�vkov�','F', '47',  35000, 2, '10.8.2003');
INSERT INTO person VALUES(908, 'J�chym', 'Benda ','M', '45',  38000, 2, '7/12/2003');
INSERT INTO person VALUES(909, 'Lenka', 'Kozlov�','F', '55',  14000, 2, '20.2.2009');
INSERT INTO person VALUES(910, 'Otto', '�ediv� ','M', '28',  43000, 2, '9/3/2016');
INSERT INTO person VALUES(911, 'Tati�na', 'Ne?asov�','F', '40',  22000, 1, '17.12.2005');
INSERT INTO person VALUES(912, 'Bo?ivoj', 'Hladk� ','M', '50',  16000, 1, '18/3/2011');
INSERT INTO person VALUES(913, 'Veronika', 'Seifertov�','F', '47',  38000, 2, '30.6.2011');
INSERT INTO person VALUES(914, 'Ren�', 'Vojt�ek ','M', '33',  21000, 2, '24/1/2007');
INSERT INTO person VALUES(915, 'Bohuslava', 'Kov�?ov�','F', '56',  26000, 3, '1.9.2018');
INSERT INTO person VALUES(916, 'Radim', 'Marek ','M', '61',  26000, 3, '27/5/2006');
INSERT INTO person VALUES(917, 'Silvie 7300', 'Hol�','F', '41',  33000, 2, '28.6.2015');
INSERT INTO person VALUES(918, 'Igor', 'Form�nek ','M', '38',  35000, 2, '28/10/2017');
INSERT INTO person VALUES(919, 'Radmila', '�im�?kov�','F', '49',  13000, 3, '15.8.2004');
INSERT INTO person VALUES(920, 'Daniel', 'Seidl ','M', '21',  41000, 3, '5/9/2013');
INSERT INTO person VALUES(921, 'Bohuslava', 'Ferkov�','F', '34',  21000, 2, '3.11.2017');
INSERT INTO person VALUES(922, 'Viktor', 'Macha? ','M', '43',  14000, 2, '12/9/2008');
INSERT INTO person VALUES(923, 'And?la', 'Melicharov�','F', '41',  37000, 3, '22.12.2006');
INSERT INTO person VALUES(924, 'Jaroslav', 'Polansk� ','M', '26',  19000, 3, '22/7/2004');
INSERT INTO person VALUES(925, 'Sandra', 'Bart�kov�','F', '27',  44000, 2, '18.10.2003');
INSERT INTO person VALUES(926, 'Lubo�', 'Kr�l�?ek ','M', '48',  28000, 2, '23/12/2015');
INSERT INTO person VALUES(927, 'Kar�n', 'Kraj�?kov�','F', '34',  24000, 2, '30.4.2009');
INSERT INTO person VALUES(928, 'Adrian', 'Kotrba ','M', '31',  33000, 2, '1/11/2011');
INSERT INTO person VALUES(929, 'Old?i�ka', 'Tvrd�kov�','F', '20',  32000, 2, '24.2.2006');
INSERT INTO person VALUES(930, 'Ond?ej', 'Ve?e?a ','M', '53',  43000, 2, '8/11/2006');
INSERT INTO person VALUES(931, 'Bo�ena', '?͎kov�','F', '28',  20000, 3, '28.4.2013');
INSERT INTO person VALUES(932, 'Po?et', 'Kon�?ek ','M', '36',  47000, 3, '11/3/2006');
INSERT INTO person VALUES(933, 'Karin', 'Homolov�','F', '58',  19000, 2, '2.7.2008');
INSERT INTO person VALUES(934, 'Jan', 'Mar��k ','M', '59',  21000, 2, '17/2/2014');
INSERT INTO person VALUES(935, 'Miroslava', 'Kade?�bkov�','F', '21',  43000, 3, '4.9.2015');
INSERT INTO person VALUES(936, 'Gejza', 'V�tek ','M', '41',  26000, 3, '20/6/2013');
INSERT INTO person VALUES(937, 'Miloslava', 'Mina?�kov�','F', '28',  23000, 3, '22.10.2004');
INSERT INTO person VALUES(938, 'Samuel', 'Dan?k ','M', '24',  31000, 3, '28/4/2009');
INSERT INTO person VALUES(939, 'Blanka', 'Vlas�kov�','F', '59',  31000, 3, '11.1.2018');
INSERT INTO person VALUES(940, 'Oleg', 'Koubek ','M', '46',  40000, 3, '6/5/2004');
INSERT INTO person VALUES(941, 'Kv?toslava', 'Hrochov�','F', '21',  46000, 3, '1.3.2007');
INSERT INTO person VALUES(942, 'Alexander 4 000', 'Mu��k ','M', '29',  45000, 3, '7/8/2016');
INSERT INTO person VALUES(943, 'Milena', 'Vav?�kov�','F', '52',  18000, 2, '26.12.2003');
INSERT INTO person VALUES(944, 'Erich', 'Pivo?ka ','M', '51',  19000, 2, '15/8/2011');
INSERT INTO person VALUES(945, 'Pavl�na', 'Borovi?kov�','F', '38',  26000, 2, '16.3.2017');
INSERT INTO person VALUES(946, 'Alfred', 'Ka?�rek ','M', '28',  28000, 2, '23/8/2006');
INSERT INTO person VALUES(947, 'Kv?toslava', 'Nedv?dov�','F', '45',  42000, 2, '4.5.2006');
INSERT INTO person VALUES(948, 'Anton', 'Bl�ha ','M', '57',  33000, 2, '24/11/2018');
INSERT INTO person VALUES(949, 'Tamara', 'Kle?kov�','F', '53',  29000, 3, '5.7.2013');
INSERT INTO person VALUES(950, 'Svatopluk', 'Zl�mal ','M', '39',  38000, 3, '28/3/2018');
INSERT INTO person VALUES(951, 'Nat�lie', 'Hrabovsk�','F', '38',  29000, 2, '9.9.2008');
INSERT INTO person VALUES(952, 'Denis', 'Homolka ','M', '62',  47000, 2, '10/10/2009');
INSERT INTO person VALUES(953, 'Marika', 'Proke�ov�','F', '46',  17000, 3, '12.11.2015');
INSERT INTO person VALUES(954, 'Peter', 'Mou?ka ','M', '44',  16000, 3, '10/2/2009');
INSERT INTO person VALUES(955, 'Lydie', 'Luke�ov�','F', '32',  25000, 3, '7.9.2012');
INSERT INTO person VALUES(956, 'Mari�n', 'Hlav�?ek ','M', '20',  25000, 3, '19/2/2004');
INSERT INTO person VALUES(957, 'Bohdana', 'Krej?�?ov�','F', '39',  40000, 3, '21.3.2018');
INSERT INTO person VALUES(958, 'Du�an', '�varc ','M', '49',  31000, 3, '22/5/2016');
INSERT INTO person VALUES(959, 'Marika', 'Bou?kov�','F', '24',  12000, 2, '15.1.2015');
INSERT INTO person VALUES(960, 'Alexandr', 'Mar��lek ','M', '25',  40000, 2, '30/5/2011');
INSERT INTO person VALUES(961, 'Vanesa', 'Houdkov�','F', '32',  28000, 3, '4.3.2004');
INSERT INTO person VALUES(962, 'Filip', 'Balcar ','M', '54',  45000, 3, '8/4/2007');
INSERT INTO person VALUES(963, 'Gabriela', 'Vesel�','F', '64',  43000, 3, '12.1.2019');
INSERT INTO person VALUES(964, 'Juraj', '�ediv� ','M', '30',  18000, 3, '8/10/2005');
INSERT INTO person VALUES(965, 'Drahom�ra', 'Hrabalov�','F', '26',  23000, 3, '1.3.2008');
INSERT INTO person VALUES(966, 'Mat?j', 'Mare?ek ','M', '59',  23000, 3, '9/1/2018');
INSERT INTO person VALUES(967, 'Romana', 'Jir�kov�','F', '57',  31000, 3, '26.12.2004');
INSERT INTO person VALUES(968, 'Marian', 'Vojt�ek ','M', '35',  32000, 3, '17/1/2013');
INSERT INTO person VALUES(969, 'Bohumila', 'Hlav�?ov�','F', '64',  47000, 3, '9.7.2010');
INSERT INTO person VALUES(970, 'Radek', 'Petr? ','M', '64',  37000, 3, '25/11/2008');
INSERT INTO person VALUES(971, 'Kamila', 'Stehl�kov�','F', '50',  18000, 3, '5.5.2007');
INSERT INTO person VALUES(972, 'Zbyn?k', 'Moln�r ','M', '40',  46000, 3, '3/12/2003');
INSERT INTO person VALUES(973, 'Kristina', 'Richtrov�','F', '57',  34000, 3, '15.11.2012');
INSERT INTO person VALUES(974, 'Josef', 'Stupka ','M', '23',  16000, 3, '6/3/2016');
INSERT INTO person VALUES(975, '�t?p�nka', 'Ve?erkov�','F', '43',  42000, 2, '10.9.2009');
INSERT INTO person VALUES(976, 'Patrik', 'Sobotka ','M', '46',  25000, 2, '14/3/2011');
INSERT INTO person VALUES(977, 'Edita', 'Hamplov�','F', '50',  22000, 3, '24.3.2015');
INSERT INTO person VALUES(978, '?udov�t', 'Mina?�k ','M', '28',  30000, 3, '21/1/2007');
INSERT INTO person VALUES(979, 'Alice', 'Frankov�','F', '35',  29000, 2, '18.1.2012');
INSERT INTO person VALUES(980, 'Stanislav', 'Hrbek ','M', '51',  39000, 2, '23/6/2018');
INSERT INTO person VALUES(981, 'Al�beta', 'Hendrychov�','F', '44',  17000, 3, '22.3.2019');
INSERT INTO person VALUES(982, 'Svatoslav', 'Kotrba ','M', '33',  44000, 3, '24/10/2017');
INSERT INTO person VALUES(983, 'Kate?ina', 'Jedli?kov�','F', '51',  33000, 4, '9.5.2008');
INSERT INTO person VALUES(984, 'Vili�m', 'Pavl�k ','M', '62',  13000, 4, '2/9/2013');
INSERT INTO person VALUES(985, 'Nad?�da', 'Vav?�kov�','F', '38',  13000, 4, '25.10.2006');
INSERT INTO person VALUES(986, 'Milan', 'Kon�?ek ','M', '37',  22000, 4, '4/3/2012');
INSERT INTO person VALUES(987, 'Al�beta', 'Mat?jkov�','F', '22',  12000, 3, '25.5.2018');
INSERT INTO person VALUES(988, 'Vladim�r', 'Mar��k ','M', '60',  32000, 3, '17/9/2003');
INSERT INTO person VALUES(989, 'M�ria', 'Nedv?dov�','F', '30',  36000, 4, '2.3.2009');
INSERT INTO person VALUES(990, 'Roland', 'Bedn�? ','M', '42',  36000, 4, '14/6/2019');
INSERT INTO person VALUES(991, 'Be�ta', 'Vejvodov�','F', '61',  36000, 2, '7.5.2004');
INSERT INTO person VALUES(992, 'Nicolas', 'Je� ','M', '20',  46000, 2, '27/12/2010');
INSERT INTO person VALUES(993, 'Kv?ta', 'Hrabovsk�','F', '23',  24000, 3, '10.7.2011');
INSERT INTO person VALUES(994, 'Alex', 'Koubek ','M', '48',  15000, 3, '29/4/2010');
INSERT INTO person VALUES(995, 'Josefa', 'T�borsk�','F', '30',  39000, 4, '20.1.2017');
INSERT INTO person VALUES(996, '?estm�r', 'Mu��k ','M', '31',  20000, 4, '8/3/2006');
INSERT INTO person VALUES(997, 'S�ra', 'Knotkov�','F', '62',  47000, 3, '16.11.2013');
INSERT INTO person VALUES(998, 'Imrich', 'Pivo?ka ','M', '53',  29000, 3, '8/8/2017');
INSERT INTO person VALUES(999, 'Kv?ta', 'Wagnerov�','F', '47',  19000, 3, '12.9.2010');
INSERT INTO person VALUES(1000, 'Ruslan', 'Ka?�rek ','M', '29',  38000, 3, '15/8/2012');
INSERT INTO person VALUES(1001, 'Bohuslava', '?�hov�','F', '55',  35000, 3, '25.3.2016');
INSERT INTO person VALUES(1002, 'Ondrej', 'Bl�ha ','M', '58',  44000, 3, '24/6/2008');
INSERT INTO person VALUES(1003, 'Silvie 7300', 'Musilov�','F', '40',  42000, 2, '18.1.2013');
INSERT INTO person VALUES(1004, 'Alan', 'Hrdina ','M', '35',  17000, 2, '2/7/2003');
INSERT INTO person VALUES(1005, 'Natalie', 'Kub�nov�','F', '49',  30000, 4, '28.10.2003');
INSERT INTO person VALUES(1006, 'Kristi�n', '��p ','M', '63',  21000, 4, '28/3/2019');
INSERT INTO person VALUES(1007, 'Jitka', 'M�?kov�','F', '56',  46000, 4, '10.5.2009');
INSERT INTO person VALUES(1008, 'P?emysl', 'Mou?ka ','M', '45',  27000, 4, '4/2/2015');
INSERT INTO person VALUES(1009, 'Anna', 'Kopalov�','F', '41',  18000, 3, '6.3.2006');
INSERT INTO person VALUES(1010, 'Leopold', 'Hlav�?ek ','M', '22',  36000, 3, '11/2/2010');
INSERT INTO person VALUES(1011, 'Zuzana', 'Z�me?n�kov�','F', '49',  33000, 4, '17.9.2011');
INSERT INTO person VALUES(1012, 'Emil', '�varc ','M', '51',  41000, 4, '21/12/2005');
INSERT INTO person VALUES(1013, 'Jitka', 'Gabrielov�','F', '34',  41000, 3, '13.7.2008');
INSERT INTO person VALUES(1014, 'Ev�en', 'Mar��lek ','M', '27',  14000, 3, '23/5/2017');
INSERT INTO person VALUES(1015, 'Eva', 'Voj�?kov�','F', '20',  13000, 3, '8.5.2005');
INSERT INTO person VALUES(1016, '?en?k', 'Sko?epa ','M', '49',  23000, 3, '30/5/2012');
INSERT INTO person VALUES(1017, 'Hedvika', 'Ve?erkov�','F', '28',  36000, 4, '10.7.2012');
INSERT INTO person VALUES(1018, 'Mikul�', '�ediv� ','M', '31',  28000, 4, '2/10/2011');
INSERT INTO person VALUES(1019, 'Dita', 'Hamplov�','F', '35',  16000, 4, '21.1.2018');
INSERT INTO person VALUES(1020, 'Kamil', 'B�l� ','M', '60',  33000, 4, '10/8/2007');
INSERT INTO person VALUES(1021, 'Nikol', 'Frankov�','F', '21',  24000, 4, '17.11.2014');
INSERT INTO person VALUES(1022, 'Erik', 'Dvorsk� ','M', '37',  42000, 4, '10/1/2019');
INSERT INTO person VALUES(1023, 'Karla', 'Koubov�','F', '52',  32000, 3, '13.9.2011');
INSERT INTO person VALUES(1024, 'Nikolas', 'Kala ','M', '59',  16000, 3, '18/1/2014');
INSERT INTO person VALUES(1025, 'Dita', 'P�chov�','F', '60',  47000, 3, '26.3.2017');
INSERT INTO person VALUES(1026, 'Bed?ich', 'Moln�r ','M', '42',  21000, 3, '26/11/2009');
INSERT INTO person VALUES(1027, 'Nikol', '��rov�','F', '45',  19000, 3, '19.1.2014');
INSERT INTO person VALUES(1028, 'Andrej', 'Ad�mek ','M', '64',  30000, 3, '3/12/2004');
INSERT INTO person VALUES(1029, 'Bronislava', 'Men��kov�','F', '52',  35000, 3, '2.8.2019');
INSERT INTO person VALUES(1030, 'Alois', 'Sobotka ','M', '47',  35000, 3, '7/3/2017');
INSERT INTO person VALUES(1031, 'Ji?ina', 'Pale?kov�','F', '61',  23000, 4, '11.5.2010');
INSERT INTO person VALUES(1032, 'Libor', 'Polansk� ','M', '29',  40000, 4, '8/7/2016');
INSERT INTO person VALUES(1033, 'Petra', 'Vejvodov�','F', '46',  30000, 4, '7.3.2007');
INSERT INTO person VALUES(1034, 'Marcel', 'Kr�l�?ek ','M', '52',  13000, 4, '16/7/2011');
INSERT INTO person VALUES(1035, 'Libu�e', 'Ondr�?kov�','F', '53',  46000, 4, '17.9.2012');
INSERT INTO person VALUES(1036, 'Karel', 'Jakoubek ','M', '34',  18000, 4, '25/5/2007');
INSERT INTO person VALUES(1037, 'Ivana', 'Kop?ivov�','F', '39',  18000, 4, '14.7.2009');
INSERT INTO person VALUES(1038, 'Rostislav', '�koda ','M', '57',  28000, 4, '25/10/2018');
INSERT INTO person VALUES(1039, 'Andrea', 'Maxov�','F', '46',  34000, 4, '25.1.2015');
INSERT INTO person VALUES(1040, 'Maxmili�n', 'Buchta ','M', '40',  33000, 4, '3/9/2014');
INSERT INTO person VALUES(1041, 'Dana', 'Hejnov�','F', '32',  41000, 3, '21.11.2011');
INSERT INTO person VALUES(1042, 'Vojt?ch', 'Mar��k ','M', '62',  42000, 3, '10/9/2009');
INSERT INTO person VALUES(1043, 'Sylva', '?�hov�','F', '40',  29000, 1, '22.1.2019');
INSERT INTO person VALUES(1044, 'Martin', 'Bedn�? ','M', '44',  47000, 1, '11/1/2009');
INSERT INTO person VALUES(1045, 'Andrea', 'Buchtov�','F', '24',  29000, 3, '29.3.2014');
INSERT INTO person VALUES(1046, 'Miroslav', 'Je� ','M', '21',  21000, 3, '20/12/2016');
INSERT INTO person VALUES(1047, 'Maria', '?eho?ov�','F', '33',  17000, 4, '5.1.2005');
INSERT INTO person VALUES(1048, 'Artur', 'Koubek ','M', '49',  25000, 4, '22/4/2016');
INSERT INTO person VALUES(1049, 'Gabriela', 'Reme�ov�','F', '63',  16000, 3, '5.8.2016');
INSERT INTO person VALUES(1050, 'Zby�ek', 'Uhl�? ','M', '27',  35000, 3, '5/11/2007');
INSERT INTO person VALUES(1051, 'Karolina', 'Va��?kov�','F', '26',  40000, 4, '15.5.2007');
INSERT INTO person VALUES(1052, 'Walter', 'Bernard ','M', '55',  40000, 4, '9/3/2007');
INSERT INTO person VALUES(1053, 'Sylvie', 'Truhl�?ov�','F', '33',  20000, 1, '25.11.2012');
INSERT INTO person VALUES(1054, 'Juraj', 'R?�ek ','M', '38',  45000, 1, '10/6/2019');
INSERT INTO person VALUES(1055, 'Valerie', 'Zezulov�','F', '64',  28000, 4, '21.9.2009');
INSERT INTO person VALUES(1056, 'Petro', 'Bl�ha ','M', '60',  18000, 4, '18/6/2014');
INSERT INTO person VALUES(1057, 'Jarom�ra', 'Hankov�','F', '50',  35000, 3, '17.7.2006');
INSERT INTO person VALUES(1058, 'Vladimir', 'Hrdina ','M', '36',  27000, 3, '25/6/2009');
INSERT INTO person VALUES(1059, 'Sylvie', 'Horov�','F', '57',  15000, 4, '28.1.2012');
INSERT INTO person VALUES(1060, 'Julius', 'Homolka ','M', '19',  32000, 4, '3/5/2005');
INSERT INTO person VALUES(1061, 'Nata�a', 'Hanzl�kov�','F', '43',  23000, 3, '23.11.2008');
INSERT INTO person VALUES(1062, 'J�lius', 'Sad�lek ','M', '41',  42000, 3, '4/10/2016');
INSERT INTO person VALUES(1063, 'Kl�ra', 'Skalov�','F', '51',  47000, 4, '26.1.2016');
INSERT INTO person VALUES(1064, 'Viliam', 'Hlav�?ek ','M', '23',  46000, 4, '5/2/2016');
INSERT INTO person VALUES(1065, 'Eli�ka', 'Kloudov�','F', '37',  18000, 4, '21.11.2012');
INSERT INTO person VALUES(1066, 'Bruno', 'Hus�k ','M', '46',  19000, 4, '12/2/2011');
INSERT INTO person VALUES(1067, 'Daniela', 'Vrbov�','F', '44',  34000, 4, '4.6.2018');
INSERT INTO person VALUES(1068, 'Matou�', 'Mar��lek ','M', '29',  25000, 4, '22/12/2006');
INSERT INTO person VALUES(1069, 'Zdenka', 'Pechov�','F', '29',  42000, 3, '30.3.2015');
INSERT INTO person VALUES(1070, 'Hubert', 'Sko?epa ','M', '51',  34000, 3, '24/5/2018');
INSERT INTO person VALUES(1071, 'Nad?�da', '�andov�','F', '37',  21000, 4, '17.5.2004');
INSERT INTO person VALUES(1072, 'Hynek', 'Zv??ina ','M', '34',  39000, 4, '1/4/2014');
INSERT INTO person VALUES(1073, 'Daniela', 'Kom�nkov�','F', '22',  29000, 3, '6.8.2017');
INSERT INTO person VALUES(1074, 'Ferdinand', 'Valenta ','M', '56',  12000, 3, '9/4/2009');
INSERT INTO person VALUES(1075, 'M�ria', 'Kulh�nkov�','F', '29',  45000, 4, '24.9.2006');
INSERT INTO person VALUES(1076, 'Radom�r', 'Jedli?ka ','M', '39',  18000, 4, '15/2/2005');
INSERT INTO person VALUES(1077, 'Olena', 'Hrbkov�','F', '38',  33000, 1, '26.11.2013');
INSERT INTO person VALUES(1078, 'Lud?k', 'Petr? ','M', '21',  22000, 1, '18/6/2004');
INSERT INTO person VALUES(1079, 'Patricie', 'Pa�kov�','F', '23',  40000, 4, '22.9.2010');
INSERT INTO person VALUES(1080, 'Kry�tof', 'Moln�r ','M', '44',  31000, 4, '20/11/2015');
INSERT INTO person VALUES(1081, 'Radom�ra', 'Kl�mov�','F', '31',  20000, 1, '4.4.2016');
INSERT INTO person VALUES(1082, 'Ivan', 'Stupka ','M', '27',  37000, 1, '28/9/2011');
INSERT INTO person VALUES(1083, 'Na?a', 'Pe�kov�','F', '62',  28000, 4, '29.1.2013');
INSERT INTO person VALUES(1084, 'Ludv�k', 'Sobotka ','M', '49',  46000, 4, '5/10/2006');
INSERT INTO person VALUES(1085, 'Tatiana', 'V�clavkov�','F', '23',  44000, 1, '12.8.2018');
INSERT INTO person VALUES(1086, 'Zden?k', 'Mina?�k ','M', '32',  15000, 1, '7/1/2019');
INSERT INTO person VALUES(1087, 'Miriam', '�lechtov�','F', '55',  15000, 4, '7.6.2015');
INSERT INTO person VALUES(1088, 'Richard', 'Hrbek ','M', '54',  24000, 4, '14/1/2014');
INSERT INTO person VALUES(1089, 'Hana', 'Martinkov�','F', '62',  31000, 4, '25.7.2004');
INSERT INTO person VALUES(1090, 'V?roslav', 'Schejbal ','M', '37',  30000, 4, '23/11/2009');
INSERT INTO person VALUES(1091, 'Natalie', 'Peterkov�','F', '47',  39000, 4, '14.10.2017');
INSERT INTO person VALUES(1092, 'Miloslav', 'Bar�k ','M', '59',  39000, 4, '30/11/2004');
INSERT INTO person VALUES(1093, 'Jitka', 'Knapov�','F', '55',  19000, 4, '2.12.2006');
INSERT INTO person VALUES(1094, 'Alan', '�im?�k ','M', '42',  44000, 4, '4/3/2017');
INSERT INTO person VALUES(1095, 'Anna', 'Kavkov�','F', '40',  26000, 4, '28.9.2003');
INSERT INTO person VALUES(1096, 'Jaroslav', 'Nov�?ek ','M', '19',  17000, 4, '11/3/2012');
INSERT INTO person VALUES(1097, 'Zuzana', 'Hude?kov�','F', '47',  42000, 4, '10.4.2009');
INSERT INTO person VALUES(1098, 'Augustin', 'V�clav�k ','M', '48',  22000, 4, '18/1/2008');
INSERT INTO person VALUES(1099, 'Vladislava', 'Tepl�','F', '56',  30000, 1, '12.6.2016');
INSERT INTO person VALUES(1100, 'Ota', 'Baloun ','M', '30',  27000, 1, '22/5/2007');
INSERT INTO person VALUES(1101, 'Leona', 'Rudolfov�','F', '41',  38000, 1, '7.4.2013');
INSERT INTO person VALUES(1102, 'Erv�n', 'H�bl ','M', '52',  36000, 1, '22/10/2018');
INSERT INTO person VALUES(1103, 'Ivanka', 'Sobotkov�','F', '49',  17000, 1, '19.10.2018');
INSERT INTO person VALUES(1104, 'Vlastislav', '� astn� ','M', '35',  42000, 1, '30/8/2014');
INSERT INTO person VALUES(1105, 'Vladislava', 'Hole?kov�','F', '34',  25000, 4, '15.8.2015');
INSERT INTO person VALUES(1106, 'Gabriel', 'Jon� ','M', '57',  15000, 4, '7/9/2009');
INSERT INTO person VALUES(1107, 'Jindra', 'Hanzalov�','F', '41',  41000, 1, '2.10.2004');
INSERT INTO person VALUES(1108, 'Radovan', 'Doubek ','M', '40',  20000, 1, '16/7/2005');
INSERT INTO person VALUES(1109, 'Elena', 'Hanouskov�','F', '27',  12000, 4, '22.12.2017');
INSERT INTO person VALUES(1110, 'Drahom�r', 'Pa�ek ','M', '62',  29000, 4, '16/12/2016');
INSERT INTO person VALUES(1111, '�ofie', 'Kola?�kov�','F', '34',  28000, 1, '9.2.2007');
INSERT INTO person VALUES(1112, 'Jozef', 'Mat?j�?ek ','M', '45',  34000, 1, '25/10/2012');
INSERT INTO person VALUES(1113, 'Jindra', 'Valov�','F', '20',  36000, 4, '6.12.2003');
INSERT INTO person VALUES(1114, 'Alexander 4 000', 'Br�zdil ','M', '22',  44000, 4, '2/11/2007');
INSERT INTO person VALUES(1115, 'Johana', 'Moudr�','F', '27',  16000, 4, '18.6.2009');
INSERT INTO person VALUES(1116, 'Lubom�r', 'Kopeck� ','M', '51',  13000, 4, '11/9/2003');
INSERT INTO person VALUES(1117, 'Ema', 'Lavi?kov�','F', '58',  23000, 4, '13.4.2006');
INSERT INTO person VALUES(1118, 'B?etislav', 'Balog ','M', '27',  22000, 4, '11/2/2015');
INSERT INTO person VALUES(1119, 'Iveta', 'Linhartov�','F', '21',  47000, 1, '15.6.2013');
INSERT INTO person VALUES(1120, 'Vit', 'Kubi� ','M', '55',  27000, 1, '14/6/2014');
INSERT INTO person VALUES(1121, 'Ilona', 'Hankov�','F', '28',  27000, 1, '27.12.2018');
INSERT INTO person VALUES(1122, 'Prokop', 'L�tal ','M', '38',  32000, 1, '23/4/2010');
INSERT INTO person VALUES(1123, 'Radka', 'Kalouskov�','F', '60',  35000, 1, '23.10.2015');
INSERT INTO person VALUES(1124, 'Rudolf', 'Jane?ek ','M', '60',  41000, 1, '30/4/2005');
INSERT INTO person VALUES(1125, 'Danu�e', 'Hanzl�kov�','F', '21',  15000, 1, '10.12.2004');
INSERT INTO person VALUES(1126, 'Bruno', 'David ','M', '43',  46000, 1, '2/8/2017');
INSERT INTO person VALUES(1127, 'Aneta', '?ez�?ov�','F', '52',  22000, 1, '1.3.2018');
INSERT INTO person VALUES(1128, 'Milan', 'Z�ruba ','M', '20',  20000, 1, '9/8/2012');
INSERT INTO person VALUES(1129, 'Magdalena', 'Linkov�','F', '60',  38000, 1, '19.4.2007');
INSERT INTO person VALUES(1130, 'Hubert', 'Sova ','M', '48',  25000, 1, '17/6/2008');
INSERT INTO person VALUES(1131, 'Danu�e', 'Mokr�','F', '45',  46000, 4, '12.2.2004');
INSERT INTO person VALUES(1132, 'Roland', 'Hrube� ','M', '25',  34000, 4, '26/6/2003');
INSERT INTO person VALUES(1133, 'Karla', 'Ka�p�rkov�','F', '52',  25000, 1, '25.8.2009');
INSERT INTO person VALUES(1134, 'Ferdinand', 'Fousek ','M', '54',  39000, 1, '27/9/2015');
INSERT INTO person VALUES(1135, 'Ladislava', 'Vojtov�','F', '38',  33000, 4, '21.6.2006');
INSERT INTO person VALUES(1136, 'Alex', 'Hor�?ek ','M', '30',  12000, 4, '4/10/2010');
INSERT INTO person VALUES(1137, 'Nikol', 'Chlupov�','F', '45',  13000, 1, '2.1.2012');
INSERT INTO person VALUES(1138, '?estm�r', 'B?ezina ','M', '59',  18000, 1, '13/8/2006');
INSERT INTO person VALUES(1139, 'Karla', 'Dani�ov�','F', '30',  21000, 4, '28.10.2008');
INSERT INTO person VALUES(1140, 'Imrich', 'Janovsk� ','M', '35',  27000, 4, '13/1/2018');
INSERT INTO person VALUES(1141, 'Radana', 'Radov�','F', '39',  44000, 1, '31.12.2015');
INSERT INTO person VALUES(1142, 'Bohdan', 'Kamen�k ','M', '63',  32000, 1, '16/5/2017');
INSERT INTO person VALUES(1143, 'Hanna', 'Boh�?ov�','F', '24',  16000, 1, '25.10.2012');
INSERT INTO person VALUES(1144, 'Mario', 'Ko?�nek ','M', '40',  41000, 1, '24/5/2012');
INSERT INTO person VALUES(1145, 'Iryna', 'Tome�ov�','F', '32',  32000, 1, '8.5.2018');
INSERT INTO person VALUES(1146, 'Mojm�r', 'Hofman ','M', '23',  46000, 1, '1/4/2008');
INSERT INTO person VALUES(1147, 'Nicole', '�im�nkov�','F', '63',  40000, 4, '4.3.2015');
INSERT INTO person VALUES(1148, 'Kristi�n', '�iga ','M', '45',  19000, 4, '2/9/2019');
INSERT INTO person VALUES(1149, 'Vendula', 'Hrub�','F', '26',  27000, 2, '11.12.2005');
INSERT INTO person VALUES(1150, 'Boris', 'Kala� ','M', '27',  24000, 2, '4/1/2019');
INSERT INTO person VALUES(1151, 'Laura', 'K?enkov�','F', '56',  27000, 4, '11.7.2017');
INSERT INTO person VALUES(1152, 'Leopold', 'Ho?ej�� ','M', '50',  34000, 4, '19/7/2010');
INSERT INTO person VALUES(1153, 'Julie', 'Ulrichov�','F', '64',  15000, 1, '19.4.2008');
INSERT INTO person VALUES(1154, 'Lum�r', 'Veverka ','M', '32',  38000, 1, '19/11/2009');
INSERT INTO person VALUES(1155, 'Linda', 'Peterkov�','F', '26',  31000, 2, '31.10.2013');
INSERT INTO person VALUES(1156, 'Bohumil', '�mejkal ','M', '61',  44000, 2, '28/9/2005');
INSERT INTO person VALUES(1157, 'Nela', 'Vodi?kov�','F', '57',  38000, 1, '27.8.2010');
INSERT INTO person VALUES(1158, 'Maty�', 'Vo?�ek ','M', '37',  17000, 1, '28/2/2017');
INSERT INTO person VALUES(1159, 'Julie', 'Pt�?kov�','F', '43',  46000, 1, '22.6.2007');
INSERT INTO person VALUES(1160, 'Mikul�', 'Dosko?il ','M', '60',  26000, 1, '8/3/2012');
INSERT INTO person VALUES(1161, 'Terezie', 'Mayerov�','F', '50',  26000, 1, '2.1.2013');
INSERT INTO person VALUES(1162, 'Kamil', 'Kotas ','M', '43',  31000, 1, '15/1/2008');
INSERT INTO person VALUES(1163, 'Erika', 'Berkyov�','F', '35',  33000, 4, '29.10.2009');
INSERT INTO person VALUES(1164, 'Bronislav', 'Hork� ','M', '19',  40000, 4, '17/6/2019');
INSERT INTO person VALUES(1165, 'Darina', 'Veverkov�','F', '43',  13000, 1, '12.5.2015');
INSERT INTO person VALUES(1166, 'Milo�', 'Hanzl�k ','M', '48',  46000, 1, '26/4/2015');
INSERT INTO person VALUES(1167, 'Zde?ka', 'Hanusov�','F', '51',  37000, 2, '18.2.2006');
INSERT INTO person VALUES(1168, 'Luk�', '�im�k ','M', '30',  14000, 2, '27/8/2014');
INSERT INTO person VALUES(1169, 'V?ra', 'Boudov�','F', '37',  45000, 1, '10.5.2019');
INSERT INTO person VALUES(1170, 'Bohuslav', 'Kopeck� ','M', '52',  23000, 1, '3/9/2009');
INSERT INTO person VALUES(1171, 'Vlasta', 'Kr�tk�','F', '44',  25000, 2, '27.6.2008');
INSERT INTO person VALUES(1172, 'Kevin', 'Kub�?ek ','M', '35',  29000, 2, '13/7/2005');
INSERT INTO person VALUES(1173, 'Martina', 'Klime�ov�','F', '29',  32000, 1, '22.4.2005');
INSERT INTO person VALUES(1174, 'Libor', 'Plach� ','M', '58',  38000, 1, '13/12/2016');
INSERT INTO person VALUES(1175, 'Eli�ka', 'Kune�ov�','F', '37',  12000, 2, '3.11.2010');
INSERT INTO person VALUES(1176, 'Vladan', 'Mikula ','M', '41',  43000, 2, '22/10/2012');
INSERT INTO person VALUES(1177, 'Vlasta', '��dkov�','F', '22',  20000, 1, '30.8.2007');
INSERT INTO person VALUES(1178, 'Karel', '?ernohorsk� ','M', '63',  16000, 1, '30/10/2007');
INSERT INTO person VALUES(1179, 'Zdenka', 'Dobe�ov�','F', '29',  36000, 1, '12.3.2013');
INSERT INTO person VALUES(1180, 'Norbert', '�im�nek ','M', '46',  22000, 1, '7/9/2003');
INSERT INTO person VALUES(1181, 'Pavla', 'Form�nkov�','F', '61',  43000, 1, '6.1.2010');
INSERT INTO person VALUES(1182, 'Maxmili�n', 'Dole�al ','M', '22',  31000, 1, '8/2/2015');
INSERT INTO person VALUES(1183, 'Daniela', 'Ne�porov�','F', '22',  23000, 1, '20.7.2015');
INSERT INTO person VALUES(1184, 'Dan', 'Nguyen ','M', '51',  36000, 1, '17/12/2010');
INSERT INTO person VALUES(1185, 'Zdenka', 'L�talov�','F', '54',  31000, 1, '15.5.2012');
INSERT INTO person VALUES(1186, 'Vasil', 'Zelen� ','M', '27',  45000, 1, '24/12/2005');
INSERT INTO person VALUES(1187, 'Vlastimila', 'Kohoutov�','F', '62',  18000, 2, '17.7.2019');
INSERT INTO person VALUES(1188, 'Radomil', 'Fousek ','M', '55',  14000, 2, '27/4/2005');
INSERT INTO person VALUES(1189, 'Em�lia', 'Jirou�kov�','F', '23',  34000, 2, '3.9.2008');
INSERT INTO person VALUES(1190, 'Bohum�r', 'Reme� ','M', '38',  19000, 2, '29/7/2017');
INSERT INTO person VALUES(1191, 'Ingrid', 'Karlov�','F', '55',  42000, 2, '30.6.2005');
INSERT INTO person VALUES(1192, 'Gustav', 'Klime� ','M', '61',  28000, 2, '5/8/2012');
INSERT INTO person VALUES(1193, 'Na?a', 'Havr�nkov�','F', '62',  22000, 2, '11.1.2011');
INSERT INTO person VALUES(1194, 'Eduard', 'Burda ','M', '44',  34000, 2, '14/6/2008');
INSERT INTO person VALUES(1195, 'Patricie', 'Bauerov�','F', '47',  29000, 1, '7.11.2007');
INSERT INTO person VALUES(1196, 'Juraj', 'Zach ','M', '20',  43000, 1, '22/6/2003');
INSERT INTO person VALUES(1197, 'Radom�ra', 'Rousov�','F', '55',  45000, 2, '20.5.2013');
INSERT INTO person VALUES(1198, 'Dominik', 'Junek ','M', '49',  12000, 2, '24/9/2015');
INSERT INTO person VALUES(1199, 'Oksana', 'Karbanov�','F', '40',  17000, 1, '16.3.2010');
INSERT INTO person VALUES(1200, 'Marian', '�emli?ka ','M', '25',  21000, 1, '1/10/2010');
INSERT INTO person VALUES(1201, 'Natalie', 'Kleinov�','F', '48',  33000, 2, '27.9.2015');
INSERT INTO person VALUES(1202, 'Marek', 'Moudr� ','M', '54',  26000, 2, '10/8/2006');
INSERT INTO person VALUES(1203, 'Miriam', 'Bare�ov�','F', '33',  40000, 1, '22.7.2012');
INSERT INTO person VALUES(1204, '�tefan', 'Kov�? ','M', '30',  36000, 1, '10/1/2018');
INSERT INTO person VALUES(1205, 'Hana', 'Sv?tl�kov�','F', '40',  20000, 2, '2.2.2018');
INSERT INTO person VALUES(1206, 'Pavel', 'Zaj�?ek ','M', '59',  41000, 2, '18/11/2013');
INSERT INTO person VALUES(1207, 'Zita', 'Ko?kov�','F', '26',  28000, 1, '29.11.2014');
INSERT INTO person VALUES(1208, 'Bohumil', 'Synek ','M', '36',  14000, 1, '26/11/2008');
INSERT INTO person VALUES(1209, 'Dominika', 'Zaj�?kov�','F', '34',  16000, 2, '7.9.2005');
INSERT INTO person VALUES(1210, 'Jakub', '�ilhav� ','M', '64',  19000, 2, '29/3/2008');
INSERT INTO person VALUES(1211, 'Leona', '�im�nkov�','F', '41',  31000, 2, '21.3.2011');
INSERT INTO person VALUES(1212, 'J?lius', 'Kr�l ','M', '47',  24000, 2, '5/2/2004');
INSERT INTO person VALUES(1213, 'Hedvika', 'Vydrov�','F', '27',  39000, 2, '15.1.2008');
INSERT INTO person VALUES(1214, 'Svatoslav', 'Luk� ','M', '23',  33000, 2, '9/7/2015');
INSERT INTO person VALUES(1215, 'Vladislava', 'K?enkov�','F', '34',  19000, 2, '28.7.2013');
INSERT INTO person VALUES(1216, 'Leo', 'Jan�?ek ','M', '52',  38000, 2, '17/5/2011');
INSERT INTO person VALUES(1217, 'Leona', 'G�borov�','F', '20',  27000, 2, '23.5.2010');
INSERT INTO person VALUES(1218, 'Stepan', 'Ors�g ','M', '28',  12000, 2, '24/5/2006');
INSERT INTO person VALUES(1219, 'Elena', 'Tanco�ov�','F', '27',  42000, 2, '4.12.2015');
INSERT INTO person VALUES(1220, 'Mikul�', 'Mlejnek ','M', '57',  17000, 2, '26/8/2018');
INSERT INTO person VALUES(1221, 'Dita', 'Kocmanov�','F', '58',  14000, 1, '29.9.2012');
INSERT INTO person VALUES(1222, 'Sebastian', 'Maz�nek ','M', '33',  26000, 1, '2/9/2013');
INSERT INTO person VALUES(1223, 'Jaroslava', 'Pt�?kov�','F', '21',  38000, 3, '9.7.2003');
INSERT INTO person VALUES(1224, 'Emanuel', 'Zima ','M', '62',  31000, 3, '3/1/2013');
INSERT INTO person VALUES(1225, 'Elena', 'M?llerov�','F', '51',  37000, 1, '6.2.2015');
INSERT INTO person VALUES(1226, 'Nikolas', 'Mare?ek ','M', '39',  40000, 1, '19/7/2004');
INSERT INTO person VALUES(1227, 'Ji?ina', 'Berkyov�','F', '60',  25000, 2, '15.11.2005');
INSERT INTO person VALUES(1228, '?estm�r', 'P�a ','M', '21',  45000, 2, '20/11/2003');
INSERT INTO person VALUES(1229, 'Michala', '�imkov�','F', '44',  25000, 1, '15.6.2017');
INSERT INTO person VALUES(1230, 'Andrej', 'Sk�cel ','M', '44',  19000, 1, '29/10/2011');
INSERT INTO person VALUES(1231, 'Libu�e', '�ubrtov�','F', '52',  13000, 2, '23.3.2008');
INSERT INTO person VALUES(1232, 'Arno�t', 'Mach�?ek ','M', '26',  24000, 2, '1/3/2011');
INSERT INTO person VALUES(1233, 'Radka', '�?rkov�','F', '60',  29000, 3, '4.10.2013');
INSERT INTO person VALUES(1234, 'Libor', 'Kub�k ','M', '55',  29000, 3, '8/1/2007');
INSERT INTO person VALUES(1235, 'Iveta', 'Jur?�kov�','F', '45',  36000, 2, '31.7.2010');
INSERT INTO person VALUES(1236, 'Marcel', 'Van??ek ','M', '31',  38000, 2, '10/6/2018');
INSERT INTO person VALUES(1237, 'Ilona', 'Zachov�','F', '52',  16000, 3, '11.2.2016');
INSERT INTO person VALUES(1238, 'Karel', 'Pr?cha ','M', '60',  43000, 3, '18/4/2014');
INSERT INTO person VALUES(1239, 'Ad�la', 'Slab�','F', '38',  24000, 2, '7.12.2012');
INSERT INTO person VALUES(1240, 'Rostislav', 'Jan? ','M', '37',  16000, 2, '26/4/2009');
INSERT INTO person VALUES(1241, 'Andrea', 'Chovancov�','F', '23',  31000, 1, '3.10.2009');
INSERT INTO person VALUES(1242, 'Bohum�r', 'Kotrba ','M', '59',  26000, 1, '3/5/2004');
INSERT INTO person VALUES(1243, 'Aneta', 'Kr�l�?kov�','F', '31',  47000, 2, '16.4.2015');
INSERT INTO person VALUES(1244, 'Jarom�r', 'Du�ek ','M', '42',  31000, 2, '4/8/2016');
INSERT INTO person VALUES(1245, 'D�a', 'Form�nkov�','F', '39',  35000, 3, '23.1.2006');
INSERT INTO person VALUES(1246, 'Martin', 'Hr?za ','M', '24',  36000, 3, '7/12/2015');
INSERT INTO person VALUES(1247, 'Drahom�ra', 'Junkov�','F', '23',  35000, 2, '22.8.2017');
INSERT INTO person VALUES(1248, 'Miroslav', 'Votava ','M', '47',  45000, 2, '21/6/2007');
INSERT INTO person VALUES(1249, 'Aloisie', 'L�talov�','F', '32',  23000, 3, '31.5.2008');
INSERT INTO person VALUES(1250, 'Artur', 'Srb ','M', '29',  14000, 3, '22/10/2006');
INSERT INTO person VALUES(1251, 'Ladislava', 'Zapletalov�','F', '62',  22000, 1, '6.8.2003');
INSERT INTO person VALUES(1252, 'Zby�ek', 'Pernica ','M', '52',  24000, 1, '30/9/2014');
INSERT INTO person VALUES(1253, 'Hanna', 'Matulov�','F', '25',  46000, 3, '8.10.2010');
INSERT INTO person VALUES(1254, 'Walter', '�ebesta ','M', '34',  28000, 3, '31/1/2014');
INSERT INTO person VALUES(1255, 'Sylvie', 'Prchalov�','F', '56',  18000, 2, '4.8.2007');
INSERT INTO person VALUES(1256, 'Petr', 'Mu��k ','M', '57',  38000, 2, '7/2/2009');
INSERT INTO person VALUES(1257, 'Radana', 'Winklerov�','F', '63',  33000, 2, '14.2.2013');
INSERT INTO person VALUES(1258, 'Petro', 'Zikmund ','M', '40',  43000, 2, '17/12/2004');
INSERT INTO person VALUES(1259, 'Hanna', 'Ko�kov�','F', '49',  41000, 2, '10.12.2009');
INSERT INTO person VALUES(1260, 'Vladimir', 'Kalivoda ','M', '62',  16000, 2, '19/5/2016');
INSERT INTO person VALUES(1261, 'So?a', 'Barto?ov�','F', '57',  29000, 3, '11.2.2017');
INSERT INTO person VALUES(1262, 'Juli�s', '?ejka ','M', '44',  21000, 3, '20/9/2015');
INSERT INTO person VALUES(1263, 'Nicole', '�indlerov�','F', '41',  29000, 2, '18.4.2012');
INSERT INTO person VALUES(1264, 'J?lius', 'Han�k ','M', '21',  30000, 2, '5/4/2007');
INSERT INTO person VALUES(1265, 'Al�b?ta', 'R?�kov�','F', '50',  16000, 3, '21.6.2019');
INSERT INTO person VALUES(1266, 'Viliam', 'Dolej�� ','M', '49',  35000, 3, '6/8/2006');
INSERT INTO person VALUES(1267, 'Nela', 'Bare�ov�','F', '57',  32000, 3, '8.8.2008');
INSERT INTO person VALUES(1268, 'Vil�m', 'St�rek ','M', '32',  40000, 3, '8/11/2018');
INSERT INTO person VALUES(1269, 'Julie', 'Vacul�kov�','F', '43',  40000, 2, '4.6.2005');
INSERT INTO person VALUES(1270, 'Matou�', 'Pil�t ','M', '54',  14000, 2, '15/11/2013');
INSERT INTO person VALUES(1271, 'Al�b?ta', 'Jan�?kov�','F', '28',  12000, 2, '24.8.2018');
INSERT INTO person VALUES(1272, 'Hubert', '�varc ','M', '31',  23000, 2, '22/11/2008');
INSERT INTO person VALUES(1273, 'Erika', 'Riedlov�','F', '35',  27000, 2, '12.10.2007');
INSERT INTO person VALUES(1274, 'Hynek', 'Bauer ','M', '60',  28000, 2, '1/10/2004');
INSERT INTO person VALUES(1275, 'Sabina', 'Lev�','F', '21',  35000, 2, '6.8.2004');
INSERT INTO person VALUES(1276, 'Ferdinand', 'Ol�h ','M', '36',  37000, 2, '3/3/2016');
INSERT INTO person VALUES(1277, 'Terezie', 'Jansov�','F', '28',  15000, 2, '17.2.2010');
INSERT INTO person VALUES(1278, 'Otakar', 'Berger ','M', '19',  42000, 2, '11/1/2012');
INSERT INTO person VALUES(1279, 'V?ra', 'Kupcov�','F', '37',  39000, 3, '21.4.2017');
INSERT INTO person VALUES(1280, 'Lud?k', 'Janda ','M', '47',  47000, 3, '14/5/2011');
INSERT INTO person VALUES(1281, 'Svatava', '� astn�','F', '21',  38000, 2, '26.6.2012');
INSERT INTO person VALUES(1282, 'Vladislav', 'Kolman ','M', '24',  21000, 2, '21/4/2019');
INSERT INTO person VALUES(1283, 'Zde?ka', 'Bo?kov�','F', '29',  26000, 3, '29.8.2019');
INSERT INTO person VALUES(1284, 'Ivan', 'Anto� ','M', '52',  26000, 3, '23/8/2018');
INSERT INTO person VALUES(1285, 'Hana', 'Pelik�nov�','F', '61',  34000, 2, '24.6.2016');
INSERT INTO person VALUES(1286, 'Ludv�k', 'Doubrava ','M', '29',  35000, 2, '30/8/2013');
INSERT INTO person VALUES(1287, 'Vlasta', 'Kolmanov�','F', '22',  14000, 3, '12.8.2005');
INSERT INTO person VALUES(1288, 'Zden?k', 'Rozsypal ','M', '58',  40000, 3, '8/7/2009');
INSERT INTO person VALUES(1289, 'Martina', 'Farka�ov�','F', '54',  21000, 2, '31.10.2018');
INSERT INTO person VALUES(1290, 'Richard', 'Ot�hal ','M', '34',  13000, 2, '16/7/2004');
INSERT INTO person VALUES(1291, 'Eli�ka', 'Krej?�kov�','F', '61',  37000, 3, '19.12.2007');
INSERT INTO person VALUES(1292, 'V?roslav', 'Valenta ','M', '63',  18000, 3, '17/10/2016');
INSERT INTO person VALUES(1293, 'Zuzana', 'Schwarzov�','F', '46',  45000, 2, '14.10.2004');
INSERT INTO person VALUES(1294, 'Miloslav', 'Bo?ek ','M', '39',  28000, 2, '25/10/2011');
INSERT INTO person VALUES(1295, 'Zdenka', 'Markov�','F', '54',  25000, 3, '27.4.2010');
INSERT INTO person VALUES(1296, 'Alan', '?onka ','M', '22',  33000, 3, '3/9/2007');
INSERT INTO person VALUES(1297, 'Pavla', 'Vobo?ilov�','F', '39',  32000, 2, '21.2.2007');
INSERT INTO person VALUES(1298, 'Martin', 'Hor?�k ','M', '44',  42000, 2, '3/2/2019');
INSERT INTO person VALUES(1299, 'Ivanka', 'Mare?kov�','F', '48',  20000, 3, '25.4.2014');
INSERT INTO person VALUES(1300, 'Rastislav', '?ervenka ','M', '26',  47000, 3, '7/6/2018');
INSERT INTO person VALUES(1301, 'Ingrid', 'Kubalov�','F', '55',  36000, 4, '6.11.2019');
INSERT INTO person VALUES(1302, 'Ota', 'Hole?ek ','M', '55',  16000, 4, '15/4/2014');
INSERT INTO person VALUES(1303, 'Vlastimila', '�pi?kov�','F', '40',  43000, 3, '31.8.2016');
INSERT INTO person VALUES(1304, 'Erv�n', 'Vyb�ral ','M', '32',  25000, 3, '22/4/2009');
INSERT INTO person VALUES(1305, 'Patricie', 'Zbo?ilov�','F', '48',  23000, 3, '19.10.2005');
INSERT INTO person VALUES(1306, 'Vlastislav', 'Hrbek ','M', '61',  30000, 3, '1/3/2005');
INSERT INTO person VALUES(1307, '�ofie', 'Ha�kov�','F', '33',  31000, 3, '8.1.2019');
INSERT INTO person VALUES(1308, 'Gabriel', 'Kliment ','M', '37',  40000, 3, '1/8/2016');
INSERT INTO person VALUES(1309, 'Na?a', 'Bradov�','F', '40',  47000, 3, '26.2.2008');
INSERT INTO person VALUES(1310, 'Radovan', 'Pracha? ','M', '20',  45000, 3, '10/6/2012');
INSERT INTO person VALUES(1311, 'Patricie', 'K?e?kov�','F', '26',  18000, 3, '22.12.2004');
INSERT INTO person VALUES(1312, 'Drahom�r', 'Richter ','M', '42',  18000, 3, '18/6/2007');
INSERT INTO person VALUES(1313, 'Miriam', 'Bobkov�','F', '33',  34000, 3, '5.7.2010');
INSERT INTO person VALUES(1314, 'Jozef', 'Nov�?ek ','M', '25',  23000, 3, '19/9/2019');
INSERT INTO person VALUES(1315, 'Oksana', 'Mertov�','F', '64',  42000, 2, '1.5.2007');
INSERT INTO person VALUES(1316, 'Alexander 4 000', 'Krej?�k ','M', '47',  32000, 2, '27/9/2014');
INSERT INTO person VALUES(1317, 'Ilona', '�a�kov�','F', '27',  30000, 3, '3.7.2014');
INSERT INTO person VALUES(1318, '�imon', 'Vin� ','M', '29',  37000, 3, '28/1/2014');
INSERT INTO person VALUES(1319, 'Miriam', 'N?me?kov�','F', '57',  29000, 2, '6.9.2009');
INSERT INTO person VALUES(1320, 'B?etislav', 'Vav?�k ','M', '53',  47000, 2, '12/8/2005');
INSERT INTO person VALUES(1321, 'Jind?i�ka', 'Hynkov�','F', '20',  17000, 3, '8.11.2016');
INSERT INTO person VALUES(1322, 'Vit', 'Uhl�? ','M', '35',  16000, 3, '14/12/2004');
INSERT INTO person VALUES(1323, 'Hedvika', 'Ko�kov�','F', '27',  33000, 4, '27.12.2005');
INSERT INTO person VALUES(1324, 'Zd?nek', 'V�t ','M', '64',  21000, 4, '17/3/2017');
INSERT INTO person VALUES(1325, 'Magdalena', 'Motlov�','F', '58',  41000, 3, '18.3.2019');
INSERT INTO person VALUES(1326, 'Rudolf', 'Smola ','M', '40',  30000, 3, '24/3/2012');
INSERT INTO person VALUES(1327, 'Danu�e', '�vestkov�','F', '44',  12000, 2, '12.1.2016');
INSERT INTO person VALUES(1328, 'Dalibor', 'Ne�por ','M', '62',  39000, 2, '2/4/2007');
INSERT INTO person VALUES(1329, 'Hedvika', 'Vojt?chov�','F', '51',  28000, 3, '1.3.2005');
INSERT INTO person VALUES(1330, 'Milan', 'Kuchta ','M', '45',  44000, 3, '4/7/2019');
INSERT INTO person VALUES(1331, 'Magdalena', 'Kvasni?kov�','F', '37',  36000, 2, '20.5.2018');
INSERT INTO person VALUES(1332, 'Lud?k', 'Charv�t ','M', '22',  18000, 2, '11/7/2014');
INSERT INTO person VALUES(1333, 'Zd?nka', 'Menclov�','F', '45',  24000, 3, '26.2.2009');
INSERT INTO person VALUES(1334, 'Jarom�r', 'Hartman ','M', '50',  22000, 3, '12/11/2013');
INSERT INTO person VALUES(1335, 'Marie', 'Langov�','F', '52',  39000, 4, '9.9.2014');
INSERT INTO person VALUES(1336, 'Ctibor', '�im�?ek ','M', '33',  28000, 4, '20/9/2009');
INSERT INTO person VALUES(1337, 'Zora', 'Kubov�','F', '38',  47000, 3, '6.7.2011');
INSERT INTO person VALUES(1338, 'Tom�', 'Tanco� ','M', '55',  37000, 3, '28/9/2004');
INSERT INTO person VALUES(1339, 'Hanna', 'Ne?asov�','F', '23',  19000, 3, '1.5.2008');
INSERT INTO person VALUES(1340, 'Dominik', 'Dole�el ','M', '31',  46000, 3, '29/2/2016');
INSERT INTO person VALUES(1341, 'Iryna', 'Seifertov�','F', '31',  35000, 3, '12.11.2013');
INSERT INTO person VALUES(1342, 'Boleslav', 'Kozel ','M', '60',  15000, 3, '7/1/2012');
INSERT INTO person VALUES(1343, 'Radana', 'Kynclov�','F', '62',  42000, 2, '8.9.2010');
INSERT INTO person VALUES(1344, 'Marek', 'Bou�ka ','M', '36',  24000, 2, '15/1/2007');
INSERT INTO person VALUES(1345, 'Petra', 'V�chov�','F', '23',  22000, 3, '21.3.2016');
INSERT INTO person VALUES(1346, 'Mario', 'Zouhar ','M', '19',  30000, 3, '18/4/2019');
INSERT INTO person VALUES(1347, 'V�clava', '�im�?kov�','F', '32',  46000, 4, '28.12.2006');
INSERT INTO person VALUES(1348, 'Petro', 'Straka ','M', '47',  34000, 4, '19/8/2018');
INSERT INTO person VALUES(1349, 'Ivana', 'Hor�kov�','F', '62',  45000, 3, '28.7.2018');
INSERT INTO person VALUES(1350, 'Kristi�n', 'V�cha ','M', '25',  44000, 3, '4/3/2010');
INSERT INTO person VALUES(1351, 'Linda', 'Melicharov�','F', '25',  33000, 4, '6.5.2009');
INSERT INTO person VALUES(1352, 'Boris', 'Dudek ','M', '53',  13000, 4, '5/7/2009');
INSERT INTO person VALUES(1353, 'Nela', 'Bart�kov�','F', '56',  41000, 3, '2.3.2006');
INSERT INTO person VALUES(1354, 'J?lius', 'Peroutka ','M', '29',  22000, 3, '12/7/2004');
INSERT INTO person VALUES(1355, 'Sylva', 'Kraj�?kov�','F', '63',  21000, 4, '13.9.2011');
INSERT INTO person VALUES(1356, 'Lum�r', 'Hroch ','M', '58',  27000, 4, '14/10/2016');
INSERT INTO person VALUES(1357, 'Linda', '�emli?kov�','F', '49',  28000, 3, '9.7.2008');
INSERT INTO person VALUES(1358, 'Leo', 'Kone?n� ','M', '34',  36000, 3, '22/10/2011');
INSERT INTO person VALUES(1359, 'Maria', 'Zimov�','F', '56',  44000, 4, '20.1.2014');
INSERT INTO person VALUES(1360, 'Maty�', 'Pavl�?ek ','M', '63',  42000, 4, '31/8/2007');
INSERT INTO person VALUES(1361, 'Darina', 'Homolov�','F', '41',  16000, 3, '15.11.2010');
INSERT INTO person VALUES(1362, 'Mikul�', 'Hude?ek ','M', '40',  15000, 3, '31/1/2019');
INSERT INTO person VALUES(1363, 'Karolina', 'Ji?�?kov�','F', '49',  32000, 3, '28.5.2016');
INSERT INTO person VALUES(1364, 'Kamil', 'Klement ','M', '22',  20000, 3, '9/12/2014');
INSERT INTO person VALUES(1365, 'Maria', 'Fejfarov�','F', '34',  39000, 3, '24.3.2013');
INSERT INTO person VALUES(1366, 'Bronislav', 'Mayer ','M', '45',  29000, 3, '17/12/2009');
INSERT INTO person VALUES(1367, 'Valerie', 'Hendrychov�','F', '42',  19000, 3, '5.10.2018');
INSERT INTO person VALUES(1368, 'Milo�', '?eh�?ek ','M', '28',  34000, 3, '25/10/2005');
INSERT INTO person VALUES(1369, 'Renata', 'Holasov�','F', '50',  43000, 4, '14.7.2009');
INSERT INTO person VALUES(1370, 'Luk�', 'Bal� ','M', '56',  39000, 4, '25/2/2005');
INSERT INTO person VALUES(1371, 'Eli�ka', 'Vav?�kov�','F', '35',  15000, 4, '10.5.2006');
INSERT INTO person VALUES(1372, 'Bohuslav', 'Sedl�? ','M', '32',  12000, 4, '29/7/2016');
INSERT INTO person VALUES(1373, 'Milu�e', 'Hus�kov�','F', '43',  31000, 4, '21.11.2011');
INSERT INTO person VALUES(1374, 'Kevin', 'Mi?ka ','M', '61',  18000, 4, '6/6/2012');
INSERT INTO person VALUES(1375, 'Kl�ra', 'Nedv?dov�','F', '28',  38000, 4, '15.9.2008');
INSERT INTO person VALUES(1376, 'Libor', 'Dunka ','M', '37',  27000, 4, '15/6/2007');
INSERT INTO person VALUES(1377, 'Nad?�da', 'Lexov�','F', '35',  18000, 4, '29.3.2014');
INSERT INTO person VALUES(1378, 'Alfred', 'Michna ','M', '20',  32000, 4, '16/9/2019');
INSERT INTO person VALUES(1379, 'Daniela', 'Hrabovsk�','F', '21',  26000, 3, '23.1.2011');
INSERT INTO person VALUES(1380, 'Karel', 'V�?a ','M', '43',  41000, 3, '23/9/2014');
INSERT INTO person VALUES(1381, 'Nina', 'Proke�ov�','F', '29',  13000, 4, '27.3.2018');
INSERT INTO person VALUES(1382, 'V?roslav', 'Pa�ek ','M', '25',  46000, 4, '25/1/2014');
INSERT INTO person VALUES(1383, 'Nad?�da', 'Pelcov�','F', '60',  13000, 3, '1.6.2013');
INSERT INTO person VALUES(1384, 'Maxmili�n', 'P?�hoda ','M', '48',  20000, 3, '9/8/2005');
INSERT INTO person VALUES(1385, 'Em�lia', 'Krej?�?ov�','F', '22',  37000, 4, '10.3.2004');
INSERT INTO person VALUES(1386, 'Zolt�n', 'Pluha? ','M', '30',  24000, 4, '10/12/2004');
INSERT INTO person VALUES(1387, 'M�ria', '?�hov�','F', '52',  37000, 3, '9.10.2015');
INSERT INTO person VALUES(1388, 'Vasil', 'Hl�vka ','M', '53',  34000, 3, '18/11/2012');
INSERT INTO person VALUES(1389, 'Olena', '�afr�nkov�','F', '61',  24000, 4, '18.7.2006');
INSERT INTO person VALUES(1390, 'Radomil', 'Balog ','M', '35',  39000, 4, '21/3/2012');
INSERT INTO person VALUES(1391, 'Tatiana', '�vestkov�','F', '22',  40000, 1, '29.1.2012');
INSERT INTO person VALUES(1392, 'Alexandr', 'Nedv?d ','M', '64',  44000, 1, '29/1/2008');
INSERT INTO person VALUES(1393, 'Radom�ra', 'Moln�rov�','F', '54',  12000, 4, '23.11.2008');
INSERT INTO person VALUES(1394, 'Gustav', '?eho? ','M', '40',  17000, 4, '1/7/2019');
INSERT INTO person VALUES(1395, 'V?ra', 'Kvasni?kov�','F', '61',  28000, 4, '6.6.2014');
INSERT INTO person VALUES(1396, 'Eduard', '?ernohorsk� ','M', '23',  22000, 4, '9/5/2015');
INSERT INTO person VALUES(1397, 'Tatiana', 'Z�me?n�kov�','F', '46',  35000, 4, '2.4.2011');
INSERT INTO person VALUES(1398, 'Juraj', 'Svato? ','M', '46',  32000, 4, '17/5/2010');
INSERT INTO person VALUES(1399, 'Martina', 'Sta?kov�','F', '54',  15000, 4, '13.10.2016');
INSERT INTO person VALUES(1400, 'Dominik', 'Dole�al ','M', '29',  37000, 4, '25/3/2006');
INSERT INTO person VALUES(1401, 'Hana', 'Kol�?ov�','F', '39',  23000, 4, '9.8.2013');
INSERT INTO person VALUES(1402, 'Marian', 'Berka ','M', '51',  46000, 4, '25/8/2017');
INSERT INTO person VALUES(1403, 'Kv?tu�e', 'Ne?asov�','F', '48',  47000, 1, '18.5.2004');
INSERT INTO person VALUES(1404, 'Zbyn?k', 'Hrube� ','M', '33',  15000, 1, '27/12/2016');
INSERT INTO person VALUES(1405, 'Jitka', 'Stoklasov�','F', '32',  46000, 3, '16.12.2015');
INSERT INTO person VALUES(1406, '�tefan', 'Neubauer ','M', '56',  24000, 3, '11/7/2008');
INSERT INTO person VALUES(1407, 'Jolana', 'Kynclov�','F', '40',  34000, 1, '24.9.2006');
INSERT INTO person VALUES(1408, 'Patrik', 'Ber�nek ','M', '38',  29000, 1, '13/11/2007');
INSERT INTO person VALUES(1409, 'Kv?tu�e', 'Nedbalov�','F', '26',  42000, 4, '21.7.2003');
INSERT INTO person VALUES(1410, 'Vil�m', 'Sochor ','M', '61',  38000, 4, '15/4/2019');
INSERT INTO person VALUES(1411, 'Vladislava', 'Wolfov�','F', '33',  22000, 4, '31.1.2009');
INSERT INTO person VALUES(1412, 'Stanislav', 'Vojta ','M', '43',  44000, 4, '21/2/2015');
INSERT INTO person VALUES(1413, 'Leona', 'C�sa?ov�','F', '19',  29000, 4, '27.11.2005');
INSERT INTO person VALUES(1414, '�t?p�n', 'Pape� ','M', '20',  17000, 4, '1/3/2010');
INSERT INTO person VALUES(1415, 'Ivanka', '�ilhav�','F', '26',  45000, 4, '10.6.2011');
INSERT INTO person VALUES(1416, 'Svatoslav', 'Kulhav� ','M', '49',  22000, 4, '7/1/2006');
INSERT INTO person VALUES(1417, 'Vladislava', 'Havrdov�','F', '57',  17000, 4, '4.4.2008');
INSERT INTO person VALUES(1418, 'Vlastimil', 'R?�i?ka ','M', '25',  31000, 4, '9/6/2017');
INSERT INTO person VALUES(1419, 'Jindra', 'P�tkov�','F', '19',  32000, 4, '17.10.2013');
INSERT INTO person VALUES(1420, 'Stepan', 'Sedl�k ','M', '54',  36000, 4, '18/4/2013');
INSERT INTO person VALUES(1421, 'Elena', 'Hrbkov�','F', '50',  40000, 3, '12.8.2010');
INSERT INTO person VALUES(1422, 'Vladim�r', 'Vacul�k ','M', '30',  46000, 3, '25/4/2008');
INSERT INTO person VALUES(1423, 'Ji?ina', 'Kri�tofov�','F', '59',  28000, 1, '14.10.2017');
INSERT INTO person VALUES(1424, 'Nicolas', 'Syrov� ','M', '58',  14000, 1, '27/8/2007');
INSERT INTO person VALUES(1425, '��rka', 'Homolov�','F', '20',  44000, 1, '2.12.2006');
INSERT INTO person VALUES(1426, 'Emanuel', 'Maxa ','M', '41',  19000, 1, '6/7/2003');
INSERT INTO person VALUES(1427, 'Marta', 'Pila?ov�','F', '51',  15000, 4, '28.9.2003');
INSERT INTO person VALUES(1428, 'Oskar', '�r�mek ','M', '64',  29000, 4, '6/12/2014');
INSERT INTO person VALUES(1429, 'Simona', 'Fejfarov�','F', '59',  31000, 1, '10.4.2009');
INSERT INTO person VALUES(1430, '?estm�r', 'Kalina ','M', '47',  34000, 1, '15/10/2010');
INSERT INTO person VALUES(1431, 'Iveta', 'Stiborov�','F', '44',  39000, 4, '4.2.2006');
INSERT INTO person VALUES(1432, '?ubom�r', 'M?ller ','M', '23',  43000, 4, '22/10/2005');
INSERT INTO person VALUES(1433, 'Ilona', 'Zl�malov�','F', '51',  19000, 1, '18.8.2011');
INSERT INTO person VALUES(1434, 'Arno�t', 'Merta ','M', '52',  12000, 1, '23/1/2018');
INSERT INTO person VALUES(1435, 'Radka', 'Dobi�ov�','F', '37',  26000, 4, '12.6.2008');
INSERT INTO person VALUES(1436, 'Ondrej', 'Hrd� ','M', '28',  22000, 4, '31/1/2013');
INSERT INTO person VALUES(1437, 'Katar�na', 'Borovi?kov�','F', '45',  14000, 1, '15.8.2015');
INSERT INTO person VALUES(1438, 'Mykola', '�imon ','M', '56',  26000, 1, '3/6/2012');
INSERT INTO person VALUES(1439, 'Aneta', 'Tomanov�','F', '29',  14000, 4, '20.10.2010');
INSERT INTO person VALUES(1440, 'Pavol', 'Benda ','M', '33',  36000, 4, '18/12/2003');
INSERT INTO person VALUES(1441, 'Zlata', '�im?nkov�','F', '38',  38000, 1, '22.12.2017');
INSERT INTO person VALUES(1442, 'Bohumir', 'Pham ','M', '61',  41000, 1, '13/9/2019');
INSERT INTO person VALUES(1443, 'Danu�e', 'Tepl�','F', '22',  37000, 4, '26.2.2013');
INSERT INTO person VALUES(1444, 'Bohum�r', 'Hladk� ','M', '39',  14000, 4, '28/3/2011');
INSERT INTO person VALUES(1445, 'Aloisie', 'Vil�mkov�','F', '31',  25000, 1, '6.12.2003');
INSERT INTO person VALUES(1446, 'Michael', 'Sv?tl�k ','M', '21',  19000, 1, '30/7/2010');
INSERT INTO person VALUES(1447, 'Zora', 'Pelcov�','F', '38',  41000, 1, '18.6.2009');
INSERT INTO person VALUES(1448, 'Martin', 'Marek ','M', '50',  24000, 1, '7/6/2006');
INSERT INTO person VALUES(1449, 'Zd?nka', 'Wagnerov�','F', '23',  13000, 1, '13.4.2006');
INSERT INTO person VALUES(1450, 'Robert', 'Form�nek ','M', '26',  34000, 1, '7/11/2017');
INSERT INTO person VALUES(1451, 'Aloisie', '�vejdov�','F', '55',  20000, 4, '3.7.2019');
INSERT INTO person VALUES(1452, 'Leo�', 'Kindl ','M', '48',  43000, 4, '15/11/2012');
INSERT INTO person VALUES(1453, 'Radana', 'Musilov�','F', '62',  36000, 4, '20.8.2008');
INSERT INTO person VALUES(1454, 'Anton�n', 'Macha? ','M', '31',  12000, 4, '23/9/2008');
INSERT INTO person VALUES(1455, 'Hanna', 'Sedl�?kov�','F', '48',  44000, 4, '16.6.2005');
INSERT INTO person VALUES(1456, 'Jozef', 'Walter ','M', '54',  21000, 4, '1/10/2003');
INSERT INTO person VALUES(1457, 'Iryna', 'Jake�ov�','F', '55',  24000, 4, '28.12.2010');
INSERT INTO person VALUES(1458, 'Petr', 'Kr�l�?ek ','M', '36',  26000, 4, '3/1/2016');
INSERT INTO person VALUES(1459, 'Antonie', 'Kopalov�','F', '63',  47000, 1, '1.3.2018');
INSERT INTO person VALUES(1460, 'Herbert', 'Vondra ','M', '64',  31000, 1, '6/5/2015');
INSERT INTO person VALUES(1461, 'Petra', 'Pol�kov�','F', '48',  47000, 4, '6.5.2013');
INSERT INTO person VALUES(1462, 'Vladimir', 'Ve?e?a ','M', '42',  41000, 4, '19/11/2006');
INSERT INTO person VALUES(1463, 'Nela', 'Gabrielov�','F', '56',  35000, 1, '12.2.2004');
INSERT INTO person VALUES(1464, 'Juli�s', 'Kon�?ek ','M', '24',  45000, 1, '22/3/2006');
INSERT INTO person VALUES(1465, 'Julie', 'Ludv�kov�','F', '42',  43000, 1, '3.5.2017');
INSERT INTO person VALUES(1466, 'Zd?nek', 'Ku?era ','M', '46',  19000, 1, '22/8/2017');
INSERT INTO person VALUES(1467, 'Linda', 'Proch�zkov�','F', '49',  22000, 1, '21.6.2006');
INSERT INTO person VALUES(1468, 'Viliam', 'V�tek ','M', '29',  24000, 1, '1/7/2013');
INSERT INTO person VALUES(1469, 'Nela', 'Buben�kov�','F', '34',  30000, 4, '10.9.2019');
INSERT INTO person VALUES(1470, 'Bruno', 'Kola?�k ','M', '51',  33000, 4, '8/7/2008');
INSERT INTO person VALUES(1471, 'Darina', 'Fenclov�','F', '42',  46000, 1, '28.10.2008');
INSERT INTO person VALUES(1472, 'Matou�', 'Koubek ','M', '34',  38000, 1, '16/5/2004');
INSERT INTO person VALUES(1473, 'Terezie', 'Kloudov�','F', '27',  17000, 4, '24.8.2005');
INSERT INTO person VALUES(1474, 'Hubert', 'Michalec ','M', '57',  12000, 4, '18/10/2015');
INSERT INTO person VALUES(1475, 'Maria', 'Vrbov�','F', '34',  33000, 1, '7.3.2011');
INSERT INTO person VALUES(1476, 'Hynek', 'Pivo?ka ','M', '40',  17000, 1, '26/8/2011');
INSERT INTO person VALUES(1477, 'Darina', 'Pechov�','F', '20',  41000, 4, '31.12.2007');
INSERT INTO person VALUES(1478, 'Ferdinand', 'Ka?�rek ','M', '62',  26000, 4, '3/9/2006');
INSERT INTO person VALUES(1479, 'Jarom�ra', '�andov�','F', '27',  21000, 4, '13.7.2013');
INSERT INTO person VALUES(1480, 'Otakar', '�ev?�k ','M', '45',  31000, 4, '5/12/2018');
INSERT INTO person VALUES(1481, 'R?�ena', 'Havrdov�','F', '36',  45000, 2, '21.4.2004');
INSERT INTO person VALUES(1482, 'Lud?k', 'Zl�mal ','M', '27',  36000, 2, '7/4/2018');
INSERT INTO person VALUES(1483, 'Valerie', 'K?�kov�','F', '20',  44000, 4, '20.11.2015');
INSERT INTO person VALUES(1484, 'Vladislav', 'Homolka ','M', '50',  46000, 4, '21/10/2009');
INSERT INTO person VALUES(1485, 'Kl�ra', 'Hrbkov�','F', '28',  32000, 1, '29.8.2006');
INSERT INTO person VALUES(1486, 'Ivan', 'Mou?ka ','M', '32',  14000, 1, '21/2/2009');
INSERT INTO person VALUES(1487, 'Eli�ka', 'Pa�kov�','F', '60',  40000, 1, '25.6.2003');
INSERT INTO person VALUES(1488, 'Ludv�k', 'Hlav�?ek ','M', '54',  24000, 1, '29/2/2004');
INSERT INTO person VALUES(1489, 'Vlasta', '�v�bov�','F', '45',  47000, 4, '12.9.2016');
INSERT INTO person VALUES(1490, 'Mojm�r', 'Hus�k ','M', '31',  33000, 4, '2/8/2015');
INSERT INTO person VALUES(1491, 'Zdenka', 'Fi�erov�','F', '52',  27000, 1, '31.10.2005');
INSERT INTO person VALUES(1492, 'Richard', 'Mar��lek ','M', '60',  38000, 1, '10/6/2011');
INSERT INTO person VALUES(1493, 'Karin', 'Zem�nkov�','F', '61',  15000, 2, '2.1.2013');
INSERT INTO person VALUES(1494, 'Daniel', 'Mac�k ','M', '42',  43000, 2, '11/10/2010');
INSERT INTO person VALUES(1495, 'Daniela', '�lechtov�','F', '45',  15000, 4, '9.3.2008');
INSERT INTO person VALUES(1496, 'Miloslav', 'Hejna ','M', '19',  16000, 4, '19/9/2018');
INSERT INTO person VALUES(1497, 'Ingrid', 'Dittrichov�','F', '54',  38000, 2, '12.5.2015');
INSERT INTO person VALUES(1498, 'Pavel', 'Mare?ek ','M', '47',  21000, 2, '20/1/2018');
INSERT INTO person VALUES(1499, 'Ane�ka', 'Peterkov�','F', '38',  38000, 4, '17.7.2010');
INSERT INTO person VALUES(1500, 'Martin', 'Jedli?ka ','M', '24',  31000, 4, '5/8/2009');
INSERT INTO person VALUES(1501, 'Em�lia', 'Studen�','F', '46',  26000, 1, '18.9.2017');
INSERT INTO person VALUES(1502, 'Rastislav', 'Petr? ','M', '52',  36000, 1, '6/12/2008');
INSERT INTO person VALUES(1503, 'Ingrid', 'Dubsk�','F', '32',  34000, 1, '15.7.2014');
INSERT INTO person VALUES(1504, 'Roman', 'Moln�r ','M', '29',  45000, 1, '14/12/2003');
INSERT INTO person VALUES(1505, 'Na?a', 'Tich�','F', '39',  13000, 1, '2.9.2003');
INSERT INTO person VALUES(1506, 'Erv�n', 'Stupka ','M', '57',  14000, 1, '17/3/2016');
INSERT INTO person VALUES(1507, 'Patricie', 'Vl?kov�','F', '25',  21000, 1, '20.11.2016');
INSERT INTO person VALUES(1508, 'Ji?�', 'Sobotka ','M', '34',  23000, 1, '25/3/2011');
INSERT INTO person VALUES(1509, 'Radom�ra', 'Rudolfov�','F', '32',  37000, 1, '8.1.2006');
INSERT INTO person VALUES(1510, 'Gabriel', 'Jir�sek ','M', '63',  28000, 1, '31/1/2007');
INSERT INTO person VALUES(1511, 'Na?a', 'Smolov�','F', '63',  45000, 4, '30.3.2019');
INSERT INTO person VALUES(1512, 'Vojtech', '�tefan ','M', '39',  38000, 4, '4/7/2018');
INSERT INTO person VALUES(1513, 'Natalie', 'Noskov�','F', '25',  24000, 1, '17.5.2008');
INSERT INTO person VALUES(1514, 'Drahom�r', 'Schejbal ','M', '22',  43000, 1, '12/5/2014');
INSERT INTO person VALUES(1515, 'Dominika', '�vejdov�','F', '33',  12000, 2, '20.7.2015');
INSERT INTO person VALUES(1516, 'Bronislav', 'Pavl�k ','M', '50',  47000, 2, '13/9/2013');
INSERT INTO person VALUES(1517, 'Jind?i�ka', 'Kou?ilov�','F', '19',  20000, 1, '15.5.2012');
INSERT INTO person VALUES(1518, 'Nikolas', 'Buchta ','M', '26',  21000, 1, '20/9/2008');
INSERT INTO person VALUES(1519, 'Kv?tu�e', 'Sedl�?kov�','F', '26',  36000, 2, '26.11.2017');
INSERT INTO person VALUES(1520, '�imon', 'Hynek ','M', '55',  26000, 2, '29/7/2004');
INSERT INTO person VALUES(1521, 'Dominika', 'Novotn�','F', '57',  43000, 1, '21.9.2014');
INSERT INTO person VALUES(1522, 'Tibor', 'Ma?�k ','M', '32',  35000, 1, '31/12/2015');
INSERT INTO person VALUES(1523, 'Leona', 'Holcov�','F', '19',  23000, 2, '9.11.2003');
INSERT INTO person VALUES(1524, 'Vit', 'Pernica ','M', '61',  40000, 2, '8/11/2011');
INSERT INTO person VALUES(1525, 'Hedvika', 'Sk?iv�nkov�','F', '50',  31000, 1, '28.1.2017');
INSERT INTO person VALUES(1526, 'Denis', 'Sobek ','M', '37',  14000, 1, '15/11/2006');
INSERT INTO person VALUES(1527, 'Vladislava', 'Linhartov�','F', '57',  47000, 1, '18.3.2006');
INSERT INTO person VALUES(1528, 'Rudolf', '� astn� ','M', '20',  19000, 1, '17/2/2019');
INSERT INTO person VALUES(1529, 'Leona', '?ervenkov�','F', '43',  18000, 1, '7.6.2019');
INSERT INTO person VALUES(1530, 'Dalibor', 'Jon� ','M', '42',  28000, 1, '24/2/2014');
INSERT INTO person VALUES(1531, 'Elena', 'Kalouskov�','F', '50',  34000, 1, '25.7.2008');
INSERT INTO person VALUES(1532, 'Michal', '�est�k ','M', '25',  33000, 1, '3/1/2010');
INSERT INTO person VALUES(1533, 'Zora', 'Schneiderov�','F', '37',  14000, 1, '9.1.2007');
INSERT INTO person VALUES(1534, 'Alexandr', 'Bl�ha ','M', '46',  42000, 1, '5/7/2008');
INSERT INTO person VALUES(1535, 'Jaroslava', 'N�vltov�','F', '44',  30000, 2, '22.7.2012');
INSERT INTO person VALUES(1536, 'Jarom�r', 'Kova?�k ','M', '29',  47000, 2, '13/5/2004');
INSERT INTO person VALUES(1537, 'Iryna', 'Kavanov�','F', '29',  37000, 1, '18.5.2009');
INSERT INTO person VALUES(1538, 'Eduard', 'Homolka ','M', '52',  20000, 1, '14/10/2015');
INSERT INTO person VALUES(1539, 'Ji?ina', '�i�kov�','F', '37',  17000, 2, '29.11.2014');
INSERT INTO person VALUES(1540, 'Tom�', 'Posp�chal ','M', '35',  26000, 2, '23/8/2011');
INSERT INTO person VALUES(1541, 'Lucie', 'Gajdo�ov�','F', '22',  25000, 1, '25.9.2011');
INSERT INTO person VALUES(1542, 'Dominik', 'Le ','M', '57',  35000, 1, '30/8/2006');
INSERT INTO person VALUES(1543, 'Marta', 'Havlov�','F', '29',  40000, 1, '7.4.2017');
INSERT INTO person VALUES(1544, 'Boleslav', 'Kubi� ','M', '40',  40000, 1, '2/12/2018');
INSERT INTO person VALUES(1545, 'Ivana', 'M�llerov�','F', '61',  12000, 1, '1.2.2014');
INSERT INTO person VALUES(1546, 'Marek', 'Holub ','M', '62',  13000, 1, '9/12/2013');
INSERT INTO person VALUES(1547, 'Magda', 'Hude?kov�','F', '23',  36000, 2, '10.11.2004');
INSERT INTO person VALUES(1548, 'Josef', 'Balcar ','M', '44',  18000, 2, '11/4/2013');
INSERT INTO person VALUES(1549, 'Sv?tlana', 'Cinov�','F', '31',  16000, 2, '24.5.2010');
INSERT INTO person VALUES(1550, 'Petro', 'Jan�?ek ','M', '27',  23000, 2, '18/2/2009');
INSERT INTO person VALUES(1551, 'Sylva', 'Grygarov�','F', '62',  23000, 2, '19.3.2007');
INSERT INTO person VALUES(1552, 'Vladimir', 'R�c ','M', '50',  32000, 2, '26/2/2004');
INSERT INTO person VALUES(1553, 'Katar�na', '�v�bov�','F', '23',  39000, 2, '29.9.2012');
INSERT INTO person VALUES(1554, 'Boris', 'Kolman ','M', '32',  37000, 2, '30/5/2016');
INSERT INTO person VALUES(1555, 'Sv?tlana', 'Bedna?�kov�','F', '55',  47000, 2, '26.7.2009');
INSERT INTO person VALUES(1556, 'J?lius', '?apek ','M', '55',  47000, 2, '7/6/2011');
INSERT INTO person VALUES(1557, 'D�a', 'Hrub�','F', '62',  27000, 2, '6.2.2015');
INSERT INTO person VALUES(1558, 'Lum�r', 'Chalupa ','M', '38',  16000, 2, '15/4/2007');
INSERT INTO person VALUES(1559, 'Karolina', 'Valentov�','F', '48',  34000, 1, '3.12.2011');
INSERT INTO person VALUES(1560, 'Leo', 'Ha�ek ','M', '60',  25000, 1, '16/9/2018');
INSERT INTO person VALUES(1561, 'Olga', 'Malinov�','F', '56',  22000, 3, '4.2.2019');
INSERT INTO person VALUES(1562, 'Slavom�r', 'H?lka ','M', '42',  30000, 3, '17/1/2018');
INSERT INTO person VALUES(1563, 'D�a', '?adov�','F', '40',  22000, 1, '10.4.2014');
INSERT INTO person VALUES(1564, 'Mikul�', 'Pavl? ','M', '19',  40000, 1, '1/8/2009');
INSERT INTO person VALUES(1565, 'Renata', 'Moudr�','F', '49',  46000, 2, '17.1.2005');
INSERT INTO person VALUES(1566, 'Hynek', 'Popelka ','M', '47',  44000, 2, '3/12/2008');
INSERT INTO person VALUES(1567, 'R?�ena', 'Lavi?kov�','F', '34',  17000, 2, '8.4.2018');
INSERT INTO person VALUES(1568, 'Emanuel', 'Schejbal ','M', '24',  17000, 2, '11/12/2003');
INSERT INTO person VALUES(1569, 'Milu�e', 'Mu��kov�','F', '42',  33000, 2, '27.5.2007');
INSERT INTO person VALUES(1570, 'Otakar', 'Hor?�k ','M', '53',  23000, 2, '13/3/2016');
INSERT INTO person VALUES(1571, 'Kl�ra', 'Vale�ov�','F', '27',  41000, 2, '22.3.2004');
INSERT INTO person VALUES(1572, '?estm�r', 'H�na ','M', '29',  32000, 2, '22/3/2011');
INSERT INTO person VALUES(1573, 'So?a', 'R?�i?kov�','F', '34',  21000, 2, '3.10.2009');
INSERT INTO person VALUES(1574, 'Bohuslav', 'Kala� ','M', '58',  37000, 2, '28/1/2007');
INSERT INTO person VALUES(1575, 'Milu�e', 'J�chov�','F', '20',  28000, 1, '30.7.2006');
INSERT INTO person VALUES(1576, 'Arno�t', 'V�clav�k ','M', '34',  46000, 1, '30/6/2018');
INSERT INTO person VALUES(1577, 'Al�b?ta', 'Schejbalov�','F', '27',  44000, 2, '10.2.2012');
INSERT INTO person VALUES(1578, 'Libor', 'Ko� �l ','M', '63',  16000, 2, '9/5/2014');
INSERT INTO person VALUES(1579, 'Nad?�da', 'Peckov�','F', '59',  16000, 1, '5.12.2008');
INSERT INTO person VALUES(1580, 'Marcel', 'Nagy ','M', '39',  25000, 1, '16/5/2009');
INSERT INTO person VALUES(1581, 'Danu�ka', 'Frydrychov�','F', '21',  40000, 2, '7.2.2016');
INSERT INTO person VALUES(1582, 'Ivo', '� astn� ','M', '21',  29000, 2, '16/9/2008');
INSERT INTO person VALUES(1583, 'Ingrid', 'Rousov�','F', '52',  47000, 2, '3.12.2012');
INSERT INTO person VALUES(1584, 'Bohumir', 'Jon� ','M', '44',  39000, 2, '25/9/2003');
INSERT INTO person VALUES(1585, 'Olena', 'Vojtov�','F', '60',  27000, 2, '16.6.2018');
INSERT INTO person VALUES(1586, 'Miloslav', '�est�k ','M', '27',  44000, 2, '27/12/2015');
INSERT INTO person VALUES(1587, 'Em�lia', 'Kleinov�','F', '45',  35000, 2, '12.4.2015');
INSERT INTO person VALUES(1588, 'Michael', 'Klouda ','M', '49',  17000, 2, '4/1/2011');
INSERT INTO person VALUES(1589, 'Zlatu�e', 'Dani�ov�','F', '53',  15000, 2, '30.5.2004');
INSERT INTO person VALUES(1590, 'Martin', 'Mat?j�?ek ','M', '32',  22000, 2, '12/11/2006');
INSERT INTO person VALUES(1591, 'Na?a', 'Sv?tl�kov�','F', '38',  22000, 1, '18.8.2017');
INSERT INTO person VALUES(1592, 'Robert', 'Br�zdil ','M', '54',  31000, 1, '14/4/2018');
INSERT INTO person VALUES(1593, 'Tatiana', 'Z�tkov�','F', '45',  38000, 2, '6.10.2006');
INSERT INTO person VALUES(1594, 'Artur', 'Vl?ek ','M', '37',  37000, 2, '21/2/2014');
INSERT INTO person VALUES(1595, 'Bla�ena', 'Tome�ov�','F', '54',  26000, 3, '8.12.2013');
INSERT INTO person VALUES(1596, 'Gerhard', 'Vondr�k ','M', '19',  41000, 3, '24/6/2013');
INSERT INTO person VALUES(1597, 'Hana', 'Kub�?kov�','F', '38',  25000, 2, '12.2.2009');
INSERT INTO person VALUES(1598, 'Walter', 'Plach� ','M', '43',  15000, 2, '7/1/2005');
INSERT INTO person VALUES(1599, 'Alexandra', 'Sokolov�','F', '46',  13000, 3, '16.4.2016');
INSERT INTO person VALUES(1600, 'Cyril', 'Ne�por ','M', '25',  20000, 3, '10/5/2004');
INSERT INTO person VALUES(1601, 'Bla�ena', 'K?enkov�','F', '32',  21000, 2, '10.2.2013');
INSERT INTO person VALUES(1602, 'Herbert', '�ulc ','M', '47',  29000, 2, '11/10/2015');
INSERT INTO person VALUES(1603, 'Jolana', 'Svato?ov�','F', '39',  37000, 3, '24.8.2018');
INSERT INTO person VALUES(1604, 'Drahom�r', 'David ','M', '30',  34000, 3, '20/8/2011');
INSERT INTO person VALUES(1605, 'Kv?tu�e', 'Kub�nkov�','F', '25',  44000, 2, '19.6.2015');
INSERT INTO person VALUES(1606, 'Juli�s', 'Z�ruba ','M', '52',  43000, 2, '27/8/2006');
INSERT INTO person VALUES(1607, 'Ta �na', 'Z�kov�','F', '32',  24000, 2, '6.8.2004');
INSERT INTO person VALUES(1608, 'Tade�', 'Kaplan ','M', '35',  13000, 2, '28/11/2018');
INSERT INTO person VALUES(1609, 'Jolana', '�afa?�kov�','F', '63',  32000, 2, '26.10.2017');
INSERT INTO person VALUES(1610, 'Viliam', 'Kaiser ','M', '57',  22000, 2, '6/12/2013');
INSERT INTO person VALUES(1611, 'Ivanka', 'Jandov�','F', '25',  12000, 2, '14.12.2006');
INSERT INTO person VALUES(1612, 'Vil�m', 'Fousek ','M', '40',  27000, 2, '14/10/2009');
INSERT INTO person VALUES(1613, 'Vladislava', 'Soukupov�','F', '56',  19000, 2, '10.10.2003');
INSERT INTO person VALUES(1614, 'Matou�', 'Hor�?ek ','M', '63',  36000, 2, '21/10/2004');
INSERT INTO person VALUES(1615, 'Vlastimila', 'Ors�gov�','F', '63',  35000, 2, '22.4.2009');
INSERT INTO person VALUES(1616, '�t?p�n', 'B?ezina ','M', '46',  42000, 2, '23/1/2017');
INSERT INTO person VALUES(1617, 'Irena', 'Krupov�','F', '26',  23000, 3, '24.6.2016');
INSERT INTO person VALUES(1618, 'Rudolf', 'Kope?ek ','M', '28',  46000, 3, '26/5/2016');
INSERT INTO person VALUES(1619, 'Monika', '�?rkov�','F', '57',  31000, 3, '19.4.2013');
INSERT INTO person VALUES(1620, 'Radom�r', 'Kamen�k ','M', '50',  19000, 3, '4/6/2011');
INSERT INTO person VALUES(1621, 'Pavl�na', 'Cibulkov�','F', '19',  46000, 3, '31.10.2018');
INSERT INTO person VALUES(1622, 'Michal', 'V�cha ','M', '33',  25000, 3, '12/4/2007');
INSERT INTO person VALUES(1623, 'Marta', 'Zachov�','F', '50',  18000, 2, '27.8.2015');
INSERT INTO person VALUES(1624, 'Lud?k', 'Ondr�?ek ','M', '55',  34000, 2, '12/9/2018');
INSERT INTO person VALUES(1625, 'Ji?ina', 'Mar��lkov�','F', '36',  26000, 2, '22.6.2012');
INSERT INTO person VALUES(1626, 'Kry�tof', 'Fridrich ','M', '32',  43000, 2, '20/9/2013');
INSERT INTO person VALUES(1627, '��rka', 'Kr�lov�','F', '43',  42000, 2, '3.1.2018');
INSERT INTO person VALUES(1628, 'Ivan', 'Michal ','M', '60',  12000, 2, '29/7/2009');
INSERT INTO person VALUES(1629, 'Diana', 'Dobe�ov�','F', '51',  29000, 3, '12.10.2008');
INSERT INTO person VALUES(1630, 'Franti�ek', 'Kone?n� ','M', '42',  17000, 3, '29/11/2008');
INSERT INTO person VALUES(1631, 'Viktorie', 'Form�nkov�','F', '37',  37000, 3, '8.8.2005');
INSERT INTO person VALUES(1632, 'Radim', 'Ko� �l ','M', '19',  26000, 3, '8/12/2003');
INSERT INTO person VALUES(1633, 'Vanda', 'Ne�porov�','F', '44',  17000, 3, '19.2.2011');
INSERT INTO person VALUES(1634, 'Ruslan', '�mejkal ','M', '48',  31000, 3, '10/3/2016');
INSERT INTO person VALUES(1635, 'Diana', 'Jir�nkov�','F', '30',  25000, 3, '15.12.2007');
INSERT INTO person VALUES(1636, 'Daniel', 'Vo?�ek ','M', '24',  40000, 3, '18/3/2011');
INSERT INTO person VALUES(1637, 'Zlata', '�ime?kov�','F', '37',  40000, 3, '27.6.2013');
INSERT INTO person VALUES(1638, 'Mario', 'Mayer ','M', '53',  46000, 3, '25/1/2007');
INSERT INTO person VALUES(1639, 'Katar�na', 'Matulov�','F', '22',  12000, 2, '23.4.2010');
INSERT INTO person VALUES(1640, 'Pavel', 'Paul ','M', '29',  19000, 2, '27/6/2018');
INSERT INTO person VALUES(1641, 'Barbara', 'Luk�kov�','F', '30',  28000, 3, '4.11.2015');
INSERT INTO person VALUES(1642, 'Lubor', 'Navr�til ','M', '58',  24000, 3, '6/5/2014');
INSERT INTO person VALUES(1643, 'Marcela', 'Rakov�','F', '62',  44000, 3, '21.4.2014');
INSERT INTO person VALUES(1644, 'Stanislav', 'Mat?j�?ek ','M', '34',  33000, 3, '5/11/2012');
INSERT INTO person VALUES(1645, 'Nikola', 'Bauerov�','F', '24',  23000, 3, '2.11.2019');
INSERT INTO person VALUES(1646, 'Oliver', 'Vav?�k ','M', '63',  38000, 3, '13/9/2008');
INSERT INTO person VALUES(1647, 'Olga', 'Barto?ov�','F', '55',  31000, 3, '27.8.2016');
INSERT INTO person VALUES(1648, 'Po?et', 'Vl?ek ','M', '39',  47000, 3, '21/9/2003');
INSERT INTO person VALUES(1649, 'Denisa', 'Karbanov�','F', '62',  47000, 3, '15.10.2005');
INSERT INTO person VALUES(1650, '?en?k', 'Kub�?ek ','M', '22',  16000, 3, '24/12/2015');
INSERT INTO person VALUES(1651, 'Renata', 'R?�kov�','F', '48',  18000, 3, '4.1.2019');
INSERT INTO person VALUES(1652, 'Gejza', 'Plach� ','M', '44',  26000, 3, '31/12/2010');
INSERT INTO person VALUES(1653, 'Vladim�ra', 'Bare�ov�','F', '55',  34000, 3, '22.2.2008');
INSERT INTO person VALUES(1654, 'Samuel', 'Zbo?il ','M', '27',  31000, 3, '9/11/2006');
INSERT INTO person VALUES(1655, 'Denisa', 'Pr?�ov�','F', '40',  42000, 2, '18.12.2004');
INSERT INTO person VALUES(1656, 'Oleg', 'Holoubek ','M', '49',  40000, 2, '11/4/2018');
INSERT INTO person VALUES(1657, 'Vendula', 'Jelenov�','F', '48',  22000, 3, '1.7.2010');
INSERT INTO person VALUES(1658, 'Bronislav', '�im�nek ','M', '32',  45000, 3, '18/2/2014');
INSERT INTO person VALUES(1659, 'So?a', 'Riedlov�','F', '33',  29000, 2, '27.4.2007');
INSERT INTO person VALUES(1660, 'Nikolas', 'Dole�al ','M', '55',  19000, 2, '25/2/2009');
INSERT INTO person VALUES(1661, 'Danu�ka', 'Kroupov�','F', '42',  17000, 3, '28.6.2014');
INSERT INTO person VALUES(1662, 'Andrej', 'Kaplan ','M', '37',  23000, 3, '28/6/2008');
INSERT INTO person VALUES(1663, 'Yveta', 'Vydrov�','F', '49',  33000, 4, '16.8.2003');
INSERT INTO person VALUES(1664, 'Alois', 'Kope?n� ','M', '20',  28000, 4, '7/5/2004');
INSERT INTO person VALUES(1665, 'Bed?i�ka', '?eh�?kov�','F', '34',  41000, 3, '4.11.2016');
INSERT INTO person VALUES(1666, 'Svatopluk', 'Fousek ','M', '42',  38000, 3, '8/10/2015');
INSERT INTO person VALUES(1667, 'Be�ta', 'Pek�rkov�','F', '42',  21000, 4, '23.12.2005');
INSERT INTO person VALUES(1668, 'Old?ich', 'Dole?ek ','M', '25',  43000, 4, '16/8/2011');
INSERT INTO person VALUES(1669, 'Zlatu�e', 'Bo?kov�','F', '27',  28000, 3, '14.3.2019');
INSERT INTO person VALUES(1670, 'Peter', 'B?ezina ','M', '47',  16000, 3, '24/8/2006');
INSERT INTO person VALUES(1671, 'Olena', 'Pelik�nov�','F', '59',  36000, 2, '8.1.2016');
INSERT INTO person VALUES(1672, 'Mari�n', 'Janovsk� ','M', '24',  25000, 2, '24/1/2018');
INSERT INTO person VALUES(1673, 'Tati�na', 'Kolmanov�','F', '20',  16000, 3, '25.2.2005');
INSERT INTO person VALUES(1674, 'Du�an', 'Zach ','M', '53',  30000, 3, '2/12/2013');
INSERT INTO person VALUES(1675, '�aneta', 'B?ezinov�','F', '28',  39000, 4, '29.4.2012');
INSERT INTO person VALUES(1676, 'Vojt?ch', 'V�cha ','M', '35',  35000, 4, '5/4/2013');
INSERT INTO person VALUES(1677, 'V?ra', 'Krej?�kov�','F', '59',  39000, 3, '4.7.2007');
INSERT INTO person VALUES(1678, 'Jarom�r', '�emli?ka ','M', '58',  45000, 3, '18/10/2004');
INSERT INTO person VALUES(1679, 'Silvie 7300', 'Fuchsov�','F', '21',  27000, 4, '5.9.2014');
INSERT INTO person VALUES(1680, 'Miroslav', 'Hampl ','M', '40',  14000, 4, '19/2/2004');
INSERT INTO person VALUES(1681, 'Zde?ka', 'Pokorn�','F', '51',  27000, 2, '10.11.2009');
INSERT INTO person VALUES(1682, 'Tom�', 'Linhart ','M', '63',  23000, 2, '28/1/2012');
INSERT INTO person VALUES(1683, 'Margita', 'Koci�nov�','F', '60',  14000, 4, '12.1.2017');
INSERT INTO person VALUES(1684, 'Zby�ek', 'Hrabal ','M', '45',  28000, 4, '31/5/2011');
INSERT INTO person VALUES(1685, 'Alexandra', 'Smejkalov�','F', '45',  22000, 3, '8.11.2013');
INSERT INTO person VALUES(1686, 'Radek', 'Vymazal ','M', '21',  37000, 3, '7/6/2006');
INSERT INTO person VALUES(1687, 'Sandra', 'Smr�ov�','F', '53',  38000, 3, '22.5.2019');
INSERT INTO person VALUES(1688, 'Tobi�', '�ilhav� ','M', '50',  42000, 3, '9/9/2018');
INSERT INTO person VALUES(1689, 'Margita', '�pi?kov�','F', '38',  45000, 3, '16.3.2016');
INSERT INTO person VALUES(1690, 'Josef', 'Kalina ','M', '27',  16000, 3, '16/9/2013');
INSERT INTO person VALUES(1691, 'Old?i�ka', 'Chovancov�','F', '45',  25000, 3, '4.5.2005');
INSERT INTO person VALUES(1692, 'Petro', 'Luk� ','M', '56',  21000, 3, '26/7/2009');
INSERT INTO person VALUES(1693, 'Ta �na', 'Ha�kov�','F', '31',  33000, 3, '24.7.2018');
INSERT INTO person VALUES(1694, 'Vladimir', '?ernoch ','M', '32',  30000, 3, '2/8/2004');
INSERT INTO person VALUES(1695, 'Karin', 'Bradov�','F', '38',  13000, 3, '11.9.2007');
INSERT INTO person VALUES(1696, 'Boris', 'T?�ska ','M', '61',  35000, 3, '4/11/2016');
INSERT INTO person VALUES(1697, 'Miroslava', '?ejkov�','F', '47',  37000, 4, '13.11.2014');
INSERT INTO person VALUES(1698, 'Robin', 'Slav�k ','M', '43',  40000, 4, '7/3/2016');
INSERT INTO person VALUES(1699, 'Tereza', 'V�clav�kov�','F', '32',  44000, 4, '9.9.2011');
INSERT INTO person VALUES(1700, 'Vili�m', 'Vysko?il ','M', '19',  13000, 4, '15/3/2011');
INSERT INTO person VALUES(1701, 'Pavl�na', 'Kubelkov�','F', '39',  24000, 4, '22.3.2017');
INSERT INTO person VALUES(1702, 'Vratislav', 'Zima ','M', '48',  18000, 4, '22/1/2007');
INSERT INTO person VALUES(1703, 'Irena', '�a�kov�','F', '25',  32000, 3, '16.1.2014');
INSERT INTO person VALUES(1704, 'Slavom�r', 'Hrb�?ek ','M', '24',  28000, 3, '24/6/2018');
INSERT INTO person VALUES(1705, 'Milena', 'Prchalov�','F', '32',  12000, 4, '30.7.2019');
INSERT INTO person VALUES(1706, '�t?p�n', 'P�a ','M', '53',  33000, 4, '2/5/2014');
INSERT INTO person VALUES(1707, 'Pavl�na', 'Hynkov�','F', '63',  19000, 3, '24.5.2016');
INSERT INTO person VALUES(1708, 'Erik', 'Pokorn� ','M', '30',  42000, 3, '10/5/2009');
INSERT INTO person VALUES(1709, 'Stanislava', 'Ko�kov�','F', '25',  35000, 4, '12.7.2005');
INSERT INTO person VALUES(1710, 'Jind?ich', 'Toman ','M', '59',  47000, 4, '18/3/2005');
INSERT INTO person VALUES(1711, 'Simona', 'Pluha?ov�','F', '56',  43000, 3, '1.10.2018');
INSERT INTO person VALUES(1712, 'Otakar', '�afr�nek ','M', '35',  20000, 3, '18/8/2016');
INSERT INTO person VALUES(1713, 'Nat�lie', 'Jahodov�','F', '63',  22000, 3, '19.11.2007');
INSERT INTO person VALUES(1714, 'Luk�', 'Van??ek ','M', '64',  26000, 3, '27/6/2012');
INSERT INTO person VALUES(1715, 'Stanislava', 'Vojt?chov�','F', '49',  30000, 3, '14.9.2004');
INSERT INTO person VALUES(1716, 'Bohuslav', 'Jirou�ek ','M', '40',  35000, 3, '5/7/2007');
INSERT INTO person VALUES(1717, 'Lydie', 'Krop�?kov�','F', '57',  18000, 4, '17.11.2011');
INSERT INTO person VALUES(1718, 'Ale�', 'Adamec ','M', '22',  40000, 4, '5/11/2006');
INSERT INTO person VALUES(1719, 'Bohdana', 'Pr?�ov�','F', '19',  34000, 4, '30.5.2017');
INSERT INTO person VALUES(1720, 'Oskar', 'Star� ','M', '51',  45000, 4, '7/2/2019');
INSERT INTO person VALUES(1721, 'Marika', 'Jan�?kov�','F', '50',  41000, 4, '25.3.2014');
INSERT INTO person VALUES(1722, 'V�clav', 'Blecha ','M', '28',  18000, 4, '14/2/2014');
INSERT INTO person VALUES(1723, 'Zlata', 'Kubov�','F', '36',  13000, 3, '19.1.2011');
INSERT INTO person VALUES(1724, 'Ivo', 'Vyslou�il ','M', '50',  27000, 3, '22/2/2009');
INSERT INTO person VALUES(1725, 'Vilma', 'Lev�','F', '43',  29000, 4, '1.8.2016');
INSERT INTO person VALUES(1726, 'V?roslav', 'Vydra ','M', '33',  32000, 4, '31/12/2004');
INSERT INTO person VALUES(1727, 'Barbara', 'Seifertov�','F', '28',  37000, 3, '28.5.2013');
INSERT INTO person VALUES(1728, 'Vojt?ch', 'Vacek ','M', '55',  42000, 3, '2/6/2016');
INSERT INTO person VALUES(1729, 'Zora', 'Bro�kov�','F', '36',  16000, 3, '9.12.2018');
INSERT INTO person VALUES(1730, 'Zolt�n', 'P?ibyl ','M', '38',  47000, 3, '11/4/2012');
INSERT INTO person VALUES(1731, 'Bohumila', 'Holoubkov�','F', '44',  40000, 1, '17.9.2009');
INSERT INTO person VALUES(1732, 'Augustin', 'Kazda ','M', '20',  16000, 1, '13/8/2011');
INSERT INTO person VALUES(1733, 'Kamila', '�im�?kov�','F', '30',  12000, 4, '13.7.2006');
INSERT INTO person VALUES(1734, 'Adrian', 'Moudr� ','M', '42',  25000, 4, '20/8/2006');
INSERT INTO person VALUES(1735, 'Alice', 'Pelik�nov�','F', '37',  28000, 4, '24.1.2012');
INSERT INTO person VALUES(1736, 'Oto', 'Kab�t ','M', '25',  30000, 4, '22/11/2018');
INSERT INTO person VALUES(1737, '�t?p�nka', 'Melicharov�','F', '22',  35000, 4, '19.11.2008');
INSERT INTO person VALUES(1738, 'Gerhard', 'Zaj�?ek ','M', '48',  39000, 4, '29/11/2013');
INSERT INTO person VALUES(1739, 'Vladim�ra', '�i�kov�','F', '54',  43000, 3, '15.9.2005');
INSERT INTO person VALUES(1740, 'Jan', 'Synek ','M', '24',  12000, 3, '6/12/2008');
INSERT INTO person VALUES(1741, 'Alice', 'Kochov�','F', '61',  23000, 4, '29.3.2011');
INSERT INTO person VALUES(1742, 'Cyril', 'Fu?�k ','M', '53',  18000, 4, '15/10/2004');
INSERT INTO person VALUES(1743, 'Al�beta', 'Zapletalov�','F', '24',  47000, 1, '31.5.2018');
INSERT INTO person VALUES(1744, 'Samuel', 'Kr�l ','M', '35',  22000, 1, '16/2/2004');
INSERT INTO person VALUES(1745, 'Regina', 'Sou?kov�','F', '55',  18000, 4, '27.3.2015');
INSERT INTO person VALUES(1746, 'Oleg', 'Luk� ','M', '57',  31000, 4, '19/7/2015');
INSERT INTO person VALUES(1747, 'Be�ta', 'Pickov�','F', '62',  34000, 1, '14.5.2004');
INSERT INTO person VALUES(1748, 'Alexander 4 000', 'Jan�?ek ','M', '40',  37000, 1, '28/5/2011');
INSERT INTO person VALUES(1749, 'Yveta', 'Be?v�?ov�','F', '48',  42000, 4, '2.8.2017');
INSERT INTO person VALUES(1750, 'Erich', 'Ors�g ','M', '62',  46000, 4, '4/6/2006');
INSERT INTO person VALUES(1751, 'Alena', 'Zahradn�kov�','F', '55',  22000, 4, '20.9.2006');
INSERT INTO person VALUES(1752, 'B?etislav', 'Mlejnek ','M', '45',  15000, 4, '6/9/2018');
INSERT INTO person VALUES(1753, 'Be�ta', 'Pet?�kov�','F', '40',  29000, 4, '17.7.2003');
INSERT INTO person VALUES(1754, 'Anton', 'Maz�nek ','M', '22',  24000, 4, '13/9/2013');
INSERT INTO person VALUES(1755, 'Veronika', 'Holasov�','F', '48',  45000, 4, '27.1.2009');
INSERT INTO person VALUES(1756, 'V�t', 'Novotn� ','M', '51',  30000, 4, '22/7/2009');
INSERT INTO person VALUES(1757, 'Lenka', 'Vav?�kov�','F', '33',  17000, 4, '23.11.2005');
INSERT INTO person VALUES(1758, 'Adolf', 'K?iv�nek ','M', '27',  39000, 4, '30/7/2004');
INSERT INTO person VALUES(1759, 'S�ra', 'B�rtov�','F', '42',  41000, 1, '25.1.2013');
INSERT INTO person VALUES(1760, 'Peter', 'P�a ','M', '55',  43000, 1, '1/12/2003');
INSERT INTO person VALUES(1761, 'Veronika', 'Kr�l�kov�','F', '26',  40000, 3, '31.3.2008');
INSERT INTO person VALUES(1762, 'Radom�r', 'Sk�cel ','M', '32',  17000, 3, '9/11/2011');
INSERT INTO person VALUES(1763, 'Bohuslava', 'Kle?kov�','F', '34',  28000, 4, '3.6.2015');
INSERT INTO person VALUES(1764, 'Du�an', 'Mach�?ek ','M', '60',  22000, 4, '12/3/2011');
INSERT INTO person VALUES(1765, 'Drahoslava', 'Sikorov�','F', '42',  44000, 1, '21.7.2004');
INSERT INTO person VALUES(1766, 'Roland', 'Kub�k ','M', '43',  27000, 1, '18/1/2007');
INSERT INTO person VALUES(1767, 'Radmila', 'Proke�ov�','F', '27',  15000, 4, '10.10.2017');
INSERT INTO person VALUES(1768, 'Filip', 'Van??ek ','M', '20',  36000, 4, '21/6/2018');
INSERT INTO person VALUES(1769, 'Kar�n', 'Pot??kov�','F', '34',  31000, 1, '28.11.2006');
INSERT INTO person VALUES(1770, 'Alex', 'Hladk� ','M', '49',  42000, 1, '29/4/2014');
INSERT INTO person VALUES(1771, 'And?la', 'Janotov�','F', '20',  39000, 4, '24.9.2003');
INSERT INTO person VALUES(1772, 'Franti�ek', 'Pro�ek ','M', '25',  15000, 4, '6/5/2009');
INSERT INTO person VALUES(1773, 'Viera', 'Zelinkov�','F', '27',  19000, 1, '6.4.2009');
INSERT INTO person VALUES(1774, 'J�chym', 'Kala ','M', '54',  20000, 1, '15/3/2005');
INSERT INTO person VALUES(1775, 'Karin', '�afr�nkov�','F', '59',  26000, 4, '30.1.2006');
INSERT INTO person VALUES(1776, 'Ruslan', 'Du�ek ','M', '30',  29000, 4, '15/8/2016');
INSERT INTO person VALUES(1777, 'Danu�ka', '�vestkov�','F', '20',  42000, 4, '14.8.2011');
INSERT INTO person VALUES(1778, 'Bo?ivoj', 'Ad�mek ','M', '59',  34000, 4, '24/6/2012');
INSERT INTO person VALUES(1779, 'Nina', 'Moln�rov�','F', '51',  14000, 4, '8.6.2008');
INSERT INTO person VALUES(1780, 'Mario', 'Votava ','M', '35',  44000, 4, '2/7/2007');
INSERT INTO person VALUES(1781, 'Blanka', '?ezn�?kov�','F', '60',  38000, 1, '11.8.2015');
INSERT INTO person VALUES(1782, 'Kristi�n', 'Srb ','M', '63',  12000, 1, '2/11/2006');
INSERT INTO person VALUES(1783, 'Miroslava', '?eh�kov�','F', '45',  45000, 4, '6.6.2012');
INSERT INTO person VALUES(1784, '?udov�t', 'P?ibyl ','M', '40',  21000, 4, '4/4/2018');
INSERT INTO person VALUES(1785, 'Tereza', 'Stehl�kov�','F', '31',  17000, 4, '2.4.2009');
INSERT INTO person VALUES(1786, 'Stanislav', 'Ferenc ','M', '62',  31000, 4, '12/4/2013');
INSERT INTO person VALUES(1787, 'Blanka', 'Richtrov�','F', '38',  33000, 4, '14.10.2014');
INSERT INTO person VALUES(1788, 'Oliver', 'Fischer ','M', '45',  36000, 4, '18/2/2009');
INSERT INTO person VALUES(1789, 'Michala', 'Vobo?ilov�','F', '47',  21000, 1, '22.7.2005');
INSERT INTO person VALUES(1790, 'Leo', 'Kab�t ','M', '27',  41000, 1, '21/6/2008');
INSERT INTO person VALUES(1791, 'Milena', '?ervinkov�','F', '31',  20000, 4, '19.2.2017');
INSERT INTO person VALUES(1792, '?en?k', 'Kalivoda ','M', '50',  14000, 4, '30/5/2016');
INSERT INTO person VALUES(1793, 'Alenka', 'Kalousov�','F', '39',  44000, 1, '29.11.2007');
INSERT INTO person VALUES(1794, 'Slavom�r', '?ejka ','M', '32',  19000, 1, '1/10/2015');
INSERT INTO person VALUES(1795, 'Lidmila', 'Hendrychov�','F', '25',  16000, 4, '24.9.2004');
INSERT INTO person VALUES(1796, 'Sebastian', 'Fu?�k ','M', '55',  28000, 4, '9/10/2010');
INSERT INTO person VALUES(1797, 'Tamara', 'Jedli?kov�','F', '32',  32000, 1, '7.4.2010');
INSERT INTO person VALUES(1798, 'Erik', 'Dolej�� ','M', '37',  33000, 1, '17/8/2006');
INSERT INTO person VALUES(1799, 'Alenka', 'Such�','F', '63',  39000, 4, '1.2.2007');
INSERT INTO person VALUES(1800, 'Emanuel', 'Semer�d ','M', '60',  43000, 4, '17/1/2018');
INSERT INTO person VALUES(1801, 'Marika', 'Zichov�','F', '25',  19000, 1, '14.8.2012');
INSERT INTO person VALUES(1802, 'Bed?ich', 'Jech ','M', '43',  12000, 1, '26/11/2013');
INSERT INTO person VALUES(1803, 'Lydie', 'Mat?j�?kov�','F', '56',  27000, 4, '9.6.2009');
INSERT INTO person VALUES(1804, 'Andrej', 'Kom�rek ','M', '19',  21000, 4, '3/12/2008');
INSERT INTO person VALUES(1805, 'Bohdana', 'Berkov�','F', '64',  43000, 1, '21.12.2014');
INSERT INTO person VALUES(1806, 'Alois', 'Bauer ','M', '48',  26000, 1, '12/10/2004');
INSERT INTO person VALUES(1807, 'Marika', 'Hork�','F', '49',  14000, 4, '17.10.2011');
INSERT INTO person VALUES(1808, 'Svatopluk', 'Ol�h ','M', '24',  35000, 4, '14/3/2016');
INSERT INTO person VALUES(1809, 'Vanesa', 'Kri�tofov�','F', '56',  30000, 4, '29.4.2017');
INSERT INTO person VALUES(1810, 'Old?ich', 'Berger ','M', '53',  41000, 4, '21/1/2012');
INSERT INTO person VALUES(1811, 'Ladislava', 'N?me?kov�','F', '19',  18000, 1, '6.2.2008');
INSERT INTO person VALUES(1812, 'V�clav', 'Janda ','M', '35',  45000, 1, '25/5/2011');
INSERT INTO person VALUES(1813, 'Drahom�ra', '��kov�','F', '50',  26000, 1, '2.12.2004');
INSERT INTO person VALUES(1814, 'Ivo', 'Lang ','M', '58',  19000, 1, '1/6/2006');
INSERT INTO person VALUES(1815, 'Kristina', 'Michalcov�','F', '57',  41000, 1, '15.6.2010');
INSERT INTO person VALUES(1816, 'Maxmili�n', 'Hus�k ','M', '41',  24000, 1, '2/9/2018');
INSERT INTO person VALUES(1817, 'Bohumila', 'St�rkov�','F', '43',  13000, 1, '10.4.2007');
INSERT INTO person VALUES(1818, 'Vojt?ch', '�irok� ','M', '63',  33000, 1, '10/9/2013');
INSERT INTO person VALUES(1819, 'Magdal�na', '?erven�','F', '50',  29000, 1, '21.10.2012');
INSERT INTO person VALUES(1820, 'Vasil', 'Rozsypal ','M', '46',  38000, 1, '19/7/2009');
INSERT INTO person VALUES(1821, 'Alice', 'Mr�zov�','F', '36',  36000, 4, '17.8.2009');
INSERT INTO person VALUES(1822, 'Miroslav', 'Ot�hal ','M', '22',  47000, 4, '26/7/2004');
INSERT INTO person VALUES(1823, 'Nicole', 'Kvasni?kov�','F', '44',  24000, 2, '19.10.2016');
INSERT INTO person VALUES(1824, 'Artur', 'Hladk� ','M', '50',  16000, 2, '28/11/2003');
INSERT INTO person VALUES(1825, 'Edita', 'Kulhav�','F', '28',  24000, 4, '25.12.2011');
INSERT INTO person VALUES(1826, 'Zby�ek', 'Bo?ek ','M', '27',  26000, 4, '5/11/2011');
INSERT INTO person VALUES(1827, 'Brigita', 'Sta?kov�','F', '37',  12000, 1, '26.2.2019');
INSERT INTO person VALUES(1828, 'Gerhard', 'Kala ','M', '55',  31000, 1, '8/3/2011');
INSERT INTO person VALUES(1829, 'Magda', 'Hudcov�','F', '21',  47000, 4, '3.5.2014');
INSERT INTO person VALUES(1830, 'Tobi�', 'Hor?�k ','M', '33',  40000, 4, '14/2/2019');
INSERT INTO person VALUES(1831, 'Kate?ina', 'Vorlov�','F', '30',  35000, 1, '9.2.2005');
INSERT INTO person VALUES(1832, 'Cyril', 'Ad�mek ','M', '61',  45000, 1, '17/6/2018');
INSERT INTO person VALUES(1833, 'Dagmar', '�ebestov�','F', '37',  15000, 2, '23.8.2010');
INSERT INTO person VALUES(1834, 'Marian', 'Hole?ek ','M', '44',  14000, 2, '26/4/2014');
INSERT INTO person VALUES(1835, 'Jarmila', 'Trnkov�','F', '22',  23000, 1, '18.6.2007');
INSERT INTO person VALUES(1836, 'Julius', 'Vyb�ral ','M', '20',  23000, 1, '3/5/2009');
INSERT INTO person VALUES(1837, 'Alena', 'Volfov�','F', '54',  30000, 4, '13.4.2004');
INSERT INTO person VALUES(1838, 'J�lius', 'Pernica ','M', '42',  33000, 4, '10/5/2004');
INSERT INTO person VALUES(1839, 'Dagmar', '�pl�chalov�','F', '61',  46000, 1, '25.10.2009');
INSERT INTO person VALUES(1840, 'Robin', 'Kliment ','M', '25',  38000, 1, '12/8/2016');
INSERT INTO person VALUES(1841, 'Jarmila', 'Vorl�?kov�','F', '47',  18000, 4, '21.8.2006');
INSERT INTO person VALUES(1842, 'Vili�m', 'Mare� ','M', '48',  47000, 4, '20/8/2011');
INSERT INTO person VALUES(1843, 'Olga', 'Neumannov�','F', '54',  34000, 1, '3.3.2012');
INSERT INTO person VALUES(1844, 'Vratislav', 'Richter ','M', '30',  16000, 1, '29/6/2007');
INSERT INTO person VALUES(1845, 'Milu�ka', 'Vojt�kov�','F', '62',  21000, 2, '6.5.2019');
INSERT INTO person VALUES(1846, 'V�t', 'Mar��k ','M', '58',  21000, 2, '30/10/2006');
INSERT INTO person VALUES(1847, 'Nikola', 'R�cov�','F', '47',  21000, 1, '10.7.2014');
INSERT INTO person VALUES(1848, '�t?p�n', 'Krej?�k ','M', '36',  31000, 1, '7/10/2014');
INSERT INTO person VALUES(1849, 'Zdena', 'Stehl�kov�','F', '55',  45000, 2, '18.4.2005');
INSERT INTO person VALUES(1850, 'Vlastimil', 'Vin� ','M', '64',  35000, 2, '8/2/2014');
INSERT INTO person VALUES(1851, 'Denisa', 'Ludv�kov�','F', '39',  45000, 4, '16.11.2016');
INSERT INTO person VALUES(1852, 'Jind?ich', 'J�ra ','M', '41',  45000, 4, '23/8/2005');
INSERT INTO person VALUES(1853, 'Viera', 'Ve?erkov�','F', '48',  32000, 2, '26.8.2007');
INSERT INTO person VALUES(1854, 'Vladim�r', 'Uhl�? ','M', '23',  14000, 2, '24/12/2004');
INSERT INTO person VALUES(1855, 'Kar�n', 'Fantov�','F', '33',  40000, 1, '21.6.2004');
INSERT INTO person VALUES(1856, 'Vladislav', 'Jahoda ','M', '45',  23000, 1, '27/5/2016');
INSERT INTO person VALUES(1857, 'Ester', 'Van�?kov�','F', '41',  20000, 1, '2.1.2010');
INSERT INTO person VALUES(1858, 'Ernest', 'Smola ','M', '28',  28000, 1, '4/4/2012');
INSERT INTO person VALUES(1859, 'Viera', 'Kuncov�','F', '26',  27000, 1, '29.10.2006');
INSERT INTO person VALUES(1860, 'Ale�', 'Ne�por ','M', '51',  37000, 1, '12/4/2007');
INSERT INTO person VALUES(1861, 'Bed?i�ka', 'Zedn�kov�','F', '33',  43000, 1, '11.5.2012');
INSERT INTO person VALUES(1862, 'Oskar', 'Kuchta ','M', '34',  43000, 1, '15/7/2019');
INSERT INTO person VALUES(1863, 'Danu�ka', '��rov�','F', '19',  15000, 1, '6.3.2009');
INSERT INTO person VALUES(1864, 'V�clav', 'Charv�t ','M', '56',  16000, 1, '22/7/2014');
INSERT INTO person VALUES(1865, 'Yveta', 'Men��kov�','F', '26',  31000, 1, '17.9.2014');
INSERT INTO person VALUES(1866, '?ubom�r', 'Divi� ','M', '39',  21000, 1, '31/5/2010');
INSERT INTO person VALUES(1867, 'Ren�ta', 'Mat?j�?kov�','F', '35',  19000, 2, '26.6.2005');
INSERT INTO person VALUES(1868, 'Ondrej', '�im�?ek ','M', '21',  26000, 2, '1/10/2009');
INSERT INTO person VALUES(1869, 'Emilie', 'Vejvodov�','F', '20',  26000, 1, '15.9.2018');
INSERT INTO person VALUES(1870, 'Alan', 'Tanco� ','M', '43',  35000, 1, '8/10/2004');
INSERT INTO person VALUES(1871, 'Miloslava', 'Tepl�','F', '51',  34000, 1, '12.7.2015');
INSERT INTO person VALUES(1872, 'Jaroslav', 'Dole�el ','M', '19',  44000, 1, '11/3/2016');
INSERT INTO person VALUES(1873, 'Ema', 'Vil�mkov�','F', '60',  22000, 2, '20.4.2006');
INSERT INTO person VALUES(1874, 'Rastislav', 'Rozsypal ','M', '47',  13000, 2, '13/7/2015');
INSERT INTO person VALUES(1875, 'Kv?toslava', 'Kub�tov�','F', '44',  21000, 1, '17.11.2017');
INSERT INTO person VALUES(1876, 'Adrian', 'Bou�ka ','M', '25',  23000, 1, '25/1/2007');
INSERT INTO person VALUES(1877, 'Johana', 'Wagnerov�','F', '53',  45000, 2, '26.8.2008');
INSERT INTO person VALUES(1878, 'Erv�n', 'Valenta ','M', '53',  27000, 2, '29/5/2006');
INSERT INTO person VALUES(1879, 'Ema', '�vejdov�','F', '38',  17000, 1, '22.6.2005');
INSERT INTO person VALUES(1880, 'Ji?�', 'Bo?ek ','M', '29',  36000, 1, '29/10/2017');
INSERT INTO person VALUES(1881, 'Yvona', 'Musilov�','F', '45',  33000, 2, '3.1.2011');
INSERT INTO person VALUES(1882, '?en?k', '?onka ','M', '58',  42000, 2, '6/9/2013');
INSERT INTO person VALUES(1883, 'Tamara', 'Dole�alov�','F', '31',  40000, 1, '30.10.2007');
INSERT INTO person VALUES(1884, 'Vojtech', 'Hor?�k ','M', '34',  15000, 1, '14/9/2008');
INSERT INTO person VALUES(1885, 'Radka', 'Neumannov�','F', '39',  28000, 2, '1.1.2015');
INSERT INTO person VALUES(1886, 'Sebastian', 'Ad�mek ','M', '62',  19000, 2, '16/1/2008');
INSERT INTO person VALUES(1887, 'Yvona', 'Holcov�','F', '24',  28000, 1, '7.3.2010');
INSERT INTO person VALUES(1888, 'Oleg', 'Vil�mek ','M', '40',  29000, 1, '24/12/2015');
INSERT INTO person VALUES(1889, 'Aneta', 'R�cov�','F', '32',  16000, 2, '9.5.2017');
INSERT INTO person VALUES(1890, 'Nikolas', 'Vyb�ral ','M', '22',  34000, 2, '27/4/2015');
INSERT INTO person VALUES(1891, 'Ad�la', 'Votrubov�','F', '64',  23000, 1, '5.3.2014');
INSERT INTO person VALUES(1892, 'Vladan', 'Pernica ','M', '44',  43000, 1, '4/5/2010');
INSERT INTO person VALUES(1893, 'Drahom�ra', 'Ludv�kov�','F', '25',  39000, 2, '16.9.2019');
INSERT INTO person VALUES(1894, 'Tibor', 'Kliment ','M', '27',  12000, 2, '12/3/2006');
INSERT INTO person VALUES(1895, 'Romana', 'Vondrov�','F', '56',  47000, 1, '12.7.2016');
INSERT INTO person VALUES(1896, 'Norbert', 'Mare� ','M', '49',  22000, 1, '13/8/2017');
INSERT INTO person VALUES(1897, 'Ladislava', 'Buben�kov�','F', '64',  27000, 2, '30.8.2005');
INSERT INTO person VALUES(1898, 'Denis', 'Richter ','M', '32',  27000, 2, '21/6/2013');
INSERT INTO person VALUES(1899, 'Drahom�ra', 'N�vltov�','F', '49',  34000, 1, '19.11.2018');
INSERT INTO person VALUES(1900, 'Dan', '�est�k ','M', '54',  36000, 1, '29/6/2008');
INSERT INTO person VALUES(1901, 'Sylvie', 'Kuncov�','F', '58',  22000, 2, '27.8.2009');
INSERT INTO person VALUES(1902, 'Pavol', 'Jur?�k ','M', '36',  41000, 2, '31/10/2007');
INSERT INTO person VALUES(1903, 'Radana', 'Zedn�kov�','F', '19',  38000, 3, '10.3.2015');
INSERT INTO person VALUES(1904, 'Rostislav', 'Vin� ','M', '19',  46000, 3, '8/9/2003');
INSERT INTO person VALUES(1905, 'Hanna', '��rov�','F', '50',  46000, 2, '4.1.2012');
INSERT INTO person VALUES(1906, 'Bohum�r', 'Dohnal ','M', '42',  19000, 2, '9/2/2015');
INSERT INTO person VALUES(1907, 'Laura', 'Men��kov�','F', '58',  25000, 2, '17.7.2017');
INSERT INTO person VALUES(1908, 'Jarom�r', 'Uhl�? ','M', '25',  24000, 2, '18/12/2010');
INSERT INTO person VALUES(1909, 'Nicole', 'Kostkov�','F', '43',  33000, 2, '13.5.2014');
INSERT INTO person VALUES(1910, 'Eduard', 'Jahoda ','M', '47',  34000, 2, '25/12/2005');
INSERT INTO person VALUES(1911, 'Svitlana', 'B�hmov�','F', '28',  41000, 1, '9.3.2011');
INSERT INTO person VALUES(1912, 'Juraj', 'Farka� ','M', '23',  43000, 1, '28/5/2017');
INSERT INTO person VALUES(1913, 'Laura', 'Neradov�','F', '36',  20000, 2, '19.9.2016');
INSERT INTO person VALUES(1914, 'Dominik', 'Ne�por ','M', '52',  12000, 2, '5/4/2013');
INSERT INTO person VALUES(1915, 'Julie', 'Kop?ivov�','F', '44',  44000, 3, '28.6.2007');
INSERT INTO person VALUES(1916, 'Anton�n', 'Hrdina ','M', '34',  17000, 3, '6/8/2012');
INSERT INTO person VALUES(1917, 'Al�b?ta', 'Kub�tov�','F', '30',  16000, 2, '23.4.2004');
INSERT INTO person VALUES(1918, 'Zbyn?k', 'Berger ','M', '57',  26000, 2, '15/8/2007');
INSERT INTO person VALUES(1919, 'Erika', 'B?�zov�','F', '37',  32000, 3, '4.11.2009');
INSERT INTO person VALUES(1920, 'Petr', 'Hartman ','M', '40',  31000, 3, '23/6/2003');
INSERT INTO person VALUES(1921, 'Sabina', 'Vodr�kov�','F', '22',  39000, 2, '31.8.2006');
INSERT INTO person VALUES(1922, 'Lubom�r', 'Kolman ','M', '62',  40000, 2, '23/11/2014');
INSERT INTO person VALUES(1923, 'Terezie', 'Muchov�','F', '30',  19000, 2, '13.3.2012');
INSERT INTO person VALUES(1924, 'Vladimir', 'Tanco� ','M', '45',  45000, 2, '2/10/2010');
INSERT INTO person VALUES(1925, 'Erika', 'Malinov�','F', '61',  27000, 2, '7.1.2009');
INSERT INTO person VALUES(1926, 'Jakub', 'Dole�el ','M', '21',  19000, 2, '9/10/2005');
INSERT INTO person VALUES(1927, 'Svatava', 'Reme�ov�','F', '22',  43000, 2, '21.7.2014');
INSERT INTO person VALUES(1928, 'J?lius', 'Kozel ','M', '50',  24000, 2, '11/1/2018');
INSERT INTO person VALUES(1929, 'Josefa', 'Moudr�','F', '54',  14000, 2, '16.5.2011');
INSERT INTO person VALUES(1930, 'Svatoslav', 'Bou�ka ','M', '26',  33000, 2, '18/1/2013');
INSERT INTO person VALUES(1931, 'V?ra', 'Pol�kov�','F', '62',  38000, 3, '18.7.2018');
INSERT INTO person VALUES(1932, 'Nikola', 'Valenta ','M', '54',  38000, 3, '21/5/2012');
INSERT INTO person VALUES(1933, 'Svatava', 'Horv�tov�','F', '47',  38000, 1, '22.9.2013');
INSERT INTO person VALUES(1934, 'Stepan', 'Lavi?ka ','M', '32',  12000, 1, '5/12/2003');
INSERT INTO person VALUES(1935, 'Martina', 'Hankov�','F', '55',  26000, 2, '1.7.2004');
INSERT INTO person VALUES(1936, 'Hubert', '?onka ','M', '60',  16000, 2, '31/8/2019');
INSERT INTO person VALUES(1937, 'Eli�ka', 'Horov�','F', '62',  42000, 3, '12.1.2010');
INSERT INTO person VALUES(1938, 'Hynek', 'Dudek ','M', '43',  21000, 3, '10/7/2015');
INSERT INTO person VALUES(1939, 'Zuzana', 'Hanzl�kov�','F', '48',  13000, 2, '8.11.2006');
INSERT INTO person VALUES(1940, 'Ferdinand', 'Peroutka ','M', '19',  31000, 2, '17/7/2010');
INSERT INTO person VALUES(1941, 'Zdenka', 'Lakato�ov�','F', '55',  29000, 3, '21.5.2012');
INSERT INTO person VALUES(1942, 'Otakar', 'Hroch ','M', '48',  36000, 3, '25/5/2006');
INSERT INTO person VALUES(1943, 'Pavla', 'Ba?ov�','F', '41',  37000, 2, '16.3.2009');
INSERT INTO person VALUES(1944, '?estm�r', 'Kone?n� ','M', '24',  45000, 2, '26/10/2017');
INSERT INTO person VALUES(1945, 'Zuzana', 'Frydrychov�','F', '26',  44000, 1, '10.1.2006');
INSERT INTO person VALUES(1946, 'Imrich', 'Ko� �l ','M', '46',  18000, 1, '2/11/2012');
INSERT INTO person VALUES(1947, 'Milada', 'Sp�?ilov�','F', '33',  24000, 2, '24.7.2011');
INSERT INTO person VALUES(1948, 'Arno�t', 'Hude?ek ','M', '29',  24000, 2, '10/9/2008');
INSERT INTO person VALUES(1949, 'Vlastimila', 'Ka?kov�','F', '42',  12000, 3, '25.9.2018');
INSERT INTO person VALUES(1950, 'Ludv�k', 'Pracha? ','M', '57',  28000, 3, '13/1/2008');
INSERT INTO person VALUES(1951, 'Iva', 'Chlupov�','F', '26',  12000, 2, '30.11.2013');
INSERT INTO person VALUES(1952, 'Marcel', 'Slov�?ek ','M', '35',  38000, 2, '21/12/2015');
INSERT INTO person VALUES(1953, '�ofie', 'K?�kov�','F', '35',  35000, 3, '8.9.2004');
INSERT INTO person VALUES(1954, 'Richard', 'Nov�?ek ','M', '63',  43000, 3, '23/4/2015');
INSERT INTO person VALUES(1955, 'Jindra', 'Zaj�cov�','F', '20',  43000, 2, '28.11.2017');
INSERT INTO person VALUES(1956, 'P?emysl', 'Krej?�k ','M', '39',  16000, 2, '1/5/2010');
INSERT INTO person VALUES(1957, 'Patricie', 'Holanov�','F', '27',  23000, 3, '16.1.2007');
INSERT INTO person VALUES(1958, 'Miloslav', 'Sedl�? ','M', '22',  21000, 3, '9/3/2006');
INSERT INTO person VALUES(1959, '�ofie', 'Tome�ov�','F', '59',  31000, 2, '11.11.2003');
INSERT INTO person VALUES(1960, 'Emil', 'Vav?�k ','M', '44',  30000, 2, '9/8/2017');
INSERT INTO person VALUES(1961, 'Oksana', 'Schneiderov�','F', '20',  46000, 3, '24.5.2009');
INSERT INTO person VALUES(1962, 'Martin', 'Dunka ','M', '27',  35000, 3, '18/6/2013');
INSERT INTO person VALUES(1963, 'Johana', 'Sojkov�','F', '51',  18000, 2, '20.3.2006');
INSERT INTO person VALUES(1964, 'Robert', 'Bro� ','M', '50',  45000, 2, '25/6/2008');
INSERT INTO person VALUES(1965, 'Miriam', 'Pavlicov�','F', '59',  34000, 2, '1.10.2011');
INSERT INTO person VALUES(1966, 'Artur', 'Kr�tk� ','M', '33',  14000, 2, '4/5/2004');
INSERT INTO person VALUES(1967, 'Oksana', 'Dosko?ilov�','F', '44',  41000, 2, '27.7.2008');
INSERT INTO person VALUES(1968, 'Anton�n', '�ime?ek ','M', '55',  23000, 2, '5/10/2015');
INSERT INTO person VALUES(1969, 'Ilona', 'Peterkov�','F', '53',  29000, 3, '29.9.2015');
INSERT INTO person VALUES(1970, 'Ji?�', 'Kuchta ','M', '37',  28000, 3, '5/2/2015');
INSERT INTO person VALUES(1971, 'Magdalena', 'Knapov�','F', '60',  45000, 3, '16.11.2004');
INSERT INTO person VALUES(1972, 'Gabriel', 'Pluha? ','M', '20',  33000, 3, '15/12/2010');
INSERT INTO person VALUES(1973, 'Danu�e', 'Kalivodov�','F', '45',  17000, 3, '4.2.2018');
INSERT INTO person VALUES(1974, 'Vojtech', '�t?rba ','M', '42',  42000, 3, '22/12/2005');
INSERT INTO person VALUES(1975, 'Hedvika', 'B�hmov�','F', '53',  33000, 3, '25.3.2007');
INSERT INTO person VALUES(1976, 'Drahom�r', 'Balog ','M', '25',  47000, 3, '26/3/2018');
INSERT INTO person VALUES(1977, 'Magdalena', 'Hrdinov�','F', '38',  40000, 3, '19.1.2004');
INSERT INTO person VALUES(1978, 'Juli�s', 'Kov�?�k ','M', '47',  21000, 3, '2/4/2013');
INSERT INTO person VALUES(1979, 'Nikol', 'Grygarov�','F', '45',  20000, 3, '1.8.2009');
INSERT INTO person VALUES(1980, 'Tade�', 'Vrabec ','M', '30',  26000, 3, '8/2/2009');
INSERT INTO person VALUES(1981, 'Karla', 'Krupov�','F', '31',  28000, 2, '28.5.2006');
INSERT INTO person VALUES(1982, 'Viliam', 'Vit�sek ','M', '53',  35000, 2, '17/2/2004');
INSERT INTO person VALUES(1983, 'Zora', 'Noskov�','F', '39',  16000, 4, '30.7.2013');
INSERT INTO person VALUES(1984, 'Tibor', 'Homola ','M', '35',  40000, 4, '20/6/2003');
INSERT INTO person VALUES(1985, 'Nikol', 'Cibulkov�','F', '24',  15000, 2, '4.10.2008');
INSERT INTO person VALUES(1986, 'Matou�', 'Mike� ','M', '58',  14000, 2, '28/5/2011');
INSERT INTO person VALUES(1987, 'Iryna', 'Hanouskov�','F', '32',  39000, 3, '6.12.2015');
INSERT INTO person VALUES(1988, 'Denis', 'P�cha ','M', '40',  18000, 3, '29/9/2010');
INSERT INTO person VALUES(1989, 'Adriana', 'Kov�?ov�','F', '62',  39000, 2, '10.2.2011');
INSERT INTO person VALUES(1990, 'Adolf', 'Maty� ','M', '63',  28000, 2, '6/9/2018');
INSERT INTO person VALUES(1991, 'Lucie', 'Valov�','F', '25',  26000, 3, '14.4.2018');
INSERT INTO person VALUES(1992, 'Dalibor', 'K?� ','M', '45',  33000, 3, '7/1/2018');
INSERT INTO person VALUES(1993, 'Laura', 'Uhrov�','F', '56',  34000, 2, '8.2.2015');
INSERT INTO person VALUES(1994, 'Radoslav', 'Franc ','M', '21',  42000, 2, '15/1/2013');
INSERT INTO person VALUES(1995, 'Ivana', 'Jare�ov�','F', '64',  14000, 3, '28.3.2004');
INSERT INTO person VALUES(1996, 'Lud?k', 'Kr�l�k ','M', '50',  47000, 3, '23/11/2008');
INSERT INTO person VALUES(1997, 'Petra', 'D?dkov�','F', '49',  22000, 2, '17.6.2017');
INSERT INTO person VALUES(1998, 'Kry�tof', 'Cihl�? ','M', '27',  20000, 2, '1/12/2003');
INSERT INTO person VALUES(1999, 'Dana', 'Vale�ov�','F', '56',  37000, 3, '5.8.2006');
INSERT INTO person VALUES(2000, 'Ivan', 'Pape� ','M', '56',  26000, 3, '4/3/2016');
INSERT INTO person VALUES(2001, 'Michaela', '�ime?kov�','F', '42',  45000, 2, '24.10.2019');
INSERT INTO person VALUES(2002, 'Ludv�k', 'Brada ','M', '32',  35000, 2, '12/3/2011');
INSERT INTO person VALUES(2003, 'Andrea', 'J�chov�','F', '49',  25000, 3, '11.12.2008');
INSERT INTO person VALUES(2004, 'Franti�ek', 'R?�i?ka ','M', '61',  40000, 3, '19/1/2007');
INSERT INTO person VALUES(2005, 'Maria', 'Francov�','F', '58',  13000, 4, '13.2.2016');
INSERT INTO person VALUES(2006, 'Boleslav', '�iga ','M', '43',  45000, 4, '22/5/2006');
INSERT INTO person VALUES(2007, 'Darina', 'Hovorkov�','F', '43',  20000, 3, '9.12.2012');
INSERT INTO person VALUES(2008, 'Marek', '?eh�?ek ','M', '19',  18000, 3, '22/10/2017');
INSERT INTO person VALUES(2009, 'Karolina', 'Frydrychov�','F', '50',  36000, 4, '22.6.2018');
INSERT INTO person VALUES(2010, 'Mario', 'Ho?ej�� ','M', '48',  23000, 4, '31/8/2013');
INSERT INTO person VALUES(2011, 'Maria', 'Rousov�','F', '36',  44000, 3, '18.4.2015');
INSERT INTO person VALUES(2012, 'Pavel', 'N?me?ek ','M', '25',  32000, 3, '7/9/2008');
INSERT INTO person VALUES(2013, 'Valerie', 'Vojtov�','F', '43',  24000, 3, '5.6.2004');
INSERT INTO person VALUES(2014, 'Lubor', '�r�mek ','M', '54',  37000, 3, '17/7/2004');
INSERT INTO person VALUES(2015, 'Jarom�ra', 'Kleinov�','F', '28',  31000, 3, '24.8.2017');
INSERT INTO person VALUES(2016, 'Rastislav', 'Voj�?ek ','M', '30',  47000, 3, '18/12/2015');
INSERT INTO person VALUES(2017, 'Sylvie', 'Dani�ov�','F', '36',  47000, 3, '12.10.2006');
INSERT INTO person VALUES(2018, 'Ota', 'M?ller ','M', '59',  16000, 3, '26/10/2011');
INSERT INTO person VALUES(2019, 'Valerie', 'Pohankov�','F', '21',  19000, 3, '8.8.2003');
INSERT INTO person VALUES(2020, 'Erv�n', 'Hu�ek ','M', '35',  25000, 3, '3/11/2006');
INSERT INTO person VALUES(2021, 'Kl�ra', 'Boh�?ov�','F', '30',  43000, 4, '10.10.2010');
INSERT INTO person VALUES(2022, 'Leo', 'Hork� ','M', '63',  30000, 4, '6/3/2006');
INSERT INTO person VALUES(2023, 'Gertruda', 'He?manov�','F', '60',  42000, 2, '15.12.2005');
INSERT INTO person VALUES(2024, '?en?k', 'Toman ','M', '40',  40000, 2, '11/2/2014');
INSERT INTO person VALUES(2025, 'Daniela', '�im�nkov�','F', '22',  30000, 4, '16.2.2013');
INSERT INTO person VALUES(2026, 'Mikul�', 'Vorel ','M', '22',  44000, 4, '15/6/2013');
INSERT INTO person VALUES(2027, 'Zdenka', '�krabalov�','F', '54',  38000, 3, '13.12.2009');
INSERT INTO person VALUES(2028, 'Sebastian', 'Hl�vka ','M', '45',  17000, 3, '22/6/2008');
INSERT INTO person VALUES(2029, 'Nad?�da', 'Lacinov�','F', '61',  18000, 3, '26.6.2015');
INSERT INTO person VALUES(2030, 'Bronislav', 'Ba�ta ','M', '28',  23000, 3, '30/4/2004');
INSERT INTO person VALUES(2031, 'Daniela', 'Pek�rkov�','F', '47',  25000, 3, '20.4.2012');
INSERT INTO person VALUES(2032, 'Nikolas', '�indel�? ','M', '50',  32000, 3, '2/10/2015');
INSERT INTO person VALUES(2033, 'M�ria', 'Kub�nkov�','F', '54',  41000, 3, '1.11.2017');
INSERT INTO person VALUES(2034, '�imon', '��?ek ','M', '33',  37000, 3, '10/8/2011');
INSERT INTO person VALUES(2035, 'Ane�ka', 'Kocmanov�','F', '39',  13000, 3, '28.8.2014');
INSERT INTO person VALUES(2036, 'Tibor', 'Vojt?ch ','M', '55',  46000, 3, '17/8/2006');
INSERT INTO person VALUES(2037, 'Em�lia', '��mov�','F', '48',  37000, 4, '6.6.2005');
INSERT INTO person VALUES(2038, 'Arno�t', 'Svato? ','M', '37',  15000, 4, '19/12/2005');
INSERT INTO person VALUES(2039, 'Radom�ra', 'Z�le��kov�','F', '55',  16000, 4, '18.12.2010');
INSERT INTO person VALUES(2040, 'Libor', 'Dole�al ','M', '20',  20000, 4, '22/3/2018');
INSERT INTO person VALUES(2041, 'Na?a', 'Berkyov�','F', '41',  24000, 4, '14.10.2007');
INSERT INTO person VALUES(2042, 'Marcel', 'Berka ','M', '42',  29000, 4, '30/3/2013');
INSERT INTO person VALUES(2043, 'Tatiana', 'Veverkov�','F', '48',  40000, 4, '26.4.2013');
INSERT INTO person VALUES(2044, 'Karel', 'Lacina ','M', '25',  35000, 4, '5/2/2009');
INSERT INTO person VALUES(2045, 'Radom�ra', '�ubrtov�','F', '33',  47000, 3, '19.2.2010');
INSERT INTO person VALUES(2046, 'Rostislav', 'Neubauer ','M', '48',  44000, 3, '13/2/2004');
INSERT INTO person VALUES(2047, 'Oksana', 'Trojanov�','F', '19',  19000, 3, '16.12.2006');
INSERT INTO person VALUES(2048, 'Bohum�r', 'Dani� ','M', '24',  17000, 3, '17/7/2015');
INSERT INTO person VALUES(2049, 'Natalie', 'Vit�skov�','F', '26',  35000, 3, '28.6.2012');
INSERT INTO person VALUES(2050, 'Jarom�r', 'Vod�k ','M', '53',  22000, 3, '25/5/2011');
INSERT INTO person VALUES(2051, 'Dominika', 'Klime�ov�','F', '35',  23000, 4, '31.8.2019');
INSERT INTO person VALUES(2052, 'Martin', 'Vojta ','M', '35',  27000, 4, '25/9/2010');
INSERT INTO person VALUES(2053, 'Anna', 'Mar��lkov�','F', '19',  22000, 3, '5.11.2014');
INSERT INTO person VALUES(2054, 'Tom�', 'Uher ','M', '58',  37000, 3, '3/9/2018');
INSERT INTO person VALUES(2055, 'Kv?tu�e', '��dkov�','F', '27',  46000, 4, '14.8.2005');
INSERT INTO person VALUES(2056, 'Artur', 'Kulhav� ','M', '40',  41000, 4, '4/1/2018');
INSERT INTO person VALUES(2057, 'Jitka', 'Kr�l�?kov�','F', '58',  46000, 3, '14.3.2017');
INSERT INTO person VALUES(2058, 'Zby�ek', 'Rudolf ','M', '64',  15000, 3, '20/7/2009');
INSERT INTO person VALUES(2059, 'Leona', 'V�tov�','F', '20',  34000, 4, '21.12.2007');
INSERT INTO person VALUES(2060, 'Walter', 'Sedl�k ','M', '46',  20000, 4, '20/11/2008');
INSERT INTO person VALUES(2061, 'Hedvika', '?ejkov�','F', '52',  41000, 3, '16.10.2004');
INSERT INTO person VALUES(2062, 'Petr', 'Vacul�k ','M', '22',  29000, 3, '28/11/2003');
INSERT INTO person VALUES(2063, 'Vladislava', 'Jir�nkov�','F', '59',  21000, 4, '29.4.2010');
INSERT INTO person VALUES(2064, 'Petro', 'Machala ','M', '51',  34000, 4, '1/3/2016');
INSERT INTO person VALUES(2065, 'Leona', 'Kubelkov�','F', '44',  29000, 3, '23.2.2007');
INSERT INTO person VALUES(2066, 'Vladimir', 'Pr�ek ','M', '27',  43000, 3, '9/3/2011');
INSERT INTO person VALUES(2067, 'Elena', 'Matulov�','F', '52',  45000, 4, '5.9.2012');
INSERT INTO person VALUES(2068, 'Boris', 'Michal�k ','M', '56',  13000, 4, '15/1/2007');
INSERT INTO person VALUES(2069, 'Dita', 'Demeterov�','F', '37',  16000, 3, '2.7.2009');
INSERT INTO person VALUES(2070, 'J?lius', 'Novotn� ','M', '32',  22000, 3, '18/6/2018');
INSERT INTO person VALUES(2071, 'Lucie', 'Rakov�','F', '45',  40000, 4, '3.9.2016');
INSERT INTO person VALUES(2072, 'Viliam', 'M?ller ','M', '60',  26000, 4, '19/10/2017');
INSERT INTO person VALUES(2073, 'Marta', 'Bauerov�','F', '53',  20000, 1, '22.10.2005');
INSERT INTO person VALUES(2074, 'Vil�m', 'Merta ','M', '43',  32000, 1, '27/8/2013');
INSERT INTO person VALUES(2075, 'Ji?ina', 'Barto?ov�','F', '38',  28000, 4, '10.1.2019');
INSERT INTO person VALUES(2076, 'Matou�', 'Hrd� ','M', '20',  41000, 4, '4/9/2008');
INSERT INTO person VALUES(2077, '��rka', 'Karbanov�','F', '45',  43000, 4, '28.2.2008');
INSERT INTO person VALUES(2078, '�t?p�n', 'Lev� ','M', '49',  46000, 4, '13/7/2004');
INSERT INTO person VALUES(2079, 'Libu�e', 'Balounov�','F', '31',  15000, 4, '24.12.2004');
INSERT INTO person VALUES(2080, 'Hynek', 'Benda ','M', '25',  19000, 4, '15/12/2015');
INSERT INTO person VALUES(2081, 'Radka', 'Pol�vkov�','F', '38',  31000, 4, '7.7.2010');
INSERT INTO person VALUES(2082, 'Jind?ich', '�ediv� ','M', '54',  25000, 4, '23/10/2011');
INSERT INTO person VALUES(2083, 'Iveta', 'Pr?�ov�','F', '24',  38000, 4, '3.5.2007');
INSERT INTO person VALUES(2084, 'Otakar', 'Hladk� ','M', '30',  34000, 4, '30/10/2006');
INSERT INTO person VALUES(2085, 'Aneta', 'Jelenov�','F', '31',  18000, 4, '13.11.2012');
INSERT INTO person VALUES(2086, 'Luk�', 'Vojt�ek ','M', '59',  39000, 4, '1/2/2019');
INSERT INTO person VALUES(2087, 'Ad�la', 'Riedlov�','F', '62',  26000, 3, '8.9.2009');
INSERT INTO person VALUES(2088, 'Bohuslav', 'Mencl ','M', '35',  12000, 3, '8/2/2014');
INSERT INTO person VALUES(2089, 'Katar�na', 'Tomkov�','F', '25',  14000, 1, '10.11.2016');
INSERT INTO person VALUES(2090, 'Ivan', 'Form�nek ','M', '63',  17000, 1, '11/6/2013');
INSERT INTO person VALUES(2091, 'Aneta', 'Jansov�','F', '55',  13000, 3, '16.1.2012');
INSERT INTO person VALUES(2092, 'Libor', 'Havelka ','M', '41',  27000, 3, '25/12/2004');
INSERT INTO person VALUES(2093, 'D�a', '?eh�?kov�','F', '64',  37000, 4, '20.3.2019');
INSERT INTO person VALUES(2094, 'Zden?k', 'Macha? ','M', '23',  31000, 4, '27/4/2004');
INSERT INTO person VALUES(2095, 'Karolina', 'Holoubkov�','F', '49',  45000, 4, '14.1.2016');
INSERT INTO person VALUES(2096, 'Richard', 'Walter ','M', '45',  40000, 4, '28/9/2015');
INSERT INTO person VALUES(2097, 'Aloisie', 'Bo?kov�','F', '56',  25000, 4, '3.3.2005');
INSERT INTO person VALUES(2098, 'V?roslav', 'Kr�l�?ek ','M', '28',  46000, 4, '7/8/2011');
INSERT INTO person VALUES(2099, 'Valerie', 'Smol�kov�','F', '42',  32000, 4, '22.5.2018');
INSERT INTO person VALUES(2100, 'Miloslav', 'Gregor ','M', '50',  19000, 4, '14/8/2006');
INSERT INTO person VALUES(2101, 'Hanna', 'Kolmanov�','F', '49',  12000, 4, '10.7.2007');
INSERT INTO person VALUES(2102, 'Zolt�n', 'Ve?e?a ','M', '33',  24000, 4, '16/11/2018');
INSERT INTO person VALUES(2103, 'Sylvie', 'Klou?kov�','F', '35',  20000, 3, '5.5.2004');
INSERT INTO person VALUES(2104, 'Martin', '�i�ka ','M', '56',  33000, 3, '23/11/2013');
INSERT INTO person VALUES(2105, 'Milu�e', 'Nov�','F', '43',  44000, 4, '8.7.2011');
INSERT INTO person VALUES(2106, 'Rastislav', 'Ku?era ','M', '38',  38000, 4, '26/3/2013');
INSERT INTO person VALUES(2107, 'Vendula', 'Fuchsov�','F', '50',  24000, 1, '18.1.2017');
INSERT INTO person VALUES(2108, 'Ota', 'V�tek ','M', '21',  43000, 1, '2/2/2009');
INSERT INTO person VALUES(2109, 'So?a', 'Mlejnkov�','F', '36',  31000, 4, '14.11.2013');
INSERT INTO person VALUES(2110, 'Erv�n', 'Kola?�k ','M', '43',  16000, 4, '10/2/2004');
INSERT INTO person VALUES(2111, 'Julie', 'Trojanov�','F', '43',  47000, 1, '28.5.2019');
INSERT INTO person VALUES(2112, 'Vlastislav', 'Koubek ','M', '26',  22000, 1, '14/5/2016');
INSERT INTO person VALUES(2113, 'Al�b?ta', 'Smejkalov�','F', '29',  19000, 4, '23.3.2016');
INSERT INTO person VALUES(2114, 'Gabriel', 'Michalec ','M', '48',  31000, 4, '22/5/2011');
INSERT INTO person VALUES(2115, 'Nela', 'Smr�ov�','F', '36',  34000, 1, '11.5.2005');
INSERT INTO person VALUES(2116, 'Leo�', 'Pivo?ka ','M', '31',  36000, 1, '30/3/2007');
INSERT INTO person VALUES(2117, 'Julie', '�pi?kov�','F', '21',  42000, 4, '30.7.2018');
INSERT INTO person VALUES(2118, 'Drahom�r', 'Ka?�rek ','M', '53',  45000, 4, '31/8/2018');
INSERT INTO person VALUES(2119, 'Terezie', 'Chovancov�','F', '29',  22000, 4, '17.9.2007');
INSERT INTO person VALUES(2120, 'Zbyn?k', '�ev?�k ','M', '36',  15000, 4, '9/7/2014');
INSERT INTO person VALUES(2121, 'Erika', 'Ha�kov�','F', '60',  30000, 4, '13.7.2004');
INSERT INTO person VALUES(2122, 'Tade�', 'Kube� ','M', '59',  24000, 4, '16/7/2009');
INSERT INTO person VALUES(2123, 'Tati�na', 'Vor�?kov�','F', '23',  17000, 1, '15.9.2011');
INSERT INTO person VALUES(2124, '�imon', 'Kri�tof ','M', '41',  28000, 1, '17/11/2008');
INSERT INTO person VALUES(2125, 'Terezie', 'Jur�skov�','F', '53',  17000, 4, '20.11.2006');
INSERT INTO person VALUES(2126, 'Vil�m', 'Sad�lek ','M', '64',  38000, 4, '25/10/2016');
INSERT INTO person VALUES(2127, 'V?ra', 'V�clav�kov�','F', '61',  41000, 1, '22.1.2014');
INSERT INTO person VALUES(2128, 'Vit', 'Hlav�?ek ','M', '46',  43000, 1, '26/2/2016');
INSERT INTO person VALUES(2129, 'Mark�ta', 'Kubelkov�','F', '23',  21000, 1, '5.8.2019');
INSERT INTO person VALUES(2130, 'Zd?nek', '�varc ','M', '29',  12000, 1, '5/1/2012');
INSERT INTO person VALUES(2131, 'Martina', '�a�kov�','F', '54',  28000, 1, '30.5.2016');
INSERT INTO person VALUES(2132, 'Rudolf', 'Mar��lek ','M', '51',  21000, 1, '12/1/2007');
INSERT INTO person VALUES(2133, 'Eli�ka', 'Prchalov�','F', '61',  44000, 1, '18.7.2005');
INSERT INTO person VALUES(2134, 'Nikola', 'Ol�h ','M', '34',  27000, 1, '16/4/2019');
INSERT INTO person VALUES(2135, 'Vlasta', 'Do?kalov�','F', '47',  16000, 4, '7.10.2018');
INSERT INTO person VALUES(2136, 'Michal', 'Hejna ','M', '56',  36000, 4, '23/4/2014');
INSERT INTO person VALUES(2137, 'Martina', 'Zelinkov�','F', '32',  23000, 4, '3.8.2015');
INSERT INTO person VALUES(2138, 'Lud?k', 'V�vra ','M', '33',  45000, 4, '30/4/2009');
INSERT INTO person VALUES(2139, 'Jolana', 'Barto�kov�','F', '41',  47000, 1, '12.5.2006');
INSERT INTO person VALUES(2140, 'Filip', 'Vojt�ek ','M', '61',  14000, 1, '31/8/2008');
INSERT INTO person VALUES(2141, 'Old?i�ka', 'Kalinov�','F', '48',  27000, 1, '23.11.2011');
INSERT INTO person VALUES(2142, 'Ctibor', 'Petr? ','M', '44',  19000, 1, '10/7/2004');
INSERT INTO person VALUES(2143, 'Ta �na', 'Gregorov�','F', '33',  35000, 1, '17.9.2008');
INSERT INTO person VALUES(2144, 'Tom�', 'Moln�r ','M', '20',  28000, 1, '11/12/2015');
INSERT INTO person VALUES(2145, 'Jolana', '?ezn�?kov�','F', '19',  42000, 4, '14.7.2005');
INSERT INTO person VALUES(2146, 'Dominik', 'Ad�mek ','M', '42',  37000, 4, '19/12/2010');
INSERT INTO person VALUES(2147, 'Jana', '�olcov�','F', '27',  30000, 1, '15.9.2012');
INSERT INTO person VALUES(2148, 'Radek', 'Macha? ','M', '24',  42000, 1, '21/4/2010');
INSERT INTO person VALUES(2149, 'Vladislava', 'Hrube�ov�','F', '58',  30000, 4, '21.11.2007');
INSERT INTO person VALUES(2150, 'Marek', 'Frank ','M', '48',  16000, 4, '29/3/2018');
INSERT INTO person VALUES(2151, 'Jaroslava', 'Pokorn�','F', '20',  18000, 1, '23.1.2015');
INSERT INTO person VALUES(2152, 'Josef', 'Kr�l�?ek ','M', '30',  20000, 1, '31/7/2017');
INSERT INTO person VALUES(2153, 'Irena', 'Mar��kov�','F', '27',  34000, 1, '12.3.2004');
INSERT INTO person VALUES(2154, 'Kristi�n', 'Kotrba ','M', '59',  26000, 1, '8/6/2013');
INSERT INTO person VALUES(2155, 'Monika', 'Odehnalov�','F', '59',  41000, 1, '1.6.2017');
INSERT INTO person VALUES(2156, '?udov�t', 'Ve?e?a ','M', '35',  35000, 1, '15/6/2008');
INSERT INTO person VALUES(2157, '��rka', 'Zelenkov�','F', '20',  21000, 1, '20.7.2006');
INSERT INTO person VALUES(2158, 'Boris', 'Buchta ','M', '64',  40000, 1, '24/4/2004');
INSERT INTO person VALUES(2159, 'Marta', 'Hol�','F', '52',  29000, 1, '8.10.2019');
INSERT INTO person VALUES(2160, 'Oliver', 'Mar��k ','M', '40',  13000, 1, '25/9/2015');
INSERT INTO person VALUES(2161, 'Ji?ina', 'Koz�kov�','F', '37',  36000, 4, '3.8.2016');
INSERT INTO person VALUES(2162, 'Po?et', 'Jur?�k ','M', '63',  22000, 4, '2/10/2010');
INSERT INTO person VALUES(2163, '��rka', 'Zahr�dkov�','F', '44',  16000, 4, '21.9.2005');
INSERT INTO person VALUES(2164, 'Leo', 'Je� ','M', '45',  28000, 4, '11/8/2006');
INSERT INTO person VALUES(2165, 'Diana', 'Bradov�','F', '53',  40000, 2, '23.11.2012');
INSERT INTO person VALUES(2166, 'Slavom�r', 'Koubek ','M', '27',  32000, 2, '12/12/2005');
INSERT INTO person VALUES(2167, 'Radka', '�i�kov�','F', '37',  40000, 4, '29.1.2008');
INSERT INTO person VALUES(2168, 'Mikul�', 'Va�ek ','M', '51',  42000, 4, '20/11/2013');
INSERT INTO person VALUES(2169, 'Vanda', 'Volkov�','F', '46',  27000, 1, '2.4.2015');
INSERT INTO person VALUES(2170, 'Erik', 'Pivo?ka ','M', '33',  47000, 1, '23/3/2013');
INSERT INTO person VALUES(2171, 'Ilona', '�emli?kov�','F', '30',  27000, 4, '6.6.2010');
INSERT INTO person VALUES(2172, 'Bronislav', 'Schmidt ','M', '56',  20000, 4, '5/10/2004');
INSERT INTO person VALUES(2173, 'Zlata', 'Sou?kov�','F', '38',  15000, 1, '8.8.2017');
INSERT INTO person VALUES(2174, 'Bed?ich', 'Bl�ha ','M', '38',  25000, 1, '7/2/2004');
INSERT INTO person VALUES(2175, 'Vilma', 'Pickov�','F', '46',  31000, 2, '26.9.2006');
INSERT INTO person VALUES(2176, 'Luk�', 'Kova?�k ','M', '21',  30000, 2, '10/5/2016');
INSERT INTO person VALUES(2177, 'Aloisie', 'Be?v�?ov�','F', '31',  38000, 1, '23.7.2003');
INSERT INTO person VALUES(2178, 'Bohuslav', 'Homolka ','M', '43',  40000, 1, '18/5/2011');
INSERT INTO person VALUES(2179, 'D�a', 'Michalcov�','F', '62',  46000, 4, '11.10.2016');
INSERT INTO person VALUES(2180, 'Arno�t', 'Sad�lek ','M', '20',  13000, 4, '26/5/2006');
INSERT INTO person VALUES(2181, 'Nikola', 'Pluha?ov�','F', '25',  34000, 2, '21.7.2007');
INSERT INTO person VALUES(2182, 'Ren�', 'Hlav�?ek ','M', '48',  17000, 2, '26/9/2005');
INSERT INTO person VALUES(2183, 'Aloisie', 'Majerov�','F', '55',  33000, 4, '18.2.2019');
INSERT INTO person VALUES(2184, 'Marcel', 'Chlup ','M', '25',  27000, 4, '4/9/2013');
INSERT INTO person VALUES(2185, 'Denisa', 'Vojt?chov�','F', '64',  21000, 1, '26.11.2009');
INSERT INTO person VALUES(2186, 'Ivo', 'Mar��lek ','M', '53',  32000, 1, '5/1/2013');
INSERT INTO person VALUES(2187, '�t?p�nka', 'B�rtov�','F', '25',  37000, 2, '9.6.2015');
INSERT INTO person VALUES(2188, 'Maxmili�n', 'Balcar ','M', '36',  37000, 2, '13/11/2008');
INSERT INTO person VALUES(2189, 'Vladim�ra', '�ev?�kov�','F', '56',  45000, 1, '4.4.2012');
INSERT INTO person VALUES(2190, 'Vojt?ch', 'Zv??ina ','M', '58',  46000, 1, '22/11/2003');
INSERT INTO person VALUES(2191, 'Antonie', 'Kle?kov�','F', '64',  25000, 2, '16.10.2017');
INSERT INTO person VALUES(2192, 'Zolt�n', 'R�c ','M', '41',  16000, 2, '23/2/2016');
INSERT INTO person VALUES(2193, 'Vendula', 'Strouhalov�','F', '49',  32000, 1, '12.8.2014');
INSERT INTO person VALUES(2194, 'Miroslav', 'Jedli?ka ','M', '63',  25000, 1, '2/3/2011');
INSERT INTO person VALUES(2195, 'So?a', 'Vorlov�','F', '35',  40000, 4, '8.6.2011');
INSERT INTO person VALUES(2196, 'Mat?j', 'Sojka ','M', '40',  34000, 4, '10/3/2006');
INSERT INTO person VALUES(2197, 'Antonie', '�ebestov�','F', '42',  20000, 1, '19.12.2016');
INSERT INTO person VALUES(2198, 'Artur', 'Hron ','M', '23',  39000, 1, '11/6/2018');
INSERT INTO person VALUES(2199, 'Yveta', 'Spurn�','F', '50',  44000, 2, '28.9.2007');
INSERT INTO person VALUES(2200, 'Gerhard', 'Stupka ','M', '51',  44000, 2, '12/10/2017');
INSERT INTO person VALUES(2201, 'Nela', 'Peroutkov�','F', '35',  43000, 1, '27.4.2019');
INSERT INTO person VALUES(2202, 'Walter', 'Matys ','M', '28',  18000, 1, '27/4/2009');
INSERT INTO person VALUES(2203, 'Tati�na', 'Urbanov�','F', '43',  31000, 2, '3.2.2010');
INSERT INTO person VALUES(2204, 'Cyril', 'Mina?�k ','M', '56',  22000, 2, '28/8/2008');
INSERT INTO person VALUES(2205, 'Zlatu�e', 'Hor�kov�','F', '29',  39000, 1, '30.11.2006');
INSERT INTO person VALUES(2206, 'Herbert', 'Hrbek ','M', '32',  31000, 1, '5/9/2003');
INSERT INTO person VALUES(2207, 'Lenka', 'Kotl�rov�','F', '36',  19000, 2, '12.6.2012');
INSERT INTO person VALUES(2208, 'Julius', 'Schejbal ','M', '61',  37000, 2, '8/12/2015');
INSERT INTO person VALUES(2209, 'Tati�na', 'Vojt�kov�','F', '21',  26000, 1, '8.4.2009');
INSERT INTO person VALUES(2210, 'J�lius', 'Bar�k ','M', '38',  46000, 1, '15/12/2010');
INSERT INTO person VALUES(2211, 'Zde?ka', '?eh�kov�','F', '29',  42000, 1, '20.10.2014');
INSERT INTO person VALUES(2212, 'Tade�', 'H�na ','M', '20',  15000, 1, '24/10/2006');
INSERT INTO person VALUES(2213, 'V?ra', 'Kub�kov�','F', '60',  14000, 1, '15.8.2011');
INSERT INTO person VALUES(2214, 'Vili�m', 'Str�nsk� ','M', '43',  24000, 1, '26/3/2018');
INSERT INTO person VALUES(2215, 'Mark�ta', 'J�rov�','F', '21',  29000, 1, '25.2.2017');
INSERT INTO person VALUES(2216, 'Vil�m', 'V�clav�k ','M', '26',  30000, 1, '1/2/2014');
INSERT INTO person VALUES(2217, 'Zde?ka', 'Humlov�','F', '53',  37000, 1, '22.12.2013');
INSERT INTO person VALUES(2218, 'Matou�', 'Svato� ','M', '48',  39000, 1, '9/2/2009');
INSERT INTO person VALUES(2219, 'Eli�ka', '?ervinkov�','F', '60',  17000, 1, '5.7.2019');
INSERT INTO person VALUES(2220, '�t?p�n', 'Nagy ','M', '31',  44000, 1, '18/12/2004');
INSERT INTO person VALUES(2221, 'And?la', 'Kalousov�','F', '23',  41000, 2, '13.4.2010');
INSERT INTO person VALUES(2222, 'Vlastimil', '� astn� ','M', '59',  13000, 2, '21/4/2004');
INSERT INTO person VALUES(2223, 'Sandra', 'Hradeck�','F', '54',  12000, 2, '7.2.2007');
INSERT INTO person VALUES(2224, 'Radom�r', 'Jon� ','M', '35',  22000, 2, '22/9/2015');
INSERT INTO person VALUES(2225, 'Karin', 'Koz�kov�','F', '61',  28000, 2, '20.8.2012');
INSERT INTO person VALUES(2226, 'Michal', '�est�k ','M', '64',  27000, 2, '31/7/2011');
INSERT INTO person VALUES(2227, 'Old?i�ka', 'Such�','F', '47',  36000, 1, '16.6.2009');
INSERT INTO person VALUES(2228, 'Vladislav', 'Klouda ','M', '41',  36000, 1, '8/8/2006');
INSERT INTO person VALUES(2229, 'Nina', 'Zichov�','F', '54',  16000, 2, '28.12.2014');
INSERT INTO person VALUES(2230, 'Nicolas', 'Mat?j�?ek ','M', '24',  42000, 2, '9/11/2018');
INSERT INTO person VALUES(2231, 'Vlastimila', 'Mat?j�?kov�','F', '39',  23000, 1, '23.10.2011');
INSERT INTO person VALUES(2232, 'Ivan', 'Br�zdil ','M', '46',  15000, 1, '16/11/2013');
INSERT INTO person VALUES(2233, 'Miroslava', 'Podzimkov�','F', '48',  47000, 2, '25.12.2018');
INSERT INTO person VALUES(2234, 'Franti�ek', 'Pa?�zek ','M', '28',  19000, 2, '20/3/2013');
INSERT INTO person VALUES(2235, 'Tereza', 'Semer�dov�','F', '33',  19000, 2, '21.10.2015');
INSERT INTO person VALUES(2236, 'Radim', '�im�?ek ','M', '50',  29000, 2, '27/3/2008');
INSERT INTO person VALUES(2237, 'Ludmila', 'Vil�mkov�','F', '19',  26000, 1, '16.8.2012');
INSERT INTO person VALUES(2238, 'Igor', 'Tanco� ','M', '26',  38000, 1, '28/8/2019');
INSERT INTO person VALUES(2239, 'Irena', 'Pelcov�','F', '26',  42000, 2, '27.2.2018');
INSERT INTO person VALUES(2240, 'Daniel', 'Holub ','M', '55',  43000, 2, '7/7/2015');
INSERT INTO person VALUES(2241, 'Monika', 'Hrom�dkov�','F', '58',  14000, 1, '23.12.2014');
INSERT INTO person VALUES(2242, 'Viktor', 'Hradil ','M', '32',  16000, 1, '14/7/2010');
INSERT INTO person VALUES(2243, 'Lada', 'Peroutkov�','F', '20',  38000, 2, '1.10.2005');
INSERT INTO person VALUES(2244, 'Bohumil', 'Zv??ina ','M', '60',  21000, 2, '14/11/2009');
INSERT INTO person VALUES(2245, 'Lidmila', '�afr�nkov�','F', '27',  18000, 3, '14.4.2011');
INSERT INTO person VALUES(2246, '?udov�t', 'R�c ','M', '43',  26000, 3, '23/9/2005');
INSERT INTO person VALUES(2247, 'Ivona', 'Kub�nov�','F', '59',  25000, 2, '8.2.2008');
INSERT INTO person VALUES(2248, 'Stanislav', 'Jedli?ka ','M', '19',  35000, 2, '23/2/2017');
INSERT INTO person VALUES(2249, 'Lada', 'Hradilov�','F', '44',  33000, 1, '4.12.2004');
INSERT INTO person VALUES(2250, 'Kamil', 'Sojka ','M', '41',  44000, 1, '2/3/2012');
INSERT INTO person VALUES(2251, 'Diana', 'Urbancov�','F', '52',  13000, 2, '17.6.2010');
INSERT INTO person VALUES(2252, 'Po?et', 'Dudek ','M', '24',  14000, 2, '10/1/2008');
INSERT INTO person VALUES(2253, 'Viktorie', 'R�cov�','F', '37',  20000, 1, '12.4.2007');
INSERT INTO person VALUES(2254, 'Jind?ich', 'Peroutka ','M', '47',  23000, 1, '12/6/2019');
INSERT INTO person VALUES(2255, 'Vanda', 'Smr?kov�','F', '44',  36000, 2, '23.10.2012');
INSERT INTO person VALUES(2256, 'Gejza', 'Matys ','M', '30',  28000, 2, '21/4/2015');
INSERT INTO person VALUES(2257, 'Krist�na', 'Richtrov�','F', '53',  24000, 3, '2.8.2003');
INSERT INTO person VALUES(2258, 'Sebastian', 'Mina?�k ','M', '58',  33000, 3, '22/8/2014');
INSERT INTO person VALUES(2259, 'Dagmar', 'Humlov�','F', '38',  32000, 2, '21.10.2016');
INSERT INTO person VALUES(2260, 'Ernest', 'Hrbek ','M', '34',  42000, 2, '29/8/2009');
INSERT INTO person VALUES(2261, 'Gabriela', '?ervinkov�','F', '46',  12000, 3, '9.12.2005');
INSERT INTO person VALUES(2262, 'Nikolas', 'Schejbal ','M', '63',  47000, 3, '8/7/2005');
INSERT INTO person VALUES(2263, 'Olga', 'Van�?kov�','F', '31',  19000, 2, '28.2.2019');
INSERT INTO person VALUES(2264, 'Vladan', 'Bar�k ','M', '39',  20000, 2, '8/12/2016');
INSERT INTO person VALUES(2265, 'Karol�na', 'Hrd�','F', '38',  35000, 2, '17.4.2008');
INSERT INTO person VALUES(2266, 'Andrej', '�im?�k ','M', '22',  26000, 2, '16/10/2012');
INSERT INTO person VALUES(2267, 'Nikola', 'Zedn�kov�','F', '24',  43000, 2, '10.2.2005');
INSERT INTO person VALUES(2268, '?ubom�r', 'Nov�?ek ','M', '44',  35000, 2, '25/10/2007');
INSERT INTO person VALUES(2269, 'Kamila', 'C�sa?ov�','F', '31',  22000, 2, '24.8.2010');
INSERT INTO person VALUES(2270, 'Svatopluk', 'V�clav�k ','M', '27',  40000, 2, '2/9/2003');
INSERT INTO person VALUES(2271, 'Denisa', 'Votavov�','F', '62',  30000, 2, '20.6.2007');
INSERT INTO person VALUES(2272, 'Jon�', 'Svato� ','M', '50',  13000, 2, '2/2/2015');
INSERT INTO person VALUES(2273, 'Nata�a', 'Mat?j�?kov�','F', '25',  18000, 3, '22.8.2014');
INSERT INTO person VALUES(2274, 'Pavol', 'H�bl ','M', '32',  18000, 3, '6/6/2014');
INSERT INTO person VALUES(2275, 'Vladim�ra', 'Mach�?ov�','F', '55',  18000, 1, '27.10.2009');
INSERT INTO person VALUES(2276, 'Mari�n', 'Tvrd�k ','M', '55',  28000, 1, '19/12/2005');
INSERT INTO person VALUES(2277, 'Ester', 'Hork�','F', '64',  41000, 2, '29.12.2016');
INSERT INTO person VALUES(2278, 'Bohum�r', 'Jon� ','M', '37',  32000, 2, '21/4/2005');
INSERT INTO person VALUES(2279, 'Al�beta', 'Kri�tofov�','F', '25',  21000, 3, '16.2.2006');
INSERT INTO person VALUES(2280, 'Vojt?ch', 'Doubek ','M', '20',  38000, 3, '24/7/2017');
INSERT INTO person VALUES(2281, 'Regina', 'Kalov�','F', '56',  29000, 2, '8.5.2019');
INSERT INTO person VALUES(2282, 'Eduard', 'Pa�ek ','M', '42',  47000, 2, '31/7/2012');
INSERT INTO person VALUES(2283, 'Be�ta', 'Karasov�','F', '64',  45000, 3, '25.6.2008');
INSERT INTO person VALUES(2284, 'Miroslav', 'Mat?j�?ek ','M', '25',  16000, 3, '9/6/2008');
INSERT INTO person VALUES(2285, 'Yveta', 'Ma?�kov�','F', '49',  16000, 2, '20.4.2005');
INSERT INTO person VALUES(2286, 'Mat?j', 'Br�zdil ','M', '47',  25000, 2, '10/11/2019');
INSERT INTO person VALUES(2287, 'Bed?i�ka', 'Muchov�','F', '35',  24000, 1, '10.7.2018');
INSERT INTO person VALUES(2288, 'Leo�', 'Divi� ','M', '24',  34000, 1, '17/11/2014');
INSERT INTO person VALUES(2289, 'Be�ta', 'Dittrichov�','F', '42',  40000, 2, '28.8.2007');
INSERT INTO person VALUES(2290, 'Radek', 'Pelik�n ','M', '53',  40000, 2, '26/9/2010');
INSERT INTO person VALUES(2291, 'Kv?ta', 'Mr�zov�','F', '50',  28000, 3, '30.10.2014');
INSERT INTO person VALUES(2292, 'Petr', 'Kubi� ','M', '35',  44000, 3, '27/1/2010');
INSERT INTO person VALUES(2293, 'Lenka', 'Studen�','F', '35',  27000, 2, '4.1.2010');
INSERT INTO person VALUES(2294, 'Josef', 'Vrabec ','M', '58',  18000, 2, '5/1/2018');
INSERT INTO person VALUES(2295, 'Silvie 7300', 'Kulhav�','F', '43',  15000, 3, '8.3.2017');
INSERT INTO person VALUES(2296, 'Vladimir', 'Jane?ek ','M', '40',  23000, 3, '8/5/2017');
INSERT INTO person VALUES(2297, 'Veronika', 'Matou�kov�','F', '27',  15000, 2, '12.5.2012');
INSERT INTO person VALUES(2298, '?udov�t', 'Ka?a ','M', '63',  33000, 2, '20/11/2008');
INSERT INTO person VALUES(2299, 'Bohuslava', 'Hudcov�','F', '36',  39000, 3, '15.7.2019');
INSERT INTO person VALUES(2300, 'J�lius', 'Z�ruba ','M', '45',  37000, 3, '24/3/2008');
INSERT INTO person VALUES(2301, 'Silvie 7300', 'Skalick�','F', '21',  46000, 2, '10.5.2016');
INSERT INTO person VALUES(2302, 'Zd?nek', 'Flori�n ','M', '22',  46000, 2, '25/8/2019');
INSERT INTO person VALUES(2303, 'Sandra', 'Jaklov�','F', '29',  26000, 3, '28.6.2005');
INSERT INTO person VALUES(2304, 'Vili�m', 'Kaiser ','M', '51',  16000, 3, '3/7/2015');
INSERT INTO person VALUES(2305, 'Margita', 'He?m�nkov�','F', '60',  34000, 2, '17.9.2018');
INSERT INTO person VALUES(2306, 'Nikola', 'Kratochv�l ','M', '27',  25000, 2, '11/7/2010');
INSERT INTO person VALUES(2307, 'And?la', 'Chmela?ov�','F', '21',  14000, 2, '5.11.2007');
INSERT INTO person VALUES(2308, 'Slavom�r', 'Hor�?ek ','M', '56',  30000, 2, '19/5/2006');
INSERT INTO person VALUES(2309, 'Sandra', 'Pol�chov�','F', '53',  21000, 2, '31.8.2004');
INSERT INTO person VALUES(2310, 'R�bert', 'Kr�l�k ','M', '32',  39000, 2, '19/10/2017');
INSERT INTO person VALUES(2311, 'Helena', 'Michal�kov�','F', '61',  45000, 3, '2.11.2011');
INSERT INTO person VALUES(2312, 'Ferdinand', 'Ba�ant ','M', '60',  44000, 3, '20/2/2017');
INSERT INTO person VALUES(2313, 'Barbora', 'Hradilov�','F', '23',  25000, 3, '15.5.2017');
INSERT INTO person VALUES(2314, 'Radom�r', 'Kamen�k ','M', '43',  13000, 3, '29/12/2012');
INSERT INTO person VALUES(2315, 'Bo�ena', 'Siv�kov�','F', '54',  32000, 3, '11.3.2014');
INSERT INTO person VALUES(2316, '?estm�r', 'Ko?�nek ','M', '19',  22000, 3, '6/1/2008');
INSERT INTO person VALUES(2317, 'Ludmila', 'K?�kov�','F', '40',  40000, 2, '5.1.2011');
INSERT INTO person VALUES(2318, 'Imrich', 'Vale� ','M', '42',  32000, 2, '9/6/2019');
INSERT INTO person VALUES(2319, 'Nikol', 'Voln�','F', '48',  28000, 3, '9.3.2018');
INSERT INTO person VALUES(2320, 'Bohdan', '�im?�k ','M', '24',  36000, 3, '10/10/2018');
INSERT INTO person VALUES(2321, 'Karla', 'Dvorsk�','F', '33',  36000, 3, '3.1.2015');
INSERT INTO person VALUES(2322, 'Tobi�', 'Nov�?ek ','M', '46',  45000, 3, '17/10/2013');
INSERT INTO person VALUES(2323, 'Adriana', 'Prokopov�','F', '41',  15000, 3, '21.2.2004');
INSERT INTO person VALUES(2324, 'Mojm�r', 'V�clav�k ','M', '29',  15000, 3, '26/8/2009');
INSERT INTO person VALUES(2325, 'Magdal�na', 'Fi�erov�','F', '26',  23000, 2, '11.5.2017');
INSERT INTO person VALUES(2326, 'Kristi�n', 'Svato� ','M', '51',  24000, 2, '2/9/2004');
INSERT INTO person VALUES(2327, 'Bronislava', 'Sekaninov�','F', '33',  39000, 3, '29.6.2006');
INSERT INTO person VALUES(2328, 'P?emysl', 'Nagy ','M', '34',  29000, 3, '5/12/2016');
INSERT INTO person VALUES(2329, 'Adriana', 'Horsk�','F', '19',  47000, 2, '18.9.2019');
INSERT INTO person VALUES(2330, 'Leopold', 'Tvrd�k ','M', '57',  38000, 2, '13/12/2011');
INSERT INTO person VALUES(2331, 'Petra', 'Dittrichov�','F', '27',  34000, 3, '27.6.2010');
INSERT INTO person VALUES(2332, 'Lum�r', 'Jon� ','M', '39',  43000, 3, '15/4/2011');
INSERT INTO person VALUES(2333, 'Laura', 'Reme�ov�','F', '59',  42000, 3, '23.4.2007');
INSERT INTO person VALUES(2334, 'Leo', 'Schmidt ','M', '61',  16000, 3, '22/4/2006');
INSERT INTO person VALUES(2335, 'Michaela', 'Studen�','F', '20',  22000, 3, '3.11.2012');
INSERT INTO person VALUES(2336, 'Vratislav', 'Pa�ek ','M', '44',  21000, 3, '25/7/2018');
INSERT INTO person VALUES(2337, 'Kate?ina', 'Srbov�','F', '52',  30000, 3, '29.8.2009');
INSERT INTO person VALUES(2338, 'Mikul�', 'Kuchta ','M', '20',  30000, 3, '1/8/2013');
INSERT INTO person VALUES(2339, 'Dana', 'Matou�kov�','F', '59',  45000, 3, '12.3.2015');
INSERT INTO person VALUES(2340, 'Kamil', 'Br�zdil ','M', '49',  36000, 3, '10/6/2009');
INSERT INTO person VALUES(2341, 'Michaela', 'Pol�kov�','F', '44',  17000, 2, '6.1.2012');
INSERT INTO person VALUES(2342, 'Erik', 'Divi� ','M', '25',  45000, 2, '17/6/2004');
INSERT INTO person VALUES(2343, 'Krist�na', 'Jurkov�','F', '52',  33000, 3, '19.7.2017');
INSERT INTO person VALUES(2344, 'Milo�', 'Pelik�n ','M', '54',  14000, 3, '18/9/2016');
INSERT INTO person VALUES(2345, 'Dagmar', 'Smolov�','F', '37',  40000, 2, '15.5.2014');
INSERT INTO person VALUES(2346, 'Bed?ich', 'Andrle ','M', '31',  23000, 2, '27/9/2011');
INSERT INTO person VALUES(2347, 'Darina', 'He?m�nkov�','F', '46',  28000, 3, '21.2.2005');
INSERT INTO person VALUES(2348, 'Bohuslav', 'Holub ','M', '59',  28000, 3, '28/1/2011');
INSERT INTO person VALUES(2349, 'Jarom�ra', 'Chmela?ov�','F', '53',  44000, 4, '4.9.2010');
INSERT INTO person VALUES(2350, 'Kevin', 'Jane?ek ','M', '42',  33000, 4, '6/12/2006');
INSERT INTO person VALUES(2351, 'Milu�ka', 'Pol�chov�','F', '38',  16000, 3, '30.6.2007');
INSERT INTO person VALUES(2352, 'Libor', 'Homola ','M', '64',  42000, 3, '9/5/2018');
INSERT INTO person VALUES(2353, 'Valerie', 'Dole�alov�','F', '46',  32000, 4, '10.1.2013');
INSERT INTO person VALUES(2354, 'Vladan', 'Z�ruba ','M', '47',  12000, 4, '17/3/2014');
INSERT INTO person VALUES(2355, 'Jarom�ra', 'Novotn�','F', '31',  39000, 3, '6.11.2009');
INSERT INTO person VALUES(2356, 'V�clav', 'Flori�n ','M', '23',  21000, 3, '24/3/2009');
INSERT INTO person VALUES(2357, 'Gertruda', 'Holcov�','F', '38',  19000, 3, '20.5.2015');
INSERT INTO person VALUES(2358, 'Norbert', 'Kaiser ','M', '52',  26000, 3, '31/1/2005');
INSERT INTO person VALUES(2359, 'Nata�a', 'Sk?iv�nkov�','F', '24',  27000, 3, '15.3.2012');
INSERT INTO person VALUES(2360, 'Maxmili�n', 'Kratochv�l ','M', '29',  35000, 3, '3/7/2016');
INSERT INTO person VALUES(2361, 'Zdenka', 'Votrubov�','F', '32',  15000, 4, '18.5.2019');
INSERT INTO person VALUES(2362, 'Zolt�n', 'Ha�ek ','M', '57',  40000, 4, '5/11/2015');
INSERT INTO person VALUES(2363, 'Ester', '�t?p�nov�','F', '63',  14000, 3, '23.7.2014');
INSERT INTO person VALUES(2364, 'Vasil', 'Kr�l�k ','M', '34',  14000, 3, '20/5/2007');
INSERT INTO person VALUES(2365, 'Daniela', 'Vondrov�','F', '25',  38000, 4, '30.4.2005');
INSERT INTO person VALUES(2366, 'Radomil', 'Ba�ant ','M', '62',  18000, 4, '20/9/2006');
INSERT INTO person VALUES(2367, 'Regina', 'J�nsk�','F', '55',  38000, 2, '28.11.2016');
INSERT INTO person VALUES(2368, 'Albert', 'Stoklasa ','M', '39',  28000, 2, '29/8/2014');
INSERT INTO person VALUES(2369, 'Ane�ka', 'Braunov�','F', '64',  25000, 4, '7.9.2007');
INSERT INTO person VALUES(2370, 'Oto', 'Ko?�nek ','M', '21',  33000, 4, '30/12/2013');
INSERT INTO person VALUES(2371, 'Sabina', 'Jan�?kov�','F', '25',  41000, 4, '20.3.2013');
INSERT INTO person VALUES(2372, 'Eduard', 'Ondr�?ek ','M', '50',  38000, 4, '8/11/2009');
INSERT INTO person VALUES(2373, 'M�ria', 'Folt�nov�','F', '57',  13000, 3, '14.1.2010');
INSERT INTO person VALUES(2374, 'Juraj', 'Fridrich ','M', '26',  47000, 3, '15/11/2004');
INSERT INTO person VALUES(2375, 'Ane�ka', 'Gajdo�ov�','F', '42',  21000, 3, '10.11.2006');
INSERT INTO person VALUES(2376, 'Cyril', 'Janota ','M', '49',  20000, 3, '17/4/2016');
INSERT INTO person VALUES(2377, 'Kv?ta', 'Havlov�','F', '49',  36000, 3, '23.5.2012');
INSERT INTO person VALUES(2378, 'Marian', 'Ho?ej�� ','M', '32',  26000, 3, '25/2/2012');
INSERT INTO person VALUES(2379, 'Ren�ta', 'M�llerov�','F', '35',  44000, 3, '18.3.2009');
INSERT INTO person VALUES(2380, 'Julius', 'N?me?ek ','M', '54',  35000, 3, '4/3/2007');
INSERT INTO person VALUES(2381, 'S�ra', 'Hrb�?kov�','F', '42',  24000, 3, '29.9.2014');
INSERT INTO person VALUES(2382, '�tefan', 'Brabec ','M', '37',  40000, 3, '5/6/2019');
INSERT INTO person VALUES(2383, 'Natalie', 'Neradov�','F', '50',  12000, 4, '8.7.2005');
INSERT INTO person VALUES(2384, 'Patrik', 'Vo?�ek ','M', '19',  45000, 4, '7/10/2018');
INSERT INTO person VALUES(2385, 'Miriam', 'Grygarov�','F', '36',  19000, 4, '27.9.2018');
INSERT INTO person VALUES(2386, 'Vil�m', 'Dosko?il ','M', '41',  18000, 4, '14/10/2013');
INSERT INTO person VALUES(2387, 'Hana', '�v�bov�','F', '43',  35000, 4, '15.11.2007');
INSERT INTO person VALUES(2388, 'Jakub', 'Paul ','M', '24',  23000, 4, '22/8/2009');
INSERT INTO person VALUES(2389, 'Zita', 'Bedna?�kov�','F', '29',  43000, 3, '10.9.2004');
INSERT INTO person VALUES(2390, 'V�t', 'Majer ','M', '46',  32000, 3, '30/8/2004');
INSERT INTO person VALUES(2391, 'Jitka', 'Hrub�','F', '36',  23000, 4, '24.3.2010');
INSERT INTO person VALUES(2392, 'Svatoslav', 'Hanzl�k ','M', '29',  38000, 4, '1/12/2016');
INSERT INTO person VALUES(2393, 'Anna', 'Moravcov�','F', '21',  30000, 3, '17.1.2007');
INSERT INTO person VALUES(2394, 'Vlastimil', 'Vorel ','M', '52',  47000, 3, '10/12/2011');
INSERT INTO person VALUES(2395, 'Bo�ena', 'Kazdov�','F', '29',  46000, 4, '30.7.2012');
INSERT INTO person VALUES(2396, 'Stepan', 'Fo?t ','M', '35',  16000, 4, '18/10/2007');
INSERT INTO person VALUES(2397, 'Helena', 'Pe?inov�','F', '60',  18000, 3, '26.5.2009');
INSERT INTO person VALUES(2398, 'Vladim�r', 'Kubica ','M', '57',  25000, 3, '20/3/2019');
INSERT INTO person VALUES(2399, 'Leona', 'Mac�kov�','F', '23',  42000, 4, '28.7.2016');
INSERT INTO person VALUES(2400, 'Nicolas', 'Plach� ','M', '39',  30000, 4, '22/7/2018');
INSERT INTO person VALUES(2401, 'Bo�ena', '��mov�','F', '53',  41000, 3, '3.10.2011');
INSERT INTO person VALUES(2402, 'Ernest', '��?ek ','M', '62',  40000, 3, '3/2/2010');
INSERT INTO person VALUES(2403, 'Dita', 'Horv�tov�','F', '61',  29000, 4, '5.12.2018');
INSERT INTO person VALUES(2404, 'Oskar', 'Holoubek ','M', '44',  44000, 4, '6/6/2009');
INSERT INTO person VALUES(2405, 'Jindra', 'Pol�kov�','F', '23',  45000, 4, '23.1.2008');
INSERT INTO person VALUES(2406, '?estm�r', '�im�nek ','M', '27',  14000, 4, '15/4/2005');
INSERT INTO person VALUES(2407, 'Elena', 'Bene�ov�','F', '54',  17000, 4, '18.11.2004');
INSERT INTO person VALUES(2408, 'Imrich', 'Dole�al ','M', '50',  23000, 4, '15/9/2016');
INSERT INTO person VALUES(2409, 'Ema', 'Smolov�','F', '61',  32000, 4, '1.6.2010');
INSERT INTO person VALUES(2410, 'Arno�t', 'Nguyen ','M', '32',  28000, 4, '25/7/2012');
INSERT INTO person VALUES(2411, 'Michala', 'Schejbalov�','F', '47',  40000, 4, '27.3.2007');
INSERT INTO person VALUES(2412, 'Ondrej', 'Zelen� ','M', '55',  37000, 4, '2/8/2007');
INSERT INTO person VALUES(2413, 'Johana', 'J�lkov�','F', '54',  20000, 4, '7.10.2012');
INSERT INTO person VALUES(2414, 'Marcel', 'Vondra ','M', '38',  43000, 4, '3/11/2019');
INSERT INTO person VALUES(2415, 'Ema', 'Hlad�kov�','F', '40',  27000, 3, '3.8.2009');
INSERT INTO person VALUES(2416, 'Pavol', 'Pohl ','M', '60',  16000, 3, '11/11/2014');
INSERT INTO person VALUES(2417, 'Iveta', 'Sp�?ilov�','F', '48',  15000, 1, '5.10.2016');
INSERT INTO person VALUES(2418, 'Bohumir', 'B?ezina ','M', '42',  20000, 1, '14/3/2014');
INSERT INTO person VALUES(2419, 'Tamara', 'Fuksov�','F', '32',  15000, 3, '11.12.2011');
INSERT INTO person VALUES(2420, 'Bohum�r', 'Vesel� ','M', '19',  30000, 3, '26/9/2005');
INSERT INTO person VALUES(2421, 'Ad�la', 'Chlupov�','F', '41',  39000, 4, '12.2.2019');
INSERT INTO person VALUES(2422, 'Emil', 'Zach ','M', '47',  35000, 4, '28/1/2005');
INSERT INTO person VALUES(2423, 'Marika', 'V�tov�','F', '25',  38000, 3, '18.4.2014');
INSERT INTO person VALUES(2424, 'Eduard', 'Kola?�k ','M', '25',  45000, 3, '5/1/2013');
INSERT INTO person VALUES(2425, 'Aneta', 'Fu?�kov�','F', '34',  26000, 4, '25.1.2005');
INSERT INTO person VALUES(2426, 'Robert', '�emli?ka ','M', '53',  13000, 4, '8/5/2012');
INSERT INTO person VALUES(2427, 'Ad�la', 'Smolkov�','F', '19',  34000, 4, '16.4.2018');
INSERT INTO person VALUES(2428, 'Radovan', '�vec ','M', '29',  22000, 4, '17/5/2007');
INSERT INTO person VALUES(2429, 'Drahom�ra', '�pa?kov�','F', '26',  14000, 4, '4.6.2007');
INSERT INTO person VALUES(2430, 'Anton�n', 'Kov�? ','M', '58',  28000, 4, '18/8/2019');
INSERT INTO person VALUES(2431, 'Romana', 'Kub�?kov�','F', '58',  21000, 3, '30.3.2004');
INSERT INTO person VALUES(2432, 'Jozef', 'Machala ','M', '34',  37000, 3, '26/8/2014');
INSERT INTO person VALUES(2433, 'Ladislava', 'Pohlov�','F', '19',  37000, 4, '11.10.2009');
INSERT INTO person VALUES(2434, 'Petr', 'Synek ','M', '63',  42000, 4, '4/7/2010');
INSERT INTO person VALUES(2435, 'Drahom�ra', 'Rakov�','F', '50',  45000, 3, '7.8.2006');
INSERT INTO person VALUES(2436, 'Lubom�r', '�enk ','M', '39',  15000, 3, '11/7/2005');
INSERT INTO person VALUES(2437, 'Kristina', 'Bauerov�','F', '58',  25000, 4, '18.2.2012');
INSERT INTO person VALUES(2438, 'Vladimir', 'Kri�tof ','M', '22',  21000, 4, '13/10/2017');
INSERT INTO person VALUES(2439, 'Radana', 'Gajdo�ov�','F', '20',  13000, 1, '21.4.2019');
INSERT INTO person VALUES(2440, 'Juli�s', 'Luk� ','M', '50',  25000, 1, '13/2/2017');
INSERT INTO person VALUES(2441, 'Magdal�na', 'Kr�kov�','F', '50',  12000, 4, '26.6.2014');
INSERT INTO person VALUES(2442, 'J�lius', 'Mr�zek ','M', '28',  35000, 4, '29/8/2008');
INSERT INTO person VALUES(2443, 'Laura', 'M�llerov�','F', '59',  36000, 1, '4.4.2005');
INSERT INTO person VALUES(2444, 'Viliam', 'Ors�g ','M', '56',  40000, 1, '31/12/2007');
INSERT INTO person VALUES(2445, 'Nicole', 'Hru�kov�','F', '44',  44000, 4, '24.6.2018');
INSERT INTO person VALUES(2446, 'Bruno', 'Lev� ','M', '32',  13000, 4, '2/6/2019');
INSERT INTO person VALUES(2447, 'Petra', 'Hu�kov�','F', '52',  23000, 4, '12.8.2007');
INSERT INTO person VALUES(2448, 'Matou�', 'Maz�nek ','M', '61',  18000, 4, '11/4/2015');
INSERT INTO person VALUES(2449, 'Brigita', 'Slaninov�','F', '37',  31000, 4, '7.6.2004');
INSERT INTO person VALUES(2450, 'Hubert', 'Mr�z ','M', '37',  27000, 4, '18/4/2010');
INSERT INTO person VALUES(2451, 'Michaela', 'Slez�kov�','F', '44',  47000, 4, '19.12.2009');
INSERT INTO person VALUES(2452, 'Hynek', 'Mare?ek ','M', '20',  33000, 4, '24/2/2006');
INSERT INTO person VALUES(2453, 'Kate?ina', 'Tomkov�','F', '30',  19000, 4, '14.10.2006');
INSERT INTO person VALUES(2454, 'Ferdinand', 'Folt�n ','M', '43',  42000, 4, '28/7/2017');
INSERT INTO person VALUES(2455, 'Dagmar', '�krabalov�','F', '37',  34000, 4, '26.4.2012');
INSERT INTO person VALUES(2456, 'Radom�r', 'Sk�cel ','M', '25',  47000, 4, '5/6/2013');
INSERT INTO person VALUES(2457, 'Jarmila', '?eh�?kov�','F', '23',  42000, 3, '20.2.2009');
INSERT INTO person VALUES(2458, '?estm�r', 'Severa ','M', '48',  20000, 3, '12/6/2008');
INSERT INTO person VALUES(2459, 'Terezie', 'Kov�?ov�','F', '31',  30000, 1, '24.4.2016');
INSERT INTO person VALUES(2460, 'Kry�tof', 'Seidl ','M', '30',  25000, 1, '15/10/2007');
INSERT INTO person VALUES(2461, 'Milu�ka', 'Pe?inov�','F', '38',  46000, 1, '12.6.2005');
INSERT INTO person VALUES(2462, 'Ivan', 'Van??ek ','M', '59',  30000, 1, '23/8/2003');
INSERT INTO person VALUES(2463, 'Svatava', 'Hoffmannov�','F', '24',  17000, 4, '1.9.2018');
INSERT INTO person VALUES(2464, 'Ludv�k', 'Jirou�ek ','M', '35',  39000, 4, '24/1/2015');
INSERT INTO person VALUES(2465, 'Josefa', 'Dokoupilov�','F', '55',  25000, 4, '27.6.2015');
INSERT INTO person VALUES(2466, 'Mojm�r', 'Kub�nek ','M', '57',  12000, 4, '31/1/2010');
INSERT INTO person VALUES(2467, 'Milu�ka', 'B?ezinov�','F', '63',  41000, 4, '14.8.2004');
INSERT INTO person VALUES(2468, 'Richard', 'Male?ek ','M', '40',  18000, 4, '9/12/2005');
INSERT INTO person VALUES(2469, 'Svatava', 'Hrdli?kov�','F', '48',  12000, 4, '3.11.2017');
INSERT INTO person VALUES(2470, 'P?emysl', 'Pech ','M', '63',  27000, 4, '12/5/2017');
INSERT INTO person VALUES(2471, 'Zdena', 'Mirgov�','F', '55',  28000, 4, '22.12.2006');
INSERT INTO person VALUES(2472, 'Miloslav', '�ubrt ','M', '46',  32000, 4, '20/3/2013');
INSERT INTO person VALUES(2473, 'Pavla', 'J�chov�','F', '64',  16000, 1, '23.2.2014');
INSERT INTO person VALUES(2474, 'Pavel', 'Knap ','M', '28',  37000, 1, '21/7/2012');
INSERT INTO person VALUES(2475, 'Zuzana', 'Zdr�halov�','F', '49',  24000, 1, '20.12.2010');
INSERT INTO person VALUES(2476, 'Bohumil', 'V�tek ','M', '50',  46000, 1, '30/7/2007');
INSERT INTO person VALUES(2477, 'Zdenka', 'Peckov�','F', '57',  40000, 1, '2.7.2016');
INSERT INTO person VALUES(2478, 'Rastislav', 'P?ibyl ','M', '33',  15000, 1, '31/10/2019');
INSERT INTO person VALUES(2479, 'Pavla', 'Brychtov�','F', '42',  47000, 4, '28.4.2013');
INSERT INTO person VALUES(2480, 'Roman', 'Ferenc ','M', '55',  24000, 4, '7/11/2014');
INSERT INTO person VALUES(2481, 'Iva', 'Han�kov�','F', '49',  27000, 1, '9.11.2018');
INSERT INTO person VALUES(2482, 'Erv�n', 'Fischer ','M', '38',  30000, 1, '16/9/2010');
INSERT INTO person VALUES(2483, 'Milada', 'Tom�kov�','F', '35',  35000, 4, '4.9.2015');
INSERT INTO person VALUES(2484, 'Ji?�', 'Sladk� ','M', '60',  39000, 4, '23/9/2005');
INSERT INTO person VALUES(2485, 'Vlastimila', 'Ferencov�','F', '43',  23000, 1, '13.6.2006');
INSERT INTO person VALUES(2486, 'Gejza', 'Zaj�?ek ','M', '42',  44000, 1, '24/1/2005');
INSERT INTO person VALUES(2487, 'Iva', 'Vor�?kov�','F', '27',  22000, 4, '11.1.2018');
INSERT INTO person VALUES(2488, 'Vojtech', '�ev?�k ','M', '20',  17000, 4, '2/1/2013');
INSERT INTO person VALUES(2489, '�ofie', 'Pohankov�','F', '36',  46000, 1, '20.10.2008');
INSERT INTO person VALUES(2490, 'Sebastian', 'Zl�mal ','M', '48',  22000, 1, '5/5/2012');
INSERT INTO person VALUES(2491, 'Emilie', 'Dudov�','F', '20',  46000, 4, '26.12.2003');
INSERT INTO person VALUES(2492, 'Juli�s', 'Ludv�k ','M', '25',  32000, 4, '19/11/2003');
INSERT INTO person VALUES(2493, 'Patricie', 'He?manov�','F', '29',  33000, 1, '27.2.2011');
INSERT INTO person VALUES(2494, 'Nikolas', 'Semer�d ','M', '53',  36000, 1, '15/8/2019');
INSERT INTO person VALUES(2495, 'Ema', 'Bou�kov�','F', '60',  41000, 4, '23.12.2007');
INSERT INTO person VALUES(2496, 'Vladan', 'Mr�zek ','M', '29',  46000, 4, '22/8/2014');
INSERT INTO person VALUES(2497, 'Oksana', 'Jane?kov�','F', '21',  21000, 1, '5.7.2013');
INSERT INTO person VALUES(2498, 'Tibor', 'Kom�rek ','M', '58',  15000, 1, '1/7/2010');
INSERT INTO person VALUES(2499, 'Johana', 'Krej?ov�','F', '53',  29000, 4, '1.5.2010');
INSERT INTO person VALUES(2500, 'Norbert', 'Cibulka ','M', '35',  24000, 4, '8/7/2005');
INSERT INTO person VALUES(2501, 'B�ra', 'Nagyov�','F', '60',  44000, 1, '12.11.2015');
INSERT INTO person VALUES(2502, 'Denis', 'Ol�h ','M', '64',  29000, 1, '10/10/2017');
INSERT INTO person VALUES(2503, 'Yvona', 'Barto�kov�','F', '46',  16000, 4, '7.9.2012');
INSERT INTO person VALUES(2504, 'Dan', 'Hejna ','M', '40',  38000, 4, '17/10/2012');
INSERT INTO person VALUES(2505, 'Zita', 'Kalinov�','F', '53',  32000, 4, '21.3.2018');
INSERT INTO person VALUES(2506, 'Dalibor', 'Sommer ','M', '23',  44000, 4, '25/8/2008');
INSERT INTO person VALUES(2507, 'Magdalena', '�afa?�kov�','F', '61',  20000, 2, '28.12.2008');
INSERT INTO person VALUES(2508, 'Rostislav', 'Lang ','M', '51',  12000, 2, '28/12/2007');
INSERT INTO person VALUES(2509, 'Danu�e', 'Tom�ov�','F', '47',  27000, 1, '23.10.2005');
INSERT INTO person VALUES(2510, 'Bohum�r', 'Sk�cel ','M', '27',  22000, 1, '30/5/2019');
INSERT INTO person VALUES(2511, 'Hedvika', 'Mare�ov�','F', '54',  43000, 1, '6.5.2011');
INSERT INTO person VALUES(2512, 'Jarom�r', '�irok� ','M', '56',  27000, 1, '7/4/2015');
INSERT INTO person VALUES(2513, 'Magdalena', 'Bla�kov�','F', '40',  15000, 1, '1.3.2008');
INSERT INTO person VALUES(2514, 'Eduard', 'Dittrich ','M', '32',  36000, 1, '15/4/2010');
INSERT INTO person VALUES(2515, 'Nikol', 'Hartmanov�','F', '47',  31000, 1, '12.9.2013');
INSERT INTO person VALUES(2516, 'Tom�', 'Ot�hal ','M', '61',  41000, 1, '21/2/2006');
INSERT INTO person VALUES(2517, 'Karla', 'Mar��kov�','F', '32',  38000, 1, '9.7.2010');
INSERT INTO person VALUES(2518, 'Dominik', 'Jir�sek ','M', '38',  14000, 1, '24/7/2017');
INSERT INTO person VALUES(2519, 'Radana', 'Vit�skov�','F', '41',  26000, 2, '10.9.2017');
INSERT INTO person VALUES(2520, 'Radek', 'Jan? ','M', '20',  19000, 2, '25/11/2016');
INSERT INTO person VALUES(2521, 'Nikol', 'V�lkov�','F', '25',  26000, 4, '15.11.2012');
INSERT INTO person VALUES(2522, 'Marek', 'T�th ','M', '43',  29000, 4, '9/6/2008');
INSERT INTO person VALUES(2523, 'Iryna', 'Mar��lkov�','F', '34',  14000, 2, '25.8.2003');
INSERT INTO person VALUES(2524, 'Petr', 'Du�ek ','M', '25',  34000, 2, '11/10/2007');
INSERT INTO person VALUES(2525, 'Adriana', 'Vyslou�ilov�','F', '64',  13000, 4, '24.3.2015');
INSERT INTO person VALUES(2526, 'Pavel', 'H�na ','M', '48',  43000, 4, '19/9/2015');
INSERT INTO person VALUES(2527, 'Petra', 'Kr�l�?kov�','F', '26',  37000, 1, '31.12.2005');
INSERT INTO person VALUES(2528, 'Vladimir', 'Votava ','M', '30',  12000, 1, '20/1/2015');
INSERT INTO person VALUES(2529, 'Laura', 'Gi?ov�','F', '58',  45000, 1, '22.3.2019');
INSERT INTO person VALUES(2530, 'Jakub', 'Skopal ','M', '52',  21000, 1, '27/1/2010');
INSERT INTO person VALUES(2531, 'Ivana', 'Maty�ov�','F', '19',  25000, 1, '9.5.2008');
INSERT INTO person VALUES(2532, 'J?lius', 'Pernica ','M', '35',  26000, 1, '6/12/2005');
INSERT INTO person VALUES(2533, 'Petra', 'Volkov�','F', '51',  32000, 1, '5.3.2005');
INSERT INTO person VALUES(2534, 'Svatoslav', 'Sobek ','M', '58',  36000, 1, '8/5/2017');
INSERT INTO person VALUES(2535, 'Dana', 'Je?�bkov�','F', '58',  12000, 1, '16.9.2010');
INSERT INTO person VALUES(2536, 'Leo', 'Mare� ','M', '41',  41000, 1, '17/3/2013');
INSERT INTO person VALUES(2537, 'Michaela', 'Sou?kov�','F', '43',  20000, 4, '12.7.2007');
INSERT INTO person VALUES(2538, 'Stepan', 'Kub�n ','M', '63',  14000, 4, '24/3/2008');
INSERT INTO person VALUES(2539, 'Andrea', 'Pickov�','F', '51',  35000, 1, '22.1.2013');
INSERT INTO person VALUES(2540, 'Mikul�', '�est�k ','M', '46',  19000, 1, '1/2/2004');
INSERT INTO person VALUES(2541, 'Maria', 'Gajdo��kov�','F', '59',  23000, 2, '1.11.2003');
INSERT INTO person VALUES(2542, 'Hynek', 'Jur?�k ','M', '28',  24000, 2, '28/10/2019');
INSERT INTO person VALUES(2543, 'Darina', 'Ju?�kov�','F', '44',  31000, 1, '20.1.2017');
INSERT INTO person VALUES(2544, 'Ferdinand', 'Han�k ','M', '50',  33000, 1, '4/11/2014');
INSERT INTO person VALUES(2545, 'Karolina', 'Provazn�kov�','F', '52',  47000, 2, '10.3.2006');
INSERT INTO person VALUES(2546, 'Otakar', 'Dohnal ','M', '33',  38000, 2, '13/9/2010');
INSERT INTO person VALUES(2547, 'Maria', 'Jahodov�','F', '37',  18000, 1, '30.5.2019');
INSERT INTO person VALUES(2548, '?estm�r', 'Posp�chal ','M', '56',  12000, 1, '20/9/2005');
INSERT INTO person VALUES(2549, 'Valerie', 'Ber�nkov�','F', '44',  34000, 2, '17.7.2008');
INSERT INTO person VALUES(2550, 'Bohuslav', 'Jahoda ','M', '39',  17000, 2, '22/12/2017');
INSERT INTO person VALUES(2551, 'Jarom�ra', 'T?mov�','F', '30',  42000, 1, '13.5.2005');
INSERT INTO person VALUES(2552, 'Arno�t', 'Farka� ','M', '61',  26000, 1, '30/12/2012');
INSERT INTO person VALUES(2553, 'Eli�ka', 'Pr?�ov�','F', '38',  30000, 2, '14.7.2012');
INSERT INTO person VALUES(2554, 'Ren�', 'Bauer ','M', '43',  31000, 2, '2/5/2012');
INSERT INTO person VALUES(2555, 'Vlasta', 'Jan�?kov�','F', '24',  37000, 2, '10.5.2009');
INSERT INTO person VALUES(2556, 'Mykola', 'Ol�h ','M', '19',  40000, 2, '10/5/2007');
INSERT INTO person VALUES(2557, 'Kl�ra', 'Riedlov�','F', '31',  17000, 2, '21.11.2014');
INSERT INTO person VALUES(2558, 'Richard', 'Berger ','M', '48',  45000, 2, '12/8/2019');
INSERT INTO person VALUES(2559, 'Eli�ka', 'Kuchtov�','F', '63',  25000, 1, '17.9.2011');
INSERT INTO person VALUES(2560, 'Bohumir', 'Sommer ','M', '24',  18000, 1, '19/8/2014');
INSERT INTO person VALUES(2561, 'Daniela', '�ustrov�','F', '24',  41000, 2, '30.3.2017');
INSERT INTO person VALUES(2562, 'Miloslav', 'Kolman ','M', '53',  24000, 2, '27/6/2010');
INSERT INTO person VALUES(2563, 'Zdenka', 'Spurn�','F', '55',  12000, 1, '24.1.2014');
INSERT INTO person VALUES(2564, 'Emil', '?apek ','M', '30',  33000, 1, '5/7/2005');
INSERT INTO person VALUES(2565, 'Karin', 'Holoubkov�','F', '64',  36000, 2, '1.11.2004');
INSERT INTO person VALUES(2566, 'Lubo�', 'Doubrava ','M', '58',  37000, 2, '5/11/2004');
INSERT INTO person VALUES(2567, 'Daniela', 'Urbanov�','F', '48',  36000, 1, '1.6.2016');
INSERT INTO person VALUES(2568, 'Robert', 'Van?ura ','M', '35',  47000, 1, '14/10/2012');
INSERT INTO person VALUES(2569, 'Ingrid', 'Smol�kov�','F', '57',  24000, 2, '11.3.2007');
INSERT INTO person VALUES(2570, 'Ond?ej', 'Ot�hal ','M', '63',  16000, 2, '15/2/2012');
INSERT INTO person VALUES(2571, 'Ane�ka', 'Kotl�rov�','F', '41',  23000, 1, '9.10.2018');
INSERT INTO person VALUES(2572, 'Anton�n', 'Pavl? ','M', '40',  26000, 1, '30/8/2003');
INSERT INTO person VALUES(2573, 'Patricie', 'Klou?kov�','F', '49',  47000, 2, '18.7.2009');
INSERT INTO person VALUES(2574, 'Jan', 'Bo?ek ','M', '22',  30000, 2, '27/5/2019');
INSERT INTO person VALUES(2575, 'Radom�ra', '�olcov�','F', '57',  27000, 2, '29.1.2015');
INSERT INTO person VALUES(2576, 'Gabriel', '?onka ','M', '51',  36000, 2, '4/4/2015');
INSERT INTO person VALUES(2577, 'Na?a', 'Dolej�ov�','F', '42',  35000, 2, '25.11.2011');
INSERT INTO person VALUES(2578, 'Vojtech', 'Hor?�k ','M', '27',  45000, 2, '11/4/2010');
INSERT INTO person VALUES(2579, 'Patricie', 'Janovsk�','F', '28',  42000, 1, '19.9.2008');
INSERT INTO person VALUES(2580, 'Ladislav', 'H�na ','M', '50',  18000, 1, '19/4/2005');
INSERT INTO person VALUES(2581, 'Miriam', 'Vobo?ilov�','F', '35',  22000, 2, '2.4.2014');
INSERT INTO person VALUES(2582, 'Juli�s', 'Vil�mek ','M', '33',  23000, 2, '21/7/2017');
INSERT INTO person VALUES(2583, 'Oksana', 'Hornov�','F', '20',  30000, 1, '27.1.2011');
INSERT INTO person VALUES(2584, 'Prokop', 'Pet?�k ','M', '55',  32000, 1, '28/7/2012');
INSERT INTO person VALUES(2585, 'Natalie', 'Karl�kov�','F', '28',  45000, 1, '9.8.2016');
INSERT INTO person VALUES(2586, 'Viliam', 'Ko� �l ','M', '38',  38000, 1, '6/6/2008');
INSERT INTO person VALUES(2587, 'Dominika', '�pi?kov�','F', '36',  33000, 3, '19.5.2007');
INSERT INTO person VALUES(2588, 'Anton', 'Kliment ','M', '20',  42000, 3, '8/10/2007');
INSERT INTO person VALUES(2589, 'Anna', 'Koz�kov�','F', '20',  33000, 1, '17.12.2018');
INSERT INTO person VALUES(2590, 'Matou�', 'Tome� ','M', '43',  16000, 1, '16/9/2015');
INSERT INTO person VALUES(2591, 'Kv?tu�e', 'Jakubcov�','F', '29',  21000, 2, '25.9.2009');
INSERT INTO person VALUES(2592, 'Denis', 'Richter ','M', '25',  21000, 2, '17/1/2015');
INSERT INTO person VALUES(2593, 'Dominika', 'Br�zdov�','F', '60',  28000, 2, '21.7.2006');
INSERT INTO person VALUES(2594, 'Karol', '�est�k ','M', '48',  30000, 2, '24/1/2010');
INSERT INTO person VALUES(2595, 'Leona', 'Jur�skov�','F', '22',  44000, 2, '1.2.2012');
INSERT INTO person VALUES(2596, 'Dalibor', 'Krej?�k ','M', '31',  35000, 2, '3/12/2005');
INSERT INTO person VALUES(2597, 'Hedvika', 'Podzimkov�','F', '53',  16000, 2, '27.11.2008');
INSERT INTO person VALUES(2598, 'Radoslav', 'Kurka ','M', '53',  44000, 2, '5/5/2017');
INSERT INTO person VALUES(2599, 'Vladislava', 'Mi?kov�','F', '60',  32000, 2, '10.6.2014');
INSERT INTO person VALUES(2600, 'Lud?k', 'Vav?�k ','M', '36',  14000, 2, '13/3/2013');
INSERT INTO person VALUES(2601, 'Nikol', 'Andrlov�','F', '46',  39000, 1, '6.4.2011');
INSERT INTO person VALUES(2602, 'Kry�tof', 'Vl?ek ','M', '58',  23000, 1, '21/3/2008');
INSERT INTO person VALUES(2603, 'Elena', 'N?me?kov�','F', '53',  19000, 2, '17.10.2016');
INSERT INTO person VALUES(2604, 'Ivan', 'Bro� ','M', '41',  28000, 2, '28/1/2004');
INSERT INTO person VALUES(2605, 'Dita', 'V�tkov�','F', '38',  27000, 1, '13.8.2013');
INSERT INTO person VALUES(2606, 'Ludv�k', 'Schneider ','M', '63',  37000, 1, '1/7/2015');
INSERT INTO person VALUES(2607, 'Jindra', 'Hejdukov�','F', '46',  43000, 2, '24.2.2019');
INSERT INTO person VALUES(2608, 'Zden?k', '�ime?ek ','M', '46',  42000, 2, '9/5/2011');
INSERT INTO person VALUES(2609, 'Marta', 'Pluha?ov�','F', '54',  31000, 3, '3.12.2009');
INSERT INTO person VALUES(2610, 'Boleslav', 'Kuchta ','M', '28',  47000, 3, '9/9/2010');
INSERT INTO person VALUES(2611, 'Ji?ina', '�vestkov�','F', '40',  38000, 2, '28.9.2006');
INSERT INTO person VALUES(2612, 'Marek', 'Charv�t ','M', '51',  20000, 2, '17/9/2005');
INSERT INTO person VALUES(2613, 'Iveta', 'Vojt?chov�','F', '47',  18000, 3, '10.4.2012');
INSERT INTO person VALUES(2614, 'Mario', '�t?rba ','M', '34',  26000, 3, '19/12/2017');
INSERT INTO person VALUES(2615, 'Libu�e', '?ern�kov�','F', '32',  26000, 2, '4.2.2009');
INSERT INTO person VALUES(2616, 'Pavel', 'Kaplan ','M', '56',  35000, 2, '26/12/2012');
INSERT INTO person VALUES(2617, 'Radka', 'Bure�ov�','F', '40',  41000, 2, '18.8.2014');
INSERT INTO person VALUES(2618, 'Lubor', 'Kov�?�k ','M', '39',  40000, 2, '4/11/2008');
INSERT INTO person VALUES(2619, 'Iveta', '�t?p�nkov�','F', '25',  13000, 2, '14.6.2011');
INSERT INTO person VALUES(2620, 'Rastislav', 'Luk�? ','M', '61',  13000, 2, '12/11/2003');
INSERT INTO person VALUES(2621, 'Aneta', 'Strouhalov�','F', '32',  29000, 2, '25.12.2016');
INSERT INTO person VALUES(2622, 'Ota', 'Vit�sek ','M', '44',  18000, 2, '14/2/2016');
INSERT INTO person VALUES(2623, 'Ad�la', 'Vorlov�','F', '64',  37000, 2, '20.10.2013');
INSERT INTO person VALUES(2624, 'Erv�n', '?eh�k ','M', '20',  28000, 2, '21/2/2011');
INSERT INTO person VALUES(2625, 'Danu�e', '�ebestov�','F', '25',  16000, 2, '3.5.2019');
INSERT INTO person VALUES(2626, 'Vlastislav', 'Mike� ','M', '49',  33000, 2, '30/12/2006');
INSERT INTO person VALUES(2627, 'Aneta', 'Trnkov�','F', '57',  24000, 1, '27.2.2016');
INSERT INTO person VALUES(2628, 'Gabriel', 'M�ka ','M', '26',  42000, 1, '2/6/2018');
INSERT INTO person VALUES(2629, 'D�a', 'Slov�kov�','F', '19',  12000, 3, '6.12.2006');
INSERT INTO person VALUES(2630, 'Mikul�', 'V�cha ','M', '54',  47000, 3, '3/10/2017');
INSERT INTO person VALUES(2631, 'Karolina', 'Slav�?kov�','F', '51',  19000, 2, '2.10.2003');
INSERT INTO person VALUES(2632, 'Sebastian', 'Ondr�?ek ','M', '30',  20000, 2, '10/10/2012');
INSERT INTO person VALUES(2633, 'R?�ena', 'Zahr�dkov�','F', '59',  43000, 3, '4.12.2010');
INSERT INTO person VALUES(2634, 'Emanuel', 'Peroutka ','M', '58',  24000, 3, '11/2/2012');
INSERT INTO person VALUES(2635, 'Valerie', 'Rysov�','F', '43',  43000, 2, '8.2.2006');
INSERT INTO person VALUES(2636, 'Nikolas', 'Hou�ka ','M', '35',  34000, 2, '27/8/2003');
INSERT INTO person VALUES(2637, 'Renata', '�i�kov�','F', '52',  31000, 3, '11.4.2013');
INSERT INTO person VALUES(2638, 'Andrej', 'Kone?n� ','M', '63',  39000, 3, '23/5/2019');
INSERT INTO person VALUES(2639, 'R?�ena', 'Berkov�','F', '37',  38000, 2, '5.2.2010');
INSERT INTO person VALUES(2640, '?ubom�r', 'Ko� �l ','M', '40',  12000, 2, '31/5/2014');
INSERT INTO person VALUES(2641, 'Milu�e', '�emli?kov�','F', '45',  18000, 3, '19.8.2015');
INSERT INTO person VALUES(2642, 'Svatopluk', 'Hude?ek ','M', '23',  17000, 3, '8/4/2010');
INSERT INTO person VALUES(2643, 'Kl�ra', 'Jirkov�','F', '30',  26000, 2, '14.6.2012');
INSERT INTO person VALUES(2644, 'Jon�', 'Tome� ','M', '45',  27000, 2, '15/4/2005');
INSERT INTO person VALUES(2645, 'So?a', 'Hermanov�','F', '37',  42000, 3, '26.12.2017');
INSERT INTO person VALUES(2646, 'Marcel', 'Mayer ','M', '28',  32000, 3, '18/7/2017');
INSERT INTO person VALUES(2647, 'Milu�e', 'Karasov�','F', '23',  13000, 2, '22.10.2014');
INSERT INTO person VALUES(2648, 'Mari�n', 'Paul ','M', '50',  41000, 2, '25/7/2012');
INSERT INTO person VALUES(2649, 'Nina', 'Hejdukov�','F', '31',  37000, 3, '31.7.2005');
INSERT INTO person VALUES(2650, 'Bohumir', 'Krej?�k ','M', '32',  46000, 3, '26/11/2011');
INSERT INTO person VALUES(2651, 'Nad?�da', 'Nesvadbov�','F', '61',  37000, 2, '27.2.2017');
INSERT INTO person VALUES(2652, 'Bohum�r', 'Sklen�? ','M', '55',  19000, 2, '4/11/2019');
INSERT INTO person VALUES(2653, 'Em�lia', 'Majerov�','F', '24',  25000, 3, '7.12.2007');
INSERT INTO person VALUES(2654, 'Michael', 'Vav?�k ','M', '37',  24000, 3, '7/3/2019');
INSERT INTO person VALUES(2655, 'Zlatu�e', '�im�kov�','F', '31',  41000, 3, '19.6.2013');
INSERT INTO person VALUES(2656, 'Miroslav', 'Dunka ','M', '20',  29000, 3, '14/1/2015');
INSERT INTO person VALUES(2657, 'Olena', 'V�kov�','F', '63',  12000, 3, '15.4.2010');
INSERT INTO person VALUES(2658, 'Mat?j', 'Bro� ','M', '43',  39000, 3, '21/1/2010');
INSERT INTO person VALUES(2659, 'Em�lia', 'Kulhav�','F', '48',  20000, 2, '9.2.2007');
INSERT INTO person VALUES(2660, 'Leo�', 'Schneider ','M', '19',  12000, 2, '28/1/2005');
INSERT INTO person VALUES(2661, 'Radom�ra', 'Hlou�kov�','F', '55',  36000, 3, '22.8.2012');
INSERT INTO person VALUES(2662, 'Radek', 'Zbo?il ','M', '48',  17000, 3, '2/5/2017');
INSERT INTO person VALUES(2663, 'Na?a', 'Langerov�','F', '41',  43000, 2, '17.6.2009');
INSERT INTO person VALUES(2664, 'Zbyn?k', 'Holoubek ','M', '24',  26000, 2, '9/5/2012');
INSERT INTO person VALUES(2665, 'Tatiana', '�ebelov�','F', '48',  23000, 2, '29.12.2014');
INSERT INTO person VALUES(2666, 'Petr', 'Karel ','M', '53',  31000, 2, '17/3/2008');
INSERT INTO person VALUES(2667, 'Bla�ena', '�ebestov�','F', '57',  47000, 3, '7.10.2005');
INSERT INTO person VALUES(2668, 'Herbert', '�t?rba ','M', '35',  36000, 3, '20/7/2007');
INSERT INTO person VALUES(2669, 'Hana', 'Hrom�dkov�','F', '41',  47000, 2, '7.5.2017');
INSERT INTO person VALUES(2670, 'Vladimir', 'Strnad ','M', '59',  46000, 2, '27/6/2015');
INSERT INTO person VALUES(2671, 'Alexandra', 'Peroutkov�','F', '49',  34000, 3, '14.2.2008');
INSERT INTO person VALUES(2672, 'J�lius', 'Kov�?�k ','M', '41',  14000, 3, '28/10/2014');
INSERT INTO person VALUES(2673, 'Martina', '?echov�','F', '34',  34000, 2, '14.9.2019');
INSERT INTO person VALUES(2674, 'J?lius', 'Bu?ek ','M', '64',  24000, 2, '13/5/2006');
INSERT INTO person VALUES(2675, 'Jolana', '?erve?�kov�','F', '42',  22000, 3, '23.6.2010');
INSERT INTO person VALUES(2676, 'Vili�m', 'Dole?ek ','M', '46',  29000, 3, '13/9/2005');
INSERT INTO person VALUES(2677, 'Kv?tu�e', 'Hradilov�','F', '28',  30000, 2, '19.4.2007');
INSERT INTO person VALUES(2678, 'Nikola', 'B?ezina ','M', '22',  38000, 2, '14/2/2017');
INSERT INTO person VALUES(2679, 'Vladislava', 'Urbancov�','F', '35',  45000, 3, '30.10.2012');
INSERT INTO person VALUES(2680, 'Slavom�r', 'Mike� ','M', '51',  43000, 3, '23/12/2012');
INSERT INTO person VALUES(2681, 'Leona', 'R�cov�','F', '20',  17000, 2, '25.8.2009');
INSERT INTO person VALUES(2682, 'R�bert', 'M�ka ','M', '27',  17000, 2, '31/12/2007');
INSERT INTO person VALUES(2683, 'Ivanka', 'Smr?kov�','F', '28',  33000, 3, '8.3.2015');
INSERT INTO person VALUES(2684, 'Hynek', 'Maty� ','M', '56',  22000, 3, '9/11/2003');
INSERT INTO person VALUES(2685, 'Vladislava', 'Ludv�kov�','F', '59',  40000, 2, '2.1.2012');
INSERT INTO person VALUES(2686, 'Ferdinand', 'Ducho? ','M', '33',  31000, 2, '11/4/2015');
INSERT INTO person VALUES(2687, 'Jindra', 'Proch�zkov�','F', '20',  20000, 3, '15.7.2017');
INSERT INTO person VALUES(2688, 'Otakar', 'Dani� ','M', '62',  36000, 3, '18/2/2011');
INSERT INTO person VALUES(2689, 'Irena', '?ervinkov�','F', '29',  44000, 4, '23.4.2008');
INSERT INTO person VALUES(2690, 'Vladislav', 'Sochor ','M', '44',  41000, 4, '21/6/2010');
INSERT INTO person VALUES(2691, 'Monika', 'Van�?kov�','F', '60',  16000, 3, '17.2.2005');
INSERT INTO person VALUES(2692, 'Otto', 'Hrabal ','M', '20',  14000, 3, '28/6/2005');
INSERT INTO person VALUES(2693, '��rka', 'Hrd�','F', '22',  32000, 4, '31.8.2010');
INSERT INTO person VALUES(2694, 'Ale�', 'Pape� ','M', '49',  19000, 4, '30/9/2017');
INSERT INTO person VALUES(2695, 'Marta', 'Je�ov�','F', '53',  39000, 3, '26.6.2007');
INSERT INTO person VALUES(2696, 'Ren�', 'Brada ','M', '25',  29000, 3, '7/10/2012');
INSERT INTO person VALUES(2697, 'Simona', 'Ra�kov�','F', '60',  19000, 3, '6.1.2013');
INSERT INTO person VALUES(2698, 'Zden?k', 'R?�i?ka ','M', '54',  34000, 3, '15/8/2008');
INSERT INTO person VALUES(2699, '��rka', 'Votavov�','F', '46',  27000, 3, '2.11.2009');
INSERT INTO person VALUES(2700, 'Ivo', 'Siv�k ','M', '30',  43000, 3, '24/8/2003');
INSERT INTO person VALUES(2701, 'Ilona', 'Dou�ov�','F', '53',  43000, 3, '16.5.2015');
INSERT INTO person VALUES(2702, 'V?roslav', 'Vacul�k ','M', '59',  12000, 3, '25/11/2015');
INSERT INTO person VALUES(2703, 'Radka', 'Mach�?ov�','F', '38',  14000, 3, '11.3.2012');
INSERT INTO person VALUES(2704, 'Miloslav', 'T?�ska ','M', '36',  21000, 3, '2/12/2010');
INSERT INTO person VALUES(2705, 'Jind?i�ka', 'Voln�','F', '46',  30000, 3, '22.9.2017');
INSERT INTO person VALUES(2706, 'Zolt�n', 'Pr�ek ','M', '19',  27000, 3, '11/10/2006');
INSERT INTO person VALUES(2707, 'Ilona', 'Dvorsk�','F', '31',  38000, 2, '19.7.2014');
INSERT INTO person VALUES(2708, 'Martin', '�ebela ','M', '41',  36000, 2, '13/3/2018');
INSERT INTO person VALUES(2709, 'Zlata', 'Kalov�','F', '40',  25000, 4, '26.4.2005');
INSERT INTO person VALUES(2710, 'Adrian', 'Voj�?ek ','M', '23',  40000, 4, '14/7/2017');
INSERT INTO person VALUES(2711, 'Zd?nka', 'Karasov�','F', '47',  41000, 4, '7.11.2010');
INSERT INTO person VALUES(2712, 'Ota', 'M?ller ','M', '52',  46000, 4, '23/5/2013');
INSERT INTO person VALUES(2713, 'Aloisie', 'Ma?�kov�','F', '32',  13000, 3, '3.9.2007');
INSERT INTO person VALUES(2714, 'Gerhard', 'Hu�ek ','M', '28',  19000, 3, '30/5/2008');
INSERT INTO person VALUES(2715, 'Zora', 'Nesvadbov�','F', '40',  29000, 4, '16.3.2013');
INSERT INTO person VALUES(2716, 'Vlastislav', 'Hrd� ','M', '57',  24000, 4, '8/4/2004');
INSERT INTO person VALUES(2717, 'Zd?nka', 'Dittrichov�','F', '25',  36000, 3, '10.1.2010');
INSERT INTO person VALUES(2718, 'Gabriel', 'Toman ','M', '34',  33000, 3, '9/9/2015');
INSERT INTO person VALUES(2719, 'Iryna', 'Dobi�ov�','F', '32',  16000, 4, '24.7.2015');
INSERT INTO person VALUES(2720, 'Leo�', 'Benda ','M', '62',  39000, 4, '19/7/2011');
INSERT INTO person VALUES(2721, 'Radana', 'Van?urov�','F', '64',  24000, 3, '19.5.2012');
INSERT INTO person VALUES(2722, 'Drahom�r', 'Kol�?ek ','M', '39',  12000, 3, '26/7/2006');
INSERT INTO person VALUES(2723, '�t?p�nka', 'Kulhav�','F', '26',  12000, 4, '21.7.2019');
INSERT INTO person VALUES(2724, 'Alexander 4 000', 'Ba�ta ','M', '21',  16000, 4, '26/11/2005');
INSERT INTO person VALUES(2725, 'Iryna', 'Matou�kov�','F', '57',  47000, 3, '25.9.2014');
INSERT INTO person VALUES(2726, 'Tade�', 'Pro�ek ','M', '44',  26000, 3, '4/11/2013');
INSERT INTO person VALUES(2727, 'Antonie', 'Hudcov�','F', '19',  35000, 4, '4.7.2005');
INSERT INTO person VALUES(2728, 'B?etislav', '��?ek ','M', '26',  31000, 4, '7/3/2013');
INSERT INTO person VALUES(2729, 'Petra', 'Jurkov�','F', '49',  35000, 3, '1.2.2017');
INSERT INTO person VALUES(2730, 'Vil�m', 'Ma�ek ','M', '49',  41000, 3, '19/9/2004');
INSERT INTO person VALUES(2731, 'V�clava', 'Bar�kov�','F', '58',  23000, 4, '11.11.2007');
INSERT INTO person VALUES(2732, 'Vit', 'Kindl ','M', '31',  45000, 4, '22/1/2004');
INSERT INTO person VALUES(2733, 'Sylva', 'Hrom�dkov�','F', '19',  38000, 4, '24.5.2013');
INSERT INTO person VALUES(2734, 'Zd?nek', 'Macha? ','M', '60',  15000, 4, '24/4/2016');
INSERT INTO person VALUES(2735, 'Linda', 'Chmela?ov�','F', '51',  46000, 4, '20.3.2010');
INSERT INTO person VALUES(2736, 'Rudolf', 'Walter ','M', '37',  24000, 4, '2/5/2011');
INSERT INTO person VALUES(2737, 'Nela', 'Pol�chov�','F', '36',  18000, 3, '13.1.2007');
INSERT INTO person VALUES(2738, 'Dalibor', 'Hol� ','M', '59',  33000, 3, '10/5/2006');
INSERT INTO person VALUES(2739, 'Sylva', 'Dole�alov�','F', '43',  34000, 3, '26.7.2012');
INSERT INTO person VALUES(2740, 'Michal', 'Gregor ','M', '42',  38000, 3, '11/8/2018');
INSERT INTO person VALUES(2741, 'Terezie', 'Dvo?�kov�','F', '29',  41000, 3, '22.5.2009');
INSERT INTO person VALUES(2742, 'Lud?k', 'Fischer ','M', '64',  47000, 3, '18/8/2013');
INSERT INTO person VALUES(2743, 'Maria', 'Rybov�','F', '36',  21000, 3, '3.12.2014');
INSERT INTO person VALUES(2744, 'Nicolas', '�i�ka ','M', '47',  17000, 3, '27/6/2009');
INSERT INTO person VALUES(2745, 'Mark�ta', 'R�cov�','F', '45',  45000, 4, '11.9.2005');
INSERT INTO person VALUES(2746, 'Ctibor', 'Ku?era ','M', '29',  21000, 4, '28/10/2008');
INSERT INTO person VALUES(2747, 'Jarom�ra', 'Dvo?�?kov�','F', '29',  45000, 3, '11.4.2017');
INSERT INTO person VALUES(2748, 'Oskar', 'Kraj�?ek ','M', '52',  31000, 3, '6/10/2016');
INSERT INTO person VALUES(2749, 'R?�ena', 'Ludv�kov�','F', '37',  32000, 4, '19.1.2008');
INSERT INTO person VALUES(2750, 'J�chym', 'Kola?�k ','M', '34',  36000, 4, '7/2/2016');
INSERT INTO person VALUES(2751, 'Mark�ta', 'Stuchl�kov�','F', '23',  40000, 4, '13.11.2004');
INSERT INTO person VALUES(2752, 'Boleslav', 'Rudolf ','M', '57',  45000, 4, '14/2/2011');
INSERT INTO person VALUES(2753, 'Kl�ra', '�im?�kov�','F', '30',  20000, 4, '27.5.2010');
INSERT INTO person VALUES(2754, 'Bo?ivoj', 'Michalec ','M', '40',  14000, 4, '24/12/2006');
INSERT INTO person VALUES(2755, 'Eli�ka', 'Braunov�','F', '62',  27000, 3, '23.3.2007');
INSERT INTO person VALUES(2756, 'Mario', 'Jech ','M', '62',  23000, 3, '26/5/2018');
INSERT INTO person VALUES(2757, 'Milu�e', 'Jan�?kov�','F', '23',  43000, 4, '3.10.2012');
INSERT INTO person VALUES(2758, 'Mykola', 'Ka?�rek ','M', '45',  29000, 4, '4/4/2014');
INSERT INTO person VALUES(2759, 'Kl�ra', 'Folt�nov�','F', '54',  15000, 3, '30.7.2009');
INSERT INTO person VALUES(2760, 'Lubor', 'Havr�nek ','M', '21',  38000, 3, '11/4/2009');
INSERT INTO person VALUES(2761, 'Nad?�da', 'Ad�mkov�','F', '62',  31000, 4, '10.2.2015');
INSERT INTO person VALUES(2762, 'Bohumir', 'Kube� ','M', '50',  43000, 4, '17/2/2005');
INSERT INTO person VALUES(2763, 'Daniela', 'Havlov�','F', '47',  38000, 3, '7.12.2011');
INSERT INTO person VALUES(2764, 'Ota', 'Ml?och ','M', '27',  16000, 3, '21/7/2016');
INSERT INTO person VALUES(2765, 'Al�b?ta', 'Chv�talov�','F', '54',  18000, 4, '19.6.2017');
INSERT INTO person VALUES(2766, 'Emil', 'Sad�lek ','M', '55',  22000, 4, '29/5/2012');
INSERT INTO person VALUES(2767, 'Olena', 'Mach�?ov�','F', '63',  42000, 1, '28.3.2008');
INSERT INTO person VALUES(2768, 'Lubo�', 'Hlav�?ek ','M', '37',  26000, 1, '30/9/2011');
INSERT INTO person VALUES(2769, 'Em�lia', 'Neradov�','F', '48',  14000, 4, '21.1.2005');
INSERT INTO person VALUES(2770, 'Maty�', 'Hus�k ','M', '60',  35000, 4, '8/10/2006');
INSERT INTO person VALUES(2771, 'Zlatu�e', 'Dvorsk�','F', '55',  30000, 4, '4.8.2010');
INSERT INTO person VALUES(2772, 'Ond?ej', 'Mar��lek ','M', '43',  41000, 4, '9/1/2019');
INSERT INTO person VALUES(2773, 'Na?a', 'Kaplanov�','F', '41',  37000, 4, '31.5.2007');
INSERT INTO person VALUES(2774, 'J�n', 'Sko?epa ','M', '19',  14000, 4, '16/1/2014');
INSERT INTO person VALUES(2775, 'Tatiana', 'Fi�erov�','F', '48',  17000, 4, '11.12.2012');
INSERT INTO person VALUES(2776, 'Jan', 'Hejna ','M', '48',  19000, 4, '25/11/2009');
INSERT INTO person VALUES(2777, 'Radom�ra', 'Beranov�','F', '34',  25000, 4, '7.10.2009');
INSERT INTO person VALUES(2778, 'Adam', 'V�vra ','M', '24',  28000, 4, '2/12/2004');
INSERT INTO person VALUES(2779, 'Hana', 'Horsk�','F', '41',  40000, 4, '20.4.2015');
INSERT INTO person VALUES(2780, 'Herbert', 'Jedli?ka ','M', '53',  34000, 4, '6/3/2017');
INSERT INTO person VALUES(2781, 'Natalie', 'Kazdov�','F', '26',  12000, 3, '13.2.2012');
INSERT INTO person VALUES(2782, 'Ladislav', 'Sojka ','M', '30',  43000, 3, '13/3/2012');
INSERT INTO person VALUES(2783, 'Bla�ena', 'Paulov�','F', '35',  36000, 1, '17.4.2019');
INSERT INTO person VALUES(2784, 'Kevin', 'Moln�r ','M', '58',  47000, 1, '15/7/2011');
INSERT INTO person VALUES(2785, 'Hana', 'Kom�rkov�','F', '19',  36000, 3, '22.6.2014');
INSERT INTO person VALUES(2786, 'Prokop', 'Ondra ','M', '35',  21000, 3, '23/6/2019');
INSERT INTO person VALUES(2787, 'Kv?tu�e', 'Srbov�','F', '28',  23000, 4, '31.3.2005');
INSERT INTO person VALUES(2788, 'Alfred', 'Sobotka ','M', '63',  26000, 4, '24/10/2018');
INSERT INTO person VALUES(2789, 'Ta �na', 'Matou�kov�','F', '35',  39000, 1, '12.10.2010');
INSERT INTO person VALUES(2790, 'Anton', 'Jir�sek ','M', '46',  31000, 1, '2/9/2014');
INSERT INTO person VALUES(2791, 'Jolana', 'Pol�kov�','F', '20',  47000, 4, '8.8.2007');
INSERT INTO person VALUES(2792, 'Drahoslav', '�tefan ','M', '22',  40000, 4, '9/9/2009');
INSERT INTO person VALUES(2793, 'Hedvika', 'Bene�ov�','F', '52',  19000, 4, '3.6.2004');
INSERT INTO person VALUES(2794, 'Radko', '�krabal ','M', '44',  13000, 4, '16/9/2004');
INSERT INTO person VALUES(2795, 'Vladislava', 'Smolov�','F', '59',  34000, 4, '15.12.2009');
INSERT INTO person VALUES(2796, 'Karol', 'Bar�k ','M', '27',  19000, 4, '19/12/2016');
INSERT INTO person VALUES(2797, 'Leona', 'Kindlov�','F', '45',  42000, 3, '10.10.2006');
INSERT INTO person VALUES(2798, 'Ctibor', '?�ek ','M', '50',  28000, 3, '27/12/2011');
INSERT INTO person VALUES(2799, 'Ivanka', 'Davidov�','F', '52',  22000, 4, '22.4.2012');
INSERT INTO person VALUES(2800, 'Zdenek', 'Str�nsk� ','M', '33',  33000, 4, '4/11/2007');
INSERT INTO person VALUES(2801, 'Monika', 'Pol�chov�','F', '60',  46000, 1, '25.6.2019');
INSERT INTO person VALUES(2802, 'Alexandr', 'Ma?�k ','M', '61',  38000, 1, '8/3/2007');
INSERT INTO person VALUES(2803, 'Jindra', 'Sko?epov�','F', '45',  45000, 4, '30.8.2014');
INSERT INTO person VALUES(2804, 'Kry�tof', 'Svato� ','M', '38',  12000, 4, '13/2/2015');
INSERT INTO person VALUES(2805, 'Marta', 'Novotn�','F', '53',  33000, 1, '8.6.2005');
INSERT INTO person VALUES(2806, 'V�t?zslav', 'Sobek ','M', '20',  16000, 1, '16/6/2014');
INSERT INTO person VALUES(2807, 'Ema', 'Uhrov�','F', '37',  33000, 4, '6.1.2017');
INSERT INTO person VALUES(2808, 'Ludv�k', 'Tvrd�k ','M', '43',  26000, 4, '30/12/2005');
INSERT INTO person VALUES(2809, '��rka', 'Kurkov�','F', '46',  21000, 1, '16.10.2007');
INSERT INTO person VALUES(2810, 'Radim', 'Jon� ','M', '25',  31000, 1, '2/5/2005');
INSERT INTO person VALUES(2811, 'Ilona', 'Dvo?�?kov�','F', '53',  36000, 1, '28.4.2013');
INSERT INTO person VALUES(2812, 'Boleslav', '�est�k ','M', '54',  36000, 1, '4/8/2017');
INSERT INTO person VALUES(2813, 'Radka', '�t?p�nov�','F', '39',  44000, 1, '21.2.2010');
INSERT INTO person VALUES(2814, 'Daniel', 'Klouda ','M', '30',  45000, 1, '11/8/2012');
INSERT INTO person VALUES(2815, 'Iveta', '�pa?kov�','F', '24',  16000, 4, '18.12.2006');
INSERT INTO person VALUES(2816, 'Viktor', 'Pavlica ','M', '53',  18000, 4, '19/8/2007');
INSERT INTO person VALUES(2817, 'Ilona', 'J�nsk�','F', '31',  32000, 4, '30.6.2012');
INSERT INTO person VALUES(2818, 'Pavel', 'Br�zdil ','M', '36',  24000, 4, '28/6/2003');
INSERT INTO person VALUES(2819, 'Radka', 'Ottov�','F', '63',  39000, 4, '26.4.2009');
INSERT INTO person VALUES(2820, 'Bohumil', 'Divi� ','M', '58',  33000, 4, '28/11/2014');
INSERT INTO person VALUES(2821, 'Danu�e', 'Hovorkov�','F', '24',  19000, 4, '7.11.2014');
INSERT INTO person VALUES(2822, 'Rastislav', 'Pelik�n ','M', '41',  38000, 4, '7/10/2010');
INSERT INTO person VALUES(2823, 'Barbara', 'Folt�nov�','F', '33',  43000, 1, '16.8.2005');
INSERT INTO person VALUES(2824, 'Oliver', 'Kubi� ','M', '23',  43000, 1, '7/2/2010');
INSERT INTO person VALUES(2825, 'Magdalena', 'Min�?ov�','F', '63',  42000, 4, '16.3.2017');
INSERT INTO person VALUES(2826, 'Erv�n', 'Vrabec ','M', '46',  16000, 4, '15/1/2018');
INSERT INTO person VALUES(2827, 'Karolina', 'Fridrichov�','F', '49',  22000, 4, '31.8.2015');
INSERT INTO person VALUES(2828, 'Jind?ich', 'Hradil ','M', '22',  25000, 4, '17/7/2016');
INSERT INTO person VALUES(2829, 'Aloisie', 'Stejskalov�','F', '57',  38000, 4, '18.10.2004');
INSERT INTO person VALUES(2830, 'Gejza', 'Chl�dek ','M', '51',  30000, 4, '26/5/2012');
INSERT INTO person VALUES(2831, 'D�a', 'Hru�kov�','F', '42',  46000, 4, '7.1.2018');
INSERT INTO person VALUES(2832, 'Luk�', 'Kysela ','M', '27',  39000, 4, '3/6/2007');
INSERT INTO person VALUES(2833, 'Renata', 'Hrdinov�','F', '51',  33000, 1, '16.10.2008');
INSERT INTO person VALUES(2834, 'Nicolas', 'Jedli?ka ','M', '55',  44000, 1, '4/10/2006');
INSERT INTO person VALUES(2835, 'Vladim�ra', 'Grygarov�','F', '58',  13000, 1, '29.4.2014');
INSERT INTO person VALUES(2836, 'Emanuel', '?apek ','M', '38',  13000, 1, '6/1/2019');
INSERT INTO person VALUES(2837, 'Denisa', 'Gottwaldov�','F', '43',  21000, 1, '23.2.2011');
INSERT INTO person VALUES(2838, 'Oskar', 'Hron ','M', '60',  22000, 1, '13/1/2014');
INSERT INTO person VALUES(2839, 'Vendula', 'Sedl�?ov�','F', '51',  37000, 1, '5.9.2016');
INSERT INTO person VALUES(2840, 'Andrej', 'Ha�ek ','M', '43',  28000, 1, '22/11/2009');
INSERT INTO person VALUES(2841, 'So?a', '�igov�','F', '36',  44000, 1, '1.7.2013');
INSERT INTO person VALUES(2842, '?ubom�r', 'Matys ','M', '19',  37000, 1, '29/11/2004');
INSERT INTO person VALUES(2843, 'Antonie', 'Moravcov�','F', '43',  24000, 1, '12.1.2019');
INSERT INTO person VALUES(2844, 'Svatopluk', 'Pavl? ','M', '48',  42000, 1, '2/3/2017');
INSERT INTO person VALUES(2845, 'Vendula', 'Kov�?ov�','F', '29',  32000, 4, '8.11.2015');
INSERT INTO person VALUES(2846, 'Jon�', 'Havl�k ','M', '25',  15000, 4, '10/3/2012');
INSERT INTO person VALUES(2847, 'Nela', 'Pe?inov�','F', '36',  12000, 1, '26.12.2004');
INSERT INTO person VALUES(2848, 'Peter', 'Ko?�nek ','M', '54',  21000, 1, '17/1/2008');
INSERT INTO person VALUES(2849, 'Julie', 'Hoffmannov�','F', '22',  19000, 4, '17.3.2018');
INSERT INTO person VALUES(2850, 'Mari�n', 'Vale� ','M', '30',  30000, 4, '19/6/2019');
INSERT INTO person VALUES(2851, 'Zlatu�e', 'Jare�ov�','F', '30',  43000, 1, '24.12.2008');
INSERT INTO person VALUES(2852, 'Bohumir', 'H�na ','M', '58',  34000, 1, '21/10/2018');
INSERT INTO person VALUES(2853, 'Nela', 'Brabcov�','F', '60',  43000, 4, '28.2.2004');
INSERT INTO person VALUES(2854, 'Alexandr', 'Janota ','M', '35',  44000, 4, '5/5/2010');
INSERT INTO person VALUES(2855, 'Tati�na', 'Vale�ov�','F', '23',  31000, 1, '2.5.2011');
INSERT INTO person VALUES(2856, 'Michael', 'V�clav�k ','M', '63',  13000, 1, '6/9/2009');
INSERT INTO person VALUES(2857, 'Zde?ka', 'Bene�ov�','F', '30',  46000, 2, '12.11.2016');
INSERT INTO person VALUES(2858, 'Miroslav', 'Ko� �l ','M', '46',  18000, 2, '15/7/2005');
INSERT INTO person VALUES(2859, 'V?ra', 'Nov�kov�','F', '62',  18000, 1, '8.9.2013');
INSERT INTO person VALUES(2860, 'Mat?j', 'Nagy ','M', '23',  27000, 1, '15/12/2016');
INSERT INTO person VALUES(2861, 'Tatiana', 'Zdr�halov�','F', '47',  26000, 4, '5.7.2010');
INSERT INTO person VALUES(2862, 'Leo�', 'Tvrd�k ','M', '45',  37000, 4, '24/12/2011');
INSERT INTO person VALUES(2863, 'Zde?ka', 'Hr?zov�','F', '54',  42000, 1, '16.1.2016');
INSERT INTO person VALUES(2864, 'Radek', 'Dosko?il ','M', '28',  42000, 1, '1/11/2007');
INSERT INTO person VALUES(2865, 'V?ra', 'Brychtov�','F', '40',  13000, 4, '11.11.2012');
INSERT INTO person VALUES(2866, 'Zbyn?k', 'Kr�tk� ','M', '50',  15000, 4, '3/4/2019');
INSERT INTO person VALUES(2867, 'Vlasta', 'Han�kov�','F', '47',  29000, 1, '25.5.2018');
INSERT INTO person VALUES(2868, 'Josef', 'Majer ','M', '33',  20000, 1, '10/2/2015');
INSERT INTO person VALUES(2869, 'Sandra', 'Anto�ov�','F', '56',  17000, 2, '2.3.2009');
INSERT INTO person VALUES(2870, 'Herbert', 'Mat?j�?ek ','M', '61',  25000, 2, '13/6/2014');
INSERT INTO person VALUES(2871, 'Eli�ka', 'Vo?�kov�','F', '40',  16000, 1, '7.5.2004');
INSERT INTO person VALUES(2872, 'Vladimir', 'Vorel ','M', '38',  35000, 1, '27/12/2005');
INSERT INTO person VALUES(2873, 'Old?i�ka', 'Ba�tov�','F', '48',  40000, 2, '10.7.2011');
INSERT INTO person VALUES(2874, 'J�lius', 'Vl?ek ','M', '20',  39000, 2, '29/4/2005');
INSERT INTO person VALUES(2875, 'Ta �na', 'Pohankov�','F', '34',  12000, 1, '5.5.2008');

commit;

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'rsk');
SELECT * FROM person WHERE REGEXP_LIKE(lastname,'�ad');
SELECT * FROM person WHERE REGEXP_LIKE(lastname,'Ma�kov�');
SELECT * FROM person WHERE REGEXP_LIKE(lastname,'Ha�kov�');
SELECT * FROM person WHERE REGEXP_LIKE(lastname,'Pa�kov�');

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'[MHP]a�kov�');
SELECT * FROM person WHERE REGEXP_LIKE(firstname,'[HJ]ana');
SELECT * FROM person WHERE REGEXP_LIKE(firstname,'[RM]a[dr]ek');

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'[N�][io][mv]��ek');

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'[A-Z]ana');

SELECT * FROM v$nls_parameters;

ALTER SESSION SET nls_sort = 'binary';

-- sortovani ro nejakz jazyk v abecede s velkzmi pismeny 

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'[A-Z][a-z][a-z]��ek');

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'Jana');
SELECT * FROM person WHERE REGEXP_LIKE(firstname,'Hana');

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'Radka')
UNION
SELECT * FROM person WHERE REGEXP_LIKE(firstname,'Marek');

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'Radka','Marek');

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'[DHJ]ana');

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'[^ N]ov��ek');

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'^[^H]ana');
-- dat pred yavorkami jestli hceme na yacatku mit spravne 

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'an$');

-- na konci dame $ abzchom dali vedet ye je to konec reteyce 

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'Pet��[�]*kov�');

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'Adam[c]*ov�');

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'Mu[l]+erov�');

ALTER SESSION SET nls_date_format= 'DD.MM.YYYY';

SELECT hire_date FROM person WHERE hire_date. > 2000;


SELECT * FROM dual  WHERE REGEXP_LIKE('Hello world','[a-z]ello','i');

-- kez senzitive pro cast 

SELECT * FROM dual  WHERE REGEXP_LIKE('Hello world','[a-z]ello','c');
SELECT * FROM dual  WHERE REGEXP_LIKE('Hello world','[a-z]ello');

SELECT * FROM dual WHERE REGEXP_LIKE('jedemeSrat','[A-Z]rat$');
SELECT * FROM dual WHERE REGEXP_LIKE('jedeme*rat','[*]rat$');
SELECT * FROM dual WHERE REGEXP_LIKE('jedemeSrat','[A-Z]rat$');
SELECT * FROM dual WHERE REGEXP_LIKE('jedemeSrat','rat');
SELECT * FROM dual WHERE REGEXP_LIKE('jedemeSrat5','[5]');

SELECT * FROM dual WHERE REGEXP_LIKE('Hello world',[[:upper:]]);
SELECT * FROM dual WHERE REGEXP_LIKE('Hello world','['=[:upper:]]ello');

SELECT * FROM dual WHERE REGEXP_LIKE('Hello world','[[:alpha:]]ello');
SELECT * FROM dual WHERE REGEXP_LIKE('Hello world','[^[:alpha:]]ello');

SELECT * FROM dual WHERE REGEXP_LIKE('Heeeello world','H[e]llo');

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'[:upper:][:lower:]*[kr]ov�$');

DELETE person;


INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextval, 'Petr', 'Svoboda', 'M', 25, 47800, 1 ); 
INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextval, 'Radek', 'Barta', 'M', 34, 17520, 1 ); 
INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextval, 'Frantisek', 'Novak', 'M', 58, 37800, 1 ); 
INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextval, 'Lenka', 'Novakova', 'F', 45, 33800, 3 ); 
INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextval, 'Dita', 'Wiesnerova', 'F', 38, 44800, 1 ); 
INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextval, 'Karel', 'Janak', 'M', 31, 40000, 2 ); 

commit;



TRUNCATE TABLE person;

DROP SEQUENCE seqPerson; 
CREATE SEQUENCE seqPerson 
    START WITH 1 
    INCREMENT BY 1 
    NOCACHE;

INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextval, 'Petr', 'Svoboda', 'M', 25, 47800, 1 ); 
INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextval, 'Radek', 'Barta', 'M', 34, 17520, 1 ); 
INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextval, 'Frantisek', 'Novak', 'M', 58, 37800, 1 ); 
INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextval, 'Lenka', 'Novakova', 'F', 45, 33800, 3 ); 
INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextval, 'Dita', 'Wiesnerova', 'F', 38, 44800, 1 ); 
INSERT INTO person (id, firstName, lastName, sex, age, salary, id_dept) VALUES (seqPerson.nextval, 'Karel', 'Janak', 'M', 31, 40000, 2 ); 

SELECT * FROM person WHERE firstname='Dita';

CREATE INDEX ix_firstname ON person(firstname);

ALTER TABLE cat_contact_type ADD CONSTRAINT pk_cct_id PRIMARY KEY(id); -- index jhe pro system 
-- contact pk_contact_id
--department pk_deparment_id
--person pk_person_id
ALTER TABLE contact ADD CONSTRAINT pk_contact_id PRIMARY KEY(id);
ALTER TABLE department ADD CONSTRAINT pk_deparment_id PRIMARY KEY(id);
ALTER TABLE person ADD CONSTRAINT pk_person_id PRIMARY KEY(id);

ALTER TABLE contact ADD CONSTRAINT fk_contact_cct_id FOREIGN KEY(id_cat_contact)REFERENCES cat_contact_type(id);

ALTER TABLE contact ADD CONSTRAINT fk_contact_person_id FOREIGN KEY(id_person)REFERENCES person(id);

ALTER TABLE contact 
ADD CONSTRAINT fk_contact_person_id 
FOREIGN KEY(id_person)
REFERENCES person(id);


ALTER TABLE person ADD CONSTRAINT fk_department_person_id FOREIGN KEY(id_dept)REFERENCES department(id);


CREATE INDEX ix_fk_person_dept_id ON person(id_dept);
CREATE INDEX ix_fk_contact_person_id ON contact(id_person);
CREATE INDEX ix_fk_person_dept_id ON contact(id_dept);

DROP TABLE inventory;
CREATE TABLE inventory (
    id      NUMBER(5) NOT NULL,  
    name    VARCHAR(50) NOT NULL,
    price   NUMBER(9,2),
    serial  VARCHAR(50),
    id_type NUMBER(5),
    date_purchase   DATE DEFAULT SYSDATE,
    CONSTRAINT pk_inventory_id PRIMARY KEY (id)
);


DROP TABLE cat_inventory;
CREATE TABLE cat_inventory (
    id      NUMBER(5) NOT NULL,
    name    VARCHAR(50) NOT NULL
);

TRUNCATE TABLE inventory; 
TRUNCATE TABLE cat_inventory; 

INSERT INTO cat_inventory VALUES (1, 'MOBIL'); 
INSERT INTO cat_inventory VALUES (2, 'NOTEBOOK'); 
INSERT INTO cat_inventory VALUES (3, 'AUTO'); 
INSERT INTO cat_inventory VALUES (4, 'KNIHA'); 

INSERT INTO inventory VALUES (1, 'Skoda Octavia', 550000, '1T26677',3,DEFAULT); 
INSERT INTO inventory VALUES (2,'BMW X5',1550000,'2T22222',3,DEFAULT); 
INSERT INTO inventory VALUES (3,'Ford Focus',40000,'1A43456',3,DEFAULT); 
INSERT INTO inventory VALUES (4, 'Samsung Galaxy S8',16000 , 'SMSG90903',1,DEFAULT); 
INSERT INTO inventory VALUES (5, 'Sony Xperia', 5000,'SON12345',1,DEFAULT); 
INSERT INTO inventory VALUES (6, 'Nokia 3310', 1500,'NK23456',1,DEFAULT); 
INSERT INTO inventory VALUES (7, 'Lenovo Yoga', 36000,'AAAA',2,DEFAULT); 
INSERT INTO inventory VALUES (8, 'ASUS Travelmate',26500, 'BBBB',2,DEFAULT); 
INSERT INTO inventory VALUES (9, 'Java for dummies ',649, 'ISBN12345',4,DEFAULT); 

--vazebn� tabulka
DROP TABLE map_inventory_person;
CREATE TABLE map_inventory_person (
    id_inventory    NUMBER(5),
    id_person       NUMBER(5),
    CONSTRAINT uq_map_id_inventory UNIQUE (id_inventory)
);

TRUNCATE TABLE map_inventory_person; 

INSERT INTO map_inventory_person VALUES (2,1); 
INSERT INTO map_inventory_person VALUES (8,3); 
INSERT INTO map_inventory_person VALUES (5,3); 
INSERT INTO map_inventory_person VALUES (3,3); 
INSERT INTO map_inventory_person VALUES (6,6); 
INSERT INTO map_inventory_person VALUES (7,6); 
INSERT INTO map_inventory_person VALUES (9,2); 
--INSERT INTO map_inventory_person VALUES (9,3);  -- toto diky unique neprojde 

COMMIT; 

--fk map_inventory_person-person
ALTER TABLE map_inventory_person ADD CONSTRAINT fk_mapinv_person_id
FOREIGN KEY(id_person) REFERENCES person (id);

--fk map_inventory_person-inventory
ALTER TABLE map_inventory_person ADD CONSTRAINT fk_mapinv_inventory_id
FOREIGN KEY(id_inventory) REFERENCES inventory (id);


SELECT * FROM person per
JOIN map_inventory_person mip ON (per.id=mip.id_person)
JOIN inventory inv ON (mip.id_inventory=inv.id)
JOIN cat_inventory ci ON (ci.id=inv.id_type);

SELECT per.firstname|| ' ' || per.lastname as fullName, inv.name as inventory_name,ci.name as inventory
FROM person per
JOIN map_inventory_person mip ON (per.id=mip.id_person)
JOIN inventory inv ON (mip.id_inventory=inv.id)
JOIN cat_inventory ci ON (ci.id=inv.id_type);

SELECT name, id_type FROM inventory 
WHERE id NOT IN (
    SELECT id_inventory FROM map_inventory_person
)
;



SELECT name, id_type
FROM inventory
WHERE id NOT IN (
    SELECT id_inventory
    FROM map_inventory_person
);

SELECT inventory.name, inventory.id_type
FROM inventory
WHERE inventory.name NOT IN (
    SELECT
    inv.name
    FROM person per
    JOIN map_inventory_person mip ON (per.id=mip.id_person)
    JOIN inventory inv ON (mip.id_inventory=inv.id)
    JOIN cat_inventory ci ON (ci.id=inv.id_type));
    
SELECT name, id_type
FROM inventory
WHERE NOT EXISTS (
    SELECT id_inventory
    FROM map_inventory_person
    WHERE map_inventory_person.id_inventory = inventory.id
);

SELECT inventory.name, inventory.id_type,ci.name
FROM inventory
WHERE inventory.name NOT IN (
    SELECT
    inv.name
    FROM person per
    JOIN map_inventory_person mip ON (per.id=mip.id_person)
    JOIN inventory inv ON (mip.id_inventory=inv.id)
    JOIN cat_inventory ci ON (ci.id=inv.id_type));

SELECT inv.name,inv.price,inv.serial FROM person per
JOIN map_inventory_person mip ON (per.id=mip.id_person)
JOIN inventory inv ON (mip.id_inventory=inv.id)
JOIN cat_inventory ci ON (ci.id=inv.id_type);


SELECT SUM(inv.price), per.id_dept FROM person per
JOIN map_inventory_person mip ON (per.id=mip.id_person)
JOIN inventory inv ON (mip.id_inventory=inv.id)
JOIN cat_inventory ci ON (ci.id=inv.id_type)
WHERE inv.id_type =1 OR inv.id_type =2
GROUP BY per.id_dept;