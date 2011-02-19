<?
// русскоязычные наименования месяцев в именительном падеже
$months[1]="январь"; 
$months[2]="февраль"; 
$months[3]="март"; 
$months[4]="апрель"; 
$months[5]="май"; 
$months[6]="июнь"; 
$months[7]="июль"; 
$months[8]="август"; 
$months[9]="сентябрь"; 
$months[10]="октябрь"; 
$months[11]="ноябрь"; 
$months[12]="декабрь";

// русскоязычные наименования месяцев в родительном падеже
$months2[1]="января"; 
$months2[2]="февраля"; 
$months2[3]="марта"; 
$months2[4]="апреля"; 
$months2[5]="мая"; 
$months2[6]="июня"; 
$months2[7]="июля"; 
$months2[8]="августа"; 
$months2[9]="сентября"; 
$months2[10]="октября"; 
$months2[11]="ноября"; 
$months2[12]="декабря";

// строковое представление кварталов латинскими цифрами
$quartals[1]="I";
$quartals[2]="II";
$quartals[3]="III";
$quartals[4]="IV";

// сводный массив по отчётам
$reports[1]=array("Наименование"=>"Формирование отчёта <B>&laquo;Статистика работы услуг СИЦ&raquo;</B>","Комментарии"=>"Данный отчёт отправляется дежурным инженером ежедневно за прошедший день, по понедельникам за прошедшую неделю, а также 1-го числа каждого месяца за прошедший месяц в виде сохранённого файла <B>*.htm</B> на адрес электронной почты <B>irai@mgts.by</B><!-- и <B>anna@mgts.by</B> --> специалисту отдела маркетинга (Илюк&nbsp;И.М.), а также печатается в одном экземпляре и предоставляется начальнику СИЦ (Степановой&nbsp;М.Н.) каждый понедельник за прошедшую неделю и 1-го числа каждого месяца за прошедший месяц.");
$reports[2]=array("Наименование"=>"Формирование отчёта &laquo;Статистика работы телефонистов СИУ &laquo;090&raquo; и &laquo;093&raquo;&raquo;","Комментарии"=>"");
$reports[3]=array("Наименование"=>"Формирование отчёта &laquo;Статистика работы телефонисток&raquo;","Комментарии"=>"");
$reports[4]=array("Наименование"=>"Формирование отчёта &laquo;Статистика Content Provider для Гидрометцентра&raquo;","Комментарии"=>"Данный отчёт формируется дежурным инженером каждый понедельник за прошедшую неделю и подшивается в специально отведённую для этого папку в одном печатном экземпляре.");
$reports[5]=array("Наименование"=>"Формирование отчёта &laquo;Квартальный отчёт по услуге СИЦ &laquo;009&raquo;&raquo;","Комментарии"=>"Данный отчёт формируется дежурным инженером 1-го числа следующего за отчётным кварталом месяца и предоставляется начальнику СИЦ (Степановой М.Н.) в одном печатном экземпляре.");
$reports[6]=array("Наименование"=>"Формирование отчёта <B>&laquo;Сведения о входящем трафике от сети СП &laquo;МЦС&raquo; за месяц&raquo;</B>","Комментарии"=>"");
$reports[7]=array("Наименование"=>"Формирование отчёта <B>&laquo;Сведения о входящем трафике от сети СООО &laquo;МТС&raquo; за месяц&raquo;</B>","Комментарии"=>"");
$reports[8]=array("Наименование"=>"Корректировка тарифов услуг СИЦ","Комментарии"=>"");
$reports[9]=array("Наименование"=>"Формирование таблицы irda_* за указанный месяц","Комментарии"=>"Данный пункт меню позволяет сформировать общую таблицу входящих звонков на платформу за указанный месяц - <B>irda_<I>ггггмм</I></B>, используя таблицы звонков <B>ird_<I>ггггммдд</I></B> за каждый отдельный день");
$reports[10]=array("Наименование"=>"Формирование таблицы orda_* за указанный месяц","Комментарии"=>"Данный пункт меню позволяет сформировать общую таблицу исходящих звонков с платформы за указанный месяц - <B>orda_<I>ггггмм</I></B>, используя таблицы звонков <B>ord_<I>ггггммдд</I></B> за каждый отдельный день");
$reports[11]=array("Наименование"=>"Снятие оплаты за звонок на службы СИЦ","Комментарии"=>"Данный пункт меню позволяет произвести снятие оплаты указанного звонка на службы СИЦ с указанного номера телефона за указанную дату");
$reports[12]=array("Наименование"=>"Формирование отчёта &laquo;Статистика по количеству соединений по наведённой справке&raquo;","Комментарии"=>"Данный отчёт формируется дежурным инженером 1-го числа каждого месяца и предоставляется начальнику СИЦ (Степановой М.Н.) в одном печатном экземпляре.");
$reports[13]=array("Наименование"=>"Формирование отчёта по &laquo;зависшим&raquo; абонентам за месяц","Комментарии"=>"Данный пункт меню позволяет сформировать статистический отчёт по &laquo;зависшим&raquo; абонентам за указанный месяц с указанием личного номера телефониста и количества абонентов");
$reports[14]=array("Наименование"=>"Формирование ответа на запрос ИРЦ о предоставлении информации о наличии соединений","Комментарии"=>"Данный пункт меню позволяет сформировать ответ на запрос ИРЦ о предоставлении информации о наличии соединений по услугам СИЦ по указанным номерам телефонов");
$reports[15]=array("Наименование"=>"Формирование отчёта &laquo;Статистика работы телефонистов СИУ &laquo;090&raquo; и &laquo;093&raquo;&raquo; (старая форма)","Комментарии"=>"");

