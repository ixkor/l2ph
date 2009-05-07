unit uScriptProject;

interface

uses
  uScriptUnitVisual,
  forms,
  uScriptProjectVisual,
  uScriptControlItem,
  uscriptdata,
  messages,
  dialogs, JvTabBar, ComCtrls, extctrls,
  Controls, SysUtils, Classes, PaxCompilerExplorer,
  PaxCompilerDebugger, PaxProgram, PaxCompiler, siComp, siLngLnk;


type
  TScriptProject = class(TDataModule)
    PC: TPaxCompiler;
    PPL: TPaxPascalLanguage;
    PP: TPaxProgram;
    PCD: TPaxCompilerDebugger;
    PCE: TPaxCompilerExplorer;
    dlgSaveNewUnit: TSaveDialog;
    siLangLinked1: TsiLangLinked;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure PCCompilerProgress(Sender: TPaxCompiler);
    procedure PPDestroyObject(Sender: TPaxProgram; Instance: TObject);
    procedure PPCreateObject(Sender: TPaxProgram; Instance: TObject);
    procedure PPAfterObjectDestruction(Sender: TPaxProgram; C: TClass);
    procedure PPPrintEvent(Sender: TPaxProgram; const Text: string);
    procedure PPPause(Sender: TPaxProgram; const ModuleName: string;
      SourceLineNumber: Integer);
    procedure PPAfterObjectCreation(Sender: TPaxProgram; Instance: TObject);
    procedure PPException(Sender: TPaxProgram; E: Exception;
      const ModuleName: string; SourceLineNumber: Integer);
    procedure UpdateStrings;
    procedure siLangLinked1ChangeLanguage(Sender: TObject);
  private
    { Private declarations }
    statusbar: Tstatusbar;
    objlist: TList;
    Function IsNameValid(str:string):boolean;
  public
    destroying : boolean;
    PauseUnit : string;
    PauseLine : integer;
    projecttab:TJvTabBarItem;
    ProjectsList : TList;
    UserForm : TForm;
    ProjectUnit:Tobject;
    Units : TList;
    Owner : TWinControl;
    Filename, Projectname :string;
    Visual : TScriptProjectVisual;
    ProjItem : TfScriptControlItem;
    CurrentAction : integer;
    CanUse:boolean;
    Prepare :boolean;
    WasCompilled : boolean;
    WasInited : boolean;
    modified:boolean;
    selected:boolean;

    sd:tscriptdata;


    Function OnPacket:boolean;

    ////////////////////////////////////////////

    Function Compile(DebugMode:boolean):boolean;
    Function Run(Params:Integer):boolean;
    Procedure Terminate;
    Function CallAction(ActionCode:integer;RunParam:integer):boolean;

    procedure PauseMode(IsPaused, isfullpaused:boolean);
    ////////////////////////////////////////////

    procedure GotError(index:integer);
    procedure init(AOwner : TWinControl; AssignUserForm: TForm; assignProjectsList : TList; Assignstatusbar: Tstatusbar);

    Procedure Show;
    Procedure Hide;

    Procedure StatusOutput(str:string);

    procedure saveallunits;
    procedure nexttab;
    procedure prevtab;

    procedure InspectVariable(VariableName:string);
    Function CanInspectVariable(VariableName:string):boolean;

    Procedure Save;
    Procedure SaveAs(Fname:string);

    Procedure LoadProject(ProjectFilename:string);
    Procedure CreateProject(ProjectFilename:string);
    Procedure CreateUnit(IsMain:boolean);
    Function  FindUnit(UnitName:string):Tobject;

    Procedure AddUnit(UnitFilename:string; source:string = '');
    Procedure RemoveUnit(Unitname:string);
    Function RefreshSources:boolean;
    Function GenerateProjectUnit:boolean;

    Procedure RefreshCallstack;
    Procedure RefreshVarList;
    Procedure RefreshWatchList;
    procedure EnumCallback(Id: Integer; Host: Boolean; Kind: TPaxMemberKind; Data: Pointer);

  end;

  
  tbreakpoint = class(tobject)
    breaklist : tlist;
    line:integer;
  public

    constructor create(assignbreaklist:tlist;assignline:integer);
    destructor Destroy; override;
  end;


  Tunit = class(tobject)
  public
    breaklist : tlist;
    Visual : TScriptUnitVisual;
    tab : TJvTabBarItem;
    ListItem:tlistitem;
    UnitList : Tlist;
    Filename, Unitname : string;
    ScriptProject: TScriptProject;
    modified : boolean;

    procedure Showunit(GoLine:integer);

    Procedure Save;
    Procedure SaveAs;

    function findbp(line:integer):tbreakpoint;
    procedure togglebp(line:integer);
    procedure addbps;

    Constructor create(Aowher: twincontrol; AssignUnitList : Tlist; assignScriptProject: TScriptProject);
    Procedure Load(Unitfilename:string; source:string = '');
    Procedure RefreshSource;
    destructor Destroy; override;
  end;


  TsForms = class(tobject)
  public
    WNDproc : procedure(var msg: TMessage) of object;
    form : tform;
    disabled : boolean;
    procedure newwndproc(var msg: TMessage);
    Constructor create(var AssignedForm:tform);
  end;

  TsTimers = class(tobject)
  public
    Timer : TTimer;
    Project : TScriptProject;
    wasdisabled, oldstate:boolean;
    
    Constructor create(var AssignedTimer:TTimer);
  end;

  TsObjects = class(tobject)
  public
    stimer : TsTimers;
    sForm : TsForms;

    sObject : TObject;
    OldClassName:string;
    Project : TScriptProject;
    ObjList:tList;
    ObjName:string;
    procedure Debugmode(isPaused, isfullpaused:boolean);
    Constructor create(var AssignedObject:tObject; AssignedProject:TScriptProject; assignedobjectlist:tlist);
    destructor Destroy; override;
  end;


