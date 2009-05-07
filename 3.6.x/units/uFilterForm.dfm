object fPacketFilter: TfPacketFilter
  Left = 391
  Top = 263
  BorderStyle = bsSizeToolWin
  Caption = #1060#1080#1083#1100#1090#1088' '#1087#1072#1082#1077#1090#1086#1074
  ClientHeight = 346
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl2: TPageControl
    Left = 0
    Top = 0
    Width = 316
    Height = 295
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 257
    object TabSheet1: TTabSheet
      Caption = #1054#1090' '#1089#1077#1088#1074#1077#1088#1072
      ExplicitWidth = 249
      object ListView1: TListView
        Left = 0
        Top = 0
        Width = 308
        Height = 267
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = 'ID'
            Width = 60
          end
          item
            AutoSize = True
            Caption = 'Name'
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GridLines = True
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
        ExplicitWidth = 249
      end
    end
    object TabSheet7: TTabSheet
      Caption = #1054#1090' '#1082#1083#1080#1077#1085#1090#1072
      ImageIndex = 1
      ExplicitWidth = 249
      object ListView2: TListView
        Left = 0
        Top = 0
        Width = 308
        Height = 267
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Caption = 'ID'
            Width = 60
          end
          item
            AutoSize = True
            Caption = 'Name'
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        GridLines = True
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        ShowWorkAreas = True
        TabOrder = 0
        ViewStyle = vsReport
        ExplicitWidth = 249
      end
    end
  end
  object Panel17: TPanel
    Left = 0
    Top = 295
    Width = 316
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 257
    object Button1: TButton
      Left = 8
      Top = 27
      Width = 150
      Height = 19
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1105
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button13: TButton
      Left = 160
      Top = 27
      Width = 150
      Height = 19
      Caption = #1048#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 1
      OnClick = Button13Click
    end
    object UpdateBtn: TButton
      Left = 8
      Top = 5
      Width = 302
      Height = 19
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      TabOrder = 2
      OnClick = UpdateBtnClick
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
      'TfPacketFilter.CharSet')
    UseInheritedData = True
    AutoSkipEmpties = True
    NumOfLanguages = 2
    LangDispatcher = fMain.siLangDispatcher
    LangDelim = 1
    DoNotTranslate.Strings = (
      'Action2'
      'Action3')
    LangNames.Strings = (
      'Default'
      'English')
    Language = 'Default'
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
      'CharSet')
    Left = 141
    Top = 12
    TranslationData = {
      737443617074696F6E730D0A54665061636B657446696C74657201D4E8EBFCF2
      F020EFE0EAE5F2EEE2015061636B65742066696C746572010D0A546162536865
      65743101CEF220F1E5F0E2E5F0E00146726F6D20736572766572010D0A546162
      53686565743701CEF220EAEBE8E5EDF2E00146726F6D20636C69656E74010D0A
      427574746F6E3101C2FBE4E5EBE8F2FC20E2F1B80153656C65637420616C6C01
      0D0A427574746F6E313301C8EDE2E5F0F2E8F0EEE2E0F2FC01496E7665727401
      0D0A55706461746542746E01CFF0E8ECE5EDE8F2FC014150504C59010D0A7374
      48696E74730D0A7374446973706C61794C6162656C730D0A7374466F6E74730D
      0A54665061636B657446696C746572014D532053616E73205365726966015461
      686F6D61010D0A4C6973745669657731014D532053616E732053657269660154
      61686F6D61010D0A4C6973745669657732014D532053616E7320536572696601
      5461686F6D61010D0A73744D756C74694C696E65730D0A7374446C6773436170
      74696F6E730D0A5761726E696E67015761726E696E67015761726E696E67010D
      0A4572726F72014572726F72014572726F72010D0A496E666F726D6174696F6E
      01496E666F726D6174696F6E01496E666F726D6174696F6E010D0A436F6E6669
      726D01436F6E6669726D01436F6E6669726D010D0A5965730126596573012659
      6573010D0A4E6F01264E6F01264E6F010D0A4F4B014F4B014F4B010D0A43616E
      63656C0143616E63656C0143616E63656C010D0A41626F7274012641626F7274
      012641626F7274010D0A52657472790126526574727901265265747279010D0A
      49676E6F7265012649676E6F7265012649676E6F7265010D0A416C6C0126416C
      6C0126416C6C010D0A4E6F20546F20416C6C014E266F20746F20416C6C014E26
      6F20746F20416C6C010D0A59657320546F20416C6C0159657320746F2026416C
      6C0159657320746F2026416C6C010D0A48656C70012648656C70012648656C70
      010D0A7374537472696E67730D0A73744F74686572537472696E67730D0A7374
      4C6F63616C65730D0A7374436F6C6C656374696F6E730D0A4C69737456696577
      312E436F6C756D6E735B305D2E43617074696F6E01494401010D0A4C69737456
      696577312E436F6C756D6E735B315D2E43617074696F6E014E616D6501010D0A
      4C69737456696577322E436F6C756D6E735B305D2E43617074696F6E01494401
      010D0A4C69737456696577322E436F6C756D6E735B315D2E43617074696F6E01
      4E616D6501010D0A737443686172536574730D0A}
  end
end
