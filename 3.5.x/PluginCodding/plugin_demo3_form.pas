unit plugin_demo3_form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TMyForm = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MyForm: TMyForm;

implementation

{$R *.dfm}

procedure TMyForm.FormCreate(Sender: TObject);
begin
Align := alClient;
end;

procedure TMyForm.Button1Click(Sender: TObject);
begin
Button1.Caption := Button1.Caption + ')';
end;

end.
