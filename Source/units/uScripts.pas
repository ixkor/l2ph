unit uScripts;

interface

uses
  usharedstructs, uglobalfuncs, uresourcestrings, CommCtrl, Menus, Windows, Messages,
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, CheckLst, JvExControls,
  JvEditorCommon, JvEditor, JvHLEditor, uscripteditor,
  siComp, ecSyntAnal, ImgList, ToolWin, JvTabBar, JvLabel, ecKeyMap;

type

  TScript = class (tobject)
    mi: TMenuItem;
    Tab : TJvTabBarItem;
    Editor : TfScriptEditor;
    ListItem : TListItem;
  private
  public
    ScriptName: string;                            
    isRunning, Compilled, Modified: Boolean;
    cs: RTL_CRITICAL_SECTION;
    changetime:TDateTime;
    procedure markerrorline;
    constructor create;
    Procedure Load(Filename:string;isnew:boolean=false;fullfilename:string=''); //инициализация, вызывать после креейта
    destructor Destroy; override;
    Procedure Save(Filename:string='');
    Procedure LoadOriginal;
    Function delete():boolean;
    Function UseThisScript(UseScript:boolean):boolean;
    Procedure CompileThisScript;
    procedure updatecontrols;
  end;

  TfScript = class(TForm)
    StatusBar: TStatusBar;
    DlgOpenScript: TOpenDialog;
    dlgSaveScript: TSaveDialog;
    JvTabBar1: TJvTabBar;
    imgBT: TImageList;
    ToolBar2: TToolBar;
    BtnSave: TToolButton;
    btnLoad: TToolButton;
    btnRename: TToolButton;
    btnDelete: TToolButton;
    btnNew: TToolButton;
    btnCompile: TToolButton;
    btnInitTest: TToolButton;
    btnFreeTest: TToolButton;
    btnRefresh: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    pnlScriptList: TPanel;
    Panel9: TPanel;
    Button9: TButton;
    Button10: TButton;
    Splitter1: TSplitter;
    btnShowHideList: TToolButton;
    ImageList1: TImageList;
    ScriptsListVisual: TListView;
    ToolButton1: TToolButton;
    lang: TsiLang;
    Instruction: TJvLabel;
    Button1: TButton;
    SyntAnalyser: TSyntAnalyzer;
    ToolButton2: TToolButton;
    btnShowWatch: TToolButton;
    btnShowClasses: TToolButton;
    SyntKeyMapping1: TSyntKeyMapping;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure ButtonCheckSyntaxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure JvTabBar1TabSelected(Sender: TObject; Item: TJvTabBarItem);
    procedure JvTabBar1TabClosed(Sender: TObject; Item: TJvTabBarItem);
    procedure btnShowHideListClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnRenameClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnFreeTestClick(Sender: TObject);
    procedure btnCompileClick(Sender: TObject);
    procedure btnInitTestClick(Sender: TObject);
    procedure ScriptsListVisualDblClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ScriptsListVisualSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ScriptsListVisualClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure btnShowWatchClick(Sender: TObject);
    procedure btnShowClassesClick(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
  private
    { Private declarations }
   ignorenextcheck : boolean;
  protected
    //у оригинального тлиствиева нет реакции на чек/унчек чекбоксов. но это исправимо.
    OriginalListViewWindowProc : TWndMethod;
    procedure ListViewWindowProcEx(var Message: TMessage) ;
    procedure CreateParams (var Params : TCreateParams); override;
  public
    procedure ScryptProcessPacket(var newpacket: tpacket; FromServer: boolean; Id:integer);
    procedure ScriptCheckClick(Sender: TObject);
    procedure DestroyAllScripts;
    Function FindScriptByName(name:string):Tscript;
    procedure RefreshScripts;
    { Public declarations }
    procedure savescryptorder;
    procedure init;
  end;

var
  fScript: TfScript;
  ScriptList:Tlist;
  currentScript : TScript;

implementation
uses uClassesDLG, usettingsdialog, uencdec, uplugindata, umain, Math, uData, uLogForm;
{$R *.dfm}

{ TForm1 }

procedure TfScript.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    ExStyle := ExStyle OR WS_EX_APPWINDOW;
end;

procedure TfScript.RefreshScripts;
var
  SearchRec: TSearchRec;
  Mask: string;
  newScript : TScript;
  i : integer;
  tempname:string;
begin
  //Mask := ExtractFilePath(ParamStr(0))+'Scripts\*.Script';
  Mask:=AppPath+'Scripts\*.Script';

  DestroyAllScripts;
  //Сначала грузим в порядке очереди с инишки и компилим по надобности.
  if assigned(Options) then
    begin
      i := 0;
      while i < Options.ReadInteger('scripts','Scriptscount',0) do
      begin
        tempname := Options.ReadString('scripts','name'+inttostr(i),'')+'.script';
        if fileexists(AppPath+'Scripts\'+tempname) then
          begin
            newScript := TScript.create;
            newScript.Load(tempname);
            if Options.ReadBool('scripts','checked'+inttostr(i), false) then
                newScript.ListItem.Checked := true;
          end;
        Inc(i);
      end;
    end;
  //а потом все остальное
  if FindFirst(Mask, faAnyFile, SearchRec) = 0 then
  begin
    repeat
      Application.ProcessMessages;
      if (SearchRec.Attr and faDirectory) <> faDirectory then
      if FindScriptByName(Copy(SearchRec.Name,1,Length(SearchRec.Name)-7)) = nil then //исключаем уже подгруженные
      begin
        newScript := TScript.create;
        newScript.Load(SearchRec.Name);
      end;
    until FindNext(SearchRec)<>0;
    FindClose(SearchRec);
  end;
  {}
end;

procedure TfScript.Button9Click(Sender: TObject);
var
  poz : integer;
  temp1 : TScript;
  vasused:boolean;  
begin
  if ScriptsListVisual.ItemIndex>0 then
  begin
    poz := ScriptsListVisual.ItemIndex;
    temp1 := FindScriptByName(ScriptsListVisual.Items.Item[poz].Caption);
    vasused := temp1.ListItem.Checked;
    temp1.ListItem.Destroy;
    temp1.ListItem := ScriptsListVisual.Items.Insert(poz-1);
    temp1.ListItem.Checked := vasused;
    temp1.ListItem.Caption := temp1.ScriptName;
    ScriptsListVisual.ItemIndex := poz -1;
  end;
end;

procedure TfScript.Button10Click(Sender: TObject);
var
  poz : integer;
  temp1: TScript;
  vasused:boolean;
begin
  if ScriptsListVisual.ItemIndex<ScriptsListVisual.Items.Count-1 then
  begin
    poz := ScriptsListVisual.ItemIndex;
    temp1 := FindScriptByName(ScriptsListVisual.Items.Item[poz].Caption);
    vasused := temp1.ListItem.Checked;
    temp1.ListItem.Destroy;
    temp1.ListItem := ScriptsListVisual.Items.Insert(poz+1);
    temp1.ListItem.Checked := vasused;
    temp1.ListItem.Caption := temp1.ScriptName;
    ScriptsListVisual.ItemIndex := poz +1;
  end;
end;

procedure TfScript.ButtonCheckSyntaxClick(Sender: TObject);
begin

end;

{ Tsctypts }

procedure TfScript.FormCreate(Sender: TObject);
begin
  if FileExists(AppPath+'settings\editor.dat') then
    SyntAnalyser.LoadFromFile(AppPath+'settings\editor.dat');

  if FileExists(AppPath+'settings\editorkeys.dat') then
    LoadComponentFromFile(SyntKeyMapping1, AppPath+'settings\editorkeys.dat');
     
  loadpos(self);
  ignorenextcheck := false;

  ScriptList := TList.Create;
  OriginalListViewWindowProc := ScriptsListVisual.WindowProc;
  ScriptsListVisual.WindowProc := ListViewWindowProcEx;

  JvTabBar1TabSelected(nil,nil);
end;

procedure TfScript.FormDestroy(Sender: TObject);
begin
  savepos(self);
  DestroyAllScripts;
  ScriptList.Destroy;
  ScriptList := nil;
end;

procedure TfScript.ScriptCheckClick(Sender: TObject);
begin
end;

{ TScript }

procedure TScript.CompileThisScript;
begin
  Editor.Editor.Gutter.Objects.Items[0].Line := -1;
  Compilled := dmData.Compile(Editor, fscript.StatusBar);
  fscript.StatusBar.SimpleText := ScriptName +': '+ fscript.StatusBar.SimpleText;
  Editor.BreakNext := false;
  Editor.Nomove := false;
  if Compilled then
      Editor.Editor.Invalidate;
  
end;

constructor TScript.create;
begin
  ScriptList.Add(Self);
  isRunning := false;
  ScriptName := '';
  Editor := TfScriptEditor.Create(fScript);
  Editor.init;
  Editor.fsScript.SyntaxType := 'PascalScript';
  mi := TMenuItem.Create(fMain.nScripts);
  dmData.UpdateAutoCompleate(Editor.AutoComplete);
  Editor.Name := '';
  Tab := fScript.JvTabBar1.AddTab('');
  Editor.assignedTScript := self;
  Tab.Visible := false;
  Editor.Visible := false;
  Editor.Parent := fScript;
  Editor.Editor.Visible := false;

  fMain.nScripts.Add(mi);
  mi.AutoCheck := True;
  mi.Checked := False;
  mi.OnClick := fScript.ScriptCheckClick;
  Editor.fsScript.Clear;
  ListItem := fScript.ScriptsListVisual.Items.add;
  Modified := false;
end;

Function TScript.delete;
begin
  //result := DeleteFile(ExtractFilePath(ParamStr(0))+'Scripts\'+ScriptName+'.script');
  result := DeleteFile(AppPath+'Scripts\'+ScriptName+'.script');
  if result then
    begin
    Modified := false;
    Tab.ImageIndex := 0;
    end;
end;

destructor TScript.destroy;
var
  i : integer;
begin
  if currentScript = self then
    begin
    currentScript := nil;
    if fClassesDLG <> nil then
      begin
      fClassesDLG.Hide;
      if fClassesDLG.fsTree1 <> nil then
        fClassesDLG.fsTree1.Script := nil;
      end;
    end;
    
  if Modified then
    if editor.Source.Lines.Count > 1 then
    if MessageDlg(pchar(fScript.lang.GetTextOrDefault('IDS_4' (* 'Желаете сохранить изменения в скрипте ' *) )+scriptname+' ?'),mtConfirmation,[mbYes, mbNo],0)=mrYes then
      Save();
      
  i := 0;
  while i < ScriptList.Count do
    begin
      if TScript(ScriptList.Items[i]) = self then
        begin
        ScriptList.Delete(i);
        break;
        end;
      inc(i);
    end;
  try
  if isRunning then
    begin
      ListItem.Checked := false;
      try
        Editor.fsScript.CallFunction('Free',0);
      except
      end;
    end;
  except
  //ну и ? -)
  end;
  ListItem.Destroy;
  mi.Destroy;
  tab.Destroy;
  Editor.deinit;
  Editor.Destroy;

  inherited;
end;


procedure TScript.Load;
begin
  if fullfilename <> '' then
    ScriptName := Copy(ExtractFileName(fullfilename),1,LastDelimiter('.',ExtractFileName(fullfilename))-1)
  else
  if isnew then
    ScriptName := Filename
  else
  if ScriptName = '' then
    ScriptName := Copy(Filename,1,Length(Filename)-7);

if isnew then
  begin
  Editor.Source.Lines.Text:=
    fScript.lang.GetTextOrDefault('IDS_7' (* 'procedure Init; //Вызывается при включении скрипта' *) )+sLineBreak+
    'begin'+sLineBreak+sLineBreak+
    'end;'+sLineBreak+sLineBreak+
    fScript.lang.GetTextOrDefault('IDS_11' (* 'procedure Free; //Вызывается при выключении скрипта' *) )+sLineBreak+
    'begin'+sLineBreak+sLineBreak+
    'end;'+sLineBreak+sLineBreak+
{    fScript.lang.GetTextOrDefault('IDS_14' (* 'procedure OnConnect(WithClient: Boolean); //Вызывается при установке соединения' *) )+sLineBreak+
    'begin'+sLineBreak+sLineBreak+
    'end;'+sLineBreak+sLineBreak+
    fScript.lang.GetTextOrDefault('IDS_17' (* 'procedure OnDisonnect(WithClient: Boolean); //Вызывается при потере соединения' *) )+sLineBreak+
    'begin'+sLineBreak+sLineBreak+
    'end;'+sLineBreak+sLineBreak+ //}
    fScript.lang.GetTextOrDefault('IDS_22' (* '//основная часть скрипта' *) )+sLineBreak+
    fScript.lang.GetTextOrDefault('IDS_23' (* '//вызывается при приходе каждого пакета если скрипт включен' *) )+sLineBreak+
    'begin'+sLineBreak+sLineBreak+
    'end.';
  end
  else
  if fullfilename <> '' then
    Editor.Source.Lines.LoadFromFile(fullfilename)
  else
    Editor.Source.Lines.LoadFromFile(AppPath+'Scripts\'+Filename);

  Editor.fsScript.Lines.Assign(Editor.Source.Lines);

  mi.Caption := ScriptName;
//  Editor.Name := ScriptName;
  Tab.Caption := ScriptName;
  ListItem.Caption := ScriptName;
  Tab.ImageIndex := 0;
  Compilled := false;
  if isnew then
    begin
      //ну и показываем новый.
      Tab.Visible := true;
      Tab.Selected := true;
    end;
 changetime := getmodiftime(AppPath+'Scripts\'+Filename);
 Modified := false;  
end;

procedure TfScript.DestroyAllScripts;
begin
  if ScriptList <> nil then
    while ScriptList.Count > 0 do
      TScript(ScriptList.Items[0]).destroy;
end;

procedure TfScript.JvTabBar1TabSelected(Sender: TObject;
  Item: TJvTabBarItem);
begin

  if item <> nil then
    begin
    currentScript := FindScriptByName(item.Caption);
    fClassesDLG.fsTree1.Script := currentScript.Editor.fsScript;
    end;

  if not Assigned(item) or not Assigned(currentScript) then 
    begin
      //Ничего не выбрано. глушим кнопки
      btnRename.Enabled := false;
      btnDelete.Enabled := false;
      btnCompile.Enabled := false;
      btnInitTest.Enabled := false;
      BtnSave.Enabled := false;
      btnFreeTest.Enabled := false;
      btnShowWatch.Enabled := false;
      btnShowClasses.Enabled := false;
      exit;
    end;

  btnShowWatch.Enabled := true;
  btnShowClasses.Enabled := true;
  currentScript.Editor.Visible := true;
  currentScript.Editor.Editor.Visible := true;
  currentScript.Editor.BringToFront;
  currentScript.updatecontrols;
  try
  currentScript.Editor.SetFocus;
  btnShowWatch.Down := currentScript.Editor.PnWatchList.Visible;
  if currentScript.Editor.PnWatchList.Visible then
    begin
    currentScript.Editor.fsScript.OnGetVarValue := currentScript.Editor.fsScriptGetVarValue;
    currentScript.Editor.fsScript.OnRunLine := currentScript.Editor.fsScriptRunLine;
    end
  else
    begin
    currentScript.Editor.fsScript.OnGetVarValue := nil;
    currentScript.Editor.fsScript.OnRunLine := nil;
    end;
  except
  end;
end;

function TfScript.FindScriptByName(name: string): Tscript;
var
i:integer;
begin
  i := 0;
  Result := nil;
  while i < ScriptList.Count do
  begin
    if lowercase(TScript(ScriptList.Items[i]).ScriptName) = lowercase(name) then
      begin
        Result := TScript(ScriptList.Items[i]);
        Exit;
      end;
    inc(i);
  end;
end;

procedure TfScript.JvTabBar1TabClosed(Sender: TObject; Item: TJvTabBarItem);
var
  CloseScr:TScript;
begin
  if item = nil then exit;
  CloseScr := FindScriptByName(Item.Caption);
  if not assigned(CloseScr) then exit;
  if CloseScr.Modified then
    if MessageDlg(lang.GetTextOrDefault('IDS_4' (* 'Желаете сохранить изменения в скрипте ' *) )+CloseScr.ScriptName+' ?',mtConfirmation,[mbYes, mbNo],0)=mrYes then
      CloseScr.Save
    else
      CloseScr.LoadOriginal;
      
  Item.Visible := false;
  FindScriptByName(Item.Caption).Editor.Visible := false;
  FindScriptByName(Item.Caption).Editor.Editor.Visible := false;
  if CloseScr = currentScript then
  begin
    currentScript := nil;
    fClassesDLG.fsTree1.Script := nil;
    fClassesDLG.Hide;
  end;
end;

procedure TfScript.btnShowHideListClick(Sender: TObject);
begin
  pnlScriptList.Visible := not pnlScriptList.Visible;
  Splitter1.Visible := not Splitter1.Visible;
end;

procedure TfScript.btnRefreshClick(Sender: TObject);
begin
  RefreshScripts;
end;

procedure TfScript.BtnSaveClick(Sender: TObject);
begin
  if currentScript = nil then exit;
  currentScript.save;
end;

procedure TfScript.btnDeleteClick(Sender: TObject);
begin
  if currentScript = nil then exit; 
    if MessageDlg(lang.GetTextOrDefault('IDS_30' (* 'Вы уверены что хотите удалить скрипт ' *) )+currentScript.ScriptName+' ?'
      +sLineBreak+lang.GetTextOrDefault('IDS_31' (* 'Это действие необратимо и приведёт к утрате файла со скриптом.' *) ),mtConfirmation,[mbYes, mbNo],0)=mrYes then
  begin
    if currentScript.delete then
      begin
      StatusBar.SimpleText := lang.GetTextOrDefault('script' (* 'Скрипт ' *) )+currentScript.ScriptName+lang.GetTextOrDefault('IDS_33' (* ' удален' *) );
      currentScript.destroy;
      end
    else
      StatusBar.SimpleText := lang.GetTextOrDefault('script' (* 'Скрипт ' *) )+currentScript.ScriptName+lang.GetTextOrDefault('IDS_35' (* ' не был удален' *) );
  end;
end;

procedure TfScript.btnLoadClick(Sender: TObject);
var
  s: string;
  r: Boolean;// для проверки не нажат ли Cancel
  newscript : TScript;
begin
  //ChDir(AppPath+'scripts\');
  DlgOpenScript.InitialDir:=AppPath+'scripts\';
  if DlgOpenScript.Execute then
  begin
    s:=ExtractFileName(DlgOpenScript.FileName);
    s:=Copy(s,1,LastDelimiter('.',s)-1);
    //if fileExists(ExtractFilePath(ParamStr(0))+'Scripts\'+s+'.script') then
    if fileExists(AppPath+'Scripts\'+s+'.script') then
      if MessageDlg(lang.GetTextOrDefault('IDS_38' (* 'Скрипт с таким названием уже существует, хотите его заменить?' *) ),mtConfirmation,[mbYes, mbNo],0)=mrNo then
      begin
        r := true;
        // будем проверять пока ненажат Cancel или файла с таким именем нету
        //while fileExists(ExtractFilePath(ParamStr(0))+'Scripts\'+s+'.script') AND r do
        while fileExists(AppPath+'Scripts\'+s+'.script') AND r do
        begin
          r := InputQuery(lang.GetTextOrDefault('IDS_41' (* 'Переименование скрипта' *) ),lang.GetTextOrDefault('IDS_42' (* 'Такой скрипт существует' *) )+sLineBreak+lang.GetTextOrDefault('IDS_43' (* 'Пожалуйста, укажите новое название' *) ), s);
          if not r then exit;
        end;
      end;

    newscript := TScript.create;
    newscript.Load('',false,DlgOpenScript.FileName);
    newscript.Save(s);
  end;
  //ChDir(AppPath+'settings\');
end;

procedure TfScript.btnRenameClick(Sender: TObject);
var
  s: string;
  r: Boolean;
begin
  if currentScript = nil then exit;
    s:= currentScript.ScriptName;
    r:= true;
    // переименовываем пока скрипт с таким именем есть или не нажата кнопка Cancel
    //while fileExists(ExtractFilePath(ParamStr(0))+'Scripts\'+s+'.script') AND r  do
    while fileExists(AppPath+'Scripts\'+s+'.script') AND r  do
    begin
      r:= InputQuery(lang.GetTextOrDefault('IDS_41' (* 'Переименование скрипта' *) ),lang.GetTextOrDefault('IDS_43' (* 'Пожалуйста, укажите новое название' *) ),s);
      if not r then exit;
    end;

    if currentScript.delete then
      begin
        StatusBar.SimpleText := lang.GetTextOrDefault('script' (* 'Скрипт ' *) )+currentScript.ScriptName+lang.GetTextOrDefault('IDS_49' (* ' был успешно переименован в ' *) )+s;
        currentScript.Save(s);
      end
      else
        StatusBar.SimpleText := lang.GetTextOrDefault('script' (* 'Скрипт ' *) )+currentScript.ScriptName+lang.GetTextOrDefault('IDS_51' (* ' не был переименован' *) );

end;

procedure TfScript.btnNewClick(Sender: TObject);
var
  s: string;
  newscript:TScript;
begin
  s:='NewScript';
  if not InputQuery(lang.GetTextOrDefault('IDS_53' (* 'Новый скрипт' *) ), lang.GetTextOrDefault('IDS_55' (* 'Пожалуйста, укажите имя для создаваемого скрипта' *) ),s )then exit;
  //while fileExists(ExtractFilePath(ParamStr(0))+'Scripts\'+s+'.script') do
  while fileExists(AppPath+'Scripts\'+s+'.script') do
     if not InputQuery(lang.GetTextOrDefault('IDS_53' (* 'Новый скрипт' *) ),lang.GetTextOrDefault('IDS_42' (* 'Такой скрипт существует' *) )+sLineBreak+lang.GetTextOrDefault('IDS_55' (* 'Пожалуйста, укажите название для создаваемого скрипта' *) ), s) then exit;
  newscript := TScript.Create;
  newscript.Load(s,True);
  newscript.Save;
  StatusBar.SimpleText := lang.GetTextOrDefault('script' (* 'Скрипт ' *) )+newscript.ScriptName+lang.GetTextOrDefault('Created' (* ' создан' *) );
end;

procedure TfScript.btnFreeTestClick(Sender: TObject);
begin
  if currentScript = nil then exit;
  if currentScript.isRunning then
  begin
    if currentScript.ListItem.Checked then
      currentScript.ListItem.Checked := false
    else
    begin
      currentScript.isRunning := false;
      currentScript.ListItem.Checked := false;
      currentScript.updatecontrols;
      try
        currentScript.Editor.fsScript.CallFunction('Free',0);
      except
      on e : exception do
        begin
          fScript.StatusBar.SimpleText := currentScript.ScriptName+'> ' + e.ClassName +' : '+ e.Message;
          currentScript.markerrorline;
        end
      else   //EOSError ?
        begin
          fScript.StatusBar.SimpleText := currentScript.ScriptName+'> '+SysErrorMessage(GetLastError);
          currentScript.markerrorline;
        end;
      end;
    end;
  end;
end;

procedure TfScript.btnCompileClick(Sender: TObject);
begin
  if currentScript = nil then exit;
  if not currentScript.Compilled then
    currentScript.CompileThisScript;
end;

procedure TfScript.btnInitTestClick(Sender: TObject);
begin
  if currentScript = nil then exit;
  if not currentScript.Compilled then currentScript.CompileThisScript;
  if currentScript.Compilled then
  begin
    currentScript.isRunning := true;
    try
      currentScript.Editor.fsScript.CallFunction('Init',0);
    except
      on e : exception do
        begin
          fScript.StatusBar.SimpleText := currentScript.ScriptName+'> ' + e.ClassName +' : '+ e.Message;
          currentScript.isRunning := false;
          currentScript.markerrorline;
        end
      else   //EOSError ?
        begin
          fScript.StatusBar.SimpleText := currentScript.ScriptName+'> '+SysErrorMessage(GetLastError);
          currentScript.isRunning := false;
          currentScript.markerrorline;
        end;
    end;
    currentScript.updatecontrols;
  end;
end;

procedure TScript.LoadOriginal;
begin
  //Editor.Source.Lines.LoadFromFile(ExtractFilePath(ParamStr(0))+'Scripts\'+ScriptName+'.script');
  Editor.Source.Lines.LoadFromFile(AppPath+'Scripts\'+ScriptName+'.script');
  Editor.fsScript.Lines.Assign(Editor.Source.Lines);
  Modified := false;
  Tab.ImageIndex := 0;
  Compilled := false;
  changetime := getmodiftime(AppPath+'Scripts\'+ScriptName+'.script');
end;

procedure TScript.markerrorline;
begin
  if Editor.Editor.Visible then
  try
    Editor.Editor.SetFocus;
  except
  //....
  end;
  Editor.Editor.CurrentLine := Editor.CurrentLine;
  Editor.Editor.ShowLine(Editor.Editor.CurrentLine-1);
  Editor.Editor.SelectLine(Editor.Editor.CurrentLine-1);
  Editor.Editor.Gutter.Objects.Items[0].Line := Editor.CurrentLine-1;
  Editor.Editor.SelectWord;
  Editor.Editor.Invalidate;
end;

procedure TScript.Save(Filename: string);
begin
  if Filename <> '' then
  //алярм! сохранение под новым именем. нервных просим удалится
  begin
    ListItem.Caption := Filename;
    Tab.Caption := Filename;
    ScriptName := Filename;
  end;
  Editor.Editor.Invalidate;
  editor.Source.Lines.SaveToFile(AppPath+'Scripts\'+ScriptName+'.script');
  Editor.Editor.Modified := false;;
  Tab.ImageIndex := 0;
  fScript.StatusBar.SimpleText:=fScript.lang.GetTextOrDefault('script' (* 'Скрипт ' *) )+ScriptName+fScript.lang.GetTextOrDefault('IDS_29' (* ' сохранен' *) );
  changetime := getmodiftime(AppPath+'Scripts\'+ScriptName+'.script');
  Modified := false;
 
end;

procedure TfScript.ListViewWindowProcEx(var Message: TMessage);
var
  listItem : TListItem;
  CheckedScrypt:TScript;
begin
  if Message.Msg = CN_NOTIFY then
  begin
    if PNMHdr(Message.LParam)^.Code = LVN_ITEMCHANGED then
    begin
      with PNMListView(Message.LParam)^ do
      begin
        if (uChanged and LVIF_STATE) <> 0 then
        begin
          if ((uNewState and LVIS_STATEIMAGEMASK) shr 12) <> ((uOldState and LVIS_STATEIMAGEMASK) shr 12) then
          begin
            if ignorenextcheck then
              begin
                ignorenextcheck := false;
                exit;
              end
            else
              begin
                listItem := ScriptsListVisual.Items[iItem];
                if listItem.Caption = '' then
                  begin
                    OriginalListViewWindowProc(Message);
                    exit;
                  end;

                CheckedScrypt := FindScriptByName(listItem.Caption);
                if assigned(CheckedScrypt) then
                if CheckedScrypt.isRunning and listItem.Checked then
                  begin
                    ignorenextcheck :=true;
                    listItem.Checked := false
                  end
                else
                  listItem.Checked := CheckedScrypt.UseThisScript(listItem.Checked);
              end;
          end;
        end;
      end;
    end;
  end;
  //original ListView message handling
  OriginalListViewWindowProc(Message) ;
end;

procedure TScript.updatecontrols;
begin
  Editor.Source.ReadOnly := isRunning;
  fScript.btnLoad.Enabled := not isRunning;
  fScript.btnDelete.Enabled := not isRunning;
  fScript.btnCompile.Enabled := not isRunning;
  fScript.btnInitTest.Enabled := not isRunning;
  fScript.btnFreeTest.Enabled := isRunning;
  fScript.btnRefresh.Enabled := not isRunning;
  fScript.BtnSave.Enabled := true;
  fScript.btnRename.Enabled := true;
end;

Function TScript.UseThisScript(UseScript: boolean):boolean;
begin
  ChDir(AppPath);
  result := UseScript;
  if UseScript and not Compilled then CompileThisScript;
  if not Compilled and UseScript then result := false
  else
    if isRunning <> Result then
      if result then
        try
          Editor.fsScript.CallFunction('Init',0);
        except
          on e : exception do
            begin
              fScript.StatusBar.SimpleText := ScriptName+'> ' + e.ClassName +' : '+ e.Message;
              markerrorline;
              result := false;
            end
          else   //EOSError ?
            begin
              fScript.StatusBar.SimpleText := ScriptName+'> '+SysErrorMessage(GetLastError);
              markerrorline;
              result := false;
            end;
        end
    else
      try
        Editor.fsScript.CallFunction('Free',0);
        if not UseScript and compilled then
          fScript.StatusBar.SimpleText := ScriptName+fScript.lang.GetTextOrDefault('nouse' (* ': Не будет использоваться' *) );
      except
      on e : exception do
        begin
          fScript.StatusBar.SimpleText := currentScript.ScriptName+'> ' + e.ClassName +' : '+ e.Message;
          markerrorline;
        end
      else   //EOSError ?
        begin
          fScript.StatusBar.SimpleText := currentScript.ScriptName+'> '+SysErrorMessage(GetLastError);
          markerrorline;
        end;
      end;
      isRunning := Result;

      if currentScript = Self then updatecontrols;
end;

procedure TfScript.ScriptsListVisualDblClick(Sender: TObject);
var
  scr:TScript;
begin
  if (ScriptsListVisual.Selected = nil) then exit;
  scr := FindScriptByName(ScriptsListVisual.Selected.Caption);
  if scr = nil then exit; //0_о
  scr.Tab.Visible := true;
  scr.Editor.Visible := true;
  scr.Editor.Editor.Visible := true;
  scr.Tab.Selected := true;
  scr.Editor.BringToFront;
end;

procedure TfScript.ScryptProcessPacket;
//сюда попадаем перед выводом
var
  temp:string;
  i:integer;
  cScript : TScript;
  connectname:string;
begin
 connectname := dmdata.ConnectNameById(id);
 setlength(temp,newpacket.Size - 2);
 Move(newpacket.data[0], temp[1], newpacket.size - 2);

  //По прежнему без бутылки сюда не лезть.
  for i := 0 to Plugins.Count - 1 do
    with TPlugin(Plugins.Items[i]) do
      if Loaded and Assigned(OnPacket) then
      begin
        OnPacket(id, FromServer, connectname, temp);
        //если плагин обнулил размер пакета
        if length(temp) = 0 then break; 
      end;


  //Скрипты
  if length(temp) > 0 then
  for i:=0 to ScriptsListVisual.Items.Count-1 do
  begin
    if fScript.ScriptsListVisual.Items.Item[i].Checked then
    begin
      cScript := fScript.FindScriptByName(fScript.ScriptsListVisual.Items.Item[i].Caption);
      if cScript <> nil then
        if cScript.isRunning and cScript.Compilled then
          if (
                (cScript.Editor.fsScript.Variables['UseForConnectName'] = '')
              or
                (cScript.Editor.fsScript.Variables['UseForConnectName'] = connectname )
              )
          and
             (
                (cScript.Editor.fsScript.Variables['UseForConnectID'] = 0)
              or
                (cScript.Editor.fsScript.Variables['UseForConnectID'] = id )
             )
             then
                begin
                  //по очереди посылаем всем включенным скриптам
                  cScript.Editor.fsScript.Variables['pck'] := temp;
                  cScript.Editor.fsScript.Variables['buf'] := '';
                  cScript.Editor.fsScript.Variables['ConnectID']:=id;
                  cScript.Editor.fsScript.Variables['ConnectName']:=connectname;
                  cScript.Editor.fsScript.Variables['FromServer']:=FromServer;
                  cScript.Editor.fsScript.Variables['FromClient']:=not FromServer;
                  try
                    cScript.Editor.fsScript.Execute;
                     temp:=cScript.Editor.fsScript.Variables['pck'];
                  except
                    fMain.StatusBar1.SimpleText := cScript.ScriptName+': '+SysErrorMessage(GetLastError)+'; on line '+inttostr(cScript.Editor.Editor.CurrentLine);
                    StatusBar.SimpleText := fMain.StatusBar1.SimpleText;
                  end;

                  //В момент когда скрипт не выполняеться - обнуляем эти переменные.
                  cScript.Editor.fsScript.Variables['pck'] := '';
                  cScript.Editor.fsScript.Variables['buf'] := '';
                  cScript.Editor.fsScript.Variables['ConnectID'] := 0;
                  cScript.Editor.fsScript.Variables['ConnectName'] := '';
                  if length(temp) = 0 then break; //Вылетаем с цикла если пцк был обнулен
                end;
    end;
  end;
  
  if length(temp) > 0 then
  begin
    newpacket.Size := length(temp) + 2;
    Move(temp[1], newpacket.data[0], newpacket.Size - 2);
  end
  else
  begin
    FillChar(newpacket.PacketAsCharArray[0], $ffff, #0)
  end;
end;

procedure TfScript.ToolButton1Click(Sender: TObject);
begin
  fLog.show;
end;

procedure TfScript.ScriptsListVisualSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  Button9.Enabled := false;
  Button10.Enabled := false;

  if item = nil then exit;

  if item.Index > 0 then
    Button9.Enabled := true;

  if (item.Index >= 0) and (item.index < ScriptsListVisual.Items.Count -1) then
    Button10.Enabled := true;
end;

procedure TfScript.ScriptsListVisualClick(Sender: TObject);
begin
  if assigned(currentScript) then
    currentScript.Editor.Editor.SetFocus;
end;

procedure TfScript.savescryptorder;
var
i:integer;
begin
  if not Assigned(Options) then exit;

  Options.WriteInteger('scripts','Scriptscount',ScriptsListVisual.Items.Count);
  i := 0;
  while i < ScriptsListVisual.Items.Count do
  begin
    Options.WriteString('scripts','name'+inttostr(i), ScriptsListVisual.Items.Item[i].Caption);
    Options.WriteBool('scripts','checked'+inttostr(i), ScriptsListVisual.Items.Item[i].Checked);
    Inc(i);
  end;
  Options.UpdateFile;
end;

procedure TfScript.init;
begin
  RefreshScripts;
end;

procedure TfScript.Button1Click(Sender: TObject);
begin
   savescryptorder;//сохраняем порядок
end;

procedure TfScript.ToolButton2Click(Sender: TObject);
begin
 if SyntAnalyser.Customize then
   SyntAnalyser.SaveToFile(AppPath+'settings\editor.dat');
end;

procedure TfScript.btnShowWatchClick(Sender: TObject);
begin
  if Assigned(currentScript) then
    if btnShowWatch.Down then
    begin
      currentScript.Editor.Splitter1.Visible := true;
      currentScript.Editor.PnWatchList.Visible := true;
      currentScript.Editor.fsScript.OnGetVarValue := currentScript.Editor.fsScriptGetVarValue;
      currentScript.Editor.fsScript.OnRunLine := currentScript.Editor.fsScriptRunLine;
    end
    else
    begin
      currentScript.Editor.PnWatchList.Visible := false;
      currentScript.Editor.Splitter1.Visible := false;
      currentScript.Editor.fsScript.OnGetVarValue := nil;
      currentScript.Editor.fsScript.OnRunLine := nil;      
    end;
end;

procedure TfScript.btnShowClassesClick(Sender: TObject);
begin
  if currentScript = nil then exit;
  fClassesDlg.show;
end;

procedure TfScript.ToolButton3Click(Sender: TObject);
begin
 if SyntKeyMapping1.Customize then
   SaveComponentToFile(SyntKeyMapping1, AppPath+'settings\editorkeys.dat');
end;

end.
