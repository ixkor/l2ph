unit uLangSelectDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, siLangCombo, siComp;

type
  TfLangSelectDialog = class(TForm)
    siLangCombo1: TsiLangCombo;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fLangSelectDialog: TfLangSelectDialog;

implementation
uses uGlobalFuncs, umain;
{$R *.dfm}

procedure TfLangSelectDialog.Button1Click(Sender: TObject);
begin
close;
if siLangCombo1.ItemIndex = -1 then exit;
fMain.siLangDispatcher.Language := siLangCombo1.Items.Strings[siLangCombo1.ItemIndex];
Options.WriteInteger('General', 'language', fLangSelectDialog.siLangCombo1.ItemIndex);
Options.UpdateFile;
end;

procedure TfLangSelectDialog.Button2Click(Sender: TObject);
begin
close;
end;

end.
