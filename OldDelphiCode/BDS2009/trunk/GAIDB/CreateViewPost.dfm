object CreateViewPostForm: TCreateViewPostForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 5
  Caption = 'OA4 - '#1044#1086#1073#1072#1074#1083#1077#1085#1080#1077'/'#1095#1090#1077#1085#1080#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
  ClientHeight = 256
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 219
    Width = 634
    Height = 37
    Align = alBottom
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    object btnProcess: TButton
      Left = 4
      Top = 4
      Width = 157
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1086#1084#1077#1090#1082#1080' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1103', '#1082#1072#1082' '#1087#1088#1086#1095#1080#1090#1072#1085#1085#1086#1075#1086
      Caption = '&'#1055#1086#1084#1077#1090#1080#1090#1100' '#1082#1072#1082' '#1087#1088#1086#1095#1080#1090#1072#1085#1085#1086#1077
      TabOrder = 1
      OnClick = btnProcessClick
    end
    object btnSend: TButton
      Left = 388
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1089#1086#1086#1073#1097#1077#1085#1080#1103' '#1072#1076#1088#1077#1089#1072#1090#1091
      Caption = #1054'&'#1090#1087#1088#1072#1074#1080#1090#1100
      ModalResult = 1
      TabOrder = 4
    end
    object btnClose: TButton
      Left = 469
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 5
    end
    object btnHelp: TButton
      Left = 550
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      TabOrder = 6
    end
    object btnClear: TButton
      Left = 4
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1095#1080#1089#1090#1082#1080' '#1087#1086#1083#1077#1081' '#1092#1086#1088#1084#1099
      Caption = '&'#1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 0
      OnClick = btnClearClick
    end
    object btnPrevious: TButton
      Left = 248
      Top = 4
      Width = 91
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1077#1088#1077#1093#1086#1076#1072' '#1082' '#1087#1088#1077#1076#1099#1076#1091#1097#1077#1084#1091' '#1085#1077#1087#1088#1086#1095#1080#1090#1072#1085#1085#1086#1084#1091' '#1087#1080#1089#1100#1084#1091
      Caption = '&'#1055#1088#1077#1076#1099#1076#1091#1097#1077#1077
      TabOrder = 2
      Visible = False
    end
    object btnNext: TButton
      Left = 345
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1077#1088#1077#1093#1086#1076#1072' '#1082' '#1089#1083#1077#1076#1091#1102#1097#1077#1084#1091' '#1085#1077#1087#1088#1086#1095#1080#1090#1072#1085#1085#1086#1084#1091' '#1087#1080#1089#1100#1084#1091
      Caption = '&'#1057#1083#1077#1076#1091#1102#1097#1077#1077
      TabOrder = 3
      Visible = False
    end
    object btnErase: TButton
      Left = 167
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1076#1072#1085#1085#1086#1075#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      TabOrder = 7
      OnClick = btnEraseClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 634
    Height = 219
    Align = alClient
    BevelEdges = []
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object pnlID: TPanel
      Left = 0
      Top = 193
      Width = 634
      Height = 26
      Hint = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1079#1072#1087#1080#1089#1080' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      Align = alBottom
      BevelEdges = []
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      object lblPostIDCaption: TLabel
        Left = 2
        Top = 7
        Width = 123
        Height = 13
        Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1079#1072#1087#1080#1089#1080':'
        Transparent = False
        Layout = tlCenter
      end
      object lblPostID: TLabel
        Left = 131
        Top = 7
        Width = 5
        Height = 13
        Caption = '?'
        Enabled = False
        Transparent = False
      end
      object Bevel4: TBevel
        Left = 0
        Top = 0
        Width = 634
        Height = 6
        Align = alTop
        Shape = bsTopLine
        ExplicitTop = 20
        ExplicitWidth = 233
      end
    end
    object pnlCreation: TPanel
      Left = 0
      Top = 167
      Width = 634
      Height = 26
      Hint = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1089#1086#1086#1073#1097#1077#1085#1080#1103', '#1072#1074#1090#1086#1088' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      Align = alBottom
      BevelEdges = []
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object lblPostCreatedAtByCaption: TLabel
        Left = 2
        Top = 7
        Width = 103
        Height = 13
        Caption = #1050#1090#1086' '#1080' '#1082#1086#1075#1076#1072' '#1089#1086#1079#1076#1072#1083':'
        Transparent = False
        Layout = tlCenter
      end
      object lblPostCreatedAtBy: TLabel
        Left = 131
        Top = 7
        Width = 5
        Height = 13
        Caption = '?'
        Enabled = False
        Transparent = False
      end
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 634
        Height = 6
        Align = alTop
        Shape = bsTopLine
        ExplicitTop = 20
        ExplicitWidth = 233
      end
    end
    object meMessage: TMemo
      Left = 0
      Top = 47
      Width = 634
      Height = 120
      Hint = #1042#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      Align = alClient
      TabOrder = 1
      OnChange = FormShow
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 634
      Height = 47
      Align = alTop
      BevelEdges = []
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        634
        47)
      object lblCaption: TLabel
        Left = 2
        Top = 0
        Width = 83
        Height = 13
        Caption = #1058#1077#1084#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
        Transparent = False
        Layout = tlCenter
      end
      object lblTo: TLabel
        Left = 392
        Top = 0
        Width = 43
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #1040#1076#1088#1077#1089#1072#1090
        Transparent = False
        Layout = tlCenter
      end
      object lblMessage: TLabel
        Left = 2
        Top = 34
        Width = 88
        Height = 13
        Caption = #1058#1077#1082#1089#1090' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
        Transparent = False
        Layout = tlCenter
      end
      object edbxCaption: TEdit
        Left = 0
        Top = 13
        Width = 386
        Height = 21
        Hint = #1042#1074#1077#1076#1080#1090#1077' '#1079#1072#1075#1086#1083#1086#1074#1086#1082' ('#1090#1077#1084#1091') '#1089#1086#1086#1073#1097#1077#1085#1080#1103
        Anchors = [akLeft, akTop, akRight]
        OEMConvert = True
        TabOrder = 0
        OnChange = FormShow
      end
      object cmbbxTo: TComboBox
        Left = 392
        Top = 13
        Width = 242
        Height = 21
        Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1072#1076#1088#1077#1089#1072#1090#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1103' '#1080#1079' '#1089#1087#1080#1089#1082#1072
        Style = csDropDownList
        Anchors = [akTop, akRight]
        ItemHeight = 13
        TabOrder = 1
        OnChange = FormShow
      end
    end
  end
end
