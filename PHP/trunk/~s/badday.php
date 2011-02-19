<!-- Страница выдаётся при выставлении несуществующей даты или неправильного промежутка времени -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
    <TITLE>Ошибка!</TITLE>
    <META CONTENT="no-cache" HTTP-EQUIV="pragma">
    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">
    <META CONTENT=Dynamic name=Document-state>
    <META content="text/html; charset=Windows-1251" http-equiv=Content-Type>
    <STYLE>@import url(ie5.css);</STYLE>
    <LINK DISABLED REL="stylesheet" HREF="ie5.css">
  </HEAD>
  <BODY>
<?
if ($vdate!=""):
?>
    <H1><?print $vdate;?> - введена несуществующая дата!</H1>
    <P>Нажмите клавишу <A HREF="javascript:history.back()">&laquo;Backspace&raquo;</A> для возврата к предыдущему шагу.</P>
<?
endif;
?>
  </BODY>
</HTML>