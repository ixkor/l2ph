unit uEditorMain;

interface

uses
  Buttons,
  Classes,
  Controls,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  ImgList,
  IniFiles,
  Math,
  Menus,
  StdCtrls,
  StrUtils,
  Types,
  Variants,
  VarUtils,
  PaxCompiler,
  PaxRegister,
  uScriptProject,
  Windows,
  SysUtils,
  Messages,


  ecActns, ActnList, ecSyntAnal, siComp, ecKeyMap, ComCtrls,
  ToolWin, JvDockControlForm, JvComponentBase, JvDockTree, JvDockVIDStyle,
  JvDockVSNetStyle;

type
  TfEditorMain = class(TForm)
    ImageList1: TImageList;
    SyntKeyMapping1: TSyntKeyMapping;
    SyntAnalyser: TSyntAnalyzer;
    SyntStyles1: TSyntStyles;
    MM: TMainMenu;
    mmEdit: TMenuItem;
    mmSynchEdit: TMenuItem;
    N2: TMenuItem;
    mmUndo: TMenuItem;
    mmRedo: TMenuItem;
    N3: TMenuItem;
    mmCopy: TMenuItem;
    mmCut: TMenuItem;
    mmPaste: TMenuItem;
    mmDelete: TMenuItem;
    N4: TMenuItem;
    mmSort: TMenuItem;
    mmSortAZ: TMenuItem;
    mmSortZA: TMenuItem;
    mmMacroses: TMenuItem;
    Play1: TMenuItem;
    N17: TMenuItem;
    Record1: TMenuItem;
    Stop1: TMenuItem;
    Cancel1: TMenuItem;
    mmSearch: TMenuItem;
    mmFind: TMenuItem;
    mmReplace: TMenuItem;
    N13: TMenuItem;
    mmGoLine: TMenuItem;
    mmView: TMenuItem;
    mmNonPrinted: TMenuItem;
    mmWordWrap: TMenuItem;
    N10: TMenuItem;
    mmToggleFolding: TMenuItem;
    Options1: TMenuItem;
    mmHotKeys: TMenuItem;
    mmSynHightlight: TMenuItem;
    mmSyntaxlexer: TMenuItem;
    N1: TMenuItem;
    mmSaveDocks: TMenuItem;
    mmLoadDocks: TMenuItem;
    mmDebug: TMenuItem;
    estinit1: TMenuItem;
    mmCallInit: TMenuItem;
    mmCallFree: TMenuItem;
    mmTerminate: TMenuItem;
    N7: TMenuItem;
    mmToggleBP: TMenuItem;
    mmRun: TMenuItem;
    mmStepOver: TMenuItem;
    mmTraceIn: TMenuItem;
    mmWinLogs: TMenuItem;
    mmObjInspector: TMenuItem;
    mmErrorLog: TMenuItem;
    mmPrintLogs: TMenuItem;
    mmCalStack: TMenuItem;
    mmWatchList: TMenuItem;
    N5: TMenuItem;
    mmScripts: TMenuItem;
    Actionlist: TActionList;
    ecCommandRedo: TecCommandAction;
    ecCommandAction1: TecCommandAction;
    ecCommandAction2: TecCommandAction;
    ecSearch1: TecSearch;
    ecReplace1: TecReplace;
    ecUserRangeDelete1: TecUserRangeDelete;
    ecUserRangeCollapsable1: TecUserRangeCollapsable;
    ecUserRangeTopLine1: TecUserRangeTopLine;
    ecGotoLine1: TecGotoLine;
    ecUserRangeBottomLine1: TecUserRangeBottomLine;
    ecToggleNonPrinted1: TecToggleNonPrinted;
    ecToggleWordWrap1: TecToggleWordWrap;
    ecCopy1: TecCopy;
    ecPaste1: TecPaste;
    ecCut1: TecCut;
    ecClear1: TecClear;
    ecUndo1: TecUndo;
    ecToggleFolding1: TecToggleFolding;
    ecMacroRecord1: TecMacroRecord;
    ecMacroStop1: TecMacroStop;
    ecMacroPlay1: TecMacroPlay;
    ecSortAscending1: TecSortAscending;
    ecSortDescending1: TecSortDescending;
    ecMacroCancel1: TecMacroCancel;
    ecCommandAction4: TecCommandAction;
    ecCommandAction5: TecCommandAction;
    ecSyncEditMode1: TecSyncEditMode;
    ToolBar: TToolBar;
    tbUndo: TToolButton;
    tbRedo: TToolButton;
    ToolButton9: TToolButton;
    tbCopy: TToolButton;
    tbCut: TToolButton;
    tbPaste: TToolButton;
    tbDelete: TToolButton;
    ToolButton12: TToolButton;
    tbSyntEdit: TToolButton;
    ToolButton16: TToolButton;
    tbSearch: TToolButton;
    tbReplace: TToolButton;
    ToolButton21: TToolButton;
    tbMoveLeft: TToolButton;
    tbMoveRight: TToolButton;
    ToolButton11: TToolButton;
    tbWordWrap: TToolButton;
    tbNonprinted: TToolButton;
    tbToggleFolding: TToolButton;
    ToolButton31: TToolButton;
    tbSortAZ: TToolButton;
    tbSortZA: TToolButton;
    ToolButton67: TToolButton;
    tbMoveUp: TToolButton;
    tbMoveDown: TToolButton;
    ToolButton18: TToolButton;
    tbUserrangeFolding: TToolButton;
    tbuserrangeTop: TToolButton;
    tbUserrangeBottom: TToolButton;
    tbUserrangeDelete: TToolButton;
    statusbar: TStatusBar;
    JvDockVSNetStyle1: TJvDockVSNetStyle;
    JvDockServer1: TJvDockServer;
    mmVariables: TMenuItem;
    siLang1: TsiLang;
    procedure mmObjInspectorClick(Sender: TObject);
    procedure mmErrorLogClick(Sender: TObject);
    procedure mmPrintLogsClick(Sender: TObject);
    procedure mmCalStackClick(Sender: TObject);
    procedure mmWatchListClick(Sender: TObject);
    procedure mmHotKeysClick(Sender: TObject);
    procedure mmSynHightlightClick(Sender: TObject);
    procedure mmSyntaxlexerClick(Sender: TObject);
    procedure mmSaveDocksClick(Sender: TObject);
    procedure mmLoadDocksClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mmVariablesClick(Sender: TObject);
    procedure mmScriptsClick(Sender: TObject);
    procedure estinit1Click(Sender: TObject);
    procedure mmCallInitClick(Sender: TObject);
    procedure mmCallFreeClick(Sender: TObject);
    procedure mmTerminateClick(Sender: TObject);
    procedure mmToggleBPClick(Sender: TObject);
    procedure mmRunClick(Sender: TObject);
    procedure mmStepOverClick(Sender: TObject);
    procedure mmTraceInClick(Sender: TObject);
    procedure ToolButton22Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure CreateParams (var Params : TCreateParams); override;  
  public
    { Public declarations }
    CurrentProject : tobject;
    procedure init;
  end;

