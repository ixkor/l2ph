unit LSPStructures;
interface
uses windows, JwaWinsock2;

const
  //а мне так захотелось... -)
  Apendix = '{27-06-22-78-28-31-94-8-30-50}';
  Mutexname = 'm' + Apendix;

  //акшины
  Action_client_connect = 1;
  Action_client_recv = 2;
  Action_client_send = 3;
  Action_client_disconnect = 4;
  Action_sendtoServer = 5;
  Action_sendtoClient = 6;
  Action_closesocket = 7;

  //события
  WM_action = $04F1;               

type

  //буффер.
  Tbuffer = array [0..$FFFF] of Byte;

  PShareMapMain = ^TShareMapMain;
  //Основная шаред структура
  TShareMapMain = record
    ReciverHandle : Thandle;  //Сюда - хендл нашего приемника
    ProcessesForHook : string[100];  //сюда - те процессы в которых нужно перехватывать функции.
  end;

  TSendRecvStruct = packed record
      exists:boolean;
      SockNum : integer;
      CurrentBuff: Tbuffer;
      CurrentSize : Word;
    end;

  TDisconnectStruct = packed record
      exists:boolean;
      SockNum : integer;
      lpErrno : integer;
    end;


  //общий участок памяти
  PTmemoryBuffer = ^TMemoryBuffer;

  TConnectStruct = packed record
    Exists:boolean;
    application:string[255]; //что за приложение
    pid: Cardinal; //pid процесса
    SockNum : integer;
    ip : string[15];  //куда соединился сокет
    port : Cardinal;  //на какой порт
    HookIt : boolean;
    reddirect:boolean;
    ReciverHandle : thandle;
    /////////////////
    MemBuf : PTmemoryBuffer;
    MemBufHandle : THandle;
  end;


  TMemoryBuffer = packed record
    ConnectStruct : TConnectStruct;
    DisconnectStruct: TDisconnectStruct;
    SendStruct, SendProcessed,
    RecvStruct, RecvProcessed,
    SendRecv : TSendRecvStruct;
  end;


  TClient = class(tobject)
      canWork:boolean;
      MemBuf : PTmemoryBuffer;
      MemBufHandle : THandle;
    /////////////////////////////
      SockNum : Integer;  //сокет
      ControlHandle : thandle;
      InRecv, inSend : boolean;
    end;

  TshareMain = record
      MapData : PShareMapMain; //блаблабла
      MapHandle : THandle; //ляляля. -)
    end;
 
implementation

end.
