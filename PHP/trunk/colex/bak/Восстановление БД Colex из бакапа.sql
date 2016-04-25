USE [master]
GO
RESTORE DATABASE [Colex] FROM  DISK = N'C:\wamp\www\colex\bak\Colex.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5