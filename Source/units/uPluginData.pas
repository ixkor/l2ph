unit uPluginData;

interface
uses windows, classes, SysUtils, strutils, usharedstructs;

type
  TEnableFunc = (efOnPacket, efOnConnect, efOnDisconnect, efOnLoad, efOnFree,
                 efOnCallMethod, efOnRefreshPrecompile);
  TEnableFuncs = set of TEnableFunc;

  TGetPluginInfo = function(const ver: Integer): PChar; stdcall;
  //TGetEnableFuncs = function: TEnableFuncs; stdcall;
  TSetStruct = function(const struct: PPluginStruct): Boolean; stdcall;
  TOnPacket = procedure(const cnt: Cardinal; const fromServer: Boolean; var packet : tpacket); stdcall;
  TOnConnect = procedure(const cnt: Cardinal; const withServer: Boolean); stdcall;
  TOnDisconnect = TOnConnect;
  TOnLoad = procedure; stdcall;
  TOnFree = TOnLoad;
  TOnCallMethod = function(const MethodName: String; var Params,
                           FuncResult: Variant): Boolean; stdcall;
  TOnRefreshPrecompile = procedure; stdcall;

  TConnectInfo = class (tobject)
  ConnectionId: integer;
  ConnectionName: String;
  end;

  TPluginStructClass = class (TPluginStruct)
    private
      conNum:integer;
      function getconnectionscount:integer;
    public
    function ReadC(const pck: string; const index:integer):byte; override;
    function ReadH(const pck: string; const index:integer):word; override;
    function ReadD(const pck: string; const index:integer):integer; override;
    function ReadF(const pck: string; const index:integer):double; override;
    function ReadS(const pck: string; const index:integer):string; override;
    function ReadCEx(const pck; const index:integer):byte; override;
    function ReadHEx(const pck; const index:integer):word; override;
    function ReadDEx(const pck; const index:integer):integer; override;
    function ReadFEx(const pck; const index:integer):double; override;
    function ReadSEx(const pck; const index:integer):string; override;
    procedure WriteC(var pck: string; const v:byte;    ind:integer=-1); override;
    procedure WriteH(var pck: string; const v:word;    ind:integer=-1); override;
    procedure WriteD(var pck: string; const v:integer; ind:integer=-1); override;
    procedure WriteF(var pck: string; const v:double;  ind:integer=-1); override;
    procedure WriteS(var pck: string; const v:string;  ind:integer=-1); override;
    procedure WriteCEx(var pck; const v:byte;    ind:integer=-1); override;
    procedure WriteHEx(var pck; const v:word;    ind:integer=-1); override;
    procedure WriteDEx(var pck; const v:integer; ind:integer=-1); override;
    procedure WriteFEx(var pck; const v:double;  ind:integer=-1); override;
    procedure WriteSEx(var pck; const v:string;  ind:integer=-1); override;

    function CreateAndRunTimerThread(const interval, usrParam: Cardinal;
                                     const OnTimerProc: TOnTimer): Pointer; override;
    procedure ChangeTimerThread(const timer: Pointer; const interval: Cardinal;
                                const usrParam: Cardinal = $ffffffff;
                                const OnTimerProc: TOnTimer = nil); override;
    procedure DestroyTimerThread(var timer: Pointer); override;
    function StringToHex(str1,Separator:String):String; override;
    function HexToString(Hex:String):String; override;
    function DataPckToStrPck(var pck): string; override;
    procedure SendPacketData(var pck; const tid: integer; const ToServer: Boolean); override;
    procedure SendPacketStr(pck: string; const tid: integer; const ToServer: Boolean); override;
    procedure SendPacket(Size: Word; pck: string; tid: integer; ToServer: Boolean); override;


    function getConnectionName(id : integer):string; override;
    function getConnectioidByName(name : string):integer; override;

    Function GoFirstConnection:boolean; override;
    Function GoNextConnection:boolean; override;
    procedure ShowUserForm(ActivateOnly:boolean); override;
    Procedure HideUserForm; override;
    Constructor create;
    Destructor Destroy;override;
  end;

  TPlugin = class(TObject)
  public
    FileName, Info: string;
    Loaded: Boolean;
    hLib: Cardinal;
    EnableFuncs: TEnableFuncs;
    GetPluginInfo: TGetPluginInfo;
    //GetEnableFuncs: TGetEnableFuncs;
    SetStruct: TSetStruct;
    OnPacket: TOnPacket;
    OnConnect: TOnConnect;
    OnDisconnect: TOnDisconnect;
    OnLoad: TOnLoad;
    OnFree: TOnFree;
    OnCallMethod: TOnCallMethod;
    OnRefreshPrecompile: TOnRefreshPrecompile;
    constructor Create;
    destructor Destroy; override;
    function LoadPlugin: Boolean;
    function LoadInfo: Boolean;
    procedure FreePlugin;
  end;

  TPlugThread = class(TThread)
  public
    OnTimer: TOnTimer;
    TimerInterval, UserParam: Cardinal;
  protected
    procedure Execute; override;
  end;
  
