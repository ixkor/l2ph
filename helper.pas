unit helper;

interface
uses Windows, Messages, SysUtils, Classes, advApiHook, PSAPI, TlHelp32,
  fs_iinterpreter,WinSock;

  // функции преобразования
  function DataPckToStrPck(var pck): string; stdcall;
  function SymbolEntersCount(s: string): string;
  function HexToString(Hex:String):String;
  function StringToHex(str1,Separator:String):String;
  function ByteArrayToHex(str1:array of Byte; size: Word):String;
  function StringToWideString(const s: AnsiString; codePage: Word): WideString;
  function WideStringToString(const ws: WideString; codePage: Word): AnsiString;

  // для работы с сокетами
  // олучаем данные из сокета
  function GetSocketData(Socket: TSocket; var Data; const Size: Word): Boolean;
  //ожидаем подключения клиента
  function WaitClient(var hSocket, NewSocket: TSocket): Boolean;
  //соединение с сервером
  function ConnectToServer(var hSocket: TSocket; Port: Word; IP: Integer): Boolean;
  //закрываем сокет
  procedure DeInitSocket(const hSocket: Integer);
  //инициализируем сокет
  function InitSocket(var hSocket: TSocket; Port: Word; IP: String): Boolean;

  
  function GetNamePacket(s:string):string; // вырезаем название акета из строки
  procedure GetProcessList(var sl: TStrings); // получаем список процессов
  procedure ShowMessageNew(const Msg: string); // скрывает сообщение FastScript

  function CRLFToSpace(const Str: string): string;
  function DSpaceToCRLF(const Str: string): string;
  function CopyArr(arr: array of Byte; ind, count: Integer): string;
  procedure AntiLIIC4(var data: array of Byte);

  // корректировка id для пакетов Gracia на оффициальных серверах
  procedure Corrector(var data; const tid: Integer; const enc: Boolean = False;
    const FromServer: Boolean = False);

type
  //скрипт
  TScript = record
    fsScript: TfsScript;
    Name: string;
    Compilled: Boolean;
    cs: RTL_CRITICAL_SECTION;
  end;
  
var
  ShowMessageOld: procedure (const Msg: string);
  Scripts: array[0..63] of TScript;
  WSA: TWSAData;
  Terminate: boolean; //завершать работу потока? true - да, false - нет
  Terminated: boolean; //завершил работу поток? true - да, false - нет
  SLThreadTerminate: boolean; //завершать работу потока? true - да, false - нет
  SLThreadStarted: boolean; //заущен поток? true - да, false - нет


const
  {The name of the debug info support L2phx}
  UnLoadDllSuccessfully = 'Библиотека %s успешно выгружена';
  LoadDllUnSuccessful = 'Библиотека %s отсутствует или заблокирована другим приложением';
  LoadDllSuccessfully = 'Успешно загрузили %s';
  StartLocalServer = 'На %d зарегистрирован локальный сервер';
  FailedLocalServer = 'Неудалось зарегистрировать локальный сервер на порте %d'+ #13#10+ 'Возможно этот порт занят другим приложением';
  CreateNewConnect = 'Создано новое соединение - %d';
  ConnectBreak = 'Соединение %d разорвано';
  WSA_VER=$202;

implementation

uses main;

function DataPckToStrPck(var pck): string; stdcall;
var
  tpck: packed record
    size: Word;
    id: Byte;
  end absolute pck;
begin
  SetLength(Result,tpck.size-2);
  Move(tpck.id,Result[1],Length(Result));
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

function HexToString(Hex:String):String;
var
  buf:String;
  bt:Byte;
  i:Integer;
begin
  buf:='';
  Hex:=SymbolEntersCount(UpperCase(Hex));
  for i:=0 to (Length(Hex) div 2)-1 do begin
    bt:=0;
    if (Byte(hex[i*2+1])>$2F)and(Byte(hex[i*2+1])<$3A)then bt:=Byte(hex[i*2+1])-$30;
    if (Byte(hex[i*2+1])>$40)and(Byte(hex[i*2+1])<$47)then bt:=Byte(hex[i*2+1])-$37;
    if (Byte(hex[i*2+2])>$2F)and(Byte(hex[i*2+2])<$3A)then bt:=bt*16+Byte(hex[i*2+2])-$30;
    if (Byte(hex[i*2+2])>$40)and(Byte(hex[i*2+2])<$47)then bt:=bt*16+Byte(hex[i*2+2])-$37;
    buf:=buf+char(bt);
  end;
  HexToString:=buf;
