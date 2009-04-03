unit uScripts;

interface

uses
  usharedstructs, uglobalfuncs, uresourcestrings, CommCtrl, Menus, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, CheckLst, JvExControls,
  JvEditorCommon, JvEditor, JvHLEditor, fs_iinterpreter, JvTabBar, uScriptEditor,
  ToolWin, ImgList, JvLabel, fs_iinirtti, fs_imenusrtti, fs_idialogsrtti,
  fs_iextctrlsrtti, fs_iformsrtti, fs_iclassesrtti;

type

  TScript = class (tobject)
    fsScript: TfsScript;
    mi: TMenuItem;
    Tab : TJvTabBarItem;
    Editor : TfScriptEditor;
    ListItem : TListItem;
  private
  public
    ScriptName: string;
    isRunning, Compilled, Modified: Boolean;
    cs: RTL_CRITICAL_SECTION;
    constructor create;
    Procedure Load(Filename:string;isnew:boolean=false;fullfilename:string=''); //инициализация, вызывать после креейта
    destructor destroy; override;
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
    Instruction: TJvLabel;
    ToolButton1: TToolButton;
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
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
    procedure HintMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolButton1Click(Sender: TObject);
    procedure ScriptsListVisualSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { Private declarations }

  protected
    //у оригинального тлиствиева нет реакции на чек/унчек чекбоксов. но это исправимо.
    OriginalListViewWindowProc : TWndMethod;
    procedure ListViewWindowProcEx(var Message: TMessage) ;
    procedure CreateParams (var Params : TCreateParams); override;
  public
    procedure ScryptProcessPacket(var newpacket: tpacket; FromServer: boolean; Caller: TObject);
    procedure ScriptCheckClick(Sender: TObject);
    procedure DestroyAllScripts;
    Function FindScriptByName(name:string):Tscript;
    procedure RefreshScripts;
    { Public declarations }
  end;

var
  fScript: TfScript;
  ScriptList:Tlist;
  currentScript : TScript;

implementation
uses uencdec, uplugindata, umain, Math, uData, uLogForm;
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
begin

  Mask := ExtractFilePath(ParamStr(0))+'Scripts\*.Script';
  DestroyAllScripts;
  if FindFirst(Mask, faAnyFile, SearchRec) = 0 then
  begin
    repeat
      Application.ProcessMessages;
      if (SearchRec.Attr and faDirectory) <> faDirectory then
      begin
        newScript := TScript.create;
        newScript.Load(SearchRec.Name);
      end;
    until FindNext(SearchRec)<>0;
    FindClose(SearchRec);
  end;
  {}
end;

procedure TfScript.ButtonSaveClick(Sender: TObject);
begin
{
  }
end;

