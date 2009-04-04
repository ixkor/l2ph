unit uSettingsDialog;

interface

uses
  uResourceStrings, 
  usharedstructs,
  uglobalfuncs,
  winsock,
  math, 
  IniFiles, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, JvExMask, JvSpin, ComCtrls, siComp;

type
  TfSettings = class(TForm)
    PageControl3: TPageControl;
    TabSheet8: TTabSheet;
    isIgnorePorts: TLabeledEdit;
    isClientsList: TLabeledEdit;
    TabSheet9: TTabSheet;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    isInject: TLabeledEdit;
    HookMethod: TRadioGroup;
    ChkIntercept: TCheckBox;
    JvSpinEdit1: TJvSpinEdit;
    ChkSocks5: TCheckBox;
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
    isNewxor: TLabeledEdit;
    iNewxor: TCheckBox;
    TabSheet1: TTabSheet;
    ChkAllowExit: TCheckBox;
    ChkShowLogWinOnStart: TCheckBox;
    chkNoFree: TCheckBox;
    chkRaw: TCheckBox;
    lang: TsiLang;
    procedure ChkKamaelClick(Sender: TObject);
    procedure ChkGraciaOffClick(Sender: TObject);
    procedure ChkInterceptClick(Sender: TObject);
    procedure ChkSocks5Click(Sender: TObject);
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

uses uData, uLogForm, uFilterForm, uMain;

{$R *.dfm}

procedure TfSettings.readsettings;
begin
  //������������ ���������� ����� � ����
  MaxLinesInLog:=Options.ReadInteger('General','MaxLinesInLog',300);
  //������������ ���������� ����� � ���� �������
  MaxLinesInPktLog:=Options.ReadInteger('General','MaxLinesInPktLog',3000);


  isClientsList.Text:=Options.ReadString('General','Clients','l2.exe;l2walker.exe');
  isIgnorePorts.Text:=Options.ReadString('General','IgnorPorts','5001;5002;2222');
  ChkNoDecrypt.Checked:=Options.ReadBool('General','NoDecrypt',False);
  ChkChangeXor.Checked:=Options.ReadBool('General','AntiXORkey',False);
  ChkKamael.Checked:=Options.ReadBool('General','ChkKamael',False);
  ChkGraciaOff.Checked:=Options.ReadBool('General', 'ChkGraciaOff', False);
  isNewxor.Text:=Options.ReadString('General','isNewxor', 'newxor.dll');
  isInject.Text:=Options.ReadString('General','isInject', 'inject.dll');
  isLSP.Text := Options.ReadString('General','isLSP', ExtractFilePath(Application.ExeName)+'LSPprovider.dll'); //+ ������ ����. �.�. ������������ ��������.

  iNewxor.Checked:=Options.ReadBool('General', 'iNewxor', False);
  iInject.Checked:=Options.ReadBool('General', 'iInject', False);

  ChkLSPIntercept.Checked:=Options.ReadBool('General','EnableLSP',False);
  ChkIntercept.Checked:=Options.ReadBool('General','Enable',True);
  chkSocks5.Checked:=Options.ReadBool('General','Socks5',False);
  JvSpinEdit1.Value:=Options.ReadFloat('General','Timer',5);
  HookMethod.ItemIndex:=Options.ReadInteger('General','HookMethod',1);
  LocalPort := htons(Options.ReadInteger('General','LocalPort',$FEDC));
  ChkAllowExit.Checked := Options.ReadBool('General','FastExit',False);
  ChkShowLogWinOnStart.Checked := Options.ReadBool('General','AutoShowLog',False);
  rgProtocolVersion.ItemIndex :=  Min(Options.ReadInteger('Snifer','ProtocolVersion', 0), rgProtocolVersion.Items.Count);
  chkNoFree.Checked := Options.ReadBool('General','NoFreeAfterDisconnect',False);
  chkRaw.Checked := Options.ReadBool('General','RAWdatarememberallowed',False);

  InterfaceEnabled := true;
  
  dmData.LSPControl.LookFor := isClientsList.Text;
  dmData.LSPControl.PathToLspModule := isLSP.Text;

  if iNewxor.Checked and (Length(isNewxor.Text) > 0) then
  if LoadLibraryXor(isNewxor.Text) then
  begin
    isNewxor.Enabled := false;
    iNewxor.Checked := true;
  end;

  if iInject.Checked and (Length(isInject.Text) > 0) then
  begin
    isInject.Enabled := false;
    iInject.Checked := true;
    ChkInterceptClick(nil);
  end
  else
   begin
   ChkLSPIntercept.Checked := false;
   ChkInterceptClick(nil);
   end;


  if dmData.LSPControl.isLspModuleInstalled then //+ ���� ���� �� �������. ���� �������� ������� �� �����������
  begin
    isLSP.Enabled := false;
    ChkLSPIntercept.Checked := true;
    ChkLSPInterceptClick(nil);
  end;

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
    case rgProtocolVersion.ItemIndex of
      0: GlobalProtocolVersion := 560;
      1: GlobalProtocolVersion := 660;
      2: GlobalProtocolVersion := 737;
      3: GlobalProtocolVersion := 828;
      else
        GlobalProtocolVersion := 560;
      
    end;

    if oldProto <> GlobalProtocolVersion then
      begin
        fPacketFilter.LoadPacketsIni;
        if InterfaceEnabled then
        fPacketFilter.UpdateBtnClick(nil);
      end;
  end;

  GlobalNoFreeAfterDisconnect := chkNoFree.Checked;

  sClientsList := isClientsList.Text;
  sIgnorePorts := isIgnorePorts.Text;
  sNewxor := isNewxor.Text;
  sInject := isInject.Text;
  sLSP := isLSP.Text;
  AllowExit := ChkAllowExit.Checked;

