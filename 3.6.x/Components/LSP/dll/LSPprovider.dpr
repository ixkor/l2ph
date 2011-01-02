library LSPprovider;

uses
  JwaWS2spi,
  JwaWinType,
  JwaWinSock2,
  Windows,
  Sysutils,
  SyncObjs,
  classes,
  math,
  overlapped in 'overlapped.pas',
  LSPStructures in '..\structures\LSPStructures.pas';

type
  Tselects=record
  result:integer;
  s: TSocket;
  hWnd: HWND;
  wMsg: u_int;
  lEvent: integer;
  lpErrno: Integer;
  end;

var
  sprocessname:string;
  NextProcTable:WSPPROC_TABLE;
  glCS:TCriticalSection;
  cOverlapped: TOverlapped;
  hookthis:boolean;
  Connections : TList;
  ReciverHandle:thandle = 0;
  ReciverWndClass:TWndClassEx;
  ReciverMEssageProcessThreadId: DWORD;
  ReciverMEssageProcessThreadHandle: THandle;
  Mmsg: MSG;  //сообщение
  ShareMain : TshareMain;

procedure debug(msg:string);
begin
  OutputDebugString(pchar(msg));
end;



function isMainWork:boolean;
var
  MutexHandle : THandle;
begin
result := false;
try
  //Основное работает?
  MutexHandle := OpenMutex(MUTEX_ALL_ACCESS, false, Mutexname);
  if MutexHandle <> 0 then
    begin
      CloseHandle(MutexHandle);
      Result := true;
    end
  else
    begin
      Result := false;
    end;
except
debug('!!!ERROR!!! isMainWork');
end;
end;

Function GetConnectionData(SockNum:integer): TClient;
var
  i : integer;
begin
  //Получаем екземпляр TClient по его сокетному номеру.
  //Если не найден или не перехваываем - результат = nil;
  Result := nil;
  if not assigned(Connections) then exit;
  i := 0;
  while i < Connections.Count do
    begin
      if TClient(Connections.Items[i]).SockNum = SockNum then
        begin
          Result := TClient(Connections.Items[i]);
          exit;
        end;
      inc(i);
    end;
end;

function isSocketHooked(SockNum:cardinal):boolean;
begin
  Result := assigned(GetConnectionData(SockNum));
end;

procedure DeleteClient(SockNum:integer);
var
  i : integer;
begin
  if not Assigned(Connections) then exit;
  //бежим пока не найдем наш
  i := 0;
  while i < Connections.Count do
    begin
      if TClient(Connections.Items[i]).SockNum = SockNum then
        begin
          UnmapViewOfFile(TClient(Connections.Items[i]).MemBuf);
          CloseHandle(TClient(Connections.Items[i]).MemBufHandle);
          TClient(Connections.Items[i]).Destroy;
          Connections.Delete(i);
          break;//нашли
        end;
      inc(i);
    end;
end;


function ByteToHexStr(Data: Pointer; Len: Integer;calledfrom:string): String;
var
  I, Octets, PartOctets: Integer;
  DumpData: String;
begin
  result := '';
try
  if Len = 0 then Exit;
  if Data = nil then exit;
  I := 0;
  Octets := 0;
  PartOctets := 0;
  Result := '';
  while I < Len do
  begin
    case PartOctets of
      0: Result := Result + Format('%.4d: ', [Octets]);
      9:
      begin
        Inc(Octets, 10);
        PartOctets := -1;
        Result := Result + '    ' + DumpData + sLineBreak;
        DumpData := '';
      end;
    else
      begin
        Result := Result + Format('%s ', [IntToHex(TByteArray(Data^)[I], 2)]);
        if TByteArray(Data^)[I] in [$19..$FF] then
          DumpData := DumpData + Chr(TByteArray(Data^)[I])
        else
          DumpData := DumpData + '.';
        Inc(I);
      end;
    end;
    Inc(PartOctets);
  end;
  if PartOctets <> 0 then
  begin
    PartOctets := (8 - Length(DumpData)) * 3;
    Inc(PartOctets, 4);
    Result := Result + StringOfChar(' ', PartOctets) +
      DumpData
  end;
except
  debug('!!!error!!! ByteToHexStr len = '+inttostr(Len)+' calledfrom='+calledfrom);
end;
end;


