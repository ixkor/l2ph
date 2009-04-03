unit usocketengine;

interface

uses
  uResourceStrings,
  uencdec,
  Windows,
  SysUtils,
  WinSock,
  usharedstructs,
  classes,
  uVisualContainer,
  ComCtrls,
  SyncObjs;

const
  WSA_VER=$202;

type

 Ttunel = class (TObject)
  serversocket,              //Серверный сокет
  clientsocket : integer;    //клиентский
  curSockEngine : TObject;   //Сокетный движек создавший этот объект (для возврата назад по обьектам)
  ConnectOrErrorEvent : Cardinal;   //эвент возникающий при соединении клиентского потока
  hServerThread, hClientThread  : integer;  //хендлы потоков
  idServerThread, idClientThread : LongWord;  //threadid потоков
  sLastMessage : String;
  CriticalSectionS, CriticalSectionC  : TCriticalSection;
 private
 Public
  active : boolean;
  isRawAllowed: boolean;
  RawLog : TMemoryStream;
  Visual: TfVisual;
  AssignedTabSheet : TTabSheet;
  TunelWork:boolean;
  noFreeAfterDisconnect : Boolean;
  MustBeDestroyed : boolean;
  CharName : string;
  EncDec : TEncDec;
  Procedure AddToRawLog(dirrection : byte; var data; size:word);
  Procedure EncryptAndSend(Packet:Tpacket; ToServer:Boolean);
  procedure SendNewAction(action : byte);
  procedure NewAction(action : byte; Caller: TObject);
  procedure NewPacket(FromServer: boolean; Caller: TObject);
 Published
  constructor create(SockEngine : TObject);
  Procedure   RUN;
  destructor  destroy; override;
 end;

 TSocketEngine = class (TObject)
  sLastMessage:string;
   tunels : TList;  
 private
   WSA: TWSAData;
   hServerListenThread  : integer;
   idServerListenThread: Cardinal;
   ServerListenSock: Integer;
   procedure sendNewAction(Action : integer);
   procedure NewAction(action : byte; Caller: TObject);
   procedure sendMSG(MSG:string);
   
   function  WaitClient(var hSocket, NewSocket: TSocket): Boolean;
   function  WaitForData(Socket: TSocket; Timeout: Longint): Boolean;
   procedure DeInitSocket(VAR hSocket : integer; const ExitCode: Integer);
   function  InitSocket(var hSocket: TSocket; Port: Word; IP: String): Boolean;
   function  AuthSocks5(var sock:integer; var srvIP: Integer; var srvPort: Word): Boolean;
   function  GetSocketData(Socket: TSocket; var Data; const Size: Word): Boolean;
   function  ConnectToServer(var hSocket: TSocket; Port: Word; IP: Integer): Boolean;   

 public
   //Установать перед Init
   ServerPort : Word;
   //можно менять в момент работы
   isSocks5 : boolean;
   RedirrectIP : Integer;
   RedirrectPort : Word;
   //установить флаг если надо уничтожить
   isServerTerminating : boolean;
 published
   procedure destroyDeadTunels;
   constructor create; //создание и предустановка
   Procedure StartServer; //запуск, вызывать после креейта и установки всех проперти
   destructor destroy; override; //по цепочке разрушит все имеющиеся экземпляры Ttunel
 end;

Procedure ClientBody(thisTunel:Ttunel);
Procedure ServerBody(thisTunel:Ttunel);
procedure showpacket(str:string; packet: TPacket);


implementation
uses uglobalfuncs, umain, Math;

{ TSocketEngine }
procedure TSocketEngine.DeInitSocket;
begin
  // Если была ошибка - выводим ее
  if (ExitCode <> 0) and (ExitCode <> 5) then
  begin
    if hsocket >= 0 then
      SendMSG(format(rsTsocketEngineSocketError, [hsocket, ExitCode, SysErrorMessage(ExitCode)]));
  end;
  // Закрываем сокет
  if hSocket <> INVALID_SOCKET then closesocket(hSocket);
  hSocket := -1;
end;



procedure showpacket(str:string; packet: TPacket);
begin
  OutputDebugString(pchar(str+ByteArrayToHex(packet.PacketAsByteArray,packet.Size)));;
