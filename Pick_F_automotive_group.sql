CREATE TABLE "car" (
  "serial_number" VARCHAR(100) NOT NULL,
  "color" VARCHAR(100),
  "make" VARCHAR(100),
  "model" VARCHAR(100),
  "year_" INTEGER,
  "new_" BOOLEAN,
  PRIMARY KEY ("serial_number")
);
CREATE TABLE "salesperson" (
  "salesperson_id" SERIAL,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  PRIMARY KEY ("salesperson_id")
);
CREATE TABLE "mechanic" (
  "mechanic_id" SERIAL,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  "hourly_rate" NUMERIC(8,2),
  PRIMARY KEY ("mechanic_id")
);
CREATE TABLE "part" (
  "part_id" SERIAL,
  "purchase_cost" NUMERIC(8,2),
  "retail_cost" NUMERIC(8,2),
  "name_" VARCHAR(100),
  PRIMARY KEY ("part_id")
);
CREATE TABLE "customer" (
  "customer_id" SERIAL,
  "serial_number" VARCHAR(100) NOT NULL,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  "address" VARCHAR(150),
  "phone" BIGINT,
  "billing_info" VARCHAR(100),
  PRIMARY KEY ("customer_id"),
  FOREIGN KEY(serial_number) REFERENCES car(serial_number)
);
CREATE TABLE "service_ticket" (
  "service_ticket_id" SERIAL,
  "serial_number" VARCHAR(100) NOT NULL,
  "is_fullfilled" BOOLEAN,
  "date_received" DATE,
  "date_returned" DATE,
  PRIMARY KEY ("service_ticket_id"),
  FOREIGN KEY(serial_number) REFERENCES car(serial_number)
);
CREATE TABLE "part_inventory" (
  "upc" SERIAL,
  "part_id" INTEGER NOT NULL,
  PRIMARY KEY ("upc"),
  FOREIGN KEY(part_id) REFERENCES part(part_id)
);
CREATE TABLE "service_task" (
  "service_task_id" SERIAL,
  "service_ticket_id" INTEGER NOT NULL,
  "service_name" VARCHAR(100),
  "service_task_cost" VARCHAR(100),
  "mechanic_id" INTEGER NOT NULL,
  "upc" INTEGER NOT NULL,
  PRIMARY KEY ("service_task_id"),
  FOREIGN KEY(service_ticket_id) REFERENCES service_ticket(service_ticket_id),
  FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
  FOREIGN KEY(upc) REFERENCES part_inventory(upc)
);
CREATE TABLE "sales_invoice" (
  "invoice_id" SERIAL,
  "cost_" NUMERIC(10,2),
  "salesperson_id" INTEGER NOT NULL,
  "serial_number" VARCHAR(100) NOT NULL,
  "date_" DATE,
  PRIMARY KEY ("invoice_id"),
  FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id),
  FOREIGN KEY(serial_number) REFERENCES car(serial_number)
);

--Stored procedure

CREATE OR REPLACE PROCEDURE cust_info(
	serialNum VARCHAR(100),
	firstName VARCHAR(100),
	lastName VARCHAR(100),
	loc_ VARCHAR(150),
	telephone BIGINT,
	payment VARCHAR(100)
)
language plpgsql
AS $$
BEGIN
	INSERT INTO car(serial_number)
	VALUES(serialNum);
	
	INSERT INTO customer(serial_number,first_name,last_name,address,phone,billing_info)
	VALUES(serialNum,firstName,lastName,loc_,telephone,payment);
	
	
	COMMIT;
END;
$$

CREATE OR REPLACE PROCEDURE carInfo(
	serial_numberU VARCHAR(100),
	colorU VARCHAR(100),
	makeU VARCHAR(100),
	modelU VARCHAR(100),
	year_U INTEGER,
	new_U BOOLEAN
)
language plpgsql
AS $$
BEGIN
	UPDATE car
	SET 
		color = colorU,
		make = makeU,
		model = modelU,
		year_ = year_U,
		new_ = new_U
	WHERE serial_number = serial_numberU;
	COMMIT;
END;
$$

CREATE OR REPLACE PROCEDURE cust_info(
	serialNum VARCHAR(100),
	firstName VARCHAR(100),
	lastName VARCHAR(100),
	loc_ VARCHAR(150),
	telephone BIGINT,
	payment VARCHAR(100)
)
language plpgsql
as $$
BEGIN
	INSERT INTO car(serial_number)
	VALUES(serialNum);
	INSERT INTO customer(serial_number,first_name,last_name,address,phone,billing_info)
	VALUES(serialNum,firstName,lastName,loc_,telephone,payment);
	COMMIT;
