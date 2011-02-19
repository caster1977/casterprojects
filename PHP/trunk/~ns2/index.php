<?
session_start();
//if (!session_register("user","password")) die("Не могу зарегестрировать переменные в сессии!");
require ("arrays.inc");
if ($step=="") $step=1;
/*
if (($user=="")||($password=="")||($step=="")):
  session_destroy();
  session_start();
  $step=0;
endif;
*/
if ($rep=="") $rep=1;
if ($step==3)
  $title=$reports[$rep]["Наименование"];
else
  $title="Формирование отчётов по работе справочно-информационного цеха МГТС";
//if (!(($step>=2)&&($step<=5))) $step=1; // если шаг не попадает в промежуток [2..5] - устанавливаем шаг равным 1
if (!(($rep>=1)&&($rep<=count($reports)))) $rep=1; // если отчёт выходит за пределы [1..кол-во отчётов] - устанавливаем отчёт номер 1
// расчет текущей даты
$d=date("d")+0; // определение текущего дня
$m=date("m")+0; // определение текущего месяца
$y=date("Y")+0; // определение текущего года
// расчёт прошлого дня
$ldd=date("d",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,2,2005)-mktime(0,0,0,1,1,2005))))+0; // определение числа вчерашней даты
$ldm=date("m",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,2,2005)-mktime(0,0,0,1,1,2005))))+0; // определение месяца вчерашней даты
$ldy=date("Y",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,2,2005)-mktime(0,0,0,1,1,2005))))+0; // определение года вчерашней даты
// echo "$ldd $ldm $ldy";
// расчёт начального и конечного дня прошедшей недели
$i=date("w")+0; // получение номера дня недели
if ($i==0) $i=7; // корректировка дня недели для расчёта
$lwbd=date("d",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,7+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // расчёт начального дня прошедшёй недели
$lwbm=date("m",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,7+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // расчёт начального месяца прошедшёй недели
$lwby=date("Y",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,7+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // расчёт начального года прошедшёй недели
$lwed=date("d",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,1+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // расчёт конечного дня прошедшёй недели
$lwem=date("m",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,1+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // расчёт конечного месяца прошедшёй недели
$lwey=date("Y",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,1+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // расчёт конечного года прошедшёй недели
// echo "  $lwbd $lwbm $lwby $lwed $lwem $lwey";
// расчёт начального и конечного числа, номера месяа и года прошедшего месяца
$lmbd=1; // установка начальной даты прошедшего месяца на первое число
$lmed=date("d",mktime(1,0,0,date("m"),1,date("Y"))-((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000)))); // получение последней даты прошлого месяца - от первого числа текущего месяца отнимаем один день
$lmm=date("m")-1; // определение прошедшего месяца
if ($lmm==0): $lmm=12; $lmy=date("Y")-1; else: $lmy=date("Y")+0; endif; // корректировка прошедшего месяца и определение года прошедшего месяца
// echo "  $lmbd $lmm $lmy $lmed $lmm $lmy";
// расчёт номера прошедшего квартала, его года в зависимости от номера текущего месяца
$lqbd=1;
switch ($m):
  case 1: case 2: case 3: $lqq=4; $lqy=$y-1; $lqbm=10; $lqem=12; $lqed=31; break;
  case 4: case 5: case 6: $lqq=1; $lqy=$y+0; $lqbm=1; $lqem=3; $lqed=31; break;
  case 7: case 8: case 9: $lqq=2; $lqy=$y+0; $lqbm=4; $lqem=6; $lqed=30; break;
  case 10: case 11: case 12: $lqq=3; $lqy=$y+0; $lqbm=7; $lqem=9; $lqed=30; break;
endswitch;
// echo "  $lqbd $lqbm $lmy $lqed $lqem $lmy";
// расчёт данных для "другого" квартала
if (($aqq=="")||(!(($aqq>=1)&&($aqq<=4)))) $aqq=$lqq; // если не задан номер квартала либо неправильно задан номер квартала, то устанавливаем номер квартала в номер прошедшего квартала
if ($aqy=="") $aqy=$lqy; // если не задан год "другого" квартала, устанавливаем его равным номеру года прошедшего квартала
$aqbd=1;
switch ($aqq):
  case 1: $aqbm=1; $aqem=3; $aqed=31; break;
  case 2: $aqbm=4; $aqem=6; $aqed=30; break;
  case 3: $aqbm=7; $aqem=9; $aqed=30; break;
  case 4: $aqbm=10; $aqem=12; $aqed=31; break;
endswitch;
// расчёт данных для "другого" месяца
if ($amm=="") $amm=$lmm; // если месяц "другого" месяца не указан - установить значение прошлого месяца
if ($amy=="") $amy=$lmy; // если год "другого" месяца не указан - установить значение года прошлого месяца
$ambd=1; // установка начальной даты "другого" месяца на первое число
$i=$amm+1; if ($i==13): $i=1; $j=$amy+1; else: $j=$amy+0; endif; // производим расчёт номера месяца и года, следующего за указанным "другим" месяцем для вычисления последнего числа "другого" месяца
$amed=date("d",mktime(1,0,0,$i,1,$j)-((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000)))); // получение последней даты "другого" месяца - отнимаем один день от первого числа следующего за "другим" месяца
// расчёт данных для "другого" дня
if ($add=="") $add=$ldd; // если начальный день "другого" дня не определён - указываем вчерашний день
if ($adm=="") $adm=$ldm; // если начальный месяц "другого" дня не определён - указываем вчерашний месяц
if ($ady=="") $ady=$ldy; // если начальный год "другого" дня не определён - указываем вчерашний год
// расчёт данных для "другого" периода
if ($abd=="") $abd=$ldd; // если начальный день "другого" периода не определён - указываем вчерашний день
if ($aed=="") $aed=$ldd; // если конечный день "другого" периода не определён - указываем вчерашний день
if ($abm=="") $abm=$ldm; // если начальный месяц "другого" периода не определён - указываем вчерашний месяц
if ($aem=="") $aem=$ldm; // если конечный месяц "другого" периода не определён - указываем вчерашний месяц
if ($aby=="") $aby=$ldy; // если начальный год "другого" периода не определён - указываем вчерашний год
if ($aey=="") $aey=$ldy; // если конечный год "другого" периода не определён - указываем вчерашний год
switch ($step):
/*
  case 0: // $step==0
    require("login.inc");
  break;
*/
  case 1: // $step==1
    require("step1.inc");
  break;
  case 2: // $step==2
    if ($time==""):
      switch ($rep):
        case 1:
        case 2:
        case 3: $time="yesterday"; break;
        case 4: $time="lastweek"; break;
        case 5: $time="lastquart"; break;
        case 6:
        case 7:
        case 8:
        case 9:
        case 10: $time="lastmonth"; break;
        case 11: $time="today"; break;
        case 12: $time="lastmonth"; break;
      endswitch;
    endif;
    if ($action==""): 
      if ($rep==1)
        $action="print";
      elseif (($rep==2)||($rep==3)||($rep==4)||($rep==5)||($rep==6)||($rep==7)||($rep==8)||($rep==12))
        $action="print";
    endif;
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==5))  // указание ориентации страницы для отчётов
      $orientation="книжная";
    elseif (($rep==6)||($rep==7)||($rep==8))
      $orientation="альбомная";
    require("step2.inc");
  break;
  case 3: // $step==3
    if ($time=="lastweek"):
      $startday=$lwbd+0;
      $stopday=$lwed+0;
      $startmonth=$lwbm+0;
      $stopmonth=$lwem+0;
      $startyear=$lwby+0;
      $stopyear=$lwey+0;
    elseif ($time=="today"):
      $startday=$d+0;
      $stopday=$d+0;
      $startmonth=$m+0;
      $stopmonth=$m+0;
      $startyear=$y+0;
      $stopyear=$y+0;
    elseif ($time=="yesterday"):
      $startday=$ldd+0;
      $stopday=$ldd+0;
      $startmonth=$ldm+0;
      $stopmonth=$ldm+0;
      $startyear=$ldy+0;
      $stopyear=$ldy+0;
    elseif ($time=="lastmonth"):
      $startday=$lmbd+0;
      $stopday=$lmed+0;
      $startmonth=$lmm+0;
      $stopmonth=$lmm+0;
      $startyear=$lmy+0;
      $stopyear=$lmy+0;
    elseif ($time=="anotherday"):
      $startday=$add+0;
      $stopday=$add+0;
      $startmonth=$adm+0;
      $stopmonth=$adm+0;
      $startyear=$ady+0;
      $stopyear=$ady+0;
    elseif ($time=="anothermonth"):
      $startday=$ambd+0;
      $stopday=$amed+0;
      $startmonth=$amm+0;
      $stopmonth=$amm+0;
      $startyear=$amy+0;
      $stopyear=$amy+0;
    elseif ($time=="another"):
      $startday=$abd+0;
      $stopday=$aed+0;
      $startmonth=$abm+0;
      $stopmonth=$aem+0;
      $startyear=$aby+0;
      $stopyear=$aey+0;
    endif;
    if ($rep<10):
      require("step3rep0$rep.inc");
    else:
      require("step3rep$rep.inc");
    endif;
  break;
endswitch;
if (($step==5)): // для всех отчётов: если отображается шаг 5 и выбрана распечатка на принтере, отобразить кнопки "<< Назад" и "Печать"
?>
    <BR><CENTER><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< Назад" NAME="back"><?if ($action=="print"):?>&nbsp;<INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="document.all.print.style.visibility='hidden'; document.all.back.style.visibility='hidden'; if (typeof(window.print) != 'undefined') {window.print();}; document.all.back.style.visibility = '';document.all.print.style.visibility = '';" VALUE="Печать" NAME="print"><?endif;?></CENTER>
<?
endif;
if (($step!=1)&&($step!=2)&&($step!=3)):
?>
  </BODY>
</HTML>
<?
endif;
//echo getenv('HTTP_USER_AGENT');
?>
