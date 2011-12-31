unit uPacketView;

interface

uses
  ComCtrls,
  SysUtils,
  StrUtils,
  uGlobalFuncs,
  Windows,
  Messages, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RVScroll, RichView, RVStyle, ExtCtrls, siComp, StdCtrls, Menus;

type
  TfPacketView = class(TFrame)
    Splitter1: TSplitter;
    rvHEX: TRichView;
    lang: TsiLang;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    RVStyle1: TRVStyle;
    N2: TMenuItem;
    Panel1: TPanel;
    rvFuncs: TRichView;
    Label2: TLabel;
    rvDescryption: TRichView;
    Splitter2: TSplitter;
    procedure rvHEXMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure rvDescryptionMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure rvDescryptionRVMouseUp(Sender: TCustomRichView;
      Button: TMouseButton; Shift: TShiftState; ItemNo, X, Y: Integer);
    procedure rvHEXRVMouseUp(Sender: TCustomRichView; Button: TMouseButton;
      Shift: TShiftState; ItemNo, X, Y: Integer);
    procedure rvHEXSelect(Sender: TObject);
    procedure rvDescryptionSelect(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure rvFuncsSelect(Sender: TObject);

  private
    procedure addToDescr(offset: integer; typ, name_, value: string);
    function GetFuncParams(FuncParamNames, FuncParamTypes :TStringList): string;
    procedure PrintFuncsParams(sFuncName :string);
    procedure fParse;
    procedure fGet;
    procedure fSwitch;
    procedure fLoop;
    procedure fFor;
    procedure fLoopM;
    function GetName(s: string): string;
    function GetTyp(s: string): string;
    function GetType(const s: string; var i: Integer): string;
    function GetFunc(s: string): string;
    function GetParam(s: string): string;
    function GetParam2(s: string): string;
    function GetFunc01(const ar1: integer): string;
    function GetFunc01Aion(const ar1: integer): string;
    function GetFuncStrAion(const ar1: integer): string;
    function GetFunc02(const ar1: integer): string;
    function GetFunc09(id: byte; ar1: integer): string;
    function GetSkill(const ar1: integer): string;
    function GetSkillAion(const ar1: integer): string;
    function GetAugment(const ar1: integer): string;
    function GetMsgID(const ar1: integer): string;
    function GetMsgIDA(const ar1: integer): string;
    function GetClassID(const ar1: integer): string;
    function GetClassIDAion(const ar1: integer): string;
    function GetFSup(const ar1: integer): string;
    function prnoffset(offset: integer): string;
    function AllowedName(Name: string): boolean;
    //для совместимости с WPF 669f
    function GetFSay2(const ar1: integer): string;
    function GetF0(const ar1: integer): string;
    function GetF1(const ar1: integer): string;
    function GetF9(ar1: integer): string;
    function GetF3(const ar1: integer): string;

    { Private declarations }
  public
    currentpacket: string;
    //kId: cardinal; //коэфф преобразования NpcID
    hexvalue: string; //для вывода HEX в расшифровке пакетов
    HexViewOffset : boolean;
    itemTag, templateindex:integer;
    function GetValue(var typ:string; name_, PktStr: string; var PosInPkt: integer): string;
    function GetNpcID(const ar1 : cardinal) : string;
    procedure ParsePacket(PacketName, Packet:string; size : word = 0);
    procedure addtoHex(Str:string);
    procedure selectitemwithtag (Itemtag:integer);
    function get(param1:string;id: byte; var value:string):boolean;

    { Public declarations }
  end;

implementation

uses umain;

{$R *.dfm}
  var
    cID: Byte;
    wSubID, wSize, wSub2ID : word;
    blockmask, PktStr, StrIni, Param0: String;
    oldpos, ii, PosInIni, PosInPkt, offset: Integer;
    ptime: TDateTime;
    isshow: Boolean;
    FuncNames, FuncParamNames, FuncParamTypes, FuncParamNumbers: TStringList;
    value, tmp_value, typ, name_, func, tmp_param, param1, param2,
    tmp_param1, tmp_param2, tmp_param12: String;

procedure TfPacketView.addtoHex(Str: string);
begin
  inc(itemTag);
  rvHEX.AddNLTag(copy(str,1,length(str)-1),templateindex,-1,itemTag);
  rvHEX.AddNL(' ', 0, -1);
end;

function TfPacketView.GetNpcID(const ar1: cardinal): string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.NpcID - возвращает текст по его ID из значения аргумента
var
 _ar1: cardinal;
begin
  _ar1:=ar1-kNpcID;
  result:='0'; if ar1=0 then exit;
  result:=NpcIdList.Values[inttostr(_ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown Npc ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;

function TfPacketView.GetValue(var typ:string; name_, PktStr: string; var PosInPkt: integer): string;
var
  value: string;
  d:integer;
  pch: WideString;
begin
  templateindex := 0;
  hexvalue:='';
  case typ[1] of
    'd':
    begin
      value:=IntToStr(PInteger(@PktStr[PosInPkt])^);
      hexvalue:=' (0x'+inttohex(Strtoint(value),8)+')';
      templateindex := 10;
      Inc(PosInPkt,4);
    end;  //integer (размер 4 байта)           d, h-hex
    'c':
    begin
      value:=IntToStr(PByte(@PktStr[PosInPkt])^);
      hexvalue:=' (0x'+inttohex(Strtoint(value),2)+')';
      templateindex := 11;
      Inc(PosInPkt);
    end;  //byte / char (размер 1 байт)        b
    'f':
    begin
      value:=FloatToStr(PDouble(@PktStr[PosInPkt])^);
      templateindex := 12;
      Inc(PosInPkt,8);
    end;  //double (размер 8 байт, float)      f
    'n':
    begin
      value:=FloatToStr(PSingle(@PktStr[PosInPkt])^);
      templateindex := 12;
      Inc(PosInPkt,4);
    end;  //Single (размер 4 байт, float)      n
    'h':
    begin
      value:=IntToStr(PWord(@PktStr[PosInPkt])^);
      hexvalue:=' (0x'+inttohex(Strtoint(value),4)+')';
      templateindex := 13;
      Inc(PosInPkt,2);
    end;  //word (размер 2 байта)              w
    'q':
    begin
      value:=IntToStr(PInt64(@PktStr[PosInPkt])^);
      templateindex := 14;
      Inc(PosInPkt,8);
    end;  //int64 (размер 8 байта)
    '-','z':
    begin
      templateindex := 15;
      if Length(name_)>4 then
      begin
        if name_[1]<>'S' then
        begin
          d:=strtoint(copy(name_,1,4));
          Inc(PosInPkt,d);
          value:=lang.GetTextOrDefault('skip' (* 'Пропускаем ' *) )+inttostr(d)+lang.GetTextOrDefault('byte' (* ' байт(а)' *) );
        end else
          value:=lang.GetTextOrDefault('skip script' (* 'Пропускаем скрипт' *) );
      end else
      begin
        d:=strtoint(name_);
        Inc(PosInPkt,d);
        value:=lang.GetTextOrDefault('skip' (* 'Пропускаем ' *) )+inttostr(d)+lang.GetTextOrDefault('byte' (* ' байт(а)' *) );
      end;
    end;
    's':begin
      templateindex := 16;
      d := PosEx(#0#0, PktStr ,PosInPkt)-PosInPkt;
      if (d mod 2)=1 then Inc(d);
      SetLength(pch, d div 2);
      if d>=2 then Move(PktStr[PosInPkt],pch[1],d) else d:=0;
      value:=pch; //преобразует автоматом

     Inc(PosInPkt,d+2);
    end;
    '_':begin //(подчерк) ничего не делаем, нужен для switch
      templateindex := 17;
      value:='0';
    end;
    else value:= lang.GetTextOrDefault('unknownid' (* 'Неизвестный идентификатор -> ?(name_)!' *) );
  end;
  Result:=value;
  if PosInPkt>wSize+10 then
    result:='range error';
end;

{ TfPacketView }
//-------------
function TfPacketView.GetType(const s:string; var i: Integer):string;
begin
  Result:='';
  while (s[i]<>')')and(i<Length(s)) do begin
    Result:=Result+s[i];
    Inc(i);
  end;
  Result:=Result+s[i];
end;
//-------------
function TfPacketView.GetTyp(s:string):string;
begin
  //d(Count:For.0001)
  //d(Count:Get.Func01)
  //-(40)
  Result:=s[1];
end;
function TfPacketView.GetName(s:string):string;
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
function TfPacketView.GetFunc(s:string):string;
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
function TfPacketView.GetParam(s:string):string;
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
function TfPacketView.GetParam2(s:string):string;
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
//для совместимости с WPF 669f
function TfPacketView.GetF0(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.F0 - возвращает название Item'а по его ID из значения аргумента
begin
  result:=GetFunc01(ar1);
end;
function TfPacketView.GetF3(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.F3 - возвращает название рецепта по его ID из значения аргумента
begin
  result:=GetFunc01(ar1);
end;
//-------------
function TfPacketView.GetFunc01(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.Func01 - возвращает название Item'а по его ID из значения аргумента
begin
  result:='0'; if ar1=0 then exit;
  result:=ItemsList.Values[IntTostr(ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown Items ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;
//AION -------------
function TfPacketView.GetFunc01Aion(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.Func01A - возвращает название Item'а по его ID из значения аргумента
begin
  result:='0'; if ar1=0 then exit;
  result:=ItemsListAion.Values[IntTostr(ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown Items ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;
//-------------
function TfPacketView.GetFuncStrAion(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.StringA - возвращает строку по его ID из значения аргумента
begin
  result:='0'; if ar1=0 then exit;
  result:=ClientStringsAion.Values[IntTostr(ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown msgID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;
//для совместимости с WPF 669f
function TfPacketView.GetFSay2(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.FSay2 - возвращает тип Say2
begin
  result:=GetFunc02(ar1);
end;

function TfPacketView.GetFunc02(const ar1 : integer) : string;
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
    11: result := 'BOAT (WILLCRASHCLIENT?)';
    12: result := 'L2FRIEND';
    13: result := 'MSNCHAT';
    14: result := 'PARTYMATCH_ROOM';
    15: result := 'PARTYROOM_COMMANDER (yellow)';
    16: result := 'PARTYROOM_ALL (red)';
    17: result := 'HERO_VOICE';
    18: result := 'CRITICAL_ANNOUNCE';
    19: result := 'SCREEN_ANNOUNCE';
    20: result := 'BATTLEFIELD';
    21: result := 'MPCC_ROOM';
    else result := '?';
  end;
  result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')';
end;
//-------------
function TfPacketView.GetF9(ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.F9 - SocialAction
begin
  result := '';
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
    $0E: result := 'Charm';
    $0F: result := 'Shyness';
    $10: result := 'Hero light';
    $084A: result := 'LVL-UP';
    else result := '?';
  end;
  result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')';
end;
//-------------
function TfPacketView.GetFunc09(id: byte; ar1 : integer) : string;
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
      $0E: result := 'Charm';
      $0F: result := 'Shyness';
      $10: result := 'Hero light';
      $084A: result := 'LVL-UP';
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
function TfPacketView.GetSkill(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.Skill - возвращает название скила по его ID из значения аргумента
begin
  result:='0'; if ar1=0 then exit;
  result:=SkillList.Values[inttostr(ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown Skill ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;
//AION -------------
function TfPacketView.GetSkillAion(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.SkillA - возвращает название скила по его ID из значения аргумента
begin
  result:='0'; if ar1=0 then exit;
  result:=SkillListAion.Values[inttostr(ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown Skill ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;
//для совместимости с WPF 669f
function TfPacketView.GetF1(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.F1 - возвращает название скила по его ID из значения аргумента
begin
  result:=GetAugment(ar1);
end;
//-------------
function TfPacketView.GetAugment(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.AugmentID - возвращает название скила по его ID из значения аргумента
begin
  result:='0'; if ar1=0 then exit;
  result := AugmentList.Values[inttostr(ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown Augment ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;
//-------------
function TfPacketView.GetMsgID(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.MsgID - возвращает текст по его ID из значения аргумента
begin
  result:='0'; if ar1=0 then exit;
  result:=SysMsgidList.Values[inttostr(ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown SysMsg ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;
//AION -------------
function TfPacketView.GetMsgIDA(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.MsgIDA - возвращает текст по его ID из значения аргумента
begin
  result:='0'; if ar1=0 then exit;
  result:=SysMsgidListAion.Values[inttostr(ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown SysMsg ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;
//-------------
function TfPacketView.GetClassID(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.ClassID - профа
begin
  result:=ClassIdList.Values[inttostr(ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown Class ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;
//AION -------------
function TfPacketView.GetClassIDAion(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.ClassIDA - профа
begin
  result:=ClassIdListAion.Values[inttostr(ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown Class ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;
//-------------
function TfPacketView.GetFSup(const ar1 : integer) : string;
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

function TfPacketView.prnoffset(offset:integer):string;
begin
  result:=inttostr(offset);
  case Length(result) of
    1: result:='000'+result;
    2: result:='00'+result;
    3: result:='0'+result;
  end;
end;
//проверка на то, что строка только из символов
function TfPacketView.AllowedName(Name:string):boolean;
var
i:integer;
begin
  result := true;
  i := 1;
  while i <= length(Name) do
  begin
    if not (lowercase(Name[i])[1] in ['a'..'z']) then
      begin
        result := false;
        exit;
      end;
    inc(i);
  end;
end;
//=======================================================================
// извлекаю локальные функции
//=======================================================================
//  procedure addToDescr(offset:integer; typ, name_, value:string);
//  procedure PrintFuncsParams(sFuncName:string);
//  procedure fGet();
//  procedure fFor();
//  procedure fLoop();
//  procedure fParse();
//  procedure fSwitch();
//=======================================================================
procedure TfPacketView.addToDescr(offset :integer; typ, name_, value :string);
var
  another :string;
begin
  another := ' ' + typ + ' ';
  if HexViewOffset
    then
      rvDescryption.AddNLTag(inttohex(offset, 4)+another, templateindex, 0, itemTag)
    else
      rvDescryption.AddNLTag(prnoffset(offset)+another, templateindex, 0, itemTag);

  rvDescryption.GetItem(rvDescryption.ItemCount-1).Tag := itemTag;
  rvDescryption.AddNL(' ', 0, -1);
  rvDescryption.AddNL(name_, 1, -1);
  rvDescryption.AddNL(': ', 0, -1);
  rvDescryption.AddNL(value, 0, -1);
end;
//=======================================================================
function TfPacketView.GetFuncParams(FuncParamNames, FuncParamTypes :TStringList) :string;
var
  i :integer;
begin
  result := '';
  i := 0;
  while i < funcparamnames.Count do
  begin
    if (i < funcparamnames.Count - 1) and (FuncParamTypes.Strings[i] = FuncParamTypes.Strings[i+1]) then
      result := format('%s%s, ',[result, FuncParamNames.Strings[i]])
    else
    begin
    case FuncParamTypes.Strings[i][1] of
      'd':
          begin
            result := format('%s%s:%s',[result, FuncParamNames.Strings[i],'Integer']);
          end;  //dword (размер 4 байта)           d, h-hex
      'c':
          begin
            result := format('%s%s:%s',[result, FuncParamNames.Strings[i],'Byte']);
          end;  //byte / char (размер 1 байт)        b
      'f':
          begin
            result := format('%s%s:%s',[result, FuncParamNames.Strings[i],'Real']);
          end;  //double (размер 8 байт, float)      f
      'h':
          begin
            result := format('%s%s:%s',[result, FuncParamNames.Strings[i],'Word']);
          end;  //word (размер 2 байта)              w
      'q':
          begin
            result := format('%s%s:%s',[result, FuncParamNames.Strings[i],'Int64']);
          end;  //int64 (размер 8 байта)
      's':begin
            result := format('%s%s:%s',[result, FuncParamNames.Strings[i],'String']);
          end;
    end;
    if i < funcparamnames.Count-1 then
      result := result + '; ';
    end;
    inc(i);
  end;
end;
//=======================================================================
procedure TfPacketView.PrintFuncsParams(sFuncName :string);
var
  i :integer;
  values :string;
begin
  if FuncNames.IndexOf(sFuncName) < 0 then
  begin
    i := 0;
    values := '';
    while i < FuncParamNumbers.count do
    begin
      if (i < FuncParamNumbers.Count - 1) then
        values := format('%sValues[%s], ', [values, FuncParamNumbers.Strings[i]])
      else
        values := format('%sValues[%s]', [values, FuncParamNumbers.Strings[i]]);

      inc(i);
    end;
    rvFuncs.AddNL(format('Declaration : %s(%s);', [sFuncName, GetFuncParams(FuncParamNames, FuncParamTypes)]), 0, 0);
    rvFuncs.AddNL(format('Calling : %s(%s);', [sFuncName, values]), 0, 0);

    FuncNames.Add(sFuncName);
    rvFuncs.AddNL('Mask : ', 0, 0);
    rvFuncs.AddNL(blockmask, 0, -1);
    rvFuncs.AddNL('', 0, 0);
    blockmask := '';
  end;
  FuncParamNumbers.clear;
  FuncParamNames.Clear;
  FuncParamTypes.Clear;
end;
//=======================================================================
  procedure TfPacketView.fParse();
  begin
      //считали строку вида typ(name_:func.param1.param2)
      Param0:=GetType (StrIni, PosInIni);
      inc(PosInIni); //сместились на следующее значение
      typ:=GetTyp(Param0); //считываем тип значения
      name_:=GetName(Param0); //считываем имя значения в скобках typ(name_:func.param1.param2)
      func:=uppercase(GetFunc(Param0)); //считываем имя функции в скобках typ(name_:func.param1.param2)
      param1:=uppercase(GetParam(Param0)); //считываем имя значения в скобках typ(name_:func.param1.param2)
      param2:=GetParam2(Param0); //считываем имя значения в скобках typ(name_:func.param1.param2)
      offset:=PosinPkt-11;
      oldpos := PosInPkt;
      //где то тут проверять
      // if (PosInIni<Length(StrIni))and(PosInPkt<sizze+10)

      //считываем значение из пакета, сдвигаем указатели в соответствии с типом значения
      value:=GetValue(typ, name_, PktStr, PosInPkt);
      //игнорируем подчерк
      if typ<>'_' then
      begin
        if AllowedName(name_) then
        begin
          FuncParamNames.Add(name_);
          FuncParamTypes.Add(typ);
          FuncParamNumbers.Add(inttostr(length(blockmask)));
        end;
        blockmask := blockmask + typ;
      end;
      if PosInPkt - oldpos > 0 then
        addtoHex(StringToHex(copy(pktstr, oldpos, PosInPkt - oldpos),' '));
  end;
//=======================================================================
  procedure TfPacketView.fGet();
  begin
    if not get(param1, cID, value) then
      exit
    else
      addToDescr(offset, typ, name_, value);        //распечатываем
  end;
//=======================================================================
//Оператор выбора switch в java имеет следующий вид:
//Код:
//switch (выражение) { case
//значение1:
//// последовательность операторов
//break;
//case значение2:
//// последовательность операторов
//break;
//...
//case значениеN:
//// последовательность операторов
//break;
//default:
//// последовательность операторов, выполняемая по умолчанию
//У нас оператор выбора выглядит так, пример:
//Код:
//17=SM_MESSAGE:h(id2)c(chatType:switch.0002.0003)c(RaceId)d(ObjectId)_(id:case.0.2)h(unk)s(message)_(id:case.1.3)h(unk)d(unk)s(message)_(id:case.2.4)h(unk)d(unk)d(unk)s(message)s(Name)s(message)
//Код:
//здесь в куске c(chatType:switch.0002.0003)
//chatType  - выражение, тип чата (1 байт)
// switch  - ключевое слово оператора выбора
//0002 - сколько элементов после switch пропускать, т.е. элементы c(RaceId)d(ObjectId) просто выводятся в расшифровке на экран
//0003 - сколько элементов _(id:case присутствует в switch
//
//в куске _(id:case.0000.0002)h(unk)s(message)
//_ - пропускается
//id - пропускается, сюда можно вписать имя идентификатора
//case - ключевое слово для элемента выбора со значением 0000
//0002 – количество элементов в блоке case, т.е. элементы h(unk)s(message)
//Последние элементы s(Name)s(message) попадают под выбор default, т.е. если chatType не соответствует ни одному case, то в расшифровку попадают элементы s(Name)s(message).
//Не значащие нули везде можно опускать, т.е. вместо 0001 пишем 1.
//=======================================================================
  procedure TfPacketView.fSwitch();
  var
    i, j :integer;
    end_block :string;
  begin
      //распечатываем
      addToDescr(offset, typ, name_, value+hexvalue);
      tmp_param1:=param1;
      tmp_param2:=param2;
      tmp_value:=value;
      end_block:=value;
      if value = 'range error' then exit;
      //проверка, что param1 > 0
      if strtoint(param1)>0 then
      begin
        //распечатываем значения всех пропускаемых блоков
        for i:=1 to StrToInt(tmp_param1) do
        begin
          fParse();
          if Func='LOOPM' then  fLoopM()
          else
          if Func='LOOP' then  fLoop()
          else
          if Func='FOR' then  fFor()
          else
          if Func='SWITCH' then  fSwitch()
          else
          if Func='GET' then  fGet() //get(param1, id, value);
          //распечатываем
          else addToDescr(offset, typ, name_, value+hexvalue);
        end;
      end;
      for i:=1 to StrToInt(tmp_param2) do  //пробегаем по всем case
      begin
          fParse();
          tmp_param12:=param2;
          if Func='CASE' then
          begin
            if tmp_value=param1 then  //id совпало
            begin
              //распечатываем значения
              for j:=1 to StrToInt(tmp_param12) do
              begin
                fParse();
                if Func='LOOPM' then  fLoopM()
                else
                if Func='LOOP' then  fLoop()
                else
                if Func='FOR' then  fFor()
                else
                if Func='SWITCH' then  fSwitch()
                else
                if Func='GET' then  fGet() //get(param1, id, value);
                //распечатываем
                else addToDescr(offset, typ, name_, value+hexvalue);
              end;
            end else
              //пропускаем значения
              for j:=1 to StrToInt(tmp_param12) do
              begin
                Param0:=GetType(StrIni, PosInIni);
                inc(PosInIni);
              end;
          end;
      end;
  end;
//=======================================================================
  procedure TfPacketView.fLoop();
  var
    i, j, val :integer;
    end_block :string;
  begin
      //распечатываем
      addToDescr(offset, typ, name_, value+hexvalue);
      tmp_param:=param2;
      tmp_value:=value;
      //end_block:=value;
      if value='range error' then exit;
      if StrToInt(value)=0 then
      begin
        //пропускаем данные входящие в Loop
        for i:=1 to StrToInt(param2) do
        begin
          Param0:=GetType(StrIni, PosInIni);
          inc(PosInIni);
        end;
      end else
      begin
        //проверка, что param1 > 1
        if strtoint(param1)>1 then
        begin
          //распечатываем значения
          for i:=1 to StrToInt(param1)-1 do
          begin
            fParse();
            if Func='GET' then  fGet() //get(param1, id, value);
            //распечатываем
            else addToDescr(offset, typ, name_, value+hexvalue);
          end;
        end;
        ii:=PosInIni;
        if tmp_value = 'range error' then exit;
        //PrintFuncsParams('Pck'+PacketName);
        if StrToInt(tmp_value)>32767
        then val:=(StrToInt(tmp_value) XOR $FFFF)+1
        else val:=StrToInt(tmp_value);
        end_block:=inttostr(val);
//        for i:=1 to StrToInt(tmp_value) do
        for i:=1 to val do
        begin
          rvDescryption.AddNL('              '+lang.GetTextOrDefault('startb' (* '[Начало повторяющегося блока ' *) ), 0, 0);
          rvDescryption.AddNL(inttostr(i)+'/'+end_block, 1, -1);
          rvDescryption.AddNL(']', 0, -1);
          PosInIni:=ii;
          for j:=1 to StrToInt(tmp_param) do
          begin
            fParse();
            //здесь может быть SWITCH
            if Func='LOOPM' then  fLoopM()
            else
            if Func='LOOP' then  fLoop()
            else
            if Func='FOR' then  fFor()
            else
            if Func='SWITCH' then  fSwitch()
            else
            if Func='GET' then  fGet() //get(param1, id, value);
            //распечатываем
            else addToDescr(offset, typ, name_, value+hexvalue);
          end;
          //if value = 'range error' then break;
          rvDescryption.AddNL('              '+lang.GetTextOrDefault('endb' (* '[Конец повторяющегося блока ' *) ), 0, 0);
          rvDescryption.AddNL(inttostr(i)+'/'+end_block, 1, -1);
          rvDescryption.AddNL(']', 0, -1);
          //PrintFuncsParams('Item'+PacketName);
        end;
      end;
  end;
//=======================================================================
//цикл Loop для Айон с параметром в виде маски
  procedure TfPacketView.fLoopM();
  var
    i, j, val, k :integer;
    end_block :string;
  begin
      //распечатываем
      addToDescr(offset, typ, name_, value+hexvalue);
      tmp_param:=param2;
      tmp_value:=value;
      //end_block:=value;
      if value='range error' then exit;
      if StrToInt(value)=0 then
      begin
        //пропускаем данные входящие в Loop
        for i:=1 to StrToInt(param2) do
        begin
          Param0:=GetType(StrIni, PosInIni);
          inc(PosInIni);
        end;
      end else
      begin
        //проверка, что param1 > 1
        if strtoint(param1)>1 then
        begin
          //распечатываем значения
          for i:=1 to StrToInt(param1)-1 do
          begin
            fParse();
            if Func='GET' then  fGet() //get(param1, id, value);
            //распечатываем
            else addToDescr(offset, typ, name_, value+hexvalue);
          end;
        end;
        ii:=PosInIni;
        if tmp_value = 'range error' then exit;
        //преобразуем параметр Маска в число
        k:=StrToInt(tmp_value); // EquipmentMask
        val:=0;
        for i:=0 to 15 do val:=val+((k shr i)and 1);
        end_block:=inttostr(val);
        for i:=1 to val do
        begin
          rvDescryption.AddNL('              '+lang.GetTextOrDefault('startb' (* '[Начало повторяющегося блока ' *) ), 0, 0);
          rvDescryption.AddNL(inttostr(i)+'/'+end_block, 1, -1);
          rvDescryption.AddNL(']', 0, -1);
          PosInIni:=ii;
          for j:=1 to StrToInt(tmp_param) do
          begin
            fParse();
            if Func='LOOPM' then  fLoopM()
            else
            if Func='LOOP' then  fLoop()
            else
            if Func='FOR' then  fFor()
            else
            if Func='SWITCH' then  fSwitch()
            else
            if Func='GET' then  fGet() //get(param1, id, value);
            //распечатываем
            else addToDescr(offset, typ, name_, value+hexvalue);
          end;
          //if value = 'range error' then break;
          rvDescryption.AddNL('              '+lang.GetTextOrDefault('endb' (* '[Конец повторяющегося блока ' *) ), 0, 0);
          rvDescryption.AddNL(inttostr(i)+'/'+end_block, 1, -1);
          rvDescryption.AddNL(']', 0, -1);
          //PrintFuncsParams('Item'+PacketName);
        end;
      end;
  end;
//=======================================================================
  procedure TfPacketView.fFor();
  var
    i, j :integer;
  begin
      //распечатываем
      addToDescr(offset, typ, name_, value+hexvalue);
      tmp_param:=param1;
      tmp_value:=value;
      ii:=PosInIni;
      if value='range error' then exit;
      if StrToInt(value)=0 then
      begin
        //пропускаем пустые значения
        for i:=1 to StrToInt(param1) do
        begin
      //где то тут проверять
      // if (PosInIni<Length(StrIni))and(PosInPkt<sizze+10)

          Param0:=GetType(StrIni, PosInIni);
          inc(PosInIni);
        end;
      end else begin
        //rvDescryption.AddNL('Mask : ', 0, 0);
        //rvDescryption.AddNL(blockmask, 4, -1);
        //blockmask := '';
        for i:=1 to StrToInt(tmp_value) do
        begin
          rvDescryption.AddNL('              '+lang.GetTextOrDefault('startb' (* '[Начало повторяющегося блока ' *) ), 0, 0);
          rvDescryption.AddNL(inttostr(i)+'/'+tmp_value, 1, -1);
          rvDescryption.AddNL(']', 0, -1);
          PosInIni:=ii;
          for j:=1 to StrToInt(tmp_param) do
          begin
            fParse();
            //здесь может быть SWITCH
            if Func='LOOP' then  fLoop()
            else
            if Func='FOR' then  fFor()
            else
            if Func='SWITCH' then  fSwitch()
            else
            if Func='GET' then  fGet() //get(param1, id, value);
            //распечатываем
            else addToDescr(offset, typ, name_, value+hexvalue);
          end;
          rvDescryption.AddNL('              '+lang.GetTextOrDefault('endb' (* '[Конец повторяющегося блока ' *) ), 0, 0);
          rvDescryption.AddNL(inttostr(i)+'/'+tmp_value, 1, -1);
          rvDescryption.AddNL(']', 0, -1);
        end;
      end;
  end;
//=======================================================================
procedure TfPacketView.ParsePacket(PacketName, Packet: string; size: word = 0);
begin
  FuncParamNames := TStringList.Create;
  FuncParamTypes := TStringList.Create;
  FuncParamNumbers := TStringList.Create;
  FuncNames := TStringList.Create;
  //HexViewOffset := GlobalSettings.HexViewOffset;
  try
    //строка пакета, sid - номер пакета, cid - номер соединения
    PktStr := HexToString(packet);
    if Length(PktStr)<12 then Exit;
    Move(PktStr[2],ptime,8);
    if size = 0 then
      Size:=Word(Byte(PktStr[11]) shl 8 + Byte(PktStr[10]))
    else
      ptime := now;
    //делаем видимой во внешних функциях
    wSize:=size;
    if (GlobalProtocolVersion=AION)then // для Айон 2.1 - 2.6
    begin
      cID:=Byte(PktStr[12]); //фактическое начало пакета, ID
      wSubID:=0;   //не требуется
      wSub2ID:=0;   //не требуется
    end
    else
    if (GlobalProtocolVersion=AION27)then // для Айон 2.7 двухбайтные ID
    begin
      cID:=Byte(PktStr[12]);                    //в cID - ID пакета при однобайтном ID
      wSubID:=Word(Byte(PktStr[13]) shl 8 + cID); //в wSubId - ID пакета при двухбайтном ID
      wSub2ID:=0;   //не требуется
    end
    else //для Lineage II
    begin
      if wSize=3 then
      begin
        cID:=Byte(PktStr[12]); //фактическое начало пакета, ID
        wSubID:=0;    //пакет закончился, пишем в subid 0
        wSub2ID:=0;   //не требуется
      end
      else
      begin
        if PktStr[1]=#04 then
        begin      //client  04,
          cID:=Byte(PktStr[13]); //учитываем трех байтное ID в wSub2ID
          wSub2ID:=Word(cID shl 8+Byte(PktStr[14]));
          cID:=Byte(PktStr[12]); //фактическое начало пакета, ID
          wSubID:=Word(cID shl 8+Byte(PktStr[13])); //учитываем двух байтное ID в wSubID
        end
        else  //сервер  03, учитываем двух и четырех байтное ID
        begin
          cID:=Byte(PktStr[12]); //фактическое начало пакета, ID
          if wSize=3 then
          begin
              wSubID:=0;    //пакет закончился, пишем в subid 0
              wSub2ID:=0;    //пакет закончился, пишем в subid 0
          end
          else
          begin
            cID:=Byte(PktStr[14]); //фактическое начало SUB2ID
            wSub2ID:=Word(cID shl 8+Byte(PktStr[15])); //считываем Sub2Id
            cID:=Byte(PktStr[12]);                   //фактическое начало пакета, ID
            wSubID:=Word(cID shl 8+Byte(PktStr[13])); //считываем SubId
          end;
        end;
      end;
    end;

    currentpacket := StringToHex(copy(PktStr, 12, length(PktStr)-11),' ');

    rvHEX.Clear;
    rvDescryption.Clear;
    rvFuncs.Clear;

    if PacketName = '' then
      GetPacketName(cID, wSubID, wSub2ID, (PktStr[1]=#03), PacketName, isshow);
    //считываем строку из packets.ini для парсинга
    if PktStr[1]=#04 then
    begin
      //client  04
      if (GlobalProtocolVersion=AION)then // для Айон 2.1 - 2.6
      begin
        StrIni:=PacketsINI.ReadString('client', IntToHex(cID, 2), 'Unknown:');
      end
      else
      begin
        if (GlobalProtocolVersion=AION27)then // для Айон 2.7 двухбайтные ID
        begin
          //0081=cm_time_check:c(static)h(id2)d(nanoTime)
          //32=cm_group_response:h(id2)d(unk1)c(unk2)
          StrIni:=PacketsINI.ReadString('client', IntToHex(wSubId, 4), 'Unknown:');
          //если не нашли двухбайтное ID, значит у нас ID однобайтное
          if (StrIni = 'Unknown:') then
          begin
            StrIni:=PacketsINI.ReadString('client', IntToHex(cID, 2), 'Unknown:');   //если и такого не нашли, то имя пакета - Unknown:
            wSubId:=0;   //сигнал, что однобайтное ID
          end;
        end
        else
        begin
          if (GlobalProtocolVersion<GRACIA) then
          begin
            //фиксим пакет 39 для хроник C4-C5-Interlude
            if (cID in [$39, $D0]) and (wSize>3) then
              //C4, C5, T0
              StrIni:=PacketsINI.ReadString('client', IntToHex(wSubID, 4), 'Unknown:h(subID)')
            else
              StrIni:=PacketsINI.ReadString('client', IntToHex(cID, 2), 'Unknown:');
          end
          else
          begin
            //для хроник Kamael - Hellbound - Gracia - Freya
           //client three ID packets: c(ID)h(sub2ID)
           if (cID=$D0) and (((wsub2id>=$5100) and (wsub2id<=$5105)) or (wsub2id=$5A00)) and (wSize>3) then
              StrIni:=PacketsINI.ReadString('server', IntToHex(cID, 2)+IntToHex(wSub2ID, 4), 'Unknown:c(ID)h(subID)')
            else
            begin
              if (cID=$D0) and (wSize>3) then
                StrIni:=PacketsINI.ReadString('client',IntToHex(wSubID, 4), 'Unknown:h(subID)')
              else
                StrIni:=PacketsINI.ReadString('client', IntToHex(cID, 2), 'Unknown:');
            end;
          end;
        end;
      end;
    end
    else
    begin
      //server  03
      if (GlobalProtocolVersion=AION)then // для Айон 2.1 - 2.6
      begin
        StrIni:=PacketsINI.ReadString('server', IntToHex(cID, 2), 'Unknown:');
      end
      else
      begin
        if (GlobalProtocolVersion=AION27)then // для Айон 2.7 двухбайтные ID
        begin
          //0081=cm_time_check:c(static)h(id2)d(nanoTime)
          //32=cm_group_response:h(id2)d(unk1)c(unk2)
          StrIni:=PacketsINI.ReadString('server', IntToHex(wSubId, 4), 'Unknown:');
          //если не нашли двухбайтное ID, значит у нас ID однобайтное
          if (StrIni = 'Unknown:') then
          begin
            StrIni:=PacketsINI.ReadString('server', IntToHex(cID, 2), 'Unknown:');   //если и такого не нашли, то имя пакета - Unknown:
            wSubId:=0;   //сигнал, что однобайтное ID
          end;
        end
        else
        begin
          //server four ID packets: c(ID)h(subID)h(sub2ID)
          if ((wsubid=$FE97) or (wsubid=$FE98) or (wsubid=$FEB7)) and (wSize>3) then
              StrIni:=PacketsINI.ReadString('server', IntToHex(wSubID, 4)+IntToHex(wSub2ID, 4), 'Unknown:h(subID)h(sub2ID)')
          else
          begin
            if (cID=$FE) and (wSize>3) then
              StrIni:=PacketsINI.ReadString('server', IntToHex(wSubID, 4), 'Unknown:h(subID)')
            else
              StrIni:=PacketsINI.ReadString('server', IntToHex(cID, 2), 'Unknown:');
          end;
        end;
      end;
    end;

    if ((GlobalProtocolVersion=AION27) and (wSubId<>0))then // для Айон 2.7 двухбайтные ID
      Label1.Caption:=lang.GetTextOrDefault('IDS_109' (* 'Выделенный пакет: тип - 0x' *) )+IntToHex(wSubId, 4)+', '+PacketName+lang.GetTextOrDefault('size' (* ', размер - ' *) )+IntToStr(wSize)
    else
      Label1.Caption:=lang.GetTextOrDefault('IDS_109' (* 'Выделенный пакет: тип - 0x' *) )+IntToHex(cID, 2)+', '+PacketName+lang.GetTextOrDefault('size' (* ', размер - ' *) )+IntToStr(wSize);
    //начинаем разбирать пакет по заданному в packets.ini формату
    //смещение в ini
    PosInIni:=Pos(':',StrIni);
    //смещение в pkt
    PosInPkt:=13;
    Inc(PosInIni);
    //Добавляем тип
    rvDescryption.AddNL(lang.GetTextOrDefault('IDS_121' (* 'Tип: ' *) ), 11, 0);
    if ((GlobalProtocolVersion=AION27) and (wSubId<>0))then // для Айон 2.7 двухбайтные ID
      rvDescryption.AddNLTag('0x'+IntToHex(wSubId, 4), 0, -1, 1)
    else
      rvDescryption.AddNLTag('0x'+IntToHex(cID, 2), 0, -1, 1);
    rvDescryption.AddNL(' (', 0, -1);
    rvDescryption.AddNL(PacketName, 1, -1);
    rvDescryption.AddNL(')', 0, -1);
    //добавляем размер и время
    rvDescryption.AddNL(lang.GetTextOrDefault('size2' (* 'Pазмер: ' *) ), 0, 0);
    rvDescryption.AddNL(IntToStr(wSize-2), 1, -1);
    rvDescryption.AddNL('+2', 2, -1);

    rvDescryption.AddNL(lang.GetTextOrDefault('IDS_126' (* 'Время прихода: ' *) ), 0, 0);
    rvDescryption.AddNL(FormatDateTime('hh:nn:ss:zzz',ptime), 1, -1);

    itemTag := 0;
    templateindex := 11;

    if ((GlobalProtocolVersion=AION27) and (wSubId<>0))then // для Айон 2.7 двухбайтные ID
    begin
      addtoHex(StringToHex(copy(pktstr, 12, 2),' '));
      inc(PosInPkt);
    end
    else
      addtoHex(StringToHex(copy(pktstr, 12, 1),' '));

    itemTag := 1;

    //GetType - возвращает строчку типа d(Count:For.0001) из packets.ini
    //StrIni - строчка из packets.ini по ID из пакета
    //PktStr - пакет
    //Param0 - строка d(Count:For.0001)
    //PosInIni - смещение в строчке из packets.ini по ID из пакета
    //PosInPkt - смещение в пакете
    try
      blockmask := '';
      while (PosInIni>1)and(PosInIni<Length(StrIni))and(PosInPkt<wSize+10) do
      begin
        fParse();
        if Func='GET' then fGet()
        else
        //для С4, С5 и Т0-Интерлюдия
        if Func='FOR' then fFor()
        else
        //для Т1 - Камаель-Хелбаунд-Грация
        (*в функции LOOP первый параметр может быть больше 1,
        значит его просто выводим, а остальное
        в цикле до параметр 2*)
        if (Func='LOOP') {and (StrToInt(value)>0)} then fLoop()
        else
        if (Func='LOOPM') {and (StrToInt(value)>0)} then fLoopM()
        else
        //========================================================================
        //для Грации, Фрейи и AION
        (*в функции SWITCH первый параметр может быть больше 0,
        значит описания просто выводим, а остальное
        в цикле до параметр 2*)
        //d(id:switch.skip.count)
        // _(id:case.param1.param2)
        //d(number)
        // _(id:case.param1.param2)
        //d(number)
        if Func='SWITCH' then fSwitch()
        else
          //распечатываем
          addToDescr(offset, typ, name_, value+hexvalue);
      end;
    except
      //ошибка при распознании пакета
    end;
    oldpos := PosInPkt;
    PosInPkt := wSize + 10;
    if PosInPkt - oldpos > 0 then
      addtoHex(StringToHex(copy(pktstr, oldpos, PosInPkt - oldpos),' '));

    if blockmask <> '' then
      PrintFuncsParams('Pck'+PacketName);

    rvHEX.FormatTail;
    rvFuncs.FormatTail;
    rvDescryption.FormatTail;
  finally
    FuncParamNames.Destroy;
    FuncParamTypes.Destroy;
    FuncParamNumbers.Destroy;
    FuncNames.Destroy;
  end;
end;

procedure TfPacketView.rvHEXMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  rvHEX.SetFocusSilent;
end;

procedure TfPacketView.rvDescryptionMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  rvDescryption.SetFocusSilent;
end;

procedure TfPacketView.rvDescryptionRVMouseUp(Sender: TCustomRichView;
  Button: TMouseButton; Shift: TShiftState; ItemNo, X, Y: Integer);
begin
if ItemNo >= 0 then
  selectitemwithtag(rvDescryption.GetItemTag(ItemNo));
end;

procedure TfPacketView.selectitemwithtag(Itemtag: integer);
var
  i:integer;
begin
  i := 0;
  while (i < rvhex.ItemCount) do
    begin
      if rvHEX.GetItemStyle(i) >= 20 then
        dec(rvHEX.GetItem(i).StyleNo,10);

      inc(i);
    end;

  i := 0;
  while (i < rvDescryption.ItemCount) do
    begin
      if rvDescryption.GetItemStyle(i) >= 20 then
        dec(rvDescryption.GetItem(i).StyleNo,10);

      inc(i);
    end;

  if Itemtag < 1 then exit;
  i := 0;
  while (i < rvHEX.ItemCount) and (rvHEX.GetItemTag(i)<>ItemTag) do inc(i);
  if i < rvHEX.ItemCount then
  begin
    Inc(rvHEX.GetItem(i).StyleNo,10);
    rvHEX.Format;
  end;

  i := 0;
  while (i < rvDescryption.ItemCount) and (rvDescryption.GetItemTag(i)<>ItemTag) do inc(i);
  if i < rvDescryption.ItemCount then
  begin
    Inc(rvDescryption.GetItem(i).StyleNo,10);
    rvDescryption.Format;
  end;

end;

procedure TfPacketView.rvHEXRVMouseUp(Sender: TCustomRichView;
  Button: TMouseButton; Shift: TShiftState; ItemNo, X, Y: Integer);
begin
if ItemNo >= 0 then
  selectitemwithtag(rvHEX.GetItemTag(ItemNo));
end;

procedure TfPacketView.rvHEXSelect(Sender: TObject);
begin
  if rvHEX.SelectionExists then begin
    rvHEX.CopyDef;
    rvHEX.Deselect;
    rvHEX.Invalidate;
    rvHEX.SetFocus;
  end;
end;

procedure TfPacketView.rvDescryptionSelect(Sender: TObject);
begin
  if rvDescryption.SelectionExists then begin
    rvDescryption.CopyDef;
    rvDescryption.Deselect;
    rvDescryption.Invalidate;
    rvDescryption.SetFocus;
  end;
end;

Function TfPacketView.get(param1: string; id: byte; var value: string):boolean;
begin
  result := false;
  if StrToIntDef(value, 0) <> StrToIntDef(value, 1) then exit;
  if param1='FUNC01' then    value:=GetFunc01(strtoint(value)) else
  if param1='FUNC01A' then   value:=GetFunc01Aion(strtoint(value)) else
  if param1='FUNC02' then    value:=GetFunc02(strtoint(value)) else
  if param1='FUNC09' then    value:=GetFunc09(id, strtoint(value)) else
  if param1='CLASSID' then   value:=GetClassID(strtoint(value)) else
  if param1='CLASSIDA' then  value:=GetClassIDAion(strtoint(value)) else
  if param1='FSUP' then      value:=GetFsup(strtoint(value)) else
  if param1='NPCID' then     value:=GetNpcID(strtoint(value)) else
  if param1='MSGID' then     value:=GetMsgID(strtoint(value)) else
  if param1='MSGIDA' then    value:=GetMsgIDA(strtoint(value)) else
  if param1='SKILL' then     value:=GetSkill(strtoint(value)) else
  if param1='SKILLA' then    value:=GetSkillAion(strtoint(value)) else
  if param1='STRINGA' then   value:=GetFuncStrAion(strtoint(value)) else
  if param1='F0' then        value:=GetF0(strtoint(value)) else
  if param1='F1' then        value:=GetF1(strtoint(value)) else
  if param1='F3' then        value:=GetF3(strtoint(value)) else
  if param1='F9' then        value:=GetF9(strtoint(value)) else
  if param1='FSAY2' then     value:=GetFSay2(strtoint(value)) else
  if param1='AUGMENTID' then value:=GetAugment(strtoint(value));
  result := true;
end;

procedure TfPacketView.N1Click(Sender: TObject);
begin
  N1.Checked := not N1.Checked;
  rvDescryption.WordWrap := N1.Checked;
  rvDescryption.Format;
end;

procedure TfPacketView.N2Click(Sender: TObject);
begin
  N2.Checked := not n2.Checked;
  rvFuncs.Visible := n2.Checked;
  Splitter2.Visible := N2.Checked;
  //Splitter2.Top := 1;
end;

procedure TfPacketView.rvFuncsSelect(Sender: TObject);
begin
  if rvFuncs.SelectionExists then
  begin
    rvFuncs.CopyDef;
    rvFuncs.Deselect;
    rvFuncs.Invalidate;
    rvFuncs.SetFocus;
  end;
end;

end.

