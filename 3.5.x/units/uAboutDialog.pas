unit uAboutDialog;

interface

uses
  Shellapi, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, siComp;

type
  TfAbout = class(TForm)
    Memo1: TMemo;
    Image1: TImage;
    Label1: TLabel;
    lang: TsiLang;
    procedure Label1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAbout: TfAbout;

implementation

{$R *.dfm}

procedure TfAbout.Label1Click(Sender: TObject);
begin
  ShellExecute(handle, 'open', 'http://coderx.ru', nil, nil, SW_SHOW);
end;

end.
