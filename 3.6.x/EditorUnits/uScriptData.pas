unit uScriptData;

interface
uses
  dialogs,
  sysutils,
  uUserForm,
  forms,
  windows,
  classes,
  PaxCompiler,
  PaxRegister,
  variants;
  
type

  TscriptData = class (Tobject)
  private
  public
    scripter : tobject;
    Pck,
    Buf : string;

    ConnectID : integer;
    FromServer,
    FromClient : boolean;
    Finished : boolean;
    ConnectName : string;

    constructor Create;
    destructor Destroy;override;
  end;

  var
  CurrentSD : TscriptData;

procedure updatescripterfuncs(var list:tstringlist);
procedure RegisterRoutine(sd:TscriptData;PC: TPaxCompiler);

implementation

uses umain, uScriptProject, usharedstructs, udata, uglobalfuncs, uScriptEditorResourcesStrings, strutils;

var
  searchfor : string;
  searchresult : thandle;

{ TscripterData }


procedure ShowForm;
begin
  if not TScriptProject(CurrentSD.scripter).CanUse then exit;
  UserForm.Show;
  fMain.nUserFormShow.Enabled := true;
end;

procedure HideForm;
begin
  if not TScriptProject(CurrentSD.scripter).CanUse then exit;
  UserForm.Hide;
  fMain.nUserFormShow.Enabled := false;
end;

procedure Delay(msec: Cardinal);
begin
  Sleep(msec);
end;

procedure WriteC(v: byte; ind: integer = 0);
begin
try
 if ind = 0 then
   CurrentSD.Buf:=CurrentSD.Buf+Char(v)
 else
   begin
   while length(CurrentSD.Buf) <= ind+1 do
     CurrentSD.Buf := CurrentSD.Buf + ' ';

   CurrentSD.Buf[ind]:=Char(v);
   end;
except
end;
end;

procedure WriteS(v: string);
var
  temp : widestring;
  tmp : string;
begin
try
  tmp := v + v;
  temp := v;
  Move(temp[1],tmp[1],Length(tmp));
  CurrentSD.Buf := CurrentSD.Buf + tmp + #0#0
except
end;
end;

procedure WriteD(v : integer; ind: integer = 0);
var
  tmp: string;
begin
try
  if ind = 0 then
  begin
    SetLength(tmp,4);
    Move(v,tmp[1],4);
    CurrentSD.Buf:=CurrentSD.Buf+tmp;
  end
  else
  begin
    while length(CurrentSD.Buf) <= ind+4 do
     CurrentSD.Buf := CurrentSD.Buf + ' '; 
    Move(v,CurrentSD.Buf[ind], 4);
  end;
except
end;
end;

procedure WriteH(v: word; ind: integer = 0);
var
  tmp: string;
begin
try
    if ind = 0 then
    begin
      SetLength(tmp,2);
      Move(v,tmp[1],2);
      CurrentSD.Buf:=CurrentSD.Buf+tmp;
    end else
    begin
      while length(CurrentSD.Buf) <= ind+2 do
       CurrentSD.Buf := CurrentSD.Buf + ' ';    
      Move(v,CurrentSD.Buf[ind],2);
    end;
except
end;
end;

procedure WriteF(v: double; ind: integer = 0);
var
  tmp: string;
begin
try
    if ind = 0 then
    begin
      SetLength(tmp,8);
      Move(v,tmp[1],8);
      CurrentSD.Buf:=CurrentSD.Buf+tmp;
    end
      else
    begin
      while length(CurrentSD.Buf) <= ind+8 do
       CurrentSD.Buf := CurrentSD.Buf + ' ';    
      Move(v,CurrentSD.Buf[ind],8);
    end;
except
end;
end;

function ReadS(var index: integer): string;
var
  temp : WideString;
  d : integer;
