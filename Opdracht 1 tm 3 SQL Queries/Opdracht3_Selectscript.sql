--=== Opdracht 3A t/m 3M ===--
USE FLETNIX

-- A: Alle films gesorteerd naar genre [movie title, publication year, genre]
SELECT M.title, M.publication_year, MG.genre_name
FROM Movie M LEFT OUTER JOIN Movie_Genre MG
			 ON M.movie_id = MG.movie_id
ORDER BY MG.genre_name


-- B: Alle movies die tussen 1990 en 2010 geproduceerd zijn.
SELECT *
FROM Movie
WHERE publication_year >= 1990 AND publication_year <= 2010


-- C: Alle klanten die op dit moment actief zijn (i.e. subscription_end moet leeg zijn) [customer lastname, firstname, subscription_start]
SELECT lastname, firstname, subscription_start
FROM Customer
WHERE subscription_end IS NULL OR subscription_end > CURRENT_TIMESTAMP


-- D: De cast uit alle Terminator movies uit het jaar 1991 [id, title, firstname, lastname, role]
SELECT MC.person_id, M.title, P.firstname, P.lastname, MC.[role]
FROM Movie M INNER JOIN Movie_Cast MC
			 ON M.movie_id = MC.movie_id
			 INNER JOIN Person P
			 ON MC.person_id = P.person_id
WHERE M.title LIKE 'Terminator%' AND M.publication_year = 1991


-- E: Alle movies waarin de acteur “Arnold Schwarzenegger” een rol speelt [movie title, publication year]
SELECT title, publication_year
FROM Movie
WHERE movie_id IN
	(SELECT movie_id
	 FROM Movie_Cast
	 WHERE person_id IN
		(SELECT person_id
		 FROM Person
		 WHERE firstname = 'Arnold' AND lastname = 'Schwarzenegger'))


-- F: Alle gebruikers met openstaande kosten [Customer lastname, firstname, total price] Maak een View voor deze informatiebehoefte.
IF OBJECT_ID ('OpenstaandeKosten') IS NOT NULL
DROP VIEW OpenstaandeKosten

GO
CREATE VIEW OpenstaandeKosten (firstname, lastname, totale_kosten)
AS SELECT C.firstname, C.lastname, SUM(W.price) AS totale_kosten
   FROM Customer C LEFT OUTER JOIN Watchhistory W
				   ON C.customer_mail_adress = W.customer_mail_adress
	WHERE W.invoiced = 0
	GROUP BY C.lastname, C.firstname
GO

SELECT firstname, lastname, totale_kosten
FROM OpenstaandeKosten


-- G: Toon 100 movies die tot nu toe het minst bekeken zijn, gesorteerd naar het aantal keren dat ze gekeken werden. 
--    Dit houdt ook 0 keer in [movie title, number of times watched]. Maak een View voor deze informatiebehoefte.
IF OBJECT_ID('AantalWeergaven') IS NOT NULL
DROP VIEW AantalWeergaven

GO
CREATE VIEW AantalWeergaven (title, aantalKeerBekeken)
AS  SELECT M.title, COUNT(W.watch_date) AS aantalKeerBekeken
	FROM Movie M LEFT OUTER JOIN Watchhistory W
				 ON M.movie_id = W.movie_id
	GROUP BY M.title
GO
	
SET ROWCOUNT 100
SELECT title, aantalKeerBekeken
FROM AantalWeergaven
ORDER BY aantalKeerBekeken DESC
SET ROWCOUNT 0


-- H: Alle movies die in de afgelopen twee maanden het meest bekeken zijn, gesorteerd naar het aantal keren dat ze gekeken 
--    werden. Toon alleen movies die minimaal één keer bekeken zijn [movie title, publication_year, number of times watched].
--    Maak een View voor deze informatiebehoefte. De sortering kun je niet binnen de view doen, laat die buiten de view.
IF OBJECT_ID('BekekenAfgelopenTweeMaanden') IS NOT NULL
DROP VIEW BekekenAfgelopenTweeMaanden

GO
CREATE VIEW BekekenAfgelopenTweeMaanden (title, publication_year, aantalKeerBekeken)
AS	SELECT M.title, M.publication_year, COUNT(W.watch_date) AS aantalKeerBekeken
	FROM Movie M INNER JOIN Watchhistory W
				 ON M.movie_id = W.movie_id
	WHERE watch_date >= DATEADD(MM,-2,GETDATE())
	GROUP BY M.title, M.publication_year
	HAVING COUNT(W.watch_date) >= 1
GO

