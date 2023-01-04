create database Brokerage_firm

use Brokerage_firm
go


SET BLOCKSIZE to 128;

create schema schBrokerage

go

create table Employee
(
SSN int identity (1,1) primary key NOT NULL,
Fname nvarchar(50),
Minit varchar,
Lname nvarchar(50),
Bdate DATE,
Address_ nvarchar(50),
Sex tinyint check(Sex between 0 and 2),
Salary int
);

create index idx_Salary_SSN on Employee(Salary,SSN)

create index idx_Salary on Employee(Salary)

drop index idx_Salary on Employee
drop index idx_Salary_SSN on Employee


create table Department
(
Dname nvarchar(50),
Dnumber int identity (1,1) Primary Key NOT NULL,
Mgr_SSN int foreign key references Employee(SSN),
Mgr_Start_Date DATE
);


alter table Employee
add DNO int foreign key references Department(Dnumber);


alter table Employee
add Super_SSN int foreign key references Employee(SSN);


create table Project
(
Pname nvarchar(50),
Pnumber INT unique identity (1,1) NOT NULL,
Plocation nvarchar(50) NOT NULL,
DNO INT foreign key references Department(Dnumber),
CONSTRAINT Project_KEY_COMPOSITE PRIMARY KEY (Pnumber, Plocation)
);

--select * from Project where (Pnumber = 10);

create table Intern
(
SSN bigint identity (3000000,1) primary key Not NULL,
Fname nvarchar(50),
Minit varchar,
Lname nvarchar(50),
Bdate DATE,
Address_ nvarchar(50),
Sex tinyint check(Sex between 0 and 2),
Salary int,
Major nvarchar(50),
Super_SSN int foreign key references Employee(SSN)
);

--drop table Intern;

--select count(*) from Project;
--delete from Contracts;


create table Contracts
(
Name_Company nvarchar(50),
Date_created DATE,
ProjectID int foreign key references Project(Pnumber),
Product nvarchar(50),
Price int,
Date_of_Contract DATE,
Emp_Name nvarchar(50),
Emp_SSN int foreign key references Employee(SSN),
Contractor_Name nvarchar(50),
Cont_SSN int,
Delivery_Location nvarchar(50),
CONSTRAINT Contracts_KEY_COMPOSITE PRIMARY KEY (Product, Emp_SSN, Cont_SSN)
);


create table Dept_Locations
(
Dnumber INT Identity (1,1) foreign key references Department(Dnumber),
Dlocation nvarchar(50) NOT NULL,
CONSTRAINT Department_KEY_COMPOSITE PRIMARY KEY (Dnumber, Dlocation)
);


create table Works_On
(
ESSN INT foreign key references Employee(SSN),
PNO INT foreign key references Project(Pnumber),
Hours INT,
CONSTRAINT WorksOn_KEY_COMPOSITE PRIMARY KEY (ESSN, PNO)
);


create table Dependent_
(
ESSN INT foreign key references Employee(SSN),
Dependent_Name nvarchar(50) NOT NULL,
Sex tinyint check(Sex between 0 and 2),
Bdate DATE,
Relationship nvarchar(50),
CONSTRAINT Dependent_KEY_COMPOSITE PRIMARY KEY (ESSN, Dependent_Name)
);


INSERT INTO Employee(Fname, Minit, Lname, Bdate, Address_, Sex, Salary) Values ('ayman','m','MOh', '11/11/2000', 'ahmed', 2, 3000);


SELECT * FROM sys.dm_db_index_physical_stats (DB_ID(N'Brokerage_firm'), OBJECT_ID(N'[Intern].[SSN]'), NULL, NULL , 'DETAILED');



SELECT
  database_id AS DatabaseID,
  DB_NAME(database_id) AS DatabaseName,
  COUNT(file_id) * 8/1024.0 AS BufferSizeInMB
FROM sys.dm_os_buffer_descriptors
GROUP BY DB_NAME(database_id),database_id
ORDER BY BufferSizeInMB DESC
GO 


select count(*) from Employee as E, Department as D, Project as P  where P.DNO = D.Dnumber and D.Mgr_SSN = E.SSN and E.Salary < 90000 group by E.Salary;



select * from (Employee cross join Department) as emp_dep where emp_dep.Salary > 5000 and emp_dep.Dnumber > 1 and emp_dep.DNO = emp_dep.Dnumber;



select * from (Employee cross join Contracts) as emp_cont, Project as p where emp_cont.Salary > 5000 and emp_cont.SSN = emp_cont.Emp_SSN and emp_cont.PNO = p.Pnumber and p.DNO > 1;


select * from employee as e cross join department as d where e.Salary > 5000 and d.Dnumber > 1 and e.DNO = d.Dnumber;

select * from Employee as e cross join Contracts as c, Project as p where e.Salary > 5000 and e.SSN = c.Emp_SSN  and p.DNO > 1;