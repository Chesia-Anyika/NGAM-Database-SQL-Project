
/* create county table */
CREATE TABLE county (
  c_code INT,
  c_name VARCHAR(20),
  c_population INT,
  c_malepop INT,
  c_femalepop INT,
  PRIMARY KEY (c_code)
);


/* create organisation table */
CREATE TABLE organisation (
  o_code INT,
  c_code INT,
  o_name VARCHAR(50),
  o_employees INT,
  o_malepop INT,
  o_femalepop INT,
  PRIMARY KEY (o_code),
  FOREIGN KEY (c_code) REFERENCES county(c_code)
);
 
/* create employee type table */
CREATE TABLE employee_type (
  type_code CHAR(3), /*abbreviation of job title, like engineer = ENG */
  e_type VARCHAR(20),
  PRIMARY KEY (type_code)
);


/* create employee table */
CREATE TABLE employee (
  e_id INT,
  o_code INT,
  e_fname VARCHAR(20),
  e_lname VARCHAR(20),
  type_code VARCHAR(3), /*abbreviation of job title, like engineer = ENG */
  e_gender CHAR(1), /* m or f */
  e_salary NUMBER(10,2),
  PRIMARY KEY (e_id),
  FOREIGN KEY (o_code) REFERENCES organisation(o_code),
  FOREIGN KEY (type_code) REFERENCES employee_type(type_code)
  CONSTRAINT unique_values CHECK (e_gender in ('m','f'))
);

/* create hire table */
CREATE TABLE hire (
  e_id INT,
  o_code INT,
  hire_date DATE,
  years_of_employment INT,
  PRIMARY KEY (e_id, o_code),
  FOREIGN KEY (e_id) REFERENCES employee(e_id),
  FOREIGN KEY (o_code) REFERENCES organisation(o_code)
);

/* create salary table */
CREATE TABLE salary (
  type_code INT,
  o_code INT,
  avg_salary NUMBER(10, 2),
  PRIMARY KEY (type_code, o_code),
  FOREIGN KEY (o_code) REFERENCES organisation(o_code)
);

/* create school table */
CREATE TABLE school (
  s_id 	INT,
  c_code INT,
  s_name VARCHAR(20),
  s_population INT,
  s_malepop INT,
  s_femalepop INT,
  PRIMARY KEY (s_id),
  FOREIGN KEY (c_code) REFERENCES county(c_code)
);

/* create student table */
CREATE TABLE student (
  st_id INT,
  s_id INT,
  s_fname VARCHAR(20),
  s_lname VARCHAR(20),
  s_gender CHAR(1), 
  s_onScholarship CHAR(1),
  PRIMARY KEY (st_id)
  CONSTRAINT unique_values CHECK (s_gender in ('m','f')),
  CONSTRAINT unique_values CHECK (s_onScholarship in ('y','n'))
);



/* create on_scholarship table */
CREATE TABLE on_scholarship (
  st_id INT,
  scholarship VARCHAR(20),
  tuition NUMBER(10, 2),
  PRIMARY KEY (st_id),
  FOREIGN KEY (st_id) REFERENCES student(st_id)
);

/* create no_scholarship table */
CREATE TABLE no_scholarship (
  st_id INT,
  tuition NUMBER(10, 2),
  PRIMARY KEY (st_id),
  FOREIGN KEY (st_id) REFERENCES student(st_id)
);

/* create enroll table */
CREATE TABLE enroll (
  st_id INT,
  s_id INT,
  enroll_date DATE,
  enroll_year VARCHAR(10), /*freshman, sophomore, junior, senior*/
  PRIMARY KEY (st_id, s_id),
  FOREIGN KEY (st_id) REFERENCES student(st_id),
  FOREIGN KEY (s_id) REFERENCES school(s_id)
);

/* create degree table */
CREATE TABLE degree (
  deg_code CHAR(3), /*Abbreviation of degree name, e.g Accounting = ACC*/
  deg_name VARCHAR(30),
  PRIMARY KEY (deg_code)
);

/* create gpa table */
CREATE TABLE gpa (
  grade CHAR(1), /* A, B, C, D, F */
  g_start INT, /* e.g A starts at 90 */
  g_end INT, /*eng A ends at 100*/
  standing VARCHAR(10), /*good or bad*/
  PRIMARY KEY (grade)
  CONSTRAINT unique_values CHECK (standing in ('good','bad'))
);

/* create graduate table */
CREATE TABLE graduate (
  st_id INT,
  s_id INT,
  g_date DATE,
  grade CHAR(1), /* A, B, C, D, F */
  deg_code CHAR(3), /*abbreviation of degree name, e.g Psychology = PSY */
  PRIMARY KEY (st_id, s_id),
  FOREIGN KEY (st_id) REFERENCES student(st_id),
  FOREIGN KEY (s_id) REFERENCES school(s_id),
  FOREIGN KEY (deg_code) REFERENCES degree(deg_code),
  FOREIGN KEY (grade) REFERENCES gpa(grade)
);


