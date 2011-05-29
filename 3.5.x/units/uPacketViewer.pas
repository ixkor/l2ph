unit uPacketViewer;

interface

uses
  Windows, uPacketView, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, ExtCtrls, RVScroll, RichView, RVEdit,
  RVStyle, siComp, StdCtrls, JvExStdCtrls, JvRichEdit;

type
  TfPacketViewer = class(TForm)
    Splitter3: TSplitter;
    packetVievPanel: TPanel;
    imgBT: TImageList;
    Panel1: TPanel;
    ToolBar2: TToolBar;
    ToServer: TToolButton;
    ToClient: TToolButton;
    siLang1: TsiLang;
    Memo4: TJvRichEdit;
    ToolButton1: TToolButton;
    procedure ToClientClick(Sender: TObject);
    procedure ToServerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Memo4Change(Sender: TObject);
  protected
    procedure CreateParams (var Params : TCreateParams); override;
  private
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

procedure TfPacketViewer.Memo4Change(Sender: TObject);
var
  i,k:Integer;
  temp: string;
  p: TPoint;
  b: Boolean;
  PktStr : string;
  size : word;
begin

  p:=Memo4.CaretPos;
  b:=False;
  for k := 0 to Memo4.Lines.Count-1 do begin
    temp:=Memo4.Lines[k];
    for i := 1 to Length(temp) do
      if not(temp[i] in ['0'..'9','a'..'f','A'..'F',' ']) then begin
        temp[i]:=' ';
        b:=True;
      end;
    if b then Memo4.Lines[k]:=temp;
  end;
  Memo4.CaretPos:=p;
  PktStr := Memo4.Text;
  if PktStr = '' then exit;
  size := length(HexToString(PktStr))+2;
  if size = 2 then exit;
  if ToServer.Down then
    PktStr:='0400000000000000000000'+PktStr
    else
    PktStr:='0300000000000000000000'+PktStr;
  PacketView.ParsePacket('', PktStr, size);  
end;

procedure TfPacketViewer.ToClientClick(Sender: TObject);
begin
ToClient.Down := true;
ToServer.Down := false;
Memo4Change(nil);
end;

procedure TfPacketViewer.ToServerClick(Sender: TObject);
begin
ToServer.Down := true;
ToClient.Down := false;
Memo4Change(nil);
end;

end.

