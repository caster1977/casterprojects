<?
$months[]=""; $months[1]="������"; $months[2]="�������"; $months[3]="����"; $months[4]="������"; $months[5]="���"; $months[6]="����"; $months[7]="����"; $months[8]="������"; $months[9]="��������"; $months[10]="�������"; $months[11]="������"; $months[12]="�������";
$months2[]=""; $months2[1]="������"; $months2[2]="�������"; $months2[3]="�����"; $months2[4]="������"; $months2[5]="���"; $months2[6]="����"; $months2[7]="����"; $months2[8]="�������"; $months2[9]="��������"; $months2[10]="�������"; $months2[11]="������"; $months2[12]="�������";
$quartals[]=""; $quartals[1]="I"; $quartals[2]="II"; $quartals[3]="III"; $quartals[4]="IV";

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
$servicelist[]="99091";
$servicelist[]="99092";
$servicelist[]="99094";
$servicelist[]="99095";
$servicelist[]="99096";
$servicelist[]="99097";

$services["009"]="������� �������";
$services["075"]="������ �������-������������� ���������";
$services["088"]="������ ������� �������";
$services["090"]="�������������";
$services["091"]="���������";
$services["092"]="��������";
$services["093"]="����� � �����������";
$services["094"]="��������";
$services["095"]="������� ������";
$services["096"]="������ �� ��������";
$services["097"]="�������";
$services["098"]="�������-���������";
$services["099"]="���������� �������";
$services["9900911"]="��������, ������� �������";
$services["9909111"]="��������, ���������� �������";
$services["9909911"]="��������, ���������� �������";
$services["99075"]="��������, ������ �������-������������� ���������";
$services["99088"]="��������, ������ ������� �������";
$services["99091"]="��������, ���������";
$services["99092"]="��������, ������ �����";
$services["99094"]="��������, ��������";
$services["99095"]="��������, ������� ������";
$services["99096"]="��������, ������ ��� �����";
$services["99097"]="��������, �������";

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
$service_servedcondition["99091"]="(dur>0) AND (LEFT(ddi,5)='99091') AND (v_mreza>'')";
$service_servedcondition["99092"]="(dur>0) AND (LEFT(ddi,5)='99092') AND (v_mreza>'')";
$service_servedcondition["99094"]="(dur>0) AND (LEFT(ddi,5)='99094') AND (v_mreza>'')";
$service_servedcondition["99095"]="(dur>0) AND (LEFT(ddi,5)='99095') AND (v_mreza>'')";
$service_servedcondition["99096"]="(dur>0) AND (LEFT(ddi,5)='99096') AND (v_mreza>'')";
$service_servedcondition["99097"]="(dur>0) AND (LEFT(ddi,5)='99097') AND (v_mreza>'')";

$service_billingcondition["009"]="(LEFT(ddi,3)='009') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=3) OR (izgnum>'')) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0291______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______') OR (ani LIKE '0298______'))";
$service_billingcondition["075"]="(dur>0) AND (LEFT(ddi,3)='075') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0291______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______') OR (ani LIKE '0298______'))";
$service_billingcondition["088"]="(dur>0) AND (LEFT(ddi,3)='088') AND (v_mreza>'') AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0291______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______') OR (ani LIKE '0298______'))";
$service_billingcondition["090"]="(LEFT(ddi,3)='090') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=3) OR (izgnum>'')) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0291______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______') OR (ani LIKE '0298______'))";
$service_billingcondition["091"]="(dur>0) AND (LEFT(ddi,3)='091') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0291______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______') OR (ani LIKE '0298______'))";
$service_billingcondition["092"]="(dur>0) AND (LEFT(ddi,3)='092') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0291______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______') OR (ani LIKE '0298______'))";
$service_billingcondition["093"]="(LEFT(ddi,3)='093') AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=3) OR (izgnum>'')) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0291______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______') OR (ani LIKE '0298______'))";
$service_billingcondition["094"]="(dur>0) AND (LEFT(ddi,3)='094') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0291______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______') OR (ani LIKE '0298______'))";
$service_billingcondition["095"]="(dur>0) AND (LEFT(ddi,3)='095') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0291______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______') OR (ani LIKE '0298______'))";
$service_billingcondition["096"]="(dur>0) AND (LEFT(ddi,3)='096') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0291______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______') OR (ani LIKE '0298______'))";
$service_billingcondition["097"]="(dur>0) AND (LEFT(ddi,3)='097') AND (v_mreza>'') AND (druga_info=0) AND ((ani LIKE '00172______') OR (ani LIKE '02______') OR (ani LIKE '00175______') OR (ani LIKE '0296______') OR (ani LIKE '0293______') OR (ani LIKE '0291______') OR (ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______') OR (ani LIKE '0298______'))";
$service_billingcondition["098"]="0";
$service_billingcondition["099"]="0";
$service_billingcondition["9900911"]="0";
$service_billingcondition["9909111"]="0";
$service_billingcondition["9909911"]="0";
$service_billingcondition["99075"]="0";
$service_billingcondition["99088"]="0";
$service_billingcondition["99091"]="0";
$service_billingcondition["99092"]="0";
$service_billingcondition["99094"]="0";
$service_billingcondition["99095"]="0";
$service_billingcondition["99096"]="0";
$service_billingcondition["99097"]="0";

$repnames[1]="���������� ������ ����� ���";$repnames[2]="�������� � ���������� �����������";$repnames[3]="���������� ������ ������������";$repnames[4]="���������� Content Provider ��� ��������������"; $repnames[5]="����������� ����� �� ������ ��� &laquo;009&raquo;"; $repnames[6]="�������� � �������� ������� �� ���� �� &laquo;���&raquo; �� �����"; $repnames[7]="�������� � �������� ������� �� ���� ���� &laquo;���&raquo; �� �����"; $repnames[8]="�������� � �������� ������� �� ���� ���� &laquo;���&raquo; �� ����� (������ �����)"; $repnames[9]="������������ ������� irda_* �� ��������� �����"; $repnames[10]="������������ ������� orda_* �� ��������� �����";
$repcomments[1]="������ ����� ������������ �������� ��������� ��������� �� ��������� ����, �� ������������� �� ��������� ������, � ����� 1-�� ����� ������� ������ �� ��������� ����� � ���� ����������� ����� <B>*.htm</B> �� ����� ����������� ����� <B>irai@mgts.by</B><!-- � <B>anna@mgts.by</B> --> ����������� ������ ���������� (����&nbsp;�.�.), � ����� ���������� � ����� ���������� � ��������������� ���������� ��� (����������&nbsp;�.�.) ������ ����������� �� ��������� ������ � 1-�� ����� ������� ������ �� ��������� �����."; $repcomments[4]="������ ����� ����������� �������� ��������� ������ ����������� �� ��������� ������ � ����������� � ���������� ��������� ��� ����� ����� � ����� �������� ����������."; $repcomments[5]="������ ����� ����������� �������� ��������� 1-�� ����� ���������� �� �������� ��������� ������ � ��������������� ���������� ��� (���������� �.�.) � ����� �������� ����������."; $repcomments[9]="������ ����� ���� ��������� ������������ ����� ������� �������� ������� �� ��������� �� ��������� ����� - <B>irda_<I>������</I></B>, ��������� ������� ������� <B>ird_<I>��������</I></B> �� ������ ��������� ����"; $repcomments[10]="������ ����� ���� ��������� ������������ ����� ������� ��������� ������� � ��������� �� ��������� ����� - <B>orda_<I>������</I></B>, ��������� ������� ������� <B>ord_<I>��������</I></B> �� ������ ��������� ����";
/*
if ($STEP==5)
  $title="$repnames[$rep]";
else
*/
  $title="������������ ������� �� ������ ���������-��������������� ���� ����";
if (!(($STEP>=2)&&($STEP<=5))) $STEP=1; // ���� ��� �� �������� � ���������� [2..5] - ������������� ��� ������ 1
if (!(($rep>=1)&&($rep<=count($repnames)))) $rep=1; // ���� ����� ������� �� ������� [1..���-�� �������] - ������������� ����� ����� 1
// ������ ������� ����
$d=date("d")+0; // ����������� �������� ���
$m=date("m")+0; // ����������� �������� ������
$y=date("Y")+0; // ����������� �������� ����
// ������ �������� ���
$ldd=date("d",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))))+0; // ����������� ����� ��������� ����
$ldm=date("m",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))))+0; // ����������� ������ ��������� ����
$ldy=date("Y",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))))+0; // ����������� ���� ��������� ����
// ������ ���������� � ��������� ��� ��������� ������
$i=date("w")+0; // ��������� ������ ��� ������
if ($i==0) $i=7; // ������������� ��� ������ ��� �������
$lwbd=date("d",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,7+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // ������ ���������� ��� ��������� ������
$lwbm=date("m",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,7+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // ������ ���������� ������ ��������� ������
$lwby=date("Y",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,7+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // ������ ���������� ���� ��������� ������
$lwed=date("d",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,1+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // ������ ��������� ��� ��������� ������
$lwem=date("m",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,1+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // ������ ��������� ������ ��������� ������
$lwey=date("Y",mktime(1,0,0,date("m"),date("d"),date("Y"))-((mktime(0,0,0,1,1+$i,2000)-mktime(0,0,0,1,1,2000))))+0; // ������ ��������� ���� ��������� ������
// ������ ���������� � ��������� �����, ������ ����� � ���� ���������� ������
$lmbd=1; // ��������� ��������� ���� ���������� ������ �� ������ �����
$lmed=date("d",mktime(1,0,0,date("m"),1,date("Y"))-((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000)))); // ��������� ��������� ���� �������� ������ - �� ������� ����� �������� ������ �������� ���� ����
$lmm=date("m")-1; // ����������� ���������� ������
if ($lmm==0): $lmm=12; $lmy=date("Y")-1; else: $lmy=date("Y")+0; endif; // ������������� ���������� ������ � ����������� ���� ���������� ������
// ������ ������ ���������� ��������, ��� ���� � ����������� �� ������ �������� ������
$lqbd=1;
switch ($m):
  case 1: case 2: case 3: $lqq=4; $lqy=$y-1; $lqbm=10; $lqem=12; $lqed=31; break;
  case 4: case 5: case 6: $lqq=1; $lqy=$y+0; $lqbm=1; $lqem=3; $lqed=31; break;
  case 7: case 8: case 9: $lqq=2; $lqy=$y+0; $lqbm=4; $lqem=6; $lqed=30; break;
  case 10: case 11: case 12: $lqq=3; $lqy=$y+0; $lqbm=7; $lqem=9; $lqed=30; break;
endswitch;
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
// ������ ������ ��� "�������" �������
if ($abd=="") $abd=$ldd; // ���� ��������� ���� "�������" ������� �� �������� - ��������� ��������� ����
if ($aed=="") $aed=$ldd; // ���� �������� ���� "�������" ������� �� �������� - ��������� ��������� ����
if ($abm=="") $abm=$ldm; // ���� ��������� ����� "�������" ������� �� �������� - ��������� ��������� �����
if ($aem=="") $aem=$ldm; // ���� �������� ����� "�������" ������� �� �������� - ��������� ��������� �����
if ($aby=="") $aby=$ldy; // ���� ��������� ��� "�������" ������� �� �������� - ��������� ��������� ���
if ($aey=="") $aey=$ldy; // ���� �������� ��� "�������" ������� �� �������� - ��������� ��������� ���
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE><?print $title;?></TITLE><META CONTENT="no-cache" HTTP-EQUIV="pragma"><META CONTENT="no-cache" HTTP-EQUIV="cache-control"><META CONTENT=Dynamic NAME=Document-state><META content="text/html; charset=Windows-1251" http-equiv=Content-Type>
    <STYLE MEDIA="screen, print">
      *               {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 8pt;}
      BODY            {font-size: 8pt; background-color: white; margin: 5px; color: #000000;}
      P               {font-size: inherit; text-indent: 0; margin-top: 2px; margin-bottom: 2px; text-align: justify; font-weight: normal; color: #000000; background: transparent;}
      A               {font-size: inherit; text-align: left; font-weight: bold; background: transparent; text-decoration:none;}
      H1              {font-size: 13pt; margin-top: 5px; margin-bottom: 5px; text-align: center; font-weight: bold; color: #000000; background-color: transparent; padding-top: 3px; padding-bottom: 3px;}
      CAPTION         {font-size: 13pt; margin-top: 5px; margin-bottom: 5px; text-align: center; font-weight: bold; color: #000000; background-color: transparent; padding-top: 3px; padding-bottom: 3px;}
      TABLE           {width: <?if ((($rep=="6")||($rep=="7")||($rep=="8"))&&($STEP=="5")): echo "280"; else: echo "179"; endif;?> mm; caption-side: top; table-layout: auto; empty-cells: show; font-size: 8pt; float: none; clear: both; border-collapse: collapse; background-color: transparent;}
      TBODY           {vertical-align: top;}
      TD              {font-weight: normal; padding: 0 5px;}
      TH              {font-weight: bold; padding: 0 5px;}
    </STYLE>
  </HEAD>
  <BODY <?if (($STEP==5)&&($ACTION=="print")) print " ONLOAD=\"if defined(document.all.print) document.all.print.focus();\"";?>>
<?
switch ($STEP):
  case 1: // $STEP==1 (��� 1 - ����� ������ �� ������)
//    require('step1.inc');
?>
    <FORM METHOD="GET">
      <TABLE WIDTH="179mm" BORDER="0" ALIGN="CENTER">
        <THEAD ALIGN="CENTER" VALIGN="MIDDLE" BGCOLOR="WHITE">
          <TR>
            <TD COLSPAN="4"><H1><?echo $title?></H1></TD>
          </TR>
        </THEAD>
        <TFOOT ALIGN="CENTER" VALIGN="MIDDLE" BGCOLOR="WHITE">
          <TR>
            <TD COLSPAN="4">
              <INPUT TYPE="HIDDEN" NAME="STEP" VALUE="2">
              <INPUT TYPE="SUBMIT" VALUE="����� >>>">
            </TD>
          </TR>
        </TFOOT>
        <TBODY ALIGN="RIGHT" VALIGN="BOTTOM" BGCOLOR="#339999">
          <TR HEIGHT="15">
            <TD WIDTH="5" ROWSPAN="3">&nbsp;</TD>
            <TD COLSPAN="2"></TD>
            <TD WIDTH="5" ROWSPAN="3">&nbsp;</TD>
          </TR>
          <TR BGCOLOR="#FFFFFF">
            <TH WIDTH="50%">�������� �����:</TH>
            <TD WIDTH="50%">
              <SELECT NAME="rep" SIZE="<?echo count($repnames);?>">
<?
    for ($i=1;$i<=count($repnames);$i++):
      if ($repnames[$i]!=""):
?>
                <OPTION value="<?echo "$i";?>"<?if ($i==$rep) echo " SELECTED";?>><?echo $repnames[$i];?></OPTION>
<?
      endif;
    endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR HEIGHT="15">
            <TD COLSPAN="4">
            </TD>
          </TR>
          <TR BGCOLOR="#FFFFFF" HEIGHT="13">
            <TD COLSPAN="4">
            </TD>
          </TR>
        </TBODY>
      </TABLE>
    </FORM>
<?
  break;
  case 2: // $STEP==2 (��� 2 - ����� ������������ ������, ������������ �� ���� � ����� ���������� ���������� ��� ������������ ������)
//    require('step2.inc');
?>
    <FORM METHOD="GET">
      <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
        <TBODY BGCOLOR="#339999">
          <TR>
            <TD BGCOLOR="WHITE" COLSPAN="4">
              <H1><?echo $title?></H1>
            </TD>
          </TR>
          <TR HEIGHT="15" VALIGN="MIDDLE">
            <TD WIDTH="5" ROWSPAN="4">&nbsp;</TD>
            <TD COLSPAN="2" WIDTH="100%"></TD>
            <TD WIDTH="5" ROWSPAN="4">&nbsp;</TD>
          </TR>
          <TR HEIGHT="22" VALIGN="MIDDLE">
            <TH ALIGN="LEFT" WIDTH="50%" BGCOLOR="#FFFFFF">�����:</TH>
            <TD WIDTH="50%" BGCOLOR="#EEEEEE"><?print $repnames[$rep]; ?></TD>
          </TR>
          <TR HEIGHT="22" VALIGN="MIDDLE">
            <TH ALIGN="LEFT" BGCOLOR="#EEEEEE">�����������:</TH>
            <TD BGCOLOR="#FFFFFF"><?if (!($repcomments[$rep]=="")) print $repcomments[$rep]; else print "&#151;";?></TD>
          </TR>
          <TR VALIGN="MIDDLE">
            <TD HEIGHT="15" COLSPAN="2"></TD>
          </TR>
          <TR BGCOLOR="#FFFFFF">
            <TD HEIGHT="13" COLSPAN="4"></TD>
          </TR>
          <TR BGCOLOR="#FFFFFF">
            <TD ALIGN="CENTER" COLSPAN="4">
              <INPUT TYPE="HIDDEN" NAME="STEP" VALUE="1">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?print $rep;?>">
              <INPUT TYPE="SUBMIT" VALUE="<<< �����">
            </TD>
          </TR>
        </TBODY>
      </TABLE>
    </FORM>
    <FORM METHOD="GET">
      <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
        <TBODY BGCOLOR="#339999">
<?
    // ��������� ������� ���� � ����������� �� ������ ������
    switch ($rep):
      case "1": case "2": case "3":
        // ���� �� �������� ���������� ������� ������ - ��������� �� ��������� ��������� ����
        if ($time=="")
          $time="yesterday";
?>
          <TR VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="11">&nbsp;</TD><TD HEIGHT="15" COLSPAN="2" WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="11">&nbsp;</TD></TR>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>�������� ��������� ���������� ������������ ������:</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE">
            <TH ALIGN="LEFT" WIDTH="50%"><INPUT TYPE="RADIO" NAME="time" VALUE="yesterday" STYLE='height:15px;'<?if ($time=="yesterday"):?> CHECKED<?endif;?>>��������� ����</TH>
            <TD ALIGN="LEFT" WIDTH="50%"><?if ($ldd<10) print "0"; print "$ldd $months2[$ldm] $ldy ����";?></TD>
          </TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#FFFFFF">
            <TH ALIGN="LEFT"><INPUT TYPE="RADIO" NAME="time" VALUE="lastweek" STYLE='height:15px;'<?if ($time=="lastweek"):?> CHECKED<?endif;?>>��������� ������</TH>
            <TD ALIGN="LEFT"><?if ($lwbd<10) print "0"; print "$lwbd $months2[$lwbm] $lwby ���� - "; if ($lwed<10) print "0"; print "$lwed $months2[$lwem] $lwe� ����";?></TD>
          </TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE">
            <TH ALIGN="LEFT"><INPUT TYPE="RADIO" NAME="time" VALUE="lastmonth" STYLE='height:15px;'<?if ($time=="lastmonth"):?> CHECKED<?endif;?>>��������� �����</TH>
            <TD ALIGN="LEFT"><?print "$months[$lmm] $lmy ����";?></TD>
          </TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#FFFFFF">
            <TH ALIGN="LEFT"><INPUT TYPE="RADIO" NAME="time" VALUE="anothermonth" STYLE='height:15px;'<?if ($time=="anothermonth"):?> CHECKED<?endif;?>>��������� �����:</TH>
            <TD ALIGN="LEFT">
              <SELECT NAME="amm">
<?
        for ($i=1;$i<count($months);$i++):
?>
                <OPTION <?if ($i==$amm):?>SELECTED <?endif;?>value="<?print $i;?>"><?print $months[$i];?></OPTION>
<?
        endfor;
?>
              </SELECT>
              <SELECT NAME="amy">
<?
        for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$amy):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $i;?></OPTION>
<?
        endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD ALIGN="LEFT" COLSPAN="2"><INPUT TYPE="RADIO" NAME="time" VALUE="another" STYLE='height:15px;'<?if ($time=="another"):?> CHECKED<?endif;?>><B>������ ������</B></TD></TR>
          <TR VALIGN="MIDDLE" BGCOLOR="#FFFFFF">
            <TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��������� ����:</TD>
            <TD ALIGN="LEFT">
              <SELECT NAME="abd">
<?
        for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$abd):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $i;?></OPTION>
<?
        endfor;
?>
              </SELECT>
              <SELECT NAME="abm">
<?
        for ($i=1;$i<count($months);$i++):
?>
                <OPTION <?if ($i==$abm):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $months2[$i];?></OPTION>
<?
        endfor;
?>
              </SELECT>
              <SELECT NAME="aby">
<?
        for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$aby):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $i;?></OPTION>
<?
        endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR VALIGN="MIDDLE" BGCOLOR="#EEEEEE">
            <TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�������� ����:</TD>
            <TD ALIGN="LEFT">
              <SELECT NAME="aed">
<?
        for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$aed):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $i;?></OPTION>
<?
        endfor;
?>
              </SELECT>
              <SELECT NAME="aem">
<?
        for ($i=1;$i<=12;$i++):
?>
                <OPTION <?if ($i==$aem):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $months2[$i];?></OPTION>
<?
        endfor;
?>
              </SELECT>
              <SELECT NAME="aey">
<?
        for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$aey):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $i;?></OPTION>
<?
        endfor;
?>
              </SELECT>
            </TD>
          </TR>
<?
      break;
      case "4":
        // ���� �� �������� ���������� ������� ������ - ��������� �� ��������� ��������� ������
        if ($time=="")
          $time="lastweek";
?>
          <TR VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="9">&nbsp;</TD><TD HEIGHT="15" COLSPAN="2"  WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="9">&nbsp;</TD></TR>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>�������� ��������� ���������� ������������ ������:</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#FFFFFF">
            <TH ALIGN="LEFT"><INPUT TYPE="RADIO" NAME="time" VALUE="lastweek" STYLE='height:15px;'<?if ($time=="lastweek"):?> CHECKED<?endif;?>>��������� ������</TH>
            <TD ALIGN="LEFT"><?if ($lwbd<10) print "0"; print "$lwbd $months2[$lwbm] $lwby ���� - "; if ($lwed<10) print "0"; print "$lwed $months2[$lwem] $lwey ����";?></TD>
          </TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE">
            <TH ALIGN="LEFT" WIDTH="50%"><INPUT TYPE="RADIO" NAME="time" VALUE="yesterday" STYLE='height:15px;'<?if ($time=="yesterday"):?> CHECKED<?endif;?>>��������� ����</TH>
            <TD ALIGN="LEFT" WIDTH="50%"><?print "$ldd $months2[$ldm] $ldy ����";?></TD>
          </TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#FFFFFF"><TD ALIGN="LEFT" COLSPAN="2"><INPUT TYPE="RADIO" NAME="time" VALUE="another" STYLE='height:15px;'<?if ($time=="another"):?> CHECKED<?endif;?>><B>������ ������</B></TD></TR>
          <TR VALIGN="MIDDLE" BGCOLOR="#EEEEEE">
            <TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��������� ����:</TD>
            <TD ALIGN="LEFT">
              <SELECT NAME="abd">
<?
        for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$abd):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $i;?></OPTION>
<?
        endfor;
?>
              </SELECT>
              <SELECT NAME="abm">
<?
        for ($i=1;$i<count($months);$i++):
?>
                <OPTION <?if ($i==$abm):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $months2[$i];?></OPTION>
<?
        endfor;
?>
              </SELECT>
              <SELECT NAME="aby">
<?
        for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$aby):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $i;?></OPTION>
<?
        endfor;
?>
              </SELECT>
            </TD>
          </TR>
          <TR VALIGN="MIDDLE" BGCOLOR="#FFFFFF">
            <TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�������� ����:</TD>
            <TD ALIGN="LEFT">
              <SELECT NAME="aed">
<?
        for ($i=1;$i<32;$i++):
?>
                <OPTION <?if ($i==$aed):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $i;?></OPTION>
<?
        endfor;
?>
              </SELECT>
              <SELECT NAME="aem">
<?
        for ($i=1;$i<=12;$i++):
?>
                <OPTION <?if ($i==$aem):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $months2[$i];?></OPTION>
<?
        endfor;
?>
              </SELECT>
              <SELECT NAME="aey">
<?
        for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$aey):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $i;?></OPTION>
