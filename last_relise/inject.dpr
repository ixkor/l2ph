library inject;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses  windows,advapihook;

const
  user32    = 'user32.dll';
  kernel32  = 'kernel32.dll';
  winsocket = 'wsock32.dll';
type
  HWND = type LongWord;
  DWORD = LongWord;
  UINT = LongWord;
  WPARAM = Longint;
  LPARAM = Longint;
  LRESULT = Longint;
  LPCSTR = PAnsiChar;
  FARPROC = Pointer;
  {$EXTERNALSYM u_char}
  u_char = Char;
  {$EXTERNALSYM u_short}
  u_short = Word;
  {$EXTERNALSYM u_int}
  u_int = Integer;
  {$EXTERNALSYM u_long}
  u_long = Longint;
  {$EXTERNALSYM SunB}
  SunB = packed record
    s_b1, s_b2, s_b3, s_b4: u_char;
  end;

  {$EXTERNALSYM SunW}
  SunW = packed record
    s_w1, s_w2: u_short;
  end;
  in_addr = record
    case integer of
      0: (S_un_b: SunB);
      1: (S_un_w: SunW);
      2: (S_addr: u_long);
  end;
  TInAddr = in_addr;
  sockaddr_in = record
    case Integer of
      0: (sin_family: u_short;
          sin_port: u_short;
          sin_addr: TInAddr;
          sin_zero: array[0..7] of Char);
      1: (sa_family: u_short;
          sa_data: array[0..13] of Char)
  end;
  TSockAddrIn = sockaddr_in;

var
  ConnectNextHook : function (s: Integer; var Name: sockaddr_in; namelen: Integer): Integer; stdcall;

function FindWindow(lpClassName, lpWindowName: PChar): HWND; stdcall; external user32 name 'FindWindowA';
function SendMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall; external user32 name 'SendMessageA';
function inet_addr(cp: PChar): u_long; stdcall; external winsocket name 'inet_addr';
//function GetModuleHandle(lpModuleName: PChar): HMODULE; stdcall; external kernel32 name 'GetModuleHandleA';
//function GetProcAddress(hModule: HMODULE; lpProcName: LPCSTR): FARPROC; stdcall; external kernel32 name 'GetProcAddress';
//function LoadLibrary(lpLibFileName: PChar): HMODULE; stdcall; external kernel32 name 'LoadLibraryA';

function ConnectHookProc(s: Integer; var Name: sockaddr_in; namelen: Integer): Integer; stdcall;
var
  apph: HWND;
  x: packed record
    lo: Word;
    hi: Word;
  end absolute apph;
begin
  apph:=FindWindow('TL2PacketHackMain',nil);
  if (apph>0)then begin
    apph:=SendMessage(apph,$04F0,Name.sin_addr.S_addr,Name.sin_port);
    if x.lo=1 then begin
      Name.sin_addr.S_addr:=inet_addr('127.0.0.1');
      Name.sin_port:=x.hi;
    end;
  end;
  result:=ConnectNextHook(s, Name, namelen);
end;

begin
  StopProcess(GetCurrentProcessId);
  if not HookProc('ws2_32.dll', 'connect', @ConnectHookProc, @ConnectNextHook) then
    HookProc('wsock32.dll', 'connect', @ConnectHookProc, @ConnectNextHook);
  RunProcess(GetCurrentProcessId);
end.
