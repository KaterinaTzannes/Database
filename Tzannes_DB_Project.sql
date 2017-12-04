-- Katerina Tzannes --
-- Car Wash Database --

DROP TABLE IF EXISTS people CASCADE;
DROP TABLE IF EXISTS make CASCADE;
DROP TABLE IF EXISTS model CASCADE;
DROP TABLE IF EXISTS vehicle CASCADE;
DROP TABLE IF EXISTS positions CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS jobs CASCADE;
DROP TABLE IF EXISTS managers CASCADE;
DROP TABLE IF EXISTS service CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS awesomeCustomers CASCADE;

DROP ROLE IF EXISTS admin;
DROP ROLE IF EXISTS employee;

--- People Table ---
CREATE TABLE people (
	pid	       char(4) NOT NULL,
	firstName      text,
	lastName       text,
	dob 	       date,
	phoneNumber    char(10),
      primary key(pid)
);

--- Managers Table ---
CREATE TABLE  managers(
	pid		char(4) NOT NULL references people(pid),
	promotionDate	date,
       primary key (pid)
);

--- Make Table ---
CREATE TABLE make(
	makeID		char(7) NOT NULL, 
	manufacturer	text,
      primary key(makeID)
);

--- Model Table ---
CREATE TABLE model(
	modelID		char(8) NOT NULL,
	makeID		char(7) NOT NULL references make(makeID),
	modelName	text,
	year		int,
      primary key(makeID, modelID)
      
);

--- Positions Table ---
CREATE TABLE positions(
	positionID	char(6) NOT NULL,
	jobTitle	text,
	description	text,
      primary key (positionID)
);

--- Vehicle Table ---
CREATE TABLE vehicle (
	VIN	  text NOT NULL,
	pid	  char(4) NOT NULL references people(pid),
	makeID	  char(7) NOT NULL ,
	modelID   char(8) NOT NULL,
	regNum    text,
	capacity  int,
	odometer  int,
	color	  text,
      primary key(VIN)--,
      FOREIGN KEY (makeID, modelID) references model(modelID, makeID)
);


--- Service Table ---
CREATE TABLE service(
	VIN 		text NOT NULL references vehicle(VIN),
	dateOfService	date NOT NULL,
	exterior	text DEFAULT 'No',
	interior	text DEFAULT 'No',
	priceUSD	numeric (10,2),
	paymentType	text,
       primary key(dateOfService, VIN),
       CONSTRAINT check_interior CHECK
		(interior='yes' OR interior='no' OR interior='Yes' OR interior='No'),
       CONSTRAINT check_exterior CHECK
		(exterior='yes' OR exterior='no' OR exterior='Yes' OR exterior='No')
);

--- Customers Table ---
CREATE TABLE customers(
	pid		char(4) NOT NULL references people(pid),
	aquisitionDate	date,
      primary key(pid)
);

--- AwesomeCustomers Table ---
CREATE TABLE awesomeCustomers(
	pid		char(4) NOT NULL references people(pid),
	visits		int,
      primary key (pid)
);

--- Jobs Table ---
CREATE TABLE jobs(
	positionID	char(6) NOT NULL references positions(positionID),
	pid		char(4) NOT NULL references people(pid),
       primary key (positionID, pid)
);

--- Employees Table ---
CREATE TABLE employees(
	pid		char(4) NOT NULL references people(pid),
	hourlyRateUSD	numeric (8,2),
	hireDate	date,
	positionID	char(6)	NOT NULL references positions(positionID),
	goldStar	text DEFAULT 'No',
       primary key (pid),
       CONSTRAINT gotGold CHECK 
		(goldStar = 'yes' OR goldStar = 'no' OR goldStar = 'Yes' OR goldStar = 'No')
);

--- Sample Data People---

INSERT INTO people (pid, firstName, lastName, DOB, phoneNumber)
VALUES ('p001', 'Alan', 'Labouseur', '01-01-1975', '1234567890') ;

INSERT INTO people (pid, firstName, lastName, DOB, phoneNumber)
VALUES ('p002', 'Katerina', 'Tzannes', '09-09-1998', '5161234567') ;

