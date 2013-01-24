object ProfileForm: TProfileForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 6
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1086#1092#1080#1083#1103
  ClientHeight = 320
  ClientWidth = 462
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 293
    Width = 462
    Height = 27
    Align = alBottom
    BevelOuter = bvNone
    Constraints.MaxHeight = 27
    Constraints.MinHeight = 27
    TabOrder = 2
    DesignSize = (
      462
      27)
    object btnApply: TButton
      Left = 225
      Top = 2
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actApply
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object btnCancel: TButton
      Left = 306
      Top = 2
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actCancel
      Anchors = [akTop, akRight]
      Cancel = True
      TabOrder = 2
    end
    object btnDefaults: TButton
      Left = 0
      Top = 2
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actDefaults
      TabOrder = 0
    end
    object btnHelp: TButton
      Left = 387
      Top = 2
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actHelp
      Anchors = [akTop, akRight]
      TabOrder = 3
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 53
    Width = 462
    Height = 240
    Align = alClient
    Style = tsButtons
    TabOrder = 1
    object tsConnection: TTabSheet
      Caption = ' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1082' '#1090#1077#1089#1090#1080#1088#1091#1077#1084#1086#1081' '#1073#1072#1079#1077' '#1076#1072#1085#1085#1099#1093
      TabVisible = False
      object gbConnection: TGroupBox
        Left = 0
        Top = 0
        Width = 454
        Height = 230
        Align = alClient
        TabOrder = 0
        DesignSize = (
          454
          230)
        object lblServerName: TLabel
          Left = 10
          Top = 9
          Width = 199
          Height = 13
          Caption = '&1. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1080#1083#1080' '#1074#1074#1077#1076#1080#1090#1077' '#1080#1084#1103' '#1089#1077#1088#1074#1077#1088#1072':'
          FocusControl = cmbServerName
        end
        object lblDatabaseName: TLabel
          Left = 10
          Top = 174
          Width = 194
          Height = 13
          Caption = '&3. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1073#1072#1079#1091' '#1076#1072#1085#1085#1099#1093' '#1085#1072' '#1089#1077#1088#1074#1077#1088#1077':'
          Enabled = False
          FocusControl = cmbDatabaseName
        end
        object lblLogin: TLabel
          Left = 67
          Top = 123
          Width = 30
          Height = 13
          Caption = #1051#1086'&'#1075#1080#1085
          Enabled = False
          FocusControl = ebLogin
        end
        object lblPassword: TLabel
          Left = 67
          Top = 150
          Width = 37
          Height = 13
          Caption = #1055#1072'&'#1088#1086#1083#1100
          Enabled = False
          FocusControl = mePassword
        end
        object lblSecurity: TLabel
          Left = 10
          Top = 55
          Width = 197
          Height = 13
          Caption = '&2. '#1044#1083#1103' '#1074#1093#1086#1076#1072' '#1085#1072' '#1089#1077#1088#1074#1077#1088' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100':'
          FocusControl = rbWinNTSecurity
        end
        object cmbServerName: TComboBox
          Left = 43
          Top = 28
          Width = 401
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Sorted = True
          TabOrder = 0
          OnChange = cmbServerNameChange
          OnDropDown = cmbServerNameDropDown
          OnKeyUp = cmbServerNameKeyUp
          OnSelect = cmbServerNameSelect
        end
        object cmbDatabaseName: TComboBox
          Left = 43
          Top = 193
          Width = 253
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          TabOrder = 7
        end
        object rbWinNTSecurity: TRadioButton
          Left = 43
          Top = 74
          Width = 286
          Height = 17
          Action = actUseWinNTSecurity
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          TabStop = True
        end
        object rbLoginAndPassword: TRadioButton
          Left = 43
          Top = 97
          Width = 286
          Height = 17
          Action = actUseLoginAndPassword
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
        end
        object btnTestConnection: TButton
          Left = 302
          Top = 191
          Width = 142
          Height = 25
          Cursor = crHandPoint
          Action = actTestConnection
          Anchors = [akTop, akRight]
          TabOrder = 8
        end
        object cbUseEmptyPassword: TCheckBox
          Left = 302
          Top = 149
          Width = 63
          Height = 17
          Action = actUseEmptyPassword
          TabOrder = 5
        end
        object cbAllowPasswordSaving: TCheckBox
          Left = 371
          Top = 149
          Width = 73
          Height = 17
          Action = actAllowPasswordSaving
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 6
        end
        object ebLogin: TEdit
          Left = 110
          Top = 120
          Width = 186
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          TabOrder = 3
        end
        object mePassword: TMaskEdit
          Left = 110
          Top = 147
          Width = 186
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Enabled = False
          PasswordChar = '*'
          TabOrder = 4
          Text = ''
        end
      end
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 462
    Height = 53
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 4
    TabOrder = 0
    object gbTop: TGroupBox
      Left = 4
      Top = 4
      Width = 454
      Height = 45
      Align = alClient
      Caption = ' '#1053#1072#1089#1090#1088#1086#1081#1082#1080': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        454
        45)
      object cmbPageName: TComboBox
        Left = 10
        Top = 15
        Width = 379
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnSelect = cmbPageNameSelect
        Items.Strings = (
          ' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1082' '#1090#1077#1089#1090#1080#1088#1091#1077#1084#1086#1081' '#1073#1072#1079#1077' '#1076#1072#1085#1085#1099#1093)
      end
      object btnNextPage: TButton
        Left = 423
        Top = 15
        Width = 22
        Height = 21
        Cursor = crHandPoint
        Action = actNextPage
        Anchors = [akTop, akRight]
        Images = ImageList
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object btnPreviousPage: TButton
        Left = 395
        Top = 15
        Width = 22
        Height = 21
        Cursor = crHandPoint
        Action = actPreviousPage
        Anchors = [akTop, akRight]
        Images = ImageList
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
    end
  end
  object ActionList: TActionList
    Images = ImageList
    Left = 368
    Top = 168
    object actCancel: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1054#1090#1084#1077#1085#1072
      Hint = #1054#1090#1084#1077#1085#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1084#1077#1085#1099' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
      OnExecute = actCancelExecute
    end
    object actApply: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1055#1088#1080#1084#1077#1085#1080#1090#1100
      Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
    end
    object actHelp: TAction_Help
      Category = #1057#1087#1088#1072#1074#1082#1072
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      Enabled = False
      Hint = #1057#1087#1088#1072#1074#1082#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ImageIndex = 2
      ShortCut = 112
    end
    object actTestConnection: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = #1055'&'#1088#1086#1074#1077#1088#1082#1072' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      Hint = 
        #1058#1077#1089#1090#1080#1088#1086#1074#1072#1090#1100' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1090#1077#1089#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1089#1086#1077#1076#1080 +
        #1085#1077#1085#1080#1103' '
    end
    object actUseWinNTSecurity: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      AutoCheck = True
      Caption = #1074#1089#1090#1088#1086#1077#1085#1085#1091#1102' '#1089#1080#1089#1090#1077#1084#1091' &'#1073#1077#1079#1086#1087#1072#1089#1085#1086#1089#1090#1080' Windows NT'
      Checked = True
      OnExecute = actUseWinNTSecurityExecute
    end
    object actUseLoginAndPassword: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      AutoCheck = True
      Caption = #1089#1083#1077#1076#1091#1102#1097#1080#1077' &'#1083#1086#1075#1080#1085' '#1080' '#1087#1072#1088#1086#1083#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
      OnExecute = actUseLoginAndPasswordExecute
    end
    object actDefaults: TAction_Defaults
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = #1057'&'#1073#1088#1086#1089
      Hint = 
        #1057#1073#1088#1086#1089#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1073#1088#1086#1089#1072' '#1074#1089#1077#1093' '#1079#1085#1072#1095#1077#1085#1080#1081' '#1082' '#1079#1085#1072#1095#1077#1085#1080#1103#1084' '#1087 +
        #1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    end
    object actPreviousPage: TAction_PreviousPage
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Hint = 
        #1050' '#1087#1088#1077#1076#1099#1076#1091#1097#1077#1081' '#1089#1090#1088#1072#1085#1080#1094#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1087#1088#1077#1076#1099#1076#1091#1097#1077#1081' '#1089#1090#1088#1072#1085#1080#1094 +
        #1099
      ImageIndex = 0
      ShortCut = 16421
      OnExecute = actPreviousPageExecute
      OnUpdate = actPreviousPageUpdate
    end
    object actNextPage: TAction_NextPage
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Hint = #1050' '#1089#1083#1077#1076#1091#1102#1097#1077#1081' '#1089#1090#1088#1072#1085#1080#1094#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1089#1083#1077#1076#1091#1102#1097#1077#1081' '#1089#1090#1088#1072#1085#1080#1094#1099
      ImageIndex = 1
      ShortCut = 16423
      OnExecute = actNextPageExecute
      OnUpdate = actNextPageUpdate
    end
    object actAllowPasswordSaving: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      AutoCheck = True
      Caption = #1089#1086'&'#1093#1088#1072#1085#1080#1090#1100
      OnExecute = actAllowPasswordSavingExecute
      OnUpdate = actAllowPasswordSavingUpdate
    end
    object actUseEmptyPassword: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      AutoCheck = True
      Caption = #1087#1091#1089#1090#1086'&'#1081
      OnExecute = actUseEmptyPasswordExecute
      OnUpdate = actUseEmptyPasswordUpdate
    end
  end
  object ADOConnection: TADOConnection
    Provider = 'SQLOLEDB.1'
    Left = 368
    Top = 120
  end
  object ImageList: TImageList
    Left = 16
    Top = 184
    Bitmap = {
      494C010102000800200010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000042424200868686000000000000000000000000003333
      3300A4A0A0000000000000000000000000000000000000000000424242009966
      6600000000000000000000000000424242008686860000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000042424200C0C0C000F0FBFF00868686000000000033333300C0C0
      C000F0FBFF00A4A0A00000000000000000000000000033666600C0C0C000C0DC
      C000868686000000000042424200C0C0C000F0FBFF0086868600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000042424200C0C0C000F0FBFF00868686000000000033333300C0C0C000F0FB
      FF00A4A0A000000000000000000000000000000000000000000042424200C0C0
      C000F0FBFF00868686000000000042424200C0C0C000F0FBFF00A4A0A0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200C0C0C000F0FBFF00868686000000000033333300C0C0C000F0FBFF00A4A0
      A000000000000000000000000000000000000000000000000000000000004242
      4200C0C0C000F0FBFF00868686000000000033333300C0C0C000F0FBFF00A4A0
      A000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000042424200C0C0
      C000F0FBFF00868686000000000042424200C0C0C000F0FBFF00A4A0A0000000
      0000000000000000000000000000000000000000000000000000000000000000
      000042424200C0C0C000F0FBFF00868686000000000033333300C0C0C000F0FB
      FF00A4A0A0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000033666600C0C0C000C0DC
      C000868686000000000042424200C0C0C000F0FBFF0086868600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000042424200C0C0C000F0FBFF00868686000000000033333300C0C0
      C000F0FBFF00A4A0A00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000042424200C0C0
      C000F0FBFF00868686000000000042424200C0C0C000F0FBFF00A4A0A0000000
      0000000000000000000000000000000000000000000000000000000000000000
      000042424200C0C0C000F0FBFF00868686000000000033333300C0C0C000F0FB
      FF00A4A0A0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200C0C0C000F0FBFF00868686000000000033333300C0C0C000F0FBFF00A4A0
      A000000000000000000000000000000000000000000000000000000000004242
      4200C0C0C000F0FBFF00868686000000000033333300C0C0C000F0FBFF00A4A0
      A000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000042424200C0C0C000F0FBFF00868686000000000033333300C0C0C000F0FB
      FF00A4A0A000000000000000000000000000000000000000000042424200C0C0
      C000F0FBFF00868686000000000042424200C0C0C000F0FBFF00A4A0A0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000042424200C0C0C000F0FBFF00868686000000000033333300C0C0
      C000F0FBFF00A4A0A00000000000000000000000000033666600C0C0C000C0DC
      C000868686000000000042424200C0C0C000F0FBFF0086868600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000042424200868686000000000000000000000000003333
      3300A4A0A0000000000000000000000000000000000000000000424242009966
      6600000000000000000000000000424242008686860000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      FC63C63F00000000F801801F00000000F001800F00000000E001800700000000
      C003C003000000008007E00100000000800FF001000000008007E00100000000
      C003C00300000000E001800700000000F001800F00000000F801801F00000000
      FC63C63F00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