<?
        endfor;
?>
              </SELECT>
            </TD>
          </TR>
<?
      break;
      case "5":
        // ���� �� �������� ���������� ������� ������ - ��������� �� ��������� ��������� �������
        if ($time=="")
          $time="lastquart";
?>
          <TR VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="6">&nbsp;</TD><TD HEIGHT="15" COLSPAN="2"  WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="6">&nbsp;</TD></TR>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>�������� ��������� ���������� ������������ ������:</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#FFFFFF">
            <TH ALIGN="LEFT"><INPUT TYPE="RADIO" NAME="time" VALUE="lastquart" STYLE='height:15px;'<?if ($time=="lastquart"):?> CHECKED<?endif;?>>��������� �������</TH>
            <TD ALIGN="LEFT"><?print "$months[$lqbm] - $months[$lqem] $lqy ����";?></TD>
          </TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE">
            <TH ALIGN="LEFT"><INPUT TYPE="RADIO" NAME="time" VALUE="anotherquart" STYLE='height:15px;'<?if ($time=="anotherquart"):?> CHECKED<?endif;?>>������ �������</TH>
            <TD ALIGN="LEFT">
              <SELECT NAME="aqq">
<?
        for ($i=1;$i<count($quartals);$i++):
?>
                <OPTION <?if ($i==$aqq):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $quartals[$i];?></OPTION>
<?
        endfor;
?>
              </SELECT>
              <SELECT NAME="aqy">
<?
        for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$aqy):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $i;?></OPTION>
<?
        endfor;
?>
              </SELECT>
            </TD>
          </TR>
<?
      break;
      case "6": case "7": case "8": case "9": case "10":
        if ($time=="")
          $time="lastmonth";
?>
          <TR VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="6">&nbsp;</TD><TD HEIGHT="15" COLSPAN="2"  WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="6">&nbsp;</TD></TR>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>�������� ��������� ���������� ������������ ������:</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE">
            <TH ALIGN="LEFT"><INPUT TYPE="RADIO" NAME="time" VALUE="lastmonth" STYLE='height:15px;'<?if ($time=="lastmonth"):?> CHECKED<?endif;?>>��������� �����</TH>
            <TD ALIGN="LEFT"><?print "$months[$lmm] $lmy ����";?></TD>
          </TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#FFFFFF">
            <TH ALIGN="LEFT"><INPUT TYPE="RADIO" NAME="time" VALUE="anothermonth" STYLE='height:15px;'<?if ($time=="anothermonth"):?> CHECKED<?endif;?>>��������� �����:</TH>
            <TD ALIGN="LEFT">
              <SELECT NAME="amm">
<?
        for ($i=1;$i<count($months);$i++):
?>
                <OPTION <?if ($i==$amm):?>SELECTED <?endif;?>value="<?print $i;?>"><?print $months[$i];?></OPTION>
<?
        endfor;
?>
              </SELECT>
              <SELECT NAME="amy">
<?
        for ($i=$y-2;$i<=$y;$i++):
?>
                <OPTION <?if ($i==$amy):?>SELECTED <?endif;?>VALUE="<?print $i;?>"><?print $i;?></OPTION>
<?
        endfor;
?>
              </SELECT>
            </TD>
          </TR>
<?
      break;
    endswitch;
?>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR BGCOLOR="#FFFFFF"><TD HEIGHT="13" COLSPAN="4"></TD></TR>
          <TR BGCOLOR="#FFFFFF"><TD ALIGN="CENTER" COLSPAN="4"><INPUT TYPE="HIDDEN" NAME="STEP" VALUE="3"><INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?print $rep;?>"><INPUT TYPE="SUBMIT" VALUE="����� >>>"></TD></TR>
        </TBODY>
      </TABLE>
    </FORM>
<?
  break;
  case 3: // $STEP==3 (�������� �������� ������������� �������������� ���������� ��� ������������ ������)
//    require('step3.inc');
    // �������� �� ������������ ���������� ������� �������
    if ($time=="another"):
      if (checkdate($abm,$abd,$aby)<>1):
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR><TD BGCOLOR="WHITE" COLSPAN="3"><H1><?echo $title?></H1></TD></TR>
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>��������! ������� �������������� ��������� ����:</B> <?print "$abd&nbsp;$months2[$abm]&nbsp;$aby&nbsp;����";?>!<BR><BR>������� ������ <B>&laquo;�����&raquo;</B> ��� �������� � ���� ������ ���������� �������.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
        die("");
      elseif (checkdate($aem,$aed,$aey)<>1):
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR><TD BGCOLOR="WHITE" COLSPAN="3"><H1><?echo $title?></H1></TD></TR>
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>��������! ������� �������������� �������� ����:</B> <?print "$aed&nbsp;$months2[$aem]&nbsp;$aey&nbsp;����";?>!<BR><BR>������� ������ <B>&laquo;�����&raquo;</B> ��� �������� � ���� ������ ���������� �������.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
        die("");
      // �������� �� ������������ ��������� � �������� ��� �� ��������� ���� � ����� - �������� ���� ������ ���� ������� ���������
      elseif ((mktime(0,0,0,$aem+0,$aed+0,$aey+0)-mktime(0,0,0,$abm,$abd,$aby))<0):
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR><TD BGCOLOR="WHITE" COLSPAN="3"><H1><?echo $title?></H1></TD></TR>
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>��������! ����� ������������ �������� ���:</B><BR>��������� ���� (<?print "$abd&nbsp;$months2[$abm]&nbsp;$aby&nbsp;����";?>) �������� ����� �������, ��� �������� ���� (<?print "$aed&nbsp;$months2[$aem]&nbsp;$aey&nbsp;����";?>)!<BR><BR>������� ������ <B>&laquo;�����&raquo;</B> ��� �������� � ���� ������ ���������� �������.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
        die("");
      endif;
    endif;
?>
    <FORM METHOD="GET">
      <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
        <TBODY BGCOLOR="#339999">
          <TR><TD BGCOLOR="WHITE" COLSPAN="4"><H1><?echo $title?></H1></TD></TR>
          <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="5">&nbsp;</TD><TD COLSPAN="2" WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="5">&nbsp;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TH ALIGN="LEFT" WIDTH="50%" BGCOLOR="#FFFFFF">�����:</TH><TD WIDTH="50%" BGCOLOR="#EEEEEE"><?print $repnames[$rep]; ?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TH ALIGN="LEFT" BGCOLOR="#EEEEEE">�����������:</TH><TD BGCOLOR="#FFFFFF"><?if (!($repcomments[$rep]=="")) print $repcomments[$rep]; else print "&#151;";?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE">
            <TH ALIGN="LEFT" BGCOLOR="#FFFFFF">���������� �������:</TH>
            <TD BGCOLOR="#EEEEEE">
<?
    switch ($time):
      case "yesterday":
        if ($ldd<10) print "0"; print "$ldd $months2[$ldm] $ldy ����";
      break;
      case "lastweek":
        if ($lwbd<10) print "0";
        print "$lwbd $months2[$lwbm] $lwby ���� - ";
        if ($lwed<10) print "0";
        print "$lwed $months2[$lwem] $lwey ����";
      break;
      case "lastmonth":
        print "$months[$lmm] $lmy ����";
      break;
      case "lastquart":
        print "$quartals[$lqq] ������� $lqy ����";
      break;
      case "anothermonth":
        print "$months[$amm] $amy ����";
      break;
      case "anotherquart":
        print "$quartals[$aqq] ������� $aqy ����";
      break;
      case "another":
        if (($abd==$aed)&&($abm==$aem)&&($aby==$aey)):
          print "$abd $months2[$abm] $aby ����";
        else:
          print "$abd $months2[$abm] $aby ���� - $aed $months2[$aem] $aey ����";
        endif;
      break;
    endswitch;
?>
            </TD>
          </TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR BGCOLOR="#FFFFFF"><TD HEIGHT="13" COLSPAN="4"></TD></TR>
          <TR BGCOLOR="#FFFFFF">
            <TD ALIGN="CENTER" COLSPAN="4">
              <INPUT TYPE="HIDDEN" NAME="STEP" VALUE="2">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?print $rep;?>">
              <INPUT TYPE="HIDDEN" NAME="time" VALUE="<?print $time;?>">
<?
    if (($rep==1)||($rep==2)||($rep==3)||($rep==6)||($rep==7)||($rep==8)||($rep==9)||($rep==10)):
?>
              <INPUT TYPE="HIDDEN" NAME="amm" VALUE="<?print $amm;?>">
              <INPUT TYPE="HIDDEN" NAME="amy" VALUE="<?print $amy;?>">
<?
    endif;
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)):
?>
              <INPUT TYPE="HIDDEN" NAME="abd" VALUE="<?print $abd;?>">
              <INPUT TYPE="HIDDEN" NAME="abm" VALUE="<?print $abm;?>">
              <INPUT TYPE="HIDDEN" NAME="aby" VALUE="<?print $aby;?>">
              <INPUT TYPE="HIDDEN" NAME="aed" VALUE="<?print $aed;?>">
              <INPUT TYPE="HIDDEN" NAME="aem" VALUE="<?print $aem;?>">
              <INPUT TYPE="HIDDEN" NAME="aey" VALUE="<?print $aey;?>">
<?
    endif;
    if ($rep==5):
?>
              <INPUT TYPE="HIDDEN" NAME="aqq" VALUE="<?print $aqq;?>">
              <INPUT TYPE="HIDDEN" NAME="aqy" VALUE="<?print $aqy;?>">
<?
    endif;
?>
              <INPUT TYPE="SUBMIT" VALUE="<<< �����">
            </TD>
          </TR>
        </TBODY>
      </TABLE>
    </FORM>
    <FORM METHOD="GET">
      <INPUT TYPE="HIDDEN" NAME="STEP" VALUE="4">
      <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?print $rep;?>">
      <INPUT TYPE="HIDDEN" NAME="time" VALUE="<?print $time;?>">
<?
    if (($rep==1)||($rep==2)||($rep==3)||($rep==6)||($rep==7)||($rep==8)||($rep==9)||($rep==10)):
?>
      <INPUT TYPE="HIDDEN" NAME="amm" VALUE="<?print $amm;?>">
      <INPUT TYPE="HIDDEN" NAME="amy" VALUE="<?print $amy;?>">
<?
    endif;
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)):
?>
      <INPUT TYPE="HIDDEN" NAME="abd" VALUE="<?print $abd;?>">
      <INPUT TYPE="HIDDEN" NAME="abm" VALUE="<?print $abm;?>">
      <INPUT TYPE="HIDDEN" NAME="aby" VALUE="<?print $aby;?>">
      <INPUT TYPE="HIDDEN" NAME="aed" VALUE="<?print $aed;?>">
      <INPUT TYPE="HIDDEN" NAME="aem" VALUE="<?print $aem;?>">
      <INPUT TYPE="HIDDEN" NAME="aey" VALUE="<?print $aey;?>">
<?
    endif;
    if ($rep==5):
?>
      <INPUT TYPE="HIDDEN" NAME="aqq" VALUE="<?print $aqq;?>">
      <INPUT TYPE="HIDDEN" NAME="aqy" VALUE="<?print $aqy;?>">
<?
    endif;
?>
      <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
        <TBODY BGCOLOR="#339999">
<?
    if (($rep==1)||($rep==2)) $rowcount=2+24+8;
    elseif ($rep==3) $rowcount=2+25;
    elseif ($rep==5) $rowcount=2+9;
    elseif (($rep==6)||($rep==7)||($rep==9)||($rep==10)) $rowcount=2+1;
    elseif (($rep==4)||($rep==8)) $rowcount=2+5;
    else $rowcount=2;
?>
          <TR VALIGN="MIDDLE" HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="<?print $rowcount;?>">&nbsp;</TD><TD COLSPAN="2" WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="<?print $rowcount;?>">&nbsp;</TD></TR>
<?
    // ���� � ������ ���� �������������� ���������, ������� ���� ����� ��� �� �����
    if (($rep==1)||($rep==2)):
?>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>�������� ������ ���, �� ������� ���������� ������������ �����:</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TH BGCOLOR="#FFFFFF" WIDTH="50%">��������� ������</TH><TH BGCOLOR="#EEEEEE" WIDTH="50%">��������������</TH></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C009" <?if ($C009=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.C9909911.checked);">009 &#151; <?echo $services["009"]?></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C075" <?if ($C075=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">075 &#151; <?echo $services["075"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C090" <?if ($C090=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.C9909911.checked);">090 &#151; <?echo $services["090"]?></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C088" <?if ($C088=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">088 &#151; <?echo $services["088"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C093" <?if ($C093=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.C9909911.checked);">093 &#151; <?echo $services["093"]?></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C091" <?if ($C091=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">091 &#151; <?echo $services["091"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C098" <?if ($C099=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.checked);">098 &#151; <?echo $services["098"]?></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C092" <?if ($C092=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">092 &#151; <?echo $services["092"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C099" <?if ($C099=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.C9909911.checked);">099 &#151; <?echo $services["099"]?></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C094" <?if ($C094=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">094 &#151; <?echo $services["094"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C9900911" <?if ($C9900911=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.C9909911.checked);">9900911 &#151; <?echo $services["9900911"]?></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C095" <?if ($C095=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">095 &#151; <?echo $services["095"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C9909111" <?if ($C9909111=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.C9909911.checked);">9909111 &#151; <?echo $services["9909111"]?></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C096" <?if ($C096=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">096 &#151; <?echo $services["096"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C9909911" <?if ($C9909911=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_VOICE.checked=(C009.checked && C090.checked && C093.checked && C099.checked && C9900911.checked && C9909111.checked && C9909911.checked && C098.C9909911.checked);">9909911 &#151; <?echo $services["9909911"]?></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C097" <?if ($C097=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked);">097 &#151; <?echo $services["097"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99075" <?if ($C99075=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99075 &#151; <?echo $services["99075"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99088" <?if ($C99088=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99088 &#151; <?echo $services["99088"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99091" <?if ($C99091=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99091 &#151; <?echo $services["99091"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99092" <?if ($C99092=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99092 &#151; <?echo $services["99092"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99094" <?if ($C99094=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99094 &#151; <?echo $services["99094"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99095" <?if ($C99095=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99095 &#151; <?echo $services["99095"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"></TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99096" <?if ($C99096=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99096 &#151; <?echo $services["99096"]?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF"></TD><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="C99097" <?if ($C99097=="on") print "CHECKED ";?>ONCLICK="CHECK_ALL_AUTO.checked=(C075.checked && C088.checked && C091.checked && C092.checked && C094.checked && C095.checked && C096.checked && C097.checked && C99075.checked && C99088.checked && C99091.checked && C99092.checked && C99094.checked && C99095.checked && C99096.checked && C99097.checked);">99097 &#151; <?echo $services["99097"]?></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="CHECK_ALL_VOICE" <?if ($CHECK_ALL_VOICE=="on") print "CHECKED ";?>ONCLICK="C009.checked=this.checked; C090.checked=this.checked; C093.checked=this.checked; C099.checked=this.checked; C9900911.checked=this.checked; C9909111.checked=this.checked; C9909911.checked=this.checked; C098.checked=this.checked;">������� ��� ��������� ������</TD><TD BGCOLOR="#FFFFFF"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;" NAME="CHECK_ALL_AUTO" <?if ($CHECK_ALL_AUTO=="on") print "CHECKED ";?>ONCLICK="C075.checked=this.checked; C088.checked=this.checked; C091.checked=this.checked; C092.checked=this.checked; C094.checked=this.checked; C095.checked=this.checked; C096.checked=this.checked; C097.checked=this.checked; C99075.checked=this.checked; C99088.checked=this.checked; C99091.checked=this.checked; C99092.checked=this.checked; C99094.checked=this.checked; C99095.checked=this.checked; C99096.checked=this.checked; C99097.checked=this.checked;">������� ��� ������ �� ���� ���������������</TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>������� ������ ����������� (����������� ������):</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD WIDTH="50%">�������, ��������</TD><TD WIDTH="50%"><INPUT TYPE="TEXT" NAME="maker" SIZE="30" VALUE="<?if ($maker!=""): print "$maker"; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#FFFFFF"><TD>���������</TD><TD><INPUT TYPE="TEXT" NAME="makerstate" SIZE="30" VALUE="<?if ($makerstate!=""): print "$makerstate"; else: print "�������-�������������"; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD>���������� �������</TD><TD><INPUT TYPE="TEXT" NAME="makerphone" SIZE="30" VALUE="<?if ($makerphone!=""): print "$makerphone"; else: print "(8017)2947544"; endif;?>"></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>�������� ������ ��������� ��� ������������ ������:</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" BGCOLOR="#FFFFFF"><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="LEFT"><INPUT TYPE="CHECKBOX" STYLE="height: 11pt;"  NAME="RECALC" <?if ($RECALC=="on") print "CHECKED";?>>�������� ������ �������� ������ ������� �� ��������� ������</TD></TR>
<?
    elseif ($rep==3):
?>
          <TR><TD VALIGN="MIDDLE" ALIGN="CENTER" COLSPAN="2"><B>�������� ��������� ������ �� ������ ������������ � ������������ ���� �����:</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="DDBD" <?if ($DDBD=="on") print "CHECKED ";?>ONCLICK="F_DATE.checked=!DDBD.checked;">�� ��������� �� �����</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="DDBPN" <?if ($DDBPN=="on") print "CHECKED ";?>ONCLICK="F_FIO.checked=!DDBPN.checked; F_PRIVATENUMBER.checked=!DDBPN.checked; F_RM.checked=!DDBPN.checked; F_WORKBEGINTIME.checked=!DDBPN.checked; F_WORKENDTIME.checked=!DDBPN.checked;">�� ��������� �� ������ �������</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="SONT" <?if ($SONT=="on") print "CHECKED ";?>>���������� ������ ������ ������ �����</TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_DATE" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_DATE.checked) DDBD.checked=false;">���� &laquo;����&raquo; (����� ���������� ������ � ������, ���� �� ���������� ������ &laquo;�� ��������� �� �����&raquo;)</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_FIO" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_FIO.checked) DDBPN.checked=false;">���� &laquo;�.�.�.&raquo; (����� ���������� ������ � ������, ���� �� ���������� ������ &laquo;�� ��������� �� ������ �������&raquo;)</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_PRIVATENUMBER" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_PRIVATENUMBER.checked) DDBPN.checked=false;">���� &laquo;������ �����&raquo; (����� ���������� ������ � ������, ���� �� ���������� ������ &laquo;�� ��������� �� ������ �������&raquo;)</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_RM" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_RM.checked) DDBPN.checked=false;">���� &laquo;����� �������� �����&raquo; (����� ���������� ������ � ������, ���� �� ���������� ������ &laquo;�� ��������� �� ������ �������&raquo;)</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_WORKBEGINTIME" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_WORKBEGINTIME.checked) DDBPN.checked=false;">���� &laquo;����� ������ ������&raquo; (����� ���������� ������ � ������, ���� �� ���������� ������ &laquo;�� ��������� �� ������ �������&raquo;)</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_WORKENDTIME" <?if ($F_DDBPN!="on") print "CHECKED ";?>ONCLICK="if (F_WORKENDTTIME.checked) DDBPN.checked=false;">���� &laquo;����� ��������� ������&raquo; (����� ���������� ������ � ������, ���� �� ���������� ������ &laquo;�� ��������� �� ������ �������&raquo;)</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_WAITTIME" <?if ($F_WAITTIME=="on") print "CHECKED ";?>ONCLICK="">���� &laquo;��������&raquo;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_WORKTIME" <?if ($F_WORKTIME=="on") print "CHECKED ";?>ONCLICK="">���� &laquo;����� ������&raquo;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_PROCESSMIDDLETIME" <?if ($F_PROCESSMIDDLETIME=="on") print "CHECKED ";?>ONCLICK="">���� &laquo;������� ����� ������������&raquo;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_WAITMIDDLETIME" <?if ($F_WAITMIDDLETIME=="on") print "CHECKED ";?>ONCLICK="">���� &laquo;������� ����� ��������&raquo;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_PROCESSEDALL" <?if ($F_PROCESSEDALL=="on") print "CHECKED ";?>ONCLICK="">���� &laquo;��������� �����&raquo;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#EEEEEE" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_NOTPROCESSED" <?if ($F_NOTPROCESSED=="on") print "CHECKED ";?>ONCLICK="">���� &laquo;�� ���������&raquo;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TD BGCOLOR="#FFFFFF" COLSPAN="2"><INPUT TYPE="CHECKBOX" STYLE="height: 13pt;" NAME="F_PROCESSED" <?if ($F_PROCESSED=="on") print "CHECKED ";?>ONCLICK="">���� &laquo;���������&raquo;</TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>������� ������ ����������� (����������� ������):</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD WIDTH="50%">�������, ��������</TD><TD WIDTH="50%"><INPUT TYPE="TEXT" NAME="maker" SIZE="30" VALUE="<?if ($maker!=""): print "$maker"; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#FFFFFF"><TD>���������</TD><TD><INPUT TYPE="TEXT" NAME="makerstate" SIZE="30" VALUE="<?if ($makerstate!=""): print "$makerstate"; else: print "�������-�������������"; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD>���������� �������</TD><TD><INPUT TYPE="TEXT" NAME="makerphone" SIZE="30" VALUE="<?if ($makerphone!=""): print "$makerphone"; else: print "(8017)2947544"; endif;?>"></TD></TR>
<?
    elseif (($rep==5)||($rep==6)||($rep==7)):
?>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>������� ������ ����������� (����������� ������):</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD WIDTH="50%">�������, ��������</TD><TD WIDTH="50%"><INPUT TYPE="TEXT" NAME="maker" SIZE="30" VALUE="<?if ($maker!=""): print "$maker"; else: if ($rep==5) print "������ �.�."; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#FFFFFF"><TD>���������</TD><TD><INPUT TYPE="TEXT" NAME="makerstate" SIZE="30" VALUE="<?if ($makerstate!=""): print "$makerstate"; else: if ($rep==4): print "�������-�������������"; elseif ($rep==5): print "�������-�����������"; endif; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD>���������� �������</TD><TD><INPUT TYPE="TEXT" NAME="makerphone" SIZE="30" VALUE="<?if ($makerphone!=""): print "$makerphone"; else: if ($rep==4): print "(8017)2947544"; elseif ($rep==5): print "(8017)2853813"; endif; endif;?>"></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>�������� ������ ��������� ��� ������������ ������:</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" BGCOLOR="#FFFFFF"><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="LEFT"><INPUT TYPE="CHECKBOX" NAME="RECALC" <?if ($RECALC=="on") print "CHECKED";?>>�������� ������ �������� ������ ������� �� ��������� ������</TD></TR>
<?
    elseif (($rep==4)||($rep==8)):
?>
          <TR><TD COLSPAN="2" VALIGN="MIDDLE" ALIGN="CENTER"><B>������� ������ ����������� (����������� ������):</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD WIDTH="50%">�������, ��������</TD><TD WIDTH="50%"><INPUT TYPE="TEXT" NAME="maker" SIZE="30" VALUE="<?if ($maker!=""): print "$maker"; else: if ($rep==8) print "������ �.�."; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#FFFFFF"><TD>���������</TD><TD><INPUT TYPE="TEXT" NAME="makerstate" SIZE="30" VALUE="<?if ($makerstate!=""): print "$makerstate"; else: if ($rep==4): print "�������-�������������"; elseif ($rep==8): print "�������-�����������"; endif; endif;?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR="#EEEEEE"><TD>���������� �������</TD><TD><INPUT TYPE="TEXT" NAME="makerphone" SIZE="30" VALUE="<?if ($makerphone!=""): print "$makerphone"; else: if ($rep==4): print "(8017)2947544"; elseif ($rep==8): print "(8017)2853813"; endif; endif;?>"></TD></TR>