Records
County table
INSERT INTO county (c_code, c_name, c_population, c_malepop, c_femalepop) 
VALUES
(001, 'Mombasa', 1208333, 609157, 599176),
(002, 'Kwale', 866820, 429328, 437492),
(003, 'Kilifi', 1453787, 708480, 745307),
(004, 'Tana River', 315943, 159364, 156579),
(005, 'Lamu', 143920, 69767, 74153),
(006, 'Taita Taveta', 340671, 168091, 172580),
(007, 'Garissa', 841353, 440610, 400743),
(008, 'Wajir', 781263, 402527, 378736),
(009, 'Mandera', 867457, 459358, 408099),
(010, 'Marsabit', 459785, 234567, 225218);


Employment tables(organisation, employee_type, employee, hire, salary)
/*insert records into organisation table*/
INSERT INTO organisation VALUES
(1001, 001, 'ABC Inc.', 50, 25, 25),
(1002, 002, 'XYZ Corp.', 100, 60, 40),
(1003, 003, 'Acme Co.', 200, 100, 100),
(1004, 004, 'Beta Corp.', 75, 30, 45),
(1005, 005, 'Gamma LLC', 150, 75, 75),
(1006, 006, 'Delta Corp.', 80, 40, 40),
(1007, 007, 'Epsilon Inc.', 30, 10, 20),
(1008, 008, 'Theta Corp.', 125, 70, 55),
(1009, 009, 'Iota LLC', 50, 20, 30),
(1010, 010, 'Kappa Co.', 90, 45, 45);

