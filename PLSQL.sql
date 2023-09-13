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
        RETURN v_result;
    END avgSalDept;
    /
    SELECT avgSalDept(1)FROM dual;
    SELECT avgSalDept(2)FROM dual;
    SELECT avgSalDept(3)FROM dual;
    SELECT avgSalDept(4)FROM dual;