<?
    elseif (($rep==9)||($rep==10)):
?>
          <TR><TD VALIGN="MIDDLE" ALIGN="CENTER" COLSPAN="2"><B>����������� �������������� ��������� ��� ������������ ���������� ������</B></TD></TR>
<?
    endif;
?>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR BGCOLOR="#FFFFFF"><TD HEIGHT="13" COLSPAN="4"></TD></TR>
          <TR BGCOLOR="#FFFFFF"><TD ALIGN="CENTER" COLSPAN="4"><INPUT TYPE="SUBMIT" VALUE="����� >>>"></TD></TR>
        </TBODY>
      </TABLE>
    </FORM>
<?
  break;
  case 4: // �������� ������ ������������� ��������, ������������� ��� �������: ������, ��������, �������� �� ����, ����� � �.�.
    if (($rep==1)||($rep==2)||($rep==4)||($rep==5)||($rep==8)) $rowcount=6; elseif (($rep==3)||($rep==6)||($rep==7)||($rep==9)||($rep==10)) $rowcount=5; else $rowcount=2;
?>
    <FORM METHOD="GET">
      <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
        <TBODY BGCOLOR="#339999">
          <TR><TD BGCOLOR="WHITE" COLSPAN="4"><H1><?echo $title?></H1></TD></TR>
          <TR VALIGN="MIDDLE" HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="<?print $rowcount;?>">&nbsp;</TD><TD COLSPAN="2" WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="<?print $rowcount;?>">&nbsp;</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TH ALIGN="LEFT" WIDTH="50%" BGCOLOR="#FFFFFF">�����:</TH><TD WIDTH="50%" BGCOLOR="#EEEEEE"><?print $repnames[$rep]; ?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE"><TH ALIGN="LEFT" BGCOLOR="#EEEEEE">�����������:</TH><TD BGCOLOR="#FFFFFF"><?if (!($repcomments[$rep]=="")) print $repcomments[$rep]; else print "&#151;";?></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE">
            <TH ALIGN="LEFT" BGCOLOR="#FFFFFF">���������� �������:</TH>
            <TD BGCOLOR="#EEEEEE">
<?
    switch ($time):
      case "yesterday":
        if ($ldd<10) print "0"; print "$ldd $months2[$ldm] $ldy ����";
      break;
      case "lastweek":
        if ($lwbd<10) print "0";
        print "$lwbd $months2[$lwbm] $lwby ���� - ";
        if ($lwed<10) print "0";
        print "$lwed $months2[$lwem] $lwey ����";
      break;
      case "lastmonth":
        print "$months[$lmm] $lmy ����";
      break;
      case "lastquart":
        print "$quartals[$lqq] ������� $lqy ����";
      break;
      case "anothermonth":
        print "$months[$amm] $amy ����";
      break;
      case "anotherquart":
        print "$quartals[$aqq] ������� $aqy ����";
      break;
      case "another":
        if (($abd==$aed)&&($abm==$aem)&&($aby==$aey)):
          print "$abd $months2[$abm] $aby ����";
        else:
          print "$abd $months2[$abm] $aby ���� - $aed $months2[$aem] $aey ����";
        endif;
      break;
    endswitch;
?>
            </TD>
          </TR>
<?
    if (($rep==1)||($rep==2)):
      $s="";
      if ($C009=="on") $s .= "009 &#151; $services[009]<BR>";
      if ($C075=="on"): $s .= "075 &#151; $services[075]<BR>"; endif;
      if ($C088=="on"): $s .= "088 &#151; $services[088]<BR>"; endif;
      if ($C090=="on"): $s .= "090 &#151; $services[090]<BR>"; endif;
      if ($C091=="on"): $s .= "091 &#151; $services[091]<BR>"; endif;
      if ($C092=="on"): $s .= "092 &#151; $services[092]<BR>"; endif;
      if ($C093=="on"): $s .= "093 &#151; $services[093]<BR>"; endif;
      if ($C094=="on"): $s .= "094 &#151; $services[094]<BR>"; endif;
      if ($C095=="on"): $s .= "095 &#151; $services[095]<BR>"; endif;
      if ($C096=="on"): $s .= "096 &#151; $services[096]<BR>"; endif;
      if ($C097=="on"): $s .= "097 &#151; $services[097]<BR>"; endif;
      if ($C098=="on"): $s .= "098 &#151; $services[098]<BR>"; endif;
      if ($C099=="on"): $s .= "099 &#151; $services[099]<BR>"; endif;
      if ($C9900911=="on"): $s .= "9900911 &#151; $services[9900911]<BR>"; endif;
      if ($C9909111=="on"): $s .= "9909111 &#151; $services[9909111]<BR>"; endif;
      if ($C9909911=="on"): $s .= "9909911 &#151; $services[9909911]<BR>"; endif;
      if ($C99075=="on"): $s .= "99075 &#151; $services[99075]<BR>"; endif;
      if ($C99088=="on"): $s .= "99088 &#151; $services[99088]<BR>"; endif;
      if ($C99091=="on"): $s .= "99091 &#151; $services[99091]<BR>"; endif;
      if ($C99092=="on"): $s .= "99092 &#151; $services[99092]<BR>"; endif;
      if ($C99094=="on"): $s .= "99094 &#151; $services[99094]<BR>"; endif;
      if ($C99095=="on"): $s .= "99095 &#151; $services[99095]<BR>"; endif;
      if ($C99096=="on"): $s .= "99096 &#151; $services[99096]<BR>"; endif;
      if ($C99097=="on"): $s .= "99097 &#151; $services[99097]<BR>"; endif;
?>
          <TR HEIGHT="22" VALIGN="MIDDLE">
            <TH ALIGN="LEFT" BGCOLOR="#EEEEEE">������:
              <INPUT TYPE="HIDDEN" NAME="C009" VALUE="<?print $C009;?>">
              <INPUT TYPE="HIDDEN" NAME="C075" VALUE="<?print $C075;?>">
              <INPUT TYPE="HIDDEN" NAME="C088" VALUE="<?print $C088;?>">
              <INPUT TYPE="HIDDEN" NAME="C090" VALUE="<?print $C090;?>">
              <INPUT TYPE="HIDDEN" NAME="C091" VALUE="<?print $C091;?>">
              <INPUT TYPE="HIDDEN" NAME="C092" VALUE="<?print $C092;?>">
              <INPUT TYPE="HIDDEN" NAME="C093" VALUE="<?print $C093;?>">
              <INPUT TYPE="HIDDEN" NAME="C094" VALUE="<?print $C094;?>">
              <INPUT TYPE="HIDDEN" NAME="C095" VALUE="<?print $C095;?>">
              <INPUT TYPE="HIDDEN" NAME="C096" VALUE="<?print $C096;?>">
              <INPUT TYPE="HIDDEN" NAME="C097" VALUE="<?print $C097;?>">
              <INPUT TYPE="HIDDEN" NAME="C098" VALUE="<?print $C098;?>">
              <INPUT TYPE="HIDDEN" NAME="C099" VALUE="<?print $C099;?>">
              <INPUT TYPE="HIDDEN" NAME="C9900911" VALUE="<?print $C9900911;?>">
              <INPUT TYPE="HIDDEN" NAME="C9909111" VALUE="<?print $C9909111;?>">
              <INPUT TYPE="HIDDEN" NAME="C9909911" VALUE="<?print $C9909911;?>">
              <INPUT TYPE="HIDDEN" NAME="C99075" VALUE="<?print $C99075;?>">
              <INPUT TYPE="HIDDEN" NAME="C99088" VALUE="<?print $C99088;?>">
              <INPUT TYPE="HIDDEN" NAME="C99091" VALUE="<?print $C99091;?>">
              <INPUT TYPE="HIDDEN" NAME="C99092" VALUE="<?print $C99092;?>">
              <INPUT TYPE="HIDDEN" NAME="C99094" VALUE="<?print $C99094;?>">
              <INPUT TYPE="HIDDEN" NAME="C99095" VALUE="<?print $C99095;?>">
              <INPUT TYPE="HIDDEN" NAME="C99096" VALUE="<?print $C99096;?>">
              <INPUT TYPE="HIDDEN" NAME="C99097" VALUE="<?print $C99097;?>">
              <INPUT TYPE="HIDDEN" NAME="CHECK_ALL_VOICE" VALUE="<?print $CHECK_ALL_VOICE;?>">
              <INPUT TYPE="HIDDEN" NAME="CHECK_ALL_AUTO" VALUE="<?print $CHECK_ALL_AUTO;?>">
            </TH>
            <TD BGCOLOR="#FFFFFF"><?print $s;?></TD>
          </TR>
<?
    elseif (($rep==4)||($rep==5)||($rep==8)):
      $s="";
      if ($makerstate!="")
        $s.="$makerstate";
      if ($maker!=""):
        if ($s!="") $s.=" ";
        $s.="$maker";
      endif;
      if ($makerphone!=""):
        if ($s!="") $s .=", ";
        $s.="�������: $makerphone";
      endif;
?>
          <TR HEIGHT="22" VALIGN="MIDDLE">
            <TH ALIGN="LEFT" BGCOLOR="#EEEEEE">�����������:</TH>
            <TD BGCOLOR="#FFFFFF"><?print $s;?></TD>
          </TR>
<?
    endif;
?>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR BGCOLOR="#FFFFFF"><TD HEIGHT="13" COLSPAN="4"></TD></TR>
          <TR BGCOLOR="#FFFFFF">
            <TD ALIGN="CENTER" COLSPAN="4">
              <INPUT TYPE="HIDDEN" NAME="STEP" VALUE="3">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?print $rep;?>">
              <INPUT TYPE="HIDDEN" NAME="time" VALUE="<?print $time;?>">
<?
    if (($rep==6)||($rep==7)||($rep==9)||($rep==10)):
?>
              <INPUT TYPE="HIDDEN" NAME="amm" VALUE="<?print $amm;?>">
              <INPUT TYPE="HIDDEN" NAME="amy" VALUE="<?print $amy;?>">
<?
    endif;
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==5)||($rep==8)):
?>
              <INPUT TYPE="HIDDEN" NAME="maker" VALUE="<?print $maker;?>">
              <INPUT TYPE="HIDDEN" NAME="makerstate" VALUE="<?print $makerstate;?>">
              <INPUT TYPE="HIDDEN" NAME="makerphone" VALUE="<?print $makerphone;?>">
<?
    endif;
    if ($rep==5):
?>
              <INPUT TYPE="HIDDEN" NAME="aqq" VALUE="<?print $aqq;?>">
              <INPUT TYPE="HIDDEN" NAME="aqy" VALUE="<?print $aqy;?>">
<?
    endif;
    if ((($rep==1)||($rep==2)||($rep==5)||($rep==6)||($rep==7))&&($RECALC!="")):
?>
              <INPUT TYPE="HIDDEN" NAME="RECALC" VALUE="<?print $RECALC;?>">
<?
    endif;
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==8)):
?>
              <INPUT TYPE="HIDDEN" NAME="amm" VALUE="<?print $amm;?>">
              <INPUT TYPE="HIDDEN" NAME="amy" VALUE="<?print $amy;?>">
<?
    endif;
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)):
?>
              <INPUT TYPE="HIDDEN" NAME="abd" VALUE="<?print $abd;?>">
              <INPUT TYPE="HIDDEN" NAME="abm" VALUE="<?print $abm;?>">
              <INPUT TYPE="HIDDEN" NAME="aby" VALUE="<?print $aby;?>">
              <INPUT TYPE="HIDDEN" NAME="aed" VALUE="<?print $aed;?>">
              <INPUT TYPE="HIDDEN" NAME="aem" VALUE="<?print $aem;?>">
              <INPUT TYPE="HIDDEN" NAME="aey" VALUE="<?print $aey;?>">
<?
    endif;
    if ($rep==3):
?>
              <INPUT TYPE="HIDDEN" NAME="F_DDBD" VALUE="<?print $F_DDBD;?>">
              <INPUT TYPE="HIDDEN" NAME="F_DDBPN" VALUE="<?print $F_DDBPN;?>">
              <INPUT TYPE="HIDDEN" NAME="F_SONT" VALUE="<?print $F_SONT;?>">
              <INPUT TYPE="HIDDEN" NAME="F_DATE" VALUE="<?print $F_DATE;?>">
              <INPUT TYPE="HIDDEN" NAME="F_FIO" VALUE="<?print $F_FIO;?>">
              <INPUT TYPE="HIDDEN" NAME="F_PRIVATENUMBER" VALUE="<?print $F_PRIVATENUMBER;?>">
              <INPUT TYPE="HIDDEN" NAME="F_RM" VALUE="<?print $F_RM;?>">
              <INPUT TYPE="HIDDEN" NAME="F_WORKBEGINTIME" VALUE="<?print $F_WORKBEGINTIME;?>">
              <INPUT TYPE="HIDDEN" NAME="F_WORKENDTIME" VALUE="<?print $F_WORKENDTIME;?>">
              <INPUT TYPE="HIDDEN" NAME="F_WAITTIME" VALUE="<?print $F_WAITTIME;?>">
              <INPUT TYPE="HIDDEN" NAME="F_WORKTIME" VALUE="<?print $F_WORKTIME;?>">
              <INPUT TYPE="HIDDEN" NAME="F_PROCESSMIDDLETIME" VALUE="<?print $F_PROCESSMIDDLETIME;?>">
              <INPUT TYPE="HIDDEN" NAME="F_WAITMIDDLETIME" VALUE="<?print $F_WAITMIDDLETIME;?>">
              <INPUT TYPE="HIDDEN" NAME="F_PROCESSEDALL" VALUE="<?print $F_PROCESSEDALL;?>">
              <INPUT TYPE="HIDDEN" NAME="F_NOTPROCESSED" VALUE="<?print $F_NOTPROCESSED;?>">
              <INPUT TYPE="HIDDEN" NAME="F_PROCESSED" VALUE="<?print $F_PROCESSED;?>">
<?
    endif;
?>
              <INPUT TYPE="SUBMIT" VALUE="<<< �����">
            </TD>
          </TR>
        </TBODY>
      </TABLE>
    </FORM>
<?
    if (($rep==1) && ($C009!="on") && ($C075!="on") && ($C088!="on") && ($C090!="on") && ($C091!="on") && ($C092!="on") && ($C093!="on") && ($C094!="on") && ($C095!="on") && ($C096!="on") && ($C097!="on") && ($C098!="on") && ($C099!="on") && ($C9900911!="on") && ($C9909111!="on") && ($C9909911!="on") && ($C99075!="on") && ($C99088!="on") && ($C99091!="on") && ($C99092!="on") && ($C99094!="on") && ($C99095!="on") && ($C99096!="on") && ($C99097!="on")):
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>�� ������ ������� ���� �� ���� �� ����� ��� ��� ������������ ������� ������!<BR><BR>������� ������ <B>&laquo;�����&raquo;</B> ��� �������� � ���� ������ ����� ���.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <!--TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR-->
        <!--TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"></TD></TD></TR-->
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
      die("");
    endif;
    if ((($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==5)||($rep==8))&&(($maker=="")||($makerstate=="")||($makerphone==""))):
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>�� ������ ��������� ���� &laquo;<?if ($maker==""): echo "�������, ��������"; elseif ($makerstate==""): echo "���������"; elseif ($makerphone==""): echo "���������� �������"; endif;?> �����������&raquo; ��� ������������ ������� ������!<BR><BR>������� ������ <B>&laquo;�����&raquo;</B> ��� �������� � ���� ������ ����� ���.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <!--TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR-->
        <!--TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"></TD></TD></TR-->
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
      die("");
    endif;
?>
    <FORM METHOD="GET">
      <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
        <TBODY BGCOLOR="#339999">
<?
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==5)||($rep==6)||($rep==7)||($rep==8)): $rowcount=21-4;
    elseif (($rep==9)||($rep==10)): $rowcount=3;
    else: $rowcount=3;
    endif;
?>
          <TR VALIGN="MIDDLE" HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="<?print $rowcount;?>">&nbsp;</TD><TD COLSPAN="2" WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="<?print $rowcount;?>">&nbsp;</TD></TR>
<?
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==5)||($rep==6)||($rep==7)||($rep==8)):
?>
          <TR VALIGN="MIDDLE" ALIGN="CENTER"><TD HEIGHT="15" COLSPAN="2"><B>�������� ��������, ������� ���������� ���������:</B></TD></TR>
          <TR VALIGN="MIDDLE" ALIGN="CENTER"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
<?
      // if ($rep==1) $ACTION="email";
      if ($ACTION==""): if ($rep==1) $ACTION="print"; elseif (($rep==2)||($rep==3)||($rep==4)||($rep==5)||($rep==6)||($rep==7)||($rep==8)) $ACTION="print"; endif;
      if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==5)) $orientation="�������";
      elseif (($rep==6)||($rep==7)||($rep==8)) $orientation="���������"; // �������� ���������� �������� ��� �������
?>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT" COLSPAN="2"><INPUT TYPE="RADIO" NAME="ACTION" VALUE="print" STYLE='height:13px;'<?if ($ACTION=="print") print " CHECKED";?>><B>���������� ��������, ���������� � ������</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT"" COLSPAN="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B><FONT COLOR="#FF0000">��������!</FONT></B> ��� ������ ���������� ��������� � ���� <B>|����|��������� ��������&#133;|</B> ��������� ��������� ��������:</TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������ �����:</TD><TD><B><?if ($orientation=="�������") print "20.00"; elseif ($orientation=="���������") print "5.00";?></B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������ ������:</TD><TD><B>5.00</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������ ������:</TD><TD><B>5.00</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������ �����:</TD><TD><B>5.00</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���������� ��������:</TD><TD><B><?print $orientation;?></B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������ ����������:</TD><TD><B>&b&b�������� &p �� &P</B></TD></TR>
          <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT" COLSPAN="2"><INPUT TYPE="RADIO" NAME="ACTION" VALUE="email" STYLE='height:13px;'<?if ($ACTION=="email") print " CHECKED";?>><B>�������� �� ����������� �����</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT" WIDTH="50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������� ������� ����������:</TD><TD>����: <INPUT TYPE="TEXT" NAME="EMAIL1Addr" SIZE="30" VALUE="<?if ($rep==1) print "irai@mgts.by"?>"><BR>����: <INPUT TYPE="TEXT" NAME="EMAIL1Name" SIZE="30" VALUE="<?if ($rep==1) print "���� ����� ����������";?>"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������� ������� ����������:</TD><TD>����: <INPUT TYPE="TEXT" NAME="EMAIL2Addr" SIZE="30" VALUE=""><BR>����: <INPUT TYPE="TEXT" NAME="EMAIL2Name" SIZE="30" VALUE=""></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������� �������� ����������:</TD><TD>����: <INPUT TYPE="TEXT" NAME="EMAIL3Addr" SIZE="30" VALUE=""><BR>����: <INPUT TYPE="TEXT" NAME="EMAIL3Name" SIZE="30" VALUE=""></TD></TR>
<!--
          <TR VALIGN="MIDDLE"><TD HEIGHT="6" COLSPAN="2"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT" COLSPAN="2"><INPUT TYPE="RADIO" NAME="ACTION" VALUE="save" STYLE='height:13px;'<?if ($ACTION=="save") print " CHECKED";?>><B>���������� � ���� �� �����</B></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#EEEEEE><TD ALIGN="LEFT" WIDTH="50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������� ���� ��� ���������� �����:</TD><TD><INPUT TYPE="TEXT" NAME="SAVEPATH" SIZE="30" VALUE="C:\"></TD></TR>
          <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="LEFT">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�������� ������ �����:</TD><TD><SELECT NAME="savefiletype"><OPTION VALUE="htm" CHECKED>htm</OPTION><OPTION VALUE="txt">txt</OPTION><OPTION VALUE="csv">csv</OPTION></SELECT></TD></TR>
-->
<?
    elseif (($rep==9)||($rep==10)):
?>
          <TR><TD VALIGN="MIDDLE" ALIGN="CENTER" COLSPAN="2"><B>���������� ����� �������� ��� ������������ ���������� ������</B></TD></TR>
<?
    endif;
?>
          <TR VALIGN="MIDDLE"><TD HEIGHT="15" COLSPAN="2"></TD></TR>
          <TR BGCOLOR="#FFFFFF"><TD HEIGHT="13" COLSPAN="4"></TD></TR>
          <TR BGCOLOR="#FFFFFF">
            <TD ALIGN="CENTER" COLSPAN="4">
              <INPUT TYPE="HIDDEN" NAME="STEP" VALUE="5">
              <INPUT TYPE="HIDDEN" NAME="rep" VALUE="<?print $rep;?>">
              <INPUT TYPE="HIDDEN" NAME="time" VALUE="<?print $time;?>">
<?
    if (($rep==6)||($rep==7)):
?>
              <INPUT TYPE="HIDDEN" NAME="amm" VALUE="<?print $amm;?>">
              <INPUT TYPE="HIDDEN" NAME="amy" VALUE="<?print $amy;?>">
<?
    endif;
    if ($rep==5):
?>
              <INPUT TYPE="HIDDEN" NAME="aqq" VALUE="<?print $aqq;?>">
              <INPUT TYPE="HIDDEN" NAME="aqy" VALUE="<?print $aqy;?>">
<?
    endif;
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==5)||($rep==8)):
?>
              <INPUT TYPE="HIDDEN" NAME="maker" VALUE="<?print $maker;?>">
              <INPUT TYPE="HIDDEN" NAME="makerstate" VALUE="<?print $makerstate;?>">
              <INPUT TYPE="HIDDEN" NAME="makerphone" VALUE="<?print $makerphone;?>">
<?
    endif;
    if ((($rep==1)||($rep==2)||($rep==5)||($rep==6)||($rep==7))&&($RECALC!="")):
?>
              <INPUT TYPE="HIDDEN" NAME="RECALC" VALUE="<?print $RECALC;?>">
<?
    endif;
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)||($rep==8)):
?>
              <INPUT TYPE="HIDDEN" NAME="amm" VALUE="<?print $amm;?>">
              <INPUT TYPE="HIDDEN" NAME="amy" VALUE="<?print $amy;?>">
<?
    endif;
    if (($rep==1)||($rep==2)||($rep==3)||($rep==4)):
?>
              <INPUT TYPE="HIDDEN" NAME="abd" VALUE="<?print $abd;?>">
              <INPUT TYPE="HIDDEN" NAME="abm" VALUE="<?print $abm;?>">
              <INPUT TYPE="HIDDEN" NAME="aby" VALUE="<?print $aby;?>">
              <INPUT TYPE="HIDDEN" NAME="aed" VALUE="<?print $aed;?>">
              <INPUT TYPE="HIDDEN" NAME="aem" VALUE="<?print $aem;?>">
              <INPUT TYPE="HIDDEN" NAME="aey" VALUE="<?print $aey;?>">
<?
    endif;
    if (($rep==1)||($rep==2)):
