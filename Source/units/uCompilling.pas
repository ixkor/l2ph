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
uses umain, uscripts, uMainReplacer;

{$R *.dfm}

{ TfCompilling }

procedure TfCompilling.ActivateMe;
begin
  if fMainReplacer.Visible then
    begin
      fMainReplacer.Status.caption := Label1.caption +': '+Tscript(AssignedSEditor.assignedTScript).ScriptName;
      fMainReplacer.Repaint;
      Application.ProcessMessages;
      exit;
    end;
    
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
