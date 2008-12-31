unit phxPlugins;

interface

uses Windows, Coding, SysUtils, StrUtils, Classes;

var                                {version} {revision}
  version_a: array[0..3] of Byte = ( 3,4,1,      73   );
  version: Integer  absolute version_a;

type
  TEnableFunc = (efOnPacket, efOnConnect, efOnDisconnect, efOnLoad, efOnFree,
                 efOnCallMethod, efOnRefreshPrecompile);
  TEnableFuncs = set of TEnableFunc;

  TGetPluginInfo = function(const ver: Integer): PChar; stdcall;
  //TGetEnableFuncs = function: TEnableFuncs; stdcall;
  TSetStruct = function(const struct: TPluginStruct): Boolean; stdcall;
  TOnPacket = procedure(const cnt: Cardinal; const fromServer: Boolean; var packet); stdcall;
  TOnConnect = procedure(const cnt: Cardinal; const withServer: Boolean); stdcall;
  TOnDisconnect = TOnConnect;
  TOnLoad = procedure; stdcall;
  TOnFree = TOnLoad;
  TOnCallMethod = function(const MethodName: String; var Params,
                           FuncResult: Variant): Boolean; stdcall;
  TOnRefreshPrecompile = function(var funcs: TStringArray): Integer; stdcall;

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

  function ReadC(const pck: string; const index:integer):byte; stdcall;
  function ReadH(const pck: string; const index:integer):word; stdcall;
  function ReadD(const pck: string; const index:integer):integer; stdcall;
  function ReadF(const pck: string; const index:integer):double; stdcall;
  function ReadS(const pck: string; const index:integer):string; stdcall;
  function ReadCEx(const pck; const index:integer):byte; stdcall;
  function ReadHEx(const pck; const index:integer):word; stdcall;
  function ReadDEx(const pck; const index:integer):integer; stdcall;
  function ReadFEx(const pck; const index:integer):double; stdcall;
  function ReadSEx(const pck; const index:integer):string; stdcall;
  procedure WriteC(var pck: string; const v:byte;    ind:integer=-1); stdcall;
  procedure WriteH(var pck: string; const v:word;    ind:integer=-1); stdcall;
  procedure WriteD(var pck: string; const v:integer; ind:integer=-1); stdcall;
  procedure WriteF(var pck: string; const v:double;  ind:integer=-1); stdcall;
  procedure WriteS(var pck: string; const v:string;  ind:integer=-1); stdcall;
  procedure WriteCEx(var pck; const v:byte;    ind:integer=-1); stdcall;
  procedure WriteHEx(var pck; const v:word;    ind:integer=-1); stdcall;
  procedure WriteDEx(var pck; const v:integer; ind:integer=-1); stdcall;
  procedure WriteFEx(var pck; const v:double;  ind:integer=-1); stdcall;
  procedure WriteSEx(var pck; const v:string;  ind:integer=-1); stdcall;

  function CreateAndRunTimerThread(const interval, usrParam: Cardinal;
                                   const OnTimerProc: TOnTimer): Pointer; stdcall;
  procedure ChangeTimerThread(const timer: Pointer; const interval: Cardinal;
                              const usrParam: Cardinal = $ffffffff;
                              const OnTimerProc: TOnTimer = nil); stdcall;
  procedure DestroyTimerThread(var timer: Pointer); stdcall;

var
  Plugins: array of TPlugin;
  PluginStruct: TPluginStruct;

implementation

{ TPlugin }

constructor TPlugin.Create;
begin
  Loaded:=False;
  EnableFuncs:=[];
end;

destructor TPlugin.Destroy;
begin
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

  Info:=String(GetPluginInfo(version));

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
  or(not SetStruct(PluginStruct))then begin
    FreePlugin;
    Exit;
  end;

  Info:=String(GetPluginInfo(version));
  EnableFuncs:=[];

  OnPacket:=GetProcAddress(hLib,'OnPacket');
  OnConnect:=GetProcAddress(hLib,'OnConnect');
  OnDisconnect:=GetProcAddress(hLib,'OnDisconnect');
  OnLoad:=GetProcAddress(hLib,'OnLoad');
  OnFree:=GetProcAddress(hLib,'OnFree');
  OnCallMethod:=GetProcAddress(hLib,'OnCallMethod');
  OnRefreshPrecompile:=GetProcAddress(hLib,'OnRefreshPrecompile');

  if Assigned(OnPacket) then EnableFuncs:=EnableFuncs+[efOnPacket];
  if Assigned(OnConnect) then EnableFuncs:=EnableFuncs+[efOnConnect];
  if Assigned(OnDisconnect) then EnableFuncs:=EnableFuncs+[efOnDisconnect];
  if Assigned(OnLoad) then begin
    EnableFuncs:=EnableFuncs+[efOnLoad];
    OnLoad;
  end;
  if Assigned(OnFree) then EnableFuncs:=EnableFuncs+[efOnFree];
  if Assigned(OnCallMethod) then EnableFuncs:=EnableFuncs+[efOnCallMethod];
  if Assigned(OnRefreshPrecompile) then EnableFuncs:=EnableFuncs+[efOnRefreshPrecompile];

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