// массив наименований отчётов
$repnames[1]="Статистика работы услуг СИЦ";
$repnames[2]="Статистика работы услуг СИЦ (мобильные операторы)";
$repnames[3]="Статистика работы телефонисток";
$repnames[4]="Статистика Content Provider для Гидрометцентра";
$repnames[5]="Квартальный отчёт по услуге СИЦ &laquo;009&raquo;";
$repnames[6]="Сведения о входящем трафике от сети СП &laquo;МЦС&raquo; за месяц";
$repnames[7]="Сведения о входящем трафике от сети СООО &laquo;МТС&raquo; за месяц";
$repnames[9]="Формирование таблицы irda_* за указанный месяц";
$repnames[10]="Формирование таблицы orda_* за указанный месяц";
$repnames[12]="Статистика по количеству соединений по наведенной справке";
$repnames[13]="Сведения по &laquo;зависшим&raquo; абонентам за месяц";

$workedreps[1]=1;
$workedreps[2]=1;
$workedreps[3]=0;
$workedreps[4]=1;
$workedreps[5]=1;
$workedreps[6]=0;
$workedreps[7]=0;
$workedreps[8]=0;
$workedreps[9]=1;
$workedreps[10]=1;
$workedreps[11]=1;
$workedreps[12]=1;
$workedreps[13]=0;
$workedreps[14]=1;
$workedreps[15]=1;

// массив комментариев к отчётам
$repcomments[1]="Данный отчёт отправляется дежурным инженером ежедневно за прошедший день, по понедельникам за прошедшую неделю, а также 1-го числа каждого месяца за прошедший месяц в виде сохранённого файла <B>*.htm</B> на адрес электронной почты <B>irai@mgts.by</B><!-- и <B>anna@mgts.by</B> --> специалисту отдела маркетинга (Илюк&nbsp;И.М.), а также печатается в одном экземпляре и предоставляется начальнику СИЦ (Степановой&nbsp;М.Н.) каждый понедельник за прошедшую неделю и 1-го числа каждого месяца за прошедший месяц.";
$repcomments[4]="Данный отчёт формируется дежурным инженером каждый понедельник за прошедшую неделю и подшивается в специально отведённую для этого папку в одном печатном экземпляре.";
$repcomments[5]="Данный отчёт формируется дежурным инженером 1-го числа следующего за отчётным кварталом месяца и предоставляется начальнику СИЦ (Степановой М.Н.) в одном печатном экземпляре.";
$repcomments[9]="Данный пункт меню позволяет сформировать общую таблицу входящих звонков на платформу за указанный месяц - <B>irda_<I>ггггмм</I></B>, используя таблицы звонков <B>ird_<I>ггггммдд</I></B> за каждый отдельный день";
$repcomments[10]="Данный пункт меню позволяет сформировать общую таблицу исходящих звонков с платформы за указанный месяц - <B>orda_<I>ггггмм</I></B>, используя таблицы звонков <B>ord_<I>ггггммдд</I></B> за каждый отдельный день";

