USE [master]
RESTORE DATABASE [MYIMDB] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Backup\MYIMDB.bak' WITH  FILE = 1,  NOUNLOAD,  STATS = 5

GO

USE MYIMDB

SELECT * FROM MYIMDB.dbo.Imported_Cast
SELECT * FROM MYIMDB.dbo.Imported_Director_Genre
SELECT * FROM MYIMDB.dbo.Imported_Directors
SELECT * FROM MYIMDB.dbo.Imported_Genre
SELECT * FROM MYIMDB.dbo.Imported_Movie
SELECT * FROM MYIMDB.dbo.Imported_Movie_Directors
SELECT * FROM MYIMDB.dbo.Imported_Person