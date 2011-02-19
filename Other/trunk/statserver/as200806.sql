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
 FROM irda.irda_200806_askr 
 WHERE ddi IN('109', '188', '192', '195', '99109', '99188', '99192', '99195') AND 
 (ani LIKE '00172______' OR ani LIKE '0172______' OR ani LIKE '02______' OR ani LIKE '2______' OR 
  ani LIKE '00173______' OR ani LIKE '0173______' OR ani LIKE '03______' OR ani LIKE '3______' OR
  ani LIKE '00175______' OR ani LIKE '0175______' OR ani LIKE '05______' OR ani LIKE '5______' 
 ) 
 ORDER BY ddi, datum, vrijeme;

INSERT INTO arj.new_report(numA, data, time, price, t_serv, t_tar)
 SELECT DISTINCT RIGHT(ani, 6), DATE_FORMAT(datum, "%d%m%y"), TIME_FORMAT(vrijeme, "%H%i%s"), '0', ddi, '3'
 FROM irda.irda_200806_askr 
 WHERE ddi IN('109', '188', '192', '195', '99109', '99188', '99192', '99195') AND 
 (ani LIKE '00172_____' OR ani LIKE '0172_____' OR ani LIKE '02_____' OR ani LIKE '2_____' OR 
  ani LIKE '00173_____' OR ani LIKE '0173_____' OR ani LIKE '03_____' OR ani LIKE '3_____' OR
  ani LIKE '00175_____' OR ani LIKE '0175_____' OR ani LIKE '05_____' OR ani LIKE '5_____' OR
  ani LIKE '00178______' OR ani LIKE '0178______' OR ani LIKE '08______' OR ani LIKE '8______' 
 ) 
 ORDER BY ddi, datum, vrijeme;

INSERT INTO arj.new_report(numA, data, time, price, t_serv, t_tar)
 SELECT DISTINCT RIGHT(ani, 5), DATE_FORMAT(datum, "%d%m%y"), TIME_FORMAT(vrijeme, "%H%i%s"), '0', ddi, '3'
 FROM irda.irda_200806_askr 
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
 FROM irda.irda_200806_askr 
 WHERE ddi IN('175', '190', '191', '193', '194', '196', '197', '99175', '99190', '99191', '99193', '99194', '99196', '99197') AND 
 (ani LIKE '00172______' OR ani LIKE '0172______' OR ani LIKE '02______' OR ani LIKE '2______' OR 
  ani LIKE '00173______' OR ani LIKE '0173______' OR ani LIKE '03______' OR ani LIKE '3______' OR
  ani LIKE '00175______' OR ani LIKE '0175______' OR ani LIKE '05______' OR ani LIKE '5______' 
 ) 
 ORDER BY ddi, datum, vrijeme;

INSERT INTO arj.new_report(numA, data, time, dur, price, t_serv, t_tar)
 SELECT DISTINCT RIGHT(ani, 6), DATE_FORMAT(datum, "%d%m%y"), TIME_FORMAT(vrijeme, "%H%i%s"), TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60), "%H%i"), '0', ddi, '1'
 FROM irda.irda_200806_askr 
 WHERE ddi IN('175', '190', '191', '193', '194', '196', '197', '99175', '99190', '99191', '99193', '99194', '99196', '99197') AND 
 (ani LIKE '00172_____' OR ani LIKE '0172_____' OR ani LIKE '02_____' OR ani LIKE '2_____' OR 
  ani LIKE '00173_____' OR ani LIKE '0173_____' OR ani LIKE '03_____' OR ani LIKE '3_____' OR
  ani LIKE '00175_____' OR ani LIKE '0175_____' OR ani LIKE '05_____' OR ani LIKE '5_____' OR
  ani LIKE '00178______' OR ani LIKE '0178______' OR ani LIKE '08______' OR ani LIKE '8______' 
 ) 
 ORDER BY ddi, datum, vrijeme;

INSERT INTO arj.new_report(numA, data, time, dur, price, t_serv, t_tar)
 SELECT DISTINCT RIGHT(ani, 6), DATE_FORMAT(datum, "%d%m%y"), TIME_FORMAT(vrijeme, "%H%i%s"), TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60), "%H%i"), '0', ddi, '1'
 FROM irda.irda_200806_askr 
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
 INTO OUTFILE 'd:\\ASKR\\200806\\188.unl' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n'
 FROM arj.new_report r
 LEFT JOIN arj.black b ON r.numA LIKE b.phn
 WHERE ISNULL(b.phn) AND t_serv IN('188','99188')
 ORDER BY t_serv, data, time;



#----------------------------------------------
#------------выгрузка всех кроме 188-----------
#----------------------------------------------

SELECT cod, type, cat, numA, numB, data, time, dur, '0', '17109', t_serv, t_tar, ''
 INTO OUTFILE 'd:\\ASKR\\200806\\109.unl' FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n'
 FROM arj.new_report r
 LEFT JOIN arj.black b ON r.numA LIKE b.phn
 WHERE ISNULL(b.phn) AND (!(t_serv IN('188','99188')))
 ORDER BY t_serv, data, time;



#----------------------------------------------------
#------------формирование файла статистики-----------
#----------------------------------------------------

SELECT t_serv, COUNT(*), SUM(dur)
 INTO OUTFILE 'd:\\ASKR\\200806\\summary_bottom.txt' FIELDS TERMINATED BY '		|' LINES TERMINATED BY '\n'
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
 INTO OUTFILE 'd:\\ASKR\\200806\\summary_top.txt' FIELDS TERMINATED BY '\n' LINES TERMINATED BY '\n'
 FROM arj.new_report
 GROUP BY '';



