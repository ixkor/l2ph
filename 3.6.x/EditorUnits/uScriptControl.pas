unit uScriptControl;

interface

uses
  Inifiles, Sysutils, windows, Forms, Graphics, Dialogs, Controls, ComCtrls, ToolWin, Classes, JvExForms,
  JvScrollBox, siComp, siLngLnk;

type
  TfScriptControl = class(TForm)
    ScroolBox: TJvScrollBox;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    dlgSaveUnit: TSaveDialog;
    dlgOpenUnit: TOpenDialog;
    siLangLinked1: TsiLangLinked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure CreateParams (var Params : TCreateParams); override;  
  public
    additionalfuncs:TStringList;
    ProjectsList:Tlist;
    currentScripter : Tobject;
    norebuild:boolean;
    procedure rebuild;
    procedure init;
    { Public declarations }
  end;

var
  fScriptControl: TfScriptControl;


implementation
uses uMain, uGlobalFuncs, uScriptEditorResourcesStrings, uscriptproject, uEditorMain;

{$R *.dfm}



procedure TfScriptControl.ToolButton1Click(Sender: TObject);
var
Newfilename:string;
res : boolean;
begin
  Newfilename := '';
  res := InputQuery(siLangLinked1.GetTextOrDefault('TypeFilename' (* 'Select filename' *) ), siLangLinked1.GetTextOrDefault('ChooseName' (* 'choose name of the scrypt project' *) ), Newfilename);
  while res and (fileexists(AppPath+'Scripts\'+Newfilename+'.PHsp') or (Newfilename = '')) do
    res := InputQuery(siLangLinked1.GetTextOrDefault('TypeFilename' (* 'Select filename' *) ), siLangLinked1.GetTextOrDefault('AlreadyExistsChoseAnother' (* 'Project with same name already exists. choose another name' *) ), Newfilename);

  if not res  then exit;
  with TScriptProject.Create(fEditorMain) do
      begin
        init(fEditorMain,UserForm,fScriptControl.ProjectsList, fEditorMain.statusbar);
        CreateProject(AppPath+'Scripts\'+Newfilename+'.PHsp');
        CreateUnit(true);
        Show;
      end;
end;

procedure TfScriptControl.ToolButton2Click(Sender: TObject);
var
i:integer;
proj : TScriptProject;
begin
  proj := nil;
  i := 0;
  while i < ProjectsList.Count do
  begin
    if TScriptProject(ProjectsList.Items[i]).selected then
      begin
        proj := TScriptProject(ProjectsList.Items[i]);
        break;
      end;
    inc(i);
  end;
  if not assigned(proj) then exit;

  if MessageDlg(format(rsReallyWantDeleteProject, [proj.Projectname]),mtWarning, [mbYes, mbNo],0) <> mrYes then exit;

  proj.saveallunits;
  DeleteFile(pchar(proj.Filename));
  proj.modified := false;
  proj.Destroy;
end;

procedure TfScriptControl.ToolButton3Click(Sender: TObject);
var
i:integer;
proj : TScriptProject;
res : boolean;
newfilename:string;
begin
  proj := nil;
  i := 0;
  while i < ProjectsList.Count do
  begin
    if TScriptProject(ProjectsList.Items[i]).selected then
      begin
        proj := TScriptProject(ProjectsList.Items[i]);
        break;
      end;
    inc(i);
  end;
  if not assigned(proj) then exit;

  newfilename := proj.Projectname;
  res := InputQuery(siLangLinked1.GetTextOrDefault('TypeFilename' (* 'Select filename' *) ), siLangLinked1.GetTextOrDefault('ChooseName' (* 'choose name of the scrypt project' *) ), newfilename);
    while res and (fileexists(AppPath+'Scripts\'+newfilename+'.PHsp') or (newfilename = '')) do
      res := InputQuery(siLangLinked1.GetTextOrDefault('TypeFilename' (* 'Select filename' *) ), siLangLinked1.GetTextOrDefault('AlreadyExistsChoseAnother' (* 'Project with same name already exists. choose another name' *) ), newfilename);

  if not res then exit;
  proj.SaveAs(AppPath+'Scripts\'+newfilename+'.PHsp');

end;

procedure TfScriptControl.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    ExStyle := ExStyle OR WS_EX_APPWINDOW or WS_EX_CONTROLPARENT;
end;

procedure TfScriptControl.FormCreate(Sender: TObject);
begin
  ProjectsList := TList.Create;
  loadpos(self);

end;

procedure TfScriptControl.FormDestroy(Sender: TObject);
begin
  while ProjectsList.Count > 0 do
    TScriptProject(ProjectsList.Items[0]).Destroy;
  ProjectsList.Destroy;
  savepos(self);

end;

procedure TfScriptControl.init;
begin

end;

procedure TfScriptControl.rebuild;
Function GetMin(var newx:integer):TScriptProject;
  var
    i : integer;
    minnum : integer;
    MinValue:integer;
    curvalue:integer;
  begin
    MinValue := MaxInt;
    minnum := -1;
    i := 0;
    while i < ProjectsList.Count do
    begin
      curvalue := TScriptProject(ProjectsList.Items[i]).ProjItem.Top;
      if (curvalue > newx) and (curvalue < MinValue) then
        begin
          MinValue := curvalue;
          minnum := i;
        end;      
      inc(i);
    end;
    if minnum >= 0 then
      begin
        Result := TScriptProject(ProjectsList.Items[minnum]);
        newx := MinValue;
      end
    else
      Result := nil;
  end;
var
NewProj:TList;
proj : TScriptProject;
i:integer;
ini:tinifile;
str:string;
x : integer;
begin
if norebuild then exit;

if ProjectsList.Count > 0 then
begin
  x := -1;
  NewProj := TList.Create;
  proj := GetMin(x);
  while assigned(proj) do
  begin
    NewProj.Add(proj);
    proj := GetMin(x);
  end;
  ProjectsList.Assign(NewProj);
  NewProj.Destroy;
end;

if not DirectoryExists(AppPath+'settings\') then
  MkDir(AppPath+'settings\');
ini := TIniFile.Create(AppPath+'settings\Scripts.ini');
ini.WriteInteger('PHsp','ScriptCount', ProjectsList.Count);
i := 0;
while i < ProjectsList.Count do
begin
  str := TScriptProject(ProjectsList.items[i]).Filename;
  if pos(lowercase(AppPath+'scripts\'), lowercase(str))=1 then
      delete(str, 1, length(AppPath+'scripts\'));

  ini.WriteString('PHsp','name'+inttostr(i), str);
  ini.WriteBool('PHsp','active'+inttostr(i), TScriptProject(ProjectsList.items[i]).CanUse);
  inc(i);
end;

ini.Destroy;
end;

end.