END;
$$
CREATE OR REPLACE PROCEDURE carInfo(
	serial_numberU VARCHAR(100),
	colorU VARCHAR(100),
	makeU VARCHAR(100),
	modelU VARCHAR(100),
	year_U INTEGER,
	new_U BOOLEAN
)
language plpgsql
AS $$
BEGIN
	UPDATE car
	SET 
		color = colorU,
		make = makeU,
		model = modelU,
		year_ = year_U,
		new_ = new_U
	WHERE serial_number = serial_numberU;
	COMMIT;
END;
$$
	serialNum VARCHAR(100),
	firstName VARCHAR(100),
	lastName VARCHAR(100),
	loc_ VARCHAR(150),
	telephone BIGINT,
	payment VARCHAR(100)

CALL cust_info('123','Fred','Ramos','5234 W. Moth St. Chicago, IL, 60641',3126085111,'4242424242424241');
CALL cust_info('1','Crystal','Sanders','1234 W. Moth St. Chicago, IL, 60621',3128059066,'4242424242424242'); 
CALL cust_info('2', 'Frank', 'Ramus', '1235 S. Elston St. Chicago, IL, 60341', 3128059123, '4242424242424241'); 
CALL cust_info('3', 'Ida', 'McCarty', '124 N. Armitage Ave. Chicago, IL, 68641', 3128059029, '4242424242424241'); 
Call carInfo('123','brown','Ford','Focus',2016,False);
CALL carInfo('1','brown','Ford','Focus',2016,False);
CALL carInfo('2', 'red', 'Ford', 'Taurus',2020,True);
CALL carInfo('3','silver','Audi','Series 3',2020,True);

INSERT INTO mechanic(mechanic_id,first_name,last_name,hourly_rate)
VALUES(1,'Ida','McCarty',55);
INSERT INTO mechanic(mechanic_id,first_name,last_name,hourly_rate)
VALUES(2,'Keith','Mason',55);
INSERT INTO mechanic(mechanic_id,first_name,last_name,hourly_rate)
VALUES(3,'Frank','Ramos',55);
INSERT INTO mechanic(mechanic_id,first_name,last_name,hourly_rate)
VALUES(4,'Patrick','Turner',55);
INSERT INTO mechanic(mechanic_id,first_name,last_name,hourly_rate)
VALUES(5,'Crystal','Sanders',55);

INSERT INTO part(part_id,purchase_cost,retail_cost,name_)
VALUES(1,68,99,'Muffler');
INSERT INTO part(part_id,purchase_cost,retail_cost,name_)
VALUES(2,129,239,'Rotor');
INSERT INTO part(part_id,purchase_cost,retail_cost,name_)
VALUES(3,287,444,'Regulator');
INSERT INTO part(part_id,purchase_cost,retail_cost,name_)
VALUES(4,144,315,'TDC Sensor');
INSERT INTO part(part_id,purchase_cost,retail_cost,name_)
VALUES(5,48,109,'Brake pads');

INSERT INTO part_inventory(upc, part_id)
VALUES(1000, 1);
INSERT INTO part_inventory(upc, part_id)
VALUES(1001, 2);
INSERT INTO part_inventory(upc, part_id)
VALUES(1002, 3);
INSERT INTO part_inventory(upc, part_id)
VALUES(1003, 4);
INSERT INTO part_inventory(upc, part_id)
VALUES(1004, 5);

INSERT INTO service_ticket(
    service_ticket_id,
    serial_number,
    is_fullfilled,
    date_received,
    date_returned
)VALUES(
    1,
    1,
    'FALSE',
    '2020-09-22',
    '2020-09-25'
);
INSERT INTO service_ticket(
    service_ticket_id,
    serial_number,
    is_fullfilled,
    date_received,
    date_returned
)VALUES(
    2,
    2,
    'TRUE',
    '2020-10-11',
    '2020-10-13'
);

INSERT INTO service_task(
    service_task_id,
    service_ticket_id,
    service_name,
    service_task_cost,
    mechanic_id,
    upc
)VALUES(
    1,
    1,
    'Brakes',
    '459.99',
    1,
    1000
);
INSERT INTO service_task(
    service_task_id,
    service_ticket_id,
    service_name,
    service_task_cost,
    mechanic_id,
    upc
)VALUES(
    2,
    2,
    'Diagnostic',
    '49.99',
    2,
    1002
);

CREATE OR REPLACE PROCEDURE cust_info(
	serialNum VARCHAR(100),
	firstName VARCHAR(100),
	lastName VARCHAR(100),
	loc_ VARCHAR(150),
	telephone BIGINT,
	payment VARCHAR(100)
)
language plpgsql
as $$
BEGIN
	INSERT INTO car(serial_number)
	VALUES(serialNum);
	INSERT INTO customer(serial_number,first_name,last_name,address,phone,billing_info)
	VALUES(serialNum,firstName,lastName,loc_,telephone,payment);
	COMMIT;
