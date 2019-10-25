USE FLETNIX_DOCENT

-- B: Implementeer het model (dus het aangepast 3NV model) in SQL Server door het maken van een DDL script. 
--=== DDL ===--

IF OBJECT_ID('Awards_per_Year') IS NOT NULL
DROP TABLE Awards_per_Year
IF OBJECT_ID('Description') IS NOT NULL
DROP TABLE [Description]
IF OBJECT_ID('Awardshow') IS NOT NULL
DROP TABLE Awardshow

CREATE TABLE Awardshow (
	award		VARCHAR(50)		NOT NULL,
	[year]		INTEGER			NOT NULL,
	country		VARCHAR(50)		NOT NULL,
	CONSTRAINT pk_Awardshow PRIMARY KEY (award, [year])
)

CREATE TABLE [Description] (
	code			VARCHAR(5)		NOT NULL,
	[description]	VARCHAR(20)		NOT NULL,
	CONSTRAINT pk_Description PRIMARY KEY (code),
	CONSTRAINT ak_Description UNIQUE ([description])
)

CREATE TABLE Awards_per_Year (
	award		VARCHAR(50)		NOT NULL,
	[year]		INTEGER			NOT NULL,
	category	VARCHAR(50)		NOT NULL,
	movie_id	INTEGER			NOT NULL,
	person_id	INTEGER			NOT NULL,
	code		VARCHAR(5)		NOT NULL,
	CONSTRAINT pk_Awards_per_Year PRIMARY KEY (award, [year], category, movie_id, person_id),
	CONSTRAINT fk_Awards_per_Year_Awardshow FOREIGN KEY (award, [year]) REFERENCES Awardshow(award, [year])
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT fk_Awards_per_Year_Person FOREIGN KEY (person_id) REFERENCES Person(person_id)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT fk_Awards_per_Year_Movie FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT fk_Awards_per_Year_Description FOREIGN KEY (code) REFERENCES [Description](code)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
)

-- C: Populeer de nieuwe database met de ontbrekende data, conform deze twee overzichten
--=== INSERT ===--
DELETE FROM Person WHERE person_id >= 950001 AND person_id <= 950016
DELETE FROM Awardshow;
DELETE FROM [Description];
DELETE FROM Awards_per_Year;

INSERT INTO Person(firstname, lastname, person_id)
VALUES	('Paul',		'Rubell',		950001),
		('Richard',		'Hymns',		950002),
		('Dane',		'Davis',		950003),
		('John',		'Gaeta',		950004),
		('Steve',		'Courtley',		950005),
		('Jon',			'Thum',			950006),
		('David',		'Lee',			950007),
		('John',		'Reitz',		950008),
		('Gregg',		'Rudloff',		950009),
		('David',		'Campbell',		950010),
		('Tom',			'Bellfort',		950012),
		('Bob',			'Beemer',		950013),
		('Bill',		'Pope',			950014),
		('Conrad',		'Hall',			950015),
		('Tariq',		'Anwar',		950016)

INSERT INTO Awardshow
VALUES	('Academy Awards', 2000, 'Netherlands'),
		('BAFTA Awards', 2000, 'New Zealand')

INSERT INTO [Description]
VALUES	('W', 'Won'),
		('N', 'Nominated')

INSERT INTO Awards_per_Year									      /*Movie*/	  /*Person*/
VALUES	('Academy Awards',	2000,	'Best Film Editing',			207992,		550813,		'W'),
		('Academy Awards',	2000,	'Best Film Editing',			160492,		276884,		'N'),
		('Academy Awards',	2000,	'Best Film Editing',			160492,		950001,		'N'),
		('Academy Awards',	2000,	'Best Film Editing',			160492,		68042,		'N'),
		('Academy Awards',	2000,	'Best Film Editing',			303564,		54796,		'N'),

		('Academy Awards',	2000,	'Best Sound Effects Editing',	112290,		351397,		'N'),
		('Academy Awards',	2000,	'Best Sound Effects Editing',	112290,		950002,		'N'),
		('Academy Awards',	2000,	'Best Sound Effects Editing',	207992,		950003,		'W'),
		('Academy Awards',	2000,	'Best Sound Effects Editing',	313474,		165453,		'N'),

		('Academy Awards',	2000,	'Best Visual Effects',			313474,		351981,		'N'),
		('Academy Awards',	2000,	'Best Visual Effects',			313474,		191712,		'N'),
		('Academy Awards',	2000,	'Best Visual Effects',			207992,		950004,		'W'),
		('Academy Awards',	2000,	'Best Visual Effects',			207992,		540853,		'W'),
		('Academy Awards',	2000,	'Best Visual Effects',			207992,		950005,		'W'),
		('Academy Awards',	2000,	'Best Visual Effects',			207992,		950006,		'W'),

		('BAFTA Awards',	2000,	'Best Sound',					207992,		950007,		'W'),
		('BAFTA Awards',	2000,	'Best Sound',					207992,		950008,		'W'),
		('BAFTA Awards',	2000,	'Best Sound',					207992,		950009,		'W'),
		('BAFTA Awards',	2000,	'Best Sound',					207992,		950010,		'W'),
		('BAFTA Awards',	2000,	'Best Sound',					207992,		950003,		'W'),
		('BAFTA Awards',	2000,	'Best Sound',					313474,		165453,		'N'),
		('BAFTA Awards',	2000,	'Best Sound',					313474,		950012,		'N'),
		('BAFTA Awards',	2000,	'Best Sound',					13789,		950013,		'N'),

		('BAFTA Awards',	2000,	'Best Cinematography',			207992,		950014,		'N'),
		('BAFTA Awards',	2000,	'Best Cinematography',			13789,		950015,		'W'),

		('BAFTA Awards',	2000,	'Best Production Design',		207992,		464716,		'N'),
		('BAFTA Awards',	2000,	'Best Production Design',		304862,		303143,		'W'),

		('BAFTA Awards',	2000,	'Best Editing',					207992,		550813,		'N'),
		('BAFTA Awards',	2000,	'Best Editing',					13789,		950016,		'W'),
		('BAFTA Awards',	2000,	'Best Editing',					13789,		283753,		'W')

/*TER CONTROLE ALLE RESULTATEN WEERGEVEN*/
SELECT * FROM Awards_per_Year
SELECT * FROM Awardshow
SELECT * FROM [Description]