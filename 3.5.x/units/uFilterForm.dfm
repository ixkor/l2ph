object fPacketFilter: TfPacketFilter
  Left = 364
  Top = 258
  Width = 334
  Height = 480
  BorderStyle = bsSizeToolWin
  Caption = #1060#1080#1083#1100#1090#1088' '#1087#1072#1082#1077#1090#1086#1074
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
    Width = 318
    Height = 391
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1054#1090' '#1089#1077#1088#1074#1077#1088#1072
      object ListView1: TListView
        Left = 0
        Top = 0
        Width = 310
        Height = 363
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
      end
    end
    object TabSheet7: TTabSheet
      Caption = #1054#1090' '#1082#1083#1080#1077#1085#1090#1072
      ImageIndex = 1
      object ListView2: TListView
        Left = 0
        Top = 0
        Width = 310
        Height = 363
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
      end
    end
  end
  object Panel17: TPanel
    Left = 0
    Top = 391
    Width = 318
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
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
      'TL2PacketHackMain.Caption')
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
      'MasterFields')
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
      0A54665061636B657446696C746572014D532053616E7320536572696601010D
      0A4C6973745669657731014D532053616E7320536572696601010D0A4C697374
      5669657732014D532053616E7320536572696601010D0A73744D756C74694C69
      6E65730D0A7374446C677343617074696F6E730D0A5761726E696E6701576172
      6E696E67015761726E696E67010D0A4572726F72014572726F72014572726F72
      010D0A496E666F726D6174696F6E01496E666F726D6174696F6E01496E666F72
      6D6174696F6E010D0A436F6E6669726D01436F6E6669726D01436F6E6669726D
      010D0A59657301265965730126596573010D0A4E6F01264E6F01264E6F010D0A
      4F4B014F4B014F4B010D0A43616E63656C0143616E63656C0143616E63656C01
      0D0A41626F7274012641626F7274012641626F7274010D0A5265747279012652
      6574727901265265747279010D0A49676E6F7265012649676E6F726501264967
      6E6F7265010D0A416C6C0126416C6C0126416C6C010D0A4E6F20546F20416C6C
      014E266F20746F20416C6C014E266F20746F20416C6C010D0A59657320546F20
      416C6C0159657320746F2026416C6C0159657320746F2026416C6C010D0A4865
      6C70012648656C70012648656C70010D0A7374537472696E67730D0A4944535F
      313801C2FB20F3E2E5F0E5EDFB20F7F2EE20F5EEF2E8F2E520E2FBE9F2E820E8
      E720EFF0EEE3F0E0ECECFB3F0141726520796F752073757265203F010D0A4944
      535F313901C2F1E520F1EEE5E4E8EDE5EDE8FF20EFF0E5F0E2F3F2F1FF210141
      6C6C20636F6E6E656374696F6E732077696C6C20626520636C6F73656421010D
      0A4944535F3601CFEEE4E4E5F0E6E0F2FC20EFF0EEE5EAF23A01537570706F72
      7420746869732070726F6A6563743A010D0A4944535F3901D1F2E0F0F2F3E5F2
      204C32706820760153746172747570206F66204C3270682076010D0A73744F74
      686572537472696E67730D0A73744C6F63616C65730D0A7374436F6C6C656374
      696F6E730D0A4C69737456696577312E436F6C756D6E735B305D2E4361707469
      6F6E01494401010D0A4C69737456696577312E436F6C756D6E735B315D2E4361
      7074696F6E014E616D6501010D0A4C69737456696577322E436F6C756D6E735B
      305D2E43617074696F6E01494401010D0A4C69737456696577322E436F6C756D
      6E735B315D2E43617074696F6E014E616D6501010D0A73744368617253657473
      0D0A54665061636B657446696C7465720144454641554C545F43484152534554
      0144454641554C545F43484152534554010D0A4C697374566965773101444546
      41554C545F434841525345540144454641554C545F43484152534554010D0A4C
      69737456696577320144454641554C545F434841525345540144454641554C54
      5F43484152534554010D0A}
  end
end