// строковое предствление списка услуг СИЦ
$servicelist[]="009"; 
$servicelist[]="075"; 
$servicelist[]="088"; 
$servicelist[]="090"; 
$servicelist[]="091"; 
$servicelist[]="092"; 
$servicelist[]="093"; 
$servicelist[]="094"; 
$servicelist[]="095"; 
$servicelist[]="096"; 
$servicelist[]="097"; 
$servicelist[]="098"; 
$servicelist[]="099"; 
$servicelist[]="9900911";
$servicelist[]="9909111";
$servicelist[]="9909911";
$servicelist[]="99075";
$servicelist[]="99088";
$servicelist[]="99090";
$servicelist[]="99091";
$servicelist[]="99092";
$servicelist[]="99093";
$servicelist[]="99094";
$servicelist[]="99095";
$servicelist[]="99096";
$servicelist[]="99097";

// список наименований услуг СИЦ
$services["009"]="Платная справка"; 
$services["075"]="Тарифы жилищно-коммунального хозяйства"; 
$services["088"]="Служба точного времени"; 
$services["090"]="ГорИнфоСервис";
$services["091"]="Киноафиша"; 
$services["092"]="Посмеёмся"; 
$services["093"]="Отдых и развлечения"; 
$services["094"]="Гороскоп"; 
$services["095"]="Прогноз погоды"; 
$services["096"]="Сказка по телефону"; 
$services["097"]="Именины"; 
$services["098"]="Телефонный центр обслуживания клиентов"; 
$services["099"]="Бесплатная справка"; 
$services["9900911"]="Межгород, платная справка"; 
$services["9909111"]="Межгород, бесплатная справка"; 
$services["9909911"]="Межгород, бесплатная справка";
$services["99075"]="Межгород, тарифы жилищно-коммунального хозяйства"; 
$services["99088"]="Межгород, служба точного времени"; 
$services["99090"]="Межгород, ГорИнфоСервис"; 
$services["99091"]="Межгород, киноафиша"; 
$services["99092"]="Межгород, Посмеёмся"; 
$services["99093"]="Межгород, Отдых и развлечения"; 
$services["99094"]="Межгород, гороскоп"; 
$services["99095"]="Межгород, прогноз погоды"; 
$services["99096"]="Межгород, сказки для детей"; 
$services["99097"]="Межгород, именины"; 

$abonent_types["МГТС"]="((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '2______') OR (ani LIKE '00175______') OR (ani LIKE '00178______') OR (ani LIKE '08______') OR (ani LIKE '8______') OR (ani LIKE '%8______') OR (ani LIKE '00172_____') OR (ani LIKE '02_____') OR (ani LIKE '00172____') OR (ani LIKE '02____'))";
$abonent_types["МЦС"]="((ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0291______') OR (ani LIKE '0299______'))";
$abonent_types["МТС"]="((ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______') OR (ani LIKE '0298______'))";
$abonent_types["БеСТ"]="(ani LIKE '0259______')";
$abonent_types["БелСел"]="(ani LIKE '00294______')";
$abonent_types["прочие"]="(!((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '2______') OR (ani LIKE '00175______') OR (ani LIKE '00178______') OR (ani LIKE '08______') OR (ani LIKE '8______') OR (ani LIKE '%8______') OR (ani LIKE '00172_____') OR (ani LIKE '02_____') OR (ani LIKE '00172____') OR (ani LIKE '02____') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0291______') OR (ani LIKE '0299______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______') OR (ani LIKE '0298______') OR (ani LIKE '00294______') OR (ani LIKE '0259______')))";

