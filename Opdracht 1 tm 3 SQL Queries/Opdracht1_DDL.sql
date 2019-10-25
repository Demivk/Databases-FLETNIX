--=== Opdracht 1A t/m 1D ===--
USE master
GO

-- Deleteing FLETNIX if it exists
IF DB_ID('FLETNIX') IS NOT NULL
BEGIN
	RAISERROR('Deleting database FLETNIX', 0, 1) WITH NOWAIT
	ALTER DATABASE FLETNIX SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE FLETNIX
END

-- Creating the database
RAISERROR('Creating database FLETNIX', 0, 1) WITH NOWAIT
CREATE DATABASE FLETNIX
GO

USE FLETNIX

IF OBJECT_ID ('CK_WatchdateTussenSubstartEnSubend') IS NOT NULL
DROP FUNCTION CK_WatchdateTussenSubstartEnSubend

GO
CREATE FUNCTION CK_WatchdateTussenSubstartEnSubend(@watch_date DATE)
RETURNS BIT
AS
BEGIN
RETURN	CASE WHEN EXISTS(
		SELECT *
		FROM Watchhistory W LEFT OUTER JOIN Customer C ON W.customer_mail_adress = C.customer_mail_adress
		WHERE W.watch_date = @watch_date AND
			  @watch_date >= C.subscription_start AND
			  (@watch_date <= C.subscription_end OR C.subscription_end IS NULL))
		THEN 1 --OK
		ELSE 0 --NOT OK
	END
END
GO

CREATE TABLE [Contract](
	contract_type			VARCHAR(10)			NOT NULL,
	price_per_month			NUMERIC(5,2)		NOT NULL,
	discount_percentage		NUMERIC(2)			NOT NULL,

	CONSTRAINT pk_contract PRIMARY KEY (contract_type)
)

CREATE TABLE Country(
	country_name			VARCHAR(50)			NOT NULL,

	CONSTRAINT pk_country PRIMARY KEY (country_name)
)

CREATE TABLE Genre(
	genre_name				VARCHAR(255)		NOT NULL,
	[description]			VARCHAR(255)		NULL,

	CONSTRAINT pk_genre PRIMARY KEY (genre_name)
)

CREATE TABLE Payment(
	payment_method			VARCHAR(10)			NOT NULL,

	CONSTRAINT pk_payment PRIMARY KEY (payment_method)
)

CREATE TABLE Person(
	person_id				INTEGER				NOT NULL,
	lastname				VARCHAR(50)			NOT NULL,
	firstname				VARCHAR(50)			NOT NULL,
	gender					CHAR(1)				NULL,

	CONSTRAINT pk_person PRIMARY KEY (person_id),
	CONSTRAINT ck_person_gender CHECK (gender IN ('M', 'F'))
)

CREATE TABLE Customer(
	customer_mail_adress	VARCHAR(255)		NOT NULL,
	lastname				VARCHAR(50)			NOT NULL,
	firstname				VARCHAR(50)			NOT NULL,
	payment_method			VARCHAR(10)			NOT NULL,
	payment_card_number		VARCHAR(30)			NOT NULL,
	contract_type			VARCHAR(10)			NOT NULL,
	subscription_start		DATE				NOT NULL,
	subscription_end		DATE				NULL,
	[user_name]				VARCHAR(30)			NOT NULL,
	[password]				VARCHAR(50)			NOT NULL,
	country_name			VARCHAR(50)			NOT NULL,
	gender					CHAR(1)				NULL,
	birth_date				DATE				NULL,

	CONSTRAINT pk_customer PRIMARY KEY (customer_mail_adress),
	CONSTRAINT ak_customver_user_name UNIQUE ([user_name]),
	CONSTRAINT fk_customer_contract FOREIGN KEY (contract_type) REFERENCES [Contract](contract_type)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT fk_customer_country FOREIGN KEY (country_name) REFERENCES Country(country_name)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT fk_customer_payment FOREIGN KEY (payment_method) REFERENCES Payment(payment_method)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT ck_customer_subscription CHECK (subscription_start < subscription_end),
	CONSTRAINT ck_customer_birth_date CHECK (birth_date <= CURRENT_TIMESTAMP - (12 * 365.25)),
	CONSTRAINT ck_customer_email CHECK (customer_mail_adress LIKE '%_@__%.__%')
)

CREATE TABLE Movie(
	movie_id				INTEGER				NOT NULL,
	title					VARCHAR(255)		NOT NULL,
	duration				INTEGER				NULL,
	[description]			VARCHAR(255)		NULL,
	publication_year		INTEGER				NULL,
	cover_image				VARCHAR(255)		NULL,
	previous_part			INTEGER				NULL,
	price					NUMERIC(5,2)		NOT NULL,
	[URL]					VARCHAR(255)		NULL,

	CONSTRAINT pk_movie PRIMARY KEY (movie_id),
	CONSTRAINT fk_movie_movie FOREIGN KEY (previous_part) REFERENCES Movie(movie_id)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
	CONSTRAINT ck_movie_publication_year CHECK (publication_year >= 1890 AND publication_year < year(getdate())),
	CONSTRAINT ck_movie_price CHECK (price > 0)
)

CREATE TABLE Movie_Cast(
	movie_id				INTEGER				NOT NULL,
	person_id				INTEGER				NOT NULL,
	[role]					VARCHAR(255)		NOT NULL,

	CONSTRAINT pk_movie_cast PRIMARY KEY (movie_id, person_id, [role]),
	CONSTRAINT fk_movie_cast_movie FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT fk_movie_cast_person FOREIGN KEY (person_id) REFERENCES Person(person_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
)

CREATE TABLE Movie_Directors(
	movie_id				INTEGER				NOT NULL,
	person_id				INTEGER				NOT NULL,

	CONSTRAINT pk_movie_director PRIMARY KEY (movie_id, person_id),
	CONSTRAINT fk_movie_director_person FOREIGN KEY (person_id) REFERENCES Person(person_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT fk_movie_director_movie FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
)

CREATE TABLE Movie_Genre(
	movie_id				INTEGER				NOT NULL,
	genre_name				VARCHAR(255)		NOT NULL,

	CONSTRAINT pk_movie_genre PRIMARY KEY (movie_id, genre_name),
	CONSTRAINT fk_movie_genre_movie FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT fk_movie_genre_genre FOREIGN KEY (genre_name) REFERENCES Genre(genre_name)
		ON UPDATE CASCADE
		ON DELETE CASCADE
)

CREATE TABLE Watchhistory(
	movie_id				INTEGER				NOT NULL,
	customer_mail_adress	VARCHAR(255)		NOT NULL,
	watch_date				DATE				NOT NULL,
	price					NUMERIC(5,2)		NOT NULL,
	invoiced				BIT					NOT NULL,

	CONSTRAINT pk_watchhistory PRIMARY KEY (movie_id, customer_mail_adress, watch_date),
	CONSTRAINT fk_watchhistory_customer FOREIGN KEY (customer_mail_adress) REFERENCES Customer(customer_mail_adress)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT fk_watchhistory_movie FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT ck_watch_date CHECK (dbo.CK_WatchdateTussenSubstartEnSubend(watch_date) = 1)
)

PRINT('Database FLETNIX has been created')