?>
              <INPUT TYPE="HIDDEN" NAME="C009" VALUE="<?print $C009;?>">
              <INPUT TYPE="HIDDEN" NAME="C075" VALUE="<?print $C075;?>">
              <INPUT TYPE="HIDDEN" NAME="C088" VALUE="<?print $C088;?>">
              <INPUT TYPE="HIDDEN" NAME="C090" VALUE="<?print $C090;?>">
              <INPUT TYPE="HIDDEN" NAME="C091" VALUE="<?print $C091;?>">
              <INPUT TYPE="HIDDEN" NAME="C092" VALUE="<?print $C092;?>">
              <INPUT TYPE="HIDDEN" NAME="C093" VALUE="<?print $C093;?>">
              <INPUT TYPE="HIDDEN" NAME="C094" VALUE="<?print $C094;?>">
              <INPUT TYPE="HIDDEN" NAME="C095" VALUE="<?print $C095;?>">
              <INPUT TYPE="HIDDEN" NAME="C096" VALUE="<?print $C096;?>">
              <INPUT TYPE="HIDDEN" NAME="C097" VALUE="<?print $C097;?>">
              <INPUT TYPE="HIDDEN" NAME="C098" VALUE="<?print $C098;?>">
              <INPUT TYPE="HIDDEN" NAME="C099" VALUE="<?print $C099;?>">
              <INPUT TYPE="HIDDEN" NAME="C9900911" VALUE="<?print $C9900911;?>">
              <INPUT TYPE="HIDDEN" NAME="C9909111" VALUE="<?print $C9909111;?>">
              <INPUT TYPE="HIDDEN" NAME="C9909911" VALUE="<?print $C9909911;?>">
              <INPUT TYPE="HIDDEN" NAME="C99075" VALUE="<?print $C99075;?>">
              <INPUT TYPE="HIDDEN" NAME="C99088" VALUE="<?print $C99088;?>">
              <INPUT TYPE="HIDDEN" NAME="C99091" VALUE="<?print $C99091;?>">
              <INPUT TYPE="HIDDEN" NAME="C99092" VALUE="<?print $C99092;?>">
              <INPUT TYPE="HIDDEN" NAME="C99094" VALUE="<?print $C99094;?>">
              <INPUT TYPE="HIDDEN" NAME="C99095" VALUE="<?print $C99095;?>">
              <INPUT TYPE="HIDDEN" NAME="C99096" VALUE="<?print $C99096;?>">
              <INPUT TYPE="HIDDEN" NAME="C99097" VALUE="<?print $C99097;?>">
              <INPUT TYPE="HIDDEN" NAME="CHECK_ALL_VOICE" VALUE="<?print $CHECK_ALL_VOICE;?>">
              <INPUT TYPE="HIDDEN" NAME="CHECK_ALL_AUTO" VALUE="<?print $CHECK_ALL_AUTO;?>">
<?
    endif;
?>
              <INPUT TYPE="SUBMIT" VALUE="����� >>>">
            </TD>
          </TR>
        </TBODY>
      </TABLE>
    </FORM>
<?
  break;
  case 5: // ��� - ����� ������ �� ����� � ������ �������� (�������� �� ��. �����, �� ����, ���������� � ���� �� �����)
    $DEBUG="off";

    // ����������� ����������� ������ �� FTP
    if (($rep==9)||($rep==10)):
      $ftp_server="10.1.1.2";
      $conn_id=ftp_connect($ftp_server);
      if ($conn_id<1) die("    <TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD ALIGN=\"CENTER\" WIDTH=\"62px\" STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">FTP</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0; font: \">�� ������� ���������� ���������� � FTP-�������� <B>$ftp_server</B>!</TD></TR></TABLE>\n  </BODY>\n</HTML>");
      $login_result=ftp_login($conn_id, "root", "kron");
      if ((!$conn_id)||(!$login_result)) die("    <TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD ALIGN=\"CENTER\" WIDTH=\"62px\" STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">FTP</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0; font: \">�� ������� ������������ � FTP-������� <B>$ftp_server</B> ��� ��������� ������� � �������! ���������� � �������������� ����.</TD></TR></TABLE>\n  </BODY>\n</HTML>");
      else
        if ($DEBUG=="on"):
?>
    <TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">FTP</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">���������� � FTP-�������� <B><?echo $ftp_server;?></B> ���������.</TD></TR></TBODY></TABLE>
<?
        endif;
      ftp_quit($conn_id);
      if ($DEBUG=="on"):
?>
    <TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">FTP</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������� ����������� ���������� � FTP-�������� <B><?echo $ftp_server;?></B>.</TD></TR></TBODY></TABLE>
<?
      endif;
    endif;

    // ���������� ����������� � ������� 10.1.1.250 - �� ��������� ������ ������� �� ������� MAINSERVER, � ��� � ������ ������� - � DBSERVER

    $HostName="10.1.1.250";
    $UserName="sel";
    $Password="";
    $DBName="newstat";
    $MYSQLCON=MYSQL_CONNECT($HostName,$UserName,$Password) OR die("    <TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">My-SQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0;\">�� ������� ���������� ����������� � MySQL-������� <B>$HostName</B>!</TD></TR></TABLE>\n  </BODY>\n</HTML>");
    MYSQL_SELECT_DB("$DBName") OR die("    <TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">My-SQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0; font: \">�� ������� ���������� ����������� � �� <B>$DBName</B> �� MySQL-������� <B>$HostName</B>!</TD></TR></TABLE>\n  </BODY>\n</HTML>");
    if ($DEBUG=="on"):
?>
    <TABLE BORDER="1" ALIGN="CENTER" STYLE="margin-bottom: 1px; border-color: black; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">My-SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������� ���������� ����������� � �� <B><?echo $DBName;?></B> �� MySQL-������� <B><?echo $HostName;?></B>.</TD></TR></TBODY></TABLE>
<?
    endif;









































    // ������������ ������ #1

    if ($rep==1):
      if ($time=="lastweek"):
        $startday=$lwbd;
        $stopday=$lwed;
        $startmonth=$lwbm;
        $stopmonth=$lwem;
        $startyear=$lwby;
        $stopyear=$lwey;
      elseif ($time=="yesterday"):
        $startday=$ldd;
        $stopday=$ldd;
        $startmonth=$ldm;
        $stopmonth=$ldm;
        $startyear=$ldy;
        $stopyear=$ldy;
      elseif ($time=="lastmonth"):
        $startday=$lmbd;
        $stopday=$lmed;
        $startmonth=$lmm;
        $stopmonth=$lmm;
        $startyear=$lmy;
        $stopyear=$lmy;
      elseif ($time=="anothermonth"):
        $startday=$amd;
        $stopday=$amd;
        $startmonth=$amm;
        $stopmonth=$amm;
        $startyear=$amy;
        $stopyear=$amy;
      elseif ($time=="another"):
        $startday=$abd;
        $stopday=$aed;
        $startmonth=$abm;
        $stopmonth=$aem;
        $startyear=$aby;
        $stopyear=$aey;
      endif;

      // ���������� ���������������� �������, � ������� ���������� ������ � ���, ����� �� �������� �� ������ ����������� ������ ��� ���
      $a[0]=$C009; $a[1]=$C075; $a[2]=$C088; $a[3]=$C090; $a[4]=$C091; $a[5]=$C092; $a[6]=$C093; $a[7]=$C094; $a[8]=$C095; $a[9]=$C096; $a[10]=$C097; $a[11]=$C098; $a[12]=$C099; $a[13]=$C9900911; $a[14]=$C9909111; $a[15]=$C9909911; $a[16]=$C99075; $a[17]=$C99088; $a[18]=$C99091; $a[19]=$C99092; $a[20]=$C99094; $a[21]=$C99095; $a[22]=$C99095; $a[23]=$C99096; $a[24]=$C99097;

      $currentd=$startday+0;
      $currentm=$startmonth+0;
      $currenty=$startyear+0;


      $daycount=mktime(0,0,0,$stopmonth+0,$stopday+0,$stopyear+0)-mktime(0,0,0,$startmonth,$startday,$startyear);

      if ($daycount>=0): // ���������� ���� ����������� � ������ ������, ��� 0 - �������� �������� �����
        // ������������ ��������� ������ ��� ����������� ��� ������
        $title="����������&nbsp;��&nbsp;�������&nbsp;��� "; if (($time=="lastmonth")||($time=="anothermonth")||(($time=="another")&&(($startday==$lmbd)&&($startmonth==$lmm)&&($startyear==$lmy)&&($stopday==$lmed)&&($stopmonth==$lmm)&&($stopyear==$lmy)))): $title.="��&nbsp;$months[$startmonth]&nbsp;$startyear&nbsp;����"; elseif ((($time=="another")&&(($startday==$stopday)&&($startmonth==$stopmonth)&&($startyear==$stopyear)))||($time=="yesterday")): $title.="��&nbsp;$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;����"; else: $title.="��&nbsp;������ �&nbsp;$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;���� ��&nbsp;$stopday&nbsp;$months2[$stopmonth]&nbsp;$stopyear&nbsp;����"; endif;
?>
    <TABLE BORDER="1" WIDTH="100%" ALIGN="CENTER" STYLE="border-width: 0; border-style: solid; border-color: black; font-size: 8pt">
      <TBODY>
        <TR STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0;"><TD COLSPAN="7" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0;"><H1><?echo $title;?></H1></TD></TR>
        <TR VALIGN="MIDDLE" STYLE="border: 0 solid black;"><TH ROWSPAN="2" STYLE="border-color: black; border-style: solid; border-width: 2px;">�������<BR>������</TH><TH ROWSPAN="2" STYLE="border-color: black; border-style: solid; border-width: 2px 2px 2px 0;">������������<BR>������</TH><TH ROWSPAN="2" STYLE="border-color: black; border-style: solid; border-width: 2px 2px 2px 0;">���������<BR>�������</TH><TH COLSPAN="2" STYLE="border-color: black; border-style: solid; border-width: 2px 2px 1px 0;">������������<BR>�������</TH><TH ROWSPAN="2" STYLE="border-color: black; border-style: solid; border-width: 2px 2px 2px 0;">�������&nbsp;�����<BR>������&nbsp;(�&nbsp;���.)</TH><TH ROWSPAN="2" STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">�������<BR>�&nbsp;������***</TH></TR>
        <TR VALIGN="MIDDLE" STYLE="border: 0 solid black;"><TH STYLE="border-color: black; border-style: solid; border-width: 0 1px 2px 0;">�&nbsp;���.*</TH><TH STYLE="border-color: black; border-style: solid; border-width: 0 2px 2px 0;">�&nbsp;���.**</TH></TR>
        <TR ALIGN="CENTER" STYLE="font-size: 6pt;"><TD STYLE="padding: 2px; border-color: black; border-style: solid; border-width: 0 2px 2px 2px;"><B>I</B></TD><TD STYLE="padding: 2px; border-color: black; border-style: solid; border-width: 0 2px 2px 0;"><B>II</B></TD><TD STYLE="padding: 2px; border-color: black; border-style: solid; border-width: 0 2px 2px 0;"><B>III</B></TD><TD STYLE="padding: 2px; border-color: black; border-style: solid; border-width: 0 1px 2px 0;"><B>IV</B></TD><TD STYLE="padding: 2px; border-color: black; border-style: solid; border-width: 0 2px 2px 0;"><B>V</B></TD><TD STYLE="padding: 2px; border-color: black; border-style: solid; border-width: 0 2px 2px 0;"><B>VI</B><BR><FONT STYLE="font-size: 6pt;">(��. IV / ��. III)</FONT></TD><TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>VII</B><BR><FONT STYLE="font-size: 6pt;"></FONT></TD></TR>
<?
          if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">�������� ������� ������� <B>newstat.rep1</B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
          endif;
        // �������� �� ������� ������� newstat.rep1
        $q="SHOW TABLES FROM newstat LIKE 'rep1';";
        if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
        endif;
        $table=MYSQL_QUERY($q);
        $num_rows=MYSQL_NUM_ROWS($table);
        if ($num_rows!=0):
          if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������� <B>newstat.rep1</B> ������� �������.</TD></TR></TABLE></TD></TR>
<?
          endif;
        else:
          if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������� <B>newstat.rep1</B> �� �������!</TD></TR></TABLE></TD></TR>
<?
          endif;
          if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">�������� ������� <B>newstat.rep1</B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
          endif;
          $len=0;
          for ($j=0;$j<count($servicelist);$j++)
            if ($len<strlen($servicelist[$j]))
              $len=strlen($servicelist[$j]);
          $q="CREATE TABLE newstat.rep1 (service char($len) NOT NULL default '', year_month_day char(8) NOT NULL default '', served_calls int(10) unsigned default NULL, duration_in_sec int(10) unsigned default NULL, duration_in_min int(10) unsigned default NULL, average_duration_in_sec decimal(10,2) default NULL, calls_to_pay int(10) unsigned default NULL) TYPE=MyISAM;";
          MYSQL_QUERY($q);
          if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
          endif;
          $q="SHOW TABLES FROM newstat LIKE 'rep1';";
          $table=MYSQL_QUERY($q);
          $num_rows=MYSQL_NUM_ROWS($table);
          if ($num_rows!=0):
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������� <B>newstat.rep1</B> ������� �������.</TD></TR></TABLE></TD></TR>
<?
            endif;
          else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>�� ������ ������� ������� <B>newstat.rep1</B>! ���������� � ���������� ��������������!<BR><BR>������� ������ <B>&laquo;�����&raquo;</B> ��� �������� � ����������� ���� ������������ ������.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
            die("");
          endif;
        endif;

// ������ �����

        $i=1;
        while ($i>0):
          if ($currentd<10) $cd="0$currentd"; else $cd="$currentd";
          if ($currentm<10) $cm="0$currentm"; else $cm="$currentm";
          $flag1=0; // ������������� ���� ���������� � ���� ("�� �������")
// ����������� � MySQL-������� MAINSERVER � ������, ���� ������� ����������� ��� ���
          if ($HostName!="10.1.1.250"):
            MYSQL_CLOSE($MYSQLCON);
            $HostName="10.1.1.250";
            $UserName="sel";
            $Password="";
            $DBName="newstat";
            $MYSQLCON=MYSQL_CONNECT($HostName,$UserName,$Password) OR die("        <TR><TD COLSPAN=4 STYLE=\"padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;\"><TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">MySQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0;\">�� ������� ���������� ����������� � MySQL-������� <B>$HostName</B>!</TD></TR></TABLE></TD></TR>\n      </TBODY>\n    </TABLE>\n  </BODY>\n</HTML>");
            MYSQL_SELECT_DB("$DBName") OR die("        <TR><TD COLSPAN=4 STYLE=\"padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;\"><TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">MySQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0;\">�� ������� ���������� ����������� � �� <B>$DBName</B> �� MySQL-������� <B>$HostName</B>!</TD></TR></TABLE></TD></TR>\n      </TBODY>\n    </TABLE>\n  </BODY>\n</HTML>");
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD WIDTH="62px" ALIGN="CENTER" STYLE="border-color: white; border-style: solid; border-width: 0;">������� ���������� ����������� � �� <B><?echo $DBName;?></B> �� MySQL-������� <B><?echo $HostName;?></B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
          endif;
// �������� ������ ������ �� ���� �� ���� ������� �� "�������" ���ר���� ����
          if ($RECALC=="on"):
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">�������� ����� ����������� ������ �� ������� <B>newstat.rep1</B> �� <?echo "$currentd $months2[$currentm] $currenty ����";?>.</TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
            for ($serv=0;$serv<count($servicelist);$serv++):
              if ($a[$serv]=="on"):
                $q="DELETE FROM newstat.rep1 WHERE year_month_day='$currenty$cm$cd' AND service='$servicelist[$serv]';";
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
                MYSQL_QUERY($q);
              endif;
            endfor;
          endif;
// ����� ����������� ������ �� "�������" ������ �� "�������" ���ר���� ���� � ������� newstat.rep1
            for ($serv=0;$serv<count($servicelist);$serv++):
              if ($a[$serv]=="on"):
                $flag2=0; // ������������� ���� ��� ������������ ���������� � 0 ("�� ������")
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">����� ����� ����������� ������ �� ������ <B><?echo "$servicelist[$serv]";?></B> � ������� <B>newstat.rep1</B> �� <B><?echo "$currentd $months2[$currentm] $currenty ����";?></B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
                $q="SELECT COUNT(*) AS f1 FROM newstat.rep1 WHERE year_month_day='$currenty$cm$cd' AND service='$servicelist[$serv]';";
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
                $table=MYSQL_QUERY($q);
                $num_rows=MYSQL_NUM_ROWS($table);
                if ($num_rows==1):
                  $f1=MYSQL_RESULT($table, 0, "f1");
                  if ($f1==1):
                    if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">����� ����������� ��������� �� ������ <B><?echo "$servicelist[$serv]";?></B> �� <B><?echo "$currentd $months2[$currentm] $currenty ����";?></B> ������� ������.</TD></TR></TABLE></TD></TR>
<?
                    endif;
                    $flag2=1; // ������������� ���� ���������� ��� ������������ ���������� � 1 ("������")
                  else:
                    if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������ �� ������ <B><?echo "$servicelist[$serv]";?></B> �� <B><?echo "$currentd $months2[$currentm] $currenty ����";?></B> � ������� <B>newstat.rep1</B> �� �������!</TD></TR></TABLE></TD></TR>
<?
                    endif;
                  endif;
                else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>���� ��� ��������� ������ �� ������ <?echo "$servicelist[$serv]";?> �� <?echo "$currentd $months2[$currentm] $currenty ����";?> �� ������� newstat.rep1! ���������� � ���������� ��������������!<BR><BR>������� ������ <B>&laquo;�����&raquo;</B> ��� �������� � ����������� ���� ������������ ������.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
                  die("");
                endif;
// � ����������� �� ���� ������� �� ������ �� "�������" ���ר���� ���� �� "�������" ������ � ������� newstat.rep1
                if ($flag2!=1):
// ���� ������ �� ���� ������� - ������ ���ר� ������ � ��������� �� � ������� newstat.rep1
  // �����Ш���� ���������� ������ ������ � ���������� � �������� mainserver@arj.ird_��������, mainserver@arj.irda_������, dbserver@statistika.ird_��������
                  $current_table="arj.ird_$currenty$cm$cd";
    // ���� ������ ���� �������� � ������ ������� - ������������� ���� ����������
    // ���� ���� ���������� �� ����������, �������� ����� �� ������ �������
    // ���� ������ ���� �������� �� ������ ������� - ������������� ���� ����������
    // ���� ���� ���������� �� ����������, ���������� ������������ �� dbserver � �������� ����� �� ������ �������
    // ���� ������ ���� �������� �� ������ ������� - ������������� ���� ����������
    // ���� ���� ���������� �� ���������� - ������� �� ������ "������ �� �������!"
  // ���� ���� ��������� ���������� - ��������� �������
    // ��������� ������ �� ���ר� ������ �� ����������� ���������, ������������� � �������� ������� ������
                  $row1="$servicelist[$serv]";
                  $row2="$currenty$cm$cd";
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������ ���������� ����������� �������, ������������ ������� � �������� ������� ������ �� ������ <B><?echo "$servicelist[$serv]";?></B> �� <B><?echo "$currentd $months2[$currentm] $currenty ����";?></B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  $q="SELECT COUNT(*) AS row3, SUM(dur) AS row4, SUM(SEC_TO_TIME(CEILING(dur/60))) AS row5, SUM(dur)/COUNT(*) AS row6 FROM $current_table WHERE $service_servedcondition[$row1] AND datum='$currenty-$cm-$cd';";
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  $table=MYSQL_QUERY($q);
                  $num_rows=MYSQL_NUM_ROWS($table);
                  if ($num_rows==1):
                    $row3=MYSQL_RESULT($table, 0, "row3");
                    $row4=MYSQL_RESULT($table, 0, "row4");
                    $row5=MYSQL_RESULT($table, 0, "row5");
                    $row6=MYSQL_RESULT($table, 0, "row6");
                    if ($row3=="") $row3=0;
                    if ($row4=="") $row4=0;
                    if ($row5=="") $row5=0;
                    if ($row6=="") $row6=0;
                    if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">���������� ����������� �������, ������������ ������� � ������� ����� ������ �� ������ <B><?echo "$servicelist[$serv]";?></B> �� <B><?echo "$currentd $months2[$currentm] $currenty ����";?></B> ������� ���������.</TD></TR></TABLE></TD></TR>
<?
                    endif;
                  else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>���� ��� ������� ���������� ����������� �������, ������������ ������� � �������� ������� ������ �� ������ <?echo "$servicelist[$serv]";?> �� <?echo "$currentd $months2[$currentm] $currenty ����";?>! ���������� � ���������� ��������������!<BR><BR>������� ������ <B>&laquo;�����&raquo;</B> ��� �������� � ����������� ���� ������������ ������.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
                    die("");
                  endif;
    // ��������� ������ �� ���ר� ������ �� ������������ �������
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������ ���������� ������� � ������ �� ������ <B><?echo "$servicelist[$serv]";?></B> �� <B><?echo "$currentd $months2[$currentm] $currenty ����";?></B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  $q="SELECT COUNT(*) AS row7 FROM $current_table WHERE $service_billingcondition[$row1] AND datum='$currenty-$cm-$cd';";
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  $table=MYSQL_QUERY($q);
                  $num_rows=MYSQL_NUM_ROWS($table);
                  if ($num_rows==1):
                    $row7=MYSQL_RESULT($table, 0, "row7");
                    if ($row7!=""):
                      if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">���������� ���������� ������ ������� �� ������ <B><?echo "$servicelist[$serv]";?></B> �� <B><?echo "$currentd $months2[$currentm] $currenty ����";?></B> ������� ���������.</TD></TR></TABLE></TD></TR>
<?
                      endif;
    // ��������� � ���� ����������� ������
                      if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">���������� ����������� ������ �� ������ <B><?echo "$servicelist[$serv]";?></B> �� <B><?echo "$currentd $months2[$currentm] $currenty ����";?></B> � ������� <B>newstat.rep1</B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
                      endif;
                      $q="INSERT INTO newstat.rep1(service, year_month_day, served_calls, duration_in_sec, duration_in_min, average_duration_in_sec, calls_to_pay) VALUES ('$row1', '$row2', $row3, $row4, $row5, $row6, $row7);";
                      if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                      endif;
                      MYSQL_QUERY($q);
                    else:
                      if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">�� ������� ��������� ���������� ���������� ������ ������� �� ������ <B><?echo "$servicelist[$serv]";?></B> �� <B><?echo "$currentd $months2[$currentm] $currenty ����";?></B>!</TD></TR></TABLE></TD></TR>
<?
                      endif;
                    endif;
                  else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>���� ��� ������� ���������� ���������� ������ ������� �� ������ <?echo "$servicelist[$serv]";?> �� <?echo "$currentd $months2[$currentm] $currenty ����";?>! ���������� � ���������� ��������������!<BR><BR>������� ������ <B>&laquo;�����&raquo;</B> ��� �������� � ����������� ���� ������������ ������.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
                    die("");
                  endif;
                endif;
              endif;
            endfor;
          // ������������� ����
          $ncurrentd=date("d",mktime(5,0,0,$currentm,$currentd,$currenty)+((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))))+0;
          $ncurrentm=date("m",mktime(5,0,0,$currentm,$currentd,$currenty)+((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))))+0;
          $ncurrenty=date("Y",mktime(5,0,0,$currentm,$currentd,$currenty)+((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))))+0;
          $currentd=$ncurrentd;
          $currentm=$ncurrentm;
          $currenty=$ncurrenty;

// !!!!!!!!!! ���� ��� �������� ����� - ����� ���������� � 2 �� 2 ����� ����� ����������� ���� �� ������ ����� � � ? �� ? - ����� ������
          $i=mktime(2,0,0,$stopmonth+0,$stopday+0,$stopyear+0)-mktime(2,0,0,$currentm+0,$currentd+0,$currenty+0);
