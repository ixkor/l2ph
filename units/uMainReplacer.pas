unit uMainReplacer;

interface

uses
  uSharedStructs,
  ComCtrls,
  uGlobalFuncs,
  uResourceStrings,
  advApiHook,  
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList;

type
  TL2PacketHackMain = class(TForm)
    ActionList1: TActionList;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    Action9: TAction;
    Action10: TAction;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure Action10Execute(Sender: TObject);
  private
    { Private declarations }
  public
    procedure NewPacket(var msg: TMessage); Message WM_NewPacket;
    procedure ProcessPacket(var msg: TMessage); Message WM_ProcessPacket;
    procedure NewAction(var msg: TMessage); Message WM_NewAction;
    procedure ReadMsg(var msg: TMessage); Message WM_Dll_Log;

    { Public declarations }
  end;

var
  L2PacketHackMain: TL2PacketHackMain;

implementation
uses
  SyncObjs, uPlugins, uPluginData, usocketengine, winsock, uEncDec, uVisualContainer,
  uSettingsDialog, uLogForm, uConvertForm, uFilterForm, uProcesses,
  uAboutDialog, uData, uUserForm, uProcessRawLog, uScripts, Math, uMain;

{$R *.dfm}

{ TuMainFormReplacer }
var
  c_s : TCriticalSection;

procedure TL2PacketHackMain.NewAction(var msg: TMessage);
var
  Tunel : Ttunel;
  EncDec : TencDec;
  SocketEngine : TSocketEngine;
  action : byte;
  i:integer;

begin
c_s.Enter;
try
action := byte(msg.wparam);

case action of
  TencDec_Action_LOG: //Данные в sLastPacket;  Рисуем пакет
  begin
    //TencDec(Caller).sLastPacket
  end;
  TencDec_Action_MSG: //дaнные в sLastMessage; обработчик - Log
    begin
      EncDec := TencDec(msg.LParam);
      AddToLog(encdec.sLastMessage);
    end;
  TencDec_Action_GotName:
    begin
      EncDec := TencDec(msg.LParam);
      if assigned(EncDec.ParentTtunel) then
        begin
          Tunel := Ttunel(EncDec.ParentTtunel);
          if assigned(tunel) then
            begin
              AddToLog(Format(rsConnectionName, [integer(pointer(Tunel)), encdec.CharName]));
              Tunel.AssignedTabSheet.Caption := EncDec.CharName;
              Tunel.CharName := EncDec.CharName;
            end;
        end;
    end; //данные в name;
    
  TencDec_Action_ClearPacketLog:; //данные нет. просто акшин; обработчик ClearPacketsLog
  //TSocketEngine вызывает эти
  TSocketEngine_Action_MSG: //данные в sLastMessage; обработчик - Log
    begin
      SocketEngine := TSocketEngine(msg.LParam);
      AddToLog(SocketEngine.sLastMessage);
    end;
  Ttunel_Action_connect_server:
  begin
    Tunel := Ttunel(msg.LParam);
    Tunel.AssignedTabSheet := TTabSheet.Create(fMain.pcClientsConnection);
    Tunel.AssignedTabSheet.PageControl := fMain.pcClientsConnection;
    fMain.pcClientsConnection.ActivePageIndex := Tunel.AssignedTabSheet.PageIndex;
    Tunel.AssignedTabSheet.Show;

    Tunel.Visual := TfVisual.Create(Tunel.AssignedTabSheet);
    Tunel.Visual.currentLSP := nil;
    Tunel.Visual.CurrentTpacketLog := nil;
    Tunel.Visual.currenttunel := Tunel;
    Tunel.AssignedTabSheet.Caption := Tunel.CharName;
    tunel.Visual.init;
    Tunel.NeedDeinit := true;

    Tunel.Visual.setNofreeBtns(GlobalNoFreeAfterDisconnect);
    Tunel.Visual.Parent := Tunel.AssignedTabSheet;
    Tunel.active := true;

    if not fMain.pcClientsConnection.Visible then fMain.pcClientsConnection.Visible  := true;

    for i:=0 to Plugins.Count - 1 do with TPlugin(Plugins.Items[i]) do
      if Loaded and Assigned(OnConnect) then OnConnect(Tunel.serversocket, true);
  end; //
  Ttunel_Action_disconnect_server:
  begin
    Tunel := Ttunel(msg.LParam);
    Tunel.active := false;
    for i:=0 to Plugins.Count - 1 do with TPlugin(Plugins.Items[i]) do
      if Loaded and Assigned(OnDisconnect) then OnDisconnect(Tunel.serversocket, true);
  end; //
  Ttunel_Action_connect_client:
    begin ////Создавать такие вещи в нити нельзя.. а вот тут можно...
      Tunel := Ttunel(msg.LParam);
      for i:=0 to Plugins.Count - 1 do with TPlugin(Plugins.Items[i]) do
        if Loaded and Assigned(OnConnect) then OnConnect(Tunel.serversocket, false);
    end; //
  Ttunel_Action_disconnect_client:
    begin
      Tunel := Ttunel(msg.LParam);
      Tunel.active := false;
      for i:=0 to Plugins.Count - 1 do with TPlugin(Plugins.Items[i]) do
        if Loaded and Assigned(OnDisconnect) then OnDisconnect(Tunel.serversocket, false);
    end;

  Ttulel_action_tunel_created:
    begin

    end;
  Ttulel_action_tunel_destroyed:
    begin
      Tunel := Ttunel(msg.LParam);
      if Tunel.NeedDeinit then
        tunel.Visual.deinit;
      if assigned(Tunel) then
        if assigned(Tunel.Visual) then
          begin
          Tunel.Visual.Destroy;
          Tunel.Visual := nil;
          end;

      if Assigned(Tunel.AssignedTabSheet) then
        begin
        Tunel.AssignedTabSheet.Destroy;
        Tunel.AssignedTabSheet := nil;
        end;
    end; 

  end;
