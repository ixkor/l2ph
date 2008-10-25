// JCL_DEBUG_EXPERT_GENERATEJDBG ON
// JCL_DEBUG_EXPERT_INSERTJDBG ON
program l2pbx;

uses
  FastMM4,
  Forms,
  Classes,
  ExcepDialog in 'ExcepDialog.pas' {ExceptionDialog},
  BlowFish in 'BlowFish.pas',
  XorCoding in 'XorCoding.pas',
  NativeAPI in 'NativeAPI.pas',
  advApiHook in 'advApiHook.pas',
  main in 'main.pas' {L2PacketHackMain},
  Coding in 'Coding.pas',
  FindReplaceUnit in 'FindReplaceUnit.pas' {FindReplaceForm},
  phxPlugins in 'phxPlugins.pas',
  helper in 'helper.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.CreateForm(TL2PacketHackMain, L2PacketHackMain);
  Application.CreateForm(TFindReplaceForm, FindReplaceForm);
  Application.Run;
end.
