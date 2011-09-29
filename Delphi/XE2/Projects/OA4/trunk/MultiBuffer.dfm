object MultiBufferForm: TMultiBufferForm
  Left = 0
  Top = 0
  Hint = #1054#1082#1085#1086' '#1084#1091#1083#1100#1090#1080#1073#1091#1092#1077#1088#1072' '#1082#1086#1087#1080#1088#1091#1077#1084#1099#1093' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1081
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 5
  Caption = #1052#1091#1083#1100#1090#1080#1073#1091#1092#1077#1088
  ClientHeight = 256
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lvBuffer: TListView
    Left = 0
    Top = 0
    Width = 634
    Height = 219
    Hint = #1057#1087#1080#1089#1086#1082' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1081' '#1089#1082#1086#1087#1080#1088#1086#1074#1072#1085#1085#1099#1093' '#1074' '#1073#1091#1092#1077#1088
    Align = alClient
    Columns = <
      item
        Caption = 'ID'
        Width = 75
      end
      item
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 486
      end>
    ColumnClick = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnSelectItem = lvBufferSelectItem
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 219
    Width = 634
    Height = 37
    Align = alBottom
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    object btnPaste: TButton
      Left = 5
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1089#1090#1072#1074#1082#1080' '#1074#1099#1073#1088#1072#1085#1085#1099#1093' '#1076#1072#1085#1085#1099#1093' '#1086' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1080' '#1074' '#1087#1086#1083#1103' '#1074#1074#1086#1076#1072
      Caption = '&'#1042#1089#1090#1072#1074#1080#1090#1100
      ModalResult = 1
      TabOrder = 0
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
      Default = True
      ModalResult = 2
      TabOrder = 3
    end
    object btnHelp: TButton
      Left = 550
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      TabOrder = 4
    end
    object btnDelete: TButton
      Left = 86
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1074#1099#1073#1088#1072#1085#1085#1099#1093' '#1076#1072#1085#1085#1099#1093' '#1080#1079' '#1073#1091#1092#1077#1088#1072
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      TabOrder = 1
      OnClick = btnDeleteClick
    end
    object btnClear: TButton
      Left = 167
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1074#1089#1077#1093' '#1076#1072#1085#1085#1099#1093' '#1080#1079' '#1073#1091#1092#1077#1088#1072
      Caption = '&'#1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 2
      OnClick = btnClearClick
    end
  end
end
