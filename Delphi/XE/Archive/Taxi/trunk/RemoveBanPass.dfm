object RemoveBanPassForm: TRemoveBanPassForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1042#1085#1080#1084#1072#1085#1080#1077
  ClientHeight = 96
  ClientWidth = 196
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 3
    Width = 153
    Height = 28
    AutoSize = False
    Caption = #1054#1090#1084#1077#1085#1072' '#1076#1072#1085#1085#1086#1075#1086' '#1079#1072#1087#1088#1077#1090#1072' '#1079#1072#1097#1080#1097#1077#1085#1072' '#1087#1072#1088#1086#1083#1077#1084
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 4
    Top = 40
    Width = 82
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100
  end
  object Button1: TButton
    Left = 18
    Top = 65
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 99
    Top = 65
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 92
    Top = 37
    Width = 94
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
end