$service_types["009"]="voice";
$service_types["075"]="auto";
$service_types["088"]="auto";
$service_types["090"]="voice";
$service_types["091"]="auto";
$service_types["092"]="auto";
$service_types["093"]="voice";
$service_types["094"]="auto";
$service_types["095"]="auto";
$service_types["096"]="auto";
$service_types["097"]="auto";
$service_types["098"]="voice";
$service_types["099"]="voice";
$service_types["9900911"]="voice";
$service_types["9909111"]="voice";
$service_types["9909911"]="voice";
$service_types["99075"]="auto";
$service_types["99088"]="auto";
$service_types["99090"]="voice";
$service_types["99091"]="auto";
$service_types["99092"]="auto";
$service_types["99093"]="voice";
$service_types["99094"]="auto";
$service_types["99095"]="auto";
$service_types["99096"]="auto";
$service_types["99097"]="auto";


// запросы на обслуживание
$service_servedcondition["009"]="(LEFT(ddi,3)='009') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))";
$service_servedcondition["075"]="(dur>0) AND (LEFT(ddi,3)='075') AND (v_mreza>'')";
$service_servedcondition["088"]="(dur>0) AND (LEFT(ddi,3)='088') AND (v_mreza>'')";
$service_servedcondition["090"]="(LEFT(ddi,3)='090') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))";
$service_servedcondition["091"]="(dur>0) AND (LEFT(ddi,3)='091') AND (v_mreza>'')";
$service_servedcondition["092"]="(dur>0) AND (LEFT(ddi,3)='092') AND (v_mreza>'')";
$service_servedcondition["093"]="(LEFT(ddi,3)='093') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))";
$service_servedcondition["094"]="(dur>0) AND (LEFT(ddi,3)='094') AND (v_mreza>'')";
$service_servedcondition["095"]="(dur>0) AND (LEFT(ddi,3)='095') AND (v_mreza>'')";
$service_servedcondition["096"]="(dur>0) AND (LEFT(ddi,3)='096') AND (v_mreza>'')";
$service_servedcondition["097"]="(dur>0) AND (LEFT(ddi,3)='097') AND (v_mreza>'')";
$service_servedcondition["098"]="(dur>1) AND ((ddi='098') OR (ddi='001798'))";
$service_servedcondition["099"]="((LEFT(ddi,3)='099') OR (ddi='1111')) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))";
$service_servedcondition["9900911"]="(LEFT(ddi,7)='9900911') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))";
$service_servedcondition["9909111"]="((LEFT(ddi,7)='9909111') OR (ddi='2222')) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))";
$service_servedcondition["9909911"]="(LEFT(ddi,7)='9909911') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))";
$service_servedcondition["99075"]="(dur>0) AND (LEFT(ddi,5)='99075') AND (v_mreza>'')";
$service_servedcondition["99088"]="(dur>0) AND (LEFT(ddi,5)='99088') AND (v_mreza>'')";
$service_servedcondition["99090"]="(LEFT(ddi,5)='99090') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))";
$service_servedcondition["99091"]="(dur>0) AND (LEFT(ddi,5)='99091') AND (v_mreza>'')";
$service_servedcondition["99092"]="(dur>0) AND (LEFT(ddi,5)='99092') AND (v_mreza>'')";
$service_servedcondition["99093"]="(LEFT(ddi,5)='99093') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))";
$service_servedcondition["99094"]="(dur>0) AND (LEFT(ddi,5)='99094') AND (v_mreza>'')";
$service_servedcondition["99095"]="(dur>0) AND (LEFT(ddi,5)='99095') AND (v_mreza>'')";
$service_servedcondition["99096"]="(dur>0) AND (LEFT(ddi,5)='99096') AND (v_mreza>'')";
$service_servedcondition["99097"]="(dur>0) AND (LEFT(ddi,5)='99097') AND (v_mreza>'')";

