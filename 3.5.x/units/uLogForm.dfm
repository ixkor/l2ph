object fLog: TfLog
  Left = 2
  Top = 3
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1051#1086#1075' '#1087#1072#1082#1077#1090#1093#1072#1082#1072
  ClientHeight = 170
  ClientWidth = 660
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
  object Log: TMemo
    Left = 0
    Top = 0
    Width = 660
    Height = 147
    Align = alClient
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    BorderStyle = bsNone
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 147
    Width = 660
    Height = 23
    Align = alBottom
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object Help: TLabel
      Left = 8
      Top = 8
      Width = 3
      Height = 13
    end
    object Panel3: TPanel
      Left = 485
      Top = 0
      Width = 175
      Height = 23
      Align = alRight
      BevelOuter = bvNone
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      object Button1: TButton
        Left = 22
        Top = 2
        Width = 150
        Height = 19
        Caption = #1047#1072#1082#1088#1099#1090#1100
        TabOrder = 0
        OnClick = Button1Click
      end
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
      737443617074696F6E730D0A54664C6F6701CBEEE320EFE0EAE5F2F5E0EAE001
      4C327068204C6F67010D0A427574746F6E3101C7E0EAF0FBF2FC01436C6F7365
      010D0A737448696E74730D0A7374446973706C61794C6162656C730D0A737446
      6F6E74730D0A54664C6F67014D532053616E7320536572696601010D0A73744D
      756C74694C696E65730D0A7374446C677343617074696F6E730D0A5761726E69
      6E67015761726E696E67015761726E696E67010D0A4572726F72014572726F72
      014572726F72010D0A496E666F726D6174696F6E01496E666F726D6174696F6E
      01496E666F726D6174696F6E010D0A436F6E6669726D01436F6E6669726D0143
      6F6E6669726D010D0A59657301265965730126596573010D0A4E6F01264E6F01
      264E6F010D0A4F4B014F4B014F4B010D0A43616E63656C0143616E63656C0143
      616E63656C010D0A41626F7274012641626F7274012641626F7274010D0A5265
      7472790126526574727901265265747279010D0A49676E6F7265012649676E6F
      7265012649676E6F7265010D0A416C6C0126416C6C0126416C6C010D0A4E6F20
      546F20416C6C014E266F20746F20416C6C014E266F20746F20416C6C010D0A59
      657320546F20416C6C0159657320746F2026416C6C0159657320746F2026416C
      6C010D0A48656C70012648656C70012648656C70010D0A7374537472696E6773
      0D0A4944535F313801C2FB20F3E2E5F0E5EDFB20F7F2EE20F5EEF2E8F2E520E2
      FBE9F2E820E8E720EFF0EEE3F0E0ECECFB3F0141726520796F75207375726520
      3F010D0A4944535F313901C2F1E520F1EEE5E4E8EDE5EDE8FF20EFF0E5F0E2F3
      F2F1FF2101416C6C20636F6E6E656374696F6E732077696C6C20626520636C6F
      73656421010D0A4944535F3601CFEEE4E4E5F0E6E0F2FC20EFF0EEE5EAF23A01
      537570706F727420746869732070726F6A6563743A010D0A4944535F3901D1F2
      E0F0F2F3E5F2204C32706820760153746172747570206F66204C327068207601
      0D0A4944535F340120D1EEF5F0E0EDFFE5EC20EBEEE32E2E2E01536176696E67
      206C6F672E2E2E010D0A73744F74686572537472696E67730D0A73744C6F6361
      6C65730D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A
      54664C6F670144454641554C545F434841525345540144454641554C545F4348
      4152534554010D0A}
  end
end
