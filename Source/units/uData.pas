unit uData;

interface

uses
  uResourceStrings,
  uGlobalFuncs,
  ecSyntMemo,
  SysUtils,
  Classes,
  Forms,
  Dialogs,
  Graphics, 
  LSPControl,
  LSPStructures,
  ExtCtrls,
  windows,
  ComCtrls,
  math,
  uencdec,
  usharedstructs,
  uVisualContainer,
  uSocketEngine,
  uUserForm,
  StrUtils,
  Variants,
  ecPopupCtrl,
  SyncObjs,
  uScriptEditor,
  JwaWinsock2,
  fs_iinterpreter, fs_ipascal, fs_iinirtti, fs_imenusrtti, fs_idialogsrtti,
  fs_iextctrlsrtti, fs_iformsrtti, fs_iclassesrtti, siComp;

type
  TlspConnection = class (tobject)
    Visual: TfVisual;
    AssignedTabSheet : TTabSheet;
    EncDec : TEncDec;
    SocketNum : integer;
    tempfilename:string;

  private
  public
    active : boolean;
    RawLog : TFileStream;
    isRawAllowed:boolean;
    tempbufferRecv, tempbufferSend : array [0..$ffff] of byte;
    TempBufferRecvLen, TempBufferSendLen :cardinal;
    mustbedestroyed: boolean;
    DisconnectAfterDestroy : boolean;
    noFreeAfterDisconnect: boolean;
    procedure encryptAndSend(Packet: Tpacket; ToServer: Boolean);    
    procedure NewAction(action : byte; Caller: TObject);
    procedure NewPacket(var Packet:Tpacket;FromServer: boolean; Caller: TObject);
    constructor create(SocketN:integer);
    Procedure   INIT;
    procedure disconnect;
    destructor  Destroy; override;
    Procedure AddToRawLog(dirrection : byte; data:tbuffer; size:word);
  end;

  TpacketLogWiev = class (TObject)
    Visual: TfVisual;
    AssignedTabSheet : TTabSheet;
    MustBeDestroyed : boolean;
    sFileName:string;
  public
    constructor create;
    Procedure   INIT(Filename:string);
    destructor  Destroy; override;
  end;
  
  TdmData = class(TDataModule)
    LSPControl: TLSPModuleControl;
    timerSearchProcesses: TTimer;
    fsClassesRTTI1: TfsClassesRTTI;
    fsFormsRTTI1: TfsFormsRTTI;
    fsExtCtrlsRTTI1: TfsExtCtrlsRTTI;
    fsDialogsRTTI1: TfsDialogsRTTI;
    fsMenusRTTI1: TfsMenusRTTI;
    fsIniRTTI1: TfsIniRTTI;
    lang: TsiLang;
    dumbtimer: TTimer;
    procedure LSPControlLspModuleState(state: Byte);
    procedure timerSearchProcessesTimer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure LSPControlConnect(var Struct: TConnectStruct;
      var hook: Boolean);
    procedure LSPControlDisconnect(var Struct: TDisconnectStruct);
    procedure LSPControlRecv(const inStruct: TSendRecvStruct;
      var OutStruct: TSendRecvStruct);
    procedure LSPControlSend(const inStruct: TSendRecvStruct;
      var OutStruct: TSendRecvStruct);
    procedure dumbtimerTimer(Sender: TObject);
  private
    CriticalSection  : TCriticalSection;
    { Private declarations }
  public
    function FindLspConnectionBySockNum(SockNum:integer):TlspConnection;
    procedure destroyDeadLSPConnections;
    procedure destroyDeadLogWievs;

    function CallMethod(Scripter:TfsScript; CalledByScripter:boolean; Instance: TObject; ClassType: TClass; const sMethodName: String; var Params: Variant): Variant;

    procedure SendPacket(Packet: Tpacket; tid: integer; ToServer: Boolean);
    procedure SendPacketToName(Packet: Tpacket; cName: string; ToServer: Boolean);
    function ConnectNameById(id:integer):string;
    function ConnectIdByName(cname:string):integer;
    procedure SetConName(Id:integer; Name:string);

              //Каламбурное название :)
    Procedure setNoDisconnectOnDisconnect(id:integer; NoFree:boolean;IsServer:boolean);
    Procedure setNoFreeOnConnectionLost(id:integer; NoFree:boolean);
    procedure DoDisconnect(id:integer);
    function Compile(var EditorModule: tfscripteditor; var StatBat:TStatusBar): Boolean;

    procedure DO_reloadFuncs;
    procedure RefreshPrecompile(var fsScript: TfsScript);
    procedure UpdateAutoCompleate(var AutoComplete: TAutoCompletePopup);
    procedure RefreshStandartFuncs;
  end;

var
  dmData: TdmData;
  Processes :TStringList;
  LSPConnections, PacketLogWievs:Tlist;
  sockEngine : TSocketEngine;
  MyFuncs, StandartFuncs:TStringList;

implementation
uses uPluginData, uPlugins, umain, uSettingsDialog, uProcesses, advApiHook,
  uCompilling, uScripts;

var
  searchfor : string;
  searchresult : thandle;
{$R *.dfm}

{ TdmData }



procedure TdmData.LSPControlLspModuleState(state: Byte);
begin
if fSettings.InterfaceEnabled then
  case state of
  LSP_Install_success:      AddToLog(rsLSP_Install_success);//не вмешиваемся
  LSP_Already_installed:    AddToLog(rsLSP_Already_installed);
  LSP_Uninstall_success:    AddToLog(rsLSP_Uninstall_success);
  LSP_Not_installed:        ;//AddToLog(rsLSP_Not_installed);
  LSP_Install_error:
                            begin //хотели поставить но не вышло.
                              fSettings.isLSP.Enabled := true;
                              fSettings.ChkLSPIntercept.Checked := false;
                              AddToLog(rsLSP_Install_error)
                            end;
  LSP_UnInstall_error:
                            begin //хотели снять регу но не вышло.
                              fSettings.isLSP.Enabled := false;
                              fSettings.ChkLSPIntercept.Checked := true;
                              AddToLog(rsLSP_UnInstall_error)
                            end;
  LSP_Install_error_badspipath:
                            begin //хотели поставить но не вышло.
                              fSettings.isLSP.Enabled := true;
                              fSettings.ChkLSPIntercept.Checked := false;
                              AddToLog(rsLSP_Install_error_badspipath)
                            end;
  end;
end;

Function IsProcessInjected(Pid:string):boolean;
var
 hMutex : cardinal;
begin
 hMutex := CreateMutex(nil, false, pchar('injected'+pid));
 result := (GetLastError = ERROR_ALREADY_EXISTS);
 ReleaseMutex(hMutex);
 CloseHandle(hMutex);
end;

procedure TdmData.timerSearchProcessesTimer(Sender: TObject);
var
  tmp: TStrings;
  i,k: Integer;
  cc: Cardinal;
  ListSearch: string; // список процессов которые будем искать
