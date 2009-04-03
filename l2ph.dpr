// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_GENERATEJDBG ON
program l2ph;

uses
  FastMM4 in 'fastmm\FastMM4.pas',
  uExcepDialog in 'units\uExcepDialog.pas' {ExceptionDialog},
  Forms,
  uMain in 'units\uMain.pas' {L2PacketHackMain},
  uAboutDialog in 'units\uAboutDialog.pas' {fAbout},
  uConvertForm in 'units\uConvertForm.pas' {fConvert},
  uData in 'units\uData.pas' {dmData: TDataModule},
  uencdec in 'units\uencdec.pas',
  uFilterForm in 'units\uFilterForm.pas' {fPacketFilter},
  uGlobalFuncs in 'units\uglobalfuncs.pas',
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
  uUserForm in 'units\uUserForm.pas' {UserForm},
  uProcessRawLog in 'units\uProcessRawLog.pas' {fProcessRawLog},
  uPlugins in 'units\uPlugins.pas' {fPlugins},
  uPluginData in 'units\uPluginData.pas',
  uScripts in 'units\uScripts.pas' {fScript},
  uScriptEditor in 'units\uScriptEditor.pas' {fScriptEditor: TFrame},
  uFindReplace in 'units\uFindReplace.pas' {fFindReplace};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'L2PacketHack';
  Application.CreateForm(TL2PacketHackMain, L2PacketHackMain);
  Application.CreateForm(TfAbout, fAbout);
  Application.CreateForm(TfConvert, fConvert);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfPacketFilter, fPacketFilter);
  Application.CreateForm(TfLog, fLog);
  Application.CreateForm(TfProcesses, fProcesses);
  Application.CreateForm(TfSettings, fSettings);
  Application.CreateForm(TUserForm, UserForm);
  Application.CreateForm(TfProcessRawLog, fProcessRawLog);
  Application.CreateForm(TfPlugins, fPlugins);
  Application.CreateForm(TfScript, fScript);
  Application.CreateForm(TfFindReplace, fFindReplace);
  fSettings.init;
  L2PacketHackMain.INIT;
  Application.Run;

end.
