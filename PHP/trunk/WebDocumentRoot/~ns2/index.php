<?
session_start();
//if (!session_register("user","password")) die("�� ���� ���������������� ���������� � ������!");
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
  $title=$reports[$rep]["������������"];
else
  $title="������������ ������� �� ������ ���������-��������������� ���� ����";
//if (!(($step>=2)&&($step<=5))) $step=1; // ���� ��� �� �������� � ���������� [2..5] - ������������� ��� ������ 1
if (!(($rep>=1)&&($rep<=count($reports)))) $rep=1; // ���� ����� ������� �� ������� [1..���-�� �������] - ������������� ����� ����� 1
// ������ ������� ����
$d=date("d")+0; // ����������� �������� ���
$m=date("m")+0; // ����������� �������� ������
$y=date("Y")+0; // ����������� �������� ����
// ������ �������� ���
$ldd=date("d",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,2,2005)-mktime(0,0,0,1,1,2005))))+0; // ����������� ����� ��������� ����
$ldm=date("m",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,2,2005)-mktime(0,0,0,1,1,2005))))+0; // ����������� ������ ��������� ����
$ldy=date("Y",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,2,2005)-mktime(0,0,0,1,1,2005))))+0; // ����������� ���� ��������� ����
// echo "$ldd $ldm $ldy";
// ������ ���������� � ��������� ��� ��������� ������
$i=date("w")+0; // ��������� ������ ��� ������
if ($i==0) $i=7; // ������������� ��� ������ ��� �������
$lwbd=date("d",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,7+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // ������ ���������� ��� ��������� ������
$lwbm=date("m",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,7+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // ������ ���������� ������ ��������� ������
$lwby=date("Y",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,7+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // ������ ���������� ���� ��������� ������
$lwed=date("d",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,1+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // ������ ��������� ��� ��������� ������
$lwem=date("m",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,1+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // ������ ��������� ������ ��������� ������
$lwey=date("Y",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,1+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // ������ ��������� ���� ��������� ������
// echo "  $lwbd $lwbm $lwby $lwed $lwem $lwey";
// ������ ���������� � ��������� �����, ������ ����� � ���� ���������� ������
$lmbd=1; // ��������� ��������� ���� ���������� ������ �� ������ �����
$lmed=date("d",mktime(1,0,0,date("m"),1,date("Y"))-((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000)))); // ��������� ��������� ���� �������� ������ - �� ������� ����� �������� ������ �������� ���� ����
$lmm=date("m")-1; // ����������� ���������� ������
if ($lmm==0): $lmm=12; $lmy=date("Y")-1; else: $lmy=date("Y")+0; endif; // ������������� ���������� ������ � ����������� ���� ���������� ������
// echo "  $lmbd $lmm $lmy $lmed $lmm $lmy";
// ������ ������ ���������� ��������, ��� ���� � ����������� �� ������ �������� ������
$lqbd=1;
switch ($m):
  case 1: case 2: case 3: $lqq=4; $lqy=$y-1; $lqbm=10; $lqem=12; $lqed=31; break;
  case 4: case 5: case 6: $lqq=1; $lqy=$y+0; $lqbm=1; $lqem=3; $lqed=31; break;
  case 7: case 8: case 9: $lqq=2; $lqy=$y+0; $lqbm=4; $lqem=6; $lqed=30; break;
  case 10: case 11: case 12: $lqq=3; $lqy=$y+0; $lqbm=7; $lqem=9; $lqed=30; break;
endswitch;
// echo "  $lqbd $lqbm $lmy $lqed $lqem $lmy";
// ������ ������ ��� "�������" ��������
if (($aqq=="")||(!(($aqq>=1)&&($aqq<=4)))) $aqq=$lqq; // ���� �� ����� ����� �������� ���� ����������� ����� ����� ��������, �� ������������� ����� �������� � ����� ���������� ��������
if ($aqy=="") $aqy=$lqy; // ���� �� ����� ��� "�������" ��������, ������������� ��� ������ ������ ���� ���������� ��������
$aqbd=1;
switch ($aqq):
  case 1: $aqbm=1; $aqem=3; $aqed=31; break;
  case 2: $aqbm=4; $aqem=6; $aqed=30; break;
  case 3: $aqbm=7; $aqem=9; $aqed=30; break;
  case 4: $aqbm=10; $aqem=12; $aqed=31; break;
endswitch;
// ������ ������ ��� "�������" ������
if ($amm=="") $amm=$lmm; // ���� ����� "�������" ������ �� ������ - ���������� �������� �������� ������
if ($amy=="") $amy=$lmy; // ���� ��� "�������" ������ �� ������ - ���������� �������� ���� �������� ������
$ambd=1; // ��������� ��������� ���� "�������" ������ �� ������ �����
$i=$amm+1; if ($i==13): $i=1; $j=$amy+1; else: $j=$amy+0; endif; // ���������� ������ ������ ������ � ����, ���������� �� ��������� "������" ������� ��� ���������� ���������� ����� "�������" ������
$amed=date("d",mktime(1,0,0,$i,1,$j)-((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000)))); // ��������� ��������� ���� "�������" ������ - �������� ���� ���� �� ������� ����� ���������� �� "������" ������
// ������ ������ ��� "�������" ���
if ($add=="") $add=$ldd; // ���� ��������� ���� "�������" ��� �� �������� - ��������� ��������� ����
if ($adm=="") $adm=$ldm; // ���� ��������� ����� "�������" ��� �� �������� - ��������� ��������� �����
if ($ady=="") $ady=$ldy; // ���� ��������� ��� "�������" ��� �� �������� - ��������� ��������� ���
// ������ ������ ��� "�������" �������
if ($abd=="") $abd=$ldd; // ���� ��������� ���� "�������" ������� �� �������� - ��������� ��������� ����
if ($aed=="") $aed=$ldd; // ���� �������� ���� "�������" ������� �� �������� - ��������� ��������� ����
if ($abm=="") $abm=$ldm; // ���� ��������� ����� "�������" ������� �� �������� - ��������� ��������� �����
if ($aem=="") $aem=$ldm; // ���� �������� ����� "�������" ������� �� �������� - ��������� ��������� �����
if ($aby=="") $aby=$ldy; // ���� ��������� ��� "�������" ������� �� �������� - ��������� ��������� ���
if ($aey=="") $aey=$ldy; // ���� �������� ��� "�������" ������� �� �������� - ��������� ��������� ���
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
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==5))  // �������� ���������� �������� ��� �������
      $orientation="�������";
    elseif (($rep==6)||($rep==7)||($rep==8))
      $orientation="���������";
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
if (($step==5)): // ��� ���� �������: ���� ������������ ��� 5 � ������� ���������� �� ��������, ���������� ������ "<< �����" � "������"
?>
    <BR><CENTER><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"><?if ($action=="print"):?>&nbsp;<INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="document.all.print.style.visibility='hidden'; document.all.back.style.visibility='hidden'; if (typeof(window.print) != 'undefined') {window.print();}; document.all.back.style.visibility = '';document.all.print.style.visibility = '';" VALUE="������" NAME="print"><?endif;?></CENTER>
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