end;

procedure ServerListen(CurrentEngine: TSocketEngine);
var
  NewSocket: TSocket;
  NewTunel : Ttunel;
begin
with CurrentEngine do
begin
    if not InitSocket(ServerListenSock, ServerPort, '0.0.0.0') then
    begin
      sendMSG(format(rsFailedLocalServer,[ntohs(ServerPort)]));
      exit;
    end;
    sendMSG(format(rsStartLocalServer,[ntohs(ServerPort)]));

    while WaitClient(ServerListenSock, NewSocket) do
    begin
      sendMSG(rsSocketEngineNewConnection);
      //новое соединение на серверный сокет. создаем тунель.
      NewTunel := Ttunel.create(CurrentEngine);
      NewTunel.serversocket := NewSocket; //айди серверного сокета = наш индефикатор
      NewTunel.CharName := '[Proxy]#'+IntToStr(NewSocket);
      NewTunel.RUN; //и запускаем его
    end;
end;
end;

Procedure ServerBody(thisTunel:Ttunel);
var
  StackAccumulator : TCharArray;
  AccumulatorLen : LongWord;
  BytesInStack : Longint;
  curPacket : TPacket;
  LastResult : integer;
  EventTimeout : boolean;
  IP: Integer;
  IPb:array[0..3] of Byte absolute ip;
begin