INSERT INTO people (pid, firstName, lastName, DOB, phoneNumber)
VALUES ('p003', 'Andrew', 'Bauman', '03-01-1998', '8451234567') ;

INSERT INTO people (pid, firstName, lastName, DOB, phoneNumber)
VALUES ('p004', 'Chris', 'Lowman', '07-28-1998', '6311234567') ;

INSERT INTO people (pid, firstName, lastName, DOB, phoneNumber)
VALUES ('p005', 'Annisa', 'Santiago', '06-29-1988', '2017899990') ;

INSERT INTO people (pid, firstName, lastName, DOB, phoneNumber)
VALUES ('p006', 'Liz', 'Latta', '12-12-1998', '9177765634') ;

INSERT INTO people (pid, firstName, lastName, DOB, phoneNumber)
VALUES ('p007', 'Richard', 'Latta', '11-10-1998', '3478891232') ;

INSERT INTO people (pid, firstName, lastName, DOB, phoneNumber)
VALUES ('p008', 'Jayla', 'Merry', '12-17-1958', '9098801254') ;

INSERT INTO people (pid, firstName, lastName, DOB, phoneNumber)
VALUES ('p901', 'Ilana', 'Blumstein', '02-02-1952', '8090001254') ;

INSERT INTO people (pid, firstName, lastName, DOB, phoneNumber)
VALUES ('p902', 'Andrew', 'Bauman', '03-19-1968', '5168801254') ;

INSERT INTO people (pid, firstName, lastName, DOB, phoneNumber)
VALUES ('p903', 'Leo', 'Durante', '10-19-1948', '6470801250') ;

INSERT INTO people (pid, firstName, lastName, DOB, phoneNumber)
VALUES ('p904', 'Gennaro', 'Ottamaneli', '11-16-1949', '6470801250') ;

INSERT INTO people (pid, firstName, lastName, DOB, phoneNumber)
VALUES ('p905', 'Dean', 'Zouvelos', '12-19-1964', '6470801250') ;

INSERT INTO people (pid, firstName, lastName, DOB, phoneNumber)
VALUES ('p906', 'Olga', 'Holevas', '12-30-1957', '6470801250') ;

--- Sample Data Make ---

INSERT INTO make (makeID, manufacturer)
VALUES ('make001', 'Bently') ;

INSERT INTO make (makeID, manufacturer)
VALUES ('make002', 'Porsche') ;

INSERT INTO make (makeID, manufacturer)
VALUES ('make003', 'Honda') ;

INSERT INTO make (makeID, manufacturer)
VALUES ('make004', 'BMW') ;

INSERT INTO make (makeID, manufacturer)
VALUES ('make005', 'Ford') ;

INSERT INTO make (makeID, manufacturer)
VALUES ('make006', 'Dodge') ;

INSERT INTO make (makeID, manufacturer)
VALUES ('make007', 'Mini Cooper') ;


--- Sample Data Model ---

INSERT INTO model (makeID, modelID, modelName, year)
VALUES ('make001', 'model001', 'Hunaudieres', '2019') ;

INSERT INTO model (makeID, modelID, modelName, year)
VALUES ('make002', 'model002', '911 Turbo S', '2018') ;

INSERT INTO model (makeID, modelID, modelName, year)
VALUES ('make003', 'model003', 'Ridgline', '2011') ;

INSERT INTO model (makeID, modelID, modelName, year)
VALUES ('make004', 'model004', 'i8', '2015') ;

INSERT INTO model (makeID, modelID, modelName, year)
VALUES ('make005', 'model005', 'Exhibition', '2012') ;

INSERT INTO model (makeID, modelID, modelName, year)
VALUES ('make006', 'model006', 'Hellcat', '2002') ;

INSERT INTO model (makeID, modelID, modelName,  year)
VALUES ('make007', 'model007', 'Cooper S', '2014') ;


--- Sample Data Vehicles ---

INSERT INTO vehicle (VIN, pid, makeID, modelID, regNum, capacity, odometer, color)
VALUES ('KJDKN3DUXC1536981', 'p001', 'make001', 'model001', '224GYW', '2', '132', 'black') ;

