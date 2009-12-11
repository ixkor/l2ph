unit uFilterForm;

interface

uses
  inifiles, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, siComp, JvExComCtrls, JvListView;

type
  TfPacketFilter = class(TForm)
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet7: TTabSheet;
    Panel17: TPanel;
    Button1: TButton;
    Button13: TButton;
    UpdateBtn: TButton;
    lang: TsiLang;
    ListView1: TJvListView;
    ListView2: TJvListView;
    procedure Button1Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure UpdateBtnClick(Sender: TObject);
  protected
    procedure CreateParams (var Params : TCreateParams); override;
  public
  procedure refreshexisting;
  procedure LoadPktIni(s:string);
  procedure LoadPacketsIni;
    { Public declarations }
  end;

var
  fPacketFilter: TfPacketFilter;

implementation
uses uMain, uGlobalFuncs, uData, uSocketEngine;
{$R *.dfm}

procedure TfPacketFilter.Button1Click(Sender: TObject);
var
  i:integer;
begin
  if PageControl2.ActivePageIndex=0 then
    for i:=0 to ListView1.Items.Count-1 do
      ListView1.Items.Item[i].Checked:=True
  else
    for i:=0 to ListView2.Items.Count-1 do
      ListView2.Items.Item[i].Checked:=True;
      
end;

procedure TfPacketFilter.Button13Click(Sender: TObject);
var
  i: Integer;
begin
  if PageControl2.ActivePageIndex=0 then
    with ListView1.Items do
      for i:=0 to ListView1.Items.Count-1 do
        Item[i].Checked:=not Item[i].Checked
  else
    with ListView2.Items do
      for i:=0 to ListView2.Items.Count-1 do
        Item[i].Checked:=not Item[i].Checked;
      
end;

procedure TfPacketFilter.FormCreate(Sender: TObject);
begin
loadpos(self);

PacketsFromS := TStringList.Create;
PacketsFromC := TStringList.Create;
PacketsNames := TStringList.Create;
  
end;

procedure TfPacketFilter.FormDestroy(Sender: TObject);
begin
savepos(self);

PacketsFromC.Destroy;
PacketsFromS.Destroy;
PacketsNames.Destroy;
if assigned(PacketsINI) then PacketsINI.Destroy;
end;

procedure TfPacketFilter.LoadPktIni(s: string);
var
  FromS: boolean;
  i: integer;
  temp: string;
