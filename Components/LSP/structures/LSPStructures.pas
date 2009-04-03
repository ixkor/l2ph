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
  Action_sendtoserver = 5;
  Action_closesocket = 7;

  //события
  WM_action = $04F0;               

type

  //буффер.
  Tbuffer = array [0..$FFFF] of Byte;

  //Основная шаред структура
  TShareMapMain = record
    ReciverHandle : Thandle;  //Сюда - хендл нашего приемника
    ProcessesForHook : string[100];  //сюда - те процессы в которых нужно перехватывать функции.
  end;
  PShareMapMain = ^TShareMapMain;

  //Шаред структура клиентов
  TShareMapClient = record
    ReciverHandle : Thandle; //куда будет слать основное приложение уведомления
    ip : string[15];  //куда соединился сокет (только инфо. управления нет.)
    port : Cardinal;  //на какой порт
    application:string[255]; //что за приложение
    pid: Cardinal; //pid процесса
    Buff: Tbuffer;    //буффер для обмена ланными с основным приложением
    buffersize : cardinal; //размер этого буфера
    toclientbuffer: //временный буфер. используется при sendtoclient
    record
      Buff: Tbuffer; // Содержимое буффера
      buffsize: byte;
    end;
    ignorenextsend:boolean; //флаг, используется в WSPSend и при
    hookithandle : thandle; //хендл мьютекса уведомляющего о том что данное соединение следует перехватывать.
  end;
  
  PShareMapClient = ^TShareMapClient;

  TshareClient =
    record
      SocketNum : cardinal;  //сокет
      MapData  : PShareMapClient;  //указатель на шареддату
      MapHandle: THandle;  //хендл шареддаты
    end;

  TshareMain =
    record
      MapData : PShareMapMain; //блаблабла
      MapHandle : THandle; //ляляля. -)
    end;
    
implementation

end.
