object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Form2'
  ClientHeight = 225
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    482
    225)
  PixelsPerInch = 96
  TextHeight = 13
  object lblBody: TLabel
    Left = 8
    Top = 127
    Width = 33
    Height = 13
    Caption = #1058#1077#1082#1089#1090':'
    FocusControl = meBody
  end
  object Button1: TButton
    Left = 399
    Top = 144
    Width = 75
    Height = 73
    Anchors = [akTop, akRight, akBottom]
    Caption = 'Button1'
    TabOrder = 4
  end
  object ledFrom: TLabeledEdit
    Left = 8
    Top = 20
    Width = 466
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 44
    EditLabel.Height = 13
    EditLabel.Caption = #1054#1090' '#1082#1086#1075#1086':'
    TabOrder = 0
    ExplicitWidth = 456
  end
  object ledTo: TLabeledEdit
    Left = 8
    Top = 60
    Width = 466
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 29
    EditLabel.Height = 13
    EditLabel.Caption = #1050#1086#1084#1091':'
    TabOrder = 1
    ExplicitWidth = 456
  end
  object ledSubject: TLabeledEdit
    Left = 8
    Top = 100
    Width = 466
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = #1058#1077#1084#1072':'
    TabOrder = 2
    ExplicitWidth = 456
  end
  object meBody: TMemo
    Left = 8
    Top = 146
    Width = 385
    Height = 71
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
  end
  object ActionList: TActionList
    Left = 416
    Top = 24
  end
end
