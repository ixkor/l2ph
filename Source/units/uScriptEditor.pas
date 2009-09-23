unit uScriptEditor;

interface

uses
  math, Windows, variants, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvEditorCommon, JvEditor, JvHLEditor, JvTabBar,
  StdCtrls, Mask, JvExMask, JvSpin, ComCtrls, ToolWin, ImgList, ecSyntAnal,
  ecKeyMap, ecPopupCtrl, ecSyntMemo, ecAutoReplace, ecSyntDlg, fs_ipascal,
  fs_iinterpreter, StdActns, ActnList, ExtCtrls, siComp;

type

  tDebugItem = class(tobject)
  VarName: String;
  VarTyp: TfsVarType;
  OldValue: Variant;
  Item:TListItem;
  list_: TList;
  LastModifiedLine: Integer;
  procedure updateitem;
  procedure updateValue;
  Constructor Create(PutTo:TList;List:tlistview;name:string;VarTyp: TfsVarType; line : integer);
  Destructor Destroy; override;
  end;

  TfScriptEditor = class(TFrame)
    Editor: TSyntaxMemo;
    Source: TSyntTextSource;
    SyntFindDialog1: TSyntFindDialog;
    SyntReplaceDialog1: TSyntReplaceDialog;
    SyntAutoReplace1: TSyntAutoReplace;
    SyntaxManager1: TSyntaxManager;
    AutoComplete: TAutoCompletePopup;
    TemplatePopup1: TTemplatePopup;
    fsScript: TfsScript;
    fsPascal1: TfsPascal;
    imglGutterGlyphs: TImageList;
    actlMain: TActionList;
    actDebugStep: TAction;
    actDebugGotoCursor: TAction;
    actToggleBreakpoint: TAction;
    actClearAllBreakpoints: TAction;
    EditPaste1: TEditPaste;
    Splitter1: TSplitter;
    PnWatchList: TPanel;
    WatchList: TListView;
    CurLineLabel: TLabel;
    siLang1: TsiLang;
    procedure EditorChange(Sender: TObject);
    procedure EditorKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditorTGutterObjects1CheckLine(Sender: TObject;
      Line: Integer; var Show: Boolean);
    function fsScriptGetVarValue(VarName: String; VarTyp: TfsVarType;
      OldValue: Variant): Variant;
    procedure fsScriptRunLine(Sender: TfsScript; const UnitName,
      SourcePos: String);
    procedure EditorTGutterObjects3CheckLine(Sender: TObject;
      Line: Integer; var Show: Boolean);
    procedure EditorTGutterObjects2CheckLine(Sender: TObject;
      Line: Integer; var Show: Boolean);
    procedure EditorEnter(Sender: TObject);
  private
    { Private declarations }
    FBreakPoints: TList;
    function IsBreakPt(Line: integer): boolean;
  public
    DebugList:Tlist;
    assignedTScript : tobject;
    CurrentLine: integer;
    Nomove, BreakNext:boolean;
    procedure init;
    procedure deinit;
    procedure SetVar(  VarName: String; VarTyp: TfsVarType; OldValue: Variant; Line : integer);
  end;



implementation
uses umain, uglobalfuncs, uscripts;


{$R *.dfm}

procedure TfScriptEditor.EditorChange(Sender: TObject);
begin
BreakNext := false;
Nomove := false;
CurrentLine := -1;
//Для случаев если используеться в "дополнительно" соединения
if not Assigned(assignedTScript) then
  begin
    Editor.Invalidate;
    exit;
  end;

//для редактора. соответственно
if Assigned(assignedTScript) then
  begin
    Tscript(assignedTScript).tab.ImageIndex := 1;
    Tscript(assignedTScript).Modified := true;
    Tscript(assignedTScript).Compilled := false;
  end;
  Editor.Gutter.Objects.Items[0].Line := -1;

  FBreakPoints.Clear;
  Editor.Invalidate;
end;

procedure TfScriptEditor.EditorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not Assigned(assignedTScript) then exit; //не назначен ? мы используемся в "дополнительно".

  if(Key=VK_F9) and (Shift=[]) then
    if Assigned(assignedTScript) then
      if not TScript(assignedTScript).isRunning then
          fScript.btnInitTest.click;

  if(Key=VK_F2) and (Shift=[ssCtrl]) then
    if Assigned(assignedTScript) then
      if TScript(assignedTScript).isRunning then
          fScript.btnFreeTest.click;