var
  fEditorMain: TfEditorMain;
//  list:tstringlist;

implementation
uses
IMPORT_COMMON,
uMain,
uGlobalFuncs,uMainReplacer,
uScriptEditorResourcesStrings,
uUserForm, uScriptCallStack, uScriptErrors, uObjInspector, uScriptPrints,
  uScriptWatchList, uScriptVariables, uScriptControl, uScriptProjectVisual;

{$R *.dfm}

procedure TfEditorMain.mmCalStackClick(Sender: TObject);
begin
  ShowDockForm(fScriptCallStack);
end;

procedure TfEditorMain.mmScriptsClick(Sender: TObject);
begin
fScriptControl.show;
end;

procedure TfEditorMain.mmErrorLogClick(Sender: TObject);
begin
  ShowDockForm(fScriptErrors);
end;

procedure TfEditorMain.mmCallFreeClick(Sender: TObject);
begin
if not assigned(CurrentProject) then exit;
TScriptProject(CurrentProject).Visual.tbFree.Click;
end;

procedure TfEditorMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    ExStyle := ExStyle OR WS_EX_APPWINDOW or WS_EX_CONTROLPARENT;
end;

procedure TfEditorMain.estinit1Click(Sender: TObject);
begin
if not assigned(CurrentProject) then exit;
TScriptProject(CurrentProject).Visual.tbCompile.Click;
end;