////////////////////////////////////////////////////////////////////////////////

function ReadC(const pck: string; const index:integer):byte; stdcall;
begin
  Result:=0;
  if index>Length(pck) then Exit;
  Result:=Byte(pck[index]);
end;

function ReadH(const pck: string; const index:integer):word; stdcall;
begin
  Result:=0;
  if index+1>Length(pck) then Exit;
  Move(pck[index],Result,2);
end;

function ReadD(const pck: string; const index:integer):integer; stdcall;
begin
  Result:=0;
  if index+3>Length(pck) then Exit;
  Move(pck[index],Result,4);
end;

function ReadF(const pck: string; const index:integer):double; stdcall;
begin
  Result:=0;
  if index+7>Length(pck) then Exit;
  Move(pck[index],Result,8);
end;

function ReadS(const pck: string; const index:integer):string; stdcall;
var
  temp: WideString;
  d: Integer;
begin
  d:=PosEx(#0#0,pck,index)-index;
  if (d mod 2)=1 then Inc(d);
  SetLength(temp,d div 2);
  if d>=2 then Move(pck[index],temp[1],d); //else d:=0;
  Result:=temp;//WideStringToString(temp,1251);
end;

function ReadCEx(const pck; const index:integer):byte; stdcall;
begin
  Result:=0;
  if index>=PWord(@pck)^ then Exit;
  Result:=PByteArray(@pck)^[index];
end;

function ReadHEx(const pck; const index:integer):word; stdcall;
begin
  Result:=0;
  if index+1>=PWord(@pck)^ then Exit;
  Move(PByteArray(@pck)^[index],Result,2);
end;

function ReadDEx(const pck; const index:integer):integer; stdcall;
begin
  Result:=0;
  if index+3>=PWord(@pck)^ then Exit;
  Move(PByteArray(@pck)^[index],Result,4);
end;

function ReadFEx(const pck; const index:integer):double; stdcall;
begin
  Result:=0;
  if index+7>=PWord(@pck)^ then Exit;
  Move(PByteArray(@pck)^[index],Result,8);
end;

function ReadSEx(const pck; const index:integer):string; stdcall;
var
  temp: WideString;
  i,d: Integer;
begin
  //d:=PosEx(#0#0,pck,index)-index;
  i:=index;
  while not((PByteArray(@pck)^[i]=0)and(PByteArray(@pck)^[i+1]=0))
    and(PWord(@pck)^>i+1)do Inc(i,2);
  d:=i-index;
  //if (d mod 2)=1 then Inc(d);
  SetLength(temp,d div 2);
  if d>=2 then Move(PByteArray(@pck)^[index],temp[1],d);// else d:=0;
  Result:=temp;//WideStringToString(temp,1251);
end;

procedure WriteC(var pck: string; const v:byte;    ind:integer=-1); stdcall;
const
  dt_size = 1;
begin
  if ind=-1 then ind:=Length(pck)+1;
  if ind+dt_size-1>Length(pck) then SetLength(pck,ind+dt_size-1);
  Move(v,pck[ind],dt_size);
end;

procedure WriteH(var pck: string; const v:word;    ind:integer=-1); stdcall;
const
  dt_size = 2;
begin
  if ind=-1 then ind:=Length(pck)+1;
  if ind+dt_size-1>Length(pck) then SetLength(pck,ind+dt_size-1);
  Move(v,pck[ind],dt_size);
end;

procedure WriteD(var pck: string; const v:integer; ind:integer=-1); stdcall;
const
  dt_size = 4;
begin
  if ind=-1 then ind:=Length(pck)+1;
  if ind+dt_size-1>Length(pck) then SetLength(pck,ind+dt_size-1);
  Move(v,pck[ind],dt_size);
end;

procedure WriteF(var pck: string; const v:double;  ind:integer=-1); stdcall;
const
  dt_size = 8;
begin
  if ind=-1 then ind:=Length(pck)+1;
  if ind+dt_size-1>Length(pck) then SetLength(pck,ind+dt_size-1);
  Move(v,pck[ind],dt_size);
end;

procedure WriteS(var pck: string; const v:string;  ind:integer=-1); stdcall;
var
  temp: WideString;
  dt_size: Word;
begin
  dt_size:=Length(v)*2+2;
  temp:=v+#0;
  if ind=-1 then ind:=Length(pck)+1;
  if ind+dt_size-1>Length(pck) then SetLength(pck,ind+dt_size-1);
  Move(temp[1],pck[ind],dt_size);
end;

procedure WriteCEx(var pck; const v:byte;    ind:integer=-1); stdcall;
const
  dt_size = 1;
begin
  if ind=-1 then ind:=PWord(@pck)^;
  if ind+dt_size>PWord(@pck)^ then PWord(@pck)^:=ind+dt_size;
  Move(v,PByteArray(@pck)^[ind],dt_size);
end;

procedure WriteHEx(var pck; const v:word;    ind:integer=-1); stdcall;
const
  dt_size = 2;
begin
  if ind=-1 then ind:=PWord(@pck)^;
  if ind+dt_size>PWord(@pck)^ then PWord(@pck)^:=ind+dt_size;
  Move(v,PByteArray(@pck)^[ind],dt_size);
end;

procedure WriteDEx(var pck; const v:integer; ind:integer=-1); stdcall;
const
  dt_size = 4;
begin
  if ind=-1 then ind:=PWord(@pck)^;
  if ind+dt_size>PWord(@pck)^ then PWord(@pck)^:=ind+dt_size;
  Move(v,PByteArray(@pck)^[ind],dt_size);
end;

procedure WriteFEx(var pck; const v:double;  ind:integer=-1); stdcall;
const
  dt_size = 8;
begin
  if ind=-1 then ind:=PWord(@pck)^;
  if ind+dt_size>PWord(@pck)^ then PWord(@pck)^:=ind+dt_size;
  Move(v,PByteArray(@pck)^[ind],dt_size);
end;

procedure WriteSEx(var pck; const v:string;  ind:integer=-1); stdcall;
var
  temp: WideString;
  dt_size: Word;
begin
  dt_size:=Length(v)*2+2;
  temp:=v+#0;
  if ind=-1 then ind:=PWord(@pck)^;
  if ind+dt_size>PWord(@pck)^ then PWord(@pck)^:=ind+dt_size;
  Move(temp[1],PByteArray(@pck)^[ind],dt_size);
end;

function CreateAndRunTimerThread(const interval, usrParam: Cardinal;
                                 const OnTimerProc: TOnTimer): Pointer; stdcall;
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
end;

procedure ChangeTimerThread(const timer: Pointer; const interval: Cardinal;
                            const usrParam: Cardinal = $ffffffff;
                            const OnTimerProc: TOnTimer = nil); stdcall;
begin
  with TPlugThread(timer) do begin
    TimerInterval:=interval;
    if @OnTimerProc<>nil then
      OnTimer:=OnTimerProc;
    if usrParam<>$ffffffff then
      UserParam:=usrParam;
  end;
end;

procedure DestroyTimerThread(var timer: Pointer); stdcall;
begin
  FreeAndNil(TPlugThread(timer));
end;

initialization
  PluginStruct.ReadC:=ReadC;
  PluginStruct.ReadH:=ReadH;
  PluginStruct.ReadD:=ReadD;
  PluginStruct.ReadF:=ReadF;
  PluginStruct.ReadS:=ReadS;
  PluginStruct.ReadCEx:=ReadCEx;
  PluginStruct.ReadHEx:=ReadHEx;
  PluginStruct.ReadDEx:=ReadDEx;
  PluginStruct.ReadFEx:=ReadFEx;
  PluginStruct.ReadSEx:=ReadSEx;
  PluginStruct.WriteC:=WriteC;
  PluginStruct.WriteH:=WriteH;
  PluginStruct.WriteD:=WriteD;
  PluginStruct.WriteF:=WriteF;
  PluginStruct.WriteS:=WriteS;
  PluginStruct.WriteCEx:=WriteCEx;
  PluginStruct.WriteHEx:=WriteHEx;
  PluginStruct.WriteDEx:=WriteDEx;
  PluginStruct.WriteFEx:=WriteFEx;
  PluginStruct.WriteSEx:=WriteSEx;
  PluginStruct.CreateAndRunTimerThread:=CreateAndRunTimerThread;
  PluginStruct.ChangeTimerThread:=ChangeTimerThread;
  PluginStruct.DestroyTimerThread:=DestroyTimerThread;

end.
