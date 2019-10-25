--=== Opdracht 1F ===--
USE FLETNIX

/*MAAK ALLES LEEG*/
DELETE FROM Watchhistory; 
DELETE FROM Movie_Genre;
DELETE FROM Movie_Directors;
DELETE FROM Movie_Cast;
DELETE FROM Movie;
DELETE FROM Customer;
DELETE FROM Person;
DELETE FROM Payment;
DELETE FROM Genre;
DELETE FROM Country;
DELETE FROM [Contract];

INSERT INTO [Contract]
VALUES('Basic',		4,	0),
	  ('Premium',	5,	20),
	  ('Pro',		6,	40)

INSERT INTO Country
VALUES('The Netherlands'),
	  ('Belgium'),
	  ('France'),
	  ('Germany'),
	  ('Ireland'),
	  ('China'),
	  ('Japan')

INSERT INTO Genre
VALUES('Action',	'Creative works characterized by emphasis on exciting action sequences.'),
	  ('Drama',		'Fictional division between comedy and tragedy.'),
	  ('Family',	'Movies suitable for a wide range of age groups.'),
	  ('Sci-Fi',	'Fictional movies dealing with imaginative content such as futuristic settings, futuristic science and technology, space travel, time travel, parallel universes, and extraterrestrial life.'),
	  ('Fantasy',	'Fantasy is a genre of fiction set in a fictional universe, often, but not always, without any locations, events, or people referencing the real world.')

INSERT INTO Payment
VALUES('Mastercard'),
	  ('Visa'),
	  ('Amex'),
	  ('Ideal'),
	  ('PayPal'),
	  ('V PAY')

INSERT INTO Person
VALUES(83616,	'Wachowski',	'Andy',			'M'),
	  (83617,	'Wachowski',	'Larry',		'M'),
	  (393411,	'Reeves',		'Keanu',		'M'),
	  (729933,	'Moss',			'Carrie-Anne',	'F'),
	  (151786,	'Fishburne',	'Laurence',		'M'),

	  (100000,	'Lucas',		'George',		'M'),
	  (100001,	'Kershner',		'Irvin',		'M'),
	  (100002,	'Marquand',		'Richard',		'M'),

	  (110000,	'Hamill',		'Mark',			'M'),
	  (110001,	'Fisher',		'Carrie',		'F'),
	  (110002,	'Ford',			'Harrison',		'M')
	  
INSERT INTO Customer
VALUES('peter@pan.de',				'Pan',			'Peter',	'Mastercard',	'0123456789',	'Basic',	'01-oct-2014',	'28-oct-2014',	'pp123',			'peterpass',	'The Netherlands',	'M',	'28-jun-1971'),
	  ('guy@monk.nl',				'Threepwood',	'Guybrush',	'Visa',			'333-555-777',	'Premium',	'01-jan-2014',	NULL,			'gm4ever',			'guypass',		'Belgium',			'M',	'03-mar-1972'),
	  ('llama@llamaland.com',		'Frey',			'James',	'Ideal',		'4830087',		'Basic',	'01-nov-2015',	'01-apr-2016',	'BigLlama',			'lamapass',		'The Netherlands',	'M',	'04-apr-1998'),
	  ('freek@vonk.nl',				'Vonk',			'Freek',	'PayPal',		'6720910',		'Pro',		'01-jan-2015',	NULL,			'FreekVonk',		'Dieren',		'The Netherlands',	'M',	'24-feb-1983'),
	  ('andre@lon.nl',				'Lon',			'Andre',	'V PAY',		'8057749',		'Premium',	'11-apr-2013',	NULL,			'AndreLon',			'Andrepass',	'The Netherlands',	'M',	'11-sep-2002'),
	  ('ton@deuze.net',				'Deuze',		'Ton',		'Mastercard',	'2135561',		'Basic',	'01-apr-2016',	'01-dec-2017',	'TonDeuze',			'Tonpass',		'China',			'M',	'01-jan-1993'),
	  ('alan@walker.com',			'Walker',		'Alan',		'PayPal',		'6990407',		'Pro',		'12-nov-2015',	NULL,			'AlanWalker',		'Alanpass',		'Japan',			'M',	'24-aug-1997'),
	  ('keecar@diaperstack.com',	'Caruso',		'Keeley',	'Amex',			'2461623',		'Basic',	'14-feb-2014',	'14-mar-2014',	'keelcaruso43',		'Epalos',		'Japan',			'M',	'27-sep-1943'),
	  ('james@gmail.com',			'Philips',		'James',	'Visa',			'5124666',		'Pro',		'26-dec-2013',	NULL,			'Jamey',			'Jamepass',		'France',			'M',	'30-jul-1963'),
	  ('pinkandfluffy@hotmail.com', 'Davids',		'Jane',		'PayPal',		'8298223',		'Premium',	'14-jun-2014',	NULL,			'Pinkandfluffy',	'fluffers',		'Germany',			'F',	'10-apr-1989')

