library plugin_demo;

{$define RELEASE} // для совместимости с релизом пакетхака, при дебуге можно закоментировать

uses
  FastMM4,
  SysUtils,
  Windows,
  Coding in 'plugins\Coding.pas';

var                                {version} {revision}
  min_ver_a: array[0..3] of Byte = ( 3,4,1,      46   );
  min_ver: Integer absolute min_ver_a; // минимальная поддерживаемая версия программы
  ps: TPluginStruct;
  ppck: PPacket;

function GetPluginInfo(const ver: Integer): PChar; stdcall;
begin
  if ver<min_ver then
    Result:='Демонстрационный Plugin к программе l2phx'+sLineBreak+
            'Для версий 3.4.0+'+sLineBreak+
            'У вас старая версия программы! Плагин не сможет корректно с ней работать!'
  else
    Result:='Демонстрационный Plugin к программе l2phx'+sLineBreak+
            'Для версий 3.4.0+'+sLineBreak+
            'Автовыпивалка НР бутылок';
end;

function SetStruct(const struct: TPluginStruct): Boolean; stdcall;
begin
  ps:=struct;
  Result:=True;
end;

const
  pause=15000;

var
  ColvoHP, CharObjID, ItemObjHP: integer;
  CurHP, MaxHP, lastHP, cntHP:integer;
  TimerHP: Boolean;
  StatusHP: Boolean;

function CntByName(nm: string): Byte;
var
  i: Integer;
begin
  Result:=0;
  for i:=0 to ps.ThreadsCount-1 do if ps.Threads[i].Name=nm then begin
    Result:=i;
    Exit;
  end;
end;

procedure Say(msg:string);
var
  buf: string;
begin
  with ps do begin
    buf:=HexToString('4A 00 00 00 00');
    WriteD(buf,2);
    WriteS(buf,'AutoHP');
    WriteS(buf,msg);
    SendPckStr(buf,cntHP,False);
  end;
end;

procedure InitStats;
begin
  //Запоминаем ИД
  CharObjID:=ps.ReadDEx(ppck^,19);
  MaxHP:=ps.ReadDEx(ppck^,83);
end;

procedure StatsUpdate;
var
 i: integer;
begin
 for i:=0 to ps.ReadDEx(ppck^,7)-1 do
 case ppck^.data[i*8+8] of
   $09: CurHP:=ps.ReadDEx(ppck^,i*8+15);
   $0A: MaxHP:=ps.ReadDEx(ppck^,i*8+15);
 end;
 say('CurHP/MaxHP = '+inttostr(curhp)+'/'+inttostr(maxhp));
 if (CurHP<=MaxHP-50) then TimerHP:=true else TimerHP:=false;
end;

procedure OnLoad; stdcall;
var
 i: integer;
begin
  statusHP:=false;
  CharObjID:=0;
  ItemObjHP:=0;
  TimerHP:=false;
  lastHP:=0;
  for i:=0 to ps.ThreadsCount-1 do begin
    cntHP:=i;
    Say('Для выбора нужного соединения наберите в чате слово set и отправьте');
  end;
  cntHP:=-1;
end;

procedure OnPacket(const cnt: Cardinal; const fromServer: Boolean; var pck: TPacket); stdcall;
var
  buf: string;
begin
  if pck.size<3 then exit;
  ppck:=@pck;

  if not FromServer and(pck.id=$38)and(cntHP=-1)then
  if(ps.ReadSEx(pck,3)='set')then begin
    pck.size:=2; // не пропускаем пакет
    cntHP:=cnt;
    Say('Выбрано это соединение.');
    Say('Для начала работы скрипта бросаем, подбираем или выпиваем Heal Potion!');
  end;

  if FromServer and(cnt=cntHP)then begin
    //InventoryUpdate
    if(pck.id=$27)and((ps.ReadDEx(pck,13)=1060)
    or(ps.ReadDEx(pck,13)=1061))then begin //Healing Potion, Lesser Healing Potion
      ItemObjHP:=ps.ReadDEx(pck,9);
      ColvoHP:=ps.ReadDEx(pck,17); //количество хилок
      if statusHP then exit;
      Say('Автоматическое использование Нeal Рotion готово к работе!');
      Say('Хилок='+IntToStr(ColvoHP));
      statusHP:=true;
    end;

    //UserInfo
    if(pck.id=$04)then InitStats;

    //StatusUpdate
    if((pck.id=$0E)and(ps.ReadDEx(pck,3)=CharObjID)and(pck.data[4]=$04))then
      StatsUpdate;

    if TimerHP and(GetTickCount-lastHP>pause)then begin
      lastHP:=GetTickCount;
      buf:=#$14;
      ps.WriteD(buf,ItemObjHP);
      ps.WriteD(buf,0);
      ps.SendPckStr(buf,cnt,True);
      if ColvoHP<5 then
        Say('Кончаются хилки! Закупите Heal Potion!');
      if ColvoHP=1 then begin
        Say('Хилок='+inttostr(ColvoHP-1));
        Say('Кончились хилки! Закупите Heal Potion!');
        TimerHP:=False;
      end;
    end;
  end;

end;

exports
  GetPluginInfo,
  OnPacket,
  OnLoad,
  SetStruct;

begin
end.
