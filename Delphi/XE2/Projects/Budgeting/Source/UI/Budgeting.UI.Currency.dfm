inherited frmCurrency: TfrmCurrency
  ClientHeight = 172
  ExplicitWidth = 400
  ExplicitHeight = 213
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvl1: TBevel
    Top = 136
  end
  inherited pnlButtons: TPanel
    Top = 147
    TabOrder = 5
    inherited pbProgress: TcxProgressBar
      ExplicitHeight = 23
    end
  end
  object cxlblCode: TcxLabel [2]
    AlignWithMargins = True
    Left = 3
    Top = 6
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1050#1086#1076':'
    FocusControl = edtCode
  end
  object edtCode: TcxTextEdit [3]
    AlignWithMargins = True
    Left = 3
    Top = 29
    Align = alTop
    Properties.OnChange = edtCodePropertiesChange
    Properties.OnEditValueChanged = edtCodePropertiesEditValueChanged
    TabOrder = 0
    Width = 376
  end
  object cxlblDescription: TcxLabel [4]
    AlignWithMargins = True
    Left = 3
    Top = 59
    Margins.Top = 6
    Align = alTop
    Caption = #1054'&'#1087#1080#1089#1072#1085#1080#1077':'
    ExplicitTop = 112
  end
  object edtDescription: TcxTextEdit [5]
    AlignWithMargins = True
    Left = 3
    Top = 82
    Align = alTop
    Properties.OnChange = edtAddressPropertiesChange
    Properties.OnEditValueChanged = edtAddressPropertiesEditValueChanged
    TabOrder = 1
    ExplicitTop = 135
    Width = 376
  end
  object chkActivity: TcxCheckBox [6]
    AlignWithMargins = True
    Left = 3
    Top = 112
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
    Properties.OnChange = chkActivityPropertiesChange
    Properties.OnEditValueChanged = chkActivityPropertiesEditValueChanged
    TabOrder = 2
    ExplicitTop = 165
    Width = 376
  end
end
