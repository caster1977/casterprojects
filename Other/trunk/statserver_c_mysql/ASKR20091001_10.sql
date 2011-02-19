USE irda;
DROP TABLE IF EXISTS irda.irda_20091001_10;
CREATE TABLE irda.irda_20091001_10 (KEY datum (datum), KEY ddi (ddi), KEY ani (ani)) SELECT * FROM ird.ird_20091001 WHERE 1=0;

#--------------------------------------------
#-------формирование таблицы за декаду-------
#--------------------------------------------
INSERT INTO irda.irda_20091001_10
SELECT * FROM ird.ird_20091001 UNION
SELECT * FROM ird.ird_20091002 UNION
SELECT * FROM ird.ird_20091003 UNION
SELECT * FROM ird.ird_20091004 UNION
SELECT * FROM ird.ird_20091005 UNION
SELECT * FROM ird.ird_20091006 UNION
SELECT * FROM ird.ird_20091007 UNION
SELECT * FROM ird.ird_20091008 UNION
SELECT * FROM ird.ird_20091009 UNION
SELECT * FROM ird.ird_20091010;

#-----------------------------------------------------------------------------------------
#-------копирование данных из таблицы за декаду в другую для нормалимзации номеров Б------
#-----------------------------------------------------------------------------------------

DROP TABLE IF EXISTS irda.irda_20091001_10_normalized;
CREATE TABLE irda.irda_20091001_10_normalized (KEY datum (datum), KEY ddi (ddi), KEY ani (ani)) SELECT * FROM irda.irda_20091001_10;



#------------------------------------
#-------нормализация номеров Б-------
#------------------------------------

UPDATE irda.irda_20091001_10_normalized SET ddi='109' WHERE (LEFT(ddi,3)='109');
UPDATE irda.irda_20091001_10_normalized SET ddi='130' WHERE (LEFT(ddi,3)='130');
UPDATE irda.irda_20091001_10_normalized SET ddi='175' WHERE (LEFT(ddi,3)='175');
UPDATE irda.irda_20091001_10_normalized SET ddi='188' WHERE (LEFT(ddi,3)='188');
UPDATE irda.irda_20091001_10_normalized SET ddi='190' WHERE (LEFT(ddi,3)='190');
UPDATE irda.irda_20091001_10_normalized SET ddi='191' WHERE (LEFT(ddi,3)='191');
UPDATE irda.irda_20091001_10_normalized SET ddi='192' WHERE (LEFT(ddi,3)='192');
UPDATE irda.irda_20091001_10_normalized SET ddi='193' WHERE (LEFT(ddi,3)='193');
UPDATE irda.irda_20091001_10_normalized SET ddi='194' WHERE (LEFT(ddi,3)='194');
UPDATE irda.irda_20091001_10_normalized SET ddi='195' WHERE (LEFT(ddi,3)='195');
UPDATE irda.irda_20091001_10_normalized SET ddi='196' WHERE (LEFT(ddi,3)='196');
UPDATE irda.irda_20091001_10_normalized SET ddi='197' WHERE (LEFT(ddi,3)='197');
UPDATE irda.irda_20091001_10_normalized SET ddi='198' WHERE (LEFT(ddi,3)='198');
UPDATE irda.irda_20091001_10_normalized SET ddi='199' WHERE (LEFT(ddi,4)='1111');
UPDATE irda.irda_20091001_10_normalized SET ddi='9910911' WHERE (LEFT(ddi,4)='2222') OR (LEFT(ddi,7)='9910911');
UPDATE irda.irda_20091001_10_normalized SET ddi='9919911' WHERE (LEFT(ddi,7)='9919911');
UPDATE irda.irda_20091001_10_normalized SET ddi='99175' WHERE (LEFT(ddi,5)='99175');
UPDATE irda.irda_20091001_10_normalized SET ddi='99188' WHERE (LEFT(ddi,5)='99188');
UPDATE irda.irda_20091001_10_normalized SET ddi='99190' WHERE (LEFT(ddi,5)='99190');
UPDATE irda.irda_20091001_10_normalized SET ddi='99191' WHERE (LEFT(ddi,5)='99191');
UPDATE irda.irda_20091001_10_normalized SET ddi='99192' WHERE (LEFT(ddi,5)='99192');
UPDATE irda.irda_20091001_10_normalized SET ddi='99193' WHERE (LEFT(ddi,5)='99193');
UPDATE irda.irda_20091001_10_normalized SET ddi='99194' WHERE (LEFT(ddi,5)='99194');
UPDATE irda.irda_20091001_10_normalized SET ddi='99195' WHERE (LEFT(ddi,5)='99195');
UPDATE irda.irda_20091001_10_normalized SET ddi='99196' WHERE (LEFT(ddi,5)='99196');
UPDATE irda.irda_20091001_10_normalized SET ddi='99197' WHERE (LEFT(ddi,5)='99197');



