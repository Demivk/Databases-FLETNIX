/* Opdracht 5A */
/* Overzicht Nominaties en Winnaars Per Award */
USE FLETNIX_DOCENT

IF OBJECT_ID ('OverzichtNominatiesEnWinnaarsPerAward') IS NOT NULL
DROP VIEW OverzichtNominatiesEnWinnaarsPerAward

GO
CREATE VIEW OverzichtNominatiesEnWinnaarsPerAward
AS	(SELECT M.movie_id, M.title, M.publication_year, AY.award, A.country, AY.[year], AY.category, P.person_id, P.firstname, P.lastname, code
	 FROM Movie M INNER JOIN Awards_per_Year AY ON M.movie_id = AY.movie_id
				  INNER JOIN Awardshow A ON AY.award = A.award
				  INNER JOIN Person P ON AY.person_id = P.person_id)
GO

SELECT * FROM OverzichtNominatiesEnWinnaarsPerAward
/*----------*/

/* Winnaars en Nominaties */
USE FLETNIX_DOCENT

IF OBJECT_ID ('BerekenAantalNominaties') IS NOT NULL
DROP VIEW BerekenAantalNominaties

GO
CREATE VIEW BerekenAantalNominaties
AS	SELECT M.movie_id, M.title, COUNT(*) AS nominations
	FROM Awards_per_Year AY LEFT OUTER JOIN Movie M ON AY.movie_id = M.movie_id
	GROUP BY M.movie_id, M.title
GO

--SELECT * FROM BerekenAantalNominaties


IF OBJECT_ID ('BerekenAantalVerloren') IS NOT NULL
DROP VIEW BerekenAantalVerloren

GO
CREATE VIEW BerekenAantalVerloren
AS	SELECT M.movie_id, M.title, COUNT(*) AS lost
	FROM Awards_per_Year AY LEFT OUTER JOIN Movie M ON AY.movie_id = M.movie_id
	WHERE code <> 'W'
	GROUP BY M.movie_id, M.title
GO

--SELECT * FROM BerekenAantalVerloren


IF OBJECT_ID ('AantalNominatiesEnWinnaarsPerFilm') IS NOT NULL
DROP VIEW AantalNominatiesEnWinnaarsPerFilm

GO
CREATE VIEW AantalNominatiesEnWinnaarsPerFilm
AS	SELECT N.movie_id, N.title, nominations, nominations - lost AS won
	FROM BerekenAantalNominaties N LEFT OUTER JOIN BerekenAantalVerloren L ON N.movie_id = L.movie_id
GO

--SELECT * FROM AantalNominatiesEnWinnaarsPerFilm
/*----------------------------------------------*/


/* Opdracht 5B1 */
/* Bereken totale omzet */
USE FLETNIX

IF OBJECT_ID ('Betaald') IS NOT NULL
DROP VIEW Betaald

GO
CREATE VIEW Betaald
AS	(SELECT YEAR(watch_date) AS [year], CU.country_name, SUM(price) AS total_profit
	 FROM Watchhistory W LEFT OUTER JOIN Customer CU ON W.customer_mail_adress = CU.customer_mail_adress
						 LEFT OUTER JOIN Country CO ON CU.country_name = CO.country_name
	 WHERE invoiced = 1
	 GROUP BY CU.country_name, YEAR(watch_date))
GO

--SELECT * FROM Betaald ORDER BY [year]


IF OBJECT_ID ('NietBetaald') IS NOT NULL
DROP VIEW NietBetaald

GO
CREATE VIEW NietBetaald
AS	(SELECT YEAR(watch_date) AS [year], CU.country_name, SUM(price) AS total_loss
	 FROM Watchhistory W LEFT OUTER JOIN Customer CU ON W.customer_mail_adress = CU.customer_mail_adress
						 LEFT OUTER JOIN Country CO ON CU.country_name = CO.country_name
	 WHERE invoiced = 0
	 GROUP BY CU.country_name, YEAR(watch_date))
GO

--SELECT * FROM NietBetaald ORDER BY [year]


IF OBJECT_ID ('TotaleOmzet') IS NOT NULL
DROP VIEW TotaleOmzet

GO
CREATE VIEW TotaleOmzet
AS	(SELECT B.country_name, B.[year], total_profit, total_loss, total_profit - total_loss AS total_revenue
	 FROM Betaald B LEFT OUTER JOIN NietBetaald N ON B.[year] = N.[year])
GO

SELECT * FROM TotaleOmzet ORDER BY country_name
/*----------*/


/* Spreiding genres */
USE FLETNIX

IF OBJECT_ID ('GenresPerCountry') IS NOT NULL
DROP VIEW GenresPerCountry

GO
CREATE VIEW GenresPerCountry
AS	(SELECT C.country_name, W.watch_date, M.movie_id, M.title, MG.genre_name
	 FROM Movie M INNER JOIN Movie_Genre MG ON M.movie_id = MG.movie_id
				  INNER JOIN Watchhistory W ON M.movie_id = W.movie_id
				  INNER JOIN Customer C ON C.customer_mail_adress = W.customer_mail_adress)