begin
try
    d:=PosEx(#0#0, CurrentSD.Pck,index)-index;
    if (d mod 2)=1 then Inc(d);
    SetLength(temp,d div 2);
    if d>=2 then Move(CurrentSD.Pck[index],temp[1],d) else d:=0;
    Inc(index,d+2);
    Result := temp;
except
   Result := '';
end;
end;

function ConstReadS(Const index: integer): string;
var
  i : integer;
begin
  i := index;
  Result := ReadS(i);
end;


function ReadC(var index: integer): byte;
begin
try
  if (index <= Length(CurrentSD.Pck)) and (index > 0) then
   result := Byte(CurrentSD.Pck[index])
  else
   Result :=0;
  inc(index)
except
  result := 0;
end;
end;

function ConstReadC(Const index: integer): byte;
var
  i : integer;
begin
  i := index;
  Result := ReadC(i);
end;

function ReadD(var index:integer):integer;
begin
try
  if index < Length(CurrentSD.Pck) - 2 then
    Move(CurrentSD.Pck[index], Result, 4)
  else
    Result := 0;

  inc(index, 4);
except
  result := 0;
end;

end;

function ConstReadD(Const index: integer): integer;
var
  i : integer;
begin
  i := index;
  Result := ReadD(i);
end;


function ReadF(var index: integer): double;
begin
try
  if index < Length(CurrentSD.Pck) - 6 then
    Move(CurrentSD.Pck[index], Result, 8)
  else
    Result := 0;
  inc(index, 8)
  
except
  result := 0;
end;
end;

function ConstReadF(Const index: integer): Double;
var
  i : integer;
begin
  i := index;
  Result := ReadF(i);
end;


function ReadH(var index: integer): word;
begin
try
  if index < Length(CurrentSD.Pck) then
    Move(CurrentSD.Pck[index], Result, 2)
  else
    Result := 0;
  inc(index, 2)
except
  result := 0;
end;
end;

function ConstReadH(Const index: integer): word;
var
  i : integer;
begin
  i := index;
  Result := ReadH(i);
end;

function StrToHex(str1:String):String;
begin
try
  Result:=StringToHex(str1,'')
except
end;
end;

procedure LogMSG(msg:String);
begin
  AddToLog(msg);
end;

procedure Finish;
begin
  CurrentSD.Finished := true;
end;

procedure SetName(Name:string);
begin
  dmdata.SetConName(CurrentSD.ConnectID, name);
  CurrentSD.ConnectName := name;
end;

Function ConnectName: String;
begin
  Result := CurrentSD.ConnectName;
end;

Function FromServer: Boolean;
begin
  Result := CurrentSD.FromServer;
end;

Function FromClient: Boolean;
begin
  Result := CurrentSD.FromClient;
end;

Function ConnectID: Integer;
begin
  Result := CurrentSD.ConnectID;
end;

function ConnectNameByID(id:integer):string;
begin
  Result := dmData.ConnectNameByID(id)
end;

function ConnectIDByName(name:string):integer;
begin
  Result := dmData.ConnectIdByName(name);
end;

procedure Disconnect;
begin
  if not TScriptProject(CurrentSD.scripter).CanUse then exit;
  dmdata.DoDisconnect(CurrentSD.ConnectID);
end;

procedure NoCloseFrameAfterDisconnect;
begin
  if not TScriptProject(CurrentSD.scripter).CanUse then exit;
  dmdata.setNoFreeOnConnectionLost(CurrentSD.ConnectID, true);
end;

procedure CloseFrameAfterDisconnect;
begin
  if not TScriptProject(CurrentSD.scripter).CanUse then exit;
  dmdata.setNoFreeOnConnectionLost(CurrentSD.ConnectID, false);
end;

procedure NoCloseClientAfterServerDisconnect;
begin
  if not TScriptProject(CurrentSD.scripter).CanUse then exit;
  dmdata.setNoDisconnectOnDisconnect(CurrentSD.ConnectID, true, true);
end;

procedure CloseClientAfterServerDisconnect;
begin
  if not TScriptProject(CurrentSD.scripter).CanUse then exit;
  dmdata.setNoDisconnectOnDisconnect(CurrentSD.ConnectID, false, false);
end;

procedure NoCloseServerAfterClientDisconnect;
begin
  if not TScriptProject(CurrentSD.scripter).CanUse then exit;
  dmdata.setNoDisconnectOnDisconnect(CurrentSD.ConnectID, true, false);
end;

procedure CloseServerAfterClientDisconnect;
begin
  if not TScriptProject(CurrentSD.scripter).CanUse then exit;
  dmdata.setNoDisconnectOnDisconnect(CurrentSD.ConnectID, false, true);
end;


procedure SendToClient;
var
  packet : TPacket;
begin
  if not TScriptProject(CurrentSD.scripter).CanUse then exit;
  packet.Size := Length(CurrentSD.Buf)+2;
  Move(CurrentSD.Buf[1], packet.Data[0], Length(CurrentSD.Buf));
  dmData.SendPacket(packet, ConnectID, False);
end;

procedure SendToServer;
var
  packet : TPacket;
begin
  if not TScriptProject(CurrentSD.scripter).CanUse then exit;
  packet.Size := Length(CurrentSD.Buf)+2;
  Move(CurrentSD.Buf[1], packet.Data[0], Length(CurrentSD.Buf));
  dmData.SendPacket(packet, ConnectID, True);
end;

procedure SendToClientEx(CharName:string);
var
  packet : TPacket;
begin
  if not TScriptProject(CurrentSD.scripter).CanUse then exit;
  packet.Size := Length(CurrentSD.Buf)+2;
  Move(CurrentSD.Buf[1], packet.Data[0], Length(CurrentSD.Buf));
  dmData.SendPacketToName(packet, CharName, False);
end;

procedure SendToServerEx(CharName:string);
var
  packet : TPacket;
begin
  if not TScriptProject(CurrentSD.scripter).CanUse then exit;
  packet.Size := Length(CurrentSD.Buf)+2;
  Move(CurrentSD.Buf[1], packet.Data[0], Length(CurrentSD.Buf));
  dmData.SendPacketToName(packet, CharName, True);
end;

procedure RegisterRoutine(sd:TscriptData;PC: TPaxCompiler);
var
  H: Integer;
begin

pc.RegisterVariable(0,'Pck:string;',@sd.pck);
pc.RegisterVariable(0,'Buf:string;',@sd.Buf);
pc.RegisterVariable(0,'Userform:Tform;',@Userform);

pc.RegisterHeader(0, 'Function HStr(Hex: String): String;', @HexToString);
pc.RegisterHeader(0, 'function StrToHex(str1:String):String;', @StrToHex);

pc.RegisterHeader(0, 'procedure LogMSG(msg:String);', @LogMSG);
pc.RegisterHeader(0, 'procedure Finish;', @Finish);

pc.RegisterHeader(0,'procedure SendToClient;', @SendToClient);
pc.RegisterHeader(0,'procedure SendToServer;', @SendToServer);
pc.RegisterHeader(0,'procedure SendToServerEx(CharName:string);', @SendToServerEx);
pc.RegisterHeader(0,'procedure SendToClientEx(CharName:string);', @SendToClientEx);

pc.RegisterHeader(0,'function ConnectID : integer;', @ConnectID);
pc.RegisterHeader(0,'function ConnectName : string;', @ConnectName);
pc.RegisterHeader(0,'function FromServer : boolean;', @FromServer);
pc.RegisterHeader(0,'function FromClient : boolean;', @FromClient);
pc.RegisterHeader(0, 'procedure SetName(Name:string);', @SetName);
pc.RegisterHeader(0, 'function ConnectNameByID(id:integer):string;', @ConnectNameByID);
pc.RegisterHeader(0, 'function ConnectIDByName(name:string):integer;', @ConnectIDByName);
pc.RegisterHeader(0, 'procedure Disconnect;', @Disconnect);

pc.RegisterHeader(0, 'procedure NoCloseFrameAfterDisconnect;', @NoCloseFrameAfterDisconnect);
pc.RegisterHeader(0, 'procedure CloseFrameAfterDisconnect;', @CloseFrameAfterDisconnect);
pc.RegisterHeader(0, 'procedure NoCloseClientAfterServerDisconnect;', @NoCloseClientAfterServerDisconnect);
pc.RegisterHeader(0, 'procedure CloseClientAfterServerDisconnect;', @CloseClientAfterServerDisconnect);
pc.RegisterHeader(0, 'procedure NoCloseServerAfterClientDisconnect;', @NoCloseServerAfterClientDisconnect);
pc.RegisterHeader(0, 'procedure CloseServerAfterClientDisconnect;', @CloseServerAfterClientDisconnect);

pc.RegisterHeader(0, 'procedure HideForm;', @HideForm);
pc.RegisterHeader(0, 'procedure ShowForm;', @ShowForm);
PC.RegisterHeader(0, 'procedure Delay(msec: Cardinal); ', @Delay);

PC.RegisterHeader(0, 'procedure WriteS(v:string);',@WriteS);
PC.RegisterHeader(0, 'procedure WriteC(v:byte; ind:integer=0);',@WriteC);
PC.RegisterHeader(0, 'procedure WriteD(v:integer; ind:integer=0);',@WriteD);
PC.RegisterHeader(0, 'procedure WriteH(v:word; ind:integer=0);',@WriteH);
PC.RegisterHeader(0, 'procedure WriteF(v:double; ind:integer=0);',@WriteF);

PC.RegisterHeader(0, 'function ReadS(var index:integer):string; overload;',@ReadS);
PC.RegisterHeader(0, 'function ReadC(var index:integer):byte; overload;',@ReadC);
PC.RegisterHeader(0, 'function ReadD(var index:integer):integer; overload;',@ReadD);
PC.RegisterHeader(0, 'function ReadH(var index:integer):word; overload;',@ReadH);
PC.RegisterHeader(0, 'function ReadF(var index:integer):double; overload;',@ReadF);

PC.RegisterHeader(0, 'function ReadS(Const index:integer):string; overload;',@ConstReadS);
PC.RegisterHeader(0, 'function ReadC(Const index:integer):byte; overload;',@ConstReadC);
PC.RegisterHeader(0, 'function ReadD(Const index:integer):integer; overload;',@ConstReadD);
PC.RegisterHeader(0, 'function ReadH(Const index:integer):word; overload;',@ConstReadH);
PC.RegisterHeader(0, 'function ReadF(Const index:integer):double; overload;',@ConstReadF);

end;

procedure updatescripterfuncs(var list:tstringlist);
begin
list.Clear;
list.Add('Pck:string;');
list.Add('Buf:string;');


list.Add('Function HStr(Hex: String): String;');
list.Add('function StrToHex(str1:String):String;');

list.Add('procedure WriteS(v:string);');
list.Add('procedure WriteC(v:byte; ind:integer=0);');
list.Add('procedure WriteD(v:integer; ind:integer=0);');
list.Add('procedure WriteH(v:word; ind:integer=0);');
list.Add('procedure WriteF(v:double; ind:integer=0);');

list.Add('function ReadS(var/const index:integer):string;');
list.Add('function ReadC(var/const index:integer):byte;');
list.Add('function ReadD(var/const index:integer):integer;');
list.Add('function ReadH(var/const index:integer):word;');
list.Add('function ReadF(var/const index:integer):double;');

list.Add('procedure SendToClient;');
list.Add('procedure SendToServer;');
list.Add('procedure SendToServerEx(CharName:string);');
list.Add('procedure SendToClientEx(CharName:string);');

list.Add('procedure Delay(msec: Cardinal); ');
list.Add('procedure LogMSG(msg:String);');
list.Add('Print [array of variables];');

list.Add('Userform:Tform;');
list.Add('procedure HideForm;');
list.Add('procedure ShowForm;');

list.Add('function ConnectName : string;');
list.Add('function FromServer : boolean;');
list.Add('function FromClient : boolean;');
list.Add('function ConnectID : integer;');
list.Add('procedure SetName(Name:string);');
list.Add('function ConnectNameByID(id:integer):string;');
list.Add('function ConnectIDByName(name:string):integer;');
list.Add('procedure Disconnect;');

list.Add('procedure NoCloseFrameAfterDisconnect;');
list.Add('procedure CloseFrameAfterDisconnect;');
list.Add('procedure NoCloseClientAfterServerDisconnect;');
list.Add('procedure CloseClientAfterServerDisconnect;');
list.Add('procedure NoCloseServerAfterClientDisconnect;');
list.Add('procedure CloseServerAfterClientDisconnect;');




end;






constructor TscriptData.create;
begin
  inherited;
end;

destructor TscriptData.Destroy;
begin
  inherited;
end;


end.




