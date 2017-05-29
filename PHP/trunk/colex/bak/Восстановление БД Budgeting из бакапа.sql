USE [master]
GO
RESTORE DATABASE [Budgeting] FROM  DISK = N'D:\wamp\www\colex\bak\Budgeting.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5