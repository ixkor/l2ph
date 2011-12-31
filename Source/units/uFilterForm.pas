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
  ListView1.Items.BeginUpdate;
  ListView2.Items.BeginUpdate;
  try
    // очищаем спискм
    ListView1.Clear;
    ListView2.Clear;
    PacketsFromS.Clear;
    PacketsFromC.Clear;
    PacketsNames.Clear;
    //считываем packets.ini
    PacketsNames.LoadFromFile(AppPath+'settings\'+s);
    for i:=0 to PacketsNames.Count-1 do begin
      temp:=copy(PacketsNames[i],1,2); //взять с первой позиции два символа 
      if temp='//' then continue; //комментарии, пропускаем их
      if PacketsNames[i]='' then continue;     //пустые строки, пропускаем их
      if uppercase(PacketsNames[i])='[CLIENT]' then begin fromS:=false; continue; end;   //переходим к следующей итерации цикла
      if uppercase(PacketsNames[i])='[SERVER]' then begin fromS:=true; continue; end;    //переходим к следующей итерации цикла
      if not fromS then
      begin // клиентские пакеты
        with ListView2.Items.Add do
        begin
          Caption:=PacketsNames.Names[i];
          Checked:=True;
          SubItems.Add(GetNamePacket(PacketsNames.ValueFromIndex[i]));
          PacketsFromC.Append(PacketsNames.Names[i]+'='+(GetNamePacket(PacketsNames.ValueFromIndex[i])));
        end;
      end
      else   //серверные пакеты
      begin
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
  //для выбора соответствующего packets???.ini
  case GlobalProtocolVersion of
    AION: LoadPktIni('packetsAion21.ini');       //пакеты для AION v 2.1 - 2.6
    AION27: LoadPktIni('packetsAion27.ini');   //пакеты для AION v 2.7 - двух байтные ID
    CHRONICLE4: LoadPktIni('packetsC4.ini');   //пакеты для С4
    CHRONICLE5: LoadPktIni('packetsC5.ini');   //пакеты для C5
    INTERLUDE: LoadPktIni('packetsInterlude.ini');        //пакеты для Интерлюдии
    GRACIA: LoadPktIni('packetsGracia.ini');              //пакеты для Грация
    GRACIAFINAL: LoadPktIni('packetsGraciaFinal.ini');    //пакеты для Грация Финал
    GRACIAEPILOGUE: LoadPktIni('packetsGraciaEpilogue.ini');  //пакеты для Грация Эпилог
    FREYA: LoadPktIni('packetsFreya.ini');                    //пакеты для Freya
    HIGHFIVE: LoadPktIni('packetsHighFive.ini');              //пакеты для High Five
    GOD: LoadPktIni('packetsGOD.ini');                        //пакеты для Goddess of Destruction
  end;

  filterS:=Options.ReadString('Snifer','notFS','');
  filterC:=Options.ReadString('Snifer','notFC','');

  for i:=0 to (ListView1.Items.Count)-1 do
    ListView1.Items.Item[i].Checked := pos('/'+ListView1.Items.Item[i].Caption+'/',filterS)=0;

  for i:=0 to (ListView2.Items.Count)-1 do
    ListView2.Items.Item[i].Checked := pos('/'+ListView2.Items.Item[i].Caption+'/',filterC)=0;
end;

procedure TfPacketFilter.UpdateBtnClick(Sender: TObject);
var
  i : integer;
begin
  filterS := '/';
  i := 0;
  while i < ListView1.Items.Count do
  begin
    if not ListView1.Items.Item[i].Checked then
      filterS := filterS + ListView1.Items.Item[i].Caption+'/';
    inc(i);
  end;
  Options.WriteString('Snifer','notFS',filterS);
  filterC := '/';
  i := 0;
  while i < ListView2.Items.Count do
  begin
    if not ListView2.Items.Item[i].Checked then
      filterC := filterC + ListView2.Items.Item[i].Caption+'/';
    inc(i);
  end;
  Options.WriteString('Snifer','notFC',filterC);

  Options.UpdateFile;
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
