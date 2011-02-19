USE ARJ;
DELETE FROM arj.new_report;
#009
INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar) 
SELECT DISTINCT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'70',LEFT(ddi,3),'3' FROM irda.irda_200703 i 
WHERE ((LEFT(ddi,3)='009') OR ((LEFT(ddi,3)='109') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND (ani LIKE '00175______')
ORDER BY datum,vrijeme;
#090
INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar) 
SELECT DISTINCT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1' FROM irda.irda_200703 i 
WHERE ((LEFT(ddi,3)='090') OR ((LEFT(ddi,3)='190') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND (ani LIKE '00175______')
ORDER BY datum,vrijeme;
#093
INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar) 
SELECT DISTINCT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1' FROM irda.irda_200703 i 
WHERE ((LEFT(ddi,3)='093') OR ((LEFT(ddi,3)='193') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND (ani LIKE '00175______')
ORDER BY datum,vrijeme;
#088
INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'5',LEFT(ddi,3),'3'
FROM irda.irda_200703
WHERE ((LEFT(ddi,3)='088') OR ((LEFT(ddi,3)='188') AND datum='20070331')) AND (dur>0) AND (v_mreza>'') AND (ani LIKE '00175______')
ORDER BY datum,vrijeme;
#091,094,096,097,075
INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"), TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1'
FROM irda.irda_200703 i WHERE (((LEFT(ddi,3)='075') OR ((LEFT(ddi,3)='175') AND datum='20070331')) OR ((LEFT(ddi,3)='091') OR ((LEFT(ddi,3)='191') AND datum='20070331')) OR ((LEFT(ddi,3)='094') OR ((LEFT(ddi,3)='194') AND datum='20070331')) OR ((LEFT(ddi,3)='096') OR ((LEFT(ddi,3)='196') AND datum='20070331')) OR ((LEFT(ddi,3)='097') OR ((LEFT(ddi,3)='197') AND datum='20070331'))) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND (ani LIKE '00175______') ORDER BY ddi,datum,vrijeme;
#092
INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'35',LEFT(ddi,3),'3'
FROM irda.irda_200703 i 
WHERE ((LEFT(ddi,3)='092') OR ((LEFT(ddi,3)='192') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND (ani LIKE '00175______')
ORDER BY ddi,datum,vrijeme;
#095
INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'35',LEFT(ddi,3),'3'
FROM irda.irda_200703 i 
WHERE ((LEFT(ddi,3)='095') OR ((LEFT(ddi,3)='195') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND (ani LIKE '00175______')
ORDER BY ddi,datum,vrijeme;

SELECT cod,type,cat,numA,numB,data,time,dur,'0',CONCAT('17',LEFT(t_serv,1),'09'),t_serv,t_tar,''
INTO OUTFILE 'd:\\ASKR\\200703\\spr5003.009' FIELDS TERMINATED BY '|'  LINES TERMINATED BY '\n'
FROM arj.new_report r
LEFT JOIN arj.black b ON (r.numA LIKE b.phn)
WHERE b.phn IS null;

SELECT t_serv,count(*),sum(dur)
INTO OUTFILE 'd:\\ASKR\\200703\\spr5003.sta' FIELDS TERMINATED BY '|'  LINES TERMINATED BY '\n'
FROM arj.new_report r
LEFT JOIN arj.black b ON (r.numA LIKE b.phn)
WHERE b.phn IS null
GROUP BY t_serv;







DELETE FROM arj.new_report;

#009
INSERT into arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'70',LEFT(ddi,3),'3'
FROM irda.irda_200703 i 
WHERE ((LEFT(ddi,3)='009') OR ((LEFT(ddi,3)='109') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '2______') OR (ani LIKE '00173______') OR (ani LIKE '03______') OR (ani LIKE '3______') OR (ani LIKE '00178______' OR ani LIKE '08______' OR ani LIKE '8______' OR ani LIKE '%8______')) 
ORDER BY datum,vrijeme;

INSERT into arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,6),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'70',LEFT(ddi,3),'3'
FROM irda.irda_200703 i 
WHERE ((LEFT(ddi,3)='009') OR ((LEFT(ddi,3)='109') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '00172_____') OR (ani LIKE '02_____') OR (ani LIKE '00173_____') OR (ani LIKE '03_____')) 
ORDER BY datum,vrijeme;

INSERT into arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,5),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'70',LEFT(ddi,3),'3'
FROM irda.irda_200703 i 
WHERE ((LEFT(ddi,3)='009') OR ((LEFT(ddi,3)='109') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '00172____') OR (ani LIKE '02____') OR (ani LIKE '00173____') OR (ani LIKE '03____')) 
ORDER BY datum,vrijeme;


#090
INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1'
FROM irda.irda_200703 i
WHERE ((LEFT(ddi,3)='090') OR ((LEFT(ddi,3)='190') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '2______') OR (ani LIKE '00173______') OR (ani LIKE '03______') OR (ani LIKE '3______') OR (ani LIKE '00178______' OR ani LIKE '08______' OR ani LIKE '8______' OR ani LIKE '%8______')) 
ORDER BY datum,vrijeme;

INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,6),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1'
FROM irda.irda_200703 i
WHERE ((LEFT(ddi,3)='090') OR ((LEFT(ddi,3)='190') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '00172_____') OR (ani LIKE '02_____') OR (ani LIKE '00173_____') OR (ani LIKE '03_____')) 
ORDER BY datum,vrijeme;

INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,5),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1'
FROM irda.irda_200703 i
WHERE ((LEFT(ddi,3)='090') OR ((LEFT(ddi,3)='190') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '00172____') OR (ani LIKE '02____') OR (ani LIKE '00173____') OR (ani LIKE '03____')) 
ORDER BY datum,vrijeme;


#093
INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1'
FROM irda.irda_200703 i
WHERE ((LEFT(ddi,3)='093') OR ((LEFT(ddi,3)='193') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '2______') OR (ani LIKE '00173______') OR (ani LIKE '03______') OR (ani LIKE '3______') OR (ani LIKE '00178______' OR ani LIKE '08______' OR ani LIKE '8______' OR ani LIKE '%8______')) 
ORDER BY datum,vrijeme;

INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,6),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1'
FROM irda.irda_200703 i
WHERE ((LEFT(ddi,3)='093') OR ((LEFT(ddi,3)='193') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '00172_____') OR (ani LIKE '02_____') OR (ani LIKE '00173_____') OR (ani LIKE '03_____')) 
ORDER BY datum,vrijeme;

INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,5),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1'
FROM irda.irda_200703 i
WHERE ((LEFT(ddi,3)='093') OR ((LEFT(ddi,3)='193') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '00172____') OR (ani LIKE '02____') OR (ani LIKE '00173____') OR (ani LIKE '03____')) 
ORDER BY datum,vrijeme;


#088
INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'5',LEFT(ddi,3),'3'
FROM irda.irda_200703
WHERE ((LEFT(ddi,3)='088') OR ((LEFT(ddi,3)='188') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (dur>0) AND (v_mreza>'') AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '2______') OR (ani LIKE '00173______') OR (ani LIKE '03______') OR (ani LIKE '3______') OR (ani LIKE '00178______' OR ani LIKE '08______' OR ani LIKE '8______' OR ani LIKE '%8______')) 
ORDER BY datum,vrijeme;

INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,6),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'5',LEFT(ddi,3),'3'
FROM irda.irda_200703
WHERE ((LEFT(ddi,3)='088') OR ((LEFT(ddi,3)='188') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (dur>0) AND (v_mreza>'') AND ((ani LIKE '00172_____') OR (ani LIKE '02_____') OR (ani LIKE '00173_____') OR (ani LIKE '03_____')) 
ORDER BY datum,vrijeme;

INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,5),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'5',LEFT(ddi,3),'3'
FROM irda.irda_200703
WHERE ((LEFT(ddi,3)='088') OR ((LEFT(ddi,3)='188') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (dur>0) AND (v_mreza>'') AND ((ani LIKE '00172____') OR (ani LIKE '02____') OR (ani LIKE '00173____') OR (ani LIKE '03____')) 
ORDER BY datum,vrijeme;


#091,094,096,097,075
INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1'
FROM irda.irda_200703 i 
WHERE (((LEFT(ddi,3)='075') OR ((LEFT(ddi,3)='175') AND datum='20070331')) OR ((LEFT(ddi,3)='091') OR ((LEFT(ddi,3)='191') AND datum='20070331')) OR ((LEFT(ddi,3)='094') OR ((LEFT(ddi,3)='194') AND datum='20070331')) OR ((LEFT(ddi,3)='096') OR ((LEFT(ddi,3)='196') AND datum='20070331')) OR ((LEFT(ddi,3)='097') OR ((LEFT(ddi,3)='197') AND datum='20070331'))) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '2______') OR (ani LIKE '00173______') OR (ani LIKE '03______') OR (ani LIKE '3______') OR (ani LIKE '00178______' OR ani LIKE '08______' OR ani LIKE '8______' OR ani LIKE '%8______')) 
ORDER BY ddi,datum,vrijeme;

INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,6),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1'
FROM irda.irda_200703 i 
WHERE (((LEFT(ddi,3)='075') OR ((LEFT(ddi,3)='175') AND datum='20070331')) OR ((LEFT(ddi,3)='091') OR ((LEFT(ddi,3)='191') AND datum='20070331')) OR ((LEFT(ddi,3)='094') OR ((LEFT(ddi,3)='194') AND datum='20070331')) OR ((LEFT(ddi,3)='096') OR ((LEFT(ddi,3)='196') AND datum='20070331')) OR ((LEFT(ddi,3)='097') OR ((LEFT(ddi,3)='197') AND datum='20070331'))) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172_____') OR (ani LIKE '02_____') OR (ani LIKE '00173_____') OR (ani LIKE '03_____')) 
ORDER BY ddi,datum,vrijeme;

INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,5),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1'
FROM irda.irda_200703 i 
WHERE (((LEFT(ddi,3)='075') OR ((LEFT(ddi,3)='175') AND datum='20070331')) OR ((LEFT(ddi,3)='091') OR ((LEFT(ddi,3)='191') AND datum='20070331')) OR ((LEFT(ddi,3)='094') OR ((LEFT(ddi,3)='194') AND datum='20070331')) OR ((LEFT(ddi,3)='096') OR ((LEFT(ddi,3)='196') AND datum='20070331')) OR ((LEFT(ddi,3)='097') OR ((LEFT(ddi,3)='197') AND datum='20070331'))) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172____') OR (ani LIKE '02____') OR (ani LIKE '00173____') OR (ani LIKE '03____')) 
ORDER BY ddi,datum,vrijeme;


