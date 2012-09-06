object PermissionsForm: TPermissionsForm
  Left = 0
  Top = 0
  ActiveControl = chklbxPermissions
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 5
  Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1088#1072#1074#1072#1084#1080' '#1076#1086#1089#1090#1091#1087#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
  ClientHeight = 322
  ClientWidth = 624
  Color = clBtnFace
  Constraints.MaxHeight = 360
  Constraints.MaxWidth = 640
  Constraints.MinHeight = 360
  Constraints.MinWidth = 640
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
  object chklbxPermissions: TCheckListBox
    Left = 0
    Top = 0
    Width = 624
    Height = 284
    OnClickCheck = chklbxPermissionsClickCheck
    Align = alTop
    ItemHeight = 13
    TabOrder = 0
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 290
    Width = 624
    Height = 32
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      624
      30)
    object btnApply: TButton
      Left = 369
      Top = 5
      Width = 81
      Height = 25
      Cursor = crHandPoint
      Action = actApply
      Anchors = [akTop, akRight]
      TabOrder = 2
    end
    object btnClose: TButton
      Left = 456
      Top = 5
      Width = 81
      Height = 25
      Cursor = crHandPoint
      Action = actClose
      Anchors = [akTop, akRight]
      Cancel = True
      TabOrder = 3
    end
    object btnHelp: TButton
      Left = 543
      Top = 5
      Width = 81
      Height = 25
      Cursor = crHandPoint
      Action = actHelp
      Anchors = [akTop, akRight]
      TabOrder = 4
    end
    object btnSelectAll: TButton
      Left = 0
      Top = 7
      Width = 22
      Height = 22
      Cursor = crHandPoint
      Action = actSelectAll
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Images = ImageList
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btnSelectNone: TButton
      Left = 28
      Top = 7
      Width = 22
      Height = 22
      Cursor = crHandPoint
      Action = actSelectNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Images = ImageList
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
  end
  object ImageList: TImageList
    AllocBy = 3
    Left = 424
    Top = 128
    Bitmap = {
      494C010104002000F00110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005346450053464500534645005346450053464500534645000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000897970007D6E65007463
      5A0073625900736259007362590073625900736259007362590074635A007D6E
      650089797000000000000000000000000000000000000000000000000000B58E
      7B00B5928400F7E3D600EFE3DE00EFE3DE00F7E7DE00F7E3D600BDA69C005346
      45005346450000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000AE7B6E00D9AD9D00D6A89A00D3A6
      9800D2A49700CCA19900C99E9700C69C9600C4999500C1969300B6918B00C094
      8E007E6F66000000000000000000000000000000000000000000BDA69C00F7E7
      DE00FFF3F700E7DBD600DEB29C00D6A68C00E7C7BD00EFEBEF00F7F3F700F7E3
      D600E7CBBD005346450000000000000000000000000084868400CED7D600CED7
      D600CED7D600CED7D600CED7D600CED7D600CED7D600CED7D600CED7D600CED7
      D600CED7D600CED7D600FFFFFF00000000000000000084868400CED7D600CED7
      D600CED7D600CED7D600CED7D600CED7D600CED7D600CED7D600CED7D600CED7
      D600CED7D600CED7D600FFFFFF0000000000B5827200FCE1CB00FBE0C800FBDE
      C400FBDCC2008C5B5A008C5B5A00F3CEB100A2726800A2716500AB796B00FDC6
      A20074635A0000000000000000000000000000000000BDA69C00F7EBE700FFFF
      FF00C68E7300BD5D2900BD5D2900DEB29C00BD5D2900BD5D2900D69E8400F7F3
      F700F7E7DE00D6C7BD005346450000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000BB887500FCE4CF00FCE2CC00FBE0
      C900FBDEC6008C5B5A008C5B5A00EFCFB300FCC99000FDC48500FDCA9800F0BF
      A7007362590000000000000000000000000000000000BDA69C00FFFFFF00CE6D
      4200BD5D2900BD5D2900C6A29400FFFFFF00E7825200BD5D2900BD5D2900D696
      7300FFFBF700F7E3D6005346450000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000C28F7900FCE7D400FCE4D100FCE3
      CE00FCE1CA00FBDFC700EFD2BB00B39C8900775E3F00846B4F009F867200D3AA
      9600705F5600000000000000000000000000BDA69C00FFFBFF00DE9E7B00BD5D
      2900CE653100CE653100CE693900D68A6300CE653100CE653100BD5D2900BD5D
      2900E7CBBD00F7EFEF00DECBC60053464500000000008486840042414200FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000C8957C00FCE8D8002900DF002900
      DF00FCE3CE003C14DD002900DC009373BE00CF8E3C009175720076483600826A
      5F00574A4300000000000000000000000000D6C7BD00FFF7F700C6613100BD5D
      2900CE653100BD5D2900CE866300F7E7DE00D6693900BD5D2900CE653100BD5D
      2900CE714200FFFFFF00E7CBBD0053464500000000008486840042414200FFFF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000CF9C8000FCEBDD002900DF002900
      DF00FCE6D300FCE4CF00FCE2CC00F0D6C5008B8B8300BCA37D00EEB17400B178
      430052341900565251000000000000000000D6C7BD00F7DFD600BD5D2900CE65
      3100CE653100BD5D2900D6825200FFFBFF00E7AE9400BD5D2900BD5D2900CE65
      3100BD5D2900FFEFEF00F7DFD60053464500000000008486840042414200FFFF
      FF000000000000000000FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000D5A28300FDEEE000FDECDD00FCEA
      DB00FCE8D700FCE6D300FCE4D100FBE2CD00FBE1CA00E5C4A100E3AE7D00F9D7
      B600F7C79600B8814B006B6B6B007D7D8700D6C7BD00F7D7CE00CE653100CE65
      3100CE653100CE653100BD5D2900DEAA9400FFF7F700EF9E7300BD5D2900CE65
      3100BD5D2900F7F3EF00EFE3DE0053464500000000008486840042414200FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000DCA98700FEF0E500FDEEE100FDEC
      DF00FDEBDB008C5B5A008C5B5A00F4DBC800A2767100A2767000C9A39400ECBD
      A300B4845700C6AB91005C77D3003D5ABE00D6C7BD00FFEFE700D6693900CE65
      3100CE653100BD5D2900BD5D2900BD5D2900E7CFC600FFFFFF00D6693900CE65
      3100CE693900FFFBFF00F7DFD60053464500000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000DCA98700FDF3EA00FDF1E600FDEF
      E300FDEDDF008C5B5A008C5B5A00FBE4D400E6C9BB00E6C9B800F0D2BF00F3CC
      BA007362590000000000999FCC00ADB1DF00D6C7BD00FFFFFF00F79A6B00D669
      3900CE8E6B00F7EBE700D6825200BD5D2900D6967300FFFFFF00E78E5A00BD5D
      2900EF926300FFFFFF00D6C7BD0053464500000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000DCA98700FDF5ED00FEF3EA00FDF2
      E700FDEFE400FDEDE100FDECDE00FCEADA00FCE8D700FCE6D300FCE4D000F3CD
      BD0078675F0000000000000000000000000000000000D6C7BD00FFEBDE00EF86
      5200E7825200F7F7F700FFFFFF00DEBAAD00FFFFFF00F7F7F700DE714200D671
      3900FFF3EF00F7E7E7005346450000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000DCA98700FEF8F2008C5B5A008C5B
      5A00F3E4DB008C5B5A008C5B5A008C5B5A008C5B5A008C5B5A00E8CDBE00F4C9
      BA008979700000000000000000000000000000000000D6C7BD00FFFFFF00FFEF
      D600FFAA7300EFAA8C00EFE3DE00EFEFEF00F7E7E700FFA67B00F78E5A00F7DB
      CE00FFFFFF00D6C7BD000000000000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000DCA98700FFFAF7008C5B5A008C5B
      5A00FEF4EC00FEF2E900FDF1E600FDEFE200FFD5CC00FFD5CC00F5B3AA00B388
      7E00897970000000000000000000000000000000000000000000D6C7BD00FFFF
      FF00FFFFFF00FFF3C600FFDFAD00FFD39C00FFC79400FFD7AD00FFFFFF00FFFF
      FF00D6C7BD000000000000000000000000000000000084868400424142004241
      4200424142004241420042414200424142004241420042414200424142004241
      420042414200CED7D600FFFFFF00000000000000000084868400424142004241
      4200424142004241420042414200424142004241420042414200424142004241
      420042414200CED7D600FFFFFF0000000000DCA98700FFFDFB00FFFBF700FEF9
      F400FEF7F100FEF5ED00FDF3EB00FDF1E700F7A64300F7A64300E09241009686
      7D0000000000000000000000000000000000000000000000000000000000D6C7
      BD00D6C7BD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFBFF00DECBC600D6C7
      BD00000000000000000000000000000000000000000084868400848684008486
      8400848684008486840084868400848684008486840084868400848684008486
      84008486840084868400FFFFFF00000000000000000084868400848684008486
      8400848684008486840084868400848684008486840084868400848684008486
      84008486840084868400FFFFFF0000000000DCA9870000000000FFFEFB00FFFB
      F800FEFAF500FEF8F100FEF6EE00FDF3EC00DCA98700EAB377008C7463000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DECBC600D6C7BD00D6C7BD00D6C7BD00D6C7BD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DCA98700DCA98700DCA98700DCA9
      8700DCA98700DCA98700DEAB8800D6A38400DCA9870089797000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000F81FFFFFFFFF8007E007800180010007
      C003800180010007800180018001000780018001800100070000800180010007
      0000800180010003000080018001000000008001800100000000800180010004
      000080018001000780018001800100078003800180010007C00780018001000F
      E00F80018001401FF83FFFFFFFFF003F00000000000000000000000000000000
      000000000000}
  end
  object ActionList: TActionList
    Images = ImageList
    Left = 360
    Top = 128
    object actSelectAll: TAction
      Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1074#1089#1077#1093' '#1087#1088#1072#1074' '#1076#1086#1089#1090#1091#1087#1072
      ImageIndex = 1
      OnExecute = actSelectAllExecute
      OnUpdate = actSelectAllUpdate
    end
    object actSelectNone: TAction
      Hint = 
        #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1085#1103#1090#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1089#1086' '#1074#1089#1077#1093' '#1087#1088#1072#1074' '#1076#1086#1089#1090#1091#1087 +
        #1072
      ImageIndex = 2
      OnExecute = actSelectNoneExecute
      OnUpdate = actSelectNoneUpdate
    end
    object actApply: TAction
      Caption = '&'#1055#1088#1080#1084#1077#1085#1080#1090#1100
      Hint = 
        #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1088#1080#1084#1077#1085#1077#1085#1080#1103' '#1085#1086#1074#1086#1075#1086' '#1087#1072#1088#1086#1083#1103' '#1080' '#1079#1072#1082#1088#1099 +
        #1090#1080#1103' '#1086#1082#1085#1072
      OnExecute = actApplyExecute
    end
    object actClose: TAction
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      Hint = 
        #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1084#1077#1085#1099' '#1074#1089#1077#1093' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1080' '#1079#1072#1082#1088#1099 +
        #1090#1080#1103' '#1086#1082#1085#1072
      OnExecute = actCloseExecute
    end
    object actHelp: TAction
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1089#1087#1088#1072#1074#1082#1091'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1089#1087#1088#1072#1074#1086#1095#1085#1086#1075#1086' '#1092#1072#1081#1083#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 0
      OnExecute = actHelpExecute
      OnUpdate = actHelpUpdate
    end
  end
end
