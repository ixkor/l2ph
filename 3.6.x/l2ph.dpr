// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_GENERATEJDBG ON
program l2ph;

uses
  ShareMem,
  Forms,
  windows,
  sysutils,
  uMain in 'units\uMain.pas' {fMain},
  uAboutDialog in 'units\uAboutDialog.pas' {fAbout},
  uConvertForm in 'units\uConvertForm.pas' {fConvert},
  uData in 'units\uData.pas' {dmData: TDataModule},
  uencdec in 'units\uencdec.pas',
  uFilterForm in 'units\uFilterForm.pas' {fPacketFilter},
  uglobalfuncs in 'units\uglobalfuncs.pas',
  uLogForm in 'units\uLogForm.pas' {fLog},
  uProcesses in 'units\uProcesses.pas' {fProcesses},
  uResourceStrings in 'units\uResourceStrings.pas',
  uSettingsDialog in 'units\uSettingsDialog.pas' {fSettings},
  usharedstructs in 'units\usharedstructs.pas',
  usocketengine in 'units\usocketengine.pas',
  uVisualContainer in 'units\uVisualContainer.pas' {fVisual: TFrame},
  advApiHook in 'units\advApiHook.pas',
  NativeAPI in 'units\NativeAPI.pas',
  FastMM4Messages in 'fastmm\FastMM4Messages.pas',
  uProcessRawLog in 'units\uProcessRawLog.pas' {fProcessRawLog},
  uPlugins in 'units\uPlugins.pas' {fPlugins},
  uPluginData in 'units\uPluginData.pas',
  uPacketView in 'units\uPacketView.pas' {fPacketView: TFrame},
  uMainReplacer in 'units\uMainReplacer.pas' {fMainReplacer},
  uUserForm in 'EditorUnits\uUserForm.pas' {UserForm},
  uEditorMain in 'EditorUnits\uEditorMain.pas' {fEditorMain},
  uObjInspector in 'EditorUnits\uObjInspector.pas' {fObjInspector},
  uScriptCallStack in 'EditorUnits\uScriptCallStack.pas' {fScriptCallStack},
  uScriptCompileProgress in 'EditorUnits\uScriptCompileProgress.pas' {fScriptCompileProgress},
  uScriptControl in 'EditorUnits\uScriptControl.pas' {fScriptControl},
  uScriptControlItem in 'EditorUnits\uScriptControlItem.pas' {fScriptControlItem: TFrame},
  uScriptData in 'EditorUnits\uScriptData.pas',
  uScriptEditorResourcesStrings in 'EditorUnits\uScriptEditorResourcesStrings.pas',
  uScriptErrors in 'EditorUnits\uScriptErrors.pas' {fScriptErrors},
  uScriptPrints in 'EditorUnits\uScriptPrints.pas' {fScriptPrints},
  uScriptProject in 'EditorUnits\uScriptProject.pas' {ScriptProject: TDataModule},
  uScriptProjectVisual in 'EditorUnits\uScriptProjectVisual.pas' {ScriptProjectVisual: TFrame},
  uScriptUnitVisual in 'EditorUnits\uScriptUnitVisual.pas' {ScriptUnitVisual: TFrame},
  uScriptVariables in 'EditorUnits\uScriptVariables.pas' {fScriptVariables},
  uScriptWatchList in 'EditorUnits\uScriptWatchList.pas' {fScriptWatchList},
  uLangSelectDialog in 'units\uLangSelectDialog.pas' {fLangSelectDialog};

{$R *.res}
Procedure Check2stInstance;
var
 hMutex, hWindow : cardinal;

begin
 //ћьютекс нужен дабы исключить проблеммы при активном дебаггере с открытым пх.
 hMutex := CreateMutex(nil, false, 'L2PH');
 if GetLastError = ERROR_ALREADY_EXISTS then
 begin
   ReleaseMutex(hMutex);
   CloseHandle(hMutex);
   
   hWindow := FindWindow('TL2PacketHackMain', nil);
   if hWindow > 0 then
   begin
     SetForegroundWindow(hWindow);
     ExitProcess(0);
   end;
 end;
end;

begin
  Check2stInstance;
  AppPath := ExtractFilePath(Application.ExeName);
  isGlobalDestroying := false;
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(TfMainReplacer, fMainReplacer);
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfAbout, fAbout);
  Application.CreateForm(TfConvert, fConvert);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfPacketFilter, fPacketFilter);
  Application.CreateForm(TfLog, fLog);
  Application.CreateForm(TfProcesses, fProcesses);
  Application.CreateForm(TfSettings, fSettings);
  Application.CreateForm(TfProcessRawLog, fProcessRawLog);
  Application.CreateForm(TfPlugins, fPlugins);
  Application.CreateForm(TfLangSelectDialog, fLangSelectDialog);
  //Editor
  Application.CreateForm(TfEditorMain, fEditorMain);
  Application.CreateForm(TUserForm, UserForm);
  Application.CreateForm(TfScriptCompileProgress, fScriptCompileProgress);
  Application.CreateForm(TfScriptCallStack, fScriptCallStack);
  Application.CreateForm(TfScriptErrors, fScriptErrors);
  Application.CreateForm(TfScriptPrints, fScriptPrints);
  Application.CreateForm(TfScriptWatchList, fScriptWatchList);
  Application.CreateForm(TfScriptVariables, fScriptVariables);
  Application.CreateForm(TfObjInspector, fObjInspector);
  Application.CreateForm(TfScriptControl, fScriptControl);

  Application.ShowMainForm := false;
  fSettings.init;
  fMain.INIT;
  fPlugins.init;
  fEditorMain.init;
  fScriptControl.init;  
  Application.Run;

end.