// запросы на оплату
$service_billingcondition["009"]="(LEFT(ddi,3)='009') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))";
$service_billingcondition["075"]="(dur>0) AND (LEFT(ddi,3)='075') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))";
$service_billingcondition["088"]="(dur>0) AND (LEFT(ddi,3)='088') AND (v_mreza>'') AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))";
$service_billingcondition["090"]="(LEFT(ddi,3)='090') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))";
$service_billingcondition["091"]="(dur>0) AND (LEFT(ddi,3)='091') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))";
$service_billingcondition["092"]="(dur>0) AND (LEFT(ddi,3)='092') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))";
$service_billingcondition["093"]="(LEFT(ddi,3)='093') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))";
$service_billingcondition["094"]="(dur>0) AND (LEFT(ddi,3)='094') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))";
$service_billingcondition["095"]="(dur>0) AND (LEFT(ddi,3)='095') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))";
$service_billingcondition["096"]="(dur>0) AND (LEFT(ddi,3)='096') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))";
$service_billingcondition["097"]="(dur>0) AND (LEFT(ddi,3)='097') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))";
$service_billingcondition["098"]="0";
$service_billingcondition["099"]="0";
$service_billingcondition["9900911"]="0";
$service_billingcondition["9909111"]="0";
$service_billingcondition["9909911"]="0";
$service_billingcondition["99075"]="0";
$service_billingcondition["99088"]="0";
$service_billingcondition["99090"]="0";
$service_billingcondition["99091"]="0";
$service_billingcondition["99092"]="0";
$service_billingcondition["99093"]="0";
$service_billingcondition["99094"]="0";
$service_billingcondition["99095"]="0";
$service_billingcondition["99096"]="0";
$service_billingcondition["99097"]="0";

// сводный массив по услугам (номер, наименование, запрос на обслуживание, запрос на оплату)
$services2[0]=array("Номер"=>"009","Наименование"=>"Платная справка","Запрос на обслуживание"=>"(LEFT(ddi,3)='009') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))","Запрос на оплату"=>"(LEFT(ddi,3)='009') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))");
$services2[1]=array("Номер"=>"075", "Наименование"=>"Тарифы жилищно-коммунального хозяйства","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,3)='075') AND (v_mreza>'')", "Запрос на оплату"=>"(dur>0) AND (LEFT(ddi,3)='075') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))");
$services2[2]=array("Номер"=>"088", "Наименование"=>"Служба точного времени","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,3)='088') AND (v_mreza>'')", "Запрос на оплату"=>"(dur>0) AND (LEFT(ddi,3)='088') AND (v_mreza>'') AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))");
$services2[3]=array("Номер"=>"090", "Наименование"=>"ГорИнфоСервис","Запрос на обслуживание"=>"(LEFT(ddi,3)='090') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))", "Запрос на оплату"=>"(LEFT(ddi,3)='090') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))");
$services2[4]=array("Номер"=>"091", "Наименование"=>"Киноафиша","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,3)='091') AND (v_mreza>'')", "Запрос на оплату"=>"(dur>0) AND (LEFT(ddi,3)='091') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))");
$services2[5]=array("Номер"=>"092", "Наименование"=>"Посмеёмся","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,3)='092') AND (v_mreza>'')", "Запрос на оплату"=>"(dur>0) AND (LEFT(ddi,3)='092') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))");
$services2[6]=array("Номер"=>"093", "Наименование"=>"Отдых и развлечения","Запрос на обслуживание"=>"(LEFT(ddi,3)='093') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))", "Запрос на оплату"=>"(LEFT(ddi,3)='093') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>3) OR (izgnum>'')) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))");
$services2[7]=array("Номер"=>"094", "Наименование"=>"Гороскоп","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,3)='094') AND (v_mreza>'')", "Запрос на оплату"=>"(dur>0) AND (LEFT(ddi,3)='094') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))");
$services2[8]=array("Номер"=>"095", "Наименование"=>"Прогноз погоды","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,3)='095') AND (v_mreza>'')", "Запрос на оплату"=>"(dur>0) AND (LEFT(ddi,3)='095') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))");
$services2[9]=array("Номер"=>"096", "Наименование"=>"Сказки для детей","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,3)='096') AND (v_mreza>'')", "Запрос на оплату"=>"(dur>0) AND (LEFT(ddi,3)='096') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))");
$services2[10]=array("Номер"=>"097", "Наименование"=>"Именины","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,3)='097') AND (v_mreza>'')", "Запрос на оплату"=>"(dur>0) AND (LEFT(ddi,3)='097') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______'))");
$services2[11]=array("Номер"=>"098", "Наименование"=>"Контент-провайдер","Запрос на обслуживание"=>"(dur>1) AND ((ddi='098') OR (ddi='001798'))", "Запрос на оплату"=>"0");
$services2[12]=array("Номер"=>"099", "Наименование"=>"Бесплатная справка","Запрос на обслуживание"=>"((LEFT(ddi,3)='099') OR (ddi='1111')) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))", "Запрос на оплату"=>"0");
$services2[13]=array("Номер"=>"9900911", "Наименование"=>"Межгород, платная справка","Запрос на обслуживание"=>"(LEFT(ddi,7)='9900911') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))", "Запрос на оплату"=>"0");
$services2[14]=array("Номер"=>"9909111", "Наименование"=>"Межгород, бесплатная справка","Запрос на обслуживание"=>"((LEFT(ddi,7)='9909111') OR (ddi='2222')) AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))", "Запрос на оплату"=>"0");
$services2[15]=array("Номер"=>"9909911", "Наименование"=>"Межгород, бесплатная справка","Запрос на обслуживание"=>"(LEFT(ddi,7)='9909911') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))", "Запрос на оплату"=>"0");
$services2[16]=array("Номер"=>"99075", "Наименование"=>"Межгород, тарифы жилищно-коммунального хозяйства","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,5)='99075') AND (v_mreza>'')", "Запрос на оплату"=>"0");
$services2[17]=array("Номер"=>"99088", "Наименование"=>"Межгород, служба точного времени","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,5)='99088') AND (v_mreza>'')", "Запрос на оплату"=>"0");
$services2[18]=array("Номер"=>"99090", "Наименование"=>"Межгород, ГорИнфоСервис","Запрос на обслуживание"=>"(LEFT(ddi,5)='99090') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))", "Запрос на оплату"=>"0");
$services2[19]=array("Номер"=>"99091", "Наименование"=>"Межгород, киноафиша","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,5)='99091') AND (v_mreza>'')", "Запрос на оплату"=>"0");
$services2[20]=array("Номер"=>"99092", "Наименование"=>"Межгород, Посмеёмся","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,5)='99092') AND (v_mreza>'')", "Запрос на оплату"=>"0");
$services2[21]=array("Номер"=>"99093", "Наименование"=>"Межгород, Отдых и развлечения","Запрос на обслуживание"=>"(LEFT(ddi,5)='99093') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=0) OR (izgnum>''))", "Запрос на оплату"=>"0");
$services2[22]=array("Номер"=>"99094", "Наименование"=>"Межгород, гороскоп","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,5)='99094') AND (v_mreza>'')", "Запрос на оплату"=>"0");
$services2[23]=array("Номер"=>"99095", "Наименование"=>"Межгород, прогноз погоды","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,5)='99095') AND (v_mreza>'')", "Запрос на оплату"=>"0");
$services2[24]=array("Номер"=>"99096", "Наименование"=>"Межгород, сказки для детей","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,5)='99096') AND (v_mreza>'')", "Запрос на оплату"=>"0");
$services2[25]=array("Номер"=>"99097", "Наименование"=>"Межгород, именины","Запрос на обслуживание"=>"(dur>0) AND (LEFT(ddi,5)='99097') AND (v_mreza>'')", "Запрос на оплату"=>"0");

