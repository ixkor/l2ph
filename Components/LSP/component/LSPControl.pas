unit LSPControl;

interface

uses LSPInstalation, LSPStructures, windows, messages, sysutils, Classes, SyncObjs;

const
  LSP_Install_success = 1;
  LSP_Already_installed = 2;
  LSP_Uninstall_success = 3;
  LSP_Not_installed = 4;
  LSP_Install_error = 5;
  LSP_UnInstall_error = 6;
  LSP_Install_error_badspipath = 7;


resourcestring
  rsLSP_Install_success = 'LSP успешно зарегистрирован.';
  rsLSP_Already_installed = 'LSP модуль зарегистрирован в системе';
  rsLSP_Uninstall_success = 'Регистрация LSP модуля успешно снята';
  rsLSP_Not_installed = 'LSP модуль не зарегистрирован';
  rsLSP_Install_error = 'Ошибка при регистрации LSP модуля. (нет прав доступа к веткам реестра?)';
  rsLSP_UnInstall_error = 'Ошибка при снятия регистрации LSP модуля. (нет прав доступа к веткам реестра?)';
  rsLSP_Install_error_badspipath = 'Неверно указан путь к LSP модулю, необходим абсолютный путь,'#13#10'             либо наличие библиотеки LSP модуля в SYSTEM32';

type
  tOnSendOrRecv = procedure (SocketNum : cardinal; var buffer : Tbuffer; var len : cardinal) of object;
  tOnConnect = procedure (SocketNum : cardinal; ip:string; port:cardinal; exename:string; pid:cardinal; hook:boolean) of object;
  tOnDisconnect = procedure (SocketNum : cardinal) of object;
  tLspModuleState = procedure (state : byte) of object;

  TLSPModuleControl = class(TComponent)
  private
    fOnRecv,fOnSend: tOnSendOrRecv;
    fOnConnect:tOnConnect;
    fOnDisconnect:tOnDisconnect;
    fPathToLspModule : string;
    fLookFor:string;
    fonLspModuleState : tLspModuleState;
    fWasStarted : boolean; //true - Было стартовано успешно, можно освобождать.
    ShareClient : array[0..255] of TshareClient;
    ClientCount : integer;
    ShareMain : TshareMain;

    ReciverMEssageProcessThreadId: DWORD;
    ReciverMEssageProcessThreadHandle: THandle;
    ReciverWndClass:TWndClassEx; //окошко, через которое основное приложение нас будет уведомлять о новых данных... точнее класс окна.
    MutexHandle : THandle;

    Function setbuffer(SocketNum : cardinal; buffer : Tbuffer; len : word):integer;
    function FindIndexBySocketNum(SocketNum : cardinal):integer;
    Function CreateReciverWnd: Thandle;
    Procedure addclient(SocketNum : cardinal);
    Procedure deleteclient(SocketNum: cardinal);
    Procedure clientsend(SocketNum : cardinal);
    Procedure clientrecv(SocketNum : cardinal);
    procedure setlookfor(newLookFor:string);
    function isLspinstalled:boolean;

  public
    TmpBuff: Tbuffer;
    Function SendToServer(SocketNum : cardinal; buffer : Tbuffer; len : word):boolean;
    Function SendToClient(SocketNum : cardinal; buffer : Tbuffer; len : word):boolean;
    Procedure CloseSocket(SocketNum : cardinal);
    Procedure setlspstate(state: boolean);

  published
    property WasStarted:boolean read fWasStarted;
    property PathToLspModule:string read fPathToLspModule write fPathToLspModule;
    property isLspModuleInstalled:boolean read islspinstalled;
    
    property LookFor:string read fLookFor write setlookfor;
    property onLspModuleState:tLspModuleState read fonLspModuleState write fonLspModuleState;
    property onConnect:tOnConnect read fOnConnect write fOnConnect;
    property onDisconnect:tOnDisconnect read fOnDisconnect write fOnDisconnect;
    property onRecv:tOnSendOrRecv read fOnRecv write fOnRecv;
    property onSend:tOnSendOrRecv read fOnSend write fOnSend;
    constructor Create(AOwner: TComponent); override;
    destructor destroy; override;
  end;

  Tbuffer = array [0..$FFFF] of Byte;
