{
Модификация L2PacketHack 3.2.0 by CODERX.RU
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Принимали участие в написании кода:
  Xkor;
  NLObP;
  Wanick;
  QaK.
}
{ TODO 1 -cThreads -oNLObP : разобраться с правильностью создания/освобождения потоков }
{ DONE 1 -cThreads -oNLObP : надо найти, что-то два раза освобождается, после работы с клиентами, когда выходим из программы падает с ошибкой }
{ DONE 5 -cInterface -owanick : проверить правильность логики вкл/выкл кнопок на вкладке "скрипты" }
{ TODO 5 -cEditor -oNLObP : исправить find/replace - заменяет не текущее вхождение, а следующее }
{ TODO 5 -cEditor -owanick : есть TfsSyntaxMemo почему его не юзаем для скриптов? }
{ TODO 5 -owanick -cScripts :  Вынести все вспомогательные методы и функции в отдельную Dll если такое получится}
{ DONE 5 -oNLObP -cGeneral : возможность произвольных имен файлов для newxor и inject, значения берем из options.ini }
unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinSock, ToolWin, ImgList, Menus, Coding,
  IniFiles, advApiHook, ExtCtrls, ComCtrls, PSAPI, TlHelp32,
  CheckLst, Buttons, fs_iclassesrtti, fs_ipascal, Variants,
  fs_iinterpreter, fs_idialogsrtti, fs_iextctrlsrtti, fs_iformsrtti,
  AppEvnts, XorCoding, XPMan, fs_igraphicsrtti, ShellAPI, OleCtrls,
  ExtDlgs, mshtml, SHDocVw, JvComponentBase, JvAppHotKey, JvCaptionButton,
  JvXPCore, JvExStdCtrls, JvRichEdit, JvExControls, JvEditorCommon, JvEditor,
  JvHLEditor, JvUrlListGrabber, JvUrlGrabbers, JvHtmlParser, Mask, JvExMask,
  JvSpin, Wininet, JvTrayIcon, phxPlugins;

const
  //сообщения от потоков
  WM_Dll_Log = $04F0;               //получаем сообщение из inject.dll
  WM_ListBox3_Log = WM_APP+101;     //пишем в LisBox3
  WM_PrnPacket_Log = WM_APP+102;    //пишем в ListView5 +77
  WM_ExecuteScripts = WM_APP+103;   //выполняем скрипт  +45
  WM_SetConnect = WM_APP+104;       //
  WM_SetDisconnect = WM_APP+105;    //
  WM_UpdateComboBox1 = WM_APP+106;  //
  WM_ClearPacketsLog = WM_APP+107;  //
  WM_Finished = WM_APP+108;         //закрытие хэндла потока