with TSocketEngine(thisTunel.curSockEngine) do
begin
  //Авторизация на прокси, чтение конечной точки соединения
  if isSocks5 then
    if not AuthSocks5(thisTunel.serversocket, RedirrectIP, RedirrectPort) then Exit;

  thisTunel.ConnectOrErrorEvent := CreateEvent(nil, true,false,PChar('ConnectOrErrorEvent'+
                                                      IntToStr(thisTunel.hServerThread)));

  //поток с коннектом на сервер
  thisTunel.hClientThread :=BeginThread(nil, 0, @ClientBody, thisTunel, 0, thisTunel.idClientThread);

  thisTunel.CriticalSectionS.Enter;
  thisTunel.SendNewAction(Ttunel_Action_connect_server);
  thisTunel.CriticalSectionS.Leave;
  EventTimeout := (WaitForSingleObject(thisTunel.ConnectOrErrorEvent, 30000) <> 0);
  if (EventTimeout) or (not thisTunel.TunelWork) then
    begin
      CloseHandle(thisTunel.ConnectOrErrorEvent);
      thisTunel.CriticalSectionS.Enter;
      thisTunel.MustBeDestroyed := true; //Ставим флаг уведомляющий о том что этот обьект не нужен.
      thisTunel.TunelWork := false;
      AddToLog(Format(rsTunelTimeout, [integer(pointer(thisTunel))]));
      thisTunel.CriticalSectionS.Leave;

      DeinitSocket(thisTunel.serversocket,WSAGetLastError);
      TerminateThread(thisTunel.hServerThread,0);
    end;
    CloseHandle(thisTunel.ConnectOrErrorEvent);


  ip := RedirrectIP;
  thisTunel.CriticalSectionS.Enter;
  AddToLog(Format(rsTunelConnected, [integer(pointer(thisTunel)), thisTunel.serversocket, thisTunel.clientsocket, IntToStr(IPb[0])+'.'+IntToStr(IPb[1])+'.'+IntToStr(IPb[2])+'.'+IntToStr(IPb[3]), ntohs(RedirrectPort)]));
  thisTunel.CriticalSectionS.Leave;
  AccumulatorLen := 1;
  LastResult := recv(thisTunel.serversocket, StackAccumulator[0], 1, 0);//Читаем ПЕРВЫЙ байт чтобы задать значение
  if LastResult > 0 then
    thisTunel.AddToRawLog(PCK_GS_ToServer, StackAccumulator[0], LastResult);

  While (LastResult > 0) and (thisTunel.serversocket <> -1) do
  begin //Читаем пока не отвалимся
    //Сколько еще в буфере ?!
    ioctlsocket(thisTunel.serversocket, FIONREAD, Longint(BytesInStack));
    if BytesInStack = 0 then
      BytesInStack := 1;

    LastResult := recv(thisTunel.serversocket, StackAccumulator[AccumulatorLen], BytesInStack, 0);//Читаем 1 байт или весь буффер сразу
    if LastResult > 0 then
    begin
    
    thisTunel.AddToRawLog(PCK_GS_ToServer, StackAccumulator[AccumulatorLen], LastResult);
    inc(AccumulatorLen, LastResult);
    
    if not thisTunel.EncDec.Settings.isNoProcessToServer then
      begin
        if AccumulatorLen >= 2 then
          begin //В акумуляторе данных на 2+ байтикоф
            //дергаем пакет с акамулятора (сейчас важна длина)
            curPacket.PacketAsCharArray := StackAccumulator;
            //Хватит ли в акамуляторе данных для пакета ?
              while (AccumulatorLen >= curPacket.Size) and (AccumulatorLen >= 2) and (curPacket.Size > 0) do
                begin
                  if curPacket.Size = 0 then
                  begin
                    {Ахтунг! пакет! с нулевой длиной!
                    поступаем так же как и в клиентбоди}
                    curPacket.Size := AccumulatorLen;
                  end;
                  thisTunel.CriticalSectionS.Enter;
                  //смещаем и уменьшаем длину акумулятора
                  move(StackAccumulator[curPacket.Size], StackAccumulator[0], AccumulatorLen-curPacket.Size);


                  dec(AccumulatorLen, curPacket.Size);
                  thisTunel.EncDec.Packet := curPacket;
                  thisTunel.EncDec.DecodePacket(PCK_GS_ToServer);
                  //тут можно встроить доп обработку.
                  //пакет уже прошел декод скрипты и обработку встроеную в пх.

                  thisTunel.EncDec.EncodePacket(PCK_GS_ToServer);
                  curPacket := thisTunel.EncDec.Packet;
                  thisTunel.CriticalSectionS.Leave;
                  send(thisTunel.clientsocket, curPacket, curPacket.Size, 0);

                  if AccumulatorLen >= 2 then
                  //повторно загоняем пакет. для вайла
                  curPacket.PacketAsCharArray := StackAccumulator
                  else curPacket.Size := 0;
                end;
          end; // if AccumulatorLen >= 2 then
      end //if not thisTunel.EncDec.Settings.isNoDecryptToServer then
    else //не надо декодить. просто шлем.
      begin
        send(thisTunel.clientsocket, StackAccumulator[0], AccumulatorLen, 0);
        AccumulatorLen := 0;
      end;
    end;
  end;//While LastResult <> SOCKET_ERROR do
    thisTunel.CriticalSectionS.Enter;
    AddToLog(Format(rsTunelServerDisconnect, [integer(pointer(thisTunel))]));

    //сюда попадаем когда отвалился сервер
    thisTunel.sendNewAction(Ttunel_Action_disconnect_server);
    //Интересно.. а так можно сделать ? -)
    thisTunel.Visual.ThisOneDisconnected;
    //
    //не разрываем связь если отключен сервер и noFreeOnServerDisconnect
    thisTunel.CriticalSectionS.Leave;
    while (thisTunel.noFreeAfterDisconnect)  do Sleep(1);

    //закрываем сокеты
    DeinitSocket(thisTunel.serversocket,WSAGetLastError);
    DeinitSocket(thisTunel.clientsocket,WSAGetLastError);
    thisTunel.TunelWork := false;
    thisTunel.MustBeDestroyed := true;
  end;
end;

Procedure ClientBody(thisTunel:Ttunel);
var
  socks5ok : string;
  StackAccumulator : TCharArray;
  AccumulatorLen : LongWord;
  BytesInStack : Longint;
  curPacket : TPacket;
  LastResult : integer;
  IP: Integer;
  IPb:array[0..3] of Byte absolute ip;
