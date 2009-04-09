unit uMain;

interface

uses
  uSharedStructs,
  uGlobalFuncs,
  uResourceStrings,
  advApiHook,
  SyncObjs,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ComCtrls, Menus, XPMan, JvExComCtrls, JvComCtrls, JvExControls, JvLabel,
  ExtCtrls, AppEvnts, Dialogs, JvComponentBase, JvTrayIcon, siComp,
  ActnList;

type
  TL2PacketHackMain = class(TForm)
    StatusBar1: TStatusBar;
    XPManifest1: TXPManifest;
    MainMenu1: TMainMenu;
    nFile: TMenuItem;
    nSettings: TMenuItem;
    N11: TMenuItem;
    nExitApp: TMenuItem;
    nHelp: TMenuItem;
    nAboutDlgShow: TMenuItem;
    nAdditional: TMenuItem;
    nProcessesShow: TMenuItem;
    nConvertorShow: TMenuItem;
    pcClientsConnection: TJvPageControl;
    nPscketFilterShow: TMenuItem;
    Splash: TJvLabel;
    UnUsedObjectsDestroyer: TTimer;
    nReloadPacketsIni: TMenuItem;
    N2: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    nUserFormShow: TMenuItem;
    N6: TMenuItem;
    nOpenPlog: TMenuItem;
    dlgOpenLog: TOpenDialog;
    nOpenRawLog: TMenuItem;
    nAutomation: TMenuItem;
    nScriptsShow: TMenuItem;
    nPluginsShow: TMenuItem;
    trayMenu: TPopupMenu;
    nScripts: TMenuItem;
    MenuItem1: TMenuItem;
    nPlugins: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem4: TMenuItem;
    nExit: TMenuItem;
    JvTrayIcon1: TJvTrayIcon;
    nShowHide: TMenuItem;
    N14: TMenuItem;
    nLanguage: TMenuItem;
    lang: TsiLang;
    RusLang: TMenuItem;
    EngLang: TMenuItem;
    ActionList1: TActionList;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    Action9: TAction;
    Action10: TAction;
    l2ph1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure nSettingsClick(Sender: TObject);
    procedure nProcessesShowClick(Sender: TObject);
    procedure nConvertorShowClick(Sender: TObject);
    procedure nPscketFilterShowClick(Sender: TObject);
    procedure nAboutDlgShowClick(Sender: TObject);
    procedure UnUsedObjectsDestroyerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure nExitAppClick(Sender: TObject);
    procedure nReloadPacketsIniClick(Sender: TObject);
    procedure nUserFormShowClick(Sender: TObject);
    procedure nOpenPlogClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure nOpenRawLogClick(Sender: TObject);
    procedure nPluginsShowClick(Sender: TObject);
    procedure nScriptsShowClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure JvTrayIcon1Click(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure nShowHideClick(Sender: TObject);
    procedure nExitClick(Sender: TObject);
    procedure RusLangClick(Sender: TObject);
    procedure EngLangClick(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure l2ph1Click(Sender: TObject);
    procedure langChangeLanguage(Sender: TObject);
    procedure UpdateStrings;
  protected
    procedure CreateParams (var Params : TCreateParams); override;
  private
    { Private declarations }
    procedure NewPacket(var msg: TMessage); Message WM_NewPacket;
    procedure ProcessPacket(var msg: TMessage); Message WM_ProcessPacket;
    procedure NewAction(var msg: TMessage); Message WM_NewAction;
    procedure ReadMsg(var msg: TMessage); Message WM_Dll_Log;
  public
    { Public declarations }
    Procedure init;

  end;
  pstr = ^string;

var
  L2PacketHackMain: TL2PacketHackMain;
  c_s : TCriticalSection;

implementation
uses uPlugins, uPluginData, usocketengine, winsock, uEncDec, uVisualContainer,
  uSettingsDialog, uLogForm, uConvertForm, uFilterForm, uProcesses,
  uAboutDialog, uData, uUserForm, uProcessRawLog, uScripts, Math;
 

{$R *.dfm}

{ TfMain }

procedure TL2PacketHackMain.init;
var
  ver : string;
begin
  deltemps; //Удаляем *.temp файлы

  ver := uGlobalFuncs.getversion;
  Splash.Caption := 'L2PacketHack v'+ ver +#10#13#10#13+'[No Connections]';
  Caption := 'L2PacketHack v' + ver + ' by CoderX.ru Team';
  fAbout.Memo1.Lines.Insert(0, lang.GetTextOrDefault('IDS_6' (* 'Поддержать проект:' *) ));
  fAbout.Memo1.Lines.Insert(0,'');
  fAbout.Memo1.Lines.Insert(0, ' by CoderX.ru Team');
  fAbout.Memo1.Lines.Insert(0,'L2PacketHack v' + ver);




  AddToLog(lang.GetTextOrDefault('IDS_9' (* 'Стартует L2ph v' *) ) + ver);
  sockEngine := TSocketEngine.create;
  sockEngine.ServerPort := htons(LocalPort);
  sockEngine.StartServer;
  sockEngine.isSocks5 := false;//Можно менять в процессе работы, на текущие нити влять не будет
end;



procedure TL2PacketHackMain.FormCreate(Sender: TObject);
begin
  UpdateStrings;
  loadpos(self);
  Randomize;
  HookCode(@ShowMessage,@ShowMessageNew,@ShowMessageOld);
  c_s := TCriticalSection.Create;
  DoubleBuffered := true;
  FillVersion_a;
  SysMsgIdList := TStringList.Create;
  ItemsList := TStringList.Create;
  NpcIdList := TStringList.Create;
  ClassIdList := TStringList.Create;
  SkillList := TStringList.Create;
  Reload;

end;

procedure TL2PacketHackMain.nSettingsClick(Sender: TObject);
begin
  if GetForegroundWindow = fSettings.Handle then
    fSettings.Hide
  else
    fSettings.Show;
end;

procedure TL2PacketHackMain.nProcessesShowClick(Sender: TObject);
begin
fProcesses.Show;
end;

procedure TL2PacketHackMain.nConvertorShowClick(Sender: TObject);
begin
  if GetForegroundWindow = fConvert.Handle then
    fConvert.Hide
  else
    fConvert.Show;
end;

procedure TL2PacketHackMain.nPscketFilterShowClick(Sender: TObject);
begin
  if GetForegroundWindow = fPacketFilter.Handle then
    fPacketFilter.Hide
  else
    fPacketFilter.Show;
end;

procedure TL2PacketHackMain.nAboutDlgShowClick(Sender: TObject);
begin
fAbout.show;
end;

procedure TL2PacketHackMain.UnUsedObjectsDestroyerTimer(Sender: TObject);
begin
  if Assigned(sockEngine) then sockEngine.destroyDeadTunels;
  if Assigned(dmData) then dmData.destroyDeadLSPConnections;
  if Assigned(dmData) then dmData.destroyDeadLogWievs;
  //Убираем пейджконтрол если нет закладок
  if pcClientsConnection.Visible then
    if pcClientsConnection.ActivePage = nil then
      pcClientsConnection.Hide;

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
    Tunel.AssignedTabSheet := TTabSheet.Create(pcClientsConnection);
    Tunel.Visual := TfVisual.Create(Tunel.AssignedTabSheet);
    Tunel.Visual.currentLSP := nil;
    Tunel.Visual.CurrentTpacketLog := nil;
    Tunel.Visual.currenttunel := Tunel;
    Tunel.AssignedTabSheet.Caption := Tunel.CharName;
    tunel.Visual.init;
    Tunel.NeedDeinit := true;

    Tunel.Visual.setNofreeBtns(GlobalNoFreeAfterDisconnect);
    Tunel.Visual.Parent := Tunel.AssignedTabSheet;
    Tunel.AssignedTabSheet.PageControl := pcClientsConnection;
    Tunel.active := true;

    if not pcClientsConnection.Visible then pcClientsConnection.Visible  := true;

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

procedure TL2PacketHackMain.FormDestroy(Sender: TObject);
begin
  savepos(self);
  isGlobalDestroying := true;
  UnhookCode(@ShowMessageOld);
  c_s.Destroy;
  if Assigned(sockEngine) then
    begin
      sockEngine.destroy;
      sockEngine := nil;
    end;

  SysMsgIdList.Destroy;
  SysMsgIdList := nil;
  ItemsList.Destroy;
  ItemsList := nil;
  NpcIdList.Destroy;
  NpcIdList := nil;
  ClassIdList.Destroy;
  ClassIdList := nil;
  SkillList.Destroy;
  SkillList := nil;

end;

procedure TL2PacketHackMain.nExitAppClick(Sender: TObject);
begin
  Close;
end;

procedure TL2PacketHackMain.nReloadPacketsIniClick(Sender: TObject);
begin
  Reload;
  fPacketFilter.refreshexisting;
end;

procedure TL2PacketHackMain.nUserFormShowClick(Sender: TObject);
begin
if (GetForegroundWindow = UserForm.Handle) or not nUserFormShow.Enabled then
  UserForm.Hide
else
  UserForm.show;
end;

procedure TL2PacketHackMain.nOpenPlogClick(Sender: TObject);
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
  if MessageDlg(pchar(
                lang.GetTextOrDefault('IDS_18' (* 'Вы уверены что хотите выйти из программы?' *) ) + #10#13+
                lang.GetTextOrDefault('IDS_19' (* 'Все соединения прервутся!' *) )),
                mtConfirmation,[mbYes, mbNo],0)=mrYes then Application.Terminate;
  CanClose:=False;
end;

procedure TL2PacketHackMain.nOpenRawLogClick(Sender: TObject);
begin
  if GetForegroundWindow = fProcessRawLog.Handle then
    fProcessRawLog.Hide
  else
    fProcessRawLog.Show;
end;

procedure TL2PacketHackMain.nPluginsShowClick(Sender: TObject);
begin
  if GetForegroundWindow = fPlugins.Handle then
    fPlugins.Hide
  else
    fPlugins.Show;

end;

procedure TL2PacketHackMain.nScriptsShowClick(Sender: TObject);
begin
  if GetForegroundWindow = fScript.Handle then
    fScript.Hide
  else
    fScript.Show;
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
{ TODO : При переключении с другого приложение на пх - в таскбаре не активируется кнопка. }
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TL2PacketHackMain.JvTrayIcon1Click(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
{if Button = mbLeft then
if L2PacketHackMain.Visible then SetForegroundWindow(L2PacketHackMain.Handle);}
end;

procedure TL2PacketHackMain.nShowHideClick(Sender: TObject);
begin
  if JvTrayIcon1.ApplicationVisible then
    JvTrayIcon1.HideApplication
  else
    begin
    JvTrayIcon1.ShowApplication;
    SetForegroundWindow(L2PacketHackMain.Handle);
    end;
end;

procedure TL2PacketHackMain.nExitClick(Sender: TObject);
begin
close;
end;

procedure TL2PacketHackMain.RusLangClick(Sender: TObject);
begin
EngLang.Checked := False;
lang.Language := 'Rus';
end;

procedure TL2PacketHackMain.EngLangClick(Sender: TObject);
begin
EngLang.Checked := true;
lang.Language := 'Eng';
end;

procedure TL2PacketHackMain.Action9Execute(Sender: TObject);
begin
  if Visible then BringToFront; 
end;

procedure TL2PacketHackMain.l2ph1Click(Sender: TObject);
begin
if GetForegroundWindow = fLog.Handle then
  fLog.Hide
else
  fLog.Show;
end;

procedure TL2PacketHackMain.ProcessPacket(var msg: TMessage);
var
visual:tfvisual;
begin
  visual := TfVisual(pointer(msg.WParam)^);
  visual.processpacketfromacum;
end;

procedure TL2PacketHackMain.langChangeLanguage(Sender: TObject);
var
  i : integer;
begin
  if not assigned(fSettings) then exit;
  if not fSettings.InterfaceEnabled then exit;
  fSettings.lang.Language := lang.Language;

  //переводим все фреймы (изврат?)
  fProcessRawLog.visual.Translate;
  if Assigned(LSPConnections) then
  for i := 0 to LSPConnections.Count -1 do
    TlspConnection(LSPConnections.Items[i]).Visual.Translate;

  if Assigned(sockEngine) then
  for i := 0 to sockEngine.tunels.Count -1 do
    Ttunel(sockEngine.tunels.Items[i]).Visual.Translate;
    
  if Assigned(PacketLogWievs) then
  for i := 0 to PacketLogWievs.Count -1 do
    TpacketLogWiev(PacketLogWievs.Items[i]).Visual.Translate;
  //
  fProcessRawLog.lang.Language := lang.Language;
  if assigned(Options) then
    begin
      Options.WriteString('General','language',lang.Language);
      Options.UpdateFile;
    end;
  fProcesses.lang.Language := lang.Language;
  fScript.lang.Language := lang.Language;
  fPlugins.lang.Language := lang.Language;       
  fLog.lang.Language := lang.Language;
  fPacketFilter.lang.Language := lang.Language;
  fConvert.lang.Language := lang.Language;
  fAbout.lang.Language := lang.Language;
  dmData.lang.Language := lang.Language;

  UpdateStrings;
end;

procedure TL2PacketHackMain.UpdateStrings;
begin
  RsThreadCallStack := lang.GetTextOrDefault('strRsThreadCallStack');
  RsMainThreadCallStack := lang.GetTextOrDefault('strRsMainThreadCallStack');
  RsMissingVersionInfo := lang.GetTextOrDefault('strRsMissingVersionInfo');
  RsThread := lang.GetTextOrDefault('strRsThread');
  RsActiveControl := lang.GetTextOrDefault('strRsActiveControl');
  RsScreenRes := lang.GetTextOrDefault('strRsScreenRes');
  RsMemory := lang.GetTextOrDefault('strRsMemory');
  RsProcessor := lang.GetTextOrDefault('strRsProcessor');
  RsOSVersion := lang.GetTextOrDefault('strRsOSVersion');
  RsModulesList := lang.GetTextOrDefault('strRsModulesList');
  RsStackList := lang.GetTextOrDefault('strRsStackList');
  RsExceptionAddr := lang.GetTextOrDefault('strRsExceptionAddr');
  RsExceptionMessage := lang.GetTextOrDefault('strRsExceptionMessage');
  RsExceptionClass := lang.GetTextOrDefault('strRsExceptionClass');
  RsAppError := lang.GetTextOrDefault('strRsAppError');
  rsLSPDisconnectDetected := lang.GetTextOrDefault('strrsLSPDisconnectDetected');
  rsLSPConnectionWillbeIgnored := lang.GetTextOrDefault('strrsLSPConnectionWillbeIgnored');
  rsLSPConnectionWillbeIntercepted := lang.GetTextOrDefault('strrsLSPConnectionWillbeIntercepted');
  rsLSPConnectionDetected := lang.GetTextOrDefault('strrsLSPConnectionDetected');
  rsFailedLocalServer := lang.GetTextOrDefault('strrsFailedLocalServer');
  rsStartLocalServer := lang.GetTextOrDefault('strrsStartLocalServer');
  rsLoadDllSuccessfully := lang.GetTextOrDefault('strrsLoadDllSuccessfully');
  rsLoadDllUnSuccessful := lang.GetTextOrDefault('strrsLoadDllUnSuccessful');
  rsUnLoadDllSuccessfully := lang.GetTextOrDefault('strrsUnLoadDllSuccessfully');
  rsClientPatched2 := lang.GetTextOrDefault('strrsClientPatched2');
  rsClientPatched1 := lang.GetTextOrDefault('strrsClientPatched1');
  rsClientPatched0 := lang.GetTextOrDefault('strrsClientPatched0');
  rsConnectionName := lang.GetTextOrDefault('strrsConnectionName');
  rsSavingPacketLog := lang.GetTextOrDefault('strrsSavingPacketLog');
  rsTsocketEngineSocketError := lang.GetTextOrDefault('strrsTsocketEngineSocketError');
  rsTsocketEngineError := lang.GetTextOrDefault('strrsTsocketEngineError');
  rsSocketEngineNewConnection := lang.GetTextOrDefault('strrsSocketEngineNewConnection');
  rsTunelClientDisconnect := lang.GetTextOrDefault('strrsTunelClientDisconnect');
  rsTunelServerDisconnect := lang.GetTextOrDefault('strrsTunelServerDisconnect');
  rsInjectConnectInterceptedIgnoder := lang.GetTextOrDefault('strrsInjectConnectInterceptedIgnoder');
  rsInjectConnectInterceptOff := lang.GetTextOrDefault('strrsInjectConnectInterceptOff');
  rsInjectConnectIntercepted := lang.GetTextOrDefault('strrsInjectConnectIntercepted');
  rsTunelTimeout := lang.GetTextOrDefault('strrsTunelTimeout');
  rsTunelConnected := lang.GetTextOrDefault('strrsTunelConnected');
  rsTunelConnecting := lang.GetTextOrDefault('strrsTunelConnecting');
  rsTunelDestroy := lang.GetTextOrDefault('strrsTunelDestroy');
  rsTunelRUN := lang.GetTextOrDefault('strrsTunelRUN');
  rsTunelCreated := lang.GetTextOrDefault('strrsTunelCreated');
end;

end.