var
  this_component : TLSPModuleControl;
  cs : RTL_CRITICAL_SECTION;
  Mmsg: MSG;  //сообщение

procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('LSP', [TLSPModuleControl]);
end;



// Процедура обработки сообщений
function WindowProc (wnd: HWND; msg: integer; wparam: WPARAM; lparam: LPARAM):LRESULT;STDCALL;
begin

  result := 0;
  case msg of
  WM_action:
  begin
    case lparam of
    Action_client_connect:
      this_component.addclient(wparam);
    Action_client_disconnect:
      this_component.deleteclient(wparam);
    Action_client_send:
      this_component.clientsend(wparam);
    Action_client_recv:
      this_component.clientrecv(wparam);
  end;
  end;
  else
    Result := DefWindowProc(wnd,msg,wparam,lparam);
  end;
end;


procedure pReciverMessageProcess;
begin
  // Цикл обработки сообщений}
  while GetMessage (Mmsg,0,0,0) do
  begin
    TranslateMessage (Mmsg);
    DispatchMessage (Mmsg);
  end;
end;

Function TLSPModuleControl.CreateReciverWnd;
begin
 //Вот тут мы создаем окошко.
  ReciverWndClass.cbSize := sizeof (ReciverWndClass);
  with ReciverWndClass do
  begin
    lpfnWndProc := @WindowProc;
    cbClsExtra := 0;
    cbWndExtra := 0;
    hInstance := HInstance;
    lpszMenuName := nil;
    lpszClassName := Apendix;
  end;
  RegisterClassEx (ReciverWndClass);
  // Создание окна на основе созданного класса
  result := CreateWindowEx(0, Apendix, Apendix, WS_OVERLAPPEDWINDOW,0,0,0,0,0,0,Hinstance,nil);
end;

constructor TLSPModuleControl.create;
begin
  inherited Create(AOwner);
  fWasStarted := false; //мы еще не стартовали.
  if csDesigning in self.ComponentState then exit;
  InitializeCriticalSection(cs);
  EnterCriticalSection(cs);
  //создаем мютекс говорящий всем нашим клиентам что основное приложение - работает.
  MutexHandle := CreateMutex(nil, False, Mutexname);

  If (GetLastError = ERROR_ALREADY_EXISTS) then
    begin
      //Мы уже существуем....
      LeaveCriticalSection(cs);
      MessageBox(0, 'Другой экземпляр TLSPModuleControl уже существует.'#10#13+
                    'новый экземляр не может быть создан.', 'TLSPModuleControl', MB_OK);
      exit;
    end;

  ClientCount := 0;//изначально считается что у нас ноль клиентов

  //Создаем мапфайл.
  ShareMain.MapHandle := CreateFileMapping(INVALID_HANDLE_VALUE, nil,
        PAGE_READWRITE, 0, SizeOf(TShareMapMain), Apendix);
  if ShareMain.MapHandle = 0 then
  ShareMain.MapHandle := OpenFileMapping(PAGE_READWRITE, false, Apendix);
  ShareMain.MapData := MapViewOfFile(ShareMain.MapHandle, FILE_MAP_ALL_ACCESS,
        0, 0, SizeOf(TShareMapMain));

  if ShareMain.MapHandle = 0 then
    begin
      setlspstate(false);
      MessageBox(0, 'Невозможно получить доступ к общему участку памяти.'#10#13+
                    'Регистрация LSP провайдера автоматически снята'#10#13+
                    'Перезагрузите машину.', 'TLSPModuleControl', MB_OK);
      exit;    
    end;
  //Создаем приемник.
  ShareMain.MapData^.ReciverHandle := CreateReciverWnd;

  //Создаем Поток, который будет обрабатывать сообщения от приемника
  ReciverMessageProcessThreadHandle := CreateThread(nil, 0, @pReciverMessageProcess, nil, 0, ReciverMEssageProcessThreadId);
  ResumeThread(ReciverMEssageProcessThreadHandle);

  //Указываем в каких приложениях стоит перехватывать
  ShareMain.MapData^.ProcessesForHook := flookfor;
  fWasStarted := true; //Мы стартовали успешно.
  LeaveCriticalSection(cs);
  this_component := self;
