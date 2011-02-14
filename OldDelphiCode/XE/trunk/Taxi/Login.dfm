object LoginForm: TLoginForm
  Left = 0
  Top = 0
  ActiveControl = edbxLogin
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103' '#1076#1080#1089#1087#1077#1090#1095#1077#1088#1072
  ClientHeight = 95
  ClientWidth = 206
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
  object lblLogin: TLabel
    Left = 8
    Top = 8
    Width = 101
    Height = 13
    Caption = 'F1: '#1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
    FocusControl = edbxLogin
  end
  object lblPassword: TLabel
    Left = 8
    Top = 36
    Width = 56
    Height = 13
    Caption = 'F2: '#1055#1072#1088#1086#1083#1100
    FocusControl = edbxPassword
  end
  object edbxLogin: TEdit
    Left = 115
    Top = 4
    Width = 88
    Height = 21
    Hint = #1042#1074#1077#1076#1080#1090#1077' '#1042#1072#1096' '#1083#1086#1075#1080#1085
    TabOrder = 0
    OnChange = edbxLoginChange
    OnKeyUp = edbxLoginKeyUp
  end
  object edbxPassword: TMaskEdit
    Left = 115
    Top = 30
    Width = 88
    Height = 21
    Hint = #1042#1074#1077#1076#1080#1090#1077' '#1042#1072#1096' '#1087#1072#1088#1086#1083#1100
    PasswordChar = '*'
    TabOrder = 1
    OnKeyUp = edbxPasswordKeyUp
  end
  object btnOk: TButton
    Left = 24
    Top = 67
    Width = 75
    Height = 24
    Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1086#1087#1099#1090#1082#1080' '#1074#1093#1086#1076#1072' '#1074' '#1089#1080#1089#1090#1077#1084#1091' '#1087#1086#1076' '#1091#1082#1072#1079#1072#1085#1085#1099#1084' '#1080#1084#1077#1085#1077#1084
    Caption = 'OK'
    Enabled = False
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 107
    Top = 67
    Width = 75
    Height = 24
    Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
