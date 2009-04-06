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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fProcesses: TfProcesses;

implementation
uses uglobalfuncs;

{$R *.dfm}

procedure TfProcesses.FormCreate(Sender: TObject);
begin
  loadpos(self);
end;

procedure TfProcesses.FormDestroy(Sender: TObject);
begin
  savepos(self);
end;

end.