end;

destructor TLSPModuleControl.destroy;
begin
  if WasStarted then
    begin
      ReleaseMutex(MutexHandle); //жгем напалмом. (мы уже не работаем).
      CloseHandle(MutexHandle);
      TerminateThread(ReciverMEssageProcessThreadHandle, 0); //Рубаем нить с обработкой сообщений
      DestroyWindow(ShareMain.MapData^.ReciverHandle); //убиваем окно рецивера
      ShareMain.MapData^.ReciverHandle := 0;
      windows.UnregisterClass(apendix, HInstance);
    end;
  inherited destroy;
end;


procedure TLSPModuleControl.addclient;
var
  hook:boolean;
begin
  //Идентификатор
  ShareClient[ClientCount].SocketNum := SocketNum;

  //подключаем мапфайл для клиента (должен быть создан в длл)
  ShareClient[ClientCount].MapHandle := CreateFileMapping(INVALID_HANDLE_VALUE, nil,
        PAGE_READWRITE, 0, SizeOf(TShareMapClient), pchar(Apendix + inttostr(SocketNum)));
  ShareClient[ClientCount].MapData := MapViewOfFile(ShareClient[ClientCount].MapHandle, FILE_MAP_ALL_ACCESS,
        0, 0, SizeOf(TShareMapClient));
  hook := true;
  if assigned(onConnect) then
    onConnect(SocketNum, ShareClient[ClientCount].MapData^.ip, ShareClient[ClientCount].MapData^.port,ShareClient[ClientCount].MapData^.application,ShareClient[ClientCount].MapData^.pid,hook);
  //надо ловить этот конект ?
  if hook then
  begin
    //если да - создаем мьютекс и увеличиваем кол--во юзверей на 1.
    ShareClient[ClientCount].MapData.hookithandle := CreateMutex(nil, false, pchar(Mutexname+inttostr(SocketNum)));

    //увеличиваем кол-во юзверей на 1.
    Inc(ClientCount);
  end
  else //не надо ? затираем ссылку на мапфайл. хендл и сокетнум.
  begin
    ShareClient[ClientCount].MapData := nil;
    ShareClient[ClientCount].MapHandle := 0;
    ShareClient[ClientCount].SocketNum := 0;
  end;
end;

procedure TLSPModuleControl.deleteclient;
var
  i : integer;
begin
  i := 0;
  //бежим пока не находим наш sockid; или не находим -)
  while (i < ClientCount) and (ShareClient[i].SocketNum <> SocketNum) do
    inc(i);

  if i = ClientCount then //не нашли -)... чертовщина какаято.. -)
    exit;

  //освобождаем мьютекс
  if ShareClient[i].MapData <> nil then
    begin
    ReleaseMutex(ShareClient[i].MapData.hookithandle);
    CloseHandle(ShareClient[i].MapData.hookithandle)
    end;

  //Ставим позицию чуть чуть дальше
  inc(i);

  //и затираем наш отключившийся клиент.
  while i < ClientCount do
    begin
      ShareClient[i-1] := ShareClient[i];
      inc(i);
    end;
  ShareClient[ClientCount].MapData.hookithandle := CreateMutex(nil, false, pchar(Mutexname+inttostr(SocketNum)));

  if assigned(onDisconnect) then
    onDisconnect(SocketNum);
        
  // -1 пользователь
  Dec(ClientCount);
end;

function TLSPModuleControl.FindIndexBySocketNum;
begin
  result := 0;
  //бежим пока не находим наш sockid; или не находим -)
  while (result < ClientCount) and (ShareClient[result].SocketNum <> SocketNum) do
    inc(result);

  if Result = ClientCount then Result := -1;

end;

procedure TLSPModuleControl.clientrecv(SocketNum: cardinal);
var
  index : integer;
