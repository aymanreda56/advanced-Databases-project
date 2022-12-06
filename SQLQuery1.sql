create database Brokerage_firm

use Brokerage_firm
go

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


create table Dept_Locations
(
Dnumber INT foreign key references Department(Dnumber),
Dlocation nvarchar(50) NOT NULL,
CONSTRAINT Department_KEY_COMPOSITE PRIMARY KEY (Dnumber, Dlocation)
);

create table Project
(
Pname nvarchar(50),
Pnumber INT unique identity (1,1) NOT NULL,
Plocation nvarchar(50) NOT NULL,
DNO INT foreign key references Department(Dnumber),
CONSTRAINT Project_KEY_COMPOSITE PRIMARY KEY (Pnumber, Plocation)
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