// !!!!!!!!!!
        endwhile;


        for ($serv=0;$serv<count($servicelist);$serv++):
          if ($a[$serv]=="on"):
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">��������� �������� ������ �� ������ <B><?echo $servicelist[$serv];?></B> �� ������ � <B><?echo "$startday $months2[$startmonth] $startyear";?> ����</B> �� <B><?echo "$stopday $months2[$stopmonth] $stopyear";?> ����</B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
            $q="SELECT service AS f1, SUM(served_calls) AS f2, SUM(duration_in_sec) AS f3, SUM(duration_in_min) AS f4, SUM(duration_in_sec)/sum(served_calls) AS f5, SUM(calls_to_pay) AS f6 FROM newstat.rep1 WHERE (service='$servicelist[$serv]') AND (year_month_day BETWEEN '$startyear";
            if ($startmonth<10) $q.="0";
            $q.="$startmonth";
            if ($startday<10) $q.="0";
            $q.="$startday' AND '$stopyear";
            if ($stopmonth<10) $q.="0";
            $q.="$stopmonth";
            if ($stopday<10) $q.="0";
            $q.="$stopday') GROUP BY service;";
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
            $table=MYSQL_QUERY($q);
            $num_rows=MYSQL_NUM_ROWS($table);
            if ($num_rows==1):
              $f1=MYSQL_RESULT($table, 0, "f1");
              $f2=MYSQL_RESULT($table, 0, "f2");
              $f3=MYSQL_RESULT($table, 0, "f3");
              $f4=MYSQL_RESULT($table, 0, "f4");
              $f5=MYSQL_RESULT($table, 0, "f5");
              $f6=MYSQL_RESULT($table, 0, "f6");
              if (($f1!=0)||($f2!="")||($f3!="")||($f4!="")||($f5!="")||($f6!="")):
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������ �� ������ <B><?echo $servicelist[$serv];?></B> �� ������ � <B><?echo "$startday $months2[$startmonth] $startyear";?> ����</B> �� <B><?echo "$stopday $months2[$stopmonth] $stopyear";?> ����</B> ������� ��������.</TD></TR></TABLE></TD></TR>
<?
                endif;
              else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>�� ������� �������� ���������� ������� �� ������� <B>newstat.rep1</B>! ���������� � ���������� ��������������!<BR><BR>������� ������ <B>&laquo;�����&raquo;</B> ��� �������� � ����������� ���� ������������ ������.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
                die("");
              endif;
            else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>���� ��� ��������� ������������� ������� �� ������� <B>newstat.rep1</B>! ���������� � ���������� ��������������!<BR><BR>������� ������ <B>&laquo;�����&raquo;</B> ��� �������� � ����������� ���� ������������ ������.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
              die("");
            endif;
            if (($f2!=0)||($f3!=0)||($f4!=0)||($f5!=0)||($f6!=0)): // ���� ������ �� "�������" ������ ���� - ������� �� � �����

?>
        <TR VALIGN="MIDDLE" STYLE="border: 0 solid #000000;">
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;" ALIGN="CENTER"><?echo $f1;?></TD>
          <TD ALIGN="LEFT" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?echo $services[$f1];?></TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?echo $f2;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;"><?echo $f3;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?echo $f4;?></TD>
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?echo $f5;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?echo $f6;?></TD>
        </TR>
<?
            endif;
          endif;
        endfor;

        // ������������ ������ ��������� �������
        $q1="";
        for ($serv=0;$serv<count($servicelist);$serv++):
          if ($a[$serv]=="on"):
            if ($q1!="") $q1.=" OR ";
            $q1.="(service='$servicelist[$serv]')";
          endif;
        endfor;
        if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">��������� �������� ������ �� ���� ��������� ������� �� ������ � <B><?echo "$startday $months2[$startmonth] $startyear";?> ����</B> �� <B><?echo "$stopday $months2[$stopmonth] $stopyear";?> ����</B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
        endif;
        $q="SELECT SUM(served_calls) AS f1, SUM(duration_in_sec) AS f2, SUM(duration_in_min) AS f3, SUM(duration_in_sec)/sum(served_calls) AS f4, SUM(calls_to_pay) AS f5 FROM newstat.rep1 WHERE ($q1) AND (year_month_day BETWEEN '$startyear";
        if ($startmonth<10) $q.="0";
        $q.="$startmonth";
        if ($startday<10) $q.="0";
        $q.="$startday' AND '$stopyear";
        if ($stopmonth<10) $q.="0";
        $q.="$stopmonth";
        if ($stopday<10) $q.="0";
        $q.="$stopday') GROUP BY '';";
        if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
        endif;
        $table=MYSQL_QUERY($q);
        $num_rows=MYSQL_NUM_ROWS($table);
        if ($num_rows==1):
          $f1=MYSQL_RESULT($table, 0, "f1");
          $f2=MYSQL_RESULT($table, 0, "f2");
          $f3=MYSQL_RESULT($table, 0, "f3");
          $f4=MYSQL_RESULT($table, 0, "f4");
          $f5=MYSQL_RESULT($table, 0, "f5");
          if (($f1!=0)||($f2!="")||($f3!="")||($f4!="")||($f5!="")):
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD ALIGN="CENTER" WIDTH="62px" STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">�������� ������ �� ���� ��������� ������� �� ������ � <B><?echo "$startday $months2[$startmonth] $startyear";?> ����</B> �� <B><?echo "$stopday $months2[$stopmonth] $stopyear";?> ����</B> ������� ��������.</TD></TR></TABLE></TD></TR>
<?
            endif;
          else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>�� ������� �������� ���������� ������� �� ������� <B>newstat.rep1</B>! ���������� � ���������� ��������������!<BR><BR>������� ������ <B>&laquo;�����&raquo;</B> ��� �������� � ����������� ���� ������������ ������.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
            die("");
          endif;
        else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>���� ��� ��������� ������������� ������� �� ������� <B>newstat.rep1</B>! ���������� � ���������� ��������������!<BR><BR>������� ������ <B>&laquo;�����&raquo;</B> ��� �������� � ����������� ���� ������������ ������.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
          die("");
        endif;
?>
        <TR VALIGN="MIDDLE" STYLE="border: 0 solid #000000;">
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 2px;;">�����:</TD>
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">&#151;</TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;"><?echo $f1;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 2px 1px 2px 0;"><?echo $f2;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;"><?echo $f3;?></TD>
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;"><?echo $f4;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;"><?echo $f5;?></TD>
        </TR>
        <TR STYLE="font-size: 6pt;"><TD COLSPAN="7" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0; padding-top: 10px;">* - ����� ������������� � �������� ������� �� �������</TD></TR>
        <TR STYLE="font-size: 6pt;"><TD COLSPAN="7" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0;">** - ����� ������������� � ������� ������� �� �������</TD></TR>
        <TR STYLE="font-size: 6pt;"><TD COLSPAN="7" STYLE="border-color: <?if ($maker!=""):?>gray<?else:?>white<?endif;?>; border-style: solid; border-width: 0 0 1px 0; padding-bottom: 5px;">*** - ���������� �������, ������� ����� �������� � ������ ������ �� ������ ��� ����</TD></TR>
<?
        if (($maker!="")||($makerstate!="")||($makerphone!="")): // ���� ������ ����������� ������ - ������� ��� �� ������
?>
        <TR><TD COLSPAN="7" STYLE="padding-top: 10px; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 6pt;">�����������:<?if ($makerstate!="") echo "<BR>$makerstate"; if ($maker!="") echo "<BR>$maker"; if ($makerphone!="") echo "<BR>$makerphone";?></TD></TR>
<?
        endif;
?>
      </TBODY>
    </TABLE>
<?
      else:
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER"><B>��������� ������ ������ ����� ������ ���!<BR><BR>������� ������ <B>&laquo;�����&raquo;</B> ��� �������� � ����������� ���� ������������ ������.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
        die("");
      endif;




















































    elseif ($rep==4):
      if ($time=="lastweek"):
        $startday=$lwbd;
        $stopday=$lwed;
        $startmonth=$lwbm;
        $stopmonth=$lwem;
        $startyear=$lwby;
        $stopyear=$lwey;
      elseif ($time=="yesterday"):
        $startday=$ldd;
        $stopday=$ldd;
        $startmonth=$ldm;
        $stopmonth=$ldm;
        $startyear=$ldy;
        $stopyear=$ldy;
      elseif ($time=="another"):
        $startday=$abd;
        $stopday=$aed;
        $startmonth=$abm;
        $stopmonth=$aem;
        $startyear=$aby;
        $stopyear=$aey;
      endif;
      $currentd=$startday+0;
      $currentm=$startmonth+0;
      $currenty=$startyear+0;
      $title="����������&nbsp;�������&nbsp;�������������� ��&nbsp;�����&nbsp;&laquo;098&raquo;";
      if ((($time=="another")&&(($startday==$stopday)&&($startmonth==$stopmonth)&&($startyear==$stopyear)))||($time=="yesterday")) $title.=" ��&nbsp;$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;����"; else $title.="��&nbsp;������ �&nbsp;$startday&nbsp;$months2[$startmonth]&nbsp;$startyear&nbsp;���� ��&nbsp;$stopday&nbsp;$months2[$stopmonth]&nbsp;$stopyear&nbsp;����";
      $i=mktime(0,0,0,$stopmonth+0,$stopday+0,$stopyear+0)-mktime(0,0,0,$startmonth,$startday,$startyear);
      if ($i>=0): // ���������� ���� ����������� � ������ ������, ��� 0 ����� ���������� ����� ��� ������
?>
    <TABLE BORDER="1" WIDTH="100%" ALIGN="CENTER" STYLE="border: 0 solid #FFFFFF; font-size: 6pt">
      <TBODY>
        <TR STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0;"><TD COLSPAN="4" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0;"><H1><?print $title;?></H1></TD></TR>
        <TR VALIGN="MIDDLE" STYLE="border: 0 solid #000000;">
          <TH STYLE="border-color: #000000; border-style: solid; border-width: 2px;">����� ��������</TH>
          <TH STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">���� ������</TH>
          <TH STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">����� ������</TH>
          <TH STYLE="border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">������������ ������</TH>
        </TR>
<?
        while ($i>=0):
          if ($currentd<10) $cd="0$currentd"; else $cd="$currentd";
          if ($currentm<10) $cm="0$currentm"; else $cm="$currentm";
          $flag=0; // ������������� ���� ���������� � ���� (�� �������)
          if ($HostName!="10.1.1.250"):
            MYSQL_CLOSE($MYSQLCON);
            $HostName="10.1.1.250";
            $UserName="sel";
            $Password="";
            $DBName="newstat";
            $MYSQLCON=MYSQL_CONNECT($HostName,$UserName,$Password) OR die("        <TR><TD COLSPAN=4 STYLE=\"padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;\"><TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">MySQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0;\">�� ������� ���������� ����������� � MySQL-������� <B>$HostName</B>!</TD></TR></TABLE></TD></TR>\n      </TBODY>\n    </TABLE>\n  </BODY>\n</HTML>");
            MYSQL_SELECT_DB("$DBName") OR die("        <TR><TD COLSPAN=4 STYLE=\"padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;\"><TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">MySQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0;\">�� ������� ���������� ����������� � �� <B>$DBName</B> �� MySQL-������� <B>$HostName</B>!</TD></TR></TABLE></TD></TR>\n      </TBODY>\n    </TABLE>\n  </BODY>\n</HTML>");
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������� ���������� ����������� � �� <B><?echo $DBName;?></B> �� MySQL-������� <B><?echo $HostName;?></B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
          endif;
          // ���� �� ���� ������ �� �������
          // ������� �1: �� 10.1.1.250 � �������� "arj" � ����� "irda_������"
          $q="SHOW TABLES FROM arj LIKE 'irda_$currenty$cm';";
          if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN=4 STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
          endif;
          $table=MYSQL_QUERY($q);
          $num_rows=MYSQL_NUM_ROWS($table);
          if ($num_rows!=0): // ���� ������� ���� ������, ������ �������� �� ������� � �� �������
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������� <B>arj.irda_<?echo "$currenty$cm";?></B> ������� �������.</TD></TR></TABLE></TD></TR>
<?
            endif;
            $q="SELECT COUNT(*) AS row1 FROM arj.irda_$currenty$cm;";
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
            $table=MYSQL_QUERY($q);
            $num_rows=MYSQL_NUM_ROWS($table);
            if ($num_rows>0): // ���� ������ ������� ���������
              $row1=MYSQL_RESULT($table, 0, "row1"); // ������� �������� ���������� ������� � �������
              if ($row1>0): // ���� ���������� ������� ������ ����
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">���������� ����� � ������� <B><?echo "arj.irda_$currenty$cm";?></B> ������ ��� ����.</TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
                // ������� ����� ������ �� ������� ���� � ������� �� �����
                $q="SELECT ani AS f1, vrijeme AS f2, SEC_TO_TIME(dur) AS f3 FROM arj.irda_$currenty$cm WHERE datum='$currenty-$cm-$cd' AND (dur>1) AND ((ddi LIKE '%2339535') OR (ddi='098') OR (ddi='001798')) AND (ani LIKE '%2370654');";
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
                $table=MYSQL_QUERY($q);
                $num_rows=MYSQL_NUM_ROWS($table);
                if ($num_rows>0): // ���� ������ ������� ���������
                  $flag=1;
                endif;
              else:
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">���������� ������� � ������� <B><?echo "arj.irda_$currenty$cm";?></B> ����� ���� - ������� �� ���������!</TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
              endif;
            else:
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">��������� ������ ��� ������� ��������� ���������� ������� � ������� <B><?echo "arj.irda_$currenty$cm";?></B>!</TD></TR></TBODY></TABLE></TD></TR>
<?
              endif;
            endif;
          else:
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������� <B><?echo "arj.irda_$currenty$cm";?></B> �� �������!</TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
          endif;
          if ($flag!=1): // ���� ������ ��� �� ���� �������, ���������� �����
            // ������� �2: �� 10.1.1.250 � �������� "arj" � ����� "ird_��������"
            $q="SHOW TABLES FROM arj LIKE 'ird_$currenty$cm$cd';";
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
            $table=MYSQL_QUERY($q);
            $num_rows=MYSQL_NUM_ROWS($table);
            if ($num_rows!=0): // ���� ������� ���� ������, ������ �������� �� ������� � �� �������
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������� <B>arj.irda_<?echo "$currenty$cm$cd";?></B> ������� �������.</TD></TR></TABLE></TD></TR>
<?
              endif;
              $q="SELECT COUNT(*) AS row1 FROM arj.ird_$currenty$cm$cd;";
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
              endif;
              $table=MYSQL_QUERY($q);
              $num_rows=MYSQL_NUM_ROWS($table);
              if ($num_rows>0): // ���� ������ ������� ���������
                $row1=MYSQL_RESULT($table, 0, "row1"); // ������� �������� ���������� ������� � �������
                if ($row1>0): // ���� ���������� ������� ������ ����
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">���������� ����� � ������� <B><?echo "arj.ird_$currenty$cm$cd";?></B> ������ ��� ����.</TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  // ������� ����� ������ �� ������� ���� � ������� �� ����
                  $q="SELECT ani AS f1, vrijeme AS f2, SEC_TO_TIME(dur) AS f3 FROM arj.ird_$currenty$cm$cd WHERE datum='$currenty-$cm-$cd' AND (dur>1) AND ((ddi LIKE '%2339535') OR (ddi='098') OR (ddi='001798')) AND (ani LIKE '%2370654');";
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  $table=MYSQL_QUERY($q);
                  $num_rows=MYSQL_NUM_ROWS($table);
                  if ($num_rows>0): // ���� ������ ������� ���������
                    $flag=1;
                  endif;
                else:
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">���������� ������� � ������� <B><?echo "arj.irda_$currenty$cm$cd";?></B> ����� ���� - ������� �� ���������!</TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                endif;
              else:
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">��������� ������ ��� ������� ��������� ���������� ������� � ������� <B><?echo "arj.irda_$currenty$cm$cd";?></B>!</TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
              endif;
            else:
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������� <B><?echo "arj.irda_$currenty$cm$cd";?></B> �� �������!</TD></TR></TBODY></TABLE></TD></TR>
<?
              endif;
            endif;
          endif;
          if ($flag!=1): // ���� ������ ��� �� ���� �������, ���������� �����
            // ������� �2: �� 10.1.1.2 � �������� "statistika" � ����� "ird_��������"
            if ($HostName!="10.1.1.2"):
              MYSQL_CLOSE($MYSQLCON);
              $HostName="10.1.1.2";
              $UserName="sel";
              $Password="";
              $DBName="statistika";
              $MYSQLCON=MYSQL_CONNECT($HostName,$UserName,$Password) OR die("    <TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">My-SQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0;\">�� ������� ���������� ����������� � MySQL-������� <B>$HostName</B>!</TD></TR></TABLE>\n  </BODY>\n</HTML>");
              MYSQL_SELECT_DB("$DBName") OR die("    <TABLE BORDER=\"1\" STYLE=\"margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;\"><TR VALIGN=\"MIDDLE\"><TD STYLE=\"border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;\">My-SQL</TD><TD STYLE=\"border-color: white; border-style: solid; border-width: 0; font: \">�� ������� ���������� ����������� � �� <B>$DBName</B> �� MySQL-������� <B>$HostName</B>!</TD></TR></TABLE>\n  </BODY>\n</HTML>");
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">My-SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������� ���������� ����������� � �� <B><?echo $DBName;?></B> �� MySQL-������� <B><?echo $HostName;?></B>.</TD></TR></TBODY></TABLE></TD></TR>
<?
              endif;
            endif;
            $q="SHOW TABLES FROM statistika LIKE 'ird_$currenty$cm$cd';";
            if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
            endif;
            $table=MYSQL_QUERY($q);
            $num_rows=MYSQL_NUM_ROWS($table);
            if ($num_rows!=0): // ���� ������� ���� ������, ������ �������� �� ������� � �� �������
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: green; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������� <B>statistika.ird_<?echo "$currenty$cm$cd";?></B> ������� �������.</TD></TR></TABLE></TD></TR>
<?
              endif;
              $q="SELECT COUNT(*) AS row1 FROM statistika.ird_$currenty$cm$cd;";
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
              endif;
              $table=MYSQL_QUERY($q);
              $num_rows=MYSQL_NUM_ROWS($table);
              if ($num_rows>0): // ���� ������ ������� ���������
                $row1=MYSQL_RESULT($table, 0, "row1"); // ������� �������� ���������� ������� � �������
                if ($row1>0): // ���� ���������� ������� ������ ����
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: yellow; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">���������� ����� � ������� <B>statistika.ird_<?echo "$currenty$cm$cd";?></B> ������ ��� ����.</TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  // ������� ����� ������ �� ������� ���� � ������� �� ����
                  $q="SELECT ani AS f1, vrijeme AS f2, SEC_TO_TIME(dur) AS f3 FROM statistika.ird_$currenty$cm$cd WHERE datum='$currenty-$cm-$cd' AND (dur>1) AND ((ddi LIKE '%2339535') OR (ddi='098') OR (ddi='001798')) AND (ani LIKE '%2370654');";
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: black; background: gray; font-weight: bold; font-size: 12pt; font-family: Times;">SQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0; font-weight: bold;"><?echo $q;?></TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                  $table=MYSQL_QUERY($q);
                  $num_rows=MYSQL_NUM_ROWS($table);
                  if ($num_rows>0): // ���� ������ ������� ���������
                    $flag=1;
                  endif;
                else:
                  if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">���������� ������� � ������� <B>statistika.ird_<?echo "$currenty$cm$cd";?></B> ����� ���� - ������� �� ���������!</TD></TR></TBODY></TABLE></TD></TR>
<?
                  endif;
                endif;
              else:
                if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">��������� ������ ��� ������� ��������� ���������� ������� � ������� <B>statistika.ird_<?echo "$currenty$cm$cd";?></B>!</TD></TR></TBODY></TABLE></TD></TR>
<?
                endif;
              endif;
            else:
              if ($DEBUG=="on"):
?>
        <TR><TD COLSPAN="4" STYLE="padding-top: 1px; padding-left: 0; border-color: white; border-width: 0; border-style: solid;"><TABLE BORDER="1" STYLE="margin-bottom: 1px; border-color: white; border-style: solid; border-width: 0;"><TBODY><TR VALIGN="MIDDLE"><TD STYLE="border-color: black; border-style: solid; border-width: 1px; color: white; background: red; font-weight: bold; font-size: 12pt; font-family: Times;">MySQL</TD><TD STYLE="border-color: white; border-style: solid; border-width: 0;">������� <B>statistika.ird_<?echo "$currenty$cm$cd";?></B> �� �������!</TD></TR></TBODY></TABLE></TD></TR>
<?
              endif;
            endif;
          endif;
          if ($flag!=1):
?>
    <TABLE BORDER="0" WIDTH="100%" ALIGN="CENTER">
      <TBODY BGCOLOR="#FF0000">
        <TR HEIGHT="15" VALIGN="MIDDLE"><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD><TD WIDTH="100%"></TD><TD WIDTH="5" ROWSPAN="3">&nbsp;</TD></TR>
        <TR HEIGHT="22" VALIGN="MIDDLE" BGCOLOR=#FFFFFF><TD ALIGN="CENTER">������ �� ��������� ���� ���������� ������� (<B><?print "$cd $months2[$cm] $currenty ����";?></B>) � �������� ���� ������ ������� �� ����!<BR><BR>����������� ��������� ������� ������������ ������.</TD></TR>
        <TR VALIGN="MIDDLE"><TD HEIGHT="15"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD HEIGHT="13" COLSPAN="3"></TD></TR>
        <TR BGCOLOR=#FFFFFF><TD ALIGN="CENTER" COLSPAN="3"><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"></TD></TD></TR>
      </TBODY>
    </TABLE>
  </BODY>
</HTML>
<?
            die("");
          endif;
          $j=0; // ���������� ��� �������� ������� ������� ������ � �������
          if ($num_rows>0):
            while ($j<$num_rows):
              $f1=mysql_result($table, $j, "f1");
              $f2=mysql_result($table, $j, "f2");
              $f3=mysql_result($table, $j, "f3");
?>
        <TR VALIGN="MIDDLE" STYLE="border: 2px solid #000000;">
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px <?if (($j+1)<$num_rows):?>1<?else:?>2<?endif;?>px 2px;"><?print "$f1";?></TD>
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px <?if (($j+1)<$num_rows):?>1<?else:?>2<?endif;?>px 0;"><?print "$currentd $months2[$currentm] $currenty ����";?></TD>
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px <?if (($j+1)<$num_rows):?>1<?else:?>2<?endif;?>px 0;"><?print "$f2";?></TD>
          <TD ALIGN="CENTER" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px <?if (($j+1)<$num_rows):?>1<?else:?>2<?endif;?>px 0;"><?print "$f3";?></TD>
        </TR>
<?
              $j++;
            endwhile;
          endif;
          $ncurrentd=date("d",mktime(0,0,0,$currentm,$currentd,$currenty)+((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))))+0;
          $ncurrentm=date("m",mktime(0,0,0,$currentm,$currentd,$currenty)+((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))))+0;
          $ncurrenty=date("Y",mktime(0,0,0,$currentm,$currentd,$currenty)+((mktime(0,0,0,1,2,2000)-mktime(0,0,0,1,1,2000))))+0;
          $currentd=$ncurrentd;
          $currentm=$ncurrentm;
          $currenty=$ncurrenty;
          $i=mktime(0,0,0,$stopmonth+0,$stopday+0,$stopyear+0)-mktime(0,0,0,$currentm+0,$currentd+0,$currenty+0);
        endwhile;
        $i=mktime(0,0,0,$stopmonth+0,$stopday+0,$stopyear+0)-mktime(0,0,0,$startmonth,$startday,$startyear);
?>
        <TR>
<?
        if ($maker!=""):
?>
          <TD COLSPAN="2" STYLE="padding-top: 10px; border-color: white; border-style: solid; border-width: 0; text-align: left; font-size: 6pt;">�����������:<BR>
<?
        if ($makerstate!=""): print "$makerstate<BR>"; endif;
        print "$maker";
        if ($makerphone!=""): print "<BR>$makerphone"; endif;
      else:
        // ����� �������� ���������� ������������� �������� ��� (�������� ���� �������� ����� �������, ������ ���������)
?>
          <TD COLSPAN="6" STYLE="border-color: white; border-style: solid; border-width: 0;">
<?
      endif;
?>
          </TD>
        </TR>
      </TBODY>
    </TABLE>
