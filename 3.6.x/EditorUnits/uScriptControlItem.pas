unit uScriptControlItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, siComp, siLngLnk;

type
  TfScriptControlItem = class(TFrame)
    Panel23: TPanel;
    Scriptname: TLabel;
    SpeedButton2: TSpeedButton;
    scriptactive: TCheckBox;
    siLangLinked1: TsiLangLinked;
    procedure SpeedButton2Click(Sender: TObject);
    procedure scriptactiveClick(Sender: TObject);
    procedure ScriptnameMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    Project:tobject;
    Function selectProject:boolean;
    { Public declarations }
  end;

implementation
uses uMain, PaxProgram, uScriptEditorResourcesStrings, uScriptProject, uEditorMain, uScriptControl;

{$R *.dfm}

procedure TfScriptControlItem.scriptactiveClick(Sender: TObject);
begin
if scriptactive.Checked  then
  begin
  if not TScriptProject(Project).CanUse then
  begin
    if not TScriptProject(Project).WasInited then
      begin
         TScriptProject(Project).Compile(DebugEnable);
         TScriptProject(Project).CallAction(ActionInit, _rmRUN);
      end;
    TScriptProject(Project).CanUse := TScriptProject(Project).WasInited and TScriptProject(Project).WasCompilled;
    TScriptProject(Project).Visual.tbUsing.Down := TScriptProject(Project).CanUse;
    scriptactive.Checked := TScriptProject(Project).CanUse;
  end;
  end
else
  begin
    TScriptProject(Project).CallAction(ActionFree, _rmRUN);
  end;
fScriptControl.rebuild;
end;

procedure TfScriptControlItem.ScriptnameMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const  SC_DragMove = $F012;
begin
if selectProject then
if button = mbLeft then
begin
  ReleaseCapture;
  perform(WM_SysCommand, SC_DragMove, 0);
  Align := alNone;
  Align := alTop;
  fScriptControl.rebuild;
end;
end;

Function TfScriptControlItem.selectProject;
var
i:integer;
begin
Result := false;
i := 0;
while i < fscriptcontrol.ProjectsList.Count do
  begin
    if fscriptcontrol.ProjectsList.Items[i] = Project then
      begin
      if TScriptProject(fscriptcontrol.ProjectsList.Items[i]).selected then
        begin
          Result := true;
          exit;
        end;     
      TScriptProject(fscriptcontrol.ProjectsList.Items[i]).selected := true;
      TScriptProject(fscriptcontrol.ProjectsList.Items[i]).ProjItem.Scriptname.Font.Style := [fsbold];
      end
    else
      begin
      TScriptProject(fscriptcontrol.ProjectsList.Items[i]).selected := false;
      TScriptProject(fscriptcontrol.ProjectsList.Items[i]).ProjItem.Scriptname.Font.Style := [];
      end;
    inc(i);
  end;


end;

procedure TfScriptControlItem.SpeedButton2Click(Sender: TObject);
begin
 TScriptProject(Project).Show;
end;

end.