procedure TfEditorMain.mmCallInitClick(Sender: TObject);
begin
if not assigned(CurrentProject) then exit;
TScriptProject(CurrentProject).Visual.tbInit.Click;
end;

procedure TfEditorMain.FormCreate(Sender: TObject);
begin
AppPath := ExtractFilePath(Application.ExeName);

if not DirectoryExists(AppPath+'Scripts\') then
  MkDir(AppPath+'Scripts\');

if not DirectoryExists(AppPath+'settings\') then
    MkDir(AppPath+'settings\');

if FileExists(AppPath+'settings\lexer.lcf') then
  SyntAnalyser.LoadFromFile(AppPath+'settings\lexer.lcf');

if FileExists(AppPath+'settings\Key_map.dat') then
  LoadComponentFromFile(SyntKeyMapping1, AppPath+'settings\Key_map.dat');

  mmToggleBP.Visible := DebugEnable;
  mmRun.Visible := DebugEnable;
  mmStepOver.Visible := DebugEnable;
  mmTraceIn.Visible := DebugEnable;
  mmCalStack.Visible := DebugEnable;
  mmWatchList.Visible := DebugEnable;
  mmVariables.Visible := DebugEnable;
  loadpos(self);

end;

procedure TfEditorMain.FormDestroy(Sender: TObject);
begin
  savepos(self);
end;

procedure TfEditorMain.mmSynHightlightClick(Sender: TObject);
begin
  if SyntAnalyser.Customize then
  begin
    if not DirectoryExists(AppPath+'settings\') then
      MkDir(AppPath+'settings\');
    SyntAnalyser.SaveToFile(AppPath+'settings\lexer.lcf');
  end;
end;

procedure TfEditorMain.init;
function isProjectPresent(str:string):boolean;
var
  i:integer;
begin
  i := 0;
  Result := false;
  while i < fScriptControl.ProjectsList.Count do
    begin
      if lowercase(TScriptProject(fScriptControl.ProjectsList.Items[i]).Filename) = LowerCase(str) then
        begin
          Result := true;
          exit;
        end;
      inc(i);
    end;
end;
var
  SearchRec: TSearchRec;
  Mask: string;
  i : integer;
  tempname:string;
  ini : tinifile;
begin
//siLangDispatcher1.SaveAllToFile('C:\Documents and Settings\Admin\Рабочий стол\PC\settings\1.txt','§');
if fileexists(AppPath+'settings\editor_docking.dat') then
  LoadDockTreeFromFile(AppPath+'settings\editor_docking.dat');
hide;

fScriptControl.norebuild := true;
Mask := AppPath+'Scripts\*.PHsp';
ini := TIniFile.Create(AppPath+'settings\Scripts.ini');
i := 0;
while i < ini.ReadInteger('PHsp','ScriptCount',0) do
begin
  tempname := ini.ReadString('PHsp','name'+inttostr(i),'');
  if fileexists(AppPath+'Scripts\'+tempname+'.PHsp') then
    begin
      with TScriptProject.Create(self)
      do
          begin
            init(self,UserForm,fScriptControl.ProjectsList,statusbar);
            LoadProject(AppPath+'Scripts\'+tempname+'.PHsp');
            ProjItem.scriptactive.Checked := ini.ReadBool('PHsp','active'+inttostr(i), false);
          end;
    end;
  Inc(i);
end;
ini.Destroy;

  //все остальное
  if FindFirst(Mask, faAnyFile, SearchRec) = 0 then
  begin
    repeat
     if not isProjectPresent(AppPath+'Scripts\'+SearchRec.Name) then
      with TScriptProject.Create(self)
      do
          begin
            init(self,UserForm,fScriptControl.ProjectsList,statusbar);
            LoadProject(AppPath+'Scripts\'+SearchRec.Name);
          end;
    until FindNext(SearchRec)<>0;
    FindClose(SearchRec);
  end;
fScriptControl.norebuild := false;
end;


procedure TfEditorMain.mmHotKeysClick(Sender: TObject);
begin
  SyntKeyMapping1.Customize;
  if not DirectoryExists(AppPath+'settings\') then
    MkDir(AppPath+'settings\');

  SaveComponentToFile(SyntKeyMapping1, AppPath+'settings\Key_map.dat');
end;

procedure TfEditorMain.mmLoadDocksClick(Sender: TObject);
begin
  if fileexists(AppPath+'settings\editor_docking.dat') then
    LoadDockTreeFromFile(AppPath+'settings\editor_docking.dat');
end;

procedure TfEditorMain.mmVariablesClick(Sender: TObject);
begin
  ShowDockForm(fScriptVariables);
end;

procedure TfEditorMain.mmObjInspectorClick(Sender: TObject);
begin
  ShowDockForm(fObjInspector);
end;

procedure TfEditorMain.mmToggleBPClick(Sender: TObject);
begin
if not assigned(CurrentProject) then exit;
if not assigned(TScriptProject(CurrentProject).Visual.currentunit) then exit;
Tunit(TScriptProject(CurrentProject).Visual.currentunit).Visual.Editor.ExecCommand(9000, nil);

end;

procedure TfEditorMain.mmPrintLogsClick(Sender: TObject);
begin
  ShowDockForm(fScriptPrints);
end;

procedure TfEditorMain.mmRunClick(Sender: TObject);
begin
if not assigned(CurrentProject) then exit;
if not assigned(TScriptProject(CurrentProject).Visual.currentunit) then exit;
Tunit(TScriptProject(CurrentProject).Visual.currentunit).Visual.Editor.ExecCommand(9001, nil);

end;

procedure TfEditorMain.mmSaveDocksClick(Sender: TObject);
begin
  if not DirectoryExists(AppPath+'settings\') then
    MkDir(AppPath+'settings\');
  SaveDockTreeToFile(AppPath+'settings\editor_docking.dat');
end;

procedure TfEditorMain.mmStepOverClick(Sender: TObject);
begin
if not assigned(CurrentProject) then exit;
if not assigned(TScriptProject(CurrentProject).Visual.currentunit) then exit;
Tunit(TScriptProject(CurrentProject).Visual.currentunit).Visual.Editor.ExecCommand(9004, nil);

end;

procedure TfEditorMain.mmTraceInClick(Sender: TObject);
begin
if not assigned(CurrentProject) then exit;
if not assigned(TScriptProject(CurrentProject).Visual.currentunit) then exit;
Tunit(TScriptProject(CurrentProject).Visual.currentunit).Visual.Editor.ExecCommand(9005, nil);

end;

procedure TfEditorMain.mmSyntaxlexerClick(Sender: TObject);
begin
  if SyntAnalyser.CustomizeLexer then
  begin
    if not DirectoryExists(AppPath+'settings\') then
      MkDir(AppPath+'settings\');
    SyntAnalyser.SaveToFile(AppPath+'settings\lexer.lcf');
  end;

end;

procedure TfEditorMain.mmTerminateClick(Sender: TObject);
begin
if not assigned(CurrentProject) then exit;
TScriptProject(CurrentProject).Visual.tbTerminate.Click;
end;

procedure TfEditorMain.ToolButton22Click(Sender: TObject);
begin
TScriptProject(CurrentProject).OnPacket;
end;

procedure TfEditorMain.mmWatchListClick(Sender: TObject);
begin
  ShowDockForm(fScriptWatchList);
end;

end.