<?
      endif;























    elseif ($rep==5): // ��� �5 ��� ������ �5
      if ($time=="lastquart"):
        $quart=$lqq;
        $year=$lqy;
      elseif ($time=="anotherquart"):
        $quart=$aqq;
        $year=$aqy;
      endif;
      $m=($quart*3)-2; if ($m<10) $m1="0$m"; else $m1="$m";
      $m=($quart*3)-1; if ($m<10) $m2="0$m"; else $m2="$m";
      $m=($quart*3); if ($m<10) $m3="0$m"; else $m3="$m";
      for ($i=1;$i<4;$i++):
        $m=(($quart-1)*3)+$i;
        if ($m<10) $m="0$m"; else $m="$m";
        $table=MYSQL_QUERY("SHOW TABLES FROM arj LIKE 'irda_$year$m';");
        $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
        if ($num_rows==0):
          $m=$m+0;
?>
    <P>����� �� ����� ���� ������ �� ������� ���������� ������� ������ �� <?print "$months[$m] $year ����";?>!</P>
<?
          die("");
        else:
          $table=MYSQL_QUERY("SELECT COUNT(*) AS f1 FROM arj.irda_$year$m;");
          $rows=mysql_result($table, 0, "f1");
          if ($rows==0):
            $m=$m+0;
?>
    <P>����� �� ����� ���� ������ �� ������� ���������� ������ � ������� �� �� <?print "$months[$m] $year ����";?>!</P>
<?
            die("");
          endif;
        endif;
      endfor;
      $table=MYSQL_QUERY("SHOW TABLES FROM newstat LIKE 'rep5';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // ���� �������������� ������� �� ������� - ������ �
      if ($num_rows==0)
        MYSQL_QUERY("CREATE TABLE newstat.rep5 (ddi char(7) NOT NULL default '', yearmonth char(6) NOT NULL default '', call_quantity decimal(11,0) default NULL, call_sumtime decimal(13,0) default NULL, call_middletime decimal(13,2) default NULL, allowed_call_quantity decimal(11,0) default NULL, allowed_call_sumtime decimal(13,0) default NULL, allowed_call_middletime decimal(13,2) default NULL, nonallowed_call_percent decimal(5,2) default NULL) TYPE=MyISAM;");

      if ($time=="lastquart"):
        $title="���������� �� ������ &laquo;009&raquo;<BR>�� ������ � $lqbd $months2[$lqbm] $lqy ���� �� $lqed $months2[$lqem] $lqy ����";
        $Subject="���������� �� ������ \"009\" �� ������ � $lqbd $months2[$lqbm] $lqy ���� �� $lqed $months2[$lqem] $lqy ����";
      elseif ($time=="anotherquart"):
        $title="���������� �� ������ &laquo;009&raquo;<BR>�� ������ � $aqbd $months2[$aqbm] $aqy ���� �� $aqed $months2[$aqem] $aqy ����";
        $Subject="���������� �� ������ \"009\" �� ������ � $aqbd $months2[$aqbm] $aqy ���� �� $aqed $months2[$aqem] $aqy ����";
      endif;
      // ���� ���������� ��������� ����������� ������ �� ��������� ������ - ������� �� �������������� ������� ��� ������ �� ��������� ������
      if ($RECALC=="on")
        MYSQL_QUERY("DELETE FROM newstat.rep5 WHERE yearmonth='$year$m1' OR yearmonth='$year$m2' OR yearmonth='$year$m3';");
      // ������� ��� ��������� �������, �������������� ��� ������������ �������
      MYSQL_QUERY("DROP TABLE IF EXISTS newstat.rep5_1, newstat.rep5_2, newstat.rep5_3;");
      // � ������ �� ������
      MYSQL_QUERY("CREATE TABLE newstat.rep5_1 (ddi char(7) NOT NULL default '', yearmonth char(6) NOT NULL default '', call_quantity decimal(11,0) default NULL, call_sumtime decimal(13,0) default NULL, allowed_call_quantity decimal(11,0) default NULL, allowed_call_sumtime decimal(13,0) default NULL) TYPE=MyISAM COMMENT='������� �� ����������� ���������';");
      MYSQL_QUERY("CREATE TABLE newstat.rep5_2 (ddi char(7) NOT NULL default '', yearmonth char(6) NOT NULL default '', call_quantity decimal(11,0) default NULL, call_sumtime decimal(13,0) default NULL, allowed_call_quantity decimal(11,0) default NULL, allowed_call_sumtime decimal(13,0) default NULL) TYPE=MyISAM COMMENT='������� �� ����������� ���������';");
      MYSQL_QUERY("CREATE TABLE newstat.rep5_3 (ddi char(7) NOT NULL default '', yearmonth char(6) NOT NULL default '', call_quantity decimal(11,0) default NULL, call_sumtime decimal(13,0) default NULL, call_middletime decimal(13,2) default NULL, allowed_call_quantity decimal(11,0) default NULL, allowed_call_sumtime decimal(13,0) default NULL, allowed_call_middletime decimal(13,2) default NULL, nonallowed_call_percent decimal(5,2) default NULL) TYPE=MyISAM COMMENT='��������� �������';");
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep5 WHERE yearmonth='$year$m1';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows==0): // ���� ������� ����� - ������ ������� �� ������ ����� � �������������� ������� ��� � ��������� �������� ������
        // ������� � ������ �������� ������ �� ��������� ���������
        MYSQL_QUERY("INSERT INTO newstat.rep5_1 SELECT ddi AS '����� ������', '$year$m1', COUNT(*) AS '���������� ����������� �������', SUM(dur) AS '����� ����������������� �������', '' AS '���������� ����������� �������', '' AS '����� ����������������� ����������� �������' FROM arj.irda_$year$m1 WHERE ddi='009' GROUP BY ddi;");
        MYSQL_QUERY("INSERT INTO newstat.rep5_2 SELECT ddi AS '����� ������', '$year$m1', '' AS '���������� ����������� �������', '' AS '����� ����������������� �������', COUNT(*) AS '���������� ����������� �������', SUM(dur) AS '����� ����������������� ����������� �������' FROM arj.irda_$year$m1 WHERE ddi='009' AND (dur>0) AND (v_mreza>'') AND (rm>0) GROUP BY ddi;");
        // ������������ ���������������� ����������
        MYSQL_QUERY("INSERT INTO newstat.rep5_3 SELECT a.ddi AS '����� ������', '$year$m1', a.call_quantity AS '���������� ����������� �������', a.call_sumtime AS '����� ����������������� ����������� �������', a.call_sumtime/a.call_quantity AS '������� ����� ������������ ������', b.allowed_call_quantity AS '���������� ����������� �������', b.allowed_call_sumtime AS '����� ����������������� ����������� �������', b.allowed_call_sumtime/b.allowed_call_quantity AS '������� ����� ������������ ������', (1-(b.allowed_call_quantity/a.call_quantity))*100 AS '������� �������' FROM newstat.rep5_1 AS a, newstat.rep5_2 AS b WHERE a.ddi=b.ddi;");
        // �������� ���� ������������� ������ �� ������ �� �������
        MYSQL_QUERY("DELETE FROM newstat.rep5_1;");
        MYSQL_QUERY("DELETE FROM newstat.rep5_2;");
        // ��������� ���������������� ���������� � ������������� �������
        MYSQL_QUERY("INSERT INTO newstat.rep5 SELECT * FROM newstat.rep5_3 WHERE yearmonth='$year$m1'");
      else: // ����� - ������ ��������� ������ �� �������������� ������� �� ���������
        MYSQL_QUERY("INSERT INTO newstat.rep5_3 SELECT * FROM newstat.rep5 WHERE yearmonth='$year$m1'");
      endif;

      $table=MYSQL_QUERY("SELECT * FROM newstat.rep5 WHERE yearmonth='$year$m2';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows==0): // ���� ������� ����� - ������ ������� �� ������ ����� � �������������� ������� ��� � ��������� �������� ������
        // ������� � ������ �������� ������ �� ��������� ���������
        MYSQL_QUERY("INSERT INTO newstat.rep5_1 SELECT ddi AS '����� ������', '$year$m2', COUNT(*) AS '���������� ����������� �������', SUM(dur) AS '����� ����������������� �������', '' AS '���������� ����������� �������', '' AS '����� ����������������� ����������� �������' FROM arj.irda_$year$m2 WHERE ddi='009' GROUP BY ddi;");
        MYSQL_QUERY("INSERT INTO newstat.rep5_2 SELECT ddi AS '����� ������', '$year$m2', '' AS '���������� ����������� �������', '' AS '����� ����������������� �������', COUNT(*) AS '���������� ����������� �������', SUM(dur) AS '����� ����������������� ����������� �������' FROM arj.irda_$year$m2 WHERE ddi='009' AND (dur>0) AND (v_mreza>'') AND (rm>0) GROUP BY ddi;");
        // ������������ ���������������� ����������
        MYSQL_QUERY("INSERT INTO newstat.rep5_3 SELECT a.ddi AS '����� ������', '$year$m2', a.call_quantity AS '���������� ����������� �������', a.call_sumtime AS '����� ����������������� ����������� �������', a.call_sumtime/a.call_quantity AS '������� ����� ������������ ������', b.allowed_call_quantity AS '���������� ����������� �������', b.allowed_call_sumtime AS '����� ����������������� ����������� �������', b.allowed_call_sumtime/b.allowed_call_quantity AS '������� ����� ������������ ������', (1-(b.allowed_call_quantity/a.call_quantity))*100 AS '������� �������' FROM newstat.rep5_1 AS a, newstat.rep5_2 AS b WHERE a.ddi=b.ddi;");
        // �������� ���� ������������� ������ �� ������ �����
        MYSQL_QUERY("DELETE FROM newstat.rep5_1;");
        MYSQL_QUERY("DELETE FROM newstat.rep5_2;");
        // ��������� ���������������� ���������� � ������������� �������
        MYSQL_QUERY("INSERT INTO newstat.rep5 SELECT * FROM newstat.rep5_3 WHERE yearmonth='$year$m2'");
      else: // ����� - ������ ��������� ������ �� �������������� ������� �� ���������
        MYSQL_QUERY("INSERT INTO newstat.rep5_3 SELECT * FROM newstat.rep5 WHERE yearmonth='$year$m2'");
      endif;

      $table=MYSQL_QUERY("SELECT * FROM newstat.rep5 WHERE yearmonth='$year$m3';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows==0): // ���� ������� ����� - ������ ������� �� ������ ����� � �������������� ������� ��� � ��������� �������� ������
        // ������� � ������ �������� ������ �� ��������� ���������
        MYSQL_QUERY("INSERT INTO newstat.rep5_1 SELECT ddi AS '����� ������', '$year$m3', COUNT(*) AS '���������� ����������� �������', SUM(dur) AS '����� ����������������� �������', '' AS '���������� ����������� �������', '' AS '����� ����������������� ����������� �������' FROM arj.irda_$year$m3 WHERE ddi='009' GROUP BY ddi;");
        MYSQL_QUERY("INSERT INTO newstat.rep5_2 SELECT ddi AS '����� ������', '$year$m3', '' AS '���������� ����������� �������', '' AS '����� ����������������� �������', COUNT(*) AS '���������� ����������� �������', SUM(dur) AS '����� ����������������� ����������� �������' FROM arj.irda_$year$m3 WHERE ddi='009' AND (dur>0) AND (v_mreza>'') AND (rm>0) GROUP BY ddi;");
        // ������������ ���������������� ����������
        MYSQL_QUERY("INSERT INTO newstat.rep5_3 SELECT a.ddi AS '����� ������', '$year$m3', a.call_quantity AS '���������� ����������� �������', a.call_sumtime AS '����� ����������������� ����������� �������', a.call_sumtime/a.call_quantity AS '������� ����� ������������ ������', b.allowed_call_quantity AS '���������� ����������� �������', b.allowed_call_sumtime AS '����� ����������������� ����������� �������', b.allowed_call_sumtime/b.allowed_call_quantity AS '������� ����� ������������ ������', (1-(b.allowed_call_quantity/a.call_quantity))*100 AS '������� �������' FROM newstat.rep5_1 AS a, newstat.rep5_2 AS b WHERE a.ddi=b.ddi;");
        // ��������� ���������������� ���������� � ������������� �������
        MYSQL_QUERY("INSERT INTO newstat.rep5 SELECT * FROM newstat.rep5_3 WHERE yearmonth='$year$m3'");
      else: // ����� - ������ ��������� ������ �� �������������� ������� �� ���������
        MYSQL_QUERY("INSERT INTO newstat.rep5_3 SELECT * FROM newstat.rep5 WHERE yearmonth='$year$m3'");
      endif;

      // ����� ������ �� �����
?>
    <H1><BR><?print $title;?></H1>
    <TABLE BORDER="1" WIDTH="100%" ALIGN="CENTER" STYLE="border: 2px solid #000000;">
      <TBODY>
        <TR VALIGN="MIDDLE" STYLE="border: 2px solid #000000;">
          <TH STYLE="border: 2px solid #000000;">������ (�����, ���)</TH>
          <TH STYLE="border: 2px solid #000000;">���������� ����������� �������</TH>
          <TH STYLE="border: 2px solid #000000;">����� ����������������� ����������� �������, ���.</TH>
          <TH STYLE="border: 2px solid #000000;">���������� ����������� �������</TH>
          <TH STYLE="border: 2px solid #000000;">����� ����������������� ����������� �������, ���.</TH>
          <TH STYLE="border: 2px solid #000000;">������ �� ������, %</TH>
        </TR>
<?
      // ���������� ������ ��� �������� �� ����
      $message="<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">
<HTML>
  <BODY STYLE=\"font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 8pt; background-color: white; margin: 10px; color: #000000;\">
    <H1 STYLE=\"font-size: 13pt; margin-top: 5px; margin-bottom: 5px; text-align: center; font-weight: bold; color: #000000; background-color: transparent; padding-top: 3px; padding-bottom: 3px;\">$title</H1>
    <TABLE BORDER=\"1\" ALIGN=\"CENTER\" STYLE=\"caption-side: top; table-layout: auto; empty-cells: show; font-size: 8pt; float: none; clear: both; border-collapse: collapse; background-color: transparent; border: 1px solid #000000;\">
      <TBODY STYLE=\"vertical-align: top;\">
        <TR VALIGN=\"MIDDLE\" STYLE=\"font-weight: bold; padding: 10px 5px; border: 1px solid #000000;\">
          <TH STYLE=\"\">������ (�����, ���)</TH>
          <TH STYLE=\"\">���������� ����������� �������</TH>
          <TH STYLE=\"\">����� ����������������� ����������� �������, ���.</TH>
          <TH STYLE=\"\">���������� ����������� �������</TH>
          <TH STYLE=\"\">����� ����������������� ����������� �������, ���.</TH>
          <TH STYLE=\"\">������ �� ������, %</TH>
        </TR>
";
      $table=MYSQL_QUERY("SELECT CONCAT(RIGHT(yearmonth,2),'.',LEFT(yearmonth,4)) AS f1, call_quantity AS f2, call_sumtime AS f3, allowed_call_quantity AS f4, allowed_call_sumtime AS f5, (100-((allowed_call_quantity/call_quantity)*100)) AS f6 FROM newstat.rep5_3 GROUP BY yearmonth, ddi ORDER BY yearmonth, ddi;");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows>0):
        for ($i=0;$i<$num_rows;$i++):
          $f1=mysql_result($table, $i, "f1");
          $f2=mysql_result($table, $i, "f2");
          $f3=mysql_result($table, $i, "f3");
          $f4=mysql_result($table, $i, "f4");
          $f5=mysql_result($table, $i, "f5");
          $f6=mysql_result($table, $i, "f6");
          if ($i==0) $a="1px"; else $a="0px";
?>
        <TR>
          <TD ALIGN="CENTER" STYLE="border-left, border-right: 2px solid #000000; border-top, border-bottom: 1px solid #000000;"><?print $f1;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-left, border-right: 2px solid #000000; border-top, border-bottom: 1px solid #000000;"><?print $f2;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-left, border-right: 2px solid #000000; border-top, border-bottom: 1px solid #000000;"><?print $f3;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-left, border-right: 2px solid #000000; border-top, border-bottom: 1px solid #000000;"><?print $f4;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-left, border-right: 2px solid #000000; border-top, border-bottom: 1px solid #000000;"><?print $f5;?></TD>
          <TD ALIGN="RIGHT" STYLE="border-left, border-right: 2px solid #000000; border-top, border-bottom: 1px solid #000000;"><?print $f6;?></TD>
        </TR>
<?
          // ���������� ������ ��� �������� �� ����
          $message.="        <TR VALIGN=\"MIDDLE\">
          <TD ALIGN=\"CENTER\" STYLE=\"font-weight: normal; padding: 0 5px; border-color: #000000; border-style: solid; border-width: $a 1px 1px 1px;\">$f1</TD>
          <TD ALIGN=\"RIGHT\" STYLE=\"font-weight: normal; padding: 0 5px; border-color: #000000; border-style: solid; border-width: $a 1px 1px 1px;\">$f2</TD>
          <TD ALIGN=\"RIGHT\" STYLE=\"font-weight: normal; padding: 0 5px; border-color: #000000; border-style: solid; border-width: $a 1px 1px 1px;\">$f3</TD>
          <TD ALIGN=\"RIGHT\" STYLE=\"font-weight: normal; padding: 0 5px; border-color: #000000; border-style: solid; border-width: $a 1px 1px 1px;\">$f4</TD>
          <TD ALIGN=\"RIGHT\" STYLE=\"font-weight: normal; padding: 0 5px; border-color: #000000; border-style: solid; border-width: $a 1px 1px 1px;\">$f5</TD>
          <TD ALIGN=\"RIGHT\" STYLE=\"font-weight: normal; padding: 0 5px; border-color: #000000; border-style: solid; border-width: $a 1px 1px 1px;\">$f6</TD>
        </TR>
";
        endfor;
      else: // ������� �� ���������!
      endif;
      // �������� ������
      $table=MYSQL_QUERY("SELECT '�����' AS f1, SUM(call_quantity) AS f2, SUM(call_sumtime) AS f3, SUM(allowed_call_quantity) AS f4, SUM(allowed_call_sumtime) AS f5, (100-((SUM(allowed_call_quantity)/SUM(call_quantity))*100)) AS f6 FROM newstat.rep5_3 GROUP BY ddi;");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows>0):
        $f1=mysql_result($table, 0, "f1");
        $f2=mysql_result($table, 0, "f2");
        $f3=mysql_result($table, 0, "f3");
        $f4=mysql_result($table, 0, "f4");
        $f5=mysql_result($table, 0, "f5");
        $f6=mysql_result($table, 0, "f6");
?>
        <TR STYLE="border: 2px solid #000000;">
          <TH ALIGN="CENTER" STYLE="border: 2px solid #000000;"><?print $f1;?></TH>
          <TH ALIGN="RIGHT" STYLE="border: 2px solid #000000;"><?print $f2;?></TH>
          <TH ALIGN="RIGHT" STYLE="border: 2px solid #000000;"><?print $f3;?></TH>
          <TH ALIGN="RIGHT" STYLE="border: 2px solid #000000;"><?print $f4;?></TH>
          <TH ALIGN="RIGHT" STYLE="border: 2px solid #000000;"><?print $f5;?></TH>
          <TH ALIGN="RIGHT" STYLE="border: 2px solid #000000;"><?print $f6;?></TH>
        </TR>
<?
        $message.="        <TR VALIGN=\"MIDDLE\">
          <TH ALIGN=\"CENTER\" STYLE=\"font-weight: bold; padding: 0 5px; border: 1px solid #000000;\">$f1</TH>
          <TH ALIGN=\"RIGHT\" STYLE=\"font-weight: bold; padding: 0 5px; border: 1px solid #000000;\">$f2</TH>
          <TH ALIGN=\"RIGHT\" STYLE=\"font-weight: bold; padding: 0 5px; border: 1px solid #000000;\">$f3</TH>
          <TH ALIGN=\"RIGHT\" STYLE=\"font-weight: bold; padding: 0 5px; border: 1px solid #000000;\">$f4</TH>
          <TH ALIGN=\"RIGHT\" STYLE=\"font-weight: bold; padding: 0 5px; border: 1px solid #000000;\">$f5</TH>
          <TH ALIGN=\"RIGHT\" STYLE=\"font-weight: bold; padding: 0 5px; border: 1px solid #000000;\">$f6</TH>
        </TR>
";
      endif;
      $message.="      </TBODY>
    </TABLE>
  </BODY>
</HTML>";
?>
      </TBODY>
    </TABLE>
<?
        if ($maker!=""):
?>
          <P STYLE="padding-top: 50px; padding-left: 5px; border-color: white; border-style: solid; border-width: 0; text-align: left; font-size: 6pt;">�����������:<BR>
<?
        if ($makerstate!=""): print "$makerstate<BR>"; endif;
        print "$maker";
        if ($makerphone!=""): print "<BR>$makerphone"; endif;
      endif;
