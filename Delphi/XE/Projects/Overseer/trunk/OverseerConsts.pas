unit OverseerConsts;

interface

uses
  OverseerTypes;

const
  STATUSBAR_STATE_PANEL_NUMBER: integer=0;
  STATUSBAR_PROGRESS_PANEL_NUMBER: integer=1;
  STATUSBAR_HINT_PANEL_NUMBER: integer=2;
  ICON_ERROR=15; // номера иконок в списке ImageList1
  ICON_WARNING=13;
  ICON_INFO=6;
  ICON_SQL=14;
  ICON_DEBUG=33;
  ICON_BUSY=0;
  ICON_READY=1;
  ICON_FINDGUID=28;
  ICON_ACCOUNTS=12;
  ICON_CONFIGURATION=11;
  ICON_ORALSERVICES=12;
  ICON_AUTOSERVICES=32;

  WMCD_MODALLOG: integer=221; // идентификатор типа строки содержайщей данные лога, принимаемой через сообщение WM_COPYDATA из модальных окон
  WMCD_THREADLOG: integer=222; // идентификатор типа строки содержайщей данные лога, принимаемой через сообщение WM_COPYDATA из дочернего потока

  saQuarters: array [1..4] of string=('I', 'II', 'III', 'IV');
  saMonths1: array [1..12] of string=('январь', 'февраль', 'март', 'апрель', 'май', 'июнь', 'июль', 'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь');
  saMonths2: array [1..12] of string=('января', 'февраля', 'марта', 'апреля', 'мая', 'июня', 'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря');

  aRegions_Count=6;
  aRegions: array [0..aRegions_Count-1] of trRegion=( //
    (sPrefix: '015'; sName: 'Гродненская область'),
    (sPrefix: '016'; sName: 'Брестская область'),
    (sPrefix: '017'; sName: 'Минская область'),
    (sPrefix: '021'; sName: 'Витебская область'),
    (sPrefix: '022'; sName: 'Могилёвская область'),
    (sPrefix: '023'; sName: 'Гомельская область')
  ); //

  aServices_Count=26;
  aServices: array [0..aServices_Count-1] of trService=( //
    (sNumber: '109'; sName: 'Платная справка'; bAutoService: False; bUsedInReport_SIC_03: True), //
    (sNumber: '130'; sName: 'Телефонный центр обслуживания клиентов'; bAutoService: False; bUsedInReport_SIC_03: False), //
    (sNumber: '175'; sName: 'Тарифы жилищно-коммунального хозяйства'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '188'; sName: 'Служба точного времени'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '190'; sName: 'ГорИнфоСервис'; bAutoService: False; bUsedInReport_SIC_03: True), //
    (sNumber: '191'; sName: 'Киноафиша'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '192'; sName: 'Посмеёмся'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '193'; sName: 'Отдых и развлечения'; bAutoService: False; bUsedInReport_SIC_03: True), //
    (sNumber: '194'; sName: 'Гороскоп'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '195'; sName: 'Прогноз погоды'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '196'; sName: 'Сказка по телефону'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '197'; sName: 'Именины'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '199'; sName: 'Бесплатная справка'; bAutoService: False; bUsedInReport_SIC_03: False), //
    (sNumber: '2003498'; sName: 'Back Office'; bAutoService: False; bUsedInReport_SIC_03: False), //
    (sNumber: '9910911'; sName: 'Межгород, платная справка'; bAutoService: False; bUsedInReport_SIC_03: False), //
    (sNumber: '99175'; sName: 'Межгород, тарифы жилищно-коммунального хозяйства'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '99188'; sName: 'Межгород, служба точного времени'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '99190'; sName: 'Межгород, ГорИнфоСервис'; bAutoService: False; bUsedInReport_SIC_03: False), //
    (sNumber: '99191'; sName: 'Межгород, киноафиша'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '99192'; sName: 'Межгород, Посмеёмся'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '99193'; sName: 'Межгород, Отдых и развлечения'; bAutoService: False; bUsedInReport_SIC_03: False), //
    (sNumber: '99194'; sName: 'Межгород, гороскоп'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '99195'; sName: 'Межгород, прогноз погоды'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '99196'; sName: 'Межгород, сказки для детей'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '99197'; sName: 'Межгород, именины'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '9919911'; sName: 'Межгород, бесплатная справка'; bAutoService: False; bUsedInReport_SIC_03: False) //
    ); //

  aNets_Count=7;
  aNets: array [0..aNets_Count-1] of trNet=( //
    (sName: ''; sHTMLMobileNetName: ''; sHTMLAbonentsName: ''; sQuery: ''), // все сети полностью
    (sName: 'МГТС'; sHTMLMobileNetName: ''; sHTMLAbonentsName: '&nbsp;абонентов&nbsp;&laquo;МГТС&raquo;'; sQuery: //
    '(' //
    // городские телефоны, начинающиеся на цифру "2"
    // нормальная длина номера
    +'(ani LIKE "00172______") OR ' //
    +'(ani LIKE  "0172______") OR ' //
    +'(ani LIKE    "02______") OR ' //
    +'(ani LIKE     "2______") OR ' //
    // обрезана одна цифра с конца
    +'(ani LIKE "00172_____") OR ' //
    +'(ani LIKE  "0172_____") OR ' //
    +'(ani LIKE    "02_____") OR ' //
    // обрезаны две цифры с конца
    +'(ani LIKE "00172____") OR ' //
    +'(ani LIKE  "0172____") OR ' //
    +'(ani LIKE    "02____") OR ' //

    // городские телефоны, начинающиеся на цифру "3"
    // нормальная длина номера
    +'(ani LIKE "00173______") OR ' //
    +'(ani LIKE  "0173______") OR ' //
    +'(ani LIKE    "03______") OR ' //
    +'(ani LIKE     "3______") OR ' //
    // обрезана одна цифра с конца
    +'(ani LIKE "00173_____") OR ' //
    +'(ani LIKE  "0173_____") OR ' //
    +'(ani LIKE    "03_____") OR ' //
    // обрезаны две цифры с конца
    +'(ani LIKE "00173____") OR ' //
    +'(ani LIKE  "0173____") OR ' //
    +'(ani LIKE    "03____") OR ' //

    // пригородные телефоны, начинающиеся на цифру "5"
    +'(ani LIKE "00175______") OR ' //
    +'(ani LIKE  "0175______") OR ' //
    +'(ani LIKE    "05______") OR ' //
    +'(ani LIKE     "5______") OR ' //

    // таксофоны, начинающиеся на цифру "8"
    +'(ani LIKE "00178______") OR ' //
    +'(ani LIKE  "0178______") OR ' //
    +'(ani LIKE    "08______") OR ' //
    +'(ani LIKE     "8______")'+ //
    ')' //
    ), //
    (sName: 'МЦС'; sHTMLMobileNetName: 'СП&nbsp;&laquo;МЦС&raquo;'; sHTMLAbonentsName: '&nbsp;абонентов&nbsp;сети&nbsp;СП&nbsp;&laquo;МЦС&raquo;'; sQuery: //
    '(' //
    +'(ani LIKE "00291______") OR ' //
    +'(ani LIKE  "0291______") OR ' //

    +'(ani LIKE "00293______") OR ' //
    +'(ani LIKE  "0293______") OR ' //

    +'(ani LIKE "00296______") OR ' //
    +'(ani LIKE  "0296______") OR ' //

    +'(ani LIKE "00299______") OR ' //
    +'(ani LIKE  "0299______") OR ' //

    +'(ani LIKE "0044_______") OR ' //
    +'(ani LIKE  "044_______")'+ //
    ')' //
    ), //
    (sName: 'МТС'; sHTMLMobileNetName: 'СООО&nbsp;&laquo;МТС&raquo;'; sHTMLAbonentsName: '&nbsp;абонентов&nbsp;сети&nbsp;СООО&nbsp;&laquo;МТС&raquo;'; sQuery: //
    '(' //
    +'(ani LIKE "00292______") OR ' //
    +'(ani LIKE  "0292______") OR ' //

    +'(ani LIKE "00295______") OR ' //
    +'(ani LIKE  "0295______") OR ' //

    +'(ani LIKE "00297______") OR ' //
    +'(ani LIKE  "0297______") OR ' //

    +'(ani LIKE "00298______") OR ' //
    +'(ani LIKE  "0298______") OR ' //

    +'(ani LIKE "0033_______") OR ' //
    +'(ani LIKE  "033_______")'+ //
    ')' //
    ), //
    (sName: 'БеСТ'; sHTMLMobileNetName: 'ЗАО&nbsp;&laquo;БеСТ&raquo;'; sHTMLAbonentsName: '&nbsp;абонентов&nbsp;сети&nbsp;ЗАО&nbsp;&laquo;БеСТ&raquo;'; sQuery: //
    '(' //
    +'(ani LIKE "00255______") OR ' //
    +'(ani LIKE  "0255______") OR ' //

    +'(ani LIKE "00256______") OR ' //
    +'(ani LIKE  "0256______") OR ' //

    +'(ani LIKE "00257______") OR ' //
    +'(ani LIKE  "0257______") OR ' //

    +'(ani LIKE "00259______") OR ' //
    +'(ani LIKE  "0259______")'+ //
    ')' //
    ), //
    (sName: 'БелСел'; sHTMLMobileNetName: 'СП&nbsp;&laquo;БелСел&raquo;'; sHTMLAbonentsName: '&nbsp;абонентов&nbsp;сети&nbsp;СП&nbsp;&laquo;БелСел&raquo;'; sQuery: //
    '(' //
    +'(ani LIKE "00294______") OR ' //
    +'(ani LIKE  "0294______")'+ //
    ')' //
    ), //
    (sName: 'прочие'; sHTMLMobileNetName: ''; sHTMLAbonentsName: '&nbsp;прочих&nbsp;абонентов'; sQuery: //
    '(!' // выборка только тех телефонов, которые не попадают в указанный ниже список ;)
    +'(' //

    // городские телефоны
    +'(ani LIKE "00172______") OR ' //
    +'(ani LIKE  "0172______") OR ' //
    +'(ani LIKE    "02______") OR ' //
    +'(ani LIKE     "2______") OR ' //

    +'(ani LIKE "00172_____") OR ' //
    +'(ani LIKE  "0172_____") OR ' //
    +'(ani LIKE    "02_____") OR ' //

    +'(ani LIKE "00172____") OR ' //
    +'(ani LIKE  "0172____") OR ' //
    +'(ani LIKE    "02____") OR ' //

    +'(ani LIKE "00173______") OR ' //
    +'(ani LIKE  "0173______") OR ' //
    +'(ani LIKE    "03______") OR ' //
    +'(ani LIKE     "3______") OR ' //

    +'(ani LIKE "00173_____") OR ' //
    +'(ani LIKE  "0173_____") OR ' //
    +'(ani LIKE    "03_____") OR ' //

    +'(ani LIKE "00173____") OR ' //
    +'(ani LIKE  "0173____") OR ' //
    +'(ani LIKE    "03____") OR ' //

    +'(ani LIKE "00175______") OR ' //
    +'(ani LIKE  "0175______") OR ' //
    +'(ani LIKE    "05______") OR ' //
    +'(ani LIKE     "5______") OR ' //

    +'(ani LIKE "00178______") OR ' //
    +'(ani LIKE  "0178______") OR ' //
    +'(ani LIKE    "08______") OR ' //
    +'(ani LIKE     "8______") OR ' //

    // МЦС
    +'(ani LIKE "00291______") OR ' //
    +'(ani LIKE  "0291______") OR ' //

    +'(ani LIKE "00293______") OR ' //
    +'(ani LIKE  "0293______") OR ' //

    +'(ani LIKE "00296______") OR ' //
    +'(ani LIKE  "0296______") OR ' //

    +'(ani LIKE "00299______") OR ' //
    +'(ani LIKE  "0299______") OR ' //

    +'(ani LIKE "0044_______") OR ' //
    +'(ani LIKE  "044_______") OR ' //

    // МТС
    +'(ani LIKE "00292______") OR ' //
    +'(ani LIKE  "0292______") OR ' //

    +'(ani LIKE "00295______") OR ' //
    +'(ani LIKE  "0295______") OR ' //

    +'(ani LIKE "00297______") OR ' //
    +'(ani LIKE  "0297______") OR ' //

    +'(ani LIKE "00298______") OR ' //
    +'(ani LIKE  "0298______") OR ' //

    +'(ani LIKE "0033_______") OR ' //
    +'(ani LIKE  "033_______") OR ' //

    // БеСТ
    +'(ani LIKE "00255______") OR ' //
    +'(ani LIKE  "0255______") OR ' //

    +'(ani LIKE "00256______") OR ' //
    +'(ani LIKE  "0256______") OR ' //

    +'(ani LIKE "00257______") OR ' //
    +'(ani LIKE  "0257______") OR ' //

    +'(ani LIKE "00259______") OR ' //
    +'(ani LIKE  "0259______") OR ' //

    // БелСел
    +'(ani LIKE "00294______") OR ' //
    +'(ani LIKE  "0294______")' //

    +')'+ //
    ')' //
    ) //
    );

  USD_TARIF_BEST_109_DAY: double=0.06;
  USD_TARIF_BEST_109_NIGHT: double=0.12;
  USD_TARIF_BEST_188: double=0.009;
  USD_TARIF_BEST_192: double=0.083;
  USD_TARIF_BEST_195: double=0.023;
  USD_TARIF_BEST_175: double=0.031;
  USD_TARIF_BEST_190: double=0.214;
  USD_TARIF_BEST_191: double=0.031;
  USD_TARIF_BEST_193: double=0.144;
  USD_TARIF_BEST_194: double=0.031;
  USD_TARIF_BEST_196: double=0.031;
  USD_TARIF_BEST_197: double=0.031;

  USD_TARIF_BELSEL_109_DAY: double=0.06;
  USD_TARIF_BELSEL_109_NIGHT: double=0.12;
  USD_TARIF_BELSEL_188: double=0.009;
  USD_TARIF_BELSEL_192: double=0.083;
  USD_TARIF_BELSEL_195: double=0.023;
  USD_TARIF_BELSEL_175: double=0.031;
  USD_TARIF_BELSEL_190: double=0.214;
  USD_TARIF_BELSEL_191: double=0.031;
  USD_TARIF_BELSEL_193: double=0.144;
  USD_TARIF_BELSEL_194: double=0.031;
  USD_TARIF_BELSEL_196: double=0.031;
  USD_TARIF_BELSEL_197: double=0.031;

  USD_TARIF_MTS_109_DAY: double=0.059;
  USD_TARIF_MTS_109_NIGHT: double=0.117;
  USD_TARIF_MTS_188: double=0.009;
  USD_TARIF_MTS_192: double=0.083;
  USD_TARIF_MTS_195: double=0.023;
  USD_TARIF_MTS_175: double=0.031;
  USD_TARIF_MTS_190: double=0.215;
  USD_TARIF_MTS_191: double=0.031;
  USD_TARIF_MTS_193: double=0.144;
  USD_TARIF_MTS_194: double=0.031;
  USD_TARIF_MTS_196: double=0.031;
  USD_TARIF_MTS_197: double=0.031;

  USD_TARIF_MCS_109_DAY: double=0.066;
  USD_TARIF_MCS_109_NIGHT: double=0.132;
  USD_TARIF_MCS_188: double=0.009;
  USD_TARIF_MCS_192: double=0.083;
  USD_TARIF_MCS_195: double=0.023;
  USD_TARIF_MCS_175: double=0.031;
  USD_TARIF_MCS_190: double=0.214;
  USD_TARIF_MCS_191: double=0.031;
  USD_TARIF_MCS_193: double=0.144;
  USD_TARIF_MCS_194: double=0.031;
  USD_TARIF_MCS_196: double=0.031;
  USD_TARIF_MCS_197: double=0.031;

implementation

end.
