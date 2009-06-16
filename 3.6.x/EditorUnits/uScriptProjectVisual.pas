unit uScriptProjectVisual;

interface

uses
  uScriptEditorResourcesStrings,
  Dialogs,
  sysutils,
  types,
  Forms, ecSyntMemo, ecAutoReplace, ecPopupCtrl, ImgList, Controls, Menus,
  ComCtrls, ToolWin, StdCtrls, JvExControls, JvSpeedButton, JvExComCtrls,
  JvComCtrls, JvTabBar, ExtCtrls, Classes, siComp, siLngLnk;

type
  TScriptProjectVisual = class(TFrame)
    Bevel1: TBevel;
    btm: TPanel;
    LWatchList: TListView;
    LPrints: TListBox;
    LErrorsWatch: TListView;
    EditorsContainer: TPanel;
    Tabbar: TJvTabBar;
    ToolBar1: TToolBar;
    tbSave: TToolButton;
    tbSaveAll: TToolButton;
    ToolButton3: TToolButton;
    tbCompile: TToolButton;
    tbInit: TToolButton;
    tbFree: TToolButton;
    tbTerminate: TToolButton;
    ToolButton8: TToolButton;
    tbShowErrors: TToolButton;
    tbShowCallstack: TToolButton;
    tbShowWatchList: TToolButton;
    tbShowPrints: TToolButton;
    tbShowVariables: TToolButton;
    tbShowObjInspector: TToolButton;
    OnlyModulePnl: TPanel;
    ToolBar2: TToolBar;
    ToolButton15: TToolButton;
    tbShowUnitTree: TToolButton;
    watchlistmenu: TPopupMenu;
    wAdd: TMenuItem;
    wDelete: TMenuItem;
    printsmenu: TPopupMenu;
    pclear: TMenuItem;
    ImageList: TImageList;
    WatchBntmenu: TPopupMenu;
    show1: TMenuItem;
    MenuItem1: TMenuItem;
    Clear1: TMenuItem;
    PrintsBtnMenu: TPopupMenu;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    TemplatePopup: TTemplatePopup;
    AutoComplete: TAutoCompletePopup;
    AutoReplace: TSyntAutoReplace;
    newunitPopup: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ProjContainer: TPanel;
    ProjectPNL: TPanel;
    JvPageControl1: TJvPageControl;
    TabSheet2: TTabSheet;
    UnitList: TListView;
    Panel5: TPanel;
    btnUnitRename: TJvSpeedButton;
    btnUnitDelete: TJvSpeedButton;
    btnNewUnit: TJvSpeedButton;
    JvSpeedButton1: TJvSpeedButton;
    Panel7: TPanel;
    TabSheet3: TTabSheet;
    descryption: TMemo;
    LCallStack: TListView;
    LVariables: TListView;
    tbUsing: TToolButton;
    ToolButton2: TToolButton;
    siLangLinked1: TsiLangLinked;
    procedure JvSpeedButton1Click(Sender: TObject);
    procedure TabbarTabCloseQuery(Sender: TObject; Item: TJvTabBarItem;
      var CanClose: Boolean);
    procedure TabbarTabSelecting(Sender: TObject; Item: TJvTabBarItem;
      var AllowSelect: Boolean);
    procedure tbSaveClick(Sender: TObject);
    procedure tbSaveAllClick(Sender: TObject);
    procedure tbCompileClick(Sender: TObject);
    procedure tbInitClick(Sender: TObject);
    procedure tbFreeClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure btnUnitRenameClick(Sender: TObject);
    procedure btnUnitDeleteClick(Sender: TObject);
    procedure tbTerminateClick(Sender: TObject);
    procedure tbShowErrorsClick(Sender: TObject);
    procedure tbShowCallstackClick(Sender: TObject);
    procedure show1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure wDeleteClick(Sender: TObject);
    procedure pclearClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure tbShowObjInspectorClick(Sender: TObject);
    procedure tbShowVariablesClick(Sender: TObject);
    procedure LErrorsWatchDblClick(Sender: TObject);
    procedure tbUsingClick(Sender: TObject);
  private
    { Private declarations }
  public
    Project : tobject;
    currentunit : TObject;
    { Public declarations }
  end;

