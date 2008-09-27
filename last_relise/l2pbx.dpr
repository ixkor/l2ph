program l2pbx;

uses
  FastMM4,
  Forms,
  Classes,
  BlowFish in 'BlowFish.pas',
  XorCoding in 'XorCoding.pas',
  NativeAPI in 'NativeAPI.pas',
  advApiHook in 'advApiHook.pas',
  main in 'main.pas' {L2PacketHackMain},
  Coding in 'Coding.pas',
  FindReplaceUnit in 'FindReplaceUnit.pas' {FindReplaceForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TL2PacketHackMain, L2PacketHackMain);
  Application.CreateForm(TFindReplaceForm, FindReplaceForm);
  Application.Run;
end.