INSERT INTO Movie
VALUES(11,	'Matrix, The',						122,	'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.',																											1999,		NULL,		NULL,		2.50,		'https://www.youtube.com/watch?v=0Z1=M8O70zk'),
	  (12,	'Matrix Reloaded, The',				106,	'Neo and the rebel leaders estimate that they have 72 hours until 250,000 probes discover Zion and destroy it and its inhabitants. During this, Neo must decide how he can save Trinity from a dark fate in his dreams.',							2003,		NULL,		11,			2.50,		'https://www.youtube.com/watch?v=HVrGMnk5E_M'),
	  (13,	'Matrix Revolutions, The',			103,	'The human city of Zion defends itself against the massive invasion of the machines as Neo fights to end the war at another front while also opposing the rogue Agent Smith.',																		2003,		NULL,		12,			2.50,		'https://www.youtube.com/watch?v=NhoaoTZJSX4'),
	  (14,	'Star Wars',						121,	'Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a Wookiee, and two droids to save the galaxy from the Empire''s world-destroying battle-station, while also attempting to rescue Princess Leia from the evil Darth Vader.',			1977,		NULL,		NULL,		1.25,		'https://www.youtube.com/watch?v=9gvqpFbRKtQ'),
	  (15,	'The Empire Strikes Back',			124,	'After the rebels are overpowered by the Empire on their newly established base, Luke Skywalker begins Jedi training with Yoda. His friends accept shelter from a questionable ally as Darth Vader hunts them in a plan to capture Luke.',			1980,		NULL,		14,			1.50,		'https://www.youtube.com/watch?v=PkEKIw0FU6Y'),
	  (16,	'Return of the Jedi',				132,	'After a daring mission to rescue Han Solo from Jabba the Hutt, the rebels dispatch to Endor to destroy a more powerful Death Star. Meanwhile, Luke struggles to help Vader back from the dark side without falling into the Emperor''s trap.',		1983,		NULL,		15,			1.75,		'https://www.youtube.com/watch?v=5UfA_aKBGMc'),
	  (17,	'Star Wars: The Clone Wars',		98, 	'After the Republic''s victory on Christophsis, Anakin and his new apprentice Ahsoka Tano must rescue the kidnapped son of Jabba the Hutt. Political intrigue complicates their mission.',															2008,		NULL,		16,			2.00,		'https://www.youtube.com/watch?v=yA14TnyCkgE'),
	  (18,	'Star Wars: The Force Awakens',		135,	'Three decades after the Empire''s defeat, a new threat arises in the militant First Order. Stormtrooper defector Finn and spare parts scavenger Rey are caught up in the Resistance''s search for the missing Luke Skywalker.',					2015,		NULL,		17,			2.50,		'https://www.youtube.com/watch?v=sGbxmsDFVnE')

INSERT INTO Movie_Cast
VALUES(11,	393411,	'Neo'),
	  (11,	729933,	'Trinity'),
	  (11,	151786,	'Morpheus'),
	  (12,	393411,	'Neo'),
	  (12,	729933,	'Trinity'),
	  (12,	151786,	'Morpheus'),
	  (13,	393411,	'Neo'),
	  (13,	729933,	'Trinity'),
	  (13,	151786,	'Morpheus'),

	  (14, 110000,	'Luke Skywalker'),
	  (14, 110001,	'Leia Organa'),
	  (14, 110002,	'Han Solo'),
	  (15, 110000,	'Luke Skywalker'),
	  (15, 110001,	'Leia Organa'),
	  (15, 110002,	'Han Solo'),
	  (16, 110000,	'Luke Skywalker'),
	  (16, 110001,	'Leia Organa'),
  	  (16, 110002,	'Han Solo')

INSERT INTO Movie_Directors
VALUES(11, 83616),
	  (11, 83617),
	  (12, 83616),
	  (12, 83617),
		
	  (14, 100000),
	  (15, 100001),
	  (16, 100002)

