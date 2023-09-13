DROP TABLE exponaty;

DROP TABLE nemoci;

DROP TABLE osetrovatele;

DROP TABLE veterinari;

CREATE TABLE exponaty (
    inv_cis     NUMBER(38, 0), druh        VARCHAR2(26), jmeno       VARCHAR2(26), pohlavi     VARCHAR2(26), rok_nar     NUMBER(38, 0),
    umisteni    VARCHAR2(26), osetrovatel VARCHAR2(26)
);

INSERT INTO exponaty (
    inv_cis, druh, jmeno, pohlavi, rok_nar, umisteni, osetrovatel
) VALUES (
    1548, 'Nosorožec', 'Pelda', 'M', 2005, 'Pavilon tlustokožcù', 'LAZ05'
);

INSERT INTO exponaty (
    inv_cis, druh, jmeno, pohlavi, rok_nar, umisteni, osetrovatel
) VALUES (
    1677, 'Hroch', 'Bob', 'M', 2003, 'Pavilon tlustokožcù', 'LAZ05'
);

INSERT INTO exponaty (
    inv_cis, druh, jmeno, pohlavi, rok_nar, umisteni, osetrovatel
) VALUES (
    1891, 'Hroch', 'Sam', 'M', 2012, 'Pavilon tlustokožcù', 'LAZ05'
);

INSERT INTO exponaty (
    inv_cis, druh, jmeno, pohlavi, rok_nar, umisteni, osetrovatel
) VALUES (
    3117, 'Žirafa', 'Domina', 'F', 2009, 'Výbìh', 'STA01'
);

INSERT INTO exponaty (
    inv_cis, druh, jmeno, pohlavi, rok_nar, umisteni, osetrovatel
) VALUES (
    4321, 'Sokol', 'Karlík', 'M', 2021, 'Voliéra', 'NOV23'
);

CREATE TABLE nemoci (
    exponat   NUMBER(38, 0), rok       NUMBER(38, 0), nemoc     VARCHAR2(26), dni       NUMBER(38, 0), veterinar VARCHAR2(26)
);

INSERT INTO nemoci (
    exponat, rok, nemoc, dni, veterinar
) VALUES (
    1891, 2020, 'Zánìt kyèle', 7, 'ALD15'
);

INSERT INTO nemoci (
    exponat, rok, nemoc, dni, veterinar
) VALUES (
    1891, 2016, 'Nalomený øezák', 1, 'ALD15'
);

INSERT INTO nemoci (
    exponat, rok, nemoc, dni, veterinar
) VALUES (
    3117, 2019, 'Porucha krevního obìhu', 2, 'BEN33'
);

INSERT INTO nemoci (
    exponat, rok, nemoc, dni, veterinar
) VALUES (
    4321, 2019, 'Nákaza èmelíky', 4, 'BEN33'
);

INSERT INTO nemoci (
    exponat, rok, nemoc, dni, veterinar
) VALUES (
    3117, 2020, 'Angína', 5, 'ALD15'
);

INSERT INTO nemoci (
    exponat, rok, nemoc, dni, veterinar
) VALUES (
    3117, 2018, 'Operace kloubù', 3, 'ALD15'
);

CREATE TABLE osetrovatele (
    os_cis   VARCHAR2(26), prijmeni VARCHAR2(26), jmeno    VARCHAR2(26), rok_nar  NUMBER(38, 0), vzdelani VARCHAR2(26)
);

INSERT INTO osetrovatele (
    os_cis, prijmeni, jmeno, rok_nar, vzdelani
) VALUES (
    'LAZ05', 'Lazar', 'Ludvík', '1975', 'Veterinární univerzita'
);

INSERT INTO osetrovatele (
    os_cis, prijmeni, jmeno, rok_nar, vzdelani
) VALUES (
    'NOV23', 'Nováková', 'Nela', '1981', 'Støední zdravotní'
);

INSERT INTO osetrovatele (
    os_cis, prijmeni, jmeno, rok_nar, vzdelani
) VALUES (
    'STA01', 'Stárková', 'Simona', '1990', 'Støední veterinární'
);

CREATE TABLE veterinari (
    ident     VARCHAR2(26), prijmeni  VARCHAR2(26), jmeno     VARCHAR2(26), sazba_den NUMBER(38, 0)
);

