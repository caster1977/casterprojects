USE ARJ;
DELETE FROM arj.new_report;
#009
INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar) 
SELECT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'70',LEFT(ddi,3),'3' FROM irda.irda_200607 i 
WHERE (LEFT(ddi,3)='009') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND (ani LIKE '00175______')
ORDER BY datum,vrijeme;
#090
INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar) 
SELECT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1' FROM irda.irda_200607 i 
WHERE (LEFT(ddi,3)='090') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND (ani LIKE '00175______')
ORDER BY datum,vrijeme;
#093
INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar) 
SELECT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1' FROM irda.irda_200607 i 
WHERE (LEFT(ddi,3)='093') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND (ani LIKE '00175______')
ORDER BY datum,vrijeme;
#088
INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'5',LEFT(ddi,3),'3'
FROM irda.irda_200607
WHERE (LEFT(ddi,3)='088') AND (dur>0) AND (v_mreza>'') AND (ani LIKE '00175______')
ORDER BY datum,vrijeme;
#091,094,096,097,075
INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar)
SELECT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"), TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1'
FROM irda.irda_200607 i 
WHERE ((LEFT(ddi,3)='075') OR (LEFT(ddi,3)='091') OR (LEFT(ddi,3)='094') OR (LEFT(ddi,3)='096') OR (LEFT(ddi,3)='097')) AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND (ani LIKE '00175______')
ORDER BY ddi,datum,vrijeme;
#092
INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'35',LEFT(ddi,3),'3'
FROM irda.irda_200607 i 
WHERE (LEFT(ddi,3)='092') AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND (ani LIKE '00175______')
ORDER BY ddi,datum,vrijeme;
#095
INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'35',LEFT(ddi,3),'3'
FROM irda.irda_200607 i 
WHERE (LEFT(ddi,3)='095') AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND (ani LIKE '00175______')
ORDER BY ddi,datum,vrijeme;

SELECT cod,type,cat,numA,numB,data,time,dur,'0','17009',t_serv,t_tar,''
INTO OUTFILE 'd:\\ASKR\\200607\\spr5007.009' FIELDS TERMINATED BY '|'  LINES TERMINATED BY '\n'
FROM arj.new_report r
LEFT JOIN arj.black b ON (r.numA LIKE b.phn)
WHERE b.phn IS null;

SELECT t_serv,count(*),sum(dur)
INTO OUTFILE 'd:\\ASKR\\200607\\spr5007.sta' FIELDS TERMINATED BY '|'  LINES TERMINATED BY '\n'
FROM arj.new_report r
LEFT JOIN arj.black b ON (r.numA LIKE b.phn)
WHERE b.phn IS null
GROUP BY t_serv;

DELETE FROM arj.new_report;
#009
INSERT into arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'70',LEFT(ddi,3),'3'
FROM irda.irda_200607 i 
WHERE (LEFT(ddi,3)='009') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND (ani LIKE '00172______' OR ani LIKE '02______') 
ORDER BY datum,vrijeme;
#090
INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar)
SELECT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1'
FROM irda.irda_200607 i
WHERE (LEFT(ddi,3)='090') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND (ani LIKE '00172______' OR ani LIKE '02______') 
ORDER BY datum,vrijeme;
#093
INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar)
SELECT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1'
FROM irda.irda_200607 i
WHERE (LEFT(ddi,3)='093') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND (ani LIKE '00172______' OR ani LIKE '02______') 
ORDER BY datum,vrijeme;
#088
INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'5',LEFT(ddi,3),'3'
FROM irda.irda_200607
WHERE (LEFT(ddi,3)='088') AND (dur>0) AND (v_mreza>'') AND ((ani LIKE '00172______') OR (ani LIKE '02______'))
ORDER BY datum,vrijeme;
#091,094,096,097,075
INSERT INTO arj.new_report(numA,data,time,dur,price,t_serv,t_tar)
SELECT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),TIME_FORMAT(SEC_TO_TIME(ceiling(dur/60)*60),"%H%i"),'22',LEFT(ddi,3),'1'
FROM irda.irda_200607 i 
WHERE ((LEFT(ddi,3)='075') OR (LEFT(ddi,3)='091') OR (LEFT(ddi,3)='094') OR (LEFT(ddi,3)='096') OR (LEFT(ddi,3)='097')) AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______'))
ORDER BY ddi,datum,vrijeme;
#092
INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'35',LEFT(ddi,3),'3'
FROM irda.irda_200607 i 
WHERE (LEFT(ddi,3)='092') AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______'))
ORDER BY ddi,datum,vrijeme;
#095
INSERT INTO arj.new_report(numA,data,time,price,t_serv,t_tar)
SELECT RIGHT(ani,7),DATE_FORMAT(datum,"%d%m%y"),TIME_FORMAT(vrijeme,"%H%i"),'35',LEFT(ddi,3),'3'
FROM irda.irda_200607 i 
WHERE (LEFT(ddi,3)='095') AND (dur>0) AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______'))
ORDER BY ddi,datum,vrijeme;
#088
SELECT cod,type,cat,numA,numB,data,time,dur,'0',v_serv,t_serv,t_tar,''
INTO OUTFILE 'd:\\ASKR\\200607\\088.unl' FIELDS TERMINATED BY '|'  LINES TERMINATED BY '\n'
FROM arj.new_report r
LEFT JOIN arj.black b on r.numA LIKE b.phn
WHERE b.phn IS null and t_serv='088';
#OTHER
SELECT cod,type,cat,numA,numB,data,time,dur,'0',v_serv,t_serv,t_tar,''
INTO OUTFILE 'd:\\ASKR\\200607\\009.unl' FIELDS TERMINATED BY '|'  LINES TERMINATED BY '\n'
FROM arj.new_report r
LEFT JOIN arj.black b on r.numA LIKE b.phn
WHERE b.phn IS null and t_serv!='088';

SELECT t_serv,count(*),sum(dur)
INTO OUTFILE 'd:\\ASKR\\200607\\009.sta' FIELDS TERMINATED BY '|'  LINES TERMINATED BY '\n'
FROM arj.new_report r
LEFT JOIN arj.black b on r.numA LIKE b.phn
WHERE b.phn IS null 
GROUP BY t_serv;
