object MaintenanceForm: TMaintenanceForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1077#1088#1074#1080#1089#1085#1086#1077' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1077' '#1041#1044
  ClientHeight = 77
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 5
    Top = 0
    Width = 419
    Height = 56
    Caption = ' '#1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1080#1079' '#1041#1044' '#1088#1072#1085#1085#1080#1093' '#1074#1077#1088#1089#1080#1081' '
    TabOrder = 0
    object btnImport: TButton
      Left = 10
      Top = 20
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Enabled = False
      TabOrder = 0
      OnClick = btnImportClick
    end
    object pbImportTotal: TProgressBar
      Left = 100
      Top = 20
      Width = 306
      Height = 11
      TabOrder = 1
    end
    object pbImportDetail: TProgressBar
      Left = 100
      Top = 34
      Width = 306
      Height = 11
      TabOrder = 2
    end
  end
  object sbMaintenance: TStatusBar
    Left = 0
    Top = 58
    Width = 428
    Height = 19
    Panels = <>
    SimplePanel = True
    SizeGrip = False
  end
end
