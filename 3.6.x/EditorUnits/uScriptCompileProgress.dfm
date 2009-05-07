object fScriptCompileProgress: TfScriptCompileProgress
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1050#1086#1084#1087#1080#1083#1080#1088#1086#1074#1072#1085#1080#1077'...'
  ClientHeight = 211
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    AlignWithMargins = True
    Left = 15
    Top = 181
    Width = 332
    Height = 25
    Margins.Left = 15
    Margins.Right = 15
    Margins.Bottom = 5
    Align = alBottom
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 362
    Height = 145
    Align = alTop
    TabOrder = 1
    object PanelProject: TPanel
      Left = 16
      Top = 16
      Width = 329
      Height = 20
      BevelInner = bvLowered
      BevelOuter = bvLowered
      TabOrder = 0
      object LabelProject: TLabel
        Left = 2
        Top = 2
        Width = 325
        Height = 16
        Align = alClient
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
    end
    object PanelStatus: TPanel
      Left = 16
      Top = 48
      Width = 329
      Height = 20
      BevelInner = bvLowered
      BevelOuter = bvLowered
      TabOrder = 1
      object LabelStatus: TLabel
        Left = 2
        Top = 2
        Width = 325
        Height = 16
        Align = alClient
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
    end
    object PanelCurrLine: TPanel
      Left = 16
      Top = 80
      Width = 327
      Height = 20
      BevelInner = bvLowered
      BevelOuter = bvLowered
      TabOrder = 2
      object LabelCurrLine: TLabel
        Left = 2
        Top = 2
        Width = 82
        Height = 16
        Align = alLeft
        Caption = #1058#1077#1082#1091#1097#1072#1103' '#1083#1080#1085#1080#1103':'
        ExplicitHeight = 13
      end
      object LabelCurrLineNumber: TLabel
        Left = 84
        Top = 2
        Width = 241
        Height = 16
        Align = alClient
        Alignment = taRightJustify
        ExplicitLeft = 322
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
    end
    object PanelError: TPanel
      Left = 16
      Top = 112
      Width = 329
      Height = 20
      BevelInner = bvLowered
      BevelOuter = bvLowered
      TabOrder = 3
      object LabelError: TLabel
        Left = 2
        Top = 2
        Width = 325
        Height = 16
        Align = alClient
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
    end
  end
  object autoclose: TCheckBox
    AlignWithMargins = True
    Left = 15
    Top = 153
    Width = 332
    Height = 17
    Margins.Left = 15
    Margins.Top = 8
    Margins.Right = 15
    Align = alTop
    Caption = #1047#1072#1082#1088#1099#1074#1072#1090#1100' '#1101#1090#1086' '#1086#1082#1085#1086' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080
    TabOrder = 2
    OnClick = autocloseClick
  end
  object siLangLinked1: TsiLangLinked
    Version = '6.1.0.1'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    SmartExcludeProps.Strings = (
      'TfScriptCompileProgress.CharSet')
    AutoSkipEmpties = True
    NumOfLanguages = 2
    LangDispatcher = fMain.siLangDispatcher
    LangDelim = 1
    LangNames.Strings = (
      'Default'
      'English')
    Language = 'Default'
    CommonContainer = fEditorMain.siLang1
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
    Left = 39
    Top = 21
    TranslationData = {
      737443617074696F6E730D0A5466536372697074436F6D70696C6550726F6772
      65737301CAEEECEFE8EBE8F0EEE2E0EDE8E52E2E2E01436F6D70696C6C696E67
      2E2E2E010D0A427574746F6E31014F4B01010D0A4C6162656C437572724C696E
      6501D2E5EAF3F9E0FF20EBE8EDE8FF3A0143757272656E74206C696E653A010D
      0A6175746F636C6F736501C7E0EAF0FBE2E0F2FC20FDF2EE20EEEAEDEE20E0E2
      F2EEECE0F2E8F7E5F1EAE8014175746F20636C6F736520746869732077696E64
      6F77010D0A737448696E74730D0A7374446973706C61794C6162656C730D0A73
      74466F6E74730D0A5466536372697074436F6D70696C6550726F677265737301
      5461686F6D61015461686F6D61010D0A73744D756C74694C696E65730D0A7374
      537472696E67730D0A576F726B696E6701D0E0E1EEF2E0E5EC2E2E2E01576F72
      6B696E672E2E2E010D0A43616E63656C01CEF2ECE5EDE00143616E63656C010D
      0A4572726F7273466F756E6401CDE0E9E4E5EDFB20EEF8E8E1EAE82E01457272
      6F727320666F756E642E010D0A446F6E6501C3EEF2EEE2EE2E01446F6E652E01
      0D0A436C6F736501C7E0EAF0FBF2FC01436C6F7365010D0A73744F7468657253
      7472696E67730D0A7374436F6C6C656374696F6E730D0A737443686172536574
      730D0A}
  end
end