END;
$$
CREATE OR REPLACE PROCEDURE carInfo(
	serial_numberU VARCHAR(100),
	colorU VARCHAR(100),
	makeU VARCHAR(100),
	modelU VARCHAR(100),
	year_U INTEGER,
	new_U BOOLEAN
)
language plpgsql
AS $$
BEGIN
	UPDATE car
	SET 
		color = colorU,
		make = makeU,
		model = modelU,
		year_ = year_U,
		new_ = new_U
	WHERE serial_number = serial_numberU;
	COMMIT;
END;
$$
CALL cust_info('123','Fred','Ramos','5234 W. Moth St. Chicago, IL, 60641',3126085111,'4242424242424241'); 
CALL carInfo('123','brown','ford','focus',2015,False);
CALL cust_info('1','Crystal','Sanders','1234 W. Moth St. Chicago, IL, 60621',3128059066,'4242424242424242'); 
CALL carInfo('1','brown','ford','focus',2016,False);
CALL cust_info('2', 'Frank', 'Ramus', '1235 S. Elston St. Chicago, IL, 60341', 3128059123, '4242424242424241'); 
CALL carInfo('2', 'red', 'ford', 'taurus', 2020, True);
CALL cust_info('3', 'Ida', 'McCarty', '124 N. Armitage Ave. Chicago, IL, 68641', 3128059029, '4242424242424241'); 
CALL carInfo('3', 'silver', 'audi', 'series 3', 2020, True);
-- Checking
SELECT *
FROM customer;
SELECT *
FROM car;
-- inserting data normally
INSERT INTO mechanic(mechanic_id,first_name,last_name,hourly_rate)
VALUES(1,'Ida','McCarty',55);
INSERT INTO mechanic(mechanic_id,first_name,last_name,hourly_rate)
VALUES(2,'Keith','Mason',55);
INSERT INTO mechanic(mechanic_id,first_name,last_name,hourly_rate)
VALUES(3,'Frank','Ramos',55);
INSERT INTO mechanic(mechanic_id,first_name,last_name,hourly_rate)
VALUES(4,'Patrick','Turner',55);
INSERT INTO mechanic(mechanic_id,first_name,last_name,hourly_rate)
VALUES(5,'Crystal','Sanders',55);
SELECT *
FROM mechanic;
INSERT INTO part(part_id,purchase_cost,retail_cost,name_)
VALUES(1,68,99,'Muffler');
INSERT INTO part(part_id,purchase_cost,retail_cost,name_)
VALUES(2,129,239,'Rotor');
INSERT INTO part(part_id,purchase_cost,retail_cost,name_)
VALUES(3,287,444,'Regulator');
INSERT INTO part(part_id,purchase_cost,retail_cost,name_)
VALUES(4,144,315,'TDC Sensor');
INSERT INTO part(part_id,purchase_cost,retail_cost,name_)
VALUES(5,48,109,'Brake pads');
SELECT *
FROM part;
INSERT INTO part_inventory(upc, part_id)
VALUES(1000, 1);
INSERT INTO part_inventory(upc, part_id)
VALUES(1001, 2);
INSERT INTO part_inventory(upc, part_id)
VALUES(1002, 3);
INSERT INTO part_inventory(upc, part_id)
VALUES(1003, 4);
INSERT INTO part_inventory(upc, part_id)
VALUES(1004, 5);
SELECT *
FROM part_inventory;
INSERT INTO service_ticket(service_ticket_id, serial_number, is_fullfilled)
INSERT INTO service_ticket(
    service_ticket_id,
    serial_number,
    is_fullfilled,
    date_received,
    date_returned
)VALUES(
    1,
    1,
    'FALSE',
    '2020-09-22',
    '2020-09-25'
);
INSERT INTO service_ticket(
    service_ticket_id,
    serial_number,
    is_fullfilled,
    date_received,
    date_returned
)VALUES(
    2,
    2,
    'TRUE',
    '2020-10-11',
    '2020-10-13'
);
SELECT *
FROM service_ticket;
INSERT INTO service_task(
    service_task_id,
    service_ticket_id,
    service_name,
    service_task_cost,
    mechanic_id,
    upc
)VALUES(
    1,
    1,
    'Brakes',
    '459.99',
    1,
    1000
);
INSERT INTO service_task(
    service_task_id,
    service_ticket_id,
    service_name,
    service_task_cost,
    mechanic_id,
    upc
)VALUES(
    2,
    2,
    'Diagnostic',
    '49.99',
    2,
    1002
);

INSERT INTO salesperson(salesperson_id, first_name, last_name)
VALUES(1, 'Patrick', 'Turner');
INSERT INTO salesperson(salesperson_id, first_name, last_name)
VALUES(2, 'Joel', 'Carter');
INSERT INTO sales_invoice(invoice_id, cost_, salesperson_id, serial_number, date_)
VALUES(1, 30000, 1, '123', CURRENT_DATE);
INSERT INTO sales_invoice(invoice_id, cost_, salesperson_id, serial_number, date_)
VALUES(2, 50000, 2, '3', CURRENT_DATE);