INSERT INTO vehicle (VIN, pid, makeID, modelID, regNum, capacity, odometer, color)
VALUES ('JTDKN3DU7C1576997', 'p002', 'make002', 'model002', '373HJW', '2', '120000', 'white') ;

INSERT INTO vehicle (VIN, pid, makeID, modelID, regNum, capacity, odometer, color)
VALUES ('2C4RC1BG9ER217847', 'p003', 'make003', 'model003', '222HJK', '5', '200', 'white') ;

INSERT INTO vehicle (VIN, pid, makeID, modelID, regNum, capacity, odometer, color)
VALUES ('3GCPCTE03CG256200', 'p004', 'make004', 'model004', '903KYW', '2', '11248', 'blue') ;

INSERT INTO vehicle (VIN, pid, makeID, modelID, regNum, capacity, odometer, color)
VALUES ('2FMDK39C17BB55672', 'p005', 'make005', 'model005', '391SQW', '5', '6382', 'grey') ;

INSERT INTO vehicle (VIN, pid, makeID, modelID, regNum, capacity, odometer, color)
VALUES ('JN1AZ34E54T030166', 'p006', 'make006', 'model006', '628BEV', '4', '726', 'red') ;

INSERT INTO vehicle (VIN, pid, makeID, modelID, regNum, capacity, odometer, color)
VALUES ('1GCNKPEC3EZ270189', 'p007', 'make007', 'model007', '397JZW', '4', '5000', 'green') ;

--- Sample Data Positions ---
INSERT INTO positions (positionID, jobTitle, description)
VALUES ('pos001', 'manager', 'manages car wash business') ;

INSERT INTO positions (positionID, jobTitle, description)
VALUES ('pos002', 'washer', 'uses soap to wash exterior car') ;

INSERT INTO positions (positionID, jobTitle, description)
VALUES ('pos003', 'rinser', 'rinses soap off vehicle') ;

INSERT INTO positions (positionID, jobTitle, description)
VALUES ('pos004', 'soaker', 'wets exterior vehicle before soap is applied') ;

INSERT INTO positions (positionID, jobTitle, description)
VALUES ('pos005', 'dryer', 'drys exterior of vehicle after wash') ;

INSERT INTO positions (positionID, jobTitle, description)
VALUES ('pos006', 'wiper', 'wipes interior of vehicle') ;

INSERT INTO positions (positionID, jobTitle, description)
VALUES ('pos007', 'window cleaner', 'shines window on vehicle to create illusion of no glass') ;

INSERT INTO positions (positionID, jobTitle, description)
VALUES ('pos008', 'vaccum', 'vaccumes interior of vehicle') ;

INSERT INTO positions (positionID, jobTitle, description)
VALUES ('pos009', 'mover', 'moves and parks vehicles') ;

INSERT INTO positions (positionID, jobTitle, description)
VALUES ('pos010', 'secretary', 'does office work') ;

INSERT INTO positions (positionID, jobTitle, description)
VALUES ('pos011', 'cashier', 'charges customers and accepts payments') ;



--- Sample Data Employees ---

INSERT INTO employees (pid, positionID, hourlyRateUSD, hireDate, goldStar)
VALUES ('p901', 'pos001', '10.00', '05-06-2009', 'no') ;

INSERT INTO employees (pid, positionID, hourlyRateUSD, hireDate, goldstar)
VALUES ('p902', 'pos001', '13.00', '02-09-2010', 'yes') ;

INSERT INTO employees (pid, hourlyRateUSD, hireDate, positionID, goldstar)
VALUES ('p903', '9.00', '09-26-2014', 'pos001', 'no') ;

INSERT INTO employees (pid, hourlyRateUSD, hireDate, positionID, goldStar)
VALUES ('p904', '6.01', '10-31-2015', 'pos002', 'yes') ;

INSERT INTO employees (pid, hourlyRateUSD, hireDate, positionID, goldStar)
VALUES ('p905', '12.00', '01-16-2016', 'pos003', 'no') ;

INSERT INTO employees (pid, hourlyRateUSD, hireDate, positionID, goldStar)
VALUES ('p906', '20.00', '08-06-2016', 'pos004', 'no') ;


--- Sample Data Jobs ---
INSERT INTO jobs (positionID, PID)
VALUES ('pos001', 'p901') ;

