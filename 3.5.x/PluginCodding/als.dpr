{ Плагин переходник экспортирующий функции пакетхака для возможности их        }
{ использования из плагинов написанных на других языках (не на Delphi)         }

library als;

{$define RELEASE} // для совместимости с релизом пакетхака, при дебуге можно закоментировать

uses
  FastMM4 in '..\fastmm\FastMM4.pas',
  FastMM4Messages in '..\fastmm\FastMM4Messages.pas',
  usharedstructs in '..\units\usharedstructs.pas';

type
  TalsStruct = record
    userFormHandle: THandle;
    ConnectInfo : tConnectInfo;
  end;
  PalsStruct = ^TalsStruct;

var
  ps: TPluginStruct;
  pals: PalsStruct;

function GetPluginInfo(const ver: Integer): PChar; stdcall;
begin
  Result:='Plugin for support not Delphi plugins';
end;                                            

function SetStruct(const struct: PPluginStruct): Boolean; stdcall;
begin
  ps:=struct^;
  pals:=@ps.userFormHandle;
  Result:=True;
end;

function GetALSStruct: PalsStruct; stdcall;
begin
  Result:=pals;
end;

function ReadC(const pck: string; const index:integer):byte; stdcall;
begin
  Result:=ps.ReadC(pck,index);
end;

function ReadH(const pck: string; const index:integer):word; stdcall;
begin
  Result:=ps.ReadH(pck,index);
end;

function ReadD(const pck: string; const index:integer):integer; stdcall;
begin
  Result:=ps.ReadD(pck,index);
end;

function ReadF(const pck: string; const index:integer):double; stdcall;
begin
  Result:=ps.ReadF(pck,index);
end;

function ReadS(const pck: string; const index:integer):string; stdcall;
begin
  Result:=ps.ReadS(pck,index);
end;

function ReadCEx(const pck; const index:integer):byte; stdcall;
begin
  Result:=ps.ReadCEx(pck,index);
end;

function ReadHEx(const pck; const index:integer):word; stdcall;
begin
  Result:=ps.ReadHEx(pck,index);
end;

function ReadDEx(const pck; const index:integer):integer; stdcall;
begin
  Result:=ps.ReadDEx(pck,index);
end;

function ReadFEx(const pck; const index:integer):double; stdcall;
begin
  Result:=ps.ReadFEx(pck,index);
end;

function ReadSEx(const pck; const index:integer):PChar; stdcall;
begin
  Result:=@ps.ReadSEx(pck,index)[1];
end;

procedure WriteC(var pck: string; const v:byte;    ind:integer=-1); stdcall;
begin
  ps.WriteC(pck,v,ind);
end;

procedure WriteH(var pck: string; const v:word;    ind:integer=-1); stdcall;
begin
  ps.WriteH(pck,v,ind);
end;

procedure WriteD(var pck: string; const v:integer; ind:integer=-1); stdcall;
begin
  ps.WriteD(pck,v,ind);
end;

procedure WriteF(var pck: string; const v:double;  ind:integer=-1); stdcall;
begin
  ps.WriteF(pck,v,ind);
end;

procedure WriteS(var pck: string; const v:string;  ind:integer=-1); stdcall;
begin
  ps.WriteS(pck,v,ind);
end;

procedure WriteCEx(var pck; const v:byte;    ind:integer=-1); stdcall;
begin
  ps.WriteCEx(pck,v,ind);
end;

procedure WriteHEx(var pck; const v:word;    ind:integer=-1); stdcall;
begin
  ps.WriteHEx(pck,v,ind);
end;

procedure WriteDEx(var pck; const v:integer; ind:integer=-1); stdcall;
begin
  ps.WriteDEx(pck,v,ind);
end;

procedure WriteFEx(var pck; const v:double;  ind:integer=-1); stdcall;
begin
  ps.WriteFEx(pck,v,ind);
end;

procedure WriteSEx(var pck; const v:PChar;  ind:integer=-1); stdcall;
begin
  ps.WriteSEx(pck,v,ind);
end;

function CreateAndRunTimerThread(const interval, usrParam: Cardinal;
                                 const OnTimerProc: TOnTimer): Pointer; stdcall;
begin
  Result:=ps.CreateAndRunTimerThread(interval, usrParam, OnTimerProc);
end;

procedure ChangeTimerThread(const timer: Pointer; const interval: Cardinal;
                            const usrParam: Cardinal = $ffffffff;
                            const OnTimerProc: TOnTimer = nil); stdcall;
begin
  ps.ChangeTimerThread(timer, interval, usrParam, OnTimerProc);
end;

procedure DestroyTimerThread(var timer: Pointer); stdcall;
begin
  ps.DestroyTimerThread(timer);
end;

function StringToHex(str1,Separator: string):string; stdcall;
begin
  Result:=ps.StringToHex(str1,Separator);
end;

function HexToString(Hex:string):string; stdcall;
begin
  Result:=ps.HexToString(Hex);
end;

function DataPckToStrPck(var pck): string; stdcall;
begin
  Result:=ps.DataPckToStrPck(pck);
end;

procedure SendPacketData(var pck; const tid: integer; const ToServer: Boolean); stdcall;
begin
  ps.SendPacketData(pck, tid, ToServer);
end;

procedure SendPacketStr(pck: string; const tid: integer; const ToServer: Boolean); stdcall;
begin
  ps.SendPacketStr(pck, tid, ToServer);
end;

procedure SendPacket(Size: Word; pck: string; tid: integer; ToServer: Boolean); stdcall;
begin
  ps.SendPacket(Size, pck, tid, ToServer);
end;

function getConnectionName(id: integer):PChar; stdcall;
begin
  Result:=PChar(ps.getConnectionName(id));
end;

function getConnectioidByName(name: PChar):integer; stdcall;
begin
  Result:=ps.getConnectioidByName(name);
end;

Function GoFirstConnection:boolean; stdcall;
begin
  Result:=ps.GoFirstConnection;
end;

Function GoNextConnection:boolean; stdcall;
begin
  Result:=ps.GoNextConnection;
end;

procedure ShowUserForm(ActivateOnly:boolean); stdcall;
begin
  ps.ShowUserForm(ActivateOnly);
end;

Procedure HideUserForm; stdcall;
begin
  HideUserForm;
end;

exports
  GetPluginInfo,
  SetStruct,
  ReadC,
  ReadH,
  ReadD,
  ReadF,
  ReadS,
  ReadCEx,
  ReadHEx,
  ReadDEx,
  ReadFEx,
  ReadSEx,
  WriteC,
  WriteH,
  WriteD,
  WriteF,
  WriteS,
  WriteCEx,
  WriteHEx,
  WriteDEx,
  WriteFEx,
  WriteSEx,
  CreateAndRunTimerThread,
  ChangeTimerThread,
  DestroyTimerThread,
  StringToHex,
  HexToString,
  DataPckToStrPck,
  SendPacketData,
  SendPacketStr,
  SendPacket,
  getConnectionName,
  getConnectioidByName,
  GoFirstConnection,
  GoNextConnection,
  ShowUserForm,
  HideUserForm,
  GetALSStruct;

begin
end.