var
  PluginStruct: TPluginStruct;
  Plugins : tlist;
  
implementation
uses uscripts, uglobalFuncs, uMain, uUserForm, udata, usocketengine, uencdec, Controls;
{ TPluginDataClass }

procedure TPluginStructClass.ChangeTimerThread(const timer: Pointer;
  const interval, usrParam: Cardinal; const OnTimerProc: TOnTimer);
begin
  with TPlugThread(timer) do begin
    TimerInterval:=interval;
    if @OnTimerProc<>nil then
      OnTimer:=OnTimerProc;
    if usrParam<>$ffffffff then
      UserParam:=usrParam;
  end;
  inherited;
end;

constructor TPluginStructClass.create;
begin
  inherited;
  conNum := 0;
  userFormHandle := UserForm.Handle;
  UserFuncs := TStringList.Create;
end;

function TPluginStructClass.CreateAndRunTimerThread(const interval,
  usrParam: Cardinal; const OnTimerProc: TOnTimer): Pointer;
begin
  Result:=TPlugThread.Create(True);
  with TPlugThread(Result) do begin
    FreeOnTerminate:=True;
    Priority:=tpLower;
    TimerInterval:=interval;
    OnTimer:=OnTimerProc;
    UserParam:=usrParam;
    Resume;
  end;
  inherited;
end;

function TPluginStructClass.DataPckToStrPck(var pck): string;
var
  tpck: packed record
    size: Word;
    id: Byte;
  end absolute pck;
begin
  SetLength(Result,tpck.size-2);
  Move(tpck.id,Result[1],Length(Result));
  inherited;
end;

destructor TPluginStructClass.Destroy;
begin
  UserFuncs.Destroy;
  inherited;
end;

procedure TPluginStructClass.DestroyTimerThread(var timer: Pointer);
begin
  FreeAndNil(TPlugThread(timer));
  inherited;
end;

function TPluginStructClass.getConnectioidByName(name : string):integer;
begin
  result := dmData.ConnectIdByName(name);
  inherited;
end;

function TPluginStructClass.getConnectionName(id: integer): string;
begin
  result := dmData.ConnectNameById(id);
  inherited;
end;