OPTIMIZE TABLE irda.irda_20091001_10_normalized;



#----------------------------------------------------------------------------------------------------
#-------создание таблицы для копирования в неё звонков с непустым номером А по платным услугам-------
#----------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS irda.irda_20091001_10_askr;
CREATE TABLE irda.irda_20091001_10_askr (KEY datum (datum), KEY ddi (ddi), KEY ani (ani)) SELECT * FROM irda.irda_20091001_10 WHERE 1=0;



#--------------------------------------------------
#-------внесение звонков на голосовые услуги-------
#--------------------------------------------------

INSERT INTO irda.irda_20091001_10_askr
 SELECT *
 FROM irda.irda_20091001_10_normalized
 WHERE ddi IN('109', '190', '193', '9910911', '99190') AND 
 (!(ani="" OR ani="0" OR ISNULL(ani))) AND
 v_mreza>'' AND druga_info=0 AND v_oper>'' AND rm>0 AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND dur>0
 ORDER BY ddi, datum, vrijeme;



#-------------------------------------------------
#-------внесение звонков на автоинформаторы-------
#-------------------------------------------------

INSERT INTO irda.irda_20091001_10_askr
 SELECT *
 FROM irda.irda_20091001_10_normalized
 WHERE ddi IN('175', '188', '191', '192', '194', '195', '196', '197', '99175', '99188', '99191', '99192', '99194', '99195', '99196', '99197') AND 
 (!(ani="" OR ani="0" OR ISNULL(ani))) AND
 v_mreza>'' AND druga_info=0 AND dur>4 
 ORDER BY ddi, datum, vrijeme;



#------------------------------------------------------------------------
#-------нормализация номеров Б для выгрузки АСКР по договорённости-------
#------------------------------------------------------------------------

UPDATE irda.irda_20091001_10_askr SET ddi='99109' WHERE ddi='9910911';



OPTIMIZE TABLE irda.irda_20091001_10_askr;



#-----------------------------
#-------проверка списка-------
#-----------------------------

#SELECT ddi, COUNT(*) FROM irda.irda_20091001_10_normalized GROUP BY ddi;
#SELECT ddi, COUNT(*) FROM irda.irda_20091001_10_askr GROUP BY ddi;



#--------------------------------------------------------------------------------------------------------------------------------------------------
#-запросы на выборку данных по звонкам с городских, пригородных (в том числе WLL), таксофонных и гостиничных телефонов идущих с города и через МЦК-
#--------------------------------------------------------------------------------------------------------------------------------------------------

USE ARJ;
DELETE FROM arj.new_report;
OPTIMIZE TABLE arj.new_report;



#---------------------------------------------------------------------
#------------109, 188, 192, 195, 99109, 99188, 99192, 99195-----------
#---------------------------------------------------------------------

INSERT INTO arj.new_report(numA, data, time, price, t_serv, t_tar)
 SELECT DISTINCT RIGHT(ani, 7), DATE_FORMAT(datum, "%d%m%y"), TIME_FORMAT(vrijeme, "%H%i%s"), '0', ddi, '3'
 FROM irda.irda_20091001_10_askr
 WHERE ddi IN('109', '188', '192', '195', '99109', '99188', '99192', '99195') AND 
 (ani LIKE '00172______' OR ani LIKE '0172______' OR ani LIKE '02______' OR ani LIKE '2______' OR 
  ani LIKE '00173______' OR ani LIKE '0173______' OR ani LIKE '03______' OR ani LIKE '3______' OR
  ani LIKE '00175______' OR ani LIKE '0175______' OR ani LIKE '05______' OR ani LIKE '5______' 
 ) 
 ORDER BY ddi, datum, vrijeme;