end;

procedure TfSettings.WriteSettings;
begin
  //������������ ���������� ����� � ����
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

  Options.WriteBool('General', 'Enable', ChkIntercept.Checked);
  Options.WriteBool('General', 'EnableLSP', ChkLSPIntercept.Checked);
  Options.WriteBool('General', 'Socks5', chkSocks5.Checked);
  Options.WriteFloat('General','Timer',JvSpinEdit1.Value);
  Options.WriteInteger('General','HookMethod',HookMethod.ItemIndex);
  Options.WriteBool('General', 'FastExit', ChkAllowExit.Checked);
  Options.WriteBool('General', 'iNewxor', iNewxor.Checked);
  Options.WriteBool('General', 'iInject', iInject.Checked);
  Options.WriteBool('General','AutoShowLog',ChkShowLogWinOnStart.Checked);
  Options.WriteInteger('Snifer','ProtocolVersion', rgProtocolVersion.ItemIndex);
  Options.WriteBool('General','NoFreeAfterDisconnect',chkNoFree.Checked);
  Options.WriteBool('General','RAWdatarememberallowed',chkRaw.Checked); 
  Options.UpdateFile;
end;

procedure TfSettings.ChkKamaelClick(Sender: TObject);
begin
  if not ChkKamael.Checked then ChkGraciaOff.Checked:=False;
end;

procedure TfSettings.ChkGraciaOffClick(Sender: TObject);
begin
  if ChkGraciaOff.Checked then ChkKamael.Checked := True;
  GenerateSettingsFromInterface;
end;

procedure TfSettings.ChkInterceptClick(Sender: TObject);
begin
  if not iInject.Checked then
    ChkIntercept.Checked := false;

  if ChkIntercept.Checked then
    begin
      chkSocks5.Checked:= False;
      ChkLSPIntercept.Checked := False;
      dmData.LSPControl.setlspstate(ChkLSPIntercept.Checked);
      isLSP.Enabled := true;
    end
  else
    exit;
  dmData.timerSearchProcesses.Enabled := ChkIntercept.Checked;
end;

procedure TfSettings.ChkSocks5Click(Sender: TObject);
begin
  if not InterfaceEnabled then exit;
  if chkSocks5.Checked then
  begin
    ChkIntercept.Checked := False;
    ChkLSPIntercept.Checked := False;
    dmData.LSPControl.setlspstate(ChkLSPIntercept.Checked);
    isLSP.Enabled := true;
  end;
  if Sender = nil then exit;
  ChkInterceptClick(nil);
  ChkLSPInterceptClick(nil);
  GenerateSettingsFromInterface;
end;

procedure TfSettings.FormDestroy(Sender: TObject);
begin
  //���������� ����������
  //���������� � ������ ����
  Options.WriteInteger('General','Top',L2PacketHackMain.Top);
  Options.WriteInteger('General','Left',L2PacketHackMain.Left);
  Options.WriteInteger('General','Widht',L2PacketHackMain.Width);
  Options.WriteInteger('General','Heigth',L2PacketHackMain.Height);
  Options.UpdateFile;
  Options.Free;
  
  if hXorLib <> 0 then FreeLibrary(hXorLib);
  if not isInject.Enabled then FreeMem(pInjectDll);
end;

procedure TfSettings.ChkLSPInterceptClick(Sender: TObject);
begin
ChkLSPIntercept.Checked := false;
  if not InterfaceEnabled then exit;
  isLSP.Enabled := not ChkLSPIntercept.Checked;
  if ChkLSPIntercept.Checked then
  begin
    ChkSocks5.Checked := false;
    ChkIntercept.Checked := false;
  end;
  dmData.LSPControl.setlspstate(ChkLSPIntercept.Checked);
end;

procedure TfSettings.iNewxorClick(Sender: TObject);
begin
    if iNewxor.Checked then
    begin
      isNewxor.Enabled := false;
      if not loadLibraryXOR(isNewxor.Text) then
        begin
          isNewxor.Enabled := true;
          iNewxor.Checked := false;
        end;

    end
    else
    begin
      if not isNewxor.Enabled then
      begin
        FreeLibrary(hXorLib);
        isNewxor.Enabled := true;
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
  if iInject.Checked then
  begin
    isInject.Enabled := false;
    if not LoadLibraryInject (isInject.Text) then iInject.Checked := false;
  end
  else
  begin
    ChkIntercept.Checked := false;
    FreeMem(pInjectDll);
    AddToLog(format(rsUnLoadDllSuccessfully,[isInject.Text]));
    isInject.Enabled := true;
  end;
  isInject.Enabled := not iInject.Checked;
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
  //��������� Options.ini � ������
  Options:=TMemIniFile.Create(ExtractFilePath(Application.ExeName)+'Options.ini');
  readsettings;
  GenerateSettingsFromInterface;
  if ChkShowLogWinOnStart.Checked then fLog.show;
end;

procedure TfSettings.rgProtocolVersionClick(Sender: TObject);
begin
  GenerateSettingsFromInterface;
  
end;

procedure TfSettings.FormCreate(Sender: TObject);
begin
  InterfaceEnabled := false;
end;

procedure TfSettings.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle OR WS_EX_APPWINDOW;
end;

end.