GO

SELECT * FROM GenresPerCountry ORDER BY country_name, genre_name
/*----------*/


/* Opdracht 5B3 */
/* Bereken aantal klanten per jaar*/
USE FLETNIX
IF OBJECT_ID ('BerekenAantalKlantenPerJaar') IS NOT NULL
DROP VIEW BerekenAantalKlantenPerJaar

GO
CREATE VIEW BerekenAantalKlantenPerJaar
AS	SELECT YEAR(subscription_start) AS jaar, COUNT(subscription_start) AS aanmeldingen, COUNT(subscription_end) AS afmeldingen, COUNT(subscription_start) - COUNT(subscription_end) AS totale_toename
	FROM Customer
	GROUP BY YEAR(subscription_start)
GO

SELECT * FROM BerekenAantalKlantenPerJaar


/* Bereken groei */
IF OBJECT_ID ('BerekenGroeiPercentage') IS NOT NULL
DROP VIEW BerekenGroeiPercentage

GO
CREATE VIEW BerekenGroeiPercentage
AS	SELECT YEAR(subscription_start) AS jaar, COUNT(subscription_start) - COUNT(subscription_end) AS totale_toename,
		   100 * ((COUNT(subscription_start) - COUNT(subscription_end)) - LAG((COUNT(subscription_start) - COUNT(subscription_end)), 1) OVER (ORDER BY YEAR(subscription_start)) / LAG((COUNT(subscription_start) - COUNT(subscription_end)), 1) OVER (ORDER BY YEAR(subscription_start))) AS groeipercentage_tov_vorig_jaar
	FROM Customer
	GROUP BY YEAR(subscription_start)
GO

SELECT * FROM BerekenGroeiPercentage


IF OBJECT_ID ('AanmeldingenVSAfmeldingen') IS NOT NULL
DROP VIEW AanmeldingenVSAfmeldingen

GO
CREATE VIEW AanmeldingenVSAfmeldingen
AS	SELECT BG.jaar, BK.aanmeldingen, BK.afmeldingen, BK.totale_toename, BG.groeipercentage_tov_vorig_jaar
	FROM BerekenAantalKlantenPerJaar BK LEFT OUTER JOIN BerekenGroeiPercentage BG ON BK.jaar = BG.jaar
GO

SELECT * FROM AanmeldingenVSAfmeldingen
/*----------*/


/* Opdracht 5B4 */
/* Leeftijdscategorieën */
USE FLETNIX

IF OBJECT_ID ('BerekenLeeftijd') IS NOT NULL
DROP FUNCTION BerekenLeeftijd

GO
CREATE FUNCTION BerekenLeeftijd (
    @DOB		DATETIME,
    @PassedDate DATETIME
)

RETURNS INT
WITH SCHEMABINDING
AS
BEGIN
	DECLARE @iMonthDayDob INT
	DECLARE @iMonthDayPassedDate INT

	SELECT @iMonthDayDob = CAST(DATEPART (mm,@DOB) * 100 + DATEPART  (dd,@DOB) AS int) 
	SELECT @iMonthDayPassedDate = CAST(DATEPART (mm,@PassedDate) * 100 + DATEPART  (dd,@PassedDate) AS int) 

	RETURN DATEDIFF(yy,@DOB, @PassedDate) 
	- CASE WHEN @iMonthDayDob <= @iMonthDayPassedDate
	THEN 0 
	ELSE 1
	END
END
GO

SELECT customer_mail_adress, dbo.BerekenLeeftijd(birth_date, GETDATE()) AS age
FROM Customer


IF OBJECT_ID ('Leeftijdscategorie_25_50') IS NOT NULL
DROP VIEW Leeftijdscategorie_25_50

GO
CREATE VIEW Leeftijdscategorie_25_50
AS	SELECT customer_mail_adress, birth_date, subscription_start, dbo.BerekenLeeftijd(birth_date, GETDATE()) AS age
	FROM Customer
	WHERE dbo.BerekenLeeftijd(birth_date, GETDATE()) >= 25 AND dbo.BerekenLeeftijd(birth_date, GETDATE()) <= 50
GO

SELECT * FROM Leeftijdscategorie_25_50


IF OBJECT_ID ('Leeftijdscategorie_50_75') IS NOT NULL
DROP VIEW Leeftijdscategorie_50_75

GO
CREATE VIEW Leeftijdscategorie_50_75
AS	SELECT customer_mail_adress, birth_date, subscription_start, dbo.BerekenLeeftijd(birth_date, GETDATE()) AS age
	FROM Customer
	WHERE dbo.BerekenLeeftijd(birth_date, GETDATE()) >= 50 AND dbo.BerekenLeeftijd(birth_date, GETDATE()) <= 75
GO

SELECT * FROM Leeftijdscategorie_50_75

/*----------*/