INSERT INTO arj.new_report(numA, data, time, price, t_serv, t_tar)
 SELECT DISTINCT RIGHT(ani, 6), DATE_FORMAT(datum, "%d%m%y"), TIME_FORMAT(vrijeme, "%H%i%s"), '0', ddi, '3'
 FROM irda.irda_20091001_10_askr
 WHERE ddi IN('109', '188', '192', '195', '99109', '99188', '99192', '99195') AND 
 (ani LIKE '00172_____' OR ani LIKE '0172_____' OR ani LIKE '02_____' OR ani LIKE '2_____' OR 
  ani LIKE '00173_____' OR ani LIKE '0173_____' OR ani LIKE '03_____' OR ani LIKE '3_____' OR
  ani LIKE '00175_____' OR ani LIKE '0175_____' OR ani LIKE '05_____' OR ani LIKE '5_____' OR
  ani LIKE '00178______' OR ani LIKE '0178______' OR ani LIKE '08______' OR ani LIKE '8______' 
 ) 
 ORDER BY ddi, datum, vrijeme;

INSERT INTO arj.new_report(numA, data, time, price, t_serv, t_tar)
 SELECT DISTINCT RIGHT(ani, 5), DATE_FORMAT(datum, "%d%m%y"), TIME_FORMAT(vrijeme, "%H%i%s"), '0', ddi, '3'
 FROM irda.irda_20091001_10_askr
 WHERE ddi IN('109', '188', '192', '195', '99109', '99188', '99192', '99195') AND 
 (ani LIKE '00172____' OR ani LIKE '0172____' OR ani LIKE '02____' OR ani LIKE '2____' OR 
  ani LIKE '00173____' OR ani LIKE '0173____' OR ani LIKE '03____' OR ani LIKE '3____' OR
  ani LIKE '00175____' OR ani LIKE '0175____' OR ani LIKE '05____' OR ani LIKE '5____' OR
  ani LIKE '00178_____' OR ani LIKE '0178_____' OR ani LIKE '08_____' OR ani LIKE '8_____' 
 ) 
 ORDER BY ddi, datum, vrijeme;



#---------------------------------------------------------------------------------------------------------
#------------175, 190, 191, 193, 194, 196, 197, 99175, 99190, 99191, 99193, 99194, 99196, 99197-----------
#---------------------------------------------------------------------------------------------------------

INSERT INTO arj.new_report(numA, data, time, dur, price, t_serv, t_tar)
 SELECT DISTINCT RIGHT(ani, 7), DATE_FORMAT(datum, "%d%m%y"), TIME_FORMAT(vrijeme, "%H%i%s"), TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60), "%H%i"), '0', ddi, '1'
 FROM irda.irda_20091001_10_askr
 WHERE ddi IN('175', '190', '191', '193', '194', '196', '197', '99175', '99190', '99191', '99193', '99194', '99196', '99197') AND 
 (ani LIKE '00172______' OR ani LIKE '0172______' OR ani LIKE '02______' OR ani LIKE '2______' OR 
  ani LIKE '00173______' OR ani LIKE '0173______' OR ani LIKE '03______' OR ani LIKE '3______' OR
  ani LIKE '00175______' OR ani LIKE '0175______' OR ani LIKE '05______' OR ani LIKE '5______' 
 ) 
 ORDER BY ddi, datum, vrijeme;

INSERT INTO arj.new_report(numA, data, time, dur, price, t_serv, t_tar)
 SELECT DISTINCT RIGHT(ani, 6), DATE_FORMAT(datum, "%d%m%y"), TIME_FORMAT(vrijeme, "%H%i%s"), TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60), "%H%i"), '0', ddi, '1'
 FROM irda.irda_20091001_10_askr
 WHERE ddi IN('175', '190', '191', '193', '194', '196', '197', '99175', '99190', '99191', '99193', '99194', '99196', '99197') AND 
 (ani LIKE '00172_____' OR ani LIKE '0172_____' OR ani LIKE '02_____' OR ani LIKE '2_____' OR 
  ani LIKE '00173_____' OR ani LIKE '0173_____' OR ani LIKE '03_____' OR ani LIKE '3_____' OR
  ani LIKE '00175_____' OR ani LIKE '0175_____' OR ani LIKE '05_____' OR ani LIKE '5_____' OR
  ani LIKE '00178______' OR ani LIKE '0178______' OR ani LIKE '08______' OR ani LIKE '8______' 
 ) 
 ORDER BY ddi, datum, vrijeme;