// массив ассоциаций номеров услуг номерам элементов массива // необходимо для использования конструкций типа $services2[$service_num_to_array_number["009"]]["Наименование"]
$service_num_to_array_number["009"]=0;
$service_num_to_array_number["075"]=1;
$service_num_to_array_number["088"]=2;
$service_num_to_array_number["090"]=3;
$service_num_to_array_number["091"]=4;
$service_num_to_array_number["092"]=5;
$service_num_to_array_number["093"]=6;
$service_num_to_array_number["094"]=7;
$service_num_to_array_number["095"]=8;
$service_num_to_array_number["096"]=9;
$service_num_to_array_number["097"]=10;
$service_num_to_array_number["098"]=11;
$service_num_to_array_number["099"]=12;
$service_num_to_array_number["9900911"]=13;
$service_num_to_array_number["9909111"]=14;
$service_num_to_array_number["9909911"]=15;
$service_num_to_array_number["99075"]=16;
$service_num_to_array_number["99088"]=17;
$service_num_to_array_number["99090"]=18;
$service_num_to_array_number["99091"]=19;
$service_num_to_array_number["99092"]=20;
$service_num_to_array_number["99093"]=21;
$service_num_to_array_number["99094"]=22;
$service_num_to_array_number["99095"]=23;
$service_num_to_array_number["99096"]=24;
$service_num_to_array_number["99097"]=25;
?>