/*insert records into employee_type table*/
INSERT INTO employee_type VALUES
('ACC', 'Accountant'),
('ADM', 'Administrator'),
('ENG', 'Engineer'),
('EXC', 'Company Executive'),
('HRM', 'Human Resources Manager'),
('INT', 'Intern'),
('MRK', 'Marketing’),
('PRG', 'Programmer'),
('SAL', 'Salesperson'),
('OPR', 'Operations manager');

/*insert records into employee table*/
INSERT INTO employee VALUES
(600001, 1001, 'John', 'Doe', 'ENG', 'm', 70000.00),
(600002, 1003, 'Jane', 'Smith', 'HRM', 'f', 85000.00),
(600003, 1002, 'David', 'Brown', 'INT', 'm', 90000.00),
(600004, 1001, 'Linda', 'Johnson', 'ACC', 'f', 55000.00),
(600005, 1002, 'Michael', 'Wilson', 'ENG', 'm', 80000.00),
(600006, 1005, 'Sarah', 'Taylor', 'MRK', 'f', 65000.00),
(600007, 1004, 'Matthew', 'Anderson', 'OPR', 'm', 95000.00),
(600008, 1003, 'Emily', 'Clark', 'SAL', 'f', 75000.00),
(600009, 1005, 'Daniel', 'Martinez', 'PRG', 'm', 85000.00),
(600010, 1004, 'Amanda', 'Lee', 'EXC', 'f', 70000.00);

/*insert records into hire table*/
INSERT INTO hire VALUES
(600001, 1001, '2010-05-12', 11),
(600002, 1003, '2018-09-20', 3),
(600003, 1002, '2015-02-28', 6),
(600004, 1001, '2012-07-11', 9),
(600005, 1002, '2019-04-30', 2),
(600006, 1005, '2016-11-18', 5),
(600007, 1004, '2014-03-15', 8),
(600008, 1003, '2017-06-22', 4),
(600009, 1005, '2013-08-08', 8),
(600010, 1004, '2021-01-10', 1);

/*insert records into salary*/
INSERT INTO salary VALUES
('ACC', 1001, 85000.00),
('ADM', 1001, 125000.00),
('ENG', 1002, 65000.00),
('EXC', 1002, 55000.00),
('HRM', 1003, 45000.00),
('INT', 1003, 60000.00),
('MRK', 1004, 80000.00),
('PRG', 1004, 130000.00),
('SAL', 1005, 70000.00),
('OPR', 1005, 40000.00);


Education tables(school, student, on_scholarship, no_scholarship, enroll, degree, gpa, graduate)
		
		/*insert into school*/
INSERT INTO school (s_id, c_code, s_name, s_population, s_malepop, s_femalepop)
VALUES
(1, 001, 'Springfield High School', 1000, 500, 500),
(2, 002, 'Oakland Elementary', 750, 350, 400),
(3, 002, 'Maplewood Middle School', 900, 450, 450),
(4, 003, 'Northridge High School', 1100, 600, 500),
(5, 004, 'Lincoln Elementary', 600, 300, 300),
(6, 005, 'Roosevelt Middle School', 800, 400, 400),
(7, 006, 'Jefferson Elementary', 650, 300, 350),
(8, 008, 'Westfield High School', 950, 500, 450),
(9, 009, 'Hillside Elementary', 500, 250, 250),
(10, 010, 'Fairview Middle School', 700, 350, 350);

/*insert into student*/
INSERT INTO student (st_id, s_id, s_fname, s_lname, s_gender, s_onScholarship)
VALUES 
  (1, 1, 'John', 'Doe', 'm', 'y'),
  (2, 2, 'Jane', 'Smith', 'f', 'n'),
  (3, 3, 'Bob', 'Johnson', 'm', 'n'),
  (4, 4, 'Alice', 'Williams', 'f', 'y'),
  (5, 5, 'Mark', 'Davis', 'm', 'n'),
  (6, 6, 'Sara', 'Lee', 'f', 'y'),
  (7, 7, 'David', 'Brown', 'm', 'n'),
  (8, 8, 'Emily', 'Taylor', 'f', 'n'),
  (9, 9, 'Michael', 'Wilson', 'm', 'y'),
  (10, 10, 'Jennifer', 'Thomas', 'f', 'y')
  (11, 1, 'Oliver', 'Doe', 'm', 'y'),
  (12, 2, 'Olivia', 'Smith', 'f', 'n'),
  (13, 3, 'Bill', 'Johnson', 'm', 'n'),
  (14, 4, 'Alayna', 'Williams', 'f', 'y'),
  (15, 5, 'Matt', 'Davis', 'm', 'n'),
  (16, 6, 'Sarah', 'Lee', 'f', 'y'),
  (17, 7, 'Dave', 'Brown', 'm', 'n'),
  (18, 8, 'Emilia', 'Taylor', 'f', 'n'),
  (19, 9, 'Mikey', 'Wilson', 'm', 'y'),
  (20, 10, 'Jeanine', 'Thomas', 'f', 'y')

/*insert into enroll*/
INSERT INTO enroll (st_id, s_id, enroll_date, enroll_year)
VALUES
(1, 1, '2021-09-01', 'freshman'),
(2, 2, '2021-09-01', 'junior'),
(3, 3, '2021-09-01', 'sophomore'),
(4, 4, '2021-09-01', 'senior'),
(5, 5, '2021-09-01', 'freshman'),
(6, 6, '2021-09-01', 'sophomore'),
(7, 7, '2021-09-01', 'freshman'),
(8, 8, '2021-09-01', 'senior'),
(9, 9, '2021-09-01', 'junior'),
(10, 10, '2021-09-01', 'freshman');

/*insert into on_scholarship*/
INSERT INTO on_scholarship (st_id, scholarship, tuition)
VALUES
  (1, 'Merit Scholarship', 5000.00),
  (2, 'Athletic Scholarship', 7500.00),
  (4, 'Need-based Scholarship', 10000.00),
  (5, 'Merit Scholarship', 5000.00),
  (6, 'Athletic Scholarship', 7500.00),
  (7, 'Need-based Scholarship', 10000.00),
  (8, 'Merit Scholarship', 5000.00),
  (9, 'Athletic Scholarship', 7500.00),
  (10, 'Need-based Scholarship', 10000.00),
  (3, 'Merit Scholarship', 5000.00);

/*insert into no_scholarship*/
INSERT INTO no_scholarship (st_id, tuition)
VALUES 
  (11, 10000.00),
  (12, 12000.00),
  (13, 9000.00),
  (14, 11000.00),
  (15, 8000.00),
  (16, 13000.00),
  (17, 9500.00),
  (18, 11500.00),
  (19, 7500.00),
  (20, 14000.00);


/*insert into degree table*/
INSERT INTO degree (deg_code, deg_name)
VALUES
  ('CSI', 'Computer Science'),
  ('ENG', 'English'),
  ('BIO', 'Biology'),
  ('GDE', 'Graphic Design'),
  ('PSY', 'Psychology'),
  ('HIS', 'History'),
  ('MTH', 'Mathematics'),
  ('CHM', 'Chemistry'),
  ('PSC', 'Political Science'),
  ('ENV', 'Environmental Science');



/*insert into gpa table*/
INSERT INTO gpa (grade, g_start, g_end, standing)
VALUES
  ('A', 90, 100, 'good'),
  ('B', 80, 89, 'good'),
  ('C', 70, 79, 'good'),
  ('D', 60, 69, 'bad'),
  ('F', 50, 59, 'bad'),
  ('G', 40, 49, 'bad'),
  ('H', 30, 39, 'bad'),
  ('I', 20, 29, 'bad'),
  ('J', 10, 19, 'bad'),
  ('K', 0, 9, 'bad');

/*insert into graduate*/
/*option 1*/
INSERT INTO graduate (st_id, s_id, g_date, grade, deg_code)
VALUES
  (1, 1, '2022-05-20', 'A', 'CHM'),
  (2, 2, '2021-12-15', 'B', 'ENG'),
  (3, 3, '2022-05-20', 'A', 'BIO'),
  (4, 4, '2021-12-15', 'C', 'HIS'),
  (5, 5, '2022-05-20', 'B', 'ENV'),
  (6, 6, '2021-12-15', 'A', 'CSI'),
  (7, 7, '2022-05-20', 'C', 'PSC'),
  (8, 8, '2021-12-15', 'D', 'PSC'),
  (9, 9, '2022-05-20', 'B', 'ENG'),
  (10, 10, '2021-12-15', 'F', 'BIO');









		