{  if(Key=VK_F8) and (Shift=[]) then
  begin
//    BreakNext := true;
    Nomove := false;
  end;

  if(Key=VK_F5) and (Shift=[]) then
  begin

   if IsBreakPt(Editor.CaretPos.Y) then
       FBreakPoints.Remove(TObject(Editor.CaretPos.Y))
     else
     if assigned(assignedTScript) then
     if Tscript(assignedTScript).Compilled then
     if fsScript.IsExecutableLine(Editor.CaretPos.Y+1) then
       FBreakPoints.Add(TObject(Editor.CaretPos.Y));
   Editor.Invalidate;  
  //Ставим, снимаем бряк
  end;
  }
  //ctrl+w
  if (Key in [Ord('W'), Ord('w'), Ord('Ц'), Ord('ц')]) and (Shift=[ssCtrl]) then fScript.JvTabBar1TabClosed(nil, TScript(assignedTScript).Tab) else
  // добавили комбинацию клавиш 'сохранить файл' - ctrl+s
  if(Key in [Ord('S'), Ord('s'), Ord('Ы'), Ord('ы')]) and (Shift=[ssCtrl]) then TScript(assignedTScript).Save else
  // добавили комбинацию клавиш 'проверить синтаксис' - ctrl+f9
  if(Key=VK_F9)and(Shift=[ssCtrl]) then
    TScript(assignedTScript).CompileThisScript;
end;


function TfScriptEditor.IsBreakPt(Line: integer): boolean;
begin
  Result := FBreakPoints.IndexOf(Pointer(Line)) <> -1;
end;

procedure TfScriptEditor.deinit;
begin
  FBreakPoints.Destroy;
  while DebugList.Count > 0 do
    tDebugItem(DebugList.Items[0]).Destroy;
  DebugList.Destroy;
end;

procedure TfScriptEditor.init;
begin
  FBreakPoints := TList.Create;
  DebugList := TList.Create;
//  BreakNext := false;
  CurrentLine := -1;
  Nomove := false;
end;

procedure TfScriptEditor.EditorTGutterObjects1CheckLine(Sender: TObject;
  Line: Integer; var Show: Boolean);
begin
  Show := IsBreakPt(Line) and (CurrentLine <> Line);
end;

function TfScriptEditor.fsScriptGetVarValue(VarName: String;
  VarTyp: TfsVarType; OldValue: Variant): Variant;
begin
  if not Assigned(assignedTScript) then exit; //не назначен ? мы используемся в "дополнительно".
  SetVar(VarName, VarTyp, OldValue, currentline);
end;

procedure TfScriptEditor.fsScriptRunLine(Sender: TfsScript; const UnitName,
  SourcePos: String);
var
str:string;
begin             { TODO : Надо будет отключать }
if not Assigned(assignedTScript) then exit; //не назначен ? мы используемся в "дополнительно".
str := copy(SourcePos, 1, pos(':',SourcePos)-1);
if str <> '' then
  begin
    CurrentLine := StrToInt(str);
    if IsBreakPt(CurrentLine) or BreakNext then
      begin
        Nomove := true;
      end;
    CurLineLabel.Caption := format(siLang1.GetTextOrDefault('IDS_0' (* 'Last processed line %d' *) ),[CurrentLine]);
  end;
end;

procedure TfScriptEditor.EditorTGutterObjects3CheckLine(Sender: TObject;
  Line: Integer; var Show: Boolean);
begin
try
  if assigned(assignedTScript) then
    begin
      show := fsScript.IsExecutableLine(Line+1) and Tscript(assignedTScript).Compilled;
    end;

except
end;
end;

{ tDebugItem }

constructor tDebugItem.Create;
begin
  list_ := putto;
  PutTo.Add(self);
  case VarTyp of
  fvtInt,fvtBool,fvtFloat,fvtChar,fvtString:
    item := List.Items.Insert(0);
  else
    item := List.Items.Add;
  end;


  item.Caption := name;
  Item.SubItems.Add('');
  Item.SubItems.Add('');
  Item.SubItems.Add('');
  LastModifiedLine := Line;
