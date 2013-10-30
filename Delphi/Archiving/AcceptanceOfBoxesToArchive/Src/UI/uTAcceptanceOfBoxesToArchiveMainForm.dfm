object AcceptanceOfBoxesToArchiveMainForm: TAcceptanceOfBoxesToArchiveMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  BorderWidth = 6
  Caption = #1055#1088#1080#1105#1084#1082#1072' '#1082#1086#1088#1086#1073#1086#1074' '#1074' '#1072#1088#1093#1080#1074
  ClientHeight = 331
  ClientWidth = 422
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 300
    Width = 422
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    DesignSize = (
      422
      31)
    object btnClose: TButton
      Left = 347
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actClose
      Anchors = [akTop, akRight]
      Cancel = True
      TabOrder = 0
    end
  end
  object gbBarcode: TGroupBox
    Left = 0
    Top = 136
    Width = 422
    Height = 54
    Align = alTop
    Caption = ' '#1064#1090#1088#1080#1093'-'#1082#1086#1076' '
    TabOrder = 0
    DesignSize = (
      422
      54)
    object edBarcode: TEdit
      Left = 8
      Top = 24
      Width = 405
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnKeyDown = edBarcodeKeyDown
    end
  end
  object gbHint: TGroupBox
    Left = 0
    Top = 190
    Width = 422
    Height = 110
    Align = alClient
    Caption = ' '#1057#1086#1086#1073#1097#1077#1085#1080#1077' '
    TabOrder = 1
    object lblHint: TLabel
      Left = 8
      Top = 16
      Width = 405
      Height = 86
      Align = alCustom
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 395
      ExplicitHeight = 82
    end
  end
  object gbLastBox: TGroupBox
    Left = 0
    Top = 0
    Width = 422
    Height = 136
    Align = alTop
    Caption = ' '#1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1087#1086#1089#1083#1077#1076#1085#1077#1084' '#1087#1088#1080#1085#1103#1090#1086#1084' '#1082#1086#1088#1086#1073#1077' '
    TabOrder = 3
  end
  object SQLConnection: TSQLConnection
    ConnectionName = 'MSSQLConnection'
    DriverName = 'MSSQL'
    LoginPrompt = False
    Params.Strings = (
      'SchemaOverride=sa.dbo'
      'DriverName=MSSQL'
      'HostName=MOSTRA-822'
      'DataBase=RTL'
      'User_Name=user'
      'Password=password'
      'BlobSize=-1'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'OS Authentication=True'
      'Prepare SQL=False'
      'ConnectTimeout=60'
      'Mars_Connection=False')
    Left = 176
    Top = 32
  end
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLNCLI10.1;Integrated Security=SSPI;Persist Security I' +
      'nfo=False;User ID="";Initial Catalog=RTL;Data Source=MOSTRA-822;' +
      'Initial File Name="";Server SPN=""'
    Provider = 'SQLNCLI10.1'
    Left = 104
    Top = 32
  end
  object ActionList: TActionList
    Images = ImageList
    Left = 48
    Top = 32
    object actPrintSticker: TAction
      Hint = #1055#1077#1095#1072#1090#1100' '#1089#1090#1080#1082#1077#1088#1072' '#1076#1083#1103' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1082#1086#1088#1086#1073#1072
      ImageIndex = 0
    end
    object actDeleteLastDocument: TAction
      Hint = #1059#1076#1072#1083#1077#1085#1080#1077' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1080#1079' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1082#1086#1088#1086#1073#1072
      ImageIndex = 5
    end
    object actClose: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      OnExecute = actCloseExecute
    end
  end
  object ImageList: TImageList
    Left = 240
    Top = 32
    Bitmap = {
      494C01010B008800F80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F6F6F609ECECEC13E9E9E916E9E9E916F0F0F00FFCFCFC030000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFE01F5F5F50AEBEBEB14E9E9E916E9E9E916EFEFEF10FBFBFB040000
      0000000000000000000000000000000000000000000000000000FEFEFE01FBFB
      FB04FAFAFA05FCFCFC03FCFCFC03FCFCFC030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F2F2
      F20DCACACA3EB8B7B7C7BEBABAFFB9B5B5FFB1AEAEEAA9A8A893BEBEBE41E2E2
      E21DFCFCFC03000000000000000000000000000000000000000000000000F1F1
      F10EC5C5C54DBBB9B9D2BEBABAFFB9B5B5FFB3AEAEF5A9A7A79FBBBBBB44DDDD
      DD22FBFBFB0400000000000000000000000000000000FCFCFC03F8F8F807F9F9
      F906BFC8BF400B9610FE558D55AAE0E2E01F00000000FEFEFE01000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E6E6E619DBD9
      D9FF5754A0FF12129EFF1313A5FF1414ACFF1616B3FF1F1FB7FFB2ADB8FFA7A5
      A5ABCBCBCB34F9F9F90600000000000000000000000000000000E6E6E619D5D2
      D2FFB47450FFB45A26FFB45A26FFB96226FFC27125FFCB7F24FFCEB89EFFA7A5
      A5B5C8C8C837F9F9F906000000000000000000000000E6E8E619CBCBCB34B0B2
      B04F23B62FFF1BB227FF08AC0FFFA5B0A55ACECECE31ECEEEC13000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E4E4E424C9C6CEFF1010
      92FF111199FF1212A0FF1414A7FF1515AEFF1616B5FF1717BCFF1919C3FF4746
      CAFFACA8A8E0CBCBCB34FCFCFC030000000000000000E4E4E424CEBAB1FFB45A
      26FFB45A26FFB45A26FFB45A26FFBC6725FFC67724FFCF8624FFD79423FFE0AA
      3BFFADA8A8E0C8C8C837FBFBFB0400000000D7D9D728D2D2D22DD2D2D22D2DCB
      3DFF2ACC3BFF0DC016FF0ABF13FF049307FFDEDEDE21E1E1E11EE3E3E31CF6F7
      F609000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAFAFA05E7E6E6FF0F0F8BFF1010
      93FF11119AFF1212A1FF1414A8FF1515B0FF1616B7FF1818BEFF1919C5FF1A1A
      CCFF4A4AD3FFA8A7A7ABE2E2E21D00000000F9F9F906DED6D3FFB45A26FFB45A
      26FFB45A26FFB45A26FFB45B26FFBD6A25FFAE6B1FFFD18A23FFDA9923FFE2A6
      22FFEBBA3CFFA9A6A6B5DDDDDD2200000000000000000000000033D044FF35CF
      48FF18C324FF0ABE13FF0ABE13FF0BC314FF358835CAECECEC13EDEDED12EEEE
      EE11EEEEEE11FBFBFB0400000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E2E1E1AA0D0D84FF0E0E8BFF1C1C
      96FFDFDFDFFFB4B4CFFF1414A8FF1515AFFF2121B7FFDFDFDFFFB6B6D6FF1A1A
      CBFF1B1BD0FFB8B4BFFFBEBEBE41FCFCFC03D8D8D8B8B45A26FFB45A26FFB45A
      26FFB45A26FFB45A26FFB45A26FFBD6925FFD4D4D4FF9C671AFFD99723FFE1A4
      22FFE6AD21FFD7C6A4FFBBBBBB44FBFBFB040000000030CE40FF40D455FF24C8
      33FF0EC017FF0EC317FF0ABE13FF0ABE13FF09B911FFEDF3ED12FDFDFD02F6F6
      F609F6F6F609F5F5F50AF4F4F40BFBFBFB040000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CFCCCCFF3D3D9BFF0E0E8AFFB4B4
      CCFFCCCCCCFFCCCCCCFFB5B5D0FF2020B0FFDFDFDFFFCCCCCCFFDFDFDFFF1919
      C6FF1A1AC9FF2222C6FFAAA9A993F0F0F00FD0C7C4FFC47D54FFB45A26FFB45A
      26FFB45A26FFB45A26FFB45A26FF9A531EFFCACACAFFCACACAFF986C26FFDB9B
      22FFDFA122FFDE9F22FFAAA9A99FEFEFEF102FD03EFF6ADF7DFF55D663FF43CF
      4BFF289C2CDFABCDAB540AC214FF0ABE13FF12C21DFF11A818FE000000000000
      0000FCFCFC03FBFBFB04FAFAFA05FCFCFC030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008280ACFF40409CFF37379DFF0F0F
      8FFFB4B4CDFFCCCCCCFFCCCCCCFFDFDFDFFFCCCCCCFFDFDFDFFF2222BDFF1818
      C0FF1818C2FF1818C2FFB8B4B4EAE9E9E916C19781FFC47D54FFC1764BFFB45A
      26FFB45A26FFC4B2A8FFC2C2C2FFC2C2C2FFC1C1C1FFC1C1C1FFC0C0C0FF9975
      3EFFD69323FFD69223FFBCB8B8FFE9E9E91696F0A8FF85E391FF7CDF84FF2A9B
      2DE10000000000000000159F1AEF0ABE13FF27CA37FF4FDC69FF459945BA0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006160A1FF3F3F9AFF4040A0FF3939
      A1FF101094FFB4B4CEFFCCCCCCFFCCCCCCFFDFDFDFFF2020B4FF1616B6FF1717
      B9FF1717BBFF1717BBFFC2BFBFFFE9E9E916C18664FFC47D54FFC47D54FFC279
      4EFFBEBEBEFFBABABAFFBABABAFFB9B9B9FFB9B9B9FFB9B9B9FFB8B8B8FFD1B5
      92FFCD8324FFCD8324FFC1BDBDFFE9E9E91632AA3DF2B2F2B8FF2D9D30E30000
      000000000000000000000000000019C626FF3DD353FF45D65DFF21C32EFFFDFD
      FD02000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007574A7FF3F3F99FF40409DFF3E3E
      A1FF4343A7FFDFDFDFFFCCCCCCFFCCCCCCFFCCCCCCFFB5B5D1FF1515B0FF1616
      B2FF1616B4FF1616B3FFC8C5C5FFECECEC13C58C6BFFC47D54FFC47D54FFCCB1
      A1FFB3B3B3FFB7B7B7FFC69477FFB45A26FFB1B1B1FFB1B1B1FFC89368FFC170
      25FFC37325FFC37325FFC8C5C5FFEBEBEB140000000000000000000000000000
      0000000000000000000000000000C1DAC13E51DF6BFF31CE43FF1FC529FF10A2
      14FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A8A5B7FF3F3F96FF3F3F9BFF4646
      A1FFDFDFDFFFCCCCCCFFDFDFDFFFB9B9D1FFCCCCCCFFCCCCCCFFB5B5D1FF1414
      ABFF1515ADFF1414ACFFBFBEBEC7F6F6F609CCB3A7FFC47D54FFC47D54FFACAC
      ACFFCAAA97FFC07549FFBF7145FFBD6E40FFAAAAAAFFBE764DFFB55B26FFB760
      26FFB96226FFB96226FFC2C2C2D2F5F5F50A0000000000000000000000000000
      00000000000000000000000000000000000036A53FE030CB3DFF35CB3FFF5ADB
      6CFF47A147B80000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CAC6C6FF3F3F95FF3F3F98FFBCBC
      CEFFCCCCCCFFDFDFDFFF3C3CA5FF2E2EA4FFB9B9D0FFCCCCCCFFDFDFDFFF1E1E
      A8FF1A1AA8FF5E5CADFFCACACA3E00000000C8C4C4FFC47D54FFC47D54FFBBA1
      92FFC2784DFFC07549FFBF7145FFBD6E40FFBC6B3CFFBA6838FFB96434FFB862
      30FFB65F2CFFB77D5DFFC7C7C74BFEFEFE010000000000000000000000000000
      0000000000000000000000000000000000000000000034C93CFF58D765FF74E2
      88FF53D75FFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F7219E9DBCFF3F3F95FF3D3D
      98FFBCBCCEFF3E3E9FFF31319EFF2D2D9FFF2828A0FFB8B8CFFF2B2BA5FF1C1C
      A2FF1919A1FFEAE9E9FFF2F2F20D00000000FDFDFD21E1C8BAFFC47D54FFC37B
      51FFC2784DFFC07549FFBF7145FFBD6E40FFBC6B3CFFBA6838FFB96434FFB862
      30FFB65F2CFFE6E5E5FFF2F2F20D000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C1DAC13E7EE78FFF7CE2
      8BFF61D76AFF1CAE1EFE00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CFCDCDD08E8EBCFF3C3C
      94FF383896FF343497FF303099FF2B2B9AFF27279BFF24249BFF1F1F9BFF1B1B
      9BFFCCCAD2FFE6E6E619000000000000000000000000D9D6D6C0D7A98EFFC37B
      51FFC2784DFFC07549FFBF7145FFBD6E40FFBC6B3CFFBA6838FFB96434FFB862
      30FFDCD4D1FFE6E6E61900000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005CAC61DF7DDF
      87FF72DB78FF8BE698FF64AF699E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CFCDCDD0A3A2
      BDFF373791FF333393FF2F2F94FF2A2A94FF272795FF232395FF252598FFDAD8
      D8FFE4E4E4240000000000000000000000000000000000000000D1CECED0DECA
      BFFFC2784DFFC07549FFBF7145FFBD6E40FFBC6B3CFFBA6838FFBA6636FFD6D3
      D3FFECECEC230000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A2E4
      A6FF94E59CFFA0EBAEFF89DF98FE000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F721C7C3C3FFAEAAB8FF8886B1FF6F6EABFF8986B0FFC5C1C1FFD5D5D5AAFAFA
      FA0500000000000000000000000000000000000000000000000000000000F7F7
      F731BCB7B7FFD0C6C2FFCDA28AFFC79579FFC5A28FFFC9C4C4FFE5E5E5A9FAFA
      FA05000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEEA
      DE21D2FDDAFFCBFBD5FF9FC59F68000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FEFEFE01F5F5F50AEBEBEB14E9E9E916E9E9E916EFEFEF10FBFBFB040000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000044CC720065D0890087D09D0082CB98005EC8800041C96E000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F6F6F609ECECEC13E9E9E916E9E9E916F0F0F00FFCFCFC030000
      000000000000000000000000000000000000000000000000000000000000F1F1
      F10EC5C5C54DBBB9B9D2BEBABAFFB9B5B5FFB3AEAEF5A9A7A79FBBBBBB44DDDD
      DD22FBFBFB0400000000000000000000000000000000000000006E6E6E006E6E
      6E00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000044CC
      720092DDAB00E3EAE400EAE6E600E4DFDE00DCD6D500D3CBCA00BFC0B80079C0
      8D0041C96E00000000000000000000000000000000000000000000000000F2F2
      F20DCACACA3EB8B7B7C7BEBABAFFB9B5B5FFB1AEAEEAA9A8A893BEBEBE41E2E2
      E21DFCFCFC030000000000000000000000000000000000000000E6E6E619D5D2
      D2FFB47450FFB45A26FFB45A26FFB96226FFC27125FFCB7F24FFCEB89EFFA7A5
      A5B5C8C8C837F9F9F906000000000000000000000000795FEA002900DF003F28
      A600656565000000000000000000000000000000000000000000000000000000
      00006250B2002E07D8000000000000000000000000000000000044CC7200D1F5
      DC00F8F6F6009AC699004E9F4D003D953B003D953B004898460087AF8100CDC5
      C300A8BCA8003ECE6E0000000000000000000000000000000000E6E6E619DBD9
      D9FF5754A0FF12129EFF1313A5FF1414ACFF1616B3FF1F1FB7FFB2ADB8FFA7A5
      A5ABCBCBCB34F9F9F906000000000000000000000000E4E4E424CEBAB1FFB45A
      26FFB45A26FFB45A26FFB15925FF8D4D1CFFA1611DFFCF8624FFD79423FFE0AA
      3BFFADA8A8E0C8C8C837FBFBFB040000000000000000795FEA002900DF00300A
      DB00534E6A006565650000000000000000000000000000000000000000004629
      C3002900DF005A46B60000000000000000000000000046D07500D7F3E100EDF5
      ED0047A34C000A8511000A840F000A840F00057C0500057C0500057C05002D8C
      2B00C5C5BC00ADC2AE0041C96E000000000000000000E4E4E424C9C6CEFF1010
      92FF111199FF1212A0FF1414A7FF1515AEFF1616B5FF1717BCFF1919C3FF4746
      CAFFACA8A8E0CBCBCB34FCFCFC0300000000F9F9F906DED6D3FFB45A26FFB45A
      26FFB45A26FFB45A26FFDADADAFFCDCDCDFFC3B19DFFD18A23FFDA9923FFE2A6
      22FFEBBA3CFFA9A6A6B5DDDDDD22000000000000000000000000795FEA002900
      DF003D1CD2005F5F5F00000000000000000000000000000000003A18CD002E07
      D8005A46B6000000000000000000000000000000000098E4B200FEFEFE004DAD
      5800139423001394230013942300B4DAB600B4DAB6000A840F00057C0500057C
      05002D8C2B00D1D5CE0082CA970000000000FAFAFA05E7E6E6FF0F0F8BFF1010
      93FF11119AFF1212A1FF1414A8FF1515B0FF1616B7FF1818BEFF1919C5FF1A1A
      CCFF4A4AD3FFA8A7A7ABE2E2E21D00000000D8D8D8B8B45A26FFB45A26FFB45A
      26FFB45A26FFB45A26FFC9C9C9FFBDBDBDFFC6AC90FFD08923FFD99723FFE1A4
      22FFE6AD21FFD7C6A4FFBBBBBB44FBFBFB040000000000000000000000007A60
      EB002900DF005238C3006464640000000000000000003A18CD002E07D8005A46
      B6000000000000000000000000000000000046D07500F2FBF400A8DAB1001CA4
      36001CA436001CA436001CA43600D8EFDC00D8EFDC000F8E1B000A851100057C
      0500057C050081B27D00D1D5CE0044CC7200E2E1E1AA0D0D84FF0E0E8BFF1010
      92FF11119AFF1212A1FF1414A8FF1515AFFF1616B6FF1818BDFF1919C4FF1A1A
      CBFF1B1BD0FFB8B4BFFFBEBEBE41FCFCFC03D0C7C4FFC47D54FFB45A26FFB45A
      26FFB45A26FFB45A26FFB45A26FF98521EFF9F5F1EFFCD8324FFD59023FFDB9B
      22FFDFA122FFDE9F22FFAAA9A99FEFEFEF100000000000000000000000000000
      00007A60EB002900DF005137C30053505E003312C7002C06D7005A46B6000000
      0000000000000000000000000000000000006DDA9200FEFEFE0066C57A0023AF
      440025B44A0025B44A0025B44A00D8EFDC00D8EFDC00179B2C0011901E000A85
      1100057C050030902F00E6E2E10065D08900CFCCCCFF3D3D9BFF0E0E8AFF1010
      91FF111198FF1212A0FF1313A7FF1515AEFF1616B4FF1717BBFF1818C1FF1919
      C6FF1A1AC9FF2222C6FFAAA9A993F0F0F00FC19781FFC47D54FFC1764BFFB45A
      26FFB45A26FFB45A26FFE4CDC0FFE5E5E5FFAC7D55FFC87A24FFCE8624FFD48E
      23FFD69323FFD69223FFBCB8B8FFE9E9E9160000000000000000000000000000
      000000000000795FEA002900DF002C06D7002B05D6006A628C00000000000000
      00000000000000000000000000000000000098E4B200FEFEFE005DC97A002ABC
      5500BEEBCC00D9F4E200D9F4E200F2FBF400F2FBF400D8EFDC00D8EFDC00B4DA
      B6000A840F00057C0500EEEBEB008FD9A7008280ACFF40409CFF37379DFF0F0F
      8FFF111196FF12129DFF1313A4FF1414ABFF1515B1FF1616B7FF1717BCFF1818
      C0FF1818C2FF1818C2FFB8B4B4EAE9E9E916C18664FFC47D54FFC47D54FFC279
      4EFFB45A26FFB45A26FFCC9473FFCFCFCFFFC5C5C5FF90531CFFC47723FFCB80
      24FFCD8324FFCD8324FFC1BDBDFFE9E9E9160000000000000000000000000000
      000000000000000000002F08D9002900DF00472BC4006A628C00000000000000
      00000000000000000000000000000000000098E4B200FEFEFE0062D2850037CB
      6800C8F1D500E6F9EB00E0F7E700F6FDF800F2FBF400D9F4E200D8EFDC00B6DD
      BA000A851100057C0500F8F6F6008FD9A7006160A1FF3F3F9AFF4040A0FFADAD
      ADFFA7A7A7FFA3A3A3FFA5A5A5FFAAAAAAFFB1B1B1FFB9B9B9FFC2C2C2FFE4E4
      E4FF1717BBFF1717BBFFC2BFBFFFE9E9E916C58C6BFFC47D54FFC47D54FFC37B
      51FFC2784DFFBA6738FFB45A26FFCBBAB0FFB7B7B7FFBCBCBCFF955A2AFFC170
      25FFC37325FFC37325FFC8C5C5FFEBEBEB140000000000000000000000000000
      0000000000003A18CD002E07D8005A46B600360FE000593DD6006A628C000000
      0000000000000000000000000000000000006DDA9200FEFEFE0078DC990057D7
      7F0076E2940076E2940065DC8900E6F9EB00D9F4E20025B44A001FA93C00179B
      2C000F8E1B0034953500F8F6F6006DDA92007574A7FF3F3F99FF40409DFFE7E7
      E7FFE1E1E1FFDBDBDBFFD7D7D7FFD3D3D3FFD1D1D1FFD2D2D2FFD4D4D4FFECEC
      F5FF1616B4FF1616B3FFC8C5C5FFECECEC13CCB3A7FFC47D54FFC47D54FFC37B
      51FFC2784DFFC07549FFBF7145FFBD6E40FFD1C7C0FFCBCBCBFFD8D3D1FFB760
      26FFB96226FFB96226FFC2C2C2D2F5F5F50A0000000000000000000000000000
      00003A18CD002900DF005A46B6000000000000000000431FE2004A28DD006A62
      8C000000000000000000000000000000000046D07500F2FBF400BEF0CE0076E2
      940096E9AC00A6F2B40086E79E00E6F9EB00D9F4E2002ABC550023AF4400189D
      2E000F8E1B0082BF8400EEF7F10044CC7200A8A5B7FF3F3F96FF3F3F9BFF3D3D
      9EFF3A3AA1FF3636A4FF3333A7FF2D2DA8FF1F1FA7FF1616A7FF1414A9FF1414
      ABFF1515ADFF1414ACFFBFBEBEC7F6F6F609C8C4C4FFC47D54FFC47D54FFC37B
      51FFC2784DFFDBDBDBFFA4755AFF935632FFD3CBC7FFDBDBDBFFE9E9E9FFB862
      30FFB65F2CFFB77D5DFFC7C7C74BFEFEFE010000000000000000000000003917
      CC002900DF005A46B600000000000000000000000000000000005F40E700350E
      DF006A628C000000000000000000000000000000000098E4B200FEFEFE0096E9
      AC00A6F2B400B7F8BF0091EBA600D1F5DC00C2F2CF002ABC550023AF4400189D
      2E002E9D3900EDF5ED0098E4B20000000000CAC6C6FF3F3F95FF3F3F98FF3D3D
      9BFF39399EFF3636A0FF3232A2FF2E2EA4FF2929A6FF2626A7FF2222A8FF1E1E
      A8FF1A1AA8FF5E5CADFFCACACA3E00000000FDFDFD21E1C8BAFFC47D54FFC37B
      51FFC2784DFFDADADAFFD5D5D5FFDCDCDCFFE4E4E4FFECECECFFC6A491FFB862
      30FFB65F2CFFE6E5E5FFF2F2F20D0000000000000000000000003917CC002900
      DF005A46B6000000000000000000000000000000000000000000000000005F40
      E7002900DF000000000000000000000000000000000046D07500D9F4E200F6FD
      F800A4EEB50096E9AC007DE4980057D77F0035C966002ABC55001FA93C0035A9
      4800D2EAD500D9F4E20046D0750000000000F7F7F7219E9DBCFF3F3F95FF3D3D
      98FF39399AFF35359CFF31319EFF2D2D9FFF2828A0FF2525A1FF2020A2FF1C1C
      A2FF1919A1FFEAE9E9FFF2F2F20D0000000000000000D9D6D6C0D7A98EFFC37B
      51FFC2784DFFC47E54FFE6DDD7FFF1F1F1FFF7F7F7FFD7A98FFFB96434FFB862
      30FFDCD4D1FFE6E6E619000000000000000000000000411DE0002900DF004629
      C300000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000044CC7200D9F4
      E200FEFEFE00C2F2CF007DE498003ECE6E002EC25C0050C46E008FD49E00F2FB
      F400D9F4E20044CC7200000000000000000000000000CFCDCDD08E8EBCFF3C3C
      94FF383896FF343497FF303099FF2B2B9AFF27279BFF24249BFF1F1F9BFF1B1B
      9BFFCCCAD2FFE6E6E61900000000000000000000000000000000D1CECED0DECA
      BFFFC2784DFFC07549FFBF7145FFBD6E40FFBC6B3CFFBA6838FFBA6636FFD6D3
      D3FFECECEC23000000000000000000000000000000003610E1004D2CE1000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000046D0
      750098E4B200F2FBF400FEFEFE00FEFEFE00FEFEFE00FEFEFE00F2FBF40098E4
      B20046D075000000000000000000000000000000000000000000CFCDCDD0A3A2
      BDFF373791FF333393FF2F2F94FF2A2A94FF272795FF232395FF252598FFDAD8
      D8FFE4E4E424000000000000000000000000000000000000000000000000F7F7
      F731BCB7B7FFD0C6C2FFCDA28AFFC79579FFC5A28FFFC9C4C4FFE5E5E5A9FAFA
      FA05000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000046D075006DDA920098E4B20098E4B2006DDA920046D075000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F721C7C3C3FFAEAAB8FF8886B1FF6F6EABFF8986B0FFC5C1C1FFD5D5D5AAFAFA
      FA05000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008E8E8E007676
      76007E7E7E009797970092929200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000868686008686860000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000069696900375E8C002869
      8A002C4F5C0047474700585858006E6E6E007E7E7E0092929200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B2B2B200C0C0C00077777700000000000000000086868600777777000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000003760700037607000376070003760700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009191910028698A004574C4003D83
      DD003A8AE7002593E4002878AD002B5C7D002C4F5C00474747005F5F5F006E6E
      6E00838383000000000000000000000000000000000000000000C0C0C000C0C0
      C0007777770077777700CCCCCC00A4A0A000A4A0A00000000000000000008686
      8600777777000000000000000000000000000000000000000000000000000000
      000000000000000000000376070018A430001AB3330003760700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009191910028698A004279CD00407D
      D3003D83DD003B88E500388DED003693F5002D99F8002593E4002878AD001D60
      7600374A59006464640000000000000000000000000086868600777777007777
      7700CCCCCC00CCCCCC00C0C0C000A4A0A0009999990096969600868686000000
      0000000000007777770000000000000000000000000000000000000000000000
      00000000000000000000037607001DA93A0020B9400003760700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009191910028698A00417BCF004279
      CD00407DD3003D83DD003B88E500388DED003693F5003399FF003399FF003399
      FF002299EE004747470000000000000000008686860077777700D7D7D700CCCC
      CC00CCCCCC00C0C0C000C0C0C000A4A0A0009999990096969600969696008686
      8600868686000000000000000000000000000000000000000000000000000000
      000000000000000000000376070021AE430026BF4D0003760700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009191910028698A00407DD3004572
      C2004279CD00407DD3003D83DD003B88E500388DED003693F5003399FF003399
      FF002699F20047474700000000000000000086868600F8F8F800CCCCCC00CCCC
      CC00C0C0C000C0C0C000F8F8F80099999900A4A0A00096969600868686008686
      8600777777008686860077777700000000000000000000000000037607000376
      070003760700037607000376070029B953002EC75D0003760700037607000376
      0700037607000376070000000000000000000000000000000000000094000000
      9400000094000000940000009400000094000000940000009400000094000000
      94000000940000009400000000000000000091919100296D9C00407ED400486C
      B8004572C2004279CD00407DD3003D83DD003A8AE700388DED003693F5003399
      FF002699F20047474700000000000000000086868600F8F8F800C0C0C000C0C0
      C000F8F8F800F8F8F800CCCCCC00CCCCCC00CCCCCC0096969600969696008686
      8600868686007777770077777700000000000000000000000000037607004DE5
      800048E17B0040D973003BD46E003BD46E0032CB64002DBF590021AD42001DA9
      3A0016A22B000376070000000000000000000000000000000000000094000000
      FF000000FF000000FF000000FF000000FF000000E1000000E1000000BF000000
      BF000000BF000000940000000000000000009191910034669800375E8C003C55
      7E003D4D7100466EBC004179CD00407DD3003D82DB003B88E500388EEE003693
      F5002699F20045454500000000000000000086868600F8F8F800F8F8F800F8F8
      F800D7D7D700D7D7D7000000FF003300CC00CCCCCC00CCCCCC00C0C0C0008686
      86008686860086868600777777000000000000000000000000000376070055ED
      88004DE5800048E17B0040D973003BD46E0032CB64002EC75D0026BF4D001FB8
      3D001AB333000376070000000000000000000000000000000000000094000000
      FF000000FF000000FF000000FF000000FF000000FF000000E1000000E1000000
      BF000000BF00000094000000000000000000919191003970B1003D4D71004A67
      B1004B65AD0042588B0042588B0042588B003E66A2003F69A8003981D3003890
      F0002994EB0045454500000000000000000086868600F8F8F800DDDDDD00DDDD
      DD0000FF000000996600CCCCCC00CCCCCC00D7D7D70077777700868686000000
      0000C0C0C00077777700777777000000000000000000000000000C7812000376
      070003760700037607000370060040D9730038D16B0003700600037006000370
      0600037006000370060000000000000000000000000000000000000094000000
      9400000094000000940000009400000094000000940000009400000094000000
      94000000940000009400000000000000000091919100446BB3003D4D71004475
      C7004475C7004475C7004376C70081DBF10088EDFF0057A5EB003E66A2003762
      8F003F69A800384051000000000000000000000000008686860086868600F8F8
      F800DDDDDD00D7D7D700D7D7D7008686860077777700C0C0C000C0C0C0000000
      0000C0C0C0007777770077777700000000000000000000000000000000000000
      000000000000000000000370060047E07A0040D9730003700600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000919191003D5077003970B1003F7F
      D6003F7FD6003F7FD6003F7FD6007ADDFF007ADDFF0057ADF4003F7FD6003F7F
      D6003F7FD60042588B0000000000000000000000000000000000000000008686
      860086868600F8F8F80077777700C0C0C000C0C0C000DDDDDD00E3E3E300DDDD
      DD00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000037006004DE5800045DE780003700600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000919191004B85C9008EC5F300BEE9
      FA00A8D7F7008EC5F3008EC5F30057A5EB005098E600398CEA003A8AE7003A8A
      E7003A8AE7003751660000000000000000000000000000000000000000000000
      0000000000008686860086868600D7D7D700DDDDDD00EAEAEA00EAEAEA00F1F1
      F100DDDDDD000000000000000000000000000000000000000000000000000000
      000000000000000000000370060052EB85004DE5800003700600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009797970085858500476E
      A300276AC9003981D3005B94CE0069C0F7007BCAF90092E4FD007BCAF9007ADD
      FF0069CFFF00384E6D0000000000000000000000000000000000000000000000
      000000000000000000000000000086868600E3E3E300EAEAEA00F1F1F100F8F8
      F800F8F8F800DDDDDD0000000000000000000000000000000000000000000000
      0000000000000000000003700600037006000370060003700600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009797
      97001E4BB100223B800000000000000000001E265D00121D6E0037628F003F69
      A8007B7B7B000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000086868600F1F1F100F1F1F100F8F8
      F800868686008686860000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009191
      91004B8BD600286CDD00223B8000223B80001938950012258000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000086868600868686008686
      8600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000092929200A0A0A000476B9400476B940042588B0000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00F81FF01FC0FF0000E007E00780BF0000
      C003C003803F000080018001000F000000010001C00300000000000080000000
      0000000000300000000000000C1F0000000000001E0F000000000000FE0F0000
      00000000FF07000000010000FF87000000010001FF83000080038003FFC10000
      C007C007FFE10000E00FE00FFFE10000F01FFFFFF81FF81FE007CFFFE007E007
      C00387F3C003C003800183E3800180010001C3C7800100010000E18F00000000
      0000F01F000000000000F83F000000000000FC3F000000000000F81F00000000
      0000F18F000000000000E3C7800100010001C7E78001000180038FFFC0038003
      C0079FFFE007C007E00FFFFFF81FE00FFC7FFFFFFFFFC1FFF01FFFFFFFFF803F
      C007FC3FFFFF00078001FC3FFFFF00038001FC3FFFFF00030001FC3FFFFF0003
      0000C003C00300030000C003C00300030000C003C00300030000C003C0030003
      8001FC3FFFFF0003E007FC3FFFFF0003F803FC3FFFFF8003FE00FC3FFFFFE307
      FF03FFFFFFFFE03FFF8FFFFFFFFFF07F00000000000000000000000000000000
      000000000000}
  end
end