//  BColor: TColor;
begin
  fromS:=false;
  // очищаем спискм

  ListView1.Items.BeginUpdate;
  ListView2.Items.BeginUpdate;
  try
  ListView1.Clear;
  ListView2.Clear;
  PacketsFromS.Clear;
  PacketsFromC.Clear;

  //считываем packets.ini
  PacketsNames.LoadFromFile(AppPath+'settings\'+s);
  for i:=0 to PacketsNames.Count-1 do begin
    temp:=copy(PacketsNames[i],1,2); //взять первые два символа
    if temp='//' then continue; //комментарии
    if PacketsNames[i]='' then continue;     //пустые строки
    if uppercase(PacketsNames[i])='[CLIENT]' then begin fromS:=false; continue; end;
    if uppercase(PacketsNames[i])='[SERVER]' then begin fromS:=true; continue; end;
    if not fromS then begin
      with ListView2.Items.Add do
      begin
        Caption:=PacketsNames.Names[i];
        Checked:=True;
        SubItems.Add(GetNamePacket(PacketsNames.ValueFromIndex[i]));
        PacketsFromC.Append(PacketsNames.Names[i]+'='+(GetNamePacket(PacketsNames.ValueFromIndex[i])));
      end;
    end;
    if fromS then begin
      with ListView1.Items.Add do
      begin
        Caption:=PacketsNames.Names[i];
        Checked:=True;
        SubItems.Add(GetNamePacket(PacketsNames.ValueFromIndex[i]));
        PacketsFromS.Append(PacketsNames.Names[i]+'='+(GetNamePacket(PacketsNames.ValueFromIndex[i])));
      end;
    end;
  end;

  //считываем packets.ini
  //полный вариант для разбора пакетов
  if PacketsINI <> nil then PacketsINI.Free;
  PacketsINI := TMemIniFile.Create(AppPath+'settings\'+s);

  finally
    ListView1.Items.EndUpdate;
    ListView2.Items.EndUpdate;
  end;
end;

procedure TfPacketFilter.LoadPacketsIni;
var
  i: Integer;
begin
  if (GlobalProtocolVersion=-123)then
    LoadPktIni('packetAion.ini')   //пакеты для AION
  else
  if (GlobalProtocolVersion>=12) and (GlobalProtocolVersion<=100) then
    LoadPktIni('packetst2.ini')   //пакеты для Грация Финал
  else begin
    //  ProtocolVersion:=560; //C4
    if GlobalProtocolVersion<828 then begin
      // С4/C5/CT0
      if GlobalProtocolVersion<660 then begin
        // C4 секция [GS_c4]
        LoadPktIni('packetsc4.ini');
      end;
      if (GlobalProtocolVersion>=660) and (GlobalProtocolVersion<=736) then begin
        // C5 секция [GS]
        LoadPktIni('packetsc5.ini');
      end;
      if GlobalProtocolVersion>=737 then begin
        // interlude T0  секция [GS_t0]
        LoadPktIni('packetst0.ini');
      end;
    end else begin // >= 828 (какой там минимальный T1 протокол ?)
        LoadPktIni('packetst1.ini');
    end;
  end;
  filterS:=Options.ReadString('Snifer','FS','notset');
  filterC:=Options.ReadString('Snifer','FC','notset');
  if filterS = 'notset' then
  for i:=0 to (ListView1.Items.Count)-1 do
    ListView1.Items.Item[i].Checked := true
  else
  for i:=0 to (ListView2.Items.Count)-1 do
    ListView1.Items.Item[i].Checked := pos('/'+ListView1.Items.Item[i].Caption+'/',filterS)>0;

  if filterC = 'notset' then
  for i:=0 to (ListView2.Items.Count)-1 do
    ListView2.Items.Item[i].Checked := true
  else
  for i:=0 to (ListView2.Items.Count)-1 do
    ListView2.Items.Item[i].Checked := pos('/'+ListView2.Items.Item[i].Caption+'/',filterC)>0;
end;

procedure TfPacketFilter.UpdateBtnClick(Sender: TObject);
var
  i : integer;
begin
  filterS := '/';
  i := 0;
  while i < ListView1.Items.Count do
  begin
    if ListView1.Items.Item[i].Checked then
      begin
      filterS := filterS + ListView1.Items.Item[i].Caption+'/';
      end;
    inc(i);
  end;
  Options.WriteString('Snifer','FS',filterS);
  filterC := '/';
  i := 0;
  while i < ListView2.Items.Count do
  begin
    if ListView2.Items.Item[i].Checked then
      begin
      filterC := filterC + ListView2.Items.Item[i].Caption+'/';
      end;
    inc(i);
  end;
  Options.WriteString('Snifer','FC',filterC);
  refreshexisting;
end;

procedure TfPacketFilter.refreshexisting;
//обновляет существующие твизуалы.
var
  i : integer;
begin
  try
    i := 0;
    while i < LSPConnections.Count do
    begin
      if assigned(TlspConnection(LSPConnections.Items[i]).Visual) then
          TlspConnection(LSPConnections.Items[i]).Visual.PacketListRefresh(false);
      inc(i);
    end;

    i := 0;
    if assigned(sockEngine) then
    while i < sockEngine.tunels.Count do
    begin
      if assigned(Ttunel(sockEngine.tunels.Items[i]).Visual) then
        Ttunel(sockEngine.tunels.Items[i]).Visual.PacketListRefresh(false);
      inc(i);
    end;

    i := 0;
    while i < PacketLogWievs.Count do
    begin
      if assigned(TpacketLogWiev(PacketLogWievs.Items[i]).Visual) then
        TpacketLogWiev(PacketLogWievs.Items[i]).Visual.PacketListRefresh(false);
      inc(i);
    end;
  except
  end;
end;

procedure TfPacketFilter.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    ExStyle := ExStyle OR WS_EX_APPWINDOW or WS_EX_CONTROLPARENT;
end;

end.
