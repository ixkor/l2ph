unit uScriptEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvEditorCommon, JvEditor, JvHLEditor, JvTabBar,
  StdCtrls, Mask, JvExMask, JvSpin, ComCtrls, ToolWin, ImgList;

type
  TfScriptEditor = class(TFrame)
    JvHLEditor1: TJvHLEditor;
    procedure JvHLEditor1Change(Sender: TObject);
    procedure JvHLEditor1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

  public
    assignedTScript : tobject;
    procedure FindWords;
    procedure ReplaceWords;
  end;

implementation
uses uFindReplace, uscripts;

{$R *.dfm}

procedure TfScriptEditor.FindWords;
begin
  fFindReplace.PageControl1.ActivePageIndex:=0;
  fFindReplace.ShowModal; //поиск и замена в редакторе скриптов
  {}
end;

procedure TfScriptEditor.JvHLEditor1Change(Sender: TObject);
begin
if Assigned(assignedTScript) then
  begin
  Tscript(assignedTScript).tab.ImageIndex := 1;
  Tscript(assignedTScript).Modified := true;
  Tscript(assignedTScript).Compilled := false;

  end;
end;

procedure TfScriptEditor.JvHLEditor1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  JvHLEditor1.SelBackColor:=clHighlight;
  JvHLEditor1.SelBackColor:=clHighlight;
  // добавили комбинацию клавиш 'сохранить файл' - ctrl+s
  if(Key in [Ord('S'), Ord('s')])and(Shift=[ssCtrl]) then TScript(assignedTScript).Save else
  // добавили комбинацию клавиш 'проверить синтаксис' - ctrl+f9
  if(Key=VK_F9)and(Shift=[ssCtrl]) then TScript(assignedTScript).CompileThisScript;
  // добавили комбинацию клавиш 'поиск' - ctrl+f
  if(Key in [Ord('F'), Ord('f')])and(Shift=[ssCtrl]) then FindWords;
  if(Key in [Ord('R'), Ord('r')])and(Shift=[ssCtrl]) then ReplaceWords;
end;

procedure TfScriptEditor.ReplaceWords;
begin
  fFindReplace.PageControl1.ActivePageIndex:=1;
  fFindReplace.ShowModal; //поиск и замена в редакторе скриптов
  {}
end;

end.