implementation
uses
  uMain, JvDockControlForm, windows, uScriptEditorResourcesStrings, uScriptCompileProgress,
  uScriptWatchList, uScriptCallStack, uScriptPrints,
  uScriptErrors, uScriptVariables, uScriptControl, uEditorMain;
{$R *.dfm}

procedure TScriptProject.AddUnit;
var
  NewUnit : Tunit;
begin
  if source = '' then

  if not fileexists(UnitFilename) then
  if fileexists(ExtractFilePath(Filename)+UnitFilename) then
    begin
      UnitFilename := ExtractFilePath(Filename)+UnitFilename;
    end
  else
    begin
      MessageDlg(format(rsUnitNotFound, [filename, #10#13]),mtError,[mbOK],-1);
      exit;
    end;

  NewUnit := Tunit.create(Visual.ProjContainer, Units, Self);
  NewUnit.Load(UnitFilename, source);
end;


function TScriptProject.CallAction;
begin
Visual.tbTerminate.Enabled := true;

if not WasCompilled or (not wasinited and (ActionCode = ActionFree)) then
  begin
    Result := false;
    exit;
  end;
Prepare := true;
CurrentAction := ActionCode;
try
result := Run(RunParam);
if PC.DebugMode then
  while pcd.IsPaused do
    begin
    Application.ProcessMessages;
    sleep(1);
    end;  
finally
Prepare := false;
end;
case ActionCode of
  ActionInit :
    begin
      WasInited := Result;
      visual.tbInit.Enabled := not Result;
      visual.tbFree.Enabled := Result;
      Visual.tbUsing.Down := false;
    end;
  ActionFree :
    begin
      WasInited := false;
      Visual.tbInit.Enabled := true;
      Visual.tbFree.Enabled := false;
      Visual.tbUsing.Down := false;
      CanUse := false;
      ProjItem.scriptactive.Checked := false;
      Terminate;         
    end;
end;
  fEditorMain.mmCallInit.Enabled := Visual.tbInit.Enabled;
  fEditorMain.mmCallFree.Enabled := Visual.tbFree.Enabled;
end;

function TScriptProject.CanInspectVariable(VariableName: string): boolean;
begin
Result := false;
end;

function TScriptProject.Compile;
var
  i : integer;
begin
  CanUse := false;
  if WasInited then
    ProjItem.scriptactive.Checked := false;
  Visual.LErrorsWatch.Clear;
  PauseUnit := '';
  if WasCompilled then
    terminate;

  result := RefreshSources;
  if not result then
    begin
      { TODO : нет юнитов в проекте }
      exit;
    end; 
  CurrentAction := 0;
  fScriptCompileProgress.Show;
  fScriptCompileProgress.LabelProject.Caption := 'Project: '+Projectname;
  fScriptCompileProgress.BeginCompiling;
  result := pc.Compile(pp);
  fScriptCompileProgress.errors := not Result;
  fScriptCompileProgress.EndCompiling;

  if result then
  begin
    StatusOutput(format(rsCompilled, [Projectname]));
    WasCompilled := true;
    Visual.tbInit.Enabled := true;
    Visual.tbFree.Enabled := false;
    PCE.RegisterCompiler(PC);
    
    if DebugMode then
      begin
      PCD.RegisterCompiler(PC, PP);
      PCD.RemoveAllBreakpoints;
      i := 0;
      while i < Units.Count do
        begin
          Tunit(Units.Items[i]).addbps;
          inc(i);
        end;
      end;

  end
  else
    for I:=0 to PC.ErrorCount - 1 do
    begin
      GotError(i);
      if i = 0 then
        begin
            ShowDockForm(fScriptErrors);
            Visual.LErrorsWatch.ItemIndex := Visual.LErrorsWatch.Items.Count - 1;
            Visual.LErrorsWatch.OnDblClick(Self);
        end;
    end;
end;

procedure TScriptProject.CreateProject(ProjectFilename: string);
begin
  Filename := ProjectFilename;
  Projectname := ExtractFileName(ProjectFilename);
  Projectname := copy(Projectname, 1, length(Projectname) - length(extractfileext(Projectname)));
  projecttab.Caption := Projectname;
  ProjItem.Scriptname.Caption := Projectname;
end;

procedure TScriptProject.CreateUnit(IsMain: boolean);
const
 UnitMain =
 'Unit %s;'#13+
 'interface'#13+
 'uses forms, classes, extctrls, sysutils, stdctrls;'#13+
 ''#13+
 ''#13+
 'Procedure Init;'#13+
 'procedure Free;'#13+
 'Procedure OnPacket;'#13+
 ''#13+
 'implementation'#13+
 ''#13+
 'procedure Init;'#13+
 'Begin'#13+
 ''#13+
 'End;'#13+
 ''#13+
 ''#13+
 'procedure Free;'#13+
 'Begin'#13+
 ''#13+
 'End;'#13+
 ''#13+
 ''#13+
 'procedure OnPacket;'#13+
 'Begin'#13+
 ''#13+
 'End;'#13+
 ''#13+
 'end.';

 SimpleUnit =
 'Unit %s;'#13+
 'interface'#13+
 ''#13+
 'implementation'#13+
 ''#13+
 'end.';
var
  str : string;
begin
  if not dlgSaveNewUnit.Execute then exit;
  str := ExtractFileName(dlgSaveNewUnit.FileName);
  str := copy(str, 1, length(str) - length(ExtractFileExt(str)));
  if not IsNameValid(str) then
    begin
      ShowMessage(rsInvalidUnitName);
      exit;
    end;

  if assigned(FindUnit(str)) then
    begin
      ShowMessage(rsUnitAlreadyExists);
      exit;
    end;
  modified:= true;
  if IsMain then   
    AddUnit(dlgSaveNewUnit.FileName, format(UnitMain, [str]))
  else
    AddUnit(dlgSaveNewUnit.FileName, format(SimpleUnit, [str]));
  
end;

procedure TScriptProject.DataModuleCreate(Sender: TObject);
begin
  UpdateStrings;
  modified := false;
  selected := false;
  destroying := false;
  Visual := TScriptProjectVisual.Create(self);
  Visual.Project := self;
  Visual.Name := '';
  Visual.Visible := false;
  Visual.tbShowCallstack.Visible := DebugEnable;
  Visual.tbShowVariables.Visible := DebugEnable;
  Visual.tbShowWatchList.Visible := DebugEnable;



  Units := TList.Create;
  projecttab := visual.Tabbar.AddTab('');
  projecttab.Tag := -1;
  projecttab.ImageIndex := 2;
  objlist := TList.Create;

  WasCompilled := false;
  WasInited := false;
  CanUse := false;
  visual.LVariables.Parent := fScriptVariables;
  visual.LVariables.SendToBack;
  visual.LWatchList.Parent := fScriptWatchList;
  visual.LWatchList.SendToBack;
  visual.LCallStack.Parent := fScriptCallStack;
  visual.LCallStack.SendToBack;
  visual.LPrints.Parent := fScriptPrints;
  visual.LPrints.SendToBack;
  visual.LErrorsWatch.Parent := fScriptErrors;
  visual.LErrorsWatch.SendToBack;
  ProjItem := TfScriptControlItem.Create(Self);
  ProjItem.Project := Self;
  ProjItem.Parent := fScriptcontrol.ScroolBox;
  sd := TscriptData.create;
  sd.scripter := self;
end;

procedure TScriptProject.DataModuleDestroy(Sender: TObject);
var
i:integer;
begin
destroying := true;
i := 0;
  while i < ProjectsList.Count do
    begin
      if TScriptProject(ProjectsList.Items[i]) = self then
        begin
          ProjectsList.Delete(i);
          break;
        end;
      inc(i);
    end;
  sd.Destroy;
  
  while Units.Count > 0 do
    Tunit(Units.Items[0]).Destroy;
  Units.Destroy;
  objlist.Destroy;
end;

procedure TScriptProject.EnumCallback(Id: Integer; Host: Boolean;
  Kind: TPaxMemberKind; Data: Pointer);
var
item : TListItem;
begin
  item := TListItem(data);
  if lowercase(pce.Names[id]) = LowerCase(item.Caption) then
  windows.beep(1,1);
  
end;

function TScriptProject.FindUnit(UnitName: string): Tobject;
var
  i:integer;
begin
Result := nil;
i := 0;
while i < Units.Count do
  begin
    if LowerCase(Tunit(Units.Items[i]).Unitname) = LowerCase(UnitName) then
    begin
      Result := Units.Items[i];
      break;
    end;
    inc(i);   
  end;
end;

function TScriptProject.GenerateProjectUnit;
const
ProjectUnitTemlate =
'Program %s;'#13+
'uses %s;'#13+
''#13+                 
'Begin'#13+
'  case CurrentAction of'#13+
'    ActionInit: Init;'#13+
'    ActionFree: Free;'#13+
'    ActionPacket: onpacket;'#13+
'  end;'#13+
'end.';

var
  i: integer;
  Res : string;
begin
  Result:= false;
  Res := '';
  i:=0;
  while i < Units.Count do
    begin
      if Res = '' then
        Res := Res + Tunit(Units.Items[i]).Unitname
      else
        Res := Res + ', '+Tunit(Units.Items[i]).Unitname;
      inc(i);
    end;
  if Res = '' then exit;
  Res := Format(ProjectUnitTemlate,[Projectname, Res]);

  if pc.Modules[Projectname] = nil then
      PC.AddModule(Projectname, PPL.LanguageName);
  PC.Modules[Projectname].Text := Res;
  Result := true;  
end;

procedure TScriptProject.GotError(index: integer);
begin
  with Visual.LErrorsWatch.Items.Add do
  begin
    Caption := pc.ErrorModuleName[index];
    SubItems.Add(inttostr(PC.ErrorLineNumber[index]+1));
    SubItems.Add('[Pascal] '+PC.ErrorMessage[index]);
  end;
end;

procedure TScriptProject.Hide;
begin
  if modified then
  if MessageDlg(format(rsSaveChangesBe4Closing,[Projectname]), mtConfirmation, [mbYes, mbNo],0) = mrYes then
      Save;

  Visual.SendToBack;
  Visual.Hide;
  visual.LWatchList.SendToBack;
  visual.LVariables.SendToBack;
  visual.LCallStack.SendToBack;
  visual.LPrints.SendToBack;
  visual.LErrorsWatch.SendToBack;
  if feditorMain.CurrentProject = self then
  begin
    feditorMain.CurrentProject := nil;
    fEditorMain.mmDebug.Enabled := false;   
  end;
  
end;

procedure TScriptProject.init;
begin
  Owner := AOwner;
  UserForm := AssignUserForm;
  Visual.Parent := AOwner;
  ProjectsList := assignProjectsList;
  statusbar := Assignstatusbar;
  ProjectsList.Add(Self);
end;

procedure TScriptProject.InspectVariable(VariableName: string);
begin

end;

function TScriptProject.IsNameValid(str: string): boolean;
var
i:integer;
begin
Result := (Length(str) > 0);
i := 1;
while result and (i <= length(str)) do
begin
  Result := (pos(LowerCase(str[i]), '1234567890qwertyuiopasdfghjklzxcvbnm') > 0);
  inc(i);
end;

if result then
  Result := (pos(LowerCase(str[1]), 'qwertyuiopasdfghjklzxcvbnm') > 0);
end;

procedure TScriptProject.LoadProject(ProjectFilename: string);
var
  projContainer : TStringList;
  i : integer;
  str : string;
begin
  Filename := ProjectFilename;
  Projectname := ExtractFileName(ProjectFilename);
  Projectname := copy(Projectname, 1, length(Projectname) - length(extractfileext(Projectname)));

  projContainer := TStringList.Create;
  projContainer.LoadFromFile(ProjectFilename);
  i := 0;
  while i < projContainer.Count do
    begin
      if length(projContainer.Strings[i]) > 0 then
        begin
        if projContainer.Strings[i][1]<>':' then
          addunit(projContainer.Strings[i])
        else
          begin
           str := projContainer.Strings[i];
           delete(str,1,1);
           visual.Descryption.Lines.Add(str);
          end;
        end;
      inc(i);
    end;
  projContainer.Destroy;
  projecttab.Caption := Projectname;
  ProjItem.Scriptname.Caption := Projectname;
end;

Function TScriptProject.RefreshSources;
var
i:integer;
begin
  PC.Reset;
  PC.RegisterLanguage(PPL);
  PC.DebugMode := DebugEnable;

  
  PC.RegisterObject(0, 'UserForm', pc.RegisterClassType(0, TForm), @UserForm);
  PC.RegisterConstant(0,'ActionInit', ActionInit);
  PC.RegisterConstant(0,'ActionPacket', ActionPacket);
  PC.RegisterConstant(0,'ActionFree', ActionFree);
  PC.RegisterVariable(0, 'CurrentAction:byte;', @CurrentAction);
  RegisterRoutine(sd,pc);
  sd.Pck := '';
  sd.Buf := '';
  sd.FromServer := false;
  sd.FromClient := false;
  sd.ConnectID := 0;
  sd.ConnectName := '';

  result := GenerateProjectUnit;
  if not result then exit;

  i:=0;
  while i < Units.Count do
    begin
      Tunit(Units.Items[i]).RefreshSource;
      inc(i);
    end;
end;

procedure TScriptProject.RefreshVarList;
procedure AddFields(StackFrameNumber, Id: Integer);
var
  I, K: Integer;
  OwnerName: String;
begin
  K := PCE.GetFieldCount(Id);
  if K = 0 then
    Exit;

  OwnerName := PCE.Names[Id];
  if PCD.GetValueAsString(Id) = 'nil' then
    Exit;

  for I:=0 to K - 1 do
      with Visual.LVariables.Items.Add do
        begin
          caption := 'Local';
          SubItems.Add(OwnerName + '.'+PCE.GetFieldName(Id, I));
          SubItems.Add(PCD.GetFieldValueAsString(StackFrameNumber, Id, I));
        end;

  begin
  end;
end;

procedure AddArrayElements(StackFrameNumber, Id: Integer);
var
  I, K1, K2: Integer;
  OwnerName: String;
begin
  if not PCE.HasArrayType(Id) then
    Exit;

  K1 := PCE.GetArrayLowBound(Id);
  K2 := PCE.GetArrayHighBound(Id);

  OwnerName := PCE.Names[Id];
  for I:=K1 to K2 do
      with Visual.LVariables.Items.Add do
        begin
          caption := 'Local';
          SubItems.Add(OwnerName + '[' + IntToStr(I) + ']');
          SubItems.Add(PCD.GetArrayItemValueAsString(StackFrameNumber, Id, I));
        end;

end;

procedure AddDynArrayElements(StackFrameNumber, Id: Integer);
var
  I, L: Integer;
  OwnerName: String;
begin
  if not PCE.HasDynArrayType(Id) then
    Exit;

  L := PCD.GetDynArrayLength(StackFrameNumber, Id);

  OwnerName := PCE.Names[Id];
  for I:=0 to L - 1 do
      with Visual.LVariables.Items.Add do
        begin
          caption := 'Local';
          SubItems.Add(OwnerName + '[' + IntToStr(I) + ']');
          SubItems.Add(PCD.GetDynArrayItemValueAsString(StackFrameNumber, Id, I));
        end;
end;

var
  StackFrameNumber, J, K, SubId, Id: Integer;
  V: String;
begin
  Visual.LVariables.Clear;
  if not PCD.Valid or not PCD.IsPaused then
    exit;

  StackFrameNumber := PCD.CallStackCount - 1;
  SubId := PCD.CallStack[StackFrameNumber];
  K := PCE.GetLocalCount(SubId);
  for J:=0 to K - 1 do
  begin
    Id := PCE.GetLocalId(SubId, J);
    V := PCD.GetValueAsString(StackFrameNumber, Id);
    with Visual.LVariables.Items.Add do
    begin
      caption := 'Local';
      SubItems.Add(PCE.Names[Id]);
      SubItems.Add(v)
    end;
    AddFields(StackFrameNumber, Id);
    AddArrayElements(StackFrameNumber, Id);
    AddDynArrayElements(StackFrameNumber, Id);
  end;

    K := PCE.GetGlobalCount(0);
    for J:=0 to K - 1 do
    begin
      Id := PCE.GetGlobalId(0, J);
      V := PCD.GetValueAsString(Id);
      if LowerCase(PCE.Names[Id]) <> 'currentaction' then
      with Visual.LVariables.Items.Add do
      begin
        caption := 'Global';
        SubItems.Add(PCE.Names[Id]);
        SubItems.Add(v)
      end;

      AddFields(0, Id);
      AddArrayElements(0, Id);
      AddDynArrayElements(0, Id);
    end;

end;

procedure TScriptProject.RefreshWatchList;
{var
  i:integer;
  hand:integer;
  {}
begin
{
i := 0;
while i < Visual.LWatchList.Items.Count do
begin
  if not PCd.Valid or not PCD.IsPaused then
    Visual.LWatchList.Items.Item[i].SubItems.Strings[0] := 'Inaccessible'
  else
    begin
    hand := Pc.GetHandle(0, Visual.LWatchList.Items.Item[i].Caption,true);
    Visual.LWatchList.Items.Item[i].SubItems.Strings[0] := Pcd.GetValueAsString(hand);


    PCE.EnumMembers(PCD.CallStack[PCD.CallStackCount - 1], false, pmkVar, EnumCallback, pointer(Visual.LWatchList.Items.Item[i]));
    end;
  inc(i);
end;
}
end;

procedure TScriptProject.RemoveUnit(Unitname: string);
var
  i : integer;
begin
if ExtractFilePath(Unitname) <> '' then
  begin
    UnitName := ExtractFileName(Unitname);
    UnitName := copy(UnitName, 1, length(UnitName) - length(extractfileext(UnitName)));
  end;

  i := 0;
  while i < Units.Count do
  begin
    if lowercase(Tunit(Units.Items[i]).Unitname) = LowerCase(Unitname) then
      Tunit(Units.Items[i]).Destroy
    else
      inc(i);    
  end;
end;

function TScriptProject.Run(Params: Integer): boolean;
begin
  result := false;

  if not WasCompilled then exit;
  if (PC.DebugMode and not PCD.Valid) then exit;

  if pc.DebugMode then
      if PCD.IsPaused then
      begin
        PCD.RunMode := Params;
        PauseMode(true, false);
        try
          CurrentSD := sd;
          PCD.Run;
        except
          with Visual.LErrorsWatch.Items.Add do
          begin
            Caption := PCd.ModuleName;
            SubItems.Add(inttostr(pcd.SourceLineNumber+1));
            SubItems.Add(siLangLinked1.GetTextOrDefault('FatalErrorScriptTerminated' (* '[Runtime] Fatal error. script terminated' *) ));
          end;
          Terminate;
        end;
        if not PCD.IsPaused then
        begin
          PCD.RunMode := _rmRUN;
          PauseMode(false, false);
        end;
      end
  else
  else
  try
    CurrentSD := sd;
    PP.Run;
    result := true;
  except
    Result := false;
  end;
end;

procedure TScriptProject.Save;
var
  list:tstringlist;
  i:integer;
  str : string;
begin
list := TStringList.Create;

i := 0;
while i < Visual.descryption.Lines.Count do
  begin
    list.Add(':'+Visual.descryption.Lines.Strings[i]);
    inc(i);
  end;

i := 0;
while i < Units.Count do
  begin
    str := Tunit(Units.Items[i]).Filename;
    if pos(lowercase(ExtractFilePath(Filename)), lowercase(Tunit(Units.Items[i]).Filename))=1 then
        delete(str, 1, length(ExtractFilePath(Filename)));
    list.Add(str);
    inc(i);
  end;

list.SaveToFile(Filename);
list.Destroy;
StatusOutput(Format(rsProjectSaved, [Projectname, Filename]));
projecttab.Caption := Projectname;
ProjItem.Scriptname.Caption := Projectname;
end;

procedure TScriptProject.SaveAs(Fname: string);
begin
  DeleteFile(pchar(Filename));
  Filename := Fname;
  Projectname := ExtractFileName(Fname);
  Projectname := copy(Projectname, 1, length(Projectname) - length(extractfileext(Projectname)));
  Save;
end;

procedure TScriptProject.Show;
var
i : integer;
begin
  fEditorMain.Show;
  fEditorMain.BringToFront;
  Visual.Show;
  Visual.BringToFront;
  feditorMain.CurrentProject := self;
  i := 0;
  if assigned(ProjectsList) then 
  while i < ProjectsList.Count do
  begin
    if TScriptProject(ProjectsList.Items[i]) <> self then
      TScriptProject(ProjectsList.Items[i]).Hide;
    inc(i);
  end;

  visual.LWatchList.BringToFront;
  visual.LVariables.BringToFront;
  visual.LCallStack.BringToFront;
  visual.LPrints.BringToFront;
  visual.LErrorsWatch.BringToFront;

  fEditorMain.mmDebug.Enabled := true;
  fEditorMain.mmCallInit.Enabled := Visual.tbInit.Enabled;
  fEditorMain.mmCallFree.Enabled := Visual.tbFree.Enabled;
end;

procedure TScriptProject.siLangLinked1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TScriptProject.StatusOutput(str: string);
begin
  statusbar.Panels.Items[1].Text := str;
end;

procedure TScriptProject.Terminate;
var
tempObj:Tobject;
begin
  PauseUnit := '';
  WasInited := false;
  WasCompilled := false;
  Visual.tbUsing.Down := false;
  CanUse := false;
  if not destroying then
    ProjItem.scriptactive.Checked := false;
  Pc.Reset;
  if pcd.Valid then
    PCd.Reset;
  while ObjList.Count > 0  do
    try
      tempObj := TsObjects(objlist.Items[0]).sObject;
      TsObjects(objlist.Items[0]).sObject := nil;
      PP.DestroyScriptObject(tempObj);
      TsObjects(objlist.Items[0]).Destroy;
    except
    end;
  Visual.tbInit.Enabled := true;
  Visual.tbFree.Enabled := false;
  Visual.tbTerminate.Enabled := false;

end;

procedure TScriptProject.UpdateStrings;
begin
  rsCallingFunction := siLangLinked1.GetTextOrDefault('strrsCallingFunction');
  rsReallyWantDeleteProject := siLangLinked1.GetTextOrDefault('strrsReallyWantDeleteProject');
  rsAddWarchlist := siLangLinked1.GetTextOrDefault('strrsAddWarchlist');
  rsEnterNameForVariable := siLangLinked1.GetTextOrDefault('strrsEnterNameForVariable');
  rsPausedOnLine := siLangLinked1.GetTextOrDefault('strrsPausedOnLine');
  rsDeleteUnitConfirm := siLangLinked1.GetTextOrDefault('strrsDeleteUnitConfirm');
  rsInvalidUnitName := siLangLinked1.GetTextOrDefault('strrsInvalidUnitName');
  rsUnitAlreadyExists := siLangLinked1.GetTextOrDefault('strrsUnitAlreadyExists');
  rsCompilled := siLangLinked1.GetTextOrDefault('strrsCompilled');
  rsSaveChangesBe4Closing := siLangLinked1.GetTextOrDefault('strrsSaveChangesBe4Closing');
  rsWholeProjectSaved := siLangLinked1.GetTextOrDefault('strrsWholeProjectSaved');
  rsProjectSaved := siLangLinked1.GetTextOrDefault('strrsProjectSaved');
  rsUnitLoaded := siLangLinked1.GetTextOrDefault('strrsUnitLoaded');
  rsUnitSaved := siLangLinked1.GetTextOrDefault('strrsUnitSaved');
  rsUnitNotFound := siLangLinked1.GetTextOrDefault('strrsUnitNotFound');
end;

{ Tunit }

procedure Tunit.addbps;
var
i : integer;
begin
i := 0;
while i < breaklist.Count do
  begin
    if ScriptProject.WasCompilled then
    if ScriptProject.PCE.IsExecutableLine(Unitname, tbreakpoint(breaklist.Items[i]).line) then
       ScriptProject.PCD.AddBreakpoint(Unitname, tbreakpoint(breaklist.Items[i]).line)
    else
      begin
        tbreakpoint(breaklist.Items[i]).Destroy;
        Dec(i);
      end;
      
    inc(i);
  end;
end;

constructor Tunit.create;
begin
  UnitList := AssignUnitList;
  ScriptProject := assignScriptProject;
  UnitList.Add(self);
  Visual := TScriptUnitVisual.Create(Aowher);
  Visual.errorline := -1;
  Visual.Name := '';
  Visual.Parent := Aowher;
  Visual.thisunit := self;
  tab := ScriptProject.visual.Tabbar.AddTab('');
  ListItem := ScriptProject.Visual.UnitList.Items.Add;
  ListItem.SubItems.Add('');
  breaklist := TList.Create;
end;

destructor Tunit.Destroy;
var
  i : integer;
begin
  ScriptProject.Terminate;
  if modified and not ScriptProject.destroying then
    if MessageDlg(format(rsSaveChangesBe4Closing,[Unitname]), mtConfirmation, [mbYes, mbNo],0) = mrYes then
      Save;
      
  while breaklist.Count > 0 do
    tbreakpoint(breaklist.Items[0]).Destroy;
  breaklist.Destroy;

  i := 0;
  while i < UnitList.Count do
    begin
      if Tunit(UnitList.Items[i])= self then
        UnitList.Delete(i);
      inc(i);
    end;
  ListItem.Delete;
  if assigned(tab) then
    tab.Destroy;
  
   
  inherited;
end;

function Tunit.findbp(line: integer): tbreakpoint;
var
i : integer;
begin
  result := nil;
  if not assigned(breaklist) then exit;
  
  i := 0;
  while (i < breaklist.Count) do
  begin
    if tbreakpoint(breaklist.Items[i]).line = line then
      begin
        result := tbreakpoint(breaklist.Items[i]);
        break;
      end;
    inc(i);
  end;
end;

procedure Tunit.Load;
begin
  Filename := Unitfilename;
  UnitName := ExtractFileName(UnitFilename);
  UnitName := copy(UnitName, 1, length(UnitName) - length(extractfileext(UnitName)));
  if source = '' then
    Visual.Source.Lines.LoadFromFile(Filename)
  else
    Visual.Source.Lines.Text := source;
  tab.Caption := Unitname;
  tab.Visible := false;
  ListItem.Caption := Unitname;
  ListItem.SubItems[0] := Filename;
  if source = '' then
    begin
      modified := false;
      tab.ImageIndex := 0;
    end;
  ScriptProject.StatusOutput(format(rsUnitLoaded, [Unitname, Filename]));
  
end;

procedure TScriptProject.nexttab;
var
  CurPos : integer;
begin
  if not assigned(Visual.currentunit) then exit;

  CurPos := 0;
  while CurPos < units.Count do
    begin
      if units.Items[CurPos] = visual.currentunit then
        break;
      inc(CurPos);
    end;

  if CurPos = units.Count then exit;
  inc(CurPos);
  //найдена тек позиция
  //находим следующий
  while CurPos < units.Count do
    begin
      if tUnit(units.Items[CurPos]).tab.Visible then
        break;
      inc(CurPos);
    end;
  if CurPos = units.Count then
    begin
      CurPos := 0;
      while CurPos < units.Count do
        begin
          if tUnit(units.Items[CurPos]).tab.Visible then
            break;
          inc(CurPos);
        end;
    end;

    tUnit(units.Items[CurPos]).Showunit(0);
end;

function TScriptProject.OnPacket: boolean;
begin
  Result := false;
  if (not WasInited) or (not WasCompilled) then exit;
  CurrentSD := sd;
  CallAction(ActionPacket, _rmRUN);
  if pc.DebugMode then
    if PCD.IsPaused then
      sd.Finished := false
    else
      sd.Finished := true
  else
    sd.Finished := true;

  while not (sd.Finished) and (PCd.Valid) and (WasInited) do
    begin
    sleep(1);
    Application.ProcessMessages;
    end;
  Result := true;
end;

procedure TScriptProject.PauseMode;
var
i:integer;
begin
i := 0;
while i < objlist.Count do
  begin
    TsObjects(objlist.Items[i]).Debugmode(isPaused, isfullpaused);
    inc(i);
  end;
refreshCallstack;
RefreshVarList;
RefreshWatchList;
end;

procedure TScriptProject.PCCompilerProgress(Sender: TPaxCompiler);
begin
  Application.ProcessMessages;
  fScriptCompileProgress.LabelStatus.Caption := 'Compiling: ' + Sender.CurrModuleName;
  fScriptCompileProgress.LabelCurrLineNumber.Caption := IntToStr(Sender.CurrLineNumber);
end;

procedure TScriptProject.PPAfterObjectCreation(Sender: TPaxProgram;
  Instance: TObject);
begin
  TsObjects.create(Instance, self, objlist);
end;

procedure TScriptProject.PPAfterObjectDestruction(Sender: TPaxProgram;
  C: TClass);
begin
//
end;

procedure TScriptProject.PPCreateObject(Sender: TPaxProgram; Instance: TObject);
begin
//
end;

procedure TScriptProject.PPDestroyObject(Sender: TPaxProgram;
  Instance: TObject);
var
  i:integer;
begin
  i := 0;
  while i < objlist.Count do
    begin
      if TsObjects(objlist.Items[i]).sObject = Instance then
        begin
          TsObjects(objlist.Items[i]).Destroy;
          break;
        end;
      inc(i);
    end;
end;

procedure TScriptProject.PPException(Sender: TPaxProgram; E: Exception;
  const ModuleName: string; SourceLineNumber: Integer);
begin
with Visual.LErrorsWatch.Items.Add do
  begin
    Caption := ModuleName;
    SubItems.Add(inttostr(SourceLineNumber+1));
    SubItems.Add('[Runtime] '+E.Message);
  end;
end;

procedure TScriptProject.PPPause(Sender: TPaxProgram; const ModuleName: string;
  SourceLineNumber: Integer);
var
Found:tunit;
begin
  PauseMode(true, true);
  PauseUnit := ModuleName;
  PauseLine := SourceLineNumber;
  found := Tunit(FindUnit(ModuleName));

  if assigned(found) then
    begin
      Found.Showunit(SourceLineNumber);
      Found.Visual.Editor.Invalidate;
      StatusOutput(format(rsPausedOnLine,[ModuleName, SourceLineNumber + 1]));
    end;
end;

procedure TScriptProject.PPPrintEvent(Sender: TPaxProgram; const Text: string);
begin
  Visual.LPrints.Items.Insert(0,'['+timetostr(now)+'] '+text);
end;

procedure TScriptProject.prevtab;
var
  CurPos : integer;
begin
  if not assigned(visual.currentunit) then exit;

  CurPos := 0;
  while CurPos < units.Count do
    begin
      if units.Items[CurPos] = visual.currentunit then
        break;
      inc(CurPos);
    end;

  if CurPos = units.Count then exit;
  dec(CurPos);

  //найдена тек позиция
  //находим следующий
  while CurPos >= 0 do
    begin
      if tUnit(units.Items[CurPos]).tab.Visible then
        break;
      dec(CurPos);
    end;
  if CurPos = -1 then
    begin
      CurPos := units.Count -1;
      while CurPos < units.Count do
        begin
          if tUnit(units.Items[CurPos]).tab.Visible then
            break;
          dec(CurPos);
        end;      
    end;

    tUnit(units.Items[CurPos]).Showunit(0);
end;

procedure TScriptProject.refreshCallstack;
var
  StackFrameNumber, J, K, SubId, Id: Integer;
  S, V: String;

begin
Visual.LCallStack.Clear;
if pcd.Valid then
    if pcd.CallStackCount > 0 then
    begin
      for StackFrameNumber:=0 to pcd.CallStackCount - 1 do
      begin
        SubId := pcd.CallStack[StackFrameNumber];
        S := '(';
        K := PCE.GetParamCount(SubId);
        for J:=0 to K - 1 do
        begin
          Id := PCE.GetParamId(SubId, J);
          V := PCD.GetValueAsString(StackFrameNumber, Id);
          S := S + V;
          if J < K - 1 then
            S := S + ',';
        end;
        s := s + ')';
        with Visual.LCallStack.Items.Add do
        begin
          caption := PCD.CallStackModuleName[StackFrameNumber];
          SubItems.Add(inttostr(pcd.CallStackLineNumber[StackFrameNumber]));
          SubItems.Add(pce.names[SubId]);
          SubItems.Add(s);
        end;
      end;
end;
end;

procedure Tunit.RefreshSource;
begin
  if ScriptProject.pc.Modules[Unitname] = nil then
      ScriptProject.PC.AddModule(Unitname, ScriptProject.PPL.LanguageName);
  ScriptProject.PC.Modules[UnitName].Text := Visual.Source.Lines.Text;
end;

procedure Tunit.Save;
begin
  Visual.Source.Lines.SaveToFile(filename);
  modified := false;
  tab.ImageIndex := 0;
  ScriptProject.StatusOutput(format(rsUnitSaved, [Unitname, Filename]));  
end;

procedure TScriptProject.saveallunits;
var
i:integer;
begin
i := 0;
if not assigned(units) then exit;
while i < units.Count do
begin
  tUnit(units.Items[i]).save;
  inc(i);
end;
Save;
StatusOutput(Format(rsWholeProjectSaved, [Projectname]));
end;

procedure Tunit.SaveAs;
var
str:string;
begin
  if not ScriptProject.dlgSaveNewUnit.Execute then exit;
  str := ExtractFileName(ScriptProject.dlgSaveNewUnit.FileName);
  str := copy(str, 1, length(str) - length(ExtractFileExt(str)));
  if not ScriptProject.IsNameValid(str) then
    begin
      ShowMessage(rsInvalidUnitName);
      exit;
    end;
    
  DeleteFile(pchar(Filename));
  Filename := ScriptProject.dlgSaveNewUnit.FileName;
  UnitName := str;
  tab.Caption := Unitname;
  ListItem.Caption := Unitname;
  ListItem.SubItems[0] := Filename;
  ScriptProject.modified:= true;
  Save;
end;

procedure Tunit.Showunit(GoLine: integer);
begin

  ScriptProject.Show;
  Tab.Visible := true;
  Tab.Selected := true;

  if goline > 0 then
    Visual.Editor.CurrentLine := goline;
  try
    Visual.Show;
    Visual.BringToFront;
    Visual.editor.SetFocus;
    Visual.editor.invalidate;
  except
  end;

end;

procedure Tunit.togglebp(line: integer);
var
  bp : tbreakpoint;
begin
  if not DebugEnable then exit;

  bp := findbp(line);
  if not assigned(bp) then
    begin

      if (ScriptProject.pcd.Valid) and (ScriptProject.WasCompilled) then
      if ScriptProject.PCE.IsExecutableLine(Unitname, line) then
      begin
       tbreakpoint.create(breaklist,line);
       ScriptProject.PCD.AddBreakpoint(Unitname, line);
      end
      else
      else
       tbreakpoint.create(breaklist,line);
    end
  else
    begin
      bp.Destroy;
      try
        if ScriptProject.pcd.Valid then
          ScriptProject.PCD.RemoveBreakpoint(unitname,line);
      except
      end;
    end;
end;
{ TsObjects }

constructor TsObjects.create;
begin
  if AssignedObject.InheritsFrom(TComponent) then
    ObjName := TComponent(AssignedObject).Name;
  ObjList := assignedobjectlist;
  Project := AssignedProject;
  sObject := AssignedObject;
  ObjList.Insert(0,Self);
  OldClassName := lowercase(sObject.ClassName);
  //Если это форма
  if sObject.InheritsFrom(TForm) then
      sForm := TsForms.Create(TForm(AssignedObject));
  //Если это таймер
  if sObject.InheritsFrom(Ttimer) then
      stimer := TsTimers.Create(TTimer(AssignedObject));

  
 end;


procedure TsObjects.Debugmode(isPaused, isfullpaused: boolean);
begin
if Assigned(stimer) then
with stimer do
begin
  if isPaused then
  begin
    if wasdisabled then exit;
    wasdisabled := true;
    oldstate := Timer.Enabled;
    Timer.Enabled := false;
  end
  else
  begin
    if not wasdisabled then exit;
    wasdisabled := false;
    Timer.Enabled := oldstate;
  end;
end;
if Assigned(sForm) then
with sForm do
begin
if not isPaused then
      begin
        disabled := isPaused;
        form.Show;
        form.Invalidate;
      end;
if isPaused then
  form.Hide;
  
disabled := isPaused or isfullpaused;
end;
end;

destructor TsObjects.Destroy;
var
i:integer;
begin
  i := 0;
  while i < ObjList.Count do
  begin
    if TsObjects(ObjList.items[i]) = self then
      begin
        ObjList.Delete(i);
        break;
      end;
    inc(i);
  end;

  if Assigned(stimer) then
    stimer.Destroy;
  if Assigned(sForm) then
    sForm.Destroy;

  inherited;
end;


{ tbreakpoint }

constructor tbreakpoint.create(assignbreaklist: tlist; assignline: integer);
begin
breaklist := assignbreaklist;
line := assignline;
breaklist.Add(self)
end;

destructor tbreakpoint.Destroy;
var
i : integer;
begin
  i := 0;
  while i < breaklist.Count do
  begin
    if tbreakpoint(breaklist.Items[i]) = self then
      begin
        breaklist.Delete(i);
        break;
      end;
    inc(i);
  end;
  inherited;
end;

{ TsTimers }




{ TsTimers }

constructor TsTimers.create(var AssignedTimer: TTimer);
begin
  wasdisabled := false;
  Timer := AssignedTimer;
end;

{ TsForms }

constructor TsForms.create(var AssignedForm: tform);
begin
  disabled := false;
  form := AssignedForm;
  WNDproc := AssignedForm.WindowProc;
  AssignedForm.WindowProc := newwndproc;
end;

procedure TsForms.newwndproc(var msg: TMessage);
begin
  if Disabled then
  else
    WNDproc(msg);
end;

end.