#092
INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'35',LEFT(ddi,3),'3'
FROM irda.irda_200703 i 
WHERE ((LEFT(ddi,3)='092') OR ((LEFT(ddi,3)='192') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '2______') OR (ani LIKE '00173______') OR (ani LIKE '03______') OR (ani LIKE '3______') OR (ani LIKE '00178______' OR ani LIKE '08______' OR ani LIKE '8______' OR ani LIKE '%8______')) 
ORDER BY ddi,datum,vrijeme;

INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,6),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'35',LEFT(ddi,3),'3'
FROM irda.irda_200703 i 
WHERE ((LEFT(ddi,3)='092') OR ((LEFT(ddi,3)='192') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172_____') OR (ani LIKE '02_____') OR (ani LIKE '00173_____') OR (ani LIKE '03_____')) 
ORDER BY ddi,datum,vrijeme;

INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,5),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'35',LEFT(ddi,3),'3'
FROM irda.irda_200703 i 
WHERE ((LEFT(ddi,3)='092') OR ((LEFT(ddi,3)='192') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172____') OR (ani LIKE '02____') OR (ani LIKE '00173____') OR (ani LIKE '03____')) 
ORDER BY ddi,datum,vrijeme;


#095
INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'35',LEFT(ddi,3),'3'
FROM irda.irda_200703 i 
WHERE ((LEFT(ddi,3)='095') OR ((LEFT(ddi,3)='195') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '2______') OR (ani LIKE '00173______') OR (ani LIKE '03______') OR (ani LIKE '3______') OR (ani LIKE '00178______' OR ani LIKE '08______' OR ani LIKE '8______' OR ani LIKE '%8______')) 
ORDER BY ddi,datum,vrijeme;

INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,6),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'35',LEFT(ddi,3),'3'
FROM irda.irda_200703 i 
WHERE ((LEFT(ddi,3)='095') OR ((LEFT(ddi,3)='195') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172_____') OR (ani LIKE '02_____') OR (ani LIKE '00173_____') OR (ani LIKE '03_____')) 
ORDER BY ddi,datum,vrijeme;

INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT DISTINCT RIGHT(ani,5),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'35',LEFT(ddi,3),'3'
FROM irda.irda_200703 i 
WHERE ((LEFT(ddi,3)='095') OR ((LEFT(ddi,3)='195') AND datum='20070331')) AND (!((datum='20070331') AND (vrijeme BETWEEN '00:00:00' AND '05:59:59'))) AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172____') OR (ani LIKE '02____') OR (ani LIKE '00173____') OR (ani LIKE '03____')) 
ORDER BY ddi,datum,vrijeme;


#088
SELECT cod,type,cat,numA,numB,data,time,dur,'0',CONCAT('17',LEFT(t_serv,1),'09'),t_serv,t_tar,''
INTO OUTFILE 'd:\\ASKR\\200703\\088.unl' FIELDS TERMINATED BY '|'  LINES TERMINATED BY '\n'
FROM arj.new_report r
LEFT JOIN arj.black b on r.numA LIKE b.phn
WHERE b.phn IS null and ((t_serv='088') OR (t_serv='188'));

#OTHER
SELECT cod,type,cat,numA,numB,data,time,dur,'0',CONCAT('17',LEFT(t_serv,1),'09'),t_serv,t_tar,''
INTO OUTFILE 'd:\\ASKR\\200703\\009.unl' FIELDS TERMINATED BY '|'  LINES TERMINATED BY '\n'
FROM arj.new_report r
LEFT JOIN arj.black b on r.numA LIKE b.phn
WHERE b.phn IS null AND t_serv!='088' AND t_serv!='188';

SELECT t_serv,count(*),sum(dur)
INTO OUTFILE 'd:\\ASKR\\200703\\009.sta' FIELDS TERMINATED BY '|'  LINES TERMINATED BY '\n'
FROM arj.new_report r
LEFT JOIN arj.black b on r.numA LIKE b.phn
WHERE b.phn IS null 
GROUP BY t_serv;
