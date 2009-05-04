unit uMain;

interface

uses
  uSharedStructs,
  uGlobalFuncs,
  uResourceStrings,
  advApiHook,
  SyncObjs,
  Windows,
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ComCtrls, Menus, XPMan, JvExComCtrls, JvComCtrls, JvExControls, JvLabel,
  ExtCtrls, Dialogs, JvComponentBase, JvTrayIcon, siComp,
  JvCaptionButton;

type
  TfMain = class(TForm)
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
    procedure nShowHideClick(Sender: TObject);
    procedure nExitClick(Sender: TObject);
    procedure RusLangClick(Sender: TObject);
    procedure EngLangClick(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure l2ph1Click(Sender: TObject);
    procedure langChangeLanguage(Sender: TObject);
    procedure UpdateStrings;
    procedure pcClientsConnectionChange(Sender: TObject);
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
  fMain: TfMain;

implementation
uses uPlugins, uPluginData, usocketengine, winsock, uEncDec, uVisualContainer,
  uSettingsDialog, uLogForm, uConvertForm, uFilterForm, uProcesses,
  uAboutDialog, uData, uUserForm, uProcessRawLog, uScripts, Math,
  uMainReplacer;
 

{$R *.dfm}

{ TfMain }

procedure TfMain.init;
var
  ver : string;
begin
  deltemps; //Удаляем *.temp файлы
  JvTrayIcon1.ShowApplication;
  ShowWindow(L2PacketHackMain.Handle,sw_hide);
  ShowWindow(application.Handle,sw_hide);

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



procedure TfMain.FormCreate(Sender: TObject);
begin
  UpdateStrings;
  loadpos(self);
  Randomize;
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

procedure TfMain.nSettingsClick(Sender: TObject);
begin
  if GetForegroundWindow = fSettings.Handle then
    fSettings.Hide
  else
    fSettings.Show;
end;

procedure TfMain.nProcessesShowClick(Sender: TObject);
begin
fProcesses.Show;
end;

procedure TfMain.nConvertorShowClick(Sender: TObject);
begin
  if GetForegroundWindow = fConvert.Handle then
    fConvert.Hide
  else
    fConvert.Show;
end;

procedure TfMain.nPscketFilterShowClick(Sender: TObject);
begin
  if GetForegroundWindow = fPacketFilter.Handle then
    fPacketFilter.Hide
  else
    fPacketFilter.Show;
end;

procedure TfMain.nAboutDlgShowClick(Sender: TObject);
begin
fAbout.show;
end;

procedure TfMain.UnUsedObjectsDestroyerTimer(Sender: TObject);
begin
  if Assigned(sockEngine) then sockEngine.destroyDeadTunels;
  if Assigned(dmData) then dmData.destroyDeadLSPConnections;
  if Assigned(dmData) then dmData.destroyDeadLogWievs;
  //Убираем пейджконтрол если нет закладок
  if pcClientsConnection.Visible then
    if pcClientsConnection.ActivePage = nil then
      pcClientsConnection.Hide;

end;

procedure TfMain.ReadMsg(var msg: TMessage);
begin
end;


procedure TfMain.NewPacket(var msg: TMessage);
begin
end;

procedure TfMain.NewAction(var msg: TMessage);
begin
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  savepos(self);
  isGlobalDestroying := true;
  UnhookCode(@ShowMessageOld);

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

procedure TfMain.nExitAppClick(Sender: TObject);
begin
  Close;
end;

procedure TfMain.nReloadPacketsIniClick(Sender: TObject);
begin
  Reload;
  fPacketFilter.refreshexisting;
end;

procedure TfMain.nUserFormShowClick(Sender: TObject);
begin
if (GetForegroundWindow = UserForm.Handle) or not nUserFormShow.Enabled then
  UserForm.Hide
else
  UserForm.show;
end;

procedure TfMain.nOpenPlogClick(Sender: TObject);
var
  NewPacketLogWiev : TpacketLogWiev;
begin
  if dlgOpenLog.Execute then
  if FileExists(dlgOpenLog.FileName) then
  begin
    NewPacketLogWiev := TpacketLogWiev.create;
    NewPacketLogWiev.INIT(dlgOpenLog.FileName);
    NewPacketLogWiev.AssignedTabSheet.Show;
  end;
end;

procedure TfMain.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if AllowExit then Application.Terminate;
  if MessageDlg(pchar(
                lang.GetTextOrDefault('IDS_18' (* 'Вы уверены что хотите выйти из программы?' *) ) + #10#13+
                lang.GetTextOrDefault('IDS_19' (* 'Все соединения прервутся!' *) )),
                mtConfirmation,[mbYes, mbNo],0)=mrYes then Application.Terminate;
  CanClose:=False;
end;

procedure TfMain.nOpenRawLogClick(Sender: TObject);
begin
  if GetForegroundWindow = fProcessRawLog.Handle then
    fProcessRawLog.Hide
  else
    fProcessRawLog.Show;
end;

procedure TfMain.nPluginsShowClick(Sender: TObject);
begin
  if GetForegroundWindow = fPlugins.Handle then
    fPlugins.Hide
  else
    fPlugins.Show;

end;

procedure TfMain.nScriptsShowClick(Sender: TObject);
begin
  if GetForegroundWindow = fScript.Handle then
    fScript.Hide
  else
    fScript.Show;
end;

procedure TfMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    ExStyle := ExStyle OR WS_EX_APPWINDOW or WS_EX_CONTROLPARENT;
end;

procedure TfMain.nShowHideClick(Sender: TObject);
begin
  if JvTrayIcon1.ApplicationVisible then
    JvTrayIcon1.HideApplication
  else
    begin
    JvTrayIcon1.ShowApplication;
    ShowWindow(L2PacketHackMain.Handle,sw_hide);
    ShowWindow(application.Handle,sw_hide);
    end;
end;

procedure TfMain.nExitClick(Sender: TObject);
begin
close;
end;

procedure TfMain.RusLangClick(Sender: TObject);
begin
EngLang.Checked := False;
lang.Language := 'Rus';
end;

procedure TfMain.EngLangClick(Sender: TObject);
begin
EngLang.Checked := true;
lang.Language := 'Eng';
end;

procedure TfMain.Action9Execute(Sender: TObject);
begin
  if Visible then BringToFront; 
end;

procedure TfMain.l2ph1Click(Sender: TObject);
begin
if GetForegroundWindow = fLog.Handle then
  fLog.Hide
else
  fLog.Show;
end;

procedure TfMain.ProcessPacket(var msg: TMessage);
begin
end;

procedure TfMain.langChangeLanguage(Sender: TObject);
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

procedure TfMain.UpdateStrings;
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

procedure TfMain.pcClientsConnectionChange(Sender: TObject);
begin
if Assigned(pcClientsConnection.ActivePage) then 
  if pcClientsConnection.ActivePage.ComponentCount > 0 then
  begin
    TfVisual(pcClientsConnection.ActivePage.Components[0]).show;
    TfVisual(pcClientsConnection.ActivePage.Components[0]).Repaint;
    TfVisual(pcClientsConnection.ActivePage.Components[0]).Invalidate;
  end;
end;

end.