end;

destructor tDebugItem.Destroy;
var
i:integer;
begin
  i := 0;
  while i< list_.Count do
    begin
      if tDebugItem(list_.Items[i]) = self then
        begin
          list_.Delete(i);
          break;
        end;
      inc(i);
    end;
  inherited;
end;

procedure TfScriptEditor.SetVar;
var
i:integer;
NewItem : tDebugItem;
begin
  i := 0;
  while i < DebugList.Count do
  begin
    if tDebugItem(DebugList.Items[i]).VarName = VarName then
      begin
        tDebugItem(DebugList.Items[i]).VarTyp := VarTyp;
        tDebugItem(DebugList.Items[i]).LastModifiedLine := line;
        tDebugItem(DebugList.Items[i]).OldValue := OldValue;
        tDebugItem(DebugList.Items[i]).updateValue;
        exit;
      end; 
    inc(i);
  end;

  NewItem := tDebugItem.Create(DebugList, WatchList, VarName, VarTyp, line);
  NewItem.VarName := VarName;
  NewItem.VarTyp := VarTyp;
  NewItem.OldValue := OldValue;
  NewItem.updateitem;
  NewItem.updateValue;
end;

procedure tDebugItem.updateitem;
begin
case VarTyp of
fvtInt :
  begin
    Item.SubItems.Strings[0] := 'Int';
  end;
fvtBool :
  begin
    Item.SubItems.Strings[0] := 'Bool';
  end;
fvtFloat :
  begin
    Item.SubItems.Strings[0] := 'Float';
  end;
fvtChar :
  begin
    Item.SubItems.Strings[0] := 'Char';
  end;
fvtString :
  begin
    Item.SubItems.Strings[0] := 'Str';
  end;
fvtArray:
  begin
    Item.SubItems.Strings[0] := 'Array';
  end;

fvtClass:
  begin
    Item.SubItems.Strings[0] := 'Class';
  end;

fvtEnum:
  begin
    Item.SubItems.Strings[0] := 'Enum';
  end;

fvtVariant:
  begin
    Item.SubItems.Strings[0] := 'Variant';
  end;

fvtConstructor:
  begin
    Item.SubItems.Strings[0] := 'Constructor';
  end;
else
  begin
    Item.SubItems.Strings[0] := 'Unknown';
  end;

end;

end;

procedure TfScriptEditor.EditorTGutterObjects2CheckLine(Sender: TObject;
  Line: Integer; var Show: Boolean);
begin
//  show := line = CurrentLine;
end;

procedure tDebugItem.updateValue;
begin
if LastModifiedLine >= 0 then
  Item.SubItems.Strings[1] := inttostr(LastModifiedLine)
else
  Item.SubItems.Strings[1] := '';

case VarTyp of
fvtInt :
  begin
    Item.SubItems.Strings[2] := inttostr(VarAsType(OldValue, varInteger));
  end;
fvtBool :
  begin
    if VarAsType(OldValue, varBoolean) then
      Item.SubItems.Strings[2] := 'True'
    else
      Item.SubItems.Strings[2] := 'False'
  end;
fvtFloat :
  begin
    Item.SubItems.Strings[2] := VarAsType(OldValue,varString);
  end;
fvtChar :
  begin
    Item.SubItems.Strings[2] := VarAsType(OldValue, varString);
  end;
fvtString :
  begin
    Item.SubItems.Strings[2] := VarAsType(OldValue, varString);
  end;
end;
end;

procedure TfScriptEditor.EditorEnter(Sender: TObject);
begin
try
if assignedTScript = nil then exit;
if GetModifTime(AppPath+'Scripts\'+(assignedTScript as TScript).ScriptName+'.script') > (assignedTScript as TScript).changetime then
    if MessageDlg(format(siLang1.GetTextOrDefault('IDS_16' (* 'Файл %s был модифицирован внешней программой. Перезагрузить его ?' *) ),[(assignedTScript as TScript).ScriptName]),mtWarning,[mbYes, mbNo],0) = mrYes then
      (assignedTScript as TScript).LoadOriginal
    else
      (assignedTScript as TScript).changetime := GetModifTime(AppPath+'Scripts\'+(assignedTScript as TScript).ScriptName+'.script');
except
end;
end;


end.
