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
    Source: TSyntTextSource;
    SyntFindDialog1: TSyntFindDialog;
    SyntReplaceDialog1: TSyntReplaceDialog;
    SyntAutoReplace1: TSyntAutoReplace;
    SyntKeyMapping1: TSyntKeyMapping;
    SyntaxManager1: TSyntaxManager;
    AutoComplete: TAutoCompletePopup;
    TemplatePopup1: TTemplatePopup;
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
//ƒл€ случаев если используетьс€ в "дополнительно" соединени€
if not Assigned(assignedTScript) then
  begin
    Editor.LineStateDisplay.UnchangedColor := clNone;
    Editor.LineStateDisplay.NewColor := clNone;
    Editor.LineStateDisplay.SavedColor := clNone;
    Editor.Invalidate;
    exit;
  end;

//дл€ редактора. соответственно
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
  if not Assigned(assignedTScript) then exit; //не назначен ? мы используемс€ в "дополнительно".


  //ctrl+w
  if (Key in [Ord('W'), Ord('w'), Ord('÷'), Ord('ц')]) and (Shift=[ssCtrl]) then fScript.JvTabBar1TabClosed(nil, TScript(assignedTScript).Tab) else
  // добавили комбинацию клавиш 'сохранить файл' - ctrl+s
  if(Key in [Ord('S'), Ord('s'), Ord('џ'), Ord('ы')]) and (Shift=[ssCtrl]) then TScript(assignedTScript).Save else
  // добавили комбинацию клавиш 'проверить синтаксис' - ctrl+f9
  if(Key=VK_F9)and(Shift=[ssCtrl]) then
    TScript(assignedTScript).CompileThisScript;
end;

end.