end;

function StringToHex(str1,Separator:String):String;
var
  buf:String;
  i:Integer;
begin
  buf:='';
  for i:=1 to Length(str1) do begin
    buf:=buf+IntToHex(Byte(str1[i]),2)+Separator;
  end;
  Result:=buf;
end;

function ByteArrayToHex(str1:array of Byte; size: Word):String;
var
  buf:String;
  i:Integer;
begin
  buf:='';
  for i:=0 to size-1 do begin
    buf:=buf+IntToHex(str1[i],2);
  end;
  Result:=buf;
end;

function WideStringToString(const ws: WideString; codePage: Word): AnsiString;
var
  l: integer;
begin
  if ws = '' then
    Result := ''
else
  begin
    l := WideCharToMultiByte(codePage,
      WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
      @ws[1], -1, nil, 0, nil, nil);
    SetLength(Result, l - 1);
    if l > 1 then
      WideCharToMultiByte(codePage,
        WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
        @ws[1], -1, @Result[1], l - 1, nil, nil);
  end;
end;

function StringToWideString(const s: AnsiString; codePage: Word): WideString;
var
  l: integer;
begin
  if s = '' then
    Result := ''
else
  begin
    l := MultiByteToWideChar(codePage, MB_PRECOMPOSED, PChar(@s[1]), -1, nil,
      0);
    SetLength(Result, l - 1);
    if l > 1 then
      MultiByteToWideChar(CodePage, MB_PRECOMPOSED, PChar(@s[1]),
        -1, PWideChar(@Result[1]), l - 1);
  end;
end;


function GetSocketData(Socket: TSocket; var Data; const Size: Word): Boolean;
var
  Position: Word;
  Len: Integer;
  DataB: array[0..$5000] of Byte absolute Data;
begin
  Result:=False;
  Position:=0;
  while Position<Size do begin
    Len:=recv(Socket,DataB[Position],1,0);
    if Len<=0 then Exit;
    Inc(Position, Len);
  end;
  Result:=True;
end;

function WaitForData(Socket: TSocket; Timeout: Longint): Boolean;
var
  FDSet: TFDSet;
  TimeVal: TTimeVal;
begin
  TimeVal.tv_sec := Timeout div 1000;
  TimeVal.tv_usec := (Timeout mod 1000) * 1000;
  FD_ZERO(FDSet);
  FD_SET(Socket, FDSet);
  Result := select(0, @FDSet, nil, nil, @TimeVal) > 0;
end;

function WaitClient(var hSocket, NewSocket: TSocket): Boolean;
var
  Addr_in: sockaddr_in;
  AddrSize: Integer;
begin
  Result:=False;
  if listen(hSocket, 1)<>0 then
  begin
    DeInitSocket(hSocket);
    Exit;
  end;
  FillChar(Addr_in,SizeOf(sockaddr_in), 0);
  Addr_in.sin_family:=AF_INET;
  Addr_in.sin_addr.s_addr:=inet_addr(PChar('0.0.0.0'));
  Addr_in.sin_port:=HToNS(0);
  AddrSize:=SizeOf(Addr_in);
  while true do begin
    if SLThreadTerminate then exit;
    if WaitForData(hSocket, 15) then begin
      NewSocket:=accept(hSocket, @Addr_in, @AddrSize);
      break;
    end;
  end;
  if NewSocket>0 then Result:=True;
  if not Result then begin
    DeInitSocket(hSocket);
    DeInitSocket(NewSocket);
  end;
end;

function ConnectToServer(var hSocket: TSocket; Port: Word; IP: Integer): Boolean;
var
  Addr_in: sockaddr_in;
begin
  Result:=False;
  Addr_in.sin_family:=AF_INET;
  Addr_in.sin_addr.S_addr:=IP;
  Addr_in.sin_port:=Port;
  if connect(hSocket,Addr_in,SizeOf(Addr_in))=0 then Result:=True;
  if not Result then begin
    DeInitSocket(hSocket);
  end;
end;

procedure DeInitSocket(const hSocket: Integer);
begin
  // Закрываем сокет
  if hSocket <> INVALID_SOCKET then begin
    sendMSG('WSA no error ' + inttostr(WSAGetLastError)+'/'+inttostr(hsocket));
    //Shutdown(hSocket,2);  //выключаем сокет
    closesocket(hSocket); //уничтожаем сокет
  end else //ошибка, анализируем с помощью WSAGetLastError
      sendMSG('WSA error ' + inttostr(WSAGetLastError)+'/'+inttostr(hsocket));

