inherited frmBank: TfrmBank
  ExplicitWidth = 400
  ExplicitHeight = 267
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlButtons: TPanel
    TabOrder = 7
    inherited pbProgress: TcxProgressBar
      ExplicitHeight = 23
    end
  end
  object cxlblName: TcxLabel [2]
    AlignWithMargins = True
    Left = 3
    Top = 6
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
    FocusControl = edtName
  end
  object edtName: TcxTextEdit [3]
    AlignWithMargins = True
    Left = 3
    Top = 29
    Align = alTop
    Properties.OnChange = edtNamePropertiesChange
    Properties.OnEditValueChanged = edtNamePropertiesEditValueChanged
    TabOrder = 1
    Width = 376
  end
  object cxlblCode: TcxLabel [4]
    AlignWithMargins = True
    Left = 3
    Top = 59
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1050#1086#1076':'
    FocusControl = edtCode
  end
  object edtCode: TcxTextEdit [5]
    AlignWithMargins = True
    Left = 3
    Top = 82
    Align = alTop
    Properties.OnChange = edtCodePropertiesChange
    Properties.OnEditValueChanged = edtCodePropertiesEditValueChanged
    TabOrder = 3
    Width = 376
  end
  object cxlblAddress: TcxLabel [6]
    AlignWithMargins = True
    Left = 3
    Top = 112
    Margins.Top = 6
    Align = alTop
    Caption = #1040'&'#1076#1088#1077#1089':'
  end
  object edtAddress: TcxTextEdit [7]
    AlignWithMargins = True
    Left = 3
    Top = 135
    Align = alTop
    Properties.OnChange = edtAddressPropertiesChange
    Properties.OnEditValueChanged = edtAddressPropertiesEditValueChanged
    TabOrder = 5
    Width = 376
  end
  object chkActivity: TcxCheckBox [8]
    AlignWithMargins = True
    Left = 3
    Top = 165
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
    Properties.OnChange = chkActivityPropertiesChange
    Properties.OnEditValueChanged = chkActivityPropertiesEditValueChanged
    TabOrder = 6
    Width = 376
  end
end