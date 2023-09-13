DROP TABLE EMPLOYEES;
CREATE TABLE EMPLOYEES (
    ID NUMBER(3) NOT NULL,
    FIRST_NAME VARCHAR2(20) NOT NULL,
    LAST_NAME VARCHAR2(20) NOT NULL,
    DEPT_ID NUMBER(2) NOT NULL,
    SALARY NUMBER(6) NOT NULL,
    CONSTRAINT PK_EMPLOYEES PRIMARY KEY(ID));

DROP SEQUENCE SQ_EMPLOYEES;
CREATE SEQUENCE SQ_EMPLOYEES
    INCREMENT BY 1 
    START WITH 1
    MINVALUE 1
    MAXVALUE 999
    NOCACHE;

INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DEPT_ID, SALARY) VALUES (SQ_EMPLOYEES.NEXTVAL, 'John', 'Woody', 1, 100000);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DEPT_ID, SALARY) VALUES (SQ_EMPLOYEES.NEXTVAL, 'Joann', 'Herby', 1, 90000);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DEPT_ID, SALARY) VALUES (SQ_EMPLOYEES.NEXTVAL, 'Anna', 'Brenton', 2, 75000);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DEPT_ID, SALARY) VALUES (SQ_EMPLOYEES.NEXTVAL, 'Brenda', 'Bryant', 2, 75000);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DEPT_ID, SALARY) VALUES (SQ_EMPLOYEES.NEXTVAL, 'Will', 'Ackeby', 2, 55000);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DEPT_ID, SALARY) VALUES (SQ_EMPLOYEES.NEXTVAL, 'Karen', 'Portman', 3, 20000);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DEPT_ID, SALARY) VALUES (SQ_EMPLOYEES.NEXTVAL, 'Miles', 'Aberdeen', 3, 20000);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DEPT_ID, SALARY) VALUES (SQ_EMPLOYEES.NEXTVAL, 'Laura', 'Palmer', 4, 55000);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DEPT_ID, SALARY) VALUES (SQ_EMPLOYEES.NEXTVAL, 'Harry', 'Freeman', 4, 60000);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DEPT_ID, SALARY) VALUES (SQ_EMPLOYEES.NEXTVAL, 'Sheila', 'Aberdeen', 4, 55000);

commit;

set serveroutput on;

DECLARE
    v_salaries NUMBER;
    v_cnt NUMBER;
BEGIN
    SELECT SUM(SALARY) INTO v_salaries FROM EMPLOYEES;
    SELECT COUNT(*) INTO v_cnt FROM EMPLOYEES;
    DBMS_OUTPUT.PUT_LINE('Firma vyplatí svým ' || TO_CHAR(v_cnt) || 
    ' zamìstnancùm na výplatách '  || TO_CHAR(v_salaries) ||  ' eur.');
END;

--cviceni napiste anonzmni blok pro vypocet prumerne mzdy v oddeleni 4 a pocet yamestnancu v tomto oddeleni 

DECLARE
    v_salaries NUMBER;
    v_cnt NUMBER;
    BEGIN
        SELECT AVG(salary) INTO v_salaries FROM EMPLOYEES WHERE DEPT_ID=4;
        SELECT COUNT(*) INTO v_cnt FROM EMPLOYEES WHERE DEPT_ID=4;
        DBMS_OUTPUT.PUT_LINE('Na 4 oddeleni je celkem ' || TO_CHAR(v_cnt) || 
    ' zamìstnancùm a jejich prumerna mzda je '  || TO_CHAR(ROUND(v_salaries)) ||  ' eur.');
    END;
    
    --funkce scita vic cisla 
    CREATE OR REPLACE FUNCTION addNumbers1(pNumber1 NUMBER,pNumber2 NUMBER)
    RETURN NUMBER IS
        v_result NUMBER;
    BEGIN
        SELECT (pNumber1 + pNumber2)
        INTO v_result
        FROM dual;
        RETURN v_result;
    END addNumbers1;
    /
     CREATE OR REPLACE FUNCTION addNumbers2(pNumber1 NUMBER,pNumber2 NUMBER)
    RETURN NUMBER IS
        v_result NUMBER;
    BEGIN
        v_result := pNumber1 + pNumber2;
        RETURN v_result;
    END addNumbers2;
    / -- ukoncovani bloku
    SELECT addNumbers1(5,6) FROM DUAL;
    SELECT addNumbers2(5,6) FROM DUAL;
    
    
    CREATE OR REPLACE FUNCTION avgSalDept(nDept NUMBER)
    RETURN NUMBER IS
        v_result NUMBER;
    BEGIN
        SELECT AVG(SALARY) INTO v_result FROM EMPLOYEES WHERE DEPT_ID = nDept;
        RETURN ROUND(v_result);
    END avgSalDept;
    /
    SELECT avgSalDept(1)FROM dual;
    SELECT avgSalDept(2)FROM dual;
    SELECT avgSalDept(3)FROM dual;
    SELECT avgSalDept(4)FROM dual;
    
    -- procedury
    --procedury pl vypise text
    CREATE OR REPLACE PROCEDURE pl(pText IN VARCHAR2) IS