begin

  if isDestroying then exit;
  try
  tmp:=TStringList.Create;
  ListSearch := LowerCase(sClientsList); // в нижний регистр
  // убираем все пробелы
  ListSearch := StringReplace (ListSearch, ' ', '', [rfReplaceAll]);
  // наслучай если пользователь использует ,  меняем ее на ;
  // и добавляем в конец строки ;  в поиске он нам не помешает а вот если его нет,
  // то процесс не найдется
  ListSearch := StringReplace (ListSearch, ',', ';', [rfReplaceAll])+';';

  GetProcessList(tmp);
  for i:=0 to tmp.Count-1 do begin
    // ненадо проверять по количеству процессов (tmp.Count <> ListBox1.Items.Count)
    // наслучай если поле было отредактировано
    if (fProcesses.FoundProcesses.Items.IndexOf(tmp.ValueFromIndex[i]+' ('+tmp.Names[i]+')')=-1) then
    begin
      fProcesses.FoundProcesses.Items.Clear;
      fProcesses.FoundClients.Items.Clear;
      for k := 0 to tmp.Count - 1 do
      begin
        // добавляем в лист запущеных процессов
        fProcesses.FoundProcesses.Items.Add(tmp.ValueFromIndex[k]+' ('+tmp.Names[k]+')');
        //сравниваем найденные программы со списком необходимых программ
        if (AnsiPos(tmp.ValueFromIndex[k]+';', ListSearch) > 0) and (tmp.ValueFromIndex[k] <> '')  then
        begin
          if fSettings.ChkIntercept.Checked and (Processes.Values[tmp.Names[k]]='') then
          begin
            cc := OpenProcess(PROCESS_ALL_ACCESS,False,StrToInt(tmp.Names[k]));
            if IsProcessInjected(tmp.Names[k]) then
              Processes.Values[tmp.Names[k]]:='ok'
            else
            begin
            Processes.Values[tmp.Names[k]] := 'error';
            case fSettings.HookMethod.ItemIndex of
              0:
              begin
                if InjectDll(cc, PChar(fSettings.isInject.Text)) then
                begin
                  Processes.Values[tmp.Names[k]]:='ok';
                  AddToLog (format(rsClientPatched0, [tmp.ValueFromIndex[k], tmp.Names[k]]));
                end;
              end;
              1:
              begin
                if InjectDllEx(cc, pInjectDll) then
                begin
                  Processes.Values[tmp.Names[k]]:='ok';
                  AddToLog (format(rsClientPatched1, [tmp.ValueFromIndex[k], tmp.Names[k]]));
                end;
              end;
              2:
              begin
                if InjectDllAlt(cc, PChar(fSettings.isInject.Text)) then
                begin
                  Processes.Values[tmp.Names[k]]:='ok';
                  AddToLog (format(rsClientPatched2, [tmp.ValueFromIndex[k], tmp.Names[k]]));
                end;
              end;
            end;
            end;
            CloseHandle(cc);
          end;
          fProcesses.FoundClients.Items.Add(tmp.ValueFromIndex[k]+' ('+tmp.Names[k]+') '+Processes.Values[tmp.Names[k]]);
        end;
      end;
    end;
  end;
  finally
  tmp.Free;
  end;
end;

procedure TdmData.DataModuleCreate(Sender: TObject);
begin
  Processes:=TStringList.Create;
  LSPConnections := TList.Create;
  CriticalSection  := TCriticalSection.create;
  PacketLogWievs := TList.Create;
  MyFuncs := TStringList.Create;
  StandartFuncs := TStringList.Create;
  RefreshStandartFuncs;
end;

procedure TdmData.DataModuleDestroy(Sender: TObject);
begin
  Processes.Free;
  while LSPConnections.Count > 0 do
    TlspConnection(LSPConnections.Items[0]).destroy;
  while PacketLogWievs.Count > 0 do
    TpacketLogWiev(PacketLogWievs.Items[0]).destroy;

  LSPConnections.Destroy;
  PacketLogWievs.Destroy;
  CriticalSection.destroy;
  MyFuncs.Destroy;
  StandartFuncs.Destroy;
end;



{ TlspVisual }

procedure TlspConnection.AddToRawLog(dirrection: byte; data:tbuffer;
  size: word);
var
  dtime: Double;
begin
  if not isRawAllowed then exit;
  RawLog.WriteBuffer(dirrection,1);
  RawLog.WriteBuffer(size,2);
  dtime := now;
  RawLog.WriteBuffer(dtime,8);
  RawLog.WriteBuffer(data[0],size);
end;

constructor TlspConnection.create;
begin
  LSPConnections.Add(self);
  tempfilename := 'RAW.'+IntToStr(round(random(1000000)*10000))+'.temp';
  RawLog := TFileStream.Create(tempfilename, fmOpenWrite or fmCreate);
  isRawAllowed := GlobalRawAllowed;
  SocketNum := SocketN;
  TempBufferSendLen := 0;
  TempBufferRecvLen := 0;
  mustbedestroyed := false;
  DisconnectAfterDestroy := false;
  EncDec := TencDec.create;
  EncDec.Ident := SocketNum;
  EncDec.ParentTtunel := nil;
  EncDec.ParentLSP := self;
  EncDec.Settings := GlobalSettings;
end;

destructor TlspConnection.destroy;
var
  i : integer;
begin
  if DisconnectAfterDestroy then
    if SocketNum <> 0 then
      begin
        dmData.LSPControl.CloseSocket(SocketNum);
      end;

  i := 0;
  while i < LSPConnections.Count do
    begin
      if LSPConnections.Items[i] = self then
        begin
          LSPConnections.Delete(i);
          break;
        end;
        inc(i);
    end;


  if Assigned(visual) then
    begin
      Visual.deinit;
      Visual.Destroy;
    end;
  EncDec.destroy;
  if Assigned(AssignedTabSheet) then
    AssignedTabSheet.Destroy;
  RawLog.Destroy;
  DeleteFile(pchar(tempfilename));
  inherited;
end;

procedure TlspConnection.disconnect;
begin
dmData.LSPControl.CloseSocket(SocketNum);
end;

procedure TlspConnection.encryptAndSend(Packet: Tpacket; ToServer: Boolean);
var
  Dirrection : byte;
  struct : TSendRecvStruct;
  PreSize : Word;
  PreAccumulator : TCharArray;
    