#------------------------------------------------------------------------------------------------------------------------------------------------
#------------копирование данных для составления таблицы отсева звонков, подлежащих оплате, но не проходящих по номеру А (кроме пустых)-----------
#------------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS irda.irda_200806_askr_filtered;
CREATE TABLE irda.irda_200806_askr_filtered (KEY datum (datum), KEY ddi (ddi), KEY ani (ani)) SELECT * FROM irda.irda_200806_askr;



#---------------------------------------------------------------------
#------------109, 188, 192, 195, 99109, 99188, 99192, 99195-----------
#---------------------------------------------------------------------

DELETE FROM irda.irda_200806_askr_filtered 
 WHERE ddi IN('109', '188', '192', '195', '99109', '99188', '99192', '99195') AND 
 (ani LIKE '00172______' OR ani LIKE '0172______' OR ani LIKE '02______' OR ani LIKE '2______' OR 
  ani LIKE '00173______' OR ani LIKE '0173______' OR ani LIKE '03______' OR ani LIKE '3______' OR
  ani LIKE '00175______' OR ani LIKE '0175______' OR ani LIKE '05______' OR ani LIKE '5______' 
 );

DELETE FROM irda.irda_200806_askr_filtered 
 WHERE ddi IN('109', '188', '192', '195', '99109', '99188', '99192', '99195') AND 
 (ani LIKE '00172_____' OR ani LIKE '0172_____' OR ani LIKE '02_____' OR ani LIKE '2_____' OR 
  ani LIKE '00173_____' OR ani LIKE '0173_____' OR ani LIKE '03_____' OR ani LIKE '3_____' OR
  ani LIKE '00175_____' OR ani LIKE '0175_____' OR ani LIKE '05_____' OR ani LIKE '5_____' OR
  ani LIKE '00178______' OR ani LIKE '0178______' OR ani LIKE '08______' OR ani LIKE '8______' 
 );

DELETE FROM irda.irda_200806_askr_filtered 
 WHERE ddi IN('109', '188', '192', '195', '99109', '99188', '99192', '99195') AND 
 (ani LIKE '00172____' OR ani LIKE '0172____' OR ani LIKE '02____' OR ani LIKE '2____' OR 
  ani LIKE '00173____' OR ani LIKE '0173____' OR ani LIKE '03____' OR ani LIKE '3____' OR
  ani LIKE '00175____' OR ani LIKE '0175____' OR ani LIKE '05____' OR ani LIKE '5____' OR
  ani LIKE '00178_____' OR ani LIKE '0178_____' OR ani LIKE '08_____' OR ani LIKE '8_____' 
 );



#---------------------------------------------------------------------------------------------------------
#------------175, 190, 191, 193, 194, 196, 197, 99175, 99190, 99191, 99193, 99194, 99196, 99197-----------
#---------------------------------------------------------------------------------------------------------

DELETE FROM irda.irda_200806_askr_filtered 
 WHERE ddi IN('175', '190', '191', '193', '194', '196', '197', '99175', '99190', '99191', '99193', '99194', '99196', '99197') AND 
 (ani LIKE '00172______' OR ani LIKE '0172______' OR ani LIKE '02______' OR ani LIKE '2______' OR 
  ani LIKE '00173______' OR ani LIKE '0173______' OR ani LIKE '03______' OR ani LIKE '3______' OR
  ani LIKE '00175______' OR ani LIKE '0175______' OR ani LIKE '05______' OR ani LIKE '5______' 
 );

DELETE FROM irda.irda_200806_askr_filtered 
 WHERE ddi IN('175', '190', '191', '193', '194', '196', '197', '99175', '99190', '99191', '99193', '99194', '99196', '99197') AND 
 (ani LIKE '00172_____' OR ani LIKE '0172_____' OR ani LIKE '02_____' OR ani LIKE '2_____' OR 
  ani LIKE '00173_____' OR ani LIKE '0173_____' OR ani LIKE '03_____' OR ani LIKE '3_____' OR
  ani LIKE '00175_____' OR ani LIKE '0175_____' OR ani LIKE '05_____' OR ani LIKE '5_____' OR
  ani LIKE '00178______' OR ani LIKE '0178______' OR ani LIKE '08______' OR ani LIKE '8______' 
 );

DELETE FROM irda.irda_200806_askr_filtered 
 WHERE ddi IN('175', '190', '191', '193', '194', '196', '197', '99175', '99190', '99191', '99193', '99194', '99196', '99197') AND 
 (ani LIKE '00172____' OR ani LIKE '0172____' OR ani LIKE '02____' OR ani LIKE '2____' OR 
  ani LIKE '00173____' OR ani LIKE '0173____' OR ani LIKE '03____' OR ani LIKE '3____' OR
  ani LIKE '00175____' OR ani LIKE '0175____' OR ani LIKE '05____' OR ani LIKE '5____' OR
  ani LIKE '00178_____' OR ani LIKE '0178_____' OR ani LIKE '08_____' OR ani LIKE '8_____' 
 );



OPTIMIZE TABLE irda.irda_200806_askr_filtered;



#-----------------------------
#-------проверка списка-------
#-----------------------------

#SELECT ddi, COUNT(*) FROM irda.irda_200806_askr_filtered GROUP BY ddi;
#SELECT ani, COUNT(*) FROM irda.irda_200806_askr_filtered GROUP BY ani;