implementation
uses uMain, JvDockControlForm, PaxProgram, uScriptProject, uEditorMain, uScriptErrors,
  uScriptCallStack, uScriptWatchList, uScriptPrints,
  uObjInspector, uScriptVariables;
{$R *.dfm}

procedure TScriptProjectVisual.btnUnitDeleteClick(Sender: TObject);
var
  found : Tunit;
begin
if assigned(UnitList.Selected) then
  if MessageDlg(format(rsDeleteUnitConfirm,[UnitList.Selected.Caption]),mtWarning,[mbYes,mbNo],0) = mrYes then
  begin
    found := tunit(TScriptProject(Project).FindUnit(UnitList.Selected.Caption));
  if Assigned(found) then
    begin
    found.Destroy;
    TScriptProject(Project).modified:= true;
    end;
  end;
end;

procedure TScriptProjectVisual.btnUnitRenameClick(Sender: TObject);
var
  found : Tunit;
begin
if assigned(UnitList.Selected) then
  begin
    found := tunit(TScriptProject(Project).FindUnit(UnitList.Selected.Caption));
  if Assigned(found) then
    found.SaveAs;
  end;
end;

procedure TScriptProjectVisual.Clear1Click(Sender: TObject);
begin
  LWatchList.Clear;
end;

procedure TScriptProjectVisual.JvSpeedButton1Click(Sender: TObject);
var
  cunit : tunit;
begin
  if not assigned(UnitList.Selected) then exit;
  cunit := tUnit(TScriptProject(Project).findunit(UnitList.Selected.Caption));
  if assigned(cunit) then
    begin
      cunit.Showunit(0);
    end;
end;

procedure TScriptProjectVisual.LErrorsWatchDblClick(Sender: TObject);
var
found:tunit;
begin
if Assigned(LErrorsWatch.Selected) then
  begin
    found := tunit(TScriptProject(Project).FindUnit(LErrorsWatch.Selected.Caption));
    if assigned(found) then
      begin
      found.Visual.errorline := strtoint(LErrorsWatch.Selected.SubItems.Strings[0])-1;
      found.Showunit(found.Visual.errorline);
      end;
  end;
end;

procedure TScriptProjectVisual.MenuItem1Click(Sender: TObject);
var
str : string;
begin
str := InputBox(rsAddWarchlist,rsEnterNameForVariable,'');
if str <> '' then
  with LWatchList.items.Add do
    begin
      Caption := str;
      subitems.Add('');
    end;
show1Click(self);
TScriptProject(Project).RefreshVarList;
end;

procedure TScriptProjectVisual.MenuItem2Click(Sender: TObject);
begin
ShowDockForm(fScriptPrints);
LPrints.BringToFront;
end;

procedure TScriptProjectVisual.N1Click(Sender: TObject);
begin
TScriptProject(Project).CreateUnit(true);
end;

procedure TScriptProjectVisual.N2Click(Sender: TObject);
begin
TScriptProject(Project).CreateUnit(false);
end;

procedure TScriptProjectVisual.pclearClick(Sender: TObject);
begin
  LPrints.Clear;
end;

procedure TScriptProjectVisual.show1Click(Sender: TObject);
begin
ShowDockForm(fScriptWatchList);
LWatchList.BringToFront;

end;

procedure TScriptProjectVisual.TabbarTabCloseQuery(Sender: TObject;
  Item: TJvTabBarItem; var CanClose: Boolean);
var
  closeunit: tunit;
  res : integer;
begin
CanClose := false;
closeunit := tUnit(TScriptProject(Project).FindUnit(Item.Caption));
if not Assigned(closeunit) then
  begin
   TScriptProject(Project).Hide;
   exit;
  end;
  
