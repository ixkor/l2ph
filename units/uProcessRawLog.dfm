object fProcessRawLog: TfProcessRawLog
  Left = 215
  Top = 168
  Width = 847
  Height = 727
  Caption = #1056#1072#1073#1086#1090#1072' '#1089' RAW '#1083#1086#1075#1086#1084' '#1090#1088#1072#1092#1080#1082#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 839
    Height = 29
    ButtonHeight = 23
    EdgeBorders = [ebTop, ebBottom]
    Images = imgBT
    TabOrder = 0
    object btnOpenRaw: TToolButton
      Left = 0
      Top = 2
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1083#1086#1075' '#1082#1072#1082'..'
      Caption = 'btnOpenRaw'
      ImageIndex = 0
      OnClick = btnOpenRawClick
    end
    object ToolButton1: TToolButton
      Left = 23
      Top = 2
      Width = 14
      Caption = 'ToolButton1'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object btnNoExplode: TToolButton
      Left = 37
      Top = 2
      Hint = #1053#1077' '#1073#1091#1076#1077#1090' '#1088#1072#1089#1082#1083#1077#1080#1074#1072#1090#1100' '#1087#1072#1082#1077#1090#1099' '#1087#1088#1080#1096#1077#1076#1096#1080#1093' '#1086#1076#1085#1080#1084' '#1082#1091#1089#1082#1086#1084' '#1086#1090' '#1089#1077#1088#1074#1077#1088#1072
      Caption = 'btnNoExplode'
      ImageIndex = 1
      Style = tbsCheck
      OnClick = btnNoExplodeClick
    end
    object btnExplode: TToolButton
      Left = 60
      Top = 2
      Hint = #1041#1091#1076#1077#1090' '#1088#1072#1079#1073#1080#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1085#1072' '#1087#1072#1082#1077#1090#1099' ('#1087#1099#1090#1072#1090#1089#1103')'
      Caption = 'btnExplode'
      Down = True
      ImageIndex = 2
      Style = tbsCheck
      OnClick = btnExplodeClick
    end
    object btnDecrypt: TToolButton
      Left = 83
      Top = 2
      Hint = #1055#1086#1087#1099#1090#1072#1090#1100#1089#1103' '#1076#1077#1082#1088#1080#1087#1090#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1081' Raw '#1083#1086#1075
      Caption = 'btnDecrypt'
      Down = True
      ImageIndex = 3
      Style = tbsCheck
      OnClick = btnDecryptClick
    end
    object ToolButton3: TToolButton
      Left = 106
      Top = 2
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object ToolButton2: TToolButton
      Left = 114
      Top = 2
      Caption = 'ToolButton2'
      ImageIndex = 7
      OnClick = ToolButton2Click
    end
    object ToolButton6: TToolButton
      Left = 137
      Top = 2
      Width = 18
      Caption = 'ToolButton6'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object btnShowDirrection: TToolButton
      Left = 155
      Top = 2
      Caption = 'btnShowDirrection'
      ImageIndex = 6
      Style = tbsCheck
      OnClick = btnShowDirrectionClick
    end
    object btnShowTimeStamp: TToolButton
      Left = 178
      Top = 2
      Caption = 'btnShowTimeStamp'
      ImageIndex = 5
      Style = tbsCheck
      OnClick = btnShowDirrectionClick
    end
    object ToolButton15: TToolButton
      Left = 201
      Top = 2
      Width = 11
      Caption = 'ToolButton15'
      ImageIndex = 16
      Style = tbsSeparator
    end
    object btnUseLib: TToolButton
      Left = 212
      Top = 2
      Hint = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1076#1088#1091#1075#1091#1102' '#1073#1080#1073#1083#1080#1086#1090#1077#1082#1091' '#1076#1083#1103' '#1076#1077#1082#1088#1080#1087#1090#1086#1074#1082#1080
      Caption = 'btnUseLib'
      ImageIndex = 4
      Style = tbsCheck
      OnClick = btnUseLibClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 29
    Width = 839
    Height = 664
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #1058#1077#1082#1091#1097#1077#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077
      OnResize = TabSheet1Resize
      object memo1: TJvRichEdit
        Left = 0
        Top = 0
        Width = 831
        Height = 636
        Hint = #1054#1082#1085#1086' '#1087#1086#1076#1088#1086#1073#1085#1086#1081' '#1088#1072#1089#1096#1080#1092#1088#1086#1074#1082#1080' '#1087#1072#1082#1077#1090#1072
        AdvancedTypography = False
        Align = alClient
        AutoAdvancedTypography = False
        AutoSize = False
        AutoURLDetect = False
        AutoVerbMenu = False
        AllowObjects = False
        ClipboardCommands = [caCopy, caClear, caUndo]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ForceUndo = False
        HideScrollBars = False
        LangOptions = []
        ParentFont = False
        ReadOnly = True
        SelectionBar = False
        TabOrder = 0
        UndoLimit = 0
        WantReturns = False
        WordWrap = False
      end
      object waitbar: TPanel
        Left = 160
        Top = 248
        Width = 456
        Height = 46
        TabOrder = 1
        Visible = False
        object Label3: TLabel
          Left = 1
          Top = 1
          Width = 454
          Height = 13
          Align = alTop
          Caption = #1063#1080#1090#1072#1077#1090#1089#1103' '#1080' '#1092#1086#1088#1084#1072#1090#1080#1088#1091#1077#1090#1089#1103' RAW '#1083#1086#1075'..'
        end
        object ProgressBar1: TProgressBar
          Left = 1
          Top = 14
          Width = 454
          Height = 31
          Align = alClient
          TabOrder = 0
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1056#1072#1079#1073#1086#1088
      ImageIndex = 2
    end
    object TabSheet2: TTabSheet
      Caption = #1051#1086#1075' '#1087#1088#1086#1074#1077#1088#1082#1080
      ImageIndex = 1
      object JvRichEdit1: TJvRichEdit
        Left = 0
        Top = 0
        Width = 831
        Height = 636
        Hint = #1054#1082#1085#1086' '#1087#1086#1076#1088#1086#1073#1085#1086#1081' '#1088#1072#1089#1096#1080#1092#1088#1086#1074#1082#1080' '#1087#1072#1082#1077#1090#1072
        AdvancedTypography = False
        Align = alClient
        AutoAdvancedTypography = False
        AutoSize = False
        AutoURLDetect = False
        AutoVerbMenu = False
        AllowObjects = False
        ClipboardCommands = [caCopy, caClear, caUndo]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ForceUndo = False
        HideScrollBars = False
        LangOptions = []
        ParentFont = False
        ReadOnly = True
        SelectionBar = False
        TabOrder = 0
        UndoLimit = 0
        WantReturns = False
        WordWrap = False
      end
    end
  end
  object imgBT: TImageList
    Left = 432
    Top = 64
    Bitmap = {
      494C010108000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5636B00A563
      6B00A5636B00A5636B00A5636B00A5636B00A5636B00A5636B00A5636B00A563
      6B00A5636B00A5636B00A5636B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9392009B9591009B9591009B9591009C939200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000219FE000219FE000219FE000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5636B00FFEF
      C600C6CE9400D6CE9400EFCE9C00E7CE9400EFC68400EFBD8400EFBD7B00EFBD
      8400EFBD8400EFC68400A5636B00000000000000000000000000000000008484
      84009C9C9C00737373006363630073737300ADADAD00B5B5B500BDBDBD00A5A5
      A500848484008484840000000000000000000000000000000000000000009C94
      92009B959100BEB5B300F0E3E300F0E3E300F0E3E300BEB5B3009B9591009C94
      920000000000000000000000000000000000000000000000000000000000219F
      E00054E0FF004EDFFF0049DFFF00219FE0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5636B00FFEF
      CE009CBD7300299C21006BAD4A0021941000219410005AA53900CEB57300EFBD
      7B00EFBD7B00EFC68400A5636B00000000000000000000000000000000004A4A
      4A00BDBDBD0084848400636363007B7B7B00A5A5A500BDBDBD00D6D6D600C6C6
      C600ADADAD009C9C9C00000000000000000000000000000000009B959100BEB5
      B300F0E3E300F0E3E300BAA89A00BAA89A00BAA89A00F0E3E300F0E3E300BEB5
      B3009B9591000000000000000000000000000000000000000000219FE00063E3
      FF005BE1FF0054E0FF004EDFFF0049DFFF00219FE00000000000000000000000
      0000000000000000000000000000000000000000000000000000A5635A00FFEF
      DE00BDCE9C00108C08000084000000840000008400000084000029941800DEBD
      7B00EFBD7B00EFC68400A5636B00000000000000000000000000000000004242
      4200BDBDBD008484840063636300737373000842630008426300D6D6D600C6C6
      C600ADADAD009C9C9C000000000000000000000000009C949200BEB5B300F0E3
      E300BAA89A00BAA89A00E8E9E800E8E9E800E8E9E800BAA89A00BAA89A00F0E3
      E300BEB5B3009C949200000000000000000000000000219FE00074E5FF006BE4
      FF0063E3FF005BE1FF0054E0FF004EDFFF0049DFFF00219FE000000000000000
      0000000000000000000000000000000000000000000000000000A5635A00FFF7
      E700BDCE9C00189410000084000018941000ADBD730073AD4A000084000073AD
      4A00EFBD8400EFC68400A5636B00000000000000000000000000000000004A4A
      4A00BDBDBD0084848400636363007B7B7B008CF7FF00ADCEE70008426300C6C6
      C600A5A5A500949494000000000000000000000000009B959100F0E3E300BAA8
      9A00EAEBEA00EAEBEA00EAEBEA00EAEBEA00EAEBEA00EAEBEA00EAEBEA00BAA8
      9A00F0E3E3009B9591000000000000000000219FE00085E7FF007CE6FF0074E5
      FF006BE4FF0063E3FF005BE1FF0054E0FF004EDFFF0049DFFF00219FE0000000
      0000000000000000000000000000000000000000000000000000A5736B00FFF7
      EF00BDD6A500088C0800008400000084000084B55A00EFCEA500A5B56B006BAD
      4A00EFC68C00EFC68400A5636B00000000000000000000000000000000004A4A
      4A00A5A5A500737373005A5A5A0073737300ADCEE7008CF7FF00ADCEE7000842
      6300848484008484840000000000000000009C939200BEB5B300F0E3E300BAA8
      9A00EEEFEE00EEEFEE00EEEFEE00EEEFEE00EEEFEE00EEEFEE00EEEFEE00BAA8
      9A00F0E3E300BEB5B3009C93920000000000219FE0008EE9FF0085E7FF007CE6
      FF0074E5FF006BE4FF0063E3FF005BE1FF0054E0FF004EDFFF0049DFFF00219F
      E000000000000000000000000000000000000000000000000000A5736B00FFFF
      FF00E7E7D600A5CE94009CC6840094BD73009CBD7300EFD6AD00EFCEA5009CC6
      7B00EFC69400EFC68C00A5636B00000000000000000000000000000000004242
      4200BDBDBD00848484006363630073737300A5A5A500ADCEE7008CF7FF00ADCE
      E700084263009C9C9C0000000000000000009B959100F0E3E300BAA89A00F2F2
      F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2
      F200BAA89A00F0E3E3009B95910000000000219FE0009EF2FF009AF5FF0085E7
      FF007CE6FF0074E5FF006BE4FF0063E3FF005BE1FF0054E0FF004EDFFF0049DF
      FF00219FE0000000000000000000000000000000000000000000BD846B00FFFF
      FF00A5DEA500FFEFE700F7EFD6009CC6840094BD730094BD73009CBD7300EFCE
      A500EFCE9C00F7CE9400A5636B00000000000000000000000000000000004242
      4200BDBDBD008C848C0063636B007B737300A5A5A500B5B5B500ADCEE7008CF7
      FF004ABDFF008CF7FF004ABDFF00000000009B959100F0E3E300BAA89A00F6F6
      F600F6F6F600F6F6F600F6F6F600928780009287800092878000F6F6F600F6F6
      F600BAA89A00F0E3E3009B9591000000000000000000219FE000A9FEFF009AF5
      FF0085E7FF007CE6FF0074E5FF006BE4FF0063E3FF005BE1FF0054E0FF004EDF
      FF0049DFFF00219FE00000000000000000000000000000000000BD846B00FFFF
      FF0073C67300ADD6A500FFEFE70084C673000084000000840000088C0800EFD6
      AD00EFCEA500F7D6A500A5636B00000000000000000000000000000000004242
      4200BDBDBD008C848C00636363007B7B7B00A5A5A500B5B5B500084263008CF7
      FF008CF7FF008CF7FF008CF7FF004ABDFF009B959100F0E3E300BAA89A00FAFA
      FA00FAFAFA00FAFAFA00FAFAFA0092878000FAFAFA00FAFAFA00FAFAFA00FAFA
      FA00BAA89A00F0E3E3009B959100000000000000000000000000219FE000ABFF
      FF009AF5FF0085E7FF007CE6FF0074E5FF006BE4FF006AEAFF0062E8FF005BE7
      FF004EDFFF0049DFFF00219FE000000000000000000000000000D6946B00FFFF
      FF0084CE8400008400007BC67300ADD6A5001894180000840000108C0800F7D6
      B500F7D6AD00EFCEA500A5636B00000000000000000000000000000000005242
      4A00A5A5A500737373006363630073737300A5A5A500B5B5B500CECECE00ADCE
      E7008CF7FF00299CEF008CF7FF008CF7FF009C939200BEB5B300F0E3E300BAA8
      9A00FDFDFD00FDFDFD00FDFDFD0092878000FDFDFD00FDFDFD00FEFEFE00BAA8
      9A00F0E3E300BEB5B3009C93920000000000000000000000000000000000219F
      E000ABFFFF009AF5FF0085E7FF007CE6FF0080F1FF0081FAFF0051CEEF0071F7
      FF0060ECFF004EDFFF00219FE000000000000000000000000000D6946B00FFFF
      FF00F7F7EF0029A5290000840000008400000084000000840000108C0800FFEF
      CE00DECEB500B5AD9400A5636B00000000000000000000000000000000005242
      4A00BDBDBD008C848C006B63630073737300A5A5A500ADADAD00CECECE00C6C6
      C600ADCEE7008CF7FF008CF7FF004ABDFF00000000009B959100F0E3E300BAA8
      9A00FFFFFF00FFFFFF00FFFFFF0092878000FFFFFF00FFFFFF00FFFFFF00BAA8
      9A00F0E3E3009B95910000000000000000000000000000000000000000000000
      0000219FE000ABFFFF009AF5FF0085E7FF0086F0FF0022A0E000219FE000219F
      E00065EBFF0054E0FF00219FE000000000000000000000000000DE9C7300FFFF
      FF00FFFFFF00DEF7DE0063BD6300219C2100219C210073BD6B00299C2100946B
      5200A56B5A00A56B5A00A5636B00000000000000000000000000000000005242
      4A00BDBDBD008C848C0063635A006B736B009C9C9C00ADADAD00CECECE00BDBD
      BD00A5A5A500ADCEE7004ABDFF0000000000000000009C949200BEB5B300F0E3
      E300BAA89A00BAA89A00FFFFFF00FFFFFF00FFFFFF00BAA89A00BAA89A00F0E3
      E300BEB5B3009C94920000000000000000000000000000000000000000000000
      000000000000219FE000ABFFFF009AF5FF0085E7FF0022A0E000219FE00022A0
      E00063E3FF005BE1FF00219FE000000000000000000000000000DE9C7300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DEF7DE00DEF7DE00FFFFF700ADB594008C6B
      5200E79C5200E78C3100B56B4A00000000000000000000000000000000005242
      4A00A5A5A50073737300635A6B006B736B0094949400ADADAD00CECECE00BDBD
      BD00A5A5A5008C8C8C00000000000000000000000000000000009B959100BEB5
      B300F0E3E300F0E3E300BAA89A00BAA89A00BAA89A00F0E3E300F0E3E300BEB5
      B3009B9591000000000000000000000000000000000000000000000000000000
      00000000000000000000219FE000A9FEFF008EE9FF0085E7FF004DC2EF0074E5
      FF006BE4FF006BEBFF00219FE000000000000000000000000000E7AD7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEC6C600A56B
      5A00FFB55A00BD7B5A0000000000000000000000000000000000000000004A52
      4A00ADADB5008C8C8C009CA59400A5A5A500A5A5A500A5A5A500ADADAD00A5A5
      A5008C8C8C007B7B7B0000000000000000000000000000000000000000009C94
      92009B959100BEB5B300F0E3E300F0E3E300F0E3E300BEB5B3009B9591009C94
      9200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000219FE000B3FEFF00AAFFFF00A1FFFF0098FF
      FF0093FFFF00219FE00000000000000000000000000000000000E7AD7B00F7F7
      EF00F7F7EF00F7F7EF00F7F7EF00F7F7EF00F7F7EF00F7F7EF00DEC6C600A56B
      5A00BD846B000000000000000000000000000000000000000000000000000000
      00008C847B007B737B00736B730073737B007373730073737300737373007B7B
      7B00848484000000000000000000000000000000000000000000000000000000
      0000000000009C9392009B9591009B9591009B9591009C939200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000219FE000219FE000219FE000219F
      E000219FE0000000000000000000000000000000000000000000E7AD7B00D694
      6B00D6946B00D6946B00D6946B00D6946B00D6946B00D6946B00D6946B00A56B
      5A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5848400B584
      8400B5848400B5848400B5848400B5848400B5848400B5848400B5848400B584
      8400B5848400B5848400B5848400000000000000000000000000C6A59C00FFF7
      E700FFF7E700FFF7E700F7E7D600F7E7CE00F7E7CE00F7DEC600F7DEC600F7DE
      B500F7D6AD00EFCE9C00B5848400000000000000000000000000B5848400B584
      8400B5848400B5848400B5848400B5848400B5848400B5848400B5848400B584
      8400B5848400B5848400A5A5A500424242000000000029ADD60031B5DE0021AD
      D600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6A59C00FFEF
      D600F7E7C600F7DEBD00F7DEB500F7D6AD00F7D6A500EFCE9C00EFCE9400EFCE
      9400EFCE9400F7D69C00B5848400000000000000000000000000C6A59C00FFF7
      E700F7E7D600F7E7D600F7E7CE00F7E7CE00F7DEC600F7DEC600F7DEB500F7D6
      AD00EFCE9C00EFCE9C00B5848400000000000000000000000000C6A59C00FFEF
      D600F7E7C600F7DEBD00F7DEB500F7D6AD00F7D6A500EFCE9C00EFCE9400EFCE
      9400EFCE9400ADADAD005A5A5A00C6C6C6000000000029ADD6009CDEEF0084EF
      FF004AC6E70021ADD60018A5C60018A5C60018A5C60000000000000000000000
      0000000000000000000000000000000000000000000000000000C6A59C00FFEF
      D600C6A59C00C6A59C00C6A59C00C6A59C00C6A59C00C6A59C00C6A59C00C6A5
      9C00C6A59C00EFCE9C00B5848400000000000000000000000000C6ADA500FFF7
      E700F7E7D600F7E7CE00F7E7C600F7DEC600F7DEB500F7D6B500F7D6AD00EFCE
      9C00EFCE9C00EFCE9400B5848400000000000000000000000000C6A59C00FFEF
      D600F7E7CE00F7DEC600F7DEBD00F7D6B500F7D6A500EFCE9C00EFCE9C00EFCE
      9400BDBDBD006B6B6B00C6C6C600848484000000000029ADD60052BDE7009CFF
      FF0094FFFF0073DEF70073DEF70073DEF70073DEF7004AC6E70021ADD60018A5
      C600000000000000000000000000000000000000000000000000C6ADA500FFEF
      E700F7E7D600F7E7CE00F7DEC600F7DEBD00F7D6B500F7D6AD00EFCE9C00EFCE
      9C00EFCE9400EFCE9C00B5848400000000000000000000000000C6ADA500FFF7
      E700F7E7D600F7E7CE00F7DEC600F7DEBD00F7D6B500F7D6AD00EFCE9C00EFCE
      9C00EFCE9400EFCE9C00B5848400000000000000000000000000C6ADA500FFEF
      E700AD6B5A00AD6B5A00AD6B5A009C9C9C009C9C9C009C9C9C009C9C9C00AD6B
      5A006B6B6B00181818006B6B6B00524A4A000000000029ADD60052BDE700ADFF
      FF008CF7FF008CEFFF008CEFFF008CEFFF0073DEF70073DEF70073DEF7004AC6
      EF0021ADD6000000000000000000000000000000000000000000C6ADA500FFF7
      E700F7E7D600F7E7CE00F7E7C600F7DEC600F7DEB500F7D6B500F7D6AD00EFCE
      9C00EFCE9C00EFCE9400B5848400000000000000000000000000C6A59C00FFEF
      D600F7E7CE00F7DEC600F7DEBD00F7D6B500F7D6A500EFCE9C00EFCE9C00EFCE
      9400EFCE9400EFCE9C00B5848400000000000000000000000000C6ADA500FFF7
      E700F7E7D600F7E7CE00BDBDBD004A4A4A00524A4A004A4A4A0052525200A5A5
      A500393939006B6B6B00BDBDBD00000000000000000029ADD60029ADD600ADDE
      EF0094F7FF0094F7FF008CEFFF008CEFFF008CEFFF008CEFFF0073DEF70073DE
      F7004AC6EF000000000000000000000000000000000000000000CEB5AD00FFFF
      F700C6A59C00C6A59C00C6A59C00C6A59C00C6A59C00C6A59C00C6A59C00C6A5
      9C00C6A59C00EFCE9C00B584840000000000005A000000000000C6A59C00FFEF
      D600F7E7C600F7DEBD00F7DEB500F7D6AD00F7D6A500EFCE9C00EFCE9400EFCE
      9400EFCE9400F7D69C00B5848400000000000000000000000000CEB5AD00FFFF
      F700AD6B5A0094949C0042393900AD6B5A00AD6B5A00AD6B5A00AD6B5A004239
      39006B6B6B00DEDED600B5848400000000000000000029ADD60073DEF70029AD
      D6009CFFFF008CF7FF008CF7FF008CF7FF008CEFFF008CEFFF008CEFFF0073DE
      F70073DEF70018A5C60000000000000000000000000000000000D6B5AD00FFFF
      FF00FFF7EF00FFEFE700F7E7D600F7E7CE00F7E7C600F7DEC600F7DEBD00F7D6
      AD00F7D6A500F7D6A500B58484000000000000730800005A0000B5848400B584
      8400B5848400B5848400B5848400B5848400B5848400B5848400B5848400B584
      8400B5848400B5848400B5848400000000000000000000000000D6B5AD00FFFF
      FF00A5A59C0042393900B5847300AD6B5A00AD6B5A00AD6B5A00AD6B5A00B584
      730042393900C6C6C600B5848400000000000000000029ADD60094F7FF0029AD
      D600ADDEEF00A5EFF700A5EFF700A5F7FF008CEFFF008CEFFF008CEFFF0073DE
      F7000073080018A5C60000000000000000000000000000000000D6BDB500FFFF
      FF00FFF7F700FFF7EF00FFEFDE00F7E7D600F7E7CE00F7E7C600F7DEC600F7DE
      BD00F7D6B500F7D6AD00B5848400000000000073080000730800005A00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6BDB500A5A5
      9C006B6B6B00C6B59400FFE7D600EFC6AD00F7D6AD00F7D6AD00E7C69C00F7E7
      CE009C8C730042393900B5848400000000000000000029ADD6009CFFFF0073DE
      F70029ADD60018A5C60018A5C60018A5C600ADDEEF008CF7FF0084EFFF000073
      08005AE78C000073080018A5C600000000000000000000000000D6BDB500FFFF
      FF00C6A59C00C6A59C00C6A59C00C6A59C00C6A59C00C6A59C00C6A59C00C6A5
      9C00C6A59C00F7DEB500B58484000000000008841000008C0800008C08000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6BDB500A5A5
      9C006B6B6B00D6BDA500AD6B5A00AD6B5A00AD6B5A00AD6B5A00AD6B5A00AD6B
      5A00AD9C8C0042393900B5848400000000000000000029ADD6009CFFFF0094F7
      FF0073DEF70073DEF70073DEF7006BDEF70029ADD600ADDEEF000073080052D6
      7B0042D66B0031C64A0000730800000000000000000000000000DEBDB500FFFF
      FF00FFFFFF00FFFFFF00FFF7F700FFEFE700FFEFDE00F7E7D600F7E7CE00F7DE
      C600F7DEC600F7D6B500B584840000000000008C0800008C0800B5848400B584
      8400B5848400B5848400B5848400B5848400B5848400B5848400B5848400B584
      8400B5848400B5848400B5848400000000000000000000000000DEBDB500A5A5
      9C006B6B6B00C6BDA500B5847300B5847300AD6B5A00AD6B5A00AD6B5A00AD6B
      5A00A5947B0042393900B5848400000000000000000029ADD6009CFFFF0094F7
      FF0094F7FF0094F7FF0094F7FF0073DEF70073DEF70029ADD60018A5C600108C
      210031C64A00109C210018A5C600000000000000000000000000DEC6B500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFEFE700FFEFDE00FFEFDE00FFEF
      D600E7DEC600C6BDAD00B584840000000000008C080000000000C6A59C00FFEF
      D600F7E7C600F7DEBD00F7DEB500F7D6AD00F7D6A500EFCE9C00EFCE9400EFCE
      9400EFCE9400F7D69C00B5848400000000000000000000000000DEC6B500FFFF
      FF00A5A59C006B6B6B00FFD6AD00FFE7D600F7FFFF00FFFFF700FFDED600FFD6
      B50042393900A5A5A500B5848400000000000000000029ADD600C6FFFF0094FF
      FF009CFFFF00D6FFFF00D6FFFF008CEFFF0094EFFF0073DEF70073DEF7000884
      100018AD29000884100000000000000000000000000000000000E7C6B500FFFF
      FF00C6A59C00C6A59C00C6A59C00C6A59C00C6A59C00FFF7EF00F7E7D600C6A5
      9400B5948C00B58C8400B5848400000000000000000000000000C6A59C00FFEF
      D600F7E7CE00F7DEC600F7DEBD00F7D6B500F7D6A500EFCE9C00EFCE9C00EFCE
      9400EFCE9400EFCE9C00B5848400000000000000000000000000E7C6B500FFFF
      FF00FFFFFF00A5A59C006B6B6B00F7D6AD00AD6B5A00AD6B5A00EFD6A5004239
      3900BDBDBD00B58C8400B5848400000000000000000021ADD6009CDEEF00C6FF
      FF00C6FFFF009CDEEF0018ADD60018A5C60018A5C60018A5C60018A5C600088C
      100008A518000000000000000000000000000000000000000000E7C6B500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700E7CECE00BD8C
      7300EFB57300EFA54A00C6846B00000000000000000000000000C6ADA500FFF7
      E700F7E7D600F7E7CE00F7DEC600F7DEBD00F7D6B500F7D6AD00EFCE9C00EFCE
      9C00EFCE9400EFCE9C00B5848400000000000000000000000000E7C6B500FFFF
      FF00AD6B5A00AD6B5A00A5A59C006B6B6B006B6B6B006B6B6B006B6B6B00A5A5
      9C00EFB57300EFA54A00C6846B0000000000000000000000000031B5DE0029AD
      D60018A5C60018A5C60000000000000000000000000000000000088C100008A5
      1800088410000000000000000000000000000000000000000000EFCEBD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7D6CE00C694
      7B00FFC67300CE94730000000000000000000000000000000000C6ADA500FFF7
      E700F7E7D600F7E7CE00F7E7C600F7DEC600F7DEB500F7D6B500F7D6AD00EFCE
      9C00EFCE9C00EFCE9400B5848400000000000000000000000000EFCEBD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A5A59C00A5A59C00A5A59C00A5A59C00C694
      7B00FFC67300CE94730000000000000000000000000000000000000000000000
      000000000000000000000000000000730800087B0800088C1000088C1000087B
      0800000000000000000000000000000000000000000000000000E7C6B500FFF7
      F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00E7CECE00C694
      7B00CE9C84000000000000000000000000000000000000000000C6A59C00FFF7
      E700FFF7E700F7E7D600F7E7CE00F7E7CE00F7DEC600F7DEC600F7DEB500F7D6
      AD00EFCE9C00EFCE9C00B5848400000000000000000000000000E7C6B500FFF7
      F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00E7CECE00C694
      7B00CE9C84000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7C6B500EFCE
      B500EFCEB500EFCEB500EFCEB500E7C6B500E7C6B500EFCEB500D6BDB500BD84
      7B00000000000000000000000000000000000000000000000000C6A59C00FFF7
      E700FFF7E700FFF7E700F7E7D600F7E7CE00F7E7CE00F7DEC600F7DEC600F7DE
      B500F7D6AD00EFCE9C00B5848400000000000000000000000000E7C6B500EFCE
      B500EFCEB500EFCEB500EFCEB500E7C6B500E7C6B500EFCEB500D6BDB500BD84
      7B0000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFC001FFFFF83FF1FFC001
      E003E00FE0FFC001E003C007C07FC001E0038003803FC001E0038003001FC001
      E0030001000FC001E00300010007C001E00100018003C001E0000001C001C001
      E0000001E001C001E0008003F001C001E0018003F801C001E003C007FC01C003
      E003E00FFE03C007F007F83FFF07C00FFFFFC001C001C0008FFFC001C001C000
      807FC001C001C000800FC001C001C0008007C001C001C0018007C0014001C001
      8003C0010001C0018003C0011FFFC0018001C0011FFFC0018001C0010001C001
      8001C0014001C0018003C001C001C0018007C001C001C001C3C7C003C001C003
      FE0FC007C001C007FFFFC00FC001C00F00000000000000000000000000000000
      000000000000}
  end
  object dlgOpenRawLog: TOpenDialog
    DefaultExt = '*.rawLog'
    Filter = 'Raw '#1083#1086#1075' '#1087#1072#1082#1077#1090#1086#1074' (*.rawLog)|*.rawLog|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 391
    Top = 65
  end
  object dlgOpenDll: TOpenDialog
    DefaultExt = '*.Dll'
    Filter = 'Dll '#1092#1072#1081#1083' (*.Dll)|*.Dll|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 391
    Top = 97
  end
end
