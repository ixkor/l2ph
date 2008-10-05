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
    rezerv: array[0..99] of Byte;
  end;
  PThreads = ^TThreads;
  TThreads = array[0..0] of TThread;

  TSendPacket = procedure(Size: Word; pck: string; tid: Byte; ToServer: Boolean);

  TEnableFunc = (efOnPacket, efOnConnect, efOnDisconnect, efOnLoad, efOnFree);
  TEnableFuncs = set of TEnableFunc;
  TPluginStruct = packed record
    Threads: PThreads;
    ThreadsCount: Integer;
    SendPck: TSendPacket;
  end;
  
implementation
    
end.