begin
with TSocketEngine(thisTunel.curSockEngine) do
begin
if not InitSocket(thisTunel.clientsocket,0,'0.0.0.0') then
  begin
    EndThread(0);
  end;
  ip := RedirrectIP;
  thisTunel.CriticalSectionC.Enter;
  AddToLog(Format(rsTunelConnecting, [integer(pointer(thisTunel)), thisTunel.serversocket, thisTunel.clientsocket, IntToStr(IPb[0])+'.'+IntToStr(IPb[1])+'.'+IntToStr(IPb[2])+'.'+IntToStr(IPb[3]), ntohs(RedirrectPort)]));
  thisTunel.CriticalSectionC.Leave;
  if not ConnectToServer(thisTunel.clientsocket, RedirrectPort, RedirrectIP) then
  begin
    SetEvent(thisTunel.ConnectOrErrorEvent); //разрешаем сдвинутся с места в сервербоди
    EndThread(0);
  end;

  if isSocks5 then
  begin
    socks5ok:=#5#0#0#1#$7f#0#0#1#0#0;
    send(thisTunel.serversocket, socks5ok[1], Length(socks5ok), 0);
  end;

  thisTunel.CriticalSectionC.Enter;
  thisTunel.sendNewAction(Ttunel_Action_connect_client);
  thisTunel.CriticalSectionC.Leave;
  
  thisTunel.TunelWork := true;
  SetEvent(thisTunel.ConnectOrErrorEvent); //разрешаем сдвинутся с места в сервербоди
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  AccumulatorLen := 1;
  LastResult := recv(thisTunel.clientsocket, StackAccumulator[0], 1, 0);//Читаем ПЕРВЫЙ байт чтобы задать значение
  
  if LastResult > 0 then
    thisTunel.AddToRawLog(PCK_GS_ToClient, StackAccumulator[0], LastResult);
      
  While (LastResult > 0) and (thisTunel.clientsocket <> -1) do
  begin //Читаем пока не отвалимся
    //Сколько еще в буфере ?!
    ioctlsocket(thisTunel.clientsocket, FIONREAD, Longint(BytesInStack));
    if BytesInStack = 0 then
      BytesInStack := 1;

    LastResult := recv(thisTunel.clientsocket, StackAccumulator[AccumulatorLen], BytesInStack, 0);//Читаем 1 байт или весь буффер сразу
    if LastResult > 0 then
    begin
    thisTunel.AddToRawLog(PCK_GS_ToClient, StackAccumulator[AccumulatorLen], LastResult);
    inc(AccumulatorLen, LastResult);

    if not thisTunel.EncDec.Settings.isNoProcessToClient then
      begin
        if AccumulatorLen >= 2 then
          begin //В акумуляторе данных на 2+ байтикоф
            //читаем длину
            curPacket.PacketAsCharArray := StackAccumulator;
            //Хватит ли в акамуляторе данных для пакета ?
              while (AccumulatorLen >= curPacket.Size) and (AccumulatorLen >= 2) and (curPacket.Size > 0) do
                begin
                  //дергаем пакет с акамулятора
                  if curPacket.Size = 0 then
                  begin
                    {Ахтунг! пакет! с нулевой длиной!
                    это озачает что траффиг криптован и мы его не разобрали!
                    по большому счету можно просто уведомить юзверя и дисконекнуть.. но.. мы продолжим работать..
                    будем считать что у пакета длина = длина данных в акуме}
                    curPacket.Size := AccumulatorLen;
                  end;

                  //смещаем и уменьшаем длину акумулятора
                  move(StackAccumulator[curPacket.Size], StackAccumulator[0], AccumulatorLen-curPacket.Size);
                  //CopyMemory(@StackAccumulator[curPacket.Size], @StackAccumulator[0], AccumulatorLen-curPacket.Size);
                  dec(AccumulatorLen,curPacket.Size);
                  thisTunel.CriticalSectionC.Enter;
                  thisTunel.EncDec.Packet.PacketAsByteArray := curPacket.PacketAsByteArray;
                  thisTunel.EncDec.DecodePacket(PCK_GS_ToClient);
                  //тут можно встроить доп обработку.
                  //пакет уже прошел декод скрипты и обработку встроеную в пх.

                  thisTunel.EncDec.EncodePacket(PCK_GS_ToClient);
                  curPacket.PacketAsByteArray := thisTunel.EncDec.Packet.PacketAsByteArray;
                  thisTunel.CriticalSectionC.Leave;
                  send(thisTunel.serversocket, curPacket, curPacket.Size, 0);

                  //повторно загоняем пакет. для вайла
                  if AccumulatorLen >= 2 then
                  //повторно загоняем пакет. для вайла
                  curPacket.PacketAsCharArray := StackAccumulator
                  else curPacket.Size := 0;                  
                end;
          end; // if AccumulatorLen >= 2 then
      end //if not thisTunel.EncDec.Settings.isNoDecryptToServer then
    else //не надо декодить. просто шлем.
      begin
        send(thisTunel.serversocket, StackAccumulator[0], AccumulatorLen, 0);
        AccumulatorLen := 0;
      end;
    end;
  end;//While LastResult <> SOCKET_ERROR do
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  thisTunel.CriticalSectionC.Enter;
  AddToLog(Format(rsTunelClientDisconnect, [integer(pointer(thisTunel))]));

  thisTunel.sendNewAction(Ttunel_Action_disconnect_client);

  //не разрываем связь если отключен сервер и noFreeOnServerDisconnect
  //Интересно.. а так можно сделать ? -)
  thisTunel.Visual.ThisOneDisconnected;
  //
  thisTunel.CriticalSectionC.Leave;
  while thisTunel.noFreeAfterDisconnect do Sleep(1);

  //закрываем сокеты
  DeinitSocket(thisTunel.serversocket,WSAGetLastError);
  DeinitSocket(thisTunel.clientsocket,WSAGetLastError);
  thisTunel.TunelWork := false;