INSERT INTO arj.new_report(numA, data, time, dur, price, t_serv, t_tar)
 SELECT DISTINCT RIGHT(ani, 6), DATE_FORMAT(datum, "%d%m%y"), TIME_FORMAT(vrijeme, "%H%i%s"), TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60), "%H%i"), '0', ddi, '1'
 FROM irda.irda_20091001_10_askr
 WHERE ddi IN('175', '190', '191', '193', '194', '196', '197', '99175', '99190', '99191', '99193', '99194', '99196', '99197') AND 
 (ani LIKE '00172____' OR ani LIKE '0172____' OR ani LIKE '02____' OR ani LIKE '2____' OR 
  ani LIKE '00173____' OR ani LIKE '0173____' OR ani LIKE '03____' OR ani LIKE '3____' OR
  ani LIKE '00175____' OR ani LIKE '0175____' OR ani LIKE '05____' OR ani LIKE '5____' OR
  ani LIKE '00178_____' OR ani LIKE '0178_____' OR ani LIKE '08_____' OR ani LIKE '8_____' 
 ) 
 ORDER BY ddi, datum, vrijeme;



OPTIMIZE TABLE arj.new_report;



#-----------------------------------
#------------выгрузка 188-----------
#-----------------------------------

SELECT cod, type, cat, numA, numB, data, time, dur, '0', '17109', t_serv, t_tar, ''
 INTO OUTFILE 'd:\\ASKR\\20091001_10\\188.unl' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n'
 FROM arj.new_report r
 LEFT JOIN arj.black b ON r.numA LIKE b.phn
 WHERE ISNULL(b.phn) AND t_serv IN('188','99188')
 ORDER BY t_serv, data, time;



#----------------------------------------------
#------------выгрузка всех кроме 188-----------
#----------------------------------------------

SELECT cod, type, cat, numA, numB, data, time, dur, '0', '17109', t_serv, t_tar, ''
 INTO OUTFILE 'd:\\ASKR\\20091001_10\\109.unl' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n'
 FROM arj.new_report r
 LEFT JOIN arj.black b ON r.numA LIKE b.phn
 WHERE ISNULL(b.phn) AND (!(t_serv IN('188','99188')))
 ORDER BY t_serv, data, time;



#----------------------------------------------------
#------------формирование файла статистики-----------
#----------------------------------------------------

SELECT t_serv, COUNT(*), SUM(dur)
 INTO OUTFILE 'd:\\ASKR\\20091001_10\\summary_bottom.txt' FIELDS TERMINATED BY '		|' LINES TERMINATED BY '\n'
 FROM arj.new_report r
 LEFT JOIN arj.black b ON r.numA LIKE b.phn
 WHERE ISNULL(b.phn) 
 GROUP BY t_serv
 ORDER BY t_serv;



SELECT 'СОПРОВОДИТЕЛЬНЫЙ ЯРЛЫК',
CONCAT('Период данных: ', LEFT(MIN(data),2), '/', RIGHT(LEFT(MIN(data),4),2), '/', RIGHT(MIN(data),2), ' - ', LEFT(MAX(data),2), '/', RIGHT(LEFT(MAX(data),4),2), '/', RIGHT(MAX(data),2)), 
'',
'Имя: 109.unl', 
'Размер файла: ',
'',
'Имя: 188.unl',
'Размер файла: ',
'',
'DDI		|Запись		|Длительность'
 INTO OUTFILE 'd:\\ASKR\\20091001_10\\summary_top.txt' FIELDS TERMINATED BY '\n' LINES TERMINATED BY '\n'
 FROM arj.new_report
 GROUP BY '';



#------------------------------------------------------------------------------------------------------------------------------------------------
#------------копирование данных для составления таблицы отсева звонков, подлежащих оплате, но не проходящих по номеру А (кроме пустых)-----------
#------------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS irda.irda_20091001_10_askr_filtered;
CREATE TABLE irda.irda_20091001_10_askr_filtered (KEY datum (datum), KEY ddi (ddi), KEY ani (ani)) SELECT * FROM irda.irda_20091001_10_askr;



#---------------------------------------------------------------------
#------------109, 188, 192, 195, 99109, 99188, 99192, 99195-----------
#---------------------------------------------------------------------

DELETE FROM irda.irda_20091001_10_askr_filtered
 WHERE ddi IN('109', '188', '192', '195', '99109', '99188', '99192', '99195') AND 
 (ani LIKE '00172______' OR ani LIKE '0172______' OR ani LIKE '02______' OR ani LIKE '2______' OR 
  ani LIKE '00173______' OR ani LIKE '0173______' OR ani LIKE '03______' OR ani LIKE '3______' OR
  ani LIKE '00175______' OR ani LIKE '0175______' OR ani LIKE '05______' OR ani LIKE '5______' 
 );

