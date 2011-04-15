unit OverseerConsts;

interface

uses
  OverseerTypes;

const
  STATUSBAR_STATE_PANEL_NUMBER: integer=0;
  STATUSBAR_PROGRESS_PANEL_NUMBER: integer=1;
  STATUSBAR_HINT_PANEL_NUMBER: integer=2;
  ICON_ERROR=15; // ������ ������ � ������ ImageList1
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

  WMCD_MODALLOG: integer=221; // ������������� ���� ������ ����������� ������ ����, ����������� ����� ��������� WM_COPYDATA �� ��������� ����
  WMCD_THREADLOG: integer=222; // ������������� ���� ������ ����������� ������ ����, ����������� ����� ��������� WM_COPYDATA �� ��������� ������

  saQuarters: array [1..4] of string=('I', 'II', 'III', 'IV');
  saMonths1: array [1..12] of string=('������', '�������', '����', '������', '���', '����', '����', '������', '��������', '�������', '������', '�������');
  saMonths2: array [1..12] of string=('������', '�������', '�����', '������', '���', '����', '����', '�������', '��������', '�������', '������', '�������');

  aRegions_Count=6;
  aRegions: array [0..aRegions_Count-1] of trRegion=( //
    (sPrefix: '015'; sName: '����������� �������'),
    (sPrefix: '016'; sName: '��������� �������'),
    (sPrefix: '017'; sName: '������� �������'),
    (sPrefix: '021'; sName: '��������� �������'),
    (sPrefix: '022'; sName: '���������� �������'),
    (sPrefix: '023'; sName: '���������� �������')
  ); //

  aServices_Count=26;
  aServices: array [0..aServices_Count-1] of trService=( //
    (sNumber: '109'; sName: '������� �������'; bAutoService: False; bUsedInReport_SIC_03: True), //
    (sNumber: '130'; sName: '���������� ����� ������������ ��������'; bAutoService: False; bUsedInReport_SIC_03: False), //
    (sNumber: '175'; sName: '������ �������-������������� ���������'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '188'; sName: '������ ������� �������'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '190'; sName: '�������������'; bAutoService: False; bUsedInReport_SIC_03: True), //
    (sNumber: '191'; sName: '���������'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '192'; sName: '��������'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '193'; sName: '����� � �����������'; bAutoService: False; bUsedInReport_SIC_03: True), //
    (sNumber: '194'; sName: '��������'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '195'; sName: '������� ������'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '196'; sName: '������ �� ��������'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '197'; sName: '�������'; bAutoService: True; bUsedInReport_SIC_03: True), //
    (sNumber: '199'; sName: '���������� �������'; bAutoService: False; bUsedInReport_SIC_03: False), //
    (sNumber: '2003498'; sName: 'Back Office'; bAutoService: False; bUsedInReport_SIC_03: False), //
    (sNumber: '9910911'; sName: '��������, ������� �������'; bAutoService: False; bUsedInReport_SIC_03: False), //
    (sNumber: '99175'; sName: '��������, ������ �������-������������� ���������'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '99188'; sName: '��������, ������ ������� �������'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '99190'; sName: '��������, �������������'; bAutoService: False; bUsedInReport_SIC_03: False), //
    (sNumber: '99191'; sName: '��������, ���������'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '99192'; sName: '��������, ��������'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '99193'; sName: '��������, ����� � �����������'; bAutoService: False; bUsedInReport_SIC_03: False), //
    (sNumber: '99194'; sName: '��������, ��������'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '99195'; sName: '��������, ������� ������'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '99196'; sName: '��������, ������ ��� �����'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '99197'; sName: '��������, �������'; bAutoService: True; bUsedInReport_SIC_03: False), //
    (sNumber: '9919911'; sName: '��������, ���������� �������'; bAutoService: False; bUsedInReport_SIC_03: False) //
    ); //

  aNets_Count=7;
  aNets: array [0..aNets_Count-1] of trNet=( //
    (sName: ''; sHTMLMobileNetName: ''; sHTMLAbonentsName: ''; sQuery: ''), // ��� ���� ���������
    (sName: '����'; sHTMLMobileNetName: ''; sHTMLAbonentsName: '&nbsp;���������&nbsp;&laquo;����&raquo;'; sQuery: //
    '(' //
    // ��������� ��������, ������������ �� ����� "2"
    // ���������� ����� ������
    +'(ani LIKE "00172______") OR ' //
    +'(ani LIKE  "0172______") OR ' //
    +'(ani LIKE    "02______") OR ' //
    +'(ani LIKE     "2______") OR ' //
    // �������� ���� ����� � �����
    +'(ani LIKE "00172_____") OR ' //
    +'(ani LIKE  "0172_____") OR ' //
    +'(ani LIKE    "02_____") OR ' //
    // �������� ��� ����� � �����
    +'(ani LIKE "00172____") OR ' //
    +'(ani LIKE  "0172____") OR ' //
    +'(ani LIKE    "02____") OR ' //

    // ��������� ��������, ������������ �� ����� "3"
    // ���������� ����� ������
    +'(ani LIKE "00173______") OR ' //
    +'(ani LIKE  "0173______") OR ' //
    +'(ani LIKE    "03______") OR ' //
    +'(ani LIKE     "3______") OR ' //
    // �������� ���� ����� � �����
    +'(ani LIKE "00173_____") OR ' //
    +'(ani LIKE  "0173_____") OR ' //
    +'(ani LIKE    "03_____") OR ' //
    // �������� ��� ����� � �����
    +'(ani LIKE "00173____") OR ' //
    +'(ani LIKE  "0173____") OR ' //
    +'(ani LIKE    "03____") OR ' //

    // ����������� ��������, ������������ �� ����� "5"
    +'(ani LIKE "00175______") OR ' //
    +'(ani LIKE  "0175______") OR ' //
    +'(ani LIKE    "05______") OR ' //
    +'(ani LIKE     "5______") OR ' //

    // ���������, ������������ �� ����� "8"
    +'(ani LIKE "00178______") OR ' //
    +'(ani LIKE  "0178______") OR ' //
    +'(ani LIKE    "08______") OR ' //
    +'(ani LIKE     "8______")'+ //
    ')' //
    ), //
    (sName: '���'; sHTMLMobileNetName: '��&nbsp;&laquo;���&raquo;'; sHTMLAbonentsName: '&nbsp;���������&nbsp;����&nbsp;��&nbsp;&laquo;���&raquo;'; sQuery: //
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
    (sName: '���'; sHTMLMobileNetName: '����&nbsp;&laquo;���&raquo;'; sHTMLAbonentsName: '&nbsp;���������&nbsp;����&nbsp;����&nbsp;&laquo;���&raquo;'; sQuery: //
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
    (sName: '����'; sHTMLMobileNetName: '���&nbsp;&laquo;����&raquo;'; sHTMLAbonentsName: '&nbsp;���������&nbsp;����&nbsp;���&nbsp;&laquo;����&raquo;'; sQuery: //
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
    (sName: '������'; sHTMLMobileNetName: '��&nbsp;&laquo;������&raquo;'; sHTMLAbonentsName: '&nbsp;���������&nbsp;����&nbsp;��&nbsp;&laquo;������&raquo;'; sQuery: //
    '(' //
    +'(ani LIKE "00294______") OR ' //
    +'(ani LIKE  "0294______")'+ //
    ')' //
    ), //
    (sName: '������'; sHTMLMobileNetName: ''; sHTMLAbonentsName: '&nbsp;������&nbsp;���������'; sQuery: //
    '(!' // ������� ������ ��� ���������, ������� �� �������� � ��������� ���� ������ ;)
    +'(' //

    // ��������� ��������
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

    // ���
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

    // ���
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

    // ����
    +'(ani LIKE "00255______") OR ' //
    +'(ani LIKE  "0255______") OR ' //

    +'(ani LIKE "00256______") OR ' //
    +'(ani LIKE  "0256______") OR ' //

    +'(ani LIKE "00257______") OR ' //
    +'(ani LIKE  "0257______") OR ' //

    +'(ani LIKE "00259______") OR ' //
    +'(ani LIKE  "0259______") OR ' //

    // ������
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
