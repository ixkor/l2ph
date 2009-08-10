unit uCompilling;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, fs_iinterpreter, uscripteditor, siComp;

type
  TfCompilling = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    lang: TsiLang;
  private
    { Private declarations }
  public
    AssignedSEditor: tfscripteditor;
    procedure ActivateMe;
    procedure DeActivateMe;
    { Public declarations }
  end;

var
  fCompilling: TfCompilling;

implementation
uses umain, uscripts;

{$R *.dfm}

{ TfCompilling }

procedure TfCompilling.ActivateMe;
begin
  Label2.Caption := Tscript(AssignedSEditor.assignedTScript).ScriptName;
  show;
  Application.ProcessMessages;
end;

procedure TfCompilling.DeActivateMe;
begin
  hide;
end;

{ tUpdateThread }

end.
