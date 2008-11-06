unit Coding;

interface

uses classes;

type
  PCodingClass =^TCodingClass;
  TCodingClass = class(TObject)
  public
    GKeyS,GKeyR:array[0..15] of Byte;
    procedure InitKey(const XorKey; Interlude: Boolean = False); Virtual; Abstract;
    procedure DecryptGP(var Data; const Size: Word); Virtual; Abstract;
    procedure EncryptGP(var Data; const Size: Word); Virtual; Abstract;
  end;

  PCorrectorData = ^TCorrectorData;
  TCorrectorData = packed record
    _seed : integer;  // random generator seed for mixing id tables
    _1_byte_table : string;
    _2_byte_table : string;
    _2_byte_table_size: integer;
    _id_mix : boolean;
    temp_seed : integer;
    protocol: integer;
  end;

  PThread = ^TThread;
  TThread = packed record
    STH,CTH: Cardinal;
    SSock,CSock: Integer;
    IP, SH, CH, pckCount: Integer;
    NoUsed, IsGame, Connect, InitXOR, AutoPing, UseProxy, isInterlude,
    noFreeOnClientDisconnect, noFreeOnServerDisconnect: Boolean;
    Name, temp: String;
    Port: Word;
    xorC, xorS: TCodingClass;
    Dump: TStrings;
    ScriptsEnable: array[0..63] of Boolean;
    ConnectEvent: Cardinal;
    cd: PCorrectorData;
    // резерв, при добавлении переменных перед ним
    // обязательно вычитать из массива использованный обьём памяти!
    rezerv: array[0..91] of Byte;
  end;
  PThreads = ^TThreads;
  TThreads = array[0..0] of TThread;

  TStringArray = array of string;

  TSendPacket = procedure(Size: Word; pck: string; tid: Byte; ToServer: Boolean);
  TSendPckStr = procedure(pck: string; const tid: Byte; const ToServer: Boolean);
  TSendPckData = procedure(var pck; const tid: Byte; const ToServer: Boolean); stdcall;
  TDataPckToStrPck = function(var pck): string; stdcall;
  THexToString = function(Hex:String):String;
  TStringToHex = function(str1,Separator:String):String;
  TReadC = function(const pck: string; const index:integer):byte; stdcall;
  TReadH = function(const pck: string; const index:integer):word; stdcall;
  TReadD = function(const pck: string; const index:integer):integer; stdcall;
  TReadF = function(const pck: string; const index:integer):double; stdcall;
  TReadS = function(const pck: string; const index:integer):string; stdcall;
  TReadCEx = function(const pck; const index:integer):byte; stdcall;
  TReadHEx = function(const pck; const index:integer):word; stdcall;
  TReadDEx = function(const pck; const index:integer):integer; stdcall;
  TReadFEx = function(const pck; const index:integer):double; stdcall;
  TReadSEx = function(const pck; const index:integer):string; stdcall;
  TWriteC = procedure(var pck: string; const v:byte;    ind:integer=-1); stdcall;
  TWriteH = procedure(var pck: string; const v:word;    ind:integer=-1); stdcall;
  TWriteD = procedure(var pck: string; const v:integer; ind:integer=-1); stdcall;
  TWriteF = procedure(var pck: string; const v:double;  ind:integer=-1); stdcall;
  TWriteS = procedure(var pck: string; const v:string;  ind:integer=-1); stdcall;
  TWriteCEx = procedure(var pck; const v:byte;    ind:integer=-1); stdcall;
  TWriteHEx = procedure(var pck; const v:word;    ind:integer=-1); stdcall;
  TWriteDEx = procedure(var pck; const v:integer; ind:integer=-1); stdcall;
  TWriteFEx = procedure(var pck; const v:double;  ind:integer=-1); stdcall;
  TWriteSEx = procedure(var pck; const v:string;  ind:integer=-1); stdcall;

  TOnTimer = procedure(const param: Cardinal); stdcall;
  TCreateAndRunTimerThread = function(const interval, usrParam: Cardinal;
                                   const OnTimerProc: TOnTimer): Pointer; stdcall;
  TChangeTimerThread = procedure(const timer: Pointer; const interval: Cardinal;
                              const usrParam: Cardinal = $ffffffff;
                              const OnTimerProc: TOnTimer = nil); stdcall;
  TDestroyTimerThread = procedure(var timer: Pointer); stdcall;

  PPacket = ^TPacket;
  TPacket = record
    size: Word;
    id: Byte;
    data: array[Word] of Byte;
  end;

  PPluginStruct = ^TPluginStruct;
  TPluginStruct = packed record
    Threads: PThreads;
    ThreadsCount: Integer;
    SendPck: TSendPacket;
    SendPckStr: TSendPckStr;
    SendPckData: TSendPckData;
    DataPckToStrPck: TDataPckToStrPck;
    HexToString:THexToString;
    StringToHex:TStringToHex;
    ReadC: TReadC;
    ReadH: TReadH;
    ReadD: TReadD;
    ReadF: TReadF;
    ReadS: TReadS;
    ReadCEx: TReadCEx;
    ReadHEx: TReadHEx;
    ReadDEx: TReadDEx;
    ReadFEx: TReadFEx;
    ReadSEx: TReadSEx;
    WriteC: TWriteC;
    WriteH: TWriteH;
    WriteD: TWriteD;
    WriteF: TWriteF;
    WriteS: TWriteS;
    WriteCEx: TWriteCEx;
    WriteHEx: TWriteHEx;
    WriteDEx: TWriteDEx;
    WriteFEx: TWriteFEx;
    WriteSEx: TWriteSEx;
    CreateAndRunTimerThread: TCreateAndRunTimerThread;
    ChangeTimerThread: TChangeTimerThread;
    DestroyTimerThread: TDestroyTimerThread;
  end;

implementation
    
end.
