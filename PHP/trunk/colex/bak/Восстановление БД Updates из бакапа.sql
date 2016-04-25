USE [master]
GO
RESTORE DATABASE [Updates] FROM  DISK = N'C:\wamp\www\colex\bak\Updates.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5