SELECT title, publication_year, aantalKeerBekeken
FROM BekekenAfgelopenTweeMaanden
ORDER BY aantalKeerBekeken DESC


-- I: Alle movies die meer dan 8 genres hebben [title, publication_year]
SELECT M.title, M.publication_year, COUNT(*) AS aantalGenres
FROM Movie M INNER JOIN Movie_Genre MG
			 ON M.movie_id = MG.movie_id
GROUP BY M.title, M.publication_year
HAVING COUNT(*) > 8


-- J: Alle vrouwen die in Horror movies en Family movies gespeeld hebben [firstname,lastname].
SELECT firstname, lastname
FROM Person
WHERE person_id IN
	(SELECT person_id
	 FROM Movie_Cast
	 WHERE movie_id IN
		(SELECT movie_id
		 FROM Movie_Genre
		 WHERE genre_name = 'Horror' OR genre_name = 'Family'))
 AND gender = 'F'


-- K: De director die tot nu toe de meeste films geproduceerd heeft [firstname, lastname].
SELECT firstname, lastname, COUNT(*) AS aantalFilms
FROM Person P INNER JOIN Movie_Directors MD
			  ON P.person_id = MD.person_id
GROUP BY firstname, lastname
HAVING COUNT(*) >= ALL
	(SELECT COUNT(*)
	 FROM Movie_Directors
	 GROUP BY person_id)


-- L: Alle Genres en het percentage dat de films uit het bepaalde genre uitmaken t.o.v. het totale aantal films [genre, percentage], 
--    gesorteerd op meest populaire genre. Maak een View voor deze informatiebehoefte. Je mag ook eerst één of meerdere (hulp-)views
--    maken om de informatiebehoefte op te lossen.
IF OBJECT_ID('PercentageFilmsPerGenre') IS NOT NULL
DROP VIEW PercentageFilmsPerGenre

GO
CREATE VIEW PercentageFilmsPerGenre
AS	SELECT genre_name, (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Movie_Genre)) AS [percentage]
	FROM Movie_Genre
	GROUP BY genre_name
GO

SELECT genre_name, [percentage]
FROM PercentageFilmsPerGenre
ORDER BY [percentage] DESC


-- M: Gebruikers [mail_adress] en het gemiddelde aantal films die elke gebruiker per dag kijkt. Toon alleen gebruikers die gemiddeld 
--    2 of meer films per dag kijken, met het grootste gemiddelde bovenaan. Maak een View voor deze informatiebehoefte. Je mag ook 
--    eerst één of meerdere (hulp-)views maken om de informatiebehoefte op te lossen.
IF OBJECT_ID('AantalFilmsPerDag') IS NOT NULL
DROP VIEW AantalFilmsPerDag

GO
CREATE VIEW AantalFilmsPerDag
AS	SELECT customer_mail_adress, watch_date, COUNT(*) AS aantalFilmsPerDag 
	FROM Watchhistory 
	GROUP BY customer_mail_adress, watch_date 
GO
-- SELECT * FROM AantalFilmsPerDag


IF OBJECT_ID('AantalDatums') IS NOT NULL
DROP VIEW AantalDatums

GO
CREATE VIEW AantalDatums
AS	SELECT customer_mail_adress, COUNT(*) AS aantalDatums
	FROM AantalFilmsPerDag
	GROUP BY customer_mail_adress
GO
-- SELECT * FROM AantalDatums


IF OBJECT_ID('AantalFilmsPerPersoon') IS NOT NULL
DROP VIEW AantalFilmsPerPersoon

GO
CREATE VIEW AantalFilmsPerPersoon
AS	SELECT customer_mail_adress, SUM(aantalFilmsPerDag) AS aantalFilmsPerPersoon
	FROM AantalFilmsPerDag
	GROUP BY customer_mail_adress
GO
-- SELECT * FROM AantalFilmsPerPersoon


IF OBJECT_ID('BerekenGemiddelde') IS NOT NULL
DROP VIEW BerekenGemiddelde

GO
CREATE VIEW BerekenGemiddelde
AS	SELECT AantalFilmsPerPersoon.customer_mail_adress, (CAST(aantalFilmsPerPersoon AS NUMERIC(3,2)) / CAST(aantalDatums AS NUMERIC(3,1))) AS gemiddelde
	FROM AantalFilmsPerPersoon, AantalDatums
	WHERE AantalFilmsPerPersoon.customer_mail_adress = AantalDatums.customer_mail_adress
GO

SELECT * FROM BerekenGemiddelde WHERE gemiddelde >= 2