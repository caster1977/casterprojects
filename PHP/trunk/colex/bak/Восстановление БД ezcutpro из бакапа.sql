USE [master]
GO
RESTORE DATABASE [ezcutpro] FROM  DISK = N'C:\wamp\www\colex\bak\ezcutpro.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5