-- Drop schema azure_company;

-- ===========================================
--  SCHEMA
-- ===========================================
CREATE SCHEMA IF NOT EXISTS azure_company;
USE azure_company;

-- ===========================================
--  TABELA: employee
-- ===========================================
CREATE TABLE employee (
    Fname VARCHAR(15) NOT NULL,
    Minit CHAR(1),
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) NOT NULL,
    Bdate DATE,
    Address VARCHAR(30),
    Sex CHAR(1),
    Salary DECIMAL(10,2),
    Super_ssn CHAR(9),
    Dno INT NOT NULL DEFAULT 1,
    
    CONSTRAINT chk_salary_employee CHECK (Salary > 2000),
    CONSTRAINT pk_employee PRIMARY KEY (Ssn),
    CONSTRAINT fk_supervisor FOREIGN KEY (Super_ssn)
        REFERENCES employee(Ssn)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- ===========================================
--  TABELA: departament
-- ===========================================
CREATE TABLE departament (
    Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn CHAR(9) NOT NULL,
    Mgr_start_date DATE,
    Dept_create_date DATE,

    CONSTRAINT pk_dept PRIMARY KEY (Dnumber),
    CONSTRAINT unique_name_dept UNIQUE (Dname),
    CONSTRAINT chk_date_dept CHECK (Dept_create_date < Mgr_start_date),
    CONSTRAINT fk_dept_manager FOREIGN KEY (Mgr_ssn)
        REFERENCES employee(Ssn)
        ON UPDATE CASCADE
);

-- ===========================================
--  TABELA: dept_locations
-- ===========================================
CREATE TABLE dept_locations (
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(15) NOT NULL,

    CONSTRAINT pk_dept_locations PRIMARY KEY (Dnumber, Dlocation),
    CONSTRAINT fk_dept_locations FOREIGN KEY (Dnumber)
        REFERENCES departament(Dnumber)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ===========================================
--  TABELA: project
-- ===========================================
CREATE TABLE project (
    Pname VARCHAR(15) NOT NULL,
    Pnumber INT NOT NULL,
    Plocation VARCHAR(15),
    Dnum INT NOT NULL,

    CONSTRAINT pk_project PRIMARY KEY (Pnumber),
    CONSTRAINT unique_project UNIQUE (Pname),
    CONSTRAINT fk_project_dept FOREIGN KEY (Dnum)
        REFERENCES departament (Dnumber)
);

-- ===========================================
--  TABELA: works_on
-- ===========================================
CREATE TABLE works_on (
    Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3,1) NOT NULL,

    CONSTRAINT pk_works_on PRIMARY KEY (Essn, Pno),
    CONSTRAINT fk_works_emp FOREIGN KEY (Essn)
        REFERENCES employee(Ssn),
    CONSTRAINT fk_works_proj FOREIGN KEY (Pno)
        REFERENCES project(Pnumber)
);

-- ===========================================
--  TABELA: dependent
-- ===========================================
CREATE TABLE dependent (
    Essn CHAR(9) NOT NULL,
    Dependent_name VARCHAR(15) NOT NULL,
    Sex CHAR(1),
    Bdate DATE,
    Relationship VARCHAR(8),

    CONSTRAINT pk_dependent PRIMARY KEY (Essn, Dependent_name),
    CONSTRAINT fk_dependent FOREIGN KEY (Essn)
        REFERENCES employee(Ssn)
);

-- ===========================================
--  INSERÇÃO DE DADOS
-- ===========================================
-- 1) SUPERVISORES (não possuem Super_ssn)
INSERT INTO employee (
    Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno
) VALUES
    ('James',    'E', 'Borg',    '888665555', '1937-11-10', '450-Stone-Houston-TX', 'M', 55000, NULL, 1),
    ('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291-Berry-Bellaire-TX', 'F', 43000, NULL, 4),
    ('Franklin', 'T', 'Wong',    '333445555', '1955-12-08', '638-Voss-Houston-TX',   'M', 40000, NULL, 5);

-- 2) SUBORDINADOS
INSERT INTO employee (
    Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno
) VALUES
    ('John',     'B', 'Smith',   '123456789', '1965-01-09', '731-Fondren-Houston-TX', 'M', 30000, '333445555', 5),
    ('Alicia',   'J', 'Zelaya',  '999887777', '1968-01-19', '3321-Castle-Spring-TX',  'F', 25000, '987654321', 4),
    ('Ramesh',   'K', 'Narayan', '666884444', '1962-09-15', '975-Fire-Oak-Humble-TX', 'M', 38000, '333445555', 5),
    ('Joyce',    'A', 'English', '453453453', '1972-07-31', '5631-Rice-Houston-TX',   'F', 25000, '333445555', 5),
    ('Ahmad',    'V', 'Jabbar',  '987987987', '1969-03-29', '980-Dallas-Houston-TX',  'M', 25000, '987654321', 4);

