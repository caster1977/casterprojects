object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'TestMySQL'
  ClientHeight = 72
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 105
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 39
    Width = 105
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 1
    OnClick = Button2Click
  end
end
