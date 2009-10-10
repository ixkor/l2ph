unit usharedstructs;

interface
uses Classes;

const
  PCK_GS_ToServer = 4;
  PCK_GS_ToClient = 3;
  PCK_LS_ToServer = 2;
  PCK_LS_ToClient = 1;

type

  TEncDecSettings =
  record
    isChangeXor,
    isNoDecrypt,
    isNoProcessToClient,
    isNoProcessToServer,
    isKamael,
    isGraciaOff,
    isSaveLog,
    ShowLastPacket,
    HexViewOffset,
    isprocesspackets : boolean;
  end;

  {»спользуетс€ плагинами}

  PCodingClass =^TCodingClass;
  TCodingClass = class(TObject)
  public
    GKeyS,GKeyR:array[0..15] of Byte;
    procedure InitKey(const XorKey; Interlude: Boolean = False); Virtual; Abstract;   
    procedure DecryptGP(var Data; var Size: Word); Virtual; Abstract;
    procedure EncryptGP(var Data; var Size: Word); Virtual; Abstract;
    procedure PreDecrypt(var Data; var Size: Word); Virtual; Abstract;
    procedure PostEncrypt(var Data; var Size: Word); Virtual; Abstract;
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

  TCharArray = array[0..$FFFF] of AnsiChar;
  TCharArrayEx = array[0..$1FFFE] of AnsiChar; //2х

  PPacket = ^TPacket;  
  TPacket = packed record case Integer of
    0: (Size: Word;
        Data: array[0..$FFFD] of Byte);
    1: (PacketAsByteArray: array[0..$FFFF] of Byte);
    2: (PacketAsCharArray: TCharArray);
    3: (pckSize: Word;
        pckId: Byte;
        pckData: array[0..$FFFC] of Byte);
  end;


  TNewPacket = procedure(var Packet:tpacket;FromServer : boolean; Caller: TObject)  of object; // Caller это TencDec к примеру -> TencDec(caller).name вызывает акшин только TencDec 
  TNewAction = procedure (action : byte; Caller: TObject)  of object; //Caller зависит от action
  TStringArray = array of string;

  
  {экземпл€р этого класса (точнее его потомок) передаетс€ в плагины.}  
  TOnTimer = procedure(const param: Cardinal); stdcall;
  tConnectInfo = packed record
    ConnectID:integer;
    ConnectName:string[200];
  end;

  tConnectInfoEx = packed record  //»спользуетьс€ в ASL
    ConnectInfo : tConnectInfo;
    Valid : boolean;
  end;   

  PPluginStruct = ^TPluginStruct;
  TPluginStruct = class (tobject)
    private
    public
    userFormHandle: THandle;
    ConnectInfo : tConnectInfo;
    UserFuncs : tstringlist;
    function ReadC(const pck:string; const index:integer):byte; Virtual; Abstract;
    function ReadH(const pck:string; const index:integer):word; Virtual; Abstract;
    function ReadD(const pck:string; const index:integer):integer; Virtual; Abstract;
    function ReadQ(const pck:string; const index:integer):int64; Virtual; Abstract;
    function ReadF(const pck:string; const index:integer):double; Virtual; Abstract;
    function ReadS(const pck:string; const index:integer):string; Virtual; Abstract;

    function ReadCEx(const pck; const index:integer):byte; Virtual; Abstract;
    function ReadHEx(const pck; const index:integer):word; Virtual; Abstract;
    function ReadDEx(const pck; const index:integer):integer; Virtual; Abstract;
    function ReadQEx(const pck; const index:integer):int64; Virtual; Abstract;
    function ReadFEx(const pck; const index:integer):double; Virtual; Abstract;
    function ReadSEx(const pck; const index:integer):string; Virtual; Abstract;
    procedure WriteC(var pck: string; const v:byte;    ind:integer=-1); Virtual; Abstract;
    procedure WriteH(var pck: string; const v:word;    ind:integer=-1); Virtual; Abstract;
    procedure WriteD(var pck: string; const v:integer; ind:integer=-1); Virtual; Abstract;
    procedure WriteQ(var pck: string; const v:int64; ind:integer=-1); Virtual; Abstract;
    procedure WriteF(var pck: string; const v:double;  ind:integer=-1); Virtual; Abstract;
    procedure WriteS(var pck: string; const v:string;  ind:integer=-1); Virtual; Abstract;
    procedure WriteCEx(var pck; const v:byte;    ind:integer=-1); Virtual; Abstract;
    procedure WriteHEx(var pck; const v:word;    ind:integer=-1); Virtual; Abstract;
    procedure WriteDEx(var pck; const v:integer; ind:integer=-1); Virtual; Abstract;
    procedure WriteQEx(var pck; const v:int64; ind:integer=-1); Virtual; Abstract;
    procedure WriteFEx(var pck; const v:double;  ind:integer=-1); Virtual; Abstract;
    procedure WriteSEx(var pck; const v:string;  ind:integer=-1); Virtual; Abstract;

    Function SetScriptVariable(scriptid:integer; varname:string; varvalue:variant):boolean; Virtual; Abstract;
    Function GetScriptVariable(scriptid:integer; varname:string):variant; Virtual; Abstract;
    function CallScriptFunction(scriptid:integer; Name: String; Params: Variant; var error:string): Variant; Virtual; Abstract;
    
    function IsScriptIdValid(scriptid:integer):boolean; Virtual; Abstract;


    function CreateAndRunTimerThread(const interval, usrParam: Cardinal;
                                     const OnTimerProc: TOnTimer): Pointer; Virtual; Abstract;
    procedure ChangeTimerThread(const timer: Pointer; const interval: Cardinal;
                                const usrParam: Cardinal = $ffffffff;
                                const OnTimerProc: TOnTimer = nil); Virtual; Abstract;
    procedure DestroyTimerThread(var timer: Pointer); Virtual; Abstract;
    function StringToHex(str1,Separator:String):String; Virtual; Abstract;
    function HexToString(Hex:String):String; Virtual; Abstract;
    function DataPckToStrPck(var pck): string; Virtual; Abstract;
    procedure SendPacketData(var pck; const tid: integer; const ToServer: Boolean); Virtual; Abstract;
    procedure SendPacketStr(pck: string; const tid: integer; const ToServer: Boolean); Virtual; Abstract;
    procedure SendPacket(Size: Word; pck: string; tid: integer; ToServer: Boolean); Virtual; Abstract;
    
    function getConnectionName(id : integer):string; Virtual; Abstract;
    function getConnectioidByName(name : string):integer; Virtual; Abstract;
    Function GoFirstConnection:boolean; Virtual; Abstract;
    Function GoNextConnection:boolean; Virtual; Abstract; 
    procedure ShowUserForm(ActivateOnly:boolean);  Virtual; Abstract;
    Procedure HideUserForm;  Virtual; Abstract;
  end;

implementation



end.