begin
  index := FindIndexBySocketNum(SocketNum);
  if index = -1 then exit; //а это кто еще шлет!?..а? наафиг!!!

  if Assigned(onRecv) then
    onRecv(SocketNum, ShareClient[index].MapData^.buff, ShareClient[index].MapData^.buffersize);

  //данные обработаны. у нас есть еще один нюанс.

{    if (ShareClient[index].MapData^.toclientbuffer.buffsize > 0) then
      try
        //надо бы сместить данные в уже обработаном буфере на
        offset := ShareClient[index].MapData^.toclientbuffer.buffsize;
        //в текущем буфере размером
        cursize := ShareClient[index].MapData^.buffersize;
        //при этом буффер станет размером
        inc(ShareClient[index].MapData^.buffersize, offset);
        //а добавочный буфер станет длинной в ноль
        ShareClient[index].MapData^.toclientbuffer.buffsize := 0;

      //двигаем на офсет
        move(ShareClient[index].MapData^.Buff[0],
             ShareClient[index].MapData^.Buff[offset],
             cursize);

        //и в начало буфера добавятся данные
        move(ShareClient[index].MapData^.toclientbuffer.Buff[0],
             ShareClient[index].MapData^.Buff[0],
             offset);
      except
      end     }
end;

procedure TLSPModuleControl.clientsend(SocketNum: cardinal);
var
  index : integer;
begin
  index := FindIndexBySocketNum(SocketNum);
  if index = -1 then exit; //а это кто еще шлет!?.. наааааафиг пошел!!!
  if Assigned(onSend) then
    onSend(SocketNum, ShareClient[index].MapData^.buff, ShareClient[index].MapData^.buffersize);
end;

//Отправляем данные от имени клиента использующего указаный номер сокета
function TLSPModuleControl.SendToServer;
var
  index : integer;
begin
  index := setbuffer(SocketNum, buffer, len);
  Result := (index >= 0);
  if not Result then
    exit;

  SendMessage(ShareClient[index].MapData^.ReciverHandle, WM_action, SocketNum, Action_sendtoserver);
end;

//Отправляем данные клиенту использующему указаный номер сокета
function TLSPModuleControl.SendToClient;
var
  index : integer;
begin
  index := FindIndexBySocketNum(SocketNum);
  Result := (index >= 0);
  if not Result then
    exit;

  //Добавляем в акамулятор наши данные
  Move(buffer, ShareClient[index].MapData^.toclientbuffer.Buff[ShareClient[index].MapData^.toclientbuffer.buffsize], len);
  //и увеличиваем их длину
  inc(ShareClient[index].MapData^.toclientbuffer.buffsize, len);
end;

//Записываем буффер в мапфайл закрепленный за определенным номером сокета
function TLSPModuleControl.setbuffer;
begin
  result := FindIndexBySocketNum(SocketNum);
  if Result = -1 then exit;

  FillChar(ShareClient[result].MapData^.Buff, $ffff, #0);
  CopyMemory(
    @ShareClient[result].MapData^.Buff[0],
    @buffer[0],
    len);
    
  ShareClient[result].MapData^.buffersize := len;
end;

procedure TLSPModuleControl.setlookfor(newLookFor: string);
begin
fLookFor := newLookFor;
if ShareMain.MapData <> nil then
  ShareMain.MapData^.ProcessesForHook := flookfor;
end;

function TLSPModuleControl.islspinstalled: boolean;
begin
result := isinstalled;
end;

Procedure TLSPModuleControl.setlspstate(state: boolean);
var
  result : byte;
begin
  if state then
    result := InstallProvider(fPathToLspModule)
  else
    result := RemoveProvider;

if assigned(onLspModuleState) then
  onLspModuleState(result);

end;

procedure TLSPModuleControl.CloseSocket(SocketNum: cardinal);
var
 index: integer;
begin
  index := FindIndexBySocketNum(SocketNum);
  if index = -1 then exit;
  SendMessage(ShareClient[index].MapData^.ReciverHandle, WM_action, SocketNum, Action_closesocket);
end;

end.