INSERT INTO veterinari (
    ident, prijmeni, jmeno, sazba_den
) VALUES (
    'ALD15', 'Aldorf', 'Adam', '2800'
);

INSERT INTO veterinari (
    ident, prijmeni, jmeno, sazba_den
) VALUES (
    'BEN33', 'Benda', 'Bøetislav', '1900'
);

INSERT INTO veterinari (
    ident, prijmeni, jmeno, sazba_den
) VALUES (
    'COU21', 'Coufal', 'Ctirad', '3200'
);

COMMIT;


SELECT *
FROM EXPONATY ex
JOIN NEMOCI nem ON ex.INV_CIS=nem.EXPONAT
WHERE dni IN (SELECT )
;

--datum ktere ma nejnemosnejsi 
--1
WITH ExponatIllnessCount AS (
    SELECT
        e.inv_cis,
        e.jmeno AS exponat_jmeno,
        COUNT(n.nemoc) AS illness_count
    FROM
        exponaty e
    LEFT JOIN
        nemoci n ON e.inv_cis = n.exponat
    GROUP BY
        e.inv_cis, e.jmeno
    ORDER BY
        COUNT(n.nemoc) DESC
    FETCH FIRST ROW ONLY
)

SELECT
    e.rok_nar AS datum_narozeni_exponatu
FROM
    exponaty e
JOIN
    ExponatIllnessCount ec ON e.inv_cis = ec.inv_cis;
    
  --2  
    
    WITH ExponatIllnessCount AS (
    SELECT
        e.inv_cis,
        e.jmeno AS exponat_jmeno,
        COUNT(n.nemoc) AS illness_count
    FROM
        exponaty e
    LEFT JOIN
        nemoci n ON e.inv_cis = n.exponat
    GROUP BY
        e.inv_cis, e.jmeno
    ORDER BY
        COUNT(n.nemoc) DESC
    FETCH FIRST ROW ONLY
)

SELECT
    os.rok_nar AS datum_narozeni
FROM
    exponaty e
JOIN
    ExponatIllnessCount ec ON e.inv_cis = ec.inv_cis
JOIN
    OSETROVATELE os ON os.os_cis = e.osetrovatel ;
    
 -- 5 
SELECT DISTINCT e.umisteni AS untreated_exhibit, e.jmeno
FROM exponaty e
LEFT JOIN nemoci n ON e.inv_cis = n.exponat
WHERE n.exponat IS NULL;

--3

SELECT vet.ident, SUM(ne.dni * vet.sazba_den) AS celkovy FROM VETERINARI vet
JOIN nemoci ne ON ne.veterinar = vet.ident
JOIN exponaty ex ON ex.inv_cis = ne.exponat
WHERE ex.druh='Hroch'
GROUP BY vet.ident;


--4

SELECT ne.exponat, SUM(ne.dni * vet.sazba_den) AS celkovy FROM nemoci ne
JOIN veterinari vet ON vet.ident = ne.veterinar
JOIN exponaty e ON e.inv_cis = ne.exponat
GROUP BY ne.exponat
ORDER BY celkovy DESC
fetch first 1 row only
;


--5
select * from exponaty e
where e.inv_cis not in (SELECT nemoci.exponat from nemoci);
-- nejvice se yaplatilo 


SELECT
    v.ident AS veterinarian_id,
    v.prijmeni AS veterinarian_lastname,
    v.jmeno AS veterinarian_firstname,
    SUM(v.sazba_den * n.dni) AS total_payment,
    o.jmeno as jmeno_osetrovatele,
    o.prijmeni as prijemni_osetrovatele,
    o.vzdelani as VZDELANI_OSETROVATELE
FROM
    veterinari v
JOIN
    nemoci n ON v.ident = n.veterinar
JOIN
    exponaty e ON n.exponat = e.inv_cis
JOIN
    osetrovatele o ON o.os_cis = e.osetrovatel
WHERE
    e.druh = 'Hroch'
;
    
    --6
    
    SELECT o.prijmeni,o.vzdelani,v.sazba_den FROM osetrovatele o
    JOIN exponaty e ON e.osetrovatel = o.os_cis
    JOIN nemoci n ON n.exponat = e.inv_cis
    JOIN veterinari v ON v.ident = n.veterinar
    
    WHERE v.sazba_den = (SELECT MAX(sazba_den)FROM veterinari WHERE ident IN (SELECT veterinar FROM nemoci))
    
    ;
