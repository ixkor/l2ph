unit uProcesses;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, siComp;

type
  TfProcesses = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    FoundProcesses: TListBox;
    FoundClients: TListBox;
    lang: TsiLang;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  protected
    procedure CreateParams (var Params : TCreateParams); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fProcesses: TfProcesses;

implementation
uses umain, uglobalfuncs;

{$R *.dfm}

procedure TfProcesses.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    ExStyle := ExStyle OR WS_EX_APPWINDOW or WS_EX_CONTROLPARENT;

end;

procedure TfProcesses.FormCreate(Sender: TObject);
begin
  loadpos(self);
end;

procedure TfProcesses.FormDestroy(Sender: TObject);
begin
  savepos(self);
end;

end.
