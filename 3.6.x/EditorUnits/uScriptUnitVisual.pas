unit uScriptUnitVisual;

interface

uses
  Forms, types, sysutils, ecSyntDlg, Controls, ecSyntMemo, ecAutoReplace, ecMacroRec, ImgList,
  ecSyntAnal, Classes, ecMultRepl, siComp, siLngLnk;

type
  TScriptUnitVisual = class(TFrame)
    ecMultiReplace1: TecMultiReplace;
    Source: TSyntTextSource;
    SyntaxManager1: TSyntaxManager;
    imglGutterGlyphs: TImageList;
    ecMacroRecorder1: TecMacroRecorder;
    Editor: TSyntaxMemo;
    SyntFindDialog1: TSyntFindDialog;
    SyntReplaceDialog1: TSyntReplaceDialog;
    siLangLinked1: TsiLangLinked;
    procedure EditorChange(Sender: TObject);
    procedure EditorEnter(Sender: TObject);
    procedure EditorGetStyleEntry(Sender: TObject; CurPos: Integer;
      StyleList: TStyleEntries; var NextPos: Integer);
    procedure EditorKeyPress(Sender: TObject; var Key: Char);
    procedure EditorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditorMouseEnter(Sender: TObject);
    procedure EditorMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EditorTGutterObjects1CheckLine(Sender: TObject; Line: Integer;
      var Show: Boolean);
    procedure EditorTGutterObjects3CheckLine(Sender: TObject; Line: Integer;
      var Show: Boolean);
    procedure EditorTGutterObjects2CheckLine(Sender: TObject; Line: Integer;
      var Show: Boolean);
    procedure EditorGutterClick(Sender: TObject; Line: Integer;
      Buton: TMouseButton; Shift: TShiftState; XY: TPoint);
    procedure EditorTGutterObjects0CheckLine(Sender: TObject; Line: Integer;
      var Show: Boolean);
    procedure EditorMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure EditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FHltToken: integer;
    procedure SetHltToken(Value: integer);

    { Private declarations }
  public
    errorline : integer;
    
    ThisUnit : Tobject;
    procedure SyntKeyMapping1ExecuteCommand(Sender: TObject;
      Command: Integer; Data: Pointer; var Handled: Boolean);
    property HltToken: integer read FHltToken write SetHltToken;
    procedure compleaterefresh(Def:boolean=false);
  end;

implementation
uses uMain, uscriptdata, uScriptEditorResourcesStrings, PaxProgram, uEditorMain, uscriptproject,
  ComCtrls;
{$R *.dfm}

procedure TScriptUnitVisual.compleaterefresh;
 Function cut(what:string; var from:string):Boolean;
  begin
    Result := false;
    if pos(lowercase(what), lowercase(from)) > 0 then
      begin
      delete(from, 1, length(what));
      result := true;
      end;

  end;

  Function MakeShort(str:string):string;
  begin
  Result := str;
  if pos('(', Result)>0 then
    Result := Copy(Result,1,pos('(', Result)-1);

  if pos('[', Result)>0 then
    Result := Copy(Result,1,pos('(', Result)-1);

  if pos(':', Result)>0 then
    Result := Copy(Result,1,pos(':', Result)-1);

  if cut('procedure ', result) then exit;
  if cut('function ', result) then exit;
  if cut('property ', result) then exit;
  if cut('field ', result) then exit;
  if cut('constructor ', result) then exit;
  if cut('destructor ', result) then exit;
  if cut('var ', result) then exit;
  if cut('const ', result) then exit;
  end;

var
  unitname:string;
  mylist : TStringList;
  i : integer;
begin
  with Tunit(ThisUnit).ScriptProject do
  begin
    RefreshSources;
    unitname := tunit(ThisUnit).Unitname;
    mylist := TStringList.Create;
    Visual.AutoComplete.Items.Clear;
    Visual.AutoComplete.DisplayItems.Clear;
    if def then
      updatescripterfuncs(mylist)
    else
      PC.CodeCompletion(unitname, Editor.CaretPos.X-1, Editor.CaretPos.Y, mylist);

    if mylist.Count > 0 then
      begin
      i := 0;
      while i < mylist.Count do
        begin
          Visual.AutoComplete.Items.Add(MakeShort(mylist.Strings[i]));
          Visual.AutoComplete.DisplayItems.Add(mylist.Strings[i]);
          inc(i);
        end;
      end;

    mylist.Destroy;
  end;
