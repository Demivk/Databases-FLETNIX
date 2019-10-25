--=== Opdracht 1E ===--
USE FLETNIX

-- Gender mag alleen M of F zijn --
DELETE FROM Person;

/* Positief */
INSERT INTO Person
VALUES(83616, 'Wachowski', 'Andy', 'M')

/* Negatief */
INSERT INTO Person
VALUES (45789, 'Wachowski', 'Andy', 'T')

PRINT('----------')

-- Publication_year moet tussen 1890 en de huidige datum liggen --
DELETE FROM Watchhistory;
DELETE FROM Movie;

/* Positief */
INSERT INTO Movie
VALUES (20,	'The Movie',	120,	'A movie about movies',			2015,		NULL,		NULL,		2.50,		'https://www.youtube.com/watch?v=0Z1=M8O70zk')

/* Negatief */
INSERT INTO Movie
VALUES (21,	'The Movie 2',	118,	'A movie about movies part 2',	2121,		NULL,		NULL,		2.50,		'https://www.youtube.com/watch?v=0Z1=M8O70zk')

PRINT('----------')

-- Subscription_start mag niet groter zijn dan subscription_end --
DELETE FROM Customer;

/* Positief */
INSERT INTO Customer
VALUES ('jane@davids.nl',	'Davids',	'Jane',		'Ideal',	'7891234',	'Basic',	'15-oct-2015',	'15-dec-2015',	'JaneDavids',		'password123',	'The Netherlands',	'F',	'15-jul-1970')

/* Negatief */
INSERT INTO Customer
VALUES ('jane@smith.nl',	'Smith',	'Jane',		'Ideal',	'7891234',	'Basic',	'15-oct-2015',	'15-aug-2015',	'JaneSmith',		'password123',	'The Netherlands',	'F',	'15-jul-1970')

PRINT('----------')

-- Unique username --
DELETE FROM Watchhistory
DELETE FROM Customer;

/* Positief */
INSERT INTO Customer
VALUES ('pinkandfluffy@hotmail.com', 'Davids',		'Jane',		'PayPal',		'8298223',		'Premium',	'14-jun-2014',	NULL,			'Pinkandfluffy',	'fluffers',		'Germany',			'F',	'10-apr-1989')

/* Negatief */
INSERT INTO Customer
VALUES ('jane@smith.nl',			 'Smith',		'Jane',		'Ideal',		'7891234',		'Basic',	'15-oct-2015',	'15-dec-2015',	'Pinkandfluffy',	'password123',	'The Netherlands',	'F',	'15-jul-1970')

PRINT('----------')

-- Watchdate ligt tussen sub.start en sub.end
DELETE FROM Watchhistory;

INSERT INTO Customer
VALUES('peter@pan.de',	'Pan',	'Peter',	'Mastercard',	'0123456789',	'Basic',	'01-oct-2014',	'28-oct-2014',	'pp123',	'peterpass',	'The Netherlands',	'M',	'28-jun-1971')

INSERT INTO Movie
VALUES(11,	'Matrix, The',	122,	'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.',	1999,		NULL,		NULL,		2.50,		'https://www.youtube.com/watch?v=0Z1=M8O70zk')

/* Positief */
INSERT INTO Watchhistory
VALUES	(11,	'peter@pan.de',		'01-oct-2014',		2.50,	1)

/* Negatief */
INSERT INTO Watchhistory
VALUES	(11,	'peter@pan.de',		'15-dec-2025',		2.50,	1)

PRINT('----------')

-- Minimale leeftijd van 12 jaar --
DELETE FROM Watchhistory;
DELETE FROM Customer;

/* Positief */
INSERT INTO Customer
VALUES ('jane@davids.nl',	'Davids',	'Jane',		'Ideal',	'7891234',	'Basic',	'15-oct-2015',	'15-dec-2015',	'JaneDavids',		'password123',	'The Netherlands',	'F',	'15-jul-1970')

/* Negatief */
INSERT INTO Customer
VALUES ('jane@smith.nl',	'Smith',	'Jane',		'Ideal',	'7891234',	'Basic',	'15-oct-2015',	'15-dec-2015',	'JaneSmith',		'password123',	'The Netherlands',	'F',	'15-jul-2008')

PRINT('----------')

-- Price moet groter zijn dan 0 --
DELETE FROM Movie

/* Positief */
INSERT INTO Movie
VALUES	(98,	'Maze Runner, The',	113,	'Thomas is deposited in a community of boys after his memory is erased, soon learning they''re all trapped in a maze that will require him to join forces with fellow ''runners'' for a shot at escape.',	2014,	NULL,	NULL,	2.50,	'https://www.youtube.com/watch?v=AwwbhhjQ9Xk')

/* Negatief */
INSERT INTO Movie
VALUES	(99,	'Maze Runner, The',	113,	'Thomas is deposited in a community of boys after his memory is erased, soon learning they''re all trapped in a maze that will require him to join forces with fellow ''runners'' for a shot at escape.',	2014,	NULL,	NULL,	0.00,	'https://www.youtube.com/watch?v=AwwbhhjQ9Xk')

PRINT('----------')

-- Er moet een valid email adres worden ingevoerd --
DELETE FROM Customer

/* Positief */
INSERT INTO Customer
VALUES	('jan@wit.com',	'Wit',	'Jan',	'Visa',	'9826915',	'Pro',	'11-apr-2016',	NULL,	'JanWit',		'janwit123',	'Belgium',	'M',	'16-feb-1984')

/* Negatief */
INSERT INTO Customer
VALUES	('janwitcom',	'Wit',	'Jan',	'Visa',	'9826915',	'Pro',	'11-apr-2016',	NULL,	'JantjeWit',	'janwit123',	'Belgium',	'M',	'16-feb-1984')
