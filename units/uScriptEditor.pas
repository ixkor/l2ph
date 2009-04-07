unit uScriptEditor;

interface

uses 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvEditorCommon, JvEditor, JvHLEditor, JvTabBar,
  StdCtrls, Mask, JvExMask, JvSpin, ComCtrls, ToolWin, ImgList, ecSyntAnal,
  ecKeyMap, ecPopupCtrl, ecSyntMemo, ecAutoReplace, ecSyntDlg;

type
  TfScriptEditor = class(TFrame)
    Editor: TSyntaxMemo;
    SyntaxManager1: TSyntaxManager;
    AutoComplete: TAutoCompletePopup;
    Source: TSyntTextSource;
    SyntFindDialog1: TSyntFindDialog;
    SyntReplaceDialog1: TSyntReplaceDialog;
    SyntAutoReplace1: TSyntAutoReplace;
    TemplatePopup1: TTemplatePopup;
    SyntKeyMapping1: TSyntKeyMapping;
    SyntAnalyzer1: TSyntAnalyzer;
    procedure EditorChange(Sender: TObject);
    procedure EditorKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

  public
    assignedTScript : tobject;
    procedure FindWords;
    procedure ReplaceWords;
  end;

implementation
uses uscripts;

{$R *.dfm}

procedure TfScriptEditor.FindWords;
begin
{ TODO : Find Here }
end;

procedure TfScriptEditor.ReplaceWords;
begin
 { TODO : replace here }
end;

procedure TfScriptEditor.EditorChange(Sender: TObject);
begin
//Для случаев если используеться в "дополнительно" соединения
if not Assigned(assignedTScript) then
  begin
    Editor.LineStateDisplay.UnchangedColor := clNone;
    Editor.LineStateDisplay.NewColor := clNone;
    Editor.LineStateDisplay.SavedColor := clNone;
    Editor.Invalidate;
    exit;
  end;

//для редактора. соответственно
if Assigned(assignedTScript) then
  begin
    Tscript(assignedTScript).tab.ImageIndex := 1;
    if not Tscript(assignedTScript).Modified then
    begin
      Editor.LineStateDisplay.UnchangedColor := clNone;
      Editor.LineStateDisplay.NewColor := clNone;
      Editor.LineStateDisplay.SavedColor := clNone;
      Editor.Invalidate;
    end;

    Tscript(assignedTScript).Modified := true;
    Tscript(assignedTScript).Compilled := false;
  end;
  Editor.Gutter.Objects.Items[0].Line := -1;


end;

procedure TfScriptEditor.EditorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not Assigned(assignedTScript) then exit; //не назначен ? мы используемся в "дополнительно".
  
  // добавили комбинацию клавиш 'сохранить файл' - ctrl+s
  if(Key in [Ord('S'), Ord('s')]) and (Shift=[ssCtrl]) then TScript(assignedTScript).Save else
  // добавили комбинацию клавиш 'проверить синтаксис' - ctrl+f9
  if(Key=VK_F9)and(Shift=[ssCtrl]) then
    TScript(assignedTScript).CompileThisScript;
end;

end.