DELETE FROM irda.irda_20091001_10_askr_filtered
 WHERE ddi IN('109', '188', '192', '195', '99109', '99188', '99192', '99195') AND 
 (ani LIKE '00172_____' OR ani LIKE '0172_____' OR ani LIKE '02_____' OR ani LIKE '2_____' OR 
  ani LIKE '00173_____' OR ani LIKE '0173_____' OR ani LIKE '03_____' OR ani LIKE '3_____' OR
  ani LIKE '00175_____' OR ani LIKE '0175_____' OR ani LIKE '05_____' OR ani LIKE '5_____' OR
  ani LIKE '00178______' OR ani LIKE '0178______' OR ani LIKE '08______' OR ani LIKE '8______' 
 );

DELETE FROM irda.irda_20091001_10_askr_filtered
 WHERE ddi IN('109', '188', '192', '195', '99109', '99188', '99192', '99195') AND 
 (ani LIKE '00172____' OR ani LIKE '0172____' OR ani LIKE '02____' OR ani LIKE '2____' OR 
  ani LIKE '00173____' OR ani LIKE '0173____' OR ani LIKE '03____' OR ani LIKE '3____' OR
  ani LIKE '00175____' OR ani LIKE '0175____' OR ani LIKE '05____' OR ani LIKE '5____' OR
  ani LIKE '00178_____' OR ani LIKE '0178_____' OR ani LIKE '08_____' OR ani LIKE '8_____' 
 );



#---------------------------------------------------------------------------------------------------------
#------------175, 190, 191, 193, 194, 196, 197, 99175, 99190, 99191, 99193, 99194, 99196, 99197-----------
#---------------------------------------------------------------------------------------------------------

DELETE FROM irda.irda_20091001_10_askr_filtered
 WHERE ddi IN('175', '190', '191', '193', '194', '196', '197', '99175', '99190', '99191', '99193', '99194', '99196', '99197') AND 
 (ani LIKE '00172______' OR ani LIKE '0172______' OR ani LIKE '02______' OR ani LIKE '2______' OR 
  ani LIKE '00173______' OR ani LIKE '0173______' OR ani LIKE '03______' OR ani LIKE '3______' OR
  ani LIKE '00175______' OR ani LIKE '0175______' OR ani LIKE '05______' OR ani LIKE '5______' 
 );

DELETE FROM irda.irda_20091001_10_askr_filtered
 WHERE ddi IN('175', '190', '191', '193', '194', '196', '197', '99175', '99190', '99191', '99193', '99194', '99196', '99197') AND
 (ani LIKE '00172_____' OR ani LIKE '0172_____' OR ani LIKE '02_____' OR ani LIKE '2_____' OR 
  ani LIKE '00173_____' OR ani LIKE '0173_____' OR ani LIKE '03_____' OR ani LIKE '3_____' OR
  ani LIKE '00175_____' OR ani LIKE '0175_____' OR ani LIKE '05_____' OR ani LIKE '5_____' OR
  ani LIKE '00178______' OR ani LIKE '0178______' OR ani LIKE '08______' OR ani LIKE '8______' 
 );

DELETE FROM irda.irda_20091001_10_askr_filtered
 WHERE ddi IN('175', '190', '191', '193', '194', '196', '197', '99175', '99190', '99191', '99193', '99194', '99196', '99197') AND 
 (ani LIKE '00172____' OR ani LIKE '0172____' OR ani LIKE '02____' OR ani LIKE '2____' OR 
  ani LIKE '00173____' OR ani LIKE '0173____' OR ani LIKE '03____' OR ani LIKE '3____' OR
  ani LIKE '00175____' OR ani LIKE '0175____' OR ani LIKE '05____' OR ani LIKE '5____' OR
  ani LIKE '00178_____' OR ani LIKE '0178_____' OR ani LIKE '08_____' OR ani LIKE '8_____' 
 );



OPTIMIZE TABLE irda.irda_20091001_10_askr_filtered;



#-----------------------------
#-------проверка списка-------
#-----------------------------

#SELECT ddi, COUNT(*) FROM irda.irda_20091001_10_askr_filtered GROUP BY ddi;
#SELECT ani, COUNT(*) FROM irda.irda_20091001_10_askr_filtered GROUP BY ani;