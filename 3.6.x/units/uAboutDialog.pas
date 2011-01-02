unit uAboutDialog;

interface

uses
  Shellapi, windows, Controls, Forms,
  StdCtrls, ExtCtrls, siComp, Graphics, Classes;

type
  TfAbout = class(TForm)
    Image1: TImage;
    lang: TsiLang;
    Label2: TLabel;
    Label3: TLabel;
    AboutMemo: TMemo;
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAbout: TfAbout;

implementation
uses umain;

{$R *.dfm}

procedure TfAbout.Label2Click(Sender: TObject);
begin
  ShellExecute(handle, 'open', 'http://allcheats.ru/forum.php', nil, nil, SW_SHOW);
end;

procedure TfAbout.Label3Click(Sender: TObject);
begin
  ShellExecute(handle, 'open', 'http://l2phx.pp.ru/', nil, nil, SW_SHOW);
end;

procedure TfAbout.FormDeactivate(Sender: TObject);
begin
  SetWindowPos(handle,HWND_TOP,0,0,0,0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;

end.