INSERT INTO jobs (positionID, PID)
VALUES ('pos002', 'p902') ;

INSERT INTO jobs (positionID, PID)
VALUES ('pos003', 'p903') ;

INSERT INTO jobs (positionID, PID)
VALUES ('pos004', 'p904') ;

INSERT INTO jobs (positionID, PID)
VALUES ('pos005', 'p905') ;

INSERT INTO jobs (positionID, PID)
VALUES ('pos006', 'p906') ;



--- Sample Data Managers---
INSERT INTO managers (pid, promotionDate)
VALUES ('p901', '11-11-2015') ;

INSERT INTO managers (pid, promotionDate)
VALUES ('p902', '08-25-2016') ;

INSERT INTO managers (pid, promotionDate)
VALUES ('p903', '01-01-2005') ;

--- Sample Data Service ---
INSERT INTO service (dateOfService, VIN, exterior, interior, priceUSD, paymentType)
VALUES ('11-12-2015', 'KJDKN3DUXC1536981', 'yes', 'yes', '10', 'cash') ;

INSERT INTO service (dateOfService, VIN, exterior, interior, priceUSD, paymentType)
VALUES ('11-13-2015', 'KJDKN3DUXC1536981', 'yes', 'yes', '20', 'credit') ;

INSERT INTO service (dateOfService, VIN, exterior, interior, priceUSD, paymentType)
VALUES ('11-12-2014', 'JTDKN3DU7C1576997', 'yes', 'no', '14', 'cash') ;

INSERT INTO service (dateOfService, VIN, exterior, interior, priceUSD, paymentType)
VALUES ('10-12-2015', '2C4RC1BG9ER217847', 'no', 'yes', '9', 'cash') ;

INSERT INTO service (dateOfService, VIN, exterior, interior, priceUSD, paymentType)
VALUES ('01-12-2016', 'JTDKN3DU7C1576997', 'yes', 'no', '40', 'credit') ;

INSERT INTO service (dateOfService, VIN, exterior, interior, priceUSD, paymentType)
VALUES ('12-12-2015', '3GCPCTE03CG256200', 'no', 'yes', '58', 'credit') ;

INSERT INTO service (dateOfService, VIN, exterior, interior, priceUSD, paymentType)
VALUES ('02-22-2016', '3GCPCTE03CG256200', 'no', 'no', '15', 'cash') ;

INSERT INTO service (dateOfService, VIN,  exterior, interior, priceUSD, paymentType)
VALUES ('04-19-2014', '2FMDK39C17BB55672', 'yes', 'yes', '25', 'credit') ;

INSERT INTO service (dateOfService, VIN,  exterior, interior, priceUSD, paymentType)
VALUES ('01-29-2015', 'JN1AZ34E54T030166', 'no', 'yes', '10', 'cash') ;

INSERT INTO service (dateOfService, VIN, exterior, interior, priceUSD, paymentType)
VALUES ('08-03-2016', '1GCNKPEC3EZ270189', 'no', 'yes', '10', 'cash') ;

--- Sample Data customers ---
INSERT INTO customers (pid, aquisitionDate)
VALUES ('p001', '06-18-2016') ;

INSERT INTO customers (pid, aquisitionDate)
VALUES ('p002', '10-22-2015') ;

INSERT INTO customers (pid, aquisitionDate)
VALUES ('p003', '08-16-2010') ;

INSERT INTO customers (pid, aquisitionDate)
VALUES ('p004', '04-14-2016') ;

INSERT INTO customers (pid, aquisitionDate)
VALUES ('p005', '11-19-2016') ;

INSERT INTO customers (pid, aquisitionDate)
VALUES ('p006', '02-07-2017') ;

INSERT INTO customers (pid, aquisitionDate)
VALUES ('p007', '11-13-2015') ;

--- sample data awesome Customers ---
INSERT INTO awesomeCustomers (pid, visits)
VALUES ('p001', '23') ;

INSERT INTO awesomeCustomers (pid, visits)
VALUES ('p002', '3') ;

INSERT INTO awesomeCustomers (pid, visits)
VALUES ('p003', '13') ;