end;

procedure TScriptUnitVisual.EditorChange(Sender: TObject);
begin
  if not assigned(ThisUnit) then exit;
  
  Tunit(ThisUnit).modified := true;
  Tunit(ThisUnit).tab.ImageIndex := 1;
  errorline := -1;
end;

procedure TScriptUnitVisual.EditorEnter(Sender: TObject);
begin
  Editor.KeyMapping.OnExecuteCommand := SyntKeyMapping1ExecuteCommand;
  Tunit(ThisUnit).ScriptProject.visual.TemplatePopup.SyntMemo := Editor;
  Tunit(ThisUnit).ScriptProject.visual.AutoComplete.SyntMemo := Editor;
  Tunit(ThisUnit).ScriptProject.visual.AutoReplace.SyntMemo := Editor;  
end;

procedure TScriptUnitVisual.EditorGetStyleEntry(Sender: TObject;
  CurPos: Integer; StyleList: TStyleEntries; var NextPos: Integer);
begin
  if Editor.UserStyles = nil then exit;
  
  NextPos := -1;
  if (FHltToken <> -1) and (Editor.UserStyles.Styles.Count > 0) then
   with Editor.SyntObj do

    if (FHltToken < TagCount) and (Tags[FHltToken].StartPos <= CurPos)
       and (Tags[FHltToken].EndPos > CurPos) then
     begin
      StyleList.Add(TStyleEntry.Create(Editor.UserStyles.Styles[0],
                                       Tags[FHltToken].StartPos,
                                       Tags[FHltToken].EndPos));
      NextPos := Tags[FHltToken].EndPos;
     end else
    if CurPos < Tags[FHltToken].StartPos then
      NextPos := Tags[FHltToken].StartPos;
end;

procedure TScriptUnitVisual.EditorGutterClick(Sender: TObject; Line: Integer;
  Buton: TMouseButton; Shift: TShiftState; XY: TPoint);
begin
if (buton = mbLeft) and (xy.x < 20) then
begin
    tUnit(thisunit).togglebp(Line);
    Editor.Invalidate;
end;
end;

procedure TScriptUnitVisual.EditorKeyPress(Sender: TObject; var Key: Char);
begin
  if errorline >= 0 then
    begin
      errorline := -1;
      Editor.Invalidate;
    end;

end;

procedure TScriptUnitVisual.EditorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 190 then
    Editor.ExecCommand(700, pointer(1));
end;

procedure TScriptUnitVisual.EditorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const IdentifierTokenIndex = 2;
var TokIdx: Integer;
begin
  if (ssCtrl in Shift) and (Button = mbLeft)  then
   begin
     TokIdx := Editor.SyntObj.TokenAtPos(Editor.CaretPosToStrPos(Editor.MouseToCaret(X,Y)));
     if (TokIdx <> -1) and (Editor.SyntObj.Tags[TokIdx].TokenType = IdentifierTokenIndex) then
         begin
           Tunit(ThisUnit).ScriptProject.InspectVariable(Editor.SyntObj.TagStr[TokIdx]);
         end;
     Abort;
   end;
end;

procedure TScriptUnitVisual.EditorMouseEnter(Sender: TObject);
begin
  HltToken := -1;
end;

procedure TScriptUnitVisual.EditorMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
const IdentifierTokenIndex = 2;
var TokIdx: Integer;
begin
  if (ssCtrl in Shift) then
    begin
      HltToken := Editor.TokenAtPos(Point(X, Y));
      TokIdx := Editor.SyntObj.TokenAtPos(Editor.CaretPosToStrPos(Editor.MouseToCaret(X,Y)));
      if (TokIdx <> -1) and (Editor.SyntObj.Tags[TokIdx].TokenType = IdentifierTokenIndex) then
        if not Tunit(ThisUnit).ScriptProject.CanInspectVariable(Editor.SyntObj.TagStr[TokIdx]) then
        HltToken := -1;
    end
  else
    HltToken := -1;

end;


procedure TScriptUnitVisual.EditorMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
if ssCtrl in Shift then
begin
if WheelDelta > 0 then
  Editor.Zoom := Editor.Zoom + 10
else
  Editor.Zoom := Editor.Zoom - 10;
Abort;
end;
end;

procedure TScriptUnitVisual.EditorTGutterObjects0CheckLine(Sender: TObject;
  Line: Integer; var Show: Boolean);
begin
  show := line = errorline;
end;