end;

function InitSocket(var hSocket: TSocket; Port: Word; IP: String): Boolean;
var
  Addr_in: sockaddr_in;
begin
  Result:=False;
  hSocket := socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  if hSocket = INVALID_SOCKET then
  begin
    DeInitSocket(hSocket);
    Exit;
  end;
  FillChar(Addr_in, SizeOf(sockaddr_in), 0);
  Addr_in.sin_family:= AF_INET;
  Addr_in.sin_addr.s_addr := inet_addr(PChar(IP));
  Addr_in.sin_port := HToNS(Port);
  if bind(hSocket, Addr_in, SizeOf(sockaddr_in)) <> 0 then  //ошибка, если больше нуля
  begin
    DeInitSocket(hSocket);
    Exit;
  end;
  Result := True;
end;

function GetNamePacket(s:string):string;
var
  ik: Word;
begin
  Result:='';
  ik:=1;
  // ищем конец имени пакета
  while (s[ik]<>':') and (ik<Length(s)) do begin
    Result:=Result+s[ik];
    Inc(ik);
  end;
  if (ik=Length(s))and(s[ik]<>':') then Result:=Result+s[ik];
end;

procedure GetProcessList(var sl: TStrings);
var
  pe: TProcessEntry32;
  ph, snap: THandle; //дескрипторы процесса и снимка
  mh: hmodule; //дескриптор модуля
  procs: array[0..$FFF] of dword; //массив для хранения дескрипторов процессов
  count, cm: cardinal; //количество процессов
  i: integer;
  ModName: array[0..max_path] of char; //имя модуля
  tmp: string;
begin
  sl.Clear;
  if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
  begin //если это Win9x
    snap := CreateToolhelp32Snapshot(th32cs_snapprocess, 0);
    if integer(snap)=-1 then
    begin
      exit;
    end
    else
    begin
      pe.dwSize:=sizeof(pe);
      if Process32First(snap, pe) then
        repeat
          sl.Add(string(pe.szExeFile));
        until not Process32Next(snap, pe);
    end;
  end else begin //Если WinNT/2000/XP
    if not EnumProcesses(@procs, sizeof(procs), count) then
    begin
      exit;
    end;
    for i:=0 to (count div 4) - 1 do if procs[i] <> 4 then
    begin
      EnablePrivilegeEx(INVALID_HANDLE_VALUE,'SeDebugPrivilege');
      ph := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, false, procs[i]);
      if ph > 0 then
      begin
        EnumProcessModules(ph, @mh, 4, cm);
        GetModuleFileNameEx(ph, mh, ModName, sizeof(ModName));
        tmp:=LowerCase(ExtractFileName(string(ModName)));
        sl.Add(IntToStr(procs[i])+'='+tmp);
        CloseHandle(ph);
      end;
    end;
  end;
end;

{скрываем сообщение о том, что желательно купить FastScript}
procedure ShowMessageNew(const Msg: string);
begin
  if Msg<>'Unregistered version of FastScript.' then
    ShowMessageOld(Msg);
end;
{не нашел где используется}
function CRLFToSpace(const Str: string): string;
var
  P: Integer;
begin
  Result:=str;
  repeat
    P:=Pos(sLineBreak, Result);
    if P>0 then
    begin
      Result[P]:=' ';
      Result[P+1]:=' ';
    end;
  until P=0;
end;
{не нашел где используется}
function DSpaceToCRLF(const Str: string): string;
var
  P: Integer;
begin
  Result:=str;
  repeat
    P:=Pos('  ', Result);
    if P>0 then
    begin
      Result[P]:=sLineBreak[1];
      Result[P+1]:=sLineBreak[2];
    end;
  until P=0;
end;
{не нашел где используется}
function CopyArr(arr: array of Byte; ind, count: Integer): string;
begin
  SetLength(Result,count);
  Move(arr[ind],Result[1],count);
end;

{не нашел где используется}
procedure AntiLIIC4(var data: array of Byte);
var
  i:Word;
  crc: Byte;
begin
  crc:=0;
  i:=3;
  while not((data[i]=0)and(data[i+1]=0)) do begin
    crc:=crc xor data[i];
    Inc(i);
  end;
  data[4]:=crc;
  data[2]:=$07;
end;

