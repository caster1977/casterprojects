USE [master]
GO
RESTORE DATABASE [Colex] FROM  DISK = N'D:\wamp\www\colex\bak\Colex.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5