?>
<?
      MYSQL_QUERY("DROP TABLE IF EXISTS newstat.rep5_1, newstat.rep5_2, newstat.rep5_3;");

    elseif (($rep==6)||($rep==7)):
      if ($time=="lastmonth"):
        $startdate=$lmbd;
        $stopdate=$lmed;
        $month=$lmm;
        $year=$lmy;
      elseif ($time=="anothermonth"):
        $startdate=$ambd;
        $stopdate=$amed;
        $month=$amm;
        $year=$amy;
      endif;
      // ���������� �������� ���� ������� ��� ���
      if ($startdate<10) $startdate="0$startdate";
      if ($stopdate<10) $stopdate="0$stopdate";
      if ($month<10) $month="0$month";

      $table=MYSQL_QUERY("SHOW TABLES FROM arj LIKE 'irda_$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows==0):
        print "SHOW TABLES FROM arj LIKE 'irda_$year$month';";
        $month=$month+0;
?>
    <P>����� �� ����� ���� ������ �� ������� ���������� ������� ������ �� <?print "$months[$month] $year ����";?>!</P>
<?
        die("");
      else:
        $table=MYSQL_QUERY("SELECT COUNT(*) AS f1 FROM arj.irda_$year$month;");
        $rows=mysql_result($table, 0, "f1");
        if ($rows==0):
          print "SELECT COUNT(*) AS f1 FROM arj.irda_$year$month;";
          $month=$month+0;
?>
    <P>����� �� ����� ���� ������ �� ������� ���������� ������ � ������� �� �� <?print "$months[$month] $year ����";?>!</P>
<?
          die("");
        endif;
      endif;
      $i=$month+0;
      $Subject="�������� � �������� ������� � ���� ��� \"����������\" �� ������� ���������� ������ �� ���� ";
      if ($rep==6)
        $Subject.="�� \"���\"";
      elseif ($rep==7)
        $Subject.=$Subject.="���� \"���\"";
      $Subject.=" �� ������ � $startdate �� $stopdate $months2[$i] $year ����";
?>
    <TABLE BORDER="1" WIDTH="100%" ALIGN="CENTER" STYLE="border-width: 0; border-style: solid; border-color: #FFFFFF; font-size: 8pt;">
      <TBODY STYLE="vertical-align: top;">
        <TR font-size: 6pt;"><TD COLSPAN="5" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0;">&nbsp;</TD><TD COLSPAN="4" STYLE="border-color: gray; border-style: solid; border-width: 0 0 1px 0; text-align: right;">���������-�������������� ��� ������� &laquo;����&raquo; ��� &laquo;����������&raquo;</TD></TR>
        <TR><TD COLSPAN="8" STYLE="font-weight: bold; padding-top: 0.5cm; padding-bottom: 0.3cm; border-color: #FFFFFF; border-style: solid; border-width: 0; font-size: 13pt; margin-top: 5px; margin-bottom: 5px; text-align: center; font-weight: bold; color: #000000; background-color: transparent;">��������&nbsp;�&nbsp;��������&nbsp;������� �&nbsp;����&nbsp;���&nbsp;&laquo;����������&raquo; ��&nbsp;�������&nbsp;����������&nbsp;������ ��&nbsp;����&nbsp;<?if ($rep==6):?>��&nbsp;&laquo;���&raquo;<?elseif ($rep==7):?>����&nbsp;&laquo;���&raquo;<?endif;?></TD></TR>
        <TR><TD COLSPAN="7" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: right; font-size: 10pt;">������:</TD><TD STYLE="border-color: #000000; border-style: solid; border-width: 1px; text-align: center; font-size: 10pt; font-weight: bold;"><?print "$startdate-$stopdate.$month.$year";?></TD></TR>
        <TR><TD COLSPAN="8" STYLE="font-weight: bold; padding-bottom: 0.5cm; padding-left: 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 10pt;">5. �������� ������ �� ������� ���������� ������ ��� &laquo;����������&raquo;</TD></TR>
        <TR><TD COLSPAN="8" STYLE="padding-bottom: 0.5cm; padding-left: 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 9pt;">5.1. ������ �� �������� �������������� �� ���� �����������</TD></TR>
        <TR VALIGN="MIDDLE" STYLE="font-weight: bold;">
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 2px;" ROWSPAN="2">������</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 1px 0;" COLSPAN="2">���������� ����������</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 1px 0;" COLSPAN="2">�����, �������� ���</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 1px 0;" COLSPAN="3">�����, �������� ���</TH>
        </TR>
        <TR VALIGN="MIDDLE" STYLE="font-weight: bold;">
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">������� �����*</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;">������ �����**</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">������� �����*</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;">������ �����**</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">������� �����*</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">������ �����**</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;">�����</TH>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 2px;"><B>I</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><B>II</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>III</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><B>IV</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>V</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><B>VI</B><BR><FONT STYLE="font-size: 6pt;">(��. II * ��. IV)</FONT></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><B>VII</B><BR><FONT STYLE="font-size: 6pt;">(��. III * ��. V)</FONT></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>VIII</B><BR><FONT STYLE="font-size: 6pt;">(��. V + ��. VI)</FONT></TD>
        </TR>
<?
      switch ($rep):
        case 6: $mask1="0296______";
           $mask2="0293______";
           $mask3="0291______";
           $mask4="0291______";
        break;
        case 7: $mask1="0297______";
           $mask2="0295______";
           $mask3="0292______";
           $mask4="0298______";
        break;
      endswitch;
      // �������� �� ������� ����� ��������� �������
      $table=MYSQL_QUERY("SHOW TABLES FROM newstat LIKE 'rep$rep';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // �������� ������� � ������ � ����������
      if ($num_rows==0)
        MYSQL_QUERY("CREATE TABLE newstat.rep$rep (service char(4) NOT NULL DEFAULT '', yearmonth char(6) NOT NULL DEFAULT '', calls_quantity int(12) unsigned, duration decimal(12,0) NOT NULL DEFAULT '0');");

      // �������� ������ �� ������ ������ � ������ ������������� ��������� ��� ������������ ������
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='009d' AND yearmonth='$year$month';");
      // �������� �� ������� ������ �� ������ � �������
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='009d' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // ������ ������ �� ������ � ������ �� ���������� � �������
      if ($num_rows==0):
        // �������� �� ������� ������ �� �����
        $s="SELECT COUNT(*) AS row1 FROM arj.irda_$year$month WHERE ddi='009' AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=3) OR (izgnum>'')) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2') OR (ani LIKE '$mask3') OR (ani LIKE '$mask4')";
        $s.=") AND ((vrijeme>='06:00:00') AND (vrijeme<'22:00:00')) GROUP BY ddi;";
        $table1=MYSQL_QUERY($s); // ��������� ���������� ������� �� ������ � ������� �����
        $num_rows1=MYSQL_NUM_ROWS($table1); // ��������� ���������� ����� �������
        if ($num_rows1==0) $row1=0;
        else $row1=mysql_result($table1, 0, "row1");
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('009d', '$year$month', $row1, 0);");
      endif;

      // �������� ������ �� ������ ������ � ������ ������������� ��������� ��� ������������ ������
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='009n' AND yearmonth='$year$month';");
      // �������� �� ������� ������ �� ������ � �������
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='009n' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // ������ ������ �� ������ � ������ �� ���������� � �������
      if ($num_rows==0):
        // �������� �� ������� ������ �� �����
        $s="SELECT COUNT(*) AS row1 FROM arj.irda_$year$month WHERE ddi='009' AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=3) OR (izgnum>'')) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2') OR (ani LIKE '$mask3') OR (ani LIKE '$mask4')";
        $s.=") AND ((vrijeme<'06:00:00') OR (vrijeme>='22:00:00')) GROUP BY ddi;";
        $table1=MYSQL_QUERY($s); // ��������� ���������� ������� �� ������ � ������ �����
        $num_rows1=MYSQL_NUM_ROWS($table1); // ��������� ���������� ����� �������
        if ($num_rows1==0) $row1=0;
        else $row1=mysql_result($table1, 0, "row1");
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('009n', '$year$month', $row1, 0);");
      endif;

      // �������� ������ �� ������ ������ � ������ ������������� ��������� ��� ������������ ������
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='075' AND yearmonth='$year$month';");
      // �������� �� ������� ������ �� ������ � �������
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='075' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // ������ ������ �� ������ � ������ �� ���������� � �������
      if ($num_rows==0):
        // �������� �� ������� ������ �� �����
        // ��������� �� 08.07.2005 $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='075') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $s="SELECT COUNT(*) AS row1, CEILING((SUM(dur)/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='075') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2') OR (ani LIKE '$mask3') OR (ani LIKE '$mask4')";
        $s.=") GROUP BY ddi;";
        $table1=MYSQL_QUERY($s);
        $num_rows1=MYSQL_NUM_ROWS($table1); // ��������� ���������� ����� �������
        if ($num_rows1==0):
          $row1=0;
          $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('075', '$year$month', $row1, $row2);");
      endif;

      // �������� ������ �� ������ ������ � ������ ������������� ��������� ��� ������������ ������
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='088' AND yearmonth='$year$month';");
      // �������� �� ������� ������ �� ������ � �������
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='088' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // ������ ������ �� ������ � ������ �� ���������� � �������
      if ($num_rows==0):
        // �������� �� ������� ������ �� �����
        $s="SELECT COUNT(*) AS row1 FROM arj.irda_$year$month WHERE (ddi='088') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2') OR (ani LIKE '$mask3') OR (ani LIKE '$mask4')";
        $s.=") GROUP BY ddi;";
        $table1=MYSQL_QUERY($s);
        $num_rows1=MYSQL_NUM_ROWS($table1); // ��������� ���������� ����� �������
        if ($num_rows1==0) $row1=0;
        else $row1=mysql_result($table1, 0, "row1");
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('088', '$year$month', $row1, 0);");
      endif;

      // �������� ������ �� ������ ������ � ������ ������������� ��������� ��� ������������ ������
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='090' AND yearmonth='$year$month';");
      // �������� �� ������� ������ �� ������ � �������
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='090' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // ������ ������ �� ������ � ������ �� ���������� � �������
      if ($num_rows==0):
        // �������� �� ������� ������ �� �����
        // ��������� �� 08.07.2005 $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE ddi='090' AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=3) OR (izgnum>'')) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $s="SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE ddi='090' AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=3) OR (izgnum>'')) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2') OR (ani LIKE '$mask3') OR (ani LIKE '$mask4')";
        $s.=") GROUP BY ddi;";
        $table1=MYSQL_QUERY($s);
        $num_rows1=MYSQL_NUM_ROWS($table1); // ��������� ���������� ����� �������
        if ($num_rows1==0):
          $row1=0;
          // ��������� �� 08.07.2005 $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        // ��������� �� 08.07.2005 MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('090', '$year$month', $row1, $row2);");
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('090', '$year$month', $row1, $row2);");
      endif;

      // �������� ������ �� ������ ������ � ������ ������������� ��������� ��� ������������ ������
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='091' AND yearmonth='$year$month';");
      // �������� �� ������� ������ �� ������ � �������
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='091' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // ������ ������ �� ������ � ������ �� ���������� � �������
      if ($num_rows==0):
        // �������� �� ������� ������ �� �����
        // ��������� �� 08.07.2005 $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='091') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $s="SELECT COUNT(*) AS row1, CEILING((SUM(dur)/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='091') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2') OR (ani LIKE '$mask3') OR (ani LIKE '$mask4')";
        $s.=") GROUP BY ddi;";
        $table1=MYSQL_QUERY($s);
        $num_rows1=MYSQL_NUM_ROWS($table1); // ��������� ���������� ����� �������
        if ($num_rows1==0):
          $row1=0;
          $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('091', '$year$month', $row1, $row2);");
      endif;

      // �������� ������ �� ������ ������ � ������ ������������� ��������� ��� ������������ ������
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='092' AND yearmonth='$year$month';");
      // �������� �� ������� ������ �� ������ � �������
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='092' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // ������ ������ �� ������ � ������ �� ���������� � �������
      if ($num_rows==0):
        // �������� �� ������� ������ �� �����
        // ��������� �� 08.07.2005 $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='092') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $s="SELECT COUNT(*) AS row1, CEILING((SUM(dur)/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='092') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2') OR (ani LIKE '$mask3') OR (ani LIKE '$mask4')";
        $s.=") GROUP BY ddi;";
        $table1=MYSQL_QUERY($s);
        $num_rows1=MYSQL_NUM_ROWS($table1); // ��������� ���������� ����� �������
        if ($num_rows1==0):
          $row1=0;
          $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('092', '$year$month', $row1, $row2);");
      endif;

      // �������� ������ �� ������ ������ � ������ ������������� ��������� ��� ������������ ������
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='093' AND yearmonth='$year$month';");
      // �������� �� ������� ������ �� ������ � �������
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='093' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // ������ ������ �� ������ � ������ �� ���������� � �������
      if ($num_rows==0):
        // �������� �� ������� ������ �� �����
        // ��������� �� 08.07.2005 $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE ddi='093' AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=3) OR (izgnum>'')) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $s="SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE ddi='093' AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=3) OR (izgnum>'')) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2') OR (ani LIKE '$mask3') OR (ani LIKE '$mask4')";
        $s.=") GROUP BY ddi;";
        $table1=MYSQL_QUERY($s);
        $num_rows1=MYSQL_NUM_ROWS($table1); // ��������� ���������� ����� �������
        if ($num_rows1==0):
          $row1=0;
          // ��������� �� 08.07.2005 $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        // ��������� �� 08.07.2005 MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('093', '$year$month', $row1, $row2);");
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('093', '$year$month', $row1, $row2);");
      endif;

      // �������� ������ �� ������ ������ � ������ ������������� ��������� ��� ������������ ������
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='094' AND yearmonth='$year$month';");
      // �������� �� ������� ������ �� ������ � �������
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='094' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // ������ ������ �� ������ � ������ �� ���������� � �������
      if ($num_rows==0):
        // �������� �� ������� ������ �� �����
        // ��������� �� 08.07.2005 $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='094') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $s="SELECT COUNT(*) AS row1, CEILING((SUM(dur)/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='094') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2') OR (ani LIKE '$mask3') OR (ani LIKE '$mask4')";
        $s.=") GROUP BY ddi;";
        $table1=MYSQL_QUERY($s);
        $num_rows1=MYSQL_NUM_ROWS($table1); // ��������� ���������� ����� �������
        if ($num_rows1==0):
          $row1=0;
          $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('094', '$year$month', $row1, $row2);");
      endif;

      // �������� ������ �� ������ ������ � ������ ������������� ��������� ��� ������������ ������
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='095' AND yearmonth='$year$month';");
      // �������� �� ������� ������ �� ������ � �������
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='095' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // ������ ������ �� ������ � ������ �� ���������� � �������
      if ($num_rows==0):
        // �������� �� ������� ������ �� �����
        $s="SELECT COUNT(*) AS row1 FROM arj.irda_$year$month WHERE (ddi='095') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2') OR (ani LIKE '$mask3') OR (ani LIKE '$mask4')";
        $s.=") GROUP BY ddi;";
        $table1=MYSQL_QUERY($s);
        $num_rows1=MYSQL_NUM_ROWS($table1); // ��������� ���������� ����� �������
        if ($num_rows1==0) $row1=0;
        else $row1=mysql_result($table1, 0, "row1");
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('095', '$year$month', $row1, 0);");
      endif;

      // �������� ������ �� ������ ������ � ������ ������������� ��������� ��� ������������ ������
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='096' AND yearmonth='$year$month';");
      // �������� �� ������� ������ �� ������ � �������
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='096' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // ������ ������ �� ������ � ������ �� ���������� � �������
      if ($num_rows==0):
        // �������� �� ������� ������ �� �����
        // ��������� �� 08.07.2005 $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='096') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $s="SELECT COUNT(*) AS row1, CEILING((SUM(dur)/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='096') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2') OR (ani LIKE '$mask3') OR (ani LIKE '$mask4')";
        $s.=") GROUP BY ddi;";
        $table1=MYSQL_QUERY($s);
        $num_rows1=MYSQL_NUM_ROWS($table1); // ��������� ���������� ����� �������
        if ($num_rows1==0):
          $row1=0;
          $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('096', '$year$month', $row1, $row2);");
      endif;

      // �������� ������ �� ������ ������ � ������ ������������� ��������� ��� ������������ ������
      if ($RECALC=="on") MYSQL_QUERY("DELETE FROM newstat.rep$rep WHERE service='097' AND yearmonth='$year$month';");
      // �������� �� ������� ������ �� ������ � �������
      $table=MYSQL_QUERY("SELECT * FROM newstat.rep$rep WHERE service='097' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // ������ ������ �� ������ � ������ �� ���������� � �������
      if ($num_rows==0):
        // �������� �� ������� ������ �� �����
        // ��������� �� 08.07.2005 $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1, SUM(CEILING(dur/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='097') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2')) GROUP BY ddi;");
        $s="SELECT COUNT(*) AS row1, CEILING((SUM(dur)/60)) AS row2 FROM arj.irda_$year$month WHERE (ddi='097') AND (v_mreza>'') AND (dur>0) AND ((ani LIKE '$mask1') OR (ani LIKE '$mask2') OR (ani LIKE '$mask3') OR (ani LIKE '$mask4')";
        $s.=") GROUP BY ddi;";
        $table1=MYSQL_QUERY($s);
        $num_rows1=MYSQL_NUM_ROWS($table1); // ��������� ���������� ����� �������
        if ($num_rows1==0):
          $row1=0;
          $row2=0;
        else:
          $row1=mysql_result($table1, 0, "row1");
          $row2=mysql_result($table1, 0, "row2");
        endif;
        MYSQL_QUERY("INSERT INTO newstat.rep$rep VALUES('097', '$year$month', $row1, $row2);");
      endif;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f1 FROM newstat.rep$rep WHERE service='009d' AND yearmonth='$year$month';"); // ��������� ���������� ������� �� ������ � ������� �����
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows>0) $f1=mysql_result($table, 0, "f1"); else $f1="������!"; // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
      if ($rep==6):
        $tax1=0.066;
      elseif ($rep==7):
        $tax1=0.059;
      endif;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f2 FROM newstat.rep$rep WHERE service='009n' AND yearmonth='$year$month';"); // ��������� ���������� ������� �� ������ � ������ �����
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows>0) $f2=mysql_result($table, 0, "f2"); else $f2="������!"; // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
      if ($rep==6):
        $tax2=$tax1*2;
      elseif ($rep==7):
        $tax2=0.117;
      endif;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f3, duration AS f3_1 FROM newstat.rep$rep WHERE service='075' AND yearmonth='$year$month';"); // ��������� ���������� ������� �� ������
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows>0):
        $f3=mysql_result($table, 0, "f3"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
        $f3_1=mysql_result($table, 0, "f3_1"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
      else:
        $f3="������!";
        $f3_1="������!";
      endif;
      if ($rep==6):
        $tax3=0.0121;
      elseif ($rep==7):
        $tax3=0.031;
      endif;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f4 FROM newstat.rep$rep WHERE service='088' AND yearmonth='$year$month';"); // ��������� ���������� ������� �� ������
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows>0) $f4=mysql_result($table, 0, "f4"); else $f4="������!"; // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
      if ($rep==6):
        $tax4=0.0028;
      elseif ($rep==7):
        $tax4=0.009;
      endif;

      if ($rep==6):
        $tax5=0.101;
      elseif ($rep==7):
        $tax5=0.215;
      endif;
      $table=MYSQL_QUERY("SELECT calls_quantity AS f5, duration AS f5_1 FROM newstat.rep$rep WHERE service='090' AND yearmonth='$year$month';"); // ��������� ���������� ������� �� ������
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows>0):
        $f5=mysql_result($table, 0, "f5"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
        $f5_1=mysql_result($table, 0, "f5_1"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
      else:
        $f5="������!";
        $f5_1="������!";
      endif;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f6, duration AS f6_1 FROM newstat.rep$rep WHERE service='091' AND yearmonth='$year$month';"); // ��������� ���������� ������� �� ������
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows>0):
        $f6=mysql_result($table, 0, "f6"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
        $f6_1=mysql_result($table, 0, "f6_1"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
      else:
        $f6="������!";
        $f6_1="������!";
      endif;
      if ($rep==6):
        $tax6=0.0121;
      elseif ($rep==7):
        $tax6=0.031;
      endif;

      if ($rep==6):
        $table=MYSQL_QUERY("SELECT calls_quantity AS f7 FROM newstat.rep$rep WHERE service='092' AND yearmonth='$year$month';"); // ��������� ���������� ������� �� ������
        $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
        if ($num_rows>0):
          $f7=mysql_result($table, 0, "f7"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
        else:
          $f7="������!";
        endif;
//        $tax7=0.0121;
      elseif ($rep==7):
        $table=MYSQL_QUERY("SELECT calls_quantity AS f7, duration AS f7_1 FROM newstat.rep$rep WHERE service='092' AND yearmonth='$year$month';"); // ��������� ���������� ������� �� ������
        $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
        if ($num_rows>0):
          $f7=mysql_result($table, 0, "f7"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
          $f7_1=mysql_result($table, 0, "f7_1"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
        else:
          $f7="������!";
          $f7_1="������!";
        endif;
//        $tax7=0.031;
      endif;
      $tax7=0.083;

      if ($rep==6):
//        $tax8=0.101;
        $tax8=0.144;
      elseif ($rep==7):
        $tax8=0.144;
      endif;
      $table=MYSQL_QUERY("SELECT calls_quantity AS f8, duration AS f8_1  FROM newstat.rep$rep WHERE service='093' AND yearmonth='$year$month';"); // ��������� ���������� ������� �� ������
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows>0):
        $f8=mysql_result($table, 0, "f8"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
        $f8_1=mysql_result($table, 0, "f8_1"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
      else:
        $f8="������!";
        $f8_1="������!";
      endif;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f9, duration AS f9_1 FROM newstat.rep$rep WHERE service='094' AND yearmonth='$year$month';"); // ��������� ���������� ������� �� ������
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows>0):
        $f9=mysql_result($table, 0, "f9"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
        $f9_1=mysql_result($table, 0, "f9_1"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
      else:
        $f9="������!";
        $f9_1="������!";
      endif;
      if ($rep==6):
        $tax9=0.0121;
      elseif ($rep==7):
        $tax9=0.031;
      endif;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f10 FROM newstat.rep$rep WHERE service='095' AND yearmonth='$year$month';"); // ��������� ���������� ������� �� ������
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows>0) $f10=mysql_result($table, 0, "f10"); else $f10="������!"; // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
      if ($rep==6):
        $tax10=0.0186;
      elseif ($rep==7):
        $tax10=0.023;
      endif;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f11, duration AS f11_1 FROM newstat.rep$rep WHERE service='096' AND yearmonth='$year$month';"); // ��������� ���������� ������� �� ������
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows>0):
        $f11=mysql_result($table, 0, "f11"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
        $f11_1=mysql_result($table, 0, "f11_1"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
      else:
        $f11="������!";
        $f11_1="������!";
      endif;
      if ($rep==6):
        $tax11=0.0121;
      elseif ($rep==7):
        $tax11=0.031;
      endif;

      $table=MYSQL_QUERY("SELECT calls_quantity AS f12, duration AS f12_1 FROM newstat.rep$rep WHERE service='097' AND yearmonth='$year$month';"); // ��������� ���������� ������� �� ������
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows>0):
        $f12=mysql_result($table, 0, "f12"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
        $f12_1=mysql_result($table, 0, "f12_1"); // ���� ������ ��� ��������, � ����� ����� �������� ���������� ��������
      else:
        $f12="������!";
        $f12_1="������!";
      endif;
      if ($rep==6):
        $tax12=0.0121;
      elseif ($rep==7):
        $tax12=0.031;
      endif;

      if ($rep==6):
        if (($f1=="������!")||($f2=="������!")||($f3=="������!")||($f3_1=="������!")||($f4=="������!")||($f5=="������!")||($f5_1=="������!")||($f6=="������!")||($f6_1=="������!")||($f7=="������!")||($f7_1=="������!")||($f8=="������!")||($f8_1=="������!")||($f9=="������!")||($f9_1=="������!")||($f10=="������!")||($f11=="������!")||($f11_1=="������!")||($f12=="������!")||($f12_1=="������!")):
          ($sum=="������!");
        else:
          $sum=
          ($f1*$tax1)+ // 009d
          ($f2*$tax2)+ // 009n
          ($f3_1*$tax3)+ // 075
          ($f4*$tax4)+ // 088
          ($f5_1*$tax5)+ // 090
          ($f6_1*$tax6)+ // 091
          ($f7*$tax7)+ // 092
          ($f8_1*$tax8)+ // 093
          ($f9_1*$tax9)+ // 094
          ($f10*$tax10)+ // 095
          ($f11_1*$tax11)+ // 096
          ($f12_1*$tax12); // 097
        endif;
      elseif ($rep==7):
        if (($f1=="������!")||($f2=="������!")||($f3=="������!")||($f3_1=="������!")||($f4=="������!")||($f5=="������!")||($f5_1=="������!")||($f6=="������!")||($f6_1=="������!")||($f7=="������!")||($f7_1=="������!")||($f8=="������!")||($f8_1=="������!")||($f9=="������!")||($f9_1=="������!")||($f10=="������!")||($f11=="������!")||($f11_1=="������!")||($f12=="������!")||($f12_1=="������!")):
          ($sum=="������!");
        else:
          $sum=
          ($f1*$tax1)+ // 009d
          ($f2*$tax2)+ // 009n
          ($f3_1*$tax3)+ // 075
          ($f4*$tax4)+ // 088
          ($f5_1*$tax5)+ // 090
          ($f6_1*$tax6)+ // 091
          ($f7*$tax7)+ // 092
          ($f8_1*$tax8)+ // 093
          ($f9_1*$tax9)+ // 094
          ($f10*$tax10)+ // 095
          ($f11_1*$tax11)+ // 096
          ($f12_1*$tax12); // 097
        endif;
      endif;
?>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">009</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;"><?print $f1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f2;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;"><?print $tax1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $tax2;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;"><?if ($f1=="������!") print "������!"; else print $tax1*$f1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;"><?if ($f2=="������!") print "������!"; else print $tax2*$f2;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if (($f1=="������!")||($f2=="������!")) print "������!"; else print (($tax1*$f1)+($tax2*$f2));?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">088</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;" COLSPAN="2"><?print $f4;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;" COLSPAN="2"><?print $tax4;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;" COLSPAN="2"><?if ($f4=="������!") print "������!"; else print $tax4*$f4;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f4=="������!") print "������!"; else print $tax4*$f4;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">092</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;" COLSPAN="2"><?print $f7;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;" COLSPAN="2"><?print $tax7;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;" COLSPAN="2"><?if ($f7=="������!") print "������!"; else print $tax7*$f7;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f7=="������!") print "������!"; else print $tax7*$f7;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 2px;">095</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;" COLSPAN="2"><?print $f10;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;" COLSPAN="2"><?print $tax10;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;" COLSPAN="2"><?if ($f10=="������!") print "������!"; else print $tax10*$f10;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?if ($f10=="������!") print "������!"; else print $tax10*$f10;?></TD>
        </TR>
      </TBODY>
    </TABLE>
    <TABLE BORDER="1" WIDTH="100%" ALIGN="CENTER" STYLE="border: 0 solid #FFFFFF; font-size: 8pt;">
      <TBODY STYLE="vertical-align: top;">
        <TR><TD COLSPAN="8" STYLE="padding: 0.5cm 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 9pt;">5.2. ������ �� �������� �������������� �� ������</TD></TR>
        <TR VALIGN="MIDDLE" STYLE="font-weight: bold;">
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 2px;">������</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">���������� ����������</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">����������������� ����������, �����</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">�����, �������� ���</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;">�����, �������� ���</TH>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 2px;"><B>I</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>II</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>III</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>IV</B></TD>
          <TD STYLE="font-size: 7pt; padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><B>V</B><BR><FONT STYLE="font-size: 6pt;">(��. III * ��. IV)</FONT></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">075</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f3;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f3_1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $tax3;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f3_1=="������!") print "������!"; else print $tax3*$f3_1;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">090</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f5;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f5_1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $tax5;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f5_1=="������!") print "������!"; else print $tax5*$f5_1;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">091</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f6;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f6_1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $tax6;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f6_1=="������!") print "������!"; else print $tax6*$f6_1;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">093</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f8;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f8_1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $tax8;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f8_1=="������!") print "������!"; else print $tax8*$f8_1;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">094</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f9;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f9_1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $tax9;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f9_1=="������!") print "������!"; else print $tax9*$f9_1;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 2px;">096</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f11;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $f11_1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?print $tax11;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;"><?if ($f11_1=="������!") print "������!"; else print $tax11*$f11_1;?></TD>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 2px;">097</TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?print $f12;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?print $f12_1;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?print $tax12;?></TD>
          <TD STYLE="padding: 2px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?if ($f12_1=="������!") print "������!"; else print $tax12*$f12_1;?></TD>
        </TR>
        <TR><TD COLSPAN="4" STYLE="padding: 0.5cm 0 0 0; font-weight: bold; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 9pt;">����� � ������ ��� &laquo;����������&raquo;:</TD><TD STYLE="padding: 0.5cm 0 0 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: right; font-size: 9pt; font-weight: bold;"><?print "$sum ����. ���";?></TD></TR>
        <TR><TD COLSPAN="4" STYLE="padding: 0; font-style: italic; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 9pt;">���� ������� ��� �� <?print "$stopdate $months2[$i] $year ����";?>:</TD><TD STYLE="padding: 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: right; font-size: 9pt; font-style: italic;"><?print "���. ���.";?></TD></TR>
        <TR><TD COLSPAN="4" STYLE="padding: 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 9pt;">���������� � ����������� ������:</TD><TD STYLE="padding: 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: right; font-size: 9pt;"><?print "���. ���.";?></TD></TR>
        <TR VALIGN="BOTTOM" STYLE="height: 1.4cm;"><TD COLSPAN="4" STYLE="padding: 0; text-align: left; font-size: 6pt; border-color: #FFFFFF; border-style: solid; border-width: 0;"><I>����������:</I><BR>*: ���������� �������� ����� � 06<SUP>00</SUP> �� 21<SUP>59</SUP> (��� ���������� ������ &laquo;009&raquo;, 8-ABC-9900911)<BR>**: ���������� �������� ����� � 21<SUP>00</SUP> �� 05<SUP>59</SUP> (��� ���������� ������ &laquo;009&raquo;, 8-ABC-9900911)</TD><TD COLSPAN="3" STYLE="text-align: right; padding-top: 0; border-color: gray; border-style: solid; border-width: 0; font-size: 6pt;">���� ��� �������� ������:<BR>(8017)2261288, (8017)2222901</TD></TR>
      </TBODY>
    </TABLE>
<?
    elseif ($rep==8):
      if ($time=="lastmonth"):
        $startdate=$lmbd;
        $stopdate=$lmed;
        $month=$lmm;
        $year=$lmy;
      elseif ($time=="anothermonth"):
        $startdate=$ambd;
        $stopdate=$amed;
        $month=$amm;
        $year=$amy;
      endif;
      // ���������� �������� ���� ������� ��� ���
      if ($startdate<10) $startdate="0$startdate";
      if ($stopdate<10) $stopdate="0$stopdate";
      if ($month<10) $month="0$month";

      $table=MYSQL_QUERY("SHOW TABLES FROM arj LIKE 'irda_$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows==0):
        print "SHOW TABLES FROM arj LIKE 'irda_$year$month';";
        $month=$month+0;
?>
    <P>����� �� ����� ���� ������ �� ������� ���������� ������� ������ �� <?print "$months[$month] $year ����";?>!</P>
<?
        die("");
      else:
        $table=MYSQL_QUERY("SELECT COUNT(*) AS f1 FROM arj.irda_$year$month;");
        $rows=mysql_result($table, 0, "f1");
        if ($rows==0):
          print "SELECT COUNT(*) AS f1 FROM arj.irda_$year$month;";
          $month=$month+0;
?>
    <P>����� �� ����� ���� ������ �� ������� ���������� ������ � ������� �� �� <?print "$months[$month] $year ����";?>!</P>
<?
          die("");
        endif;
      endif;
      $i=$month+0;
      // !!! ��������� ������� !!!
      if ($year<2004):
        $tax1=84;
      elseif ($year==2004):
        if ($i<=2): $tax1=84; endif;
        if (($i>=3)&&($i<=5)): $tax1=87; endif; // ������� � 01 ������ 2004 ���� ����� �� 009 �������� 87 ������
        if ($i>5): $tax1=90; endif; // ������� � 15 ��� 2004 ���� ����� �� 009 �������� 90 ������
      elseif ($year==2005):
        $tax1=100; // ???
        if ($i>=1) $tax1=110; // ������� � 15 ������ 2005 ���� ����� �� 009 �������� 110 ������
        if ($i>6) $tax1=111; // ������� � 01 ���� 2005 ���� ����� �� 009 �������� 111 ������
        if ($i>7) $tax1=112; // ������� � 01 ������� 2005 ���� ����� �� 009 �������� 123 �����
        if ($i>7) $tax1=123; // ������� � 18 ������� 2005 ���� ����� �� 009 �������� 123 �����
        if ($i>10) $tax1=124; // ������� � 26 ������� 2005 ���� ����� �� 009 �������� 124 �����
        if ($i>10) $tax1=125; // ������� � 15 ������ 2005 ���� ����� �� 009 �������� 125 ������
        if ($i>11) $tax1=126; // ������� � 1 ������� 2005 ���� ����� �� 009 �������� 126 ������
      endif;
      if ($year==2006):
        $tax1=126;
      endif;
      $tax2=$tax1*2;
      $Subject="�������� � �������� ������� � ���� ��� \"����������\" �� ������� ���������� ������ �� ���� ���� \"���\" �� ������ � $startdate �� $stopdate $months2[$i] $year ����";
      // �������� �� ������� ����� ��������� �������
      $table=MYSQL_QUERY("SHOW TABLES FROM newstat LIKE 'rep8';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // �������� ������� � ������ � ����������
      if ($num_rows==0)
        MYSQL_QUERY("CREATE TABLE newstat.rep8 (service char(4) NOT NULL default '', yearmonth char(6) NOT NULL default '', calls_quantity int(11) unsigned default NULL) TYPE=MyISAM;");
      // �������� ���� ������� �� ������ ������ � ������ ������������� ��������� ��� ������������ ������
      if ($RECALC=="on")
        MYSQL_QUERY("DELETE FROM newstat.rep8 WHERE yearmonth='$year$month';");
      // �������� �� ������� ������ �� ������ � �������

      $table=MYSQL_QUERY("SELECT * FROM newstat.rep8 WHERE service='009d' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // ������ ������ �� ������ � ������ �� ���������� � �������
      if ($num_rows==0):
        // �������� �� ������� ������ �� �����
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1 FROM arj.irda_$year$month WHERE ddi='009' AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=3) OR (izgnum>'')) AND ((ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______') OR (ani LIKE '0298______')) AND ((vrijeme>='06:00:00') AND (vrijeme<'22:00:00')) GROUP BY ddi;"); // ��������� ���������� ������� �� ������ � ������� �����
        $num_rows1=MYSQL_NUM_ROWS($table1); // ��������� ���������� ����� �������
        if ($num_rows1==0) $row1=0;
        else $row1=mysql_result($table1, 0, "row1");
        MYSQL_QUERY("INSERT INTO newstat.rep8 VALUES('009d', '$year$month', $row1);");
      endif;

      $table=MYSQL_QUERY("SELECT * FROM newstat.rep8 WHERE service='009n' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      // ������ ������ �� ������ � ������ �� ���������� � �������
      if ($num_rows==0):
        // �������� �� ������� ������ �� �����
        $table1=MYSQL_QUERY("SELECT COUNT(*) AS row1 FROM arj.irda_$year$month WHERE ddi='009' AND (v_mreza>'') AND (v_oper>'') AND (rm>0) AND (druga_info=0) AND (((dur-(TIME_TO_SEC(v_oper)-TIME_TO_SEC(v_mreza)))>=3) OR (izgnum>'')) AND ((ani LIKE '0297______') OR (ani LIKE '0295______') OR (ani LIKE '0292______') OR (ani LIKE '0298______')) AND ((vrijeme<'06:00:00') OR (vrijeme>='22:00:00')) GROUP BY ddi;"); // ��������� ���������� ������� �� ������ � ������ �����
        $num_rows1=MYSQL_NUM_ROWS($table1); // ��������� ���������� ����� �������
        if ($num_rows1==0) $row1=0;
        else $row1=mysql_result($table1, 0, "row1");
        MYSQL_QUERY("INSERT INTO newstat.rep8 VALUES('009n', '$year$month', $row1);");
      endif;

      $f1="������!"; // ���� ��� ���������� ������� �� ����
      $f2="������!"; // ���� ��� ����� �� ����
      $f3="������!"; // ���� ��� ���������� ������� �� ����
      $f4="������!"; // ���� ��� ����� �� ����
      $f5="������!"; // ���� ��� �������� �����
      $table=MYSQL_QUERY("SELECT calls_quantity AS f1 FROM newstat.rep8 WHERE service='009d' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows>0):
        $f1=mysql_result($table, 0, "f1");
        $f2=$tax1*$f1;
      endif;
      $table=MYSQL_QUERY("SELECT calls_quantity AS f3 FROM newstat.rep8 WHERE service='009n' AND yearmonth='$year$month';");
      $num_rows=MYSQL_NUM_ROWS($table); // ��������� ���������� ����� �������
      if ($num_rows>0):
        $f3=mysql_result($table, 0, "f3");
        $f4=$tax2*$f3;
      endif;
      // ���� ����� �� ���� � �� ���� �������� �������, � �� �������� "������!" - ��������� �������� �����
      if (($f2!="������!")&&($f4!="������!")) $f5=$f2+$f4;
      // ����� ������ �� �����
?>
    <TABLE BORDER="1" ALIGN="CENTER" STYLE="border: 0 solid #FFFFFF; font-size: 8pt;">
      <TBODY STYLE="vertical-align: top;">
        <TR STYLE="font-size: 6pt;"><TD COLSPAN="5" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0;">&nbsp;</TD><TD COLSPAN="4" STYLE="border-color: gray; border-style: solid; border-width: 0 0 1px 0; text-align: right;">���������-�������������� ��� ������� &laquo;����&raquo;<BR>��� &laquo;����������&raquo;</TD></TR>
        <TR><TD COLSPAN="9" STYLE="border-color: #FFFFFF; border-style: solid; border-width: 0; font-size: 13pt; margin-top: 5px; margin-bottom: 5px; text-align: center; font-weight: bold; color: #000000; background-color: transparent; padding-top: 2cm; padding-bottom: 0.5cm;">��������&nbsp;�&nbsp;��������&nbsp;������� �&nbsp;����&nbsp;���&nbsp;&laquo;����������&raquo; ��&nbsp;�������&nbsp;����������&nbsp;������ ��&nbsp;����&nbsp;����&nbsp;&laquo;���&raquo;</TD></TR>
        <TR><TD COLSPAN="9" STYLE="padding: 1cm 0cm 0.5cm 0cm; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: right; font-size: 10pt;">������: <B><?print "$startdate-$stopdate $months2[$i] $year ����";?></B></TD></TR>
        <TR VALIGN="MIDDLE" STYLE="font-weight: bold;">
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 2px;" ROWSPAN="2">������</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 2px 0;" ROWSPAN="2">������</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 1px 0;" COLSPAN="2">���������� ����������</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 1px 0;" COLSPAN="2">����� (���. ���.)</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 1px 0;" COLSPAN="3">����� (���. ���.)</TH>
        </TR>
        <TR VALIGN="MIDDLE" STYLE="font-weight: bold;">
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">������� �����*</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;">������ �����**</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">������� �����*</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;">������ �����**</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">������� �����*</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;">������ �����**</TH>
          <TH ALIGN="CENTER" STYLE="padding: 5px; border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;">�����</TH>
        </TR>
        <TR ALIGN="CENTER">
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 2px 2px;">009</TD>
          <TD WIDTH="150px" STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?print "$startdate-$stopdate.$month.$year";?></TD>
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><?print $f1;?></TD>
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?print $f3;?></TD>
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><?print $tax1;?></TD>
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?print $tax2;?></TD>
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><?print $f2;?></TD>
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 1px 2px 0;"><?print $f4;?></TD>
          <TD STYLE="border-color: #000000; border-style: solid; border-width: 0 2px 2px 0;"><?print $f5;?></TD>
        </TR>
        <TR><TD COLSPAN="9" STYLE="padding: 10px 0; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 10pt;\">����� � ������ ��� &laquo;����������&raquo;:&nbsp;&nbsp;&nbsp;<B><?print "$f5&nbsp;���.&nbsp;���.";?></B></TD></TR>
        <TR VALIGN="BOTTOM" STYLE="height: 7.7cm;"><TD COLSPAN="9" STYLE="padding-bottom: 1cm; text-align: left; font-size: 7pt; border-color: #FFFFFF; border-style: solid; border-width: 0;"><I>����������:</I><BR>*: ���������� �������� ����� � 06<SUP>00</SUP> �� 21<SUP>59</SUP> (��� ���������� ������ &laquo;009&raquo;)<BR>**: ���������� �������� ����� � 21<SUP>00</SUP> �� 05<SUP>59</SUP> (��� ���������� ������ &laquo;009&raquo;)</TD></TR>
        <TR>
<?
      if ($maker!=""):
?>
          <TD COLSPAN="6" STYLE="padding-top: 10px; border-color: gray; border-style: solid; border-width: 1px 0 0 0; text-align: left; font-size: 6pt;">�����������:<BR>
<?
        if ($makerstate!=""): print "$makerstate<BR>"; endif;
        print "$maker";
        if ($makerphone!=""): print "<BR>$makerphone"; endif;
      else:
?>
          <TD COLSPAN="6" STYLE="border-color: white; border-style: solid; border-width: 0;">
<?
      endif;
?>
          </TD>
          <TD COLSPAN="3" STYLE="text-align: right; padding-top: 10px; border-color: gray; border-style: solid; border-width: 1px 0 0 0; font-size: 6pt;">���� ��� �������� ������:<BR>(8017)2261288, (8017)2222901</TD>
        </TR>
      </TBODY>
    </TABLE>
<?
      $i=$month+0;
      // ������������ ������ ������
      $message="<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">
<HTML>
  <BODY STYLE=\"font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 8pt; background-color: white; margin: 10px; color: #000000;\">
    <TABLE BORDER=\"1\" ALIGN=\"CENTER\" STYLE=\"caption-side: top; table-layout: auto; empty-cells: show; font-size: 8pt; float: none; clear: both; border-collapse: collapse; background-color: transparent; border: 0 solid #FFFFFF;\">
      <TBODY STYLE=\"vertical-align: top;\">
        <TR><TD COLSPAN=\"5\" STYLE=\"border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: right; font-size: 6pt;\">&nbsp;</TD><TD COLSPAN=\"4\" STYLE=\"border-color: gray; border-style: solid; border-width: 0 0 1px 0; text-align: right; font-size: 6pt;\">���������-�������������� ��� ������� &laquo;����&raquo;<BR>��� &laquo;����������&raquo;</TD></TR>
        <TR><TD COLSPAN=\"9\" STYLE=\"border-color: #FFFFFF; border-style: solid; border-width: 0; font-size: 13pt; margin-top: 5px; margin-bottom: 5px; text-align: center; font-weight: bold; color: #000000; background-color: transparent; padding-top: 2cm; padding-bottom: 0.5cm;\">��������&nbsp;�&nbsp;��������&nbsp;������� �&nbsp;����&nbsp;���&nbsp;&laquo;����������&raquo; ��&nbsp;�������&nbsp;����������&nbsp;������ ��&nbsp;����&nbsp;����&nbsp;&laquo;���&raquo;</TD></TR>
        <TR><TD COLSPAN=\"9\" STYLE=\"padding: 1cm 0cm 0.5cm 0cm; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: right; font-size: 10pt;\">������: <B>$startdate-$stopdate $months2[$i] $year ����</B></TD></TR>
        <TR VALIGN=\"MIDDLE\" STYLE=\"font-weight: bold;\">
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 1px 1px 2px;\" ROWSPAN=\"2\">������</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 1px 1px  1px;\" ROWSPAN=\"2\">������</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 1px 1px  1px;\" COLSPAN=\"2\">���������� ����������</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 1px 1px  1px;\" COLSPAN=\"2\">����� (���. ���.)</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 2px 2px 1px  1px;\" COLSPAN=\"3\">����� (���. ���.)</TH>
        </TR>
        <TR VALIGN=\"MIDDLE\" STYLE=\"font-weight: bold;\">
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 1px;\">������� �����*</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;\">������ �����**</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 1px;\">������� �����*</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;\">������ �����**</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 1px;\">������� �����*</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 0 1px 1px 0;\">������ �����**</TH>
          <TH ALIGN=\"CENTER\" STYLE=\"padding: 5px; border-color: #000000; border-style: solid; border-width: 0 2px 1px 0;\">�����</TH>
        </TR>
        <TR VALIGN=\"MIDDLE\">
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 2px;\">009</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 1px;\">$startdate-$stopdate.$month.$year</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 1px;\">$f1</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 0;\">$f3</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 1px;\">$tax1</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 0;\">$tax2</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 1px;\">$f2</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 1px 2px 0;\">$f4</TD>
          <TD ALIGN=\"CENTER\" STYLE=\"border-color: #000000; border-style: solid; border-width: 1px 2px 2px 0;\">$f5</TD>
        </TR>
        <TR><TD COLSPAN=\"9\" STYLE=\"padding: 10px; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 10pt;\">����� � ������ ��� &laquo;����������&raquo;:&nbsp;&nbsp;&nbsp;<B>$f5&nbsp;���.&nbsp;���.</B></TD></TR>
        <TR><TD COLSPAN=\"5\" STYLE=\"padding-top: 14.5cm; padding-bottom: 1cm; border-color: gray; border-style: solid; border-width: 0 0 1px 0; text-align: left; font-size: 7pt;\"><I>����������:</I><BR>*: ���������� �������� ����� � 06:00 �� 21:59 (��� ���������� ������ &laquo;009&raquo;)<BR>**: ���������� �������� ����� � 21:00 �� 05:59 (��� ���������� ������ &laquo;009&raquo;)</TD COLSPAN=\"4\"><TD></TD></TR>
";
      if ($maker!=""):
        $message.="        <TR>
          <TD COLSPAN=\"9\" STYLE=\"padding-top: 10px; border-color: #FFFFFF; border-style: solid; border-width: 0; text-align: left; font-size: 6pt;\">�����������:<BR>
";
        if ($makerstate!="") $message.="$makerstate<BR>";
        $message.="$maker";
        if ($makerphone!="") $message.="<BR>$makerphone";
        $message.="
          </TD>
        </TR>
      </TBODY>
    </TABLE>
";
      endif;
      $message.="  </BODY>\n</HTML>";
    endif; // ($rep=="����� ������")
    // �������� ����� ��������� � ������ ���� ��� ������ ��������������� ����� � ��������� ���� ���������
    if (($EMAIL1Addr!="")&&($ACTION=="email")&&($message!="")): $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"���������-�������������� ��� ������� ���� ��� ����������\" <sic009@tut.by>\nTo: "; if ($EMAIL1Name!="") $Headers.="\"$EMAIL1Name\" "; $Headers.="<$EMAIL1Addr>\nContent-Type: text/html; charset=Windows-1251"; if (mail("$EMAIL1Addr",$Subject,$message,$Headers)): print "<BR><HR><P>�������� ������ "; if ($EMAIL1Name!=""): print "<B>$EMAIL1Name</B> "; endif; print "�� ������ <B>$EMAIL1Addr</B> ������ �������.</P>"; else: print "<BR><HR><P>�� ������� ��������� ����� "; if ($EMAIL1Name!=""): print "<B>$EMAIL1Name</B> "; endif; print "�� ������ <B>$EMAIL1Addr</B>!</P>"; endif; endif;
    if (($EMAIL2Addr!="")&&($ACTION=="email")&&($message!="")): $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"���������-�������������� ��� ������� ���� ��� ����������\" <sic009@tut.by>\nTo: "; if ($EMAIL2Name!="") $Headers.="\"$EMAIL2Name\" "; $Headers.="<$EMAIL2Addr>\nContent-Type: text/html; charset=Windows-1251"; if (mail("$EMAIL2Addr",$Subject,$message,$Headers)): print "<P>�������� ������ "; if ($EMAIL2Name!=""): print "<B>$EMAIL2Name</B> "; endif; print "�� ������ <B>$EMAIL2Addr</B> ������ �������.</P>"; else: print "<P>�� ������� ��������� ����� "; if ($EMAIL2Name!=""): print "<B>$EMAIL2Name</B> "; endif; print "�� ������ <B>$EMAIL2Addr</B>!</P>"; endif; endif;
    if (($EMAIL3Addr!="")&&($ACTION=="email")&&($message!="")): $Headers="Priority: urgent\nMIME-Version: 1.0\nContent-Type: text/html; charset=Windows-1251\nFrom: \"���������-�������������� ��� ������� ���� ��� ����������\" <sic009@tut.by>\nTo: "; if ($EMAIL3Name!="") $Headers.="\"$EMAIL3Name\" "; $Headers.="<$EMAIL3Addr>\nContent-Type: text/html; charset=Windows-1251"; if (mail("$EMAIL3Addr",$Subject,$message,$Headers)): print "<P>�������� ������ "; if ($EMAIL3Name!=""): print "<B>$EMAIL3Name</B> "; endif; print "�� ������ <B>$EMAIL3Addr</B> ������ �������.</P>"; else: print "<P>�� ������� ��������� ����� "; if ($EMAIL3Name!=""): print "<B>$EMAIL3Name</B> "; endif; print "�� ������ <B>$EMAIL3Addr</B>!</P>"; endif; endif;
  break;
endswitch;
/*
if (($STEP==5)): // ��� ���� �������: ���� ������������ ��� 5 � ������� ���������� �� ��������, ���������� ������ "<< �����" � "������"
?>
    <BR><CENTER><INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="history.back();" VALUE="<< �����" NAME="back"><?if ($ACTION=="print"):?>&nbsp;<INPUT TYPE="BUTTON" STYLE="WIDTH: 100px; HEIGHT: 25px" ONCLICK="document.all.print.style.visibility='hidden'; document.all.back.style.visibility='hidden'; if (typeof(window.print) != 'undefined') {window.print();}; document.all.back.style.visibility = '';document.all.print.style.visibility = '';" VALUE="������" NAME="print"><?endif;?></CENTER>
<?
endif;
*/
?>
  </BODY>
</HTML>
