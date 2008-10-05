unit phxPlugins;

interface

uses Windows, Classes, Coding;

const
  version = $03040000;

type

  TGetPluginInfo = function(const ver: Integer): PChar; stdcall;
  //TGetEnableFuncs = function: TEnableFuncs; stdcall;
  TSetStruct = function(const struct: TPluginStruct): Boolean; stdcall;
  TOnPacket = procedure(const cnt: Cardinal; const fromServer: Boolean; var packet); stdcall;
  TOnConnect = procedure(const cnt: Cardinal); stdcall;
  TOnDisconnect = TOnConnect;
  TOnLoad = procedure; stdcall;
  TOnFree = TOnLoad;

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
    constructor Create;
    destructor Destroy; override;
    function LoadPlugin: Boolean;
    function LoadInfo: Boolean;
    procedure FreePlugin;
  end;

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

  EnableFuncs:=[];
  if Assigned(OnPacket) then EnableFuncs:=EnableFuncs+[efOnPacket];
  if Assigned(OnConnect) then EnableFuncs:=EnableFuncs+[efOnConnect];
  if Assigned(OnDisconnect) then EnableFuncs:=EnableFuncs+[efOnDisconnect];
  if Assigned(OnLoad) then EnableFuncs:=EnableFuncs+[efOnLoad];
  if Assigned(OnFree) then EnableFuncs:=EnableFuncs+[efOnFree];

  FreeLibrary(hLib);

  Result:=True;
end;

function TPlugin.LoadPlugin: Boolean;
begin
  hLib:=LoadLibrary(PChar(FileName));
  Loaded:=hLib<>0;
  Result:=False;
  if not Loaded then exit;

  //GetEnableFuncs:=GetProcAddress(hLib,'GetEnableFuncs');
  GetPluginInfo:=GetProcAddress(hLib,'GetPluginInfo');
  SetStruct:=GetProcAddress(hLib,'SetStruct');

  if(not Assigned(GetPluginInfo))
  //or(not Assigned(GetEnableFuncs))
  or(not Assigned(SetStruct))
  or(not SetStruct(PluginStruct))then Exit;

  //EnableFuncs:=GetEnableFuncs;
  Info:=String(GetPluginInfo(version));
  EnableFuncs:=[];

  //if efOnPacket in EnableFuncs then
    OnPacket:=GetProcAddress(hLib,'OnPacket');
  //if efOnConnect in EnableFuncs then
    OnConnect:=GetProcAddress(hLib,'OnConnect');
  //if efOnDisconnect in EnableFuncs then
    OnDisconnect:=GetProcAddress(hLib,'OnDisconnect');
  //if efOnLoad in EnableFuncs then
    OnLoad:=GetProcAddress(hLib,'OnLoad');
  //if efOnFree in EnableFuncs then
    OnFree:=GetProcAddress(hLib,'OnFree');

  if Assigned(OnPacket) then EnableFuncs:=EnableFuncs+[efOnPacket];
  if Assigned(OnConnect) then EnableFuncs:=EnableFuncs+[efOnConnect];
  if Assigned(OnDisconnect) then EnableFuncs:=EnableFuncs+[efOnDisconnect];
  if Assigned(OnLoad) then begin
    EnableFuncs:=EnableFuncs+[efOnLoad];
    OnLoad;
  end;
  if Assigned(OnFree) then EnableFuncs:=EnableFuncs+[efOnFree];

  Result:=True;
end;

end.