type
  TL2PacketHackMain = class(TForm)
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    ApplicationEvents1: TApplicationEvents;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    XPManifest1: TXPManifest;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    Memo1: TMemo;
    fsScript1: TfsScript;
    fsPascal1: TfsPascal;
    fsClassesRTTI1: TfsClassesRTTI;
    fsGraphicsRTTI1: TfsGraphicsRTTI;
    fsFormsRTTI1: TfsFormsRTTI;
    fsExtCtrlsRTTI1: TfsExtCtrlsRTTI;
    fsDialogsRTTI1: TfsDialogsRTTI;
    ImageList2: TImageList;
    fsScript2: TfsScript;
    JvApplicationHotKey1: TJvApplicationHotKey;
    JvCaptionButton1: TJvCaptionButton;
    OpenDialog2: TOpenDialog;
    Timer2: TTimer;
    Panel12: TPanel;
    ComboBox1: TComboBox;
    Label13: TLabel;
    Label12: TLabel;
    ListBox3: TMemo;
    imgBT: TImageList;
    PageControl1: TPageControl;
    TabSheet5: TTabSheet;
    Panel2: TPanel;
    Label1: TLabel;
    ListBox1: TListBox;
    Panel20: TPanel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    LabeledEdit1: TLabeledEdit;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    ListBox2: TListBox;
    LabeledEdit2: TLabeledEdit;
    RadioGroup1: TRadioGroup;
    ChkNoDecrypt: TCheckBox;
    JvSpinEdit1: TJvSpinEdit;
    isKamael: TCheckBox;
    TabSheet4: TTabSheet;
    Panel15: TPanel;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    ListView1: TListView;
    TabSheet7: TTabSheet;
    ListView2: TListView;
    Panel17: TPanel;
    Button1: TButton;
    Button13: TButton;
    Panel23: TPanel;
    Panel4: TPanel;
    Splitter4: TSplitter;
    ListView5: TListView;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Memo2: TJvRichEdit;
    GroupBox6: TGroupBox;
    Memo3: TJvRichEdit;
    ToolBar1: TToolBar;
    tbtnSave: TToolButton;
    tbtnLoad: TToolButton;
    ToolButton1: TToolButton;
    tbtnClear: TToolButton;
    tbtnFilterDel: TToolButton;
    tbtnDelete: TToolButton;
    tbtnToSend: TToolButton;
    TabSheet3: TTabSheet;
    GroupBox7: TGroupBox;
    Memo4: TJvRichEdit;
    Panel10: TPanel;
    Splitter2: TSplitter;
    Memo8: TJvRichEdit;
    GroupBox9: TGroupBox;
    Memo5: TJvRichEdit;
    Panel11: TPanel;
    Label6: TLabel;
    Button11: TButton;
    Button12: TButton;
    Button21: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    CheckBox12: TCheckBox;
    Edit1: TEdit;
    ChkOnePacket: TCheckBox;
    TabSheet2: TTabSheet;
    Panel7: TPanel;
    Panel8: TPanel;
    GroupBox4: TGroupBox;
    GroupBox8: TGroupBox;
    Panel6: TPanel;
    Button2: TButton;
    Button6: TButton;
    Button8: TButton;
    Button3: TButton;
    JvHLEditor2: TJvHLEditor;
    TabSheet6: TTabSheet;
    Splitter3: TSplitter;
    Panel19: TPanel;
    ButtonCheckSyntex: TButton;
    Button18: TButton;
    ButtonLoadNew: TButton;
    ButtonSave: TButton; // кнопка сохранить
    GroupBox3: TGroupBox;
    ScriptsList: TCheckListBox;
    ButtonDelete: TButton;
    ButtonRename: TButton;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    Panel9: TPanel;
    Button9: TButton;
    Button10: TButton;
    JvHLEditor1: TJvHLEditor;
    TabSheet10: TTabSheet;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    Panel5: TPanel;
    Splitter5: TSplitter;
    Button4: TButton;
    Button5: TButton;
    CheckBox8: TCheckBox;
    Label5: TLabel;
    Memo7: TMemo;
    Memo6: TMemo;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    JvTrayIcon1: TJvTrayIcon;
    Splitter6: TSplitter;
    GroupBox2: TGroupBox;
    ChkXORfix: TCheckBox;
    isNewxor: TLabeledEdit;
    isInject: TLabeledEdit;
    iNewxor: TCheckBox;
    iInject: TCheckBox;
    tsPluginsTab: TTabSheet;
    GroupBox5: TGroupBox;
    clbPluginsList: TCheckListBox;
    Panel13: TPanel;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    btnRefreshPluginList: TButton;
    mPluginInfo: TMemo;
    clbPluginFuncs: TCheckListBox;
    nScripts: TMenuItem;
    nPlugins: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    Splitter7: TSplitter;
    isGraciaOff: TCheckBox;
    procedure isInjectChange(Sender: TObject);
    procedure isNewxorChange(Sender: TObject);
    procedure iInjectClick(Sender: TObject);
    procedure iNewxorClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure LabeledEdit2Change(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure LoadLibraryXor (const name: string);
    procedure LoadLibraryInject (const name: string);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CheckBox10Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure ListViewChange(Item: TListItem; Memo, memo2: TJvRichEdit);
    procedure Label12Click(Sender: TObject);
    procedure ButtonCheckSyntexClick(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure BtnSaveLogClick(Sender: TObject);
    function CallMethod(Instance: TObject; ClassType: TClass; const MethodName: String; var Params: Variant): Variant;
    procedure Button27Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    function Compile(var fsScript: TfsScript; var JvHLEditor: TJvHLEditor): Boolean;
    procedure RefreshScripts;
    procedure RefreshPrecompile(var fsScript: TfsScript);
    procedure Button28Click(Sender: TObject);
    procedure ScriptsListClickCheck(Sender: TObject);
    procedure ScriptsListClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure ListView5Click(Sender: TObject);
    procedure ListView5KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListView2Click(Sender: TObject);
    procedure ButtonRenameClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonLoadNewClick(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Memo6Change(Sender: TObject);
    procedure Memo7Change(Sender: TObject);
    procedure Memo4Change(Sender: TObject);
    procedure Memo4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RadioButton1Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure JvHLEditor1PaintGutter(Sender: TObject; Canvas: TCanvas);
    procedure JvHLEditor1Scroll(Sender: TObject);
    procedure JvHLEditor1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure JvHLEditor1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure JvHLEditor2Scroll(Sender: TObject);
    procedure JvHLEditor2PaintGutter(Sender: TObject; Canvas: TCanvas);
    procedure JvHLEditor2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure JvHLEditor2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button23Click(Sender: TObject);
    procedure BtnClearLogClick(Sender: TObject);
    procedure JvHLEditor1Change(Sender: TObject);
    procedure BtnToSendClick(Sender: TObject);
    procedure Memo4MouseEnter(Sender: TObject);
    procedure Memo4MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure JvSpinEdit1Change(Sender: TObject);
    procedure ChkXORfixClick(Sender: TObject);
    procedure isKamaelClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure LoadPktIni(s:string);
    procedure ChkNoDecryptClick(Sender: TObject);
    procedure Memo2DblClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Memo8DblClick(Sender: TObject);
    procedure btnRefreshPluginListClick(Sender: TObject);
    procedure clbPluginsListClick(Sender: TObject);
    procedure clbPluginsListClickCheck(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure LoadPacketsIni;
    procedure Memo2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Memo4KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Memo8KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Memo8MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Memo2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure isGraciaOffClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ReadMsg(var msg: TMessage); Message WM_Dll_Log;        //$04F0;
    procedure PacketSend(var msg: TMessage); Message WM_PrnPacket_Log;
//    procedure ExecuteScriptsMsg(var msg: TMessage); Message WM_ExecuteScripts;
    procedure ExecuteScripts(var msg: TMessage); Message WM_ExecuteScripts;
    procedure SetConnect(var msg: TMessage); Message WM_SetConnect;
    procedure SetDisconnect(var msg: TMessage); Message WM_SetDisconnect;
    procedure Log(var msg: TMessage); Message WM_ListBox3_Log;
    procedure UpdateComboBox1(var msg: TMessage); Message WM_UpdateComboBox1;
    procedure ClearPacketsLog(var msg: TMessage); Message WM_ClearPacketsLog;
    procedure ThreadFinished(var msg: TMessage); Message WM_Finished;
  end;
  pstr = ^string;

  procedure SendPacket(Size: Word; pck: string; tid: Byte; ToServer: Boolean);
  procedure SendPckStr(pck: string; const tid: Byte; const ToServer: Boolean);
  procedure SendPckData(var pck; const tid: Byte; const ToServer: Boolean); stdcall;

  //потоки
  procedure ServerListen(PSock: Pointer);
  procedure Server(Param: Pointer);
  procedure Client(Param: Pointer);

  procedure PacketProcesor(PacketData: array of Byte; SendSocket: TSocket; id, From: Byte);
  procedure GetMsgFromDLL(name:pchar;messageBuf:pointer;messageLen:dword;answerBuf:pointer;answerLen:dword); stdcall;
  procedure sendMSG (msg: String);

var
  L2PacketHackMain: TL2PacketHackMain;
  hid: Cardinal;
  //определяем потоки
  Thread: array of TThread;

  SLh,SLSock,SGh,SGSock,CurentIP: Integer;
  LCFree, LSFree, NoServer: Boolean;
  SLth: Cardinal;

  ThreadGid,MaxThr,CID: Byte;
  CurentPort, LPortConst:Word;

  PacketsINI, Options: TMemIniFile;
  Processes, PacketsNames, ItemsList, SysMsgIdList, SkillList,
  NpcIdList, ClassIdList, PacketsFromS, PacketsFromC: TStringList;
  _cid:integer;

  dllScr: Pointer;
  _cs, cs_send: RTL_CRITICAL_SECTION;
  Lib:THandle;
  CreateXorIn: Function(Value:PCodingClass):HRESULT; stdcall;
  CreateXorOut: Function(Value:PCodingClass):HRESULT; stdcall;
  startScript: TfsScript;

  FndOffset: integer; //смещение до найденного слова
  hexvalue: string; //для вывода HEX в расшифровке пакетов
  filterS, filterC: string; //строка фильтров

  //дублирование чекбоксов и прочие настройки
  //ОСНОВНОЕ
  //перехват,  пропуск.логин, не дешифр.траф.,обход см.ключа,список прог.,Камаель
  isIntercept, isPassLogin,   isNoDecryptTraf, isChangeXor,   isListProg,  isCamael: boolean;
  isHookMethod: integer;
  //способ внедрения(true-надежный/false-скрытый)
  isInjectMetod : boolean;
  //ПРОСМОТР
  isFromServer, isFromClient, isLock, isSaveLog: boolean;
  ProtocolVersion: word; //протокол линейки из c00=ProtocolVersion:h(psize)c(ID)d(ProtocolVersion)z(0256Instant)

  kId:integer; //коэфф преобразования NpcID
  //возможность изменить имя для dll
//  isNewxor, isInject: string;

  //раскрашиваем
  typ0: string;
  SelStart, SelLength: integer;
  SelAttributes: TColor;
  //считаем потоки
//  CountThread : integer;

implementation

uses StrUtils, Types, FindReplaceUnit, Helper;

{$R *.dfm}

procedure TL2PacketHackMain.ExecuteScripts(var msg: TMessage);
var
  i: Integer;
  FromServer: boolean;
  id: byte;
  pck_data: array[Word] of Byte;
begin
  FromServer:=Boolean(msg.LParamLo);
  id:=msg.LParamHi;
  SetCurrentDir(ExtractFilePath(ParamStr(0)));

  // обрабатываем плагинами
  // PS без пол литра даж не пытайтесь вникнуть что тут происходит :)
  Move(pstr(msg.WParam)^[1],pck_data[2],Length(pstr(msg.WParam)^));
  PWord(@pck_data[0])^:=Length(pstr(msg.WParam)^)+2;
  for i:=0 to High(Plugins) do with Plugins[i] do
    if Loaded and Assigned(OnPacket) then begin
      OnPacket(id,FromServer,pck_data);
      if PWord(@pck_data[0])^<3 then Break;
    end;
  if PWord(@pck_data[0])^>2 then begin
    SetLength(pstr(msg.WParam)^,PWord(@pck_data[0])^-2);
    Move(pck_data[2],pstr(msg.WParam)^[1],PWord(@pck_data[0])^-2);
  end else begin
    pstr(msg.WParam)^:='';
    Exit;
  end;

  for i:=0 to ScriptsList.Count-1 do begin
    if ScriptsList.Checked[i] then begin
      //по очереди посылаем всем включенным скриптам
      //EnterCriticalSection(_cs);
      Scripts[i].fsScript.Variables['pck']:=pstr(msg.WParam)^;
      Scripts[i].fsScript.Variables['ConnectID']:=id;
      Scripts[i].fsScript.Variables['ConnectName']:=Thread[id].Name;
      Scripts[i].fsScript.Variables['FromServer']:=FromServer;
      Scripts[i].fsScript.Variables['FromClient']:=not FromServer;
      //LeaveCriticalSection(_cs);
      Scripts[i].fsScript.Execute;
      pstr(msg.WParam)^:=Scripts[i].fsScript.Variables['pck'];
    end;
  end;
end;

procedure PacketProcesor(PacketData: array of Byte; SendSocket: TSocket; id, From: Byte);
var
  ii: Word;
  TimeStep: TDateTime; //TTime;
  CanSend, InitX: Boolean;
  a: packed record case Integer of
    0: (ab: Integer);
    1: (a,b: Word);
  end;
  Packet: record
    Size: Word;
    DataB: array[0..$FFFD] of Byte;
  end absolute PacketData;
  PacketC: record
    Size: Word;
    DataC: array[0..$FFFD] of Char;
  end absolute PacketData;
  PacketB: array[0..$FFFF] of Byte absolute PacketData;
  TimeStepB: array[0..7] of Byte;
  WStr: WideString;
  temp,tmp: string;
begin
  TimeStep:=Time;
  Move(TimeStep,TimeStepB,8);
  CanSend:=True;
  if (Packet.Size>2) then begin
    case From of
      {1,2: begin                     //от ЛС, к ЛС
        EnterCriticalSection(_cs);
        Thread[id].InitXOR:=False;
        //sendMSG('Пришёл пакет от/к ЛС, пропускаем...');
        LeaveCriticalSection(_cs);
      end;}
      1,3: begin                       //от ГС
        InitX:=Thread[id].InitXOR;
        EnterCriticalSection(_cs);
        Inc(Thread[id].pckCount);
        LeaveCriticalSection(_cs);
        if isChangeXor and (Thread[id].pckCount=4) then begin
          SetLength(tmp,Packet.Size);
          Move(PacketB[0], tmp[1], Packet.Size);
          EnterCriticalSection(_cs);
          Thread[id].xorS.DecryptGP(PacketC.DataC, Packet.Size-2);
          ii:=$13 or ((Packet.size-7) div 295) shl 8;
          PInteger(@PacketB[$02])^:=PInteger(@PacketB[$02])^ xor ii xor PInteger(@(Thread[id].xorS.GKeyS[0]))^;
          Thread[id].xorS.InitKey(PacketB[$02],Thread[id].isInterlude);
          Thread[id].xorC.InitKey(PacketB[$02],Thread[id].isInterlude);
          if (not isNoDecryptTraf) then Thread[id].xorC.DecryptGP(Thread[id].temp[3], Length(Thread[id].temp)-2);
          if (not isNoDecryptTraf) then Thread[id].xorC.EncryptGP(Thread[id].temp[3], Length(Thread[id].temp)-2);
          Thread[id].InitXOR:=True;
          LeaveCriticalSection(_cs);
          Move(tmp[1], PacketB[0], Packet.Size);
        end;
        if InitX and (not isNoDecryptTraf) then begin
          EnterCriticalSection(_cs);
          Thread[id].xorS.DecryptGP(PacketC.DataC, Packet.Size-2);
          LeaveCriticalSection(_cs);
        end;
        SetLength(temp, Packet.Size-2);
        Move(PacketC.DataC, temp[1], Packet.Size-2);
        //>>>>>>>>!!!!!!!!!<<<<<<<<
        //пакет от сервера - клиенту
        //sendMSG('Пришёл пакет от ГС, посылаем его скриптам на обработку...');
        a.a:=Word(true);
        a.b:=id;
        SendMessage(L2PacketHackMain.Handle, WM_ExecuteScripts, Integer(@temp),a.ab);
        //>>>>>>>>!!!!!!!!!<<<<<<<<
        Packet.Size:=Length(temp)+2;
        if Packet.Size>2 then begin
          Move(temp[1], PacketC.DataC, Packet.Size-2);
          if (not isNoDecryptTraf) then case PacketB[2] of
            $00: begin
              if not Thread[id].InitXOR then begin
                EnterCriticalSection(_cs);
                Thread[id].isInterlude:=(Packet.Size>19);
                Thread[id].xorC.InitKey(Packet.DataB[2], Thread[id].isInterlude);
                Thread[id].xorS.InitKey(Packet.DataB[2], Thread[id].isInterlude);
                LeaveCriticalSection(_cs);
                SendPacket(Packet.Size, temp, id, Boolean((from+1) mod 2));
                EnterCriticalSection(_cs);
                Thread[id].InitXOR:=True;
                LeaveCriticalSection(_cs);
                CanSend:=False;
              end;
            end;
            //UserInfo
//            $04: begin
//              //EnterCriticalSection(_cs);
//              if Thread[id].Name='' then begin
//                ii:=5*4+1;
//                while not ((Packet.DataB[ii]=0) and (Packet.DataB[ii+1]=0)) do Inc(ii);
//                Dec(ii, 5*4);
//                SetLength(WStr, ii div 2);
//                Move(Packet.DataB[5*4+1], WStr[1], ii);
//                Thread[id].Name:=WideStringToString(WStr, 1251);
//                L2PacketHackMain.ComboBox1.Items.BeginUpdate;
//                iii:=L2PacketHackMain.ComboBox1.ItemIndex;
//                L2PacketHackMain.ComboBox1.Items.Clear;
//                for h1:=0 to MaxThr-1 do
//                  if not Thread[h1].NoUsed then L2PacketHackMain.ComboBox1.Items.Add(IntToStr(h1)+' - '+Thread[h1].Name) else
//                    L2PacketHackMain.ComboBox1.Items.Add(IntToStr(h1)+' - пусто');
//                L2PacketHackMain.ComboBox1.ItemIndex:=iii;
//                L2PacketHackMain.ComboBox1.Items.EndUpdate;
//              end;
//              //LeaveCriticalSection(_cs);
//            end;
            //CharSelected
            $15: begin
              if not isCamael then begin //and (Thread[id].pckCount=7)
                  sendMSG('Считываем имя соединения...');
                  ii:=1;
                  while not ((Packet.DataB[ii]=0) and (Packet.DataB[ii+1]=0)) do Inc(ii);
                  SetLength(WStr, ii div 2);
                  Move(Packet.DataB[1], WStr[1], ii);
                  EnterCriticalSection(_cs);
                  Thread[id].Name:=WideStringToString(WStr, 1251);
                  LeaveCriticalSection(_cs);
                  sendMSG('Имя соединения:'+Thread[id].Name);
                  //обновляем Список соединений
//                  PostMessage(L2PacketHackMain.Handle, WM_UpdateComboBox1, 0, 0);
                  SendMessage(L2PacketHackMain.Handle, WM_UpdateComboBox1, 0, 0);              end;
            end;
            //CharSelected
            $0B: begin
              if isCamael then begin // and (Thread[id].pckCount=6)
                  sendMSG('Считываем имя соединения...');
                  ii:=1;
                  while not ((Packet.DataB[ii]=0) and (Packet.DataB[ii+1]=0)) do Inc(ii);
                  SetLength(WStr, ii div 2);
                  Move(Packet.DataB[1], WStr[1], ii);
                  EnterCriticalSection(_cs);
                  Thread[id].Name:=WideStringToString(WStr, 1251);
                  if L2PacketHackMain.isGraciaOff.Checked then
                    Corrector(Packet.Size,id,False,True); // инициализация корректора
                  LeaveCriticalSection(_cs);
                  sendMSG('Имя соединения:'+Thread[id].Name);
                  //обновляем Список соединений
//                  PostMessage(L2PacketHackMain.Handle, WM_UpdateComboBox1, 0, 0);
                  SendMessage(L2PacketHackMain.Handle, WM_UpdateComboBox1, 0, 0);              end;
            end;
            $2e: begin
              if (not Thread[id].InitXOR) and isCamael then begin
                EnterCriticalSection(_cs);
                Thread[id].isInterlude:=True;
                Thread[id].xorC.InitKey(Packet.DataB[2], Thread[id].isInterlude);
                Thread[id].xorS.InitKey(Packet.DataB[2], Thread[id].isInterlude);
                if L2PacketHackMain.isGraciaOff.Checked then
                  Corrector(Packet.Size,id,False,True); // инициализация корректора
                LeaveCriticalSection(_cs);
                SendPacket(Packet.Size, temp, id, Boolean((from+1) mod 2));
                EnterCriticalSection(_cs);
                Thread[id].InitXOR:=True;
                LeaveCriticalSection(_cs);
                CanSend:=False;
              end;
            end;
          end;
        end else begin
          CanSend:=False;
        end;
      end;
      2,4: begin                    //к ЛС или ГС
        EnterCriticalSection(_cs);
        InitX:=Thread[id].InitXOR;
        LeaveCriticalSection(_cs);
        Inc(Thread[id].pckCount);
        if isChangeXor and (Thread[id].pckCount=3) then begin
          SetLength(Thread[id].temp, Packet.Size);
          Move(PacketB, Thread[id].temp[1], Packet.Size);
        end;
        if InitX and (not isNoDecryptTraf) then begin
          EnterCriticalSection(_cs);
          Thread[id].xorC.DecryptGP(PacketC.DataC,Packet.Size-2);
          LeaveCriticalSection(_cs);
        end;
        if L2PacketHackMain.isGraciaOff.Checked and (not isNoDecryptTraf)then
          Corrector(Packet.Size,id);
        SetLength(temp,Packet.Size-2);
        Move(PacketC.DataC,temp[1],Packet.Size-2);
        //>>>>>>>>!!!!!!!!!<<<<<<<<
        //пакет от клиента - серверу
        //sendMSG('Пришёл пакет к ГС, посылаем его скриптам на обработку...');
        a.a:=Word(false);
        a.b:=id;
        SendMessage(L2PacketHackMain.Handle, WM_ExecuteScripts, Integer(@temp),a.ab);
        //>>>>>>>>!!!!!!!!!<<<<<<<<
        Packet.Size:=Length(temp)+2;
        if Packet.Size>2
          then Move(temp[1],PacketC.DataC,Packet.Size-2)
          else CanSend:=False;
      end;
    end;
  end;
  if CanSend then SendPacket(Packet.Size,temp,id,Boolean((from+1) mod 2));
end;

procedure GetMsgFromDLL(name       : pchar;
                        messageBuf : pointer; messageLen : dword;
                        answerBuf  : pointer; answerLen  : dword); stdcall;
begin
//  SendMessage(L2PacketHackMain.Handle,$04F0,Integer(messageBuf^),Word(Pointer(Integer(messageBuf)+4)^));
  SendMessage(L2PacketHackMain.Handle,WM_Dll_Log,Integer(messageBuf^),Word(Pointer(Integer(messageBuf)+4)^));
end;

// загружаем XOR dll
procedure TL2PacketHackMain.LoadLibraryXor (const name: string);
begin
  Lib:=LoadLibrary(PChar(ExtractFilePath(Application.ExeName)+name));
  if Lib > 0 then begin
    sendMSG(format(LoadDllSuccessfully,[name]));
    @CreateXorIn:=GetProcAddress(Lib,'CreateCoding');
    @CreateXorOut:=GetProcAddress(Lib,'CreateCodingOut');
    if @CreateXorOut=nil then CreateXorOut:=CreateXorIn;
  end else begin
    sendMSG(format(LoadDllUnSuccessful,[name]));
    isNewxor.Enabled := true;
    iNewxor.Checked := false;
  end;
end;

procedure TL2PacketHackMain.iNewxorClick(Sender: TObject);
begin
    if iNewxor.Checked then begin
      isNewxor.Enabled := false;
      loadLibraryXOR (isNewxor.Text)
    end else begin
      if not isNewxor.Enabled then begin
        FreeLibrary(Lib);
        sendMSG(format(UnLoadDllSuccessfully,[isNewxor.Text]));
        isNewxor.Enabled := true;
      end;
    end;
end;

procedure  TL2PacketHackMain.LoadLibraryInject (const name: string);
var sFile, Size:THandle;
    ee:OFSTRUCT;
    tmp:PChar;
begin
  tmp:=PChar(ExtractFilePath(Application.ExeName)+name);
  if fileExists (tmp) then begin
    sFile := OpenFile(tmp,ee,OF_READ);
    sendMSG(format(LoadDllSuccessfully,[name]));
    Size := GetFileSize(sFile, nil);
    GetMem(dllScr, Size);
    ReadFile(sFile, dllScr^, Size, Size, nil);
    CloseHandle(sFile);
  end else begin
     sendMSG(format(LoadDllUnSuccessful,[name]));
     isInject.Enabled := true;
     iInject.Checked := false;
  end;
end;
// инициируем загрузку или выгрузку Inject
procedure TL2PacketHackMain.iInjectClick(Sender: TObject);
begin
    if iInject.Checked then begin
      isInject.Enabled := false;
      LoadLibraryInject (isInject.Text)
    end else begin
      if not isInject.Enabled then begin
        FreeMem(dllScr);
        sendMSG(format(UnLoadDllSuccessfully,[isInject.Text]));
        isInject.Enabled := true;
      end;
    end;
end;
procedure TL2PacketHackMain.LoadPacketsIni;
var
  i, j: Integer;
begin
  //  ProtocolVersion:=560; //C4
  if ProtocolVersion<828 then begin
    // С4/C5/CT0
    if ProtocolVersion<660 then begin
      // C4 секция [GS_c4]
      LoadPktIni('packetsc4.ini');
      ToolButton10.Down:=true;
      ToolButton11.Down:=false;
      ToolButton12.Down:=false;
      ToolButton13.Down:=false;
    end;
    if (ProtocolVersion>=660) and (ProtocolVersion<=736) then begin
      // C5 секция [GS]
      LoadPktIni('packetsc5.ini');
      ToolButton10.Down:=false;
      ToolButton11.Down:=true;
      ToolButton12.Down:=false;
      ToolButton13.Down:=false;
    end;
    if ProtocolVersion>=737 then begin
      // interlude T0  секция [GS_t0]
      LoadPktIni('packetst0.ini');
      ToolButton10.Down:=false;
      ToolButton11.Down:=false;
      ToolButton12.Down:=true;
      ToolButton13.Down:=false;
    end;
  end else begin // >= 828 (какой там минимальный T1 протокол ?)
      LoadPktIni('packetst1.ini');
      ToolButton10.Down:=false;
      ToolButton11.Down:=false;
      ToolButton12.Down:=false;
      ToolButton13.Down:=true;
  end;
  filterS:=HexToString(Options.ReadString('Snifer','FilterS','FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'));
  filterC:=HexToString(Options.ReadString('Snifer','FilterC','FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'));

  //обновляем чекбоксы пакетов
  for i:=0 to (ListView2.Items.Count div 8)-1 do
    for j:=0 to 7 do
      ListView2.Items.Item[i*8+j].Checked:=Boolean((Byte(filterS[i+1])shr j) and 1);
  for i:=0 to (ListView1.Items.Count div 8)-1 do
    for j:=0 to 7 do
      ListView1.Items.Item[i*8+j].Checked:=Boolean((Byte(filterC[i+1])shr j) and 1);
end;

procedure TL2PacketHackMain.FormCreate(Sender: TObject);
var i:integer;
begin
  Caption:='Модификация L2PacketHack '+inet_ntoa(TInAddr(version))+' by CoderX.ru';
  sendMsg('Стартует L2phx '+inet_ntoa(TInAddr(version)));
  typ0:='я'; //тип переменной по молчанию
  CID:=0; //показывать в логе пакетов "нулевое соединение"
  Processes:=TStringList.Create;
  SkillList:=TStringList.Create;
  ItemsList:=TStringList.Create;
  SysMsgIdList:=TStringList.Create;
  NpcIdList:=TStringList.Create;
  ClassIdList:=TStringList.Create;
  //
  PacketsNames:=TStringList.Create;
  PacketsFromS:=TStringList.Create; //будем сохранять названия пакетов от сервера
  PacketsFromC:=TStringList.Create; //будем сохранять названия пакетов от клиента
  //считываем Options.ini в память
  Options:=TMemIniFile.Create(ExtractFilePath(Application.ExeName)+'Options.ini');

  InitializeCriticalSection(_cs);
  InitializeCriticalSection(cs_send);
  //грузим из options.ini названия используемых библиотек
  isNewxor.Text:=Options.ReadString('General','isNewxor','newxor.dll');
  isInject.Text:=Options.ReadString('General','isInject','inject.dll');

  if Length(isNewxor.Text) > 0 then begin
    isNewxor.Enabled := false;
    iNewxor.Checked := true;
  end;

  if Length(isInject.Text) > 0 then begin
    isInject.Enabled := false;
    iInject.Checked := true;
  end;

  PageControl1.ActivePageIndex:=0;
  Application.Icon:=L2PacketHackMain.Icon;
  //скрываем сообщение о том, что желательно купить FastScript
  HookCode(@ShowMessage,@ShowMessageNew,@ShowMessageOld);
  Memo1.Text:='Поддержать проект можно сюда:'+sLineBreak+'Z245193560959, R183025505328'+sLineBreak+'E360790044610, U392200550010';
  //скрываем закладку "пользовательская"
  TabSheet10.TabVisible:=False;

  LabeledEdit1.Text:=Options.ReadString('General','Clients','l2.exe;l2walker.exe');
  MaxThr:=Options.ReadInteger('General','MaxConections',5);
  SetLength(Thread, MaxThr);
  ComboBox1.Items.BeginUpdate;
  ComboBox1.Items.Clear;
  //готовим потоки
  for i:=0 to MaxThr-1 do begin
    Thread[i].NoUsed:=True;
    Thread[i].Dump:=TStringList.Create;
    New(Thread[i].cd);
    Thread[i].cd._id_mix:=False;
    ComboBox1.Items.Add(IntToStr(i)+' - пусто');
  end;
  ComboBox1.ItemIndex:=0;
  ComboBox1.Items.EndUpdate;

  //панель Просмотр
  ToolButton3.Down:=Options.ReadBool('Snifer','FromClient',True);
  ToolButton4.Down:=Options.ReadBool('Snifer','FromServer',True);
  ToolButton5.Down:=Options.ReadBool('Snifer','Scroll',False);
  //сохранять пакеты
  ToolButton7.Down:=Options.ReadBool('Snifer','SaveLog',False);
  isSaveLog:=ToolButton7.Down;
  //панель Основное
  CheckBox2.Checked:=Options.ReadBool('General','NoLogin',True);
  isPassLogin:=CheckBox2.Checked;
  CheckBox3.Checked:=Options.ReadBool('General','Enable',True);
  isIntercept:=CheckBox3.Checked;
  isKamael.Checked:=Options.ReadBool('General','isKamael',False);
  isCamael:=isKamael.Checked;
  isGraciaOff.Checked:=Options.ReadBool('General', 'isGraciaOff', False);
  ChkXORfix.Checked:=Options.ReadBool('General','AntiXORkey',False);
  isChangeXor:=ChkXORfix.Checked;
  CheckBox4.Checked:=Options.ReadBool('General','Programs',False);
  ChkNoDecrypt.Checked:=Options.ReadBool('General','NoDecrypt',False);
  isNoDecryptTraf:=ChkNoDecrypt.Checked;
  RadioGroup1.ItemIndex:=Options.ReadInteger('General','HookMethod',1);
  isHookMethod:=RadioGroup1.ItemIndex;
  //размеры формы
  Top:=Options.ReadInteger('General','Top',0);
  Left:=Options.ReadInteger('General','Left',600);
  Width:=Options.ReadInteger('General','Widht',700);
  Height:=Options.ReadInteger('General','Heigth',960);

  kId:=Options.ReadInteger('General','kID',1023000); //по умолчанию для TheAbyss.ru

  Panel2.Visible:=CheckBox4.Checked;
  LPortConst:=htons(Options.ReadInteger('General','LocalPort',$FEDC));
  LabeledEdit2.Text:=Options.ReadString('General','IgnorPorts','5001;5002;2222');

  if StrToBool(Options.ReadString('Snifer','ShowFilters', '0')) then
  begin
    ToolButton6.Down := true;
    panel15.Visible := ToolButton6.Down;
  end;
     
    //грузим packets.ini
  ProtocolVersion := strtoint(Options.ReadString('Snifer','ProtocolVersion','560'));
  ToolButton8Click(Sender);

  //скрипты
  for i:=0 to 63 do Scripts[i].fsScript:=TfsScript.Create(Self);

  WSAStartup(WSA_VER, WSA);  //стартуем сокеты
  NoServer:=True;
  RefreshScripts;
  JvHLEditor1.CurrentLineHighlight:=$e6fffa;
  JvHLEditor2.CurrentLineHighlight:=$e6fffa;
  //запускаем главный поток
  SLThreadTerminate := false;
  SLThreadStarted := false;
  SLh:=BeginThread(nil, 0, @ServerListen, nil, 0, SLth);
  sendMsg('Thread Start: основной поток ServerListen '+inttostr(SLh)+'/'+inttostr(SLth));

  PluginStruct.Threads:=@Thread[0];
  PluginStruct.ThreadsCount:=High(Thread)+1;
  PluginStruct.SendPck:=SendPacket;
  PluginStruct.SendPckStr:=SendPckStr;
  PluginStruct.SendPckData:=SendPckData;
  PluginStruct.DataPckToStrPck:=DataPckToStrPck;
  PluginStruct.HexToString:=HexToString;
  PluginStruct.StringToHex:=StringToHex;
  btnRefreshPluginListClick(nil);

  // эти кнопки поумолчанию выключены
  tbtnFilterDel.Enabled := false;
  tbtnDelete.Enabled := false;
end;

procedure TL2PacketHackMain.FormDestroy(Sender: TObject);
var
  i,j: Integer;
  data: array[0..255] of Byte;
  temp: string;
  var dw : dword;
begin
  if SLThreadStarted then begin //если ещё работает
    SLThreadTerminate:=true; //сигналим завершиться процессу ServerListen
    while ResumeThread(SLh)>0 do ;
    dw := GetTickCount;
    while SLThreadStarted and ((GetTickCount-dw)<2000) do begin
      WaitForSingleObject(SLh, 15);  //ждем завершения
    end;
    if SLThreadStarted then TerminateThread(SLh, 0) else CloseHandle(SLh);
  end;
  WSACleanup;

  //сохраняем фильтр в файл
  for i:=0 to (ListView2.Items.Count div 8)-1 do begin
    data[i]:=0;
    for j := 0 to 7 do begin
      Inc(data[i],Byte(ListView2.Items.Item[i*8+j].Checked) shl j);
    end;
  end;
  temp:=ByteArrayToHex(data,ListView2.Items.Count div 8);
  //дописываем в конец FF
  if length(temp)<128 then begin
    for i:=0 to 128-Length(temp)-1 do temp:=temp+'F';
  end;
  Options.WriteString('Snifer','FilterS',temp);
  //-------------
  for i:=0 to (ListView1.Items.Count div 8)-1 do begin
    data[i]:=0;
    for j := 0 to 7 do begin
      Inc(data[i],Byte(ListView1.Items.Item[i*8+j].Checked) shl j);
    end;
  end;
  temp:=ByteArrayToHex(data,ListView1.Items.Count div 8);
  if length(temp)<128 then begin
    for i:=0 to 128-Length(temp)-1 do temp:=temp+'F';
  end;
  Options.WriteString('Snifer','FilterC',temp);
  Options.WriteInteger('General','Top',Top);
  Options.WriteInteger('General','Left',Left);
  Options.WriteInteger('General','Widht',Width);
  Options.WriteInteger('General','Heigth',Height);
  Options.WriteInteger('Snifer','ProtocolVersion',ProtocolVersion);
  Options.WriteInteger('General','HookMethod',isHookMethod);
  Options.UpdateFile;
  Options.Free;

  //потоки
  for i:=0 to MaxThr-1 do begin
    Thread[i].Dump.Free;
    Dispose(Thread[i].cd);
  end;

  //скрипты
  for i:=0 to 63 do Scripts[i].fsScript.Destroy;

  Processes.Free;
  PacketsNames.Free;
  PacketsFromS.Free;
  PacketsFromC.Free;
  SysMsgIdList.Free;
  ItemsList.Free;
  NpcIdList.Free;
  ClassIdList.Free;
  SkillList.Free;
  PacketsINI.free;

  if Lib<>0 then FreeLibrary(Lib);
  if not isInject.Enabled then FreeMem(dllScr);

  DeleteCriticalSection(_cs);
  DeleteCriticalSection(cs_send);

  for i:=0 to High(Plugins) do Plugins[i].Free;
  SetLength(Plugins,0);

  UnhookCode(@ShowMessageOld); //снимаем хук и освобождаем память

  sendMsg('Завершил работу L2phx... ');
end;

procedure TL2PacketHackMain.isGraciaOffClick(Sender: TObject);
begin
  if isGraciaOff.Checked then isKamael.Checked:=True;
  Options.WriteBool('General', 'isGraciaOff', isGraciaOff.Checked);
  Options.UpdateFile;
end;

procedure TL2PacketHackMain.isInjectChange(Sender: TObject);
begin
  Options.WriteString('General', 'isInject', isInject.Text);
  Options.UpdateFile;
end;

procedure TL2PacketHackMain.isKamaelClick(Sender: TObject);
{если нажали галочку isKamael}
begin
  Options.WriteBool('General','isKamael',isKamael.Checked);
  isCamael:=isKamael.Checked;
end;

procedure TL2PacketHackMain.isNewxorChange(Sender: TObject);
begin
  Options.WriteString('General', 'isNewxor', isNewxor.Text);
  Options.UpdateFile;
end;

procedure TL2PacketHackMain.JvHLEditor1Change(Sender: TObject);
begin
  ButtonSave.Enabled:=True;
end;

procedure FindWords;
begin
  FindReplaceForm.PageControl1.ActivePageIndex:=0;
  FindReplaceForm.ShowModal; //поиск и замена в редакторе скриптов
end;

procedure ReplaceWords;
begin
  FindReplaceForm.PageControl1.ActivePageIndex:=1;
  FindReplaceForm.ShowModal; //поиск и замена в редакторе скриптов
end;

procedure TL2PacketHackMain.JvHLEditor1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  JvHLEditor1.SelBackColor:=clHighlight;
  // добавили комбинацию клавиш 'сохранить файл' - ctrl+s
  if(Key in [Ord('S'), Ord('s')])and(Shift=[ssCtrl]) then ButtonSaveClick(Sender) else
  // добавили комбинацию клавиш 'проверить синтаксис' - ctrl+f9
  if(Key=VK_F9)and(Shift=[ssCtrl]) then ButtonCheckSyntexClick(Sender);
  // добавили комбинацию клавиш 'поиск' - ctrl+f
  if(Key in [Ord('F'), Ord('f')])and(Shift=[ssCtrl]) then FindWords;
  if(Key in [Ord('R'), Ord('r')])and(Shift=[ssCtrl]) then ReplaceWords;
end;

procedure TL2PacketHackMain.JvHLEditor1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  JvHLEditor1.SelBackColor:=clHighlight;
end;

procedure TL2PacketHackMain.JvHLEditor1PaintGutter(Sender: TObject; Canvas: TCanvas);
var
  h,i: Integer;
begin
  Canvas.Font.Color:=clWindowText;
  Canvas.Font.Style:=[];
  with Canvas do begin
    h:=TextHeight('8')+1;
    for i := ClipRect.Top div h to ClipRect.Bottom div h do
      TextOut(JvHLEditor1.GutterWidth-TextWidth(IntToStr(i+1+JvHLEditor1.TopRow))-5,ClipRect.Top+i*h,IntToStr(i+1+JvHLEditor1.TopRow));
  end;
end;

procedure TL2PacketHackMain.JvHLEditor1Scroll(Sender: TObject);
begin
  JvHLEditor1.Gutter.Paint;
end;

procedure TL2PacketHackMain.JvHLEditor2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  JvHLEditor2.SelBackColor:=clHighlight;
end;

procedure TL2PacketHackMain.JvHLEditor2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  JvHLEditor2.SelBackColor:=clHighlight;
end;

procedure TL2PacketHackMain.JvHLEditor2PaintGutter(Sender: TObject; Canvas: TCanvas);
var
  h,i: Integer;
begin
  Canvas.Font.Color:=clWindowText;
  Canvas.Font.Style:=[];
  with Canvas do begin
    h:=TextHeight('8')+1;
    for i := ClipRect.Top div h to ClipRect.Bottom div h do
      TextOut(JvHLEditor2.GutterWidth-TextWidth(IntToStr(i+1+JvHLEditor2.TopRow))-5,ClipRect.Top+i*h,IntToStr(i+1+JvHLEditor2.TopRow));
  end;
end;

procedure TL2PacketHackMain.JvHLEditor2Scroll(Sender: TObject);
begin
  JvHLEditor2.Gutter.Paint;
end;

procedure TL2PacketHackMain.JvSpinEdit1Change(Sender: TObject);
begin
  Timer1.Interval:=Round(JvSpinEdit1.Value*1000);
  CheckBox3.Checked:=True;
end;

procedure TL2PacketHackMain.Label12Click(Sender: TObject);
begin
  ShellExecute(handle, 'open', 'http://coderx.ru', nil, nil, SW_SHOW);
end;

procedure TL2PacketHackMain.LabeledEdit1Change(Sender: TObject);
begin
  Options.WriteString('General','Clients',LabeledEdit1.Text);
  Options.UpdateFile;
  // при изменении поля очищаем список запомненых процессов
  // обнавляется список нужных процессов
  ListBox1.Clear;
end;

procedure TL2PacketHackMain.LabeledEdit2Change(Sender: TObject);
begin
  Options.WriteString('General','IgnorPorts',LabeledEdit2.Text);
  Options.UpdateFile;
end;

procedure TL2PacketHackMain.ListView1Click(Sender: TObject);
var
  msg: TMessage;
  i: Integer;
begin
  //расшифровываем лог пакетов
  ListView5.Items.BeginUpdate;
  ListView5.Items.Clear;
  //EnterCriticalSection(_cs);
  for i := 0 to Thread[CID].Dump.Count-1 do begin
    //смотрим второй байт в каждом пакете
    if Thread[CID].Dump.Strings[i][2]='4' then //от клиента
      msg.WParam:=Integer(CID and $FF)+ $100
    else if Thread[CID].Dump.Strings[i][2]='3' then //от сервера
      msg.WParam:=Integer(CID and $FF);
    msg.LParam:=i;
    PacketSend(msg);
  end;
  //LeaveCriticalSection(_cs);
  ListView5.Items.EndUpdate;
end;
//-------------
procedure TL2PacketHackMain.ListView2Click(Sender: TObject);
begin
  ListView1Click(Sender);
end;
//-------------
procedure TL2PacketHackMain.ListView5Click(Sender: TObject);
begin
  typ0:='я';
  if ListView5.SelCount=1 then ListViewChange(ListView5.Selected,Memo3,Memo2);
end;
//-------------
procedure TL2PacketHackMain.ListView5KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  ListView5Click(Sender);
end;

//===========================================================================
function GetFunc01(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.Func01 - возвращает название Item'а по его ID из значения аргумента
begin
  result:='0'; if ar1=0 then exit;
  result:=ItemsList.Values[IntTostr(ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown Items ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;
//-------------
function GetFunc02(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.Func02 - возвращает тип Say2
begin
  case ar1 of
    0: result := 'ALL';
    1: result := '! SHOUT';
    2: result := '" TELL';
    3: result := '# PARTY';
    4: result := '@ CLAN';
    5: result := 'GM';
    6: result := 'PETITION_PLAYER';
    7: result := 'PETITION_GM';
    8: result := '+ TRADE';
    9: result := '$ ALLIANCE';
    10: result := 'ANNOUNCEMENT';
    11: result := 'WILLCRASHCLIENT';
    12: result := 'FAKEALL?';
    13: result := 'FAKEALL?';
    14: result := 'FAKEALL?';
    15: result := 'PARTYROOM_ALL';
    16: result := 'PARTYROOM_COMMANDER';
    17: result := 'HERO_VOICE';
    else result := '?';
  end;
  result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')';
end;
//-------------
function GetFunc09(id: byte; ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.Func09 - разное.
begin
  result := '';
  if (id in [$1B,$2D,$27]) then begin
    case ar1 of // [C] 1B - RequestSocialAction,  [S] 2D - SocialAction
                // CT1: [S] 27 - SocialAction
       02: result := 'Greeting';
       03: result := 'Victory';
       04: result := 'Advance';
       05: result := 'No';
       06: result := 'Yes';
       07: result := 'Bow';
       08: result := 'Unaware';
       09: result := 'Social Waiting';
      $0A: result := 'Laugh';
      $0B: result := 'Applaud';
      $0C: result := 'Dance';
      $0D: result := 'Sorrow';
      $0E: result := 'Sorrow';
      $0F: result := 'lvl-up light';
      $10: result := 'Hero light';
      else result := '?';
    end;
  end else if (id=$6D) then begin
    case ar1 of //  [C] 6D - RequestRestartPoint.
      0: result := 'res to town';
      1: result := 'res to clanhall';
      2: result := 'res to castle';
      3: result := 'res to siege HQ';
      4: result := 'res here and now :)';
      else result := '?';
    end;
  end;
  if (id=$6E) then begin
    case ar1 of // [C] 6E - RequestGMCommand.
      1: result := 'player status';
      2: result := 'player clan';
      3: result := 'player skills';
      4: result := 'player quests';
      5: result := 'player inventory';
      6: result := 'player warehouse';
      else result := '?';
    end;
  end;
  if (id=$A0) then begin
    case ar1 of // [C] A0 -RequestBlock
      0: result := 'block name';
      1: result := 'unblock name';
      2: result := 'list blocked names';
      3: result := 'block all';
      4: result := 'unblock all';
      else result := '?';
    end;
  end;
  result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')';
end;
//-------------
function GetSkill(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.Skill - возвращает название скила по его ID из значения аргумента
begin
  result:='0'; if ar1=0 then exit;
  result:=SkillList.Values[inttostr(ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown Skill ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;
//-------------
function GetMsgID(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.MsgID - возвращает текст по его ID из значения аргумента
begin
  result:='0'; if ar1=0 then exit;
  result:=SysMsgidList.Values[inttostr(ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown SysMsg ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;
//-------------
function GetNpcID(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.NpcID - возвращает текст по его ID из значения аргумента
var
 _ar1: integer;
begin
  _ar1:=ar1-kId;
  result:='0'; if ar1=0 then exit;
  result:=NpcIdList.Values[inttostr(_ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown Npc ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;
//-------------
function GetClassID(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.ClassID - профа
begin
  result:=ClassIdList.Values[inttostr(ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown Class ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;
//-------------
function GetFSup(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.FSup - Status Update ID
begin
  case ar1 of
    01: result := 'Level';      02: result := 'EXP';         03: result := 'STR';
    04: result := 'DEX';        05: result := 'CON';         06: result := 'INT';
    07: result := 'WIT';        08: result := 'MEN';         09: result := 'cur_HP';
    $0A: result := 'max_HP';   $0B: result := 'cur_MP';     $0C: result := 'max_MP';
    $0D: result := 'SP';       $0E: result := 'cur_Load';   $0F: result := 'max_Load';
    $11: result := 'P_ATK';    $12: result := 'ATK_SPD';    $13: result := 'P_DEF';
    $14: result := 'Evasion';  $15: result := 'Accuracy';   $16: result := 'Critical';
    $17: result := 'M_ATK';    $18: result := 'CAST_SPD';   $19: result := 'M_DEF';
    $1A: result := 'PVP_FLAG'; $1B: result := 'KARMA';      $21: result := 'cur_CP';
    $22: result := 'max_CP';
    else result := '?'
  end;
  result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')';
end;
//-------------
function GetType(const s:string; var i: Integer):string;
begin
  Result:='';
  while (s[i]<>')')and(i<Length(s)) do begin
    Result:=Result+s[i];
    Inc(i);
  end;
  Result:=Result+s[i];
end;
//-------------
function GetTyp(s:string):string;
begin
  //d(Count:For.0001)
  //d(Count:Get.Func01)
  //-(40)
  Result:=s[1];
end;
function GetName(s:string):string;
var
 k : integer;
begin
  Result:='';
  k:=Pos('(',s);
  if k=0 then exit;
  inc(k);
  while (s[k]<>':')and(k<Length(s)) do begin
    Result:=Result+s[k];
    Inc(k);
  end;
end;
function GetFunc(s:string):string;
var
 k : integer;
begin
  Result:='';
  k:=Pos(':',s);
  if k=0 then exit;
  inc(k);
  while (s[k]<>'.')and(k<Length(s)) do begin
    Result:=Result+s[k];
    Inc(k);
  end;
end;
//-------------
function GetParam(s:string):string;
var
 k : integer;
begin
  Result:='';
  k:=Pos('.',s);
  //не нашли точку
  if k=0 then exit;
  inc(k);
  while (s[k]<>'.') and (k<Length(s)) do begin //or(s[k]<>')')
    Result:=Result+s[k];
    Inc(k);
  end;
end;
//-------------
function GetParam2(s:string):string;
var
 k, l : integer;
 s2: string;
begin
  Result:='';
  k:=Pos('.',s);
  //не нашли точку
  if k=0 then exit;
  //на следующий за точкой символ
  inc(k);
  l:=length(s);
  s2:=copy(s,k, l-k+1);
  //ищем вторую точку
  k:=Pos('.',s2);
  //не нашли точку
  if k=0 then exit;
  inc(k);
  while (s2[k]<>')')and(k<Length(s2)) do begin
    Result:=Result+s2[k];
    Inc(k);
  end;
end;
//-------------
function GetValue(typ, name, PktStr: string; var PosInPkt: integer; size:word; Memo: TJvRichEdit): string;
var
  value: string;
  d:integer;
  pch: WideString;
begin
  hexvalue:='';
  Memo.SelStart:=(PosInPkt-12)*3;
  d:=0;
  case typ[1] of
    'd': begin
      value:=IntToStr(PInteger(@PktStr[PosInPkt])^);
      hexvalue:=' (0x'+inttohex(Strtoint(value),8)+')';
      Memo.SelLength:=11;
      Memo.SelAttributes.BackColor:=$aadfdf;
      SelAttributes:=$aadfdf;
      Inc(PosInPkt,4);
    end;  //integer (размер 4 байта)           d, h-hex
    'c': begin
      value:=IntToStr(PByte(@PktStr[PosInPkt])^);
      hexvalue:=' (0x'+inttohex(Strtoint(value),2)+')';
      SelLength:=2;
      SelAttributes:=$aaaadf;
      Memo.SelLength:=2;
      Memo.SelAttributes.BackColor:=$aaaadf;
      Inc(PosInPkt);
    end;  //byte / char (размер 1 байт)        b
    'f': begin
      value:=FloatToStr(PDouble(@PktStr[PosInPkt])^);
      //hexvalue:=value+' (0x'+inttohex(Strtoint(value),8)+')';
      SelLength:=23;
      SelAttributes:=$dfaaaa;
      Memo.SelLength:=23;
      Memo.SelAttributes.BackColor:=$dfaaaa;
      Inc(PosInPkt,8);
    end;  //double (размер 8 байт, float)      f
    'h': begin
      value:=IntToStr(PWord(@PktStr[PosInPkt])^);
      hexvalue:=' (0x'+inttohex(Strtoint(value),4)+')';
      SelLength:=5;
      SelAttributes:=$dfaadf;
      Memo.SelLength:=5;
      Memo.SelAttributes.BackColor:=$dfaadf;
      Inc(PosInPkt,2);
    end;  //word (размер 2 байта)              w
    'q': begin
      value:=IntToStr(PInt64(@PktStr[PosInPkt])^);
      SelLength:=23;
      SelAttributes:=$aadfd0;
      Memo.SelLength:=23;
      Memo.SelAttributes.BackColor:=$aadfd0;
      Inc(PosInPkt,8);
    end;  //int64 (размер 8 байта)
    '-','z': begin
      if Length(name)>4 then begin
        if name[1]<>'S' then begin
          d:=strtoint(copy(name,1,4)); Inc(PosInPkt,d);
          value:='Пропускаем '+inttostr(d)+' байт(а)';
        end else
          value:='Пропускаем скрипт';
      end else begin
        d:=strtoint(name); Inc(PosInPkt,d);
        value:='Пропускаем '+inttostr(d)+' байт(а)';
      end;
      d:=(d+2)*3-1;
      SelAttributes:=$dadada;
      Memo.SelLength:=d;
      Memo.SelAttributes.BackColor:=$dadada;
    end;
    's':begin
      d:=PosEx(#0#0,PktStr,PosInPkt)-PosInPkt;
      if (d mod 2)=1 then Inc(d);
      SetLength(pch,d div 2);
      if d>=2 then Move(PktStr[PosInPkt],pch[1],d) else d:=0;
      //value:=WideStringToString(pch,1251);
      value:=pch; //преобразует автоматом
      SelLength:=(d+2)*3-1;
      SelAttributes:=$dfdfaa;
      Memo.SelLength:=(d+2)*3-1;
      Memo.SelAttributes.BackColor:=$dfdfaa;
      Inc(PosInPkt,d+2);
    end;
    else value:= 'Неизвестный идентификатор -> ?(name)!';
  end;
  Result:=value;
  //проверяем на выход за границу пакета
  //if PosInPkt>Size+10 then raise ERangeError.CreateFmt(result+' is not within the valid range of %d', [Size]);
  if PosInPkt>Size+10 then result:='range error';
end;
//===========================================================================
procedure TL2PacketHackMain.LoadPktIni(s:string);
var
  FromS: boolean;
  i: integer;
  temp: string;
//  BColor: TColor;
begin
  fromS:=false;
  // очищаем спискм
  ListView1.Clear;
  ListView2.Clear;
  PacketsFromS.Clear;
  PacketsFromC.Clear;

  //считываем packets.ini
  PacketsNames.LoadFromFile(ExtractFilePath(Application.ExeName)+s);
  for i:=0 to PacketsNames.Count-1 do begin
    temp:=copy(PacketsNames[i],1,2); //взять первые два символа
    if temp='//' then continue; //комментарии
    if PacketsNames[i]='' then continue;     //пустые строки
    if uppercase(PacketsNames[i])='[CLIENT]' then begin fromS:=false; continue; end;
    if uppercase(PacketsNames[i])='[SERVER]' then begin fromS:=true; continue; end;
    if not fromS then begin
      with ListView2.Items.Add do
      begin
        Caption:=PacketsNames.Names[i];
        Checked:=True;
        SubItems.Add(GetNamePacket(PacketsNames.ValueFromIndex[i]));
        PacketsFromC.Append(PacketsNames.Names[i]+'='+(GetNamePacket(PacketsNames.ValueFromIndex[i])));
      end;
    end;
    if fromS then begin
      with ListView1.Items.Add do
      begin
        Caption:=PacketsNames.Names[i];
        Checked:=True;
        SubItems.Add(GetNamePacket(PacketsNames.ValueFromIndex[i]));
        PacketsFromS.Append(PacketsNames.Names[i]+'='+(GetNamePacket(PacketsNames.ValueFromIndex[i])));
      end;
    end;
  end;

  //считываем packets.ini
  //полный вариант для разбора пакетов
  PacketsINI:=TMemIniFile.Create(ExtractFilePath(Application.ExeName)+s)
end;
//===========================================================================
procedure TL2PacketHackMain.ListViewChange(Item: TListItem; Memo, Memo2: TJvRichEdit);
var
  sid, ii, j, jj: Integer;
  id: Byte;
  Size: Word;
  PktStr, StrIni, Param0: string;
  d, PosInIni, PosInPkt, offset: integer;
  ptime: TDateTime;
  SubID: word;
  typ, name,func, tmp_param, param1, param2: string;
  value, tmp_value: string;
begin
  if (Item.SubItems.Count>0)and(Item.Selected) then begin
    //выделили пакет значит включаем кнопку 
    tbtnFilterDel.Enabled := true;
    tbtnDelete.Enabled := true;

    sid:=StrToInt(Item.SubItems.Strings[0]);
    EnterCriticalSection(_cs);
    //строка пакета, sid номер пакета, cid номер соединения
    PktStr:=HexToString(Thread[cid].Dump.Strings[sid]);
    LeaveCriticalSection(_cs);
    if Length(PktStr)<12 then Exit;
    Move(PktStr[2],ptime,8);
    Size:=Word(Byte(PktStr[11]) shl 8)+Byte(PktStr[10]);
    id:=Byte(PktStr[12]);                   //фактическое начало пакета, ID
    SubId:=Word(id shl 8+Byte(PktStr[13])); //считываем SubId
    Memo.Lines.BeginUpdate;
    Memo.Clear;
    Memo.Lines.Add(StringToHex(Copy(PktStr,12,Length(PktStr)-11),' '));
//    Memo.Lines.Add('');
//    Memo.Lines.Add('  №  | 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F |    Строкой');
//    Memo.Lines.Add('-----+-------------------------------------------------+-----------------');
//    Memo.Lines.Add(ParceData(Copy(temp,12,Length(temp)-11)));
    GroupBox6.Caption:='Выделенный пакет: тип - 0x'+IntToHex(id,2)+', '+Item.Caption+', размер - '+IntToStr(Size);
    Memo.Lines.EndUpdate;
    //считываем строку из packets.ini для парсинга
    if PktStr[1]=#04 then begin //client
      if (ID in [$39,$D0]) and (size>3) then begin
        StrIni:=PacketsINI.ReadString('client',IntToHex(subid,4),'Unknow:h(subID)');
      end
      else begin
        StrIni:=PacketsINI.ReadString('client',IntToHex(id,2),'Unknow:');
      end;
    end else begin
      if (ID in [$FE]) and (size>3) then begin
        StrIni:=PacketsINI.ReadString('server',IntToHex(subid,4),'Unknow:h(subID)');
      end
      else begin
        StrIni:=PacketsINI.ReadString('server',IntToHex(id,2),'Unknow:');
      end;
    end;
    //начинаем разбирать пакет по заданному в packets.ini формату
    //смещение в ini
    PosInIni:=Pos(':',StrIni);
    //смещение в pkt
    PosInPkt:=13;
    Inc(PosInIni);
    //Memo2.Lines.BeginUpdate;
    Memo2.Clear;
    Memo2.Lines.Add('Tип: 0x'+IntToHex(id,2)+' ('+Item.Caption+')');
    Memo2.Lines.Add('Pазмер: '+IntToStr(Size-2)+'+2');
    Memo2.Lines.Add('Время прихода: '+FormatDateTime('hh:nn:ss:zzz',ptime));
    //GetType - возвращает строчку типа d(Count:For.0001) из packets.ini
    //StrIni - строчка из packets.ini по ID из пакета
    //PktStr - пакет
    //Param0 - строка d(Count:For.0001)
    //PosInIni - смещение в строчке из packets.ini по ID из пакета
    //PosInPkt - смещение в пакете
    Memo.SelStart:=0;
    Memo.SelLength:=2;
    Memo.SelAttributes.BackColor:=$aaaadf;
    Memo2.SelStart:=5;
    Memo2.SelLength:=4;
    Memo2.SelAttributes.BackColor:=$aaaadf;
    d:=Memo2.GetTextLen-Memo2.Lines.Count;
    while (PosInIni>1)and(PosInIni<Length(StrIni))and(PosInPkt<Size+10) do begin
      Param0:=GetType(StrIni,PosInIni);
      inc(PosInIni);
      typ:=GetTyp(Param0); //считываем тип значения
      name:=GetName(Param0); //считываем имя значения в скобках (name:func.par)
      func:=uppercase(GetFunc(Param0)); //считываем имя функции в скобках (name:func.par)
      param1:=uppercase(GetParam(Param0)); //считываем имя значения в скобках (name:func.1.2)
      param2:=GetParam2(Param0); //считываем имя значения в скобках (name:func.1.2)
      offset:=PosinPkt-11;
      value:=GetValue(typ, name, PktStr, PosInPkt, size, memo3); //считываем значение, сдвигаем указатели в соответствии с типом значения
      if uppercase(Func)='GET' then begin
        if param1='FUNC01' then   value:=GetFunc01(strtoint(value)) else
        if param1='FUNC02' then   value:=GetFunc02(strtoint(value)) else
        if param1='FUNC09' then   value:=GetFunc09(id, strtoint(value)) else
        if param1='CLASSID' then  value:=GetClassID(strtoint(value)) else
        if param1='FSUP' then     value:=GetFsup(strtoint(value)) else
        if param1='NPCID' then    value:=GetNpcID(strtoint(value)) else
        if param1='MSGID' then    value:=GetMsgID(strtoint(value)) else
        if param1='SKILL' then    value:=GetSkill(strtoint(value));
        Memo2.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value);
        //Memo2.SelStart:=d+length(inttostr(offset))+1;
        Memo2.SelStart:=d+5;
        Memo2.SelLength:=1;
        Memo2.SelAttributes.BackColor:=SelAttributes;
        d:=Memo2.GetTextLen-Memo2.Lines.Count;
      end else
      //для С4, С5 и Т0-Интерлюдия
      if uppercase(Func)='FOR' then begin
        //распечатываем
        Memo2.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue);
        //Memo2.SelStart:=d+length(inttostr(offset))+1;
        Memo2.SelStart:=d+5;
        Memo2.SelLength:=1;
        Memo2.SelAttributes.BackColor:=SelAttributes;
        d:=Memo2.GetTextLen-Memo2.Lines.Count;
        tmp_param:=param1;
        tmp_value:=value;
        ii:=PosInIni;
        if value='range error' then exit;
        if StrToInt(value)=0 then begin
          //пропускаем пустые значения
          for jj:=1 to StrToInt(param1) do begin
            Param0:=GetType(StrIni,PosInIni);
            inc(PosInIni);
          end;
        end else begin
          for j:=1 to StrToInt(tmp_value) do begin
            Memo2.Lines.Add('[Начало повторяющегося блока '+inttostr(j)+'/'+tmp_value+']');
            d:=Memo2.GetTextLen-Memo2.Lines.Count;
            PosInIni:=ii;
            for jj:=1 to StrToInt(tmp_param) do begin
              Param0:=GetType(StrIni,PosInIni);
              inc(PosInIni);
              typ:=GetTyp(Param0); //считываем тип значения
              name:=GetName(Param0); //считываем имя значения в скобках (name:func.1)
              func:=uppercase(GetFunc(Param0)); //считываем имя функции в скобках (name:func.par)
              param1:=uppercase(GetParam(Param0)); //считываем имя значения в скобках (name:func.1.2)
              //param2:=GetParam2(Param0); //считываем имя значения в скобках (name:func.1)
              offset:=PosinPkt-11;
              value:=GetValue(typ, name, PktStr, PosInPkt, size, memo3);
              if uppercase(Func)='GET' then begin
                if param1='FUNC01' then   value:=GetFunc01(strtoint(value)) else
                if param1='FUNC02' then   value:=GetFunc02(strtoint(value)) else
                if param1='FUNC09' then   value:=GetFunc09(id, strtoint(value)) else
                if param1='CLASSID' then  value:=GetClassID(strtoint(value)) else
                if param1='FSUP' then     value:=GetFsup(strtoint(value)) else
                if param1='NPCID' then    value:=GetNpcID(strtoint(value)) else
                if param1='MSGID' then    value:=GetMsgID(strtoint(value)) else
                if param1='SKILL' then    value:=GetSkill(strtoint(value));
              end;
              Memo2.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value);
              //Memo2.SelStart:=d+length(inttostr(offset))+1;
              Memo2.SelStart:=d+5;
              Memo2.SelLength:=1;
              Memo2.SelAttributes.BackColor:=SelAttributes;
              d:=Memo2.GetTextLen-Memo2.Lines.Count;
            end;
            Memo2.Lines.Add('[Конец повторяющегося блока  '+inttostr(j)+'/'+tmp_value+']');
            d:=Memo2.GetTextLen-Memo2.Lines.Count;
          end;
        end;
      end else
      //для Т1-Камаель
      if uppercase(Func)='LOOP' then begin
        //распечатываем
        Memo2.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue);
        //Memo2.SelStart:=d+length(inttostr(offset))+1;
        Memo2.SelStart:=d+5;
        Memo2.SelLength:=1;
        Memo2.SelAttributes.BackColor:=SelAttributes;
        d:=Memo2.GetTextLen-Memo2.Lines.Count;
        //проверку что param1=1?
        tmp_param:=param2;
        tmp_value:=value;
        if value='range error' then exit;
        if strtoint(param1)>1 then begin
          //распечатываем значения
          for jj:=1 to StrToInt(param1)-1 do begin
            Param0:=GetType(StrIni,PosInIni);
            inc(PosInIni);
            typ:=GetTyp(Param0); //считываем тип значения
            name:=GetName(Param0); //считываем имя значения в скобках (name:func.1.2)
            func:=uppercase(GetFunc(Param0)); //считываем имя функции в скобках (name:func.par)
            param1:=uppercase(GetParam(Param0)); //считываем имя значения в скобках (name:func.1.2)
            param2:=GetParam2(Param0); //считываем имя значения в скобках (name:func.1.2)
            offset:=PosinPkt-11;
            value:=GetValue(typ, name, PktStr, PosInPkt, size, memo3);
            //распечатываем
            Memo2.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue);
            //Memo2.SelStart:=d+length(inttostr(offset))+1;
            Memo2.SelStart:=d+5;
            Memo2.SelLength:=1;
            Memo2.SelAttributes.BackColor:=SelAttributes;
            d:=Memo2.GetTextLen-Memo2.Lines.Count;
          end;
        end;
        ii:=PosInIni;
        for j:=1 to StrToInt(tmp_value) do begin
          Memo2.Lines.Add('[Начало повторяющегося блока '+inttostr(j)+'/'+tmp_value+']');
          d:=Memo2.GetTextLen-Memo2.Lines.Count;
          PosInIni:=ii;
          for jj:=1 to StrToInt(tmp_param) do begin
            Param0:=GetType(StrIni,PosInIni);
            inc(PosInIni);
            typ:=GetTyp(Param0); //считываем тип значения
            name:=GetName(Param0); //считываем имя значения в скобках (name:func.1.2)
            func:=uppercase(GetFunc(Param0)); //считываем имя функции в скобках (name:func.par)
            param1:=uppercase(GetParam(Param0)); //считываем имя значения в скобках (name:func.1.2)
            param2:=GetParam2(Param0); //считываем имя значения в скобках (name:func.1.2)
            offset:=PosinPkt-11;
            value:=GetValue(typ, name, PktStr, PosInPkt, size, memo3);
            if uppercase(Func)='GET' then begin
              if param1='FUNC01' then   value:=GetFunc01(strtoint(value)) else
              if param1='FUNC02' then   value:=GetFunc02(strtoint(value)) else
              if param1='FUNC09' then   value:=GetFunc09(id, strtoint(value)) else
              if param1='CLASSID' then  value:=GetClassID(strtoint(value)) else
              if param1='FSUP' then     value:=GetFsup(strtoint(value)) else
              if param1='NPCID' then    value:=GetNpcID(strtoint(value)) else
              if param1='MSGID' then    value:=GetMsgID(strtoint(value)) else
              if param1='SKILL' then    value:=GetSkill(strtoint(value));
            end;
            //распечатываем
            Memo2.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value);
            //Memo2.SelStart:=d+length(inttostr(offset))+1;
            Memo2.SelStart:=d+5;
            Memo2.SelLength:=1;
            Memo2.SelAttributes.BackColor:=SelAttributes;
            d:=Memo2.GetTextLen-Memo2.Lines.Count;
          end;
          Memo2.Lines.Add('[Конец повторяющегося блока  '+inttostr(j)+'/'+tmp_value+']');
          d:=Memo2.GetTextLen-Memo2.Lines.Count;
        end;
      end else begin
        //распечатываем
        Memo2.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue);
        //Memo2.SelStart:=d+length(inttostr(offset))+1;
        Memo2.SelStart:=d+5;
        Memo2.SelLength:=1;
        Memo2.SelAttributes.BackColor:=SelAttributes;
        d:=Memo2.GetTextLen-Memo2.Lines.Count;
      end;
    end;
    //Memo2.Lines.EndUpdate;
  end;
end;

//по двойному клику на строке выделяем место, где расположены данные
procedure TL2PacketHackMain.Memo2DblClick(Sender: TObject);
var
 i, j: integer;
 str, str2: string;
begin
 str:=Memo2.Lines.Strings[Memo2.CaretPos.Y]; //считываем строку под курсором
 try
   case typ0[1] of
     'd': SelAttributes:=$aadfdf;
     'c': SelAttributes:=$aaaadf;
     'f': SelAttributes:=$dfaaaa;
     'h': SelAttributes:=$dfaadf;
     'q': SelAttributes:=$aadfd0;
     's': SelAttributes:=$dfdfaa;
     else SelAttributes:=clWhite; //ошибочный тип переменной
   end;
   if typ0<>'я' then begin
     Memo3.SelAttributes.BackColor:=SelAttributes;
     Memo3.SelAttributes.Color:=clBlack;
   end;
   i:=strtoint('$'+copy(str,1,4));
   Memo3.SelStart:=(i-1)*3;
   case str[6] of
     'd': begin Memo3.SelLength:=11; typ0:='d'; end;
     'c': begin Memo3.SelLength:=2; typ0:='c'; end;
     'f': begin Memo3.SelLength:=23; typ0:='f'; end;
     'h': begin Memo3.SelLength:=5; typ0:='h'; end;
     'q': begin Memo3.SelLength:=23; typ0:='q'; end;
     's': begin
         str2:=Memo2.Lines.Strings[Memo2.CaretPos.Y+1]; //считываем следующую строку
         if str2[1]='[' then begin
           str2:=Memo2.Lines.Strings[Memo2.CaretPos.Y+2];
           if str2[1]='[' then str2:=Memo2.Lines.Strings[Memo2.CaretPos.Y+3];
         end;
         j:=strtoint('$'+copy(str2,1,4));
         Memo3.SelLength:=(j-i)*3-1;
         if Memo3.SelLength=0 then Memo3.SelLength:=2;
         typ0:='s';
     end;
     else Memo3.SelLength:=0; //ошибочный тип переменной
   end;
   Memo3.SelAttributes.BackColor:=clBlue;
   Memo3.SelAttributes.Color:=clWhite;
   Memo3.SetFocus;
   Memo2.SetFocus;
 except;
   //сообщение об ошибке
 end;
end;

procedure TL2PacketHackMain.Memo2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Memo2DblClick(Sender);
end;

procedure TL2PacketHackMain.Memo2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Memo2DblClick(Sender);
end;

//закладка "посылка"
procedure TL2PacketHackMain.Memo4Change(Sender: TObject);
var
  i,k:Integer;
  temp: string;
  p: TPoint;
  b: Boolean;
begin
 //Memo4.Lines.BeginUpdate;
  p:=Memo4.CaretPos;
  b:=False;
  for k := 0 to Memo4.Lines.Count-1 do begin
    temp:=Memo4.Lines[k];
    for i := 1 to Length(temp) do
      if not(temp[i] in ['0'..'9','a'..'f','A'..'F',' ']) then begin
        temp[i]:=' ';
        b:=True;
      end;
    if b then Memo4.Lines[k]:=temp;
  end;
  Memo4.CaretPos:=p;
  //Memo4KeyDown(Sender,d,TShiftState(0));
  //Memo4.Lines.EndUpdate;
end;
procedure TL2PacketHackMain.Memo4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  RadioButton1Click(Sender);
end;

procedure TL2PacketHackMain.Memo4KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  RadioButton1Click(Sender);
end;

procedure TL2PacketHackMain.Memo4MouseEnter(Sender: TObject);
begin
  RadioButton1Click(Sender);
end;
procedure TL2PacketHackMain.Memo4MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RadioButton1Click(Sender);
end;

procedure TL2PacketHackMain.RadioButton1Click(Sender: TObject);
var
  //sid,
  ii, j, jj: Integer;
  id: Byte;
  Size: Word;
  PktStr, StrIni, Param0: string;
  d, PosInIni, PosInPkt, offset: integer;
  //ptime: TDateTime;
  SubID: word;
  typ, name,func, tmp_param, param1, param2: string;
  value, tmp_value: string;
begin
  PktStr:=StringOfChar(' ',11)+HexToString(Memo4.Lines[Memo4.CaretPos.Y]);
  Size:=Length(PktStr)-9;
  if Size>2 then begin
    id:=Byte(PktStr[12]);                   //фактическое начало пакета, ID
    SubId:=Word(id shl 8+Byte(PktStr[13])); //считываем SubId
    Memo5.Lines.BeginUpdate;
    Memo5.Clear;
    Memo5.Lines.Add(StringToHex(Copy(PktStr,12,Length(PktStr)-11),' '));
    //считываем строку из packets.ini для парсинга
    if RadioButton2.Checked then begin //client
      if (ID in [$39,$D0]) and (size>3) then begin
        StrIni:=PacketsINI.ReadString('client',IntToHex(subid,4),'Unknow:h(subID)');
      end
      else begin
        StrIni:=PacketsINI.ReadString('client',IntToHex(id,2),'Unknow:');
      end;
    end else begin
      if (ID in [$FE]) and (size>3) then begin
        StrIni:=PacketsINI.ReadString('server',IntToHex(subid,4),'Unknow:h(subID)');
      end
      else begin
        StrIni:=PacketsINI.ReadString('server',IntToHex(id,2),'Unknow:');
      end;
    end;
    //начинаем разбирать пакет по заданному в packets.ini формату
    //смещение в ini
    PosInIni:=Pos(':',StrIni);
    GroupBox9.Caption:='Выделенный пакет: тип - 0x'+IntToHex(id,2)+', '+Copy(StrIni,1,PosInIni-1)+', размер - '+IntToStr(Size);
    //смещение в pkt
    PosInPkt:=13;
    Inc(PosInIni);
    Memo8.Clear;
    Memo8.Lines.Add('Tип: 0x'+IntToHex(id,2)+' ('+Copy(StrIni,1,PosInIni-1)+')');
    Memo8.Lines.Add('Pазмер: '+IntToStr(Size-2)+'+2');
    Memo8.Lines.Add('');
    //GetType - возвращает строчку типа d(Count:For.0001) из packets.ini
    //StrIni - строчка из packets.ini по ID из пакета
    //PktStr - пакет
    //Param0 - строка d(Count:For.0001)
    //PosInIni - смещение в строчке из packets.ini по ID из пакета
    //PosInPkt - смещение в пакете
    Memo5.SelStart:=0;
    Memo5.SelLength:=2;
    Memo5.SelAttributes.BackColor:=$aaaadf;
    Memo8.SelStart:=5;
    Memo8.SelLength:=4;
    Memo8.SelAttributes.BackColor:=$aaaadf;
    d:=Memo8.GetTextLen-Memo8.Lines.Count;
    while (PosInIni>1)and(PosInIni<Length(StrIni))and(PosInPkt<Size+10) do begin
      Param0:=GetType(StrIni,PosInIni);
      inc(PosInIni);
      typ:=GetTyp(Param0); //считываем тип значения
      name:=GetName(Param0); //считываем имя значения в скобках (name:func.par)
      func:=uppercase(GetFunc(Param0)); //считываем имя функции в скобках (name:func.par)
      param1:=uppercase(GetParam(Param0)); //считываем имя значения в скобках (name:func.1.2)
      param2:=GetParam2(Param0); //считываем имя значения в скобках (name:func.1.2)
      offset:=PosinPkt-11;
      value:=GetValue(typ, name, PktStr, PosInPkt, size, memo5); //считываем значение, сдвигаем указатели в соответствии с типом значения
      if uppercase(Func)='GET' then begin
        if param1='FUNC01' then   value:=GetFunc01(strtoint(value)) else
        if param1='FUNC02' then   value:=GetFunc02(strtoint(value)) else
        if param1='FUNC09' then   value:=GetFunc09(id, strtoint(value)) else
        if param1='CLASSID' then  value:=GetClassID(strtoint(value)) else
        if param1='FSUP' then     value:=GetFsup(strtoint(value)) else
        if param1='NPCID' then    value:=GetNpcID(strtoint(value)) else
        if param1='MSGID' then    value:=GetMsgID(strtoint(value)) else
        if param1='SKILL' then    value:=GetSkill(strtoint(value));
        Memo8.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value);
        Memo8.SelStart:=d+5;
        Memo8.SelLength:=1;
        Memo8.SelAttributes.BackColor:=SelAttributes;
        d:=Memo8.GetTextLen-Memo8.Lines.Count;
      end else
      //для С4, С5 и Т0-Интерлюдия
      if uppercase(Func)='FOR' then begin
        //распечатываем
        Memo8.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue);
        Memo8.SelStart:=d+5;
        Memo8.SelLength:=1;
        Memo8.SelAttributes.BackColor:=SelAttributes;
        d:=Memo8.GetTextLen-Memo8.Lines.Count;
        tmp_param:=param1;
        tmp_value:=value;
        ii:=PosInIni;
        if value='range error' then exit;
        if StrToInt(value)=0 then begin
          //пропускаем пустые значения
          for jj:=1 to StrToInt(param1) do begin
            Param0:=GetType(StrIni,PosInIni);
            inc(PosInIni);
          end;
        end else begin
          for j:=1 to StrToInt(tmp_value) do begin
            Memo8.Lines.Add('[Начало повторяющегося блока '+inttostr(j)+'/'+tmp_value+']');
            d:=Memo8.GetTextLen-Memo8.Lines.Count;
            PosInIni:=ii;
            for jj:=1 to StrToInt(tmp_param) do begin
              Param0:=GetType(StrIni,PosInIni);
              inc(PosInIni);
              typ:=GetTyp(Param0); //считываем тип значения
              name:=GetName(Param0); //считываем имя значения в скобках (name:func.1)
              func:=uppercase(GetFunc(Param0)); //считываем имя функции в скобках (name:func.par)
              param1:=uppercase(GetParam(Param0)); //считываем имя значения в скобках (name:func.1.2)
              //param2:=GetParam2(Param0); //считываем имя значения в скобках (name:func.1)
              offset:=PosinPkt-11;
              value:=GetValue(typ, name, PktStr, PosInPkt, size, memo5);
              if uppercase(Func)='GET' then begin
                if param1='FUNC01' then   value:=GetFunc01(strtoint(value)) else
                if param1='FUNC02' then   value:=GetFunc02(strtoint(value)) else
                if param1='FUNC09' then   value:=GetFunc09(id, strtoint(value)) else
                if param1='CLASSID' then  value:=GetClassID(strtoint(value)) else
                if param1='FSUP' then     value:=GetFsup(strtoint(value)) else
                if param1='NPCID' then    value:=GetNpcID(strtoint(value)) else
                if param1='MSGID' then    value:=GetMsgID(strtoint(value)) else
                if param1='SKILL' then    value:=GetSkill(strtoint(value));
              end;
              Memo8.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value);
              Memo8.SelStart:=d+5;
              Memo8.SelLength:=1;
              Memo8.SelAttributes.BackColor:=SelAttributes;
              d:=Memo8.GetTextLen-Memo8.Lines.Count;
            end;
            Memo8.Lines.Add('[Конец повторяющегося блока  '+inttostr(j)+'/'+tmp_value+']');
            d:=Memo8.GetTextLen-Memo8.Lines.Count;
          end;
        end;
      end else
      //для Т1-Камаель
      if uppercase(Func)='LOOP' then begin
        //распечатываем
        Memo8.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue);
        Memo8.SelStart:=d+5;
        Memo8.SelLength:=1;
        Memo8.SelAttributes.BackColor:=SelAttributes;
        d:=Memo8.GetTextLen-Memo8.Lines.Count;
        //проверку что param1=1?
        tmp_param:=param2;
        tmp_value:=value;
        if value='range error' then exit;
        if strtoint(param1)>1 then begin
          //распечатываем значения
          for jj:=1 to StrToInt(param1)-1 do begin
            Param0:=GetType(StrIni,PosInIni);
            inc(PosInIni);
            typ:=GetTyp(Param0); //считываем тип значения
            name:=GetName(Param0); //считываем имя значения в скобках (name:func.1.2)
            func:=uppercase(GetFunc(Param0)); //считываем имя функции в скобках (name:func.par)
            param1:=uppercase(GetParam(Param0)); //считываем имя значения в скобках (name:func.1.2)
            param2:=GetParam2(Param0); //считываем имя значения в скобках (name:func.1.2)
            offset:=PosinPkt-11;
            value:=GetValue(typ, name, PktStr, PosInPkt, size, memo5);
            //распечатываем
            Memo8.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue);
            Memo8.SelStart:=d+5;
            Memo8.SelLength:=1;
            Memo8.SelAttributes.BackColor:=SelAttributes;
            d:=Memo8.GetTextLen-Memo8.Lines.Count;
          end;
        end;
        ii:=PosInIni;
        for j:=1 to StrToInt(tmp_value) do begin
          Memo8.Lines.Add('[Начало повторяющегося блока '+inttostr(j)+'/'+tmp_value+']');
          d:=Memo8.GetTextLen-Memo8.Lines.Count;
          PosInIni:=ii;
          for jj:=1 to StrToInt(tmp_param) do begin
            Param0:=GetType(StrIni,PosInIni);
            inc(PosInIni);
            typ:=GetTyp(Param0); //считываем тип значения
            name:=GetName(Param0); //считываем имя значения в скобках (name:func.1.2)
            func:=uppercase(GetFunc(Param0)); //считываем имя функции в скобках (name:func.par)
            param1:=uppercase(GetParam(Param0)); //считываем имя значения в скобках (name:func.1.2)
            param2:=GetParam2(Param0); //считываем имя значения в скобках (name:func.1.2)
            offset:=PosinPkt-11;
            value:=GetValue(typ, name, PktStr, PosInPkt, size, memo5);
            if uppercase(Func)='GET' then begin
              if param1='FUNC01' then   value:=GetFunc01(strtoint(value)) else
              if param1='FUNC02' then   value:=GetFunc02(strtoint(value)) else
              if param1='FUNC09' then   value:=GetFunc09(id, strtoint(value)) else
              if param1='CLASSID' then  value:=GetClassID(strtoint(value)) else
              if param1='FSUP' then     value:=GetFsup(strtoint(value)) else
              if param1='NPCID' then    value:=GetNpcID(strtoint(value)) else
              if param1='MSGID' then    value:=GetMsgID(strtoint(value)) else
              if param1='SKILL' then    value:=GetSkill(strtoint(value));
            end;
            //распечатываем
            Memo8.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value);
            Memo8.SelStart:=d+5;
            Memo8.SelLength:=1;
            Memo8.SelAttributes.BackColor:=SelAttributes;
            d:=Memo8.GetTextLen-Memo8.Lines.Count;
          end;
          Memo8.Lines.Add('[Конец повторяющегося блока  '+inttostr(j)+'/'+tmp_value+']');
          d:=Memo8.GetTextLen-Memo8.Lines.Count;
        end;
      end else begin
        //распечатываем
        Memo8.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue);
        Memo8.SelStart:=d+5;
        Memo8.SelLength:=1;
        Memo8.SelAttributes.BackColor:=SelAttributes;
        d:=Memo8.GetTextLen-Memo8.Lines.Count;
      end;
    end;
    Memo5.Lines.EndUpdate;
  end else begin
    Memo8.Clear;
    Memo5.Clear;
    GroupBox9.Caption:='Выделенный пакет:';
  end;
end;

//по двойному клику на строке выделяем место, где расположены данные
procedure TL2PacketHackMain.Memo8DblClick(Sender: TObject);
var
 i, j: integer;
 str, str2: string;
begin
 str:=Memo8.Lines.Strings[Memo8.CaretPos.Y]; //считываем строку под курсором
 try
   case typ0[1] of
     'd': SelAttributes:=$aadfdf;
     'c': SelAttributes:=$aaaadf;
     'f': SelAttributes:=$dfaaaa;
     'h': SelAttributes:=$dfaadf;
     'q': SelAttributes:=$aadfd0;
     's': SelAttributes:=$dfdfaa;
     else SelAttributes:=clWhite; //ошибочный тип переменной
   end;
   if typ0<>'я' then begin
     Memo5.SelAttributes.BackColor:=SelAttributes;
     Memo5.SelAttributes.Color:=clBlack;
   end;
   i:=strtoint('$'+copy(str,1,4));
   Memo5.SelStart:=(i-1)*3;
   case str[6] of
     'd': begin Memo5.SelLength:=11; typ0:='d'; end;
     'c': begin Memo5.SelLength:=2; typ0:='c'; end;
     'f': begin Memo5.SelLength:=23; typ0:='f'; end;
     'h': begin Memo5.SelLength:=5; typ0:='h'; end;
     'q': begin Memo5.SelLength:=23; typ0:='q'; end;
     's': begin
         str2:=Memo8.Lines.Strings[Memo8.CaretPos.Y+1]; //считываем следующую строку
         if str2[1]='[' then begin
           str2:=Memo8.Lines.Strings[Memo8.CaretPos.Y+2];
           if str2[1]='[' then str2:=Memo8.Lines.Strings[Memo8.CaretPos.Y+3];
         end;
         j:=strtoint('$'+copy(str2,1,4));
         Memo5.SelLength:=(j-i)*3-1;
         if Memo5.SelLength=0 then Memo5.SelLength:=2;
         typ0:='s';
     end;
     else Memo5.SelLength:=0; //ошибочный тип переменной
   end;
   Memo5.SelAttributes.BackColor:=clBlue;
   Memo5.SelAttributes.Color:=clWhite;
   Memo5.SetFocus;
   Memo8.SetFocus;
 except;
   //игнорим сообщение об ошибке
 end;
end;

procedure TL2PacketHackMain.Memo8KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
Memo8DblClick(Sender);
end;

procedure TL2PacketHackMain.Memo8MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Memo8DblClick(Sender);
end;

procedure TL2PacketHackMain.N6Click(Sender: TObject);
begin
  clbPluginsList.Checked[TMenuItem(Sender).MenuIndex]:=TMenuItem(Sender).Checked;
  clbPluginsListClickCheck(nil);
end;

procedure TL2PacketHackMain.N7Click(Sender: TObject);
begin
  ScriptsList.Checked[TMenuItem(Sender).MenuIndex]:=TMenuItem(Sender).Checked;
  ScriptsListClickCheck(nil);
end;

procedure TL2PacketHackMain.Memo6Change(Sender: TObject);
begin
  if CheckBox8.Checked then Button4Click(Sender);
end;

procedure TL2PacketHackMain.Memo7Change(Sender: TObject);
begin
  if CheckBox8.Checked then Button5Click(Sender);
end;

procedure TL2PacketHackMain.PacketSend(var msg: TMessage);
{посылают потоки! рисуем в ListView5 расшифровку пакетов}
var
  tid, from, id: Byte;
  subid: word;
  PktStr: string;
  i, PckCount: integer;
//  h1: Byte;
begin
  tid:=Byte(msg.WParam and $FF);
  PckCount:=msg.LParam;
  if tid=CID then begin
    from:=Byte((msg.WParam shr 8) and $FF); //клиент=1, сервер=0
    //для ускорения работы берем только 4 байта с ID пакета
    EnterCriticalSection(_cs);
    PktStr:=HexToString(Copy(Thread[CID].Dump.Strings[PckCount],23,4));
    LeaveCriticalSection(_cs);
    if Length(PktStr)=0 then Exit;         // если пустой пакет выходим
    id:=Byte(PktStr[1]);                   //фактическое начало пакета, ID
    SubId:=Word(id shl 8+Byte(PktStr[2])); //считываем SubId
    //------------------------------------------------------------------------
    //расшифровываем коды пакетов и вносим неизвестные в списки пакетов
    if from=0 then begin
      //от сервера
      if id=$FE then begin
        //находим индекс пакета
        i:=PacketsFromS.IndexOfName(IntToHex(subid,4));
        if i=-1 then  begin
          //неизвестный пакет от сервера
          with ListView5.Items.Add do begin
            //имя пакета
            Caption:='Unknown';
            //код иконки
            ImageIndex:=0;
            //номер пакета по порядку
            SubItems.Add(IntToStr(PckCount));
            //код пакета
            SubItems.Add(IntToHex(subid,4));
            //добавляем в список пакетов так как его там нет
            with ListView1.Items.Add do
            begin
              Caption:=(IntToHex(subid,4));
              Checked:=True;
              SubItems.Add('Unknown');
              PacketsFromS.Append(IntToHex(subid,4)+'=Unknown:h(SubId)');
            end;
            if ToolButton5.Down then MakeVisible(false);
          end;
        end else begin
          if ToolButton4.Down and (ListView1.Items.Item[i].Checked) then begin
            with ListView5.Items.Add do begin
              //имя пакета
              Caption:=ListView1.Items.Item[i].SubItems[0];
              //код иконки
              ImageIndex:=0;
              //номер пакета по порядку
              SubItems.Add(IntToStr(PckCount));
              //код пакета
              SubItems.Add(IntToHex(subid,4));
              if ToolButton5.Down then MakeVisible(false);
            end;
          end;
        end;
      end else begin
        i:=PacketsFromS.IndexOfName(IntToHex(id,2));
        if i=-1 then begin
          //неизвестный пакет от сервера
          with ListView5.Items.Add do begin
            //имя пакета
            Caption:='Unknown';
            //код иконки
            ImageIndex:=0;
            //номер пакета по порядку
            SubItems.Add(IntToStr(PckCount));
            //код пакета
            SubItems.Add(IntToHex(id,2));
            //добавляем в список пакетов так как его там нет
            with ListView1.Items.Add do
            begin
              Caption:=(IntToHex(id,2));
              Checked:=True;
              SubItems.Add('Unknown');
              PacketsFromS.Append(IntToHex(id,2)+'=Unknown:');
            end;
            if ToolButton5.Down then MakeVisible(false);
          end;
        end else begin
          if ToolButton4.Down and (ListView1.Items.Item[i].Checked) then begin
            with ListView5.Items.Add do begin
              //имя пакета
              Caption:=ListView1.Items.Item[i].SubItems[0];
              //проверить что быстрее будет!!!
              //Caption:=PacketsFromS.Values[IntToHex(id,2)];
              //код иконки
              ImageIndex:=0;
              //номер пакета по порядку
              SubItems.Add(IntToStr(PckCount));
              //код пакета
              SubItems.Add(IntToHex(id,2));
              if ToolButton5.Down then MakeVisible(false);
            end;
          end;
        end;
      end;
    end else begin
      //от клиента
      if (id in [$39,$D0]) then begin
        i:=PacketsFromC.IndexOfName(IntToHex(subid,4));
        if i=-1 then begin
          //неизвестный пакет от сервера
          with ListView5.Items.Add do begin
            //имя пакета
            Caption:='Unknown';
            //код иконки
            ImageIndex:=0;
            //номер пакета по порядку
            SubItems.Add(IntToStr(PckCount));
            //код пакета
            SubItems.Add(IntToHex(subid,4));
            //добавляем в список пакетов так как его там нет
            with ListView2.Items.Add do
            begin
              Caption:=(IntToHex(subid,4));
              Checked:=True;
              SubItems.Add('Unknown');
              PacketsFromC.Append(IntToHex(subid,4)+'=Unknown:h(SubId)');
            end;
            if ToolButton5.Down then MakeVisible(false);
          end;
        end else begin
          if ToolButton3.Down and (ListView2.Items.Item[i].Checked) then begin
            with ListView5.Items.Add do begin
              //имя пакета
              Caption:=ListView2.Items.Item[i].SubItems[0];
              //код иконки
              ImageIndex:=1;
              //номер пакета по порядку
              SubItems.Add(IntToStr(PckCount));
              //код пакета
              SubItems.Add(IntToHex(subid,4));
              if ToolButton5.Down then MakeVisible(false);
            end;
          end;
        end;
      end else begin
        i:=PacketsFromC.IndexOfName(IntToHex(id,2));
        if i=-1 then begin
          //неизвестный пакет от сервера
          with ListView5.Items.Add do begin
            //имя пакета
            Caption:='Unknown';
            //код иконки
            ImageIndex:=0;
            //номер пакета по порядку
            SubItems.Add(IntToStr(PckCount));
            //код пакета
            SubItems.Add(IntToHex(id,2));
            //добавляем в список пакетов так как его там нет
            with ListView2.Items.Add do
            begin
              Caption:=(IntToHex(id,2));
              Checked:=True;
              SubItems.Add('Unknown');
              PacketsFromC.Append(IntToHex(id,2)+'=Unknown:');
            end;
            if ToolButton5.Down then MakeVisible(false);
          end;
        end else begin
          if ToolButton3.Down and (ListView2.Items.Item[i].Checked) then begin
            with ListView5.Items.Add do begin
              //имя пакета
              Caption:=ListView2.Items.Item[i].SubItems[0];
              //код иконки
              ImageIndex:=1;
              //номер пакета по порядку
              SubItems.Add(IntToStr(PckCount));
              //код пакета
              SubItems.Add(IntToHex(id,2));
              if ToolButton5.Down then MakeVisible(false);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TL2PacketHackMain.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage=TabSheet6 then JvHLEditor1.SetFocus;
end;

procedure TL2PacketHackMain.Button14Click(Sender: TObject);
var
  PktStr: string;
  i, indx: Integer;
  tmpItm: TListItem;
  from, id: Byte;
  subid: word;
begin
  tmpItm:=ListView5.Selected;
  for i:=0 to ListView5.SelCount-1 do begin
    EnterCriticalSection(_cs);
    PktStr:=HexToString(Thread[cid].Dump.Strings[StrToInt(tmpItm.SubItems.Strings[0])]);
    LeaveCriticalSection(_cs);
    if Length(PktStr)<12 then Exit;
    from:=Byte(PktStr[1]);   //клиент=4, сервер=3
    id:=Byte(PktStr[12]);   //фактическое начало пакета, ID
    SubId:=Word(id shl 8+Byte(PktStr[13])); //считываем SubId
    if from=4 then begin
      //от клиента
      if (id in [$39,$D0]) then begin
        //находим индекс пакета
        indx:=PacketsFromC.IndexOfName(IntToHex(subid,4));
        if indx>-1 then ListView2.Items.Item[indx].Checked:=False;
      end else begin
        indx:=PacketsFromC.IndexOfName(IntToHex(id,2));
        if indx>-1 then ListView2.Items.Item[indx].Checked:=False;
      end;
    end else begin
      //от сервера
      if id=$FE then begin
        //находим индекс пакета
        indx:=PacketsFromS.IndexOfName(IntToHex(subid,4));
        if indx>-1 then ListView1.Items.Item[indx].Checked:=False;
      end else begin
        indx:=PacketsFromS.IndexOfName(IntToHex(id,2));
        if indx>-1 then ListView1.Items.Item[indx].Checked:=False;
      end;
    end;
    tmpItm:=ListView5.GetNextItem(tmpItm,sdAll,[isSelected]);
  end;
  ListView1Click(Sender);
  //удалили значит выключаем кнопку
  tbtnFilterDel.Enabled:=false;
  tbtnDelete.Enabled:=false;
end;

procedure TL2PacketHackMain.Timer1Timer(Sender: TObject);
var
  tmp: TStrings;
  i,k: Integer;
  cc: Cardinal;
  ListSearch: string; // список процессов которые будем искать
begin
  ListSearch := ';'+LowerCase(LabeledEdit1.Text); // в нижний регистр
  // убираем все пробелы
  ListSearch := StringReplace (ListSearch, ' ', '', [rfReplaceAll]);
  // наслучай если пользователь использует ,  меняем ее на ;
  // и добавляем в конец строки ;  в поиске он нам не помешает а вот если его нет,
  // то процесс не найдется
  ListSearch := StringReplace (ListSearch, ',', ';', [rfReplaceAll])+';';
  tmp:=TStringList.Create;
  GetProcessList(tmp);
  for i:=0 to tmp.Count-1 do begin
    // ненадо проверять по количеству процессов (tmp.Count <> ListBox1.Items.Count)
    // наслучай если поле было отредактировано
    if (ListBox1.Items.IndexOf(tmp.ValueFromIndex[i]+' ('+tmp.Names[i]+')')=-1) then begin
      ListBox1.Items.Clear;
      ListBox2.Items.Clear;
      for k := 0 to tmp.Count - 1 do begin
        // добавляем в лист запущеных процессов
        ListBox1.Items.Add(tmp.ValueFromIndex[k]+' ('+tmp.Names[k]+')');
        //сравниваем найденные программы со списком необходимых программ
        if AnsiPos(';'+tmp.ValueFromIndex[k]+';', ListSearch) > 0  then
        begin
          if isIntercept and (Processes.Values[tmp.Names[k]]='') then begin
            Processes.Values[tmp.Names[k]]:='error';
            cc:=OpenProcess(PROCESS_ALL_ACCESS,False,StrToInt(tmp.Names[k]));
            if RadioGroup1.ItemIndex=0 then begin
              if InjectDll(cc, PChar(ExtractFilePath(ParamStr(0))+'inject.dll')) then begin
                Processes.Values[tmp.Names[k]]:='ok';
                sendMsg ('Надёжно пропатчен новый клиент '+tmp.ValueFromIndex[k]+' ('+tmp.Names[k]+') ');
              end;
            end else begin
              if InjectDllEx(cc, dllScr) then begin
                Processes.Values[tmp.Names[k]]:='ok';
                sendMsg ('Скрытно пропатчен новый клиент '+tmp.ValueFromIndex[k]+' ('+tmp.Names[k]+') ');
              end;
            end;
            CloseHandle(cc);
          end;
          ListBox2.Items.Add(tmp.ValueFromIndex[k]+' ('+tmp.Names[k]+') '+Processes.Values[tmp.Names[k]]);
        end;
      end;
    end;
  end;
  tmp.Free;
end;

procedure TL2PacketHackMain.Timer2Timer(Sender: TObject);
begin
  if CheckBox12.Checked then Button11Click(Sender);
end;

procedure TL2PacketHackMain.ToolButton10Click(Sender: TObject);
begin
  if ProtocolVersion=560 then exit;
  ProtocolVersion:=560; //C4
  LoadPacketsIni;
  ListView1Click(Sender);
end;

procedure TL2PacketHackMain.ToolButton11Click(Sender: TObject);
begin
  if ProtocolVersion=660 then exit;
  ProtocolVersion:=660; //C5
  LoadPacketsIni;
  ListView1Click(Sender);
end;

procedure TL2PacketHackMain.ToolButton12Click(Sender: TObject);
begin
  if ProtocolVersion=737 then exit;
  ProtocolVersion:=737; //T0
  LoadPacketsIni;
  ListView1Click(Sender);
end;

procedure TL2PacketHackMain.ToolButton13Click(Sender: TObject);
begin
  if ProtocolVersion=828 then exit;
  ProtocolVersion:=828; //T1
  LoadPacketsIni;
  ListView1Click(Sender);
end;

procedure TL2PacketHackMain.ToolButton3Click(Sender: TObject);
begin
  if ToolButton3.Down then ToolButton3.Down:=true else ToolButton3.Down:=false;
  Options.WriteBool('Snifer','FromClient',ToolButton3.Down);
  Options.UpdateFile;
  ListView1Click(Sender);
end;

procedure TL2PacketHackMain.ToolButton4Click(Sender: TObject);
begin
  if ToolButton4.Down then begin
    ToolButton4.Down:=true;
    ListView1Click(Sender);
  end else begin
    ToolButton4.Down:=false;
  end;
  Options.WriteBool('Snifer','FromServer',ToolButton4.Down);
  Options.UpdateFile;
  ListView1Click(Sender);
end;

procedure TL2PacketHackMain.ToolButton5Click(Sender: TObject);
begin
  if ToolButton5.Down then begin
    ToolButton5.Down:=true;
  end else begin
    ToolButton5.Down:=false;
  end;
  Options.WriteBool('Snifer','Scroll',ToolButton5.Down);
  Options.UpdateFile;
end;

procedure TL2PacketHackMain.ToolButton6Click(Sender: TObject);
//var
//  i,k: Integer;
//  data: array[0..255] of Byte;
//  temp: string;
begin
  Panel15.Visible:=ToolButton6.Down;

  Options.WriteBool('Snifer','ShowFilters',ToolButton6.Down);
  Options.UpdateFile;
  end;

procedure TL2PacketHackMain.ToolButton7Click(Sender: TObject);
begin
  if ToolButton7.Down then begin
    ToolButton7.Down:=true;
    isSaveLog:=true;
  end else begin
    ToolButton7.Down:=false;
    isSaveLog:=false;
  end;
  Options.WriteBool('Snifer','SaveLog',isSaveLog);
  Options.UpdateFile;
end;

procedure TL2PacketHackMain.ToolButton8Click(Sender: TObject);
begin
  //считываем sysmsgid.ini
  SysMsgIdList.LoadFromFile(ExtractFilePath(Application.ExeName)+'sysmsgid.ini');
  //считываем ItemsID.ini
  ItemsList.LoadFromFile(ExtractFilePath(Application.ExeName)+'ItemsID.ini');
  //считываем Npcid.ini
  NpcIdList.LoadFromFile(ExtractFilePath(Application.ExeName)+'npcsid.ini');
  //считываем ClassId.ini
  ClassIdList.LoadFromFile(ExtractFilePath(Application.ExeName)+'classid.ini');
  //считываем SkillsID.ini
  SkillList.LoadFromFile(ExtractFilePath(Application.ExeName)+'SkillsID.ini');
  //считываем packets??.ini
  LoadPacketsIni;

  ListView1Click(Sender);
end;

procedure TL2PacketHackMain.ApplicationEvents1Activate(Sender: TObject);
begin
//  ShowWindow(Application.Handle, SW_HIDE);
  NoServer:=False;
end;

procedure TL2PacketHackMain.ApplicationEvents1Hint(Sender: TObject);
begin
  StatusBar1.SimpleText:=Application.Hint;
end;

function TL2PacketHackMain.Compile(var fsScript: TfsScript; var JvHLEditor: TJvHLEditor): Boolean;
var
  ps,x,y: Integer;
begin
  RefreshPrecompile(fsScript);
  fsScript.Lines:=JvHLEditor.Lines;
  if not fsScript.Compile then begin
//    StaticText2.Caption:=fsScript1.ErrorMsg+' - '+fsScript1.ErrorPos;
    ps:=Pos(':',fsScript.ErrorPos);
    x:=StrToInt(Copy(fsScript.ErrorPos,ps+1,length(fsScript.ErrorPos)-ps));
    y:=StrToInt(Copy(fsScript.ErrorPos,1,ps-1));
{    fsSyntaxMemo.SetFocus;
    fsSyntaxMemo.SetPos(x,y);
    fsSyntaxMemo.ShowMessage(fsScript.ErrorMsg);
    fsSyntaxMemo.SetActiveLine(y-1);}
    JvHLEditor.SetFocus;
    JvHLEditor.SetCaret(x-1,y-1);
    JvHLEditor.SelectWordOnCaret;
    JvHLEditor.SelBackColor:=clRed;
    StatusBar1.SimpleText:='Ошибка: '+fsScript.ErrorMsg;
    Result:=False;
  end else begin
    StatusBar1.SimpleText:='Скрипт проверен';
    Result:=True;
  end;
end;

procedure TL2PacketHackMain.Button8Click(Sender: TObject);
begin
  SaveDialog1.FilterIndex:=2;
  if SaveDialog1.Execute then JvHLEditor2.Lines.SaveToFile(SaveDialog1.FileName);
  SaveDialog1.FilterIndex:=1;
end;

procedure TL2PacketHackMain.Button9Click(Sender: TObject);
var
  dt: TScript;
  ind:integer;
begin
  if ScriptsList.ItemIndex>0 then begin
    ind:=ScriptsList.ItemIndex;
    dt:=scripts[ScriptsList.ItemIndex];
    scripts[ScriptsList.ItemIndex]:=scripts[ScriptsList.ItemIndex-1];
    scripts[ScriptsList.ItemIndex-1]:=dt;
    ScriptsList.Items.Move(ScriptsList.ItemIndex, ScriptsList.ItemIndex-1);
    ScriptsList.ItemIndex:=ind-1;
    if ScriptsList.ItemIndex>0 then Button9.Enabled:=True else Button9.Enabled:=False;
    if ScriptsList.ItemIndex<ScriptsList.Items.Count-1 then Button10.Enabled:=True else Button10.Enabled:=False;
  end;
end;

procedure TL2PacketHackMain.Button10Click(Sender: TObject);
var
  dt: TScript;
  ind:integer;
begin
  if (ScriptsList.ItemIndex>=0)and(ScriptsList.ItemIndex<ScriptsList.Items.Count-1) then begin
    ind:=ScriptsList.ItemIndex;
    dt:=scripts[ScriptsList.ItemIndex];
    scripts[ScriptsList.ItemIndex]:=scripts[ScriptsList.ItemIndex+1];
    scripts[ScriptsList.ItemIndex+1]:=dt;
    ScriptsList.Items.Move(ScriptsList.ItemIndex, ScriptsList.ItemIndex+1);
    ScriptsList.ItemIndex:=ind+1;
    if ScriptsList.ItemIndex>0 then Button9.Enabled:=True else Button9.Enabled:=False;
    if ScriptsList.ItemIndex<ScriptsList.Items.Count-1 then Button10.Enabled:=True else Button10.Enabled:=False;
  end;
end;

procedure TL2PacketHackMain.Button11Click(Sender: TObject);
var
  i: Integer;
  temp: string;
begin
  if ChkOnePacket.Checked then begin
    temp:=HexToString(Memo4.Lines.Text);
    if Length(temp)>=1 then SendPacket(Length(temp)+2,temp,cid,RadioButton2.Checked);
  end else for i:=0 to Memo4.Lines.Count-1 do begin
    temp:=HexToString(Memo4.Lines.Strings[i]);
    if Length(temp)>=1 then SendPacket(Length(temp)+2,temp,cid,RadioButton2.Checked);
  end;
end;

procedure TL2PacketHackMain.Button12Click(Sender: TObject);
begin
  SaveDialog1.FilterIndex:=2;
  if SaveDialog1.Execute then Memo4.Lines.SaveToFile(SaveDialog1.FileName);
  SaveDialog1.FilterIndex:=1;
end;

procedure TL2PacketHackMain.Button13Click(Sender: TObject);
var
  i: Integer;
begin
  if PageControl2.ActivePageIndex=0 then with ListView1.Items do for i:=0 to ListView1.Items.Count-1 do begin
    Item[i].Checked:=not Item[i].Checked;
  end else with ListView2.Items do for i:=0 to ListView2.Items.Count-1 do begin
    Item[i].Checked:=not Item[i].Checked;
  end;
  ListView1Click(Sender);
end;

{
  нажата кнопка "Удалить"
}
procedure TL2PacketHackMain.ButtonDeleteClick(Sender: TObject);
begin
  if ScriptsList.ItemIndex<>-1 then
    if MessageDlg('Вы уверены что хотите удалить скрипт '+Scripts[ScriptsList.ItemIndex].Name+'?'
      +sLineBreak+'Это действие необратимо и приведёт к утрате файла со скриптом.',mtConfirmation,[mbYes, mbNo],0)=mrYes then begin
    DeleteFile(ExtractFilePath(ParamStr(0))+'Scripts\'+Scripts[ScriptsList.ItemIndex].Name+'.txt');
    ScriptsList.ItemEnabled[ScriptsList.ItemIndex] := false; // отключаем текущий ScriptsList.ItemIndex
    ButtonDelete.Enabled := false; // отключаем кнопку Удалить, зачем удалять уже удаленный
    ButtonSave.Enabled := false; // нельзя сохранять удаленный скрипт
  end;
end;

{
  нажали кнопку переименовать
}
procedure TL2PacketHackMain.ButtonRenameClick(Sender: TObject);
var
  s: string;
  r: Boolean;
begin
  if ScriptsList.ItemIndex<>-1 then begin
    s:= Scripts[ScriptsList.ItemIndex].Name;
    r:= true;
    // переименовываем пока скрипт с таким именем есть или не нажата кнопка Cancel
    while fileExists(ExtractFilePath(ParamStr(0))+'Scripts\'+s+'.txt') AND r  do
    begin
      r:= InputQuery('Переименование скрипта','Пожалуйста, укажите новое название',s);
      if not r then exit;
    end;
    RenameFile(ExtractFilePath(ParamStr(0))+'Scripts\'+Scripts[ScriptsList.ItemIndex].Name+'.txt',ExtractFilePath(ParamStr(0))+'Scripts\'+s+'.txt');
    ScriptsList.Items.Strings[ScriptsList.ItemIndex]:=s;
    Scripts[ScriptsList.ItemIndex].Name:=s;
  end;
end;

procedure TL2PacketHackMain.ButtonCheckSyntexClick(Sender: TObject);
begin
  Compile(fsScript1,JvHLEditor1);
end;

{
  Нажата кнопка "Новый скрипт"
}
procedure TL2PacketHackMain.Button18Click(Sender: TObject);
var
  s: string;
  r:Boolean;
begin
  s:='NewScript';
  if not InputQuery('Новый скрипт', 'Пожалуйста, укажите название для создаваемого скрипта',s )then exit;
  r:= true;
  while fileExists(ExtractFilePath(ParamStr(0))+'Scripts\'+s+'.txt') AND r do
     if not InputQuery('Новый скрипт','Такой скрипт существует'+sLineBreak+'Пожалуйста, укажите название для создаваемого скрипта', s) then exit;
  JvHLEditor1.Lines.Clear;
  JvHLEditor1.Lines.Text:=
    'procedure Init; //Вызывается при включении скрипта'+sLineBreak+
    'begin'+sLineBreak+sLineBreak+
    'end;'+sLineBreak+sLineBreak+
    'procedure Free; //Вызывается при выключении скрипта'+sLineBreak+
    'begin'+sLineBreak+sLineBreak+
    'end;'+sLineBreak+sLineBreak+
    'procedure OnConnect(WithClient: Boolean); //Вызывается при установке соединения'+sLineBreak+
    'begin'+sLineBreak+sLineBreak+
    'end;'+sLineBreak+sLineBreak+
    'procedure OnDisonnect(WithClient: Boolean); //Вызывается при потере соединения'+sLineBreak+
    'begin'+sLineBreak+sLineBreak+
    'end;'+sLineBreak+sLineBreak+
    '//основная часть скрипта'+sLineBreak+
    '//вызывается при приходе каждого пакета если скрипт включен'+sLineBreak+
    'begin'+sLineBreak+sLineBreak+
    'end.';
  JvHLEditor1.Lines.SaveToFile(ExtractFilePath(ParamStr(0))+'Scripts\'+s+'.txt');
  ScriptsList.ItemIndex:=ScriptsList.Items.Add(s);
  Scripts[ScriptsList.ItemIndex].Name:=s;
  Scripts[ScriptsList.ItemIndex].fsScript.Lines:=JvHLEditor1.Lines;
  // отключаем потомучто только что созданном скрипе сохранять нечего
  ButtonSave.Enabled := false;
end;

{
  Нажата кнопка "Загрузить новый"
}
procedure TL2PacketHackMain.ButtonLoadNewClick(Sender: TObject);
var
  s: string;
  r: Boolean;// для проверки не нажат ли Cancel
begin
  if (ScriptsList.ItemIndex<>-1)and ButtonSave.Enabled then if MessageDlg('Желаете сохранить изменения в текущем скрипте прежде чем создадите новый?',mtConfirmation,[mbYes, mbNo],0)=mrYes then ButtonSaveClick(Sender);
  if OpenDialog2.Execute then begin
    JvHLEditor1.Lines.LoadFromFile(OpenDialog2.FileName);
    s:=ExtractFileName(OpenDialog2.FileName);
    s:=Copy(s,1,LastDelimiter('.',s)-1);
    if fileExists(ExtractFilePath(ParamStr(0))+'Scripts\'+s+'.txt') then if MessageDlg('Скрипт с таким названием уже существует, хотите его заменить?',mtConfirmation,[mbYes, mbNo],0)=mrNo then begin
      r := true;
      // будем проверять пока ненажат Cancel или файла с таким именем нету
      while fileExists(ExtractFilePath(ParamStr(0))+'Scripts\'+s+'.txt') AND r do
      begin
        r := InputQuery('Переименование скрипта','Такой скрипт существует'+sLineBreak+'Пожалуйста, укажите новое название', s);
        if not r then exit;
      end;
      ScriptsList.ItemIndex:=ScriptsList.Items.Add(s);
      end else ScriptsList.ItemIndex:=ScriptsList.Items.IndexOf(s)
    else ScriptsList.ItemIndex:=ScriptsList.Items.Add(s);
    JvHLEditor1.Lines.SaveToFile(ExtractFilePath(ParamStr(0))+'Scripts\'+s+'.txt');
    Scripts[ScriptsList.ItemIndex].Name:=s;
    Scripts[ScriptsList.ItemIndex].fsScript.Lines:=JvHLEditor1.Lines;
    // отключаем потомучто в только что загруженном скрипе сохранять нечего
    ButtonSave.Enabled := false;
  end;
end;

procedure TL2PacketHackMain.Button1Click(Sender: TObject);
var
  i: Integer;
begin
  if PageControl2.ActivePageIndex=0 then for i:=0 to ListView1.Items.Count-1 do begin
    ListView1.Items.Item[i].Checked:=True;
  end else for i:=0 to ListView2.Items.Count-1 do begin
    ListView2.Items.Item[i].Checked:=True;
  end;
  ListView1Click(Sender);
end;

procedure TL2PacketHackMain.ButtonSaveClick(Sender: TObject);
begin
  if ScriptsList.ItemIndex<>-1 then begin
    JvHLEditor1.Lines.SaveToFile(ExtractFilePath(ParamStr(0))+'Scripts\'+Scripts[ScriptsList.ItemIndex].Name+'.txt');
    Scripts[ScriptsList.ItemIndex].fsScript.Lines:=JvHLEditor1.Lines;
    Scripts[ScriptsList.ItemIndex].Compilled:=False;
    ButtonSave.Enabled:=False;
    StatusBar1.SimpleText:='Скрипт сохранен';
  end;
end;

procedure TL2PacketHackMain.Button21Click(Sender: TObject);
begin
  if OpenDialog2.Execute then Memo4.Lines.LoadFromFile(OpenDialog2.FileName);
end;

procedure TL2PacketHackMain.Button23Click(Sender: TObject);
begin
  if OpenDialog2.Execute then begin
    EnterCriticalSection(_cs);
    Thread[CID].Dump.LoadFromFile(OpenDialog2.FileName);
    LeaveCriticalSection(_cs);
    ListView1Click(Sender);
  end;
end;

procedure TL2PacketHackMain.BtnClearLogClick(Sender: TObject);
begin
  EnterCriticalSection(_cs);
  Thread[CID].Dump.Clear;
  LeaveCriticalSection(_cs);
  Memo3.Clear;
  Memo2.Clear;
  ListView1Click(Sender);
end;

procedure TL2PacketHackMain.btnRefreshPluginListClick(Sender: TObject);
var
  SearchRec: TSearchRec;
  Mask, s: string;
  i: Integer;
  mi: TMenuItem;
begin
  Mask := ExtractFilePath(ParamStr(0))+'plugins\*.dll';
  clbPluginsList.Clear;
  for i:=0 to High(Plugins) do Plugins[i].Free;
  SetLength(Plugins,0);
  nPlugins.Clear;
  if FindFirst(Mask, faAnyFile, SearchRec) = 0 then
  begin
    repeat
      Application.ProcessMessages;
      if (SearchRec.Attr and faDirectory) <> faDirectory then begin
        SetLength(Plugins,High(Plugins)+2);
        i:=High(Plugins);
        Plugins[i]:=TPlugin.Create;
        Plugins[i].FileName:=ExtractFilePath(ParamStr(0))+'plugins\'+SearchRec.Name;
        s:=Copy(SearchRec.Name,1,Length(SearchRec.Name)-4);
        clbPluginsList.Items.Add(s);
        mi:=TMenuItem.Create(nPlugins);
        nPlugins.Add(mi);
        mi.AutoCheck:=True;
        mi.Checked:=False;
        mi.Caption:=s;
        mi.OnClick:=N6Click;
      end;
    until FindNext(SearchRec)<>0;
    FindClose(SearchRec);
  end;
end;

procedure TL2PacketHackMain.BtnSaveLogClick(Sender: TObject);
begin
  SaveDialog1.FilterIndex:=2;
  if SaveDialog1.Execute then begin
    EnterCriticalSection(_cs);
    Thread[CID].Dump.SaveToFile(SaveDialog1.FileName);
    LeaveCriticalSection(_cs);
  end;
  SaveDialog1.FilterIndex:=1;
end;

procedure TL2PacketHackMain.BtnToSendClick(Sender: TObject);
begin
  Memo4.Lines.Add(Copy(Memo3.Text,1,Pos(sLineBreak,Memo3.Text)-1));
end;

procedure TL2PacketHackMain.Button26Click(Sender: TObject);
begin
  if not Button27.Enabled then begin
    fsScript1.CallFunction('Free',0);
    Button26.Enabled := False;
    ButtonCheckSyntex.Enabled := True;
    Button27.Enabled := True;
    Button18.Enabled := True;
    ButtonRename.Enabled := True;
    ButtonLoadNew.Enabled := True;
    ButtonDelete.Enabled := True;
    Button28.Enabled := True;
    Button9.Enabled := True;
    Button10.Enabled := True;
    ScriptsList.Enabled := True;
    JvHLEditor1.ReadOnly := False;
  end;
end;

procedure TL2PacketHackMain.Button27Click(Sender: TObject);
begin
  if Compile(fsScript1,JvHLEditor1) then begin
    fsScript1.CallFunction('Init',0);
    Button26.Enabled := True;
    ButtonCheckSyntex.Enabled := False;
    Button27.Enabled := False;
    Button18.Enabled := False;
    ButtonRename.Enabled := False;
    ButtonLoadNew.Enabled := False;
    ButtonDelete.Enabled := False;
    Button28.Enabled := False;
    Button9.Enabled := False;
    Button10.Enabled := False;
    ScriptsList.Enabled := False;
    JvHLEditor1.ReadOnly := True;
  end;
end;

procedure TL2PacketHackMain.Button28Click(Sender: TObject);
begin
  RefreshScripts;
end;

procedure RunScript;
begin
  with L2PacketHackMain do try
    fsScript2.Execute;
  finally
    Button3.Enabled:=False;
    Button2.Enabled:=True;
  end;
end;

procedure TL2PacketHackMain.Button2Click(Sender: TObject);
begin
  if Thread[cid].NoUsed then
    sendMSG('Нет соединения!'+sLineBreak+'Возможно вы выбрали пустое соединение.'+
                sLineBreak+'Выберете в списке соединений ваш ник.')
  else begin
    RefreshPrecompile(fsScript2);
    fsScript2.Lines:=JvHLEditor2.Lines;
    if Compile(fsScript2,JvHLEditor2) then begin
      Button2.Enabled:=False;
      Button3.Enabled:=True;
      BeginThread(nil, 0, @RunScript, nil, 0, hid);
    end;
  end;
end;

procedure TL2PacketHackMain.Button3Click(Sender: TObject);
begin
{  Button3.Enabled:=False;
  Button2.Enabled:=True;}
{  if fsScript1.IsRunning then} begin
    fsScript1.Terminate;
    TerminateThread(hid,0);
    Button3.Enabled:=False;
    Button2.Enabled:=True;
  end;
end;

procedure TL2PacketHackMain.Button4Click(Sender: TObject);
var
  temp: string;
  i64: Int64;
begin
  if RadioButton5.Checked then Memo7.Text:=StringToHex(Memo6.Text,' ');
  if RadioButton6.Checked then begin
    SetLength(temp,Length(Memo6.Text)*2);
    Move(StringToWideString(Memo6.Text,1251)[1],temp[1],Length(temp));
    Memo7.Text:=StringToHex(temp,' ');
  end;
  if RadioButton7.Checked then begin
    SetLength(temp,1);
    i64:=StrToInt64Def(Memo6.Text,0);
    Move(i64,temp[1],1);
    Memo7.Text:=StringToHex(temp,' ');
  end;
  if RadioButton8.Checked then begin
    SetLength(temp,2);
    i64:=StrToInt64Def(Memo6.Text,0);
    Move(i64,temp[1],2);
    Memo7.Text:=StringToHex(temp,' ');
  end;
  if RadioButton9.Checked then begin
    SetLength(temp,4);
    i64:=StrToInt64Def(Memo6.Text,0);
    Move(i64,temp[1],4);
    Memo7.Text:=StringToHex(temp,' ');
  end;
end;

procedure TL2PacketHackMain.Button5Click(Sender: TObject);
var
  temp: string;
  i64: Int64;
  wtemp: WideString;
begin
  if RadioButton5.Checked then Memo6.Text:=HexToString(Memo7.Text);
  if RadioButton6.Checked then begin
    temp:=HexToString(Memo7.Text);
    SetLength(wtemp,Length(temp)div 2);
    Move(temp[1],wtemp[1],Length(temp));
    Memo6.Text:=WideStringToString(wtemp,1251);
  end;
  if RadioButton7.Checked then begin
    i64:=0;
    Move((HexToString(Memo7.Text)+#0)[1],i64,1);
    Memo6.Text:=IntToStr(i64);
  end;
  if RadioButton8.Checked then begin
    i64:=0;
    Move((HexToString(Memo7.Text)+#0#0)[1],i64,2);
    Memo6.Text:=IntToStr(i64);
  end;
  if RadioButton9.Checked then begin
    i64:=0;
    Move((HexToString(Memo7.Text)+#0#0#0#0)[1],i64,4);
    Memo6.Text:=IntToStr(i64);
  end;
end;

procedure TL2PacketHackMain.Button6Click(Sender: TObject);
begin
  if OpenDialog2.Execute then JvHLEditor2.Lines.LoadFromFile(OpenDialog2.FileName);
end;

procedure SendPacket(Size: Word; pck: string; tid: Byte; ToServer: Boolean);
var
  Packet: packed record case Integer of
    0: (Size: Word;
        PackType: Byte;
        DataC: array[0..$FFFC] of Char);
    1: (PacketB: array[0..$FFFF] of Byte);
    2: (PacketC: array[0..$FFFF] of Char);
  end;
  TimeStep: TDateTime;
  TimeStepB: array [0..7] of Byte;
begin
  EnterCriticalSection(cs_send);
  if Thread[tid].NoUsed then begin
    L2PacketHackMain.StatusBar1.SimpleText:='Нет соединения!'+sLineBreak+'Возможно вы выбрали пустое соединение.'+
                sLineBreak+'Выберете в списке соединений ваш ник.';
  end else begin
    TimeStep:=Time;
    Move(TimeStep,TimeStepB,8);
    Packet.Size:=Size;
    Size:=Length(pck);
    Move(pck[1],Packet.PackType,Size);
    if ToServer then begin
      if isSaveLog then begin
        Thread[tid].Dump.Add('04'+ByteArrayToHex(TimeStepB,8)+ByteArrayToHex(Packet.PacketB,Packet.Size));
        PostMessage(L2PacketHackMain.Handle,WM_PrnPacket_Log,Integer(tid and $FF)+ $100,Thread[tid].Dump.Count-1);
      end;
      if (not isNoDecryptTraf) and Thread[tid].InitXOR then begin
        if L2PacketHackMain.isGraciaOff.Checked then
          Corrector(Packet.Size,tid,True);
        Thread[tid].xorC.EncryptGP(Packet.PackType,Size);
      end;
      if send(Thread[tid].CSock,Packet,Size+2,0)<0 then DeInitSocket(Thread[tid].CSock);
    end else begin
      if isSaveLog then begin
        Thread[tid].Dump.Add('03'+ByteArrayToHex(TimeStepB,8)+ByteArrayToHex(Packet.PacketB,Packet.Size));
        PostMessage(L2PacketHackMain.Handle,WM_PrnPacket_Log,Integer(tid and $FF),Thread[tid].Dump.Count-1);
      end;
      if (not isNoDecryptTraf) and Thread[tid].InitXOR then Thread[tid].xorS.EncryptGP(Packet.PackType,Size);
      if send(Thread[tid].SSock,Packet,Size+2,0)<0 then DeInitSocket(Thread[tid].SSock);
    end;
  end;
  LeaveCriticalSection(cs_send);
end;

procedure SendPckStr(pck: string; const tid: Byte; const ToServer: Boolean);
begin
  SendPacket(Length(pck)+2,pck,tid,ToServer);
end;

procedure SendPckData(var pck; const tid: Byte; const ToServer: Boolean); stdcall;
var
  tpck: packed record
    size: Word;
    id: Byte;
  end absolute pck;
  spck: string;
begin
  SetLength(spck,tpck.size-2);
  Move(tpck.id,spck[1],Length(spck));
  SendPacket(tpck.size,spck,tid,ToServer);
end;

function TL2PacketHackMain.CallMethod(Instance: TObject; ClassType: TClass; const MethodName: String; var Params: Variant): Variant;
var
  buf,pct,tmp: string;
  temp: WideString;
  d: Integer;
  b: Byte;
  h: Word;
  f: Double;
  LibHandle:Pointer;
  Count:Integer;
  Par:array of Pointer;
  List:variant;
  i:integer;
  Res:Integer;
  //support DLL
  popa:array of PChar;
  count1:pchar;
  TestFunc: function (ar:array of PChar):Pchar;stdcall;
  TestProc: procedure (ar:array of PChar);stdcall;
  tstFunc1: procedure (ar:pchar);
  tstFunc: procedure (ar:integer);
  //support DLL
begin
  // сначала даём возможность плагинам обработать функции
  for i:=0 to High(Plugins) do
   if Plugins[i].Loaded and Assigned(Plugins[i].OnCallMethod) then
    if Plugins[i].OnCallMethod(MethodName,Params,Result) then Exit;

  // если плагины не обработать то обрабатываем сами  
  if MethodName = 'SENDTOCLIENT' then begin
    buf:=TfsScript(Integer(Params[0])).Variables['buf'];
    b:=TfsScript(Integer(Params[0])).Variables['ConnectID'];
    SendPacket(Length(buf)+2,buf,b,False);
  end else
  if MethodName = 'SENDTOSERVER' then begin
    buf:=TfsScript(Integer(Params[0])).Variables['buf'];
    b:=TfsScript(Integer(Params[0])).Variables['ConnectID'];
    SendPacket(Length(buf)+2,buf,b,True);
  end else
  if MethodName = 'SENDTOCLIENTEX' then begin
    buf:=TfsScript(Integer(Params[1])).Variables['buf'];
    for b:=0 to High(Thread) do
      if UpperCase(string(Params[0]))=UpperCase(Thread[b].Name) then Break;
    SendPacket(Length(buf)+2,buf,b,False);
  end else
  if MethodName = 'SENDTOSERVEREX' then begin
    buf:=TfsScript(Integer(Params[1])).Variables['buf'];
    for b:=0 to High(Thread) do
      if UpperCase(string(Params[0]))=UpperCase(Thread[b].Name) then Break;
    SendPacket(Length(buf)+2,buf,b,True);
  end else
  if MethodName = 'READC' then begin
    pct:=TfsScript(Integer(Params[1])).Variables['pck'];
    if Integer(Params[0])<=Length(pct) then b:=Byte(pct[Integer(Params[0])])
    else b:=0;
    Params[0]:=Integer(Params[0])+1;
    Result:=b;
  end else
  if MethodName = 'READD' then begin
    pct:=TfsScript(Integer(Params[1])).Variables['pck'];
    if Integer(Params[0])<Length(pct)-2 then Move(pct[Integer(Params[0])],d,4);
    Params[0]:=Integer(Params[0])+4;
    Result:=d;
  end else
  if MethodName = 'READH' then begin
    pct:=TfsScript(Integer(Params[1])).Variables['pck'];
    if Integer(Params[0])<Length(pct) then Move(pct[Integer(Params[0])],h,2);
    Params[0]:=Integer(Params[0])+2;
    Result:=h;
  end else
  if MethodName = 'READF' then begin
    pct:=TfsScript(Integer(Params[1])).Variables['pck'];
    if Integer(Params[0])<Length(pct)-6 then Move(pct[Integer(Params[0])],f,8);
    Params[0]:=Integer(Params[0])+8;
    Result:=f;
  end else
  if MethodName = 'READS' then begin
    pct:=TfsScript(Integer(Params[1])).Variables['pck'];
    d:=PosEx(#0#0,pct,Integer(Params[0]))-Integer(Params[0]);
    if (d mod 2)=1 then Inc(d);
    SetLength(temp,d div 2);
    if d>=2 then Move(pct[Integer(Params[0])],temp[1],d) else d:=0;
    Params[0]:=Integer(Params[0])+d+2;
    tmp:=temp;
    Result:=tmp;//WideStringToString(temp,1251);
  end else
  if MethodName = 'WRITEC' then begin
    buf:=TfsScript(Integer(Params[2])).Variables['buf'];
    b:=Params[0];
    if Integer(Params[1])=0 then buf:=buf+Char(b)
      else buf[Integer(Params[1])]:=Char(b);
    TfsScript(Integer(Params[2])).Variables['buf']:=buf;
  end else
  if MethodName = 'WRITED' then begin
    buf:=TfsScript(Integer(Params[2])).Variables['buf'];
    SetLength(tmp,4);
    d:=Params[0];
    if Integer(Params[1])=0 then begin
      Move(d,tmp[1],4);
      buf:=buf+tmp;
    end else begin
      Move(d,buf[Integer(Params[1])],4);
    end;
    TfsScript(Integer(Params[2])).Variables['buf']:=buf;
  end else
  if MethodName = 'WRITEH' then begin
    buf:=TfsScript(Integer(Params[2])).Variables['buf'];
    SetLength(tmp,2);
    h:=Params[0];
    if Integer(Params[1])=0 then begin
      Move(h,tmp[1],2);
      buf:=buf+tmp;
    end else begin
      Move(h,buf[Integer(Params[1])],2);
    end;
    TfsScript(Integer(Params[2])).Variables['buf']:=buf;
  end else
  if MethodName = 'WRITEF' then begin
    buf:=TfsScript(Integer(Params[2])).Variables['buf'];
    SetLength(tmp,8);
    f:=Params[0];
    if Integer(Params[1])=0 then begin
      Move(f,tmp[1],8);
      buf:=buf+tmp;
    end else begin
      Move(f,buf[Integer(Params[1])],8);
    end;
    TfsScript(Integer(Params[2])).Variables['buf']:=buf;
  end else
  if MethodName = 'WRITES' then begin
    buf:=TfsScript(Integer(Params[1])).Variables['buf'];
    tmp:=Params[0];
    temp:=tmp;//StringToWideString(tmp,1251);
    tmp:=tmp+tmp;
    Move(temp[1],tmp[1],Length(tmp));
    {if Integer(Params[1])=0 then }
    buf:=buf+tmp+#0#0;
    { else begin
//      buf[Integer(Params[1])]:=Char(5);
    end;}
    TfsScript(Integer(Params[1])).Variables['buf']:=buf;
  end else
  if MethodName = 'LOADLIBRARY' then begin
    Result := LoadLibrary(PAnsiChar(VarToStr(Params[0])));
  end else
  if MethodName = 'HSTR' then Result:=HexToString(Params[0]) else
  //for support DLL
  if MethodName = 'STRTOHEX' then Result:=StringToHex(Params[0],'') else
  if MethodName = 'CALLPR' then begin
    @TestProc := nil;
    @TestProc := GetProcAddress(Cardinal(Params[0]),PAnsiChar(VarToStr(Params[1])));
    if @TestProc <> nil then begin
      Count := Params[2];
      setLength(popa,count);
      for i:=0 to Count-1 do
      popa[i]:=PChar(VarToStr(Params[3][i]));
      TestProc(popa);
    end;
    @TestProc:=nil;
  end else
  if MethodName = 'CALLFNC' then begin
    @TestFunc := nil;
    @TestFunc := GetProcAddress(Cardinal(Params[0]),PAnsiChar(VarToStr(Params[1])));
    if @TestFunc <> nil then begin
      Count := Params[2];
      setLength(popa,count);
      for i:=0 to Count-1 do
      popa[i]:=PChar(VarToStr(Params[3][i]));
      Result:=StrPas(TestFunc(popa));
    end;
    @TestFunc:=nil;
  end else
  if MethodName = 'TESTFUNC' then begin
    @tstFunc:= nil;
    @tstFunc := GetProcAddress(Cardinal(Params[0]),PAnsiChar(VarToStr(Params[1])));
    if @tstFunc <> nil then begin
      Count := Params[2];
      tstFunc(Count);
    end;
  end else
  if MethodName = 'TESTFUNC1' then begin
    @tstFunc1:= nil;
    @tstFunc1 := GetProcAddress(Cardinal(Params[0]),PAnsiChar(VarToStr(Params[1])));
    if @tstFunc1 <> nil then begin
      Count1 := PAnsiChar(VarToStr(Params[2]));
      tstFunc1(Count1);
    end;
  end else
{/*by wanick*/}
  if MethodName = 'CALLSF' then begin
    Res:= -1;
    i:=-1;
    while ((i <= ScriptsList.Count-1) AND (Res < 0)) do
    begin
      i := i + 1;
      if Scripts[i].Name = Params[0] then Res := i;
    end;
    if not ScriptsList.Checked[Res] OR not Scripts[Res].Compilled then
    begin
      sendMSG ('Скрипт к которому вы обращаетесь не включен!');
      Result := '-1';
      exit;
    end;
    try
      Result := Scripts[Res].fsScript.CallFunction(Params[1], Params[2]);
    except
      sendMSG ('Произошла неизвестная ошибка в вызываемом методе!');
      Result := '-1';
      exit;
    end;
  end else
  if MethodName = 'SENDMSG'  then begin
    sendMSG(Params[0]);
  end else
{/*by wanick*/}
  //for support DLL
  if MethodName = 'CALLFUNCTION' then begin
    LibHAndle := nil;
    LibHandle := GetProcAddress(Cardinal(Params[0]),PAnsiChar(VarToStr(Params[1])));
    if LibHandle <> nil then begin
      Count := Params[2];
      SetLength(Par,Count);
      List := VarArrayRef(Params[3]);
      for i:= 0 to count -1 do
        Par[i]  := FindVarData(VarArrayRef(List)[i])^.VPointer;
      asm
        pusha;
        mov edx,[par]
        mov ecx, Count;
        cmp ecx,0
        jz @@m1;
        @@loop:
        dec ecx;
        mov eax,[edx + ecx*4];
        push eax;
        jnz @@loop;
        @@m1:
        call LibHandle;
        mov Res,eax;
        popa;
      end;
      List := 0;
      Result := Res;
    end;
  end else
  if MethodName = 'FREELIBRARY' then Result := FreeLibrary(Params[0]) else
  if MethodName = 'CONNECTNAMEBYID' then begin
    Result:=Thread[Integer(Params[0])].Name;
  end else
  if MethodName = 'CONNECTIDBYNAME' then begin
    for b:=0 to High(Thread) do
      if UpperCase(string(Params[0]))=UpperCase(Thread[b].Name) then begin
        Result:=Integer(b);
        Break;
      end;
  end else
  if MethodName = 'SETNAME' then begin
    buf:=TfsScript(Integer(Params[1])).Variables['buf'];
    b:=TfsScript(Integer(Params[1])).Variables['ConnectID'];
    Thread[b].Name:=String(Params[0]);
  end else
  if MethodName = 'NOFREEONCLIENTDISCONNECT' then begin
    buf:=TfsScript(Integer(Params[0])).Variables['buf'];
    b:=TfsScript(Integer(Params[0])).Variables['ConnectID'];
    Thread[b].noFreeOnClientDisconnect:=True;
  end else
  if MethodName = 'YESFREEONCLIENTDISCONNECT' then begin
    buf:=TfsScript(Integer(Params[0])).Variables['buf'];
    b:=TfsScript(Integer(Params[0])).Variables['ConnectID'];
    Thread[b].noFreeOnClientDisconnect:=False;
  end else
  if MethodName = 'NOFREEONSERVERDISCONNECT' then begin
    buf:=TfsScript(Integer(Params[0])).Variables['buf'];
    b:=TfsScript(Integer(Params[0])).Variables['ConnectID'];
    Thread[b].noFreeOnServerDisconnect:=True;
  end else
  if MethodName = 'YESFREEONCLIENTDISCONNECT' then begin
    buf:=TfsScript(Integer(Params[0])).Variables['buf'];
    b:=TfsScript(Integer(Params[0])).Variables['ConnectID'];
    Thread[b].noFreeOnServerDisconnect:=False;
  end else
  if MethodName = 'DISCONNECTCLIENT' then begin
    buf:=TfsScript(Integer(Params[0])).Variables['buf'];
    b:=TfsScript(Integer(Params[0])).Variables['ConnectID'];
    DeInitSocket(Thread[b].CSock);
  end else
  if MethodName = 'DISCONNECTSERVER' then begin
    buf:=TfsScript(Integer(Params[0])).Variables['buf'];
    b:=TfsScript(Integer(Params[0])).Variables['ConnectID'];
    DeInitSocket(Thread[b].SSock);
  end else
  if MethodName = 'DELAY' then Sleep(Params[0]) else
  if MethodName = 'SHOWTAB' then TabSheet10.TabVisible:=True else
  if MethodName = 'HIDETAB' then TabSheet10.TabVisible:=False;
end;

procedure TL2PacketHackMain.CheckBox10Click(Sender: TObject);
begin
  Panel15.Visible:=ToolButton6.Down;
end;

procedure TL2PacketHackMain.CheckBox12Click(Sender: TObject);
begin
  Memo4.ReadOnly:=CheckBox12.Checked;
  RadioButton1.Enabled:=not CheckBox12.Checked;
  RadioButton2.Enabled:=not CheckBox12.Checked;
  Button21.Enabled:=not CheckBox12.Checked;
  if CheckBox12.Checked then Timer2.Interval:=StrToInt(Edit1.Text)
    else Timer2.Interval:=0;
end;

procedure TL2PacketHackMain.CheckBox2Click(Sender: TObject);
begin
  Options.WriteBool('General','NoLogin',CheckBox2.Checked);
  Options.UpdateFile;
  isPassLogin:=CheckBox2.Checked;
end;

procedure TL2PacketHackMain.CheckBox3Click(Sender: TObject);
begin
  Options.WriteBool('General','Enable',CheckBox3.Checked);
  Options.UpdateFile;
  ListBox1.Items.Add('');
  Timer1Timer(Sender);
  isIntercept:=CheckBox3.Checked;
end;

procedure TL2PacketHackMain.CheckBox4Click(Sender: TObject);
begin
  Options.WriteBool('General','Programs',CheckBox4.Checked);
  Options.UpdateFile;
  Panel2.Visible:=CheckBox4.Checked;
end;

{
 Вызывается при выборе скрипта в списке
}
procedure TL2PacketHackMain.ScriptsListClick(Sender: TObject);
begin
  if ScriptsList.ItemIndex >= 0 then begin
    JvHLEditor1.Lines := Scripts[ScriptsList.ItemIndex].fsScript.Lines;
    ButtonSave.Enabled := not ButtonSave.Enabled AND not ScriptsList.ItemEnabled[ScriptsList.ItemIndex];
    ButtonDelete.Enabled := not ScriptsList.Checked[ScriptsList.ItemIndex] AND ScriptsList.ItemEnabled[ScriptsList.ItemIndex];
    ButtonRename.Enabled := not ScriptsList.Checked[ScriptsList.ItemIndex];
    Button9.Enabled := ScriptsList.ItemIndex > 0;
    Button10.Enabled := ScriptsList.ItemIndex<ScriptsList.Items.Count-1;
    if not ScriptsList.ItemEnabled[ScriptsList.ItemIndex] then
      JvHLEditor1.ReadOnly := true
    else JvHLEditor1.ReadOnly:=ScriptsList.Checked[ScriptsList.ItemIndex];
  end;
end;

{
  Вызывается при включении скрипта
}
procedure TL2PacketHackMain.ScriptsListClickCheck(Sender: TObject);
var
  i: integer;
begin
  // если не включен и менялся спрашиваем сохранят или нет если не сохранять перезугружаем старую версию
  if ScriptsList.Checked[ScriptsList.ItemIndex] AND ButtonSave.Enabled then
    if MessageDlg('Сохранить изменения перед запуском?',mtConfirmation,[mbYes, mbNo],0) = mrYes then
      ButtonSaveClick(Sender) else JvHLEditor1.Lines:=Scripts[ScriptsList.ItemIndex].fsScript.Lines;
  // далее выполняем скрипт
  if (ScriptsList.ItemIndex>=0)and(not ScriptsList.Checked[ScriptsList.ItemIndex]) then
    Scripts[ScriptsList.ItemIndex].fsScript.CallFunction('Free',0);
  if (ScriptsList.ItemIndex>=0)and(ScriptsList.Checked[ScriptsList.ItemIndex]) then
    if not Scripts[ScriptsList.ItemIndex].Compilled then begin
      RefreshPrecompile(Scripts[ScriptsList.ItemIndex].fsScript);
      if not Scripts[ScriptsList.ItemIndex].fsScript.Compile then begin
        ScriptsList.Checked[ScriptsList.ItemIndex]:=False;
        ButtonCheckSyntexClick(Sender);
      end else begin
        Scripts[ScriptsList.ItemIndex].Compilled:=True;
        Scripts[ScriptsList.ItemIndex].fsScript.CallFunction('Init',0);
      end;
    end else Scripts[ScriptsList.ItemIndex].fsScript.CallFunction('Init',0);

    nScripts.Items[ScriptsList.ItemIndex].Checked:=ScriptsList.Checked[ScriptsList.ItemIndex];
{/*by wanick*/}
{
 может просто сделать чтобы была глабальная переменная
 есть включеный скрипт или нет
 тогда можно будет пробегатся по скриптам только в этом методе
 вроде еще где-то перебирается 
}
    i:=0;
    Button28.Enabled := true;
    while (i <= ScriptsList.Count-1) AND Button28.Enabled do
    begin
      if ScriptsList.Checked[i] then Button28.Enabled:=false;
      i:= i + 1;
    end;
{/*by wanick*/}
end;

procedure TL2PacketHackMain.ChkNoDecryptClick(Sender: TObject);
begin
  Options.WriteBool('General','NoDecrypt',ChkNoDecrypt.Checked);
  Options.UpdateFile;
  isNoDecryptTraf:=ChkNoDecrypt.Checked;
end;

procedure TL2PacketHackMain.ChkXORfixClick(Sender: TObject);
begin
  Options.WriteBool('General','AntiXORkey',ChkXORfix.Checked);
  Options.UpdateFile;
  isChangeXor:=ChkXORfix.Checked;
end;

procedure TL2PacketHackMain.clbPluginsListClick(Sender: TObject);
var
  i: Integer;
begin
  mPluginInfo.Clear;
  for i:=0 to 6 do clbPluginFuncs.Checked[i]:=False;

  if clbPluginsList.ItemIndex=-1 then Exit;

  with Plugins[clbPluginsList.ItemIndex] do if Loaded then begin
    mPluginInfo.Lines.Add(Info);
    for i:=0 to 6 do if TEnableFunc(i) in EnableFuncs then
      clbPluginFuncs.Checked[i]:=True;
  end else if LoadInfo then begin
    mPluginInfo.Lines.Add(Info);
    for i:=0 to 6 do if TEnableFunc(i) in EnableFuncs then
      clbPluginFuncs.Checked[i]:=True;
  end;
end;

procedure TL2PacketHackMain.clbPluginsListClickCheck(Sender: TObject);
var
  i: Integer;
begin
  i:=clbPluginsList.ItemIndex;
  if i=-1 then Exit;

  if clbPluginsList.Checked[i] then
    clbPluginsList.Checked[i]:=Plugins[i].LoadPlugin
  else
    Plugins[i].FreePlugin;

  nPlugins.Items[i].Checked:=clbPluginsList.Checked[i];
end;

procedure TL2PacketHackMain.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.ItemIndex>-1 then begin
    CID:=ComboBox1.ItemIndex;
    ListView1Click(Sender);
  end;
end;

procedure TL2PacketHackMain.CreateParams(var Params: TCreateParams);
begin
  Inherited CreateParams(Params);
end;

procedure TL2PacketHackMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=False;
  SpeedButton1Click(Sender);
end;

procedure TL2PacketHackMain.TrayIcon1Click(Sender: TObject);
begin
  L2PacketHackMain.Visible:=not L2PacketHackMain.Visible;
  if L2PacketHackMain.Visible then SetForegroundWindow(L2PacketHackMain.Handle);
end;

procedure TL2PacketHackMain.RadioGroup1Click(Sender: TObject);
begin
  isHookMethod:=RadioGroup1.ItemIndex;
end;

procedure TL2PacketHackMain.ReadMsg(var msg: TMessage);
var
  IPb:array[0..3]of Byte absolute CurentIP;
begin
  msg.ResultHi:=LPortConst;
  CurentIP:=msg.WParam;
  CurentPort:=msg.LParamLo;
  if Pos(';'+IntToStr(ntohs(msg.LParamLo))+';',';'+LabeledEdit2.Text+';')=0 then begin
    if CheckBox3.Checked then begin
      msg.ResultLo:=1;
      sendMsg ('Перехвачен коннект на '+IntToStr(IPb[0])+'.'+IntToStr(IPb[1])+'.'+IntToStr(IPb[2])+'.'+IntToStr(IPb[3])+':'+IntToStr(ntohs(CurentPort)));
    end else begin
      msg.ResultLo:=0;
      sendMsg ('Коннект на '+IntToStr(IPb[0])+'.'+IntToStr(IPb[1])+'.'+IntToStr(IPb[2])+'.'+IntToStr(IPb[3])+' пропущен (перехват выключен)');
    end;
  end else begin
    msg.ResultLo:=0;
    sendMsg ('Коннект на '+IntToStr(IPb[0])+'.'+IntToStr(IPb[1])+'.'+IntToStr(IPb[2])+'.'+IntToStr(IPb[3])+':'+IntToStr(ntohs(CurentPort))+' проигнорирован');
  end;
end;

procedure TL2PacketHackMain.RefreshPrecompile(var fsScript: TfsScript);
var
  fss: string;
  i,k: Integer;
  funcs: TStringArray;
begin
  fss:='fss:integer='+IntToStr(Integer(fsScript));
  fsScript.Clear;
  fsScript.AddRTTI;

  // позволяем плагинам добавить свои функции в скрипты
  for i:=0 to High(Plugins) do
  if Plugins[i].Loaded and Assigned(Plugins[i].OnRefreshPrecompile) then begin
    SetLength(funcs,0);
    k:=Plugins[i].OnRefreshPrecompile(funcs);
    if k>0 then for k:=0 to High(funcs) do
      fsScript.AddMethod(funcs[k],CallMethod);
  end;

  fsScript.AddMethod('function HStr(Hex:String):String',CallMethod);
  fsScript.AddMethod('procedure SendToClient('+fss+')',CallMethod);
  fsScript.AddMethod('procedure SendToServer('+fss+')',CallMethod);
  fsScript.AddMethod('procedure SendToClientEx(CharName:string;'+fss+')',CallMethod);
  fsScript.AddMethod('procedure SendToServerEx(CharName:string;'+fss+')',CallMethod);
  fsScript.AddMethod('procedure NoFreeOnClientDisconnect('+fss+')',CallMethod);
  fsScript.AddMethod('procedure YesFreeOnClientDisconnect('+fss+')',CallMethod);
  fsScript.AddMethod('procedure NoFreeOnServerDisconnect('+fss+')',CallMethod);
  fsScript.AddMethod('procedure YesFreeOnServerDisconnect('+fss+')',CallMethod);
  fsScript.AddMethod('procedure DisconnectServer('+fss+')',CallMethod);
  fsScript.AddMethod('procedure DisconnectClient('+fss+')',CallMethod);
  fsScript.AddMethod('function ConnectNameByID(id:integer;'+fss+'):string',CallMethod);
  fsScript.AddMethod('function ConnectIDByName(name:string;'+fss+'):integer',CallMethod);
  fsScript.AddMethod('procedure SetName(Name:string;'+fss+')',CallMethod);
  fsScript.AddMethod('procedure Delay(msec: Cardinal)',CallMethod);
  fsScript.AddMethod('procedure ShowTab',CallMethod);
  fsScript.AddMethod('procedure HideTab',CallMethod);
  fsScript.AddMethod('procedure WriteS(v:string;'+fss+')',CallMethod);
  fsScript.AddMethod('procedure WriteC(v:byte; ind:integer=0;'+fss+')',CallMethod);
  fsScript.AddMethod('procedure WriteD(v:integer; ind:integer=0;'+fss+')',CallMethod);
  fsScript.AddMethod('procedure WriteH(v:word; ind:integer=0;'+fss+')',CallMethod);
  fsScript.AddMethod('procedure WriteF(v:double; ind:integer=0;'+fss+')',CallMethod);
  fsScript.AddMethod('function ReadS(var index:integer;'+fss+'):string',CallMethod);
  fsScript.AddMethod('function ReadC(var index:integer;'+fss+'):byte',CallMethod);
  fsScript.AddMethod('function ReadD(var index:integer;'+fss+'):integer',CallMethod);
  fsScript.AddMethod('function ReadH(var index:integer;'+fss+'):word',CallMethod);
  fsScript.AddMethod('function ReadF(var index:integer;'+fss+'):double',CallMethod);
  fsScript.AddMethod('function LoadLibrary(LibName:String):Integer',CallMethod);
  fsScript.AddMethod('function FreeLibrary(LibHandle:Integer):Boolean',CallMethod);
  //for support DLL
  fsScript.AddMethod('function StrToHex(str1:String):String;',CallMethod);
  fsScript.AddMethod('procedure CallPr(LibHandle:integer;FunctionName:String;Count:Integer;Params:array of variant)',CallMethod);
  fsScript.AddMethod('function CallFnc(LibHandle:integer;FunctionName:String;Count:Integer;Params:array of variant):string',CallMethod);
  fsScript.AddMethod('procedure TestFunc(LibHandle:integer;FunctionName:String;Count:Integer)',CallMethod);
  fsScript.AddMethod('procedure TestFunc1(LibHandle:integer;FunctionName:String;Count1:variant)',CallMethod);
  //for support DLL
  fsScript.AddMethod('function CallFunction(LibHandle:integer;FunctionName:String;Count:Integer;Params:array of variant):variant',CallMethod);
  // взаимодействие между скриптами
  fsScript.AddMethod('function CallSF(ScriptName:String;FunctionName:String;Params:array of variant):variant',CallMethod);
  fsScript.AddMethod('procedure sendMSG(msg:String;)',CallMethod);

  fsScript.AddObject('UserTab',TabSheet10);
  fsScript.AddVariable('buf','String','');
  fsScript.AddVariable('pck','String','');
  fsScript.AddVariable('FromServer','Boolean',True);
  fsScript.AddVariable('FromClient','Boolean',False);
  fsScript.AddVariable('ConnectID','Integer',0);
  fsScript.AddVariable('ConnectName','String','');
end;

procedure TL2PacketHackMain.RefreshScripts;
var
  SearchRec: TSearchRec;
  Mask: string;
  i: Byte;
  mi: TMenuItem;
begin
  ButtonRename.Enabled:=False;
  ButtonDelete.Enabled:=False;
  ButtonSave.Enabled:=False;
  Button10.Enabled:=False;
  Button9.Enabled:=False;
  Mask := ExtractFilePath(ParamStr(0))+'Scripts\*.txt';
  i:=0;
  ScriptsList.Clear;
  nScripts.Clear;
  if FindFirst(Mask, faAnyFile, SearchRec) = 0 then
  begin
    repeat
      Application.ProcessMessages;
      if (SearchRec.Attr and faDirectory) <> faDirectory then begin
        if i<65 then begin
          Scripts[i].fsScript.Lines.LoadFromFile(ExtractFilePath(ParamStr(0))+'Scripts\'+SearchRec.Name);
          Scripts[i].fsScript.Clear;
          Scripts[i].Name:=Copy(SearchRec.Name,1,Length(SearchRec.Name)-4);
          Scripts[i].Compilled:=False;
          ScriptsList.Items.Add(Scripts[i].Name);
          mi:=TMenuItem.Create(nScripts);
          nScripts.Add(mi);
          mi.AutoCheck:=True;
          mi.Checked:=False;
          mi.Caption:=Scripts[i].Name;
          mi.OnClick:=N7Click;
          Inc(i);
        end;
      end;
    until FindNext(SearchRec)<>0;
    FindClose(SearchRec);
  end;
  if i=65 then if MessageDlg('Ограничение на количество используемых скриптов!'+sLineBreak+'Будут задействованы только 64 скрипта.'+sLineBreak+'Переместите лишние в другое место.',mtInformation ,[mbOk],0)=mrOk then
end;

procedure TL2PacketHackMain.SpeedButton1Click(Sender: TObject);
begin
  if MessageDlg('Вы уверены что хотите выйти из программы?',mtConfirmation,[mbYes, mbNo],0)=mrYes then begin
    Application.Terminate;
  end;
end;

procedure TL2PacketHackMain.tbtnDeleteClick(Sender: TObject);
var
  i,k:Integer;
  tmpItm: TListItem;
begin
  tmpItm:=ListView5.Selected;
  for i:=1 to ListView5.SelCount do begin
    k:=StrToInt(tmpItm.SubItems.Strings[0])-i+1;
    EnterCriticalSection(_cs);
    Thread[cid].Dump.Delete(k);
    LeaveCriticalSection(_cs);
    tmpItm:=ListView5.GetNextItem(tmpItm,sdAll,[isSelected]);
  end;
  ListView1Click(Sender);
  //удалили значит выключаем кнопку
  tbtnFilterDel.Enabled:=false;
  tbtnDelete.Enabled:=false;
end;

///////////////////////////////////////////////////////////////////////////////
//                        вызываются из всех потоков
///////////////////////////////////////////////////////////////////////////////
//....................
//вызывать через сообщения
procedure TL2PacketHackMain.Log(var msg: TMessage);
begin
  //выводим в мемо
  ListBox3.Lines.Add(pstr(msg.LParam)^);
  //сохраняем мемо в файл
  ListBox3.Lines.SaveToFile(PChar(ExtractFilePath(Application.ExeName))+'\logs\l2phx.log');
end;
//....................
procedure sendMSG (msg: string);
begin
  SendMessage(L2PacketHackMain.Handle, WM_ListBox3_Log, 0, integer(@Msg));
end;
//....................
//вызывать через сообщения
procedure TL2PacketHackMain.ThreadFinished(var msg: TMessage);
var
  h1:integer;
begin
  h1:=msg.LParam; // хендл отработаного потока
  CloseHandle(h1);
end;
///////////////////////////////////////////////////////////////////////////////
//                      главный VCL поток
///////////////////////////////////////////////////////////////////////////////
//главный поток ожидания подключений
procedure ServerListen(PSock: Pointer);
var
  NewSocket: TSocket;
  id: Byte;
begin
{
Q :На 56574 зарегистрирован локальный сервер? Что это за порт? Какое его назначение?
A: На этом порту пакетхак принимает соединения от клиента, чтобы перенаправить их на сервер.
}
  try
    SLThreadStarted:=true;
    //локальный сервер создан? TRUE при запуске программы
    while NoServer do Sleep(1);  //пока true ждем
    if not InitSocket(SLSock,ntohs(LPortConst),'0.0.0.0') then begin
      sendMSG(format(FailedLocalServer,[ntohs(LPortConst)]));
      exit;
    end;
    //создаем локальный сервер
    sendMSG(format(StartLocalServer,[ntohs(LPortConst)]));
    //ждём соединения с клиентом
    while WaitClient(SLSock, NewSocket) do begin
      //ищем свободный поток
      for id:=0 to MaxThr-1 do begin
        if Thread[id].NoUsed then begin
          EnterCriticalSection(_cs);
          if Assigned(CreateXorIn)
            then CreateXorIn(@Thread[id].xorS)
            else Thread[id].xorS:=L2Xor.Create;
          if Assigned(CreateXorOut)
            then CreateXorOut(@Thread[id].xorC)
            else Thread[id].xorC:=L2Xor.Create;
          //инициализируем поток
          Thread[id].Connect:=False;
          Thread[id].IP:=CurentIP;
          Thread[id].Port:=CurentPort;
          Thread[id].InitXOR:=False;
          Thread[id].SSock:=NewSocket;
          Thread[id].Dump.Clear;
          LeaveCriticalSection(_cs);
          Thread[id].SH:=BeginThread(nil, 0, @Server, Pointer(id), 0, Thread[id].STH);
          //sendMSG(format(CreateNewConnect,[id]));
          sendMSG('Thread Start: поток сервера Thread[id].SH '+inttostr(Thread[id].SH)+'/'+inttostr(Thread[id].STH)+' id:'+inttostr(id));
          break; //прерываем цикл, как только находим свободный поток
        end;
      end;
    end;
  finally
    SLThreadStarted:=false;
    sendMSG('Thread Exit: основной поток ServerListen '+inttostr(SLH)+'/'+inttostr(SLTH));
  end;
end;
//конец - главный VCL поток
///////////////////////////////////////////////////////////////////////////////
//                 запускается из 1-го и 2-го потока
///////////////////////////////////////////////////////////////////////////////
//....................
//вызывать через сообщения
procedure TL2PacketHackMain.UpdateComboBox1(var msg: TMessage);
var
  i, id: integer;
begin
  //обновляем Список соединений
  //сохраним текущее соединение в комбобоксе
  i:=ComboBox1.ItemIndex;
  ComboBox1.Items.BeginUpdate;
  ComboBox1.Items.Clear;
  for id:=0 to MaxThr-1 do
    if not Thread[id].NoUsed
       then ComboBox1.Items.Add(IntToStr(id)+' - '+Thread[id].Name)
       else ComboBox1.Items.Add(IntToStr(id)+' - пусто');
  //восстановим текущее соединение в комбобоксе
  ComboBox1.ItemIndex:=i;
  ComboBox1.Items.EndUpdate;
end;
//....................
//вызывать через сообщения
procedure TL2PacketHackMain.SetDisconnect(var msg: TMessage);
var
  i, id : integer;
begin
  id:=msg.LParam;

  for i:=0 to High(Plugins) do with Plugins[i] do
    if Loaded and Assigned(OnDisconnect) then OnDisconnect(id,Boolean(msg.WParam));

  for i:=0 to ScriptsList.Count-1 do
    if(ScriptsList.Checked[i])then
      if not Scripts[i].Compilled then begin
        RefreshPrecompile(Scripts[i].fsScript);
        if not Scripts[i].fsScript.Compile then begin
          ScriptsList.Checked[i]:=False;
        end else begin
          Scripts[i].Compilled:=True;
          Scripts[i].fsScript.Variables['ConnectID']:=id;
          Scripts[i].fsScript.CallFunction('OnDisconnect',True);
        end;
      end else begin
        Scripts[i].fsScript.Variables['ConnectID']:=id;
        Scripts[i].fsScript.CallFunction('OnDisconnect',True);
      end;
end;
//....................
//вызывать через сообщения
procedure TL2PacketHackMain.SetConnect(var msg: TMessage);
var
  i, id : integer;
begin
  id:=msg.LParam;

  for i:=0 to High(Plugins) do with Plugins[i] do
    if Loaded and Assigned(OnConnect) then OnConnect(id,Boolean(msg.WParam));

  //инициируем переменные ConnectID и OnConnect в скрипте
  for i:=0 to ScriptsList.Count-1 do
    if(ScriptsList.Checked[i])then
      if not Scripts[i].Compilled then begin
        RefreshPrecompile(Scripts[i].fsScript);
        if not Scripts[i].fsScript.Compile then begin
          ScriptsList.Checked[i]:=False;
        end else begin
          Scripts[i].Compilled:=True;
          Scripts[i].fsScript.Variables['ConnectID']:=id;
          Scripts[i].fsScript.CallFunction('OnConnect',True);
        end;
      end else begin
        Scripts[i].fsScript.Variables['ConnectID']:=id;
        Scripts[i].fsScript.CallFunction('OnConnect',True);
      end;
end;
//....................
//вызывать через сообщения
procedure TL2PacketHackMain.ClearPacketsLog(var msg: TMessage);
begin
  //чистим лог пакетов
  ListView5.Items.Clear;
  Memo3.Clear;
  Memo2.Clear;
end;
//....................
///////////////////////////////////////////////////////////////////////////////
//                          1-й рабочий поток
///////////////////////////////////////////////////////////////////////////////
//подключение к гейм-серверу
procedure Server(Param: Pointer);
var
//  i: Integer;
  id:Byte;
  Packet: record
    Size: Word;
    DataB: array[0..$FFFD] of Byte;
  end;
  PacketC: record
    Size: Word;
    DataC: array[0..$FFFD] of Char;
  end absolute Packet;
  PacketB: array[0..$FFFF] of Byte absolute Packet;
  SSockl,CSockl: TSocket;
  IsGamel: Boolean;
//  LogMsg: PChar;
  msg: string;
  x: integer;
begin
    id:=Byte(Param);
    EnterCriticalSection(_cs);
    SSockl:=Thread[id].SSock;
    Thread[id].noFreeOnServerDisconnect:=False;
    Thread[id].noFreeOnClientDisconnect:=False;
    Thread[id].IsGame:=True;
    Thread[id].pckCount:=0;
    Thread[id].AutoPing:=False;
    Thread[id].NoUsed:=False;
    Thread[id].cd._id_mix:=False;
    LeaveCriticalSection(_cs);
    Thread[id].ConnectEvent:=CreateEvent(nil, true,false,PChar('phx_srv_'+
                                                      IntToStr(Thread[id].SH)));
    //запускаем поток к клиенту
    Thread[id].CH:=BeginThread(nil, 0, @Client, Param, 0, Thread[id].CTH);
    sendMSG('Thread Start: поток клиента Thread[id].CH '+inttostr(Thread[id].CH)+'/'+inttostr(Thread[id].CTH)+' id:'+inttostr(id));
    //инициируем переменные ConnectID и OnConnect в скрипте
    PostMessage(L2PacketHackMain.Handle, WM_SetConnect, 1, id);

    //ждем подключения 30 секунд, если оно не произошло завершаемся
    if WaitForSingleObject(Thread[id].ConnectEvent, 30000)<>0 then begin
      CloseHandle(Thread[id].ConnectEvent);
      TerminateThread(Thread[id].CH,0);
      ExitThread(0);
    end;
    CloseHandle(Thread[id].ConnectEvent);
    //while not Thread[id].Connect do Sleep(1);
    //подключились
  //  EnterCriticalSection(_cs);
    CSockl:=Thread[id].CSock;
    GetSocketData(SSockl,Packet,2);
    if Thread[id].IsGame then Thread[id].AutoPing:=True;
    IsGamel:=Thread[id].IsGame;
  //  LeaveCriticalSection(_cs);

    //пропускать логин?
    //если (пропускать логин и мы не в игре)
    if isPassLogin and (not IsGamel) then begin
      //отсылаем данные, сначала длину, а потом сам пакет
      send(CSockl,PacketB,2,0);
      repeat until send(CSockl,PacketB,recv(SSockl,PacketB,$FFFF,0),0)<=0;
    end else begin
      //иначе (пропускать логин и мы в игре)
      //прием пакетов
      repeat
        if not GetSocketData(SSockl,Packet.DataB,Packet.Size-2) then break;
        if IsGamel
           then PacketProcesor(PacketB,CSockl,id,4)
           else PacketProcesor(PacketB,CSockl,id,2);
        if not GetSocketData(SSockl,Packet,2) then break;
      until False;
    end;
    //сюда попадаем когда отвалился сервер
    //инициируем переменные ConnectID и OnDisconnect в скрипте
    SendMessage(L2PacketHackMain.Handle, WM_SetDisconnect, 1, id);
    sendMSG('Disconnect: отвалился сервер Thread[id].SH '+inttostr(Thread[id].SH)+'/'+inttostr(Thread[id].STH)+' id:'+inttostr(id));

    //не разрываем связь если отключен сервер и noFreeOnServerDisconnect
    while Thread[id].noFreeOnServerDisconnect do Sleep(1);
    EnterCriticalSection(_cs);
    //сохраняем лог пакетов в файл
    try
      if isSaveLog and (Thread[ID].Name<>'') then begin
        msg:='logs\'+Thread[ID].Name+'_'+datetostr(now)+'_'+timetostr(time)+'.txt';
        x:=pos(':', msg); // ищем подстроку
        if x>0 then begin
          Delete(msg, x, length(':')); // удаляем её
          Insert('.', msg, x); // вставляем новую
        end;
        x:=pos(':', msg); // ищем подстроку
        if x>0 then begin
          Delete(msg, x, length(':')); // удаляем её
          Insert('.', msg, x); // вставляем новую
        end;
        Thread[ID].Dump.SaveToFile(PChar(ExtractFilePath(Application.ExeName))+msg);
      end;
    except
      //пропускаем ошибки при записи
    end;
    //закрываем сокеты
    DeinitSocket(SSockl);
    DeinitSocket(CSockl);
    //чистим лог пакетов
    Thread[ID].Dump.Clear;
    Thread[id].NoUsed:=True;
//    PostMessage(L2PacketHackMain.Handle, WM_Finished, 0, Thread[id].SH);
    PostMessage(L2PacketHackMain.Handle, WM_ClearPacketsLog, 0, 0);
    //sendMSG(format(ConnectBreak,[id]));
    //обновляем Список соединений
    SendMessage(L2PacketHackMain.Handle, WM_UpdateComboBox1, 0, 0);
    sendMSG('Thread Exit: поток сервера Thread[id].SH '+inttostr(Thread[id].SH)+'/'+inttostr(Thread[id].STH)+' id:'+inttostr(id));
    CloseHandle(Thread[id].SH);
    LeaveCriticalSection(_cs);
end;
//....................
//конец - 1-й рабочий поток
///////////////////////////////////////////////////////////////////////////////
//                        2-й рабочий поток
///////////////////////////////////////////////////////////////////////////////
procedure Client(Param: Pointer);
var
  id:Byte;
  Packet: record
    Size: Word;
    DataB: array[0..$FFFD] of Byte;
  end;
  PacketC: record
    Size: Word;
    DataC: array[0..$FFFD] of Char;
  end absolute Packet;
  PacketB: array[0..$FFFF] of Byte absolute Packet;
  SSockl,CSockl: TSocket;
  IsGamel: Boolean;
begin
  id:=Byte(Param);
  EnterCriticalSection(_cs);
  SSockl:=Thread[id].SSock;
  if not InitSocket(Thread[id].CSock,0,'0.0.0.0') then begin
    EndThread(0);
  end;
  if not ConnectToServer(Thread[id].CSock,Thread[id].Port,Thread[id].IP) then begin
    EndThread(0);
  end;
  //инициируем переменные ConnectID и OnConnect в скрипте
  SendMessage(L2PacketHackMain.Handle, WM_SetConnect, 0, id);
  //ждем подключения
  Thread[id].Connect:=True;
  SetEvent(Thread[id].ConnectEvent);
  Thread[id].Name:='';
  CSockl:=Thread[id].CSock;
  LeaveCriticalSection(_cs);

  GetSocketData(CSockl,Packet,2);
  EnterCriticalSection(_cs);
  if not Thread[id].AutoPing then begin
    Thread[id].IsGame:=False;
  end;
  IsGamel:=Thread[id].IsGame;
  LeaveCriticalSection(_cs);
  //если (пропускать логин и мы не в игре)
  if isPassLogin and (not IsGamel) then begin
    //отсылаем данные, сначала длину, а потом сам пакет
    send(SSockl,PacketB,2,0);
    repeat until send(SSockl,PacketB,recv(CSockl,PacketB,$FFFF,0),0)<=0;
  end else
  repeat
    //иначе (пропускать логин и мы в игре)
    //прием пакетов
    if not GetSocketData(CSockl,Packet.DataB,Packet.Size-2) then break;
    if IsGamel
      then PacketProcesor(PacketB,SSockl,id,3)
      else PacketProcesor(PacketB,SSockl,id,1);
    if not GetSocketData(CSockl,Packet,2) then break;
  until False;

  //сюда попадаем когда отвалился клиент
  //инициируем переменные ConnectID и OnDisconnect в скрипте
  sendMSG('Disconnect: отвалился клиент Thread[id].CH '+inttostr(Thread[id].CH)+'/'+inttostr(Thread[id].CTH)+' id:'+inttostr(id));
  PostMessage(L2PacketHackMain.Handle, WM_SetDisconnect, 0, id);

  //не разрываем связь если отключен клиент и noFreeOnClientDisconnect
  while Thread[id].noFreeOnClientDisconnect do Sleep(1);
  EnterCriticalSection(_cs);
  //дождемся закрытия потока
  //PostMessage(L2PacketHackMain.Handle, WM_Finished, 0, Thread[id].CH);
  //обновляем Список соединений
//  PostMessage(L2PacketHackMain.Handle, WM_UpdateComboBox1, 0, 0);
  sendMSG('Thread Exit: поток клиента Thread[id].CH '+inttostr(Thread[id].CH)+'/'+inttostr(Thread[id].CTH)+' id:'+inttostr(id));
  Closehandle(Thread[id].CH);
  Thread[id].cd._id_mix:=False;
  LeaveCriticalSection(_cs);
end;
//....................
//конец - 2-й рабочий поток

end.
