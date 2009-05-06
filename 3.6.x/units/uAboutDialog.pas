unit uAboutDialog;

interface

uses
  Shellapi, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, siComp;

type
  TfAbout = class(TForm)
    Image1: TImage;
    lang: TsiLang;
    Label2: TLabel;
    Label3: TLabel;
    AboutMemo: TMemo;
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
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

end.
