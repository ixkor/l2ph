unit uPacketViewer;

interface

uses
  Windows, uPacketView, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, ExtCtrls, RVScroll, RichView, RVEdit,
  RVStyle, siComp;

type
  TfPacketViewer = class(TForm)
    Splitter3: TSplitter;
    packetVievPanel: TPanel;
    imgBT: TImageList;
    Panel1: TPanel;
    ToolBar2: TToolBar;
    ToServer: TToolButton;
    ToClient: TToolButton;
    RVStyle1: TRVStyle;
    RichViewEdit1: TRichViewEdit;
    siLang1: TsiLang;
    procedure RichViewEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure ToClientClick(Sender: TObject);
    procedure ToServerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RichViewEdit1Change(Sender: TObject);
  protected
    procedure CreateParams (var Params : TCreateParams); override;
  private
    var
    PacketView : TfPacketView;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPacketViewer: TfPacketViewer;

implementation
uses umain, uglobalfuncs;

{$R *.dfm}

procedure TfPacketViewer.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    ExStyle := ExStyle OR WS_EX_APPWINDOW or WS_EX_CONTROLPARENT;
end;


procedure TfPacketViewer.FormCreate(Sender: TObject);
begin
loadpos(self);
PacketView := TfPacketView.Create(packetVievPanel);
PacketView.Parent := packetVievPanel;
end;

procedure TfPacketViewer.FormDestroy(Sender: TObject);
begin
savepos(self);
PacketView.Destroy;
end;

procedure TfPacketViewer.RichViewEdit1Change(Sender: TObject);
var
  PktStr : string;
  size : integer;
begin

  PktStr := RichViewEdit1.GetCurrentItemText;
  if PktStr = '' then exit;
  size := length(HexToString(PktStr))+2;
  if size = 2 then exit;
  if ToServer.Down then
    PktStr:='0300000000000000000000'+PktStr
    else
    PktStr:='0400000000000000000000'+PktStr;

  PacketView.ParsePacket('', PktStr, size);
end;

procedure TfPacketViewer.RichViewEdit1KeyPress(Sender: TObject; var Key: Char);
begin
if pos(LowerCase(key),'1234567890abcdef')>0 then
  key := UpCase(key)
else
  key := #0;
end;

procedure TfPacketViewer.ToClientClick(Sender: TObject);
begin
ToClient.Down := true;
ToServer.Down := false;
RichViewEdit1Change(nil);
end;

procedure TfPacketViewer.ToServerClick(Sender: TObject);
begin
ToServer.Down := true;
ToClient.Down := false;
RichViewEdit1Change(nil);
end;

end.

