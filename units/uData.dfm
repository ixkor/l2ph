object dmData: TdmData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 321
  Top = 326
  Height = 397
  Width = 829
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
    OnTimer = timerSearchProcessesTimer
    Left = 40
    Top = 72
  end
  object fsClassesRTTI1: TfsClassesRTTI
    Left = 280
    Top = 40
  end
  object fsFormsRTTI1: TfsFormsRTTI
    Left = 200
    Top = 104
  end
  object fsExtCtrlsRTTI1: TfsExtCtrlsRTTI
    Left = 192
    Top = 40
  end
  object fsDialogsRTTI1: TfsDialogsRTTI
    Left = 368
    Top = 48
  end
  object fsMenusRTTI1: TfsMenusRTTI
    Left = 368
    Top = 104
  end
  object fsIniRTTI1: TfsIniRTTI
    Left = 296
    Top = 112
  end
end