finally
  c_s.Leave;
end;
end;

procedure TL2PacketHackMain.NewPacket(var msg: TMessage);
var
  temp : SendMessageParam;
begin
c_s.Enter;
try
temp := SendMessageParam(pointer(msg.WParam)^);
fScript.ScryptProcessPacket(temp.packet, temp.FromServer, temp.Id);
if temp.Packet.Size > 2 then //плагины либо скрипты могли обнулить
if assigned(Ttunel(temp.tunel)) then
  if not Ttunel(temp.tunel).MustBeDestroyed then
    if assigned(Ttunel(temp.tunel).Visual) then
      begin
        Ttunel(temp.tunel).Visual.AddPacketToAcum(temp.Packet, temp.FromServer, Ttunel(temp.tunel).EncDec);
        PostMessage(Handle,WM_ProcessPacket,integer(@Ttunel(temp.tunel).Visual), 0);
      end;
finally
  c_s.Leave;
end;
end;

procedure TL2PacketHackMain.ProcessPacket(var msg: TMessage);
var
visual:tfvisual;
begin
  visual := TfVisual(pointer(msg.WParam)^);
  visual.processpacketfromacum;
end;

procedure TL2PacketHackMain.ReadMsg(var msg: TMessage);
var
  NewReddirectIP: Integer;
  IPb:array[0..3] of Byte absolute NewReddirectIP;
begin
c_s.Enter;
  msg.ResultHi := LocalPort;
  NewReddirectIP := msg.WParam;
  sockEngine.RedirrectIP := NewReddirectIP;
  sockEngine.RedirrectPort := msg.LParamLo;

  if Pos(IntToStr(ntohs(msg.LParamLo))+';',sIgnorePorts+';')=0 then begin
    if fSettings.ChkIntercept.Checked then
    begin
      msg.ResultLo:=1;
      AddToLog (Format(rsInjectConnectIntercepted, [IPb[0],IPb[1],IPb[2],IPb[3],ntohs(msg.LParamLo)]));
    end else
    begin
      msg.ResultLo:=0;
      AddToLog (Format(rsInjectConnectInterceptOff, [IPb[0],IPb[1],IPb[2],IPb[3],ntohs(msg.LParamLo)]));
    end;
  end else
  begin
    msg.ResultLo:=0;
    AddToLog (Format(rsInjectConnectInterceptedIgnoder, [IPb[0],IPb[1],IPb[2],IPb[3],ntohs(msg.LParamLo)]));
  end;
c_s.Leave;
end;
procedure TL2PacketHackMain.FormDestroy(Sender: TObject);
begin
c_s.Destroy;
end;

procedure TL2PacketHackMain.FormCreate(Sender: TObject);
begin
  AppPath := ExtractFilePath(Application.ExeName);
  c_s := TCriticalSection.Create;
  left := -1000;
end;

procedure TL2PacketHackMain.Action2Execute(Sender: TObject);
begin
  if GetForegroundWindow = fProcessRawLog.Handle then
    fProcessRawLog.Hide
  else
    fProcessRawLog.Show;
end;

procedure TL2PacketHackMain.Action3Execute(Sender: TObject);
begin
  if GetForegroundWindow = fSettings.Handle then
    fSettings.Hide
  else
    fSettings.Show;
end;

procedure TL2PacketHackMain.Action4Execute(Sender: TObject);
begin
  if GetForegroundWindow = fScript.Handle then
    fScript.Hide
  else
    fScript.Show;

end;

procedure TL2PacketHackMain.Action6Execute(Sender: TObject);
begin
  if GetForegroundWindow = fPacketFilter.Handle then
    fPacketFilter.Hide
  else
    fPacketFilter.Show;
end;

procedure TL2PacketHackMain.Action7Execute(Sender: TObject);
begin
  if GetForegroundWindow = fPlugins.Handle then
    fPlugins.Hide
  else
    fPlugins.Show;
end;

procedure TL2PacketHackMain.Action8Execute(Sender: TObject);
begin
if (GetForegroundWindow = UserForm.Handle) or not fMain.nUserFormShow.Enabled then
  UserForm.Hide
else
  UserForm.show;
end;

procedure TL2PacketHackMain.Action9Execute(Sender: TObject);
begin
  if fMain.Visible then fMain.BringToFront; 
end;

procedure TL2PacketHackMain.Action10Execute(Sender: TObject);
begin
if GetForegroundWindow = fLog.Handle then
  fLog.Hide
else
  fLog.Show;
end;

end.
