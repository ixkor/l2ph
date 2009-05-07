object dmData: TdmData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 269
  Width = 496
  object LSPControl: TLSPModuleControl
    onLspModuleState = LSPControlLspModuleState
    onConnect = LSPControlConnect
    onDisconnect = LSPControlDisconnect
    onRecv = LSPControlRecv
    onSend = LSPControlSend
    Left = 40
    Top = 16
  end
  object timerSearchProcesses: TTimer
    Interval = 5000
    OnTimer = timerSearchProcessesTimer
    Left = 40
    Top = 72
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
      737443617074696F6E730D0A737448696E74730D0A7374446973706C61794C61
      62656C730D0A7374466F6E74730D0A544C325061636B65744861636B4D61696E
      014D532053616E73205365726966015461686F6D61010D0A53706C617368014D
      532053616E73205365726966015461686F6D61010D0A53746174757342617231
      015461686F6D61015461686F6D61010D0A73744D756C74694C696E65730D0A73
      74446C677343617074696F6E730D0A5761726E696E67015761726E696E670157
      61726E696E67010D0A4572726F72014572726F72014572726F72010D0A496E66
      6F726D6174696F6E01496E666F726D6174696F6E01496E666F726D6174696F6E
      010D0A436F6E6669726D01436F6E6669726D01436F6E6669726D010D0A596573
      01265965730126596573010D0A4E6F01264E6F01264E6F010D0A4F4B014F4B01
      4F4B010D0A43616E63656C0143616E63656C0143616E63656C010D0A41626F72
      74012641626F7274012641626F7274010D0A5265747279012652657472790126
      5265747279010D0A49676E6F7265012649676E6F7265012649676E6F7265010D
      0A416C6C0126416C6C0126416C6C010D0A4E6F20546F20416C6C014E266F2074
      6F20416C6C014E266F20746F20416C6C010D0A59657320546F20416C6C015965
      7320746F2026416C6C0159657320746F2026416C6C010D0A48656C7001264865
      6C70012648656C70010D0A7374537472696E67730D0A73744F74686572537472
      696E67730D0A73744C6F63616C65730D0A7374436F6C6C656374696F6E730D0A
      737443686172536574730D0A}
  end
end