end;
end;




function TSocketEngine.initSocket(var hSocket: TSocket; Port: Word; IP: String): Boolean;
var
  Addr_in: sockaddr_in;
begin
  Result:=False;
  // создаем сокет
  hSocket := socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  if hSocket = INVALID_SOCKET then
  begin
    DeInitSocket(hSocket, WSAGetLastError);
    Exit;
  end;
  FillChar(Addr_in, SizeOf(sockaddr_in), 0);
  Addr_in.sin_family:= AF_INET;
  // указываем за каким интерфейсом будем следить
  Addr_in.sin_addr.s_addr := inet_addr(PChar(IP));
  Addr_in.sin_port := HToNS(Port);
  // связываем сокет с локальным адресом
  if bind(hSocket, Addr_in, SizeOf(sockaddr_in)) <> 0 then  //ошибка, если больше нуля
  begin
    DeInitSocket(hSocket, WSAGetLastError);
    Exit;
  end;
  Result:=True;
end;

constructor TSocketEngine.create;
begin
  isSocks5 := false;
  isServerTerminating := false;
  tunels := TList.Create;
end;

destructor TSocketEngine.destroy;
var
  i : integer;
begin
  SuspendThread(hServerListenThread);
  i := 0;
  while i < tunels.Count do
    begin
      Ttunel(tunels.Items[i]).Destroy;
      inc(i);
    end;
  tunels.Destroy;
  TerminateThread(hServerListenThread, 0);
  WSACleanup;
  inherited;
end;


Procedure TSocketEngine.StartServer;
begin
if not (WSAStartup(WSA_VER, WSA) = NOERROR) then
  begin
    sendMSG(Format(rsTsocketEngineError,[SysErrorMessage(WSAGetLastError)]));
    exit;
  end;

hServerListenThread := BeginThread(nil, 0, @ServerListen, self, 0, idServerListenThread);
ResumeThread(hServerListenThread);
end;

procedure TSocketEngine.sendNewAction(Action: integer);
begin
    NewAction(action, Self);
end;

procedure TSocketEngine.sendMSG(MSG: string);
begin
  sLastMessage := MSG;
  sendNewAction(TSocketEngine_Action_MSG);
end;

function TSocketEngine.WaitClient(var hSocket, NewSocket: TSocket): Boolean;
var
  Addr_in: sockaddr_in;
  AddrSize: Integer;
begin
  Result:=False;
  if listen(hSocket, 1)<>0 then
  begin
    DeInitSocket(hSocket, WSAGetLastError);
    Exit;
  end;
  FillChar(Addr_in,SizeOf(sockaddr_in), 0);
  Addr_in.sin_family:=AF_INET;
  Addr_in.sin_addr.s_addr:=inet_addr(PChar('0.0.0.0'));
  Addr_in.sin_port:=HToNS(0);
  AddrSize:=SizeOf(Addr_in);
  while not isServerTerminating do
  begin
    if WaitForData(hSocket, 5000) then
    begin
      NewSocket:=accept(hSocket, @Addr_in, @AddrSize);
      break;
    end;
  end;
  if NewSocket>0 then Result:=True;
  if not Result then
  begin
    DeInitSocket(hSocket,WSAGetLastError);
    DeInitSocket(NewSocket,WSAGetLastError);
  end;
