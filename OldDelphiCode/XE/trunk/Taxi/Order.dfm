object OrderForm: TOrderForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1079#1072#1082#1072#1079' '#1076#1083#1103' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
  ClientHeight = 262
  ClientWidth = 342
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
    Left = 4
    Top = 3
    Width = 69
    Height = 13
    Caption = 'F1: '#1055#1086#1079#1099#1074#1085#1086#1081
  end
  object Label2: TLabel
    Left = 86
    Top = 3
    Width = 63
    Height = 13
    Caption = 'F2: '#1058#1077#1083#1077#1092#1086#1085
  end
  object MaskEdit1: TMaskEdit
    Left = 85
    Top = 18
    Width = 86
    Height = 21
    EditMask = '000\-00\-00;1; '
    MaxLength = 9
    TabOrder = 1
    Text = '   -  -  '
  end
  object Memo1: TMemo
    Left = 0
    Top = 42
    Width = 339
    Height = 189
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    Lines.Strings = (
      '<'#1079#1072#1082#1072#1079' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>')
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
  end
  object Button1: TButton
    Left = 185
    Top = 236
    Width = 75
    Height = 24
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 4
  end
  object Button2: TButton
    Left = 265
    Top = 236
    Width = 75
    Height = 24
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 5
  end
  object Edit1: TEdit
    Left = 2
    Top = 18
    Width = 69
    Height = 21
    MaxLength = 4
    TabOrder = 0
    Text = '0'
  end
  object Edit2: TEdit
    Left = 173
    Top = 18
    Width = 35
    Height = 21
    MaxLength = 3
    TabOrder = 2
  end
end
