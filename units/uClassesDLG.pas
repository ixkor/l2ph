unit uClassesDLG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, fs_tree;

type
  TfClassesDLG = class(TForm)
    fsTree1: TfsTree;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure CreateParams(var Params : TCreateParams); override;
  public

    { Public declarations }
  end;

var
  fClassesDLG: TfClassesDLG;

implementation
uses uglobalfuncs;

{$R *.dfm}

procedure TfClassesDLG.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle OR WS_EX_APPWINDOW;
end;

procedure TfClassesDLG.FormCreate(Sender: TObject);
begin
loadpos(Self);
end;

procedure TfClassesDLG.FormDestroy(Sender: TObject);
begin
savepos(Self);
end;

end.

