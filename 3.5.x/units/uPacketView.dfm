object fPacketView: TfPacketView
  Left = 0
  Top = 0
  Width = 435
  Height = 266
  Align = alClient
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  TabStop = True
  object Splitter1: TSplitter
    Left = 0
    Top = 185
    Width = 435
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 435
    Height = 13
    Align = alTop
    Caption = #1055#1072#1082#1077#1090':'
  end
  object rvHEX: TRichView
    Left = 0
    Top = 13
    Width = 435
    Height = 172
    Align = alTop
    TabOrder = 0
    OnMouseMove = rvHEXMouseMove
    DocParameters.LeftMargin = 4.000000000000000000
    DocParameters.RightMargin = 4.000000000000000000
    DocParameters.TopMargin = 4.000000000000000000
    DoInPaletteMode = rvpaCreateCopies
    Options = [rvoAllowSelection, rvoShowPageBreaks, rvoAutoCopyText, rvoAutoCopyRVF, rvoAutoCopyImage, rvoAutoCopyRTF, rvoFormatInvalidate, rvoDblClickSelectsWord, rvoRClickDeselects, rvoFastFormatting]
    RTFReadProperties.TextStyleMode = rvrsAddIfNeeded
    RTFReadProperties.ParaStyleMode = rvrsAddIfNeeded
    RVFOptions = [rvfoSavePicturesBody, rvfoSaveControlsBody, rvfoConvUnknownStylesToZero, rvfoSaveBinary, rvfoSaveTextStyles, rvfoSaveParaStyles, rvfoSaveDocProperties, rvfoLoadDocProperties]
    Style = RVStyle1
    OnRVMouseUp = rvHEXRVMouseUp
    OnSelect = rvHEXSelect
  end
  object Panel1: TPanel
    Left = 0
    Top = 188
    Width = 435
    Height = 78
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Label2: TLabel
      Left = 0
      Top = 0
      Width = 435
      Height = 13
      Align = alTop
      Caption = #1044#1077#1090#1072#1083#1100#1085#1072#1103' '#1088#1072#1089#1096#1080#1092#1088#1086#1074#1082#1072':'
    end
    object Splitter2: TSplitter
      Left = 0
      Top = 23
      Width = 435
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      Visible = False
    end
    object rvFuncs: TRichView
      Left = 0
      Top = 26
      Width = 435
      Height = 52
      Align = alBottom
      PopupMenu = PopupMenu1
      TabOrder = 0
      Visible = False
      DocParameters.LeftMargin = 4.000000000000000000
      DocParameters.RightMargin = 4.000000000000000000
      DocParameters.TopMargin = 4.000000000000000000
      DoInPaletteMode = rvpaCreateCopies
      Options = [rvoAllowSelection, rvoShowPageBreaks, rvoAutoCopyText, rvoAutoCopyRVF, rvoAutoCopyImage, rvoAutoCopyRTF, rvoFormatInvalidate, rvoDblClickSelectsWord, rvoRClickDeselects, rvoFastFormatting]
      RTFReadProperties.TextStyleMode = rvrsAddIfNeeded
      RTFReadProperties.ParaStyleMode = rvrsAddIfNeeded
      RVFOptions = [rvfoSavePicturesBody, rvfoSaveControlsBody, rvfoConvUnknownStylesToZero, rvfoSaveBinary, rvfoSaveTextStyles, rvfoSaveParaStyles, rvfoSaveDocProperties, rvfoLoadDocProperties]
      Style = RVStyle1
      WordWrap = False
      OnSelect = rvFuncsSelect
    end
    object rvDescryption: TRichView
      Left = 0
      Top = 13
      Width = 435
      Height = 10
      Align = alClient
      PopupMenu = PopupMenu1
      TabOrder = 1
      OnMouseMove = rvDescryptionMouseMove
      DocParameters.LeftMargin = 4.000000000000000000
      DocParameters.RightMargin = 4.000000000000000000
      DocParameters.TopMargin = 4.000000000000000000
      DoInPaletteMode = rvpaCreateCopies
      Options = [rvoAllowSelection, rvoShowPageBreaks, rvoAutoCopyText, rvoAutoCopyRVF, rvoAutoCopyImage, rvoAutoCopyRTF, rvoFormatInvalidate, rvoDblClickSelectsWord, rvoRClickDeselects, rvoFastFormatting]
      RTFReadProperties.TextStyleMode = rvrsAddIfNeeded
      RTFReadProperties.ParaStyleMode = rvrsAddIfNeeded
      RVFOptions = [rvfoSavePicturesBody, rvfoSaveControlsBody, rvfoConvUnknownStylesToZero, rvfoSaveBinary, rvfoSaveTextStyles, rvfoSaveParaStyles, rvfoSaveDocProperties, rvfoLoadDocProperties]
      Style = RVStyle1
      OnRVMouseUp = rvDescryptionRVMouseUp
      OnSelect = rvDescryptionSelect
    end
  end
  object lang: TsiLang
    Version = '6.1.0.1'
    IsInheritedOwner = True
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    SmartExcludeProps.Strings = (
      'Action4.Caption'
      'Action5.Caption'
      'Action6.Caption'
      'Action7.Caption'
      'Action8.Caption'
      'Action9.Caption'
      'Action10.Caption'
      'TL2PacketHackMain.Caption'
      'Memo4.Hint')
    UseInheritedData = True
    AutoSkipEmpties = True
    NumOfLanguages = 2
    LangDispatcher = fMain.lang
    LangDelim = 1
    DoNotTranslate.Strings = (
      'Action2'
      'Action3')
    LangNames.Strings = (
      'Rus'
      'Eng')
    Language = 'Rus'
    ExcludedProperties.Strings = (
      'Category'
      'SecondaryShortCuts'
      'HelpKeyword'
      'InitialDir'
      'HelpKeyword'
      'ActivePage'
      'ImeName'
      'DefaultExt'
      'FileName'
      'FieldName'
      'PickList'
      'DisplayFormat'
      'EditMask'
      'KeyList'
      'LookupDisplayFields'
      'DropDownSpecRow'
      'TableName'
      'DatabaseName'
      'IndexName'
      'MasterFields'
      'TabStops'
      'SyntaxType')
    Left = 56
    Top = 24
    TranslationData = {
      737443617074696F6E730D0A4C6162656C3101CFE0EAE5F23A015061636B6574
      010D0A4E3101CFE5F0E5EDEEF120F1EBEEE201576F72642D57726170010D0A73
      7448696E74730D0A7374446973706C61794C6162656C730D0A7374466F6E7473
      0D0A54665061636B657456696577014D532053616E7320536572696601010D0A
      73744D756C74694C696E65730D0A7374446C677343617074696F6E730D0A5761
      726E696E67015761726E696E67015761726E696E67010D0A4572726F72014572
      726F72014572726F72010D0A496E666F726D6174696F6E01496E666F726D6174
      696F6E01496E666F726D6174696F6E010D0A436F6E6669726D01436F6E666972
      6D01436F6E6669726D010D0A59657301265965730126596573010D0A4E6F0126
      4E6F01264E6F010D0A4F4B014F4B014F4B010D0A43616E63656C0143616E6365
      6C0143616E63656C010D0A41626F7274012641626F7274012641626F7274010D
      0A52657472790126526574727901265265747279010D0A49676E6F7265012649
      676E6F7265012649676E6F7265010D0A416C6C0126416C6C0126416C6C010D0A
      4E6F20546F20416C6C014E266F20746F20416C6C014E266F20746F20416C6C01
      0D0A59657320546F20416C6C0159657320746F2026416C6C0159657320746F20
      26416C6C010D0A48656C70012648656C70012648656C70010D0A737453747269
      6E67730D0A4944535F3901D1F2E0F0F2F3E5F2204C3270682076015374617274
      7570206F66204C3270682076010D0A627974650120E1E0E9F228E02901206279
      7465287329010D0A656E6462015BCAEEEDE5F620EFEEE2F2EEF0FFFEF9E5E3EE
      F1FF20E1EBEEEAE02020015B456E64206F662072657065617420626C6F636B20
      20010D0A4944535F31303901C2FBE4E5EBE5EDEDFBE920EFE0EAE5F23A20F2E8
      EF202D2030780153656C6563746564207061636B6574203A2074797065202D30
      78010D0A4944535F31323601C2F0E5ECFF20EFF0E8F5EEE4E03A200152656369
      76652074696D653A20010D0A4944535F32333201C2FBE4E5EBE5EDEDFBE920EF
      E0EAE5F23A0153656C6563746564207061636B65743A010D0A7265616C6C7977
      616E743201E5F1EBE820EEEDEE20F1F3F9E5F1F2E2F3E5F22E20C2FB20F3E2E5
      F0E5EDFB203F0141726520796F752073757265203F010D0A7265616C6C797761
      6E7401DDF2EE20E4E5E9F1F2E2E8E520E7E0EAF0EEE5F220E4E0EDEDFBE920E4
      E8E0EBEEE320E820EFF0E5F0E2E5F220F2E5EAF3F9E5E520F1EEE5E4E8EDE5ED
      E8E501546869732077696C6C20636C6F73652074686973206469616C6F672061
      6E6420636F6E6E656374696F6E2E010D0A73697A65012C20F0E0E7ECE5F0202D
      20012C2073697A65202D20010D0A73697A65320150E0E7ECE5F03A200153697A
      653A20010D0A736B69702073637279707401CFF0EEEFF3F1EAE0E5EC20F1EAF0
      E8EFF201536B697020736372697074010D0A736B697001CFF0EEEFF3F1EAE0E5
      EC2001536B697020010D0A737461727462015BCDE0F7E0EBEE20EFEEE2F2EEF0
      FFFEF9E5E3EEF1FF20E1EBEEEAE020015B626567696E206F6620726570656174
      20626C6F636B2020010D0A7479706530780154E8EF3A20307801547970654C20
      3078010D0A756E6B6E6F77696E6401CDE5E8E7E2E5F1F2EDFBE920E8E4E5EDF2
      E8F4E8EAE0F2EEF0202D3E203F286E616D65292101556E6B6E6F776E20696E64
      6566696361746F72202D3E203F286E616D652921010D0A4944535F3132310154
      E8EF3A2001547970653A010D0A73744F74686572537472696E67730D0A727648
      45582E44656C696D697465727301202E3B2C3A28297B7D222F5C3C3E213F5B5D
      919293942D2B2A3DA08401010D0A73744C6F63616C65730D0A7374436F6C6C65
      6374696F6E730D0A737443686172536574730D0A54665061636B657456696577
      0144454641554C545F434841525345540144454641554C545F43484152534554
      010D0A}
  end
  object PopupMenu1: TPopupMenu
    Left = 232
    Top = 120
    object N1: TMenuItem
      Caption = #1055#1077#1088#1077#1085#1086#1089' '#1089#1083#1086#1074
      Checked = True
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1084#1072#1089#1082#1080' '#1080' '#1074#1072#1088#1080#1072#1085#1090' '#1086#1073#1100#1103#1074#1083#1077#1085#1080#1103
      OnClick = N2Click
    end
  end
  object RVStyle1: TRVStyle
    TextStyles = <
      item
        StyleName = 'Normal text'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
      end
      item
        StyleName = 'Bold'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        Style = [fsBold]
      end
      item
        StyleName = 'RedBold'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        Color = clRed
      end
      item
        StyleName = 'reserved'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
      end
      item
        StyleName = 'mask'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        Color = clGreen
      end
      item
        StyleName = 'reserved'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
      end
      item
        StyleName = 'reserved'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
      end
      item
        StyleName = 'reserved'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
      end
      item
        StyleName = 'reserved'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
      end
      item
        StyleName = 'reserved'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
      end
      item
        StyleName = 'style_d'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = 11198431
        HoverBackColor = 11198431
        HoverColor = clRed
        Jump = True
        JumpCursor = crArrow
      end
      item
        StyleName = 'style_c'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = 11184863
        HoverBackColor = 11184863
        HoverColor = clRed
        Jump = True
        JumpCursor = crArrow
      end
      item
        StyleName = 'style_f'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = 14658218
        HoverBackColor = 14658218
        HoverColor = clRed
        Jump = True
        JumpCursor = crArrow
      end
      item
        StyleName = 'style_h'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = 14658271
        HoverBackColor = 14658271
        HoverColor = clRed
        Jump = True
        JumpCursor = crArrow
      end
      item
        StyleName = 'style_q'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = 11198416
        HoverBackColor = 11198416
        HoverColor = clRed
        Jump = True
        JumpCursor = crArrow
      end
      item
        StyleName = 'style_l'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = 12906685
        HoverBackColor = 12906685
        HoverColor = clRed
        Jump = True
        JumpCursor = crArrow
      end
      item
        StyleName = 'style_s'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = 14671786
        HoverBackColor = 14671786
        HoverColor = clRed
        Jump = True
        JumpCursor = crArrow
      end
      item
        StyleName = 'style_z'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = 13619151
        HoverBackColor = 13619151
        HoverColor = clRed
        Jump = True
        JumpCursor = crArrow
      end
      item
        StyleName = 'Font Style'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
      end
      item
        StyleName = 'Font Style'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
      end
      item
        StyleName = 'style_d_hover'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = clRed
        HoverBackColor = clRed
        HoverColor = clWindowText
      end
      item
        StyleName = 'style_c_hover'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = clRed
        HoverBackColor = clRed
        HoverColor = clWindowText
      end
      item
        StyleName = 'style_f_hover'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = clRed
        HoverBackColor = clRed
        HoverColor = clWindowText
      end
      item
        StyleName = 'style_h_hover'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = clRed
        HoverBackColor = clRed
        HoverColor = clWindowText
      end
      item
        StyleName = 'Style_q_hover'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = clRed
        HoverBackColor = clRed
        HoverColor = clWindowText
      end
      item
        StyleName = 'style_l_hover'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = clRed
        HoverBackColor = clRed
        HoverColor = clWindowText
      end
      item
        StyleName = 'style_s_hover'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = clRed
        HoverBackColor = clRed
        HoverColor = clWindowText
      end
      item
        StyleName = 'style_z_hover'
        Standard = False
        FontName = 'Tahoma'
        Size = 8
        BackColor = clRed
        HoverBackColor = clRed
        HoverColor = clWindowText
      end>
    ParaStyles = <
      item
        StyleName = 'Paragraph Style'
        Tabs = <>
      end
      item
        StyleName = 'Centered'
        Alignment = rvaCenter
        Tabs = <>
      end>
    ListStyles = <>
    InvalidPicture.Data = {
      07544269746D617036100000424D361000000000000036000000280000002000
      0000200000000100200000000000001000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF000000FF000000FF00FFFF
      FF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00C0C0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000
      FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000
      FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF000000FF000000FF00FFFF
      FF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF00C0C0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008080800080808000808080008080800080808000808080008080
      800080808000808080008080800080808000808080008080800080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000}
    StyleTemplates = <>
    Left = 24
    Top = 40
  end
end
