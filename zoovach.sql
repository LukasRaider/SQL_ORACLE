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