procedure TScriptUnitVisual.EditorTGutterObjects1CheckLine(Sender: TObject;
  Line: Integer; var Show: Boolean);
begin
if assigned(thisunit) then
  show := assigned(tUnit(thisunit).findbp(line));
end;

procedure TScriptUnitVisual.EditorTGutterObjects2CheckLine(Sender: TObject;
  Line: Integer; var Show: Boolean);
begin

if tunit(ThisUnit).ScriptProject.PCD.Valid then
  if tunit(ThisUnit).ScriptProject.PCD.IsPaused then
    if lowercase(tunit(ThisUnit).ScriptProject.PauseUnit) = lowercase(tunit(ThisUnit).Unitname) then
      show := Line = tunit(ThisUnit).ScriptProject.PauseLine;


end;

procedure TScriptUnitVisual.EditorTGutterObjects3CheckLine(Sender: TObject;
  Line: Integer; var Show: Boolean);
begin
if tunit(ThisUnit).ScriptProject.PCD.Valid then
 show := tunit(ThisUnit).ScriptProject.PCE.IsExecutableLine(tunit(ThisUnit).Unitname, Line);

end;

procedure TScriptUnitVisual.SetHltToken(Value: integer);
var Upd: TPoint; // updating range
begin
  if Value <> -1 then
   if editor.SyntObj.Tags[Value].TokenType <> 2 {Identifier} then
    Value := -1;

  Upd.X := -1;
  if FHltToken <> Value then
   begin
    if (FHltToken >= 0) and (FHltToken < editor.SyntObj.TagCount) then
     with editor.SyntObj.Tags[FHltToken] do
      Upd := Point(StartPos, EndPos);

    FHltToken := Value;

    if (FHltToken >= 0) and (FHltToken < editor.SyntObj.TagCount) then
     with editor.SyntObj.Tags[FHltToken] do
      if Upd.X = -1 then Upd := Point(StartPos, EndPos) else
       begin
        if Upd.X > StartPos then Upd.X := StartPos;
        if Upd.Y < EndPos then Upd.Y := EndPos;
       end;
    editor.InvalidateTextRange(Upd.X, Upd.Y, not false);
   end;
end;

procedure TScriptUnitVisual.SyntKeyMapping1ExecuteCommand(Sender: TObject;
  Command: Integer; Data: Pointer; var Handled: Boolean);
begin
case command of
700: begin
      compleaterefresh(data=nil);
     end;
9000: //bp
  begin
    tUnit(thisunit).togglebp(Editor.CurrentLine);
    Editor.Invalidate;
  end;

9001:  //resume
  begin
    if not DebugEnable then
    begin
      if Tunit(ThisUnit).ScriptProject.WasInited then
        Tunit(ThisUnit).ScriptProject.Terminate;
      if not Tunit(ThisUnit).ScriptProject.WasCompilled then
        Tunit(ThisUnit).ScriptProject.Compile(DebugEnable);
      Tunit(ThisUnit).ScriptProject.CallAction(ActionInit, _rmRUN);
    end
    else
    begin
      Tunit(ThisUnit).ScriptProject.Run(_rmRUN);
    end;
  end;
9002:  //compile
  begin
    Tunit(ThisUnit).ScriptProject.Compile(DebugEnable);
  end;

9003:  //terminate
  begin
    Tunit(ThisUnit).ScriptProject.CallAction(ActionFree, _rmRUN);
    Tunit(ThisUnit).ScriptProject.Terminate;
  end;

9004:// Step Over
  begin
    if not DebugEnable then exit;
    Tunit(ThisUnit).ScriptProject.Run(_rmRUN);
  end;
9005:// Step into
  begin
    if not DebugEnable then exit;
    Tunit(ThisUnit).ScriptProject.Run(_rmTRACE_INTO);
  end;
  
9010:// save unit
  begin
    tUnit(thisunit).save;
  end;
9011:// save unit
  begin
    Tunit(ThisUnit).ScriptProject.saveallunits;
  end;
9012:
  begin
    tUnit(thisunit).Tab.Visible := false;
    tUnit(thisunit).Visual.Hide;
    tUnit(thisunit).Visual.Editor.Hide;
  end;
9013:
  begin
    Tunit(ThisUnit).ScriptProject.nexttab;
  end;
9014:
  begin
    Tunit(ThisUnit).ScriptProject.prevtab;
  end;
end;

if (command >= 9000) and (command < 9012) then
  editor.Invalidate;
end;

end.
