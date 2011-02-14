object AddOrderForm: TAddOrderForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1079#1072#1082#1072#1079#1072
  ClientHeight = 260
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 2
    Width = 63
    Height = 13
    Caption = 'F1: '#1058#1077#1083#1077#1092#1086#1085
  end
  object Label2: TLabel
    Left = 4
    Top = 43
    Width = 50
    Height = 13
    Caption = 'F2: '#1059#1083#1080#1094#1072
  end
  object Label3: TLabel
    Left = 137
    Top = 2
    Width = 31
    Height = 13
    Caption = #1051#1080#1085#1080#1103
  end
  object Label4: TLabel
    Left = 133
    Top = 24
    Width = 39
    Height = 13
    Caption = '<'#1085#1077#1090'>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 185
    Top = 2
    Width = 39
    Height = 13
    Caption = 'F3: '#1044#1086#1084
  end
  object Label6: TLabel
    Left = 244
    Top = 2
    Width = 55
    Height = 13
    Caption = 'F4: '#1050#1086#1088#1087#1091#1089
  end
  object Label7: TLabel
    Left = 185
    Top = 43
    Width = 32
    Height = 13
    Caption = 'F5: '#1050#1074
  end
  object Label8: TLabel
    Left = 244
    Top = 43
    Width = 64
    Height = 13
    Caption = 'F6: '#1055#1086#1076#1098#1077#1079#1076
  end
  object Label9: TLabel
    Left = 185
    Top = 83
    Width = 66
    Height = 13
    Caption = 'F7: '#1047#1072#1082#1072#1079#1095#1084#1082
  end
  object Label10: TLabel
    Left = 185
    Top = 127
    Width = 68
    Height = 13
    Caption = 'F8: '#1042#1086#1076#1080#1090#1077#1083#1100
  end
  object Button1: TButton
    Left = 76
    Top = 231
    Width = 75
    Height = 25
    Caption = 'OK'
    Enabled = False
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 155
    Top = 231
    Width = 75
    Height = 25
    Caption = #1053#1077#1089#1082#1086#1083#1100#1082#1086
    Enabled = False
    TabOrder = 1
  end
  object Button3: TButton
    Left = 235
    Top = 231
    Width = 75
    Height = 25
    Caption = #1053#1086#1074#1099#1081
    TabOrder = 2
  end
  object Button4: TButton
    Left = 315
    Top = 231
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object RichEdit1: TRichEdit
    Left = 183
    Top = 144
    Width = 207
    Height = 84
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
  end
  object Edit1: TEdit
    Left = 89
    Top = 16
    Width = 35
    Height = 21
    TabOrder = 5
    Text = '029'
  end
  object MaskEdit1: TMaskEdit
    Left = 1
    Top = 16
    Width = 81
    Height = 21
    EditMask = '000\-00\-00;1; '
    MaxLength = 9
    TabOrder = 6
    Text = '   -  -  '
  end
  object Edit2: TEdit
    Left = 183
    Top = 16
    Width = 51
    Height = 21
    TabOrder = 7
  end
  object Edit3: TEdit
    Left = 242
    Top = 16
    Width = 133
    Height = 21
    TabOrder = 8
  end
  object ListBox1: TListBox
    Left = 1
    Top = 57
    Width = 179
    Height = 171
    ItemHeight = 13
    Sorted = True
    TabOrder = 9
  end
  object Edit4: TEdit
    Left = 183
    Top = 57
    Width = 51
    Height = 21
    TabOrder = 10
  end
  object Edit5: TEdit
    Left = 242
    Top = 57
    Width = 133
    Height = 21
    TabOrder = 11
  end
  object Edit6: TEdit
    Left = 183
    Top = 97
    Width = 207
    Height = 21
    TabOrder = 12
  end
  object Edit7: TEdit
    Left = 337
    Top = 121
    Width = 53
    Height = 21
    TabOrder = 13
    Text = '0 '#1084#1080#1085
  end
  object Edit8: TEdit
    Left = 280
    Top = 121
    Width = 55
    Height = 21
    TabOrder = 14
  end
end
