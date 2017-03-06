USE [master]
GO
RESTORE DATABASE ue_django FROM  DISK = N'C:\Site\ue_django.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5