-- ===========================================
-- 3) DEPARTAMENTOS
INSERT INTO departament (
    Dname, Dnumber, Mgr_ssn, Mgr_start_date, Dept_create_date
) VALUES
    ('Research',        5, '333445555', '1988-05-22', '1986-05-22'),
    ('Administration',  4, '987654321', '1995-01-01', '1994-01-01'),
    ('Headquarters',    1, '888665555', '1981-06-19', '1980-06-19');

-- ===========================================
-- 4) LOCALIZAÇÕES DOS DEPARTAMENTOS
INSERT INTO dept_locations (Dnumber, Dlocation) VALUES
    (1, 'Houston'),
    (4, 'Stafford'),
    (5, 'Bellaire'),
    (5, 'Sugarland'),
    (5, 'Houston');

-- ===========================================
-- 5) PROJETOS
INSERT INTO project (Pname, Pnumber, Plocation, Dnum) VALUES
    ('ProductX',        1,  'Bellaire', 5),
    ('ProductY',        2,  'Sugarland', 5),
    ('ProductZ',        3,  'Houston', 5),
    ('Computerization', 10, 'Stafford', 4),
    ('Reorganization',  20, 'Houston', 1),
    ('Newbenefits',     30, 'Stafford', 4);

-- ===========================================
-- 6) PARTICIPAÇÃO EM PROJETOS
INSERT INTO works_on (Essn, Pno, Hours) VALUES
    ('123456789', 1, 32.5),
    ('123456789', 2,  7.5),
    ('666884444', 3, 40.0),
    ('453453453', 1, 20.0),
    ('453453453', 2, 20.0),
    ('333445555', 2, 10.0),
    ('333445555', 3, 10.0),
    ('333445555', 10,10.0),
    ('333445555', 20,10.0),
    ('999887777', 30,30.0),
    ('999887777', 10,10.0),
    ('987987987', 10,35.0),
    ('987987987', 30, 5.0),
    ('987654321', 30,25.0),
    ('987654321', 20,15.0),
    ('888665555', 20,40.0);

-- ===========================================
-- 7) DEPENDENTES
INSERT INTO dependent (
    Essn, Dependent_name, Sex, Bdate, Relationship
) VALUES
    ('333445555', 'Alice',     'F', '1986-04-05', 'Daughter'),
    ('333445555', 'Theodore',  'M', '1983-10-25', 'Son'),
    ('333445555', 'Joy',       'F', '1958-05-03', 'Spouse'),
    ('987654321', 'Abner',     'M', '1942-02-28', 'Spouse'),
    ('123456789', 'Michael',   'M', '1988-01-04', 'Son'),
    ('123456789', 'Alice',     'F', '1988-12-30', 'Daughter'),
    ('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');


-- Consultas SQL

select * from employee;
select Ssn, count(ssn) from employee e, dependent d 
	where (e.Ssn = d.Essn)
    group by e.ssn;
select * from dependent;

SELECT Bdate, Address FROM employee
WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

select * from departament where Dname = 'Research';

SELECT Fname, Lname, Address
FROM employee, departament
WHERE Dname = 'Research' AND Dnumber = Dno;

select * from project;
--
--
--
-- Expressões e concatenação de strings
--
--
-- recuperando informações dos departamentos presentes em Stafford
select Dname as Department, Mgr_ssn as Manager from departament d, dept_locations l
where d.Dnumber = l.Dnumber;

-- padrão sql -> || no MySQL usa a função concat()
select Dname as Department, concat(Fname, ' ', Lname) as Name from departament d, dept_locations l, employee e
where d.Dnumber = l.Dnumber and Mgr_ssn = e.Ssn;

select * from departament, project;
-- recuperando info dos projetos em Stafford
select * from project, departament where Dnum = Dnumber and Plocation = 'Stafford';

-- recuperando info sobre os departamentos e projetos localizados em Stafford
SELECT  p.Pnumber, p.Dnum, e.Lname, e.Address, e.Bdate FROM project p
	JOIN departament d 
		ON p.Dnum = d.Dnumber
	JOIN employee e
		ON d.Mgr_ssn = e.Ssn
WHERE p.Plocation = 'Stafford';


SELECT * FROM employee WHERE Dno IN (3,6,9);

--
--
-- Operadores lógicos
--
--

SELECT Bdate, Address
FROM EMPLOYEE
WHERE Fname = ‘John’ AND Minit = ‘B’ AND Lname = ‘Smith’;

SELECT Fname, Lname, Address
FROM EMPLOYEE, DEPARTMENT
WHERE Dname = ‘Research’ AND Dnumber = Dno;