INSERT INTO Movie_Genre
VALUES(11,	'Action'),
	  (11,	'Sci-Fi'),
	  (12,	'Action'),
	  (12,	'Sci-Fi'),
	  (13,	'Action'),
	  (13,	'Sci-Fi'),

	  (14,	'Sci-Fi'),
	  (14,	'Fantasy'),
	  (14,	'Action'),
	  (15,	'Sci-Fi'),
	  (15,	'Fantasy'),
	  (15,	'Action'),
	  (16,	'Sci-Fi'),
	  (16,	'Fantasy'),
	  (16,	'Action'),
	  (17,	'Sci-Fi'),
	  (18,	'Sci-Fi'),
	  (18,	'Fantasy'),
	  (18,	'Action')

INSERT INTO Watchhistory
VALUES(11,	'peter@pan.de',					'01-oct-2014',		2.50,	1),
	  (11,	'peter@pan.de',					'02-oct-2014',		2.50,	0),
	  (13,	'peter@pan.de',					'07-oct-2014',		2.50,	0),
	  (15,	'peter@pan.de',					'13-oct-2014',		1.50,	1),
	  ---
	  (12,	'guy@monk.nl',					'20-mar-2014',		2.50,	0),
	  (14,	'guy@monk.nl',					'23-mar-2014',		1.25,	0),
	  (18,	'guy@monk.nl',					'28-mar-2014',		2.50,	1),
	  (11,	'guy@monk.nl',					'02-apr-2014',		2.50,	1),
	  ---
	  (11,	'llama@llamaland.com',			'03-dec-2015',		2.50,	1),
	  (17,	'llama@llamaland.com',			'07-dec-2015',		2.00,	0),
	  (12,	'llama@llamaland.com',			'08-dec-2015',		2.50,	1),
	  (13,	'llama@llamaland.com',			'12-dec-2015',		2.50,	1),
	  ---
	  (11,	'freek@vonk.nl',				'27-jan-2015',		2.50,	0),
	  (14,	'freek@vonk.nl',				'29-jan-2015',		1.25,	1),
	  (17,	'freek@vonk.nl',				'30-jan-2015',		2.00,	1),
	  (18,	'freek@vonk.nl',				'03-feb-2015',		2.50,	0),
	  ---
	  (11,	'andre@lon.nl',					'15-jul-2014',		2.50,	1),
	  (16,	'andre@lon.nl',					'20-jul-2014',		1.75,	0),
	  (18,	'andre@lon.nl',					'20-jul-2014',		2.50,	1),
	  (12,	'andre@lon.nl',					'27-jul-2014',		2.50,	1),
	  ---
	  (11,	'ton@deuze.net',				'11-nov-2017',		2.50,	0),
	  (15,	'ton@deuze.net',				'15-nov-2017',		1.50,	0),
	  (14,	'ton@deuze.net',				'16-nov-2017',		1.25,	0),
	  (15,	'ton@deuze.net',				'24-nov-2017',		1.50,	0),
	  ---
	  (11,	'alan@walker.com',				'07-dec-2015',		2.50,	1),
	  (17,	'alan@walker.com',				'12-dec-2015',		2.00,	0),
	  (14,	'alan@walker.com',				'19-dec-2015',		1.25,	1),
	  (12,	'alan@walker.com',				'19-dec-2015',		2.50,	1),
	  ---
	  (11,	'keecar@diaperstack.com',		'15-feb-2014',		2.50,	1),
	  (15,	'keecar@diaperstack.com',		'18-feb-2014',		1.50,	0),
	  (11,	'keecar@diaperstack.com',		'23-feb-2014',		2.50,	1),
	  (18,	'keecar@diaperstack.com',		'27-feb-2014',		2.50,	0),
	  ---
	  (11,	'james@gmail.com',				'27-dec-2013',		2.50,	1),
	  (14,	'james@gmail.com',				'28-dec-2013',		1.25,	0),
	  (13,	'james@gmail.com',				'09-jan-2014',		2.50,	0),
	  (16,	'james@gmail.com',				'09-jan-2014',		1.75,	0),
	  ---
	  (11,	'pinkandfluffy@hotmail.com',	'15-jun-2014',		2.50,	0),
	  (17,	'pinkandfluffy@hotmail.com',	'17-jun-2014',		2.00,	1),
	  (18,	'pinkandfluffy@hotmail.com',	'20-jun-2014',		2.50,	1),
	  (12,	'pinkandfluffy@hotmail.com',	'22-jun-2014',		2.50,	1)

/*TER CONTROLE ALLE RESULTATEN WEERGEVEN*/
SELECT * FROM [Contract]
SELECT * FROM Country
SELECT * FROM Genre
SELECT * FROM Payment
SELECT * FROM Person
SELECT * FROM Customer
SELECT * FROM Movie
SELECT * FROM Movie_Cast
SELECT * FROM Movie_Directors
SELECT * FROM Movie_Genre
SELECT * FROM Watchhistory