BEGIN
    DBMS_OUTPUT.PUT_LINE(pText);
END pl;
/

EXECUTE pl('Hi!');

--procedura vypise info o cloveku, jehoz id zname - procedura empInfo

CREATE OR REPLACE PROCEDURE empInfo(pId IN NUMBER) IS
    v_firstName EMPLOYEES.FIRST_NAME%TYPE;
    v_lastName EMPLOYEES.LAST_NAME%TYPE;
    v_salary EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT FIRST_NAME INTO v_firstName FROM EMPLOYEES WHERE ID = pId;
    SELECT LAST_NAME INTO v_lastName FROM EMPLOYEES WHERE ID = pId;
    SELECT SALARY INTO v_salary FROM EMPLOYEES WHERE ID = pId;
    pl(v_firstName || ' ' || v_lastName || ' má výplatu ' || TO_CHAR(v_salary)|| ' EUR');
    
END empInfo;
/

execute empinfo(1);


CREATE OR REPLACE PROCEDURE empInfoRec(pId IN NUMBER) IS
    r_emp EMPLOYEES%ROWTYPE;
    BEGIN
        SELECT * INTO r_emp FROM EMPLOYEES WHERE ID = pID;
        pl(r_emp.FIRST_NAME || ' ' || r_emp.LAST_NAME || ' ma vyplatu ' || TO_CHAR(r_emp.SALARY) || ' EUR');
    END empInfoRec;
    /
    
execute empinforec(1);

CREATE OR REPLACE PROCEDURE deptInfo(pId IN NUMBER) IS
    r_emp EMPLOYEES%ROWTYPE;
    v_cnt NUMBER;
    v_salary NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_cnt FROM EMPLOYEES WHERE DEPT_ID = pID;
        SELECT SUM(SALARY)INTO v_salary FROM EMPLOYEES WHERE DEPT_ID = pID;
        
        pl('Oddeleni cislo ' || pID || ' ma celkem ' || v_cnt || ' zamestnance a firma zaplati na jejich mzdach celkem ' || ROUND(v_salary) || ' EUR');
    END deptInfo;
    /
    
    EXECUTE deptInfo(1);
    
    
--kurzory
--anonymní blok, který vypíše jméno a pøíjmení jako jeden øetìzec
BEGIN
    FOR r_emp IN (
        SELECT FIRST_NAME, 
            LAST_NAME 
        FROM EMPLOYEES
    )
    LOOP
        pl( r_emp.FIRST_NAME ||' '|| r_emp.LAST_NAME);
    END LOOP;
END;
/

SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES;

--EXPLICITNÍ

DECLARE
    CURSOR c_emp IS
        SELECT
            FIRST_NAME,
            LAST_NAME
        FROM EMPLOYEES;
    r_emp c_emp%ROWTYPE;   
BEGIN
    FOR r_emp IN c_emp
    LOOP
        pl( r_emp.FIRST_NAME ||' '|| r_emp.LAST_NAME);
    END LOOP;
END;
/


DECLARE
    CURSOR c_emp IS
        SELECT
            FIRST_NAME,
            LAST_NAME
        FROM EMPLOYEES;
    r_emp c_emp%ROWTYPE;   
BEGIN
    
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO r_emp;
        EXIT WHEN c_emp%NOTFOUND;
        pl( r_emp.FIRST_NAME ||' '|| r_emp.LAST_NAME);
    END LOOP;
    CLOSE c_emp;
END;
/

-- uprava uppercase pro jmeno a a lowercase pro prijemni pridani 10000 na vzplatu vypis procedurz pl 
DECLARE
    CURSOR c_emp IS
        SELECT
            FIRST_NAME,
            LAST_NAME,
            SALARY
        FROM EMPLOYEES;
    r_emp c_emp%ROWTYPE;   
BEGIN
    
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO r_emp;
        EXIT WHEN c_emp%NOTFOUND;
        pl( UPPER(r_emp.FIRST_NAME) ||' '|| LOWER(r_emp.LAST_NAME) || ' vyplata ' || TO_CHAR(r_emp.SALARY+ 10000));
    END LOOP;
    CLOSE c_emp;
END;
/

--TRIGGER
CREATE OR REPLACE TRIGGER TR_EMPLOYEES_BI
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
BEGIN
    IF(:NEW.ID IS NULL) THEN
        SELECT SQ_EMPLOYEES.NEXTVAL
        INTO :NEW.ID
        FROM DUAL;
    END IF;
END;
/

INSERT INTO EMPLOYEES (FIRST_NAME, LAST_NAME, DEPT_ID, SALARY) 
VALUES ('Joanna', 'Trench', 1, 75000);
commit;

CREATE OR REPLACE TRIGGER TR_EMPLOYEES_BU
BEFORE UPDATE ON EMPLOYEES
FOR EACH ROW
BEGIN
    :NEW.VERSION := :OLD.VERSION + 1;
END;
/

UPDATE employees SET SALARY=60000 WHERE ID=12;
COMMIT;

