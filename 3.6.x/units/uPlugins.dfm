object fPlugins: TfPlugins
  Left = 243
  Top = 253
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1055#1083#1072#1075#1080#1085#1099
  ClientHeight = 408
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox5: TGroupBox
    Left = 0
    Top = 0
    Width = 206
    Height = 380
    Align = alLeft
    BiDiMode = bdLeftToRight
    Caption = #1057#1087#1080#1089#1086#1082' '#1087#1083#1072#1075#1080#1085#1086#1074':'
    ParentBiDiMode = False
    TabOrder = 0
    object clbPluginsList: TCheckListBox
      Left = 2
      Top = 15
      Width = 202
      Height = 363
      OnClickCheck = clbPluginsListClickCheck
      Align = alClient
      BorderStyle = bsNone
      ItemHeight = 13
      TabOrder = 0
      OnClick = clbPluginsListClick
    end
  end
  object Panel13: TPanel
    Left = 206
    Top = 0
    Width = 446
    Height = 380
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object GroupBox10: TGroupBox
      Left = 0
      Top = 0
      Width = 446
      Height = 258
      Align = alClient
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
      TabOrder = 0
      object mPluginInfo: TMemo
        Left = 2
        Top = 15
        Width = 442
        Height = 241
        Align = alClient
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object GroupBox11: TGroupBox
      Left = 0
      Top = 258
      Width = 446
      Height = 122
      Align = alBottom
      Caption = #1055#1086#1076#1076#1077#1088#1078#1080#1074#1072#1077#1084#1099#1077' '#1092#1091#1085#1082#1094#1080#1080':'
      Enabled = False
      TabOrder = 1
      object clbPluginFuncs: TCheckListBox
        Left = 2
        Top = 15
        Width = 442
        Height = 105
        Align = alClient
        BorderStyle = bsNone
        ItemHeight = 13
        Items.Strings = (
          'OnPacket'
          'OnConnect'
          'OnDisconnect'
          'OnLoad'
          'OnFree'
          'OnCallMethod'
          'OnRefreshPrecompile')
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 380
    Width = 652
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnRefreshPluginList: TButton
      Left = 5
      Top = 5
      Width = 188
      Height = 18
      Hint = #1055#1077#1088#1077#1079#1072#1075#1088#1091#1078#1072#1077#1090' '#1089#1087#1080#1089#1086#1082' '#1087#1083#1072#1075#1080#1085#1086#1074
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
      TabOrder = 0
      OnClick = btnRefreshPluginListClick
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
      'FoundProcesses.Hint'
      'btnRefreshPluginList.Hint')
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
      'MasterFields')
    Left = 29
    Top = 84
    TranslationData = {
      737443617074696F6E730D0A5466506C7567696E7301CFEBE0E3E8EDFB01506C
      7567696E73010D0A47726F7570426F783501D1EFE8F1EEEA20EFEBE0E3E8EDEE
      E23A014C697374206F6620666F756E6420706C7567696E73010D0A47726F7570
      426F78313001CEEFE8F1E0EDE8E53A014465736372697074696F6E010D0A4772
      6F7570426F78313101CFEEE4E4E5F0E6E8E2E0E5ECFBE520F4F3EDEAF6E8E83A
      01537570706F727465642066756E6373010D0A62746E52656672657368506C75
      67696E4C69737401CEE1EDEEE2E8F2FC20F1EFE8F1EEEA015265667265736820
      6C697374010D0A737448696E74730D0A7374446973706C61794C6162656C730D
      0A7374466F6E74730D0A5466506C7567696E73014D532053616E732053657269
      66015461686F6D61010D0A73744D756C74694C696E65730D0A636C62506C7567
      696E46756E63732E4974656D73014F6E5061636B65742C4F6E436F6E6E656374
      2C4F6E446973636F6E6E6563742C4F6E4C6F61642C4F6E467265652C4F6E4361
      6C6C4D6574686F642C4F6E52656672657368507265636F6D70696C65014F6E50
      61636B65742C4F6E436F6E6E6563742C4F6E446973636F6E6E6563742C4F6E4C
      6F61642C4F6E467265652C4F6E43616C6C4D6574686F642C4F6E526566726573
      68507265636F6D70696C65010D0A7374446C677343617074696F6E730D0A5761
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
      6E67730D0A4944535F313801C2FB20F3E2E5F0E5EDFB20F7F2EE20F5EEF2E8F2
      E520E2FBE9F2E820E8E720EFF0EEE3F0E0ECECFB3F0141726520796F75207375
      7265203F010D0A4944535F313901C2F1E520F1EEE5E4E8EDE5EDE8FF20EFF0E5
      F0E2F3F2F1FF2101416C6C20636F6E6E656374696F6E732077696C6C20626520
      636C6F73656421010D0A4944535F3601CFEEE4E4E5F0E6E0F2FC20EFF0EEE5EA
      F23A01537570706F727420746869732070726F6A6563743A010D0A4944535F39
      01D1F2E0F0F2F3E5F2204C32706820760153746172747570206F66204C327068
      2076010D0A73744F74686572537472696E67730D0A73744C6F63616C65730D0A
      7374436F6C6C656374696F6E730D0A737443686172536574730D0A5466506C75
      67696E730144454641554C545F434841525345540144454641554C545F434841
      52534554010D0A}
  end
end