begin
  if assigned(Visual) then
  begin
    Visual.AddPacketToAcum(Packet, not ToServer, EncDec);
    Visual.processpacketfromacum;
  end;

  //кодируем
  if ToServer then
    Dirrection := PCK_GS_ToServer
  else
    Dirrection := PCK_GS_ToClient;

  EncDec.EncodePacket(packet, Dirrection);
  //Для постенкрипта
  FillChar(PreAccumulator[0],$ffff,0);
  move(packet, PreAccumulator[0], Packet.Size);
  PreSize := Packet.Size;

  if ToServer then
    EncDec.xorC.PostEncrypt(PreAccumulator, PreSize)
  else
    EncDec.xorS.PostEncrypt(PreAccumulator, PreSize);

  //Заполняем структуру
  struct.SockNum := SocketNum;
  FillChar(struct.CurrentBuff[0], $ffff, #0);

  Move(PreAccumulator[0], struct.CurrentBuff[0], PreSize);
  struct.CurrentSize := PreSize;


  if ToServer then
    dmData.LSPControl.SendToServer(struct)
  else
    dmData.LSPControl.SendToClient(struct);

end;


procedure TlspConnection.INIT;
begin
  EncDec.onNewAction := NewAction;
  EncDec.onNewPacket := NewPacket;
  EncDec.init;
  AssignedTabSheet := TTabSheet.Create(fMain.pcClientsConnection);
  AssignedTabSheet.PageControl := fMain.pcClientsConnection;
  fMain.pcClientsConnection.ActivePageIndex := AssignedTabSheet.PageIndex;
  AssignedTabSheet.Show;

  Visual := TfVisual.Create(AssignedTabSheet);
  Visual.currenttunel := nil;
  Visual.CurrentTpacketLog := nil;
  Visual.Parent := AssignedTabSheet;
  Visual.setNofreeBtns(GlobalNoFreeAfterDisconnect);
  noFreeAfterDisconnect := GlobalNoFreeAfterDisconnect;
  AssignedTabSheet.PageControl := fMain.pcClientsConnection;
  AssignedTabSheet.Caption := '[lsp]#'+inttostr(SocketNum);
  if not fMain.pcClientsConnection.Visible then fMain.pcClientsConnection.Visible  := true;
  Visual.currentLSP := self;
  Visual.init;
  active := true;
end;

procedure TlspConnection.NewAction(action: byte; Caller: TObject);
var
  encdec : TencDec;
  lspConnection : TlspConnection;

begin
case action of
  TencDec_Action_GotName:
    begin
      EncDec := TencDec(caller);
      LspConnection := nil;
      if assigned(EncDec.ParentLSP) then
        lspConnection := TlspConnection(EncDec.ParentLSP);
      if assigned(LspConnection) then
        LspConnection.AssignedTabSheet.Caption := EncDec.CharName;
    end; //данные в name; обработчик - UpdateComboBox1 (требует видоизменения)

end;

end;

procedure TlspConnection.NewPacket(var Packet:Tpacket;FromServer: boolean; Caller: TObject);
begin
  fScript.ScryptProcessPacket(packet, FromServer, TencDec(Caller).Ident); //отсылаем плагинам и скриптам
  if Packet.Size > 2 then //плагины либо скрипты могли обнулить
  if assigned(visual) then
  begin
    Visual.AddPacketToAcum(Packet, FromServer, Caller);
    visual.processpacketfromacum;
  end;
end;


function TdmData.FindLspConnectionBySockNum(SockNum: integer): TlspConnection;
var
  i : integer;
begin
i := 0;
while i < LSPConnections.Count do
  begin
    if TlspConnection(LSPConnections.Items[i]).SocketNum = SockNum then break;
    inc(i);
  end;

  if i = LSPConnections.Count then
    Result := nil
  else
    Result := TlspConnection(LSPConnections.Items[i]);
end;

procedure TdmData.destroyDeadLspConnections;
var
  i: integer;
begin
  if not Assigned(LSPConnections) then exit;

  i := 0;
  while i < LSPConnections.Count do
  begin
    if TlspConnection(LSPConnections.Items[i]).MustBeDestroyed then
    begin
      TlspConnection(LSPConnections.Items[i]).destroy;
      break;
    end
    else
    inc(i);
  end;
end;


procedure TdmData.RefreshPrecompile(var fsScript: TfsScript);
var
  i: Integer;
begin
  fsScript.Clear;
  fsScript.AddRTTI;

  i := 0;
  while i < MyFuncs.Count do
  begin
    fsScript.AddMethod(MyFuncs.Strings[i], CallMethod);
    inc(i);
  end;

  fsScript.AddForm(UserForm);
  fsScript.AddVariable('buf','String','');
  fsScript.AddVariable('pck','String','');
  fsScript.AddVariable('FromServer','Boolean',True);
  fsScript.AddVariable('FromClient','Boolean',False);
  fsScript.AddVariable('ConnectID','Integer',0);
  fsScript.AddVariable('ConnectName','String','');
  fsScript.AddVariable('UseForConnectName','String','');
  fsScript.AddVariable('UseForConnectID','Integer',0);
end;


function EnumWinsProc(Wd: HWnd; Param: LongInt): Boolean; stdcall; 
var
    buff: array[0..127] of Char;
Begin
    GetWindowText(Wd, buff, sizeof(buff));
    if lowercase(strpas(buff)) = lowercase(searchfor) then
      begin
        Result := false;
        searchresult := wd;
      end
    else
    result := true;
end;


function TdmData.CallMethod;
var
  buf,pct,tmp: string;
  temp: WideString;
  d: Integer;
  i64:Int64;
  ConId:integer;
  b: byte;
  h: Word;
  f: Double;
  LibHandle:Pointer;
  Count:Integer;
  Par:array of Pointer;
  List:variant;
  i:integer;
  ThisScriptId:integer;
  Res:Integer;
  //support DLL
  popa:array of PChar;
  count1:pchar;
  TestFunc: function (ar:array of PChar):Pchar;stdcall;
  TestProc: procedure (ar:array of PChar);stdcall;
  tstFunc1: procedure (ar:pchar);
  tstFunc: procedure (ar:integer);
  packet:TPacket;
  SelectedScript:tscript;
  mask:string;
  arr : array of variant;
  arrtmp : variant;
  //support DLL
begin
  result := Null;

  ThisScriptId := integer(Scripter);
  if Scripter.Variables['UseForConnectName'] <> '' then
      ConId := ConnectIdByName(Scripter.Variables['UseForConnectName'])
    else
      if Scripter.Variables['UseForConnectID'] <> 0 then
          ConId := Scripter.Variables['UseForConnectID']
        else
          ConId := Scripter.Variables['ConnectID'];
          
  if CalledByScripter then
  begin
  // даём возможность плагинам обработать функции
  if (sMethodName <> 'READC')
  and (sMethodName <> 'READD')
  and (sMethodName <> 'READQ')
  and (sMethodName <> 'READH')
  and (sMethodName <> 'READF')
  and (sMethodName <> 'READS')
  and (sMethodName <> 'WRITEC')
  and (sMethodName <> 'WRITED')
  and (sMethodName <> 'WRITEQ')
  and (sMethodName <> 'WRITEH')
  and (sMethodName <> 'WRITEF')
  and (sMethodName <> 'WRITES')
  and (sMethodName <> 'WRITEMASK')
  and (sMethodName <> 'READMASK')
  then
  for i:=0 to Plugins.Count - 1 do
    with TPlugin(Plugins.Items[i]) do
      if Loaded and Assigned(OnCallMethod) then
        if OnCallMethod(ConId, ThisScriptId, sMethodName, Params, Result) then Exit;
  end;
  // если плагины не обработать то обрабатываем сами
  if sMethodName = 'READC' then begin
    pct := scripter.Variables['pck'];
    if Integer(Params[0])<=Length(pct)-1 then b:=Byte(pct[Integer(Params[0])])
    else b:=0;
    Params[0]:=Integer(Params[0])+1;
    Result:=b;
  end else
  if sMethodName = 'READD' then begin
    pct := scripter.Variables['pck'];
    if Integer(Params[0])<=Length(pct)-3 then
      Move(pct[Integer(Params[0])],d,4);
    Params[0]:=Integer(Params[0])+4;
    Result:=d;
  end else
  if sMethodName = 'READQ' then begin
    pct := scripter.Variables['pck'];
    if Integer(Params[0])<=Length(pct)-7 then Move(pct[Integer(Params[0])],i64,8);
    Params[0]:=Integer(Params[0])+8;
    Result:=i64;
  end else
  if sMethodName = 'READH' then begin
    pct := scripter.Variables['pck'];
    if Integer(Params[0])<=Length(pct)-1 then Move(pct[Integer(Params[0])],h,2);
    Params[0]:=Integer(Params[0])+2;
    Result:=h;
  end else
  if sMethodName = 'READF' then begin
    pct := scripter.Variables['pck'];
    if Integer(Params[0])<=Length(pct)-7 then Move(pct[Integer(Params[0])],f,8);
    Params[0]:=Integer(Params[0])+8;
    Result:=f;
  end else
  if sMethodName = 'READS' then begin
    pct := Scripter.Variables['pck'];
    d:=PosEx(#0#0,pct,Integer(Params[0]))-Integer(Params[0]);
    if (d mod 2)=1 then Inc(d);
    SetLength(temp,d div 2);
    if d>=2 then Move(pct[Integer(Params[0])],temp[1],d) else d:=0;
    Params[0]:=Integer(Params[0])+d+2;
    tmp:=temp;
    Result:=tmp;//WideStringToString(temp,1251);
  end else
  if sMethodName = 'WRITEC' then begin
    buf := Scripter.Variables['buf'];
    b:=Params[0];
    if Integer(Params[1])=0 then buf:=buf+Char(b)
      else buf[Integer(Params[1])]:=Char(b);
    Scripter.Variables['buf']:=buf;
  end else
  if sMethodName = 'WRITED' then begin
    buf := Scripter.Variables['buf'];
    SetLength(tmp,4);
    d:=Params[0];
    if Integer(Params[1])=0 then begin
      Move(d,tmp[1],4);
      buf:=buf+tmp;
    end else begin
      Move(d,buf[Integer(Params[1])],4);
    end;
    Scripter.Variables['buf'] := buf;
  end else
  if sMethodName = 'WRITEQ' then begin
    buf := Scripter.Variables['buf'];
    SetLength(tmp,8);
    i64:=Params[0];
    if Integer(Params[1])=0 then begin
      Move(i64,tmp[1],8);
      buf:=buf+tmp;
    end else begin
      Move(i64,buf[Integer(Params[1])],8);
    end;
    Scripter.Variables['buf'] := buf;
  end else
  if sMethodName = 'WRITEH' then begin
    buf := Scripter.Variables['buf'];
    SetLength(tmp,2);
    h:=Params[0];
    if Integer(Params[1])=0 then begin
      Move(h,tmp[1],2);
      buf:=buf+tmp;
    end else begin
      Move(h,buf[Integer(Params[1])],2);
    end;
    Scripter.Variables['buf'] := buf;
  end else
  if sMethodName = 'WRITEF' then begin
    buf := Scripter.Variables['buf'];
    SetLength(tmp,8);
    f:=Params[0];
    if Integer(Params[1])=0 then begin
      Move(f,tmp[1],8);
      buf:=buf+tmp;
    end else begin
      Move(f,buf[Integer(Params[1])],8);
    end;
    Scripter.Variables['buf'] := buf;
  end else
  if sMethodName = 'WRITES' then begin
    buf := Scripter.Variables['buf'];
    tmp:=Params[0];
    temp:=tmp;//StringToWideString(tmp,1251);
    tmp:=tmp+tmp;
    Move(temp[1],tmp[1],Length(tmp));
    buf:=buf+tmp+#0#0;
    Scripter.Variables['buf']:=buf;
  end else
  if sMethodName = 'WRITEMASK' then begin
    mask := UpperCase(Params[0]);
    arr := params[1];
    i := 0;
    while (i < length(mask)) do
    begin
      arrtmp := VarArrayOf([arr[i],0]);
      case mask[i+1] of
      'S':CallMethod(Scripter, false, Instance,ClassType,'WRITES',arrtmp);
      'C':CallMethod(Scripter, false, Instance,ClassType,'WRITEC',arrtmp);
      'D':CallMethod(Scripter, false, Instance,ClassType,'WRITED',arrtmp);
      'H':CallMethod(Scripter, false, Instance,ClassType,'WRITEH',arrtmp);
      'F':CallMethod(Scripter, false, Instance,ClassType,'WRITEF',arrtmp);
      'Q':CallMethod(Scripter, false, Instance,ClassType,'WRITEQ',arrtmp);
      end;
      inc(i);
    end;
  end else
  if sMethodName = 'READMASK' then begin
    mask := UpperCase(Params[0]);
    arrtmp := VarArrayOf([Params[1]]);
    arr := Params[2];
    i := 0;
    while (i < length(mask)) do
    begin
      case mask[i+1] of
      'S':arr[i] := CallMethod(Scripter, false, Instance,ClassType,'READS',arrtmp);
      'C':arr[i] := CallMethod(Scripter, false, Instance,ClassType,'READC',arrtmp);
      'D':arr[i] := CallMethod(Scripter, false, Instance,ClassType,'READD',arrtmp);
      'H':arr[i] := CallMethod(Scripter, false, Instance,ClassType,'READH',arrtmp);
      'F':arr[i] := CallMethod(Scripter, false, Instance,ClassType,'READF',arrtmp);
      'Q':arr[i] := CallMethod(Scripter, false, Instance,ClassType,'READQ',arrtmp);
      end;
      inc(i);
    end;
    Params[2] := arr;
    Params[1] := arrtmp[0];
  end else  
  if sMethodName = 'CANUSEALTTAB' then begin
    searchfor := VarAsType(Params[0],varString);
    if searchfor <> '' then
    begin
      //FindWindow ищет по верхнему уровню. значит поступим воттак
      searchresult := 0;
      EnumWindows (@EnumWinsProc, 0);
      if searchresult > 0 then
      begin
        SetWindowLong(searchresult, GWL_EXSTYLE,
        GetWindowLong(searchresult, GWL_EXSTYLE) or WS_EX_APPWINDOW);
      end
    end;
  end else
  if sMethodName = 'SENDTOCLIENT' then begin
    buf := Scripter.Variables['buf'];
    packet.Size := Length(buf)+2;
    Move(buf[1], packet.Data[0], Length(buf));
    SendPacket(packet, ConId, False);
  end else
  if sMethodName = 'SENDTOSERVER' then begin
    buf := scripter.Variables['buf'];
    packet.Size := Length(buf)+2;
    Move(buf[1], packet.Data[0], Length(buf));
    SendPacket(packet, ConId, true);
  end else
  if sMethodName = 'SENDTOCLIENTEX' then begin
    buf := scripter.Variables['buf'];
    packet.Size := Length(buf)+2;
    Move(buf[1], packet.Data[0], Length(buf));
    SendPacketToName(packet, string(Params[0]), False);
  end else
  if sMethodName = 'SENDTOSERVEREX' then begin
    buf := scripter.Variables['buf'];
    packet.Size := Length(buf)+2;
    Move(buf[1], packet.Data[0], Length(buf));
    SendPacketToName(packet, string(Params[0]), True);
  end else

  if sMethodName = 'LOADLIBRARY' then begin
    Result := LoadLibrary(PAnsiChar(VarToStr(Params[0])));
  end else
  if sMethodName = 'HSTR' then Result:=HexToString(Params[0]) else
  //for support DLL
  if sMethodName = 'STRTOHEX' then Result:=StringToHex(Params[0],'') else
  if sMethodName = 'CALLPR' then begin
    @TestProc := nil;
    @TestProc := GetProcAddress(Cardinal(Params[0]),PAnsiChar(VarToStr(Params[1])));
    if @TestProc <> nil then begin
      Count := Params[2];
      setLength(popa,count);
      for i:=0 to Count-1 do
      popa[i]:=PChar(VarToStr(Params[3][i]));
      TestProc(popa);
    end;
    @TestProc:=nil;
  end else
  if sMethodName = 'CALLFNC' then begin
    @TestFunc := nil;
    @TestFunc := GetProcAddress(Cardinal(Params[0]),PAnsiChar(VarToStr(Params[1])));
    if @TestFunc <> nil then begin
      Count := Params[2];
      setLength(popa,count);
      for i:=0 to Count-1 do
      popa[i]:=PChar(VarToStr(Params[3][i]));
      Result:=StrPas(TestFunc(popa));
    end;
    @TestFunc:=nil;
  end else
  if sMethodName = 'TESTFUNC' then begin
    @tstFunc:= nil;
    @tstFunc := GetProcAddress(Cardinal(Params[0]),PAnsiChar(VarToStr(Params[1])));
    if @tstFunc <> nil then begin
      Count := Params[2];
      tstFunc(Count);
    end;
  end else
  if sMethodName = 'TESTFUNC1' then begin
    @tstFunc1:= nil;
    @tstFunc1 := GetProcAddress(Cardinal(Params[0]),PAnsiChar(VarToStr(Params[1])));
    if @tstFunc1 <> nil then begin
      Count1 := PAnsiChar(VarToStr(Params[2]));
      tstFunc1(Count1);
    end;
  end else
{/*by wanick*/}
  if sMethodName = 'CALLSF' then begin
    Res:= -1;
    SelectedScript := nil;
    if Params[0] <> '' then
      SelectedScript := fScript.FindScriptByName(Params[0]);
    if SelectedScript = nil then
      begin
        AddToLog (lang.GetTextOrDefault('IDS_110' (* 'Script: скрипт с именем ' *) )+Params[0]+lang.GetTextOrDefault('IDS_111' (* 'не найден !' *) ));
      end
    else
      begin //Скрипт найден.
          if not SelectedScript.ListItem.Checked then
            //но при этом не отмечен
            AddToLog (lang.GetTextOrDefault('IDS_112' (* 'Скрипт к которому вы обращаетесь (' *) )+Params[0]+lang.GetTextOrDefault('IDS_113' (* ') не включен!' *) ))
          else
            try//все в порядке
            Result := SelectedScript.Editor.fsScript.CallFunction(Params[1], Params[2]);
            except
            AddToLog (lang.GetTextOrDefault('IDS_114' (* 'При вызове ' *) )+Params[0]+lang.GetTextOrDefault('IDS_115' (* ' произошла ошибка в вызываемом методе! (' *) )+inttostr(GetLastError)+')')
            end;

      end;
  end else
  if sMethodName = 'SENDMSG'  then
  begin
    if Params[0] <> null then
      AddToLog('Script: '+Params[0]);
  end else
{/*by wanick*/}
  //for support DLL
  if sMethodName = 'CALLFUNCTION' then begin
    LibHAndle := nil;
    LibHandle := GetProcAddress(Cardinal(Params[0]),PAnsiChar(VarToStr(Params[1])));
    if LibHandle <> nil then begin
      Count := Params[2];
      SetLength(Par,Count);
      List := VarArrayRef(Params[3]);
      for i:= 0 to count -1 do
        Par[i]  := FindVarData(VarArrayRef(List)[i])^.VPointer;
      asm
        pusha;
        mov edx,[par]
        mov ecx, Count;
        cmp ecx,0
        jz @@m1;
        @@loop:
        dec ecx;
        mov eax,[edx + ecx*4];
        push eax;
        jnz @@loop;
        @@m1:
        call LibHandle;
        mov Res,eax;
        popa;
      end;
      List := 0;
      Result := Res;
    end;
  end else
  if sMethodName = 'FREELIBRARY' then
    Result := FreeLibrary(Params[0]) else
  if sMethodName = 'CONNECTNAMEBYID' then begin
    Result:=CONNECTNAMEBYID(integer(Params[0]))
  end else
  if sMethodName = 'CONNECTIDBYNAME' then begin
    Result := ConnectIdByName(string(Params[0]));
  end else
  if sMethodName = 'SETNAME' then begin
    buf := Scripter.Variables['buf'];
    SetConName(ConId, String(Params[0]));
  end else
  if sMethodName = 'NOCLOSESERVERAFTERCLIENTDISCONNECT' then begin
    setNoDisconnectOnDisconnect(ConId, true, false);
  end else
  if sMethodName = 'CLOSESERVERAFTERCLIENTDISCONNECT' then begin
    setNoDisconnectOnDisconnect(ConId, false, true);
  end else
  if sMethodName = 'NOCLOSECLIENTAFTERSERVERDISCONNECT' then begin
    setNoDisconnectOnDisconnect(ConId, true, true);
  end else
  if sMethodName = 'CLOSECLIENTAFTERSERVERDISCONNECT' then begin
    setNoDisconnectOnDisconnect(ConId, false, false);
  end else
  if sMethodName = 'NOCLOSEFRAMEAFTERDISCONNECT' then begin
    setNoFreeOnConnectionLost(ConId, true);
  end else
  if sMethodName = 'CLOSEFRAMEAFTERDISCONNECT' then begin
    setNoFreeOnConnectionLost(ConId, false);
  end ELSE
  if sMethodName = 'DISCONNECT' then begin
    DoDisconnect(ConId);
  end else
  if sMethodName = 'DELAY' then Sleep(Params[0]) else
  if sMethodName = 'SHOWFORM' then
    begin
      UserForm.Show;
      fMain.nUserFormShow.Enabled := true;
    end
    else
  if sMethodName = 'HIDEFORM' then
      begin
      UserForm.Hide;
      fMain.nUserFormShow.Enabled := false;
    end;

end;

procedure TdmData.SendPacket(Packet: Tpacket; tid: integer; ToServer: Boolean);
var
  i : integer;
begin
// Совместимо.
//нужно бужет найти соединение по айди и отправить данные
  if tid = 0 then exit;
  i := 0;
  while i < LSPConnections.Count do
  begin
    if (TlspConnection(LSPConnections.Items[i]).SocketNum = tid) then
      begin
        TlspConnection(LSPConnections.Items[i]).encryptAndSend(Packet, toserver);
        exit;
      end;
    inc(i);
  end;

  i := 0;
  while i < sockEngine.tunels.Count do
  begin
    if (Ttunel(sockEngine.tunels.Items[i]).initserversocket = tid) then
      begin
        Ttunel(sockEngine.tunels.Items[i]).EncryptAndSend(Packet, toserver);
        exit;
      end;
    inc(i);
  end;
end;

procedure TdmData.SendPacketToName(Packet: Tpacket; cName: string; ToServer: Boolean);
var
i : integer;
begin
//Совместимо.
//нужно найти соединение с указаным именем и отправить данные
  i := ConnectIdByName(cName);
  if i > 0 then
    SendPacket(Packet, i, ToServer);
end;

function TdmData.CONNECTNAMEBYID(id: integer): string;
var
  i : integer;
begin
// Совместимо.
//Получение имени по номеру соединения
  Result :=  '';
  i := 0;
  while i < LSPConnections.Count do
  begin
    if TlspConnection(LSPConnections.Items[i]).SocketNum = id then
      begin
        Result := TlspConnection(LSPConnections.Items[i]).EncDec.CharName;
        exit;
      end;
    inc(i);
  end;

  i := 0;
  while i < sockEngine.tunels.Count do
  begin
    if Ttunel(sockEngine.tunels.Items[i]).initserversocket = id then
      begin
        result := Ttunel(sockEngine.tunels.Items[i]).EncDec.CharName;
        exit;
      end;
    inc(i);
  end;
end;

function TdmData.ConnectIdByName(cname: string): integer;
var
  i : integer;
begin
// Совместимо.
//получение айди по имени
  Result :=  0;
  i := 0;
  while i < LSPConnections.Count do
  begin
    if (LowerCase(TlspConnection(LSPConnections.Items[i]).EncDec.CharName) = LowerCase(cname)) and
        (TlspConnection(LSPConnections.Items[i]).active) then
      begin
        Result := TlspConnection(LSPConnections.Items[i]).SocketNum;
        exit;
      end;
    inc(i);
  end;

  i := 0;
  while i < sockEngine.tunels.Count do
  begin
    if (LowerCase(Ttunel(sockEngine.tunels.Items[i]).EncDec.CharName) = LowerCase(cname)) and
     (Ttunel(sockEngine.tunels.Items[i]).active) then
      begin
        result := Ttunel(sockEngine.tunels.Items[i]).initserversocket;
        exit;
      end;
    inc(i);
  end;
end;

procedure TdmData.SetConName(Id: integer; Name: string);
var
  i : integer;
begin
// Совместимо.
//назначение имени соединению
  i := 0;
  while i < LSPConnections.Count do
  begin
    if TlspConnection(LSPConnections.Items[i]).SocketNum = id then
      begin
        TlspConnection(LSPConnections.Items[i]).EncDec.CharName := name;
        exit;
      end;
    inc(i);
  end;

  i := 0;
  while i < sockEngine.tunels.Count do
  begin
    if Ttunel(sockEngine.tunels.Items[i]).initserversocket = id then
      begin
        Ttunel(sockEngine.tunels.Items[i]).EncDec.CharName := name;
        exit;
      end;
    inc(i);
  end;
end;

procedure TdmData.setNoDisconnectOnDisconnect(id: integer; NoFree: boolean;IsServer:boolean);
var
  i : integer;
begin
// Совместимо.
//Назначить nofree
  i := 0;
  while i < sockEngine.tunels.Count do
  begin
    if Ttunel(sockEngine.tunels.Items[i]).initserversocket = id then
      begin
        if IsServer then
        Ttunel(sockEngine.tunels.Items[i]).noFreeOnServerDisconnect := NoFree
        else
        Ttunel(sockEngine.tunels.Items[i]).noFreeOnClientDisconnect := NoFree;
        exit;
      end;
    inc(i);
  end;
end;


procedure TdmData.DoDisconnect(id: integer);
var
i : integer;
begin
  i := 0;
  while i < LSPConnections.Count do
  begin
    if TlspConnection(LSPConnections.Items[i]).SocketNum = id then
      begin
        TlspConnection(LSPConnections.Items[i]).mustbedestroyed := true;
        exit;
      end;
    inc(i);
  end;

  i := 0;
  while i < sockEngine.tunels.Count do
  begin
    if Ttunel(sockEngine.tunels.Items[i]).initserversocket = id then
      begin
        Ttunel(sockEngine.tunels.Items[i]).mustbedestroyed := true;
        exit;
      end;
    inc(i);
  end;
end;


function TdmData.Compile;
var
  ps,x,y: Integer;
  p:tpoint;
begin
  fCompilling.AssignedSEditor := EditorModule;
  fCompilling.ActivateMe;
  RefreshPrecompile(EditorModule.fsScript);
  EditorModule.fsScript.Lines.Assign(EditorModule.editor.Lines);
  if not EditorModule.fsScript.Compile then
  try
    ps:=Pos(':',EditorModule.fsScript.ErrorPos);
    x:=StrToInt(Copy(EditorModule.fsScript.ErrorPos,ps+1,length(EditorModule.fsScript.ErrorPos)-ps));
    y:=StrToInt(Copy(EditorModule.fsScript.ErrorPos,1,ps-1));
    EditorModule.Editor.Gutter.Objects.Items[0].Line := y-1;
    p.X := x-1;
    p.Y := y-1;
    if EditorModule.Editor.Visible then
    try
      EditorModule.Editor.SetFocus;
    except
    //....
    end;
    with EditorModule do
    begin
    Editor.CurrentLine := y-1;
    Editor.ShowLine(y-1);
    Editor.SelectLine(y-1);
    Editor.SelectWord;
    Editor.Invalidate;
    StatBat.SimpleText:=lang.GetTextOrDefault('IDS_149' (* 'Ошибка: ' *) )+fsScript.ErrorMsg + lang.GetTextOrDefault('IDS_150' (* ', позиция: ' *) )+fsScript.ErrorPos;
    Result:=False;
    end;
  except
    StatBat.SimpleText:=lang.GetTextOrDefault('IDS_149' (* 'Ошибка: ' *) )+EditorModule.fsScript.ErrorMsg + '>' + EditorModule.fsScript.ErrorPos;
    Result:=False;
  end
   else
  begin
    StatBat.SimpleText:=lang.GetTextOrDefault('IDS_151' (* 'Скрипт проверен' *) );
    Result:=True;
  end;
  fCompilling.deactivateMe;
end;

procedure TdmData.destroyDeadLogWievs;
var
  i: integer;
begin
  if not Assigned(PacketLogWievs) then exit;
  i := 0;
  while i < PacketLogWievs.Count do
  begin
    if TpacketLogWiev(PacketLogWievs.Items[i]).MustBeDestroyed then
    begin
      TpacketLogWiev(PacketLogWievs.Items[i]).destroy;
      break;
    end
    else
    inc(i);
  end;
end;

procedure TdmData.setNoFreeOnConnectionLost(id: integer; NoFree:boolean);
var
  i : integer;
begin
// Совместимо.
//Назначить nofree
  i := 0;
  while i < LSPConnections.Count do
  begin
    if TlspConnection(LSPConnections.Items[i]).SocketNum = id then
      begin
        TlspConnection(LSPConnections.Items[i]).noFreeAfterDisconnect := NoFree;
        exit;
      end;
    inc(i);
  end;

  i := 0;
  while i < sockEngine.tunels.Count do
  begin
    if Ttunel(sockEngine.tunels.Items[i]).initserversocket = id then
      begin
        Ttunel(sockEngine.tunels.Items[i]).noFreeAfterDisconnect := NoFree;
        exit;
      end;
    inc(i);
  end;
end;

procedure TdmData.UpdateAutoCompleate;
var
  i : integer;
  Orig, fname:String;
begin
  i := 0;
  AutoComplete.Items.Clear;
  AutoComplete.DisplayItems.Clear;
  
  while i < MyFuncs.Count do
  begin
    orig := MyFuncs.Strings[i];
    fname := orig;
    delete(fname, 1, pos(' ', fname));
    if pos('(',fname) > 0 then
      begin
      delete(fname, pos('(',fname), length(fname)-pos('(',fname)+1);
      fname := fname + '(';
      end;
    AutoComplete.DisplayItems.add(Orig+';');
    AutoComplete.Items.add(fname);
    inc(i);
  end;

  i := 0;
  while i < StandartFuncs.Count do
  begin
    orig := StandartFuncs.Strings[i];
    fname := orig;
    delete(fname, 1, pos(' ', fname));
    if pos('(',fname) > 0 then
      begin
      delete(fname, pos('(',fname), length(fname)-pos('(',fname)+1);
      fname := fname + '(';
      end;
    AutoComplete.DisplayItems.add(Orig+';');
    AutoComplete.Items.add(fname);
    inc(i);
  end;
  

  AutoComplete.DisplayItems.add('var buf: string;');
  AutoComplete.Items.add('buf');

  AutoComplete.DisplayItems.add('var pck: string;');
  AutoComplete.Items.add('pck');

  AutoComplete.DisplayItems.add('const FromServer: Boolean;');
  AutoComplete.Items.add('FromServer');

  AutoComplete.DisplayItems.add('const FromClient: Boolean;');
  AutoComplete.Items.add('FromClient');

  AutoComplete.DisplayItems.add('const ConnectID: Integer;');
  AutoComplete.Items.add('ConnectID');

  AutoComplete.DisplayItems.add('const ConnectName: string;');
  AutoComplete.Items.add('ConnectName');

  AutoComplete.DisplayItems.add('var UseForConnectName: string;');
  AutoComplete.Items.add('UseForConnectName');

  AutoComplete.DisplayItems.add('var UseForConnectID: Integer;');
  AutoComplete.Items.add('UseForConnectID');

end;

procedure TdmData.DO_reloadFuncs;
var
  i:integer;
begin
  MyFuncs.Clear;
  MyFuncs.Add('function HStr(Hex:String):String');
  MyFuncs.Add('procedure SendToClient()');
  MyFuncs.Add('procedure SendToServer()');
  MyFuncs.Add('procedure SendToClientEx(CharName:string)');
  MyFuncs.Add('procedure SendToServerEx(CharName:string)');
  MyFuncs.Add('procedure NoCloseFrameAfterDisconnect()');
  MyFuncs.Add('procedure CloseFrameAfterDisconnect()');
  MyFuncs.Add('procedure NoCloseClientAfterServerDisconnect()');
  MyFuncs.Add('procedure CloseClientAfterServerDisconnect()');
  MyFuncs.Add('procedure NoCloseServerAfterClientDisconnect()');
  MyFuncs.Add('procedure CloseServerAfterClientDisconnect()');
  MyFuncs.Add('procedure Disconnect()');
  MyFuncs.Add('function ConnectNameByID(id:integer):string');
  MyFuncs.Add('function ConnectIDByName(name:string):integer');
  MyFuncs.Add('procedure SetName(Name:string)');
  MyFuncs.Add('procedure Delay(msec: Cardinal)');
  MyFuncs.Add('procedure ShowForm()');
  MyFuncs.Add('procedure HideForm()');
  MyFuncs.Add('procedure WriteS(v:string)');
  MyFuncs.Add('procedure WriteC(v:byte; ind:integer=0)');
  MyFuncs.Add('procedure WriteD(v:integer; ind:integer=0)');
  MyFuncs.Add('procedure WriteH(v:word; ind:integer=0)');
  MyFuncs.Add('procedure WriteF(v:double; ind:integer=0)');
  MyFuncs.Add('procedure WriteQ(v:int64; ind:integer=0)');
  MyFuncs.Add('procedure WriteMask(Mask:string; parameters : array of variant)');
  MyFuncs.Add('function ReadS(var index:integer):string');
  MyFuncs.Add('function ReadC(var index:integer):byte');
  MyFuncs.Add('function ReadD(var index:integer):integer');
  MyFuncs.Add('function ReadH(var index:integer):word');
  MyFuncs.Add('function ReadF(var index:integer):double');
  MyFuncs.Add('function ReadQ(var index:integer):Int64');
  MyFuncs.Add('procedure ReadMask(Mask:string; var index:integer; var resultarray : array of variant)');
  MyFuncs.Add('function LoadLibrary(LibName:String):Integer');
  MyFuncs.Add('function FreeLibrary(LibHandle:Integer):Boolean');
  MyFuncs.Add('function StrToHex(str1:String):String');
  MyFuncs.Add('procedure CallPr(LibHandle:integer;FunctionName:String;Count:Integer;Params:array of variant)');
  MyFuncs.Add('function CallFnc(LibHandle:integer;FunctionName:String;Count:Integer;Params:array of variant):string');
  MyFuncs.Add('procedure TestFunc(LibHandle:integer;FunctionName:String;Count:Integer)');
  MyFuncs.Add('procedure TestFunc1(LibHandle:integer;FunctionName:String;Count1:variant)');
  MyFuncs.Add('function CallFunction(LibHandle:integer;FunctionName:String;Count:Integer;Params:array of variant):variant');
  MyFuncs.Add('function CallSF(ScriptName:String;FunctionName:String;Params:array of variant):variant');
  MyFuncs.Add('procedure sendMSG(msg:String)');
  MyFuncs.Add('procedure CanUseAltTab(FormCaption: string)');

  PluginStruct.UserFuncs.clear;
  if assigned(Plugins) then
  begin
  // позволяем плагинам добавить свои функции в скрипты
  for i:=0 to Plugins.Count - 1 do
    with TPlugin(Plugins.Items[i]) do
      if Loaded and Assigned(OnRefreshPrecompile) then
      begin
        OnRefreshPrecompile;
        MyFuncs.AddStrings(PluginStruct.UserFuncs);
        PluginStruct.UserFuncs.clear;
      end;
  end;
  
end;

procedure TdmData.RefreshStandartFuncs;
begin
StandartFuncs.Clear;
StandartFuncs.Add('function IntToStr(i: Integer): String');
StandartFuncs.Add('function FloatToStr(e: Extended): String');
StandartFuncs.Add('function DateToStr(e: Extended): String');
StandartFuncs.Add('function TimeToStr(e: Extended): String');
StandartFuncs.Add('function DateTimeToStr(e: Extended): String');
StandartFuncs.Add('function VarToStr(v: Variant): String');
StandartFuncs.Add('function StrToInt(s: String): Integer');
StandartFuncs.Add('function StrToFloat(s: String): Extended');
StandartFuncs.Add('function StrToDate(s: String): Extended');
StandartFuncs.Add('function StrToTime(s: String): Extended');
StandartFuncs.Add('function StrToDateTime(s: String): Extended');
StandartFuncs.Add('function Format(Fmt: String; Args: array): String');
StandartFuncs.Add('function FormatFloat(Fmt: String; Value: Extended): String');
StandartFuncs.Add('function FormatDateTime(Fmt: String; DateTime: TDateTime): String');
StandartFuncs.Add('function FormatMaskText(EditMask: string; Value: string): string');
StandartFuncs.Add('function EncodeDate(Year, Month, Day: Word): TDateTime');
StandartFuncs.Add('procedure DecodeDate(Date: TDateTime; var Year, Month, Day: Word)');
StandartFuncs.Add('function EncodeTime(Hour, Min, Sec, MSec: Word): TDateTime');
StandartFuncs.Add('procedure DecodeTime(Time: TDateTime; var Hour, Min, Sec, MSec: Word)');
StandartFuncs.Add('function Date: TDateTime');
StandartFuncs.Add('function Time: TDateTime');
StandartFuncs.Add('function Now: TDateTime');
StandartFuncs.Add('function DayOfWeek(aDate: DateTime): Integer');
StandartFuncs.Add('function IsLeapYear(Year: Word): Boolean');
StandartFuncs.Add('function DaysInMonth(nYear, nMonth: Integer): Integer');
StandartFuncs.Add('function Length(s: String): Integer');
StandartFuncs.Add('function Copy(s: String; from, count: Integer): String');
StandartFuncs.Add('function Pos(substr, s: String): Integer');
StandartFuncs.Add('procedure Delete(var s: String; from, count: Integer)');
StandartFuncs.Add('procedure Insert(s: String; var s2: String; pos: Integer)');
StandartFuncs.Add('function Uppercase(s: String): String');
StandartFuncs.Add('function Lowercase(s: String): String');
StandartFuncs.Add('function Trim(s: String): String');
StandartFuncs.Add('function NameCase(s: String): String');
StandartFuncs.Add('function CompareText(s, s1: String): Integer');
StandartFuncs.Add('function Chr(i: Integer): Char');
StandartFuncs.Add('function Chr(i: Integer): Char');
StandartFuncs.Add('function Ord(ch: Char): Integer');
StandartFuncs.Add('procedure SetLength(var S: String; L: Integer)');
StandartFuncs.Add('function Round(e: Extended): Integer');
StandartFuncs.Add('function Trunc(e: Extended): Integer');
StandartFuncs.Add('function Int(e: Extended): Integer');
StandartFuncs.Add('function Frac(X: Extended): Extended');
StandartFuncs.Add('function Sqrt(e: Extended): Extended');
StandartFuncs.Add('function Abs(e: Extended): Extended');
StandartFuncs.Add('function Sin(e: Extended): Extended');
StandartFuncs.Add('function Cos(e: Extended): Extended');
StandartFuncs.Add('function ArcTan(X: Extended): Extended');
StandartFuncs.Add('function Tan(X: Extended): Extended');
StandartFuncs.Add('function Exp(X: Extended): Extended');
StandartFuncs.Add('function Ln(X: Extended): Extended');
StandartFuncs.Add('function Pi: Extended');
StandartFuncs.Add('procedure Inc(var i: Integer; incr: Integer = 1)');
StandartFuncs.Add('procedure Dec(var i: Integer; decr: Integer = 1)');
StandartFuncs.Add('procedure RaiseException(Param: String)');
StandartFuncs.Add('procedure ShowMessage(Msg: Variant)');
StandartFuncs.Add('procedure Randomize');
StandartFuncs.Add('function Random: Extended');
StandartFuncs.Add('function ValidInt(cInt: String): Boolean');
StandartFuncs.Add('function ValidFloat(cFlt: String): Boolean');
StandartFuncs.Add('function ValidDate(cDate: String): Boolean');
StandartFuncs.Add('function CreateOleObject(ClassName: String): Variant');
StandartFuncs.Add('function VarArrayCreate(Bounds: Array; Typ: Integer): Variant');
end;

{ TpacketLogWiev }

constructor TpacketLogWiev.create;
begin
  PacketLogWievs.Add(self);
  mustbedestroyed := false;
end;

destructor TpacketLogWiev.destroy;
var
  i : integer;
begin
  i := 0;
  while i < PacketLogWievs.Count do
    begin
      if PacketLogWievs.Items[i] = self then
        begin
          PacketLogWievs.Delete(i);
          break;
        end;
        inc(i);
    end;
  if Assigned(visual) then
    begin
      Visual.deinit;
      Visual.Destroy;
    end;

  if Assigned(AssignedTabSheet) then
    AssignedTabSheet.Destroy;    
  inherited;
end;

procedure TpacketLogWiev.INIT;
begin
  sFileName := Filename;
  AssignedTabSheet := TTabSheet.Create(fMain.pcClientsConnection);
  AssignedTabSheet.PageControl := fMain.pcClientsConnection;
  fMain.pcClientsConnection.ActivePageIndex := AssignedTabSheet.PageIndex;
  AssignedTabSheet.Show;
  Visual := TfVisual.Create(AssignedTabSheet);
  Visual.currenttunel := nil;
  Visual.currentLSP := nil;
  Visual.Parent := AssignedTabSheet;
  Visual.setNofreeBtns(GlobalNoFreeAfterDisconnect);
  AssignedTabSheet.Caption := '[log]#'+ExtractFileName(Filename);
  if not fMain.pcClientsConnection.Visible then fMain.pcClientsConnection.Visible  := true;
  Visual.CurrentTpacketLog := self;
  Visual.init;
  visual.Panel7.Width := 30;//там у нас только одна кнопка..

  
end;

procedure TdmData.LSPControlConnect(var Struct: TConnectStruct;
  var hook: Boolean);
var
  str : string;
  i : integer;
  newlspconnection : TlspConnection;
  needhook : boolean;
begin
  hook := false;
  needhook := (Pos(';'+IntToStr(Struct.port)+';',';'+sIgnorePorts+';')=0);
  if needhook then
    if fSettings.lspInterceptMethod.ItemIndex = 1 then
        str := rsLSPConnectionWillbeInterceptedAndRettirected
      else
        str := rsLSPConnectionWillbeIntercepted
    else
      str := rsLSPConnectionWillbeIgnored;
    
  AddToLog(Format(rsLSPConnectionDetected, [Struct.SockNum, Struct.ip, Struct.port, str]));

  if needhook then
  if fSettings.lspInterceptMethod.ItemIndex = 1 then
    begin
      hook := true;
      newlspconnection := TlspConnection.create(Struct.SockNum);
      newlspconnection.INIT;
      Application.ProcessMessages;
      //Уведомляем плагины
      for i:=0 to Plugins.Count - 1 do with TPlugin(Plugins.Items[i]) do
      if Loaded  then
      begin
        if Assigned(OnConnect) then OnConnect(Struct.SockNum, true);
        if Assigned(OnConnect) then OnConnect(Struct.SockNum, false);
      end;
    end
  else
  begin
    sockEngine.RedirrectIP := inet_addr(pchar(string(Struct.ip)));
    sockEngine.RedirrectPort := HToNS(Struct.port);//msg.LParamLo;
    Struct.port := LocalPort;
    Struct.reddirect := true;
  end;


end;

procedure TdmData.LSPControlDisconnect(var Struct: TDisconnectStruct);
var
  connection : TlspConnection;
  i : integer;

begin
  //Уведомляем плагины
  for i:=0 to Plugins.Count - 1 do with TPlugin(Plugins.Items[i]) do
  if Loaded  then
  begin
    if Assigned(OnDisconnect) then OnDisconnect(Struct.SockNum, true);
    if Assigned(OnDisconnect) then OnDisconnect(Struct.SockNum, false);
  end;


  connection := FindLspConnectionBySockNum(Struct.SockNum);
  if assigned(connection) then
    if not connection.noFreeAfterDisconnect then
      begin
        connection.SocketNum := 0;
        connection.active := false;
        connection.destroy;
      end
    else
    begin
      connection.Visual.ThisOneDisconnected;
      connection.active := false;
    end;
  AddToLog(Format(rsLSPDisconnectDetected, [Struct.SockNum]));
end;



procedure TdmData.LSPControlRecv(const inStruct: TSendRecvStruct;
  var OutStruct: TSendRecvStruct);
var
  LspConnection : TlspConnection;
  PcktLen : Word;
  //ResultBuff : Tbuffer;
  //ResultLen : cardinal;
  tmppack:tpacket;
  TmpInStruct : TSendRecvStruct;
begin

  CriticalSection.Enter;
  LspConnection := FindLspConnectionBySockNum(inStruct.SockNum);
  OutStruct.SockNum := inStruct.SockNum;
  
  if LspConnection = nil then
    begin
      OutStruct := inStruct;
      exit;
    end;
  LspConnection.AddToRawLog(PCK_GS_ToClient, inStruct.CurrentBuff, inStruct.CurrentSize);
  TmpInStruct := inStruct;
  LspConnection.EncDec.xorS.PreDecrypt(TmpInStruct.CurrentBuff, TmpInStruct.CurrentSize);

//  ResultLen := 0;
//  FillChar(ResultBuff,$ffff,#0);
  //Запихиваем все поступившие данные во временный буффер (хранит необработанные данные)
  Move(TmpInStruct.CurrentBuff[0], LspConnection.tempbufferRecv[LspConnection.TempBufferRecvLen], TmpInStruct.CurrentSize);
  inc(LspConnection.TempBufferRecvLen, TmpInStruct.CurrentSize);

  //получаем длинну пакета хранящегося в временном буфере
  Move(LspConnection.TempBufferRecv[0], PcktLen, 2);
  if PcktLen=29754 then PcktLen:=267;
  //пока у нас хватает данных в буффере чтобы получить пакет полностью - обрабатываем пакет
  while (LspConnection.TempBufferRecvLen >= PcktLen) and (PcktLen >= 2) and (LspConnection.TempBufferRecvLen >= 2) do
  begin
    //Засовывем данные с временного буффера в структуру идущую на обработку 
    Move(LspConnection.TempBufferRecv[0], tmppack.PacketAsCharArray[0], PcktLen);
    //Сдвигаем буффер и Уменьшаем счетчик длинны временого буфера
    move(LspConnection.TempBufferRecv[PcktLen], LspConnection.TempBufferRecv[0], LspConnection.TempBufferRecvLen);
    dec(LspConnection.TempBufferRecvLen, PcktLen);
    if PcktLen=29754 then PcktLen:=267;
    //обрабатываем пакет
    LspConnection.EncDec.DecodePacket(tmppack, PCK_GS_ToClient);
    if tmppack.Size > 2 then
    begin
      LspConnection.EncDec.EncodePacket(tmppack, PCK_GS_ToClient);
      //Перемещаем обработаное во временный результирующий буффер
      Move(tmppack.PacketAsCharArray[0],  outStruct.CurrentBuff[outStruct.CurrentSize], tmppack.Size);
      inc(outStruct.CurrentSize, tmppack.Size);
      outStruct.exists := true;
      //Move(tmppack.PacketAsCharArray[0],  ResultBuff[ResultLen], tmppack.Size);
      //увеличиваем длиннну временного результирующего буффера
    end
    else
      beep(1000,20);

    if LspConnection.TempBufferRecvLen > 2 then
      //получаем длинну пакета хранящегося в временном буфере
      Move(LspConnection.TempBufferRecv[0], PcktLen, 2)
    else
      PcktLen := 0;
  end;

  //в итоге у тас получается результирующий буффер
  CriticalSection.Leave;
end;

procedure TdmData.LSPControlSend(const inStruct: TSendRecvStruct;
  var OutStruct: TSendRecvStruct);
var
  LspConnection : TlspConnection;
  PcktLen : Word;
  tmppack:tpacket;
  TmpInStruct : TSendRecvStruct;
begin

  CriticalSection.Enter;
  LspConnection := FindLspConnectionBySockNum(inStruct.SockNum);
  OutStruct.SockNum := inStruct.SockNum;
  if LspConnection = nil then
    begin
      OutStruct := inStruct;    
      exit;
    end;
    
  LspConnection.AddToRawLog(PCK_GS_ToServer, inStruct.CurrentBuff, inStruct.CurrentSize);
  TmpInStruct := inStruct;
  LspConnection.EncDec.xorS.PreDecrypt(TmpInStruct.CurrentBuff, TmpInStruct.CurrentSize);

  //Запихиваем все поступившие данные во временный буффер (хранит необработанные данные)
  Move(TmpInStruct.CurrentBuff[0],LspConnection.tempbufferSend[LspConnection.TempBufferSendLen], TmpInStruct.CurrentSize);
  inc(LspConnection.TempBufferSendLen, TmpInStruct.CurrentSize);

  //получаем длинну пакета хранящегося в временном буфере
  Move(LspConnection.TempBufferSend[0], PcktLen, 2);

  //пока у нас хватает данных в буффере чтобы получить пакет полностью - обрабатываем  попакетно
  while (LspConnection.TempBufferSendLen >= PcktLen) and (PcktLen >= 2) and (LspConnection.TempBufferSendLen >= 2) do
  begin
    //Засовывем данные с временного буффера в структуру идущую на обработку 
    Move(LspConnection.TempBufferSend[0], tmppack.PacketAsCharArray[0], PcktLen);

    //Сдвигаем и Уменьшаем счетчик длинны временого буфера
    move(LspConnection.TempBufferSend[PcktLen], LspConnection.TempBufferSend[0], LspConnection.TempBufferSendLen);
    dec(LspConnection.TempBufferSendLen, PcktLen);

    //обрабатываем пакет
    LspConnection.EncDec.DecodePacket(tmppack, PCK_GS_ToServer);
    if tmppack.Size > 2 then
    begin
      LspConnection.EncDec.EncodePacket(tmppack, PCK_GS_ToServer);
      //Перемещаем обработаное во временный результирующий буффер

      Move(tmppack.PacketAsCharArray[0], OutStruct.CurrentBuff[OutStruct.CurrentSize], tmppack.Size);
      //увеличиваем длиннну временного результирующего буффера
      inc(OutStruct.CurrentSize, tmppack.Size);
      OutStruct.exists := true;
    end;
    
    if LspConnection.TempBufferSendLen > 2 then
    //получаем длинну пакета хранящегося в временном буфере
    Move(LspConnection.TempBufferSend[0], PcktLen, 2)
    else
      PcktLen := 0;
  end;

  CriticalSection.Leave;
end;


function EnumWins (Wd: HWnd; Param: LongInt): Boolean; stdcall; // Обязательно stdcall !!!
var
  wNm:Array[0..255] of Char;
  wName:String;

Begin
  If  IsWindowVisible(WD) then
    If  isWindow(WD) then
    begin
      GetWindowText(Wd, wNm, 255);
      wName := AnsiLowerCase(String(wNm));
      If (Pos('l2rus',wName)>0) then
        begin
          dmData.dumbtimer.Enabled := false;
          result := false;
          exit;
        end;
    end;
Result := true;
end;


procedure TdmData.dumbtimerTimer(Sender: TObject);
begin
EnumWindows (@EnumWins, 0);
if not dumbtimer.Enabled then
  begin
  Options.WriteInteger('General','dumb',1);
  fSettings.WriteSettings;
  end;
end;

end.
