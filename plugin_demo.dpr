library plugin_demo;

uses
  FastMM4,
  Coding in 'Coding.pas';

const
  min_ver = $03040000;

var
  th: PThreads;
  thc: Integer;
  SendPacket: TSendPacket;


function GetPluginInfo(const ver: Integer): PChar; stdcall;
begin
  if ver<min_ver then
    Result:='Демонстрационный Plugin к программе l2phx'+sLineBreak+
            'Для версий 3.4.0+'+sLineBreak+
            'У вас старая версия программы! Плагин не сможет корректно с ней работать!'
  else
    Result:='Демонстрационный Plugin к программе l2phx'+sLineBreak+
            'Для версий 3.4.0+';
end;

function SetStruct(const struct: TPluginStruct): Boolean; stdcall;
begin
  th:=struct.Threads;
  thc:=struct.ThreadsCount;
  SendPacket:=struct.SendPck;
end;

procedure OnPacket(const cnt: Cardinal; const fromServer: Boolean; var packet); stdcall;
var
  pck: packed record
    size: Word;
    id: Byte;
    data: array[0..0] of Byte;
  end absolute packet;
  spck: string;
begin
  if fromServer and(pck.id=$4a)then begin
    SetLength(spck,pck.size-2);
    Move(pck.id,spck[1],Length(spck));
    SendPacket(pck.size,spck,cnt,False);
  end;
end;

exports
  GetPluginInfo,
  OnPacket,
  SetStruct;

begin
end.
