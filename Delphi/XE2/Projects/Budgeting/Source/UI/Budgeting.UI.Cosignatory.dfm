inherited frmCosignatory: TfrmCosignatory
  ClientHeight = 437
  ExplicitWidth = 400
  ExplicitHeight = 478
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvl1: TBevel
    Top = 401
    ExplicitTop = 401
  end
  inherited pnlButtons: TPanel
    Top = 412
    TabOrder = 15
    ExplicitTop = 412
    inherited btnSave: TButton
      Caption = #1057#1086'&'#1093#1088#1072#1085#1080#1090#1100
    end
    inherited pbProgress: TcxProgressBar
      ExplicitHeight = 23
    end
  end
  object cxlblBankInfo: TcxLabel [2]
    AlignWithMargins = True
    Left = 3
    Top = 271
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1041#1072#1085#1082':'
    FocusControl = cbbBankInfo
    ExplicitTop = 291
  end
  object cbbBankInfo: TcxComboBox [3]
    AlignWithMargins = True
    Left = 3
    Top = 294
    Align = alTop
    Properties.DropDownListStyle = lsEditFixedList
    Properties.ImmediatePost = True
    Properties.OnEditValueChanged = cbbBankInfoPropertiesEditValueChanged
    TabOrder = 8
    Width = 376
  end
  object cxlblName: TcxLabel [4]
    AlignWithMargins = True
    Left = 3
    Top = 6
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
    FocusControl = edtName
  end
  object edtName: TcxTextEdit [5]
    AlignWithMargins = True
    Left = 3
    Top = 29
    Align = alTop
    Properties.OnChange = edtNamePropertiesChange
    Properties.OnEditValueChanged = edtNamePropertiesEditValueChanged
    TabOrder = 0
    Width = 376
  end
  object cxlblAddress: TcxLabel [6]
    AlignWithMargins = True
    Left = 3
    Top = 112
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1040#1076#1088#1077#1089':'
    FocusControl = edtAddress
    ExplicitTop = 116
  end
  object edtAddress: TcxTextEdit [7]
    AlignWithMargins = True
    Left = 3
    Top = 135
    Align = alTop
    Properties.OnChange = edtAddressPropertiesChange
    Properties.OnEditValueChanged = edtAddressPropertiesEditValueChanged
    TabOrder = 2
    Width = 376
  end
  object chkActivity: TcxCheckBox [8]
    AlignWithMargins = True
    Left = 3
    Top = 377
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
    Properties.OnChange = chkActivityPropertiesChange
    Properties.OnEditValueChanged = chkActivityPropertiesEditValueChanged
    TabOrder = 12
    Width = 376
  end
  object cxlblUNP: TcxLabel [9]
    AlignWithMargins = True
    Left = 3
    Top = 59
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1059#1053#1055':'
    FocusControl = edtUNP
  end
  object edtUNP: TcxTextEdit [10]
    AlignWithMargins = True
    Left = 3
    Top = 82
    Align = alTop
    Properties.OnChange = edtUNPPropertiesChange
    Properties.OnEditValueChanged = edtUNPPropertiesEditValueChanged
    TabOrder = 1
    Width = 376
  end
  object cxlblAgreementNumber: TcxLabel [11]
    AlignWithMargins = True
    Left = 3
    Top = 165
    Margins.Top = 6
    Align = alTop
    Caption = #1053#1086'&'#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072':'
  end
  object edtAgreementNumber: TcxTextEdit [12]
    AlignWithMargins = True
    Left = 3
    Top = 188
    Align = alTop
    Properties.OnChange = edtAgreementNumberPropertiesChange
    Properties.OnEditValueChanged = edtAgreementNumberPropertiesEditValueChanged
    TabOrder = 4
    Width = 376
  end
  object cxlblAccount: TcxLabel [13]
    AlignWithMargins = True
    Left = 3
    Top = 324
    Margins.Top = 6
    Align = alTop
    Caption = #1053#1086'&'#1084#1077#1088' '#1089#1095#1105#1090#1072':'
    FocusControl = edtAccount
    ExplicitTop = 328
  end
  object edtAccount: TcxTextEdit [14]
    AlignWithMargins = True
    Left = 3
    Top = 347
    Align = alTop
    Properties.OnChange = edtlAccountPropertiesChange
    Properties.OnEditValueChanged = edtlAccountPropertiesEditValueChanged
    TabOrder = 9
    Width = 376
  end
  object cxlblAgreementPeriod: TcxLabel [15]
    AlignWithMargins = True
    Left = 3
    Top = 218
    Margins.Top = 6
    Align = alTop
    Caption = #1057#1088#1086#1082' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1076#1086#1075#1086#1074#1086#1088#1072':'
  end
  object pnlAgreementPeriod: TPanel [16]
    AlignWithMargins = True
    Left = 3
    Top = 241
    Width = 376
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    object deAgreementStart: TcxDateEdit
      Left = 12
      Top = 0
      Align = alLeft
      Properties.DisplayFormat = 'dd.mm.yyyy'
      Properties.EditFormat = 'dd.mm.yyyy'
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.OnChange = deAgreementStartPropertiesChange
      Properties.OnEditValueChanged = deAgreementStartPropertiesEditValueChanged
      TabOrder = 0
      Width = 121
    end
    object cxlblAgreementStart: TcxLabel
      AlignWithMargins = True
      Left = 0
      Top = 3
      Margins.Left = 0
      Align = alLeft
      Caption = '&c'
      FocusControl = deAgreementStart
    end
    object cxlbl1: TcxLabel
      AlignWithMargins = True
      Left = 139
      Top = 3
      Margins.Left = 6
      Align = alLeft
      Caption = '&'#1087#1086
      FocusControl = deAgreementStop
    end
    object deAgreementStop: TcxDateEdit
      Left = 158
      Top = 0
      Align = alLeft
      Properties.DisplayFormat = 'dd.mm.yyyy'
      Properties.EditFormat = 'dd.mm.yyyy'
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.OnChange = deAgreementStopPropertiesChange
      Properties.OnEditValueChanged = deAgreementStopPropertiesEditValueChanged
      TabOrder = 1
      Width = 121
    end
  end
end