procedure TfScript.ButtonDeleteClick(Sender: TObject);
begin
{
  {}
end;

procedure TfScript.Button9Click(Sender: TObject);
var
  poz : integer;
  temp1, temp2 : TScript;
begin
  if ScriptsListVisual.ItemIndex>0 then
  begin
    poz := ScriptsListVisual.ItemIndex;
    temp1 := FindScriptByName(ScriptsListVisual.Items.Item[poz].Caption);
    temp2 := FindScriptByName(ScriptsListVisual.Items.Item[poz-1].Caption);
    temp1.ListItem.Destroy;
    temp2.ListItem.Destroy;
    temp2.ListItem := ScriptsListVisual.Items.Insert(poz-1);
    temp2.ListItem.Caption := temp2.ScriptName;
    temp1.ListItem := ScriptsListVisual.Items.Insert(poz-1);
    temp1.ListItem.Caption := temp1.ScriptName;
    ScriptsListVisual.ItemIndex := poz -1;
  end;
end;

procedure TfScript.Button10Click(Sender: TObject);
var
  poz : integer;
  temp1, temp2 : TScript;
begin
  if ScriptsListVisual.ItemIndex>0 then
  begin
    poz := ScriptsListVisual.ItemIndex;
    temp1 := FindScriptByName(ScriptsListVisual.Items.Item[poz].Caption);
    temp2 := FindScriptByName(ScriptsListVisual.Items.Item[poz-1].Caption);
    temp1.ListItem.Destroy;
    temp2.ListItem.Destroy;
    temp1.ListItem := ScriptsListVisual.Items.Insert(poz-1);
    temp1.ListItem.Caption := temp1.ScriptName;
    temp2.ListItem := ScriptsListVisual.Items.Insert(poz-1);
    temp2.ListItem.Caption := temp2.ScriptName;
    ScriptsListVisual.ItemIndex := poz -1;
  end;
end;

procedure TfScript.ButtonCheckSyntaxClick(Sender: TObject);
begin

end;

{ Tsctypts }

procedure TfScript.FormCreate(Sender: TObject);
begin
  ScriptList := TList.Create;
  RefreshScripts;
  OriginalListViewWindowProc := ScriptsListVisual.WindowProc;
  ScriptsListVisual.WindowProc := ListViewWindowProcEx;
  Instruction.Caption := RsScryptingInstructions;
  JvTabBar1TabSelected(nil,nil);
end;

procedure TfScript.FormDestroy(Sender: TObject);
begin
  DestroyAllScripts;
  ScriptList.Destroy;
end;

procedure TfScript.ScriptCheckClick(Sender: TObject);
begin
{  ScriptsListVisual.Checked[TMenuItem(Sender).MenuIndex]:=TMenuItem(Sender).Checked;
  ScriptsListVisualClickCheck(nil);
  }
end;

{ TScript }

procedure TScript.CompileThisScript;
begin
  Compilled := dmData.Compile(fsScript, Editor.JvHLEditor1, fscript.StatusBar);

  fscript.StatusBar.SimpleText := ScriptName +': '+ fscript.StatusBar.SimpleText;
end;

constructor TScript.create;
begin
  ScriptList.Add(Self);
  isRunning := false;
  ScriptName := '';
  fsScript := TfsScript.Create(nil);
  fsScript.SyntaxType := 'PascalScript';
  mi := TMenuItem.Create(L2PacketHackMain.nScripts);
  Editor := TfScriptEditor.Create(fScript);
  Editor.Name := '';
  Tab := fScript.JvTabBar1.AddTab('');
  Editor.assignedTScript := self;
  Tab.Visible := false;
  Editor.Visible := false;
  Editor.Parent := fScript;
  Editor.JvHLEditor1.Visible := false;

  L2PacketHackMain.nScripts.Add(mi);
  mi.AutoCheck := True;
  mi.Checked := False;
  mi.OnClick := fScript.ScriptCheckClick;
  fsScript.Clear;
  ListItem := fScript.ScriptsListVisual.Items.add
end;

Function TScript.delete;
begin
  result := DeleteFile(ExtractFilePath(ParamStr(0))+'Scripts\'+ScriptName+'.script');
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
  if Modified then
    if MessageDlg(pchar('Желаете сохранить изменения в скрипте '+scriptname+' ?'),mtConfirmation,[mbYes, mbNo],0)=mrYes then
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
      fsScript.CallFunction('Free',0);
    end;
  except
  //ну и ? -)
  end;
  ListItem.Destroy;
  mi.Destroy;
  tab.Destroy;
  Editor.Destroy;
  fsScript.Destroy;
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
  Editor.JvHLEditor1.Lines.Text:=
    'procedure Init; //Вызывается при включении скрипта'+sLineBreak+
    'begin'+sLineBreak+sLineBreak+
    'end;'+sLineBreak+sLineBreak+
    'procedure Free; //Вызывается при выключении скрипта'+sLineBreak+
    'begin'+sLineBreak+sLineBreak+
    'end;'+sLineBreak+sLineBreak+
    'procedure OnConnect(WithClient: Boolean); //Вызывается при установке соединения'+sLineBreak+
    'begin'+sLineBreak+sLineBreak+
    'end;'+sLineBreak+sLineBreak+
    'procedure OnDisonnect(WithClient: Boolean); //Вызывается при потере соединения'+sLineBreak+
    'begin'+sLineBreak+sLineBreak+
    'end;'+sLineBreak+sLineBreak+
    '//основная часть скрипта'+sLineBreak+
    '//вызывается при приходе каждого пакета если скрипт включен'+sLineBreak+
    'begin'+sLineBreak+sLineBreak+
    'end.';
  end
  else
  if fullfilename <> '' then
    Editor.JvHLEditor1.Lines.LoadFromFile(fullfilename)
  else
    Editor.JvHLEditor1.Lines.LoadFromFile(ExtractFilePath(ParamStr(0))+'Scripts\'+Filename);

  fsScript.Lines.Assign(Editor.JvHLEditor1.Lines);

  mi.Caption := ScriptName;
//  Editor.Name := ScriptName;
  Tab.Caption := ScriptName;
  ListItem.Caption := ScriptName;
  modified := false;
  Tab.ImageIndex := 0;
  Compilled := false;
  if isnew then
    begin
      //ну и показываем новый.
      Tab.Visible := true;
      Tab.Selected := true;
    end;
end;

procedure TfScript.DestroyAllScripts;
begin
  while ScriptList.Count > 0 do TScript(ScriptList.Items[0]).destroy;
end;

procedure TfScript.JvTabBar1TabSelected(Sender: TObject;
  Item: TJvTabBarItem);
begin
  if item = nil then
    begin
      //Ничего не выбрано. глушим кнопки
      btnRename.Enabled := false;
      btnDelete.Enabled := false;
      btnCompile.Enabled := false;
      btnInitTest.Enabled := false;
      BtnSave.Enabled := false;
      btnFreeTest.Enabled := false;
      exit;
    end;
  currentScript := FindScriptByName(item.Caption);
  currentScript.Editor.Visible := true;
  currentScript.Editor.JvHLEditor1.Visible := true;
  currentScript.Editor.BringToFront;
  currentScript.updatecontrols;
end;

function TfScript.FindScriptByName(name: string): Tscript;
var
i:integer;
begin
i := 0;
Result := nil;
while i < ScriptList.Count do
  begin
    if TScript(ScriptList.Items[i]).ScriptName = name then
      begin
        Result := TScript(ScriptList.Items[i]);
        Exit;
      end;
    inc(i);
  end;
end;

procedure TfScript.JvTabBar1TabClosed(Sender: TObject;
  Item: TJvTabBarItem);
begin
  if item = nil then exit;
  if currentScript.Modified then
    if MessageDlg('Желаете сохранить изменения в скрипте '+currentScript.ScriptName+' ?',mtConfirmation,[mbYes, mbNo],0)=mrYes then
      currentScript.Save
    else
      currentScript.LoadOriginal;
      
  Item.Visible := false;
  FindScriptByName(Item.Caption).Editor.Visible := false;
  FindScriptByName(Item.Caption).Editor.JvHLEditor1.Visible := false;
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
  StatusBar.SimpleText:='Скрипт '+currentScript.ScriptName+' сохранен';
end;

procedure TfScript.btnDeleteClick(Sender: TObject);
begin
  if currentScript = nil then exit; 
    if MessageDlg('Вы уверены что хотите удалить скрипт '+currentScript.ScriptName+' ?'
      +sLineBreak+'Это действие необратимо и приведёт к утрате файла со скриптом.',mtConfirmation,[mbYes, mbNo],0)=mrYes then
  begin
    if currentScript.delete then
      begin
      StatusBar.SimpleText := 'Скрипт '+currentScript.ScriptName+' удален';
      currentScript.destroy;
      end
    else
      StatusBar.SimpleText := 'Скрипт '+currentScript.ScriptName+' не был удален';
  end;
end;

procedure TfScript.btnLoadClick(Sender: TObject);
var
  s: string;
  r: Boolean;// для проверки не нажат ли Cancel
  newscript : TScript;
begin

  if DlgOpenScript.Execute then
  begin
    s:=ExtractFileName(DlgOpenScript.FileName);
    s:=Copy(s,1,LastDelimiter('.',s)-1);   
    if fileExists(ExtractFilePath(ParamStr(0))+'Scripts\'+s+'.script') then
      if MessageDlg('Скрипт с таким названием уже существует, хотите его заменить?',mtConfirmation,[mbYes, mbNo],0)=mrNo then
      begin
        r := true;
        // будем проверять пока ненажат Cancel или файла с таким именем нету
        while fileExists(ExtractFilePath(ParamStr(0))+'Scripts\'+s+'.script') AND r do
        begin
          r := InputQuery('Переименование скрипта','Такой скрипт существует'+sLineBreak+'Пожалуйста, укажите новое название', s);
          if not r then exit;
        end;
      end;

    newscript := TScript.create;
    newscript.Load('',false,DlgOpenScript.FileName);
    newscript.Save(s);
  end;
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
    while fileExists(ExtractFilePath(ParamStr(0))+'Scripts\'+s+'.script') AND r  do
    begin
      r:= InputQuery('Переименование скрипта','Пожалуйста, укажите новое название',s);
      if not r then exit;
    end;

    if currentScript.delete then
      begin
        StatusBar.SimpleText := 'Скрипт '+currentScript.ScriptName+' был успешно переименован в '+s;
        currentScript.Save(s);
      end
      else
        StatusBar.SimpleText := 'Скрипт '+currentScript.ScriptName+' не был переименован';

end;

procedure TfScript.btnNewClick(Sender: TObject);
var
  s: string;
  newscript:TScript;
begin
  s:='NewScript';
  if not InputQuery('Новый скрипт', 'Пожалуйста, укажите имя для создаваемого скрипта',s )then exit;
  while fileExists(ExtractFilePath(ParamStr(0))+'Scripts\'+s+'.script') do
     if not InputQuery('Новый скрипт','Такой скрипт существует'+sLineBreak+'Пожалуйста, укажите название для создаваемого скрипта', s) then exit;
  newscript := TScript.Create;
  newscript.Load(s,True);
  newscript.Save;
  StatusBar.SimpleText := 'Скрипт '+newscript.ScriptName+' создан';
end;

procedure TfScript.btnFreeTestClick(Sender: TObject);
begin
if currentScript = nil then exit;
if currentScript.isRunning then
  begin
    currentScript.isRunning := false;
    currentScript.ListItem.Checked := false;
    currentScript.updatecontrols;
    try
      currentScript.fsScript.CallFunction('Free',0);
    except
      currentScript.isRunning := true; //я не представляю что должно произойти что бы мы сюда попали
      currentScript.ListItem.Checked := true; //но на всякий пожарный код пусть будет
      currentScript.updatecontrols;
    end;
  end;
end;

procedure TfScript.btnCompileClick(Sender: TObject);
begin
  if currentScript = nil then exit;
  if not currentScript.Compilled then
    currentScript.CompileThisScript;
  //Compile(fsScript1, JvHLEditor1);
end;

procedure TfScript.btnInitTestClick(Sender: TObject);
begin
if currentScript = nil then exit;
if not currentScript.Compilled then currentScript.CompileThisScript;
if currentScript.Compilled then
  begin
    currentScript.isRunning := true;
    currentScript.updatecontrols;
    try
      currentScript.fsScript.CallFunction('Init',0);
    except
      currentScript.isRunning := false;
      currentScript.updatecontrols;
    end;
  end;
end;

procedure TScript.LoadOriginal;
begin
  Editor.JvHLEditor1.Lines.LoadFromFile(ExtractFilePath(ParamStr(0))+'Scripts\'+ScriptName+'.script');
  fsScript.Lines.Assign(Editor.JvHLEditor1.Lines);
  Modified := false;
  Tab.ImageIndex := 0;
  Compilled := false;
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
  
  editor.JvHLEditor1.Lines.SaveToFile(ExtractFilePath(ParamStr(0))+'Scripts\'+ScriptName+'.script');
  Modified := false;
  Tab.ImageIndex := 0;
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
            listItem := ScriptsListVisual.Items[iItem];
            CheckedScrypt := FindScriptByName(listItem.Caption);
            if CheckedScrypt <> nil then
            listItem.Checked := CheckedScrypt.UseThisScript(listItem.Checked);
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
  Editor.JvHLEditor1.ReadOnly := isRunning;
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
result := UseScript;
if UseScript and not Compilled then CompileThisScript;
if not Compilled and UseScript then
    result := false
else
if not UseScript and compilled then
  fScript.StatusBar.SimpleText := ScriptName+': Не будет использоваться';
  
isRunning := Result;

if result then
  fsScript.CallFunction('Init',0)
else
  fsScript.CallFunction('Free',0);
if currentScript = Self then
  updatecontrols;
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
  scr.Editor.JvHLEditor1.Visible := true;
  scr.Tab.Selected := true;
  scr.Editor.BringToFront;
end;

procedure TfScript.HintMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
StatusBar.SimpleText := (Sender as TControl).Hint;
end;

procedure TfScript.ScryptProcessPacket(var newpacket: tpacket; FromServer: boolean; Caller: TObject);
//сюда попадаем перед выводом

var
  temp:string;
  i:integer;
  id:integer;
  cScript : TScript;
begin
  id := tencdec(caller).Ident;
  { TODO :
  Обработка пакета плагинами и скриптами
  по какойто причине багнуто.
  убрал его из обработки по месейджу..
  этот кусок в тестовом режиме.!!! }
  
  //По прежнему без бутылки сюда не лезть.
  for i := 0 to Plugins.Count - 1 do
    with TPlugin(Plugins.Items[i]) do
      if Loaded and Assigned(OnPacket) then
      begin
        OnPacket(id, FromServer, newpacket);
        //если плагин обнулил размер пакета
        if newpacket.Size < 3 then exit; //раньше тут был бряк, но ведь пустой пакет скриптам не нужен. поэтому екзит.
      end;


  //Скрипты
  setlength(temp,newpacket.Size - 2);
  Move(newpacket.data[0], temp[1], newpacket.size - 2);
  for i:=0 to ScriptsListVisual.Items.Count-1 do
  begin
    if fScript.ScriptsListVisual.Items.Item[i].Checked then
    begin
      cScript := fScript.FindScriptByName(fScript.ScriptsListVisual.Items.Item[i].Caption);
      if cScript <> nil then
        if cScript.isRunning and cScript.Compilled then
        begin
        //по очереди посылаем всем включенным скриптам
        //EnterCriticalSection(_cs);
        cScript.fsScript.Variables['pck'] := temp;
        cScript.fsScript.Variables['ConnectID']:=id;
        cScript.fsScript.Variables['ConnectName']:=dmdata.ConnectNameById(id);
        cScript.fsScript.Variables['FromServer']:=FromServer;
        cScript.fsScript.Variables['FromClient']:=not FromServer;
        //LeaveCriticalSection(_cs);
        cScript.fsScript.Execute;
        temp:=cScript.fsScript.Variables['pck'];
        end;
    end;
  end;
  newpacket.Size := length(temp) + 2;
  Move(temp[1], newpacket.data[0], newpacket.Size - 2);
  
  
{  SetLength(temp, TencDec(caller).Packet.Size-2);
  Move(TencDec(caller).Packet.data[1], temp[1], TencDec(caller).Packet.Size-2);
  a.a:=Word(FromServer);
  a.b:=TlspConnection(TencDec(caller).ParentLSP).SocketNum;
  SendMessage(L2PacketHackMain.Handle, WM_ExecuteScripts, Integer(@temp),a.ab);
  TencDec(caller).Packet.Size := length(temp)+2;
  Move(temp[1], TencDec(caller).Packet.Data, length(temp));
 {}
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

end.
