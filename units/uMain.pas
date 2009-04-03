unit uMain;

interface

uses
  uSharedStructs,
  uGlobalFuncs,
  uResourceStrings,
  advApiHook,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ComCtrls, Menus, XPMan, JvExComCtrls, JvComCtrls, JvExControls, JvLabel,
  ExtCtrls, AppEvnts, Dialogs, JvComponentBase, JvTrayIcon;

type
  TL2PacketHackMain = class(TForm)
    StatusBar1: TStatusBar;
    XPManifest1: TXPManifest;
    MainMenu1: TMainMenu;
    N4: TMenuItem;
    N10: TMenuItem;
    Log1: TMenuItem;
    N11: TMenuItem;
    N5: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    l1: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    pcClientsConnection: TJvPageControl;
    N1: TMenuItem;
    JvLabel1: TJvLabel;
    UnUsedObjectsDestroyer: TTimer;
    packetsini1: TMenuItem;
    N2: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    ShowUserForm: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    dlgOpenLog: TOpenDialog;
    RAW1: TMenuItem;
    N3: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    trayMenu: TPopupMenu;
    nScripts: TMenuItem;
    MenuItem1: TMenuItem;
    nPlugins: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    JvTrayIcon1: TJvTrayIcon;
    dasdas1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure Log1Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure UnUsedObjectsDestroyerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure packetsini1Click(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure ShowUserFormClick(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RAW1Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure JvTrayIcon1Click(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dasdas1Click(Sender: TObject);
  protected
    procedure CreateParams (var Params : TCreateParams); override;
  private
    { Private declarations }
    procedure NewPacket(var msg: TMessage); Message WM_NewPacket;
    procedure NewAction(var msg: TMessage); Message WM_NewAction;
    procedure ReadMsg(var msg: TMessage); Message WM_Dll_Log;
  public
    { Public declarations }
    Procedure init;

  end;
  pstr = ^string;

var
  L2PacketHackMain: TL2PacketHackMain;

implementation
uses uPlugins, uPluginData, usocketengine, winsock, uEncDec, uVisualContainer,
  uSettingsDialog, uLogForm, uConvertForm, uFilterForm, uProcesses,
  uAboutDialog, uData, uUserForm, uProcessRawLog, uScripts;
 

{$R *.dfm}

{ TfMain }

procedure TL2PacketHackMain.init;
var
  ver : string;
begin
  ver := uGlobalFuncs.getversion;
  JvLabel1.Caption := 'L2PacketHack v' + ver + 'a'+#10#13#10#13+'[Нет соединений]';
  Caption := 'L2PacketHack v' + ver + ' by CoderX.ru Team';
  fAbout.Memo1.Clear;
  fAbout.Memo1.Lines.Add('L2PacketHack v' + ver);
  fAbout.Memo1.Lines.Add('by CoderX.ru Team');
  fAbout.Memo1.Lines.Add('');
  fAbout.Memo1.Lines.Add('Поддержать проект:');
  fAbout.Memo1.Lines.Add('Z245193560959, R183025505328');
  fAbout.Memo1.Lines.Add('E360790044610, U392200550010');
  AddToLog('Стартует L2ph v' + ver);
  sockEngine := TSocketEngine.create;
  sockEngine.ServerPort := htons(LocalPort);
  sockEngine.StartServer;
  sockEngine.isSocks5 := false;//Можно менять в процессе работы, на текущие нити влять не будет

  //размер формы
  Top :=Options.ReadInteger('General','Top',0);
  Left :=Options.ReadInteger('General','Left',600);
  Width :=Options.ReadInteger('General','Widht',700);
  Height :=Options.ReadInteger('General','Heigth',960);

end;



procedure TL2PacketHackMain.FormCreate(Sender: TObject);
begin
  HookCode(@ShowMessage,@ShowMessageNew,@ShowMessageOld);
  DoubleBuffered := true;
  FillVersion_a;
  SysMsgIdList := TStringList.Create;
  ItemsList := TStringList.Create;
  NpcIdList := TStringList.Create;
  ClassIdList := TStringList.Create;
  SkillList := TStringList.Create;
  Reload;

end;

procedure TL2PacketHackMain.N10Click(Sender: TObject);
begin
fSettings.Show;
end;

procedure TL2PacketHackMain.Log1Click(Sender: TObject);
begin
fLog.Show;
end;

procedure TL2PacketHackMain.N12Click(Sender: TObject);
begin
fProcesses.Show;
end;

procedure TL2PacketHackMain.N13Click(Sender: TObject);
begin
fConvert.Show;
end;

procedure TL2PacketHackMain.N1Click(Sender: TObject);
begin
fPacketFilter.show;
end;

procedure TL2PacketHackMain.N9Click(Sender: TObject);
begin
fAbout.show;
end;

procedure TL2PacketHackMain.UnUsedObjectsDestroyerTimer(Sender: TObject);
begin
  if Assigned(sockEngine) then sockEngine.destroyDeadTunels;
  if Assigned(dmData) then dmData.destroyDeadLSPConnections;
  if Assigned(dmData) then dmData.destroyDeadLogWievs;
end;

procedure TL2PacketHackMain.ReadMsg(var msg: TMessage);
var
  NewReddirectIP: Integer;
  IPb:array[0..3] of Byte absolute NewReddirectIP;
begin
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
end;


procedure TL2PacketHackMain.NewPacket(var msg: TMessage);
var
  Packet : TPacket;
  FromServer : boolean;
  Tunel : Ttunel;
begin
  packet := TencDec(msg.LParam).Packet;
  FromServer := boolean(msg.WParam);

  if assigned(TencDec(msg.LParam).ParentTtunel) then
  begin
    Tunel := Ttunel(TencDec(msg.LParam).ParentTtunel);
    fScript.ScryptProcessPacket(Packet, FromServer, TencDec(msg.LParam)); //отсылаем плагинам и скриптам
    if Packet.Size > 2 then //плагины либо скрипты могли обнулить
    Tunel.Visual.NewPacket(Packet, FromServer, TencDec(msg.LParam), -1);
  end;
end;

procedure TL2PacketHackMain.NewAction(var msg: TMessage);
var
  Tunel : Ttunel;
  EncDec : TencDec;
  SocketEngine : TSocketEngine;
  action : byte;
  i:integer;

begin
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




    end; //данные в name; обработчик - UpdateComboBox1 (требует видоизменения)
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
      Tunel.AssignedTabSheet := TTabSheet.Create(pcClientsConnection);
      Tunel.Visual := TfVisual.Create(Tunel.AssignedTabSheet);
      Tunel.Visual.setNofreeBtns(GlobalNoFreeAfterDisconnect);
      Tunel.Visual.Parent := Tunel.AssignedTabSheet;
      Tunel.AssignedTabSheet.PageControl := pcClientsConnection;
      Tunel.AssignedTabSheet.Caption := Tunel.CharName;
      Tunel.Visual.currentLSP := nil;
      Tunel.Visual.CurrentTpacketLog := nil;
      Tunel.Visual.currenttunel := Tunel;
      tunel.Visual.init;
      Tunel.active := true;
      if not pcClientsConnection.Visible then pcClientsConnection.Visible  := true;
      
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
      tunel.Visual.deinit;
      if Assigned(Tunel.Visual) then Tunel.Visual.Destroy;
      if Assigned(Tunel.AssignedTabSheet) then Tunel.AssignedTabSheet.Destroy;
    end; 

  end;
end;

procedure TL2PacketHackMain.FormDestroy(Sender: TObject);
begin
  UnhookCode(@ShowMessageOld); 
if Assigned(sockEngine) then
  sockEngine.destroy;
  SysMsgIdList.Destroy;
  ItemsList.Destroy;
  NpcIdList.Destroy;
  ClassIdList.Destroy;
  SkillList.Destroy;

end;

procedure TL2PacketHackMain.N5Click(Sender: TObject);
begin
  Close;
end;

procedure TL2PacketHackMain.packetsini1Click(Sender: TObject);
begin
  Reload;
end;

procedure TL2PacketHackMain.ApplicationEvents1Hint(Sender: TObject);
begin
  StatusBar1.SimpleText := Application.Hint;
end;

procedure TL2PacketHackMain.ShowUserFormClick(Sender: TObject);
begin
UserForm.show;
end;

procedure TL2PacketHackMain.N7Click(Sender: TObject);
var
  NewPacketLogWiev : TpacketLogWiev;
begin
  if dlgOpenLog.Execute then
  if FileExists(dlgOpenLog.FileName) then
  begin
    NewPacketLogWiev := TpacketLogWiev.create;
    NewPacketLogWiev.INIT(dlgOpenLog.FileName);
  end;
end;

procedure TL2PacketHackMain.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if AllowExit then Application.Terminate;
  if MessageDlg('Вы уверены что хотите выйти из программы?'#10#13'Все соединения прервутся!',mtConfirmation,[mbYes, mbNo],0)=mrYes then Application.Terminate;
  CanClose:=False;
end;

procedure TL2PacketHackMain.RAW1Click(Sender: TObject);
begin
fProcessRawLog.Show;
end;

procedure TL2PacketHackMain.N17Click(Sender: TObject);
begin
//ShowMessage('Недоработано. временно отключил.');
fPlugins.Show;
end;

procedure TL2PacketHackMain.N16Click(Sender: TObject);
begin
fScript.show;
//ShowMessage('Глобальные скрипты еще даже не начинал делать.. отладка имеющегося кода. эта опция не работает. ждите.');
end;

procedure TL2PacketHackMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    ExStyle := ExStyle OR WS_EX_APPWINDOW;
end;

procedure TL2PacketHackMain.FormActivate(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TL2PacketHackMain.JvTrayIcon1Click(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
{if Button = mbLeft then
if L2PacketHackMain.Visible then SetForegroundWindow(L2PacketHackMain.Handle);}
end;

procedure TL2PacketHackMain.dasdas1Click(Sender: TObject);
begin
  if JvTrayIcon1.ApplicationVisible then
    JvTrayIcon1.HideApplication
  else
    begin
    JvTrayIcon1.ShowApplication;
    SetForegroundWindow(L2PacketHackMain.Handle);
    end;
end;

end.