// модификация скрипта от ShadeOfNothing:
// corrector-3.fsc CT2.2 version 
// скрипт для дополнительного [де]кодирования  ID исходящих пакетов геймсервера 
// в настоящее время, по видимому, нужен только для офа.
procedure Corrector(var data; const tid: Integer; const enc: Boolean = False;
  const FromServer: Boolean = False);
var
  buff: array[1..400] of Char absolute data;

  procedure _pseudo_srand(seed : integer);
  begin
    Thread[tid].cd._seed := seed;
  end;

  function _pseudo_rand: integer;
  var
    a : integer;
  begin
    with Thread[tid].cd^ do begin
      a := (Int64(_seed) * $343fd + $269EC3) and $FFFFFFFF;
      _seed := a;
      result := (_seed shr $10) and $7FFF;
    end;
  end;

  procedure _init_tables(seed: integer; _2_byte_size: integer);
  var
    i : integer;
    x : Char;
    x2: Word;
    rand_pos : integer;
    cur_pos : integer;
  begin
    with Thread[tid].cd^ do begin
      _1_byte_table := '';
      _2_byte_table := '';

      _2_byte_table_size := _2_byte_size;

      for i := 0 to $D0 do begin
        _1_byte_table := _1_byte_table + chr(i);
      end;
      for i := 0 to _2_byte_size do begin
        _2_byte_table := _2_byte_table + chr(i) + #$0;
      end;
      _pseudo_srand(seed);
      for i := 2 to $D1 do begin
        rand_pos := (_pseudo_rand mod i) + 1;
        x := _1_byte_table[rand_pos];
        _1_byte_table[rand_pos] := _1_byte_table[i];
        _1_byte_table[i] := x;
      end;

      cur_pos := 3;
      for i := 2 to _2_byte_size+1 do begin
        rand_pos := _pseudo_rand mod i;
        x2 := PWord(@_2_byte_table[rand_pos * 2 + 1])^;
        PWord(@_2_byte_table[rand_pos * 2 + 1])^:=PWord(@_2_byte_table[cur_pos])^;
        PWord(@_2_byte_table[cur_pos])^:=x2;
        cur_pos := cur_pos + 2;
      end;

      cur_pos := Pos(#$12, _1_byte_table);
      x := _1_byte_table[$13];
      _1_byte_table[$13] := #$12;
      _1_byte_table[cur_pos]:=x;

      cur_pos := Pos(#$B1, _1_byte_table);
      x := _1_byte_table[$B2];
      _1_byte_table[$B2] := #$B1;
      _1_byte_table[cur_pos]:=x;

      _id_mix := true;
    end;
  end;

  procedure _decode_ID;
  begin
    with Thread[tid].cd^ do begin
      buff[3]:=_1_byte_table[Byte(buff[3])+1];
      if buff[3] = #$D0 then begin
        if Byte(buff[4]) > _2_byte_table_size then begin
          // error!
        end;
        buff[4]:=_2_byte_table[Byte(buff[4])*2+1];
      end;
    end;
  end;

  procedure _encode_ID;
  var
    p: integer;
  begin
    with Thread[tid].cd^ do begin
      if buff[3] = #$D0 then begin
        p:= pos(buff[4], _2_byte_table);
        buff[4]:=Char(((p + 1) shr 1) - 1);
      end;
      p := pos(buff[3], _1_byte_table);
      buff[3]:=Char(p-1);
    end;
  end;

begin
  with Thread[tid].cd^ do if FromServer then begin
    if _id_mix and(buff[3]=#$0b)then begin
      temp_seed:=PInteger(@buff[PWord(@buff[1])^-3])^;
      _init_tables(temp_seed,_2_byte_table_size);
    end;
    if(buff[3]=#$2e)then begin
      //if(Protocol = 871)or(Protocol = 12)then _init_tables(PInteger(@buff[$16])^, $58); // CT2.2
      //if(Protocol = 851)or(Protocol = 19)then _init_tables(PInteger(@buff[$16])^, $55); // CT2
      //if Protocol = 831 then _init_tables(PInteger(@buff[$16])^, $4E); // CT1.5+
      _init_tables(PInteger(@buff[$16])^, $80);
    end;
  end else begin
    if not _id_mix and(buff[3]=#$0e)then Protocol:=PInteger(@buff[4])^;
    if _id_mix and not enc then _decode_ID;
    if _id_mix and enc then _encode_ID;
  end;
end;

end.
