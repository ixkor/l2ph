unit uVisualContainer;

interface

uses
  uGlobalFuncs,
  uSharedStructs,
  StrUtils,
  uREsourceStrings,
  LSPControl,
  uScriptEditor,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, JvExControls, JvEditorCommon, JvEditor, JvHLEditor,
  StdCtrls, ComCtrls, ToolWin, JvExStdCtrls, JvRichEdit, ExtCtrls, Menus,
  JvExExtCtrls, JvNetscapeSplitter, Mask, JvExMask, JvSpin, JvLabel,
  fs_iinterpreter, fs_ipascal, siComp;

type

  TfVisual = class(TFrame)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    GroupBox6: TGroupBox;
    Splitter1: TSplitter;
    Memo3: TJvRichEdit;
    Memo2: TJvRichEdit;
    GroupBox12: TGroupBox;
    ListView5: TListView;
    TabSheet2: TTabSheet;
    Splitter7: TSplitter;
    GroupBox7: TGroupBox;
    Memo4: TJvRichEdit;
    Panel10: TPanel;
    Splitter2: TSplitter;
    TabSheet3: TTabSheet;
    GroupBox8: TGroupBox;
    imgBT: TImageList;
    ImageList2: TImageList;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    dlgSaveLog: TSaveDialog;
    JvNetscapeSplitter1: TJvNetscapeSplitter;
    Panel2: TPanel;
    Memo5: TJvRichEdit;
    Label1: TLabel;
    Panel3: TPanel;
    Memo8: TJvRichEdit;
    Label2: TLabel;
    Panel4: TPanel;
    ToolBar1: TToolBar;
    tbtnSave: TToolButton;
    tbtnClear: TToolButton;
    ToolButton1: TToolButton;
    tbtnFilterDel: TToolButton;
    tbtnDelete: TToolButton;
    ToolButton15: TToolButton;
    tbtnToSend: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton9: TToolButton;
    ToolButton6: TToolButton;
    ToolButton17: TToolButton;
    Panel5: TPanel;
    Panel7: TPanel;
    ToolBar3: TToolBar;
    ToolButton37: TToolButton;
    ToolButton38: TToolButton;
    timerSend: TTimer;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel11: TPanel;
    ToolBar5: TToolBar;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    ToolBar2: TToolBar;
    SaveBnt: TToolButton;
    OpenBtn: TToolButton;
    ToolButton14: TToolButton;
    ToServer: TToolButton;
    ToClient: TToolButton;
    ToolButton19: TToolButton;
    EachLinePacket: TToolButton;
    ToolButton13: TToolButton;
    SendBtn: TToolButton;
    ToolButton26: TToolButton;
    SendByTimer: TToolButton;
    JvSpinEdit2: TJvSpinEdit;
    fsScript: TfsScript;
    Panel12: TPanel;
    Panel13: TPanel;
    ToolBar6: TToolBar;
    ToolButton25: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    btnExecute: TToolButton;
    btnTerminate: TToolButton;
    ToolButton8: TToolButton;
    btnSaveRaw: TToolButton;
    dlgSaveLogRaw: TSaveDialog;
    DlgSavePacket: TSaveDialog;
    DlgOpenPacket: TOpenDialog;
    Panel14: TPanel;
    DlgOpenScript: TOpenDialog;
    dlgSaveScript: TSaveDialog;
    waitbar: TPanel;
    ProgressBar1: TProgressBar;
    Label3: TLabel;
    lang: TsiLang;
    ReloadThis: TToolButton;
    procedure ListView5Click(Sender: TObject);
    procedure ListView5KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo2DblClick(Sender: TObject);
    procedure Memo2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbtnToSendClick(Sender: TObject);
    procedure ToolButton17Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure CloseConnectionClick(Sender: TObject);
    procedure tbtnClearClick(Sender: TObject);
    procedure tbtnFilterDelClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure Memo4Change(Sender: TObject);
    procedure ToServerClick(Sender: TObject);
    procedure ToClientClick(Sender: TObject);
    procedure Memo4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SaveBntClick(Sender: TObject);
    procedure JvSpinEdit2Change(Sender: TObject);
    procedure SendByTimerClick(Sender: TObject);
    procedure SendBtnClick(Sender: TObject);
    procedure ToolButton30Click(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnTerminateClick(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure ToolButton27Click(Sender: TObject);
    procedure ToolButton25Click(Sender: TObject);
    procedure btnSaveRawClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure ReloadThisClick(Sender: TObject);
  private
    { Private declarations }
    typ0 : String;
    hScriptThread, idScriptThread: cardinal;
    SelLength: integer;
    kId: cardinal; //коэфф преобразования NpcID
    HexViewOffset: boolean;   //показывать смещение в Hex формате
    SelAttributes: TColor;
    Edit:tfscripteditor;
  public
    dump, dumpacumulator : TStringList;
    hexvalue: string; //для вывода HEX в расшифровке пакетов
    currenttunel, currentLSP, CurrentTpacketLog : Tobject;
    CharName : string;
    procedure ProcessPacket(newpacket: tpacket; FromServer: boolean; Caller: TObject; PacketNumber:integer);
    Procedure processpacketfromacum();
    procedure AddPacketToAcum(newpacket: tpacket; FromServer: boolean; Caller: TObject);
    procedure init();
    Procedure Translate();
    procedure deinit();
    procedure ListViewChange(Item: TListItem; Memo, Memo2: TJvRichEdit);




    function GetNpcID(const ar1 : cardinal) : string;
    function GetValue(typ, name, PktStr: string; var PosInPkt: integer; size:word; Memo: TJvRichEdit): string;
    { Public declarations }
    procedure sendThis(str:string);

    Procedure SavePacketLog;                      //сохраняет Dump в файл
    Procedure PacketListRefresh;
    Procedure DisableBtns;
    Procedure EnableBtns;
    procedure disableControls;
    Procedure enableControls;
    procedure IDontknowHowToNameThis;
    Procedure setNofreeBtns(down:boolean);
    Procedure ThisOneDisconnected;

  end;

implementation
uses uencdec, uMain, uSocketEngine, uFilterForm, uData, uScripts;

{$R *.dfm}

{ TFrame1 }

procedure TfVisual.init;
begin
  translate();
  { TODO : Воттут }
  //dmData.UpdateEditor(JvHLEditor2);
  Panel7.Width := 46;
  if assigned(currenttunel) then
      btnSaveRaw.Visible := Ttunel(currenttunel).isRawAllowed;

  if Assigned(currentLSP) then
      btnSaveRaw.Visible := TlspConnection(currentLSP).isRawAllowed;
  edit := TfScriptEditor.Create(GroupBox8);
  Edit.Parent := GroupBox8;
  edit.Source.Lines.SetText(
  'begin'#10#13+
  'buf:=#$4A;'#10#13+
  'WriteD(0);'#10#13+
  'WriteD(10);'#10#13+
  'WriteS('''');'#10#13+
  'WriteS(''Hello!!!'');'#10#13+
  'SendToClient;'#10#13+
  'end.');
  dmData.UpdateAutoCompleate(edit.AutoComplete);
  
  Dump := TStringList.Create;
  dumpacumulator := TStringList.Create;
  ToolButton7.Down := GlobalSettings.isSaveLog;
  if CurrentTpacketLog <> nil then //просмотр логов. просто скрываем все ненужное.
    begin
      TabSheet2.TabVisible := false;
      TabSheet2.Hide;
      TabSheet3.TabVisible := false;
      TabSheet3.Hide;
      TabSheet1.TabVisible := false;
      N2.Visible := false;
      ToolButton2.Visible := false;
      tbtnToSend.Hide;
      ToolButton37.Hide;
      ToolButton37.Hide;
      ToolButton38.Hide;
      ToolButton8.Show;
      dump.LoadFromFile(TpacketLogWiev(CurrentTpacketLog).sFileName);
      PacketListRefresh;
      //в этом екземпляре нет соединения!
    end;
  //
end;

procedure TfVisual.deinit;
begin
  SavePacketLog;
  Dump.Destroy;
  dumpacumulator.Destroy;
  edit.Destroy;
end;

procedure TfVisual.Processpacket;
    Procedure AddToListView5(ItemImageIndex:byte; ItemCaption:String; ItemPacketNumber: LongWord; ItemId, ItemSubId : word; Visible : boolean);
    var
      str : string;
    begin
    with ListView5.Items.Add do begin
          //имя пакета
          Caption := ItemCaption;
          //код иконки
          ImageIndex := ItemImageIndex;
          //номер
          SubItems.Add(IntToStr(ItemPacketNumber));
          //код пакета

          if ItemId = 0 then
            str := IntToHex(ItemSubId,4)
          else
            str := IntToHex(ItemId,2);

          SubItems.Add(str);
          if not Visible then MakeVisible(false);
        end;
    end;

    Procedure AddToPacketFilterUnknown(ItemFromServer : boolean; ItemId, ItemSubId:Word; ItemChecked:boolean);
    var
      CurrentList : TListView;
      currentpackedfrom : TStringList;
      str:string;
    begin
      if ItemFromServer then
        begin
        currentpackedfrom := PacketsFromS;
        CurrentList := fPacketFilter.ListView1
        end
      else
        begin
        currentpackedfrom := PacketsFromC;
        CurrentList := fPacketFilter.ListView2;
        end;

      with CurrentList.Items.Add do
      begin
        if ItemId = 0 then
            str := IntToHex(ItemSubId,4)
          else
            str := IntToHex(ItemId,2);

        Caption :=str;
        Checked := ItemChecked;
        SubItems.Add('Unknown');
        currentpackedfrom.Append(str+'=Unknown:h(SubId)');
      end;
    end;
var
  id: Byte;
  subid: word;
  i: integer;

begin
  if PacketNumber < 0 then exit; //или -1 0_о
  if PacketNumber >= Dump.Count then exit; //или индекс оф боундс -)
  if newpacket.Size = 0 then exit; // если пустой пакет выходим
  
  id := newpacket.Data[0];
  SubId := Word(id shl 8+Byte(newpacket.Data[1]));


  //------------------------------------------------------------------------
  //расшифровываем коды пакетов и вносим неизвестные в списки пакетов
  if FromServer then begin  //от сервера
    if id=$FE then begin
      //находим индекс пакета
      i := PacketsFromS.IndexOfName(IntToHex(subid,4));
      if i=-1 then
      begin
        //неизвестный пакет от сервера
          AddToListView5(0, 'Unknown', PacketNumber, 0, subid, not ToolButton5.Down);
          //добавляем в список пакетов так как его там нет
          AddToPacketFilterUnknown(FromServer, 0, subid, True);
      end
      else
        if ToolButton4.Down and (fPacketFilter.ListView1.Items.Item[i].Checked) then
            AddToListView5(0, fPacketFilter.ListView1.Items.Item[i].SubItems[0], PacketNumber, 0, subid, not ToolButton5.Down);
    end
    else
    begin
      i:=PacketsFromS.IndexOfName(IntToHex(id,2));
      if i=-1 then
      begin
        //неизвестный пакет от сервера
        AddToListView5(0, 'Unknown', PacketNumber, id, 0, not ToolButton5.Down);
        ////добавляем в список пакетов так как его там нет
        AddToPacketFilterUnknown(FromServer, id, 0, True);
      end else
        if ToolButton4.Down and (fPacketFilter.ListView1.Items.Item[i].Checked) then
          AddToListView5(0, fPacketFilter.ListView1.Items.Item[i].SubItems[0], PacketNumber, id, 0, not ToolButton5.Down);
    end;
  end;
  
  if not FromServer then
  begin  //от клиента
    if GlobalProtocolVersion<828 then begin //фиксим пакет 39 в Камаель-Грация
      if (id in [$39,$D0]) then begin //для C4, C5, T0
        i:=PacketsFromC.IndexOfName(IntToHex(subid,4));
        if i=-1 then
        begin
          //неизвестный пакет от клиента
          AddToListView5(1, 'Unknown', PacketNumber, 0, subid, not ToolButton5.Down);
          //добавляем в список пакетов так как его там нет
          AddToPacketFilterUnknown(FromServer, 0, subid, True);
        end else
          if ToolButton3.Down and (fPacketFilter.ListView2.Items.Item[i].Checked) then
            AddToListView5(1, fPacketFilter.ListView2.Items.Item[i].SubItems[0], PacketNumber, 0, subid, not ToolButton5.Down);
      end else
      begin
        i:=PacketsFromC.IndexOfName(IntToHex(id,2));
        if i=-1 then
        begin
          //неизвестный пакет от клиента
          AddToListView5(1, 'Unknown', PacketNumber, id, 0, not ToolButton5.Down);
          //добавляем в список пакетов так как его там нет
          AddToPacketFilterUnknown(FromServer, id, 0, True);
        end else
          if ToolButton3.Down and (fPacketFilter.ListView2.Items.Item[i].Checked) then
            AddToListView5(1, fPacketFilter.ListView2.Items.Item[i].SubItems[0], PacketNumber, 0, subid, not ToolButton5.Down);
      end;
    end else
    begin
      if (id=$D0) then
      begin //для T1 и выше
        i:=PacketsFromC.IndexOfName(IntToHex(subid,4));
        if i=-1 then
        begin
          //неизвестный пакет от клиента
          AddToListView5(1, 'Unknown', PacketNumber, 0, subid, not ToolButton5.Down);
          //добавляем в список пакетов так как его там нет
          AddToPacketFilterUnknown(FromServer, 0, subid, True);
        end else
          if ToolButton3.Down and (fPacketFilter.ListView2.Items.Item[i].Checked) then
            AddToListView5(1, fPacketFilter.ListView2.Items.Item[i].SubItems[0], PacketNumber, 0, subid, not ToolButton5.Down);
      end else
      begin
        i:=PacketsFromC.IndexOfName(IntToHex(id,2));
        if i=-1 then
        begin
          //неизвестный пакет от клиента
          AddToListView5(1, 'Unknown', PacketNumber, id, 0, not ToolButton5.Down);
          //добавляем в список пакетов так как его там нет
          AddToPacketFilterUnknown(FromServer, id, 0, True);
        end else
          if ToolButton3.Down and (fPacketFilter.ListView2.Items.Item[i].Checked) then
            AddToListView5(1, fPacketFilter.ListView2.Items.Item[i].SubItems[0], PacketNumber, id, 0, not ToolButton5.Down);

      end;
    end;
  end;   
end;

procedure TfVisual.ListView5Click(Sender: TObject);
begin
  typ0:='я';
  if ListView5.SelCount=1 then
    begin
    EnableBtns;
    ListViewChange(ListView5.Selected,Memo3,Memo2);
    end;
end;


procedure TfVisual.ListView5KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
ListView5Click(Sender);
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

function prnoffset(offset:integer):string;
begin
  result:=inttostr(offset);
  case Length(result) of
    1: result:='000'+result;
    2: result:='00'+result;
    3: result:='0'+result;
  end;
end;


procedure TfVisual.ListViewChange(Item: TListItem; Memo, Memo2: TJvRichEdit);
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
    //строка пакета, sid номер пакета, cid номер соединения
    PktStr:=HexToString(Dump.Strings[sid]);
    if Length(PktStr)<12 then Exit;
    Move(PktStr[2],ptime,8);
    Size:=Word(Byte(PktStr[11]) shl 8)+Byte(PktStr[10]);
    id:=Byte(PktStr[12]);                   //фактическое начало пакета, ID
    SubId:=Word(id shl 8+Byte(PktStr[13])); //считываем SubId
    Memo.Lines.BeginUpdate;
    try
    Memo.Clear;
    Memo.Lines.Add(StringToHex(Copy(PktStr,12,Length(PktStr)-11),' '));
    GroupBox6.Caption:='Выделенный пакет: тип - 0x'+IntToHex(id,2)+', '+Item.Caption+lang.GetTextOrDefault('size' (* ', размер - ' *) )+IntToStr(Size);
    finally
    Memo.Lines.EndUpdate;
    end;
    //считываем строку из packets.ini для парсинга
    if PktStr[1]=#04 then begin //client
      if GlobalProtocolVersion<828 then begin //фиксим пакет 39 для Грация-Камаель
        if (ID in [$39,$D0]) and (size>3) then begin //C4, C5, T0
          StrIni:=PacketsINI.ReadString('client',IntToHex(subid,4),'Unknow:h(subID)');
        end
        else begin
          StrIni:=PacketsINI.ReadString('client',IntToHex(id,2),'Unknow:');
        end;
      end else begin
        if (ID=$D0) and (size>3) then begin //T1 и выше
          StrIni:=PacketsINI.ReadString('client',IntToHex(subid,4),'Unknow:h(subID)');
        end
        else begin
          StrIni:=PacketsINI.ReadString('client',IntToHex(id,2),'Unknow:');
        end;
      end;
    end else begin //server
      if (ID in [$FE]) and (size>3) then begin
        StrIni:=PacketsINI.ReadString('server',IntToHex(subid,4),'Unknow:h(subID)');
      end else begin
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
    Memo2.Lines.Add(lang.GetTextOrDefault('size2' (* 'Pазмер: ' *) )+IntToStr(Size-2)+'+2');
    Memo2.Lines.Add(lang.GetTextOrDefault('IDS_126' (* 'Время прихода: ' *) )+FormatDateTime('hh:nn:ss:zzz',ptime));
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
    try
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
        try
          if StrToIntDef(value, 0) <> StrToIntDef(value, 1) then exit; 
          if param1='FUNC01' then   value:=GetFunc01(strtoint(value)) else
          if param1='FUNC02' then   value:=GetFunc02(strtoint(value)) else
          if param1='FUNC09' then   value:=GetFunc09(id, strtoint(value)) else
          if param1='CLASSID' then  value:=GetClassID(strtoint(value)) else
          if param1='FSUP' then     value:=GetFsup(strtoint(value)) else
          if param1='NPCID' then    value:=GetNpcID(strtoint(value)) else
          if param1='MSGID' then    value:=GetMsgID(strtoint(value)) else
          if param1='SKILL' then    value:=GetSkill(strtoint(value));
        except
          //ShowMessage('ошибка при распознании пакета');
          exit;
        end;
        //распечатываем
        if HexViewOffset
          then Memo2.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value)
          else Memo2.Lines.Add(prnoffset(offset)+' '+typ+' '+name+': '+value);
        //Memo2.SelStart:=d+length(inttostr(offset))+1;
        Memo2.SelStart:=d+5;
        Memo2.SelLength:=1;
        Memo2.SelAttributes.BackColor:=SelAttributes;
        d:=Memo2.GetTextLen-Memo2.Lines.Count;
      end else
      //для С4, С5 и Т0-Интерлюдия
      if uppercase(Func)='FOR' then begin
        //распечатываем
        if HexViewOffset
          then Memo2.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue)
          else Memo2.Lines.Add(prnoffset(offset)+' '+typ+' '+name+': '+value+hexvalue);
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
            Memo2.Lines.Add(lang.GetTextOrDefault('startb' (* '[Начало повторяющегося блока ' *) )+inttostr(j)+'/'+tmp_value+']');
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
              try

                if uppercase(Func)='GET' then
                begin
                if StrToIntDef(value, 0) <> StrToIntDef(value, 1) then exit;
                  if param1='FUNC01' then   value:=GetFunc01(strtoint(value)) else
                  if param1='FUNC02' then   value:=GetFunc02(strtoint(value)) else
                  if param1='FUNC09' then   value:=GetFunc09(id, strtoint(value)) else
                  if param1='CLASSID' then  value:=GetClassID(strtoint(value)) else
                  if param1='FSUP' then     value:=GetFsup(strtoint(value)) else
                  if param1='NPCID' then    value:=GetNpcID(strtoint(value)) else
                  if param1='MSGID' then    value:=GetMsgID(strtoint(value)) else
                  if param1='SKILL' then    value:=GetSkill(strtoint(value));
                end;
              except
                //ShowMessage('ошибка при распознании пакета');
                exit;
              end;
              //распечатываем
              if HexViewOffset
                then Memo2.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value)
                else Memo2.Lines.Add(prnoffset(offset)+' '+typ+' '+name+': '+value);
              //Memo2.SelStart:=d+length(inttostr(offset))+1;
              Memo2.SelStart:=d+5;
              Memo2.SelLength:=1;
              Memo2.SelAttributes.BackColor:=SelAttributes;
              d:=Memo2.GetTextLen-Memo2.Lines.Count;
            end;
            Memo2.Lines.Add(lang.GetTextOrDefault('endb' (* '[Конец повторяющегося блока  ' *) )+inttostr(j)+'/'+tmp_value+']');
            d:=Memo2.GetTextLen-Memo2.Lines.Count;
          end;
        end;
      end else
      //для Т1 - Камаель-Хелбаунд-Грация
      {в функции LOOP первый параметр может быть больше 1,
       значит его просто выводим, а остальное
       в цикле до параметр 2}
      if uppercase(Func)='LOOP' then begin
        //распечатываем
        if HexViewOffset
          then Memo2.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue)
          else Memo2.Lines.Add(prnoffset(offset)+' '+typ+' '+name+': '+value+hexvalue);
        //Memo2.SelStart:=d+length(inttostr(offset))+1;
        Memo2.SelStart:=d+5;
        Memo2.SelLength:=1;
        Memo2.SelAttributes.BackColor:=SelAttributes;
        d:=Memo2.GetTextLen-Memo2.Lines.Count;
        tmp_param:=param2;
        tmp_value:=value;
        if value='range error' then exit;
        if StrToInt(value)=0 then begin

          //сделать проверку на то, что первый параметр может быть больше 1

          //пропускаем пустые значения
          for jj:=1 to StrToInt(param1) do begin
            Param0:=GetType(StrIni,PosInIni);
            inc(PosInIni);
          end;
        end else begin
          //проверка, что param1 > 1
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
              if HexViewOffset
                then Memo2.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue)
                else Memo2.Lines.Add(prnoffset(offset)+' '+typ+' '+name+': '+value+hexvalue);
              //Memo2.SelStart:=d+length(inttostr(offset))+1;
              Memo2.SelStart:=d+5;
              Memo2.SelLength:=1;
              Memo2.SelAttributes.BackColor:=SelAttributes;
              d:=Memo2.GetTextLen-Memo2.Lines.Count;
            end;
          end;
          ii:=PosInIni;
          for j:=1 to StrToInt(tmp_value) do begin
            Memo2.Lines.Add(lang.GetTextOrDefault('startb' (* '[Начало повторяющегося блока ' *) )+inttostr(j)+'/'+tmp_value+']');
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
              try

                if uppercase(Func)='GET' then
                begin
                  if StrToIntDef(value, 0) <> StrToIntDef(value, 1) then exit;
                  if param1='FUNC01' then   value:=GetFunc01(StrToInt(value)) else
                  if param1='FUNC02' then   value:=GetFunc02(strtoint(value)) else
                  if param1='FUNC09' then   value:=GetFunc09(id, strtoint(value)) else
                  if param1='CLASSID' then  value:=GetClassID(strtoint(value)) else
                  if param1='FSUP' then     value:=GetFsup(strtoint(value)) else
                  if param1='NPCID' then    value:=GetNpcID(strtoint(value)) else
                  if param1='MSGID' then    value:=GetMsgID(strtoint(value)) else
                  if param1='SKILL' then    value:=GetSkill(strtoint(value));
                end;
              except
                //ShowMessage('ошибка при распознании пакета');
                exit;
              end;
              //распечатываем
              if HexViewOffset
                then Memo2.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value)
                else Memo2.Lines.Add(prnoffset(offset)+' '+typ+' '+name+': '+value);
              //Memo2.SelStart:=d+length(inttostr(offset))+1;
              Memo2.SelStart:=d+5;
              Memo2.SelLength:=1;
              Memo2.SelAttributes.BackColor:=SelAttributes;
              d:=Memo2.GetTextLen-Memo2.Lines.Count;
            end;
            Memo2.Lines.Add(lang.GetTextOrDefault('endb' (* '[Конец повторяющегося блока  ' *) )+inttostr(j)+'/'+tmp_value+']');
            d:=Memo2.GetTextLen-Memo2.Lines.Count;
          end;
        end;
      end else begin
        //распечатываем
        if HexViewOffset
          then Memo2.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue)
          else Memo2.Lines.Add(prnoffset(offset)+' '+typ+' '+name+': '+value+hexvalue);
        //Memo2.SelStart:=d+length(inttostr(offset))+1;
        Memo2.SelStart:=d+5;
        Memo2.SelLength:=1;
        Memo2.SelAttributes.BackColor:=SelAttributes;
        d:=Memo2.GetTextLen-Memo2.Lines.Count;
      end;
    end;
    except
      //ошибка при распознании пакета
    end;
    //Memo2.Lines.EndUpdate;
  end;  //*)
end;

function TfVisual.GetValue(typ, name, PktStr: string;
  var PosInPkt: integer; size: word; Memo: TJvRichEdit): string;
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
          value:=lang.GetTextOrDefault('skip' (* 'Пропускаем ' *) )+inttostr(d)+lang.GetTextOrDefault('byte' (* ' байт(а)' *) );
        end else
          value:=lang.GetTextOrDefault('skip scrypt' (* 'Пропускаем скрипт' *) );
      end else begin
        d:=strtoint(name); Inc(PosInPkt,d);
        value:=lang.GetTextOrDefault('skip' (* 'Пропускаем ' *) )+inttostr(d)+lang.GetTextOrDefault('byte' (* ' байт(а)' *) );
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
    else value:= lang.GetTextOrDefault('unknowind' (* 'Неизвестный идентификатор -> ?(name)!' *) );
  end;
  Result:=value;
  //проверяем на выход за границу пакета
  //if PosInPkt>Size+10 then raise ERangeError.CreateFmt(result+' is not within the valid range of %d', [Size]);
  if PosInPkt>Size+10 then result:='range error';
end;


function TfVisual.GetNpcID(const ar1: cardinal): string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.NpcID - возвращает текст по его ID из значения аргумента
var
 _ar1: cardinal;
begin
  _ar1:=ar1-kId;
  result:='0'; if ar1=0 then exit;
  result:=NpcIdList.Values[inttostr(_ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown Npc ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;


procedure TfVisual.Memo2DblClick(Sender: TObject);
var
 i, j: integer;
 str, str2: string;
begin
 if str = '' then exit;
 str:=Memo2.Lines.Strings[Memo2.CaretPos.Y]; //считываем строку под курсором
 if str = '' then exit;
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
   //считае смещение в пакете в зависимости от отображения его в hex/dec
   if HexViewOffset
     then
       begin
         if StrToIntDef('$'+copy(str,1,4),1) <> StrToIntDef('$'+copy(str,1,4),2) then exit; //простая проверка на то является ли параметр интом. изврат -)
         i:=strtoint('$'+copy(str,1,4));
       end
     else
       begin
         if StrToIntDef(copy(str,1,4),1) <> StrToIntDef(copy(str,1,4),2) then exit; //простая проверка на то является ли параметр интом. изврат -)
         i:=StrToInt(copy(str,1,4));
       end;
   Memo3.SelStart:=(i-1)*3;
   case str[6] of
     'd': begin Memo3.SelLength:=11; typ0:='d'; end;
     'c': begin Memo3.SelLength:=2; typ0:='c'; end;
     'f': begin Memo3.SelLength:=23; typ0:='f'; end;
     'h': begin Memo3.SelLength:=5; typ0:='h'; end;
     'q': begin Memo3.SelLength:=23; typ0:='q'; end;
     's': begin
         str2:=Memo2.Lines.Strings[Memo2.CaretPos.Y+1]; //считываем следующую строку
         if str2 = '' then exit;
         if str2[1]='[' then begin
           str2:=Memo2.Lines.Strings[Memo2.CaretPos.Y+2];
           if str2 <> '' then if str2[1]='[' then str2:=Memo2.Lines.Strings[Memo2.CaretPos.Y+3];
         end;
         j:=StrToIntDef(copy(str2,1,4),0);
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
procedure TfVisual.Memo2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Memo2DblClick(Sender);
end;

procedure TfVisual.Memo2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Memo2DblClick(Sender);
end;

procedure TfVisual.tbtnToSendClick(Sender: TObject);
begin
  if Memo4.Text <> '' then
    EachLinePacket.Down := true;
  Memo4.Lines.Add(Copy(Memo3.Text,1,Pos(sLineBreak,Memo3.Text)-1));
end;

procedure TfVisual.ToolButton17Click(Sender: TObject);
begin
  HexViewOffset := ToolButton17.Down;
  PacketListRefresh;
end;

procedure TfVisual.ToolButton6Click(Sender: TObject);
begin
  if fPacketFilter.Visible then
    fPacketFilter.Hide
  else
    fPacketFilter.Show;
end;

procedure TfVisual.tbtnSaveClick(Sender: TObject);
begin
  if dlgSaveLog.Execute then
    Dump.SaveToFile(dlgSaveLog.FileName);
end;

{$warnings off}
procedure TfVisual.SavePacketLog;
var
SaveThis: TStringList;
begin
  if not assigned(dump) then exit;

  if ToolButton7.Down then
  begin
    AddToLog(rsSavingPacketLog);
    SaveThis := TStringList.Create;
    SaveThis.Assign(dump);
  end;
  Dump.Clear;
  ListView5.Items.BeginUpdate;
  ListView5.Items.Clear;
  ListView5.Items.EndUpdate;

  if ToolButton7.Down then
  begin
    if CharName <> '' then
      if SaveThis.Count > 0 then
        SaveThis.SaveToFile(PChar(ExtractFilePath(ParamStr(0)))+'logs\'+CharName+' '+AddDateTime+'.txt');
    SaveThis.Free;
  end;
end;
{$warnings on}
procedure TfVisual.CloseConnectionClick(Sender: TObject);
begin
if MessageDlg(lang.GetTextOrDefault('reallywant' (* 'Это действие закроет данный диалог и прервет текущее соединение' *) ) + #10#13+lang.GetTextOrDefault('reallywant2' (* 'если оно существует. Вы уверены ?' *) ),mtWarning,[mbYes,mbNo],0) = mrCancel then exit;
  if assigned(currenttunel) then
    Ttunel(currenttunel).MustBeDestroyed := true;
  if Assigned(currentLSP) then
    begin
    TlspConnection(currentLSP).DisconnectAfterDestroy := true;
    TlspConnection(currentLSP).mustbedestroyed := true;
    end;
end;

procedure TfVisual.tbtnClearClick(Sender: TObject);
begin
  dump.Clear;
  ListView5.Clear;
end;

procedure TfVisual.tbtnFilterDelClick(Sender: TObject);
var
  PktStr: string;
  i, indx: Integer;
  tmpItm: TListItem;
  from, id: Byte;
  subid: word;
begin
  DisableBtns;
  tmpItm:=ListView5.Selected;
  for i:=0 to ListView5.SelCount-1 do begin
    PktStr:=HexToString(Dump.Strings[StrToInt(tmpItm.SubItems.Strings[0])]);
    if Length(PktStr)<12 then Exit;
    from:=Byte(PktStr[1]);   //клиент=4, сервер=3
    id:=Byte(PktStr[12]);   //фактическое начало пакета, ID
    SubId:=Word(id shl 8+Byte(PktStr[13])); //считываем SubId
    if from=4 then begin
      //от клиента
      if (id in [$39,$D0]) then begin
        //находим индекс пакета
        indx:=PacketsFromC.IndexOfName(IntToHex(subid,4));
        if indx>-1 then fPacketFilter.ListView2.Items.Item[indx].Checked:=False;
      end else begin
        indx:=PacketsFromC.IndexOfName(IntToHex(id,2));
        if indx>-1 then fPacketFilter.ListView2.Items.Item[indx].Checked:=False;
      end;
    end else begin
      //от сервера
      if id=$FE then begin
        //находим индекс пакета
        indx:=PacketsFromS.IndexOfName(IntToHex(subid,4));
        if indx>-1 then fPacketFilter.ListView1.Items.Item[indx].Checked:=False;
      end else begin
        indx:=PacketsFromS.IndexOfName(IntToHex(id,2));
        if indx>-1 then fPacketFilter.ListView1.Items.Item[indx].Checked:=False;
      end;
    end;
    tmpItm:=ListView5.GetNextItem(tmpItm,sdAll,[isSelected]);
  end;
  fPacketFilter.UpdateBtn.Click;
end;

procedure TfVisual.PacketListRefresh;
var
  i: Integer;
  FromServer: boolean;
  Currentpacket:TPacket;
  str : string;
  pm:integer;
begin
  waitbar.Show;
  //расшифровываем лог пакетов
  DisableBtns;
  ListView5.Items.BeginUpdate;
  try
    ListView5.Items.Clear;
    Memo3.Clear;
    Memo2.Clear;
    ProgressBar1.Max := dump.Count;
    pm := 0;
    for i := 0 to Dump.Count-1 do
    begin
      if pm < 50 then
        begin
          pm := 30;
          ProgressBar1.Position := i;
          Application.ProcessMessages;
        end;
      dec(pm);
      //смотрим второй байт в каждом пакете
      str := dump.Strings[i];
      FromServer := (str[2]='3');
      Delete(str,1,18);
      HexToBin(@str[1], Currentpacket.PacketAsCharArray, round(Length(str)/2));
      ProcessPacket(Currentpacket, FromServer, nil, i);
    end;
  finally
    ListView5.Items.EndUpdate;
    waitbar.Hide;
  end;
end;

procedure TfVisual.DisableBtns;
begin
  tbtnToSend.Enabled := false;
  tbtnFilterDel.Enabled := false;
  tbtnDelete.Enabled := false;
  n1.Enabled := false;
  N2.Enabled := false;
end;

procedure TfVisual.EnableBtns;
begin
  tbtnToSend.Enabled := true;
  tbtnFilterDel.Enabled := true;
  tbtnDelete.Enabled := true;
  n1.Enabled := true;
  N2.Enabled := true;
end;

procedure TfVisual.tbtnDeleteClick(Sender: TObject);
  var
  i,k:Integer;
  tmpItm: TListItem;


begin
  tmpItm:=ListView5.Selected;
  for i:=1 to ListView5.SelCount do
  begin
    k:=StrToInt(tmpItm.SubItems.Strings[0])-i+1;
    Dump.Delete(k);
    tmpItm:=ListView5.GetNextItem(tmpItm,sdAll,[isSelected]);
  end;
  PacketListRefresh;
end;

procedure TfVisual.ToolButton4Click(Sender: TObject);
begin
  PacketListRefresh;
end;

procedure TfVisual.Memo4Change(Sender: TObject);
var
  i,k:Integer;
  temp: string;
  p: TPoint;
  b: Boolean;
begin
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
end;

procedure TfVisual.disableControls;
begin
OpenBtn.Enabled := false;
ToServer.Enabled := false;
ToClient.Enabled := false;
end;

procedure TfVisual.enableControls;
begin
OpenBtn.Enabled := true;
ToServer.Enabled := true;
ToClient.Enabled := true;
end;

procedure TfVisual.ToServerClick(Sender: TObject);
begin
ToServer.Down := true;
ToClient.Down := false;
IDontknowHowToNameThis;
end;

procedure TfVisual.ToClientClick(Sender: TObject);
begin
ToServer.Down := false;
ToClient.Down := true;
IDontknowHowToNameThis;
end;

procedure TfVisual.IDontknowHowToNameThis;
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
  Memo8.Clear;
  Memo5.Clear;
  if Size>2 then begin
    id:=Byte(PktStr[12]);                   //фактическое начало пакета, ID
    SubId:=Word(id shl 8+Byte(PktStr[13])); //считываем SubId
    //Memo5.Lines.BeginUpdate;
    //Memo8.Lines.BeginUpdate;
    Memo5.Lines.Add(StringToHex(Copy(PktStr,12,Length(PktStr)-11),' '));
    //считываем строку из packets.ini для парсинга
//    if PktStr[1]=#04 then begin //client
    if ToServer.Down then
    begin //from client
      if GlobalProtocolVersion<828 then begin //фиксим пакет 39 для Грация-Камаель
        if (ID in [$39,$D0]) and (size>3) then begin //C4, C5, T0
          StrIni:=PacketsINI.ReadString('client',IntToHex(subid,4),'Unknow:h(subID)');
        end
        else begin
          StrIni:=PacketsINI.ReadString('client',IntToHex(id,2),'Unknow:');
        end;
      end else begin
        if (ID=$D0) and (size>3) then begin //T1 и выше
          StrIni:=PacketsINI.ReadString('client',IntToHex(subid,4),'Unknow:h(subID)');
        end
        else begin
          StrIni:=PacketsINI.ReadString('client',IntToHex(id,2),'Unknow:');
        end;
      end;
    end else begin //from server
      if (ID in [$FE]) and (size>3) then begin
        StrIni:=PacketsINI.ReadString('server',IntToHex(subid,4),'Unknow:h(subID)');
      end else begin
        StrIni:=PacketsINI.ReadString('server',IntToHex(id,2),'Unknow:');
      end;
    end;
    //начинаем разбирать пакет по заданному в packets.ini формату
    //смещение в ini
    if Pos(':',StrIni)=0 then PosInIni:=Length(StrIni)+1 else PosInIni:=Pos(':',StrIni);
    Label1.Caption:=lang.GetTextOrDefault('IDS_109' (* 'Выделенный пакет: тип - 0x' *) )+IntToHex(id,2)+', '+Copy(StrIni,1,PosInIni-1)+lang.GetTextOrDefault('size' (* ', размер - ' *) )+IntToStr(Size);
    //смещение в pkt
    PosInPkt:=13;
    Inc(PosInIni);
    //Memo8.Clear;
    Memo8.Lines.Add(lang.GetTextOrDefault('type0x' (* 'Tип: 0x' *) )+IntToHex(id,2)+' ('+Copy(StrIni,1,PosInIni-2)+')');
    Memo8.Lines.Add(lang.GetTextOrDefault('size2' (* 'Pазмер: ' *) )+IntToStr(Size-2)+'+2');
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
    try
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
          try
            if param1='FUNC01' then   value:=GetFunc01(strtoint(value)) else
            if param1='FUNC02' then   value:=GetFunc02(strtoint(value)) else
            if param1='FUNC09' then   value:=GetFunc09(id, strtoint(value)) else
            if param1='CLASSID' then  value:=GetClassID(strtoint(value)) else
            if param1='FSUP' then     value:=GetFsup(strtoint(value)) else
            if param1='NPCID' then    value:=GetNpcID(strtoint(value)) else
            if param1='MSGID' then    value:=GetMsgID(strtoint(value)) else
            if param1='SKILL' then    value:=GetSkill(strtoint(value));
          except
            //ShowMessage('ошибка при распознании пакета');
            exit;
          end;
          //распечатываем
          if HexViewOffset
            then Memo8.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value)
            else Memo8.Lines.Add(prnoffset(offset)+' '+typ+' '+name+': '+value);
          Memo8.SelStart:=d+5;
          Memo8.SelLength:=1;
          Memo8.SelAttributes.BackColor:=SelAttributes;
          d:=Memo8.GetTextLen-Memo8.Lines.Count;
        end else
        //для С4, С5 и Т0-Интерлюдия
        if uppercase(Func)='FOR' then begin
          //распечатываем
          if HexViewOffset
            then Memo8.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue)
            else Memo8.Lines.Add(prnoffset(offset)+' '+typ+' '+name+': '+value+hexvalue);
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
              Memo8.Lines.Add(lang.GetTextOrDefault('startb' (* '[Начало повторяющегося блока ' *) )+inttostr(j)+'/'+tmp_value+']');
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
                try
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
                except
                  //ShowMessage('ошибка при распознании пакета');
                  exit;
                end;
                //распечатываем
                if HexViewOffset
                  then Memo8.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value)
                  else Memo8.Lines.Add(prnoffset(offset)+' '+typ+' '+name+': '+value);
                Memo8.SelStart:=d+5;
                Memo8.SelLength:=1;
                Memo8.SelAttributes.BackColor:=SelAttributes;
                d:=Memo8.GetTextLen-Memo8.Lines.Count;
              end;
              Memo8.Lines.Add(lang.GetTextOrDefault('endb' (* '[Конец повторяющегося блока  ' *) )+inttostr(j)+'/'+tmp_value+']');
              d:=Memo8.GetTextLen-Memo8.Lines.Count;
            end;
          end;
        end else
        //для Т1-Камаель
        if uppercase(Func)='LOOP' then begin
          //распечатываем
          if HexViewOffset
            then Memo8.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue)
            else Memo8.Lines.Add(prnoffset(offset)+' '+typ+' '+name+': '+value+hexvalue);
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
              if HexViewOffset
                then Memo8.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue)
                else Memo8.Lines.Add(prnoffset(offset)+' '+typ+' '+name+': '+value+hexvalue);
              Memo8.SelStart:=d+5;
              Memo8.SelLength:=1;
              Memo8.SelAttributes.BackColor:=SelAttributes;
              d:=Memo8.GetTextLen-Memo8.Lines.Count;
            end;
          end;
          ii:=PosInIni;
          for j:=1 to StrToInt(tmp_value) do begin
            Memo8.Lines.Add(lang.GetTextOrDefault('startb' (* '[Начало повторяющегося блока ' *) )+inttostr(j)+'/'+tmp_value+']');
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
              try
                if uppercase(Func)='GET' then begin
                  if StrToIntDef(value,1)<>StrToIntDef(value,2) then exit;
                  if param1='FUNC01' then   value:=GetFunc01(strtoint(value)) else
                  if param1='FUNC02' then   value:=GetFunc02(strtoint(value)) else
                  if param1='FUNC09' then   value:=GetFunc09(id, strtoint(value)) else
                  if param1='CLASSID' then  value:=GetClassID(strtoint(value)) else
                  if param1='FSUP' then     value:=GetFsup(strtoint(value)) else
                  if param1='NPCID' then    value:=GetNpcID(strtoint(value)) else
                  if param1='MSGID' then    value:=GetMsgID(strtoint(value)) else
                  if param1='SKILL' then    value:=GetSkill(strtoint(value));
                end;
              except
                //ShowMessage('ошибка при распознании пакета');
                exit;
              end;
              //распечатываем
              if HexViewOffset
                then Memo8.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value)
                else Memo8.Lines.Add(prnoffset(offset)+' '+typ+' '+name+': '+value);
              Memo8.SelStart:=d+5;
              Memo8.SelLength:=1;
              Memo8.SelAttributes.BackColor:=SelAttributes;
              d:=Memo8.GetTextLen-Memo8.Lines.Count;
            end;
            Memo8.Lines.Add(lang.GetTextOrDefault('endb' (* '[Конец повторяющегося блока  ' *) )+inttostr(j)+'/'+tmp_value+']');
            d:=Memo8.GetTextLen-Memo8.Lines.Count;
          end;
        end else begin
          //распечатываем
          if HexViewOffset
            then Memo8.Lines.Add(inttohex(offset,4)+' '+typ+' '+name+': '+value+hexvalue)
            else Memo8.Lines.Add(prnoffset(offset)+' '+typ+' '+name+': '+value+hexvalue);
          Memo8.SelStart:=d+5;
          Memo8.SelLength:=1;
          Memo8.SelAttributes.BackColor:=SelAttributes;
          d:=Memo8.GetTextLen-Memo8.Lines.Count;
        end;
      end;
    except
      //ошибка расшифровки пакета
    end;
//    Memo5.Lines.EndUpdate;
//    Memo8.Lines.EndUpdate;
  end else begin
//    Memo8.Clear;
//    Memo5.Clear;
    Label1.Caption:=lang.GetTextOrDefault('IDS_232' (* 'Выделенный пакет:' *) );
  end;
end;
procedure TfVisual.Memo4KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
IDontknowHowToNameThis;
end;

procedure TfVisual.Memo4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
IDontknowHowToNameThis;
end;

procedure TfVisual.SaveBntClick(Sender: TObject);
begin
  if DlgSavePacket.Execute then Memo4.Lines.SaveToFile(DlgSavePacket.FileName);
end;

procedure TfVisual.JvSpinEdit2Change(Sender: TObject);
begin
timerSend.Interval := round(JvSpinEdit2.Value*1000);
end;

procedure TfVisual.SendByTimerClick(Sender: TObject);
begin
timerSend.Enabled := SendByTimer.Down;
end;

procedure TfVisual.SendBtnClick(Sender: TObject);
var
  i: Integer;
begin
  if not EachLinePacket.Down then
  begin
    sendThis(HexToString(Memo4.Lines.Text));
  end
  else
  begin
  i := 0;
  while i < Memo4.Lines.Count do
    begin
      sendThis(HexToString(Memo4.Lines.Strings[i]));
      inc(i);
    end;
  end;
end;

procedure TfVisual.sendThis(str: string);
var
  Packet : TPacket;
begin
    if Length(str)>=1 then
    begin
      if Assigned(currenttunel) then
      begin
        FillChar(Packet.PacketAsCharArray,$ffff,#0);
        Packet.Size := length(str) + 2;
        move(str[1],Packet.Data,Packet.Size - 2);
        Ttunel(currenttunel).EncryptAndSend(Packet,ToServer.Down);
      end;
      if Assigned(currentLSP) then
      begin
        FillChar(Packet.PacketAsCharArray,$ffff,#0);
        Packet.Size := length(str) + 2;
        move(str[1],Packet.Data,Packet.Size - 2);
        dmData.encryptAndSend(TlspConnection(currentLSP), Packet, ToServer.Down);
      end;
    end;
end;

procedure TfVisual.ToolButton30Click(Sender: TObject);
var
 down : boolean;
begin

  down := (sender as TToolButton).Down;
  setNofreeBtns(down);
  if Assigned(currenttunel) then
    Ttunel(currenttunel).noFreeAfterDisconnect := down;
  if Assigned(currentLSP) then
  begin
  TlspConnection(currentLSP).noFreeAfterDisconnect := down;
  end;
end;

procedure TfVisual.setNofreeBtns(down: boolean);
begin
  ToolButton37.Down := down;
  ToolButton30.Down := down;
end;

procedure TfVisual.ThisOneDisconnected;
begin
timerSend.Enabled := false;
ToServer.Enabled := false;
ToClient.Enabled := false;
SendBtn.Enabled := false;
JvSpinEdit2.Enabled := false;
SendByTimer.Enabled := false;
SendByTimer.Down := false;
ToolButton37.Enabled := false;
ToolButton30.Enabled := false;
btnExecute.Enabled := false;
btnTerminate.Click;
end;

procedure TfVisual.btnExecuteClick(Sender: TObject);
  procedure RunScript(Visual:TfVisual);
  begin
    try
      Visual.fsScript.Execute;
    finally
      Visual.btnTerminate.Enabled:=False;
      Visual.btnExecute.Enabled:=True;
    end;
  end;
begin
    dmData.RefreshPrecompile(fsScript);
    fsScript.Lines.Assign(Edit.Source.Lines);
    if dmData.Compile(fsScript,Edit.Editor,L2PacketHackMain.StatusBar1) then
    begin
      //Делаем зелененькие поля.
      Edit.Editor.LineStateDisplay.UnchangedColor := clLime;
      Edit.Editor.LineStateDisplay.NewColor := clLime;
      Edit.Editor.LineStateDisplay.SavedColor := clLime;
      Edit.Editor.Invalidate;

      if assigned(currenttunel) then
      begin
        fsScript.Variables['ConnectID'] := Ttunel(currenttunel).serversocket;
        fsScript.Variables['ConnectName'] := Ttunel(currenttunel).EncDec.CharName;
      end
      else
      if assigned(currentLSP) then
      begin
        fsScript.Variables['ConnectID'] := TlspConnection(currenttunel).SocketNum;
        fsScript.Variables['ConnectName'] := TlspConnection(currenttunel).EncDec.CharName;
      end;

      btnExecute.Enabled:=False;
      btnTerminate.Enabled:=True;
      hScriptThread := BeginThread(nil, 0, @RunScript, Self, 0, idScriptThread);
    end;
end;

procedure TfVisual.btnTerminateClick(Sender: TObject);
begin
  fsScript.Terminate;
  TerminateThread(hScriptThread,0);
  btnTerminate.Enabled:=False;
  btnExecute.Enabled:=True;
end;

procedure TfVisual.ToolButton8Click(Sender: TObject);
begin
  TpacketLogWiev(CurrentTpacketLog).MustBeDestroyed := true;
end;

procedure TfVisual.PopupMenu1Popup(Sender: TObject);
begin
  if ListView5.SelCount=1 then
  
end;

procedure TfVisual.ToolButton27Click(Sender: TObject);
begin
  if DlgOpenScript.Execute then
    Edit.Source.Lines.LoadFromFile(DlgOpenScript.FileName);
end;

procedure TfVisual.ToolButton25Click(Sender: TObject);
begin
  if dlgSaveScript.Execute then
    Edit.Source.Lines.SaveToFile(dlgSaveScript.FileName);
end;

procedure TfVisual.btnSaveRawClick(Sender: TObject);
begin
if dlgSaveLogRaw.Execute then
  if assigned(currenttunel) then
    CopyFile(pchar(Ttunel(currenttunel).tempfilename), pchar(dlgSaveLogRaw.FileName), false)
  else
  if Assigned(currentLSP) then
    CopyFile(pchar(TlspConnection(currentLSP).tempfilename), pchar(dlgSaveLogRaw.FileName), false);
end;

procedure TfVisual.FrameResize(Sender: TObject);
begin
  waitbar.Left := round((Self.Width-waitbar.Width)/2);
  waitbar.Top := round((Self.Height-waitbar.Height)/2);
end;

procedure TfVisual.AddPacketToAcum;
var
  TimeStep : TDateTime;
  TimeStepB: array [0..7] of Byte;
  apendix : string;
  sLastPacket : string;
begin
  //на серве - апендикс 04, на клиент = 03
  if FromServer then
    apendix := '03'
  else
    apendix := '04';

  TimeStep := now;
  Move(TimeStep,TimeStepB,8);

  sLastPacket :=
           Apendix +
           ByteArrayToHex(TimeStepB,8) +
           ByteArrayToHex(newpacket.PacketAsByteArray, newpacket.Size);

  dumpacumulator.Add(sLastPacket);

//  sendAction(TencDec_Action_LOG);

end;

procedure TfVisual.processpacketfromacum;
var
  packetnumber:integer;
  str : string;
  FromServer:boolean;
  Currentpacket : TPacket;
begin
while dumpacumulator.Count > 0 do
begin
  if Dump.Count >= MaxLinesInPktLog then
    SavePacketLog;
  if dumpacumulator.Count = 0 then exit;
  PacketNumber := Dump.Count;
  dump.Add(dumpacumulator.Strings[0]);
  dumpacumulator.Delete(0);
  //смотрим второй байт в каждом пакете
  str := dump.Strings[PacketNumber];
  FromServer := (str[2]='3');
  Delete(str,1,18);
  HexToBin(@str[1], Currentpacket.PacketAsCharArray, round(Length(str)/2));
  ProcessPacket(Currentpacket, FromServer, nil, packetnumber);
end;
end;

procedure TfVisual.Translate;
begin
  Lang.Language := L2PacketHackMain.lang.Language;
end;

procedure TfVisual.ReloadThisClick(Sender: TObject);
begin
  Reload;
  PacketListRefresh;
end;

end.
