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
    rvDescryption: TRichView;
    lang: TsiLang;
    Label1: TLabel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    RVStyle1: TRVStyle;
    Splitter2: TSplitter;
    rvFuncs: TRichView;
    N2: TMenuItem;
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

  private
    { Private declarations }
  public
    currentpacket: string;
    kId: cardinal; //коэфф преобразования NpcID
    hexvalue: string; //для вывода HEX в расшифровке пакетов
    HexViewOffset : boolean;
    itemTag, templateindex:integer;
    function GetValue(var typ:string; name, PktStr: string; var PosInPkt: integer; size:word): string;
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
  _ar1:=ar1-kId;
  result:='0'; if ar1=0 then exit;
  result:=NpcIdList.Values[inttostr(_ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown Npc ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
end;


function TfPacketView.GetValue(var typ:string; name, PktStr: string;
  var PosInPkt: integer; size: word): string;
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
    {'i':
    begin
      value:=IntToStr(PInteger(@PktStr[PosInPkt])^);
      hexvalue:=' (0x'+inttohex(Strtoint(value),8)+')';
      templateindex := 17;
      Inc(PosInPkt,4);
    end;  //integer (размер 4 байта)           d, h-hex
    }
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
      if Length(name)>4 then
      begin
        if name[1]<>'S' then
        begin
          d:=strtoint(copy(name,1,4));
          Inc(PosInPkt,d);
          value:=lang.GetTextOrDefault('skip' (* 'Пропускаем ' *) )+inttostr(d)+lang.GetTextOrDefault('byte' (* ' байт(а)' *) );
        end else
          value:=lang.GetTextOrDefault('skip script' (* 'Пропускаем скрипт' *) );
      end else
      begin
        d:=strtoint(name);
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
    else value:= lang.GetTextOrDefault('unknownid' (* 'Неизвестный идентификатор -> ?(name)!' *) );
  end;
  Result:=value;
  if PosInPkt>Size+10 then
    result:='range error';
end;


{ TfPacketView }

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

function GetAugment(const ar1 : integer) : string;
// внешняя ф-ция, вызывается не из скрипта, а по аргументу
// :Get.AugmentID - возвращает название скила по его ID из значения аргумента
begin
  result:='0'; if ar1=0 then exit;
  result := AugmentList.Values[inttostr(ar1)];
  if length(result)>0 then result:=result+' ID:'+inttostr(ar1)+' (0x'+inttohex(ar1,4)+')' else result:='Unknown Augment ID:'+inttostr(ar1)+'('+inttohex(ar1,4)+')';
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


function AllowedName(Name:string):boolean;
var
i:integer;
begin
  result := true;
  i := 1;
  while i <= length(name) do
  begin
    if not (lowercase(Name[i])[1] in ['a'..'z']) then
      begin
        result := false;
        exit;
      end;
    inc(i);
  end;
end;

procedure TfPacketView.ParsePacket;
  procedure addToDescr(offset:integer; typ, name, value:string);
  function prnoffset(offset:integer):string;
  begin
    result:=inttostr(offset);
    case Length(result) of
      1: result:='000'+result;
      2: result:='00'+result;
      3: result:='0'+result;
    end;
  end;
  VAR
  another:string;

  begin
    another := ' ' + typ + ' ';
    if HexViewOffset
      then
        rvDescryption.AddNLTag(inttohex(offset,4)+another,templateindex, 0, itemTag)
      else
        rvDescryption.AddNLTag(prnoffset(offset)+another,templateindex, 0, itemTag);
    rvDescryption.GetItem(rvDescryption.ItemCount-1).Tag := itemTag;

    rvDescryption.AddNL(' ', 0, -1);
    rvDescryption.AddNL(name, 1, -1);
    rvDescryption.AddNL(': ', 0, -1);
    rvDescryption.AddNL(value, 0, -1);
  end;
var
  ii, j, jj: Integer;
  id: Byte;
  PktStr, StrIni, Param0: string;
  PosInIni, PosInPkt, offset: integer;
  ptime: TDateTime;
  SubID: word;
  typ, name,func, tmp_param, param1, param2: string;
  value, tmp_value: string;
  oldpos:integer;
  isshow:boolean;
  blockmask : string;
  FuncNames, FuncParamNames,FuncParamTypes, FuncParamNumbers:tstringlist;
    function GetFuncParams : string;
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
{        'i':
            begin
              result := format('%s%s:%s',[result, FuncParamNames.Strings[i],'Integer']);
            end;  //integer (размер 4 байта)           d, h-hex
            }
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
    FuncParamNames.Clear;
    FuncParamTypes.Clear;
    end;
    
    procedure PrintFuncsParams(sFuncName:string);
    var
    i:integer;
    values:string;
    begin
      if FuncNames.IndexOf(sFuncName) < 0 then
      begin
         i := 0;
         values := '';
         while i < FuncParamNumbers.count do
         begin
          if (i < FuncParamNumbers.Count - 1) then
            values := format('%sValues[%s], ',[values, FuncParamNumbers.Strings[i]])
          else
            values := format('%sValues[%s]',[values, FuncParamNumbers.Strings[i]]);

         inc(i);
         end;

        rvFuncs.AddNL(format('Declaration : %s(%s);',[sFuncName,GetFuncParams]),0,0);
        rvFuncs.AddNL(format('Calling : %s(%s);',[sFuncName,values]),0,0);

        FuncNames.Add(sFuncName);
        FuncParamNumbers.clear;
        rvFuncs.AddNL('Mask : ', 0, 0);
        rvFuncs.AddNL(blockmask, 0, -1);
        rvFuncs.AddNL('', 0, 0);
        
      end;
    end;
begin
    FuncParamNames := TStringList.Create;
    FuncParamTypes := TStringList.Create;
    FuncParamNumbers := TStringList.Create;
    FuncNames := TStringList.Create;
try
    //строка пакета, sid - номер пакета, cid - номер соединения
    PktStr := HexToString(packet);
    if Length(PktStr)<12 then Exit;
    Move(PktStr[2],ptime,8);
    if size = 0 then
      Size:=Word(Byte(PktStr[11]) shl 8)+Byte(PktStr[10])
    else
      ptime := now;

    id:=Byte(PktStr[12]);                   //фактическое начало пакета, ID
    SubId:=Word(id shl 8+Byte(PktStr[13])); //считываем SubId

    currentpacket := StringToHex(copy(PktStr, 12, length(PktStr)-11),' ');

    rvHEX.Clear;
    rvDescryption.Clear;
    rvFuncs.Clear;
    
    if PacketName = '' then
      GetPacketName(id, subid, (PktStr[1]=#03), PacketName, isshow);

    //считываем строку из packets.ini для парсинга
    if PktStr[1]=#04 then
    //client
      if (GlobalProtocolVersion>83) and (GlobalProtocolVersion<828) then
      //фиксим пакет 39 для Грация-Камаель
        if (ID in [$39,$D0]) and (size>3) then
        //C4, C5, T0
          StrIni:=PacketsINI.ReadString('client',IntToHex(subid,4),'Unknown:h(subID)')
        else
          StrIni:=PacketsINI.ReadString('client',IntToHex(id,2),'Unknown:')
      else
        if (ID=$D0) and (size>3) then
        //T1 и выше
          StrIni:=PacketsINI.ReadString('client',IntToHex(subid,4),'Unknown:h(subID)')
        else
          StrIni:=PacketsINI.ReadString('client',IntToHex(id,2),'Unknown:')
    else
      //server
      if (Byte(PktStr[12]) in [$FE]) and (size>3) then
        StrIni:=PacketsINI.ReadString('server',IntToHex(subid,4),'Unknown:h(subID)')
      else
        StrIni:=PacketsINI.ReadString('server',IntToHex(id,2),'Unknown:');

    Label1.Caption:=lang.GetTextOrDefault('IDS_109' (* 'Выделенный пакет: тип - 0x' *) )+IntToHex(id,2)+', '+PacketName+lang.GetTextOrDefault('size' (* ', размер - ' *) )+IntToStr(Size);

    //начинаем разбирать пакет по заданному в packets.ini формату
    //смещение в ini
    PosInIni:=Pos(':',StrIni);
    //смещение в pkt
    PosInPkt:=13;
    Inc(PosInIni);
    //Memo2.Lines.BeginUpdate;
    
    //Добавляем тип
    rvDescryption.AddNL(lang.GetTextOrDefault('IDS_121' (* 'Tип: ' *) ),11,0);
    rvDescryption.AddNLTag('0x'+IntToHex(id,2),0,-1,1);
    rvDescryption.AddNL(' (',0,-1);
    rvDescryption.AddNL(PacketName,1,-1);
    rvDescryption.AddNL(')',0,-1);

    //добавляем размер и время
    rvDescryption.AddNL(lang.GetTextOrDefault('size2' (* 'Pазмер: ' *) ), 0, 0);
    rvDescryption.AddNL(IntToStr(Size-2),1,-1);
    rvDescryption.AddNL('+2',2,-1);

    rvDescryption.AddNL(lang.GetTextOrDefault('IDS_126' (* 'Время прихода: ' *) ),0,0);
    rvDescryption.AddNL(FormatDateTime('hh:nn:ss:zzz',ptime),1,-1);


    itemTag := 0;
    templateindex := 11;
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
    while (PosInIni>1)and(PosInIni<Length(StrIni))and(PosInPkt<Size+10) do
    begin
      Param0:=GetType (StrIni,PosInIni);
      inc(PosInIni);
      typ:=GetTyp(Param0); //считываем тип значения
      name:=GetName(Param0); //считываем имя значения в скобках (name:func.par)
      func:=uppercase(GetFunc(Param0)); //считываем имя функции в скобках (name:func.par)
      param1:=uppercase(GetParam(Param0)); //считываем имя значения в скобках (name:func.1.2)
      param2:=GetParam2(Param0); //считываем имя значения в скобках (name:func.1.2)
      offset:=PosinPkt-11;
      oldpos := PosInPkt;
      value:=GetValue(typ, name, PktStr, PosInPkt, size); //считываем значение, сдвигаем указатели в соответствии с типом значения
      if AllowedName(name) then
      begin
        FuncParamNames.Add(name);
        FuncParamTypes.Add(typ);
        FuncParamNumbers.Add(inttostr(length(blockmask)));
      end;
      blockmask := blockmask + typ;
      
      if PosInPkt - oldpos > 0 then
        addtoHex(StringToHex(copy(pktstr, oldpos, PosInPkt - oldpos),' '));

      if value = 'range error' then break;
      if uppercase(Func)='GET' then
      begin
        if not get(param1, id, value) then
          exit
        else
        addToDescr(offset, typ, name, value);        //распечатываем
      end
      else
      //для С4, С5 и Т0-Интерлюдия
      if uppercase(Func)='FOR' then begin
        //распечатываем
        addToDescr(offset, typ, name, value+hexvalue);

        tmp_param:=param1;
        tmp_value:=value;
        ii:=PosInIni;
        if value='range error' then break;
        if StrToInt(value)=0 then begin
          //пропускаем пустые значения
          for jj:=1 to StrToInt(param1) do begin
            Param0:=GetType(StrIni,PosInIni);
            inc(PosInIni);
          end;
        end else begin
          rvDescryption.AddNL('Mask : ', 0, 0);
          rvDescryption.AddNL(blockmask, 4, -1);
          blockmask := '';
          for j:=1 to StrToInt(tmp_value) do
          begin
            rvDescryption.AddNL('              '+lang.GetTextOrDefault('startb' (* '[Начало повторяющегося блока ' *) ), 0, 0);
            rvDescryption.AddNL(inttostr(j)+'/'+tmp_value, 1, -1);
            rvDescryption.AddNL(']', 0, -1);

            PosInIni:=ii;

            for jj:=1 to StrToInt(tmp_param) do
            begin
              Param0:=GetType(StrIni,PosInIni);
              inc(PosInIni);
              typ:=GetTyp(Param0); //считываем тип значения
              name:=GetName(Param0); //считываем имя значения в скобках (name:func.1)
              func:=uppercase(GetFunc(Param0)); //считываем имя функции в скобках (name:func.par)
              param1:=uppercase(GetParam(Param0)); //считываем имя значения в скобках (name:func.1.2)
              //param2:=GetParam2(Param0); //считываем имя значения в скобках (name:func.1)
              offset:=PosinPkt-11;
              oldpos := PosInPkt;
              value:=GetValue(typ, name, PktStr, PosInPkt, size);
              if AllowedName(name) then
              begin
                FuncParamNames.Add(name);
                FuncParamTypes.Add(typ);
                FuncParamNumbers.Add(inttostr(length(blockmask)));
              end;
              blockmask := blockmask + typ;

              if PosInPkt - oldpos > 0 then
                addtoHex(StringToHex(copy(pktstr, oldpos, PosInPkt - oldpos),' '));

              if value = 'range error' then break;
              if uppercase(Func)='GET' then  get(param1, id, value);
              addToDescr(offset, typ, name, value); //печатаем
            end;
            
            if value = 'range error' then break;

            rvDescryption.AddNL('              '+lang.GetTextOrDefault('endb' (* '[Конец повторяющегося блока ' *) ), 0, 0);
            rvDescryption.AddNL(inttostr(j)+'/'+tmp_value, 1, -1);
            rvDescryption.AddNL(']', 0, -1);
          end;
        end;
      end else
      //для Т1 - Камаель-Хелбаунд-Грация
      (*в функции LOOP первый параметр может быть больше 1,
       значит его просто выводим, а остальное
       в цикле до параметр 2*)
      if uppercase(Func)='LOOP' then begin
        //распечатываем                                                                              
        addToDescr(offset, typ, name, value+hexvalue);
        PrintFuncsParams('Pck'+PacketName);

        //Memo2.SelStart:=d+length(inttostr(offset))+1;

        tmp_param:=param2;
        tmp_value:=value;
        if value='range error' then break;
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
              oldpos := PosInPkt;
              value:=GetValue(typ, name, PktStr, PosInPkt, size);
              if AllowedName(name) then
              begin
                FuncParamNames.Add(name);
                FuncParamTypes.Add(typ);
                FuncParamNumbers.Add(inttostr(length(blockmask)));
              end;
              blockmask := blockmask + typ;
              if PosInPkt - oldpos > 0 then
                addtoHex(StringToHex(copy(pktstr, oldpos, PosInPkt - oldpos),' '));

              if value = 'range error' then break;

              //распечатываем
              addToDescr(offset, typ, name, value+hexvalue);
            end;
          end;
          ii:=PosInIni;
            PrintFuncsParams('LoopItem'+PacketName);

          for j:=1 to StrToInt(tmp_value) do begin

            rvDescryption.AddNL('              '+lang.GetTextOrDefault('startb' (* '[Начало повторяющегося блока ' *) ), 0, 0);
            rvDescryption.AddNL(inttostr(j)+'/'+tmp_value, 1, -1);
            rvDescryption.AddNL(']', 0, -1);
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

              oldpos := PosInPkt;
              value:=GetValue(typ, name, PktStr, PosInPkt, size);
              if AllowedName(name) then
              begin
                FuncParamNames.Add(name);
                FuncParamTypes.Add(typ);
                FuncParamNumbers.Add(inttostr(length(blockmask)));
              end;
              blockmask := blockmask + typ;

              if PosInPkt - oldpos > 0 then
                addtoHex(StringToHex(copy(pktstr, oldpos, PosInPkt - oldpos),' '));

              if value = 'range error' then break;
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
              addToDescr(offset, typ, name, value+hexvalue);
            end;
            PrintFuncsParams('Item'+PacketName);

            rvDescryption.AddNL('              '+lang.GetTextOrDefault('endb' (* '[Конец повторяющегося блока ' *) ), 0, 0);
            rvDescryption.AddNL(inttostr(j)+'/'+tmp_value, 1, -1);
            rvDescryption.AddNL(']', 0, -1);
          end;
        end;
      end else
      begin
        //распечатываем
        addToDescr(offset, typ, name, value+hexvalue);

      end;
    end;
    except
      //ошибка при распознании пакета
    end;
  oldpos := PosInPkt;
  PosInPkt := size + 10;
  if PosInPkt - oldpos > 0 then
    addtoHex(StringToHex(copy(pktstr, oldpos, PosInPkt - oldpos),' '));

  if blockmask <> '' then
    PrintFuncsParams('FullPck'+PacketName);

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
  if param1='FUNC01' then   value:=GetFunc01(strtoint(value)) else
  if param1='FUNC02' then   value:=GetFunc02(strtoint(value)) else
  if param1='FUNC09' then   value:=GetFunc09(id, strtoint(value)) else
  if param1='CLASSID' then  value:=GetClassID(strtoint(value)) else
  if param1='FSUP' then     value:=GetFsup(strtoint(value)) else
  if param1='NPCID' then    value:=GetNpcID(strtoint(value)) else
  if param1='MSGID' then    value:=GetMsgID(strtoint(value)) else
  if param1='SKILL' then    value:=GetSkill(strtoint(value)) else
  if param1='AUGMENTID' then    value:=GetAugment(strtoint(value));

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
Splitter2.Visible := N2.Checked;
rvFuncs.Visible := n2.Checked;
Splitter2.Top := 1;
end;

end.

