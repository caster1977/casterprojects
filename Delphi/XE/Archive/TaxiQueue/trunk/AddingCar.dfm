object AddingCarForm: TAddingCarForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1055#1086#1089#1090#1072#1085#1086#1074#1082#1072'/'#1089#1087#1080#1089#1072#1085#1080#1077' '#1072#1074#1090#1086#1084#1086#1073#1080#1083#1103
  ClientHeight = 220
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 5
    Top = 8
    Width = 69
    Height = 13
    Caption = 'F1: '#1055#1086#1079#1099#1074#1085#1086#1081
    Layout = tlCenter
  end
  object Edit1: TEdit
    Left = 79
    Top = 5
    Width = 59
    Height = 21
    MaxLength = 3
    TabOrder = 0
    OnChange = Edit1Change
  end
  object RichEdit1: TRichEdit
    Left = 5
    Top = 30
    Width = 336
    Height = 126
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    WantTabs = True
  end
  object Button1: TButton
    Left = 35
    Top = 162
    Width = 110
    Height = 25
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100' ( Enter )'
    Enabled = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 35
    Top = 191
    Width = 224
    Height = 25
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1074' '#1085#1072#1095#1072#1083#1086' ( Num + )'
    Enabled = False
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 148
    Top = 162
    Width = 111
    Height = 25
    Caption = #1057#1087#1080#1089#1072#1090#1100' ( Num - )'
    Enabled = False
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 265
    Top = 191
    Width = 76
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 5
  end
end