end;
function TSocketEngine.WaitForData(Socket: TSocket;  Timeout: Integer): Boolean;
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

function TSocketEngine.AuthSocks5(var sock:integer; var srvIP: Integer; var srvPort: Word): Boolean;
var
  buf: string;
  i: Integer;
  authOk: Boolean;
  p: PHostEnt;
begin
  Result:=False;
  // получаем версию прокси и количество поддерживаемых методов авторизации
  SetLength(buf,2);
  if(not GetSocketData(sock,buf[1],2))or(buf[1]<>#5)then
  begin
    DeInitSocket(sock,WSAGetLastError);
    Exit;
  end;

  // получаем поддерживаемые клиентом методы авторизации
  SetLength(buf,2+Byte(buf[2]));
  if(not GetSocketData(sock,buf[3],Byte(buf[2])))then
  begin
    DeInitSocket(sock,WSAGetLastError);
    Exit;
  end;
  authOk:=False;
  for i:=3 to Length(buf) do if buf[i]=#0 then authOk:=True;

  if not authOk then
  begin
    DeInitSocket(sock,WSAGetLastError);
    Exit;
  end;

  // говорим что авторизация не требуется
  buf:=#5#0;
  send(sock,buf[1],2,0);

  // получаем запрос на подключение
  SetLength(buf,4);
  if(not GetSocketData(sock,buf[1],4))
  or(buf[1]<>#5) // проверяем версию протокола
  or(buf[2]<>#1) // проверяем команду CMD = CONNECT
  then
  begin
    DeInitSocket(sock,WSAGetLastError);
    Exit;
  end;

  if(buf[4]=#1)then
  begin          // если коннект по IP
    GetSocketData(sock,srvIP,4);
    GetSocketData(sock,srvPort,2);
    Result:=True;
  end else if(buf[4]=#3)then
  begin // если по доменному имени
    i:=0;
    GetSocketData(sock,i,1);
    SetLength(buf,i);
    GetSocketData(sock,buf[1],i);
    GetSocketData(sock,srvPort,2);
    p:=GetHostByName(PChar(buf));
    srvIP:=PInAddr(p.h_addr_list^)^.S_addr;
    Result:=True;
  end;
end;

function TSocketEngine.GetSocketData(Socket: TSocket; var Data;
  const Size: Word): Boolean;
var
  Position: Word;
  Len: Integer;
  DataB: array[0..$5000] of Byte absolute Data;
begin
  Result:=False;
  Position:=0;
  while Position<Size do
  begin
    Len:=recv(Socket,DataB[Position],1,0);
    if Len<=0 then Exit;
    Inc(Position, Len);
  end;
  Result:=True;
end;

function TSocketEngine.ConnectToServer(var hSocket: TSocket; Port: Word;
  IP: Integer): Boolean;
var
  Addr_in: sockaddr_in;
begin
  Result:=False;
  Addr_in.sin_family:=AF_INET;
  Addr_in.sin_addr.S_addr:=IP;
  Addr_in.sin_port:=Port;
  if connect(hSocket,Addr_in,SizeOf(Addr_in))=0 then Result:=True;
  if not Result then begin
    DeInitSocket(hSocket,WSAGetLastError);
  end;

end;

procedure TSocketEngine.destroyDeadTunels;
var
  i: integer;
begin
  if not Assigned(tunels) then exit;
  i := 0;
  while i < tunels.Count do
  begin
    if Ttunel(tunels.Items[i]).MustBeDestroyed then
    begin
      Ttunel(tunels.Items[i]).destroy;
      break;//будем убивать по одному. раз в 20 мс.
    end
    else
    inc(i);
  end;
end;

procedure TSocketEngine.NewAction(Action: byte; Caller: TObject);
begin
SendMessage(L2PacketHackMain.Handle,WM_NewAction,integer(action),integer(caller));
end;

{ Ttunel }

constructor Ttunel.create;
begin
  active := false;
  TSocketEngine(SockEngine).tunels.Add(self);
  isRawAllowed := GlobalRawAllowed;
  CriticalSectionS := TCriticalSection.Create;
  CriticalSectionC := TCriticalSection.Create;
  AddToLog(Format(rsTunelCreated, [integer(pointer(Self))]));
  TunelWork := false;
  noFreeAfterDisconnect := GlobalNoFreeAfterDisconnect;
  MustBeDestroyed := false;
  cursockengine := SockEngine;
  EncDec := TencDec.create;
  EncDec.ParentTtunel := Self;
  EncDec.ParentLSP := nil;
  EncDec.Settings := GlobalSettings;
  RawLog := TMemoryStream.Create;
end;

destructor Ttunel.destroy;
var
  i: integer;
begin
  if not Assigned(TSocketEngine(curSockEngine).tunels) then exit;
  i := 0;
  while i < TSocketEngine(curSockEngine).tunels.Count do
  begin
    if Ttunel(TSocketEngine(curSockEngine).tunels.Items[i]) = self then
    begin
      TSocketEngine(curSockEngine).tunels.Delete(i);
      break;
    end;
    inc(i);
  end;

  AddToLog(Format(rsTunelDestroy, [integer(pointer(Self))]));
  if Assigned(encdec) then EncDec.destroy;
  if assigned(curSockEngine) then TSocketEngine(curSockEngine).DeinitSocket(serversocket,WSAGetLastError);
  if assigned(curSockEngine) then TSocketEngine(curSockEngine).DeinitSocket(clientsocket,WSAGetLastError);
  if hServerThread <> 0 then TerminateThread(hServerThread, 0);
  if hClientThread <> 0 then TerminateThread(hClientThread, 0);
  sendNewAction(Ttulel_action_tunel_destroyed);
  CriticalSectionS.Destroy;
  CriticalSectionC.Destroy;
  RawLog.Destroy;
  inherited;
end;

procedure Ttunel.NewAction(action: byte; Caller: TObject);
begin
  SendMessage(L2PacketHackMain.Handle,WM_NewAction,integer(action),integer(caller));
end;

procedure Ttunel.NewPacket(FromServer: boolean; Caller: TObject);
begin
  SendMessage(L2PacketHackMain.Handle,WM_NewPacket,integer(FromServer),integer(Caller));
end;

procedure Ttunel.RUN;
begin
  //устанавливаем идентификатор, передаем указатели на невхор, передаем события.
  EncDec.Ident := serversocket;
  EncDec.onNewAction := NewAction;
  EncDec.init;
  EncDec.onNewPacket := NewPacket;//TSocketEngine(curSockEngine).onNewPacket;
  //Стартуем поток обрабатывающий данные к серверу
  hServerThread := BeginThread(nil, 0, @ServerBody, self, 0, idServerThread);
  ResumeThread(hServerThread);
  AddToLog(Format(rsTunelRUN, [integer(pointer(Self)), EncDec.Ident]));
  sendNewAction(Ttulel_action_tunel_created);
end;

procedure Ttunel.EncryptAndSend(Packet: Tpacket; ToServer: Boolean);
var
  sSendTo : TSocket;
begin
EncDec.Packet := Packet;
if ToServer then
  begin
    EncDec.EncodePacket(PCK_GS_ToServer);
    sSendTo := clientsocket;
  end
  else
  begin
    EncDec.EncodePacket(PCK_GS_ToClient);
    sSendTo := serversocket;
  end;
Packet := EncDec.Packet;
Send(sSendTo, Packet, packet.Size, 0);
end;

procedure Ttunel.SendNewAction(action: byte);
begin
  NewAction(Action, self)
end;

procedure Ttunel.AddToRawLog(dirrection: byte; var data; size: word);
var
  dtime: Double;
begin
  if not isRawAllowed then exit;
  RawLog.WriteBuffer(dirrection,1);
  RawLog.WriteBuffer(size,2);
  dtime := now;
  RawLog.WriteBuffer(dtime,8);
  RawLog.WriteBuffer(data,size);
end;

end.