if closeunit.modified then
 begin
 res := MessageDlg(format(rsSaveChangesBe4Closing,[closeunit.unitname]),mtWarning,[mbYes,mbNo,mbCancel],0);
   case res of
     mrYes: closeunit.save;
     mrNo:;
     else
     exit;
   end;
 end;

Item.Visible := false;
closeunit.Visual.Hide;
end;

procedure TScriptProjectVisual.TabbarTabSelecting(Sender: TObject;
  Item: TJvTabBarItem; var AllowSelect: Boolean);
begin
if Item = nil then
    currentunit := nil
  else
    if Item.Tag = -1 then
        currentunit := nil
      else
        currentunit := TScriptProject(Project).findunit(Item.Caption);
    
if not Assigned(currentunit) then
  begin
    OnlyModulePnl.Hide;
    ProjectPNL.BringToFront;
  end
 else
  begin
    OnlyModulePnl.Show;
    tUnit(currentunit).Visual.Show;
    tUnit(currentunit).Visual.Editor.Show;
    tUnit(currentunit).Visual.BringToFront;
    tUnit(currentunit).Visual.Editor.SetFocus;
  end;
end;

procedure TScriptProjectVisual.tbCompileClick(Sender: TObject);
begin
  TScriptProject(Project).Compile(DebugEnable);
end;

procedure TScriptProjectVisual.tbFreeClick(Sender: TObject);
begin
  TScriptProject(Project).CallAction(ActionFree, _rmRUN);
  TScriptProject(Project).Terminate;
end;

procedure TScriptProjectVisual.tbInitClick(Sender: TObject);
begin
  if not TScriptProject(Project).WasCompilled then
      TScriptProject(Project).Compile(DebugEnable);
  TScriptProject(Project).CallAction(ActionInit, _rmRUN);
end;

procedure TScriptProjectVisual.tbSaveAllClick(Sender: TObject);
begin
  TScriptProject(Project).saveallunits;
end;

procedure TScriptProjectVisual.tbSaveClick(Sender: TObject);
begin
if assigned(currentunit) then
  begin
  tUnit(currentunit).save;
  tUnit(currentunit).Visual.Editor.Invalidate;
  end
else
  TScriptProject(Project).save;
end;

procedure TScriptProjectVisual.tbShowCallstackClick(Sender: TObject);
begin
ShowDockForm(fScriptCallStack);
LCallStack.BringToFront;

end;

procedure TScriptProjectVisual.tbShowErrorsClick(Sender: TObject);
begin
ShowDockForm(fScriptErrors);
LErrorsWatch.BringToFront;
end;

procedure TScriptProjectVisual.tbShowObjInspectorClick(Sender: TObject);
begin
ShowDockForm(fObjInspector);
end;

procedure TScriptProjectVisual.tbShowVariablesClick(Sender: TObject);
begin
ShowDockForm(fScriptVariables);
LVariables.BringToFront;
end;

procedure TScriptProjectVisual.tbTerminateClick(Sender: TObject);
begin
    TScriptProject(Project).Terminate;
end;

procedure TScriptProjectVisual.tbUsingClick(Sender: TObject);
begin
if tbUsing.Down and not TScriptProject(Project).WasInited then
begin
  if not TScriptProject(Project).WasCompilled then
      TScriptProject(Project).Compile(DebugEnable);
  TScriptProject(Project).CallAction(ActionInit, _rmRUN);
  if not TScriptProject(Project).WasInited then
  begin
   tbUsing.Down := false;
   exit;
  end
  else
  tbUsing.Down := true; 
end;

  TScriptProject(Project).CanUse := tbUsing.Down;
  TScriptProject(Project).ProjItem.scriptactive.Checked := tbUsing.Down;

end;

procedure TScriptProjectVisual.wDeleteClick(Sender: TObject);
begin
if assigned(LWatchList.Selected) then
  LWatchList.Selected.Delete;
end;

end.
