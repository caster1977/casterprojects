object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'LogKeeper'
  ClientHeight = 283
  ClientWidth = 794
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
  object imState: TImage
    Left = 2
    Top = 267
    Width = 16
    Height = 16
    Hint = #1048#1085#1076#1080#1082#1072#1090#1086#1088' '#1075#1086#1090#1086#1074#1085#1086#1089#1090#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' '
    AutoSize = True
    Constraints.MaxHeight = 16
    Constraints.MaxWidth = 16
    Constraints.MinHeight = 16
    Constraints.MinWidth = 16
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 263
    Width = 794
    Height = 20
    Hint = #1069#1090#1086' '#1087#1072#1085#1077#1083#1100' '#1089#1090#1072#1090#1091#1089#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
    Panels = <
      item
        Width = 20
      end
      item
        Width = 100
      end
      item
        Text = #1057#1086#1086#1073#1097#1077#1085#1080#1081':'
        Width = 0
      end
      item
        Text = #1055#1088#1086#1090#1086#1082#1086#1083': '
        Width = 0
      end
      item
        Width = 50
      end>
  end
  object pbMain: TProgressBar
    Left = 21
    Top = 265
    Width = 98
    Height = 17
    Hint = #1048#1085#1076#1080#1082#1072#1090#1086#1088' '#1087#1088#1086#1075#1088#1077#1089#1089#1072' '#1074#1099#1087#1086#1083#1085#1103#1077#1084#1086#1081' '#1086#1087#1077#1088#1072#1094#1080#1080
    Constraints.MaxHeight = 17
    Constraints.MaxWidth = 98
    Constraints.MinHeight = 17
    Constraints.MinWidth = 98
    Step = 1
    TabOrder = 1
  end
  object Log: TLogProvider
    Enabled = True
    LogFile.Enabled = True
    LogFile.FileNameSuffix = 'LogKeeper_MainForm'
    LogClient.Enabled = True
    Left = 16
    Top = 16
  end
  object ilMainFormStateIcons: TImageList
    AllocBy = 2
    Left = 48
    Top = 16
    Bitmap = {
      494C010102000400000310001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000052517B004241730039386B003938730039387300525173000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005279520042714200396939003971390039713900527152000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B69
      8C00425194006B86C60094B6E700A5CFEF0094BEE70094BEE700738EC6004A51
      9400525173000000000000000000000000000000000000000000000000006B8E
      6B00429642006BC76B0094E79400A5EFA50094E7940094E7940073C773004A96
      4A00527152000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000737194004A59
      A50084AEEF009CCFF700ADD7F700B5DFFF00ADD7FF00ADD7FF009CCFF7008CB6
      EF004A59A5005251730000000000000000000000000000000000739673004AA6
      4A0084EF84009CF79C00ADF7AD00B5FFB500ADFFB500ADFFB5009CF79C008CEF
      8C004AA64A005271520000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000039418C006B96
      E70084B6EF0094BEF700A5CFF700ADCFF700A5CFF700A5CFF70094BEF70084B6
      EF00739EE70042498C0000000000000000000000000000000000398E39006BE7
      6B0084EF840094F79400A5F7AD00ADF7AD00A5F7AD00A5F7AD0094F7940084EF
      840073E77300428E420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B6994004A59BD006B96
      E7007BA6EF0084AEEF008CB6F70094B6F7008CB6F7008CB6F70084AEEF007B9E
      EF006B96E7004A59B5004A49730000000000000000006B966B004ABE4A006BE7
      6B007BEF7B0084EF84008CF78C0094F794008CF78C008CF78C0084EF84007BEF
      7B006BE76B004AB64A004A714A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004A497B004A61CE006386
      E7006B8EEF007396EF00739EF700739EEF00739EEF00739EEF006B96EF006B8E
      E7006379DE004A61CE003938730000000000000000004A794A004ACF4A0063E7
      63006BEF6B0073EF730073F7730073EF730073EF730073EF73006BEF6B006BE7
      6B0063DF63004ACF4A0039713900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004A497B004A61CE006386
      E7006B8EEF007396EF00739EF700739EEF00739EEF00739EEF006B96EF006B8E
      E7006379DE004A61CE003938730000000000000000004A794A004ACF4A0063E7
      63006BEF6B0073EF730073F7730073EF730073EF730073EF73006BEF6B006BE7
      6B0063DF63004ACF4A0039713900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000424173004251D6004A61
      E7005271EF005A71EF005A79EF006379EF005A79EF005A79EF005A71E7005269
      DE004A61DE004251CE0039386B0000000000000000004271420042D742004AE7
      4A0052EF52005AEF5A005AEF5A0063EF63005AEF5A005AEF5A005AE75A0052DF
      52004ADF4A0042CF420039693900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004A497B002930C6002930
      DE003138EF003141EF003941EF003941EF003141E7003141E7003141DE002938
      D6002930CE002930BD004241730000000000000000004A794A0029C7290029DF
      290031EF310031EF310039EF390039EF390031E7310031E7310031DF310029D7
      290029CF290029BE290042714200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073719C002118B5001010
      D6001010E7001810EF001818EF001818EF001810DE001810DE001810D6001010
      C6001010BD001818A50052517B000000000000000000739E730018B6180010D7
      100010E7100010EF100018EF180018EF180010DF100010DF100010D7100010C7
      100010BE100018A6180052795200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000039388C004241
      DE005251E7006359EF006359F7006361EF006361EF006361EF005A59DE005A51
      D6004A49CE0039388C0000000000000000000000000000000000398E390042DF
      420052E752005AEF5A005AF75A0063EF630063EF630063EF63005ADF5A0052D7
      52004ACF4A00398E390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008486A5005A51
      A5009C9EEF00B5B6F700B5B6F700BDB6F700B5B6F700B5B6F700B5B6EF00A5A6
      E7005A59A5006B698C000000000000000000000000000000000084A6840052A6
      52009CEF9C00B5F7B500B5F7B500B5F7BD00B5F7B500B5F7B500B5EFB500A5E7
      A5005AA65A006B8E6B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008486
      A50063619400ADAECE00CECFE700DEDFF700CECFE700CECFE700ADAECE006361
      94007371940000000000000000000000000000000000000000000000000084A6
      840063966300ADCFAD00CEE7CE00DEF7DE00CEE7CE00CEE7CE00ADCFAD006396
      6300739673000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000073719C004A498400424173004A497B004A497B006B6994000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000739E73004A864A00427142004A794A004A794A006B966B000000
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
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000F81FF81F00000000
      E007E00700000000C003C00300000000C003C003000000008001800100000000
      8001800100000000800180010000000080018001000000008001800100000000
      8001800100000000C003C00300000000C003C00300000000E007E00700000000
      F81FF81F00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 80
    Top = 16
  end
end
