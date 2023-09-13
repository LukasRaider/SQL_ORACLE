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
    1548, 'Nosoro�ec', 'Pelda', 'M', 2005, 'Pavilon tlustoko�c�', 'LAZ05'
);

INSERT INTO exponaty (
    inv_cis, druh, jmeno, pohlavi, rok_nar, umisteni, osetrovatel
) VALUES (
    1677, 'Hroch', 'Bob', 'M', 2003, 'Pavilon tlustoko�c�', 'LAZ05'
);

INSERT INTO exponaty (
    inv_cis, druh, jmeno, pohlavi, rok_nar, umisteni, osetrovatel
) VALUES (
    1891, 'Hroch', 'Sam', 'M', 2012, 'Pavilon tlustoko�c�', 'LAZ05'
);

INSERT INTO exponaty (
    inv_cis, druh, jmeno, pohlavi, rok_nar, umisteni, osetrovatel
) VALUES (
    3117, '�irafa', 'Domina', 'F', 2009, 'V�b�h', 'STA01'
);

INSERT INTO exponaty (
    inv_cis, druh, jmeno, pohlavi, rok_nar, umisteni, osetrovatel
) VALUES (
    4321, 'Sokol', 'Karl�k', 'M', 2021, 'Voli�ra', 'NOV23'
);

CREATE TABLE nemoci (
    exponat   NUMBER(38, 0), rok       NUMBER(38, 0), nemoc     VARCHAR2(26), dni       NUMBER(38, 0), veterinar VARCHAR2(26)
);

INSERT INTO nemoci (
    exponat, rok, nemoc, dni, veterinar
) VALUES (
    1891, 2020, 'Z�n�t ky�le', 7, 'ALD15'
);

INSERT INTO nemoci (
    exponat, rok, nemoc, dni, veterinar
) VALUES (
    1891, 2016, 'Nalomen� �ez�k', 1, 'ALD15'
);

INSERT INTO nemoci (
    exponat, rok, nemoc, dni, veterinar
) VALUES (
    3117, 2019, 'Porucha krevn�ho ob�hu', 2, 'BEN33'
);

INSERT INTO nemoci (
    exponat, rok, nemoc, dni, veterinar
) VALUES (
    4321, 2019, 'N�kaza �mel�ky', 4, 'BEN33'
);

INSERT INTO nemoci (
    exponat, rok, nemoc, dni, veterinar
) VALUES (
    3117, 2020, 'Ang�na', 5, 'ALD15'
);

INSERT INTO nemoci (
    exponat, rok, nemoc, dni, veterinar
) VALUES (
    3117, 2018, 'Operace kloub�', 3, 'ALD15'
);

CREATE TABLE osetrovatele (
    os_cis   VARCHAR2(26), prijmeni VARCHAR2(26), jmeno    VARCHAR2(26), rok_nar  NUMBER(38, 0), vzdelani VARCHAR2(26)
);

INSERT INTO osetrovatele (
    os_cis, prijmeni, jmeno, rok_nar, vzdelani
) VALUES (
    'LAZ05', 'Lazar', 'Ludv�k', '1975', 'Veterin�rn� univerzita'
);

INSERT INTO osetrovatele (
    os_cis, prijmeni, jmeno, rok_nar, vzdelani
) VALUES (
    'NOV23', 'Nov�kov�', 'Nela', '1981', 'St�edn� zdravotn�'
);

INSERT INTO osetrovatele (
    os_cis, prijmeni, jmeno, rok_nar, vzdelani
) VALUES (
    'STA01', 'St�rkov�', 'Simona', '1990', 'St�edn� veterin�rn�'
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
    'BEN33', 'Benda', 'B�etislav', '1900'
);

INSERT INTO veterinari (
    ident, prijmeni, jmeno, sazba_den
) VALUES (
    'COU21', 'Coufal', 'Ctirad', '3200'
);

COMMIT;