function SymbolEntersCount(s: string): string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to Length(s) do
    if not(s[i] in [' ',#10,#13]) then
      Result:=Result+s[i];
end;


function TPluginStructClass.getconnectionscount: integer;
var
i:integer;
begin
  result := 0;
  i := 0;
  while i < LSPConnections.Count do
  begin
    if TlspConnection(LSPConnections.Items[i]).active then inc(result);
    inc(i);
  end;

  i := 0;
  while i < sockEngine.tunels.Count do
  begin
    if Ttunel(sockEngine.tunels.Items[i]).active then inc(result);
    inc(i);
  end;
  
end;

function TPluginStructClass.GoFirstConnection: boolean;
var
  i : integer;
begin
  if getconnectionscount = 0 then
    begin
      Result := false;
      Exit;
    end;
  Result := true;
  conNum := 0;
  i := 0;
  while i < LSPConnections.Count do
  begin
    if TlspConnection(LSPConnections.Items[i]).active then
      begin
        ConnectInfo.ConnectID := TlspConnection(LSPConnections.Items[i]).SocketNum;
        ConnectInfo.ConnectName := TlspConnection(LSPConnections.Items[i]).EncDec.CharName;
        exit;
      end;
    inc(i);
  end;


  i := 0;
  while i < sockEngine.tunels.Count do
  begin
    if Ttunel(sockEngine.tunels.Items[i]).active then
      begin
        ConnectInfo.ConnectID := Ttunel(sockEngine.tunels.Items[i]).serversocket;
        ConnectInfo.ConnectName := Ttunel(sockEngine.tunels.Items[i]).EncDec.CharName;
        exit;
      end;
    inc(i);
  end;
  inherited;
end;

function TPluginStructClass.GoNextConnection: boolean;
var
  i : integer;
  index : integer;
begin
  Inc(conNum);
  if getconnectionscount <= conNum then
    begin
      Result := false;
      Exit;
    end;
  Result := true;
  index := 0;
  i := 0;
  while i < LSPConnections.Count do
  begin
    if (index = conNum) and TlspConnection(LSPConnections.Items[i]).active then
      begin
        ConnectInfo.ConnectID := TlspConnection(LSPConnections.Items[i]).SocketNum;
        ConnectInfo.ConnectName := TlspConnection(LSPConnections.Items[i]).EncDec.CharName;
        exit;
      end;
    if TlspConnection(LSPConnections.Items[i]).active then inc(index);
    inc(i);
  end;


  i := 0;
  while i < sockEngine.tunels.Count do
  begin
    if (index = conNum) and Ttunel(sockEngine.tunels.Items[i]).active then
      begin
        ConnectInfo.ConnectID := Ttunel(sockEngine.tunels.Items[i]).serversocket;
        ConnectInfo.ConnectName := Ttunel(sockEngine.tunels.Items[i]).EncDec.CharName;
        exit;
      end;
    if Ttunel(sockEngine.tunels.Items[i]).active then inc(index);
    inc(i);
  end;
  inherited;
end;

function TPluginStructClass.HexToString(Hex: String): String;
var
  buf:String;
  bt:Byte;
  i:Integer;
begin
  buf:='';
  Hex := SymbolEntersCount(UpperCase(Hex));
  for i:=0 to (Length(Hex) div 2)-1 do begin
    bt:=0;
    if (Byte(hex[i*2+1])>$2F)and(Byte(hex[i*2+1])<$3A)then bt:=Byte(hex[i*2+1])-$30;
    if (Byte(hex[i*2+1])>$40)and(Byte(hex[i*2+1])<$47)then bt:=Byte(hex[i*2+1])-$37;
    if (Byte(hex[i*2+2])>$2F)and(Byte(hex[i*2+2])<$3A)then bt:=bt*16+Byte(hex[i*2+2])-$30;
    if (Byte(hex[i*2+2])>$40)and(Byte(hex[i*2+2])<$47)then bt:=bt*16+Byte(hex[i*2+2])-$37;
    buf:=buf+char(bt);
  end;
  Result:=buf;
  inherited;
end;

procedure TPluginStructClass.HideUserForm;
begin
  inherited;
  UserForm.Hide;
  fMain.nUserFormShow.Enabled := false;
end;

function TPluginStructClass.ReadC(const pck: string;
  const index: integer): byte;
begin
  Result:=0;
  if index>Length(pck) then Exit;
  Result:=Byte(pck[index]);
  inherited;
end;

function TPluginStructClass.ReadCEx(const pck; const index: integer): byte;
begin
  Result:=0;
  if index>=PWord(@pck)^ then Exit;
  Result:=PByteArray(@pck)^[index];
  inherited;
end;

function TPluginStructClass.ReadD(const pck: string;
  const index: integer): integer;
begin
  Result:=0;
  if index+3>Length(pck) then Exit;
  Move(pck[index],Result,4);
  inherited;
end;

function TPluginStructClass.ReadDEx(const pck;
  const index: integer): integer;
begin
  Result:=0;
  if index+3>=PWord(@pck)^ then Exit;
  Move(PByteArray(@pck)^[index],Result,4);
  inherited;
end;

function TPluginStructClass.ReadF(const pck: string;
  const index: integer): double;
begin
  Result:=0;
  if index+7>Length(pck) then Exit;
  Move(pck[index],Result,8);
  inherited;
end;

function TPluginStructClass.ReadFEx(const pck; const index: integer): double;
begin
  Result:=0;
  if index+7>=PWord(@pck)^ then Exit;
  Move(PByteArray(@pck)^[index],Result,8);
  inherited;
end;

function TPluginStructClass.ReadH(const pck: string;
  const index: integer): word;
begin
  Result:=0;
  if index+1>Length(pck) then Exit;
  Move(pck[index],Result,2);
  inherited;
end;

function TPluginStructClass.ReadHEx(const pck; const index: integer): word;
begin
  Result:=0;
  if index+1>=PWord(@pck)^ then Exit;
  Move(PByteArray(@pck)^[index],Result,2);
  inherited;
end;

function TPluginStructClass.ReadS(const pck: string;
  const index: integer): string;
var
  temp: WideString;
  d: Integer;
begin
  d:=PosEx(#0#0,pck,index)-index;
  if (d mod 2)=1 then Inc(d);
  SetLength(temp,d div 2);
  if d>=2 then Move(pck[index],temp[1],d);
  Result:=temp;
  inherited;
end;

function TPluginStructClass.ReadSEx(const pck; const index: integer): string;
var
  temp: WideString;
  i,d: Integer;
begin
  i:=index;
  while not((PByteArray(@pck)^[i]=0)and(PByteArray(@pck)^[i+1]=0))
    and(PWord(@pck)^>i+1)do Inc(i,2);
  d:=i-index;
  SetLength(temp,d div 2);
  if d>=2 then Move(PByteArray(@pck)^[index],temp[1],d);
  Result:=temp;
  inherited;
end;

procedure TPluginStructClass.SendPacket(Size: Word; pck: string;
  tid: integer; ToServer: Boolean);
var
  packet: TPacket;
begin
  FillChar(packet.PacketAsCharArray,$ffff,#0);
  packet.Size := size;
  Move(pck[1],packet.data[0],length(pck));
  dmData.SendPacket(packet, tid, False);
  inherited;
end;

procedure TPluginStructClass.SendPacketData(var pck; const tid: integer;
  const ToServer: Boolean);
var
  tpck: packed record
    size: Word;
    id: Byte;
  end absolute pck;
  spck: string;
begin
  SetLength(spck,tpck.size-2);
  Move(tpck.id,spck[1],Length(spck));
  SendPacket(tpck.size,spck,tid,ToServer);
  inherited;
end;

procedure TPluginStructClass.SendPacketStr(pck: string; const tid: integer;
  const ToServer: Boolean);
begin
  SendPacket(Length(pck)+2,pck,tid,ToServer);
  inherited;
end;

procedure TPluginStructClass.ShowUserForm(ActivateOnly: boolean);
begin
  inherited;
  if not ActivateOnly then
    UserForm.show;
  fMain.nUserFormShow.Enabled := true;
end;

function TPluginStructClass.StringToHex(str1, Separator: String): String;
var
  buf:String;
  i:Integer;
begin
  buf:='';
  for i:=1 to Length(str1) do begin
    buf:=buf+IntToHex(Byte(str1[i]),2)+Separator;
  end;
  Result:=buf;
  inherited;
end;

procedure TPluginStructClass.WriteC(var pck: string; const v: byte;
  ind: integer);
const
  dt_size = 1;
begin
  if ind=-1 then ind:=Length(pck)+1;
  if ind+dt_size-1>Length(pck) then SetLength(pck,ind+dt_size-1);
  Move(v,pck[ind],dt_size);
  inherited;
end;

procedure TPluginStructClass.WriteCEx(var pck; const v: byte; ind: integer);
const
  dt_size = 1;
begin
  if ind=-1 then ind:=PWord(@pck)^;
  if ind+dt_size>PWord(@pck)^ then PWord(@pck)^:=ind+dt_size;
  Move(v,PByteArray(@pck)^[ind],dt_size);
  inherited;
end;

procedure TPluginStructClass.WriteD(var pck: string; const v: integer;
  ind: integer);
const
  dt_size = 4;
begin
  if ind=-1 then ind:=Length(pck)+1;
  if ind+dt_size-1>Length(pck) then SetLength(pck,ind+dt_size-1);
  Move(v,pck[ind],dt_size);
  inherited;
end;

procedure TPluginStructClass.WriteDEx(var pck; const v: integer;
  ind: integer);
const
  dt_size = 4;
begin
  if ind=-1 then ind:=PWord(@pck)^;
  if ind+dt_size>PWord(@pck)^ then PWord(@pck)^:=ind+dt_size;
  Move(v,PByteArray(@pck)^[ind],dt_size);
  inherited;
end;

procedure TPluginStructClass.WriteF(var pck: string; const v: double;
  ind: integer);
const
  dt_size = 8;
begin
  if ind=-1 then ind:=Length(pck)+1;
  if ind+dt_size-1>Length(pck) then SetLength(pck,ind+dt_size-1);
  Move(v,pck[ind],dt_size);
  inherited;
end;

procedure TPluginStructClass.WriteFEx(var pck; const v: double;
  ind: integer);
const
  dt_size = 8;
begin
  if ind=-1 then ind:=PWord(@pck)^;
  if ind+dt_size>PWord(@pck)^ then PWord(@pck)^:=ind+dt_size;
  Move(v,PByteArray(@pck)^[ind],dt_size);
  inherited;
end;

procedure TPluginStructClass.WriteH(var pck: string; const v: word;
  ind: integer);
const
  dt_size = 2;
begin
  if ind=-1 then ind:=Length(pck)+1;
  if ind+dt_size-1>Length(pck) then SetLength(pck,ind+dt_size-1);
  Move(v,pck[ind],dt_size);
  inherited;
end;

procedure TPluginStructClass.WriteHEx(var pck; const v: word; ind: integer);
const
  dt_size = 2;
begin
  if ind=-1 then ind:=PWord(@pck)^;
  if ind+dt_size>PWord(@pck)^ then PWord(@pck)^:=ind+dt_size;
  Move(v,PByteArray(@pck)^[ind],dt_size);
  inherited;
end;

procedure TPluginStructClass.WriteS(var pck: string; const v: string;
  ind: integer);
var
  temp: WideString;
  dt_size: Word;
begin
  dt_size:=Length(v)*2+2;
  temp:=v+#0;
  if ind=-1 then ind:=Length(pck)+1;
  if ind+dt_size-1>Length(pck) then SetLength(pck,ind+dt_size-1);
  Move(temp[1],pck[ind],dt_size);
  inherited;
end;
procedure TPluginStructClass.WriteSEx(var pck; const v: string;
  ind: integer);
var
  temp: WideString;
  dt_size: Word;
begin
  dt_size:=Length(v)*2+2;
  temp:=v+#0;
  if ind=-1 then ind:=PWord(@pck)^;
  if ind+dt_size>PWord(@pck)^ then PWord(@pck)^:=ind+dt_size;
  Move(temp[1],PByteArray(@pck)^[ind],dt_size);
  inherited;
end;



{ TPlugin }



constructor TPlugin.Create;
begin
  plugins.Add(self);
  Loaded:=False;
  EnableFuncs:=[];
end;

destructor TPlugin.Destroy;
var
i : integer;
begin
i := 0;
  while i < Plugins.Count do
    begin
      if TPlugin(Plugins.Items[i]) = self then
        begin
        Plugins.Delete(i);
        break;
        end;
        
      inc(i);
    end;

    
  if Loaded then begin
    if Assigned(OnFree) then OnFree;
    FreeLibrary(hLib);
  end;
  inherited;
end;

procedure TPlugin.FreePlugin;
begin
  if Loaded then begin
    if Assigned(OnFree) then OnFree;
    FreeLibrary(hLib);
  end;
  EnableFuncs:=[];
  Loaded:=False;
end;

function TPlugin.LoadInfo: Boolean;
begin
  Result:=False;
  hLib:=LoadLibrary(PChar(FileName));
  if hLib=0 then exit;

  GetPluginInfo:=GetProcAddress(hLib,'GetPluginInfo');

  if(not Assigned(GetPluginInfo))then Exit;

  Info:=String(GetPluginInfo(l2pxversion));

  OnPacket:=GetProcAddress(hLib,'OnPacket');
  OnConnect:=GetProcAddress(hLib,'OnConnect');
  OnDisconnect:=GetProcAddress(hLib,'OnDisconnect');
  OnLoad:=GetProcAddress(hLib,'OnLoad');
  OnFree:=GetProcAddress(hLib,'OnFree');
  OnCallMethod:=GetProcAddress(hLib,'OnCallMethod');
  OnRefreshPrecompile:=GetProcAddress(hLib,'OnRefreshPrecompile');

  EnableFuncs:=[];
  if Assigned(OnPacket) then EnableFuncs:=EnableFuncs+[efOnPacket];
  if Assigned(OnConnect) then EnableFuncs:=EnableFuncs+[efOnConnect];
  if Assigned(OnDisconnect) then EnableFuncs:=EnableFuncs+[efOnDisconnect];
  if Assigned(OnLoad) then EnableFuncs:=EnableFuncs+[efOnLoad];
  if Assigned(OnFree) then EnableFuncs:=EnableFuncs+[efOnFree];
  if Assigned(OnCallMethod) then EnableFuncs:=EnableFuncs+[efOnCallMethod];
  if Assigned(OnRefreshPrecompile) then EnableFuncs:=EnableFuncs+[efOnRefreshPrecompile];

  FreeLibrary(hLib);

  Result:=True;
end;

function TPlugin.LoadPlugin: Boolean;
begin
  hLib:=LoadLibrary(PChar(FileName));
  Loaded:=hLib<>0;
  Result:=False;
 try
  if not Loaded then exit;

  GetPluginInfo:=GetProcAddress(hLib,'GetPluginInfo');
  SetStruct:=GetProcAddress(hLib,'SetStruct');

  if(not Assigned(GetPluginInfo))
  or(not Assigned(SetStruct))
  or(not SetStruct(@PluginStruct))then begin
    FreePlugin;
    Exit;
  end;

  Info:=String(GetPluginInfo(l2pxversion));
  EnableFuncs:=[];

  OnPacket:=GetProcAddress(hLib,'OnPacket');
  OnConnect:=GetProcAddress(hLib,'OnConnect');
  OnDisconnect:=GetProcAddress(hLib,'OnDisconnect');
  OnLoad:=GetProcAddress(hLib,'OnLoad');
  OnFree:=GetProcAddress(hLib,'OnFree');
  OnCallMethod:=GetProcAddress(hLib,'OnCallMethod');
  OnRefreshPrecompile := GetProcAddress(hLib,'OnRefreshPrecompile');

  if Assigned(OnPacket) then EnableFuncs:=EnableFuncs+[efOnPacket];
  if Assigned(OnConnect) then EnableFuncs:=EnableFuncs+[efOnConnect];
  if Assigned(OnDisconnect) then EnableFuncs:=EnableFuncs+[efOnDisconnect];
  if Assigned(OnLoad) then begin
    EnableFuncs:=EnableFuncs+[efOnLoad];
    OnLoad;
  end;
  if Assigned(OnFree) then EnableFuncs:=EnableFuncs+[efOnFree];
  if Assigned(OnCallMethod) then EnableFuncs:=EnableFuncs+[efOnCallMethod];
  if Assigned(OnRefreshPrecompile) then EnableFuncs := EnableFuncs+[efOnRefreshPrecompile];

  Result:=True;
 finally
  Loaded:=Result;
 end;
end;

{ TPlugThread }

procedure TPlugThread.Execute;
begin
  repeat
    Sleep(TimerInterval);
    OnTimer(UserParam);
  until TimerInterval=0;
end;
end.
