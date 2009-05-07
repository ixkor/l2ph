object fLangSelectDialog: TfLangSelectDialog
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = #1071#1079#1099#1082
  ClientHeight = 90
  ClientWidth = 171
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 12
    Top = 7
    Width = 90
    Height = 13
    Caption = #1071#1079#1099#1082' '#1080#1085#1090#1077#1088#1092#1077#1081#1089#1072
  end
  object siLangCombo1: TsiLangCombo
    Left = 12
    Top = 26
    Width = 145
    Height = 22
    ItemHeight = 16
    TabOrder = 0
    siLangDispatcher = fMain.siLangDispatcher
    LanguageInfos = <
      item
        FontName = 'Tahoma'
        FontCharset = DEFAULT_CHARSET
      end
      item
        FontName = 'Tahoma'
        FontCharset = DEFAULT_CHARSET
      end>
  end
  object Button1: TButton
    Left = 12
    Top = 61
    Width = 70
    Height = 22
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 87
    Top = 61
    Width = 70
    Height = 22
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    OnClick = Button2Click
  end
  object siLang1: TsiLang
    Version = '6.1.0.1'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 2
    LangDispatcher = fMain.siLangDispatcher
    LangDelim = 1
    DoNotTranslate.Strings = (
      'siLangCombo1')
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
      'CharSet'
      'HelpFile')
    Left = 60
    Top = 6
    TranslationData = {
      737443617074696F6E730D0A54664C616E6753656C6563744469616C6F6701DF
      E7FBEA014C616E6775616765010D0A4C6162656C3201DFE7FBEA20E8EDF2E5F0
      F4E5E9F1E001496E74657266616365206C616E6775616765010D0A737448696E
      74730D0A54664C616E6753656C6563744469616C6F670101010D0A4C6162656C
      320101010D0A7374446973706C61794C6162656C730D0A7374466F6E74730D0A
      54664C616E6753656C6563744469616C6F67015461686F6D61015461686F6D61
      010D0A73744D756C74694C696E65730D0A7374446C677343617074696F6E730D
      0A5761726E696E67015761726E696E6701010D0A4572726F72014572726F7201
      010D0A496E666F726D6174696F6E01496E666F726D6174696F6E01010D0A436F
      6E6669726D01436F6E6669726D01010D0A596573012659657301010D0A4E6F01
      264E6F01010D0A4F4B014F4B01010D0A43616E63656C0143616E63656C01010D
      0A41626F7274012641626F727401010D0A52657472790126526574727901010D
      0A49676E6F7265012649676E6F726501010D0A416C6C0126416C6C01010D0A4E
      6F20546F20416C6C014E266F20746F20416C6C01010D0A59657320546F20416C
      6C0159657320746F2026416C6C01010D0A48656C70012648656C7001010D0A73
      74537472696E67730D0A73744F74686572537472696E67730D0A73744C6F6361
      6C65730D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A}
  end
end
