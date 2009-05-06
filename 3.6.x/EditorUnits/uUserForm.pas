unit uUserForm;

interface

uses
  Windows, Classes, Controls, Forms, Dialogs, ExtCtrls;

type
  TUserForm = class(TForm)
  private
    { Private declarations }
  protected
    procedure CreateParams(var Params : TCreateParams); override;
  public
    { Public declarations }
  end;

var
  UserForm: TUserForm;

implementation

{$R *.dfm}

{ TfUserForm }

procedure TUserForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle OR WS_EX_APPWINDOW;
end;

end.
