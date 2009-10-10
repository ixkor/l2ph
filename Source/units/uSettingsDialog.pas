unit uSettingsDialog;

interface

uses
  uResourceStrings, 
  usharedstructs,
  uglobalfuncs,
  winsock,
  math, 
  IniFiles, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, JvExMask, JvSpin, ComCtrls, siComp,
  Buttons;

type
  TfSettings = class(TForm)
    PageControl3: TPageControl;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    isInject: TLabeledEdit;
    HookMethod: TRadioGroup;
    ChkIntercept: TCheckBox;
    JvSpinEdit1: TJvSpinEdit;
    ChkSocks5Mode: TCheckBox;
    iInject: TCheckBox;
    ChkLSPIntercept: TCheckBox;
    isLSP: TLabeledEdit;
    Panel1: TPanel;
    Panel3: TPanel;
    Button1: TButton;
    Button2: TButton;
    rgProtocolVersion: TRadioGroup;
    GroupBox1: TGroupBox;
    ChkNoDecrypt: TCheckBox;
    ChkChangeXor: TCheckBox;
    ChkKamael: TCheckBox;
    ChkGraciaOff: TCheckBox;
    iNewxor: TCheckBox;
    TabSheet1: TTabSheet;
    ChkAllowExit: TCheckBox;
    ChkShowLogWinOnStart: TCheckBox;
    lang: TsiLang;
    Bevel4: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    JvSpinEdit2: TJvSpinEdit;
    isIgnorePorts: TLabeledEdit;
    isClientsList: TLabeledEdit;
    GroupBox2: TGroupBox;
    chkAutoSavePlog: TCheckBox;
    ChkHexViewOffset: TCheckBox;
    ChkShowLastPacket: TCheckBox;
    chkRaw: TCheckBox;
    chkNoFree: TCheckBox;
    btnNewXor: TSpeedButton;
    BtnInject: TSpeedButton;
    BtnLsp: TSpeedButton;
    dlgOpenDll: TOpenDialog;
    isNewXor: TLabeledEdit;
    ChkLSPDeinstallonclose: TCheckBox;
    Label3: TLabel;
    isMainFormCaption: TEdit;
    Bevel5: TBevel;
    lspInterceptMethod: TRadioGroup;
    chkProcessPackets: TCheckBox;
    PnlSocks5Chain: TGroupBox;
    ChkUseSocks5Chain: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    edSocks5Host: TEdit;
    edSocks5Port: TEdit;
    chkSocks5NeedAuth: TCheckBox;
    edSocks5AuthUsername: TEdit;
    Label6: TLabel;
    edSocks5AuthPwd: TEdit;
    Label7: TLabel;
    btnTestSocks5Chain: TButton;
    procedure ChkKamaelClick(Sender: TObject);
    procedure ChkGraciaOffClick(Sender: TObject);
    procedure ChkInterceptClick(Sender: TObject);
    procedure ChkSocks5ModeClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ChkLSPInterceptClick(Sender: TObject);
    procedure iNewxorClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure iInjectClick(Sender: TObject);
    procedure isLSPChange(Sender: TObject);
    procedure ChkNoDecryptClick(Sender: TObject);
    procedure rgProtocolVersionClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnInjectClick(Sender: TObject);
    procedure BtnLspClick(Sender: TObject);
    procedure btnNewXorClick(Sender: TObject);
    procedure isMainFormCaptionChange(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure edSocks5AuthPwdEnter(Sender: TObject);
    procedure edSocks5AuthPwdExit(Sender: TObject);
    procedure edSocks5PortKeyPress(Sender: TObject; var Key: Char);
    procedure edSocks5PortExit(Sender: TObject);
    procedure lspInterceptMethodClick(Sender: TObject);
    procedure btnTestSocks5ChainClick(Sender: TObject);
  protected
    procedure CreateParams(var Params : TCreateParams); override;
  private
    { Private declarations }
  public
    InterfaceEnabled:boolean;
    procedure init;
    procedure readsettings;
    procedure WriteSettings;
    procedure GenerateSettingsFromInterface;
    { Public declarations }

  end;

var
  fSettings: TfSettings;

implementation

uses uData, usocketengine, uLogForm, uFilterForm, uMain, uLangSelectDialog;

{$R *.dfm}

procedure TfSettings.readsettings;
begin
  InterfaceEnabled := true;

  fLangSelectDialog.siLangCombo1.ItemIndex := Options.ReadInteger('General', 'language', 0);
  fMain.lang.Language := fLangSelectDialog.siLangCombo1.Items.Strings[fLangSelectDialog.siLangCombo1.ItemIndex];
  Application.ProcessMessages;
  InterfaceEnabled := false;

  //максимальное количество строк в логе
  MaxLinesInLog:=Options.ReadInteger('General','MaxLinesInLog',300);
  //максимальное количество строк в логе пакетов
  MaxLinesInPktLog:=Options.ReadInteger('General','MaxLinesInPktLog',3000);

  isClientsList.Text:=Options.ReadString('General','Clients','l2.exe;l2walker.exe;l2helper.exe;l2.bin;');
  isIgnorePorts.Text:=Options.ReadString('General','IgnorPorts','5001;5002;5003;5004;2222;2106;80;2593;');

  ChkNoDecrypt.Checked:=Options.ReadBool('General','NoDecrypt',False);
  ChkChangeXor.Checked:=Options.ReadBool('General','AntiXORkey',False);
  ChkKamael.Checked:=Options.ReadBool('General','ChkKamael',False);
  ChkGraciaOff.Checked:=Options.ReadBool('General', 'ChkGraciaOff', False);
  isNewxor.Text:=Options.ReadString('General','isNewxor', AppPath+'newxor.dll');
  isInject.Text:=Options.ReadString('General','isInject', AppPath+'inject.dll');
  isLSP.Text := Options.ReadString('General','isLSP', ExtractFilePath(Application.ExeName)+'LSPprovider.dll'); //+ ПОЛНЫЙ путь. т.к. используется системой.

  iNewxor.Checked:=Options.ReadBool('General', 'iNewxor', False);
  iInject.Checked:=Options.ReadBool('General', 'iInject', False);

  ChkLSPIntercept.Checked:=Options.ReadBool('General','EnableLSP',False);
  ChkIntercept.Checked:=Options.ReadBool('General','Enable',True);
  ChkSocks5Mode.Checked:=Options.ReadBool('General','Socks5Mode',False);
  JvSpinEdit1.Value:=Options.ReadFloat('General','Timer',5);
  HookMethod.ItemIndex:=Options.ReadInteger('General','HookMethod',0);
  JvSpinEdit2.Value := Options.ReadInteger('General','LocalPort',7788);
  LocalPort := round(JvSpinEdit2.Value);
  ChkAllowExit.Checked := Options.ReadBool('General','FastExit',False);
  ChkShowLogWinOnStart.Checked := Options.ReadBool('General','AutoShowLog',False);
  rgProtocolVersion.ItemIndex :=  Min(Options.ReadInteger('Snifer','ProtocolVersion', 0), rgProtocolVersion.Items.Count);
  chkNoFree.Checked := Options.ReadBool('General','NoFreeAfterDisconnect',False);
  chkRaw.Checked := Options.ReadBool('General','RAWdatarememberallowed',False);
  JvSpinEdit1.Value := Options.ReadFloat('General', 'interval', 5);
  isMainFormCaption.Text := Options.ReadString('general','Caption', 'L2PacketHack v%s by CoderX.ru Team');

  ChkHexViewOffset.Checked := Options.ReadBool('General','HexViewOffset', True);
  chkAutoSavePlog.Checked := Options.ReadBool('General','AutoSaveLog', False);
  ChkShowLastPacket.Checked := Options.ReadBool('General','ShowLastPacket', True);
  ChkLSPDeinstallonclose.Checked := Options.ReadBool('General','LSPDeinstallonclose',true);
  LspInterceptMethod.ItemIndex := Options.ReadInteger('General','lspInterceptMethod',0);
  chkProcessPackets.Checked := Options.ReadBool('General','chkProcessPackets',true);


  ChkUseSocks5Chain.Checked := Options.ReadBool('General','ChkUseSocks5Chain',false);
  chkSocks5NeedAuth.Checked := Options.ReadBool('General','ChkSocks5NeedAuth',false);

  edSocks5Host.Text := Options.ReadString('General','Socks5Host','');
  edSocks5Port.Text := Options.ReadString('General','Socks5Port','1080');
  edSocks5AuthUsername.Text := Options.ReadString('General','Socks5AuthUsername','');
  edSocks5AuthPwd.Text := Options.ReadString('General','Socks5AuthPwd','');


  dmData.LSPControl.LookFor := isClientsList.Text;
  dmData.LSPControl.PathToLspModule := isLSP.Text;
  InterfaceEnabled := true;

  if iNewxor.Checked and (fileexists(isNewxor.Text)) then
  if LoadLibraryXor(isNewxor.Text) then
  begin
    isNewxor.Enabled := false;
    btnNewXor.Enabled := false;
    iNewxor.Checked := true;
  end;
  if iInject.Checked and (fileexists(isInject.Text)) then
  begin
    isInject.Enabled := false;
    BtnInject.Enabled := false;
    iInject.Checked := true;
    ChkInterceptClick(nil);
  end
  else
  if iInject.Checked then
  begin
    ChkLSPIntercept.Checked := false;
    ChkInterceptClick(nil);
  end;
  if dmData.LSPControl.isLspModuleInstalled then //+ чуть чуть по другому. буду смотреть реально ли установлена
  begin
    isLSP.Enabled := false;
    BtnLsp.Enabled := false;
    ChkLSPIntercept.Checked := true;
    ChkLSPInterceptClick(nil);
  end;

 if Options.ReadInteger('General','dumb',0) > 0 then
   begin
   Options.WriteInteger('General','dumb',Options.ReadInteger('General','dumb',1)+1);
   dmData.dumbtimer.Enabled := false;
   end
 else
   Options.WriteInteger('General','dumb',0);
   
 PnlSocks5Chain.Enabled := ChkIntercept.Checked or (ChkLSPIntercept.Checked and (lspInterceptMethod.ItemIndex = 0) or ChkSocks5Mode.Checked);
 PnlSocks5Chain.Font.Color := ifthen(PnlSocks5Chain.Enabled, clBlack, clGrayText);
 WriteSettings;
end;

procedure TfSettings.GenerateSettingsFromInterface;
var oldProto:integer;
begin
with GlobalSettings do
  begin
    oldProto := GlobalProtocolVersion;
    isNoDecrypt := ChkNoDecrypt.Checked;
    isChangeXor := ChkChangeXor.Checked;
    isChangeXor := ChkChangeXor.Checked;
    isGraciaOff := ChkGraciaOff.Checked;
    isKamael := ChkKamael.Checked;
    isNoProcessToClient := False;
    isNoProcessToServer := False;
    GlobalRawAllowed := chkRaw.Checked;
    HexViewOffset := ChkHexViewOffset.Checked;
    isSaveLog := chkAutoSavePlog.Checked;
    ShowLastPacket := ChkShowLastPacket.Checked;
    isprocesspackets := chkProcessPackets.Checked;
    case rgProtocolVersion.ItemIndex of
      0: GlobalProtocolVersion := 560;  //С4
      1: GlobalProtocolVersion := 660;
      2: GlobalProtocolVersion := 737;  //Интерлюд
      3: GlobalProtocolVersion := 828;  //Грация
      4: GlobalProtocolVersion := 83;   //Грация Финал
      else
        GlobalProtocolVersion := 560;   //по умолчанию
    end;

    if oldProto <> GlobalProtocolVersion then
      begin
        fPacketFilter.LoadPacketsIni;
        if InterfaceEnabled then
        fPacketFilter.UpdateBtnClick(nil);
      end;

    UseSocks5Chain := ChkUseSocks5Chain.Checked;
    Socks5NeedAuth := chkSocks5NeedAuth.Checked;
    Socks5Port := strtointdef(edSocks5Port.Text,1080);
    Socks5Host := edSocks5Host.Text;
    Socks5AuthUsername := edSocks5AuthUsername.Text;
    Socks5AuthPwd := edSocks5AuthPwd.Text;
    NoFreeAfterDisconnect := chkNoFree.Checked;
  end;



  sClientsList := isClientsList.Text;
  sIgnorePorts := isIgnorePorts.Text;
  sNewxor := isNewxor.Text;
  sInject := isInject.Text;
  sLSP := isLSP.Text;
  AllowExit := ChkAllowExit.Checked;
  dmData.timerSearchProcesses.Interval := round(JvSpinEdit1.Value*1000);

  if assigned(sockEngine) then
    sockEngine.isSocks5 := ChkSocks5Mode.Checked;

end;

procedure TfSettings.WriteSettings;
begin
  //максимальное количество строк в логе
  Options.WriteInteger('General','MaxLinesInLog',MaxLinesInLog);
  Options.WriteInteger('General','MaxLinesInPktLog',MaxLinesInPktLog);
  Options.WriteString('General','Clients', isClientsList.Text);
  Options.WriteString('General','IgnorPorts', isIgnorePorts.Text);
  Options.WriteBool('General','NoDecrypt', ChkNoDecrypt.Checked);
  Options.WriteBool('General','AntiXORkey', ChkChangeXor.Checked);
  Options.WriteBool('General','ChkKamael', ChkKamael.Checked);
  Options.WriteBool('General','ChkGraciaOff', ChkGraciaOff.Checked);
  Options.WriteString('General', 'isNewxor', isNewxor.Text);
  Options.WriteString('General', 'isInject', isInject.Text);
  Options.WriteString('General', 'isLSP', isLSP.Text);

  Options.WriteFloat('General', 'interval', JvSpinEdit1.Value);
  Options.WriteBool('General', 'Enable', ChkIntercept.Checked);
  Options.WriteBool('General', 'EnableLSP', ChkLSPIntercept.Checked);
  Options.WriteBool('General', 'Socks5Mode', ChkSocks5Mode.Checked);
  Options.WriteFloat('General','Timer',JvSpinEdit1.Value);
  Options.WriteInteger('General','HookMethod',HookMethod.ItemIndex);
  Options.WriteBool('General', 'FastExit', ChkAllowExit.Checked);
  Options.WriteBool('General', 'iNewxor', iNewxor.Checked);
  Options.WriteBool('General', 'iInject', iInject.Checked);
  Options.WriteBool('General','AutoShowLog',ChkShowLogWinOnStart.Checked);
  Options.WriteInteger('Snifer','ProtocolVersion', rgProtocolVersion.ItemIndex);
  Options.WriteBool('General','NoFreeAfterDisconnect',chkNoFree.Checked);
  Options.WriteBool('General','RAWdatarememberallowed',chkRaw.Checked);
  Options.WriteInteger('General','LocalPort',round(JvSpinEdit2.Value));
  
  Options.WriteBool('General','HexViewOffset',ChkHexViewOffset.Checked);
  Options.WriteBool('General','AutoSaveLog',chkAutoSavePlog.Checked);
  Options.WriteBool('General','ShowLastPacket',ChkShowLastPacket.Checked);
  Options.WriteBool('General','LSPDeinstallonclose',ChkLSPDeinstallonclose.Checked);
  Options.WriteInteger('General','lspInterceptMethod',lspInterceptMethod.ItemIndex);
  Options.WriteBool('General','chkProcessPackets',chkProcessPackets.Checked);

  Options.WriteBool('General','ChkUseSocks5Chain',ChkUseSocks5Chain.Checked);
  Options.WriteBool('General','ChkSocks5NeedAuth',chkSocks5NeedAuth.Checked);

  Options.WriteString('General','Socks5Host',edSocks5Host.Text);
  Options.WriteString('General','Socks5Port',edSocks5Port.Text);
  Options.WriteString('General','Socks5AuthUsername',edSocks5AuthUsername.Text);
  Options.WriteString('General','Socks5AuthPwd',edSocks5AuthPwd.Text);



  Options.UpdateFile;
end;

procedure TfSettings.ChkKamaelClick(Sender: TObject);
begin
  if not ChkKamael.Checked then ChkGraciaOff.Checked:=False;
  if not InterfaceEnabled then exit;
  GenerateSettingsFromInterface;
end;

procedure TfSettings.ChkGraciaOffClick(Sender: TObject);
begin
  if ChkGraciaOff.Checked then ChkKamael.Checked := True;
  if not InterfaceEnabled then exit;
  GenerateSettingsFromInterface;
end;

procedure TfSettings.ChkInterceptClick(Sender: TObject);
begin
  if not iInject.Checked then
    ChkIntercept.Checked := false;

  if ChkIntercept.Checked then
    begin
      ChkSocks5Mode.Checked:= False;
      dmData.LSPControl.setlspstate(ChkLSPIntercept.Checked);
      isLSP.Enabled := true;
      BtnLsp.Enabled := true;
      ChkLSPIntercept.Checked := False;
    end;

  dmData.timerSearchProcesses.Enabled := ChkIntercept.Checked;
  PnlSocks5Chain.Enabled := ChkIntercept.Checked or (ChkLSPIntercept.Checked and (lspInterceptMethod.ItemIndex = 0) or ChkSocks5Mode.Checked);
  PnlSocks5Chain.Font.Color := ifthen(PnlSocks5Chain.Enabled, clBlack, clGrayText);  
end;

procedure TfSettings.ChkSocks5ModeClick(Sender: TObject);
begin
  if not InterfaceEnabled then exit;
  if ChkSocks5Mode.Checked then
  begin
    ChkIntercept.Checked := False;
    dmData.LSPControl.setlspstate(ChkLSPIntercept.Checked);
    isLSP.Enabled := true;
    BtnLsp.Enabled := true;
    ChkLSPIntercept.Checked := False;
  end;
  if Sender = nil then exit;
  ChkInterceptClick(nil);
  ChkLSPInterceptClick(nil);

  GenerateSettingsFromInterface;
  PnlSocks5Chain.Enabled := ChkIntercept.Checked or (ChkLSPIntercept.Checked and (lspInterceptMethod.ItemIndex = 0) or ChkSocks5Mode.Checked);
  PnlSocks5Chain.Font.Color := ifthen(PnlSocks5Chain.Enabled, clBlack, clGrayText);
end;

procedure TfSettings.FormDestroy(Sender: TObject);
begin
  //координаты и размер окна
  savepos(self);
  //убираем LSP при выходе из программы
  if ChkLSPDeinstallonclose.Checked then
    dmData.LSPControl.setlspstate(false);

  //Сохранимся напоследок
  Options.UpdateFile;
  Options.Destroy;
  if hXorLib <> 0 then FreeLibrary(hXorLib);
  if not isInject.Enabled then FreeMem(pInjectDll);
end;

procedure TfSettings.ChkLSPInterceptClick(Sender: TObject);
begin
if (ExtractFilePath(isLSP.Text) = '') and ChkLSPIntercept.Checked then
  begin
    ChkLSPIntercept.Checked := false;
    exit;
  end;

  if ChkLSPIntercept.Checked then
  begin
    isLSP.Enabled := false;
    BtnLsp.Enabled := false;
    ChkSocks5Mode.Checked := false;
    ChkIntercept.Checked := false;
  end else
  begin
    isLSP.Enabled := true;
    BtnLsp.Enabled := true;
  end;
  dmData.LSPControl.setlspstate(ChkLSPIntercept.Checked);

  PnlSocks5Chain.Enabled := ChkIntercept.Checked or (ChkLSPIntercept.Checked and (lspInterceptMethod.ItemIndex = 0) or ChkSocks5Mode.Checked);
  PnlSocks5Chain.Font.Color := ifthen(PnlSocks5Chain.Enabled, clBlack, clGrayText);
end;

procedure TfSettings.iNewxorClick(Sender: TObject);
begin
  if not InterfaceEnabled then exit;
    if iNewxor.Checked then
    begin
      isNewxor.Enabled := false;
      btnNewXor.Enabled := false;
      if not loadLibraryXOR(isNewxor.Text) then
      begin
        isNewxor.Enabled := true;
        btnNewXor.Enabled := true;
        iNewxor.Checked := false;
      end;
    end
    else
    begin
      if not isNewxor.Enabled then
      begin
        FreeLibrary(hXorLib);
        hXorLib := 0;
        @CreateXorIn := nil;
        @CreateXorOut := nil;
        isNewxor.Enabled := true;
        btnNewXor.Enabled := true;
      end;
    end;
  GenerateSettingsFromInterface;
end;

procedure TfSettings.Button1Click(Sender: TObject);
begin
  WriteSettings;
  GenerateSettingsFromInterface;
  Hide;
end;

procedure TfSettings.Button2Click(Sender: TObject);
begin
  readsettings;
  GenerateSettingsFromInterface;
  Hide;
end;

procedure TfSettings.iInjectClick(Sender: TObject);
begin      
  if not iInject.Checked then
  begin
    ChkIntercept.Checked := false;
    FreeMem(pInjectDll);
    pInjectDll := nil;
    AddToLog(format(rsUnLoadDllSuccessfully,[isInject.Text]));
  end
  else
  if ExtractFilePath(isInject.Text) = '' then
    iInject.Checked := false
  else
  if not LoadLibraryInject (isInject.Text) then
    iInject.Checked := false;

  isInject.Enabled := not iInject.Checked;
  BtnInject.Enabled := not iInject.Checked;
  HookMethod.Enabled := iInject.Checked;
  ChkIntercept.Enabled := iInject.Checked;
  JvSpinEdit1.Enabled := iInject.Checked;

  if not InterfaceEnabled then exit;
  GenerateSettingsFromInterface;
end;

procedure TfSettings.isLSPChange(Sender: TObject);
begin
  dmData.LSPControl.PathToLspModule := isLSP.Text;
end;

procedure TfSettings.ChkNoDecryptClick(Sender: TObject);
begin
  if not InterfaceEnabled then exit;
  GenerateSettingsFromInterface;
end;

procedure TfSettings.init;
begin
  //считываем Options.ini в память
  Options:=TMemIniFile.Create(AppPath+'settings\Options.ini');

  if not FileExists(AppPath+'settings\Options.ini') then
    begin
      fLangSelectDialog.ShowModal;
      Show;
    end;

  readsettings;
  GenerateSettingsFromInterface;
  if ChkShowLogWinOnStart.Checked then fLog.show;
end;

procedure TfSettings.rgProtocolVersionClick(Sender: TObject);
begin
  if not InterfaceEnabled then exit;
  ChkKamael.Checked := (rgProtocolVersion.ItemIndex >= 3);
  GenerateSettingsFromInterface;

end;

procedure TfSettings.FormCreate(Sender: TObject);
begin
  loadpos(self);
  InterfaceEnabled := false;
end;

procedure TfSettings.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle OR WS_EX_APPWINDOW;
end;

procedure TfSettings.BtnInjectClick(Sender: TObject);
begin
  dlgOpenDll.InitialDir:=AppPath;
  if dlgOpenDll.Execute then
    isInject.Text := dlgOpenDll.FileName;
end;

procedure TfSettings.BtnLspClick(Sender: TObject);
begin
  dlgOpenDll.InitialDir:=AppPath;
  if dlgOpenDll.Execute then
    isLSP.Text := dlgOpenDll.FileName;
end;

procedure TfSettings.btnNewXorClick(Sender: TObject);
begin
  dlgOpenDll.InitialDir:=AppPath;
  if dlgOpenDll.Execute then
    isNewxor.Text := dlgOpenDll.FileName;
end;

procedure TfSettings.isMainFormCaptionChange(Sender: TObject);
begin
  fMain.Caption := format(isMainFormCaption.Text, [uGlobalFuncs.getversion]);
  Options.WriteString('general','Caption', isMainFormCaption.Text);
end;

procedure TfSettings.FormDeactivate(Sender: TObject);
begin
  SetWindowPos(handle,HWND_TOP,0,0,0,0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;

procedure TfSettings.edSocks5AuthPwdEnter(Sender: TObject);
begin
  edSocks5AuthPwd.PasswordChar := #0;
end;

procedure TfSettings.edSocks5AuthPwdExit(Sender: TObject);
begin
  edSocks5AuthPwd.PasswordChar := '*';
end;

procedure TfSettings.edSocks5PortKeyPress(Sender: TObject; var Key: Char);
begin
  if (pos(key, '1234567890') = 0) and (key<>#8) then
  key := #0;
end;

procedure TfSettings.edSocks5PortExit(Sender: TObject);
begin
  edSocks5Port.Text := inttostr(StrToIntDef(edSocks5Port.text,1080));
end;

procedure TfSettings.lspInterceptMethodClick(Sender: TObject);
begin
  PnlSocks5Chain.Enabled := ChkIntercept.Checked or (ChkLSPIntercept.Checked and (lspInterceptMethod.ItemIndex = 0) or ChkSocks5Mode.Checked);
  PnlSocks5Chain.Font.Color := ifthen(PnlSocks5Chain.Enabled, clBlack, clGrayText);
end;

procedure TfSettings.btnTestSocks5ChainClick(Sender: TObject);
var
  s : tsocket;
  res : integer;
begin
 S:=socket(AF_INET,SOCK_STREAM,0);
 if S=INVALID_SOCKET then
    Showmessage('Socket error');

 res := AuthOnSocks5(s, edSocks5Host.Text, strtointdef(edSocks5Port.text,1080), inet_addr(pchar('207.46.232.182')){microsoft.com}, htons(80), chkSocks5NeedAuth.Checked, edSocks5AuthUsername.Text, edSocks5AuthPwd.Text);
 if res = 0 then 
        begin
          ShowMessage(rsProxyServerOk);
        end
      else
        begin
        //неуспешно
          case res of
          1:ShowMessage(rs101);
          2:ShowMessage(rs102);
          3:ShowMessage(rs103);
          4:ShowMessage(rs105);
          5:ShowMessage(rs105);
          6:ShowMessage(rs106);
          7:ShowMessage(rs107);
          8:ShowMessage(rs108);
          9:ShowMessage(rs109);
          10:ShowMessage(rs110);
          11:ShowMessage(rs111);
          12:ShowMessage(rs112);
          13:ShowMessage(rs113);
          14:ShowMessage(rs114);
          15:ShowMessage(rs115);
          end;
        end;
end;

end.
