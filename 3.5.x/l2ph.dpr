program l2ph;

uses
  ExceptionLog,
  Forms,
  windows,
  IniFiles,
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
  uUserForm in 'units\uUserForm.pas' {UserForm},
  uProcessRawLog in 'units\uProcessRawLog.pas' {fProcessRawLog},
  uPlugins in 'units\uPlugins.pas' {fPlugins},
  uPluginData in 'units\uPluginData.pas',
  uScripts in 'units\uScripts.pas' {fScript},
  uScriptEditor in 'units\uScriptEditor.pas' {fScriptEditor: TFrame},
  uPacketView in 'units\uPacketView.pas' {fPacketView: TFrame},
  uClassesDLG in 'units\uClassesDLG.pas' {fClassesDLG},
  uMainReplacer in 'units\uMainReplacer.pas' {fMainReplacer},
  uPacketViewer in 'units\uPacketViewer.pas' {fPacketViewer},
  uLangSelectDialog in 'units\uLangSelectDialog.pas' {fLangSelectDialog},
  uCompilling in 'units\uCompilling.pas' {fCompilling},
  uJavaParser in 'units\uJavaParser.pas';

{$R *.res}

Procedure Check2stInstance;
var
  hMutex, hWindow : cardinal;
  str : String;
begin
 //ћьютекс нужен дабы исключить проблемы при активном дебаггере с открытым пх.
  //считываем Options.ini в пам€ть
  Options:=TMemIniFile.Create('.\\settings\\options.ini');
  str := Options.ReadString('general', 'mainMutex', 'L2PH');
  Options.Destroy;
  //hMutex := CreateMutex(nil, false, 'L2PH');
  hMutex := CreateMutex(nil, false, PChar(String(str)));
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    ReleaseMutex(hMutex);
    CloseHandle(hMutex);

    hWindow := FindWindow(PChar(String(TfMain.ClassName)), nil);
    if hWindow > 0 then
    begin
      SetForegroundWindow(hWindow);
      ExitProcess(0);
    end;
  end;
end;

begin
  Check2stInstance;
  isGlobalDestroying := false;
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(TfMainReplacer, fMainReplacer);
  ShowWindow(application.Handle,sw_hide);
  windows.BringWindowToTop(fMainReplacer.Handle);
  fMainReplacer.Repaint;
  Application.ProcessMessages;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfAbout, fAbout);
  Application.CreateForm(TfConvert, fConvert);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfPacketFilter, fPacketFilter);
  Application.CreateForm(TfLog, fLog);
  Application.CreateForm(TfProcesses, fProcesses);
  Application.CreateForm(TfSettings, fSettings);
  Application.CreateForm(TUserForm, UserForm);
  Application.CreateForm(TfProcessRawLog, fProcessRawLog);
  Application.CreateForm(TfScript, fScript);
  Application.CreateForm(TfPlugins, fPlugins);
  Application.CreateForm(TfClassesDLG, fClassesDLG);
  Application.CreateForm(TfPacketViewer, fPacketViewer);
  Application.CreateForm(TfLangSelectDialog, fLangSelectDialog);
  Application.CreateForm(TfCompilling, fCompilling);
//  Application.ShowMainForm := false;
  fSettings.init;
  fMain.INIT;
  fPlugins.init;
  fScript.init;
  fMainReplacer.HideSplash.Enabled := true;
  fMainReplacer.Status.Hide;
  Application.Run;

end.
