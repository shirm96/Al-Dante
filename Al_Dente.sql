USE [master]
GO

DROP DATABASE IF EXISTS [Al_Dente]
GO

CREATE DATABASE [Al_Dente];
GO

USE [Al_Dente];
GO

CREATE TABLE Customers 
(
	Customer_id INT,
	First_Name VARCHAR(25),
	Last_Name VARCHAR(25),
	Email VARCHAR(60),
	Birthday DATE,
	Phone_number VARCHAR(12),

	CONSTRAINT cust_id_pk PRIMARY KEY(Customer_id),
	CONSTRAINT email_ck CHECK(email LIKE '%@%')

);
GO

CREATE TABLE Employees 
(
	Employee_id INT,
	First_Name VARCHAR(25),
	Last_Name VARCHAR(25),
	Age INT,
	Gender VARCHAR(15),
	Phone_number VARCHAR(12),
	Join_date DATE   CONSTRAINT Join_date_nn NOT NULL,
	End_date DATE,
	Role VARCHAR(50)  CONSTRAINT Role_nn NOT NULL,
	Hourly_Salary INT  CONSTRAINT Hourly_Salary_nn NOT NULL,

	CONSTRAINT Employee_id_pk PRIMARY KEY(Employee_id),
	CONSTRAINT Phone_uq UNIQUE(Phone_number),
	CONSTRAINT Hourly_Salary_ck CHECK(Hourly_Salary BETWEEN 5 AND 250),
	CONSTRAINT Gender_ck CHECK(Gender='M' OR Gender='F'),
	CONSTRAINT End_date_ck CHECK(End_date> Join_date)

	);
GO

CREATE TABLE Meals (
	Meal_id INT,
	Meal_name VARCHAR(30) CONSTRAINT Meal_name_nn NOT NULL,
	Meal_menu_price INT CONSTRAINT Meal_menu_price_nn NOT NULL,
	Meal_cost INT CONSTRAINT Meal_cost_nn NOT NULL,

	CONSTRAINT Meal_id_pk PRIMARY KEY(Meal_id),
	CONSTRAINT Meal_name_uq UNIQUE(Meal_name),
	CONSTRAINT Meal_menu_price_ck CHECK(Meal_menu_price<50),
	CONSTRAINT Meal_cost_ck CHECK(Meal_cost<50)
);
GO

CREATE TABLE Orders (
	Order_id INT,
	Customer_id INT,
	Date DATETIME DEFAULT GETDATE()    CONSTRAINT Date_nn NOT NULL,
	Meal_id INT,

	CONSTRAINT Order_id_pk PRIMARY KEY(Order_id),
	CONSTRAINT Customer_id_fk FOREIGN KEY(Customer_id) REFERENCES Customers(Customer_id),
	CONSTRAINT Meal_id_fk FOREIGN KEY(Meal_id) REFERENCES Meals(Meal_id),

);
GO

CREATE TABLE Payment (
	Pay_id INT,
	Customer_id INT,
	Pay_amount INT			     	CONSTRAINT Pay_amount_nn NOT NULL,
	Date DATE DEFAULT GETDATE()    CONSTRAINT Date_nn2 NOT NULL,

	CONSTRAINT Pay_id_pk PRIMARY KEY (Pay_id),
	CONSTRAINT Customer_id_fk2 FOREIGN KEY(Customer_id) REFERENCES Customers(Customer_id),

);
GO

CREATE TABLE Tables (
	Table_id INT,
	Number_of_sits INT CONSTRAINT Number_of_sits_nn NOT NULL,

	CONSTRAINT Table_id_pk PRIMARY KEY (Table_id),
	CONSTRAINT Number_of_sits_ck CHECK(Number_of_sits<=20)
);
GO

CREATE TABLE Reservations (
	Reservation_id INT,
	Customer_id INT,
	Date_time DATETIME DEFAULT GETDATE()  CONSTRAINT Datetime_nn NOT NULL,
	Party_size INT						CONSTRAINT Party_size_nn NOT NULL,
	Table_id INT						CONSTRAINT Table_id_nn NOT NULL,

	CONSTRAINT Reservation_id_pk PRIMARY KEY (Reservation_id),
	CONSTRAINT Customer_id_fk3 FOREIGN KEY(Customer_id) REFERENCES Customers(Customer_id),
	CONSTRAINT Party_size_ck CHECK(Party_size<=20),
	CONSTRAINT Table_id_fk FOREIGN KEY(Table_id) REFERENCES Tables(Table_id)

);
GO

CREATE TABLE Shifts (
	Employee_id INT	CONSTRAINT Employee_id_nn NOT NULL,
	Clock_in DATETIME  CONSTRAINT Clock_in_nn NOT NULL ,
	Clock_out DATETIME CONSTRAINT Clock_out_nn NOT NULL,

	CONSTRAINT Employee_id_fk FOREIGN KEY(Employee_id) REFERENCES Employees(Employee_id)
);
GO


CREATE TABLE Tips (
	Table_id INT,
	Employee_id INT,
	Customer_id INT,
	Tip_amount INT,

	CONSTRAINT Table_id_fk2 FOREIGN KEY(Table_id) REFERENCES Tables(Table_id),
	CONSTRAINT Employee_id_fk2 FOREIGN KEY(Employee_id) REFERENCES Employees(Employee_id),
	CONSTRAINT Customer_id_fk4 FOREIGN KEY(Customer_id) REFERENCES Customers(Customer_id)
);
GO
--Inserting to customer table

insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (1, 'Kailey', 'Kerkham', 'kkerkham0@nsw.gov.au', '1988-12-17', '833-661-7683');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (2, 'Humfrid', 'Redmayne', 'hredmayne1@cbc.ca', '1994-09-30', '384-200-1028');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (3, 'Fran', 'Howells', 'fhowells2@imdb.com', '1998-02-15', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (4, 'Gallagher', 'Hamnet', 'ghamnet3@theglobeandmail.com', '1970-07-10', '937-741-0603');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (5, 'Nadya', 'Lafee', 'nlafee4@gmpg.org', '1962-06-05', '707-459-5489');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (6, 'Nealson', 'Phippen', null, '1998-03-24', '254-935-5137');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (7, 'Teodoor', 'Leimster', 'tleimster6@psu.edu', '1969-01-09', '497-158-2399');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (8, 'Cordelia', 'Renon', 'crenon7@umn.edu', null, '345-644-8656');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (9, 'Wendel', 'Perott', null, '1983-11-20', '642-482-4332');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (10, 'Sophey', 'Nation', 'snation9@wsj.com', '1980-04-09', '710-774-7417');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (11, 'Ashbey', 'Offa', null, '1961-11-08', '525-871-7608');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (12, null, null, null, '1995-12-02', '669-335-2378');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (13, 'Gillie', 'Eames', 'geamesc@technorati.com', '1990-09-01', '323-799-3098');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (14, 'Lexi', 'Marlowe', 'lmarlowed@sitemeter.com', '1997-05-11', '228-562-4369');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (15, 'Nissie', 'Lyttle', 'nlyttlee@discuz.net', null, '653-898-5654');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (16, 'Kiley', 'Butterfill', 'kbutterfillf@fema.gov', '1961-07-31', '798-709-1570');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (17, 'Natka', 'Starkey', 'nstarkeyg@pagesperso-orange.fr', '1991-05-23', '801-238-4561');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (18, 'Nydia', 'Armit', 'narmith@histats.com', '1987-03-29', '732-551-4214');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (19, 'Mariellen', 'Wawer', 'mwaweri@ibm.com', null, '160-250-2287');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (20, 'Piggy', 'De Ambrosi', null, '1981-01-30', '529-282-4485');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (21, 'Rubia', 'Matysik', null, '1961-03-15', '878-930-3652');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (22, 'Drew', 'Burt', null, '1999-10-04', '367-806-7649');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (23, 'Ted', 'Arkwright', 'tarkwrightm@blogtalkradio.com', null, '224-134-2658');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (24, 'Willdon', 'Lippett', 'wlippettn@youtube.com', '1980-04-21', '665-537-5232');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (25, null, null, 'kshelfo@ovh.net', '1982-12-17', '746-137-3806');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (26, 'Eda', 'Carnson', 'ecarnsonp@salon.com', '1995-02-05', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (27, 'Didi', 'Carlin', 'dcarlinq@is.gd', null, '695-491-9663');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (28, 'Suzi', 'Bradbrook', 'sbradbrookr@naver.com', '1983-09-16', '704-577-0420');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (29, 'Alastair', 'Phippen', null, null, '691-795-8365');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (30, 'Lockwood', 'Lowton', 'llowtont@tmall.com', '1964-09-30', '500-441-1878');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (31, 'Loren', 'Clemencet', 'lclemencetu@blogtalkradio.com', '1961-01-06', '198-603-5896');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (32, 'Ebeneser', 'Gwinnell', 'egwinnellv@delicious.com', null, null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (33, 'Stacey', 'Oxby', 'soxbyw@addthis.com', '1971-09-16', '691-517-8320');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (34, 'Kristine', 'Coppins', 'kcoppinsx@digg.com', null, '905-923-0867');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (35, 'Janessa', 'Janicijevic', 'jjanicijevicy@fotki.com', '1974-07-29', '436-887-2297');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (36, 'Tiena', 'Robardley', 'trobardleyz@blog.com', '1986-11-06', '650-298-0429');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (37, 'Rafaello', 'Rubinivitz', 'rrubinivitz10@ucoz.com', '1968-03-26', '929-291-3774');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (38, 'Karleen', 'Frandsen', 'kfrandsen11@icio.us', '1983-09-17', '501-270-8781');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (39, 'Thorin', 'Crank', null, '1976-08-07', '615-101-2108');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (40, 'Nicol', 'Bestman', 'nbestman13@hatena.ne.jp', '1994-01-30', '759-730-5747');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (41, 'Shannen', 'Coucha', 'scoucha14@java.com', '1971-11-30', '236-495-8312');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (42, 'Ad', 'Kedge', null, '1983-05-20', '812-406-9619');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (43, 'Pansie', 'Saiz', null, '1998-03-10', '105-635-6435');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (44, 'Putnam', 'Abad', 'pabad17@4shared.com', '1979-05-16', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (45, 'Tome', 'Whisby', 'twhisby18@tuttocitta.it', '1992-06-17', '932-292-5487');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (46, 'Christiano', 'Gussin', 'cgussin19@marketwatch.com', '1996-11-27', '553-171-7356');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (47, 'Giralda', 'Richardson', 'grichardson1a@timesonline.co.uk', '2000-05-02', '983-210-9238');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (48, 'Ronalda', 'Garber', 'rgarber1b@unblog.fr', '1995-09-16', '309-132-5514');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (49, 'Germaine', 'Von Brook', 'gvonbrook1c@booking.com', '1966-03-13', '566-508-6850');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (50, 'Ruthy', 'Goldman', 'rgoldman1d@pagesperso-orange.fr', '1965-02-01', '678-878-8427');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (51, 'Margit', 'Netherwood', 'mnetherwood1e@bloglines.com', '1996-02-18', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (52, 'Juliana', 'Labbett', 'jlabbett1f@tiny.cc', '1999-06-13', '702-438-1238');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (53, 'Marinna', 'Monckman', 'mmonckman1g@privacy.gov.au', '1974-12-20', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (54, 'Kaia', 'Josovich', 'kjosovich1h@sphinn.com', '2000-03-29', '391-141-1806');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (55, 'Kata', 'Antonellini', 'kantonellini1i@home.pl', '1964-04-29', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (56, 'Levy', 'Kenderdine', 'lkenderdine1j@barnesandnoble.com', '1997-07-27', '470-837-8930');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (57, 'Charla', 'Diwell', 'cdiwell1k@nba.com', '1980-01-28', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (58, 'Valeria', 'O''Curran', 'vocurran1l@patch.com', '1971-03-08', '893-284-9281');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (59, 'Jillie', 'Wiszniewski', 'jwiszniewski1m@t-online.de', null, '291-203-1852');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (60, null, null, 'nbaraja1n@acquirethisname.com', '1977-12-21', '318-801-2535');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (61, 'Fianna', 'Shone', null, '1976-12-27', '524-727-8748');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (62, 'Ed', 'Browell', 'ebrowell1p@theguardian.com', '1986-12-16', '288-463-8090');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (63, 'Chalmers', 'O''Cullinane', 'cocullinane1q@guardian.co.uk', null, '187-547-2020');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (64, null, null, 'aackerley1r@oakley.com', null, null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (65, 'Nevin', 'Iacobacci', 'niacobacci1s@nydailynews.com', '1992-10-18', '543-315-8379');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (66, 'Phebe', 'Heijnen', 'pheijnen1t@bluehost.com', '1965-09-06', '852-650-6518');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (67, 'Irwin', 'Carrigan', 'icarrigan1u@prweb.com', null, '165-167-1835');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (68, 'Camilla', 'Yeend', 'cyeend1v@springer.com', null, '897-180-9527');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (69, 'Ferguson', 'Hutchcraft', 'fhutchcraft1w@hp.com', null, null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (70, 'Collin', 'Huyche', 'chuyche1x@google.ca', '1987-04-15', '965-565-7945');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (71, 'Frants', 'Sprowle', 'fsprowle1y@java.com', '1975-12-10', '863-448-7126');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (72, 'Zelig', 'Clac', 'zclac1z@unesco.org', '1972-09-16', '425-345-9264');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (73, 'Phineas', 'Wantling', 'pwantling20@weebly.com', '1972-07-22', '449-748-5245');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (74, 'Helena', 'Dahlman', 'hdahlman21@intel.com', '1978-10-30', '333-307-0174');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (75, 'Pooh', 'MacLaughlin', null, '1988-12-02', '913-196-0954');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (76, 'Isidor', 'Abbott', 'iabbott23@merriam-webster.com', null, null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (77, 'Anthe', 'Simanenko', 'asimanenko24@artisteer.com', '1972-07-27', '485-749-9355');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (78, 'Kristyn', 'Remington', 'kremington25@pcworld.com', null, '880-533-9538');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (79, 'Calhoun', 'Hembling', 'chembling26@usgs.gov', null, '491-350-1628');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (80, 'Erika', 'Huckfield', 'ehuckfield27@hexun.com', '1981-08-09', '221-179-6696');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (81, 'Gerri', 'Farrer', 'gfarrer28@who.int', '1965-01-05', '344-847-0769');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (82, 'Milzie', 'Hinkens', 'mhinkens29@xrea.com', '1991-03-25', '278-292-0871');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (83, 'Eyde', 'Gozney', 'egozney2a@ebay.co.uk', '1969-11-21', '364-859-4948');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (84, 'Storm', 'Pineaux', 'spineaux2b@amazon.com', '1995-09-14', '263-774-3874');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (85, 'Hillard', 'Antonomolii', 'hantonomolii2c@squidoo.com', '1963-04-23', '911-986-2509');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (86, 'Quentin', 'Gallimore', null, null, '198-229-8427');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (87, 'Halli', 'Willan', 'hwillan2e@nifty.com', '1992-06-02', '733-860-1583');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (88, 'Shepherd', 'Franchioni', 'sfranchioni2f@weebly.com', '1973-03-19', '924-321-6279');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (89, 'Druci', 'Abazi', 'dabazi2g@independent.co.uk', '1971-10-14', '615-585-5221');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (90, 'Sari', 'Rosen', 'srosen2h@omniture.com', '1996-02-13', '523-259-6688');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (91, 'Vanni', 'Topling', 'vtopling2i@tinypic.com', '1979-08-29', '808-781-1962');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (92, 'Cindee', 'Rowberry', 'crowberry2j@wordpress.org', '1981-11-15', '671-139-4908');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (93, 'Walliw', 'Blemen', 'wblemen2k@geocities.jp', '1987-04-17', '118-487-4381');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (94, 'Ester', 'Newport', 'enewport2l@sphinn.com', null, '367-425-2701');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (95, 'Darcey', 'Alvarado', 'dalvarado2m@1und1.de', null, '811-286-1880');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (96, 'Chloris', 'Haggerston', null, '1994-04-16', '579-690-7445');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (97, 'Noble', 'Venable', 'nvenable2o@wunderground.com', '1974-01-03', '906-438-6142');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (98, 'Emelen', 'Bjerkan', 'ebjerkan2p@dedecms.com', null, '763-424-8537');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (99, 'Milena', 'Carr', 'mcarr2q@uiuc.edu', null, null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (100, 'Karyn', 'Legrand', 'klegrand2r@moonfruit.com', '1965-05-24', '913-592-7685');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (101, 'Freddie', 'Ludman', 'fludman2s@berkeley.edu', '1971-05-23', '313-133-1397');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (102, 'Catharine', 'Sleeman', 'csleeman2t@wikipedia.org', '1968-05-17', '794-507-0182');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (103, 'Griffy', 'Jereatt', 'gjereatt2u@admin.ch', '1997-10-02', '432-303-3766');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (104, 'Dion', 'Holgan', 'dholgan2v@privacy.gov.au', '2000-07-06', '203-236-1823');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (105, 'Gigi', 'Bruckstein', null, null, '993-875-5338');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (106, 'Maybelle', 'Melmeth', 'mmelmeth2x@reddit.com', '1968-09-20', '195-998-1599');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (107, 'Laurie', 'Tremontana', null, '1979-06-23', '878-639-9624');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (108, 'Reynold', 'Duny', 'rduny2z@wikipedia.org', '1998-03-04', '796-166-1551');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (109, 'Alvie', 'Capelin', null, '1980-08-20', '640-238-9830');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (110, 'Aluin', 'Bowler', null, null, '122-238-1006');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (111, 'Borg', 'Chatell', 'bchatell32@istockphoto.com', '1981-12-10', '403-219-1310');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (112, 'Penny', 'Well', 'pwell33@vk.com', '1994-01-18', '344-340-8547');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (113, 'Ofilia', 'McGerraghty', 'omcgerraghty34@toplist.cz', '1995-06-16', '931-292-2640');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (114, 'Renae', 'Buff', 'rbuff35@google.com', '1973-11-09', '576-524-2304');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (115, 'Lula', 'Heigl', null, '1992-04-20', '497-703-3788');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (116, 'Jasen', 'Haggath', 'jhaggath37@cnet.com', '1969-01-17', '969-758-1630');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (117, 'Goldy', 'Purtell', 'gpurtell38@free.fr', '1992-12-05', '654-456-6616');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (118, 'Glori', 'Widdowson', 'gwiddowson39@spotify.com', null, '967-385-9075');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (119, 'Berte', 'Barwise', null, '1987-07-27', '650-742-8246');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (120, 'Janot', 'Flawn', 'jflawn3b@businessweek.com', '1992-10-14', '102-729-5098');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (121, 'Auroora', 'Marland', 'amarland3c@twitter.com', '1967-04-29', '936-693-3043');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (122, 'Agnes', 'Palfreeman', 'apalfreeman3d@istockphoto.com', null, null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (123, 'Lucien', 'Jacklin', 'ljacklin3e@mlb.com', null, '512-664-6740');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (124, 'Irena', 'Petrashov', 'ipetrashov3f@uol.com.br', '1977-11-07', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (125, 'Kristofor', 'Paulo', 'kpaulo3g@fda.gov', '1964-03-16', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (126, 'Josephine', 'Esom', null, '1999-12-08', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (127, 'Malvina', 'Catteroll', 'mcatteroll3i@miitbeian.gov.cn', null, '196-852-9323');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (128, 'Gaynor', 'Gallelli', 'ggallelli3j@businessinsider.com', '1963-10-31', '466-805-4570');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (129, 'Abbey', 'Horley', 'ahorley3k@about.com', '1973-09-20', '933-991-2097');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (130, 'Chandra', 'Blakeden', 'cblakeden3l@opensource.org', '1998-01-17', '680-889-2199');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (131, 'Aubrette', 'Trownson', 'atrownson3m@xinhuanet.com', '1992-03-02', '822-541-1066');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (132, 'Celestyna', 'Havenhand', 'chavenhand3n@wikimedia.org', '1978-04-18', '400-306-9188');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (133, 'Isabella', 'Kennelly', 'ikennelly3o@tripadvisor.com', '1981-06-01', '836-660-7331');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (134, null, null, 'dcaccavella3p@archive.org', '1983-03-21', '131-459-1728');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (135, 'Lainey', 'Skellington', 'lskellington3q@elpais.com', '1991-07-04', '872-933-4882');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (136, 'Filbert', 'Landman', 'flandman3r@earthlink.net', '1980-07-05', '721-394-8517');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (137, 'Rutter', 'Dayly', 'rdayly3s@wsj.com', '1993-02-17', '373-260-7036');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (138, 'Moshe', 'Pilmoor', 'mpilmoor3t@friendfeed.com', '1990-10-02', '356-898-9373');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (139, null, null, 'screebo3u@reference.com', '1987-07-18', '808-593-5198');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (140, 'Christan', 'Giannassi', 'cgiannassi3v@google.ru', '1993-07-21', '859-716-9352');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (141, null, null, 'ihourihane3w@unc.edu', '1998-07-24', '496-829-0986');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (142, 'Fedora', 'Holliar', 'fholliar3x@free.fr', '1999-05-30', '490-114-1834');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (143, 'Vidovic', 'Borgne', 'vborgne3y@instagram.com', null, '677-364-3922');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (144, 'Kent', 'Brayford', 'kbrayford3z@google.de', '1995-12-05', '878-455-1537');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (145, 'Cly', 'Humbatch', 'chumbatch40@weebly.com', '1975-02-28', '943-302-9768');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (146, 'Drucill', 'Chape', 'dchape41@ifeng.com', '1973-12-18', '553-165-2679');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (147, 'Dasie', 'Romanini', 'dromanini42@meetup.com', '1977-01-24', '862-682-7576');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (148, 'Aluino', 'Kantor', 'akantor43@pbs.org', '1975-09-21', '120-964-7149');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (149, 'Axel', 'Robardey', 'arobardey44@rediff.com', '1977-10-11', '406-391-4231');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (150, 'Efrem', 'Linger', 'elinger45@ow.ly', null, '646-598-4288');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (151, 'Raye', 'O''Lunny', 'rolunny46@ezinearticles.com', '1962-01-24', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (152, 'Davie', 'Colgrave', 'dcolgrave47@pinterest.com', '1981-06-13', '959-506-2929');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (153, 'Tabby', 'Killimister', null, null, '184-684-1373');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (154, 'Bernadene', 'Knoble', 'bknoble49@hao123.com', '1966-07-19', '967-691-8055');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (155, 'Thane', 'Tull', 'ttull4a@opensource.org', '1997-02-12', '801-878-0037');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (156, 'D''arcy', 'Brideoke', 'dbrideoke4b@imdb.com', '1994-01-01', '563-267-3405');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (157, 'Brande', 'Chugg', 'bchugg4c@squidoo.com', null, null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (158, 'Dita', 'Folling', 'dfolling4d@archive.org', '1981-08-07', '133-481-7174');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (159, 'Alisander', 'Eatock', 'aeatock4e@dot.gov', '1980-06-23', '681-317-1160');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (160, null, null, 'akempston4f@reference.com', '1965-12-02', '383-550-5399');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (161, 'Win', 'Seilmann', 'wseilmann4g@bizjournals.com', null, '889-781-9709');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (162, 'Duffy', 'Kiljan', 'dkiljan4h@nbcnews.com', null, '939-852-7383');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (163, 'Gerladina', 'Trodd', 'gtrodd4i@zdnet.com', '1998-04-21', '750-129-2741');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (164, 'Evvie', 'Spain', 'espain4j@census.gov', '1964-02-03', '802-999-8725');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (165, 'Freddie', 'Delacour', null, '1993-08-31', '392-138-0984');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (166, 'Emmy', 'Roscoe', 'eroscoe4l@sciencedaily.com', '1990-05-27', '670-481-8953');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (167, 'Sari', 'Baniard', 'sbaniard4m@microsoft.com', '1974-11-13', '400-637-1584');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (168, 'Phyllida', 'Yurkin', 'pyurkin4n@dyndns.org', '1984-12-11', '963-100-2985');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (169, 'Avis', 'Gravell', 'agravell4o@japanpost.jp', '1993-12-03', '818-668-5286');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (170, 'Rivi', 'De Paepe', null, '1993-01-13', '181-531-4260');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (171, null, null, 'dsouthcombe4q@clickbank.net', '1994-09-06', '112-239-4207');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (172, 'Annadiane', 'Hearon', 'ahearon4r@arizona.edu', '1984-04-21', '403-191-9238');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (173, 'Maurine', 'Chaston', 'mchaston4s@psu.edu', '1988-03-03', '237-285-3808');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (174, null, null, 'gstandage4t@google.es', null, '799-636-2843');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (175, 'Ferdinanda', 'Caramuscia', 'fcaramuscia4u@umn.edu', null, '455-257-1031');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (176, 'Rodi', 'Capstake', null, null, '938-364-0302');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (177, 'Kerianne', 'Kalvin', 'kkalvin4w@thetimes.co.uk', '1980-07-29', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (178, 'Andi', 'Warsop', 'awarsop4x@symantec.com', null, '422-550-7294');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (179, 'Burl', 'Phittiplace', 'bphittiplace4y@typepad.com', '1972-08-05', '629-335-2258');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (180, 'Edee', 'Fenwick', 'efenwick4z@google.cn', '1979-10-21', '376-101-3689');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (181, 'Christoforo', 'Plewright', 'cplewright50@instagram.com', '1971-02-18', '652-578-0911');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (182, 'Willdon', 'Lintot', 'wlintot51@census.gov', '1984-01-21', '102-826-4103');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (183, 'Rois', 'Scarfe', 'rscarfe52@mashable.com', '1984-11-10', '218-623-8307');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (184, 'Sutton', 'Le Gassick', 'slegassick53@artisteer.com', '1974-08-05', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (185, 'Glendon', 'Codling', 'gcodling54@ask.com', null, null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (186, 'Sher', 'Bucham', 'sbucham55@webs.com', null, '175-834-1225');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (187, 'Gan', 'Lemmanbie', 'glemmanbie56@nationalgeographic.com', '1963-02-05', '834-711-6455');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (188, 'Arri', 'Ricks', 'aricks57@wordpress.com', '1987-03-22', '284-294-4710');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (189, 'Charmine', 'Spinetti', 'cspinetti58@ed.gov', null, '666-745-0279');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (190, 'Ailsun', 'Dawidowsky', 'adawidowsky59@omniture.com', '1971-07-31', '275-187-3633');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (191, 'Tamera', 'Stolze', null, null, '541-331-3471');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (192, 'Xenos', 'Pitkin', 'xpitkin5b@domainmarket.com', '1970-10-09', '723-946-3696');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (193, 'Shauna', 'Klesel', 'sklesel5c@nymag.com', '1976-03-24', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (194, 'Katrina', 'Lyal', 'klyal5d@state.gov', '1982-09-28', '478-544-5089');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (195, 'Mikey', 'Grant', 'mgrant5e@wikipedia.org', null, '272-775-5001');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (196, 'Maury', 'Warrillow', 'mwarrillow5f@umich.edu', '1978-10-17', '241-106-5720');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (197, 'Sherie', 'Summerhayes', 'ssummerhayes5g@hubpages.com', '1995-01-16', '342-684-3907');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (198, 'Starlene', 'Rochewell', 'srochewell5h@studiopress.com', '1965-05-01', '320-840-9358');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (199, 'Nat', 'Raleston', 'nraleston5i@bigcartel.com', null, '562-261-8409');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (200, 'Benedict', 'Edgin', 'bedgin5j@github.com', '1968-09-18', '951-686-4095');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (201, 'Garrek', 'Proschke', 'gproschke5k@ifeng.com', null, '535-894-5193');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (202, 'Isidora', 'Itzchaki', 'iitzchaki5l@alibaba.com', '1981-08-16', '264-494-8321');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (203, 'Lil', 'Nevill', 'lnevill5m@yelp.com', '1969-12-13', '693-501-1474');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (204, null, null, 'pbleby5n@usnews.com', null, '657-503-1263');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (205, 'Dory', 'Risson', 'drisson5o@comcast.net', '1984-08-05', '383-238-0311');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (206, null, null, 'dnance5p@dagondesign.com', null, '130-834-3596');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (207, 'Saul', 'Simoes', null, '1997-11-29', '337-404-8956');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (208, 'Gertruda', 'Emilien', 'gemilien5r@fda.gov', '1973-01-26', '990-748-4990');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (209, 'Sonni', 'McElrea', 'smcelrea5s@trellian.com', '1991-10-22', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (210, 'Fons', 'Finnick', 'ffinnick5t@fema.gov', '1975-06-08', '835-431-8966');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (211, 'Moreen', 'Dole', null, '1995-07-27', '319-793-6452');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (212, 'Abbie', 'Dumberell', 'adumberell5v@ycombinator.com', null, '157-419-5341');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (213, 'Antonius', 'Pymar', 'apymar5w@mysql.com', null, '342-869-9655');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (214, 'Gayler', 'Broxis', 'gbroxis5x@digg.com', null, null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (215, 'Cort', 'Pietroni', 'cpietroni5y@imgur.com', null, '114-898-6284');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (216, 'Freeland', 'Cready', 'fcready5z@java.com', '1967-04-12', '988-507-8176');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (217, 'Monroe', 'Lowrey', 'mlowrey60@state.gov', '1962-10-23', '159-104-8278');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (218, 'Tatiana', 'Phelan', 'tphelan61@google.de', null, '668-665-4028');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (219, 'Ranique', 'Mellonby', 'rmellonby62@xinhuanet.com', '1995-06-18', '184-232-0958');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (220, 'Jerry', 'Glidder', null, '1989-02-23', '586-217-0400');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (221, 'Rip', 'Hillam', null, '1963-03-13', '881-573-2403');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (222, 'Ariella', 'Denys', 'adenys65@163.com', '1985-11-27', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (223, 'Dore', 'Guerre', 'dguerre66@miibeian.gov.cn', '1977-05-20', '822-552-7260');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (224, 'Laurette', 'Nipper', 'lnipper67@chron.com', '1987-07-22', '887-257-8613');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (225, 'Emelina', 'Pendell', 'ependell68@ebay.co.uk', '1990-06-08', '507-362-8702');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (226, 'Raynor', 'Randlesome', 'rrandlesome69@g.co', '1980-04-13', '755-115-3317');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (227, null, null, 'erevan6a@adobe.com', null, '937-825-0575');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (228, 'Cody', 'Fossey', 'cfossey6b@php.net', '1991-01-16', '762-952-7194');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (229, 'Lilas', 'Langmead', 'llangmead6c@google.cn', '1987-03-28', '300-374-1227');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (230, 'Glenn', 'Woolfoot', 'gwoolfoot6d@jimdo.com', '1978-09-13', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (231, 'Caroljean', 'Neilan', 'cneilan6e@about.me', null, '153-489-5228');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (232, 'Jackie', 'Lehemann', 'jlehemann6f@admin.ch', '1962-07-10', '377-741-0561');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (233, null, null, 'wchace6g@themeforest.net', '1969-02-15', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (234, 'Berget', 'Gullen', 'bgullen6h@cnbc.com', '1981-05-15', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (235, 'Eran', 'Luther', null, null, '290-742-3567');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (236, 'Melony', 'Oswell', 'moswell6j@cdc.gov', '1983-07-13', '730-732-1616');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (237, 'Edvard', 'Tire', 'etire6k@thetimes.co.uk', '1987-04-07', '852-636-3345');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (238, 'Hendrick', 'Ransom', 'hransom6l@slideshare.net', null, '106-803-5771');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (239, 'Bethany', 'Mawford', 'bmawford6m@bravesites.com', '1984-08-25', '203-388-9094');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (240, 'Lorna', 'Norvell', 'lnorvell6n@booking.com', '1977-04-05', '650-646-4102');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (241, 'Sissy', 'Diboll', 'sdiboll6o@163.com', '1988-07-05', '808-993-1283');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (242, 'Niven', 'MacAndrew', 'nmacandrew6p@live.com', '1976-04-21', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (243, 'Bethanne', 'Revell', null, null, '262-749-8273');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (244, 'Elane', 'Milch', 'emilch6r@wix.com', '1998-12-11', '923-682-5742');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (245, 'Irita', 'Nardoni', 'inardoni6s@ezinearticles.com', '1979-06-16', '366-166-0033');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (246, 'Isac', 'Girault', 'igirault6t@imdb.com', null, '274-496-1789');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (247, 'Cazzie', 'Bysouth', 'cbysouth6u@yandex.ru', '1979-06-23', '732-710-0183');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (248, 'Georgie', 'Bernakiewicz', 'gbernakiewicz6v@irs.gov', '1998-06-17', '446-327-3712');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (249, 'Clayson', 'Hully', null, '1992-09-18', '501-255-9605');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (250, 'Eleanora', 'Yosifov', 'eyosifov6x@elegantthemes.com', '1973-05-30', '280-108-2589');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (251, null, null, 'plegen6y@cnn.com', '1973-11-25', '395-425-4958');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (252, null, null, 'apreator6z@e-recht24.de', '1985-12-10', '678-631-8249');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (253, 'Ann', 'Cristofolo', 'acristofolo70@bloglovin.com', '1988-11-27', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (254, 'Locke', 'Anersen', null, '1975-09-09', '884-387-6284');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (255, 'Devlen', 'Bachman', null, '1987-04-09', '698-299-7233');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (256, 'Seamus', 'Clayfield', null, '1962-07-14', '997-626-6215');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (257, 'Alf', 'Burnitt', 'aburnitt74@cmu.edu', '1995-03-27', '592-340-8901');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (258, 'Arnold', 'Moroney', 'amoroney75@google.com', '1972-02-26', '611-456-0867');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (259, 'Mable', 'Grice', 'mgrice76@ucoz.ru', '1998-01-13', '218-184-3875');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (260, 'Pace', 'MacConnell', 'pmacconnell77@twitter.com', '1975-03-02', '111-778-9240');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (261, 'Llywellyn', 'Brewis', 'lbrewis78@cpanel.net', null, '880-938-1835');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (262, 'Chelsie', 'Blasoni', null, '1992-05-12', '490-300-4574');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (263, 'Gustavus', 'Browncey', 'gbrowncey7a@cloudflare.com', '1985-10-20', '982-332-2346');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (264, 'Abagail', 'Sandeman', 'asandeman7b@istockphoto.com', '1961-04-30', '643-708-9481');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (265, 'Shell', 'Couve', 'scouve7c@chicagotribune.com', '1963-11-19', '128-164-4975');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (266, 'Rowney', 'Whitebrook', 'rwhitebrook7d@1688.com', '1990-01-08', '445-157-3919');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (267, null, null, 'amerriman7e@businessweek.com', '1983-09-06', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (268, 'Cari', 'Whetnell', 'cwhetnell7f@paypal.com', null, null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (269, 'Jameson', 'Pett', 'jpett7g@technorati.com', '1994-09-26', '730-267-1529');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (270, 'Devina', 'Czajkowski', 'dczajkowski7h@macromedia.com', null, '667-522-0244');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (271, 'Aubry', 'Luke', 'aluke7i@mail.ru', null, null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (272, 'Kiersten', 'Pomfret', 'kpomfret7j@themeforest.net', '1998-09-22', '789-547-8072');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (273, 'Suzanne', 'Elby', null, '1969-07-16', '811-402-9234');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (274, 'Catharina', 'Crossthwaite', 'ccrossthwaite7l@elegantthemes.com', '1992-01-28', '542-563-3629');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (275, 'Hyacinth', 'Chastney', 'hchastney7m@reference.com', null, null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (276, 'Laurie', 'Pritty', 'lpritty7n@dailymotion.com', '1999-09-25', '860-389-4544');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (277, 'Alfredo', 'Girsch', null, '1992-12-04', '694-603-0367');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (278, 'Augie', 'Erickson', 'aerickson7p@soup.io', '1970-05-06', '428-544-5176');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (279, 'Meredith', 'Insull', 'minsull7q@msu.edu', '1997-08-18', '616-401-2206');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (280, 'Calida', 'Tilt', 'ctilt7r@cnbc.com', '1962-09-24', '687-552-6131');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (281, 'Percy', 'Antonognoli', 'pantonognoli7s@blinklist.com', '1965-05-23', '370-909-3722');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (282, 'Renaud', 'Killick', 'rkillick7t@123-reg.co.uk', null, null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (283, 'Gussy', 'Flatt', 'gflatt7u@wired.com', '1979-09-21', '649-661-5684');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (284, 'Lanny', 'Callen', 'lcallen7v@drupal.org', '1969-02-03', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (285, 'Godiva', 'O''Cannovane', null, '1963-12-18', '650-326-9946');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (286, 'Trista', 'Creboe', 'tcreboe7x@indiegogo.com', '1965-08-02', '549-804-6188');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (287, 'Hagan', 'Southcomb', 'hsouthcomb7y@mail.ru', '1971-07-23', '402-666-0178');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (288, 'Ruddie', 'Bulluck', 'rbulluck7z@blinklist.com', null, null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (289, 'Gisela', 'Oppery', null, '1995-08-11', '325-846-5617');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (290, 'Brenda', 'Parysowna', 'bparysowna81@globo.com', '1963-07-06', '615-274-1166');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (291, null, null, 'gpurser82@list-manage.com', '1985-08-13', '614-709-2562');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (292, 'Teodora', 'MacKeeg', 'tmackeeg83@abc.net.au', '1987-07-01', '864-270-3356');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (293, 'Carrol', 'Jerg', 'cjerg84@de.vu', '1971-09-28', '383-780-6374');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (294, 'Berkly', 'Crowne', 'bcrowne85@sitemeter.com', '1969-10-12', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (295, 'Samara', 'Wheal', 'swheal86@nhs.uk', '1995-09-15', '930-919-7580');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (296, 'Dion', 'Foxten', 'dfoxten87@patch.com', '1994-01-11', '646-941-8205');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (297, 'Pernell', 'Pordal', 'ppordal88@wordpress.com', '1975-09-06', null);
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (298, 'Georges', 'Guiduzzi', null, '1995-08-14', '801-509-8346');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (299, 'Miguel', 'Postle', 'mpostle8a@webnode.com', '1962-10-19', '102-680-4606');
insert into Customers (Customer_id, First_Name, Last_Name, Email, Birthday, Phone_number) values (300, 'Clo', 'McRannell', 'cmcrannell8b@goodreads.com', '1990-03-26', '851-696-5062');

--inserting to employees
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (1, 'Laird', 'Gellan', 36, 'M', '196-899-2600', '2021-12-26', null, 'Waiter', 39);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (2, 'Laina', 'Soot', 70, 'F', '174-705-3247', '2021-10-23', '2021-11-23', 'Chef', 180);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (3, 'Hanna', 'Chancellor', 64, 'F', '980-638-6341', '2021-11-12', null, 'Restaurant manager', 200);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (4, 'Aluino', 'Sadgrove', 51, 'M', '636-649-6649', '2022-01-28', null, 'Cleaner', 25);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (5, 'Allegra', 'Skilbeck', 66, 'F', '989-611-3182', '2021-01-21', null, 'Waiter', 40);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (6, 'Delcina', 'Hellwich', 54, 'F', '992-607-0624', '2020-10-27', null, 'Cleaner', 30);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (7, 'Megen', 'Moss', 44, 'F', '170-497-4115', '2021-02-14', null, 'Shift_Manager', 72);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (8, 'Madison', 'Barz', 36, 'M', '352-241-4401', '2022-09-20', null, 'Shift_Manager', 61);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (9, 'Jess', 'Orridge', 42, 'M', '618-975-8400', '2022-03-07', null, 'Kitchen_staff', 55);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (10, 'Mack', 'Toffalo', 24, 'M', '114-497-4463', '2021-01-31', null, 'Chef', 180);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (11, 'Doyle', 'Remmer', 49, 'M', null, '2022-08-26', null, 'Waiter', 45);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (12, 'Avrom', 'Auckland', 62, 'M', '926-864-8907', '2020-12-16', null, 'Waiter', 54);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (13, 'Kizzee', 'Hornig', 66, 'F', '187-572-8403', '2020-10-20', null, 'Kitchen_staff', 23);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (14, null, 'Muckle', null, 'M', '114-987-4463', '2022-03-19', null, 'Host', 26);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (15, 'Joice', 'De Ferrari', 26, 'F', '275-192-6380', '2021-11-13', '2021-12-27', 'host', 30);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (16, 'Analise', 'Glazzard', 51, 'F', '361-453-6115', '2022-01-10', null, 'Shift_Manager', 98);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (17, 'Lishe', 'Crips', 38, 'F', '349-774-3764', '2022-05-18', null, 'Host', 30);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (18, 'Ramonda', 'Darker', 69, 'F', '834-361-7738', '2021-06-11', null, 'Kitchen_staff', 50);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (19, 'Allis', 'Waszkiewicz', 47, 'F', '252-252-2606', '2022-03-07', null, 'Waiter', 44);
insert into Employees (Employee_id, First_Name, Last_Name, Age, Gender, Phone_number, Join_date, End_date, Role, Hourly_Salary) values (20, 'Starr', 'Viner', 49, 'F', '837-552-4688', '2022-06-22', null, 'Cleaner', 30);


--inserting to Meals
insert into Meals (Meal_id, Meal_name, Meal_menu_price, Meal_cost) values (1, 'Risotto', 7, 5);
insert into Meals (Meal_id, Meal_name, Meal_menu_price, Meal_cost) values (2, 'Polenta', 34, 9);
insert into Meals (Meal_id, Meal_name, Meal_menu_price, Meal_cost) values (3, 'Lasagna', 19, 13);
insert into Meals (Meal_id, Meal_name, Meal_menu_price, Meal_cost) values (4, 'Ravioli', 22, 8);
insert into Meals (Meal_id, Meal_name, Meal_menu_price, Meal_cost) values (5, 'Osso buco', 20, 2);
insert into Meals (Meal_id, Meal_name, Meal_menu_price, Meal_cost) values (6, 'Arancini', 12, 3);
insert into Meals (Meal_id, Meal_name, Meal_menu_price, Meal_cost) values (7, 'Carbonara', 21, 6);
insert into Meals (Meal_id, Meal_name, Meal_menu_price, Meal_cost) values (8, 'Ribollita', 17, 9);
insert into Meals (Meal_id, Meal_name, Meal_menu_price, Meal_cost) values (9, 'Pizza', 13, 5);
insert into Meals (Meal_id, Meal_name, Meal_menu_price, Meal_cost) values (10, 'Caprese', 10, 20);
insert into Meals (Meal_id, Meal_name, Meal_menu_price, Meal_cost) values (11, 'Gnocchi', 4, 1);
insert into Meals (Meal_id, Meal_name, Meal_menu_price, Meal_cost) values (12, 'Swordfish', 28, 18);
insert into Meals (Meal_id, Meal_name, Meal_menu_price, Meal_cost) values (13, 'Parmigiana', 28, 7);
insert into Meals (Meal_id, Meal_name, Meal_menu_price, Meal_cost) values (14, 'Tiramisu', 16, 6);
insert into Meals (Meal_id, Meal_name, Meal_menu_price, Meal_cost) values (15, 'Steak', 30, 12);


--inserting to Orders
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (1, null, '2022-07-13 07:17:19', 15);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (2, 91, '2021-05-23 20:04:19', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (3, 84, '2020-11-16 03:13:51', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (4, 165, '2021-08-28 06:14:56', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (5, 297, '2022-03-02 08:16:52', 13);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (6, 134, '2020-11-09 14:58:57', 9);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (7, null, '2022-01-18 02:43:38', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (8, 162, '2021-10-15 20:33:54', 15);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (9, 283, '2021-09-25 04:05:27', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (10, null, '2022-08-04 07:30:52', 1);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (11, 200, '2022-03-13 23:03:14', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (12, 252, '2022-02-15 18:04:10', 6);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (13, 58, '2021-09-26 18:12:45', 10);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (14, 152, '2022-07-19 10:54:47', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (15, null, '2020-12-27 11:45:46', 6);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (16, 21, '2022-09-24 20:56:22', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (17, null, '2021-09-16 13:51:32', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (18, 289, '2022-07-05 07:43:15', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (19, 85, '2021-08-16 19:30:58', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (20, 247, '2021-12-25 10:01:27', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (21, 279, '2022-01-07 21:06:56', 13);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (22, 87, '2022-09-04 23:37:33', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (23, 82, '2021-10-07 01:45:17', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (24, 133, '2022-05-09 10:44:18', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (25, 22, '2021-06-16 06:41:38', 15);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (26, null, '2022-05-04 00:18:27', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (27, 7, '2021-04-29 20:51:41', 8);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (28, null, '2022-01-08 23:26:39', 8);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (29, 118, '2020-11-25 14:27:12', 12);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (30, null, '2022-08-13 23:16:15', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (31, null, '2022-07-02 05:38:04', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (32, 281, '2022-08-01 12:11:24', 8);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (33, 113, '2021-04-22 14:14:14', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (34, 138, '2021-04-29 08:34:13', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (35, 84, '2022-02-07 04:28:44', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (36, null, '2020-11-23 12:24:19', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (37, 120, '2022-01-26 16:08:10', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (38, null, '2021-10-10 09:38:25', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (39, 241, '2021-11-24 01:55:43', 6);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (40, 259, '2021-06-20 08:04:45', 9);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (41, 106, '2020-12-03 07:31:50', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (42, 103, '2021-05-10 03:57:22', 10);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (43, 162, '2021-12-02 20:04:08', 8);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (44, 163, '2022-03-06 12:39:07', 9);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (45, 200, '2021-06-03 21:29:31', 11);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (46, 87, '2021-01-19 11:29:15', 12);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (47, null, '2020-12-09 03:19:42', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (48, 271, '2021-03-18 02:43:34', 13);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (49, 295, '2020-09-30 18:17:17', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (50, 228, '2021-10-31 07:13:02', 15);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (51, 70, '2020-11-17 08:42:46', 6);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (52, null, '2020-11-06 09:59:08', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (53, 89, '2022-09-23 15:42:02', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (54, 169, '2021-06-18 12:42:24', 9);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (55, null, '2020-11-05 00:13:30', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (56, 38, '2022-05-05 22:38:58', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (57, 197, '2020-10-01 09:33:32', 11);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (58, null, '2022-03-12 14:53:48', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (59, 135, '2021-06-24 02:49:11', 15);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (60, 180, '2021-05-19 09:13:29', 12);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (61, 229, '2021-09-19 12:46:18', 10);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (62, null, '2021-05-02 00:07:16', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (63, 72, '2020-10-07 12:37:12', 8);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (64, 57, '2022-06-25 15:31:15', 11);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (65, 107, '2021-10-14 12:47:06', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (66, null, '2021-12-02 21:17:33', 1);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (67, 114, '2021-06-08 21:54:25', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (68, 244, '2021-01-23 14:35:15', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (69, null, '2022-06-14 07:05:44', 11);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (70, 136, '2022-03-13 08:58:07', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (71, 81, '2022-07-19 14:12:46', 9);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (72, 222, '2022-04-22 23:08:18', 1);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (73, 8, '2022-06-01 16:17:39', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (74, 291, '2021-05-29 14:11:41', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (75, 251, '2021-12-03 00:27:50', 14);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (76, null, '2021-01-28 01:03:07', 13);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (77, 198, '2022-04-02 23:19:19', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (78, 75, '2022-04-13 08:29:18', 9);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (79, 70, '2022-02-23 04:46:16', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (80, 43, '2022-03-13 20:34:56', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (81, null, '2021-04-16 12:12:41', 10);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (82, 55, '2020-12-30 05:20:24', 11);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (83, 34, '2022-09-06 06:56:44', 9);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (84, 166, '2021-05-29 16:49:41', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (85, null, '2021-06-11 20:54:46', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (86, 213, '2020-12-28 16:43:47', 1);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (87, 12, '2020-11-21 04:46:44', 10);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (88, 205, '2021-10-31 16:48:18', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (89, 55, '2021-02-05 06:44:12', 12);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (90, null, '2022-09-09 17:28:38', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (91, 93, '2021-11-30 13:31:19', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (92, 170, '2021-02-25 15:42:06', 11);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (93, 8, '2022-09-21 04:29:45', 11);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (94, null, '2021-03-21 23:12:23', 6);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (95, 153, '2021-07-31 22:58:22', 14);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (96, 272, '2022-09-12 02:41:13', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (97, 94, '2022-01-09 04:12:07', 8);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (98, 148, '2021-10-08 22:16:34', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (99, 259, '2021-08-30 19:22:16', 13);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (100, 95, '2020-12-13 09:13:17', 15);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (101, 236, '2021-03-07 22:24:13', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (102, null, '2022-01-02 04:41:53', 14);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (103, 250, '2021-02-23 08:29:45', 8);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (104, 248, '2022-08-18 12:46:41', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (105, 96, '2021-11-14 13:58:14', 14);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (106, null, '2020-10-31 17:24:17', 13);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (107, 267, '2021-06-03 09:08:35', 14);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (108, 237, '2022-05-01 15:27:44', 8);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (109, 163, '2021-09-07 05:09:52', 6);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (110, 21, '2021-01-12 05:34:32', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (111, null, '2021-12-06 14:01:33', 14);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (112, 159, '2021-02-12 16:24:29', 14);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (113, 300, '2020-12-13 11:16:20', 11);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (114, 153, '2022-09-21 00:45:20', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (115, null, '2021-03-14 00:11:11', 15);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (116, 272, '2020-10-27 02:35:35', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (117, 235, '2021-12-07 15:20:22', 9);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (118, 264, '2022-09-01 06:44:17', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (119, 147, '2020-12-15 20:19:30', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (120, 144, '2022-04-06 15:16:08', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (121, 39, '2021-01-23 02:21:45', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (122, null, '2021-07-28 05:50:00', 1);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (123, 20, '2021-11-13 12:50:09', 12);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (124, 163, '2022-01-19 15:48:06', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (125, 64, '2022-07-11 18:11:16', 15);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (126, 234, '2021-02-18 13:10:37', 10);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (127, 264, '2021-11-09 17:15:14', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (128, 226, '2021-06-27 02:20:37', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (129, 181, '2022-01-15 14:05:18', 6);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (130, 228, '2020-11-24 19:37:08', 11);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (131, null, '2022-06-16 00:38:04', 6);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (132, null, '2022-05-24 15:20:04', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (133, 164, '2022-04-05 15:40:59', 15);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (134, 177, '2021-06-15 19:33:05', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (135, 253, '2022-09-26 07:50:04', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (136, 8, '2020-10-18 18:46:43', 11);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (137, 262, '2022-04-29 23:22:19', 9);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (138, 271, '2022-03-14 03:09:49', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (139, 102, '2021-03-05 05:13:52', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (140, 105, '2021-01-30 04:50:11', 8);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (141, 231, '2022-03-21 10:28:00', 15);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (142, null, '2020-11-11 11:08:10', 11);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (143, 230, '2021-03-11 06:14:38', 1);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (144, 263, '2022-07-17 13:01:48', 12);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (145, 252, '2022-02-20 17:30:30', 9);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (146, 279, '2021-06-10 18:47:57', 11);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (147, 195, '2022-09-26 08:16:17', 14);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (148, 26, '2021-04-28 09:45:10', 6);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (149, 158, '2022-05-13 02:55:55', 12);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (150, 265, '2020-12-26 14:17:16', 1);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (151, 142, '2021-06-25 04:30:29', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (152, 21, '2021-11-03 06:57:25', 15);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (153, 279, '2021-04-30 15:04:37', 8);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (154, 215, '2020-12-07 21:03:36', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (155, 239, '2022-06-15 02:44:20', 8);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (156, null, '2022-03-04 03:24:26', 8);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (157, null, '2021-06-09 11:27:26', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (158, 84, '2021-02-28 07:22:43', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (159, 24, '2022-01-20 17:56:05', 12);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (160, 33, '2021-02-05 17:05:40', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (161, 67, '2022-05-20 00:40:25', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (162, 204, '2022-06-14 14:35:52', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (163, 39, '2021-05-03 05:49:27', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (164, 285, '2022-09-20 19:37:55', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (165, null, '2021-10-07 12:27:10', 11);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (166, null, '2022-01-10 13:31:58', 14);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (167, 254, '2022-06-06 21:42:10', 11);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (168, 235, '2022-05-17 17:14:05', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (169, 281, '2021-07-25 14:15:31', 1);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (170, 180, '2021-12-14 13:51:23', 9);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (171, 160, '2021-09-16 23:46:37', 6);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (172, 206, '2021-08-16 16:37:17', 6);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (173, 102, '2022-02-24 07:51:02', 11);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (174, null, '2022-05-23 03:47:02', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (175, 274, '2022-05-30 01:43:06', 1);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (176, 166, '2022-08-18 01:21:23', 8);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (177, 250, '2022-06-15 17:10:13', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (178, 80, '2021-03-29 11:43:36', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (179, 10, '2022-01-10 15:17:39', 6);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (180, 106, '2021-07-08 02:33:08', 13);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (181, 192, '2020-11-23 11:10:42', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (182, 118, '2021-02-19 11:11:44', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (183, null, '2020-12-14 03:58:58', 3);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (184, 295, '2022-03-07 08:48:59', 6);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (185, 207, '2022-09-15 20:34:26', 15);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (186, 213, '2021-06-29 02:12:57', 9);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (187, 109, '2021-11-18 09:32:02', 8);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (188, 143, '2022-07-24 15:13:08', 15);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (189, 90, '2021-01-18 22:59:17', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (190, 297, '2021-10-09 22:50:43', 10);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (191, 2, '2022-02-24 03:25:24', 15);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (192, 36, '2021-11-23 01:38:39', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (193, 95, '2020-11-11 23:09:07', 10);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (194, null, '2022-09-09 06:25:28', 2);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (195, 215, '2021-12-01 20:31:08', 5);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (196, 213, '2021-09-27 13:07:38', 14);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (197, 252, '2021-02-19 17:09:42', 9);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (198, null, '2020-11-22 18:30:29', 4);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (199, null, '2020-12-29 15:56:17', 7);
insert into Orders (Order_id, Customer_id, Date, Meal_id) values (200, 240, '2022-04-18 23:18:27', 2);


--Inserting to payment
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (1, 285, 462, '2021-11-03');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (2, null, 384, '2022-09-23');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (3, 35, 406, '2022-04-17');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (4, 174, 670, '2022-02-21');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (5, 225, 929, '2022-08-02');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (6, 245, 740, '2022-08-25');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (7, 181, 783, '2022-02-16');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (8, 186, 435, '2022-04-30');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (9, 150, 474, '2022-05-02');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (10, 111, 754, '2022-06-20');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (11, 132, 354, '2022-08-19');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (12, 278, 59, '2022-05-11');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (13, 213, 173, '2022-04-20');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (14, null, 437, '2021-11-04');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (15, 156, 4, '2022-01-10');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (16, null, 487, '2022-07-28');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (17, 120, 728, '2021-12-25');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (18, null, 515, '2021-10-14');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (19, 96, 932, '2022-02-11');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (20, null, 799, '2022-02-06');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (21, 241, 597, '2022-04-29');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (22, 9, 470, '2022-07-01');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (23, 48, 879, '2021-12-06');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (24, null, 329, '2022-01-27');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (25, 276, 967, '2021-12-06');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (26, 284, 885, '2022-04-05');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (27, null, 704, '2022-02-05');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (28, 141, 274, '2022-01-20');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (29, 256, 811, '2022-02-21');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (30, null, 755, '2021-11-10');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (31, null, 274, '2022-02-15');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (32, 32, 493, '2022-05-15');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (33, 41, 144, '2022-04-17');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (34, null, 529, '2022-03-09');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (35, 186, 881, '2022-01-06');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (36, null, 890, '2022-01-21');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (37, null, 139, '2022-02-15');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (38, 121, 990, '2022-05-13');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (39, 146, 264, '2021-10-03');
insert into Payment (Pay_id, Customer_id, Pay_amount, Date) values (40, 23, 576, '2022-07-10');

--inserting into tables

insert into Tables (Table_id, Number_of_sits) values (1, 7);
insert into Tables (Table_id, Number_of_sits) values (2, 2);
insert into Tables (Table_id, Number_of_sits) values (3, 8);
insert into Tables (Table_id, Number_of_sits) values (4, 20);
insert into Tables (Table_id, Number_of_sits) values (5, 6);
insert into Tables (Table_id, Number_of_sits) values (6, 10);
insert into Tables (Table_id, Number_of_sits) values (7, 4);
insert into Tables (Table_id, Number_of_sits) values (8, 4);
insert into Tables (Table_id, Number_of_sits) values (9, 4);
insert into Tables (Table_id, Number_of_sits) values (10, 20);
insert into Tables (Table_id, Number_of_sits) values (11, 1);
insert into Tables (Table_id, Number_of_sits) values (12, 14);
insert into Tables (Table_id, Number_of_sits) values (13, 7);
insert into Tables (Table_id, Number_of_sits) values (14, 10);
insert into Tables (Table_id, Number_of_sits) values (15, 9);
insert into Tables (Table_id, Number_of_sits) values (16, 6);
insert into Tables (Table_id, Number_of_sits) values (17, 6);
insert into Tables (Table_id, Number_of_sits) values (18, 10);
insert into Tables (Table_id, Number_of_sits) values (19, 4);
insert into Tables (Table_id, Number_of_sits) values (20, 15);
insert into Tables (Table_id, Number_of_sits) values (21, 8);
insert into Tables (Table_id, Number_of_sits) values (22, 6);
insert into Tables (Table_id, Number_of_sits) values (23, 6);
insert into Tables (Table_id, Number_of_sits) values (24, 6);
insert into Tables (Table_id, Number_of_sits) values (25, 4);
insert into Tables (Table_id, Number_of_sits) values (26, 4);
insert into Tables (Table_id, Number_of_sits) values (27, 11);
insert into Tables (Table_id, Number_of_sits) values (28, 4);
insert into Tables (Table_id, Number_of_sits) values (29, 3);
insert into Tables (Table_id, Number_of_sits) values (30, 14);
insert into Tables (Table_id, Number_of_sits) values (31, 4);
insert into Tables (Table_id, Number_of_sits) values (32, 4);
insert into Tables (Table_id, Number_of_sits) values (33, 8);
insert into Tables (Table_id, Number_of_sits) values (34, 6);
insert into Tables (Table_id, Number_of_sits) values (35, 5);
insert into Tables (Table_id, Number_of_sits) values (36, 12);
insert into Tables (Table_id, Number_of_sits) values (37, 5);
insert into Tables (Table_id, Number_of_sits) values (38, 6);
insert into Tables (Table_id, Number_of_sits) values (39, 6);
insert into Tables (Table_id, Number_of_sits) values (40, 8);



--Inserting to Reservations
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (1, 200, '2022-04-22 19:24', 7, 26);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (2, 55, '2021-08-03 15:33', 8, 33);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (3, 172, '2021-03-09 14:01', 2, 26);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (4, 233, '2022-03-16 06:32:54', 7, 5);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (5, 97, '2020-11-20 18:39:47', 8, 15);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (6, 235, '2021-11-20 21:12:24', 5, 16);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (7, 75, '2022-06-03 10:22:06', 8, 40);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (8, 261, '2020-12-06 03:31:59', 15, 27);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (9, 47, '2021-05-27 07:29:21', 14, 10);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (10, 236, '2022-01-13 09:10:32', 10, 29);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (11, 150, '2022-06-04 14:21:23', 2, 40);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (12, 257, '2021-11-22 19:44:27', 8, 30);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (13, 23, '2022-09-05 22:22:26', 5, 23);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (14, 249, '2021-06-23 02:44:30', 6, 37);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (15, 105, '2021-10-23 18:31:55', 6, 28);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (16, 219, '2021-02-19 16:19:06', 10, 23);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (17, 298, '2022-04-07 22:40:41', 1, 36);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (18, 64, '2021-12-21 21:43:20', 7, 16);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (19, 97, '2020-12-05 05:34:42', 7, 24);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (20, 279, '2021-09-02 21:39:46', 6, 17);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (21, 271, '2022-04-30 09:26:55', 8, 18);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (22, 11, '2020-12-21 03:22:10', 9, 26);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (23, 2, '2021-01-03 01:34:56', 4, 26);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (24, 34, '2022-01-10 00:30:29', 7, 11);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (25, 168, '2021-07-25 05:16:39', 20, 7);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (26, 133, '2020-10-04 02:22:53', 7, 40);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (27, 71, '2021-06-13 11:15:23', 11, 25);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (28, 142, '2021-01-19 03:35:52', 6, 37);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (29, 122, '2022-07-02 22:12:18', 2, 30);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (30, 139, '2022-09-04 14:40:05', 11, 32);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (31, 6, '2022-08-28 14:02:05', 7, 28);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (32, 150, '2021-02-05 11:17:05', 13, 18);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (33, 25, '2021-01-16 17:39:50', 14, 40);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (34, 262, '2021-02-27 05:36:58', 12, 25);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (35, 275, '2020-11-11 00:12:55', 7, 22);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (36, 232, '2022-09-16 06:24:19', 11, 40);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (37, 44, '2020-10-16 14:58:27', 3, 8);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (38, 11, '2022-08-12 06:59:31', 5, 27);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (39, 159, '2022-03-11 03:02:07', 8, 30);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (40, 262, '2022-07-03 03:10:46', 15, 23);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (41, 41, '2021-06-12 10:33:26', 20, 20);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (42, 126, '2021-03-17 17:44:41', 9, 4);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (43, 253, '2020-12-10 18:44:52', 5, 35);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (44, 156, '2021-09-21 09:02:02', 5, 5);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (45, 63, '2021-12-22 03:38:58', 7, 15);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (46, 104, '2021-11-27 07:02:10', 8, 35);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (47, 270, '2021-09-18 18:51:28', 6, 20);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (48, 191, '2022-09-07 15:23:27', 8, 5);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (49, 167, '2021-07-16 19:18:54', 5, 33);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (50, 136, '2021-06-07 14:38:56', 7, 19);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (51, 218, '2020-11-09 21:46:59', 7, 6);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (52, 253, '2021-01-18 19:48:49', 12, 18);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (53, 51, '2021-04-21 21:21:28', 16, 32);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (54, 196, '2021-11-22 04:15:36', 7, 33);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (55, 204, '2020-10-30 07:19:30', 7, 6);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (56, 212, '2021-04-22 15:29:22', 10, 9);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (57, 255, '2020-11-09 03:27:51', 12, 39);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (58, 298, '2020-11-19 21:53:52', 11, 34);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (59, 223, '2021-09-01 05:42:11', 17, 17);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (60, 246, '2022-04-25 00:24:27', 7, 8);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (61, 106, '2021-09-03 07:58:57', 12, 4);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (62, 43, '2020-10-24 23:53:58', 3, 11);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (63, 94, '2022-01-29 08:10:05', 9, 3);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (64, 230, '2021-10-02 04:36:15', 20, 23);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (65, 97, '2020-10-09 18:09:53', 10, 24);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (66, 103, '2022-03-21 07:13:57', 14, 1);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (67, 180, '2022-09-06 03:49:04', 7, 16);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (68, 164, '2021-02-23 12:10:06', 2, 7);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (69, 59, '2020-10-25 19:05:26', 10, 25);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (70, 289, '2021-06-28 20:18:37', 6, 8);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (71, 4, '2020-10-27 00:44:44', 16, 35);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (72, 220, '2022-04-25 22:04:43', 9, 11);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (73, 42, '2020-11-02 17:33:25', 18, 4);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (74, 245, '2022-03-13 19:33:05', 16, 19);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (75, 205, '2020-11-26 16:00:02', 8, 2);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (76, 40, '2021-04-13 14:05:10', 11, 14);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (77, 240, '2022-09-05 11:21:48', 2, 7);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (78, 273, '2022-03-30 23:39:55', 11, 20);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (79, 68, '2022-04-07 06:07:11', 9, 7);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (80, 236, '2021-09-28 00:13:52', 5, 40);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (81, 28, '2022-03-03 23:34:22', 2, 5);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (82, 295, '2021-04-26 03:51:36', 9, 30);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (83, 161, '2021-11-17 14:53:38', 9, 15);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (84, 72, '2021-03-11 01:52:16', 18, 11);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (85, 147, '2021-03-25 16:17:52', 2, 5);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (86, 159, '2020-11-03 09:55:48', 11, 25);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (87, 84, '2021-11-16 15:21:11', 16, 9);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (88, 139, '2022-06-28 18:30:01', 16, 4);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (89, 123, '2021-11-06 08:02:31', 17, 27);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (90, 156, '2022-04-29 07:28:16', 1, 24);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (91, 137, '2021-06-17 11:16:29', 4, 12);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (92, 4, '2021-01-21 14:44:08', 5, 3);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (93, 240, '2022-07-09 15:27:38', 8, 13);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (94, 277, '2022-05-12 05:55:53', 9, 4);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (95, 284, '2021-06-07 00:59:04', 6, 9);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (96, 48, '2021-08-03 08:35:21', 10, 8);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (97, 137, '2020-12-31 13:08:38', 5, 39);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (98, 40, '2021-04-25 01:39:17', 3, 24);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (99, 148, '2021-02-15 03:36:58', 8, 34);
insert into Reservations (Reservation_id, Customer_id, Date_time, Party_size, Table_id) values (100, 15, '2021-01-12 10:58:42', 3, 8);

--Inserting to shifts
insert into Shifts (Employee_id, Clock_in, Clock_out) values (12, '2022-01-07 19:53:09', '2022-05-24 04:12:27');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (16, '2022-04-16 11:51:46', '2022-01-19 23:23:37');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (16, '2022-08-05 14:25:34', '2022-07-21 07:03:58');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (3, '2022-09-08 06:55:32', '2022-05-09 12:51:48');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (14, '2021-10-02 03:42:34', '2022-01-21 08:11:47');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (14, '2022-08-26 06:53:06', '2022-08-04 16:53:07');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (17, '2022-02-24 15:47:07', '2022-03-12 22:28:02');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (15, '2022-06-06 10:26:21', '2022-08-05 03:32:30');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (9, '2022-03-16 07:44:54', '2022-05-10 07:31:28');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (18, '2022-06-10 16:25:03', '2022-09-11 10:17:39');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (1, '2022-04-07 18:17:18', '2022-08-30 00:20:43');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (13, '2022-06-25 00:07:24', '2022-03-01 21:35:19');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (14, '2022-01-19 10:24:14', '2022-06-29 21:11:38');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (9, '2022-02-25 13:15:18', '2022-04-05 21:56:25');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (15, '2021-11-30 05:02:47', '2022-05-12 17:28:02');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (15, '2022-09-06 22:21:56', '2022-02-26 17:14:50');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (19, '2022-01-20 07:01:40', '2022-07-13 12:31:53');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (1, '2021-10-05 10:38:49', '2022-08-23 20:24:42');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (18, '2022-09-29 10:23:45', '2022-07-10 00:48:51');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (6, '2022-04-22 14:29:20', '2022-09-25 10:57:03');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (4, '2022-05-21 00:06:40', '2022-04-13 22:23:45');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (17, '2022-01-05 04:39:46', '2022-08-07 00:45:44');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (11, '2022-02-04 17:11:36', '2022-05-02 07:56:39');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (1, '2022-04-06 20:52:26', '2021-11-23 23:57:14');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (3, '2022-04-24 22:31:49', '2022-09-06 10:10:10');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (12, '2022-08-13 22:47:01', '2022-03-10 22:28:40');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (9, '2021-12-19 21:10:15', '2022-01-27 04:49:05');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (11, '2022-04-11 18:59:28', '2022-09-05 19:37:21');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (2, '2022-08-02 20:00:25', '2022-02-08 01:49:50');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (4, '2022-02-06 17:20:05', '2022-07-29 10:41:05');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (4, '2022-02-21 02:53:20', '2022-05-23 16:04:19');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (18, '2022-09-25 13:19:18', '2022-05-28 23:41:49');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (20, '2022-08-24 12:00:22', '2022-07-11 00:06:24');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (19, '2021-10-18 14:01:48', '2022-08-16 11:12:08');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (20, '2021-12-21 03:51:29', '2021-12-27 15:53:22');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (19, '2021-10-19 06:11:03', '2022-08-28 10:58:08');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (11, '2022-08-12 02:57:15', '2021-10-21 15:57:08');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (6, '2022-02-22 22:21:36', '2022-01-25 05:18:57');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (6, '2022-09-08 20:47:37', '2022-07-29 11:53:01');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (5, '2021-10-09 16:30:42', '2021-11-27 18:38:22');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (4, '2022-06-22 02:43:27', '2022-07-02 03:52:39');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (4, '2022-08-25 01:02:45', '2022-04-15 19:02:32');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (11, '2022-01-09 18:42:24', '2022-06-10 18:17:19');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (11, '2022-01-06 11:13:45', '2022-01-10 05:53:41');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (10, '2022-03-13 19:13:34', '2022-09-03 01:18:14');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (6, '2022-04-30 09:03:33', '2022-03-18 04:05:01');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (11, '2022-01-06 13:48:34', '2022-07-22 21:58:06');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (10, '2022-02-27 12:13:18', '2021-12-06 15:32:36');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (10, '2022-08-30 11:14:33', '2021-12-21 02:31:41');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (12, '2022-08-14 00:39:36', '2022-05-04 11:49:19');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (16, '2022-04-19 11:09:28', '2022-01-25 04:27:33');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (18, '2022-02-11 08:41:03', '2022-07-22 22:43:05');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (10, '2022-04-07 00:55:35', '2022-05-30 05:41:58');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (2, '2021-12-03 01:04:49', '2022-07-19 23:28:29');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (18, '2022-03-11 13:51:14', '2022-07-28 10:56:55');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (7, '2022-02-20 17:15:47', '2022-01-28 19:35:45');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (19, '2022-01-02 01:55:28', '2021-11-09 11:18:33');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (9, '2022-07-18 07:52:17', '2021-10-10 09:32:06');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (11, '2022-04-17 05:15:47', '2022-06-27 17:48:13');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (14, '2021-11-20 11:10:39', '2021-12-20 08:00:38');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (20, '2022-05-07 13:39:28', '2022-06-15 15:42:21');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (12, '2022-06-30 07:37:58', '2021-11-25 14:14:18');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (10, '2021-12-18 14:21:37', '2022-09-24 00:31:34');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (4, '2022-01-16 21:38:47', '2022-05-21 15:55:10');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (15, '2022-02-15 09:20:36', '2022-06-10 21:12:00');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (7, '2021-11-01 21:42:05', '2022-04-18 17:07:19');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (15, '2021-10-21 14:52:35', '2022-02-27 19:41:50');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (6, '2022-03-09 02:23:55', '2022-04-13 11:48:30');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (15, '2021-12-07 21:57:32', '2022-05-06 06:39:13');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (10, '2022-05-09 15:56:34', '2021-12-01 12:12:26');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (16, '2021-11-11 11:14:10', '2022-10-01 07:54:11');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (20, '2022-04-14 23:53:30', '2022-03-14 12:35:46');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (2, '2022-01-17 01:03:27', '2022-02-27 17:42:05');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (16, '2022-04-12 07:02:39', '2022-01-04 19:07:29');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (8, '2022-02-27 23:35:40', '2022-03-09 10:19:58');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (11, '2021-12-21 01:42:43', '2022-02-27 03:03:21');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (3, '2021-12-26 21:48:21', '2022-08-21 22:46:58');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (11, '2022-06-17 02:45:09', '2022-01-27 10:33:39');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (1, '2022-06-17 20:49:30', '2022-09-22 22:54:58');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (13, '2022-06-19 21:45:06', '2022-08-20 23:01:35');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (5, '2022-05-25 15:52:45', '2021-10-10 17:34:17');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (7, '2022-03-01 01:31:21', '2022-06-10 11:00:21');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (4, '2022-08-01 14:03:19', '2022-03-31 09:47:40');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (13, '2022-09-03 15:00:53', '2022-02-23 21:10:54');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (1, '2021-10-08 18:48:16', '2022-06-30 05:16:26');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (2, '2022-07-03 15:04:35', '2022-01-09 07:01:03');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (11, '2022-04-24 05:04:13', '2022-04-16 07:18:10');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (15, '2021-12-07 14:06:11', '2021-11-21 12:20:20');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (14, '2022-02-14 00:50:54', '2021-12-30 04:11:20');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (3, '2022-05-29 14:39:38', '2022-06-17 19:21:34');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (16, '2021-11-11 23:16:15', '2022-08-20 23:42:37');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (19, '2021-12-01 17:53:35', '2022-06-15 13:18:51');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (11, '2022-01-23 21:25:21', '2022-02-28 03:18:32');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (20, '2022-05-07 15:57:40', '2022-09-09 23:21:54');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (1, '2021-12-06 21:33:17', '2022-08-03 04:18:59');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (14, '2022-01-21 01:51:18', '2022-07-08 21:49:56');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (14, '2022-09-06 00:00:33', '2022-04-12 09:26:11');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (15, '2021-10-13 15:53:43', '2022-06-08 18:47:29');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (10, '2022-08-23 23:40:51', '2021-10-25 22:58:32');
insert into Shifts (Employee_id, Clock_in, Clock_out) values (20, '2022-03-17 00:14:45', '2022-05-22 18:01:00');



--inserting into tips

insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (15, 17, 36, 135);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (40, 16, null, 8);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (3, 6, 109, 197);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (17, 1, 274, 89);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (16, 9, null, 75);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (7, 2, 266, 128);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (17, 6, 163, 116);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (20, 9, 11, 57);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (33, 9, 146, 157);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (10, 13, null, 145);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (4, 19, null, 100);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (18, 16, 225, 66);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (25, null, 234, 11);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (21, 4, 108, 67);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (15, 10, 36, 32);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (19, 13, null, 6);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (21, 20, 293, 58);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (10, 12, 280, 199);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (13, 18, 222, 50);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (12, 4, 87, 42);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (39, 18, 155, 75);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (24, 11, 70, 114);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (25, 10, 171, 48);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (1, 16, 278, 137);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (20, 5, 234, 136);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (3, 14, 73, 186);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (33, 16, 254, 75);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (32, 15, 229, 197);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (27, 1, 243, 184);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (36, 6, 3, 149);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (19, 9, 91, 162);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (23, 2, 198, 148);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (16, 7, 142, 80);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (22, 10, 204, 20);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (26, 4, 176, 73);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (14, 19, 173, 30);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (22, 19, 137, 61);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (26, 3, 257, 105);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (38, 16, 67, 142);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (36, 12, 161, 151);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (23, 15, 183, 146);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (29, 20, 115, 19);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (10, 20, 237, 94);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (4, 16, 184, 100);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (10, 9, 194, 5);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (31, 9, 245, 48);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (1, 9, 225, 0);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (19, 5, 130, 172);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (31, 5, 171, 162);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (18, 19, 142, 28);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (29, 13, 70, 35);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (2, 17, 193, 18);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (9, 3, 95, 138);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (22, 7, 20, 143);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (15, 18, null, 109);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (30, null, 234, 194);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (24, 4, 214, 115);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (34, 9, 164, 81);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (36, 6, 189, 38);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (36, 15, 62, 46);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (17, 10, 119, 38);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (22, 20, null, 75);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (5, 18, 58, 76);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (17, 16, 180, 184);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (26, 4, 75, 10);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (8, 13, 221, 0);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (21, 1, 225, 193);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (26, 14, 144, 174);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (27, 15, 14, 176);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (29, 16, null, 94);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (38, 12, 147, 2);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (40, 8, 78, 181);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (10, 2, 268, 200);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (34, 16, 50, 106);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (3, 2, 82, 46);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (3, 5, 78, 8);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (4, null, 264, 94);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (16, 19, 45, 27);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (3, 14, 282, 164);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (38, 10, 99, 132);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (22, 8, 189, 130);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (30, 3, 244, 91);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (1, 4, 114, 196);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (8, 2, 3, 189);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (14, 6, 88, 189);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (22, 9, 9, 128);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (10, 6, 261, 60);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (30, 13, 236, 95);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (13, 18, 92, 160);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (19, 7, 165, 93);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (16, 17, 293, 128);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (40, 5, null, 170);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (12, 14, null, 152);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (38, 11, 140, 159);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (24, 12, 220, 129);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (22, 1, 21, 151);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (26, 18, 188, 91);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (31, 11, 114, 171);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (7, 10, 58, 66);
insert into Tips (Table_id, Employee_id, Customer_id, Tip_amount) values (25, 9, 2, 41);