INSERT INTO awesomeCustomers (pid, visits)
VALUES ('p004', '18') ;

INSERT INTO awesomeCustomers (pid, visits)
VALUES ('p005', '36') ;

INSERT INTO awesomeCustomers (pid, visits)
VALUES ('p006', '12') ;

INSERT INTO awesomeCustomers (pid, visits)
VALUES ('p007', '27') ;
---------------------------------------------------------------------------------

--Query--

-- which payment type is used for expensive things
SELECT priceUSD, paymentType
FROM service
ORDER BY priceUSD DESC

--- customers who have cleaned both interior and exterior
SELECT firstName, lastName, dateOfService, exterior, interior
FROM customers c INNER JOIN vehicle v ON c.PID = v.PID
		 INNER JOIN people p ON p.PID = c.PID
		 INNER JOIN service s ON v.VIN = s.VIN 
WHERE exterior = 'yes' AND interior = 'yes'
ORDER BY lastName ASC;

--- customers who have cleaned neither interior nor exterior
SELECT firstName, lastName, dateOfService, exterior, interior
FROM customers c INNER JOIN vehicle v ON c.PID = v.PID
		 INNER JOIN people p ON p.PID = c.PID
		 INNER JOIN service s ON v.VIN = s.VIN 
WHERE exterior = 'no' AND interior = 'no'
ORDER BY lastName ASC;


--- View---
DROP view IF EXISTS highMilage;
create or replace view highMilage as
SELECT DISTINCT firstName, lastName, manufacturer, modelName, odometer, VIN
FROM vehicle v INNER JOIN people p ON v.PID = p.PID
               INNER JOIN make ma ON v.MakeID = ma.MakeID 
               INNER JOIN model mo ON v.ModelID = mo.ModelID
WHERE odometer >80000;
SELECT * 
FROM highMilage;



-- an employees name, wage, job title, promotionDate
DROP view IF EXISTS employeeHistory;
create or replace view employeeHistory as
SELECT DISTINCT firstName, lastName,  hourlyRateUSD, jobTitle, promotionDate
FROM employees e INNER JOIN people p ON e.PID = p.PID
		 INNER JOIN jobs   j ON e.PID = j.PID
		 INNER JOIN positions pos ON j.positionID = pos.positionID
		 LEFT OUTER JOIN managers m ON e.PID = m.PID;

SELECT *
FROM employeeHistory



--- store procedures ---
--- does an employee have a gold star
CREATE OR REPLACE FUNCTION hasStar(text, REFCURSOR)
RETURNS refcursor as $$
DECLARE
	starInput  text     := $1;
	resultSet REFCURSOR := $2;
BEGIN
   open resultset for
	SELECT *
	FROM people p INNER JOIN employees e ON p.pid = e.pid
		      WHERE e.pid = starInput;
	
   return resultset;
end;
$$
language plpgsql;

SELECT hasStar('p901', 'results');
FETCH ALL FROM results;

--- TRIGGER ---
CREATE TRIGGER hasStar AFTER INSERT OR UPDATE OR DELETE ON employees
   FOR EACH ROW EXECUTE PROCEDURE hasStar();





--- who owns what
  CREATE OR REPLACE FUNCTION public.vehiclesowner(
    character,
    refcursor)
  RETURNS refcursor AS
$BODY$
DECLARE
	pidInput  char(4)   := $1;
	resultSet REFCURSOR := $2;
BEGIN
   open resultset for
	SELECT firstName, lastName, manufacturer, modelName
	FROM people p INNER JOIN customers c ON p.pid = c.pid
		      INNER JOIN vehicle v ON p.pid = v.pid
		      INNER JOIN make ma ON v.makeID = ma.makeID
		      INNER JOIN model mo ON v.modelID = mo.modelID
		      WHERE p.pid = pidInput;
	
   return resultset;
end;
$BODY$
  LANGUAGE plpgsql;
SELECT vehiclesowner('p001', 'results');
FETCH ALL FROM results;


  --- SECURITY ---
CREATE ROLE admin;
GRANT ALL ON ALL TABLES
IN SCHEMA PUBLIC
TO Admin;

CREATE ROLE employee;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES
IN SCHEMA PUBLIC
TO employee;
