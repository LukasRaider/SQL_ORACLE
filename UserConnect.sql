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

--ÚKOL1: Procviète jednoduché selecty. 
--Cviète na tabulce person, která vznikla díky vytváøecímu a 
--plnícímu skriptu v pøedchozí kapitole.
--výpis osob s platem vyšším než 28000
SELECT * FROM person WHERE salary > 28000;
--výpis všech žen
SELECT * FROM person WHERE sex = 'F';
--spojení pøedchozího, tedy výpis všech žen s platem nad 28000
SELECT * FROM person 
WHERE salary > 28000
AND sex = 'F';

--ÚKOL 2
--ORDER BY ... (ASC), DESC
--a)výpis seøazený podle pøíjmení
SELECT * FROM person ORDER BY lastname;
--b)výpis seøazený podle pøíjmení, v pøípadì stejného 
--pøíjmení jsou osoby seøazeny dále podle køestního jména sestupnì
SELECT * FROM person ORDER BY lastname, firstname DESC;
--c)totéž, ale nejprve budou všechny ženy, potom muži
SELECT * FROM person ORDER BY sex, lastname, firstname DESC;

--ÚKOL3:Aliasování tabulky: 
--a)vyhledejte v tabulce napøíklad osobu, 
--jejíž id je 1. Vytvoøte pøitom alias na tabulku person. 
--Ovìøte, zda je poté možno i nadále používat pùvodní název tabulky.
SELECT per.id, per.lastname FROM person per WHERE id=1;
--Aliasování sloupcù: 
--b)vypište tabulku tak, že v záhlaví místo firstName a 
--lastName bude Jméno a Pøíjmení
SELECT per.firstname AS jmeno, 
    per.lastname AS prijmeni
FROM person per 
WHERE id=1;
--c)vypište tabulku tak, že místo dvou sloupcù 
--(firstName a lastName) bude jeden, v nìm bude jméno 
--a pøíjmení oddìlené mezerou.
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

--ÚKOL 4: v tabulce person:
--A)z Novakù udìlejte Dvoraky. Ovìøte výpisem tabulky. 
--Bylo nutné použít commit? Po ovìøení vrate zpìt (pøíkaz ROLLBACK), 
--a v tom nemáme chaos. Nebo znovu spuste plnící skript.
--B)id všech záznamù zvyšte o 25. Ovìøte a pak vrate zpìt
--C)køestní jména pøeveïte na velká písmena. Ovìøte a pak vrate zpìt
--D)pøed pøíjmení pøidejte znak #. Ovìøte a pak vrate zpìt


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
SELECT id_dept as "Oddìlení", SUM(salary) as "Platy" FROM person  
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
INSERT INTO person VALUES(1, 'Mária', 'Vymazalová','F', '26',  24000, 3, '25.11.2014');
INSERT INTO person VALUES(2, 'Vít', 'Antoš ','M', '23',  23000, 3, '22/1/2011');
INSERT INTO person VALUES(3, 'Olena', 'Vránová','F', '35',  12000, 4, '3.9.2005');
INSERT INTO person VALUES(4, 'Rudolf', 'Motl ','M', '51',  28000, 4, '25/5/2010');
INSERT INTO person VALUES(5, 'Emília', 'Adamcová','F', '20',  19000, 4, '23.11.2018');
INSERT INTO person VALUES(6, 'Dalibor', 'Kubík ','M', '28',  37000, 4, '1/6/2005');
INSERT INTO person VALUES(7, 'Radomíra', 'Papežová','F', '28',  35000, 4, '11.1.2008');
INSERT INTO person VALUES(8, 'Michal', 'Fojtík ','M', '57',  42000, 4, '3/9/2017');
INSERT INTO person VALUES(9, 'Sára', 'Marková','F', '58',  35000, 3, '11.8.2019');
INSERT INTO person VALUES(10, 'Vladimír', 'Valenta ','M', '34',  16000, 3, '18/3/2009');
INSERT INTO person VALUES(11, 'Tatiana', 'Drábková','F', '20',  23000, 4, '19.5.2010');
INSERT INTO person VALUES(12, 'Roland', 'Dvorský ','M', '62',  20000, 4, '19/7/2008');
INSERT INTO person VALUES(13, 'Martina', 'Mazurová','F', '28',  38000, 1, '30.11.2015');
INSERT INTO person VALUES(14, 'Ferdinand', 'Pecka ','M', '45',  26000, 1, '28/5/2004');
INSERT INTO person VALUES(15, 'Hana', 'Heczková','F', '59',  46000, 4, '25.9.2012');
INSERT INTO person VALUES(16, 'Alex', 'Haná?ek ','M', '21',  35000, 4, '29/10/2015');
INSERT INTO person VALUES(17, 'Vlasta', 'Zárubová','F', '20',  26000, 4, '8.4.2018');
INSERT INTO person VALUES(18, '?estmír', 'Seifert ','M', '50',  40000, 4, '7/9/2011');
INSERT INTO person VALUES(19, 'Martina', 'Zbo?ilová','F', '52',  33000, 4, '2.2.2015');
INSERT INTO person VALUES(20, 'Imrich', 'Hole?ek ','M', '26',  13000, 4, '14/9/2006');
INSERT INTO person VALUES(21, 'Pavla', 'Krejzová','F', '59',  13000, 4, '22.3.2004');
INSERT INTO person VALUES(22, 'Arnošt', 'Mina?ík ','M', '55',  19000, 4, '16/12/2018');
INSERT INTO person VALUES(23, 'Zuzana', 'Honsová','F', '45',  21000, 4, '11.6.2017');
INSERT INTO person VALUES(24, 'Ondrej', 'Hrbek ','M', '32',  28000, 4, '24/12/2013');
INSERT INTO person VALUES(25, 'Zdenka', 'Pavlová','F', '52',  37000, 4, '30.7.2006');
INSERT INTO person VALUES(26, 'René', 'Kotlár ','M', '61',  33000, 4, '1/11/2009');
INSERT INTO person VALUES(27, 'Pavla', 'Houšková','F', '37',  44000, 3, '18.10.2019');
INSERT INTO person VALUES(28, 'Pavol', 'Pracha? ','M', '37',  42000, 3, '9/11/2004');
INSERT INTO person VALUES(29, 'Iva', 'Richterová','F', '45',  24000, 4, '5.12.2008');
INSERT INTO person VALUES(30, 'Ivo', 'Šim?ík ','M', '20',  47000, 4, '10/2/2017');
INSERT INTO person VALUES(31, 'Milada', 'Havlíková','F', '30',  32000, 3, '1.10.2005');
INSERT INTO person VALUES(32, 'Bohumir', 'Nová?ek ','M', '42',  21000, 3, '18/2/2012');
INSERT INTO person VALUES(33, 'Jindra', 'Hlavatá','F', '39',  20000, 4, '3.12.2012');
INSERT INTO person VALUES(34, 'Emil', 'Machálek ','M', '24',  25000, 4, '22/6/2011');
INSERT INTO person VALUES(35, 'Patricie', 'Gruberová','F', '46',  36000, 1, '16.6.2018');
INSERT INTO person VALUES(36, 'Martin', 'Baloun ','M', '53',  31000, 1, '30/4/2007');
INSERT INTO person VALUES(37, 'Žofie', 'Mazánková','F', '31',  43000, 4, '12.4.2015');
INSERT INTO person VALUES(38, 'Robert', 'Hýbl ','M', '29',  40000, 4, '30/9/2018');
INSERT INTO person VALUES(39, 'Na?a', 'Kuželová','F', '39',  23000, 1, '30.5.2004');
INSERT INTO person VALUES(40, 'Adrian', 'Soukup ','M', '58',  45000, 1, '9/8/2014');
INSERT INTO person VALUES(41, 'Johana', 'Šindlerová','F', '24',  31000, 4, '18.8.2017');
INSERT INTO person VALUES(42, 'Antonín', 'Vít ','M', '35',  18000, 4, '16/8/2009');
INSERT INTO person VALUES(43, 'Ema', 'Blechová','F', '55',  38000, 3, '14.6.2014');
INSERT INTO person VALUES(44, 'Jozef', 'Smola ','M', '57',  27000, 3, '23/8/2004');
INSERT INTO person VALUES(45, 'Oksana', 'Machá?ková','F', '63',  18000, 4, '2.8.2003');
INSERT INTO person VALUES(46, 'Jan', 'Pašek ','M', '40',  33000, 4, '25/11/2016');
INSERT INTO person VALUES(47, 'Ilona', 'Valášková','F', '25',  42000, 1, '4.10.2010');
INSERT INTO person VALUES(48, 'Vojtech', 'Urbánek ','M', '22',  37000, 1, '28/3/2016');
INSERT INTO person VALUES(49, 'Bára', 'Fiedlerová','F', '55',  42000, 4, '9.12.2005');
INSERT INTO person VALUES(50, 'Herbert', 'Pluha? ','M', '45',  47000, 4, '12/10/2007');
INSERT INTO person VALUES(51, 'Jind?iška', 'Kliková','F', '64',  29000, 1, '10.2.2013');
INSERT INTO person VALUES(52, 'Juliús', 'Pa?ízek ','M', '27',  16000, 1, '12/2/2007');
INSERT INTO person VALUES(53, 'Ilona', 'Niklová','F', '49',  37000, 4, '7.12.2009');
INSERT INTO person VALUES(54, 'Prokop', 'Šimá?ek ','M', '50',  25000, 4, '15/7/2018');
INSERT INTO person VALUES(55, 'Magdalena', 'Petrášová','F', '57',  17000, 1, '20.6.2015');
INSERT INTO person VALUES(56, 'Viliam', 'Hanzal ','M', '32',  30000, 1, '24/5/2014');
INSERT INTO person VALUES(57, 'Danuše', 'Jav?rková','F', '42',  25000, 4, '14.4.2012');
INSERT INTO person VALUES(58, 'Bruno', 'Št?pánek ','M', '55',  39000, 4, '31/5/2009');
INSERT INTO person VALUES(59, 'Aloisie', 'H?lková','F', '51',  12000, 1, '17.6.2019');
INSERT INTO person VALUES(60, 'Norbert', 'Balcar ','M', '37',  44000, 1, '1/10/2008');
INSERT INTO person VALUES(61, 'Magdalena', '?ermáková','F', '35',  12000, 4, '22.8.2014');
INSERT INTO person VALUES(62, 'Hubert', 'Homola ','M', '60',  18000, 4, '9/9/2016');
INSERT INTO person VALUES(63, 'Zd?nka', 'Kupková','F', '43',  36000, 1, '31.5.2005');
INSERT INTO person VALUES(64, 'Dan', 'Mokrý ','M', '42',  22000, 1, '11/1/2016');
INSERT INTO person VALUES(65, 'Karla', 'Hrabalová','F', '28',  35000, 4, '29.12.2016');
INSERT INTO person VALUES(66, 'Karol', 'Pícha ','M', '19',  32000, 4, '27/7/2007');
INSERT INTO person VALUES(67, 'Radana', 'Paterová','F', '36',  23000, 1, '8.10.2007');
INSERT INTO person VALUES(68, 'Radoslav', 'Šíma ','M', '47',  37000, 1, '27/11/2006');
INSERT INTO person VALUES(69, 'Lucie', 'Hronová','F', '43',  39000, 1, '20.4.2013');
INSERT INTO person VALUES(70, 'Lud?k', 'Kouba ','M', '30',  42000, 1, '28/2/2019');
INSERT INTO person VALUES(71, 'Iryna', 'Schwarzová','F', '29',  47000, 1, '13.2.2010');
INSERT INTO person VALUES(72, 'Kryštof', 'Hendrych ','M', '53',  15000, 1, '8/3/2014');
INSERT INTO person VALUES(73, 'Ivana', 'N?mcová','F', '36',  27000, 1, '27.8.2015');
INSERT INTO person VALUES(74, 'Ivan', 'Rezek ','M', '36',  21000, 1, '14/1/2010');
INSERT INTO person VALUES(75, 'Petra', 'Kotasová','F', '22',  34000, 4, '22.6.2012');
INSERT INTO person VALUES(76, 'Ludvík', 'Bažant ','M', '58',  30000, 4, '21/1/2005');
INSERT INTO person VALUES(77, 'Laura', 'Mizerová','F', '53',  42000, 4, '18.4.2009');
INSERT INTO person VALUES(78, 'Mojmír', 'Pavlí?ek ','M', '34',  39000, 4, '24/6/2016');
INSERT INTO person VALUES(79, 'Ivana', 'T?ísková','F', '60',  22000, 4, '30.10.2014');
INSERT INTO person VALUES(80, 'Radim', 'Sláma ','M', '63',  44000, 4, '2/5/2012');
INSERT INTO person VALUES(81, 'Linda', 'Kalábová','F', '23',  46000, 1, '8.8.2005');
INSERT INTO person VALUES(82, 'Marek', 'Lebeda ','M', '45',  13000, 1, '3/9/2011');
INSERT INTO person VALUES(83, 'Dana', 'Urbánková','F', '53',  45000, 4, '8.3.2017');
INSERT INTO person VALUES(84, 'Daniel', 'Žiga ','M', '22',  23000, 4, '12/8/2019');
INSERT INTO person VALUES(85, 'Sylva', 'Homolková','F', '62',  33000, 1, '15.12.2007');
INSERT INTO person VALUES(86, 'Pavel', 'Ž?árský ','M', '50',  27000, 1, '13/12/2018');
INSERT INTO person VALUES(87, 'Andrea', 'Hurtová','F', '46',  33000, 4, '15.7.2019');
INSERT INTO person VALUES(88, 'Jaroslav', 'Ho?ejší ','M', '28',  37000, 4, '28/6/2010');
INSERT INTO person VALUES(89, 'Maria', 'Líbalová','F', '54',  20000, 1, '23.4.2010');
INSERT INTO person VALUES(90, 'Rastislav', 'Veverka ','M', '56',  42000, 1, '29/10/2009');
INSERT INTO person VALUES(91, 'Darina', 'Zahradní?ková','F', '40',  28000, 4, '17.2.2007');
INSERT INTO person VALUES(92, 'Roman', 'Mi?ka ','M', '32',  15000, 4, '5/11/2004');
INSERT INTO person VALUES(93, 'Karolina', 'Jan?íková','F', '47',  44000, 1, '30.8.2012');
INSERT INTO person VALUES(94, 'Oliver', 'Chvojka ','M', '61',  20000, 1, '7/2/2017');
INSERT INTO person VALUES(95, 'Miluška', 'Táborská','F', '32',  16000, 4, '26.6.2009');
INSERT INTO person VALUES(96, 'Ji?í', 'Michna ','M', '37',  29000, 4, '15/2/2012');
INSERT INTO person VALUES(97, 'Valerie', 'Ježková','F', '40',  31000, 1, '7.1.2015');
INSERT INTO person VALUES(98, '?en?k', 'Kotas ','M', '20',  35000, 1, '24/12/2007');
INSERT INTO person VALUES(99, 'Jaromíra', 'Bedná?ová','F', '25',  39000, 4, '2.11.2011');
INSERT INTO person VALUES(100, 'Gejza', 'Horký ','M', '43',  44000, 4, '27/5/2019');
INSERT INTO person VALUES(101, 'Gertruda', 'Suchomelová','F', '32',  19000, 4, '15.5.2017');
INSERT INTO person VALUES(102, 'Samuel', 'Hanzlík ','M', '25',  13000, 4, '4/4/2015');
INSERT INTO person VALUES(103, 'Miluše', 'Pet?í?ková','F', '41',  43000, 2, '22.2.2008');
INSERT INTO person VALUES(104, 'Bronislav', 'Šimák ','M', '53',  18000, 2, '6/8/2014');
INSERT INTO person VALUES(105, 'Svitlana', 'P?ikrylová','F', '25',  42000, 4, '22.9.2019');
INSERT INTO person VALUES(106, 'Alexander 4 000', 'Pham ','M', '31',  27000, 4, '18/2/2006');
INSERT INTO person VALUES(107, 'Nad?žda', 'Blechová','F', '34',  30000, 1, '1.7.2010');
INSERT INTO person VALUES(108, 'Šimon', 'Kraus ','M', '59',  32000, 1, '21/6/2005');
INSERT INTO person VALUES(109, 'Daniela', 'Landová','F', '19',  38000, 1, '27.4.2007');
INSERT INTO person VALUES(110, 'Tibor', 'Nedv?d ','M', '35',  41000, 1, '22/11/2016');
INSERT INTO person VALUES(111, 'Alžb?ta', 'Mašková','F', '26',  18000, 1, '7.11.2012');
INSERT INTO person VALUES(112, 'Alois', 'Mikula ','M', '64',  47000, 1, '30/9/2012');
INSERT INTO person VALUES(113, 'Nad?žda', 'Malá','F', '58',  25000, 1, '2.9.2009');
INSERT INTO person VALUES(114, 'Svatopluk', '?ernohorský ','M', '40',  20000, 1, '8/10/2007');
INSERT INTO person VALUES(115, 'Sabina', 'Polanská','F', '19',  41000, 1, '16.3.2015');
INSERT INTO person VALUES(116, 'Old?ich', 'Šimánek ','M', '23',  25000, 1, '17/8/2003');
INSERT INTO person VALUES(117, 'Mária', 'Nguyenová','F', '51',  13000, 4, '10.1.2012');
INSERT INTO person VALUES(118, 'Peter', 'Doležal ','M', '46',  34000, 4, '17/1/2015');
INSERT INTO person VALUES(119, 'Erika', 'Lukešová','F', '58',  29000, 1, '23.7.2017');
INSERT INTO person VALUES(120, 'Milan', 'Jaroš ','M', '29',  39000, 1, '26/11/2010');
INSERT INTO person VALUES(121, 'Sabina', 'Stránská','F', '43',  36000, 4, '19.5.2014');
INSERT INTO person VALUES(122, 'Dušan', 'Lacina ','M', '51',  13000, 4, '3/12/2005');
INSERT INTO person VALUES(123, 'Radomíra', 'Fischerová','F', '52',  24000, 1, '25.2.2005');
INSERT INTO person VALUES(124, 'Jaromír', 'Kavka ','M', '33',  17000, 1, '5/4/2005');
INSERT INTO person VALUES(125, 'Hana', '?ermáková','F', '59',  40000, 2, '8.9.2010');
INSERT INTO person VALUES(126, 'Vasil', 'Remeš ','M', '62',  23000, 2, '8/7/2017');
INSERT INTO person VALUES(127, 'Natalie', 'Veselá','F', '45',  12000, 1, '4.7.2007');
INSERT INTO person VALUES(128, 'Tomáš', 'Klimeš ','M', '38',  32000, 1, '15/7/2012');
INSERT INTO person VALUES(129, 'Martina', 'Hrabalová','F', '52',  27000, 2, '14.1.2013');
INSERT INTO person VALUES(130, 'Albert', 'Burda ','M', '21',  37000, 2, '23/5/2008');
INSERT INTO person VALUES(131, 'Hana', 'Jiráková','F', '37',  35000, 1, '10.11.2009');
INSERT INTO person VALUES(132, 'Zbyšek', 'Zach ','M', '43',  46000, 1, '25/10/2019');
INSERT INTO person VALUES(133, 'Natalie', 'Dubová','F', '23',  43000, 4, '6.9.2006');
INSERT INTO person VALUES(134, 'Radek', 'Kulhavý ','M', '20',  19000, 4, '1/11/2014');
INSERT INTO person VALUES(135, 'Jitka', 'Bendová','F', '30',  22000, 1, '19.3.2012');
INSERT INTO person VALUES(136, 'Tobiáš', 'Rambousek ','M', '49',  25000, 1, '10/9/2010');
INSERT INTO person VALUES(137, 'Jolana', 'Machalová','F', '39',  46000, 2, '22.5.2019');
INSERT INTO person VALUES(138, 'Petro', '?ervinka ','M', '31',  29000, 2, '11/1/2010');
INSERT INTO person VALUES(139, 'Zuzana', 'Hor?áková','F', '23',  46000, 1, '27.7.2014');
INSERT INTO person VALUES(140, 'Kristián', 'Ková? ','M', '54',  39000, 1, '19/12/2017');
INSERT INTO person VALUES(141, 'Vladislava', 'Mizerová','F', '31',  34000, 2, '5.5.2005');
INSERT INTO person VALUES(142, 'Boris', 'Hejda ','M', '36',  44000, 2, '22/4/2017');
INSERT INTO person VALUES(143, 'Barbora', 'Franková','F', '62',  33000, 4, '2.12.2016');
INSERT INTO person VALUES(144, 'Leopold', 'Gajdoš ','M', '59',  17000, 4, '4/11/2008');
INSERT INTO person VALUES(145, 'Ivanka', 'Medková','F', '24',  21000, 2, '11.9.2007');
INSERT INTO person VALUES(146, 'Robin', 'Šilhavý ','M', '41',  22000, 2, '7/3/2008');
INSERT INTO person VALUES(147, 'Dita', 'Balcarová','F', '55',  29000, 1, '7.7.2004');
INSERT INTO person VALUES(148, 'Leo', 'Kalina ','M', '64',  31000, 1, '9/8/2019');
INSERT INTO person VALUES(149, 'Jindra', 'Pavelková','F', '63',  45000, 1, '18.1.2010');
INSERT INTO person VALUES(150, 'Vratislav', 'Barták ','M', '46',  37000, 1, '17/6/2015');
INSERT INTO person VALUES(151, 'Elena', 'Mat?jková','F', '48',  16000, 1, '14.11.2006');
INSERT INTO person VALUES(152, 'Slavomír', 'Merta ','M', '23',  46000, 1, '24/6/2010');
INSERT INTO person VALUES(153, 'Žofie', 'Pale?ková','F', '55',  32000, 1, '27.5.2012');
INSERT INTO person VALUES(154, 'Kamil', 'Orság ','M', '52',  15000, 1, '3/5/2006');
INSERT INTO person VALUES(155, 'Michala', 'Korbelová','F', '41',  40000, 1, '22.3.2009');
INSERT INTO person VALUES(156, 'Erik', 'Levý ','M', '28',  24000, 1, '3/10/2017');
INSERT INTO person VALUES(157, 'Johana', 'Ondrá?ková','F', '48',  20000, 1, '3.10.2014');
INSERT INTO person VALUES(158, 'Miloš', 'Macák ','M', '57',  29000, 1, '12/8/2013');
INSERT INTO person VALUES(159, 'Radka', 'Táborská','F', '57',  44000, 2, '12.7.2005');
INSERT INTO person VALUES(160, 'Vladimír', 'Zima ','M', '39',  34000, 2, '13/12/2012');
INSERT INTO person VALUES(161, 'Iveta', 'Knotková','F', '42',  15000, 2, '1.10.2018');
INSERT INTO person VALUES(162, 'Bohuslav', 'Hrbá?ek ','M', '61',  43000, 2, '21/12/2007');
INSERT INTO person VALUES(163, 'Ilona', 'Bedná?ová','F', '49',  31000, 2, '19.11.2007');
INSERT INTO person VALUES(164, 'Ernest', 'Pato?ka ','M', '44',  13000, 2, '30/10/2003');
INSERT INTO person VALUES(165, 'Radka', 'Bláhová','F', '35',  39000, 1, '14.9.2004');
INSERT INTO person VALUES(166, 'Aleš', 'Marek ','M', '21',  22000, 1, '1/4/2015');
INSERT INTO person VALUES(167, 'Danuše', 'Bergerová','F', '42',  18000, 2, '28.3.2010');
INSERT INTO person VALUES(168, 'Vladan', 'Machá?ek ','M', '50',  27000, 2, '7/2/2011');
INSERT INTO person VALUES(169, 'Aneta', 'Ambrožová','F', '28',  26000, 1, '22.1.2007');
INSERT INTO person VALUES(170, 'Václav', 'Seidl ','M', '26',  36000, 1, '15/2/2006');
INSERT INTO person VALUES(171, 'Magdalena', 'Polá?ková','F', '35',  42000, 2, '4.8.2012');
INSERT INTO person VALUES(172, 'Norbert', 'Jakubec ','M', '55',  41000, 2, '19/5/2018');
INSERT INTO person VALUES(173, 'Danuše', 'Vaší?ková','F', '20',  14000, 1, '30.5.2009');
INSERT INTO person VALUES(174, 'Maxmilián', 'Polanský ','M', '31',  15000, 1, '27/5/2013');
INSERT INTO person VALUES(175, 'Aloisie', 'Synková','F', '29',  37000, 2, '1.8.2016');
INSERT INTO person VALUES(176, 'Zoltán', 'Adamec ','M', '59',  19000, 2, '27/9/2012');
INSERT INTO person VALUES(177, 'Ladislava', 'Zezulová','F', '59',  37000, 1, '7.10.2011');
INSERT INTO person VALUES(178, 'Vasil', 'Kotrba ','M', '36',  29000, 1, '11/4/2004');
INSERT INTO person VALUES(179, 'Hanna', 'Zemanová','F', '22',  25000, 2, '9.12.2018');
INSERT INTO person VALUES(180, 'Augustin', 'Wagner ','M', '64',  34000, 2, '14/8/2003');
INSERT INTO person VALUES(181, 'Iryna', 'Kasalová','F', '29',  41000, 2, '27.1.2008');
INSERT INTO person VALUES(182, 'Bohumír', 'Hr?za ','M', '47',  39000, 2, '15/11/2015');
INSERT INTO person VALUES(183, 'Radana', 'Petráková','F', '60',  12000, 2, '22.11.2004');
INSERT INTO person VALUES(184, 'Oto', 'Knap ','M', '24',  12000, 2, '22/11/2010');
INSERT INTO person VALUES(185, 'Lucie', 'Stránská','F', '22',  28000, 2, '5.6.2010');
INSERT INTO person VALUES(186, 'Eduard', 'Urbanec ','M', '53',  17000, 2, '1/10/2006');
INSERT INTO person VALUES(187, 'Laura', 'Šindelá?ová','F', '53',  36000, 2, '31.3.2007');
INSERT INTO person VALUES(188, 'Juraj', 'Dan?k ','M', '29',  27000, 2, '3/3/2018');
INSERT INTO person VALUES(189, 'Ivana', 'Janatová','F', '60',  16000, 2, '11.10.2012');
INSERT INTO person VALUES(190, 'Dominik', 'Šebesta ','M', '58',  32000, 2, '10/1/2014');
INSERT INTO person VALUES(191, 'Petra', 'Šípková','F', '46',  23000, 1, '7.8.2009');
INSERT INTO person VALUES(192, 'Marian', 'Mužík ','M', '34',  41000, 1, '17/1/2009');
INSERT INTO person VALUES(193, 'Nela', 'Ku?ová','F', '54',  47000, 3, '9.10.2016');
INSERT INTO person VALUES(194, 'Jozef', 'Bayer ','M', '62',  46000, 3, '20/5/2008');
INSERT INTO person VALUES(195, 'Michaela', 'Škodová','F', '39',  47000, 1, '15.12.2011');
INSERT INTO person VALUES(196, 'Štefan', 'Kalivoda ','M', '39',  19000, 1, '28/4/2016');
INSERT INTO person VALUES(197, 'Linda', 'Dubová','F', '47',  35000, 2, '16.2.2019');
INSERT INTO person VALUES(198, 'Lubomír', '?ejka ','M', '21',  24000, 2, '30/8/2015');
INSERT INTO person VALUES(199, 'Dana', 'Grundzová','F', '31',  34000, 1, '23.4.2014');
INSERT INTO person VALUES(200, 'Patrik', 'Kova?ík ','M', '45',  34000, 1, '14/3/2007');
INSERT INTO person VALUES(201, 'Darina', 'Havelková','F', '40',  22000, 2, '29.1.2005');
INSERT INTO person VALUES(202, 'Jakub', 'Hanus ','M', '27',  39000, 2, '16/7/2006');
INSERT INTO person VALUES(203, 'Karolina', 'Hor?áková','F', '47',  38000, 3, '12.8.2010');
INSERT INTO person VALUES(204, 'J?lius', 'Stárek ','M', '56',  44000, 3, '17/10/2018');
INSERT INTO person VALUES(205, 'Maria', 'Lebedová','F', '33',  45000, 2, '8.6.2007');
INSERT INTO person VALUES(206, 'Svatoslav', 'Pilát ','M', '32',  17000, 2, '25/10/2013');
INSERT INTO person VALUES(207, 'Valerie', 'Franková','F', '40',  25000, 3, '19.12.2012');
INSERT INTO person VALUES(208, 'Leo', 'Ju?ík ','M', '61',  22000, 3, '2/9/2009');
INSERT INTO person VALUES(209, 'Jaromíra', 'Koubová','F', '25',  33000, 2, '15.10.2009');
INSERT INTO person VALUES(210, 'Stepan', 'Bauer ','M', '37',  31000, 2, '9/9/2004');
INSERT INTO person VALUES(211, 'Miluška', 'Hofmanová','F', '57',  41000, 1, '11.8.2006');
INSERT INTO person VALUES(212, 'Vladimír', 'Oláh ','M', '60',  41000, 1, '11/2/2016');
INSERT INTO person VALUES(213, 'Valerie', 'Chadimová','F', '64',  20000, 2, '22.2.2012');
INSERT INTO person VALUES(214, 'Róbert', 'Janá?ek ','M', '43',  46000, 2, '20/12/2011');
INSERT INTO person VALUES(215, 'Klára', 'Mat?jková','F', '27',  44000, 3, '26.4.2019');
INSERT INTO person VALUES(216, 'Ferdinand', 'Havlí?ek ','M', '25',  15000, 3, '22/4/2011');
INSERT INTO person VALUES(217, 'Gertruda', 'Šestáková','F', '57',  44000, 2, '30.6.2014');
INSERT INTO person VALUES(218, 'Emanuel', 'Kolman ','M', '48',  24000, 2, '31/3/2019');
INSERT INTO person VALUES(219, 'Daniela', 'Korbelová','F', '19',  32000, 3, '8.4.2005');
INSERT INTO person VALUES(220, '?estmír', 'Antoš ','M', '30',  29000, 3, '1/8/2018');
INSERT INTO person VALUES(221, 'Regina', 'Cinová','F', '49',  31000, 1, '6.11.2016');
INSERT INTO person VALUES(222, 'Andrej', 'Chalupa ','M', '53',  39000, 1, '14/2/2010');
INSERT INTO person VALUES(223, 'Nad?žda', 'Karásková','F', '58',  19000, 3, '16.8.2007');
INSERT INTO person VALUES(224, 'Arnošt', 'Rozsypal ','M', '35',  43000, 3, '17/6/2009');
INSERT INTO person VALUES(225, 'Daniela', 'Dufková','F', '43',  27000, 2, '11.6.2004');
INSERT INTO person VALUES(226, 'Ondrej', 'Otáhal ','M', '57',  17000, 2, '24/6/2004');
INSERT INTO person VALUES(227, 'Mária', 'Sva?inová','F', '51',  43000, 2, '23.12.2009');
INSERT INTO person VALUES(228, 'Marcel', 'Tichý ','M', '40',  22000, 2, '26/9/2016');
INSERT INTO person VALUES(229, 'Anežka', 'Hanzalová','F', '36',  14000, 2, '18.10.2006');
INSERT INTO person VALUES(230, 'Pavol', 'Popelka ','M', '63',  31000, 2, '4/10/2011');
INSERT INTO person VALUES(231, 'Sabina', 'Buchtová','F', '43',  30000, 2, '30.4.2012');
INSERT INTO person VALUES(232, 'Ivo', '?onka ','M', '46',  36000, 2, '12/8/2007');
INSERT INTO person VALUES(233, 'Mária', 'Kola?íková','F', '29',  38000, 2, '24.2.2009');
INSERT INTO person VALUES(234, 'Bohumir', 'Hor?ák ','M', '22',  45000, 2, '13/1/2019');
INSERT INTO person VALUES(235, 'Sára', 'Štorková','F', '36',  18000, 2, '7.9.2014');
INSERT INTO person VALUES(236, 'Vojt?ch', 'Horník ','M', '51',  15000, 2, '21/11/2014');
INSERT INTO person VALUES(237, 'Tatiana', 'Vaší?ková','F', '45',  41000, 3, '16.6.2005');
INSERT INTO person VALUES(238, 'Martin', 'Hole?ek ','M', '33',  19000, 3, '24/3/2014');
INSERT INTO person VALUES(239, 'Miriam', 'Ko?ínková','F', '30',  13000, 2, '5.9.2018');
INSERT INTO person VALUES(240, 'Robert', 'Vybíral ','M', '55',  29000, 2, '1/4/2009');
INSERT INTO person VALUES(241, 'Hana', 'Zezulová','F', '37',  29000, 3, '24.10.2007');
INSERT INTO person VALUES(242, 'Artur', 'Volný ','M', '38',  34000, 3, '7/2/2005');
INSERT INTO person VALUES(243, 'Natalie', 'Rozsypalová','F', '23',  37000, 2, '19.8.2004');
INSERT INTO person VALUES(244, 'Antonín', 'Neuman ','M', '60',  43000, 2, '11/7/2016');
INSERT INTO person VALUES(245, 'Martina', 'Matušková','F', '30',  16000, 3, '2.3.2010');
INSERT INTO person VALUES(246, 'Gerhard', 'Pracha? ','M', '43',  12000, 3, '19/5/2012');
INSERT INTO person VALUES(247, 'Anna', 'Hubá?ková','F', '62',  24000, 2, '26.12.2006');
INSERT INTO person VALUES(248, 'Petr', 'Richter ','M', '20',  21000, 2, '27/5/2007');
INSERT INTO person VALUES(249, 'Zuzana', 'Be?ková','F', '23',  40000, 3, '8.7.2012');
INSERT INTO person VALUES(250, 'Cyril', 'Ptá?ek ','M', '49',  27000, 3, '29/8/2019');
INSERT INTO person VALUES(251, 'Jitka', 'Linková','F', '54',  47000, 2, '4.5.2009');
INSERT INTO person VALUES(252, 'Herbert', 'Dubský ','M', '25',  36000, 2, '5/9/2014');
INSERT INTO person VALUES(253, 'Leona', 'Macková','F', '63',  35000, 3, '6.7.2016');
INSERT INTO person VALUES(254, 'Juliús', 'Vinš ','M', '53',  41000, 3, '6/1/2014');
INSERT INTO person VALUES(255, 'Božena', 'Kašpárková','F', '47',  35000, 2, '11.9.2011');
INSERT INTO person VALUES(256, 'Július', 'Vav?ík ','M', '30',  14000, 2, '22/7/2005');
INSERT INTO person VALUES(257, 'Vladislava', 'Slová?ková','F', '56',  23000, 3, '13.11.2018');
INSERT INTO person VALUES(258, 'Viliam', 'Tomek ','M', '58',  19000, 3, '22/11/2004');
INSERT INTO person VALUES(259, 'Leona', 'Komínková','F', '41',  30000, 2, '8.9.2015');
INSERT INTO person VALUES(260, 'Bruno', 'Vondrák ','M', '35',  28000, 2, '24/4/2016');
INSERT INTO person VALUES(261, 'Marie', 'Bayerová','F', '50',  18000, 3, '17.6.2006');
INSERT INTO person VALUES(262, 'Norbert', 'Jení?ek ','M', '63',  33000, 3, '27/8/2015');
INSERT INTO person VALUES(263, 'Dita', 'Radová','F', '34',  18000, 2, '15.1.2018');
INSERT INTO person VALUES(264, 'Hubert', 'Nešpor ','M', '40',  43000, 2, '11/3/2007');
INSERT INTO person VALUES(265, 'Lucie', 'Pašková','F', '42',  42000, 3, '24.10.2008');
INSERT INTO person VALUES(266, 'Dan', 'Malina ','M', '22',  47000, 3, '12/7/2006');
INSERT INTO person VALUES(267, 'Elena', 'Ji?íková','F', '26',  41000, 2, '30.12.2003');
INSERT INTO person VALUES(268, 'Karol', 'David ','M', '45',  21000, 2, '20/6/2014');
INSERT INTO person VALUES(269, 'Ji?ina', 'Pešková','F', '35',  29000, 3, '3.3.2011');
INSERT INTO person VALUES(270, 'Radoslav', 'Hartman ','M', '27',  26000, 3, '21/10/2013');
INSERT INTO person VALUES(271, 'Lucie', 'Havlí?ková','F', '20',  37000, 2, '27.12.2007');
INSERT INTO person VALUES(272, 'Albert', 'Kolman ','M', '49',  35000, 2, '28/10/2008');
INSERT INTO person VALUES(273, 'Libuše', 'Tóthová','F', '28',  17000, 3, '9.7.2013');
INSERT INTO person VALUES(274, 'Kryštof', 'Strej?ek ','M', '32',  40000, 3, '6/9/2004');
INSERT INTO person VALUES(275, 'Ivana', 'Cihlá?ová','F', '59',  24000, 2, '5.5.2010');
INSERT INTO person VALUES(276, 'Bohdan', 'Chalupa ','M', '55',  13000, 2, '7/2/2016');
INSERT INTO person VALUES(277, 'Iveta', 'Kucha?ová','F', '20',  40000, 3, '16.11.2015');
INSERT INTO person VALUES(278, 'Ludvík', 'Kozel ','M', '38',  19000, 3, '17/12/2011');
INSERT INTO person VALUES(279, 'Nela', 'Dole?ková','F', '53',  20000, 3, '3.5.2014');
INSERT INTO person VALUES(280, 'Petro', 'H?lka ','M', '59',  27000, 3, '18/6/2010');
INSERT INTO person VALUES(281, 'Sylva', 'Tome?ková','F', '60',  36000, 3, '21.6.2003');
INSERT INTO person VALUES(282, 'Marian', 'Tichý ','M', '42',  32000, 3, '26/4/2006');
INSERT INTO person VALUES(283, 'Linda', 'Pospíchalová','F', '46',  43000, 3, '8.9.2016');
INSERT INTO person VALUES(284, 'Boris', 'Popelka ','M', '64',  42000, 3, '27/9/2017');
INSERT INTO person VALUES(285, 'Maria', 'Bartošová','F', '53',  23000, 3, '28.10.2005');
INSERT INTO person VALUES(286, 'Štefan', '?onka ','M', '47',  47000, 3, '5/8/2013');
INSERT INTO person VALUES(287, 'Darina', 'R?ži?ková','F', '39',  31000, 2, '16.1.2019');
INSERT INTO person VALUES(288, 'Robin', 'Hor?ák ','M', '24',  20000, 2, '12/8/2008');
INSERT INTO person VALUES(289, 'Karolina', 'Hanusová','F', '46',  47000, 3, '5.3.2008');
INSERT INTO person VALUES(290, 'Bohumil', 'Horník ','M', '52',  25000, 3, '21/6/2004');
INSERT INTO person VALUES(291, 'Maria', 'Boudová','F', '31',  18000, 2, '30.12.2004');
INSERT INTO person VALUES(292, 'Vratislav', 'Kalaš ','M', '29',  34000, 2, '22/11/2015');
INSERT INTO person VALUES(293, 'Markéta', 'Linková','F', '40',  42000, 3, '3.3.2012');
INSERT INTO person VALUES(294, 'Št?pán', 'Šafá? ','M', '57',  39000, 3, '25/3/2015');
INSERT INTO person VALUES(295, 'Renata', 'Chytilová','F', '47',  22000, 4, '14.9.2017');
INSERT INTO person VALUES(296, 'Po?et', 'Volný ','M', '40',  44000, 4, '1/2/2011');
INSERT INTO person VALUES(297, 'R?žena', 'Kašpárková','F', '33',  30000, 3, '11.7.2014');
INSERT INTO person VALUES(298, 'Jind?ich', 'Neuman ','M', '62',  18000, 3, '8/2/2006');
INSERT INTO person VALUES(299, 'Miluše', 'Svobodová','F', '40',  45000, 4, '29.8.2003');
INSERT INTO person VALUES(300, 'Stepan', 'Pracha? ','M', '45',  23000, 4, '13/5/2018');
INSERT INTO person VALUES(301, 'Klára', 'Kubištová','F', '25',  17000, 3, '16.11.2016');
INSERT INTO person VALUES(302, 'Vladimír', 'Richter ','M', '21',  32000, 3, '20/5/2013');
INSERT INTO person VALUES(303, 'Eliška', 'Michlová','F', '57',  25000, 2, '12.9.2013');
INSERT INTO person VALUES(304, 'Bohuslav', 'Šesták ','M', '44',  41000, 2, '27/5/2008');
INSERT INTO person VALUES(305, 'Miluše', 'Lacková','F', '64',  40000, 3, '26.3.2019');
INSERT INTO person VALUES(306, 'Ernest', 'Dubský ','M', '27',  46000, 3, '5/4/2004');
INSERT INTO person VALUES(307, 'Nina', 'Kolková','F', '27',  28000, 4, '2.1.2010');
INSERT INTO person VALUES(308, 'Oskar', 'Podzimek ','M', '55',  15000, 4, '7/8/2003');
INSERT INTO person VALUES(309, 'Nad?žda', 'Kohoutová','F', '57',  28000, 3, '9.3.2005');
INSERT INTO person VALUES(310, 'Vladan', 'Vav?ík ','M', '32',  25000, 3, '16/7/2011');
INSERT INTO person VALUES(311, 'Emília', 'Pla?ková','F', '19',  16000, 4, '11.5.2012');
INSERT INTO person VALUES(312, '?ubomír', 'Tomek ','M', '60',  29000, 4, '16/11/2010');
INSERT INTO person VALUES(313, 'Alžb?ta', 'Karlová','F', '49',  15000, 2, '16.7.2007');
INSERT INTO person VALUES(314, 'Norbert', 'Kubí?ek ','M', '37',  39000, 2, '24/10/2018');
INSERT INTO person VALUES(315, 'Olena', 'Nedomová','F', '58',  39000, 4, '17.9.2014');
INSERT INTO person VALUES(316, 'Jonáš', 'Smola ','M', '19',  44000, 4, '25/2/2018');
INSERT INTO person VALUES(317, 'Tatiana', 'Janáková','F', '19',  19000, 4, '5.11.2003');
INSERT INTO person VALUES(318, 'Marcel', 'Hejduk ','M', '48',  13000, 4, '3/1/2014');
INSERT INTO person VALUES(319, 'Radomíra', 'Janková','F', '51',  27000, 3, '24.1.2017');
INSERT INTO person VALUES(320, 'Pavol', 'Jirka ','M', '24',  22000, 3, '10/1/2009');
INSERT INTO person VALUES(321, 'V?ra', 'Petrová','F', '58',  43000, 4, '14.3.2006');
INSERT INTO person VALUES(322, 'Rostislav', 'Pluha? ','M', '53',  28000, 4, '19/11/2004');
INSERT INTO person VALUES(323, 'Tatiana', 'Kašparová','F', '43',  14000, 3, '3.6.2019');
INSERT INTO person VALUES(324, 'Bohumír', 'Št?rba ','M', '30',  37000, 3, '21/4/2016');
INSERT INTO person VALUES(325, 'Radomíra', 'Pavlíková','F', '29',  22000, 3, '29.3.2016');
INSERT INTO person VALUES(326, 'Oto', 'Kaplan ','M', '52',  46000, 3, '29/4/2011');
INSERT INTO person VALUES(327, 'Hana', 'Vrabcová','F', '36',  38000, 3, '17.5.2005');
INSERT INTO person VALUES(328, 'Eduard', 'Kope?ný ','M', '35',  15000, 3, '8/3/2007');
INSERT INTO person VALUES(329, 'Alexandra', 'Drápalová','F', '45',  26000, 4, '18.7.2012');
INSERT INTO person VALUES(330, 'Mat?j', 'Št?pánek ','M', '63',  20000, 4, '9/7/2006');
INSERT INTO person VALUES(331, 'Martina', 'Žá?ková','F', '29',  25000, 3, '23.9.2007');
INSERT INTO person VALUES(332, 'Dominik', 'Dole?ek ','M', '40',  30000, 3, '17/6/2014');
INSERT INTO person VALUES(333, 'Jolana', 'Kantorová','F', '37',  13000, 4, '25.11.2014');
INSERT INTO person VALUES(334, 'Antonín', 'Demeter ','M', '22',  34000, 4, '18/10/2013');
INSERT INTO person VALUES(335, 'Zuzana', 'Vydrová','F', '22',  13000, 3, '30.1.2010');
INSERT INTO person VALUES(336, 'Marek', 'Mikeš ','M', '45',  44000, 3, '2/5/2005');
INSERT INTO person VALUES(337, 'Ta ána', 'Sýkorová','F', '30',  36000, 4, '3.4.2017');
INSERT INTO person VALUES(338, 'Petr', 'Pícha ','M', '27',  13000, 4, '3/9/2004');
INSERT INTO person VALUES(339, 'Vlastimila', 'Cihlá?ová','F', '37',  16000, 4, '22.5.2006');
INSERT INTO person VALUES(340, 'Petro', 'Krupka ','M', '56',  18000, 4, '5/12/2016');
INSERT INTO person VALUES(341, 'Ivanka', '?adová','F', '23',  24000, 4, '11.8.2019');
INSERT INTO person VALUES(342, 'Vladimir', 'Blažek ','M', '33',  27000, 4, '13/12/2011');
INSERT INTO person VALUES(343, 'Vladislava', 'Koukalová','F', '54',  32000, 3, '5.6.2016');
INSERT INTO person VALUES(344, 'Jakub', 'Hampl ','M', '55',  36000, 3, '21/12/2006');
INSERT INTO person VALUES(345, 'Vlastimila', 'Ptá?ková','F', '62',  47000, 3, '24.7.2005');
INSERT INTO person VALUES(346, 'J?lius', 'Sochor ','M', '38',  42000, 3, '24/3/2019');
INSERT INTO person VALUES(347, 'Elena', 'Vránová','F', '47',  19000, 3, '13.10.2018');
INSERT INTO person VALUES(348, 'Svatoslav', 'Hrabal ','M', '60',  15000, 3, '1/4/2014');
INSERT INTO person VALUES(349, 'Monika', 'Vybíralová','F', '56',  43000, 4, '22.7.2009');
INSERT INTO person VALUES(350, 'Nikola', 'Kohout ','M', '42',  19000, 4, '2/8/2013');
INSERT INTO person VALUES(351, 'Šárka', 'R?ži?ková','F', '63',  23000, 4, '2.2.2015');
INSERT INTO person VALUES(352, 'Matouš', 'Sláma ','M', '25',  25000, 4, '10/6/2009');
INSERT INTO person VALUES(353, 'Marta', 'Brabencová','F', '48',  30000, 4, '29.11.2011');
INSERT INTO person VALUES(354, 'Hubert', 'Klement ','M', '48',  34000, 4, '18/6/2004');
INSERT INTO person VALUES(355, 'Simona', 'Boudová','F', '56',  46000, 4, '11.6.2017');
INSERT INTO person VALUES(356, 'Hynek', 'Chmela? ','M', '31',  39000, 4, '19/9/2016');
INSERT INTO person VALUES(357, 'Šárka', '?ernochová','F', '41',  18000, 4, '6.4.2014');
INSERT INTO person VALUES(358, 'Ferdinand', 'Bína ','M', '53',  12000, 4, '27/9/2011');
INSERT INTO person VALUES(359, 'Marta', 'Suková','F', '27',  25000, 3, '31.1.2011');
INSERT INTO person VALUES(360, 'Alex', 'Navrátil ','M', '29',  22000, 3, '5/10/2006');
INSERT INTO person VALUES(361, 'Radka', 'Hlavá?ková','F', '34',  41000, 3, '13.8.2016');
INSERT INTO person VALUES(362, '?estmír', 'Slavík ','M', '58',  27000, 3, '6/1/2019');
INSERT INTO person VALUES(363, 'Vanda', 'Klementová','F', '42',  29000, 1, '23.5.2007');
INSERT INTO person VALUES(364, 'Otto', 'Jakeš ','M', '40',  31000, 1, '9/5/2018');
INSERT INTO person VALUES(365, 'Ilona', 'Píšová','F', '27',  29000, 3, '21.12.2018');
INSERT INTO person VALUES(366, 'Arnošt', 'Vojá?ek ','M', '63',  41000, 3, '22/11/2009');
INSERT INTO person VALUES(367, 'Zlata', 'Michlová','F', '35',  17000, 4, '29.9.2009');
INSERT INTO person VALUES(368, 'Ludvík', 'Michna ','M', '45',  46000, 4, '25/3/2009');
INSERT INTO person VALUES(369, 'Danuše', 'Balážová','F', '19',  16000, 3, '4.12.2004');
INSERT INTO person VALUES(370, 'Marcel', 'Píša ','M', '23',  20000, 3, '3/3/2017');
INSERT INTO person VALUES(371, 'Aloisie', 'Kyselová','F', '28',  40000, 4, '6.2.2012');
INSERT INTO person VALUES(372, 'Richard', 'Vondrá?ek ','M', '51',  24000, 4, '4/7/2016');
INSERT INTO person VALUES(373, 'Zora', 'Straková','F', '35',  20000, 1, '19.8.2017');
INSERT INTO person VALUES(374, 'V?roslav', 'Šimon ','M', '34',  30000, 1, '12/5/2012');
INSERT INTO person VALUES(375, 'Zd?nka', 'Brožová','F', '20',  28000, 4, '14.6.2014');
INSERT INTO person VALUES(376, 'Miloslav', 'Kudlá?ek ','M', '56',  39000, 4, '21/5/2007');
INSERT INTO person VALUES(377, 'Aloisie', 'Jarošová','F', '52',  35000, 3, '10.4.2011');
INSERT INTO person VALUES(378, 'Emil', 'Víšek ','M', '32',  12000, 3, '21/10/2018');
INSERT INTO person VALUES(379, 'Radana', 'Máchová','F', '59',  15000, 4, '21.10.2016');
INSERT INTO person VALUES(380, 'Martin', 'Bašta ','M', '61',  17000, 4, '29/8/2014');
INSERT INTO person VALUES(381, 'Hanna', 'Machálková','F', '45',  23000, 3, '17.8.2013');
INSERT INTO person VALUES(382, 'Robert', 'Šindelá? ','M', '38',  26000, 3, '6/9/2009');
INSERT INTO person VALUES(383, 'Iryna', 'Burdová','F', '52',  38000, 4, '28.2.2019');
INSERT INTO person VALUES(384, 'Artur', 'Starý ','M', '20',  32000, 4, '15/7/2005');
INSERT INTO person VALUES(385, 'Antonie', 'Hrn?í?ová','F', '60',  26000, 1, '7.12.2009');
INSERT INTO person VALUES(386, 'Ervín', 'Be?vá? ','M', '48',  36000, 1, '16/11/2004');
INSERT INTO person VALUES(387, 'Vendula', 'Hladká','F', '46',  34000, 4, '2.10.2006');
INSERT INTO person VALUES(388, 'Ji?í', 'Nedoma ','M', '25',  45000, 4, '18/4/2016');
INSERT INTO person VALUES(389, 'Václava', 'Pavlíková','F', '53',  14000, 1, '14.4.2012');
INSERT INTO person VALUES(390, 'Gabriel', 'Sedlá?ek ','M', '54',  15000, 1, '25/2/2012');
INSERT INTO person VALUES(391, 'Antonie', 'Dostálová','F', '39',  21000, 4, '8.2.2009');
INSERT INTO person VALUES(392, 'Vojtech', 'Tu?ek ','M', '30',  24000, 4, '5/3/2007');
INSERT INTO person VALUES(393, 'Linda', 'Zav?elová','F', '46',  37000, 4, '22.8.2014');
INSERT INTO person VALUES(394, 'Drahomír', 'Lacina ','M', '59',  29000, 4, '6/6/2019');
INSERT INTO person VALUES(395, 'Nela', 'Peštová','F', '31',  45000, 4, '18.6.2011');
INSERT INTO person VALUES(396, 'Juliús', 'Neubauer ','M', '35',  38000, 4, '13/6/2014');
INSERT INTO person VALUES(397, 'Sylva', 'Kroupová','F', '39',  25000, 4, '29.12.2016');
INSERT INTO person VALUES(398, 'Tadeáš', 'Korbel ','M', '64',  44000, 4, '22/4/2010');
INSERT INTO person VALUES(399, 'Terezie', 'Dlouhá','F', '24',  32000, 4, '25.10.2013');
INSERT INTO person VALUES(400, 'Viliam', 'Kabát ','M', '41',  17000, 4, '29/4/2005');
INSERT INTO person VALUES(401, 'Maria', 'Kupcová','F', '31',  12000, 4, '8.5.2019');
INSERT INTO person VALUES(402, 'B?etislav', 'Ku?era ','M', '24',  22000, 4, '1/8/2017');
INSERT INTO person VALUES(403, 'Darina', 'H?lková','F', '63',  20000, 3, '2.3.2016');
INSERT INTO person VALUES(404, 'Matouš', 'Uher ','M', '46',  31000, 3, '8/8/2012');
INSERT INTO person VALUES(405, 'Zde?ka', 'Hájková','F', '25',  44000, 1, '10.12.2006');
INSERT INTO person VALUES(406, 'Denis', 'Karban ','M', '28',  36000, 1, '10/12/2011');
INSERT INTO person VALUES(407, 'R?žena', 'Koukalová','F', '33',  23000, 1, '22.6.2012');
INSERT INTO person VALUES(408, 'Rudolf', 'Rambousek ','M', '57',  41000, 1, '19/10/2007');
INSERT INTO person VALUES(409, 'Markéta', 'Skácelová','F', '64',  31000, 4, '18.4.2009');
INSERT INTO person VALUES(410, 'Dalibor', 'Sedlák ','M', '33',  14000, 4, '21/3/2019');
INSERT INTO person VALUES(411, 'Klára', 'Vránová','F', '25',  47000, 1, '30.10.2014');
INSERT INTO person VALUES(412, 'Michal', 'Pavelka ','M', '62',  20000, 1, '27/1/2015');
INSERT INTO person VALUES(413, 'Eliška', 'Adamcová','F', '57',  19000, 4, '26.8.2011');
INSERT INTO person VALUES(414, 'Lud?k', 'Slabý ','M', '38',  29000, 4, '4/2/2010');
INSERT INTO person VALUES(415, 'Miluše', 'Papežová','F', '64',  34000, 1, '8.3.2017');
INSERT INTO person VALUES(416, 'Nicolas', 'Gajdoš ','M', '21',  34000, 1, '13/12/2005');
INSERT INTO person VALUES(417, 'Klára', 'Mládková','F', '50',  42000, 4, '1.1.2014');
INSERT INTO person VALUES(418, 'Ivan', 'Michalík ','M', '44',  43000, 4, '16/5/2017');
INSERT INTO person VALUES(419, 'Nad?žda', 'Drábková','F', '57',  22000, 1, '15.7.2019');
INSERT INTO person VALUES(420, 'Alex', 'Šíp ','M', '27',  13000, 1, '24/3/2013');
INSERT INTO person VALUES(421, 'Daniela', 'Mare?ková','F', '42',  29000, 4, '10.5.2016');
INSERT INTO person VALUES(422, 'František', 'Janda ','M', '49',  22000, 4, '31/3/2008');
INSERT INTO person VALUES(423, 'Nina', 'Suková','F', '51',  17000, 1, '17.2.2007');
INSERT INTO person VALUES(424, 'Boleslav', 'Merta ','M', '31',  26000, 1, '3/8/2007');
INSERT INTO person VALUES(425, 'Nad?žda', 'Kalábová','F', '35',  17000, 4, '17.9.2018');
INSERT INTO person VALUES(426, 'Ruslan', 'Husák ','M', '54',  36000, 4, '11/7/2015');
INSERT INTO person VALUES(427, 'Emília', 'Janoušková','F', '44',  41000, 1, '26.6.2009');
INSERT INTO person VALUES(428, 'Mario', 'Motl ','M', '36',  41000, 1, '11/11/2014');
INSERT INTO person VALUES(429, 'Zlatuše', 'Píšová','F', '51',  21000, 1, '7.1.2015');
INSERT INTO person VALUES(430, 'Mykola', 'Macák ','M', '19',  46000, 1, '20/9/2010');
INSERT INTO person VALUES(431, 'Na?a', '?ernohorská','F', '36',  28000, 1, '2.11.2011');
INSERT INTO person VALUES(432, 'Lubor', 'Šedivý ','M', '41',  19000, 1, '27/9/2005');
INSERT INTO person VALUES(433, 'Tatiana', 'Balážová','F', '44',  44000, 1, '15.5.2017');
INSERT INTO person VALUES(434, 'P?emysl', 'Bílý ','M', '24',  24000, 1, '30/12/2017');
INSERT INTO person VALUES(435, 'Radomíra', 'Doleželová','F', '29',  16000, 1, '11.3.2014');
INSERT INTO person VALUES(436, 'Leopold', 'Dvorský ','M', '47',  34000, 1, '6/1/2013');
INSERT INTO person VALUES(437, 'Na?a', 'Pánková','F', '60',  23000, 4, '5.1.2011');
INSERT INTO person VALUES(438, 'Ervín', 'Kala ','M', '23',  43000, 4, '14/1/2008');
INSERT INTO person VALUES(439, 'Natalie', 'Syrová','F', '22',  39000, 4, '18.7.2016');
INSERT INTO person VALUES(440, 'Evžen', 'Molnár ','M', '52',  12000, 4, '23/11/2003');
INSERT INTO person VALUES(441, 'Blažena', 'Jarošová','F', '30',  27000, 1, '27.4.2007');
INSERT INTO person VALUES(442, 'Matyáš', 'Hloušek ','M', '34',  17000, 1, '19/8/2019');
INSERT INTO person VALUES(443, 'Hana', 'Hynková','F', '60',  27000, 4, '25.11.2018');
INSERT INTO person VALUES(444, 'Radovan', 'Sobotka ','M', '57',  27000, 4, '3/3/2011');
INSERT INTO person VALUES(445, 'Kv?tuše', 'Machálková','F', '23',  15000, 1, '3.9.2009');
INSERT INTO person VALUES(446, 'Ján', 'Polanský ','M', '39',  31000, 1, '5/7/2010');
INSERT INTO person VALUES(447, 'Jitka', 'Motlová','F', '53',  14000, 4, '7.11.2004');
INSERT INTO person VALUES(448, 'Jozef', 'Hrbek ','M', '63',  41000, 4, '12/6/2018');
INSERT INTO person VALUES(449, 'Jolana', 'Smetanová','F', '62',  38000, 1, '10.1.2012');
INSERT INTO person VALUES(450, 'Adam', 'Jakoubek ','M', '45',  46000, 1, '13/10/2017');
INSERT INTO person VALUES(451, 'Kv?tuše', 'Švarcová','F', '47',  46000, 4, '5.11.2008');
INSERT INTO person VALUES(452, 'Šimon', 'Škoda ','M', '21',  19000, 4, '21/10/2012');
INSERT INTO person VALUES(453, 'Vladislava', 'Tvrdá','F', '54',  25000, 1, '19.5.2014');
INSERT INTO person VALUES(454, 'David', 'Buchta ','M', '50',  24000, 1, '29/8/2008');
INSERT INTO person VALUES(455, 'Leona', 'Menclová','F', '40',  33000, 4, '15.3.2011');
INSERT INTO person VALUES(456, 'Alois', 'Maršík ','M', '26',  33000, 4, '7/9/2003');
INSERT INTO person VALUES(457, 'Ivanka', 'Langová','F', '47',  13000, 1, '25.9.2016');
INSERT INTO person VALUES(458, 'Prokop', 'Ma?ák ','M', '55',  39000, 1, '9/12/2015');
INSERT INTO person VALUES(459, 'Vladislava', 'Kozlová','F', '33',  21000, 4, '21.7.2013');
INSERT INTO person VALUES(460, 'Old?ich', 'Jež ','M', '31',  12000, 4, '16/12/2010');
INSERT INTO person VALUES(461, 'Jindra', 'Niklová','F', '40',  36000, 1, '1.2.2019');
INSERT INTO person VALUES(462, 'Bruno', 'Hýbl ','M', '60',  17000, 1, '25/10/2006');
INSERT INTO person VALUES(463, 'Marta', 'Dlouhá','F', '48',  24000, 2, '10.11.2009');
INSERT INTO person VALUES(464, 'Drahoslav', 'Jav?rek ','M', '42',  22000, 2, '25/2/2006');
INSERT INTO person VALUES(465, 'Žofie', 'Jav?rková','F', '33',  24000, 4, '15.1.2005');
INSERT INTO person VALUES(466, 'Hubert', 'Jonáš ','M', '20',  31000, 4, '3/2/2014');
INSERT INTO person VALUES(467, 'Šárka', 'H?lková','F', '41',  12000, 2, '19.3.2012');
INSERT INTO person VALUES(468, 'Dan', 'R?žek ','M', '48',  36000, 2, '6/6/2013');
INSERT INTO person VALUES(469, 'Marta', 'Bínová','F', '27',  19000, 1, '13.1.2009');
INSERT INTO person VALUES(470, 'Ctibor', 'Bláha ','M', '24',  45000, 1, '13/6/2008');
INSERT INTO person VALUES(471, 'Radka', 'Kupková','F', '34',  35000, 1, '27.7.2014');
INSERT INTO person VALUES(472, 'Radoslav', 'Kova?ík ','M', '53',  14000, 1, '22/4/2004');
INSERT INTO person VALUES(473, 'Iveta', 'Melicharová','F', '19',  43000, 1, '23.5.2011');
INSERT INTO person VALUES(474, 'Albert', 'Homolka ','M', '29',  24000, 1, '23/9/2015');
INSERT INTO person VALUES(475, 'Diana', 'Pavlová','F', '28',  31000, 2, '24.7.2018');
INSERT INTO person VALUES(476, 'Gustav', 'Mou?ka ','M', '57',  28000, 2, '24/1/2015');
INSERT INTO person VALUES(477, 'Sylva', 'Houšková','F', '59',  38000, 1, '20.5.2015');
INSERT INTO person VALUES(478, 'Walter', 'Hlavá?ek ','M', '34',  37000, 1, '31/1/2010');
INSERT INTO person VALUES(479, 'Katarína', 'Richterová','F', '21',  18000, 2, '7.7.2004');
INSERT INTO person VALUES(480, 'Kv?toslav', 'Kubát ','M', '62',  43000, 2, '10/12/2005');
INSERT INTO person VALUES(481, 'Sv?tlana', '?ÍŽková','F', '52',  26000, 1, '26.9.2017');
INSERT INTO person VALUES(482, 'Petro', 'Šolc ','M', '39',  16000, 1, '12/5/2017');
INSERT INTO person VALUES(483, 'Zlata', 'Koudelová','F', '59',  42000, 2, '14.11.2006');
INSERT INTO person VALUES(484, 'Igor', 'Balcar ','M', '22',  21000, 2, '21/3/2013');
INSERT INTO person VALUES(485, 'Karolina', 'Kade?ábková','F', '45',  13000, 1, '10.9.2003');
INSERT INTO person VALUES(486, 'Boris', 'Zv??ina ','M', '44',  30000, 1, '28/3/2008');
INSERT INTO person VALUES(487, 'Olga', 'Košková','F', '53',  37000, 2, '11.11.2010');
INSERT INTO person VALUES(488, 'Tadeáš', 'Bílý ','M', '26',  35000, 2, '30/7/2007');
INSERT INTO person VALUES(489, 'Dáša', 'Vlasáková','F', '37',  37000, 1, '16.1.2006');
INSERT INTO person VALUES(490, 'Robin', 'Jedli?ka ','M', '49',  45000, 1, '8/7/2015');
INSERT INTO person VALUES(491, 'Renata', 'Šindlerová','F', '46',  25000, 2, '20.3.2013');
INSERT INTO person VALUES(492, 'Vilém', 'Petr? ','M', '31',  13000, 2, '8/11/2014');
INSERT INTO person VALUES(493, 'Sylvie', 'Kaiserová','F', '30',  24000, 1, '25.5.2008');
INSERT INTO person VALUES(494, 'Vratislav', 'Dudek ','M', '55',  23000, 1, '24/5/2006');
INSERT INTO person VALUES(495, 'Denisa', 'Machá?ková','F', '39',  12000, 2, '28.7.2015');
INSERT INTO person VALUES(496, 'Št?pán', 'Seifert ','M', '37',  28000, 2, '24/9/2005');
INSERT INTO person VALUES(497, 'Vendula', 'Najmanová','F', '46',  28000, 2, '14.9.2004');
INSERT INTO person VALUES(498, 'Po?et', 'H?lka ','M', '20',  33000, 2, '26/12/2017');
INSERT INTO person VALUES(499, 'So?a', 'Fiedlerová','F', '31',  35000, 2, '4.12.2017');
INSERT INTO person VALUES(500, 'Jind?ich', 'Mina?ík ','M', '42',  42000, 2, '3/1/2013');
INSERT INTO person VALUES(501, 'Miluše', 'Šedová','F', '63',  43000, 1, '29.9.2014');
INSERT INTO person VALUES(502, 'Otakar', 'Hrbek ','M', '64',  16000, 1, '11/1/2008');
INSERT INTO person VALUES(503, 'Vendula', 'Prokešová','F', '24',  23000, 1, '17.11.2003');
INSERT INTO person VALUES(504, 'Lukáš', 'Schejbal ','M', '47',  21000, 1, '19/11/2003');
INSERT INTO person VALUES(505, 'So?a', 'Lukešová','F', '56',  31000, 1, '5.2.2017');
INSERT INTO person VALUES(506, 'Bohuslav', 'Barák ','M', '23',  30000, 1, '22/4/2015');
INSERT INTO person VALUES(507, 'Julie', 'Krej?í?ová','F', '63',  46000, 1, '26.3.2006');
INSERT INTO person VALUES(508, 'Ernest', 'Šim?ík ','M', '52',  35000, 1, '28/2/2011');
INSERT INTO person VALUES(509, 'Zlatuše', 'Holubová','F', '25',  34000, 2, '28.5.2013');
INSERT INTO person VALUES(510, 'Oskar', 'Pila? ','M', '34',  40000, 2, '1/7/2010');
INSERT INTO person VALUES(511, 'Nela', 'Houdková','F', '56',  34000, 1, '2.8.2008');
INSERT INTO person VALUES(512, 'Vladan', 'Václavík ','M', '58',  14000, 1, '9/6/2018');
INSERT INTO person VALUES(513, 'Tatiána', 'Moty?ková','F', '64',  22000, 2, '5.10.2015');
INSERT INTO person VALUES(514, '?ubomír', 'Baloun ','M', '40',  18000, 2, '10/10/2017');
INSERT INTO person VALUES(515, 'Terezie', 'Mí?ková','F', '48',  21000, 1, '10.12.2010');
INSERT INTO person VALUES(516, 'Norbert', 'Mi?ka ','M', '63',  28000, 1, '25/4/2009');
INSERT INTO person VALUES(517, 'V?ra', 'Suchánková','F', '57',  45000, 2, '10.2.2018');
INSERT INTO person VALUES(518, 'Jonáš', 'Š astný ','M', '45',  33000, 2, '26/8/2008');
INSERT INTO person VALUES(519, 'Tatiana', 'Hlavá?ová','F', '42',  17000, 1, '7.12.2014');
INSERT INTO person VALUES(520, 'Zoltán', 'Jonáš ','M', '21',  42000, 1, '3/9/2003');
INSERT INTO person VALUES(521, 'Zde?ka', 'Hlávková','F', '50',  33000, 2, '25.1.2004');
INSERT INTO person VALUES(522, 'Pavol', 'Doubek ','M', '50',  47000, 2, '6/12/2015');
INSERT INTO person VALUES(523, 'V?ra', 'Bart??ková','F', '35',  40000, 1, '15.4.2017');
INSERT INTO person VALUES(524, 'Radomil', 'Pašek ','M', '27',  20000, 1, '13/12/2010');
INSERT INTO person VALUES(525, 'Vlasta', 'Ko?ová','F', '42',  20000, 2, '3.6.2006');
INSERT INTO person VALUES(526, 'Bohumír', 'Mat?jí?ek ','M', '55',  26000, 2, '22/10/2006');
INSERT INTO person VALUES(527, 'Martina', 'Hamplová','F', '28',  28000, 1, '23.8.2019');
INSERT INTO person VALUES(528, 'Oto', 'Brázdil ','M', '32',  35000, 1, '24/3/2018');
INSERT INTO person VALUES(529, 'Margita', 'T?ísková','F', '36',  16000, 2, '1.6.2010');
INSERT INTO person VALUES(530, 'Vlastislav', 'Pa?ízek ','M', '60',  39000, 2, '25/7/2017');
INSERT INTO person VALUES(531, 'Old?iška', 'Málková','F', '44',  31000, 3, '13.12.2015');
INSERT INTO person VALUES(532, 'Mat?j', 'Vondrák ','M', '43',  45000, 3, '3/6/2013');
INSERT INTO person VALUES(533, 'Ta ána', 'Jedli?ková','F', '29',  39000, 2, '7.10.2012');
INSERT INTO person VALUES(534, 'Leoš', 'Kubiš ','M', '19',  18000, 2, '10/6/2008');
INSERT INTO person VALUES(535, 'Karin', 'Ferková','F', '36',  19000, 2, '20.4.2018');
INSERT INTO person VALUES(536, 'Antonín', 'Látal ','M', '48',  23000, 2, '18/4/2004');
INSERT INTO person VALUES(537, 'Old?iška', 'Hurtová','F', '22',  27000, 2, '14.2.2015');
INSERT INTO person VALUES(538, 'Zbyn?k', 'Jane?ek ','M', '24',  32000, 2, '20/9/2015');
INSERT INTO person VALUES(539, 'Ingrid', 'Bartáková','F', '29',  42000, 2, '3.4.2004');
INSERT INTO person VALUES(540, 'Petr', 'David ','M', '53',  38000, 2, '29/7/2011');
INSERT INTO person VALUES(541, 'Vlastimila', 'Divišová','F', '60',  14000, 2, '23.6.2017');
INSERT INTO person VALUES(542, 'Lubomír', 'Záruba ','M', '30',  47000, 2, '5/8/2006');
INSERT INTO person VALUES(543, 'Emília', 'Tvrdíková','F', '22',  30000, 2, '11.8.2006');
INSERT INTO person VALUES(544, 'Vladimir', 'Sova ','M', '59',  16000, 2, '7/11/2018');
INSERT INTO person VALUES(545, 'Žofie', 'Mou?ková','F', '53',  37000, 1, '30.10.2019');
INSERT INTO person VALUES(546, 'Jakub', 'Hrubeš ','M', '35',  25000, 1, '14/11/2013');
INSERT INTO person VALUES(547, 'Pavlína', 'Ježková','F', '62',  25000, 3, '8.8.2010');
INSERT INTO person VALUES(548, 'Zd?nek', 'Chalupa ','M', '63',  30000, 3, '17/3/2013');
INSERT INTO person VALUES(549, 'Patricie', 'Pila?ová','F', '46',  25000, 1, '13.10.2005');
INSERT INTO person VALUES(550, 'Svatoslav', 'Horá?ek ','M', '40',  40000, 1, '30/9/2004');
INSERT INTO person VALUES(551, 'Simona', 'Suchomelová','F', '54',  13000, 2, '15.12.2012');
INSERT INTO person VALUES(552, 'Nikola', 'Rezek ','M', '22',  44000, 2, '1/2/2004');
INSERT INTO person VALUES(553, 'Natálie', 'Vlasáková','F', '62',  29000, 3, '28.6.2018');
INSERT INTO person VALUES(554, 'Matouš', 'Kope?ek ','M', '51',  14000, 3, '5/5/2016');
INSERT INTO person VALUES(555, 'Stanislava', 'P?ikrylová','F', '47',  36000, 2, '24.4.2015');
INSERT INTO person VALUES(556, 'Hubert', 'Kameník ','M', '27',  23000, 2, '13/5/2011');
INSERT INTO person VALUES(557, 'Dominika', 'Kaiserová','F', '54',  16000, 3, '11.6.2004');
INSERT INTO person VALUES(558, 'Hynek', 'Svozil ','M', '56',  28000, 3, '21/3/2007');
INSERT INTO person VALUES(559, 'Jind?iška', 'Borovi?ková','F', '40',  24000, 2, '31.8.2017');
INSERT INTO person VALUES(560, 'Ferdinand', 'Hofman ','M', '33',  37000, 2, '22/8/2018');
INSERT INTO person VALUES(561, 'Ilona', 'Truhlá?ová','F', '25',  31000, 1, '26.6.2014');
INSERT INTO person VALUES(562, 'Alex', 'Žiga ','M', '55',  46000, 1, '29/8/2013');
INSERT INTO person VALUES(563, 'Dominika', 'Šim?nková','F', '33',  47000, 2, '14.8.2003');
INSERT INTO person VALUES(564, '?estmír', 'Michal ','M', '38',  16000, 2, '8/7/2009');
INSERT INTO person VALUES(565, 'Vilma', 'Polanská','F', '41',  35000, 3, '16.10.2010');
INSERT INTO person VALUES(566, 'Otto', 'Šimek ','M', '20',  20000, 3, '8/11/2008');
INSERT INTO person VALUES(567, 'Hedvika', 'Olivová','F', '25',  35000, 2, '21.12.2005');
INSERT INTO person VALUES(568, 'Arnošt', 'Vymazal ','M', '43',  30000, 2, '16/10/2016');
INSERT INTO person VALUES(569, 'Vanesa', 'Lukešová','F', '34',  23000, 3, '22.2.2013');
INSERT INTO person VALUES(570, 'Ludvík', 'Šmejkal ','M', '25',  35000, 3, '18/2/2016');
INSERT INTO person VALUES(571, 'Leona', 'Bajerová','F', '64',  22000, 1, '29.4.2008');
INSERT INTO person VALUES(572, 'Marcel', 'Kalina ','M', '48',  45000, 1, '2/9/2007');
INSERT INTO person VALUES(573, 'Marie', 'Bou?ková','F', '27',  46000, 3, '2.7.2015');
INSERT INTO person VALUES(574, 'Richard', 'Bart?n?k ','M', '30',  13000, 3, '3/1/2007');
INSERT INTO person VALUES(575, 'Zora', 'Janatová','F', '58',  18000, 2, '26.4.2012');
INSERT INTO person VALUES(576, 'P?emysl', 'Kotas ','M', '53',  22000, 2, '6/6/2018');
INSERT INTO person VALUES(577, 'Lucie', 'Samková','F', '19',  33000, 2, '7.11.2017');
INSERT INTO person VALUES(578, 'Miloslav', 'Navrátil ','M', '36',  28000, 2, '14/4/2014');
INSERT INTO person VALUES(579, 'Iryna', 'Neumannová','F', '51',  41000, 2, '3.9.2014');
INSERT INTO person VALUES(580, 'Emil', 'Hanzlík ','M', '58',  37000, 2, '21/4/2009');
INSERT INTO person VALUES(581, 'Ji?ina', 'Kopalová','F', '58',  21000, 2, '22.10.2003');
INSERT INTO person VALUES(582, 'Martin', 'Vysko?il ','M', '41',  42000, 2, '28/2/2005');
INSERT INTO person VALUES(583, 'Lucie', 'Sehnalová','F', '44',  29000, 2, '10.1.2017');
INSERT INTO person VALUES(584, 'Robert', 'Fo?t ','M', '63',  15000, 2, '31/7/2016');
INSERT INTO person VALUES(585, 'Libuše', 'Gabrielová','F', '51',  44000, 2, '28.2.2006');
INSERT INTO person VALUES(586, 'Artur', 'Hrbá?ek ','M', '46',  21000, 2, '9/6/2012');
INSERT INTO person VALUES(587, 'Viktorie', 'Bart??ková','F', '59',  32000, 3, '2.5.2013');
INSERT INTO person VALUES(588, 'Ervín', 'Hlavá? ','M', '28',  25000, 3, '11/10/2011');
INSERT INTO person VALUES(589, 'Iveta', '?erná','F', '44',  32000, 2, '7.7.2008');
INSERT INTO person VALUES(590, 'Gerhard', 'Pokorný ','M', '52',  35000, 2, '18/9/2019');
INSERT INTO person VALUES(591, 'Sv?tlana', 'Hamplová','F', '52',  20000, 3, '8.9.2015');
INSERT INTO person VALUES(592, 'Gabriel', 'Hrn?í? ','M', '34',  40000, 3, '20/1/2019');
INSERT INTO person VALUES(593, 'Sylva', 'Franková','F', '38',  27000, 2, '4.7.2012');
INSERT INTO person VALUES(594, 'Vojtech', 'Šimánek ','M', '56',  13000, 2, '27/1/2014');
INSERT INTO person VALUES(595, 'Katarína', 'Nedbalová','F', '45',  43000, 3, '15.1.2018');
INSERT INTO person VALUES(596, 'Drahomír', 'Víšek ','M', '39',  18000, 3, '6/12/2009');
INSERT INTO person VALUES(597, 'Sv?tlana', 'Píchová','F', '30',  15000, 2, '11.11.2014');
INSERT INTO person VALUES(598, 'Juliús', 'Nguyen ','M', '61',  27000, 2, '13/12/2004');
INSERT INTO person VALUES(599, 'Dáša', 'Kohoutková','F', '38',  31000, 3, '30.12.2003');
INSERT INTO person VALUES(600, 'Tadeáš', 'Adamec ','M', '44',  32000, 3, '16/3/2017');
INSERT INTO person VALUES(601, 'Karolina', 'Kolá?ková','F', '23',  38000, 2, '20.3.2017');
INSERT INTO person VALUES(602, 'Viliam', 'Vondra ','M', '20',  42000, 2, '24/3/2012');
INSERT INTO person VALUES(603, 'Aloisie', 'Kovandová','F', '30',  18000, 2, '8.5.2006');
INSERT INTO person VALUES(604, 'Vilém', 'Blecha ','M', '49',  47000, 2, '31/1/2008');
INSERT INTO person VALUES(605, 'Markéta', 'Korbelová','F', '63',  34000, 3, '22.10.2004');
INSERT INTO person VALUES(606, 'Drahoslav', 'Klimeš ','M', '25',  19000, 3, '2/8/2006');
INSERT INTO person VALUES(607, 'Renata', 'Ondrá?ková','F', '24',  14000, 3, '5.5.2010');
INSERT INTO person VALUES(608, 'Denis', 'Burda ','M', '54',  25000, 3, '4/11/2018');
INSERT INTO person VALUES(609, 'R?žena', 'Kop?ivová','F', '56',  21000, 2, '1.3.2007');
INSERT INTO person VALUES(610, 'Dan', 'Zach ','M', '30',  34000, 2, '11/11/2013');
INSERT INTO person VALUES(611, 'Miluše', 'Vojtková','F', '63',  37000, 3, '11.9.2012');
INSERT INTO person VALUES(612, 'Dalibor', 'Junek ','M', '59',  39000, 3, '19/9/2009');
INSERT INTO person VALUES(613, 'Klára', 'Hejnová','F', '48',  45000, 2, '8.7.2009');
INSERT INTO person VALUES(614, 'Radoslav', 'Žemli?ka ','M', '35',  12000, 2, '27/9/2004');
INSERT INTO person VALUES(615, 'So?a', 'Zemánková','F', '56',  24000, 3, '19.1.2015');
INSERT INTO person VALUES(616, 'Lud?k', 'Moudrý ','M', '64',  18000, 3, '29/12/2016');
INSERT INTO person VALUES(617, 'Miluše', 'Buchtová','F', '41',  32000, 2, '14.11.2011');
INSERT INTO person VALUES(618, 'Kryštof', 'Ková? ','M', '41',  27000, 2, '6/1/2012');
INSERT INTO person VALUES(619, 'Nina', '?eho?ová','F', '50',  20000, 3, '16.1.2019');
INSERT INTO person VALUES(620, 'Vít?zslav', 'Hejda ','M', '23',  31000, 3, '10/5/2011');
INSERT INTO person VALUES(621, 'Bed?iška', 'Vlachová','F', '57',  36000, 4, '5.3.2008');
INSERT INTO person VALUES(622, 'Tomáš', 'Buriánek ','M', '51',  37000, 4, '18/3/2007');
INSERT INTO person VALUES(623, 'Emília', 'Vaší?ková','F', '42',  43000, 3, '30.12.2004');
INSERT INTO person VALUES(624, 'Dominik', 'Šilhavý ','M', '28',  46000, 3, '18/8/2018');
INSERT INTO person VALUES(625, 'Ingrid', 'Ko?ínková','F', '28',  15000, 2, '21.3.2018');
INSERT INTO person VALUES(626, 'Igor', 'Kalina ','M', '50',  19000, 2, '26/8/2013');
INSERT INTO person VALUES(627, 'Olena', 'Zezulová','F', '35',  31000, 3, '9.5.2007');
INSERT INTO person VALUES(628, 'Marek', 'Lukáš ','M', '33',  24000, 3, '4/7/2009');
INSERT INTO person VALUES(629, 'Emília', 'Rozsypalová','F', '21',  39000, 2, '4.3.2004');
INSERT INTO person VALUES(630, 'Štefan', '?ernoch ','M', '55',  34000, 2, '12/7/2004');
INSERT INTO person VALUES(631, 'Radomíra', 'Matušková','F', '28',  18000, 3, '15.9.2009');
INSERT INTO person VALUES(632, 'Pavel', 'Orság ','M', '38',  39000, 3, '13/10/2016');
INSERT INTO person VALUES(633, 'Františka', 'Petráková','F', '36',  42000, 4, '16.11.2016');
INSERT INTO person VALUES(634, '?udovít', 'Bílek ','M', '20',  43000, 4, '14/2/2016');
INSERT INTO person VALUES(635, 'Tatiana', 'Lakatošová','F', '21',  42000, 2, '22.1.2012');
INSERT INTO person VALUES(636, 'Rastislav', 'Mazánek ','M', '44',  17000, 2, '30/8/2007');
INSERT INTO person VALUES(637, 'Blažena', 'Šindelá?ová','F', '29',  30000, 4, '26.3.2019');
INSERT INTO person VALUES(638, 'Oliver', 'Zima ','M', '26',  22000, 4, '31/12/2006');
INSERT INTO person VALUES(639, 'Natálie', 'Macková','F', '61',  37000, 3, '20.1.2016');
INSERT INTO person VALUES(640, 'Po?et', 'Hrbá?ek ','M', '48',  31000, 3, '2/6/2018');
INSERT INTO person VALUES(641, 'Alexandra', 'Šípková','F', '22',  17000, 3, '9.3.2005');
INSERT INTO person VALUES(642, 'Leo', 'Píša ','M', '31',  36000, 3, '11/4/2014');
INSERT INTO person VALUES(643, 'Blažena', 'Šandová','F', '53',  25000, 3, '29.5.2018');
INSERT INTO person VALUES(644, 'Stepan', 'Pokorný ','M', '53',  45000, 3, '18/4/2009');
INSERT INTO person VALUES(645, 'Jolana', 'Lukášová','F', '61',  41000, 3, '17.7.2007');
INSERT INTO person VALUES(646, 'Mikuláš', 'Machá?ek ','M', '36',  15000, 3, '25/2/2005');
INSERT INTO person VALUES(647, 'Kv?tuše', 'Kulhánková','F', '46',  12000, 3, '11.5.2004');
INSERT INTO person VALUES(648, 'Sebastian', 'Seidl ','M', '58',  24000, 3, '28/7/2016');
INSERT INTO person VALUES(649, 'Ta ána', 'Grundzová','F', '53',  28000, 3, '22.11.2009');
INSERT INTO person VALUES(650, 'Bronislav', 'Van??ek ','M', '41',  29000, 3, '5/6/2012');
INSERT INTO person VALUES(651, 'Jolana', 'Kolková','F', '39',  36000, 2, '18.9.2006');
INSERT INTO person VALUES(652, 'Nikolas', 'Jiroušek ','M', '64',  38000, 2, '14/6/2007');
INSERT INTO person VALUES(653, 'Ivanka', 'Kotková','F', '46',  16000, 3, '31.3.2012');
INSERT INTO person VALUES(654, 'Šimon', 'Jan? ','M', '47',  44000, 3, '15/9/2019');
INSERT INTO person VALUES(655, 'Monika', 'Lebedová','F', '55',  39000, 4, '3.6.2019');
INSERT INTO person VALUES(656, 'Bohuslav', 'Starý ','M', '29',  12000, 4, '16/1/2019');
INSERT INTO person VALUES(657, 'Jaroslava', 'Václavková','F', '40',  47000, 3, '29.3.2016');
INSERT INTO person VALUES(658, 'Arnošt', 'Blecha ','M', '51',  21000, 3, '24/1/2014');
INSERT INTO person VALUES(659, 'Irena', 'Koubová','F', '47',  27000, 4, '17.5.2005');
INSERT INTO person VALUES(660, 'Libor', 'Hr?za ','M', '34',  27000, 4, '2/12/2009');
INSERT INTO person VALUES(661, 'Monika', 'Hofmanová','F', '33',  35000, 3, '5.8.2018');
INSERT INTO person VALUES(662, 'Marcel', 'Knap ','M', '56',  36000, 3, '9/12/2004');
INSERT INTO person VALUES(663, 'Šárka', 'Chadimová','F', '40',  14000, 4, '23.9.2007');
INSERT INTO person VALUES(664, 'Karel', 'Srb ','M', '39',  41000, 4, '13/3/2017');
INSERT INTO person VALUES(665, 'Marta', 'Knapová','F', '25',  22000, 3, '19.7.2004');
INSERT INTO person VALUES(666, 'Rostislav', 'P?ibyl ','M', '62',  14000, 3, '20/3/2012');
INSERT INTO person VALUES(667, 'Simona', 'Kostková','F', '33',  38000, 3, '30.1.2010');
INSERT INTO person VALUES(668, 'Radko', 'Šebesta ','M', '44',  20000, 3, '28/1/2008');
INSERT INTO person VALUES(669, 'Šárka', 'Hude?ková','F', '64',  45000, 3, '26.11.2006');
INSERT INTO person VALUES(670, 'Jaromír', 'Mužík ','M', '21',  29000, 3, '30/6/2019');
INSERT INTO person VALUES(671, 'Diana', 'Peterová','F', '27',  33000, 4, '28.1.2014');
INSERT INTO person VALUES(672, 'Miroslav', 'Kabát ','M', '49',  33000, 4, '31/10/2018');
INSERT INTO person VALUES(673, 'Radka', 'Drápalová','F', '57',  33000, 3, '4.4.2009');
INSERT INTO person VALUES(674, 'Tomáš', 'Kalivoda ','M', '26',  43000, 3, '16/5/2010');
INSERT INTO person VALUES(675, 'Vanda', 'Sobotková','F', '19',  21000, 4, '6.6.2016');
INSERT INTO person VALUES(676, 'Artur', '?ejka ','M', '54',  12000, 4, '16/9/2009');
INSERT INTO person VALUES(677, 'Barbara', 'Hejnová','F', '27',  37000, 4, '25.7.2005');
INSERT INTO person VALUES(678, 'Gustav', 'Pekárek ','M', '37',  17000, 4, '26/7/2005');
INSERT INTO person VALUES(679, 'Zlata', 'Hanzalová','F', '58',  44000, 4, '13.10.2018');
INSERT INTO person VALUES(680, 'Walter', 'Dolejší ','M', '59',  26000, 4, '26/12/2016');
INSERT INTO person VALUES(681, 'Vilma', 'Buchtová','F', '19',  24000, 4, '1.12.2007');
INSERT INTO person VALUES(682, 'Kv?toslav', 'Stárek ','M', '42',  32000, 4, '3/11/2012');
INSERT INTO person VALUES(683, 'Aloisie', 'Kola?íková','F', '51',  32000, 3, '26.9.2004');
INSERT INTO person VALUES(684, 'Petro', 'Pilát ','M', '19',  41000, 3, '12/11/2007');
INSERT INTO person VALUES(685, 'Zora', 'Štorková','F', '58',  12000, 4, '9.4.2010');
INSERT INTO person VALUES(686, 'Igor', 'Ju?ík ','M', '48',  46000, 4, '20/9/2003');
INSERT INTO person VALUES(687, 'Zd?nka', 'Dole?ková','F', '44',  19000, 3, '3.2.2007');
INSERT INTO person VALUES(688, 'Boris', 'Bauer ','M', '24',  19000, 3, '20/2/2015');
INSERT INTO person VALUES(689, 'Vladimíra', 'Ko?ínková','F', '52',  43000, 4, '7.4.2014');
INSERT INTO person VALUES(690, 'Tadeáš', 'Kosina ','M', '52',  24000, 4, '24/6/2014');
INSERT INTO person VALUES(691, 'Radana', 'Mužíková','F', '36',  43000, 3, '11.6.2009');
INSERT INTO person VALUES(692, 'Lumír', 'Berger ','M', '29',  34000, 3, '6/1/2006');
INSERT INTO person VALUES(693, 'Št?pánka', 'Rozsypalová','F', '45',  30000, 4, '13.8.2016');
INSERT INTO person VALUES(694, 'Vilém', 'Janda ','M', '57',  38000, 4, '9/5/2005');
INSERT INTO person VALUES(695, 'Iryna', 'R?ži?ková','F', '29',  30000, 3, '19.10.2011');
INSERT INTO person VALUES(696, 'Vratislav', 'Kolman ','M', '34',  12000, 3, '17/4/2013');
INSERT INTO person VALUES(697, 'Antonie', 'Hanzlíková','F', '38',  18000, 4, '21.12.2018');
INSERT INTO person VALUES(698, 'Št?pán', 'Antoš ','M', '62',  17000, 4, '18/8/2012');
INSERT INTO person VALUES(699, 'Magda', 'Lakatošová','F', '45',  34000, 1, '8.2.2008');
INSERT INTO person VALUES(700, 'Po?et', 'Šolc ','M', '45',  22000, 1, '27/6/2008');
INSERT INTO person VALUES(701, 'Václava', 'Linková','F', '30',  41000, 4, '4.12.2004');
INSERT INTO person VALUES(702, 'Jind?ich', 'Rozsypal ','M', '22',  31000, 4, '5/7/2003');
INSERT INTO person VALUES(703, 'Antonie', 'Mokrá','F', '62',  13000, 3, '22.2.2018');
INSERT INTO person VALUES(704, 'Otakar', 'Otáhal ','M', '44',  40000, 3, '5/12/2014');
INSERT INTO person VALUES(705, 'Linda', 'Kašpárková','F', '23',  29000, 4, '13.4.2007');
INSERT INTO person VALUES(706, 'Lukáš', 'Valenta ','M', '27',  46000, 4, '14/10/2010');
INSERT INTO person VALUES(707, 'Nela', 'Klementová','F', '55',  36000, 3, '6.2.2004');
INSERT INTO person VALUES(708, 'Bohuslav', 'Bo?ek ','M', '49',  19000, 3, '21/10/2005');
INSERT INTO person VALUES(709, 'Sylva', 'Kubištová','F', '62',  16000, 4, '19.8.2009');
INSERT INTO person VALUES(710, 'Ernest', '?onka ','M', '32',  24000, 4, '23/1/2018');
INSERT INTO person VALUES(711, 'Veronika', 'Kulhánková','F', '24',  40000, 1, '21.10.2016');
INSERT INTO person VALUES(712, 'Oskar', 'Haná?ek ','M', '60',  29000, 1, '26/5/2017');
INSERT INTO person VALUES(713, 'Maria', 'Drozdová','F', '55',  40000, 3, '27.12.2011');
INSERT INTO person VALUES(714, 'Vladan', 'Peroutka ','M', '37',  39000, 3, '8/12/2008');
INSERT INTO person VALUES(715, 'Markéta', 'Kolková','F', '63',  28000, 4, '28.2.2019');
INSERT INTO person VALUES(716, '?ubomír', 'Hole?ek ','M', '19',  43000, 4, '11/4/2008');
INSERT INTO person VALUES(717, 'Zde?ka', 'Ji?íková','F', '48',  35000, 4, '25.12.2015');
INSERT INTO person VALUES(718, 'V?roslav', 'Vybíral ','M', '42',  16000, 4, '12/9/2019');
INSERT INTO person VALUES(719, 'V?ra', 'Šimánková','F', '34',  43000, 3, '19.10.2012');
INSERT INTO person VALUES(720, 'Miloslav', 'Pernica ','M', '64',  25000, 3, '19/9/2014');
INSERT INTO person VALUES(721, 'Markéta', 'Sokolová','F', '41',  23000, 4, '2.5.2018');
INSERT INTO person VALUES(722, 'Zoltán', 'Kliment ','M', '47',  31000, 4, '29/7/2010');
INSERT INTO person VALUES(723, 'Sandra', 'Tóthová','F', '50',  47000, 1, '8.2.2009');
INSERT INTO person VALUES(724, 'Lubor', 'Škoda ','M', '29',  35000, 1, '29/11/2009');
INSERT INTO person VALUES(725, 'Margita', 'Ulrichová','F', '35',  18000, 4, '5.12.2005');
INSERT INTO person VALUES(726, 'Adrian', 'Zikmund ','M', '51',  45000, 4, '6/12/2004');
INSERT INTO person VALUES(727, 'And?la', 'Peterková','F', '42',  34000, 1, '18.6.2011');
INSERT INTO person VALUES(728, 'Ota', 'Štefek ','M', '34',  14000, 1, '10/3/2017');
INSERT INTO person VALUES(729, 'Sandra', 'Vodi?ková','F', '28',  42000, 4, '13.4.2008');
INSERT INTO person VALUES(730, 'Ervín', 'Holan ','M', '57',  23000, 4, '17/3/2012');
INSERT INTO person VALUES(731, 'Jolana', 'Ptá?ková','F', '59',  13000, 3, '6.2.2005');
INSERT INTO person VALUES(732, 'Ji?í', 'Kova?ík ','M', '33',  32000, 3, '25/3/2007');
INSERT INTO person VALUES(733, 'Old?iška', 'Mayerová','F', '21',  29000, 4, '20.8.2010');
INSERT INTO person VALUES(734, 'Gabriel', 'Dohnal ','M', '62',  37000, 4, '27/6/2019');
INSERT INTO person VALUES(735, 'Tereza', 'Vl?ková','F', '29',  17000, 1, '22.10.2017');
INSERT INTO person VALUES(736, 'Samuel', 'Stárek ','M', '44',  42000, 1, '28/10/2018');
INSERT INTO person VALUES(737, 'Vlastimila', 'Jonášová','F', '59',  17000, 4, '27.12.2012');
INSERT INTO person VALUES(738, 'Drahomír', 'Jahoda ','M', '21',  16000, 4, '13/5/2010');
INSERT INTO person VALUES(739, 'Miroslava', 'Hanusová','F', '22',  41000, 1, '6.10.2003');
INSERT INTO person VALUES(740, 'Alexander 4 000', 'Ju?ík ','M', '49',  21000, 1, '13/9/2009');
INSERT INTO person VALUES(741, 'Tereza', 'Boudová','F', '53',  12000, 4, '25.12.2016');
INSERT INTO person VALUES(742, 'Erich', 'Bauer ','M', '26',  30000, 4, '20/9/2004');
INSERT INTO person VALUES(743, 'Pavlína', 'Krátká','F', '61',  28000, 1, '12.2.2006');
INSERT INTO person VALUES(744, 'Šimon', 'Malina ','M', '54',  35000, 1, '23/12/2016');
INSERT INTO person VALUES(745, 'Irena', 'Vlková','F', '46',  36000, 4, '3.5.2019');
INSERT INTO person VALUES(746, 'Anton', 'Janá?ek ','M', '31',  44000, 4, '31/12/2011');
INSERT INTO person VALUES(747, 'Milena', 'Sladká','F', '53',  15000, 4, '20.6.2008');
INSERT INTO person VALUES(748, 'Vit', 'Hartman ','M', '60',  13000, 4, '8/11/2007');
INSERT INTO person VALUES(749, 'Pavlína', 'Žídková','F', '39',  23000, 4, '16.4.2005');
INSERT INTO person VALUES(750, 'Denis', 'Kolman ','M', '36',  23000, 4, '11/4/2019');
INSERT INTO person VALUES(751, 'Lidmila', 'Kubištová','F', '47',  47000, 1, '18.6.2012');
INSERT INTO person VALUES(752, 'Peter', 'Antoš ','M', '64',  27000, 1, '12/8/2018');
INSERT INTO person VALUES(753, 'Simona', 'Formánková','F', '32',  47000, 4, '24.8.2007');
INSERT INTO person VALUES(754, 'Dalibor', 'Doležel ','M', '41',  37000, 4, '24/2/2010');
INSERT INTO person VALUES(755, 'Vanda', 'Drozdová','F', '40',  34000, 1, '26.10.2014');
INSERT INTO person VALUES(756, 'Dušan', 'Rozsypal ','M', '23',  42000, 1, '28/6/2009');
INSERT INTO person VALUES(757, 'Marika', '?ervenková','F', '47',  14000, 1, '14.12.2003');
INSERT INTO person VALUES(758, 'Radko', 'Steiner ','M', '52',  47000, 1, '6/5/2005');
INSERT INTO person VALUES(759, 'Lydie', 'Kohoutová','F', '33',  22000, 1, '4.3.2017');
INSERT INTO person VALUES(760, 'Filip', 'Tichý ','M', '29',  20000, 1, '6/10/2016');
INSERT INTO person VALUES(761, 'Bohdana', 'Jiroušková','F', '40',  38000, 1, '22.4.2006');
INSERT INTO person VALUES(762, 'Ctibor', 'Straka ','M', '58',  25000, 1, '15/8/2012');
INSERT INTO person VALUES(763, 'Barbara', 'Karlová','F', '26',  45000, 4, '11.7.2019');
INSERT INTO person VALUES(764, 'Tomáš', '?onka ','M', '34',  35000, 4, '23/8/2007');
INSERT INTO person VALUES(765, 'Zlata', 'Máchová','F', '57',  17000, 4, '6.5.2016');
INSERT INTO person VALUES(766, 'Radim', 'Hor?ák ','M', '56',  44000, 4, '23/1/2019');
INSERT INTO person VALUES(767, 'Vilma', 'Kocourková','F', '64',  33000, 4, '24.6.2005');
INSERT INTO person VALUES(768, 'Boleslav', 'Peroutka ','M', '39',  13000, 4, '2/12/2014');
INSERT INTO person VALUES(769, 'Kamila', 'Janková','F', '27',  21000, 1, '26.8.2012');
INSERT INTO person VALUES(770, 'Tobiáš', 'Hole?ek ','M', '21',  18000, 1, '4/4/2014');
INSERT INTO person VALUES(771, 'Zora', 'Karbanová','F', '57',  20000, 4, '1.11.2007');
INSERT INTO person VALUES(772, 'Mario', 'Kone?ný ','M', '44',  27000, 4, '18/10/2005');
INSERT INTO person VALUES(773, 'Bohumila', 'Kašparová','F', '19',  44000, 1, '3.1.2015');
INSERT INTO person VALUES(774, 'Kristián', 'Volný ','M', '26',  32000, 1, '18/2/2005');
INSERT INTO person VALUES(775, 'Marie', 'Barešová','F', '50',  44000, 4, '9.3.2010');
INSERT INTO person VALUES(776, 'Lubor', 'Hude?ek ','M', '50',  42000, 4, '27/1/2013');
INSERT INTO person VALUES(777, 'Alice', 'Vrabcová','F', '58',  32000, 1, '11.5.2017');
INSERT INTO person VALUES(778, 'Boris', 'Pracha? ','M', '32',  47000, 1, '30/5/2012');
INSERT INTO person VALUES(779, 'Št?pánka', 'Orságová','F', '44',  39000, 4, '7.3.2014');
INSERT INTO person VALUES(780, 'Oliver', 'Richter ','M', '54',  20000, 4, '7/6/2007');
INSERT INTO person VALUES(781, 'Regina', 'Pourová','F', '52',  27000, 1, '14.12.2004');
INSERT INTO person VALUES(782, 'Viliám', 'Štefek ','M', '36',  24000, 1, '8/10/2006');
INSERT INTO person VALUES(783, 'Antonie', 'Kroupová','F', '36',  27000, 4, '14.7.2016');
INSERT INTO person VALUES(784, 'Leo', 'Krej?ík ','M', '59',  34000, 4, '16/9/2014');
INSERT INTO person VALUES(785, 'Alžbeta', 'Cibulková','F', '45',  15000, 1, '23.4.2007');
INSERT INTO person VALUES(786, 'Slavomír', 'Vinš ','M', '41',  39000, 1, '17/1/2014');
INSERT INTO person VALUES(787, 'Václava', 'Kupcová','F', '29',  14000, 4, '21.11.2018');
INSERT INTO person VALUES(788, 'Mikuláš', 'Vav?ík ','M', '19',  13000, 4, '2/8/2005');
INSERT INTO person VALUES(789, 'Beáta', 'Kopecká','F', '38',  38000, 1, '29.8.2009');
INSERT INTO person VALUES(790, 'Erik', 'Tomek ','M', '47',  17000, 1, '3/12/2004');
INSERT INTO person VALUES(791, 'Yveta', 'Hájková','F', '23',  46000, 4, '25.6.2006');
INSERT INTO person VALUES(792, 'Emanuel', 'Vondrák ','M', '23',  26000, 4, '5/5/2016');
INSERT INTO person VALUES(793, 'Alena', 'Koukalová','F', '30',  25000, 1, '6.1.2012');
INSERT INTO person VALUES(794, 'Bed?ich', 'Smola ','M', '52',  32000, 1, '14/3/2012');
INSERT INTO person VALUES(795, 'Beáta', 'Skácelová','F', '62',  33000, 4, '1.11.2008');
INSERT INTO person VALUES(796, 'Andrej', 'Nešpor ','M', '28',  41000, 4, '22/3/2007');
INSERT INTO person VALUES(797, 'Veronika', 'Vránová','F', '23',  13000, 1, '15.5.2014');
INSERT INTO person VALUES(798, 'Bohuslav', 'Kuchta ','M', '57',  46000, 1, '23/6/2019');
INSERT INTO person VALUES(799, 'Lenka', 'Nová','F', '55',  21000, 4, '11.3.2011');
INSERT INTO person VALUES(800, 'Svatopluk', 'Charvát ','M', '33',  19000, 4, '1/7/2014');
INSERT INTO person VALUES(801, 'Marcela', 'Fuchsová','F', '62',  36000, 1, '21.9.2016');
INSERT INTO person VALUES(802, 'Libor', 'Št?rba ','M', '62',  25000, 1, '9/5/2010');
INSERT INTO person VALUES(803, 'Radmila', 'Brabencová','F', '24',  24000, 2, '1.7.2007');
INSERT INTO person VALUES(804, 'Václav', 'Berky ','M', '44',  29000, 2, '9/9/2009');
INSERT INTO person VALUES(805, 'Bohuslava', 'Cahová','F', '56',  32000, 1, '25.4.2004');
INSERT INTO person VALUES(806, 'Ivo', 'Strej?ek ','M', '21',  38000, 1, '17/9/2004');
INSERT INTO person VALUES(807, 'Drahoslava', '?ernochová','F', '63',  12000, 2, '6.11.2009');
INSERT INTO person VALUES(808, 'Maxmilián', 'Št?pánek ','M', '50',  44000, 2, '19/12/2016');
INSERT INTO person VALUES(809, 'Sandra', 'Bradá?ová','F', '49',  19000, 1, '2.9.2006');
INSERT INTO person VALUES(810, 'Vojt?ch', 'Kozel ','M', '26',  17000, 1, '28/12/2011');
INSERT INTO person VALUES(811, 'Karín', 'P?ibylová','F', '56',  35000, 1, '15.3.2012');
INSERT INTO person VALUES(812, 'Zoltán', 'Homola ','M', '55',  22000, 1, '5/11/2007');
INSERT INTO person VALUES(813, 'And?la', 'Janoušková','F', '41',  43000, 1, '9.1.2009');
INSERT INTO person VALUES(814, 'Miroslav', 'Zouhar ','M', '31',  31000, 1, '7/4/2019');
INSERT INTO person VALUES(815, 'Nina', 'Píšová','F', '49',  23000, 1, '23.7.2014');
INSERT INTO person VALUES(816, 'Radomil', 'Pícha ','M', '60',  37000, 1, '14/2/2015');
INSERT INTO person VALUES(817, 'Karin', '?ernohorská','F', '34',  30000, 1, '18.5.2011');
INSERT INTO person VALUES(818, 'Artur', 'Vícha ','M', '36',  46000, 1, '21/2/2010');
INSERT INTO person VALUES(819, 'Barbora', 'Sv?tlíková','F', '43',  18000, 2, '20.7.2018');
INSERT INTO person VALUES(820, 'Gerhard', 'Spá?il ','M', '64',  14000, 2, '24/6/2009');
INSERT INTO person VALUES(821, 'Nina', 'Doleželová','F', '27',  18000, 4, '24.9.2013');
INSERT INTO person VALUES(822, 'Walter', 'Franc ','M', '42',  24000, 4, '2/6/2017');
INSERT INTO person VALUES(823, 'Blanka', 'Do?ekalová','F', '35',  42000, 2, '3.7.2004');
INSERT INTO person VALUES(824, 'Cyril', 'Hroch ','M', '24',  29000, 2, '3/10/2016');
INSERT INTO person VALUES(825, 'Emilie', 'Brožová','F', '43',  21000, 2, '14.1.2010');
INSERT INTO person VALUES(826, 'Leoš', 'Bažant ','M', '53',  34000, 2, '12/8/2012');
INSERT INTO person VALUES(827, 'Miloslava', 'Jarošová','F', '28',  29000, 1, '10.11.2006');
INSERT INTO person VALUES(828, 'Julius', 'Pavlí?ek ','M', '29',  43000, 1, '20/8/2007');
INSERT INTO person VALUES(829, 'Františka', 'Máchová','F', '35',  45000, 2, '23.5.2012');
INSERT INTO person VALUES(830, 'Zbyn?k', 'Sláma ','M', '58',  13000, 2, '28/6/2003');
INSERT INTO person VALUES(831, 'Kv?toslava', 'Peka?ová','F', '21',  17000, 1, '19.3.2009');
INSERT INTO person VALUES(832, 'Tadeáš', 'Klement ','M', '34',  22000, 1, '29/11/2014');
INSERT INTO person VALUES(833, 'Milena', 'Macha?ová','F', '52',  24000, 1, '12.1.2006');
INSERT INTO person VALUES(834, 'Viliám', 'Mayer ','M', '57',  31000, 1, '6/12/2009');
INSERT INTO person VALUES(835, 'Františka', 'Šedivá','F', '59',  40000, 1, '26.7.2011');
INSERT INTO person VALUES(836, 'Vilém', '?ehá?ek ','M', '40',  36000, 1, '14/10/2005');
INSERT INTO person VALUES(837, 'Yvona', 'Hladká','F', '22',  28000, 2, '27.9.2018');
INSERT INTO person VALUES(838, 'Vít', 'Baláž ','M', '22',  41000, 2, '15/2/2005');
INSERT INTO person VALUES(839, 'Blažena', 'Tvrdá','F', '52',  27000, 1, '2.12.2013');
INSERT INTO person VALUES(840, 'Št?pán', 'Slavík ','M', '45',  15000, 1, '23/1/2013');
INSERT INTO person VALUES(841, 'Bohdana', 'Soukupová','F', '61',  15000, 2, '10.9.2004');
INSERT INTO person VALUES(842, 'Vlastimil', 'Mi?ka ','M', '27',  19000, 2, '27/5/2012');
INSERT INTO person VALUES(843, 'Kv?tuše', 'Langová','F', '45',  15000, 1, '10.4.2016');
INSERT INTO person VALUES(844, 'Jind?ich', 'Vojá?ek ','M', '50',  29000, 1, '10/12/2003');
INSERT INTO person VALUES(845, 'Tá?a', 'Peštová','F', '53',  39000, 2, '18.1.2007');
INSERT INTO person VALUES(846, 'Michal', 'Michna ','M', '32',  34000, 2, '5/9/2019');
INSERT INTO person VALUES(847, 'Bohdana', 'Hejlová','F', '39',  46000, 1, '13.11.2003');
INSERT INTO person VALUES(848, 'Vladislav', 'Vá?a ','M', '54',  43000, 1, '13/9/2014');
INSERT INTO person VALUES(849, 'Jana', 'Dlouhá','F', '46',  26000, 2, '26.5.2009');
INSERT INTO person VALUES(850, 'Nicolas', 'Horký ','M', '37',  12000, 2, '22/7/2010');
INSERT INTO person VALUES(851, 'Vanesa', 'Ková?ová','F', '32',  34000, 1, '22.3.2006');
INSERT INTO person VALUES(852, 'Ivan', 'P?íhoda ','M', '60',  21000, 1, '29/7/2005');
INSERT INTO person VALUES(853, 'Ludmila', 'H?lková','F', '39',  14000, 1, '3.10.2011');
INSERT INTO person VALUES(854, 'Oskar', 'Kudlá?ek ','M', '43',  27000, 1, '31/10/2017');
INSERT INTO person VALUES(855, 'Jana', 'Šimá?ková','F', '24',  21000, 1, '29.7.2008');
INSERT INTO person VALUES(856, 'Zden?k', 'Víšek ','M', '19',  36000, 1, '7/11/2012');
INSERT INTO person VALUES(857, 'Monika', 'Pelikánová','F', '32',  37000, 1, '9.2.2014');
INSERT INTO person VALUES(858, '?ubomír', 'Bašta ','M', '48',  41000, 1, '16/9/2008');
INSERT INTO person VALUES(859, 'Adriana', 'Skácelová','F', '40',  25000, 2, '18.11.2004');
INSERT INTO person VALUES(860, 'Ondrej', 'Nedv?d ','M', '30',  46000, 2, '18/1/2008');
INSERT INTO person VALUES(861, 'Irena', 'Farkašová','F', '24',  25000, 1, '18.6.2016');
INSERT INTO person VALUES(862, 'Jonáš', 'Žá?ek ','M', '53',  19000, 1, '26/12/2015');
INSERT INTO person VALUES(863, 'Ivona', 'Adamcová','F', '33',  12000, 2, '27.3.2007');
INSERT INTO person VALUES(864, 'Mykola', '?ernohorský ','M', '35',  24000, 2, '29/4/2015');
INSERT INTO person VALUES(865, 'Lada', 'Zapletalová','F', '64',  20000, 2, '21.1.2004');
INSERT INTO person VALUES(866, 'Lubor', 'Svato? ','M', '57',  33000, 2, '6/5/2010');
INSERT INTO person VALUES(867, 'Lidmila', 'Dunková','F', '26',  36000, 2, '3.8.2009');
INSERT INTO person VALUES(868, 'Bohumir', 'Sedlá?ek ','M', '40',  39000, 2, '14/3/2006');
INSERT INTO person VALUES(869, 'Viktorie', 'Koudelová','F', '57',  44000, 1, '30.5.2006');
INSERT INTO person VALUES(870, 'Ota', 'Tu?ek ','M', '63',  12000, 1, '15/8/2017');
INSERT INTO person VALUES(871, 'Vanda', 'Mare?ková','F', '64',  23000, 2, '11.12.2011');
INSERT INTO person VALUES(872, 'Michael', 'Lacina ','M', '46',  17000, 2, '23/6/2013');
INSERT INTO person VALUES(873, 'Diana', 'Mina?íková','F', '50',  31000, 1, '6.10.2008');
INSERT INTO person VALUES(874, 'Vlastislav', 'Neubauer ','M', '22',  26000, 1, '30/6/2008');
INSERT INTO person VALUES(875, 'Zlata', 'Kalábová','F', '57',  47000, 2, '19.4.2014');
INSERT INTO person VALUES(876, 'Mat?j', 'Pohl ','M', '51',  31000, 2, '9/5/2004');
INSERT INTO person VALUES(877, 'Katarína', 'Holasová','F', '42',  18000, 1, '12.2.2011');
INSERT INTO person VALUES(878, 'Leoš', 'Vodák ','M', '27',  41000, 1, '10/10/2015');
INSERT INTO person VALUES(879, 'Barbara', 'Homolková','F', '50',  34000, 1, '25.8.2016');
INSERT INTO person VALUES(880, 'Radek', 'Ku?era ','M', '56',  46000, 1, '19/8/2011');
INSERT INTO person VALUES(881, 'Karolína', '?ernohorská','F', '58',  22000, 3, '4.6.2007');
INSERT INTO person VALUES(882, 'Jan', 'Raška ','M', '38',  15000, 3, '20/12/2010');
INSERT INTO person VALUES(883, 'Nikola', 'Najmanová','F', '44',  30000, 2, '30.3.2004');
INSERT INTO person VALUES(884, 'Adam', 'Karban ','M', '61',  24000, 2, '27/12/2005');
INSERT INTO person VALUES(885, 'Kamila', 'Doleželová','F', '51',  46000, 2, '11.10.2009');
INSERT INTO person VALUES(886, 'Herbert', 'Rambousek ','M', '43',  29000, 2, '31/3/2018');
INSERT INTO person VALUES(887, 'Karolína', 'Sikorová','F', '36',  17000, 2, '7.8.2006');
INSERT INTO person VALUES(888, 'Ladislav', 'Sedlák ','M', '20',  38000, 2, '7/4/2013');
INSERT INTO person VALUES(889, 'Št?pánka', 'Šašková','F', '44',  33000, 2, '18.2.2012');
INSERT INTO person VALUES(890, 'Július', 'Ková? ','M', '49',  43000, 2, '14/2/2009');
INSERT INTO person VALUES(891, 'Vladimíra', 'Pot??ková','F', '29',  41000, 2, '13.12.2008');
INSERT INTO person VALUES(892, 'Zd?nek', 'Machala ','M', '25',  17000, 2, '22/2/2004');
INSERT INTO person VALUES(893, 'Ester', 'Šmídová','F', '38',  29000, 3, '15.2.2016');
INSERT INTO person VALUES(894, 'Bruno', 'Maxa ','M', '53',  21000, 3, '25/6/2003');
INSERT INTO person VALUES(895, 'Št?pánka', 'Bu?ková','F', '22',  28000, 1, '22.4.2011');
INSERT INTO person VALUES(896, 'Nikola', 'Michalík ','M', '30',  31000, 1, '3/6/2011');
INSERT INTO person VALUES(897, 'Regina', 'Macha?ová','F', '30',  16000, 3, '24.6.2018');
INSERT INTO person VALUES(898, 'Drahoslav', 'Barto? ','M', '58',  36000, 3, '4/10/2010');
INSERT INTO person VALUES(899, 'Ester', 'Moty?ková','F', '62',  24000, 2, '20.4.2015');
INSERT INTO person VALUES(900, 'Radko', 'Spurný ','M', '35',  45000, 2, '11/10/2005');
INSERT INTO person VALUES(901, 'Yveta', 'Švarcová','F', '23',  40000, 2, '7.6.2004');
INSERT INTO person VALUES(902, 'Karol', 'Merta ','M', '64',  14000, 2, '13/1/2018');
INSERT INTO person VALUES(903, 'Bed?iška', 'Suchánková','F', '55',  47000, 2, '26.8.2017');
INSERT INTO person VALUES(904, 'Ctibor', 'Hrdý ','M', '40',  23000, 2, '20/1/2013');
INSERT INTO person VALUES(905, 'Beáta', 'Menclová','F', '62',  27000, 2, '14.10.2006');
INSERT INTO person VALUES(906, 'Zdenek', 'Levý ','M', '23',  29000, 2, '28/11/2008');
INSERT INTO person VALUES(907, 'Yveta', 'Hlávková','F', '47',  35000, 2, '10.8.2003');
INSERT INTO person VALUES(908, 'Jáchym', 'Benda ','M', '45',  38000, 2, '7/12/2003');
INSERT INTO person VALUES(909, 'Lenka', 'Kozlová','F', '55',  14000, 2, '20.2.2009');
INSERT INTO person VALUES(910, 'Otto', 'Šedivý ','M', '28',  43000, 2, '9/3/2016');
INSERT INTO person VALUES(911, 'Tatiána', 'Ne?asová','F', '40',  22000, 1, '17.12.2005');
INSERT INTO person VALUES(912, 'Bo?ivoj', 'Hladký ','M', '50',  16000, 1, '18/3/2011');
INSERT INTO person VALUES(913, 'Veronika', 'Seifertová','F', '47',  38000, 2, '30.6.2011');
INSERT INTO person VALUES(914, 'René', 'Vojtíšek ','M', '33',  21000, 2, '24/1/2007');
INSERT INTO person VALUES(915, 'Bohuslava', 'Ková?ová','F', '56',  26000, 3, '1.9.2018');
INSERT INTO person VALUES(916, 'Radim', 'Marek ','M', '61',  26000, 3, '27/5/2006');
INSERT INTO person VALUES(917, 'Silvie 7300', 'Holá','F', '41',  33000, 2, '28.6.2015');
INSERT INTO person VALUES(918, 'Igor', 'Formánek ','M', '38',  35000, 2, '28/10/2017');
INSERT INTO person VALUES(919, 'Radmila', 'Šimá?ková','F', '49',  13000, 3, '15.8.2004');
INSERT INTO person VALUES(920, 'Daniel', 'Seidl ','M', '21',  41000, 3, '5/9/2013');
INSERT INTO person VALUES(921, 'Bohuslava', 'Ferková','F', '34',  21000, 2, '3.11.2017');
INSERT INTO person VALUES(922, 'Viktor', 'Macha? ','M', '43',  14000, 2, '12/9/2008');
INSERT INTO person VALUES(923, 'And?la', 'Melicharová','F', '41',  37000, 3, '22.12.2006');
INSERT INTO person VALUES(924, 'Jaroslav', 'Polanský ','M', '26',  19000, 3, '22/7/2004');
INSERT INTO person VALUES(925, 'Sandra', 'Bartáková','F', '27',  44000, 2, '18.10.2003');
INSERT INTO person VALUES(926, 'Luboš', 'Králí?ek ','M', '48',  28000, 2, '23/12/2015');
INSERT INTO person VALUES(927, 'Karín', 'Krají?ková','F', '34',  24000, 2, '30.4.2009');
INSERT INTO person VALUES(928, 'Adrian', 'Kotrba ','M', '31',  33000, 2, '1/11/2011');
INSERT INTO person VALUES(929, 'Old?iška', 'Tvrdíková','F', '20',  32000, 2, '24.2.2006');
INSERT INTO person VALUES(930, 'Ond?ej', 'Ve?e?a ','M', '53',  43000, 2, '8/11/2006');
INSERT INTO person VALUES(931, 'Božena', '?ÍŽková','F', '28',  20000, 3, '28.4.2013');
INSERT INTO person VALUES(932, 'Po?et', 'Koní?ek ','M', '36',  47000, 3, '11/3/2006');
INSERT INTO person VALUES(933, 'Karin', 'Homolová','F', '58',  19000, 2, '2.7.2008');
INSERT INTO person VALUES(934, 'Jan', 'Maršík ','M', '59',  21000, 2, '17/2/2014');
INSERT INTO person VALUES(935, 'Miroslava', 'Kade?ábková','F', '21',  43000, 3, '4.9.2015');
INSERT INTO person VALUES(936, 'Gejza', 'Vítek ','M', '41',  26000, 3, '20/6/2013');
INSERT INTO person VALUES(937, 'Miloslava', 'Mina?íková','F', '28',  23000, 3, '22.10.2004');
INSERT INTO person VALUES(938, 'Samuel', 'Dan?k ','M', '24',  31000, 3, '28/4/2009');
INSERT INTO person VALUES(939, 'Blanka', 'Vlasáková','F', '59',  31000, 3, '11.1.2018');
INSERT INTO person VALUES(940, 'Oleg', 'Koubek ','M', '46',  40000, 3, '6/5/2004');
INSERT INTO person VALUES(941, 'Kv?toslava', 'Hrochová','F', '21',  46000, 3, '1.3.2007');
INSERT INTO person VALUES(942, 'Alexander 4 000', 'Mužík ','M', '29',  45000, 3, '7/8/2016');
INSERT INTO person VALUES(943, 'Milena', 'Vav?íková','F', '52',  18000, 2, '26.12.2003');
INSERT INTO person VALUES(944, 'Erich', 'Pivo?ka ','M', '51',  19000, 2, '15/8/2011');
INSERT INTO person VALUES(945, 'Pavlína', 'Borovi?ková','F', '38',  26000, 2, '16.3.2017');
INSERT INTO person VALUES(946, 'Alfred', 'Ka?írek ','M', '28',  28000, 2, '23/8/2006');
INSERT INTO person VALUES(947, 'Kv?toslava', 'Nedv?dová','F', '45',  42000, 2, '4.5.2006');
INSERT INTO person VALUES(948, 'Anton', 'Bláha ','M', '57',  33000, 2, '24/11/2018');
INSERT INTO person VALUES(949, 'Tamara', 'Kle?ková','F', '53',  29000, 3, '5.7.2013');
INSERT INTO person VALUES(950, 'Svatopluk', 'Zlámal ','M', '39',  38000, 3, '28/3/2018');
INSERT INTO person VALUES(951, 'Natálie', 'Hrabovská','F', '38',  29000, 2, '9.9.2008');
INSERT INTO person VALUES(952, 'Denis', 'Homolka ','M', '62',  47000, 2, '10/10/2009');
INSERT INTO person VALUES(953, 'Marika', 'Prokešová','F', '46',  17000, 3, '12.11.2015');
INSERT INTO person VALUES(954, 'Peter', 'Mou?ka ','M', '44',  16000, 3, '10/2/2009');
INSERT INTO person VALUES(955, 'Lydie', 'Lukešová','F', '32',  25000, 3, '7.9.2012');
INSERT INTO person VALUES(956, 'Marián', 'Hlavá?ek ','M', '20',  25000, 3, '19/2/2004');
INSERT INTO person VALUES(957, 'Bohdana', 'Krej?í?ová','F', '39',  40000, 3, '21.3.2018');
INSERT INTO person VALUES(958, 'Dušan', 'Švarc ','M', '49',  31000, 3, '22/5/2016');
INSERT INTO person VALUES(959, 'Marika', 'Bou?ková','F', '24',  12000, 2, '15.1.2015');
INSERT INTO person VALUES(960, 'Alexandr', 'Maršálek ','M', '25',  40000, 2, '30/5/2011');
INSERT INTO person VALUES(961, 'Vanesa', 'Houdková','F', '32',  28000, 3, '4.3.2004');
INSERT INTO person VALUES(962, 'Filip', 'Balcar ','M', '54',  45000, 3, '8/4/2007');
INSERT INTO person VALUES(963, 'Gabriela', 'Veselá','F', '64',  43000, 3, '12.1.2019');
INSERT INTO person VALUES(964, 'Juraj', 'Šedivý ','M', '30',  18000, 3, '8/10/2005');
INSERT INTO person VALUES(965, 'Drahomíra', 'Hrabalová','F', '26',  23000, 3, '1.3.2008');
INSERT INTO person VALUES(966, 'Mat?j', 'Mare?ek ','M', '59',  23000, 3, '9/1/2018');
INSERT INTO person VALUES(967, 'Romana', 'Jiráková','F', '57',  31000, 3, '26.12.2004');
INSERT INTO person VALUES(968, 'Marian', 'Vojtíšek ','M', '35',  32000, 3, '17/1/2013');
INSERT INTO person VALUES(969, 'Bohumila', 'Hlavá?ová','F', '64',  47000, 3, '9.7.2010');
INSERT INTO person VALUES(970, 'Radek', 'Petr? ','M', '64',  37000, 3, '25/11/2008');
INSERT INTO person VALUES(971, 'Kamila', 'Stehlíková','F', '50',  18000, 3, '5.5.2007');
INSERT INTO person VALUES(972, 'Zbyn?k', 'Molnár ','M', '40',  46000, 3, '3/12/2003');
INSERT INTO person VALUES(973, 'Kristina', 'Richtrová','F', '57',  34000, 3, '15.11.2012');
INSERT INTO person VALUES(974, 'Josef', 'Stupka ','M', '23',  16000, 3, '6/3/2016');
INSERT INTO person VALUES(975, 'Št?pánka', 'Ve?erková','F', '43',  42000, 2, '10.9.2009');
INSERT INTO person VALUES(976, 'Patrik', 'Sobotka ','M', '46',  25000, 2, '14/3/2011');
INSERT INTO person VALUES(977, 'Edita', 'Hamplová','F', '50',  22000, 3, '24.3.2015');
INSERT INTO person VALUES(978, '?udovít', 'Mina?ík ','M', '28',  30000, 3, '21/1/2007');
INSERT INTO person VALUES(979, 'Alice', 'Franková','F', '35',  29000, 2, '18.1.2012');
INSERT INTO person VALUES(980, 'Stanislav', 'Hrbek ','M', '51',  39000, 2, '23/6/2018');
INSERT INTO person VALUES(981, 'Alžbeta', 'Hendrychová','F', '44',  17000, 3, '22.3.2019');
INSERT INTO person VALUES(982, 'Svatoslav', 'Kotrba ','M', '33',  44000, 3, '24/10/2017');
INSERT INTO person VALUES(983, 'Kate?ina', 'Jedli?ková','F', '51',  33000, 4, '9.5.2008');
INSERT INTO person VALUES(984, 'Viliám', 'Pavlík ','M', '62',  13000, 4, '2/9/2013');
INSERT INTO person VALUES(985, 'Nad?žda', 'Vav?íková','F', '38',  13000, 4, '25.10.2006');
INSERT INTO person VALUES(986, 'Milan', 'Koní?ek ','M', '37',  22000, 4, '4/3/2012');
INSERT INTO person VALUES(987, 'Alžbeta', 'Mat?jková','F', '22',  12000, 3, '25.5.2018');
INSERT INTO person VALUES(988, 'Vladimír', 'Maršík ','M', '60',  32000, 3, '17/9/2003');
INSERT INTO person VALUES(989, 'Mária', 'Nedv?dová','F', '30',  36000, 4, '2.3.2009');
INSERT INTO person VALUES(990, 'Roland', 'Bedná? ','M', '42',  36000, 4, '14/6/2019');
INSERT INTO person VALUES(991, 'Beáta', 'Vejvodová','F', '61',  36000, 2, '7.5.2004');
INSERT INTO person VALUES(992, 'Nicolas', 'Jež ','M', '20',  46000, 2, '27/12/2010');
INSERT INTO person VALUES(993, 'Kv?ta', 'Hrabovská','F', '23',  24000, 3, '10.7.2011');
INSERT INTO person VALUES(994, 'Alex', 'Koubek ','M', '48',  15000, 3, '29/4/2010');
INSERT INTO person VALUES(995, 'Josefa', 'Táborská','F', '30',  39000, 4, '20.1.2017');
INSERT INTO person VALUES(996, '?estmír', 'Mužík ','M', '31',  20000, 4, '8/3/2006');
INSERT INTO person VALUES(997, 'Sára', 'Knotková','F', '62',  47000, 3, '16.11.2013');
INSERT INTO person VALUES(998, 'Imrich', 'Pivo?ka ','M', '53',  29000, 3, '8/8/2017');
INSERT INTO person VALUES(999, 'Kv?ta', 'Wagnerová','F', '47',  19000, 3, '12.9.2010');
INSERT INTO person VALUES(1000, 'Ruslan', 'Ka?írek ','M', '29',  38000, 3, '15/8/2012');
INSERT INTO person VALUES(1001, 'Bohuslava', '?Íhová','F', '55',  35000, 3, '25.3.2016');
INSERT INTO person VALUES(1002, 'Ondrej', 'Bláha ','M', '58',  44000, 3, '24/6/2008');
INSERT INTO person VALUES(1003, 'Silvie 7300', 'Musilová','F', '40',  42000, 2, '18.1.2013');
INSERT INTO person VALUES(1004, 'Alan', 'Hrdina ','M', '35',  17000, 2, '2/7/2003');
INSERT INTO person VALUES(1005, 'Natalie', 'Kubínová','F', '49',  30000, 4, '28.10.2003');
INSERT INTO person VALUES(1006, 'Kristián', 'Šíp ','M', '63',  21000, 4, '28/3/2019');
INSERT INTO person VALUES(1007, 'Jitka', 'Mí?ková','F', '56',  46000, 4, '10.5.2009');
INSERT INTO person VALUES(1008, 'P?emysl', 'Mou?ka ','M', '45',  27000, 4, '4/2/2015');
INSERT INTO person VALUES(1009, 'Anna', 'Kopalová','F', '41',  18000, 3, '6.3.2006');
INSERT INTO person VALUES(1010, 'Leopold', 'Hlavá?ek ','M', '22',  36000, 3, '11/2/2010');
INSERT INTO person VALUES(1011, 'Zuzana', 'Záme?níková','F', '49',  33000, 4, '17.9.2011');
INSERT INTO person VALUES(1012, 'Emil', 'Švarc ','M', '51',  41000, 4, '21/12/2005');
INSERT INTO person VALUES(1013, 'Jitka', 'Gabrielová','F', '34',  41000, 3, '13.7.2008');
INSERT INTO person VALUES(1014, 'Evžen', 'Maršálek ','M', '27',  14000, 3, '23/5/2017');
INSERT INTO person VALUES(1015, 'Eva', 'Vojá?ková','F', '20',  13000, 3, '8.5.2005');
INSERT INTO person VALUES(1016, '?en?k', 'Sko?epa ','M', '49',  23000, 3, '30/5/2012');
INSERT INTO person VALUES(1017, 'Hedvika', 'Ve?erková','F', '28',  36000, 4, '10.7.2012');
INSERT INTO person VALUES(1018, 'Mikuláš', 'Šedivý ','M', '31',  28000, 4, '2/10/2011');
INSERT INTO person VALUES(1019, 'Dita', 'Hamplová','F', '35',  16000, 4, '21.1.2018');
INSERT INTO person VALUES(1020, 'Kamil', 'Bílý ','M', '60',  33000, 4, '10/8/2007');
INSERT INTO person VALUES(1021, 'Nikol', 'Franková','F', '21',  24000, 4, '17.11.2014');
INSERT INTO person VALUES(1022, 'Erik', 'Dvorský ','M', '37',  42000, 4, '10/1/2019');
INSERT INTO person VALUES(1023, 'Karla', 'Koubová','F', '52',  32000, 3, '13.9.2011');
INSERT INTO person VALUES(1024, 'Nikolas', 'Kala ','M', '59',  16000, 3, '18/1/2014');
INSERT INTO person VALUES(1025, 'Dita', 'Píchová','F', '60',  47000, 3, '26.3.2017');
INSERT INTO person VALUES(1026, 'Bed?ich', 'Molnár ','M', '42',  21000, 3, '26/11/2009');
INSERT INTO person VALUES(1027, 'Nikol', 'Šírová','F', '45',  19000, 3, '19.1.2014');
INSERT INTO person VALUES(1028, 'Andrej', 'Adámek ','M', '64',  30000, 3, '3/12/2004');
INSERT INTO person VALUES(1029, 'Bronislava', 'Menšíková','F', '52',  35000, 3, '2.8.2019');
INSERT INTO person VALUES(1030, 'Alois', 'Sobotka ','M', '47',  35000, 3, '7/3/2017');
INSERT INTO person VALUES(1031, 'Ji?ina', 'Pale?ková','F', '61',  23000, 4, '11.5.2010');
INSERT INTO person VALUES(1032, 'Libor', 'Polanský ','M', '29',  40000, 4, '8/7/2016');
INSERT INTO person VALUES(1033, 'Petra', 'Vejvodová','F', '46',  30000, 4, '7.3.2007');
INSERT INTO person VALUES(1034, 'Marcel', 'Králí?ek ','M', '52',  13000, 4, '16/7/2011');
INSERT INTO person VALUES(1035, 'Libuše', 'Ondrá?ková','F', '53',  46000, 4, '17.9.2012');
INSERT INTO person VALUES(1036, 'Karel', 'Jakoubek ','M', '34',  18000, 4, '25/5/2007');
INSERT INTO person VALUES(1037, 'Ivana', 'Kop?ivová','F', '39',  18000, 4, '14.7.2009');
INSERT INTO person VALUES(1038, 'Rostislav', 'Škoda ','M', '57',  28000, 4, '25/10/2018');
INSERT INTO person VALUES(1039, 'Andrea', 'Maxová','F', '46',  34000, 4, '25.1.2015');
INSERT INTO person VALUES(1040, 'Maxmilián', 'Buchta ','M', '40',  33000, 4, '3/9/2014');
INSERT INTO person VALUES(1041, 'Dana', 'Hejnová','F', '32',  41000, 3, '21.11.2011');
INSERT INTO person VALUES(1042, 'Vojt?ch', 'Maršík ','M', '62',  42000, 3, '10/9/2009');
INSERT INTO person VALUES(1043, 'Sylva', '?Íhová','F', '40',  29000, 1, '22.1.2019');
INSERT INTO person VALUES(1044, 'Martin', 'Bedná? ','M', '44',  47000, 1, '11/1/2009');
INSERT INTO person VALUES(1045, 'Andrea', 'Buchtová','F', '24',  29000, 3, '29.3.2014');
INSERT INTO person VALUES(1046, 'Miroslav', 'Jež ','M', '21',  21000, 3, '20/12/2016');
INSERT INTO person VALUES(1047, 'Maria', '?eho?ová','F', '33',  17000, 4, '5.1.2005');
INSERT INTO person VALUES(1048, 'Artur', 'Koubek ','M', '49',  25000, 4, '22/4/2016');
INSERT INTO person VALUES(1049, 'Gabriela', 'Remešová','F', '63',  16000, 3, '5.8.2016');
INSERT INTO person VALUES(1050, 'Zbyšek', 'Uhlí? ','M', '27',  35000, 3, '5/11/2007');
INSERT INTO person VALUES(1051, 'Karolina', 'Vaší?ková','F', '26',  40000, 4, '15.5.2007');
INSERT INTO person VALUES(1052, 'Walter', 'Bernard ','M', '55',  40000, 4, '9/3/2007');
INSERT INTO person VALUES(1053, 'Sylvie', 'Truhlá?ová','F', '33',  20000, 1, '25.11.2012');
INSERT INTO person VALUES(1054, 'Juraj', 'R?žek ','M', '38',  45000, 1, '10/6/2019');
INSERT INTO person VALUES(1055, 'Valerie', 'Zezulová','F', '64',  28000, 4, '21.9.2009');
INSERT INTO person VALUES(1056, 'Petro', 'Bláha ','M', '60',  18000, 4, '18/6/2014');
INSERT INTO person VALUES(1057, 'Jaromíra', 'Hanková','F', '50',  35000, 3, '17.7.2006');
INSERT INTO person VALUES(1058, 'Vladimir', 'Hrdina ','M', '36',  27000, 3, '25/6/2009');
INSERT INTO person VALUES(1059, 'Sylvie', 'Horová','F', '57',  15000, 4, '28.1.2012');
INSERT INTO person VALUES(1060, 'Julius', 'Homolka ','M', '19',  32000, 4, '3/5/2005');
INSERT INTO person VALUES(1061, 'Nataša', 'Hanzlíková','F', '43',  23000, 3, '23.11.2008');
INSERT INTO person VALUES(1062, 'Július', 'Sadílek ','M', '41',  42000, 3, '4/10/2016');
INSERT INTO person VALUES(1063, 'Klára', 'Skalová','F', '51',  47000, 4, '26.1.2016');
INSERT INTO person VALUES(1064, 'Viliam', 'Hlavá?ek ','M', '23',  46000, 4, '5/2/2016');
INSERT INTO person VALUES(1065, 'Eliška', 'Kloudová','F', '37',  18000, 4, '21.11.2012');
INSERT INTO person VALUES(1066, 'Bruno', 'Husák ','M', '46',  19000, 4, '12/2/2011');
INSERT INTO person VALUES(1067, 'Daniela', 'Vrbová','F', '44',  34000, 4, '4.6.2018');
INSERT INTO person VALUES(1068, 'Matouš', 'Maršálek ','M', '29',  25000, 4, '22/12/2006');
INSERT INTO person VALUES(1069, 'Zdenka', 'Pechová','F', '29',  42000, 3, '30.3.2015');
INSERT INTO person VALUES(1070, 'Hubert', 'Sko?epa ','M', '51',  34000, 3, '24/5/2018');
INSERT INTO person VALUES(1071, 'Nad?žda', 'Šandová','F', '37',  21000, 4, '17.5.2004');
INSERT INTO person VALUES(1072, 'Hynek', 'Zv??ina ','M', '34',  39000, 4, '1/4/2014');
INSERT INTO person VALUES(1073, 'Daniela', 'Komínková','F', '22',  29000, 3, '6.8.2017');
INSERT INTO person VALUES(1074, 'Ferdinand', 'Valenta ','M', '56',  12000, 3, '9/4/2009');
INSERT INTO person VALUES(1075, 'Mária', 'Kulhánková','F', '29',  45000, 4, '24.9.2006');
INSERT INTO person VALUES(1076, 'Radomír', 'Jedli?ka ','M', '39',  18000, 4, '15/2/2005');
INSERT INTO person VALUES(1077, 'Olena', 'Hrbková','F', '38',  33000, 1, '26.11.2013');
INSERT INTO person VALUES(1078, 'Lud?k', 'Petr? ','M', '21',  22000, 1, '18/6/2004');
INSERT INTO person VALUES(1079, 'Patricie', 'Pašková','F', '23',  40000, 4, '22.9.2010');
INSERT INTO person VALUES(1080, 'Kryštof', 'Molnár ','M', '44',  31000, 4, '20/11/2015');
INSERT INTO person VALUES(1081, 'Radomíra', 'Klímová','F', '31',  20000, 1, '4.4.2016');
INSERT INTO person VALUES(1082, 'Ivan', 'Stupka ','M', '27',  37000, 1, '28/9/2011');
INSERT INTO person VALUES(1083, 'Na?a', 'Pešková','F', '62',  28000, 4, '29.1.2013');
INSERT INTO person VALUES(1084, 'Ludvík', 'Sobotka ','M', '49',  46000, 4, '5/10/2006');
INSERT INTO person VALUES(1085, 'Tatiana', 'Václavková','F', '23',  44000, 1, '12.8.2018');
INSERT INTO person VALUES(1086, 'Zden?k', 'Mina?ík ','M', '32',  15000, 1, '7/1/2019');
INSERT INTO person VALUES(1087, 'Miriam', 'Šlechtová','F', '55',  15000, 4, '7.6.2015');
INSERT INTO person VALUES(1088, 'Richard', 'Hrbek ','M', '54',  24000, 4, '14/1/2014');
INSERT INTO person VALUES(1089, 'Hana', 'Martinková','F', '62',  31000, 4, '25.7.2004');
INSERT INTO person VALUES(1090, 'V?roslav', 'Schejbal ','M', '37',  30000, 4, '23/11/2009');
INSERT INTO person VALUES(1091, 'Natalie', 'Peterková','F', '47',  39000, 4, '14.10.2017');
INSERT INTO person VALUES(1092, 'Miloslav', 'Barák ','M', '59',  39000, 4, '30/11/2004');
INSERT INTO person VALUES(1093, 'Jitka', 'Knapová','F', '55',  19000, 4, '2.12.2006');
INSERT INTO person VALUES(1094, 'Alan', 'Šim?ík ','M', '42',  44000, 4, '4/3/2017');
INSERT INTO person VALUES(1095, 'Anna', 'Kavková','F', '40',  26000, 4, '28.9.2003');
INSERT INTO person VALUES(1096, 'Jaroslav', 'Nová?ek ','M', '19',  17000, 4, '11/3/2012');
INSERT INTO person VALUES(1097, 'Zuzana', 'Hude?ková','F', '47',  42000, 4, '10.4.2009');
INSERT INTO person VALUES(1098, 'Augustin', 'Václavík ','M', '48',  22000, 4, '18/1/2008');
INSERT INTO person VALUES(1099, 'Vladislava', 'Teplá','F', '56',  30000, 1, '12.6.2016');
INSERT INTO person VALUES(1100, 'Ota', 'Baloun ','M', '30',  27000, 1, '22/5/2007');
INSERT INTO person VALUES(1101, 'Leona', 'Rudolfová','F', '41',  38000, 1, '7.4.2013');
INSERT INTO person VALUES(1102, 'Ervín', 'Hýbl ','M', '52',  36000, 1, '22/10/2018');
INSERT INTO person VALUES(1103, 'Ivanka', 'Sobotková','F', '49',  17000, 1, '19.10.2018');
INSERT INTO person VALUES(1104, 'Vlastislav', 'Š astný ','M', '35',  42000, 1, '30/8/2014');
INSERT INTO person VALUES(1105, 'Vladislava', 'Hole?ková','F', '34',  25000, 4, '15.8.2015');
INSERT INTO person VALUES(1106, 'Gabriel', 'Jonáš ','M', '57',  15000, 4, '7/9/2009');
INSERT INTO person VALUES(1107, 'Jindra', 'Hanzalová','F', '41',  41000, 1, '2.10.2004');
INSERT INTO person VALUES(1108, 'Radovan', 'Doubek ','M', '40',  20000, 1, '16/7/2005');
INSERT INTO person VALUES(1109, 'Elena', 'Hanousková','F', '27',  12000, 4, '22.12.2017');
INSERT INTO person VALUES(1110, 'Drahomír', 'Pašek ','M', '62',  29000, 4, '16/12/2016');
INSERT INTO person VALUES(1111, 'Žofie', 'Kola?íková','F', '34',  28000, 1, '9.2.2007');
INSERT INTO person VALUES(1112, 'Jozef', 'Mat?jí?ek ','M', '45',  34000, 1, '25/10/2012');
INSERT INTO person VALUES(1113, 'Jindra', 'Valová','F', '20',  36000, 4, '6.12.2003');
INSERT INTO person VALUES(1114, 'Alexander 4 000', 'Brázdil ','M', '22',  44000, 4, '2/11/2007');
INSERT INTO person VALUES(1115, 'Johana', 'Moudrá','F', '27',  16000, 4, '18.6.2009');
INSERT INTO person VALUES(1116, 'Lubomír', 'Kopecký ','M', '51',  13000, 4, '11/9/2003');
INSERT INTO person VALUES(1117, 'Ema', 'Lavi?ková','F', '58',  23000, 4, '13.4.2006');
INSERT INTO person VALUES(1118, 'B?etislav', 'Balog ','M', '27',  22000, 4, '11/2/2015');
INSERT INTO person VALUES(1119, 'Iveta', 'Linhartová','F', '21',  47000, 1, '15.6.2013');
INSERT INTO person VALUES(1120, 'Vit', 'Kubiš ','M', '55',  27000, 1, '14/6/2014');
INSERT INTO person VALUES(1121, 'Ilona', 'Hanková','F', '28',  27000, 1, '27.12.2018');
INSERT INTO person VALUES(1122, 'Prokop', 'Látal ','M', '38',  32000, 1, '23/4/2010');
INSERT INTO person VALUES(1123, 'Radka', 'Kalousková','F', '60',  35000, 1, '23.10.2015');
INSERT INTO person VALUES(1124, 'Rudolf', 'Jane?ek ','M', '60',  41000, 1, '30/4/2005');
INSERT INTO person VALUES(1125, 'Danuše', 'Hanzlíková','F', '21',  15000, 1, '10.12.2004');
INSERT INTO person VALUES(1126, 'Bruno', 'David ','M', '43',  46000, 1, '2/8/2017');
INSERT INTO person VALUES(1127, 'Aneta', '?ezá?ová','F', '52',  22000, 1, '1.3.2018');
INSERT INTO person VALUES(1128, 'Milan', 'Záruba ','M', '20',  20000, 1, '9/8/2012');
INSERT INTO person VALUES(1129, 'Magdalena', 'Linková','F', '60',  38000, 1, '19.4.2007');
INSERT INTO person VALUES(1130, 'Hubert', 'Sova ','M', '48',  25000, 1, '17/6/2008');
INSERT INTO person VALUES(1131, 'Danuše', 'Mokrá','F', '45',  46000, 4, '12.2.2004');
INSERT INTO person VALUES(1132, 'Roland', 'Hrubeš ','M', '25',  34000, 4, '26/6/2003');
INSERT INTO person VALUES(1133, 'Karla', 'Kašpárková','F', '52',  25000, 1, '25.8.2009');
INSERT INTO person VALUES(1134, 'Ferdinand', 'Fousek ','M', '54',  39000, 1, '27/9/2015');
INSERT INTO person VALUES(1135, 'Ladislava', 'Vojtová','F', '38',  33000, 4, '21.6.2006');
INSERT INTO person VALUES(1136, 'Alex', 'Horá?ek ','M', '30',  12000, 4, '4/10/2010');
INSERT INTO person VALUES(1137, 'Nikol', 'Chlupová','F', '45',  13000, 1, '2.1.2012');
INSERT INTO person VALUES(1138, '?estmír', 'B?ezina ','M', '59',  18000, 1, '13/8/2006');
INSERT INTO person VALUES(1139, 'Karla', 'Danišová','F', '30',  21000, 4, '28.10.2008');
INSERT INTO person VALUES(1140, 'Imrich', 'Janovský ','M', '35',  27000, 4, '13/1/2018');
INSERT INTO person VALUES(1141, 'Radana', 'Radová','F', '39',  44000, 1, '31.12.2015');
INSERT INTO person VALUES(1142, 'Bohdan', 'Kameník ','M', '63',  32000, 1, '16/5/2017');
INSERT INTO person VALUES(1143, 'Hanna', 'Bohá?ová','F', '24',  16000, 1, '25.10.2012');
INSERT INTO person VALUES(1144, 'Mario', 'Ko?ínek ','M', '40',  41000, 1, '24/5/2012');
INSERT INTO person VALUES(1145, 'Iryna', 'Tomešová','F', '32',  32000, 1, '8.5.2018');
INSERT INTO person VALUES(1146, 'Mojmír', 'Hofman ','M', '23',  46000, 1, '1/4/2008');
INSERT INTO person VALUES(1147, 'Nicole', 'Šimánková','F', '63',  40000, 4, '4.3.2015');
INSERT INTO person VALUES(1148, 'Kristián', 'Žiga ','M', '45',  19000, 4, '2/9/2019');
INSERT INTO person VALUES(1149, 'Vendula', 'Hrubá','F', '26',  27000, 2, '11.12.2005');
INSERT INTO person VALUES(1150, 'Boris', 'Kalaš ','M', '27',  24000, 2, '4/1/2019');
INSERT INTO person VALUES(1151, 'Laura', 'K?enková','F', '56',  27000, 4, '11.7.2017');
INSERT INTO person VALUES(1152, 'Leopold', 'Ho?ejší ','M', '50',  34000, 4, '19/7/2010');
INSERT INTO person VALUES(1153, 'Julie', 'Ulrichová','F', '64',  15000, 1, '19.4.2008');
INSERT INTO person VALUES(1154, 'Lumír', 'Veverka ','M', '32',  38000, 1, '19/11/2009');
INSERT INTO person VALUES(1155, 'Linda', 'Peterková','F', '26',  31000, 2, '31.10.2013');
INSERT INTO person VALUES(1156, 'Bohumil', 'Šmejkal ','M', '61',  44000, 2, '28/9/2005');
INSERT INTO person VALUES(1157, 'Nela', 'Vodi?ková','F', '57',  38000, 1, '27.8.2010');
INSERT INTO person VALUES(1158, 'Matyáš', 'Vo?íšek ','M', '37',  17000, 1, '28/2/2017');
INSERT INTO person VALUES(1159, 'Julie', 'Ptá?ková','F', '43',  46000, 1, '22.6.2007');
INSERT INTO person VALUES(1160, 'Mikuláš', 'Dosko?il ','M', '60',  26000, 1, '8/3/2012');
INSERT INTO person VALUES(1161, 'Terezie', 'Mayerová','F', '50',  26000, 1, '2.1.2013');
INSERT INTO person VALUES(1162, 'Kamil', 'Kotas ','M', '43',  31000, 1, '15/1/2008');
INSERT INTO person VALUES(1163, 'Erika', 'Berkyová','F', '35',  33000, 4, '29.10.2009');
INSERT INTO person VALUES(1164, 'Bronislav', 'Horký ','M', '19',  40000, 4, '17/6/2019');
INSERT INTO person VALUES(1165, 'Darina', 'Veverková','F', '43',  13000, 1, '12.5.2015');
INSERT INTO person VALUES(1166, 'Miloš', 'Hanzlík ','M', '48',  46000, 1, '26/4/2015');
INSERT INTO person VALUES(1167, 'Zde?ka', 'Hanusová','F', '51',  37000, 2, '18.2.2006');
INSERT INTO person VALUES(1168, 'Lukáš', 'Šimák ','M', '30',  14000, 2, '27/8/2014');
INSERT INTO person VALUES(1169, 'V?ra', 'Boudová','F', '37',  45000, 1, '10.5.2019');
INSERT INTO person VALUES(1170, 'Bohuslav', 'Kopecký ','M', '52',  23000, 1, '3/9/2009');
INSERT INTO person VALUES(1171, 'Vlasta', 'Krátká','F', '44',  25000, 2, '27.6.2008');
INSERT INTO person VALUES(1172, 'Kevin', 'Kubí?ek ','M', '35',  29000, 2, '13/7/2005');
INSERT INTO person VALUES(1173, 'Martina', 'Klimešová','F', '29',  32000, 1, '22.4.2005');
INSERT INTO person VALUES(1174, 'Libor', 'Plachý ','M', '58',  38000, 1, '13/12/2016');
INSERT INTO person VALUES(1175, 'Eliška', 'Kunešová','F', '37',  12000, 2, '3.11.2010');
INSERT INTO person VALUES(1176, 'Vladan', 'Mikula ','M', '41',  43000, 2, '22/10/2012');
INSERT INTO person VALUES(1177, 'Vlasta', 'Žídková','F', '22',  20000, 1, '30.8.2007');
INSERT INTO person VALUES(1178, 'Karel', '?ernohorský ','M', '63',  16000, 1, '30/10/2007');
INSERT INTO person VALUES(1179, 'Zdenka', 'Dobešová','F', '29',  36000, 1, '12.3.2013');
INSERT INTO person VALUES(1180, 'Norbert', 'Šimánek ','M', '46',  22000, 1, '7/9/2003');
INSERT INTO person VALUES(1181, 'Pavla', 'Formánková','F', '61',  43000, 1, '6.1.2010');
INSERT INTO person VALUES(1182, 'Maxmilián', 'Doležal ','M', '22',  31000, 1, '8/2/2015');
INSERT INTO person VALUES(1183, 'Daniela', 'Nešporová','F', '22',  23000, 1, '20.7.2015');
INSERT INTO person VALUES(1184, 'Dan', 'Nguyen ','M', '51',  36000, 1, '17/12/2010');
INSERT INTO person VALUES(1185, 'Zdenka', 'Látalová','F', '54',  31000, 1, '15.5.2012');
INSERT INTO person VALUES(1186, 'Vasil', 'Zelený ','M', '27',  45000, 1, '24/12/2005');
INSERT INTO person VALUES(1187, 'Vlastimila', 'Kohoutová','F', '62',  18000, 2, '17.7.2019');
INSERT INTO person VALUES(1188, 'Radomil', 'Fousek ','M', '55',  14000, 2, '27/4/2005');
INSERT INTO person VALUES(1189, 'Emília', 'Jiroušková','F', '23',  34000, 2, '3.9.2008');
INSERT INTO person VALUES(1190, 'Bohumír', 'Remeš ','M', '38',  19000, 2, '29/7/2017');
INSERT INTO person VALUES(1191, 'Ingrid', 'Karlová','F', '55',  42000, 2, '30.6.2005');
INSERT INTO person VALUES(1192, 'Gustav', 'Klimeš ','M', '61',  28000, 2, '5/8/2012');
INSERT INTO person VALUES(1193, 'Na?a', 'Havránková','F', '62',  22000, 2, '11.1.2011');
INSERT INTO person VALUES(1194, 'Eduard', 'Burda ','M', '44',  34000, 2, '14/6/2008');
INSERT INTO person VALUES(1195, 'Patricie', 'Bauerová','F', '47',  29000, 1, '7.11.2007');
INSERT INTO person VALUES(1196, 'Juraj', 'Zach ','M', '20',  43000, 1, '22/6/2003');
INSERT INTO person VALUES(1197, 'Radomíra', 'Rousová','F', '55',  45000, 2, '20.5.2013');
INSERT INTO person VALUES(1198, 'Dominik', 'Junek ','M', '49',  12000, 2, '24/9/2015');
INSERT INTO person VALUES(1199, 'Oksana', 'Karbanová','F', '40',  17000, 1, '16.3.2010');
INSERT INTO person VALUES(1200, 'Marian', 'Žemli?ka ','M', '25',  21000, 1, '1/10/2010');
INSERT INTO person VALUES(1201, 'Natalie', 'Kleinová','F', '48',  33000, 2, '27.9.2015');
INSERT INTO person VALUES(1202, 'Marek', 'Moudrý ','M', '54',  26000, 2, '10/8/2006');
INSERT INTO person VALUES(1203, 'Miriam', 'Barešová','F', '33',  40000, 1, '22.7.2012');
INSERT INTO person VALUES(1204, 'Štefan', 'Ková? ','M', '30',  36000, 1, '10/1/2018');
INSERT INTO person VALUES(1205, 'Hana', 'Sv?tlíková','F', '40',  20000, 2, '2.2.2018');
INSERT INTO person VALUES(1206, 'Pavel', 'Zají?ek ','M', '59',  41000, 2, '18/11/2013');
INSERT INTO person VALUES(1207, 'Zita', 'Ko?ková','F', '26',  28000, 1, '29.11.2014');
INSERT INTO person VALUES(1208, 'Bohumil', 'Synek ','M', '36',  14000, 1, '26/11/2008');
INSERT INTO person VALUES(1209, 'Dominika', 'Zají?ková','F', '34',  16000, 2, '7.9.2005');
INSERT INTO person VALUES(1210, 'Jakub', 'Šilhavý ','M', '64',  19000, 2, '29/3/2008');
INSERT INTO person VALUES(1211, 'Leona', 'Šimánková','F', '41',  31000, 2, '21.3.2011');
INSERT INTO person VALUES(1212, 'J?lius', 'Král ','M', '47',  24000, 2, '5/2/2004');
INSERT INTO person VALUES(1213, 'Hedvika', 'Vydrová','F', '27',  39000, 2, '15.1.2008');
INSERT INTO person VALUES(1214, 'Svatoslav', 'Lukáš ','M', '23',  33000, 2, '9/7/2015');
INSERT INTO person VALUES(1215, 'Vladislava', 'K?enková','F', '34',  19000, 2, '28.7.2013');
INSERT INTO person VALUES(1216, 'Leo', 'Janí?ek ','M', '52',  38000, 2, '17/5/2011');
INSERT INTO person VALUES(1217, 'Leona', 'Gáborová','F', '20',  27000, 2, '23.5.2010');
INSERT INTO person VALUES(1218, 'Stepan', 'Orság ','M', '28',  12000, 2, '24/5/2006');
INSERT INTO person VALUES(1219, 'Elena', 'Tancošová','F', '27',  42000, 2, '4.12.2015');
INSERT INTO person VALUES(1220, 'Mikuláš', 'Mlejnek ','M', '57',  17000, 2, '26/8/2018');
INSERT INTO person VALUES(1221, 'Dita', 'Kocmanová','F', '58',  14000, 1, '29.9.2012');
INSERT INTO person VALUES(1222, 'Sebastian', 'Mazánek ','M', '33',  26000, 1, '2/9/2013');
INSERT INTO person VALUES(1223, 'Jaroslava', 'Ptá?ková','F', '21',  38000, 3, '9.7.2003');
INSERT INTO person VALUES(1224, 'Emanuel', 'Zima ','M', '62',  31000, 3, '3/1/2013');
INSERT INTO person VALUES(1225, 'Elena', 'M?llerová','F', '51',  37000, 1, '6.2.2015');
INSERT INTO person VALUES(1226, 'Nikolas', 'Mare?ek ','M', '39',  40000, 1, '19/7/2004');
INSERT INTO person VALUES(1227, 'Ji?ina', 'Berkyová','F', '60',  25000, 2, '15.11.2005');
INSERT INTO person VALUES(1228, '?estmír', 'Píša ','M', '21',  45000, 2, '20/11/2003');
INSERT INTO person VALUES(1229, 'Michala', 'Šimková','F', '44',  25000, 1, '15.6.2017');
INSERT INTO person VALUES(1230, 'Andrej', 'Skácel ','M', '44',  19000, 1, '29/10/2011');
INSERT INTO person VALUES(1231, 'Libuše', 'Šubrtová','F', '52',  13000, 2, '23.3.2008');
INSERT INTO person VALUES(1232, 'Arnošt', 'Machá?ek ','M', '26',  24000, 2, '1/3/2011');
INSERT INTO person VALUES(1233, 'Radka', 'Ž?rková','F', '60',  29000, 3, '4.10.2013');
INSERT INTO person VALUES(1234, 'Libor', 'Kubík ','M', '55',  29000, 3, '8/1/2007');
INSERT INTO person VALUES(1235, 'Iveta', 'Jur?íková','F', '45',  36000, 2, '31.7.2010');
INSERT INTO person VALUES(1236, 'Marcel', 'Van??ek ','M', '31',  38000, 2, '10/6/2018');
INSERT INTO person VALUES(1237, 'Ilona', 'Zachová','F', '52',  16000, 3, '11.2.2016');
INSERT INTO person VALUES(1238, 'Karel', 'Pr?cha ','M', '60',  43000, 3, '18/4/2014');
INSERT INTO person VALUES(1239, 'Adéla', 'Slabá','F', '38',  24000, 2, '7.12.2012');
INSERT INTO person VALUES(1240, 'Rostislav', 'Jan? ','M', '37',  16000, 2, '26/4/2009');
INSERT INTO person VALUES(1241, 'Andrea', 'Chovancová','F', '23',  31000, 1, '3.10.2009');
INSERT INTO person VALUES(1242, 'Bohumír', 'Kotrba ','M', '59',  26000, 1, '3/5/2004');
INSERT INTO person VALUES(1243, 'Aneta', 'Králí?ková','F', '31',  47000, 2, '16.4.2015');
INSERT INTO person VALUES(1244, 'Jaromír', 'Dušek ','M', '42',  31000, 2, '4/8/2016');
INSERT INTO person VALUES(1245, 'Dáša', 'Formánková','F', '39',  35000, 3, '23.1.2006');
INSERT INTO person VALUES(1246, 'Martin', 'Hr?za ','M', '24',  36000, 3, '7/12/2015');
INSERT INTO person VALUES(1247, 'Drahomíra', 'Junková','F', '23',  35000, 2, '22.8.2017');
INSERT INTO person VALUES(1248, 'Miroslav', 'Votava ','M', '47',  45000, 2, '21/6/2007');
INSERT INTO person VALUES(1249, 'Aloisie', 'Látalová','F', '32',  23000, 3, '31.5.2008');
INSERT INTO person VALUES(1250, 'Artur', 'Srb ','M', '29',  14000, 3, '22/10/2006');
INSERT INTO person VALUES(1251, 'Ladislava', 'Zapletalová','F', '62',  22000, 1, '6.8.2003');
INSERT INTO person VALUES(1252, 'Zbyšek', 'Pernica ','M', '52',  24000, 1, '30/9/2014');
INSERT INTO person VALUES(1253, 'Hanna', 'Matulová','F', '25',  46000, 3, '8.10.2010');
INSERT INTO person VALUES(1254, 'Walter', 'Šebesta ','M', '34',  28000, 3, '31/1/2014');
INSERT INTO person VALUES(1255, 'Sylvie', 'Prchalová','F', '56',  18000, 2, '4.8.2007');
INSERT INTO person VALUES(1256, 'Petr', 'Mužík ','M', '57',  38000, 2, '7/2/2009');
INSERT INTO person VALUES(1257, 'Radana', 'Winklerová','F', '63',  33000, 2, '14.2.2013');
INSERT INTO person VALUES(1258, 'Petro', 'Zikmund ','M', '40',  43000, 2, '17/12/2004');
INSERT INTO person VALUES(1259, 'Hanna', 'Košková','F', '49',  41000, 2, '10.12.2009');
INSERT INTO person VALUES(1260, 'Vladimir', 'Kalivoda ','M', '62',  16000, 2, '19/5/2016');
INSERT INTO person VALUES(1261, 'So?a', 'Barto?ová','F', '57',  29000, 3, '11.2.2017');
INSERT INTO person VALUES(1262, 'Juliús', '?ejka ','M', '44',  21000, 3, '20/9/2015');
INSERT INTO person VALUES(1263, 'Nicole', 'Šindlerová','F', '41',  29000, 2, '18.4.2012');
INSERT INTO person VALUES(1264, 'J?lius', 'Hanák ','M', '21',  30000, 2, '5/4/2007');
INSERT INTO person VALUES(1265, 'Alžb?ta', 'R?žková','F', '50',  16000, 3, '21.6.2019');
INSERT INTO person VALUES(1266, 'Viliam', 'Dolejší ','M', '49',  35000, 3, '6/8/2006');
INSERT INTO person VALUES(1267, 'Nela', 'Barešová','F', '57',  32000, 3, '8.8.2008');
INSERT INTO person VALUES(1268, 'Vilém', 'Stárek ','M', '32',  40000, 3, '8/11/2018');
INSERT INTO person VALUES(1269, 'Julie', 'Vaculíková','F', '43',  40000, 2, '4.6.2005');
INSERT INTO person VALUES(1270, 'Matouš', 'Pilát ','M', '54',  14000, 2, '15/11/2013');
INSERT INTO person VALUES(1271, 'Alžb?ta', 'Janí?ková','F', '28',  12000, 2, '24.8.2018');
INSERT INTO person VALUES(1272, 'Hubert', 'Švarc ','M', '31',  23000, 2, '22/11/2008');
INSERT INTO person VALUES(1273, 'Erika', 'Riedlová','F', '35',  27000, 2, '12.10.2007');
INSERT INTO person VALUES(1274, 'Hynek', 'Bauer ','M', '60',  28000, 2, '1/10/2004');
INSERT INTO person VALUES(1275, 'Sabina', 'Levá','F', '21',  35000, 2, '6.8.2004');
INSERT INTO person VALUES(1276, 'Ferdinand', 'Oláh ','M', '36',  37000, 2, '3/3/2016');
INSERT INTO person VALUES(1277, 'Terezie', 'Jansová','F', '28',  15000, 2, '17.2.2010');
INSERT INTO person VALUES(1278, 'Otakar', 'Berger ','M', '19',  42000, 2, '11/1/2012');
INSERT INTO person VALUES(1279, 'V?ra', 'Kupcová','F', '37',  39000, 3, '21.4.2017');
INSERT INTO person VALUES(1280, 'Lud?k', 'Janda ','M', '47',  47000, 3, '14/5/2011');
INSERT INTO person VALUES(1281, 'Svatava', 'Š astná','F', '21',  38000, 2, '26.6.2012');
INSERT INTO person VALUES(1282, 'Vladislav', 'Kolman ','M', '24',  21000, 2, '21/4/2019');
INSERT INTO person VALUES(1283, 'Zde?ka', 'Bo?ková','F', '29',  26000, 3, '29.8.2019');
INSERT INTO person VALUES(1284, 'Ivan', 'Antoš ','M', '52',  26000, 3, '23/8/2018');
INSERT INTO person VALUES(1285, 'Hana', 'Pelikánová','F', '61',  34000, 2, '24.6.2016');
INSERT INTO person VALUES(1286, 'Ludvík', 'Doubrava ','M', '29',  35000, 2, '30/8/2013');
INSERT INTO person VALUES(1287, 'Vlasta', 'Kolmanová','F', '22',  14000, 3, '12.8.2005');
INSERT INTO person VALUES(1288, 'Zden?k', 'Rozsypal ','M', '58',  40000, 3, '8/7/2009');
INSERT INTO person VALUES(1289, 'Martina', 'Farkašová','F', '54',  21000, 2, '31.10.2018');
INSERT INTO person VALUES(1290, 'Richard', 'Otáhal ','M', '34',  13000, 2, '16/7/2004');
INSERT INTO person VALUES(1291, 'Eliška', 'Krej?íková','F', '61',  37000, 3, '19.12.2007');
INSERT INTO person VALUES(1292, 'V?roslav', 'Valenta ','M', '63',  18000, 3, '17/10/2016');
INSERT INTO person VALUES(1293, 'Zuzana', 'Schwarzová','F', '46',  45000, 2, '14.10.2004');
INSERT INTO person VALUES(1294, 'Miloslav', 'Bo?ek ','M', '39',  28000, 2, '25/10/2011');
INSERT INTO person VALUES(1295, 'Zdenka', 'Marková','F', '54',  25000, 3, '27.4.2010');
INSERT INTO person VALUES(1296, 'Alan', '?onka ','M', '22',  33000, 3, '3/9/2007');
INSERT INTO person VALUES(1297, 'Pavla', 'Vobo?ilová','F', '39',  32000, 2, '21.2.2007');
INSERT INTO person VALUES(1298, 'Martin', 'Hor?ák ','M', '44',  42000, 2, '3/2/2019');
INSERT INTO person VALUES(1299, 'Ivanka', 'Mare?ková','F', '48',  20000, 3, '25.4.2014');
INSERT INTO person VALUES(1300, 'Rastislav', '?ervenka ','M', '26',  47000, 3, '7/6/2018');
INSERT INTO person VALUES(1301, 'Ingrid', 'Kubalová','F', '55',  36000, 4, '6.11.2019');
INSERT INTO person VALUES(1302, 'Ota', 'Hole?ek ','M', '55',  16000, 4, '15/4/2014');
INSERT INTO person VALUES(1303, 'Vlastimila', 'Špi?ková','F', '40',  43000, 3, '31.8.2016');
INSERT INTO person VALUES(1304, 'Ervín', 'Vybíral ','M', '32',  25000, 3, '22/4/2009');
INSERT INTO person VALUES(1305, 'Patricie', 'Zbo?ilová','F', '48',  23000, 3, '19.10.2005');
INSERT INTO person VALUES(1306, 'Vlastislav', 'Hrbek ','M', '61',  30000, 3, '1/3/2005');
INSERT INTO person VALUES(1307, 'Žofie', 'Hašková','F', '33',  31000, 3, '8.1.2019');
INSERT INTO person VALUES(1308, 'Gabriel', 'Kliment ','M', '37',  40000, 3, '1/8/2016');
INSERT INTO person VALUES(1309, 'Na?a', 'Bradová','F', '40',  47000, 3, '26.2.2008');
INSERT INTO person VALUES(1310, 'Radovan', 'Pracha? ','M', '20',  45000, 3, '10/6/2012');
INSERT INTO person VALUES(1311, 'Patricie', 'K?e?ková','F', '26',  18000, 3, '22.12.2004');
INSERT INTO person VALUES(1312, 'Drahomír', 'Richter ','M', '42',  18000, 3, '18/6/2007');
INSERT INTO person VALUES(1313, 'Miriam', 'Bobková','F', '33',  34000, 3, '5.7.2010');
INSERT INTO person VALUES(1314, 'Jozef', 'Nová?ek ','M', '25',  23000, 3, '19/9/2019');
INSERT INTO person VALUES(1315, 'Oksana', 'Mertová','F', '64',  42000, 2, '1.5.2007');
INSERT INTO person VALUES(1316, 'Alexander 4 000', 'Krej?ík ','M', '47',  32000, 2, '27/9/2014');
INSERT INTO person VALUES(1317, 'Ilona', 'Šašková','F', '27',  30000, 3, '3.7.2014');
INSERT INTO person VALUES(1318, 'Šimon', 'Vinš ','M', '29',  37000, 3, '28/1/2014');
INSERT INTO person VALUES(1319, 'Miriam', 'N?me?ková','F', '57',  29000, 2, '6.9.2009');
INSERT INTO person VALUES(1320, 'B?etislav', 'Vav?ík ','M', '53',  47000, 2, '12/8/2005');
INSERT INTO person VALUES(1321, 'Jind?iška', 'Hynková','F', '20',  17000, 3, '8.11.2016');
INSERT INTO person VALUES(1322, 'Vit', 'Uhlí? ','M', '35',  16000, 3, '14/12/2004');
INSERT INTO person VALUES(1323, 'Hedvika', 'Košková','F', '27',  33000, 4, '27.12.2005');
INSERT INTO person VALUES(1324, 'Zd?nek', 'Vít ','M', '64',  21000, 4, '17/3/2017');
INSERT INTO person VALUES(1325, 'Magdalena', 'Motlová','F', '58',  41000, 3, '18.3.2019');
INSERT INTO person VALUES(1326, 'Rudolf', 'Smola ','M', '40',  30000, 3, '24/3/2012');
INSERT INTO person VALUES(1327, 'Danuše', 'Švestková','F', '44',  12000, 2, '12.1.2016');
INSERT INTO person VALUES(1328, 'Dalibor', 'Nešpor ','M', '62',  39000, 2, '2/4/2007');
INSERT INTO person VALUES(1329, 'Hedvika', 'Vojt?chová','F', '51',  28000, 3, '1.3.2005');
INSERT INTO person VALUES(1330, 'Milan', 'Kuchta ','M', '45',  44000, 3, '4/7/2019');
INSERT INTO person VALUES(1331, 'Magdalena', 'Kvasni?ková','F', '37',  36000, 2, '20.5.2018');
INSERT INTO person VALUES(1332, 'Lud?k', 'Charvát ','M', '22',  18000, 2, '11/7/2014');
INSERT INTO person VALUES(1333, 'Zd?nka', 'Menclová','F', '45',  24000, 3, '26.2.2009');
INSERT INTO person VALUES(1334, 'Jaromír', 'Hartman ','M', '50',  22000, 3, '12/11/2013');
INSERT INTO person VALUES(1335, 'Marie', 'Langová','F', '52',  39000, 4, '9.9.2014');
INSERT INTO person VALUES(1336, 'Ctibor', 'Šimá?ek ','M', '33',  28000, 4, '20/9/2009');
INSERT INTO person VALUES(1337, 'Zora', 'Kubová','F', '38',  47000, 3, '6.7.2011');
INSERT INTO person VALUES(1338, 'Tomáš', 'Tancoš ','M', '55',  37000, 3, '28/9/2004');
INSERT INTO person VALUES(1339, 'Hanna', 'Ne?asová','F', '23',  19000, 3, '1.5.2008');
INSERT INTO person VALUES(1340, 'Dominik', 'Doležel ','M', '31',  46000, 3, '29/2/2016');
INSERT INTO person VALUES(1341, 'Iryna', 'Seifertová','F', '31',  35000, 3, '12.11.2013');
INSERT INTO person VALUES(1342, 'Boleslav', 'Kozel ','M', '60',  15000, 3, '7/1/2012');
INSERT INTO person VALUES(1343, 'Radana', 'Kynclová','F', '62',  42000, 2, '8.9.2010');
INSERT INTO person VALUES(1344, 'Marek', 'Bouška ','M', '36',  24000, 2, '15/1/2007');
INSERT INTO person VALUES(1345, 'Petra', 'Víchová','F', '23',  22000, 3, '21.3.2016');
INSERT INTO person VALUES(1346, 'Mario', 'Zouhar ','M', '19',  30000, 3, '18/4/2019');
INSERT INTO person VALUES(1347, 'Václava', 'Šimá?ková','F', '32',  46000, 4, '28.12.2006');
INSERT INTO person VALUES(1348, 'Petro', 'Straka ','M', '47',  34000, 4, '19/8/2018');
INSERT INTO person VALUES(1349, 'Ivana', 'Horáková','F', '62',  45000, 3, '28.7.2018');
INSERT INTO person VALUES(1350, 'Kristián', 'Vícha ','M', '25',  44000, 3, '4/3/2010');
INSERT INTO person VALUES(1351, 'Linda', 'Melicharová','F', '25',  33000, 4, '6.5.2009');
INSERT INTO person VALUES(1352, 'Boris', 'Dudek ','M', '53',  13000, 4, '5/7/2009');
INSERT INTO person VALUES(1353, 'Nela', 'Bartáková','F', '56',  41000, 3, '2.3.2006');
INSERT INTO person VALUES(1354, 'J?lius', 'Peroutka ','M', '29',  22000, 3, '12/7/2004');
INSERT INTO person VALUES(1355, 'Sylva', 'Krají?ková','F', '63',  21000, 4, '13.9.2011');
INSERT INTO person VALUES(1356, 'Lumír', 'Hroch ','M', '58',  27000, 4, '14/10/2016');
INSERT INTO person VALUES(1357, 'Linda', 'Žemli?ková','F', '49',  28000, 3, '9.7.2008');
INSERT INTO person VALUES(1358, 'Leo', 'Kone?ný ','M', '34',  36000, 3, '22/10/2011');
INSERT INTO person VALUES(1359, 'Maria', 'Zimová','F', '56',  44000, 4, '20.1.2014');
INSERT INTO person VALUES(1360, 'Matyáš', 'Pavlí?ek ','M', '63',  42000, 4, '31/8/2007');
INSERT INTO person VALUES(1361, 'Darina', 'Homolová','F', '41',  16000, 3, '15.11.2010');
INSERT INTO person VALUES(1362, 'Mikuláš', 'Hude?ek ','M', '40',  15000, 3, '31/1/2019');
INSERT INTO person VALUES(1363, 'Karolina', 'Ji?í?ková','F', '49',  32000, 3, '28.5.2016');
INSERT INTO person VALUES(1364, 'Kamil', 'Klement ','M', '22',  20000, 3, '9/12/2014');
INSERT INTO person VALUES(1365, 'Maria', 'Fejfarová','F', '34',  39000, 3, '24.3.2013');
INSERT INTO person VALUES(1366, 'Bronislav', 'Mayer ','M', '45',  29000, 3, '17/12/2009');
INSERT INTO person VALUES(1367, 'Valerie', 'Hendrychová','F', '42',  19000, 3, '5.10.2018');
INSERT INTO person VALUES(1368, 'Miloš', '?ehá?ek ','M', '28',  34000, 3, '25/10/2005');
INSERT INTO person VALUES(1369, 'Renata', 'Holasová','F', '50',  43000, 4, '14.7.2009');
INSERT INTO person VALUES(1370, 'Lukáš', 'Baláž ','M', '56',  39000, 4, '25/2/2005');
INSERT INTO person VALUES(1371, 'Eliška', 'Vav?íková','F', '35',  15000, 4, '10.5.2006');
INSERT INTO person VALUES(1372, 'Bohuslav', 'Sedlá? ','M', '32',  12000, 4, '29/7/2016');
INSERT INTO person VALUES(1373, 'Miluše', 'Husáková','F', '43',  31000, 4, '21.11.2011');
INSERT INTO person VALUES(1374, 'Kevin', 'Mi?ka ','M', '61',  18000, 4, '6/6/2012');
INSERT INTO person VALUES(1375, 'Klára', 'Nedv?dová','F', '28',  38000, 4, '15.9.2008');
INSERT INTO person VALUES(1376, 'Libor', 'Dunka ','M', '37',  27000, 4, '15/6/2007');
INSERT INTO person VALUES(1377, 'Nad?žda', 'Lexová','F', '35',  18000, 4, '29.3.2014');
INSERT INTO person VALUES(1378, 'Alfred', 'Michna ','M', '20',  32000, 4, '16/9/2019');
INSERT INTO person VALUES(1379, 'Daniela', 'Hrabovská','F', '21',  26000, 3, '23.1.2011');
INSERT INTO person VALUES(1380, 'Karel', 'Vá?a ','M', '43',  41000, 3, '23/9/2014');
INSERT INTO person VALUES(1381, 'Nina', 'Prokešová','F', '29',  13000, 4, '27.3.2018');
INSERT INTO person VALUES(1382, 'V?roslav', 'Pašek ','M', '25',  46000, 4, '25/1/2014');
INSERT INTO person VALUES(1383, 'Nad?žda', 'Pelcová','F', '60',  13000, 3, '1.6.2013');
INSERT INTO person VALUES(1384, 'Maxmilián', 'P?íhoda ','M', '48',  20000, 3, '9/8/2005');
INSERT INTO person VALUES(1385, 'Emília', 'Krej?í?ová','F', '22',  37000, 4, '10.3.2004');
INSERT INTO person VALUES(1386, 'Zoltán', 'Pluha? ','M', '30',  24000, 4, '10/12/2004');
INSERT INTO person VALUES(1387, 'Mária', '?Íhová','F', '52',  37000, 3, '9.10.2015');
INSERT INTO person VALUES(1388, 'Vasil', 'Hlávka ','M', '53',  34000, 3, '18/11/2012');
INSERT INTO person VALUES(1389, 'Olena', 'Šafránková','F', '61',  24000, 4, '18.7.2006');
INSERT INTO person VALUES(1390, 'Radomil', 'Balog ','M', '35',  39000, 4, '21/3/2012');
INSERT INTO person VALUES(1391, 'Tatiana', 'Švestková','F', '22',  40000, 1, '29.1.2012');
INSERT INTO person VALUES(1392, 'Alexandr', 'Nedv?d ','M', '64',  44000, 1, '29/1/2008');
INSERT INTO person VALUES(1393, 'Radomíra', 'Molnárová','F', '54',  12000, 4, '23.11.2008');
INSERT INTO person VALUES(1394, 'Gustav', '?eho? ','M', '40',  17000, 4, '1/7/2019');
INSERT INTO person VALUES(1395, 'V?ra', 'Kvasni?ková','F', '61',  28000, 4, '6.6.2014');
INSERT INTO person VALUES(1396, 'Eduard', '?ernohorský ','M', '23',  22000, 4, '9/5/2015');
INSERT INTO person VALUES(1397, 'Tatiana', 'Záme?níková','F', '46',  35000, 4, '2.4.2011');
INSERT INTO person VALUES(1398, 'Juraj', 'Svato? ','M', '46',  32000, 4, '17/5/2010');
INSERT INTO person VALUES(1399, 'Martina', 'Sta?ková','F', '54',  15000, 4, '13.10.2016');
INSERT INTO person VALUES(1400, 'Dominik', 'Doležal ','M', '29',  37000, 4, '25/3/2006');
INSERT INTO person VALUES(1401, 'Hana', 'Kolá?ová','F', '39',  23000, 4, '9.8.2013');
INSERT INTO person VALUES(1402, 'Marian', 'Berka ','M', '51',  46000, 4, '25/8/2017');
INSERT INTO person VALUES(1403, 'Kv?tuše', 'Ne?asová','F', '48',  47000, 1, '18.5.2004');
INSERT INTO person VALUES(1404, 'Zbyn?k', 'Hrubeš ','M', '33',  15000, 1, '27/12/2016');
INSERT INTO person VALUES(1405, 'Jitka', 'Stoklasová','F', '32',  46000, 3, '16.12.2015');
INSERT INTO person VALUES(1406, 'Štefan', 'Neubauer ','M', '56',  24000, 3, '11/7/2008');
INSERT INTO person VALUES(1407, 'Jolana', 'Kynclová','F', '40',  34000, 1, '24.9.2006');
INSERT INTO person VALUES(1408, 'Patrik', 'Beránek ','M', '38',  29000, 1, '13/11/2007');
INSERT INTO person VALUES(1409, 'Kv?tuše', 'Nedbalová','F', '26',  42000, 4, '21.7.2003');
INSERT INTO person VALUES(1410, 'Vilém', 'Sochor ','M', '61',  38000, 4, '15/4/2019');
INSERT INTO person VALUES(1411, 'Vladislava', 'Wolfová','F', '33',  22000, 4, '31.1.2009');
INSERT INTO person VALUES(1412, 'Stanislav', 'Vojta ','M', '43',  44000, 4, '21/2/2015');
INSERT INTO person VALUES(1413, 'Leona', 'Císa?ová','F', '19',  29000, 4, '27.11.2005');
INSERT INTO person VALUES(1414, 'Št?pán', 'Papež ','M', '20',  17000, 4, '1/3/2010');
INSERT INTO person VALUES(1415, 'Ivanka', 'Šilhavá','F', '26',  45000, 4, '10.6.2011');
INSERT INTO person VALUES(1416, 'Svatoslav', 'Kulhavý ','M', '49',  22000, 4, '7/1/2006');
INSERT INTO person VALUES(1417, 'Vladislava', 'Havrdová','F', '57',  17000, 4, '4.4.2008');
INSERT INTO person VALUES(1418, 'Vlastimil', 'R?ži?ka ','M', '25',  31000, 4, '9/6/2017');
INSERT INTO person VALUES(1419, 'Jindra', 'Pátková','F', '19',  32000, 4, '17.10.2013');
INSERT INTO person VALUES(1420, 'Stepan', 'Sedlák ','M', '54',  36000, 4, '18/4/2013');
INSERT INTO person VALUES(1421, 'Elena', 'Hrbková','F', '50',  40000, 3, '12.8.2010');
INSERT INTO person VALUES(1422, 'Vladimír', 'Vaculík ','M', '30',  46000, 3, '25/4/2008');
INSERT INTO person VALUES(1423, 'Ji?ina', 'Krištofová','F', '59',  28000, 1, '14.10.2017');
INSERT INTO person VALUES(1424, 'Nicolas', 'Syrový ','M', '58',  14000, 1, '27/8/2007');
INSERT INTO person VALUES(1425, 'Šárka', 'Homolová','F', '20',  44000, 1, '2.12.2006');
INSERT INTO person VALUES(1426, 'Emanuel', 'Maxa ','M', '41',  19000, 1, '6/7/2003');
INSERT INTO person VALUES(1427, 'Marta', 'Pila?ová','F', '51',  15000, 4, '28.9.2003');
INSERT INTO person VALUES(1428, 'Oskar', 'Šrámek ','M', '64',  29000, 4, '6/12/2014');
INSERT INTO person VALUES(1429, 'Simona', 'Fejfarová','F', '59',  31000, 1, '10.4.2009');
INSERT INTO person VALUES(1430, '?estmír', 'Kalina ','M', '47',  34000, 1, '15/10/2010');
INSERT INTO person VALUES(1431, 'Iveta', 'Stiborová','F', '44',  39000, 4, '4.2.2006');
INSERT INTO person VALUES(1432, '?ubomír', 'M?ller ','M', '23',  43000, 4, '22/10/2005');
INSERT INTO person VALUES(1433, 'Ilona', 'Zlámalová','F', '51',  19000, 1, '18.8.2011');
INSERT INTO person VALUES(1434, 'Arnošt', 'Merta ','M', '52',  12000, 1, '23/1/2018');
INSERT INTO person VALUES(1435, 'Radka', 'Dobiášová','F', '37',  26000, 4, '12.6.2008');
INSERT INTO person VALUES(1436, 'Ondrej', 'Hrdý ','M', '28',  22000, 4, '31/1/2013');
INSERT INTO person VALUES(1437, 'Katarína', 'Borovi?ková','F', '45',  14000, 1, '15.8.2015');
INSERT INTO person VALUES(1438, 'Mykola', 'Šimon ','M', '56',  26000, 1, '3/6/2012');
INSERT INTO person VALUES(1439, 'Aneta', 'Tomanová','F', '29',  14000, 4, '20.10.2010');
INSERT INTO person VALUES(1440, 'Pavol', 'Benda ','M', '33',  36000, 4, '18/12/2003');
INSERT INTO person VALUES(1441, 'Zlata', 'Šim?nková','F', '38',  38000, 1, '22.12.2017');
INSERT INTO person VALUES(1442, 'Bohumir', 'Pham ','M', '61',  41000, 1, '13/9/2019');
INSERT INTO person VALUES(1443, 'Danuše', 'Teplá','F', '22',  37000, 4, '26.2.2013');
INSERT INTO person VALUES(1444, 'Bohumír', 'Hladký ','M', '39',  14000, 4, '28/3/2011');
INSERT INTO person VALUES(1445, 'Aloisie', 'Vilímková','F', '31',  25000, 1, '6.12.2003');
INSERT INTO person VALUES(1446, 'Michael', 'Sv?tlík ','M', '21',  19000, 1, '30/7/2010');
INSERT INTO person VALUES(1447, 'Zora', 'Pelcová','F', '38',  41000, 1, '18.6.2009');
INSERT INTO person VALUES(1448, 'Martin', 'Marek ','M', '50',  24000, 1, '7/6/2006');
INSERT INTO person VALUES(1449, 'Zd?nka', 'Wagnerová','F', '23',  13000, 1, '13.4.2006');
INSERT INTO person VALUES(1450, 'Robert', 'Formánek ','M', '26',  34000, 1, '7/11/2017');
INSERT INTO person VALUES(1451, 'Aloisie', 'Švejdová','F', '55',  20000, 4, '3.7.2019');
INSERT INTO person VALUES(1452, 'Leoš', 'Kindl ','M', '48',  43000, 4, '15/11/2012');
INSERT INTO person VALUES(1453, 'Radana', 'Musilová','F', '62',  36000, 4, '20.8.2008');
INSERT INTO person VALUES(1454, 'Antonín', 'Macha? ','M', '31',  12000, 4, '23/9/2008');
INSERT INTO person VALUES(1455, 'Hanna', 'Sedlá?ková','F', '48',  44000, 4, '16.6.2005');
INSERT INTO person VALUES(1456, 'Jozef', 'Walter ','M', '54',  21000, 4, '1/10/2003');
INSERT INTO person VALUES(1457, 'Iryna', 'Jakešová','F', '55',  24000, 4, '28.12.2010');
INSERT INTO person VALUES(1458, 'Petr', 'Králí?ek ','M', '36',  26000, 4, '3/1/2016');
INSERT INTO person VALUES(1459, 'Antonie', 'Kopalová','F', '63',  47000, 1, '1.3.2018');
INSERT INTO person VALUES(1460, 'Herbert', 'Vondra ','M', '64',  31000, 1, '6/5/2015');
INSERT INTO person VALUES(1461, 'Petra', 'Polášková','F', '48',  47000, 4, '6.5.2013');
INSERT INTO person VALUES(1462, 'Vladimir', 'Ve?e?a ','M', '42',  41000, 4, '19/11/2006');
INSERT INTO person VALUES(1463, 'Nela', 'Gabrielová','F', '56',  35000, 1, '12.2.2004');
INSERT INTO person VALUES(1464, 'Juliús', 'Koní?ek ','M', '24',  45000, 1, '22/3/2006');
INSERT INTO person VALUES(1465, 'Julie', 'Ludvíková','F', '42',  43000, 1, '3.5.2017');
INSERT INTO person VALUES(1466, 'Zd?nek', 'Ku?era ','M', '46',  19000, 1, '22/8/2017');
INSERT INTO person VALUES(1467, 'Linda', 'Procházková','F', '49',  22000, 1, '21.6.2006');
INSERT INTO person VALUES(1468, 'Viliam', 'Vítek ','M', '29',  24000, 1, '1/7/2013');
INSERT INTO person VALUES(1469, 'Nela', 'Bubeníková','F', '34',  30000, 4, '10.9.2019');
INSERT INTO person VALUES(1470, 'Bruno', 'Kola?ík ','M', '51',  33000, 4, '8/7/2008');
INSERT INTO person VALUES(1471, 'Darina', 'Fenclová','F', '42',  46000, 1, '28.10.2008');
INSERT INTO person VALUES(1472, 'Matouš', 'Koubek ','M', '34',  38000, 1, '16/5/2004');
INSERT INTO person VALUES(1473, 'Terezie', 'Kloudová','F', '27',  17000, 4, '24.8.2005');
INSERT INTO person VALUES(1474, 'Hubert', 'Michalec ','M', '57',  12000, 4, '18/10/2015');
INSERT INTO person VALUES(1475, 'Maria', 'Vrbová','F', '34',  33000, 1, '7.3.2011');
INSERT INTO person VALUES(1476, 'Hynek', 'Pivo?ka ','M', '40',  17000, 1, '26/8/2011');
INSERT INTO person VALUES(1477, 'Darina', 'Pechová','F', '20',  41000, 4, '31.12.2007');
INSERT INTO person VALUES(1478, 'Ferdinand', 'Ka?írek ','M', '62',  26000, 4, '3/9/2006');
INSERT INTO person VALUES(1479, 'Jaromíra', 'Šandová','F', '27',  21000, 4, '13.7.2013');
INSERT INTO person VALUES(1480, 'Otakar', 'Šev?ík ','M', '45',  31000, 4, '5/12/2018');
INSERT INTO person VALUES(1481, 'R?žena', 'Havrdová','F', '36',  45000, 2, '21.4.2004');
INSERT INTO person VALUES(1482, 'Lud?k', 'Zlámal ','M', '27',  36000, 2, '7/4/2018');
INSERT INTO person VALUES(1483, 'Valerie', 'K?ížková','F', '20',  44000, 4, '20.11.2015');
INSERT INTO person VALUES(1484, 'Vladislav', 'Homolka ','M', '50',  46000, 4, '21/10/2009');
INSERT INTO person VALUES(1485, 'Klára', 'Hrbková','F', '28',  32000, 1, '29.8.2006');
INSERT INTO person VALUES(1486, 'Ivan', 'Mou?ka ','M', '32',  14000, 1, '21/2/2009');
INSERT INTO person VALUES(1487, 'Eliška', 'Pašková','F', '60',  40000, 1, '25.6.2003');
INSERT INTO person VALUES(1488, 'Ludvík', 'Hlavá?ek ','M', '54',  24000, 1, '29/2/2004');
INSERT INTO person VALUES(1489, 'Vlasta', 'Švábová','F', '45',  47000, 4, '12.9.2016');
INSERT INTO person VALUES(1490, 'Mojmír', 'Husák ','M', '31',  33000, 4, '2/8/2015');
INSERT INTO person VALUES(1491, 'Zdenka', 'Fišerová','F', '52',  27000, 1, '31.10.2005');
INSERT INTO person VALUES(1492, 'Richard', 'Maršálek ','M', '60',  38000, 1, '10/6/2011');
INSERT INTO person VALUES(1493, 'Karin', 'Zemánková','F', '61',  15000, 2, '2.1.2013');
INSERT INTO person VALUES(1494, 'Daniel', 'Macák ','M', '42',  43000, 2, '11/10/2010');
INSERT INTO person VALUES(1495, 'Daniela', 'Šlechtová','F', '45',  15000, 4, '9.3.2008');
INSERT INTO person VALUES(1496, 'Miloslav', 'Hejna ','M', '19',  16000, 4, '19/9/2018');
INSERT INTO person VALUES(1497, 'Ingrid', 'Dittrichová','F', '54',  38000, 2, '12.5.2015');
INSERT INTO person VALUES(1498, 'Pavel', 'Mare?ek ','M', '47',  21000, 2, '20/1/2018');
INSERT INTO person VALUES(1499, 'Anežka', 'Peterková','F', '38',  38000, 4, '17.7.2010');
INSERT INTO person VALUES(1500, 'Martin', 'Jedli?ka ','M', '24',  31000, 4, '5/8/2009');
INSERT INTO person VALUES(1501, 'Emília', 'Studená','F', '46',  26000, 1, '18.9.2017');
INSERT INTO person VALUES(1502, 'Rastislav', 'Petr? ','M', '52',  36000, 1, '6/12/2008');
INSERT INTO person VALUES(1503, 'Ingrid', 'Dubská','F', '32',  34000, 1, '15.7.2014');
INSERT INTO person VALUES(1504, 'Roman', 'Molnár ','M', '29',  45000, 1, '14/12/2003');
INSERT INTO person VALUES(1505, 'Na?a', 'Tichá','F', '39',  13000, 1, '2.9.2003');
INSERT INTO person VALUES(1506, 'Ervín', 'Stupka ','M', '57',  14000, 1, '17/3/2016');
INSERT INTO person VALUES(1507, 'Patricie', 'Vl?ková','F', '25',  21000, 1, '20.11.2016');
INSERT INTO person VALUES(1508, 'Ji?í', 'Sobotka ','M', '34',  23000, 1, '25/3/2011');
INSERT INTO person VALUES(1509, 'Radomíra', 'Rudolfová','F', '32',  37000, 1, '8.1.2006');
INSERT INTO person VALUES(1510, 'Gabriel', 'Jirásek ','M', '63',  28000, 1, '31/1/2007');
INSERT INTO person VALUES(1511, 'Na?a', 'Smolová','F', '63',  45000, 4, '30.3.2019');
INSERT INTO person VALUES(1512, 'Vojtech', 'Štefan ','M', '39',  38000, 4, '4/7/2018');
INSERT INTO person VALUES(1513, 'Natalie', 'Nosková','F', '25',  24000, 1, '17.5.2008');
INSERT INTO person VALUES(1514, 'Drahomír', 'Schejbal ','M', '22',  43000, 1, '12/5/2014');
INSERT INTO person VALUES(1515, 'Dominika', 'Švejdová','F', '33',  12000, 2, '20.7.2015');
INSERT INTO person VALUES(1516, 'Bronislav', 'Pavlík ','M', '50',  47000, 2, '13/9/2013');
INSERT INTO person VALUES(1517, 'Jind?iška', 'Kou?ilová','F', '19',  20000, 1, '15.5.2012');
INSERT INTO person VALUES(1518, 'Nikolas', 'Buchta ','M', '26',  21000, 1, '20/9/2008');
INSERT INTO person VALUES(1519, 'Kv?tuše', 'Sedlá?ková','F', '26',  36000, 2, '26.11.2017');
INSERT INTO person VALUES(1520, 'Šimon', 'Hynek ','M', '55',  26000, 2, '29/7/2004');
INSERT INTO person VALUES(1521, 'Dominika', 'Novotná','F', '57',  43000, 1, '21.9.2014');
INSERT INTO person VALUES(1522, 'Tibor', 'Ma?ák ','M', '32',  35000, 1, '31/12/2015');
INSERT INTO person VALUES(1523, 'Leona', 'Holcová','F', '19',  23000, 2, '9.11.2003');
INSERT INTO person VALUES(1524, 'Vit', 'Pernica ','M', '61',  40000, 2, '8/11/2011');
INSERT INTO person VALUES(1525, 'Hedvika', 'Sk?ivánková','F', '50',  31000, 1, '28.1.2017');
INSERT INTO person VALUES(1526, 'Denis', 'Sobek ','M', '37',  14000, 1, '15/11/2006');
INSERT INTO person VALUES(1527, 'Vladislava', 'Linhartová','F', '57',  47000, 1, '18.3.2006');
INSERT INTO person VALUES(1528, 'Rudolf', 'Š astný ','M', '20',  19000, 1, '17/2/2019');
INSERT INTO person VALUES(1529, 'Leona', '?ervenková','F', '43',  18000, 1, '7.6.2019');
INSERT INTO person VALUES(1530, 'Dalibor', 'Jonáš ','M', '42',  28000, 1, '24/2/2014');
INSERT INTO person VALUES(1531, 'Elena', 'Kalousková','F', '50',  34000, 1, '25.7.2008');
INSERT INTO person VALUES(1532, 'Michal', 'Šesták ','M', '25',  33000, 1, '3/1/2010');
INSERT INTO person VALUES(1533, 'Zora', 'Schneiderová','F', '37',  14000, 1, '9.1.2007');
INSERT INTO person VALUES(1534, 'Alexandr', 'Bláha ','M', '46',  42000, 1, '5/7/2008');
INSERT INTO person VALUES(1535, 'Jaroslava', 'Nývltová','F', '44',  30000, 2, '22.7.2012');
INSERT INTO person VALUES(1536, 'Jaromír', 'Kova?ík ','M', '29',  47000, 2, '13/5/2004');
INSERT INTO person VALUES(1537, 'Iryna', 'Kavanová','F', '29',  37000, 1, '18.5.2009');
INSERT INTO person VALUES(1538, 'Eduard', 'Homolka ','M', '52',  20000, 1, '14/10/2015');
INSERT INTO person VALUES(1539, 'Ji?ina', 'Šišková','F', '37',  17000, 2, '29.11.2014');
INSERT INTO person VALUES(1540, 'Tomáš', 'Pospíchal ','M', '35',  26000, 2, '23/8/2011');
INSERT INTO person VALUES(1541, 'Lucie', 'Gajdošová','F', '22',  25000, 1, '25.9.2011');
INSERT INTO person VALUES(1542, 'Dominik', 'Le ','M', '57',  35000, 1, '30/8/2006');
INSERT INTO person VALUES(1543, 'Marta', 'Havlová','F', '29',  40000, 1, '7.4.2017');
INSERT INTO person VALUES(1544, 'Boleslav', 'Kubiš ','M', '40',  40000, 1, '2/12/2018');
INSERT INTO person VALUES(1545, 'Ivana', 'Müllerová','F', '61',  12000, 1, '1.2.2014');
INSERT INTO person VALUES(1546, 'Marek', 'Holub ','M', '62',  13000, 1, '9/12/2013');
INSERT INTO person VALUES(1547, 'Magda', 'Hude?ková','F', '23',  36000, 2, '10.11.2004');
INSERT INTO person VALUES(1548, 'Josef', 'Balcar ','M', '44',  18000, 2, '11/4/2013');
INSERT INTO person VALUES(1549, 'Sv?tlana', 'Cinová','F', '31',  16000, 2, '24.5.2010');
INSERT INTO person VALUES(1550, 'Petro', 'Janá?ek ','M', '27',  23000, 2, '18/2/2009');
INSERT INTO person VALUES(1551, 'Sylva', 'Grygarová','F', '62',  23000, 2, '19.3.2007');
INSERT INTO person VALUES(1552, 'Vladimir', 'Rác ','M', '50',  32000, 2, '26/2/2004');
INSERT INTO person VALUES(1553, 'Katarína', 'Švábová','F', '23',  39000, 2, '29.9.2012');
INSERT INTO person VALUES(1554, 'Boris', 'Kolman ','M', '32',  37000, 2, '30/5/2016');
INSERT INTO person VALUES(1555, 'Sv?tlana', 'Bedna?íková','F', '55',  47000, 2, '26.7.2009');
INSERT INTO person VALUES(1556, 'J?lius', '?apek ','M', '55',  47000, 2, '7/6/2011');
INSERT INTO person VALUES(1557, 'Dáša', 'Hrubá','F', '62',  27000, 2, '6.2.2015');
INSERT INTO person VALUES(1558, 'Lumír', 'Chalupa ','M', '38',  16000, 2, '15/4/2007');
INSERT INTO person VALUES(1559, 'Karolina', 'Valentová','F', '48',  34000, 1, '3.12.2011');
INSERT INTO person VALUES(1560, 'Leo', 'Hašek ','M', '60',  25000, 1, '16/9/2018');
INSERT INTO person VALUES(1561, 'Olga', 'Malinová','F', '56',  22000, 3, '4.2.2019');
INSERT INTO person VALUES(1562, 'Slavomír', 'H?lka ','M', '42',  30000, 3, '17/1/2018');
INSERT INTO person VALUES(1563, 'Dáša', '?adová','F', '40',  22000, 1, '10.4.2014');
INSERT INTO person VALUES(1564, 'Mikuláš', 'Pavl? ','M', '19',  40000, 1, '1/8/2009');
INSERT INTO person VALUES(1565, 'Renata', 'Moudrá','F', '49',  46000, 2, '17.1.2005');
INSERT INTO person VALUES(1566, 'Hynek', 'Popelka ','M', '47',  44000, 2, '3/12/2008');
INSERT INTO person VALUES(1567, 'R?žena', 'Lavi?ková','F', '34',  17000, 2, '8.4.2018');
INSERT INTO person VALUES(1568, 'Emanuel', 'Schejbal ','M', '24',  17000, 2, '11/12/2003');
INSERT INTO person VALUES(1569, 'Miluše', 'Mužíková','F', '42',  33000, 2, '27.5.2007');
INSERT INTO person VALUES(1570, 'Otakar', 'Hor?ák ','M', '53',  23000, 2, '13/3/2016');
INSERT INTO person VALUES(1571, 'Klára', 'Valešová','F', '27',  41000, 2, '22.3.2004');
INSERT INTO person VALUES(1572, '?estmír', 'Hána ','M', '29',  32000, 2, '22/3/2011');
INSERT INTO person VALUES(1573, 'So?a', 'R?ži?ková','F', '34',  21000, 2, '3.10.2009');
INSERT INTO person VALUES(1574, 'Bohuslav', 'Kalaš ','M', '58',  37000, 2, '28/1/2007');
INSERT INTO person VALUES(1575, 'Miluše', 'Jíchová','F', '20',  28000, 1, '30.7.2006');
INSERT INTO person VALUES(1576, 'Arnošt', 'Václavík ','M', '34',  46000, 1, '30/6/2018');
INSERT INTO person VALUES(1577, 'Alžb?ta', 'Schejbalová','F', '27',  44000, 2, '10.2.2012');
INSERT INTO person VALUES(1578, 'Libor', 'Koš ál ','M', '63',  16000, 2, '9/5/2014');
INSERT INTO person VALUES(1579, 'Nad?žda', 'Pecková','F', '59',  16000, 1, '5.12.2008');
INSERT INTO person VALUES(1580, 'Marcel', 'Nagy ','M', '39',  25000, 1, '16/5/2009');
INSERT INTO person VALUES(1581, 'Danuška', 'Frydrychová','F', '21',  40000, 2, '7.2.2016');
INSERT INTO person VALUES(1582, 'Ivo', 'Š astný ','M', '21',  29000, 2, '16/9/2008');
INSERT INTO person VALUES(1583, 'Ingrid', 'Rousová','F', '52',  47000, 2, '3.12.2012');
INSERT INTO person VALUES(1584, 'Bohumir', 'Jonáš ','M', '44',  39000, 2, '25/9/2003');
INSERT INTO person VALUES(1585, 'Olena', 'Vojtová','F', '60',  27000, 2, '16.6.2018');
INSERT INTO person VALUES(1586, 'Miloslav', 'Šesták ','M', '27',  44000, 2, '27/12/2015');
INSERT INTO person VALUES(1587, 'Emília', 'Kleinová','F', '45',  35000, 2, '12.4.2015');
INSERT INTO person VALUES(1588, 'Michael', 'Klouda ','M', '49',  17000, 2, '4/1/2011');
INSERT INTO person VALUES(1589, 'Zlatuše', 'Danišová','F', '53',  15000, 2, '30.5.2004');
INSERT INTO person VALUES(1590, 'Martin', 'Mat?jí?ek ','M', '32',  22000, 2, '12/11/2006');
INSERT INTO person VALUES(1591, 'Na?a', 'Sv?tlíková','F', '38',  22000, 1, '18.8.2017');
INSERT INTO person VALUES(1592, 'Robert', 'Brázdil ','M', '54',  31000, 1, '14/4/2018');
INSERT INTO person VALUES(1593, 'Tatiana', 'Zítková','F', '45',  38000, 2, '6.10.2006');
INSERT INTO person VALUES(1594, 'Artur', 'Vl?ek ','M', '37',  37000, 2, '21/2/2014');
INSERT INTO person VALUES(1595, 'Blažena', 'Tomešová','F', '54',  26000, 3, '8.12.2013');
INSERT INTO person VALUES(1596, 'Gerhard', 'Vondrák ','M', '19',  41000, 3, '24/6/2013');
INSERT INTO person VALUES(1597, 'Hana', 'Kubí?ková','F', '38',  25000, 2, '12.2.2009');
INSERT INTO person VALUES(1598, 'Walter', 'Plachý ','M', '43',  15000, 2, '7/1/2005');
INSERT INTO person VALUES(1599, 'Alexandra', 'Sokolová','F', '46',  13000, 3, '16.4.2016');
INSERT INTO person VALUES(1600, 'Cyril', 'Nešpor ','M', '25',  20000, 3, '10/5/2004');
INSERT INTO person VALUES(1601, 'Blažena', 'K?enková','F', '32',  21000, 2, '10.2.2013');
INSERT INTO person VALUES(1602, 'Herbert', 'Šulc ','M', '47',  29000, 2, '11/10/2015');
INSERT INTO person VALUES(1603, 'Jolana', 'Svato?ová','F', '39',  37000, 3, '24.8.2018');
INSERT INTO person VALUES(1604, 'Drahomír', 'David ','M', '30',  34000, 3, '20/8/2011');
INSERT INTO person VALUES(1605, 'Kv?tuše', 'Kubánková','F', '25',  44000, 2, '19.6.2015');
INSERT INTO person VALUES(1606, 'Juliús', 'Záruba ','M', '52',  43000, 2, '27/8/2006');
INSERT INTO person VALUES(1607, 'Ta ána', 'Zíková','F', '32',  24000, 2, '6.8.2004');
INSERT INTO person VALUES(1608, 'Tadeáš', 'Kaplan ','M', '35',  13000, 2, '28/11/2018');
INSERT INTO person VALUES(1609, 'Jolana', 'Šafa?íková','F', '63',  32000, 2, '26.10.2017');
INSERT INTO person VALUES(1610, 'Viliam', 'Kaiser ','M', '57',  22000, 2, '6/12/2013');
INSERT INTO person VALUES(1611, 'Ivanka', 'Jandová','F', '25',  12000, 2, '14.12.2006');
INSERT INTO person VALUES(1612, 'Vilém', 'Fousek ','M', '40',  27000, 2, '14/10/2009');
INSERT INTO person VALUES(1613, 'Vladislava', 'Soukupová','F', '56',  19000, 2, '10.10.2003');
INSERT INTO person VALUES(1614, 'Matouš', 'Horá?ek ','M', '63',  36000, 2, '21/10/2004');
INSERT INTO person VALUES(1615, 'Vlastimila', 'Orságová','F', '63',  35000, 2, '22.4.2009');
INSERT INTO person VALUES(1616, 'Št?pán', 'B?ezina ','M', '46',  42000, 2, '23/1/2017');
INSERT INTO person VALUES(1617, 'Irena', 'Krupová','F', '26',  23000, 3, '24.6.2016');
INSERT INTO person VALUES(1618, 'Rudolf', 'Kope?ek ','M', '28',  46000, 3, '26/5/2016');
INSERT INTO person VALUES(1619, 'Monika', 'Ž?rková','F', '57',  31000, 3, '19.4.2013');
INSERT INTO person VALUES(1620, 'Radomír', 'Kameník ','M', '50',  19000, 3, '4/6/2011');
INSERT INTO person VALUES(1621, 'Pavlína', 'Cibulková','F', '19',  46000, 3, '31.10.2018');
INSERT INTO person VALUES(1622, 'Michal', 'Vícha ','M', '33',  25000, 3, '12/4/2007');
INSERT INTO person VALUES(1623, 'Marta', 'Zachová','F', '50',  18000, 2, '27.8.2015');
INSERT INTO person VALUES(1624, 'Lud?k', 'Ondrá?ek ','M', '55',  34000, 2, '12/9/2018');
INSERT INTO person VALUES(1625, 'Ji?ina', 'Maršálková','F', '36',  26000, 2, '22.6.2012');
INSERT INTO person VALUES(1626, 'Kryštof', 'Fridrich ','M', '32',  43000, 2, '20/9/2013');
INSERT INTO person VALUES(1627, 'Šárka', 'Králová','F', '43',  42000, 2, '3.1.2018');
INSERT INTO person VALUES(1628, 'Ivan', 'Michal ','M', '60',  12000, 2, '29/7/2009');
INSERT INTO person VALUES(1629, 'Diana', 'Dobešová','F', '51',  29000, 3, '12.10.2008');
INSERT INTO person VALUES(1630, 'František', 'Kone?ný ','M', '42',  17000, 3, '29/11/2008');
INSERT INTO person VALUES(1631, 'Viktorie', 'Formánková','F', '37',  37000, 3, '8.8.2005');
INSERT INTO person VALUES(1632, 'Radim', 'Koš ál ','M', '19',  26000, 3, '8/12/2003');
INSERT INTO person VALUES(1633, 'Vanda', 'Nešporová','F', '44',  17000, 3, '19.2.2011');
INSERT INTO person VALUES(1634, 'Ruslan', 'Šmejkal ','M', '48',  31000, 3, '10/3/2016');
INSERT INTO person VALUES(1635, 'Diana', 'Jiránková','F', '30',  25000, 3, '15.12.2007');
INSERT INTO person VALUES(1636, 'Daniel', 'Vo?íšek ','M', '24',  40000, 3, '18/3/2011');
INSERT INTO person VALUES(1637, 'Zlata', 'Šime?ková','F', '37',  40000, 3, '27.6.2013');
INSERT INTO person VALUES(1638, 'Mario', 'Mayer ','M', '53',  46000, 3, '25/1/2007');
INSERT INTO person VALUES(1639, 'Katarína', 'Matulová','F', '22',  12000, 2, '23.4.2010');
INSERT INTO person VALUES(1640, 'Pavel', 'Paul ','M', '29',  19000, 2, '27/6/2018');
INSERT INTO person VALUES(1641, 'Barbara', 'Lukášková','F', '30',  28000, 3, '4.11.2015');
INSERT INTO person VALUES(1642, 'Lubor', 'Navrátil ','M', '58',  24000, 3, '6/5/2014');
INSERT INTO person VALUES(1643, 'Marcela', 'Raková','F', '62',  44000, 3, '21.4.2014');
INSERT INTO person VALUES(1644, 'Stanislav', 'Mat?jí?ek ','M', '34',  33000, 3, '5/11/2012');
INSERT INTO person VALUES(1645, 'Nikola', 'Bauerová','F', '24',  23000, 3, '2.11.2019');
INSERT INTO person VALUES(1646, 'Oliver', 'Vav?ík ','M', '63',  38000, 3, '13/9/2008');
INSERT INTO person VALUES(1647, 'Olga', 'Barto?ová','F', '55',  31000, 3, '27.8.2016');
INSERT INTO person VALUES(1648, 'Po?et', 'Vl?ek ','M', '39',  47000, 3, '21/9/2003');
INSERT INTO person VALUES(1649, 'Denisa', 'Karbanová','F', '62',  47000, 3, '15.10.2005');
INSERT INTO person VALUES(1650, '?en?k', 'Kubí?ek ','M', '22',  16000, 3, '24/12/2015');
INSERT INTO person VALUES(1651, 'Renata', 'R?žková','F', '48',  18000, 3, '4.1.2019');
INSERT INTO person VALUES(1652, 'Gejza', 'Plachý ','M', '44',  26000, 3, '31/12/2010');
INSERT INTO person VALUES(1653, 'Vladimíra', 'Barešová','F', '55',  34000, 3, '22.2.2008');
INSERT INTO person VALUES(1654, 'Samuel', 'Zbo?il ','M', '27',  31000, 3, '9/11/2006');
INSERT INTO person VALUES(1655, 'Denisa', 'Pr?šová','F', '40',  42000, 2, '18.12.2004');
INSERT INTO person VALUES(1656, 'Oleg', 'Holoubek ','M', '49',  40000, 2, '11/4/2018');
INSERT INTO person VALUES(1657, 'Vendula', 'Jelenová','F', '48',  22000, 3, '1.7.2010');
INSERT INTO person VALUES(1658, 'Bronislav', 'Šimánek ','M', '32',  45000, 3, '18/2/2014');
INSERT INTO person VALUES(1659, 'So?a', 'Riedlová','F', '33',  29000, 2, '27.4.2007');
INSERT INTO person VALUES(1660, 'Nikolas', 'Doležal ','M', '55',  19000, 2, '25/2/2009');
INSERT INTO person VALUES(1661, 'Danuška', 'Kroupová','F', '42',  17000, 3, '28.6.2014');
INSERT INTO person VALUES(1662, 'Andrej', 'Kaplan ','M', '37',  23000, 3, '28/6/2008');
INSERT INTO person VALUES(1663, 'Yveta', 'Vydrová','F', '49',  33000, 4, '16.8.2003');
INSERT INTO person VALUES(1664, 'Alois', 'Kope?ný ','M', '20',  28000, 4, '7/5/2004');
INSERT INTO person VALUES(1665, 'Bed?iška', '?ehá?ková','F', '34',  41000, 3, '4.11.2016');
INSERT INTO person VALUES(1666, 'Svatopluk', 'Fousek ','M', '42',  38000, 3, '8/10/2015');
INSERT INTO person VALUES(1667, 'Beáta', 'Pekárková','F', '42',  21000, 4, '23.12.2005');
INSERT INTO person VALUES(1668, 'Old?ich', 'Dole?ek ','M', '25',  43000, 4, '16/8/2011');
INSERT INTO person VALUES(1669, 'Zlatuše', 'Bo?ková','F', '27',  28000, 3, '14.3.2019');
INSERT INTO person VALUES(1670, 'Peter', 'B?ezina ','M', '47',  16000, 3, '24/8/2006');
INSERT INTO person VALUES(1671, 'Olena', 'Pelikánová','F', '59',  36000, 2, '8.1.2016');
INSERT INTO person VALUES(1672, 'Marián', 'Janovský ','M', '24',  25000, 2, '24/1/2018');
INSERT INTO person VALUES(1673, 'Tatiána', 'Kolmanová','F', '20',  16000, 3, '25.2.2005');
INSERT INTO person VALUES(1674, 'Dušan', 'Zach ','M', '53',  30000, 3, '2/12/2013');
INSERT INTO person VALUES(1675, 'Žaneta', 'B?ezinová','F', '28',  39000, 4, '29.4.2012');
INSERT INTO person VALUES(1676, 'Vojt?ch', 'Vícha ','M', '35',  35000, 4, '5/4/2013');
INSERT INTO person VALUES(1677, 'V?ra', 'Krej?íková','F', '59',  39000, 3, '4.7.2007');
INSERT INTO person VALUES(1678, 'Jaromír', 'Žemli?ka ','M', '58',  45000, 3, '18/10/2004');
INSERT INTO person VALUES(1679, 'Silvie 7300', 'Fuchsová','F', '21',  27000, 4, '5.9.2014');
INSERT INTO person VALUES(1680, 'Miroslav', 'Hampl ','M', '40',  14000, 4, '19/2/2004');
INSERT INTO person VALUES(1681, 'Zde?ka', 'Pokorná','F', '51',  27000, 2, '10.11.2009');
INSERT INTO person VALUES(1682, 'Tomáš', 'Linhart ','M', '63',  23000, 2, '28/1/2012');
INSERT INTO person VALUES(1683, 'Margita', 'Kociánová','F', '60',  14000, 4, '12.1.2017');
INSERT INTO person VALUES(1684, 'Zbyšek', 'Hrabal ','M', '45',  28000, 4, '31/5/2011');
INSERT INTO person VALUES(1685, 'Alexandra', 'Smejkalová','F', '45',  22000, 3, '8.11.2013');
INSERT INTO person VALUES(1686, 'Radek', 'Vymazal ','M', '21',  37000, 3, '7/6/2006');
INSERT INTO person VALUES(1687, 'Sandra', 'Smržová','F', '53',  38000, 3, '22.5.2019');
INSERT INTO person VALUES(1688, 'Tobiáš', 'Šilhavý ','M', '50',  42000, 3, '9/9/2018');
INSERT INTO person VALUES(1689, 'Margita', 'Špi?ková','F', '38',  45000, 3, '16.3.2016');
INSERT INTO person VALUES(1690, 'Josef', 'Kalina ','M', '27',  16000, 3, '16/9/2013');
INSERT INTO person VALUES(1691, 'Old?iška', 'Chovancová','F', '45',  25000, 3, '4.5.2005');
INSERT INTO person VALUES(1692, 'Petro', 'Lukáš ','M', '56',  21000, 3, '26/7/2009');
INSERT INTO person VALUES(1693, 'Ta ána', 'Hašková','F', '31',  33000, 3, '24.7.2018');
INSERT INTO person VALUES(1694, 'Vladimir', '?ernoch ','M', '32',  30000, 3, '2/8/2004');
INSERT INTO person VALUES(1695, 'Karin', 'Bradová','F', '38',  13000, 3, '11.9.2007');
INSERT INTO person VALUES(1696, 'Boris', 'T?íska ','M', '61',  35000, 3, '4/11/2016');
INSERT INTO person VALUES(1697, 'Miroslava', '?ejková','F', '47',  37000, 4, '13.11.2014');
INSERT INTO person VALUES(1698, 'Robin', 'Slavík ','M', '43',  40000, 4, '7/3/2016');
INSERT INTO person VALUES(1699, 'Tereza', 'Václavíková','F', '32',  44000, 4, '9.9.2011');
INSERT INTO person VALUES(1700, 'Viliám', 'Vysko?il ','M', '19',  13000, 4, '15/3/2011');
INSERT INTO person VALUES(1701, 'Pavlína', 'Kubelková','F', '39',  24000, 4, '22.3.2017');
INSERT INTO person VALUES(1702, 'Vratislav', 'Zima ','M', '48',  18000, 4, '22/1/2007');
INSERT INTO person VALUES(1703, 'Irena', 'Šašková','F', '25',  32000, 3, '16.1.2014');
INSERT INTO person VALUES(1704, 'Slavomír', 'Hrbá?ek ','M', '24',  28000, 3, '24/6/2018');
INSERT INTO person VALUES(1705, 'Milena', 'Prchalová','F', '32',  12000, 4, '30.7.2019');
INSERT INTO person VALUES(1706, 'Št?pán', 'Píša ','M', '53',  33000, 4, '2/5/2014');
INSERT INTO person VALUES(1707, 'Pavlína', 'Hynková','F', '63',  19000, 3, '24.5.2016');
INSERT INTO person VALUES(1708, 'Erik', 'Pokorný ','M', '30',  42000, 3, '10/5/2009');
INSERT INTO person VALUES(1709, 'Stanislava', 'Košková','F', '25',  35000, 4, '12.7.2005');
INSERT INTO person VALUES(1710, 'Jind?ich', 'Toman ','M', '59',  47000, 4, '18/3/2005');
INSERT INTO person VALUES(1711, 'Simona', 'Pluha?ová','F', '56',  43000, 3, '1.10.2018');
INSERT INTO person VALUES(1712, 'Otakar', 'Šafránek ','M', '35',  20000, 3, '18/8/2016');
INSERT INTO person VALUES(1713, 'Natálie', 'Jahodová','F', '63',  22000, 3, '19.11.2007');
INSERT INTO person VALUES(1714, 'Lukáš', 'Van??ek ','M', '64',  26000, 3, '27/6/2012');
INSERT INTO person VALUES(1715, 'Stanislava', 'Vojt?chová','F', '49',  30000, 3, '14.9.2004');
INSERT INTO person VALUES(1716, 'Bohuslav', 'Jiroušek ','M', '40',  35000, 3, '5/7/2007');
INSERT INTO person VALUES(1717, 'Lydie', 'Kropá?ková','F', '57',  18000, 4, '17.11.2011');
INSERT INTO person VALUES(1718, 'Aleš', 'Adamec ','M', '22',  40000, 4, '5/11/2006');
INSERT INTO person VALUES(1719, 'Bohdana', 'Pr?šová','F', '19',  34000, 4, '30.5.2017');
INSERT INTO person VALUES(1720, 'Oskar', 'Starý ','M', '51',  45000, 4, '7/2/2019');
INSERT INTO person VALUES(1721, 'Marika', 'Janí?ková','F', '50',  41000, 4, '25.3.2014');
INSERT INTO person VALUES(1722, 'Václav', 'Blecha ','M', '28',  18000, 4, '14/2/2014');
INSERT INTO person VALUES(1723, 'Zlata', 'Kubová','F', '36',  13000, 3, '19.1.2011');
INSERT INTO person VALUES(1724, 'Ivo', 'Vysloužil ','M', '50',  27000, 3, '22/2/2009');
INSERT INTO person VALUES(1725, 'Vilma', 'Levá','F', '43',  29000, 4, '1.8.2016');
INSERT INTO person VALUES(1726, 'V?roslav', 'Vydra ','M', '33',  32000, 4, '31/12/2004');
INSERT INTO person VALUES(1727, 'Barbara', 'Seifertová','F', '28',  37000, 3, '28.5.2013');
INSERT INTO person VALUES(1728, 'Vojt?ch', 'Vacek ','M', '55',  42000, 3, '2/6/2016');
INSERT INTO person VALUES(1729, 'Zora', 'Brožková','F', '36',  16000, 3, '9.12.2018');
INSERT INTO person VALUES(1730, 'Zoltán', 'P?ibyl ','M', '38',  47000, 3, '11/4/2012');
INSERT INTO person VALUES(1731, 'Bohumila', 'Holoubková','F', '44',  40000, 1, '17.9.2009');
INSERT INTO person VALUES(1732, 'Augustin', 'Kazda ','M', '20',  16000, 1, '13/8/2011');
INSERT INTO person VALUES(1733, 'Kamila', 'Šimá?ková','F', '30',  12000, 4, '13.7.2006');
INSERT INTO person VALUES(1734, 'Adrian', 'Moudrý ','M', '42',  25000, 4, '20/8/2006');
INSERT INTO person VALUES(1735, 'Alice', 'Pelikánová','F', '37',  28000, 4, '24.1.2012');
INSERT INTO person VALUES(1736, 'Oto', 'Kabát ','M', '25',  30000, 4, '22/11/2018');
INSERT INTO person VALUES(1737, 'Št?pánka', 'Melicharová','F', '22',  35000, 4, '19.11.2008');
INSERT INTO person VALUES(1738, 'Gerhard', 'Zají?ek ','M', '48',  39000, 4, '29/11/2013');
INSERT INTO person VALUES(1739, 'Vladimíra', 'Žižková','F', '54',  43000, 3, '15.9.2005');
INSERT INTO person VALUES(1740, 'Jan', 'Synek ','M', '24',  12000, 3, '6/12/2008');
INSERT INTO person VALUES(1741, 'Alice', 'Kochová','F', '61',  23000, 4, '29.3.2011');
INSERT INTO person VALUES(1742, 'Cyril', 'Fu?ík ','M', '53',  18000, 4, '15/10/2004');
INSERT INTO person VALUES(1743, 'Alžbeta', 'Zapletalová','F', '24',  47000, 1, '31.5.2018');
INSERT INTO person VALUES(1744, 'Samuel', 'Král ','M', '35',  22000, 1, '16/2/2004');
INSERT INTO person VALUES(1745, 'Regina', 'Sou?ková','F', '55',  18000, 4, '27.3.2015');
INSERT INTO person VALUES(1746, 'Oleg', 'Lukáš ','M', '57',  31000, 4, '19/7/2015');
INSERT INTO person VALUES(1747, 'Beáta', 'Picková','F', '62',  34000, 1, '14.5.2004');
INSERT INTO person VALUES(1748, 'Alexander 4 000', 'Janí?ek ','M', '40',  37000, 1, '28/5/2011');
INSERT INTO person VALUES(1749, 'Yveta', 'Be?vá?ová','F', '48',  42000, 4, '2.8.2017');
INSERT INTO person VALUES(1750, 'Erich', 'Orság ','M', '62',  46000, 4, '4/6/2006');
INSERT INTO person VALUES(1751, 'Alena', 'Zahradníková','F', '55',  22000, 4, '20.9.2006');
INSERT INTO person VALUES(1752, 'B?etislav', 'Mlejnek ','M', '45',  15000, 4, '6/9/2018');
INSERT INTO person VALUES(1753, 'Beáta', 'Pet?íková','F', '40',  29000, 4, '17.7.2003');
INSERT INTO person VALUES(1754, 'Anton', 'Mazánek ','M', '22',  24000, 4, '13/9/2013');
INSERT INTO person VALUES(1755, 'Veronika', 'Holasová','F', '48',  45000, 4, '27.1.2009');
INSERT INTO person VALUES(1756, 'Vít', 'Novotný ','M', '51',  30000, 4, '22/7/2009');
INSERT INTO person VALUES(1757, 'Lenka', 'Vav?íková','F', '33',  17000, 4, '23.11.2005');
INSERT INTO person VALUES(1758, 'Adolf', 'K?ivánek ','M', '27',  39000, 4, '30/7/2004');
INSERT INTO person VALUES(1759, 'Sára', 'Bártová','F', '42',  41000, 1, '25.1.2013');
INSERT INTO person VALUES(1760, 'Peter', 'Píša ','M', '55',  43000, 1, '1/12/2003');
INSERT INTO person VALUES(1761, 'Veronika', 'Králíková','F', '26',  40000, 3, '31.3.2008');
INSERT INTO person VALUES(1762, 'Radomír', 'Skácel ','M', '32',  17000, 3, '9/11/2011');
INSERT INTO person VALUES(1763, 'Bohuslava', 'Kle?ková','F', '34',  28000, 4, '3.6.2015');
INSERT INTO person VALUES(1764, 'Dušan', 'Machá?ek ','M', '60',  22000, 4, '12/3/2011');
INSERT INTO person VALUES(1765, 'Drahoslava', 'Sikorová','F', '42',  44000, 1, '21.7.2004');
INSERT INTO person VALUES(1766, 'Roland', 'Kubík ','M', '43',  27000, 1, '18/1/2007');
INSERT INTO person VALUES(1767, 'Radmila', 'Prokešová','F', '27',  15000, 4, '10.10.2017');
INSERT INTO person VALUES(1768, 'Filip', 'Van??ek ','M', '20',  36000, 4, '21/6/2018');
INSERT INTO person VALUES(1769, 'Karín', 'Pot??ková','F', '34',  31000, 1, '28.11.2006');
INSERT INTO person VALUES(1770, 'Alex', 'Hladký ','M', '49',  42000, 1, '29/4/2014');
INSERT INTO person VALUES(1771, 'And?la', 'Janotová','F', '20',  39000, 4, '24.9.2003');
INSERT INTO person VALUES(1772, 'František', 'Prošek ','M', '25',  15000, 4, '6/5/2009');
INSERT INTO person VALUES(1773, 'Viera', 'Zelinková','F', '27',  19000, 1, '6.4.2009');
INSERT INTO person VALUES(1774, 'Jáchym', 'Kala ','M', '54',  20000, 1, '15/3/2005');
INSERT INTO person VALUES(1775, 'Karin', 'Šafránková','F', '59',  26000, 4, '30.1.2006');
INSERT INTO person VALUES(1776, 'Ruslan', 'Dušek ','M', '30',  29000, 4, '15/8/2016');
INSERT INTO person VALUES(1777, 'Danuška', 'Švestková','F', '20',  42000, 4, '14.8.2011');
INSERT INTO person VALUES(1778, 'Bo?ivoj', 'Adámek ','M', '59',  34000, 4, '24/6/2012');
INSERT INTO person VALUES(1779, 'Nina', 'Molnárová','F', '51',  14000, 4, '8.6.2008');
INSERT INTO person VALUES(1780, 'Mario', 'Votava ','M', '35',  44000, 4, '2/7/2007');
INSERT INTO person VALUES(1781, 'Blanka', '?ezní?ková','F', '60',  38000, 1, '11.8.2015');
INSERT INTO person VALUES(1782, 'Kristián', 'Srb ','M', '63',  12000, 1, '2/11/2006');
INSERT INTO person VALUES(1783, 'Miroslava', '?eháková','F', '45',  45000, 4, '6.6.2012');
INSERT INTO person VALUES(1784, '?udovít', 'P?ibyl ','M', '40',  21000, 4, '4/4/2018');
INSERT INTO person VALUES(1785, 'Tereza', 'Stehlíková','F', '31',  17000, 4, '2.4.2009');
INSERT INTO person VALUES(1786, 'Stanislav', 'Ferenc ','M', '62',  31000, 4, '12/4/2013');
INSERT INTO person VALUES(1787, 'Blanka', 'Richtrová','F', '38',  33000, 4, '14.10.2014');
INSERT INTO person VALUES(1788, 'Oliver', 'Fischer ','M', '45',  36000, 4, '18/2/2009');
INSERT INTO person VALUES(1789, 'Michala', 'Vobo?ilová','F', '47',  21000, 1, '22.7.2005');
INSERT INTO person VALUES(1790, 'Leo', 'Kabát ','M', '27',  41000, 1, '21/6/2008');
INSERT INTO person VALUES(1791, 'Milena', '?ervinková','F', '31',  20000, 4, '19.2.2017');
INSERT INTO person VALUES(1792, '?en?k', 'Kalivoda ','M', '50',  14000, 4, '30/5/2016');
INSERT INTO person VALUES(1793, 'Alenka', 'Kalousová','F', '39',  44000, 1, '29.11.2007');
INSERT INTO person VALUES(1794, 'Slavomír', '?ejka ','M', '32',  19000, 1, '1/10/2015');
INSERT INTO person VALUES(1795, 'Lidmila', 'Hendrychová','F', '25',  16000, 4, '24.9.2004');
INSERT INTO person VALUES(1796, 'Sebastian', 'Fu?ík ','M', '55',  28000, 4, '9/10/2010');
INSERT INTO person VALUES(1797, 'Tamara', 'Jedli?ková','F', '32',  32000, 1, '7.4.2010');
INSERT INTO person VALUES(1798, 'Erik', 'Dolejší ','M', '37',  33000, 1, '17/8/2006');
INSERT INTO person VALUES(1799, 'Alenka', 'Suchá','F', '63',  39000, 4, '1.2.2007');
INSERT INTO person VALUES(1800, 'Emanuel', 'Semerád ','M', '60',  43000, 4, '17/1/2018');
INSERT INTO person VALUES(1801, 'Marika', 'Zichová','F', '25',  19000, 1, '14.8.2012');
INSERT INTO person VALUES(1802, 'Bed?ich', 'Jech ','M', '43',  12000, 1, '26/11/2013');
INSERT INTO person VALUES(1803, 'Lydie', 'Mat?jí?ková','F', '56',  27000, 4, '9.6.2009');
INSERT INTO person VALUES(1804, 'Andrej', 'Komárek ','M', '19',  21000, 4, '3/12/2008');
INSERT INTO person VALUES(1805, 'Bohdana', 'Berková','F', '64',  43000, 1, '21.12.2014');
INSERT INTO person VALUES(1806, 'Alois', 'Bauer ','M', '48',  26000, 1, '12/10/2004');
INSERT INTO person VALUES(1807, 'Marika', 'Horká','F', '49',  14000, 4, '17.10.2011');
INSERT INTO person VALUES(1808, 'Svatopluk', 'Oláh ','M', '24',  35000, 4, '14/3/2016');
INSERT INTO person VALUES(1809, 'Vanesa', 'Krištofová','F', '56',  30000, 4, '29.4.2017');
INSERT INTO person VALUES(1810, 'Old?ich', 'Berger ','M', '53',  41000, 4, '21/1/2012');
INSERT INTO person VALUES(1811, 'Ladislava', 'N?me?ková','F', '19',  18000, 1, '6.2.2008');
INSERT INTO person VALUES(1812, 'Václav', 'Janda ','M', '35',  45000, 1, '25/5/2011');
INSERT INTO person VALUES(1813, 'Drahomíra', 'Žáková','F', '50',  26000, 1, '2.12.2004');
INSERT INTO person VALUES(1814, 'Ivo', 'Lang ','M', '58',  19000, 1, '1/6/2006');
INSERT INTO person VALUES(1815, 'Kristina', 'Michalcová','F', '57',  41000, 1, '15.6.2010');
INSERT INTO person VALUES(1816, 'Maxmilián', 'Husák ','M', '41',  24000, 1, '2/9/2018');
INSERT INTO person VALUES(1817, 'Bohumila', 'Stárková','F', '43',  13000, 1, '10.4.2007');
INSERT INTO person VALUES(1818, 'Vojt?ch', 'Široký ','M', '63',  33000, 1, '10/9/2013');
INSERT INTO person VALUES(1819, 'Magdaléna', '?ervená','F', '50',  29000, 1, '21.10.2012');
INSERT INTO person VALUES(1820, 'Vasil', 'Rozsypal ','M', '46',  38000, 1, '19/7/2009');
INSERT INTO person VALUES(1821, 'Alice', 'Mrázová','F', '36',  36000, 4, '17.8.2009');
INSERT INTO person VALUES(1822, 'Miroslav', 'Otáhal ','M', '22',  47000, 4, '26/7/2004');
INSERT INTO person VALUES(1823, 'Nicole', 'Kvasni?ková','F', '44',  24000, 2, '19.10.2016');
INSERT INTO person VALUES(1824, 'Artur', 'Hladký ','M', '50',  16000, 2, '28/11/2003');
INSERT INTO person VALUES(1825, 'Edita', 'Kulhavá','F', '28',  24000, 4, '25.12.2011');
INSERT INTO person VALUES(1826, 'Zbyšek', 'Bo?ek ','M', '27',  26000, 4, '5/11/2011');
INSERT INTO person VALUES(1827, 'Brigita', 'Sta?ková','F', '37',  12000, 1, '26.2.2019');
INSERT INTO person VALUES(1828, 'Gerhard', 'Kala ','M', '55',  31000, 1, '8/3/2011');
INSERT INTO person VALUES(1829, 'Magda', 'Hudcová','F', '21',  47000, 4, '3.5.2014');
INSERT INTO person VALUES(1830, 'Tobiáš', 'Hor?ák ','M', '33',  40000, 4, '14/2/2019');
INSERT INTO person VALUES(1831, 'Kate?ina', 'Vorlová','F', '30',  35000, 1, '9.2.2005');
INSERT INTO person VALUES(1832, 'Cyril', 'Adámek ','M', '61',  45000, 1, '17/6/2018');
INSERT INTO person VALUES(1833, 'Dagmar', 'Šebestová','F', '37',  15000, 2, '23.8.2010');
INSERT INTO person VALUES(1834, 'Marian', 'Hole?ek ','M', '44',  14000, 2, '26/4/2014');
INSERT INTO person VALUES(1835, 'Jarmila', 'Trnková','F', '22',  23000, 1, '18.6.2007');
INSERT INTO person VALUES(1836, 'Julius', 'Vybíral ','M', '20',  23000, 1, '3/5/2009');
INSERT INTO person VALUES(1837, 'Alena', 'Volfová','F', '54',  30000, 4, '13.4.2004');
INSERT INTO person VALUES(1838, 'Július', 'Pernica ','M', '42',  33000, 4, '10/5/2004');
INSERT INTO person VALUES(1839, 'Dagmar', 'Šplíchalová','F', '61',  46000, 1, '25.10.2009');
INSERT INTO person VALUES(1840, 'Robin', 'Kliment ','M', '25',  38000, 1, '12/8/2016');
INSERT INTO person VALUES(1841, 'Jarmila', 'Vorlí?ková','F', '47',  18000, 4, '21.8.2006');
INSERT INTO person VALUES(1842, 'Viliám', 'Mareš ','M', '48',  47000, 4, '20/8/2011');
INSERT INTO person VALUES(1843, 'Olga', 'Neumannová','F', '54',  34000, 1, '3.3.2012');
INSERT INTO person VALUES(1844, 'Vratislav', 'Richter ','M', '30',  16000, 1, '29/6/2007');
INSERT INTO person VALUES(1845, 'Miluška', 'Vojtíšková','F', '62',  21000, 2, '6.5.2019');
INSERT INTO person VALUES(1846, 'Vít', 'Maršík ','M', '58',  21000, 2, '30/10/2006');
INSERT INTO person VALUES(1847, 'Nikola', 'Rácová','F', '47',  21000, 1, '10.7.2014');
INSERT INTO person VALUES(1848, 'Št?pán', 'Krej?ík ','M', '36',  31000, 1, '7/10/2014');
INSERT INTO person VALUES(1849, 'Zdena', 'Stehlíková','F', '55',  45000, 2, '18.4.2005');
INSERT INTO person VALUES(1850, 'Vlastimil', 'Vinš ','M', '64',  35000, 2, '8/2/2014');
INSERT INTO person VALUES(1851, 'Denisa', 'Ludvíková','F', '39',  45000, 4, '16.11.2016');
INSERT INTO person VALUES(1852, 'Jind?ich', 'Jíra ','M', '41',  45000, 4, '23/8/2005');
INSERT INTO person VALUES(1853, 'Viera', 'Ve?erková','F', '48',  32000, 2, '26.8.2007');
INSERT INTO person VALUES(1854, 'Vladimír', 'Uhlí? ','M', '23',  14000, 2, '24/12/2004');
INSERT INTO person VALUES(1855, 'Karín', 'Fantová','F', '33',  40000, 1, '21.6.2004');
INSERT INTO person VALUES(1856, 'Vladislav', 'Jahoda ','M', '45',  23000, 1, '27/5/2016');
INSERT INTO person VALUES(1857, 'Ester', 'Vaní?ková','F', '41',  20000, 1, '2.1.2010');
INSERT INTO person VALUES(1858, 'Ernest', 'Smola ','M', '28',  28000, 1, '4/4/2012');
INSERT INTO person VALUES(1859, 'Viera', 'Kuncová','F', '26',  27000, 1, '29.10.2006');
INSERT INTO person VALUES(1860, 'Aleš', 'Nešpor ','M', '51',  37000, 1, '12/4/2007');
INSERT INTO person VALUES(1861, 'Bed?iška', 'Zedníková','F', '33',  43000, 1, '11.5.2012');
INSERT INTO person VALUES(1862, 'Oskar', 'Kuchta ','M', '34',  43000, 1, '15/7/2019');
INSERT INTO person VALUES(1863, 'Danuška', 'Šírová','F', '19',  15000, 1, '6.3.2009');
INSERT INTO person VALUES(1864, 'Václav', 'Charvát ','M', '56',  16000, 1, '22/7/2014');
INSERT INTO person VALUES(1865, 'Yveta', 'Menšíková','F', '26',  31000, 1, '17.9.2014');
INSERT INTO person VALUES(1866, '?ubomír', 'Diviš ','M', '39',  21000, 1, '31/5/2010');
INSERT INTO person VALUES(1867, 'Renáta', 'Mat?jí?ková','F', '35',  19000, 2, '26.6.2005');
INSERT INTO person VALUES(1868, 'Ondrej', 'Šimá?ek ','M', '21',  26000, 2, '1/10/2009');
INSERT INTO person VALUES(1869, 'Emilie', 'Vejvodová','F', '20',  26000, 1, '15.9.2018');
INSERT INTO person VALUES(1870, 'Alan', 'Tancoš ','M', '43',  35000, 1, '8/10/2004');
INSERT INTO person VALUES(1871, 'Miloslava', 'Teplá','F', '51',  34000, 1, '12.7.2015');
INSERT INTO person VALUES(1872, 'Jaroslav', 'Doležel ','M', '19',  44000, 1, '11/3/2016');
INSERT INTO person VALUES(1873, 'Ema', 'Vilímková','F', '60',  22000, 2, '20.4.2006');
INSERT INTO person VALUES(1874, 'Rastislav', 'Rozsypal ','M', '47',  13000, 2, '13/7/2015');
INSERT INTO person VALUES(1875, 'Kv?toslava', 'Kubátová','F', '44',  21000, 1, '17.11.2017');
INSERT INTO person VALUES(1876, 'Adrian', 'Bouška ','M', '25',  23000, 1, '25/1/2007');
INSERT INTO person VALUES(1877, 'Johana', 'Wagnerová','F', '53',  45000, 2, '26.8.2008');
INSERT INTO person VALUES(1878, 'Ervín', 'Valenta ','M', '53',  27000, 2, '29/5/2006');
INSERT INTO person VALUES(1879, 'Ema', 'Švejdová','F', '38',  17000, 1, '22.6.2005');
INSERT INTO person VALUES(1880, 'Ji?í', 'Bo?ek ','M', '29',  36000, 1, '29/10/2017');
INSERT INTO person VALUES(1881, 'Yvona', 'Musilová','F', '45',  33000, 2, '3.1.2011');
INSERT INTO person VALUES(1882, '?en?k', '?onka ','M', '58',  42000, 2, '6/9/2013');
INSERT INTO person VALUES(1883, 'Tamara', 'Doležalová','F', '31',  40000, 1, '30.10.2007');
INSERT INTO person VALUES(1884, 'Vojtech', 'Hor?ák ','M', '34',  15000, 1, '14/9/2008');
INSERT INTO person VALUES(1885, 'Radka', 'Neumannová','F', '39',  28000, 2, '1.1.2015');
INSERT INTO person VALUES(1886, 'Sebastian', 'Adámek ','M', '62',  19000, 2, '16/1/2008');
INSERT INTO person VALUES(1887, 'Yvona', 'Holcová','F', '24',  28000, 1, '7.3.2010');
INSERT INTO person VALUES(1888, 'Oleg', 'Vilímek ','M', '40',  29000, 1, '24/12/2015');
INSERT INTO person VALUES(1889, 'Aneta', 'Rácová','F', '32',  16000, 2, '9.5.2017');
INSERT INTO person VALUES(1890, 'Nikolas', 'Vybíral ','M', '22',  34000, 2, '27/4/2015');
INSERT INTO person VALUES(1891, 'Adéla', 'Votrubová','F', '64',  23000, 1, '5.3.2014');
INSERT INTO person VALUES(1892, 'Vladan', 'Pernica ','M', '44',  43000, 1, '4/5/2010');
INSERT INTO person VALUES(1893, 'Drahomíra', 'Ludvíková','F', '25',  39000, 2, '16.9.2019');
INSERT INTO person VALUES(1894, 'Tibor', 'Kliment ','M', '27',  12000, 2, '12/3/2006');
INSERT INTO person VALUES(1895, 'Romana', 'Vondrová','F', '56',  47000, 1, '12.7.2016');
INSERT INTO person VALUES(1896, 'Norbert', 'Mareš ','M', '49',  22000, 1, '13/8/2017');
INSERT INTO person VALUES(1897, 'Ladislava', 'Bubeníková','F', '64',  27000, 2, '30.8.2005');
INSERT INTO person VALUES(1898, 'Denis', 'Richter ','M', '32',  27000, 2, '21/6/2013');
INSERT INTO person VALUES(1899, 'Drahomíra', 'Nývltová','F', '49',  34000, 1, '19.11.2018');
INSERT INTO person VALUES(1900, 'Dan', 'Šesták ','M', '54',  36000, 1, '29/6/2008');
INSERT INTO person VALUES(1901, 'Sylvie', 'Kuncová','F', '58',  22000, 2, '27.8.2009');
INSERT INTO person VALUES(1902, 'Pavol', 'Jur?ík ','M', '36',  41000, 2, '31/10/2007');
INSERT INTO person VALUES(1903, 'Radana', 'Zedníková','F', '19',  38000, 3, '10.3.2015');
INSERT INTO person VALUES(1904, 'Rostislav', 'Vinš ','M', '19',  46000, 3, '8/9/2003');
INSERT INTO person VALUES(1905, 'Hanna', 'Šírová','F', '50',  46000, 2, '4.1.2012');
INSERT INTO person VALUES(1906, 'Bohumír', 'Dohnal ','M', '42',  19000, 2, '9/2/2015');
INSERT INTO person VALUES(1907, 'Laura', 'Menšíková','F', '58',  25000, 2, '17.7.2017');
INSERT INTO person VALUES(1908, 'Jaromír', 'Uhlí? ','M', '25',  24000, 2, '18/12/2010');
INSERT INTO person VALUES(1909, 'Nicole', 'Kostková','F', '43',  33000, 2, '13.5.2014');
INSERT INTO person VALUES(1910, 'Eduard', 'Jahoda ','M', '47',  34000, 2, '25/12/2005');
INSERT INTO person VALUES(1911, 'Svitlana', 'Böhmová','F', '28',  41000, 1, '9.3.2011');
INSERT INTO person VALUES(1912, 'Juraj', 'Farkaš ','M', '23',  43000, 1, '28/5/2017');
INSERT INTO person VALUES(1913, 'Laura', 'Neradová','F', '36',  20000, 2, '19.9.2016');
INSERT INTO person VALUES(1914, 'Dominik', 'Nešpor ','M', '52',  12000, 2, '5/4/2013');
INSERT INTO person VALUES(1915, 'Julie', 'Kop?ivová','F', '44',  44000, 3, '28.6.2007');
INSERT INTO person VALUES(1916, 'Antonín', 'Hrdina ','M', '34',  17000, 3, '6/8/2012');
INSERT INTO person VALUES(1917, 'Alžb?ta', 'Kubátová','F', '30',  16000, 2, '23.4.2004');
INSERT INTO person VALUES(1918, 'Zbyn?k', 'Berger ','M', '57',  26000, 2, '15/8/2007');
INSERT INTO person VALUES(1919, 'Erika', 'B?ízová','F', '37',  32000, 3, '4.11.2009');
INSERT INTO person VALUES(1920, 'Petr', 'Hartman ','M', '40',  31000, 3, '23/6/2003');
INSERT INTO person VALUES(1921, 'Sabina', 'Vodrážková','F', '22',  39000, 2, '31.8.2006');
INSERT INTO person VALUES(1922, 'Lubomír', 'Kolman ','M', '62',  40000, 2, '23/11/2014');
INSERT INTO person VALUES(1923, 'Terezie', 'Muchová','F', '30',  19000, 2, '13.3.2012');
INSERT INTO person VALUES(1924, 'Vladimir', 'Tancoš ','M', '45',  45000, 2, '2/10/2010');
INSERT INTO person VALUES(1925, 'Erika', 'Malinová','F', '61',  27000, 2, '7.1.2009');
INSERT INTO person VALUES(1926, 'Jakub', 'Doležel ','M', '21',  19000, 2, '9/10/2005');
INSERT INTO person VALUES(1927, 'Svatava', 'Remešová','F', '22',  43000, 2, '21.7.2014');
INSERT INTO person VALUES(1928, 'J?lius', 'Kozel ','M', '50',  24000, 2, '11/1/2018');
INSERT INTO person VALUES(1929, 'Josefa', 'Moudrá','F', '54',  14000, 2, '16.5.2011');
INSERT INTO person VALUES(1930, 'Svatoslav', 'Bouška ','M', '26',  33000, 2, '18/1/2013');
INSERT INTO person VALUES(1931, 'V?ra', 'Polášková','F', '62',  38000, 3, '18.7.2018');
INSERT INTO person VALUES(1932, 'Nikola', 'Valenta ','M', '54',  38000, 3, '21/5/2012');
INSERT INTO person VALUES(1933, 'Svatava', 'Horvátová','F', '47',  38000, 1, '22.9.2013');
INSERT INTO person VALUES(1934, 'Stepan', 'Lavi?ka ','M', '32',  12000, 1, '5/12/2003');
INSERT INTO person VALUES(1935, 'Martina', 'Hanková','F', '55',  26000, 2, '1.7.2004');
INSERT INTO person VALUES(1936, 'Hubert', '?onka ','M', '60',  16000, 2, '31/8/2019');
INSERT INTO person VALUES(1937, 'Eliška', 'Horová','F', '62',  42000, 3, '12.1.2010');
INSERT INTO person VALUES(1938, 'Hynek', 'Dudek ','M', '43',  21000, 3, '10/7/2015');
INSERT INTO person VALUES(1939, 'Zuzana', 'Hanzlíková','F', '48',  13000, 2, '8.11.2006');
INSERT INTO person VALUES(1940, 'Ferdinand', 'Peroutka ','M', '19',  31000, 2, '17/7/2010');
INSERT INTO person VALUES(1941, 'Zdenka', 'Lakatošová','F', '55',  29000, 3, '21.5.2012');
INSERT INTO person VALUES(1942, 'Otakar', 'Hroch ','M', '48',  36000, 3, '25/5/2006');
INSERT INTO person VALUES(1943, 'Pavla', 'Ba?ová','F', '41',  37000, 2, '16.3.2009');
INSERT INTO person VALUES(1944, '?estmír', 'Kone?ný ','M', '24',  45000, 2, '26/10/2017');
INSERT INTO person VALUES(1945, 'Zuzana', 'Frydrychová','F', '26',  44000, 1, '10.1.2006');
INSERT INTO person VALUES(1946, 'Imrich', 'Koš ál ','M', '46',  18000, 1, '2/11/2012');
INSERT INTO person VALUES(1947, 'Milada', 'Spá?ilová','F', '33',  24000, 2, '24.7.2011');
INSERT INTO person VALUES(1948, 'Arnošt', 'Hude?ek ','M', '29',  24000, 2, '10/9/2008');
INSERT INTO person VALUES(1949, 'Vlastimila', 'Ka?ková','F', '42',  12000, 3, '25.9.2018');
INSERT INTO person VALUES(1950, 'Ludvík', 'Pracha? ','M', '57',  28000, 3, '13/1/2008');
INSERT INTO person VALUES(1951, 'Iva', 'Chlupová','F', '26',  12000, 2, '30.11.2013');
INSERT INTO person VALUES(1952, 'Marcel', 'Slová?ek ','M', '35',  38000, 2, '21/12/2015');
INSERT INTO person VALUES(1953, 'Žofie', 'K?ížková','F', '35',  35000, 3, '8.9.2004');
INSERT INTO person VALUES(1954, 'Richard', 'Nová?ek ','M', '63',  43000, 3, '23/4/2015');
INSERT INTO person VALUES(1955, 'Jindra', 'Zajícová','F', '20',  43000, 2, '28.11.2017');
INSERT INTO person VALUES(1956, 'P?emysl', 'Krej?ík ','M', '39',  16000, 2, '1/5/2010');
INSERT INTO person VALUES(1957, 'Patricie', 'Holanová','F', '27',  23000, 3, '16.1.2007');
INSERT INTO person VALUES(1958, 'Miloslav', 'Sedlá? ','M', '22',  21000, 3, '9/3/2006');
INSERT INTO person VALUES(1959, 'Žofie', 'Tomešová','F', '59',  31000, 2, '11.11.2003');
INSERT INTO person VALUES(1960, 'Emil', 'Vav?ík ','M', '44',  30000, 2, '9/8/2017');
INSERT INTO person VALUES(1961, 'Oksana', 'Schneiderová','F', '20',  46000, 3, '24.5.2009');
INSERT INTO person VALUES(1962, 'Martin', 'Dunka ','M', '27',  35000, 3, '18/6/2013');
INSERT INTO person VALUES(1963, 'Johana', 'Sojková','F', '51',  18000, 2, '20.3.2006');
INSERT INTO person VALUES(1964, 'Robert', 'Brož ','M', '50',  45000, 2, '25/6/2008');
INSERT INTO person VALUES(1965, 'Miriam', 'Pavlicová','F', '59',  34000, 2, '1.10.2011');
INSERT INTO person VALUES(1966, 'Artur', 'Krátký ','M', '33',  14000, 2, '4/5/2004');
INSERT INTO person VALUES(1967, 'Oksana', 'Dosko?ilová','F', '44',  41000, 2, '27.7.2008');
INSERT INTO person VALUES(1968, 'Antonín', 'Šime?ek ','M', '55',  23000, 2, '5/10/2015');
INSERT INTO person VALUES(1969, 'Ilona', 'Peterková','F', '53',  29000, 3, '29.9.2015');
INSERT INTO person VALUES(1970, 'Ji?í', 'Kuchta ','M', '37',  28000, 3, '5/2/2015');
INSERT INTO person VALUES(1971, 'Magdalena', 'Knapová','F', '60',  45000, 3, '16.11.2004');
INSERT INTO person VALUES(1972, 'Gabriel', 'Pluha? ','M', '20',  33000, 3, '15/12/2010');
INSERT INTO person VALUES(1973, 'Danuše', 'Kalivodová','F', '45',  17000, 3, '4.2.2018');
INSERT INTO person VALUES(1974, 'Vojtech', 'Št?rba ','M', '42',  42000, 3, '22/12/2005');
INSERT INTO person VALUES(1975, 'Hedvika', 'Böhmová','F', '53',  33000, 3, '25.3.2007');
INSERT INTO person VALUES(1976, 'Drahomír', 'Balog ','M', '25',  47000, 3, '26/3/2018');
INSERT INTO person VALUES(1977, 'Magdalena', 'Hrdinová','F', '38',  40000, 3, '19.1.2004');
INSERT INTO person VALUES(1978, 'Juliús', 'Ková?ík ','M', '47',  21000, 3, '2/4/2013');
INSERT INTO person VALUES(1979, 'Nikol', 'Grygarová','F', '45',  20000, 3, '1.8.2009');
INSERT INTO person VALUES(1980, 'Tadeáš', 'Vrabec ','M', '30',  26000, 3, '8/2/2009');
INSERT INTO person VALUES(1981, 'Karla', 'Krupová','F', '31',  28000, 2, '28.5.2006');
INSERT INTO person VALUES(1982, 'Viliam', 'Vitásek ','M', '53',  35000, 2, '17/2/2004');
INSERT INTO person VALUES(1983, 'Zora', 'Nosková','F', '39',  16000, 4, '30.7.2013');
INSERT INTO person VALUES(1984, 'Tibor', 'Homola ','M', '35',  40000, 4, '20/6/2003');
INSERT INTO person VALUES(1985, 'Nikol', 'Cibulková','F', '24',  15000, 2, '4.10.2008');
INSERT INTO person VALUES(1986, 'Matouš', 'Mikeš ','M', '58',  14000, 2, '28/5/2011');
INSERT INTO person VALUES(1987, 'Iryna', 'Hanousková','F', '32',  39000, 3, '6.12.2015');
INSERT INTO person VALUES(1988, 'Denis', 'Pícha ','M', '40',  18000, 3, '29/9/2010');
INSERT INTO person VALUES(1989, 'Adriana', 'Ková?ová','F', '62',  39000, 2, '10.2.2011');
INSERT INTO person VALUES(1990, 'Adolf', 'Matyáš ','M', '63',  28000, 2, '6/9/2018');
INSERT INTO person VALUES(1991, 'Lucie', 'Valová','F', '25',  26000, 3, '14.4.2018');
INSERT INTO person VALUES(1992, 'Dalibor', 'K?íž ','M', '45',  33000, 3, '7/1/2018');
INSERT INTO person VALUES(1993, 'Laura', 'Uhrová','F', '56',  34000, 2, '8.2.2015');
INSERT INTO person VALUES(1994, 'Radoslav', 'Franc ','M', '21',  42000, 2, '15/1/2013');
INSERT INTO person VALUES(1995, 'Ivana', 'Jarešová','F', '64',  14000, 3, '28.3.2004');
INSERT INTO person VALUES(1996, 'Lud?k', 'Králík ','M', '50',  47000, 3, '23/11/2008');
INSERT INTO person VALUES(1997, 'Petra', 'D?dková','F', '49',  22000, 2, '17.6.2017');
INSERT INTO person VALUES(1998, 'Kryštof', 'Cihlá? ','M', '27',  20000, 2, '1/12/2003');
INSERT INTO person VALUES(1999, 'Dana', 'Valešová','F', '56',  37000, 3, '5.8.2006');
INSERT INTO person VALUES(2000, 'Ivan', 'Papež ','M', '56',  26000, 3, '4/3/2016');
INSERT INTO person VALUES(2001, 'Michaela', 'Šime?ková','F', '42',  45000, 2, '24.10.2019');
INSERT INTO person VALUES(2002, 'Ludvík', 'Brada ','M', '32',  35000, 2, '12/3/2011');
INSERT INTO person VALUES(2003, 'Andrea', 'Jíchová','F', '49',  25000, 3, '11.12.2008');
INSERT INTO person VALUES(2004, 'František', 'R?ži?ka ','M', '61',  40000, 3, '19/1/2007');
INSERT INTO person VALUES(2005, 'Maria', 'Francová','F', '58',  13000, 4, '13.2.2016');
INSERT INTO person VALUES(2006, 'Boleslav', 'Žiga ','M', '43',  45000, 4, '22/5/2006');
INSERT INTO person VALUES(2007, 'Darina', 'Hovorková','F', '43',  20000, 3, '9.12.2012');
INSERT INTO person VALUES(2008, 'Marek', '?ehá?ek ','M', '19',  18000, 3, '22/10/2017');
INSERT INTO person VALUES(2009, 'Karolina', 'Frydrychová','F', '50',  36000, 4, '22.6.2018');
INSERT INTO person VALUES(2010, 'Mario', 'Ho?ejší ','M', '48',  23000, 4, '31/8/2013');
INSERT INTO person VALUES(2011, 'Maria', 'Rousová','F', '36',  44000, 3, '18.4.2015');
INSERT INTO person VALUES(2012, 'Pavel', 'N?me?ek ','M', '25',  32000, 3, '7/9/2008');
INSERT INTO person VALUES(2013, 'Valerie', 'Vojtová','F', '43',  24000, 3, '5.6.2004');
INSERT INTO person VALUES(2014, 'Lubor', 'Šrámek ','M', '54',  37000, 3, '17/7/2004');
INSERT INTO person VALUES(2015, 'Jaromíra', 'Kleinová','F', '28',  31000, 3, '24.8.2017');
INSERT INTO person VALUES(2016, 'Rastislav', 'Vojá?ek ','M', '30',  47000, 3, '18/12/2015');
INSERT INTO person VALUES(2017, 'Sylvie', 'Danišová','F', '36',  47000, 3, '12.10.2006');
INSERT INTO person VALUES(2018, 'Ota', 'M?ller ','M', '59',  16000, 3, '26/10/2011');
INSERT INTO person VALUES(2019, 'Valerie', 'Pohanková','F', '21',  19000, 3, '8.8.2003');
INSERT INTO person VALUES(2020, 'Ervín', 'Hušek ','M', '35',  25000, 3, '3/11/2006');
INSERT INTO person VALUES(2021, 'Klára', 'Bohá?ová','F', '30',  43000, 4, '10.10.2010');
INSERT INTO person VALUES(2022, 'Leo', 'Horký ','M', '63',  30000, 4, '6/3/2006');
INSERT INTO person VALUES(2023, 'Gertruda', 'He?manová','F', '60',  42000, 2, '15.12.2005');
INSERT INTO person VALUES(2024, '?en?k', 'Toman ','M', '40',  40000, 2, '11/2/2014');
INSERT INTO person VALUES(2025, 'Daniela', 'Šimánková','F', '22',  30000, 4, '16.2.2013');
INSERT INTO person VALUES(2026, 'Mikuláš', 'Vorel ','M', '22',  44000, 4, '15/6/2013');
INSERT INTO person VALUES(2027, 'Zdenka', 'Škrabalová','F', '54',  38000, 3, '13.12.2009');
INSERT INTO person VALUES(2028, 'Sebastian', 'Hlávka ','M', '45',  17000, 3, '22/6/2008');
INSERT INTO person VALUES(2029, 'Nad?žda', 'Lacinová','F', '61',  18000, 3, '26.6.2015');
INSERT INTO person VALUES(2030, 'Bronislav', 'Bašta ','M', '28',  23000, 3, '30/4/2004');
INSERT INTO person VALUES(2031, 'Daniela', 'Pekárková','F', '47',  25000, 3, '20.4.2012');
INSERT INTO person VALUES(2032, 'Nikolas', 'Šindelá? ','M', '50',  32000, 3, '2/10/2015');
INSERT INTO person VALUES(2033, 'Mária', 'Kubánková','F', '54',  41000, 3, '1.11.2017');
INSERT INTO person VALUES(2034, 'Šimon', 'Žá?ek ','M', '33',  37000, 3, '10/8/2011');
INSERT INTO person VALUES(2035, 'Anežka', 'Kocmanová','F', '39',  13000, 3, '28.8.2014');
INSERT INTO person VALUES(2036, 'Tibor', 'Vojt?ch ','M', '55',  46000, 3, '17/8/2006');
INSERT INTO person VALUES(2037, 'Emília', 'Šímová','F', '48',  37000, 4, '6.6.2005');
INSERT INTO person VALUES(2038, 'Arnošt', 'Svato? ','M', '37',  15000, 4, '19/12/2005');
INSERT INTO person VALUES(2039, 'Radomíra', 'Zálešáková','F', '55',  16000, 4, '18.12.2010');
INSERT INTO person VALUES(2040, 'Libor', 'Doležal ','M', '20',  20000, 4, '22/3/2018');
INSERT INTO person VALUES(2041, 'Na?a', 'Berkyová','F', '41',  24000, 4, '14.10.2007');
INSERT INTO person VALUES(2042, 'Marcel', 'Berka ','M', '42',  29000, 4, '30/3/2013');
INSERT INTO person VALUES(2043, 'Tatiana', 'Veverková','F', '48',  40000, 4, '26.4.2013');
INSERT INTO person VALUES(2044, 'Karel', 'Lacina ','M', '25',  35000, 4, '5/2/2009');
INSERT INTO person VALUES(2045, 'Radomíra', 'Šubrtová','F', '33',  47000, 3, '19.2.2010');
INSERT INTO person VALUES(2046, 'Rostislav', 'Neubauer ','M', '48',  44000, 3, '13/2/2004');
INSERT INTO person VALUES(2047, 'Oksana', 'Trojanová','F', '19',  19000, 3, '16.12.2006');
INSERT INTO person VALUES(2048, 'Bohumír', 'Daniš ','M', '24',  17000, 3, '17/7/2015');
INSERT INTO person VALUES(2049, 'Natalie', 'Vitásková','F', '26',  35000, 3, '28.6.2012');
INSERT INTO person VALUES(2050, 'Jaromír', 'Vodák ','M', '53',  22000, 3, '25/5/2011');
INSERT INTO person VALUES(2051, 'Dominika', 'Klimešová','F', '35',  23000, 4, '31.8.2019');
INSERT INTO person VALUES(2052, 'Martin', 'Vojta ','M', '35',  27000, 4, '25/9/2010');
INSERT INTO person VALUES(2053, 'Anna', 'Maršálková','F', '19',  22000, 3, '5.11.2014');
INSERT INTO person VALUES(2054, 'Tomáš', 'Uher ','M', '58',  37000, 3, '3/9/2018');
INSERT INTO person VALUES(2055, 'Kv?tuše', 'Žídková','F', '27',  46000, 4, '14.8.2005');
INSERT INTO person VALUES(2056, 'Artur', 'Kulhavý ','M', '40',  41000, 4, '4/1/2018');
INSERT INTO person VALUES(2057, 'Jitka', 'Králí?ková','F', '58',  46000, 3, '14.3.2017');
INSERT INTO person VALUES(2058, 'Zbyšek', 'Rudolf ','M', '64',  15000, 3, '20/7/2009');
INSERT INTO person VALUES(2059, 'Leona', 'Vítová','F', '20',  34000, 4, '21.12.2007');
INSERT INTO person VALUES(2060, 'Walter', 'Sedlák ','M', '46',  20000, 4, '20/11/2008');
INSERT INTO person VALUES(2061, 'Hedvika', '?ejková','F', '52',  41000, 3, '16.10.2004');
INSERT INTO person VALUES(2062, 'Petr', 'Vaculík ','M', '22',  29000, 3, '28/11/2003');
INSERT INTO person VALUES(2063, 'Vladislava', 'Jiránková','F', '59',  21000, 4, '29.4.2010');
INSERT INTO person VALUES(2064, 'Petro', 'Machala ','M', '51',  34000, 4, '1/3/2016');
INSERT INTO person VALUES(2065, 'Leona', 'Kubelková','F', '44',  29000, 3, '23.2.2007');
INSERT INTO person VALUES(2066, 'Vladimir', 'Prášek ','M', '27',  43000, 3, '9/3/2011');
INSERT INTO person VALUES(2067, 'Elena', 'Matulová','F', '52',  45000, 4, '5.9.2012');
INSERT INTO person VALUES(2068, 'Boris', 'Michalík ','M', '56',  13000, 4, '15/1/2007');
INSERT INTO person VALUES(2069, 'Dita', 'Demeterová','F', '37',  16000, 3, '2.7.2009');
INSERT INTO person VALUES(2070, 'J?lius', 'Novotný ','M', '32',  22000, 3, '18/6/2018');
INSERT INTO person VALUES(2071, 'Lucie', 'Raková','F', '45',  40000, 4, '3.9.2016');
INSERT INTO person VALUES(2072, 'Viliam', 'M?ller ','M', '60',  26000, 4, '19/10/2017');
INSERT INTO person VALUES(2073, 'Marta', 'Bauerová','F', '53',  20000, 1, '22.10.2005');
INSERT INTO person VALUES(2074, 'Vilém', 'Merta ','M', '43',  32000, 1, '27/8/2013');
INSERT INTO person VALUES(2075, 'Ji?ina', 'Barto?ová','F', '38',  28000, 4, '10.1.2019');
INSERT INTO person VALUES(2076, 'Matouš', 'Hrdý ','M', '20',  41000, 4, '4/9/2008');
INSERT INTO person VALUES(2077, 'Šárka', 'Karbanová','F', '45',  43000, 4, '28.2.2008');
INSERT INTO person VALUES(2078, 'Št?pán', 'Levý ','M', '49',  46000, 4, '13/7/2004');
INSERT INTO person VALUES(2079, 'Libuše', 'Balounová','F', '31',  15000, 4, '24.12.2004');
INSERT INTO person VALUES(2080, 'Hynek', 'Benda ','M', '25',  19000, 4, '15/12/2015');
INSERT INTO person VALUES(2081, 'Radka', 'Polívková','F', '38',  31000, 4, '7.7.2010');
INSERT INTO person VALUES(2082, 'Jind?ich', 'Šedivý ','M', '54',  25000, 4, '23/10/2011');
INSERT INTO person VALUES(2083, 'Iveta', 'Pr?šová','F', '24',  38000, 4, '3.5.2007');
INSERT INTO person VALUES(2084, 'Otakar', 'Hladký ','M', '30',  34000, 4, '30/10/2006');
INSERT INTO person VALUES(2085, 'Aneta', 'Jelenová','F', '31',  18000, 4, '13.11.2012');
INSERT INTO person VALUES(2086, 'Lukáš', 'Vojtíšek ','M', '59',  39000, 4, '1/2/2019');
INSERT INTO person VALUES(2087, 'Adéla', 'Riedlová','F', '62',  26000, 3, '8.9.2009');
INSERT INTO person VALUES(2088, 'Bohuslav', 'Mencl ','M', '35',  12000, 3, '8/2/2014');
INSERT INTO person VALUES(2089, 'Katarína', 'Tomková','F', '25',  14000, 1, '10.11.2016');
INSERT INTO person VALUES(2090, 'Ivan', 'Formánek ','M', '63',  17000, 1, '11/6/2013');
INSERT INTO person VALUES(2091, 'Aneta', 'Jansová','F', '55',  13000, 3, '16.1.2012');
INSERT INTO person VALUES(2092, 'Libor', 'Havelka ','M', '41',  27000, 3, '25/12/2004');
INSERT INTO person VALUES(2093, 'Dáša', '?ehá?ková','F', '64',  37000, 4, '20.3.2019');
INSERT INTO person VALUES(2094, 'Zden?k', 'Macha? ','M', '23',  31000, 4, '27/4/2004');
INSERT INTO person VALUES(2095, 'Karolina', 'Holoubková','F', '49',  45000, 4, '14.1.2016');
INSERT INTO person VALUES(2096, 'Richard', 'Walter ','M', '45',  40000, 4, '28/9/2015');
INSERT INTO person VALUES(2097, 'Aloisie', 'Bo?ková','F', '56',  25000, 4, '3.3.2005');
INSERT INTO person VALUES(2098, 'V?roslav', 'Králí?ek ','M', '28',  46000, 4, '7/8/2011');
INSERT INTO person VALUES(2099, 'Valerie', 'Smolíková','F', '42',  32000, 4, '22.5.2018');
INSERT INTO person VALUES(2100, 'Miloslav', 'Gregor ','M', '50',  19000, 4, '14/8/2006');
INSERT INTO person VALUES(2101, 'Hanna', 'Kolmanová','F', '49',  12000, 4, '10.7.2007');
INSERT INTO person VALUES(2102, 'Zoltán', 'Ve?e?a ','M', '33',  24000, 4, '16/11/2018');
INSERT INTO person VALUES(2103, 'Sylvie', 'Klou?ková','F', '35',  20000, 3, '5.5.2004');
INSERT INTO person VALUES(2104, 'Martin', 'Šiška ','M', '56',  33000, 3, '23/11/2013');
INSERT INTO person VALUES(2105, 'Miluše', 'Nová','F', '43',  44000, 4, '8.7.2011');
INSERT INTO person VALUES(2106, 'Rastislav', 'Ku?era ','M', '38',  38000, 4, '26/3/2013');
INSERT INTO person VALUES(2107, 'Vendula', 'Fuchsová','F', '50',  24000, 1, '18.1.2017');
INSERT INTO person VALUES(2108, 'Ota', 'Vítek ','M', '21',  43000, 1, '2/2/2009');
INSERT INTO person VALUES(2109, 'So?a', 'Mlejnková','F', '36',  31000, 4, '14.11.2013');
INSERT INTO person VALUES(2110, 'Ervín', 'Kola?ík ','M', '43',  16000, 4, '10/2/2004');
INSERT INTO person VALUES(2111, 'Julie', 'Trojanová','F', '43',  47000, 1, '28.5.2019');
INSERT INTO person VALUES(2112, 'Vlastislav', 'Koubek ','M', '26',  22000, 1, '14/5/2016');
INSERT INTO person VALUES(2113, 'Alžb?ta', 'Smejkalová','F', '29',  19000, 4, '23.3.2016');
INSERT INTO person VALUES(2114, 'Gabriel', 'Michalec ','M', '48',  31000, 4, '22/5/2011');
INSERT INTO person VALUES(2115, 'Nela', 'Smržová','F', '36',  34000, 1, '11.5.2005');
INSERT INTO person VALUES(2116, 'Leoš', 'Pivo?ka ','M', '31',  36000, 1, '30/3/2007');
INSERT INTO person VALUES(2117, 'Julie', 'Špi?ková','F', '21',  42000, 4, '30.7.2018');
INSERT INTO person VALUES(2118, 'Drahomír', 'Ka?írek ','M', '53',  45000, 4, '31/8/2018');
INSERT INTO person VALUES(2119, 'Terezie', 'Chovancová','F', '29',  22000, 4, '17.9.2007');
INSERT INTO person VALUES(2120, 'Zbyn?k', 'Šev?ík ','M', '36',  15000, 4, '9/7/2014');
INSERT INTO person VALUES(2121, 'Erika', 'Hašková','F', '60',  30000, 4, '13.7.2004');
INSERT INTO person VALUES(2122, 'Tadeáš', 'Kubeš ','M', '59',  24000, 4, '16/7/2009');
INSERT INTO person VALUES(2123, 'Tatiána', 'Vorá?ková','F', '23',  17000, 1, '15.9.2011');
INSERT INTO person VALUES(2124, 'Šimon', 'Krištof ','M', '41',  28000, 1, '17/11/2008');
INSERT INTO person VALUES(2125, 'Terezie', 'Jurásková','F', '53',  17000, 4, '20.11.2006');
INSERT INTO person VALUES(2126, 'Vilém', 'Sadílek ','M', '64',  38000, 4, '25/10/2016');
INSERT INTO person VALUES(2127, 'V?ra', 'Václavíková','F', '61',  41000, 1, '22.1.2014');
INSERT INTO person VALUES(2128, 'Vit', 'Hlavá?ek ','M', '46',  43000, 1, '26/2/2016');
INSERT INTO person VALUES(2129, 'Markéta', 'Kubelková','F', '23',  21000, 1, '5.8.2019');
INSERT INTO person VALUES(2130, 'Zd?nek', 'Švarc ','M', '29',  12000, 1, '5/1/2012');
INSERT INTO person VALUES(2131, 'Martina', 'Šašková','F', '54',  28000, 1, '30.5.2016');
INSERT INTO person VALUES(2132, 'Rudolf', 'Maršálek ','M', '51',  21000, 1, '12/1/2007');
INSERT INTO person VALUES(2133, 'Eliška', 'Prchalová','F', '61',  44000, 1, '18.7.2005');
INSERT INTO person VALUES(2134, 'Nikola', 'Oláh ','M', '34',  27000, 1, '16/4/2019');
INSERT INTO person VALUES(2135, 'Vlasta', 'Do?kalová','F', '47',  16000, 4, '7.10.2018');
INSERT INTO person VALUES(2136, 'Michal', 'Hejna ','M', '56',  36000, 4, '23/4/2014');
INSERT INTO person VALUES(2137, 'Martina', 'Zelinková','F', '32',  23000, 4, '3.8.2015');
INSERT INTO person VALUES(2138, 'Lud?k', 'Vávra ','M', '33',  45000, 4, '30/4/2009');
INSERT INTO person VALUES(2139, 'Jolana', 'Bartošková','F', '41',  47000, 1, '12.5.2006');
INSERT INTO person VALUES(2140, 'Filip', 'Vojtíšek ','M', '61',  14000, 1, '31/8/2008');
INSERT INTO person VALUES(2141, 'Old?iška', 'Kalinová','F', '48',  27000, 1, '23.11.2011');
INSERT INTO person VALUES(2142, 'Ctibor', 'Petr? ','M', '44',  19000, 1, '10/7/2004');
INSERT INTO person VALUES(2143, 'Ta ána', 'Gregorová','F', '33',  35000, 1, '17.9.2008');
INSERT INTO person VALUES(2144, 'Tomáš', 'Molnár ','M', '20',  28000, 1, '11/12/2015');
INSERT INTO person VALUES(2145, 'Jolana', '?ezní?ková','F', '19',  42000, 4, '14.7.2005');
INSERT INTO person VALUES(2146, 'Dominik', 'Adámek ','M', '42',  37000, 4, '19/12/2010');
INSERT INTO person VALUES(2147, 'Jana', 'Šolcová','F', '27',  30000, 1, '15.9.2012');
INSERT INTO person VALUES(2148, 'Radek', 'Macha? ','M', '24',  42000, 1, '21/4/2010');
INSERT INTO person VALUES(2149, 'Vladislava', 'Hrubešová','F', '58',  30000, 4, '21.11.2007');
INSERT INTO person VALUES(2150, 'Marek', 'Frank ','M', '48',  16000, 4, '29/3/2018');
INSERT INTO person VALUES(2151, 'Jaroslava', 'Pokorná','F', '20',  18000, 1, '23.1.2015');
INSERT INTO person VALUES(2152, 'Josef', 'Králí?ek ','M', '30',  20000, 1, '31/7/2017');
INSERT INTO person VALUES(2153, 'Irena', 'Maršíková','F', '27',  34000, 1, '12.3.2004');
INSERT INTO person VALUES(2154, 'Kristián', 'Kotrba ','M', '59',  26000, 1, '8/6/2013');
INSERT INTO person VALUES(2155, 'Monika', 'Odehnalová','F', '59',  41000, 1, '1.6.2017');
INSERT INTO person VALUES(2156, '?udovít', 'Ve?e?a ','M', '35',  35000, 1, '15/6/2008');
INSERT INTO person VALUES(2157, 'Šárka', 'Zelenková','F', '20',  21000, 1, '20.7.2006');
INSERT INTO person VALUES(2158, 'Boris', 'Buchta ','M', '64',  40000, 1, '24/4/2004');
INSERT INTO person VALUES(2159, 'Marta', 'Holá','F', '52',  29000, 1, '8.10.2019');
INSERT INTO person VALUES(2160, 'Oliver', 'Maršík ','M', '40',  13000, 1, '25/9/2015');
INSERT INTO person VALUES(2161, 'Ji?ina', 'Kozáková','F', '37',  36000, 4, '3.8.2016');
INSERT INTO person VALUES(2162, 'Po?et', 'Jur?ík ','M', '63',  22000, 4, '2/10/2010');
INSERT INTO person VALUES(2163, 'Šárka', 'Zahrádková','F', '44',  16000, 4, '21.9.2005');
INSERT INTO person VALUES(2164, 'Leo', 'Jež ','M', '45',  28000, 4, '11/8/2006');
INSERT INTO person VALUES(2165, 'Diana', 'Bradová','F', '53',  40000, 2, '23.11.2012');
INSERT INTO person VALUES(2166, 'Slavomír', 'Koubek ','M', '27',  32000, 2, '12/12/2005');
INSERT INTO person VALUES(2167, 'Radka', 'Žižková','F', '37',  40000, 4, '29.1.2008');
INSERT INTO person VALUES(2168, 'Mikuláš', 'Vašek ','M', '51',  42000, 4, '20/11/2013');
INSERT INTO person VALUES(2169, 'Vanda', 'Volková','F', '46',  27000, 1, '2.4.2015');
INSERT INTO person VALUES(2170, 'Erik', 'Pivo?ka ','M', '33',  47000, 1, '23/3/2013');
INSERT INTO person VALUES(2171, 'Ilona', 'Žemli?ková','F', '30',  27000, 4, '6.6.2010');
INSERT INTO person VALUES(2172, 'Bronislav', 'Schmidt ','M', '56',  20000, 4, '5/10/2004');
INSERT INTO person VALUES(2173, 'Zlata', 'Sou?ková','F', '38',  15000, 1, '8.8.2017');
INSERT INTO person VALUES(2174, 'Bed?ich', 'Bláha ','M', '38',  25000, 1, '7/2/2004');
INSERT INTO person VALUES(2175, 'Vilma', 'Picková','F', '46',  31000, 2, '26.9.2006');
INSERT INTO person VALUES(2176, 'Lukáš', 'Kova?ík ','M', '21',  30000, 2, '10/5/2016');
INSERT INTO person VALUES(2177, 'Aloisie', 'Be?vá?ová','F', '31',  38000, 1, '23.7.2003');
INSERT INTO person VALUES(2178, 'Bohuslav', 'Homolka ','M', '43',  40000, 1, '18/5/2011');
INSERT INTO person VALUES(2179, 'Dáša', 'Michalcová','F', '62',  46000, 4, '11.10.2016');
INSERT INTO person VALUES(2180, 'Arnošt', 'Sadílek ','M', '20',  13000, 4, '26/5/2006');
INSERT INTO person VALUES(2181, 'Nikola', 'Pluha?ová','F', '25',  34000, 2, '21.7.2007');
INSERT INTO person VALUES(2182, 'René', 'Hlavá?ek ','M', '48',  17000, 2, '26/9/2005');
INSERT INTO person VALUES(2183, 'Aloisie', 'Majerová','F', '55',  33000, 4, '18.2.2019');
INSERT INTO person VALUES(2184, 'Marcel', 'Chlup ','M', '25',  27000, 4, '4/9/2013');
INSERT INTO person VALUES(2185, 'Denisa', 'Vojt?chová','F', '64',  21000, 1, '26.11.2009');
INSERT INTO person VALUES(2186, 'Ivo', 'Maršálek ','M', '53',  32000, 1, '5/1/2013');
INSERT INTO person VALUES(2187, 'Št?pánka', 'Bártová','F', '25',  37000, 2, '9.6.2015');
INSERT INTO person VALUES(2188, 'Maxmilián', 'Balcar ','M', '36',  37000, 2, '13/11/2008');
INSERT INTO person VALUES(2189, 'Vladimíra', 'Šev?íková','F', '56',  45000, 1, '4.4.2012');
INSERT INTO person VALUES(2190, 'Vojt?ch', 'Zv??ina ','M', '58',  46000, 1, '22/11/2003');
INSERT INTO person VALUES(2191, 'Antonie', 'Kle?ková','F', '64',  25000, 2, '16.10.2017');
INSERT INTO person VALUES(2192, 'Zoltán', 'Rác ','M', '41',  16000, 2, '23/2/2016');
INSERT INTO person VALUES(2193, 'Vendula', 'Strouhalová','F', '49',  32000, 1, '12.8.2014');
INSERT INTO person VALUES(2194, 'Miroslav', 'Jedli?ka ','M', '63',  25000, 1, '2/3/2011');
INSERT INTO person VALUES(2195, 'So?a', 'Vorlová','F', '35',  40000, 4, '8.6.2011');
INSERT INTO person VALUES(2196, 'Mat?j', 'Sojka ','M', '40',  34000, 4, '10/3/2006');
INSERT INTO person VALUES(2197, 'Antonie', 'Šebestová','F', '42',  20000, 1, '19.12.2016');
INSERT INTO person VALUES(2198, 'Artur', 'Hron ','M', '23',  39000, 1, '11/6/2018');
INSERT INTO person VALUES(2199, 'Yveta', 'Spurná','F', '50',  44000, 2, '28.9.2007');
INSERT INTO person VALUES(2200, 'Gerhard', 'Stupka ','M', '51',  44000, 2, '12/10/2017');
INSERT INTO person VALUES(2201, 'Nela', 'Peroutková','F', '35',  43000, 1, '27.4.2019');
INSERT INTO person VALUES(2202, 'Walter', 'Matys ','M', '28',  18000, 1, '27/4/2009');
INSERT INTO person VALUES(2203, 'Tatiána', 'Urbanová','F', '43',  31000, 2, '3.2.2010');
INSERT INTO person VALUES(2204, 'Cyril', 'Mina?ík ','M', '56',  22000, 2, '28/8/2008');
INSERT INTO person VALUES(2205, 'Zlatuše', 'Horáková','F', '29',  39000, 1, '30.11.2006');
INSERT INTO person VALUES(2206, 'Herbert', 'Hrbek ','M', '32',  31000, 1, '5/9/2003');
INSERT INTO person VALUES(2207, 'Lenka', 'Kotlárová','F', '36',  19000, 2, '12.6.2012');
INSERT INTO person VALUES(2208, 'Julius', 'Schejbal ','M', '61',  37000, 2, '8/12/2015');
INSERT INTO person VALUES(2209, 'Tatiána', 'Vojtíšková','F', '21',  26000, 1, '8.4.2009');
INSERT INTO person VALUES(2210, 'Július', 'Barák ','M', '38',  46000, 1, '15/12/2010');
INSERT INTO person VALUES(2211, 'Zde?ka', '?eháková','F', '29',  42000, 1, '20.10.2014');
INSERT INTO person VALUES(2212, 'Tadeáš', 'Hána ','M', '20',  15000, 1, '24/10/2006');
INSERT INTO person VALUES(2213, 'V?ra', 'Kubíková','F', '60',  14000, 1, '15.8.2011');
INSERT INTO person VALUES(2214, 'Viliám', 'Stránský ','M', '43',  24000, 1, '26/3/2018');
INSERT INTO person VALUES(2215, 'Markéta', 'Jírová','F', '21',  29000, 1, '25.2.2017');
INSERT INTO person VALUES(2216, 'Vilém', 'Václavík ','M', '26',  30000, 1, '1/2/2014');
INSERT INTO person VALUES(2217, 'Zde?ka', 'Humlová','F', '53',  37000, 1, '22.12.2013');
INSERT INTO person VALUES(2218, 'Matouš', 'Svatoš ','M', '48',  39000, 1, '9/2/2009');
INSERT INTO person VALUES(2219, 'Eliška', '?ervinková','F', '60',  17000, 1, '5.7.2019');
INSERT INTO person VALUES(2220, 'Št?pán', 'Nagy ','M', '31',  44000, 1, '18/12/2004');
INSERT INTO person VALUES(2221, 'And?la', 'Kalousová','F', '23',  41000, 2, '13.4.2010');
INSERT INTO person VALUES(2222, 'Vlastimil', 'Š astný ','M', '59',  13000, 2, '21/4/2004');
INSERT INTO person VALUES(2223, 'Sandra', 'Hradecká','F', '54',  12000, 2, '7.2.2007');
INSERT INTO person VALUES(2224, 'Radomír', 'Jonáš ','M', '35',  22000, 2, '22/9/2015');
INSERT INTO person VALUES(2225, 'Karin', 'Kozáková','F', '61',  28000, 2, '20.8.2012');
INSERT INTO person VALUES(2226, 'Michal', 'Šesták ','M', '64',  27000, 2, '31/7/2011');
INSERT INTO person VALUES(2227, 'Old?iška', 'Suchá','F', '47',  36000, 1, '16.6.2009');
INSERT INTO person VALUES(2228, 'Vladislav', 'Klouda ','M', '41',  36000, 1, '8/8/2006');
INSERT INTO person VALUES(2229, 'Nina', 'Zichová','F', '54',  16000, 2, '28.12.2014');
INSERT INTO person VALUES(2230, 'Nicolas', 'Mat?jí?ek ','M', '24',  42000, 2, '9/11/2018');
INSERT INTO person VALUES(2231, 'Vlastimila', 'Mat?jí?ková','F', '39',  23000, 1, '23.10.2011');
INSERT INTO person VALUES(2232, 'Ivan', 'Brázdil ','M', '46',  15000, 1, '16/11/2013');
INSERT INTO person VALUES(2233, 'Miroslava', 'Podzimková','F', '48',  47000, 2, '25.12.2018');
INSERT INTO person VALUES(2234, 'František', 'Pa?ízek ','M', '28',  19000, 2, '20/3/2013');
INSERT INTO person VALUES(2235, 'Tereza', 'Semerádová','F', '33',  19000, 2, '21.10.2015');
INSERT INTO person VALUES(2236, 'Radim', 'Šimá?ek ','M', '50',  29000, 2, '27/3/2008');
INSERT INTO person VALUES(2237, 'Ludmila', 'Vilímková','F', '19',  26000, 1, '16.8.2012');
INSERT INTO person VALUES(2238, 'Igor', 'Tancoš ','M', '26',  38000, 1, '28/8/2019');
INSERT INTO person VALUES(2239, 'Irena', 'Pelcová','F', '26',  42000, 2, '27.2.2018');
INSERT INTO person VALUES(2240, 'Daniel', 'Holub ','M', '55',  43000, 2, '7/7/2015');
INSERT INTO person VALUES(2241, 'Monika', 'Hromádková','F', '58',  14000, 1, '23.12.2014');
INSERT INTO person VALUES(2242, 'Viktor', 'Hradil ','M', '32',  16000, 1, '14/7/2010');
INSERT INTO person VALUES(2243, 'Lada', 'Peroutková','F', '20',  38000, 2, '1.10.2005');
INSERT INTO person VALUES(2244, 'Bohumil', 'Zv??ina ','M', '60',  21000, 2, '14/11/2009');
INSERT INTO person VALUES(2245, 'Lidmila', 'Šafránková','F', '27',  18000, 3, '14.4.2011');
INSERT INTO person VALUES(2246, '?udovít', 'Rác ','M', '43',  26000, 3, '23/9/2005');
INSERT INTO person VALUES(2247, 'Ivona', 'Kubínová','F', '59',  25000, 2, '8.2.2008');
INSERT INTO person VALUES(2248, 'Stanislav', 'Jedli?ka ','M', '19',  35000, 2, '23/2/2017');
INSERT INTO person VALUES(2249, 'Lada', 'Hradilová','F', '44',  33000, 1, '4.12.2004');
INSERT INTO person VALUES(2250, 'Kamil', 'Sojka ','M', '41',  44000, 1, '2/3/2012');
INSERT INTO person VALUES(2251, 'Diana', 'Urbancová','F', '52',  13000, 2, '17.6.2010');
INSERT INTO person VALUES(2252, 'Po?et', 'Dudek ','M', '24',  14000, 2, '10/1/2008');
INSERT INTO person VALUES(2253, 'Viktorie', 'Rácová','F', '37',  20000, 1, '12.4.2007');
INSERT INTO person VALUES(2254, 'Jind?ich', 'Peroutka ','M', '47',  23000, 1, '12/6/2019');
INSERT INTO person VALUES(2255, 'Vanda', 'Smr?ková','F', '44',  36000, 2, '23.10.2012');
INSERT INTO person VALUES(2256, 'Gejza', 'Matys ','M', '30',  28000, 2, '21/4/2015');
INSERT INTO person VALUES(2257, 'Kristýna', 'Richtrová','F', '53',  24000, 3, '2.8.2003');
INSERT INTO person VALUES(2258, 'Sebastian', 'Mina?ík ','M', '58',  33000, 3, '22/8/2014');
INSERT INTO person VALUES(2259, 'Dagmar', 'Humlová','F', '38',  32000, 2, '21.10.2016');
INSERT INTO person VALUES(2260, 'Ernest', 'Hrbek ','M', '34',  42000, 2, '29/8/2009');
INSERT INTO person VALUES(2261, 'Gabriela', '?ervinková','F', '46',  12000, 3, '9.12.2005');
INSERT INTO person VALUES(2262, 'Nikolas', 'Schejbal ','M', '63',  47000, 3, '8/7/2005');
INSERT INTO person VALUES(2263, 'Olga', 'Vaní?ková','F', '31',  19000, 2, '28.2.2019');
INSERT INTO person VALUES(2264, 'Vladan', 'Barák ','M', '39',  20000, 2, '8/12/2016');
INSERT INTO person VALUES(2265, 'Karolína', 'Hrdá','F', '38',  35000, 2, '17.4.2008');
INSERT INTO person VALUES(2266, 'Andrej', 'Šim?ík ','M', '22',  26000, 2, '16/10/2012');
INSERT INTO person VALUES(2267, 'Nikola', 'Zedníková','F', '24',  43000, 2, '10.2.2005');
INSERT INTO person VALUES(2268, '?ubomír', 'Nová?ek ','M', '44',  35000, 2, '25/10/2007');
INSERT INTO person VALUES(2269, 'Kamila', 'Císa?ová','F', '31',  22000, 2, '24.8.2010');
INSERT INTO person VALUES(2270, 'Svatopluk', 'Václavík ','M', '27',  40000, 2, '2/9/2003');
INSERT INTO person VALUES(2271, 'Denisa', 'Votavová','F', '62',  30000, 2, '20.6.2007');
INSERT INTO person VALUES(2272, 'Jonáš', 'Svatoš ','M', '50',  13000, 2, '2/2/2015');
INSERT INTO person VALUES(2273, 'Nataša', 'Mat?jí?ková','F', '25',  18000, 3, '22.8.2014');
INSERT INTO person VALUES(2274, 'Pavol', 'Hýbl ','M', '32',  18000, 3, '6/6/2014');
INSERT INTO person VALUES(2275, 'Vladimíra', 'Machá?ová','F', '55',  18000, 1, '27.10.2009');
INSERT INTO person VALUES(2276, 'Marián', 'Tvrdík ','M', '55',  28000, 1, '19/12/2005');
INSERT INTO person VALUES(2277, 'Ester', 'Horká','F', '64',  41000, 2, '29.12.2016');
INSERT INTO person VALUES(2278, 'Bohumír', 'Jonáš ','M', '37',  32000, 2, '21/4/2005');
INSERT INTO person VALUES(2279, 'Alžbeta', 'Krištofová','F', '25',  21000, 3, '16.2.2006');
INSERT INTO person VALUES(2280, 'Vojt?ch', 'Doubek ','M', '20',  38000, 3, '24/7/2017');
INSERT INTO person VALUES(2281, 'Regina', 'Kalová','F', '56',  29000, 2, '8.5.2019');
INSERT INTO person VALUES(2282, 'Eduard', 'Pašek ','M', '42',  47000, 2, '31/7/2012');
INSERT INTO person VALUES(2283, 'Beáta', 'Karasová','F', '64',  45000, 3, '25.6.2008');
INSERT INTO person VALUES(2284, 'Miroslav', 'Mat?jí?ek ','M', '25',  16000, 3, '9/6/2008');
INSERT INTO person VALUES(2285, 'Yveta', 'Ma?íková','F', '49',  16000, 2, '20.4.2005');
INSERT INTO person VALUES(2286, 'Mat?j', 'Brázdil ','M', '47',  25000, 2, '10/11/2019');
INSERT INTO person VALUES(2287, 'Bed?iška', 'Muchová','F', '35',  24000, 1, '10.7.2018');
INSERT INTO person VALUES(2288, 'Leoš', 'Diviš ','M', '24',  34000, 1, '17/11/2014');
INSERT INTO person VALUES(2289, 'Beáta', 'Dittrichová','F', '42',  40000, 2, '28.8.2007');
INSERT INTO person VALUES(2290, 'Radek', 'Pelikán ','M', '53',  40000, 2, '26/9/2010');
INSERT INTO person VALUES(2291, 'Kv?ta', 'Mrázová','F', '50',  28000, 3, '30.10.2014');
INSERT INTO person VALUES(2292, 'Petr', 'Kubiš ','M', '35',  44000, 3, '27/1/2010');
INSERT INTO person VALUES(2293, 'Lenka', 'Studená','F', '35',  27000, 2, '4.1.2010');
INSERT INTO person VALUES(2294, 'Josef', 'Vrabec ','M', '58',  18000, 2, '5/1/2018');
INSERT INTO person VALUES(2295, 'Silvie 7300', 'Kulhavá','F', '43',  15000, 3, '8.3.2017');
INSERT INTO person VALUES(2296, 'Vladimir', 'Jane?ek ','M', '40',  23000, 3, '8/5/2017');
INSERT INTO person VALUES(2297, 'Veronika', 'Matoušková','F', '27',  15000, 2, '12.5.2012');
INSERT INTO person VALUES(2298, '?udovít', 'Ka?a ','M', '63',  33000, 2, '20/11/2008');
INSERT INTO person VALUES(2299, 'Bohuslava', 'Hudcová','F', '36',  39000, 3, '15.7.2019');
INSERT INTO person VALUES(2300, 'Július', 'Záruba ','M', '45',  37000, 3, '24/3/2008');
INSERT INTO person VALUES(2301, 'Silvie 7300', 'Skalická','F', '21',  46000, 2, '10.5.2016');
INSERT INTO person VALUES(2302, 'Zd?nek', 'Florián ','M', '22',  46000, 2, '25/8/2019');
INSERT INTO person VALUES(2303, 'Sandra', 'Jaklová','F', '29',  26000, 3, '28.6.2005');
INSERT INTO person VALUES(2304, 'Viliám', 'Kaiser ','M', '51',  16000, 3, '3/7/2015');
INSERT INTO person VALUES(2305, 'Margita', 'He?mánková','F', '60',  34000, 2, '17.9.2018');
INSERT INTO person VALUES(2306, 'Nikola', 'Kratochvíl ','M', '27',  25000, 2, '11/7/2010');
INSERT INTO person VALUES(2307, 'And?la', 'Chmela?ová','F', '21',  14000, 2, '5.11.2007');
INSERT INTO person VALUES(2308, 'Slavomír', 'Horá?ek ','M', '56',  30000, 2, '19/5/2006');
INSERT INTO person VALUES(2309, 'Sandra', 'Poláchová','F', '53',  21000, 2, '31.8.2004');
INSERT INTO person VALUES(2310, 'Róbert', 'Králík ','M', '32',  39000, 2, '19/10/2017');
INSERT INTO person VALUES(2311, 'Helena', 'Michalíková','F', '61',  45000, 3, '2.11.2011');
INSERT INTO person VALUES(2312, 'Ferdinand', 'Bažant ','M', '60',  44000, 3, '20/2/2017');
INSERT INTO person VALUES(2313, 'Barbora', 'Hradilová','F', '23',  25000, 3, '15.5.2017');
INSERT INTO person VALUES(2314, 'Radomír', 'Kameník ','M', '43',  13000, 3, '29/12/2012');
INSERT INTO person VALUES(2315, 'Božena', 'Siváková','F', '54',  32000, 3, '11.3.2014');
INSERT INTO person VALUES(2316, '?estmír', 'Ko?ínek ','M', '19',  22000, 3, '6/1/2008');
INSERT INTO person VALUES(2317, 'Ludmila', 'K?ížková','F', '40',  40000, 2, '5.1.2011');
INSERT INTO person VALUES(2318, 'Imrich', 'Valeš ','M', '42',  32000, 2, '9/6/2019');
INSERT INTO person VALUES(2319, 'Nikol', 'Volná','F', '48',  28000, 3, '9.3.2018');
INSERT INTO person VALUES(2320, 'Bohdan', 'Šim?ík ','M', '24',  36000, 3, '10/10/2018');
INSERT INTO person VALUES(2321, 'Karla', 'Dvorská','F', '33',  36000, 3, '3.1.2015');
INSERT INTO person VALUES(2322, 'Tobiáš', 'Nová?ek ','M', '46',  45000, 3, '17/10/2013');
INSERT INTO person VALUES(2323, 'Adriana', 'Prokopová','F', '41',  15000, 3, '21.2.2004');
INSERT INTO person VALUES(2324, 'Mojmír', 'Václavík ','M', '29',  15000, 3, '26/8/2009');
INSERT INTO person VALUES(2325, 'Magdaléna', 'Fišerová','F', '26',  23000, 2, '11.5.2017');
INSERT INTO person VALUES(2326, 'Kristián', 'Svatoš ','M', '51',  24000, 2, '2/9/2004');
INSERT INTO person VALUES(2327, 'Bronislava', 'Sekaninová','F', '33',  39000, 3, '29.6.2006');
INSERT INTO person VALUES(2328, 'P?emysl', 'Nagy ','M', '34',  29000, 3, '5/12/2016');
INSERT INTO person VALUES(2329, 'Adriana', 'Horská','F', '19',  47000, 2, '18.9.2019');
INSERT INTO person VALUES(2330, 'Leopold', 'Tvrdík ','M', '57',  38000, 2, '13/12/2011');
INSERT INTO person VALUES(2331, 'Petra', 'Dittrichová','F', '27',  34000, 3, '27.6.2010');
INSERT INTO person VALUES(2332, 'Lumír', 'Jonáš ','M', '39',  43000, 3, '15/4/2011');
INSERT INTO person VALUES(2333, 'Laura', 'Remešová','F', '59',  42000, 3, '23.4.2007');
INSERT INTO person VALUES(2334, 'Leo', 'Schmidt ','M', '61',  16000, 3, '22/4/2006');
INSERT INTO person VALUES(2335, 'Michaela', 'Studená','F', '20',  22000, 3, '3.11.2012');
INSERT INTO person VALUES(2336, 'Vratislav', 'Pašek ','M', '44',  21000, 3, '25/7/2018');
INSERT INTO person VALUES(2337, 'Kate?ina', 'Srbová','F', '52',  30000, 3, '29.8.2009');
INSERT INTO person VALUES(2338, 'Mikuláš', 'Kuchta ','M', '20',  30000, 3, '1/8/2013');
INSERT INTO person VALUES(2339, 'Dana', 'Matoušková','F', '59',  45000, 3, '12.3.2015');
INSERT INTO person VALUES(2340, 'Kamil', 'Brázdil ','M', '49',  36000, 3, '10/6/2009');
INSERT INTO person VALUES(2341, 'Michaela', 'Poláková','F', '44',  17000, 2, '6.1.2012');
INSERT INTO person VALUES(2342, 'Erik', 'Diviš ','M', '25',  45000, 2, '17/6/2004');
INSERT INTO person VALUES(2343, 'Kristýna', 'Jurková','F', '52',  33000, 3, '19.7.2017');
INSERT INTO person VALUES(2344, 'Miloš', 'Pelikán ','M', '54',  14000, 3, '18/9/2016');
INSERT INTO person VALUES(2345, 'Dagmar', 'Smolová','F', '37',  40000, 2, '15.5.2014');
INSERT INTO person VALUES(2346, 'Bed?ich', 'Andrle ','M', '31',  23000, 2, '27/9/2011');
INSERT INTO person VALUES(2347, 'Darina', 'He?mánková','F', '46',  28000, 3, '21.2.2005');
INSERT INTO person VALUES(2348, 'Bohuslav', 'Holub ','M', '59',  28000, 3, '28/1/2011');
INSERT INTO person VALUES(2349, 'Jaromíra', 'Chmela?ová','F', '53',  44000, 4, '4.9.2010');
INSERT INTO person VALUES(2350, 'Kevin', 'Jane?ek ','M', '42',  33000, 4, '6/12/2006');
INSERT INTO person VALUES(2351, 'Miluška', 'Poláchová','F', '38',  16000, 3, '30.6.2007');
INSERT INTO person VALUES(2352, 'Libor', 'Homola ','M', '64',  42000, 3, '9/5/2018');
INSERT INTO person VALUES(2353, 'Valerie', 'Doležalová','F', '46',  32000, 4, '10.1.2013');
INSERT INTO person VALUES(2354, 'Vladan', 'Záruba ','M', '47',  12000, 4, '17/3/2014');
INSERT INTO person VALUES(2355, 'Jaromíra', 'Novotná','F', '31',  39000, 3, '6.11.2009');
INSERT INTO person VALUES(2356, 'Václav', 'Florián ','M', '23',  21000, 3, '24/3/2009');
INSERT INTO person VALUES(2357, 'Gertruda', 'Holcová','F', '38',  19000, 3, '20.5.2015');
INSERT INTO person VALUES(2358, 'Norbert', 'Kaiser ','M', '52',  26000, 3, '31/1/2005');
INSERT INTO person VALUES(2359, 'Nataša', 'Sk?ivánková','F', '24',  27000, 3, '15.3.2012');
INSERT INTO person VALUES(2360, 'Maxmilián', 'Kratochvíl ','M', '29',  35000, 3, '3/7/2016');
INSERT INTO person VALUES(2361, 'Zdenka', 'Votrubová','F', '32',  15000, 4, '18.5.2019');
INSERT INTO person VALUES(2362, 'Zoltán', 'Hašek ','M', '57',  40000, 4, '5/11/2015');
INSERT INTO person VALUES(2363, 'Ester', 'Št?pánová','F', '63',  14000, 3, '23.7.2014');
INSERT INTO person VALUES(2364, 'Vasil', 'Králík ','M', '34',  14000, 3, '20/5/2007');
INSERT INTO person VALUES(2365, 'Daniela', 'Vondrová','F', '25',  38000, 4, '30.4.2005');
INSERT INTO person VALUES(2366, 'Radomil', 'Bažant ','M', '62',  18000, 4, '20/9/2006');
INSERT INTO person VALUES(2367, 'Regina', 'Jánská','F', '55',  38000, 2, '28.11.2016');
INSERT INTO person VALUES(2368, 'Albert', 'Stoklasa ','M', '39',  28000, 2, '29/8/2014');
INSERT INTO person VALUES(2369, 'Anežka', 'Braunová','F', '64',  25000, 4, '7.9.2007');
INSERT INTO person VALUES(2370, 'Oto', 'Ko?ínek ','M', '21',  33000, 4, '30/12/2013');
INSERT INTO person VALUES(2371, 'Sabina', 'Janá?ková','F', '25',  41000, 4, '20.3.2013');
INSERT INTO person VALUES(2372, 'Eduard', 'Ondrá?ek ','M', '50',  38000, 4, '8/11/2009');
INSERT INTO person VALUES(2373, 'Mária', 'Foltýnová','F', '57',  13000, 3, '14.1.2010');
INSERT INTO person VALUES(2374, 'Juraj', 'Fridrich ','M', '26',  47000, 3, '15/11/2004');
INSERT INTO person VALUES(2375, 'Anežka', 'Gajdošová','F', '42',  21000, 3, '10.11.2006');
INSERT INTO person VALUES(2376, 'Cyril', 'Janota ','M', '49',  20000, 3, '17/4/2016');
INSERT INTO person VALUES(2377, 'Kv?ta', 'Havlová','F', '49',  36000, 3, '23.5.2012');
INSERT INTO person VALUES(2378, 'Marian', 'Ho?ejší ','M', '32',  26000, 3, '25/2/2012');
INSERT INTO person VALUES(2379, 'Renáta', 'Müllerová','F', '35',  44000, 3, '18.3.2009');
INSERT INTO person VALUES(2380, 'Julius', 'N?me?ek ','M', '54',  35000, 3, '4/3/2007');
INSERT INTO person VALUES(2381, 'Sára', 'Hrbá?ková','F', '42',  24000, 3, '29.9.2014');
INSERT INTO person VALUES(2382, 'Štefan', 'Brabec ','M', '37',  40000, 3, '5/6/2019');
INSERT INTO person VALUES(2383, 'Natalie', 'Neradová','F', '50',  12000, 4, '8.7.2005');
INSERT INTO person VALUES(2384, 'Patrik', 'Vo?íšek ','M', '19',  45000, 4, '7/10/2018');
INSERT INTO person VALUES(2385, 'Miriam', 'Grygarová','F', '36',  19000, 4, '27.9.2018');
INSERT INTO person VALUES(2386, 'Vilém', 'Dosko?il ','M', '41',  18000, 4, '14/10/2013');
INSERT INTO person VALUES(2387, 'Hana', 'Švábová','F', '43',  35000, 4, '15.11.2007');
INSERT INTO person VALUES(2388, 'Jakub', 'Paul ','M', '24',  23000, 4, '22/8/2009');
INSERT INTO person VALUES(2389, 'Zita', 'Bedna?íková','F', '29',  43000, 3, '10.9.2004');
INSERT INTO person VALUES(2390, 'Vít', 'Majer ','M', '46',  32000, 3, '30/8/2004');
INSERT INTO person VALUES(2391, 'Jitka', 'Hrubá','F', '36',  23000, 4, '24.3.2010');
INSERT INTO person VALUES(2392, 'Svatoslav', 'Hanzlík ','M', '29',  38000, 4, '1/12/2016');
INSERT INTO person VALUES(2393, 'Anna', 'Moravcová','F', '21',  30000, 3, '17.1.2007');
INSERT INTO person VALUES(2394, 'Vlastimil', 'Vorel ','M', '52',  47000, 3, '10/12/2011');
INSERT INTO person VALUES(2395, 'Božena', 'Kazdová','F', '29',  46000, 4, '30.7.2012');
INSERT INTO person VALUES(2396, 'Stepan', 'Fo?t ','M', '35',  16000, 4, '18/10/2007');
INSERT INTO person VALUES(2397, 'Helena', 'Pe?inová','F', '60',  18000, 3, '26.5.2009');
INSERT INTO person VALUES(2398, 'Vladimír', 'Kubica ','M', '57',  25000, 3, '20/3/2019');
INSERT INTO person VALUES(2399, 'Leona', 'Macáková','F', '23',  42000, 4, '28.7.2016');
INSERT INTO person VALUES(2400, 'Nicolas', 'Plachý ','M', '39',  30000, 4, '22/7/2018');
INSERT INTO person VALUES(2401, 'Božena', 'Šímová','F', '53',  41000, 3, '3.10.2011');
INSERT INTO person VALUES(2402, 'Ernest', 'Žá?ek ','M', '62',  40000, 3, '3/2/2010');
INSERT INTO person VALUES(2403, 'Dita', 'Horvátová','F', '61',  29000, 4, '5.12.2018');
INSERT INTO person VALUES(2404, 'Oskar', 'Holoubek ','M', '44',  44000, 4, '6/6/2009');
INSERT INTO person VALUES(2405, 'Jindra', 'Poláková','F', '23',  45000, 4, '23.1.2008');
INSERT INTO person VALUES(2406, '?estmír', 'Šimánek ','M', '27',  14000, 4, '15/4/2005');
INSERT INTO person VALUES(2407, 'Elena', 'Benešová','F', '54',  17000, 4, '18.11.2004');
INSERT INTO person VALUES(2408, 'Imrich', 'Doležal ','M', '50',  23000, 4, '15/9/2016');
INSERT INTO person VALUES(2409, 'Ema', 'Smolová','F', '61',  32000, 4, '1.6.2010');
INSERT INTO person VALUES(2410, 'Arnošt', 'Nguyen ','M', '32',  28000, 4, '25/7/2012');
INSERT INTO person VALUES(2411, 'Michala', 'Schejbalová','F', '47',  40000, 4, '27.3.2007');
INSERT INTO person VALUES(2412, 'Ondrej', 'Zelený ','M', '55',  37000, 4, '2/8/2007');
INSERT INTO person VALUES(2413, 'Johana', 'Jílková','F', '54',  20000, 4, '7.10.2012');
INSERT INTO person VALUES(2414, 'Marcel', 'Vondra ','M', '38',  43000, 4, '3/11/2019');
INSERT INTO person VALUES(2415, 'Ema', 'Hladíková','F', '40',  27000, 3, '3.8.2009');
INSERT INTO person VALUES(2416, 'Pavol', 'Pohl ','M', '60',  16000, 3, '11/11/2014');
INSERT INTO person VALUES(2417, 'Iveta', 'Spá?ilová','F', '48',  15000, 1, '5.10.2016');
INSERT INTO person VALUES(2418, 'Bohumir', 'B?ezina ','M', '42',  20000, 1, '14/3/2014');
INSERT INTO person VALUES(2419, 'Tamara', 'Fuksová','F', '32',  15000, 3, '11.12.2011');
INSERT INTO person VALUES(2420, 'Bohumír', 'Veselý ','M', '19',  30000, 3, '26/9/2005');
INSERT INTO person VALUES(2421, 'Adéla', 'Chlupová','F', '41',  39000, 4, '12.2.2019');
INSERT INTO person VALUES(2422, 'Emil', 'Zach ','M', '47',  35000, 4, '28/1/2005');
INSERT INTO person VALUES(2423, 'Marika', 'Vítová','F', '25',  38000, 3, '18.4.2014');
INSERT INTO person VALUES(2424, 'Eduard', 'Kola?ík ','M', '25',  45000, 3, '5/1/2013');
INSERT INTO person VALUES(2425, 'Aneta', 'Fu?íková','F', '34',  26000, 4, '25.1.2005');
INSERT INTO person VALUES(2426, 'Robert', 'Žemli?ka ','M', '53',  13000, 4, '8/5/2012');
INSERT INTO person VALUES(2427, 'Adéla', 'Smolková','F', '19',  34000, 4, '16.4.2018');
INSERT INTO person VALUES(2428, 'Radovan', 'Švec ','M', '29',  22000, 4, '17/5/2007');
INSERT INTO person VALUES(2429, 'Drahomíra', 'Špa?ková','F', '26',  14000, 4, '4.6.2007');
INSERT INTO person VALUES(2430, 'Antonín', 'Ková? ','M', '58',  28000, 4, '18/8/2019');
INSERT INTO person VALUES(2431, 'Romana', 'Kubí?ková','F', '58',  21000, 3, '30.3.2004');
INSERT INTO person VALUES(2432, 'Jozef', 'Machala ','M', '34',  37000, 3, '26/8/2014');
INSERT INTO person VALUES(2433, 'Ladislava', 'Pohlová','F', '19',  37000, 4, '11.10.2009');
INSERT INTO person VALUES(2434, 'Petr', 'Synek ','M', '63',  42000, 4, '4/7/2010');
INSERT INTO person VALUES(2435, 'Drahomíra', 'Raková','F', '50',  45000, 3, '7.8.2006');
INSERT INTO person VALUES(2436, 'Lubomír', 'Šenk ','M', '39',  15000, 3, '11/7/2005');
INSERT INTO person VALUES(2437, 'Kristina', 'Bauerová','F', '58',  25000, 4, '18.2.2012');
INSERT INTO person VALUES(2438, 'Vladimir', 'Krištof ','M', '22',  21000, 4, '13/10/2017');
INSERT INTO person VALUES(2439, 'Radana', 'Gajdošová','F', '20',  13000, 1, '21.4.2019');
INSERT INTO person VALUES(2440, 'Juliús', 'Lukáš ','M', '50',  25000, 1, '13/2/2017');
INSERT INTO person VALUES(2441, 'Magdaléna', 'Kršková','F', '50',  12000, 4, '26.6.2014');
INSERT INTO person VALUES(2442, 'Július', 'Mrázek ','M', '28',  35000, 4, '29/8/2008');
INSERT INTO person VALUES(2443, 'Laura', 'Müllerová','F', '59',  36000, 1, '4.4.2005');
INSERT INTO person VALUES(2444, 'Viliam', 'Orság ','M', '56',  40000, 1, '31/12/2007');
INSERT INTO person VALUES(2445, 'Nicole', 'Hrušková','F', '44',  44000, 4, '24.6.2018');
INSERT INTO person VALUES(2446, 'Bruno', 'Levý ','M', '32',  13000, 4, '2/6/2019');
INSERT INTO person VALUES(2447, 'Petra', 'Hušková','F', '52',  23000, 4, '12.8.2007');
INSERT INTO person VALUES(2448, 'Matouš', 'Mazánek ','M', '61',  18000, 4, '11/4/2015');
INSERT INTO person VALUES(2449, 'Brigita', 'Slaninová','F', '37',  31000, 4, '7.6.2004');
INSERT INTO person VALUES(2450, 'Hubert', 'Mráz ','M', '37',  27000, 4, '18/4/2010');
INSERT INTO person VALUES(2451, 'Michaela', 'Slezáková','F', '44',  47000, 4, '19.12.2009');
INSERT INTO person VALUES(2452, 'Hynek', 'Mare?ek ','M', '20',  33000, 4, '24/2/2006');
INSERT INTO person VALUES(2453, 'Kate?ina', 'Tomková','F', '30',  19000, 4, '14.10.2006');
INSERT INTO person VALUES(2454, 'Ferdinand', 'Foltýn ','M', '43',  42000, 4, '28/7/2017');
INSERT INTO person VALUES(2455, 'Dagmar', 'Škrabalová','F', '37',  34000, 4, '26.4.2012');
INSERT INTO person VALUES(2456, 'Radomír', 'Skácel ','M', '25',  47000, 4, '5/6/2013');
INSERT INTO person VALUES(2457, 'Jarmila', '?ehá?ková','F', '23',  42000, 3, '20.2.2009');
INSERT INTO person VALUES(2458, '?estmír', 'Severa ','M', '48',  20000, 3, '12/6/2008');
INSERT INTO person VALUES(2459, 'Terezie', 'Ková?ová','F', '31',  30000, 1, '24.4.2016');
INSERT INTO person VALUES(2460, 'Kryštof', 'Seidl ','M', '30',  25000, 1, '15/10/2007');
INSERT INTO person VALUES(2461, 'Miluška', 'Pe?inová','F', '38',  46000, 1, '12.6.2005');
INSERT INTO person VALUES(2462, 'Ivan', 'Van??ek ','M', '59',  30000, 1, '23/8/2003');
INSERT INTO person VALUES(2463, 'Svatava', 'Hoffmannová','F', '24',  17000, 4, '1.9.2018');
INSERT INTO person VALUES(2464, 'Ludvík', 'Jiroušek ','M', '35',  39000, 4, '24/1/2015');
INSERT INTO person VALUES(2465, 'Josefa', 'Dokoupilová','F', '55',  25000, 4, '27.6.2015');
INSERT INTO person VALUES(2466, 'Mojmír', 'Kubánek ','M', '57',  12000, 4, '31/1/2010');
INSERT INTO person VALUES(2467, 'Miluška', 'B?ezinová','F', '63',  41000, 4, '14.8.2004');
INSERT INTO person VALUES(2468, 'Richard', 'Male?ek ','M', '40',  18000, 4, '9/12/2005');
INSERT INTO person VALUES(2469, 'Svatava', 'Hrdli?ková','F', '48',  12000, 4, '3.11.2017');
INSERT INTO person VALUES(2470, 'P?emysl', 'Pech ','M', '63',  27000, 4, '12/5/2017');
INSERT INTO person VALUES(2471, 'Zdena', 'Mirgová','F', '55',  28000, 4, '22.12.2006');
INSERT INTO person VALUES(2472, 'Miloslav', 'Šubrt ','M', '46',  32000, 4, '20/3/2013');
INSERT INTO person VALUES(2473, 'Pavla', 'Jíchová','F', '64',  16000, 1, '23.2.2014');
INSERT INTO person VALUES(2474, 'Pavel', 'Knap ','M', '28',  37000, 1, '21/7/2012');
INSERT INTO person VALUES(2475, 'Zuzana', 'Zdráhalová','F', '49',  24000, 1, '20.12.2010');
INSERT INTO person VALUES(2476, 'Bohumil', 'Vítek ','M', '50',  46000, 1, '30/7/2007');
INSERT INTO person VALUES(2477, 'Zdenka', 'Pecková','F', '57',  40000, 1, '2.7.2016');
INSERT INTO person VALUES(2478, 'Rastislav', 'P?ibyl ','M', '33',  15000, 1, '31/10/2019');
INSERT INTO person VALUES(2479, 'Pavla', 'Brychtová','F', '42',  47000, 4, '28.4.2013');
INSERT INTO person VALUES(2480, 'Roman', 'Ferenc ','M', '55',  24000, 4, '7/11/2014');
INSERT INTO person VALUES(2481, 'Iva', 'Hanáková','F', '49',  27000, 1, '9.11.2018');
INSERT INTO person VALUES(2482, 'Ervín', 'Fischer ','M', '38',  30000, 1, '16/9/2010');
INSERT INTO person VALUES(2483, 'Milada', 'Tomášková','F', '35',  35000, 4, '4.9.2015');
INSERT INTO person VALUES(2484, 'Ji?í', 'Sladký ','M', '60',  39000, 4, '23/9/2005');
INSERT INTO person VALUES(2485, 'Vlastimila', 'Ferencová','F', '43',  23000, 1, '13.6.2006');
INSERT INTO person VALUES(2486, 'Gejza', 'Zají?ek ','M', '42',  44000, 1, '24/1/2005');
INSERT INTO person VALUES(2487, 'Iva', 'Vorá?ková','F', '27',  22000, 4, '11.1.2018');
INSERT INTO person VALUES(2488, 'Vojtech', 'Šev?ík ','M', '20',  17000, 4, '2/1/2013');
INSERT INTO person VALUES(2489, 'Žofie', 'Pohanková','F', '36',  46000, 1, '20.10.2008');
INSERT INTO person VALUES(2490, 'Sebastian', 'Zlámal ','M', '48',  22000, 1, '5/5/2012');
INSERT INTO person VALUES(2491, 'Emilie', 'Dudová','F', '20',  46000, 4, '26.12.2003');
INSERT INTO person VALUES(2492, 'Juliús', 'Ludvík ','M', '25',  32000, 4, '19/11/2003');
INSERT INTO person VALUES(2493, 'Patricie', 'He?manová','F', '29',  33000, 1, '27.2.2011');
INSERT INTO person VALUES(2494, 'Nikolas', 'Semerád ','M', '53',  36000, 1, '15/8/2019');
INSERT INTO person VALUES(2495, 'Ema', 'Boušková','F', '60',  41000, 4, '23.12.2007');
INSERT INTO person VALUES(2496, 'Vladan', 'Mrázek ','M', '29',  46000, 4, '22/8/2014');
INSERT INTO person VALUES(2497, 'Oksana', 'Jane?ková','F', '21',  21000, 1, '5.7.2013');
INSERT INTO person VALUES(2498, 'Tibor', 'Komárek ','M', '58',  15000, 1, '1/7/2010');
INSERT INTO person VALUES(2499, 'Johana', 'Krej?ová','F', '53',  29000, 4, '1.5.2010');
INSERT INTO person VALUES(2500, 'Norbert', 'Cibulka ','M', '35',  24000, 4, '8/7/2005');
INSERT INTO person VALUES(2501, 'Bára', 'Nagyová','F', '60',  44000, 1, '12.11.2015');
INSERT INTO person VALUES(2502, 'Denis', 'Oláh ','M', '64',  29000, 1, '10/10/2017');
INSERT INTO person VALUES(2503, 'Yvona', 'Bartošková','F', '46',  16000, 4, '7.9.2012');
INSERT INTO person VALUES(2504, 'Dan', 'Hejna ','M', '40',  38000, 4, '17/10/2012');
INSERT INTO person VALUES(2505, 'Zita', 'Kalinová','F', '53',  32000, 4, '21.3.2018');
INSERT INTO person VALUES(2506, 'Dalibor', 'Sommer ','M', '23',  44000, 4, '25/8/2008');
INSERT INTO person VALUES(2507, 'Magdalena', 'Šafa?íková','F', '61',  20000, 2, '28.12.2008');
INSERT INTO person VALUES(2508, 'Rostislav', 'Lang ','M', '51',  12000, 2, '28/12/2007');
INSERT INTO person VALUES(2509, 'Danuše', 'Tomášová','F', '47',  27000, 1, '23.10.2005');
INSERT INTO person VALUES(2510, 'Bohumír', 'Skácel ','M', '27',  22000, 1, '30/5/2019');
INSERT INTO person VALUES(2511, 'Hedvika', 'Marešová','F', '54',  43000, 1, '6.5.2011');
INSERT INTO person VALUES(2512, 'Jaromír', 'Široký ','M', '56',  27000, 1, '7/4/2015');
INSERT INTO person VALUES(2513, 'Magdalena', 'Blažková','F', '40',  15000, 1, '1.3.2008');
INSERT INTO person VALUES(2514, 'Eduard', 'Dittrich ','M', '32',  36000, 1, '15/4/2010');
INSERT INTO person VALUES(2515, 'Nikol', 'Hartmanová','F', '47',  31000, 1, '12.9.2013');
INSERT INTO person VALUES(2516, 'Tomáš', 'Otáhal ','M', '61',  41000, 1, '21/2/2006');
INSERT INTO person VALUES(2517, 'Karla', 'Maršíková','F', '32',  38000, 1, '9.7.2010');
INSERT INTO person VALUES(2518, 'Dominik', 'Jirásek ','M', '38',  14000, 1, '24/7/2017');
INSERT INTO person VALUES(2519, 'Radana', 'Vitásková','F', '41',  26000, 2, '10.9.2017');
INSERT INTO person VALUES(2520, 'Radek', 'Jan? ','M', '20',  19000, 2, '25/11/2016');
INSERT INTO person VALUES(2521, 'Nikol', 'Válková','F', '25',  26000, 4, '15.11.2012');
INSERT INTO person VALUES(2522, 'Marek', 'Tóth ','M', '43',  29000, 4, '9/6/2008');
INSERT INTO person VALUES(2523, 'Iryna', 'Maršálková','F', '34',  14000, 2, '25.8.2003');
INSERT INTO person VALUES(2524, 'Petr', 'Dušek ','M', '25',  34000, 2, '11/10/2007');
INSERT INTO person VALUES(2525, 'Adriana', 'Vysloužilová','F', '64',  13000, 4, '24.3.2015');
INSERT INTO person VALUES(2526, 'Pavel', 'Hána ','M', '48',  43000, 4, '19/9/2015');
INSERT INTO person VALUES(2527, 'Petra', 'Králí?ková','F', '26',  37000, 1, '31.12.2005');
INSERT INTO person VALUES(2528, 'Vladimir', 'Votava ','M', '30',  12000, 1, '20/1/2015');
INSERT INTO person VALUES(2529, 'Laura', 'Gi?ová','F', '58',  45000, 1, '22.3.2019');
INSERT INTO person VALUES(2530, 'Jakub', 'Skopal ','M', '52',  21000, 1, '27/1/2010');
INSERT INTO person VALUES(2531, 'Ivana', 'Matyášová','F', '19',  25000, 1, '9.5.2008');
INSERT INTO person VALUES(2532, 'J?lius', 'Pernica ','M', '35',  26000, 1, '6/12/2005');
INSERT INTO person VALUES(2533, 'Petra', 'Volková','F', '51',  32000, 1, '5.3.2005');
INSERT INTO person VALUES(2534, 'Svatoslav', 'Sobek ','M', '58',  36000, 1, '8/5/2017');
INSERT INTO person VALUES(2535, 'Dana', 'Je?ábková','F', '58',  12000, 1, '16.9.2010');
INSERT INTO person VALUES(2536, 'Leo', 'Mareš ','M', '41',  41000, 1, '17/3/2013');
INSERT INTO person VALUES(2537, 'Michaela', 'Sou?ková','F', '43',  20000, 4, '12.7.2007');
INSERT INTO person VALUES(2538, 'Stepan', 'Kubín ','M', '63',  14000, 4, '24/3/2008');
INSERT INTO person VALUES(2539, 'Andrea', 'Picková','F', '51',  35000, 1, '22.1.2013');
INSERT INTO person VALUES(2540, 'Mikuláš', 'Šesták ','M', '46',  19000, 1, '1/2/2004');
INSERT INTO person VALUES(2541, 'Maria', 'Gajdošíková','F', '59',  23000, 2, '1.11.2003');
INSERT INTO person VALUES(2542, 'Hynek', 'Jur?ík ','M', '28',  24000, 2, '28/10/2019');
INSERT INTO person VALUES(2543, 'Darina', 'Ju?íková','F', '44',  31000, 1, '20.1.2017');
INSERT INTO person VALUES(2544, 'Ferdinand', 'Hanák ','M', '50',  33000, 1, '4/11/2014');
INSERT INTO person VALUES(2545, 'Karolina', 'Provazníková','F', '52',  47000, 2, '10.3.2006');
INSERT INTO person VALUES(2546, 'Otakar', 'Dohnal ','M', '33',  38000, 2, '13/9/2010');
INSERT INTO person VALUES(2547, 'Maria', 'Jahodová','F', '37',  18000, 1, '30.5.2019');
INSERT INTO person VALUES(2548, '?estmír', 'Pospíchal ','M', '56',  12000, 1, '20/9/2005');
INSERT INTO person VALUES(2549, 'Valerie', 'Beránková','F', '44',  34000, 2, '17.7.2008');
INSERT INTO person VALUES(2550, 'Bohuslav', 'Jahoda ','M', '39',  17000, 2, '22/12/2017');
INSERT INTO person VALUES(2551, 'Jaromíra', 'T?mová','F', '30',  42000, 1, '13.5.2005');
INSERT INTO person VALUES(2552, 'Arnošt', 'Farkaš ','M', '61',  26000, 1, '30/12/2012');
INSERT INTO person VALUES(2553, 'Eliška', 'Pr?šová','F', '38',  30000, 2, '14.7.2012');
INSERT INTO person VALUES(2554, 'René', 'Bauer ','M', '43',  31000, 2, '2/5/2012');
INSERT INTO person VALUES(2555, 'Vlasta', 'Janí?ková','F', '24',  37000, 2, '10.5.2009');
INSERT INTO person VALUES(2556, 'Mykola', 'Oláh ','M', '19',  40000, 2, '10/5/2007');
INSERT INTO person VALUES(2557, 'Klára', 'Riedlová','F', '31',  17000, 2, '21.11.2014');
INSERT INTO person VALUES(2558, 'Richard', 'Berger ','M', '48',  45000, 2, '12/8/2019');
INSERT INTO person VALUES(2559, 'Eliška', 'Kuchtová','F', '63',  25000, 1, '17.9.2011');
INSERT INTO person VALUES(2560, 'Bohumir', 'Sommer ','M', '24',  18000, 1, '19/8/2014');
INSERT INTO person VALUES(2561, 'Daniela', 'Šustrová','F', '24',  41000, 2, '30.3.2017');
INSERT INTO person VALUES(2562, 'Miloslav', 'Kolman ','M', '53',  24000, 2, '27/6/2010');
INSERT INTO person VALUES(2563, 'Zdenka', 'Spurná','F', '55',  12000, 1, '24.1.2014');
INSERT INTO person VALUES(2564, 'Emil', '?apek ','M', '30',  33000, 1, '5/7/2005');
INSERT INTO person VALUES(2565, 'Karin', 'Holoubková','F', '64',  36000, 2, '1.11.2004');
INSERT INTO person VALUES(2566, 'Luboš', 'Doubrava ','M', '58',  37000, 2, '5/11/2004');
INSERT INTO person VALUES(2567, 'Daniela', 'Urbanová','F', '48',  36000, 1, '1.6.2016');
INSERT INTO person VALUES(2568, 'Robert', 'Van?ura ','M', '35',  47000, 1, '14/10/2012');
INSERT INTO person VALUES(2569, 'Ingrid', 'Smolíková','F', '57',  24000, 2, '11.3.2007');
INSERT INTO person VALUES(2570, 'Ond?ej', 'Otáhal ','M', '63',  16000, 2, '15/2/2012');
INSERT INTO person VALUES(2571, 'Anežka', 'Kotlárová','F', '41',  23000, 1, '9.10.2018');
INSERT INTO person VALUES(2572, 'Antonín', 'Pavl? ','M', '40',  26000, 1, '30/8/2003');
INSERT INTO person VALUES(2573, 'Patricie', 'Klou?ková','F', '49',  47000, 2, '18.7.2009');
INSERT INTO person VALUES(2574, 'Jan', 'Bo?ek ','M', '22',  30000, 2, '27/5/2019');
INSERT INTO person VALUES(2575, 'Radomíra', 'Šolcová','F', '57',  27000, 2, '29.1.2015');
INSERT INTO person VALUES(2576, 'Gabriel', '?onka ','M', '51',  36000, 2, '4/4/2015');
INSERT INTO person VALUES(2577, 'Na?a', 'Dolejšová','F', '42',  35000, 2, '25.11.2011');
INSERT INTO person VALUES(2578, 'Vojtech', 'Hor?ák ','M', '27',  45000, 2, '11/4/2010');
INSERT INTO person VALUES(2579, 'Patricie', 'Janovská','F', '28',  42000, 1, '19.9.2008');
INSERT INTO person VALUES(2580, 'Ladislav', 'Hána ','M', '50',  18000, 1, '19/4/2005');
INSERT INTO person VALUES(2581, 'Miriam', 'Vobo?ilová','F', '35',  22000, 2, '2.4.2014');
INSERT INTO person VALUES(2582, 'Juliús', 'Vilímek ','M', '33',  23000, 2, '21/7/2017');
INSERT INTO person VALUES(2583, 'Oksana', 'Hornová','F', '20',  30000, 1, '27.1.2011');
INSERT INTO person VALUES(2584, 'Prokop', 'Pet?ík ','M', '55',  32000, 1, '28/7/2012');
INSERT INTO person VALUES(2585, 'Natalie', 'Karlíková','F', '28',  45000, 1, '9.8.2016');
INSERT INTO person VALUES(2586, 'Viliam', 'Koš ál ','M', '38',  38000, 1, '6/6/2008');
INSERT INTO person VALUES(2587, 'Dominika', 'Špi?ková','F', '36',  33000, 3, '19.5.2007');
INSERT INTO person VALUES(2588, 'Anton', 'Kliment ','M', '20',  42000, 3, '8/10/2007');
INSERT INTO person VALUES(2589, 'Anna', 'Kozáková','F', '20',  33000, 1, '17.12.2018');
INSERT INTO person VALUES(2590, 'Matouš', 'Tomeš ','M', '43',  16000, 1, '16/9/2015');
INSERT INTO person VALUES(2591, 'Kv?tuše', 'Jakubcová','F', '29',  21000, 2, '25.9.2009');
INSERT INTO person VALUES(2592, 'Denis', 'Richter ','M', '25',  21000, 2, '17/1/2015');
INSERT INTO person VALUES(2593, 'Dominika', 'Brázdová','F', '60',  28000, 2, '21.7.2006');
INSERT INTO person VALUES(2594, 'Karol', 'Šesták ','M', '48',  30000, 2, '24/1/2010');
INSERT INTO person VALUES(2595, 'Leona', 'Jurásková','F', '22',  44000, 2, '1.2.2012');
INSERT INTO person VALUES(2596, 'Dalibor', 'Krej?ík ','M', '31',  35000, 2, '3/12/2005');
INSERT INTO person VALUES(2597, 'Hedvika', 'Podzimková','F', '53',  16000, 2, '27.11.2008');
INSERT INTO person VALUES(2598, 'Radoslav', 'Kurka ','M', '53',  44000, 2, '5/5/2017');
INSERT INTO person VALUES(2599, 'Vladislava', 'Mi?ková','F', '60',  32000, 2, '10.6.2014');
INSERT INTO person VALUES(2600, 'Lud?k', 'Vav?ík ','M', '36',  14000, 2, '13/3/2013');
INSERT INTO person VALUES(2601, 'Nikol', 'Andrlová','F', '46',  39000, 1, '6.4.2011');
INSERT INTO person VALUES(2602, 'Kryštof', 'Vl?ek ','M', '58',  23000, 1, '21/3/2008');
INSERT INTO person VALUES(2603, 'Elena', 'N?me?ková','F', '53',  19000, 2, '17.10.2016');
INSERT INTO person VALUES(2604, 'Ivan', 'Brož ','M', '41',  28000, 2, '28/1/2004');
INSERT INTO person VALUES(2605, 'Dita', 'Vítková','F', '38',  27000, 1, '13.8.2013');
INSERT INTO person VALUES(2606, 'Ludvík', 'Schneider ','M', '63',  37000, 1, '1/7/2015');
INSERT INTO person VALUES(2607, 'Jindra', 'Hejduková','F', '46',  43000, 2, '24.2.2019');
INSERT INTO person VALUES(2608, 'Zden?k', 'Šime?ek ','M', '46',  42000, 2, '9/5/2011');
INSERT INTO person VALUES(2609, 'Marta', 'Pluha?ová','F', '54',  31000, 3, '3.12.2009');
INSERT INTO person VALUES(2610, 'Boleslav', 'Kuchta ','M', '28',  47000, 3, '9/9/2010');
INSERT INTO person VALUES(2611, 'Ji?ina', 'Švestková','F', '40',  38000, 2, '28.9.2006');
INSERT INTO person VALUES(2612, 'Marek', 'Charvát ','M', '51',  20000, 2, '17/9/2005');
INSERT INTO person VALUES(2613, 'Iveta', 'Vojt?chová','F', '47',  18000, 3, '10.4.2012');
INSERT INTO person VALUES(2614, 'Mario', 'Št?rba ','M', '34',  26000, 3, '19/12/2017');
INSERT INTO person VALUES(2615, 'Libuše', '?erníková','F', '32',  26000, 2, '4.2.2009');
INSERT INTO person VALUES(2616, 'Pavel', 'Kaplan ','M', '56',  35000, 2, '26/12/2012');
INSERT INTO person VALUES(2617, 'Radka', 'Burešová','F', '40',  41000, 2, '18.8.2014');
INSERT INTO person VALUES(2618, 'Lubor', 'Ková?ík ','M', '39',  40000, 2, '4/11/2008');
INSERT INTO person VALUES(2619, 'Iveta', 'Št?pánková','F', '25',  13000, 2, '14.6.2011');
INSERT INTO person VALUES(2620, 'Rastislav', 'Luká? ','M', '61',  13000, 2, '12/11/2003');
INSERT INTO person VALUES(2621, 'Aneta', 'Strouhalová','F', '32',  29000, 2, '25.12.2016');
INSERT INTO person VALUES(2622, 'Ota', 'Vitásek ','M', '44',  18000, 2, '14/2/2016');
INSERT INTO person VALUES(2623, 'Adéla', 'Vorlová','F', '64',  37000, 2, '20.10.2013');
INSERT INTO person VALUES(2624, 'Ervín', '?ehák ','M', '20',  28000, 2, '21/2/2011');
INSERT INTO person VALUES(2625, 'Danuše', 'Šebestová','F', '25',  16000, 2, '3.5.2019');
INSERT INTO person VALUES(2626, 'Vlastislav', 'Mikeš ','M', '49',  33000, 2, '30/12/2006');
INSERT INTO person VALUES(2627, 'Aneta', 'Trnková','F', '57',  24000, 1, '27.2.2016');
INSERT INTO person VALUES(2628, 'Gabriel', 'Míka ','M', '26',  42000, 1, '2/6/2018');
INSERT INTO person VALUES(2629, 'Dáša', 'Slováková','F', '19',  12000, 3, '6.12.2006');
INSERT INTO person VALUES(2630, 'Mikuláš', 'Vícha ','M', '54',  47000, 3, '3/10/2017');
INSERT INTO person VALUES(2631, 'Karolina', 'Slaví?ková','F', '51',  19000, 2, '2.10.2003');
INSERT INTO person VALUES(2632, 'Sebastian', 'Ondrá?ek ','M', '30',  20000, 2, '10/10/2012');
INSERT INTO person VALUES(2633, 'R?žena', 'Zahrádková','F', '59',  43000, 3, '4.12.2010');
INSERT INTO person VALUES(2634, 'Emanuel', 'Peroutka ','M', '58',  24000, 3, '11/2/2012');
INSERT INTO person VALUES(2635, 'Valerie', 'Rysová','F', '43',  43000, 2, '8.2.2006');
INSERT INTO person VALUES(2636, 'Nikolas', 'Houška ','M', '35',  34000, 2, '27/8/2003');
INSERT INTO person VALUES(2637, 'Renata', 'Žižková','F', '52',  31000, 3, '11.4.2013');
INSERT INTO person VALUES(2638, 'Andrej', 'Kone?ný ','M', '63',  39000, 3, '23/5/2019');
INSERT INTO person VALUES(2639, 'R?žena', 'Berková','F', '37',  38000, 2, '5.2.2010');
INSERT INTO person VALUES(2640, '?ubomír', 'Koš ál ','M', '40',  12000, 2, '31/5/2014');
INSERT INTO person VALUES(2641, 'Miluše', 'Žemli?ková','F', '45',  18000, 3, '19.8.2015');
INSERT INTO person VALUES(2642, 'Svatopluk', 'Hude?ek ','M', '23',  17000, 3, '8/4/2010');
INSERT INTO person VALUES(2643, 'Klára', 'Jirková','F', '30',  26000, 2, '14.6.2012');
INSERT INTO person VALUES(2644, 'Jonáš', 'Tomeš ','M', '45',  27000, 2, '15/4/2005');
INSERT INTO person VALUES(2645, 'So?a', 'Hermanová','F', '37',  42000, 3, '26.12.2017');
INSERT INTO person VALUES(2646, 'Marcel', 'Mayer ','M', '28',  32000, 3, '18/7/2017');
INSERT INTO person VALUES(2647, 'Miluše', 'Karasová','F', '23',  13000, 2, '22.10.2014');
INSERT INTO person VALUES(2648, 'Marián', 'Paul ','M', '50',  41000, 2, '25/7/2012');
INSERT INTO person VALUES(2649, 'Nina', 'Hejduková','F', '31',  37000, 3, '31.7.2005');
INSERT INTO person VALUES(2650, 'Bohumir', 'Krej?ík ','M', '32',  46000, 3, '26/11/2011');
INSERT INTO person VALUES(2651, 'Nad?žda', 'Nesvadbová','F', '61',  37000, 2, '27.2.2017');
INSERT INTO person VALUES(2652, 'Bohumír', 'Sklená? ','M', '55',  19000, 2, '4/11/2019');
INSERT INTO person VALUES(2653, 'Emília', 'Majerová','F', '24',  25000, 3, '7.12.2007');
INSERT INTO person VALUES(2654, 'Michael', 'Vav?ík ','M', '37',  24000, 3, '7/3/2019');
INSERT INTO person VALUES(2655, 'Zlatuše', 'Šimáková','F', '31',  41000, 3, '19.6.2013');
INSERT INTO person VALUES(2656, 'Miroslav', 'Dunka ','M', '20',  29000, 3, '14/1/2015');
INSERT INTO person VALUES(2657, 'Olena', 'Víšková','F', '63',  12000, 3, '15.4.2010');
INSERT INTO person VALUES(2658, 'Mat?j', 'Brož ','M', '43',  39000, 3, '21/1/2010');
INSERT INTO person VALUES(2659, 'Emília', 'Kulhavá','F', '48',  20000, 2, '9.2.2007');
INSERT INTO person VALUES(2660, 'Leoš', 'Schneider ','M', '19',  12000, 2, '28/1/2005');
INSERT INTO person VALUES(2661, 'Radomíra', 'Hloušková','F', '55',  36000, 3, '22.8.2012');
INSERT INTO person VALUES(2662, 'Radek', 'Zbo?il ','M', '48',  17000, 3, '2/5/2017');
INSERT INTO person VALUES(2663, 'Na?a', 'Langerová','F', '41',  43000, 2, '17.6.2009');
INSERT INTO person VALUES(2664, 'Zbyn?k', 'Holoubek ','M', '24',  26000, 2, '9/5/2012');
INSERT INTO person VALUES(2665, 'Tatiana', 'Šebelová','F', '48',  23000, 2, '29.12.2014');
INSERT INTO person VALUES(2666, 'Petr', 'Karel ','M', '53',  31000, 2, '17/3/2008');
INSERT INTO person VALUES(2667, 'Blažena', 'Šebestová','F', '57',  47000, 3, '7.10.2005');
INSERT INTO person VALUES(2668, 'Herbert', 'Št?rba ','M', '35',  36000, 3, '20/7/2007');
INSERT INTO person VALUES(2669, 'Hana', 'Hromádková','F', '41',  47000, 2, '7.5.2017');
INSERT INTO person VALUES(2670, 'Vladimir', 'Strnad ','M', '59',  46000, 2, '27/6/2015');
INSERT INTO person VALUES(2671, 'Alexandra', 'Peroutková','F', '49',  34000, 3, '14.2.2008');
INSERT INTO person VALUES(2672, 'Július', 'Ková?ík ','M', '41',  14000, 3, '28/10/2014');
INSERT INTO person VALUES(2673, 'Martina', '?echová','F', '34',  34000, 2, '14.9.2019');
INSERT INTO person VALUES(2674, 'J?lius', 'Bu?ek ','M', '64',  24000, 2, '13/5/2006');
INSERT INTO person VALUES(2675, 'Jolana', '?erve?áková','F', '42',  22000, 3, '23.6.2010');
INSERT INTO person VALUES(2676, 'Viliám', 'Dole?ek ','M', '46',  29000, 3, '13/9/2005');
INSERT INTO person VALUES(2677, 'Kv?tuše', 'Hradilová','F', '28',  30000, 2, '19.4.2007');
INSERT INTO person VALUES(2678, 'Nikola', 'B?ezina ','M', '22',  38000, 2, '14/2/2017');
INSERT INTO person VALUES(2679, 'Vladislava', 'Urbancová','F', '35',  45000, 3, '30.10.2012');
INSERT INTO person VALUES(2680, 'Slavomír', 'Mikeš ','M', '51',  43000, 3, '23/12/2012');
INSERT INTO person VALUES(2681, 'Leona', 'Rácová','F', '20',  17000, 2, '25.8.2009');
INSERT INTO person VALUES(2682, 'Róbert', 'Míka ','M', '27',  17000, 2, '31/12/2007');
INSERT INTO person VALUES(2683, 'Ivanka', 'Smr?ková','F', '28',  33000, 3, '8.3.2015');
INSERT INTO person VALUES(2684, 'Hynek', 'Matyáš ','M', '56',  22000, 3, '9/11/2003');
INSERT INTO person VALUES(2685, 'Vladislava', 'Ludvíková','F', '59',  40000, 2, '2.1.2012');
INSERT INTO person VALUES(2686, 'Ferdinand', 'Ducho? ','M', '33',  31000, 2, '11/4/2015');
INSERT INTO person VALUES(2687, 'Jindra', 'Procházková','F', '20',  20000, 3, '15.7.2017');
INSERT INTO person VALUES(2688, 'Otakar', 'Daniš ','M', '62',  36000, 3, '18/2/2011');
INSERT INTO person VALUES(2689, 'Irena', '?ervinková','F', '29',  44000, 4, '23.4.2008');
INSERT INTO person VALUES(2690, 'Vladislav', 'Sochor ','M', '44',  41000, 4, '21/6/2010');
INSERT INTO person VALUES(2691, 'Monika', 'Vaní?ková','F', '60',  16000, 3, '17.2.2005');
INSERT INTO person VALUES(2692, 'Otto', 'Hrabal ','M', '20',  14000, 3, '28/6/2005');
INSERT INTO person VALUES(2693, 'Šárka', 'Hrdá','F', '22',  32000, 4, '31.8.2010');
INSERT INTO person VALUES(2694, 'Aleš', 'Papež ','M', '49',  19000, 4, '30/9/2017');
INSERT INTO person VALUES(2695, 'Marta', 'Ježová','F', '53',  39000, 3, '26.6.2007');
INSERT INTO person VALUES(2696, 'René', 'Brada ','M', '25',  29000, 3, '7/10/2012');
INSERT INTO person VALUES(2697, 'Simona', 'Rašková','F', '60',  19000, 3, '6.1.2013');
INSERT INTO person VALUES(2698, 'Zden?k', 'R?ži?ka ','M', '54',  34000, 3, '15/8/2008');
INSERT INTO person VALUES(2699, 'Šárka', 'Votavová','F', '46',  27000, 3, '2.11.2009');
INSERT INTO person VALUES(2700, 'Ivo', 'Sivák ','M', '30',  43000, 3, '24/8/2003');
INSERT INTO person VALUES(2701, 'Ilona', 'Doušová','F', '53',  43000, 3, '16.5.2015');
INSERT INTO person VALUES(2702, 'V?roslav', 'Vaculík ','M', '59',  12000, 3, '25/11/2015');
INSERT INTO person VALUES(2703, 'Radka', 'Machá?ová','F', '38',  14000, 3, '11.3.2012');
INSERT INTO person VALUES(2704, 'Miloslav', 'T?íska ','M', '36',  21000, 3, '2/12/2010');
INSERT INTO person VALUES(2705, 'Jind?iška', 'Volná','F', '46',  30000, 3, '22.9.2017');
INSERT INTO person VALUES(2706, 'Zoltán', 'Prášek ','M', '19',  27000, 3, '11/10/2006');
INSERT INTO person VALUES(2707, 'Ilona', 'Dvorská','F', '31',  38000, 2, '19.7.2014');
INSERT INTO person VALUES(2708, 'Martin', 'Šebela ','M', '41',  36000, 2, '13/3/2018');
INSERT INTO person VALUES(2709, 'Zlata', 'Kalová','F', '40',  25000, 4, '26.4.2005');
INSERT INTO person VALUES(2710, 'Adrian', 'Vojá?ek ','M', '23',  40000, 4, '14/7/2017');
INSERT INTO person VALUES(2711, 'Zd?nka', 'Karasová','F', '47',  41000, 4, '7.11.2010');
INSERT INTO person VALUES(2712, 'Ota', 'M?ller ','M', '52',  46000, 4, '23/5/2013');
INSERT INTO person VALUES(2713, 'Aloisie', 'Ma?íková','F', '32',  13000, 3, '3.9.2007');
INSERT INTO person VALUES(2714, 'Gerhard', 'Hušek ','M', '28',  19000, 3, '30/5/2008');
INSERT INTO person VALUES(2715, 'Zora', 'Nesvadbová','F', '40',  29000, 4, '16.3.2013');
INSERT INTO person VALUES(2716, 'Vlastislav', 'Hrdý ','M', '57',  24000, 4, '8/4/2004');
INSERT INTO person VALUES(2717, 'Zd?nka', 'Dittrichová','F', '25',  36000, 3, '10.1.2010');
INSERT INTO person VALUES(2718, 'Gabriel', 'Toman ','M', '34',  33000, 3, '9/9/2015');
INSERT INTO person VALUES(2719, 'Iryna', 'Dobiášová','F', '32',  16000, 4, '24.7.2015');
INSERT INTO person VALUES(2720, 'Leoš', 'Benda ','M', '62',  39000, 4, '19/7/2011');
INSERT INTO person VALUES(2721, 'Radana', 'Van?urová','F', '64',  24000, 3, '19.5.2012');
INSERT INTO person VALUES(2722, 'Drahomír', 'Kolá?ek ','M', '39',  12000, 3, '26/7/2006');
INSERT INTO person VALUES(2723, 'Št?pánka', 'Kulhavá','F', '26',  12000, 4, '21.7.2019');
INSERT INTO person VALUES(2724, 'Alexander 4 000', 'Bašta ','M', '21',  16000, 4, '26/11/2005');
INSERT INTO person VALUES(2725, 'Iryna', 'Matoušková','F', '57',  47000, 3, '25.9.2014');
INSERT INTO person VALUES(2726, 'Tadeáš', 'Prošek ','M', '44',  26000, 3, '4/11/2013');
INSERT INTO person VALUES(2727, 'Antonie', 'Hudcová','F', '19',  35000, 4, '4.7.2005');
INSERT INTO person VALUES(2728, 'B?etislav', 'Žá?ek ','M', '26',  31000, 4, '7/3/2013');
INSERT INTO person VALUES(2729, 'Petra', 'Jurková','F', '49',  35000, 3, '1.2.2017');
INSERT INTO person VALUES(2730, 'Vilém', 'Mašek ','M', '49',  41000, 3, '19/9/2004');
INSERT INTO person VALUES(2731, 'Václava', 'Baráková','F', '58',  23000, 4, '11.11.2007');
INSERT INTO person VALUES(2732, 'Vit', 'Kindl ','M', '31',  45000, 4, '22/1/2004');
INSERT INTO person VALUES(2733, 'Sylva', 'Hromádková','F', '19',  38000, 4, '24.5.2013');
INSERT INTO person VALUES(2734, 'Zd?nek', 'Macha? ','M', '60',  15000, 4, '24/4/2016');
INSERT INTO person VALUES(2735, 'Linda', 'Chmela?ová','F', '51',  46000, 4, '20.3.2010');
INSERT INTO person VALUES(2736, 'Rudolf', 'Walter ','M', '37',  24000, 4, '2/5/2011');
INSERT INTO person VALUES(2737, 'Nela', 'Poláchová','F', '36',  18000, 3, '13.1.2007');
INSERT INTO person VALUES(2738, 'Dalibor', 'Holý ','M', '59',  33000, 3, '10/5/2006');
INSERT INTO person VALUES(2739, 'Sylva', 'Doležalová','F', '43',  34000, 3, '26.7.2012');
INSERT INTO person VALUES(2740, 'Michal', 'Gregor ','M', '42',  38000, 3, '11/8/2018');
INSERT INTO person VALUES(2741, 'Terezie', 'Dvo?áková','F', '29',  41000, 3, '22.5.2009');
INSERT INTO person VALUES(2742, 'Lud?k', 'Fischer ','M', '64',  47000, 3, '18/8/2013');
INSERT INTO person VALUES(2743, 'Maria', 'Rybová','F', '36',  21000, 3, '3.12.2014');
INSERT INTO person VALUES(2744, 'Nicolas', 'Šiška ','M', '47',  17000, 3, '27/6/2009');
INSERT INTO person VALUES(2745, 'Markéta', 'Rácová','F', '45',  45000, 4, '11.9.2005');
INSERT INTO person VALUES(2746, 'Ctibor', 'Ku?era ','M', '29',  21000, 4, '28/10/2008');
INSERT INTO person VALUES(2747, 'Jaromíra', 'Dvo?á?ková','F', '29',  45000, 3, '11.4.2017');
INSERT INTO person VALUES(2748, 'Oskar', 'Krají?ek ','M', '52',  31000, 3, '6/10/2016');
INSERT INTO person VALUES(2749, 'R?žena', 'Ludvíková','F', '37',  32000, 4, '19.1.2008');
INSERT INTO person VALUES(2750, 'Jáchym', 'Kola?ík ','M', '34',  36000, 4, '7/2/2016');
INSERT INTO person VALUES(2751, 'Markéta', 'Stuchlíková','F', '23',  40000, 4, '13.11.2004');
INSERT INTO person VALUES(2752, 'Boleslav', 'Rudolf ','M', '57',  45000, 4, '14/2/2011');
INSERT INTO person VALUES(2753, 'Klára', 'Šim?íková','F', '30',  20000, 4, '27.5.2010');
INSERT INTO person VALUES(2754, 'Bo?ivoj', 'Michalec ','M', '40',  14000, 4, '24/12/2006');
INSERT INTO person VALUES(2755, 'Eliška', 'Braunová','F', '62',  27000, 3, '23.3.2007');
INSERT INTO person VALUES(2756, 'Mario', 'Jech ','M', '62',  23000, 3, '26/5/2018');
INSERT INTO person VALUES(2757, 'Miluše', 'Janá?ková','F', '23',  43000, 4, '3.10.2012');
INSERT INTO person VALUES(2758, 'Mykola', 'Ka?írek ','M', '45',  29000, 4, '4/4/2014');
INSERT INTO person VALUES(2759, 'Klára', 'Foltýnová','F', '54',  15000, 3, '30.7.2009');
INSERT INTO person VALUES(2760, 'Lubor', 'Havránek ','M', '21',  38000, 3, '11/4/2009');
INSERT INTO person VALUES(2761, 'Nad?žda', 'Adámková','F', '62',  31000, 4, '10.2.2015');
INSERT INTO person VALUES(2762, 'Bohumir', 'Kubeš ','M', '50',  43000, 4, '17/2/2005');
INSERT INTO person VALUES(2763, 'Daniela', 'Havlová','F', '47',  38000, 3, '7.12.2011');
INSERT INTO person VALUES(2764, 'Ota', 'Ml?och ','M', '27',  16000, 3, '21/7/2016');
INSERT INTO person VALUES(2765, 'Alžb?ta', 'Chvátalová','F', '54',  18000, 4, '19.6.2017');
INSERT INTO person VALUES(2766, 'Emil', 'Sadílek ','M', '55',  22000, 4, '29/5/2012');
INSERT INTO person VALUES(2767, 'Olena', 'Machá?ová','F', '63',  42000, 1, '28.3.2008');
INSERT INTO person VALUES(2768, 'Luboš', 'Hlavá?ek ','M', '37',  26000, 1, '30/9/2011');
INSERT INTO person VALUES(2769, 'Emília', 'Neradová','F', '48',  14000, 4, '21.1.2005');
INSERT INTO person VALUES(2770, 'Matyáš', 'Husák ','M', '60',  35000, 4, '8/10/2006');
INSERT INTO person VALUES(2771, 'Zlatuše', 'Dvorská','F', '55',  30000, 4, '4.8.2010');
INSERT INTO person VALUES(2772, 'Ond?ej', 'Maršálek ','M', '43',  41000, 4, '9/1/2019');
INSERT INTO person VALUES(2773, 'Na?a', 'Kaplanová','F', '41',  37000, 4, '31.5.2007');
INSERT INTO person VALUES(2774, 'Ján', 'Sko?epa ','M', '19',  14000, 4, '16/1/2014');
INSERT INTO person VALUES(2775, 'Tatiana', 'Fišerová','F', '48',  17000, 4, '11.12.2012');
INSERT INTO person VALUES(2776, 'Jan', 'Hejna ','M', '48',  19000, 4, '25/11/2009');
INSERT INTO person VALUES(2777, 'Radomíra', 'Beranová','F', '34',  25000, 4, '7.10.2009');
INSERT INTO person VALUES(2778, 'Adam', 'Vávra ','M', '24',  28000, 4, '2/12/2004');
INSERT INTO person VALUES(2779, 'Hana', 'Horská','F', '41',  40000, 4, '20.4.2015');
INSERT INTO person VALUES(2780, 'Herbert', 'Jedli?ka ','M', '53',  34000, 4, '6/3/2017');
INSERT INTO person VALUES(2781, 'Natalie', 'Kazdová','F', '26',  12000, 3, '13.2.2012');
INSERT INTO person VALUES(2782, 'Ladislav', 'Sojka ','M', '30',  43000, 3, '13/3/2012');
INSERT INTO person VALUES(2783, 'Blažena', 'Paulová','F', '35',  36000, 1, '17.4.2019');
INSERT INTO person VALUES(2784, 'Kevin', 'Molnár ','M', '58',  47000, 1, '15/7/2011');
INSERT INTO person VALUES(2785, 'Hana', 'Komárková','F', '19',  36000, 3, '22.6.2014');
INSERT INTO person VALUES(2786, 'Prokop', 'Ondra ','M', '35',  21000, 3, '23/6/2019');
INSERT INTO person VALUES(2787, 'Kv?tuše', 'Srbová','F', '28',  23000, 4, '31.3.2005');
INSERT INTO person VALUES(2788, 'Alfred', 'Sobotka ','M', '63',  26000, 4, '24/10/2018');
INSERT INTO person VALUES(2789, 'Ta ána', 'Matoušková','F', '35',  39000, 1, '12.10.2010');
INSERT INTO person VALUES(2790, 'Anton', 'Jirásek ','M', '46',  31000, 1, '2/9/2014');
INSERT INTO person VALUES(2791, 'Jolana', 'Poláková','F', '20',  47000, 4, '8.8.2007');
INSERT INTO person VALUES(2792, 'Drahoslav', 'Štefan ','M', '22',  40000, 4, '9/9/2009');
INSERT INTO person VALUES(2793, 'Hedvika', 'Benešová','F', '52',  19000, 4, '3.6.2004');
INSERT INTO person VALUES(2794, 'Radko', 'Škrabal ','M', '44',  13000, 4, '16/9/2004');
INSERT INTO person VALUES(2795, 'Vladislava', 'Smolová','F', '59',  34000, 4, '15.12.2009');
INSERT INTO person VALUES(2796, 'Karol', 'Barák ','M', '27',  19000, 4, '19/12/2016');
INSERT INTO person VALUES(2797, 'Leona', 'Kindlová','F', '45',  42000, 3, '10.10.2006');
INSERT INTO person VALUES(2798, 'Ctibor', '?ížek ','M', '50',  28000, 3, '27/12/2011');
INSERT INTO person VALUES(2799, 'Ivanka', 'Davidová','F', '52',  22000, 4, '22.4.2012');
INSERT INTO person VALUES(2800, 'Zdenek', 'Stránský ','M', '33',  33000, 4, '4/11/2007');
INSERT INTO person VALUES(2801, 'Monika', 'Poláchová','F', '60',  46000, 1, '25.6.2019');
INSERT INTO person VALUES(2802, 'Alexandr', 'Ma?ák ','M', '61',  38000, 1, '8/3/2007');
INSERT INTO person VALUES(2803, 'Jindra', 'Sko?epová','F', '45',  45000, 4, '30.8.2014');
INSERT INTO person VALUES(2804, 'Kryštof', 'Svatoš ','M', '38',  12000, 4, '13/2/2015');
INSERT INTO person VALUES(2805, 'Marta', 'Novotná','F', '53',  33000, 1, '8.6.2005');
INSERT INTO person VALUES(2806, 'Vít?zslav', 'Sobek ','M', '20',  16000, 1, '16/6/2014');
INSERT INTO person VALUES(2807, 'Ema', 'Uhrová','F', '37',  33000, 4, '6.1.2017');
INSERT INTO person VALUES(2808, 'Ludvík', 'Tvrdík ','M', '43',  26000, 4, '30/12/2005');
INSERT INTO person VALUES(2809, 'Šárka', 'Kurková','F', '46',  21000, 1, '16.10.2007');
INSERT INTO person VALUES(2810, 'Radim', 'Jonáš ','M', '25',  31000, 1, '2/5/2005');
INSERT INTO person VALUES(2811, 'Ilona', 'Dvo?á?ková','F', '53',  36000, 1, '28.4.2013');
INSERT INTO person VALUES(2812, 'Boleslav', 'Šesták ','M', '54',  36000, 1, '4/8/2017');
INSERT INTO person VALUES(2813, 'Radka', 'Št?pánová','F', '39',  44000, 1, '21.2.2010');
INSERT INTO person VALUES(2814, 'Daniel', 'Klouda ','M', '30',  45000, 1, '11/8/2012');
INSERT INTO person VALUES(2815, 'Iveta', 'Špa?ková','F', '24',  16000, 4, '18.12.2006');
INSERT INTO person VALUES(2816, 'Viktor', 'Pavlica ','M', '53',  18000, 4, '19/8/2007');
INSERT INTO person VALUES(2817, 'Ilona', 'Jánská','F', '31',  32000, 4, '30.6.2012');
INSERT INTO person VALUES(2818, 'Pavel', 'Brázdil ','M', '36',  24000, 4, '28/6/2003');
INSERT INTO person VALUES(2819, 'Radka', 'Ottová','F', '63',  39000, 4, '26.4.2009');
INSERT INTO person VALUES(2820, 'Bohumil', 'Diviš ','M', '58',  33000, 4, '28/11/2014');
INSERT INTO person VALUES(2821, 'Danuše', 'Hovorková','F', '24',  19000, 4, '7.11.2014');
INSERT INTO person VALUES(2822, 'Rastislav', 'Pelikán ','M', '41',  38000, 4, '7/10/2010');
INSERT INTO person VALUES(2823, 'Barbara', 'Foltýnová','F', '33',  43000, 1, '16.8.2005');
INSERT INTO person VALUES(2824, 'Oliver', 'Kubiš ','M', '23',  43000, 1, '7/2/2010');
INSERT INTO person VALUES(2825, 'Magdalena', 'Miná?ová','F', '63',  42000, 4, '16.3.2017');
INSERT INTO person VALUES(2826, 'Ervín', 'Vrabec ','M', '46',  16000, 4, '15/1/2018');
INSERT INTO person VALUES(2827, 'Karolina', 'Fridrichová','F', '49',  22000, 4, '31.8.2015');
INSERT INTO person VALUES(2828, 'Jind?ich', 'Hradil ','M', '22',  25000, 4, '17/7/2016');
INSERT INTO person VALUES(2829, 'Aloisie', 'Stejskalová','F', '57',  38000, 4, '18.10.2004');
INSERT INTO person VALUES(2830, 'Gejza', 'Chládek ','M', '51',  30000, 4, '26/5/2012');
INSERT INTO person VALUES(2831, 'Dáša', 'Hrušková','F', '42',  46000, 4, '7.1.2018');
INSERT INTO person VALUES(2832, 'Lukáš', 'Kysela ','M', '27',  39000, 4, '3/6/2007');
INSERT INTO person VALUES(2833, 'Renata', 'Hrdinová','F', '51',  33000, 1, '16.10.2008');
INSERT INTO person VALUES(2834, 'Nicolas', 'Jedli?ka ','M', '55',  44000, 1, '4/10/2006');
INSERT INTO person VALUES(2835, 'Vladimíra', 'Grygarová','F', '58',  13000, 1, '29.4.2014');
INSERT INTO person VALUES(2836, 'Emanuel', '?apek ','M', '38',  13000, 1, '6/1/2019');
INSERT INTO person VALUES(2837, 'Denisa', 'Gottwaldová','F', '43',  21000, 1, '23.2.2011');
INSERT INTO person VALUES(2838, 'Oskar', 'Hron ','M', '60',  22000, 1, '13/1/2014');
INSERT INTO person VALUES(2839, 'Vendula', 'Sedlá?ová','F', '51',  37000, 1, '5.9.2016');
INSERT INTO person VALUES(2840, 'Andrej', 'Hašek ','M', '43',  28000, 1, '22/11/2009');
INSERT INTO person VALUES(2841, 'So?a', 'Žigová','F', '36',  44000, 1, '1.7.2013');
INSERT INTO person VALUES(2842, '?ubomír', 'Matys ','M', '19',  37000, 1, '29/11/2004');
INSERT INTO person VALUES(2843, 'Antonie', 'Moravcová','F', '43',  24000, 1, '12.1.2019');
INSERT INTO person VALUES(2844, 'Svatopluk', 'Pavl? ','M', '48',  42000, 1, '2/3/2017');
INSERT INTO person VALUES(2845, 'Vendula', 'Ková?ová','F', '29',  32000, 4, '8.11.2015');
INSERT INTO person VALUES(2846, 'Jonáš', 'Havlík ','M', '25',  15000, 4, '10/3/2012');
INSERT INTO person VALUES(2847, 'Nela', 'Pe?inová','F', '36',  12000, 1, '26.12.2004');
INSERT INTO person VALUES(2848, 'Peter', 'Ko?ínek ','M', '54',  21000, 1, '17/1/2008');
INSERT INTO person VALUES(2849, 'Julie', 'Hoffmannová','F', '22',  19000, 4, '17.3.2018');
INSERT INTO person VALUES(2850, 'Marián', 'Valeš ','M', '30',  30000, 4, '19/6/2019');
INSERT INTO person VALUES(2851, 'Zlatuše', 'Jarešová','F', '30',  43000, 1, '24.12.2008');
INSERT INTO person VALUES(2852, 'Bohumir', 'Hána ','M', '58',  34000, 1, '21/10/2018');
INSERT INTO person VALUES(2853, 'Nela', 'Brabcová','F', '60',  43000, 4, '28.2.2004');
INSERT INTO person VALUES(2854, 'Alexandr', 'Janota ','M', '35',  44000, 4, '5/5/2010');
INSERT INTO person VALUES(2855, 'Tatiána', 'Valešová','F', '23',  31000, 1, '2.5.2011');
INSERT INTO person VALUES(2856, 'Michael', 'Václavík ','M', '63',  13000, 1, '6/9/2009');
INSERT INTO person VALUES(2857, 'Zde?ka', 'Benešová','F', '30',  46000, 2, '12.11.2016');
INSERT INTO person VALUES(2858, 'Miroslav', 'Koš ál ','M', '46',  18000, 2, '15/7/2005');
INSERT INTO person VALUES(2859, 'V?ra', 'Nováková','F', '62',  18000, 1, '8.9.2013');
INSERT INTO person VALUES(2860, 'Mat?j', 'Nagy ','M', '23',  27000, 1, '15/12/2016');
INSERT INTO person VALUES(2861, 'Tatiana', 'Zdráhalová','F', '47',  26000, 4, '5.7.2010');
INSERT INTO person VALUES(2862, 'Leoš', 'Tvrdík ','M', '45',  37000, 4, '24/12/2011');
INSERT INTO person VALUES(2863, 'Zde?ka', 'Hr?zová','F', '54',  42000, 1, '16.1.2016');
INSERT INTO person VALUES(2864, 'Radek', 'Dosko?il ','M', '28',  42000, 1, '1/11/2007');
INSERT INTO person VALUES(2865, 'V?ra', 'Brychtová','F', '40',  13000, 4, '11.11.2012');
INSERT INTO person VALUES(2866, 'Zbyn?k', 'Krátký ','M', '50',  15000, 4, '3/4/2019');
INSERT INTO person VALUES(2867, 'Vlasta', 'Hanáková','F', '47',  29000, 1, '25.5.2018');
INSERT INTO person VALUES(2868, 'Josef', 'Majer ','M', '33',  20000, 1, '10/2/2015');
INSERT INTO person VALUES(2869, 'Sandra', 'Antošová','F', '56',  17000, 2, '2.3.2009');
INSERT INTO person VALUES(2870, 'Herbert', 'Mat?jí?ek ','M', '61',  25000, 2, '13/6/2014');
INSERT INTO person VALUES(2871, 'Eliška', 'Vo?íšková','F', '40',  16000, 1, '7.5.2004');
INSERT INTO person VALUES(2872, 'Vladimir', 'Vorel ','M', '38',  35000, 1, '27/12/2005');
INSERT INTO person VALUES(2873, 'Old?iška', 'Baštová','F', '48',  40000, 2, '10.7.2011');
INSERT INTO person VALUES(2874, 'Július', 'Vl?ek ','M', '20',  39000, 2, '29/4/2005');
INSERT INTO person VALUES(2875, 'Ta ána', 'Pohanková','F', '34',  12000, 1, '5.5.2008');

commit;

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'rsk');
SELECT * FROM person WHERE REGEXP_LIKE(lastname,'èad');
SELECT * FROM person WHERE REGEXP_LIKE(lastname,'Mašková');
SELECT * FROM person WHERE REGEXP_LIKE(lastname,'Hašková');
SELECT * FROM person WHERE REGEXP_LIKE(lastname,'Pašková');

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'[MHP]ašková');
SELECT * FROM person WHERE REGEXP_LIKE(firstname,'[HJ]ana');
SELECT * FROM person WHERE REGEXP_LIKE(firstname,'[RM]a[dr]ek');

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'[NŠ][io][mv]áèek');

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'[A-Z]ana');

SELECT * FROM v$nls_parameters;

ALTER SESSION SET nls_sort = 'binary';

-- sortovani ro nejakz jazyk v abecede s velkzmi pismeny 

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'[A-Z][a-z][a-z]áèek');

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'Jana');
SELECT * FROM person WHERE REGEXP_LIKE(firstname,'Hana');

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'Radka')
UNION
SELECT * FROM person WHERE REGEXP_LIKE(firstname,'Marek');

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'Radka','Marek');

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'[DHJ]ana');

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'[^ N]ováèek');

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'^[^H]ana');
-- dat pred yavorkami jestli hceme na yacatku mit spravne 

SELECT * FROM person WHERE REGEXP_LIKE(firstname,'an$');

-- na konci dame $ abzchom dali vedet ye je to konec reteyce 

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'Petøí[è]*ková');

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'Adam[c]*ová');

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'Mu[l]+erová');

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

SELECT * FROM person WHERE REGEXP_LIKE(lastname,'[:upper:][:lower:]*[kr]ová$');

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

--vazební tabulka
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