function WindowProc (wnd: HWND; msg: integer; wparam: WPARAM; lparam: LPARAM):LRESULT;STDCALL;
var
  Client : TClient;
begin
result := 0;
try
  case msg of
  WM_action:
    if isMainWork then //обрабатываем акшины только когда основное запущено.
    case lparam of
      Action_sendtoServer: //отправка от имени клиента.
      try
        Client := GetConnectionData(wparam);
        if assigned(Client) then //перехвачено
          begin
            //если мы не находимся в WSPSend
            if not client.inSend then
              begin
                //просто шлем данные с флагом 99
                send(client.MemBuf^.SendRecv.SockNum, client.MemBuf^.SendRecv.CurrentBuff[0], client.MemBuf^.SendRecv.CurrentSize, 99);
                FillChar(client.MemBuf^.SendRecv.CurrentBuff[0],$ffff,#0);
                client.MemBuf^.SendRecv.CurrentSize := 0;
              end
              else //в данный момент мы в WSPSend
              begin
                //если структура не создана - ее нужно создать.
                if not client.MemBuf^.SendProcessed.exists then
                  begin
                    client.MemBuf^.SendProcessed.exists := true;
                    client.MemBuf^.SendProcessed.CurrentSize := 0;
                    FillChar(client.MemBuf^.SendProcessed.CurrentBuff[0],$ffff,#0);
                  end;

                //Запихиваем данные
                move(client.MemBuf^.SendRecv.CurrentBuff[0], client.MemBuf^.SendProcessed.CurrentBuff[client.MemBuf^.SendProcessed.CurrentSize], client.MemBuf^.SendRecv.CurrentSize);
                inc(client.MemBuf^.SendProcessed.CurrentSize, client.MemBuf^.SendRecv.CurrentSize);
                FillChar(client.MemBuf^.SendRecv.CurrentBuff[0],$ffff,#0);              
                client.MemBuf^.SendRecv.CurrentSize := 0;
              end;
          end; {}
      except
      end;

      Action_sendtoClient: //отправка от имени сервера. тут поприкольней
      try
       
        debug('Action_sendtoClient');
        Client := GetConnectionData(wparam);
        if assigned(Client) then //перехвачено
          begin
            if not client.InRecv then
            begin
              debug('client.InRecv');
              //Если мы не в WSPRecv
              //создать структуру если ее нет, запихнуть туда данные
              if not client.MemBuf^.RecvProcessed.exists then
                begin
                  client.MemBuf^.RecvProcessed.exists := true;
                  client.MemBuf^.RecvProcessed.CurrentSize := 0;
                  FillChar(client.MemBuf^.RecvProcessed.CurrentBuff[0],$ffff,#0);
                end;
                //Запихиваем данные
                move(client.MemBuf^.SendRecv.CurrentBuff[0], client.MemBuf^.RecvProcessed.CurrentBuff[client.MemBuf^.RecvProcessed.CurrentSize], client.MemBuf^.SendRecv.CurrentSize);
                inc(client.MemBuf^.RecvProcessed.CurrentSize, client.MemBuf^.SendRecv.CurrentSize);
                FillChar(client.MemBuf^.SendRecv.CurrentBuff[0],$ffff,#0);
                client.MemBuf^.SendRecv.CurrentSize := 0;

            end
            else
            begin
             debug('not client.InRecv');
             //если в WSPRecv
             //создать афтер структуру если ее нет
             //запихнуть туда данные
              if not client.MemBuf^.RecvProcessed.exists then
                begin
                  debug('not Client.RecvStructAfter.exists');
                  client.MemBuf^.RecvProcessed.exists := true;
                  client.MemBuf^.RecvProcessed.CurrentSize := 0;
                  FillChar(client.MemBuf^.RecvProcessed.CurrentBuff[0],$ffff,#0);
                end;
                //Запихиваем данные
                move(client.MemBuf^.SendRecv.CurrentBuff[0], client.MemBuf^.RecvProcessed.CurrentBuff[client.MemBuf^.RecvProcessed.CurrentSize], client.MemBuf^.SendRecv.CurrentSize);
                inc(client.MemBuf^.RecvProcessed.CurrentSize, client.MemBuf^.SendRecv.CurrentSize);
                FillChar(client.MemBuf^.SendRecv.CurrentBuff[0],$ffff,#0);
                client.MemBuf^.SendRecv.CurrentSize := 0;
           end;
          end; {}
      except
      end;

      Action_closesocket:
      try
        Client := GetConnectionData(wparam);
        if Assigned(Client) then
          closesocket(wparam);
        Client.canWork := false;
      except
      end;

  end;
  else
    Result := DefWindowProc(wnd,msg,wparam,lparam);
  end;
except
debug('!!!ERROR!!! WindowProc');
end;
end;


procedure pReciverMessageProcess;
begin
try
  // Цикл обработки сообщений}
  while GetMessage (Mmsg,0,0,0) do
  begin
    TranslateMessage (Mmsg);
    DispatchMessage (Mmsg);
  end;

except
debug('!!!ERROR!!! pReciverMessageProcess');
end;
end;

Function CreateReciverWnd:Thandle;
begin
try
 //Вот тут мы создаем окошко.
  ReciverWndClass.cbSize := sizeof (ReciverWndClass);
  with ReciverWndClass do
  begin
    lpfnWndProc := @WindowProc;
    cbClsExtra := 0;
    cbWndExtra := 0;
    hInstance := HInstance;
    lpszMenuName := nil;
    lpszClassName := 'c'+Apendix;
  end;
  RegisterClassEx (ReciverWndClass);
  // Создание окна на основе созданного класса

  result := CreateWindow('c'+Apendix, 'c'+Apendix, 0,0,0,0,0,0,0,0,nil);
except
debug('!!!ERROR!!! CreateReciverWnd');
result := 0;
end;
end;

function WSPConnect(s: TSocket; name: PSockAddr; namelen: Integer; lpCallerData: LPWSABUF;
    lpCalleeData: LPWSABUF; lpSQOS: LPQOS; lpGQOS: LPQOS; var lpErrno: Integer): Integer; stdcall;
var
  NewClient : TClient;
begin
  result := -1;
  NewClient := nil;
  try
    if isMainWork then
    begin
    try
      //создаем обьект хранящий данный о соединении в контексте этого приложения
      NewClient := TClient.Create;
      //присваем ему буффер, через него будем работать.
      NewClient.MemBufHandle := CreateFileMapping(INVALID_HANDLE_VALUE, nil,
        PAGE_READWRITE, 0, SizeOf(TMemoryBuffer), pchar(Apendix + inttostr(s)));
      NewClient.MemBuf := MapViewOfFile(NewClient.MemBufHandle, FILE_MAP_ALL_ACCESS,
        0, 0, SizeOf(TMemoryBuffer));
      NewClient.MemBuf^.ConnectStruct.Exists := true;
      NewClient.MemBuf^.ConnectStruct.HookIt := false;
      NewClient.MemBuf^.ConnectStruct.reddirect := false;
      NewClient.MemBuf^.ConnectStruct.SockNum := s;
      NewClient.MemBuf^.ConnectStruct.pid := GetCurrentProcessId;
      NewClient.MemBuf^.ConnectStruct.ip := inet_ntoa(name.sin_addr);
      NewClient.MemBuf^.ConnectStruct.port := ntohs(Name.sin_port);
      NewClient.MemBuf^.ConnectStruct.ReciverHandle := ReciverHandle;
      NewClient.MemBuf^.ConnectStruct.application := sprocessname;
      NewClient.canWork := false;
      try
        //уведомляем о коннекте
        SendMessage(ShareMain.MapData^.ReciverHandle, WM_action, s, Action_client_connect);
      except
        debug('!!!ERROR!!! WSPConnect>x2');
      end;
    except
      debug('!!!ERROR!!! WSPConnect>x1');
    end;


    if assigned(NewClient) then
    if NewClient.MemBuf^.ConnectStruct.HookIt then //Нас хотят видеть. -) добавляем клиента в соединения
      begin
      NewClient.canWork := true;
      NewClient.SockNum := s;
      NewClient.ControlHandle := ShareMain.MapData^.ReciverHandle;
      NewClient.InRecv := false;
      NewClient.inSend := false;
      Connections.Add(NewClient);
      NewClient.MemBuf^.RecvStruct.SockNum := s;
      NewClient.MemBuf^.RecvStruct.CurrentSize := 0;
      NewClient.MemBuf^.RecvStruct.exists := false;
      NewClient.MemBuf^.SendStruct.SockNum := s;
      NewClient.MemBuf^.SendStruct.CurrentSize := 0;
      NewClient.MemBuf^.SendStruct.exists := false;
      NewClient.MemBuf^.ConnectStruct.Exists := false;
      NewClient.MemBuf^.SendRecv.CurrentSize := 0;
      NewClient.MemBuf^.SendRecv.exists := false;
      NewClient.MemBuf^.SendRecv.SockNum := s;

      NewClient.MemBuf^.SendProcessed.CurrentSize := 0;
      NewClient.MemBuf^.SendProcessed.exists := false;
      NewClient.MemBuf^.SendProcessed.SockNum := s;
      NewClient.MemBuf^.RecvProcessed.CurrentSize := 0;
      NewClient.MemBuf^.RecvProcessed.exists := false;
      NewClient.MemBuf^.RecvProcessed.SockNum := s;

      end
    else
      //нас не хотят видеть -(
      begin

      //или все таки хотят ? но подругому...
      if NewClient.MemBuf^.ConnectStruct.reddirect then
        begin
          name.sin_addr.S_addr := inet_addr('127.0.0.1');
          name.sin_port := htons(NewClient.MemBuf^.ConnectStruct.port);
        end;

      //Убиваем созданое
      NewClient.MemBuf^.ConnectStruct.Exists := false;
      UnmapViewOfFile(NewClient.MemBuf);
      CloseHandle(NewClient.MemBufHandle);
      NewClient.Destroy;
      end;
    end;

    //производим коннект
    result:=NextProcTable.lpWSPConnect(s, name, namelen, lpCallerData, lpCalleeData,
            lpSQOS, lpGQOS, lpErrno);
  except
    debug('!!!ERROR!!! WSPConnect '+inttostr(GetLastError));
  end;
end;

function WSPCloseSocket(s: TSocket; var lpErrno: Integer): Integer; stdcall;
var
  Client : TClient;
begin
  Client := GetConnectionData(s);
  //нет перехвата на этом сокете ? отпрабатываем и выходим.
  if not Assigned(Client) then
  begin
    result := NextProcTable.lpWSPCloseSocket(s,lperrno); //отключаемся
    exit;
  end;
  //сюда попадаем если есть перехват.
  result := 0;
  try
    client.MemBuf^.DisconnectStruct.exists := true;
    client.MemBuf^.DisconnectStruct.SockNum := s;
    client.MemBuf^.DisconnectStruct.lpErrno := lpErrno;
    SendMessage(Client.ControlHandle, WM_action, s, Action_client_disconnect); //уведомляем
    result := NextProcTable.lpWSPCloseSocket(s, lperrno); //отключаемся
    client.MemBuf^.DisconnectStruct.exists := false;
    DeleteClient(s);    
  except
    debug('WSPCloseSocket code = '+inttostr(GetLastError));
  end;
end;

function WSPSend(s: TSocket; lpBuffers: LPWSABUF; dwBufferCount: DWORD;
    var lpNumberOfBytesSent: DWORD; dwFlags: DWORD; lpOverlapped: LPWSAOVERLAPPED;
    lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE;
    lpThreadId: LPWSATHREADID; var lpErrno: Integer): Integer; stdcall;
var
  Client : TClient;
begin
Client := GetConnectionData(s);
//если не захуканы либо флаг = 99 (шлем сами) то просто исполняем и уходим
if not assigned(Client) or (dwFlags = 99) then
begin
    if dwFlags = 99 then dwFlags := 0;
    result:=NextProcTable.lpWSPSend(s,lpBuffers,dwBufferCount,lpNumberOfBytesSent,
       dwFlags,lpOverlapped,lpCompletionRoutine,lpThreadId,lpErrno);
    exit;
end;

//данные требуют обработки. попадаем сюда.
//Заранее говорим что отправили все.
result := 0;
lpNumberOfBytesSent := lpBuffers.len;


try
  if not Client.canWork then
    begin
      Result := -1;
      lpNumberOfBytesSent := 0;
      exit;
    end;

  Client.InSend := true; //флаг нужный в оконном обработчике при action_sendtoServer
  
  Client.MemBuf^.SendStruct.exists := true;
  //Пишем структуру полученый буфер
  FillChar(Client.MemBuf^.SendStruct.CurrentBuff[0], $ffff, #0);
  move(lpBuffers.buf[0], Client.MemBuf^.SendStruct.CurrentBuff[0], lpBuffers.len);
  Client.MemBuf^.SendStruct.CurrentSize := lpBuffers.len;

  //Уведомляем приложение
  SendMessage(Client.ControlHandle, WM_action, s, Action_client_send); //уведомляем о приеме

  //просто отправляем полученый буфер с флагом 99
  if Client.MemBuf^.SendProcessed.CurrentSize > 0 then
  send(s, Client.MemBuf^.SendProcessed.CurrentBuff[0], Client.MemBuf^.SendProcessed.CurrentSize, 99);

  //уничтожаем результирующую структуру
  Client.MemBuf^.SendProcessed.CurrentSize := 0; 
  Client.MemBuf^.SendProcessed.exists := false;  //рабочая структура уничтожена
  FillChar(Client.MemBuf^.SendProcessed.CurrentBuff[0], $ffff, #0);
  Client.inSend := False; //снимаем флаг
  except
    debug('!!!ERROR!!! in WSPSend');
  end; 
end;



function WSPRecv(s: TSocket; lpBuffers: LPWSABUF; dwBufferCount: DWORD;
    var lpNumberOfBytesRecvd, lpFlags: DWORD; lpOverlapped: LPWSAOVERLAPPED;
    lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE; lpThreadId: LPWSATHREADID;
    var lpErrno: Integer): Integer; stdcall;

var
  Client : TClient;
  TempBuf : Tbuffer;
  tempSize : Cardinal;

begin
Client := GetConnectionData(s);
result := NextProcTable.lpWSPRecv(s,lpBuffers,dwBufferCount,lpNumberOfBytesRecvd,
                                lpFlags,lpOverlapped,lpCompletionRoutine,lpThreadId,
                                lpErrno);
                                
//Если перехват этого соединения не установлен - выходим.
if not assigned(Client) then exit;
//Если установлен - попадаем сюда

//если мы получили данные то выполняем наш код.
if (result=0) and (lpNumberOfBytesRecvd>0) then
begin
  try
  if not Client.canWork then
    begin
      Result := -1;
      lpNumberOfBytesRecvd := 0;
      exit;
    end;
  Client.InRecv := true; //флаг нужный в оконном обработчике при action_sendtoClient
  //В структуре уже есть (могут быть) данные добавленые нашим приложением через сообщение action_sendtoClient
  //Запоминаем их
  FillChar(TempBuf[0], $ffff, #0);
  move(Client.MemBuf^.RecvStruct.CurrentBuff[0], TempBuf[0], Client.MemBuf^.RecvStruct.CurrentSize);
  tempSize := Client.MemBuf^.RecvStruct.CurrentSize;

  //Пишем структуру полученый буфер
  FillChar(Client.MemBuf^.RecvStruct.CurrentBuff[0], $ffff, #0);
  move(lpBuffers.buf[0], Client.MemBuf^.RecvStruct.CurrentBuff[0], lpnumberofbytesrecvd);
  Client.MemBuf^.RecvStruct.CurrentSize := lpNumberOfBytesRecvd;

  //Уведомляем приложение

  SendMessage(Client.ControlHandle, WM_action, s, Action_client_recv); //уведомляем о приеме

  //замещаем буфер который идет на клиент
  lpnumberofbytesrecvd := Client.MemBuf^.RecvProcessed.CurrentSize; //основное приложение могло изменить данные, новая длина полученых данных
  CopyMemory(@lpBuffers^.buf[0], @Client.MemBuf^.RecvProcessed.CurrentBuff[0], lpnumberofbytesrecvd);

  //уничтожаем рабочую структуру
  Client.MemBuf^.RecvProcessed.CurrentSize := 0;
  Client.MemBuf^.RecvProcessed.exists := false;  //рабочая структура уничтожена
  FillChar(Client.MemBuf^.RecvProcessed.CurrentBuff[0], $ffff, #0);
  //снимаем флаг
  Client.InRecv := False;
  except
    debug('!!!ERROR!!! in WSPRecv');
  end; 
end;

end;


const
  reg_key='SYSTEM\CurrentControlSet\Services\WinSock2\SockEyeS';
  MAX_PATH=1024;
  
function GetHookProvider(pProtocolInfo:LPWSAPROTOCOL_INFOW;var sPathName:string):boolean;
  procedure GetRightEntryIdItem(pProtocolInfo:LPWSAPROTOCOL_INFOW;var sItem:string);
  begin
    if pProtocolInfo.ProtocolChain.ChainLen<=1 then
      begin
        sItem:=inttostr(pProtocolInfo.dwCatalogEntryId);
      end
    else
      begin
        sItem:=inttostr(pProtocolInfo.ProtocolChain.ChainEntries[pProtocolInfo.ProtocolChain.ChainLen-1]);
      end;
  end;
var
  sItem:string;
  sTemp,
  sPathTmp:pchar;
  hSubKey: hkey;
  ulDateLenth: DWORD;
  Datatype,i:integer;
begin
  result:=true;
  GetRightEntryIdItem(pProtocolInfo,sItem);
  ulDateLenth:=MAX_PATH;
  getmem(sTemp,MAX_PATH);
  getmem(sPathTmp,MAX_PATH);
  try
    if RegOpenKeyEx(HKEY_LOCAL_MACHINE,pchar(reg_key),0,KEY_ALL_ACCESS,hSubKey)<>0 then
      begin
        result:=false;
        exit;
      end;
    if RegQueryValueEx(hSubKey,pchar(sItem),nil,@Datatype,pbyte(sTemp),@ulDateLenth)=0 then
      begin
        i:=ExpandEnvironmentStrings(sTemp,sPathTmp,ulDateLenth);
        if i<>0 then
          begin
            sPathName:=strpas(sPathTmp);
            RegCloseKey(hSubKey);
          end
        else
          begin
            result:=false;
            exit;
          end;
      end
    else
      begin
        result:=false;
        exit;
      end;
  finally
    freemem(sTemp);
    freemem(sPathTmp);
  end;
end;

function WSPioctrl(s: TSocket; dwIoControlCode: DWORD; lpvInBuffer: LPVOID; cbInBuffer: DWORD;
    lpvOutBuffer: LPVOID; cbOutBuffer: DWORD; var lpcbBytesReturned: DWORD;
    lpOverlapped: LPWSAOVERLAPPED; lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE;
    lpThreadId: LPWSATHREADID; var lpErrno: Integer): Integer; stdcall;
begin
  result := NextProcTable.lpWSPIoctl(s, dwIoControlCode, lpvInBuffer, cbInBuffer,
      lpvOutBuffer, cbOutBuffer, lpcbBytesReturned,
      lpOverlapped, lpCompletionRoutine,
      lpThreadId, lpErrno);

  if isSocketHooked(s) then
        debug('WSPioctrl result ('+inttostr(result)+') s ('+inttostr(s)+') dwIoControlCode ('+inttostr(dwIoControlCode)+
          ') cbInBuffer ('+inttostr(cbInBuffer)+') cbOutBuffer ('+inttostr(cbOutBuffer)
          +') lpcbBytesReturned ('+inttostr(lpcbBytesReturned)+') lpThreadId ('+inttostr(lpThreadId.ThreadHandle)+')'
          +') lpErrno ('+inttostr(lpErrno)+')');
end;


function WSPAsyncSelect(s: TSocket; hWnd: HWND; wMsg: u_int; lEvent: Longint; var lpErrno: Integer): Integer; stdcall;
begin
  result := NextProcTable.lpWSPAsyncSelect(s, hWnd, wMsg, lEvent, lpErrno);

  if isSocketHooked(s) then
  debug('WSPAsyncSelect s ('+inttostr(s)+') hWnd ('+inttostr(hWnd)+
      ') wMsg ('+inttostr(wMsg)+') lEvent ('+inttostr(lEvent)
      +') lpErrno ('+inttostr(lpErrno)+')');

end;



function WSPStartup(wVersionRequested: WORD; lpWSPData: LPWSPDATA;
  lpProtocolInfo: LPWSAPROTOCOL_INFOW; UpcallTable: WSPUPCALLTABLE;
  lpProcTable: LPWSPPROC_TABLE): Integer; stdcall;
var
  WSPStartupFunc:LPWSPSTARTUP;
  slibpath:string;
  hlibhandle:hmodule;
begin
 
  if not GetHookProvider(lpProtocolInfo,slibPath) then
    begin
      result:=WSAEPROVIDERFAILEDINIT;
      exit;
    end;
  hlibhandle:=loadlibrary(pchar(slibpath));
  if hlibhandle<>0 then
    begin
      WSPStartupFunc:= LPWSPSTARTUP(getprocaddress(hlibhandle,pchar('WSPStartup')));
      if assigned(WSPStartupFunc) then
        begin
          result:=WSPStartupFunc(wVersionRequested,lpWSPData,lpProtocolInfo,UpcallTable,lpProcTable);
          if (result=0) then
            begin
                NextProcTable:=lpProcTable^;
                if hookthis then
                begin
                  //ставим свои функции перехвата.
                  lpProcTable.lpWSPConnect := WSPConnect;
                  lpProcTable.lpWSPCloseSocket := WSPCloseSocket;
                  lpProcTable.lpWSPSend := WSPSend;
                  lpProcTable.lpWSPRecv := WSPRecv;
                  lpProcTable.lpWSPIoctl := WSPioctrl;
                  lpProcTable.lpWSPAsyncSelect := WSPAsyncSelect;
                end;
              exit;
            end;
        end
      else
        begin
          result:=WSAEPROVIDERFAILEDINIT;
        end;
    end
  else
    begin
      result:=WSAEPROVIDERFAILEDINIT;
    end;
end;

procedure opensharemain;
begin
try
  //Подсоединяемся к мапфайлу основного приложения.
  ShareMain.MapHandle := CreateFileMapping(INVALID_HANDLE_VALUE, nil,
        PAGE_READWRITE, 0, SizeOf(TShareMapMain), Apendix);
  ShareMain.MapData := MapViewOfFile(ShareMain.MapHandle, FILE_MAP_ALL_ACCESS,
        0, 0, SizeOf(TShareMapMain));
except
debug('!!!ERROR!!! opensharemain');
end;
end;


procedure DllMain(dwReason : DWORD);
var
  tmp:pchar;
begin
  case dwReason of
    DLL_PROCESS_ATTACH :
      begin
        hookthis := false;
        cOverlapped := TOverlapped.create;
        glCS := TCriticalSection.Create;
        try
        getmem(tmp,1024);
        if getmodulefilenamea(0,tmp,1024)>0 then
          begin
            sprocessname:=strpas(tmp);
            debug(sprocessname+' - Подгрузила длл');

            if isMainWork then //Работает ли основное ?
              begin
                opensharemain; //Подсоединяемся к структуре в которой лежат данные об основном приложении
                if pos(LowerCase(ExtractFileName(sprocessname)),LowerCase(ShareMain.MapData^.ProcessesForHook)) > 0 then
                //наше прилодение в списке перехватываемых ?
                begin
                  hookthis := true; //нужно перехватывать
                  ReciverHandle := CreateReciverWnd; //создаем ресайвер
                  Connections := TList.Create;
                  
                  //Создаем Поток, который будет обрабатывать сообщения от приемника
                  ReciverMessageProcessThreadHandle := CreateThread(nil, 0, @pReciverMessageProcess, nil, 0, ReciverMEssageProcessThreadId);
                  //и запускаем его
                  ResumeThread(ReciverMEssageProcessThreadHandle);
                end;
              end;
          end
        else
          begin
            sprocessname:='';
            debug('Кудато подгрузились..');
          end;
        freemem(tmp);
        except
        debug('!!!ERROR!!! DLL_PROCESS_ATTACH');
        end;
      end;
      
    DLL_PROCESS_DETACH :
      begin
        try
          if hookthis then
          begin
          if Assigned(Connections) then
          while Connections.Count > 0 do
            begin
              UnmapViewOfFile(TClient(Connections.Items[0]).MemBuf);
              CloseHandle(TClient(Connections.Items[0]).MemBufHandle);
              TClient(Connections.Items[0]).Destroy;
              Connections.Delete(0);
            end;
            if Assigned(Connections) then
            Connections.Destroy;

            TerminateThread(ReciverMEssageProcessThreadHandle,0);
            DestroyWindow(ReciverHandle);
          end;
        except

        end;

        cOverlapped.destroy;
        cOverlapped := nil;
        glCS.Destroy;
      end;

    DLL_THREAD_ATTACH :
      begin
      end;

    DLL_THREAD_DETACH :
      begin
      end;
  end;
end;

exports
  WSPStartup;

begin
  hookthis := false;
  DLLProc := @DLLMain;
  DLLMain(DLL_PROCESS_ATTACH);
end.


