object LoginForm: TLoginForm
  Left = 0
  Top = 0
  ActiveControl = edbxLogin
  BorderStyle = bsNone
  ClientHeight = 125
  ClientWidth = 208
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 208
    Height = 125
    Align = alClient
    BevelInner = bvRaised
    TabOrder = 0
    object lblLogin: TLabel
      Left = 10
      Top = 10
      Width = 34
      Height = 13
      Caption = #1051#1086#1075#1080#1085':'
      FocusControl = edbxLogin
    end
    object lblPassword: TLabel
      Left = 10
      Top = 50
      Width = 41
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100':'
      FocusControl = edbxPassword
    end
    object imgKey: TImage
      Left = 92
      Top = 92
      Width = 24
      Height = 24
      Picture.Data = {
        055449636F6E0000010001001818000001000800C80600001600000028000000
        1800000030000000010008000000000000000000000000000000000000000000
        0000000000000000FFFFFF0073BEE70052AEE70052A6E7004AA6DE0042A6DE00
        429EDE00399EDE00319EDE003196DE002996DE002196D600188ED6001886CE00
        4A9ECE007BBEEF008CC7EF0084C7EF006BB6E70063B6E70063AEE7005AAEE700
        52A6DE00298ED6001879BD004A8EB50094C7EF00A5CFEF0094CFEF007BBEE700
        BDDFF700D6EFFF00CEE7F7009CCFEF002996D6002186C60010619C0084BEEF00
        3196D6001061A500EFF7FF00F7FFFF001069A50073B6E700DEEFFF00399ED600
        2986C6001869A500C6E7F700A5D7EF00D6E7F7002196DE00218EC600299EDE00
        219EDE009CD7EF004AB6E70039A6DE0042A6E70063BEE70029A6DE0031AEE700
        84CFEF00188EC6004AAEE7007BCFEF0018A6DE00189EDE00188ECE000869A500
        4AA6E700CEEFFF0094D7F70039BEE70018AEE70010A6DE00108ECE00218ED600
        73C7EF0029AEE70021B6E70018B6E70010AEE700088ECE00B5E7F70029B6E700
        10B6E70008AEE70008A6DE000069A500108ED60039B6E70000A6DE00008ECE00
        1086D600E7F7FF0039AEE70021AEE700009EDE000086CE000061A5000886D600
        B5DFF70021A6E7000086C6000879CE001086CE00219ED600009ED600008ED600
        0079BD0000599C004296C6000871BD001079BD001879C6001886C600108EC600
        088EC6000069AD003986AD004286B50008619C000861A5000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000007A7B
        7B7B25252525282B7C46465A6565656570790000007172731974242424757575
        40764D77775464696F787900006A6B454E2323232323236C6C44434C4C59636D
        6E6F700000660D0C010101016709093D3D68624B5353585D63696500005F4E0B
        0160222D0121012D615062515257585863646500005B0B09013305042D010101
        2D5C5651525757585D5E5A00000D0A080101110503311D2D0155565152525758
        59545A00004E08071101011305053B2A014F5051515253534C544600000C0805
        051B012A1347062D012D4848494A4B4B4C4D4600000B060504031D012A130641
        2D0101010101424344454600000A05040303031B012A143A3B3C3D3E3F2A013F
        37402B00000A1716161603171B012A030909363737392A2A09352B0000080316
        161616040533010309093637373738011E352B00000816151515161705330108
        09090B16093416011D353000000814131315160417330107080911011F341601
        1D2F30000007132C131315160431012C08081001320B32011E2F300000052C1E
        02131516161E012D0508090A0A03012A2E2F3000000510111202131415162101
        29110416222A012627242B000003112211260213131413210101010101011108
        2724280000161B1C1D121E0213131314111F2021221406082324250000021011
        1202131314151616160304170506080A18191A00000002030405060708080808
        08090A0B0B0B0C0D0E0F00000000000000000000000000000000000000000000
        00000000FFFFFF00C00003008000010080000100800001008000010080000100
        8000010080000100800001008000010080000100800001008000010080000100
        80000100800001008000010080000100800001008000010080000100C0000300
        FFFFFF00}
      Transparent = True
    end
    object edbxLogin: TEdit
      Left = 9
      Top = 25
      Width = 191
      Height = 21
      Hint = #1042#1074#1077#1076#1080#1090#1077' '#1042#1072#1096' '#1083#1086#1075#1080#1085
      TabOrder = 0
      OnChange = edbxLoginChange
    end
    object edbxPassword: TMaskEdit
      Left = 9
      Top = 65
      Width = 191
      Height = 21
      Hint = #1042#1074#1077#1076#1080#1090#1077' '#1042#1072#1096' '#1087#1072#1088#1086#1083#1100
      PasswordChar = '*'
      TabOrder = 1
      Text = ''
    end
    object btnOk: TButton
      Left = 9
      Top = 92
      Width = 75
      Height = 24
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1086#1087#1099#1090#1082#1080' '#1074#1093#1086#1076#1072' '#1074' '#1089#1080#1089#1090#1077#1084#1091' '#1087#1086#1076' '#1091#1082#1072#1079#1072#1085#1085#1099#1084' '#1080#1084#1077#1085#1077#1084
      Caption = '&Ok'
      Enabled = False
      ModalResult = 1
      TabOrder = 2
    end
    object btnCancel: TButton
      Left = 125
      Top = 92
      Width = 75
      Height = 24
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072
      Cancel = True
      Caption = #1054'&'#1090#1084#1077#1085#1072
      Default = True
      ModalResult = 2
      TabOrder = 3
    end
  end
end
