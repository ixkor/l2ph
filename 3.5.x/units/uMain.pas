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
    lang1: TsiLang;
    l2ph1: TMenuItem;
    lang: TsiLangDispatcher;
    N1: TMenuItem;
    N3: TMenuItem;
    Language1: TMenuItem;
    pcClientsConnection: TJvPageControl;
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
    procedure Action9Execute(Sender: TObject);
    procedure l2ph1Click(Sender: TObject);
    procedure lang1ChangeLanguage(Sender: TObject);
    procedure UpdateStrings;
    procedure pcClientsConnectionChange(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Language1Click(Sender: TObject);
  protected
    procedure CreateParams (var Params : TCreateParams); override;
  private
    { Private declarations }
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
  uMainReplacer, uPacketViewer, uLangSelectDialog;
 

{$R *.dfm}

{ TfMain }

procedure TfMain.init;
var
  ver : string;
begin
  deltemps; //Удаляем *.temp файлы
  ver := uGlobalFuncs.getversion;

  Splash.Caption := 'L2PacketHack v'+ ver;

  fMainReplacer.Status.Caption := Splash.Caption;
  fMainReplacer.Repaint;
  Application.ProcessMessages;

  fAbout.AboutMemo.Lines.Add('L2PacketHack v' + ver);
  fAbout.AboutMemo.Lines.Add('');
  fAbout.AboutMemo.Lines.Add(lang1.GetTextOrDefault('IDS_6'));
  fAbout.AboutMemo.Lines.Add('xkor,');
  fAbout.AboutMemo.Lines.Add('NLObP,');
  fAbout.AboutMemo.Lines.Add('Wanick,');
  fAbout.AboutMemo.Lines.Add('QaK,');
  fAbout.AboutMemo.Lines.Add('alexteam.');

  AddToLog(lang1.GetTextOrDefault('IDS_9' (* 'Стартует L2ph v' *) ) + ver);
  sockEngine := TSocketEngine.create;
  sockEngine.ServerPort := LocalPort;
  sockEngine.StartServer;
  sockEngine.isSocks5 := fSettings.ChkSocks5Mode.Checked;

 if Options.ReadInteger('General','dumb',0) > 10 then
 begin
 fmain.Splash.Alignment := taLeftJustify;
 fmain.Splash.Caption :=
 '  Уважаемые пользователи портала l2rus, и не столь уважаемая администрация данного портала.'#10#13+
 '        (В прочем данноЕ петициЙо направленно последним.)'#10#13+
 ''#10#13+
 '  Довожу до вашего сведения что:'#10#13+
 '  1. Удалять коментарии разработчиков направленные на то чтобы донести'#10#13+
 '       до пользователя что выложеная версия не стабильна - некрасиво'#10#13+
 '  2. При этом еще и банить аккаунт разработчика вообще нехорошо.'#10#13+
 '  3. Выкладывать софт без линки на оффорум тоже не очень.'#10#13+
 '  либо вы заимеете совесть либо она поимеет вас.'#10#13+
 ''#10#13+
 ''#10#13+
 ''#10#13+
 ''#10#13+
 ''#10#13+
 '  "не забудьте извиниццо и исправиться, иначе буду бить по  рукам" ©'#10#13+
 '       к примеру просто рубану ваш сайт у пользователей этой утилиты.'#10#13+
 '  зы.  кстати. это сообщение выскакивает только у пользователей вашего портала.'#10#13+
 '  зы2. кстати, это полностью протестированный и стабл билд. его как раз и имеет смысл качать'#10#13+
 '       С наилутшими пожеланиями. Желаю приятных кошмарикоФ.';

 end;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  UpdateStrings;
  loadpos(self);
  Randomize;
  DoubleBuffered := true;
  FillVersion_a;
  SysMsgIdList := TStringList.Create;
  ItemsList := TStringList.Create;
  NpcIdList := TStringList.Create;
  ClassIdList := TStringList.Create;
  SkillList := TStringList.Create;
  AugmentList := TStringList.Create;
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


procedure TfMain.FormDestroy(Sender: TObject);
begin
  if Assigned(sockEngine) then
    begin
      sockEngine.Destroy;
      sockEngine := nil;
    end;
  savepos(self);

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
  AugmentList.Destroy;
  AugmentList := nil;
  JvTrayIcon1.IconVisible := false;
  ExitProcess(0);
end;

procedure TfMain.nExitAppClick(Sender: TObject);
begin
  Close;
end;

procedure TfMain.nReloadPacketsIniClick(Sender: TObject);
begin
  Reload; //перечитываем инишки
  fPacketFilter.LoadPacketsIni;  //перечитываем packets.ini
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
  //ChDir(AppPath+'logs\');
  dlgOpenLog.InitialDir:=AppPath+'logs\';
  if dlgOpenLog.Execute then
  if FileExists(dlgOpenLog.FileName) then
  begin
    NewPacketLogWiev := TpacketLogWiev.create;
    NewPacketLogWiev.INIT(dlgOpenLog.FileName);
    NewPacketLogWiev.AssignedTabSheet.Show;
  end;
  //ChDir(AppPath+'settings\');
end;

procedure TfMain.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not AllowExit then
  if not (MessageDlg(pchar(
                lang1.GetTextOrDefault('IDS_18' (* 'Вы уверены что хотите выйти из программы?' *) ) + #10#13+
                lang1.GetTextOrDefault('IDS_19' (* 'Все соединения прервутся!' *) )),
                mtConfirmation,[mbYes, mbNo],0)=mrYes) then
    begin
      CanClose := false;
      exit;
    end;
    isDestroying := true;
    isGlobalDestroying := true;
    fScript.DestroyAllScripts;
    Application.Terminate;
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
    ShowWindow(fMainReplacer.Handle,sw_hide);
    ShowWindow(application.Handle,sw_hide);
  end;
end;

procedure TfMain.nExitClick(Sender: TObject);
begin
  close;
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

procedure TfMain.lang1ChangeLanguage(Sender: TObject);
begin
  UpdateStrings;
end;

procedure TfMain.N1Click(Sender: TObject);
begin
  if GetForegroundWindow = fPacketViewer.Handle then
    fPacketViewer.Hide
  else
    fPacketViewer.Show;
end;

procedure TfMain.UpdateStrings;
begin
  rsLSP_Install_success := lang1.GetTextOrDefault('strLSP_Install_success');
  rsLSP_Already_installed := lang1.GetTextOrDefault('strLSP_Already_installed');
  rsLSP_Uninstall_success := lang1.GetTextOrDefault('strLSP_Uninstall_success');
  rsLSP_Not_installed := lang1.GetTextOrDefault('strLSP_Not_installed');
  rsLSP_Install_error := lang1.GetTextOrDefault('strLSP_Install_error');
  rsLSP_UnInstall_error := lang1.GetTextOrDefault('strLSP_UnInstall_error');
  rsLSP_Install_error_badspipath := lang1.GetTextOrDefault('strLSP_Install_error_badspipath');

  RsThreadCallStack := lang1.GetTextOrDefault('strRsThreadCallStack');
  RsMainThreadCallStack := lang1.GetTextOrDefault('strRsMainThreadCallStack');
  RsMissingVersionInfo := lang1.GetTextOrDefault('strRsMissingVersionInfo');
  RsThread := lang1.GetTextOrDefault('strRsThread');
  RsActiveControl := lang1.GetTextOrDefault('strRsActiveControl');
  RsScreenRes := lang1.GetTextOrDefault('strRsScreenRes');
  RsMemory := lang1.GetTextOrDefault('strRsMemory');
  RsProcessor := lang1.GetTextOrDefault('strRsProcessor');
  RsOSVersion := lang1.GetTextOrDefault('strRsOSVersion');
  RsModulesList := lang1.GetTextOrDefault('strRsModulesList');
  RsStackList := lang1.GetTextOrDefault('strRsStackList');
  RsExceptionAddr := lang1.GetTextOrDefault('strRsExceptionAddr');
  RsExceptionMessage := lang1.GetTextOrDefault('strRsExceptionMessage');
  RsExceptionClass := lang1.GetTextOrDefault('strRsExceptionClass');
  RsAppError := lang1.GetTextOrDefault('strRsAppError');
  rsLSPDisconnectDetected := lang1.GetTextOrDefault('strrsLSPDisconnectDetected');
  rsLSPConnectionWillbeIgnored := lang1.GetTextOrDefault('strrsLSPConnectionWillbeIgnored');
  rsLSPConnectionWillbeIntercepted := lang1.GetTextOrDefault('strrsLSPConnectionWillbeIntercepted');
  rsLSPConnectionWillbeInterceptedAndRettirected := lang1.GetTextOrDefault('rsLSPConnectionWillbeInterceptedAndRettirected');
  rsLSPConnectionDetected := lang1.GetTextOrDefault('strrsLSPConnectionDetected');
  rsFailedLocalServer := lang1.GetTextOrDefault('strrsFailedLocalServer');
  rsStartLocalServer := lang1.GetTextOrDefault('strrsStartLocalServer');
  rsLoadDllSuccessfully := lang1.GetTextOrDefault('strrsLoadDllSuccessfully');
  rsLoadDllUnSuccessful := lang1.GetTextOrDefault('strrsLoadDllUnSuccessful');
  rsUnLoadDllSuccessfully := lang1.GetTextOrDefault('strrsUnLoadDllSuccessfully');
  rsClientPatched2 := lang1.GetTextOrDefault('strrsClientPatched2');
  rsClientPatched1 := lang1.GetTextOrDefault('strrsClientPatched1');
  rsClientPatched0 := lang1.GetTextOrDefault('strrsClientPatched0');
  rsConnectionName := lang1.GetTextOrDefault('strrsConnectionName');
  rsSavingPacketLog := lang1.GetTextOrDefault('strrsSavingPacketLog');
  rsTsocketEngineSocketError := lang1.GetTextOrDefault('strrsTsocketEngineSocketError');
  rsTsocketEngineError := lang1.GetTextOrDefault('strrsTsocketEngineError');
  rsSocketEngineNewConnection := lang1.GetTextOrDefault('strrsSocketEngineNewConnection');
  rsTunelClientDisconnect := lang1.GetTextOrDefault('strrsTunelClientDisconnect');
  rsTunelServerDisconnect := lang1.GetTextOrDefault('strrsTunelServerDisconnect');
  rsInjectConnectInterceptedIgnoder := lang1.GetTextOrDefault('strrsInjectConnectInterceptedIgnoder');
  rsInjectConnectInterceptOff := lang1.GetTextOrDefault('strrsInjectConnectInterceptOff');
  rsInjectConnectIntercepted := lang1.GetTextOrDefault('strrsInjectConnectIntercepted');
  rsInjectConnectInterceptedIgnoredPort := lang1.GetTextOrDefault('strrsInjectConnectInterceptedIgnoredPort');
  rsTunelTimeout := lang1.GetTextOrDefault('strrsTunelTimeout');
  rsTunelConnected := lang1.GetTextOrDefault('strrsTunelConnected');
  rsTunelConnectedProxyUse := lang1.GetTextOrDefault('strrsTunelConnectedProxyUse');
  rsTunelConnecting := lang1.GetTextOrDefault('strrsTunelConnecting');
  rsTunelDestroy := lang1.GetTextOrDefault('strrsTunelDestroy');
  rsTunelRUN := lang1.GetTextOrDefault('strrsTunelRUN');
  rsTunelCreated := lang1.GetTextOrDefault('strrsTunelCreated');
  rstunel := lang1.GetTextOrDefault('strrsTunel');
  rsSocks5Check := lang1.GetTextOrDefault('strrsSocks5Check');

  rs100 := lang1.GetTextOrDefault('strrs100');
  rs101 := lang1.GetTextOrDefault('strrs101');
  rs102 := lang1.GetTextOrDefault('strrs102');
  rs103 := lang1.GetTextOrDefault('strrs103');
  rs104 := lang1.GetTextOrDefault('strrs104');
  rs105 := lang1.GetTextOrDefault('strrs105');
  rs106 := lang1.GetTextOrDefault('strrs106');
  rs107 := lang1.GetTextOrDefault('strrs107');
  rs108 := lang1.GetTextOrDefault('strrs108');
  rs109 := lang1.GetTextOrDefault('strrs109');
  rs110 := lang1.GetTextOrDefault('strrs110');
  rs111 := lang1.GetTextOrDefault('strrs111');
  rs112 := lang1.GetTextOrDefault('strrs112');
  rs113 := lang1.GetTextOrDefault('strrs113');
  rs114 := lang1.GetTextOrDefault('strrs114');
  rs115 := lang1.GetTextOrDefault('strrs115');
  rsLSPSOCKSMODE := lang1.GetTextOrDefault('strrsLSPSOCKSMODE');
  rsProxyServerOk := lang1.GetTextOrDefault('strrsProxyServerOk');
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

procedure TfMain.Language1Click(Sender: TObject);
begin
  fLangSelectDialog.show;
end;

end.




