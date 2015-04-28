
CREATE TABLE LOCATIONS(
  LOCATION_ID INT(8) PRIMARY KEY AUTO_INCREMENT,
  STREET_ADDRESS VARCHAR(40),
  POSTAL_CODE VARCHAR(30),
  CITY VARCHAR(30) NOT NULL,
  STATE_PROVINCE VARCHAR(25)
);

CREATE TABLE DEPARTAMENTS(
  DEPARTMENT_ID INT PRIMARY KEY AUTO_INCREMENT,
  DEPARTMENT_NAME VARCHAR(30),
  LOCATION_ID INT
);


CREATE TABLE JOBS(
  JOB_ID INT PRIMARY KEY AUTO_INCREMENT,
  JOB_TITLE VARCHAR(35),
  MIN_SALARY INT,
  MAX_SALARY INT
);

CREATE TABLE EMPLOYEES(
  EMPLOYEE_ID INT PRIMARY KEY AUTO_INCREMENT,
  FIRST_NAME VARCHAR(20),
  LAST_NAME VARCHAR(25) NOT NULL,
  EMAIL VARCHAR(25) NOT NULL,
  PHONE_NUMBER VARCHAR(20),
  HIRE_DATE DATE NOT NULL,
  JOB_ID INT NOT NULL,
  SALARY DECIMAL(8,2),
  COMMIISSION_PCT DECIMAL(2,2),
  MANAGER_ID INT,
  DEPARTMENT_ID INT
);



ALTER TABLE EMPLOYEES ADD FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES (EMPLOYEE_ID);
ALTER TABLE EMPLOYEES ADD FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTAMENTS (DEPARTMENT_ID);
ALTER TABLE EMPLOYEES ADD FOREIGN KEY (JOB_ID) REFERENCES JOBS (JOB_ID);
ALTER TABLE DEPARTAMENTS ADD FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS (LOCATION_ID);



INSERT INTO LOCATIONS VALUES (1700, 'Str.LALA', '97634', 'Bucuresti', 'Bucuresti');
INSERT INTO DEPARTAMENTS VALUES (1, 'Administrator', 1700);
INSERT INTO JOBS VALUES (1, 'President', 20000, 40000);
INSERT INTO EMPLOYEES VALUES (1, 'Steven', 'Sking', 'lala@email.com', '515.123.4567', now(), '1', 24000, NULL, NULL, 1);


ROLLBACK;


COMMIT;


ALTER TABLE EMPLOYEES DROP FOREIGN KEY employees_ibfk_3;


ALTER TABLE EMPLOYEES MODIFY COLUMN JOB_ID VARCHAR(10);
ALTER TABLE JOBS MODIFY  COLUMN JOB_ID VARCHAR(10);


ALTER TABLE EMPLOYEES ADD FOREIGN KEY (JOB_ID) REFERENCES JOBS (JOB_ID);



SELECT * FROM employees;


SELECT * FROM departments;


SELECT * FROM jobs;


SELECT first_name, last_name
FROM employees;



SELECT *
FROM employees
WHERE department_id = 50;



UPDATE employees
SET salary = salary * 1.3
WHERE department_id = 50;


DELETE FROM employees
WHERE employee_id = 101;



SELECT *
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name;




SELECT e.*, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
      AND d.department_id = 50;



SELECT COUNT(employee_id)
FROM employees emp
WHERE emp.JOB_ID = 'IT_PROG';


SELECT *
FROM employees e, departments d
WHERE e.department_id = d.department_id
      AND d.location_id = (SELECT location_id
                           FROM locations
                           WHERE LOWER(city) = 'seattle');



CREATE VIEW emp_dep_view AS
  SELECT first_name, last_name, department_name
  FROM employees e, departments d
  WHERE e.department_id = d.department_id;


SELECT * FROM emp_dep_view;


SELECT CURRENT_TIME FROM dual;


SELECT DATE_FORMAT(SYSDATE(), '%Y-%m-%d');


SELECT DATE_FORMAT(STR_TO_DATE('25-11-2014', 'dd-MM-yyyy'), 'dd-MM-yyyy') FROM dual;



SELECT UPPER(first_name) "First Name", LOWER(email) "Email"
FROM employees;


SELECT CONCAT('First Name: ', first_name) "First Name"
FROM employees;


SELECT COUNT(*) "Total nr. of employees"
FROM employees;




SELECT COUNT(*) "Total nr. of IT_PROG"
FROM employees
WHERE job_id = 'IT_PROG';




SELECT department_id, COUNT(*) "Nr. of employees per dept."
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
ORDER BY 2 DESC;



SELECT SUM(salary) "Total salary of dept. 50"
FROM employees
WHERE department_id = 50;



SELECT MAX(salary) "Maximum salary in dept 50", MIN(salary) "Minimum salary in dept 50"
FROM employees
WHERE department_id = 50;